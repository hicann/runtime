/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */


#ifndef OP_API_COMMON_INC_OPDEV_INTERNAL_OUTSHAPE_H
#define OP_API_COMMON_INC_OPDEV_INTERNAL_OUTSHAPE_H

#include <type_traits>
#include "aclnn/acl_meta.h"
#include "opdev/common_types.h"
#include "opdev/internal/kernel_arg.h"
#include "kernel_utils.h"
#include "opdev/op_def.h"
#include "opdev/op_errno.h"
#include "opdev/op_log.h"
#include "opdev/op_dfx.h"
#include "runtime/mem.h"
#include "block_pool.h"

namespace op::internal {

inline void *SyncTensorData(const aclTensor *tensor)
{
    op::DataType dtype = tensor->GetDataType();
    size_t size = op::CalcShapeBytes(tensor->Size(), dtype);
    void *p = BlockPool::Malloc(size);
    OP_CHECK(p != nullptr, OP_LOGE(ACLNN_ERR_INNER, "malloc failed. %zu", size), return nullptr);
    rtError_t rc = rtMemcpy(p, size, tensor->GetData(), size, RT_MEMCPY_DEVICE_TO_HOST);
    if (rc != 0) {
        BlockPool::Free(p);
        OP_LOGE(rc, "rtMemcpy failed. size: %zu", size);
        return nullptr;
    }
    OP_LOGD("Sync tensor to host. size: %zu. dev: %p, host: %p", size, tensor->GetData(), p);
    return p;
}

template<typename T>
void UpdateTensorShape([[maybe_unused]]size_t index, const aclTensor *arg, void *shapeData)
{
    gert::Shape newShape;
    int64_t dimNum = static_cast<int64_t>(*PtrCastTo<T>(shapeData));
    //三类算子适配：
    //1. uint64类型，aclnn按int64解析, 第32位置0
    //2. 识别int64不是正数时，打印warning日志
    if (std::is_same_v<T, int64_t>) {
        if (dimNum <= 0) {
            OP_LOGW("dimNum should be positive, actual is %ld", dimNum);
        } else {
            dimNum = dimNum & 0xffffffff7fffffff;
        }
    }
    for (int64_t i = 1; i <= dimNum; i++) {
        int64_t dimSize = static_cast<int64_t>(*PtrCastTo<T>(PtrShift(shapeData, i * sizeof(T))));
#ifdef DEBUG
        OP_LOGD("outshape rank size: %ld, dim[%ld]: %ld", dimNum, i-1, dimSize);
#endif
        newShape.AppendDim(dimSize);
    }
    const_cast<aclTensor *>(arg)->SetStorageShape(newShape);
    const_cast<aclTensor *>(arg)->SetOriginalShape(newShape);
    const_cast<aclTensor *>(arg)->SetViewShape(newShape);
}

aclnnStatus RefreshOutputShape([[maybe_unused]] size_t index, OpArgList &outputShape, OpArgList &outputs);

}  // op::internal

#endif  // OP_API_COMMON_INC_OPDEV_INTERNAL_OUTSHAPE_H_
