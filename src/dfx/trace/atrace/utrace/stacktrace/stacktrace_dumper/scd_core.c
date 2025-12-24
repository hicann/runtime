/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "scd_core.h"
#include "scd_process.h"
#include "scd_log.h"
#include "scd_util.h"
#include "stacktrace_err_code.h"

#define SCD_ARGC_NUM 2
#define SCD_SLEEP_INTERVAL      (100 * 1000) // ms
#define SCD_MAX_RETRY_TIME      10

STATIC TraStatus ScdWaitDirCreate(const char *dirPath)
{
    int32_t count = 0;
    while (access(dirPath, F_OK) != 0) {
        SCD_DLOG_DBG("directory path \"%s\" has not create, retry time=%d.", dirPath, count);
        count++;
        if (count > SCD_MAX_RETRY_TIME) {
            SCD_DLOG_ERR("directory path \"%s\" does not exist.", dirPath);
            return TRACE_FAILURE;
        }
        (void)usleep(SCD_SLEEP_INTERVAL); // 100ms
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus ScdInitLogCat(const ScdProcessArgs *args)
{
    TraStatus ret = StacktraceLogInit(STACKTRACE_LOG_TITLE_SUB);
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }

    StacktraceLogSetPath(args->filePath, args->fileName);
    return TRACE_SUCCESS;
}

STATIC void ScdReleaseLogCat(const ScdProcessArgs *args)
{
    if (args->handleType == SCD_DUMP_THREADS_TXT) {
        StackcoreLogSave();
    }
    StackcoreLogExit();
}

int32_t MAIN(int32_t argc, const char **argv)
{
    (void)argc;
    (void)argv;
    // parse args
    ScdProcessArgs args = {0};
    TraStatus ret = ScdUtilReadStdin((void *)&args, sizeof(ScdProcessArgs));
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("read args from stdin failed, ret=%d.", ret);
        return SCD_ERR_CODE_READ_STDIN;
    }

    // wait directory create
    ret = ScdWaitDirCreate(args.filePath);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("wait directory create failed, ret=%d.", ret);
        return SCD_ERR_CODE_WAIT_DIR;
    }

    ret = ScdInitLogCat(&args);
    if (ret != TRACE_SUCCESS) {
        SCD_DLOG_ERR("init log cat failed, ret=%d.", ret);
        return SCD_ERR_CODE_INIT_LOGCAT;
    }
    STACKTRACE_LOG_RUN("sub process start, pid=%d.", getpid());
    STACKTRACE_LOG_RUN("handle signal(%d) received by thread(%u).", args.signo, args.crashTid);
    ret = ScdProcessDump(&args);
    if (ret != TRACE_SUCCESS) {
        STACKTRACE_LOG_ERR("process dump failed, ret=%d.", ret);
        ScdReleaseLogCat(&args);
        return SCD_ERR_CODE_DUMP_INFO;
    }

    ScdReleaseLogCat(&args);
    return SCD_ERR_CODE_SUCCESS;
}