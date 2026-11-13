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
#include <securec.h>
#include <new>
#include "davinci_kernel_task.h"
#include "kernel.hpp"
#include "para_convertor.hpp"
#include "capture_model.hpp"
#include "arg_loader.hpp"
#include "stars_arg_manager.hpp"
#include "error_message_manage.hpp"
#include "task/task_info.hpp"
#include "stream_david.hpp"
#include "enum_desc.hpp"
#include "task_enum_desc.hpp"
#include "capture_model_utils.hpp"
#include "aix_c.hpp"

namespace cce {
namespace runtime {
rtError_t GetLaunchBlockDim(const uint32_t blockDim, uint16_t& launchBlockDim)
{
    if (blockDim > (UINT16_MAX / 2U)) {
        RT_LOG_OUTER_MSG_INVALID_PARAM_WITH_DESC("Starting the compute task", blockDim, "[1, 32767]");
        return RT_ERROR_INVALID_VALUE;
    }
    launchBlockDim = static_cast<uint16_t>(blockDim * 2U);
    return RT_ERROR_NONE;
}

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

static rtTaskType ConvertMemcpyTaskType(const uint8_t copyMethod)
{
    rtTaskType taskType = RT_TASK_DEFAULT;
    switch (static_cast<rtAsyncCpyMethod>(copyMethod)) {
        case rtAsyncCpyMethod::RT_ASYNC_CPY:
            taskType = RT_TASK_MEMCPY;
            break;
        case rtAsyncCpyMethod::RT_ASYNC_CPY_2D:
            taskType = RT_TASK_MEMCPY_2D;
            break;
        case rtAsyncCpyMethod::RT_ASYNC_CPY_BATCH:
            taskType = RT_TASK_MEMCPY_BATCH;
            break;
        default:
            break;
    }
    return taskType;
}

rtError_t ConvertTaskType(const TaskInfo* const task, rtTaskType* type)
{
    COND_RETURN_ERROR(
        (task->stream == nullptr), RT_ERROR_INVALID_VALUE,
        "The stream associated with the task does not exist, taskId=%u.", task->id);

    rtTaskType taskType = rtTaskType::RT_TASK_DEFAULT;
    if (task->taskOwner == static_cast<uint8_t>(TaskOwner::RT_TASK_INNER)) {
        *type = taskType;
        RT_LOG(
            RT_LOG_INFO,
            "end to get task type, streamId=%d, taskId=%u, alloc taskType=%d, taskName=%s, taskOwner=%d, convert to "
            "rtTaskType=%s.",
            task->stream->Id_(), task->id, task->type, task->typeName, static_cast<int32_t>(task->taskOwner),
            TaskTypeToString(*type).c_str());
        return RT_ERROR_NONE;
    }

    switch (task->type) {
        case TS_TASK_TYPE_KERNEL_AICORE:
        case TS_TASK_TYPE_KERNEL_AIVEC:
            taskType = IsPureSimtTask(task->u.aicTaskInfo) ? RT_TASK_SIMT_KERNEL : RT_TASK_KERNEL;
            break;
        case TS_TASK_TYPE_CAPTURE_WAIT:
        case TS_TASK_TYPE_STREAM_WAIT_EVENT:
        case TS_TASK_TYPE_DAVID_EVENT_WAIT:
            taskType = RT_TASK_EVENT_WAIT;
            break;
        case TS_TASK_TYPE_MEM_WAIT_VALUE:
            taskType = RT_TASK_VALUE_WAIT;
            break;
        case TS_TASK_TYPE_EVENT_RECORD:
        case TS_TASK_TYPE_CAPTURE_RECORD:
        case TS_TASK_TYPE_DAVID_EVENT_RECORD:
        case TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL:
            taskType = RT_TASK_EVENT_RECORD;
            break;
        case TS_TASK_TYPE_EVENT_RESET:
        case TS_TASK_TYPE_DAVID_EVENT_RESET:
            taskType = RT_TASK_EVENT_RESET;
            break;
        case TS_TASK_TYPE_MEM_WRITE_VALUE:
            taskType = strcmp(task->typeName, "EVENT_RESET") != 0 ? RT_TASK_VALUE_WRITE : RT_TASK_EVENT_RESET;
            break;
        case TS_TASK_TYPE_MEMCPY:
            taskType = ConvertMemcpyTaskType(task->u.memcpyAsyncTaskInfo.copyMethod);
            break;
        case TS_TASK_TYPE_MEMSET:
            taskType = RT_TASK_MEMSET;
            break;
        case TS_TASK_TYPE_HOSTFUNC_CALLBACK:
            taskType = RT_TASK_HOST;
            break;
        case TS_TASK_TYPE_CAPTURE_CONDITION:
            taskType = RT_TASK_COND;
            break;
        case TS_TASK_TYPE_NOTIFY_RECORD:
            if ((!task->u.notifyrecordTask.isCountNotify) && (task->typeName != nullptr) &&
                (strcmp(task->typeName, "NOTIFY_RECORD") == 0)) {
                taskType = RT_TASK_NOTIFY_RECORD;
            }
            break;
        case TS_TASK_TYPE_NOTIFY_WAIT:
            if (!task->u.notifywaitTask.isCountNotify) {
                taskType = RT_TASK_NOTIFY_WAIT;
            }
            break;
        default:
            break;
    }
    *type = taskType;
    RT_LOG(
        RT_LOG_INFO,
        "end to get task type, streamId=%d, taskId=%u, alloc taskType=%d, taskName=%s, convert to rtTaskType=%s.",
        task->stream->Id_(), task->id, task->type, task->typeName, TaskTypeToString(taskType).c_str());
    return RT_ERROR_NONE;
}

static rtError_t AppendKernelTaskCommonParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    Stream* stm = taskInfo->stream;
    Model* mdl = stm->Model_();
    COND_RETURN_AND_MSG_OUTER(
        mdl == nullptr, RT_ERROR_MODEL_NULL, ErrorCode::EE1017, "Obtaining kernel task parameters", "task",
        RtFmtMsg("The stream (stream_id=%d) to which the task belongs is not bound to a model", stm->Id_()));
    COND_RETURN_AND_MSG_OUTER(
        mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL, RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1016,
        "Obtaining kernel task parameters", "Non ACL Graph mode is not supported");
    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(mdl);
    const TaskGroup* taskGroup = captureModel->GetTaskGroup(stm->Id_(), taskInfo->id);
    params->taskGrp = static_cast<void*>(RtPtrToUnConstPtr<TaskGroup*>(taskGroup));
    size_t infoSize = 0;
    params->opInfoPtr = captureModel->GetShapeInfo(stm->Id_(), GetTaskId(taskInfo), infoSize);
    params->opInfoSize = infoSize;
    return RT_ERROR_NONE;
}

// map the cached args form onto the ABI struct; DEVICE_BUFFER is kernel-form only (compiled away for SIMT)
template <typename UpdateInfoT, typename TaskParamsT>
static void FillArgsFormFromCache(
    const UpdateInfoT& info, TaskParamsT* const out, size_t& logArgsSize, const void*& logArgsAddr)
{
    if (info.argsType == RT_KERNEL_ARGS_ARRAY) {
        out->argsType = RT_KERNEL_ARGS_ARRAY;
        out->argsArray = info.argsArray;
        logArgsAddr = info.argsArray;
        logArgsSize = static_cast<size_t>(info.kernel->GetParamTotalSize());
    } else if (info.argsType == RT_KERNEL_ARGS_HOST_BUFFER) {
        out->argsType = RT_KERNEL_ARGS_HOST_BUFFER;
        out->hostBuffer.hostArgs = info.hostBuffer.hostArgs;
        out->hostBuffer.hostArgsSize = info.hostBuffer.hostArgsSize;
        out->hostBuffer.placeHolderArray = info.hostBuffer.placeHolderArray;
        out->hostBuffer.placeHolderNum = info.hostBuffer.placeHolderNum;
        logArgsSize = info.hostBuffer.hostArgsSize;
        logArgsAddr = info.hostBuffer.hostArgs;
    } else if constexpr (std::is_same_v<UpdateInfoT, KernelTaskUpdateInfo>) {
        // DEVICE_BUFFER (Set/launch validate argsType, no other value can be cached)
        out->argsType = RT_KERNEL_ARGS_DEVICE_BUFFER;
        out->deviceBuffer.deviceArgs = info.deviceBuffer.deviceArgs;
        out->deviceBuffer.deviceArgsSize = info.deviceBuffer.deviceArgsSize;
        logArgsSize = info.deviceBuffer.deviceArgsSize;
        logArgsAddr = info.deviceBuffer.deviceArgs;
    }
}

rtError_t GetKernelTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    // reachable only via GetTaskParamsWithUpdate; a missing entry means no kernel was cached, report instead
    const TaskUpdateInfo* const updateInfo = taskInfo->updateInfo;
    COND_RETURN_AND_MSG_OUTER(
        (updateInfo == nullptr) || (updateInfo->latestParams.isValid != 1U), RT_ERROR_INVALID_VALUE, ErrorCode::EE1004,
        "Obtaining kernel task parameters", "the cached launch parameters of the task");

    params->type = RT_TASK_KERNEL;
    rtKernelTaskParams* const kernelTaskParams = &(params->kernelTaskParams);
    // merged cache: populated at launch (original form) and overwritten by Set (pending form)
    const KernelTaskUpdateInfo& kernelUpdateInfo = updateInfo->latestParams.u.kernelUpdateParams;
    kernelTaskParams->funcHandle = const_cast<void*>(kernelUpdateInfo.launchFunc);
    kernelTaskParams->cfg = nullptr;
    kernelTaskParams->numBlocks = kernelUpdateInfo.numBlocks;
    size_t logArgsSize = 0U;
    const void* logArgsAddr = nullptr;
    FillArgsFormFromCache(kernelUpdateInfo, kernelTaskParams, logArgsSize, logArgsAddr);
    // 兼容回填：旧三字段仍返回任务实际加载的参数地址（Device 内存），供旧调用方使用
    kernelTaskParams->args = taskInfo->u.aicTaskInfo.comm.args;
    kernelTaskParams->isHostArgs = 0U;
    kernelTaskParams->argsSize = static_cast<size_t>(taskInfo->u.aicTaskInfo.comm.argsSize);
    const rtError_t error = AppendKernelTaskCommonParams(taskInfo, params);
    RT_LOG(
        RT_LOG_INFO,
        "stream_id=%d, task_id=%hu, task_type=%d(%s), kernel_name=%s, funcHandle=%p, numBlocks=%u, argsType=%s, "
        "argsAddr=%p, argsSize=%zu, loadedArgsAddr=%p, loadedArgsSize=%zu, opInfoPtr=%p, opInfoSize=%zu.",
        taskInfo->stream->Id_(), taskInfo->id, taskInfo->type, taskInfo->typeName,
        kernelUpdateInfo.kernel->Name_().c_str(), kernelTaskParams->funcHandle, kernelTaskParams->numBlocks,
        KernelArgsTypeToString(kernelUpdateInfo.argsType).c_str(), logArgsAddr, logArgsSize, kernelTaskParams->args,
        kernelTaskParams->argsSize, params->opInfoPtr, params->opInfoSize);
    return error;
}

rtError_t GetSimtKernelTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    // reachable only via GetTaskParamsWithUpdate; a SIMT task is always cached at launch time
    const TaskUpdateInfo* const updateInfo = taskInfo->updateInfo;
    COND_RETURN_AND_MSG_OUTER(
        (updateInfo == nullptr) || (updateInfo->latestParams.isValid != 1U), RT_ERROR_INVALID_VALUE, ErrorCode::EE1004,
        "Obtaining kernel task parameters", "the cached launch parameters of the task");

    params->type = RT_TASK_SIMT_KERNEL;
    rtSimtKernelTaskParams* const simtTaskParams = &(params->simtKernelTaskParams);
    const SimtKernelTaskUpdateInfo& kernelUpdateInfo = updateInfo->latestParams.u.simtKernelUpdateParams;
    simtTaskParams->func = const_cast<void*>(kernelUpdateInfo.launchFunc);
    simtTaskParams->cfg = nullptr;
    simtTaskParams->gridDimX = kernelUpdateInfo.gridDim.x;
    simtTaskParams->gridDimY = kernelUpdateInfo.gridDim.y;
    simtTaskParams->gridDimZ = kernelUpdateInfo.gridDim.z;
    simtTaskParams->blockDimX = kernelUpdateInfo.blockDim.x;
    simtTaskParams->blockDimY = kernelUpdateInfo.blockDim.y;
    simtTaskParams->blockDimZ = kernelUpdateInfo.blockDim.z;
    simtTaskParams->dynUbufSize = kernelUpdateInfo.dynUbufSize;
    size_t logArgsSize = 0U;
    const void* logArgsAddr = nullptr;
    FillArgsFormFromCache(kernelUpdateInfo, simtTaskParams, logArgsSize, logArgsAddr);
    const rtError_t error = AppendKernelTaskCommonParams(taskInfo, params);
    RT_LOG(
        RT_LOG_INFO,
        "stream_id=%d, task_id=%hu, task_type=%d(%s), kernel_name=%s, func=%p, gridDim=[%u,%u,%u], "
        "blockDim=[%u,%u,%u], dynUbufSize=%zu, argsType=%s, argsAddr=%p, argsSize=%zu, opInfoPtr=%p, opInfoSize=%zu.",
        taskInfo->stream->Id_(), taskInfo->id, taskInfo->type, taskInfo->typeName,
        kernelUpdateInfo.kernel->Name_().c_str(), simtTaskParams->func, simtTaskParams->gridDimX,
        simtTaskParams->gridDimY, simtTaskParams->gridDimZ, simtTaskParams->blockDimX, simtTaskParams->blockDimY,
        simtTaskParams->blockDimZ, simtTaskParams->dynUbufSize,
        KernelArgsTypeToString(kernelUpdateInfo.argsType).c_str(), logArgsAddr, logArgsSize, params->opInfoPtr,
        params->opInfoSize);
    return error;
}

static rtError_t CheckCacheKernelTaskCommon(TaskInfo* const taskInfo, const rtTaskParams* const params)
{
    if ((taskInfo->type != TS_TASK_TYPE_KERNEL_AICORE) && (taskInfo->type != TS_TASK_TYPE_KERNEL_AIVEC)) {
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1017, "Updating kernel parameters", "task",
            "The input task must be a compute task on the Cube Core or Vector Core. Before calling "
            "aclmdlRITaskSetParams, "
            "use aclmdlRITaskGetType to obtain the task type and check whether the task type is correct");
        RT_LOG(
            RT_LOG_ERROR, "Invalid taskInfo type=%s(%d), expect 0(AI core) or 66(AI vector)",
            GetTaskDescByType(taskInfo->type), taskInfo->type);
        return RT_ERROR_INVALID_VALUE;
    }
    COND_RETURN_AND_MSG_OUTER(
        (params->taskGrp != nullptr), RT_ERROR_INVALID_VALUE, ErrorCode::EE1003, "rtModelTaskSetParams",
        params->taskGrp, "params->taskGrp", "NULL pointer");
    return RT_ERROR_NONE;
}

template <typename KernelUpdateInfoT>
void FreeKernelUpdateInfoBuffers(KernelUpdateInfoT& kernelUpdateInfo)
{
    switch (kernelUpdateInfo.argsType) {
        case RT_KERNEL_ARGS_ARRAY:
            // argsArray is the base of the single allocation holding the pointer array and the params
            RT_LOG(RT_LOG_DEBUG, "free cached args array block, argsArrayAddr=%p.", kernelUpdateInfo.argsArray);
            delete[] static_cast<uint8_t*>(static_cast<void*>(kernelUpdateInfo.argsArray));
            kernelUpdateInfo.argsArray = nullptr;
            break;
        case RT_KERNEL_ARGS_HOST_BUFFER:
            RT_LOG(
                RT_LOG_DEBUG, "free cached host args, hostArgsAddr=%p, hostArgsSize=%zu, placeHolderAddr=%p.",
                kernelUpdateInfo.hostBuffer.hostArgs, kernelUpdateInfo.hostBuffer.hostArgsSize,
                kernelUpdateInfo.hostBuffer.placeHolderArray);
            delete[] static_cast<uint8_t*>(kernelUpdateInfo.hostBuffer.hostArgs);
            kernelUpdateInfo.hostBuffer.hostArgs = nullptr;
            delete[] kernelUpdateInfo.hostBuffer.placeHolderArray;
            kernelUpdateInfo.hostBuffer.placeHolderArray = nullptr;
            break;
        case RT_KERNEL_ARGS_DEVICE_BUFFER: // user-owned pointer, nothing to free
            break;
        default:
            break;
    }
}

template void FreeKernelUpdateInfoBuffers<KernelTaskUpdateInfo>(KernelTaskUpdateInfo&);
template void FreeKernelUpdateInfoBuffers<SimtKernelTaskUpdateInfo>(SimtKernelTaskUpdateInfo&);

static void SetLatestKernelUpdateParams(TaskUpdateParams& latestParams, const KernelTaskUpdateInfo& kernelUpdateInfo)
{
    latestParams.u.kernelUpdateParams = kernelUpdateInfo;
}

static void SetLatestKernelUpdateParams(
    TaskUpdateParams& latestParams, const SimtKernelTaskUpdateInfo& kernelUpdateInfo)
{
    latestParams.u.simtKernelUpdateParams = kernelUpdateInfo;
}

template <typename KernelUpdateInfoT>
static rtError_t CommitKernelUpdateInfo(
    TaskInfo* const taskInfo, const rtTaskParams* const params, const rtTaskType latestType,
    KernelUpdateInfoT& kernelUpdateInfo)
{
    Stream* const stm = taskInfo->stream;
    CaptureModel* const captureModel = dynamic_cast<CaptureModel*>(stm->Model_());
    if ((params->opInfoPtr != nullptr) && (params->opInfoSize != 0U)) {
        taskInfo->taskTrackTimeStamp = MsprofSysCycleTime();
        rtError_t error = captureModel->SetShapeInfo(stm, GetTaskId(taskInfo), params->opInfoPtr, params->opInfoSize);
        if (error != RT_ERROR_NONE) {
            FreeKernelUpdateInfoBuffers(kernelUpdateInfo);
            ERROR_RETURN(error, "update shape info failed, stream_id=%d, task_id=%u.", stm->Id_(), GetTaskId(taskInfo));
        }
    } else {
        captureModel->ClearShapeInfo(stm->Id_(), GetTaskId(taskInfo));
    }

    TaskUpdateParams& latestParams = taskInfo->updateInfo->latestParams;
    SetLatestKernelUpdateParams(latestParams, kernelUpdateInfo);
    latestParams.type = latestType;
    return RT_ERROR_NONE;
}

static rtError_t CheckPlaceHolderOffsets(
    const rtPlaceHolderInfo_t* const placeHolderArray, const size_t placeHolderNum, const size_t hostArgsSize)
{
    for (size_t i = 0U; i < placeHolderNum; i++) {
        COND_RETURN_AND_MSG_OUTER(
            placeHolderArray[i].addrOffset >= hostArgsSize, RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
            "Setting task parameters", RtFmtMsg("placeHolderArray[%zu].addrOffset or hostArgsSize", i),
            RtFmtMsg(
                "Parameter placeHolderArray[%zu].addrOffset %u should be less than parameter hostArgsSize %zu", i,
                placeHolderArray[i].addrOffset, hostArgsSize));
        COND_RETURN_AND_MSG_OUTER(
            placeHolderArray[i].dataOffset >= hostArgsSize, RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
            "Setting task parameters", RtFmtMsg("placeHolderArray[%zu].dataOffset or hostArgsSize", i),
            RtFmtMsg(
                "Parameter placeHolderArray[%zu].dataOffset %u should be less than parameter hostArgsSize %zu", i,
                placeHolderArray[i].dataOffset, hostArgsSize));
    }
    return RT_ERROR_NONE;
}

static rtError_t CopyPlaceHolderArray(
    const rtPlaceHolderInfo_t* const placeHolderArray, const size_t placeHolderNum,
    rtPlaceHolderInfo_t*& copiedPlaceHolder)
{
    const size_t copySize = placeHolderNum * sizeof(rtPlaceHolderInfo_t);
    copiedPlaceHolder = new (std::nothrow) rtPlaceHolderInfo_t[placeHolderNum];
    COND_RETURN_AND_MSG_OUTER(
        copiedPlaceHolder == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, copySize, "new");
    const errno_t copyRet = memcpy_s(copiedPlaceHolder, copySize, placeHolderArray, copySize);
    if (copyRet != EOK) {
        delete[] copiedPlaceHolder;
        copiedPlaceHolder = nullptr;
        RT_LOG(RT_LOG_ERROR, "copy placeHolder failed, retCode=%d.", copyRet);
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
            ErrorCode::EE1020, "Setting task parameters", "memcpy_s", copyRet,
            "Failed to copy the supplied placeHolder array", RtFmtMsg("copySize=%zu.", copySize));
        return RT_ERROR_SEC_HANDLE;
    }
    return RT_ERROR_NONE;
}

// HOST_BUFFER copy shared by the kernel and SIMT branches; out pointers stay null on failure
static rtError_t DeepCopyHostArgsWithPlaceHolder(
    const void* const hostArgs, const size_t hostArgsSize, const rtPlaceHolderInfo_t* const placeHolderArray,
    const size_t placeHolderNum, uint8_t*& copiedArgs, rtPlaceHolderInfo_t*& copiedPlaceHolder)
{
    copiedArgs = new (std::nothrow) uint8_t[hostArgsSize];
    COND_RETURN_AND_MSG_OUTER(
        copiedArgs == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, hostArgsSize, "new");
    const errno_t copyRet = memcpy_s(copiedArgs, hostArgsSize, hostArgs, hostArgsSize);
    if (copyRet != EOK) {
        delete[] copiedArgs;
        copiedArgs = nullptr;
        RT_LOG(RT_LOG_ERROR, "copy host args failed, retCode=%d, hostArgsSize=%zu.", copyRet, hostArgsSize);
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
            ErrorCode::EE1020, "Setting task parameters", "memcpy_s", copyRet,
            "Failed to copy the supplied host kernel arguments", RtFmtMsg("hostArgsSize=%zu.", hostArgsSize));
        return RT_ERROR_SEC_HANDLE;
    }
    if (placeHolderNum > 0U) {
        const rtError_t error = CopyPlaceHolderArray(placeHolderArray, placeHolderNum, copiedPlaceHolder);
        if (error != RT_ERROR_NONE) {
            delete[] copiedArgs;
            copiedArgs = nullptr;
            return error;
        }
    }
    RT_LOG(
        RT_LOG_DEBUG,
        "srcAddr=%p, copiedAddr=%p, size=%zu, placeHolderSrcAddr=%p, placeHolderCopiedAddr=%p, placeHolderNum=%zu.",
        hostArgs, copiedArgs, hostArgsSize, placeHolderArray, copiedPlaceHolder, placeHolderNum);
    return RT_ERROR_NONE;
}

// allocate one [ptr array][param bytes] block, copy the user args at kernel-metadata offsets, wire argsArray[i]
static rtError_t CreateArgsArrayBlock(const Kernel* const kernel, void** const srcArgsArray, uint8_t*& outArgsBlock)
{
    const uint32_t paramCount = kernel->GetParamCount();
    const uint64_t paramTotalSize = kernel->GetParamTotalSize();
    const uint64_t arrayBytes = static_cast<uint64_t>(paramCount) * sizeof(void*);
    const uint64_t totalBytes = arrayBytes + paramTotalSize;
    // defensive only: paramTotalSize comes from kernel metadata and cannot approach UINT64_MAX
    COND_RETURN_ERROR(
        (totalBytes < arrayBytes), RT_ERROR_INVALID_VALUE,
        "args array block size overflow, paramCount=%u, paramTotalSize=%" PRIu64 ".", paramCount, paramTotalSize);
    outArgsBlock = new (std::nothrow) uint8_t[totalBytes];
    if (outArgsBlock == nullptr) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, totalBytes, "new");
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    uint8_t* const dataBase = outArgsBlock + arrayBytes;
    void** const argsArray = reinterpret_cast<void**>(outArgsBlock);
    const rtError_t error = CopyKernelParamsToBuffer(kernel, srcArgsArray, dataBase, argsArray);
    if (error != RT_ERROR_NONE) {
        delete[] outArgsBlock;
        outArgsBlock = nullptr;
        return error;
    }
    return RT_ERROR_NONE;
}

// ARRAY form: single allocation + deep copy; a zero-param kernel leaves argsArray null
template <typename UpdateInfoT>
static rtError_t CacheArgsArrayForm(const Kernel* const kernel, void** const srcArgsArray, UpdateInfoT& info)
{
    info.argsType = RT_KERNEL_ARGS_ARRAY;
    if (kernel->GetParamTotalSize() == 0ULL) {
        return RT_ERROR_NONE;
    }
    uint8_t* argsBlock = nullptr;
    const rtError_t error = CreateArgsArrayBlock(kernel, srcArgsArray, argsBlock);
    ERROR_RETURN(error, "create args array block failed, retCode=%#x.", static_cast<uint32_t>(error));
    info.argsArray = reinterpret_cast<void**>(argsBlock);
    RT_LOG(
        RT_LOG_DEBUG, "srcArgsArrayAddr=%p, blockAddr=%p, paramCount=%u.", srcArgsArray, argsBlock,
        kernel->GetParamCount());
    return RT_ERROR_NONE;
}

// HOST_BUFFER form, Set path only; the launch path uses DeepCopyHostArgs, identical except the funcDesc
template <typename UpdateInfoT>
static rtError_t CacheHostBufferForm(
    const void* const hostArgs, const size_t hostArgsSize, const rtPlaceHolderInfo_t* const placeHolderArray,
    const size_t placeHolderNum, UpdateInfoT& info)
{
    uint8_t* copiedArgs = nullptr;
    rtPlaceHolderInfo_t* copiedPlaceHolder = nullptr;
    const rtError_t error = DeepCopyHostArgsWithPlaceHolder(
        hostArgs, hostArgsSize, placeHolderArray, placeHolderNum, copiedArgs, copiedPlaceHolder);
    ERROR_RETURN(error, "cache host args failed, retCode=%#x.", static_cast<uint32_t>(error));
    info.argsType = RT_KERNEL_ARGS_HOST_BUFFER;
    info.hostBuffer.hostArgs = copiedArgs;
    info.hostBuffer.hostArgsSize = hostArgsSize;
    info.hostBuffer.placeHolderArray = copiedPlaceHolder;
    info.hostBuffer.placeHolderNum = placeHolderNum;
    return RT_ERROR_NONE;
}

// 旧形态入口：三字段语义与历史一致（非 0 深拷贝，0 零拷贝），结果写入新形态
static rtError_t CacheLegacyArgsForm(const rtKernelTaskParams* const kernelTaskParams, KernelTaskUpdateInfo& info)
{
    COND_RETURN_AND_MSG_OUTER(
        (kernelTaskParams->args == nullptr), RT_ERROR_INVALID_VALUE, ErrorCode::EE1004, "rtModelTaskSetParams",
        "params->kernelTaskParams->args");
    COND_RETURN_AND_MSG_OUTER(
        (kernelTaskParams->argsSize == 0U), RT_ERROR_INVALID_VALUE, ErrorCode::EE1003, "rtModelTaskSetParams",
        kernelTaskParams->argsSize, "params->kernelTaskParams->argsSize", "greater than 0");
    if (kernelTaskParams->isHostArgs != 0U) {
        // 与历史实现同为深拷贝；placeHolder 是新增能力，旧形态无此输入，恒为 0
        return CacheHostBufferForm(kernelTaskParams->args, kernelTaskParams->argsSize, nullptr, 0U, info);
    }
    info.argsType = RT_KERNEL_ARGS_DEVICE_BUFFER;
    info.deviceBuffer.deviceArgs = kernelTaskParams->args;
    info.deviceBuffer.deviceArgsSize = kernelTaskParams->argsSize;
    return RT_ERROR_NONE;
}

static rtError_t CommitKernelTaskCache(
    TaskInfo* const taskInfo, const rtTaskParams* const params, Kernel* const kernel, const TaskCfg& taskCfg,
    const rtKernelTaskParams* const kernelTaskParams, KernelTaskUpdateInfo& kernelUpdateInfo)
{
    kernelUpdateInfo.kernel = kernel;
    kernelUpdateInfo.taskCfg = taskCfg;
    kernelUpdateInfo.numBlocks = kernelTaskParams->numBlocks;
    kernelUpdateInfo.launchFunc = kernelTaskParams->funcHandle;
    return CommitKernelUpdateInfo(taskInfo, params, RT_TASK_KERNEL, kernelUpdateInfo);
}

rtError_t CacheSimtKernelTaskParams(TaskInfo* const taskInfo, const rtTaskParams* const params, Kernel* const kernel)
{
    rtError_t error = CheckCacheKernelTaskCommon(taskInfo, params);
    ERROR_RETURN(error, "check cache kernel task common params failed, retCode=%#x.", static_cast<uint32_t>(error));
    COND_RETURN_AND_MSG_OUTER(
        !IsPureSimtTask(taskInfo->u.aicTaskInfo), RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
        "Setting SIMT task parameters", "task",
        "The target task is not a SIMT kernel task. Before calling aclmdlRITaskSetParams, use "
        "aclmdlRITaskGetParams to obtain the task parameters and fill simtKernelTaskParams for a SIMT task");
    COND_RETURN_AND_MSG_OUTER(
        (kernel == nullptr), RT_ERROR_INVALID_VALUE, ErrorCode::EE1004, "rtModelTaskSetParams",
        "params->simtKernelTaskParams->func");

    const rtSimtKernelTaskParams* const simtTaskParams = &(params->simtKernelTaskParams);
    // validation already ran in ApiErrorDecorator::TaskSetParams; only the cache assembly remains

    TaskCfg taskCfg = {};
    error = ConvertLaunchCfgToTaskCfg(taskCfg, simtTaskParams->cfg);
    ERROR_RETURN(error, "convert task cfg failed, retCode=%#x.", error);
    taskCfg.base.localMemorySize = static_cast<uint32_t>(simtTaskParams->dynUbufSize);

    SimtKernelTaskUpdateInfo kernelUpdateInfo = {};
    kernelUpdateInfo.kernel = kernel;
    kernelUpdateInfo.taskCfg = taskCfg;
    kernelUpdateInfo.numBlocks = simtTaskParams->gridDimX * simtTaskParams->gridDimY * simtTaskParams->gridDimZ;
    kernelUpdateInfo.gridDim = {simtTaskParams->gridDimX, simtTaskParams->gridDimY, simtTaskParams->gridDimZ};
    kernelUpdateInfo.blockDim = {simtTaskParams->blockDimX, simtTaskParams->blockDimY, simtTaskParams->blockDimZ};
    kernelUpdateInfo.dynUbufSize = simtTaskParams->dynUbufSize;
    kernelUpdateInfo.launchFunc = simtTaskParams->func;
    // cache the original params only (no implicit header assembly, the header is generated at load time)
    const void* argsAddr = nullptr; // 活跃形态的缓存地址与大小，仅用于日志
    size_t argsSize = 0U;
    if (simtTaskParams->argsType == RT_KERNEL_ARGS_ARRAY) {
        error = CacheArgsArrayForm(kernel, simtTaskParams->argsArray, kernelUpdateInfo);
        ERROR_RETURN(error, "cache simt args array failed, retCode=%#x.", static_cast<uint32_t>(error));
        argsAddr = kernelUpdateInfo.argsArray;
        argsSize = static_cast<size_t>(kernel->GetParamTotalSize());
    } else {
        error = CacheHostBufferForm(
            simtTaskParams->hostBuffer.hostArgs, simtTaskParams->hostBuffer.hostArgsSize,
            simtTaskParams->hostBuffer.placeHolderArray, simtTaskParams->hostBuffer.placeHolderNum, kernelUpdateInfo);
        ERROR_RETURN(error, "cache simt host args failed, retCode=%#x.", static_cast<uint32_t>(error));
        argsAddr = kernelUpdateInfo.hostBuffer.hostArgs;
        argsSize = kernelUpdateInfo.hostBuffer.hostArgsSize;
    }
    RT_LOG(
        RT_LOG_DEBUG,
        "stream_id=%d, task_id=%hu, kernel_name=%s, func=%p, cfg=%p, gridDim=[%u,%u,%u], blockDim=[%u,%u,%u], "
        "dynUbufSize=%zu, argsType=%s, argsAddr=%p, argsSize=%zu, opInfoPtr=%p, opInfoSize=%zu.",
        taskInfo->stream->Id_(), taskInfo->id, kernel->Name_().c_str(), simtTaskParams->func, simtTaskParams->cfg,
        simtTaskParams->gridDimX, simtTaskParams->gridDimY, simtTaskParams->gridDimZ, simtTaskParams->blockDimX,
        simtTaskParams->blockDimY, simtTaskParams->blockDimZ, simtTaskParams->dynUbufSize,
        KernelArgsTypeToString(kernelUpdateInfo.argsType).c_str(), argsAddr, argsSize, params->opInfoPtr,
        params->opInfoSize);
    return CommitKernelUpdateInfo(taskInfo, params, RT_TASK_SIMT_KERNEL, kernelUpdateInfo);
}

rtError_t CacheKernelTaskParams(TaskInfo* const taskInfo, const rtTaskParams* const params, Kernel* const kernel)
{
    rtError_t error = CheckCacheKernelTaskCommon(taskInfo, params);
    ERROR_RETURN(error, "check cache kernel task common params failed, retCode=%#x.", static_cast<uint32_t>(error));
    COND_RETURN_AND_MSG_OUTER(
        (kernel == nullptr), RT_ERROR_INVALID_VALUE, ErrorCode::EE1004, "rtModelTaskSetParams",
        "params->kernelTaskParams->funcHandle");

    const rtKernelTaskParams* const kernelTaskParams = &(params->kernelTaskParams);
    TaskCfg taskCfg = {};
    error = ConvertLaunchCfgToTaskCfg(taskCfg, kernelTaskParams->cfg);
    ERROR_RETURN(error, "convert task cfg failed, retCode=%#x.", error);

    KernelTaskUpdateInfo kernelUpdateInfo = {};
    const void* argsAddr = nullptr; // 活跃形态的缓存地址与大小，仅用于日志
    size_t argsSize = 0U;
    // level-2 dispatch on argsType; non-zero leaves the legacy fields ignored, GetParams backfills them
    switch (kernelTaskParams->argsType) {
        case RT_KERNEL_ARGS_UNSET: {
            error = CacheLegacyArgsForm(kernelTaskParams, kernelUpdateInfo);
            if (error != RT_ERROR_NONE) {
                return error;
            }
            // 旧形态经转换后为 HOST_BUFFER（深拷贝）或 DEVICE_BUFFER（零拷贝）
            argsAddr = (kernelTaskParams->isHostArgs != 0U) ?
                           static_cast<const void*>(kernelUpdateInfo.hostBuffer.hostArgs) :
                           static_cast<const void*>(kernelUpdateInfo.deviceBuffer.deviceArgs);
            argsSize = (kernelTaskParams->isHostArgs != 0U) ? kernelUpdateInfo.hostBuffer.hostArgsSize :
                                                              kernelUpdateInfo.deviceBuffer.deviceArgsSize;
            break;
        }
        case RT_KERNEL_ARGS_ARRAY: {
            // validation aligned with ApiErrorDecorator::CheckArgsWithType (RT_ARGS_ARRAY)
            COND_RETURN_WARN(
                kernel->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_CPU, RT_ERROR_FEATURE_NOT_SUPPORT,
                "AICPU kernel is not supported.");
            COND_RETURN_AND_MSG_OUTER(
                !(kernel->HasParamSummary()), RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "Setting task parameters",
                "kernel", "Kernel does not have parameter information");
            if (kernel->GetParamCount() > 0U) {
                COND_RETURN_AND_MSG_OUTER(
                    (kernelTaskParams->argsArray == nullptr), RT_ERROR_INVALID_VALUE, ErrorCode::EE1004,
                    "rtModelTaskSetParams", "params->kernelTaskParams->argsArray");
            }
            error = CacheArgsArrayForm(kernel, kernelTaskParams->argsArray, kernelUpdateInfo);
            if (error != RT_ERROR_NONE) {
                return error;
            }
            argsAddr = kernelUpdateInfo.argsArray;
            argsSize = static_cast<size_t>(kernel->GetParamTotalSize());
            break;
        }
        case RT_KERNEL_ARGS_HOST_BUFFER: {
            // validation aligned with ApiErrorDecorator::CheckArgs: offsets must fall inside hostArgsSize
            COND_RETURN_AND_MSG_OUTER(
                (kernelTaskParams->hostBuffer.hostArgs == nullptr), RT_ERROR_INVALID_VALUE, ErrorCode::EE1004,
                "rtModelTaskSetParams", "params->kernelTaskParams->hostBuffer.hostArgs");
            COND_RETURN_AND_MSG_OUTER(
                (kernelTaskParams->hostBuffer.hostArgsSize == 0U), RT_ERROR_INVALID_VALUE, ErrorCode::EE1003,
                "rtModelTaskSetParams", kernelTaskParams->hostBuffer.hostArgsSize,
                "params->kernelTaskParams->hostBuffer.hostArgsSize", "greater than 0");
            if (kernelTaskParams->hostBuffer.placeHolderNum > 0U) {
                COND_RETURN_AND_MSG_OUTER(
                    (kernelTaskParams->hostBuffer.placeHolderArray == nullptr), RT_ERROR_INVALID_VALUE,
                    ErrorCode::EE1004, "rtModelTaskSetParams", "params->kernelTaskParams->hostBuffer.placeHolderArray");
                error = CheckPlaceHolderOffsets(
                    kernelTaskParams->hostBuffer.placeHolderArray, kernelTaskParams->hostBuffer.placeHolderNum,
                    kernelTaskParams->hostBuffer.hostArgsSize);
                ERROR_RETURN(error, "check placeHolder offsets failed, retCode=%#x.", static_cast<uint32_t>(error));
            }
            error = CacheHostBufferForm(
                kernelTaskParams->hostBuffer.hostArgs, kernelTaskParams->hostBuffer.hostArgsSize,
                kernelTaskParams->hostBuffer.placeHolderArray, kernelTaskParams->hostBuffer.placeHolderNum,
                kernelUpdateInfo);
            if (error != RT_ERROR_NONE) {
                return error;
            }
            argsAddr = kernelUpdateInfo.hostBuffer.hostArgs;
            argsSize = kernelUpdateInfo.hostBuffer.hostArgsSize;
            break;
        }
        case RT_KERNEL_ARGS_DEVICE_BUFFER: {
            COND_RETURN_AND_MSG_OUTER(
                (kernelTaskParams->deviceBuffer.deviceArgs == nullptr), RT_ERROR_INVALID_VALUE, ErrorCode::EE1004,
                "rtModelTaskSetParams", "params->kernelTaskParams->deviceBuffer.deviceArgs");
            COND_RETURN_AND_MSG_OUTER(
                (kernelTaskParams->deviceBuffer.deviceArgsSize == 0U), RT_ERROR_INVALID_VALUE, ErrorCode::EE1003,
                "rtModelTaskSetParams", kernelTaskParams->deviceBuffer.deviceArgsSize,
                "params->kernelTaskParams->deviceBuffer.deviceArgsSize", "greater than 0");
            kernelUpdateInfo.argsType = RT_KERNEL_ARGS_DEVICE_BUFFER;
            kernelUpdateInfo.deviceBuffer.deviceArgs = kernelTaskParams->deviceBuffer.deviceArgs;
            kernelUpdateInfo.deviceBuffer.deviceArgsSize = kernelTaskParams->deviceBuffer.deviceArgsSize;
            argsAddr = kernelUpdateInfo.deviceBuffer.deviceArgs;
            argsSize = kernelUpdateInfo.deviceBuffer.deviceArgsSize;
            break;
        }
        default: {
            RT_LOG_OUTER_MSG_IMPL(
                ErrorCode::EE1003, "rtModelTaskSetParams", KernelArgsTypeToString(kernelTaskParams->argsType),
                "params->kernelTaskParams->argsType",
                "KERNEL_ARGS_ARRAY(1), KERNEL_ARGS_HOST_BUFFER(2) or KERNEL_ARGS_DEVICE_BUFFER(3)");
            return RT_ERROR_INVALID_VALUE;
        }
    }
    RT_LOG(
        RT_LOG_DEBUG,
        "stream_id=%d, task_id=%hu, kernel_name=%s, funcHandle=%p, cfg=%p, numBlocks=%u, argsType=%s, "
        "argsAddr=%p, argsSize=%zu, opInfoPtr=%p, opInfoSize=%zu.",
        taskInfo->stream->Id_(), taskInfo->id, kernel->Name_().c_str(), kernelTaskParams->funcHandle,
        kernelTaskParams->cfg, kernelTaskParams->numBlocks, KernelArgsTypeToString(kernelUpdateInfo.argsType).c_str(),
        argsAddr, argsSize, params->opInfoPtr, params->opInfoSize);
    return CommitKernelTaskCache(taskInfo, params, kernel, taskCfg, kernelTaskParams, kernelUpdateInfo);
}

// 归一三形态为 LoadKernelArgs 入参；校验失败在拆卸任务前返回，模型可继续用原参数执行
static rtError_t BuildKernelArgsLoadInput(
    const KernelTaskUpdateInfo* const kernelUpdateInfo, const Kernel* const kernel, rtArgsEx_t& argsInfo,
    void**& argsArray)
{
    argsArray = nullptr;
    switch (kernelUpdateInfo->argsType) {
        case RT_KERNEL_ARGS_ARRAY: {
            // 零参数 kernel 的 argsArray 合法为空，与 launch 侧 ConvertArgsArrayToArgsEx 行为一致
            const uint64_t paramTotalSize = kernel->GetParamTotalSize();
            COND_RETURN_ERROR(
                (paramTotalSize > 0ULL) && (kernelUpdateInfo->argsArray == nullptr), RT_ERROR_MODEL_UPDATE_FAILED,
                "cached ARRAY args are invalid, paramTotalSize=%" PRIu64 ", argsArray is null.", paramTotalSize);
            argsInfo.argsSize = static_cast<uint32_t>(paramTotalSize);
            argsInfo.isNoNeedH2DCopy = (paramTotalSize == 0ULL) ? 1U : 0U;
            argsArray = kernelUpdateInfo->argsArray;
            RT_LOG(
                RT_LOG_DEBUG, "argsType=%s, argsArrayAddr=%p, argsSize=%u, isNoNeedH2DCopy=%u.",
                KernelArgsTypeToString(RT_KERNEL_ARGS_ARRAY).c_str(), argsArray, argsInfo.argsSize,
                static_cast<uint32_t>(argsInfo.isNoNeedH2DCopy));
            return RT_ERROR_NONE;
        }
        case RT_KERNEL_ARGS_HOST_BUFFER: {
            argsInfo.args = kernelUpdateInfo->hostBuffer.hostArgs;
            argsInfo.argsSize = static_cast<uint32_t>(kernelUpdateInfo->hostBuffer.hostArgsSize);
            argsInfo.isNoNeedH2DCopy = 0U;
            COND_RETURN_ERROR(
                (argsInfo.args == nullptr) || (argsInfo.argsSize == 0U), RT_ERROR_MODEL_UPDATE_FAILED,
                "cached HOST_BUFFER args are invalid, args=%p, argsSize=%u.", argsInfo.args, argsInfo.argsSize);
            if (kernelUpdateInfo->hostBuffer.placeHolderNum > 0U) {
                // kernel-form offsets are full-layout relative, layout-compatible with rtHostInputInfo_t
                argsInfo.hostInputInfoPtr =
                    RtPtrToPtr<rtHostInputInfo_t*>(kernelUpdateInfo->hostBuffer.placeHolderArray);
                argsInfo.hostInputInfoNum = static_cast<uint16_t>(kernelUpdateInfo->hostBuffer.placeHolderNum);
            }
            RT_LOG(
                RT_LOG_DEBUG,
                "argsType=%s, argsAddr=%p, argsSize=%u, hostInputInfoAddr=%p, "
                "hostInputInfoNum=%u.",
                KernelArgsTypeToString(RT_KERNEL_ARGS_HOST_BUFFER).c_str(), argsInfo.args, argsInfo.argsSize,
                argsInfo.hostInputInfoPtr, static_cast<uint32_t>(argsInfo.hostInputInfoNum));
            return RT_ERROR_NONE;
        }
        case RT_KERNEL_ARGS_DEVICE_BUFFER: {
            argsInfo.args = kernelUpdateInfo->deviceBuffer.deviceArgs;
            argsInfo.argsSize = static_cast<uint32_t>(kernelUpdateInfo->deviceBuffer.deviceArgsSize);
            argsInfo.isNoNeedH2DCopy = 1U;
            COND_RETURN_ERROR(
                (argsInfo.args == nullptr) || (argsInfo.argsSize == 0U), RT_ERROR_MODEL_UPDATE_FAILED,
                "cached DEVICE_BUFFER args are invalid, args=%p, argsSize=%u.", argsInfo.args, argsInfo.argsSize);
            RT_LOG(
                RT_LOG_DEBUG, "argsType=%s, argsAddr=%p, argsSize=%u, isNoNeedH2DCopy=%u.",
                KernelArgsTypeToString(RT_KERNEL_ARGS_DEVICE_BUFFER).c_str(), argsInfo.args, argsInfo.argsSize,
                static_cast<uint32_t>(argsInfo.isNoNeedH2DCopy));
            return RT_ERROR_NONE;
        }
        default: {
            // Set 与 launch 都已校验 argsType，此处纯防御
            RT_LOG(
                RT_LOG_ERROR, "unsupported cached argsType=%s.",
                KernelArgsTypeToString(kernelUpdateInfo->argsType).c_str());
            return RT_ERROR_MODEL_UPDATE_FAILED;
        }
    }
}

rtError_t UpdateKernelParams(TaskInfo* const taskInfo, KernelTaskUpdateInfo* const kernelUpdateInfo)
{
    Stream* const stm = taskInfo->stream;
    const Device* const dev = stm->Device_();
    Kernel* const kernel = kernelUpdateInfo->kernel;
    COND_RETURN_ERROR(
        (kernel == nullptr), RT_ERROR_MODEL_UPDATE_FAILED, "cached kernel is null, stream_id=%d, task_id=%hu.",
        stm->Id_(), taskInfo->id);

    rtArgsEx_t argsInfo = {};
    void** argsArray = nullptr;
    rtError_t error = BuildKernelArgsLoadInput(kernelUpdateInfo, kernel, argsInfo, argsArray);
    ERROR_RETURN(
        error, "failed to build the args load input, retCode=%#x, device_id=%u, stream_id=%d, task_id=%hu.", error,
        dev->Id_(), stm->Id_(), taskInfo->id);

    BackupTaskArgHandle(taskInfo);
    TaskClearForUpdate(taskInfo);

    uint8_t mixType = NO_MIX;
    uint32_t prefetchCnt1 = 0U;
    uint32_t prefetchCnt2 = 0U;
    Program* const prog = kernel->Program_();
    error = GetPrefetchCntAndMixTypeWithKernel(kernel, prefetchCnt1, prefetchCnt2, mixType);
    ERROR_RETURN(
        error, "failed to get prefetch cnt, retCode=%#x, device_id=%u, stream_id=%d, task_id=%hu.", error, dev->Id_(),
        stm->Id_(), taskInfo->id);

    const rtKernelAttrType kernelAttrType = kernel->GetKernelAttrType();
    const bool isNeedAllocSqeDevBuf = false;
    AicTaskInit(
        taskInfo, kernel, kernelAttrType, static_cast<uint16_t>(kernelUpdateInfo->numBlocks),
        &(kernelUpdateInfo->taskCfg), isNeedAllocSqeDevBuf);
    error = CheckDynSizeValid(taskInfo, kernel);
    ERROR_RETURN(
        error, "Failed to check shared memory size, retCode=%#x, device_id=%u, stream_id=%d, task_id=%hu.", error,
        dev->Id_(), stm->Id_(), taskInfo->id);

    AicTaskInfo* const aicTask = &(taskInfo->u.aicTaskInfo);
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

    StarsArgLoaderResult argsResult = {};
    error = LoadKernelArgs(stm, &argsInfo, argsResult, kernel, kernelUpdateInfo->argsType, argsArray);
    ERROR_RETURN(
        error, "failed to load cached args, retCode=%#x, device_id=%u, stream_id=%d, task_id=%hu.", error, dev->Id_(),
        stm->Id_(), taskInfo->id);
    SetAicoreArgsSuperKernel(taskInfo, &argsInfo, argsResult);

    error = PostUpdateKernelParams(taskInfo);
    ERROR_RETURN(error, "PostUpdateKernelParams failed, retCode=%#x.", error);
    RT_LOG(
        RT_LOG_INFO,
        "device_id=%u, stream_id=%d, task_id=%hu, kernelAttrType=%s, kernel_name=%s, argsType=%s, arg_size=%u, "
        "blockDim=%u, taskRation=%u, funcType=%u, addr1=0x%llx, addr2=0x%llx, "
        "mixType=%u, kernelFlag=0x%x, qos=%u, partId=%u, schemMode=%u, infoAddr=%p, atomicIndex=%u, "
        "shareMemSize=%u, kernelVfType=%u, dynamicShareMemSize=%u, simtDcuSmSize=%u.",
        dev->Id_(), stm->Id_(), taskInfo->id, KernelAttrTypeToString(kernelAttrType).c_str(), kernel->Name_().c_str(),
        KernelArgsTypeToString(kernelUpdateInfo->argsType).c_str(), argsInfo.argsSize, kernelUpdateInfo->numBlocks,
        kernel->GetTaskRation(), kernel->GetFuncType(), kernelPc1, kernelPc2, mixType, aicTask->comm.kernelFlag,
        aicTask->qos, aicTask->partId, aicTask->schemMode, aicTask->inputArgsSize.infoAddr,
        aicTask->inputArgsSize.atomicIndex, kernel->ShareMemSize_(), kernel->KernelVfType_(),
        aicTask->dynamicShareMemSize, aicTask->simtDcuSmSize);
    return RT_ERROR_NONE;
}

//              API     TaskInfo    返回情况
// 永不超时       0        全F          0
// 默认超时     不配置      0         实际超时
// 其他超时     其他值    其他值       实际超时
static rtError_t ConvertTimeoutByAttrId(
    uint64_t timeout, rtLaunchKernelAttrId attrId, rtLaunchKernelAttrVal_t* attrValue)
{
    uint64_t realTimeout; // us
    RT_LOG(RT_LOG_INFO, "timeout(us) in config=%llu", timeout);
    if (timeout == MAX_UINT64_NUM) {
        realTimeout = 0ULL;
    } else {
        uint32_t opTimeout = 0U;
        const rtError_t error = GetOpExecuteMsTimeout(&opTimeout, &timeout);
        COND_RETURN_AND_MSG_OUTER(
            error == RT_ERROR_FEATURE_NOT_SUPPORT, error, ErrorCode::EE1006, "Obtaining kernel function attributes",
            (attrId == RT_LAUNCH_KERNEL_ATTR_TIMEOUT) ? "The TIMEOUT attribute" : "The TIMEOUT_US attribute",
            "The current chip does not support the kernel timeout credit capability");
        ERROR_RETURN(error, "failed to get system timeout for the kernel task attribute");
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

rtError_t GetKernelAttribute(
    const TaskInfo* const taskInfo, rtLaunchKernelAttrId attrId, rtLaunchKernelAttrVal_t* attrValue)
{
    if ((taskInfo->type != TS_TASK_TYPE_KERNEL_AICORE) && (taskInfo->type != TS_TASK_TYPE_KERNEL_AIVEC)) {
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1017, "Obtaining kernel function attributes", "task",
            "The input task must be a compute task on the Cube Core or Vector Core. Before calling "
            "aclmdlRIKernelTaskGetAttribute, "
            "use aclmdlRITaskGetType to obtain the task type and check whether the task type is correct");
        RT_LOG(
            RT_LOG_ERROR, "Invalid taskInfo type=%s(%d), expect 0(AI core) or 66(AI vector)",
            GetTaskDescByType(taskInfo->type), taskInfo->type);
        return RT_ERROR_INVALID_VALUE;
    }

    RT_LOG(RT_LOG_INFO, "get kernel attrId=%s", LaunchKernelAttrIdToString(attrId).c_str());
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
            RT_LOG(
                RT_LOG_INFO, "config schemMode=%u, current schemMode=%u", aicTaskInfo->schemMode, attrValue->schemMode);
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
        case RT_LAUNCH_KERNEL_ATTR_ENABLE_PROFILING:
            attrValue->enableProfiling = taskInfo->enableProfiling;
            break;
        case RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE:
        case RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET:
        case RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH:
            RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
                ErrorCode::EE1003, "Obtaining kernel function attributes", LaunchKernelAttrIdToString(attrId), "attrId",
                RtFmtMsg(
                    "%s, %s, %s, %s, %s or %s", LaunchKernelAttrIdToString(RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE).c_str(),
                    LaunchKernelAttrIdToString(RT_LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE).c_str(),
                    LaunchKernelAttrIdToString(RT_LAUNCH_KERNEL_ATTR_DATA_DUMP).c_str(),
                    LaunchKernelAttrIdToString(RT_LAUNCH_KERNEL_ATTR_TIMEOUT).c_str(),
                    LaunchKernelAttrIdToString(RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US).c_str(),
                    LaunchKernelAttrIdToString(RT_LAUNCH_KERNEL_ATTR_ENABLE_PROFILING).c_str()));
            ret = RT_ERROR_INVALID_VALUE;
            break;
        default:
            RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
                ErrorCode::EE1003, "Obtaining kernel function attributes", LaunchKernelAttrIdToString(attrId), "attrId",
                RtFmtMsg(
                    "[%u, %u)", static_cast<uint32_t>(RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE),
                    static_cast<uint32_t>(RT_LAUNCH_KERNEL_ATTR_MAX)));
            ret = RT_ERROR_INVALID_VALUE;
            break;
    }
    return ret;
}

rtError_t GetOpExecuteMsTimeout(uint32_t* const timeout, uint64_t* customTimeout)
{
    *timeout = 0U;
    float64_t timeoutUs = 0.0F;
    Runtime* const rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);

    const RtTimeoutConfig& timeoutCfg = rtInstance->GetTimeoutConfig();
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
            const uint64_t kernelCreditTmp =
                static_cast<uint64_t>((timeoutTmpUs + kernelCreditScaleUS - 1) / kernelCreditScaleUS);
            timeoutUs = kernelCreditScaleUS * static_cast<float64_t>(kernelCreditTmp);
        }
    } else {
        // ​​If timeout is not set, use AIC default timeout.​
        timeoutUs = kernelCreditScaleUS * static_cast<float64_t>(defaultKernelCredit);
    }

    if ((timeoutCfg.isOpTimeoutMs) && (timeoutCfg.isCfgOpExcTaskTimeout) && (timeoutCfg.opExcTaskTimeout == 0UL)) {
        *timeout = UINT32_MAX; // never timeout
    } else {
        *timeout = static_cast<uint32_t>(ceil(timeoutUs / static_cast<float64_t>(RT_TIMEOUT_MS_TO_US)));
    }
    RT_LOG(RT_LOG_INFO, "get OP execute timeout=%u ms.", *timeout);
    return RT_ERROR_NONE;
}

// deep copy a host args block into copiedArgs, returns the failure code and leaves copiedArgs null on failure
static rtError_t DeepCopyHostArgs(const void* const hostArgs, const size_t hostArgsSize, uint8_t*& copiedArgs)
{
    copiedArgs = new (std::nothrow) uint8_t[hostArgsSize];
    if (copiedArgs == nullptr) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, hostArgsSize, "new");
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    const errno_t ret = memcpy_s(copiedArgs, hostArgsSize, hostArgs, hostArgsSize);
    if (ret != EOK) {
        delete[] copiedArgs;
        copiedArgs = nullptr;
        RT_LOG(RT_LOG_ERROR, "copy host args failed, retCode=%d, hostArgsSize=%zu.", ret, hostArgsSize);
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
            ErrorCode::EE1020, "Caching the kernel launch arguments", "memcpy_s", ret,
            "Failed to copy the host kernel arguments for caching", RtFmtMsg("hostArgsSize=%zu.", hostArgsSize));
        return RT_ERROR_SEC_HANDLE;
    }
    RT_LOG(RT_LOG_DEBUG, "srcAddr=%p, copiedAddr=%p, size=%zu.", hostArgs, copiedArgs, hostArgsSize);
    return RT_ERROR_NONE;
}

// merged placeHolder table for a NON_CPU_EX host-args launch; a null table alone is not a failure
static rtError_t BuildNonCpuPlaceHolderTable(
    const rtArgsEx_t* const argsInfo, rtPlaceHolderInfo_t*& table, uint16_t& placeHolderNum)
{
    table = nullptr;
    placeHolderNum = 0U;
    const uint16_t mergedNum = argsInfo->hostInputInfoNum + ((argsInfo->hasTiling != 0U) ? 1U : 0U);
    if (mergedNum == 0U) {
        return RT_ERROR_NONE;
    }
    table = new (std::nothrow) rtPlaceHolderInfo_t[mergedNum];
    if (table == nullptr) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, mergedNum * sizeof(rtPlaceHolderInfo_t), "new");
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    size_t idx = 0U;
    for (; idx < static_cast<size_t>(argsInfo->hostInputInfoNum); ++idx) {
        table[idx].addrOffset = argsInfo->hostInputInfoPtr[idx].addrOffset;
        table[idx].dataOffset = argsInfo->hostInputInfoPtr[idx].dataOffset;
    }
    if (argsInfo->hasTiling != 0U) {
        table[idx].addrOffset = argsInfo->tilingAddrOffset;
        table[idx].dataOffset = argsInfo->tilingDataOffset;
    }
    placeHolderNum = mergedNum;
    return RT_ERROR_NONE;
}

// unpublish, release, install, republish -- a reader must never see isValid over freed buffers
template <typename UpdateInfoT>
static void CommitLaunchCache(TaskUpdateParams& latestParams, const rtTaskType type, const UpdateInfoT& info)
{
    latestParams.isValid = 0U;
    if (latestParams.type == RT_TASK_KERNEL) {
        FreeKernelUpdateInfoBuffers(latestParams.u.kernelUpdateParams);
    } else if (latestParams.type == RT_TASK_SIMT_KERNEL) {
        FreeKernelUpdateInfoBuffers(latestParams.u.simtKernelUpdateParams);
    }
    SetLatestKernelUpdateParams(latestParams, info);
    latestParams.type = type;
    latestParams.isValid = 1U;
}

// build and commit the SIMT cache entry; a copy failure leaves the old entry untouched and fails the launch
static rtError_t SetSimtKernelLaunchParams(
    const rtStreamLaunchKernelV2ExtendArgs_t* const extendArgs, Kernel* const kernel, TaskInfo& task,
    TaskUpdateParams& latestParams)
{
    SimtKernelTaskUpdateInfo kernelUpdateInfo = {};
    kernelUpdateInfo.kernel = kernel;
    if (extendArgs->simtArgsHost != nullptr) {
        const SimtArgsHost* const simtArgsHost = extendArgs->simtArgsHost;
        kernelUpdateInfo.launchFunc = simtArgsHost->launchFunc;
        kernelUpdateInfo.numBlocks = simtArgsHost->gridDim.x * simtArgsHost->gridDim.y * simtArgsHost->gridDim.z;
        kernelUpdateInfo.gridDim = simtArgsHost->gridDim;
        kernelUpdateInfo.blockDim = simtArgsHost->blockDim;
        kernelUpdateInfo.dynUbufSize = simtArgsHost->dynUbufSize;
        kernelUpdateInfo.argsType = RT_KERNEL_ARGS_HOST_BUFFER;
        uint8_t* copiedArgs = nullptr;
        rtError_t error = DeepCopyHostArgs(simtArgsHost->hostArgs, simtArgsHost->argsSize, copiedArgs);
        ERROR_RETURN(error, "cache simt launch host args failed, retCode=%#x.", static_cast<uint32_t>(error));
        kernelUpdateInfo.hostBuffer.hostArgs = copiedArgs;
        kernelUpdateInfo.hostBuffer.hostArgsSize = simtArgsHost->argsSize;
        if (simtArgsHost->placeHolderNum > 0U) {
            error = CopyPlaceHolderArray(
                simtArgsHost->placeHolderArray, simtArgsHost->placeHolderNum,
                kernelUpdateInfo.hostBuffer.placeHolderArray);
            if (error != RT_ERROR_NONE) {
                delete[] static_cast<uint8_t*>(kernelUpdateInfo.hostBuffer.hostArgs);
                kernelUpdateInfo.hostBuffer.hostArgs = nullptr;
                ERROR_RETURN(error, "cache simt launch placeHolder failed, retCode=%#x.", static_cast<uint32_t>(error));
            }
            kernelUpdateInfo.hostBuffer.placeHolderNum = simtArgsHost->placeHolderNum;
        }
    } else { // simtArgsArray: params block, argsArray[i] wired to the user-region base + offset
        const SimtArgsArray* const simtArgsArray = extendArgs->simtArgsArray;
        kernelUpdateInfo.launchFunc = simtArgsArray->launchFunc;
        kernelUpdateInfo.numBlocks = simtArgsArray->gridDim.x * simtArgsArray->gridDim.y * simtArgsArray->gridDim.z;
        kernelUpdateInfo.gridDim = simtArgsArray->gridDim;
        kernelUpdateInfo.blockDim = simtArgsArray->blockDim;
        kernelUpdateInfo.dynUbufSize = simtArgsArray->dynUbufSize;
        const rtError_t error = CacheArgsArrayForm(kernel, simtArgsArray->argsArray, kernelUpdateInfo);
        ERROR_RETURN(error, "cache simt launch args array failed, retCode=%#x.", static_cast<uint32_t>(error));
    }
    CommitLaunchCache(latestParams, RT_TASK_SIMT_KERNEL, kernelUpdateInfo);
    RT_LOG(
        RT_LOG_INFO, "cache simt launch args success, stream_id=%d, task_id=%hu, argsType=%s.", task.stream->Id_(),
        task.id, KernelArgsTypeToString(kernelUpdateInfo.argsType).c_str());
    return RT_ERROR_NONE;
}

// build and commit the normal kernel cache entry (WithArgsArray / NON_CPU_EX host / device forms)
static rtError_t SetNormalKernelLaunchParams(
    const rtArgsEx_t* const argsInfo, const rtStreamLaunchKernelV2ExtendArgs_t* const extendArgs, TaskInfo& task,
    Kernel* const kernel, TaskUpdateParams& latestParams)
{
    KernelTaskUpdateInfo kernelUpdateInfo = {};
    kernelUpdateInfo.kernel = kernel;
    kernelUpdateInfo.numBlocks = task.u.aicTaskInfo.comm.dim;
    if ((extendArgs != nullptr) && (extendArgs->argsArrayInfo != nullptr)) { // WithArgsArray
        kernelUpdateInfo.launchFunc = extendArgs->argsArrayInfo->launchFunc;
        const rtError_t error = CacheArgsArrayForm(kernel, extendArgs->argsArrayInfo->argsArray, kernelUpdateInfo);
        ERROR_RETURN(error, "cache launch args array failed, retCode=%#x.", static_cast<uint32_t>(error));
    } else if (argsInfo->isNoNeedH2DCopy != 0U) {
        // NON_CPU_EX device args: zero copy; no raw func here, fall back to the kernel handle
        kernelUpdateInfo.launchFunc = kernel->GetInnerHandle();
        kernelUpdateInfo.argsType = RT_KERNEL_ARGS_DEVICE_BUFFER;
        kernelUpdateInfo.deviceBuffer.deviceArgs = argsInfo->args;
        kernelUpdateInfo.deviceBuffer.deviceArgsSize = argsInfo->argsSize;
    } else {
        // NON_CPU_EX host args: deep copy the full block plus the placeHolder table for trace
        if ((argsInfo->args == nullptr) || (argsInfo->argsSize == 0U)) {
            RT_LOG(
                RT_LOG_ERROR, "invalid host args to cache, args=%p, argsSize=%u, stream_id=%d.", argsInfo->args,
                argsInfo->argsSize, task.stream->Id_());
            return RT_ERROR_INVALID_VALUE;
        }
        kernelUpdateInfo.launchFunc = kernel->GetInnerHandle(); // same fallback as the device form
        kernelUpdateInfo.argsType = RT_KERNEL_ARGS_HOST_BUFFER;
        uint8_t* copiedArgs = nullptr;
        rtError_t error = DeepCopyHostArgs(argsInfo->args, argsInfo->argsSize, copiedArgs);
        ERROR_RETURN(error, "cache launch host args failed, retCode=%#x.", static_cast<uint32_t>(error));
        kernelUpdateInfo.hostBuffer.hostArgs = copiedArgs;
        kernelUpdateInfo.hostBuffer.hostArgsSize = argsInfo->argsSize;
        rtPlaceHolderInfo_t* placeHolderTable = nullptr;
        uint16_t mergedPlaceHolderNum = 0U;
        error = BuildNonCpuPlaceHolderTable(argsInfo, placeHolderTable, mergedPlaceHolderNum);
        if (error != RT_ERROR_NONE) {
            // the entry is not committed yet, so release the host args copied above
            delete[] copiedArgs;
            kernelUpdateInfo.hostBuffer.hostArgs = nullptr;
            ERROR_RETURN(error, "cache launch placeHolder table failed, retCode=%#x.", static_cast<uint32_t>(error));
        }
        kernelUpdateInfo.hostBuffer.placeHolderArray = placeHolderTable;
        kernelUpdateInfo.hostBuffer.placeHolderNum = mergedPlaceHolderNum;
    }
    CommitLaunchCache(latestParams, RT_TASK_KERNEL, kernelUpdateInfo);
    RT_LOG(
        RT_LOG_INFO, "cache launch args success, stream_id=%d, task_id=%hu, argsType=%s.", task.stream->Id_(), task.id,
        KernelArgsTypeToString(kernelUpdateInfo.argsType).c_str());
    return RT_ERROR_NONE;
}

// cache the launch args (capture only); Set overwrites, Update keeps; guards aicTaskInfo.kernel (may be null)
rtError_t SetKernelLaunchParams(
    const Stream* const stm, const rtArgsEx_t* const argsInfo, TaskInfo& task,
    const rtStreamLaunchKernelV2ExtendArgs_t* extendArgs)
{
    // 非capture模式下，不需要设置
    if (stm->GetCaptureStatus() == RT_STREAM_CAPTURE_STATUS_NONE) {
        return RT_ERROR_NONE;
    }
    // 非aicore任务，不需要设置
    if ((task.type != TS_TASK_TYPE_KERNEL_AICORE) && (task.type != TS_TASK_TYPE_KERNEL_AIVEC)) {
        return RT_ERROR_NONE;
    }
    // DEFAULT_TILING_KEY legitimately launches with no registered kernel; skip and let Get report
    Kernel* const kernel = task.u.aicTaskInfo.kernel;
    if (kernel == nullptr) {
        RT_LOG(
            RT_LOG_DEBUG, "no registered kernel to cache launch args, stream_id=%d, task_id=%hu.", stm->Id_(), task.id);
        return RT_ERROR_NONE;
    }

    if (task.updateInfo == nullptr) {
        task.updateInfo = new (std::nothrow) TaskUpdateInfo{};
        if (task.updateInfo == nullptr) {
            RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, sizeof(TaskUpdateInfo), "new");
            return RT_ERROR_MEMORY_ALLOCATION;
        }
    }
    TaskUpdateParams& latestParams = task.updateInfo->latestParams;

    const bool isSimtForm =
        (extendArgs != nullptr) && ((extendArgs->simtArgsArray != nullptr) || (extendArgs->simtArgsHost != nullptr));
    if (isSimtForm) {
        return SetSimtKernelLaunchParams(extendArgs, kernel, task, latestParams);
    }
    return SetNormalKernelLaunchParams(argsInfo, extendArgs, task, kernel, latestParams);
}

// deep copy argsArray[i] to dest at kernel-metadata offsets; outArgsArray[i] is wired to the copy
rtError_t CopyKernelParamsToBuffer(const Kernel* kernel, void** argsArray, void* dest, void** outArgsArray)
{
    if (kernel == nullptr || argsArray == nullptr || dest == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Invalid parameters, kernel=%p, argsArray=%p, dest=%p.", kernel, argsArray, dest);
        return RT_ERROR_INVALID_VALUE;
    }

    uint32_t paramCount = kernel->GetParamCount();
    for (uint32_t i = 0U; i < paramCount; i++) {
        uint32_t offset = 0U;
        uint32_t size = 0U;
        COND_RETURN_AND_MSG_OUTER(
            argsArray[i] == nullptr, RT_ERROR_INVALID_VALUE, ErrorCode::EE1004, "Copying kernel parameters to a buffer",
            std::string("argsArray[") + std::to_string(i) + std::string("]"));
        rtError_t error = kernel->GetParamInfo(i, &offset, &size);
        COND_RETURN_ERROR(
            (error != RT_ERROR_NONE), error, "GetParamInfo failed, index=%u, retCode=%#x.", i,
            static_cast<uint32_t>(error));

        void* destAddr = static_cast<uint8_t*>(dest) + offset;
        const errno_t ret = memcpy_s(destAddr, static_cast<size_t>(size), argsArray[i], static_cast<size_t>(size));
        COND_RETURN_ERROR_MSG_INNER(
            (ret != EOK), RT_ERROR_SEC_HANDLE,
            "Failed to call memcpy_s to copy argsArray[%u], dest=%p, dest_max=%zu, src=%p, count=%zu, retCode=%d.", i,
            destAddr, static_cast<size_t>(size), argsArray[i], static_cast<size_t>(size), ret);
        if (outArgsArray != nullptr) {
            outArgsArray[i] = destAddr;
        }
    }
    return RT_ERROR_NONE;
}
} // namespace runtime
} // namespace cce
