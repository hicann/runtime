/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api.hpp"
#include "global_state_manager.hpp"
#include "api_c.h"
#include "api_global_err.h"

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtMallocCached);
} // namespace runtime
} // namespace cce

using namespace cce::runtime;

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
VISIBILITY_DEFAULT
rtError_t rtMallocCached(void** devPtr, uint64_t size, rtMemType_t type, const uint16_t moduleId)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api* const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);

    TIMESTAMP_BEGIN(rtMallocCached);
    const rtError_t error = apiInstance->DevMalloc(devPtr, size, type, moduleId);
    TIMESTAMP_END(rtMallocCached);
    if (unlikely(error != RT_ERROR_NONE)) {
        return GetRtExtErrCodeAndSetGlobalErr(error);
    }
    return ACL_RT_SUCCESS;
}
#ifdef __cplusplus
}
#endif // __cplusplus
