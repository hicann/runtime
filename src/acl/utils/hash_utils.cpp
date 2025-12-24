/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hash_utils.h"
#include <fstream>
#include <sstream>
#include "common/log_inner.h"

namespace acl {
namespace hash_utils {
aclError CalculateSimpleHash(const char *filePath, const std::string &configString, std::string &hashResult) {
    ACL_LOG_INFO("Begin to calculate hash for file: %s", filePath);

    std::size_t hashValue = std::hash<std::string>{}(configString);
    hashResult = std::to_string(hashValue);
    ACL_LOG_INFO("End to calculate hash for file: %s, hash value: %s", filePath, hashResult.c_str());

    return ACL_SUCCESS;
}
} // namespace hash_utils
} // namespace acl