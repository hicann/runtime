/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ae_kernel_lib_manager.hpp"

#include <vector>
#include <string>
#include "ae_kernel_lib_fwk.hpp"
#include "ae_kernel_lib_aicpu.hpp"
#include "ae_kernel_lib_aicpu_kfc.h"
#include "ae_def.hpp"

namespace cce {
    /*
     * A inner function, the caller should make sure "kernelLib" is not null.
     * Get a  AIKernelLIb specialised by kernelType
     */
    aeStatus_t AIKernelsLibManger::GetKernelLib(const aicpu::KernelType kernelType, AIKernelsLibBase *&kernelLib)
    {
        switch (kernelType) {
            case aicpu::KERNEL_TYPE_FWK:
                kernelLib = AIKernelsLibFWK::GetInstance();
                break;
            case aicpu::KERNEL_TYPE_AICPU:
            case aicpu::KERNEL_TYPE_AICPU_CUSTOM:
                kernelLib = AIKernelsLibAiCpu::GetInstance();
                break;
            case aicpu::KERNEL_TYPE_AICPU_KFC:
            case aicpu::KERNEL_TYPE_AICPU_CUSTOM_KFC:
                kernelLib = AIKernelsLibAiCpuKFC::GetInstance();
                break;
            default:
                AE_ERR_LOG(AE_MODULE_ID, "Input param kernelType is invalid :%d", kernelType);
                break;
        }

        if (kernelLib == nullptr) {
            AE_ERR_LOG(AE_MODULE_ID, "Get kernelLib is NULL, kernel type=%d", kernelType);
            return AE_STATUS_BAD_PARAM;
        }
        return AE_STATUS_SUCCESS;
    }

    /**
     * Clear a AIKernelLIb in manager specialised by kernelType
     */
    void AIKernelsLibManger::ClearKernelLib(const aicpu::KernelType kernelType)
    {
        switch (kernelType) {
            case aicpu::KERNEL_TYPE_FWK:
                AIKernelsLibFWK::DestroyInstance();
                break;
            case aicpu::KERNEL_TYPE_AICPU:
            case aicpu::KERNEL_TYPE_AICPU_CUSTOM:
                AIKernelsLibAiCpu::DestroyInstance();
                break;
            case aicpu::KERNEL_TYPE_AICPU_KFC:
            case aicpu::KERNEL_TYPE_AICPU_CUSTOM_KFC:
                AIKernelsLibAiCpuKFC::DestroyInstance();
                break;
            default:
                break;
        }
    }

    aeStatus_t AIKernelsLibManger::BatchLoadKernelSo(const aicpu::KernelType kernelType,
                                                     const uint32_t loadSoNum,
                                                     const char_t * const * const soNames)
    {
        AE_INFO_LOG(AE_MODULE_ID, "Start to batch load kernel so. kernelType=%d, loadSoNum=%u.", kernelType, loadSoNum);
        if (loadSoNum == 0U) {
            return AE_STATUS_SUCCESS;
        }
        // pair first is so name, second is so path
        std::vector<std::string> aicpuSoVec;
        std::vector<std::string> tfSoVec;
        for (uint32_t index = 0U; index < loadSoNum; index++) {
            if (soNames[index] == nullptr) {
                AE_WARN_LOG(AE_MODULE_ID, "soName is null.");
                continue;
            }
            std::string soName(soNames[index]);
            if (soName == "libtf_kernels.so") {
                tfSoVec.emplace_back(soName);
            } else {
                aicpuSoVec.push_back(soName);
            }
        }

        if (!tfSoVec.empty()) {
            if (AIKernelsLibFWK::GetInstance()->BatchLoadKernelSo(kernelType, tfSoVec) != AE_STATUS_SUCCESS) {
                AE_WARN_LOG(AE_MODULE_ID, "batch load kernel so failed.");
            }
        }
        if (!aicpuSoVec.empty()) {
            if (AIKernelsLibAiCpu::GetInstance()->BatchLoadKernelSo(kernelType, aicpuSoVec) != AE_STATUS_SUCCESS) {
                AE_WARN_LOG(AE_MODULE_ID, "batch load kernel so failed.");
            }
        }
        AE_INFO_LOG(AE_MODULE_ID, "Finish to batch load kernel so. loadSoNum=%u.", loadSoNum);
        return AE_STATUS_SUCCESS;
    }

    aeStatus_t AIKernelsLibManger::AddSoInWhiteList(const char_t * const soName)
    {
        AIKernelsLibAiCpu *aicpuKernel = AIKernelsLibAiCpu::GetInstance();
        if (aicpuKernel == nullptr) {
            AE_ERR_LOG(AE_MODULE_ID, "Get kernelLib is NULL");
            return AE_STATUS_INNER_ERROR;
        }
        const std::string soNameStr(soName);
        AE_INFO_LOG(AE_MODULE_ID, "begin add so:%s", soNameStr.c_str());
        return aicpuKernel->AddSoInWhiteList(soNameStr);
    }

    void AIKernelsLibManger::DelteSoInWhiteList(const char_t * const soName)
    {
        AIKernelsLibAiCpu *aicpuKernel = AIKernelsLibAiCpu::GetInstance();
        if (aicpuKernel == nullptr) {
            AE_ERR_LOG(AE_MODULE_ID, "Get kernelLib is NULL");
            return;
        }
        const std::string soNameStr(soName);
        AE_INFO_LOG(AE_MODULE_ID, "begin delete so:%s", soNameStr.c_str());
        aicpuKernel->DeleteSoInWhiteList(soNameStr);
    }
}