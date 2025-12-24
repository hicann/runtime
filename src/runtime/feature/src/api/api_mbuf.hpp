/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_MBUF_HPP
#define CCE_RUNTIME_API_MBUF_HPP

#include "runtime/rt.h"
#include "base.hpp"
#include "runtime.hpp"
#include "event.hpp"
#include "model.hpp"
#include "label.hpp"
#include "api.hpp"

namespace cce {
namespace runtime {

// Runtime interface
class ApiMbuf {
public:
    ApiMbuf() = default;
    virtual ~ApiMbuf() = default;

    ApiMbuf(const ApiMbuf &) = delete;
    ApiMbuf &operator=(const ApiMbuf &) = delete;
    ApiMbuf(ApiMbuf &&) = delete;
    ApiMbuf &operator=(ApiMbuf &&) = delete;

    // Get ApiMbuf instance.
    static ApiMbuf *Instance();

    // mbuf API
    virtual rtError_t MbufInit(rtMemBuffCfg_t * const cfg) = 0;
};
}  // namespace runtime
}  // namespace cce


#endif  // CCE_RUNTIME_API_MBUF_HPP
