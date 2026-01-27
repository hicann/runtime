/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ide_common_util.h"
#include <cstring>
#include <ctime>
#include <cerrno>
#include <sys/stat.h>
#include <sys/types.h>
#include <cstdarg>
#include <csignal>
#include <vector>
#include <string>
#include <mutex>
#include <syslog.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/prctl.h>
#include "ide_platform_util.h"
#include "adx_log.h"
#include "adx_config.h"
#include "memory_utils.h"
using std::vector;
using namespace std;
using namespace IdeDaemon::Common::Config;
using namespace Adx;
using namespace Analysis::Dvvp::Adx;

struct IdeComponentsFuncs       g_ideComponentsFuncs;
static struct ComponentMap g_compMap[] = {
    {IDE_COMPONENT_HOOK_REG,    IDE_INVALID_REQ,            "hook_reg",       nullptr         },
    {IDE_COMPONENT_HDC,         IDE_INVALID_REQ,            "hdc",            nullptr         },
    {IDE_COMPONENT_PROFILING,   IDE_PROFILING_REQ,          "profiling",      "Profiling"     },
    {NR_IDE_COMPONENTS,         NR_IDE_CMD_CLASS,           "default",        nullptr         },
};

#define IDE_GET_COMPONENT_NUM    ((sizeof(g_compMap) / sizeof(g_compMap[0])))

IdeString IdeGetCompontName(int32_t type)
{
    uint32_t i;
    for (i = 0; i < IDE_GET_COMPONENT_NUM; i++) {
        if (type == static_cast<int32_t>(g_compMap[i].type)) {
            return g_compMap[i].name;
        }
    }

    return "default";
}

IdeString IdeGetCompontNameByReq(CmdClassT reqType)
{
    uint32_t i;
    for (i = 0; i < IDE_GET_COMPONENT_NUM; i++) {
        if (reqType == g_compMap[i].cmdType) {
            return g_compMap[i].name;
        }
    }

    return "default";
}

/**
 * @brief get the corresponding handler according to tlv
 * @param req: tlv request
 *
 * @return
 *        components_type
 */
enum IdeComponentType IdeGetComponentType(IdeTlvConReq req)
{
    IDE_CTRL_VALUE_FAILED(req != nullptr, return NR_IDE_COMPONENTS, "input req is nullptr");
    enum IdeComponentType type = NR_IDE_COMPONENTS;
    uint32_t i;

    for (i = 0; i < IDE_GET_COMPONENT_NUM; i++) {
        if (req->type == g_compMap[i].cmdType) {
            type = g_compMap[i].type;
            break;
        }
    }

    return type;
}

/**
 * @brief free tlv request
 * @param req: tlv request
 *
 * @return
 */
void IdeReqFree(const IdeTlvReq req)
{
    IdeXfree(req);
}

/**
 * @brief register the SIGPIPE process function
 *
 * @return
 */
void IdeRegisterSig()
{
    signal(SIGPIPE, SIG_IGN);
}

/**
 * @brief initial ide daemon, mkdir workspace and init socket server
 *
 * @return
 *        IDE_DAEMON_OK: succ
 *        IDE_DAEMON_ERROR: failed
 */
int32_t IdeDaemonSubInit()
{
    IdeRegisterSig();
    return IDE_DAEMON_OK;
}

/**
 * @brief call ide components initial functions
 *
 * @return
 *        IDE_DAEMON_OK: succ
 *        IDE_DAEMON_ERROR: failed
 */
int32_t IdeComponentsInit()
{
    int32_t i;
    for (i = 0; i < NR_IDE_COMPONENTS; i++) {
        if (g_ideComponentsFuncs.init[i] == nullptr) {
            continue;
        }
        int32_t err = g_ideComponentsFuncs.init[i]();
        if (err != IDE_DAEMON_OK) {
            MSPROF_LOGE("call [%s] init function failed", IdeGetCompontName(i));
            printf("init [%s] failed\n", IdeGetCompontName(i));
            if (i == IDE_COMPONENT_HDC) {
                return IDE_DAEMON_ERROR;
            }
        } else {
            MSPROF_LOGI("call [%s] init function succ", IdeGetCompontName(i));
        }
    }

    return IDE_DAEMON_OK;
}

/**
 * @brief call ide components destroy functions
 *
 * @return
 */
void IdeComponentsDestroy()
{
    int32_t i;
    for (i = NR_IDE_COMPONENTS; i > 0; i--) {
        int32_t pos = i - 1;
        if (g_ideComponentsFuncs.destroy[pos] != nullptr) {
            int32_t err = g_ideComponentsFuncs.destroy[pos]();
            if (err != IDE_DAEMON_OK) {
                MSPROF_LOGE("call ideComponents Funcs destroy[%s] failed", IdeGetCompontName(pos));
            } else {
                MSPROF_LOGI("call ideComponents Funcs destroy[%s] success", IdeGetCompontName(pos));
            }
        }

        g_ideComponentsFuncs.init[pos] = nullptr;
        g_ideComponentsFuncs.destroy[pos] = nullptr;
        g_ideComponentsFuncs.sockProcess[pos] = nullptr;
        g_ideComponentsFuncs.hdcProcess[pos] = nullptr;
    }
    return;
}

/**
 * @brief Create a working path, switch the working path, initialize the socket service
 *
 * @return
 *        IDE_DAEMON_OK: succ
 *        IDE_DAEMON_ERROR: failed
 */
int32_t DaemonInit()
{
    int32_t err = IdeDaemonSubInit();
    IDE_CTRL_VALUE_FAILED(err == IDE_DAEMON_OK, return err, "ide_Daemon_sub_init failed, err: %d", err);

    err = IdeComponentsInit();
    if (err != IDE_DAEMON_OK) {
        return IDE_DAEMON_ERROR;
    }

    MSPROF_LOGI("Daemon Init done");
    return IDE_DAEMON_OK;
}

/**
 * @brief destroy ide daemon context
 *
 * @return
 */
void DaemonDestroy()
{
    IdeComponentsDestroy();
    MSPROF_LOGI("Components Destroy success.");

    (void)mmSACleanup();
    MSPROF_LOGI("SACleanup success.");
    return;
}
