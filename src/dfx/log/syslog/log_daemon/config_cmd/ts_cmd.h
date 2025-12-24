/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TS_CMD_H
#define TS_CMD_H

#include "config_common.h"

#ifdef __cplusplus
extern "C" {
#endif
void TsCmdGetConfig(char *resultBuf, uint32_t bufLen, uint16_t devId);
int32_t TsCmdSetConfig(const struct MsnReq *req, uint16_t devId, char *resultBuf, uint32_t bufLen);
#ifdef __cplusplus
}
#endif

#endif