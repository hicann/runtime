/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log/adx_log.h"
#include "path.h"
#include "dump_manager.h"
#include "sys_utils.h"
#include "exception_dumper.h"

namespace Adx {

int32_t ExceptionDumper::LoadTensorPluginLib()
{
    // Not support tensor plugin feature
    return ADUMP_SUCCESS;
}

int32_t ExceptionDumper::DumpArgsException(const rtExceptionInfo &exception, const std::string &dumpPath) const
{
    // common L0 excpetion dump
    return DumpArgsExceptionInner(exception, dumpPath);
}

int32_t ExceptionDumper::DumpDetailException(const rtExceptionInfo &exception, const std::string &dumpPath)
{
    // Not support detail exception dump, downgrade to L0 exception dump
    if (coredumpEnableComplete_) {
        return DumpArgsException(exception, dumpPath);
    }
    return ADUMP_SUCCESS;
}
}  // namespace Adx
