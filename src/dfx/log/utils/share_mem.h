/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef SHARE_MEM_H
#define SHARE_MEM_H
#include "log_error_code.h"
#include "log_system_api.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    SHM_ERROR = -1,
    SHM_SUCCEED = 0
} ShmErr;

#define CONFIG_PATH_LEN 512U
#define GLOBAL_ARR_LEN  512U
#define MODULE_ARR_LEN  2048U
#define LEVEL_ARR_LEN   1024U

#define MAGIC_HEAD      0x071C2A5B
#define MAGIC_TAIL      0x4F0B73C1
#define MSGTYPE_TAG     0
#define MSGTYPE_STRUCT  1

typedef struct {
    int32_t magicHead;
    int8_t msgType;
    char resv[503]; // keep total size equal to GLOBAL_ARR_LEN
    int32_t magicTail;
} GloablArr;

#define SHM_SIZE 4096U
#define SHM_MODE 0640

ShmErr ShMemCreat(int32_t *shmId, toolMode perm);
ShmErr ShMemOpen(int32_t *shmId);
ShmErr ShMemWrite(int32_t shmId, const char *value, uint32_t len, uint32_t offset);
ShmErr ShMemRead(int32_t shmId, char *value, size_t len, size_t offset);
void ShMemRemove(void);

#ifdef __cplusplus
}
#endif
#endif /* SHARE_MEM_H */
