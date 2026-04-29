/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "kernel_utils.hpp"
#include "davinci_kernel_task.h"
#include "kernel.hpp"
#include "para_convertor.hpp"
#include "capture_model.hpp"
#include "arg_loader.hpp"
#include "error_message_manage.hpp"
#include "task/task_info.hpp"

namespace cce {
namespace runtime {
void ComputeRatio(uint16_t ratio[2], uint32_t mixType, uint32_t taskRatio) 
{
    ratio[0] = 0U;
    ratio[1] = 0U;
    switch (mixType) {
        case NO_MIX:
            break;
        case MIX_AIC:
            ratio[0] = 1U;
            ratio[1] = 0U;
            break;
        case MIX_AIV:
            ratio[0] = 0U;
            ratio[1] = 1U;
            break;
        case MIX_AIC_AIV_MAIN_AIC:
            if (taskRatio == 1U) {
                ratio[0] = 1U;
                ratio[1] = 1U;
            } else if (taskRatio == 2U) {
                ratio[0] = 1U;
                ratio[1] = 2U;
            } else {
                RT_LOG(RT_LOG_WARNING, "Unsupported mixType=%u, taskRatio=%u", mixType, taskRatio);
            }
            break;
        case MIX_AIC_AIV_MAIN_AIV:
            if (taskRatio == 1U) {
                ratio[0] = 1U;
                ratio[1] = 1U;
            } else if (taskRatio == 2U) {
                ratio[0] = 2U;
                ratio[1] = 1U;
            } else {
                RT_LOG(RT_LOG_WARNING, "Unsupported mixType=%u, taskRatio=%u", mixType, taskRatio);
            }
            break;
        default:
            RT_LOG(RT_LOG_WARNING, "Unsupported mixType=%u, taskRatio=%u", mixType, taskRatio);
            break;
    }
}

rtError_t ConvertTaskType(const TaskInfo * const task, rtTaskType *type)
{
    if (task->stream == nullptr) {
        RT_LOG(RT_LOG_ERROR, "The stream associated with the task does not exist, taskId=%u.", task->id);
        return RT_ERROR_INVALID_VALUE;
    }

    rtTaskType taskType = rtTaskType::RT_TASK_DEFAULT;
    if (task->taskOwner == static_cast<uint8_t>(TaskOwner::RT_TASK_INNER)) {
        *type = taskType;
        RT_LOG(RT_LOG_INFO, "end to get task type, streamId=%d, taskId=%u, alloc taskType=%d, taskName=%s, taskOwner=%d, convert to rtTaskType=%d.",
            task->stream->Id_(), task->id, task->type, task->typeName, static_cast<int32_t>(task->taskOwner), *type);
        return RT_ERROR_NONE;
    }

    switch(task->type) {
        case TS_TASK_TYPE_KERNEL_AICORE: 
        case TS_TASK_TYPE_KERNEL_AIVEC:
            taskType = RT_TASK_KERNEL;
            break;
        case TS_TASK_TYPE_CAPTURE_WAIT:
        case TS_TASK_TYPE_STREAM_WAIT_EVENT:
            taskType = RT_TASK_EVENT_WAIT;
            break;
        case TS_TASK_TYPE_MEM_WAIT_VALUE: 
            taskType = RT_TASK_VALUE_WAIT;
            break;
        case TS_TASK_TYPE_EVENT_RECORD:
        case TS_TASK_TYPE_CAPTURE_RECORD:
            taskType = RT_TASK_EVENT_RECORD;
            break;
        case TS_TASK_TYPE_EVENT_RESET:
            taskType = RT_TASK_EVENT_RESET;
            break;
        case TS_TASK_TYPE_MEM_WRITE_VALUE:
            taskType = strcmp(task->typeName, "EVENT_RESET") != 0 ? RT_TASK_VALUE_WRITE : RT_TASK_EVENT_RESET;
            break;
        default:
            break;
    }
    *type = taskType;
    RT_LOG(RT_LOG_INFO, "end to get task type, streamId=%d, taskId=%u, alloc taskType=%d, taskName=%s, convert to rtTaskType=%d.",
        task->stream->Id_(), task->id, task->type, task->typeName, taskType);
    return RT_ERROR_NONE;
}

rtError_t GetKernelTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    const AicTaskInfo* aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    rtKernelTaskParams* kernelTaskParams = &(params->kernelTaskParams);
    kernelTaskParams->funcHandle = aicTaskInfo->kernel;
    kernelTaskParams->cfg = nullptr;
    kernelTaskParams->args = aicTaskInfo->comm.args;
    kernelTaskParams->isHostArgs = 0U;
    kernelTaskParams->argsSize = aicTaskInfo->comm.argsSize;
    kernelTaskParams->numBlocks = aicTaskInfo->comm.dim;

    Stream* stm = taskInfo->stream;
    Model* mdl = stm->Model_();
    NULL_PTR_RETURN(mdl, RT_ERROR_MODEL_NULL);
    COND_RETURN_AND_MSG_OUTER(mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL, RT_ERROR_FEATURE_NOT_SUPPORT, 
        ErrorCode::EE1006, __func__, "non aclGraph mode");
    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(mdl);
    const TaskGroup* taskGroup = captureModel->GetTaskGroup(stm->Id_(), taskInfo->id);
    params->taskGrp = static_cast<void*>(RtPtrToUnConstPtr<TaskGroup*>(taskGroup));
    size_t infoSize = 0;
    params->opInfoPtr = captureModel->GetShapeInfo(stm->Id_(), GetTaskId(taskInfo), infoSize);
    params->opInfoSize = infoSize;

    RT_LOG(
        RT_LOG_INFO,
        "stream_id=%d, task_id=%hu, typeName=%s, task type=%d, funcHandle=%p, args=%p, argsSize=%zu, blockDim=%u, "
        "opInfoPtr=%p, opInfoSize=%zu",
        stm->Id_(), taskInfo->id, taskInfo->typeName, taskInfo->type, kernelTaskParams->funcHandle,
        kernelTaskParams->args, kernelTaskParams->argsSize, kernelTaskParams->numBlocks, params->opInfoPtr,
        params->opInfoSize);
    return RT_ERROR_NONE;
}

static rtError_t UpdateKernelTaskInfoWithArgsAndCfg(
    TaskInfo* const taskInfo, Kernel* kernel, const rtArgsEx_t* argsInfo, const TaskCfg* taskCfg, uint32_t blockDim)
{
    Stream* stm = taskInfo->stream;
    Device* dev = stm->Device_();
    TaskUnInitProc(taskInfo);
    uint8_t mixType = NO_MIX;
    uint32_t prefetchCnt1 = 0U;
    uint32_t prefetchCnt2 = 0U;
    Program* prog = kernel->Program_();
    rtError_t error = GetPrefetchCntAndMixTypeWithKernel(kernel, prefetchCnt1, prefetchCnt2, mixType);
    ERROR_RETURN(
        error, "failed to get prefetch cnt, retCode=%#x, device_id=%u, stream_id=%d, task_id=%hu.", error, dev->Id_(),
        stm->Id_(), taskInfo->id);
    rtKernelAttrType kernelAttrType = kernel->GetKernelAttrType();
    ArgLoaderResult result = {};
    error = dev->ArgLoader_()->Load(argsInfo, stm, &result);
    ERROR_RETURN(
        error, "failed to load args, retCode=%#x, device_id=%u, stream_id=%d, task_id=%hu.", error, dev->Id_(),
        stm->Id_(), taskInfo->id);

    bool isNeedAllocSqeDevBuf = false;
    AicTaskInit(taskInfo, kernelAttrType, static_cast<uint16_t>(blockDim), 0, taskCfg, isNeedAllocSqeDevBuf);
    AicTaskInfo* aicTask = &(taskInfo->u.aicTaskInfo);
    aicTask->kernel = kernel;
    aicTask->progHandle = prog;

    uint64_t kernelPc1 = 0ULL;
    uint64_t kernelPc2 = 0ULL;
    error = kernel->GetFunctionDevAddr(kernelPc1, kernelPc2);
    ERROR_RETURN(error, "get function address failed.");
    aicTask->funcAddr = kernelPc1;
    aicTask->funcAddr1 = kernelPc2;
    kernel->SetPrefetchCnt1_(prefetchCnt1);
    kernel->SetPrefetchCnt2_(prefetchCnt2);

    if (result.handle != nullptr) {
        SetAicoreArgs(taskInfo, result.kerArgs, argsInfo->argsSize, result.handle);
        result.handle = nullptr;
    }

    RT_LOG(
        RT_LOG_INFO,
        "device_id=%u, stream_id=%d, task_id=%hu, kernelAttrType=%d, kernel_name=%s, arg_size=%u, "
        "blockDim=%u, taskRation=%u, funcType=%u, addr1=0x%llx, addr2=0x%llx, "
        "mixType=%u, kernelFlag=0x%x, qos=%u, partId=%u, schemMode=%u, infoAddr=%p, atomicIndex=%lu.",
        dev->Id_(), stm->Id_(), taskInfo->id, kernelAttrType, kernel->Name_().c_str(), argsInfo->argsSize, blockDim,
        kernel->GetTaskRation(), kernel->GetFuncType(), kernelPc1, kernelPc2, mixType, aicTask->comm.kernelFlag,
        aicTask->qos, aicTask->partId, aicTask->schemMode, aicTask->inputArgsSize.infoAddr,
        aicTask->inputArgsSize.atomicIndex);

    return RT_ERROR_NONE;
}

rtError_t UpdateKernelParams(TaskInfo* const taskInfo, rtTaskParams* const params)
{
    COND_RETURN_AND_MSG_OUTER(
        (taskInfo->type != TS_TASK_TYPE_KERNEL_AICORE && taskInfo->type != TS_TASK_TYPE_KERNEL_AIVEC),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1001, "now only support update kernel to kernel");
    COND_RETURN_AND_MSG_OUTER((params->taskGrp != nullptr),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1001, "taskGrp must be nullptr");

    const rtKernelTaskParams* kernelTaskParams = &(params->kernelTaskParams);
    Kernel* const kernel = RtPtrToPtr<Kernel*>(kernelTaskParams->funcHandle);
    COND_RETURN_AND_MSG_OUTER((kernel == nullptr),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1001, "funcHandle cannot be nullptr");
    COND_RETURN_AND_MSG_OUTER((kernelTaskParams->args == nullptr),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1001, "args cannot be nullptr");
    COND_RETURN_AND_MSG_OUTER((kernelTaskParams->argsSize == 0U),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1001, "argsSize cannot be 0");

    TaskCfg taskCfg = {};
    rtError_t error = ConvertLaunchCfgToTaskCfg(taskCfg, kernelTaskParams->cfg);
    ERROR_RETURN(error, "convert task cfg failed, retCode=%#x.", error);

    rtArgsEx_t argsInfo = {};
    argsInfo.args = kernelTaskParams->args;
    argsInfo.argsSize = kernelTaskParams->argsSize;
    argsInfo.isNoNeedH2DCopy = (kernelTaskParams->isHostArgs == 0U) ? 1U : 0U;
    error = UpdateKernelTaskInfoWithArgsAndCfg(taskInfo, kernel, &argsInfo, &taskCfg, kernelTaskParams->numBlocks);
    ERROR_RETURN(error, "update task info failed, retCode=%#x.", error);
    error = WaitAsyncCopyComplete(taskInfo);
    ERROR_RETURN(error, "WaitAsyncCopyComplete Failed");

    Stream* stm = taskInfo->stream;
    Model* mdl = stm->Model_();
    NULL_PTR_RETURN(mdl, RT_ERROR_MODEL_NULL);
    COND_RETURN_AND_MSG_OUTER(mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL, RT_ERROR_FEATURE_NOT_SUPPORT, 
        ErrorCode::EE1006, __func__, "non aclGraph mode");
    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(mdl);

    if (params->opInfoPtr != nullptr && params->opInfoSize != 0) {
        taskInfo->taskTrackTimeStamp = MsprofSysCycleTime();
        error = captureModel->SetShapeInfo(stm, GetTaskId(taskInfo), params->opInfoPtr, params->opInfoSize);
        ERROR_RETURN(error, "update shape info failed, stream_id=%d, task_id=%u.", stm->Id_(), GetTaskId(taskInfo));
    } else {
        captureModel->ClearShapeInfo(stm->Id_(), GetTaskId(taskInfo));
    }

    return RT_ERROR_NONE;
}

//              API     TaskInfo    返回情况
// 永不超时       0        全F          0
// 默认超时     不配置      0         实际超时
// 其他超时     其他值    其他值       实际超时
static rtError_t ConvertTimeoutByAttrId(uint64_t timeout, rtLaunchKernelAttrId attrId,
    rtLaunchKernelAttrVal_t *attrValue)
{
    uint64_t realTimeout;  // us
    RT_LOG(RT_LOG_INFO, "timeout(us) in config=%llu", timeout);
    if (timeout == MAX_UINT64_NUM) {
        realTimeout = 0ULL;
    } else {
        uint32_t opTimeout = 0U;
        rtError_t error = GetOpExecuteMsTimeout(&opTimeout, &timeout);
        ERROR_RETURN(error, "cannot get system timeout");
        // 0: 用户未配置, 默认超时； 非0: 当前实际超时
        realTimeout = (timeout == 0ULL) ? static_cast<uint64_t>(opTimeout) * RT_TIMEOUT_MS_TO_US : timeout;
    }

    if (attrId == RT_LAUNCH_KERNEL_ATTR_TIMEOUT) {
        attrValue->timeout = static_cast<uint16_t>(realTimeout / RT_TIMEOUT_S_TO_US);
    } else {
        constexpr uint8_t timeOffset = 32U;
        attrValue->timeoutUs.timeoutLow = static_cast<uint32_t>(realTimeout);
        attrValue->timeoutUs.timeoutHigh = static_cast<uint32_t>(realTimeout >> timeOffset);
    }
    RT_LOG(RT_LOG_INFO, "the real timeout(us)=%llu", realTimeout);
    return RT_ERROR_NONE;
}

rtError_t GetKernelAttribute(const TaskInfo* const taskInfo, rtLaunchKernelAttrId attrId,
    rtLaunchKernelAttrVal_t *attrValue)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        ((taskInfo->type != TS_TASK_TYPE_KERNEL_AICORE) && (taskInfo->type != TS_TASK_TYPE_KERNEL_AIVEC)),
        RT_ERROR_INVALID_VALUE, taskInfo->type,
        std::to_string(TS_TASK_TYPE_KERNEL_AICORE) + " or " + std::to_string(TS_TASK_TYPE_KERNEL_AIVEC));

    RT_LOG(RT_LOG_INFO, "get kernel attrId=%d", attrId);
    const AicTaskInfo* aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    rtError_t ret = RT_ERROR_NONE;
    switch (attrId) {
        case RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE:
            // RT_SCHEM_MODE_END表示未通过API配置此属性
            if (aicTaskInfo->schemMode == RT_SCHEM_MODE_END) {
                // kernel为空则返回默认Mode(0)
                attrValue->schemMode = (aicTaskInfo->kernel == nullptr) ? 0U : aicTaskInfo->kernel->GetSchedMode();
            } else {
                attrValue->schemMode = aicTaskInfo->schemMode;
            }
            RT_LOG(RT_LOG_INFO, "config schemMode=%u, current schemMode=%u",
                aicTaskInfo->schemMode, attrValue->schemMode);
            break;
        case RT_LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE:
            attrValue->dynUBufSize = aicTaskInfo->dynamicShareMemSize;
            break;
        case RT_LAUNCH_KERNEL_ATTR_DATA_DUMP:
            // 设置的时候，在taskcfg里面将1(enable)转成了RT_KERNEL_DUMPFLAG，0(disable)转成了RT_KERNEL_DEFAULT
            attrValue->isDataDump = ((aicTaskInfo->comm.kernelFlag & RT_KERNEL_DUMPFLAG) != 0U) ? 1U : 0U;
            break;
        case RT_LAUNCH_KERNEL_ATTR_TIMEOUT:
        case RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US:
            ret = ConvertTimeoutByAttrId(aicTaskInfo->timeout, attrId, attrValue);
            break;
        case RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE:
        case RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET:
        case RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH:
            RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1003, attrId, "attrId",
                "not equal (" + std::to_string(RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE) + ", " +
                std::to_string(RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET) + ", " +
                std::to_string(RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH) + ")");
            ret = RT_ERROR_INVALID_VALUE;
            break;
        default:
            RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1003, attrId, "attrId",
                "[ " + std::to_string(RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE) + ", " +
                std::to_string(RT_LAUNCH_KERNEL_ATTR_MAX) + ")");
            ret = RT_ERROR_INVALID_VALUE;
            break;
    }
    return ret;
}

rtError_t GetOpExecuteMsTimeout(uint32_t *const timeout, uint64_t *customTimeout)
{
    *timeout = 0U;
    float64_t timeoutUs = 0.0F;
    Runtime *const rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);

    const RtTimeoutConfig &timeoutCfg = rtInstance->GetTimeoutConfig();
    const float64_t kernelCreditScaleUS = rtInstance->GetKernelCreditScaleUS();
    const uint32_t defaultKernelCredit = rtInstance->GetDefaultKernelCredit();
    const float64_t maxKernelCredit = static_cast<float64_t>(rtInstance->GetMaxKernelCredit());

    // Get different ChipType of kernel credit scale and default kernel credit.
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (defaultKernelCredit == 0U || (kernelCreditScaleUS < std::numeric_limits<double>::epsilon())) {
        RT_LOG(RT_LOG_WARNING, "Unsupported chip type, chipType=%d.", chipType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    if ((customTimeout != nullptr) && (*customTimeout != 0)) {
        timeoutUs = kernelCreditScaleUS * static_cast<float64_t>(maxKernelCredit);
        uint64_t maxTimeout = static_cast<uint64_t>(ceil(timeoutUs));
        // 实际时间 = min(用户配置, 系统最大值)
        *customTimeout = (*customTimeout > maxTimeout) ? maxTimeout : *customTimeout;
        return RT_ERROR_NONE;
    }

    // Calculate timeout based on different conditions.
    if (timeoutCfg.isCfgOpExcTaskTimeout) {
        const float64_t timeoutTmpUs = static_cast<float64_t>(timeoutCfg.opExcTaskTimeout);
        if ((timeoutCfg.opExcTaskTimeout == 0U) || (timeoutTmpUs > kernelCreditScaleUS * maxKernelCredit)) {
            // If timeout is 0 or timeouttmp > the maximum timeout period, it is considered as the maximum timeout
            // period.​
            timeoutUs = kernelCreditScaleUS * maxKernelCredit;
        } else {
            // Round up to get the hardware effective time.
            const uint64_t kernelCreditTmp = static_cast<uint64_t>((timeoutTmpUs + kernelCreditScaleUS - 1) / kernelCreditScaleUS);
            timeoutUs = kernelCreditScaleUS * static_cast<float64_t>(kernelCreditTmp);
        }
    } else {
        // ​​If timeout is not set, use AIC default timeout.​
        timeoutUs = kernelCreditScaleUS * static_cast<float64_t>(defaultKernelCredit);
    }

    if ((timeoutCfg.isOpTimeoutMs) && (timeoutCfg.isCfgOpExcTaskTimeout) &&
        (timeoutCfg.opExcTaskTimeout == 0UL)) {
        *timeout = UINT32_MAX; // never timeout
    } else {
        *timeout = static_cast<uint32_t>(ceil(timeoutUs / static_cast<float64_t>(RT_TIMEOUT_MS_TO_US)));
    }
    RT_LOG(RT_LOG_INFO, "get OP execute timeout=%u ms.", *timeout);
    return RT_ERROR_NONE;
}
}
}