/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "raw_device.hpp"

#include <chrono>
#include "device.hpp"
#include "uma_arg_loader.hpp"
#include "runtime.hpp"
#include "ctrl_stream.hpp"
#include "tsch_stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "program.hpp"
#include "module.hpp"
#include "api.hpp"
#include "driver/ascend_hal.h"
#include "task.hpp"
#include "device/device_error_proc.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "aicpu_err_msg.hpp"
#include "dvpp_grp.hpp"
#include "task_info.hpp"
#include "task_submit.hpp"
#include "event.hpp"
#include "ctrl_res_pool.hpp"
#include "npu_driver_dcache_lock.hpp"
#include "stream_factory.hpp"
#include "arg_loader_ub.hpp"
#include "stub_task.hpp"
#include "dev_info_manage.h"
#include "soc_info.h"
#include "notify.hpp"
#include "capture_model.hpp"
#include "device_sq_cq_pool.hpp"
#include "sq_addr_memory_pool.hpp"
#include "printf.hpp"
#include "platform/platform_info.h"

namespace cce {
namespace runtime {
static const std::string GetSocVersion()
{
    if (halGetSocVersion != nullptr) {
        char_t socVersion[SOC_VERSION_LEN] = {0};
        uint32_t deviceCnt = 1U;
        drvError_t drvRet = drvGetDevNum(&deviceCnt);
        RT_LOG(RT_LOG_DEBUG, "[drv api] drvGetDevNum=%u ret=%#x", deviceCnt, drvRet);
        for (uint32_t i = 0U; i < deviceCnt; i++) {
            drvRet = halGetSocVersion(i, socVersion, SOC_VERSION_LEN);
            RT_LOG(RT_LOG_DEBUG, "[drv api] halGetSocVersion device_id=%u drv ret=%#x", i, drvRet);
            std::string socVer(socVersion);
            if ((drvRet == DRV_ERROR_NONE) && (!socVer.empty())) {
                return socVer;
            }
        }
    }

    const Runtime * const rtInstance = Runtime::Instance();
    const rtSocType_t socType = rtInstance->GetSocType();
    return GetSocVersionStrByType(socType);
}

static rtError_t GetDeviceResByFe(const uint32_t devId, int32_t moduleType, int64_t &value)
{
    const std::string socVersion = GetSocVersion();
    uint32_t platformRet = fe::PlatformInfoManager::GeInstance().InitRuntimePlatformInfos(socVersion);
    if (platformRet != 0U) {
        RT_LOG(RT_LOG_ERROR,
            "drv devId=%u, socVersion=%s, platformRet=%u", devId, socVersion.c_str(), platformRet);
        return RT_ERROR_INVALID_VALUE;
    }

    fe::PlatFormInfos platformInfos;
    platformRet = fe::PlatformInfoManager::GeInstance().GetRuntimePlatformInfosByDevice(devId, platformInfos);
    if (platformRet != 0U) {
        RT_LOG(RT_LOG_ERROR, "drv devId=%u, platformRet=%u", devId, platformRet);
        return RT_ERROR_INVALID_VALUE;
    }

    const std::string socInfoKey = "SoCInfo";
    std::map<std::string, std::string> res;
    if (!platformInfos.GetPlatformResWithLock(socInfoKey, res)) {
        RT_LOG(RT_LOG_ERROR, "get platform result failed");
        return RT_ERROR_INVALID_VALUE;
    }

    std::string strVal;
    switch (moduleType) {
        case MODULE_TYPE_AICORE:
            strVal = res["ai_core_cnt"];
            break;
        case MODULE_TYPE_VECTOR_CORE:
            strVal = res["vector_core_cnt"];
            break;
        default:
            return RT_ERROR_INVALID_VALUE;
    }

    try {
        value = std::stoll(strVal);
    } catch (...) {
        RT_LOG(RT_LOG_ERROR, "strVal[%s] can not be converted to digital value, moduleType=%d", strVal.c_str(), moduleType);
        return RT_ERROR_INVALID_VALUE;
    }

    return RT_ERROR_NONE;
}

void RawDevice::InitResource()
{
    int64_t totalCoreNum = 0;
    (void)GetDeviceResByFe(deviceId_, MODULE_TYPE_AICORE, totalCoreNum);
    InsertResInit(RT_DEV_RES_CUBE_CORE, static_cast<uint32_t>(totalCoreNum));
    InsertResLimit(RT_DEV_RES_CUBE_CORE, static_cast<uint32_t>(totalCoreNum));
    (void)GetDeviceResByFe(deviceId_, MODULE_TYPE_VECTOR_CORE, totalCoreNum);
    InsertResInit(RT_DEV_RES_VECTOR_CORE, static_cast<uint32_t>(totalCoreNum));
    InsertResLimit(RT_DEV_RES_VECTOR_CORE, static_cast<uint32_t>(totalCoreNum));
}

void RawDevice::InsertResInit(rtDevResLimitType_t type, uint32_t value)
{
    if (type < RT_DEV_RES_TYPE_MAX && type >= 0) {
        resInitArray_[type] = value;
    } else {
        RT_LOG(RT_LOG_WARNING, "illegal device resource type");
    }
}

uint32_t RawDevice::GetResInitValue(const rtDevResLimitType_t type) const
{
    if (type < RT_DEV_RES_TYPE_MAX && type >= 0) {
        return resInitArray_[type];
    }
    RT_LOG(RT_LOG_WARNING, "illegal device resource type");
    return 0;
}

void RawDevice::InsertResLimit(rtDevResLimitType_t type, uint32_t value)
{
    if (type < RT_DEV_RES_TYPE_MAX && type >= 0) {
        resLimitArray_[type] = value;
    } else {
        RT_LOG(RT_LOG_WARNING, "illegal device resource type");
    }
}

uint32_t RawDevice::GetResValue(const rtDevResLimitType_t type) const
{
    if (type < RT_DEV_RES_TYPE_MAX && type >= 0) {
        return resLimitArray_[type];
    }
    RT_LOG(RT_LOG_WARNING, "illegal device resource type");
    return 0U;
}

void RawDevice::ResetResLimit(void)
{
    for (size_t i = 0; i < RT_DEV_RES_TYPE_MAX; i++) {
        resLimitArray_[i] = resInitArray_[i];
    }
}
}  // namespace runtime
}
