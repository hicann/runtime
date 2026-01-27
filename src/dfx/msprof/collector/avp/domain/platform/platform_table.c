/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "platform_table.h"
#include "errno/error_code.h"
#include "logger/logger.h"
#include "osal/osal_mem.h"
#include "chip/chip_nano_v1.h"
 
typedef struct {
    PlatformType type;
    CreatePlatformFunc func;
} PlatformTable;

static PlatformTable g_funcTable[] = {
    {CHIP_NANO_V1, CreateNanoPlatform},
};

/**
 * @brief Create interface pointer of platform
 * @param [in] type : data config of bit switch
 * @return platform interface pointer
 */
PlatformInterface *CreatePlatform(PlatformType type)
{
    PlatformInterface *pInterface = (PlatformInterface *)OsalCalloc(sizeof(PlatformInterface));
    if (pInterface == NULL) {
        MSPROF_LOGE("Failed to calloc for platform interface, type: %d", type);
        return NULL;
    }
    for (uint32_t i = 0; i < sizeof(g_funcTable)/sizeof(g_funcTable[0]); ++i) {
        if (g_funcTable[i].type == type) {
            g_funcTable[i].func(pInterface);
            MSPROF_LOGI("Success to create platform, type: %d", type);
            return pInterface;
        }
    }
    MSPROF_LOGE("Failed to find platform function, type: %d.", type);
    DestroyPlatform(pInterface);
    return NULL;
}

/**
 * @brief Free interface pointer of platform
 * @param [in] interface : platform interface pointer
 */
void DestroyPlatform(PlatformInterface *interface)
{
    OSAL_MEM_FREE(interface);
}