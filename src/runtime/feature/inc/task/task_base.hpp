/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_TASK_BASE_HPP__
#define __CCE_RUNTIME_TASK_BASE_HPP__

#include "base.hpp"
#include "osal.hpp"
#include "driver/ascend_hal.h"

#define RTS_INVALID_RES_ID  (0xFFFFFFFFU)

namespace cce {
namespace runtime {

constexpr uint8_t TASK_NO_SEND_CQ = 1U;
constexpr uint8_t TASK_NEED_SEND_CQ = 0U;
constexpr uint8_t ENDGRAPH_DUMP_FLAG = 2U;
constexpr uint8_t ENDGRAPH_INFO_FLAG = 4U;
constexpr uint8_t TASK_UNSINK_FLAG = 8U;
constexpr uint8_t KERNEL_CONVERT_FLAG = 1U;
constexpr uint8_t KERNEL_DUMPFLAG_FLAG = 2U;
constexpr uint8_t FUSION_KERNEL_DUMPFLAG = 4U;
constexpr uint8_t TASK_UN_SATURATION_MODE = 1U;
constexpr int32_t RT_STREAM_SYN_EVENT_ID_BASE = 1024;
constexpr uint8_t RINGBUFFER_NEED_DEL = 1U;
constexpr uint32_t SQ_SHARE_MEMORY_VALID = 0x5A5A5A5AU;
constexpr uint32_t CONTEXT_ALIGN_BIT = 7U;
constexpr uint32_t CONTEXT_ALIGN_LEN = 128U;
constexpr uint32_t NOTIFY_TIMEOUT = 600U;
constexpr uint32_t RT_CHIP_CLOUD_V2_LABEL_INFO_SIZE = 16U; // CHIP_910_B_93 label info size is 16B
constexpr uint8_t AICPU_QOS_VALID_FLAG = 8U;
constexpr uint32_t MULTIPLE_TASK_MAX_NUM = 5U;
constexpr float32_t RT_CHIP_CLOUD_V2_TIMESTAMP_FREQ = 50000.0;
constexpr float32_t RT_CHIP_MINI_V3_TIMESTAMP_FREQ = 48000.0;
constexpr float32_t RT_DEFAULT_TIMESTAMP_FREQ = 1000000.0;
constexpr uint32_t KERNEL_HOST_AICPU_FLAG = 0x2U;
constexpr uint8_t FORCE_RECYCLE_TASK_FLAG = 0x67U;
constexpr uint8_t CQE_ERROR_MAP_TIMEOUT = 0x4U;
constexpr uint32_t FUNC_CALL_INSTR_ALIGN_SIZE = 256U;

static constexpr uint32_t CONTEXT_LEN = 128U;               // 128B
static constexpr uint64_t OVERFLOW_OUTPUT_SIZE = 64U; // keep consistent with GE

enum {
    TASK_ERROR_SUBMIT_FAIL = 256
};

/**
 * @ingroup task
 * @brief the memcopy async task direct type
 */
enum rtMemCopyAsyncDirect {
    RT_MEMCPY_DIR_H2H = 0,
    RT_MEMCPY_DIR_H2D = 0,
    RT_MEMCPY_DIR_D2H = 1,
    RT_MEMCPY_DIR_D2D_SDMA = 2,             // D2D, 1P, P2P
    RT_MEMCPY_DIR_D2D_HCCs = 3,             // D2D, between devices
    RT_MEMCPY_DIR_D2D_PCIe = 4,             // D2D,  between devices
    RT_MEMCPY_ADDR_D2D_SDMA = 5,            // D2D, zero-cpy used
    RT_MEMCPY_DIR_D2D_UB = 6,               // D2D, between devices UB
    RT_MEMCPY_DIR_SDMA_AUTOMATIC_ADD = 10,  // SDMA inline reduce automatic add
    RT_MEMCPY_DIR_SDMA_AUTOMATIC_MAX = 11,
    RT_MEMCPY_DIR_SDMA_AUTOMATIC_MIN = 12,
    RT_MEMCPY_DIR_SDMA_AUTOMATIC_EQUAL = 13
};

enum rtReportPackageType {
    RT_PACKAGE_TYPE_TASK_REPORT = 0,
    RT_PACKAGE_TYPE_ERROR_REPORT = 1, /** used for error report */
    RT_PACKAGE_TYPE_RECYCLE_SQ_FINISHED = 3, /* recycle sq report(used by ts and drv) */
    RT_PACKAGE_TYPE_RECYCLE_STREAM_FINISHED = 4, /* recycle stream id report(used by ts and drv) */
    RT_PACKAGE_TYPE_RECYCLE_NOTIFY_FINISHED = 5, /* recycle notify id report(used by ts and drv) */
    RT_PACKAGE_TYPE_RECYCLE_EVENT_FINISHED = 6, /* recycle event id report(used by ts and drv) */
    RT_PACKAGE_TYPE_RECYCLE_CQ_FINISHED = 7, /* recycle cq report(used by ts and drv) */
    RT_PACKAGE_TYPE_BUTT = 8
};

enum WriteValueSize {
    WRITE_VALUE_SIZE_1_BYTE,
    WRITE_VALUE_SIZE_2_BYTE,
    WRITE_VALUE_SIZE_4_BYTE,
    WRITE_VALUE_SIZE_8_BYTE,
    WRITE_VALUE_SIZE_16_BYTE,
    WRITE_VALUE_SIZE_32_BYTE,
};

constexpr uint32_t WRITE_VALUE_SIZE_MAX_LEN = 32U;

// pass to sqe.wr_cqe
enum TaskWrCqeFlag {
    TASK_WR_CQE_DEFAULT,  // wr_cqe define by stream->GetStarsWrCqeFlag
    TASK_WR_CQE_NEVER,
    TASK_WR_CQE_ALWAYS
};

enum {
    MAX_REPORT_COUNT = 4
};

/**
 * @ingroup
 * @brief the type defination of task
 */
typedef enum tagTsTaskType {
    TS_TASK_TYPE_KERNEL_AICORE = 0,        /* AI core task */
    TS_TASK_TYPE_KERNEL_AICPU = 1,             /* AI cpu task */
    TS_TASK_TYPE_EVENT_RECORD = 2,             /* event record task */
    TS_TASK_TYPE_STREAM_WAIT_EVENT = 3,        /* stream wait event  task */
    TS_TASK_TYPE_FUSION_ISSUE = 4,             /* fusion issue task */
    TS_TASK_TYPE_MEMCPY = 5,                   /* memory copy task */
    TS_TASK_TYPE_MAINTENANCE = 6,              /* such as destroy the event or stream */
    TS_TASK_TYPE_CREATE_STREAM = 7,            /* create stream task */
    TS_TASK_TYPE_DATA_DUMP = 8,                /* kernel data dump configure */
    TS_TASK_TYPE_REMOTE_EVENT_WAIT = 9,        /* wait for event on another device */
    TS_TASK_TYPE_PCTRACE_ENABLE = 10,
    TS_TASK_TYPE_CREATE_L2_ADDR = 11,           /* create L2 addr info for aicpu kernel */
    TS_TASK_TYPE_MODEL_MAINTAINCE = 12,         /* bind or unbind stream with model */
    TS_TASK_TYPE_MODEL_EXECUTE = 13,            /* execute model */
    TS_TASK_TYPE_NOTIFY_WAIT = 14,              /* notify wait task */
    TS_TASK_TYPE_NOTIFY_RECORD = 15,            /* notify record task */
    TS_TASK_TYPE_RDMA_SEND = 16,           /* HCCL rdma cpy task */
    TS_TASK_TYPE_STREAM_SWITCH = 18,       /* switch stream */
    TS_TASK_TYPE_STREAM_ACTIVE = 19,       /* active stream */
    TS_TASK_TYPE_LABEL_SET = 20,           /* set label for control flow ops */
    TS_TASK_TYPE_LABEL_SWITCH = 21,        /* switch label for control flow ops */
    TS_TASK_TYPE_LABEL_GOTO = 22,          /* goto label for control flow ops */
    TS_TASK_TYPE_PROFILER_TRACE = 23,      /* profiler trace task */
    TS_TASK_TYPE_EVENT_RESET = 24,         /* event reset task */
    TS_TASK_TYPE_RDMA_DB_SEND = 25,        /* HCCL rdma db cpy task */
    TS_TASK_TYPE_PROFILER_TRACE_EX = 26,   /* profiler trace task */
    TS_TASK_TYPE_PROFILER_DYNAMIC_ENABLE = 27,     /* profiler dynamic task */
    TS_TASK_TYPE_PROFILER_DYNAMIC_DISABLE = 28,    /* profiler dynamic task */
    TS_TASK_TYPE_ALLOC_DSA_ADDR = 29,      /* alloc dsa addr task */
    TS_TASK_TYPE_CCU_LAUNCH = 30,          /* HCCL CCU Launch task */
    TS_TASK_TYPE_STARS_COMMON = 50,        /* stars common task */
    TS_TASK_TYPE_FFTS = 51,                /* ffts task */
    TS_TASK_TYPE_FFTS_PLUS = 52,           /* ffts plus task */
    TS_TASK_TYPE_CMO = 53,                 /* CMO task, CMO type is Invalid, Prefetch, or Write_back */
    TS_TASK_TYPE_BARRIER = 54,             /* CMO task, CMO type is Barrier */
    TS_TASK_TYPE_WRITE_VALUE = 55,         /* stars write value task */
    TS_TASK_TYPE_MULTIPLE_TASK = 56,       /* for dvpp launch multiple task */
    TS_TASK_TYPE_PROFILING_ENABLE = 64,    /* profiling enable task */
    TS_TASK_TYPE_PROFILING_DISABLE = 65,   /* profiling disable task */
    TS_TASK_TYPE_KERNEL_AIVEC = 66,        /* AI vector task */
    TS_TASK_TYPE_MODEL_END_GRAPH = 67,     /* add model end graph task */
    TS_TASK_TYPE_MODEL_TO_AICPU = 68,      /* add model load/execute/destroy to aicpu */
    TS_TASK_TYPE_ACTIVE_AICPU_STREAM = 69, /* active stream task for aicpu stream */
    TS_TASK_TYPE_DATADUMP_LOADINFO = 70,   /* load data dump info task */
    TS_TASK_TYPE_STREAM_SWITCH_N = 71,     /* switchN stream */
    TS_TASK_TYPE_HOSTFUNC_CALLBACK = 72,   /* host func callback */
    TS_TASK_TYPE_ONLINEPROF_START = 73,    /* start online profiling task */
    TS_TASK_TYPE_ONLINEPROF_STOP = 74,     /* stop online profiling task */
    TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX = 75,  /* index switch stream label for control flow ops */
    TS_TASK_TYPE_STREAM_LABEL_GOTO = 77,             /* goto stream label for control flow ops */
    TS_TASK_TYPE_DEBUG_REGISTER = 78, /* kernel exception overflow debug register */
    TS_TASK_TYPE_DEBUG_UNREGISTER = 79, /* kernel exception overflow debug unregister */
    TS_TASK_TYPE_FUSIONDUMP_ADDR_SET = 80, /* L1 fusion dump set task */
    TS_TASK_TYPE_MODEL_EXIT_GRAPH = 81,     /* add model end graph task */
    TS_TASK_TYPE_ADCPROF = 82,    /* mdc profiling task */
    TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL = 83,
    TS_TASK_TYPE_DEBUG_REGISTER_FOR_STREAM = 84, /* kernel exception overflow debug register for stream */
    TS_TASK_TYPE_DEBUG_UNREGISTER_FOR_STREAM = 85, /* kernel exception overflow debug unregister for stream */
    TS_TASK_TYPE_TASK_TIMEOUT_SET = 86,
    TS_TASK_TYPE_GET_DEVICE_MSG = 87,  /* Get device message */
    TS_TASK_TYPE_NPU_GET_FLOAT_STATUS = 88,  /* NPUGetFloatStatus */
    TS_TASK_TYPE_NPU_CLEAR_FLOAT_STATUS = 89,  /* NPUClearFloatStatus */
    TS_TASK_TYPE_MEMCPY_ASYNC_WITHOUT_SDMA = 90,      /* mem cpy async by place holder sqe */
    TS_TASK_TYPE_SET_OVERFLOW_SWITCH = 91,  /* Set overflow switch flag */
    TS_TASK_TYPE_REDUCE_ASYNC_V2 = 92,  /* reduce async v2, v1 use TS_TASK_TYPE_MEMCPY*/
    TS_TASK_TYPE_SET_STREAM_GE_OP_TAG = 93,  /* Set stream geOpTag */
    TS_TASK_TYPE_SET_STREAM_MODE = 94,
    TS_TASK_TYPE_IPCINT_NOTICE = 95,
    TS_TASK_TYPE_MODEL_LOAD = 96,     /* ModelLoad task for lhisi */
    TS_TASK_TYPE_GET_STARS_VERSION = 97,    /* get stars version */
    TS_TASK_TYPE_FLIP = 98,
    TS_TASK_TYPE_SET_SQ_LOCK_UNLOCK = 99,
    TS_TASK_TYPE_UPDATE_ADDRESS = 100, /* tiny translate va to pa by place holder sqe*/
    TS_TASK_TYPE_MODEL_TASK_UPDATE = 101, /* tiling key sink for update model info */
    TS_TASK_TYPE_AICPU_INFO_LOAD = 102, /* tiling key sink : aicpu info load */
    TS_TASK_TYPE_NOP = 103,
    TS_TASK_TYPE_COMMON_CMD = 104,
    TS_TASK_TYPE_UB_DB_SEND = 105,     /* HCCL ub db cpy task */
    TS_TASK_TYPE_DIRECT_SEND = 106,    /* HCCL direct db cpy task */
    TS_TASK_TYPE_FUSION_KERNEL = 107,  /* fusion kernel task */
    TS_TASK_TYPE_KERNEL_MIX_AIC = 108,
    TS_TASK_TYPE_KERNEL_MIX_AIV = 109,
    TS_TASK_TYPE_DAVID_EVENT_RECORD = 110, /* david event record task */
    TS_TASK_TYPE_DAVID_EVENT_WAIT = 111, /* david event wait task */
    TS_TASK_TYPE_DAVID_EVENT_RESET = 112, /* david event reset task */
    TS_TASK_TYPE_MEM_WRITE_VALUE = 113,  /* mem write value task */
    TS_TASK_TYPE_MEM_WAIT_VALUE  = 114,  /* mem wait value task */
    TS_TASK_TYPE_RDMA_PI_VALUE_MODIFY = 115,
    // DQS Task
    TS_TASK_TYPE_DQS_ENQUEUE = 116, /* dqs enqueue*/
    TS_TASK_TYPE_DQS_DEQUEUE = 117, /* dqs dequeue*/
    TS_TASK_TYPE_DQS_PREPARE = 118, /* dqs prepare */
    TS_TASK_TYPE_DQS_ZERO_COPY = 119, /* dqs zero copy */
    TS_TASK_TYPE_DQS_SCHED_END = 120, /* dqs sched end */
    TS_TASK_TYPE_DQS_MBUF_FREE = 121, /* dqs mbuf free*/
    TS_TASK_TYPE_DQS_INTER_CHIP_PREPROC = 122, /* dqs inter chip pre-proc */
    TS_TASK_TYPE_DQS_INTER_CHIP_POSTPROC = 123, /* dqs inter chip post-proc */
    TS_TASK_TYPE_DQS_ADSPC = 124, /* dqs adspc task */
    TS_TASK_TYPE_TSFW_AICPU_MSG_VERSION = 125, /* send tsfw-aicpu msg version to aicpu */
    TS_TASK_TYPE_CAPTURE_RECORD = 126,  /* mem write value task */
    TS_TASK_TYPE_CAPTURE_WAIT  = 127,  /* mem wait value task */
    TS_TASK_TYPE_DQS_BATCH_DEQUEUE = 128, /* dqs batch dequeue*/
    TS_TASK_TYPE_IPC_RECORD = 129,  /* ipc record task */
    TS_TASK_TYPE_IPC_WAIT  = 130,  /* ipc wait task */
    TS_TASK_TYPE_DQS_CONDITION_COPY = 131, /* dqs condition copy*/
    TS_TASK_TYPE_DQS_FRAME_ALIGN = 132, /* dqs frame align */
    TS_TASK_TYPE_RESERVED
} tsTaskType_t;

enum PhCmdType {
    CMD_STREAM_CLEAR = 0,
    CMD_NOTIFY_RESET = 1,
};

typedef enum tagMmtType {
    MMT_STREAM_ADD = 0,
    MMT_STREAM_DEL = 1,
    MMT_MODEL_LOAD_COMPLETE = 2,
    MMT_MODEL_DESTROY = 3,
    MMT_MODEL_PRE_PROC = 4,
    MMT_STREAM_LOAD_COMPLETE = 5,
    MMT_MODEL_ABORT = 6,
    MMT_RESERVED = 7
} MmtType;

typedef enum tagMtType {
    MT_STREAM_DESTROY = 0,
    MT_EVENT_DESTROY,
    MT_STREAM_RECYCLE_TASK
} MtType;

typedef enum tagFusionFlag {
    FUSION_START = 0,
    FUSION_END = 1
} FusionFlag;
/**
 * @ingroup
 * @brief the type definition of aicpu model cmd
 */
typedef enum tagTsAicpuModelCmdType {
    AICPU_MODEL_OPERATE = 1,   /* 1 aicpu model operate */
    AICPU_TIMEOUT_CONFIG = 13, /* 13 aicpu timeout config */
} tsAicpuModelCmdType;

typedef enum tagPcieDescType{
    RT_STARS_PCIE_BASE_ADDR = 0x400004008000ULL, // A+X 16P PCIE BAR
    RT_PCIE_LOCAL_DEV_OFFSET = 36ULL,
    RT_PCIE_REMOTE_DEV_OFFSET = 32ULL
} PcieDesc;


/**
 * @ingroup
 * @brief the type definition of aicpu kernel task
 */
typedef enum tagTsAicpuKernelType {
    TS_AICPU_KERNEL_CCE = 0, /* AI cpu cce kernel */
    TS_AICPU_KERNEL_FMK = 1,     /* AI cpu fmk kernel */
    TS_AICPU_KERNEL_AICPU = 2,
    TS_AICPU_KERNEL_DATADUMP = 3,
    TS_AICPU_KERNEL_CUSTOM_AICPU = 4,
    TS_AICPU_KERNEL_AICPU_KFC = 5,
    TS_AICPU_KERNEL_NON = 127, /* for callback launch topic */
    TS_AICPU_KERNEL_RESERVED = 128
} tsAicpuKernelType;

/**
 * @ingroup
 * @brief the struct define of memory copy type task
 */
enum rtMemcpyAddrConvertType {
    RT_NOT_NEED_CONVERT,
    RT_DMA_ADDR_CONVERT,
    RT_NO_DMA_ADDR_CONVERT
};

}
}
#endif  // __CCE_RUNTIME_TASK_RES_HPP__
