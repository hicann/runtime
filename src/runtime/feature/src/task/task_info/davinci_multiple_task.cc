/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "context.hpp"
#include "stars.hpp"
#include "davinci_kernel_task.h"
#include "task_execute_time.h"
#include "davinci_multiple_task.h"

namespace cce {
namespace runtime {

#if F_DESC("DavinciMultipleTask")

rtError_t DavinciMultipleTaskInit(TaskInfo* taskInfo, const void *const multipleTaskInfo, const uint32_t flag)
{
    TaskCommonInfoInit(taskInfo);
    DavinciMultiTaskInfo *multiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    const rtMultipleTaskInfo_t *info = static_cast<const rtMultipleTaskInfo_t *>(multipleTaskInfo);

    taskInfo->type = TS_TASK_TYPE_MULTIPLE_TASK;
    taskInfo->typeName = "MULTIPLE_TASK";
    taskInfo->needPostProc = true;
    multiTaskInfo->multipleTaskInfo = const_cast<void *>(multipleTaskInfo);
    multiTaskInfo->multipleTaskCqeNum = 0U;
    multiTaskInfo->sqeType = 0U;
    multiTaskInfo->errorType = 0U;
    multiTaskInfo->cqeErrorCode = 0U;
    multiTaskInfo->hasUnderstudyTask = false;
    multiTaskInfo->sqeNum = info->taskNum;
    multiTaskInfo->cmdListVec = new (std::nothrow) std::vector<void *>();
    multiTaskInfo->flag = flag;
    COND_RETURN_ERROR_MSG_INNER(multiTaskInfo->cmdListVec == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "multiTaskInfo->cmdListVec new memory fail!");

    multiTaskInfo->argHandleVec = new (std::nothrow) std::vector<void *>();
    COND_PROC_RETURN_ERROR_MSG_INNER(multiTaskInfo->argHandleVec == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        DELETE_O(multiTaskInfo->cmdListVec),
        "multiTaskInfo->argHandleVec new memory fail!");

    return RT_ERROR_NONE;
}

void ResetCmdList(TaskInfo* taskInfo)
{
    DavinciMultiTaskInfo *davMulTask = &taskInfo->u.davinciMultiTaskInfo;
    if (davMulTask->cmdListVec == nullptr) {
        RT_LOG(RT_LOG_INFO, "davMulTask->cmdListVec is nullptr.");
        return;
    }
    RT_LOG(RT_LOG_INFO, "cmdListVec.size() = %u, flag=%u", davMulTask->cmdListVec->size(), davMulTask->flag);
    if (davMulTask->cmdListVec->empty()) {
        delete davMulTask->cmdListVec;
        davMulTask->cmdListVec = nullptr;
        return;
    }

    if ((davMulTask->flag & RT_KERNEL_CMDLIST_NOT_FREE) == 0U) {
        const auto dev = taskInfo->stream->Device_();
        for (auto iter : *davMulTask->cmdListVec) {
            (void)(dev->Driver_())->DevMemFree(iter, dev->Id_());
        }
    }

    davMulTask->cmdListVec->clear();
    delete davMulTask->cmdListVec;
    davMulTask->cmdListVec = nullptr;
}

void IncMultipleTaskCqeNum(TaskInfo *taskInfo)
{
    DavinciMultiTaskInfo *davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);

    if (davinciMultiTaskInfo->multipleTaskCqeNum == 0xFFU) {
        RT_LOG(RT_LOG_WARNING, "multipleTaskCqeNum_=%u", davinciMultiTaskInfo->multipleTaskCqeNum);
        return;
    }

    davinciMultiTaskInfo->multipleTaskCqeNum++;
    return;
}

void ConstructDvppSqe(TaskInfo * const taskInfo, rtStarsSqe_t *const command, size_t idx)
{
    DavinciMultiTaskInfo *davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    Stream * const stream = taskInfo->stream;
    const rtMultipleTaskInfo_t *multipleTaskInfo =
        static_cast<const rtMultipleTaskInfo_t *>(davinciMultiTaskInfo->multipleTaskInfo);
    rtDvppTaskDesc_t dvppTask = multipleTaskInfo->taskDesc[idx].u.dvppTaskDesc;

    RtStarsDvppSqe *const dvppSqe = &(command[idx].dvppSqe);
    const errno_t error = memcpy_s(dvppSqe, sizeof(RtStarsDvppSqe), &(dvppTask.sqe), sizeof(dvppTask.sqe));
    if (error != EOK) {
        dvppSqe->sqeHeader.type = RT_STARS_SQE_TYPE_INVALID;
        RT_LOG(RT_LOG_ERROR, "copy to starsSqe failed, ret=%d, src size=%zu, dst size=%zu",
               error, sizeof(rtStarsCommonSqe_t), sizeof(dvppTask.sqe));
        return;
    }

    dvppSqe->sqeHeader.l1_lock = 0U;
    dvppSqe->sqeHeader.l1_unlock = 0U;
    dvppSqe->sqeHeader.ie = RT_STARS_SQE_INT_DIR_NO;
    dvppSqe->sqeHeader.pre_p = RT_STARS_SQE_INT_DIR_NO;
    dvppSqe->sqeHeader.post_p = RT_STARS_SQE_INT_DIR_NO;
    dvppSqe->sqeHeader.reserved = 0U;
    dvppSqe->sqeHeader.block_dim = 0U;
    dvppSqe->sqeHeader.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    dvppSqe->sqeHeader.task_id = taskInfo->id;
    dvppSqe->task_pos = dvppTask.aicpuTaskPos;

    uint16_t kernelCredit = dvppSqe->kernel_credit;
    kernelCredit = kernelCredit < RT_STARS_MAX_KERNEL_CREDIT ? kernelCredit : RT_STARS_MAX_KERNEL_CREDIT;
    dvppSqe->kernel_credit = kernelCredit;

    // the dvpp has malloced the cmdlist memory.
    const uint64_t cmdListAddrLow = dvppTask.sqe.commandCustom[STARS_DVPP_SQE_CMDLIST_ADDR_LOW_IDX];
    const uint64_t cmdListAddrHigh = dvppTask.sqe.commandCustom[STARS_DVPP_SQE_CMDLIST_ADDR_HIGH_IDX];
    // the dvpp has malloced the cmdlist memory.
    void *cmdList = reinterpret_cast<void *>(((cmdListAddrHigh << UINT32_BIT_NUM) & 0xFFFFFFFF00000000ULL) |
        (cmdListAddrLow & 0x00000000FFFFFFFFULL));
    if (cmdList == nullptr) {
        RT_LOG(RT_LOG_ERROR, "cmdList addr is null.");
        return;
    }
    davinciMultiTaskInfo->cmdListVec->push_back(cmdList);
    IncMultipleTaskCqeNum(taskInfo);
    PrintSqe(&(command[idx]), "DavinciMultipleTask-DVPP");
    RT_LOG(RT_LOG_INFO, "DavinciMultipleTask Dvpp stream_id=%d, task_id=%hu", stream->Id_(), taskInfo->id);
}

void CommonConstructAICpuSqe(TaskInfo* const taskInfo, rtStarsSqe_t *const command, const rtUncommonAicpuParams_t *const params)
{
    DavinciMultiTaskInfo *davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    Stream* const stream = taskInfo->stream;
    ArgLoader* const devArgLdr = stream->Device_()->ArgLoader_();
    ArgLoaderResult result{};
    rtError_t error = RT_ERROR_NONE;
    RtStarsAicpuKernelSqe *const aicpuSqe = &(command[params->idx].aicpuSqe);

    error = devArgLdr->LoadCpuKernelArgs(&(params->argsInfo), stream, &result);
    if (error != RT_ERROR_NONE) {
        aicpuSqe->header.type = RT_STARS_SQE_TYPE_INVALID;
        RT_LOG(RT_LOG_ERROR, "Failed to load cpu Kernel args , retCode=%#x", error);
        return;
    }
    davinciMultiTaskInfo->argHandleVec->push_back(result.handle);

    const bool isUnderstudyOp = ((params->isUnderstudyOp == 1U) ? true : false);
    davinciMultiTaskInfo->hasUnderstudyTask = isUnderstudyOp;

    aicpuSqe->header.type = (isUnderstudyOp) ? RT_STARS_SQE_TYPE_PLACE_HOLDER : RT_STARS_SQE_TYPE_AICPU;
    aicpuSqe->header.l1_lock = 0U;
    aicpuSqe->header.l1_unlock = 0U;
    aicpuSqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    aicpuSqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    aicpuSqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    aicpuSqe->header.wr_cqe = 1U;
    aicpuSqe->header.reserved = 0U;
    aicpuSqe->header.block_dim = params->blockDim;
    aicpuSqe->header.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    aicpuSqe->header.task_id = taskInfo->id;

    aicpuSqe->kernel_type = params->kernelType;
    aicpuSqe->batch_mode = 0U;
    aicpuSqe->topic_type = TOPIC_TYPE_DEVICE_AICPU_ONLY;

    aicpuSqe->qos = stream->Device_()->GetTsdQos();
    aicpuSqe->res7 = 0U;
    aicpuSqe->sqe_index = 0U; // useless
    aicpuSqe->kernel_credit = GetAicpuKernelCredit(0U);
    
    uint64_t addr = RtPtrToValue(params->soNameAddr);
    aicpuSqe->taskSoAddrLow = static_cast<uint32_t>(addr);
    aicpuSqe->taskSoAddrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    addr = RtPtrToValue(result.kerArgs);
    aicpuSqe->paramAddrLow = static_cast<uint32_t>(addr);
    aicpuSqe->param_addr_high = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    addr = RtPtrToValue(params->kernelNameAddr);
    aicpuSqe->task_name_str_ptr_low = static_cast<uint32_t>(addr);
    aicpuSqe->task_name_str_ptr_high = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    aicpuSqe->pL2CtrlLow = 0U;
    aicpuSqe->p_l2ctrl_high = 0U;
    aicpuSqe->overflow_en = stream->IsOverflowEnable();
    aicpuSqe->dump_en = 0U;

    aicpuSqe->extraFieldLow = taskInfo->id;  // send task id info to aicpu
    aicpuSqe->extra_field_high = 0U;

    aicpuSqe->subTopicId = 0U;
    aicpuSqe->topicId = 3U; // EVENT_TS_HWTS_KERNEL
    aicpuSqe->group_id = 0U;
    aicpuSqe->usr_data_len = 40U; /* size: word4-13 */
    aicpuSqe->dest_pid = 0U;

    IncMultipleTaskCqeNum(taskInfo);
    PrintSqe(&(command[params->idx]), "DavinciMultipleTask-AICPU");
    RT_LOG(RT_LOG_INFO, "DavinciMultipleTask Aicpu stream_id=%d, task_id=%hu, kernel_credit=%hu",
        stream->Id_(), taskInfo->id, aicpuSqe->kernel_credit);
}

void ConstructAICpuSqeForDavinciMultipleTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command, size_t idx) {
    DavinciMultiTaskInfo *davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    const rtMultipleTaskInfo_t *multipleTaskInfo =
        static_cast<const rtMultipleTaskInfo_t *>(davinciMultiTaskInfo->multipleTaskInfo);
    rtAicpuTaskDesc_t aicpuTask = multipleTaskInfo->taskDesc[idx].u.aicpuTaskDesc;
    void *soNameAddr = nullptr;
    void *kernelNameAddr = nullptr;
    Stream* const stream = taskInfo->stream;
    ArgLoader* const devArgLdr = stream->Device_()->ArgLoader_();
    rtError_t error = RT_ERROR_NONE;
    RtStarsAicpuKernelSqe *const aicpuSqe = &(command[idx].aicpuSqe);
    rtUncommonAicpuParams_t params;

    if (aicpuTask.kernelLaunchNames.soName != nullptr) {
        error = devArgLdr->GetKernelInfoDevAddr(static_cast<const char_t *>(aicpuTask.kernelLaunchNames.soName),
                                                KernelInfoType::SO_NAME, &soNameAddr);
        if (error != RT_ERROR_NONE) {
            aicpuSqe->header.type = RT_STARS_SQE_TYPE_INVALID;
            RT_LOG(RT_LOG_ERROR, "Failed to get so address by name, retCode=%#x", error);
            return;
        }
    }
    if (aicpuTask.kernelLaunchNames.kernelName != nullptr) {
        error = devArgLdr->GetKernelInfoDevAddr(static_cast<const char_t *>(aicpuTask.kernelLaunchNames.kernelName),
                                                KernelInfoType::KERNEL_NAME, &kernelNameAddr);
        if (error != RT_ERROR_NONE) {
            aicpuSqe->header.type = RT_STARS_SQE_TYPE_INVALID;
            RT_LOG(RT_LOG_ERROR, "Failed to get kernel address by name, retCode=%#x", error);
            return;
        }
    }

    params.idx = idx;
    params.soNameAddr = soNameAddr;
    params.kernelNameAddr = kernelNameAddr;
    params.argsInfo = aicpuTask.argsInfo;
    params.isUnderstudyOp = aicpuTask.isUnderstudyOp;
    params.kernelType = TS_AICPU_KERNEL_AICPU;
    params.blockDim = aicpuTask.blockDim;

    CommonConstructAICpuSqe(taskInfo, command, &params);
}

void ConstructAICpuSqeByHandleForDavinciMultipleTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command, size_t idx) {
    DavinciMultiTaskInfo *davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    const rtMultipleTaskInfo_t *multipleTaskInfo =
        static_cast<const rtMultipleTaskInfo_t *>(davinciMultiTaskInfo->multipleTaskInfo);
    rtAicpuTaskDescByHandle_t aicpuTaskByHandle = multipleTaskInfo->taskDesc[idx].u.aicpuTaskDescByHandle;
    Kernel *hdl = RtPtrToPtr<Kernel *>(aicpuTaskByHandle.funcHdl);
    rtUncommonAicpuParams_t params;
    void *soNameAddr = hdl->GetSoNameDevAddr(taskInfo->stream->Device_()->Id_());
    void *kernelNameAddr = hdl->GetFuncNameDevAddr(taskInfo->stream->Device_()->Id_());

    params.idx = idx;
    params.soNameAddr = soNameAddr;
    params.kernelNameAddr = kernelNameAddr;
    params.argsInfo = aicpuTaskByHandle.argsInfo;
    params.isUnderstudyOp = aicpuTaskByHandle.isUnderstudyOp;
    params.kernelType = hdl->KernelType_();
    params.blockDim = aicpuTaskByHandle.blockDim;

    CommonConstructAICpuSqe(taskInfo, command, &params);
}

void ConstructSqeForDavinciMultipleTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    DavinciMultiTaskInfo *davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    const rtMultipleTaskInfo_t *multipleTaskInfo =
        static_cast<const rtMultipleTaskInfo_t *>(davinciMultiTaskInfo->multipleTaskInfo);
    for (size_t idx = 0U; idx < multipleTaskInfo->taskNum; idx++) {
        if (multipleTaskInfo->taskDesc[idx].type == RT_MULTIPLE_TASK_TYPE_AICPU) {
            ConstructAICpuSqeForDavinciMultipleTask(taskInfo, command, idx);
        } else if (multipleTaskInfo->taskDesc[idx].type == RT_MULTIPLE_TASK_TYPE_AICPU_BY_HANDLE) {
            ConstructAICpuSqeByHandleForDavinciMultipleTask(taskInfo, command, idx);
        } else {
            ConstructDvppSqe(taskInfo, command, idx);
        }
    }
}

uint32_t GetSendSqeNumForDavinciMultipleTask(const TaskInfo * const taskInfo)
{
    const DavinciMultiTaskInfo *multiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);

    RT_LOG(RT_LOG_INFO, "sqe num is %u", multiTaskInfo->sqeNum);
    return multiTaskInfo->sqeNum;
}

uint8_t GetMultipleTaskCqeNum(TaskInfo * const taskInfo)
{
    DavinciMultiTaskInfo *multiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);

    return multiTaskInfo->multipleTaskCqeNum;
}

void DecMultipleTaskCqeNum(TaskInfo *taskInfo)
{
    DavinciMultiTaskInfo *davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    if (davinciMultiTaskInfo->multipleTaskCqeNum == 0U) {
        RT_LOG(RT_LOG_WARNING, "multipleTaskCqeNum_=%u", davinciMultiTaskInfo->multipleTaskCqeNum);
        return;
    }

    davinciMultiTaskInfo->multipleTaskCqeNum--;
    return;
}

void SetMultipleTaskCqeErrorInfo(TaskInfo *taskInfo, uint8_t sqeType, uint8_t errorType, uint32_t errorCode)
{
    DavinciMultiTaskInfo *davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);

    if (davinciMultiTaskInfo->sqeType == 0U) {  // first cqe
        davinciMultiTaskInfo->sqeType = sqeType;
        davinciMultiTaskInfo->errorType = errorType;
        davinciMultiTaskInfo->cqeErrorCode = errorCode;
    } else {
        if (errorType == 0) { // CqReport Success
            davinciMultiTaskInfo->errorType = davinciMultiTaskInfo->errorType & errorType;
            davinciMultiTaskInfo->cqeErrorCode = davinciMultiTaskInfo->cqeErrorCode & errorCode;
        } else { // CqReport fail
            davinciMultiTaskInfo->sqeType = sqeType;
            davinciMultiTaskInfo->errorType = davinciMultiTaskInfo->errorType | errorType;
            davinciMultiTaskInfo->cqeErrorCode = davinciMultiTaskInfo->cqeErrorCode | errorCode;
        }
    }

    RT_LOG(RT_LOG_DEBUG, "sqeType=%u, errorType=%u, errorCode=%u, MultiSqeType=%u, MultiErrorType=%u, MultiCqeErrorCode=%u",
           sqeType, errorType, errorCode, davinciMultiTaskInfo->sqeType, davinciMultiTaskInfo->errorType,
           davinciMultiTaskInfo->cqeErrorCode);
    return;
}

void GetMultipleTaskCqeErrorInfo(TaskInfo * const taskInfo, volatile uint8_t &sqeType,
                                 volatile uint8_t &errorType, volatile uint32_t &errorCode)
{
    DavinciMultiTaskInfo *davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);

    sqeType = davinciMultiTaskInfo->sqeType;
    errorType = davinciMultiTaskInfo->errorType;
    errorCode = davinciMultiTaskInfo->cqeErrorCode;
    return;
}

rtError_t WaitAsyncCopyCompleteForDavinciMultipleTask(TaskInfo *taskInfo)
{
    DavinciMultiTaskInfo *davinciMultiTask = &taskInfo->u.davinciMultiTaskInfo;
    const size_t size = davinciMultiTask->argHandleVec->size();
    RT_LOG(RT_LOG_INFO, "AsyncCopy task, size = %u.", size);
    if (size == 0) {
        return RT_ERROR_NONE;
    }

    for (auto iter : *davinciMultiTask->argHandleVec) {
        Handle *argHdl = static_cast<Handle *>(iter);
        if (!(argHdl->freeArgs)) {
            continue;
        }
        const rtError_t error = argHdl->argsAlloc->H2DMemCopyWaitFinish(argHdl->kerArgs);
        if (error != RT_ERROR_NONE) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "H2DMemCopyWaitFinish for args cpy result failed, retCode=%#x.", static_cast<uint32_t>(error));
            continue;
        }
    }

    RT_LOG(RT_LOG_INFO, "AsyncCopy Complete.");
    return RT_ERROR_NONE;
}

#endif

}  // namespace runtime
}  // namespace cce