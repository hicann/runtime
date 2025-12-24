/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mdc_mini_v3_device_simulator.h"


namespace Cann {
namespace Dvvp {
namespace Test {
int32_t MdcMiniV3DeviceSimulator::ProfDrvGetChannels(ChannelList &channels)
{
    int32_t channles_ids[] = {6, 7, 8, 10, 44, 47, 50, 52, 53, 54, 130, 131, 135, 137, 142};
    channels.channel_num = sizeof(channles_ids) / sizeof(int32_t);
    for (int32_t i = 0; i < channels.channel_num; i++) {
        channels.channel[i].channel_id = channles_ids[i];
    }
    return 0;
}

int32_t MdcMiniV3DeviceSimulator::GetDeviceInfo(int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (moduleType == MODULE_TYPE_SYSTEM &&
        infoType == INFO_TYPE_VERSION) {
        *value = (int64_t)platformType_ << 8;
    }

    if (moduleType == MODULE_TYPE_AICORE &&
        infoType == INFO_TYPE_CORE_NUM) {
        *value = 1;
    }

    if (moduleType == MODULE_TYPE_VECTOR_CORE &&
        infoType == INFO_TYPE_CORE_NUM) {
        *value = 1;
    }

    return 0;
}

}
}
}
