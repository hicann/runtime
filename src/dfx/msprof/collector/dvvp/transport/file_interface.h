/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_TRANSPORT_FILE_INTERFACE_H
#define ANALYSIS_DVVP_TRANSPORT_FILE_INTERFACE_H

#include "domain/transport/transport.h"

#ifdef __cplusplus
extern "C" {
#endif

int32_t ProfInitTransport(uint32_t deviceId, const char *flushDir, const char *storageLimit);
int32_t ProfSendBuffer(ProfFileChunk* chunk, const char* dir);

#ifdef __cplusplus
}
#endif
#endif