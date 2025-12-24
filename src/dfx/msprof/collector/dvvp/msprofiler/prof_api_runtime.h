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
#include "singleton/singleton.h"
#include "prof_utils.h"

namespace ProfRtAPI {
using VOID_PTR = void *;
using RtGetVisibleDeviceIdByLogicDeviceIdFunc = int32_t (*) (int32_t logicDeviceId, int32_t* visibleDeviceId);

class ExtendPlugin : public analysis::dvvp::common::singleton::Singleton<ExtendPlugin> {
public:
    void RuntimeApiInit();
    int32_t ProfGetVisibleDeviceIdByLogicDeviceId(int32_t logicDeviceId, int32_t* visibleDeviceId) const;
    ~ExtendPlugin() override;
private:
    VOID_PTR msRuntimeLibHandle_{nullptr};
    ProfAPI::PTHREAD_ONCE_T loadFlag_;
    RtGetVisibleDeviceIdByLogicDeviceIdFunc rtGetVisibleDeviceIdByLogicDeviceId_{nullptr};
private:
    void LoadProfApi();
};
}
#endif