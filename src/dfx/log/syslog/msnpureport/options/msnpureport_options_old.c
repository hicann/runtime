/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "msnpureport_options_old.h"
#include <stdbool.h>
#include "msnpureport_print.h"
#include "msn_operate_log_level.h"
#include "log_platform.h"
#include "log_common.h"
#include "mmpa_api.h"
#include "msnpureport_level.h"
#include "msnpureport_utils.h"
#include "msnpureport_report.h"

#define MAX_LOG_LEVEL_RESULT_LEN 1024
#define GET_LOG_LEVEL_STR "GetLogLevel"
#define EVENT_ENABLE "ENABLE"
#define EVENT_DISABLE "DISABLE"

typedef enum {
    RPT_ARGS_GLOABLE_LEVEL = 'g',
    RPT_ARGS_MODULE_LEVEL = 'm',
    RPT_ARGS_EVENT_LEVEL = 'e',
    RPT_ARGS_LOG_TYPE = 't',
    RPT_ARGS_DEVICE_ID = 'd',
    RPT_ARGS_REQUEST_LOG_LEVEL = 'r',
    RPT_ARGS_EXPORT_BBOX_LOGS_DEVICE_EVENT = 'a',
    RPT_ARGS_EXPORT_BBOX_LOGS_DEVICE_EVENT_MAINTENANCE_INFORMATION = 'f',
    RPT_ARGS_HELP = 'h',
    RPT_ARGS_DOCKER = 'D'
} UserArgsType;

typedef struct {
    char arg;
    int index;
} MsnArg;

#define DEFAULT_ARG_TYPES "g:m:e:t:d:rafh"
#define INVALID_ARG (-1)

const mmStructOption OPTS[] = {
    {"help",    MMPA_NO_ARGUMENT,       NULL, (int32_t)RPT_ARGS_HELP},
    {"global",  MMPA_REQUIRED_ARGUMENT, NULL, (int32_t)RPT_ARGS_GLOABLE_LEVEL},
    {"module",  MMPA_REQUIRED_ARGUMENT, NULL, (int32_t)RPT_ARGS_MODULE_LEVEL},
    {"event",   MMPA_REQUIRED_ARGUMENT, NULL, (int32_t)RPT_ARGS_EVENT_LEVEL},
    {"type",    MMPA_REQUIRED_ARGUMENT, NULL, (int32_t)RPT_ARGS_LOG_TYPE},
    {"device",  MMPA_REQUIRED_ARGUMENT, NULL, (int32_t)RPT_ARGS_DEVICE_ID},
    {"request", MMPA_NO_ARGUMENT,       NULL, (int32_t)RPT_ARGS_REQUEST_LOG_LEVEL},
    {"all",     MMPA_NO_ARGUMENT,       NULL, (int32_t)RPT_ARGS_EXPORT_BBOX_LOGS_DEVICE_EVENT},
    {"force",   MMPA_NO_ARGUMENT,       NULL, (int32_t)RPT_ARGS_EXPORT_BBOX_LOGS_DEVICE_EVENT_MAINTENANCE_INFORMATION},
    {"docker",  MMPA_NO_ARGUMENT,       NULL, (int32_t)RPT_ARGS_DOCKER},
    {NULL,      0,                      NULL, 0}
};

STATIC int SetGlobalLevel(ArgInfo *opts);
STATIC int SetModuleLevel(ArgInfo *opts);
STATIC int SetEventLevel(ArgInfo *opts);
STATIC int SetLogType(ArgInfo *opts);
STATIC int SetDeviceId(ArgInfo *opts);
STATIC int RequestLevel(ArgInfo *opts);
STATIC int ExportAllBboxLogs(ArgInfo *opts);
STATIC int ForceExportBboxLogs(ArgInfo *opts);
STATIC int GetHelpInfo(ArgInfo *opts);
STATIC int SetDockerFlag(ArgInfo *opts);

typedef int (*DataRetriver) (ArgInfo *opts);
static MsnArg g_msnArg[] = {{'g', 0}, {'m', 1}, {'e', 2}, {'t', 3}, {'d', 4}, {'r', 5}, {'a', 6}, {'f', 7}, {'h', 8},
                            {'D', 9}};

STATIC void OptionsUsage(void)
{
    (void)fprintf(stdout,
        "Recommend use new command, use 'msnpureport help' to get more information.\n"
        "Usage:\tmsnpureport\n"
        "  or:\tmsnpureport[OPTIONS]\n"
        "Example:\n"
        "\tmsnpureport                     Export all log and file.\n"
        "\tmsnpureport -a                  Export all log and file, device event information in the bbox\n"
        "\tmsnpureport -f                  Export all log and file, device event information in the bbox, "
            "historical maintenance and measurement information in the bbox\n"
        "\tmsnpureport -t 1                Export device log, include slog, message and system_info\n"
        "\tmsnpureport -g info             The device (which device id is 0) global log level options to info\n"
        "\tmsnpureport -m FMK:debug -d 1   The device (which device id is 1) FMK module log level options to debug\n"
        "\tmsnpureport -r                  Get log level\n"
        "Options:\n"
        "    --docker             Docker flag, msnpureport in docker must be explicitly used with this flag\n"
        "    -g, --global         Set device global log level: error, info, warning, debug, null\n"
        "    -m, --module         Set device module log level: error, info, warning, debug, null\n"
        "    -e, --event          Set device event log level: enable, disable\n"
        "    -t, --type           Export type: 0(all log and file, default is 0), 1(slog, message and system_info), "
            "2(bbox, current register), 3(stackcore), 4(vmcore), 5(module log)\n"
        "    -d, --device         Device ID, default is 0, can be used only with -g or -m or -e or -r\n"
        "    -r, --request        Get device log level\n"
        "    -a, --all            Export all log and file, device event information in the bbox\n"
        "    -f, --force          Export all log and file, device event information in the bbox, "
            "historical maintenance and measurement information in the bbox\n"
        "    -h, --help           Help information\n");
}

/**
 * @brief init opts->level by option values
 * @param [in] args: option values from cmdline input
 * @param [out] opts: structure to store option values
 * @return EN_OK/EN_ERROR
 */
STATIC int InitArgInfoLevel(ArgInfo *opts, const char *args, char *buff, uint32_t buffLen)
{
    MSNPU_CHK_NULL_PTR(args, return EN_ERROR);
    MSNPU_CHK_EXPR_CTRL(opts->cmdType != INVALID_CMD, return EN_ERROR,
                        "Only support one option: -g or -m or -e or -r or -a or -f, "
                        "you can execute '--help' for example value.");
    errno_t ret = strcpy_s(buff, buffLen, args);
    MSNPU_CHK_EXPR_CTRL(ret != EOK, return EN_ERROR, "The opts level(%s) init failed!", args);
    return EN_OK;
}

/**
 * @brief init opts->level by no parameter option
 * @param [out] opts: structure to store option values
 * @return EN_OK/EN_ERROR
 */
STATIC int32_t InitArgInfoLevelByNoParameterOption(ArgInfo *opts)
{
    MSNPU_CHK_NULL_PTR(opts, return EN_ERROR);
    MSNPU_CHK_EXPR_CTRL(opts->cmdType != INVALID_CMD, return EN_ERROR,
                        "Only support one option at a time: -g or -m or -e or -t or -r or -a or -f, "
                        "you can execute '--help' for example value.");
    return EN_OK;
}

/**
 * @brief convert the input string
 * @param [in/out] str: string
 * @return void
 */
STATIC int ToUpper(char *str)
{
    MSNPU_CHK_NULL_PTR(str, return EN_ERROR);
    char *ptr = str;
    while (*ptr != '\0') {
        if ((*ptr <= 'z') && (*ptr >= 'a')) {
            *ptr = (char)('A' - 'a') + *ptr;
        }
        ptr++;
    }
    return EN_OK;
}

/**
 * @brief check whether the global level of cmdline input valid
 * @param [in/out]levelStr: cmdline input level
 * @return EN_ERROR: invalid, EN_OK: valid
 */
STATIC int CheckGlobalLevel(char *levelStr, size_t len)
{
    MSNPU_CHK_NULL_PTR(levelStr, return EN_ERROR);
    MSNPU_CHK_EXPR_ACT(strlen(levelStr) >= len, return EN_ERROR);
    MSNPU_CHK_EXPR_ACT(ToUpper(levelStr) != EN_OK, return EN_ERROR);
    int32_t level = GetLevelIdByName(levelStr);
    MSNPU_CHK_EXPR_CTRL((level < LOG_MIN_LEVEL) || (level > LOG_MAX_LEVEL), return EN_ERROR,
                        "Global level is invalid, str=%s. You can execute '--help' for example value.", levelStr);
    return EN_OK;
}

/**
 * @brief check whether the module level and module name of cmdline input valid
 * @param [in/out]levelStr: cmdline input level
 * @return EN_ERROR: invalid, EN_OK: valid
 */
STATIC int CheckModuleLevel(char *levelStr, size_t len)
{
    MSNPU_CHK_NULL_PTR(levelStr, return EN_ERROR);
    MSNPU_CHK_EXPR_ACT(strlen(levelStr) >= len, return EN_ERROR);
    char modName[MAX_MODULE_NAME_LEN] = { 0 };
    char *pend = strchr(levelStr, ':');
    MSNPU_CHK_EXPR_CTRL(pend == NULL, return EN_ERROR, "Module level info has no ':', level_string=%s.", levelStr);
    int32_t retValue = memcpy_s(modName, MAX_MODULE_NAME_LEN, levelStr, (size_t)(pend - levelStr));
    MSNPU_CHK_EXPR_CTRL(retValue != EOK, return EN_ERROR, "Call memcpy_s failed, result=%d, strerr=%s.",
                        retValue, strerror(mmGetErrorCode()));
    MSNPU_CHK_EXPR_ACT(ToUpper(modName) != EN_OK, return EN_ERROR);
    const ModuleInfo *moduleInfo = GetModuleInfoByName((const char *)modName);
    MSNPU_CHK_EXPR_CTRL(moduleInfo == NULL, return EN_ERROR, "Module name does not exist, module=%s.", modName);

    pend += 1;
    MSNPU_CHK_EXPR_ACT(ToUpper(pend) != EN_OK, return EN_ERROR);
    int32_t level = GetLevelIdByName(pend);
    MSNPU_CHK_EXPR_CTRL((level < LOG_MIN_LEVEL) || (level > LOG_MAX_LEVEL), return EN_ERROR,
                        "Module level is invalid, level_string=%s.", pend);
    return EN_OK;
}

/**
 * @brief check whether the event level of cmdline input valid
 * @param [in/out]levelStr: cmdline input level
 * @return EN_ERROR: invalid, EN_OK: valid
 */
STATIC int CheckEventLevel(char *levelStr, size_t len)
{
    MSNPU_CHK_NULL_PTR(levelStr, return EN_ERROR);
    MSNPU_CHK_EXPR_ACT(strlen(levelStr) >= len, return EN_ERROR);
    MSNPU_CHK_EXPR_ACT(ToUpper(levelStr) != EN_OK, return EN_ERROR);
    int32_t levelValue = (strcmp(EVENT_ENABLE, levelStr) == 0) ? 1 : (strcmp(EVENT_DISABLE, levelStr) == 0 ? 0 : -1);
    MSNPU_CHK_EXPR_CTRL(levelValue == -1, return EN_ERROR, "Event level is invalid, level=%s.", levelStr);
    return EN_OK;
}

/**
 * @brief SetGlobalLevel
 * @param [in/out][in]opts: arg info
 * @return EN_ERROR: failed EN_OK: success
 */
STATIC int SetGlobalLevel(ArgInfo *opts)
{
    char buff[MAX_VALUE_STR_LEN] = { 0 };
    MSNPU_CHK_EXPR_ACT(InitArgInfoLevel(opts, mmGetOptArg(), buff, MAX_VALUE_STR_LEN) != EN_OK, return EN_ERROR);
    MSNPU_CHK_EXPR_CTRL(CheckGlobalLevel(buff, MAX_VALUE_STR_LEN) != EN_OK, return EN_ERROR,
                        "The level information is illegal, you can execute '--help' for example value.");
    opts->cmdType = CONFIG_SET;
    opts->subCmd = LOG_LEVEL;
    int32_t ret = 0;
    ret = sprintf_s(opts->value, MAX_VALUE_STR_LEN, "SetLogLevel(%d)[%s]", LOGLEVEL_GLOBAL, buff);
    ONE_ACT_ERR_LOG(ret < 0, return EN_ERROR, "Call sprintf_s failed for set global level.");
    return EN_OK;
}

/**
 * @brief SetModuleLevel
 * @param [in/out][in]opts: arg info
 * @return EN_ERROR: failed EN_OK: success
 */
STATIC int SetModuleLevel(ArgInfo *opts)
{
    char buff[MAX_VALUE_STR_LEN] = { 0 };
    MSNPU_CHK_EXPR_ACT(InitArgInfoLevel(opts, mmGetOptArg(), buff, MAX_VALUE_STR_LEN) != EN_OK, return EN_ERROR);
    MSNPU_CHK_EXPR_CTRL(CheckModuleLevel(buff, MAX_VALUE_STR_LEN) != EN_OK, return EN_ERROR,
                        "The level information is illegal, you can execute '--help' for example value.");
    opts->cmdType = CONFIG_SET;
    opts->subCmd = LOG_LEVEL;
    int32_t ret = 0;
    ret = sprintf_s(opts->value, MAX_VALUE_STR_LEN, "SetLogLevel(%d)[%s]", LOGLEVEL_MODULE, buff);
    ONE_ACT_ERR_LOG(ret < 0, return EN_ERROR, "Call sprintf_s failed for set module level.");
    return EN_OK;
}

/**
 * @brief SetEventLevel
 * @param [in/out][in]opts: arg info
 * @return EN_ERROR: failed EN_OK: success
 */
STATIC int SetEventLevel(ArgInfo *opts)
{
    char buff[MAX_VALUE_STR_LEN] = { 0 };
    MSNPU_CHK_EXPR_ACT(InitArgInfoLevel(opts, mmGetOptArg(), buff, MAX_VALUE_STR_LEN) != EN_OK, return EN_ERROR);
    MSNPU_CHK_EXPR_CTRL(CheckEventLevel(buff, MAX_VALUE_STR_LEN) != EN_OK, return EN_ERROR,
                        "The level information is illegal, you can execute '--help' for example value.");
    opts->cmdType = CONFIG_SET;
    opts->subCmd = LOG_LEVEL;
    int32_t ret = 0;
    ret = sprintf_s(opts->value, MAX_VALUE_STR_LEN, "SetLogLevel(%d)[%s]", LOGLEVEL_EVENT, buff);
    ONE_ACT_ERR_LOG(ret < 0, return EN_ERROR, "Call sprintf_s failed for set event level.");
    return EN_OK;
}

/**
 * @brief SetLogType
 * @param [in/out][in]opts: arg info
 * @return EN_ERROR: failed EN_OK: success
 */
STATIC int SetLogType(ArgInfo *opts)
{
    MSNPU_CHK_NULL_PTR(mmGetOptArg(), return EN_ERROR);
    MSNPU_CHK_EXPR_ACT(InitArgInfoLevelByNoParameterOption(opts) != EN_OK, return EN_ERROR);
    MSNPU_CHK_EXPR_CTRL(opts->deviceId != MAX_DEV_NUM, return EN_ERROR,
        "Option -t is used alone, no need to specify option -d.");
    const char *arg = mmGetOptArg();
    const char *typeStr[MAX_TYPE_NUM] = {"0", "1", "2", "3", "4", "5"}; // match to MsnLogType

    for (int32_t i = 0; i < MAX_TYPE_NUM; ++i) {
        if (strcmp(arg, typeStr[i]) == 0) {
            opts->cmdType = REPORT;
            opts->subCmd = REPORT_TYPE;
            opts->reportType = i;
            return EN_OK;
        }
    }
    MSNPU_ERR("The log type (%s) is illegal, you can execute '--help' for example value.", arg);
    return EN_ERROR;
}

/**
 * @brief SetDeviceId
 * @param [in/out][in]opts: arg info
 * @return EN_ERROR: failed EN_OK: success
 */
STATIC int32_t SetDeviceId(ArgInfo *opts)
{
    MSNPU_CHK_EXPR_CTRL(opts->cmdType == REPORT, return EN_ERROR,
        "Option -a, -f, -t is used alone, no need to specify option -d.");
    MSNPU_CHK_EXPR_CTRL(opts->deviceId != MAX_DEV_NUM, return EN_ERROR, "Input device id repeatedly.");
    MSNPU_CHK_NULL_PTR(mmGetOptArg(), return EN_ERROR);
    int64_t devId = -1;
    MSNPU_CHK_EXPR_CTRL(LogStrToInt(mmGetOptArg(), &devId) != LOG_SUCCESS, return EN_ERROR,
                        "Invalid device(%s), please execute '--help'.", mmGetOptArg());
    MSNPU_CHK_EXPR_CTRL((devId < 0) || (devId >= MAX_DEV_NUM), return EN_ERROR, "Input device out of range 0-63.");
    if (MsnCheckDeviceId((uint32_t)devId) != EN_OK) {
        MSNPU_ERR("Invalid device id %s.", mmGetOptArg());
        return EN_ERROR;
    }
    opts->deviceId = (uint16_t)devId;
    return EN_OK;
}

/**
 * @brief RequestLevel
 * @param [in/out][in]opts: arg info
 * @return EN_ERROR: failed EN_OK: success
 */
STATIC int RequestLevel(ArgInfo *opts)
{
    MSNPU_CHK_EXPR_ACT(InitArgInfoLevelByNoParameterOption(opts) != EN_OK, return EN_ERROR);
    opts->cmdType = CONFIG_GET;
    opts->subCmd = LOG_LEVEL;

    errno_t ret = strcpy_s(opts->value, MAX_VALUE_STR_LEN, GET_LOG_LEVEL_STR);
    ONE_ACT_ERR_LOG(ret != EOK, return EN_ERROR, "Call strcpy_s failed for get log level.");
    return EN_OK;
}

/**
 * @brief ExportAllBboxLogs
 * @param [in/out][in]opts: arg info
 * @return EN_ERROR: failed EN_OK: success
 */
STATIC int ExportAllBboxLogs(ArgInfo *opts)
{
    MSNPU_CHK_EXPR_CTRL(opts->deviceId != MAX_DEV_NUM, return EN_ERROR,
        "Option -a is used alone, no need to specify option -d.");
    MSNPU_CHK_EXPR_ACT(InitArgInfoLevelByNoParameterOption(opts) != EN_OK, return EN_ERROR);
    opts->cmdType = REPORT;
    opts->subCmd = REPORT_ALL;
    opts->reportType = (int32_t)ALL_LOG;
    return EN_OK;
}

/**
 * @brief ForceExportBboxLogs
 * @param [in/out][in]opts: arg info
 * @return EN_ERROR: failed EN_OK: success
 */
STATIC int ForceExportBboxLogs(ArgInfo *opts)
{
    MSNPU_CHK_EXPR_ACT(InitArgInfoLevelByNoParameterOption(opts) != EN_OK, return EN_ERROR);
    MSNPU_CHK_EXPR_CTRL(opts->deviceId != MAX_DEV_NUM, return EN_ERROR,
        "Option -f is used alone, no need to specify option -d.");
    opts->cmdType = REPORT;
    opts->subCmd = REPORT_FORCE;
    opts->reportType = (int32_t)ALL_LOG;
    return EN_OK;
}

/**
 * @brief GetHelpInfo
 * @param [in/out][in]opts: arg info
 * @return EN_ERROR: failed EN_OK: success
 */
STATIC int GetHelpInfo(ArgInfo *opts)
{
    (void)opts;
    OptionsUsage();
    return EN_INVALID_PARAM;
}

/**
 * @brief SetDockerFlag
 * @param [in/out][in]opts: arg info
 * @return EN_ERROR: failed EN_OK: success
 */
STATIC int SetDockerFlag(ArgInfo *opts)
{
    if (MsnIsDockerEnv()) {
        opts->dockerFlag = 1;
        return EN_OK;
    } else {
        MSNPU_ERR("--docker only used in docker env.");
        return EN_ERROR;
    }
}

/**
 * @brief  GetInputArg
 * @param [in/out][in]opts: return value of mmGetOptLong
 * @return arg
 */
static int GetInputArg(int opt)
{
    int len = sizeof(g_msnArg) / sizeof(g_msnArg[0]);
    int i = 0;
    for (; i < len; ++i) {
        if (opt == g_msnArg[i].arg) {
            return g_msnArg[i].index;
        }
    }
    return INVALID_ARG;
}

/**
 * @brief read option values from cmdline input
 * @param [in]argc: argument count
 * @param [in]argv: argument valuse
 * @param [out]opts:structure to store option values
 * @return EN_ERROR: failed EN_OK: success
 */
STATIC int GetOptions(int argc, char **argv, ArgInfo *opts)
{
    MSNPU_CHK_NULL_PTR(opts, return EN_ERROR);
    MSNPU_CHK_NULL_PTR(argv, return EN_ERROR);
    static DataRetriver dataRetriver[] = {SetGlobalLevel, SetModuleLevel, SetEventLevel, SetLogType, SetDeviceId,
                                          RequestLevel, ExportAllBboxLogs, ForceExportBboxLogs,
                                          GetHelpInfo, SetDockerFlag};
    int opt = mmGetOptLong(argc, argv, DEFAULT_ARG_TYPES, OPTS, NULL);
    if (opt == -1) {
        OptionsUsage();
        return EN_ERROR;
    }
    int ret = -1;
    while (opt != -1) {
        int arg = GetInputArg(opt);
        if (arg == INVALID_ARG) {
            OptionsUsage();
            return EN_INVALID_PARAM;
        }
        DataRetriver pRetriever = dataRetriver[arg];
        MSNPU_CHK_EXPR_CTRL(pRetriever == NULL, return EN_ERROR, "pRetriever is null.");

        ret = pRetriever(opts);
        MSNPU_CHK_EXPR_ACT(ret != EN_OK, return ret);

        opt = mmGetOptLong(argc, argv, DEFAULT_ARG_TYPES, OPTS, NULL);
    }

    if (MsnIsDockerEnv() && !(opts->dockerFlag != 0)) {
        MSNPU_ERR("msnpureport in docker should be used with --docker.");
        return EN_ERROR;
    }

    return EN_OK;
}

/**
 * @brief process command
 * @param [in]argInfo: command info
 * @return EN_OK: succ EN_ERROR: failed
 */
STATIC int RequestHandle(const ArgInfo *argInfo)
{
    // set or get device log level
    char logLevelResult[MAX_LOG_LEVEL_RESULT_LEN + 1] = { 0 };
    int32_t logLevelResultLength = MAX_LOG_LEVEL_RESULT_LEN + 1;
    int32_t ret = MsnOperateDeviceLogLevel(argInfo->deviceId, argInfo->value,
        logLevelResult, logLevelResultLength, (int32_t)argInfo->cmdType);
    if (ret != EN_OK) {
        if (strlen(logLevelResult) == 0) {
            char msg[] = "receive device level operation result failed";
            ret = strncpy_s(logLevelResult, (size_t)logLevelResultLength, msg, strlen(msg));
            MSNPU_CHK_EXPR_CTRL(ret != EOK, return EN_ERROR, "Strncpy_s device level operation result failed");
        }
        if (argInfo->cmdType == CONFIG_SET) {
            MSNPU_ERR("Result message=%s, you can execute 'msnpureport -r' to view the setting result.",
                logLevelResult);
        } else {
            MSNPU_ERR("Result message=%s.", logLevelResult);
        }
        return EN_ERROR;
    }

    if (argInfo->cmdType == CONFIG_GET) {
        MSNPU_INF("The system log level of device_id:%u is as follows:\n%s", argInfo->deviceId, logLevelResult);
    } else {
        MSNPU_INF("Set device log level success! log level string=%s, device id=%u.",
            argInfo->value, argInfo->deviceId);
    }
    return EN_OK;
}

int32_t MsnOptionsOld(int32_t argc, char **argv, ArgInfo *argInfo, bool *flag)
{
    argInfo->printMode = PRINT_STDOUT;
    argInfo->selfLogLevel = LOG_INFO;
    if (argc == 1) {        // without operation
        if (MsnIsDockerEnv()) {
            MSNPU_ERR("msnpureport in docker should be used with --docker.");
            return EN_ERROR;
        }
        argInfo->cmdType = REPORT;
        argInfo->subCmd = (uint32_t)REPORT_DEFAULT;
        argInfo->reportType = (int32_t)ALL_LOG;
        *flag = true;
        return EN_OK;
    }

    if (GetOptions(argc, argv, argInfo) != EN_OK) {
        return EN_ERROR;
    }

    if ((argInfo->cmdType == CONFIG_GET) || (argInfo->cmdType == CONFIG_SET)) {
        if (argInfo->deviceId == MAX_DEV_NUM) {
            argInfo->deviceId = 0;
        }
        *flag = false;
        if (optind < argc) {
            printf ("ERROR: Invalid option: ");
            while (optind < argc) {
                printf ("%s ", argv[optind++]);
            }
            putchar ('\n');
            return EN_ERROR;
        }
        (void)RequestHandle(argInfo);
        return EN_OK;
    }

    if ((argInfo->cmdType == INVALID_CMD) && (argInfo->deviceId != MAX_DEV_NUM)) {
        MSNPU_ERR("-d must use with -g or -m or -e or -r.");
        return EN_ERROR;
    }
    argInfo->cmdType = REPORT;
    *flag = true;
    return EN_OK;
}
