/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_STARS_HPP__
#define __CCE_RUNTIME_STARS_HPP__

#include "stars_cond_isa_define.hpp"
#include "task_info.hpp"
#include "stars_base.hpp"
#include "stars/stars_dma.hpp"
#include "stars/stars_stream.hpp"
#include "stars/stars_kernel.hpp"

namespace cce {
namespace runtime {
constexpr uint8_t RT_STARS_AS31XM1X_DEFAULT_KERNEL_CREDIT = 3U; // The TS reference time is 33.5 ms.
constexpr float32_t RT_STARS_AS31XM1X_TASK_KERNEL_CREDIT_SCALE = 33.5F; // 2^24 / 500M *1000(ms)
constexpr uint8_t RT_STARS_FFTSPLUS_SUBTYPE_MIX = 0x1U;
constexpr uint8_t RT_STARS_FFTSPLUS_HCCL_WITHOUT_AICAIV_FLAG = 0x5AU;
constexpr uint8_t RT_STARS_FFTSPLUS_HCCL_WITH_AICAIV_FLAG = 0x5BU;

constexpr uint16_t TS_FFTS_TYPE_AIC_ONLY = 0U;
constexpr uint16_t TS_FFTS_TYPE_AIV_ONLY = 1U;
constexpr uint16_t TS_FFTS_TYPE_AIC_AIV_MIX = 5U;
constexpr uint8_t RT_STARS_DCACHE_LOCK_OP = 0x0AU;

enum rtStarsSqeType {
    RT_STARS_SQE_TYPE_FFTS            = 0, // FFTS
    RT_STARS_SQE_TYPE_AICPU           = 1, // AICPU
    RT_STARS_SQE_TYPE_PLACE_HOLDER    = 3, // PLACE_HOLDER
    RT_STARS_SQE_TYPE_EVENT_RECORD    = 4, // EVENT_RECORD
    RT_STARS_SQE_TYPE_EVENT_WAIT      = 5, // EVENT_WAIT
    RT_STARS_SQE_TYPE_NOTIFY_RECORD   = 6, // NOTIFY_RECORD
    RT_STARS_SQE_TYPE_NOTIFY_WAIT     = 7, // NOTIFY_WAIT
    RT_STARS_SQE_TYPE_WRITE_VALUE     = 8, // for EVENT_RESET task
    RT_STARS_SQE_TYPE_SDMA            = 11, // SDMA
    RT_STARS_SQE_TYPE_VPC             = 12, // VPC
    RT_STARS_SQE_TYPE_JPEGE           = 13, // JPEGE
    RT_STARS_SQE_TYPE_JPEGD           = 14, // JPEGD
    RT_STARS_SQE_TYPE_DSA             = 15, // DSA
    RT_STARS_SQE_TYPE_ROCCE           = 16, // RoCCE
    RT_STARS_SQE_TYPE_PCIE_DMA        = 17, // PCIE_DMA
    RT_STARS_SQE_TYPE_RESV            = 18, // reserve
    RT_STARS_SQE_TYPE_CDQM            = 19, // CDQM
    RT_STARS_SQE_TYPE_COND            = 20, // condition
    RT_STARS_SQE_TYPE_END             = 21,
    RT_STARS_SQE_TYPE_INVALID         = 63, // STARS_SQE_TYPE_INVALID
    RT_STARS_SQE_TYPE_VIR_TYPE        = 0xFF // DVPP virtual SQE TYPE
};

enum rtStarsCqeErrorCodeType {
    RT_STARS_CQE_ERR_TYPE_EXCEPTION        = (1ULL << 0U),
    RT_STARS_CQE_ERR_TYPE_TRAP             = (1ULL << 1U),
    RT_STARS_CQE_ERR_TYPE_TASK_TIMEOUT     = (1ULL << 2U),
    RT_STARS_CQE_ERR_TYPE_SQE_ERROR        = (1ULL << 3U),
    RT_STARS_CQE_ERR_TYPE_RES_CONFLICT     = (1ULL << 4U),
    RT_STARS_CQE_ERR_TYPE_SW_STATUS        = (1ULL << 5U)
};

#pragma pack(push)
#pragma pack (1)

struct RtStarsWriteValueSqe {
    rtStarsSqeHeader_t header;

    uint32_t res3;

    uint32_t res4 : 16;
    uint32_t kernel_credit : 8;
    uint32_t res5 : 8;

    uint32_t write_addr_low;

    uint32_t write_addr_high : 17;
    uint32_t res6 : 3;
    uint32_t awsize : 3;
    uint32_t snoop : 1;
    uint32_t awcache : 4;
    uint32_t awprot : 3;
    uint32_t va : 1; // 1 /* 1: virtual address; 0: phy addr */

    uint32_t res7;  // event_id for event reset task
    uint32_t sub_type;

    uint32_t write_value_part0;
    uint32_t write_value_part1;
    uint32_t write_value_part2;
    uint32_t write_value_part3;
    uint32_t write_value_part4;
    uint32_t write_value_part5;
    uint32_t write_value_part6;
    uint32_t write_value_part7;
};

struct RtDataDumpLoadInfo {
    uint64_t dumpinfoPtr;
    uint32_t length;
    uint16_t stream_id;
    uint16_t task_id;
    uint16_t kernel_type;
    uint16_t reserved;
};

struct RtAicpuInfoLoad {
    uint64_t aicpufoPtr;
    uint32_t length;
    uint16_t stream_id;
    uint16_t task_id;
    uint16_t reserved[2];
};

struct RtDynamicProf {
    uint64_t pid;
    uint8_t eventMuxConfig[8];
    uint64_t startCycle;
    uint64_t stopCycle;
    uint8_t userDefinedEnable;
    uint8_t isTimelineProfEn;
    uint8_t isTaskBasedProfEn;
    uint8_t isProfLogEn;
    uint8_t isSocLogEn;
    uint8_t reserved[11]; // reserved 11 bytes
};

struct rtProfilerTraceEx_t {
    uint64_t profilerTraceId;
    uint64_t modelId;
    uint16_t tagId;
    uint8_t reserved[30];
};

struct RtModelDebugRegister {
    uint64_t addr;
    uint32_t modelId;
    uint32_t flag;
    uint32_t reserved[8];
};

struct RtStreamDebugRegister {
    uint64_t addr;
    uint32_t streamId;
    uint32_t flag;
    uint32_t reserved[8];
};

struct RtStarsModelMaintaince {
    uint16_t model_id;
    uint16_t stream_id;
    uint16_t operation;
    uint16_t stream_type;
    uint16_t first_task_id;
    uint16_t endgraph_notify_id;
    uint32_t executor_flag;
    uint64_t streamExecTimesAddr;
    uint32_t reserved[6];
};

struct RtStarsMaintaince {
    uint8_t  sub_type; // force recyle
    uint8_t  rsv;
    uint16_t target_id;
    uint8_t  reserved[44];
};
struct RtAllocDsaAddr {
    uint16_t sq_id;
    uint8_t  reserved[46];
};

struct RtMdlTaskUpdate {
    uint64_t descBufOffset; // rtFftsPlusTaskInfo_t-->descBuf
    uint64_t tilingKeyOffset;
    uint64_t blockDimOffset;
    uint64_t tilingTabOffset;
    uint16_t tilingTabLen;
    uint16_t desStreamId;
    uint16_t destaskId;
    uint16_t exeStreamId;
    uint8_t  reserved[8];
};

struct RtCommonCmd {
    uint16_t cmdType;
    uint16_t streamId; // for streamclear
    uint32_t notifyId; // for notifyreset
    uint16_t step;     // for streamclear
    uint8_t  reserved[38];
};

struct RtStarsVersion {
    uint32_t buildVersion;
    uint8_t  reserved[44];
};

struct RtDebugStatus {
    uint8_t debugFlag;
    uint8_t reserved[3];
};

struct RtRingBufferControl {
    uint64_t ringbuffer_offset;
    uint64_t ringbuffer_phyAddr;
    uint64_t pid;
    uint32_t total_len;
    uint8_t  ringbuffer_del_flag; // 0:create 1:delete
    uint8_t  reserved[19];
};

struct RtGetDevMsg {
    uint64_t devAddr;
    uint64_t offset;
    uint32_t len;
    uint16_t type;
    uint8_t reserved[26];
};

struct RtMemCpyAsyncWithoutSdma {
    uint64_t src;
    uint64_t dest;
    uint32_t size;
    uint32_t pid;
    uint8_t reserved[24];
};

struct RtFlipTaskTag {
    uint16_t flipNumReport;
    uint8_t reserved[46];
};

struct RtUpdateAddrTaskTag {
    uint64_t dev_addr;
    uint64_t len;
    uint8_t reserved[32];
};

struct RtStarsPhSqe {
    uint8_t type : 6;
    uint8_t l2_lock : 1;
    uint8_t l2_unlock : 1;
    uint8_t ie : 2;
    uint8_t pre_p : 2;
    uint8_t post_p : 2;
    uint8_t wr_cqe : 1;
    uint8_t res0 : 1;
    uint16_t task_type;
    uint16_t rt_streamID;
    uint16_t task_id;
    uint32_t res1; // RUNTIME_BUILD_VERSION
    uint16_t res2;
    uint8_t kernel_credit;
    uint8_t res3;
    /* The struct in the union must be 48 bytes */
    union {
        RtStarsMaintaince maintaince_info;
        RtDataDumpLoadInfo data_dump_load_info;
        RtDynamicProf dynamic_profiling_info;
        rtProfilerTraceEx_t profile_trace_info;
        RtModelDebugRegister model_debug_register_info;
        RtStreamDebugRegister stream_debug_register_info;
        RtStarsModelMaintaince model_maintaince_info;
        RtRingBufferControl ring_buffer_control_info;
        RtMemCpyAsyncWithoutSdma memcpy_async_without_sdma_info;
        RtStreamOverflowSwitch stream_overflow_switch_info;
        RtGetDevMsg get_dev_msg_info;
        RtStreamSetTag stream_set_tag_info;
        RtAllocDsaAddr allocDsaAddrInfo;
        RtDebugStatus  debugStatusInfo;
        RtFlipTaskTag flip_task_info;
        RtUpdateAddrTaskTag updateAddrInfo;
        RtAicpuInfoLoad ai_cpu_load_info;
        RtMdlTaskUpdate mdTaskUpdateInfo;
        RtCommonCmd commonCmdInfo;
        RtStarsVersion starsVersionInfo;
        uint32_t resv[12];
    } u;
};

struct rtStarsAicpuModelOperate_t {
    uint32_t model_info_addr_low;
    uint32_t model_info_addr_high : 16;
    uint32_t res : 16;
    uint16_t sq_id;
    uint16_t task_id;
    uint16_t model_id;
    uint8_t cmd_type;
    uint8_t reserved;
};

struct rtStarsAicpuTimeoutConfig_t {
    uint32_t op_wait_timeout_en : 1;
    uint32_t op_execute_timeout_en : 1;
    uint32_t rsv : 30;
    uint32_t op_wait_timeout;
    uint32_t op_execute_timeout;
};

struct rtStarsAicpuUserData_t {
    uint32_t pid;
    uint8_t cmd_type;
    uint8_t vf_id;
    uint8_t tid;
    uint8_t ts_id;
    union {
        rtStarsAicpuModelOperate_t model_operate;
        rtStarsAicpuTimeoutConfig_t timeout_cfg;
    } u;
};

struct RtStarsAicpuControlSqe {
    /* word0-1 */
    rtStarsSqeHeader_t header;

    /* word2 */
    uint16_t res0;
    uint16_t kernel_type : 7;
    uint16_t batch_mode : 1;
    uint16_t topic_type : 4;
    uint16_t qos : 3;
    uint16_t res7 : 1;

    /* word3 */
    uint16_t sqe_index;
    uint16_t kernel_credit : 8;
    uint16_t res1 : 8;

    /* word4-9 */
    rtStarsAicpuUserData_t usr_data;

    /* word10-13 */
    uint32_t res[4];

    /* word14 */
    uint32_t sub_topic_id : 12;
    uint32_t topic_id : 6;
    uint32_t group_id : 6;
    uint32_t usr_data_len : 8;

    /* word15 */
    uint32_t dest_pid;
};

constexpr uint8_t STARS_CALLBACK_EVENT_RECORD_CMDTYPE = 15U;

constexpr uint32_t STARS_CDQM_CDQE_SIZE = 15;

struct rtStarsLabelSwitchSqe_t {
    rtStarsSqeHeader_t sqeHeader;

    uint32_t reserved0;
    uint16_t reserved1;
    uint8_t kernel_credit;
    uint8_t reserved2 : 7;
    uint8_t csc : 1;

    RtStarsCondOpLoadImm ldi;
    RtStarsCondOpLHWI lhwi;
    RtStarsCondOpLLWI llwi;
    RtStarsCondOpBranch bne;
    RtStarsCondOpStreamGotoI goto_i;
    RtStarsCondOpLoop loop_goto;
    RtStarsCondOpStreamActiveI active_i;
    RtStarsCondOpStreamDeActiveI deActiveI;
    RtStarsCondOpNop nop[3];
};

struct rtStarsLabelGotoSqe_t {
    rtStarsSqeHeader_t sqeHeader;

    uint32_t reserved0;
    uint16_t reserved1;
    uint8_t kernel_credit;
    uint8_t reserved2 : 7;
    uint8_t csc : 1;

    RtStarsCondOpStreamActiveI active_i;
    RtStarsCondOpLoop loop_active;
    RtStarsCondOpNop nop1;
    RtStarsCondOpStreamGotoI goto_i;
    RtStarsCondOpLoop loop_goto;
    RtStarsCondOpStreamDeActiveI deActiveI;
    RtStarsCondOpNop nop2[5];
};

struct RtStarsGetFloatStatusSqe {
    rtStarsSqeHeader_t sqeHeader;

    uint8_t conds_sub_type;  // CONDS_SUB_TYPE_LABEL_GET_FLOAT_STATUS, 1910b tiny only
    uint8_t reserved0[3];
    uint16_t reserved1;
    uint8_t kernel_credit;
    uint8_t reserved2 : 6;
    uint8_t debugFlag : 1;
    uint8_t csc : 1;

    RtStarsCondOpLoadImm ldi;
    RtStarsCondOpLLWI llwi;
    RtStarsCondOpStore sdOverflowCnt;
    RtStarsCondOpStore sdZero[7];
};

struct RtStarsFunctionCallSqe {
    rtStarsSqeHeader_t sqeHeader;

    uint8_t conds_sub_type;  // CONDS_SUB_TYPE_STREAM_ACTIVE, 1910b tiny only
    uint8_t reserved0[3];
    uint16_t reserved1;
    uint8_t kernel_credit;
    uint8_t reserved2 : 7;
    uint8_t csc : 1;

    RtStarsCondOpLHWI lhwi1;
    RtStarsCondOpLLWI llwi1;
    RtStarsCondOpLHWI lhwi2;
    RtStarsCondOpLLWI llwi2;
    RtStarsCondOpFuncCall funcCall;
    RtStarsCondOpNop nop[5];
};

struct rtLiteStarsWrValPyload_t {
    /* dw0 */
    uint32_t writeAddrLow;
    /* dw1 */
    uint32_t writeAddrHigh : 17;
    uint32_t reserved        : 3;
    uint32_t awsize          : 3;
    uint32_t snoop           : 1;
    uint32_t awcache         : 4;
    uint32_t awprot          : 3;
    uint32_t vaEnable        : 1;
    /* dw2 - 3 */
    uint32_t reserved0[2];
    /* dw4 - 11 */
    uint32_t wrData[8];
};

typedef struct  {
    uint32_t payload[12]; // common sqe payload length : 12 DW
} rtLiteStarsPyload_t;

struct RtLiteStarsEventSqe {
    struct RtLiteStarsSqeHead head;
    rtLiteStarsPyload_t payload;
};

union rtStarsSqe_t final {
    rtStarsCommonSqe_t commonSqe;
    RtStarsKernelSqe fftsKernelSqe;
    RtStarsAicpuKernelSqe aicpuSqe;
    RtStarsHostfuncCallbackSqe callbackSqe;
    RtStarsPhSqe phSqe;
    RtStarsEventSqe eventSqe;
    RtStarsNotifySqe notifySqe;
    RtStarsWriteValueSqe writeValueSqe;
    RtStarsMemcpyAsyncSqe memcpyAsyncSqe;
    RtStarsStreamSwitchSqe streamSwitchSqe;
    RtStarsStreamSwitchExSqe streamSwitchExSqe;
    RtFftsSqe fftsSqe;
    rtFftsPlusSqe_t fftsPlusSqe;
    RtStarsCdqmSqe cdqmSqe;
    RtFftsPlusKernelSqe fftsPlusKernelSqe;
    RtStarsPcieDmaSqe pcieDmaSqe;
    RtStarsRdmaSinkSqe1 rdmaSinkSqe1;
    RtStarsRdmaSinkSqe2 rdmaSinkSqe2;
    RtStarsStreamResetHeadSqe streamResetSqe;
    RtCmoKernelSqe cmoKernelSqe;
    RtBarrierKernelSqe barrierKernelSqe;
    RtStarsGetFloatStatusSqe getFloatStatusSqe;
    RtStarsFunctionCallSqe fuctionCallSqe;
    RtStarsAicpuControlSqe aicpuControlSqe;
    RtStarsDvppSqe dvppSqe;
    RtStarsMemcpyAsyncPtrSqe memcpyAsyncPtrSqe;
    RtLiteStarsSdmaSqe liteStarsSdmaSqe;
    RtLiteStarsEventSqe liteStarsEventSqe;
    RtLiteStarsRdmaSqe liteStarsRdmaSqe;
};

/**
* @ingroup
* @brief the struct define of cqe when task is completed
*/
struct rtStarsCqeSysCnt_t {
    uint32_t syscnt_low;
    uint32_t syscnt_high;
};

struct rtStarsModelExecuteError_t {
    uint16_t task_id;
    uint16_t stream_id : 12; /* 0~4096 for stream_id */
    uint16_t result : 4;
};

/* used for stream expand spec */
struct rtStarsModelExecuteErrorEx_t {
    uint16_t task_id;
    uint16_t sq_id : 12; /* sq_id */
    uint16_t result : 4;
};

union rtStarsCqeSwStatus_t {
    rtStarsModelExecuteError_t model_exec;
    rtStarsModelExecuteErrorEx_t model_exec_ex;
    uint32_t value;
};

struct rtStarsCqeErrorInfo_t {
    uint8_t error_code;
    uint8_t drop_flag; /* software define, means drop hw cqe and no dispatch to logic cq */
    uint8_t res0 : 1;
    uint8_t sqe_type : 6;
    uint16_t sqe_index;
    rtStarsCqeSwStatus_t sq_sw_status;
};

union rtStarsCqeStatus_t {
    rtStarsCqeSysCnt_t sysCnt;
    rtStarsCqeErrorInfo_t errorInfo;
};

struct rtStarsCqe_t {
    uint16_t phase : 1;
    uint16_t warn : 1; /* process warning */
    uint16_t evt : 1;  /* event record flag */
    uint16_t place_hold : 1;
    uint16_t SQ_id : 11;
    uint16_t error_bit : 1;
    uint16_t SQ_head;

    uint16_t streamID;
    uint16_t taskID;

    rtStarsCqeStatus_t cqe_status;
};

#pragma pack(pop)

void ToConstructSqe(TaskInfo *taskInfo, rtStarsSqe_t *const command);
uint32_t GetSendSqeNum(TaskInfo * const taskInfo);
rtError_t GetIpcSqeWriteAddrForNotifyRecordTask(TaskInfo *taskInfo, uint64_t &addr);
void PrintSqe(const rtStarsSqe_t * const sqe, const char *desc);
void ConstructPcieDmaSqe(TaskInfo * const taskInfo, rtStarsSqe_t *const command);

}  // namespace runtime
}  // namespace cce
#endif  // __CCE_RUNTIME_STARS_HPP__
