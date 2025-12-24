/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PROF_MSTX_PLUGIN_H
#define PROF_MSTX_PLUGIN_H

#include <cstdint>
#include "acl/acl_base.h"
#include "prof_acl_api.h"
#include "mstx_def.h"

namespace ProfApi {
namespace MstxPlugin {

void MstxMarkAImpl(const char* message, aclrtStream stream);
mstxRangeId MstxRangeStartAImpl(const char* message, aclrtStream stream);
void MstxRangeEndImpl(mstxRangeId id);
void MstxGetToolIdImpl(uint64_t *id);
mstxDomainHandle_t MstxDomainCreateAImpl(const char *name);
void MstxDomainDestroyImpl(mstxDomainHandle_t domain);
void MstxDomainMarkAImpl(mstxDomainHandle_t domain, const char *message, aclrtStream stream);
mstxRangeId MstxDomainRangeStartAImpl(mstxDomainHandle_t domain, const char *message,
    aclrtStream stream);
void MstxDomainRangeEndImpl(mstxDomainHandle_t domain, mstxRangeId id);
int GetModuleTableFunc(MstxGetModuleFuncTableFunc getFuncTable);
void ProfRegisterMstxFunc(MstxInitInjectionFunc mstxInitFunc, ProfModule module);
void EnableMstxFunc(ProfModule module);
int MsptiMstxGetModuleFuncTable(MstxFuncModule module, MstxFuncTable* outTable, unsigned int* outSize);
int MsprofMstxGetModuleFuncTable(MstxFuncModule module, MstxFuncTable* outTable, unsigned int* outSize);

using MstxMarkAFunc = decltype(&MstxMarkAImpl);
using MstxRangeStartAFunc = decltype(&MstxRangeStartAImpl);
using MstxRangeEndFunc = decltype(&MstxRangeEndImpl);
using MstxGetToolIdFunc = decltype(&MstxGetToolIdImpl);
using MstxDomainCreateAFunc = decltype(&MstxDomainCreateAImpl);
using MstxDomainDestroyFunc = decltype(&MstxDomainDestroyImpl);
using MstxDomainMarkAFunc = decltype(&MstxDomainMarkAImpl);
using MstxDomainRangeStartAFunc = decltype(&MstxDomainRangeStartAImpl);
using MstxDomainRangeEndFunc = decltype(&MstxDomainRangeEndImpl);
using MstxGetModuleFuncTableFunc = int (*)(MstxFuncModule module, MstxFuncTable *outTable, unsigned int *outSize);
using MstxInitInjectionFunc = int (*)(MstxGetModuleFuncTableFunc);
}
}

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

// for msprof and mspti to register mstx functions
MSVP_PROF_API void ProfRegisterMstxFunc(MstxInitInjectionFunc mstxInitFunc, ProfModule module);

// for msprof and mspti to enable current mstx module
MSVP_PROF_API void ProfEnableMstxFunc(ProfModule module);

// for mstx to init mstx impl functions injection
int InitInjectionMstx(MstxGetModuleFuncTableFunc getFuncTable);

#ifdef __cplusplus
}
#endif


#endif
