/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_PACKAGE_CONTEXT_H
#define TSD_PACKAGE_CONTEXT_H

#include "basic_define.h"

#include <array>
#include <cstdint>
#include <string>

namespace tsd {

class PackageContext {
public:
    PackageContext() = default;

    ResponseCode pkgRspCode = ResponseCode::FAIL;
    bool deviceIdle = false;
    bool getCheckCodeRetrySupport = false;
    std::string loadPackageErrorMsg;
    bool aicpuPackageExistInDevice = false;
    std::array<uint32_t, static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX)> peerCheckCode{};
    std::array<uint32_t, static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_MAX)> hostCheckCode{};
};

} // namespace tsd

#endif // TSD_PACKAGE_CONTEXT_H
