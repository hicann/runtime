/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <iostream>

#include "acl/acl.h"

int main()
{
    // aclrtGetSocName returns the same SOC_VERSION string required by sample builds.
    // It does not require aclInit, so this helper stays small and fast for shell use.
    const char* socName = aclrtGetSocName();
    if ((socName == nullptr) || (socName[0] == '\0')) {
        std::cerr << "[ERROR]: Failed to get SOC_VERSION by aclrtGetSocName." << std::endl;
        return 1;
    }

    std::cout << socName << std::endl;
    return 0;
}
