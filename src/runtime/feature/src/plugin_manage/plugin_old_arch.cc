/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "runtime_keeper.h"

extern "C" {
VISIBILITY_DEFAULT cce::runtime::Runtime* ConstructRuntimeImpl()
{
    cce::runtime::Runtime* rt = new (std::nothrow) cce::runtime::Runtime();
    if (rt == nullptr) {
        RT_LOG(RT_LOG_ERROR, "new RuntimeImpl failed");
        return nullptr;
    }
    RT_LOG(RT_LOG_INFO, "RuntimeImpl construct success, rt = %p", rt);
    cce::runtime::Runtime::runtime_ = rt;
    return rt;
}

VISIBILITY_DEFAULT void DestructorRuntimeImpl(cce::runtime::Runtime *rt)
{
    delete rt;
    cce::runtime::Runtime::runtime_ = nullptr;
    RT_LOG(RT_LOG_INFO, "RuntimeImpl destructor success");
    return;
}
}
