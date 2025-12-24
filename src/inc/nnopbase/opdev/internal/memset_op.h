/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __MEMSET_OP_H__
#define __MEMSET_OP_H__

#include <vector>
#include "aclnn/acl_meta.h"
#include "opdev/op_dfx.h"
#include "opdev/common_types.h"
#include "opdev/op_arg_def.h"
#include "opdev/internal/memset_ctx_holder.h"

namespace op {
namespace internal {

class OpKernelBin;

enum class MemsetVersion : uint8_t {
    MEMSET_V1 = 0,
    MEMSET_V2 = 1
};

const std::string MEMSET_V1_NAME = "MemSet";
const std::string MEMSET_V2_NAME = "MemSetV2";

class MemsetV2ArgContext {
public:
    MemsetV2ArgContext();
    aclnnStatus Init(const std::vector<MemSetTensorInfo> &memsetTensorInfo);
    ~MemsetV2ArgContext();
    OpArgContext *GetMemsetV2OpArgContext();

private:
    void AddOneMemSetTensor(const aclTensor *tensor, op::DataType dtype, int64_t valueInt, float valueFloat);

    int32_t hugeMemPoolIndex_{op::kInvalidHugeMemIndexId};
    std::vector<const aclTensor *> memsetInputs_;
    std::vector<int64_t> memsetIntAttrs_;
    std::vector<float> memsetFloatAttrs_;
    aclTensorList *memsetTensors_{nullptr};
    aclIntArray *intAttrArray_{nullptr};
    aclFloatArray *floatAttrArray_{nullptr};
    OpArgContext *memsetV2OpArgCtx_{nullptr};
};

aclnnStatus SelectMemsetOpBin(MemsetVersion memsetVersion, size_t inputNum, OpKernelBin *&opBin);

} // namespace internal
} // namespace op

#endif
