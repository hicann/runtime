/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_ADUMP_PLATFORM_API_H
#define ADUMP_COMMON_ADUMP_PLATFORM_API_H
#include <cstdint>
#include <string>
#include "dump_setting.h"

namespace Adx {
struct PlatformData {
    uint64_t ubSize;
    uint32_t aiCoreCnt;
    uint32_t vectCoreCnt;
};

struct BufferSize {
    uint64_t l0aSize;
    uint64_t l0bSize;
    uint64_t l0cSize;
    uint64_t l1Size;
    uint64_t ubSize;
};

class AdumpPlatformApi {
public:
    static bool GetUBSizeAndCoreNum(const std::string &socVersion, PlatformType platform, PlatformData &data);
    static bool GetAicoreSizeInfo(const std::string &socVersion, BufferSize &bufferSize);
};
} // namespace Adx
#endif // ADUMP_COMMON_ADUMP_FE_API_H