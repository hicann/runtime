/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "base.hpp"
#include "device_error_proc.hpp"

namespace cce {
namespace runtime {

#if F_DESC("DeviceErrorProcStub")
DeviceErrorProc::DeviceErrorProc(Device* dev, uint32_t ringBufferSize) : device_(dev), ringBufferSize_(ringBufferSize)
{}

DeviceErrorProc::~DeviceErrorProc() noexcept {}

rtError_t DeviceErrorProc::CreateDeviceRingBufferAndSendTask() { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t DeviceErrorProc::CreateFastRingbuffer() { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t DeviceErrorProc::RingBufferRestore() { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t DeviceErrorProc::SendTaskToStopUseRingBuffer() { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t DeviceErrorProc::DestroyDeviceRingBuffer() { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t DeviceErrorProc::ProcErrorInfo(const TaskInfo* const taskPtr)
{
    UNUSED(taskPtr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t DeviceErrorProc::ReportRingBuffer(uint16_t* errorStreamId)
{
    UNUSED(errorStreamId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

void DeviceErrorProc::ProcessReportFastRingBuffer() {}

rtError_t DeviceErrorProc::ProcCleanRingbuffer() { return RT_ERROR_FEATURE_NOT_SUPPORT; }

void DeviceErrorProc::ProcClearFastRingBuffer() const {}

void DeviceErrorProc::ProduceProcNum() {}

rtError_t DeviceErrorProc::GetQosInfoFromRingbuffer() { return RT_ERROR_FEATURE_NOT_SUPPORT; }

bool DeviceErrorProc::IsPrintStreamTimeoutSnapshot() { return false; }

rtError_t DeviceErrorProc::PrintStreamTimeoutSnapshotInfo() { return RT_ERROR_FEATURE_NOT_SUPPORT; }

AicErrorInfo DeviceErrorProc::error_pc[MAX_DEV_ID] = {};
#endif

#if F_DESC("DeviceErrorCoreProcStub")
const std::map<uint32_t, std::string> g_mulBitEccEventId = {};

const std::map<uint32_t, std::string> g_aicOrSdmaOrHcclLocalMulBitEccEventIdBlkList = {};

const std::map<uint32_t, std::string> g_hcclRemoteMulBitEccEventIdBlkList = {};

const std::map<uint32_t, std::string> g_ccuTimeoutEventIdBlkList = {};

bool HasMteErr(const Device* const dev)
{
    UNUSED(dev);
    return false;
}

rtError_t GetDeviceFaultEvents(
    const uint32_t deviceId, rtDmsFaultEvent* const faultEventInfo, uint32_t& eventCount, bool needLog)
{
    UNUSED(deviceId);
    UNUSED(faultEventInfo);
    eventCount = 0U;
    UNUSED(needLog);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

bool HasBlacklistEventOnDevice(const uint32_t deviceId, const std::map<uint32_t, std::string>& eventIdBlkList)
{
    UNUSED(deviceId);
    UNUSED(eventIdBlkList);
    return false;
}

bool HasMemUceErr(const Device* const dev, const std::map<uint32_t, std::string>& eventIdBlkList)
{
    UNUSED(dev);
    UNUSED(eventIdBlkList);
    return false;
}

void ProcessSdmaError(TaskInfo* taskInfo) { UNUSED(taskInfo); }
#endif

} // namespace runtime
} // namespace cce
