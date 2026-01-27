/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __AE_KERNEL_LIB_FWK_H_
#define __AE_KERNEL_LIB_FWK_H_

#include "aicpu_engine.h"
#include "ae_def.hpp"
#include "ae_kernel_lib_base.hpp"
#include "ae_so_manager.hpp"
#include <mutex>
#include <string>
#include <vector>
#include <sys/types.h>

namespace cce {

    class FWKKernelTfImpl {
        using FwkTfOpFuncPtr = uint32_t (*)(uint64_t paramBase);
    public:
        FWKKernelTfImpl();

        ~FWKKernelTfImpl();

    public:
        // Init Interface
        aeStatus_t Init();
        // Implement call a tensorflow op kernel interface
        int32_t CallKernelApi(const uint64_t fwkKernelParam);

        // Implement load tensorflow so
        aeStatus_t LoadTfSo();

        // get thread mode so path
        void GetThreadModelSoPath(std::string &soPath);

        aeStatus_t GetTfThreadModeSoPath(std::string &soPath);

        void GetTensorflowThreadModeSoPath(std::string soPath);

        void GetTfKernelThreadModeSoPath(std::string &soPath) const;

    private:
        const std::string &GetKernelName() const;

        const std::string &GetSoFile() const;

        // Transform kernel error code
        static aeStatus_t TransformKernelErrorCode(const uint32_t errCode, const uint64_t fwkKernelParam);

    private:
        // The tf-kernel lib file
        std::string soFile_;
        // The tensorflow lib file
        std::string tensorflowSoFile_;
        // The tensorflow lib api name
        std::string kernelName_;
        // Store the tensorflow lib api addr
        void *funcAddr_;
        // Store the handle of  tensorflow lib open by dlopen
        void *soHandle_;
        // Store the hadle of libtensorflow.so open by dlopen
        void *soTensorflowHandle_;
        // A Read Write lock to protect apiCacher_
        tAERwLock rwLock_ = PTHREAD_RWLOCK_INITIALIZER;
    };

    class AIKernelsLibFWK : public AIKernelsLibBase {
    public:
        ~AIKernelsLibFWK() override = default;

        // SINGLETON object get interface
        static AIKernelsLibFWK *GetInstance();

        // Init interface
        aeStatus_t Init() override;

        // Close so
        aeStatus_t CloseSo(const char_t * const soName) override;

        // SINGLETON object destroy interface
        static void DestroyInstance();

        // Call a framework op kernel interface
        int32_t CallKernelApi(const aicpu::KernelType kernelType, const void * const kernelBase) override;

        // Batch load kernel so
        aeStatus_t BatchLoadKernelSo(const aicpu::KernelType kernelType,
                                     std::vector<std::string> &soVec) override;

    private:
        //SINGLETON object
        static AIKernelsLibFWK *instance_;

        AIKernelsLibFWK() = default;

    private:
        // Tensorflow implement.
        FWKKernelTfImpl tfImpl_;
        // Mutex lock to protect SINGLETON object create or destroy
        static std::mutex mtx_;
    };
}
#endif

