/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_STREAM_CAPTURE_HPP
#define CCE_RUNTIME_STREAM_CAPTURE_HPP

#include <cstdint>
#include <list>
#include <memory>
#include <mutex>
#include "runtime/base.h"
#include "runtime/rt_inner_model.h"
#include "stream_extension.hpp"
#include "task_base.hpp"

namespace cce {
namespace runtime {

class Stream;
struct tagTaskInfoStru;
typedef tagTaskInfoStru TaskInfo;
struct TaskGroup;
class StreamCapture final : public StreamExtension {
public:
    StreamCapture();
    ~StreamCapture() override;

    static StreamCapture* Create(const Stream* stm);
    static StreamCapture* GetOrCreate(const Stream* stm);
    static StreamCapture* Get(const Stream* stm);

    static rtError_t AllocTask(Stream* stm, tsTaskType_t taskType, uint32_t sqeNum, TaskInfo** task);
    static void EnterCapture(Stream* stm, const Stream* captureStream);
    static void ExitCapture(Stream* stm);

    void CacheTaskId(uint16_t taskId);
    const std::list<uint16_t>& GetCachedTaskIds() const;
    uint32_t GetCacheOpInfoSwitch() const;
    void SetCacheOpInfoSwitch(uint32_t status);
    uint32_t GetCacheOpInfoOriginSwitch() const;
    void SetCacheOpInfoOriginSwitch(uint32_t status);
    void MarkOrigCaptureStream(bool flag);
    bool IsOrigCaptureStream() const;
    void CancelLastLevelCaptureStream();
    bool IsLastLevelCaptureStream() const;
    void SetParentCaptureStream(Stream* parent);
    Stream* GetChildCaptureStream() const;
    void SetChildCaptureStream(Stream* child);
    rtStreamCaptureMode GetCaptureMode() const;
    void SetCaptureMode(rtStreamCaptureMode mode);
    void ResetTaskGroup();
    void UpdateCurrentTaskGroup(std::unique_ptr<TaskGroup>& taskGroup);
    std::unique_ptr<TaskGroup>& GetCurrentTaskGroup();
    TaskGroup* GetUpdateTaskGroup();
    void SetUpdateTaskGroup(TaskGroup* taskGroup);
    void UpdateTaskIndex(uint32_t index);
    void ResetUpdateTaskGroup();
    std::mutex& GetTaskGroupMutex();
    bool IsSubCaptureModel() const;
    void SetSubCaptureModel();
    void SetBeginCaptureThreadId(uint32_t threadId);
    uint32_t GetBeginCaptureThreadId() const;
    rtError_t PackingTaskGroup(const TaskInfo* task, uint16_t streamId);

private:
    static bool IsTaskGroupBreak(const Stream* stm, Stream* captureStream);
    static void Terminate(Stream* stm);
    static rtError_t AllocCascadeStream(Stream* stm, Stream*& newCaptureStream, const Stream* curCaptureStream);
    static void UpdateCascadeStreamInfo(Stream* stm, Stream* newCaptureStream, Stream* curCaptureStream);

    std::list<uint16_t> cacheCaptureTaskIds_;
    uint32_t cacheOpInfoOriginSwitch_{0U};
    uint32_t cacheOpInfoSwitch_{0U};
    bool isOrigCaptureStream_{false};
    bool isLastLevelCaptureStream_{true};
    Stream* parentCaptureStream_{nullptr};
    Stream* childCaptureStream_{nullptr};
    rtStreamCaptureMode captureMode_{RT_STREAM_CAPTURE_MODE_MAX};
    std::unique_ptr<TaskGroup> taskGroup_{nullptr};
    std::mutex taskGroupMutex_;
    TaskGroup* updateTaskGroup_{nullptr};
    bool isSubCaptureModel_{false};
    uint32_t beginCaptureThreadId_{UINT32_MAX};
};

void CacheCaptureTaskId(Stream* stm, uint16_t taskId);
uint32_t GetStreamCacheOpInfoSwitch(const Stream* stm);
void SetStreamCacheOpInfoOriginSwitch(const Stream* stm, uint32_t status);
bool IsOriginalCaptureStream(const Stream* stm);
void ResetStreamTaskGroup(Stream* stm);
rtError_t UpdateStreamTask(Stream* stm, TaskInfo** task);
rtError_t PackStreamTaskGroup(Stream* stm, const TaskInfo* task, uint16_t streamId);

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_STREAM_CAPTURE_HPP
