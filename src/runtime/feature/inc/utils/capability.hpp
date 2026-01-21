/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_CAPABILITY_HPP__
#define __CCE_RUNTIME_CAPABILITY_HPP__

#include "base.hpp"
#include "osal.hpp"
#include "elf.hpp"
#include "device.hpp"

namespace cce {
namespace runtime {

// 0: The version number starts from zero and increases by 1 each time.
// 1: runtime support 64k label info and support switch by index for vm machine.
// 2: runtime support extend aic error registers.
// 3: runtime support event/notiry wait snapshot.
// 4: runtime support rtMemcpyD2DAddrAsync.
// 5: runtime support get tslog to host.
// 6: runtime support send device id
// 7: runtime support MC2 error proc
constexpr uint32_t RUNTIME_BUILD_VERSION = 7U;  // 后续不演进

// 枚举值所有芯片形态统一编码, 添加前请评审, 请勿私自添加
typedef enum {
    // 0: The version number starts from zero and increases by 1 each time.
    RUNTIME_FEATURE_BASE                       = 0,
    // 1: runtime support 64k label info and support switch by index for vm machine.
    RUNTIME_FEATURE_MORE_LABEL                 = 1,
    // 2: runtime support extend aic error registers.
    RUNTIME_FEATURE_AIC_ERR_EXT_REG            = 2,
    // 3: runtime support event/notiry wait snapshot.
    RUNTIME_FEATURE_SNAPSHOT_ERR               = 3,
    // 4: runtime support rtMemcpyD2DAddrAsync.
    RUNTIME_FEATURE_D2D_CPY_OFFSET             = 4,
    // 5: runtime support get tslog to host.
    RUNTIME_FEATURE_LOG_TOHOST                 = 5,
    // 6: runtime support send device id
    RUNTIME_FEATURE_SEND_DEVICE_ID             = 6,
    // 7: runtime support MC2 error proc
    RUNTIME_FEATURE_MC2_ENHANCE                = 7,
    // 8: runtime support acl graph expand stream
    RUNTIME_FEATURE_STREAM_EXPAND              = 8
} RtRunTimeFeature;

// 枚举值与TSCH保持一致
typedef enum {
    TS_FEATURE_INIT = 0,
    TS_FEATURE_SUPER_TASK_FOR_DVPP = 1,
    TS_FEATURE_MORE_LABEL = 2,
    TS_FEATURE_EXPAND_STREAM_TASK = 3,
    TS_FEATURE_AICPU_EVENT_RECORD = 4,
    TS_FEATURE_GET_DEV_MSG = 5,
    TS_FEATURE_SUPPORT_STREAM_TASK_FULL = 6,
    TS_FEATURE_AIC_ERR_REG_EXT = 7,
    TS_FEATURE_EXPEND_MODEL_ID = 8,
    TS_FEATURE_REDUCE_V2_ID = 9,
    TS_FEATURE_LITE_LAUNCH = 10,
    TS_FEATURE_TS_MODEL_ABORT = 11,
    TS_FEATURE_CTRL_SQ = 12,
    TS_FEATURE_SET_STREAM_MODE = 13,
    TS_FEATURE_AIC_ERR_DHA_INFO = 14,
    TS_FEATURE_STREAM_TIMEOUT_SNAPSHOT = 15,
    TS_FEATURE_STARS_COMPATIBILITY = 16,
    TS_FEATURE_IPC_NOTICE_DC = 17,
    TS_FEATURE_OVER_FLOW_DEBUG = 18,
    TS_FEATURE_D2D_ADDR_ASYNC = 19,
    TS_FEATURE_FLIPTASK = 20,
    TS_FEATURE_FFTSPLUS_TIMEOUT = 21,
    TS_FEATURE_FFTSPLUS_TASKID_SAME_FIX = 22,
    TS_FEATURE_MC2_RTS_SUPPORT_HCCL = 23,
    TS_FEATURE_IPC_NOTICE_910_B_93 = 24,
    TS_FEATURE_MC2_RTS_SUPPORT_HCCL_DC = 25,
    TS_FEATURE_REDUCE_V2_SUPPORT_DC = 26,
    TS_FEATURE_TILING_KEY_SINK = 27,
    TS_FEATURE_NOP_TASK = 28,
    TS_FEATURE_MODEL_STREAM_REUSE = 29,
    TS_FEATURE_MC2_ENHANCE = 30,
    TS_FEATURE_REDUCE_V2_OPTIMIZE = 31,
    TS_FEATURE_WAIT_TIMEOUT_DC = 32,
    TS_FEATURE_TASK_SAME_FOR_ALL = 33,
    TS_FEATURE_TASK_ABORT = 34,
    TS_FEATURE_EVENT_DESTROY_SYNC = 35,
    TS_FEATURE_EVENT_DESTROY_SYNC_FIX = 36,
    TS_FEATURE_DYNAMIC_PROFILING = 37,
    TS_FEATURE_STREAM_ABORT = 38,
    TS_FEATURE_AICPU_NOTIMEOUT = 39,
    TS_FEATURE_COREDUMP = 40,
    TS_FEATURE_DCACHE_LOCK = 41,
    TS_FEATURE_CAPTURE_SQE_UPDATE = 42,
    TS_FEATURE_SUPPORT_AICPU_MSG_VERSION = 43,
    TS_FEATURE_OP_EXEC_TIMEOUT_MS = 44,
    TS_FEATURE_SOFTWARE_SQ_ENABLE = 45,
} rtTschFeature;

typedef enum
{
    TS_BRANCH_TRUNK = 0,
    TS_BRANCH_V1R1C30 = 1,
    TS_BRANCH_V1R1C13 = 2,
    TS_BRANCH_V1R1C15 = 3,
    TS_BRANCH_V1R1C17 = 4,
    TS_BRANCH_V1R1C18 = 5
} RtTschBranch;

typedef enum {
    RT_FEATURE_STARS_COMPATIBILITY          = 0,
    RT_FEATURE_IPC_NOTICE_DC                = 1,
    RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX     = 2,
    RT_FEATURE_OVER_FLOW_DEBUG              = 3,
    RT_FEATURE_D2D_ADDR_ASYNC               = 4,
    RT_FEATURE_FLIPTASK                     = 5,
    RT_FEATURE_FFTSPLUS_TIMEOUT             = 6,
    RT_FEATURE_MC2_RTS_SUPPORT_HCCL         = 7,
    RT_FEATURE_IPC_NOTICE_910_B_93          = 8,
    RT_FEATURE_MC2_RTS_SUPPORT_HCCL_DC      = 9,
    RT_FEATURE_SUPPORT_REDUCEASYNC_V2_DC    = 10,
    RT_FEATURE_TILING_KEY_SINK              = 11,
    RT_FEATURE_MC2_ENHANCE                  = 12,
    RT_FEATURE_FFTSPLUS_TASKID_SAME_FOR_ALL = 13,
    RT_FEATURE_TASK_ABORT                   = 14,
    RT_FEATURE_MAX                          = 15
} rtFeature;

constexpr uint32_t RUNTIME_CAPABILITY_LEN = 2048U;    // runtime能力集长度2k
constexpr uint32_t TSCH_CAPABILITY_LEN = 10240U;   // TSCH能力集长度10k
constexpr uint32_t RTS_TIMEOUT_STREAM_SNAPSHOT_LEN = (1024U * 17U);  // 17k
constexpr uint32_t RUNTME_TSCH_CAPABILITY_LEN = 12288U; // ((RUNTIME_CAPABILITY_LEN) + (TSCH_CAPABILITY_LEN))
constexpr uint32_t ONE_BYTE_BITS = 8U;
constexpr uint32_t RINGBUFFER_CAPABILITY_MAGIC = 0xA55A2022U;
 
struct RtsCapabilityHeader {
    uint32_t magic;
    uint32_t head;
    uint32_t tail;
    uint32_t depth;
    uint32_t reserved[4];
};
 
struct RuntimeCapability {
    RtsCapabilityHeader header;
    uint8_t capability[RUNTIME_CAPABILITY_LEN - sizeof(RtsCapabilityHeader)];
};
 
struct TschCapability {
    RtsCapabilityHeader header;
    uint8_t capability[TSCH_CAPABILITY_LEN - sizeof(RtsCapabilityHeader)];
};

// not use for new feature, please use CheckFeatureSupport
bool CheckFeatureIsSupportOld(const uint32_t tschVersion, rtFeature feature);
bool CheckSupportMC2Feature(Device * const dev);
const uint32_t *GetRtCapabilityTbl(void);
uint32_t GetRtCapabilityTblLen(void);
void FeatureToTsVersionInit(void);
bool CheckSupportTilingKeyWhenCompile(); // only use when compile

}  // namespace runtime
}  // namespace cce

#endif  // __CCE_RUNTIME_CAPABILITY_HPP__
