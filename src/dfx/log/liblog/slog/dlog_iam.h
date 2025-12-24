/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DLOG_IAM_H
#define DLOG_IAM_H

#include <stdbool.h>
#include "log_error_code.h"
#include "iam.h"
#include "dlog_common.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
#define IS_BUSY(err)                        (((err) == ETIMEDOUT) || ((err) == EAGAIN) || ((err) == EBUSY))
#define IS_BADFD(err)                       (((err) == EBADFD) || ((err) == EHOSTUNREACH) || ((err) == EBADF) || \
                                            ((err) == EAGAIN) || ((err) == EPIPE))

typedef void (*IamRegisterServer) (void);

int32_t DlogIamInit(void);
void DlogIamExit(void);

int32_t DlogIamIoctlGetLevel(struct IAMIoctlArg *arg);
int32_t DlogIamIoctlFlushLog(struct IAMIoctlArg *arg);
int32_t DlogIamWrite(void* buffer, uint32_t length);
int32_t DlogIamOpenService(void);
void DlogIamRegisterServer(IamRegisterServer regFunc);
bool DlogIamServiceIsValid(void);

#ifdef __cplusplus
}
#endif // __cplusplus

#endif // DLOG_IAM_H