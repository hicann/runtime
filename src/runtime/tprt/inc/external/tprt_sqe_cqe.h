/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TPRT_SQE_CQE_H
#define TPRT_SQE_CQE_H

#include <stdbool.h>
#include <stdint.h>

#if defined(__cplusplus)
extern "C" {
#endif
enum TprtSqeType : uint8_t {
    TPRT_SQE_TYPE_AICPU             = 0, // AICPU
    TPRT_SQE_TYPE_INVALID             = 1,
};

enum TprtErrorType : uint8_t {
    TPRT_EXIST_ERROR             = 1U,
    TPRT_EXIST_TIMEOUT             = 2U,
};

#define TPRT_SQE_LENGTH (sizeof(TprtSqe_t))
#pragma pack(push)
#pragma pack (1)

struct TprtCqeReport_t {
    uint32_t taskSn;
    uint32_t errorCode;    // cqe acc_status/sq_sw_status
    uint8_t errorType;     // bit0 ~ bit5 cqe stars_defined_err_code, bit 6 cqe warning bit
    uint8_t sqeType;
    uint16_t sqId;
    uint16_t sqHead;
};

struct TprtStarsSqeHeader_t {
    uint8_t type;
    uint8_t wrCqe : 2;
    uint8_t sqeLength : 6; // 0: 64B, N:(N+1) * 64B
    uint16_t sqId;

    uint32_t taskSn;
};
struct TprtStarsAicpuSqe {
    /* word0-1 */
    TprtStarsSqeHeader_t header;
    /* word2 - 3 */
    uint64_t startPcAddr;

    /* word4 - 5 */
    uint64_t argsAddr;

    uint32_t timeout;
    /* word7-15 */
    uint32_t res[9];
};

struct TprtStarsCommonSqe_t {
    /* word0-1 */
    TprtStarsSqeHeader_t sqeHeader;

    /* word2-15 */
    uint32_t commandCustom[14];       // word 2-15 is custom define by command.
};


union TprtSqe_t {
    TprtStarsCommonSqe_t commonSqe;
    TprtStarsAicpuSqe aicpuSqe;
};
#pragma pack(pop)

#if defined(__cplusplus)
}
#endif

#endif