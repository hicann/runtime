/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_API_STUB_H
#define ACL_API_STUB_H

#include <cstdint>
#include <vector>
#include <string>
#include "acl/acl.h"
#include "acl_prof.h"

namespace Cann {
namespace Dvvp {
namespace Test {
int32_t AclApiStart(aclprofConfig *config, uint64_t dataTypeConfig);
int32_t AclApiRepeatStart(aclprofConfig *config, uint64_t dataTypeConfig);
int32_t AclApiStartWithSetDeviceBehind(aclprofConfig *config, uint64_t dataTypeConfig);
int32_t CheckFiles(std::string &path, std::vector<std::string> deviceDataList, std::vector<std::string> hostDataList);
int32_t CheckAllFiles(std::string &path, std::vector<std::string> deviceDataList, std::vector<std::string> hostDataList);
void ClearApiSingleton();
void InitApiSingleton();
}
}
}

#endif