/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DOMAIN_TRANSPORT_UPLOADER_H
#define DOMAIN_TRANSPORT_UPLOADER_H

#include "osal/osal.h"
#include "osal/osal_mem.h"
#include "osal/osal_thread.h"
#include "transport/transport.h"
#include "cstl/cstl_list.h"
#include "param/profile_param.h"
#include "utils/utils.h"

#ifdef __cplusplus
extern "C" {
#endif

#define UPLOADER_CAPACITY 4096
#define MAX_DEVICE_ID_LEN 3        // 2 + '\0'
#define MAX_RAND_STR_LEN 41        // 40 + '\0'
#define MAX_TIME_FIELD_LEN 33      // 32 + '\0'
#define MAX_RAND_FIELD_LEN 9       // 8 + '\0'
#define MAX_PID_LEN 9              // 8 + '\0'
#define MAX_INDEX_LEN 7            // 6 + '\0'
#define MAX_YEAR_LEN 5             // 4 + '\0'
#define MAX_MONTH_LEN 3            // 2 + '\0'
#define MAX_DAY_LEN 3              // 2 + '\0'
#define MAX_HOUR_LEN 3             // 2 + '\0'
#define MAX_MINUTE_LEN 3           // 2 + '\0'
#define MAX_SECOND_LEN 3           // 2 + '\0'
#define MAX_MILLISECOND_LEN 4      // 3 + '\0'

typedef struct {
    bool destruct;
    bool enable;
    uint32_t deviceId;
    uint32_t capacity;
    uint32_t size;
    uint32_t front;
    uint32_t rear;
    char baseDir[DEFAULT_OUTPUT_MAX_LEGTH];
    Transport *transport;
    OsalCond uploadCond;
    OsalMutex uploadMtx;
    OsalCond notFull;
    OsalCond notEmpty;
    OsalCond clearCond;
    OsalMutex dataMtx;
    ProfFileChunk **dataQueue;
} UploaderAttr;

typedef struct {
    uint32_t devNum;
    CstlList *uploaderList;
    OsalMutex uploaderMtx;
    UploaderAttr *uploaderHost;
} UploaderMgrAttr;

void UploaderFlush(uint32_t deviceId);
int32_t UploaderInitialize(void);
int32_t UploaderFinalize(void);
int32_t CreateDataUploader(ProfileParam *param, TransportType type, uint32_t deviceId, uint32_t capacity);
void DestroyDataUploader(uint32_t deviceId);
int32_t UploaderUploadData(ProfFileChunk *chunk);
UploaderAttr* GetDataUploader(uint32_t deviceId);
int32_t CreateProfMainDir(uint32_t *apiIndex, CHAR *flushDir);
#ifdef __cplusplus
}
#endif
#endif