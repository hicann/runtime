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
#include "context.hpp"

using namespace cce::runtime;

namespace {
static const std::string UNKNOWN_SOC_TYPE("UnknowSocType");

std::string GetSocVersionByDeviceId(const uint32_t devId)
{
    char_t socVersion[SOC_VERSION_LEN] = {0};
    const drvError_t drvRet = halGetSocVersion(devId, socVersion, SOC_VERSION_LEN);
    const std::string socVer(socVersion, strnlen(socVersion, SOC_VERSION_LEN));
    RT_LOG(RT_LOG_DEBUG, "[drv api]halGetSocVersion deviceId=%u, drv ret=%#x", devId, drvRet);
    if ((drvRet == DRV_ERROR_NONE) && (!socVer.empty())) {
        return socVer;
    }

    return "";
}

const std::string GetSocVersionStr(const int32_t isHeterogenous)
{
    if (isHeterogenous == 1) {
        return GlobalContainer::GetSocVersion();
    }

    const Runtime* const rtInstance = Runtime::Instance();
    if (rtInstance->GetIsUserSetSocVersion()) {
        return GlobalContainer::GetUserSocVersion();
    }

    if (halGetSocVersion != nullptr) {
        const Context* const curCtx = rtInstance->CurrentContext();
        if (curCtx != nullptr) {
            const Device* const device = curCtx->Device_();
            if (device != nullptr) {
                const std::string socVersion = GetSocVersionByDeviceId(device->Id_());
                if (!socVersion.empty()) {
                    return socVersion;
                }
                RT_LOG(RT_LOG_WARNING, "The soc version obtained by deviceId=%u is empty", device->Id_());
            }
        }

        uint32_t deviceCnt = 1U;
        const drvError_t drvRet = drvGetDevNum(&deviceCnt);
        RT_LOG(RT_LOG_DEBUG, "[drv api] drvGetDevNum=%u ret=%#x", deviceCnt, drvRet);
        for (uint32_t i = 0U; i < deviceCnt; i++) {
            const std::string socVersion = GetSocVersionByDeviceId(i);
            if (!socVersion.empty()) {
                return socVersion;
            }
        }
        RT_LOG(RT_LOG_WARNING, "The soc version obtained by traverse device is empty");
    }

    return rtInstance->GetSocVersion();
}
} // namespace

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtGetSocVersion(char_t* ver, const uint32_t maxLen)
{
    errno_t rc;
    const Runtime* const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(ver, RT_ERROR_INVALID_VALUE);
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM(maxLen == 0U, RT_ERROR_INVALID_VALUE, maxLen, "not equal to 0");

    const int32_t isHetero = RtGetHeterogenous();
    // if helper condition, recheck ge option
    std::string socName = GetSocVersionStr(isHetero);
    if (socName.empty()) {
        rc = memcpy_s(ver, static_cast<size_t>(maxLen), UNKNOWN_SOC_TYPE.c_str(), UNKNOWN_SOC_TYPE.length() + 1U);
        if (rc != EOK) {
            std::stringstream ss;
            ss << std::hex << "ver=0x" << RtPtrToValue(ver) << ", src=0x" << RtPtrToValue(UNKNOWN_SOC_TYPE.c_str())
               << std::dec << ", maxLen=" << maxLen << ", count=" << UNKNOWN_SOC_TYPE.length() + 1U << ".";
            RT_LOG_OUTER_MSG_IMPL(
                ErrorCode::EE1020, __func__, "memcpy_s", std::to_string(rc).c_str(), strerror(rc), ss.str().c_str());
            return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_SEC_HANDLE);
        }
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INSTANCE_VERSION);
    }

    RT_LOG(RT_LOG_DEBUG, "soc version: %s", socName.c_str());
    rc = memcpy_s(ver, static_cast<size_t>(maxLen), socName.c_str(), socName.length() + 1U);
    if (rc != EOK) {
        std::stringstream ss;
        ss << std::hex << "ver=0x" << RtPtrToValue(ver) << ", src=0x" << RtPtrToValue(socName.c_str()) << std::dec
           << ", maxLen=" << maxLen << ", count=" << (socName.length() + 1U) << ".";
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1020, __func__, "memcpy_s", std::to_string(rc).c_str(), strerror(rc), ss.str().c_str());
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_SEC_HANDLE);
    }
    RT_LOG(RT_LOG_INFO, "soc version is %s", ver);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetSocVersion(const char_t* ver)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(ver, RT_ERROR_INVALID_VALUE);
    const std::string inputSocVersion(ver);
    rtChipType_t chipType = CHIP_END;
    const rtError_t ret = GetChipTypeFromPlatform(ver, chipType);
    if (ret != RT_ERROR_NONE) {
        RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1011, inputSocVersion, "ver", "The input SoC version is not supported");
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }
    if (!GlobalContainer::GetHardwareSocVersion().empty() &&
        (GlobalContainer::GetHardwareSocVersion() != inputSocVersion)) {
        RT_LOG_OUTER_MSG_WITH_FUNC(
            ErrorCode::EE1011, inputSocVersion, "ver",
            "The input SoC version does not match the actual SoC version " + GlobalContainer::GetHardwareSocVersion());
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_INVALID_VALUE);
    }
    GlobalContainer::SetRtChipType(chipType);
    GlobalContainer::SetUserSocVersion(inputSocVersion);
    GlobalContainer::SetSocVersion(inputSocVersion);
    const auto rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);
    rtInstance->SetIsUserSetSocVersion(true);
    rtInstance->UpdateDevProperties(chipType, inputSocVersion);
    RT_LOG(RT_LOG_INFO, "soc version is %s, type=%d", inputSocVersion.c_str(), chipType);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus
