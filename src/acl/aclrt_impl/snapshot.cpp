/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "acl_rt_impl.h"
#include "runtime/rts/rts_snapshot.h"
#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "common/prof_reporter.h"
#include "mmpa/mmpa_api.h"

#ifdef __cplusplus
extern "C" {
#endif

aclError aclrtSnapShotProcessLockImpl(int pid, void* reserve)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSnapShotProcessLock);
    ACL_LOG_INFO("start to execute aclrtSnapShotProcessLock, pid=%d, reserve=%p", pid, reserve);

    ACL_CHECK_INVALID_PARAM_WITH_REASON(
        pid != static_cast<int32_t>(mmGetPid()), pid,
        "pid must be current process pid, cross-process operation is not supported");

    ACL_CHECK_INVALID_PARAM_NO_VALUE(
        reserve == nullptr, "reserve", "reserve is a reserved parameter and must be nullptr");

    ACL_REQUIRES_RTS_OK(rtSnapShotProcessLock());

    ACL_LOG_INFO("successfully execute aclrtSnapShotProcessLock");
    return ACL_SUCCESS;
}

aclError aclrtSnapShotProcessUnlockImpl(int pid, void* reserve)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSnapShotProcessUnlock);
    ACL_LOG_INFO("start to execute aclrtSnapShotProcessUnlock, pid=%d, reserve=%p", pid, reserve);

    ACL_CHECK_INVALID_PARAM_WITH_REASON(
        pid != static_cast<int32_t>(mmGetPid()), pid,
        "pid must be current process pid, cross-process operation is not supported");

    ACL_CHECK_INVALID_PARAM_NO_VALUE(
        reserve == nullptr, "reserve", "reserve is a reserved parameter and must be nullptr");

    ACL_REQUIRES_RTS_OK(rtSnapShotProcessUnlock());

    ACL_LOG_INFO("successfully execute aclrtSnapShotProcessUnlock");
    return ACL_SUCCESS;
}

aclError aclrtSnapShotProcessBackupImpl(int pid, aclrtSnapShotBackupArgs* args)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSnapShotProcessBackup);
    ACL_LOG_INFO("start to execute aclrtSnapShotProcessBackup, pid=%d, args=%p", pid, args);

    ACL_CHECK_INVALID_PARAM_WITH_REASON(
        pid != static_cast<int32_t>(mmGetPid()), pid,
        "pid must be current process pid, cross-process operation is not supported");

    ACL_CHECK_INVALID_PARAM_NO_VALUE(args == nullptr, "args", "args is a reserved parameter and must be nullptr");

    ACL_REQUIRES_RTS_OK(rtSnapShotProcessBackup());

    ACL_LOG_INFO("successfully execute aclrtSnapShotProcessBackup");
    return ACL_SUCCESS;
}

aclError aclrtSnapShotProcessRestoreImpl(int pid, aclrtSnapShotRestoreArgs* args)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSnapShotProcessRestore);
    ACL_LOG_INFO("start to execute aclrtSnapShotProcessRestore, pid=%d, args=%p", pid, args);

    ACL_CHECK_INVALID_PARAM_WITH_REASON(
        pid != static_cast<int32_t>(mmGetPid()), pid,
        "pid must be current process pid, cross-process operation is not supported");

    ACL_CHECK_INVALID_PARAM_NO_VALUE(args == nullptr, "args", "args is a reserved parameter and must be nullptr");

    ACL_REQUIRES_RTS_OK(rtSnapShotProcessRestore());

    ACL_LOG_INFO("successfully execute aclrtSnapShotProcessRestore");
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
