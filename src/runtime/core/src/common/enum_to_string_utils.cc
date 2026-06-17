/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "common/enum_to_string_utils.hpp"

#include <cstddef>
#include <sstream>
#include <type_traits>

namespace cce {
namespace runtime {

namespace {

template <typename T>
struct EnumStringItem {
    T value;
    const char_t *name;
};

struct FlagStringItem {
    uint64_t value;
    const char_t *name;
};

std::string HexValueToString(const uint64_t value)
{
    std::ostringstream oss;
    oss << "0x" << std::hex << value;
    return oss.str();
}

std::string AppendFlagText(const std::string &result, const char_t * const name, const uint64_t value)
{
    std::string flagText = result;
    if (!flagText.empty()) {
        flagText += "|";
    }
    flagText += name;
    flagText += "(" + HexValueToString(value) + ")";
    return flagText;
}

std::string IntegerValueToString(const unsigned char value)
{
    return std::to_string(static_cast<uint32_t>(value));
}

template <typename T>
typename std::enable_if<
    std::is_integral<T>::value && !std::is_same<typename std::remove_cv<T>::type, unsigned char>::value,
    std::string>::type
IntegerValueToString(const T value)
{
    return std::to_string(value);
}

template <typename T>
typename std::enable_if<std::is_enum<T>::value, std::string>::type UnderlyingValueToString(const T value)
{
    using UnderlyingType = typename std::underlying_type<T>::type;
    return IntegerValueToString(static_cast<UnderlyingType>(value));
}

template <typename T>
typename std::enable_if<!std::is_enum<T>::value, std::string>::type UnderlyingValueToString(const T value)
{
    return IntegerValueToString(value);
}

template <typename T, size_t N>
std::string EnumToString(const T value, const EnumStringItem<T> (&items)[N])
{
    for (size_t i = 0U; i < N; ++i) {
        if (items[i].value == value) {
            return items[i].name;
        }
    }
    return "UNKNOWN(" + UnderlyingValueToString(value) + ")";
}

template <size_t N>
std::string FlagsToString(const uint64_t flags, const char_t * const defaultText, const FlagStringItem (&items)[N])
{
    if (flags == 0U) {
        return defaultText;
    }

    uint64_t knownFlags = 0U;
    std::string result;
    for (size_t i = 0U; i < N; ++i) {
        if ((flags & items[i].value) != 0U) {
            result = AppendFlagText(result, items[i].name, items[i].value);
            knownFlags |= items[i].value;
        }
    }

    const uint64_t unknownFlags = flags & (~knownFlags);
    if (unknownFlags != 0U) {
        result = AppendFlagText(result, "UNKNOWN", unknownFlags);
    }
    return result.empty() ? ("UNKNOWN(" + HexValueToString(flags) + ")") : result;
}

} // namespace

std::string ReduceKindToString(const rtRecudeKind_t kind)
{
    static const EnumStringItem<rtRecudeKind_t> items[] = {
        {RT_MEMCPY_SDMA_AUTOMATIC_ADD, "SDMA_AUTOMATIC_ADD(10)"},
        {RT_MEMCPY_SDMA_AUTOMATIC_MAX, "SDMA_AUTOMATIC_MAX(11)"},
        {RT_MEMCPY_SDMA_AUTOMATIC_MIN, "SDMA_AUTOMATIC_MIN(12)"},
        {RT_MEMCPY_SDMA_AUTOMATIC_EQUAL, "SDMA_AUTOMATIC_EQUAL(13)"},
        {RT_RECUDE_KIND_END, "RECUDE_KIND_END(14)"},
    };
    return EnumToString(kind, items);
}

std::string DataTypeToString(const rtDataType_t type)
{
    static const EnumStringItem<rtDataType_t> items[] = {
        {RT_DATA_TYPE_FP32, "FP32(0)"},
        {RT_DATA_TYPE_FP16, "FP16(1)"},
        {RT_DATA_TYPE_INT16, "INT16(2)"},
        {RT_DATA_TYPE_INT4, "INT4(3)"},
        {RT_DATA_TYPE_INT8, "INT8(4)"},
        {RT_DATA_TYPE_INT32, "INT32(5)"},
        {RT_DATA_TYPE_BFP16, "BFP16(6)"},
        {RT_DATA_TYPE_BFP32, "BFP32(7)"},
        {RT_DATA_TYPE_UINT8, "UINT8(8)"},
        {RT_DATA_TYPE_UINT16, "UINT16(9)"},
        {RT_DATA_TYPE_UINT32, "UINT32(10)"},
        {RT_DATA_TYPE_END, "END(11)"},
    };
    return EnumToString(type, items);
}

std::string CaptureModelStatusToString(const RtCaptureModelStatus status)
{
    static const EnumStringItem<RtCaptureModelStatus> items[] = {
        {RtCaptureModelStatus::NONE, "NONE(0)"},
        {RtCaptureModelStatus::CAPTURE_ACTIVE, "CAPTURE_ACTIVE(1)"},
        {RtCaptureModelStatus::CAPTURE_INVALIDATED, "CAPTURE_INVALIDATED(2)"},
        {RtCaptureModelStatus::UPDATING, "UPDATING(3)"},
        {RtCaptureModelStatus::FAULT, "FAULT(4)"},
        {RtCaptureModelStatus::READY, "READY(5)"},
    };
    return EnumToString(status, items);
}

std::string StreamCaptureModeToString(const rtStreamCaptureMode mode)
{
    static const EnumStringItem<rtStreamCaptureMode> items[] = {
        {RT_STREAM_CAPTURE_MODE_GLOBAL, "GLOBAL(0)"},
        {RT_STREAM_CAPTURE_MODE_THREAD_LOCAL, "THREAD_LOCAL(1)"},
        {RT_STREAM_CAPTURE_MODE_RELAXED, "RELAXED(2)"},
        {RT_STREAM_CAPTURE_MODE_MAX, "MAX(3)"},
    };
    return EnumToString(mode, items);
}

std::string StreamFlagsToString(const uint32_t flags)
{
    static const FlagStringItem items[] = {
        {RT_STREAM_PERSISTENT, "RT_STREAM_PERSISTENT"},
        {RT_STREAM_FORCE_COPY, "RT_STREAM_FORCE_COPY"},
        {RT_STREAM_HUGE, "RT_STREAM_HUGE"},
        {RT_STREAM_AICPU, "RT_STREAM_AICPU"},
        {RT_STREAM_FORBIDDEN_DEFAULT, "RT_STREAM_FORBIDDEN_DEFAULT"},
        {RT_STREAM_HEAD, "RT_STREAM_HEAD"},
        {RT_STREAM_PRIMARY_DEFAULT, "RT_STREAM_PRIMARY_DEFAULT"},
        {RT_STREAM_PRIMARY_FIRST_DEFAULT, "RT_STREAM_PRIMARY_FIRST_DEFAULT"},
        {RT_STREAM_OVERFLOW, "RT_STREAM_OVERFLOW"},
        {RT_STREAM_FAST_LAUNCH, "RT_STREAM_FAST_LAUNCH"},
        {RT_STREAM_FAST_SYNC, "RT_STREAM_FAST_SYNC"},
        {RT_STREAM_CP_PROCESS_USE, "RT_STREAM_CP_PROCESS_USE"},
        {RT_STREAM_VECTOR_CORE_USE, "RT_STREAM_VECTOR_CORE_USE"},
        {RT_STREAM_ACSQ_LOCK, "RT_STREAM_ACSQ_LOCK"},
        {RT_STREAM_DQS_CTRL, "RT_STREAM_DQS_CTRL"},
        {RT_STREAM_DQS_INTER_CHIP, "RT_STREAM_DQS_INTER_CHIP"},
    };
    return FlagsToString(flags, "RT_STREAM_DEFAULT(0x0)", items);
}

std::string EventFlagsToString(const uint64_t flags)
{
    static const FlagStringItem items[] = {
        {RT_EVENT_DDSYNC_NS, "RT_EVENT_DDSYNC_NS"},
        {RT_EVENT_STREAM_MARK, "RT_EVENT_STREAM_MARK"},
        {RT_EVENT_DDSYNC, "RT_EVENT_DDSYNC"},
        {RT_EVENT_TIME_LINE, "RT_EVENT_TIME_LINE"},
        {RT_EVENT_MC2, "RT_EVENT_MC2"},
        {RT_EVENT_EXTERNAL, "RT_EVENT_EXTERNAL"},
        {RT_EVENT_IPC, "RT_EVENT_IPC"},
    };
    return FlagsToString(flags, "UNKNOWN(0x0)", items);
}

std::string KernelFlagToString(const uint32_t flag)
{
    static const EnumStringItem<uint32_t> items[] = {
        {RT_KERNEL_DEFAULT, "RT_KERNEL_DEFAULT(0)"},
        {RT_KERNEL_CONVERT, "RT_KERNEL_CONVERT(1)"},
        {RT_KERNEL_DUMPFLAG, "RT_KERNEL_DUMPFLAG(2)"},
        {RT_FUSION_KERNEL_DUMPFLAG, "RT_FUSION_KERNEL_DUMPFLAG(4)"},
        {RT_KERNEL_CUSTOM_AICPU, "RT_KERNEL_CUSTOM_AICPU(8)"},
        {RT_KERNEL_FFTSPLUS_DYNAMIC_SHAPE_DUMPFLAG, "RT_KERNEL_FFTSPLUS_DYNAMIC_SHAPE_DUMPFLAG(16)"},
        {RT_KERNEL_FFTSPLUS_STATIC_SHAPE_DUMPFLAG, "RT_KERNEL_FFTSPLUS_STATIC_SHAPE_DUMPFLAG(32)"},
        {RT_KERNEL_CMDLIST_NOT_FREE, "RT_KERNEL_CMDLIST_NOT_FREE(64)"},
        {RT_KERNEL_USE_SPECIAL_TIMEOUT, "RT_KERNEL_USE_SPECIAL_TIMEOUT(256)"},
        {RT_KERNEL_BIUPERF_FLAG, "RT_KERNEL_BIUPERF_FLAG(128)"},
    };
    return EnumToString(flag, items);
}

std::string NotifyFlagToString(const uint32_t flag)
{
    static const EnumStringItem<uint32_t> items[] = {
        {static_cast<uint32_t>(RT_NOTIFY_FLAG_DEFAULT), "RT_NOTIFY_FLAG_DEFAULT(0)"},
        {static_cast<uint32_t>(RT_NOTIFY_FLAG_DOWNLOAD_TO_DEV), "RT_NOTIFY_FLAG_DOWNLOAD_TO_DEV(1)"},
        {static_cast<uint32_t>(RT_NOTIFY_FLAG_SHR_ID_SHADOW), "RT_NOTIFY_FLAG_SHR_ID_SHADOW(64)"},
    };
    return EnumToString(flag, items);
}

std::string RecordModeToString(const rtCntNotifyRecordMode_t mode)
{
    static const EnumStringItem<rtCntNotifyRecordMode_t> items[] = {
        {RECORD_STORE_MODE, "RECORD_STORE_MODE(0)"},
        {RECORD_ADD_MODE, "RECORD_ADD_MODE(1)"},
        {RECORD_WRITE_BIT_MODE, "RECORD_WRITE_BIT_MODE(2)"},
        {RECORD_INVALID_MODE, "RECORD_INVALID_MODE(3)"},
        {RECORD_CLEAR_BIT_MODE, "RECORD_CLEAR_BIT_MODE(4)"},
        {RECORD_MODE_MAX, "RECORD_MODE_MAX(5)"},
    };
    return EnumToString(mode, items);
}

std::string WaitModeToString(const rtCntNotifyWaitMode_t mode)
{
    static const EnumStringItem<rtCntNotifyWaitMode_t> items[] = {
        {WAIT_LESS_MODE, "WAIT_LESS_MODE(0)"},
        {WAIT_EQUAL_MODE, "WAIT_EQUAL_MODE(1)"},
        {WAIT_BIGGER_MODE, "WAIT_BIGGER_MODE(2)"},
        {WAIT_BIGGER_OR_EQUAL_MODE, "WAIT_BIGGER_OR_EQUAL_MODE(3)"},
        {WAIT_BITMAP_MODE, "WAIT_BITMAP_MODE(4)"},
        {WAIT_MODE_MAX, "WAIT_MODE_MAX(5)"},
    };
    return EnumToString(mode, items);
}

std::string CaptureEventModeToString(const uint8_t mode)
{
    static const EnumStringItem<uint8_t> items[] = {
        {static_cast<uint8_t>(CaptureEventModeType::SOFTWARE_MODE), "SOFTWARE_MODE(0)"},
        {static_cast<uint8_t>(CaptureEventModeType::HARDWARE_MODE), "HARDWARE_MODE(1)"},
    };
    return EnumToString(mode, items);
}

std::string InfoTypeToString(const uint32_t infoType)
{
    static const EnumStringItem<uint32_t> items[] = {
        {static_cast<uint32_t>(INFO_TYPE_ENV), "ENV(0)"},
        {static_cast<uint32_t>(INFO_TYPE_VERSION), "VERSION(1)"},
        {static_cast<uint32_t>(INFO_TYPE_MASTERID), "MASTERID(2)"},
        {static_cast<uint32_t>(INFO_TYPE_CORE_NUM), "CORE_NUM(3)"},
        {static_cast<uint32_t>(INFO_TYPE_FREQUE), "FREQUE(4)"},
        {static_cast<uint32_t>(INFO_TYPE_WORK_MODE), "WORK_MODE(21)"},
        {static_cast<uint32_t>(INFO_TYPE_UTILIZATION), "UTILIZATION(23)"},
        {static_cast<uint32_t>(INFO_TYPE_CORE_NUM_LEVEL), "CORE_NUM_LEVEL(15)"},
    };
    return EnumToString(infoType, items);
}

std::string ModuleTypeToString(const int32_t moduleType)
{
    static const EnumStringItem<int32_t> items[] = {
        {RT_MODULE_TYPE_SYSTEM, "SYSTEM(0)"},
        {RT_MODULE_TYPE_AICPU, "AICPU(1)"},
        {RT_MODULE_TYPE_CCPU, "CCPU(2)"},
        {RT_MODULE_TYPE_DCPU, "DCPU(3)"},
        {RT_MODULE_TYPE_AICORE, "AICORE(4)"},
        {RT_MODULE_TYPE_TSCPU, "TSCPU(5)"},
        {RT_MODULE_TYPE_PCIE, "PCIE(6)"},
        {RT_MODULE_TYPE_VECTOR_CORE, "VECTOR_CORE(7)"},
        {RT_MODULE_TYPE_HOST_AICPU, "HOST_AICPU(8)"},
        {RT_MODULE_TYPE_QOS, "QOS(9)"},
        {RT_MODULE_TYPE_MEMORY, "MEMORY(10)"},
    };
    return EnumToString(moduleType, items);
}

std::string DevResTypeToString(const rtDevResType_t type)
{
    static const EnumStringItem<rtDevResType_t> items[] = {
        {RT_RES_TYPE_STARS_NOTIFY_RECORD, "STARS_NOTIFY_RECORD(0)"},
        {RT_RES_TYPE_STARS_CNT_NOTIFY_RECORD, "STARS_CNT_NOTIFY_RECORD(1)"},
        {RT_RES_TYPE_STARS_RTSQ, "STARS_RTSQ(2)"},
        {RT_RES_TYPE_CCU_CKE, "CCU_CKE(3)"},
        {RT_RES_TYPE_CCU_XN, "CCU_XN(4)"},
        {RT_RES_TYPE_STARS_CNT_NOTIFY_BIT_WR, "STARS_CNT_NOTIFY_BIT_WR(5)"},
        {RT_RES_TYPE_STARS_CNT_NOTIFY_ADD, "STARS_CNT_NOTIFY_ADD(6)"},
        {RT_RES_TYPE_STARS_CNT_NOTIFY_BIT_CLR, "STARS_CNT_NOTIFY_BIT_CLR(7)"},
    };
    return EnumToString(type, items);
}

std::string DevResProcTypeToString(const rtDevResProcType_t type)
{
    static const EnumStringItem<rtDevResProcType_t> items[] = {
        {RT_PROCESS_CP1, "CP1(0)"},
        {RT_PROCESS_CP2, "CP2(1)"},
        {RT_PROCESS_DEV_ONLY, "DEV_ONLY(2)"},
        {RT_PROCESS_QS, "QS(3)"},
        {RT_PROCESS_HCCP, "HCCP(4)"},
        {RT_PROCESS_USER, "USER(5)"},
    };
    return EnumToString(type, items);
}

std::string UbDevQueryCmdToString(const rtUbDevQueryCmd cmd)
{
    static const EnumStringItem<rtUbDevQueryCmd> items[] = {
        {QUERY_PROCESS_TOKEN, "QUERY_PROCESS_TOKEN(0)"},
        {QUERY_TYPE_BUFF, "QUERY_TYPE_BUFF(1)"},
    };
    return EnumToString(cmd, items);
}

std::string DeviceStateCallbackToString(const DeviceStateCallback type)
{
    static const EnumStringItem<DeviceStateCallback> items[] = {
        {DeviceStateCallback::RT_DEVICE_STATE_CALLBACK, "RT_DEVICE_STATE_CALLBACK(0)"},
        {DeviceStateCallback::RTS_DEVICE_STATE_CALLBACK, "RTS_DEVICE_STATE_CALLBACK(1)"},
    };
    return EnumToString(type, items);
}

std::string LastErrLevelToString(const rtLastErrLevel_t level)
{
    static const EnumStringItem<rtLastErrLevel_t> items[] = {
        {RT_THREAD_LEVEL, "RT_THREAD_LEVEL(0)"},
        {RT_CONTEXT_LEVEL, "RT_CONTEXT_LEVEL(1)"},
    };
    return EnumToString(level, items);
}

std::string TaskBuffTypeToString(const rtTaskBuffType_t type)
{
    static const EnumStringItem<rtTaskBuffType_t> items[] = {
        {HWTS_STATIC_TASK_DESC, "HWTS_STATIC_TASK_DESC(0)"},
        {HWTS_DYNAMIC_TASK_DESC, "HWTS_DYNAMIC_TASK_DESC(1)"},
        {PARAM_TASK_INFO_DESC, "PARAM_TASK_INFO_DESC(2)"},
    };
    return EnumToString(type, items);
}

std::string MemcpyKindToString(const rtMemcpyKind_t kind)
{
    static const EnumStringItem<rtMemcpyKind_t> items[] = {
        {RT_MEMCPY_HOST_TO_HOST, "RT_MEMCPY_HOST_TO_HOST(0)"},
        {RT_MEMCPY_HOST_TO_DEVICE, "RT_MEMCPY_HOST_TO_DEVICE(1)"},
        {RT_MEMCPY_DEVICE_TO_HOST, "RT_MEMCPY_DEVICE_TO_HOST(2)"},
        {RT_MEMCPY_DEVICE_TO_DEVICE, "RT_MEMCPY_DEVICE_TO_DEVICE(3)"},
        {RT_MEMCPY_MANAGED, "RT_MEMCPY_MANAGED(4)"},
        {RT_MEMCPY_ADDR_DEVICE_TO_DEVICE, "RT_MEMCPY_ADDR_DEVICE_TO_DEVICE(5)"},
        {RT_MEMCPY_HOST_TO_DEVICE_EX, "RT_MEMCPY_HOST_TO_DEVICE_EX(6)"},
        {RT_MEMCPY_DEVICE_TO_HOST_EX, "RT_MEMCPY_DEVICE_TO_HOST_EX(7)"},
        {RT_MEMCPY_DEFAULT, "RT_MEMCPY_DEFAULT(8)"},
        {RT_MEMCPY_RESERVED, "RT_MEMCPY_RESERVED(9)"},
    };
    return EnumToString(kind, items);
}

std::string MemcpyNewKindToString(const rtMemcpyKind kind)
{
    static const EnumStringItem<rtMemcpyKind> items[] = {
        {RT_MEMCPY_KIND_HOST_TO_HOST, "RT_MEMCPY_KIND_HOST_TO_HOST(0)"},
        {RT_MEMCPY_KIND_HOST_TO_DEVICE, "RT_MEMCPY_KIND_HOST_TO_DEVICE(1)"},
        {RT_MEMCPY_KIND_DEVICE_TO_HOST, "RT_MEMCPY_KIND_DEVICE_TO_HOST(2)"},
        {RT_MEMCPY_KIND_DEVICE_TO_DEVICE, "RT_MEMCPY_KIND_DEVICE_TO_DEVICE(3)"},
        {RT_MEMCPY_KIND_DEFAULT, "RT_MEMCPY_KIND_DEFAULT(4)"},
        {RT_MEMCPY_KIND_HOST_TO_BUF_TO_DEVICE, "RT_MEMCPY_KIND_HOST_TO_BUF_TO_DEVICE(5)"},
        {RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE, "RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE(6)"},
        {RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE, "RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE(7)"},
        {RT_MEMCPY_KIND_MAX, "RT_MEMCPY_KIND_MAX(8)"},
    };
    return EnumToString(kind, items);
}

std::string WriteValueSizeTypeToString(const rtWriteValueSizeType_t type)
{
    static const EnumStringItem<rtWriteValueSizeType_t> items[] = {
        {WRITE_VALUE_SIZE_TYPE_INVALID, "WRITE_VALUE_SIZE_TYPE_INVALID(0)"},
        {WRITE_VALUE_SIZE_TYPE_8BIT, "WRITE_VALUE_SIZE_TYPE_8BIT(1)"},
        {WRITE_VALUE_SIZE_TYPE_16BIT, "WRITE_VALUE_SIZE_TYPE_16BIT(2)"},
        {WRITE_VALUE_SIZE_TYPE_32BIT, "WRITE_VALUE_SIZE_TYPE_32BIT(3)"},
        {WRITE_VALUE_SIZE_TYPE_64BIT, "WRITE_VALUE_SIZE_TYPE_64BIT(4)"},
        {WRITE_VALUE_SIZE_TYPE_128BIT, "WRITE_VALUE_SIZE_TYPE_128BIT(5)"},
        {WRITE_VALUE_SIZE_TYPE_256BIT, "WRITE_VALUE_SIZE_TYPE_256BIT(6)"},
        {WRITE_VALUE_SIZE_TYPE_BUFF, "WRITE_VALUE_SIZE_TYPE_BUFF(7)"},
    };
    return EnumToString(type, items);
}

std::string CondHandleFlagToString(const rtCondHandleFlag_t flag)
{
    static const EnumStringItem<rtCondHandleFlag_t> items[] = {
        {RT_COND_HANDLE_ASSIGN_DEFAULT, "RT_COND_HANDLE_ASSIGN_DEFAULT(1)"},
    };
    return EnumToString(flag, items);
}

std::string CondTaskTypeToString(const rtCondTaskType_t type)
{
    static const EnumStringItem<rtCondTaskType_t> items[] = {
        {RT_COND_TASK_TYPE_IF, "RT_COND_TASK_TYPE_IF(0)"},
        {RT_COND_TASK_TYPE_WHILE, "RT_COND_TASK_TYPE_WHILE(1)"},
        {RT_COND_TASK_TYPE_SWITCH, "RT_COND_TASK_TYPE_SWITCH(2)"},
        {RT_COND_TASK_TYPE_MAX, "RT_COND_TASK_TYPE_MAX(3)"},
    };
    return EnumToString(type, items);
}

std::string DevFeatureTypeToString(const int32_t devFeatureType)
{
    static const EnumStringItem<int32_t> items[] = {
        {RT_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV, "RT_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV(1)"},
        {RT_FEATURE_SYSTEM_MEMQ_EVENT_CROSS_DEV, "RT_FEATURE_SYSTEM_MEMQ_EVENT_CROSS_DEV(21)"},
        {RT_FEATURE_AICPU_SCHEDULE_TYPE, "RT_FEATURE_AICPU_SCHEDULE_TYPE(10001)"},
        {RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH, "RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH(20001)"},
    };
    return EnumToString(devFeatureType, items);
}

} // namespace runtime
} // namespace cce
