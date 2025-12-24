/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PROF_INNER_API_H
#define PROF_INNER_API_H

#include <cstddef>
#include <cstdint>
#include "acl/acl_base.h"
#include "prof_acl_api.h"
#include "prof_common.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
#define MSVP_PROF_API __declspec(dllexport)
#else
#define MSVP_PROF_API __attribute__((visibility("default")))
#endif

using PROFAPI_CONFIG_CONST_PTR = const void *; // const aclprofConfig *;
using PROFAPI_SUBSCRIBECONFIG_CONST_PTR = const void *; // const aclprofSubscribeConfig *;
using VOID_PTR = void *;
using CONST_VOID_PTR = const void *;

MSVP_PROF_API int32_t AdprofCheckFeatureIsOn(uint64_t feature);
MSVP_PROF_API int32_t AdprofReportAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length);
MSVP_PROF_API int32_t AdprofReportBatchAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length);
MSVP_PROF_API size_t AdprofGetBatchReportMaxSize(uint32_t type);
MSVP_PROF_API uint64_t AdprofGetHashId(const char *hashInfo, size_t length);

/* ACL API */
MSVP_PROF_API int32_t ProfAclInit(uint32_t type, const char *profilerPath, uint32_t len);
MSVP_PROF_API int32_t ProfAclWarmup(uint32_t type, PROFAPI_CONFIG_CONST_PTR profilerConfig);
MSVP_PROF_API int32_t ProfAclStart(uint32_t type, PROFAPI_CONFIG_CONST_PTR profilerConfig);
MSVP_PROF_API int32_t ProfAclStop(uint32_t type, PROFAPI_CONFIG_CONST_PTR profilerConfig);
MSVP_PROF_API int32_t ProfAclFinalize(uint32_t type);
MSVP_PROF_API int32_t ProfAclSubscribe(uint32_t type, uint32_t modelId, PROFAPI_SUBSCRIBECONFIG_CONST_PTR config);
MSVP_PROF_API int32_t ProfAclUnSubscribe(uint32_t type, uint32_t modelId);
MSVP_PROF_API int32_t ProfAclDrvGetDevNum();
MSVP_PROF_API int32_t ProfAclSetConfig(uint32_t configType, const char *config, size_t configLength);
MSVP_PROF_API uint64_t ProfAclGetOpTime(uint32_t type, const void *opInfo, size_t opInfoLen, uint32_t index);
MSVP_PROF_API size_t ProfAclGetId(uint32_t type, const void *opInfo, size_t opInfoLen, uint32_t index);
MSVP_PROF_API int32_t ProfAclGetOpVal(uint32_t type, const void *opInfo, size_t opInfoLen,
                                      uint32_t index, void *data, size_t len);
MSVP_PROF_API const char *ProfAclGetOpAttriVal(uint32_t type, const void *opInfo, size_t opInfoLen,
                                               uint32_t index, uint32_t attri);
MSVP_PROF_API int32_t ProfAclGetCompatibleFeatures(size_t *featuresSize, void **featuresData);
MSVP_PROF_API int32_t ProfAclGetCompatibleFeaturesV2(size_t *featuresSize, void **featuresData);
MSVP_PROF_API int ProfAclRegisterDeviceCallback();
/**
* @ingroup AscendCL
* @brief create pointer to aclprofstamp
*
*
* @retval aclprofStamp pointer
*/
MSVP_PROF_API void *ProfAclCreateStamp();

/**
* @ingroup AscendCL
* @brief destroy stamp pointer
*
*
* @retval void
*/
MSVP_PROF_API void ProfAclDestroyStamp(void *stamp);

/**
* @ingroup AscendCL
* @brief Record push timestamp
*
* @retval ACL_SUCCESS The function is successfully executed.
* @retval OtherValues Failure
*/
MSVP_PROF_API int32_t ProfAclPush(void *stamp);

/**
* @ingroup AscendCL
* @brief Record pop timestamp
*
*
* @retval ACL_SUCCESS The function is successfully executed.
* @retval OtherValues Failure
*/
MSVP_PROF_API int32_t ProfAclPop();

/**
* @ingroup AscendCL
* @brief Record range start timestamp
*
* @retval ACL_SUCCESS The function is successfully executed.
* @retval OtherValues Failure
*/
MSVP_PROF_API int32_t ProfAclRangeStart(void *stamp, uint32_t *rangeId);

/**
* @ingroup AscendCL
* @brief Record range end timestamp
*
* @retval ACL_SUCCESS The function is successfully executed.
* @retval OtherValues Failure
*/
MSVP_PROF_API int32_t ProfAclRangeStop(uint32_t rangeId);

/**
* @ingroup AscendCL
* @brief set message to stamp
*
*
* @retval void
*/
MSVP_PROF_API int32_t ProfAclSetStampTraceMessage(void *stamp, const char *msg, uint32_t msgLen);

/**
* @ingroup AscendCL
* @brief Record mark timestamp
*
* @retval ACL_SUCCESS The function is successfully executed.
* @retval OtherValues Failure
*/
MSVP_PROF_API int32_t ProfAclMark(void *stamp);

MSVP_PROF_API int32_t ProfAclMarkEx(const char *msg, size_t msgLen, aclrtStream stream);

MSVP_PROF_API int32_t ProfAclSetCategoryName(uint32_t category, const char *categoryName);

MSVP_PROF_API int32_t ProfAclSetStampCategory(VOID_PTR stamp, uint32_t category);

MSVP_PROF_API int32_t ProfAclSetStampPayload(VOID_PTR stamp, const int32_t type, VOID_PTR value);

MSVP_PROF_API bool MsprofHostFreqIsEnable();

MSVP_PROF_API int32_t MsprofSubscribeRawData(MsprofRawDataCallback callback);

MSVP_PROF_API int32_t MsprofUnSubscribeRawData();

#ifdef __cplusplus
}
#endif

#endif
