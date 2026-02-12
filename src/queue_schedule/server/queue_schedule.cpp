/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "queue_schedule.h"
#include <unistd.h>
#include <sched.h>
#include <csignal>
#include <cerrno>
#include <string>
#include "driver/ascend_hal.h"
#include "server/bqs_server.h"
#include "server/router_server.h"
#include "bind_relation.h"
#include "bind_cpu_utils.h"
#include "statistic_manager.h"
#include "subscribe_manager.h"
#include "queue_manager.h"
#include "profile_manager.h"
#include "entity_manager.h"
#include "hccl_process.h"
#include "common/bqs_util.h"
#include "queue_schedule_sub_module_interface.h"
#include "qs_interface_process.h"
#include "queue_schedule_hal_interface_ref.h"
#include "tsd.h"
#include "schedule_config.h"
#include "dynamic_sched_mgr.hpp"
#include "fsm/state_define.h"
#include "common/bqs_feature_ctrl.h"
#include "qs_args_parser.h"
#include "queue_schedule_feature_ctrl.h"

namespace bqs {
namespace {
constexpr uint32_t HOST_NAME_MAX_LEN = 128U;
constexpr const char_t *AOS_SD = "AOS_SD";
constexpr const size_t FIRST_ARRAY_INDEX = 0LU;
constexpr const uint32_t DAEMON_WAIT_TIMEOUT = 30U;
constexpr const uint32_t HOST_ENQUEUE_THREAD_NUM = 10U;
constexpr const uint32_t HOST_F2NF_THREAD_NUM = 10U;
// max qos num for hccl event: must greater than thread num in F2NF group
constexpr const uint32_t MAX_QOS_NUM_FOR_HCCL_EVENT = 12U;
// max qos num for f2nf event
constexpr const uint32_t MAX_QOS_NUM_FOR_F2NF_EVENT = 1U;
constexpr const char_t *ENQUEUE_THREAD_NAME_PREFIX = "enqueue_";
constexpr const char_t *F2NF_THREAD_NAME_PREFIX = "f2nf_";
constexpr const char_t *DAEMON_THREAD_NAME_PREFIX = "daemon";
constexpr const uint32_t ERROR_LOG_SAMPLE_INTERVAL = 1000U;

void DynamicScheduleByResponse(const uint32_t key, const uint32_t index,
    const std::vector<dgw::DynamicSchedMgr::ResponseInfo> &responses)
{
    BQS_LOG_INFO("responses size is %zu", responses.size());
    for (const auto &response : responses) {
        dgw::EntityPtr dynamicSrcEntity =
            dgw::EntityManager::Instance(index).GetSrcEntityByGlobalId(key, response.src.queueLogicId);
        if (dynamicSrcEntity == nullptr) {
            BQS_LOG_ERROR("Can't get entity by key[%u], globalId[%u]", key, response.src.queueLogicId);
            continue;
        }

        uint32_t updateCount = 0U;
        const auto &dataResults = response.groupResults;
        for (const auto groupResult : dataResults) {
            dgw::EntityPtr dynamicDstGrpEnity =
                dgw::EntityManager::Instance(index).GetDstEntityByGlobalId(key, groupResult.logicGroupId);
            if (dynamicDstGrpEnity == nullptr) {
                BQS_LOG_ERROR("Can't get entity by key[%u], globalId[%u]", key, groupResult.logicGroupId);
                continue;
            }
            const std::vector<dgw::EntityPtr> &entitiesInGroup =
                dgw::EntityManager::Instance(index).GetEntitiesInGroup(dynamicDstGrpEnity->GetId());
            if (entitiesInGroup.size() <= groupResult.index) {
                BQS_LOG_ERROR("Dynamic response's index[%u] is larger than group size[%zu]",
                    groupResult.index, entitiesInGroup.size());
                continue;
            }
            const dgw::EntityPtr dynamicDstInGroup = entitiesInGroup[groupResult.index];
            if (dynamicSrcEntity->UpdateSendObject(dynamicDstGrpEnity, dynamicDstInGroup)) {
                ++updateCount;
            }
        }
        BQS_LOG_INFO("updateCount is %u", updateCount);
        if (updateCount > 0U) {
            BQS_LOG_INFO("%s processMessage", dynamicSrcEntity->ToString().c_str());
            dgw::DynamicSchedMgr::GetInstance(index).DynamicSchedDurationEnd(dynamicSrcEntity->GetDynamicReqTime());
            dgw::InnerMessage msg;
            msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
            (void) dynamicSrcEntity->ProcessMessage(msg);
        }
    }
}
thread_local static int32_t thread_groupId;
thread_local static int32_t thread_deviceId;

int32_t getGrpId(int32_t tag, int32_t *grpId, int32_t *deviceId)
{
    (void) tag;
    if ((grpId == nullptr) || (deviceId == nullptr)) {
        return -1;
    }
    *grpId = thread_groupId;
    *deviceId = thread_deviceId;
    return 0;
}

}  // namespace

BqsStatus QueueSchedule::StartQueueSchedule()
{
    auto ret = BqsServer::GetInstance().InitBqsServer(qsInitGroupName_, deviceId_);
    if (ret != BQS_STATUS_OK) {
        BQS_LOG_ERROR("BqsServer Init failed, ret=%d.", ret);
        return ret;
    }
    ret = RouterServer::GetInstance().InitRouterServer(initQsParams_);
    if (ret != BQS_STATUS_OK) {
        BQS_LOG_ERROR("RouterServer Init failed, ret=%d.", ret);
        return ret;
    }

    GlobalCfg::GetInstance().SetNumaFlag(initQsParams_.numaFlag);
    GlobalCfg::GetInstance().RecordDeviceId(deviceId_, 0U, enqueGroupId_);
    reschedInterval_ = (reschedInterval_ == 0U) ? DAEMON_WAIT_TIMEOUT : reschedInterval_;
    abnormalInterval_ = ((initQsParams_.abnormalInterVal > ABNORMAL_INTERVAL_MIN) &&
                         (initQsParams_.abnormalInterVal < ABNORMAL_INTERVAL_MAX)) ?
                            initQsParams_.abnormalInterVal : ABNORMAL_INTERVAL_DEFAULT;
    StatisticManager::GetInstance().StartStatisticManager(
        abnormalInterval_, initQsParams_.pid, initQsParams_.numaFlag, initQsParams_.deviceIdExtra,
        initQsParams_.enqueGroupIdExtra);

    char_t hostNameStr[HOST_NAME_MAX_LEN] = {};
    const int32_t getNameRet = gethostname(&hostNameStr[FIRST_ARRAY_INDEX], HOST_NAME_MAX_LEN);
    if (getNameRet < 0) {
        BQS_LOG_ERROR("gethostname failed, ret=%d.", getNameRet);
        return BQS_STATUS_INNER_ERROR;
    }
    const std::string nameStr(hostNameStr);
    uint32_t threadNum = 0U;
    if (nameStr == AOS_SD) {
        hasAICPU_ = false;
        threadNum = 1U;
    }
    BQS_LOG_INFO("StartQueueSchedule schedPolicy:[%lu].", initQsParams_.schedPolicy);
    if (hasAICPU_ && (bqs::RunContext::HOST != bqs::GetRunContext())) {
        uint32_t aicpuNum = QueueScheduleInterface::GetInstance().GetAiCpuNum();
        BQS_LOG_RUN_INFO("the number of AICPU cores: %d", aicpuNum);
        if (aicpuNum == 0U) {
            isZeroSizeAicpuNum_ = true;
            threadNum = 1U;
        } else {
            threadNum = aicpuNum;
        }
    }
    BQS_LOG_RUN_INFO("Has aicpu:%d, numaFlag:%d, deviceId_:%u.",
        static_cast<int32_t>(hasAICPU_), initQsParams_.numaFlag, deviceId_);

    aicpuFeatureDisableRecvRequestEvent_ = (bqs::GetRunContext() == bqs::RunContext::HOST) ? false : QSFeatureCtrl::ShouldDisableRecvRequestEvent(deviceId_);
    aicpuFeatureSetPidPriority_ = (bqs::GetRunContext() == bqs::RunContext::HOST) ? false : QSFeatureCtrl::ShouldSetPidPriority(deviceId_);
    ret = InitDrvSchedModule(deviceId_, enqueGroupId_, f2nfGroupId_);
    if (ret != BQS_STATUS_OK) {
        BQS_LOG_ERROR("InitDrvSchedModule failed, ret=%d.", ret);
        return ret;
    }

    ret = QueueManager::GetInstance().InitQueueManager(deviceId_, enqueGroupId_, hasAICPU_, qsInitGroupName_);
    if (ret != BQS_STATUS_OK) {
        BQS_LOG_ERROR("QueueManager Init failed, ret=%d.", ret);
        return ret;
    }

    std::set<uint32_t> resDevids(initQsParams_.devIdVec.begin(), initQsParams_.devIdVec.end());
    resDevids.insert(deviceId_);
    if (initQsParams_.numaFlag) {
        resDevids.insert(initQsParams_.deviceIdExtra);
    }
    Subscribers::GetInstance().InitSubscribeManagers(resDevids, deviceId_);

    ProfileManager::GetInstance(0U).InitProfileManager(deviceId_);
    dgw::EntityManager::Instance(0U).SetSubscriptionPausePolicy(
        (initQsParams_.schedPolicy & static_cast<uint64_t>(SchedPolicy::POLICY_UNSUB_F2NF)) == 0UL);

    running_ = true;
    if (BindCpuUtils::InitSem() != BQS_STATUS_OK) {
        BQS_LOG_ERROR("InitSem failed");
        return BQS_STATUS_INNER_ERROR;
    }

    auto threadRet = StartThreadGroup(threadNum, deviceId_, enqueGroupId_, 0U);
    if (threadRet != BQS_STATUS_OK) {
        BQS_LOG_ERROR("StartThreadGroup failed");
        BindCpuUtils::DestroySem();
        return threadRet;
    }

    if (initQsParams_.numaFlag) {
        const auto extraRet = InitExtraSchedule(resDevids, threadNum);
        if (extraRet != BQS_STATUS_OK) {
            BQS_LOG_ERROR("InitExtraSchedule failed, ret is %d.", static_cast<int32_t>(extraRet));
            BindCpuUtils::DestroySem();
            return extraRet;
        }
    }

    BindCpuUtils::DestroySem();
    RouterServer::GetInstance().NotifyInitSuccess();
    return BQS_STATUS_OK;
}

BqsStatus QueueSchedule::InitExtraSchedule(const std::set<uint32_t> &resDevids, uint32_t threadNum)
{
    BqsStatus ret = InitDrvSchedModule(initQsParams_.deviceIdExtra, initQsParams_.enqueGroupIdExtra,
        initQsParams_.f2nfGroupIdExtra);
    if (ret != BQS_STATUS_OK) {
        BQS_LOG_ERROR("InitDrvSchedModule failed, ret=%d.", static_cast<int32_t>(ret));
        return ret;
    }
    GlobalCfg::GetInstance().RecordDeviceId(initQsParams_.deviceIdExtra, 1U, initQsParams_.enqueGroupIdExtra);

    QueueManager::GetInstance().InitExtra(initQsParams_.deviceIdExtra, initQsParams_.enqueGroupIdExtra);

    Subscribers::GetInstance().InitSubscribeManagers(resDevids, initQsParams_.deviceIdExtra);

    ProfileManager::GetInstance(1U).InitProfileManager(initQsParams_.deviceIdExtra);

    dgw::EntityManager::Instance(1U).SetSubscriptionPausePolicy(
        (initQsParams_.schedPolicy & static_cast<uint64_t>(SchedPolicy::POLICY_UNSUB_F2NF)) == 0UL);

    if (hasAICPU_ && (bqs::RunContext::HOST != bqs::GetRunContext())) {
        uint32_t aicpuNum = QueueScheduleInterface::GetInstance().GetExtraAiCpuNum();
        BQS_LOG_RUN_INFO("the number of Extra AICPU cores: %d", aicpuNum);
        if (aicpuNum == 0U) {
            aicpuNum = 1U;
        }
        threadNum = aicpuNum;
    }

    BqsStatus threadRet = StartThreadGroup(threadNum, initQsParams_.deviceIdExtra, initQsParams_.enqueGroupIdExtra, 1U);
    if (threadRet != BQS_STATUS_OK) {
        BQS_LOG_ERROR("StartThreadGroup failed");
        return threadRet;
    }

    const auto setCallbackRes = HcclSetGrpIdCallback(getGrpId);
    if (setCallbackRes != HCCL_SUCCESS) {
        BQS_LOG_ERROR("SetCallback failed, res is %d", static_cast<int32_t>(setCallbackRes));
        return BQS_STATUS_HCCL_ERROR;
    }
    return BQS_STATUS_OK;
}

BqsStatus QueueSchedule::StartThreadGroup(const uint32_t threadNum, const uint32_t deviceId,
                                          const uint32_t enqueGroupId, const uint32_t index)
{
    const sighandler_t oldHandler = signal(SIGCHLD, static_cast<sighandler_t>(SIG_DFL));
    const uint32_t enqueueThreadNum = (bqs::RunContext::HOST == bqs::GetRunContext()) ? HOST_ENQUEUE_THREAD_NUM
                                                                                      : threadNum;
    uint32_t vDevNum = 0U;
    if ((FeatureCtrl::IsVfModeCheckedByDeviceId(deviceId)) && (&halGetVdevNum != nullptr)) {
        int32_t ret = halGetVdevNum(&vDevNum);
        if (ret != 0) {
            BQS_LOG_ERROR("halGetVdevNum, failed result[%d]", ret);
            return BQS_STATUS_DRIVER_ERROR;
        }
    }
    BQS_LOG_INFO("Get vdev num=[%u] success.", vDevNum);
    for (uint32_t thIndex = 0U; thIndex < enqueueThreadNum; ++thIndex) {
        // create enqueue event thread
        uint32_t aicpuIndex = 0U;
        if (bqs::RunContext::HOST != bqs::GetRunContext()) {
            if (vDevNum > 0U) {
                aicpuIndex = (index == 0U) ?
                    QueueScheduleInterface::GetInstance().GetAicpuPhysIndexInVfMode(thIndex, deviceId) :
                    QueueScheduleInterface::GetInstance().GetExtraAicpuPhysIndexInVfMode(thIndex, deviceId);
            } else {
                aicpuIndex = (index == 0U) ?
                    QueueScheduleInterface::GetInstance().GetAicpuPhysIndex(deviceId, thIndex) :
                    QueueScheduleInterface::GetInstance().GetExtraAicpuPhysIndex(deviceId, thIndex);
            }
        }
        (void) workThreads_.emplace_back(
            &QueueSchedule::EnqueueThreadTask, this, deviceId, thIndex, aicpuIndex, enqueGroupId, index);
    }
    if (bqs::RunContext::HOST != bqs::GetRunContext()) {
        (void)workThreads_.emplace_back(&QueueSchedule::DaemonThreadTask, this, index);
    }

    uint32_t f2nfThreadNum = (bqs::RunContext::HOST == bqs::GetRunContext()) ? HOST_F2NF_THREAD_NUM : threadNum;
    if (initQsParams_.numaFlag) {
        // these event will be processed by enque thread on condition numa, so we need not create f2nf threads
        f2nfThreadNum = 0U;
    }
    for (uint32_t thIndex = 0U; thIndex < f2nfThreadNum; ++thIndex) {
        // create f2nf event thread
        uint32_t aicpuIndex = 0U;
        if (bqs::RunContext::HOST != bqs::GetRunContext()) {
            if (vDevNum > 0U) {
                aicpuIndex = QueueScheduleInterface::GetInstance().GetAicpuPhysIndexInVfMode(thIndex, deviceId);
            } else {
                aicpuIndex = QueueScheduleInterface::GetInstance().GetAicpuPhysIndex(deviceId_, thIndex);
            }
        }
        (void) workThreads_.emplace_back(
            &QueueSchedule::F2NFThreadTask, this, thIndex, aicpuIndex, f2nfGroupId_);
    }

    for (uint32_t thIndex = 0U; thIndex < enqueueThreadNum + f2nfThreadNum; ++thIndex) {
        // EnqueueThreadTask thread
        if (BindCpuUtils::WaitSem() != BQS_STATUS_OK) {
            BQS_LOG_ERROR("WaitSem failed");
            return BQS_STATUS_INNER_ERROR;
        }
    }
    (void)signal(SIGCHLD, oldHandler);
    return BQS_STATUS_OK;
}

void QueueSchedule::StopQueueSchedule()
{
    running_ = false;
    const std::unique_lock<std::mutex> daemonWaitLock(daemonWaitMtx_);
    daemonWait_.notify_all();
    StatisticManager::GetInstance().DumpOutProcMemStatInfo();
    StatisticManager::GetInstance().StopStatisticManager();
    ProfileManager::GetInstance(0U).Uninit();
    if (initQsParams_.numaFlag) {
        ProfileManager::GetInstance(1U).Uninit();
    }
}

void QueueSchedule::Destroy() const
{
    QueueManager::GetInstance().Destroy();
    if (!SubModuleInterface::GetInstance().GetStartFlag()) {
        (void)halEschedDettachDevice(deviceId_);
        if (initQsParams_.numaFlag) {
            (void)halEschedDettachDevice(initQsParams_.deviceIdExtra);
        }
    } else {
        BQS_LOG_RUN_INFO("sub module no need process detach main module do it");
    }
}

void QueueSchedule::EnqueueThreadTask(const uint32_t deviceId, const uint32_t threadIndex, const uint32_t bindCpuIndex,
                                      const uint32_t groupId, const uint32_t index)
{
    BQS_LOG_INFO("QueueSchedule enqueue thread[%u] start.", threadIndex);
    BindAicpu(threadIndex, bindCpuIndex);
    const auto threadName = std::string(ENQUEUE_THREAD_NAME_PREFIX).append(std::to_string(threadIndex));
    (void)pthread_setname_np(pthread_self(), threadName.c_str());
    thread_groupId = groupId;
    thread_deviceId = deviceId;

    const uint64_t eventBitmap =
        static_cast<uint64_t>(1LU << static_cast<uint64_t>(EVENT_QUEUE_ENQUEUE)) |
        static_cast<uint64_t>(1LU << static_cast<uint64_t>(EVENT_QUEUE_FULL_TO_NOT_FULL)) |
        static_cast<uint64_t>(1LU << static_cast<uint64_t>(dgw::EVENT_RECV_REQUEST_MSG)) |
        static_cast<uint64_t>(1LU << static_cast<uint64_t>(dgw::EVENT_SEND_COMPLETION_MSG)) |
        static_cast<uint64_t>(1LU << static_cast<uint64_t>(dgw::EVENT_RECV_COMPLETION_MSG)) |
        static_cast<uint64_t>(1LU << static_cast<uint64_t>(dgw::EVENT_CONGESTION_RELIEF_MSG));
    BQS_LOG_INFO("Enque group[%u] subscribe event, eventBitmap[%lu] deviceId[%u]", groupId, eventBitmap, deviceId);
    const int32_t ret = halEschedSubscribeEvent(deviceId, groupId, threadIndex, eventBitmap);
    if (ret != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("halEschedSubscribeEvent failed, groupId[%u] eventBitmap[%lu] result[%d].",
            groupId, eventBitmap, ret);
        StopQueueSchedule();
        return;
    }
    // set max num for hccl event
    event_sched_grp_qos qos = {};
    const std::vector<uint32_t> eventList = {dgw::EVENT_RECV_REQUEST_MSG, dgw::EVENT_SEND_COMPLETION_MSG,
        dgw::EVENT_RECV_COMPLETION_MSG, EVENT_QUEUE_FULL_TO_NOT_FULL};
    for (const uint32_t eventId : eventList) {
        qos.maxNum = (eventId == static_cast<uint32_t>(EVENT_QUEUE_FULL_TO_NOT_FULL)) ?
            MAX_QOS_NUM_FOR_F2NF_EVENT : MAX_QOS_NUM_FOR_HCCL_EVENT;
        const auto drvRet = halEschedSetGrpEventQos(deviceId, groupId, static_cast<EVENT_ID>(eventId), &qos);
        if (drvRet != DRV_ERROR_NONE) {
            BQS_LOG_ERROR("Failed to call halEschedSetGrpEventQos, groupId[%u], qos.maxNum[%u], ret[%d].",
                groupId, qos.maxNum, static_cast<int32_t>(drvRet));
            StopQueueSchedule();
            return;
        }
    }
    LoopProcessEnqueueEvent(threadIndex, deviceId, groupId, index);
}

void QueueSchedule::BindAicpu(const uint32_t threadIndex, const uint32_t bindCpuIndex)
{
    if (bqs::RunContext::HOST != bqs::GetRunContext()) {
        if (!hasAICPU_) {
            struct sched_param param;
            param.sched_priority = sched_get_priority_max(SCHED_FIFO);
            if (sched_setscheduler(0, SCHED_FIFO, &param) == -1) {
                BQS_LOG_ERROR("QueueSchedule sched_setscheduler failed, errno:%d, thread exit.", errno);
                StopQueueSchedule();
            }
        } else {
            if (!isZeroSizeAicpuNum_) {
                const int32_t status = BindCpuUtils::BindAicpu(bindCpuIndex);
                if (status != BQS_STATUS_OK) {
                    BQS_LOG_ERROR(
                        "QueueSchedule enqueue thread[%u] bind cpu[%u] failed, thread exit.",
                        threadIndex, bindCpuIndex);
                    StopQueueSchedule();
                }
            }
        }
    }

    if (BindCpuUtils::PostSem() != BQS_STATUS_OK) {
        BQS_LOG_ERROR("WaitPost failed");
    }
}

void QueueSchedule::CheckIfRecover(uint32_t &errCount, const char_t * const identity, const uint32_t threadIndex,
                                   const uint32_t groupId) const
{
    if (errCount != 0U) {
        errCount = 0U;
        BQS_LOG_ERROR("halEschedWaitEvent %s event recover, threadIndex[%u] groupId[%u]",
                      identity, threadIndex, groupId);
    }
}

void QueueSchedule::LoopProcessEnqueueEvent(const uint32_t threadIndex, const uint32_t deviceId,
    const uint32_t groupId, const uint32_t index)
{
    QueueManager::GetInstance().NotifyInitSuccess(index);
    struct event_info event = {};
    // default wait timeout 2s
    constexpr int32_t waitTimeout = 2000;
    uint32_t errCount = 0U;
    while (running_) {
        StatisticManager::GetInstance().RefreshEnqueHeartBeat();
        const int32_t schedRet = halEschedWaitEvent(deviceId, groupId, threadIndex, waitTimeout, &event);
        if (schedRet == DRV_ERROR_NONE) {
            CheckIfRecover(errCount, "enqueue", threadIndex, groupId);
            StatisticManager::GetInstance().AwakenAdd();
            ProcessEvent(threadIndex, event, index);
        } else if (schedRet == DRV_ERROR_SCHED_WAIT_TIMEOUT) {
            CheckIfRecover(errCount, "enqueue", threadIndex, groupId);
            BQS_LOG_DEBUG("halEschedWaitEvent enqueue event timeout, groupId=%u, thread index:%u",
                groupId, threadIndex);
            continue;
        } else if (schedRet == DRV_ERROR_PARA_ERROR) {
            BQS_LOG_ERROR(
                    "halEschedWaitEvent enqueue event failed, deviceId[%u] threadIndex[%u] groupId[%u] error[%d].",
                    deviceId, threadIndex, groupId, schedRet);
            break;
        } else {
            if (errCount++ == 0U) {
                BQS_LOG_ERROR(
                    "halEschedWaitEvent enqueue event failed, deviceId[%u] threadIndex[%u] groupId[%u] error[%d].",
                    deviceId, threadIndex, groupId, schedRet);
            }
        }
    }

    BQS_LOG_INFO("QueueSchedule enqueue thread[%u] exit", threadIndex);
}

void QueueSchedule::F2NFThreadTask(const uint32_t threadIndex, const uint32_t bindCpuIndex, const uint32_t groupId)
{
    BQS_LOG_INFO("Queue Schedule f2nf thread[%u] start.", threadIndex);
    const auto threadName = std::string(F2NF_THREAD_NAME_PREFIX).append(std::to_string(threadIndex));
    (void)pthread_setname_np(pthread_self(), threadName.c_str());
    BindAicpu(threadIndex, bindCpuIndex);
    const uint64_t eventBitmap =
        static_cast<uint64_t>(1LU << static_cast<uint64_t>(dgw::EVENT_RECV_REQUEST_MSG)) |
        static_cast<uint64_t>(1LU << static_cast<uint64_t>(dgw::EVENT_SEND_COMPLETION_MSG)) |
        static_cast<uint64_t>(1LU << static_cast<uint64_t>(dgw::EVENT_RECV_COMPLETION_MSG)) |
        static_cast<uint64_t>(1LU << static_cast<uint64_t>(dgw::EVENT_CONGESTION_RELIEF_MSG));

    BQS_LOG_INFO("F2NF group[%u] subscribe event, eventBitmap[%lu]", f2nfGroupId_, eventBitmap);
    const auto ret = halEschedSubscribeEvent(deviceId_, f2nfGroupId_, threadIndex, eventBitmap);
    if (ret != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("halEschedSubscribeEvent failed, groupId[%u] eventBitmap[%lu] result[%d].",
            f2nfGroupId_, eventBitmap, static_cast<int32_t>(ret));
        StopQueueSchedule();
        return;
    }

    // set max num for hccl event
    event_sched_grp_qos qos = {};
    const std::vector<uint32_t> eventList = {dgw::EVENT_RECV_REQUEST_MSG, dgw::EVENT_SEND_COMPLETION_MSG,
        dgw::EVENT_RECV_COMPLETION_MSG};
    for (const uint32_t eventId : eventList) {
        qos.maxNum = MAX_QOS_NUM_FOR_HCCL_EVENT;
        const auto drvRet = halEschedSetGrpEventQos(deviceId_, f2nfGroupId_, static_cast<EVENT_ID>(eventId), &qos);
        if (drvRet != DRV_ERROR_NONE) {
            BQS_LOG_ERROR("Failed to call halEschedSetGrpEventQos, groupId[%u], qos.maxNum[%u], ret[%d].",
                f2nfGroupId_, qos.maxNum, static_cast<int32_t>(drvRet));
            StopQueueSchedule();
            return;
        }
    }

    struct event_info event = {};
    // default wait timeout 2s
    constexpr int32_t waitTimeout = 2000;
    uint32_t errCount = 0U;
    while (running_) {
        const int32_t schedRet = halEschedWaitEvent(deviceId_, groupId, threadIndex, waitTimeout, &event);
        if (schedRet == DRV_ERROR_NONE) {
            CheckIfRecover(errCount, "f2nf", threadIndex, groupId);
            (void)ProcessEvent(threadIndex, event, 0U);
        } else if (schedRet == DRV_ERROR_SCHED_WAIT_TIMEOUT) {
            CheckIfRecover(errCount, "f2nf", threadIndex, groupId);
            BQS_LOG_DEBUG("halEschedWaitEvent f2nf event timeout,thread index:%u", threadIndex);
            continue;
        } else if (schedRet == DRV_ERROR_PARA_ERROR) {
            BQS_LOG_ERROR(
                "halEschedWaitEvent f2nf event failed, deviceId[%u] threadIndex[%u] groupId[%u] error[%d].",
                deviceId_, threadIndex, groupId, schedRet);
            break;
        } else {
            if (errCount++ == 0U) {
                BQS_LOG_ERROR(
                    "halEschedWaitEvent f2nf event failed, deviceId[%u] threadIndex[%u] groupId[%u] error[%d].",
                    deviceId_, threadIndex, groupId, schedRet);
            }
        }
    }
    BQS_LOG_INFO("Queue Schedule f2nf thread[%u] exit", threadIndex);
}

BqsStatus QueueSchedule::ProcessEvent(const uint32_t threadIndex, event_info &event, const uint32_t index)
{
    auto ret = dgw::FsmStatus::FSM_SUCCESS;
    const uint32_t eventId = event.comm.event_id;
    const uint32_t deviceId = (index == 0) ? deviceId_ : initQsParams_.deviceIdExtra;

    switch (eventId) {
        case static_cast<uint32_t>(EVENT_QUEUE_ENQUEUE): {
            BQS_LOG_INFO("the [%u]th thread[%u] recv enqueEvent", index, threadIndex);
            ProcessEnqueueEvent(threadIndex, event, index, false);
            break;
        }
        case static_cast<uint32_t>(EVENT_QUEUE_FULL_TO_NOT_FULL): {
            BQS_LOG_INFO("the [%u]th thread[%u] recv f2nfEvent", index, threadIndex);
            ProcessEnqueueEvent(threadIndex, event, index, true);
            break;
        }
        case dgw::EVENT_RECV_REQUEST_MSG: {
            ret = dgw::HcclProcess::GetInstance().ProcessRecvRequestEvent(event, deviceId, index);
            break;
        }
        case dgw::EVENT_SEND_COMPLETION_MSG: {
            ret = dgw::HcclProcess::GetInstance().ProcessSendCompletionEvent(event, deviceId, index);
            break;
        }
        case dgw::EVENT_RECV_COMPLETION_MSG: {
            ret = dgw::HcclProcess::GetInstance().ProcessRecvCompletionEvent(event, deviceId, index);
            break;
        }
        case dgw::EVENT_CONGESTION_RELIEF_MSG: {
            ret = dgw::HcclProcess::GetInstance().ProcessCongestionReliefEvent(event, deviceId, index);
            break;
        }
        default: {
            BQS_LOG_WARN("Unsupported event[%u].", eventId);
            ret = dgw::FsmStatus::FSM_FAILED;
            break;
        }
    }

    if (ret != dgw::FsmStatus::FSM_SUCCESS) {
        return BqsStatus::BQS_STATUS_INNER_ERROR;
    }
    return BqsStatus::BQS_STATUS_OK;
}

void QueueSchedule::DaemonThreadTask(const uint32_t index)
{
    BQS_LOG_INFO("Queue Schedule Daemon thread start.");
    (void)pthread_setname_np(pthread_self(), DAEMON_THREAD_NAME_PREFIX);
    const uint32_t deviceId = (index == 0) ? deviceId_ : initQsParams_.deviceIdExtra;
    const uint32_t enqueGroupId = (index == 0) ? enqueGroupId_ : initQsParams_.enqueGroupIdExtra;
    BindCpuUtils::SetThreadFIFO(deviceId);

    // fixme: can run concurrancyly for different index
    std::unique_lock<std::mutex> daemonWaitLock(daemonWaitMtx_);
    uint64_t awakenTimes = 0UL;
    QueueSubscriber subscriber;
    subscriber.devId = deviceId;
    subscriber.spGrpId = 0;
    subscriber.pid = static_cast<int32_t>(getpid());
    subscriber.groupId = static_cast<int32_t>(enqueGroupId);
    while ((daemonWait_.wait_for(daemonWaitLock, std::chrono::milliseconds(reschedInterval_)) ==
            std::cv_status::timeout) && (running_)) {
        if (StatisticManager::GetInstance().GetEventScheduleStat() == 0U) {
            // no work to do
            continue;
        }
        const uint64_t newAwakenTimes = StatisticManager::GetInstance().GetAwakenTimes();
        if (awakenTimes == newAwakenTimes) {
            int32_t ret = halQueueCtrlEvent(&subscriber, QUE_PAUSE_EVENT);
            if (ret == DRV_ERROR_NONE) {
                DaemonEnqueueEvent(index);
                ret = halQueueCtrlEvent(&subscriber, QUE_RESUME_EVENT);
                if (ret != DRV_ERROR_NONE) {
                    BQS_LOG_ERROR(
                        "halQueueCtrlEvent QUE_RESUME_EVENT failed, deviceId_[%u] enqueGroupId_[%u] ret[%d].",
                        deviceId, enqueGroupId, ret);
                }
            } else {
                BQS_LOG_RUN_WARN("halQueueCtrlEvent QUE_PAUSE_EVENT failed, deviceId_[%u] enqueGroupId_[%u] ret[%d].",
                    deviceId, enqueGroupId, ret);
            }
        } else {
            awakenTimes = newAwakenTimes;
        }
    }
    BQS_LOG_INFO("Queue Schedule Daemon thread exit");
}

void QueueSchedule::ProcessEnqueueEvent(const uint32_t threadIndex, const event_info &event, const uint32_t index,
    const bool procF2NF)
{
    auto &queueEventAtomicFlag = (index == 0U) ? queueEventAtomicFlag_ : queueEventAtomicFlagExtra_;
    // if other thread is working do nothing; if not set work flag.
    if (!queueEventAtomicFlag.test_and_set()) {
        ProfileManager &profileManager = ProfileManager::GetInstance(index);
        const uint64_t eventBegin = profileManager.GetCpuTick();
        const uint64_t schedDelay = static_cast<uint64_t>(event.comm.sched_timestamp - event.comm.submit_timestamp);
        const uint64_t schedTimes = StatisticManager::GetInstance().EventScheduleStat();
        profileManager.InitMaker(schedTimes, schedDelay);

        // handle relation queue
        const bool procRelation = QueueManager::GetInstance().HandleRelationEvent(index);
        const uint64_t f2NFBegin = profileManager.GetCpuTick();
        profileManager.SetRelationCost(f2NFBegin - eventBegin);

        // handle full to not full queue
        bool hasF2NF = QueueManager::GetInstance().HandleFullToNotFullEvent(index);
        profileManager.Setf2NFCost(profileManager.GetCpuTick() - f2NFBegin);
        hasF2NF |= procF2NF;

        // handle schedule data
        const bool procAsynMemBuff = QueueManager::GetInstance().HandleAsynMemBuffEvent(index);
        const uint64_t scheduleBegin = profileManager.GetCpuTick();
        ScheduleDataBuffAll(!(procRelation || hasF2NF || procAsynMemBuff), index);
        StatisticManager::GetInstance().UpdateScheuleStatistic(profileManager.GetTimeCost(schedDelay),
            profileManager.GetTimeCost(profileManager.GetCpuTick() - scheduleBegin));
        profileManager.TryMarker(eventBegin);
        // clear event work flag
        queueEventAtomicFlag.clear();
        return;
    }

    if (procF2NF) {
        ProcessFullToNotFullEvent(index);
        return;
    }

    bqs::StatisticManager::GetInstance().EnqueueEventFalseAwakenStat();
    BQS_LOG_DEBUG("Thread[%u] can't work as other thread is working.", threadIndex);
}

void QueueSchedule::ProcessFullToNotFullEvent(const uint32_t index)
{
    bqs::StatisticManager::GetInstance().F2nfEventStat();
    (void)QueueManager::GetInstance().EnqueueFullToNotFullEvent(index);
}

void QueueSchedule::DaemonEnqueueEvent(const uint32_t index)
{
    auto &queueEventAtomicFlag = (index == 0U) ? queueEventAtomicFlag_ : queueEventAtomicFlagExtra_;
    // if other thread is working do nothing; if not set work flag.
    if (!queueEventAtomicFlag.test_and_set()) {
        StatisticManager::GetInstance().DaemonEventScheduleStat();

        // handle relation queue
        const bool procRelation = QueueManager::GetInstance().HandleRelationEvent(index);

        // handle schedule data
        ScheduleDataBuffAll(!procRelation, index);

        // clear event work flag
        queueEventAtomicFlag.clear();
    } else {
        BQS_LOG_WARN("Daemon thread can't work as other thread is working, may event error.");
    }
}

void QueueSchedule::DynamicSchedule(const uint32_t index) const
{
    const auto &dynamicCfgKeys = dgw::ScheduleConfig::GetInstance().GetSchedKeys();
    BQS_LOG_DEBUG("dynamicCfgKeys size is %zu", dynamicCfgKeys.size());
    if (dynamicCfgKeys.empty()) {
        return;
    }
    uint32_t dynamicScheduleCount = 0U;
    for (const auto key: dynamicCfgKeys) {
        if (dgw::ScheduleConfig::GetInstance().IsStopped(key)) {
            BQS_LOG_INFO("key[%u] is stopped, then skip", key);
            continue;
        }
        while (dynamicScheduleCount++ < 100U) {
            std::vector<dgw::DynamicSchedMgr::ResponseInfo> responses;
            const auto getResponseRet = dgw::DynamicSchedMgr::GetInstance(index).GetResponse(key, responses);
            if ((getResponseRet != dgw::FsmStatus::FSM_SUCCESS) || (responses.size() == 0U)) {
                BQS_LOG_DEBUG("Can't get response, ret is %d", static_cast<int32_t>(getResponseRet));
                break;
            }
            DynamicScheduleByResponse(key, index, responses);
        }
    }
    BQS_LOG_DEBUG("finish DynamicSchedule, dynamicScheduleCount is %u", dynamicScheduleCount);
}

void QueueSchedule::ScheduleDataBuffAll(const bool dataEnqueue, const uint32_t index) const
{
    BQS_LOG_INFO("the [%u]th thread ScheduleDataBuffAll.", index);
    bool hasDequeueFlag = false;
    const auto &orderedSubscribeQueues = (index == 0U) ?
        BindRelation::GetInstance().GetOrderedSubscribeQueueId() :
        BindRelation::GetInstance().GetOrderedSubscribeQueueIdExtra();
    const auto &srcToDstRelation = (index == 0U) ?
        BindRelation::GetInstance().GetSrcToDstRelation() :
        BindRelation::GetInstance().GetSrcToDstExtraRelation();

    ProfileManager::GetInstance(index).SetSrcQueueNum(static_cast<uint32_t>(orderedSubscribeQueues.size()));
    dgw::InnerMessage msg;
    msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
    BindRelation::GetInstance().ClearAbnormalEntityInfo(index);
    if (dgw::EntityManager::Instance(index).IsExistFullEntity() ||
        dgw::EntityManager::Instance(index).IsExistAsyncMemEntity()) {
        for (const auto &src : orderedSubscribeQueues) {
            if (dgw::ScheduleConfig::GetInstance().IsStopped(src.GetSchedCfgKey())) {
                BQS_LOG_INFO("Skip schedule src[%s] for it has been stopped.", src.ToString().c_str());
                continue;
            }
            const auto iter = srcToDstRelation.find(src);
            if (iter == srcToDstRelation.end()) {
                BQS_LOG_WARN("Can't find dst queues for queue[%u].", src.GetId());
                continue;
            }
            for (auto &dst : iter->second) {
                // process full state for dst entity
                if (ProcessDstEntity(dst, index) == dgw::FsmStatus::FSM_ERROR) {
                    BQS_LOG_ERROR("Skip scheduler for routes maybe has been modified");
                    break;
                };
            }

            const auto &srcEntity = src.GetEntity();
            if (srcEntity->ProcessMessage(msg) == dgw::FsmStatus::FSM_ERROR) {
                BQS_LOG_ERROR("skip scheduler for routes maybe have been modified");
                break;
            }
            hasDequeueFlag |= (srcEntity->GetScheduleCount() > 0UL);
        }
    } else {
        for (const auto &src : orderedSubscribeQueues) {
            if (dgw::ScheduleConfig::GetInstance().IsStopped(src.GetSchedCfgKey())) {
                BQS_LOG_INFO("Skip schedule src[%s] for it has been stopped.", src.ToString().c_str());
                continue;
            }
            const auto &srcEntity = src.GetEntity();
            if (srcEntity->ProcessMessage(msg) == dgw::FsmStatus::FSM_ERROR) {
                BQS_LOG_ERROR("skip scheduler for routes maybe have been modified");
                break;
            }
            hasDequeueFlag |= (srcEntity->GetScheduleCount() > 0UL);
        }
    }

    DynamicSchedule(index);

    // supply recv request event
    if (hasDequeueFlag && (!aicpuFeatureDisableRecvRequestEvent_)) {
        (void)dgw::EntityManager::Instance(index).SupplyRecvRequestEvent();
    }

    if ((!hasDequeueFlag) && dataEnqueue) {
        StatisticManager::GetInstance().AddScheduleEmpty();
    }
    BindRelation::GetInstance().UpdateRelation(index);
}

dgw::FsmStatus QueueSchedule::ProcessDstEntity(const EntityInfo &entity, const uint32_t index) const
{
    const auto dstEntity = entity.GetEntity();
    if (dstEntity == nullptr) {
        BQS_LOG_ERROR("Get entity ptr for entity[%s] failed.", entity.ToString().c_str());
        return dgw::FsmStatus::FSM_FAILED;
    }
    // process full for queue or tag
    if (entity.GetType() != dgw::EntityType::ENTITY_GROUP) {
        BQS_LOG_DEBUG("Process dst entity, id[%u], type[%s].",
            dstEntity->GetId(), dstEntity->GetTypeDesc().c_str());
        dgw::InnerMessage msg;
        msg.msgType = dstEntity->GetCurState() == dgw::FsmState::FSM_FULL_STATE ? dgw::InnerMsgType::INNER_MSG_F2NF :
            dgw::InnerMsgType::INNER_MSG_PUSH;
        return dstEntity->ProcessMessage(msg);
    }
    // process full for group
    auto &entitiesInGroup = dgw::EntityManager::Instance(index).GetEntitiesInGroup(entity.GetId());
    for (auto &entityInGroup : entitiesInGroup) {
        BQS_LOG_DEBUG("Process dst entity in group[%u], id[%u], type[%s].",
            dstEntity->GetId(), entityInGroup->GetId(), entityInGroup->GetTypeDesc().c_str());
        dgw::InnerMessage msg;
        msg.msgType = entityInGroup->GetCurState() == dgw::FsmState::FSM_FULL_STATE ?
            dgw::InnerMsgType::INNER_MSG_F2NF : dgw::InnerMsgType::INNER_MSG_PUSH;
        (void) entityInGroup->ProcessMessage(msg);
    }
    return dgw::FsmStatus::FSM_SUCCESS;
}

QueueSchedule::~QueueSchedule()
{
    running_ = false;
    daemonWait_.notify_all();
    for (auto &worker : workThreads_) {
        if (worker.joinable()) {
            worker.join();
        }
    }
}

void QueueSchedule::WaitForStop()
{
    BQS_LOG_RUN_INFO("WaitForStop begin");
    RouterServer::GetInstance().Destroy();
    StopQueueSchedule();
    for (auto &worker : workThreads_) {
        if (worker.joinable()) {
            worker.join();
        }
    }
    BQS_LOG_INFO("WaitForStop end");
}

/* *
 * init drv event scheduler.
 * @return BQS_STATUS_OK: success, other: error
 */
BqsStatus QueueSchedule::InitDrvSchedModule(const uint32_t deviceId, const uint32_t enqueGroupId,
                                            const uint32_t f2nfGroupId) const
{
    BQS_LOG_INFO("Attach device[%u] to drv scheduler", deviceId);
    (void)f2nfGroupId;
    int32_t ret = halEschedAttachDevice(deviceId);
    if ((ret != DRV_ERROR_NONE) && (ret != DRV_ERROR_PROCESS_REPEAT_ADD)) {
        BQS_LOG_ERROR("Failed to attach device[%u] for eSched, result[%d].", deviceId, ret);
        return BQS_STATUS_DRIVER_ERROR;
    }

    for (uint32_t idx = 0; idx < initQsParams_.devIdVec.size(); idx++) {
        uint32_t currDeviceId = initQsParams_.devIdVec[idx];
        ret = halEschedAttachDevice(currDeviceId);
        if ((ret != DRV_ERROR_NONE) && (ret != DRV_ERROR_PROCESS_REPEAT_ADD)) {
            BQS_LOG_ERROR("Failed to attach device[%u] for eSched, result[%d].", currDeviceId, ret);
            return BQS_STATUS_DRIVER_ERROR;
        }

        if (deviceId_ == currDeviceId) {
            continue;
        }
        QueueSetInputPara inPutParam;
        (void)halQueueSet(currDeviceId, QUEUE_ENABLE_LOCAL_QUEUE, &inPutParam);

        ret = halQueueInit(currDeviceId);
        if ((ret != DRV_ERROR_NONE) && (ret != DRV_ERROR_REPEATED_INIT)) {
            BQS_LOG_ERROR("host flow halQueueInit error, ret=[%d]", static_cast<int32_t>(ret));
            return BQS_STATUS_DRIVER_ERROR;
        }
    }

    // set pid priority
    const bool setPidPriorityFlag = (bqs::GetRunContext() == bqs::RunContext::HOST) ?
        true : aicpuFeatureSetPidPriority_;
    if (setPidPriorityFlag) {
        (void)halEschedSetPidPriority(deviceId, PRIORITY_LEVEL0);
    }

    GROUP_TYPE enqueGrpType = GRP_TYPE_BIND_CP_CPU;
    GROUP_TYPE f2nfGrpType = GRP_TYPE_BIND_CP_CPU;
    if (hasAICPU_ && !isZeroSizeAicpuNum_ && (bqs::RunContext::HOST != bqs::GetRunContext())) {
        enqueGrpType = GRP_TYPE_BIND_DP_CPU;
        f2nfGrpType = GRP_TYPE_BIND_DP_CPU;
    }
    BQS_LOG_INFO("Create enqueGroup[%u] type[%d] on device[%u].", enqueGroupId, enqueGrpType, deviceId);
    ret = halEschedCreateGrp(deviceId, enqueGroupId, enqueGrpType);
    if (ret != DRV_ERROR_NONE) {
        (void)halEschedDettachDevice(deviceId);
        BQS_LOG_ERROR("Failed to create enqueGroup, groupId[%u] result[%d].", enqueGroupId, ret);
        return BQS_STATUS_DRIVER_ERROR;
    }

    if (!initQsParams_.numaFlag) {
        BQS_LOG_INFO("Create f2nfGroup[%u], type[%d]", f2nfGroupId_, f2nfGrpType);
        ret = halEschedCreateGrp(deviceId_, f2nfGroupId_, f2nfGrpType);
        if (ret != DRV_ERROR_NONE) {
            (void)halEschedDettachDevice(deviceId_);
            BQS_LOG_ERROR("Failed to create f2nfGroup, groupId[%u] result[%d].", f2nfGroupId_, ret);
            return BQS_STATUS_DRIVER_ERROR;
        }
    }
    return BQS_STATUS_OK;
}

void QueueSchedule::ReportAbnormal() const
{
    BQS_LOG_ERROR("Enqueue thread has missed heartbeat for %u seconds", abnormalInterval_);
    if ((bqs::GetRunContext() != bqs::RunContext::HOST) &&
        (initQsParams_.starter != bqs::QsStartType::START_BY_DEPLOYER) &&
        (initQsParams_.runMode != QueueSchedulerRunMode::MULTI_THREAD)) {
        const int32_t ret = TsdDestroy(deviceId_, TSD_QS, initQsParams_.pid, initQsParams_.vfId);
        if (ret != 0) {
            BQS_LOG_ERROR("dev[%u] send abnormal msg to tsdaemon failed, ret[%d]", deviceId_, ret);
        }
    }
}
}  // namespace bqs
