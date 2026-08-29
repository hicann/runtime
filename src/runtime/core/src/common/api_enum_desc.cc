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
#include "device_enum_desc.hpp"
#include "securec.h"

namespace cce {
namespace runtime {

const char_t* ChipTypeToName(const rtChipType_t type)
{
    if (type >= CHIP_EXT_BEGIN) {
        switch (type) {
            case CHIP_X90:
                return "CHIP_X90";
            case CHIP_9030:
                return "CHIP_9030";
            case CHIP_DEV_0000:
                return "CHIP_DEV_0000";
            case CHIP_DEV_0001:
                return "CHIP_DEV_0001";
            case CHIP_DEV_0002:
                return "CHIP_DEV_0002";
            case CHIP_DEV_0003:
                return "CHIP_DEV_0003";
            default:
                return "UNKNOWN";
        }
    }
    switch (type) {
        case CHIP_MINI:
            return "CHIP_MINI";
        case CHIP_CLOUD:
            return "CHIP_CLOUD";
        case CHIP_ADC:
            return "CHIP_ADC";
        case CHIP_LHISI:
            return "CHIP_LHISI";
        case CHIP_DC:
            return "CHIP_DC";
        case CHIP_910_B_93:
            return "CHIP_910_B_93";
        case CHIP_NO_DEVICE:
            return "CHIP_NO_DEVICE";
        case CHIP_MINI_V3:
            return "CHIP_MINI_V3";
        case CHIP_ASCEND_031:
            return "CHIP_ASCEND_031";
        case CHIP_NANO:
            return "CHIP_NANO";
        case CHIP_RESERVED:
            return "CHIP_RESERVED";
        case CHIP_AS31XM1:
            return "CHIP_AS31XM1";
        case CHIP_610LITE:
            return "CHIP_610LITE";
        case CHIP_CLOUD_V3:
            return "CHIP_CLOUD_V3";
        case CHIP_BS9SX1A:
            return "CHIP_BS9SX1A";
        case CHIP_DAVID:
            return "CHIP_DAVID";
        case CHIP_CLOUD_V5:
            return "CHIP_CLOUD_V5";
        case CHIP_MC62CM12A:
            return "CHIP_MC62CM12A";
        case CHIP_MC32DM11A:
            return "CHIP_MC32DM11A";
        case CHIP_ASCEND_350:
            return "CHIP_ASCEND_350";
        case CHIP_XPU:
            return "CHIP_XPU";
        case CHIP_5162A:
            return "CHIP_5162A";
        default:
            return "UNKNOWN";
    }
}

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

} // namespace runtime
} // namespace cce
