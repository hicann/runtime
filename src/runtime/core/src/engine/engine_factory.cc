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
#include "device_enum_desc.hpp"
#include "direct_hwts_engine.hpp"
#include "async_hwts_engine.hpp"
#include "engine.hpp"
#include "stars_engine.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
Engine* EngineFactory::CreateEngine(const rtChipType_t chipType, Device* dev)
{
    COND_RETURN_ERROR((dev == nullptr), nullptr, "Failed to create engine, Device is null.");
    Engine* newEngine = nullptr;
    DevProperties props;
    rtError_t error = GET_DEV_PROPERTIES(chipType, props);
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), nullptr, "Failed to get dev properties, chipType=%s, error=%u",
        ChipTypeToString(chipType).c_str(), error);

    size_t allocSize = 0U;
    if (dev->IsStarsPlatform()) {
        newEngine = new (std::nothrow) StarsEngine(dev);
        allocSize = sizeof(StarsEngine);
        RT_LOG(RT_LOG_INFO, "new StarsEngine, Runtime_alloc_size %zu", sizeof(StarsEngine));
    } else if (props.taskEngineType == EngineCreateType::DIRECT_HWTS_ENGINE) {
        newEngine = new (std::nothrow) DirectHwtsEngine(dev);
        allocSize = sizeof(DirectHwtsEngine);
        RT_LOG(RT_LOG_INFO, "new DirectHwtsEngine, Runtime_alloc_size %zu", sizeof(DirectHwtsEngine));
    } else {
        newEngine = new (std::nothrow) AsyncHwtsEngine(dev);
        RT_LOG(RT_LOG_INFO, "new Engine, Runtime_alloc_size %zu", sizeof(AsyncHwtsEngine));
        allocSize = sizeof(AsyncHwtsEngine);
    }
    COND_RETURN_AND_MSG_OUTER(
        (newEngine == nullptr), nullptr, ErrorCode::EE1013, std::to_string(allocSize).c_str(), "new");
    error = newEngine->Init();
    COND_RETURN_INFO((error == RT_ERROR_NONE), newEngine, "Engine init success.");
    COND_PROC_RETURN_ERROR((error != RT_ERROR_DRV_INPUT), nullptr, DELETE_O(newEngine), "Engine init failed.");
    delete newEngine;
    newEngine = new (std::nothrow) AsyncHwtsEngine(dev);
    COND_RETURN_AND_MSG_OUTER(
        (newEngine == nullptr), nullptr, ErrorCode::EE1013, std::to_string(sizeof(AsyncHwtsEngine)).c_str(), "new");
    RT_LOG(RT_LOG_INFO, "New Engine, Runtime_alloc_size %zu", sizeof(AsyncHwtsEngine));
    error = newEngine->Init();
    COND_PROC_RETURN_ERROR((error != RT_ERROR_NONE), nullptr, DELETE_O(newEngine), "Engine init failed.");

    RT_LOG(RT_LOG_INFO, "Engine init success.");
    return newEngine;
}
} // namespace runtime
} // namespace cce