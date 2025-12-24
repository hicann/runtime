/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "cloud_device_simulator.h"

namespace Cann {
namespace Dvvp {
namespace Test {
int32_t CloudDeviceSimulator::ProfDrvGetChannels(ChannelList &channels)
{
    const std::vector<int> blackList = {2, 5};
    std::string channelStr = "";
    std::string pattern = ",";

    for (int i = 1; i < 11; i++) {
        if (std::find(blackList.begin(), blackList.end(), i) != blackList.end()) {
            continue;
        }
        channelStr += std::to_string(i);
        channelStr += pattern;
    }

    for (int j = 43; j < 48; j++) {
        channelStr += std::to_string(j);
        channelStr += pattern;
    }

    for (int j = 129; j < 143; j++) {
        channelStr += std::to_string(j);
        channelStr += pattern;
    }

    if (isAicpuChannelRegister_) {
        channelStr += "143";
        channelStr += pattern;
    }
    if (isCustomCpuChannelRegister_) {
        channelStr += "144";
        channelStr += pattern;
    }
    if (isAdprofChannelRegister_) {
        channelStr += "145";
        channelStr += pattern;
    }

    std::string::size_type pos;
    std::vector<std::string> res;
    std::string str = channelStr;
    std::string::size_type size = str.size();
    int ic = 0;

    for (std::string::size_type i = 0; i < size; i++) {
        pos = str.find(pattern, i);
        if (pos < size) {
            std::string ss = str.substr(i, pos - i);
            res.push_back(ss);
            channels.channel[ic].channel_id = std::stoi(ss);
            channels.channel[ic].channel_type = 1;
            i = pos;
            ic++;
        }
    }

    channels.channel_num = res.size();
    channels.chip_type = 1;
    return 0;
}

int32_t CloudDeviceSimulator::GetDeviceInfo(int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (moduleType == MODULE_TYPE_SYSTEM &&
        infoType == INFO_TYPE_VERSION) {
        *value = (int64_t)StPlatformType::CLOUD_TYPE << 8;
    }

    if (moduleType == MODULE_TYPE_AICORE &&
        infoType == INFO_TYPE_CORE_NUM) {
        *value = 8;
    }

    if (moduleType == MODULE_TYPE_VECTOR_CORE &&
        infoType == INFO_TYPE_CORE_NUM) {
        *value = 8;
    }

    return 0;
}

}
}
}
