/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "errno/error_code.h"
#include "collect_io_server_stub.h"

using namespace analysis::dvvp::common::error;

int ProfilerServerInit(const std::string &local_sock_name) {
    return PROFILING_SUCCESS;
}

int RegisterSendData(const std::string &name, int (*func)(CONST_VOID_PTR, uint32_t)) {
    return PROFILING_SUCCESS;
}

int control_profiling(const char* uuid, const char* config, uint32_t config_len) {
    return PROFILING_SUCCESS;
}

int profiler_server_send_data(const void* ctx, const void* pkt, uint32_t size)
{
    return PROFILING_SUCCESS;
}

int ProfilerServerDestroy() {
    return PROFILING_SUCCESS;
}
