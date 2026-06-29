/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "capture_model.hpp"

namespace cce {
namespace runtime {

CaptureModel::CaptureModel(ModelType type) : Model(type) {}

CaptureModel::~CaptureModel() noexcept {}

rtError_t CaptureModel::Execute(Stream * const stm, int32_t timeout) { UNUSED(stm); UNUSED(timeout); return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CaptureModel::ExecuteAsync(Stream * const stm) { UNUSED(stm); return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CaptureModel::TearDown() { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CaptureModel::AddStreamToCaptureModel(Stream * const stm) { UNUSED(stm); return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CaptureModel::SetNotifyBeforeExecute(Stream * const exeStm, CaptureModel* const captureMdl) { UNUSED(exeStm); UNUSED(captureMdl); return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CaptureModel::SetNotifyAfterExecute(
    Stream* const exeStm, CaptureModel* const captureMdl, ExternalEventRefreshInfo* externalEventRefreshInfo)
{
    UNUSED(exeStm);
    UNUSED(captureMdl);
    UNUSED(externalEventRefreshInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

bool CaptureModel::IsAddStream(const Stream *stm) const { UNUSED(stm); return false; }

void CaptureModel::EnterCaptureNotify(const int32_t singleOperStmId, const int32_t captureStmId) { UNUSED(singleOperStmId); UNUSED(captureStmId); }

void CaptureModel::ExitCaptureNotify() {}

rtError_t CaptureModel::ResetCaptureEvents(Stream * const stm) const { UNUSED(stm); return RT_ERROR_FEATURE_NOT_SUPPORT; }

void CaptureModel::DebugDotPrintTaskGroups(const uint32_t deviceId) const { UNUSED(deviceId); }

void CaptureModel::ReportedStreamInfoForProfiling() const {}

void CaptureModel::EraseStreamInfoForProfiling() const {}

rtError_t CaptureModel::SetShapeInfo(const Stream* const stm, const uint32_t taskId, const void * const infoPtr, const size_t infoSize) { UNUSED(stm); UNUSED(taskId); UNUSED(infoPtr); UNUSED(infoSize); return RT_ERROR_FEATURE_NOT_SUPPORT; }

void CaptureModel::ClearShapeInfo(const int32_t streamId, const uint32_t taskId) { UNUSED(streamId); UNUSED(taskId); }

void* CaptureModel::GetShapeInfo(const int32_t streamId, const uint32_t taskId, size_t &infoSize) const { UNUSED(streamId); UNUSED(taskId); UNUSED(infoSize); return nullptr; }

rtError_t CaptureModel::CacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize, const Stream * const stm) { UNUSED(infoPtr); UNUSED(infoSize); UNUSED(stm); return RT_ERROR_FEATURE_NOT_SUPPORT; }

void CaptureModel::ReportShapeInfoForProfiling() const {}

void CaptureModel::SetModelCacheOpInfoSwitch(const uint32_t status) const { UNUSED(status); }

const TaskGroup* CaptureModel::GetTaskGroup(uint16_t streamId, uint16_t taskId) { UNUSED(streamId); UNUSED(taskId); return nullptr; }

void CaptureModel::BackupArgHandle(const uint16_t streamId, const uint16_t taskId) { UNUSED(streamId); UNUSED(taskId); }

rtError_t CaptureModel::Update(void) { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CaptureModel::ReleaseNotifyId(uint32_t &releaseNum) { UNUSED(releaseNum); return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CaptureModel::UpdateNotifyId(Stream * const exeStream) { UNUSED(exeStream); return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CaptureModel::BuildSqCq(Stream * const exeStream) { UNUSED(exeStream); return RT_ERROR_FEATURE_NOT_SUPPORT; }

void CaptureModel::DeconstructSqCq(void) {}

rtError_t CaptureModel::ReleaseSqCq(uint32_t &releaseNum) { UNUSED(releaseNum); return RT_ERROR_FEATURE_NOT_SUPPORT; }

void CaptureModel::CaptureModelExecuteFinish(const uint32_t errCode) { UNUSED(errCode); }

rtError_t CaptureModel::MarkStreamActiveTask(TaskInfo *streamActiveTask) { UNUSED(streamActiveTask); return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CaptureModel::RestoreForSoftwareSq(Device * const dev) { UNUSED(dev); return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CaptureModel::BindSqCqAndSendSqe(void) { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CaptureModel::BuildActualExternalTaskSqe(TaskInfo* const task)
{
    UNUSED(task);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

size_t CaptureModel::GetExternalRecordRefreshSlotSize(void) const
{
    return 0U;
}

rtError_t CaptureModel::FillExternalRecordRefreshSlot(void* const slot, uint64_t eventAddr) const
{
    UNUSED(slot);
    UNUSED(eventAddr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CaptureModel::BindSqCq(void) { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CaptureModel::BindStreamToModel(void) { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CaptureModel::UnBindSqCq(void) { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CaptureModel::AllocSqAddr(void) const { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CaptureModel::AllocSqCqProc(const uint32_t streamNum) const { UNUSED(streamNum); return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CaptureModel::UpdateStreamActiveTaskFuncCallMem(void) { return RT_ERROR_FEATURE_NOT_SUPPORT; }

void CaptureModel::ClearStreamActiveTask(void) {}

rtError_t CaptureModel::ExecuteCommon(Stream * const stm, int32_t timeout, const uint8_t executeMode) {
    UNUSED(stm);
    UNUSED(timeout);
    UNUSED(executeMode);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

Stream* CaptureModel::GetOriginalCaptureStream(void) const { return nullptr; }

void CaptureModel::ReportCacheTrackData() {}

}
}
