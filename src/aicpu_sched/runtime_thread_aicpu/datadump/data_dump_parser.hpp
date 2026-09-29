/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_THREAD_AICPU_DATA_DUMP_PARSER_HPP
#define RUNTIME_THREAD_AICPU_DATA_DUMP_PARSER_HPP

#include <cstdint>
#include <string>

#include "aicpu_sched/runtime_thread_aicpu_plugin.h"
#include "data_dump_types.hpp"

namespace cce {
namespace runtime_thread_aicpu {
namespace datadump {

class DataDumpParser final {
public:
    RuntimeThreadAicpuStatus Parse(
        const void* const dumpInfo, const uint32_t length, ParsedDumpCommand& command, std::string& errorDetail) const;
};

} // namespace datadump
} // namespace runtime_thread_aicpu
} // namespace cce

#endif
