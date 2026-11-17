/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl_creator.hpp"
#include "snapshot_socket.hpp"

namespace cce {
namespace runtime {

bool IsImplSnapshotSupported() { return false; }

ApiSnapshot* CreateImplSnapshotAndGet() { return nullptr; }

void DestroyImplSnapshot(ApiSnapshot*& apiImplSnapshot) { apiImplSnapshot = nullptr; }

rtError_t SnapshotSocketCall(int32_t, rtSnapshotOp, const SnapshotMemoryArgs*, uint32_t&)
{
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

SnapshotService::~SnapshotService() = default;

rtError_t SnapshotService::StartSnapshotService(SnapshotRequestHandler*) { return RT_ERROR_FEATURE_NOT_SUPPORT; }

void SnapshotService::StopSnapshotService() {}

int32_t SnapshotService::GetSnapshotThreadId() const { return 0; }

} // namespace runtime
} // namespace cce
