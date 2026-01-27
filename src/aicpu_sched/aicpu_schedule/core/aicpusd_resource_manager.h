/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CORE_AICPUSD_RESOURCE_MANAGER_H
#define CORE_AICPUSD_RESOURCE_MANAGER_H

#include <memory>
#include <mutex>
#include <list>
#include <vector>
#include <unordered_set>
#include <unordered_map>
#include "ascend_hal.h"
#include "aicpusd_common.h"
#include "aicpusd_util.h"

namespace AicpuSchedule {
    /**
     * @brief Guard for MBuf.
     */
    class BufManager {
    public:
        /**
         * @brief get BufManager instance.
         * @return instance
         */
        static BufManager &GetInstance();

        ~BufManager() = default;

        /**
         * @brief Guard buf.
         * BufManager take ownership of buf.
         * @param mbuf mbuf for guard.
         * @param modelId buf for model
         * @return AICPU_SCHEDULE_OK:success, other failed.
         */
        int32_t GuardBuf(Mbuf *const mbuf, const uint32_t modelId);

        /**
         * @brief Malloc and guard buf
         * BufManager malloc and take ownership of buf.
         * @param allocSize buf size
         * @param modelId buf for model
         * @return AICPU_SCHEDULE_OK:success, other failed.
         */
        Mbuf *MallocAndGuardBuf(const uint32_t allocSize, const uint32_t modelId);

        Mbuf *MallocAndGuardBufU64(const uint64_t allocSize, const uint32_t modelId);

        /**
         * @brief Malloc and guard buf list
         * BufManager malloc and take ownership of buf list.
         * @param sizeList buf size list
         * @param len sizeList length
         * @param modelId buf for model
         * @param isLinkMbuf is link mbuf
         * @param mbufPtrStore output all mbuf here, if isLinkMbuf is true, the first is mbuflist head
         * @return AICPU_SCHEDULE_OK:success, other failed.
         */
        int32_t MallocAndGuardBufList(const uint32_t * const sizeList, const uint32_t len, const uint32_t modelId,
                                      const bool isLinkMbuf, Mbuf ** const mbufPtrStore);

        /**
         * @brief UnGuard buf.
         * BufManager releases ownership of buf.
         * @param modelId model id
         * @param mbuf UnGuard buf
         * @return AICPU_SCHEDULE_OK:success, other failed.
         */
        int32_t UnGuardBuf(const uint32_t modelId, const Mbuf *const mbuf);

        /**
         * @brief free all buf in model.
         * @param modelId model id
         */
        void FreeBuf(const uint32_t modelId);

        /**
         * @brief free all buf.
         */
        void FreeAllBuf();

        // Init memzone info
        void InitBufManager();

        // not allow copy constructor and assignment operators
        BufManager(const BufManager &) = delete;

        BufManager &operator=(const BufManager &) = delete;

        BufManager(BufManager &&) = delete;

        BufManager &&operator=(BufManager &&) = delete;

    private:
        BufManager() = default;

        /**
         * @brief Malloc buf
         * BufManager malloc and take ownership of buf.
         * @param allocSize buf size
         * @return AICPU_SCHEDULE_OK:success, other failed.
         */
        Mbuf *MallocBuf(const uint32_t allocSize);

        Mbuf *MallocBufU64(const uint64_t allocSize);

        /**
         * @brief BufManager malloc and append mbuf
         * @return AICPU_SCHEDULE_OK:success, other failed.
         */
        int32_t MallocAndAppend(const uint32_t * const sizeList, const uint32_t idx, const uint32_t modelId,
            Mbuf *&mbuf, Mbuf *&mbufListHead);

        // record mbufs belong to model, no mutex
        std::list<Mbuf *> modelBufs_[MAX_MODEL_COUNT];

        SpinLock lockForModels_[MAX_MODEL_COUNT];
        // record mbufs memzone info
        BuffCfg buffConfig_;
    };

    /**
     * @brief Event wait manager.
     */
    class EventWaitManager {
    public:
        static EventWaitManager &NotifyWaitManager(const uint32_t waitIdCount = MAX_NOTIFY_COUNT);

        static EventWaitManager &EndGraphWaitManager(const uint32_t waitIdCount = MAX_MODEL_COUNT);

        static EventWaitManager &QueueNotEmptyWaitManager(const uint32_t waitIdCount = DEFAULT_QUEUE_COUNT);

        static EventWaitManager &QueueNotFullWaitManager(const uint32_t waitIdCount = DEFAULT_QUEUE_COUNT);

        static EventWaitManager &PrepareMemWaitManager(const uint32_t waitIdCount = MAX_MODEL_COUNT);

        static EventWaitManager &AnyQueNotEmptyWaitManager(const uint32_t waitIdCount = MAX_MODEL_COUNT);

        static EventWaitManager &TableUnlockWaitManager(const uint32_t waitIdCount = MAX_MODEL_COUNT);

        ~EventWaitManager() = default;

        // not allow copy constructor and assignment operators
        EventWaitManager(const EventWaitManager &) = delete;

        EventWaitManager &operator=(const EventWaitManager &) = delete;

        EventWaitManager(EventWaitManager &&) = delete;

        EventWaitManager &&operator=(EventWaitManager &&) = delete;

        /**
         * @brief Get wait stream or save notify state
         * @param eventWaitId wait id.
         * @param hasWait some stream is waiting
         * @param waitStreamId wait stream id, valid only when hasWaitStream is true
         */
        void Event(const size_t eventWaitId, bool &hasWait, uint32_t &waitStreamId);

        /**
         * @brief when event is come, clear event state,
         * or else save wait stream info and return need wait
         * @param eventWaitId wait id
         * @param waitStreamId wait stream id
         * @param needWait if event state is true, set needWait to true;
         */
        void WaitEvent(const size_t eventWaitId, const uint32_t waitStreamId, bool &needWait);

        /**
         * @brief reset specified event state
         * @param eventWaitId wait id
         */
        void ResetEventState(const size_t eventWaitId);

        /**
         * @brief clear specified record
         * @param eventWaitId wait id
         * @return AICPU_SCHEDULE_OK: success, other: failed
         */
        __attribute__((visibility("hidden")))
        int32_t ClearBatch(const std::unordered_set<size_t> &waitIds);

        /**
         * @brief check eventState_ and waitStream_ length
         */
        bool CheckEvent(const bool eventStateNeedCheck, const bool waitStreamNeedCheck, const size_t length);

        void GetWaitingEvent(std::vector<size_t> &eventWaitIds);

    private:
        EventWaitManager(const std::string &eventType,
                         const uint32_t waitIdCount) : eventType_(eventType),
                                                       count_(waitIdCount),
                                                       eventState_(static_cast<uint64_t>(waitIdCount), false),
                                                       waitStream_(static_cast<uint64_t>(waitIdCount), UINT32_MAX),
                                                       waitCount_(0) {}

        // event type
        const std::string eventType_;

        // count
        const uint32_t count_;

        // true means event come
        std::vector<bool> eventState_;

        // record wait stream id
        std::vector<uint32_t> waitStream_;

        // protect eventState_, waitStream_
        std::mutex waitMutex_;

        int32_t waitCount_;
    };

    /**
       * @brief model stream manager.
       */
    class ModelStreamManager {
    public:
        static ModelStreamManager &GetInstance();

        ~ModelStreamManager() = default;

        // not allow copy constructor and assignment operators
        ModelStreamManager(const ModelStreamManager &) = delete;

        ModelStreamManager &operator=(const ModelStreamManager &) = delete;

        ModelStreamManager(ModelStreamManager &&) = delete;

        ModelStreamManager &&operator=(ModelStreamManager &&) = delete;

        void Reg(const uint32_t modelId, const std::vector<StreamInfo> &streams);

        void UnReg(const uint32_t modelId, const std::vector<StreamInfo> &streams);

        int32_t GetStreamFlag(const uint32_t streamId, uint32_t &streamFlag);

        int32_t GetStreamModelId(const uint32_t streamId, uint32_t &modelId);

    private:
        ModelStreamManager() = default;

        mutable std::mutex streamInfoMtx_;
        // streamId: {modelId, streamFlag}
        std::unordered_map<uint32_t, std::pair<uint32_t, uint32_t>> streamInfos_;
    };

    class RwLock {
    public:
        RwLock() = default;

        ~RwLock() = default;

        void Init();

        bool RdLock();

        bool WrLock();

        void UnLock();

    private:
        std::mutex mu_;
        uint32_t readCount_;
        uint32_t writeCount_;
    };

    class TableLockManager {
    public:
        static TableLockManager &GetInstance();

        ~TableLockManager() = default;

        bool RdLockTable(const uint32_t tableId);

        bool WrLockTable(const uint32_t tableId);

        void UnLockTable(const uint32_t tableId);

    private:
        TableLockManager() = default;

        RwLock &GetTableLock(const uint32_t tableId);

        std::mutex mutexForLockMap_;
        std::unordered_map<uint32_t, RwLock> tableLocks_;
    };
}

#endif // CORE_AICPUSD_RESOURCE_MANAGER_H
