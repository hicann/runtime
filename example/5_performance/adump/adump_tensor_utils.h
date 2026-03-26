/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADUMP_TENSOR_UTILS_H
#define ADUMP_TENSOR_UTILS_H

#include <vector>
#include "acl/acl.h"
#include "runtime_init_utils.h"

namespace adump {
inline int InitRuntime(int32_t deviceId, aclrtStream *stream, const char *configPath = nullptr)
{
    return static_cast<int>(runtime::InitRuntimeAndCreateStream(deviceId, stream, configPath));
}

inline int64_t GetShapeSize(const std::vector<int64_t> &shape)
{
    int64_t shapeSize = 1;
    for (const int64_t dim : shape) {
        shapeSize *= dim;
    }
    return shapeSize;
}

template <typename T>
int CreateAclTensor(const std::vector<T> &hostData, const std::vector<int64_t> &shape, void **deviceAddr,
    aclDataType dataType, aclTensor **tensor)
{
    const size_t size = static_cast<size_t>(GetShapeSize(shape)) * sizeof(T);
    aclError ret = aclrtMalloc(deviceAddr, size, ACL_MEM_MALLOC_HUGE_FIRST);
    if (ret != ACL_SUCCESS) {
        return static_cast<int>(ret);
    }
    ret = aclrtMemcpy(*deviceAddr, size, hostData.data(), size, ACL_MEMCPY_HOST_TO_DEVICE);
    if (ret != ACL_SUCCESS) {
        return static_cast<int>(ret);
    }

    std::vector<int64_t> strides(shape.size(), 1);
    for (int64_t i = static_cast<int64_t>(shape.size()) - 2; i >= 0; --i) {
        strides[static_cast<size_t>(i)] = shape[static_cast<size_t>(i + 1)] * strides[static_cast<size_t>(i + 1)];
    }

    *tensor = aclCreateTensor(shape.data(), shape.size(), dataType, strides.data(), 0, aclFormat::ACL_FORMAT_ND,
        shape.data(), shape.size(), *deviceAddr);
    if (*tensor == nullptr) {
        return -1;
    }
    return ACL_SUCCESS;
}

inline void DestroyTensorResources(aclTensor *self, aclTensor *other, aclScalar *alpha, aclTensor *out)
{
    aclTensor *tensorList[] = {self, other, out};
    for (aclTensor *tensor : tensorList) {
        if (tensor != nullptr) {
            aclDestroyTensor(tensor);
        }
    }
    if (alpha != nullptr) {
        aclDestroyScalar(alpha);
    }
}
} // namespace adump

#endif
