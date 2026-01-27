/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "msprof_api_adapter.h"
#include "common/bqs_log.h"

namespace bqs {
namespace {
const std::string MsprofSoName = "libprofapi.so";

const std::string MsprofInitFuncName = "MsprofInit";
const std::string MsprofFinalizeFuncName = "MsprofFinalize";
const std::string MsprofRegTypeInfoFuncName = "MsprofRegTypeInfo";
const std::string MsprofRegisterCallbackFuncName = "MsprofRegisterCallback";
const std::string MsprofReportApiFuncName = "MsprofReportApi";
const std::string MsprofReportEventFuncName = "MsprofReportEvent";
const std::string MsprofSysCycleTimeFuncName = "MsprofSysCycleTime";

using MsprofInitFunc = int32_t (*)(uint32_t, void*, uint32_t);
using MsprofFinalizeFunc = int32_t (*)();
using MsprofRegTypeInfoFunc = int32_t (*)(uint16_t, uint32_t, const char*);
using MsprofRegisterCallbackFunc = int32_t (*)(uint32_t, ProfCommandHandle);
using MsprofReportApiFunc = int32_t (*)(uint32_t, const MsprofApi*);
using MsprofReportEventFunc = int32_t (*)(uint32_t, const MsprofEvent*);
using MsprofSysCycleTimeFunc = uint64_t (*)();
}

BqsMsprofApiAdapter &BqsMsprofApiAdapter::GetInstance()
{
    static BqsMsprofApiAdapter instance(MsprofSoName.c_str());
    return instance;
}

ProfStatus BqsMsprofApiAdapter::MsprofInit(uint32_t dataType, void *data, uint32_t dataLen)
{
    void *funcHandle = GetFuncHandle(MsprofInitFuncName);
    if (funcHandle == nullptr) {
        return ProfStatus::PROF_MSPROF_API_NULLPTR;
    }

    const int32_t ret = (PtrToFunctionPtr<void, MsprofInitFunc>(funcHandle))(dataType, data, dataLen);
    if (ret != 0) {
        BQS_LOG_ERROR("[Prof]Call %s failed, msprofRet=%d.", MsprofInitFuncName.c_str(), ret);
        return ProfStatus::PROF_MSPROF_INNER_ERROR;
    }

    return ProfStatus::PROF_SUCCESS;
}

ProfStatus BqsMsprofApiAdapter::MsprofFinalize()
{
    void *funcHandle = GetFuncHandle(MsprofFinalizeFuncName);
    if (funcHandle == nullptr) {
        return ProfStatus::PROF_MSPROF_API_NULLPTR;
    }

    const int32_t ret = (PtrToFunctionPtr<void, MsprofFinalizeFunc>(funcHandle))();
    if (ret != 0) {
        BQS_LOG_ERROR("[Prof]Call %s failed, msprofRet=%d.", MsprofFinalizeFuncName.c_str(), ret);
        return ProfStatus::PROF_MSPROF_INNER_ERROR;
    }

    return ProfStatus::PROF_SUCCESS;
}

ProfStatus BqsMsprofApiAdapter::MsprofRegTypeInfo(uint16_t level, uint32_t typeId, const char *typeName)
{
    void *funcHandle = GetFuncHandle(MsprofRegTypeInfoFuncName);
    if (funcHandle == nullptr) {
        return ProfStatus::PROF_MSPROF_API_NULLPTR;
    }

    const int32_t ret = (PtrToFunctionPtr<void, MsprofRegTypeInfoFunc>(funcHandle))(level, typeId, typeName);
    if (ret != 0) {
        BQS_LOG_ERROR("[Prof]Call %s failed, msprofRet=%d.", MsprofRegTypeInfoFuncName.c_str(), ret);
        return ProfStatus::PROF_MSPROF_INNER_ERROR;
    }

    return ProfStatus::PROF_SUCCESS;
}

ProfStatus BqsMsprofApiAdapter::MsprofRegisterCallback(uint32_t moduleId, ProfCommandHandle handle)
{
    void *funcHandle = GetFuncHandle(MsprofRegisterCallbackFuncName);
    if (funcHandle == nullptr) {
        return ProfStatus::PROF_MSPROF_API_NULLPTR;
    }

    const int32_t ret = (PtrToFunctionPtr<void, MsprofRegisterCallbackFunc>(funcHandle))(moduleId, handle);
    if (ret != 0) {
        BQS_LOG_ERROR("[Prof]Call %s failed, msprofRet=%d.", MsprofRegisterCallbackFuncName.c_str(), ret);
        return ProfStatus::PROF_MSPROF_INNER_ERROR;
    }

    return ProfStatus::PROF_SUCCESS;
}

ProfStatus BqsMsprofApiAdapter::MsprofReportApi(uint32_t agingFlag, const MsprofApi *api)
{
    void *funcHandle = GetFuncHandle(MsprofReportApiFuncName);
    if (funcHandle == nullptr) {
        return ProfStatus::PROF_MSPROF_API_NULLPTR;
    }

    const int32_t ret = (PtrToFunctionPtr<void, MsprofReportApiFunc>(funcHandle))(agingFlag, api);
    if (ret != 0) {
        BQS_LOG_ERROR("[Prof]Call %s failed, msprofRet=%d.", MsprofReportApiFuncName.c_str(), ret);
        return ProfStatus::PROF_MSPROF_INNER_ERROR;
    }

    return ProfStatus::PROF_SUCCESS;
}

ProfStatus BqsMsprofApiAdapter::MsprofReportEvent(uint32_t agingFlag, const MsprofEvent *event)
{
    void *funcHandle = GetFuncHandle(MsprofReportEventFuncName);
    if (funcHandle == nullptr) {
        return ProfStatus::PROF_MSPROF_API_NULLPTR;
    }

    const int32_t ret = (PtrToFunctionPtr<void, MsprofReportEventFunc>(funcHandle))(agingFlag, event);
    if (ret != 0) {
        BQS_LOG_ERROR("[Prof]Call %s failed, msprofRet=%d.", MsprofReportEventFuncName.c_str(), ret);
        return ProfStatus::PROF_MSPROF_INNER_ERROR;
    }

    return ProfStatus::PROF_SUCCESS;
}

uint64_t BqsMsprofApiAdapter::MsprofSysCycleTime()
{
    void *funcHandle = GetFuncHandle(MsprofSysCycleTimeFuncName);
    if (funcHandle == nullptr) {
        return 0UL;
    }

    return (PtrToFunctionPtr<void, MsprofSysCycleTimeFunc>(funcHandle))();
}
} // namespace bqs