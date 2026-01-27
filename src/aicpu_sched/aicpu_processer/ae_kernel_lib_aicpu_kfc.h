/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __AE_KERNEL_LIB_AICPU_KFC_H_
#define __AE_KERNEL_LIB_AICPU_KFC_H_

#include <string>
#include <mutex>
#include <vector>
#include "aicpu_context.h"
#include "aicpu_engine.h"
#include "ae_def.hpp"
#include "ae_kernel_lib_base.hpp"
#include "ae_so_manager.hpp"

namespace cce {
    using AicpuKFCOpFuncPtr = uint32_t(*)(void *);
    class AIKernelsLibAiCpuKFC : public cce::AIKernelsLibBase {
    public:
        ~AIKernelsLibAiCpuKFC()  override = default;
        /**
         * SINGLETON object get interface
         */
        static AIKernelsLibAiCpuKFC *GetInstance();
        /**
         * SINGLETON object destroy interface
         */
        static void DestroyInstance();
        /**
         * Implement get kernelName and kernelSoName
         */
        aeStatus_t GetKernelName(char_t *&kernelName, const aicpu::HwtsCceKernel *cceKernelBase) const;
        /**
         * Implement call a aicpu op kernel interface
         */
        int32_t CallKernelApi(const aicpu::KernelType kernelType, const void * const kernelBase) override;
        aeStatus_t Init() override;
        aeStatus_t BatchLoadKernelSo(const aicpu::KernelType kernelType,
                                     std::vector<std::string> &soVec) override
        {
            (void)kernelType;
            (void)soVec;
            return AE_STATUS_SUCCESS;
        }
        aeStatus_t CloseSo(const char_t * const soName) override
        {
            (void)soName;
            return AE_STATUS_SUCCESS;
        }
    private:
        AIKernelsLibAiCpuKFC() = default;
        /**
         * Run aicpu profiling
         */
        uint32_t RunAicpuFunc(const void* const kernelBase,
                              AicpuKFCOpFuncPtr &opFuncPtr) const;

        int32_t TransformKernelErrorCode(const uint32_t errCode, const char_t * const kernelName) const;

        int32_t GetApiGlobal(AicpuKFCOpFuncPtr &opFuncPtr, const char_t *kernelName) const;

    private:
        static AIKernelsLibAiCpuKFC *instance_;     // SINGLETON object
        // api cacher
        std::unordered_map<std::string, AicpuKFCOpFuncPtr> apiCacher_;
        // A Read Write lock to protect apiCacher_
        tAERwLock rwLock_ = PTHREAD_RWLOCK_INITIALIZER;
    };
}
#endif
