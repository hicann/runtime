/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api.hpp"
#include "api_mbuf.hpp"
#include "thread_local_container.hpp"

namespace cce {
namespace runtime {
Api *Api::Instance(const uint32_t flags)
{
    const Runtime * const rtInstance = Runtime::Instance();
    if (unlikely(rtInstance == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "Runtime::Instance == nullptr");
        return nullptr;
    }
    ThreadLocalContainer::SetEnvFlags(flags);
    return rtInstance->Api_();
}

ApiMbuf *ApiMbuf::Instance()
{
    const Runtime * const rtInstance = Runtime::Instance();
    if (unlikely(rtInstance == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "Runtime::Instance == nullptr");
        return nullptr;
    }
    return rtInstance->ApiMbuf_();
}

}  // namespace runtime
}  // namespace cce
