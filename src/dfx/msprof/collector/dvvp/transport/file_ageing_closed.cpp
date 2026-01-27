/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "file_ageing.h"
#include <sys/types.h>
#include "config/config.h"
#include "config_manager.h"
#include "logger/msprof_dlog.h"
#include "utils/utils.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Common::Config;
constexpr uint64_t MOVE_BIT = 20;
constexpr uint64_t STORAGE_RESERVED_VOLUME = (STORAGE_LIMIT_DOWN_THD / 10) << MOVE_BIT;

int32_t FileAgeing::Init()
{
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE) {
        MSPROF_LOGW("platform type is MINI_TYPE, not support file ageing");
        return PROFILING_SUCCESS;
    }
    return Init2();
}
}
}
}