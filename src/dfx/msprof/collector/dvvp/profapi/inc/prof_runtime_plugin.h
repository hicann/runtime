/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROF_RUNTIME_API_H
#define PROF_RUNTIME_API_H
#include <cstdint>
#include <map>
#include <string>
#include "singleton/singleton.h"
#include "prof_utils.h"
#include "acl/acl_base.h"
#include "runtime/base.h"
#include "runtime/kernel.h"
#include "error_codes/rt_error_codes.h"

namespace ProfAPI {
using RtProfilerTraceExFunc = rtError_t (*) (uint64_t indexId, uint64_t modelId, uint16_t tagId, rtStream_t stm);

struct RuntimeApiInfo {
    std::string funcName;
    void *funcAddr;
};

class ProfRuntimePlugin : public analysis::dvvp::common::singleton::Singleton<ProfRuntimePlugin> {
public:
    ~ProfRuntimePlugin() override;
    int32_t RuntimeApiInit();
    void *GetPluginApiFunc(const std::string funcName);
    int32_t ProfMarkEx(uint64_t indexId, uint64_t modelId, uint16_t tagId, void *stm);

private:
    void LoadRuntimeApi();

private:
    void *runtimeLibHandle_{nullptr};
    ProfAPI::PTHREAD_ONCE_T runtimeApiloadFlag_;
    std::map<std::string, RuntimeApiInfo> runtimeApiInfoMap_{};
};
}
#endif