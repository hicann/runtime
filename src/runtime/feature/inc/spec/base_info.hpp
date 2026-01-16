/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_BASE_INFO_HPP__
#define __CCE_RUNTIME_BASE_INFO_HPP__

#include "base.h"
#include "kernel.h"

namespace cce {
namespace runtime {
constexpr uint32_t RT_MAX_DEV_NUM = 64U;
constexpr uint32_t RT_MAX_TS_NUM = 2U;
constexpr uint32_t RT_FAST_MEM_PAGE_SIZE = 128U * 1024U;
constexpr uint32_t RT_PROGRAM_FAST_MEM_OFFSET = (61U * RT_FAST_MEM_PAGE_SIZE); // 0-53 pages for cce data
constexpr uint32_t RT_PROGRAM_FAST_MEM_INSTR = (3U * RT_FAST_MEM_PAGE_SIZE); // 10 pages left for cce binary

#ifdef TEMP_PERFORMANCE  // for ut
constexpr int32_t RT_ABORT_STREAM_TIMEOUT = 100;  // ms
constexpr int32_t RT_ABORT_MODEL_TIMEOUT = 100;  // ms
#else
constexpr int32_t RT_ABORT_STREAM_TIMEOUT = 10000;  // ms
constexpr int32_t RT_ABORT_MODEL_TIMEOUT = 10000;  // ms
#endif

constexpr int32_t RT_REPORT_TIMEOUT_TIME = 5000;
constexpr int32_t RT_REPORT_STARS_TIMEOUT_TIME = 500;
constexpr int32_t RT_REPORT_STARS_TIMEOUT_TIME_OP_TIMEOUT_MS = 1;
constexpr int32_t RT_GET_SQ_STATUS_TIMEOUT_TIME = 300000;
constexpr int32_t RT_REPORT_WITHOUT_TIMEOUT = 0;
constexpr int32_t RT_QUERY_SIMT_STACK_TIMEOUT = 1000;   //ms
constexpr int32_t RT_DEVICE_SYNCHRONIZE_TIMEOUT = 10000;   //ms
constexpr uint32_t MAX_UINT32_NUM = 0xFFFFFFFFU;
constexpr uint32_t MAX_UINT16_NUM = 0xFFFFU;
constexpr int32_t MAX_INT32_NUM = 0x7FFFFFFF;
constexpr uint32_t RT_MAX_LABEL_NUM = 1024U;
constexpr uint32_t RT_MAX_LABEL_INIT_NUM = 64U;
constexpr uint64_t MAX_ALLOC_SIZE = (1ULL << 50U);
constexpr uint32_t L1FUSION_DUMP_SIZE = 0x100000U;
constexpr uint32_t RT_MAX_TS_ID = 1U;
constexpr uint32_t RT_DEV_ZERO = 0U;
constexpr uint32_t RT_IPC_MAX_NAME = 64U;
constexpr uint32_t STUB_DEVICE_ID = RT_MAX_DEV_NUM;

constexpr uint32_t RT_AICORE_NUM_30 = 30U;
constexpr uint32_t RT_AICORE_PG_NUM_31 = 31U;
constexpr uint32_t RT_AICORE_FREQ_900 = 900U;  // MHz

constexpr uint32_t RT_AICORE_NUM_32 = 32U;
constexpr uint32_t RT_AICORE_NUM_10 = 10U;

constexpr uint32_t RT_AICORE_NUM_25 = 25U;
constexpr uint32_t RT_AIVECTOR_NUM_50 = 50U;

// 32K * num   Ascend C Expand Stack Size 16K->32K
constexpr uint32_t RT_SCALAR_BUFFER_SIZE_32K_75 =
    (32U * 1024U * (RT_AIVECTOR_NUM_50 + RT_AICORE_NUM_25));
constexpr uint32_t RT_TINY_SCALAR_BUFFER_SIZE = (16U * 1024U * 1U);
constexpr uint32_t RT_SCALAR_BUFFER_SIZE_16K_75 =
    (16U * 1024U * (RT_AIVECTOR_NUM_50 + RT_AICORE_NUM_25));
constexpr uint32_t RT_SMMU_STREAM_ID_1FU = 0x1FU;
constexpr uint64_t RT_STARS_BASE_ADDR = 0x06A0000000ULL;
constexpr uint64_t RT_STARS_SQ_SWAP_BUFFER_BASE_ADDR = 0x101B200000ULL;

constexpr uint32_t RT_AICORE_NUM_1  = 1U;
constexpr uint32_t RT_AIVECTOR_NUM_1 = 1U;

// 32K * num  Ascend C Expand Stack Size 16K->32K
constexpr uint32_t RT_SCALAR_BUFFER_SIZE_32K_2 =
    (32U * 1024U * (RT_AIVECTOR_NUM_1 + RT_AICORE_NUM_1));

constexpr uint64_t RT_STARS_BASE_ADDR_520000000 = 0x520000000ULL;
constexpr uint64_t RT_STARS_SQ_SWAP_BUFFER_BASE_ADDR_C000000 = 0xC000000ULL;

constexpr uint32_t STARS_NOTIFY_NUM_OF_SINGLE_TABLE_128 = 128U;

constexpr uint64_t RT_STARS_BASE_ADDR_78000000 = 0x078000000ULL;

constexpr uint64_t STARS_EVENT_BASE_ADDR = 0x200000ULL;
constexpr uint64_t STARS_EVENT_OFFSET = 0x4ULL;
constexpr uint32_t STARS_EVENT_NUM_OF_SINGLE_TABLE = 4096U;
constexpr uint64_t STARS_EVENT_TABLE_OFFSET = 0x10000ULL;

constexpr uint64_t STARS_NOTIFY_BASE_ADDR = 0x100000ULL;
constexpr uint64_t STARS_NOTIFY_OFFSET = 0x4ULL;
constexpr uint32_t STARS_NOTIFY_NUM_OF_SINGLE_TABLE = 512U;
constexpr uint64_t STARS_NOTIFY_TABLE_OFFSET = 0x10000ULL;

constexpr uint64_t STARS_SIMPLE_SQ_OFFSET = 0x10000ULL;
constexpr uint64_t STARS_SIMPLE_SQ_OFFSET_4K = 0x1000ULL; 
constexpr uint64_t STARS_SIMPLE_SQ0_STARS_P0_SQ_DB_0_REG = 0x08000008ULL;
constexpr uint64_t STARS_SIMPLE_SQ0_STARS_P0_SQ_CFG4_0_REG = 0x08000010ULL;
constexpr uint64_t STARS_SIMPLE_SQ0_STARS_P0_SQ_CFG5_0_REG = 0x08000014ULL;
constexpr uint64_t STARS_SIMPLE_RTSQ_FSM_SEL_REG = 0x4880ULL;
constexpr uint64_t STARSV2_SIMPLE_RTSQ_FSM_SEL_REG = 0x21000000ULL;

/* follow 4K config */
constexpr uint64_t RT_SIMPLE_SQ_OFFSET_1000 = 0x1000ULL;
constexpr uint64_t RT_SIMPLE_SQ0_STARS_P0_SQ_DB_0_REG = 0x00080008ULL;
constexpr uint64_t RT_SIMPLE_SQ0_STARS_P0_SQ_CFG4_0_REG = 0x00080010ULL;
constexpr uint64_t RT_SIMPLE_SQ0_STARS_P0_SQ_CFG5_0_REG = 0x00080014ULL;

constexpr uint32_t RT_STARS_DIE_NUM_PER_CHIP = 2U;

constexpr uint64_t RT_CHIP_BASE_ADDR        =  0x200000000000ULL;

// 注释里的值是备用方案
constexpr uint64_t RT_CROSS_NODE_BASE_ADDR_48T   =  0x300000000000ULL; // 48T
constexpr uint64_t RT_SERVER_ADDR_OFFSET_1T     =  0x10000000000ULL; // 1T
constexpr uint64_t RT_CHIP_ADDR_OFFSET_128G       =  0x2000000000ULL;  // 128G
constexpr uint64_t RT_DIE_ADDR_OFFSET_64G        =  0x1000000000ULL; // 64G
constexpr uint64_t RT_NOTIFY_ADDR_OFFSET_PER_DIE_1100000  =  0x1100000ULL;

constexpr uint64_t RT_CHIP_ADDR_OFFSET_8T =  0x80000000000ULL;
constexpr uint64_t RT_HCCS_CHIP_ADDR_OFFSET_2T =  0x20000000000ULL;

constexpr uint64_t RT_DIE_ADDR_OFFSET_1T =   0x10000000000ULL;
constexpr uint64_t RT_ROCEE_BASE_ADDR_128G  =   0x2000000000ULL;
constexpr uint64_t RT_ROCEE_VF_ADDR_OFFSET_100000 =   0x100000ULL;
constexpr uint64_t RT_ROCEE_VF_DB_CFG0_REG_230 =    0x230ULL;
constexpr uint8_t RT_SET_DEVICE_STR_MAX_LEN = 128U;
constexpr uint8_t SOCINDEX_910B4 = 24U;

constexpr uint32_t RT_MAX_AICPU_STREAM_COUNT = 1024U;
constexpr uint64_t MAX_UINT64_NUM = 0xFFFFFFFFFFFFFFFFULL;
constexpr uint64_t INVALID_CONTEXT_OVERFLOW_OFFSET = 0xFFFFFFFFFFFFFFFFULL;
constexpr uint32_t RT_MINI_MAX_TASK_NUM = 65535U;
constexpr uint32_t RT_MAX_TASK_NUM = 1024U;
constexpr uint32_t RT_HALF_TASK_NUM = 512U;
constexpr uint32_t RT_HALF_SEND_TASK_NUM = 256U; // this is half of RT_HALF_TASK_NUM
constexpr uint16_t RT_VIRTUAL_SQE_SIZE = 64U;
constexpr uint16_t RT_VIRTUAL_CQE_SIZE = 16U;
constexpr uint16_t RT_STARSV2_VIRTUAL_CQE_SIZE = 32U;

constexpr uint16_t RT_STREAM_ID_OFFSET = 10U;
constexpr uint16_t RT_TASK_ID_OFFSET = 10U;
constexpr uint16_t RT_SYNC_SLEEP_INTERVAL = 200U;
constexpr uint16_t RT_QUERY_TIMES_THRESHOLD = 10U;
constexpr uint32_t RT_QUERY_TIMES_THRESHOLD_DC = 200000U;
constexpr uint16_t RT_QUERY_TIMES_THRESHOLD_20 = 20U;
constexpr uint32_t RT_QUERY_TIMES_THRESHOLD_STARS = 200000U;
constexpr uint32_t RT_QUERY_TIMES_THRESHOLD_DOUBLE_DIE_STARS = 1000U;

constexpr uint32_t RT_QUERY_TIMES_THRESHOLD_CLOUD_FAST = 1000U;
constexpr uint32_t RT_FAST_WAIT_THRESHOLD_FOR_CLOUD = 2U;

constexpr int32_t RT_STREAM_GREATEST_PRIORITY = 0;
constexpr int32_t RT_STREAM_LEAST_PRIORITY = 7;
constexpr uint64_t MAX_MEMCPY_SIZE_OF_D2D = 4ULL * 1024ULL * 1024ULL * 1024ULL; // 4G
constexpr uint32_t MEMCPY_ASYNC_UNIT_SIZE = 64U * 1024U * 1024U;
constexpr uint64_t MEM_CTRL_TWO_M_GRANULARITY = 2U * 1024U * 1024U;

constexpr uint32_t RT_MILAN_TASK_ID_MAX = 65535U;
constexpr uint32_t RT_MILAN_MAX_QUERY_CQE_NUM = 32U;
constexpr uint16_t RT_MILAN_POSITION_NUM_MAX_MINIV3 = 2047U;   // RTSQ max positon
constexpr uint32_t RT_MAX_OP_TIMEOUT_FOR_MS = 1000000U;  // 1000s
enum TschId : uint8_t {
    RT_TSC_ID = 0U,
    RT_TSV_ID = 1U
};

enum rtPGVersion_t : uint8_t {
    RT_VER_NA    = 0U,   
    RT_VER_BIN1  = 1U,   
    RT_VER_BIN2  = 2U,   
    RT_VER_BIN3  = 3U,   
    RT_VER_BIN4  = 4U,   /* reserved is same as driver */
    RT_VER_BIN8  = 8U,   
    RT_VER_BIN10 = 10U,  
    RT_VER_END = 11U
};

enum RtPGVersion : uint8_t {
    PG_VER_BIN0 = 0U,
    PG_VER_BIN1 = 1U,   
    PG_VER_BIN2 = 2U,   
    PG_VER_BIN3 = 3U,  
    PG_VER_BIN4 = 4U,
    PG_VER_BIN5 = 5U,
    PG_VER_BIN6 = 6U,
    PG_VER_BIN7 = 7U,
    PG_VER_BIN10 = 10U,
    PG_VER_BIN11 = 11U,
    PG_VER_BIN12 = 12U,
    PG_VER_BIN13 = 13U,
    PG_VER_BIN14 = 14U,
    PG_VER_BIN15 = 15U,
    PG_VER_BIN16 = 16U,
    PG_VER_BIN17 = 17U,
    PG_VER_BIN18 = 18U,
    PG_VER_BIN19 = 19U,
    PG_VER_BIN20 = 20U,
    PG_VER_BIN21 = 21U,
    PG_VER_BIN22 = 22U,
    PG_VER_BIN23 = 23U,
    PG_VER_BIN24 = 24U,
    PG_VER_END = 25U
};

enum RtSetVisDevicesErrorType : uint8_t {
    RT_GET_DRIVER_ERROR = 0U,
    RT_ALL_DUPLICATED_ERROR,
    RT_ALL_ORDER_ERROR,
    RT_ALL_DATA_ERROR,
    RT_ALL_DATA_OK,
};

enum DevRunningState : uint8_t {
    DEV_RUNNING_NORMAL = 0U,
    DEV_RUNNING_DOWN,
};

enum RtLogLevel : uint8_t {
    RT_LOG_ERROR = 0U,
    RT_LOG_WARNING = 1U,
    RT_LOG_EVENT = 2U,
    RT_LOG_INFO = 3U,
    RT_LOG_DEBUG = 4U,
    RT_LOG_LEVEL_MAX = 5U
};

enum RtErrModuleType : uint8_t {
    ERR_MODULE_AICPU = 0U,
    ERR_MODULE_DRV = 1U,
    ERR_MODULE_HCCL = 2U,
    ERR_MODULE_GE = 3U, // This enumeration is not recommended and will be discarded gradually.
    ERR_MODULE_PROFILE = 4U,
    ERR_MODULE_TBE = 5U,
    ERR_MODULE_SYSTEM = 6U,
    ERR_MODULE_RTS = 7U,
    ERR_MODULE_FE = 8U,
    ERR_MODULE_AICPU_TIMEOUT = 9U,
    ERR_MODULE_INVALID_ARGUMENT = 10U,
    ERR_MODULE_MAX = 11U,
};

/* MPI Data structure */
struct rtStarsTransParm_t {
    /* event record/event wait/rdma/sdma opcode */
    uint32_t opcode;
    uint32_t wrCqeFlag;
    void *transParms;
    uint32_t parmsLen;
};

struct rtLaunchArgs_t {
    rtArgsEx_t argsInfo;
    uint16_t argsAddrOffset; //args Addr current Offset
    const uint16_t argsDataOffset; //args Addr end Offset
    const uint16_t hostInfoMaxNum; //Maximum number of hostInfoMaxNum
    uint16_t argsHostInputOffset;
};

struct RtMemcpyCfgInfo {
    uint32_t rsv[4];
    uint32_t checkBitmap;
};

struct RtHbmRasInfo {
    uint32_t devId;
    uint32_t eventId;
    uint64_t sysCnt;
};

constexpr uint32_t MAX_EVENT_ID_NUM = 65536U;

// keep the rtKpEventIdType_t structure consistent with event_id_type_t in stars_interface.h
struct rtKpEventIdType_t {
    uint32_t eventId;
    uint64_t offset;
};
uint32_t GetRuntimeStreamNum();
#define RT_MAX_STREAM_ID GetRuntimeStreamNum()

static constexpr const char_t *RT_INNER_ERROR = "EE9999";
static constexpr const char_t *RT_INNER_WARNING = "WE9999";
static constexpr const char_t *RT_NPU_COMMON_INNER_ERROR = "EZ9999";
static constexpr const char_t *RT_FE_INNER_ERROR = "E29999";
static constexpr const char_t *RT_AICPU_INNER_ERROR = "E39999";
static constexpr const char_t *RT_DRV_INNER_ERROR = "EL9999";
static constexpr const char_t *RT_HCCL_INNER_ERROR = "EI9999";
static constexpr const char_t *RT_GE_INNER_ERROR = "EE8888";
static constexpr const char_t *RT_PROFILE_INNER_ERROR = "EK9999";
static constexpr const char_t *RT_STREAM_SYNC_TIMEOUT_INNER_ERROR = "EE1002";
static constexpr const char_t *RT_TBE_INNER_ERROR = "EZ9999";
static constexpr const char_t *RT_SYSTEM_INNER_ERROR = "EE9999";
static constexpr const char_t *RT_INVALID_ARGUMENT_ERROR = "EE1001";
static constexpr const char_t *RT_AICPU_TIMEOUT_ERROR = "E30008";
static constexpr const char_t *RT_TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT_ERROR = "E30003";
static constexpr const char_t *RT_TSD_SUBPROCESS_BINARY_FILE_DAMAGED = "E30004";
static constexpr const char_t *RT_TSD_DEVICE_DISCONNECTED = "E30005";
static constexpr const char_t *RT_TSD_DRV_HDC_SEND_FILE_FAILED_ERROR = "E30006";
static constexpr const char_t *RT_TSD_ADD_AICPUSD_TO_CGROUP_FAILED = "E30007";

}
}
#endif // __CCE_RUNTIME_BASE_INFO_HPP__