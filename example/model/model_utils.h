/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MODEL_UTILS_H
#define MODEL_UTILS_H

#include <thread>
#include <string>
#include <vector>
#include <sstream>
#include "acl/acl.h"
#include "aclnnop/aclnn_add.h"

namespace ModelUtils {
    int64_t GetShapeSize(const std::vector<int64_t> &shape);

    int CreateAclTensor(const std::vector<int64_t> &shape, void **deviceAddr, aclDataType dataType,
        aclTensor **tensor);
    
    void PrintArray(const std::vector<float>& data);
}

#endif