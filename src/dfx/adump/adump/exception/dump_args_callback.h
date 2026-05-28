/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DUMP_ARGS_CALLBACK_H
#define DUMP_ARGS_CALLBACK_H

#include <cstdint>
#include <vector>
#include <string>
#include "str_utils.h"
#include "adump_pub.h"
#include "dump_args.h"
#include "dump_file.h"
#include "dump_tensor.h"
#include "runtime/base.h"
#include "sys_utils.h"
#include "log/hdc_log.h"

namespace Adx {

class DumpArgsCallback {
public:
    DumpArgsCallback(const rtExceptionInfo &exception, const ExceptionDumpInfo &info, const std::string &dumpPath);
    int32_t DumpDfxArgs();
    int32_t DumpExtraTensors();
    int32_t Dump();
    int32_t DumpKernelBin();

private:
    int32_t QueryDfxInfo(std::vector<uint8_t> &dfxBuffer);
    int32_t QueryDfxIsTikInfo(rtFuncHandle funcHandle);
    void RecordDumpLog(const std::string &log);
    
    std::vector<std::string> logRecord_;
    std::vector<TensorBuffer> tensorBuffer_;
    std::vector<DumpWorkspace> workspaces_;
    ExceptionDumpInfo info_;
    std::string dumpPath_;
    std::string dumpFilePath_;
    DumpFile dumpFile_;
    std::vector<uint8_t> dfxBuffer_;
    bool isTik_{false};
};

} // namespace Adx

#endif // DUMP_ARGS_CALLBACK_H
