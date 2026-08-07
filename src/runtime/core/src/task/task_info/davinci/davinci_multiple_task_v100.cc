/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "context.hpp"
#include "stars.hpp"
#include "stars_arg_manager.hpp"
#include "davinci_kernel_task.h"
#include "davinci_multiple_task.h"
#include "task_info_v100.h"
#include "task_execute_time.h"
#include "runtime_task_manager.h"

namespace cce {
namespace runtime {

std::mutex g_cmdListVecLock;

#if F_DESC("DavinciMultipleTask")

void DavinciMultipleTaskUnInit(TaskInfo* taskInfo)
{
    DavinciMultiTaskInfo* davMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    Stream* const stm = taskInfo->stream;
    const std::lock_guard<std::mutex> tskLock(g_cmdListVecLock);
    davMultiTaskInfo->multipleTaskInfo = nullptr;
    if (davMultiTaskInfo->argHandleVec != nullptr) {
        for (auto iter : *(davMultiTaskInfo->argHandleVec)) {
            if (iter != nullptr) {
                (void)stm->Device_()->ArgLoader_()->Release(iter);
            }
        }
        davMultiTaskInfo->argHandleVec->clear();
        delete davMultiTaskInfo->argHandleVec;
        davMultiTaskInfo->argHandleVec = nullptr;
    }

    ResetCmdList(taskInfo);
}

void ConstructDvppSqe(TaskInfo* const taskInfo, rtStarsSqe_t* const command, size_t idx)
{
    DavinciMultiTaskInfo* davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    Stream* const stream = taskInfo->stream;
    const rtMultipleTaskInfo_t* multipleTaskInfo =
        static_cast<const rtMultipleTaskInfo_t*>(davinciMultiTaskInfo->multipleTaskInfo);
    rtDvppTaskDesc_t dvppTask = multipleTaskInfo->taskDesc[idx].u.dvppTaskDesc;

    RtStarsDvppSqe* const dvppSqe = &(command[idx].dvppSqe);
    const errno_t error = memcpy_s(dvppSqe, sizeof(RtStarsDvppSqe), &(dvppTask.sqe), sizeof(dvppTask.sqe));
    if (error != EOK) {
        dvppSqe->sqeHeader.type = RT_STARS_SQE_TYPE_INVALID;
        RT_LOG_INNER_MSG(
            RT_LOG_ERROR,
            "Failed to call memcpy_s to copy dvppTask.sqe,"
            " src=%p, dest=%p, dest_max=%zu, count=%zu, retCode=%#x.",
            &(dvppTask.sqe), dvppSqe, sizeof(RtStarsDvppSqe), sizeof(dvppTask.sqe), error);
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
    void* cmdList = RtPtrToPtr<void*>(
        ((cmdListAddrHigh << UINT32_BIT_NUM) & 0xFFFFFFFF00000000ULL) | (cmdListAddrLow & 0x00000000FFFFFFFFULL));
    if (cmdList == nullptr) {
        RT_LOG(RT_LOG_ERROR, "cmdList addr is null.");
        return;
    }
    davinciMultiTaskInfo->cmdListVec->push_back(cmdList);
    IncMultipleTaskCqeNum(taskInfo);
    PrintSqe(&(command[idx]), "DavinciMultipleTask-DVPP");
    RT_LOG(RT_LOG_INFO, "DavinciMultipleTask Dvpp stream_id=%d, task_id=%hu", stream->Id_(), taskInfo->id);
}

void CommonConstructAICpuSqe(
    TaskInfo* const taskInfo, rtStarsSqe_t* const command, const rtUncommonAicpuParams_t* const params)
{
    DavinciMultiTaskInfo* davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    Stream* const stream = taskInfo->stream;
    StarsArgLoaderResult result{};
    rtError_t error = RT_ERROR_NONE;
    RtStarsAicpuKernelSqe* const aicpuSqe = &(command[params->idx].aicpuSqe);

    error = stream->LoadArgsInfo(&(params->argsInfo), false, &result, LoadPolicy::LP_CPU_KRN);
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
    aicpuSqe->kernel_credit = GetAicpuKernelCredit(stream->Device_(), 0U);

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

    aicpuSqe->extraFieldLow = taskInfo->id; // send task id info to aicpu
    aicpuSqe->extra_field_high = 0U;

    aicpuSqe->subTopicId = 0U;
    aicpuSqe->topicId = 3U;       // EVENT_TS_HWTS_KERNEL
    aicpuSqe->group_id = 0U;
    aicpuSqe->usr_data_len = 40U; /* size: word4-13 */
    aicpuSqe->dest_pid = 0U;

    IncMultipleTaskCqeNum(taskInfo);
    PrintSqe(&(command[params->idx]), "DavinciMultipleTask-AICPU");
    RT_LOG(
        RT_LOG_INFO, "DavinciMultipleTask Aicpu stream_id=%d, task_id=%hu, kernel_credit=%hu", stream->Id_(),
        taskInfo->id, aicpuSqe->kernel_credit);
}

void ConstructAICpuSqeForDavinciMultipleTask(TaskInfo* const taskInfo, rtStarsSqe_t* const command, size_t idx)
{
    DavinciMultiTaskInfo* davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    const rtMultipleTaskInfo_t* multipleTaskInfo =
        static_cast<const rtMultipleTaskInfo_t*>(davinciMultiTaskInfo->multipleTaskInfo);
    rtAicpuTaskDesc_t aicpuTask = multipleTaskInfo->taskDesc[idx].u.aicpuTaskDesc;
    void* soNameAddr = nullptr;
    void* kernelNameAddr = nullptr;
    Stream* const stream = taskInfo->stream;
    ArgLoader* const devArgLdr = stream->Device_()->ArgLoader_();
    rtError_t error = RT_ERROR_NONE;
    RtStarsAicpuKernelSqe* const aicpuSqe = &(command[idx].aicpuSqe);
    rtUncommonAicpuParams_t params;

    if (aicpuTask.kernelLaunchNames.soName != nullptr) {
        error = devArgLdr->GetKernelInfoDevAddr(
            static_cast<const char_t*>(aicpuTask.kernelLaunchNames.soName), KernelInfoType::SO_NAME, &soNameAddr);
        if (error != RT_ERROR_NONE) {
            aicpuSqe->header.type = RT_STARS_SQE_TYPE_INVALID;
            RT_LOG(RT_LOG_ERROR, "Failed to get so address by name, retCode=%#x", error);
            return;
        }
    }
    if (aicpuTask.kernelLaunchNames.kernelName != nullptr) {
        error = devArgLdr->GetKernelInfoDevAddr(
            static_cast<const char_t*>(aicpuTask.kernelLaunchNames.kernelName), KernelInfoType::KERNEL_NAME,
            &kernelNameAddr);
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

void ConstructAICpuSqeByHandleForDavinciMultipleTask(TaskInfo* const taskInfo, rtStarsSqe_t* const command, size_t idx)
{
    DavinciMultiTaskInfo* davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    const rtMultipleTaskInfo_t* multipleTaskInfo =
        static_cast<const rtMultipleTaskInfo_t*>(davinciMultiTaskInfo->multipleTaskInfo);
    rtAicpuTaskDescByHandle_t aicpuTaskByHandle = multipleTaskInfo->taskDesc[idx].u.aicpuTaskDescByHandle;
    Kernel* hdl = RtPtrToPtr<Kernel*>(aicpuTaskByHandle.funcHdl);
    rtUncommonAicpuParams_t params;
    void* soNameAddr = hdl->GetSoNameDevAddr(taskInfo->stream->Device_()->Id_());
    void* kernelNameAddr = hdl->GetFuncNameDevAddr(taskInfo->stream->Device_()->Id_());

    params.idx = idx;
    params.soNameAddr = soNameAddr;
    params.kernelNameAddr = kernelNameAddr;
    params.argsInfo = aicpuTaskByHandle.argsInfo;
    params.isUnderstudyOp = aicpuTaskByHandle.isUnderstudyOp;
    params.kernelType = hdl->GetAicpuKernelType_();
    params.blockDim = aicpuTaskByHandle.blockDim;

    CommonConstructAICpuSqe(taskInfo, command, &params);
}

void ConstructSqeForDavinciMultipleTask(TaskInfo* const taskInfo, rtStarsSqe_t* const command)
{
    DavinciMultiTaskInfo* davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    const rtMultipleTaskInfo_t* multipleTaskInfo =
        static_cast<const rtMultipleTaskInfo_t*>(davinciMultiTaskInfo->multipleTaskInfo);
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

rtError_t WaitAsyncCopyCompleteForDavinciMultipleTask(TaskInfo* taskInfo)
{
    DavinciMultiTaskInfo* davinciMultiTask = &taskInfo->u.davinciMultiTaskInfo;
    const size_t size = davinciMultiTask->argHandleVec->size();
    RT_LOG(RT_LOG_INFO, "AsyncCopy task, size = %u.", size);
    if (size == 0) {
        return RT_ERROR_NONE;
    }

    for (auto iter : *davinciMultiTask->argHandleVec) {
        Handle* argHdl = static_cast<Handle*>(iter);
        if (!(argHdl->freeArgs)) {
            continue;
        }
        const rtError_t error = argHdl->argsAlloc->H2DMemCopyWaitFinish(argHdl->kerArgs);
        if (error != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_ERROR, "Failed to call H2DMemCopyWaitFinish to copy args, retCode=%#x.",
                static_cast<uint32_t>(error));
            continue;
        }
    }

    RT_LOG(RT_LOG_INFO, "AsyncCopy Complete.");
    return RT_ERROR_NONE;
}

static bool DavinciMultipleTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForDavinciMultipleTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &DavinciMultipleTaskUnInit,
        .waitAsyncCpCompleteFunc = &WaitAsyncCopyCompleteForDavinciMultipleTask,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    const auto& chips = GetV100Chips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_MULTIPLE_TASK, funcs);
    }

    return true;
}

static bool g_davinciMultipleTaskRegister = DavinciMultipleTaskRegister();

#endif

} // namespace runtime
} // namespace cce
