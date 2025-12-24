/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSPROFTX_ADAPTOR_H
#define MSPROFTX_ADAPTOR_H
#include "acl/acl_base.h"
#include "prof_report_api.h"

using CONST_VOID_PTR = const void *;

/**
* @name MsprofTxInit
* @brief Init msproftx for prof_acl_mgr.cpp
* @retval void
*/
extern "C" void MsprofTxInit();

/**
 * @name  MsprofTxUnInit
 * @brief Destroy or uninit msproftx for prof_acl_mgr.cpp
 * @return void
 */
extern "C" void MsprofTxUnInit();

extern "C" void* ProfAclCreateStamp();
extern "C" void ProfAclDestroyStamp(VOID_PTR stamp);
extern "C" int32_t ProfAclSetCategoryName(uint32_t category, const char *categoryName);
extern "C" int32_t ProfAclSetStampCategory(VOID_PTR stamp, uint32_t category);
extern "C" int32_t ProfAclSetStampPayload(VOID_PTR stamp, const int32_t type, CONST_VOID_PTR value);
extern "C" int32_t ProfAclSetStampTraceMessage(VOID_PTR stamp, const char *msg, uint32_t msgLen);
extern "C" int32_t ProfAclMark(VOID_PTR stamp);
extern "C" int32_t ProfAclMarkEx(const char *msg, size_t msgLen, aclrtStream stream);
extern "C" int32_t ProfAclPush(VOID_PTR stamp);
extern "C" int32_t ProfAclPop();
extern "C" int32_t ProfAclRangeStart(VOID_PTR stamp, uint32_t *rangeId);
extern "C" int32_t ProfAclRangeStop(uint32_t rangeId);
extern "C" MSVP_PROF_API void ProfImplSetAdditionalBufPush(const ProfAdditionalBufPushCallback func);
extern "C" MSVP_PROF_API void ProfImplSetMarkEx(const ProfMarkExCallback func);
extern "C" MSVP_PROF_API void ProfImplInitMstxInjection(const ProfRegisterMstxFuncCallback func);

#endif
