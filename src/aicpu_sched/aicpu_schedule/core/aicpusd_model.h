/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPUSD_MODEL_H
#define AICPUSD_MODEL_H

#include <atomic>
#include <cstdint>
#include <unordered_map>
#include <vector>
#include <unordered_set>
#include <thread>
#include <list>
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#include "aicpusd_info.h"
#include "aicpu_task_struct.h"
#include "aicpusd_util.h"
#include "aicpusd_hccl_api.h"
#include "aicpu_event_struct.h"

#define AICPUSD_EXCEPTION_CATCH(expr0, expr1) \
    try { \
        (expr0); \
    } catch (std::exception &e) { \
	    aicpusd_err("Error reason:%s", e.what()); \
        expr1; \
    }

namespace AicpuSchedule {

    constexpr int64_t INVALID_TABLE_ID = -1;

    enum class HcclInitType : int32_t {
        INIT_TYPE_FOR_EMBEDDING,
        INIT_TYPE_FOR_SYNC_EVENT,
        INIT_TYPE_NUM
    };
    class AicpuStream {
    public:
        AicpuStream() = default;

        ~AicpuStream() = default;

        void InitAicpuStream(const uint32_t streamId, const std::vector<const AicpuTaskInfo *> &tasks);

        int32_t ExecuteNextTask(const RunContext &runContext, bool &streamEnd);

        void ResetToStart();

        void ResetTasks();

        void ShowProgress();

        int32_t AttachReportStatusQueue();

    private:
        static int32_t ExecuteTask(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext);
        static int32_t ConvertToTsKernel(const AicpuTaskInfo &kernelTaskInfo, aicpu::HwtsTsKernel &aicpufwKernelInfo);

        std::mutex mutexForStream_;
        uint32_t streamId_ = 0U;
        size_t nextTaskIndex_ = 0LU;
        std::vector<AicpuTaskInfo> tasks_;
    };

    class QueueMbufStore {
    public:
        QueueMbufStore() = default;

        ~QueueMbufStore();

        bool Init(const size_t queueNum);

        bool Store(const size_t qIndex, Mbuf *const mbuf, std::map<size_t, uint64_t> &gCntList);

        bool IsReady() const;

        inline uint64_t BirthDay() const
        {
            return birthTimeStamp_;
        }

        bool Consume(Mbuf ***mbufPptr, std::map<size_t, uint64_t> &gCntList);

        void Free(std::map<size_t, uint64_t> *const gCntList = nullptr);

        bool IsEmpty() const;

    private:
        uint64_t birthTimeStamp_{0U};
        std::vector<std::list<Mbuf *>> queuesLists_;
    };

    enum class GatherResult : int32_t {
        UN_SELECTED = 0,
        SELECTED,
        FAKE_SELECTED
    };

    enum class StoreResult : int32_t {
        SUCCESS_STORE = 0,
        FAIL_STORE,
        ABORT_STORE
    };

    enum class ExceptionAction : uint32_t {
        ADD = 0,
        EXPIRE = 1
    };

    struct StepIdInfo {
        uint64_t *stepIdAddr;
        uint32_t stepId;

        StepIdInfo() : stepIdAddr(nullptr), stepId(0U) {};
        StepIdInfo(uint64_t *addr, uint32_t id) : stepIdAddr(addr), stepId(id) {};

        std::string DebugString() const
        {
            std::stringstream ss;
            ss << "Step id info. "
               << "stepId=" << stepId << std::endl;

            return ss.str();
        }
    };

    struct AsyncTaskInfo {
        HcclRequest request;
        Mbuf *outputMbuf;
    };

    class AicpuModel {
    public:
        AicpuModel() = default;

        ~AicpuModel()
        {
            (void)pthread_rwlock_destroy(&rwlockForStream_);
        }

        int32_t Exit();

        int32_t ModelLoad(const AicpuModelInfo * const modelInfo, const ModelCfgInfo * const cfgInfo = nullptr);

        int32_t ModelExecute();

        int32_t TaskReport();

        int32_t ModelAbort();

        int32_t ModelDestroy();

        int32_t EndGraph();

        int32_t ActiveStream(const uint32_t streamId);

        int32_t RecoverStream(const uint32_t streamId);

        int32_t ModelRepeat();

        void ProcessModelException(const uint32_t modelId) const;

        uint32_t GetModelTsId() const
        {
            return modelTsId_;
        }

        void SetModelTransId(const uint64_t transId)
        {
            modelTransId_ = transId;
        }

        uint64_t GetModelTransId() const
        {
            return modelTransId_;
        }

        int32_t UnGardModelBuf(Mbuf *const mbuf);

        uint32_t GetReportStmId() const
        {
            return reportStream_;
        }

        bool IsValid() const
        {
            return isValid;
        }

        AicpuModelStatus GetModelStatus() const
        {
            return modelStatus_;
        }

        ModelPrepareData &GetModelPrepareData()
        {
            return prepareData_;
        }

        ModelPostpareData &GetModelPostpareData()
        {
            return postpareData_;
        }

        std::vector<void *> &GetInputDataPtrs()
        {
            return inputDataPtrs_;
        }

        void SetModelEndOfSequence()
        {
            endOfSequence_ = true;
        }

        void ReSetModelEndOfSequence()
        {
            endOfSequence_ = false;
        }

        bool IsEndOfSequence() const
        {
            return endOfSequence_.load();
        }

        void SetExtModelId(const uint32_t extId)
        {
            extModelId_ = extId;
        }

        uint64_t GetIteratorId() const
        {
            return iteratorCount_;
        }

        inline StepIdInfo GetStepIdInfo() const
        {
            return stepIdInfo_;
        }

        inline void SetStepIdInfo(const StepIdInfo &info)
        {
            stepIdInfo_ = info;
            return;
        }

        inline bool GetHeadNodeFlag()
        {
            return headNodeFlag_;
        }

        inline void SetHeadNodeFlag(const bool val)
        {
            headNodeFlag_ = val;
        }

        std::vector<bool> &MutableInputsIsDequeue()
        {
            return inputsIsDequeue_;
        }

        void SetModelRetCode(const int32_t retVal)
        {
            retCode_ = retVal;
        }

        int32_t GetModelRetCode() const
        {
            return retCode_.load();
        }

        bool AbnormalNeedBreak() const
        {
            return abnormalBreak_.load();
        }

        bool AbnormalNeedEnqueue() const
        {
            return abnormalEnqueue_.load();
        }

        bool AbnormalEnabled() const
        {
            return abnormalEnabled_.load();
        }

        inline MBufferPool &GetInputBufPool(const uint32_t index)
        {
            return inputBufPools_[index];
        }

        inline MBufferPool &GetOutputBufPool(const uint32_t index)
        {
            return outputBufPools_[index];
        }

        inline uint32_t GetId() const
        {
            return modelId_;
        }

        inline int32_t GetTag() const
        {
            return hcclTag_;
        }

        inline int32_t GetPsId() const
        {
            return psId_;
        }

        inline bool IsSupportCounterFilter() const
        {
            return isSupportCounterFilter_;
        }

        void WaitReleaseThreadsFinish();

        inline void SetNullDataFlag(const bool val)
        {
            nullDataFlag_ = val;
        }

        inline bool GetNullDataFlag() const
        {
            return nullDataFlag_.load();
        }

        inline HcclInitType GetHcclInitType() const
        {
            return hcclInitType_;
        }

        inline uint32_t GetInputQueueCount() const
        {
            return static_cast<uint32_t>(inputQueueIds_.size());
        }

        inline bool HasQueue(uint32_t queueId) const
        {
            return inputQueueIds_.count(queueId) > 0U;
        }

        StatusCode InitModelGroups(const ModelCfgInfo * const cfgInfo);

        void DestroyModelGroups();

        StoreResult StoreDequedMbuf(const uint64_t transId, const uint32_t routeLabel, const size_t qIndex, Mbuf *const mbuf,
            const uint32_t queueCount);

        GatherResult SelectGatheredMbuf(Mbuf ***const mbufPptr, const int32_t timeOut, const uint32_t cacheNum);

        void RecordLockedTable(const uint32_t tableId);

        void ClearLockedTable(const uint32_t tableId);

        bool IsTableLocked(const uint32_t tableId);

        void ClearAllLockedTable();

        inline void SetTableTryLock(const int64_t tableId)
        {
            tableTryLock_ = tableId;
        }

        inline int64_t GetTableTryLock() const
        {
            return tableTryLock_;
        }

        uint32_t &GetInputConsumeNumRef();

        inline uint32_t GetActiveStreamNum() const
        {
            return activeStreamNum_;
        }

        inline void IncreaseActiveStreamNum()
        {
            activeStreamNum_++;
        }

        bool GetModelDestroyStatus() const
        {
            return isDestroyModel_;
        }

        int32_t ModelStop();

        int32_t ModelRestart();

        int32_t ModelClearInput();

        size_t GetCurDequeIndex(const size_t qCnt);

        inline void ResetStaticNNModelOutputIndex()
        {
            staticNNCurOutIndex_ = 0U;
        }
        
        inline void IncreaseStaticNNModelOutputIndex()
        {
            staticNNCurOutIndex_++;
        }
        
        inline uint32_t GetCurStaticNNModelOutputIndex() const
        {
            return staticNNCurOutIndex_;
        }

        int32_t AddAsyncTask(const AsyncTaskInfo &task);

        int32_t ProcessDataException(const uint64_t transId, const uint32_t type);

        bool IsTransIdException(const uint64_t transId);

        void GetExcptionTransIdsToClear(std::vector<int64_t> &excptionTransIdsToClear);

        void UpdateExcptionTransIdsStatus(const std::vector<int64_t> excptionTransIdsCleared);

        void ClearExceptionStore();
    private:
        // it is used to store data of the model parepare process so that the process can continue after interruption.
        ModelPrepareData prepareData_;
        // it is used to store data of the model postpare process so that the process can continue after interruption.
        ModelPostpareData postpareData_;

        int32_t ExecuteStream(const uint32_t streamId, const bool executeInline);

        void ActiveOtherAicpuStreams();

        /**
         * @brief GetStream by streamId
         *  attention: must get rwlockForStream_ lock out side.
         * @param streamId stream id
         * @return aicpu stream
         */
        AicpuStream *GetStreamByStreamId(const uint32_t streamId);

        /**
         * @brief check if allow operate, if allow update status to operate dst status.
         * @param operate model operate
         * @return AICPU_SCHEDULE_OK:success, other failed.
         */
        int32_t CheckOperateAndUpdateStatus(const AicpuModelOperate operate);

        /**
         * @brief check if allow operate.
         * @param operate model operate
         * @return AICPU_SCHEDULE_OK:success, other failed.
         */
        int32_t CheckOperate(const AicpuModelOperate operate);

        /**
         * @brief Reset model for execute.
         * @return AICPU_SCHEDULE_OK:success, other failed.
         */
        int32_t ResetModelForExecute();

        /**
         * @brief release model tmp resource.
         * @return AICPU_SCHEDULE_OK:success, other failed.
         */
        int32_t ReleaseModelResource();

        int32_t LoadStreamAndTask(const AicpuModelInfo * const modelInfo);

        int32_t LoadQueueInfo(const AicpuModelInfo * const modelInfo);

        /**
         * @brief clear all load info
         */
        void ClearLoadInfo();

        __attribute__((visibility("hidden")))
        void LoadWaitNotifyId(const AicpuTaskInfo &aicpuTaskInfo,
                              std::unordered_set<size_t> &waitNotifyIdSet) const;

        StatusCode LoadCfgForEmbedding(const ModelCfgInfo * const cfgInfo);
        StatusCode LoadCfgForSyncEvent(const ModelCfgInfo * const cfgInfo);
        StatusCode LoadCfg(const ModelCfgInfo * const cfgInfo);
        int32_t InitBufPool(const ModelCfgInfo * const cfgInfo);
        StatusCode PrepareHcclLink(const ModelCfgInfo * const cfgInfo);
        GatherResult GatherDequedMbuf(Mbuf ***mbufPptr, std::pair<uint64_t, uint32_t> &mbufKey,
            const int32_t timeOutMs, const uint32_t cacheNum);
        void ClearDequedMbuf(const uint64_t transId, const uint32_t routeLabel);
        void ClearGatheredMbuf();

        void UpdateModelRetCode(const int32_t retCode);

        int32_t AttachReportStatusQueue();

        int32_t ModelClearInputQueues(const std::unordered_set<size_t> &queueIds, const uint32_t deviceId) const;

        void ReleaseMem();
        void DoReleaseMem(AsyncTaskInfo &task);
        void StopAsyncThread();

        bool IsNewVersion();
        void SetVersion(bool isNewVersion);

    private:
        static const bool modelOperatePermission[static_cast<int32_t>(AicpuModelStatus::MODEL_STATUS_MAX)]
            [static_cast<int32_t>(AicpuModelOperate::MODEL_OPERATE_MAX)];
        static const AicpuModelStatus operateNextStatus[static_cast<int32_t>(AicpuModelOperate::MODEL_OPERATE_MAX)];

        volatile bool isValid = false;
        // model mutex, guard for operate and status
        std::mutex mutexForModel_;
        uint32_t modelId_ = INVALID_NUMBER;
        uint32_t modelTsId_ = INVALID_NUMBER;
        uint64_t modelTransId_ = UINT64_MAX;
        uint32_t modelS0Stream_ = INVALID_NUMBER;
        uint32_t reportStream_ = INVALID_NUMBER;

        // model status, guard by mutexForModelStatus_.
        AicpuModelStatus modelStatus_ = AicpuModelStatus::MODEL_STATUS_UNINIT;
        std::mutex mutexForModelStatus_;

        // all streams include aicpu stream and ts stream
        std::vector<StreamInfo> allStreams_;
        // model streams, guard by rwlockForStream_
        std::unordered_map<uint32_t, AicpuStream> aicpuStreams_;
        // it is used for stream.
        pthread_rwlock_t rwlockForStream_ = PTHREAD_RWLOCK_INITIALIZER;

        // it is used to store model notifyIds
        std::unordered_set<size_t> modelNotifyId_;
        // the mutex is used for modelNotifyId_.
        std::mutex mutexForModelNotifyId_;

        // it is used to store the queue which is subscribed event in one model.
        std::vector<QueInfo> queueEventSubscribedInfo_;
        // it is used to store the input queue id which is subscribed event in one model.
        std::unordered_set<size_t> inputQueueIds_;
        // it is used to indicate whether the input is dequeued, size is equal to input queue size
        std::vector<bool> inputsIsDequeue_;
        // it is used to store the output queue id which is subscribed event in one model.
        std::unordered_set<size_t> outputQueueIds_;
        // the mutex is used to in storing the relationship of model and queueInfo.
        std::mutex mutexForQueueEventSubscribed_;

        // input data pointer
        std::vector<void *> inputDataPtrs_;
        // the mutex is used to operater mbuff list
        std::mutex mutexForMbuffList_;
        // it is used to record status(end of sequence) of the model.
        std::atomic<bool> endOfSequence_{false};
        // it is used to record status of the model.
        std::atomic<int32_t> retCode_{0};
        // it is used to identify whether to exist.
        std::atomic<bool> abnormalBreak_{false};
        // it is used to identify whether to enqueue error flag.
        std::atomic<bool> abnormalEnqueue_{false};
        // The input mbuf may not be initialized. As a result, the retcode of the model is incorrect.
        // You can determine whether the retcode of the model is available based on this flag.
        std::atomic<bool> abnormalEnabled_{false};
        // it is used to record model execute times
        uint64_t iteratorCount_ = 0UL;
        // record model step id info
        StepIdInfo stepIdInfo_{nullptr, 0U};
        // head node flag in nn
        bool headNodeFlag_ = false;
        // ge model id
        uint32_t extModelId_ = INVALID_NUMBER;
        HcclInitType hcclInitType_{HcclInitType::INIT_TYPE_NUM};
        // for loadModelWithEvent: input bufpool
        std::unordered_map<uint32_t, MBufferPool> inputBufPools_;
        // for loadModelWithEvent: output bufpool
        std::unordered_map<uint32_t, MBufferPool> outputBufPools_;
        // for loadModelWithEvent: hccl tag
        int32_t hcclTag_{0};
        // for loadModelWithEmbedding: ps id
        int32_t psId_{-1};
        // for Embedding counter filter feature
        bool isSupportCounterFilter_{false};
        std::vector<uint32_t> otherAicpuStreams_;
        // if dataFlag is 0 and has EOS flag, then only transport data to output. Do not active model.
        std::atomic<bool> nullDataFlag_{false};
        std::vector<std::string> groupList_;
        std::unordered_map<uint64_t, std::unordered_map<uint32_t, QueueMbufStore>> gatheredMbuf_;
        std::unordered_map<uint32_t, uint32_t> tableLocked_;
        int64_t tableTryLock_{INVALID_TABLE_ID};
        // num of times when report status fail
        uint32_t inputConsumeNum_ {0U};
        uint32_t activeStreamNum_{0U};
        bool isDestroyModel_ = false;
        std::unordered_set<size_t> inputMsgQueueIds_;
        std::unordered_set<size_t> outputMsgQueueIds_;
        uint32_t staticNNCurOutIndex_{0U};
        std::mutex mutexForAsyncTask_;
        std::vector<std::thread> asyncTaskThreads_;
        std::list<AsyncTaskInfo> asyncTasks_;
        bool asyncTaskRunning_{false};
        std::map<size_t, uint64_t> gatheredMbufCntList_;
        std::mutex mutexForExceptionTrans_;
        std::unordered_map<uint32_t, bool> exceptionTranses_;
    };
}
#endif // MAIN_AICPUSD_MODEL_H
