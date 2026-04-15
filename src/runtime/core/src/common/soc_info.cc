/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "soc_info.h"
#include "dev_info_manage.h"
#include "platform/platform_info.h"
#include "platform_manager_v2.h"
namespace cce {
namespace runtime {
rtError_t GetSocInfoFromRuntimeByName(const char_t * const socName, rtSocInfo_t &info)
{
    return DevInfoManage::Instance().GetSocInfo(socName, info);
}

rtError_t GetNpuArchByName(const char_t* const socName, int32_t* hardwareNpuArch)
{
    std::string result = "";
    const std::string label = "version";
    const std::string key = "NpuArch";
    const int32_t ret = PlatformManagerV2::Instance().GetSocSpec(std::string(socName), label,
        key, result);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Get soc spec failed, ret = %u, please check.", ret);
        return RT_ERROR_INVALID_VALUE;
    }
    try {
        *hardwareNpuArch = std::stoi(result);
    } catch (...) {
        *hardwareNpuArch = MAX_INT32_NUM;
        RT_LOG(RT_LOG_ERROR, "NpuArch [%s] is inValid.", result.c_str());
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

}
}