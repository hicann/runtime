/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_STARS_KERNEL_HPP__
#define __CCE_RUNTIME_STARS_KERNEL_HPP__

#include "task_info.hpp"
#include "stars_base.hpp"

namespace cce {
namespace runtime {

#pragma pack(push)
#pragma pack (1)

struct RtStarsKernelSqe {
    rtStarsSqeHeader_t header;
    uint16_t ffts_type : 2;
    uint16_t res1 : 14;
    uint16_t res2 : 2;
    uint16_t qos : 4;
    uint16_t sat : 1;
    uint16_t res3 : 9;
    uint16_t res4;
    uint16_t kernel_credit : 8;
    uint16_t schem : 2;
    uint16_t res5 : 1;
    uint16_t prefetch_cnt : 5;
    uint32_t pc_addr_low;
    uint32_t pcAddrHigh : 16;
    uint32_t res6 : 16;
    uint32_t paramAddrLow;
    uint32_t param_addr_high : 16;
    uint32_t res7 : 16;
    uint32_t stackPhyBaseLow;
    uint32_t stackPhyBaseHigh;
    uint32_t res8[6];
};

struct RtStarsAicpuKernelSqe {
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

    /* word4-5 */
    uint32_t taskSoAddrLow;
    uint32_t taskSoAddrHigh : 16;
    uint32_t res3 : 16;

    /* word6-7 */
    uint32_t paramAddrLow;
    uint32_t param_addr_high : 16;
    uint32_t res4 : 16;

    /* word8-9 */
    uint32_t task_name_str_ptr_low;
    uint32_t task_name_str_ptr_high : 16;
    uint32_t res5 : 16;

    /* word10-11 */
    uint32_t pL2CtrlLow;
    uint32_t p_l2ctrl_high : 16;
    uint32_t overflow_en : 1;
    uint32_t dump_en : 1;
    uint32_t debug_dump_en : 1;
    uint32_t res6 : 13;

    /* word12-13 */
    uint32_t extraFieldLow;  // send task id info to aicpu
    uint32_t extra_field_high;

    /* word14 */
    uint32_t subTopicId : 12;
    uint32_t topicId : 6;
    uint32_t group_id : 6;
    uint32_t usr_data_len : 8;

    /* word15 */
    uint32_t dest_pid;
};

struct RtStarsDvppSqe {
    /* word0-1 */
    rtStarsSqeHeader_t sqeHeader;

    /* word2 */
    uint32_t cmdBufSize;

    /* word3 */
    uint16_t res0;
    uint16_t kernel_credit : 8;
    uint16_t ptrMode : 1;
    uint16_t task_pos : 7;

    /* word4-15 */
    uint32_t usrData[12];
};

struct RtCmoKernelSqe {
    rtStarsSqeHeader_t header;
    /********8 ~ 15 bytes**********/
    uint16_t fftsType : 3;
    uint16_t cmo : 1;
    uint16_t res1 : 8;
    uint16_t wrrRatio : 4;
    uint16_t res2;
    uint16_t sqe_index;
    uint16_t kernel_credit : 8;
    uint16_t schem : 2;
    uint16_t res3 : 1;
    uint16_t icachePrefetchCnt : 5;
    /********16 ~ 31 bytes**********/
    uint16_t cmo_type;
    uint16_t cmoId;
    uint32_t res4;
    uint32_t res5;
    uint32_t res6;
    /********32 ~ 35 bytes**********/
    uint32_t opcode : 8;
    uint32_t ie2 : 1;
    uint32_t sssv : 1;
    uint32_t dssv : 1;
    uint32_t sns : 1;
    uint32_t dns : 1;
    uint32_t qos : 4;
    uint32_t sro : 1;
    uint32_t dro : 1;
    uint32_t part_id : 8;
    uint32_t mpam : 1;
    uint32_t pmg : 2;
    uint32_t format : 1;
    uint32_t res7 : 1;
    /********36 ~  63 bytes**********/
    uint16_t srcStreamId;
    uint16_t srcSubStreamId;
    uint16_t numOuter;
    uint16_t numInner;
    uint32_t length;
    uint32_t src_addr_low;
    uint32_t src_addr_high;
    uint32_t stride_outer;
    uint32_t stride_inner;
};

struct RtFftsPlusKernelSqe {
    rtStarsSqeHeader_t header;
    uint16_t fftsType : 3;
    uint16_t res1 : 9;
    uint16_t wrr_ratio : 4;
    uint16_t res2;
    uint16_t sqe_index;
    uint16_t kernel_credit : 8;
    uint16_t schem : 2;
    uint16_t res3 : 1;
    uint16_t icache_prefetch_cnt : 5;
    uint32_t stackPhyBaseLow;
    uint32_t stackPhyBaseHigh;
    uint32_t res4;
    uint32_t pmg : 2;
    uint32_t ns : 1;
    uint32_t part_id : 8;
    uint32_t res5 : 1;
    uint32_t qos : 4;
    uint32_t res6 : 16;
    uint32_t pc_addr_low;
    uint32_t pcAddrHigh : 16;
    uint32_t res7 : 16;
    uint32_t paramAddrLow;
    uint32_t param_addr_high;
    // use res8[1] bit 4 for l2cache
    uint32_t res8[4];
};

struct rtBarrierCmoInfo_t {
    uint16_t cmo_type;
    uint16_t cmoId;
};

struct RtBarrierKernelSqe {
    rtStarsSqeHeader_t header;
    /********8 ~ 15 bytes**********/
    uint16_t fftsType : 3;
    uint16_t cmo : 1;
    uint16_t res1 : 8;
    uint16_t wrr_ratio : 4;
    uint16_t res2;
    uint16_t sqe_index;
    uint16_t kernel_credit : 8;
    uint16_t schem : 2;
    uint16_t res3 : 1;
    uint16_t icache_prefetch_cnt : 5;
    /********16 ~ 43 bytes**********/
    uint16_t cmo_type;
    uint16_t cmo_bitmap : 6;
    uint16_t res4 : 10;
    rtBarrierCmoInfo_t cmo_info[6];
    /********44 ~ 63 bytes**********/
    uint32_t res5[5];
};

struct RtStarsCdqmSqe {
    rtStarsSqeHeader_t sqeHeader;

    uint32_t sqe_index : 16;
    uint32_t res0 : 16;
    uint32_t res1 : 16;
    uint32_t kernelCredit : 8;
    uint32_t ptrMode : 1;
    uint32_t res3 : 7;

    uint32_t cdqeAddrLow;
    uint32_t cdqeAddrHigh : 17;
    uint32_t res4 : 14;
    uint32_t va : 1;

    uint32_t cdqeIndex : 16;
    uint32_t cdqId : 16;

    uint32_t die_id : 16;
    uint32_t res5 : 16;

    uint8_t cdqe[15]; /* word8-11 cdqe */
    uint8_t res6 : 7;
    uint8_t ready : 1;
    uint32_t res7[4];
};

struct RtStarsHostfuncCallbackSqe {
    /* word0-1 */
    rtStarsSqeHeader_t header;

    /* word2 */
    uint16_t res0;
    uint16_t kernel_type : 7;
    uint16_t batch_mode : 1;
    uint16_t topic_type : 4;
    uint16_t qos : 3;
    uint16_t res1 : 1;

    /* word3 */
    uint16_t sqe_index;
    uint16_t kernel_credit : 8;
    uint16_t res2 : 8;

    /* word4-5 */
    uint16_t cb_cq_id;
    uint16_t cb_group_id;
    uint16_t dev_id;
    uint16_t stream_id;

    /* word6-7 */
    uint16_t event_id;
    uint16_t isBlock;
    uint16_t task_id;
    uint16_t res4;

    /* word8-11 */
    uint32_t hostfunc_addr_low;
    uint32_t hostfuncAddrHigh;
    uint32_t fndata_low;
    uint32_t fndata_high;

    /* word12-13 */
    uint32_t res5;               // noly vf & topic AICPU & callback msg use for hostpid.
    uint32_t res6;

    /* word14 */
    uint32_t subTopicId : 12;
    uint32_t topicId : 6;
    uint32_t group_id : 6;
    uint32_t usr_data_len : 8;

    /* word15 */
    uint32_t dest_pid;
};

struct RtStarsEventSqe {
    rtStarsSqeHeader_t header;
    uint16_t eventId;
    uint16_t res2;

    uint16_t res3;
    uint8_t  kernelCredit;
    uint8_t  res4;
    uint32_t exe_result;
    uint32_t timeout;
    uint32_t res5[10];
};

struct RtStarsNotifySqe {
    rtStarsSqeHeader_t header;

    uint32_t notify_id : 13;
    uint32_t res2 : 19;

    uint16_t res3;
    uint8_t kernel_credit;
    uint8_t res4;
    uint32_t timeout;
    uint32_t res5[11];
};

#pragma pack(pop)

}  // namespace runtime
}  // namespace cce
#endif  // __CCE_RUNTIME_STARS_KERNEL_HPP__