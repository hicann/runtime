/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_c.h"
#include "api.hpp"
#include "base.hpp"
#include "error_message_manage.hpp"
#include "errcode_manage.hpp"
#include "error_code.h"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "heterogenous.h"
#include "soc_info.h"
#include "dev_info_manage.h"

using namespace cce::runtime;

namespace {
const std::string GetSocVersionStr(const int32_t isHeterogenous)
{
    if ((isHeterogenous == 0) && (halGetSocVersion != nullptr)) {
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
    const rtSocType_t socType = (isHeterogenous == 1) ? GlobalContainer::GetSocType() : rtInstance->GetSocType();
    return GetSocVersionStrByType(socType);
}
}

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtGetSocVersion(char_t *ver, const uint32_t maxLen)
{
    errno_t rc;
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(ver, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR_WITH_EXT_ERRCODE(maxLen == 0U, RT_ERROR_INVALID_VALUE, "max length can not be 0!");

    const int32_t isHetero = RtGetHeterogenous();
    // if helper condition, recheck ge option
    const std::string socName = GetSocVersionStr(isHetero);
    if (socName.empty()) {
        rc = memcpy_s(ver, static_cast<size_t>(maxLen), "UnknowSocType", sizeof("UnknowSocType"));
        COND_RETURN_ERROR_WITH_EXT_ERRCODE(rc != EOK, RT_ERROR_SEC_HANDLE,
            "Call memcpy_s for soc type failed, max size is %u, copy size is %zu.", maxLen, sizeof("UnknowSocType"));
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INSTANCE_VERSION);
    }

    RT_LOG(RT_LOG_DEBUG, "soc version: %s", socName.c_str());
    rc = memcpy_s(ver, static_cast<size_t>(maxLen), socName.c_str(), socName.length() + 1U);
    COND_RETURN_ERROR_WITH_EXT_ERRCODE(rc != EOK, RT_ERROR_SEC_HANDLE,
        "Call memcpy_s for soc name failed, max size is %u, copy size is %zu.", maxLen, socName.length() + 1U);
    RT_LOG(RT_LOG_INFO, "soc version is %s", ver);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetSocVersion(const char_t *ver)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(ver, RT_ERROR_INVALID_VALUE);
    rtSocInfo_t socInfo = {SOC_END, CHIP_END, ARCH_END, nullptr};
    const rtError_t ret = GetSocInfoByName(ver, socInfo);
    if (ret != RT_ERROR_NONE) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "Soc version [%s] is invalid", ver);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }
    if (GlobalContainer::GetHardwareChipType() != CHIP_END &&
        GlobalContainer::GetHardwareChipType() != socInfo.chipType) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "Device has been set to real chip type=%d, different chip type=%d "
            "cannot be set, the current input soc version(%s) does not match the NPU type.",
            GlobalContainer::GetHardwareChipType(), socInfo.chipType, ver);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }
    GlobalContainer::SetRtChipType(socInfo.chipType);
    GlobalContainer::SetSocType(socInfo.socType);
    GlobalContainer::SetArchType(socInfo.archType);
    const std::string inputSocVersion = std::string(ver);
    GlobalContainer::SetUserSocVersion(inputSocVersion);
    const auto rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    rtInstance->SetIsUserSetSocVersion(true);
    rtInstance->MacroInit(socInfo.chipType);
    RT_LOG(RT_LOG_EVENT, "soc version is %s, type=%d, soc type=%d", ver, socInfo.chipType, socInfo.socType);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus
