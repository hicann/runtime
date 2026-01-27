/**
    * Copyright (c) 2025 Huawei Technologies Co., Ltd.
    * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
    * CANN Open Software License Agreement Version 2.0 (the "License").
    * Please refer to the License for details. You may not use this file except in compliance with the License.
    * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
    * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
    * See LICENSE in the root of the software repository for the full text of the License.
    */

#ifndef CCE_RUNTIME_STARSV2_BASE_H
#define CCE_RUNTIME_STARSV2_BASE_H

namespace cce {
namespace runtime {
#pragma pack(push)
#pragma pack (1)

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

struct rtDavidStarsCommonSqe_t {
    rtDavidStarsSqeHeader_t sqeHeader;  // word 0-1
    uint32_t commandCustom[14];       // word 2-15 is custom define by command.
};

// user should give the right src and dst address, and the right len
struct rtDavidMemcpyAddrInfo {
    uint64_t res0[4];
    uint64_t src;
    uint64_t dst;
    uint32_t len;
    uint32_t res1[3];
};

struct rtDavidCmoAddrInfo {
    uint32_t resv0[7];
    uint16_t num_outer;
    uint16_t num_inner;
    uint64_t src;
    uint32_t stride_outer;
    uint32_t stride_inner;
    uint32_t len_inner;
    uint32_t resv1[3];
};
#pragma pack(pop)
}
}
#endif