/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "msnpureport_options.h"
#include "mmpa_api.h"
#include "adcore_api.h"
#include "log_common.h"
#include "msnpureport_print.h"
#include "msnpureport_config.h"
#include "msnpureport_utils.h"
#include "msnpureport_level.h"
#include "msnpureport_report.h"
#include "msnpureport_common.h"
#include "msnpureport_options_old.h"

#define CONFIG_STR "config"
#define REPORT_STR "report"
#define HELP_STR "help"
#define VERSION_STR "version"
#define MSNPUREPORT_VERSION "1.2.1"
#define ENABLE_STR "ENABLE"
#define DISABLE_STR "DISABLE"
#define RESET_COREID_FLAG "0xFFFF"
#define STE_LOG_LEVEL_HEAD "SetLogLevel"
#define NUMBER_STR_LEN 64

enum ConfigArgType {
    CONFIG_ARGS_DOCKER = 0,
    CONFIG_ARGS_GET = 1,
    CONFIG_ARGS_SET = 2,
    CONFIG_ARGS_ICACHE_CHECK = 3,
    CONFIG_ARGS_ACCELERATOR_RECOVER = 4,
    CONFIG_ARGS_AIC_SWITCH = 5,
    CONFIG_ARGS_AIV_SWITCH = 6,
    CONFIG_ARGS_SINGLE_COMMIT = 7,
    CONFIG_ARGS_CORE_ID = 8,
    CONFIG_ARGS_LOG_LEVEL = 9,
    CONFIG_ARGS_GLOBAL_LEVEL = 'g',
    CONFIG_ARGS_MODULE_LEVEL = 'm',
    CONFIG_ARGS_EVENT_LEVEL = 'e',
    CONFIG_ARGS_DEVICE = 'd',
    CONFIG_ARGS_HELP = 'h',
};

#define CONFIG_OPT "g:m:e:d:h"

static const mmStructOption CONFIG_OPTS[] = {
    {"docker",              MMPA_NO_ARGUMENT,       NULL, CONFIG_ARGS_DOCKER},
    {"set",                 MMPA_NO_ARGUMENT,       NULL, CONFIG_ARGS_SET},
    {"get",                 MMPA_NO_ARGUMENT,       NULL, CONFIG_ARGS_GET},
    {"icachecheck",         MMPA_REQUIRED_ARGUMENT, NULL, CONFIG_ARGS_ICACHE_CHECK},
    {"accelerator_recover", MMPA_REQUIRED_ARGUMENT, NULL, CONFIG_ARGS_ACCELERATOR_RECOVER},
    {"aic_switch",          MMPA_REQUIRED_ARGUMENT, NULL, CONFIG_ARGS_AIC_SWITCH},
    {"aiv_switch",          MMPA_REQUIRED_ARGUMENT, NULL, CONFIG_ARGS_AIV_SWITCH},
    {"singlecommit",        MMPA_REQUIRED_ARGUMENT, NULL, CONFIG_ARGS_SINGLE_COMMIT},
    {"coreid",              MMPA_REQUIRED_ARGUMENT, NULL, CONFIG_ARGS_CORE_ID},
    {"log",                 MMPA_NO_ARGUMENT,       NULL, CONFIG_ARGS_LOG_LEVEL},
    {"global",              MMPA_REQUIRED_ARGUMENT, NULL, CONFIG_ARGS_GLOBAL_LEVEL},
    {"module",              MMPA_REQUIRED_ARGUMENT, NULL, CONFIG_ARGS_MODULE_LEVEL},
    {"event",               MMPA_REQUIRED_ARGUMENT, NULL, CONFIG_ARGS_EVENT_LEVEL},
    {"device",              MMPA_REQUIRED_ARGUMENT, NULL, CONFIG_ARGS_DEVICE},
    {"help",                MMPA_NO_ARGUMENT,       NULL, CONFIG_ARGS_HELP},
    {NULL,                  0,                      NULL, 0}
};

enum ReportArgType {
    REPORT_ARGS_DOCKER = 0,
    REPORT_ARGS_PRINT = 1,
    REPORT_ARGS_MSN_LOG_LEVEL = 2,
    REPORT_ARGS_PERMANENT,
    REPORT_ARGS_SYS_LOG_NUM,
    REPORT_ARGS_SYS_LOG_SIZE,
    REPORT_ARGS_FW_LOG_NUM,
    REPORT_ARGS_FW_LOG_SIZE,
    REPORT_ARGS_EVENT_LOG_NUM,
    REPORT_ARGS_EVENT_LOG_SIZE,
    REPORT_ARGS_SEC_LOG_NUM,
    REPORT_ARGS_SEC_LOG_SIZE,
    REPORT_ARGS_STACKCORE_NUM,
    REPORT_ARGS_FAULT_EVENT_NUM,
    REPORT_ARGS_BBOX_NUM,
    REPORT_ARGS_SLOGD_LOG_NUM,
    REPORT_ARGS_DEVICE_APP_DIR_NUM,
    REPORT_ARGS_REPORT_ALL = 'a',
    REPORT_ARGS_DEVICE = 'd',
    REPORT_ARGS_REPORT_TYPE = 't',
    REPORT_ARGS_REPORT_FORCE = 'f',
    REPORT_ARGS_REPORT_HELP = 'h',
};

#define REPORT_OPT "t:afhd:"

STATIC mmStructOption g_reportOptions[] = {
    {"docker",          MMPA_NO_ARGUMENT,       NULL, REPORT_ARGS_DOCKER},
    {"all",             MMPA_NO_ARGUMENT,       NULL, REPORT_ARGS_REPORT_ALL},
    {"type",            MMPA_REQUIRED_ARGUMENT, NULL, REPORT_ARGS_REPORT_TYPE},
    {"force",           MMPA_NO_ARGUMENT,       NULL, REPORT_ARGS_REPORT_FORCE},
    {"print",           MMPA_REQUIRED_ARGUMENT, NULL, REPORT_ARGS_PRINT},
    {"log_level",       MMPA_REQUIRED_ARGUMENT, NULL, REPORT_ARGS_MSN_LOG_LEVEL},
    {"device",          MMPA_REQUIRED_ARGUMENT, NULL, REPORT_ARGS_DEVICE},
    {"help",            MMPA_NO_ARGUMENT,       NULL, REPORT_ARGS_REPORT_HELP},
    {"permanent",       MMPA_NO_ARGUMENT,       NULL, REPORT_ARGS_PERMANENT},
    {"sys_log_num",     MMPA_REQUIRED_ARGUMENT, NULL, REPORT_ARGS_SYS_LOG_NUM},
    {"sys_log_size",    MMPA_REQUIRED_ARGUMENT, NULL, REPORT_ARGS_SYS_LOG_SIZE},
    {"fw_log_num",      MMPA_REQUIRED_ARGUMENT, NULL, REPORT_ARGS_FW_LOG_NUM},
    {"fw_log_size",     MMPA_REQUIRED_ARGUMENT, NULL, REPORT_ARGS_FW_LOG_SIZE},
    {"event_log_num",   MMPA_REQUIRED_ARGUMENT, NULL, REPORT_ARGS_EVENT_LOG_NUM},
    {"event_log_size",  MMPA_REQUIRED_ARGUMENT, NULL, REPORT_ARGS_EVENT_LOG_SIZE},
    {"sec_log_num",     MMPA_REQUIRED_ARGUMENT, NULL, REPORT_ARGS_SEC_LOG_NUM},
    {"sec_log_size",    MMPA_REQUIRED_ARGUMENT, NULL, REPORT_ARGS_SEC_LOG_SIZE},
    {"stackcore_num",   MMPA_REQUIRED_ARGUMENT, NULL, REPORT_ARGS_STACKCORE_NUM},
    {"fault_event_num", MMPA_REQUIRED_ARGUMENT, NULL, REPORT_ARGS_FAULT_EVENT_NUM},
    {"bbox_num",        MMPA_REQUIRED_ARGUMENT, NULL, REPORT_ARGS_BBOX_NUM},
    {"slogd_log_num",   MMPA_REQUIRED_ARGUMENT, NULL, REPORT_ARGS_SLOGD_LOG_NUM},
    {"app_dir_num",     MMPA_REQUIRED_ARGUMENT, NULL, REPORT_ARGS_DEVICE_APP_DIR_NUM},
    {NULL,              0,                      NULL, 0}
};

// [min, max, default]
#define MIN_INDEX 0
#define MAX_INDEX 1
#define DEFAULT_INDEX 2
const int32_t PERMANENT_ARGS_RANGE[REPORT_ARGS_DEVICE_APP_DIR_NUM + 1][3] = {
    [REPORT_ARGS_SYS_LOG_NUM] = {1, 1000, 10},
    [REPORT_ARGS_SYS_LOG_SIZE] = {1, 100, 10},
    [REPORT_ARGS_FW_LOG_NUM] = {1, 1000, 10},
    [REPORT_ARGS_FW_LOG_SIZE] = {1, 100, 10},
    [REPORT_ARGS_EVENT_LOG_NUM] = {1, 1000, 10},
    [REPORT_ARGS_EVENT_LOG_SIZE] = {1, 100, 10},
    [REPORT_ARGS_SEC_LOG_NUM] = {1, 1000, 10},
    [REPORT_ARGS_SEC_LOG_SIZE] = {1, 100, 10},
    [REPORT_ARGS_STACKCORE_NUM] = {1, 100, 50},
    [REPORT_ARGS_FAULT_EVENT_NUM] = {1, 100, 10},
    [REPORT_ARGS_BBOX_NUM] = {1, 10000, 1000},
    [REPORT_ARGS_SLOGD_LOG_NUM] = {1, 100, 2},
    [REPORT_ARGS_DEVICE_APP_DIR_NUM] = {1, 100, 8},
};

const char *g_permanentHelpMsg[REPORT_ARGS_DEVICE_APP_DIR_NUM + 1] = {
    [REPORT_ARGS_SYS_LOG_NUM] =  "    --sys_log_num        Set max syslog file num",
    [REPORT_ARGS_SYS_LOG_SIZE] =  "    --sys_log_size       Set max syslog file size, unit Mb",
    [REPORT_ARGS_FW_LOG_NUM] =  "    --fw_log_num         Set max firmware log file num",
    [REPORT_ARGS_FW_LOG_SIZE] =  "    --fw_log_size        Set max firmware log file size, unit Mb",
    [REPORT_ARGS_EVENT_LOG_NUM] =  "    --event_log_num      Set max event log file num",
    [REPORT_ARGS_EVENT_LOG_SIZE] =  "    --event_log_size     Set max event log file size, unit Mb",
    [REPORT_ARGS_SEC_LOG_NUM] =  "    --sec_log_num        Set max security log file num",
    [REPORT_ARGS_SEC_LOG_SIZE] =  "    --sec_log_size       Set max security log file size, unit Mb",
    [REPORT_ARGS_STACKCORE_NUM] = "    --stackcore_num      Set max stackcore file num",
    [REPORT_ARGS_FAULT_EVENT_NUM] =  "    --fault_event_num    Set max fault event directory num",
    [REPORT_ARGS_BBOX_NUM] =  "    --bbox_num           Set max bbox event directory num",
    [REPORT_ARGS_SLOGD_LOG_NUM] =  "    --slogd_log_num      Set max slogdlog file num",
    [REPORT_ARGS_DEVICE_APP_DIR_NUM] =  "    --app_dir_num        Set max device app directory num",
};

STATIC void MsnPrintHelp(void)
{
    (void)fprintf(stdout,
        "Usage: msnpureport <subcommand> [OPTIONS]\n"
        "subcommand:\n"
        "   config               configure settings and queries\n"
        "   report               get device log\n"
        "   help                 get help information\n"
        "   version              get version information\n\n"
        "get options information by msnpureport <subcommand> --help\n"
        "Example:\n"
        "\tmsnpureport config --help\n");
}

STATIC void MsnPrintConfigHelp(void)
{
    (void)fprintf(stdout,
        "Usage: msnpureport config (--get | --set) [OPTIONS]\n"
        "Example:\n"
        "\tmsnpureport config --get --device 0                           Get device 0 configure\n"
        "\tmsnpureport config --set --icachecheck 256 --device 0         Set device 0 icahce check range 256KB "
        "before and after the PC pointer\n"
        "\tmsnpureport config --set --aic_switch 0 --coreid 1,2 -d 0     Disable the aicore whose core id is 1 and 2\n"
        "\tmsnpureport config --set --aic_switch 1 --coreid 0xFFFF -d 0  Enable device 0 all ai vector core\n"
        "\tmsnpureport config --set --log --global info -d 0             Set device 0 global log level to info\n"
        "\tmsnpureport config --set --log --module FMK:debug -d 1        Set device 1 FMK module log level to debug\n"
        "Options:\n"
        "    --docker                     Docker flag, msnpureport in docker must be explicitly used with this flag\n"
        "    -d, --device                 Device ID, default is 0\n"
        "    -h, --help                   Help\n"
        "\nGet device configurations:\n"
        "    --get                        Get device configurations flag\n"
        "\nSet device configurations:\n"
        "    --set                        Set device configurations flag, "
        "the following options must be entered after this flag\n"
        "    --icachecheck                Set device icache check range, unit KB, max value:%u\n"
        "    --accelerator_recover {0|1}  Set TS accelerator auto recover(1) or not(0)\n"
        "    --singlecommit {0|1}         Set enable(1) or disable(0) aic singlecommit mode\n"
        "    --aic_switch {0|1}           Use with '--coreid' to disable(0) or enable(1) ai core\n"
        "    --aiv_switch {0|1}           Use with '--coreid' to disable(0) or enable(1) ai vector core\n"
        "    --coreid                     Use with '--aic_switch' or '--aiv_switch' to select core id, "
        "maximum of 4 values can be entered at the same time\n"
        "                                 Specially, input '0xFFFF' means all core(only support enable)\n"
        "\nSet device log level:\n"
        "    --log                        Set log level flag, "
        "the following options must be entered after '--set' and this flag\n"
        "    -g, --global                 Set global log level, option: error, info, warning, debug, null\n"
        "    -m, --module                 Set module log level, option: error, info, warning, debug, null\n"
        "    -e, --event                  Set event log level, option: enable, disable\n",
        MAX_ICACHE_CHECK_RANGE
    );
}

static int32_t MsnOptionGetValueInRange(const char *arg, const char *option, int64_t *value, int32_t min, int32_t max)
{
    int64_t num = -1;
    if (LogStrToInt(arg, &num) != LOG_SUCCESS) {
        MSNPU_PRINT_ERROR("Invalid value '%s' for --%s , please input a number in range[%d-%d].",
            arg, option, min, max);
        return EN_ERROR;
    }
    char tmp[NUMBER_STR_LEN] = {0};
    int32_t ret = sprintf_s(tmp, NUMBER_STR_LEN, "%ld", num);
    if (ret < 0) {
        SELF_LOG_ERROR("call sprintf failed.");
        return EN_ERROR;
    }
    if (strcmp(arg, tmp) != 0) {
        MSNPU_PRINT_ERROR("Invalid value '%s' for --%s", arg, option);
        return EN_ERROR;
    }
    if ((num < min) || num > max) {
        MSNPU_PRINT_ERROR("Invalid value '%s' for --%s, please input in range [%d-%d].", arg, option, min, max);
        return EN_ERROR;
    }

    *value = num;
    return EN_OK;
}

STATIC int32_t MsnSetDeviceId(ArgInfo *argInfo, const char *arg)
{
    ONE_ACT_ERR_LOG(arg == NULL, return EN_ERROR, "arg is NULL.");
    if (argInfo->deviceId != MAX_DEV_NUM) {
        MSNPU_PRINT_ERROR("Input device id repeatedly.");
        return EN_ERROR;
    }
    int64_t num = -1;
    if (MsnOptionGetValueInRange(arg, "device", &num, 0, MAX_DEV_NUM - 1) != EN_OK) {
        return EN_ERROR;
    }

    if (MsnCheckDeviceId((uint32_t)num) != EN_OK) {
        MSNPU_PRINT_ERROR("Input device id %s invalid.", arg);
        return EN_ERROR;
    }

    argInfo->deviceId = (uint16_t)num;
    return EN_OK;
}

STATIC int32_t MsnSetIcacheRange(ArgInfo *argInfo, const char *arg)
{
    if (argInfo->subCmd != INVALID_TYPE) {
        MSNPU_PRINT_ERROR("Only one command is supported at a time.");
        return EN_ERROR;
    }
    int64_t num = -1;
    if (MsnOptionGetValueInRange(arg, "icachecheck", &num, 0, MAX_ICACHE_CHECK_RANGE) != EN_OK) {
        return EN_ERROR;
    }

    DfxCommon *commonInfo = (DfxCommon *)argInfo->value;
    commonInfo->value = (uint32_t)num;

    argInfo->valueLen = (uint16_t)sizeof(DfxCommon);
    argInfo->subCmd = (uint32_t)ICACHE_RANGE;
    return EN_OK;
}

STATIC int32_t MsnSetAcceleratorRecover(ArgInfo *argInfo, const char *arg)
{
    if (argInfo->subCmd != INVALID_TYPE) {
        MSNPU_PRINT_ERROR("Only one command is supported at a time.");
        return EN_ERROR;
    }
    DfxCommon *commonInfo = (DfxCommon *)argInfo->value;
    if (strcmp(arg, "0") == 0) {
        commonInfo->value = 0;
    } else if (strcmp(arg, "1") == 0) {
        commonInfo->value = 1;
    } else {
        MSNPU_PRINT_ERROR("Input --accelerator_recover %s invalid, please input 0 or 1.", arg);
        return EN_ERROR;
    }
    argInfo->valueLen = (uint16_t)sizeof(DfxCommon);
    argInfo->subCmd = (uint32_t)ACCELERATOR_RECOVER;
    return EN_OK;
}

STATIC int32_t MsnSetCoreSwitch(ArgInfo *argInfo, const char *arg, enum ConfigType type)
{
    if (argInfo->subCmd != INVALID_TYPE) {
        MSNPU_PRINT_ERROR("Only one command is supported at a time.");
        return EN_ERROR;
    }
    if (strcmp(arg, "0") == 0) {
        argInfo->coreSwitch = 0;
    } else if (strcmp(arg, "1") == 0) {
        argInfo->coreSwitch = 1;
    } else {
        const char *switchName[] = {[AIC_SWITCH] = "--aic_switch", [AIV_SWITCH] = "--aiv_switch"};
        MSNPU_PRINT_ERROR("Input %s %s invalid, please input 0 or 1.", switchName[type], arg);
        return EN_ERROR;
    }
    argInfo->subCmd = (uint32_t)type;
    return EN_OK;
}

STATIC int32_t MsnHandleCoreId(DfxCoreSetMask *coreMask, const char *arg)
{
    uint8_t value = 0;
    char *context = NULL;
    char inputArg[MAX_VALUE_STR_LEN] = {0};
    errno_t err = strcpy_s(inputArg, MAX_VALUE_STR_LEN, arg);
    ONE_ACT_ERR_LOG(err != EOK, return EN_ERROR, "Call strcpy_s fail for coreid arg:%s.", arg);

    uint8_t count = 0;
    char *token = strtok_s(inputArg, ",", &context);
    while (token != NULL) {
        int64_t num = 0;
        if (MsnOptionGetValueInRange(token, "coreid", &num, 0, UINT8_MAX) != EN_OK) {
            return EN_ERROR;
        }

        value = (uint8_t)num;
        if (count >= CORE_ID_MAX) {
            MSNPU_PRINT_ERROR("Input core id count more than %d.", CORE_ID_MAX);
            return EN_ERROR;
        }
        for (uint8_t i = 0; i < count; i++) {
            if (coreMask->coreId[i] == value) {
                MSNPU_PRINT_ERROR("Duplicate input core id '%hhu'.", value);
                return EN_ERROR;
            }
        }
        coreMask->coreId[count++] = value;

        token = strtok_s(NULL, ",", &context);
    }

    uint8_t commaNum = 0;
    const char *p = arg;
    while (*p) {
        if (*p == ',') {
            commaNum++;
        }
        p++;
    }
    if (commaNum >= count) {
        MSNPU_PRINT_ERROR("Input --coreid %s is invalid.", arg);
        return EN_ERROR;
    }
    coreMask->configNum = count;

    return EN_OK;
}

STATIC int32_t MsnSetCoreId(ArgInfo *argInfo, const char *arg)
{
    if (argInfo->coreSwitch < 0) {
        MSNPU_PRINT_ERROR("Input '--aic_switch' or '--aiv_switch' first to use '--coreid'.");
        return EN_ERROR;
    }
    DfxCoreSetMask *setCoreMask = (DfxCoreSetMask *)argInfo->value;
    setCoreMask->coreSwitch = (uint8_t)argInfo->coreSwitch;

    if (strcmp(arg, RESET_COREID_FLAG) == 0) {
        // --coreid=0xFFFF means reset all core
        if (argInfo->coreSwitch != ENABLE_CORE) {
            MSNPU_PRINT_ERROR("The core id '0xFFFF' can only be used with '--aic_switch 1' or '--aiv_switch 1'");
            return EN_ERROR;
        }
        setCoreMask->coreSwitch = RESTORE_CORE;
    } else {
        if (MsnHandleCoreId(setCoreMask, arg) != EN_OK) {
            return EN_ERROR;
        }
    }

    argInfo->valueLen = (uint16_t)sizeof(DfxCoreSetMask);
    return EN_OK;
}

STATIC int32_t MsnSetSingleCommit(ArgInfo *argInfo, const char *arg)
{
    if (argInfo->subCmd != INVALID_TYPE) {
        MSNPU_PRINT_ERROR("Only one command is supported at a time.");
        return EN_ERROR;
    }

    DfxCommon *commonInfo = (DfxCommon *)argInfo->value;
    if (strcmp(arg, "0") == 0) {
        commonInfo->value = 0;
    } else if (strcmp(arg, "1") == 0) {
        commonInfo->value = 1;
    } else {
        MSNPU_PRINT_ERROR("Input --singlecommit %s invalid, please input 0 or 1.", arg);
        return EN_ERROR;
    }
    argInfo->valueLen = (uint16_t)sizeof(DfxCommon);
    argInfo->subCmd = (uint32_t)SINGLE_COMMIT;
    return EN_OK;
}

STATIC int32_t MsnCheckLevelStr(char *level, int32_t length, LogLevelType levelType)
{
    (void)length;
    if (levelType == LOGLEVEL_EVENT) {
        if ((strcmp(level, ENABLE_STR) == 0) || (strcmp(level, DISABLE_STR) == 0)) {
            return EN_OK;
        } else {
            MSNPU_PRINT_ERROR("Event level '%s' is invalid", level);
            return EN_ERROR;
        }
    }
    if (levelType == LOGLEVEL_MODULE) {
        char *pend = strchr(level, ':');
        if (pend == NULL) {
            MSNPU_PRINT_ERROR("Module level info format error, please input 'module:level' format.");
            return EN_ERROR;
        }
        *pend = '\0';
        const ModuleInfo *moduleInfo = GetModuleInfoByName(level);
        if (moduleInfo == NULL) {
            MSNPU_PRINT_ERROR("Module name '%s' does not exist.", level);
            return EN_ERROR;
        }
        *pend = ':';
        level = pend + 1;
    }

    int32_t levelId = GetLevelIdByName(level);
    if ((levelId < LOG_MIN_LEVEL) || (levelId > LOG_MAX_LEVEL)) {
        MSNPU_PRINT_ERROR("Level '%s' is invalid, You can execute 'config --help' for example value.", level);
        return EN_ERROR;
    }
    return EN_OK;
}
 
STATIC int32_t MsnSetLogLevel(ArgInfo *argInfo, const char *arg, LogLevelType levelType)
{
    if (argInfo->subCmd != LOG_LEVEL) {
        MSNPU_PRINT_ERROR("Must input '--log' before --global, --module or --event.");
        return EN_ERROR;
    }

    if (argInfo->valueLen != 0) {
        MSNPU_PRINT_ERROR("Only one command is supported at a time.");
        return EN_ERROR;
    }

    char level[MAX_VALUE_STR_LEN] = {0};
    errno_t err = strcpy_s(level, MAX_VALUE_STR_LEN, arg);
    if (err != EOK) {
        if (err == ERANGE_AND_RESET) {
            MSNPU_PRINT_ERROR("Input level '%s' is invalid.", arg);
        }
        SELF_LOG_ERROR("strcpy_s failed for log level");
        return EN_ERROR;
    }
    MsnToUpper(level, LogStrlen(level));
    if (MsnCheckLevelStr(level, MAX_VALUE_STR_LEN, levelType) != EN_OK) {
        return EN_ERROR;
    }
    int32_t ret = sprintf_s(argInfo->value, MAX_VALUE_STR_LEN, "SetLogLevel(%d)[%s]", levelType, level);
    if (ret == -1) {
        SELF_LOG_ERROR("sprintf failed for log level");
        return EN_ERROR;
    }
    argInfo->valueLen = (uint16_t)strlen(argInfo->value) + 1U;
    return EN_OK;
}

STATIC int32_t HandleCommonCmd(int32_t opt, ArgInfo *argInfo)
{
    switch (opt) {
        case CONFIG_ARGS_DOCKER:
            if (MsnIsDockerEnv()) {
                argInfo->dockerFlag = 1;
                return EN_OK;
            } else {
                MSNPU_PRINT_ERROR("--docker only used in docker env.");
                return EN_ERROR;
            }
        case CONFIG_ARGS_GET:
            if (argInfo->cmdType != INVALID_CMD) {
                MSNPU_PRINT_ERROR("Only one option(--set or --get) is supported at a time.");
                return EN_ERROR;
            }
            argInfo->cmdType = CONFIG_GET;
            return EN_OK;
        case CONFIG_ARGS_SET:
            if (argInfo->cmdType != INVALID_CMD) {
                MSNPU_PRINT_ERROR("Only one option(--set or --get) is supported at a time.");
                return EN_ERROR;
            }
            argInfo->cmdType = CONFIG_SET;
            return EN_OK;
        case CONFIG_ARGS_HELP:
            MsnPrintConfigHelp();
            return EN_INVALID_PARAM;
        case CONFIG_ARGS_DEVICE:
            if (MsnSetDeviceId(argInfo, mmGetOptArg()) != EN_OK) {
                return EN_ERROR;
            }
            return EN_OK;
        default:
            return EN_ERROR;
    }
}

STATIC int32_t HandleAicErrorCmd(int32_t opt, const char *arg, ArgInfo *argInfo)
{
    if (argInfo->cmdType != CONFIG_SET) {
        MSNPU_PRINT_ERROR("Must input '--set' before set DFX config.");
        return EN_ERROR;
    }
    switch (opt) {
        case CONFIG_ARGS_ICACHE_CHECK:
            return MsnSetIcacheRange(argInfo, arg);
        case CONFIG_ARGS_ACCELERATOR_RECOVER:
            return MsnSetAcceleratorRecover(argInfo, arg);
        case CONFIG_ARGS_AIC_SWITCH:
            return MsnSetCoreSwitch(argInfo, arg, AIC_SWITCH);
        case CONFIG_ARGS_AIV_SWITCH:
            return MsnSetCoreSwitch(argInfo, arg, AIV_SWITCH);
        case CONFIG_ARGS_SINGLE_COMMIT:
            return MsnSetSingleCommit(argInfo, arg);
        case CONFIG_ARGS_CORE_ID:
            return MsnSetCoreId(argInfo, arg);
        default:
            return EN_ERROR;
    }
}

STATIC int32_t HandleLogLevelCmd(int32_t opt, ArgInfo *argInfo)
{
    if (argInfo->cmdType != CONFIG_SET) {
        MSNPU_PRINT_ERROR("Must input '--set' before set log level.");
        return EN_ERROR;
    }
    switch (opt) {
        case CONFIG_ARGS_LOG_LEVEL:
            if (argInfo->subCmd != INVALID_TYPE) {
                MSNPU_PRINT_ERROR("Only one command is supported at a time.");
                return EN_ERROR;
            }
            argInfo->subCmd = (uint32_t)LOG_LEVEL;
            return EN_OK;
        case CONFIG_ARGS_GLOBAL_LEVEL:
            return MsnSetLogLevel(argInfo, mmGetOptArg(), LOGLEVEL_GLOBAL);
        case CONFIG_ARGS_MODULE_LEVEL:
            return MsnSetLogLevel(argInfo, mmGetOptArg(), LOGLEVEL_MODULE);
        case CONFIG_ARGS_EVENT_LEVEL:
            return MsnSetLogLevel(argInfo, mmGetOptArg(), LOGLEVEL_EVENT);
        default:
            return EN_ERROR;
    }
}

STATIC int32_t MsnConfigCmdCheck(ArgInfo *argInfo)
{
    if (argInfo->subCmd == LOG_LEVEL) {
        if (strncmp(argInfo->value, STE_LOG_LEVEL_HEAD, strlen(STE_LOG_LEVEL_HEAD)) != 0) {
            MSNPU_PRINT_ERROR("Option '--log' must used with one of '--global', '--event' and '--module'");
            return EN_ERROR;
        }
    }
    if ((argInfo->coreSwitch >= 0) && (argInfo->valueLen == 0)) {
        MSNPU_PRINT_ERROR("Option '--aic_switch' or '--aiv_switch' must use with '--coreid'");
        return EN_ERROR;
    }
    if ((argInfo->cmdType == INVALID_CMD) || ((argInfo->cmdType == CONFIG_SET) && (argInfo->valueLen == 0))) {
        MSNPU_PRINT_ERROR("Invalid command.");
        MsnPrintConfigHelp();
        return EN_ERROR;
    }
    if (MsnIsDockerEnv() && !(argInfo->dockerFlag != 0)) {
        MSNPU_PRINT_ERROR("msnpureport in docker should be used with --docker.");
        return EN_ERROR;
    }

    return EN_OK;
}

STATIC int32_t MsnGetConfigOptions(int32_t argc, char **argv, ArgInfo *argInfo)
{
    argInfo->subCmd = (uint32_t)INVALID_TYPE;
    int32_t opt = 0;
    int32_t optionIndex = 0;
    while ((opt = mmGetOptLong(argc, argv, CONFIG_OPT, CONFIG_OPTS, &optionIndex)) != -1) {
        switch (opt) {
            case CONFIG_ARGS_DOCKER:
            case CONFIG_ARGS_GET:
            case CONFIG_ARGS_SET:
            case CONFIG_ARGS_HELP:
            case CONFIG_ARGS_DEVICE:
                if (HandleCommonCmd(opt, argInfo) != EN_OK) {
                    return EN_ERROR;
                }
                break;
            case CONFIG_ARGS_ICACHE_CHECK:
            case CONFIG_ARGS_ACCELERATOR_RECOVER:
            case CONFIG_ARGS_AIC_SWITCH:
            case CONFIG_ARGS_AIV_SWITCH:
            case CONFIG_ARGS_SINGLE_COMMIT:
            case CONFIG_ARGS_CORE_ID:
                if (HandleAicErrorCmd(opt, mmGetOptArg(), argInfo) != EN_OK) {
                    return EN_ERROR;
                }
                break;
            case CONFIG_ARGS_LOG_LEVEL:
            case CONFIG_ARGS_GLOBAL_LEVEL:
            case CONFIG_ARGS_MODULE_LEVEL:
            case CONFIG_ARGS_EVENT_LEVEL:
                if (HandleLogLevelCmd(opt, argInfo) != EN_OK) {
                    return EN_ERROR;
                }
                break;
            default:
                return EN_ERROR;
        }
    }

    return MsnConfigCmdCheck(argInfo);
}

STATIC void MsnPrintReportHelp(void)
{
    printf(
        "Usage: msnpureport report [OPTIONS]\n"
        "Example:\n"
        "\tmsnpureport report               Export all log and file\n"
        "\tmsnpureport report --all         Export all log and file, device event information in the bbox\n"
        "\tmsnpureport report --type 1      Export device log, include slog, message and system_info\n"
    );
    if (!MsnIsPoolEnv()) {
        printf("\tmsnpureport report --permanent   Continuously export device slog\n");
    }
    printf(
        "Options:\n"
        "    --docker             Docker flag, msnpureport in docker must be explicitly used with this flag\n"
        "    -d, --device         Device ID\n"
        "    --print              Set the output location of msnpureport logs, "
            "option: 0(syslog, default is 0), 1(stdout)\n"
        "    --log_level          Set log level of msnpureport, option: debug, info(default is info), warning, error\n"
        "    -h, --help           Help information\n"
    );
    printf(
        "\nExport device logs and files at a time:\n"
        "    -a, --all            Export all log and file, device event information in the bbox\n"
        "    -f, --force          Export all log and file, device event information in the bbox, "
            "historical maintenance and measurement information in the bbox\n"
        "    -t, --type           Export type: 0(all log and file, default is 0), 1(slog, message and system_info), "
            "2(bbox, current register), 3(stackcore), 4(vmcore), 5(module log)\n"
    );
    if (!MsnIsPoolEnv()) {
        printf(
            "\nContinuously exporting device logs:\n"
            "    --permanent          Continuously Exporting Device log flag, "
            "the following options must be entered after this flag\n"
        );
        for (int32_t i = (int32_t)REPORT_ARGS_SYS_LOG_NUM; i <= (int32_t)REPORT_ARGS_DEVICE_APP_DIR_NUM; i++) {
            printf("%s, range [%d-%d], default %d\n", g_permanentHelpMsg[i], PERMANENT_ARGS_RANGE[i][MIN_INDEX],
                PERMANENT_ARGS_RANGE[i][MAX_INDEX], PERMANENT_ARGS_RANGE[i][DEFAULT_INDEX]);
        }
    }
}

STATIC int32_t MsnSetReportType(ArgInfo *argInfo, const char *arg)
{
    int64_t num = -1;
    if (MsnOptionGetValueInRange(arg, "type|-t", &num, ALL_LOG, MAX_TYPE_NUM - 1) != EN_OK) {
        return EN_ERROR;
    }

    argInfo->reportType = (int32_t)num;
    argInfo->subCmd = (uint32_t)REPORT_TYPE;
    return EN_OK;
}

STATIC int32_t MsnReportPermanentCmd(int32_t opt, ArgInfo *argInfo, int32_t optionIndex)
{
    if (opt == (int32_t)REPORT_ARGS_PERMANENT) {
        if (argInfo->subCmd != REPORT_DEFAULT) {
            MSNPU_PRINT_ERROR("-a,-f,-t cannot be used together with --permanent.");
            return EN_INVALID_PARAM;
        }
        if (argInfo->cmdType == REPORT_PERMANENT) {
            MSNPU_PRINT_ERROR("Input --permanent repeatedly.");
            return EN_ERROR;
        }
        argInfo->cmdType = REPORT_PERMANENT;
        return EN_OK;
    }

    FileAgeingParam *param = (FileAgeingParam *)argInfo->value;
    uint32_t *paramValue[REPORT_ARGS_DEVICE_APP_DIR_NUM + 1] = {
        [REPORT_ARGS_SYS_LOG_NUM] = &param->sysLogFileNum,
        [REPORT_ARGS_SYS_LOG_SIZE] = &param->sysLogFileSize,
        [REPORT_ARGS_FW_LOG_NUM] = &param->firmwareLogFileNum,
        [REPORT_ARGS_FW_LOG_SIZE] = &param->firmwareLogFileSize,
        [REPORT_ARGS_EVENT_LOG_NUM] = &param->eventLogFileNum,
        [REPORT_ARGS_EVENT_LOG_SIZE] = &param->eventLogFileSize,
        [REPORT_ARGS_SEC_LOG_NUM] = &param->securityLogFileNum,
        [REPORT_ARGS_SEC_LOG_SIZE] = &param->securityLogFileSize,
        [REPORT_ARGS_STACKCORE_NUM] = &param->stackcoreFileNum,
        [REPORT_ARGS_FAULT_EVENT_NUM] = &param->faultEventDirNum,
        [REPORT_ARGS_BBOX_NUM] = &param->bboxDirNum,
        [REPORT_ARGS_SLOGD_LOG_NUM] = &param->slogdLogFileNum,
        [REPORT_ARGS_DEVICE_APP_DIR_NUM] = &param->deviceAppDirNum,
    };

    if (argInfo->cmdType != REPORT_PERMANENT) {
        MSNPU_PRINT_ERROR("Must input --permanent before input --%s.", g_reportOptions[optionIndex].name);
        return EN_ERROR;
    }
    if (*paramValue[opt] != 0) {
        MSNPU_PRINT_ERROR("Repeatedly input --%s.", g_reportOptions[optionIndex].name);
        return EN_ERROR;
    }

    int64_t value = 0;
    if (MsnOptionGetValueInRange(mmGetOptArg(), g_reportOptions[optionIndex].name, &value,
        PERMANENT_ARGS_RANGE[opt][0], PERMANENT_ARGS_RANGE[opt][1]) != EN_OK) {
        return EN_INVALID_PARAM;
    }

    *paramValue[opt] = (uint32_t)value;
    return EN_OK;
}

STATIC int32_t MsnReportLogCmd(int32_t opt, ArgInfo *argInfo)
{
    if (argInfo->cmdType != REPORT) {
        MSNPU_PRINT_ERROR("-a,-f,-t cannot be used together with --permanent.");
        return EN_INVALID_PARAM;
    }
    if (argInfo->subCmd != REPORT_DEFAULT) {
        MSNPU_PRINT_ERROR("-a,-f,-t only support one option at a time.");
        return EN_INVALID_PARAM;
    }
    switch (opt) {
        case REPORT_ARGS_REPORT_ALL:
            argInfo->subCmd = (uint32_t)REPORT_ALL;
            argInfo->reportType = (int32_t)ALL_LOG;
            break;
        case REPORT_ARGS_REPORT_FORCE:
            argInfo->subCmd = (uint32_t)REPORT_FORCE;
            argInfo->reportType = (int32_t)ALL_LOG;
            break;
        case REPORT_ARGS_REPORT_TYPE:
            if (MsnSetReportType(argInfo, mmGetOptArg())) {
                return EN_INVALID_PARAM;
            }
            break;
        default:
            return EN_ERROR;
    }
    return EN_OK;
}

static int32_t MsnSetLogPrint(ArgInfo *argInfo, const char *arg)
{
    if (argInfo->printMode != INVALID_PRINT_MODE) {
        MSNPU_PRINT_ERROR("Duplicate input --print.");
        return EN_ERROR;
    }

    if (strcmp(arg, "0") == 0) {
        argInfo->printMode = PRINT_SYSLOG;
    } else if (strcmp(arg, "1") == 0) {
        argInfo->printMode = PRINT_STDOUT;
    } else {
        MSNPU_PRINT_ERROR("Input --print %s is invalid, please input 0 or 1.", arg);
        return EN_INVALID_PARAM;
    }
    return EN_OK;
}

static int32_t MsnSetSelfLogLevel(ArgInfo *argInfo, const char *arg)
{
    if (argInfo->selfLogLevel != SYSLOG_MAX_LEVEL) {
        MSNPU_PRINT_ERROR("Duplicate input --log_level.");
        return EN_ERROR;
    }

    const char *logLevelMap[SYSLOG_MAX_LEVEL] = {
        [LOG_ERR] = LOG_LEVEL_ERROR_STR,
        [LOG_WARNING] = LOG_LEVEL_WARNING_STR,
        [LOG_INFO] = LOG_LEVEL_INFO_STR,
        [LOG_DEBUG] = LOG_LEVEL_DEBUG_STR,
    };

    for (int32_t i = 0; i < SYSLOG_MAX_LEVEL; i++) {
        if ((logLevelMap[i] != NULL) && (strcmp(arg, logLevelMap[i]) == 0)) {
            argInfo->selfLogLevel = i;
            return EN_OK;
        }
    }
    MSNPU_PRINT_ERROR("Input --log_level %s is invalid, please input %s, %s, %s or %s.", arg, LOG_LEVEL_ERROR_STR,
        LOG_LEVEL_WARNING_STR, LOG_LEVEL_INFO_STR, LOG_LEVEL_DEBUG_STR);
    return EN_INVALID_PARAM;
}

STATIC int32_t MsnReportCommonCmd(int32_t opt, ArgInfo *argInfo)
{
    switch (opt) {
        case REPORT_ARGS_DOCKER:
            if (MsnIsDockerEnv()) {
                argInfo->dockerFlag = 1;
                break;
            } else {
                MSNPU_PRINT_ERROR("--docker only used in docker env.");
                return EN_ERROR;
            }
            break;
        case REPORT_ARGS_PRINT:
            if (MsnSetLogPrint(argInfo, mmGetOptArg()) != EN_OK) {
                return EN_ERROR;
            }
            break;
        case REPORT_ARGS_MSN_LOG_LEVEL:
            if (MsnSetSelfLogLevel(argInfo, mmGetOptArg()) != EN_OK) {
                return EN_ERROR;
            }
            break;
        case REPORT_ARGS_DEVICE:
            if (MsnSetDeviceId(argInfo, mmGetOptArg()) != EN_OK) {
                return EN_ERROR;
            }
            break;
        case REPORT_ARGS_REPORT_HELP:
            MsnPrintReportHelp();
            return EN_ERROR;
        default:
            return EN_ERROR;
    }
    return EN_OK;
}

STATIC int32_t MsnReportCmdCheck(ArgInfo *argInfo)
{
    if (argInfo->cmdType == REPORT) {
        if (argInfo->reportType == MAX_TYPE_NUM) {
            argInfo->reportType = ALL_LOG;
        }
    }

    if (argInfo->cmdType == REPORT_PERMANENT) {
        FileAgeingParam *param = (FileAgeingParam *)argInfo->value;
        uint32_t *paramValue[REPORT_ARGS_DEVICE_APP_DIR_NUM + 1] = {
            [REPORT_ARGS_SYS_LOG_NUM] = &param->sysLogFileNum,
            [REPORT_ARGS_SYS_LOG_SIZE] = &param->sysLogFileSize,
            [REPORT_ARGS_FW_LOG_NUM] = &param->firmwareLogFileNum,
            [REPORT_ARGS_FW_LOG_SIZE] = &param->firmwareLogFileSize,
            [REPORT_ARGS_EVENT_LOG_NUM] = &param->eventLogFileNum,
            [REPORT_ARGS_EVENT_LOG_SIZE] = &param->eventLogFileSize,
            [REPORT_ARGS_SEC_LOG_NUM] = &param->securityLogFileNum,
            [REPORT_ARGS_SEC_LOG_SIZE] = &param->securityLogFileSize,
            [REPORT_ARGS_STACKCORE_NUM] = &param->stackcoreFileNum,
            [REPORT_ARGS_FAULT_EVENT_NUM] = &param->faultEventDirNum,
            [REPORT_ARGS_BBOX_NUM] = &param->bboxDirNum,
            [REPORT_ARGS_SLOGD_LOG_NUM] = &param->slogdLogFileNum,
            [REPORT_ARGS_DEVICE_APP_DIR_NUM] = &param->deviceAppDirNum,
        };
        for (int32_t i = REPORT_ARGS_SYS_LOG_NUM; i <= REPORT_ARGS_DEVICE_APP_DIR_NUM; i++) {
            *paramValue[i] = *paramValue[i] == 0U ? (uint32_t)PERMANENT_ARGS_RANGE[i][DEFAULT_INDEX] : *paramValue[i];
        }
    }
    return EN_OK;
}

static void MsnAdaptDavidPool(void)
{
    if (MsnIsPoolEnv()) {
        uint32_t num = sizeof(g_reportOptions) / sizeof(mmStructOption);
        for (uint32_t i = 0; i < num; i++) {
            if ((g_reportOptions[i].name != NULL) && (strcmp(g_reportOptions[i].name, "permanent") == 0)) {
                g_reportOptions[i] = (mmStructOption){NULL, 0, NULL, 0};
                break;
            }
        }
    }
}

STATIC int32_t MsnGetReportOptions(int32_t argc, char **argv, ArgInfo *argInfo)
{
    MsnAdaptDavidPool();
    argInfo->cmdType = REPORT;
    argInfo->subCmd = REPORT_DEFAULT;
    argInfo->reportType = (int32_t)MAX_TYPE_NUM;;
    int32_t opt = 0;
    int32_t optionIndex = 0;
    while ((opt = mmGetOptLong(argc, argv, REPORT_OPT, g_reportOptions, &optionIndex)) != -1) {
        if ((opt >= REPORT_ARGS_PERMANENT) && (opt <= REPORT_ARGS_DEVICE_APP_DIR_NUM)) {
            if (MsnReportPermanentCmd(opt, argInfo, optionIndex) != EN_OK) {
                return EN_INVALID_PARAM;
            }
            continue;
        }
        switch (opt) {
            case REPORT_ARGS_DOCKER:
            case REPORT_ARGS_PRINT:
            case REPORT_ARGS_MSN_LOG_LEVEL:
            case REPORT_ARGS_DEVICE:
            case REPORT_ARGS_REPORT_HELP:
                if (MsnReportCommonCmd(opt, argInfo) != EN_OK) {
                    return EN_ERROR;
                }
                break;
            case REPORT_ARGS_REPORT_ALL:
            case REPORT_ARGS_REPORT_FORCE:
            case REPORT_ARGS_REPORT_TYPE:
                if (MsnReportLogCmd(opt, argInfo) !=EN_OK) {
                    return EN_INVALID_PARAM;
                }
                break;
            default:
                return EN_ERROR;
        }
    }

    return MsnReportCmdCheck(argInfo);
}

STATIC int32_t MsnOptionsHandle(int32_t argc, char **argv, ArgInfo *argInfo)
{
    ONE_ACT_ERR_LOG(argv == NULL, return EN_ERROR, "argv is NULL.");
    ONE_ACT_ERR_LOG(argv[0] == NULL, return EN_ERROR, "argv[0] is NULL.");

    if (strcmp(argv[0], CONFIG_STR) == 0) {
        if (MsnGetConfigOptions(argc, argv, argInfo) != EN_OK) {
            return EN_ERROR;
        }
    } else if (strcmp(argv[0], REPORT_STR) == 0) {
        if (MsnGetReportOptions(argc, argv, argInfo) != EN_OK) {
            return EN_ERROR;
        }
    } else if (strcmp(argv[0], HELP_STR) == 0) {
        MsnPrintHelp();
        return EN_ERROR;
    } else if (strcmp(argv[0], VERSION_STR) == 0) {
        MSNPU_PRINT("msnpureport version: %s", MSNPUREPORT_VERSION);
        return EN_ERROR;
    } else {
        MSNPU_PRINT_ERROR("Invalid subcommand: %s.", argv[0]);
        MsnPrintHelp();
    }

    if (MsnIsDockerEnv() && !(argInfo->dockerFlag != 0)) {
        MSNPU_PRINT_ERROR("msnpureport in docker should be used with --docker.");
        return EN_ERROR;
    }

    return EN_OK;
}

STATIC int32_t MsnHandleArgInfo(ArgInfo *argInfo)
{
    int32_t ret = EN_OK;
    switch (argInfo->cmdType) {
        case CONFIG_GET:
        case CONFIG_SET:
            if (argInfo->deviceId == MAX_DEV_NUM) {
                argInfo->deviceId = 0;
            }
            ret = MsnConfig(argInfo);
            break;
        case REPORT:
        case REPORT_PERMANENT:
            ret = MsnReport(argInfo);
            break;
        case INVALID_CMD:
        default:
            ret = EN_ERROR;
            break;
    }
    if (ret != EN_OK) {
        MSNPU_PRINT_ERROR("Process failed, check syslog for more information.");
    }
    return ret;
}

int32_t MsnOptions(int32_t argc, char **argv)
{
    ONE_ACT_ERR_LOG(argv == NULL, return EN_ERROR, "argv is NULL.");
    ArgInfo argInfo = {
        .cmdType = INVALID_CMD,
        .subCmd = (uint32_t)INVALID_TYPE,
        .deviceId = MAX_DEV_NUM,
        .valueLen = 0,
        .coreSwitch = -1,
        .reportType = 0,
        .dockerFlag = 0,
        .printMode = INVALID_PRINT_MODE,
        .selfLogLevel = SYSLOG_MAX_LEVEL,
        .value = {0}
    };

    if ((argc < MIN_USER_ARG_LEN) || ((argv[1] != NULL) && (argv[1][0] == '-'))) {
        // old command
        bool flag = true;
        if (MsnOptionsOld(argc, argv, &argInfo, &flag) != EN_OK) {
            return EN_ERROR;
        }
        if (!flag) {
            return EN_OK;
        }
    } else {
        // new command
        if (MsnOptionsHandle(argc - 1, &argv[1], &argInfo) != EN_OK) {
            return EN_ERROR;
        }
        optind++;       // To adapt subcommand
    }

    if (optind < argc) {
        printf ("ERROR: Invalid option: ");
        while (optind < argc) {
            printf ("%s ", argv[optind++]);
        }
        putchar ('\n');
        return EN_ERROR;
    }

    if (argInfo.printMode == INVALID_PRINT_MODE) {
        argInfo.printMode = PRINT_SYSLOG;
    }
    if (argInfo.selfLogLevel == SYSLOG_MAX_LEVEL) {
        argInfo.selfLogLevel = LOG_INFO;
    }

    MsnSetLogPrintMode(argInfo.printMode);
    MsnPrintSetLogLevel(argInfo.selfLogLevel);
    return MsnHandleArgInfo(&argInfo);
}