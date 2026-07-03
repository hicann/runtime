/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_ENUM_DESC_HPP
#define CCE_RUNTIME_ENUM_DESC_HPP

#include <cstdint>
#include <string>
#include "runtime/config.h"
#include "runtime/mem_base.h"
#include "runtime/mem.h"
#include "runtime/rt_external_mem.h"
#include "runtime/rt_external_stream.h"
#include "runtime/rt_external_stars.h"
#include "runtime/rts/rts_stars.h"
#include "runtime/kernel.h"
#include "rt_log.h"

namespace cce {
namespace runtime {

static inline std::string ReduceKindToString(const rtRecudeKind_t kind)
{
    std::string desc;
    switch (kind) {
        case RT_MEMCPY_SDMA_AUTOMATIC_ADD: desc = "MEMCPY_SDMA_AUTOMATIC_ADD(10)"; break;
        case RT_MEMCPY_SDMA_AUTOMATIC_MAX: desc = "MEMCPY_SDMA_AUTOMATIC_MAX(11)"; break;
        case RT_MEMCPY_SDMA_AUTOMATIC_MIN: desc = "MEMCPY_SDMA_AUTOMATIC_MIN(12)"; break;
        case RT_MEMCPY_SDMA_AUTOMATIC_EQUAL: desc = "MEMCPY_SDMA_AUTOMATIC_EQUAL(13)"; break;
        case RT_RECUDE_KIND_END: desc = "RECUDE_KIND_END(14)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(kind)); break;
    }
    return desc;
}

static inline std::string DataTypeToString(const rtDataType_t type)
{
    std::string desc;
    switch (type) {
        case RT_DATA_TYPE_FP32: desc = "DATA_TYPE_FP32(0)"; break;
        case RT_DATA_TYPE_FP16: desc = "DATA_TYPE_FP16(1)"; break;
        case RT_DATA_TYPE_INT16: desc = "DATA_TYPE_INT16(2)"; break;
        case RT_DATA_TYPE_INT4: desc = "DATA_TYPE_INT4(3)"; break;
        case RT_DATA_TYPE_INT8: desc = "DATA_TYPE_INT8(4)"; break;
        case RT_DATA_TYPE_INT32: desc = "DATA_TYPE_INT32(5)"; break;
        case RT_DATA_TYPE_BFP16: desc = "DATA_TYPE_BFP16(6)"; break;
        case RT_DATA_TYPE_BFP32: desc = "DATA_TYPE_BFP32(7)"; break;
        case RT_DATA_TYPE_UINT8: desc = "DATA_TYPE_UINT8(8)"; break;
        case RT_DATA_TYPE_UINT16: desc = "DATA_TYPE_UINT16(9)"; break;
        case RT_DATA_TYPE_UINT32: desc = "DATA_TYPE_UINT32(10)"; break;
        case RT_DATA_TYPE_END: desc = "DATA_TYPE_END(11)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(type)); break;
    }
    return desc;
}

static inline std::string KernelFlagToString(const uint32_t flag)
{
    std::string desc;
    switch (flag) {
        case RT_KERNEL_DEFAULT: desc = "KERNEL_DEFAULT(0)"; break;
        case RT_KERNEL_CONVERT: desc = "KERNEL_CONVERT(1)"; break;
        case RT_KERNEL_DUMPFLAG: desc = "KERNEL_DUMPFLAG(2)"; break;
        case RT_FUSION_KERNEL_DUMPFLAG: desc = "FUSION_KERNEL_DUMPFLAG(4)"; break;
        case RT_KERNEL_CUSTOM_AICPU: desc = "KERNEL_CUSTOM_AICPU(8)"; break;
        case RT_KERNEL_FFTSPLUS_DYNAMIC_SHAPE_DUMPFLAG: desc = "KERNEL_FFTSPLUS_DYNAMIC_SHAPE_DUMPFLAG(16)"; break;
        case RT_KERNEL_FFTSPLUS_STATIC_SHAPE_DUMPFLAG: desc = "KERNEL_FFTSPLUS_STATIC_SHAPE_DUMPFLAG(32)"; break;
        case RT_KERNEL_CMDLIST_NOT_FREE: desc = "KERNEL_CMDLIST_NOT_FREE(64)"; break;
        case RT_KERNEL_BIUPERF_FLAG: desc = "KERNEL_BIUPERF_FLAG(128)"; break;
        case RT_KERNEL_USE_SPECIAL_TIMEOUT: desc = "KERNEL_USE_SPECIAL_TIMEOUT(256)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%u)", static_cast<uint64_t>(flag)); break;
    }
    return desc;
}

static inline std::string LastErrLevelToString(const rtLastErrLevel_t level)
{
    std::string desc;
    switch (level) {
        case RT_THREAD_LEVEL: desc = "THREAD_LEVEL(0)"; break;
        case RT_CONTEXT_LEVEL: desc = "CONTEXT_LEVEL(1)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(level)); break;
    }
    return desc;
}

static inline std::string MemcpyKindToString(const rtMemcpyKind_t kind)
{
    std::string desc;
    switch (kind) {
        case RT_MEMCPY_HOST_TO_HOST: desc = "MEMCPY_HOST_TO_HOST(0)"; break;
        case RT_MEMCPY_HOST_TO_DEVICE: desc = "MEMCPY_HOST_TO_DEVICE(1)"; break;
        case RT_MEMCPY_DEVICE_TO_HOST: desc = "MEMCPY_DEVICE_TO_HOST(2)"; break;
        case RT_MEMCPY_DEVICE_TO_DEVICE: desc = "MEMCPY_DEVICE_TO_DEVICE(3)"; break;
        case RT_MEMCPY_MANAGED: desc = "MEMCPY_MANAGED(4)"; break;
        case RT_MEMCPY_ADDR_DEVICE_TO_DEVICE: desc = "MEMCPY_ADDR_DEVICE_TO_DEVICE(5)"; break;
        case RT_MEMCPY_HOST_TO_DEVICE_EX: desc = "MEMCPY_HOST_TO_DEVICE_EX(6)"; break;
        case RT_MEMCPY_DEVICE_TO_HOST_EX: desc = "MEMCPY_DEVICE_TO_HOST_EX(7)"; break;
        case RT_MEMCPY_DEFAULT: desc = "MEMCPY_DEFAULT(8)"; break;
        case RT_MEMCPY_RESERVED: desc = "MEMCPY_RESERVED(9)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(kind)); break;
    }
    return desc;
}

static inline std::string MemcpyNewKindToString(const rtMemcpyKind kind)
{
    std::string desc;
    switch (kind) {
        case RT_MEMCPY_KIND_HOST_TO_HOST: desc = "MEMCPY_KIND_HOST_TO_HOST(0)"; break;
        case RT_MEMCPY_KIND_HOST_TO_DEVICE: desc = "MEMCPY_KIND_HOST_TO_DEVICE(1)"; break;
        case RT_MEMCPY_KIND_DEVICE_TO_HOST: desc = "MEMCPY_KIND_DEVICE_TO_HOST(2)"; break;
        case RT_MEMCPY_KIND_DEVICE_TO_DEVICE: desc = "MEMCPY_KIND_DEVICE_TO_DEVICE(3)"; break;
        case RT_MEMCPY_KIND_DEFAULT: desc = "MEMCPY_KIND_DEFAULT(4)"; break;
        case RT_MEMCPY_KIND_HOST_TO_BUF_TO_DEVICE: desc = "MEMCPY_KIND_HOST_TO_BUF_TO_DEVICE(5)"; break;
        case RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE: desc = "MEMCPY_KIND_INNER_DEVICE_TO_DEVICE(6)"; break;
        case RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE: desc = "MEMCPY_KIND_INTER_DEVICE_TO_DEVICE(7)"; break;
        case RT_MEMCPY_KIND_MAX: desc = "MEMCPY_KIND_MAX(8)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(kind)); break;
    }
    return desc;
}

static inline std::string MemTypeToString(const rtMemType_t type)
{
    std::string desc;
    switch (type) {
        case RT_MEMORY_DEFAULT: desc = "MEMORY_DEFAULT(0)"; break;
        case RT_MEMORY_ATTACH_GLOBAL: desc = "MEMORY_ATTACH_GLOBAL(1)"; break;
        case RT_MEMORY_HBM: desc = "MEMORY_HBM(2)"; break;
        case RT_MEMORY_RDMA_HBM: desc = "MEMORY_RDMA_HBM(3)"; break;
        case RT_MEMORY_DDR: desc = "MEMORY_DDR(4)"; break;
        case RT_MEMORY_SPM: desc = "MEMORY_SPM(8)"; break;
        case RT_MEMORY_P2P_HBM: desc = "MEMORY_P2P_HBM(16)"; break;
        case RT_MEMORY_P2P_DDR: desc = "MEMORY_P2P_DDR(17)"; break;
        case RT_MEMORY_DDR_NC: desc = "MEMORY_DDR_NC(32)"; break;
        case RT_MEMORY_TS: desc = "MEMORY_TS(64)"; break;
        case RT_MEMORY_HOST: desc = "MEMORY_HOST(129)"; break;
        case RT_MEMORY_SVM: desc = "MEMORY_SVM(144)"; break;
        case RT_MEMORY_RESERVED: desc = "MEMORY_RESERVED(256)"; break;
        case RT_MEMORY_L1: desc = "MEMORY_L1(65536)"; break;
        case RT_MEMORY_L2: desc = "MEMORY_L2(131072)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%u)", static_cast<uint64_t>(type)); break;
    }
    return desc;
}

static inline std::string GnlCtrlTypeToString(const rtGeneralCtrlType_t type)
{
    std::string desc;
    switch (type) {
        case RT_GNL_CTRL_TYPE_MEMCPY_ASYNC_CFG: desc = "GNL_CTRL_TYPE_MEMCPY_ASYNC_CFG(0)"; break;
        case RT_GNL_CTRL_TYPE_REDUCE_ASYNC_CFG: desc = "GNL_CTRL_TYPE_REDUCE_ASYNC_CFG(1)"; break;
        case RT_GNL_CTRL_TYPE_FFTS_PLUS_FLAG: desc = "GNL_CTRL_TYPE_FFTS_PLUS_FLAG(2)"; break;
        case RT_GNL_CTRL_TYPE_FFTS_PLUS: desc = "GNL_CTRL_TYPE_FFTS_PLUS(3)"; break;
        case RT_GNL_CTRL_TYPE_NPU_GET_FLOAT_STATUS: desc = "GNL_CTRL_TYPE_NPU_GET_FLOAT_STATUS(4)"; break;
        case RT_GNL_CTRL_TYPE_NPU_CLEAR_FLOAT_STATUS: desc = "GNL_CTRL_TYPE_NPU_CLEAR_FLOAT_STATUS(5)"; break;
        case RT_GNL_CTRL_TYPE_STARS_TSK: desc = "GNL_CTRL_TYPE_STARS_TSK(6)"; break;
        case RT_GNL_CTRL_TYPE_CDQ_EN_QU: desc = "GNL_CTRL_TYPE_CDQ_EN_QU(7)"; break;
        case RT_GNL_CTRL_TYPE_CDQ_EN_QU_PTR: desc = "GNL_CTRL_TYPE_CDQ_EN_QU_PTR(8)"; break;
        case RT_GNL_CTRL_TYPE_CMO_TSK: desc = "GNL_CTRL_TYPE_CMO_TSK(9)"; break;
        case RT_GNL_CTRL_TYPE_BARRIER_TSK: desc = "GNL_CTRL_TYPE_BARRIER_TSK(10)"; break;
        case RT_GNL_CTRL_TYPE_STARS_TSK_FLAG: desc = "GNL_CTRL_TYPE_STARS_TSK_FLAG(11)"; break;
        case RT_GNL_CTRL_TYPE_SET_STREAM_TAG: desc = "GNL_CTRL_TYPE_SET_STREAM_TAG(12)"; break;
        case RT_GNL_CTRL_TYPE_MULTIPLE_TSK: desc = "GNL_CTRL_TYPE_MULTIPLE_TSK(13)"; break;
        case RT_GNL_CTRL_TYPE_NPU_GET_FLOAT_DEBUG_STATUS: desc = "GNL_CTRL_TYPE_NPU_GET_FLOAT_DEBUG_STATUS(14)"; break;
        case RT_GNL_CTRL_TYPE_NPU_CLEAR_FLOAT_DEBUG_STATUS: desc = "GNL_CTRL_TYPE_NPU_CLEAR_FLOAT_DEBUG_STATUS(15)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(type)); break;
    }
    return desc;
}

static inline std::string StreamTypeToString(const uint32_t streamType)
{
    std::string desc;
    switch (streamType) {
        case RT_NORMAL_STREAM: desc = "NORMAL_STREAM(0)"; break;
        case RT_HUGE_STREAM: desc = "HUGE_STREAM(1)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%u)", streamType); break;
    }
    return desc;
}

static inline std::string MemInfoTypeToString(const rtMemInfoType_t memInfoType)
{
    std::string desc;
    switch (memInfoType) {
        case RT_MEMORYINFO_DDR: desc = "MEMORYINFO_DDR(0)"; break;
        case RT_MEMORYINFO_HBM: desc = "MEMORYINFO_HBM(1)"; break;
        case RT_MEMORYINFO_DDR_HUGE: desc = "MEMORYINFO_DDR_HUGE(2)"; break;
        case RT_MEMORYINFO_DDR_NORMAL: desc = "MEMORYINFO_DDR_NORMAL(3)"; break;
        case RT_MEMORYINFO_HBM_HUGE: desc = "MEMORYINFO_HBM_HUGE(4)"; break;
        case RT_MEMORYINFO_HBM_NORMAL: desc = "MEMORYINFO_HBM_NORMAL(5)"; break;
        case RT_MEMORYINFO_DDR_P2P_HUGE: desc = "MEMORYINFO_DDR_P2P_HUGE(6)"; break;
        case RT_MEMORYINFO_DDR_P2P_NORMAL: desc = "MEMORYINFO_DDR_P2P_NORMAL(7)"; break;
        case RT_MEMORYINFO_HBM_P2P_HUGE: desc = "MEMORYINFO_HBM_P2P_HUGE(8)"; break;
        case RT_MEMORYINFO_HBM_P2P_NORMAL: desc = "MEMORYINFO_HBM_P2P_NORMAL(9)"; break;
        case RT_MEMORYINFO_HBM_HUGE1G: desc = "MEMORYINFO_HBM_HUGE1G(10)"; break;
        case RT_MEMORYINFO_HBM_P2P_HUGE1G: desc = "MEMORYINFO_HBM_P2P_HUGE1G(11)"; break;
        case RT_MEMORYINFO_NORMAL: desc = "MEMORYINFO_NORMAL(12)"; break;
        case RT_MEMORYINFO_HUGE: desc = "MEMORYINFO_HUGE(13)"; break;
        case RT_MEMORYINFO_HUGE1G: desc = "MEMORYINFO_HUGE1G(14)"; break;
        case RT_MEMORYINFO_P2P_NORMAL: desc = "MEMORYINFO_P2P_NORMAL(15)"; break;
        case RT_MEMORYINFO_P2P_HUGE: desc = "MEMORYINFO_P2P_HUGE(16)"; break;
        case RT_MEMORYINFO_P2P_HUGE1G: desc = "MEMORYINFO_P2P_HUGE1G(17)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(memInfoType)); break;
    }
    return desc;
}

static inline std::string SwitchDataTypeToString(const rtSwitchDataType_t dataType)
{
    std::string desc;
    switch (dataType) {
        case RT_SWITCH_INT32: desc = "SWITCH_INT32(0)"; break;
        case RT_SWITCH_INT64: desc = "SWITCH_INT64(1)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(dataType)); break;
    }
    return desc;
}

static inline std::string RandomNumDataTypeToString(const rtRandomNumDataType dataType)
{
    std::string desc;
    switch (dataType) {
        case RT_RANDOM_NUM_DATATYPE_INT32: desc = "RANDOM_NUM_DATATYPE_INT32(0)"; break;
        case RT_RANDOM_NUM_DATATYPE_INT64: desc = "RANDOM_NUM_DATATYPE_INT64(1)"; break;
        case RT_RANDOM_NUM_DATATYPE_UINT32: desc = "RANDOM_NUM_DATATYPE_UINT32(2)"; break;
        case RT_RANDOM_NUM_DATATYPE_UINT64: desc = "RANDOM_NUM_DATATYPE_UINT64(3)"; break;
        case RT_RANDOM_NUM_DATATYPE_BF16: desc = "RANDOM_NUM_DATATYPE_BF16(4)"; break;
        case RT_RANDOM_NUM_DATATYPE_FP16: desc = "RANDOM_NUM_DATATYPE_FP16(5)"; break;
        case RT_RANDOM_NUM_DATATYPE_FP32: desc = "RANDOM_NUM_DATATYPE_FP32(6)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(dataType)); break;
    }
    return desc;
}

static inline std::string RandomNumFuncTypeToString(const rtRandomNumFuncType funcType)
{
    std::string desc;
    switch (funcType) {
        case RT_RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK: desc = "RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK(0)"; break;
        case RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS: desc = "RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS(1)"; break;
        case RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS: desc = "RANDOM_NUM_FUNC_TYPE_NORMAL_DIS(2)"; break;
        case RT_RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS: desc = "RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS(3)"; break;
        default: desc = RtFmtMsg("UNKNOWN(%d)", static_cast<int32_t>(funcType)); break;
    }
    return desc;
}

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_ENUM_DESC_HPP
