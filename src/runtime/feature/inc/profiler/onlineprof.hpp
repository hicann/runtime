/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_ONLINEPROF_HPP__
#define __CCE_RUNTIME_ONLINEPROF_HPP__

#include "base.hpp"
#include "runtime.hpp"
#include "device.hpp"
#include "stream.hpp"

namespace cce {
namespace runtime {
constexpr uint32_t ONLINEPROF_MEM_SIZE = 0x100000;
constexpr uint32_t MAX_ONLINEPROF_NUM = 0x1FFFU; // 8K-1
constexpr uint32_t ONLINEPROF_HEAD_SIZE = 128;

class OnlineProf {
public:
    static rtError_t OnlineProfMalloc(Stream * const stm);
    static rtError_t OnlineProfFree(Stream * const stm);
    static rtError_t GetOnlineProfilingData(const Stream * const stm, rtProfDataInfo_t * const pProfData,
        const uint32_t profDataNum);
};
}
}
#endif  // __CCE_RUNTIME_ONLINEPROF_HPP__
