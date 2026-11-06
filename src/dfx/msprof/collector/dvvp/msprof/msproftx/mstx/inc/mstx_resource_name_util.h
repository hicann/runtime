/* -------------------------------------------------------------------------
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 * ------------------------------------------------------------------------- */

#ifndef MSTX_RESOURCE_NAME_UTIL_H
#define MSTX_RESOURCE_NAME_UTIL_H

#include <cstdint>
#include <cstring>
#include <string>

#include "mstx_def.h"

// 资源命名的小工具函数：与业务逻辑解耦，便于 UT 直接覆盖
inline bool MstxIsValidResourceType(uint32_t resourceType)
{
    return resourceType > static_cast<uint32_t>(MSTX_RESOURCE_TYPE_INVALID) &&
           resourceType < static_cast<uint32_t>(MSTX_RESOURCE_TYPE_SIZE);
}

// 名称按 MSTX_RESOURCE_NAME_MAX_LEN 截断（含超长与空指针场景）
inline std::string MstxTruncateResourceName(const char* name)
{
    if (name == nullptr) {
        return std::string();
    }
    return std::string(name, strnlen(name, MSTX_RESOURCE_NAME_MAX_LEN));
}

#endif // MSTX_RESOURCE_NAME_UTIL_H
