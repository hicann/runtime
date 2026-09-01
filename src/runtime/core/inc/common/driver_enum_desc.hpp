/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_DRIVER_ENUM_DESC_HPP
#define CCE_RUNTIME_DRIVER_ENUM_DESC_HPP

#include <cstdint>
#include "driver/ascend_hal_define.h"
#include "runtime/config.h"
#include "runtime/rt_external_mem.h"
#include "runtime/rt_inner_dfx.h"
#include "runtime/rts/rts_event.h"

namespace cce {
namespace runtime {

static inline const char* HandleAttrTypeName(const HandleAttrType type)
{
    switch (type) {
        case HANDLE_ATTR_MEM_MAP_ROUTE:
            return "HANDLE_ATTR_MEM_MAP_ROUTE";
        case HANDLE_ATTR_TYPE_MAX:
            return "HANDLE_ATTR_TYPE_MAX";
        default:
            return "UNKNOWN";
    }
}

static inline const char* BuffGetCmdTypeName(const BuffGetCmdType type)
{
    switch (type) {
        case BUFF_GET_MBUF_TIMEOUT_INFO:
            return "BUFF_GET_MBUF_TIMEOUT_INFO";
        case BUFF_GET_MBUF_USE_INFO:
            return "BUFF_GET_MBUF_USE_INFO";
        case BUFF_GET_MBUF_TYPE_INFO:
            return "BUFF_GET_MBUF_TYPE_INFO";
        case BUFF_GET_BUFF_TYPE_INFO:
            return "BUFF_GET_BUFF_TYPE_INFO";
        case BUFF_GET_POOL_INFO:
            return "BUFF_GET_POOL_INFO";
        case BUFF_GET_MEMPOOL_INFO:
            return "BUFF_GET_MEMPOOL_INFO";
        case BUFF_GET_MEMPOOL_BLK_AVAILABLE:
            return "BUFF_GET_MEMPOOL_BLK_AVAILABLE";
        case BUFF_GET_MP_USAGE_OF_PROCESS:
            return "BUFF_GET_MP_USAGE_OF_PROCESS";
        case BUFF_GET_MEMPOOL_USE_INFO:
            return "BUFF_GET_MEMPOOL_USE_INFO";
        case BUFF_GET_MAX:
            return "BUFF_GET_MAX";
        default:
            return "UNKNOWN";
    }
}

static inline const char* MemQueueSetCmdTypeName(const rtMemQueueSetCmdType type)
{
    switch (type) {
        case RT_MQ_QUEUE_SET_WORK_MODE:
            return "MQ_QUEUE_SET_WORK_MODE";
        case RT_MQ_QUEUE_ENABLE_LOCAL_QUEUE:
            return "MQ_QUEUE_ENABLE_LOCAL_QUEUE";
        case RT_MQ_QUEUE_SET_CMD_MAX:
            return "MQ_QUEUE_SET_CMD_MAX";
        default:
            return "UNKNOWN";
    }
}

static inline const char* GroupTypeName(const rtGroupType_t type)
{
    switch (type) {
        case RT_GRP_TYPE_BIND_DP_CPU:
            return "GRP_TYPE_BIND_DP_CPU";
        case RT_GRP_TYPE_BIND_CP_CPU:
            return "GRP_TYPE_BIND_CP_CPU";
        case RT_GRP_TYPE_BIND_DP_CPU_EXCLUSIVE:
            return "GRP_TYPE_BIND_DP_CPU_EXCLUSIVE";
        default:
            return "UNKNOWN";
    }
}

static inline const char* EschedQueryTypeName(const rtEschedQueryType type)
{
    switch (type) {
        case RT_QUERY_TYPE_LOCAL_GRP_ID:
            return "QUERY_TYPE_LOCAL_GRP_ID";
        case RT_QUERY_TYPE_REMOTE_GRP_ID:
            return "QUERY_TYPE_REMOTE_GRP_ID";
        case RT_QUERY_TYPE_MAX:
            return "QUERY_TYPE_MAX";
        default:
            return "UNKNOWN";
    }
}

static inline const char* EventIdTypeName(const rtEventIdType_t type)
{
    switch (type) {
        case RT_EVENT_RANDOM_KERNEL:
            return "EVENT_RANDOM_KERNEL";
        case RT_EVENT_DVPP_MSG:
            return "EVENT_DVPP_MSG";
        case RT_EVENT_FR_MSG:
            return "EVENT_FR_MSG";
        case RT_EVENT_TS_HWTS_KERNEL:
            return "EVENT_TS_HWTS_KERNEL";
        case RT_EVENT_AICPU_MSG:
            return "EVENT_AICPU_MSG";
        case RT_EVENT_TS_CTRL_MSG:
            return "EVENT_TS_CTRL_MSG";
        case RT_EVENT_QUEUE_ENQUEUE:
            return "EVENT_QUEUE_ENQUEUE";
        case RT_EVENT_QUEUE_FULL_TO_NOT_FULL:
            return "EVENT_QUEUE_FULL_TO_NOT_FULL";
        case RT_EVENT_QUEUE_EMPTY_TO_NOT_EMPTY:
            return "EVENT_QUEUE_EMPTY_TO_NOT_EMPTY";
        case RT_EVENT_TDT_ENQUEUE:
            return "EVENT_TDT_ENQUEUE";
        case RT_EVENT_TIMER:
            return "EVENT_TIMER";
        case RT_EVENT_HCFI_SCHED_MSG:
            return "EVENT_HCFI_SCHED_MSG";
        case RT_EVENT_HCFI_EXEC_MSG:
            return "EVENT_HCFI_EXEC_MSG";
        case RT_EVENT_ROS_MSG_LEVEL0:
            return "EVENT_ROS_MSG_LEVEL0";
        case RT_EVENT_ROS_MSG_LEVEL1:
            return "EVENT_ROS_MSG_LEVEL1";
        case RT_EVENT_ROS_MSG_LEVEL2:
            return "EVENT_ROS_MSG_LEVEL2";
        case RT_EVENT_ACPU_MSG_TYPE0:
            return "EVENT_ACPU_MSG_TYPE0";
        case RT_EVENT_ACPU_MSG_TYPE1:
            return "EVENT_ACPU_MSG_TYPE1";
        case RT_EVENT_ACPU_MSG_TYPE2:
            return "EVENT_ACPU_MSG_TYPE2";
        case RT_EVENT_CCPU_CTRL_MSG:
            return "EVENT_CCPU_CTRL_MSG";
        case RT_EVENT_SPLIT_KERNEL:
            return "EVENT_SPLIT_KERNEL";
        case RT_EVENT_DVPP_MPI_MSG:
            return "EVENT_DVPP_MPI_MSG";
        case RT_EVENT_CDQ_MSG:
            return "EVENT_CDQ_MSG";
        case RT_EVENT_TEST:
            return "EVENT_TEST";
        case RT_EVENT_MAX_NUM:
            return "EVENT_MAX_NUM";
        default:
            return "UNKNOWN";
    }
}

static inline const char* DebugMemoryTypeName(const rtDebugMemoryType_t type)
{
    switch (type) {
        case RT_MEM_TYPE_L0A:
            return "MEM_TYPE_L0A";
        case RT_MEM_TYPE_L0B:
            return "MEM_TYPE_L0B";
        case RT_MEM_TYPE_L0C:
            return "MEM_TYPE_L0C";
        case RT_MEM_TYPE_UB:
            return "MEM_TYPE_UB";
        case RT_MEM_TYPE_L1:
            return "MEM_TYPE_L1";
        case RT_MEM_TYPE_DCACHE:
            return "MEM_TYPE_DCACHE";
        case RT_MEM_TYPE_ICACHE:
            return "MEM_TYPE_ICACHE";
        case RT_MEM_TYPE_REGISTER:
            return "MEM_TYPE_REGISTER";
        case RT_MEM_TYPE_REGISTER_DIRECT:
            return "MEM_TYPE_REGISTER_DIRECT";
        case RT_MEM_TYPE_MAX:
            return "MEM_TYPE_MAX";
        default:
            return "UNKNOWN";
    }
}

static inline const char* KernelDfxInfoTypeName(const rtKernelDfxInfoType type)
{
    switch (type) {
        case RT_KERNEL_DFX_INFO_DEFAULT:
            return "KERNEL_DFX_INFO_DEFAULT";
        case RT_KERNEL_DFX_INFO_PRINTF:
            return "KERNEL_DFX_INFO_PRINTF";
        case RT_KERNEL_DFX_INFO_TENSOR:
            return "KERNEL_DFX_INFO_TENSOR";
        case RT_KERNEL_DFX_INFO_ASSERT:
            return "KERNEL_DFX_INFO_ASSERT";
        case RT_KERNEL_DFX_INFO_TIME_STAMP:
            return "KERNEL_DFX_INFO_TIME_STAMP";
        case RT_KERNEL_DFX_INFO_BLOCK_INFO:
            return "KERNEL_DFX_INFO_BLOCK_INFO";
        case RT_KERNEL_DFX_INFO_INVALID:
            return "KERNEL_DFX_INFO_INVALID";
        default:
            return "UNKNOWN";
    }
}

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_DRIVER_ENUM_DESC_HPP
