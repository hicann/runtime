/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <pthread.h>
#include <string.h>
#include "securec.h"
#include "vector.h"
#include "error_manager.h"

#define MAX_ARG_NUMBER 3
#define ERRCODE_LENGTH 6
#define PERCENT_S_LEN 2
#define NEWLINE_LEN 2
#define SPACE_NUMS 8
typedef struct {
    char *errorId;
    char *errorMessage;  // 模板错误message，可能带%s，跟argList是对应的
    char *possibleCause;
    char *solution;
    char *argList[MAX_ARG_NUMBER];
} ErrorInfoConfig;  // 外部错误码配置

typedef struct {
    char *errorId;
    char *errorMessage;  // 对于外部错误码而言，这里是格式化后的
    char *possibleCause;
    char *solution;
    bool idIsInner;   // 标识errorId是不是常量区
    bool errIsInner;  // 标识errorMessage是不是常量区
} ErrorItem;          // 兼容内外部错误信息

typedef struct {
    size_t errorMsgLen;    // 存储此次Get时返回的拼接字符串的长度
    size_t errorMsgSize;   // 上次分配errorMsg内存大小
    char *errorMsg;        // 存储Get时返回的拼接字符串
    Vector errorItemList;  // 存储每次Report的错误描述;
} ErrorInfoThread;

// g_errorMap必须要保证按errorId保序
static const ErrorInfoConfig ERROR_MAP[] = {
    // GE Errors
    {"E10001", "Value [%s] for parameter [%s] is invalid. Reason: %s", NULL /* possibleCause为空 */,
     "Try again with a valid argument.", {"value", "parameter", "reason"}},
    {"E10004", "Value for [--%s] is empty.", NULL, NULL /* solution为空 */, {"parameter"}},
    {"E10055", "The operation is not supported. Reason: %s", NULL, NULL, {"reason"}},
    {"E19001", "Failed to open file[%s]. Reason: %s.", NULL,
     "Fix the error according to the error message.", {"file", "errMsg"}},
    {"E19025", "Input tensor is invalid. Reason: %s.", NULL, NULL, {"reason"}},

    // RTS Errors， "EE4001"、"EE4002"、"EE4004"主线没有用到，删除
    {"EE1001", "The argument is invalid.Reason: %s", NULL, NULL, {"extendInfo"}},
    // {"EE4001", "Failed to bind the stream to the model. %s", "The stream has been bound to another model.",
    //  "Remove the repeated binding operation on the stream from the code.", {"extend_info"}},
    // {"EE4002", "Failed to unbind the stream to the model. %s",
    //  "1.The stream to be unbound is not bound to the model.   2.The model is running.",
    //  "1.Check the code to ensure that the stream to be unbound is bound to the model."
    //  "    2.Ensure that the model is not running.", {"extend_info"}},
    // {"EE4004", "Failed to enable profiling.  %s", NULL, "Do not enable profiling repeatedly.", {"extend_info"}},

    //  ACL Errors
    {"EH0001", "Value [%s] for [%s] is invalid. Reason: %s.", NULL, NULL, {"value", "param", "reason"}},
    {"EH0002", "Argument [%s] must not be NULL.", NULL, "Try again with a correct pointer argument.", {"param"}},
    {"EH0003", "Path [%s] is invalid. Reason: %s.", NULL, NULL, {"path", "reason"}},
    // {"EH0004", "File [%s] is invalid. Reason: %s.", NULL, NULL, {"path", "reason"}},  //主线没用到
    // {"EH0005", "AIPP argument [%s] is invalid. Reason: %s.", NULL, NULL, {"param", "reason"}}, // AIPP
    // {"EH0006", "%s is not supported. Reason: %s.", NULL, NULL, {"feature", "reason"}}, // DVPP跟TDT

    // Profiling Errors
    {"EK0001", "Value [%s] for [%s] is invalid. Reason: %s.", NULL, NULL, {"value", "param", "reason"}},
    {"EK0002", "Failed to call %s before calling %s.", NULL, NULL, {"intf1", "intf2"}},
    {"EK0003", "Failed to set the %s to [%s]. Reason: %s.", NULL, NULL, {"config", "value", "reason"}},
    {"EK0004", "[%s] is not supported in %s.", NULL, NULL, {"intf", "platform"}},
    {"EK0201", "Failed to allocate host memory for Profiling: %s.", "Available memory is insufficient.",
     "Close unused applications.", {"buf_size"}},
    {"EK9999", "An unknown error occurred. Please check the log.", NULL, NULL, {}},
};
__thread ErrorInfoThread *g_errorThread = NULL;
static pthread_key_t g_errorThreadKey;

static void KeyDestructor(void *value)
{
    if ((ErrorInfoThread *)value != NULL) {
        if (((ErrorInfoThread *)value)->errorMsg != NULL) {
            free(((ErrorInfoThread *)value)->errorMsg);
            ((ErrorInfoThread *)value)->errorMsg = NULL;
        }
        DeInitVector(&((ErrorInfoThread *)value)->errorItemList);
        free((ErrorInfoThread *)value);
    }
}

static void PfnDestroyItem(void *a)
{
    if (!((ErrorItem *)a)->idIsInner) {
        free(((ErrorItem *)a)->errorId);
    }
    if (!((ErrorItem *)a)->errIsInner) {
        free(((ErrorItem *)a)->errorMessage);
    }
    ((ErrorItem *)a)->errorId = NULL;
    ((ErrorItem *)a)->errorMessage = NULL;
    ((ErrorItem *)a)->possibleCause = NULL;
    ((ErrorItem *)a)->solution = NULL;
}

static void InitErrorThreadKey(void)
{
    pthread_key_create(&g_errorThreadKey, KeyDestructor);
}

static int32_t InitErrorInfoThread(void)
{
    static pthread_once_t once = PTHREAD_ONCE_INIT;
    pthread_once(&once, InitErrorThreadKey);
    g_errorThread = (ErrorInfoThread *)malloc(sizeof(ErrorInfoThread));
    if (g_errorThread == NULL) {
        return -1;
    }
    InitVector(&g_errorThread->errorItemList, sizeof(ErrorItem));
    SetVectorDestroyItem(&g_errorThread->errorItemList, PfnDestroyItem);
    g_errorThread->errorMsgLen = 0;
    g_errorThread->errorMsgSize = 0;
    g_errorThread->errorMsg = NULL;
    pthread_setspecific(g_errorThreadKey, g_errorThread);
    return 0;
}

static int Compare(const void *a, const void *b)
{
    return strcmp(((const ErrorInfoConfig *)a)->errorId, ((const ErrorInfoConfig *)b)->errorId);
}

static ErrorInfoConfig *SearchFromErrorMap(const char *errorCode)
{
    ErrorInfoConfig errConfig = {(char *)errorCode, NULL, NULL, NULL, {}};
    static size_t errorPerLen = sizeof(ERROR_MAP[0]);
    static size_t errorMapLen = sizeof(ERROR_MAP) / sizeof(ERROR_MAP[0]);
    return (ErrorInfoConfig *)bsearch(&errConfig, ERROR_MAP, errorMapLen, errorPerLen, Compare);
}

static int SearchFromArray(int32_t argsNum, char *args[], const char *arg)
{
    int index = -1;
    for (int i = 0; i < argsNum; i++) {
        if (strcmp(args[i], arg) == 0) {
            index = i;
            break;
        }
    }
    return index;
}

static int SubString(const char *str, const char *sub)
{
    int count = 0;
    size_t j;
    for (size_t i = 0; i < strlen(str); i++) {
        for (j = 0; j < strlen(sub); j++) {
            if (str[i + j] != sub[j]) {
                break;
            }
        }
        if (j == strlen(sub)) {
            count++;
        }
    }
    return count;
}

/* 函数名：FormatString
   函数功能：格式化错误模板信息，如
      FormatString({"value", "param", "reason"}, "Value [%s] for [%s] is invalid. Reason: %s.",
                   {"value", "param", "reason"}, {"25", "x", "The value is too small"}, 3);
      返回"Value [25] for [x] is invalid. Reason: The value is too small.
   输入：
       tmplArgList : 模板参数列表，如{"value", "param", "reason"}
       tmplErrorMsg : 模板errMsg, 如"Value [%s] for [%s] is invalid. Reason: %s."
       args : 用户传入的参数列表, {"value", "param", "reason", "..."}
       argValues : 用户传入的参数值列表， {"5", "x", "x is invalid", "..."}
       argsNum :用户传入的参数值或者参数列表长度, sizeof(args) / sizeof(char*)
   返回值：格式化后的字符串，失败为NULL
*/
static char *FormatString(char *tmplArgList[MAX_ARG_NUMBER], char *tmplErrorMsg,
                          char *args[], char *argValues[], int32_t argsNum)
{  // 当模板中errormsg %s个数大于3个时，提前处理
    if (SubString(tmplErrorMsg, "%s") > MAX_ARG_NUMBER) {
        return NULL;
    }
    // 判断模板参数列表的参数是否都包含在用户传入的参数列表中，是的话计算格式化字符串长度
    char *validArgVals[MAX_ARG_NUMBER];
    size_t formatMsgLen = strlen(tmplErrorMsg) + 1;
    int index = -1;
    for (int i = 0; i < MAX_ARG_NUMBER; i++) {
        if (tmplArgList[i] == NULL || strlen(tmplArgList[i]) == 0) {
            break;
        }
        index = SearchFromArray(argsNum, args, tmplArgList[i]);
        if (index == -1) {
            return NULL;
        }
        validArgVals[i] = argValues[index];
        formatMsgLen += (strlen(argValues[index]) - PERCENT_S_LEN);
    }
    char *dstInfo = (char *)malloc(formatMsgLen);
    if (dstInfo == NULL) {
        return NULL;
    }
    int n = sprintf_s(dstInfo, formatMsgLen, tmplErrorMsg, validArgVals[0], validArgVals[1], validArgVals[2]);
    if (n < 0) {
        free(dstInfo);
        return NULL;
    }
    return dstInfo;
}

static int32_t Init(void)
{
    if (g_errorThread == NULL) {
        int32_t initRet = InitErrorInfoThread();
        if (initRet) {
            return -1;
        }
    }
    return 0;
}

void ReportErrMessage(const char *errorCode, char *args[], char *argValues[], int32_t argsNum)
{
    int32_t initRet = Init();
    if (initRet) {
        return;
    }

    ErrorInfoConfig *searchRet = SearchFromErrorMap(errorCode);
    if (searchRet == NULL) {
        return;
    }

    ErrorItem errorItem;
    char *ret = strstr(searchRet->errorMessage, "%s");
    if (ret == NULL) {
        errorItem.errorMessage = searchRet->errorMessage;
        errorItem.errIsInner = true;
    } else {
        errorItem.errorMessage = FormatString(searchRet->argList, searchRet->errorMessage, args, argValues, argsNum);
        if (errorItem.errorMessage == NULL) {
            return;
        }
        errorItem.errIsInner = false;
    }
    errorItem.idIsInner = true;
    errorItem.errorId = searchRet->errorId;
    errorItem.possibleCause = searchRet->possibleCause;
    errorItem.solution = searchRet->solution;
    // 为GetErrorMessage时返回拼接字符串做准备，NEWLINE_LEN表示为每条errMsg末尾增加"\r\n"
    g_errorThread->errorMsgLen += (SPACE_NUMS + strlen(errorItem.errorMessage) + NEWLINE_LEN);
    if ((EmplaceBackVector(&g_errorThread->errorItemList, &errorItem) == NULL) && (errorItem.errIsInner == false)) {
        free(errorItem.errorMessage);
    }
    return;
}

static bool IsValidErrorCode(const char *errorCode)
{
    return strlen(errorCode) == ERRCODE_LENGTH;
}

static bool IsInnerErrorCode(const char *errorCode)
{
    const char *kInterErrorCodePrefix1 = "9999";
    const char *kInterErrorCodePrefix2 = "8888";
    if (IsValidErrorCode(errorCode) && (strcmp(errorCode + PERCENT_S_LEN, kInterErrorCodePrefix1) == 0 ||
        strcmp(errorCode + PERCENT_S_LEN, kInterErrorCodePrefix2) == 0)) {
        return true;
    }
    return false;
}

void ReportInterErrMessage(const char *errorCode, const char *errorMsg)
{
    int32_t initRet = Init();
    if (initRet) {
        return;
    }
    if (!IsInnerErrorCode(errorCode)) {
        return;
    }
    ErrorItem errorItem;
    size_t errCodeLen = ERRCODE_LENGTH + 1;
    errorItem.errorId = (char *)malloc(errCodeLen);
    if (errorItem.errorId == NULL) {
        return;
    }
    size_t errMsgLen = strlen(errorMsg) + 1;
    errorItem.errorMessage = (char *)malloc(errMsgLen);
    if (errorItem.errorMessage == NULL) {
        free(errorItem.errorId);
        return;
    }
    if ((memcpy_s(errorItem.errorId, errCodeLen, errorCode, errCodeLen) != EOK) ||
        (memcpy_s(errorItem.errorMessage, errMsgLen, errorMsg, errMsgLen) != EOK)) {
        free(errorItem.errorId);
        free(errorItem.errorMessage);
        return;
    }
    errorItem.idIsInner = false;
    errorItem.errIsInner = false;
    // 这里加1没加2是因为上面errMsgLen已经加了1
    g_errorThread->errorMsgLen += (SPACE_NUMS + errMsgLen + 1);
    if (EmplaceBackVector(&g_errorThread->errorItemList, &errorItem) == NULL) {
        free(errorItem.errorId);
        free(errorItem.errorMessage);
    }
    return;
}

void FormatReportInner(const char *errorCode, const char *fmt, ...)
{
    va_list arg;
    va_start(arg, fmt);
    char errorStr[LIMIT_PER_MESSAGE] = {0};
    if (vsnprintf_s(errorStr, LIMIT_PER_MESSAGE, LIMIT_PER_MESSAGE - 1, fmt, arg) != -1) {
        ReportInterErrMessage(errorCode, errorStr);
    }
    va_end(arg);
    return;
}

// 根据此次计算的字符串大小和上次申请的内存大小关系，判断是否需要重新申请内存空间
static int32_t MallocByCase(void)
{
    if ((g_errorThread->errorMsgLen) > g_errorThread->errorMsgSize) {
        if (g_errorThread->errorMsg != NULL) {
            free(g_errorThread->errorMsg);
        }
        g_errorThread->errorMsg = (char *)malloc(g_errorThread->errorMsgLen);
        if (g_errorThread->errorMsg == NULL) {
            return -1;
        }
        g_errorThread->errorMsgSize = g_errorThread->errorMsgLen;
    }
    return 0;
}

static size_t GetFirstCode(size_t errorItemNum)
{
    for (size_t i = 0; i < errorItemNum; i++) {
        if (!IsInnerErrorCode(((ErrorItem *)VectorAt(&g_errorThread->errorItemList, i))->errorId)) {
            return i;
        }
    }
    return 0;
}

static int32_t ComputeAllocate(ErrorItem *firstItem)
{
    g_errorThread->errorMsgLen += (ERRCODE_LENGTH + sizeof(": Inner Error!\r\n")  + strlen(firstItem->errorMessage) +
                                   NEWLINE_LEN  + sizeof("        TraceBack (most recent call last): \r\n"));

    if (!IsInnerErrorCode(firstItem->errorId)) {
        if (firstItem->possibleCause != NULL) {
            g_errorThread->errorMsgLen +=
                (sizeof("        PossibleCause: ") + strlen(firstItem->possibleCause) + NEWLINE_LEN);
        }
        if (firstItem->solution != NULL) {
            g_errorThread->errorMsgLen += (sizeof("        Solution: ") + strlen(firstItem->solution) + NEWLINE_LEN);
        }
    }
    return MallocByCase();
}

static int32_t FormatTraceBefore(ErrorItem *firstItem)
{
    int32_t n;
    int32_t nFirstCause = 0;
    int32_t nFirstSolution = 0;
    if (IsInnerErrorCode(firstItem->errorId)) {
        n = sprintf_s(g_errorThread->errorMsg, g_errorThread->errorMsgLen, "%s: Inner Error!\r\n%s\r\n",
                      firstItem->errorId, firstItem->errorMessage);
        if (n < 0) {
            return -1;
        }
    } else {
        n = sprintf_s(g_errorThread->errorMsg, g_errorThread->errorMsgLen, "%s: %s\r\n",
                      firstItem->errorId, firstItem->errorMessage);
        if (n < 0) {
            return -1;
        }
        if (firstItem->possibleCause != NULL) {
            nFirstCause = sprintf_s(g_errorThread->errorMsg + n, g_errorThread->errorMsgLen,
                                    "        PossibleCause: %s\r\n", firstItem->possibleCause);
            if (nFirstCause < 0) {
                return -1;
            }
            n += nFirstCause;
        }
        if (firstItem->solution != NULL) {
            nFirstSolution = sprintf_s(g_errorThread->errorMsg + n, g_errorThread->errorMsgLen,
                                       "        Solution: %s\r\n", firstItem->solution);
            if (nFirstSolution < 0) {
                return -1;
            }
            n += nFirstSolution;
        }
    }
    return n;
}

static int32_t FormatTraceAfter(ErrorItem *firstItem, size_t errorItemNum, int32_t offset)
{
    bool printTracebackOnce = false;
    int32_t n = offset;
    int traceRet;
    int32_t nErrMsg;
    ErrorItem *errorItem;
    for (size_t i = 0; i < errorItemNum; i++) {
        errorItem = (ErrorItem *)VectorAt(&g_errorThread->errorItemList, i);
        if (strcmp(firstItem->errorId, errorItem->errorId) == 0 &&
            strcmp(firstItem->errorMessage, errorItem->errorMessage) == 0) {
            continue;
        }
        if (!printTracebackOnce) {
            traceRet = sprintf_s(g_errorThread->errorMsg + n, g_errorThread->errorMsgLen, "%s\r\n",
                                 "        TraceBack (most recent call last):");
            if (traceRet < 0) {
                return -1;
            }
            printTracebackOnce = true;
            n += traceRet;
        }

        nErrMsg = sprintf_s(g_errorThread->errorMsg + n, g_errorThread->errorMsgLen, "        %s\r\n",
                            errorItem->errorMessage);
        if (nErrMsg < 0) {
            return -1;
        }
        n += nErrMsg;
    }
    return 0;
}

static bool FormatOutMsg(ErrorItem *firstItem, size_t errorItemNum)
{
    int32_t offset = FormatTraceBefore(firstItem);
    if (offset == -1) {
        return false;
    }
    int32_t ret = FormatTraceAfter(firstItem, errorItemNum, offset);
    if (ret == -1) {
        return false;
    }
    return true;
}

char *GetErrorMessage(void)
{
    if (g_errorThread == NULL) {
        return NULL;
    }
    size_t errorItemNum = VectorSize(&g_errorThread->errorItemList);
    if (errorItemNum == 0) {
        return NULL;
    }
    size_t index = GetFirstCode(errorItemNum);
    ErrorItem *firstItem = (ErrorItem *)VectorAt(&g_errorThread->errorItemList, index);
    int32_t allocResult = ComputeAllocate(firstItem);
    if (allocResult == -1) {
        return NULL;
    }
    bool ret = FormatOutMsg(firstItem, errorItemNum);
    if (!ret) {
        free(g_errorThread->errorMsg);
        g_errorThread->errorMsgLen = 0U;
        g_errorThread->errorMsgSize = 0U;
        g_errorThread->errorMsg = NULL;
        return NULL;
    }
    ClearVector(&g_errorThread->errorItemList);
    return g_errorThread->errorMsg;
}