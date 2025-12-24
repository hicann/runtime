/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef OP_API_WORKSPACE_UTILS_H
#define OP_API_WORKSPACE_UTILS_H

#include "common_types.h"
#include "data_type_utils.h"
#include "fast_vector.h"
#include "opdev/object.h"
#include "opdev/op_cache.h"
#include "opdev/op_arg_def.h"
#include "opdev/op_log.h"
#include "opdev/op_config.h"

constexpr size_t ALLOCATE_OBJ_DEFAULT_SIZE = 128;
constexpr uint64_t K_EXECUTOR_MAGIC_NUMBER = 0x1F2E3D4C5B6A;
namespace op {
class KernelLauncher;
class OpExecutorImpl;

}  // namespace op

enum DSA_TASK_TYPE {
    DSARandomNormalTaskType,
    DSARandomTruncatedNormalTaskType,
    DSARandomUniformTaskType,
    DSAGenBitMaskTaskType
};

struct aclOpExecutor : public op::Object {
    friend class UniqueExecutor;
protected:
    aclOpExecutor();
private:
    uint64_t magicNumber_{K_EXECUTOR_MAGIC_NUMBER};
public:
    ~aclOpExecutor() override;
    aclTensor *AllocTensor(const op::Shape &shape, op::DataType dataType, op::Format format = op::Format::FORMAT_ND);
    aclTensor *AllocTensor(const op::Shape &storageShape, const op::Shape &originShape, op::DataType dataType,
        op::Format storageFormat, op::Format originFormat);
    aclTensor *AllocTensor(op::DataType dataType, op::Format storageFormat, op::Format originFormat);
    aclTensor *AllocHostTensor(const op::Shape &shape, op::DataType datatype,
        op::Format format = op::Format::FORMAT_ND);
    aclTensor *AllocHostTensor(const op::Shape &storageShape, const op::Shape &originShape,
        op::DataType dataType, op::Format storageFormat, op::Format originFormat);
    aclTensor *AllocHostTensor(const int64_t *value, uint64_t size, op::DataType dataType);
    aclTensor *AllocHostTensor(const uint64_t *value, uint64_t size, op::DataType dataType);
    aclTensor *AllocHostTensor(const bool *value, uint64_t size, op::DataType dataType);
    aclTensor *AllocHostTensor(const char *value, uint64_t size, op::DataType dataType);
    aclTensor *AllocHostTensor(const int32_t *value, uint64_t size, op::DataType dataType);
    aclTensor *AllocHostTensor(const uint32_t *value, uint64_t size, op::DataType dataType);
    aclTensor *AllocHostTensor(const int16_t *value, uint64_t size, op::DataType dataType);
    aclTensor *AllocHostTensor(const uint16_t *value, uint64_t size, op::DataType dataType);
    aclTensor *AllocHostTensor(const int8_t *value, uint64_t size, op::DataType dataType);
    aclTensor *AllocHostTensor(const uint8_t *value, uint64_t size, op::DataType dataType);
    aclTensor *AllocHostTensor(const double *value, uint64_t size, op::DataType dataType);
    aclTensor *AllocHostTensor(const float *value, uint64_t size, op::DataType dataType);
    aclTensor *AllocHostTensor(const op::fp16_t *value, uint64_t size, op::DataType dataType);
    aclTensor *AllocHostTensor(const op::bfloat16 *value, uint64_t size, op::DataType dataType);
    aclTensor *CreateView(const aclTensor *tensor, const op::Shape &shape, int64_t offset);
    aclIntArray *AllocIntArray(const int64_t *value, uint64_t size);
    aclFloatArray *AllocFloatArray(const float *value, uint64_t size);
    aclBoolArray *AllocBoolArray(const bool *value, uint64_t size);
    aclTensorList *AllocTensorList(const aclTensor *const *tensors, uint64_t size);
    aclScalarList *AllocScalarList(const aclScalar *const *scalars, uint64_t size);
    aclScalar *AllocScalar(const void *data, op::DataType dataType);
    aclScalar *AllocScalar(float value);
    aclScalar *AllocScalar(double value);
    aclScalar *AllocScalar(op::fp16_t value);
    aclScalar *AllocScalar(op::bfloat16 value);
    aclScalar *AllocScalar(int32_t value);
    aclScalar *AllocScalar(int64_t value);
    aclScalar *AllocScalar(int16_t value);
    aclScalar *AllocScalar(int8_t value);
    aclScalar *AllocScalar(uint32_t value);
    aclScalar *AllocScalar(uint64_t value);
    aclScalar *AllocScalar(uint16_t value);
    aclScalar *AllocScalar(uint8_t value);
    aclScalar *AllocScalar(bool value);

    const aclTensor *ConvertToTensor(const aclIntArray *value, op::DataType dataType);
    const aclTensor *ConvertToTensor(const aclBoolArray *value, op::DataType dataType);
    const aclTensor *ConvertToTensor(const aclFloatArray *value, op::DataType dataType);
    const aclTensor *ConvertToTensor(const aclFp16Array *value, op::DataType dataType);
    const aclTensor *ConvertToTensor(const aclBf16Array *value, op::DataType dataType);
    template<typename T>
    const aclTensor *ConvertToTensor(const T *value, uint64_t size, op::DataType dataType)
    {
        aclTensor *tensor = nullptr;
        try {
            tensor = new aclTensor(value, size, dataType);
            allocatedObjList_.push_back(tensor);
            allocatedTensorList_.push_back(tensor);
            return tensor;
        } catch (...) {
            OP_LOGE(ACLNN_ERR_INNER, "aclOpExecutor::ConvertToTensor fail.");
            delete tensor;
            return nullptr;
        }
    }
    const aclTensor *ConvertToTensor(const aclScalar *value, op::DataType dataType);

    void AddToKernelLauncherList(op::KernelLauncher *obj);

    aclnnStatus AddToKernelLauncherListDvpp(uint32_t opType, op::KernelLauncher *obj, op::OpArgContext *args);

    aclnnStatus AddToKernelLauncherListCopyTask(uint32_t opType, op::KernelLauncher *obj, op::OpArgList &inputs,
        op::OpArgList &outputs, op::OpArgList &workspace);

    aclnnStatus AddToKernelLauncherListAiCpu(int32_t opType, op::KernelLauncher *obj, op::OpArgContext *args);

    void UpdateTensorAddr(void *workspaceAddr, const size_t size);
    void *GetWorkspaceAddr() const;
    uint64_t GetWorkspaceSize() const;
    uint64_t GetLinearWorkspaceSize() const;

    const op::FVector<uint64_t> &GetWorkspaceOffsets() const;
    void SetWorkspaceOffsets(const op::FVector<uint64_t> &workspaceOffsets);

    aclnnStatus Run();

    aclrtStream GetStream() const;
    std::vector<const aclTensor *> &GetInputTensors();
    std::vector<const aclTensor *> &GetOutputTensors();
    op::internal::OpLogInfo GetLogInfo() const;
    void SetLogInfo(const op::internal::OpLogInfo &logInfo);
    op::OpConfigInfo GetOpConfigInfo() const;
    void SetOpConfigInfo(const op::OpConfigInfo &opConfigInfo);
    void SetStream(aclrtStream stream);
    void AddTensorRelation(const aclTensor *tensorOut, const aclTensor *tensorMiddle);
    void AbandonCache(bool disableRepeat = false);
    void UpdateStorageAddr();
    aclnnStatus SetRepeatable();
    bool IsRepeatable() const;
    void FinalizeCache();
    aclnnStatus RepeatRunWithCache(void *workspaceAddr, const aclrtStream stream);
    bool CheckLauncherRepeatable();
    void AddCache();
    void DeleteCache();
    op::internal::OpExecCache *GetOpExecCache();
    void SetIOTensorList();
    void *GetGraph();
    uint64_t GetMagicNumber();
    mutable uint64_t workspaceDeviceAicpuTaskOffset_{0};
    uint64_t workspaceDeviceAicpuMem_{0};
private:
    op::FVector<op::KernelLauncher *> kernelLaunchObjList_;
    op::FVector<op::Object *, ALLOCATE_OBJ_DEFAULT_SIZE> allocatedObjList_;
    op::FVector<aclTensor *, ALLOCATE_OBJ_DEFAULT_SIZE> allocatedTensorList_;
    op::OpExecutorImpl *impl_{nullptr};  // Class OpExecutorImpl
    uint8_t reserved_field_[8];  // reserved field
};

class UniqueExecutor : public op::Object {
public:
    explicit UniqueExecutor(const char *funcName);
    ~UniqueExecutor() override
    {
        if (uniqueExecutor_.get() != nullptr) {
            uniqueExecutor_.get()->DeleteCache();
            OP_LOGE_WITHOUT_REPORT(ACLNN_ERR_INNER_NOT_TRANS_EXECUTOR,
                "When %s do success, ReleaseTo(executor) should be called before return.",
                funcName_);
        }
    }

    aclOpExecutor *get() const
    {
        return uniqueExecutor_.get();
    }
 
    void ReleaseTo(aclOpExecutor **executor)
    {
        if (executor != nullptr) {
            *executor = uniqueExecutor_.release();
            (*executor)->AddCache();
        }
    }
 
    aclOpExecutor *operator->()
    {
        return uniqueExecutor_.get();
    }

    UniqueExecutor(const UniqueExecutor &) = delete;
    UniqueExecutor &operator=(const UniqueExecutor &) = delete;

private:
    const char *funcName_;
    std::unique_ptr<aclOpExecutor> uniqueExecutor_{nullptr};
};

aclnnStatus CommonOpExecutorRun(void *workspace, uint64_t workspaceSize, aclOpExecutor *executor, aclrtStream stream);
op::internal::OpExecCacheWrap* GetOpExecCacheFromExecutor(aclOpExecutor *executor);
void InitL2Phase1Context(const char *l2Name, [[maybe_unused]] aclOpExecutor **executor);
void InitL2Phase2Context([[maybe_unused]] const char* l2Name, aclOpExecutor* executor);
void InitL0Context(const char *profilingName, aclOpExecutor* executor);

aclnnStatus CreatAiCoreKernelLauncher([[maybe_unused]] const char *l0Name, uint32_t opType,
    aclOpExecutor *executor, op::OpArgContext *args);
void CreatDSAKernelLauncher([[maybe_unused]] const char *l0Name, uint32_t opType, DSA_TASK_TYPE dsaTask,
    aclOpExecutor *executor, op::OpArgContext *args);

aclnnStatus InferShape(uint32_t optype, op::OpArgList &inputs, op::OpArgList &outputs, op::OpArgList &attrs);

#endif  // OP_API_WORKSPACE_UTILS_H
