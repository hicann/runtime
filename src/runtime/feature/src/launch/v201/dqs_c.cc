/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dqs_c.hpp"

#include "task_david.hpp"
#include "error_message_manage.hpp"
#include "inner_thread_local.hpp"
#include "stream_with_dqs.hpp"
#include "dqs_task_info.hpp"
#include "tsch_cmd.h"
#include "ioctl_utils.hpp"

namespace cce {
namespace runtime {

constexpr uint8_t ADSPC_CQE_SIZE = 32U;
constexpr uint8_t ADSPC_CQ_DEPTH = 8U;

using DqsTaskInitFunc = rtError_t (*)(TaskInfo *taskInfo, const Stream * const stream, const DqsTaskConfig * const cfg);
using DqsInterChipTaskInitFunc = rtError_t (*)(TaskInfo *, const uint32_t, const DqsInterChipTaskType);
using DqsLaunchTaskFunc = rtError_t (*)(Stream* const, const rtDqsTaskCfg_t *const);

struct DqsTaskInitInfo {
    const char_t *taskDesc;
    DqsTaskInitFunc taskInitFunc;
};

struct DqsInterChipTaskInitInfo {
    const char_t *taskDesc;
    DqsInterChipTaskInitFunc taskInitFunc;
};

static std::map<rtDqsTaskType, DqsTaskInitInfo> DQS_TASK_INIT_FUNC = {
    {RT_DQS_TASK_DEQUEUE,        {"dqs dequeue task",         &DqsDequeueTaskInit }},
    {RT_DQS_TASK_ENQUEUE,        {"dqs enqueue task ",        &DqsEnqueueTaskInit }},
    {RT_DQS_TASK_ZERO_COPY,      {"dqs zero copy task",       &DqsZeroCopyTaskInit}},
    {RT_DQS_TASK_FREE,           {"dqs mbuf free task",       &DqsMbufFreeTaskInit}},
    {RT_DQS_TASK_SCHED_END,      {"dqs sched end task",       &DqsSchedEndTaskInit}},
    {RT_DQS_TASK_PREPARE_OUT,    {"dqs prepare out task",     &DqsPrepareTaskInit }},
    {RT_DQS_TASK_ADSPC,          {"dqs adspc task",           &DqsAdspcTaskInit   }},
    {RT_DQS_TASK_CONDITION_COPY, {"dqs condition copy task",  &DqsConditionCopyTaskInit}},
    {RT_DQS_TASK_FRAME_ALIGN,    {"dqs frame align task",     &DqsFrameAlignTaskInit}},
};

static std::map<DqsInterChipTaskType, DqsInterChipTaskInitInfo> DQS_INTER_CHIP_TASK_INIT_FUNC = {
    {DqsInterChipTaskType::DQS_INTER_CHIP_TASK_PREPROC,
        {"dqs inter-chip pre-proc task", &DqsInterChipPreProcTaskInit}},
    {DqsInterChipTaskType::DQS_INTER_CHIP_TASK_MEMCPY_MBUF_HEAD,
        {"dqs inter-chip memcpy mbuf head task", &DqsInterChipMemcpyTaskInit}},
    {DqsInterChipTaskType::DQS_INTER_CHIP_TASK_MEMCPY_MBUF_DATA,
        {"dqs inter-chip memcpy mbuf data task", &DqsInterChipMemcpyTaskInit}},
    {DqsInterChipTaskType::DQS_INTER_CHIP_TASK_POSTPROC,
        {"dqs inter-chip post-proc task", &DqsInterChipPostProcTaskInit}},
};

static inline rtError_t GetDqsTaskInitInfo(const rtDqsTaskType type, DqsTaskInitInfo **taskInitInfo)
{
    const auto iter = DQS_TASK_INIT_FUNC.find(type);
    COND_RETURN_ERROR_MSG_INNER(iter == DQS_TASK_INIT_FUNC.end(), RT_ERROR_INVALID_VALUE,
        "type[%d] is invalid", type);

    *taskInitInfo = &(iter->second);

    return RT_ERROR_NONE;
}

static inline rtError_t GetDqsInterChipTaskInitInfo(const DqsInterChipTaskType type, DqsInterChipTaskInitInfo **taskInitInfo)
{
    const auto iter = DQS_INTER_CHIP_TASK_INIT_FUNC.find(type);
    COND_RETURN_ERROR_MSG_INNER(iter == DQS_INTER_CHIP_TASK_INIT_FUNC.end(), RT_ERROR_INVALID_VALUE,
        "type[%d] is invalid", static_cast<int32_t>(type));

    *taskInitInfo = &(iter->second);

    return RT_ERROR_NONE;
}

static void RollbackAndRecycle(TaskInfo *task, Stream * const stm, uint32_t pos)
{
    TaskUnInitProc(task);
    TaskRollBack(stm, pos);
    stm->StreamUnLock();
 
    return;
}

static rtError_t SendAccSubscribeInfo(StreamWithDqs * const streamWithDqs, const uint8_t queNum, uint32_t notifyId, const uint16_t *queIdArray, bool isCntNotify)
{
    stars_ioctl_cmd_args_t args = {};
    stars_queue_subscribe_acc_param_t param = {};
    param.op_type = 0U;  // create
    param.ts_id = static_cast<uint8_t>(streamWithDqs->Device_()->DevGetTsId());
    param.stream_id = static_cast<uint8_t>(streamWithDqs->Id_());
    param.count = queNum;
    if (isCntNotify) {
        for (uint32_t i = 0U; i < queNum; i++) {
            param.notify_list[i].queue_id = *(queIdArray + i);
            param.notify_list[i].notify_id = static_cast<uint16_t>(notifyId);
        }
    } else {
        param.notify_list[0].queue_id = *queIdArray;
        param.notify_list[0].notify_id = static_cast<uint16_t>(notifyId);
    }

    args.input_ptr = &param;
    args.input_len = sizeof(stars_queue_subscribe_acc_param_t);
    args.output_len = 0U;

    const rtError_t error = IoctlUtil::GetInstance().IoctlByCmd(STARS_IOCTL_CMD_ACC_SUBSCRIBE_QUEUE, &args);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "ioctl failed, cmd=%#x, retCode=%#x",
        STARS_IOCTL_CMD_ACC_SUBSCRIBE_QUEUE, static_cast<uint32_t>(error));
    streamWithDqs->SetAccSubInfo(param);
    RT_LOG(RT_LOG_INFO, "ioctl success, cmd=%#x", STARS_IOCTL_CMD_ACC_SUBSCRIBE_QUEUE);

    return RT_ERROR_NONE;
}

static rtError_t DqsNotifyWaitCreate(StreamWithDqs * const streamWithDqs, bool &createdFlag)
{
    rtError_t error = RT_ERROR_NONE;
    NULL_PTR_RETURN(streamWithDqs, RT_ERROR_INVALID_VALUE);

    Notify *notify = RtPtrToUnConstPtr<Notify *>(streamWithDqs->GetDqsNotify());
    if (notify == nullptr) {
        notify = new (std::nothrow) Notify(streamWithDqs->Device_()->Id_(), streamWithDqs->Device_()->DevGetTsId());
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, notify == nullptr, RT_ERROR_NOTIFY_NEW,
            "Notify create failed, new notify failed.");

        notify->SetNotifyFlag(RT_NOTIFY_DEFAULT);
        error = notify->Setup();
        ERROR_PROC_RETURN_MSG_INNER(error, DELETE_O(notify);,
             "Notify setup failed, retCode=%#x.", static_cast<uint32_t>(error));

        error = NtyWait(notify, streamWithDqs, MAX_UINT32_NUM);
        ERROR_PROC_RETURN_MSG_INNER(error, DELETE_O(notify); streamWithDqs->SetDqsNotify(nullptr);,
            "Notify wait failed, retCode=%#x.", static_cast<uint32_t>(error));

        streamWithDqs->SetDqsNotify(notify);
    } else {
        createdFlag = true;
    }
    
    return error;
}

static rtError_t DqsCountNotifyWaitCreate(StreamWithDqs * const streamWithDqs, bool &createdFlag)
{
    rtError_t error = RT_ERROR_NONE;
    NULL_PTR_RETURN(streamWithDqs, RT_ERROR_INVALID_VALUE);

    CountNotify *cntNotify = RtPtrToUnConstPtr<CountNotify *>(streamWithDqs->GetDqsCountNotify());
    if (cntNotify == nullptr) {
        cntNotify = new (std::nothrow) CountNotify(streamWithDqs->Device_()->Id_(), streamWithDqs->Device_()->DevGetTsId());
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, cntNotify == nullptr, RT_ERROR_NOTIFY_NEW,
            "Count Notify create failed, new Count Notify failed.");

        cntNotify->SetNotifyFlag(RT_NOTIFY_DEFAULT);
        error = cntNotify->Setup();
        ERROR_PROC_RETURN_MSG_INNER(error, DELETE_O(cntNotify);,
            "Count Notify setup failed, retCode=%#x.", static_cast<uint32_t>(error));

        rtCntNtyWaitInfo_t winfo = {WAIT_BIGGER_MODE, 0U, UINT32_MAX, false, {0U, 0U, 0U}};
        error = cntNotify->Wait(streamWithDqs, &winfo);
        ERROR_PROC_RETURN_MSG_INNER(error, DELETE_O(cntNotify); streamWithDqs->SetDqsCountNotify(nullptr);,
            "Count Notify wait failed, retCode=%#x.", static_cast<uint32_t>(error));

        streamWithDqs->SetDqsCountNotify(cntNotify);
    } else {
        createdFlag = true;
    }

    return error;
}

static rtError_t DqsNotifyWait(Stream * const stm)
{
    rtError_t error;
    StreamWithDqs *streamWithDqs = dynamic_cast<StreamWithDqs *>(stm);
    NULL_PTR_RETURN(streamWithDqs, RT_ERROR_INVALID_VALUE);

    stars_dqs_ctrl_space_t *ctrlSpacePtr = streamWithDqs->GetDqsCtrlSpace();
    NULL_PTR_RETURN_MSG(ctrlSpacePtr, RT_ERROR_INVALID_VALUE);
    const uint8_t queNum = ctrlSpacePtr->input_queue_num;
    if ((queNum == 0U) || (queNum > RT_DQS_MAX_INPUT_QUEUE_NUM)) {
        RT_LOG(RT_LOG_ERROR, "invalid acc subscribe count(%u), should be (0, %u]", queNum, RT_DQS_MAX_INPUT_QUEUE_NUM);
        return RT_ERROR_INVALID_VALUE;
    }

    uint32_t notifyId = 0U;
    bool isCntNotify =false;
    bool createdFlag = false;

    if (queNum > 1U) {
        isCntNotify = true;
        error = DqsCountNotifyWaitCreate(streamWithDqs, createdFlag);
        ERROR_RETURN_MSG_INNER(error, "dqs cnt notify wait failed, retCode=%#x.", static_cast<uint32_t>(error));
        CountNotify *cntNotify = RtPtrToUnConstPtr<CountNotify *>(streamWithDqs->GetDqsCountNotify());
        notifyId = cntNotify->GetCntNotifyId();
    } else {
        error = DqsNotifyWaitCreate(streamWithDqs, createdFlag);
        ERROR_RETURN_MSG_INNER(error, "dqs notify wait failed, retCode=%#x.", static_cast<uint32_t>(error));
        Notify *notify = RtPtrToUnConstPtr<Notify *>(streamWithDqs->GetDqsNotify());
        notifyId = notify->GetNotifyId();
    }

    if (createdFlag == false) {
        // send notifyId and queId to kernel space
        error = SendAccSubscribeInfo(streamWithDqs, queNum, notifyId, ctrlSpacePtr->input_queue_ids, isCntNotify);
        ERROR_RETURN_MSG_INNER(error, "send stars ioctl failed, retCode=%#x.", static_cast<uint32_t>(error));
    }

    return RT_ERROR_NONE;
}

static rtError_t LaunchDqsTaskByType(const rtDqsTaskType type, Stream * const stm, const DqsTaskConfig * const cfg = nullptr)
{
    DqsTaskInitInfo *taskInitInfo = nullptr;
    rtError_t error = GetDqsTaskInitInfo(type, &taskInitInfo);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) || (taskInitInfo == nullptr), error,
        "get dqs task init info failed, retCode=%#x", static_cast<uint32_t>(error));

    const int32_t streamId = stm->Id_();
    RT_LOG(RT_LOG_INFO, "[%s], streamId=%d.", taskInitInfo->taskDesc, streamId);
    TaskInfo *task = nullptr;
    error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "streamId=%d check failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    uint32_t pos = RT_DEFAULT_POS;
    stm->StreamLock();
    error = AllocTaskInfo(&task, stm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();,
        "streamId=%d alloc [%s] failed, retCode=%#x.", streamId, taskInitInfo->taskDesc, static_cast<uint32_t>(error));
 
    SaveTaskCommonInfo(task, stm, pos);

    error = taskInitInfo->taskInitFunc(task, stm, cfg);
    ERROR_PROC_RETURN_MSG_INNER(error, RollbackAndRecycle(task, stm, pos),
        "[%s] init failed, streamId=%d, retCode=%#x.", taskInitInfo->taskDesc, streamId, static_cast<uint32_t>(error));
 
    error = DavidSendTask(task, stm);
    ERROR_PROC_RETURN_MSG_INNER(error, RollbackAndRecycle(task, stm, pos),
        "[%s] submit failed, streamId=%d, retCode=%#x.", taskInitInfo->taskDesc, streamId, static_cast<uint32_t>(error));
    stm->StreamUnLock();
 
    SET_THREAD_TASKID_AND_STREAMID(streamId, task->taskSn);
 
    return error;
}

static rtError_t LaunchDqsInterChipTaskByType(Stream *const stm, const uint32_t blockIdx, const DqsInterChipTaskType type)
{
    DqsInterChipTaskInitInfo *taskInitInfo = nullptr;
    rtError_t error = GetDqsInterChipTaskInitInfo(type, &taskInitInfo);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) || (taskInitInfo == nullptr), error,
        "get dqs task init info failed, retCode=%#x", static_cast<uint32_t>(error));

    const int32_t streamId = stm->Id_();
    RT_LOG(RT_LOG_INFO, "[%s], streamId=%d.", taskInitInfo->taskDesc, streamId);
    TaskInfo *task = nullptr;
    error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "streamId=%d check failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    uint32_t pos = RT_DEFAULT_POS;
    stm->StreamLock();
    error = AllocTaskInfo(&task, stm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();,
        "streamId=%d alloc [%s] failed, retCode=%#x.", streamId, taskInitInfo->taskDesc, static_cast<uint32_t>(error));
 
    SaveTaskCommonInfo(task, stm, pos);
 
    error = taskInitInfo->taskInitFunc(task, blockIdx, type);
    ERROR_PROC_RETURN_MSG_INNER(error, RollbackAndRecycle(task, stm, pos),
        "[%s] init failed, streamId=%d, retCode=%#x.", taskInitInfo->taskDesc, streamId, static_cast<uint32_t>(error));
 
    error = DavidSendTask(task, stm);
    ERROR_PROC_RETURN_MSG_INNER(error, RollbackAndRecycle(task, stm, pos),
        "[%s] submit failed, streamId=%d, retCode=%#x.", taskInitInfo->taskDesc, streamId, static_cast<uint32_t>(error));
    stm->StreamUnLock();
 
    SET_THREAD_TASKID_AND_STREAMID(streamId, task->taskSn);
 
    return error;
}

static rtError_t InterChipDqsTaskInit(Stream* const stream)
{
    rtError_t result = RT_ERROR_NONE;
    RT_LOG(RT_LOG_INFO, "Init inter-chip dqs tasks for streamId: %d", stream->Id_());

    for (uint32_t groupIdx = 0U; groupIdx < DQS_INTER_CHIP_GROUP_MAX; groupIdx++) {
        result = LaunchDqsInterChipTaskByType(stream, groupIdx, DqsInterChipTaskType::DQS_INTER_CHIP_TASK_PREPROC);
        ERROR_RETURN(result, "Init pre-proc task failed for groupIdx=%u, ret=%#x",
            groupIdx, static_cast<uint32_t>(result));

        result = LaunchDqsInterChipTaskByType(stream, groupIdx, DqsInterChipTaskType::DQS_INTER_CHIP_TASK_MEMCPY_MBUF_HEAD);
        ERROR_RETURN(result, "Init memcpy head task failed for groupIdx=%u, ret=%#x",
            groupIdx, static_cast<uint32_t>(result));

        result = LaunchDqsInterChipTaskByType(stream, groupIdx, DqsInterChipTaskType::DQS_INTER_CHIP_TASK_MEMCPY_MBUF_DATA);
        ERROR_RETURN(result, "Init memcpy data task failed for groupIdx=%u, ret=%#x",
            groupIdx, static_cast<uint32_t>(result));

        result = LaunchDqsInterChipTaskByType(stream, groupIdx, DqsInterChipTaskType::DQS_INTER_CHIP_TASK_POSTPROC);
        ERROR_RETURN(result, "Init post-proc task task failed for groupIdx=%u, ret=%#x",
            groupIdx, static_cast<uint32_t>(result));
    }

    RT_LOG(RT_LOG_INFO, "Init inter-chip dqs tasks successfully for streamId: %d", stream->Id_());
    return RT_ERROR_NONE;
}

static rtError_t DqsTaskSchedConfig(const rtDqsSchedCfg_t * const cfg, Stream * const stm)
{
    StreamWithDqs *streamWithDqs = dynamic_cast<StreamWithDqs *>(stm);
    NULL_PTR_RETURN(streamWithDqs, RT_ERROR_INVALID_VALUE);
    const rtError_t ret = streamWithDqs->SetDqsSchedCfg(cfg);
    ERROR_RETURN(ret, "set stream ctrl space info failed, ret=%#x.", static_cast<uint32_t>(ret));

    return RT_ERROR_NONE;
}

// task cfg check
static rtError_t DqsSchedConfigCheck(const rtDqsSchedCfg_t *const cfg)
{
    // type check
    const uint8_t type = cfg->type;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        (type != RT_DQS_SCHED_TYPE_DSS) && (type != RT_DQS_SCHED_TYPE_NN) && (type != RT_DQS_SCHED_TYPE_VPC),
        RT_ERROR_INVALID_VALUE, type, "[1, 3]");

    // inputQueueNum check
    const uint8_t inQueNum = cfg->inputQueueNum;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        (inQueNum <= 0U) || (inQueNum > RT_DQS_MAX_INPUT_QUEUE_NUM), 
        RT_ERROR_INVALID_VALUE, inQueNum, "(0, " + std::to_string(RT_DQS_MAX_INPUT_QUEUE_NUM) +"]");

    //outputQueueNum check
    const uint8_t outQueNum = cfg->outputQueueNum;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        (type != RT_DQS_SCHED_TYPE_DSS) && ((outQueNum <= 0U) || (outQueNum > RT_DQS_MAX_OUTPUT_QUEUE_NUM)),
        RT_ERROR_INVALID_VALUE, outQueNum, "(0, " + std::to_string(RT_DQS_MAX_OUTPUT_QUEUE_NUM) +"]");    

    return RT_ERROR_NONE;
}
 
static rtError_t DqsZeroCopyTaskCfgCheck(const rtDqsZeroCopyCfg_t *const cfg)
{
    const rtDqsZeroCopyType copyType = cfg->copyType;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        (copyType != RT_DQS_ZERO_COPY_INPUT) && (copyType != RT_DQS_ZERO_COPY_OUTPUT),
        RT_ERROR_INVALID_VALUE, copyType, "[0, 1]");

    const rtDqsZeroCopyAddrOrderType copyOrderType = cfg->cpyAddrOrder;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        (copyOrderType != RT_DQS_ZERO_COPY_ADDR_ORDER_LOW32_FIRST) &&
        (copyOrderType != RT_DQS_ZERO_COPY_ADDR_ORDER_HIGH32_FIRST),
        RT_ERROR_INVALID_VALUE, copyOrderType, "[0, 1]");
    
    ZERO_RETURN_AND_MSG_OUTER(cfg->count)
    NULL_PTR_RETURN_MSG_OUTER(cfg->dest, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(cfg->offset, RT_ERROR_INVALID_VALUE);

    return RT_ERROR_NONE;
}
 
static rtError_t DqsAdspcTaskCfgCheck(const rtDqsAdspcTaskCfg_t *const cfg)
{
    NULL_PTR_RETURN_MSG_OUTER(cfg, RT_ERROR_INVALID_VALUE);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(cfg->cqeSize != ADSPC_CQE_SIZE, RT_ERROR_INVALID_VALUE, 
        cfg->cqeSize, std::to_string(ADSPC_CQE_SIZE));

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(cfg->cqDepth != ADSPC_CQ_DEPTH, RT_ERROR_INVALID_VALUE, 
        cfg->cqDepth, std::to_string(ADSPC_CQ_DEPTH));

    ZERO_RETURN_AND_MSG_OUTER(cfg->cqeBaseAddr);
    ZERO_RETURN_AND_MSG_OUTER(cfg->cqeCopyAddr);

    ZERO_RETURN_AND_MSG_OUTER(cfg->cqHeadRegAddr);
    ZERO_RETURN_AND_MSG_OUTER(cfg->cqTailRegAddr);

    return RT_ERROR_NONE;
}

static rtError_t DqsConditionCopyTaskCfgCheck(const rtDqsConditionCopyCfg_t *const cfg)
{
    NULL_PTR_RETURN_MSG_OUTER(cfg, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(cfg->condition, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(cfg->dst, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(cfg->src, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_MSG(cfg->cnt);

    COND_RETURN_ERROR_MSG_INNER((RtPtrToValue(cfg->dst) % 8ULL) != 0ULL,
        RT_ERROR_INVALID_VALUE, "dstAddr must be 8-byte aligned, actual dstAddr=%p", cfg->dst);
    COND_RETURN_ERROR_MSG_INNER((RtPtrToValue(cfg->src) % 8ULL) != 0ULL,
        RT_ERROR_INVALID_VALUE, "srcAddr must be 8-byte aligned, actual srcAddr=%p", cfg->src);
    COND_RETURN_ERROR_MSG_INNER((cfg->cnt % 8ULL) != 0ULL,
        RT_ERROR_INVALID_VALUE, "cnt must be 8-byte aligned, actual cnt=%" PRIu64 " bytes", cfg->cnt);
    COND_RETURN_ERROR_MSG_INNER((cfg->cnt > cfg->destMax),
        RT_ERROR_INVALID_VALUE, "cnt (%" PRIu64 " bytes) exceeds destination buffer capacity (%" PRIu64 " bytes)",
        cfg->cnt, cfg->destMax);
    COND_RETURN_ERROR_MSG_INNER((cfg->cnt > DQS_CONDITION_COPY_SIZE_MAX),
        RT_ERROR_INVALID_VALUE, "cnt (%" PRIu64 " bytes) exceeds maximum limit (%" PRIu64 " bytes)",
        cfg->cnt, DQS_CONDITION_COPY_SIZE_MAX);

    return RT_ERROR_NONE;
}

static rtError_t DqsLaunchSchedConfig(Stream * const stm, const rtDqsTaskCfg_t *const taskCfg)
{
    NULL_PTR_RETURN_MSG_OUTER(taskCfg->cfg, RT_ERROR_INVALID_VALUE);
    const rtError_t ret = DqsSchedConfigCheck(RtPtrToPtr<rtDqsSchedCfg_t *>(taskCfg->cfg));
    COND_RETURN_WITH_NOLOG(ret != RT_ERROR_NONE, ret);

    return DqsTaskSchedConfig(RtPtrToPtr<const rtDqsSchedCfg_t *>(taskCfg->cfg), stm);
}

static rtError_t DqsLaunchZeroCopyTask(Stream * const stm, const rtDqsTaskCfg_t *const taskCfg)
{
    NULL_PTR_RETURN_MSG_OUTER(taskCfg->cfg, RT_ERROR_INVALID_VALUE);
    const DqsTaskConfig dqsTaskCfg = { .zeroCopyCfg = RtPtrToPtr<rtDqsZeroCopyCfg_t *>(taskCfg->cfg) };
    const rtError_t ret = DqsZeroCopyTaskCfgCheck(dqsTaskCfg.zeroCopyCfg);
    COND_RETURN_WITH_NOLOG(ret != RT_ERROR_NONE, ret);

    return LaunchDqsTaskByType(taskCfg->type, stm, &dqsTaskCfg);
}

static rtError_t DqsLaunchAdspcTask(Stream * const stm, const rtDqsTaskCfg_t *const taskCfg)
{
    NULL_PTR_RETURN_MSG_OUTER(taskCfg->cfg, RT_ERROR_INVALID_VALUE);
    const DqsTaskConfig dqsTaskCfg = { .adspcCfg = RtPtrToPtr<rtDqsAdspcTaskCfg_t *>(taskCfg->cfg) };
    const rtError_t ret = DqsAdspcTaskCfgCheck(dqsTaskCfg.adspcCfg);
    COND_RETURN_WITH_NOLOG(ret != RT_ERROR_NONE, ret);

    return LaunchDqsTaskByType(taskCfg->type, stm, &dqsTaskCfg);
}

static rtError_t DqsLaunchConditionCopyTask(Stream * const stm, const rtDqsTaskCfg_t *const taskCfg)
{
    NULL_PTR_RETURN_MSG_OUTER(taskCfg->cfg, RT_ERROR_INVALID_VALUE);
    const DqsTaskConfig dqsTaskCfg = { .condCopyCfg = RtPtrToPtr<rtDqsConditionCopyCfg_t *>(taskCfg->cfg) };
    const rtError_t ret = DqsConditionCopyTaskCfgCheck(dqsTaskCfg.condCopyCfg);
    COND_RETURN_WITH_NOLOG(ret != RT_ERROR_NONE, ret);

    return LaunchDqsTaskByType(taskCfg->type, stm, &dqsTaskCfg);
}

static rtError_t DqsLaunchNotifyWaitTask(Stream * const stm, const rtDqsTaskCfg_t *const taskCfg)
{
    UNUSED(taskCfg);
    return DqsNotifyWait(stm);
}

static rtError_t DqsLaunchCommonTask(Stream * const stm, const rtDqsTaskCfg_t *const taskCfg)
{
    UNUSED(taskCfg);
    return LaunchDqsTaskByType(taskCfg->type, stm);
}

static rtError_t DqsLaunchInterChipInit(Stream * const stm, const rtDqsTaskCfg_t *const taskCfg)
{
    UNUSED(taskCfg);
    return InterChipDqsTaskInit(stm);
}

static std::map<rtDqsTaskType, DqsLaunchTaskFunc> DQS_LAUNCH_TASK_FUNC_MAP = {
    {RT_DQS_TASK_SCHED_CONFIG,    &DqsLaunchSchedConfig},
    {RT_DQS_TASK_NOTIFY_WAIT,     &DqsLaunchNotifyWaitTask},
    {RT_DQS_TASK_DEQUEUE,         &DqsLaunchCommonTask},
    {RT_DQS_TASK_ZERO_COPY,       &DqsLaunchZeroCopyTask},
    {RT_DQS_TASK_CONDITION_COPY,  &DqsLaunchConditionCopyTask},
    {RT_DQS_TASK_PREPARE_OUT,     &DqsLaunchCommonTask},
    {RT_DQS_TASK_ENQUEUE,         &DqsLaunchCommonTask},
    {RT_DQS_TASK_FREE,            &DqsLaunchCommonTask},
    {RT_DQS_TASK_FRAME_ALIGN,     &DqsLaunchCommonTask},
    {RT_DQS_TASK_SCHED_END,       &DqsLaunchCommonTask},
    {RT_DQS_TASK_INTER_CHIP_INIT, &DqsLaunchInterChipInit},
    {RT_DQS_TASK_ADSPC,           &DqsLaunchAdspcTask},
};

rtError_t DqsLaunchTask(Stream *const stm, const rtDqsTaskCfg_t *const taskCfg)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(taskCfg, RT_ERROR_INVALID_VALUE);

    auto dqsLaunchTaskFuncIter = DQS_LAUNCH_TASK_FUNC_MAP.find(taskCfg->type);

    COND_RETURN_ERROR((dqsLaunchTaskFuncIter == DQS_LAUNCH_TASK_FUNC_MAP.end()),
        RT_ERROR_INVALID_VALUE, "Unsupported dqs task type: %u", static_cast<uint32_t>(taskCfg->type));

    return dqsLaunchTaskFuncIter->second(stm, taskCfg);
}
}
}