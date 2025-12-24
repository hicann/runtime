/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_RECV_H
#define LOG_RECV_H
#if (OS_TYPE_DEF == 0)
#include "ascend_hal.h"
#endif
#include "log_common.h"
#include "log_recv_interface.h"
#include "log_queue.h"
#include "log_to_file.h"
#include "log_system_api.h"
#include "slogd_buffer.h"
#include "log_session_manage.h"

#define WRITE_INTERVAL          1
#define ONE_HUNDRED_MILLISECOND 100
#define TWO_HUNDRED_MILLISECOND 200

#ifdef __cplusplus
extern "C" {
#endif

void SlogdFirmwareLogReceive(void *args);
int32_t SlogdFirmwareLogFlush(void *args, uint32_t len, bool flushFlag);
void SlogdFirmwareLogGet(SessionItem *handle, void *buffer, uint32_t bufferLen, int32_t devId);
LogStatus SlogdFirmwareLogResInit(void);
void SlogdFirmwareLogResExit(void);

#ifdef __cplusplus
}
#endif
#endif
