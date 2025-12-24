/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROF_PLUGIN_MANAGER_H
#define PROF_PLUGIN_MANAGER_H
#include "singleton/singleton.h"
#include "prof_plugin.h"
namespace ProfAPI {
using PROF_PLUGIN_PTR = ProfPlugin *;
class ProfPluginManager : public analysis::dvvp::common::singleton::Singleton<ProfPluginManager> {
public:
    PROF_PLUGIN_PTR GetProfPlugin(void);
    void SetProfPlugin(PROF_PLUGIN_PTR plugin);
    PROF_PLUGIN_PTR profPlugin_{nullptr};
};

}
#endif