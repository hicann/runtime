/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_STARS_DMA_HPP__
#define __CCE_RUNTIME_STARS_DMA_HPP__

#include "task_info.hpp"
#include "stars_base.hpp"

namespace cce {
namespace runtime {

#pragma pack(push)
#pragma pack (1)

struct rtStarsSdmaSqe_t {
    uint32_t opcode : 8;
    uint32_t ie2 : 1;
    uint32_t sssv : 1;
    uint32_t dssv : 1;
    uint32_t sns : 1;
    uint32_t dns : 1;
    uint32_t qos : 4;
    uint32_t sro : 1;
    uint32_t dro : 1;
    uint32_t partid : 8;
    uint32_t mpam : 1;
    uint32_t pmg : 2;
    uint32_t format : 1;
    uint32_t res6 : 1;

    uint16_t srcStreamId;
    uint16_t src_sub_streamid;
    uint16_t dst_streamid;
    uint16_t dstSubStreamId;

    uint32_t length;
};

struct RtStarsPcieDmaSqe {
    /* word0~1 */
    rtStarsSqeHeader_t header;

    /* word2 */
    uint32_t res0;

    /* word3 */
    uint16_t res1;
    uint16_t kernelCredit : 8;
    uint16_t res2 : 8;

    /* word4 */
    uint32_t sq_addr_low;

    /* word5 */
    uint32_t sq_addr_high;

    /* word6 */
    uint16_t sq_tail_ptr;
    uint16_t res3;

    /* word7 */
    uint32_t isConverted : 1;
    uint32_t isDsaUpdate : 1;
    uint32_t isSqeUpdate : 1;
    uint32_t offset : 8;
    uint32_t res4 : 21;
    /* word8~11 */
    uint64_t src;
    uint64_t dst;
    /* word12-15 */
    uint64_t length;
    uint32_t passid;
    uint32_t res5;
};

struct RtStarsRdmaSinkSqe1 {
    rtStarsSqeHeader_t sqeHeader;

    uint8_t condsSubType;  
    uint8_t reserved0[3];
    uint16_t reserved1;
    uint8_t kernelCredit;
    uint8_t reserved2 : 7;
    uint8_t csc : 1;

    RtStarsCondOpLoadImm lhu;
    RtStarsCondOpImmSLLI slli1;
    RtStarsCondOpImm addi;
    RtStarsCondOpLHWI lhwi;
    RtStarsCondOpLLWI llwi;
    RtStarsCondOpOp and1;
    RtStarsCondOpImmSLLI slli2;
    RtStarsCondOpNop nop[3];
};

struct RtStarsRdmaSinkSqe2 {
    rtStarsSqeHeader_t sqeHeader;

    uint8_t condsSubType;  
    uint8_t reserved0[3];
    uint16_t reserved1;
    uint8_t kernelCredit;
    uint8_t reserved2 : 7;
    uint8_t csc : 1;

    RtStarsCondOpLHWI lhwi1;
    RtStarsCondOpLLWI llwi1;
    RtStarsCondOpOp or1;
    RtStarsCondOpLHWI lhwi2;
    RtStarsCondOpLLWI llwi2;
    RtStarsCondOpLLWI llwi3;
    RtStarsCondOpSystemCsr csrrc;
    RtStarsCondOpStore sd;
    RtStarsCondOpSystemCsr csrrs;
};

struct RtStarsMemcpyAsyncSqe {
    rtStarsSqeHeader_t header;

    uint32_t res3;
    /********12 bytes**********/

    uint16_t res4; // max_retry(u8) retry_cnt(u8)
    uint8_t kernelCredit;
    uint8_t ptrMode : 1;
    uint8_t res5 : 7;
    /********16 bytes**********/

    uint32_t opcode : 8;
    uint32_t ie2 : 1;
    uint32_t sssv : 1;
    uint32_t dssv : 1;
    uint32_t sns : 1;
    uint32_t dns : 1;
    uint32_t qos : 4;
    uint32_t sro : 1;
    uint32_t dro : 1;
    uint32_t partid : 8;
    uint32_t mpam : 1;
    uint32_t d2dOffsetFlag : 1;
    uint32_t res6 : 3;
    /********20 bytes**********/

    uint16_t src_streamid;
    uint16_t src_sub_streamid;
    uint16_t dst_streamid;
    uint16_t dstSubStreamId;
    /********28 bytes**********/

    uint32_t length;
    uint32_t src_addr_low;
    uint32_t src_addr_high;
    uint32_t dst_addr_low;
    uint32_t dst_addr_high;

    uint32_t srcOffsetLow;
    uint32_t dstOffsetLow;
    uint16_t srcOffsetHigh;
    uint16_t dstOffsetHigh;
    uint32_t resLast[1];
};

struct RtStarsMemcpyAsyncPtrSqe {
    rtStarsSqeHeader_t header;

    uint32_t res3;
    /********12 bytes**********/

    uint16_t res4; // max_retry(u8) retry_cnt(u8)
    uint8_t kernelCredit;
    uint8_t ptrMode : 1;
    uint8_t res5 : 7;
    /********16 bytes**********/

    uint32_t sdmaSqeBaseAddrLow;
    uint32_t sdmaSqeBaseAddrHigh : 17;
    uint32_t res6 : 14;
    uint32_t va : 1;
    uint32_t resLast[10];
};

struct RtLiteStarsSdmaPyload {
    /* dw0 */
    uint32_t opcode          : 8;
    uint32_t sssv            : 1;
    uint32_t dssv            : 1;
    uint32_t sns             : 1;
    uint32_t dns             : 1;
    uint32_t sro             : 1;
    uint32_t dro             : 1;
    uint32_t stride          : 2;
    uint32_t ie              : 1;
    uint32_t compEn          : 1;
    uint32_t reserved0      : 14;
    /* dw1 */
    uint32_t sqeId          : 16;
    uint32_t mpamPartid      : 8;
    uint32_t mpamns          : 1;
    uint32_t pmg             : 2;
    uint32_t qos             : 4;
    uint32_t reserved1       : 1;
    /* dw2 */
    uint32_t srcStreamid    : 16;
    uint32_t srcSubstreamid : 16;
    /* dw3 */
    uint32_t dstStreamid    : 16;
    uint32_t dstSubstreamid : 16;
    /* dw4 dw5 */
    uint32_t srcAddrL;
    uint32_t srcAddrH;
    /* dw6 dw7 */
    uint32_t dstAddrL;
    uint32_t dstAddrH;
    /* dw8 */
    uint32_t lengthMove    : 32;
    /* dw9 dw10 dw11 */
    uint32_t srcStrideLen  : 32;
    uint32_t dstStrideLen  : 32;
    uint32_t strideNum     : 32;
};

struct RtLiteStarsSqeHeadDw0 {
    uint32_t type : 6;
    uint32_t reserved0 : 2;
    uint32_t ie : 2;
    uint32_t prePaused : 2;
    uint32_t postPaused : 2;
    uint32_t wrCqe : 1;
    uint32_t reserved1 : 1;
    uint32_t reserved2 : 16;
};

struct RtLiteStarsSqeHeadDw1 {
    uint32_t rtStreamId : 16;
    uint32_t taskId: 16;
};

struct RtLiteStarsSqeHeadDw2 {
    uint32_t eventId : 16;
    uint32_t reserved0 : 16;
};

struct RtLiteStarsSqeHeadDw3 {
    uint32_t sqeIndex : 16;
    uint32_t kernelCdt : 8;
    uint32_t reserved0 : 7;
    uint32_t clr : 1;
};

struct RtLiteStarsSqeHead {
    struct RtLiteStarsSqeHeadDw0 dw0;
    struct RtLiteStarsSqeHeadDw1 dw1;
    struct RtLiteStarsSqeHeadDw2 dw2;
    struct RtLiteStarsSqeHeadDw3 dw3;
};

struct RtLiteStarsSdmaSqe {
    struct RtLiteStarsSqeHead head;
    struct RtLiteStarsSdmaPyload sdmaSqe;
};

struct RdmaSqePayloadDw0 {
    uint32_t rdmaQpAddrLow;
};

struct RdmaSqePayloadDw1 {
    uint32_t rdmaQpAddrHigh;
};

struct RdmaSqePayloadDw2 {
    uint32_t tag : 24;
    uint32_t cmd : 4;
    uint32_t reserved : 3;
    uint32_t flag : 1;
};

struct RdmaSqePayloadDw3 {
    uint32_t param;
};

struct RdmaSqePayloadDw4 {
    uint32_t waitCqeNum : 16;
    uint32_t hacFuncId : 8;
    uint32_t qpVa : 1;
    uint32_t ssv : 1;
    uint32_t reserved : 6;
};

struct RdmaSqePayloadDw5 {
    uint32_t rdmaSmmuStreamid : 16;
    uint32_t rdmaSmmuSubstreamid : 16;
};

struct RtLiteStarsRdmaPyload {
    struct RdmaSqePayloadDw0 payloadDw0;
    struct RdmaSqePayloadDw1 payloadDw1;
    struct RdmaSqePayloadDw2 payloadDw2;
    struct RdmaSqePayloadDw3 payloadDw3;
    struct RdmaSqePayloadDw4 payloadDw4;
    struct RdmaSqePayloadDw5 payloadDw5;
    uint32_t reserved[6];
};

struct RtLiteStarsRdmaSqe {
    struct RtLiteStarsSqeHead head;
    struct RtLiteStarsRdmaPyload rdmaSqe;
};

#pragma pack(pop)

}  // namespace runtime
}  // namespace cce
#endif  // __CCE_RUNTIME_STARS_DMA_HPP__