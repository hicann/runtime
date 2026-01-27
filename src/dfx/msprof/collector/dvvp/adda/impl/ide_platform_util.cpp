/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ide_platform_util.h"
#include <pwd.h>
#include "ide_common_util.h"
#include "adx_config.h"
#include "msprof_dlog.h"

using namespace IdeDaemon::Common::Config;
using namespace Analysis::Dvvp::Adx;
namespace Adx {
/**
 * @brief ide read data, support socket and hdc
 * @param handle: socket handle or hdc session
 * @param read_buf: received buffer
 * @param read_len: the length of received buffer
 *
 * @return
 *        IDE_DAEMON_OK: succ
 *        IDE_DAEMON_ERROR: failed
 */
int32_t IdeRead(const struct IdeTransChannel &handle, IdeRecvBuffT readBuf, IdeI32Pt readLen, int32_t flag)
{
    int32_t err;
    if (readBuf == nullptr || readLen == nullptr) {
        return IDE_DAEMON_ERROR;
    }

    if (flag == IDE_DAEMON_BLOCK) {
        err = HdcRead(handle.session, readBuf, readLen);
    } else {
        const int32_t retryTimeMax = 142; // 10s (1+2+...+142)ms
        int32_t retrySleepTime = 1;
        while (1) {
            err = HdcReadNb(handle.session, readBuf, readLen);
            if (err == IDE_DAEMON_RECV_NODATA) {
                mmSleep(retrySleepTime);
                retrySleepTime++;
            } else {
                return err;
            }
            if (retrySleepTime >= retryTimeMax) {
                MSPROF_LOGW("no received request in %d times", retrySleepTime);
                err = IDE_DAEMON_ERROR;
                break;
            }
        }
    }
    return err;
}

/**
 * @brief process command
 * @param cmd_info: command info
 *
 * @return
 *        IDE_DAEMON_OK: succ
 *        IDE_DAEMON_ERROR: failed
 */
pid_t IdeFork(void)
{
    return fork();
}


/**
 * @brief provides control for (file) descriptors.
 * @param fd: file descriptors
 * @param cmd: F_GETFD/F_SETFD, see fcntl for details
 * @param arg: arguments for file descriptors
 *
 * @return
 *        IDE_DAEMON_OK: succ
 *        IDE_DAEMON_ERROR: failed
 */
int32_t IdeFcntl(int32_t fd, int32_t cmd, long arg)
{
    return fcntl(fd, cmd, arg);
}

/**
 * @brief provides control for (file) descriptors.
 * @param fd: file descriptors
 * @param cmd: F_GETLK/F_SETLK, see fcntl for details
 * @param lock: arguments for file Lock descriptors
 *
 * @return
 *        0: succ
 *        low 0: failed
 */
int32_t IdeLockFcntl(int32_t fd, int32_t cmd, const struct flock &lock)
{
    return fcntl(fd, cmd, &lock);
}

/**
 * @brief get homedir
 *
 * @return
 *        string: home directory
 */
std::string IdeGetHomeDir()
{
    struct passwd *pw = getpwuid(getuid());
    if (pw != nullptr && pw->pw_dir != nullptr && strlen(pw->pw_dir) > 0 &&
        strlen(pw->pw_dir) < MMPA_MAX_PATH) {
        return pw->pw_dir;
    }

    return "";
}

/**
 * @brief remove the file
 * @param file:file path
 *
 * @return
 *        IDE_DAEMON_OK: succ
 *        IDE_DAEMON_ERROR: failed
 */
int32_t IdeRealFileRemove(IdeString file)
{
    if (file == nullptr || strlen(file) == 0) {
        return IDE_DAEMON_ERROR;
    }

    IdeStringBuffer actualPath = reinterpret_cast<IdeStringBuffer>(IdeXmalloc(MMPA_MAX_PATH));
    if (actualPath == nullptr) {
        MSPROF_LOGE("IdeXmalloc failed");
        return IDE_DAEMON_ERROR;
    }
    std::string path = IdeDaemon::Common::Utils::ReplaceWaveToHomeDir(file);
    int32_t ret = mmRealPath(path.c_str(), actualPath, MMPA_MAX_PATH);
    if (ret != EN_OK) {
        IDE_XFREE_AND_SET_NULL(actualPath);
        return IDE_DAEMON_OK;
    }
    ret = remove(actualPath);
    if (ret != 0) {
        MSPROF_LOGD("remove %s exit code %d", actualPath, ret);
    }
    IDE_XFREE_AND_SET_NULL(actualPath);
    return IDE_DAEMON_OK;
}
}
