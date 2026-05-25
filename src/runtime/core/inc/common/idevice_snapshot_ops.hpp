 /**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_IDEVICE_SNAPSHOT_OPS_HPP
#define RUNTIME_IDEVICE_SNAPSHOT_OPS_HPP

#include "base.h"

namespace cce {
namespace runtime {

class IDeviceSnapshotOps {
public:
    virtual ~IDeviceSnapshotOps() = default;

    virtual rtError_t OpMemoryBackup() = 0;
    virtual rtError_t OpMemoryRestore() = 0;
    virtual rtError_t ArgsPoolRestore() const = 0;
    virtual rtError_t UbArgsPoolRestore() const = 0;
};

}
}

#endif