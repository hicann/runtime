/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl_rt_config.hpp"
#include <map>
#include <new>
#include <string>
#include "api_impl_creator.hpp"
#include "context.hpp"
#include "context_manage.hpp"
#include "device.hpp"
#include "driver.hpp"
#include "enum_desc.hpp"
#include "error_message_manage.hpp"
#include "inner_thread_local.hpp"
#include "platform/platform_info.h"
#include "runtime.hpp"
#include "stream.hpp"

namespace cce {
namespace runtime {

bool IsImplRtConfigSupported() { return true; }

ApiRtConfig* CreateImplRtConfigAndGet()
{
    ApiRtConfig* const apiImplRtConfig = new (std::nothrow) ApiImplRtConfig();
    if (apiImplRtConfig == nullptr) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, sizeof(ApiImplRtConfig), "new");
        RT_LOG(RT_LOG_ERROR, "create ApiImplRtConfig failed.");
        return nullptr;
    }
    RT_LOG(RT_LOG_INFO, "ApiImplRtConfig:Runtime_alloc_size %zu", sizeof(ApiImplRtConfig));
    return apiImplRtConfig;
}

void DestroyImplRtConfig(ApiRtConfig*& apiImplRtConfig)
{
    delete apiImplRtConfig;
    apiImplRtConfig = nullptr;
}

static rtError_t UpdatePlatformRes(
    fe::PlatFormInfos& platformInfos, const rtDevResLimitType_t type, const uint32_t value)
{
    const std::string socInfoKey = "SoCInfo";
    std::map<std::string, std::string> res;
    if (!platformInfos.GetPlatformResWithLock(socInfoKey, res)) {
        RT_LOG(RT_LOG_ERROR, "get platform result failed");
        return RT_ERROR_INVALID_VALUE;
    }

    switch (type) {
        case RT_DEV_RES_CUBE_CORE:
            res["ai_core_cnt"] = std::to_string(value);
            res["cube_core_cnt"] = std::to_string(value);
            break;
        case RT_DEV_RES_VECTOR_CORE:
            res["vector_core_cnt"] = std::to_string(value);
            break;
        default:
            RT_LOG(RT_LOG_ERROR, "Unsupported resource type: %s", DevResLimitTypeToString(type));
            return RT_ERROR_INVALID_VALUE;
    }

    platformInfos.SetPlatformResWithLock(socInfoKey, res);
    return RT_ERROR_NONE;
}

static rtError_t SetDeviceResLimitByFe(const uint32_t devId, const rtDevResLimitType_t type, const uint32_t value)
{
    Runtime* const rt = Runtime::Instance();
    const std::string socVersion = rt->GetSocVersion();
    uint32_t platformRet = fe::PlatformInfoManager::GeInstance().InitRuntimePlatformInfos(socVersion);
    if (platformRet != 0U) {
        RT_LOG(
            RT_LOG_ERROR, "InitRuntime PlatformInfos failed, drv devId=%u, socVersion=%s, platformRet=%u", devId,
            socVersion.c_str(), platformRet);
        return RT_ERROR_INVALID_VALUE;
    }

    fe::PlatFormInfos platformInfos;
    platformRet = fe::PlatformInfoManager::GeInstance().GetRuntimePlatformInfosByDevice(devId, platformInfos);
    if (platformRet != 0U) {
        RT_LOG(
            RT_LOG_ERROR, "get runtime platformInfos by device failed, drv devId=%u, platformRet=%u", devId,
            platformRet);
        return RT_ERROR_INVALID_VALUE;
    }

    const auto error = UpdatePlatformRes(platformInfos, type, value);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "update platform res failed, drv devId=%u", devId);
        return error;
    }

    platformRet = fe::PlatformInfoManager::GeInstance().UpdateRuntimePlatformInfosByDevice(devId, platformInfos);
    if (platformRet != 0U) {
        RT_LOG(RT_LOG_ERROR, "update platformInfos failed, drv devId=%u, platformRet=%u", devId, platformRet);
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

static rtError_t SetStreamResLimitByType(Stream* const stm, const rtDevResLimitType_t type, const uint32_t value)
{
    const Device* dev = stm->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    const uint32_t initValue = dev->GetResInitValue(type);
    COND_PROC_RETURN_AND_MSG_OUTER(
        value > initValue, RT_ERROR_INVALID_VALUE, ErrorCode::EE1003,
        RT_LOG(
            RT_LOG_ERROR,
            "The value exceeds the total number of cores."
            " drv devId=%u, type=%s, value=%u, total number of cores=%u.",
            dev->Id_(), DevResLimitTypeToString(type), value, initValue),
        "Setting the device resource limits of a specific stream", value, "value",
        RtFmtMsg("must be less than or equal to %u", initValue));

    // There is no restriction that it must be less than the SetDeviceResLimit setting
    stm->InsertResLimit(type, value);
    RT_LOG(
        RT_LOG_INFO, "drv devId=%u, stream_id=%d, type=%s, value=%u.", dev->Id_(), stm->Id_(),
        DevResLimitTypeToString(type), value);
    return RT_ERROR_NONE;
}

static rtError_t GetStreamResLimitByType(const Stream* const stm, const rtDevResLimitType_t type, uint32_t* const value)
{
    const bool resLimitFlag = stm->GetResLimitFlag(type);
    if (resLimitFlag) {
        *value = stm->GetResValue(type);
    } else {
        const Device* dev = stm->Device_();
        NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
        *value = dev->GetResValue(type);
    }
    RT_LOG(
        RT_LOG_INFO, "stream_id=%d, resLimitFlag=%d, type=%s, value=%u.", stm->Id_(), resLimitFlag,
        DevResLimitTypeToString(type), *value);
    return RT_ERROR_NONE;
}

rtError_t ApiImplRtConfig::CtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal)
{
    constexpr int64_t SYS_OPT_DETERMINISTIC_LEVEL_MAX = 4;
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        ((configOpt >= SYS_OPT_RESERVED) || (configOpt == SYS_OPT_ENABLE_KERNEL_EARLY_START) || (configOpt < 0)),
        RT_ERROR_INVALID_VALUE, "Setting system parameter values in the current context",
        SysParamOptToString(configOpt), "configOpt",
        RtFmtMsg("[0, %d)", static_cast<int32_t>(SYS_OPT_ENABLE_KERNEL_EARLY_START)));
    const int64_t maxVal =
        (configOpt == SYS_OPT_DETERMINISTIC) ? SYS_OPT_DETERMINISTIC_LEVEL_MAX : static_cast<int64_t>(SYS_OPT_MAX);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        (configVal >= maxVal) || (configVal < 0), RT_ERROR_INVALID_VALUE,
        "Setting system parameter values in the current context", configVal, RtFmtMsg("[0, %" PRId64 ")", maxVal));

    Runtime::Instance()->CallApiBegin(RT_PROF_API_CtxSetSysParamOpt);

    rtError_t error = RT_ERROR_NONE;
    do {
        RT_LOG(RT_LOG_DEBUG, "Start to set sys param opt, opt=%s.", SysParamOptToString(configOpt).c_str());
        Context* const curCtx = Runtime::Instance()->CurrentContext();
        if (unlikely(!ContextManage::CheckContextIsValid(curCtx))) {
            ContextManage::ReportContextValidationError();
            error = RT_ERROR_CONTEXT_NULL;
            break;
        }
        RT_LOG(
            RT_LOG_INFO, "curCtx = %p, configOpt=%s, configVal=%lld.", curCtx, SysParamOptToString(configOpt).c_str(),
            configVal);
        error = curCtx->CtxSetSysParamOpt(configOpt, configVal);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "Set sys param opt failed, retCode=%#x.", error);
        }
    } while (false);

    Runtime::Instance()->CallApiEnd(error);
    return error;
}

rtError_t ApiImplRtConfig::CtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t* const configVal)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        (configOpt >= SYS_OPT_RESERVED) || (configOpt == SYS_OPT_ENABLE_KERNEL_EARLY_START) || (configOpt < 0),
        RT_ERROR_INVALID_VALUE, "Obtaining the system parameter value in the current context",
        SysParamOptToString(configOpt), "configOpt", "[0, " + std::to_string(SYS_OPT_ENABLE_KERNEL_EARLY_START) + ")");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        configVal, RT_ERROR_INVALID_VALUE, "Obtaining the system parameter value in the current context");

    Runtime::Instance()->CallApiBegin(RT_PROF_API_CtxGetSysParamOpt);

    rtError_t error = RT_ERROR_NONE;
    do {
        Context* const curCtx = Runtime::Instance()->CurrentContext();
        if (unlikely(!ContextManage::CheckContextIsValid(curCtx))) {
            ContextManage::ReportContextValidationError();
            error = RT_ERROR_CONTEXT_NULL;
            break;
        }
        error = curCtx->CtxGetSysParamOpt(configOpt, configVal);
        RT_LOG(
            RT_LOG_INFO, "ret=%#x, curCtx = %p, configOpt=%s, *configVal=%lld.", error, curCtx,
            SysParamOptToString(configOpt).c_str(), *configVal);
    } while (false);

    Runtime::Instance()->CallApiEnd(error);
    return error;
}

rtError_t ApiImplRtConfig::SetDeviceResLimit(const uint32_t devId, const rtDevResLimitType_t type, const uint32_t value)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        static_cast<uint32_t>(type) >= RT_DEV_RES_TYPE_MAX, RT_ERROR_INVALID_VALUE, "Setting the device resource limit",
        DevResLimitTypeToString(type), "type", "[0, 2)");
    uint32_t drvDevId = 0U;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devId, &drvDevId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert the user device ID %u to driver device ID.", devId);
    error = Runtime::Instance()->CheckDeviceIdIsValid(static_cast<int32_t>(drvDevId));
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "drv devId is invalid, drv devId=%u, retCode=%#x", drvDevId,
        static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_INFO, "drv devId=%u, type=%s, value=%u.", drvDevId, DevResLimitTypeToString(type), value);
    Device* const dev = Runtime::Instance()->GetDevice(drvDevId, static_cast<uint32_t>(RT_TSC_ID));
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    const uint32_t initValue = dev->GetResInitValue(type);
    COND_PROC_RETURN_AND_MSG_OUTER(
        value > initValue, RT_ERROR_INVALID_VALUE, ErrorCode::EE1003,
        RT_LOG(
            RT_LOG_ERROR,
            "The value exceeds the total number of cores."
            " drv devId=%u, type=%s, value=%u, total number of cores=%u.",
            drvDevId, DevResLimitTypeToString(type), value, initValue),
        "Setting the device resource limit", value, "value", RtFmtMsg("must be less than or equal to %u", initValue));

    error = SetDeviceResLimitByFe(drvDevId, type, value);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    dev->InsertResLimit(type, value);
    return RT_ERROR_NONE;
}

rtError_t ApiImplRtConfig::ResetDeviceResLimit(const uint32_t devId)
{
    uint32_t drvDevId = 0U;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devId, &drvDevId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert the user device ID %u to driver device ID.", devId);
    error = Runtime::Instance()->CheckDeviceIdIsValid(static_cast<int32_t>(drvDevId));
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "drv devId is invalid, drv devId=%u, retCode=%#x", drvDevId,
        static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_INFO, "drv devId=%u.", drvDevId);
    Device* const dev = Runtime::Instance()->GetDevice(drvDevId, static_cast<uint32_t>(RT_TSC_ID));
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    dev->ResetResLimit();

    error = SetDeviceResLimitByFe(drvDevId, RT_DEV_RES_CUBE_CORE, dev->GetResValue(RT_DEV_RES_CUBE_CORE));
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    error = SetDeviceResLimitByFe(drvDevId, RT_DEV_RES_VECTOR_CORE, dev->GetResValue(RT_DEV_RES_VECTOR_CORE));
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    return RT_ERROR_NONE;
}

rtError_t ApiImplRtConfig::GetDeviceResLimit(
    const uint32_t devId, const rtDevResLimitType_t type, uint32_t* const value)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        static_cast<uint32_t>(type) >= RT_DEV_RES_TYPE_MAX, RT_ERROR_INVALID_VALUE,
        "Obtaining the device resource limits of the current process", DevResLimitTypeToString(type), "type", "[0, 2)");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        value, RT_ERROR_INVALID_VALUE, "Obtaining the device resource limits of the current process");
    uint32_t drvDevId = 0U;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(devId, &drvDevId);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Failed to convert the user device ID %u to driver device ID.", devId);
    error = Runtime::Instance()->CheckDeviceIdIsValid(static_cast<int32_t>(drvDevId));
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "drv devId is invalid, drv devId=%u, retCode=%#x", drvDevId,
        static_cast<uint32_t>(error));

    Device* const dev = Runtime::Instance()->GetDevice(drvDevId, static_cast<uint32_t>(RT_TSC_ID));
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    *value = dev->GetResValue(type);
    RT_LOG(RT_LOG_INFO, "type=%s, value=%u.", DevResLimitTypeToString(type), *value);
    return RT_ERROR_NONE;
}

rtError_t ApiImplRtConfig::SetStreamResLimit(Stream* const stm, const rtDevResLimitType_t type, const uint32_t value)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        static_cast<uint32_t>(type) >= RT_DEV_RES_TYPE_MAX, RT_ERROR_INVALID_VALUE,
        "Setting the device resource limit for the specified stream", DevResLimitTypeToString(type), "type", "[0, 2)");

    rtError_t ret = RT_ERROR_NONE;
    if (stm == nullptr) {
        Context* const curCtx = Runtime::Instance()->CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        Stream* const defaultStream = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(defaultStream, RT_ERROR_STREAM_NULL);
        ret = SetStreamResLimitByType(defaultStream, type, value);
    } else {
        ret = SetStreamResLimitByType(stm, type, value);
    }
    return ret;
}

rtError_t ApiImplRtConfig::ResetStreamResLimit(Stream* const stm)
{
    if (stm == nullptr) {
        Context* const curCtx = Runtime::Instance()->CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        Stream* const defaultStream = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(defaultStream, RT_ERROR_STREAM_NULL);
        defaultStream->ResetResLimit();
        RT_LOG(RT_LOG_INFO, "default stream_id=%d.", defaultStream->Id_());
    } else {
        stm->ResetResLimit();
        RT_LOG(RT_LOG_INFO, "stream_id=%d.", stm->Id_());
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImplRtConfig::GetStreamResLimit(
    const Stream* const stm, const rtDevResLimitType_t type, uint32_t* const value)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        static_cast<uint32_t>(type) >= RT_DEV_RES_TYPE_MAX, RT_ERROR_INVALID_VALUE,
        "Obtaining the device resource limits of a specified stream", DevResLimitTypeToString(type), "type", "[0, 2)");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        value, RT_ERROR_INVALID_VALUE, "Obtaining the device resource limits of a specified stream");

    rtError_t ret = RT_ERROR_NONE;
    if (stm == nullptr) {
        Context* const curCtx = Runtime::Instance()->CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        Stream* const defaultStream = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(defaultStream, RT_ERROR_STREAM_NULL);
        ret = GetStreamResLimitByType(defaultStream, type, value);
    } else {
        ret = GetStreamResLimitByType(stm, type, value);
    }
    return ret;
}

rtError_t ApiImplRtConfig::UseStreamResInCurrentThread(const Stream* const stm)
{
    const Stream* curStm = stm;
    if (curStm == nullptr) {
        Context* const curCtx = Runtime::Instance()->CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    InnerThreadLocalContainer::SetCurrentResLimitStream(curStm);
    return RT_ERROR_NONE;
}

rtError_t ApiImplRtConfig::NotUseStreamResInCurrentThread(const Stream* const stm)
{
    const Stream* curStm = stm;
    if (curStm == nullptr) {
        Context* const curCtx = Runtime::Instance()->CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }

    const Stream* curResLimitStream = InnerThreadLocalContainer::GetCurrentResLimitStream();
    if (curResLimitStream == curStm) {
        InnerThreadLocalContainer::SetCurrentResLimitStream(nullptr);
    } else {
        RT_LOG(RT_LOG_EVENT, "Try to unbind non-current stream.");
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImplRtConfig::GetResInCurrentThread(const rtDevResLimitType_t type, uint32_t* const value)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_NAME_AND_FUNC_DESC(
        static_cast<uint32_t>(type) >= RT_DEV_RES_TYPE_MAX, RT_ERROR_INVALID_VALUE,
        "Obtaining the device resources that can be used by the current thread", DevResLimitTypeToString(type), "type",
        "[0, 2)");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        value, RT_ERROR_INVALID_VALUE, "Obtaining the device resources that can be used by the current thread");
    const auto curResLimitStream = InnerThreadLocalContainer::GetCurrentResLimitStream();
    if (curResLimitStream != nullptr && curResLimitStream->GetResLimitFlag(type)) {
        *value = curResLimitStream->GetResValue(type);
        RT_LOG(
            RT_LOG_INFO, "stream_id=%d, type=%s, value=%u.", curResLimitStream->Id_(), DevResLimitTypeToString(type),
            *value);
    } else {
        Device* dev = InnerThreadLocalContainer::GetDevice();
        if (dev == nullptr) {
            Context* const curCtx = Runtime::Instance()->CurrentContext();
            CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
            dev = curCtx->Device_();
            NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
        }
        *value = dev->GetResValue(type);
        RT_LOG(RT_LOG_INFO, "drv devId=%u, type=%s, value=%u.", dev->Id_(), DevResLimitTypeToString(type), *value);
    }
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
