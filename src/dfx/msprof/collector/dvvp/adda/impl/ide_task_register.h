/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef IDE_TASK_REGISTER_H
#define IDE_TASK_REGISTER_H
#include "ide_common_util.h"
#include "ide_daemon_hdc.h"
namespace Adx {
const char * const IDE_DAEMON_NAME = "adda";
extern void IdeDaemonRegisterModules();
#if defined(__IDE_UT) || defined(__IDE_ST)
STATIC void IdeRegisterModule(enum IdeComponentType type, const struct IdeSingleComponentFuncs &ideFuncs);
#endif
}
#ifdef __cplusplus
extern "C" {
#endif
extern int32_t IdeHostProfileProcess(IdeSession sockDesc, HDC_CLIENT client, IdeTlvConReq req);
extern int32_t IdeHostProfileInit();
extern int32_t IdeHostProfileCleanup();
extern int32_t IdeDeviceProfileProcess(HDC_SESSION session, IdeTlvConReq req);
extern int32_t IdeDeviceProfileInit();
extern int32_t IdeDeviceProfileCleanup();
extern int32_t IdeHostLogProcess(IdeSession sockDesc, HDC_CLIENT client, IdeTlvConReq req);
#ifdef __cplusplus
}
#endif
#endif
