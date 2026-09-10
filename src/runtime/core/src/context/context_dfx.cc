/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "context.hpp"
#include "model.hpp"

namespace cce {
namespace runtime {

rtError_t Context::ModelGetNodes(const Model* const mdl, uint32_t* const num)
{
    /* model can not bind or unbind while get nodes */
    std::unique_lock<std::mutex> taskLock(streamLock_);
    *num = mdl->ModelGetNodes();
    return RT_ERROR_NONE;
}

rtError_t Context::ModelDebugDotPrint(const Model* const mdl)
{
    std::unique_lock<std::mutex> taskLock(streamLock_);
    return mdl->ModelDebugDotPrint();
}

rtError_t Context::ModelDebugJsonPrint(const Model* const mdl, const char* path, const uint32_t flags)
{
    std::unique_lock<std::mutex> taskLock(streamLock_);
    return mdl->ModelDebugJsonPrint(path, flags);
}

} // namespace runtime
} // namespace cce
