/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ae_kernel_lib_aicpu.hpp"
#include <sstream>
#include <string>
#include <memory>
#include "securec.h"
#include "aicpu_event_struct.h"
#include "host_cpu_processer.hpp"
#ifdef AICPU_PROFILING
#include "aicpu_prof/profiling_adp.h"
#endif

namespace cce {
    namespace {
        // libcpu_kernels.so name len
        constexpr uint32_t AE_LIB_CPU_KERNELS_SO_NAME = 17U;
        // runcpukernel name len
        constexpr uint32_t AE_RUN_CPU_KERNEL_NAME = 12U;
        // aicpu device side blockdim entry function name
        constexpr char const *kRunFuncName = "RunCpuKernelWithBlock";
        // 动态白名单
        constexpr size_t MAX_WHITE_LIST_SIZE = 100UL;
        // The interface to call a aicpu kernel api
        using AicpuOpFuncPtr = uint32_t(*)(void *);
        // The interface to call a aicpu kernel api with blockdim
        using AicpuOpFuncPtrWithBlockDim = uint32_t(*)(void *, void *);

        struct BlkDimInfo {
            uint32_t  blockNum;   // blockdim number
            uint32_t  blockId;    // block id
        };
    }

    AIKernelsLibAiCpu *AIKernelsLibAiCpu::instance_ = nullptr;
    std::mutex AIKernelsLibAiCpu::mtx_;

    // SINGLETON object get interface
    AIKernelsLibAiCpu *AIKernelsLibAiCpu::GetInstance()
    {
        const std::lock_guard<std::mutex> lockGuard(mtx_);
        if (instance_ != nullptr) {
            return instance_;
        } else {
            instance_ = new(std::nothrow) AIKernelsLibAiCpu();
            if (instance_ == nullptr) {
                return nullptr;
            }
            if (instance_->Init() != AE_STATUS_SUCCESS) {
                AE_RUN_WARN_LOG(AE_MODULE_ID,  "AIKernelsLibAiCpu init failed.");
                delete instance_;
                instance_ = nullptr;
                return nullptr;
            }
            return instance_;
        }
    }

    // SINGLETON object destroy interface
    void AIKernelsLibAiCpu::DestroyInstance()
    {
        const std::lock_guard<std::mutex> lockGuard(mtx_);
        if (instance_ == nullptr) {
            return;
        }
        delete instance_;
        instance_ = nullptr;
    }

    aeStatus_t AIKernelsLibAiCpu::GetKernelNameAndKernelSoNameForHostCpu(char_t *kernelName, char_t *kernelSoName,
                                                                         char_t *paramKernelSo) const
    {
        errno_t retCpy = strncpy_s(&kernelSoName[0], AE_LIB_CPU_KERNELS_SO_NAME + 1U, paramKernelSo,
                                   AE_LIB_CPU_KERNELS_SO_NAME);
        if (retCpy != EOK) {
            AE_ERR_LOG(AE_MODULE_ID, "copy paramKernelSo failed, retCpy=%d.", retCpy);
            return AE_STATUS_INNER_ERROR;
        }
        char_t *paramKernelName = PtrToPtr<void, char_t>(ValueToPtr(
                                  PtrToValue(paramKernelSo) + AE_LIB_CPU_KERNELS_SO_NAME));
        retCpy = strncpy_s(&kernelName[0], AE_RUN_CPU_KERNEL_NAME + 1U, paramKernelName, AE_RUN_CPU_KERNEL_NAME);
        if (retCpy != EOK) {
            AE_ERR_LOG(AE_MODULE_ID, "copy paramKernelName failed, retCpy=%d.", retCpy);
            return AE_STATUS_INNER_ERROR;
        }

        return AE_STATUS_SUCCESS;
    }

    aeStatus_t AIKernelsLibAiCpu::GetKernelNameAndKernelSoName(char_t *kernelName, char_t *kernelSoName,
                                                               const char_t *paramKernelSo,
                                                               const aicpu::HwtsCceKernel *cceKernelBase) const
    {
        const auto paramKernelName = PtrToPtr<const void, const char_t>(ValueToPtr(cceKernelBase->kernelName));
        // Check kernelName is null, do not support a nullptr kernel op name
        if (paramKernelName == nullptr) {
            AE_ERR_LOG(AE_MODULE_ID, "Input param kernelName is null.");
            return AE_STATUS_BAD_PARAM;
        }
        errno_t retCpy = strncpy_s(&kernelName[0], AE_MAX_KERNEL_NAME + 1U, paramKernelName, AE_MAX_KERNEL_NAME);
        if (retCpy != EOK) {
            AE_ERR_LOG(AE_MODULE_ID, "copy paramKernelName failed, retCpy=%d.", retCpy);
            return AE_STATUS_INNER_ERROR;
        }

        retCpy = strncpy_s(&kernelSoName[0], AE_MAX_SO_NAME + 1U, paramKernelSo, AE_MAX_SO_NAME);
        if (retCpy != EOK) {
            AE_ERR_LOG(AE_MODULE_ID, "copy paramKernelSo failed, retCpy=%d.", retCpy);
            return AE_STATUS_INNER_ERROR;
        }
        return AE_STATUS_SUCCESS;
    }

    // Implement call a aicpu op kernel interface
    int32_t AIKernelsLibAiCpu::CallKernelApi(const aicpu::KernelType kernelType, const void * const kernelBase)
    {
        const aicpu::HwtsCceKernel *cceKernelBase = static_cast<const aicpu::HwtsCceKernel *>(kernelBase);
        if (cceKernelBase == nullptr) {
            AE_ERR_LOG(AE_MODULE_ID, "Input param kernelBase is nullptr.");
            return AE_STATUS_BAD_PARAM;
        }

        char_t *paramKernelSo = PtrToPtr<void, char_t>(ValueToPtr(cceKernelBase->kernelSo));
        // Do not support find cce op kernel from whole process space;
        // Only get aicpu op kernel a specific so lib.so, kernelSo should not be NULL.
        if (paramKernelSo == nullptr) {
            AE_ERR_LOG(AE_MODULE_ID, "Input param kernelSo is NULL.");
            return AE_STATUS_BAD_PARAM;
        }
        char_t kernelName[AE_MAX_KERNEL_NAME + 1U] = {};
        char_t kernelSoName[AE_MAX_SO_NAME + 1U] = {};
        DeployContext deployCtx = DeployContext::DEVICE;
        GetAicpuDeployContext(deployCtx);
        aeStatus_t ret = AE_STATUS_SUCCESS;
        if (deployCtx == DeployContext::HOSTCPU) {
            ret = GetKernelNameAndKernelSoNameForHostCpu(kernelName, kernelSoName, paramKernelSo);
            if (ret != AE_STATUS_SUCCESS) {
                AE_ERR_LOG(AE_MODULE_ID, "get kernelName and kernelSoName for hostCpu failed, ret=%u.", ret);
                return ret;
            }
        } else {
            ret = GetKernelNameAndKernelSoName(kernelName, kernelSoName, paramKernelSo, cceKernelBase);
            if (ret != AE_STATUS_SUCCESS) {
                AE_ERR_LOG(AE_MODULE_ID, "get kernelName and kernelSoName failed, ret=%u.", ret);
                return ret;
            }
        }
        void *funcAddr = nullptr;
        ret = soMngr_.GetApi(kernelType, &kernelSoName[0], &kernelName[0], &funcAddr);
        if (ret != AE_STATUS_SUCCESS) {
            AE_ERR_LOG(AE_MODULE_ID, "Get %s api from %s failed.", &kernelName[0], &kernelSoName[0]);
            return ret;
        }
        if (funcAddr == nullptr) {
            AE_ERR_LOG(AE_MODULE_ID, "Get %s api from %s success, but func is nullptr",
                       &kernelName[0], &kernelSoName[0]);
            return AE_STATUS_INNER_ERROR;
        }

        (void)aicpu::SetOpname(kernelName);

        const uint32_t result = RunAicpuFunc(kernelBase, funcAddr, &kernelName[0]);
        return static_cast<int32_t>(TransformKernelErrorCode(result, &kernelName[0], &kernelSoName[0]));
    }

    uint32_t AIKernelsLibAiCpu::RunAicpuFunc(const void* const kernelBase,
                                             void* const funcAddr,
                                             const char_t* const funcName) const
    {
        uint32_t result = 0U;
        const auto cceKernelBase = static_cast<const aicpu::HwtsCceKernel *>(kernelBase);
        void * const param = ValueToPtr(cceKernelBase->paramBase);
#ifdef AICPU_PROFILING
        uint64_t runStartTime;
        uint64_t runStartTick;
        aicpu::GetMicrosAndSysTick(runStartTime, runStartTick);
#endif
        (void)aicpu::SetBlockIdxAndBlockNum(cceKernelBase->blockId, cceKernelBase->blockNum);
        if (strcmp(funcName, kRunFuncName) == 0) {
            AE_INFO_LOG(AE_MODULE_ID, "opFuncPtr is RunCpuKernelWithBlockDim.");
            struct BlkDimInfo blkInfo = {};
            blkInfo.blockId = cceKernelBase->blockId;
            blkInfo.blockNum = cceKernelBase->blockNum;
            const auto opFuncPtr = PtrToFunctionPtr<void, AicpuOpFuncPtrWithBlockDim>(funcAddr);
            result = opFuncPtr(param, &blkInfo);
        } else {
            const auto opFuncPtr = PtrToFunctionPtr<void, AicpuOpFuncPtr>(funcAddr);
            result = opFuncPtr(param);
        }

#ifdef AICPU_PROFILING
        uint64_t runEndTime;
        uint64_t runEndTick;
        aicpu::GetMicrosAndSysTick(runEndTime, runEndTick);

        const std::shared_ptr<aicpu::ProfMessage> profHandle = aicpu::GetProfHandle();
        if (profHandle != nullptr) {
            std::string opName = "null";
            (void)aicpu::GetOpname(aicpu::GetAicpuThreadIndex(), opName);
            (void)profHandle->SetRunStartTime(runStartTime)->SetRunStartTick(runStartTick)
                ->SetRunEndTime(runEndTime)->SetRunEndTick(runEndTick);
        }
#endif
        return result;
    }

    aeStatus_t AIKernelsLibAiCpu::BatchLoadKernelSo(const aicpu::KernelType kernelType,
                                                    std::vector<std::string> &soVec)
    {
        if (soVec.empty()) {
            AE_ERR_LOG(AE_MODULE_ID, "so vec is empty.");
            return AE_STATUS_SUCCESS;
        }
        for (auto &soName : soVec) {
            const aeStatus_t ret = soMngr_.LoadSo(kernelType, soName);
            if (ret != AE_STATUS_SUCCESS) {
                AE_RUN_WARN_LOG(AE_MODULE_ID, "Load so %s failed.", soName.c_str());
                continue;
            }
        }
        return AE_STATUS_SUCCESS;
    }

    aeStatus_t AIKernelsLibAiCpu::CloseSo(const char_t * const soName)
    {
        if (soName == nullptr) {
            AE_ERR_LOG(AE_MODULE_ID, "soName is null.");
            return AE_STATUS_BAD_PARAM;
        }
        const std::string kernelSoName(soName);
        return soMngr_.CloseSo(kernelSoName);
    }

    aeStatus_t AIKernelsLibAiCpu::TransformKernelErrorCode(const uint32_t errCode,
                                                           const char_t * const kernelName,
                                                           const char_t * const soName) const
    {
        if (likely(errCode == 0U)) {
            return AE_STATUS_SUCCESS;
        }

        if (errCode == static_cast<uint32_t>(AicpuOpErrorCode::AICPU_END_OF_SEQUENCE_FLAG)) {
            AE_INFO_LOG(AE_MODULE_ID, "Get aicpu end of sequence flag. ");
            return AE_STATUS_END_OF_SEQUENCE;
        }
        if (errCode == static_cast<uint32_t>(AicpuOpErrorCode::AICPU_TASK_WATI_FLAG)) {
            AE_INFO_LOG(AE_MODULE_ID, "Get aicpu task wait flag.");
            return AE_STATUS_TASK_WAIT;
        }

        if (!aicpu::IsCustAicpuSd()) {
            if (errCode == static_cast<uint32_t>(AicpuOpErrorCode::AICPU_SILENT_FAULT)) {
                AE_INFO_LOG(AE_MODULE_ID, "Get aicpu silent fault flag");
                return AE_STATUS_SILENT_FAULT;
            }
            if (errCode == static_cast<uint32_t>(AicpuOpErrorCode::AICPU_DETECT_FAULT)) {
                AE_INFO_LOG(AE_MODULE_ID, "Get aicpu detect fault flag");
                return AE_STATUS_DETECT_FAULT;
            }

            if (errCode == static_cast<uint32_t>(AicpuOpErrorCode::AICPU_DETECT_FAULT_NORAS)) {
                AE_INFO_LOG(AE_MODULE_ID, "Get aicpu detect fault no Ras flag");
                return AE_STATUS_DETECT_FAULT_NORAS;
            }

            if (errCode == static_cast<uint32_t>(AicpuOpErrorCode::AICPU_DETECT_LOW_BIT_FAULT)) {
                AE_INFO_LOG(AE_MODULE_ID, "Get aicpu detect low-bit fault flag");
                return AE_STATUS_DETECT_LOW_BIT_FAULT;
            }

            if (errCode == static_cast<uint32_t>(AicpuOpErrorCode::AICPU_DETECT_LOW_BIT_FAULT_NORAS)) {
                AE_INFO_LOG(AE_MODULE_ID, "Get aicpu detect low-bit fault no Ras flag");
                return AE_STATUS_DETECT_LOW_BIT_FAULT_NORAS;
            }
        }

        AE_ERR_LOG(AE_MODULE_ID, "call aicpu api %s in %s failed, ret:%u.", kernelName, soName, errCode);
        // other error code: transform to inner_error
        return static_cast<aeStatus_t>(errCode);
    }

    void AIKernelsLibAiCpu::DeleteSoInWhiteList(const std::string &soName)
    {
        const std::lock_guard<std::mutex> lk(soWhiteListMtx_);
        if (soWhiteList_.empty()) {
            AE_INFO_LOG(AE_MODULE_ID, "so white list is empty");
            return;
        }
        auto iter = soWhiteList_.find(soName);
        if (iter != soWhiteList_.end()) {
            soWhiteList_.erase(iter);
            AE_INFO_LOG(AE_MODULE_ID, "erase so:%s in whilte list", soName.c_str());
        } else {
            AE_INFO_LOG(AE_MODULE_ID, "so:%s not in whilte list", soName.c_str());
        }
    }

    aeStatus_t AIKernelsLibAiCpu::AddSoInWhiteList(const std::string &soName)
    {
        const std::lock_guard<std::mutex> lk(soWhiteListMtx_);
        if (soWhiteList_.size() >= MAX_WHITE_LIST_SIZE) {
            AE_ERR_LOG(AE_MODULE_ID, "white list is full");
            return AE_STATUS_INNER_ERROR;
        }
        auto iter = soWhiteList_.find(soName);
        if (iter == soWhiteList_.end()) {
            soWhiteList_[soName] = soName;
            AE_INFO_LOG(AE_MODULE_ID, "add so:%s in whilte list, list size:%zu", soName.c_str(), soWhiteList_.size());
        } else {
            AE_INFO_LOG(AE_MODULE_ID, "so:%s aleady in whilte list, size:%zu", soName.c_str(), soWhiteList_.size());
        }
        return AE_STATUS_SUCCESS;
    }
}
