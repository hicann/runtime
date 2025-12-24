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

#include "zip_sdk.h"
#include "appmon_lib.h"
#include "ascend_hal.h"
#include "log_pm_sig.h"
#include <sys/shm.h>
#include <sys/file.h>
#include <sys/ipc.h>

#ifdef __cplusplus
extern "C" {
#endif

int hw_deflateInit2_(struct zip_stream *zstrm, int level, int method, int windowBits,
                     int memLevel, int strategy, const char *version, int stream_size);
int hw_deflate(struct zip_stream *zstrm, int flush);
int hw_deflateEnd(struct zip_stream *zstrm);

int32_t LogGetSigNo_stub(void);

void log_release_buffer(void);

#ifdef __cplusplus
}
#endif
#endif // ASCEND_HAL_STUB_H

