/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __MEMSET_CTX_HOLDER_H__
#define __MEMSET_CTX_HOLDER_H__

#include <array>
#include <iostream>
#include <string>
#include <vector>

#include "aclnn/acl_meta.h"
#include "exe_graph/runtime/tiling_context.h"
#include "opdev/internal/kernel_utils.h"
#include "opdev/op_def.h"
#include "platform/platform_info.h"
#include "launcher_ctx.h"
#include "opdev/internal/kernel_context_holder.h"

namespace op::internal {

struct MemSetTensorInfo {
    size_t argIdx_;
    op::DataType dtype_;
    float32_t valueFloat_;
    int64_t valueInt_;

    size_t tensorSize_;
    size_t tensorDataSize_;
    OpArgType argType_;
    void *tensorData_;
    const aclTensor *tensor_;
    const aclTensorList *tensorList_;
};

class MemSetKernelContextHolder : public KernelContextHolder {
public:
    aclnnStatus UpdateComputeNodeInfo(const std::vector<MemSetTensorInfo> &memsetTensorInfo)
    {
        ResetComputeNodeInfo("MemSet", memsetTensorInfo.size(), 0);
        UpdateCompileDescOffset(memsetTensorInfo.size());
        UpdateInputArg(memsetTensorInfo);
        FinalizeComputeNodeInfo(4); // memset has 4 attrs, tensor sizes, dtype, int value, float value
        UpdateAttrArg(memsetTensorInfo);
        return ACLNN_SUCCESS;
    }

private:
    void UpdateInputArg(const std::vector<MemSetTensorInfo> &memsetTensorInfo);
    void UpdateAttrArg(const std::vector<MemSetTensorInfo> &memsetTensorInfo);
};

} // namespace op::internal

#endif // __MEMSET_CTX_HOLDER_H__