/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "chunk_pool.h"
#include "securec.h"

namespace analysis {
namespace dvvp {
namespace common {
namespace memory {
using namespace analysis::dvvp::common::utils;
Chunk::Chunk(size_t bufferSize)
    : buffer_(nullptr), bufferSize_(bufferSize), usedSize_(0)
{
}

Chunk::~Chunk()
{
    Uninit();
}

bool Chunk::Init()
{
    if (bufferSize_ == 0) {
        return true;
    }

    buffer_ = static_cast<UNSIGNED_CHAR_PTR>(malloc(bufferSize_));
    if (buffer_ == nullptr) {
        return false;
    }

    Clear();

    return true;
}

void Chunk::Uninit()
{
    if (buffer_ != nullptr) {
        free(buffer_);
        buffer_ = nullptr;
    }
    bufferSize_ = 0;
}

void Chunk::Clear()
{
    if (buffer_ != nullptr) {
        (void)memset_s(buffer_, bufferSize_ * sizeof(unsigned char), 0, bufferSize_ * sizeof(unsigned char));
    }
    usedSize_ = 0;
}

uint8_t *Chunk::GetBuffer() const
{
    return buffer_;
}

size_t Chunk::GetUsedSize() const
{
    return usedSize_;
}

void Chunk::SetUsedSize(size_t size)
{
    usedSize_ = size;
}

size_t Chunk::GetFreeSize() const
{
    return bufferSize_ - usedSize_;
}

size_t Chunk::GetBufferSize() const
{
    return bufferSize_;
}

ChunkPool::ChunkPool(size_t poolSize, size_t chunkSize)
    : ResourcePool<Chunk, size_t>(poolSize, chunkSize)
{
}

ChunkPool::~ChunkPool()
{
}
}  // namespace memory
}  // namespace common
}  // namespace dvvp
}  // namespace analysis
