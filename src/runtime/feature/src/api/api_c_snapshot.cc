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
#include "api_c.h"
#include "rts/rts.h"
#include "global_state_manager.hpp"

using namespace cce::runtime;

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

static rtError_t CheckSnapShotFeatureSupport()
{
    const Runtime* const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DFX_PROCESS_SNAPSHOT)) {
        RT_LOG(
            RT_LOG_WARNING, "chip type(%d) does not support, return.", static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    return RT_ERROR_NONE;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotProcessLock()
{
    rtError_t error = CheckSnapShotFeatureSupport();
    if(error != RT_ERROR_NONE) {
        return error;
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    error = apiInstance->SnapShotProcessLock();
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotProcessUnlock()
{
    rtError_t error = CheckSnapShotFeatureSupport();
    if(error != RT_ERROR_NONE) {
        return error;
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    error = apiInstance->SnapShotProcessUnlock();
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotProcessGetState(rtProcessState *state)
{
    rtError_t error = CheckSnapShotFeatureSupport();
    if(error != RT_ERROR_NONE) {
        return error;
    }
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(state, RT_ERROR_INVALID_VALUE);
    *state = GlobalStateManager::GetInstance().GetCurrentState();
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotProcessBackup()
{
    rtError_t error = CheckSnapShotFeatureSupport();
    if(error != RT_ERROR_NONE) {
        return error;
    }

    Api * const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    error = apiInstance->SnapShotProcessBackup();
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotProcessRestore()
{
    rtError_t error = CheckSnapShotFeatureSupport();
    if(error != RT_ERROR_NONE) {
        return error;
    }

    Api *const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    error = apiInstance->SnapShotProcessRestore();
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotCallbackRegister(rtSnapShotStage stage, rtSnapShotCallBack callback, void *args)
{
    rtError_t error = CheckSnapShotFeatureSupport();
    if(error != RT_ERROR_NONE) {
        return error;
    }

    Api *const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    error = apiInstance->SnapShotCallbackRegister(stage, callback, args);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtSnapShotCallbackUnregister(rtSnapShotStage stage, rtSnapShotCallBack callback)
{
    rtError_t error = CheckSnapShotFeatureSupport();
    if(error != RT_ERROR_NONE) {
        return error;
    }

    Api *const apiInstance = Api::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    error = apiInstance->SnapShotCallbackUnregister(stage, callback);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif  // __cplusplus
