/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpu_scheduler_agent.hpp"
#include "error_message_manage.hpp"

namespace {
// aicpu success ret.
constexpr int32_t AICPU_SCHEDULE_RET_SUCCESS = 0;
}

namespace cce {
namespace runtime {
AicpuSchedulerAgent::~AicpuSchedulerAgent()
{
    Destroy();
}

rtError_t AicpuSchedulerAgent::Init()
{
    std::string libName = "libaicpu_scheduler";
    libName += LIBRARY_NAME;
    aicpuSchedulerHandle_ = mmDlopen(libName.c_str(), MMPA_RTLD_NOW);
    if (aicpuSchedulerHandle_ == nullptr) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "open %s library failed, errno=%d.", libName.c_str(), errno);
        return RT_ERROR_DRV_OPEN_AICPU;
    }

    constexpr const char_t *modelLoadFuncName = "AICPUModelLoad";
    loadModelFunc_ = RtPtrToPtr<FUNC_AICPU_MODEL_LOAD>(mmDlsym(aicpuSchedulerHandle_, modelLoadFuncName));
    if (loadModelFunc_ == nullptr) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "find %s func failed.", modelLoadFuncName);
        return RT_ERROR_DRV_SYM_AICPU;
    }

    constexpr const char_t *modelExecuteFuncName = "AICPUModelExecute";
    modelExecuteFunc_ = RtPtrToPtr<FUNC_AICPU_MODEL_OPERATE>(mmDlsym(aicpuSchedulerHandle_,
        modelExecuteFuncName));
    if (modelExecuteFunc_ == nullptr) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "find %s func failed.", modelExecuteFuncName);
        return RT_ERROR_DRV_SYM_AICPU;
    }

    constexpr const char_t *modelDestroyFuncName = "AICPUModelDestroy";
    modelDestroyFunc_ = RtPtrToPtr<FUNC_AICPU_MODEL_OPERATE>(mmDlsym(aicpuSchedulerHandle_,
        modelDestroyFuncName));
    if (modelDestroyFunc_ == nullptr) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "find %s func failed.", modelDestroyFuncName);
        return RT_ERROR_DRV_SYM_AICPU;
    }

    constexpr const char_t *loadOpMappingInfoFuncName = "LoadOpMappingInfo";
    loadOpMappingInfoFunc_ = RtPtrToPtr<FUNC_AICPU_LOAD_OP_MAPPING_INFO>(mmDlsym(aicpuSchedulerHandle_,
        loadOpMappingInfoFuncName));
    if (loadOpMappingInfoFunc_ == nullptr) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "find %s func failed.", modelDestroyFuncName);
        return RT_ERROR_DRV_SYM_AICPU;
    }

    return RT_ERROR_NONE;
}

void AicpuSchedulerAgent::Destroy() noexcept
{
    if (aicpuSchedulerHandle_ != nullptr) {
        (void)mmDlclose(aicpuSchedulerHandle_);
        aicpuSchedulerHandle_ = nullptr;
    }
    loadModelFunc_ = nullptr;
    modelExecuteFunc_ = nullptr;
    modelDestroyFunc_ = nullptr;
    loadOpMappingInfoFunc_ = nullptr;
}

rtError_t AicpuSchedulerAgent::AicpuModelLoad(void * const funcArg) const
{
    if (loadModelFunc_ == nullptr) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "AICPUModelLoad func is null.");
        return RT_ERROR_DRV_SYM_AICPU;
    }

    const int32_t ret = loadModelFunc_(funcArg);
    if (ret != AICPU_SCHEDULE_RET_SUCCESS) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "call load aicpu model func failed,aicpu retCode=%d.", ret);
        return RT_ERROR_AICPU_INTERNAL_ERROR;
    }
    return RT_ERROR_NONE;
}

rtError_t AicpuSchedulerAgent::AicpuModelDestroy(const uint32_t modelId) const
{
    if (modelDestroyFunc_ == nullptr) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "AICPUModelDestroy func is null.");
        return RT_ERROR_DRV_SYM_AICPU;
    }

    const int32_t ret = modelDestroyFunc_(modelId);
    if (ret != AICPU_SCHEDULE_RET_SUCCESS) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "call aicpu model destroy func failed, aicpu retCode=%d.", ret);
        return RT_ERROR_AICPU_INTERNAL_ERROR;
    }
    return RT_ERROR_NONE;
}

rtError_t AicpuSchedulerAgent::AicpuModelExecute(const uint32_t modelId) const
{
    if (modelExecuteFunc_ == nullptr) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "LoadOpMappingInfo is null.");
        return RT_ERROR_DRV_SYM_AICPU;
    }

    const int32_t ret = modelExecuteFunc_(modelId);
    if (ret != AICPU_SCHEDULE_RET_SUCCESS) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "call aicpu model execute func failed, aicpu retCode=%d.", ret);
        return RT_ERROR_AICPU_INTERNAL_ERROR;
    }
    return RT_ERROR_NONE;
}

rtError_t AicpuSchedulerAgent::DatadumpInfoLoad(const void * const dumpInfo, const uint32_t length) const
{
    if (loadOpMappingInfoFunc_ == nullptr) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "LoadOpMappingInfo is null.");
        return RT_ERROR_DRV_SYM_AICPU;
    }

    const int32_t ret = loadOpMappingInfoFunc_(dumpInfo, length);
    if (ret != AICPU_SCHEDULE_RET_SUCCESS) {
        RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "call aicpu load op mapping info func failed, aicpu retCode=%d.", ret);
        return RT_ERROR_AICPU_INTERNAL_ERROR;
    }
    return RT_ERROR_NONE;
}
}
}