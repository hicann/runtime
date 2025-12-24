/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef HDCLOG_DEVICE_INIT_H
#define HDCLOG_DEVICE_INIT_H
#include "adcore_api.h"

#define GET_DEVICE_LOG_LEVEL_SUCCESS_FLAG "[event]"

int32_t HdclogDeviceInit(void);
int32_t HdclogDeviceDestroy(void);
int32_t IdeDeviceLogProcess(const CommHandle *command, const void* value, uint32_t len);
#endif
