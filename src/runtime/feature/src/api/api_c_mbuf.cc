/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "api_c.h"
#include "api.hpp"
#include "api_mbuf.hpp"
#include "osal.hpp"

using namespace cce::runtime;

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtMemQueueInitQS(int32_t devId, const char_t* grpName)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiInstance->MemQueueInitQS(devId, grpName);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMbufInit(rtMemBuffCfg_t *cfg)
{
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiMbufInstance->MbufInit(cfg);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT); // special state
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_REPEATED_INIT, ACL_ERROR_RT_REPEATED_INIT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus