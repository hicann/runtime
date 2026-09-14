/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CAPTURE_OPS_HPP
#define CCE_RUNTIME_CAPTURE_OPS_HPP

#include "runtime/base.h"
#include "runtime/rt_inner_model.h"

namespace cce {
namespace runtime {

class CondHandle;
class Context;
class ContextExtension;
class Stream;

struct CaptureOps {
    ContextExtension* (*createContextExtension)(Context* ctx);
    void (*freeCascadeCaptureStream)(Context* ctx, Stream* cascadeCaptureStream);
    rtError_t (*createSubCaptureModels)(Context* ctx, CondHandle* condHandle, rtCondTaskParams params, Stream* stm);
};

void RegisterCaptureOps(const CaptureOps* captureOps);
const CaptureOps* GetCaptureOps();

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_CAPTURE_OPS_HPP
