/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver.hpp"
#include "npu_driver.hpp"
#include "errcode_manage.hpp"

namespace cce {
namespace runtime {
static DriverGetInsFunc_t g_getInsFuncs[MAX_DRIVER_NUM];
DriverFactory::DriverFactory()
{
    for (int32_t i = 0; i < static_cast<int32_t>(MAX_DRIVER_NUM); i++) {
        drivers_[i] = nullptr;
    }
}
DriverFactory::~DriverFactory()
{
    for (int32_t i = 0; i < static_cast<int32_t>(MAX_DRIVER_NUM); i++) {
        if (drivers_[i] != nullptr) {
            delete drivers_[i].load();
            drivers_[i] = nullptr;
        }
    }
}
Driver *DriverFactory::GetDriver(const driverType_t type)
{
    if (drivers_[type] == nullptr) {
        const std::unique_lock<std::mutex> mutexLock(m);
        if (drivers_[type] == nullptr) {
            drivers_[type] = g_getInsFuncs[type]();
        }
    }
    return drivers_[type];
}
bool DriverFactory::RegDriver(const driverType_t type, const DriverGetInsFunc_t func)
{
    if (func == nullptr) {
        return false;
    }
    g_getInsFuncs[type] = func;
    return true;
}

Driver::Driver() : NoCopy(), callBack_(nullptr)
{
}

Driver::~Driver()
{
    callBack_ = nullptr;
}


rtError_t FacadeDriver::GetDeviceCount(int32_t * const deviceCount) const
{
    rtError_t error = RT_ERROR_NONE;
    TIMESTAMP_NAME(__func__);
    uint32_t devCnt = 0U;
    const drvError_t drvRet = drvGetDevNum(&devCnt);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Call drvGetDevNum, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        error = RT_GET_DRV_ERRCODE(drvRet);
    }
    *deviceCount = static_cast<int32_t>(devCnt);
    return error;
}

rtError_t FacadeDriver::GetDeviceIDs(uint32_t * const devices, const uint32_t len) const
{
    rtError_t error = RT_ERROR_NONE;

    TIMESTAMP_NAME(__func__);
    const drvError_t drvRet = drvGetDevIDs(devices, len);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Call drvGetDevIDs, drvRetCode=%d, length=%u.", drvRet, len);
        error = RT_GET_DRV_ERRCODE(drvRet);
    }
    return error;
}
}
}
