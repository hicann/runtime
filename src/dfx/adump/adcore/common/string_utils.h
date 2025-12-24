/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADX_STRING_UTILS_H
#define ADX_STRING_UTILS_H
#include <string>
namespace Adx {
constexpr uint32_t IP_VALID_PART_NUM      = 3;
constexpr uint32_t IP_MAX_NUM             = 255;
constexpr uint32_t IP_MIN_NUM             = 0;
class StringUtils {
public:
    static bool IsIntDigital(const std::string &digital);
    static bool IpValid(const std::string &ipStr);
    static bool ParseConnectInfo(const std::string &connectInfo,
                                       std::string &hostId,
                                       std::string &hostPid);
};
}
#endif
