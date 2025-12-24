/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef SLOGD_COMPRESS_H
#define SLOGD_COMPRESS_H

#include <stdbool.h>
#include "log_error_code.h"

#define COMPRESS_LIST_HEAD	        0
#define COMPRESS_LIST_FIRST_TAIL	1
#define COMPRESS_LIST_TAIL	        2

#ifdef __cplusplus
extern "C" {
#endif

LogStatus SlogdCompressInit(void);
void SlogdCompressExit(void);
LogStatus SlogdCompress(const char *source, uint32_t sourceLen, char **dest, uint32_t *destLen);
bool SlogdCompressIsValid(void);

#ifdef __cplusplus
}
#endif
#endif