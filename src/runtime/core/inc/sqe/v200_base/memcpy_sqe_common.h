/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_MEMCPY_SQE_COMMON_H
#define CCE_RUNTIME_MEMCPY_SQE_COMMON_H

#include <cstdint>
#include "task_info_base.hpp"

namespace cce {
namespace runtime {
#pragma pack(push)
#pragma pack (1)

// MemAsync
struct MemcpyStride00 {
    /* word7 */
    uint16_t dstStreamId;
    uint16_t dstSubStreamId;

    /* word8-9 */
    uint32_t srcAddrLow;
    uint32_t srcAddrHigh;

    /* word10-11 */
    uint32_t dstAddrLow;
    uint32_t dstAddrHigh;

    /* word12 */
    uint32_t lengthMove;

    /* word13-15 */
    uint32_t srcOffsetLow;
    uint32_t dstOffsetLow;
    uint16_t srcOffsetHigh;
    uint16_t dstOffsetHigh;
};

struct MemcpyStride01 {
    /* word7 */
    uint16_t dstStreamId;
    uint16_t dstSubStreamId;

    /* word8-9 */
    uint32_t srcAddrLow;
    uint32_t srcAddrHigh;

    /* word10-11 */
    uint32_t dstAddrLow;
    uint32_t dstAddrHigh;

    /* word12 */
    uint32_t lengthMove;

    /* word13-15 */
    uint32_t srcStrideLength;
    uint32_t dstStrideLength;
    uint32_t strideNum;
};

struct MemcpyStride10 {
    /* word7 */
    uint16_t numOuter;
    uint16_t numInner;

    /* word8-9 */
    uint32_t srcAddrLow;
    uint32_t srcAddrHigh;

    /* word10-11 */
    uint32_t strideOuter;
    uint32_t strideInner;

    /* word12 */
    uint32_t lengthInner;

    /* word13-15 */
    uint32_t reserved[3];
};

struct CmoStride00 {
    /* word7 */
    uint32_t res4;

    /* word8-9 */
    uint32_t srcAddrLow;
    uint32_t srcAddrHigh;

    /* word10-11 */
    uint32_t res5;
    uint32_t res6;

    /* word12 */
    uint32_t lengthMove;

    /* word13-15 */
    uint32_t res7;
    uint32_t res8;
    uint32_t res9;
};

struct CmoStride01 {
    /* word7 */
    uint32_t res4;

    /* word8-9 */
    uint32_t srcAddrLow;
    uint32_t srcAddrHigh;

    /* word10-11 */
    uint32_t res5;
    uint32_t res6;

    /* word12 */
    uint32_t lengthMove;

    /* word13-15 */
    uint32_t srcStrideLength;
    uint32_t res7;
    uint32_t strideNum;
};

struct CmoStride10 {
    /* word7 */
    uint16_t numOuter;
    uint16_t numInner;

    /* word8-9 */
    uint32_t srcAddrLow;
    uint32_t srcAddrHigh;

    /* word10-11 */
    uint32_t strideOuter;
    uint32_t strideInner;

    /* word12 */
    uint32_t lengthInner;

    /* word13-15 */
    uint32_t reserved[3];
};

struct RtDavidStarsAsyncDmaSqe {
    /* word0-1 */
    rtDavidStarsSqeHeader_t header;

    /* word2 */
    uint16_t mode : 1;
    uint16_t wqeSize : 1;
    uint16_t res1 : 14;
    uint16_t res2;

    /* word3 */
    uint16_t res3;
    uint8_t kernelCredit;
    uint8_t res4 : 5;
    uint8_t sqeLength : 3;

    /* word4 */
    uint32_t jettyId : 16;
    uint32_t res5 : 9;
    uint32_t funcId : 7;

    /* word5 */
    uint32_t res6 : 31;
    uint32_t dieId : 1;
    /* word6-word15 */
    uint32_t res7[10];
};

struct RtDavidStarsPcieDmaSqe {
    /* word0-1 */
    rtDavidStarsSqeHeader_t header;

    /* word2 */
    uint32_t res1;

    /* word3 */
    uint16_t res2;
    uint8_t kernelCredit;
    uint8_t res3 : 5;
    uint8_t sqeLength : 3;

    /* word4 */
    uint32_t pcieDmaSqAddrLow;

    /* word5 */
    uint32_t pcieDmaSqAddrHigh;

    /* word6 */
    uint16_t pcieDmaSqTailPtr;
    uint16_t dieId : 1;
    uint16_t res4 : 15;

    /* word7 */
    uint32_t isConverted : 1;  //use reserved filed
    uint32_t res5 : 31;

    /* word8~11 */
    uint64_t src;  //use reserved filed
    uint64_t dst;  //use reserved filed

    /* word12-15 */
    uint64_t length;  //use reserved filed
    uint32_t passId;  //use reserved filed
    uint32_t res6;
};

struct RtDavidStarsMemcpyPtrSqe {
    /* word0-1 */
    rtDavidStarsSqeHeader_t header;

    /* word2 */
    uint32_t res1;

    /* word3 */
    uint16_t res2;
    uint8_t kernelCredit;
    uint8_t res3;

    /* word4 */
    uint32_t sdmaSqeBaseAddrLow;

    /* word5 */
    uint32_t sdmaSqeBaseAddrHigh : 17;
    uint32_t res4 : 14;
    uint32_t va : 1;

    /* word6-15 */
    uint32_t res5[10];
};
#pragma pack(pop)
}
}
#endif // CCE_RUNTIME_MEMCPY_SQE_COMMON_H