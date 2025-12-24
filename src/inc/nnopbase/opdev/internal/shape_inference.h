/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef OP_API_OP_API_COMMON_INC_OPDEV_INTERNAL_SHAPE_INFERENCE_H
#define OP_API_OP_API_COMMON_INC_OPDEV_INTERNAL_SHAPE_INFERENCE_H

#include "kernel_arg.h"
#include "kernel_mgr.h"
#include "opdev/shape_utils.h"

namespace op {
namespace internal {
aclnnStatus UpdateOutputShape(aclTensor *tensor);

aclnnStatus UpdateOutputShape(aclTensorList *tensors);

inline aclnnStatus UpdateOutputShape(OpArgList &outputs)
{
    return outputs.VisitBy([]([[maybe_unused]] size_t idx, OpArg &arg) {
        switch (arg.type) {
            case OpArgType::OPARG_ACLTENSOR:
                return UpdateOutputShape(reinterpret_cast<aclTensor *>(arg->pointer));
            case OpArgType::OPARG_ACLTENSOR_LIST:
                return UpdateOutputShape(reinterpret_cast<aclTensorList *>(arg->pointer));
            default:
                return ACLNN_SUCCESS;
        }
    });
}

inline aclnnStatus InferShape(uint32_t optype, OpArgList &inputs, OpArgList &outputs, OpArgList &attrs)
{
    auto ret = gKernelMgr.InferShape(optype, inputs, outputs, attrs);
    if (ret != ACLNN_SUCCESS) {
        return ACLNN_ERR_INNER;
    }
    ret = UpdateOutputShape(outputs);
    return ret;
}
}
}
#endif
