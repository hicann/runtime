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
#include "davinci_multiple_task.h"
#include "stream_david.hpp"
#include "stars_david.hpp"
#include "task_execute_time.h"
#include "task_manager.h"

namespace cce {
namespace runtime {

#if F_DESC("DavinciMultipleTask")

static void CommonConstructDavidAICpuSqe(TaskInfo* const taskInfo, rtDavidSqe_t *const command,
                                        uint64_t sqBaseAddr, const rtUncommonAicpuParams_t *const params)
{
    DavinciMultiTaskInfo *davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    Stream * const stm = taskInfo->stream;
    rtDavidSqe_t *sqeAddr = command + params->idx;
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + params->idx;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    ConstructDavidSqeForHeadCommon(taskInfo, sqeAddr);
    RtDavidStarsAicpuKernelSqe *const sqe = &(sqeAddr->aicpuSqe);

    StarsArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX, nullptr, nullptr};
    rtError_t error = static_cast<DavidStream *>(stm)->LoadArgsInfo(&(params->argsInfo), false, &result);
    if (error != RT_ERROR_NONE) {
        sqe->header.type = RT_DAVID_SQE_TYPE_INVALID;
        RT_LOG(RT_LOG_ERROR, "Failed to load CPU Kernel args, retCode=%#x", static_cast<uint32_t>(error));
        return;
    }
    davinciMultiTaskInfo->argHandleVec->push_back(result.handle);

    const bool isUnderstudyOp = ((params->isUnderstudyOp == 1U) ? true : false);
    davinciMultiTaskInfo->hasUnderstudyTask = isUnderstudyOp;

    /* word0-1 */
    sqe->header.type = (isUnderstudyOp) ?
        static_cast<uint8_t>(RT_DAVID_SQE_TYPE_PLACE_HOLDER) : static_cast<uint8_t>(RT_DAVID_SQE_TYPE_AICPU_D);
    sqe->header.wrCqe = 1U;
    sqe->header.blockDim = params->blockDim;

    /* word2 */
    sqe->resv.res1 = 0U;
    sqe->kernelType = params->kernelType;
    sqe->batchMode = 0U;
    sqe->topicType = TOPIC_TYPE_DEVICE_AICPU_ONLY;
    sqe->qos = stm->Device_()->GetTsdQos();
    sqe->res2 = 0U;

    /* word3 */
    sqe->sqeIndex = 0U; // useless
    sqe->kernelCredit = static_cast<uint8_t>(GetAicpuKernelCredit(0UL));
    sqe->res3 = 0U;
    sqe->sqeLength = 0U;

    /* words4-13 use reserved field */
    /* word4-5 */
    uint64_t addr = RtPtrToValue(params->soNameAddr);
    sqe->taskSoAddrLow = static_cast<uint32_t>(addr);
    sqe->taskSoAddrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);
    sqe->res4 = 0U;

    /* word6-7 */
    addr = RtPtrToValue(result.kerArgs);
    sqe->paramAddrLow = static_cast<uint32_t>(addr);
    sqe->paramAddrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);
    sqe->res5 = 0xFFFFU;

    /* word8-9 */
    addr = RtPtrToValue(params->kernelNameAddr);
    sqe->taskNameStrPtrLow = static_cast<uint32_t>(addr);
    sqe->taskNameStrPtrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);
    sqe->res6 = 0U;

    /* word10-11 */
    sqe->pL2ctrlLow = 0U;
    sqe->pL2ctrlHigh = 0U;
    sqe->overflowEn = stm->IsOverflowEnable();
    sqe->dumpEn = 0U;
    sqe->debugDumpEn = 0U;
    sqe->res7 = 0U;

    /* word12-13 */
    sqe->extraFieldLow = taskInfo->taskSn;  // send task id info to aicpu
    sqe->extraFieldHigh = 0U;

    /* word14 */
    sqe->subTopicId = 0U;
    sqe->topicId = 3U; // EVENT_TS_HWTS_KERNEL
    sqe->groupId = 0U;
    sqe->usrDataLen = 40U; /* size: word4-13 */

    /* word15 */
    sqe->destPid = 0U;

    IncMultipleTaskCqeNum(taskInfo);
    PrintDavidSqe(sqeAddr, "DavinciMultipleTask-AICPU");
    RT_LOG(RT_LOG_INFO, "DavinciMultipleTask Aicpu stream_id=%d, task_id=%hu", stm->Id_(), taskInfo->id);
}

void StarsV2DavinciMultipleTaskUnInit(TaskInfo* taskInfo)
{
    DavinciMultiTaskInfo *davMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    Stream * const stm = taskInfo->stream;
    davMultiTaskInfo->multipleTaskInfo = nullptr;
    static_cast<DavidStream *>(stm)->ArgReleaseMultipleTask(taskInfo);
    ResetCmdList(taskInfo);
}

static void ConstructDavidDvppSqe(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint32_t idx,
    uint64_t sqBaseAddr)
{
    DavinciMultiTaskInfo * const davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    Stream * const stream = taskInfo->stream;
    rtMultipleTaskInfo_t * const multipleTaskInfo =
        RtPtrToPtr<rtMultipleTaskInfo_t *>(RtPtrToUnConstPtr<void *>(davinciMultiTaskInfo->multipleTaskInfo));
    rtDvppTaskDesc_t dvppTask = multipleTaskInfo->taskDesc[idx].u.dvppTaskDesc;
    rtDavidSqe_t *sqeAddr = &davidSqe[idx];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + idx;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    RtDavidStarsDvppSqe *const dvppSqe = &(sqeAddr->dvppSqe);
    const errno_t error = memcpy_s(dvppSqe, sizeof(RtDavidStarsDvppSqe), &(dvppTask.sqe), sizeof(dvppTask.sqe));
    if (error != EOK) {
        dvppSqe->header.type = RT_DAVID_SQE_TYPE_INVALID;
        RT_LOG_INNER_MSG(RT_LOG_ERROR,
            "Failed to call memcpy_s to copy dvppTask.sqe, src=%p, dest=%p, dest_max=%u, count=%u, retCode=%#x.",
            &(dvppTask.sqe), dvppSqe, static_cast<uint32_t>(sizeof(RtDavidStarsDvppSqe)),
            static_cast<uint32_t>(sizeof(dvppTask.sqe)), static_cast<uint32_t>(error));
        return;
    }
    dvppSqe->header.lock = 0U;
    dvppSqe->header.unlock = 0U;
    dvppSqe->header.ie = 0U;
    dvppSqe->header.preP = 0U;
    dvppSqe->header.postP = 0U;
    dvppSqe->header.headUpdate = 0U;
    dvppSqe->header.reserved = 0U;
    ConstructDavidSqeForWordOne(taskInfo, sqeAddr);
    uint16_t kernelCredit = dvppSqe->kernelCredit;
    kernelCredit = kernelCredit < RT_STARS_MAX_KERNEL_CREDIT ? kernelCredit : RT_STARS_MAX_KERNEL_CREDIT;
    dvppSqe->kernelCredit = static_cast<uint8_t>(TransKernelCreditCreditByChip(kernelCredit));
    dvppSqe->taskPos = static_cast<uint8_t>(dvppTask.aicpuTaskPos);
    IncMultipleTaskCqeNum(taskInfo);

    // the dvpp has malloced the cmdlist memory.
    uint64_t cmdListAddrLow = dvppTask.sqe.commandCustom[STARS_DVPP_SQE_CMDLIST_ADDR_LOW_IDX];
    uint64_t cmdListAddrHigh = dvppTask.sqe.commandCustom[STARS_DVPP_SQE_CMDLIST_ADDR_HIGH_IDX];
    // the dvpp has malloced the cmdlist memory.
    void *cmdList = RtValueToPtr<void *>(((cmdListAddrHigh << UINT32_BIT_NUM) & 0xFFFFFFFF00000000ULL) |
        (cmdListAddrLow & 0x00000000FFFFFFFFULL));
    if (cmdList == nullptr) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to get cmdList address, it is null.");
        return;
    }
    davinciMultiTaskInfo->cmdListVec->push_back(cmdList);
    PrintDavidSqe(sqeAddr, "DavinciMultipleTask-DVPP");
    RT_LOG(RT_LOG_INFO, "DavinciMultipleTask Dvpp, device_id=%u, stream_id=%d, task_id=%hu.",
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id);
}

static void ConstructDavidAICpuSqeForDavinciMultipleTask(TaskInfo * const taskInfo, rtDavidSqe_t *const command,
    uint32_t idx, uint64_t sqBaseAddr)
{
    DavinciMultiTaskInfo *davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    Stream * const stm = taskInfo->stream;
    rtMultipleTaskInfo_t *multipleTaskInfo =
        RtPtrToPtr<rtMultipleTaskInfo_t *>(RtPtrToUnConstPtr<void *>(davinciMultiTaskInfo->multipleTaskInfo));
    rtAicpuTaskDesc_t aicpuTask = multipleTaskInfo->taskDesc[idx].u.aicpuTaskDesc;
    rtUncommonAicpuParams_t params;

    rtDavidSqe_t *sqeAddr = command + idx;
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + idx;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    ConstructDavidSqeForHeadCommon(taskInfo, sqeAddr);
    RtDavidStarsAicpuKernelSqe *const sqe = &(sqeAddr->aicpuSqe);

    void *soNameAddr = nullptr;
    void *kernelNameAddr = nullptr;
    ArgLoader* const devArgLdr = stm->Device_()->ArgLoader_();
    rtError_t error = RT_ERROR_NONE;

    if (aicpuTask.kernelLaunchNames.soName != nullptr) {
        error = devArgLdr->GetKernelInfoDevAddr(static_cast<const char_t *>(aicpuTask.kernelLaunchNames.soName),
                                                KernelInfoType::SO_NAME, &soNameAddr);
        if (error != RT_ERROR_NONE) {
            sqe->header.type = RT_DAVID_SQE_TYPE_INVALID;
            RT_LOG(RT_LOG_ERROR, "Failed to get SO address by name, retCode=%#x", static_cast<uint32_t>(error));
            return;
        }
    }
    if (aicpuTask.kernelLaunchNames.kernelName != nullptr) {
        error = devArgLdr->GetKernelInfoDevAddr(static_cast<const char_t *>(aicpuTask.kernelLaunchNames.kernelName),
                                                KernelInfoType::KERNEL_NAME, &kernelNameAddr);
        if (error != RT_ERROR_NONE) {
            sqe->header.type = RT_DAVID_SQE_TYPE_INVALID;
            RT_LOG(RT_LOG_ERROR, "Failed to get kernel address by name, retCode=%#x", static_cast<uint32_t>(error));
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

    CommonConstructDavidAICpuSqe(taskInfo, command, sqBaseAddr, &params);
}

static void ConstructDavidAICpuSqeByHandleForDavinciMultipleTask(TaskInfo * const taskInfo, rtDavidSqe_t *const command,
    uint32_t idx, uint64_t sqBaseAddr)
{
    DavinciMultiTaskInfo *davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    rtMultipleTaskInfo_t *multipleTaskInfo =
        RtPtrToPtr<rtMultipleTaskInfo_t *>(RtPtrToUnConstPtr<void *>(davinciMultiTaskInfo->multipleTaskInfo));
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
    params.kernelType = hdl->GetAicpuKernelType_();
    params.blockDim = aicpuTaskByHandle.blockDim;

    CommonConstructDavidAICpuSqe(taskInfo, command, sqBaseAddr, &params);
}

void ConstructDavidSqeForDavinciMultipleTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    DavinciMultiTaskInfo * const davinciMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    rtMultipleTaskInfo_t * const multipleTaskInfo =
        RtPtrToPtr<rtMultipleTaskInfo_t *>(RtPtrToUnConstPtr<void *>(davinciMultiTaskInfo->multipleTaskInfo));
    for (uint32_t idx = 0U; idx < multipleTaskInfo->taskNum; idx++) {
        if (multipleTaskInfo->taskDesc[idx].type == RT_MULTIPLE_TASK_TYPE_AICPU) {
            ConstructDavidAICpuSqeForDavinciMultipleTask(taskInfo, davidSqe, idx, sqBaseAddr);
        } else if (multipleTaskInfo->taskDesc[idx].type == RT_MULTIPLE_TASK_TYPE_AICPU_BY_HANDLE) {
            ConstructDavidAICpuSqeByHandleForDavinciMultipleTask(taskInfo, davidSqe, idx, sqBaseAddr);
        } else {
            ConstructDavidDvppSqe(taskInfo, davidSqe, idx, sqBaseAddr);
        }
    }
}

static bool DavinciMultipleTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &StarsV2DavinciMultipleTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };

    const auto& chips = GetDavidChips();
    for (auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_MULTIPLE_TASK, funcs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_MULTIPLE_TASK, &ConstructDavidSqeForDavinciMultipleTask);

    return true;
}

static bool g_davinciMultipleTaskRegister = DavinciMultipleTaskRegister();

#endif

}  // namespace runtime
}  // namespace cce
