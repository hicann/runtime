/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __AE_KERNEL_LIB_AICPU_H_
#define __AE_KERNEL_LIB_AICPU_H_

#include <string>
#include <mutex>
#include <vector>
#include "aicpu_context.h"
#include "aicpu_engine.h"
#include "ae_def.hpp"
#include "ae_kernel_lib_base.hpp"
#include "ae_so_manager.hpp"

namespace cce {
    class AIKernelsLibAiCpu : public cce::AIKernelsLibBase {
    public:
        ~AIKernelsLibAiCpu() override = default;
        /**
         * SINGLETON object get interface
         */
        static AIKernelsLibAiCpu *GetInstance();

        /**
         * SINGLETON object destroy interface
         */
        static void DestroyInstance();

        /**
         * Implement get kernelName and kernelSoName for hostCpu
         */
        aeStatus_t GetKernelNameAndKernelSoNameForHostCpu(char_t *kernelName, char_t *kernelSoName,
                                                          char_t *paramKernelSo) const;

        /**
         * Implement get kernelName and kernelSoName
         */
        aeStatus_t GetKernelNameAndKernelSoName(char_t *kernelName, char_t *kernelSoName,
                                                const char_t *paramKernelSo,
                                                const aicpu::HwtsCceKernel *cceKernelBase) const;

        /**
         * Implement call a aicpu op kernel interface
         */
        int32_t CallKernelApi(const aicpu::KernelType kernelType, const void * const kernelBase) override;

        /**
         * Batch load kernel so
         */
        aeStatus_t BatchLoadKernelSo(const aicpu::KernelType kernelType,
                                     std::vector<std::string> &soVec) override;

        /**
         * Close so
         */
        aeStatus_t CloseSo(const char_t * const soName) override;

        void DeleteSoInWhiteList(const std::string &soName);

        aeStatus_t AddSoInWhiteList(const std::string &soName);

    private:
        AIKernelsLibAiCpu() = default;

        /**
         * Transform kernel error code
         */
        aeStatus_t TransformKernelErrorCode(const uint32_t errCode, const char_t * const kernelName, const char_t * const soName) const;

        /**
         * Run aicpu profiling
         */
        uint32_t RunAicpuFunc(const void* const kernelBase,
                              void* const funcAddr,
                              const char_t* const funcName) const;

    private:
        static AIKernelsLibAiCpu *instance_;     // SINGLETON object
        static std::mutex mtx_;                  // Mutex lock to protect SINGLETON object create or destroy
        std::mutex soWhiteListMtx_;
        std::map<std::string, std::string> soWhiteList_;
    };
}
#endif
