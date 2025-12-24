/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "args_handle_allocator.hpp"

namespace cce {
namespace runtime {
ArgsHandleAllocator::ArgsHandleAllocator() : localArgsHandle_(nullptr)
{
    const rtError_t ret = CreateInnerArgsHandle();
    COND_PROC(ret != RT_ERROR_NONE, localArgsHandle_ = nullptr);
}

ArgsHandleAllocator::~ArgsHandleAllocator()
{
    if (localArgsHandle_ == nullptr) {
        return;
    }

    if (localArgsHandle_->buffer != nullptr) {
        uint8_t *buf = RtPtrToPtr<uint8_t *, void *>(localArgsHandle_->buffer);
        DELETE_A(buf);
    }

    uint8_t *argsHandleBuff = RtPtrToPtr<uint8_t *, RtArgsHandle *>(localArgsHandle_);
    DELETE_A(argsHandleBuff);

    return;
}

rtError_t ArgsHandleAllocator::CreateInnerArgsHandle()
{
    if (localArgsHandle_ == nullptr) {
        size_t size = sizeof(RtArgsHandle) + (sizeof(ParaDetail) * MAX_PARAM_CNT);
        uint8_t *argsHandleBuff = new (std::nothrow) uint8_t[size];
        COND_RETURN_ERROR(argsHandleBuff == nullptr, RT_ERROR_MEMORY_ALLOCATION, "new args handle failed");
        localArgsHandle_ = RtPtrToPtr<RtArgsHandle *, uint8_t *>(argsHandleBuff);
        uint8_t *buffer = new (std::nothrow) uint8_t[MAX_ARGS_BUFF_SIZE];
        if (buffer == nullptr) {
            DELETE_A(argsHandleBuff);
            return RT_ERROR_MEMORY_ALLOCATION;
        }
        localArgsHandle_->buffer = buffer;
    }

    return RT_ERROR_NONE;
}

}
}