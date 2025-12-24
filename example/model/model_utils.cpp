/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <string>
#include <thread>
#include <vector>
#include <iomanip>
#include <sstream>
#include "acl/acl.h"
#include "aclnnop/aclnn_add.h"
#include "utils.h"
#include "model_utils.h"

namespace ModelUtils {
    int64_t GetShapeSize(const std::vector<int64_t> &shape)
        {
            int64_t shapeSize = 1;
            for (auto i : shape) {
                shapeSize *= i;
            }
            return shapeSize;
        }
    int CreateAclTensor(const std::vector<int64_t> &shape, void **deviceAddr, aclDataType dataType,
        aclTensor **tensor)
        {
            auto size = GetShapeSize(shape) * sizeof(float);
            // 申请Device侧内存
            auto ret = aclrtMalloc(deviceAddr, size, ACL_MEM_MALLOC_HUGE_FIRST);
            // 计算连续tensor的stride
            std::vector<int64_t> strides(shape.size(), 1);
            for (int64_t i = shape.size() - 2; i >= 0; i--) {
                strides[i] = shape[i + 1] * strides[i + 1];
            }
            // 调用aclCreateTensor接口创建aclTensor
            *tensor = aclCreateTensor(shape.data(),
                shape.size(),
                dataType,
                strides.data(),
                0,
                aclFormat::ACL_FORMAT_ND,
                shape.data(),
                shape.size(),
                *deviceAddr);
            return 0;
        }
    void PrintArray(const std::vector<float>& data)
        {
            const int size = data.size();
            const int precision = 4;
            std::ostringstream oss;
            oss << std::fixed << std::setprecision(precision);
            oss << "The vector data is: ";
            for (int j = 0; j < size; j++) {
                oss << data[j] <<"  ";
            }
            INFO_LOG("%s", oss.str().c_str());
        }
}