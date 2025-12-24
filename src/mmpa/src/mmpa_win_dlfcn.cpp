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

/*
 * 描述:加载一个动态库中的符号
 * 参数:fileName--动态库文件名
 *      mode--打开方式
 * 返回值:执行成功返回动态链接库的句柄, 执行错误返回nullptr, 入参检查错误返回nullptr
 */
VOID *mmDlopen(const CHAR *fileName, INT32 mode)
{
    if (mode < MMPA_ZERO) {
        return nullptr;
    }

    return LoadLibrary(static_cast<LPCTSTR>(fileName));
}

/*
 * 描述：取有关最近定义给定addr 的符号的信息
 * 参数： addr--指定加载模块的的某一地址
 *       info--是指向mmDlInfo 结构的指针。由用户分配
 * 返回值：执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmDladdr(VOID *addr, mmDlInfo *info)
{
    __declspec(thread) static TCHAR szPath[MAX_PATH];
    HMODULE hModule = nullptr;
    if ((addr == nullptr) || (info == nullptr)) {
        return EN_INVALID_PARAM;
    }

    BOOL bret = GetModuleHandleEx(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS, (LPCSTR)addr, &hModule);
    if (!bret) {
        return EN_ERROR;
    }

    DWORD ret = GetModuleFileName(hModule, szPath, MAX_PATH);
    if (ret == MMPA_ZERO) {
        return EN_ERROR;
    }
    info->dli_fname = szPath;
    return EN_OK;
}

/*
 * 描述:获取mmDlopen打开的动态库中的指定符号地址
 * 参数:handle--mmDlopen 返回的指向动态链接库指针
 *       funcName--要求获取的函数的名称
 * 返回值:执行成功返回指向函数的地址, 执行错误返回nullptr, 入参检查错误返回nullptr
 */
VOID *mmDlsym(VOID *handle, const CHAR *funcName)
{
    if ((handle == nullptr) || (funcName == nullptr)) {
        return nullptr;
    }

    return GetProcAddress((HMODULE)handle, (LPCSTR)funcName);
}

/*
 * 描述:关闭mmDlopen加载的动态库
 * 参数:handle--mmDlopen 返回的指向动态链接库指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmDlclose(VOID *handle)
{
    if (handle == nullptr) {
        return EN_INVALID_PARAM;
    }

    BOOL result = FreeLibrary((HMODULE)handle);
    if (!result) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:当mmDlopen动态链接库操作函数执行失败时，mmDlerror可以返回出错信息
 * 参数:空
 * 返回值:执行成功返回nullptr
 */
CHAR *mmDlerror(void)
{
    return nullptr;
}

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

