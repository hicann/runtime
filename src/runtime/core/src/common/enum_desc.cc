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
#include "mem_type.hpp"
#include "task_enum_desc.hpp"
#include "securec.h"
#include "elf.hpp"
#include "runtime.hpp"

namespace cce {
namespace runtime {

std::string DataTypeToString(const rtDataType_t type)
{
    std::string desc;
    switch (type) {
        case RT_DATA_TYPE_FP32:
            desc = "DATA_TYPE_FP32(0)";
            break;
        case RT_DATA_TYPE_FP16:
            desc = "DATA_TYPE_FP16(1)";
            break;
        case RT_DATA_TYPE_INT16:
            desc = "DATA_TYPE_INT16(2)";
            break;
        case RT_DATA_TYPE_INT4:
            desc = "DATA_TYPE_INT4(3)";
            break;
        case RT_DATA_TYPE_INT8:
            desc = "DATA_TYPE_INT8(4)";
            break;
        case RT_DATA_TYPE_INT32:
            desc = "DATA_TYPE_INT32(5)";
            break;
        case RT_DATA_TYPE_BFP16:
            desc = "DATA_TYPE_BFP16(6)";
            break;
        case RT_DATA_TYPE_BFP32:
            desc = "DATA_TYPE_BFP32(7)";
            break;
        case RT_DATA_TYPE_UINT8:
            desc = "DATA_TYPE_UINT8(8)";
            break;
        case RT_DATA_TYPE_UINT16:
            desc = "DATA_TYPE_UINT16(9)";
            break;
        case RT_DATA_TYPE_UINT32:
            desc = "DATA_TYPE_UINT32(10)";
            break;
        case RT_DATA_TYPE_END:
            desc = "DATA_TYPE_END(11)";
            break;
        default:
            desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(type));
            break;
    }
    return desc;
}

std::string MemInfoTypeToString(const rtMemInfoType_t memInfoType)
{
    std::string desc;
    switch (memInfoType) {
        case RT_MEMORYINFO_DDR:
            desc = "MEMORYINFO_DDR(0)";
            break;
        case RT_MEMORYINFO_HBM:
            desc = "MEMORYINFO_HBM(1)";
            break;
        case RT_MEMORYINFO_DDR_HUGE:
            desc = "MEMORYINFO_DDR_HUGE(2)";
            break;
        case RT_MEMORYINFO_DDR_NORMAL:
            desc = "MEMORYINFO_DDR_NORMAL(3)";
            break;
        case RT_MEMORYINFO_HBM_HUGE:
            desc = "MEMORYINFO_HBM_HUGE(4)";
            break;
        case RT_MEMORYINFO_HBM_NORMAL:
            desc = "MEMORYINFO_HBM_NORMAL(5)";
            break;
        case RT_MEMORYINFO_DDR_P2P_HUGE:
            desc = "MEMORYINFO_DDR_P2P_HUGE(6)";
            break;
        case RT_MEMORYINFO_DDR_P2P_NORMAL:
            desc = "MEMORYINFO_DDR_P2P_NORMAL(7)";
            break;
        case RT_MEMORYINFO_HBM_P2P_HUGE:
            desc = "MEMORYINFO_HBM_P2P_HUGE(8)";
            break;
        case RT_MEMORYINFO_HBM_P2P_NORMAL:
            desc = "MEMORYINFO_HBM_P2P_NORMAL(9)";
            break;
        case RT_MEMORYINFO_HBM_HUGE1G:
            desc = "MEMORYINFO_HBM_HUGE1G(10)";
            break;
        case RT_MEMORYINFO_HBM_P2P_HUGE1G:
            desc = "MEMORYINFO_HBM_P2P_HUGE1G(11)";
            break;
        case RT_MEMORYINFO_NORMAL:
            desc = "MEMORYINFO_NORMAL(12)";
            break;
        case RT_MEMORYINFO_HUGE:
            desc = "MEMORYINFO_HUGE(13)";
            break;
        case RT_MEMORYINFO_HUGE1G:
            desc = "MEMORYINFO_HUGE1G(14)";
            break;
        case RT_MEMORYINFO_P2P_NORMAL:
            desc = "MEMORYINFO_P2P_NORMAL(15)";
            break;
        case RT_MEMORYINFO_P2P_HUGE:
            desc = "MEMORYINFO_P2P_HUGE(16)";
            break;
        case RT_MEMORYINFO_P2P_HUGE1G:
            desc = "MEMORYINFO_P2P_HUGE1G(17)";
            break;
        default:
            desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(memInfoType));
            break;
    }
    return desc;
}

const char_t* DrvMemHandleTypeToString(const rtDrvMemHandleType type)
{
    switch (type) {
        case RT_MEM_HANDLE_TYPE_NONE:
            return "MEM_HANDLE_TYPE_NONE(0)";
        case RT_MEM_HANDLE_TYPE_POSIX:
            return "MEM_HANDLE_TYPE_POSIX(2)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char_t* MemSharedHandleTypeToString(const rtMemSharedHandleType type)
{
    switch (type) {
        case RT_MEM_SHARE_HANDLE_TYPE_DEFAULT:
            return "MEM_SHARE_HANDLE_TYPE_DEFAULT(1)";
        case RT_MEM_SHARE_HANDLE_TYPE_FABRIC:
            return "MEM_SHARE_HANDLE_TYPE_FABRIC(2)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char_t* MallocAttrToString(const rtMallocAttr attr)
{
    switch (attr) {
        case RT_MEM_MALLOC_ATTR_RSV:
            return "MEM_MALLOC_ATTR_RSV(0)";
        case RT_MEM_MALLOC_ATTR_MODULE_ID:
            return "MEM_MALLOC_ATTR_MODULE_ID(1)";
        case RT_MEM_MALLOC_ATTR_DEVICE_ID:
            return "MEM_MALLOC_ATTR_DEVICE_ID(2)";
        case RT_MEM_MALLOC_ATTR_VA_FLAG:
            return "MEM_MALLOC_ATTR_VA_FLAG(3)";
        case RT_MEM_MALLOC_ATTR_MAX:
            return "MEM_MALLOC_ATTR_MAX(4)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(attr));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

const char_t* FloatOverflowModeToString(const rtFloatOverflowMode_t mode)
{
    switch (mode) {
        case RT_OVERFLOW_MODE_SATURATION:
            return "OVERFLOW_MODE_SATURATION(0)";
        case RT_OVERFLOW_MODE_INFNAN:
            return "OVERFLOW_MODE_INFNAN(1)";
        case RT_OVERFLOW_MODE_UNDEF:
            return "OVERFLOW_MODE_UNDEF(2)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(mode));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

std::string MemLocationTypeToString(const rtMemLocationType type) { return MemLocationTypeToStr(type); }

std::string LimitTypeToString(const rtLimitType_t type)
{
    switch (type) {
        case RT_LIMIT_TYPE_LOW_POWER_TIMEOUT:
            return "LIMIT_TYPE_LOW_POWER_TIMEOUT(0)";
        case RT_LIMIT_TYPE_SIMT_STACK_SIZE:
            return "LIMIT_TYPE_SIMT_STACK_SIZE(1)";
        case RT_LIMIT_TYPE_SIMT_DVG_WARP_STACK_SIZE:
            return "LIMIT_TYPE_SIMT_DVG_WARP_STACK_SIZE(2)";
        case RT_LIMIT_TYPE_STACK_SIZE:
            return "LIMIT_TYPE_STACK_SIZE(3)";
        case RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE:
            return "LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE(4)";
        case RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE:
            return "LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE(5)";
        case RT_LIMIT_TYPE_RESERVED:
            return "LIMIT_TYPE_RESERVED(6)";
        default:
            return RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(type));
    }
}

const char_t* DevResLimitTypeToString(const rtDevResLimitType_t type)
{
    switch (type) {
        case RT_DEV_RES_CUBE_CORE:
            return "DEV_RES_CUBE_CORE(0)";
        case RT_DEV_RES_VECTOR_CORE:
            return "DEV_RES_VECTOR_CORE(1)";
        case RT_DEV_RES_TYPE_MAX:
            return "DEV_RES_TYPE_MAX(2)";
        default:
            break;
    }
    static thread_local char enumBuf[32];
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(type));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

std::string ConditionToString(const rtCondition_t condition)
{
    switch (condition) {
        case RT_EQUAL:
            return "EQUAL(0)";
        case RT_NOT_EQUAL:
            return "NOT_EQUAL(1)";
        case RT_GREATER:
            return "GREATER(2)";
        case RT_GREATER_OR_EQUAL:
            return "GREATER_OR_EQUAL(3)";
        case RT_LESS:
            return "LESS(4)";
        case RT_LESS_OR_EQUAL:
            return "LESS_OR_EQUAL(5)";
        default:
            return RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(condition));
    }
}

std::string KernelFuncTypeToString(const uint32_t funcType)
{
    switch (funcType) {
        case KERNEL_FUNCTION_TYPE_INVALID:
            return "KERNEL_FUNCTION_TYPE_INVALID(0)";
        case KERNEL_FUNCTION_TYPE_AICORE:
            return "KERNEL_FUNCTION_TYPE_AICORE(1)";
        case KERNEL_FUNCTION_TYPE_AIC:
            return "KERNEL_FUNCTION_TYPE_AIC(2)";
        case KERNEL_FUNCTION_TYPE_AIV:
            return "KERNEL_FUNCTION_TYPE_AIV(3)";
        case KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN:
            return "KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN(4)";
        case KERNEL_FUNCTION_TYPE_MIX_AIV_MAIN:
            return "KERNEL_FUNCTION_TYPE_MIX_AIV_MAIN(5)";
        case KERNEL_FUNCTION_TYPE_AIC_ROLLBACK:
            return "KERNEL_FUNCTION_TYPE_AIC_ROLLBACK(6)";
        case KERNEL_FUNCTION_TYPE_AIV_ROLLBACK:
            return "KERNEL_FUNCTION_TYPE_AIV_ROLLBACK(7)";
        case KERNEL_FUNCTION_TYPE_MAX:
            return "KERNEL_FUNCTION_TYPE_MAX(8)";
        default:
            return RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(funcType));
    }
}

std::string KernelMixTypeToString(const uint8_t mixType)
{
    switch (mixType) {
        case NO_MIX:
            return "NO_MIX(0)";
        case MIX_AIC:
            return "MIX_AIC(1)";
        case MIX_AIV:
            return "MIX_AIV(2)";
        case MIX_AIC_AIV_MAIN_AIC:
            return "MIX_AIC_AIV_MAIN_AIC(3)";
        case MIX_AIC_AIV_MAIN_AIV:
            return "MIX_AIC_AIV_MAIN_AIV(4)";
        default:
            return RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(mixType));
    }
}

std::string KernelAttrTypeToString(const rtKernelAttrType type)
{
    switch (type) {
        case RT_KERNEL_ATTR_TYPE_AICORE:
            return "KERNEL_ATTR_TYPE_AICORE(0)";
        case RT_KERNEL_ATTR_TYPE_CUBE:
            return "KERNEL_ATTR_TYPE_CUBE(1)";
        case RT_KERNEL_ATTR_TYPE_VECTOR:
            return "KERNEL_ATTR_TYPE_VECTOR(2)";
        case RT_KERNEL_ATTR_TYPE_MIX:
            return "KERNEL_ATTR_TYPE_MIX(3)";
        case RT_KERNEL_ATTR_TYPE_AICPU:
            return "KERNEL_ATTR_TYPE_AICPU(100)";
        default:
            return RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(type));
    }
}

std::string LaunchKernelAttrIdToString(const rtLaunchKernelAttrId id)
{
    switch (id) {
        case RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE:
            return "LAUNCH_KERNEL_ATTR_SCHEM_MODE(1)";
        case RT_LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE:
            return "LAUNCH_KERNEL_ATTR_DYN_UBUF_SIZE(2)";
        case RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE:
            return "LAUNCH_KERNEL_ATTR_ENGINE_TYPE(3)";
        case RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET:
            return "LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET(4)";
        case RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH:
            return "LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH(5)";
        case RT_LAUNCH_KERNEL_ATTR_DATA_DUMP:
            return "LAUNCH_KERNEL_ATTR_DATA_DUMP(6)";
        case RT_LAUNCH_KERNEL_ATTR_TIMEOUT:
            return "LAUNCH_KERNEL_ATTR_TIMEOUT(7)";
        case RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US:
            return "LAUNCH_KERNEL_ATTR_TIMEOUT_US(8)";
        case RT_LAUNCH_KERNEL_ATTR_MAX:
            return "LAUNCH_KERNEL_ATTR_MAX(9)";
        default:
            return RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(id));
    }
}

const char_t* DevAttrToString(const rtDevAttr attr)
{
    static thread_local char enumBuf[32];
    switch (attr) {
        case RT_DEV_ATTR_AICPU_CORE_NUM:
            return "DEV_ATTR_AICPU_CORE_NUM(1)";
        case RT_DEV_ATTR_AICORE_CORE_NUM:
            return "DEV_ATTR_AICORE_CORE_NUM(101)";
        case RT_DEV_ATTR_CUBE_CORE_NUM:
            return "DEV_ATTR_CUBE_CORE_NUM(102)";
        case RT_DEV_ATTR_VECTOR_CORE_NUM:
            return "DEV_ATTR_VECTOR_CORE_NUM(201)";
        case RT_DEV_ATTR_WARP_SIZE:
            return "DEV_ATTR_WARP_SIZE(202)";
        case RT_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE:
            return "DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE(203)";
        case RT_DEV_ATTR_UBUF_PER_VECTOR_CORE:
            return "DEV_ATTR_UBUF_PER_VECTOR_CORE(204)";
        case RT_DEV_ATTR_MAX_GRID_DIM_X:
            return "DEV_ATTR_MAX_GRID_DIM_X(205)";
        case RT_DEV_ATTR_MAX_GRID_DIM_Y:
            return "DEV_ATTR_MAX_GRID_DIM_Y(206)";
        case RT_DEV_ATTR_MAX_GRID_DIM_Z:
            return "DEV_ATTR_MAX_GRID_DIM_Z(207)";
        case RT_DEV_ATTR_MAX_BLOCK_PER_GRID:
            return "DEV_ATTR_MAX_BLOCK_PER_GRID(208)";
        case RT_DEV_ATTR_MAX_THREADS_PER_BLOCK:
            return "DEV_ATTR_MAX_THREADS_PER_BLOCK(209)";
        case RT_DEV_ATTR_MAX_BLOCK_DIM_X:
            return "DEV_ATTR_MAX_BLOCK_DIM_X(210)";
        case RT_DEV_ATTR_MAX_BLOCK_DIM_Y:
            return "DEV_ATTR_MAX_BLOCK_DIM_Y(211)";
        case RT_DEV_ATTR_MAX_BLOCK_DIM_Z:
            return "DEV_ATTR_MAX_BLOCK_DIM_Z(212)";
        case RT_DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE:
            return "DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE(301)";
        case RT_DEV_ATTR_L2_CACHE_SIZE:
            return "DEV_ATTR_L2_CACHE_SIZE(302)";
        case RT_DEV_ATTR_SMP_ID:
            return "DEV_ATTR_SMP_ID(401)";
        case RT_DEV_ATTR_PHY_CHIP_ID:
            return "DEV_ATTR_PHY_CHIP_ID(402)";
        case RT_DEV_ATTR_SUPER_POD_DEVICE_ID:
            return "DEV_ATTR_SUPER_POD_DEVICE_ID(403)";
        case RT_DEV_ATTR_SUPER_POD_SERVER_ID:
            return "DEV_ATTR_SUPER_POD_SERVER_ID(404)";
        case RT_DEV_ATTR_SUPER_POD_ID:
            return "DEV_ATTR_SUPER_POD_ID(405)";
        case RT_DEV_ATTR_CUST_OP_PRIVILEGE:
            return "DEV_ATTR_CUST_OP_PRIVILEGE(406)";
        case RT_DEV_ATTR_MAINBOARD_ID:
            return "DEV_ATTR_MAINBOARD_ID(407)";
        case RT_DEV_ATTR_HD_CONNECT_TYPE:
            return "DEV_ATTR_HD_CONNECT_TYPE(408)";
        case RT_DEV_ATTR_DEVICE_FORM_FACTOR:
            return "DEV_ATTR_DEVICE_FORM_FACTOR(409)";
        case RT_DEV_ATTR_IS_VIRTUAL:
            return "DEV_ATTR_IS_VIRTUAL(501)";
        case RT_DEV_ATTR_NPU_ARCH:
            return "DEV_ATTR_NPU_ARCH(601)";
        case RT_DEV_ATTR_MAX:
            (void)snprintf_s(
                enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "DEV_ATTR_MAX(%d)",
                static_cast<int32_t>(RT_DEV_ATTR_MAX));
            enumBuf[sizeof(enumBuf) - 1U] = '\0';
            return enumBuf;
        default:
            break;
    }
    (void)snprintf_s(enumBuf, sizeof(enumBuf), sizeof(enumBuf) - 1, "UNKNOWN(%d)", static_cast<int32_t>(attr));
    enumBuf[sizeof(enumBuf) - 1U] = '\0';
    return enumBuf;
}

std::string HacTypeToString(const rtHacType type)
{
    switch (type) {
        case RT_HAC_TYPE_STARS:
            return "HAC_TYPE_STARS(0)";
        case RT_HAC_TYPE_AICPU:
            return "HAC_TYPE_AICPU(1)";
        case RT_HAC_TYPE_AIC:
            return "HAC_TYPE_AIC(2)";
        case RT_HAC_TYPE_AIV:
            return "HAC_TYPE_AIV(3)";
        case RT_HAC_TYPE_PCIEDMA:
            return "HAC_TYPE_PCIEDMA(4)";
        case RT_HAC_TYPE_RDMA:
            return "HAC_TYPE_RDMA(5)";
        case RT_HAC_TYPE_SDMA:
            return "HAC_TYPE_SDMA(6)";
        case RT_HAC_TYPE_DVPP:
            return "HAC_TYPE_DVPP(7)";
        case RT_HAC_TYPE_UDMA:
            return "HAC_TYPE_UDMA(8)";
        case RT_HAC_TYPE_CCU:
            return "HAC_TYPE_CCU(9)";
        case RT_HAC_TYPE_MAX:
            return "HAC_TYPE_MAX(10)";
        default:
            return RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(type));
    }
}

std::string DeviceStatusToString(const rtDeviceStatus status)
{
    switch (status) {
        case RT_DEVICE_STATUS_NORMAL:
            return "DEVICE_STATUS_NORMAL(0)";
        case RT_DEVICE_STATUS_ABNORMAL:
            return "DEVICE_STATUS_ABNORMAL(1)";
        case RT_DEVICE_STATUS_END:
            return "DEVICE_STATUS_END(65535)";
        default:
            return RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(status));
    }
}

std::string TaskTypeToString(const rtTaskType type)
{
    switch (type) {
        case RT_TASK_DEFAULT:
            return "TASK_DEFAULT(0)";
        case RT_TASK_KERNEL:
            return "TASK_KERNEL(1)";
        case RT_TASK_EVENT_RECORD:
            return "TASK_EVENT_RECORD(2)";
        case RT_TASK_EVENT_WAIT:
            return "TASK_EVENT_WAIT(3)";
        case RT_TASK_EVENT_RESET:
            return "TASK_EVENT_RESET(4)";
        case RT_TASK_VALUE_WRITE:
            return "TASK_VALUE_WRITE(5)";
        case RT_TASK_VALUE_WAIT:
            return "TASK_VALUE_WAIT(6)";
        default:
            return RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(type));
    }
}

} // namespace runtime
} // namespace cce
