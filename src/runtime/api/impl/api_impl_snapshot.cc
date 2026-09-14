/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl_snapshot.hpp"

#include <mutex>
#include <new>

#include "api_impl_creator.hpp"
#include "error_message_manage.hpp"
#include "global_state_manager.hpp"
#include "snapshot_callback_manager.hpp"
#include "snapshot_process_helper.hpp"

namespace cce {
namespace runtime {

bool IsImplSnapshotSupported() { return true; }

ApiSnapshot* CreateImplSnapshotAndGet()
{
    ApiSnapshot* const apiImplSnapshot = new (std::nothrow) ApiImplSnapshot();
    if (apiImplSnapshot == nullptr) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, sizeof(ApiImplSnapshot), "new");
        RT_LOG(RT_LOG_ERROR, "create ApiImplSnapshot failed.");
        return nullptr;
    }
    RT_LOG(RT_LOG_INFO, "ApiImplSnapshot:Runtime_alloc_size %zu", sizeof(ApiImplSnapshot));
    return apiImplSnapshot;
}

void DestroyImplSnapshot(ApiSnapshot*& apiImplSnapshot)
{
    delete apiImplSnapshot;
    apiImplSnapshot = nullptr;
}

rtError_t ApiImplSnapshot::SnapShotProcessLock()
{
    rtError_t error = SnapshotCallbackManager::GetInstance().InvokeCallbacks(RT_SNAPSHOT_LOCK_PRE);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    error = GlobalStateManager::GetInstance().Locked();
    return error;
}

rtError_t ApiImplSnapshot::SnapShotProcessUnlock()
{
    rtError_t error = GlobalStateManager::GetInstance().Unlocked();
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    error = SnapshotCallbackManager::GetInstance().InvokeCallbacks(RT_SNAPSHOT_UNLOCK_POST);
    return error;
}

rtError_t ApiImplSnapshot::SnapShotProcessBackup()
{
    GlobalStateManager& globalStateManagerInstance = GlobalStateManager::GetInstance();
    std::unique_lock<std::mutex> lock(globalStateManagerInstance.GetStateMtx());
    if (globalStateManagerInstance.GetCurrentState() != RT_PROCESS_STATE_LOCKED) {
        RT_LOG(
            RT_LOG_ERROR, "current state is not the locked state, current state is %s",
            GlobalStateManager::StateToString(globalStateManagerInstance.GetCurrentState()));
        return RT_ERROR_SNAPSHOT_BACKUP_FAILED;
    }

    rtError_t error = SnapshotCallbackManager::GetInstance().InvokeCallbacks(RT_SNAPSHOT_BACKUP_PRE);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    error = cce::runtime::SnapShotProcessBackup();
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    error = SnapshotCallbackManager::GetInstance().InvokeCallbacks(RT_SNAPSHOT_BACKUP_POST);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    globalStateManagerInstance.SetCurrentState(RT_PROCESS_STATE_BACKED_UP);
    return RT_ERROR_NONE;
}

rtError_t ApiImplSnapshot::SnapShotProcessRestore()
{
    GlobalStateManager& globalStateManagerInstance = GlobalStateManager::GetInstance();
    std::unique_lock<std::mutex> lock(globalStateManagerInstance.GetStateMtx());
    if (globalStateManagerInstance.GetCurrentState() != RT_PROCESS_STATE_BACKED_UP) {
        RT_LOG(
            RT_LOG_ERROR, "current state is not the RT_PROCESS_STATE_BACKED_UP state, current state is %s",
            GlobalStateManager::StateToString(globalStateManagerInstance.GetCurrentState()));
        return RT_ERROR_SNAPSHOT_RESTORE_FAILED;
    }

    rtError_t error = SnapshotCallbackManager::GetInstance().InvokeCallbacks(RT_SNAPSHOT_RESTORE_PRE);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    error = cce::runtime::SnapShotProcessRestore();
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    error = SnapshotCallbackManager::GetInstance().InvokeCallbacks(RT_SNAPSHOT_RESTORE_POST);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    globalStateManagerInstance.SetCurrentState(RT_PROCESS_STATE_LOCKED);
    return RT_ERROR_NONE;
}

rtError_t ApiImplSnapshot::SnapShotCallbackRegister(
    const rtSnapShotStage stage, const rtSnapShotCallBack callback, void* const args)
{
    return SnapshotCallbackManager::GetInstance().RegisterCallback(stage, callback, args);
}

rtError_t ApiImplSnapshot::SnapShotCallbackUnregister(const rtSnapShotStage stage, const rtSnapShotCallBack callback)
{
    return SnapshotCallbackManager::GetInstance().UnregisterCallback(stage, callback);
}

} // namespace runtime
} // namespace cce
