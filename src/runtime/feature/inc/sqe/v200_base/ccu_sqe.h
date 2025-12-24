/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_STARSV2_CCU_SQE_H
#define CCE_RUNTIME_STARSV2_CCU_SQE_H

#include "task_info_base.hpp"
#include "starsv2_base.hpp"

namespace cce {
namespace runtime {
#pragma pack(push)
#pragma pack (1)

union CcuResv {
    // for fusion kernel sub task
    struct {
        uint16_t missionId : 4;
        uint16_t dieId : 2;
        uint16_t ccuSize : 1;
        uint16_t res1 : 3;
        uint16_t aic : 1;
        uint16_t subType : 5;
    } ccuResvDesc1;
    struct {
        uint16_t missionId : 4;
        uint16_t dieId : 2;
        uint16_t ccuSize : 1;
        uint16_t res1 : 9;
    } ccuResvDesc2;
};

struct RtStarsV2CcuSqe {
    /* word0-1 */
    rtStarsV2SqeHeader_t header;

    /* word2 */
    CcuResv resv;
    uint16_t taskCnt : 3;
    uint16_t res2 : 13;

    /* word3 */
    uint16_t timeout;
    uint8_t kernelCredit;
    uint8_t res4 : 5;
    uint8_t sqeLength : 3;

    /* word4 */
    uint16_t instStartId;
    uint16_t instCnt;

    /* word5 */
    uint32_t instAddrKeyValue;

    /* word6-15 */
    uint32_t usrData[CCU_1ST_SQE_ARGS_LEN];
};

struct RtStarsV2CcuSqe32B {
    /* word0-1 */
    rtStarsV2SqeHeader_t header;

    /* word2 */
    CcuResv resv;
    uint16_t taskCnt : 3;
    uint16_t res2 : 13;

    /* word3 */
    uint16_t timeout;
    uint8_t kernelCredit;
    uint8_t res4 : 5;
    uint8_t sqeLength : 3;

    /* word4 */
    uint16_t instStartId;
    uint16_t instCnt;

    /* word5 */
    uint32_t instAddrKeyValue;

    /* word6-7 */
    uint32_t usrData[2];
};

#pragma pack(pop)
}
}
#endif
