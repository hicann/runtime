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
#include "errcode_manage.hpp"
#include "error_code.h"
#include "osal.hpp"
#include "prof_map_ge_model_device.hpp"
#include "runtime_keeper.h"
#include "global_state_manager.hpp"

using namespace cce::runtime;

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtsCtxCreate(rtContext_t *createCtx, uint64_t flags, int32_t devId)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM((flags > static_cast<uint64_t>(RT_CONTEXT_NORMAL_MODE)), 
        RT_ERROR_INVALID_VALUE, flags, "less than or equal to 0");

    const rtError_t error = apiInstance->ContextCreate(RtPtrToPtr<Context **>(createCtx), devId);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsCtxDestroy(rtContext_t destroyCtx)
{
    return rtCtxDestroyEx(destroyCtx);
}

VISIBILITY_DEFAULT
rtError_t rtsCtxSetCurrent(rtContext_t currentCtx)
{
    return rtCtxSetCurrent(currentCtx);
}

VISIBILITY_DEFAULT
rtError_t rtsCtxGetCurrent(rtContext_t *currentCtx)
{
    return rtCtxGetCurrent(currentCtx);
}

VISIBILITY_DEFAULT
rtError_t rtsCtxSetSysParamOpt(rtSysParamOpt configOpt, int64_t configVal)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM((configOpt >= SYS_OPT_RESERVED) || (configOpt < 0), 
        RT_ERROR_INVALID_VALUE, configOpt, "[0, " + std::to_string(SYS_OPT_RESERVED) + ")");

    const rtError_t ret = apiInstance->CtxSetSysParamOpt(configOpt, configVal);
    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsCtxGetSysParamOpt(rtSysParamOpt configOpt, int64_t *configVal)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM((configOpt >= SYS_OPT_RESERVED) || (configOpt < 0), 
        RT_ERROR_INVALID_VALUE, configOpt, "[0, " + std::to_string(SYS_OPT_RESERVED) + ")");
    
    const rtError_t ret = apiInstance->CtxGetSysParamOpt(configOpt, configVal);
    if (ret == RT_ERROR_NOT_SET_SYSPARAMOPT) {
        return ACL_ERROR_RT_SYSPARAMOPT_NOT_SET;
    }

    ERROR_RETURN_WITH_EXT_ERRCODE(ret);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsCtxGetCurrentDefaultStream(rtStream_t *stm)
{
    return rtCtxGetCurrentDefaultStream(stm);
}

VISIBILITY_DEFAULT
rtError_t rtsGetPrimaryCtxState(const int32_t devId, uint32_t *flags, int32_t *active)
{
    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->GetPrimaryCtxState(devId, flags, active);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus