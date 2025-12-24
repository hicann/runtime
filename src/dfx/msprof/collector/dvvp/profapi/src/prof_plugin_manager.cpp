/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_plugin_manager.h"
#include "errno/error_code.h"
#include "prof_cann_plugin.h"
#include "prof_atls_plugin.h"
using namespace analysis::dvvp::common::error;
namespace ProfAPI {
PROF_PLUGIN_PTR ProfPluginManager::GetProfPlugin(void)
{
    if (profPlugin_ == nullptr) {
        profPlugin_ = ProfAPI::ProfCannPlugin::instance();
    }
    return profPlugin_;
}

void ProfPluginManager::SetProfPlugin(PROF_PLUGIN_PTR plugin)
{
    profPlugin_ = plugin;
}
}