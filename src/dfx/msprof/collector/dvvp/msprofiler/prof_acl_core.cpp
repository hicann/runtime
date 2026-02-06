/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_acl_core.h"
#include "acl/acl_base.h"
#include "acl/acl_prof.h"
#include "errno/error_code.h"
#include "logger/msprof_dlog.h"
#include "utils/utils.h"
#include "prof_api_common.h"
#include "prof_acl_intf.h"
#include "prof_api.h"
#include "prof_inner_api.h"

using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::error;
using namespace Msprof::Engine::Intf;

std::mutex g_aclprofMutex;
static uint64_t g_indexId = 1;

aclError aclprofModelSubscribe(const uint32_t modelId, const aclprofSubscribeConfig *profSubscribeConfig)
{
    return ProfAclSubscribe(ACL_API_TYPE, modelId, profSubscribeConfig);
}

aclError aclprofModelUnSubscribe(const uint32_t modelId)
{
    return ProfAclUnSubscribe(ACL_API_TYPE, modelId);
}

size_t aclprofGetModelId(CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index)
{
    return ProfAclGetId(ACL_API_TYPE, opInfo, opInfoLen, index);
}

struct aclprofStepInfo {
    bool startFlag;
    bool endFlag;
    uint64_t indexId;
};

using ACLPROF_STEPINFO_PTR = aclprofStepInfo *;

aclError aclprofGetStepTimestamp(ACLPROF_STEPINFO_PTR stepInfo, aclprofStepTag tag, aclrtStream stream)
{
    if (stepInfo == nullptr) {
        MSPROF_LOGE("stepInfo is nullptr.");
        MSPROF_INPUT_ERROR("EK0003", std::vector<std::string>({"config"}),
            std::vector<std::string>({"stepInfo"}));
        return ACL_ERROR_INVALID_PARAM;
    }
    if (stepInfo->startFlag && tag == ACL_STEP_START) {
        MSPROF_LOGE("This stepInfo already started.");
        return ACL_ERROR_INVALID_PARAM;
    }
    if (stepInfo->endFlag && tag == ACL_STEP_END) {
        MSPROF_LOGE("This stepInfo already stop.");
        return ACL_ERROR_INVALID_PARAM;
    }
    if (tag == ACL_STEP_START) {
        stepInfo->startFlag = true;
    } else {
        stepInfo->endFlag = true;
    }
    auto ret = profSetStepInfo(stepInfo->indexId, tag, stream);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[aclprofGetStepTimestamp]Call ProfSetStepInfo function failed, ret = %d", ret);
        return ACL_ERROR_GE_FAILURE;
    }
    MSPROF_LOGI("[aclprofGetStepTimestamp] Call ProfSetStepInfo success, indexId:%u", stepInfo->indexId);
    return ACL_SUCCESS;
}

ACLPROF_STEPINFO_PTR aclprofCreateStepInfo()
{
    auto stepInfo = new (std::nothrow)aclprofStepInfo();
    if (stepInfo == nullptr) {
        MSPROF_LOGE("new stepInfo fail");
        MSPROF_ENV_ERROR("EK0201", std::vector<std::string>({"buf_size"}),
            std::vector<std::string>({std::to_string(sizeof(aclprofStepInfo))}));
        return nullptr;
    }
    stepInfo->startFlag = false;
    stepInfo->endFlag = false;
    std::lock_guard<std::mutex> lock(g_aclprofMutex);
    stepInfo->indexId = g_indexId++;
    return stepInfo;
}

void aclprofDestroyStepInfo(ACLPROF_STEPINFO_PTR stepInfo)
{
    if (stepInfo == nullptr) {
        MSPROF_LOGE("destroy stepInfo failed, stepInfo must not be nullptr");
        MSPROF_INPUT_ERROR("EK0003", std::vector<std::string>({"config"}),
            std::vector<std::string>({"stepInfo"}));
    } else {
        delete stepInfo;
        MSPROF_LOGI("Successfully destroy stepInfo");
    }
}

void *aclprofCreateStamp()
{
    return ProfAclCreateStamp();
}

void aclprofDestroyStamp(VOID_PTR stamp)
{
    if (stamp == nullptr) {
        return;
    }
    ProfAclDestroyStamp(stamp);
}

aclError aclprofSetCategoryName(uint32_t category, const char *categoryName)
{
    return ProfAclSetCategoryName(category, categoryName);
}

aclError aclprofSetStampCategory(VOID_PTR stamp, uint32_t category)
{
    return ProfAclSetStampCategory(stamp, category);
}

aclError aclprofSetStampPayload(VOID_PTR stamp, const int32_t type, VOID_PTR value)
{
    return ProfAclSetStampPayload(stamp, type, value);
}

aclError aclprofSetStampTraceMessage(VOID_PTR stamp, const char *msg, uint32_t msgLen)
{
    return ProfAclSetStampTraceMessage(stamp, msg, msgLen);
}

aclError aclprofMark(VOID_PTR stamp)
{
    return ProfAclMark(stamp);
}

aclError aclprofMarkEx(const char *msg, size_t msgLen, aclrtStream stream)
{
    return ProfAclMarkEx(msg, msgLen, stream);
}

aclError aclprofPush(VOID_PTR stamp)
{
    return ProfAclPush(stamp);
}

aclError aclprofPop()
{
    return ProfAclPop();
}

aclError aclprofRangeStart(VOID_PTR stamp, uint32_t *rangeId)
{
    return ProfAclRangeStart(stamp, rangeId);
}

aclError aclprofRangeStop(uint32_t rangeId)
{
    return ProfAclRangeStop(rangeId);
}

uint64_t aclprofStr2Id(const char *message)
{
    return ProfStr2Id(message, strlen(message));
}

aclError aclprofRangePushEx(ACLPROF_EVENT_ATTR_PTR attr)
{
    return ProfAclRangePushEx(attr);
}

aclError aclprofRangePop()
{
    return ProfAclRangePop();
}