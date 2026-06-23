/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_ENUM_TO_STRING_UTILS_HPP
#define CCE_RUNTIME_ENUM_TO_STRING_UTILS_HPP

#include <string>
#include "runtime/config.h"
#include "capture_model.hpp"
#include "common/thread_local_container.hpp"
#include "device.hpp"

namespace cce {
namespace runtime {

static inline std::string ReduceKindToString(const rtRecudeKind_t kind)
{
    switch (kind) {
        case RT_MEMCPY_SDMA_AUTOMATIC_ADD:
            return "SDMA_AUTOMATIC_ADD(10)";
        case RT_MEMCPY_SDMA_AUTOMATIC_MAX:
            return "SDMA_AUTOMATIC_MAX(11)";
        case RT_MEMCPY_SDMA_AUTOMATIC_MIN:
            return "SDMA_AUTOMATIC_MIN(12)";
        case RT_MEMCPY_SDMA_AUTOMATIC_EQUAL:
            return "SDMA_AUTOMATIC_EQUAL(13)";
        case RT_RECUDE_KIND_END:
            return "RECUDE_KIND_END(14)";
        default:
            return "UNKNOWN(" + std::to_string(static_cast<uint32_t>(kind)) + ")";
    }
}

static inline std::string DataTypeToString(const rtDataType_t type)
{
    switch (type) {
        case RT_DATA_TYPE_FP32:
            return "FP32(0)";
        case RT_DATA_TYPE_FP16:
            return "FP16(1)";
        case RT_DATA_TYPE_INT16:
            return "INT16(2)";
        case RT_DATA_TYPE_INT4:
            return "INT4(3)";
        case RT_DATA_TYPE_INT8:
            return "INT8(4)";
        case RT_DATA_TYPE_INT32:
            return "INT32(5)";
        case RT_DATA_TYPE_BFP16:
            return "BFP16(6)";
        case RT_DATA_TYPE_BFP32:
            return "BFP32(7)";
        case RT_DATA_TYPE_UINT8:
            return "UINT8(8)";
        case RT_DATA_TYPE_UINT16:
            return "UINT16(9)";
        case RT_DATA_TYPE_UINT32:
            return "UINT32(10)";
        case RT_DATA_TYPE_END:
            return "END(11)";
        default:
            return "UNKNOWN(" + std::to_string(static_cast<uint32_t>(type)) + ")";
    }
}

static inline std::string CaptureModelStatusToString(const RtCaptureModelStatus status)
{
    switch (status) {
        case RtCaptureModelStatus::NONE:
            return "NONE(0)";
        case RtCaptureModelStatus::CAPTURE_ACTIVE:
            return "CAPTURE_ACTIVE(1)";
        case RtCaptureModelStatus::CAPTURE_INVALIDATED:
            return "CAPTURE_INVALIDATED(2)";
        case RtCaptureModelStatus::UPDATING:
            return "UPDATING(3)";
        case RtCaptureModelStatus::FAULT:
            return "FAULT(4)";
        case RtCaptureModelStatus::READY:
            return "READY(5)";
        default:
            return "UNKNOWN(" + std::to_string(static_cast<int>(status)) + ")";
    }
}

static inline std::string StreamCaptureModeToString(const rtStreamCaptureMode mode)
{
    switch (mode) {
        case RT_STREAM_CAPTURE_MODE_GLOBAL:
            return "GLOBAL(0)";
        case RT_STREAM_CAPTURE_MODE_THREAD_LOCAL:
            return "THREAD_LOCAL(1)";
        case RT_STREAM_CAPTURE_MODE_RELAXED:
            return "RELAXED(2)";
        case RT_STREAM_CAPTURE_MODE_MAX:
            return "MAX(3)";
        default:
            return "UNKNOWN(" + std::to_string(static_cast<int32_t>(mode)) + ")";
    }
}

static inline std::string KernelFlagToString(const uint32_t flag)
{
    switch (flag) {
        case RT_KERNEL_DEFAULT:
            return "RT_KERNEL_DEFAULT(0)";
        case RT_KERNEL_CONVERT:
            return "RT_KERNEL_CONVERT(1)";
        case RT_KERNEL_DUMPFLAG:
            return "RT_KERNEL_DUMPFLAG(2)";
        case RT_FUSION_KERNEL_DUMPFLAG:
            return "RT_FUSION_KERNEL_DUMPFLAG(4)";
        case RT_KERNEL_CUSTOM_AICPU:
            return "RT_KERNEL_CUSTOM_AICPU(8)";
        case RT_KERNEL_FFTSPLUS_DYNAMIC_SHAPE_DUMPFLAG:
            return "RT_KERNEL_FFTSPLUS_DYNAMIC_SHAPE_DUMPFLAG(16)";
        case RT_KERNEL_FFTSPLUS_STATIC_SHAPE_DUMPFLAG:
            return "RT_KERNEL_FFTSPLUS_STATIC_SHAPE_DUMPFLAG(32)";
        case RT_KERNEL_CMDLIST_NOT_FREE:
            return "RT_KERNEL_CMDLIST_NOT_FREE(64)";
        case RT_KERNEL_USE_SPECIAL_TIMEOUT:
            return "RT_KERNEL_USE_SPECIAL_TIMEOUT(256)";
        case RT_KERNEL_BIUPERF_FLAG:
            return "RT_KERNEL_BIUPERF_FLAG(128)";
        default:
            return "UNKNOWN(" + std::to_string(flag) + ")";
    }
}

static inline std::string NotifyFlagToString(const uint32_t flag)
{
    switch (flag) {
        case RT_NOTIFY_FLAG_DEFAULT:
            return "RT_NOTIFY_FLAG_DEFAULT(0)";
        case RT_NOTIFY_FLAG_DOWNLOAD_TO_DEV:
            return "RT_NOTIFY_FLAG_DOWNLOAD_TO_DEV(1)";
        case RT_NOTIFY_FLAG_SHR_ID_SHADOW:
            return "RT_NOTIFY_FLAG_SHR_ID_SHADOW(64)";
        default:
            return "UNKNOWN(" + std::to_string(flag) + ")";
    }
}

static inline std::string RecordModeToString(const rtCntNotifyRecordMode_t mode)
{
    switch (mode) {
        case RECORD_STORE_MODE:
            return "RECORD_STORE_MODE(0)";
        case RECORD_ADD_MODE:
            return "RECORD_ADD_MODE(1)";
        case RECORD_WRITE_BIT_MODE:
            return "RECORD_WRITE_BIT_MODE(2)";
        case RECORD_INVALID_MODE:
            return "RECORD_INVALID_MODE(3)";
        case RECORD_CLEAR_BIT_MODE:
            return "RECORD_CLEAR_BIT_MODE(4)";
        case RECORD_MODE_MAX:
            return "RECORD_MODE_MAX(5)";
        default:
            return "UNKNOWN(" + std::to_string(static_cast<uint32_t>(mode)) + ")";
    }
}

static inline std::string WaitModeToString(const rtCntNotifyWaitMode_t mode)
{
    switch (mode) {
        case WAIT_LESS_MODE:
            return "WAIT_LESS_MODE(0)";
        case WAIT_EQUAL_MODE:
            return "WAIT_EQUAL_MODE(1)";
        case WAIT_BIGGER_MODE:
            return "WAIT_BIGGER_MODE(2)";
        case WAIT_BIGGER_OR_EQUAL_MODE:
            return "WAIT_BIGGER_OR_EQUAL_MODE(3)";
        case WAIT_BITMAP_MODE:
            return "WAIT_BITMAP_MODE(4)";
        case WAIT_MODE_MAX:
            return "WAIT_MODE_MAX(5)";
        default:
            return "UNKNOWN(" + std::to_string(static_cast<uint32_t>(mode)) + ")";
    }
}

static inline std::string CaptureEventModeToString(const uint8_t mode)
{
    switch (mode) {
        case static_cast<uint8_t>(CaptureEventModeType::SOFTWARE_MODE):
            return "SOFTWARE_MODE(0)";
        case static_cast<uint8_t>(CaptureEventModeType::HARDWARE_MODE):
            return "HARDWARE_MODE(1)";
        default:
            return "UNKNOWN(" + std::to_string(mode) + ")";
    }
}

static inline std::string InfoTypeToString(const int32_t infoType)
{
    switch (infoType) {
        case INFO_TYPE_ENV:
            return "ENV(0)";
        case INFO_TYPE_VERSION:
            return "VERSION(1)";
        case INFO_TYPE_MASTERID:
            return "MASTERID(2)";
        case INFO_TYPE_CORE_NUM:
            return "CORE_NUM(3)";
        case INFO_TYPE_FREQUE:
            return "FREQUE(4)";
        case INFO_TYPE_WORK_MODE:
            return "WORK_MODE(22)";
        case INFO_TYPE_UTILIZATION:
            return "UTILIZATION(23)";
        case INFO_TYPE_CORE_NUM_LEVEL:
            return "CORE_NUM_LEVEL(15)";
        default:
            return "UNKNOWN(" + std::to_string(infoType) + ")";
    }
}

static inline std::string ModuleTypeToString(const int32_t moduleType)
{
    switch (moduleType) {
        case RT_MODULE_TYPE_SYSTEM:
            return "SYSTEM(0)";
        case RT_MODULE_TYPE_AICPU:
            return "AICPU(1)";
        case RT_MODULE_TYPE_CCPU:
            return "CCPU(2)";
        case RT_MODULE_TYPE_DCPU:
            return "DCPU(3)";
        case RT_MODULE_TYPE_AICORE:
            return "AICORE(4)";
        case RT_MODULE_TYPE_TSCPU:
            return "TSCPU(5)";
        case RT_MODULE_TYPE_PCIE:
            return "PCIE(6)";
        case RT_MODULE_TYPE_VECTOR_CORE:
            return "VECTOR_CORE(7)";
        case RT_MODULE_TYPE_HOST_AICPU:
            return "HOST_AICPU(8)";
        case RT_MODULE_TYPE_QOS:
            return "QOS(9)";
        case RT_MODULE_TYPE_MEMORY:
            return "MEMORY(10)";
        default:
            return "UNKNOWN(" + std::to_string(moduleType) + ")";
    }
}

static inline std::string DevResTypeToString(const rtDevResType_t type)
{
    switch (type) {
        case RT_RES_TYPE_STARS_NOTIFY_RECORD:
            return "STARS_NOTIFY_RECORD(0)";
        case RT_RES_TYPE_STARS_CNT_NOTIFY_RECORD:
            return "STARS_CNT_NOTIFY_RECORD(1)";
        case RT_RES_TYPE_STARS_RTSQ:
            return "STARS_RTSQ(2)";
        case RT_RES_TYPE_CCU_CKE:
            return "CCU_CKE(3)";
        case RT_RES_TYPE_CCU_XN:
            return "CCU_XN(4)";
        case RT_RES_TYPE_STARS_CNT_NOTIFY_BIT_WR:
            return "STARS_CNT_NOTIFY_BIT_WR(5)";
        case RT_RES_TYPE_STARS_CNT_NOTIFY_ADD:
            return "STARS_CNT_NOTIFY_ADD(6)";
        case RT_RES_TYPE_STARS_CNT_NOTIFY_BIT_CLR:
            return "STARS_CNT_NOTIFY_BIT_CLR(7)";
        default:
            return "UNKNOWN(" + std::to_string(static_cast<int32_t>(type)) + ")";
    }
}

static inline std::string DevResProcTypeToString(const rtDevResProcType_t type)
{
    switch (type) {
        case RT_PROCESS_CP1:
            return "CP1(0)";
        case RT_PROCESS_CP2:
            return "CP2(1)";
        case RT_PROCESS_DEV_ONLY:
            return "DEV_ONLY(2)";
        case RT_PROCESS_QS:
            return "QS(3)";
        case RT_PROCESS_HCCP:
            return "HCCP(4)";
        case RT_PROCESS_USER:
            return "USER(5)";
        default:
            return "UNKNOWN(" + std::to_string(static_cast<int32_t>(type)) + ")";
    }
}

static inline std::string UbDevQueryCmdToString(const rtUbDevQueryCmd cmd)
{
    switch (cmd) {
        case QUERY_PROCESS_TOKEN:
            return "QUERY_PROCESS_TOKEN(0)";
        case QUERY_TYPE_BUFF:
            return "QUERY_TYPE_BUFF(1)";
        default:
            return "UNKNOWN(" + std::to_string(static_cast<uint32_t>(cmd)) + ")";
    }
}

static inline std::string DeviceStateCallbackToString(const DeviceStateCallback type)
{
    switch (type) {
        case DeviceStateCallback::RT_DEVICE_STATE_CALLBACK:
            return "RT_DEVICE_STATE_CALLBACK(0)";
        case DeviceStateCallback::RTS_DEVICE_STATE_CALLBACK:
            return "RTS_DEVICE_STATE_CALLBACK(1)";
        default:
            return "UNKNOWN(" + std::to_string(static_cast<uint32_t>(type)) + ")";
    }
}

static inline std::string LastErrLevelToString(const rtLastErrLevel_t level)

{
    switch (level) {
        case RT_THREAD_LEVEL:
            return "RT_THREAD_LEVEL(0)";
        case RT_CONTEXT_LEVEL:
            return "RT_CONTEXT_LEVEL(1)";
        default:
            return "UNKNOWN(" + std::to_string(static_cast<uint32_t>(level)) + ")";
    }
}

static inline std::string TaskBuffTypeToString(const rtTaskBuffType_t type)
{
    switch (type) {
        case HWTS_STATIC_TASK_DESC:
            return "HWTS_STATIC_TASK_DESC(0)";
        case HWTS_DYNAMIC_TASK_DESC:
            return "HWTS_DYNAMIC_TASK_DESC(1)";
        case PARAM_TASK_INFO_DESC:
            return "PARAM_TASK_INFO_DESC(2)";
        default:
            return "UNKNOWN(" + std::to_string(static_cast<uint32_t>(type)) + ")";
    }
}

static inline std::string DevFeatureTypeToString(const int32_t devFeatureType)
{
    switch (devFeatureType) {
        case RT_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV:
            return "RT_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV(1)";
        case RT_FEATURE_SYSTEM_MEMQ_EVENT_CROSS_DEV:
            return "RT_FEATURE_SYSTEM_MEMQ_EVENT_CROSS_DEV(21)";
        case RT_FEATURE_AICPU_SCHEDULE_TYPE:
            return "RT_FEATURE_AICPU_SCHEDULE_TYPE(10001)";
        case RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH:
            return "RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH(20001)";
        default:
            return "UNKNOWN(" + std::to_string(devFeatureType) + ")";
    }
}

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_ENUM_TO_STRING_UTILS_HPP