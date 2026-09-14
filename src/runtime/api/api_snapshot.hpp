/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_SNAPSHOT_HPP
#define CCE_RUNTIME_API_SNAPSHOT_HPP

#include "base.hpp"
#include "rts_snapshot.h"

namespace cce {
namespace runtime {

class ApiSnapshot {
public:
    ApiSnapshot() = default;
    virtual ~ApiSnapshot() = default;

    ApiSnapshot(const ApiSnapshot&) = delete;
    ApiSnapshot& operator=(const ApiSnapshot&) = delete;
    ApiSnapshot(ApiSnapshot&&) = delete;
    ApiSnapshot& operator=(ApiSnapshot&&) = delete;

    static ApiSnapshot* Instance();

    virtual rtError_t SnapShotProcessLock() = 0;
    virtual rtError_t SnapShotProcessUnlock() = 0;
    virtual rtError_t SnapShotProcessBackup() = 0;
    virtual rtError_t SnapShotProcessRestore() = 0;
    virtual rtError_t SnapShotCallbackRegister(rtSnapShotStage stage, rtSnapShotCallBack callback, void* args) = 0;
    virtual rtError_t SnapShotCallbackUnregister(rtSnapShotStage stage, rtSnapShotCallBack callback) = 0;
};

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_API_SNAPSHOT_HPP
