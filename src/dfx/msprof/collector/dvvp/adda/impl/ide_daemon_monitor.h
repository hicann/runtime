/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef IDE_DAEMON_MONITOR_H
#define IDE_DAEMON_MONITOR_H
#include "extra_config.h"
int IdeMonitorHostInit(void);
int IdeMonitorHostDestroy(void);
#if defined(__IDE_UT) || defined(__IDE_ST)
#define STATIC
#else
#define STATIC static
#endif
#if defined(__IDE_UT) || defined(__IDE_ST)
STATIC bool IdeMonitorIsRun(void);
STATIC bool IdeMonitorIsHeartBeat(void);
STATIC IdeThreadArg IdeMonitorThread(IdeThreadArg args);
extern STATIC struct IdeMonitorMgr g_ideMonitorMgr;
#endif

#endif // PLATFORM_MONITOR