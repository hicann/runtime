/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PLOG_CALLBACK_H_
#define PLOG_CALLBACK_H_

#include <stddef.h>
#include <stdint.h>
#include "acl_log.h"

#ifdef __cplusplus
extern "C" {
#endif

int32_t PlogRegisterCallbackInner(
    acllogRecordCallback callbackFunc, void* userData, uint32_t outputLogType, acllogCallbackHandle* callbackHandle);
int32_t PlogUnregisterCallbackInner(acllogCallbackHandle callback);
void PlogDispatchDeviceLogCallback(int32_t logType, const char* logContent, size_t length);

#ifdef __cplusplus
}
#endif

#endif // PLOG_CALLBACK_H_
