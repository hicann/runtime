/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mmpa_api.h"
#include "utils.h"
#include "prof_api.h"
#include "osal_mem.h"

#ifdef LITE_OS
void* OsalMalloc(size_t size)
{
    if (size <= 0) {
        return NULL;
    }
    return malloc(size);
}

void* OsalCalloc(size_t size)
{
    OsalVoidPtr val = NULL;
    val = OsalMalloc(size);
    if (val == NULL) {
        return NULL;
    }

    errno_t err = memset_s(val, size, 0, size);
    if (err != EOK) {
        OSAL_MEM_FREE(val);
        return NULL;
    }

    return val;
}

void OsalFree(OsalVoidPtr ptr)
{
    if (ptr != NULL) {
        free(ptr);
    }
}

void OsalConstFree(const void* ptr)
{
    if (ptr != NULL) {
        void *ptr_l = (void *)ptr;
        free(ptr_l);
    }
}
#else

#include <map>
int32_t g_handle;
extern "C" int32_t MsprofInit(uint32_t dataType, VOID_PTR data, uint32_t dataLen);
extern "C" int32_t MsprofRegisterCallback(uint32_t moduleId, ProfCommandHandle handle);
extern "C" int32_t MsprofRegTypeInfo(uint16_t level, uint32_t typeId, const char *typeName);
extern "C" uint64_t MsprofGetHashId(const char *hashInfo, size_t length);
extern "C" int32_t MsprofNotifySetDevice(uint32_t chipId, uint32_t deviceId, bool isOpen);
extern "C" int32_t MsprofFinalize();
extern "C" uint64_t MsprofSysCycleTime();
extern "C" int32_t MsprofReportEvent(uint32_t agingFlag, const struct MsprofEvent *event);
extern "C" int32_t MsprofReportApi(uint32_t agingFlag, const struct MsprofApi *api);
extern "C" int32_t MsprofReportCompactInfo(uint32_t agingFlag, const VOID_PTR data, uint32_t length);
extern "C" int32_t MsprofReportAdditionalInfo(uint32_t agingFlag, const VOID_PTR data, uint32_t length);

const std::map<std::string, void*> g_map = {
    {"MsprofInit", (void *)MsprofInit},
    {"MsprofRegisterCallback", (void *)MsprofRegisterCallback},
    {"MsprofRegTypeInfo", (void *)MsprofRegTypeInfo},
    {"MsprofGetHashId", (void *)MsprofGetHashId},
    {"MsprofNotifySetDevice", (void *)MsprofNotifySetDevice},
    {"MsprofFinalize", (void *)MsprofFinalize},
    {"MsprofSysCycleTime", (void *)MsprofSysCycleTime},
    {"MsprofReportEvent", (void *)MsprofReportEvent},
    {"MsprofReportApi", (void *)MsprofReportApi},
    {"MsprofReportCompactInfo", (void *)MsprofReportCompactInfo},
    {"MsprofReportAdditionalInfo", (void *)MsprofReportAdditionalInfo},    
};


void *mmDlsym(void *handle, const char* funcName)
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

void * mmDlopen(const char *fileName, int mode)
{
    if (strcmp(fileName, "libprofimpl.so") == 0) {
        return &g_handle;
    }
    return nullptr;
}

int mmDlclose(void *handle)
{
    return 0;
}
#endif