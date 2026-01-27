/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_PROFILER_HPP
#define CCE_RUNTIME_PROFILER_HPP

#include <string>
#include <mutex>
#include <unordered_set>
#include "engine.hpp"
#include "profiler_struct.hpp"
#include "task.hpp"

#ifndef PROF_RUNTIME_PROFILE_LOG_MASK
#define PROF_RUNTIME_PROFILE_LOG_MASK    0x00002000ULL
#endif

namespace cce {
namespace runtime {
class Profiler;
class DvppGrp;
class Api;
class ApiProfileDecorator;
class ApiProfileLogDecorator;

class Profiler : public NoCopy {
public:
    explicit Profiler(Api * const apiObj);
    ~Profiler() override;

    rtError_t Init();

    bool IsEnabled(const uint32_t devId) const;

    const ApiProfileDecorator *GetApiProfileDecorator() const
    {
        return apiProfileDecorator_;
    }

    const ApiProfileLogDecorator *GetApiProfileLogDecorator_() const
    {
        return apiProfileLogDecorator_;
    }

    rtProfCfg_t *ProfCfgPtr()
    {
        return &profCfg_;
    }
    
    RuntimeProfApiData &GetProfApiData() const;
    void SetProfApiData(const RuntimeProfApiData profiler) const;
    TaskTrackInfo& GetProfTaskTrackData(void) const;
    void ReportProfApi(const uint32_t devId, RuntimeProfApiData &profApiData) const;
    void ReportTaskTrack(TaskInfo * const taskInfo, const uint32_t devId) const;
    void ModifyTrackData(RuntimeProfTrackData *trackData) const;
    void ReportDestroyFlipTask(const Stream * const stm, const uint32_t devId) const;
    void ReportStreamSynctaskFinish(const uint16_t profileType) const;

    void ReportReceivingRun(const TaskInfo * const taskInfo, const uint32_t devId) const;
    void ReportSend(const uint16_t taskId, const uint16_t stmId) const;
    void ReportRecv(const TaskInfo * const taskInfo) const;

    void RuntimeProfilerStart(void) const;
    void RuntimeProfilerStop(void) const;
    void TsProfilerStart(const uint64_t profConfig, const uint32_t devId, Device * const dev);
    void TsProfilerStop(const uint64_t profConfig, const uint32_t devId, Device * const dev);
    void TsProfilerStart(const uint64_t profConfig, const uint32_t devId, Device * const dev,
        const bool needOpenTimeline);
    void TsProfilerStop(const uint64_t profConfig, const uint32_t devId, Device * const dev,
        const bool needCloseTimeline);
    void TrackDataInit(void) const;
    void SetTrackProfEnable(bool trackProfEnable, uint32_t cacheFlag = 0)
    {
        if (trackProfEnable) {
            TrackDataInit();
        }
        trackProfEnable_ = trackProfEnable;
        if (trackProfEnable) {
            (void)ReportCacheTrack(cacheFlag);
            (void)ReportCacheShapeInfo();
        }
    }

    bool GetTrackProfEnable() const
    {
        return  trackProfEnable_;
    }

    void SetApiProfEnable(bool apiProfEnable)
    {
        apiProfEnable_ = apiProfEnable;
    }

    bool GetApiProfEnable() const
    {
        return apiProfEnable_;
    }

    void SetProfLogEnable(bool apiProfLogEnable)
    {
        apiProfLogEnable_ = apiProfLogEnable;
    }

    bool GetProfLogEnable() const
    {
        return apiProfLogEnable_;
    }

    uint32_t GetProcessId() const
    {
        return processId_;
    }

    static uint32_t GetThreadId()
    {
        if (threadId_ == 0UL) {
            threadId_ = PidTidFetcher::GetCurrentUserTid();
        }
        return threadId_;
    }

    static uint32_t GetSeq()
    {
        return seq_;
    }

    static void SeqAdd()
    {
        seq_++;
    }

    void InsertStream(Stream * const stm);
    void EraseStream(Stream * const stm);
    rtError_t ReportCacheTrack(uint32_t cacheFlag);
    rtError_t ReportCacheShapeInfo() const;

private:
    Api *api_;
    ApiProfileDecorator *apiProfileDecorator_;
    ApiProfileLogDecorator *apiProfileLogDecorator_;
    rtProfCfg_t profCfg_;

    bool trackProfEnable_;
    bool apiProfEnable_;
    bool apiProfLogEnable_;

    uint32_t processId_;
    static __THREAD_LOCAL__ uint32_t threadId_;
    static __THREAD_LOCAL__ uint32_t seq_;
    std::mutex streamSetMutex_;
    std::unordered_set<Stream *> streamSet_;
};
}  // namespace runtime
}  // namespace cce

#endif  // CCE_RUNTIME_PROFILER_HPP
