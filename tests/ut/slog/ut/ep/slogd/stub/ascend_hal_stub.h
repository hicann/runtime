/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ASCEND_HAL_STUB_H
#define ASCEND_HAL_STUB_H

#include "ascend_hal.h"
#include "ascend_hal.h"
#include "log_pm_sig.h"
#include <sys/shm.h>
#include <sys/file.h>
#include <sys/ipc.h>

#ifdef __cplusplus
extern "C" {
#endif

int32_t LogGetSigNo_stub(void);
void log_release_buffer(void);
int32_t log_read_by_type_stub_no_data(int device_id, char *buf, unsigned int *size, int timeout, enum log_channel_type channel_type);
int32_t log_read_by_type_stub_data(int device_id, char *buf, unsigned int *size, int timeout, enum log_channel_type channel_type);

drvError_t halGetDeviceInfo_stub(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value);
#ifdef __cplusplus
}
#endif
#endif // ASCEND_HAL_STUB_H

