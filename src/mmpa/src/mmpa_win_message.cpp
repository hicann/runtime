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
 * 描述:创建一个消息队列用于进程间通信
 * 参数:key--消息队列的KEY键值,
 *      msgFlag--取消息队列标识符
 * 返回值:执行成功则返回打开的消息队列ID, 执行错误返回EN_ERROR
 */
mmMsgid mmMsgOpen(mmKey_t key, INT32 msgFlag)
{
    CHAR pipeName[MAX_PATH] = {0};
    INT32 ret = _snprintf_s(pipeName, sizeof(pipeName) - 1, "\\\\.\\pipe\\%d", key);
    if (ret < MMPA_ZERO) {
        return (mmMsgid)EN_ERROR;
    }
    // 打开命名管道
    mmMsgid namedPipeId = CreateFile((LPCSTR)pipeName, GENERIC_READ | GENERIC_WRITE, 0, nullptr,
        OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, nullptr);
    if (namedPipeId == INVALID_HANDLE_VALUE) {
        if (GetLastError() == ERROR_FILE_NOT_FOUND) { // 打开失败，说明还没有创建命名管道
            namedPipeId = CreateNamedPipe((LPCSTR)pipeName, PIPE_ACCESS_DUPLEX | FILE_FLAG_OVERLAPPED, 0, 1,
                MMPA_PIPE_BUF_SIZE, MMPA_PIPE_BUF_SIZE, 0, nullptr);
            if (namedPipeId == INVALID_HANDLE_VALUE) {
                namedPipeId = nullptr;
                return (mmMsgid)EN_ERROR;
            }
        } else {
            namedPipeId = nullptr;
            return (mmMsgid)EN_ERROR;
        }
    }
    return namedPipeId;
}

/*
 * 描述:扫描目录对应的内存释放函数
 * 参数:key--消息队列的KEY键值,
 *      msgFlag--取消息队列标识符
 * 返回值:执行成功则返回打开的消息队列ID, 执行错误返回EN_ERROR
 */
mmMsgid mmMsgCreate(mmKey_t key, INT32 msgFlag)
{
    CHAR pipeName[MAX_PATH] = {0};
    INT32 ret = _snprintf_s(pipeName, sizeof(pipeName) - 1, "\\\\.\\pipe\\%d", key);
    if (ret < MMPA_ZERO) {
        return (mmMsgid)EN_ERROR;
    }
    // 这里创建的是双向模式且使用重叠模式的命名管道
    mmMsgid namedPipe = CreateNamedPipe((LPCSTR)pipeName, PIPE_ACCESS_DUPLEX | FILE_FLAG_OVERLAPPED, 0, 1,
                                        MMPA_PIPE_BUF_SIZE, MMPA_PIPE_BUF_SIZE, 0, nullptr);
    if (namedPipe == INVALID_HANDLE_VALUE) {
        if (GetLastError() == ERROR_PIPE_BUSY) { // 说明管道已经创建，打开就可以
            namedPipe = CreateFile((LPCSTR)pipeName, GENERIC_READ | GENERIC_WRITE, 0, nullptr,
                                   OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, nullptr);
            if (namedPipe == INVALID_HANDLE_VALUE) {
                namedPipe = nullptr;
                return (mmMsgid)EN_ERROR;
            }
        } else {
            namedPipe = nullptr;
            return (mmMsgid)EN_ERROR;
        }
    }
    return namedPipe;
}

/*
 * 描述:往消息队列发送消息
 * 参数:msqid--消息队列ID
 *      buf--由用户分配内存
 *      bufLen--缓存长度
 *      msgFlag--消息标志位
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmMsgSnd(mmMsgid msqid, VOID *buf, INT32 bufLen, INT32 msgFlag)
{
    if (buf == nullptr || bufLen <= MMPA_ZERO || msqid == INVALID_HANDLE_VALUE) {
        return EN_INVALID_PARAM;
    }

    DWORD dwWrite = 0;
    ConnectNamedPipe(msqid, nullptr); // 阻塞等待，直到对端管道打开

    if (WriteFile(msqid, buf, bufLen, &dwWrite, nullptr) == MMPA_ZERO) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:从消息队列接收消息
 * 参数:msqid--消息队列ID
 *      bufLen--缓存长度
 *      msgFlag--消息标志位
 *      buf--由用户分配内存
 * 返回值:执行成功返回接收的长度, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmMsgRcv(mmMsgid msqid, VOID *buf, INT32 bufLen, INT32 msgFlag)
{
    if (buf == nullptr || bufLen <= MMPA_ZERO || msqid == INVALID_HANDLE_VALUE) {
        return EN_INVALID_PARAM;
    }

    DWORD dwRead = 0;
    ConnectNamedPipe(msqid, nullptr); // 阻塞等待，直到对端管道打开

    if (ReadFile(msqid, buf, bufLen, &dwRead, nullptr) == MMPA_ZERO) {
        return EN_ERROR;
    }
    return (INT32)dwRead;
}

/*
 * 描述:关闭创建的消息队列
 * 参数:msqid--消息队列ID
 * 返回值:执行成功返回EN_OK
 */
INT32 mmMsgClose(mmMsgid msqid)
{
    if (msqid != INVALID_HANDLE_VALUE) {
        (void)CloseHandle(msqid);
    }
    return EN_OK;
}

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

