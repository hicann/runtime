/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TDT_COMMON_UTILS_H
#define TDT_COMMON_UTILS_H

#include "utils.h"

namespace tdt {
inline bool CheckNotNull(const void *ptr, const char *name)
{
    if (ptr == nullptr) {
        ERROR_LOG("%s is nullptr", name);
        return false;
    }
    return true;
}
} // namespace tdt

#endif
