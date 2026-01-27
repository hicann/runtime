/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CORE_AICPUSD_QUEUE_EVENT_PROCESS_H
#define CORE_AICPUSD_QUEUE_EVENT_PROCESS_H

#include <memory>
#include <mutex>
#include <string>
#include <unordered_map>
#include <set>
#include "aicpusd_drv_manager.h"
#include "aicpusd_common.h"
#include "aicpusd_util.h"
#include "ascend_hal.h"
#include "ascend_hal_define.h"
#include "qs_client.h"

namespace AicpuSchedule {
    constexpr uint32_t PROXY_SUBEVENT_CREATE_GROUP = 0U;
    constexpr uint32_t PROXY_SUBEVENT_ALLOC_MBUF = 1U;
    constexpr uint32_t PROXY_SUBEVENT_FREE_MBUF = 2U;
    constexpr uint32_t PROXY_SUBEVENT_COPY_QMBUF = 3U;
    constexpr uint32_t PROXY_SUBEVENT_ADD_GROUP = 4U;
    constexpr uint32_t PROXY_SUBEVENT_ALLOC_CACHE = 5U;

    struct ProxyMsgRsp {
        uint64_t mbufAddr;
        uint64_t dataAddr;
        int32_t retCode;
        char_t rsv[12];
    };

    struct ProxyMsgCreateGroup {
        uint64_t size;  //  max buf size in group, in KB
        char_t groupName[16];
        int64_t allocSize;  // alloc size when create group, 0: alloc by size, -1: not alloc, >0: alloc by allocSize
    };

    struct ProxyMsgAllocMbuf {
        uint64_t size;
        char_t rsv[24];
    };

    struct ProxyMsgFreeMbuf {
        uint64_t mbufAddr;
        char_t rsv[24];
    };

    struct ProxyMsgCopyQMbuf {
        uint64_t destAddr;
        uint32_t destLen;
        uint32_t queueId;
        char_t rsv[16];
    };

    struct ProxyMsgAddGroup {
        uint32_t admin : 1;     /* admin permission, can add other proc to grp */
        uint32_t read : 1;     /* rsv, not support */
        uint32_t write : 1;    /* read and write permission */
        uint32_t alloc : 1;
        int32_t  pid;
        char_t groupName[16];
        char_t rsv[8];
    };
#pragma pack(push, 1)
    struct ProxyMsgAllocCache {
        uint64_t memSize;
        uint32_t allocMaxSize;
        char_t rsv[20];
    };
#pragma pack(pop)

    class AicpuQueueEventProcess {
    public:
        /**
         * @ingroup AicpuQueueEventProcess
         * @brief get AicpuQueueEventProcess Singleton
         * @return AicpuQueueEventProcess Singleton
         */
        static AicpuQueueEventProcess &GetInstance();

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief process event from driver
         * @param [in] event: queue event from driver send by acl
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t ProcessDrvMsg(const event_info &event);

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief process event from acl or qs
         * @param [in] event: queue event from acl or qs
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t ProcessQsMsg(const event_info &event);

        int32_t ProcessProxyMsg(const event_info &event);

    private:
        AicpuQueueEventProcess() : initPipeline_(BindQueueInitStatus::UNINIT), qsPid_(0), pipelineQueueId_(0U),
            type_(CpType::MASTER), curPid_(drvDeviceGetBareTgid()) {}

        ~AicpuQueueEventProcess() = default;

        // Prohibit copy constructor, copy assignment, move constructor, move assignment
        AicpuQueueEventProcess(AicpuQueueEventProcess const&) = delete;
        AicpuQueueEventProcess& operator=(AicpuQueueEventProcess const&) = delete;
        AicpuQueueEventProcess(AicpuQueueEventProcess&&) = delete;
        AicpuQueueEventProcess& operator=(AicpuQueueEventProcess&&) = delete;

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief process queue event
         * @param [in] event: queue event
         * @param [out] needRes: whether need response
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t DoProcessDrvMsg(const event_info &event, bool &needRes);

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief process queue event
         * @param [in] event: queue event
         * @param [out] callback: callback msg return from queue evnet process
         * @param [out] qsProcMsgRsp: qs process result
         * @param [out] isRes: is qs response
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t DoProcessQsMsg(const event_info &event,
                               std::shared_ptr<CallbackMsg> &callback,
                               const bqs::QsProcMsgRspDstAicpu *&qsProcMsgRsp,
                               bool &isRes);

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief process acl bind queue init event
         * @param [in] event: queue event from driver send by acl
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t ProcessBindQueueInit(const event_info &event);

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief process qs bind queue init result
         * @param [in] event: queue event from driver send by qs
         * @param [out] callback: callback msg from bind queue init
         * @param [out] qsProcMsgRsp: qs process result
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t ProcessBindQueueInitRet(const event_info &event, std::shared_ptr<CallbackMsg> &callback,
            const bqs::QsProcMsgRspDstAicpu ** const qsProcMsgRsp);

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief process acl query queue num event
         * @param [in] event: queue event from driver send by acl
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t ProcessQueryQueueNum(const event_info &event);

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief send event to qs
         * @param [in] msg: event msg will sent to qs
         * @param [in] msgLen: msg len
         * @param [in] drvSubeventId: subevent id for event
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t SendEventToQs(char_t * const msg, const size_t msgLen,
            const bqs::QueueSubEventType drvSubeventId) const;

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief alloc mbuf for data and enqueue to cp and qs pipline queue
         * @param [in] data: need copy from svm to mbuf data
         * @param [in] size: data size
         * @param [out] buff: point to alloc mbuf pointer
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t AllocMbufAndEnqueue(const bqs::QsRouteHead * const data, const size_t size, Mbuf ** const buff);

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief response event to acl
         * @param [in] event: event info which need response
         * @param [in] msg: return to acl msg
         * @param [in] len: msg len
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t ResponseEvent(const event_info &event, const char_t * const msg, const size_t len) const;

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief query qs pid and init qs pid
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t QueryQsPid();

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief copy result from mbuf to svm
         * @param [in] callback: callback which event need to copy result
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t CopyResult(const std::shared_ptr<CallbackMsg> &callback) const;

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief check qs process event result
         * @param [in] event: event from driver send by qs
         * @param [out] callback: callback msg from event info
         * @param [out] qsProcMsgRsp: qs process result
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t ProcessQsRet(const event_info &event, std::shared_ptr<CallbackMsg> &callback,
            const bqs::QsProcMsgRspDstAicpu ** const qsProcMsgRsp);

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief process grant queue, grant queue to other aicpusd process
         * @param [in] event: event from driver send by acl
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t GrantQueue(const event_info &event);

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief process attach queue,check group and queue authority
         * @param [in] event: event from driver send by acl
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t AttachQueue(const event_info &event);

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief share group with other process
         * @param [in] groupName: group name to be share
         * @param [in] pid: the process pid to be share
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t ShareGroupWithProcess(const std::string &groupName, const pid_t &pid) const;

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief get or create group for current process
         * @param [out] outGroupName: group name
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t GetOrCreateGroup(std::string &outGroupName);

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief create group for current process
         * @param [out] outGroupName: group name
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t CreateGroupForMaster(std::string &outGroupName,  const char_t * const inGroupName = nullptr,
            const uint64_t size = 0U, const uint32_t allocFlag = 0U);

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief attach group for current process
         * @param [in] grpInfos: group info
         * @param [out] outGroupName: group name
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t AttachGroupForSlave(const std::map<std::string, GroupShareAttr> &grpInfos,
                                    std::string &outGroupName);

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief create and add callback msg
         * @param [in] event: which event need to add callback
         * @param [in] mbuf: save data for event msg
         * @param [in] userData: user data
         * @param [out] callback: callback msg
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t CreateAndAddCallbackMsg(const event_info &event, Mbuf * const buff,
            const uint64_t userData, std::shared_ptr<CallbackMsg> &callback);
        /**
         * @ingroup AicpuQueueEventProcess
         * @brief save callback msg
         * @param [in] userData: key: callback event addr
         * @param [in] callback: callback msg
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t AddCallback(uint64_t userData, std::shared_ptr<CallbackMsg> &callback);

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief get and delete callback msg
         * @param [in] userData: key: callback event addr
         * @param [in] callback: callback msg
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t GetAndDeleteCallback(const uint64_t userData, std::shared_ptr<CallbackMsg> &callback);

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief add queue auth to qs, read to src queue, write to dst queue
         * @param [in] queueRoute: queue route array addr
         * @param [in] routeNum: queue route array size
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t AddQueueAuthToQs(const bqs::QueueRoute * const queueRoute, const uint32_t routeNum);

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief check qs process event result
         * @param [in] event: event from driver send by qs
         * @param [out] callback: callback msg from event info
         * @param [out] qsProcMsgRsp: qs process result
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t ProcessQsRetWithMbuf(const event_info &event, std::shared_ptr<CallbackMsg> &callback,
            const bqs::QsProcMsgRspDstAicpu ** const qsProcMsgRsp);

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief process acl queue event
         * @param [in] event: event info
         * @param [out] msg: queue event msg
         * @param [out] routeHead: queue event msg head
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t CheckAndInitParamWithMbuf(const event_info &event,
                                          const bqs::QueueRouteList *&msg,
                                          bqs::QsRouteHead *&routeHead) const;

        /**
         * @ingroup AicpuQueueEventProcess
         * @brief process acl queue event
         * @param [in] event: queue event from driver send by acl
         * @param [in] drvSubeventId: subevent id
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t ProcessQueueEventWithMbuf(const event_info &event, const bqs::QueueSubEventType drvSubeventId);

        /**
         * @ingroup
         * @brief parse queue event msg
         * @param [in] event: queue event
         * @param [out] msg: will parse from event info
         * @param [in] isSyncEvent: if sync event, msg need add offset
         * @return AICPU_SCHEDULE_OK: success
         */
        int32_t ParseQueueEventMessage(const event_info &event, const char_t *&msg, const size_t msgSize,
            const bool isSyncEvent = false) const;

        void DoProcessProxyMsg(const event_info &event, ProxyMsgRsp &rsp);
        int32_t ProxyCreateGroup(const event_info &event);
        int32_t ProxyAllocMbuf(const event_info &event, Mbuf **mbufPtr, void **dataPptr) const;
        int32_t ProxyFreeMbuf(const event_info &event) const;
        int32_t ProxyCopyQMbuf(const event_info &event) const;
        int32_t ProxyAddGroup(const event_info &event) const;
        int32_t ProxyAllocCache(const event_info &event) const;
        int32_t DoAllocCache(const char_t* const groupName, GrpCacheAllocPara* const allocPar) const;

    private:
        BindQueueInitStatus initPipeline_; // init cp and qs pipeline status
        pid_t qsPid_; // qs pid
        uint32_t pipelineQueueId_; // cp and qs pipeline queue id
        CpType type_; // cp type master or slave
        std::string grpName_; // group name
        pid_t curPid_; // current process pid
        SpinLock lockGroup_; // lock for group name
        SpinLock lockEnqueue_; // lock for enqueue
        std::atomic_flag lockInit_ = ATOMIC_FLAG_INIT; // lock for bind queue init
        std::mutex lockCallback_; // lock for callback
        std::unordered_map<uint64_t, std::shared_ptr<CallbackMsg>> callbacks_; // save userData,callback map
        std::set<uint32_t> grantedSrcQueueSet_; // src queue set already been granted to avoid grant twice
        std::set<uint32_t> grantedDstQueueSet_; // src queue set already been granted to avoid grant twice
    };
}

#endif
