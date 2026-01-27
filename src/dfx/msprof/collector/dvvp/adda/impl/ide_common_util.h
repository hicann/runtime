/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef IDE_DAEMON_COMMON_UTIL_H
#define IDE_DAEMON_COMMON_UTIL_H
#include <fcntl.h>
#include "extra_config.h"
#include "hdc_api.h"
#include "securec.h"
#include "mmpa_api.h"
#include "ide_tlv.h"
#include "adx_log.h"
#include "msprof_dlog.h"
#include "memory_utils.h"
#ifdef __cplusplus
extern "C" {
#endif

enum IdeComponentType {
    IDE_COMPONENT_HOOK_REG = 0,
    IDE_COMPONENT_BBOX, // multiple device should init callback first
    IDE_COMPONENT_HDC,
    IDE_COMPONENT_CMD,
    IDE_COMPONENT_SEND_FILE,
    IDE_COMPONENT_DEBUG,
    IDE_COMPONENT_BBOX_HDC,
    IDE_COMPONENT_LOG,
    IDE_COMPONENT_FILE_SYNC,
    IDE_COMPONENT_API,
    IDE_COMPONENT_PROFILING,
    IDE_COMPONENT_DUMP,
    IDE_COMPONENT_HOST_CMD,
    IDE_COMPONENT_DETECT,
    IDE_COMPONENT_FILE_GET,
    IDE_COMPONENT_NV,
    IDE_COMPONENT_FILE_GETD, // get device file (compare in C3x)
    IDE_COMPONENT_MONITOR,
    NR_IDE_COMPONENTS,
};

struct ComponentMap {
    enum IdeComponentType type;
    CmdClassT cmdType;
    IdeString name;
    IdeString operateType;
};

struct IdeSingleComponentFuncs {
    int32_t (*init)(void);
    int32_t (*destroy)(void);
    int32_t (*sockProcess)(IdeSession sockDesc, HDC_CLIENT client, IdeTlvConReq req);
    int32_t (*hdcProcess)(HDC_SESSION session, IdeTlvConReq req);
};

struct IdeComponentsFuncs {
    int32_t (*init[NR_IDE_COMPONENTS])(void);
    int32_t (*destroy[NR_IDE_COMPONENTS])(void);
    int32_t (*sockProcess[NR_IDE_COMPONENTS])(IdeSession sockDesc, HDC_CLIENT client, IdeTlvConReq req);
    int32_t (*hdcProcess[NR_IDE_COMPONENTS])(HDC_SESSION session, IdeTlvConReq req);
};

extern struct IdeComponentsFuncs       g_ideComponentsFuncs;

extern void IdeReqFree(const IdeTlvReq req);
extern void IdeRegisterSig();

extern IdeString IdeGetCompontName(int32_t type);
extern IdeString IdeGetCompontNameByReq(CmdClassT reqType);
enum IdeComponentType IdeGetComponentType(IdeTlvConReq req);
extern int32_t GenrateCfgFile(void);
extern void RemoveCfgFile(void);

extern int32_t IdeComponentsInit();
extern void IdeComponentsDestroy();

extern int32_t IdeDaemonSubInit();
extern int32_t DaemonInit();
extern void DaemonCloseServerSock();
extern void DaemonDestroy();

extern int32_t HdclogHostInit();
extern int32_t HdclogHostDestroy();

#define IDE_CTRL_MUTEX_LOCK(mtx, action) do {                          \
    if (mmMutexLock(mtx) != EN_OK) {                                   \
        MSPROF_LOGE("mutex lock error");                                  \
        action;                                                        \
    }                                                                  \
} while (0)

#define IDE_CTRL_MUTEX_UNLOCK(mtx, action) do {                        \
    if (mmMutexUnLock(mtx) != EN_OK) {                                 \
        MSPROF_LOGE("mutex lock error");                                  \
        action;                                                        \
    }                                                                  \
} while (0)

#define IDE_MMCLOSE_AND_SET_INVALID(fd) do {                    \
    if ((fd) >= 0) {                                            \
        (void)mmClose(fd);                                      \
        fd = -1;                                                \
    }                                                           \
} while (0)

#if defined(__IDE_UT) || defined(__IDE_ST)
#define STATIC
#else
#define STATIC static
#endif
#ifdef __cplusplus
}
#endif
#endif // IDE_DAEMON_COMMON_UTIL_H
