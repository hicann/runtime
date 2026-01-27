/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ide_daemon_monitor.h"
#include <string>
#include "ide_common_util.h"
#include "appmon_lib.h"
#include "mmpa_api.h"
#include "thread.h"
#include "msprof_dlog.h"
#include "utils/utils.h"

using namespace analysis::dvvp::common::utils;
#ifdef PLATFORM_MONITOR

STATIC const std::string IDE_DAEMON_MONITOR = "ide_monitor";
STATIC const std::string IDE_DAEMON_REASON = "ide daemon monitor exit.";
#ifdef IDE_DAEMON_DEVICE
STATIC const std::string IDE_DAEMON_SCRIPT = "/var/ide_daemon_monitor.sh";
#else
STATIC const std::string IDE_DAEMON_SCRIPT = "driver/tools/ide_daemon_monitor.sh";
#endif
STATIC const int IDE_DEATH_DESC_LENGTH = 128;
STATIC const int MONITOR_REGISTER_WAIT_TIME = 1000;
STATIC const int MONITOR_HEARTBEAT_WAIT_TIME = 3000;
STATIC const int MONITOR_TIMEOUT = 9000;

enum IDE_MONITOR_STATUS {
    IDE_MONITOR_INIT = 0,
    IDE_MONITOR_RUNNING,
    IDE_MONITOR_HEARTBEAT,
    IDE_MONITOR_EXIT,
};

struct IdeMonitorMgr {
    int status;
    mmThread tid;
    client_info_t clnt;
};

STATIC struct IdeMonitorMgr g_ideMonitorMgr;

/*
 * @brief       : judge thread is runing or heartbeat status
 * @return      : yes:true; No:false
 */
STATIC bool IdeMonitorIsRun(void)
{
    return (g_ideMonitorMgr.status == IDE_MONITOR_RUNNING ||
            g_ideMonitorMgr.status == IDE_MONITOR_HEARTBEAT);
}

/*
 * @brief       : judge thread is processing heart beat
 * @return      : yes:true; No:false
 */
STATIC bool IdeMonitorIsHeartBeat(void)
{
    return (g_ideMonitorMgr.status == IDE_MONITOR_HEARTBEAT);
}

/*
 * @brief       : set monitor thread status
 * @param [in]  : int status        thread status
 * @return      : NA
 */
STATIC void IdeMonitorSetStatus(int status)
{
    g_ideMonitorMgr.status = status;
}

/*
 * @brief       : monitor thread, register to appmon, and process heart beat
 * @param [in]  : void *args    no use
 * @return      : nullptr
 */
STATIC IdeThreadArg IdeMonitorThread(IdeThreadArg args)
{
    UNUSED(args);
    MSPROF_LOGI("ide monitor thread start.");
    int ret = appmon_client_init(&g_ideMonitorMgr.clnt, APPMON_SERVER_PATH);
    if (ret != 0) {
        MSPROF_LOGE("app mon client init failed with %d", ret);
        return nullptr;
    }
    MSPROF_LOGI("app mon client init sucess.");
    IdeMonitorSetStatus(IDE_MONITOR_RUNNING);
    while (IdeMonitorIsRun() == true) {
        if (IdeMonitorIsHeartBeat() != true) {
            ret = appmon_client_register(&g_ideMonitorMgr.clnt, MONITOR_TIMEOUT, IDE_DAEMON_SCRIPT.c_str());
            if (ret != 0) {
                (void)mmSleep(MONITOR_REGISTER_WAIT_TIME);
                continue;
            }
            MSPROF_LOGI("app mon client register sucess.");
            IdeMonitorSetStatus(IDE_MONITOR_HEARTBEAT);
        }

        (void)appmon_client_heartbeat(&g_ideMonitorMgr.clnt);
        (void)mmSleep(MONITOR_HEARTBEAT_WAIT_TIME);
    }
    MSPROF_LOGI("ide monitor thread exit.");
    return nullptr;
}

/*
 * @brief       : stop thread, free resource
 * @return      : NA
 */
void IdeMonitorStop(void)
{
    if (IdeMonitorIsRun() == true) {
        if (IdeMonitorIsHeartBeat() == true) {
            (void)appmon_client_deregister(&g_ideMonitorMgr.clnt, IDE_DAEMON_REASON.c_str());
        }
        (void)appmon_client_exit(&g_ideMonitorMgr.clnt);
    }

    IdeMonitorSetStatus(IDE_MONITOR_EXIT);
}

/*
 * @brief       : init function
 * @return      : IDE_DAEMON_OK: succ
 *                IDE_DAEMON_ERROR: failed
 */
int IdeMonitorHostInit(void)
{
    mmUserBlock_t funcBlock;

    MSPROF_LOGI("ide daemon monitor thread starting...");
    IdeMonitorSetStatus(IDE_MONITOR_INIT);
    funcBlock.procFunc = IdeMonitorThread;
    funcBlock.pulArg = nullptr;
    mmThreadAttr threadAttr = IDE_DAEMON_DEFAULT_THREAD_ATTR;
    int ret = mmCreateTaskWithThreadAttr(&g_ideMonitorMgr.tid, &funcBlock, &threadAttr);
    if (ret != EN_OK) {
        MSPROF_LOGE("ide daemon monitor thread create failed(%d).", ret);
        return IDE_DAEMON_ERROR;
    }

    (void)mmSetThreadName(&g_ideMonitorMgr.tid, IDE_DAEMON_MONITOR.c_str());
    MSPROF_LOGI("ide daemon monitor thread started success.");
    return IDE_DAEMON_OK;
}

/*
 * @brief       : if init fail, call this
 * @return      : IDE_DAEMON_OK: succ
 *                IDE_DAEMON_ERROR: failed
 */
int IdeMonitorHostDestroy(void)
{
    int ret = 0;

    MSPROF_LOGI("ide daemon monitor thread stopping...");
    if (g_ideMonitorMgr.tid) {
        IdeMonitorStop();
        ret = mmJoinTask(&g_ideMonitorMgr.tid);
        g_ideMonitorMgr.tid = 0;
    }

    MSPROF_LOGI("ide daemon monitor thread stopped.");
    return ret;
}

#else
/*
 * @brief       : stub function, only cloud support
 * @return      : IDE_DAEMON_OK: succ
 */
int IdeMonitorHostInit(void)
{
    return IDE_DAEMON_OK;
}

/*
 * @brief       : stub function, only cloud support
 * @return      : IDE_DAEMON_OK: succ
 */
int IdeMonitorHostDestroy(void)
{
    return IDE_DAEMON_OK;
}
#endif // PLATFORM_MONITOR
