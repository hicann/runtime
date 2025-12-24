/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef OP_API_OP_API_COMMON_INC_OPDEV_SHAPE_UTILS_H_
#define OP_API_OP_API_COMMON_INC_OPDEV_SHAPE_UTILS_H_

#include <cstdlib>
#include <string>
#include <exe_graph/runtime/shape.h>
#include "common_types.h"
#include "data_type_utils.h"

namespace op {
ge::AscendString ToString(const op::Shape &shape);
ge::AscendString ToString(const op::Strides &strides);
void ToShape(const int64_t *dims, uint64_t dimNum, op::Shape &shape);
void ToShape(const op::ShapeVector &shapeVector, op::Shape &shape);
ShapeVector ToShapeVector(const op::Shape &shape);
void ToContiguousStrides(const op::Shape &shape, op::Strides &strides);
bool CheckBroadcastShape(const op::Shape &self, const op::Shape &other);
bool BroadcastInferShape(const op::Shape &self, const op::Shape &other, op::Shape &broadcastShape);
} // namespace op

#endif //OP_API_OP_API_COMMON_INC_OPDEV_SHAPE_UTILS_H_
