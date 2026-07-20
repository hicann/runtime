/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ZIP_SDK_H
#define ZIP_SDK_H

#define HZIP_LEVEL_DEFAULT 0
#define HZIP_VERSION "1.0.1"
#define HZIP_METHOD_DEFAULT 0
#define HZIP_WINDOWBITS_GZIP 16
#define HZIP_MEM_LEVEL_DEFAULT 0
#define HZIP_STRATEGY_DEFAULT 0
#define HZIP_FLUSH_TYPE_SYNC_FLUSH 2
#define HZIP_FLUSH_TYPE_FINISH 3
#define HZIP_OK 0
#define HZIP_STREAM_END 1

struct zip_stream {
    void* next_in;
    unsigned long avail_in;
    unsigned long total_in;
    void* next_out;
    unsigned long avail_out;
    unsigned long total_out;
    char* msg;
    void* workspace;
    int data_type;
    unsigned long adler;
    void* reserved;
};

int hw_deflateInit2_(
    struct zip_stream* stream, int level, int method, int windowBits, int memLevel, int strategy, const char* version,
    int streamSize);
int hw_deflate(struct zip_stream* stream, int flush);
int hw_deflateEnd(struct zip_stream* stream);

#endif // ZIP_SDK_H
