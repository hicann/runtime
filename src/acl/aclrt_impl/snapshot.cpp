/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <limits>

#include "utils/data_type_utils.h"
#include "acl_rt_impl.h"
#include "runtime/rts/rts_snapshot.h"
#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "common/prof_reporter.h"
#include "mmpa/mmpa_api.h"
#include "securec.h"
#include "snapshot_socket.hpp"
#include "api_snapshot.hpp"
#include "errcode_manage.hpp"

#ifdef __cplusplus
extern "C" {
#endif

static rtError_t CallRemoteSnapshot(int32_t pid, cce::runtime::rtSnapshotOp op, const void* args, uint32_t& value)
{
    cce::runtime::SnapshotMemoryArgs localArgs = {};
    if (args != nullptr) {
        const auto ret = memcpy_s(&localArgs, sizeof(localArgs), args, sizeof(localArgs));
        if (ret != EOK) {
            ACL_LOG_INNER_ERROR("Failed to copy snapshot arguments, result=%d.", ret);
            return ACL_ERROR_RT_INTERNAL_ERROR;
        }
    }
    const rtError_t error = cce::runtime::SnapshotSocketCall(pid, op, args == nullptr ? nullptr : &localArgs, value);
    // Socket implementations, including platform stubs, return internal RT codes.
    return cce::runtime::ErrorcodeManage::Instance().GetRtExtErrCode(error);
}

aclError aclrtSnapShotProcessLockImpl(int pid, void* reserve)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSnapShotProcessLock);
    ACL_LOG_INFO("start to execute aclrtSnapShotProcessLock, pid=%d, reserve=%p", pid, reserve);

    ACL_CHECK_INVALID_PARAM_WITH_REASON(pid <= 0, pid, "pid must be positive");

    ACL_CHECK_INVALID_PARAM_NO_VALUE(
        reserve == nullptr, "reserve", "reserve is a reserved parameter and must be nullptr");

    if (pid != mmGetPid()) {
        uint32_t value = 0U;
        ACL_REQUIRES_RTS_OK(CallRemoteSnapshot(pid, cce::runtime::rtSnapshotOp::LOCK, nullptr, value));
    } else {
        ACL_REQUIRES_RTS_OK(rtSnapShotProcessLock());
    }

    ACL_LOG_INFO("successfully execute aclrtSnapShotProcessLock");
    return ACL_SUCCESS;
}

aclError aclrtSnapShotProcessUnlockImpl(int pid, void* reserve)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSnapShotProcessUnlock);
    ACL_LOG_INFO("start to execute aclrtSnapShotProcessUnlock, pid=%d, reserve=%p", pid, reserve);

    ACL_CHECK_INVALID_PARAM_WITH_REASON(pid <= 0, pid, "pid must be positive");

    ACL_CHECK_INVALID_PARAM_NO_VALUE(
        reserve == nullptr, "reserve", "reserve is a reserved parameter and must be nullptr");

    if (pid != mmGetPid()) {
        uint32_t value = 0U;
        ACL_REQUIRES_RTS_OK(CallRemoteSnapshot(pid, cce::runtime::rtSnapshotOp::UNLOCK, nullptr, value));
    } else {
        ACL_REQUIRES_RTS_OK(rtSnapShotProcessUnlock());
    }

    ACL_LOG_INFO("successfully execute aclrtSnapShotProcessUnlock");
    return ACL_SUCCESS;
}

aclError aclrtSnapShotProcessBackupImpl(int pid, aclrtSnapShotBackupArgs* args)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSnapShotProcessBackup);
    ACL_LOG_INFO("start to execute aclrtSnapShotProcessBackup, pid=%d, args=%p", pid, args);

    ACL_CHECK_INVALID_PARAM_WITH_REASON(pid <= 0, pid, "pid must be positive");

    if (args != nullptr) {
        ACL_CHECK_INVALID_VALUE_WITH_DESC(
            args->backupFlags <= ACL_RT_SNAPSHOT_BACKUP_INCLUDE_OPTIONAL,
            acl::GetSnapshotBackupFlagDesc(args->backupFlags).c_str(), "args->backupFlags",
            acl::FormatEnumExpectedDesc(
                "ACL_RT_SNAPSHOT_BACKUP_REQUIRED_ONLY(%u) or ACL_RT_SNAPSHOT_BACKUP_INCLUDE_OPTIONAL(%u)",
                static_cast<uint32_t>(ACL_RT_SNAPSHOT_BACKUP_REQUIRED_ONLY),
                static_cast<uint32_t>(ACL_RT_SNAPSHOT_BACKUP_INCLUDE_OPTIONAL))
                .c_str(),
            ACL_ERROR_INVALID_PARAM);
    }

    if (pid != mmGetPid()) {
        uint32_t value = 0U;
        ACL_REQUIRES_RTS_OK(CallRemoteSnapshot(pid, cce::runtime::rtSnapshotOp::BACKUP, args, value));
        return ACL_SUCCESS;
    }

    if (args == nullptr) {
        ACL_REQUIRES_RTS_OK(rtSnapShotProcessBackup());
    } else {
        ACL_REQUIRES_RTS_OK(rtSnapShotProcessBackupWithArgs(reinterpret_cast<const rtSnapShotBackupArgs*>(args)));
    }

    ACL_LOG_INFO("successfully execute aclrtSnapShotProcessBackup");
    return ACL_SUCCESS;
}

aclError aclrtSnapShotProcessRestoreImpl(int pid, aclrtSnapShotRestoreArgs* args)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSnapShotProcessRestore);
    ACL_LOG_INFO("start to execute aclrtSnapShotProcessRestore, pid=%d, args=%p", pid, args);

    ACL_CHECK_INVALID_PARAM_WITH_REASON(pid <= 0, pid, "pid must be positive");

    if (args != nullptr) {
        ACL_CHECK_INVALID_VALUE_WITH_DESC(
            args->restoreFlags <= ACL_RT_SNAPSHOT_RESTORE_INCLUDE_OPTIONAL,
            acl::GetSnapshotRestoreFlagDesc(args->restoreFlags).c_str(), "args->restoreFlags",
            acl::FormatEnumExpectedDesc(
                "ACL_RT_SNAPSHOT_RESTORE_REQUIRED_ONLY(%u) or ACL_RT_SNAPSHOT_RESTORE_INCLUDE_OPTIONAL(%u)",
                static_cast<uint32_t>(ACL_RT_SNAPSHOT_RESTORE_REQUIRED_ONLY),
                static_cast<uint32_t>(ACL_RT_SNAPSHOT_RESTORE_INCLUDE_OPTIONAL))
                .c_str(),
            ACL_ERROR_INVALID_PARAM);
    }

    if (pid != mmGetPid()) {
        uint32_t value = 0U;
        ACL_REQUIRES_RTS_OK(CallRemoteSnapshot(pid, cce::runtime::rtSnapshotOp::RESTORE, args, value));
        return ACL_SUCCESS;
    }

    if (args == nullptr) {
        ACL_REQUIRES_RTS_OK(rtSnapShotProcessRestore());
    } else {
        ACL_REQUIRES_RTS_OK(rtSnapShotProcessRestoreWithArgs(reinterpret_cast<const rtSnapShotRestoreArgs*>(args)));
    }

    ACL_LOG_INFO("successfully execute aclrtSnapShotProcessRestore");
    return ACL_SUCCESS;
}

aclError aclrtSnapshotProcessGetStateImpl(int pid, aclrtProcessState* state)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSnapshotProcessGetState);
    ACL_CHECK_INVALID_PARAM_WITH_REASON(pid <= 0, pid, "pid must be positive");
    ACL_REQUIRES_NOT_NULL(state);
    uint32_t value = 0U;
    if (pid != mmGetPid()) {
        ACL_REQUIRES_RTS_OK(CallRemoteSnapshot(pid, cce::runtime::rtSnapshotOp::GET_STATE, nullptr, value));
    } else {
        rtProcessState localState = RT_PROCESS_STATE_RUNNING;
        ACL_REQUIRES_RTS_OK(rtSnapShotProcessGetState(&localState));
        value = static_cast<uint32_t>(localState);
    }
    if (value > static_cast<uint32_t>(ACL_RT_PROCESS_STATE_FAILED)) {
        ACL_LOG_INNER_ERROR(
            "Invalid snapshot process state: pid=%d, state=%u, expected range=[%u, %u].", pid, value,
            static_cast<uint32_t>(ACL_RT_PROCESS_STATE_RUNNING), static_cast<uint32_t>(ACL_RT_PROCESS_STATE_FAILED));
        return ACL_ERROR_RT_INTERNAL_ERROR;
    }
    *state = static_cast<aclrtProcessState>(value);
    return ACL_SUCCESS;
}

aclError aclrtSnapshotProcessGetRestoreThreadIdImpl(int pid, int* tid)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSnapshotProcessGetRestoreThreadId);
    ACL_CHECK_INVALID_PARAM_WITH_REASON(pid <= 0, pid, "pid must be positive");
    ACL_REQUIRES_NOT_NULL(tid);
    uint32_t value = 0U;
    if (pid != mmGetPid()) {
        ACL_REQUIRES_RTS_OK(CallRemoteSnapshot(pid, cce::runtime::rtSnapshotOp::GET_RESTORE_THREAD_ID, nullptr, value));
    } else {
        int32_t localTid = 0;
        ACL_REQUIRES_RTS_OK(rtSnapShotProcessGetRestoreThreadId(&localTid));
        value = static_cast<uint32_t>(localTid);
    }
    if ((value == 0U) || (value > static_cast<uint32_t>(std::numeric_limits<int>::max()))) {
        ACL_LOG_INNER_ERROR(
            "Invalid snapshot restore thread ID: pid=%d, tid=%u, expected range=[1, %d].", pid, value,
            std::numeric_limits<int>::max());
        return ACL_ERROR_RT_INTERNAL_ERROR;
    }
    *tid = static_cast<int>(value);
    return ACL_SUCCESS;
}

aclError aclrtSnapShotCallbackRegisterImpl(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback, void* args)
{
    ACL_LOG_INFO("start to execute aclrtSnapShotCallbackRegister");
    ACL_REQUIRES_RTS_OK(rtSnapShotCallbackRegister(
        static_cast<rtSnapShotStage>(stage), static_cast<rtSnapShotCallBack>(callback), args));
    ACL_LOG_INFO("successfully execute aclrtSnapShotCallbackRegister");
    return ACL_SUCCESS;
}

aclError aclrtSnapShotCallbackUnregisterImpl(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback)
{
    ACL_LOG_INFO("start to execute aclrtSnapShotCallbackUnregister");
    ACL_REQUIRES_RTS_OK(
        rtSnapShotCallbackUnregister(static_cast<rtSnapShotStage>(stage), static_cast<rtSnapShotCallBack>(callback)));
    ACL_LOG_INFO("successfully execute aclrtSnapShotCallbackUnregister");
    return ACL_SUCCESS;
}
#ifdef __cplusplus
}
#endif
