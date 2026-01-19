/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "profiler.hpp"
#include <set>
#include "toolchain/prof_acl_api.h"
#include "stream.hpp"
#include "device.hpp"
#include "runtime.hpp"
#include "profiling_agent.hpp"
#include "task_info.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "capture_model.hpp"
#include "stub_task.hpp"

namespace cce {
namespace runtime {
namespace {
const std::set<tsTaskType_t> KERNEL_TASK_TYPE = {
    TS_TASK_TYPE_KERNEL_AICORE, TS_TASK_TYPE_KERNEL_AIVEC, TS_TASK_TYPE_KERNEL_AICPU};

static inline bool IsKernelTask(const TaskInfo &taskInfo)
{
    return KERNEL_TASK_TYPE.count(taskInfo.type) > 0U;
}

inline uint64_t GetKernelNameId(TaskInfo &taskInfo)
{
    if (IsKernelTask(taskInfo)) {
        if (taskInfo.type == TS_TASK_TYPE_KERNEL_AICPU) {
            const auto &aicpuTask = taskInfo.u.aicpuTaskInfo;
            if (aicpuTask.kernel != nullptr) {
                return aicpuTask.kernel->GetNameId();
            }
        } else {
            const auto &davinciTask = taskInfo.u.aicTaskInfo;
            if (davinciTask.kernel != nullptr) {
                return davinciTask.kernel->GetNameId();
            }
        }
    }
    RT_LOG(RT_LOG_DEBUG, "Get davinci task kernel is null.");
    return 0U;
}
}  // namespace

__THREAD_LOCAL__ uint32_t Profiler::threadId_ = 0U;
__THREAD_LOCAL__ uint32_t Profiler::seq_ = 0U;

Profiler::Profiler(Api *const apiObj)
    : NoCopy(), api_(apiObj), apiProfileDecorator_(nullptr), apiProfileLogDecorator_(nullptr), trackProfEnable_(false),
      apiProfEnable_(false), apiProfLogEnable_(false), processId_(PidTidFetcher::GetCurrentPid())
{
    const errno_t rc = memset_s(&profCfg_, sizeof(rtProfCfg_t), 0, sizeof(rtProfCfg_t));
    if (rc != EOK) {
        RT_LOG(RT_LOG_WARNING, "memset_s failed, retCode=%d, size=%zu.", rc, sizeof(rtProfCfg_t));
    }

    threadId_ = 0U;
    seq_ = 0U;
}

Profiler::~Profiler()
{
    DELETE_O(apiProfileDecorator_);
    DELETE_O(apiProfileLogDecorator_);
}

rtError_t Profiler::Init()
{
    apiProfileDecorator_ = new (std::nothrow) ApiProfileDecorator(api_, this);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM,
        apiProfileDecorator_ == nullptr,
        RT_ERROR_PROF_NEW,
        "Init profiler failed, new ApiProfileDecorator failed.");
    RT_LOG(RT_LOG_DEBUG, "new ApiProfileDecorator ok, size=%zu", sizeof(ApiProfileDecorator));

    apiProfileLogDecorator_ = new (std::nothrow) ApiProfileLogDecorator(api_, this);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM,
        apiProfileLogDecorator_ == nullptr,
        RT_ERROR_PROF_NEW,
        "Init profiler failed, new ApiProfileLogDecorator failed.");
    RT_LOG(RT_LOG_DEBUG, "new ApiProfileLogDecorator ok, size=%zu", sizeof(ApiProfileLogDecorator));

    RT_LOG(
        RT_LOG_INFO, "Init ok, Runtime_alloc_size %zu", sizeof(ApiProfileDecorator) + sizeof(ApiProfileLogDecorator));

    return RT_ERROR_NONE;
}

void Profiler::TrackDataInit(void) const
{
    TaskTrackInfo &trackMngInfo = GetProfTaskTrackData();
    trackMngInfo.taskNum = 0U;
    return;
}

bool Profiler::IsEnabled(const uint32_t devId) const
{
    UNUSED(devId);
    return (profCfg_.isRtsProfEn != 0U);
}

RuntimeProfApiData &Profiler::GetProfApiData() const
{
    return ProfilerGetProfApiData();
}

void Profiler::SetProfApiData(const RuntimeProfApiData profiler) const
{
    RuntimeProfApiData &srcProfilerData = ProfilerGetProfApiData();
    srcProfilerData = profiler;
    return;
}

TaskTrackInfo &Profiler::GetProfTaskTrackData(void) const
{
    return ProfilerGetProfTaskTrackData();
}

void Profiler::ReportProfApi(const uint32_t devId, RuntimeProfApiData &profApiData) const
{
    if (!GetApiProfEnable()) {
        return;
    }
    ProfilingAgent::Instance().ReportProfApi(devId, profApiData);
}

void Profiler::ReportStreamSynctaskFinish(const uint16_t profileType) const
{
    if (!GetApiProfEnable()) {
        return;
    }

    RuntimeProfApiData profApiData = {};
    profApiData.threadId = PidTidFetcher::GetCurrentTid();
    profApiData.dataSize = 0;
    profApiData.memcpyDirection = 0;
    profApiData.profileType = profileType;
    profApiData.entryTime = MsprofSysCycleTime();
    profApiData.exitTime = profApiData.entryTime;  // entry

    ProfilingAgent::Instance().ReportProfApi(0, profApiData);
    RT_LOG(RT_LOG_DEBUG, "profileType=%hu", profileType);
}

void Profiler::ModifyTrackData(RuntimeProfTrackData *trackData) const
{
    RuntimeProfApiData &profApiData = GetProfApiData();
    if (apiProfEnable_ && profApiData.entryTime != 0) {
        trackData->compactInfo.timeStamp =
            profApiData.entryTime + 1;  // trackData的时间戳只要在api的begin和end的范围之内就是合理的
    } else {
        trackData->compactInfo.timeStamp = MsprofSysCycleTime();
    }
}

static void ChangeTrackDataTaskType(struct MsprofRuntimeTrack &runtimeTrack, const TaskInfo *const taskInfo)
{
    if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICORE || taskInfo->type == TS_TASK_TYPE_KERNEL_AIVEC) {
        const auto &aicTaskInfo = taskInfo->u.aicTaskInfo;
        const uint8_t mixType = (aicTaskInfo.kernel != nullptr) ? aicTaskInfo.kernel->GetMixType() : 0U;
        if (mixType == MIX_AIC || mixType == MIX_AIC_AIV_MAIN_AIC) {
            runtimeTrack.taskType = TS_TASK_TYPE_KERNEL_MIX_AIC;
        } else if (mixType == MIX_AIV || mixType == MIX_AIC_AIV_MAIN_AIV) {
            runtimeTrack.taskType = TS_TASK_TYPE_KERNEL_MIX_AIV;
        } else {
            ;
        }
        RT_LOG(RT_LOG_DEBUG, "ReportTaskTrack, runtimeTrack.taskType=%llu, mixType=%u", runtimeTrack.taskType, mixType);
    }
}

void Profiler::ReportTaskTrack(TaskInfo *const taskInfo, const uint32_t devId) const
{
    // cache model task and model stream, report when taskTrack switch is turned on
    // When the stream is destroyed, clear the cached model stream object
    if ((taskInfo->stream != nullptr) && (taskInfo->stream->GetBindFlag())) {
        taskInfo->taskTrackTimeStamp = MsprofSysCycleTime();
        taskInfo->stream->CacheBindTrackTaskId(taskInfo->id);
        // cache model task's stream, report when taskTrack switch is turned on
        RT_LOG(RT_LOG_DEBUG,
            "cache task profiling info, stream_id=%d, task_id=%u.",
            taskInfo->stream->Id_(),
            taskInfo->id);
    }

    if (!GetTrackProfEnable()) {
        return;
    }

    TaskTrackInfo &trackMngInfo = GetProfTaskTrackData();
    uint32_t taskNum = trackMngInfo.taskNum;

    if (taskNum == RUNTIME_TASK_TRACK_BUFF_NUM) {
        RuntimeProfTrackData *trackData;
        for (uint32_t i = 0U; i < RUNTIME_TASK_TRACK_BUFF_NUM; i++) {
            trackData = &trackMngInfo.trackBuff[i];
            RT_LOG(RT_LOG_DEBUG,
                "isModel=%u, threadId=%u, timeStamp=%llu, devId=%u, "
                "stream_id=%u, task_id=%u, task_type=%u, kernel_name=%llu",
                trackData->isModel,
                trackData->compactInfo.threadId,
                trackData->compactInfo.timeStamp,
                trackData->compactInfo.data.runtimeTrack.deviceId,
                trackData->compactInfo.data.runtimeTrack.streamId,
                trackData->compactInfo.data.runtimeTrack.taskId,
                trackData->compactInfo.data.runtimeTrack.taskType,
                trackData->compactInfo.data.runtimeTrack.kernelName);
            const bool agingFlag = (trackData->isModel != 0) ? false : true;
            const int32_t ret = MsprofReportCompactInfo(static_cast<uint32_t>(agingFlag),
                &trackData->compactInfo,
                static_cast<uint32_t>(sizeof(MsprofCompactInfo)));
            if (ret != MSPROF_ERROR_NONE) {
                RT_LOG_CALL_MSG(ERR_MODULE_PROFILE, "Profiling reporter report task_track failed, ret=%d.", ret);
                return;
            }
        }

        trackMngInfo.taskNum = 0U;
        taskNum = 0U;
    }

    RuntimeProfTrackData *trackData = &(trackMngInfo.trackBuff[taskNum]);
    const Stream *const stm = taskInfo->stream;

    trackData->isModel = (stm == nullptr) ? false : stm->GetBindFlag();  // is it a model task

    trackData->compactInfo.level = MSPROF_REPORT_RUNTIME_LEVEL;
    trackData->compactInfo.type = RT_PROFILE_TYPE_TASK_TRACK;  // RT_PROFILE_TYPE_TASK_TRACK regitered in init
    ModifyTrackData(trackData);
    trackData->compactInfo.threadId = GetCurrentTid();
    trackData->compactInfo.dataLen = static_cast<uint32_t>(sizeof(MsprofRuntimeTrack));
    trackData->compactInfo.data.runtimeTrack.deviceId = static_cast<uint16_t>(devId);
    trackData->compactInfo.data.runtimeTrack.streamId =
        (stm == nullptr) ? RT_MAX_STREAM_ID : static_cast<uint16_t>(stm->Id_());
    if (taskInfo->type == TS_TASK_TYPE_FLIP) {
        trackData->compactInfo.data.runtimeTrack.taskId =
            GetFlipTaskId(taskInfo->id, taskInfo->u.flipTask.flipNumReport);
    } else {
        trackData->compactInfo.data.runtimeTrack.taskId = GetProfTaskId(taskInfo);
    }
    trackData->compactInfo.data.runtimeTrack.taskType = taskInfo->type;
    ChangeTrackDataTaskType(trackData->compactInfo.data.runtimeTrack, taskInfo);
    trackData->compactInfo.data.runtimeTrack.kernelName = GetKernelNameId(*taskInfo);

    // for mutil enable profiling
    taskInfo->taskTrackTimeStamp = trackData->compactInfo.timeStamp;

    RT_LOG(RT_LOG_INFO,
        "ReportTaskTrack, runtimeTrack->taskId=%u, taskInfo->id=%u, taskInfo->flipNum=%u",
        trackData->compactInfo.data.runtimeTrack.taskId,
        taskInfo->id,
        taskInfo->flipNum);

    trackMngInfo.taskNum++;

    if (!GetApiProfEnable()) {  // if not open api profiling, will send taskTrack separately
        RT_LOG(RT_LOG_DEBUG,
            "isModel=%u, threadId=%u, timeStamp=%llu, devId=%u, stream_id=%u, task_id=%u, "
            "task_type=%u, kernel_name=%llu",
            trackData->isModel,
            trackData->compactInfo.threadId,
            trackData->compactInfo.timeStamp,
            trackData->compactInfo.data.runtimeTrack.deviceId,
            trackData->compactInfo.data.runtimeTrack.streamId,
            trackData->compactInfo.data.runtimeTrack.taskId,
            trackData->compactInfo.data.runtimeTrack.taskType,
            trackData->compactInfo.data.runtimeTrack.kernelName);
        const bool agingFlag = (trackData->isModel != 0) ? false : true;
        const int32_t ret = MsprofReportCompactInfo(static_cast<uint32_t>(agingFlag),
            &trackData->compactInfo,
            static_cast<uint32_t>(sizeof(MsprofCompactInfo)));
        if (ret != MSPROF_ERROR_NONE) {
            RT_LOG_CALL_MSG(ERR_MODULE_PROFILE, "Profiling reporter report task_track failed, ret=%d.", ret);
            return;
        }
        trackMngInfo.taskNum = 0U;
        return;
    }
}

void Profiler::ReportDestroyFlipTask(const Stream *const stm, const uint32_t devId) const
{
    MsprofCompactInfo compactInfo{};
    compactInfo.level = MSPROF_REPORT_RUNTIME_LEVEL;
    compactInfo.type = RT_PROFILE_TYPE_TASK_TRACK;  // RT_PROFILE_TYPE_TASK_TRACK regitered in init
    compactInfo.timeStamp = MsprofSysCycleTime();
    compactInfo.threadId = GetCurrentTid();
    compactInfo.dataLen = static_cast<uint32_t>(sizeof(MsprofRuntimeTrack));
    compactInfo.data.runtimeTrack.deviceId = static_cast<uint16_t>(devId);
    compactInfo.data.runtimeTrack.streamId = (stm == nullptr) ? RT_MAX_STREAM_ID : static_cast<uint16_t>(stm->Id_());
    compactInfo.data.runtimeTrack.taskId = 0xFFFFFFFFU;
    compactInfo.data.runtimeTrack.taskType = TS_TASK_TYPE_FLIP;

    RT_LOG(RT_LOG_INFO,
        "threadId=%u, timeStamp=%llu, devId=%u, stream_id=%u",
        compactInfo.threadId,
        compactInfo.timeStamp,
        compactInfo.data.runtimeTrack.deviceId,
        compactInfo.data.runtimeTrack.streamId);

    const int32_t ret = MsprofReportCompactInfo(true, &compactInfo, static_cast<uint32_t>(sizeof(MsprofCompactInfo)));
    if (ret != MSPROF_ERROR_NONE) {
        RT_LOG_CALL_MSG(ERR_MODULE_PROFILE, "Profiling reporter report task_track failed, ret=%d.", ret);
        return;
    }
    return;
}

void Profiler::InsertStream(Stream *const stm)
{
    if (likely(stm != nullptr)) {
        RT_LOG(RT_LOG_INFO, "streamId=%d", stm->Id_());
        streamSetMutex_.lock();
        (void)streamSet_.insert(stm);
        streamSetMutex_.unlock();
    }
}

// When the stream is destroyed, erase the cached model stream object
void Profiler::EraseStream(Stream *const stm)
{
    RT_LOG(RT_LOG_INFO, "earse streamId=%u", stm->Id_());
    streamSetMutex_.lock();
    const auto it = streamSet_.find(stm);
    if (unlikely(it == streamSet_.end())) {
        RT_LOG(RT_LOG_INFO, "not in modelStreamSet");
        streamSetMutex_.unlock();
        return;
    }
    (void)streamSet_.erase(it);
    streamSetMutex_.unlock();
}

void Profiler::ReportSend(const uint16_t taskId, const uint16_t stmId) const
{
    if (!apiProfLogEnable_) {
        return;
    }

    rtProfileRecordAsyncSend_t recordAsyncSend;
    recordAsyncSend.type = PROFILE_RECORD_TYPE_RT_ASYNC_SEND;

    recordAsyncSend.pid = processId_;
    recordAsyncSend.taskId = taskId;
    recordAsyncSend.streamId = stmId;
    recordAsyncSend.sendStamp = GetTickCount();

    RT_LOG(RT_LOG_INFO,
        "Send: RecordType=%hu pid=%u taskId=%u streamId=%u time=%" PRIu64 "ns",
        recordAsyncSend.type,
        recordAsyncSend.pid,
        recordAsyncSend.taskId,
        recordAsyncSend.streamId,
        recordAsyncSend.sendStamp);
}

void Profiler::ReportRecv(const TaskInfo *const taskInfo) const
{
    if (!apiProfLogEnable_) {
        return;
    }

    const Stream *const stm = taskInfo->stream;

    rtProfileRecordAsyncRecv_t recordAsyncRecv;
    recordAsyncRecv.type = PROFILE_RECORD_TYPE_RT_ASYNC_RECV;
    recordAsyncRecv.pid = processId_;
    recordAsyncRecv.taskId = taskInfo->id;
    recordAsyncRecv.streamId = static_cast<uint32_t>(stm->Id_());
    recordAsyncRecv.recvStamp = GetTickCount();

    RT_LOG(RT_LOG_DEBUG,
        "Recv: RecordType=%hu pid=%u taskId=%u streamId=%u time=%" PRIu64 "ns",
        recordAsyncRecv.type,
        recordAsyncRecv.pid,
        recordAsyncRecv.taskId,
        recordAsyncRecv.streamId,
        recordAsyncRecv.recvStamp);
}

void Profiler::ReportReceivingRun(const TaskInfo *const taskInfo, const uint32_t devId) const
{
    UNUSED(devId);
    ReportRecv(taskInfo);
}

void Profiler::RuntimeProfilerStart(void) const
{
    RT_LOG(RT_LOG_INFO, "ProfilerStart");
    const auto ret = ProfilingAgent::Instance().Init();
    COND_RETURN_VOID(ret != RT_ERROR_NONE, "runtime init profiling failed, retCode=%#x.", ret);
}

// report cache task track and clear streamSet_
void Profiler::ReportCacheTrack(uint32_t cacheFlag)
{
    const Runtime *const rtInstance = Runtime::Instance();
    streamSetMutex_.lock();
    if (streamSet_.empty()) {
        RT_LOG(RT_LOG_INFO, "the cache is empty");
        streamSetMutex_.unlock();
        return;
    }

    RT_LOG(RT_LOG_INFO, "begin report cache track, stream set size=%zu", streamSet_.size());
    for (Stream *const it : streamSet_) {
        RuntimeProfTrackData trackData{};
        if ((it == nullptr) || (it->Device_() == nullptr)) {
            RT_LOG(RT_LOG_WARNING, "this cacheTask stream is invalid");
            continue;
        }

        const int32_t steamId = it->Id_();
        const uint32_t devId = it->Device_()->Id_();
        RT_LOG(RT_LOG_DEBUG, "report cache, steamId=%d, device id=%u", steamId, devId);
        // Repetitive enable profiling
        TaskInfo *cacheTask = nullptr;
        const std::list<uint16_t> &cacheTrackTaskIdList = it->GetCacheTrackTaskList();
        for (const uint16_t taskId : cacheTrackTaskIdList) {
            cacheTask = GetTaskInfo(it->Device_(), static_cast<uint32_t>(steamId), static_cast<uint32_t>(taskId));
            if (cacheTask == nullptr) {
                RT_LOG(RT_LOG_WARNING, "cacheTask is null");
                continue;
            }

            trackData.isModel = true;
            trackData.compactInfo.level = MSPROF_REPORT_RUNTIME_LEVEL;
            trackData.compactInfo.type = RT_PROFILE_TYPE_TASK_TRACK;  // RT_PROFILE_TYPE_TASK_TRACK register in init
            trackData.compactInfo.timeStamp = cacheTask->taskTrackTimeStamp;
            trackData.compactInfo.threadId = cacheTask->tid;
            trackData.compactInfo.dataLen = static_cast<uint32_t>(sizeof(MsprofRuntimeTrack));

            trackData.compactInfo.data.runtimeTrack.deviceId = static_cast<uint16_t>(devId);
            trackData.compactInfo.data.runtimeTrack.streamId = static_cast<uint32_t>(steamId);
            trackData.compactInfo.data.runtimeTrack.taskId = GetProfTaskId(cacheTask);
            trackData.compactInfo.data.runtimeTrack.taskType = cacheTask->type;
            ChangeTrackDataTaskType(trackData.compactInfo.data.runtimeTrack, cacheTask);
            trackData.compactInfo.data.runtimeTrack.kernelName = GetKernelNameId(*cacheTask);
            RT_LOG(RT_LOG_DEBUG,
                "isModel=%u, threadId=%u, timeStamp=%llu, devId=%hu, "
                "stream_id=%hu, task_id=%u ,task_type=%llu, kernel_name=%llu",
                trackData.isModel,
                trackData.compactInfo.threadId,
                trackData.compactInfo.timeStamp,
                trackData.compactInfo.data.runtimeTrack.deviceId,
                trackData.compactInfo.data.runtimeTrack.streamId,
                trackData.compactInfo.data.runtimeTrack.taskId,
                trackData.compactInfo.data.runtimeTrack.taskType,
                trackData.compactInfo.data.runtimeTrack.kernelName);
            const bool agingFlag = (trackData.isModel != 0) ? false : true;
            (void)MsprofReportCompactInfo(static_cast<uint32_t>(agingFlag),
                &trackData.compactInfo,
                static_cast<uint32_t>(sizeof(MsprofCompactInfo)));
        }
        if (cacheFlag == 1) {
            it->ClearCacheTrackTaskList();
        }
    }
    streamSetMutex_.unlock();

    Context *curCtx = rtInstance->CurrentContext();
    if (curCtx != nullptr) {
        SpinLock &modelLock = curCtx->GetModelLock();
        modelLock.Lock();
        for (const auto it : curCtx->GetModelList()) {
            if (it != nullptr && it->GetModelType() == RT_MODEL_CAPTURE_MODEL) {
                const CaptureModel *captureMdl = dynamic_cast<const CaptureModel *>(it);
                captureMdl->ReportedStreamInfoForProfiling();
            }
        }
        modelLock.Unlock();
    }
    RT_LOG(RT_LOG_INFO, "end report cache track");
}

void Profiler::ReportCacheShapeInfo() const
{
    RT_LOG(RT_LOG_INFO, "Begin report cache shape info");
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    if (curCtx != nullptr) {
        SpinLock &modelLock = curCtx->GetModelLock();
        modelLock.Lock();
        for (const auto it : curCtx->GetModelList()) {
            if (it != nullptr && it->GetModelType() == RT_MODEL_CAPTURE_MODEL) {
                const CaptureModel *captureMdl = dynamic_cast<const CaptureModel *>(it);
                captureMdl->ReportShapeInfoForProfiling();
            }
        }
        modelLock.Unlock();
    }
    RT_LOG(RT_LOG_INFO, "End report cache shape info");
}

void Profiler::RuntimeProfilerStop(void) const
{
    RT_LOG(RT_LOG_INFO, "ProfilerStop");
    const auto ret = ProfilingAgent::Instance().UnInit();
    COND_RETURN_VOID(ret != RT_ERROR_NONE, "runtime UnInit profiling failed, retCode=%#x.", ret);
}

void Profiler::TsProfilerStart(const uint64_t profConfig, const uint32_t devId, Device *const dev)
{
    RT_LOG(RT_LOG_DEBUG, "profConfig=%#" PRIx64 ", devId=%u.", profConfig, devId);
    profCfg_.isRtsProfEn = ((profConfig & PROF_SCHEDULE_TIMELINE_MASK) == 0U) ? 0U : 1U;
    if ((Runtime::Instance()->GetTsNum() == TS_NUM_ADC) && (dev->DevGetTsId() == 1U)) {  // adc and ts1
        profCfg_.isTaskBasedProfEn = ((profConfig & PROF_AIVECTORCORE_METRICS_MASK) == 0U) ? 0U : 1U;
    } else {
        profCfg_.isTaskBasedProfEn = ((profConfig & PROF_AICORE_METRICS_MASK) == 0U) ? 0U : 1U;
    }
    profCfg_.isProfLogEn = ((profConfig & static_cast<uint64_t>(PROF_RUNTIME_PROFILE_LOG_MASK)) == 0U) ? 0U : 1U;
    profCfg_.isHwtsLogEn = ((profConfig & static_cast<uint64_t>(PROF_TASK_TIME_MASK)) == 0ULL) ? 0U : 1U;

    if ((profCfg_.isRtsProfEn != 0U) || (profCfg_.isTaskBasedProfEn != 0U) || (profCfg_.isProfLogEn != 0U) ||
        (profCfg_.isHwtsLogEn != 0U)) {
        TaskInfo submitTask = {};
        rtError_t errorReason;
        TaskInfo *tsk = dev->GetCtrlStream(dev->PrimaryStream_())
                            ->AllocTask(&submitTask, TS_TASK_TYPE_PROFILING_ENABLE, errorReason);
        COND_RETURN_VOID(tsk == nullptr, "tsk is NULL, errorReason=%d.", errorReason);

        uint32_t pid;
        (void)dev->Driver_()->DeviceGetBareTgid(&pid);

        if ((dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_PROFILING_TS_DYNAMIC)) &&
            (dev->CheckFeatureSupport(TS_FEATURE_DYNAMIC_PROFILING))) {
            (void)DynamicProfilingEnableTaskInit(tsk, static_cast<uint64_t>(pid), &profCfg_);
        } else {
            (void)ProfilingEnableTaskInit(tsk, static_cast<uint64_t>(pid), &profCfg_);
        }

        const rtError_t error = dev->SubmitTask(tsk);
        if (error != RT_ERROR_NONE) {
            (void)dev->GetTaskFactory()->Recycle(tsk);
        }
    }
    Runtime::Instance()->SetProfileEnableFlag(IsEnabled(devId));
    return;
}

void Profiler::TsProfilerStart(
    const uint64_t profConfig, const uint32_t devId, Device *const dev, const bool needOpenTimeline)
{
    RT_LOG(
        RT_LOG_DEBUG, "profConfig=%#" PRIx64 ", devId=%u, needOpenTimeline=%d.", profConfig, devId, needOpenTimeline);
    profCfg_.isRtsProfEn = (needOpenTimeline) ? 1U : 0U;
    if ((Runtime::Instance()->GetTsNum() == TS_NUM_ADC) && (dev->DevGetTsId() == 1U)) {  // adc and ts1
        profCfg_.isTaskBasedProfEn = ((profConfig & PROF_AIVECTORCORE_METRICS_MASK) == 0U) ? 0U : 1U;
    } else {
        profCfg_.isTaskBasedProfEn = ((profConfig & PROF_AICORE_METRICS_MASK) == 0U) ? 0U : 1U;
    }
    profCfg_.isProfLogEn = ((profConfig & static_cast<uint64_t>(PROF_RUNTIME_PROFILE_LOG_MASK)) == 0U) ? 0U : 1U;

    if ((profCfg_.isRtsProfEn != 0U) || (profCfg_.isTaskBasedProfEn != 0U) || (profCfg_.isProfLogEn != 0U)) {
        TaskInfo submitTask = {};
        rtError_t errorReason;
        TaskInfo *const tsk = dev->GetCtrlStream(dev->PrimaryStream_())
                                  ->AllocTask(&submitTask, TS_TASK_TYPE_PROFILING_ENABLE, errorReason);
        COND_RETURN_VOID(tsk == nullptr, "tsk is NULL, errorReason=%d.", errorReason);

        uint32_t pid;
        (void)dev->Driver_()->DeviceGetBareTgid(&pid);

        (void)ProfilingEnableTaskInit(tsk, static_cast<uint64_t>(pid), &profCfg_);
        const rtError_t error = dev->SubmitTask(tsk);
        if (error != RT_ERROR_NONE) {
            (void)dev->GetTaskFactory()->Recycle(tsk);
        }
    }
    Runtime::Instance()->SetProfileEnableFlag(IsEnabled(devId));
    return;
}

void Profiler::TsProfilerStop(const uint64_t profConfig, const uint32_t devId, Device *const dev)
{
    RT_LOG(RT_LOG_DEBUG, "profConfig=%#" PRIx64 ", devId=%u.", profConfig, devId);
    profCfg_.isRtsProfEn = ((profConfig & PROF_SCHEDULE_TIMELINE_MASK) == 0U) ? 0U : 1U;
    if ((Runtime::Instance()->GetTsNum() == TS_NUM_ADC) && (dev->DevGetTsId() == 1U)) {  // adc and ts1
        profCfg_.isTaskBasedProfEn = ((profConfig & PROF_AIVECTORCORE_METRICS_MASK) == 0U) ? 0U : 1U;
    } else {
        profCfg_.isTaskBasedProfEn = ((profConfig & PROF_AICORE_METRICS_MASK) == 0U) ? 0U : 1U;
    }
    profCfg_.isProfLogEn = ((profConfig & static_cast<uint64_t>(PROF_RUNTIME_PROFILE_LOG_MASK)) == 0U) ? 0U : 1U;
    profCfg_.isHwtsLogEn = ((profConfig & static_cast<uint64_t>(PROF_TASK_TIME_MASK)) == 0ULL) ? 0U : 1U;

    if ((profCfg_.isRtsProfEn != 0U) || (profCfg_.isTaskBasedProfEn != 0U) || (profCfg_.isProfLogEn != 0U) ||
        (profCfg_.isHwtsLogEn != 0U)) {
        TaskInfo submitTask = {};
        rtError_t errorReason;
        TaskInfo *tsk = dev->PrimaryStream_()->AllocTask(&submitTask, TS_TASK_TYPE_PROFILING_DISABLE, errorReason);
        COND_RETURN_VOID(tsk == nullptr, "tsk is NULL, errorReason=%d.", errorReason);

        uint32_t pid;
        (void)dev->Driver_()->DeviceGetBareTgid(&pid);

        if ((dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_PROFILING_TS_DYNAMIC)) &&
            (dev->CheckFeatureSupport(TS_FEATURE_DYNAMIC_PROFILING))) {
            (void)DynamicProfilingDisableTaskInit(tsk, static_cast<uint64_t>(pid), &profCfg_);
        } else {
            (void)ProfilingDisableTaskInit(tsk, static_cast<uint64_t>(pid), &profCfg_);
        }

        const rtError_t error = dev->SubmitTask(tsk);
        if (error != RT_ERROR_NONE) {
            (void)dev->GetTaskFactory()->Recycle(tsk);
        }
    }
    Runtime::Instance()->SetProfileEnableFlag(IsEnabled(devId));
    return;
}

void Profiler::TsProfilerStop(
    const uint64_t profConfig, const uint32_t devId, Device *const dev, const bool needCloseTimeline)
{
    RT_LOG(
        RT_LOG_DEBUG, "profConfig=%#" PRIx64 ", devId=%u, needCloseTimeline=%d.", profConfig, devId, needCloseTimeline);

    profCfg_.isRtsProfEn = (needCloseTimeline) ? 1U : 0U;
    if ((Runtime::Instance()->GetTsNum() == TS_NUM_ADC) && (dev->DevGetTsId() == 1U)) {  // adc and ts1
        profCfg_.isTaskBasedProfEn = ((profConfig & PROF_AIVECTORCORE_METRICS_MASK) == 0U) ? 0U : 1U;
    } else {
        profCfg_.isTaskBasedProfEn = ((profConfig & PROF_AICORE_METRICS_MASK) == 0U) ? 0U : 1U;
    }
    profCfg_.isProfLogEn = ((profConfig & static_cast<uint64_t>(PROF_RUNTIME_PROFILE_LOG_MASK)) == 0U) ? 0U : 1U;

    if ((profCfg_.isRtsProfEn != 0U) || (profCfg_.isTaskBasedProfEn != 0U) || (profCfg_.isProfLogEn != 0U)) {
        TaskInfo submitTask = {};
        rtError_t errorReason;
        TaskInfo *tsk = dev->PrimaryStream_()->AllocTask(&submitTask, TS_TASK_TYPE_PROFILING_DISABLE, errorReason);
        COND_RETURN_VOID(tsk == nullptr, "tsk is NULL, errorReason=%d.", errorReason);

        uint32_t pid;
        (void)dev->Driver_()->DeviceGetBareTgid(&pid);

        (void)ProfilingDisableTaskInit(tsk, static_cast<uint64_t>(pid), &profCfg_);

        const rtError_t error = dev->SubmitTask(tsk);
        if (error != RT_ERROR_NONE) {
            (void)dev->GetTaskFactory()->Recycle(tsk);
        }
    }
    Runtime::Instance()->SetProfileEnableFlag(IsEnabled(devId));
    return;
}

}  // namespace runtime
}  // namespace cce
