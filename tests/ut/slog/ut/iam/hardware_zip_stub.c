/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_print_syslog.h"
#include "zip_sdk.h"

#define ZIP_BLOCK_SIZE (1024U * 1024U)

static char g_zipInput[ZIP_BLOCK_SIZE];
static char g_zipOutput[ZIP_BLOCK_SIZE];
static int g_deflateInitResult = HZIP_OK;
static int g_deflateResult = HZIP_STREAM_END;
static unsigned long g_deflateAvailOut = ZIP_BLOCK_SIZE - 1U;
static int g_deflateEndResult = HZIP_OK;

void HardwareZipStubReset(void)
{
    g_deflateInitResult = HZIP_OK;
    g_deflateResult = HZIP_STREAM_END;
    g_deflateAvailOut = ZIP_BLOCK_SIZE - 1U;
    g_deflateEndResult = HZIP_OK;
}

void HardwareZipStubSetDeflateInitResult(int result)
{
    g_deflateInitResult = result;
}

void HardwareZipStubSetDeflateResult(int result, unsigned long availOut)
{
    g_deflateResult = result;
    g_deflateAvailOut = availOut;
}

void HardwareZipStubSetDeflateEndResult(int result)
{
    g_deflateEndResult = result;
}

void LogPrintSys(int32_t priority, const char* format, ...)
{
    (void)priority;
    (void)format;
}

int hw_deflateInit2_(
    struct zip_stream* stream, int level, int method, int windowBits, int memLevel, int strategy, const char* version,
    int streamSize)
{
    (void)level;
    (void)method;
    (void)windowBits;
    (void)memLevel;
    (void)strategy;
    (void)version;
    (void)streamSize;
    if (g_deflateInitResult == HZIP_OK) {
        stream->next_in = g_zipInput;
        stream->next_out = g_zipOutput;
    }
    return g_deflateInitResult;
}

int hw_deflate(struct zip_stream* stream, int flush)
{
    (void)flush;
    g_zipOutput[0] = 'z';
    stream->avail_out = g_deflateAvailOut;
    return g_deflateResult;
}

int hw_deflateEnd(struct zip_stream* stream)
{
    (void)stream;
    return g_deflateEndResult;
}
