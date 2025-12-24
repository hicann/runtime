/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_DEVICE_AI_DRV_DSMI_API_H
#define ANALYSIS_DVVP_DEVICE_AI_DRV_DSMI_API_H

#include <string>
#include "ascend_hal.h"
#include "message/prof_params.h"


namespace Analysis {
namespace Dvvp {
namespace Driver {
int32_t DrvGetAicoreInfo(int32_t deviceId, int64_t &freq);
std::string DrvGeAicFrq(int32_t deviceId);
std::string DrvGeAivFrq(int32_t deviceId);
}  // namespace driver
}  // namespace dvvp
}  // namespace analysis

#endif
