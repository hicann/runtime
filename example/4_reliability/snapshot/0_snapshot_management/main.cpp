/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdint>
#include "acl/acl.h"
#include "utils.h"

namespace {
uint32_t SnapshotCallback(int32_t deviceId, void *args)
{
    const char *stageName = static_cast<const char *>(args);
    INFO_LOG("Snapshot callback on device %d, stage=%s", deviceId, stageName == nullptr ? "<null>" : stageName);
    return 0;
}
}
int main()
{
    const int32_t deviceId = 0;
    CHECK_ERROR(aclInit(nullptr)); CHECK_ERROR(aclrtSetDevice(deviceId));
    CHECK_ERROR(aclrtSnapShotCallbackRegister(ACL_RT_SNAPSHOT_LOCK_PRE, SnapshotCallback, const_cast<char *>("LOCK_PRE")));
    CHECK_ERROR(aclrtSnapShotCallbackRegister(ACL_RT_SNAPSHOT_BACKUP_PRE, SnapshotCallback, const_cast<char *>("BACKUP_PRE")));
    CHECK_ERROR(aclrtSnapShotCallbackRegister(ACL_RT_SNAPSHOT_BACKUP_POST, SnapshotCallback, const_cast<char *>("BACKUP_POST")));
    CHECK_ERROR(aclrtSnapShotCallbackRegister(ACL_RT_SNAPSHOT_RESTORE_PRE, SnapshotCallback, const_cast<char *>("RESTORE_PRE")));
    CHECK_ERROR(aclrtSnapShotCallbackRegister(ACL_RT_SNAPSHOT_RESTORE_POST, SnapshotCallback, const_cast<char *>("RESTORE_POST")));
    CHECK_ERROR(aclrtSnapShotCallbackRegister(ACL_RT_SNAPSHOT_UNLOCK_POST, SnapshotCallback, const_cast<char *>("UNLOCK_POST")));
    CHECK_ERROR(aclrtSnapShotProcessLock()); CHECK_ERROR(aclrtSnapShotProcessBackup()); CHECK_ERROR(aclrtSnapShotProcessUnlock());
    CHECK_ERROR(aclrtSnapShotProcessLock()); CHECK_ERROR(aclrtSnapShotProcessRestore()); CHECK_ERROR(aclrtSnapShotProcessUnlock());
    CHECK_ERROR(aclrtSnapShotCallbackUnregister(ACL_RT_SNAPSHOT_LOCK_PRE, SnapshotCallback)); CHECK_ERROR(aclrtSnapShotCallbackUnregister(ACL_RT_SNAPSHOT_BACKUP_PRE, SnapshotCallback)); CHECK_ERROR(aclrtSnapShotCallbackUnregister(ACL_RT_SNAPSHOT_BACKUP_POST, SnapshotCallback)); CHECK_ERROR(aclrtSnapShotCallbackUnregister(ACL_RT_SNAPSHOT_RESTORE_PRE, SnapshotCallback)); CHECK_ERROR(aclrtSnapShotCallbackUnregister(ACL_RT_SNAPSHOT_RESTORE_POST, SnapshotCallback)); CHECK_ERROR(aclrtSnapShotCallbackUnregister(ACL_RT_SNAPSHOT_UNLOCK_POST, SnapshotCallback));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId)); CHECK_ERROR(aclFinalize()); return 0;
}