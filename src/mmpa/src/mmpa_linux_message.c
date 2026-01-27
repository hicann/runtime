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
 * 描述:创建一个消息队列用于进程间通信
 * 参数:key--消息队列的KEY键值,
 *      msgFlag--取消息队列标识符
 * 返回值:执行成功则返回打开的消息队列ID, 执行错误返回EN_ERROR
 */
mmMsgid mmMsgCreate(mmKey_t key, INT32 msgFlag)
{
    return (mmMsgid)msgget(key, msgFlag);
}

/*
 * 描述:扫描目录对应的内存释放函数
 * 参数:key--消息队列的KEY键值,
 *      msgFlag--取消息队列标识符
 * 返回值:执行成功则返回打开的消息队列ID, 执行错误返回EN_ERROR
 */
mmMsgid mmMsgOpen(mmKey_t key, INT32 msgFlag)
{
    return (mmMsgid)msgget(key, msgFlag);
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
    if ((buf == NULL) || (bufLen <= MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    UINT32 sndLen = (UINT32)bufLen;
    return (INT32)msgsnd(msqid, buf, sndLen, msgFlag);
}

/*
 * 描述:从消息队列接收消息
 * 参数:msqid--消息队列ID
 *      bufLen--缓存长度
 *      msgFlag--消息标志位
 *      buf--由用户分配内存
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmMsgRcv(mmMsgid msqid, VOID *buf, INT32 bufLen, INT32 msgFlag)
{
    if ((buf == NULL) || (bufLen <= MMPA_ZERO)) {
        return EN_INVALID_PARAM;
    }
    UINT32 rcvLen = (UINT32)bufLen;
    return (INT32)msgrcv(msqid, buf, rcvLen, MMPA_DEFAULT_MSG_TYPE, msgFlag);
}

/*
 * 描述:关闭创建的消息队列
 * 参数:msqid--消息队列ID
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR
 */
INT32 mmMsgClose(mmMsgid msqid)
{
    return (INT32)msgctl(msqid, IPC_RMID, NULL);
}

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

