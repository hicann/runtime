/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef MMPA_TYPEDEF_WIN_H
#define MMPA_TYPEDEF_WIN_H

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif  // __cpluscplus
#endif  // __cpluscplus

#ifndef FALSE
#define FALSE 0
#endif

#ifndef TRUE
#define TRUE 1
#endif

#define EN_OK 0
#define EN_ERR 1
#define EN_ERROR (-1)
#define EN_INVALID_PARAM (-2)
#define EN_TIMEOUT (-3)

#define HANDLE_INVALID_VALUE (-1)
#define INVALID_SOCKET_HANDLE INVALID_SOCKET
#define MMPA_MEM_MAX_LEN (0x7fffffff)
#define MMPA_PROCESS_ERROR (0x7fffffff)

#define MMPA_ONE_THOUSAND 1000
#define MMPA_COMPUTER_BEGIN_YEAR 1900
#define SUMMER_TIME_OR_NOT (-1)
#define MMPA_ZERO 0
#define MMPA_VALUE_ONE 1
#define MMPA_SOCKET_MAIN_EDITION 2
#define MMPA_SOCKET_SECOND_EDITION 0
#define MMPA_PIPE_BUF_SIZE 1024
#define MMPA_MAX_SCANDIR_COUNT 1024
#define MAX_IOVEC_SIZE 32
#define MMPA_PIPE_COUNT 2
#define MMPA_THREADNAME_SIZE 16
#define MMPA_MIN_OS_NAME_SIZE (MAX_COMPUTERNAME_LENGTH + 1)
#define MMPA_MIN_OS_VERSION_SIZE 64

#define MMPA_MAX_NI 19
#define MMPA_MIDDLE_NI 5
#define MMPA_LOW_NI (-5)
#define MMPA_MIN_NI (-20)
#define MMPA_MAX_FILE 128

#define MMPA_PATH_SEPARATOR_STR "\\"
#define MMPA_PATH_SEPARATOR_CHAR '\\'

#define MMPA_MAX_THREAD_PIO 99
#define MMPA_MIDDLE_THREAD_PIO 66
#define MMPA_LOW_THREAD_PIO 33
#define MMPA_MIN_THREAD_PIO 1

#define MMPA_THREAD_SCHED_RR 0
#define MMPA_THREAD_SCHED_FIFO 0
#define MMPA_THREAD_SCHED_OTHER 0
#define MMPA_THREAD_MIN_STACK_SIZE 0

#define MM_MUTEX_INITIALIZER NULL

#ifdef __cplusplus
#if __cplusplus
}
#endif  // __cpluscplus
#endif  // __cpluscplus
#endif  // _MMPA_TYPEDEF_WIN_H_
