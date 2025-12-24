/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_DEVICE_AI_DRV_DEV_API_H
#define ANALYSIS_DVVP_DEVICE_AI_DRV_DEV_API_H

#include <vector>
#include <string>
#include "ascend_hal.h"
#include "message/prof_params.h"

#define MSPROF_HELPER_HOST DRV_ERROR_NOT_SUPPORT
namespace analysis {
namespace dvvp {
namespace driver {
constexpr char NOT_SUPPORT_FREQUENCY[] = "";
constexpr uint32_t FREQUENCY_KHZ_TO_MHZ = 1000; // KHz to MHz
int32_t DrvGetDevNum();
int32_t DrvGetDevIds(int32_t numDevices, std::vector<int32_t> &devIds);
int32_t DrvGetEnvType(uint32_t deviceId, int64_t &envType);
int32_t DrvGetCtrlCpuId(uint32_t deviceId, int64_t &ctrlCpuId);
int32_t DrvGetCtrlCpuCoreNum(uint32_t deviceId, int64_t &ctrlCpuCoreNum);
int32_t DrvGetCtrlCpuEndianLittle(uint32_t deviceId, int64_t &ctrlCpuEndianLittle);
int32_t DrvGetAiCpuCoreNum(uint32_t deviceId, int64_t &aiCpuCoreNum);
int32_t DrvGetAiCpuCoreId(uint32_t deviceId, int64_t &aiCpuCoreId);
int32_t DrvGetAiCpuOccupyBitmap(uint32_t deviceId, int64_t &aiCpuOccupyBitmap);
int32_t DrvGetTsCpuCoreNum(uint32_t deviceId, int64_t &tsCpuCoreNum);
int32_t DrvGetAiCoreId(uint32_t deviceId, int64_t &aiCoreId);
int32_t DrvGetAiCoreNum(uint32_t deviceId, int64_t &aiCoreNum);
int32_t DrvGetAivNum(uint32_t deviceId, int64_t &aivNum);
int32_t DrvGetPlatformInfo(uint32_t &platformInfo);
int32_t DrvGetDeviceTime(uint32_t deviceId, uint64_t &startMono, uint64_t &cntvct);
std::string DrvGetDevIdsStr();
bool DrvCheckIfHelperHost();
bool DrvGetHostFreq(std::string &freq);
bool DrvGetDeviceFreq(uint32_t deviceId, std::string &freq);
bool DrvGetDeviceStatus(const uint32_t deviceId);
}  // namespace driver
}  // namespace dvvp
}  // namespace analysis

#endif
