/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_inner_api.h"
#include "prof_acl_plugin.h"
#include "prof_cann_plugin.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

// prof acl api
MSVP_PROF_API int32_t ProfAclInit(uint32_t type, const char *profilerPath, uint32_t len)
{
    ProfAPI::ProfCannPlugin::instance()->ProfApiInit();
    ProfAPI::ProfCannPlugin::instance()->ProfInitReportBuf();
    ProfAPI::ProfCannPlugin::instance()->ProfTxInit();
    return ProfAPI::ProfAclPlugin::instance()->ProfAclInit(type, profilerPath, len);
}

MSVP_PROF_API int32_t ProfAclWarmup(uint32_t type, PROFAPI_CONFIG_CONST_PTR profilerConfig)
{
    return ProfAPI::ProfAclPlugin::instance()->ProfAclWarmup(type, profilerConfig);
}

MSVP_PROF_API int32_t ProfAclStart(uint32_t type, PROFAPI_CONFIG_CONST_PTR profilerConfig)
{
    return ProfAPI::ProfAclPlugin::instance()->ProfAclStart(type, profilerConfig);
}

MSVP_PROF_API int32_t ProfAclStop(uint32_t type, PROFAPI_CONFIG_CONST_PTR profilerConfig)
{
    return ProfAPI::ProfAclPlugin::instance()->ProfAclStop(type, profilerConfig);
}

MSVP_PROF_API int32_t ProfAclFinalize(uint32_t type)
{
    int32_t ret = ProfAPI::ProfAclPlugin::instance()->ProfAclFinalize(type);
    ProfAPI::ProfCannPlugin::instance()->ProfUnInitReportBuf();
    return ret;
}

MSVP_PROF_API int32_t ProfAclDrvGetDevNum()
{
    ProfAPI::ProfCannPlugin::instance()->ProfApiInit();
    return ProfAPI::ProfAclPlugin::instance()->ProfAclDrvGetDevNum();
}

MSVP_PROF_API int32_t ProfAclSetConfig(uint32_t configType, const char *config, size_t configLength)
{
    return ProfAPI::ProfAclPlugin::instance()->ProfAclSetConfig(configType, config, configLength);
}

MSVP_PROF_API int32_t ProfAclGetCompatibleFeatures(size_t *featuresSize, void **featuresData)
{
    return ProfAPI::ProfAclPlugin::instance()->ProfAclGetCompatibleFeatures(featuresSize, featuresData);
}

MSVP_PROF_API int32_t ProfAclGetCompatibleFeaturesV2(size_t *featuresSize, void **featuresData)
{
    return ProfAPI::ProfAclPlugin::instance()->ProfAclGetCompatibleFeaturesV2(featuresSize, featuresData);
}

MSVP_PROF_API int ProfAclRegisterDeviceCallback()
{
    return ProfAPI::ProfAclPlugin::instance()->ProfAclRegisterDeviceCallback();
}

#ifdef __cplusplus
}
#endif