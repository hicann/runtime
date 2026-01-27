/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adx_config.h"
#include "ide_common_util.h"
#include "ide_task_register.h"
#include "msprof_dlog.h"
#include "impl_utils.h"
#include "utils/utils.h"

#ifdef IAM
#include "iam.h"
#endif

using namespace IdeDaemon::Common::Config;
using namespace Adx;

/**
 * @berif : start single Process
 * @param : none
 * @return: open file fd
 */
STATIC int32_t SingleProcessStart(std::string &lockInfo)
{
    const int32_t fileMaskWc = 0600;
    lockInfo = IdeGetHomeDir() + "/ide_daemon/";
    analysis::dvvp::common::utils::Utils::CreateDir(lockInfo);
    lockInfo.append(".");
    lockInfo.append(IDE_DAEMON_NAME);
    lockInfo.append(".lock");
    int32_t fd = mmOpen2(lockInfo.c_str(), O_WRONLY | O_CREAT, fileMaskWc);
    if (fd < 0) {
        MSPROF_LOGE("single process open %s fd = %d", lockInfo.c_str(), fd);
        return IDE_DAEMON_ERROR;
    }

    struct flock lock;
    (void)memset_s(&lock, sizeof(lock), 0, sizeof(lock));
    lock.l_type = F_WRLCK;
    lock.l_start = 0;
    lock.l_whence = SEEK_SET;
    lock.l_len = 0;
    int32_t ret = IdeLockFcntl(fd, F_SETLK, lock);
    if (ret < 0) {
        MSPROF_LOGE("ada is exist, don't start again");
        printf("ada is exist, don't start again\n");
        IDE_MMCLOSE_AND_SET_INVALID(fd);
        // other process has locked the file, must not remove the file
        return IDE_DAEMON_ERROR;
    }

    int32_t val = IdeFcntl(fd, F_GETFD, 0);
    if (val < 0) {
        MSPROF_LOGE("single process fcntl get fd");
        IDE_MMCLOSE_AND_SET_INVALID(fd);
        return IDE_DAEMON_ERROR;
    }

    auto flag = static_cast<uint32_t>(val);
    flag |= FD_CLOEXEC;
    if (IdeFcntl(fd, F_SETFD, flag) < 0) {
        MSPROF_LOGE("single process fcntl set fd");
        IDE_MMCLOSE_AND_SET_INVALID(fd);
        return IDE_DAEMON_ERROR;
    }
    return fd;
}

STATIC int32_t AdxStartUpInit()
{
    // register daemon modules
    IdeDaemonRegisterModules();
    // DaemonInit function
    if (DaemonInit() != IDE_DAEMON_OK) {
        MSPROF_LOGE("ada init failed, exit");
        printf("ada init failed, exit\n");
        return IDE_DAEMON_ERROR;
    }
    // handle request
    HdcCreateHdcServerProc(nullptr);
    return IDE_DAEMON_OK;
}

/**
 * @berif : start ide daemon
 * @param : [in]isFork: if fork child process or not
 * @return: IDE_DAEMON_ERROR(-1) : failed
 *          IDE_DAEMON_ERROR(0) : success
 */
STATIC int32_t IdeDaemonStartUp()
{
#ifdef IAM
    if (IAMResMgrReady() != IDE_DAEMON_OK) {
        MSPROF_LOGE("IAMResMgrReady failed.");
        return IDE_DAEMON_ERROR;
    }
#endif
    mmUmask(IdeDaemon::Common::Config::SPECIAL_UMASK);
    std::string pidLockFile;
    int32_t fd = SingleProcessStart(pidLockFile);
    if (fd < 0) {
        MSPROF_LOGE("single process start error");
        (void)IdeRealFileRemove(pidLockFile.c_str());
        return IDE_DAEMON_ERROR;
    }

    dlog_init(); // notify slogd that pid was changed
    LogAttr logAttr = {};
    logAttr.type = SYSTEM;
    logAttr.pid = 0;
    logAttr.deviceId = 0;
    if (DlogSetAttr(logAttr) != IDE_DAEMON_OK) {
        MSPROF_LOGW("Unable to set log attribute.");
    }

    int32_t err = AdxStartUpInit();
    // destroy daemon
    DaemonDestroy();
    IDE_MMCLOSE_AND_SET_INVALID(fd);
    (void)IdeRealFileRemove(pidLockFile.c_str());
    MSPROF_LOGI("ada start up exit");
    return err;
}

#if defined(__IDE_UT) || defined(__IDE_ST)
int32_t IdeDaemonTestMain(int32_t argc, IdeStringBuffer argv[])
#else
int32_t main(int32_t /* argc */, IdeStrBufAddrT /* argv[] */)
#endif
{
    return IdeDaemonStartUp();
}

