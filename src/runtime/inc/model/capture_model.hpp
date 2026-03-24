/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_CAPTURE_MODEL_HPP__
#define __CCE_RUNTIME_CAPTURE_MODEL_HPP__
 
#include "model.hpp"
#include "task_info.hpp"
#include "stream.hpp"
#include "device_sq_cq_pool.hpp"
#include <unordered_set>

namespace cce {
namespace runtime {
class Event;

enum RtCaptureModelStatus {
    RT_CAPTURE_MODEL_STATUS_NONE = 0,            // init status
    RT_CAPTURE_MODEL_STATUS_CAPTURE_ACTIVE,      // capture status
    RT_CAPTURE_MODEL_STATUS_CAPTURE_INVALIDATED, // capture invalidated status
    RT_CAPTURE_MODEL_STATUS_UPDATING,            // updating status
    RT_CAPTURE_MODEL_STATUS_FAULT,               // fault status
    RT_CAPTURE_MODEL_STATUS_READY,               // capture or updating finish
};

struct MsprofShapeHeader {
    uint32_t modelId;
    uint32_t deviceId;
    uint32_t streamId;
    uint32_t taskId;
};

constexpr uint32_t MS_PROF_SHAPE_INFO_SIZE = sizeof(MsprofShapeInfo);
constexpr uint32_t MS_PROF_SHAPE_HEADER_SIZE = sizeof(MsprofShapeHeader);

class CaptureModel : public Model {
public:
    explicit CaptureModel(ModelType type = RT_MODEL_CAPTURE_MODEL);

    ~CaptureModel() noexcept override;
 
    rtError_t Execute(Stream * const stm, int32_t timeout = -1) override;
    rtError_t ExecuteAsync(Stream * const stm) override;
    rtError_t TearDown() override;
    rtError_t AddStreamToCaptureModel(Stream * const stm);
    rtError_t SetNotifyBeforeExecute(Stream * const exeStm, CaptureModel* const captureMdl);
    rtError_t SetNotifyAfterExecute(Stream * const exeStm, CaptureModel* const captureMdl);
    bool IsAddStream(const Stream *stm) const;

    void EnterCaptureNotify(const int32_t singleOperStmId, const int32_t captureStmId);
    void ExitCaptureNotify();

    void SetCaptureModelStatus(RtCaptureModelStatus status)
    {
        captureModelStatus_ = status;
    }

    RtCaptureModelStatus GetCaptureModelStatus() const
    {
        return captureModelStatus_;
    }

    void TerminateCapture()
    {
        if (captureModelStatus_ == RT_CAPTURE_MODEL_STATUS_CAPTURE_ACTIVE) {
            captureModelStatus_ = RT_CAPTURE_MODEL_STATUS_CAPTURE_INVALIDATED;
        }
    }

    bool IsCaptureReady() const
    {
        return (captureModelStatus_ == RT_CAPTURE_MODEL_STATUS_READY);
    }

    bool IsCaptureFinish() const
    {
        return (captureModelStatus_ > RT_CAPTURE_MODEL_STATUS_CAPTURE_INVALIDATED);
    }

    bool IsCapturing() const
    {
        return ((captureModelStatus_ == RT_CAPTURE_MODEL_STATUS_CAPTURE_ACTIVE) ||
                (captureModelStatus_ == RT_CAPTURE_MODEL_STATUS_CAPTURE_INVALIDATED));
    }

    bool IsCaptureInvalid() const
    {
        return (captureModelStatus_ == RT_CAPTURE_MODEL_STATUS_CAPTURE_INVALIDATED);
    }

    bool IsUpdating() const
    {
        return (captureModelStatus_ == RT_CAPTURE_MODEL_STATUS_UPDATING);
    }

    bool CanUpdate() const
    {
        return ((!IsCaptureModelRunning()) && 
                (captureModelStatus_ == RT_CAPTURE_MODEL_STATUS_READY ||
                 captureModelStatus_ == RT_CAPTURE_MODEL_STATUS_UPDATING));
    }

    void InsertSingleOperStmIdAndCaptureStmId(const int32_t singleOperStmId, const int32_t captureStmId)
    {
        singleOperStmIdAndCaptureStmIdMap_[singleOperStmId].insert(captureStmId);
    }

    void InsertCaptureEvent(Event * const event)
    {
        captureEvents_.insert(event);
    }

    std::set<Event *> GetCaptureEvent() const
    {
        return captureEvents_;
    }

    void InsertSingleOperEvent(Event * const event)
    {
        singleOperEvents_.insert(event);
    }

    void DeleteSingleOperEvent(Event * const event)
    {
        (void)singleOperEvents_.erase(event);
    }

    rtError_t ResetCaptureEvents(Stream * const stm) const;

    void AddNotify(Notify *notify)
    {
        addStreamNotifyList_.push_back(notify);
    }

    void AddExeNotify(Notify *notify)
    {
        executeNotifyList_.push_back(notify);
    }

    const std::map<Stream *, std::vector<Stream *>> &GetAddStreamMap()
    {
        return addStreamMap_;
    }

    void SetAddStreamMap(Stream *stm1, Stream *stm2)
    {
        addStreamMap_[stm1].push_back(stm2);
    }

    void InsertTaskGroupStreamId(const uint16_t streamId)
    {
        (void)taskGroupStmIds_.insert(streamId);
    }

    std::set<uint16_t> & GetTaskGroupStreamIds()
    {
        return taskGroupStmIds_;
    }

    void DeleteTaskGroupStreamId(const uint16_t streamId)
    {
        (void)taskGroupStmIds_.erase(streamId);
    }

    void ReplaceTaskGroupStreamId(const uint16_t oldStmId, const uint16_t newStmId)
    {
        auto iter = taskGroupStmIds_.find(oldStmId);
        if (iter != taskGroupStmIds_.end()) {
            (void)taskGroupStmIds_.erase(iter);
            (void)taskGroupStmIds_.insert(newStmId);
        }
    }

    void AddTaskGroupList(std::unique_ptr<TaskGroup> &taskGrp)
    {
        const std::unique_lock<std::mutex> lk(taskGroupListMutex_);
        taskGroupList_.push_back(std::move(taskGrp));
    }

    void SetTaskGroupErrCode(const rtError_t errCode)
    {
        taskGroupErrCode_ = errCode;
    }

    rtError_t GetTaskGroupErrCode(void) const
    {
        return taskGroupErrCode_;
    }

    void DebugDotPrintTaskGroups(const uint32_t deviceId) const;
    void ReportedStreamInfoForProfiling() const;
    void EraseStreamInfoForProfiling() const;
    rtError_t SetShapeInfo(const Stream* const stm, const uint32_t taskId, const void * const infoPtr,
                           const size_t infoSize);
    void ClearShapeInfo(const int32_t streamId, const uint32_t taskId);
    void* GetShapeInfo(const int32_t streamId, const uint32_t taskId, size_t &infoSize) const;

    rtError_t CacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize, const Stream * const stm);
    void ReportShapeInfoForProfiling() const;
    void SetModelCacheOpInfoSwitch(const uint32_t status) const;

    uint32_t GetModelCacheOpInfoSwitch() const
    {
        return cacheOpInfoSwitch_;
    }

    void InsertRdmaPiValueModifyInfo(int32_t streamId, uint16_t taskId)
    {
        // 在captureLock_下，因此不需要再加锁
        (void)rdmaPiValueModifyTaskInfoMap_[streamId].insert(taskId);
    }

    const std::unordered_map<int32_t, std::unordered_set<uint16_t>> &GetRdmaPiValueModifyTaskInfoMap() const
    {
        // 目前只有模型执行完后的notify wait的后处理才会调用这个函数，所以不需要加锁
        return rdmaPiValueModifyTaskInfoMap_;
    }

    bool IsSoftwareSqEnable(void) const
    {
        return isSoftwareSqEnable_;
    }

    void SetSoftwareSqEnable(void)
    {
        isSoftwareSqEnable_ = true;
    }

    bool IsCaptureModelRunning(void) const
    {
        return (refCount_ != 0U);
    }

    bool ModelSqOperTryLock(void)
    {
        return sqBindMutex_.try_lock();
    }

    void ModelSqOperUnLock(void)
    {
        return sqBindMutex_.unlock();
    }

    bool IsSendSqe(void) const
    {
        return isSqeSendFinish_;
    }

    void ResetTrackDataReportFlag()
    {
        trackDataReportFlag_ = false;
    }

    uint32_t GenerateSeqId()
    {
        return seqId_++;
    }

    const TaskGroup* GetTaskGroup(uint16_t streamId, uint16_t taskId);
    void BackupArgHandle(const uint16_t streamId, const uint16_t taskId);
    rtError_t Update(void);

    rtError_t ReleaseNotifyId(void);
    rtError_t UpdateNotifyId(Stream * const exeStream);
    // endGraph + alloc sq cq + Send sqe + bind sq cq + load complete + update task
    rtError_t BuildSqCq(Stream * const exeStream);
    void DeconstructSqCq(void);
    rtError_t ReleaseSqCq(uint32_t &releaseNum);
    void CaptureModelExecuteFinish(void);
    rtError_t MarkStreamActiveTask(TaskInfo *streamActiveTask); // the task of stream active is need updated
                                                                // after sq cq is allocated
    rtError_t RestoreForSoftwareSq(Device * const dev);
    
private:
    rtError_t SendSqe(void);      // copy sqe to sqe addr
    rtError_t AllocSqAddr(void) const;  // alloc sq addr
    rtError_t AllocSqCqProc(const uint32_t streamNum) const;
    rtError_t BindSqCq(void);
    rtError_t UnBindSqCq(void);
    rtError_t UpdateStreamActiveTaskFuncCallMem(void);
    void ClearStreamActiveTask(void);
    Stream* GetOriginalCaptureStream(void) const;
    rtError_t ExecuteCommon(Stream * const stm, int32_t timeout, const uint8_t executeMode);
    rtError_t BindSqCqAndSendSqe(void);
    rtError_t ConfigSqTail(void) const;
    rtError_t BindStreamToModel(void);
    void ReportCacheTrackData();

    RtCaptureModelStatus captureModelStatus_{RT_CAPTURE_MODEL_STATUS_NONE};
    mutable uint32_t cacheOpInfoSwitch_{0U}; // aclgraph stream status: 0: false, 1:true
    std::map<int32_t, std::map<uint32_t, std::unique_ptr<uint8_t []>>> shapeInfos_;
    std::unordered_map<int32_t, std::unordered_set<int32_t>> singleOperStmIdAndCaptureStmIdMap_;
    std::set<Event *> singleOperEvents_;
    std::set<Event *> captureEvents_;
    std::map<Stream *, std::vector<Stream *>> addStreamMap_; // key为add进来的stream，value为隐式创建的stream
    std::vector<Notify *> addStreamNotifyList_;
    std::vector<Notify *> executeNotifyList_;
    std::mutex notifyMutex_;
    std::mutex taskGroupListMutex_;
    std::set<uint16_t> taskGroupStmIds_;
    std::vector<std::unique_ptr<TaskGroup>> taskGroupList_;
    rtError_t taskGroupErrCode_{RT_ERROR_NONE};
    std::unordered_map<int32_t, std::unordered_set<uint16_t>> rdmaPiValueModifyTaskInfoMap_;
    bool isSoftwareSqEnable_{false};
    rtDeviceSqCqInfo_t *sqCqArray_{nullptr};
    struct sq_switch_stream_info *switchInfo_{nullptr};
    uint32_t sqCqNum_{0U};
    std::mutex streamActiveTaskListMutex_;
    std::vector<TaskInfo *> streamActiveTaskList_;
    std::mutex sqBindMutex_;
    uint32_t refCount_{0U};
    bool isSqeSendFinish_{false};
    bool isNeedUpdateEndGraph_{false};
    uint64_t beginCaptureTimeStamp_{0UL};
    bool trackDataReportFlag_{false};
    std::atomic<uint32_t> seqId_{0};
    std::set<void *> argLoaderBackup_;
};
}
}
 
#endif  // __CCE_RUNTIME_CAPTURE_MODEL_HPP__
