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
    if (temp >= Runtime::macroValue_.rtsqDepth) {
        temp -= Runtime::macroValue_.rtsqDepth;
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

void AixKernelTaskInitForFusion(TaskInfo * const taskInfo, const rtAicAivFusionInfo_t * const aicAivInfo,
    const LaunchTaskCfgInfo_t * const launchTaskCfg)
{
    FusionTaskInfo *fusionTaskInfo = &(taskInfo->u.fusionKernelTask);
    FusionTaskInfoAicPart *aicPart = &(fusionTaskInfo->aicPart);

    GetAicAivTypeForFusion(aicAivInfo->mixType, aicAivInfo->mach, fusionTaskInfo->aicAivType);

    aicPart->dim = aicAivInfo->dimNum;
    aicPart->kernel = aicAivInfo->kernel;

    aicPart->kernelFlag = static_cast<uint8_t>(launchTaskCfg->dumpflag & 0xFFU);
    aicPart->qos = launchTaskCfg->qos;
    aicPart->partId = launchTaskCfg->partId;
    aicPart->schemMode = launchTaskCfg->schemMode;

    aicPart->dynamicShareMemSize = 0U;
    aicPart->simtDcuSmSize = RT_SIMT_UB_SIZE;
    aicPart->groupDim = 0U;
    aicPart->groupBlockDim = 0U;
    aicPart->funcAddr = aicAivInfo->funcAddr;
    aicPart->funcAddr1 = aicAivInfo->funcAddr1;
    rtArgsSizeInfo_t &argsSize = ThreadLocalContainer::GetArgsSizeInfo();
    if (argsSize.infoAddr != nullptr) {
        aicPart->inputArgsSize.infoAddr = argsSize.infoAddr;
        aicPart->inputArgsSize.atomicIndex = argsSize.atomicIndex;
        argsSize.infoAddr = nullptr;
        argsSize.atomicIndex = 0U;
        RT_LOG(RT_LOG_INFO, "infoAddr=%p, atomicIndex=%u.",
            aicPart->inputArgsSize.infoAddr, aicPart->inputArgsSize.atomicIndex);
    } else {
        aicPart->inputArgsSize.infoAddr = nullptr;
        aicPart->inputArgsSize.atomicIndex = 0U;
    }
    RT_LOG(RT_LOG_INFO, "aicAivType=%hhu, taskRation=%u, kernelFlag=0x%x, qos=%u,"
        " partId=%u, schemMode=%u.", fusionTaskInfo->aicAivType, aicPart->kernel->GetTaskRation(),
        aicPart->kernelFlag, aicPart->qos, aicPart->partId,
        aicPart->schemMode);
}

void FusionKernelTaskInit(TaskInfo *taskInfo)
{
    TaskCommonInfoInit(taskInfo);
    FusionTaskInfo *fusionTaskInfo = &(taskInfo->u.fusionKernelTask);

    taskInfo->type = TS_TASK_TYPE_FUSION_KERNEL;
    taskInfo->typeName = const_cast<char_t*>("FUSION_KERNEL");
    fusionTaskInfo->argHandle = nullptr;
    fusionTaskInfo->argsInfo = nullptr;
    return;
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
    IncMultipleTaskCqeNum(taskInfo);
    PrintDavidSqe(sqeAddr, "DavinciMultipleTask-DVPP");
    RT_LOG(RT_LOG_INFO, "DavinciMultipleTask Dvpp, deviceId=%u, streamId=%d, taskId=%hu.",
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

static void ConstructDavidSqeForModelMaintainceTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ModelMaintainceTaskInfo * const modelMaintainceTaskInfo = &(taskInfo->u.modelMaintainceTaskInfo);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->taskType = TS_TASK_TYPE_MODEL_MAINTAINCE;

    sqe->u.modelMaintainceInfo.modelId = static_cast<uint16_t>(modelMaintainceTaskInfo->model->Id_());
    sqe->u.modelMaintainceInfo.streamId = static_cast<uint16_t>(modelMaintainceTaskInfo->opStream->Id_());
    sqe->u.modelMaintainceInfo.operation = static_cast<uint16_t>(modelMaintainceTaskInfo->type);
    sqe->u.modelMaintainceInfo.streamType = static_cast<uint16_t>(modelMaintainceTaskInfo->streamType);
    sqe->u.modelMaintainceInfo.firstTaskId = static_cast<uint16_t>(modelMaintainceTaskInfo->firstTaskId);

    const int32_t type = static_cast<int32_t>(modelMaintainceTaskInfo->type);
    switch (type) {
        case MMT_STREAM_ADD:
            sqe->header.preP = 1U;
            sqe->u.modelMaintainceInfo.streamExecTimesAddr = modelMaintainceTaskInfo->execTimesSvmOffset;
            modelMaintainceTaskInfo->opStream->SetBindFlag(true);
            PrintDavidSqe(davidSqe, "ModelBindTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%d, deviceId=%u, bind streamId=%hu to modelId=%hu, taskId=%hu",
                type, taskInfo->stream->Device_()->Id_(), sqe->u.modelMaintainceInfo.streamId,
                sqe->u.modelMaintainceInfo.modelId, taskInfo->id);
            break;
        case MMT_STREAM_DEL:
            sqe->header.preP = 1U;
            modelMaintainceTaskInfo->opStream->SetBindFlag(false);
            PrintDavidSqe(davidSqe, "ModelUnbindTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%d, deviceId=%u, unbind streamId=%hu from modelId=%hu,"
                "taskId=%hu", type, taskInfo->stream->Device_()->Id_(), sqe->u.modelMaintainceInfo.streamId,
                sqe->u.modelMaintainceInfo.modelId, taskInfo->id);
            break;
        case MMT_MODEL_PRE_PROC:
            sqe->header.preP = 1U;
            sqe->u.modelMaintainceInfo.executorFlag = MODEL_EXECUTOR_RESERVED;
            if (modelMaintainceTaskInfo->model->ModelExecuteType() == EXECUTOR_AICPU) {
                sqe->u.modelMaintainceInfo.executorFlag = MODEL_EXECUTOR_AICPU;
            } else {
                sqe->u.modelMaintainceInfo.endgraphNotifyId =
                    static_cast<uint16_t>(modelMaintainceTaskInfo->model->GetEndGraphNotify()->GetNotifyId());
            }
            PrintDavidSqe(davidSqe, "ModelPreProcTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%d, deviceId=%u, pre proc streamId=%hu of modelId=%hu,"
                "endgraphNotifyId=%hu, taskId=%hu", type, taskInfo->stream->Device_()->Id_(),
                sqe->u.modelMaintainceInfo.streamId, sqe->u.modelMaintainceInfo.modelId,
                sqe->u.modelMaintainceInfo.endgraphNotifyId, taskInfo->id);
            break;
        case MMT_MODEL_LOAD_COMPLETE:
            PrintDavidSqe(davidSqe, "ModelLoadCompleteTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%d, deviceId=%u, load complete streamId=%hu of modelId=%hu,"
                "taskId=%hu", type, taskInfo->stream->Device_()->Id_(), sqe->u.modelMaintainceInfo.streamId,
                sqe->u.modelMaintainceInfo.modelId, taskInfo->id);
            break;
        case MMT_MODEL_ABORT:
            sqe->header.preP = 1U;
            PrintDavidSqe(davidSqe, "ModelAbortTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%d, deviceId=%u, abort streamId=%hu of modelId=%hu, taskId=%hu",
                type, taskInfo->stream->Device_()->Id_(), sqe->u.modelMaintainceInfo.streamId,
                sqe->u.modelMaintainceInfo.modelId, taskInfo->id);
            break;
        default:
            PrintDavidSqe(davidSqe, "ModelMaintainceTask");
            RT_LOG(RT_LOG_INFO, "model maintaince type=%d, deviceId=%u, streamId=%hu, modelId=%hu, taskId=%hu",
                type, taskInfo->stream->Device_()->Id_(), sqe->u.modelMaintainceInfo.streamId,
                sqe->u.modelMaintainceInfo.modelId, taskInfo->id);
            break;
    }
    return;
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

static void ConstructDavidSqeForProfilingEnableTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ProfilingEnableTaskInfo * const profilingEnableTaskInfo = &(taskInfo->u.profilingEnableTaskInfo);
    Stream * const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe *const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_PROFILER_DYNAMIC_ENABLE;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->u.dynamicProfilingInfo.pid = profilingEnableTaskInfo->pid;
    sqe->u.dynamicProfilingInfo.isTaskBasedProfEn = profilingEnableTaskInfo->isTaskBasedProfEn;
    sqe->u.dynamicProfilingInfo.isSocLogEn = profilingEnableTaskInfo->isHwtsLogEn;
    PrintDavidSqe(davidSqe, "DynamicProfilingEnableTask");
    RT_LOG(RT_LOG_INFO, "ProfilingEnableTask, deviceId=%u, streamId=%d, taskId=%hu, pid=%llu."
        "isSocLogEn=%hhu, isTaskBasedProfEn=%hhu.",
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id, profilingEnableTaskInfo->pid,
        sqe->u.dynamicProfilingInfo.isSocLogEn, sqe->u.dynamicProfilingInfo.isTaskBasedProfEn);
}

static void ConstructDavidSqeForProfilingDisableTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ProfilingDisableTaskInfo * const profilingDisableTaskInfo = &(taskInfo->u.profilingDisableTaskInfo);
    Stream * const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_PROFILER_DYNAMIC_DISABLE;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->u.dynamicProfilingInfo.pid = profilingDisableTaskInfo->pid;
    sqe->u.dynamicProfilingInfo.isTaskBasedProfEn = profilingDisableTaskInfo->isTaskBasedProfEn;
    sqe->u.dynamicProfilingInfo.isSocLogEn = profilingDisableTaskInfo->isHwtsLogEn;
    PrintDavidSqe(davidSqe, "DynamicProfilingDisableTask");
    RT_LOG(RT_LOG_INFO, "ProfilingDisableTask, deviceId=%u, streamId=%d, taskId=%hu, pid=%u, "
        "isSocLogEn=%hhu, isTaskBasedProfEn=%hhu.",
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id,
        sqe->u.dynamicProfilingInfo.pid, sqe->u.dynamicProfilingInfo.isSocLogEn,
        sqe->u.dynamicProfilingInfo.isTaskBasedProfEn);
}

static void ConstructDavidSqeForModelExecuteTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ModelExecuteTaskInfo * const modelExecuteTaskInfo = &(taskInfo->u.modelExecuteTaskInfo);
    Stream * const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;
    sqe.header.type = RT_DAVID_SQE_TYPE_COND;
    sqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe.header.postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    sqe.sqeLength = 0U;
    sqe.csc = 1U;

    sqe.condsSubType = CONDS_SUB_TYPE_MODEL_EXEC;
    sqe.reserved0 = static_cast<uint16_t>(modelExecuteTaskInfo->modelId);

    const uint64_t funcAddr = modelExecuteTaskInfo->model->GetFuncCallSvmMem();
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsModelExeFuncCall));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "ModelExecuteTask");
    RT_LOG(RT_LOG_INFO, "ModelExecuteTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, model_id=%hu.",
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn, sqe.reserved0);
}

static void ConstructDavidSqeForDebugUnRegisterForStreamTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe *const sqe = &(davidSqe->phSqe);
    Stream * const stm = taskInfo->stream;
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_DEBUG_UNREGISTER_FOR_STREAM;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->u.streamDebugRegisterInfo.streamId = taskInfo->u.debugUnRegisterForStreamTask.streamId;

    PrintDavidSqe(davidSqe, "DebugUnRegisterForStream");
    RT_LOG(RT_LOG_INFO, "DebugUnRegisterForStreamTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        taskInfo->stream->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
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

static void ConstructDavidSqeForOverflowSwitchSetTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);
    OverflowSwitchSetTaskInfo * const overflowSwiSet = &(taskInfo->u.overflowSwitchSetTask);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_SET_OVERFLOW_SWITCH;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    sqe->u.streamOverflowSwitchInfo.streamId = static_cast<uint16_t>(overflowSwiSet->targetStm->Id_());
    sqe->u.streamOverflowSwitchInfo.isSwitchOn = overflowSwiSet->switchFlag ? 1U : 0U;

    PrintDavidSqe(davidSqe, "OverflowSwitchSetTask");
    RT_LOG(RT_LOG_INFO, "OverflowSwitchSetTask target, device_id=%u, stream_id=%d, target_stream_id=%d, task_id=%hu,"
        "task_sn=%u, switch %s.", taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), overflowSwiSet->targetStm->Id_(),
        taskInfo->id, taskInfo->taskSn, overflowSwiSet->switchFlag ? "on" : "off");
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
static void ConstructDavidSqeForStreamTagSetTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    StreamTagSetTaskInfo * const stmTagSetTsk = &(taskInfo->u.stmTagSetTask);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_SET_STREAM_GE_OP_TAG;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    sqe->u.streamSetTagInfo.streamId = static_cast<uint16_t>(stmTagSetTsk->targetStm->Id_());
    sqe->u.streamSetTagInfo.geOpTag = stmTagSetTsk->geOpTag;

    PrintDavidSqe(davidSqe, "StreamTagSetTask");
    RT_LOG(RT_LOG_INFO, "StreamTagSetTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, target_stream_id=%d, "
        "sqe_stream_id=%hu, geOpTag=%u.", taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(),
        taskInfo->id, taskInfo->taskSn, stmTagSetTsk->targetStm->Id_(), sqe->header.rtStreamId,
        stmTagSetTsk->geOpTag);
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

    PrintDavidSqe(davidSqe, "RingBufferMaintain");
    RT_LOG(RT_LOG_INFO, "RingBufferMaintainTask, device_id=%u, stream_id=%d, task_id=%hu, offset=%#" PRIx64,
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id, offset);
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

static void ConstructDavidSqeForDebugRegisterTask(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe *const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_DEBUG_REGISTER;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    sqe->u.modelDebugRegisterInfo.addr = taskInfo->u.debugRegisterTask.addr;
    sqe->u.modelDebugRegisterInfo.modelId = taskInfo->u.debugRegisterTask.modelId;
    sqe->u.modelDebugRegisterInfo.flag = taskInfo->u.debugRegisterTask.flag;

    PrintDavidSqe(davidSqe, "DebugRegister");
    RT_LOG(RT_LOG_INFO, "DebugRegisterTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
}

static void ConstructDavidSqeForDebugUnRegisterTask(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_DEBUG_UNREGISTER;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    sqe->u.modelDebugRegisterInfo.modelId = taskInfo->u.debugUnRegisterTask.modelId;

    PrintDavidSqe(davidSqe, "DebugUnRegister");
    RT_LOG(RT_LOG_INFO, "DebugUnRegisterTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, "
        "model_id=%u.", stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn,
        taskInfo->u.debugUnRegisterTask.modelId);
}

static void ConstructDavidSqeForProfilerTraceExTask(TaskInfo *taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_PROFILER_TRACE_EX;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->u.profileTraceInfo.profilerTraceId = taskInfo->u.profilerTraceExTask.profilerTraceId;
    sqe->u.profileTraceInfo.modelId = taskInfo->u.profilerTraceExTask.modelId;
    sqe->u.profileTraceInfo.tagId = taskInfo->u.profilerTraceExTask.tagId;

    PrintDavidSqe(davidSqe, "ProfilerTraceExTask");
    RT_LOG(RT_LOG_INFO, "ProfilerTraceExTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
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


static void ConstructDavidSqeForAddEndGraphTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsAicpuKernelSqe * const sqe = &(davidSqe->aicpuSqe);
    Stream * const stm = taskInfo->stream;

    sqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
    sqe->header.blockDim = 1U;
    sqe->kernelType = (static_cast<uint16_t>(TS_AICPU_KERNEL_AICPU));
    sqe->batchMode = 0U;
    sqe->topicType = 0U;

    sqe->qos = stm->Device_()->GetTsdQos();
    sqe->res2 = 0U;
    sqe->sqeIndex = 0U; // useless
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->sqeLength = 0U;

    // soname aicpu no need
    uint64_t addr = 0ULL;
    sqe->taskSoAddrLow = static_cast<uint32_t>(addr);
    sqe->taskSoAddrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    sqe->paramAddrLow = static_cast<uint32_t>(taskInfo->u.addEndGraphTask.argptr);
    sqe->paramAddrHigh = static_cast<uint16_t>(taskInfo->u.addEndGraphTask.argptr >> UINT32_BIT_NUM);

    sqe->taskNameStrPtrLow = static_cast<uint32_t>(taskInfo->u.addEndGraphTask.endGraphNamePtr);
    sqe->taskNameStrPtrHigh = static_cast<uint16_t>(taskInfo->u.addEndGraphTask.endGraphNamePtr >> UINT32_BIT_NUM);
    sqe->pL2ctrlLow = 0U;
    sqe->pL2ctrlHigh = 0U;
    sqe->overflowEn = 0U;
    sqe->extraFieldLow = taskInfo->taskSn; // send task id info to aicpu
    sqe->extraFieldHigh = 0U;

    sqe->subTopicId = 0U;
    sqe->topicId = 3U; // EVENT_TS_HWTS_KERNEL
    sqe->groupId = 0U;
    sqe->usrDataLen = 40U; // size: word4-13
    sqe->destPid = 0U;

    sqe->res5 = 0xFFFFU;

    PrintDavidSqe(davidSqe, "AddEndGraphTask");
    RT_LOG(RT_LOG_INFO, "AddEndGraphTask:ConstructDavidSqe, topicType=%u, sqe addr=%p, device_id=%u, stream_id=%d,"
        "task_id=%hu", static_cast<uint32_t>(sqe->topicType), davidSqe, taskInfo->stream->Device_()->Id_(),
        stm->Id_(), taskInfo->id);
}

static void ConstructDavidSqeForModelToAicpuTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsAicpuControlSqe *const sqe = &(davidSqe->aicpuControlSqe);
    Stream * const stm = taskInfo->stream;
    sqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
    sqe->header.blockDim = 1U;

    sqe->kernelType = static_cast<uint16_t>(TS_AICPU_KERNEL_AICPU);
    sqe->batchMode = 0U;
    sqe->topicType = 0U;

    sqe->qos = stm->Device_()->GetTsdQos();
    sqe->res2 = 0U;
    sqe->sqeIndex = 0U; // useless
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->sqeLength = 0U;

    sqe->usrData.pid = 0U;
    sqe->usrData.cmdType = static_cast<uint8_t>(TS_AICPU_MODEL_OPERATE);
    sqe->usrData.vfId = 0U;
    sqe->usrData.tid = 0U;
    sqe->usrData.tsId = 0U;
    sqe->usrData.u.modelOperate.streamId = static_cast<uint16_t>(stm->Id_());
    sqe->usrData.u.modelOperate.cmdType = static_cast<uint8_t>(taskInfo->u.modelToAicpuTask.cmdType);
    sqe->usrData.u.modelOperate.modelId = static_cast<uint16_t>(taskInfo->u.modelToAicpuTask.modelId);
    sqe->usrData.u.modelOperate.modelInfoAddrLow = static_cast<uint32_t>(taskInfo->u.modelToAicpuTask.modelArgPtr);
    sqe->usrData.u.modelOperate.modelInfoAddrHigh =
        static_cast<uint16_t>(taskInfo->u.modelToAicpuTask.modelArgPtr >> UINT32_BIT_NUM);

    sqe->subTopicId = 0U;
    sqe->topicId = 5U; // EVENT_TS_CTRL_MSG
    sqe->groupId = 0U;
    sqe->usrDataLen = 24U;

    sqe->destPid = 0U;
    PrintDavidSqe(davidSqe, "ModelToAicpuTask");
    RT_LOG(RT_LOG_INFO, "ModelToAicpuTask:ConstructDavidSqe, topic_type=%u, cmd_type=%u, device_id=%u,"
        "stream_id=%d, task_id=%hu", static_cast<uint32_t>(sqe->topicType),
        taskInfo->u.modelToAicpuTask.cmdType, taskInfo->stream->Device_()->Id_(), stm->Id_(), taskInfo->id);
}

static void ConstructDavidSqeForDebugRegisterForStreamTask(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_DEBUG_REGISTER_FOR_STREAM;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->u.streamDebugRegisterInfo.addr = taskInfo->u.debugRegisterForStreamTask.addr;
    sqe->u.streamDebugRegisterInfo.streamId = taskInfo->u.debugRegisterForStreamTask.streamId;
    sqe->u.streamDebugRegisterInfo.flag = taskInfo->u.debugRegisterForStreamTask.flag;

    PrintDavidSqe(davidSqe, "DebugRegisterForStream");
    RT_LOG(RT_LOG_INFO, "DebugRegisterForStreamTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
}

static void ConstructDavidSqeForDataDumpLoadInfoTask(TaskInfo *taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stm = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_DATADUMP_LOADINFO;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->u.dataDumpLoadInfo.dumpinfoPtr = taskInfo->u.dataDumpLoadInfoTask.dumpInfo;
    sqe->u.dataDumpLoadInfo.length = taskInfo->u.dataDumpLoadInfoTask.length;
    sqe->u.dataDumpLoadInfo.streamId = static_cast<uint16_t>(stm->Id_());
    sqe->u.dataDumpLoadInfo.taskId = taskInfo->id;
    sqe->u.dataDumpLoadInfo.kernelType = taskInfo->u.dataDumpLoadInfoTask.kernelType;
    sqe->u.dataDumpLoadInfo.reserved = 0U;

    PrintDavidSqe(davidSqe, "DataDumpLoadInfoTask");
    RT_LOG(RT_LOG_INFO, "DataDumpLoadInfoTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
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

static void ConstructDavidSqeForCcuLaunchTask(TaskInfo *taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidStarsCcuSqe * const sqe = &(command->ccuSqe);
    Stream * const stream = taskInfo->stream;
    sqe->header.type = RT_DAVID_SQE_TYPE_CCU;

    CcuLaunchTaskInfo *tskinfo = &(taskInfo->u.ccuLaunchTask);
    sqe->resv.ccuResvDesc2.missionId = tskinfo->missionId;
    sqe->resv.ccuResvDesc2.dieId = tskinfo->dieId;
    sqe->resv.ccuResvDesc2.ccuSize = tskinfo->ccu_size;
    sqe->kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;
    sqe->timeout = tskinfo->timeout;
    sqe->sqeLength = 1U;
    sqe->instStartId = tskinfo->instStartId;
    sqe->instCnt = tskinfo->instCnt;
    sqe->instAddrKeyValue = tskinfo->key;

    uint32_t *args = tskinfo->args;
    for (uint32_t i = 0U; i < CCU_1ST_SQE_ARGS_LEN; i++) {
        sqe->usrData[i] = args[i];
    }
    rtDavidSqe_t *sqeAddr = command + 1U;
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + 1U;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    const errno_t ret = memcpy_s(sqeAddr, sizeof(rtDavidStarsCommonSqe_t),
        (args + CCU_1ST_SQE_ARGS_LEN), (sizeof(uint32_t) * CCU_2ND_SQE_LEFT_LEN));
    if (ret != EOK) {
        sqe->header.type = RT_DAVID_SQE_TYPE_INVALID;
        RT_LOG(RT_LOG_ERROR, "copy to starsSqe failed, ret=%d, src size=%zu, dst size=%zu",
            ret, sizeof(rtDavidStarsCommonSqe_t), (sizeof(uint32_t) * CCU_2ND_SQE_LEFT_LEN));
        return;
    }
    PrintDavidSqe(command, "CcuLaunchTask Part0");
    PrintDavidSqe(sqeAddr, "CcuLaunchTask Part1");
    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%hu, task_id=%hu, missionId=%hu, dieId=%hu, instStartId=%hu, "
        "instCnt=%hu", stream->Device_()->Id_(), stream->Id_(), taskInfo->id, tskinfo->missionId, tskinfo->dieId,
        tskinfo->instStartId, tskinfo->instCnt);
    return;
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

static void ConfigDieFriendly(const TaskInfo* taskInfo, RtDavidStarsAicAivKernelSqe * const sqe, const Stream * const stm)
{
    sqe->dieFriendly = 1U;
#ifndef CFG_DEV_PLATFORM_PC
    const uint8_t dieNum = stm->Device_()->GetDavidDieNum();
    if (dieNum <= 1U) {
        sqe->dieFriendly = 0U; // 单die产品无需做亲die调度。
    }
#else
    UNUSED(stm);
#endif

    const bool aicTask = (taskInfo->type == TS_TASK_TYPE_KERNEL_AICORE) || (taskInfo->type == TS_TASK_TYPE_KERNEL_AIVEC);
    uint16_t blkDim = 0U;
    uint16_t groupDim = 0U;
    uint16_t groupBlockDim = 0U;
    if (aicTask) {
        blkDim = taskInfo->u.aicTaskInfo.comm.dim;
        groupDim = taskInfo->u.aicTaskInfo.groupDim;
        groupBlockDim = taskInfo->u.aicTaskInfo.groupBlockDim;
    } else {
        blkDim = taskInfo->u.fusionKernelTask.aicPart.dim;
        groupDim = taskInfo->u.fusionKernelTask.aicPart.groupDim;
        groupBlockDim = taskInfo->u.fusionKernelTask.aicPart.groupBlockDim;
    }

    if (groupDim != 0) { // active mode
        sqe->groupDim = groupDim;
        sqe->groupBlockdim = groupBlockDim;
        sqe->header.blockDim = groupDim * groupBlockDim;
        return;
    }

    // passive mode
    sqe->groupDim = static_cast<uint16_t>(sqe->header.blockDim <= 1U ? 1U : 2U);
    const uint16_t value = static_cast<uint16_t>( blkDim / sqe->groupDim ) ;
    sqe->groupBlockdim = (static_cast<uint16_t>(sqe->header.blockDim % sqe->groupDim) == 0U) ? value : (value + 1U);
}

template<typename T>
static void ConstructAivSqePart(const T * const kernelInfo, RtDavidStarsAicAivKernelSqe * const sqe, uint64_t addr)
{
    const uint64_t funcAddr = kernelInfo->funcAddr;
    uint32_t prefetchCnt1 = 0U;
    if (kernelInfo->kernel != nullptr) {
        prefetchCnt1 = kernelInfo->kernel->PrefetchCnt1_();
    }
    /* word0-1 */
    sqe->header.type = RT_DAVID_SQE_TYPE_AIV;

    /* word6 */
    sqe->aicPmg = 0U;
    sqe->aicPartId = 0U;
    sqe->piMix = 0U;
    sqe->aicQos = 0U;
    sqe->aicWrrRd = 0U;
    sqe->aicWrrWr = 0U;
    sqe->aicIcachePrefetchCnt = 0U;
    sqe->aivIcachePrefetchCnt = static_cast<uint16_t>(prefetchCnt1);

    /* word7 */
    sqe->aivPmg = 0U;
    sqe->aivPartId = kernelInfo->partId;
    sqe->res4 = 0U;
    sqe->aivQos = kernelInfo->qos;
    sqe->aivWrrRd = RT_DAVID_AIV_WRR_RD;
    sqe->aivWrrWr = RT_DAVID_AIV_WRR_WR;
    sqe->schem = static_cast<uint16_t>(kernelInfo->schemMode);
    sqe->ratio = 1U;            // only ratio is 1.

    /* word8-9 */
    sqe->aicStartPcLow = 0U;
    sqe->aivStartPcLow = static_cast<uint32_t>(funcAddr);

    /* word10 */
    sqe->aicStartPcHigh = 0U;
    sqe->aivStartPcHigh = static_cast<uint16_t>(funcAddr >> UINT32_BIT_NUM);

    /* word11-15 */
    sqe->aivSimtDcuSmSize = kernelInfo->simtDcuSmSize;
    sqe->aicTaskParamPtrLow = 0U;
    sqe->aicTaskParamPtrHigh = 0U;
    sqe->aivTaskParamPtrLow = static_cast<uint32_t>(addr);
    sqe->aivTaskParamPtrHigh = (sqe->aivTaskParamPtrHigh & 0xFFF00000U) | static_cast<uint32_t>(addr >> UINT32_BIT_NUM);
    RT_LOG(RT_LOG_INFO, "set cfgInfo schemMode=%u, ratio=%u, aivSimtDcuSmSize=%u.", kernelInfo->schemMode,
        sqe->ratio, sqe->aivSimtDcuSmSize);
}

template<typename T>
static void ConstructCommonAicAivSqePart(const T * const kernelInfo, RtDavidStarsAicAivKernelSqe * const sqe,
    const TaskInfo *taskInfo, const Stream *const stm)
{
    const Kernel *kernelPtr = taskInfo->u.aicTaskInfo.kernel;
    uint32_t minStackSize = 0U;
    if (kernelPtr != nullptr) {
        minStackSize = kernelPtr->GetMinStackSize1();
    }
    /* word0-1 */
    if (((kernelInfo->kernelFlag & RT_KERNEL_DUMPFLAG) != 0U) ||
        (stm->IsDebugRegister() && (!stm->GetBindFlag()))) {
        sqe->header.postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    }
    sqe->header.blockDim = kernelInfo->dim;

    /* word2-3 */
    ConfigDieFriendly(taskInfo, sqe, stm);
    sqe->kernelCredit = static_cast<uint8_t>(GetAicoreKernelCredit(taskInfo->u.aicTaskInfo.timeout));
    sqe->mix = 0U;
    sqe->loose = 1U;
    sqe->sqeLength = 0U;

    if ((!stm->GetBindFlag()) && (Runtime::Instance()->GetBiuperfProfFlag())) {
        if (sqe->header.postP == RT_STARS_SQE_INT_DIR_TO_TSCPU) {
            RT_LOG(RT_LOG_WARNING, "post-p has already be set, service scenarios conflict.");
        } else {
            sqe->header.postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            sqe->featureFlag = static_cast<uint8_t>(sqe->featureFlag | SQE_BIZ_FLAG_BIUPERF);
        }
    }

    if ((kernelInfo->kernelFlag & RT_KERNEL_DUMPFLAG) != 0U) {
        if (stm->IsOverflowEnable()) {
            sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
        }
        sqe->featureFlag = static_cast<uint8_t>(sqe->featureFlag | SQE_BIZ_FLAG_DATADUMP);
    }

    if (Runtime::Instance()->GetL2CacheProfFlag()) {
        sqe->header.postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
        sqe->featureFlag = static_cast<uint8_t>(sqe->featureFlag | SQE_BIZ_FLAG_L2CACHE);
    }

    RT_LOG(RT_LOG_INFO, "sqe dieFriendly=%u, blockdim=%u, groupDim=%u, groupBlockDim=%u, featureFlag=%u.",
        sqe->dieFriendly, sqe->header.blockDim, sqe->groupDim, sqe->groupBlockdim, sqe->featureFlag);
    /* word4-5 */
    uint64_t stackPhyBase = RtPtrToValue(stm->Device_()->GetStackPhyBase32k());
    if (unlikely(minStackSize > KERNEL_STACK_SIZE_32K)) {
        stackPhyBase = RtPtrToValue(stm->Device_()->GetCustomerStackPhyBase());
        const uint32_t stackLevel = stm->Device_()->GetDeviceCustomerStackLevel();
        sqe->aicTaskParamPtrHigh = (sqe->aicTaskParamPtrHigh & 0x000FFFFFU) | (stackLevel << 20U);
        sqe->aivTaskParamPtrHigh = (sqe->aivTaskParamPtrHigh & 0x000FFFFFU) | (stackLevel << 20U);
    }
    sqe->stackPhyBaseLow = static_cast<uint32_t>(stackPhyBase);
    sqe->stackPhyBaseHigh = static_cast<uint32_t>(stackPhyBase >> UINT32_BIT_NUM);
    return;
}

template<typename T>
static void ConstructMixSqePart(T * const kernelInfo, RtDavidStarsAicAivKernelSqe * const sqe, uint64_t addr)
{
    /* word11 */
    uint8_t mixType = static_cast<uint8_t>(NO_MIX);
    const uint64_t funcAddr = kernelInfo->funcAddr;
    const uint64_t funcAddr2 = kernelInfo->funcAddr1;
    uint32_t prefetchCnt1 = 0U;
    uint32_t prefetchCnt2 = 0U;
    if (kernelInfo->kernel != nullptr) {
        mixType = kernelInfo->kernel->GetMixType();
        prefetchCnt1 = kernelInfo->kernel->PrefetchCnt1_();
        prefetchCnt2 = kernelInfo->kernel->PrefetchCnt2_();
    }
    sqe->mix = 0U;
    sqe->piMix = 0U;
    sqe->aivSimtDcuSmSize = kernelInfo->simtDcuSmSize;
    switch (mixType) {
        case MIX_AIC:
            /* word6 */
            sqe->aicPmg = 0U;
            sqe->aicPartId = kernelInfo->partId;
            sqe->aicQos = kernelInfo->qos;
            sqe->aicWrrRd = RT_DAVID_AIC_WRR_RD;
            sqe->aicWrrWr = RT_DAVID_AIC_WRR_WR;
            sqe->aicIcachePrefetchCnt = static_cast<uint16_t>(prefetchCnt1);
            sqe->aivIcachePrefetchCnt = 0U;

            /* word7 */
            sqe->aivPmg = 0U;
            sqe->aivPartId = 0U;
            sqe->res4 = 0U;
            sqe->aivQos = 0U;
            sqe->aivWrrRd = 0U;
            sqe->aivWrrWr = 0U;

            /* word8-9 */
            sqe->aicStartPcLow = static_cast<uint32_t>(funcAddr);
            sqe->aivStartPcLow = 0U;

            /* word10 */
            sqe->aicStartPcHigh = static_cast<uint16_t>(funcAddr >> UINT32_BIT_NUM);
            sqe->aivStartPcHigh = 0U;

            sqe->aicTaskParamPtrLow = static_cast<uint32_t>(addr);
            sqe->aicTaskParamPtrHigh = (sqe->aicTaskParamPtrHigh & 0xFFF00000U) | static_cast<uint32_t>(addr >> UINT32_BIT_NUM);
            sqe->aivTaskParamPtrLow = 0U;
            sqe->aivTaskParamPtrHigh = 0U;
            break;
        case MIX_AIV:
            /* word6 */
            sqe->aicPmg = 0U;
            sqe->aicPartId = 0U;
            sqe->aicQos = 0U;
            sqe->aicWrrRd = 0U;
            sqe->aicWrrWr = 0U;
            sqe->aicIcachePrefetchCnt = 0U;
            sqe->aivIcachePrefetchCnt = static_cast<uint16_t>(prefetchCnt1);

            /* word7 */
            sqe->aivPmg = 0U;
            sqe->aivPartId = kernelInfo->partId;
            sqe->res4 = 0U;
            sqe->aivQos = kernelInfo->qos;
            sqe->aivWrrRd = RT_DAVID_AIV_WRR_RD;
            sqe->aivWrrWr = RT_DAVID_AIV_WRR_WR;

            /* word8-9 */
            sqe->aicStartPcLow = 0U;
            sqe->aivStartPcLow = static_cast<uint32_t>(funcAddr);

            /* word10 */
            sqe->aicStartPcHigh = 0U;
            sqe->aivStartPcHigh = static_cast<uint16_t>(funcAddr >> UINT32_BIT_NUM);

            sqe->aicTaskParamPtrLow = 0U;
            sqe->aicTaskParamPtrHigh = 0U;
            sqe->aivTaskParamPtrLow = static_cast<uint32_t>(addr);
            sqe->aivTaskParamPtrHigh = (sqe->aivTaskParamPtrHigh & 0xFFF00000U) | static_cast<uint32_t>(addr >> UINT32_BIT_NUM);
            break;
        case MIX_AIC_AIV_MAIN_AIC:
        case MIX_AIC_AIV_MAIN_AIV:
            sqe->mix = 1U;

            /* word6 */
            sqe->aicPmg = 0U;
            sqe->aicPartId = kernelInfo->partId;
            sqe->piMix = 1U;
            sqe->aicQos = kernelInfo->qos;
            sqe->aicWrrRd = RT_DAVID_AIC_WRR_RD;
            sqe->aicWrrWr = RT_DAVID_AIC_WRR_WR;
            sqe->aicIcachePrefetchCnt = static_cast<uint16_t>(prefetchCnt1);
            sqe->aivIcachePrefetchCnt = static_cast<uint16_t>(prefetchCnt2);

            /* word7 */
            sqe->aivPmg = 0U;
            sqe->aivPartId = kernelInfo->partId;
            sqe->res4 = 0U;
            sqe->aivQos = kernelInfo->qos;
            sqe->aivWrrRd = RT_DAVID_AIV_WRR_RD;
            sqe->aivWrrWr = RT_DAVID_AIV_WRR_WR;

            /* word8-9 */
            sqe->aicStartPcLow = static_cast<uint32_t>(funcAddr & MASK_32_BIT);
            sqe->aivStartPcLow = static_cast<uint32_t>(funcAddr2 & MASK_32_BIT);

            /* word10 */
            sqe->aicStartPcHigh = static_cast<uint16_t>((funcAddr >> UINT32_BIT_NUM) & MASK_32_BIT);
            sqe->aivStartPcHigh = static_cast<uint16_t>((funcAddr2 >> UINT32_BIT_NUM) & MASK_32_BIT);

            sqe->aicTaskParamPtrLow = static_cast<uint32_t>(addr);
            sqe->aicTaskParamPtrHigh = (sqe->aicTaskParamPtrHigh & 0xFFF00000U) | static_cast<uint32_t>(addr >> UINT32_BIT_NUM);
            sqe->aivTaskParamPtrLow = static_cast<uint32_t>(addr);
            sqe->aivTaskParamPtrHigh = (sqe->aivTaskParamPtrHigh & 0xFFF00000U) | static_cast<uint32_t>(addr >> UINT32_BIT_NUM);
            break;
        default:
            RT_LOG(RT_LOG_ERROR, "DavinciKernelTask mix error. ");
            return;
    }
}

template<typename T>
static void ConstructAicSqePart(T * const kernelInfo, RtDavidStarsAicAivKernelSqe * const sqe, uint64_t addr)
{
    const uint64_t funcAddr = kernelInfo->funcAddr;
    uint32_t prefetchCnt1 = 0U;
    if (kernelInfo->kernel != nullptr) {
        prefetchCnt1 = kernelInfo->kernel->PrefetchCnt1_();
    }
    /* word0-1 */
    sqe->header.type = RT_DAVID_SQE_TYPE_AIC;

    /* word6 */
    sqe->aicPmg = 0U;
    sqe->aicPartId = kernelInfo->partId;
    sqe->piMix = 0U;
    sqe->aicQos = kernelInfo->qos;
    sqe->aicWrrRd = RT_DAVID_AIC_WRR_RD;
    sqe->aicWrrWr = RT_DAVID_AIC_WRR_WR;
    sqe->aicIcachePrefetchCnt = static_cast<uint16_t>(prefetchCnt1);
    sqe->aivIcachePrefetchCnt = 0U;

    /* word7 */
    sqe->aivPmg = 0U;
    sqe->aivPartId = 0U;
    sqe->res4 = 0U;
    sqe->aivQos = 0U;
    sqe->aivWrrRd = 0U;
    sqe->aivWrrWr = 0U;
    sqe->schem = static_cast<uint16_t>(kernelInfo->schemMode);
    sqe->ratio = 1U;            // only ratio is 1.
    RT_LOG(RT_LOG_INFO, "set cfgInfo schemMode=%u, ratio=%u", kernelInfo->schemMode, sqe->ratio);

    /* word8-9 */
    sqe->aicStartPcLow = static_cast<uint32_t>(funcAddr);
    sqe->aivStartPcLow = 0U;

    /* word10 */
    sqe->aicStartPcHigh = static_cast<uint16_t>(funcAddr >> UINT32_BIT_NUM);
    sqe->aivStartPcHigh = 0U;

    /* word11-15 */
    sqe->aivSimtDcuSmSize = kernelInfo->simtDcuSmSize;
    sqe->aicTaskParamPtrLow = static_cast<uint32_t>(addr);
    sqe->aicTaskParamPtrHigh = (sqe->aicTaskParamPtrHigh & 0xFFF00000U) | static_cast<uint32_t>(addr >> UINT32_BIT_NUM);
    sqe->aivTaskParamPtrLow = 0U;
    sqe->aivTaskParamPtrHigh = 0U;
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
    ConstructAicSqePart(aicTaskInfo, sqe, addr);

    PrintDavidSqe(command, "AICore Task");
    return;
}

static void ConstructDavidAivSqeForDavinciTask(TaskInfo *taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr)
{
    ConstructDavidCommonSqeForDavinciTask(taskInfo, command, sqBaseAddr);
    RtDavidStarsAicAivKernelSqe *sqe = &(command->aicAivSqe);
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const uint64_t addr = RtPtrToValue(aicTaskInfo->comm.args);
    ConstructAivSqePart(aicTaskInfo, sqe, addr);

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
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    uint8_t taskRation = 0U;
    uint8_t mixType = static_cast<uint8_t>(NO_MIX);
    if (aicTaskInfo->kernel != nullptr) {
        taskRation = static_cast<uint8_t>(aicTaskInfo->kernel->GetTaskRation());
        mixType = aicTaskInfo->kernel->GetMixType();
        Program *programPtr = aicTaskInfo->kernel->Program_();
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
    sqe->schem = static_cast<uint16_t>(aicTaskInfo->schemMode);
    sqe->ratio = 1U;            // only ratio is 1.
    if (sqe->mix == 1U) {
        sqe->ratio = taskRation;    // ratio from elf
        if ((sqe->header.type == RT_DAVID_SQE_TYPE_AIC) && (sqe->ratio == DEFAULT_TASK_RATION)) {
            sqe->loose = 0U;
        }
    }
    RT_LOG(RT_LOG_INFO, "set cfgInfo schemMode=%u, taskType=%u, ratio=%u, mix=%u, loose=%u, piMix=%u, "
        "aivSimtDcuSmSize=%u, featureFlag=0x%x.", aicTaskInfo->schemMode, taskInfo->type, sqe->ratio, sqe->mix, sqe->loose,
        sqe->piMix, sqe->aivSimtDcuSmSize, sqe->featureFlag);

    PrintDavidSqe(command, "MIX Task");

    return;
}

static void ConstructDavidAicAivSqeForDavinciTask(TaskInfo * const taskInfo, rtDavidSqe_t * const command,
    uint64_t sqBaseAddr)
{
    RT_LOG(RT_LOG_INFO, "DavinciKernelTask::ConstructSqe, type=%u.", taskInfo->type);
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

static void ConstructCommonAicAivSubSqe(const TaskInfo* taskInfo, rtDavidSqe_t * const davidSqe)
{
    RtDavidStarsAicAivKernelSqe *sqe = &(davidSqe->aicAivSqe);
    const FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    Stream * const stm = taskInfo->stream;
    ConstructCommonAicAivSqePart(&(fusionKernelTask->aicPart), sqe, taskInfo, stm);
    return;
}

static void ConstructAicSubSqe(const TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe, uint32_t idx, uint64_t sqBaseAddr)
{
    rtDavidSqe_t *sqeAddr = &davidSqe[idx];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + idx;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    ConstructDavidSqeForHeadCommon(taskInfo, sqeAddr);
    ConstructCommonAicAivSubSqe(taskInfo, sqeAddr);

    RtDavidStarsAicAivKernelSqe *sqe = &(sqeAddr->aicAivSqe);
    const FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    const uint64_t addr = RtPtrToValue(fusionKernelTask->args);
    ConstructAicSqePart(&(fusionKernelTask->aicPart), sqe, addr);

    PrintDavidSqe(sqeAddr, "FusionKernelTask-Aic");
    return;
}

static void ConstructAivSubSqe(const TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe, uint32_t idx, uint64_t sqBaseAddr)
{
    rtDavidSqe_t *sqeAddr = &davidSqe[idx];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + idx;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    ConstructDavidSqeForHeadCommon(taskInfo, sqeAddr);
    ConstructCommonAicAivSubSqe(taskInfo, sqeAddr);
    RtDavidStarsAicAivKernelSqe *sqe = &(sqeAddr->aicAivSqe);
    const FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    const uint64_t addr = RtPtrToValue(fusionKernelTask->args);
    ConstructAivSqePart(&(fusionKernelTask->aicPart), sqe, addr);

    PrintDavidSqe(sqeAddr, "FusionKernelTask-Aiv");
    return;
}

static void SetMixStartPcAndParamForFusionKernel(const TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe)
{
    RtDavidStarsAicAivKernelSqe *sqe = &(davidSqe->aicAivSqe);
    const FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    const uint64_t addr = RtPtrToValue(fusionKernelTask->args);
    ConstructMixSqePart(&(fusionKernelTask->aicPart), sqe, addr);
    return;
}

static void ConstructMixSubSqe(const TaskInfo *const taskInfo, rtDavidSqe_t * const davidSqe, uint32_t idx,
    uint64_t sqBaseAddr)
{
    rtDavidSqe_t *sqeAddr = &davidSqe[idx];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + idx;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    ConstructDavidSqeForHeadCommon(taskInfo, sqeAddr);
    ConstructCommonAicAivSubSqe(taskInfo, sqeAddr);

    RtDavidStarsAicAivKernelSqe *sqe = &(sqeAddr->aicAivSqe);
    const FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    const FusionTaskInfoAicPart *aicPart = &(fusionKernelTask->aicPart);
    uint8_t taskRation = 0U;
    uint8_t mixType = static_cast<uint8_t>(NO_MIX);
    if (aicPart->kernel != nullptr) {
        taskRation = static_cast<uint8_t>(aicPart->kernel->GetTaskRation());
        mixType = aicPart->kernel->GetMixType();
    }

    /* word0-1 */
    if ((mixType == static_cast<uint8_t>(MIX_AIC)) || (mixType == static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC))) {
        sqe->header.type = RT_DAVID_SQE_TYPE_AIC;
    } else {
        sqe->header.type = RT_DAVID_SQE_TYPE_AIV;
    }

    SetMixStartPcAndParamForFusionKernel(taskInfo, sqeAddr);

    sqe->schem = static_cast<uint16_t>(aicPart->schemMode);
    sqe->ratio = 1U;            // only ratio is 1.
    if (sqe->mix == 1U) {
        sqe->ratio = taskRation;    // ratio from elf
        if ((sqe->header.type == RT_DAVID_SQE_TYPE_AIC) && (sqe->ratio == DEFAULT_TASK_RATION)) {
            sqe->loose = 0U;
        }
    }
    RT_LOG(RT_LOG_INFO, "sqeIndex=%u, mixType=%u, schemMode=%hu, ratio=%hhu, loose=%u, piMix=%u, "
        "aivSimtDcuSmSize=%u.", idx, mixType, sqe->schem, sqe->ratio, sqe->loose, sqe->piMix,
        sqe->aivSimtDcuSmSize);

    PrintDavidSqe(sqeAddr, "FusionKernelTask-Mix");
    return;
}

static void UpdateHeaderForFusionKernel(const TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe,
    const uint32_t sqeIndex, const uint64_t sqBaseAddr)
{
    rtDavidSqe_t *sqeHeadAddr = &davidSqe[0];
    rtDavidSqe_t *sqeAixAddr = &davidSqe[sqeIndex];
    if (sqBaseAddr != 0ULL) {
        sqeHeadAddr = GetSqPosAddr(sqBaseAddr, static_cast<uint32_t>(taskInfo->id));
        sqeAixAddr = GetSqPosAddr(sqBaseAddr, static_cast<uint32_t>(taskInfo->id) + sqeIndex);
    }
    rtDavidStarsCommonSqe_t *sqeHead = &(sqeHeadAddr->commonSqe);
    RtDavidStarsAicAivKernelSqe *sqeAix = &(sqeAixAddr->aicAivSqe);
    // now only support datadump and overflow
    if ((sqeAix->featureFlag & SQE_BIZ_FLAG_DATADUMP) == 0U) {
        return;
    }
    sqeHead->sqeHeader.preP = sqeAix->header.preP;
    sqeHead->sqeHeader.postP = sqeAix->header.postP;
    PrintDavidSqe(sqeHeadAddr, "FusionKernelTask-FirstSqe");
}

static void ConstructAicAivSubSqe(const TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint32_t &sqeIndex,
    const uint64_t sqBaseAddr)
{
    const FusionTaskInfoAicPart *aicPart = &(taskInfo->u.fusionKernelTask.aicPart);
    const uint8_t mixType = (aicPart->kernel != nullptr) ? aicPart->kernel->GetMixType() : static_cast<uint8_t>(NO_MIX);
    if (mixType != static_cast<uint8_t>(NO_MIX)) {
        ConstructMixSubSqe(taskInfo, davidSqe, sqeIndex, sqBaseAddr);
    } else {
        if (taskInfo->u.fusionKernelTask.aicAivType == 0) {
            ConstructAicSubSqe(taskInfo, davidSqe, sqeIndex, sqBaseAddr);
        } else {
            ConstructAivSubSqe(taskInfo, davidSqe, sqeIndex, sqBaseAddr);
        }
    }
    RT_LOG(RT_LOG_INFO, "sqeIndex=%u, mixType=%hhu, aicAivType=%hhu.", sqeIndex, mixType,
        taskInfo->u.fusionKernelTask.aicAivType);

    UpdateHeaderForFusionKernel(taskInfo, davidSqe, sqeIndex, sqBaseAddr);
    sqeIndex++;
    return;
}

template<typename T>
static void FusionCcuSubSqeCommonInit(const rtCcuTaskInfo_t * const subInfo, const TaskInfo *const taskInfo, uint8_t taskCnt,
    T  const sqe)
{
    const FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    Stream *const stm = taskInfo->stream;

    /* word0-1 */
    sqe->header.type = RT_DAVID_SQE_TYPE_FUSION;
    sqe->header.lock = 0U;
    sqe->header.unlock = 0U;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.preP = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.postP = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wrCqe = stm->GetStarsWrCqeFlag();
    sqe->header.ptrMode = 0U;
    sqe->header.rttMode = 0U;
    sqe->header.headUpdate = 0U;
    sqe->header.reserved = 0U;
    sqe->header.blockDim = 0U;
    sqe->header.rtStreamId = static_cast<uint16_t>(taskInfo->taskSn & 0xFFFFULL);
    sqe->header.taskId = static_cast<uint16_t>((taskInfo->taskSn & 0xFFFF0000ULL) >> UINT16_BIT_NUM);

    /* word2 */
    sqe->taskCnt = taskCnt - 1U;
    sqe->resv.ccuResvDesc1.missionId = subInfo->missionId;
    sqe->resv.ccuResvDesc1.dieId = subInfo->dieId;
    sqe->resv.ccuResvDesc1.res1 = 0U;
    sqe->resv.ccuResvDesc1.aic = fusionKernelTask->aicAivType;
    sqe->resv.ccuResvDesc1.subType = fusionKernelTask->sqeSubType;
    sqe->resv.ccuResvDesc1.ccuSize = (sqe->taskCnt == 0U) ? 0U : 1U;

    /* word3 */
    sqe->sqeLength = fusionKernelTask->sqeLen - 1U;
    sqe->kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;
    sqe->timeout = subInfo->timeout;
    sqe->res4 = 0U;

    /* word4-5 */
    sqe->instStartId = subInfo->instStartId;
    sqe->instCnt = subInfo->instCnt;
    sqe->instAddrKeyValue = subInfo->key;

    return;
}

static rtError_t ConstructCcuSubSqeFor128B(const rtCcuTaskInfo_t * const subInfo, rtDavidSqe_t * const davidSqe,
    const TaskInfo * const taskInfo, uint32_t &sqeIndex, uint8_t taskCnt, uint64_t sqBaseAddr)
{
    rtDavidSqe_t *sqeAddr = &davidSqe[sqeIndex];
    uint32_t pos = taskInfo->id + sqeIndex;
    if (sqBaseAddr != 0ULL) {
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    RtDavidStarsCcuSqe * const sqe = &(sqeAddr->ccuSqe);
    FusionCcuSubSqeCommonInit(subInfo, taskInfo, taskCnt, sqe);

    /* word6-15 memcpy, 10*4=40B */
    constexpr size_t firstCpySize = sizeof(uint32_t) * 10ULL;
    errno_t ret = memcpy_s(RtPtrToPtr<uint8_t *>(sqe) + sizeof(rtDavidSqe_t)-firstCpySize, firstCpySize,
        RtPtrToPtr<const uint8_t *>(subInfo->args), firstCpySize);
    COND_RETURN_OUT_ERROR_MSG_CALL(ret != EOK, RT_ERROR_SEC_HANDLE, "Memcpy_s part1 failed,retCode=%d,"
        " size=%zu.", ret, firstCpySize);

    /* second ccu sqe part: 16*4=64 Byte */
    constexpr size_t secondCpySize = sizeof(rtDavidSqe_t);
    rtDavidSqe_t *sqeAddr1 = davidSqe + sqeIndex + 1U;
    if (sqBaseAddr != 0ULL) {
        pos = taskInfo->id + sqeIndex + 1U;
        sqeAddr1 = GetSqPosAddr(sqBaseAddr, pos);
    }

    ret = memcpy_s(sqeAddr1, sizeof(rtDavidSqe_t),
        (RtPtrToPtr<const uint8_t *>(&(subInfo->args[firstCpySize/8U]))), secondCpySize);
    COND_RETURN_OUT_ERROR_MSG_CALL(ret != EOK, RT_ERROR_SEC_HANDLE, "Memcpy_s part2 failed, retCode=%d,"
        " size=%zu.", ret, secondCpySize);

    RT_LOG(RT_LOG_INFO, "taskIdx=%d, sqeIndex=%u, missionId=%hhu, dieId=%hhu, instStartId=%hd, instCnt=%hu,"
        "instAddrKeyValue=%u.", taskInfo->id, sqeIndex, subInfo->missionId, subInfo->dieId, subInfo->instStartId,
        subInfo->instCnt, subInfo->key);

    PrintDavidSqe(sqeAddr,  "128B FusionKernelTask-Ccu-1part");
    PrintDavidSqe(sqeAddr1,  "128B FusionKernelTask-Ccu-2part");

    sqeIndex += 2U;
    return RT_ERROR_NONE;
}

static rtError_t ConstructCcuSubSqeFor32B(const rtCcuTaskInfo_t * const subInfo, rtDavidSqe_t * const davidSqe,
    const TaskInfo * const taskInfo, uint32_t sqeIndex, uint32_t idx, uint8_t taskCnt, uint64_t sqBaseAddr)
{
    rtDavidSqe_t *sqeAddr = &davidSqe[sqeIndex];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + sqeIndex;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    /* word6-7 memcpy, 2*4=8B */
    constexpr uint8_t cpySize = sizeof(uint32_t) * 2;
    constexpr int32_t moveSize = static_cast<int32_t>(sizeof(RtDavidStarsCcuSqe32B) - cpySize);

    RtDavidStarsCcuSqe32B * const sqe = &(sqeAddr->ccuSqe32B[idx]);
    FusionCcuSubSqeCommonInit(subInfo, taskInfo, taskCnt, sqe);

    const errno_t ret = memcpy_s(RtPtrToPtr<uint8_t *>(sqe) + moveSize, cpySize, subInfo->args, cpySize);
    COND_RETURN_OUT_ERROR_MSG_CALL(ret != EOK, RT_ERROR_SEC_HANDLE, "Memcpy_s failed,retCode=%d, Size=%d(bytes).",
        ret, cpySize);

    RT_LOG(RT_LOG_INFO, "taskIdx=%u, sqeIndex=%u, missionId=%hhu, dieId=%hhu, instStartId=%hu, instCnt=%hu,"
        "instAddrKeyValue=%u.", taskInfo->id, sqeIndex, subInfo->missionId, subInfo->dieId, subInfo->instStartId,
        subInfo->instCnt, subInfo->key);

    PrintDavidSqe(sqeAddr, "32B FusionKernelTask-Ccu", sizeof(RtDavidStarsCcuSqe32B));
    return RT_ERROR_NONE;
}

static rtError_t ConstructCcuSubSqe(const TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint32_t &sqeIndex,
    const uint32_t taskIdx, const uint64_t sqBaseAddr)
{
    rtError_t error = RT_ERROR_NONE;
    const FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    rtFunsionTaskInfo_t * const fusionKernelInfo =
        static_cast<rtFunsionTaskInfo_t *>(const_cast<void *>(fusionKernelTask->fusionKernelInfo));
    rtCcuTaskGroup_t * const ccuInfo = &(fusionKernelInfo->subTask[taskIdx].task.ccuInfo);

    // 双die num奇数返错 0x18 -> 11000
    const bool isDoubleDie = (fusionKernelTask->sqeSubType & 0x18U) == 0x18U ? true : false;
    const uint8_t taskNum = static_cast<uint8_t>(ccuInfo->taskNum);
    const uint8_t taskCnt = isDoubleDie ? taskNum / 2U : taskNum;

    if (ccuInfo->ccuTaskInfo[0].argSize == RT_CCU_SQE32B_ARGS_SIZE) {
        uint32_t taskNum32B = ccuInfo->taskNum;
        const bool isOddNum = (taskNum32B % 2U == 1U);
        taskNum32B = isOddNum ? (taskNum32B - 1U) : taskNum32B;
        for (uint32_t i = 0U; i < taskNum32B; i += TASK_SQE_NUM_TWO) {
            error = ConstructCcuSubSqeFor32B(&(ccuInfo->ccuTaskInfo[i]), davidSqe, taskInfo, sqeIndex, 0, taskCnt,
                                             sqBaseAddr);
            ERROR_RETURN(error, "ConstructCcuSubSqeFor32B failed.");
            error = ConstructCcuSubSqeFor32B(&(ccuInfo->ccuTaskInfo[i + 1U]), davidSqe, taskInfo, sqeIndex, 1, taskCnt,
                                             sqBaseAddr);
            ERROR_RETURN(error, "ConstructCcuSubSqeFor32B failed.");
            sqeIndex += 1U;
        }
        // 32B sqe 是单数
        if (isOddNum) {
            error = ConstructCcuSubSqeFor32B(&(ccuInfo->ccuTaskInfo[taskNum]), davidSqe, taskInfo, sqeIndex, 0,
                                             taskCnt, sqBaseAddr);
            ERROR_RETURN(error, "ConstructCcuSubSqeFor32B failed.");
        }
    } else {
        for (uint32_t i = 0;i < ccuInfo->taskNum; i++) {
            error = ConstructCcuSubSqeFor128B(&(ccuInfo->ccuTaskInfo[i]), davidSqe, taskInfo, sqeIndex, taskCnt,
                                              sqBaseAddr);
            ERROR_RETURN(error, "ConstructCcuSubSqeFor128B failed.");
        }
    }
    sqeIndex = 4U;
    return error;
}

static void ConstructDavidSqeForFusionKernelTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    rtError_t error = RT_ERROR_NONE;
    FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    rtFunsionTaskInfo_t * const fusionKernelInfo =
        static_cast<rtFunsionTaskInfo_t *>(fusionKernelTask->fusionKernelInfo);
    uint32_t aicpuIndex = 0U;
    uint32_t sqeIndex = 0U;

    for (uint32_t idx = 0U; idx < fusionKernelInfo->subTaskNum; idx++) {
        switch (fusionKernelInfo->subTask[idx].type) {
            case RT_FUSION_AICORE:
                ConstructAicAivSubSqe(taskInfo, davidSqe, sqeIndex, sqBaseAddr);
                break;
            case RT_FUSION_AICPU:
            case RT_FUSION_HCOM_CPU:
                ConstructAicpuSubSqe(taskInfo, davidSqe, sqeIndex, aicpuIndex, idx, sqBaseAddr);
                aicpuIndex++;
                break;
            case RT_FUSION_CCU:
                error = ConstructCcuSubSqe(taskInfo, davidSqe, sqeIndex, idx, sqBaseAddr);
                break;
            default:
                // do nothing
                break;
        }
        if (error != RT_ERROR_NONE) {
            davidSqe->commonSqe.sqeHeader.type = RT_DAVID_SQE_TYPE_INVALID;
            RT_LOG(RT_LOG_ERROR, "Fusion kernel sqe proc failed, ret=%#x.", error);
        }
    }
    RT_LOG(RT_LOG_INFO, "FusionTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, sub_type=%hhu.",
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id, taskInfo->taskSn,
        fusionKernelTask->sqeSubType);
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

    sqe->qos = stm->Device_()->GetTsdQos();
    sqe->res2 = 0U;
    sqe->sqeIndex = 0U; // useless
    sqe->kernelCredit = RT_STARS_DEFAULT_AICPU_KERNEL_CREDIT;

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
}

}  // namespace runtime
}  // namespace cce
