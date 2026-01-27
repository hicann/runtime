/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_resource_manager.h"
#include <vector>
#include <list>
#include "aicpusd_status.h"
#include "aicpusd_monitor.h"
#include "aicpusd_util.h"
#include "aicpusd_meminfo_process.h"
#include "aicpusd_drv_manager.h"

namespace {
// mbuf address head align size.
constexpr uint32_t MBUF_ALLOC_ALIGN_SIZE = 64U;
constexpr int32_t MBUF_ALLOC_DEFAULT_GRP_ID = 0;
constexpr size_t ONE_SIZE = 1UL;
}  // namespace

namespace AicpuSchedule {
    BufManager &BufManager::GetInstance()
    {
        static BufManager instance;
        return instance;
    }

    int32_t BufManager::GuardBuf(Mbuf *const mbuf, const uint32_t modelId)
    {
        if (mbuf == nullptr) {
            aicpusd_err("Guard buf failed as mbuf is null, modelId[%u].", modelId);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        if (modelId >= MAX_MODEL_COUNT) {
            aicpusd_err("modelId[%u] over limit [%u].", modelId, MAX_MODEL_COUNT);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        lockForModels_[modelId].Lock();
        modelBufs_[modelId].emplace_back(mbuf);
        lockForModels_[modelId].Unlock();
        return AICPU_SCHEDULE_OK;
    }

    Mbuf *BufManager::MallocBuf(const uint32_t allocSize)
    {
        return MallocBufU64(static_cast<uint64_t>(allocSize));
    }

    Mbuf *BufManager::MallocBufU64(const uint64_t allocSize)
    {
        // There is a test scenario that will pull up multi aicpu-scheduler,
        // if the memory pool is initialized in the main func will raise OOM error.
        auto drvRet = halBuffInit(&buffConfig_);
        if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_REPEATED_INIT)) {
            aicpusd_err("halBuffInit execute failed. ret[%d]", drvRet);
            return nullptr;
        }

        Mbuf *mbuf = nullptr;
        const uint64_t deviceId = static_cast<uint64_t>(AicpuDrvManager::GetInstance().GetDeviceId());
        const uint64_t flag = (deviceId << 32UL) | static_cast<uint64_t>(BUFF_SP_HUGEPAGE_PRIOR);
        // flag of buff to alloc(0~31bit:mem type, 32~35bit:devid, 36~63bit:resv)
        drvRet = halMbufAllocEx(static_cast<uint64_t>(allocSize), MBUF_ALLOC_ALIGN_SIZE,
                                flag, MBUF_ALLOC_DEFAULT_GRP_ID, &mbuf);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Failed to alloc mbuf, size[%u], ret[%d].", allocSize, drvRet);
            return nullptr;
        }
        drvRet = halMbufSetDataLen(mbuf, static_cast<uint64_t>(allocSize));
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Failed to set mbuf data len, ret[%d].", drvRet);
            drvRet = halMbufFree(mbuf);
            if (drvRet != DRV_ERROR_NONE) {
                aicpusd_err("UnGuard Mbuf success but free by driver failed, ret[%d].", drvRet);
            }
            return nullptr;
        }
        return mbuf;
    }

    Mbuf *BufManager::MallocAndGuardBuf(const uint32_t allocSize, const uint32_t modelId)
    {
        return MallocAndGuardBufU64(static_cast<uint64_t>(allocSize), modelId);
    }

    Mbuf *BufManager::MallocAndGuardBufU64(const uint64_t allocSize, const uint32_t modelId)
    {
        Mbuf *mbuf = MallocBufU64(allocSize);
        if (mbuf == nullptr) {
            aicpusd_err("Failed to alloc mbuf for model[%u], size[%u].", modelId, allocSize);
            return nullptr;
        }
        const int32_t guardRet = GuardBuf(mbuf, modelId);
        if (guardRet != AICPU_SCHEDULE_OK) {
            aicpusd_err("Failed to guard mbuf for model[%u], size[%u], ret[%d].", modelId, allocSize, guardRet);
            const int32_t drvRet = halMbufFree(mbuf);
            if (drvRet != DRV_ERROR_NONE) {
                aicpusd_err("free by driver failed, ret[%d].", drvRet);
            }
            mbuf = nullptr;
        } else {
            aicpusd_info("Malloc and guard mbuf for model[%u], size[%u].", modelId, allocSize);
        }
        return mbuf;
    }

    int32_t BufManager::MallocAndAppend(const uint32_t * const sizeList, const uint32_t idx, const uint32_t modelId,
        Mbuf *&mbuf, Mbuf *&mbufListHead)
    {
        mbuf = MallocBuf(sizeList[idx]);
        if (mbuf == nullptr) {
            aicpusd_err("Failed to alloc mbuf for model[%u], size[%u].", modelId, sizeList[idx]);
            AicpuMonitor::GetInstance().SendKillMsgToTsd();
            return AICPU_SCHEDULE_ERROR_FROM_DRV;
        }

        int32_t ret = AICPU_SCHEDULE_OK;
        if (mbufListHead == nullptr) {
            mbufListHead = mbuf;
            ret = GuardBuf(mbuf, modelId);
            if (ret != AICPU_SCHEDULE_OK) {
                aicpusd_err("Failed to guard mbuf for model[%u], ret[%d].", modelId, ret);
                const int32_t drvRet = halMbufFree(mbuf);
                if (drvRet != DRV_ERROR_NONE) {
                    aicpusd_err("free by driver failed, ret[%d].", drvRet);
                }
                mbuf = nullptr;
                return AICPU_SCHEDULE_ERROR_INNER_ERROR;
            }
        } else {
            ret = halMbufChainAppend(mbufListHead, mbuf);
            if (ret != DRV_ERROR_NONE) {
                aicpusd_err("halMbufChainAppend mbuf error.ret:%d", ret);
                const int32_t drvRet = halMbufFree(mbuf);
                if (drvRet != DRV_ERROR_NONE) {
                    aicpusd_err("free by driver failed, ret[%d].", drvRet);
                }
                mbuf = nullptr;
                AicpuMonitor::GetInstance().SendKillMsgToTsd();
                return AICPU_SCHEDULE_ERROR_FROM_DRV;
            }
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t BufManager::MallocAndGuardBufList(const uint32_t * const sizeList, const uint32_t len,
                                              const uint32_t modelId, const bool isLinkMbuf, Mbuf ** const mbufPtrStore)
    {
        if (sizeList == nullptr) {
            aicpusd_err("malloc sizeList is nullptr.");
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        int32_t ret = static_cast<uint32_t>(AICPU_SCHEDULE_OK);
        Mbuf *mbuf = nullptr;
        Mbuf *mbufListHead = nullptr;

        // free mbuf if error occur
        const ScopeGuard mbufGuard([&]() {
            if (mbuf != nullptr) {
                aicpusd_info("MallocAndGuardBufList guard release not success, ret:[%d]", ret);
                // do not set ret value by halMbufFree, keep ret value for function return
                const auto drvRet = halMbufFree(mbuf);
                if (drvRet != DRV_ERROR_NONE) {
                    aicpusd_err("free by driver failed, ret[%d].", drvRet);
                }
                mbuf = nullptr;
            }
        });
        for (uint32_t i = 0U; i < len; i++) {
            mbuf = nullptr;
            if (!isLinkMbuf) {
                mbuf = MallocAndGuardBuf(sizeList[i], modelId);
                if (mbuf == nullptr) {
                    aicpusd_err("Failed to alloc mbuf, dataSize[%u], modelId[%u].", sizeList[i], modelId);
                    return AICPU_SCHEDULE_ERROR_FROM_DRV;
                }
            } else {
                ret = MallocAndAppend(sizeList, i, modelId, mbuf, mbufListHead);
                if (ret != AICPU_SCHEDULE_OK) {
                    return ret;
                }
            }
            // store every mbuf， set mbuf head outside
            mbufPtrStore[i] = mbuf;
            // set mbuf to nullptr otherwise, mbuf will be released
            mbuf = nullptr;
        }

        return AICPU_SCHEDULE_OK;
    }

    int32_t BufManager::UnGuardBuf(const uint32_t modelId, const Mbuf *const mbuf)
    {
        if (mbuf == nullptr) {
            aicpusd_err("UnGuard buf failed as mbuf is null.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        if (modelId >= MAX_MODEL_COUNT) {
            aicpusd_err("modelId[%u] over limit [%u].", modelId, MAX_MODEL_COUNT);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        lockForModels_[modelId].Lock();
        std::list<Mbuf *> &bufList = modelBufs_[modelId];
        for (auto iter = bufList.begin(); iter != bufList.end(); ++iter) {
            if ((*iter) == mbuf) {
                iter = bufList.erase(iter);
                break;
            }
        }
        lockForModels_[modelId].Unlock();
        return AICPU_SCHEDULE_OK;
    }

    void BufManager::FreeBuf(const uint32_t modelId)
    {
        if (modelId >= MAX_MODEL_COUNT) {
            aicpusd_err("modelId[%u] over limit [%u].", modelId, MAX_MODEL_COUNT);
            return;
        }
        lockForModels_[modelId].Lock();
        std::list<Mbuf *> &mbufLst = modelBufs_[modelId];
        if (mbufLst.empty()) {
            lockForModels_[modelId].Unlock();
            return;
        }
        for (Mbuf *const mbuf : mbufLst) {
            const auto drvRet = halMbufFree(mbuf);
            if (drvRet == static_cast<int32_t>(DRV_ERROR_NONE)) {
                aicpusd_info("Free Mbuf for model[%u] success.", modelId);
            } else {
                aicpusd_warn("Free Mbuf for model[%u] by driver failed, ret[%d].", modelId, drvRet);
            }
        }
        modelBufs_[modelId].clear();
        lockForModels_[modelId].Unlock();
        aicpusd_info("Free Mbuf for model[%u] end.", modelId);
    }

    void BufManager::FreeAllBuf()
    {
        aicpusd_info("Free all buff begin.");
        for (uint32_t i = 0U; i < MAX_MODEL_COUNT; i++) {
            FreeBuf(i);
        }
        aicpusd_info("Free all buff end.");
    }

    void BufManager::InitBufManager()
    {
        aicpusd_info("Aicpu schedule Init BufManager!");
        const auto ret = AicpuMemInfoProcess::GetMemZoneInfo(buffConfig_);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_run_info("Aicpu schedule SetBuffCfg retCode=[%u], buffConfig_ will use default value!", ret);
            buffConfig_ = {};
        } else {
            aicpusd_run_info("Aicpu schedule SetBuffCfg successfully!");
        }
    }

    EventWaitManager &EventWaitManager::NotifyWaitManager(const uint32_t waitIdCount)
    {
        static EventWaitManager notifyWaitInstance("Notify", waitIdCount);
        return notifyWaitInstance;
    }

    EventWaitManager &EventWaitManager::EndGraphWaitManager(const uint32_t waitIdCount)
    {
        static EventWaitManager endGraphWaitInstance("EndGraph", waitIdCount);
        return endGraphWaitInstance;
    }

    EventWaitManager &EventWaitManager::QueueNotEmptyWaitManager(const uint32_t waitIdCount)
    {
        static EventWaitManager queueNotEmptyWaitInstance("QueueNotEmpty", waitIdCount);
        return queueNotEmptyWaitInstance;
    }

    EventWaitManager &EventWaitManager::QueueNotFullWaitManager(const uint32_t waitIdCount)
    {
        static EventWaitManager queueNotFullWaitInstance("QueueNotFull", waitIdCount);
        return queueNotFullWaitInstance;
    }

    EventWaitManager &EventWaitManager::PrepareMemWaitManager(const uint32_t waitIdCount)
    {
        static EventWaitManager prepareMemWaitInstance("PrepareMem", waitIdCount);
        return prepareMemWaitInstance;
    }

    EventWaitManager &EventWaitManager::AnyQueNotEmptyWaitManager(const uint32_t waitIdCount)
    {
        static EventWaitManager anyQueNotEmptyWaitInstance("AnyQueNotEmpty", waitIdCount);
        return anyQueNotEmptyWaitInstance;
    }

    EventWaitManager &EventWaitManager::TableUnlockWaitManager(const uint32_t waitIdCount)
    {
        static EventWaitManager tableUnlockWaitInstance("TableUnlock", waitIdCount);
        return tableUnlockWaitInstance;
    }

    void EventWaitManager::Event(const size_t eventWaitId, bool &hasWait, uint32_t &waitStreamId)
    {
        if (CheckEvent(true, true, eventWaitId)) {
            return;
        }
        const std::unique_lock<std::mutex> lk(waitMutex_);
        eventState_[eventWaitId] = true;
        if (waitStream_[eventWaitId] == UINT32_MAX) {
            hasWait = false;
            aicpusd_info("[%s] eventWaitId[%zu] is come, but no stream is waiting. waitCount[%d]",
                         eventType_.c_str(), eventWaitId, waitCount_);
            return;
        }
        waitStreamId = waitStream_[eventWaitId];
        hasWait = true;
        waitStream_[eventWaitId] = UINT32_MAX;
        --waitCount_;
        aicpusd_info("[%s] waitId[%zu] is come, stream[%u] is waiting. waitCount[%d]",
                     eventType_.c_str(), eventWaitId, waitStreamId, waitCount_);
    }

    void EventWaitManager::WaitEvent(const size_t eventWaitId, const uint32_t waitStreamId, bool &needWait)
    {
        if (CheckEvent(true, true, eventWaitId)) {
            return;
        }
        const std::unique_lock<std::mutex> lk(waitMutex_);
        if (!eventState_[eventWaitId]) {
            waitStream_[eventWaitId] = waitStreamId;
            needWait = true;
            ++waitCount_;
            aicpusd_info("[%s] waitId[%zu] does not come, stream[%u] need wait. waitCount[%d]",
                         eventType_.c_str(), eventWaitId, waitStreamId, waitCount_);
            return;
        }

        // reset state to false
        eventState_[eventWaitId] = false;
        needWait = false;
        aicpusd_info("[%s] WaitId[%zu] is come, stream[%u] no need wait. waitCount[%d]",
                     eventType_.c_str(), eventWaitId, waitStreamId, waitCount_);
    }

    void EventWaitManager::GetWaitingEvent(std::vector<size_t> &eventWaitIds)
    {
        for (size_t id = 0U; id < count_; ++id) {
            if (waitStream_[id] != UINT32_MAX) {
                eventWaitIds.emplace_back(id);
            }
        }
    }

    void EventWaitManager::ResetEventState(const size_t eventWaitId)
    {
        if (CheckEvent(true, false, eventWaitId)) {
            return;
        }
        aicpusd_info("[%s] reset event state. waitId[%zu].", eventType_.c_str(), eventWaitId);
        const std::unique_lock<std::mutex> lk(waitMutex_);
        eventState_[eventWaitId] = false;
    }

    int32_t EventWaitManager::ClearBatch(const std::unordered_set<size_t> &waitIds)
    {
        if ((waitIds.empty()) || (CheckEvent(true, true, waitIds.size() - ONE_SIZE))) {
            return AICPU_SCHEDULE_OK;
        }
        aicpusd_info("[%s] clear records batch, waitIds.size[%zu].", eventType_.c_str(), waitIds.size());
        const std::unique_lock<std::mutex> lk(waitMutex_);
        for (const auto eventWaitId : waitIds) {
            if (eventWaitId >= count_) {
                aicpusd_err("[%s] waitId[%zu] invalid, should be in[0, %u).", eventType_.c_str(), eventWaitId, count_);
                return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
            }
            eventState_[eventWaitId] = false;
            waitStream_[eventWaitId] = UINT32_MAX;
        }
        return AICPU_SCHEDULE_OK;
    }

    bool EventWaitManager::CheckEvent(const bool eventStateNeedCheck, const bool waitStreamNeedCheck,
                                      const size_t length)
    {
        const std::unique_lock<std::mutex> lk(waitMutex_);
        if (eventStateNeedCheck) {
            if (length >= eventState_.size()) {
                aicpusd_warn("eventState_ check failed, size[%d], input value[%u].", eventState_.size(), length);
                return true;
            }
        }
        if (waitStreamNeedCheck) {
            if (length >= waitStream_.size()) {
                aicpusd_warn("waitStream_ check failed, size[%d], input value[%u].", waitStream_.size(), length);
                return true;
            }
        }
        return false;
    }

    ModelStreamManager &ModelStreamManager::GetInstance()
    {
        static ModelStreamManager instance;
        return instance;
    }

    void ModelStreamManager::Reg(const uint32_t modelId, const std::vector<StreamInfo> &streams)
    {
        std::lock_guard<std::mutex> lk(streamInfoMtx_);
        for (const auto &stream : streams) {
            const auto &ret = streamInfos_.emplace(stream.streamID, std::pair<uint32_t, uint32_t>(modelId,
                stream.streamFlag));
            if (!ret.second) {
                aicpusd_err("Reg stream failed, streamId=%u, modelId=%u, streamFlag=%u",
                            stream.streamID, modelId, stream.streamFlag);
            } else {
                aicpusd_info("Reg stream success, streamId=%u, modelId=%u, streamFlag=%u, size=%lu",
                             stream.streamID, modelId, stream.streamFlag, streamInfos_.size());
            }
        }

        return;
    }

    void ModelStreamManager::UnReg(const uint32_t modelId, const std::vector<StreamInfo> &streams)
    {
        std::lock_guard<std::mutex> lk(streamInfoMtx_);
        for (const auto &stream : streams) {
            const auto &iter = streamInfos_.find(stream.streamID);
            if (iter != streamInfos_.end()) {
                if (iter->second.first == modelId) {
                    aicpusd_info("UnReg stream success, streamId=%u, modelId=%u, size=%lu",
                                 stream.streamID, modelId, streamInfos_.size());
                    (void)streamInfos_.erase(stream.streamID);
                } else {
                    aicpusd_warn("UnReg stream[%u] failed, as param modelId[%u] but stream modelId[%u].",
                                 stream.streamID, modelId, iter->second.first);
                }
            }
        }

        return;
    }

    int32_t ModelStreamManager::GetStreamFlag(const uint32_t streamId, uint32_t &streamFlag)
    {
        std::lock_guard<std::mutex> lk(streamInfoMtx_);
        const auto &iter = streamInfos_.find(streamId);
        if (iter == streamInfos_.end()) {
            aicpusd_err("Can not find stream, streamId=%u", streamId);
            return AICPU_SCHEDULE_ERROR_STREAM_NOT_FOUND;
        }

        streamFlag = iter->second.second;

        return AICPU_SCHEDULE_OK;
    }

    int32_t ModelStreamManager::GetStreamModelId(const uint32_t streamId, uint32_t &modelId)
    {
        std::lock_guard<std::mutex> lk(streamInfoMtx_);
        const auto &iter = streamInfos_.find(streamId);
        if (iter == streamInfos_.end()) {
            aicpusd_err("Can not find stream, streamId=%u", streamId);
            return AICPU_SCHEDULE_ERROR_STREAM_NOT_FOUND;
        }

        modelId = iter->second.first;

        return AICPU_SCHEDULE_OK;
    }

    TableLockManager &TableLockManager::GetInstance()
    {
        static TableLockManager instance;
        return instance;
    }

    RwLock &TableLockManager::GetTableLock(const uint32_t tableId)
    {
        const std::unique_lock<std::mutex> lockForTableLocks(mutexForLockMap_);
        if (tableLocks_.find(tableId) == tableLocks_.end()) {
            tableLocks_[tableId].Init();
        }
        return tableLocks_[tableId];
    }

    bool TableLockManager::RdLockTable(const uint32_t tableId)
    {
        aicpusd_info("rdlock table %u.", tableId);
        auto &tableLock = GetTableLock(tableId);
        return tableLock.RdLock();
    }

    bool TableLockManager::WrLockTable(const uint32_t tableId)
    {
        aicpusd_info("wrlock table %u.", tableId);
        auto &tableLock = GetTableLock(tableId);
        return tableLock.WrLock();
    }

    void TableLockManager::UnLockTable(const uint32_t tableId)
    {
        aicpusd_info("unlock table %u.", tableId);
        auto &tableLock = GetTableLock(tableId);
        tableLock.UnLock();
    }

    void RwLock::Init()
    {
        readCount_ = 0U;
        writeCount_ = 0U;
    }

    bool RwLock::RdLock()
    {
        const std::unique_lock<std::mutex> lockForCount(mu_);
        if (writeCount_ > 0U) {
            aicpusd_info("This lock has been locked by write, can not rdLock now.");
            return false;
        }
        ++readCount_;
        aicpusd_info("rdlock success");
        return true;
    }

    bool RwLock::WrLock()
    {
        const std::unique_lock<std::mutex> lockForCount(mu_);
        if ((writeCount_ > 0U) || (readCount_ > 0U)) {
            aicpusd_info("Current writeCount[%u], readCount[%u], can not WrLock now.", writeCount_, readCount_);
            return false;
        }
        ++writeCount_;
        aicpusd_info("wrlock success");
        return true;
    }

    void RwLock::UnLock()
    {
        const std::unique_lock<std::mutex> lockForCount(mu_);
        if (writeCount_ > 0U) {
            aicpusd_info("unlock write lock, current write count is %u", writeCount_);
            --writeCount_;
            return;
        }

        if (readCount_ > 0U) {
            aicpusd_info("unlock read lock, current read count is %u", readCount_);
            --readCount_;
            return;
        }
        aicpusd_warn("Three's no lock");
    }
}
