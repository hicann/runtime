/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_EVENT_STATE_CALLBACK_MANAGER_HPP
#define CCE_RUNTIME_EVENT_STATE_CALLBACK_MANAGER_HPP

#include "common/enum_log.hpp"
#include "runtime/base.h"
#include <unordered_map>
#include "base.hpp"
#include "runtime.hpp"
#include "event.hpp"

namespace cce {
namespace runtime {

enum class EventStateCallbackType : uint8_t { RT_EVENT_STATE_CALLBACK = 0, RT_EVENT_STATE_CALLBACK_TYPE_MAX };

enum class EventStatePeriod : uint8_t {
    EVENT_STATE_PERIOD_RECORD = 0,
    EVENT_STATE_PERIOD_WAIT,
    EVENT_STATE_PERIOD_DESTROY,
    EVENT_STATE_PERIOD_TYPE_MAX
};
RT_ENUM_LOG_DECLARE(EventStatePeriodToString, EventStatePeriod)

typedef void (*rtEventStateCallback)(Stream* stream, Event* event, EventStatePeriod period, void* args);

struct EventStateCallbackInfo {
    EventStateCallbackType type;
    rtEventStateCallback callback;
    void* args;
};

class EventStateCallbackManager {
public:
    static EventStateCallbackManager& Instance();
    rtError_t RegEventStateCallback(const char_t* regName, void* callback, void* args, EventStateCallbackType cbType);
    void Notify(Stream* stream, Event* event, EventStatePeriod period);

private:
    EventStateCallbackManager() = default;
    ~EventStateCallbackManager() = default;
    EventStateCallbackManager(const EventStateCallbackManager& other) = delete;
    EventStateCallbackManager& operator=(const EventStateCallbackManager& other) = delete;
    EventStateCallbackManager(EventStateCallbackManager&& other) = delete;
    EventStateCallbackManager& operator=(EventStateCallbackManager&& other) = delete;

private:
    std::unordered_map<std::string, EventStateCallbackInfo> callbackMap_;
    std::mutex mapMutex_;
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_EVENT_STATE_CALLBACK_MANAGER_HPP
