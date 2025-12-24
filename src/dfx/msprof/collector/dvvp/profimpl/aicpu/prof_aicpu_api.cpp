/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_aicpu_api.h"
#include "prof_hal_plugin.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

/* AICPU API */
MSVP_PROF_API int32_t ProfHalGetVersion(uint32_t *version)
{
    return ProfAPI::ProfHalPlugin::instance()->ProfHalGetVersion(version);
}

MSVP_PROF_API int32_t ProfHalModuleInitialize(uint32_t moduleType, const void *moduleConfig, uint32_t length)
{
    return ProfAPI::ProfHalPlugin::instance()->ProfHalInit(moduleType, moduleConfig, length);
}

MSVP_PROF_API int32_t ProfHalModuleFinalize()
{
    return ProfAPI::ProfHalPlugin::instance()->ProfHalFinal();
}

MSVP_PROF_API void ProfHalSetFlushModuleCallback(const ProfHalFlushModuleCallback func)
{
    ProfAPI::ProfHalPlugin::instance()->ProfHalFlushModuleRegister(func);
}

MSVP_PROF_API void ProfHalSetSendDataCallback(const ProfHalSendAicpuDataCallback func)
{
    ProfAPI::ProfHalPlugin::instance()->ProfHalSendDataRegister(func);
}

MSVP_PROF_API void ProfHalSetHelperDirCallback(const ProfHalHelperDirCallback func)
{
    ProfAPI::ProfHalPlugin::instance()->ProfHalHelperDirRegister(func);
}

MSVP_PROF_API void ProfHalSetSendHelperDataCallback(const ProfHalSendHelperDataCallback func)
{
    ProfAPI::ProfHalPlugin::instance()->ProfHalSendHelperDataRegister(func);
}
#ifdef __cplusplus
}
#endif
