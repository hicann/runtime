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
#include "error_message_manage.hpp"
#include "rt_log.h"
#include "stream.hpp"
#include "device.hpp"
#include "runtime.hpp"
#include "profiling_agent.hpp"
#include "task_info.hpp"
#include "profiling_task.h"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "capture_model.hpp"
#include "stub_task.hpp"
#include "context.hpp"
#include "context_manage.hpp"

namespace cce {
namespace runtime {
namespace {
const std::set<tsTaskType_t> KERNEL_TASK_TYPE = {
    TS_TASK_TYPE_KERNEL_AICORE, TS_TASK_TYPE_KERNEL_AIVEC, TS_TASK_TYPE_KERNEL_AICPU};

static inline bool IsKernelTask(const TaskInfo& taskInfo) { return KERNEL_TASK_TYPE.count(taskInfo.type) > 0U; }

inline uint64_t GetKernelNameId(TaskInfo& taskInfo)
{
    if (IsKernelTask(taskInfo)) {
        if (taskInfo.type == TS_TASK_TYPE_KERNEL_AICPU) {
            const auto& aicpuTask = taskInfo.u.aicpuTaskInfo;
            if (aicpuTask.kernel != nullptr) {
                return aicpuTask.kernel->GetNameId();
            }
        } else {
            const auto& davinciTask = taskInfo.u.aicTaskInfo;
            if (davinciTask.kernel != nullptr) {
                return davinciTask.kernel->GetNameId();
            }
        }
    }
    RT_LOG(RT_LOG_DEBUG, "Get davinci task kernel is null.");
    return 0U;
}
} // namespace

__THREAD_LOCAL__ uint32_t Profiler::threadId_ = 0U;
__THREAD_LOCAL__ uint32_t Profiler::seq_ = 0U;

Profiler::Profiler(Api* const apiObj)
    : NoCopy(),
      api_(apiObj),
      apiProfileDecorator_(nullptr),
      apiProfileLogDecorator_(nullptr),
      profCfg_(),
      trackProfEnable_(false),
      apiProfEnable_(false),
      apiProfLogEnable_(false),
      processId_(PidTidFetcher::GetCurrentPid())
{
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
    COND_RETURN_AND_MSG_OUTER(
        apiProfileDecorator_ == nullptr, RT_ERROR_PROF_NEW, ErrorCode::EE1013,
        std::to_string(sizeof(ApiProfileDecorator)).c_str(), "new");
    RT_LOG(RT_LOG_DEBUG, "new ApiProfileDecorator ok, size=%zu", sizeof(ApiProfileDecorator));

    apiProfileLogDecorator_ = new (std::nothrow) ApiProfileLogDecorator(api_, this);
    COND_RETURN_AND_MSG_OUTER(
        apiProfileLogDecorator_ == nullptr, RT_ERROR_PROF_NEW, ErrorCode::EE1013,
        std::to_string(sizeof(ApiProfileLogDecorator)).c_str(), "new");
    RT_LOG(RT_LOG_DEBUG, "new ApiProfileLogDecorator ok, size=%zu", sizeof(ApiProfileLogDecorator));

    RT_LOG(
        RT_LOG_INFO, "Init ok, Runtime_alloc_size %zu", sizeof(ApiProfileDecorator) + sizeof(ApiProfileLogDecorator));

    return RT_ERROR_NONE;
}

void Profiler::TrackDataInit(void) const
{
    TaskTrackInfo& trackMngInfo = GetProfTaskTrackData();
    trackMngInfo.taskNum = 0U;
    return;
}

bool Profiler::IsEnabled(const uint32_t devId) const
{
    UNUSED(devId);
    return (profCfg_.isRtsProfEn != 0U);
}

RuntimeProfApiData& Profiler::GetProfApiData() const { return ProfilerGetProfApiData(); }

ProfApiContext* Profiler::PushProfApiContext() const { return ProfilerPushProfApiContext(); }

bool Profiler::PopProfApiContext(ProfApiContext& profApiContext) const
{
    return ProfilerPopProfApiContext(profApiContext);
}

ProfApiContext* Profiler::GetTopProfApiContext() const { return ProfilerGetTopProfApiContext(); }

TaskTrackInfo& Profiler::GetProfTaskTrackData(void) const { return ProfilerGetProfTaskTrackData(); }

void Profiler::ReportProfApi(const uint32_t devId, RuntimeProfApiData& profApiData) const
{
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
    profApiData.exitTime = profApiData.entryTime; // entry

    ProfilingAgent::Instance().ReportProfApi(0, profApiData);
    RT_LOG(RT_LOG_DEBUG, "profileType=%hu", profileType);
}

void ChangeTrackDataTaskType(struct MsprofRuntimeTrack& runtimeTrack, const TaskInfo* const taskInfo)
{
    const auto& aicTaskInfo = taskInfo->u.aicTaskInfo;
    const uint8_t mixType = (aicTaskInfo.kernel != nullptr) ? aicTaskInfo.kernel->GetMixType() : 0U;
    const bool isPureSimtTask = IsPureSimtTask(aicTaskInfo);
    if (isPureSimtTask) {
        runtimeTrack.taskType = static_cast<uint64_t>(ProfTaskType::PROF_TASK_TYPE_KERNEL_SIMT);
    } else if (mixType == MIX_AIC || mixType == MIX_AIC_AIV_MAIN_AIC) {
        runtimeTrack.taskType = TS_TASK_TYPE_KERNEL_MIX_AIC;
    } else if (mixType == MIX_AIV || mixType == MIX_AIC_AIV_MAIN_AIV) {
        runtimeTrack.taskType = TS_TASK_TYPE_KERNEL_MIX_AIV;
    } else {
        // no op
    }
    RT_LOG(
        RT_LOG_DEBUG, "ReportTaskTrack, runtimeTrack.taskType=%llu, mixType=%u, isPureSimtTask=%d",
        runtimeTrack.taskType, mixType, isPureSimtTask);
}

void FillKernelLaunchExtInfo(struct MsprofRuntimeTrack& runtimeTrack, const TaskInfo* const taskInfo)
{
    const tsTaskType_t taskType = taskInfo->type;
    if ((taskType != TS_TASK_TYPE_KERNEL_AICORE) && (taskType != TS_TASK_TYPE_KERNEL_AIVEC)) {
        return;
    }
    ChangeTrackDataTaskType(runtimeTrack, taskInfo);
    const auto& aicTaskInfo = taskInfo->u.aicTaskInfo;
    const uint32_t argsSize = aicTaskInfo.comm.argsSize - aicTaskInfo.simtParamOffset;
    const uint16_t argsSizeU16 = static_cast<uint16_t>((argsSize > UINT16_MAX) ? UINT16_MAX : argsSize);
    if (IsPureSimtTask(aicTaskInfo)) {
        const rtDim3& gridDim = aicTaskInfo.gridDim;
        const rtDim3& blockDim = aicTaskInfo.blockDim;
        runtimeTrack.extInfo.simtKernelInfo.gridDim.x = static_cast<uint16_t>(gridDim.x);
        runtimeTrack.extInfo.simtKernelInfo.gridDim.y = static_cast<uint16_t>(gridDim.y);
        runtimeTrack.extInfo.simtKernelInfo.gridDim.z = static_cast<uint16_t>(gridDim.z);
        runtimeTrack.extInfo.simtKernelInfo.blockDim.x = static_cast<uint16_t>(blockDim.x);
        runtimeTrack.extInfo.simtKernelInfo.blockDim.y = static_cast<uint16_t>(blockDim.y);
        runtimeTrack.extInfo.simtKernelInfo.blockDim.z = static_cast<uint16_t>(blockDim.z);
        runtimeTrack.extInfo.simtKernelInfo.argsSize = argsSizeU16;
        runtimeTrack.extInfo.simtKernelInfo.schedMode = aicTaskInfo.schemMode;
        runtimeTrack.extInfo.simtKernelInfo.rsv = 0U;
        runtimeTrack.extInfo.simtKernelInfo.reserved = 0U;
        RT_LOG(
            RT_LOG_DEBUG,
            "Fill ext info, gridDim=[%u,%u,%u], blockDim=[%u,%u,%u], argsSize=%hu, "
            "original argsSize=%u, schedMode=%u",
            gridDim.x, gridDim.y, gridDim.z, blockDim.x, blockDim.y, blockDim.z, argsSizeU16, argsSize,
            runtimeTrack.extInfo.simtKernelInfo.schedMode);
    } else {
        const uint8_t mixType = (aicTaskInfo.kernel != nullptr) ? aicTaskInfo.kernel->GetMixType() : 0U;
        runtimeTrack.extInfo.kernelInfo.numBlocks = aicTaskInfo.comm.dim;
        runtimeTrack.extInfo.kernelInfo.argsSize = argsSizeU16;
        uint8_t ratio = 0U;
        if ((mixType == MIX_AIC_AIV_MAIN_AIC) || (mixType == MIX_AIC_AIV_MAIN_AIV)) {
            const uint32_t taskRation = aicTaskInfo.kernel->GetTaskRation();
            ratio = static_cast<uint8_t>(taskRation & 0x7U);
        }
        runtimeTrack.extInfo.kernelInfo.schedMode = aicTaskInfo.schemMode;
        runtimeTrack.extInfo.kernelInfo.rsv = 0U;
        runtimeTrack.extInfo.kernelInfo.ratio = ratio;
        (void)memset_s(
            runtimeTrack.extInfo.kernelInfo.reserved, sizeof(runtimeTrack.extInfo.kernelInfo.reserved), 0,
            sizeof(runtimeTrack.extInfo.kernelInfo.reserved));
        RT_LOG(
            RT_LOG_DEBUG,
            "Fill ext info, numBlocks=%u, argsSize=%hu, "
            "original argsSize=%u, ratio=%u, schedMode=%u",
            runtimeTrack.extInfo.kernelInfo.numBlocks, argsSizeU16, argsSize, ratio,
            runtimeTrack.extInfo.kernelInfo.schedMode);
    }
}

void Profiler::ModifyTrackData(TaskInfo* const taskInfo, const uint32_t devId, RuntimeProfTrackData* trackData) const
{
    const Stream* const stm = taskInfo->stream;
    trackData->isModel = (stm == nullptr) ? false : stm->GetBindFlag(); // is it a model task
    trackData->compactInfo.level = MSPROF_REPORT_RUNTIME_LEVEL;
    trackData->compactInfo.type = RT_PROFILE_TYPE_TASK_TRACK;           // RT_PROFILE_TYPE_TASK_TRACK regitered in init

    ProfApiContext* profApiContext = GetTopProfApiContext();
    if ((profApiContext != nullptr) && profApiContext->needReport && (profApiContext->apiData.entryTime != 0U)) {
        trackData->compactInfo.timeStamp =
            profApiContext->apiData.entryTime + 1ULL; // trackData的时间戳只要在api的begin和end的范围之内就是合理的
    } else {
        trackData->compactInfo.timeStamp = MsprofSysCycleTime();
    }

    trackData->compactInfo.threadId = GetCurrentTid();
    trackData->compactInfo.dataLen = static_cast<uint32_t>(sizeof(MsprofRuntimeTrack));
    trackData->compactInfo.data.runtimeTrack.deviceId = static_cast<uint16_t>(devId);
    trackData->compactInfo.data.runtimeTrack.streamId =
        (stm == nullptr) ? RT_MAX_STREAM_ID : static_cast<uint16_t>(stm->GetExposedStreamId());

    if (taskInfo->type == TS_TASK_TYPE_FLIP) {
        trackData->compactInfo.data.runtimeTrack.taskId =
            GetFlipTaskId(taskInfo->id, taskInfo->u.flipTask.flipNumReport);
    } else {
        trackData->compactInfo.data.runtimeTrack.taskId = GetProfTaskId(taskInfo);
    }
    uint32_t taskType = taskInfo->type;
    // model exec 的notify wait,给prof上报的type做适配修改
    if (taskInfo->type == TS_TASK_TYPE_NOTIFY_WAIT &&
        (taskInfo->u.notifywaitTask.isEndGraphNotify && taskInfo->u.notifywaitTask.captureModel != nullptr)) {
        taskType = static_cast<uint32_t>(ProfTaskType::PROF_TASK_TYPE_MODEL_WAIT_COMPLETE);
        trackData->compactInfo.data.runtimeTrack.extInfo.modelInfo.modelId =
            taskInfo->u.notifywaitTask.captureModel->Id_();
    }
    if (taskType == TS_TASK_TYPE_MODEL_EXECUTE) {
        trackData->compactInfo.data.runtimeTrack.extInfo.modelInfo.modelId = taskInfo->u.modelExecuteTaskInfo.modelId;
    }

    trackData->compactInfo.data.runtimeTrack.taskType = taskType;
    FillKernelLaunchExtInfo(trackData->compactInfo.data.runtimeTrack, taskInfo);
    trackData->compactInfo.data.runtimeTrack.kernelName = GetKernelNameId(*taskInfo);

    // for mutil enable profiling
    taskInfo->taskTrackTimeStamp = trackData->compactInfo.timeStamp;

    RT_LOG(
        RT_LOG_INFO, "ReportTaskTrack, runtimeTrack->taskId=%u, taskInfo->id=%u, taskInfo->flipNum=%u",
        trackData->compactInfo.data.runtimeTrack.taskId, taskInfo->id, taskInfo->flipNum);
}

static int32_t ReportCompactInfo(RuntimeProfTrackData* const trackData)
{
    RT_LOG(
        RT_LOG_DEBUG,
        "Report compact info, isModel=%u, threadId=%u, timeStamp=%llu, devId=%hu, "
        "streamId=%hu, taskId=%u ,taskType=%llu, kernelName=%llu",
        trackData->isModel, trackData->compactInfo.threadId, trackData->compactInfo.timeStamp,
        trackData->compactInfo.data.runtimeTrack.deviceId, trackData->compactInfo.data.runtimeTrack.streamId,
        trackData->compactInfo.data.runtimeTrack.taskId, trackData->compactInfo.data.runtimeTrack.taskType,
        trackData->compactInfo.data.runtimeTrack.kernelName);
    const bool agingFlag = (trackData->isModel != 0) ? false : true;
    return MsprofReportCompactInfo(
        static_cast<uint32_t>(agingFlag), &trackData->compactInfo, static_cast<uint32_t>(sizeof(MsprofCompactInfo)));
}

void Profiler::ReportTaskTrack(TaskInfo* const taskInfo, const uint32_t devId) const
{
    // cache model task and model stream, report when taskTrack switch is turned on
    // When the stream is destroyed, clear the cached model stream object
    if ((taskInfo->stream != nullptr) && (taskInfo->stream->GetBindFlag())) {
        taskInfo->taskTrackTimeStamp = MsprofSysCycleTime();
        // cache model task's stream, report when taskTrack switch is turned on
        RT_LOG(
            RT_LOG_DEBUG, "Cache task profiling info, stream_id=%d, task_id=%u.", taskInfo->stream->Id_(),
            taskInfo->id);

        const Model* m = taskInfo->stream->Model_();
        if ((m != nullptr) && (m->GetModelType() == RT_MODEL_CAPTURE_MODEL)) {
            taskInfo->stream->CacheCaptureTaskId(taskInfo->id);
            return;
        } else {
            taskInfo->stream->CacheBindTrackTaskId(taskInfo->id);
        }
    }

    if (!GetTrackProfEnable()) {
        return;
    }

    TaskTrackInfo& trackMngInfo = GetProfTaskTrackData();
    uint32_t taskNum = trackMngInfo.taskNum;

    if (taskNum == RUNTIME_TASK_TRACK_BUFF_NUM) {
        RuntimeProfTrackData* trackData;
        for (uint32_t i = 0U; i < RUNTIME_TASK_TRACK_BUFF_NUM; i++) {
            trackData = &trackMngInfo.trackBuff[i];
            const int32_t ret = ReportCompactInfo(trackData);
            if (ret != MSPROF_ERROR_NONE) {
                RT_LOG_CALL_MSG(ERR_MODULE_PROFILE, "Failed to report profiling task track data, retCode=%d.", ret);
                return;
            }
        }

        trackMngInfo.taskNum = 0U;
        taskNum = 0U;
    }

    RuntimeProfTrackData* trackData = &(trackMngInfo.trackBuff[taskNum]);
    ModifyTrackData(taskInfo, devId, trackData);
    trackMngInfo.taskNum++;

    ProfApiContext* profApiContext = GetTopProfApiContext();
    if ((profApiContext == nullptr) ||
        !profApiContext->needReport) { // if not open api profiling, will send taskTrack separately
        const int32_t ret = ReportCompactInfo(trackData);
        if (ret != MSPROF_ERROR_NONE) {
            RT_LOG_CALL_MSG(ERR_MODULE_PROFILE, "Failed to report profiling task track data, retCode=%d.", ret);
            return;
        }
        trackMngInfo.taskNum = 0U;
        return;
    }
}

void Profiler::ReportDestroyFlipTask(const Stream* const stm, const uint32_t devId) const
{
    MsprofCompactInfo compactInfo{};
    compactInfo.level = MSPROF_REPORT_RUNTIME_LEVEL;
    compactInfo.type = RT_PROFILE_TYPE_TASK_TRACK; // RT_PROFILE_TYPE_TASK_TRACK regitered in init
    compactInfo.timeStamp = MsprofSysCycleTime();
    compactInfo.threadId = GetCurrentTid();
    compactInfo.dataLen = static_cast<uint32_t>(sizeof(MsprofRuntimeTrack));
    compactInfo.data.runtimeTrack.deviceId = static_cast<uint16_t>(devId);
    compactInfo.data.runtimeTrack.streamId =
        (stm == nullptr) ? RT_MAX_STREAM_ID : static_cast<uint16_t>(stm->GetExposedStreamId());
    compactInfo.data.runtimeTrack.taskId = 0xFFFFFFFFU;
    compactInfo.data.runtimeTrack.taskType = TS_TASK_TYPE_FLIP;

    RT_LOG(
        RT_LOG_INFO, "threadId=%u, timeStamp=%llu, devId=%u, stream_id=%u", compactInfo.threadId, compactInfo.timeStamp,
        compactInfo.data.runtimeTrack.deviceId, compactInfo.data.runtimeTrack.streamId);

    const int32_t ret = MsprofReportCompactInfo(true, &compactInfo, static_cast<uint32_t>(sizeof(MsprofCompactInfo)));
    if (ret != MSPROF_ERROR_NONE) {
        RT_LOG_CALL_MSG(ERR_MODULE_PROFILE, "Failed to report profiling task track data, retCode=%d.", ret);
        return;
    }
    MsprofCompactInfo compactInfoV2{};
    compactInfoV2.level = compactInfo.level;
    compactInfoV2.type = RT_PROFILE_TYPE_TASK_TRACK_V2;
    compactInfoV2.timeStamp = compactInfo.timeStamp;
    compactInfoV2.threadId = compactInfo.threadId;
    compactInfoV2.dataLen = static_cast<uint32_t>(sizeof(MsprofRuntimeTrackV2));
    compactInfoV2.data.runtimeTrackV2.deviceId = compactInfo.data.runtimeTrack.deviceId;
    compactInfoV2.data.runtimeTrackV2.streamId =
        (stm == nullptr) ? RT_MAX_STREAM_ID : static_cast<uint32_t>(stm->GetExposedStreamId());
    compactInfoV2.data.runtimeTrackV2.taskId = 0xFFFFFFFFU;
    compactInfoV2.data.runtimeTrackV2.taskType = TS_TASK_TYPE_FLIP;

    const int32_t retV2 =
        MsprofReportCompactInfo(true, &compactInfoV2, static_cast<uint32_t>(sizeof(MsprofCompactInfo)));
    if (retV2 != MSPROF_ERROR_NONE) {
        RT_LOG_CALL_MSG(ERR_MODULE_PROFILE, "Failed to report profiling task track v2 data, retCode=%d.", retV2);
    }
    return;
}

void Profiler::InsertStream(Stream* const stm)
{
    if (likely(stm != nullptr)) {
        RT_LOG(RT_LOG_INFO, "streamId=%d", stm->Id_());
        streamSetMutex_.lock();
        (void)streamSet_.insert(stm);
        streamSetMutex_.unlock();
    }
}

// When the stream is destroyed, erase the cached model stream object
void Profiler::EraseStream(Stream* const stm)
{
    RT_LOG(RT_LOG_INFO, "erase streamId=%u.", stm->Id_());
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

    RT_LOG(
        RT_LOG_INFO, "Send: RecordType=%hu pid=%u taskId=%u streamId=%u time=%" PRIu64 "ns", recordAsyncSend.type,
        recordAsyncSend.pid, recordAsyncSend.taskId, recordAsyncSend.streamId, recordAsyncSend.sendStamp);
}

void Profiler::ReportRecv(const TaskInfo* const taskInfo) const
{
    if (!apiProfLogEnable_) {
        return;
    }

    const Stream* const stm = taskInfo->stream;

    rtProfileRecordAsyncRecv_t recordAsyncRecv;
    recordAsyncRecv.type = PROFILE_RECORD_TYPE_RT_ASYNC_RECV;
    recordAsyncRecv.pid = processId_;
    recordAsyncRecv.taskId = taskInfo->id;
    recordAsyncRecv.streamId = static_cast<uint32_t>(stm->Id_());
    recordAsyncRecv.recvStamp = GetTickCount();

    RT_LOG(
        RT_LOG_DEBUG, "Recv: RecordType=%hu pid=%u taskId=%u streamId=%u time=%" PRIu64 "ns", recordAsyncRecv.type,
        recordAsyncRecv.pid, recordAsyncRecv.taskId, recordAsyncRecv.streamId, recordAsyncRecv.recvStamp);
}

void Profiler::ReportReceivingRun(const TaskInfo* const taskInfo, const uint32_t devId) const
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

void Profiler::ReportTrackData(const Stream* const s, const uint16_t taskId) const
{
    if ((s == nullptr) || (s->Device_() == nullptr)) {
        RT_LOG(RT_LOG_WARNING, "This task stream is invalid");
        return;
    }

    const int32_t steamId = s->Id_();
    const uint32_t devId = s->Device_()->Id_();
    TaskInfo* task = GetTaskInfo(s->Device_(), static_cast<uint32_t>(steamId), static_cast<uint32_t>(taskId));
    if (task == nullptr) {
        RT_LOG(
            RT_LOG_WARNING, "Get task info is null, deviceId=%u, streamId=%d, master streamId=%d, taskId=%u", devId,
            steamId, s->GetExposedStreamId(), taskId);
        return;
    }

    RT_LOG(
        RT_LOG_INFO, "Report track data, device_id=%u, stream_id=%d, master stream_id=%d, task_id=%u, task_sn=%u",
        devId, steamId, s->GetExposedStreamId(), taskId, task->taskSn);
    RuntimeProfTrackData trackData{};
    trackData.isModel = true;
    trackData.compactInfo.level = MSPROF_REPORT_RUNTIME_LEVEL;
    trackData.compactInfo.type = RT_PROFILE_TYPE_TASK_TRACK; // RT_PROFILE_TYPE_TASK_TRACK register in init
    trackData.compactInfo.timeStamp = task->taskTrackTimeStamp;
    trackData.compactInfo.threadId = task->tid;
    trackData.compactInfo.dataLen = static_cast<uint32_t>(sizeof(MsprofRuntimeTrack));

    trackData.compactInfo.data.runtimeTrack.deviceId = static_cast<uint16_t>(devId);
    trackData.compactInfo.data.runtimeTrack.streamId = static_cast<uint32_t>(s->GetExposedStreamId());
    trackData.compactInfo.data.runtimeTrack.taskId = GetProfTaskId(task);
    trackData.compactInfo.data.runtimeTrack.taskType = task->type;
    FillKernelLaunchExtInfo(trackData.compactInfo.data.runtimeTrack, task);
    trackData.compactInfo.data.runtimeTrack.kernelName = GetKernelNameId(*task);
    (void)ReportCompactInfo(&trackData);
    ReportTrackDataV2(s, task, devId, trackData);
    return;
}

void Profiler::ReportTrackDataV2(
    const Stream* const stm, const TaskInfo* const task, const uint32_t devId,
    const RuntimeProfTrackData& v1TrackData) const
{
    const Model* model = stm->Model_();
    if ((model == nullptr) || (model->GetModelType() != RT_MODEL_CAPTURE_MODEL)) {
        return;
    }

    RuntimeProfTrackData trackData{};
    trackData.isModel = true;
    trackData.compactInfo.level = MSPROF_REPORT_RUNTIME_LEVEL;
    trackData.compactInfo.type = RT_PROFILE_TYPE_TASK_TRACK_V2;
    trackData.compactInfo.timeStamp = task->taskTrackTimeStamp;
    trackData.compactInfo.threadId = task->tid;
    trackData.compactInfo.dataLen = static_cast<uint32_t>(sizeof(MsprofRuntimeTrackV2));

    MsprofRuntimeTrackV2& track = trackData.compactInfo.data.runtimeTrackV2;
    track.deviceId = static_cast<uint16_t>(devId);
    track.streamId = static_cast<uint32_t>(stm->GetExposedStreamId());
    track.taskId = v1TrackData.compactInfo.data.runtimeTrack.taskId;
    track.taskType = static_cast<uint32_t>(v1TrackData.compactInfo.data.runtimeTrack.taskType);
    track.kernelName = v1TrackData.compactInfo.data.runtimeTrack.kernelName;
    const errno_t rc = memcpy_s(
        &track.extInfo, sizeof(track.extInfo), &v1TrackData.compactInfo.data.runtimeTrack.extInfo,
        sizeof(v1TrackData.compactInfo.data.runtimeTrack.extInfo));
    if (rc != EOK) {
        RT_LOG(RT_LOG_ERROR, "memcpy_s failed for extInfo copy, rc=%d.", static_cast<int32_t>(rc));
        return;
    }

    (void)ReportCompactInfo(&trackData);
}

// report cache task track and clear streamSet_
rtError_t Profiler::ReportCacheTrack(uint32_t cacheFlag)
{
    streamSetMutex_.lock();
    if (streamSet_.empty()) {
        RT_LOG(RT_LOG_INFO, "the cache is empty");
        streamSetMutex_.unlock();
        return RT_ERROR_NONE;
    }

    RT_LOG(RT_LOG_INFO, "begin report cache track, stream set size=%zu", streamSet_.size());
    for (Stream* const it : streamSet_) {
        // Repetitive enable profiling
        const std::list<uint16_t>& cacheTrackTaskIdList = it->GetCacheTrackTaskList();
        for (const uint16_t taskId : cacheTrackTaskIdList) {
            ReportTrackData(it, taskId);
        }
        if ((it != nullptr) && (cacheFlag == 1)) {
            it->ClearCacheTrackTaskList();
        }
    }
    streamSetMutex_.unlock();

    RT_LOG(RT_LOG_INFO, "end report cache track");
    return RT_ERROR_NONE;
}

void Profiler::RuntimeProfilerStop(void) const
{
    RT_LOG(RT_LOG_INFO, "ProfilerStop");
    const Runtime* const rtInstance = Runtime::Instance();
    Context* curCtx = rtInstance->CurrentContext();
    if (curCtx != nullptr) {
        (void)curCtx->ForEachModel(
            [](Model* mdl) -> rtError_t {
                if (mdl->GetModelType() == RT_MODEL_CAPTURE_MODEL) {
                    CaptureModel* captureMdl = dynamic_cast<CaptureModel*>(mdl);
                    captureMdl->ResetTrackDataReportFlag();
                }
                return RT_ERROR_NONE;
            },
            false);
    }

    const auto ret = ProfilingAgent::Instance().UnInit();
    COND_RETURN_VOID(ret != RT_ERROR_NONE, "runtime UnInit profiling failed, retCode=%#x.", ret);
}

void Profiler::TsProfilerStart(const uint64_t profConfig, const uint32_t devId, Device* const dev)
{
    RT_LOG(RT_LOG_DEBUG, "profConfig=%#" PRIx64 ", devId=%u.", profConfig, devId);
    profCfg_.isRtsProfEn = ((profConfig & PROF_SCHEDULE_TIMELINE_MASK) == 0U) ? 0U : 1U;
    if ((Runtime::Instance()->GetTsNum() == TS_NUM_ADC) && (dev->DevGetTsId() == 1U)) { // mdc and ts1
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
        TaskInfo* tsk = dev->GetCtrlStream(dev->PrimaryStream_())
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
    const uint64_t profConfig, const uint32_t devId, Device* const dev, const bool needOpenTimeline)
{
    RT_LOG(
        RT_LOG_DEBUG, "profConfig=%#" PRIx64 ", devId=%u, needOpenTimeline=%d.", profConfig, devId, needOpenTimeline);
    profCfg_.isRtsProfEn = (needOpenTimeline) ? 1U : 0U;
    if ((Runtime::Instance()->GetTsNum() == TS_NUM_ADC) && (dev->DevGetTsId() == 1U)) { // mdc and ts1
        profCfg_.isTaskBasedProfEn = ((profConfig & PROF_AIVECTORCORE_METRICS_MASK) == 0U) ? 0U : 1U;
    } else {
        profCfg_.isTaskBasedProfEn = ((profConfig & PROF_AICORE_METRICS_MASK) == 0U) ? 0U : 1U;
    }
    profCfg_.isProfLogEn = ((profConfig & static_cast<uint64_t>(PROF_RUNTIME_PROFILE_LOG_MASK)) == 0U) ? 0U : 1U;

    if ((profCfg_.isRtsProfEn != 0U) || (profCfg_.isTaskBasedProfEn != 0U) || (profCfg_.isProfLogEn != 0U)) {
        TaskInfo submitTask = {};
        rtError_t errorReason;
        TaskInfo* const tsk = dev->GetCtrlStream(dev->PrimaryStream_())
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

void Profiler::TsProfilerStop(const uint64_t profConfig, const uint32_t devId, Device* const dev)
{
    RT_LOG(RT_LOG_DEBUG, "profConfig=%#" PRIx64 ", devId=%u.", profConfig, devId);
    profCfg_.isRtsProfEn = ((profConfig & PROF_SCHEDULE_TIMELINE_MASK) == 0U) ? 0U : 1U;
    if ((Runtime::Instance()->GetTsNum() == TS_NUM_ADC) && (dev->DevGetTsId() == 1U)) { // mdc and ts1
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
        TaskInfo* tsk = dev->GetCtrlSQStream(dev->PrimaryStream_())
                            ->AllocTask(&submitTask, TS_TASK_TYPE_PROFILING_DISABLE, errorReason);
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
    const uint64_t profConfig, const uint32_t devId, Device* const dev, const bool needCloseTimeline)
{
    RT_LOG(
        RT_LOG_DEBUG, "profConfig=%#" PRIx64 ", devId=%u, needCloseTimeline=%d.", profConfig, devId, needCloseTimeline);

    profCfg_.isRtsProfEn = (needCloseTimeline) ? 1U : 0U;
    if ((Runtime::Instance()->GetTsNum() == TS_NUM_ADC) && (dev->DevGetTsId() == 1U)) { // mdc and ts1
        profCfg_.isTaskBasedProfEn = ((profConfig & PROF_AIVECTORCORE_METRICS_MASK) == 0U) ? 0U : 1U;
    } else {
        profCfg_.isTaskBasedProfEn = ((profConfig & PROF_AICORE_METRICS_MASK) == 0U) ? 0U : 1U;
    }
    profCfg_.isProfLogEn = ((profConfig & static_cast<uint64_t>(PROF_RUNTIME_PROFILE_LOG_MASK)) == 0U) ? 0U : 1U;

    if ((profCfg_.isRtsProfEn != 0U) || (profCfg_.isTaskBasedProfEn != 0U) || (profCfg_.isProfLogEn != 0U)) {
        TaskInfo submitTask = {};
        rtError_t errorReason;
        TaskInfo* tsk = dev->GetCtrlSQStream(dev->PrimaryStream_())
                            ->AllocTask(&submitTask, TS_TASK_TYPE_PROFILING_DISABLE, errorReason);
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

void ReportStreamSqInfoForProfiling(const Stream* stream, uint16_t streamStatus)
{
    Profiler* const profilerPtr = Runtime::Instance()->Profiler_();
    if ((profilerPtr == nullptr) || (!profilerPtr->GetTrackProfEnable()) || (stream == nullptr)) {
        return;
    }

    MsprofCompactInfo compactInfo;
    compactInfo.level = MSPROF_REPORT_RUNTIME_LEVEL;
    compactInfo.type = RT_PROFILE_TYPE_STREAM_SQ_INFO;
    compactInfo.timeStamp = MsprofSysCycleTime();
    compactInfo.threadId = GetCurrentTid();
    compactInfo.dataLen = static_cast<uint32_t>(sizeof(MsprofStreamSqInfo));
    compactInfo.data.streamSqInfo.streamStatus = streamStatus;
    compactInfo.data.streamSqInfo.streamId = static_cast<uint16_t>(stream->Id_());
    compactInfo.data.streamSqInfo.rtsqId = static_cast<uint16_t>(stream->GetSqId());
    compactInfo.data.streamSqInfo.deviceId = static_cast<uint16_t>(stream->Device_()->Id_());
    compactInfo.data.streamSqInfo.tsId = static_cast<uint16_t>(stream->Device_()->DevGetTsId());

    const auto error = MsprofReportCompactInfo(0, &compactInfo, static_cast<uint32_t>(sizeof(MsprofCompactInfo)));
    if (error != MSPROF_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Report stream sq info for profiling failed, ret=%d.", error);
        return;
    }

    RT_LOG(
        RT_LOG_DEBUG,
        "Report stream sq info for profiling successfully, streamStatus=%hu, streamId=%hu, "
        "rtsqId=%hu, deviceId=%hu, tsId=%hu.",
        compactInfo.data.streamSqInfo.streamStatus, compactInfo.data.streamSqInfo.streamId,
        compactInfo.data.streamSqInfo.rtsqId, compactInfo.data.streamSqInfo.deviceId,
        compactInfo.data.streamSqInfo.tsId);
}

void Profiler::CallApiBegin(const uint16_t profileType, const uint64_t dataSize, const uint16_t cpyDirection) const
{
    ProfApiContext* profApiContext = nullptr;
    if (!GetApiProfEnable()) {
        // profiling 关闭时，栈空场景可直接返回；
        if (GetTopProfApiContext() == nullptr) {
            return;
        }

        // 若当前线程仍有外层活跃 frame，则必须压入 needReport=false 的占位 frame，
        // 保证嵌套场景下 CallApiBegin/CallApiEnd 继续严格配对，避免内层 End 提前弹出外层profiling数据。
        profApiContext = PushProfApiContext();
        if (profApiContext == nullptr) {
            RT_LOG(RT_LOG_ERROR, "push api profiling context failed.");
            return;
        }
        return;
    }

    profApiContext = PushProfApiContext();
    if (profApiContext == nullptr) {
        RT_LOG(RT_LOG_ERROR, "push api profiling context failed.");
        return;
    }
    profApiContext->needReport = true;

    RuntimeProfApiData& profApiData = profApiContext->apiData;
    profApiData.magicNumber = static_cast<uint16_t>(MSPROF_DATA_HEAD_MAGIC_NUM);
    profApiData.dataTag = static_cast<uint16_t>(MSPROF_RUNTIME_DATA_TAG_API);
    profApiData.threadId = PidTidFetcher::GetCurrentTid();
    profApiData.dataSize = dataSize;
    profApiData.memcpyDirection = cpyDirection;
    profApiData.maxSize = CalculateMemcpyAsyncSingleMaxSize(static_cast<rtMemcpyKind_t>(cpyDirection));
    profApiData.streamId = static_cast<uint32_t>(UINT16_MAX);
    profApiData.taskNum = 0U;
    profApiData.profileType = profileType;
    profApiData.extInfoCount = 0U;

    RT_LOG(RT_LOG_DEBUG, "profileType=%hu", profApiData.profileType);
    profApiData.entryTime = MsprofSysCycleTime();
}

void Profiler::CallApiEnd(const rtError_t retCode, const uint32_t devId) const
{
    ProfApiContext profApiContext{};
    if (!PopProfApiContext(profApiContext)) {
        if (!GetApiProfEnable()) {
            return;
        }
        RT_LOG(RT_LOG_ERROR, "api profiling stack is empty when CallApiEnd.");
        return;
    }

    if (!profApiContext.needReport || !GetApiProfEnable()) {
        return;
    }

    const uint64_t endTime = MsprofSysCycleTime();
    uint32_t deviceId = devId;
    TaskTrackInfo& trackMngInfo = profApiContext.taskTrackInfo;
    const uint32_t taskNum = trackMngInfo.taskNum;

    if (deviceId == static_cast<uint32_t>(UINT16_MAX)) {
        Context* curCtx = nullptr;
        const rtError_t error = api_->ContextGetCurrent(&curCtx);
        if ((error == RT_ERROR_NONE) && (ContextManage::CheckContextIsValid(curCtx))) {
            deviceId = curCtx->Device_()->Id_();
        }
    }

    // report task track info
    for (uint32_t i = 0U; i < taskNum; i++) {
        RuntimeProfTrackData* data = &trackMngInfo.trackBuff[i];
        RT_LOG(
            RT_LOG_DEBUG,
            "isModel=%u, threadId=%u, timeStamp=%llu, devId=%u, stream_id=%u, task_id=%u, "
            "task_type=%u, kernel_name=%llu",
            data->isModel, data->compactInfo.threadId, data->compactInfo.timeStamp,
            data->compactInfo.data.runtimeTrack.deviceId, data->compactInfo.data.runtimeTrack.streamId,
            data->compactInfo.data.runtimeTrack.taskId, data->compactInfo.data.runtimeTrack.taskType,
            data->compactInfo.data.runtimeTrack.kernelName);
        const bool agingFlag = (data->isModel != 0) ? false : true;
        const int32_t ret = MsprofReportCompactInfo(
            static_cast<uint32_t>(agingFlag), &(data->compactInfo), static_cast<uint32_t>(sizeof(MsprofCompactInfo)));
        if (ret != MSPROF_ERROR_NONE) {
            RT_LOG_CALL_MSG(ERR_MODULE_PROFILE, "Failed to report profiling task track data, retCode=%d.", ret);
            return;
        }
    }
    trackMngInfo.taskNum = 0U;

    // report runtime api info
    RuntimeProfApiData& profApiData = profApiContext.apiData;
    profApiData.retCode = static_cast<uint32_t>(RT_TRANS_EXT_ERRCODE(retCode));
    profApiData.exitTime = endTime;
    ReportProfApi(deviceId, profApiData);
    RT_LOG(RT_LOG_DEBUG, "profileType=%hu, devId=%u, retCode=%u", profApiData.profileType, deviceId, retCode);
}

} // namespace runtime
} // namespace cce
