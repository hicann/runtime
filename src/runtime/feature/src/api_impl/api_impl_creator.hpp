/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_API_IMPL_CREATOR_C_HPP__
#define __CCE_RUNTIME_API_IMPL_CREATOR_C_HPP__

#include "api.hpp"
#include "api_mbuf.hpp"

namespace cce {
namespace runtime {
Api *CreateImplAndGet();
ApiMbuf *CreateImplMbufAndGet();
}  // namespace runtime
}  // namespace cce

#endif // __CCE_RUNTIME_API_IMPL_CREATOR_C_HPP__