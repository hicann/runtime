/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_MEMCPY_SQE_H
#define CCE_RUNTIME_MEMCPY_SQE_H

#include "memcpy_sqe_common.h"

namespace cce {
namespace runtime {
#pragma pack(push)
#pragma pack (1)

struct RtDavidStarsMemcpySqe {
    /* word0-1 */
    rtDavidStarsSqeHeader_t header;

    /* word2 */
    uint32_t res1;

    /* word3 */
    uint16_t res2;
    uint8_t kernelCredit;
    uint8_t res3;

    /* word4 */
    uint32_t opcode : 8;
    uint32_t sssv : 1;
    uint32_t dssv : 1;
    uint32_t sns : 1;
    uint32_t dns : 1;
    uint32_t sro : 1;
    uint32_t dro : 1;
    uint32_t stride : 2;
    uint32_t ie2 : 1;
    uint32_t compEn : 1;
    uint32_t allocate : 1;
    uint32_t victimHint : 1;

    uint32_t vaValid : 1; // reserve
    uint32_t res4 : 10;

    /* word5 */
    uint16_t sqeId;
    uint8_t mapamPartId;
    uint8_t mpamns : 1;
    uint8_t pmg : 2;
    uint8_t qos : 4;
    uint8_t d2dOffsetFlag : 1;       // use reserved filed

    /* word6 */
    uint16_t srcStreamId;
    uint16_t srcSubStreamId;

    /* word7-15 */
    union {
        MemcpyStride00 strideMode0;
        MemcpyStride01 strideMode1;
        MemcpyStride10 strideMode2;
    } u;
};

struct RtDavidStarsCmoSqe {
    /* word0-1 */
    rtDavidStarsSqeHeader_t header;

    /* word2 */
    uint32_t cmoType : 2;
    uint32_t cmoId: 12;
    uint32_t res1 : 18;

    /* word3 */
    uint16_t res2;
    uint8_t kernelCredit;
    uint8_t res3;

    /* word4 */
    uint32_t opcode : 8;
    uint32_t sssv : 1;
    uint32_t dssv : 1;
    uint32_t sns : 1;
    uint32_t dns : 1;
    uint32_t sro : 1;
    uint32_t dro : 1;
    uint32_t stride : 2;
    uint32_t ie2 : 1;
    uint32_t compEn : 1;
    uint32_t allocate : 1;
    uint32_t victimHint : 2;
    uint32_t res4 : 11;

    /* word5 */
    uint16_t sqeId;
    uint8_t mapamPartId;
    uint8_t mpamns : 1;
    uint8_t pmg : 2;
    uint8_t qos : 4;
    uint8_t d2dOffsetFlag : 1;

    /* word6 */
    uint16_t srcStreamId;
    uint16_t srcSubStreamId;

    /* word7-15 */
    union {
        CmoStride00 strideMode0;
        CmoStride01 strideMode1;
        CmoStride10 strideMode2;
    } u;
};

#pragma pack(pop)
}
}
#endif