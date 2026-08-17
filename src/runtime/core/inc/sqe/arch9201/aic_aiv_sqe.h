/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_ARCH9201_AIC_AIV_SQE_H
#define CCE_RUNTIME_ARCH9201_AIC_AIV_SQE_H

#include "starsv2_base.hpp"

namespace cce {
namespace runtime {
#pragma pack(push)
#pragma pack(1)
struct RtArch9201StarsAicAivKernelSqe {
    /* word 0-1 */
    rtDavidStarsSqeHeader_t header;

    /* word2 */
    uint16_t groupDim;
    uint16_t groupBlockdim;

    /* word3 */
    uint8_t featureFlag; // used for DATADUMP BIUPERF L2CACHE DCACHE LOCK flag
    uint8_t res1;
    uint8_t kernelCredit;
    uint8_t dieFriendly : 1;
    uint8_t mix : 1;
    uint8_t loose : 1;
    uint8_t res2 : 1;
    uint8_t ost : 1;
    uint8_t sqeLength : 3;

    /* word 4 */
    uint16_t aicMtePortArOstd : 8;
    uint16_t aicMtePortAwOstd : 8;
    uint16_t aivMtePortArOstd : 8;
    uint16_t aivMtePortAwOstd : 8;

    /* word 5 */
    uint16_t aivDcachePrefetchCnt : 7;
    uint16_t res3 : 1;
    uint16_t aicDcachePrefetchCnt : 7;
    uint16_t res4 : 1;
    uint16_t aivIcachePrefetchCnt : 7;
    uint16_t res5 : 1;
    uint16_t aicIcachePrefetchCnt : 7;
    uint16_t res6 : 1;

    /* word6 */
    uint16_t aicPmg : 2;
    uint16_t aicNs : 1; // nonuse
    uint16_t aicPartId : 8;
    uint16_t piMix : 1;
    uint16_t aicQos : 4;
    uint16_t aicWrrRd : 3;
    uint16_t aicWrrWr : 3;
    uint16_t getNxtTaskMode : 1;
    uint16_t res7 : 1;
    uint16_t aicPreAllocateDisable : 1;
    uint16_t aivPreAllocateDisable : 1;
    uint16_t res8 : 6;

    /* word7 */
    uint16_t aivPmg : 2;
    uint16_t aivNs : 1; // nonuse
    uint16_t aivPartId : 8;
    uint16_t res9 : 1;
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
#pragma pack(pop)

} // namespace runtime
} // namespace cce
#endif