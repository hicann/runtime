/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "engine_factory.hpp"
#include "stars_engine.hpp"

namespace cce {
namespace runtime {
Engine *EngineFactory::CreateEngine(const rtChipType_t chipType, Device *dev)
{
    UNUSED(chipType);
    COND_RETURN_ERROR((dev == nullptr), nullptr, "Create engine failed, device is null.");
    Engine *newEngine = nullptr;

    newEngine = new (std::nothrow) StarsEngine(dev);
    RT_LOG(RT_LOG_INFO, "new StarsEngine, Runtime_alloc_size %zu", sizeof(StarsEngine));
    COND_RETURN_ERROR((newEngine == nullptr), nullptr, "Create engine failed, engine is null.");

    rtError_t error = newEngine->Init();
    COND_PROC_RETURN_ERROR((error != RT_ERROR_NONE), nullptr, DELETE_O(newEngine), "Engine init failed.");

    RT_LOG(RT_LOG_INFO, "Engine init success.");
    return newEngine;
}
}  // namespace runtime
}  // namespace cce