/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_STARS_STREAM_HPP__
#define __CCE_RUNTIME_STARS_STREAM_HPP__

#include "task_info.hpp"
#include "stars_base.hpp"

namespace cce {
namespace runtime {

#pragma pack(push)
#pragma pack (1)

struct RtStreamOverflowSwitch {
    uint16_t streamId;
    uint16_t isSwitchOn : 1;
    uint16_t rsv : 15;
    uint32_t reserved[11];
};

struct RtStreamSetTag {
    uint16_t streamId;
    uint16_t rsv;
    uint32_t geOpTag;
    uint32_t reserved[10];
};

struct RtStarsStreamSwitchSqe {
    rtStarsSqeHeader_t sqeHeader;

    uint8_t conds_sub_type;  // CONDS_SUB_TYPE_STREAM_SWITCH, 1910b tiny only
    uint8_t reserved0[3];
    uint16_t reserved1;
    uint8_t kernelCredit;
    uint8_t reserved2 : 7;
    uint8_t csc : 1;

    RtStarsCondOpLoadImm ldi;
    RtStarsCondOpLHWI lhwi;
    RtStarsCondOpLLWI llwi;
    RtStarsCondOpBranch bne;
    RtStarsCondOpStreamActiveI activeI;
    RtStarsCondOpLoop loop;
    RtStarsCondOpStreamDeActiveI deActiveI;
    RtStarsCondOpNop nop[3];
};

struct RtStarsStreamSwitchExSqe {
    rtStarsSqeHeader_t sqeHeader;

    uint8_t conds_sub_type;  // CONDS_SUB_TYPE_STREAM_SWITCH_EX, 1910b tiny only
    uint8_t reserved0[3];
    uint16_t reserved1;
    uint8_t kernel_credit;
    uint8_t reserved2 : 7;
    uint8_t csc : 1;

    RtStarsCondOpLoadImm var_ldi;
    RtStarsCondOpLoadImm valueLdi;
    RtStarsCondOpBranch bne;
    RtStarsCondOpStreamActiveI activeI;
    RtStarsCondOpLoop loop;
    RtStarsCondOpStreamDeActiveI deActiveI;
    RtStarsCondOpNop nop[4];
};

struct RtStarsStreamResetHeadSqe {
    rtStarsSqeHeader_t sqeHeader;

    uint32_t reserved0;
    uint16_t reserved1;
    uint8_t kernel_credit;
    uint8_t reserved2 : 7;
    uint8_t csc : 1;

    RtStarsCondOpLHWI lhwi1;
    RtStarsCondOpLLWI llwi1;
    RtStarsCondOpLLWI llwi2;
    RtStarsCondOpSystemCsr csrrc;
    RtStarsCondOpStore sw;
    RtStarsCondOpSystemCsr csrrs;
    RtStarsCondOpStreamGotoI goto_i;
    RtStarsCondOpNop nop[2];
};

#pragma pack(pop)

}  // namespace runtime
}  // namespace cce
#endif  // __CCE_RUNTIME_STARS_STREAM_HPP__