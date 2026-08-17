/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl.hpp"
#include "context.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {

rtError_t ApiImpl::FlushCache(const uint64_t base, const size_t len)
{
    RT_LOG(RT_LOG_INFO, "flush cache base=%" PRIu64 ", len=%zu.", base, len);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(base == 0U, RT_ERROR_INVALID_VALUE, base, "not equal to 0");

    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    rtError_t error = curCtx->Device_()->GetDeviceStatus();
    COND_PROC((error == RT_ERROR_DEVICE_TASK_ABORT), return error);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::InvalidCache(const uint64_t base, const size_t len)
{
    RT_LOG(RT_LOG_INFO, "invalid cache base=%" PRIu64 ", len=%zu.", base, len);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(base == 0U, RT_ERROR_INVALID_VALUE, base, "not equal to 0");

    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    return RT_ERROR_NONE;
}
} // namespace runtime
} // namespace cce
