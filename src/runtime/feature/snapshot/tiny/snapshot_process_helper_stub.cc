/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "snapshot_process_helper.hpp"

namespace cce {
namespace runtime {

rtError_t SnapShotPreProcessBackup(ContextDataManage& ctxMan)
{
    UNUSED(ctxMan);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t SnapShotDeviceRestore() { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t SnapShotResourceRestore(ContextDataManage& ctxMan)
{
    UNUSED(ctxMan);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t SnapShotAclGraphRestore(Device* const dev)
{
    UNUSED(dev);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t SnapShotProcessBackup() { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t SnapShotProcessRestore() { return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t ModelBackup(const int32_t devId)
{
    UNUSED(devId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ModelRestore(const int32_t devId)
{
    UNUSED(devId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t SinkTaskMemoryBackup(const int32_t devId)
{
    UNUSED(devId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

} // namespace runtime
} // namespace cce