/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ide_task_register.h"
#include "ide_daemon_monitor.h"
/**
 * @brief register component process
 * @param type: the component type
 * @param ide_funcs: contain init/destroy/sock_process/hdc_process to register to ide daemon
 *
 * @return
 */
namespace Adx {
STATIC void IdeRegisterModule(enum IdeComponentType type, const struct IdeSingleComponentFuncs &ideFuncs)
{
    if (type < NR_IDE_COMPONENTS) {
        g_ideComponentsFuncs.init[type] = ideFuncs.init;
        g_ideComponentsFuncs.destroy[type] = ideFuncs.destroy;
        g_ideComponentsFuncs.sockProcess[type] = ideFuncs.sockProcess;
        g_ideComponentsFuncs.hdcProcess[type] = ideFuncs.hdcProcess;
    }
}

#ifdef IDE_DAEMON_DEVICE
STATIC void IdeDeviceMonitorRegister(struct IdeSingleComponentFuncs &ideFuncs)
{
    ideFuncs.init = IdeMonitorHostInit;
    ideFuncs.destroy = IdeMonitorHostDestroy;
    ideFuncs.sockProcess = nullptr;
    ideFuncs.hdcProcess = nullptr;
    IdeRegisterModule(IDE_COMPONENT_MONITOR, ideFuncs);
}

STATIC void IdeDeviceHdcRegister(struct IdeSingleComponentFuncs &ideFuncs)
{
    ideFuncs.init = HdcDaemonInit;
    ideFuncs.destroy = HdcDaemonDestroy;
    ideFuncs.sockProcess = nullptr;
    ideFuncs.hdcProcess = nullptr;
    IdeRegisterModule(IDE_COMPONENT_HDC, ideFuncs);
}

STATIC void IdeDeviceProfileRegister(struct IdeSingleComponentFuncs &ideFuncs)
{
    ideFuncs.init = IdeDeviceProfileInit;
    ideFuncs.destroy = IdeDeviceProfileCleanup;
    ideFuncs.sockProcess = nullptr;
    ideFuncs.hdcProcess = IdeDeviceProfileProcess;
    IdeRegisterModule(IDE_COMPONENT_PROFILING, ideFuncs);
}

void IdeDaemonRegisterModules()
{
    struct IdeSingleComponentFuncs ideFuncs = {nullptr, nullptr, nullptr, nullptr};
    IdeDeviceMonitorRegister(ideFuncs);
    IdeDeviceHdcRegister(ideFuncs);
    IdeDeviceProfileRegister(ideFuncs);
}
#endif
}

