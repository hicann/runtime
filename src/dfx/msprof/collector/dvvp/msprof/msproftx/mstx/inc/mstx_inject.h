/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSTX_INJECT_H
#define MSTX_INJECT_H

#include <stdint.h>
#include "mstx_def.h"

namespace MsprofMstxApi {
void MstxMarkAFunc(const char* msg, aclrtStream stream);
uint64_t MstxRangeStartAFunc(const char* msg, aclrtStream stream);
void  MstxRangeEndFunc(uint64_t id);
mstxDomainHandle_t MstxDomainCreateAFunc(const char* name);
void MstxDomainDestroyFunc(mstxDomainHandle_t domain);
void MstxDomainMarkAFunc(mstxDomainHandle_t domain, const char* msg, aclrtStream stream);
uint64_t MstxDomainRangeStartAFunc(mstxDomainHandle_t domain, const char* msg, aclrtStream stream);
void MstxDomainRangeEndFunc(mstxDomainHandle_t domain, uint64_t id);
int GetModuleTableFunc(MstxGetModuleFuncTableFunc getFuncTable);
int InitInjectionMstx(MstxGetModuleFuncTableFunc getFuncTable);
}

#endif