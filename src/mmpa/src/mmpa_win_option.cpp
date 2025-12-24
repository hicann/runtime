/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mmpa_api.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif /* __cpluscplus */
#endif /* __cpluscplus */

static INT32 opterr = 1;       // 与linux的全局环境变量命名保持一致
static INT32 optind = 1;       // 与linux的全局环境变量命名保持一致
static INT32 optopt = '?';     // 与linux的全局环境变量命名保持一致
static CHAR *optarg = nullptr; // 与linux的全局环境变量命名保持一致
static INT32 optreset;         // 与linux的全局环境变量命名保持一致

static INT32 g_nonoptStart = -1;
static INT32 g_nonoptEnd = -1;

// 错误消息 与linux保持一致
static const CHAR *OPT_REQ_ARG_CHAR = "option requires an argument -- %c";
static const CHAR *OPT_REQ_ARG_STRING = "option requires an argument -- %s";
static const CHAR *OPT_AMBIGIOUS = "OPT_AMBIGIOUSuous option -- %.*s";
static const CHAR *OPT_NO_ARG = "option doesn't take an argument -- %.*s";
static const CHAR *OPT_ILLEGAL_CHAR = "unknown option -- %c";
static const CHAR *OPT_ILLEGAL_STRING = "unknown option -- %s";

static CHAR *g_place = const_cast<CHAR *>(MMPA_EMSG);

#define ERRA(s, c) do { \
    if (MMPA_PRINT_ERROR) { \
        (void)fprintf(stderr, s, c); \
    } \
} while (0)

#define ERRB(s, c, v) do { \
    if (MMPA_PRINT_ERROR) { \
        (void)fprintf(stderr, s, c, v); \
    } \
} while (0)

/*
 * 描述:内部使用
 */
static INT32 LocalOptionProcess(CHAR * const *nargv, const CHAR *options, const mmStructOption *longOption,
    INT32 match, CHAR *hasEqual)
{
    if (longOption->has_arg == MMPA_NO_ARGUMENT && hasEqual) {
        ERRB(OPT_NO_ARG, (INT32)strlen(longOption->name), longOption->name);
        if (longOption->flag == nullptr) {
            optopt = longOption->val;
        } else {
            optopt = 0;
        }
        return (MMPA_BADARG);
    }
    if (longOption->has_arg == MMPA_REQUIRED_ARGUMENT || longOption->has_arg == MMPA_OPTIONAL_ARGUMENT) {
        if (hasEqual != nullptr) {
            optarg = hasEqual;
        } else if (longOption->has_arg == MMPA_REQUIRED_ARGUMENT) {
            optarg = nargv[optind++];
        }
    }
    if ((longOption->has_arg == MMPA_REQUIRED_ARGUMENT) && (optarg == nullptr)) {
        ERRA(OPT_REQ_ARG_STRING, longOption->name);
        if (longOption->flag == nullptr) {
            optopt = longOption->val;
        } else {
            optopt = 0;
        }
        --optind;
        return (MMPA_BADARG);
    }
    return 0;
}

/*
 * 描述:内部使用,
 */
static INT32 LocalGetMatch(const CHAR *options, const mmStructOption *longOptions,
    INT32 shortToo, size_t currentArgvLen, INT32 *match)
{
    INT32 i;
    CHAR *currentArgv = g_place;
    for (i = 0; longOptions[i].name; i++) {
        /* find matching long option */
        if (strncmp(currentArgv, longOptions[i].name, currentArgvLen)) {
            continue;
        }
        if (strlen(longOptions[i].name) == currentArgvLen) {
            *match = i;
            break;
        }
        if (shortToo && currentArgvLen == 1) {
            continue;
        }
        if (*match == -1) {
            *match = i;
        } else {
            ERRB(OPT_AMBIGIOUS, (INT32)currentArgvLen, currentArgv);
            optopt = 0;
            return (MMPA_BADCH);
        }
    }
    return 0;
}

/*
 * 描述:内部使用, 解析长选项参数
 * 返回值:如果short_too设置了并且选项不匹配返回-1
 */
static INT32 LocalParseLongOptions(CHAR * const *nargv, const CHAR *options,
                                   const mmStructOption *longOptions, INT32 *idx, INT32 shortToo)
{
    CHAR *currentArgv = nullptr;
    CHAR *hasEqual = nullptr;
    size_t currentArgvLen;
    INT32 match = -1;
    currentArgv = g_place;
    optind++;

    hasEqual = strchr(currentArgv, '=');
    if (hasEqual != nullptr) {
        currentArgvLen = hasEqual - currentArgv;
        hasEqual++;
    } else {
        currentArgvLen = strlen(currentArgv);
    }
    INT32 ret = LocalGetMatch(options, longOptions, shortToo, currentArgvLen, &match);
    if (ret != 0) {
        return ret;
    }

    if (match != -1) {
        ret = LocalOptionProcess(nargv, options, &longOptions[match], match, hasEqual);
        if (ret != 0) {
            return ret;
        }
        if (idx != nullptr) {
            *idx = match;
        }
        if (longOptions[match].flag) {
            *longOptions[match].flag = longOptions[match].val;
            return (0);
        } else {
            return (longOptions[match].val);
        }
    } else  {
        if (shortToo) {
            --optind;
            return (-1);
        }
        ERRA(OPT_ILLEGAL_STRING, currentArgv);
        optopt = 0;
        return (MMPA_BADCH);
    }
}

/*
 * 描述:内部使用
 */
static INT32 LocalNonOption(CHAR * const *nargv, INT32 flags)
{
    g_place = const_cast<CHAR *>(MMPA_EMSG);   /* found non-option */
    if (flags & MMPA_FLAG_ALLARGS) {
        optarg = nargv[optind++];
        return (MMPA_INORDER);
    }
    if (!(flags & MMPA_FLAG_PERMUTE)) {
        return (-1);
    }
    if (g_nonoptStart == -1) {
        g_nonoptStart = optind;
    } else if (g_nonoptEnd != -1) {
        LocalPermuteArgs(g_nonoptStart, g_nonoptEnd, optind, nargv);
        g_nonoptStart = optind - g_nonoptEnd + g_nonoptStart;
        g_nonoptEnd = -1;
    }
    optind++;
    return EN_INVALID_PARAM;
}

/*
 * 描述:内部使用
 */
static INT32 LocalUpdateScanPoint(INT32 nargc, CHAR * const *nargv, const CHAR *options, UINT32 flags)
{
    /* update scanning pointer */
    optreset = 0;
    INT32 ret;
    if (optind >= nargc) {
    /* end of argument vector */
        g_place = const_cast<CHAR *>(MMPA_EMSG);
        if (g_nonoptEnd != -1) {
            LocalPermuteArgs(g_nonoptStart, g_nonoptEnd, optind, nargv);
            optind -= g_nonoptEnd - g_nonoptStart;
        } else if (g_nonoptStart != -1) {
            optind = g_nonoptStart;
        }
        g_nonoptStart = -1;
        g_nonoptEnd = -1;
        return (-1);
    }
    g_place = nargv[optind];
    if (*g_place != '-' || (g_place[1] == '\0' && strchr(options, '-') == nullptr)) {
        ret = LocalNonOption(nargv, flags);
        return ret;
    }
    if (g_nonoptStart != -1 && g_nonoptEnd == -1) {
        g_nonoptEnd = optind;
    }

    if (g_place[1] != '\0' && *++g_place == '-' && g_place[1] == '\0') {
        optind++;
        g_place = const_cast<CHAR *>(MMPA_EMSG);
        if (g_nonoptEnd != -1) {
            LocalPermuteArgs(g_nonoptStart, g_nonoptEnd, optind, nargv);
            optind -= g_nonoptEnd - g_nonoptStart;
        }
        g_nonoptStart = -1;
        g_nonoptEnd = -1;
        return (-1);
    }
    return 0;
}

/*
 * 描述:内部使用
 */
static INT32 LocalTakeArg(INT32 nargc, CHAR * const *nargv, const CHAR *options,
                          CHAR *oli, UINT32 flags, INT32 *optchar)
{
    if (*++oli != ':') {
        if (!*g_place) {
            ++optind;
        }
    } else {
        optarg = nullptr;
        if (*g_place) {
            optarg = g_place;
        } else if (oli[1] != ':') { /* arg not optional */
            if (++optind >= nargc) {    /* no arg */
                g_place = const_cast<CHAR *>(MMPA_EMSG);
                ERRA(OPT_REQ_ARG_CHAR, *optchar);
                optopt = *optchar;
                return (MMPA_BADARG);
            } else {
                optarg = nargv[optind];
            }
        } else if (!(flags & MMPA_FLAG_PERMUTE)) {
            if (optind + 1 < nargc && *nargv[optind + 1] != '-') {
                optarg = nargv[++optind];
            }
        }
        g_place = const_cast<CHAR *>(MMPA_EMSG);
        ++optind;
    }
    return 0;
}

/*
 * 描述:内部使用
 */
static void LocalDisableExten(const CHAR *options, UINT32 flags)
{
    static INT32 posixly_correct = -1;
    if (posixly_correct == -1) {
        posixly_correct = (getenv("POSIXLY_CORRECT") != nullptr);
    }
    if (posixly_correct || *options == '+') {
        flags &= ~MMPA_FLAG_PERMUTE;
    } else if (*options == '-') {
        flags |= MMPA_FLAG_ALLARGS;
    }
    if (*options == '+' || *options == '-') {
        options++;
    }
    if (optind == MMPA_ZERO) {
        optind = optreset = 1;
    }
    optarg = nullptr;
    if (optreset) {
        g_nonoptStart = g_nonoptEnd = -1;
    }
}

/*
 * 描述:内部使用
 */
static INT32 LocalJudgeMinus(const CHAR *options, INT32 *optchar, CHAR **oli)
{
    if (((*optchar = (INT32)*g_place++) == (INT32)':') || (*optchar == (INT32)'-' && *g_place != '\0') ||
        ((*oli = const_cast<CHAR *>(strchr(options, *optchar))) == nullptr)) {
        if (*optchar == (INT32)'-' && *g_place == '\0') {
            return (-1);
        }
        if (!*g_place) {
            ++optind;
        }
        ERRA(OPT_ILLEGAL_CHAR, *optchar);
        optopt = *optchar;
        return (MMPA_BADCH);
    }
    return 0;
}

/*
 * 描述:内部使用
 */
static INT32 LocalJudgeW(INT32 nargc, CHAR * const *nargv, const CHAR *options,
                         const mmStructOption *longOptions, INT32 *idx)
{
    INT32 optchar = 'W';

    if (*g_place == MMPA_ZERO) {
        if (++optind >= nargc) {    /* no arg */
            g_place = const_cast<CHAR *>(MMPA_EMSG);
            ERRA(OPT_REQ_ARG_CHAR, optchar);
            optopt = optchar;
            return -1;
        } else {    /* white space */
            g_place = nargv[optind];
        }
    }
    optchar = LocalParseLongOptions(nargv, options, longOptions, idx, 0);
    g_place = const_cast<CHAR *>(MMPA_EMSG);
    return (optchar);
}

/*
 * 描述:内部使用
 */
static INT32 LocalJudgeM(CHAR * const *nargv, const CHAR *options,
                         const mmStructOption *longOptions, INT32 *idx, INT32 *optchar)
{
    INT32 shortToo = 0;
    if (*g_place == '-') {
        g_place++;    /* --foo long option */
    } else if (*g_place != ':' && strchr(options, *g_place) != nullptr) {
        shortToo = 1;   /* could be short option too */
    }
    *optchar = LocalParseLongOptions(nargv, options, longOptions, idx, shortToo);
    if (*optchar != EN_ERROR) {
        g_place = const_cast<CHAR *>(MMPA_EMSG);
        return (*optchar);
    }
    return 0;
}

/*
 * 描述:内部使用, 解析命令行参数
 */
static INT32 LocalGetOptInternal(INT32 nargc, CHAR * const *nargv, const CHAR *options,
                                 const mmStructOption *longOptions, INT32 *idx, UINT32 flags)
{
    CHAR *optList = nullptr;
    INT32 optChar = 0;
    INT32 ret;
START:
    if (optreset || !*g_place) {
        ret = LocalUpdateScanPoint(nargc, nargv, options, flags);
        if (ret == EN_INVALID_PARAM) {
            goto START;
        } else if (ret != MMPA_ZERO) {
            return ret;
        }
    }

    if (longOptions != nullptr && g_place != nargv[optind] && (*g_place == '-' || (flags & MMPA_FLAG_LONGONLY))) {
        ret = LocalJudgeM(nargv, options, longOptions, idx, &optChar);
        if (ret != MMPA_ZERO) {
            return optChar;
        }
    }

    ret = LocalJudgeMinus(options, &optChar, &optList);
    if (ret != MMPA_ZERO) {
        return ret;
    }

    if (longOptions != nullptr && optChar == 'W' && optList[1] == ';') {
        ret = LocalJudgeW(nargc, nargv, options, longOptions, idx);
        return ret;
    }

    ret = LocalTakeArg(nargc, nargv, options, optList, flags, &optChar);
    if (ret != MMPA_ZERO) {
        return ret;
    }
    /* dump back option letter */
    return (optChar);
}

/*
 * 描述:获取变量opterr的值
 * 返回值：获取到opterr的值
 */
INT32 mmGetOptErr()
{
    return opterr;
}

/*
 * 描述:设置变量opterr的值
 * mmOptErr：设置的值
 */
VOID mmSetOptErr(INT32 mmOptErr)
{
    opterr = mmOptErr;
}

/*
 * 描述:获取变量optind的值
 * 返回值：获取到optind的值
 */
INT32 mmGetOptInd()
{
    return optind;
}

/*
 * 描述:设置变量optind的值
 * mmOptInd：设置的值
 */
VOID mmSetOptInd(INT32 mmOptInd)
{
    optind = mmOptInd;
}

/*
 * 描述:获取变量optopt的值
 * 返回值：获取到optopt的值
 */
INT32 mmGetOptOpt()
{
    return optopt;
}

/*
 * 描述:设置变量optopt的值
 * mmOptOpt：设置的值
 */
VOID mmSetOpOpt(INT32 mmOptOpt)
{
    optopt = mmOptOpt;
}

/*
 * 描述:获取变量optarg的值
 * 返回值：获取到optarg的指针
 */
CHAR *mmGetOptArg()
{
    return optarg;
}

/*
 * 描述:设置变量optarg的值
 * mmmOptArg：要设置的指针
 */
VOID mmSetOptArg(CHAR *mmOptArg)
{
    optarg = mmOptArg;
}

/*
 * 描述:分析命令行参数
 * 参数:argc--传递的参数个数
 *      argv--传递的参数内容
 *      opts--用来指定可以处理哪些选项
 * 返回值:执行错误, 找不到选项元素, 返回EN_ERROR
 */
INT32 mmGetOpt(INT32 argc, CHAR * const *argv, const CHAR *opts)
{
    if (opts == nullptr) {
        return EN_ERROR;
    } else {
        UINT32 flags = 0;
        LocalDisableExten(opts, flags);
        return (LocalGetOptInternal(argc, argv, opts, nullptr, nullptr, flags));
    }
}

/*
 * 描述:分析命令行参数-长参数
 * 参数:argc--传递的参数个数
 *      argv--传递的参数内容
 *      opts--用来指定可以处理哪些选项
 *      longopts--指向一个mmStructOption的数组
 *      longindex--表示长选项在longopts中的位置
 * 返回值:执行错误, 找不到选项元素, 返回EN_ERROR
 */
INT32 mmGetOptLong(INT32 argc, CHAR * const *argv, const CHAR *opts,
                   const mmStructOption *longopts, INT32 *longindex)
{
    if (opts == nullptr) {
        return EN_ERROR;
    } else {
        UINT32 flags = MMPA_FLAG_PERMUTE;
        LocalDisableExten(opts, flags);
        return (LocalGetOptInternal(argc, argv, opts, longopts, longindex, flags));
    }
}

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

