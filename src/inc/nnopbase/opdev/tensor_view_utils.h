/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OP_API_COMMON_INC_OP_DEV_TENSOR_VIEW_UTILS_H
#define OP_API_COMMON_INC_OP_DEV_TENSOR_VIEW_UTILS_H

#include "common_types.h"

namespace op {
/**
 * @brief Check whether tensor is contiguous. Do not used to check whether the pointer is null.
 * Contiguous tensor must meet one of the following conditions:
 * 1. Private formats tensor must be contiguous.
 * 2. Empty tensor must be contiguous.
 * 3. The stride and view shape match contiguous features.
 * 4. nullptr return true by default. 
 * @param tensor The input tensor
 * @return bool True/false
 */
bool IsContiguous(const aclTensor *tensor);

/**
 * @brief Check whether all input tensors can be regarded as a view of contiguous tensors
 * and all tensors have the same view feature.
 * @param tensorList The input tensors.
 * @return
 */
bool CanPickViewAsContiguous(std::initializer_list<const aclTensor *> tensorList);

/**
 * @brief Check whether the input tensor can be regarded as a view of a contiguous tensor.
 * @param tensor The input tensor
 * @return True/false
 */
bool CanPickViewAsContiguous(const aclTensor *tensor);

/**
 * @brief Check whether the input tensor is valid.
 * @param tensor The input tensor
 * @return bool True/false
 */
bool Validate(const aclTensor *tensor);
} // namespace op

#endif // OP_API_COMMON_INC_OP_DEV_TENSOR_VIEW_UTILS_H
