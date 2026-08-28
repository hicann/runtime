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
#include "mmpa_api.h"
#include "ascend_hal.h"

extern "C" {
// MsprofDrvApi 通过 dlopen/dlsym 动态加载以下驱动符号；注册到桩表后，
// dlsym 返回已链接的 stub 符号地址（定义见 ../stub/ide_hdc_stub.cc），
// 既有 MOCKER(驱动符号) 用例即可命中，无需修改测试用例。
static const std::map<std::string, void*> g_map = {
    {"drvHdcClientCreate", (void*)drvHdcClientCreate},
    {"drvHdcClientDestroy", (void*)drvHdcClientDestroy},
    {"drvHdcServerCreate", (void*)drvHdcServerCreate},
    {"drvHdcServerDestroy", (void*)drvHdcServerDestroy},
    {"drvHdcSessionAccept", (void*)drvHdcSessionAccept},
    {"drvHdcSetSessionReference", (void*)drvHdcSetSessionReference},
    {"drvHdcSessionConnect", (void*)drvHdcSessionConnect},
    {"halHdcSessionConnectEx", (void*)halHdcSessionConnectEx},
    {"drvHdcSessionClose", (void*)drvHdcSessionClose},
    {"drvHdcGetCapacity", (void*)drvHdcGetCapacity},
    {"drvHdcAllocMsg", (void*)drvHdcAllocMsg},
    {"drvHdcFreeMsg", (void*)drvHdcFreeMsg},
    {"drvHdcReuseMsg", (void*)drvHdcReuseMsg},
    {"drvHdcGetMsgBuffer", (void*)drvHdcGetMsgBuffer},
    {"drvHdcAddMsgBuffer", (void*)drvHdcAddMsgBuffer},
    {"halHdcSend", (void*)halHdcSend},
    {"halHdcRecv", (void*)halHdcRecv},
    {"halHdcGetSessionAttr", (void*)halHdcGetSessionAttr},
};
}

void* mmDlsym(void* handle, const char* funcName)
{
    auto it = g_map.find(funcName);
    if (it != g_map.end()) {
        return it->second;
    }
    return nullptr;
}

static int32_t g_handle = 0;

int32_t mmDlclose(void* handle) { return 0; }

void* mmDlopen(const char* fileName, int mode)
{
    if (fileName != nullptr && strcmp(fileName, "libascend_hal.so") == 0) {
        return &g_handle;
    }
    return nullptr;
}

char* mmDlerror(void) { return nullptr; }
