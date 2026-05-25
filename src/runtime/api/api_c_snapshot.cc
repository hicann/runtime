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
#include "rts/rts.h"
#include "runtime.hpp"
#include "global_state_manager.hpp"
#include "snapshot_callback_manager.hpp"
#include "snapshot_process_helper.hpp"

using namespace cce::runtime;

namespace {
static SnapshotCallbackManager g_snapshotCallbackManager;
}

#ifdef __cplusplus
extern "C" {
#endif

static rtError_t CheckSnapShotFeatureSupport()
{
    const Runtime* const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DFX_PROCESS_SNAPSHOT)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support process Snapshot feature.", static_cast<int32_t>(rtInstance->GetChipType()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }
    return RT_ERROR_NONE;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotProcessLock()
{
    rtError_t error = CheckSnapShotFeatureSupport();
    if (error != RT_ERROR_NONE) {
        return error;
    }
    error = g_snapshotCallbackManager.InvokeCallbacks(RT_SNAPSHOT_LOCK_PRE);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    error = GlobalStateManager::GetInstance().Locked();
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotProcessUnlock()
{
    rtError_t error = CheckSnapShotFeatureSupport();
    if (error != RT_ERROR_NONE) {
        return error;
    }

    error = GlobalStateManager::GetInstance().Unlocked();
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    error = g_snapshotCallbackManager.InvokeCallbacks(RT_SNAPSHOT_UNLOCK_POST);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotProcessGetState(rtProcessState *state)
{
    rtError_t error = CheckSnapShotFeatureSupport();
    if (error != RT_ERROR_NONE) {
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
    if (error != RT_ERROR_NONE) {
        return error;
    }

    GlobalStateManager &globalStateManagerInstance = GlobalStateManager::GetInstance();
    std::unique_lock<std::mutex> lock(globalStateManagerInstance.GetStateMtx());
    if (globalStateManagerInstance.GetCurrentState() != RT_PROCESS_STATE_LOCKED) {
        RT_LOG(RT_LOG_ERROR,
            "current state is not the locked state, current state is %s",
            GlobalStateManager::StateToString(globalStateManagerInstance.GetCurrentState()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_SNAPSHOT_BACKUP_FAILED);
    }

    error = g_snapshotCallbackManager.InvokeCallbacks(RT_SNAPSHOT_BACKUP_PRE);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    error = SnapShotProcessBackup();
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    
    error = g_snapshotCallbackManager.InvokeCallbacks(RT_SNAPSHOT_BACKUP_POST);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    globalStateManagerInstance.SetCurrentState(RT_PROCESS_STATE_BACKED_UP);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotProcessRestore()
{
    rtError_t error = CheckSnapShotFeatureSupport();
    if (error != RT_ERROR_NONE) {
        return error;
    }

    GlobalStateManager &globalStateManagerInstance = GlobalStateManager::GetInstance();
    std::unique_lock<std::mutex> lock(globalStateManagerInstance.GetStateMtx());
    if (globalStateManagerInstance.GetCurrentState() != RT_PROCESS_STATE_BACKED_UP) {
        RT_LOG(RT_LOG_ERROR,
            "current state is not the RT_PROCESS_STATE_BACKED_UP state, current state is %s",
            GlobalStateManager::StateToString(globalStateManagerInstance.GetCurrentState()));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_SNAPSHOT_RESTORE_FAILED);
    }

    error = g_snapshotCallbackManager.InvokeCallbacks(RT_SNAPSHOT_RESTORE_PRE);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    error = SnapShotProcessRestore();
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    
    error = g_snapshotCallbackManager.InvokeCallbacks(RT_SNAPSHOT_RESTORE_POST);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);

    globalStateManagerInstance.SetCurrentState(RT_PROCESS_STATE_LOCKED);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotCallbackRegister(rtSnapShotStage stage, rtSnapShotCallBack callback, void *args)
{
    rtError_t error = CheckSnapShotFeatureSupport();
    if (error != RT_ERROR_NONE) {
        return error;
    }
    error = g_snapshotCallbackManager.RegisterCallback(stage, callback, args);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotCallbackUnregister(rtSnapShotStage stage, rtSnapShotCallBack callback)
{
    rtError_t error = CheckSnapShotFeatureSupport();
    if (error != RT_ERROR_NONE) {
        return error;
    }
    error = g_snapshotCallbackManager.UnregisterCallback(stage, callback);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif