/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef _MMPA_LINUX_STUBTEST_H_
#define _MMPA_LINUX_STUBTEST_H_

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif /* __cpluscplus */
#endif /* __cpluscplus */

extern mmCond   cond;
extern mmMutexFC  mtxfc;
extern int socketFlag;
extern  mmThreadKey g_thread_log_key;


extern INT32 getIdleSocketid();
extern VOID* UTtest_callback(VOID * pstArg);
extern VOID* client_socket(VOID* p);
extern VOID* server_socket(VOID* p);
extern VOID* thread_func(VOID *arg);
extern VOID* thread_func_time(VOID *arg);
extern VOID pollDataCallback(pmmPollData pPolledData);
extern VOID* poll_server_socket(VOID* p);
extern VOID* poll_client_socket(VOID* p);
extern VOID* poll_server_pipe(VOID* p);
extern VOID* poll_client_pipe(VOID* p);
extern VOID* poll_server_namepipe(VOID* p);
extern VOID* poll_client_namepipe(VOID* p);

extern int utFilter(const struct dirent *entry);
extern VOID* msgqueue_server(VOID* p);
extern VOID* msgqueue_client(VOID* p);
extern VOID *tlsTestThread1(VOID *p);
extern VOID *tlsTestThread2(VOID *p);
extern void *thread_action(void* arg);

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

#endif /* _MMPA_LINUX_STUBTEST_H_ */

