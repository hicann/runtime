/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CANN_DVVP_TEST_RC_V2_DEVICE_SIMULATOR_H
#define CANN_DVVP_TEST_RC_V2_DEVICE_SIMULATOR_H

#include "rc_lite_v2_device_simulator.h"

namespace Cann {
namespace Dvvp {
namespace Test {
// rc_v2(chip 17)形态设备模拟器：通道与数据上报沿用rc lite v2形态，仅版本上报与核数按rc_v2改写
class RcV2DeviceSimulator : public RcLiteV2DeviceSimulator {
public:
    RcV2DeviceSimulator() {}
    explicit RcV2DeviceSimulator(uint32_t platformType) : RcLiteV2DeviceSimulator(platformType) {}
    ~RcV2DeviceSimulator() override {}
    int32_t GetDeviceInfo(int32_t moduleType, int32_t infoType, int64_t* value) override;
};
} // namespace Test
} // namespace Dvvp
} // namespace Cann
#endif
