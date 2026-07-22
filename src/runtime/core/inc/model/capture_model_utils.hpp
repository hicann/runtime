/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CAPTURE_MODEL_UTILS_HPP
#define CAPTURE_MODEL_UTILS_HPP

#include "model.hpp"
#include "event.hpp"
#include "stream.hpp"
#include "notify.hpp"
#include <cstddef>
#include <cstdint>
#include <vector>

namespace cce {
namespace runtime {
struct EventResource;
struct ExternalEventRefreshLayout;
struct ExternalEventRefreshInfo;
using ExternalPlaceholderSubmitter = rtError_t (*)(Device* dev, TaskInfo* task);

bool IsEventCapturing(const Event* const evt, const Stream* const stm);
void TerminateCapture(const Event* const evt, const Stream* const stm);
bool IsCrossCaptureModel(const Event* const evt, const Stream* const stm);
bool IsCapturedTask(const Stream* const launchStm, const TaskInfo* submitTask);
rtError_t GetCaptureStream(Context* const ctx, Stream* const stm, const Event* const evt, Stream** const captureStm);
rtError_t CheckCaptureStreamThreadIsMatch(const Stream* const stm);
rtError_t CheckCaptureModelSupportExternalEvent(const Device* const dev, const bool isRecord);
rtError_t CheckCaptureModelSupportSoftwareSq(const Device* const dev);
rtError_t CheckCaptureModelSupportCondOp(Device* const dev);
rtError_t CheckCaptureModelForUpdate(const Stream* stm);
bool IsSoftwareSqCaptureModel(const Model* const mdl);
bool CheckCaptureModeSupport(const Context* ctx, const char* funcName);
bool NeedReBuildSqe(const TaskInfo* const task);
bool IsUseHardwareEvent(Device* const dev);
rtError_t AllocNotifyIdForSubModel(Model* const mdl, Notify* notify);
rtError_t ReleaseNotify(Model* const mdl, Notify* notify);
uint32_t FindStreamIdInSubModels(CaptureModel* const parentModel, const uint16_t sqId);
bool IsStreamBindWithSubModel(const Stream* const stream);
bool IsTaskBelongToSubCaptureMdl(const TaskInfo* const task);
bool IsUbDmaWithSubModel(
    const Stream* const stm, const uint32_t kind, const void* const srcAddr, const void* const desAddr);
rtError_t CalculateExternalEventRefreshLayout(size_t recordCount, size_t waitCount, ExternalEventRefreshLayout* layout);
size_t GetExternalRecordRefreshEntrySize(void);
rtError_t FillExternalRecordRefreshEntry(void* const entry, uint64_t eventAddr);
rtError_t RebuildExternalTaskSqe(TaskInfo* const task);
void RollbackExternalEventRefreshInfo(ExternalEventRefreshInfo* refreshInfo);
void ReleaseRetainedEventResources(std::vector<EventResource>* resources);
rtError_t InitExternalEventHostRefresh(
    ExternalEventRefreshInfo* refreshInfo, const uint8_t* hostTemplate, uint64_t totalSize, uint32_t modelId);
rtError_t SubmitExternalEventRefreshInfo(
    Stream* launchStream, ExternalEventRefreshInfo* refreshInfo, void* deviceBase, uint64_t totalSize,
    uint32_t modelId);
void CommitExternalEventRecords(ExternalEventRefreshInfo* refreshInfo);
rtError_t SubmitExternalEventTaskCommon(
    Event* evt, Stream* stm, bool isRecord, ExternalPlaceholderSubmitter submitPlaceholder);
} // namespace runtime
} // namespace cce

#endif
