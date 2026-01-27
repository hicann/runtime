/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_XPU_CONTEXT_HPP
#define CCE_RUNTIME_XPU_CONTEXT_HPP

#include "context.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
class Device;
class Context;

class XpuContext : public Context  {
public:

    XpuContext(Device * const ctxDevice, const bool primaryCtx);
    ~XpuContext() override;

    rtError_t StreamCreate(const uint32_t prio, const uint32_t flag, Stream ** const result, DvppGrp *grp = nullptr, const bool isSoftWareSqEnable = false) override;

    // init context
    rtError_t Setup() override;

    // destroy this context
    rtError_t TearDown() override;
    rtError_t TearDownStream(Stream *stm, bool flag = true) const override;
    rtError_t CheckStatus(const Stream * const stm = nullptr, const bool isBlockDefault = true) override;
};
}
}

#endif  // CCE_RUNTIME_XPU_CONTEXT_HPP
