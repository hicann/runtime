/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef LOG_COMPRESS_H
#define LOG_COMPRESS_H

#include <stdbool.h>
#include "log_error_code.h"

#define GZIP_SUFFIX         ".gz"
#define GZIP_BUFLEN         16384U
#define GZIP_MAX_NAME_LEN   1024U

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

bool LogCompressSwitch(void);
LogStatus LogCompressAddSuffix(char *file, uint32_t length);
LogStatus LogCompressFile(const char *file);
LogStatus LogCompressGetRotatePath(char *file, uint32_t length);
bool LogCompressCheckUnzipSuffix(const char *fileName);

LogStatus LogCompressFileRotate(const char *file);
LogStatus LogCompressBuffer(const char *source, uint32_t sourceLen, char **dest, uint32_t *destLen);

bool LogCompressCheckActiveFile(const char *fileName);

#ifdef __cplusplus
}
#endif // __cplusplus
#endif
