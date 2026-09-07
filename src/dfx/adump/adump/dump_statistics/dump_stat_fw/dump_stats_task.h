/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DUMP_STATS_TASK_H
#define DUMP_STATS_TASK_H

#include <cstdint>
#include "dump_stats_server.h"
#include "dump_stats_param.h"
#include "ascend_hal.h"
#include "ascend_hal_define.h"

extern "C" {
drvError_t __attribute__((weak)) drvGetLocalDevIDByHostDevID(uint32_t hostDevId, uint32_t* localDevId);
}
namespace kfc_dump_stats {
constexpr uint64_t LOW_ADDR_MASK = 0xFFFFFFFF;
constexpr uint64_t HIGH_ADDR_MASK = 0xFFFFFFFF00000000;
constexpr uint32_t AC_SQE_SIZE = 64;
constexpr uint32_t TS_UINT32_BIT_NUM = 32;
constexpr uint32_t MAX_L2_MAIN_CACHE = 255;
constexpr uint32_t KERNEL_TIMEOUT_CONSTANT = 72;
constexpr uint16_t GROUP_DIM_DEFAULT = 2U;

enum class KfcDumpTaskType {
    FFTS_TASK = 1,
    AIVECTOR_TASK = 2,
};

struct rtStarsSqeHeader_t {
    uint8_t type : 6;
    uint8_t l1_lock : 1;
    uint8_t l1_unlock : 1;
    uint8_t ie : 2;
    uint8_t pre_p : 2;
    uint8_t post_p : 2;
    uint8_t wr_cqe : 1;
    uint8_t reserved : 1;
    uint16_t block_dim;
    uint16_t rt_stream_id;
    uint16_t task_id;
};

struct rtFftsPlusKernelSqe_t {
    rtStarsSqeHeader_t header;
    uint16_t ffts_type : 3;
    uint16_t res1 : 9;
    uint16_t wrr_ratio : 4;
    uint16_t res2;
    uint16_t sqe_index;
    uint16_t kernel_credit : 8;
    uint16_t schem : 2;
    uint16_t res3 : 1;
    uint16_t icache_prefetch_cnt : 5;
    uint32_t stack_phy_base_low;
    uint32_t stack_phy_base_high;
    uint32_t res4;
    uint32_t pmg : 2;
    uint32_t ns : 1;
    uint32_t part_id : 8;
    uint32_t res5 : 1;
    uint32_t qos : 4;
    uint32_t res6 : 16;
    uint32_t pc_addr_low;
    uint32_t pc_addr_high : 16;
    uint32_t res7 : 16;
    uint32_t param_addr_low;
    uint32_t param_addr_high;
    uint32_t res8[4];
};

struct hwts_kernel_sqe_t {
    uint16_t type : 6;
    uint16_t graph_lock : 1;
    uint16_t graph_unlock : 1;
    uint16_t ie : 1;
    uint16_t pre_p : 1;
    uint16_t post_p : 1;
    uint16_t wr_cqe : 1;
    uint16_t rd_cond : 1;
    uint16_t reserved : 1;
    uint16_t l2_lock : 1;
    uint16_t l2_unlock : 1;
    uint16_t block_dim;
    uint16_t rt_stream_id;
    uint16_t task_id;
    uint32_t pc_addr_low;
    uint32_t pc_addr_high : 16;
    uint32_t kernel_credit : 8;
    uint32_t res0 : 3;
    uint32_t prefetch_cnt : 5;
    uint32_t param_addr_low;
    uint32_t param_addr_high : 16;
    uint32_t l2_in_main : 8;
    uint32_t res1 : 8;
    uint32_t literal_addr_low;
    uint32_t literal_addr_high : 16;
    uint32_t res2 : 16;
    uint32_t literal_base_ub;
    uint32_t res3;
    uint32_t sta_mode : 1;
    uint32_t literal_buff_len : 31;
    uint32_t res4;
    uint32_t p_l2ctrl_low;
    uint32_t p_l2ctrl_high : 16;
    uint32_t res5 : 16;
    uint32_t res6;
    uint32_t res7;
};

struct rtDavidStarsSqeHeader_t {
    /* word0 */
    uint8_t type : 6;
    uint8_t lock : 1;
    uint8_t unlock : 1;
    uint8_t ie : 1;
    uint8_t preP : 1;
    uint8_t postP : 1;
    uint8_t wrCqe : 1;
    uint8_t ptrMode : 1;
    uint8_t rttMode : 1;
    uint8_t headUpdate : 1;
    uint8_t reserved : 1;
    uint16_t blockDim;

    /* word1 */
    uint16_t rtStreamId;
    uint16_t taskId;
};

struct rtDavidStarsSqeTail_t {
    /* word7 */
    uint16_t aivPmg : 2;
    uint16_t aivNs : 1; // nonuse
    uint16_t aivPartId : 8;
    uint16_t res4 : 1;
    uint16_t aivQos : 4;
    uint16_t aivWrrRd : 3;
    uint16_t aivWrrWr : 3;
    uint16_t schem : 2;
    uint16_t ratio : 8;

    /* word8-9 */
    uint32_t aicStartPcLow;
    uint32_t aivStartPcLow;

    /* word10 */
    uint16_t aicStartPcHigh;
    uint16_t aivStartPcHigh;

    /* word11-15 */
    uint32_t aivSimtDcuSmSize;
    uint32_t aicTaskParamPtrLow;
    uint32_t aicTaskParamPtrHigh;
    uint32_t aivTaskParamPtrLow;
    uint32_t aivTaskParamPtrHigh;
};

struct rtDavidStarsAicAivSqeCloudV4 {
    /* word0-1 */
    rtDavidStarsSqeHeader_t header;

    /* word2 */
    uint16_t groupDim;
    uint16_t groupBlockDim;

    /* word3 */
    uint8_t featureFlag;
    uint8_t res1;
    uint8_t kernelCredit;
    uint8_t dieFriendly : 1;
    uint8_t mix : 1;
    uint8_t loose : 1;
    uint8_t res2 : 2;
    uint8_t sqeLength : 3;

    /* word4-5 */
    uint32_t stackPhyBaseLow;
    uint32_t stackPhyBaseHigh;

    /* word6 */
    uint16_t aicPmg : 2;
    uint16_t aicNs : 1; // nonuse
    uint16_t aicPartId : 8;
    uint16_t piMix : 1;
    uint16_t aicQos : 4;
    uint16_t aicWrrRd : 3;
    uint16_t aicWrrWr : 3;
    uint16_t aicIcachePrefetchCnt : 5;
    uint16_t aivIcachePrefetchCnt : 5;
    /* word7-15 */
    rtDavidStarsSqeTail_t tail;
};

struct rtDavidStarsAicAivSqeCloudV5 {
    /* word0-1 */
    rtDavidStarsSqeHeader_t header;

    /* word2 */
    uint16_t groupDim;
    uint16_t groupBlockdim;

    /* word3 */
    uint8_t featureFlag;
    uint8_t res1;
    uint8_t kernelCredit;
    uint8_t dieFriendly : 1;
    uint8_t mix : 1;
    uint8_t loose : 1;
    uint8_t res2 : 1;
    uint8_t ost : 1;
    uint8_t sqeLength : 3;

    /* word4 */
    uint16_t aicMtePortArOstd : 8;
    uint16_t aicMtePortAwOstd : 8;
    uint16_t aivMtePortArOstd : 8;
    uint16_t aivMtePortAwOstd : 8;

    /* word5 */
    uint16_t aivDcachePrefetchCnt : 7;
    uint16_t res5 : 1;
    uint16_t aicDcachePrefetchCnt : 7;
    uint16_t res6 : 1;
    uint16_t aivIcachePrefetchCnt : 7;
    uint16_t res7 : 1;
    uint16_t aicIcachePrefetchCnt : 7;
    uint16_t res8 : 1;

    /* word6 */
    uint16_t aicPmg : 2;
    uint16_t aicNs : 1; // nonuse
    uint16_t aicPartId : 8;
    uint16_t piMix : 1;
    uint16_t aicQos : 4;
    uint16_t aicWrrRd : 3;
    uint16_t aicWrrWr : 3;
    uint16_t getNxtTaskMode : 1;
    uint16_t res9 : 1;
    // 0 represents enabled, and 1 represents disabled.
    uint16_t aicPreAllocateDisable : 1;
    uint16_t aivPreAllocateDisable : 1;
    uint16_t res10 : 6;

    /* word7-15 */
    rtDavidStarsSqeTail_t tail;
};

void AddOneStatDumpTaskV1(uint8_t* sqeIn, KfcDumpOpInitParam* dumpParam, KfcDumpContext* dumpContext);
void AddOneStatDumpTaskV2(uint8_t* sqeIn, KfcDumpOpInitParam* dumpParam, KfcDumpContext* dumpContext);
void AddOneStatDumpTaskV2Part2(hwts_kernel_sqe_t& sqeIn, KfcDumpContext* dumpContext);
void AddStatDumpTaskCloudV4(uint8_t* sqeIn, KfcDumpOpInitParam* dumpParam, KfcDumpContext* dumpContext);
void AddStatDumpTaskCloudV5(uint8_t* sqeIn, KfcDumpOpInitParam* dumpParam, KfcDumpContext* dumpContext);
class KfcDumpTaskDispatcher {
public:
    static KfcDumpResult LaunchTask(uint8_t* sqeAddr, KfcDumpStreamCtx* kfcDumpStreamInfo);
    static KfcDumpResult QuerySqBaseAddr(uint32_t devId, uint32_t sqId, uint64_t& outVal);
    static KfcDumpResult QuerySqStatusByType(int32_t devId, uint32_t sqId, drvSqCqPropType_t type, uint32_t& outVal);
    static KfcDumpResult ConfigSqStatusByType(int32_t devId, uint32_t sqId, drvSqCqPropType_t type, uint32_t value);
};
} // namespace kfc_dump_stats
#endif // DUMP_STATS_TASK_H
