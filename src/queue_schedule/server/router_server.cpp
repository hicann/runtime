/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "router_server.h"

#include <map>
#include <csignal>
#include <sstream>
#include <securec.h>
#include <sys/types.h>
#include <unistd.h>
#include "statistic_manager.h"
#include "bqs_log.h"
#include "common/bqs_util.h"
#include "hccl_process.h"
#include "hccl/hccl_so_manager.h"
#include "common/type_def.h"
#include "queue_manager.h"
#include "queue_schedule_hal_interface_ref.h"
#include "qs_interface_process.h"
#include "queue_schedule_sub_module_interface.h"
#include "entity_manager.h"

namespace bqs {
namespace {
const std::string PIPELINE_QUEUE_NAME = "QsPipeQueue";
constexpr const uint16_t MAJOR_VERSION = 3U;
constexpr const uint16_t MINOR_VERSION = 0U;
constexpr const QueueShareAttr ADMIN_QUEUE_ATTR = {1U, 1U, 1U, 0U};
constexpr const char_t *ROUTER_SERVER_THREAD_NAME_PREFIX = "router_server";

// mapping of request subeventId and response subeventId
const std::map<int32_t, int32_t> g_reqRspMapping = {
    {AICPU_BIND_QUEUE, AICPU_BIND_QUEUE_RES},
    {AICPU_BIND_QUEUE_INIT, AICPU_BIND_QUEUE_INIT_RES},
    {AICPU_UNBIND_QUEUE, AICPU_UNBIND_QUEUE_RES},
    {AICPU_QUERY_QUEUE, AICPU_QUERY_QUEUE_RES},
    {AICPU_QUERY_QUEUE_NUM, AICPU_QUERY_QUEUE_NUM_RES}
};
// mapping of request subeventId and qs operate type
const std::map<uint32_t, QsOperType> g_qsOperation = {
    {static_cast<uint32_t>(AICPU_BIND_QUEUE_INIT), QsOperType::BIND_INIT},
    {static_cast<uint32_t>(AICPU_BIND_QUEUE_INIT), QsOperType::BIND_INIT},
    {static_cast<uint32_t>(AICPU_QUERY_QUEUE_NUM), QsOperType::QUERY_NUM},
    {static_cast<uint32_t>(AICPU_QUEUE_RELATION_PROCESS), QsOperType::RELATION_PROCESS},
    {static_cast<uint32_t>(ACL_BIND_QUEUE_INIT), QsOperType::BIND_INIT},
    {static_cast<uint32_t>(ACL_BIND_QUEUE), QsOperType::RELATION_PROCESS},
    {static_cast<uint32_t>(ACL_UNBIND_QUEUE), QsOperType::RELATION_PROCESS},
    {static_cast<uint32_t>(ACL_QUERY_QUEUE_NUM), QsOperType::QUERY_NUM},
    {static_cast<uint32_t>(ACL_QUERY_QUEUE), QsOperType::RELATION_PROCESS},
    {static_cast<uint32_t>(DGW_CREATE_HCOM_HANDLE), QsOperType::CREATE_HCOM_HANDLE},
    {static_cast<uint32_t>(DGW_DESTORY_HCOM_HANDLE), QsOperType::DESTROY_HCOM_HANDLE},
    {static_cast<uint32_t>(BIND_HOSTPID), QsOperType::BIND_HOST_PID},
    // new operation type for flow gateway
    {static_cast<uint32_t>(UPDATE_CONFIG), QsOperType::UPDATE_CONFIG},
    {static_cast<uint32_t>(QUERY_CONFIG_NUM), QsOperType::QUERY_CONFIG_NUM},
    {static_cast<uint32_t>(QUERY_CONFIG), QsOperType::QUERY_CONFIG},
    {static_cast<uint32_t>(QUERY_LINKSTATUS), QsOperType::QUERY_LINKSTATUS},
    {static_cast<uint32_t>(QUERY_LINKSTATUS_V2), QsOperType::QUERY_LINKSTATUS_V2},
};

// 老版驱动结构体——解析数据时需要使用与驱动相同的结构体
struct old_event_sync_msg {
    int pid; /* local pid */
    unsigned int dst_engine : 4; /* local engine */
    unsigned int gid : 6;
    unsigned int event_id : 6;
    unsigned int subevent_id : 16; /* Range: 0 ~ 4095 */
    char msg[];
};

}

RouterServer::RouterServer() : processing_(false), done_(false), processingExtra_(false), doneExtra_(true),
                               bindQueueGroupId_(static_cast<uint32_t>(BIND_QUEUE_GROUP_ID)),
                               running_(false),  deviceId_(0U), srcPid_(-1), srcVersion_(0U),
                               srcGroupId_(-1), pipelineQueueId_(MAX_QUEUE_ID_NUM), subEventId_(0U),
                               deployMode_(QueueSchedulerRunMode::MULTI_PROCESS),
                               retCode_(static_cast<int32_t>(BQS_STATUS_OK)), attachedFlag_(false),
                               isAicpuEvent_(false), qsRouteListPtr_(nullptr), qsRouterHeadPtr_(nullptr),
                               qsRouterQueryPtr_(nullptr), drvSyncMsg_(nullptr), aicpuRspHead_(0UL),
                               f2nfGroupId_(0U), schedPolicy_(0UL), cfgInfoOperator_(nullptr), callHcclFlag_(false),
                               numaFlag_(false), readyToHandleMsg_(false), manageThreadStatus_(ThreadStatus::NOT_INIT),
                               needAttachGroup_(false), compatMsg_(false)
{}

void RouterServer::Destroy()
{
    if (!running_) {
        return;
    }
    BQS_LOG_INFO("[RouterServer]QS Server destroy.");
    running_ = false;
    queueRouteQueryList_.clear();
    cv_.notify_all();
    if (monitorQsEvent_.joinable()) {
        monitorQsEvent_.join();
    }
    manageThreadStatus_ = ThreadStatus::NOT_INIT;
    if (pipelineQueueId_ < MAX_QUEUE_ID_NUM) {
        const auto ret = halQueueDestroy(deviceId_, pipelineQueueId_);
        BQS_LOG_ERROR_WHEN(ret != DRV_ERROR_NONE,
                           "[RouterServer]Destroy relation event buff queue error, queue id[%u], ret[%d]",
                           pipelineQueueId_.load(), static_cast<int32_t>(ret));
    }
    cfgInfoOperator_ = nullptr;
    BQS_LOG_RUN_INFO("[RouterServer]QS Server finish destroy.");
}

RouterServer::~RouterServer()
{
    Destroy();
}

bool RouterServer::GetCallHcclFlag() const
{
    return callHcclFlag_;
}

uint32_t RouterServer::GetPipelineQueueId() const
{
    return pipelineQueueId_;
}

RouterServer &RouterServer::GetInstance()
{
    static RouterServer instance;
    return instance;
}

void RouterServer::HandleBqsMsg(event_info &info)
{
    if (info.comm.event_id != EVENT_QS_MSG) {
        BQS_LOG_ERROR("[RouterServer]Queue schedule do not support [%d] event",
                      static_cast<int32_t>(info.comm.event_id));
        return;
    }
    subEventId_ = info.comm.subevent_id;
    // check aicpu event
    isAicpuEvent_ = (subEventId_ <= static_cast<uint32_t>(AICPU_RELATED_MESSAGE_SPLIT)) ? true : false;
    if (!isAicpuEvent_) {
        // msg is char array, not need check nullptr
        drvSyncMsg_ = PtrToPtr<char_t, event_sync_msg>(info.priv.msg);
    }

    if (!readyToHandleMsg_) {
        BQS_LOG_WARN("[RouterServer] is not ready to HandleBqsMsg");
        SendRspEvent(static_cast<int32_t>(BQS_STATUS_NOT_INIT));
        return;
    }

    // check subEventId, SendRspEvent need drvSyncMsg if event from acl
    const auto iter = g_qsOperation.find(subEventId_);
    if (iter == g_qsOperation.end()) {
        BQS_LOG_RUN_INFO("[RouterServer]SubEventId is invalid[%d]", subEventId_);
        SendRspEvent(static_cast<int32_t>(BQS_STATUS_PARAM_INVALID));
        return;
    }

    // aicpu message is not allowed in thread mode.
    if (isAicpuEvent_ && (deployMode_ == QueueSchedulerRunMode::MULTI_THREAD)) {
        BQS_LOG_ERROR("[RouterServer]Thread mode[%u] does not sopport event[%u] from aicpu.",
                      static_cast<int32_t>(deployMode_), subEventId_);
        return;
    }
    PreProcessEvent(info);
    BQS_LOG_INFO("[RouterServer]HandleBqsMsg end, isAicpuEvent[%d].", static_cast<int32_t>(isAicpuEvent_));
    return;
}

void RouterServer::PreProcessEvent(const event_info &info)
{
    // get event head for responseing by sync interface
    BQS_LOG_INFO("[RouterServer]PreProcess start operation[%u]", subEventId_);
    const auto iter = g_qsOperation.find(subEventId_);
    if (iter == g_qsOperation.end()) {
        SendRspEvent(static_cast<int32_t>(BQS_STATUS_PARAM_INVALID));
        BQS_LOG_ERROR("[RouterServer] RouterServer receive unsupported msg type:%d", subEventId_);
        return;
    }

    const QsOperType operType = iter->second;
    switch (operType) {
        case QsOperType::BIND_INIT:
            SendRspEvent(static_cast<int32_t>(ProcessBindInit(info)));
            break;
        case QsOperType::QUERY_NUM:
            StatisticManager::GetInstance().GetBindStat();
            ParseGetBindNumMsg(info);
            break;
        case QsOperType::RELATION_PROCESS: {
            // get message from mbuf, eventid also in mbuf
            Mbuf *mBuf = nullptr;
            const auto resultCode = ParseRelationInfo(&mBuf);
            if (resultCode != BQS_STATUS_OK) {
                BQS_LOG_ERROR("[RouterServer]Get detail message from mbuf failed ret[%d].",
                              static_cast<int32_t>(resultCode));
                SendRspEvent(static_cast<int32_t>(resultCode));
                if ((mBuf != nullptr) && (srcVersion_ != 0U)) {
                    const auto freeRet = halMbufFree(mBuf);
                    BQS_LOG_ERROR_WHEN(freeRet != static_cast<int32_t>(DRV_ERROR_NONE),
                                       "Free mbuf failed, ret is %d", freeRet);
                }
                return;
            }

            BQS_LOG_INFO("[RouterServer]Start to process relation event[%u].", subEventId_);
            ProcessQueueRelationEvent(mBuf);
            break;
        }
        case QsOperType::UPDATE_CONFIG:
        case QsOperType::CREATE_HCOM_HANDLE:
        case QsOperType::DESTROY_HCOM_HANDLE:
        case QsOperType::QUERY_CONFIG:
        case QsOperType::QUERY_CONFIG_NUM: {
            ProcessConfigEvent(operType);
            break;
        }
        case QsOperType::QUERY_LINKSTATUS: {
            ProcessQueryLinkStatusEvent();
            break;
        }
        case QsOperType::QUERY_LINKSTATUS_V2: {
            ProcessQueryLinkStatusEvent();
            break;
        }
        default: {
            SendRspEvent(static_cast<int32_t>(BQS_STATUS_PARAM_INVALID));
            BQS_LOG_RUN_INFO("[RouterServer]RouterServer receive unsupported msg type:%u", subEventId_);
            break;
        }
    }
    return;
}

void RouterServer::ProcessConfigEvent(const QsOperType operType)
{
    void *mbuf = nullptr;
    auto drvRet = halQueueDeQueue(deviceId_, pipelineQueueId_, &mbuf);
    if ((drvRet != DRV_ERROR_NONE) || (mbuf == nullptr)) {
        BQS_LOG_ERROR("halQueueDeQueue from queue[%u] in device[%u] failed, error[%d]", pipelineQueueId_.load(),
            deviceId_, static_cast<int32_t>(drvRet));
        SendRspEvent(static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR));
        return;
    }
    auto resultCode = (cfgInfoOperator_ == nullptr) ? BQS_STATUS_INNER_ERROR :
        cfgInfoOperator_->ParseConfigEvent(subEventId_, pipelineQueueId_, mbuf, srcVersion_);
    if (resultCode == BQS_STATUS_WAIT) {
        resultCode = WaitSyncMsgProc();
    }
    if (operType == QsOperType::CREATE_HCOM_HANDLE) {
        callHcclFlag_ = true;
    }

    if (srcVersion_ != 0U) {
        BQS_LOG_INFO("Enque mbuf back");
        drvRet = halQueueEnQueue(deviceId_, pipelineQueueId_, mbuf);
        if (drvRet != DRV_ERROR_NONE) {
            BQS_LOG_ERROR("halQueueEnQueue into queue[%u] in device[%u] failed, error[%d]", pipelineQueueId_.load(),
                deviceId_, static_cast<int32_t>(drvRet));
            SendRspEvent(static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR));
            const auto freeRet = halMbufFree(PtrToPtr<void, Mbuf>(mbuf));
            BQS_LOG_ERROR_WHEN(freeRet != static_cast<int32_t>(DRV_ERROR_NONE),
                               "Free mbuf failed, ret is %d", freeRet);
            return;
        }
    }
    BQS_LOG_INFO("config for operate[%d] resultCode is %d.", static_cast<int32_t>(operType),
        static_cast<int32_t>(resultCode));
    SendRspEvent(static_cast<int32_t>(resultCode));
}

void RouterServer::ProcessQueryLinkStatusEvent()
{
    int32_t ret = static_cast<int32_t>(dgw::EntityManager::Instance(0U).CheckLinkStatus());
    if ((ret == 0) && numaFlag_) {
        ret = static_cast<int32_t>(dgw::EntityManager::Instance(1U).CheckLinkStatus());
    }
    SendRspEvent(ret);
}

void RouterServer::ProcessQueueRelationEvent(Mbuf *mbuf)
{
    BqsStatus ret = BQS_STATUS_INNER_ERROR;
    switch (subEventId_) {
        case AICPU_BIND_QUEUE: {
            StatisticManager::GetInstance().BindStat();
            ret = WaitBindMsgProc();
            break;
        }
        case ACL_BIND_QUEUE: {
            StatisticManager::GetInstance().BindStat();
            ret = WaitBindMsgProc();
            break;
        }
        case AICPU_UNBIND_QUEUE: {
            StatisticManager::GetInstance().UnbindStat();
            ret = WaitBindMsgProc();
            break;
        }
        case ACL_UNBIND_QUEUE: {
            StatisticManager::GetInstance().UnbindStat();
            ret = WaitBindMsgProc();
            break;
        }
        case AICPU_QUERY_QUEUE: {
            StatisticManager::GetInstance().GetBindStat();
            ret = ParseGetBindDetailMsg();
            break;
        }
        case ACL_QUERY_QUEUE: {
            StatisticManager::GetInstance().GetBindStat();
            ret = ParseGetBindDetailMsg();
            break;
        }
        default:
            BQS_LOG_ERROR("[RouterServer]unsupport subEventId[%u] in bind relation procedure", subEventId_);
            break;
    }

    if (srcVersion_ != 0U) {
        BQS_LOG_INFO("Enque mbuf back.");
        const auto drvRet = halQueueEnQueue(deviceId_, pipelineQueueId_, mbuf);
        if (drvRet != DRV_ERROR_NONE) {
            BQS_LOG_ERROR("halQueueEnQueue into queue[%u] in device[%u] failed, error[%d].", pipelineQueueId_.load(),
                deviceId_, static_cast<int32_t>(drvRet));
            SendRspEvent(static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR));
            const auto freeRet = halMbufFree(mbuf);
            BQS_LOG_ERROR_WHEN(freeRet != static_cast<int32_t>(DRV_ERROR_NONE),
                               "Free mbuf failed, ret is %d", freeRet);
            return;
        }
    }
    SendRspEvent(static_cast<int32_t>(ret));
    return;
}

BqsStatus RouterServer::WaitBindMsgProc()
{
    BQS_LOG_INFO("[RouterServer]Bind relation [add/del], stage [wait]");
    auto ret = ParseBindUnbindMsg();
    if (ret == BQS_STATUS_OK) {
        ret = WaitSyncMsgProc();
    }
    BQS_LOG_INFO("[RouterServer]RouterServer WaitBindMsgProc end");
    return ret;
}

BqsStatus RouterServer::AttachAndInitGroup()
{
    BQS_LOG_INFO("[RouterServer]Attach and init group begin.");
    int32_t drvRet = 0;
    // 针对aicpusd 与qs合设的情况，如果qs以模块方式启动，则不需要重复加组，因为aicpusd已经加组
    if (qsInitGroupName_.empty() && (!SubModuleInterface::GetInstance().GetStartFlag())) {
        const std::unique_ptr<GroupQueryOutput> groupInfoPtr(new (std::nothrow) GroupQueryOutput());
        if (groupInfoPtr == nullptr) {
            BQS_LOG_ERROR("[RouterServer] Fail to allocate GroupQueryOutput");
            return BQS_STATUS_INNER_ERROR;
        }
        GroupQueryOutput &groupInfo = *(groupInfoPtr.get());
        uint32_t groupInfoLen = 0U;
        pid_t curPid = drvDeviceGetBareTgid();
        // query group info for current qs process
        drvRet = halGrpQuery(GRP_QUERY_GROUPS_OF_PROCESS, &curPid, static_cast<uint32_t>(sizeof(curPid)),
                             reinterpret_cast<void *>(&groupInfo), &groupInfoLen);
        if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
            BQS_LOG_ERROR("[RouterServer]halGrpQuery of qs[%d] failed before attached,ret[%d]", curPid, drvRet);
            return BQS_STATUS_DRIVER_ERROR;
        }
        // not in any group, can not do attach process
        if (groupInfoLen == 0U) {
            BQS_LOG_ERROR("[RouterServer]QS should be add sharepool group before initial by aicpu or acl.");
            return BQS_STATUS_INNER_ERROR;
        }
        if ((groupInfoLen % sizeof(groupInfo.grpQueryGroupsOfProcInfo[0])) != 0U) {
            BQS_LOG_ERROR("[RouterServer]Group info size[%d] is invalid", groupInfoLen);
            return BQS_STATUS_DRIVER_ERROR;
        }
        const uint32_t groupNum = static_cast<uint32_t>(groupInfoLen / sizeof(groupInfo.grpQueryGroupsOfProcInfo[0]));
        for (uint32_t i = 0U; i < groupNum; ++i) {
        // attach and initial
            drvRet = halGrpAttach(groupInfo.grpQueryGroupsOfProcInfo[i].groupName, 0);
            if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
                BQS_LOG_ERROR("[RouterServer]Group[%s] attach failed for slave aicpusd[%d] ret[%d]",
                              groupInfo.grpQueryGroupsOfProcInfo[i].groupName, curPid, drvRet);
                return BQS_STATUS_DRIVER_ERROR;
            }
            BQS_LOG_INFO("[RouterServer] halGrpAttach execute succ. group[%s] was attached by QS",
                         groupInfo.grpQueryGroupsOfProcInfo[i].groupName);
        }
    }
    attachedFlag_ = true;
    BuffCfg defaultCfg = {};
    drvRet = halBuffInit(&defaultCfg);
    if ((drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) &&
        (drvRet != static_cast<int32_t>(DRV_ERROR_REPEATED_INIT))) {
        BQS_LOG_ERROR("[RouterServer] Buffer initial failed for qs. ret[%d]", drvRet);
        return BQS_STATUS_DRIVER_ERROR;
    }
    BQS_LOG_INFO("[RouterServer] Buffer init success ret[%d]", drvRet);
    return BQS_STATUS_OK;
}

BqsStatus RouterServer::CreateAndGrantPipelineQueue()
{
    BQS_LOG_INFO("[RouterServer]Create and grant pipeline queue begin.");
   // do initial process
    const std::unique_lock<std::mutex> lk(mutex_);
    QueueAttr queAttr = {};
    std::string nameStr(PIPELINE_QUEUE_NAME);
    pid_t curPidTemp = 0;
    if (bqs::GetRunContext() == bqs::RunContext::HOST) {
        curPidTemp = getpid();
        queAttr.deploy_type = LOCAL_QUEUE_DEPLOY;
    } else {
        curPidTemp = drvDeviceGetBareTgid();
        queAttr.deploy_type = CLIENT_QUEUE_DEPLOY;
    }
    const uint32_t curPid = static_cast<uint32_t>(curPidTemp);
    nameStr += std::to_string(curPid);
    const auto memcpyRet = memcpy_s(queAttr.name, static_cast<uint32_t>(QUEUE_MAX_STR_LEN),
                                    nameStr.c_str(), nameStr.length() + 1UL);
    if (memcpyRet != EOK) {
        BQS_LOG_ERROR("[RouterServer]CreateAndGrantPipelineQueue memcpy_s failed, ret=%d.", memcpyRet);
        return BQS_STATUS_INNER_ERROR;
    }
    queAttr.depth = 2U;
    uint32_t queueId = 0U;
    // create queue
    auto drvRet = halQueueCreate(deviceId_, &queAttr, &queueId);
    if ((drvRet != DRV_ERROR_NONE) || (queueId >= MAX_QUEUE_ID_NUM)) {
        BQS_LOG_ERROR("[RouterServer]Create queue[%s] error or qID[%u] is invalid, ret[%d]",
                      PIPELINE_QUEUE_NAME.c_str(), queueId, static_cast<int32_t>(drvRet));
        return BQS_STATUS_DRIVER_ERROR;
    }
    drvRet =  halQueueAttach(deviceId_, queueId, 0);
    if (drvRet != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("Fail to attach queue[%ud], result[%d]", queueId, static_cast<int32_t>(drvRet));
        return BQS_STATUS_DRIVER_ERROR;
    }
    pipelineQueueId_ = queueId;
    if (deployMode_ == QueueSchedulerRunMode::MULTI_THREAD) {
        BQS_LOG_INFO("[RouterServer]Thread mode need not grant queue to other process");
        return BQS_STATUS_OK;
    }
    // grant pipeline queue to src process

    drvRet = halQueueGrant(deviceId_, static_cast<int32_t>(queueId), srcPid_, ADMIN_QUEUE_ATTR);
    if (drvRet != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("[RouterServer]Fail to add queue[%d] authority for aicpusd[%d], result[%d].",
                      queueId, srcPid_, static_cast<int32_t>(drvRet));
        return BQS_STATUS_DRIVER_ERROR;
    }
    BQS_LOG_RUN_INFO("Success to init pipelineQ[%u].", pipelineQueueId_.load());
    return BQS_STATUS_OK;
}

BqsStatus RouterServer::ProcessBindInit(const event_info &info)
{
    if (info.priv.msg_len != sizeof(QsBindInit)) {
        BQS_LOG_ERROR("[RouterServer]Bind initial event message invalid, msgLen[%u]", info.priv.msg_len);
        return BQS_STATUS_PARAM_INVALID;
    }
    // bind initial already done
    if ((pipelineQueueId_ < MAX_QUEUE_ID_NUM) && (srcPid_ != -1)) {
        BQS_LOG_RUN_INFO("Pipeline queue already existed[%d], return pipelienQueueid", pipelineQueueId_.load());
        return BQS_STATUS_OK;
    }
    const QsBindInit * const bindInitMsg = reinterpret_cast<const QsBindInit *>(info.priv.msg);
    aicpuRspHead_ = bindInitMsg->syncEventHead;
    srcPid_ = bindInitMsg->pid;
    srcVersion_ = bindInitMsg->majorVersion;
    srcGroupId_ = static_cast<int32_t>(bindInitMsg->grpId);
    BQS_LOG_RUN_INFO("[RouterServer]Get hostpid[%d] srcGroup[%d], srcVersion[%u]",
                     srcPid_, srcGroupId_.load(), srcVersion_);

    // process mode need to attach group at first
    if (((deployMode_ == QueueSchedulerRunMode::SINGLE_PROCESS) ||
         (deployMode_ == QueueSchedulerRunMode::MULTI_PROCESS)) && (!attachedFlag_)) {
        BQS_LOG_INFO("[RouterServer]start up attach and init group.");
        const auto attachRet = AttachAndInitGroup();
        if (attachRet != BQS_STATUS_OK) {
            BQS_LOG_ERROR("[RouterServer]AttachAndInitGroup failed, ret[%d].", static_cast<int32_t>(attachRet));
            return attachRet;
        }
    }

    if (qsInitGroupName_.empty()) {
        auto queueInitRet = QueueManager::GetInstance().InitQueue();
        if (queueInitRet != BQS_STATUS_OK) {
            BQS_LOG_ERROR("[RouterServer] Queue init failed");
            return queueInitRet;
        }
        if (numaFlag_) {
            queueInitRet = QueueManager::GetInstance().InitQueueExtra();
            if (queueInitRet != BQS_STATUS_OK) {
                BQS_LOG_ERROR("[RouterServer] Queue init failed");
                return queueInitRet;
            }
        }
    }

    const auto ret = CreateAndGrantPipelineQueue();
    if (ret != BQS_STATUS_OK) {
        return ret;
    }
    BQS_LOG_RUN_INFO("First bind initial success, srcPid[%d], srvGroupId[%d], pipelineQueueId[%u]",
                     srcPid_, srcGroupId_.load(), pipelineQueueId_.load());
    return BQS_STATUS_OK;
}

void RouterServer::FillRspContent(QsProcMsgRsp &retRsp, const int32_t resultCode)
{
    // only aicpu event need fill in aicpuRspHead
    retRsp.syncEventHead = isAicpuEvent_ ? aicpuRspHead_ : 0UL;
    retRsp.retCode = resultCode;
    retRsp.minorVersion = MINOR_VERSION;
    retRsp.majorVersion = MAJOR_VERSION;
    if ((subEventId_ == static_cast<uint32_t>(AICPU_BIND_QUEUE_INIT)) ||
        (subEventId_ == static_cast<uint32_t>(ACL_BIND_QUEUE_INIT))) {
        // init message return pipelineID
        retRsp.retValue = (resultCode == static_cast<int32_t>(BQS_STATUS_OK)) ? pipelineQueueId_.load()
                                                                              : MAX_QUEUE_ID_NUM;
    }
    if ((subEventId_ == static_cast<uint32_t>(AICPU_QUERY_QUEUE_NUM)) ||
        (subEventId_ == static_cast<uint32_t>(ACL_QUERY_QUEUE_NUM))) {
        // query num message return bind num
        retRsp.retValue = (resultCode != static_cast<int32_t>(BQS_STATUS_OK)) ? 0U :
            static_cast<uint32_t>(queueRouteQueryList_.size());
        queueRouteQueryList_.clear();
    }
    if ((subEventId_ == static_cast<uint32_t>(AICPU_QUERY_QUEUE)) ||
        (subEventId_ == static_cast<uint32_t>(ACL_QUERY_QUEUE)) ||
        (subEventId_ == static_cast<uint32_t>(AICPU_BIND_QUEUE)) ||
        (subEventId_ == static_cast<uint32_t>(ACL_BIND_QUEUE)) ||
        (subEventId_ == static_cast<uint32_t>(AICPU_UNBIND_QUEUE)) ||
        (subEventId_ == static_cast<uint32_t>(ACL_UNBIND_QUEUE))) {
        retRsp.retValue = pipelineQueueId_;
    }
    return;
}

void RouterServer::SendRspEvent(const int32_t result)
{
    BQS_LOG_INFO("[RouterServer]Start to response message subeventid[%u]", subEventId_);
    QsProcMsgRsp retRsp = {};
    FillRspContent(retRsp, result);
    event_summary qsEvent = {};
    qsEvent.msg = PtrToPtr<QsProcMsgRsp, char_t>(&retRsp);
    qsEvent.msg_len = static_cast<uint32_t>(sizeof(retRsp));
    auto drvRet = DRV_ERROR_NONE;
    if (!isAicpuEvent_) {
        BQS_LOG_INFO("[RouterServer] Do ACL response");
        qsEvent.dst_engine = compatMsg_ ? PtrToPtr<event_sync_msg, old_event_sync_msg>(drvSyncMsg_)->dst_engine
                                        : drvSyncMsg_->dst_engine;
        qsEvent.policy = ONLY;
        qsEvent.pid = compatMsg_ ? PtrToPtr<event_sync_msg, old_event_sync_msg>(drvSyncMsg_)->pid
                                 : drvSyncMsg_->pid;
        qsEvent.grp_id = compatMsg_ ? PtrToPtr<event_sync_msg, old_event_sync_msg>(drvSyncMsg_)->gid
                                    : drvSyncMsg_->gid;
        const int32_t eventId = compatMsg_ ? PtrToPtr<event_sync_msg, old_event_sync_msg>(drvSyncMsg_)->event_id
                                           : drvSyncMsg_->event_id;
        qsEvent.event_id = static_cast<EVENT_ID>(eventId);
        qsEvent.subevent_id = compatMsg_ ? PtrToPtr<event_sync_msg, old_event_sync_msg>(drvSyncMsg_)->subevent_id
                                         : drvSyncMsg_->subevent_id;
        drvRet = halEschedSubmitEvent(deviceId_, &qsEvent); // drv interface require use 0
        drvSyncMsg_ = nullptr;
        BQS_LOG_INFO("[SendRspEvent] dst_engine[%u], pid[%d], grp_id[%u], eventId[%d], subevent_id[%u], deviceId[%u]",
            qsEvent.dst_engine, qsEvent.pid, qsEvent.grp_id, qsEvent.event_id, qsEvent.subevent_id, deviceId_);
    } else {
        BQS_LOG_INFO("[RouterServer] Do AICPU response");
        qsEvent.pid = srcPid_;
        qsEvent.grp_id = static_cast<uint32_t>(srcGroupId_);
        qsEvent.event_id = EVENT_QS_MSG;
        qsEvent.msg_len = static_cast<uint32_t>(sizeof(QsProcMsgRspDstAicpu));
        const auto iter = g_reqRspMapping.find(static_cast<int32_t>(subEventId_));
        if (iter != g_reqRspMapping.end()) {
            qsEvent.subevent_id = static_cast<uint32_t>(iter->second);
        } else {
            BQS_LOG_ERROR("[RouterServer]ERROR Invalid subeventId[%u]", subEventId_);
        }
        drvRet = halEschedSubmitEvent(deviceId_, &qsEvent); // drv interface require use 0
        aicpuRspHead_ = 0UL;
    }
    BQS_LOG_ERROR_WHEN(drvRet != DRV_ERROR_NONE, "[RouterServer]ERROR failed to submit event[%u], result[%d].",
                       subEventId_, static_cast<int32_t>(drvRet));
    BQS_LOG_INFO("[RouterServer]Finish response message subeventid[%u] ret[%d]", subEventId_, result);
    qsRouteListPtr_ = nullptr;
    qsRouterHeadPtr_ = nullptr;
    subEventId_ = 0U;
    return;
}

void RouterServer::ProcessBindQueue(const uint32_t index)
{
    BQS_LOG_INFO("[RouterServer]Bind relation [add], stage [server:process].");
    auto &relationInstance = BindRelation::GetInstance();
    retCode_ = static_cast<int32_t>(BQS_STATUS_OK);
    QueueRoute *queueRouteList = qsRouteListPtr_;
    for (uint32_t i = 0U; i < qsRouterHeadPtr_->routeNum; ++i) {
        if (queueRouteList->status != static_cast<int32_t>(BQS_STATUS_OK)) {
            retCode_ = static_cast<int32_t>(BQS_STATUS_QUEUE_AHTU_ERROR);
            queueRouteList->status = 0;
            queueRouteList = queueRouteList + 1U;
            continue;
        }
        // only queue
        EntityInfo srcEntity = CreateBasicEntityInfo(queueRouteList->srcId,
                                                     static_cast<dgw::EntityType>(queueRouteList->srcType));
        EntityInfo dstEntity = CreateBasicEntityInfo(queueRouteList->dstId,
                                                     static_cast<dgw::EntityType>(queueRouteList->dstType));
        const auto result = relationInstance.Bind(srcEntity, dstEntity, index);
        if (result == BQS_STATUS_RETRY) {
            queueRouteList = queueRouteList + 1U;
            continue;
        } else if (result != BQS_STATUS_OK) {
            retCode_ = static_cast<int32_t>(result);
            queueRouteList->status = 0;
        } else {
            queueRouteList->status = 1;
        }
        queueRouteList = queueRouteList + 1U;
        BQS_LOG_RUN_INFO("Bind relation [add], stage [server:process], relation [src:%s, dst:%s, result:%d]",
            srcEntity.ToString().c_str(), dstEntity.ToString().c_str(), static_cast<int32_t>(result));
    }
    relationInstance.Order(index);
    return;
}

void RouterServer::ProcessUnbindQueue(const uint32_t index)
{
    BQS_LOG_INFO("[RouterServer]Unbind relation [del], stage [server:process].");
    QueueRoute *queueRouteList = qsRouteListPtr_;
    retCode_ = static_cast<int32_t>(BQS_STATUS_OK);
    auto &relationInstance = BindRelation::GetInstance();
    for (uint32_t i = 0U; i < qsRouterHeadPtr_->routeNum; ++i) {
        if (queueRouteList->status != static_cast<int32_t>(BQS_STATUS_OK)) {
            retCode_ = static_cast<int32_t>(BQS_STATUS_QUEUE_ID_ERROR);
            queueRouteList->status = 1;
            queueRouteList = queueRouteList + 1U;
            continue;
        }
        EntityInfo srcEntity = CreateBasicEntityInfo(queueRouteList->srcId,
                                                     static_cast<dgw::EntityType>(queueRouteList->srcType));
        EntityInfo dstEntity = CreateBasicEntityInfo(queueRouteList->dstId,
                                                     static_cast<dgw::EntityType>(queueRouteList->dstType));
        const auto result = relationInstance.UnBind(srcEntity, dstEntity, index);
        if (result == BQS_STATUS_RETRY) {
            queueRouteList = queueRouteList + 1U;
            continue;
        } else if (result != BQS_STATUS_OK) {
            retCode_ = static_cast<int32_t>(result);
            queueRouteList->status = 1;
        } else {
            queueRouteList->status = 0;
        }
        queueRouteList = queueRouteList + 1U;
        BQS_LOG_RUN_INFO("Bind relation [del], stage [server:process], relation [src %s," \
            "dst %s, result:%d]",
            srcEntity.ToString().c_str(), dstEntity.ToString().c_str(), static_cast<int32_t>(result));
    }
    relationInstance.Order(index);
    return;
}

/**
 * Bqs server enqueue bind msg request process
 * @return NA
 */
void RouterServer::BindMsgProc(const uint32_t index)
{
    BQS_LOG_INFO("[RouterServer]RouterServer BindMsgProc begin.");
    auto &processing = (index == 0U) ? processing_ : processingExtra_;
    auto &done = (index == 0U) ? done_ : doneExtra_;

    const std::unique_lock<std::mutex> lk(mutex_);
    processing = true;

    // parse bind and unbind BQSMsg
    if ((subEventId_ == static_cast<uint32_t>(AICPU_BIND_QUEUE)) ||
        (subEventId_ == static_cast<uint32_t>(ACL_BIND_QUEUE))) {
        ProcessBindQueue(index);
    } else if ((subEventId_ == static_cast<uint32_t>(AICPU_UNBIND_QUEUE)) ||
               (subEventId_ == static_cast<uint32_t>(ACL_UNBIND_QUEUE))) {
        ProcessUnbindQueue(index);
    } else if ((subEventId_ == static_cast<uint32_t>(QueueSubEventType::UPDATE_CONFIG))) {
        retCode_ = (cfgInfoOperator_ == nullptr) ? static_cast<int32_t>(BQS_STATUS_INNER_ERROR) :
            static_cast<int32_t>(cfgInfoOperator_->ProcessUpdateConfig(index));
        BQS_LOG_INFO("[RouterServer] Process update config ret is %d.", retCode_);
    } else {
        BQS_LOG_ERROR("[RouterServer]Invalid subEventId_[%d] in bind relation process.", subEventId_);
    }

    processing = false;
    done = true;
    cv_.notify_one();

    BQS_LOG_INFO("[RouterServer]RouterServer BindMsgProc end.");
    return;
}

/**
 * Init bqs server, including init easycomm server and bind relation
 * @return BQS_STATUS_OK:success other:failed
 */
BqsStatus RouterServer::InitRouterServer(const InitQsParams &params)
{
    BQS_LOG_INFO("[RouterServer]RouterServer Init begin");
    (void)signal(SIGPIPE, SIG_IGN);

    qsInitGroupName_ = params.qsInitGrpName;
    f2nfGroupId_ = params.f2nfGroupId;
    schedPolicy_ = params.schedPolicy;
    // create config info operator
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(params.deviceId, qsInitGroupName_));
    if (cfgInfoOperator_ == nullptr) {
        BQS_LOG_ERROR("malloc memory for cfgInfoOperator_ failed.");
        return BQS_STATUS_INNER_ERROR;
    }
    SubscribeBufEvent();

    if (!running_) {
        running_ = true;
        deviceId_ = params.deviceId;
        deployMode_ = params.runMode;
        numaFlag_ = params.numaFlag;
        needAttachGroup_ = params.needAttachGroup;
        // halShrIdGetAttribute为新版驱动中才存在的接口，若没有，说明驱动为老版本，需兼容处理
        if ((bqs::GetRunContext() == bqs::RunContext::HOST) && (&halShrIdGetAttribute == nullptr)) {
            compatMsg_ = true;
        }
        BQS_LOG_INFO("compatMsg_ is %d", compatMsg_);

        try {
            monitorQsEvent_ = std::thread(&RouterServer::ManageQsEvent, this);
        } catch(std::exception &threadException) {
            BQS_LOG_ERROR("RouterServer Init thread failure, %s", threadException.what());
            return BQS_STATUS_INNER_ERROR;
        }

        std::unique_lock<std::mutex> lk(manageThreadMutex_);
        manageThreadCv_.wait(lk, [this] { return manageThreadStatus_ != ThreadStatus::NOT_INIT; });
        if (manageThreadStatus_ != ThreadStatus::INIT_SUCCESS) {
            BQS_LOG_ERROR("RouterServer thread fail to start");
            return BQS_STATUS_INNER_ERROR;
        }

        BQS_LOG_INFO("[RouterServer]RouterServer Init success.");
    } else {
        BQS_LOG_WARN("RouterServer is already inited");
    }
    return BQS_STATUS_OK;
}

BqsStatus RouterServer::ParseRelationInfo(Mbuf **mbufPtr)
{
    Mbuf *mBuf = nullptr;
    const auto drvRet = halQueueDeQueue(deviceId_, pipelineQueueId_, PtrToPtr<Mbuf *, void*>(&mBuf));
    if ((drvRet != DRV_ERROR_NONE) || (mBuf == nullptr)) {
            BQS_LOG_ERROR("[RouterServer]halQueueDeQueue from queue[%u] in device[%u] failed, error[%d]",
                          pipelineQueueId_.load(), deviceId_, static_cast<int32_t>(drvRet));
            return BQS_STATUS_DRIVER_ERROR;
    }
    *mbufPtr = mBuf;
    qsRouterHeadPtr_ = nullptr;
    const auto getBuffRet = halMbufGetBuffAddr(mBuf, reinterpret_cast<void **>(&qsRouterHeadPtr_));
    if ((getBuffRet != static_cast<int32_t>(DRV_ERROR_NONE)) || (qsRouterHeadPtr_ == nullptr)) {
        BQS_LOG_ERROR("[RouterServer]halMbufGetBuffAddr from queue[%u] in device[%u] failed, error[%d]",
                      pipelineQueueId_.load(), deviceId_, getBuffRet);
        return BQS_STATUS_DRIVER_ERROR;
    }
    if (isAicpuEvent_) {
        aicpuRspHead_ = qsRouterHeadPtr_->userData;
    }
    // aicpuRspHead_ is valid only in aicpu event senario, will be 0 in acl event senario
    subEventId_ = qsRouterHeadPtr_->subEventId;
    BQS_LOG_INFO("[RouterServer]Parse head[%u] subEvnetId[%u] from mbuff success.", aicpuRspHead_, subEventId_);

    // query message need to get query info
    if ((subEventId_ == static_cast<uint32_t>(AICPU_QUERY_QUEUE)) ||
        (subEventId_ == static_cast<uint32_t>(ACL_QUERY_QUEUE))) {
        if ((((qsRouterHeadPtr_->routeNum * sizeof(QueueRoute)) + sizeof(QsRouteHead)) + sizeof(QueueRouteQuery)) !=
             qsRouterHeadPtr_->length) {
            BQS_LOG_ERROR("[RouterServer]RouteNum[%d] is inconsistence with dataLen[%d] in subEventId[%u]",
                          qsRouterHeadPtr_->routeNum, qsRouterHeadPtr_->length, subEventId_);
            return BQS_STATUS_PARAM_INVALID;
        }
        qsRouterQueryPtr_ = reinterpret_cast<QueueRouteQuery *>(
            reinterpret_cast<uint8_t *>(qsRouterHeadPtr_) + sizeof(QsRouteHead));
        BQS_LOG_INFO("[RouterServer]Get query info success. queryType[%d]", qsRouterQueryPtr_->queryType);
        qsRouteListPtr_ = reinterpret_cast<QueueRoute *>(
            reinterpret_cast<uint8_t *>(qsRouterQueryPtr_) + sizeof(QueueRouteQuery));
    } else {
        if (((qsRouterHeadPtr_->routeNum * sizeof(QueueRoute)) + sizeof(QsRouteHead)) != qsRouterHeadPtr_->length) {
            BQS_LOG_ERROR("[RouterServer]RouteNum[%d] is inconsistence with dataLen[%d] in subEventId[%u]",
                          qsRouterHeadPtr_->routeNum, qsRouterHeadPtr_->length, subEventId_);
            return BQS_STATUS_PARAM_INVALID;
        }
        qsRouterQueryPtr_ = nullptr;
        qsRouteListPtr_ = reinterpret_cast<QueueRoute *>(
            reinterpret_cast<uint8_t *>(qsRouterHeadPtr_) + sizeof(QsRouteHead));
    }
    BQS_LOG_INFO("[RouterServer]Get relation mbuff success, bind/unbind queue num[%d]", qsRouterHeadPtr_->routeNum);
    return BQS_STATUS_OK;
}

BqsStatus RouterServer::ParseBindUnbindMsg() const
{
    BQS_LOG_INFO("[RouterServer]Bind relation [add/del], stage [server:parse and check]");
    auto resultCode = BQS_STATUS_QUEUE_AHTU_ERROR;
    QueueRoute *queueRouteList = qsRouteListPtr_;
    for (uint32_t i = 0U; i < qsRouterHeadPtr_->routeNum; ++i) {
        EntityInfo srcEntity = CreateBasicEntityInfo(queueRouteList->srcId,
                                                     static_cast<dgw::EntityType>(queueRouteList->srcType));
        EntityInfo dstEntity = CreateBasicEntityInfo(queueRouteList->dstId,
                                                     static_cast<dgw::EntityType>(queueRouteList->dstType));
        BQS_LOG_INFO("[RouterServer]Src[id:%u type:%d] Dst[id:%u type:%d]", srcEntity.GetId(), srcEntity.GetType(),
            dstEntity.GetId(), dstEntity.GetType());
        if ((srcEntity.GetId() >= MAX_QUEUE_ID_NUM) || (dstEntity.GetId() >= MAX_QUEUE_ID_NUM)) {
            BQS_LOG_ERROR("[RouterServer]Src[%s] or Dst[%s] is invalid in this "
                "bind/unbind relation", srcEntity.ToString().c_str(), dstEntity.ToString().c_str());
            queueRouteList->status = static_cast<int32_t>(BQS_STATUS_QUEUE_ID_ERROR);
            queueRouteList = queueRouteList + 1;
            continue;
        }
        // preprocess: do attach queue and check src own read auth, dst own write auth
        if ((subEventId_ == static_cast<uint32_t>(AICPU_BIND_QUEUE)) ||
            (subEventId_ == static_cast<uint32_t>(ACL_BIND_QUEUE))) {
            const auto ret = (cfgInfoOperator_ == nullptr) ? BQS_STATUS_INNER_ERROR :
                cfgInfoOperator_->AttachAndCheckQueue(srcEntity, dstEntity);
            if (ret != BQS_STATUS_OK) {
                BQS_LOG_ERROR("[RouterServer]Src[%s] Dst[%s] do attach queue "
                    "and check auth failed", srcEntity.ToString().c_str(), dstEntity.ToString().c_str());
                queueRouteList->status = static_cast<int32_t>(BQS_STATUS_QUEUE_AHTU_ERROR);
                queueRouteList = queueRouteList + 1;
                continue;
            }
        }
        resultCode = BQS_STATUS_OK;
        queueRouteList->status = static_cast<int32_t>(BQS_STATUS_OK);
        queueRouteList = queueRouteList + 1;
    }
    BQS_LOG_INFO("[RouterServer]Finish parse bind/unbind message,resultCode[%d]", static_cast<int32_t>(resultCode));
    return resultCode;
}

void RouterServer::FillRoutes(const EntityInfo &src, const EntityInfo &dst, const BindRelationStatus status)
{
    QueueRoute queueRouteInfo = {};
    queueRouteInfo.srcId = src.GetId();
    queueRouteInfo.dstId = dst.GetId();
    queueRouteInfo.srcType = static_cast<int16_t>(src.GetType());
    queueRouteInfo.dstType = static_cast<int16_t>(dst.GetType());
    queueRouteInfo.status = static_cast<int32_t>(status);
    queueRouteQueryList_.emplace_back(queueRouteInfo);
}

void RouterServer::SearchRelation(const MapEnitityInfoToInfoSet &relationMap, const EntityInfo& entityInfo,
    const BindRelationStatus status, bool bySrc)
{
    const auto iter = relationMap.find(entityInfo);
    if (iter == relationMap.end()) {
        return;
    }
    const auto dstSet = iter->second;
    BQS_LOG_INFO("[RouterServer]Bind relation [get], stage [server:process], relation [size:%zu].", dstSet.size());
    if (bySrc) {
        for (auto setIter = dstSet.begin(); setIter != dstSet.end(); ++setIter) {
            FillRoutes(entityInfo, *setIter, status);
        }
        return;
    }

    for (auto setIter = dstSet.begin(); setIter != dstSet.end(); ++setIter) {
        FillRoutes(*setIter, entityInfo, status);
    }
}

/**
 * Assembly response of get bind message according to src entity
 * @return Number of query results
 */
void RouterServer::GetBindRspBySingle(const EntityInfo& entityInfo, const uint32_t &queryType)
{
    BQS_LOG_INFO("[RouterServer]RouterServer serialize get bind rsponse by entityId[%u], entityType[%d], Type[%d].",
        entityInfo.GetId(), entityInfo.GetType(), queryType);
    auto &relationInstance = BindRelation::GetInstance();
    queueRouteQueryList_.clear();
    if ((queryType != static_cast<uint32_t>(BQS_QUERY_TYPE_SRC)) &&
        (queryType != static_cast<uint32_t>(BQS_QUERY_TYPE_DST))) {
        BQS_LOG_ERROR("[RouterServer]QueryType[%d] is not supported.", queryType);
        return;
    }

    if (queryType == static_cast<uint32_t>(BQS_QUERY_TYPE_SRC)) {
        SearchRelation(relationInstance.GetSrcToDstRelation(), entityInfo, BindRelationStatus::RelationBind, true);
        if (numaFlag_) {
            SearchRelation(relationInstance.GetSrcToDstExtraRelation(), entityInfo,
                BindRelationStatus::RelationBind, true);
        }
        SearchRelation(relationInstance.GetAbnormalSrcToDstRelation(), entityInfo,
            BindRelationStatus::RelationAbnormalForQError, true);

        if (queueRouteQueryList_.empty()) {
            BQS_LOG_WARN("[RouterServer] record does not exist according to src entityId:[%u]", entityInfo.GetId());
        }
    } else {
        SearchRelation(relationInstance.GetDstToSrcRelation(), entityInfo, BindRelationStatus::RelationBind, false);
        if (numaFlag_) {
            SearchRelation(relationInstance.GetDstToSrcExtraRelation(), entityInfo,
                BindRelationStatus::RelationBind, false);
        }
        SearchRelation(relationInstance.GetAbnormalDstToSrcRelation(), entityInfo,
            BindRelationStatus::RelationAbnormalForQError, false);
    }
    if (queueRouteQueryList_.empty()) {
        BQS_LOG_WARN("RouterServer get relation according to dst:%u failed, record does not exist", entityInfo.GetId());
    }
}

bool RouterServer::FindRelation(const MapEnitityInfoToInfoSet &relationMap, const EntityInfo& srcInfo,
    const EntityInfo& dstInfo) const
{
    const auto srcIter = relationMap.find(srcInfo);
    return ((srcIter != relationMap.end()) && (srcIter->second.count(dstInfo) != 0UL));
}

void RouterServer::TransRouteWithEntityInfo(const EntityInfo& srcInfo, const EntityInfo& dstInfo, const int32_t status,
    QueueRoute &routeInfo) const
{
    routeInfo.srcId = srcInfo.GetId();
    routeInfo.dstId = dstInfo.GetId();
    routeInfo.srcType = static_cast<int16_t>(srcInfo.GetType());
    routeInfo.dstType = static_cast<int16_t>(dstInfo.GetType());
    routeInfo.status = static_cast<int32_t>(status);
}

/**
 * Assembly response of get bind message according to dst queueId, one-to-one relation
 * @return NA
 */
void RouterServer::GetBindRspByDouble(const EntityInfo& src, const EntityInfo& dst, const uint32_t &queryType)
{
    BQS_LOG_INFO("[RouterServer]RouterServer serialize get bind rsponse by srcId[%d], srcType[%d], dstId[%d], "
        "dstType[%d], Type[%d]",
        src.GetId(), src.GetType(), dst.GetId(), dst.GetType(), queryType);
    queueRouteQueryList_.clear();
    if (queryType == static_cast<uint32_t>(BQS_QUERY_TYPE_SRC_OR_DST)) {
        GetBindRspBySingle(src, static_cast<uint32_t>(BQS_QUERY_TYPE_SRC));
        if (queueRouteQueryList_.size() > 0UL) {
            return;
        }
        GetBindRspBySingle(dst, static_cast<uint32_t>(BQS_QUERY_TYPE_DST));
        return;
    }
    if (queryType == static_cast<uint32_t>(BQS_QUERY_TYPE_SRC_AND_DST)) {
        auto status = BindRelationStatus::RelationUnknown;
        if (FindRelation(BindRelation::GetInstance().GetSrcToDstRelation(), src, dst) ||
            (numaFlag_ && (FindRelation(BindRelation::GetInstance().GetSrcToDstExtraRelation(), src, dst)))) {
            status = BindRelationStatus::RelationBind;
        } else {
            if (FindRelation(BindRelation::GetInstance().GetAbnormalSrcToDstRelation(), src, dst)) {
                status = BindRelationStatus::RelationAbnormalForQError;
            }
        }

        if (status != BindRelationStatus::RelationUnknown) {
            QueueRoute queueRouteInfo = {};
            TransRouteWithEntityInfo(src, dst, static_cast<int32_t>(status), queueRouteInfo);
            queueRouteQueryList_.emplace_back(queueRouteInfo);
        }
        return;
    }
    BQS_LOG_ERROR("[RouterServer]QueryType[%d] is not supported.", queryType);
    return;
}

void RouterServer::GetAllAbnormalBind()
{
    BQS_LOG_INFO("[RouterServer]RouterServer serialize get all abnormal bind rsponse");
    queueRouteQueryList_.clear();
    auto &relationInstance = BindRelation::GetInstance();
    auto &abnormalSrcToDstRelation = relationInstance.GetAbnormalSrcToDstRelation();
    for (auto iter = abnormalSrcToDstRelation.begin(); iter != abnormalSrcToDstRelation.end(); ++iter) {
        const auto &src = iter->first;
        const auto &dstSet = iter->second;
        for (auto &dst : dstSet) {
            QueueRoute queueRouteInfo = {};
            TransRouteWithEntityInfo(src, dst, static_cast<int32_t>(BindRelationStatus::RelationAbnormalForQError),
                queueRouteInfo);
            queueRouteQueryList_.emplace_back(queueRouteInfo);
        }
    }
}

BqsStatus RouterServer::ProcessGetBindMsg(const uint32_t &queryType, const EntityInfo& src, const EntityInfo& dst)
{
    switch (queryType) {
        case BQS_QUERY_TYPE_SRC:
            GetBindRspBySingle(src, queryType);
            break;
        case BQS_QUERY_TYPE_DST:
            GetBindRspBySingle(dst, queryType);
            break;
        case BQS_QUERY_TYPE_SRC_OR_DST:
        case BQS_QUERY_TYPE_SRC_AND_DST:
            GetBindRspByDouble(src, dst, queryType);
            break;
        case BQS_QUERY_TYPE_ABNORMAL_FOR_QUEUE_ERROR:
            GetAllAbnormalBind();
            break;
        default:
            BQS_LOG_ERROR("[RouterServer]Unsupported query type"
                "{0:src, 1:dst, 2:src-or-dst, 3:src-and-dst, 100:abnormal-all}:%u", queryType);
            break;
    }

    if ((subEventId_ == static_cast<uint32_t>(AICPU_QUERY_QUEUE_NUM)) ||
        (subEventId_ == static_cast<uint32_t>(ACL_QUERY_QUEUE_NUM))) {
        return BQS_STATUS_OK;
    }

    if (queueRouteQueryList_.size() != qsRouterHeadPtr_->routeNum) {
        BQS_LOG_ERROR("[RouterServer]Prepare number[%d] is different with real route number[%zu].",
                      qsRouterHeadPtr_->routeNum,  queueRouteQueryList_.size());
        return BQS_STATUS_PARAM_INVALID;
    }
    for (size_t i = 0UL; i < qsRouterHeadPtr_->routeNum; i++) {
        *qsRouteListPtr_ = queueRouteQueryList_[i];
        BQS_LOG_INFO("[RouterServer]Query bind relation srcId[%u] srcType[%d] dstId[%u] dstType[%d]",
                     qsRouteListPtr_->srcId, static_cast<int32_t>(qsRouteListPtr_->srcType), qsRouteListPtr_->dstId,
                     static_cast<int32_t>(qsRouteListPtr_->dstType));
        qsRouteListPtr_ = qsRouteListPtr_ + 1;
    }
    queueRouteQueryList_.clear();
    return BQS_STATUS_OK;
}

void RouterServer::ParseGetBindNumMsg(const event_info &info)
{
    BQS_LOG_INFO("[RouterServer]Bind relation number [get], stage [server:process], type [request]");
    if (info.priv.msg_len != sizeof(QueueRouteQuery)) {
        BQS_LOG_ERROR("[RouterServer]Query event[%u] message invalid, msgLen[%u]", subEventId_, info.priv.msg_len);
        SendRspEvent(static_cast<int32_t>(BQS_STATUS_PARAM_INVALID));
        return;
    }
    const QueueRouteQuery * const queueRouteQuery = PtrToPtr<const char_t, const QueueRouteQuery>(info.priv.msg);
    // param syncEventHead is filled by drv when acl (call sync event interface)
    aicpuRspHead_ = isAicpuEvent_ ? queueRouteQuery->syncEventHead : 0UL;
    const uint32_t keyType = queueRouteQuery->queryType;
    const EntityInfo src = CreateBasicEntityInfo(queueRouteQuery->srcId,
                                                 static_cast<dgw::EntityType>(queueRouteQuery->srcType));
    const EntityInfo dst = CreateBasicEntityInfo(queueRouteQuery->dstId,
                                                 static_cast<dgw::EntityType>(queueRouteQuery->dstType));
    queueRouteQueryList_.clear();
    const auto ret = ProcessGetBindMsg(keyType, src, dst);
    SendRspEvent(static_cast<int32_t>(ret));
    return;
}

BqsStatus RouterServer::ParseGetBindDetailMsg()
{
    BQS_LOG_INFO("[RouterServer]Bind relation [get], stage [server:process], type [request]");
    if (qsRouterQueryPtr_ == nullptr) {
        BQS_LOG_ERROR("[RouterServer]qsRouterQuery should not be null pointer");
        return BQS_STATUS_INNER_ERROR;
    }
    const uint32_t keyType = qsRouterQueryPtr_->queryType;
    const EntityInfo src = CreateBasicEntityInfo(qsRouterQueryPtr_->srcId,
                                                 static_cast<dgw::EntityType>(qsRouterQueryPtr_->srcType));
    const EntityInfo dst = CreateBasicEntityInfo(qsRouterQueryPtr_->dstId,
                                                 static_cast<dgw::EntityType>(qsRouterQueryPtr_->dstType));
    queueRouteQueryList_.clear();
    const auto ret = ProcessGetBindMsg(keyType, src, dst);
    return ret;
}

ThreadStatus RouterServer::PrePareForManageThread()
{
    auto ret = halEschedAttachDevice(deviceId_);
    if ((ret != DRV_ERROR_NONE) && (ret != DRV_ERROR_PROCESS_REPEAT_ADD)) {
        BQS_LOG_ERROR("Failed to attach device[%u] for eSched, result[%d].", deviceId_, static_cast<int32_t>(ret));
        (void) AttachGroup();
        return ThreadStatus::INIT_FAIL;
    }
    ret = halEschedCreateGrp(deviceId_, bindQueueGroupId_, GRP_TYPE_BIND_CP_CPU);
    if (ret != DRV_ERROR_NONE) {
        (void)halEschedDettachDevice(deviceId_);
        BQS_LOG_ERROR("Failed to create bindQueueGroup, groupId[%u] result[%d].",
            bindQueueGroupId_, static_cast<int32_t>(ret));
        (void) AttachGroup();
        return ThreadStatus::INIT_FAIL;
    }
    // subsribe bind/unbind/query event
    const uint64_t eventBitmap = (1UL << static_cast<uint32_t>(EVENT_QS_MSG));
    BQS_LOG_INFO("[RouterServer]BindQueue group[%u] subscribe event, eventBitmap[%lu]",
        bindQueueGroupId_, eventBitmap);
    ret = halEschedSubscribeEvent(deviceId_, bindQueueGroupId_, 0U, eventBitmap);
    if (ret != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("[RouterServer]halEschedSubscribeEvent failed, groupId[%u] eventBitmap[%lu] result[%d].",
            bindQueueGroupId_, eventBitmap, static_cast<int32_t>(ret));
        (void) AttachGroup();
        return ThreadStatus::INIT_FAIL;
    }

    if (!AttachGroup()) {
        BQS_LOG_ERROR("[RouterServer] Fail to attach group");
        return ThreadStatus::INIT_FAIL;
    }
    BQS_LOG_RUN_INFO("[RouterServer] ManageQsEvent of RouterServer is ready.");
    return ThreadStatus::INIT_SUCCESS;
}

void RouterServer::ManageQsEvent()
{
    BQS_LOG_INFO("[RouterServer] Manage QS event of router server thread start");
    (void)pthread_setname_np(pthread_self(), ROUTER_SERVER_THREAD_NAME_PREFIX);

    if (bqs::GetRunContext() != bqs::RunContext::HOST) {
        const std::vector<uint32_t> &cpuIds = QueueScheduleInterface::GetInstance().GetCtrlCpuIds();
        // bind thread to ctrl cpu
        const pthread_t threadId = pthread_self();
        (void)BindCpuUtils::SetThreadAffinity(threadId, cpuIds);
    }

    {
        std::unique_lock<std::mutex> lk(manageThreadMutex_);
        manageThreadStatus_ = PrePareForManageThread();
        manageThreadCv_.notify_all();
        if (manageThreadStatus_ != ThreadStatus::INIT_SUCCESS) {
            return;
        }
    }

    struct event_info event = {};
    // default wait timeout 2s
    constexpr int32_t waitTimeout = 2000;
    while (running_) {
        const auto schedRet = halEschedWaitEvent(deviceId_, bindQueueGroupId_, 0U, waitTimeout, &event);
        if (schedRet == DRV_ERROR_NONE) {
            if (event.comm.event_id == EVENT_QS_MSG) {
                HandleBqsMsg(event);
            } else {
                BQS_LOG_WARN("Thread[%u] process unsupported eventId[%d] subEventId[%u].",
                    0, static_cast<int32_t>(event.comm.event_id), event.comm.subevent_id);
            }
        } else if (schedRet == DRV_ERROR_SCHED_WAIT_TIMEOUT) {
            BQS_LOG_DEBUG("ManageQsEvent bind/unbind/query event waiting timeout");
            continue;
        } else if (schedRet == DRV_ERROR_PARA_ERROR) {
            BQS_LOG_ERROR(
                "ManageQsEvent bind/unbind/query event failed, deviceId[%u] groupId[%u] error[%d].",
                deviceId_, bindQueueGroupId_, static_cast<int32_t>(schedRet));
            break;
        } else {
            // LOG ERROR
            BQS_LOG_ERROR(
                "ManageQsEvent bind/unbind/query event failed, deviceId[%u] groupId[%u] error[%d].",
                deviceId_, bindQueueGroupId_, static_cast<int32_t>(schedRet));
        }
    }
    BQS_LOG_INFO("[RouterServer] ManageQsEvent of RouterServer thread exit.");
}

BqsStatus RouterServer::SubscribeBufEvent() const
{
    BQS_LOG_INFO("[RouterServer] SubscribeBufEvent start.");
    const bool needSubBufEvent =
        static_cast<bool>(schedPolicy_  & static_cast<uint64_t>(SchedPolicy::POLICY_SUB_BUF_EVENT));
    if (!needSubBufEvent) {
        BQS_LOG_INFO("[RouterServer] needSubBufEvent is [%d]", static_cast<int32_t>(needSubBufEvent));
        return BQS_STATUS_OK;
    }
    // load hccl so
    dgw::HcclSoManager::GetInstance()->LoadSo();
    return BQS_STATUS_OK;
}

BqsStatus RouterServer::WaitSyncMsgProc()
{
    std::unique_lock<std::mutex> lk(mutex_);

    // waiting for aicpu thread processing
    done_ = false;
    // produce enqueue event
    auto ret = QueueManager::GetInstance().EnqueueRelationEvent();
    if (ret != BQS_STATUS_OK) {
        return ret;
    }

    // if numa_flag , produce extra enqueue event
    if (numaFlag_) {
        doneExtra_ = false;
        auto result = QueueManager::GetInstance().EnqueueRelationEventExtra();
        if (result != BQS_STATUS_OK) {
            return result;
        }
    }

    BQS_LOG_INFO("[RouterServer] update config[add/del group, bind/unbind route], stage [server:waiting]");
    (void)cv_.wait_for(lk, std::chrono::milliseconds(MAX_WAITING_NOTIFY), [this] { return done_ && doneExtra_; });
    while ((!done_ || !doneExtra_) && (processing_ || processingExtra_)) {
        cv_.wait(lk);
    }
    if (!done_ || !doneExtra_) {
        QueueManager::GetInstance().LogErrorRelationQueueStatus();
        BQS_LOG_ERROR("[RouterServer] update config[add/del group, bind/unbind route], stage [server:wait], timeout, "
            "relation queue[enqueue cnt:%lu, dequeue cnt:%lu].",
            StatisticManager::GetInstance().GetRelationEnqueCnt(),
            StatisticManager::GetInstance().GetRelationDequeCnt());
        return BQS_STATUS_TIMEOUT;
    }
    // get config process result
    ret = static_cast<BqsStatus>(retCode_);
    // rest retCode_ and updateCfgInfo_
    retCode_ = static_cast<int32_t>(BQS_STATUS_OK);
    return ret;
}

void RouterServer::NotifyInitSuccess()
{
    BQS_LOG_RUN_INFO("schedule finish initing, now router is ready to handle msg");
    readyToHandleMsg_ = true;
}

bool RouterServer::AttachGroup()
{
    if (!needAttachGroup_) {
        return true;
    }
    BQS_LOG_INFO("Begin to attach group");
    std::stringstream grpNameStream(qsInitGroupName_);
    std::string grpNameElement;
    std::vector<std::string> groupNameVec;
    while (getline(grpNameStream, grpNameElement, ',')) {
        groupNameVec.emplace_back(grpNameElement);
    }

    const int32_t halTimeOut = (RunContext::HOST == GetRunContext()) ? 3000 : -1;
    for (const auto &grpName : groupNameVec) {
        BQS_LOG_RUN_INFO("Begin to halGrpAttach group[%s].", grpName.c_str());
        const auto drvRet = halGrpAttach(grpName.c_str(), halTimeOut);
        if (drvRet != static_cast<int32_t>(DRV_ERROR_NONE)) {
            BQS_LOG_ERROR("halGrpAttach group[%s] failed. ret[%d]", grpName.c_str(), drvRet);
            return false;
        }
        BQS_LOG_RUN_INFO("halGrpAttach group[%s] success.", grpName.c_str());
    }
    return true;
}

EntityInfo RouterServer::CreateBasicEntityInfo(const uint32_t id, const dgw::EntityType eType) const
{
    OptionalArg args = {};
    args.eType = eType;
    return EntityInfo(id, deviceId_, &args);
}

}  // namespace bqs