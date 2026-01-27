/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpu_engine.h"
#include "ae_def.hpp"
#include "ae_kernel_lib_manager.hpp"
#include "aicpu_event_struct.h"
#include "aicpu_context.h"

/**
 * @ingroup aicpu engine
 * @brief aeCallInterface: a interface to call  a function in a op kernfel lib
 * @param [in] addr: void *, should be HwtsTsKernel * format
 * @return int32_t
*/
__attribute__((visibility("default"))) int32_t aeCallInterface(const void * const addr)
{
    if (addr == nullptr) {
        AE_ERR_LOG(AE_MODULE_ID, "Input param addr is NULL");
        return AE_STATUS_BAD_PARAM;
    }
    const auto strKernel = static_cast<const aicpu::HwtsTsKernel *>(addr);
    AE_INFO_LOG(AE_MODULE_ID, "Begin to CallKernelApi, kernelType=%u.", strKernel->kernelType);
    FUNC_PROFILE_START
    // step1. Get the Ai Kernel Lib
    const aicpu::KernelType kernelType = static_cast<const aicpu::KernelType>(strKernel->kernelType);
    cce::AIKernelsLibBase *targetKernelLib = nullptr;
    int32_t ret = cce::AIKernelsLibManger::GetKernelLib(kernelType, targetKernelLib);
    if ((ret == AE_STATUS_SUCCESS) && (targetKernelLib != nullptr)) {
        // step2. Call the Ai Kernel Lib unify abstract interface
        ret = targetKernelLib->CallKernelApi(kernelType, static_cast<const void *>(&strKernel->kernelBase));
    }
    FUNC_PROFILE_END
    return ret;
}

/**
 * @ingroup aicpu engine
 * @brief aeClear: a interface to clear all ai kernel lib
 * @return aeStatus_t
*/
__attribute__((visibility("default"))) void aeClear()
{
    for (int32_t kernelType = aicpu::KERNEL_TYPE_CCE; kernelType <= aicpu::KERNEL_TYPE_RESERVED; kernelType++) {
        cce::AIKernelsLibManger::ClearKernelLib(static_cast<aicpu::KernelType>(kernelType));
    }
}

/**
 * @ingroup aicpu engine
 * @brief aeBatchLoadKernelSo: a interface to load kernel so
 * @param [in] kernelType: uint32_t, kernel type
 * @param [in] loadSoNum: uint32_t, so number
 * @param [in] soNames: const char_t*[], so name
 * @return aeStatus_t
*/
__attribute__((visibility("default"))) aeStatus_t aeBatchLoadKernelSo(const uint32_t kernelType,
                                                                      const uint32_t loadSoNum,
                                                                      const char_t * const * const soNames)
{
    return cce::AIKernelsLibManger::BatchLoadKernelSo(static_cast<aicpu::KernelType>(kernelType), loadSoNum, soNames);
}

/**
 * @ingroup aicpu engine
 * @brief aeClear: a interface to close a so
 * @param [in]soName: so name
 * @return aeStatus_t
*/
__attribute__((visibility("default"))) aeStatus_t aeCloseSo(const uint32_t kernelType, const char_t * const soName)
{
    cce::AIKernelsLibBase *targetKernelLib = nullptr;
    const aeStatus_t ret = cce::AIKernelsLibManger::GetKernelLib(static_cast<const aicpu::KernelType>(kernelType),
                                                                 targetKernelLib);
    if ((ret != AE_STATUS_SUCCESS)) {
        return ret;
    }
    return targetKernelLib->CloseSo(soName);
}

__attribute__((visibility("default"))) aeStatus_t AeAddSoInWhiteList(const char_t * const soName)
{
    if (soName == nullptr) {
        AE_ERR_LOG(AE_MODULE_ID, "Input param addr is NULL");
        return AE_STATUS_BAD_PARAM;
    }
    return cce::AIKernelsLibManger::AddSoInWhiteList(soName);
}

__attribute__((visibility("default"))) void AeDeleteSoInWhiteList(const char_t * const soName)
{
    if (soName == nullptr) {
        AE_ERR_LOG(AE_MODULE_ID, "Input param addr is NULL");
        return;
    }
    cce::AIKernelsLibManger::DelteSoInWhiteList(soName);
}