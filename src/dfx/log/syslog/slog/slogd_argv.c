/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "slogd_argv.h"
#include <getopt.h>
#include "log_level.h"
#include "log_print.h"
#include "log_pm.h"
#include "slogd_dev_mgr.h"

#define SLOGD_OPT "nhl:v:d"

static const struct option LONG_OPTIONS[] = {
    {"vfid", required_argument, NULL, 'v'},
    {"docker", no_argument, NULL, 'd'},
    {NULL, 0, NULL, 0}
};

STATIC void SlogdUsage(void) // no use in multi-thread
{
    (void)printf("Usage: slogd [OPTIONS]\n\n");
    (void)printf("  -n                      run in foreground\n");
    (void)printf("  -l N                    log only messages more urgent than prio N (1-4)\n");
    (void)printf("  -v N | --vfid N         id of vf (32-63)\n");
    (void)printf("  -d   | --docker         run in docker\n");
    (void)printf("  -h                      help\n");
}

/**
 * @brief       : parse argv and save to options
 * @param [in]  : argc         args num
 * @param [in]  : argv         args array
 * @param [out] : opt          options assigned to slogd
 * @return      : SYS_OK: succeed; SYS_ERROR: failed
 */
STATIC LogStatus ParseSlogdArgv(int32_t argc, char **argv, struct SlogdOptions *opt)
{
    int64_t optVal = -1;
    LogStatus ret = LOG_SUCCESS;
    int32_t opts = 0;
    while ((opts = getopt_long(argc, argv, SLOGD_OPT, LONG_OPTIONS, NULL)) != -1) {
        switch (opts) {
            case 'n':
                opt->n = 1;
                break;
            case 'l':
                if ((LogStrToInt(optarg, &optVal) != LOG_SUCCESS) ||
                    (optVal < LOG_MIN_LEVEL) || (optVal > LOG_MAX_LEVEL)) {
                    SELF_LOG_ERROR("level: %ld is not in range [0, 4].", optVal);
                    ret = LOG_FAILURE;
                    break;
                }
                opt->l = (int32_t)optVal;
                SELF_LOG_INFO("get level arg: %d", opt->l);
                break;
            case 'v':
                if ((LogStrToInt(optarg, &optVal) != LOG_SUCCESS) ||
                    (optVal < MIN_VFID_NUM) || (optVal > MAX_VFID_NUM)) {
                    SELF_LOG_ERROR("vfid: %ld is not in range [32, 63].", optVal);
                    ret = LOG_FAILURE;
                    break;
                }
                opt->v = (int32_t)optVal;
                SELF_LOG_INFO("get vfid arg: %d", opt->v);
                break;
            case 'd':
                opt->d = true;
                break;
            case 'h':
                SlogdUsage();
                ret = LOG_FAILURE;
                break;
            default:
                SELF_LOG_ERROR("parse slogd argv failed and quit slogd process.");
                SlogdUsage();
                ret = LOG_FAILURE;
                break;
        }
        ONE_ACT_NO_LOG(ret != LOG_SUCCESS, return ret);
    }
    return ret;
}

/**
 * @brief       : slogd init args from cmd
 * @param [in]  : argc         args num
 * @param [in]  : argv         args array
 * @param [out] : opt          options assigned to slogd
 * @return      : SYS_OK: success; SYS_ERROR: failed
 */
LogStatus SlogdInitArgs(int32_t argc, char **argv, struct SlogdOptions *opt)
{
    ONE_ACT_ERR_LOG((argc == 0) || (argv == NULL), return LOG_FAILURE, "no args in main and quit slogd process.");
    LogStatus ret = ParseSlogdArgv(argc, argv, opt);
    ONE_ACT_NO_LOG(ret != SYS_OK, return LOG_FAILURE);
    if ((opt->n == 0) && (LogSetDaemonize() != LOG_SUCCESS)) {
        SELF_LOG_ERROR("create daemon failed and quit slogd process.");
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

