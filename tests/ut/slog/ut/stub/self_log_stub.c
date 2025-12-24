/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "self_log_stub.h"
#include "log_print.h"

static uint32_t g_errLogNum = 0;
void LogPrintSys(int priority, const char *format, ...)
{
    va_list args;
    va_start(args, format);
    char msg[MSG_LENGTH] = { 0 };
    vsprintf(msg, format, args);
    va_end(args);
    if (priority == LOG_ERR) {
        g_errLogNum++;
        char errLogFile[200] = {0};
        sprintf(errLogFile, "%s/errLogFile.txt", PATH_ROOT);
        FILE *errFileFp = fopen(errLogFile, "aw");
        fseek(errFileFp, 0, SEEK_END);
        fwrite(msg, strlen(msg), 1, errFileFp);
        fclose(errFileFp);
        printf("[ERROR] ");
        printf(msg);
        return;
    }
#ifdef LLT_DEBUG
    char logFile[200] = {0};
    sprintf(logFile, "%s/LogFile.txt", PATH_ROOT);
    FILE *fp = fopen(logFile, "aw");
    fseek(fp, 0, SEEK_END);
    if (priority == LOG_WARNING) {
        fwrite(msg, strlen(msg), 1, fp);
        printf("[WARNING] ");
    } else if (priority == LOG_INFO) {
        fwrite(msg, strlen(msg), 1, fp);
        printf("[INFO] ");
    }
    fclose(fp);
    printf(msg);
#endif
}

void LogPrintSelf(const char *format, ...)
{
    va_list args;
    va_start(args, format);
    char msg[MSG_LENGTH] = { 0 };
    vsprintf(msg, format, args);
    va_end(args);
    char *ret = strstr(msg, "[ERROR]");
    if (ret != NULL) {
        g_errLogNum++;
        char errLogFile[200] = {0};
        sprintf(errLogFile, "%s/errLogFile.txt", PATH_ROOT);
        printf("errLogFile=%s\n", errLogFile);
        FILE *errFileFp = fopen(errLogFile, "aw");
        if (errFileFp == NULL) {
            printf("fopen failed, msg=%s\n", msg);
            return;
        }
        fseek(errFileFp, 0, SEEK_END);
        fwrite(msg, MSG_LENGTH, 1, errFileFp);
        fclose(errFileFp);
        printf("[ERROR] ");
        printf(msg);
    }
#ifdef LLT_DEBUG
    printf(msg);
#endif
}

uint32_t GetErrLogNum(void)
{
    return g_errLogNum;
}

void ResetErrLog(void)
{
    g_errLogNum = 0;
    if (access(PATH_ROOT "/errLogFile.txt", F_OK) == 0) {
        system("rm " PATH_ROOT "/errLogFile.txt");
    }
    if (access(PATH_ROOT "/errLogFile_cmd_result.txt", F_OK) == 0) {
        system("rm " PATH_ROOT "/errLogFile_cmd_result.txt");
    }
}

int32_t CheckErrLog(char *msg)
{
    char resultFile[200] = {0};
    sprintf(resultFile, "%s/errLogFile_cmd_result.txt", PATH_ROOT);
    char cmd[200] = {0};
    sprintf(cmd, "cat %s/errLogFile.txt", PATH_ROOT);
    sprintf(cmd, "cat %s/errLogFile.txt | grep -a \"%s\" | wc -l > %s", PATH_ROOT, msg, resultFile);
    system(cmd);

    char buf[MSG_LENGTH] = {0};
    FILE *fp = fopen(resultFile, "r");
    if (fp == NULL) {
        return false;
    }
    int size = fread(buf, 1, MSG_LENGTH, fp);
    fclose(fp);
    if (size == 0) {
        return 0;
    } else {
        return atoi(buf);
    }
}