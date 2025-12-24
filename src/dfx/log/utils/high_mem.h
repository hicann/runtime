/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef HIGH_MEM_H
#define HIGH_MEM_H
#include <stdint.h>
#include <stddef.h>
#include "log_ring_buffer.h"

#ifdef __cplusplus
extern "C" {
#endif
#ifndef HM_DRV_CHAR_DEV_USER_PATH
#define HM_DRV_CHAR_DEV_USER_PATH     "/local/dev/himem"
#endif
#define HM_DRV_IOCTL_BIND_BLOCK       0x000A0001
#define HM_DRV_BLOCK_TYPE_SLOG        0xA050b003U
#define HIMEM_LOG_LENGTH              1023U

typedef struct {
    LogHead head;
    char msg[HIMEM_LOG_LENGTH];
} HimemLogMsg;

int32_t HiMemInit(int32_t *fd);
void HiMemFree(int32_t *fd);
int32_t HiMemWriteIamLog(int32_t fd, RingBufferStat *logBuf);
uint32_t HiMemReadIamLog(int32_t fd, RingBufferStat *logBuf);

#ifdef __cplusplus
}
#endif
#endif