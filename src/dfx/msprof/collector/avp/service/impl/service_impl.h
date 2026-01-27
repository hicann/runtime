/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SERVICE_IMPL_SERVICE_IMPL_H
#define SERVICE_IMPL_SERVICE_IMPL_H
#include "toolchain/prof_api.h"
#include "osal/osal.h"
int32_t ServiceImplInitialize(void);
int32_t ServiceImplSetConfig(uint32_t dataType, OsalVoidPtr data, uint32_t dataLength);
int32_t ServiceImplRegisterCallback(uint32_t moduleId, ProfCommandHandle handle);
int32_t ServiceImplStart(uint32_t chipId, uint32_t deviceId);
int32_t ServiceImplStop(uint32_t chipId, uint32_t deviceId);
int32_t ServiceImplFinalize(void);
#endif

