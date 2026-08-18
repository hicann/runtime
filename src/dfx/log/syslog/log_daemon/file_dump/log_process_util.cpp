/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_process_util.h"
#include "log_print.h"
#include "log_platform.h"
#include <spawn.h>
#include <sys/wait.h>
#include <fcntl.h>

namespace Adx {

static constexpr int32_t PIPE_FD_BUF_SIZE = 32;    // buffer size for pipe fd number string
static constexpr int32_t PIPE_FD_BUF_MAX_LEN = 31; // max write length for snprintf_s
static constexpr int32_t PIPE_READ_TIMEOUT = 3600; // read timeout in seconds for child guard

STATIC int32_t CreateProcess(const char* fileName, const mmArgvEnv* env, mmProcess* id, int pipefd[2])
{
    if ((id == nullptr) || (fileName == nullptr)) {
        return EN_INVALID_PARAM;
    }

    char* const* argv = nullptr;
    char* const* envp = nullptr;
    if (env != nullptr) {
        if (env->argv != nullptr) {
            argv = env->argv;
        }
        if (env->envp != nullptr) {
            envp = env->envp;
        }
    }

    posix_spawn_file_actions_t facts;
    (void)posix_spawn_file_actions_init(&facts);
    (void)posix_spawn_file_actions_adddup2(&facts, pipefd[0], pipefd[0]);
    (void)posix_spawn_file_actions_addclose(&facts, pipefd[1]);
    posix_spawnattr_t attrs;
    (void)posix_spawnattr_init(&attrs);
    (void)posix_spawnattr_setflags(&attrs, POSIX_SPAWN_SETPGROUP);
    (void)posix_spawnattr_setpgroup(&attrs, 0);
    pid_t pid = 0;
    int32_t ret = posix_spawn(&pid, fileName, &facts, &attrs, argv, envp);
    (void)posix_spawnattr_destroy(&attrs);
    (void)posix_spawn_file_actions_destroy(&facts);
    if (ret != 0) {
        SELF_LOG_ERROR("posix_spawn failed, ret=%d, errno=%d", ret, errno);
        return EN_ERROR;
    }
    *id = pid;
    return EN_OK;
}

int32_t AdxCreateProcess(IdeString command)
{
    int pipefd[2];
    if (pipe(pipefd) != 0) {
        SELF_LOG_ERROR("pipe failed, errno=%d", errno);
        return SYS_ERROR;
    }
    (void)fcntl(pipefd[1], F_SETFD, FD_CLOEXEC);

    pid_t pid = 0;
    IdeString exe = "/bin/sh";
    IdeString sh = "sh";
    IdeString shArg = "-c";
    char wrappedCmd[IDE_MAX_FILE_PATH] = {0};
    char rdup[PIPE_FD_BUF_SIZE] = {0};
    (void)snprintf_s(rdup, PIPE_FD_BUF_SIZE, PIPE_FD_BUF_MAX_LEN, "%d", pipefd[0]);
    (void)snprintf_s(
        wrappedCmd, IDE_MAX_FILE_PATH, IDE_MAX_FILE_PATH - 1, "{ read -t %d <&%s || kill -9 0; } & %s",
        PIPE_READ_TIMEOUT, rdup, command);
    IdeStringBuffer argv[] = {const_cast<IdeStringBuffer>(sh), const_cast<IdeStringBuffer>(shArg), wrappedCmd, nullptr};
    IdeString envPath = "PATH=/usr/bin:/usr/sbin:/var";
    IdeStringBuffer envp[] = {const_cast<IdeStringBuffer>(envPath), nullptr};
    mmArgvEnv argvEnv;
    (void)memset_s(&argvEnv, sizeof(mmArgvEnv), 0, sizeof(mmArgvEnv));
    argvEnv.argv = const_cast<IdeStrBufAddrT>(argv);
    argvEnv.argvCount = sizeof(argv) / sizeof(argv[0]);
    argvEnv.envp = const_cast<IdeStrBufAddrT>(envp);
    argvEnv.envpCount = sizeof(envp) / sizeof(envp[0]);
    int32_t ret = CreateProcess(exe, &argvEnv, &pid, pipefd);
    close(pipefd[0]);
    if (ret != EN_OK) {
        close(pipefd[1]);
        SELF_LOG_ERROR("CreateProcess failed ret=%d", ret);
        return SYS_ERROR;
    }
    int32_t waitStatus = 0;
    int32_t options = WUNTRACED; // if the child process goes into a paused state, return immediately
    ret = mmWaitPid(pid, &waitStatus, options);
    close(pipefd[1]);
    if (ret != EN_ERR) {
        SELF_LOG_ERROR("mmWaitPid failed ret=%d", ret);
        return SYS_ERROR;
    }
    return SYS_OK;
}
} // namespace Adx
