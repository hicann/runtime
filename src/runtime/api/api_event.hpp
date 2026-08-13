/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under
 * the terms and conditions of CANN Open Software License Agreement Version 2.0
 * (the "License"). Please refer to the License for details. You may not use
 * this file except in compliance with the License. THIS SOFTWARE IS PROVIDED ON
 * AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS
 * FOR A PARTICULAR PURPOSE. See LICENSE in the root of the software repository
 * for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_EVENT_HPP
#define CCE_RUNTIME_API_EVENT_HPP

#include "base.hpp"
#include "event.hpp"
#include "runtime.hpp"
#include "runtime/rt.h"
#include "stream.hpp"

namespace cce {
namespace runtime {

class ApiEvent {
public:
    ApiEvent() = default;
    virtual ~ApiEvent() = default;

    ApiEvent(const ApiEvent&) = delete;
    ApiEvent& operator=(const ApiEvent&) = delete;
    ApiEvent(ApiEvent&&) = delete;
    ApiEvent& operator=(ApiEvent&&) = delete;

    // Get ApiEvent instance.
    static ApiEvent* Instance();

    virtual rtError_t IpcOpenEventHandle(rtIpcEventHandle_t* handle, IpcEvent** const event) = 0;
    virtual rtError_t IpcGetEventHandle(IpcEvent* const evt, rtIpcEventHandle_t* handle) = 0;
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_API_EVENT_HPP
