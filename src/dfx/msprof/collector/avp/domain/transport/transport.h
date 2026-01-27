/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DOMAIN_TRANSPORT_TRANSPORT_H
#define DOMAIN_TRANSPORT_TRANSPORT_H
#define MAX_OUTPUT_FILE_LEGTH 512 // equal to DEFAULT_OUTPUT_MAX_LEGTH
#define MAX_FILE_CHUNK_NAME_LENGTH 128U

#include <stdint.h>
#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    FILE_TRANSPORT,
    FLSH_TRANSPORT
} TransportType;

typedef enum {
    PROF_CTRL_DATA = 2,
    PROF_DEVICE_DATA = 3,
    PROF_HOST_DATA = 5,
} FileChunkType;

typedef struct {
    uint8_t isLastChunk;                                      // is last chunk or not
    uint8_t deviceId;                                         // report data fill suffix enum "devId"
    uint16_t chunkType;                                       // form FileChunkType
    uint64_t chunkSize;                                       // chunk size
    uint32_t offset;                                          // flush chunk to file by offset, -1：append
    uint8_t* chunk;                                           // chunk data
    char fileName[MAX_FILE_CHUNK_NAME_LENGTH];               // flush chunk to disks by "fileName.tag"
} ProfFileChunk;

typedef struct {
    int32_t (*SendBuffer)(ProfFileChunk *chunk, const char* dir);
    int32_t (*Flush)();
} Transport;

int32_t CreateUploaderTransport(uint32_t deviceId, TransportType type, Transport* transport,
    const char *flushDir);

#ifdef __cplusplus
}
#endif
#endif