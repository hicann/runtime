/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dc_device_simulator.h"

#include <fstream>

using namespace std;
namespace Cann {
namespace Dvvp {
namespace Test {

int32_t DcDeviceSimulator::ProfDrvGetChannels(ChannelList &channels)
{
    int32_t channles_ids[] = {3,7,8,10,43,44,45,46,47,130,131,134,135,136,137,138,139, 142};
    channels.channel_num = sizeof(channles_ids) / sizeof(int32_t);
    int32_t i = 0;
    for (i = 0; i < channels.channel_num; i++) {
        channels.channel[i].channel_id = channles_ids[i];
    }
    if (isAicpuChannelRegister_) {
        channels.channel[i].channel_id = 143;
        i++;
        channels.channel_num++;
    }
    if (isCustomCpuChannelRegister_) {
        channels.channel[i].channel_id = 144;
        i++;
        channels.channel_num++;
    }
    if (isAdprofChannelRegister_) {
        channels.channel[i].channel_id = 145;
        i++;
        channels.channel_num++;
    }
    return 0;
}

int32_t DcDeviceSimulator::GetDeviceInfo(int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (moduleType == MODULE_TYPE_SYSTEM &&
        infoType == INFO_TYPE_VERSION) {
        *value = (int64_t)StPlatformType::DC_TYPE << 8;
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
