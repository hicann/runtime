/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef IDE_DAEMON_HDC_H
#define IDE_DAEMON_HDC_H
#include <map>
#include <vector>
#include "ide_common_util.h"
#include "ide_platform_util.h"
#include "ascend_hal.h"

struct IdeDevStateInfo {
    uint32_t idx;
    devdrv_state_info_t* stateInfo;
};

/* hdc server state and param */
struct IdeDevInfo {
    mmThread tid;
    uint32_t phyDevId;
    uint32_t logDevId;
    bool createHdc;
    enum drvHdcServiceType serviceType;
    HDC_SERVER server;
    bool devDisable;
};

struct DeviceUpCallBack {
    std::vector <drvDeviceStartupNotify> upCallbacks;
};

struct IdeGlobalCtrlInfo {
    HDC_CLIENT hdcClient;                        // HDC client
    DeviceUpCallBack deviceNotifyCallbacks;      // Device Notify Callback functions
    std::map<int32_t, struct IdeDevInfo> mapDevInfo; // Device Info
    mmMutex_t mtx;                               // Mutex for struct
    mmSem_t devNotifySem;                        // Number of devices change semaphore
    bool devMapInfoInitFlag;                      // Mutex init flag
    bool hdcServerProcFlag;                       // HDC server process running flag
    bool hdcHandleEventFlag;                      // HDC handle process running flag
    bool initFlag;                                // Init flag
};

struct DevSession {
    uint32_t phyDevId;
    uint32_t logDevId;
    HDC_SESSION session;
    void *mmUserBlockAddr;
};

extern IdeThreadArg HdcCreateHdcServerProc(IdeThreadArg args);
extern int32_t HdcDaemonInit();
extern int32_t HdcDaemonDestroy();
extern int HdcDaemonServerRegister(uint32_t num, const std::vector<uint32_t> &dev);
extern IdeThreadArg IdeDaemonHdcProcessEvent(IdeThreadArg arg);
extern IdeThreadArg IdeDaemonHdcHandleEvent(IdeThreadArg args);
#endif /* IDE_COMMON_UTIL_H */
