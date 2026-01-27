/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <map>
#include "mmpa_api.h"
#include "prof_inner_api.h"
#include "acl/acl_base.h"
#include "runtime/base.h"

rtError_t rtProfilerTraceEx(uint64_t id, uint64_t modelId, uint16_t tagId, rtStream_t stm)
{
    return ACL_RT_SUCCESS;
}

rtError_t rtProfilerTraceExStub(uint64_t indexId, uint64_t modelId, uint16_t tagId, rtStream_t stm)
{
    (void)indexId;
    (void)modelId;
    (void)tagId;
    (void)stm;
    return RT_ERROR_NONE;
}

int32_t g_handle;
std::map<std::string, void*> g_map = {
#ifndef MSPROF_C
    {"ProfAclInit", (void *)ProfAclInit},
    {"ProfAclStart", (void *)ProfAclStart},
    {"ProfAclStop", (void *)ProfAclStop},
    {"ProfAclFinalize", (void *)ProfAclFinalize},
    {"ProfAclSubscribe", (void *)ProfAclSubscribe},
    {"ProfAclUnSubscribe", (void *)ProfAclUnSubscribe},
    {"ProfAclDrvGetDevNum", (void *)ProfAclDrvGetDevNum},
    {"ProfAclGetOpTime", (void *)ProfAclGetOpTime},
    {"ProfAclGetId", (void *)ProfAclGetId},
    {"ProfAclGetOpVal", (void *)ProfAclGetOpVal},
    {"ProfGetOpExecutionTime", (void *)ProfGetOpExecutionTime},
    {"ProfOpUnSubscribe", (void *)ProfOpUnSubscribe},
    {"ProfOpSubscribe", (void *)ProfOpSubscribe},
    {"ProfAclGetOpAttriVal", (void *)ProfAclGetOpAttriVal},
    {"rtProfilerTraceEx", (void *)rtProfilerTraceExStub}
#endif
    };

void *mmDlsym(void *handle, const char *funcName)
{
    auto it = g_map.find(funcName);
    if (it != g_map.end()) {
        return it->second;
    }
    return nullptr;
}

char *mmDlerror(void)
{
    return nullptr;
}

void *mmDlopen(const char *fileName, int mode)
{
    if (strcmp(fileName, "libprofimpl.so") == 0 ||
        strcmp(fileName, "libruntime.so") == 0) {
        return &g_handle;
    }
    return nullptr;
}

int mmDlclose(void *handle)
{
    return 0;
}
