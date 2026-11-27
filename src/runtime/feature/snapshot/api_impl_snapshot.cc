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

#include <new>

#include "api_impl_creator.hpp"
#include "error_message_manage.hpp"
#include "global_state_manager.hpp"
#include "dev_info_manage.h"
#include "snapshot_process_helper.hpp"

namespace cce {
namespace runtime {

bool IsImplSnapshotSupported() { return true; }

ApiSnapshot* CreateImplSnapshotAndGet()
{
    ApiImplSnapshot* const apiImplSnapshot = new (std::nothrow) ApiImplSnapshot();
    if (apiImplSnapshot == nullptr) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, sizeof(ApiImplSnapshot), "new");
        RT_LOG(RT_LOG_ERROR, "create ApiImplSnapshot failed.");
        return nullptr;
    }
    RT_LOG(RT_LOG_INFO, "ApiImplSnapshot:Runtime_alloc_size %zu bytes", sizeof(ApiImplSnapshot));
    return apiImplSnapshot;
}

void DestroyImplSnapshot(ApiSnapshot*& apiImplSnapshot)
{
    delete apiImplSnapshot;
    apiImplSnapshot = nullptr;
}

void ApiImplSnapshot::StartSnapshotService(const rtChipType_t chipType)
{
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DFX_PROCESS_SNAPSHOT)) {
        return;
    }
    const rtError_t error = service_.StartSnapshotService(this);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "Snapshot socket service unavailable, ret=%d. Local snapshot remains available.", error);
    }
}

void ApiImplSnapshot::StopSnapshotService() { service_.StopSnapshotService(); }

rtError_t ApiImplSnapshot::SnapShotProcessGetState(rtProcessState* state)
{
    *state = GlobalStateManager::GetInstance().GetCurrentState();
    return RT_ERROR_NONE;
}

rtError_t ApiImplSnapshot::SnapShotProcessGetRestoreThreadId(int32_t* tid)
{
    const int32_t serviceTid = service_.GetSnapshotThreadId();
    COND_RETURN_ERROR_MSG_INNER(
        serviceTid <= 0, RT_ERROR_OS_HANDLE, "Snapshot socket service is unavailable, pid=%d, tid=%d.", mmGetPid(),
        serviceTid);
    *tid = serviceTid;
    return RT_ERROR_NONE;
}

rtError_t ApiImplSnapshot::SnapShotProcessLock()
{
    rtError_t error = callbacks_.InvokeCallbacks(RT_SNAPSHOT_LOCK_PRE);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    error = GlobalStateManager::GetInstance().Locked();
    return error;
}

rtError_t ApiImplSnapshot::SnapShotProcessUnlock()
{
    rtError_t error = GlobalStateManager::GetInstance().Unlocked();
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    error = callbacks_.InvokeCallbacks(RT_SNAPSHOT_UNLOCK_POST);
    return error;
}

rtError_t ApiImplSnapshot::SnapShotProcessBackup(const rtSnapShotBackupArgs* const args)
{
    GlobalStateManager& globalStateManagerInstance = GlobalStateManager::GetInstance();
    std::unique_lock<std::mutex> lock(globalStateManagerInstance.GetStateMtx());
    if (globalStateManagerInstance.GetCurrentState() != RT_PROCESS_STATE_LOCKED) {
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1018, "Backing up the process snapshot",
            RtFmtMsg(
                "Current process state is %s. Before calling aclrtSnapShotProcessBackup, call aclrtSnapShotProcessLock "
                "first to ensure that the current process is in the LOCKED state",
                GlobalStateManager::StateToString(globalStateManagerInstance.GetCurrentState())));
        return RT_ERROR_SNAPSHOT_BACKUP_FAILED;
    }

    rtError_t error = callbacks_.InvokeCallbacks(RT_SNAPSHOT_BACKUP_PRE);
    COND_PROC_RETURN_ERROR(
        error != RT_ERROR_NONE, error, globalStateManagerInstance.SetCurrentState(RT_PROCESS_STATE_FAILED),
        "Snapshot operation failed, ret=%#x.", error);
    error = cce::runtime::SnapShotProcessBackup(args);
    COND_PROC_RETURN_ERROR(
        error != RT_ERROR_NONE, error, globalStateManagerInstance.SetCurrentState(RT_PROCESS_STATE_FAILED),
        "Snapshot operation failed, ret=%#x.", error);
    error = callbacks_.InvokeCallbacks(RT_SNAPSHOT_BACKUP_POST);
    COND_PROC_RETURN_ERROR(
        error != RT_ERROR_NONE, error, globalStateManagerInstance.SetCurrentState(RT_PROCESS_STATE_FAILED),
        "Snapshot operation failed, ret=%#x.", error);
    globalStateManagerInstance.SetCurrentState(RT_PROCESS_STATE_BACKED_UP);
    return RT_ERROR_NONE;
}

rtError_t ApiImplSnapshot::SnapShotProcessRestore(const rtSnapShotRestoreArgs* const args)
{
    GlobalStateManager& globalStateManagerInstance = GlobalStateManager::GetInstance();
    std::unique_lock<std::mutex> lock(globalStateManagerInstance.GetStateMtx());
    if (globalStateManagerInstance.GetCurrentState() != RT_PROCESS_STATE_BACKED_UP) {
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1018, "Restoring the process snapshot",
            RtFmtMsg(
                "Current process state is %s. Before calling aclrtSnapShotProcessRestore, call "
                "aclrtSnapShotProcessLock and aclrtSnapShotProcessBackup first to ensure that the current process is "
                "in the BACKED_UP state",
                GlobalStateManager::StateToString(globalStateManagerInstance.GetCurrentState())));
        return RT_ERROR_SNAPSHOT_RESTORE_FAILED;
    }

    rtError_t error = callbacks_.InvokeCallbacks(RT_SNAPSHOT_RESTORE_PRE);
    COND_PROC_RETURN_ERROR(
        error != RT_ERROR_NONE, error, globalStateManagerInstance.SetCurrentState(RT_PROCESS_STATE_FAILED),
        "Snapshot operation failed, ret=%#x.", error);
    error = cce::runtime::SnapShotProcessRestore(args);
    COND_PROC_RETURN_ERROR(
        error != RT_ERROR_NONE, error, globalStateManagerInstance.SetCurrentState(RT_PROCESS_STATE_FAILED),
        "Snapshot operation failed, ret=%#x.", error);
    error = callbacks_.InvokeCallbacks(RT_SNAPSHOT_RESTORE_POST);
    COND_PROC_RETURN_ERROR(
        error != RT_ERROR_NONE, error, globalStateManagerInstance.SetCurrentState(RT_PROCESS_STATE_FAILED),
        "Snapshot operation failed, ret=%#x.", error);
    globalStateManagerInstance.SetCurrentState(RT_PROCESS_STATE_LOCKED);
    return RT_ERROR_NONE;
}

rtError_t ApiImplSnapshot::SnapShotCallbackRegister(
    const rtSnapShotStage stage, const rtSnapShotCallBack callback, void* const args)
{
    return callbacks_.RegisterCallback(stage, callback, args);
}

rtError_t ApiImplSnapshot::SnapShotCallbackUnregister(const rtSnapShotStage stage, const rtSnapShotCallBack callback)
{
    return callbacks_.UnregisterCallback(stage, callback);
}

} // namespace runtime
} // namespace cce
