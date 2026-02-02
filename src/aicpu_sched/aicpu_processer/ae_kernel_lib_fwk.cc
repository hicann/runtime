/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ae_kernel_lib_fwk.hpp"
#include "securec.h"
#include "aicpu_context.h"
#include "aicpu_event_struct.h"

namespace {
    // aicpu so root dir, must be absolute path.
    constexpr const char *AICPU_SO_ROOT_PATH = "/usr/lib64/aicpu_kernels/";
    // tf kernels so name
    constexpr const char *TF_SO_NAME = "libtf_kernels.so";
    // tensorflow so name
    constexpr const char *TENSORFLOW_SO_NAME = "libtensorflow.so";
    // tensorflow tar uncompress path
    constexpr const char *TENSORFLOW_SO_UNCOMPRESS_PAHT = "sand_box";
    // aicpu kernels tar uncompress path
    constexpr const char *AICPU_SO_UNCOMPRESS_PATH = "aicpu_kernels_device";
    constexpr const uint32_t MAX_SO_PATH = 4096U;
    constexpr const char_t *THREAD_MODE_SO_PATH_FIX = "aicpu_kernels";
    constexpr const char_t *HELPER_AICPU_OPKERNEL_PATH_HEAD = "/home/HwHiAiUser/inuse/aicpu_kernels/";
}

namespace cce {
    AIKernelsLibFWK *AIKernelsLibFWK::instance_ = nullptr;
    std::mutex AIKernelsLibFWK::mtx_;

    AIKernelsLibFWK *AIKernelsLibFWK::GetInstance()
    {
        const std::lock_guard<std::mutex> lockGuard(mtx_);
        if (instance_ != nullptr) {
            return instance_;
        } else {
            instance_ = new(std::nothrow) AIKernelsLibFWK();
            if (instance_ == nullptr) {
                return nullptr;
            }
            (void)instance_->Init();
            return instance_;
        }
    }

    void AIKernelsLibFWK::DestroyInstance()
    {
        const std::lock_guard<std::mutex> lockGuard(mtx_);
        if (instance_ == nullptr) {
            return;
        }
        delete instance_;
        instance_ = nullptr;
    }

    aeStatus_t AIKernelsLibFWK::Init()
    {
        return tfImpl_.Init();
    }


    aeStatus_t AIKernelsLibFWK::CloseSo(const char_t * const soName)
    {
        (void)soName;
        return AE_STATUS_SUCCESS;
    }

    int32_t AIKernelsLibFWK::CallKernelApi(const aicpu::KernelType kernelType, const void * const kernelBase)
    {
        const auto fwkKernel = reinterpret_cast<const aicpu::HwtsFwkKernel * const>(kernelBase);
        if (static_cast<bool>(unlikely(fwkKernel == nullptr))) {
            AE_ERR_LOG(AE_MODULE_ID, "Input param fwkKernelBase is NULL.");
            return AE_STATUS_BAD_PARAM;
        }

        const auto fwkOpKernelPtr = static_cast<const uintptr_t>(fwkKernel->kernel);
        const auto fwkOpKernel = reinterpret_cast<const STR_FWK_OP_KERNEL * const>(fwkOpKernelPtr);
        if (static_cast<bool>(unlikely(fwkOpKernel == nullptr))) {
            AE_ERR_LOG(AE_MODULE_ID, "Input param fwkOpKernel is NULL.");
            return AE_STATUS_BAD_PARAM;
        }
        AE_INFO_LOG(AE_MODULE_ID, "Current kernelType:%d, FWK op kernel kernel type:%d.",
                    kernelType, fwkOpKernel->fwkKernelType);

        // Call different Implement method switch by kernel type.
        int32_t ret = AE_STATUS_SUCCESS;
        switch (static_cast<FwkkernelType_t>(fwkOpKernel->fwkKernelType)) {
            case FMK_KERNEL_TYPE_TF:
                ret =  tfImpl_.CallKernelApi(PtrToValue(PtrToPtr<const ::aicpu::FWKAdapter::FWKOperateParam, 
                                             const void>(&fwkOpKernel->fwkKernelBase.fwk_kernel)));
                break;
            default:
                AE_ERR_LOG(AE_MODULE_ID, "Input param fwkKernelType in STR_FWK_OP_KERNEL is invalid :%d",
                           fwkOpKernel->fwkKernelType);
                ret = AE_STATUS_BAD_PARAM;
                break;
        }
        return ret;
    }

    aeStatus_t AIKernelsLibFWK::BatchLoadKernelSo(const aicpu::KernelType kernelType,
                                                  std::vector<std::string> &soVec)
    {
        AE_INFO_LOG(AE_MODULE_ID, "Begin to batch load kernel so, kerelType:[%d].", kernelType);
        if (soVec.empty()) {
            return AE_STATUS_SUCCESS;
        }
        // only one tf so
        return tfImpl_.LoadTfSo();
    }

    // need refresh soFile_
    FWKKernelTfImpl::FWKKernelTfImpl() : kernelName_("TFOperateAPI"),
                                         funcAddr_(nullptr),
                                         soHandle_(nullptr),
                                         soTensorflowHandle_(nullptr)
    {
    }

    aeStatus_t FWKKernelTfImpl::Init()
    {
        std::string baseSoFile(AICPU_SO_ROOT_PATH);
        (void)baseSoFile.append(TF_SO_NAME);
        soFile_ = baseSoFile;
        aicpu::aicpuContext_t currentAicpuCtx;
        const aicpu::status_t status = aicpu::aicpuGetContext(&currentAicpuCtx);
        if (status == aicpu::AICPU_ERROR_NONE) {
            std::string soPath(AICPU_SO_ROOT_PATH);
            (void) HELPER_AICPU_OPKERNEL_PATH_HEAD;
#ifdef AICPU_KERNEL_HELPER
            soPath = HELPER_AICPU_OPKERNEL_PATH_HEAD;
#endif
            (void)soPath.append(std::to_string(aicpu::GetUniqueVfId()))
                .append("/")
                .append(AICPU_SO_UNCOMPRESS_PATH)
                .append("/");
            soFile_ = soPath + TF_SO_NAME;
            GetThreadModelSoPath(soPath);
            // check so file
            const aeStatus_t ret = SingleSoManager::CheckSoFile(soPath, soFile_);
            if (ret != AE_STATUS_SUCCESS) {
                soFile_ = baseSoFile;
                AE_RUN_INFO_LOG(AE_MODULE_ID, "So does not exist in path %s, use default soFile %s.",
                                soPath.c_str(), baseSoFile.c_str());
            }
        }
        AE_INFO_LOG(AE_MODULE_ID, "FWKernelTfImpl init success, soFile_=%s.", soFile_.c_str());
        return AE_STATUS_SUCCESS;
    }

    FWKKernelTfImpl::~FWKKernelTfImpl()
    {
        AE_RW_LOCK_WR_LOCK(&rwLock_);
        funcAddr_ = nullptr;
        aeStatus_t ret = SingleSoManager::CloseSo(soHandle_);
        if (ret != AE_STATUS_SUCCESS) {
            AE_RUN_WARN_LOG(AE_MODULE_ID, "~FWKKernelTfImpl CloseSo failed, ret is[%d]", ret);
        }
        ret = SingleSoManager::CloseSo(soTensorflowHandle_);
        if (ret != AE_STATUS_SUCCESS) {
            AE_RUN_WARN_LOG(AE_MODULE_ID, "~FWKKernelTensorflowImpl CloseSo failed, ret is[%d]", ret);
        }
        soHandle_ = nullptr;
        soTensorflowHandle_ = nullptr;
        AE_RW_LOCK_UN_LOCK(&rwLock_);
        AE_RW_LOCK_DESTROY(&rwLock_);
    }

    void FWKKernelTfImpl::GetTfKernelThreadModeSoPath(std::string &soPath) const
    {
#ifdef AICPU_KERNEL_HELPER
        soPath.append("inuse").append("/");
#endif
        (void)soPath.append(THREAD_MODE_SO_PATH_FIX)
            .append("/")
            .append(std::to_string(aicpu::GetUniqueVfId()))
            .append("/")
            .append(AICPU_SO_UNCOMPRESS_PATH)
            .append("/");
        return;
    }

    void FWKKernelTfImpl::GetTensorflowThreadModeSoPath(std::string soPath)
    {
        (void)soPath.append(THREAD_MODE_SO_PATH_FIX)
            .append("/")
            .append(std::to_string(aicpu::GetUniqueVfId()))
            .append("/")
            .append(AICPU_SO_UNCOMPRESS_PATH)
            .append("/")
            .append(TENSORFLOW_SO_UNCOMPRESS_PAHT)
            .append("/");
        tensorflowSoFile_ = soPath + TENSORFLOW_SO_NAME;
        return;
    }

    aeStatus_t FWKKernelTfImpl::GetTfThreadModeSoPath(std::string &soPath)
    {
        const char_t * const innerDirName = getenv("HOME");
        if (innerDirName != nullptr) {
            const std::string str =  innerDirName;
            const size_t len = str.length();
            if ((len == 0U) || (len >= static_cast<size_t>(MAX_SO_PATH))) {
                AE_ERR_LOG(AE_MODULE_ID, "Length[%zu] of inner so dir is invalid.", len);
                return AE_STATUS_INNER_ERROR;
            }
            soPath = str;
            if (soPath[soPath.size() - 1UL] != '/') {
                (void)soPath.append("/");
            }
            GetTensorflowThreadModeSoPath(soPath);
            GetTfKernelThreadModeSoPath(soPath);
            return AE_STATUS_SUCCESS;
        } else {
            return AE_STATUS_INNER_ERROR;
        }
    }

    void FWKKernelTfImpl::GetThreadModelSoPath(std::string &soPath)
    {
        uint32_t runMode;
        aicpu::status_t status = aicpu::GetAicpuRunMode(runMode);
        if (status != aicpu::AICPU_ERROR_NONE) {
            AE_ERR_LOG(AE_MODULE_ID, "Get current aicpu ctx failed.");
            return;
        }
        if (runMode != aicpu::AicpuRunMode::THREAD_MODE) {
            return;
        }
        std::string threadSoPath;
        if (GetTfThreadModeSoPath(threadSoPath) != AE_STATUS_SUCCESS) {
            AE_WARN_LOG(AE_MODULE_ID, "GetThreadModeSoPath failed.");
            return;
        }
        soPath = threadSoPath;
        soFile_ = threadSoPath + TF_SO_NAME;
    }

    int32_t FWKKernelTfImpl::CallKernelApi(const uint64_t fwkKernelParam)
    {
        void *theFuncAddr = nullptr;
        AE_RW_LOCK_RD_LOCK(&rwLock_);
        if (static_cast<bool>(unlikely(funcAddr_ != nullptr))) {
            theFuncAddr = funcAddr_;
        }
        AE_RW_LOCK_UN_LOCK(&rwLock_);

        if (static_cast<bool>(unlikely(theFuncAddr == nullptr))) {
            AE_RW_LOCK_WR_LOCK(&rwLock_);
            if (static_cast<bool>(unlikely(funcAddr_ == nullptr))) {
                AE_INFO_LOG(AE_MODULE_ID, "Begin to GetApi, soFile=%s, kernelName=%s.",
                    GetSoFile().c_str(), GetKernelName().c_str());

                aeStatus_t retGetApi = AE_STATUS_SUCCESS;
                if (static_cast<bool>(unlikely(soHandle_ == nullptr))) {
                    retGetApi = SingleSoManager::GetApi(GetSoFile().data(), GetKernelName().data(),
                                                        &funcAddr_, &soHandle_);
                } else {
                    retGetApi = SingleSoManager::GetFunc(soHandle_, GetKernelName().data(), &funcAddr_);
                }
                AE_INFO_LOG(AE_MODULE_ID, "End to GetApi, retGetApi=%d.", retGetApi);

                if (static_cast<bool>(unlikely((retGetApi == AE_STATUS_SUCCESS) && (funcAddr_ == nullptr)))) {
                    AE_RW_LOCK_UN_LOCK(&rwLock_);
                    AE_ERR_LOG(AE_MODULE_ID, "Get a NULL func addr, but status is success.");
                    return AE_STATUS_INNER_ERROR;
                } else if (static_cast<bool>(unlikely(retGetApi != AE_STATUS_SUCCESS))) {
                    AE_RW_LOCK_UN_LOCK(&rwLock_);
                    AE_ERR_LOG(AE_MODULE_ID, "Get API or Func failed, ret[%d].", static_cast<int32_t>(retGetApi));
                    return retGetApi;
                } else {
                    AE_INFO_LOG(AE_MODULE_ID, "Get API or Func success.");
                }
            }
            theFuncAddr = funcAddr_;
            AE_RW_LOCK_UN_LOCK(&rwLock_);
        }

        const uint32_t tfRet = (reinterpret_cast<FwkTfOpFuncPtr>(theFuncAddr))(fwkKernelParam);
        // for tensorflow will should check the result.
        return static_cast<int32_t>(TransformKernelErrorCode(tfRet, fwkKernelParam));
    }

    aeStatus_t FWKKernelTfImpl::LoadTfSo()
    {
        AE_RW_LOCK_RD_LOCK(&rwLock_);
        if (soHandle_ != nullptr) {
            AE_RW_LOCK_UN_LOCK(&rwLock_);
            return AE_STATUS_SUCCESS;
        }
        AE_RW_LOCK_UN_LOCK(&rwLock_);

        AE_RW_LOCK_WR_LOCK(&rwLock_);
        if (soHandle_ != nullptr) {
            AE_RW_LOCK_UN_LOCK(&rwLock_);
            return AE_STATUS_SUCCESS;
        }
        aeStatus_t ret = SingleSoManager::OpenSo(tensorflowSoFile_, &soTensorflowHandle_);
        if (ret != AE_STATUS_SUCCESS) {
            AE_RUN_WARN_LOG(AE_MODULE_ID, "load tensorflow so failed, ret is[%d]", ret);
        }
        ret = SingleSoManager::OpenSo(soFile_, &soHandle_);
        if (ret != AE_STATUS_SUCCESS) {
            AE_RW_LOCK_UN_LOCK(&rwLock_);
            return ret;
        }
        AE_RW_LOCK_UN_LOCK(&rwLock_);
        return AE_STATUS_SUCCESS;
    }

    aeStatus_t FWKKernelTfImpl::TransformKernelErrorCode(const uint32_t errCode, const uint64_t fwkKernelParam)
    {
        if (errCode == 0U) {
            return AE_STATUS_SUCCESS;
        }
        // check tf end of sequence
        if (errCode == aicpu::FWKAdapter::FWK_ADPT_NATIVE_END_OF_SEQUENCE) {
            return AE_STATUS_END_OF_SEQUENCE;
        }
        uint32_t returnCode = errCode;
        if (errCode == aicpu::FWKAdapter::FWK_ADPT_NOT_SUPPORT_OPTYPE) {
            returnCode = AE_STATUS_BAD_PARAM;
        }
        AE_ERR_LOG(AE_MODULE_ID, "Call tf api return failed:%u, returncode:%u, input param to tf api:0x%lx",
            errCode, returnCode, fwkKernelParam);
        // other error code: transform to inner_error
        return static_cast<aeStatus_t>(returnCode);
    }

    const std::string &FWKKernelTfImpl::GetSoFile() const
    {
        return soFile_;
    }

    const std::string &FWKKernelTfImpl::GetKernelName() const
    {
        return kernelName_;
    }
}