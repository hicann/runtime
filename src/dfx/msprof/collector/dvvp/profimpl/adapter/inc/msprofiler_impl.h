/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_PROFILER_MSPROF_CALLBACK_IMPL_H
#define ANALYSIS_DVVP_PROFILER_MSPROF_CALLBACK_IMPL_H

#include "acl/acl_base.h"
#include "data_dumper.h"
#include "utils/utils.h"

namespace Analysis {
namespace Dvvp {
namespace ProfilerCommon {
using namespace analysis::dvvp::common::utils;

int32_t ProfInit(uint32_t type, VOID_PTR data, uint32_t len);
int32_t ProfConfigStart(uint32_t dataType, const void *data, uint32_t length);
int32_t ProfConfigStop(uint32_t dataType, const void *data, uint32_t length);
int32_t ProfSetConfig(uint32_t configType, const char *config, size_t configLength);
int32_t ProfNotifySetDeviceForDynProf(uint32_t chipId, uint32_t devId, bool isOpenDevice);
int32_t ProfNotifySetDevice(uint32_t chipId, uint32_t devId, bool isOpenDevice);
int32_t ProfReportData(uint32_t moduleId, uint32_t type, VOID_PTR data, uint32_t len);
int32_t GetRegisterResult();
int32_t ProfFinalize();
int32_t ProfSetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId);
int32_t ProfUnsetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId);
int32_t ProfGetDeviceIdByGeModelIdx(const uint32_t geModelIdx, uint32_t* deviceId);
void InstanceFinalizeGuard();
void ProfGetImplInfo(ProfImplInfo& info);
bool CheckMsprofBin(std::string &envValue);
int32_t ProfInitProc(uint32_t type);
int32_t ProfInitIfCommandLine();
int32_t ProfAdprofInit(VOID_PTR data, uint32_t len);
int32_t ProfAdprofRegisterCallback(uint32_t moduleId, ProfCommandHandle callback);
int32_t ProfAdprofGetFeatureIsOn(uint64_t feature);
int32_t MsptiSubscribeRawData(MsprofRawDataCallback callback);
int32_t MsptiUnSubscribeRawData();

class FinalizeGuard {
public:
    FinalizeGuard() {}
    ~FinalizeGuard();
};
}  // namespace ProfilerCommon
}  // namespace Dvvp
}  // namespace Analysis

#endif
