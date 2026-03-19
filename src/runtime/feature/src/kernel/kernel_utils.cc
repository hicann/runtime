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
#include "kernel.hpp"
#include "para_convertor.hpp"
#include "capture_model.hpp"
#include "arg_loader.hpp"
#include "error_message_manage.hpp"

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
    COND_RETURN_ERROR(
        mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL, RT_ERROR_INVALID_VALUE, "now only support aclGraph");
    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(mdl);
    const TaskGroup* taskGroup = captureModel->GetTaskGroup(stm->Id_(), taskInfo->id);
    params->taskGrp = static_cast<void*>(RtPtrToUnConstPtr<TaskGroup*>(taskGroup));
    size_t infoSize = 0;
    params->opInfoPtr = captureModel->GetShapeInfo(stm->Id_(), taskInfo->id, infoSize);
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
    rtError_t error = GetPrefetchCntAndMixTypeWithKernel(kernel, prog->Machine(), prefetchCnt1, prefetchCnt2, mixType);
    ERROR_RETURN(
        error, "failed to get prefetch cnt, retCode=%#x, device_id=%u, stream_id=%d, task_id=%hu.", error, dev->Id_(),
        stm->Id_(), taskInfo->id);
    uint32_t kernelType = kernel->KernelType_();
    ArgLoaderResult result = {};
    error = dev->ArgLoader_()->Load(kernelType, argsInfo, stm, &result);
    ERROR_RETURN(
        error, "failed to load args, retCode=%#x, device_id=%u, stream_id=%d, task_id=%hu.", error, dev->Id_(),
        stm->Id_(), taskInfo->id);

    bool isNeedAllocSqeDevBuf = false;
    AicTaskInit(taskInfo, kernelType, static_cast<uint16_t>(blockDim), 0, taskCfg, isNeedAllocSqeDevBuf);
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
        "device_id=%u, stream_id=%d, task_id=%hu, kernelType=%u, kernel_name=%s, arg_size=%u, "
        "blockDim=%u, taskRation=%u, funcType=%u, addr1=0x%llx, addr2=0x%llx, "
        "mixType=%u, kernelFlag=0x%x, qos=%u, partId=%u, schemMode=%u, infoAddr=%p, atomicIndex=%lu.",
        dev->Id_(), stm->Id_(), taskInfo->id, kernelType, kernel->Name_().c_str(), argsInfo->argsSize, blockDim,
        kernel->GetTaskRation(), kernel->GetFuncType(), kernelPc1, kernelPc2, mixType, aicTask->comm.kernelFlag,
        aicTask->qos, aicTask->partId, aicTask->schemMode, aicTask->inputArgsSize.infoAddr,
        aicTask->inputArgsSize.atomicIndex);

    return RT_ERROR_NONE;
}

rtError_t UpdateKernelParams(TaskInfo* const taskInfo, rtTaskParams* const params)
{
    COND_RETURN_AND_MSG_OUTER(
        (taskInfo->type != TS_TASK_TYPE_KERNEL_AICORE && taskInfo->type != TS_TASK_TYPE_KERNEL_AIVEC),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1001, __func__, "now only support update kernel to kernel.");
    COND_RETURN_AND_MSG_OUTER((params->taskGrp != nullptr),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1001, __func__, "taskGrp must be nullptr.");

    const rtKernelTaskParams* kernelTaskParams = &(params->kernelTaskParams);
    Kernel* const kernel = RtPtrToPtr<Kernel*>(kernelTaskParams->funcHandle);
    NULL_PTR_RETURN_MSG_OUTER(kernel, RT_ERROR_INVALID_VALUE);
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
    COND_RETURN_ERROR(
        mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL, RT_ERROR_INVALID_VALUE, "now only support aclGraph");
    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(mdl);

    if (params->opInfoPtr != nullptr && params->opInfoSize != 0) {
        error = captureModel->SetShapeInfo(stm, taskInfo->id, params->opInfoPtr, params->opInfoSize);
        ERROR_RETURN(error, "update shape info failed, stream_id=%d, task_id=%u.", stm->Id_(), taskInfo->id);
    } else {
        captureModel->ClearShapeInfo(stm->Id_(), taskInfo->id);
    }

    return RT_ERROR_NONE;
}

}
}