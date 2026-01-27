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
#if    __cplusplus
extern "C" {
#endif /* __cpluscplus */
#endif /* __cpluscplus */

/*
 * 描述:获取变量opterr的值
 * 返回值：获取到opterr的值
 */
INT32 mmGetOptErr(VOID)
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
INT32 mmGetOptInd(VOID)
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
INT32 mmGetOptOpt(VOID)
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
CHAR *mmGetOptArg(VOID)
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
INT32 mmGetOpt(INT32 argc, CHAR * const * argv, const CHAR *opts)
{
    return getopt(argc, argv, opts);
}

/*
 * 描述:分析命令行参数-长参数
 * 参数:argc--传递的参数个数
 *      argv--传递的参数内容
 *      opts--用来指定可以处理哪些选项
 *      longOpts--指向一个mmStructOption的数组
 *      longIndex--表示长选项在longopts中的位置
 * 返回值:执行错误, 找不到选项元素, 返回EN_ERROR
 */
INT32 mmGetOptLong(INT32 argc, CHAR * const * argv, const CHAR *opts, const mmStructOption *longOpts, INT32 *longIndex)
{
    return getopt_long(argc, argv, opts, longOpts, longIndex);
}

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

