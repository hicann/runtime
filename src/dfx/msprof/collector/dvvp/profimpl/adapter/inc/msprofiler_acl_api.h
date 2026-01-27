/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSPROFILER_ACL_API_H
#define MSPROFILER_ACL_API_H

#include "utils/utils.h"
#include "acl_base.h"
#include "acl/acl_prof.h"
#include "prof_acl_intf.h"
#include "transport/transport.h"
#include "prof_acl_mgr.h"

using PROF_CONFIG_CONST_PTR = const ProfConfig *;
using PROF_CONFIG_PTR = ProfConfig *;

namespace Msprofiler {
namespace AclApi {
using namespace Msprof::Engine::Intf;
using namespace analysis::dvvp::common::utils;
using ProfCreateTransportFunc = SHARED_PTR_ALIA<analysis::dvvp::transport::ITransport> (*)();

aclError ProfInit(ProfType type, CONST_CHAR_PTR profilerResultPath, size_t length);
aclError ProfWarmup(ProfType type, PROF_CONFIG_CONST_PTR profilerConfig);
aclError ProfStart(ProfType type, PROF_CONFIG_CONST_PTR profilerConfig);
aclError ProfStop(ProfType type, PROF_CONFIG_CONST_PTR profilerConfig);
aclError ProfFinalize(ProfType type);
aclError ProfSetConfig(aclprofConfigType configType, const char *config, size_t configLength);
aclError ProfModelSubscribe(ProfType type, const uint32_t modelId, const aclprofSubscribeConfig *profSubscribeConfig);
aclError ProfModelUnSubscribe(ProfType type, const uint32_t modelId);
aclError ProfOpSubscribe(uint32_t devId, const aclprofSubscribeConfig *profSubscribeConfig);
aclError ProfOpUnSubscribe(uint32_t devId);
aclError ProfSubscribe(ProfType type, const Msprofiler::Api::ProfSubscribeKey &subscribeKey, const uint32_t devId,
                       const aclprofSubscribeConfig *profSubscribeConfig);
aclError ProfUnSubscribe(ProfType type, const Msprofiler::Api::ProfSubscribeKey &subscribeKey);
aclError ProfCheckModelLoaded(const uint32_t modelId, uint32_t &devId);
aclError ProfGetOpDescSize(SIZE_T_PTR opDescSize);
aclError ProfGetOpNum(CONST_VOID_PTR opInfo, size_t opInfoLen, UINT32_T_PTR opNumber);
aclError ProfGetOpTypeLen(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index, SIZE_T_PTR opTypeLen);
aclError ProfGetOpType(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index, CHAR_PTR opType, size_t opTypeLen);
aclError ProfGetOpNameLen(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index, SIZE_T_PTR opNameLen);
aclError ProfGetOpName(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index, CHAR_PTR opName, size_t opNameLen);
int32_t ProfAclDrvGetDevNum(void);
size_t ProfGetModelId(ProfType type, CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index);
uint64_t ProfAclGetOpTime(uint32_t type, CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index);
int32_t ProfAclGetOpVal(uint32_t type, CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index,
                        VOID_PTR data, size_t len);
const char *ProfAclGetOpAttriVal(uint32_t type, const void *opInfo, size_t opInfoLen, uint32_t index, uint32_t attri);
SHARED_PTR_ALIA<analysis::dvvp::transport::ITransport> CreateParserTransport();
void ProfRegisterTransport(ProfCreateTransportFunc callback);
aclError ProfAclGetCompatibleFeatures(size_t *featuresSize, void **featuresData);
aclError ProfAclGetCompatibleFeaturesV2(size_t *featuresSize, void **featuresData);
aclError ProfAclRegisterDeviceCallback();
PROF_CONFIG_CONST_PTR ProfSetDefaultConfig();
PROF_CONFIG_CONST_PTR ProfGetCurrentConfig();
}
}
#endif
