/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OP_API_OP_API_COMMON_INC_OPDEV_INTERNAL_INFERSHAPE_CONTEXT_HOLDER_H
#define OP_API_OP_API_COMMON_INC_OPDEV_INTERNAL_INFERSHAPE_CONTEXT_HOLDER_H

#include "exe_graph/runtime/infer_shape_context.h"
#include "opdev/internal/kernel_context_holder.h"

namespace op {
namespace internal {
class InferShapeContextHolder {
public:
    InferShapeContextHolder()
    {
        BuildInferShapeContext();
    }

    ~InferShapeContextHolder();

    InferShapeContextHolder(const InferShapeContextHolder &) = delete;
    InferShapeContextHolder(InferShapeContextHolder &&) = delete;
    InferShapeContextHolder &operator=(const InferShapeContextHolder &) = delete;
    InferShapeContextHolder &operator=(InferShapeContextHolder &&) = delete;

    void BuildInferShapeContext();
    aclnnStatus UpdateInferShapeContext(const KernelContextHolder *kernelCtx) const;

    gert::InferShapeContext *GetInferShapeContext() const
    {
        return PtrCastTo<gert::InferShapeContext>(inferShapeCtx_);
    }

private:
    KernelRunContext *inferShapeCtx_{nullptr};
    AsyncAnyValue *inferShapeValues_{nullptr};

    constexpr static size_t inferShapeValueNum_ = 2;
};

}
}

#endif
