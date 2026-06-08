/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ACL_RT_IMPL_TOOLCHAIN_DUMP_SHIM_H
#define ACL_RT_IMPL_TOOLCHAIN_DUMP_SHIM_H

#include <cstddef>
#include <cstdint>
#include "acl/acl_base.h"

namespace acl {
struct AdumpDumpConfigInfo {
    const char* dumpConfigPath;
    const char* dumpConfigData;
    size_t dumpConfigSize;
};

typedef int32_t (*AdumpSetDumpConfigFunc)(const AdumpDumpConfigInfo& configInfo);
typedef int32_t (*AdumpUnSetDumpFunc)();
typedef int (*AdxDataDumpServerInitFunc)();
typedef int (*AdxDataDumpServerUnInitFunc)();

struct AdumpCallbacks {
    AdumpSetDumpConfigFunc setDumpConfig;
    AdumpUnSetDumpFunc unsetDump;
    AdxDataDumpServerInitFunc serverInit;
    AdxDataDumpServerUnInitFunc serverUnInit;
};

ACL_FUNC_VISIBILITY void SetAdumpCallbacks(const AdumpCallbacks& callbacks);
const AdumpCallbacks& GetAdumpCallbacks();
} // namespace acl

#endif // ACL_RT_IMPL_TOOLCHAIN_DUMP_SHIM_H
