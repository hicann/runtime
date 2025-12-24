/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef STACKTRACE_COMMON_H
#define STACKTRACE_COMMON_H

#include <signal.h>
#include <stdint.h>

#define SIG_ATRACE          35
#define THREAD_NAME_LEN     16U
#define MAX_BIN_PATH_LEN    1024U
#define MAX_THREAD_NUM      1024U

#define SCD_MAX_NAME_HEAD_LEN       64U
#define SCD_MAX_FILENAME_LEN        128U
#define SCD_MAX_FILEDIR_LEN         255U
#define SCD_MAX_FILEPATH_LEN        (SCD_MAX_FILEDIR_LEN + SCD_MAX_NAME_HEAD_LEN)
#define SCD_MAX_FULLPATH_LEN        (SCD_MAX_FILEPATH_LEN + SCD_MAX_FILENAME_LEN)

/*
 * [parent process] ---fork---> [child process] ---execv---> [new process]
 * [parent process] application process which receive signal
 * [child process]  copy form "parent process", prepare to execute new program
 * [new process]    created by "child process" via execv, dumper stacktrace in this process
 */

typedef enum ScdDumpType {
    SCD_DUMP_THREADS_TXT,
    SCD_DUMP_THREADS_BIN,
    SCD_DUMP_THREAD_TXT,
    SCD_DUMP_THREAD_BIN,
} ScdDumpType;

// [child process] ---execv---> [new process]
typedef struct ScdProcessArgs {
    int32_t     pid;      // the crashing process
    int32_t     crashTid; // the crashing thread
    int32_t     signo;
    uint64_t    crashTime;
    uintptr_t   stackBaseAddr;
    siginfo_t   si;
    ucontext_t  uc;
    char        filePath[SCD_MAX_FILEPATH_LEN + 1U];
    char        fileName[SCD_MAX_FILENAME_LEN + 1U];
    ScdDumpType handleType;
} ScdProcessArgs;

// [parent process] ---fork---> [child process]
typedef struct {
    int32_t     pid;  // the crashing process
    int32_t     tid;  // the crashing thread
    int32_t     signo;
    uint64_t    crashTime;
    uintptr_t   stackBaseAddr;
    siginfo_t   siginfo;
    ucontext_t  ucontext;
    char        filePath[SCD_MAX_FILEPATH_LEN + 1U];
    char        fileName[SCD_MAX_FILENAME_LEN + 1U];
    char        exePath[MAX_BIN_PATH_LEN];
} ThreadArgument;

#endif