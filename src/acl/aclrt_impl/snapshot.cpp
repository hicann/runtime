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

aclError aclrtSnapShotProcessLockImpl()
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSnapShotProcessLock);
    ACL_LOG_INFO("start to execute aclrtSnapShotProcessLock");
    const rtError_t rtErr = rtSnapShotProcessLock();
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("execute SnapShotProcessLock failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtSnapShotProcessLock");
    return ACL_SUCCESS;
}

aclError aclrtSnapShotProcessUnlockImpl()
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSnapShotProcessUnlock);
    ACL_LOG_INFO("start to execute aclrtSnapShotProcessUnlock");
    const rtError_t rtErr = rtSnapShotProcessUnlock();
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("execute SnapShotProcessUnLock failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtSnapShotProcessUnlock");
    return ACL_SUCCESS;
}

aclError aclrtSnapShotProcessBackupImpl()
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSnapShotProcessBackup);
    ACL_LOG_INFO("start to execute aclrtSnapShotProcessBackup");
    const rtError_t rtErr = rtSnapShotProcessBackup();
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("execute SnapShotProcessBackup failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtSnapShotProcessBackup");
    return ACL_SUCCESS;
}

aclError aclrtSnapShotProcessRestoreImpl()
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSnapShotProcessRestore);
    ACL_LOG_INFO("start to execute aclrtSnapShotProcessRestore");
    const rtError_t rtErr = rtSnapShotProcessRestore();
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("execute SnapShotProcessRestore failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }

    ACL_LOG_INFO("successfully execute aclrtSnapShotProcessRestore");
    return ACL_SUCCESS;
}

aclError aclrtSnapShotCallbackRegisterImpl(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback, void* args)
{
    ACL_LOG_INFO("start to execute aclrtSnapShotCallbackRegister");
    const rtError_t rtErr = rtSnapShotCallbackRegister(
        static_cast<rtSnapShotStage>(stage), static_cast<rtSnapShotCallBack>(callback), args);
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR("execute SnapShotCallbackRegister failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtSnapShotCallbackRegister");
    return ACL_SUCCESS;
}

aclError aclrtSnapShotCallbackUnregisterImpl(aclrtSnapShotStage stage, aclrtSnapShotCallBack callback)
{
    ACL_LOG_INFO("start to execute aclrtSnapShotCallbackUnregister");
    const rtError_t rtErr =
        rtSnapShotCallbackUnregister(static_cast<rtSnapShotStage>(stage), static_cast<rtSnapShotCallBack>(callback));
    if (rtErr != RT_ERROR_NONE) {
        ACL_LOG_CALL_ERROR(
            "execute SnapShotCallbackUnregister failed, runtime result = %d", static_cast<int32_t>(rtErr));
        return ACL_GET_ERRCODE_RTS(rtErr);
    }
    ACL_LOG_INFO("successfully execute aclrtSnapShotCallbackUnregister");
    return ACL_SUCCESS;
}
