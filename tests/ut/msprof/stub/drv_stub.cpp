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
#include <cstring>
#include "ascend_hal.h"
#include "ascend_inpackage_hal.h"
#include "mmpa_api.h"

extern "C" {
drvError_t halGetAPIVersion(int32_t* ver)
{
    *ver = 0x071905;
    return DRV_ERROR_NONE;
}

drvError_t drvGetDeviceSplitMode(unsigned int dev_id, unsigned int* mode)
{
    *mode = 0;
    return DRV_ERROR_NONE;
}

std::map<std::string, void*> g_map = {
    {"halGetAPIVersion", (void*)halGetAPIVersion},
    {"drvGetDeviceSplitMode", (void*)drvGetDeviceSplitMode},
    {"halEschedQueryInfo", (void*)halEschedQueryInfo},
    {"halEschedCreateGrpEx", (void*)halEschedCreateGrpEx},
    // MsprofDrvApi 通过 dlopen/dlsym 动态加载以下驱动符号；注册到桩表后，
    // dlsym 返回已链接的 stub 符号地址，既有 MOCKER(驱动符号) 用例即可命中，无需修改测试用例。
    {"drvGetDevNum", (void*)drvGetDevNum},
    {"drvGetDevIDs", (void*)drvGetDevIDs},
    {"drvGetPlatformInfo", (void*)drvGetPlatformInfo},
    {"drvDeviceStatus", (void*)drvDeviceStatus},
    {"halGetDeviceInfo", (void*)halGetDeviceInfo},
    {"prof_drv_get_channels", (void*)prof_drv_get_channels},
    {"prof_drv_start", (void*)prof_drv_start},
    {"prof_stop", (void*)prof_stop},
    {"prof_channel_read", (void*)prof_channel_read},
    {"prof_channel_poll", (void*)prof_channel_poll},
    {"halProfDataFlush", (void*)halProfDataFlush},
    {"drvDeviceGetPhyIdByIndex", (void*)drvDeviceGetPhyIdByIndex},
    {"halEschedSubmitEvent", (void*)halEschedSubmitEvent},
    {"halProfSampleRegister", (void*)halProfSampleRegister},
    {"halProfSampleRegisterEx", (void*)halProfSampleRegisterEx},
    {"halProfQueryAvailBufLen", (void*)halProfQueryAvailBufLen},
    {"halProfSampleDataReport", (void*)halProfSampleDataReport},
};

void* mmDlsym(void* handle, const char* funcName)
{
    auto it = g_map.find(funcName);
    if (it != g_map.end()) {
        return it->second;
    }
    return nullptr;
}

char* mmDlerror(void) { return nullptr; }
int32_t g_handle;
void* mmDlopen(const char* fileName, int mode)
{
    if (strcmp(fileName, "libascend_hal.so") == 0) {
        return &g_handle;
    }
    return nullptr;
}

int mmDlclose(void* handle) { return 0; }
}