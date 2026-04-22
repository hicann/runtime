/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime.hpp"
#include "stars_david.hpp"
#include "stream_david.hpp"
#include "stars_cond_isa_helper.hpp"
#include "event.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "kernel.h"
#include "thread_local_container.hpp"
#include "task_execute_time.h"
#include "task_res_da.hpp"
#include "fusion_c.hpp"
#include "fusion_sqe.hpp"
#include "aic_aiv_sqe_common.hpp"
#include "ccu_sqe.hpp"
#include "device/device_error_proc.hpp"

namespace cce {
namespace runtime {
static PfnTaskToDavidSqe g_toDavidSqeFunc[TS_TASK_TYPE_RESERVED] = {};

constexpr uint8_t TASK_SQE_NUM_ONE = 1U;
constexpr uint8_t TASK_SQE_NUM_TWO = 2U;
constexpr uint8_t TASK_NUM_FOR_HEAD_UPDATE = 64U;

PfnTaskToDavidSqe *GetDavidSqeFuncAddr()
{
    return g_toDavidSqeFunc;
}

static uint32_t GetSendSqeNumForFusionKernelTask(const TaskInfo *const taskInfo)
{
    return taskInfo->u.fusionKernelTask.sqeLen;
}

uint32_t GetSendDavidSqeNum(const TaskInfo* const taskInfo)
{
    const tsTaskType_t type = taskInfo->type;
    if (type == TS_TASK_TYPE_MULTIPLE_TASK) {
        return GetSendSqeNumForDavinciMultipleTask(taskInfo);
    } else if (type == TS_TASK_TYPE_DIRECT_SEND) {
        return GetSendSqeNumForDirectWqeTask(taskInfo);
    } else if (type == TS_TASK_TYPE_MEMCPY) {
        return GetSendSqeNumForAsyncDmaTask(taskInfo);
    } else if (type == TS_TASK_TYPE_CCU_LAUNCH) {
        return TASK_SQE_NUM_TWO;
    } else if (type == TS_TASK_TYPE_FUSION_KERNEL) {
        return GetSendSqeNumForFusionKernelTask(taskInfo);
    } else if (type == TS_TASK_TYPE_IPC_WAIT) {
        return MEM_WAIT_V2_SQE_NUM;
    } else {
        return TASK_SQE_NUM_ONE;
    }
}

uint8_t GetHeadUpdateFlag(uint64_t allocTimes)
{
    return (allocTimes % TASK_NUM_FOR_HEAD_UPDATE) == 0U ? 1U : 0U;
}

rtDavidSqe_t *GetSqPosAddr(uint64_t sqBaseAddr, uint32_t pos)
{
    uint32_t temp = pos;
    const uint32_t rtsqDepth = Runtime::Instance()->GetCurChipProperties().rtsqDepth;
    if (temp >= rtsqDepth) {
        temp -= rtsqDepth;
    }
    return RtValueToPtr<rtDavidSqe_t *>(sqBaseAddr + (temp << SHIFT_SIX_SIZE));
}

void ToConstructDavidSqe(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    taskInfo->bindFlag = taskInfo->stream->GetBindFlag();
    if (g_toDavidSqeFunc[taskInfo->type] != nullptr) {
        g_toDavidSqeFunc[taskInfo->type](taskInfo, davidSqe, sqBaseAddr);
    }

    if (Runtime::Instance()->GetConnectUbFlag()) {
        uint64_t allocTimes =
            (RtPtrToPtr<TaskResManageDavid *>(taskInfo->stream->taskResMang_))->GetAllocNum();
        davidSqe->phSqe.header.headUpdate = GetHeadUpdateFlag(allocTimes);
    }

    // set expect cqeNum after sqe construction which will be checked before task recycle
    if (taskInfo->type == TS_TASK_TYPE_MULTIPLE_TASK) {
        const uint32_t sendSqeNum = GetSendDavidSqeNum(taskInfo);
        taskInfo->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].expectPackage = static_cast<uint16_t>(sendSqeNum);
    }
}

// fusion ccu not use these following func
static void ConstructDavidSqeForWordOne(const TaskInfo *const taskInfo, rtDavidSqe_t * const sqe)
{
    sqe->commonSqe.sqeHeader.rtStreamId = static_cast<uint16_t>(taskInfo->taskSn & 0xFFFFULL);
    sqe->commonSqe.sqeHeader.taskId = static_cast<uint16_t>((taskInfo->taskSn & 0xFFFF0000ULL) >> UINT16_BIT_NUM);
}

void ConstructDavidSqeForHeadCommon(const TaskInfo *taskInfo, rtDavidSqe_t * const sqe)
{
    Stream * const stream = taskInfo->stream;
    // Performance-sensitive paths, internally controllable addresses
    // and security functions are not required for evaluation.
    (void)memset_s(sqe, sizeof(rtDavidSqe_t), 0, sizeof(rtDavidSqe_t));
    sqe->commonSqe.sqeHeader.wrCqe = stream->GetStarsWrCqeFlag();
    sqe->commonSqe.sqeHeader.rtStreamId = static_cast<uint16_t>(taskInfo->taskSn & 0xFFFFULL);
    sqe->commonSqe.sqeHeader.taskId = static_cast<uint16_t>((taskInfo->taskSn & 0xFFFF0000ULL) >> UINT16_BIT_NUM);
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
        RT_LOG(RT_LOG_ERROR, "copy to starsSqe failed, ret=%d, src size=%zu, dst size=%zu",
            error, sizeof(rtDavidStarsCommonSqe_t), sizeof(dvppTask.sqe));
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
        RT_LOG(RT_LOG_ERROR, "cmdList addr is null.");
        return;
    }
    davinciMultiTaskInfo->cmdListVec->push_back(cmdList);
    PrintDavidSqe(sqeAddr, "DavinciMultipleTask-DVPP");
    RT_LOG(RT_LOG_INFO, "DavinciMultipleTask Dvpp, device_id=%u, stream_id=%d, task_id=%hu.",
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id);
}
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

    DavidArgLoaderResult result = {nullptr, nullptr, nullptr, UINT32_MAX, nullptr, nullptr};
    rtError_t error = static_cast<DavidStream *>(stm)->LoadArgsInfo(&(params->argsInfo), false, &result);
    if (error != RT_ERROR_NONE) {
        sqe->header.type = RT_DAVID_SQE_TYPE_INVALID;
        RT_LOG(RT_LOG_ERROR, "Failed to load cpu Kernel args, retCode=%#x", static_cast<uint32_t>(error));
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
            RT_LOG(RT_LOG_ERROR, "Failed to get so address by name, retCode=%#x", static_cast<uint32_t>(error));
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
    params.kernelType = hdl->KernelType_();
    params.blockDim = aicpuTaskByHandle.blockDim;

    CommonConstructDavidAICpuSqe(taskInfo, command, sqBaseAddr, &params);
}

static void ConstructDavidSqeForDavinciMultipleTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe,
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

static void ConstructDavidSqeForMaintenanceTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    MaintenanceTaskInfo * const maintenanceTaskInfo = &(taskInfo->u.maintenanceTaskInfo);
    Stream * const stream = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);

    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    if (maintenanceTaskInfo->flag && (maintenanceTaskInfo->mtType == MT_STREAM_RECYCLE_TASK)) {
        sqe->u.maintainceInfo.subType = FORCE_RECYCLE_TASK_FLAG;
        sqe->u.maintainceInfo.targetId = static_cast<uint16_t>(maintenanceTaskInfo->mtId);
        sqe->header.preP = 1U; // for force recycle
    } else {
        sqe->header.preP = 0U;
    }
    sqe->header.wrCqe = 1U;       // need write cqe for recycle task
    sqe->taskType = TS_TASK_TYPE_MAINTENANCE;

    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    PrintDavidSqe(davidSqe, "MaintenanceTask");
    RT_LOG(RT_LOG_INFO, "MaintenanceTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn);
}

static void ConstructDavidSqeForStarsCommonTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    StarsCommonTaskInfo * const starsCommTask = &(taskInfo->u.starsCommTask);
    Stream * const stm = taskInfo->stream;
    starsCommTask->commonStarsSqe.commonDavidSqe.sqeHeader.reserved = 0U;
    starsCommTask->commonStarsSqe.commonDavidSqe.sqeHeader.ie = 0U;
    starsCommTask->commonStarsSqe.commonDavidSqe.sqeHeader.preP = 0U;
    starsCommTask->commonStarsSqe.commonDavidSqe.sqeHeader.postP =
        ((starsCommTask->flag & RT_KERNEL_DUMPFLAG) != 0U) ? 1U : 0U;
    starsCommTask->commonStarsSqe.commonDavidSqe.sqeHeader.wrCqe = taskInfo->stream->GetStarsWrCqeFlag();
    starsCommTask->commonStarsSqe.commonDavidSqe.sqeHeader.headUpdate = 0U;

    const errno_t error = memcpy_s(davidSqe, sizeof(rtDavidSqe_t),
        &starsCommTask->commonStarsSqe.commonDavidSqe, sizeof(starsCommTask->commonStarsSqe.commonDavidSqe));
    if (error != EOK) {
        davidSqe->commonSqe.sqeHeader.type = RT_STARS_SQE_TYPE_INVALID;
        RT_LOG(RT_LOG_ERROR, "copy to starsSqe failed,ret=%d,src size=%zu,dst size=%zu",
            error, sizeof(starsCommTask->commonStarsSqe.commonDavidSqe), sizeof(rtDavidSqe_t));
    }
    ConstructDavidSqeForWordOne(taskInfo, davidSqe);
    PrintDavidSqe(davidSqe, "StarsCommonTask");
    RT_LOG(RT_LOG_INFO, "StarsCommonTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
}

static void ConstructDavidSqeForNpuGetFloatStaTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsGetFloatStatusSqe &sqe = davidSqe->getFloatStatusSqe;
    NpuGetFloatStatusTaskInfo * const npuGetFltSta = &(taskInfo->u.npuGetFloatStatusTask);
    Stream * const stm = taskInfo->stream;
    sqe.debugFlag = npuGetFltSta->debugFlag ? 1U : 0U;
    ConstructGetFloatStatusInstr(
        RtPtrToValue(npuGetFltSta->outputAddrPtr),
        npuGetFltSta->outputSize, sqe);

    sqe.header.type = RT_DAVID_SQE_TYPE_COND;
    sqe.header.preP = 1U;
    sqe.condsSubType = CONDS_SUB_TYPE_GET_FLOAT_STATUS;
    sqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe.sqeLength = 0U;
    sqe.csc = 1U;

    PrintDavidSqe(davidSqe, "NpuGetFloatStatusTask");
    RT_LOG(RT_LOG_INFO, "NpuGetFloatStatusTask finish, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, "
        "debugFlag=%hhu.", taskInfo->stream->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn,
        sqe.debugFlag);
}

static void ConstructDavidSqeForNpuClrFloatStaTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);
    NpuClearFloatStatusTaskInfo * const npuClrFltSta = &(taskInfo->u.npuClrFloatStatusTask);

    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_NPU_CLEAR_FLOAT_STATUS;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->u.debugStatusInfo.debugFlag = npuClrFltSta->debugFlag ? 1U : 0U;

    PrintDavidSqe(davidSqe, "NpuClearFloatStatusTask");
    RT_LOG(RT_LOG_INFO, "NpuClearFloatStatusTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, debugFlag=%d.",
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id, taskInfo->taskSn,
        npuClrFltSta->debugFlag);
}

static void ConstructDavidSqeForRingBufferMaintainTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe *const sqe = &(davidSqe->phSqe);
    RingBufferMaintainTaskInfo * const ringBufMtTsk = &(taskInfo->u.ringBufMtTask);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->res1 = taskInfo->stream->Device_()->GetTsLogToHostFlag();
    sqe->taskType = TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    sqe->u.ringBufferControlInfo.ringbufferPhyAddr = 0UL;
    if (ringBufMtTsk->deleteFlag) {
        sqe->u.ringBufferControlInfo.ringbufferOffset = 0UL;
        sqe->u.ringBufferControlInfo.totalLen = 0U;
        sqe->u.ringBufferControlInfo.ringbufferDelFlag = RINGBUFFER_NEED_DEL;
        PrintDavidSqe(davidSqe, "RingBufferMaintain");
        RT_LOG(RT_LOG_INFO, "RingBufferMaintainTask, device_id=%u, stream_id=%d, task_id=%hu",
            taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id);
        return;
    }

    uint64_t offset = RtPtrToValue(ringBufMtTsk->deviceRingBufferAddr);
    sqe->u.ringBufferControlInfo.ringbufferOffset = offset;
    sqe->u.ringBufferControlInfo.totalLen = ringBufMtTsk->bufferLen;
    sqe->u.ringBufferControlInfo.ringbufferDelFlag = 0U;
    sqe->u.ringBufferControlInfo.elementSize = RINGBUFFER_EXT_ONE_ELEMENT_LENGTH_ON_DAVID;

    PrintDavidSqe(davidSqe, "RingBufferCreate");
    RT_LOG(RT_LOG_INFO, "RingBufferCreate, device_id=%u, stream_id=%d, task_id=%hu,"
        " offset=%#" PRIx64 ", elementSize=%u.",
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id, offset,
        sqe->u.ringBufferControlInfo.elementSize);
}

static void ConstructWriteValueSqePtr(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    WriteValueTaskInfo *const writeValTsk = &(taskInfo->u.writeValTask);
    RtDavidStarsWriteValuePtrSqe * const evSqe = &(davidSqe->writeValuePtrSqe);

    evSqe->header.type = RT_DAVID_SQE_TYPE_WRITE_VALUE;
    switch (writeValTsk->cqeFlag) {
        case TASK_WR_CQE_DEFAULT:
            evSqe->header.wrCqe = taskInfo->stream->GetStarsWrCqeFlag();
            break;
        case TASK_WR_CQE_NEVER:
            evSqe->header.wrCqe = 0U;
            break;
        default:
            evSqe->header.wrCqe = 1U;
            break;
    }

    evSqe->header.ptrMode = 1U;
    evSqe->va = 1U;  // va only

    evSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    evSqe->writeValueNewSqeAddrLow = static_cast<uint32_t>(writeValTsk->sqeAddr & MASK_32_BIT);
    evSqe->writeValueNewSqeAddrHigh = static_cast<uint32_t>((writeValTsk->sqeAddr >> UINT32_BIT_NUM) & MASK_17_BIT);

    PrintDavidSqe(davidSqe, "WriteValueTaskPtr");
    RT_LOG(RT_LOG_DEBUG, "WriteValueTaskPtr, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, addr=%#." PRIx64,
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id, taskInfo->taskSn,
        writeValTsk->sqeAddr);
}

static void ConstructDavidSqeForWriteValueTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    WriteValueTaskInfo *const writeValTsk = &(taskInfo->u.writeValTask);
    if (writeValTsk->ptrFlag == 1U) {
        ConstructWriteValueSqePtr(taskInfo, davidSqe, sqBaseAddr);
        return;
    }

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsWriteValueSqe * const evSqe = &(davidSqe->writeValueSqe);
    evSqe->header.type = RT_DAVID_SQE_TYPE_WRITE_VALUE;
    switch (writeValTsk->cqeFlag) {
        case TASK_WR_CQE_DEFAULT:
            evSqe->header.wrCqe = taskInfo->stream->GetStarsWrCqeFlag();
            break;
        case TASK_WR_CQE_NEVER:
            evSqe->header.wrCqe = 0U;
            break;
        default:
            evSqe->header.wrCqe = 1U;
            break;
    }
    evSqe->va = 1U;  // va only

    evSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    evSqe->awsize = writeValTsk->awSize;
    evSqe->snoop = 0U;
    evSqe->awcache = 2U;  // 2U: 0010 Normal Non-cacheable Non-bufferable
    evSqe->awprot = 0U;

    evSqe->writeAddrLow = static_cast<uint32_t>(writeValTsk->addr & MASK_32_BIT);
    evSqe->writeAddrHigh = static_cast<uint32_t>((writeValTsk->addr >> UINT32_BIT_NUM) & MASK_17_BIT);

    uint32_t *temp = RtPtrToPtr<uint32_t *>(writeValTsk->value);
    for (uint32_t idx = 0U; idx < (WRITE_VALUE_SIZE_MAX_LEN/4U); idx++) { // 4U: sizeof(uint32_t)
        evSqe->writeValuePart[idx] = temp[idx];
    }

    PrintDavidSqe(davidSqe, "WriteValueTask");
    RT_LOG(RT_LOG_DEBUG, "WriteValueTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, "
        "addr=%#." PRIx64, taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(),
        taskInfo->id, taskInfo->taskSn, writeValTsk->addr);
}

static void ConstructDavidSqeForGetDevMsgTask(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    GetDevMsgTaskInfo * const getDevMsgTask = &(taskInfo->u.getDevMsgTask);
    Stream * const stm = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);

    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_GET_DEVICE_MSG;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->u.getDevMsgInfo.len = getDevMsgTask->msgBufferLen;
    sqe->u.getDevMsgInfo.devAddr =
        RtPtrToValue(getDevMsgTask->devMem);
    sqe->u.getDevMsgInfo.offset = getDevMsgTask->offset;
    sqe->u.getDevMsgInfo.type = static_cast<uint16_t>(getDevMsgTask->msgType);

    PrintDavidSqe(davidSqe, "GetDevMsgTask");
    RT_LOG(RT_LOG_INFO, "GetDevMsgTask, device_id=%u, stream_id=%d, task_id=%hu.", stm->Device_()->Id_(),
        stm->Id_(), taskInfo->id);
}


static void ConstructDavidSqeBase(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe *const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    RT_LOG(RT_LOG_WARNING, "No need to construct sqe. task_type=%u, device_id=%u, stream_id=%d, task_id=%hu,"
        " task_sn=%u.", taskInfo->type, taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(),
        taskInfo->id, taskInfo->taskSn);
}

static void ConstructDavidSqeForTimeoutSetTask(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    TimeoutSetTaskInfo * const timeoutSetTask = &(taskInfo->u.timeoutSetTask);
    Stream * const stm = taskInfo->stream;
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsAicpuControlSqe *const sqe = &(davidSqe->aicpuControlSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
    sqe->header.blockDim = 1U;

    sqe->kernelType = static_cast<uint16_t>(TS_AICPU_KERNEL_AICPU);
    sqe->batchMode = 0U;
    sqe->topicType = 0U;
    UpdateDavidAICpuControlSqeForDavinciTask(sqe);

    sqe->qos = stm->Device_()->GetTsdQos();
    sqe->res2 = 0U;
    sqe->sqeIndex = 0U; // useless
    sqe->kernelCredit = RT_STARS_DEFAULT_AICPU_KERNEL_CREDIT;

    sqe->usrData.pid = 0U;
    sqe->usrData.cmdType = static_cast<uint8_t>(TS_AICPU_TIMEOUT_CONFIG);
    sqe->usrData.vfId = 0U;
    sqe->usrData.tid = 0U;
    sqe->usrData.tsId = 0U;
    sqe->usrData.u.timeoutCfg.opWaitTimeoutEn = timeoutSetTask->opWaitTimeoutEn;
    sqe->usrData.u.timeoutCfg.opWaitTimeout = timeoutSetTask->opWaitTimeout;

    sqe->usrData.u.timeoutCfg.opExecuteTimeoutEn = timeoutSetTask->opExecuteTimeoutEn;
    if ((timeoutSetTask->opExecuteTimeoutEn) && (timeoutSetTask->opExecuteTimeout == 0U)) {
        sqe->usrData.u.timeoutCfg.opExecuteTimeout = RT_STARS_AICPU_DEFAULT_TIMEOUT;
    } else {
        sqe->usrData.u.timeoutCfg.opExecuteTimeout = timeoutSetTask->opExecuteTimeout;
    }

    sqe->subTopicId = 0U;
    sqe->topicId = 5U; // EVENT_TS_CTRL_MSG
    sqe->groupId = 0U;
    sqe->usrDataLen = 20U;

    sqe->destPid = 0U;
    PrintDavidSqe(davidSqe, "TaskTimeoutSetTask");
    RT_LOG(RT_LOG_INFO, "TaskTimeoutSetTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, "
        "topicType=%u, cmdType=%u.", stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn,
        static_cast<uint32_t>(sqe->topicType), sqe->usrData.cmdType);
}

static void ConstructDavidCommonSqeForDavinciTask(TaskInfo *taskInfo, rtDavidSqe_t * const command,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    RtDavidStarsAicAivKernelSqe *sqe = &(command->aicAivSqe);
    Stream * const stm = taskInfo->stream;
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    ConstructCommonAicAivSqePart(&(aicTaskInfo->comm), sqe, taskInfo, stm);
    return;
}

static void ConstructDavidAICoreSqeForDavinciTask(TaskInfo *taskInfo, rtDavidSqe_t * const command,
    uint64_t sqBaseAddr)
{
    ConstructDavidCommonSqeForDavinciTask(taskInfo, command, sqBaseAddr);
    RtDavidStarsAicAivKernelSqe *sqe = &(command->aicAivSqe);
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const uint64_t addr = RtPtrToValue(aicTaskInfo->comm.args);
    Stream * const stm = taskInfo->stream;
    ConstructAicSqePart(aicTaskInfo, sqe, addr, stm);
    UpdateDavidAICoreSqeForDavinciTask(sqe);
    PrintDavidSqe(command, "AICore Task");
    return;
}

static void ConstructDavidAivSqeForDavinciTask(TaskInfo *taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr)
{
    ConstructDavidCommonSqeForDavinciTask(taskInfo, command, sqBaseAddr);
    RtDavidStarsAicAivKernelSqe *sqe = &(command->aicAivSqe);
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const uint64_t addr = RtPtrToValue(aicTaskInfo->comm.args);
    Stream * const stm = taskInfo->stream;
    ConstructAivSqePart(aicTaskInfo, sqe, addr, stm);

    PrintDavidSqe(command, "AIV Task");
    return;
}

static void SetMixStartPcAndParam(TaskInfo *taskInfo, rtDavidSqe_t * const command)
{
    RtDavidStarsAicAivKernelSqe *sqe = &(command->aicAivSqe);
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const uint64_t addr = RtPtrToValue(aicTaskInfo->comm.args);
    ConstructMixSqePart(aicTaskInfo, sqe, addr);
    return;
}

static void ConstructDavidMixSqeForDavinciTask(TaskInfo *taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr)
{
    ConstructDavidCommonSqeForDavinciTask(taskInfo, command, sqBaseAddr);
    RtDavidStarsAicAivKernelSqe *sqe = &(command->aicAivSqe);
    Stream * const stm = taskInfo->stream;
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    uint8_t taskRation = 0U;
    uint8_t mixType = static_cast<uint8_t>(NO_MIX);
    uint8_t schemMode = aicTaskInfo->schemMode;
    const Kernel *kernel = aicTaskInfo->kernel;
    if (kernel != nullptr) {
        taskRation = static_cast<uint8_t>(kernel->GetTaskRation());
        mixType = kernel->GetMixType();
        Program *programPtr = kernel->Program_();
        if (programPtr != nullptr && programPtr->IsDcacheLockOp()) {
            sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            sqe->header.postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            sqe->featureFlag |= SQE_DCACHE_LOCK_FLAG;
        }
    }

    /* word0-1 */
    if ((mixType == static_cast<uint8_t>(MIX_AIC)) || (mixType == static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC))) {
        sqe->header.type = RT_DAVID_SQE_TYPE_AIC;
    } else {
        sqe->header.type = RT_DAVID_SQE_TYPE_AIV;
    }

    SetMixStartPcAndParam(taskInfo, command);
    uint16_t curSchemMode = GetSchemMode(kernel, schemMode);
    sqe->schem = curSchemMode;
    if (curSchemMode == RT_SCHEM_MODE_BATCH) {
        const uint16_t sqeType = sqe->header.type;
        const uint16_t blockDim = sqe->header.blockDim;
        CheckBlockDim(stm, sqeType, blockDim);
    }
    sqe->ratio = 1U;            // only ratio is 1.
    if (sqe->mix == 1U) {
        sqe->ratio = taskRation;    // ratio from elf
        if ((sqe->header.type == RT_DAVID_SQE_TYPE_AIC) && (sqe->ratio == DEFAULT_TASK_RATION)) {
            sqe->loose = 0U;
        }
    }
    RT_LOG(RT_LOG_INFO, "set cfgInfo schemMode=%u, sqe_schem=%u, taskType=%u, ratio=%u, mix=%u, loose=%u, piMix=%u,"
        "aivSimtDcuSmSize=%u, featureFlag=0x%x.", schemMode, sqe->schem, taskInfo->type, sqe->ratio,
        sqe->mix, sqe->loose, sqe->piMix, sqe->aivSimtDcuSmSize, sqe->featureFlag);

    PrintDavidSqe(command, "MIX Task");

    return;
}

static void ConstructDavidAicAivSqeForDavinciTask(TaskInfo * const taskInfo, rtDavidSqe_t * const command,
    uint64_t sqBaseAddr)
{
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const uint8_t mixType = (aicTaskInfo->kernel != nullptr) ? aicTaskInfo->kernel->GetMixType() :
        static_cast<uint8_t>(NO_MIX);
    if (mixType != NO_MIX) {
        ConstructDavidMixSqeForDavinciTask(taskInfo, command, sqBaseAddr);
    } else {
        if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICORE) {
            ConstructDavidAICoreSqeForDavinciTask(taskInfo, command, sqBaseAddr);
        } else {
            ConstructDavidAivSqeForDavinciTask(taskInfo, command, sqBaseAddr);
        }
    }

    return;
}

static void ConstructDavidSqeForCallbackLaunchTask(TaskInfo * const taskInfo, rtDavidSqe_t *const command,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidPlaceHolderSqe *const sqe = &(command->phSqe);
    Stream * const stm = taskInfo->stream;
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_HOSTFUNC_CALLBACK;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    /* word4-5 */
    sqe->u.callBackInfo.cbCqId = static_cast<uint16_t>(stm->GetCbRptCqid());
    sqe->u.callBackInfo.cbGroupId = static_cast<uint16_t>(stm->GetCbGrpId());
    sqe->u.callBackInfo.devId = static_cast<uint16_t>(stm->Device_()->Id_());
    sqe->u.callBackInfo.streamId = static_cast<uint16_t>(stm->Id_());

    /* word6-7 */
    sqe->u.callBackInfo.notifyId = static_cast<uint32_t>(taskInfo->u.callbackLaunchTask.eventId);
    sqe->u.callBackInfo.taskId = taskInfo->id;  //  send taskId callback cqe
    sqe->u.callBackInfo.isBlock = taskInfo->u.callbackLaunchTask.isBlock;

    sqe->u.callBackInfo.isOnline = stm->Device_()->Driver_()->GetRunMode() == RT_RUN_MODE_OFFLINE ? 0U : 1U;
    sqe->u.callBackInfo.res0 = 0U;
    sqe->u.callBackInfo.res1 = 0U;

    /* word8-11 */
    uint64_t addr = RtPtrToValue(taskInfo->u.callbackLaunchTask.callBackFunc);
    sqe->u.callBackInfo.hostfuncAddrLow = static_cast<uint32_t>(addr);
    sqe->u.callBackInfo.hostfuncAddrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    addr = RtPtrToValue(taskInfo->u.callbackLaunchTask.fnData);
    sqe->u.callBackInfo.fndataLow = static_cast<uint32_t>(addr);
    sqe->u.callBackInfo.fndataHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    /* word12-13 */
    sqe->u.callBackInfo.res2 = 0U;
    sqe->u.callBackInfo.res3 = 0U;

    /* word14 */
    sqe->u.callBackInfo.subTopicId = 0U;
    sqe->u.callBackInfo.topicId = 26U;     // EVENT_TS_CALLBACK_MSG
    sqe->u.callBackInfo.groupId = 11U;     // 11U, drv defined
    sqe->u.callBackInfo.usrDataLen = 32U; // word 4 to word 11
    /* word15 */
    sqe->u.callBackInfo.destPid = 0U;

    PrintDavidSqe(command, "CallbackLaunch");
    RT_LOG(RT_LOG_INFO, "CallbackLaunch, stream_id=%hu, task_id=%hu, notify_id=%hu, isBlock=%hu, pid=%u",
        sqe->u.callBackInfo.streamId, taskInfo->id, sqe->u.callBackInfo.notifyId, sqe->u.callBackInfo.isBlock,
        sqe->u.callBackInfo.destPid);
}

static void ConstructDavidSqeForAicpuMsgVersionTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    AicpuMsgVersionTaskInfo * const task = &(taskInfo->u.aicpuMsgVersionTask);
    Stream * const stm = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsAicpuControlSqe *const sqe = &(davidSqe->aicpuControlSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
    sqe->header.blockDim = 1U;

    sqe->kernelType = static_cast<uint16_t>(TS_AICPU_KERNEL_AICPU);
    sqe->batchMode = 0U;
    sqe->topicType = 0U;
    UpdateDavidAICpuControlSqeForDavinciTask(sqe);

    sqe->qos = stm->Device_()->GetTsdQos();
    sqe->res2 = 0U;
    sqe->sqeIndex = 0U; // useless
    sqe->kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;

    sqe->usrData.pid = 0U;
    sqe->usrData.cmdType = static_cast<uint8_t>(TS_AICPU_MSG_VERSION);
    sqe->usrData.vfId = 0U;
    sqe->usrData.tid = 0U;
    sqe->usrData.tsId = 0U;
    sqe->usrData.u.msgVersion.magicNum = task->magicNum;
    sqe->usrData.u.msgVersion.version = task->version;

    sqe->subTopicId = 0U;
    sqe->topicId = 5U; // EVENT_TS_CTRL_MSG
    sqe->groupId = 0U;
    sqe->usrDataLen = 12U;         /* 8 + 4 */

    sqe->destPid = 0U;
    PrintDavidSqe(davidSqe, "AicpuMsgVersionTask");
    RT_LOG(RT_LOG_INFO, "AicpuMsgVersionTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, "
        "topic_type=%u, cmd_type=%u", stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn,
        static_cast<uint32_t>(sqe->topicType), sqe->usrData.cmdType);
}

void InitWriteValueSqe(RtDavidStarsWriteValueSqe * const writeValueSqe,
    const rtWriteValueInfo_t * const writeValueInfo)
{
    const WriteValueSize awsize = WriteValueSize(static_cast<uint8_t>(writeValueInfo->size) - 1U);
    writeValueSqe->header.type = RT_DAVID_SQE_TYPE_WRITE_VALUE;
    writeValueSqe->awsize = awsize;
    writeValueSqe->snoop = 0U;
    writeValueSqe->awcache = 2U;  // 2U: 0010 Normal Non-cacheable Non-bufferable
    writeValueSqe->awprot = 0U;
    writeValueSqe->va = 1U;

    writeValueSqe->writeAddrLow = static_cast<uint32_t>(writeValueInfo->addr & MASK_32_BIT);
    writeValueSqe->writeAddrHigh = static_cast<uint32_t>((writeValueInfo->addr >> UINT32_BIT_NUM) & MASK_17_BIT);

    const uint32_t writeLen = static_cast<uint32_t>(1U << static_cast<uint32_t>(awsize));
    uint8_t value[WRITE_VALUE_SIZE_MAX_LEN] = {0U};   // max writen size is 4B*8=32B
    for (uint32_t i = 0U; i < writeLen; i++) {
        value[i] = writeValueInfo->value[i];
    }
    uint32_t *temp = RtPtrToPtr<uint32_t *>(value);
    for (uint32_t idx = 0U; idx < (WRITE_VALUE_SIZE_MAX_LEN/4U); idx++) { // 4U: sizeof(uint32_t)
        writeValueSqe->writeValuePart[idx] = temp[idx];
        RT_LOG(RT_LOG_INFO, "writeValuePart[%u]: %u", idx, writeValueSqe->writeValuePart[idx]);
    }

    PrintDavidSqe(RtPtrToPtr<rtDavidSqe_t *>(writeValueSqe), "WriteValueTask");

    return;
}

void RegTaskToDavidSqefunc(void)
{
    g_toDavidSqeFunc[TS_TASK_TYPE_KERNEL_AICPU] = &ConstructDavidAICpuSqeForDavinciTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_KERNEL_AIVEC] = &ConstructDavidAicAivSqeForDavinciTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_KERNEL_AICORE] = &ConstructDavidAicAivSqeForDavinciTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_MULTIPLE_TASK] = &ConstructDavidSqeForDavinciMultipleTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_MEMCPY] = &ConstructDavidSqeForMemcpyAsyncTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_REDUCE_ASYNC_V2] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_REMOTE_EVENT_WAIT] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_MAINTENANCE] = &ConstructDavidSqeForMaintenanceTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_CREATE_STREAM] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_CREATE_L2_ADDR] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_FUSION_ISSUE] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_PROFILING_ENABLE] = &ConstructDavidSqeForProfilingEnableTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_PROFILING_DISABLE] = &ConstructDavidSqeForProfilingDisableTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_ONLINEPROF_START] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_ONLINEPROF_STOP] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_ADCPROF] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_PCTRACE_ENABLE] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_MODEL_MAINTAINCE] = &ConstructDavidSqeForModelMaintainceTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_MODEL_EXECUTE] = &ConstructDavidSqeForModelExecuteTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DEBUG_UNREGISTER_FOR_STREAM] = &ConstructDavidSqeForDebugUnRegisterForStreamTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_MODEL_END_GRAPH] = &ConstructDavidSqeForAddEndGraphTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_MODEL_EXIT_GRAPH] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_MODEL_TO_AICPU] = &ConstructDavidSqeForModelToAicpuTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_NOTIFY_RECORD] = &ConstructDavidSqeForNotifyRecordTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_NOTIFY_WAIT] = &ConstructDavidSqeForNotifyWaitTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_ACTIVE_AICPU_STREAM] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX] = &ConstructDavidSqeForStreamLabelSwitchByIndexTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_STREAM_LABEL_GOTO] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_STARS_COMMON] = &ConstructDavidSqeForStarsCommonTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_FFTS_PLUS] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_NPU_GET_FLOAT_STATUS] = &ConstructDavidSqeForNpuGetFloatStaTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_NPU_CLEAR_FLOAT_STATUS] = &ConstructDavidSqeForNpuClrFloatStaTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_SET_OVERFLOW_SWITCH] = &ConstructDavidSqeForOverflowSwitchSetTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_SET_STREAM_GE_OP_TAG] = &ConstructDavidSqeForStreamTagSetTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL] = &ConstructDavidSqeForRingBufferMaintainTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_WRITE_VALUE] = &ConstructDavidSqeForWriteValueTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_CMO] = &ConstructDavidSqeForCmoTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_BARRIER] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_SET_STREAM_MODE] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_RDMA_SEND] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_RDMA_DB_SEND] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_HOSTFUNC_CALLBACK] = &ConstructDavidSqeForCallbackLaunchTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_STREAM_SWITCH] = &ConstructDavidSqeForStreamSwitchTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_STREAM_SWITCH_N] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_STREAM_ACTIVE] = &ConstructDavidSqeForStreamActiveTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_LABEL_SET] = &ConstructDavidSqeForLabelSetTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_LABEL_SWITCH] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_LABEL_GOTO] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_PROFILER_TRACE] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_PROFILER_TRACE_EX] = &ConstructDavidSqeForProfilerTraceExTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_FUSIONDUMP_ADDR_SET] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_DATADUMP_LOADINFO] = &ConstructDavidSqeForDataDumpLoadInfoTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DEBUG_REGISTER] = &ConstructDavidSqeForDebugRegisterTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DEBUG_UNREGISTER] = &ConstructDavidSqeForDebugUnRegisterTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_TASK_TIMEOUT_SET] = &ConstructDavidSqeForTimeoutSetTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_GET_DEVICE_MSG] = &ConstructDavidSqeForGetDevMsgTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DEBUG_REGISTER_FOR_STREAM] = &ConstructDavidSqeForDebugRegisterForStreamTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_ALLOC_DSA_ADDR] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_FLIP] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_GET_STARS_VERSION] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_SET_SQ_LOCK_UNLOCK] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_UPDATE_ADDRESS] = &ConstructDavidSqeBase;
    g_toDavidSqeFunc[TS_TASK_TYPE_CCU_LAUNCH] = &ConstructDavidSqeForCcuLaunchTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_FUSION_KERNEL] = &ConstructDavidSqeForFusionKernelTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_UB_DB_SEND] = &ConstructDavidSqeForUbDbSendTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DIRECT_SEND] = &ConstructDavidSqeForUbDirectSendTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_MODEL_TASK_UPDATE] = &ConstructDavidSqeForModelUpdateTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_AICPU_INFO_LOAD] = &ConstructDavidSqeForAicpuInfoLoadTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_NOP] = &ConstructDavidSqeForNopTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DAVID_EVENT_RECORD] = &ConstructDavidSqeForEventRecordTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DAVID_EVENT_WAIT] = &ConstructDavidSqeForEventWaitTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_DAVID_EVENT_RESET] = &ConstructDavidSqeForEventResetTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_TSFW_AICPU_MSG_VERSION] = &ConstructDavidSqeForAicpuMsgVersionTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_MEM_WAIT_VALUE] = &ConstructDavidSqeForMemWaitValueTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_MEM_WRITE_VALUE] = &ConstructDavidSqeForMemWriteValueTask;
 	g_toDavidSqeFunc[TS_TASK_TYPE_CAPTURE_RECORD] = &ConstructDavidSqeForMemWriteValueTask;
 	g_toDavidSqeFunc[TS_TASK_TYPE_CAPTURE_WAIT] = &ConstructDavidSqeForMemWaitValueTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_IPC_RECORD] = &ConstructDavidSqeForMemWriteValueTask;
    g_toDavidSqeFunc[TS_TASK_TYPE_IPC_WAIT] = &ConstructDavidSqeForMemWaitValueTask;
}

}  // namespace runtime
}  // namespace cce
