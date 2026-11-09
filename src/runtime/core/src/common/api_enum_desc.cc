/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "enum_desc.hpp"
#include "securec.h"
#include <cinttypes>
#include "runtime/context.h"
#include "runtime/rt_inner_event.h"
#include "runtime/rts/rts_event.h"
#include "runtime/rts/rts_model.h"
#include "runtime/rts/rts_stream.h"
#include "runtime/rt_inner_model.h"
#include "runtime/rt_external_device.h"
#include "runtime/rt_external_dqs.h"
#include "runtime/inner_kernel.h"

namespace cce {
namespace runtime {

const char_t* MemcpyKindToStr(const rtMemcpyKind_t kind)
{
    switch (kind) {
        case RT_MEMCPY_HOST_TO_HOST:
            return "MEMCPY_HOST_TO_HOST(0)";
        case RT_MEMCPY_HOST_TO_DEVICE:
            return "MEMCPY_HOST_TO_DEVICE(1)";
        case RT_MEMCPY_DEVICE_TO_HOST:
            return "MEMCPY_DEVICE_TO_HOST(2)";
        case RT_MEMCPY_DEVICE_TO_DEVICE:
            return "MEMCPY_DEVICE_TO_DEVICE(3)";
        case RT_MEMCPY_MANAGED:
            return "MEMCPY_MANAGED(4)";
        case RT_MEMCPY_ADDR_DEVICE_TO_DEVICE:
            return "MEMCPY_ADDR_DEVICE_TO_DEVICE(5)";
        case RT_MEMCPY_HOST_TO_DEVICE_EX:
            return "MEMCPY_HOST_TO_DEVICE_EX(6)";
        case RT_MEMCPY_DEVICE_TO_HOST_EX:
            return "MEMCPY_DEVICE_TO_HOST_EX(7)";
        case RT_MEMCPY_DEFAULT:
            return "MEMCPY_DEFAULT(8)";
        case RT_MEMCPY_RESERVED:
            return "MEMCPY_RESERVED(9)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(kind));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

std::string MemcpyNewKindToString(const rtMemcpyKind kind)
{
    switch (kind) {
        case RT_MEMCPY_KIND_HOST_TO_HOST:
            return "MEMCPY_KIND_HOST_TO_HOST(0)";
        case RT_MEMCPY_KIND_HOST_TO_DEVICE:
            return "MEMCPY_KIND_HOST_TO_DEVICE(1)";
        case RT_MEMCPY_KIND_DEVICE_TO_HOST:
            return "MEMCPY_KIND_DEVICE_TO_HOST(2)";
        case RT_MEMCPY_KIND_DEVICE_TO_DEVICE:
            return "MEMCPY_KIND_DEVICE_TO_DEVICE(3)";
        case RT_MEMCPY_KIND_DEFAULT:
            return "MEMCPY_KIND_DEFAULT(4)";
        case RT_MEMCPY_KIND_HOST_TO_BUF_TO_DEVICE:
            return "MEMCPY_KIND_HOST_TO_BUF_TO_DEVICE(5)";
        case RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE:
            return "MEMCPY_KIND_INNER_DEVICE_TO_DEVICE(6)";
        case RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE:
            return "MEMCPY_KIND_INTER_DEVICE_TO_DEVICE(7)";
        case RT_MEMCPY_KIND_MAX:
            return "MEMCPY_KIND_MAX(8)";
        default:
            return RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(kind));
    }
}

std::string CmoOpCodeToString(const rtCmoOpCode_t opCode)
{
    switch (opCode) {
        case RT_CMO_PREFETCH:
            return "CMO_PREFETCH(6)";
        case RT_CMO_WRITEBACK:
            return "CMO_WRITEBACK(7)";
        case RT_CMO_INVALID:
            return "CMO_INVALID(8)";
        case RT_CMO_FLUSH:
            return "CMO_FLUSH(9)";
        case RT_CMO_RESERVED:
            return "CMO_RESERVED(10)";
        default:
            return RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(opCode));
    }
}

std::string SysParamOptToString(const rtSysParamOpt option)
{
    switch (option) {
        case SYS_OPT_DETERMINISTIC:
            return "SYS_OPT_DETERMINISTIC(0)";
        case SYS_OPT_ENABLE_DEBUG_KERNEL:
            return "SYS_OPT_ENABLE_DEBUG_KERNEL(1)";
        case SYS_OPT_STRONG_CONSISTENCY:
            return "SYS_OPT_STRONG_CONSISTENCY(2)";
        case SYS_OPT_ENABLE_KERNEL_EARLY_START:
            return "SYS_OPT_ENABLE_KERNEL_EARLY_START(3)";
        case SYS_OPT_RESERVED:
            return "SYS_OPT_RESERVED(4)";
        default:
            return RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(option));
    }
}

std::string NamedValueDescription(const ErrMsgNamedValue& item)
{
    if (item.useHex) {
        return RtFmtMsg("%s(0x%" PRIX64 ")", item.name, item.value);
    }
    return RtFmtMsg("%s(%" PRIu64 ")", item.name, item.value);
}

std::string EnumValueDescription(const int64_t value, const std::initializer_list<ErrMsgNamedValue> names)
{
    for (const auto& item : names) {
        if (value == static_cast<int64_t>(item.value)) {
            return NamedValueDescription(item);
        }
    }
    return RtFmtMsg("UNKNOWN(%" PRId64 ")", value);
}

std::string KernelTypeToString(const int64_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {KERNEL_TYPE_CCE, "KERNEL_TYPE_CCE"},
        {KERNEL_TYPE_FWK, "KERNEL_TYPE_FWK"},
        {KERNEL_TYPE_AICPU, "KERNEL_TYPE_AICPU"},
        {KERNEL_TYPE_AICPU_CUSTOM, "KERNEL_TYPE_AICPU_CUSTOM"},
        {KERNEL_TYPE_AICPU_KFC, "KERNEL_TYPE_AICPU_KFC"},
        {KERNEL_TYPE_CUSTOM_KFC, "KERNEL_TYPE_CUSTOM_KFC"},
        {KERNEL_TYPE_HWTS, "KERNEL_TYPE_HWTS"},
        {KERNEL_TYPE_RESERVED, "KERNEL_TYPE_RESERVED"},
    };
    return EnumValueDescription(value, names);
}

std::string DeviceFlagToString(const uint64_t value)
{
    if (value == RT_DEVICE_FLAG_DEFAULT) {
        return RtFmtMsg("RT_DEVICE_FLAG_DEFAULT(0x%" PRIX64 ")", value);
    }
    if (value == RT_DEVICE_FLAG_NOT_START_CPU_SCHED) {
        return RtFmtMsg("RT_DEVICE_FLAG_NOT_START_CPU_SCHED(0x%" PRIX64 ")", value);
    }
    return RtFmtMsg("UNKNOWN(%" PRIu64 ")", value);
}

std::string MemInfoQueryTypeToString(const uint32_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_MEM_INFO_TYPE_DDR_SIZE, "RT_MEM_INFO_TYPE_DDR_SIZE", true},
        {RT_MEM_INFO_TYPE_HBM_SIZE, "RT_MEM_INFO_TYPE_HBM_SIZE", true},
        {RT_MEM_INFO_TYPE_DDR_P2P_SIZE, "RT_MEM_INFO_TYPE_DDR_P2P_SIZE", true},
        {RT_MEM_INFO_TYPE_HBM_P2P_SIZE, "RT_MEM_INFO_TYPE_HBM_P2P_SIZE", true},
        {RT_MEM_INFO_TYPE_ADDR_CHECK, "RT_MEM_INFO_TYPE_ADDR_CHECK", true},
        {RT_MEM_INFO_TYPE_CTRL_NUMA_INFO, "RT_MEM_INFO_TYPE_CTRL_NUMA_INFO", true},
        {RT_MEM_INFO_TYPE_AI_NUMA_INFO, "RT_MEM_INFO_TYPE_AI_NUMA_INFO", true},
        {RT_MEM_INFO_TYPE_BAR_NUMA_INFO, "RT_MEM_INFO_TYPE_BAR_NUMA_INFO", true},
        {RT_MEM_INFO_TYPE_SVM_GRP_INFO, "RT_MEM_INFO_TYPE_SVM_GRP_INFO", true},
        {RT_MEM_INFO_TYPE_UB_TOKEN_INFO, "RT_MEM_INFO_TYPE_UB_TOKEN_INFO", true},
        {RT_MEM_INFO_TYPE_SYS_NUMA_INFO, "RT_MEM_INFO_TYPE_SYS_NUMA_INFO", true},
        {RT_MEM_INFO_TYPE_MAX, "RT_MEM_INFO_TYPE_MAX", true},
    };
    return EnumValueDescription(value, names);
}

std::string GeneralCtrlValueToString(const uint32_t value)
{
    if (value < static_cast<uint32_t>(RT_GNL_CTRL_TYPE_MAX)) {
        return GnlCtrlTypeToString(static_cast<rtGeneralCtrlType_t>(value));
    }
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_GNL_CTRL_TYPE_MAX, "RT_GNL_CTRL_TYPE_MAX"},
    };
    return EnumValueDescription(value, names);
}

std::string FloatOverflowValueToString(const uint32_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_OVERFLOW_MODE_SATURATION, "RT_OVERFLOW_MODE_SATURATION"},
        {RT_OVERFLOW_MODE_INFNAN, "RT_OVERFLOW_MODE_INFNAN"},
        {RT_OVERFLOW_MODE_UNDEF, "RT_OVERFLOW_MODE_UNDEF"},
    };
    return EnumValueDescription(value, names);
}

std::string ContextFlagToString(const uint64_t value)
{
    if (value == static_cast<uint64_t>(RT_CONTEXT_NORMAL_MODE)) {
        return RtFmtMsg("RT_CONTEXT_NORMAL_MODE(%" PRIu64 ")", value);
    }
    return RtFmtMsg("UNKNOWN(%" PRIu64 ")", value);
}

std::string StreamDestroyFlagToString(const uint64_t value)
{
    if (value == RT_STREAM_DESTORY_FLAG_DEFAULT) {
        return RtFmtMsg("RT_STREAM_DESTORY_FLAG_DEFAULT(0x%" PRIX64 ")", value);
    }
    if (value == RT_STREAM_DESTORY_FLAG_FORCE) {
        return RtFmtMsg("RT_STREAM_DESTORY_FLAG_FORCE(0x%" PRIX64 ")", value);
    }
    return RtFmtMsg("UNKNOWN(%" PRIu64 ")", value);
}

std::string ModelStreamFlagToString(const int64_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_MODEL_STREAM_FLAG_HEAD, "RT_MODEL_STREAM_FLAG_HEAD", true},
        {RT_MODEL_STREAM_FLAG_DEFAULT, "RT_MODEL_STREAM_FLAG_DEFAULT", true},
    };
    return EnumValueDescription(value, names);
}

std::string DqsSchedTypeToString(const int64_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_DQS_SCHED_TYPE_NN, "RT_DQS_SCHED_TYPE_NN"},
        {RT_DQS_SCHED_TYPE_VPC, "RT_DQS_SCHED_TYPE_VPC"},
        {RT_DQS_SCHED_TYPE_DSS, "RT_DQS_SCHED_TYPE_DSS"},
    };
    return EnumValueDescription(value, names);
}

std::string CoreTypeToString(const int64_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_CORE_TYPE_AIC, "RT_CORE_TYPE_AIC"},
        {RT_CORE_TYPE_AIV, "RT_CORE_TYPE_AIV"},
    };
    return EnumValueDescription(value, names);
}

std::string ShapeFlagToString(const int64_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_STATIC_SHAPE_KERNEL, "RT_STATIC_SHAPE_KERNEL", true},
        {RT_DYNAMIC_SHAPE_KERNEL, "RT_DYNAMIC_SHAPE_KERNEL", true},
    };
    return EnumValueDescription(value, names);
}

std::string SchedModeToString(const int64_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_SCHEM_MODE_NORMAL, "RT_SCHEM_MODE_NORMAL"},
        {RT_SCHEM_MODE_BATCH, "RT_SCHEM_MODE_BATCH"},
        {RT_SCHEM_MODE_END, "RT_SCHEM_MODE_END"},
    };
    return EnumValueDescription(value, names);
}

std::string ModuleTypeToString(const int64_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_MODULE_TYPE_SYSTEM, "RT_MODULE_TYPE_SYSTEM"},
        {RT_MODULE_TYPE_AICPU, "RT_MODULE_TYPE_AICPU"},
        {RT_MODULE_TYPE_CCPU, "RT_MODULE_TYPE_CCPU"},
        {RT_MODULE_TYPE_DCPU, "RT_MODULE_TYPE_DCPU"},
        {RT_MODULE_TYPE_AICORE, "RT_MODULE_TYPE_AICORE"},
        {RT_MODULE_TYPE_TSCPU, "RT_MODULE_TYPE_TSCPU"},
        {RT_MODULE_TYPE_PCIE, "RT_MODULE_TYPE_PCIE"},
        {RT_MODULE_TYPE_VECTOR_CORE, "RT_MODULE_TYPE_VECTOR_CORE"},
        {RT_MODULE_TYPE_HOST_AICPU, "RT_MODULE_TYPE_HOST_AICPU"},
        {RT_MODULE_TYPE_QOS, "RT_MODULE_TYPE_QOS"},
        {RT_MODULE_TYPE_MEMORY, "RT_MODULE_TYPE_MEMORY"},
    };
    return EnumValueDescription(value, names);
}

std::string IpcMemAttrTypeToString(const int64_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_ATTR_TYPE_MEM_MAP, "RT_ATTR_TYPE_MEM_MAP"},
        {RT_ATTR_TYPE_MAX, "RT_ATTR_TYPE_MAX"},
    };
    return EnumValueDescription(value, names);
}

std::string IpcMemAttrToString(const uint64_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_IPC_MEM_ATTR_SIO, "RT_IPC_MEM_ATTR_SIO"},
        {RT_IPC_MEM_ATTR_HCCS, "RT_IPC_MEM_ATTR_HCCS"},
        {RT_IPC_MEM_ATTR_UB_ONE_PORT_PATH, "RT_IPC_MEM_ATTR_UB_ONE_PORT_PATH"},
        {RT_IPC_MEM_ATTR_UB_MULTI_PORT_PATH, "RT_IPC_MEM_ATTR_UB_MULTI_PORT_PATH"},
        {RT_IPC_MEM_ATTR_MAX, "RT_IPC_MEM_ATTR_MAX"},
    };
    for (const auto& item : names) {
        if (value == item.value) {
            return NamedValueDescription(item);
        }
    }
    return RtFmtMsg("UNKNOWN(%" PRIu64 ")", value);
}

std::string ModelAttrToString(const int64_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_MODEL_ATTR_SCH_MODE, "RT_MODEL_ATTR_SCH_MODE"},
        {RT_MODEL_ATTR_BUFF, "RT_MODEL_ATTR_BUFF"},
    };
    return EnumValueDescription(value, names);
}

std::string ModelSchedModeToString(const int64_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_MDL_SCH_DEFAULT, "RT_MDL_SCH_DEFAULT"},
        {RT_MDL_SCH_EXCLUSIVE, "RT_MDL_SCH_EXCLUSIVE"},
    };
    return EnumValueDescription(value, names);
}

std::string ModelExecutorToString(const int64_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {EXECUTOR_NONE, "EXECUTOR_NONE", true},
        {EXECUTOR_TS, "EXECUTOR_TS", true},
        {EXECUTOR_AICPU, "EXECUTOR_AICPU", true},
    };
    return EnumValueDescription(value, names);
}

std::string AclEventWaitFlagToString(const uint32_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_EVENT_WAIT_DEFAULT, "ACL_EVENT_WAIT_DEFAULT"},
        {RT_EVENT_WAIT_EXTERNAL, "ACL_EVENT_WAIT_EXTERNAL"},
    };
    return EnumValueDescription(value, names);
}

std::string AclEventRecordFlagToString(const uint32_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_EVENT_RECORD_DEFAULT, "ACL_EVENT_RECORD_DEFAULT"},
        {RT_EVENT_RECORD_EXTERNAL, "ACL_EVENT_RECORD_EXTERNAL"},
    };
    return EnumValueDescription(value, names);
}

std::string RtEventRecordFlagToString(const uint32_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_EVENT_RECORD_DEFAULT, "RT_EVENT_RECORD_DEFAULT", true},
        {RT_EVENT_RECORD_EXTERNAL, "RT_EVENT_RECORD_EXTERNAL", true},
    };
    return EnumValueDescription(value, names);
}

std::string NotifyExportFlagToString(const int64_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_NOTIFY_FLAG_DEFAULT, "RT_NOTIFY_FLAG_DEFAULT", true},
        {RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION, "RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION", true},
    };
    return EnumValueDescription(value, names);
}

std::string MemoryPolicyToString(const uint64_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_MEMORY_POLICY_NONE, "RT_MEMORY_POLICY_NONE", true},
        {RT_MEMORY_POLICY_HUGE_PAGE_FIRST, "RT_MEMORY_POLICY_HUGE_PAGE_FIRST", true},
        {RT_MEMORY_POLICY_HUGE_PAGE_ONLY, "RT_MEMORY_POLICY_HUGE_PAGE_ONLY", true},
        {RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY, "RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY", true},
        {RT_MEMORY_POLICY_HUGE_PAGE_FIRST_P2P, "RT_MEMORY_POLICY_HUGE_PAGE_FIRST_P2P", true},
        {RT_MEMORY_POLICY_HUGE_PAGE_ONLY_P2P, "RT_MEMORY_POLICY_HUGE_PAGE_ONLY_P2P", true},
        {RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P, "RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P", true},
        {RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY, "RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY", true},
        {RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY_P2P, "RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY_P2P", true},
    };
    for (const auto& item : names) {
        if (value == item.value) {
            return NamedValueDescription(item);
        }
    }
    return RtFmtMsg("UNKNOWN(%" PRIu64 ")", value);
}

std::string BinaryMetaTypeToString(const int64_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_BINARY_TYPE_BIN_VERSION, "RT_BINARY_TYPE_BIN_VERSION"},
        {RT_BINARY_TYPE_DEBUG_INFO, "RT_BINARY_TYPE_DEBUG_INFO"},
        {RT_BINARY_TYPE_DYNAMIC_PARAM, "RT_BINARY_TYPE_DYNAMIC_PARAM"},
        {RT_BINARY_TYPE_OPTIONAL_PARAM, "RT_BINARY_TYPE_OPTIONAL_PARAM"},
        {RT_BINARY_TYPE_RUNTIME_IMPLICIT_INFO, "RT_BINARY_TYPE_RUNTIME_IMPLICIT_INFO"},
        {RT_BINARY_TYPE_SK_INFO, "RT_BINARY_TYPE_SK_INFO"},
        {RT_BINARY_TYPE_SPECIALIZATION_RESOURCE_ID, "RT_BINARY_TYPE_SPECIALIZATION_RESOURCE_ID"},
        {RT_BINARY_TYPE_ICACHE_PRELOAD_FLAG, "RT_BINARY_TYPE_ICACHE_PRELOAD_FLAG"},
        {RT_BINARY_TYPE_MAX, "RT_BINARY_TYPE_MAX"},
    };
    return EnumValueDescription(value, names);
}

std::string StackTypeToString(const int64_t value)
{
    static constexpr std::initializer_list<ErrMsgNamedValue> names = {
        {RT_STACK_TYPE_SCALAR, "RT_STACK_TYPE_SCALAR"},
        {RT_STACK_TYPE_SIMT, "RT_STACK_TYPE_SIMT"},
    };
    return EnumValueDescription(value, names);
}

} // namespace runtime
} // namespace cce
