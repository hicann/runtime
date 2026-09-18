/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "api_c.h"
#include "api_handle_guard.h"
#include "api_rt_config.hpp"
#include "enum_desc.hpp"

using namespace cce::runtime;

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
RTS_API rtError_t rtCtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal)
{
    ApiRtConfig* const apiRtConfigInstance = ApiRtConfig::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiRtConfigInstance);
    const rtError_t error = apiRtConfigInstance->CtxSetSysParamOpt(configOpt, configVal);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    if (configOpt < SYS_OPT_RESERVED) {
        return rtSetSysParamOpt(configOpt, configVal);
    }
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtCtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t* const configVal)
{
    ApiRtConfig* const apiRtConfigInstance = ApiRtConfig::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiRtConfigInstance);
    const rtError_t error = apiRtConfigInstance->CtxGetSysParamOpt(configOpt, configVal);
    if (error == RT_ERROR_NOT_SET_SYSPARAMOPT) {
        return ACL_ERROR_RT_SYSPARAMOPT_NOT_SET;
    }
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsCtxSetSysParamOpt(rtSysParamOpt configOpt, int64_t configVal)
{
    ApiRtConfig* const apiRtConfigInstance = ApiRtConfig::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiRtConfigInstance);
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM_NAME(
        (configOpt >= SYS_OPT_RESERVED) || (configOpt < 0), RT_ERROR_INVALID_VALUE, SysParamOptToString(configOpt),
        "configOpt", "[0, " + std::to_string(SYS_OPT_RESERVED) + ")");
    const rtError_t error = apiRtConfigInstance->CtxSetSysParamOpt(configOpt, configVal);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsCtxGetSysParamOpt(rtSysParamOpt configOpt, int64_t* configVal)
{
    ApiRtConfig* const apiRtConfigInstance = ApiRtConfig::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiRtConfigInstance);
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM_NAME(
        (configOpt >= SYS_OPT_RESERVED) || (configOpt < 0), RT_ERROR_INVALID_VALUE, SysParamOptToString(configOpt),
        "configOpt", "[0, " + std::to_string(SYS_OPT_RESERVED) + ")");
    const rtError_t error = apiRtConfigInstance->CtxGetSysParamOpt(configOpt, configVal);
    if (error == RT_ERROR_NOT_SET_SYSPARAMOPT) {
        return ACL_ERROR_RT_SYSPARAMOPT_NOT_SET;
    }
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsSetDeviceResLimit(const int32_t devId, const rtDevResLimitType_t type, uint32_t value)
{
    ApiRtConfig* const apiRtConfigInstance = ApiRtConfig::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiRtConfigInstance);
    if (devId < 0) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(devId, "greater than or equal to 0");
        ERROR_RETURN_WITH_EXT_ERRCODE(RT_ERROR_DEVICE_ID);
    }
    const rtError_t error = apiRtConfigInstance->SetDeviceResLimit(static_cast<uint32_t>(devId), type, value);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsResetDeviceResLimit(const int32_t devId)
{
    ApiRtConfig* const apiRtConfigInstance = ApiRtConfig::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiRtConfigInstance);
    if (devId < 0) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(devId, "greater than or equal to 0");
        ERROR_RETURN_WITH_EXT_ERRCODE(RT_ERROR_DEVICE_ID);
    }
    const rtError_t error = apiRtConfigInstance->ResetDeviceResLimit(static_cast<uint32_t>(devId));
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetDeviceResLimit(const int32_t devId, const rtDevResLimitType_t type, uint32_t* value)
{
    ApiRtConfig* const apiRtConfigInstance = ApiRtConfig::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiRtConfigInstance);
    if (devId < 0) {
        RT_LOG_OUTER_MSG_INVALID_PARAM(devId, "greater than or equal to 0");
        ERROR_RETURN_WITH_EXT_ERRCODE(RT_ERROR_DEVICE_ID);
    }
    const rtError_t error = apiRtConfigInstance->GetDeviceResLimit(static_cast<uint32_t>(devId), type, value);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsSetStreamResLimit(rtStream_t stm, const rtDevResLimitType_t type, const uint32_t value)
{
    ApiRtConfig* const apiRtConfigInstance = ApiRtConfig::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiRtConfigInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    const rtError_t error = apiRtConfigInstance->SetStreamResLimit(exeStream, type, value);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsResetStreamResLimit(rtStream_t stm)
{
    ApiRtConfig* const apiRtConfigInstance = ApiRtConfig::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiRtConfigInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    const rtError_t error = apiRtConfigInstance->ResetStreamResLimit(exeStream);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetStreamResLimit(const rtStream_t stm, const rtDevResLimitType_t type, uint32_t* const value)
{
    ApiRtConfig* const apiRtConfigInstance = ApiRtConfig::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiRtConfigInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    const rtError_t error = apiRtConfigInstance->GetStreamResLimit(exeStream, type, value);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsUseStreamResInCurrentThread(const rtStream_t stm)
{
    ApiRtConfig* const apiRtConfigInstance = ApiRtConfig::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiRtConfigInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    const rtError_t error = apiRtConfigInstance->UseStreamResInCurrentThread(exeStream);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsNotUseStreamResInCurrentThread(const rtStream_t stm)
{
    ApiRtConfig* const apiRtConfigInstance = ApiRtConfig::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiRtConfigInstance);
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    const rtError_t error = apiRtConfigInstance->NotUseStreamResInCurrentThread(exeStream);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsGetResInCurrentThread(const rtDevResLimitType_t type, uint32_t* const value)
{
    ApiRtConfig* const apiRtConfigInstance = ApiRtConfig::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiRtConfigInstance);
    const rtError_t error = apiRtConfigInstance->GetResInCurrentThread(type, value);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus
