/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hwts_kernel_model_process.h"

#include "aicpusd_interface_process.h"
#include "hwts_kernel_common.h"

namespace AicpuSchedule {
namespace {
const std::string CFG_EXT_INFO = "AicpuCfgExtInfo";
const std::string MODEL_CONFIG = "AicpuModelConfig";
const std::string SHAPE_CONFIG = "AicpuModelShapeConfig";
const std::string ESCHED_PRIORITY = "AicpuModelEschedPriority";
const std::string CHECK_SUPPORTED = "CheckKernelSupported";
const std::string PROCESS_DATA_EXCEPTION = "ProcessDataException";
}  // namespace

int32_t ConfigExtInfoTsKernel::Compute(const aicpu::HwtsTsKernel &tsKernelInfo)
{
    aicpusd_info("Begin to process ts kernel CfgExtInfo event");
    const auto cfgMsg =
        PtrToPtr<void, aicpu::AicpuExtendInfo>(ValueToPtr(tsKernelInfo.kernelBase.cceKernel.paramBase));
    if (cfgMsg == nullptr) {
        aicpusd_err("param base for config extension message is null.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    return AicpuModelManager::GetInstance().ProcessExtInfoCfgMsg(*cfgMsg);
}

int32_t ModelConfigTsKernel::Compute(const aicpu::HwtsTsKernel &tsKernelInfo)
{
    aicpusd_info("Begin to process ts kernel ModelConfig event");
    const aicpu::HwtsCceKernel &kernel = tsKernelInfo.kernelBase.cceKernel;
    constexpr uint64_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelConfig);
    constexpr uint64_t offset = sizeof(aicpu::AicpuParamHead);
    const auto baseAddr = PtrToPtr<void, char_t>(ValueToPtr(kernel.paramBase));
    const aicpu::AicpuParamHead * const paramHead = PtrToPtr<char_t, aicpu::AicpuParamHead>(baseAddr);
    if (paramHead == nullptr) {
        aicpusd_err("ParamHead for ModelConfig is nullptr");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    if (paramHead->length != len) {
        aicpusd_err("ModelConfig param length[%u] should be [%lu]", paramHead->length, len);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const auto cfg = PtrToPtr<const char_t, const AicpuModelConfig>(PtrAdd<const char_t>(baseAddr, len, offset));
    return AicpuModelManager::GetInstance().ProcessModelConfigMsg(*cfg);
}

int32_t ShapeConfigTsKernel::Compute(const aicpu::HwtsTsKernel &tsKernelInfo)
{
    aicpusd_info("Begin to process ts kernel ModelShapeConfig event");
    const aicpu::HwtsCceKernel &kernel = tsKernelInfo.kernelBase.cceKernel;
    constexpr uint64_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelShapeConfig);
    const auto baseAddr = PtrToPtr<void, char_t>(ValueToPtr(kernel.paramBase));
    const aicpu::AicpuParamHead * const paramHead = PtrToPtr<char_t, aicpu::AicpuParamHead>(baseAddr);
    if (paramHead == nullptr) {
        aicpusd_err("ParamHead for ModelShapeConfig is nullptr");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    if (paramHead->length != len) {
        aicpusd_err("ModelShapeConfig param length[%u] should be [%lu]", paramHead->length, len);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    constexpr uint64_t offset = sizeof(aicpu::AicpuParamHead);
    const auto cfg =
        PtrToPtr<const char_t, const AicpuModelShapeConfig>(PtrAdd<const char_t>(baseAddr, len, offset));
    return AicpuModelManager::GetInstance().ProcessModelShapeConfigMsg(*cfg);
}

int32_t EschedPriorityTsKernel::Compute(const aicpu::HwtsTsKernel &tsKernelInfo)
{
    aicpusd_info("Begin to process ts kernel AicpuModelEschedPriority event.");
    const aicpu::HwtsCceKernel &kernel = tsKernelInfo.kernelBase.cceKernel;
    constexpr uint64_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuPriInfo);
    constexpr uint64_t offset = sizeof(aicpu::AicpuParamHead);
    const auto baseAddr = PtrToPtr<void, char_t>(ValueToPtr(kernel.paramBase));
    const aicpu::AicpuParamHead * const paramHead = PtrToPtr<char_t, aicpu::AicpuParamHead>(baseAddr);
    if (paramHead == nullptr) {
        aicpusd_err("ParamHead for AicpuModelEschedPriority is nullptr");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    if (paramHead->length != len) {
        aicpusd_err("AicpuModelEschedPriority param length[%u] should be [%lu]", paramHead->length, len);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    const auto cfg = PtrToPtr<const char_t, const AicpuPriInfo>(PtrAdd<const char_t>(baseAddr, len, offset));
    return AicpuModelManager::GetInstance().ProcessModelPriorityMsg(*cfg, true);
}

int32_t CheckSupportedTsKernel::Compute(const aicpu::HwtsTsKernel &tsKernelInfo)
{
    aicpusd_run_info("Begin to process kernel CheckKernelSupported event.");
    const aicpu::HwtsCceKernel &kernel = tsKernelInfo.kernelBase.cceKernel;
    const auto supportedCfg = PtrToPtr<void, CheckKernelSupportedConfig>(ValueToPtr(kernel.paramBase));
    const uint32_t kernelNameLen = supportedCfg->kernelNameLen;
    const char *const kernelName = PtrToPtr<void, const char>(ValueToPtr(supportedCfg->kernelNameAddr));
    uint32_t *resultAddr = PtrToPtr<void, uint32_t>(ValueToPtr(supportedCfg->checkResultAddr));
    if ((kernelName == nullptr) || (kernelNameLen == 0) || (resultAddr == nullptr)) {
        aicpusd_err("CheckKernelSupportedConfig params error");
        return AICPU_SCHEDULE_FAIL;
    }

    std::string operaterKernelName(kernelName, static_cast<uint64_t>(kernelNameLen));
    aicpusd_info("Task kernel name[%s].", operaterKernelName.c_str());
    const int32_t retCode = AicpuScheduleInterface::GetInstance().CheckKernelSupported(operaterKernelName);
    *resultAddr = static_cast<uint32_t>(retCode);
    aicpusd_run_info("Finish to process kernel CheckKernelSupported event retCode[%d].", retCode);
    return AICPU_SCHEDULE_OK;
}

int32_t ProcessDataExceptionTsKernel::Compute(const aicpu::HwtsTsKernel &tsKernelInfo)
{
    const aicpu::HwtsCceKernel &kernel = tsKernelInfo.kernelBase.cceKernel;
    const auto exceptionInfo = PtrToPtr<void, DataFlowExceptionNotify>(ValueToPtr(kernel.paramBase));
    return AicpuScheduleInterface::GetInstance().ProcessException(exceptionInfo);
}

REGISTER_HWTS_KERNEL(CFG_EXT_INFO, ConfigExtInfoTsKernel);
REGISTER_HWTS_KERNEL(MODEL_CONFIG, ModelConfigTsKernel);
REGISTER_HWTS_KERNEL(SHAPE_CONFIG, ShapeConfigTsKernel);
REGISTER_HWTS_KERNEL(ESCHED_PRIORITY, EschedPriorityTsKernel);
REGISTER_HWTS_KERNEL(CHECK_SUPPORTED, CheckSupportedTsKernel);
REGISTER_HWTS_KERNEL(PROCESS_DATA_EXCEPTION, ProcessDataExceptionTsKernel);
}  // namespace AicpuSchedule