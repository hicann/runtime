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
#include <string>
#include "mmpa_api.h"
#include "ascend_hal.h"

extern "C" drvError_t drvGetDeviceSplitMode(unsigned int dev_id, unsigned int *mode);

int32_t g_handle;
const std::map<std::string, void*> g_map = {
    {"halGetAPIVersion", (void *)halGetAPIVersion},
    {"drvGetDeviceSplitMode", (void *)drvGetDeviceSplitMode},
    {"halEschedQueryInfo", (void *)halEschedQueryInfo},
    {"halEschedCreateGrpEx", (void *)halEschedCreateGrpEx},
};

void *mmDlsym(void *handle, const char *funcName)
{
    auto it = g_map.find(funcName);
    if (it != g_map.end()) {
        return it->second;
    }
    return nullptr;
}

int32_t mmDlclose(void *handle)
{
    return 0;
}

void *mmDlopen(const char *fileName, int mode)
{
    if (strcmp(fileName, "libascend_hal.so") == 0) {
        return &g_handle;
    }
    return nullptr;
}

char *mmDlerror(void)
{
    return nullptr;
}
