/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstring>
#include <string>
#include "prof_cann_plugin.h"
#include "errno/error_code.h"
#include "aprof_pub.h"
#include "acl_prof.h"
#include "msprof_tx_manager.h"

using namespace analysis::dvvp::common::error;

// Called after MsprofInit to ensure ProfCannPlugin buffers are ready.
// ProfApiInit, ProfInitReportBuf, and ProfTxInit are idempotent, so multiple calls are safe.
static void EnsureProfCannPluginInited()
{
    ProfAPI::ProfCannPlugin::instance()->ProfApiInit();
    ProfAPI::ProfCannPlugin::instance()->ProfInitReportBuf(MSPROF_CTRL_INIT_GE_OPTIONS);
    ProfAPI::ProfCannPlugin::instance()->ProfTxInit();
}

MSVP_PROF_API aclError aclprofMarkEx(const char *msg, size_t msgLen, aclrtStream stream)
{
    EnsureProfCannPluginInited();
    (void)Msprof::MsprofTx::MsprofTxManager::instance()->Init();
    return static_cast<aclError>(Msprof::MsprofTx::MsprofTxManager::instance()->MarkEx(msg, msgLen, stream));
}

MSVP_PROF_API void* aclprofCreateStamp()
{
    EnsureProfCannPluginInited();
    (void)Msprof::MsprofTx::MsprofTxManager::instance()->Init();
    return Msprof::MsprofTx::MsprofTxManager::instance()->CreateStamp();
}

MSVP_PROF_API int32_t MsprofRegTypeInfo(uint16_t level, uint32_t typeId, const char *typeName)
{
    if (typeName == nullptr) {
        return PROFILING_FAILED;
    }
    return ProfAPI::ProfCannPlugin::instance()->ProfReportRegTypeInfo(level, typeId, typeName, strlen(typeName));
}

MSVP_PROF_API int32_t MsprofReportCompactInfo(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length)
{
    if (data == nullptr) {
        return PROFILING_FAILED;
    }
    EnsureProfCannPluginInited();
    return ProfAPI::ProfCannPlugin::instance()->ProfReportCompactInfo(nonPersistantFlag, data, length);
}

MSVP_PROF_API int32_t MsprofReportApi(uint32_t nonPersistantFlag, const struct MsprofApi *api)
{
    if (api == nullptr) {
        return PROFILING_FAILED;
    }
    EnsureProfCannPluginInited();
    return ProfAPI::ProfCannPlugin::instance()->ProfReportApi(nonPersistantFlag, api);
}

MSVP_PROF_API int32_t MsprofReportEvent(uint32_t nonPersistantFlag, const struct MsprofEvent *event)
{
    if (event == nullptr) {
        return PROFILING_FAILED;
    }
    EnsureProfCannPluginInited();
    return ProfAPI::ProfCannPlugin::instance()->ProfReportEvent(nonPersistantFlag, event);
}

MSVP_PROF_API int32_t MsprofReportAdditionalInfo(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length)
{
    if (data == nullptr) {
        return PROFILING_FAILED;
    }
    EnsureProfCannPluginInited();
    return ProfAPI::ProfCannPlugin::instance()->ProfReportAdditionalInfo(nonPersistantFlag, data, length);
}

MSVP_PROF_API uint64_t MsprofGetHashId(const char *hashInfo, size_t length)
{
    if (hashInfo == nullptr || length == 0) {
        return 0;
    }
    return ProfAPI::ProfCannPlugin::instance()->ProfReportGetHashId(hashInfo, length);
}

MSVP_PROF_API uint64_t MsprofSysCycleTime(void) { return 0; }
