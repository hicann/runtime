/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_SNAPSHOT_PROCESS_HELPER_HPP
#define CCE_RUNTIME_SNAPSHOT_PROCESS_HELPER_HPP

#include "base.hpp"
#include "context_data_manage.h"
#include "rts_snapshot.h"

namespace cce {
namespace runtime {
class Device;

rtError_t SnapShotPreProcessBackup(ContextDataManage& ctxMan);
rtError_t SnapShotDeviceRestore(const uint32_t restoreFlags);
rtError_t SnapShotResourceRestore(ContextDataManage& ctxMan);
rtError_t SnapShotAclGraphRestore(Device* const dev);

rtError_t SnapShotProcessBackup(const rtSnapShotBackupArgs* const args);
rtError_t SnapShotProcessRestore(const rtSnapShotRestoreArgs* const args);
rtError_t ModelBackup(const int32_t devId, const bool allCompatible = false);
rtError_t ModelRestore(const int32_t devId);
rtError_t SinkTaskMemoryBackup(const int32_t devId);
} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_SNAPSHOT_PROCESS_HELPER_HPP
