/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CANN_DVVP_TEST_MDC_LITE_DEVICE_SIMULATOR_H
#define CANN_DVVP_TEST_MDC_LITE_DEVICE_SIMULATOR_H
#include <algorithm>
#include <cstdint>
#include <cstdio>
#include <string>
#include <cstring>
#include <vector>
#include <map>
#include "device_drv_prof_stub.h"
#include "device_simulator.h"
#include "data_manager.h"

namespace Cann {
namespace Dvvp {
namespace Test {
class MdcLiteDeviceSimulator : public DeviceSimulator {
public:
    MdcLiteDeviceSimulator() {}
    explicit MdcLiteDeviceSimulator(uint32_t platformType) :
        platformType_(platformType) {}
    virtual ~MdcLiteDeviceSimulator() {}
    virtual int32_t ProfDrvGetChannels(ChannelList &channels) override;
    virtual int32_t GetDeviceInfo(int32_t moduleType, int32_t infoType, int64_t *value) override;
private:
    uint32_t platformType_;
};
}
}
}

#endif
