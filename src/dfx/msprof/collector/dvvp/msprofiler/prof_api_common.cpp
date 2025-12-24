/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_api_common.h"
#include "acl/acl_prof.h"
#include "errno/error_code.h"
#include "prof_acl_intf.h"
#include "prof_inner_api.h"
#include "data_struct.h"

using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Analyze;
using namespace Msprof::Engine::Intf;
aclprofSubscribeConfig *aclprofCreateSubscribeConfig(
    int8_t opTimeSwitch, aclprofAicoreMetrics aicoreMetrics, VOID_PTR fd)
{
    if (fd == nullptr) {
        MSPROF_LOGE("fd is nullptr");
        return nullptr;
    }

    static const int8_t PROF_TIME_INFO_SWITCH_OFF = 0;
    static const int8_t PROF_TIME_INFO_SWITCH_ON = 1;
    if (opTimeSwitch != PROF_TIME_INFO_SWITCH_OFF && opTimeSwitch != PROF_TIME_INFO_SWITCH_ON) {
        MSPROF_LOGE("opTimeSwitch %d out of switch's range [%d, %d]", opTimeSwitch,
            PROF_TIME_INFO_SWITCH_OFF, PROF_TIME_INFO_SWITCH_ON);
        return nullptr;
    }
    aclprofSubscribeConfig *subscribeConfig = new (std::nothrow)aclprofSubscribeConfig;
    if (subscribeConfig == nullptr) {
        MSPROF_LOGE("new aclprofSubscribeConfig failed");
        MSPROF_ENV_ERROR("EK0201", std::vector<std::string>({"buf_size"}),
            std::vector<std::string>({std::to_string(sizeof(aclprofSubscribeConfig))}));
        return nullptr;
    }
    subscribeConfig->config.timeInfo = opTimeSwitch;
    subscribeConfig->config.aicoreMetrics = static_cast<ProfAicoreMetrics>(aicoreMetrics);
    subscribeConfig->config.fd = fd;
    return subscribeConfig;
}

aclError aclprofDestroySubscribeConfig(const aclprofSubscribeConfig *profSubscribeConfig)
{
    if (profSubscribeConfig == nullptr) {
        MSPROF_LOGE("profSubscribeConfig is nullptr");
        return ACL_ERROR_INVALID_PARAM;
    }
    delete profSubscribeConfig;
    return ACL_SUCCESS;
}

aclError aclprofGetOpDescSize(SIZE_T_PTR opDescSize)
{
    MSPROF_LOGI("start to execute aclprofGetOpDescSize");
    if (opDescSize == nullptr) {
        MSPROF_LOGE("Invalid param of ProfGetOpDescSize");
        return ACL_ERROR_INVALID_PARAM;
    }
    *opDescSize = sizeof(ProfOpDesc);
    return ACL_SUCCESS;
}

aclError aclprofGetOpNum(CONST_VOID_PTR opInfo, size_t opInfoLen, UINT32_T_PTR opNumber)
{
    return ProfAclGetOpVal(ACL_OP_NUM, opInfo, opInfoLen, 0, opNumber, 0);
}

aclError aclprofGetOpTypeLen(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index, SIZE_T_PTR opTypeLen)
{
    return ProfAclGetOpVal(ACL_OP_TYPE_LEN, opInfo, opInfoLen, index, opTypeLen, 0);
}

aclError aclprofGetOpType(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index, CHAR_PTR opType, size_t opTypeLen)
{
    return ProfAclGetOpVal(ACL_OP_TYPE, opInfo, opInfoLen, index, opType, opTypeLen);
}

aclError aclprofGetOpNameLen(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index, SIZE_T_PTR opNameLen)
{
    return ProfAclGetOpVal(ACL_OP_NAME_LEN, opInfo, opInfoLen, index, opNameLen, 0);
}

aclError aclprofGetOpName(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index, CHAR_PTR opName, size_t opNameLen)
{
    return ProfAclGetOpVal(ACL_OP_NAME, opInfo, opInfoLen, index, opName, opNameLen);
}

uint64_t aclprofGetOpStart(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index)
{
    return ProfAclGetOpTime(ACL_OP_START, opInfo, opInfoLen, index);
}

uint64_t aclprofGetOpEnd(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index)
{
    return ProfAclGetOpTime(ACL_OP_END, opInfo, opInfoLen, index);
}

uint64_t aclprofGetOpDuration(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index)
{
    return ProfAclGetOpTime(ACL_OP_DURATION, opInfo, opInfoLen, index);
}


aclprofSubscribeOpFlag aclprofGetOpFlag(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index)
{
    uint32_t result = ProfAclGetOpVal(ACL_OP_GET_FLAG, opInfo, opInfoLen, index, nullptr, 0);
    return static_cast<aclprofSubscribeOpFlag>(result);
}

const char *aclprofGetOpAttriValue(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index,
    aclprofSubscribeOpAttri attri)
{
    return ProfAclGetOpAttriVal(ACL_OP_GET_ATTR, opInfo, opInfoLen, index, attri);
}
