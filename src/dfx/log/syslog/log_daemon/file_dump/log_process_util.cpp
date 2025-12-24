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
namespace Adx {

STATIC int32_t CreateProcess(const char *fileName, const mmArgvEnv *env, mmProcess *id)
{
    if ((id == nullptr) || (fileName == nullptr)) {
        return EN_INVALID_PARAM;
    }
    pid_t child = fork();
    if (child == EN_ERROR) {
        return EN_ERROR;
    }
    if (child == MMPA_ZERO) {
        CHAR * const *  argv = nullptr;
        CHAR * const *  envp = nullptr;
        if (env != nullptr) {
            if (env->argv != nullptr) {
                argv = env->argv;
            }
            if (env->envp != nullptr) {
                envp = env->envp;
            }
        }
        if (execvpe(fileName, argv, envp) < MMPA_ZERO) {
            _exit(1);
        }
        // 退出,不会运行至此
    }
    *id = child;
    return EN_OK;
}

int32_t AdxCreateProcess(IdeString command)
{
    pid_t pid = 0;
    IdeString exe = "/bin/sh";
    IdeString sh = "sh";
    IdeString shArg = "-c";
    IdeStringBuffer argv[] = {const_cast<IdeStringBuffer>(sh), const_cast<IdeStringBuffer>(shArg),
        const_cast<IdeStringBuffer>(command), nullptr};
    IdeString envPath = "PATH=/usr/bin:/usr/sbin:/var";
    IdeStringBuffer envp[] = {const_cast<IdeStringBuffer>(envPath)};
    mmArgvEnv argvEnv;
    (void)memset_s(&argvEnv, sizeof(mmArgvEnv), 0, sizeof(mmArgvEnv));
    argvEnv.argv = const_cast<IdeStrBufAddrT>(argv);
    argvEnv.argvCount = sizeof(argv) / sizeof(argv[0]);
    argvEnv.envp = const_cast<IdeStrBufAddrT>(envp);
    argvEnv.envpCount = sizeof(envp) / sizeof(envp[0]);
    int32_t ret = CreateProcess(exe, &argvEnv, &pid);
    if (ret != EN_OK) {
        SELF_LOG_ERROR("CreateProcess failed ret=%d", ret);
        return SYS_ERROR;
    }
    int32_t waitStatus = 0;
    int32_t options = WUNTRACED; // if the child process goes into a paused state, return immediately
    ret = mmWaitPid(pid, &waitStatus, options);
    if (ret != EN_ERR) {
        SELF_LOG_ERROR("mmWaitPid failed ret=%d", ret);
        return SYS_ERROR;
    }
    return SYS_OK;
}
}
