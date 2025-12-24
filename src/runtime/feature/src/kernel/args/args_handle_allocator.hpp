/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_ARGS_HANDLE_ALLOCATOR_HPP
#define RUNTIME_ARGS_HANDLE_ALLOCATOR_HPP

#include "base.hpp"
#include "osal.hpp"

namespace cce {
namespace runtime {
constexpr uint8_t SPECIAL_ARGS_MAX_CNT = 128U;
constexpr uint8_t MAX_PARAM_CNT = 128U;
constexpr size_t MAX_ARGS_BUFF_SIZE = 64U * 1024U;
constexpr size_t MAX_SYSTEM_PARAM_CNT = 8U;

class ArgsHandleAllocator {
public:
    ArgsHandleAllocator();
    ~ArgsHandleAllocator();
    RtArgsHandle *localArgsHandle_ = nullptr;
private:
    rtError_t CreateInnerArgsHandle();
};
}
}
#endif // RUNTIME_ARGS_HANDLE_ALLOCATOR_HPP