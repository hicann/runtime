/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_FFTS_HPP__
#define __CCE_RUNTIME_FFTS_HPP__

#include <map>
#include <vector>
#include "base.hpp"
#include "runtime/rt_ffts.h"

namespace cce {
namespace runtime {
class Stream;

// ticket cache window limit
constexpr uint8_t RT_FFTS_TICKET_CACHE_WINDOW_LIMIT = 16U;
// sub task length unit is 32 bytes, so mem size need 32 align
constexpr uint32_t RT_FFTS_SUB_TASK_LENGTH_UNIT = 32U;
constexpr uint16_t RT_MASK_BIT0_BIT1 = 0x3U;
constexpr uint16_t RT_MASK_BIT0_BIT11 = 0x0FFFU;
constexpr uint16_t RT_MASK_BIT12 = 0x1000U;
constexpr uint16_t RT_MASK_BIT13_BIT15 = 0xE000U;
constexpr uint16_t RT_MASK_BIT14_BIT15 = 0xC000U;
// the 12th bit of stream_id indicate whether task_id is update.
constexpr uint16_t RT_TASK_UPDATE_FLAG_BIT12 = 12U;
// the 13th and 12bit of stream_id (12:0, 13:1) indicate whether task_id is update by plan b.
constexpr uint16_t RT_TASK_UPDATE_FLAG_FOR_ALL = 0b10;
constexpr uint16_t RT_BEGIN_INDEX_OF_HCCL_INDEX = 13U;
constexpr uint16_t MAX_HCCL_STREAM_NUM = 8U;
constexpr uint16_t RT_MASK_BIT0_BIT14 = 0x7FFFU;
constexpr uint16_t RT_MASK_BIT15 = 0x8000U;
constexpr uint16_t RT_UPDATE_FOR_STREAM_EXTEND = 0b1;
constexpr uint16_t RT_UPDATE_FOR_STREAM_EXTEND_FLAG_BIT = 15U;

}
}
#endif // __CCE_RUNTIME_FFTS_HPP__
