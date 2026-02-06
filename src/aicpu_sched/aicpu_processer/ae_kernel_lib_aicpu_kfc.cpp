/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ae_kernel_lib_aicpu_kfc.h"
#include <sstream>
#include <string>
#include <memory>
#include <dlfcn.h>
#include "securec.h"
#include "aicpu_event_struct.h"
#ifdef AICPU_PROFILING
#include "aicpu_prof/profiling_adp.h"
#endif
namespace cce {
    AIKernelsLibAiCpuKFC *AIKernelsLibAiCpuKFC::instance_ = nullptr;

    // SINGLETON object get interface
    AIKernelsLibAiCpuKFC *AIKernelsLibAiCpuKFC::GetInstance()
    {
        static std::once_flag flag;
        std::call_once(flag, []() {
            instance_ = new(std::nothrow) AIKernelsLibAiCpuKFC();
            if ((instance_ != nullptr) && (instance_->Init() != AE_STATUS_SUCCESS)) {
                AE_RUN_WARN_LOG(AE_MODULE_ID,  "AIKernelsLibAiCpuKFC init failed.");
                delete instance_;
                instance_ = nullptr;
            }
            AE_RUN_INFO_LOG(AE_MODULE_ID,  "AIKernelsLibAiCpuKFC init finish.");
        });
        return instance_;
    }

    aeStatus_t AIKernelsLibAiCpuKFC::Init()
    {
        apiCacher_.clear();
        return AIKernelsLibBase::Init();
    }

    // SINGLETON object destroy interface
    void AIKernelsLibAiCpuKFC::DestroyInstance()
    {
        if (instance_ == nullptr) {
            return;
        }
        delete instance_;
        instance_ = nullptr;
    }

    aeStatus_t AIKernelsLibAiCpuKFC::GetKernelName(char_t *&kernelName, const aicpu::HwtsCceKernel *cceKernelBase) const
    {
        kernelName = PtrToPtr<void, char_t>(ValueToPtr(cceKernelBase->kernelName));
        if (static_cast<bool>(unlikely(kernelName == nullptr))) {
            AE_ERR_LOG(AE_MODULE_ID, "Input param kernelName is null.");
            return AE_STATUS_BAD_PARAM;
        }
        uint32_t len = strnlen(kernelName, AE_MAX_KERNEL_NAME + 1);
        if (static_cast<bool>(unlikely(len > AE_MAX_KERNEL_NAME))) {
            AE_ERR_LOG(AE_MODULE_ID, "KernelName length is not support, len=%d.", len);
            kernelName = nullptr;
            return AE_STATUS_INNER_ERROR;
        }
        return AE_STATUS_SUCCESS;
    }

    int32_t AIKernelsLibAiCpuKFC::GetApiGlobal(AicpuKFCOpFuncPtr &opFuncPtr, const char_t *kernelName) const
    {
        opFuncPtr = PtrToFunctionPtr<void, AicpuKFCOpFuncPtr>(dlsym(RTLD_DEFAULT, kernelName));
        if (static_cast<bool>(unlikely(opFuncPtr == nullptr))) {
            AE_ERR_LOG(AE_MODULE_ID, "Get KFC %s api success, but func is nullptr: %s",
                kernelName, dlerror());
            return static_cast<int32_t>(AE_STATUS_INNER_ERROR);
        }
        return AE_STATUS_SUCCESS;
    }

    int32_t AIKernelsLibAiCpuKFC::GetApiWhenSonameNotEmpty(const aicpu::KernelType kernelType, const uint32_t soNameLen,
        const char_t *kernelSoName, const char_t *kernelName, void* &funcAddr)
    {
        if (static_cast<bool>(unlikely(soNameLen > AE_MAX_SO_NAME))) {
            AE_RUN_WARN_LOG(AE_MODULE_ID, "kernelSoName length is not support, len=%d.", soNameLen);
            return static_cast<int32_t>(AE_STATUS_INNER_ERROR);
        }

        const auto ret = soMngr_.GetApi(kernelType, kernelSoName, kernelName, &funcAddr);
        if (static_cast<bool>(unlikely(ret != AE_STATUS_SUCCESS))) {
            AE_RUN_WARN_LOG(AE_MODULE_ID, "Get %s api from %s unsuccessfully.", kernelName, kernelSoName);
            return static_cast<int32_t>(AE_STATUS_INNER_ERROR);
        }

        if (static_cast<bool>(unlikely(funcAddr == nullptr))) {
            AE_RUN_WARN_LOG(AE_MODULE_ID, "Get %s api from %s success, but func is nullptr",
                            kernelName, kernelSoName);
            return static_cast<int32_t>(AE_STATUS_INNER_ERROR);
        }

        return AE_STATUS_SUCCESS;
    }

    int32_t AIKernelsLibAiCpuKFC::GetApiBySoname(const aicpu::KernelType kernelType, const char_t *kernelSoName,
                                                 AicpuKFCOpFuncPtr &opFuncPtr, const char_t *kernelName)
    {
        const uint32_t soNameLen = strnlen(kernelSoName, AE_MAX_SO_NAME + 1);
        if (soNameLen == 0) {
            if (GetApiGlobal(opFuncPtr, kernelName) != AE_STATUS_SUCCESS) {
                return static_cast<int32_t>(AE_STATUS_INNER_ERROR);
            }
        } else {
            void *funcAddr = nullptr;
            if (GetApiWhenSonameNotEmpty(kernelType, soNameLen, kernelSoName, kernelName, funcAddr) == AE_STATUS_SUCCESS) {
                opFuncPtr = PtrToFunctionPtr<void, AicpuKFCOpFuncPtr>(funcAddr);
            } else {
                if (GetApiGlobal(opFuncPtr, kernelName) != AE_STATUS_SUCCESS) {
                    return static_cast<int32_t>(AE_STATUS_INNER_ERROR);
                }
            }
        }

        return AE_STATUS_SUCCESS;
    }


    // Implement call a aicpu op kernel interface
    int32_t AIKernelsLibAiCpuKFC::CallKernelApi(const aicpu::KernelType kernelType, const void * const kernelBase)
    {
        (void)kernelType;
        const aicpu::HwtsCceKernel *cceKernelBase = static_cast<const aicpu::HwtsCceKernel *>(kernelBase);
        if (static_cast<bool>(unlikely(cceKernelBase == nullptr))) {
            AE_ERR_LOG(AE_MODULE_ID, "Input param KFC kernelBase is nullptr.");
            return static_cast<int32_t>(AE_STATUS_BAD_PARAM);
        }

        char_t *kernelName = nullptr;
        aeStatus_t ret = GetKernelName(kernelName, cceKernelBase);
        if (static_cast<bool>(unlikely((ret != AE_STATUS_SUCCESS)))) {
            AE_ERR_LOG(AE_MODULE_ID, "get KFC kernelName failed, ret=%u.", ret);
            return static_cast<int32_t>(ret);
        }
        AicpuKFCOpFuncPtr opFuncPtr = nullptr;
        AE_RW_LOCK_RD_LOCK(&rwLock_);
        auto apiIter = apiCacher_.find(kernelName);
        if (apiIter != apiCacher_.end()) {
            opFuncPtr = apiIter->second;
        } else {
            AE_RW_LOCK_UN_LOCK(&rwLock_);
            AE_RW_LOCK_WR_LOCK(&rwLock_);
            apiIter = apiCacher_.find(kernelName);
            if (apiIter != apiCacher_.end()) {
                opFuncPtr = apiIter->second;
            } else {
                char_t *kernelSoName = PtrToPtr<void, char_t>(ValueToPtr(cceKernelBase->kernelSo));
                if (GetApiBySoname(kernelType, kernelSoName, opFuncPtr, kernelName) != AE_STATUS_SUCCESS) {
                    AE_RW_LOCK_UN_LOCK(&rwLock_);
                    return static_cast<int32_t>(AE_STATUS_INNER_ERROR);
                }
                apiCacher_[kernelName] = opFuncPtr;
            }
        }

        AE_RW_LOCK_UN_LOCK(&rwLock_);
        AE_INFO_LOG(AE_MODULE_ID, "Get KFC kernelname[%s] func success", kernelName);
        const uint32_t result = RunAicpuFunc(kernelBase, opFuncPtr);
        return static_cast<int32_t>(TransformKernelErrorCode(result, kernelName));
    }

    uint32_t AIKernelsLibAiCpuKFC::RunAicpuFunc(const void* const kernelBase,
                                                AicpuKFCOpFuncPtr &opFuncPtr) const
    {
        const auto cceKernelBase = static_cast<const aicpu::HwtsCceKernel *>(kernelBase);
        void * const param = ValueToPtr(static_cast<const uintptr_t>(cceKernelBase->paramBase));
        uint32_t result = 0U;
        if (&aicpu::SetBlockIdxAndBlockNum != nullptr) {
            (void)aicpu::SetBlockIdxAndBlockNum(cceKernelBase->blockId, cceKernelBase->blockNum);
        }
#ifdef AICPU_PROFILING
        uint64_t runStartTick;
        uint64_t runStartTime;
        const std::shared_ptr<aicpu::ProfMessage> profHandle = aicpu::GetProfHandle();
        if (static_cast<bool>(unlikely(profHandle != nullptr))) {
            aicpu::GetMicrosAndSysTick(runStartTime, runStartTick);
        }
#endif
        result = opFuncPtr(param);
#ifdef AICPU_PROFILING
        if (static_cast<bool>(unlikely(profHandle != nullptr))) {
            uint64_t runEndTick;
            uint64_t runEndTime;
            aicpu::GetMicrosAndSysTick(runEndTime, runEndTick);
            (void)profHandle->SetRunStartTime(runStartTime)
                ->SetRunStartTick(runStartTick)
                ->SetRunEndTime(runEndTime)
                ->SetRunEndTick(runEndTick);
        }
#endif
        return result;
    }

    int32_t AIKernelsLibAiCpuKFC::TransformKernelErrorCode(const uint32_t errCode,
                                                           const char_t * const kernelName) const
    {
        if (likely(errCode == 0U)) {
            return AE_STATUS_SUCCESS;
        }

        if (errCode == static_cast<uint32_t>(AicpuOpErrorCode::AICPU_TASK_ABORT)) {
            AE_INFO_LOG(AE_MODULE_ID, "Get kfc task abort flag");
            return AE_STATUS_TASK_ABORT;
        }

        if ((errCode >= static_cast<uint32_t>(AicpuOpErrorCode::AICPU_KFC_PASSTHROUGH_START)) &&
           (errCode <= static_cast<uint32_t>(AicpuOpErrorCode::AICPU_KFC_PASSTHROUGH_END))) {
            AE_INFO_LOG(AE_MODULE_ID, "KFC %s run passthrough ret[%u]", kernelName, errCode);
            return static_cast<int32_t>(errCode);
        }

        AE_ERR_LOG(AE_MODULE_ID, "KFC %s run failed ret[%u]", kernelName, errCode);
        return AE_STATUS_TASK_FAIL;
    }
}
