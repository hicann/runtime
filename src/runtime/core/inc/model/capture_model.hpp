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
#include "event_resource.hpp"
#include "task_info.hpp"
#include "stream.hpp"
#include "stars.hpp"
#include "device_sq_cq_pool.hpp"
#include "cond_handle.hpp"
#include <unordered_set>
#include <tuple>

namespace cce {
namespace runtime {
class Event;
struct EventResource;

enum class RtCaptureModelStatus {
    NONE = 0,            // init status
    CAPTURE_ACTIVE,      // capture status
    CAPTURE_INVALIDATED, // capture invalidated status
    UPDATING,            // updating status
    FAULT,               // fault status
    READY,               // capture or updating finish
};

struct MsprofShapeHeader {
    uint32_t modelId;
    uint32_t deviceId;
    uint32_t streamId;
    uint32_t taskId;
};

constexpr uint32_t MS_PROF_SHAPE_INFO_SIZE = static_cast<uint32_t>(sizeof(MsprofShapeInfo));
constexpr uint32_t MS_PROF_SHAPE_HEADER_SIZE = static_cast<uint32_t>(sizeof(MsprofShapeHeader));
constexpr uint64_t EXTERNAL_WAIT_REFRESH_ENTRY_SIZE = sizeof(uint64_t);

struct ExternalEventTaskItem {
    // external操作使用的event对象。
    Event* event{nullptr};
    // capture阶段占位任务所在stream id。
    uint32_t captureStreamId{0U};
    // capture阶段占位任务id。
    uint32_t taskId{0U};
};

struct ExternalEventRefreshLayout {
    // record refresh entry区域在device表中的偏移。
    uint64_t recordOffset{0U};
    // wait refresh entry区域在device表中的偏移。
    uint64_t waitOffset{0U};
    // host/device refresh表总大小，用于内存申请、拷贝和释放。
    uint64_t totalSize{0U};
};

struct ExternalEventRefreshInfo {
    // 本轮replay的host刷新buffer，随H2D任务guardMem生命周期释放。
    std::shared_ptr<uint8_t[]> hostRefresh{nullptr};
    // 本轮external record预分配但尚未发布到event的资源。
    std::vector<EventResource> preparedRecords;
    // 本轮external wait持有的producer资源，交给endGraph notify或异常owner释放。
    std::vector<EventResource> retainedWaitResources;
};

class CaptureModel : public Model {
public:
    explicit CaptureModel(ModelType type = RT_MODEL_CAPTURE_MODEL);

    ~CaptureModel() noexcept override;

    rtError_t Execute(Stream* const stm, int32_t timeout = -1) override;
    rtError_t ExecuteAsync(Stream* const stm) override;
    rtError_t TearDown() override;
    rtError_t AddStreamToCaptureModel(Stream* const stm);
    rtError_t SetNotifyBeforeExecute(Stream* const exeStm, CaptureModel* const captureMdl);
    // 设置模型执行后的notify同步，必要时把本轮external wait资源转交给notify wait任务释放。
    rtError_t SetNotifyAfterExecute(
        Stream* const exeStm, CaptureModel* const captureMdl, ExternalEventRefreshInfo* refreshInfo = nullptr);
    bool IsAddStream(const Stream* stm) const;

    void EnterCaptureNotify(const int32_t singleOperStmId, const int32_t captureStmId);
    void ExitCaptureNotify();

    void SetCaptureModelStatus(RtCaptureModelStatus status) { captureModelStatus_ = status; }

    RtCaptureModelStatus GetCaptureModelStatus() const { return captureModelStatus_; }

    void TerminateCapture()
    {
        if (captureModelStatus_ == RtCaptureModelStatus::CAPTURE_ACTIVE) {
            captureModelStatus_ = RtCaptureModelStatus::CAPTURE_INVALIDATED;
        }
    }

    bool IsCaptureReady() const { return (captureModelStatus_ == RtCaptureModelStatus::READY); }

    bool IsCaptureFinish() const { return (captureModelStatus_ > RtCaptureModelStatus::CAPTURE_INVALIDATED); }

    bool IsCapturing() const
    {
        return (
            (captureModelStatus_ == RtCaptureModelStatus::CAPTURE_ACTIVE) ||
            (captureModelStatus_ == RtCaptureModelStatus::CAPTURE_INVALIDATED));
    }

    bool IsCaptureActive() const { return (captureModelStatus_ == RtCaptureModelStatus::CAPTURE_ACTIVE); }

    bool IsCaptureInvalid() const { return (captureModelStatus_ == RtCaptureModelStatus::CAPTURE_INVALIDATED); }

    bool IsUpdating() const { return (captureModelStatus_ == RtCaptureModelStatus::UPDATING); }

    bool CanUpdate() const
    {
        return (
            (!IsCaptureModelRunning()) && (captureModelStatus_ == RtCaptureModelStatus::READY ||
                                           captureModelStatus_ == RtCaptureModelStatus::UPDATING));
    }

    void InsertSingleOperStmIdAndCaptureStmId(const int32_t singleOperStmId, const int32_t captureStmId)
    {
        singleOperStmIdAndCaptureStmIdMap_[singleOperStmId].insert(captureStmId);
    }

    void InsertCaptureEvent(Event* const event) { captureEvents_.insert(event); }

    std::set<Event*> GetCaptureEvent() const { return captureEvents_; }

    void InsertSingleOperEvent(Event* const event) { singleOperEvents_.insert(event); }

    void DeleteSingleOperEvent(Event* const event) { (void)singleOperEvents_.erase(event); }

    rtError_t ResetCaptureEvents(Stream* const stm) const;
    // 注册capture阶段生成的external record占位任务，replay阶段再实例化真实record资源。
    rtError_t AddExternalRecordEvent(Event* event, uint32_t captureStreamId, uint32_t taskId);
    // 注册capture阶段生成的external wait占位任务，replay阶段再绑定真实producer资源。
    rtError_t AddExternalWaitEvent(Event* event, uint32_t captureStreamId, uint32_t taskId);

    void AddNotify(Notify* notify) { addStreamNotifyList_.push_back(notify); }

    void AddExeNotify(Notify* notify) { executeNotifyList_.push_back(notify); }

    const std::map<Stream*, std::vector<Stream*>>& GetAddStreamMap() { return addStreamMap_; }

    bool CheckIsUserAddStream(Stream* stm)
    {
        auto it = addStreamMap_.find(stm);
        COND_PROC((it != addStreamMap_.end()), return true;);

        return false;
    }

    void SetAddStreamMap(Stream* stm1, Stream* stm2) { addStreamMap_[stm1].push_back(stm2); }

    void InsertTaskGroupStreamId(const uint16_t streamId) { (void)taskGroupStmIds_.insert(streamId); }

    std::set<uint16_t>& GetTaskGroupStreamIds() { return taskGroupStmIds_; }

    void DeleteTaskGroupStreamId(const uint16_t streamId) { (void)taskGroupStmIds_.erase(streamId); }

    void ReplaceTaskGroupStreamId(const uint16_t oldStmId, const uint16_t newStmId)
    {
        auto iter = taskGroupStmIds_.find(oldStmId);
        if (iter != taskGroupStmIds_.end()) {
            (void)taskGroupStmIds_.erase(iter);
            (void)taskGroupStmIds_.insert(newStmId);
        }
    }

    void AddTaskGroupList(std::unique_ptr<TaskGroup>& taskGrp)
    {
        const std::unique_lock<std::mutex> lk(taskGroupListMutex_);
        taskGroupList_.push_back(std::move(taskGrp));
    }

    void SetTaskGroupErrCode(const rtError_t errCode) { taskGroupErrCode_ = errCode; }

    rtError_t GetTaskGroupErrCode(void) const { return taskGroupErrCode_; }

    const std::map<std::tuple<int32_t, uint16_t>, CondHandle*>& GetCondHandleTaskMap() const
    {
        return condHandleTaskMap_;
    }

    void DebugDotPrintTaskGroups(const uint32_t deviceId) const;
    void ReportedStreamInfoForProfiling() const;
    void ReportedStreamInfoForProfilingForAllModels();
    void EraseStreamInfoForProfiling() const;
    rtError_t SetShapeInfo(
        const Stream* const stm, const uint32_t taskId, const void* const infoPtr, const size_t infoSize);
    void ClearShapeInfo(const int32_t streamId, const uint32_t taskId);
    void* GetShapeInfo(const int32_t streamId, const uint32_t taskId, size_t& infoSize) const;

    rtError_t CacheLastTaskOpInfo(const void* const infoPtr, const size_t infoSize, const Stream* const stm);
    void ReportShapeInfoForProfiling() const;
    void ReportShapeInfoForProfilingForAllModels();
    void SetModelCacheOpInfoSwitch(const uint32_t status) const;
    void ReportTrackData(Profiler* profiler);
    void ReportTrackDataForAllModels(Profiler* profiler);

    uint32_t GetModelCacheOpInfoSwitch() const { return cacheOpInfoSwitch_; }

    void InsertRdmaPiValueModifyInfo(int32_t streamId, uint16_t taskId)
    {
        // 在captureLock_下，因此不需要再加锁
        (void)rdmaPiValueModifyTaskInfoMap_[streamId].insert(taskId);
    }

    const std::unordered_map<int32_t, std::unordered_set<uint16_t>>& GetRdmaPiValueModifyTaskInfoMap() const
    {
        // 目前只有模型执行完后的notify wait的后处理才会调用这个函数，所以不需要加锁
        return rdmaPiValueModifyTaskInfoMap_;
    }

    bool IsSoftwareSqEnable(void) const { return isSoftwareSqEnable_; }

    void SetSoftwareSqEnable(void) { isSoftwareSqEnable_ = true; }

    bool IsCaptureModelRunning(void) const { return (refCount_ != 0U); }

    bool ModelSqOperTryLock(void) { return sqBindMutex_.try_lock(); }

    void ModelSqOperUnLock(void) { return sqBindMutex_.unlock(); }

    void ResetTrackDataReportFlag() { trackDataReportFlag_ = false; }

    uint32_t GenerateSeqId() { return seqId_++; }

    const std::list<CondHandle*> CondHandle_() const { return condHandles_; }

    void ModelEraseCondHandle(CondHandle* const condHandle) { condHandles_.remove(condHandle); }

    void ModelPushBackCondHandle(CondHandle* const condHandle) { condHandles_.push_back(condHandle); }

    bool IsSubCaptureModel(void) const { return isSubCaptureModel_; }

    void SetSubCaptureModelEnable(void) { isSubCaptureModel_ = true; }

    void SetCondHandle(rtCondHandle_t condHandle) { condHandle_ = condHandle; }

    rtCondHandle_t GetCondHandle() const { return condHandle_; }

    void SetIsNeedUpdateEndGraph(bool isNeedUpdateEndGraph) { isNeedUpdateEndGraph_ = isNeedUpdateEndGraph; }

    void SetRootExeStreamId(uint16_t rootExeStreamId) { rootExeStreamId_ = rootExeStreamId; }

    uint16_t GetRootExeStreamId() const { return rootExeStreamId_; }

    uint32_t GetLoadCompleteNotifyid() const { return loadCompleteNotifyId_; }

    const TaskGroup* GetTaskGroup(uint16_t streamId, uint16_t taskId);
    void BackupArgHandle(const uint16_t streamId, const uint16_t taskId);
    rtError_t Update(void);

    rtError_t ReleaseNotifyId(uint32_t& releaseNum);
    rtError_t UpdateNotifyId(Stream* const exeStream);
    // endGraph + alloc sq cq + Send sqe + bind sq cq + load complete + update task
    rtError_t BuildSqCq(Stream* const exeStream);
    void DeconstructSqCq(void);
    rtError_t ReleaseSqCqAndNotifyId(uint32_t& releaseSqNum, uint32_t& releaseNtyNum);
    void CaptureModelExecuteFinish(const uint32_t errCode);

    // 子模型资源管理相关方法
    void GetSqCqTotalNum(uint32_t& streamNum);
    rtError_t ModelEndGraph();
    rtError_t SendLoadCompleteEndGraph();
    rtError_t AllocSqCqAndBindInternal();
    rtError_t AllocAllSqCq();
    rtError_t ReleaseSqCqInternal(uint32_t& releaseNum);
    rtError_t ReleaseAllSubModelSqCq(uint32_t& releaseNum);
    rtError_t LoadCompleteAll(uint32_t loadCompltetNotifyId);
    void UpdateIsNeedUpdateEndGraphFlagAll();
    rtError_t UpdateNotifyIdAll(Stream* const exeStream);
    rtError_t UpdateNotifyIdForAllModels(Stream* const exeStream);
    rtError_t UpdateCondTaskNotifyWaitSqe(Stream* const exeStream);
    rtError_t UpdateStreamActiveTaskFuncCallMemAll();
    rtError_t UpdateCondTaskFuncCallMemAll();
    void SetRootExeStreamIdAll(uint16_t rootExeStreamId);
    rtError_t StoreCondHandleTaskInfo(const int32_t streamId, const uint16_t taskId, CondHandle* condHandle);
    bool CheckSubModelsIsEndCapture();
    void ClearCachedAllSubModels();

    rtError_t MarkStreamActiveTask(TaskInfo* streamActiveTask); // the task of stream active is need updated
                                                                // after sq cq is allocated
    rtError_t RestoreForSoftwareSq(Device* const dev);
    rtError_t RestoreForSoftwareSqForOneModels(Device* const dev);

    rtError_t BindJettyForUbdma();
    rtError_t RecycleAllJetty(uint32_t& h2dCount, uint32_t& d2dCount);
    rtError_t ReleaseAllJetty();

    bool GetJettyBindFlag() const { return jettyBindFlag_; }
    void SetJettyBindFlag(bool bound) { jettyBindFlag_ = bound; }
    rtError_t EndCaptureAdapterProc();

private:
    rtError_t AllocSqAddr(void) const; // alloc sq addr
    rtError_t AllocSqCqProc(const uint32_t streamNum) const;
    rtError_t BindSqCq(void);
    rtError_t UnBindSqCq(void);
    rtError_t UpdateStreamActiveTaskFuncCallMem(void);
    void ClearStreamActiveTask(void);
    void ReleaseNotifyListOnDestroy(std::vector<Notify*>& notifyList);
    void ReleaseArgLoaderBackupOnDestroy();
    void FinalizeHostStateOnExit() noexcept;
    Stream* GetOriginalCaptureStream(void) const;
    rtError_t CheckExecuteReady(void) const;
    rtError_t PreModelExecute(Stream* const stm, ExternalEventRefreshInfo* refreshInfo);
    rtError_t ExecuteModel(
        Stream* const stm, int32_t timeout, const uint8_t executeMode, ExternalEventRefreshInfo* refreshInfo);
    rtError_t PostModelExecute(Stream* const stm, ExternalEventRefreshInfo* refreshInfo);
    rtError_t ExecuteCommon(Stream* const stm, int32_t timeout, const uint8_t executeMode);
    rtError_t BindSqCqAndSendSqe(void);
    rtError_t RebuildAllExternalTaskSqes() const;
    // capture end阶段创建external refresh表并替换record/wait占位任务。
    rtError_t FinalizeExternalRefreshTable();
    // 释放capture model持有的external refresh host模板和device表。
    void ReleaseExternalRefreshTable();
    // graph replay前准备本轮host refresh内容并持有record/wait资源。
    rtError_t PrepareExternalEventRefreshInfo(ExternalEventRefreshInfo* refreshInfo);
    rtError_t AllocateExternalRefreshTable();
    rtError_t BuildActualExternalRecordTasks();
    rtError_t BuildActualExternalWaitTasks();
    rtError_t PrepareExternalRecordsForReplay(ExternalEventRefreshInfo* refreshInfo);
    rtError_t PrepareExternalWaitsForReplay(ExternalEventRefreshInfo* refreshInfo);
    rtError_t BindStreamToModel(void);
    void ReportCacheTrackData();
    rtError_t InitAllSubCaptureModelCondTaskByDefValue();
    std::vector<CaptureModel*>& GetAllSubCaptureModels();
    void RestoreJettyForSnapshot();
    rtError_t RefreshJettyInfoList();
    bool ReportSingleCaptureStreamInfo(
        uint16_t captureStatus, uint32_t captureStmId, uint32_t singleOperStmId, uint64_t timeStamp) const;
    RtCaptureModelStatus captureModelStatus_{RtCaptureModelStatus::NONE};
    mutable uint32_t cacheOpInfoSwitch_{0U}; // aclgraph stream status: 0: false, 1:true
    std::map<int32_t, std::map<uint32_t, std::unique_ptr<uint8_t[]>>> shapeInfos_;
    std::unordered_map<int32_t, std::unordered_set<int32_t>> singleOperStmIdAndCaptureStmIdMap_;
    std::set<Event*> singleOperEvents_;
    std::set<Event*> captureEvents_;
    // external record占位任务引用，capture end和每次replay按该列表刷新。
    std::vector<ExternalEventTaskItem> externalRecordEventItems_;
    // external wait占位任务引用，capture end和每次replay按该列表刷新。
    std::vector<ExternalEventTaskItem> externalWaitEventItems_;
    // external refresh表布局，先存record entry，再存wait producer地址entry。
    ExternalEventRefreshLayout externalEventRefreshLayout_;
    // capture model生命周期内固定的device refresh表基地址。
    void* externalEventRefreshDeviceBase_{nullptr};
    // capture end生成的host模板，replay时复制后仅刷新动态字段。
    std::shared_ptr<uint8_t[]> externalEventRefreshHostTemplate_{nullptr};
    std::map<Stream*, std::vector<Stream*>> addStreamMap_; // key为add进来的stream，value为隐式创建的stream
    std::vector<Notify*> addStreamNotifyList_;
    std::vector<Notify*> executeNotifyList_;
    std::mutex notifyMutex_;
    std::mutex taskGroupListMutex_;
    std::set<uint16_t> taskGroupStmIds_;
    std::vector<std::unique_ptr<TaskGroup>> taskGroupList_;
    rtError_t taskGroupErrCode_{RT_ERROR_NONE};
    std::unordered_map<int32_t, std::unordered_set<uint16_t>> rdmaPiValueModifyTaskInfoMap_;
    bool isSoftwareSqEnable_{false};
    rtDeviceSqCqInfo_t* sqCqArray_{nullptr};
    struct sq_switch_stream_info* switchInfo_{nullptr};
    uint32_t sqCqNum_{0U};
    std::mutex streamActiveTaskListMutex_;
    std::vector<TaskInfo*> streamActiveTaskList_;
    std::mutex sqBindMutex_;
    std::list<CondHandle*> condHandles_; // 模型下发的condHandle
    uint32_t refCount_{0U};
    bool isNeedUpdateEndGraph_{false};
    uint64_t beginCaptureTimeStamp_{0UL};
    bool trackDataReportFlag_{false};
    std::atomic<uint32_t> seqId_{0};
    std::set<void*> argLoaderBackup_;
    std::mutex jettyMutex_;
    bool jettyBindFlag_{false}; // 表示当前model里normal jetty的绑定状态 -- 改成 jettyBindFlag_
    std::mutex condHandleTaskMapLock_;
    std::map<std::tuple<int32_t, uint16_t>, CondHandle*>
        condHandleTaskMap_;                         // <stream id, condition task id>, condHandle 只有父model非空
    std::vector<CaptureModel*> cachedAllSubModels_; // 只有根model有效，子model为空。缓存所有子model
    bool isSubCaptureModel_{false};
    uint64_t resourceGroupId_{0U};                  // 资源组ID，同一父子关系网共享
    rtCondHandle_t condHandle_{nullptr};            // 模型归属的condHandle
    uint16_t rootExeStreamId_{UINT16_MAX};
    uint32_t loadCompleteNotifyId_{0U};             // 用于子模型task error等异常场景
};
} // namespace runtime
} // namespace cce

#endif // __CCE_RUNTIME_CAPTURE_MODEL_HPP__
