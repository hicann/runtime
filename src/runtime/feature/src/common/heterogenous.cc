/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "heterogenous.h"
#include "config.hpp"
#include "error_message_manage.hpp"
#include "config_define.hpp"
#include "utils.h"
namespace cce {
namespace runtime {
int32_t ReadHeterogenousModeFromConfigIni(void)
{
    std::string fileName;
    // read env ASCEND_LATEST_INSTALL_PATH
    const char_t *env = nullptr;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_LATEST_INSTALL_PATH, env);
    if ((env == nullptr) || (*env == '\0')) {
        RT_LOG(RT_LOG_WARNING, "can not read ASCEND_LATEST_INSTALL_PATH! isHeterogenous=0.");
        return 0;
    } else {
        const std::string rtCfgFile("/runtime/conf/RuntimeConfig.ini");
        const std::string path(env);
        fileName = path + rtCfgFile;
    }

    const std::string key("IsHeterogenousMode=");
    int32_t valueHeterogenousMode = 0;
    const bool ret = GetConfigIniValueInt32(fileName, key, valueHeterogenousMode);
    const int32_t isHeterogenous = (ret && (valueHeterogenousMode == 1)) ? 1 : 0;
    RT_LOG(RT_LOG_INFO, "isHeterogenous=%d.", isHeterogenous);
    return isHeterogenous;
}

static std::once_flag heterogenousOnceFlag;
int32_t RtGetHeterogenous(void)
{
    static int32_t isHeterogenous = 0;
    std::call_once(heterogenousOnceFlag, [&]() {
        isHeterogenous = ReadHeterogenousModeFromConfigIni();
    });
    return isHeterogenous;
}

bool RtIsHeterogenous(void)
{
    constexpr int32_t isHeterogenous = 1;
    return (RtGetHeterogenous() == isHeterogenous);
}
}
}
