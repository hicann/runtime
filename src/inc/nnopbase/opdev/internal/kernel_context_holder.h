/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OP_API_OP_API_COMMON_INC_OPDEV_INTERNAL_KERNEL_CONTEXT_HOLDER_H
#define OP_API_OP_API_COMMON_INC_OPDEV_INTERNAL_KERNEL_CONTEXT_HOLDER_H
#include <array>
#include <cstddef>
#include <sstream>
#include <vector>

#include "exe_graph/runtime/kernel_run_context.h"
#include "opdev/internal/kernel_arg.h"
#include "opdev/internal/kernel_utils.h"
#include "opdev/internal/op_ctx_def.h"
#include "opdev/op_errno.h"
#include "opdev/op_dfx.h"

namespace op::internal {
class KernelContextHolder {
public:
    KernelContextHolder()
    {
        BuildComputeNodeInfo();
        BuildOpInOutArg();
    };

    ~KernelContextHolder();

    KernelContextHolder(const KernelContextHolder &) = delete;
    KernelContextHolder(KernelContextHolder &&) = delete;
    KernelContextHolder &operator=(const KernelContextHolder &) = delete;
    KernelContextHolder &operator=(KernelContextHolder &&) = delete;

    void UpdateOutputArgIr(OpArgList &output) const
    {
        size_t outputIdx = 0;
        output.VisitByNoReturn(
            [this, &outputIdx](size_t idx, OpArg &arg) {
                UpdateOutputArgIr(idx, arg, outputIdx);
            });
    }

    aclnnStatus UpdateComputeNodeInfo(const char *opType, OpArgList &input, OpArgList &output,
                                      OpArgList &attr)
    {
        ResetComputeNodeInfo(opType, input.count, output.count);
        UpdateCompileDescOffset(input.count);
        CHECK_RET_CODE(input.VisitBy([this](size_t idx, OpArg &arg) { return UpdateInputArg(idx, arg); }),
                       "UpdateInputArg failed.");
        CHECK_RET_CODE(output.VisitBy([this](size_t idx, OpArg &arg) { return UpdateOutputArg(idx, arg); }),
                       "UpdateInputArg failed.");
        FinalizeComputeNodeInfo(attr.count);
        void *attrPtr = attrDataStart_;
        CHECK_RET_CODE(attr.VisitBy(
                           [this, &attrPtr](size_t idx, OpArg &arg) {
                               return UpdateAttrArg(idx, arg, attrPtr);
                           }),
                       "Update Attr Arg failed");
        computeNodeInfo_->attr_size_ = PtrOffset(attrDef_, attrPtr);
        outputAnchorInfo_ = PtrCastTo<AnchorInstanceInfo>(attrPtr);
        UpdateOutputArgIr(output);
        return ACLNN_SUCCESS;
    }

    void UpdateKernelExtendInfo(const char *kernelType, const char *kernelName);
    void ResetComputeNodeInfo(const char *opType, size_t irInputNum, size_t irOutputNum);
    void UpdateCompileDescOffset(size_t irInputNum);
    void FinalizeComputeNodeInfo(size_t attrNum);

    template<size_t N>
    void AppendAttr(const std::array<size_t, N> &attrSize, std::array<void *, N> &attrAddr) const
    {
        void *attrPtr = attrDataStart_;
        for (size_t i = 0; i < N; i++) {
            attrDef_->offset[i] = PtrOffset(attrDef_, attrPtr);
            attrAddr[i] = attrPtr;
            attrPtr = PtrShift(attrPtr, attrSize[i]);
        }
    };

    size_t inputNum_{0};
    size_t outputNum_{0};
    AsyncAnyValue *opInArg_{nullptr};
    void *attrDataStart_{nullptr};

    ComputeNodeInfo *computeNodeInfo_{nullptr};
    KernelExtendInfo kernelExtendInfo_;

private:
    void BuildComputeNodeInfo();
    void BuildOpInOutArg();

    void UpdateAttrDefOffset(size_t inoutNum, size_t attrNum);

    aclnnStatus UpdateInputArg(size_t idx, OpArg &arg);
    aclnnStatus UpdateInputArg(size_t idx, const aclTensor *tensor);
    aclnnStatus UpdateInputArg(size_t idx, const aclTensorList *tensorList);
    aclnnStatus UpdateOutputArg(size_t idx, OpArg &arg);
    aclnnStatus UpdateOutputArg(size_t idx, const aclTensor *tensor);
    aclnnStatus UpdateOutputArg(size_t idx, const aclTensorList *tensorList);

    void UpdateOutputArgIr(size_t idx, OpArg &arg, size_t &seq) const;
    void UpdateOutputArgIr(size_t idx, const aclTensor *tensor, size_t &seq) const;
    void UpdateOutputArgIr(size_t idx, const aclTensorList *tensorList, size_t &seq) const;

    inline aclnnStatus UpdateAttrArg(size_t idx, op::DataType value, void *&attrPtr)
    {
        OP_LOGD("Update Attr DataType: [%zu], %d", idx, value);
        *static_cast<int64_t *>(attrPtr) = 0L;
        *static_cast<DataType *>(attrPtr) = value;
        attrPtr = PtrShift(attrPtr, sizeof(int64_t));
        return ACLNN_SUCCESS;
    }

    inline aclnnStatus UpdateAttrArg(size_t idx, int64_t value, void *&attrPtr)
    {
#ifdef DEBUG
        std::stringstream ss;
        ss << value;
        OP_LOGD("Update Attr arg Scalar: [%zu] %s", idx, ss.str().c_str());
#else
        OP_LOGD("Update Attr arg Scalar: [%zu]", idx);
#endif
        *static_cast<int64_t *>(attrPtr) = value;
        attrPtr = PtrShift(attrPtr, sizeof(uint64_t));
        return ACLNN_SUCCESS;
    }

    inline aclnnStatus UpdateAttrArg(size_t idx, double value, void *&attrPtr)
    {
#ifdef DEBUG
        std::stringstream ss;
        ss << value;
        OP_LOGD("Update Attr arg Scalar: [%zu] %s", idx, ss.str().c_str());
#else
        OP_LOGD("Update Attr arg Scalar: [%zu]", idx);
#endif
        *static_cast<double *>(attrPtr) = value;
        attrPtr = PtrShift(attrPtr, sizeof(double));
        return ACLNN_SUCCESS;
    }

    inline aclnnStatus UpdateAttrArg(size_t idx, float value, void *&attrPtr)
    {
#ifdef DEBUG
        std::stringstream ss;
        ss << value;
        OP_LOGD("Update Attr arg Scalar: [%zu] %s", idx, ss.str().c_str());
#else
        OP_LOGD("Update Attr arg Scalar: [%zu]", idx);
#endif
        *static_cast<int64_t *>(attrPtr) = 0L;
        *static_cast<float *>(attrPtr) = value;
        attrPtr = PtrShift(attrPtr, sizeof(int64_t));
        return ACLNN_SUCCESS;
    }

    aclnnStatus UpdateAttrArg(size_t idx, char *value, void *&attrPtr)
    {
        if (value == nullptr) {
            OP_LOGW("Update Attr NULL char*: [%zu]", idx);
            *static_cast<char *>(attrPtr) = '\0';
            attrPtr = PtrShift(attrPtr, sizeof(int64_t));
        } else {
            OP_LOGD("Update Attr char*: [%zu]. %s", idx, value);
            size_t slen = strlen(value);
            if (slen >= MAX_ATTR_STRING_SIZE) {
                OP_LOGD("Update Attr char* too long: [%zu]. len: [%zu]", idx, slen);
                return ACLNN_ERR_INNER;
            }
            OP_CHECK(memcpy_s(attrPtr, slen + 1, value, slen + 1) == EOK,
                     OP_LOGW("Failed to memcpy in update attr arg for char."),
                     ;);
            attrPtr = PtrShift(attrPtr, AlignSize(slen + 1, sizeof(size_t)));
        }
        return ACLNN_SUCCESS;
    }

    aclnnStatus UpdateAttrArg(size_t idx, aclScalar *value, void *&attrPtr)
    {
        if (value == nullptr) {
            OP_LOGW("Update Attr NULL aclScalar*: [%zu]", idx);
            *static_cast<int64_t *>(attrPtr) = 0;
            attrPtr = PtrShift(attrPtr, sizeof(int64_t));
        } else {
            OP_LOGD("Update Attr aclScalar*: [%zu]", idx);
            OP_CHECK(memcpy_s(attrPtr, value->Size(), value->GetData(), value->Size()) == EOK,
                     OP_LOGW("Failed to memcpy in update attr arg for aclScalar."),
                     ;);
            attrPtr = PtrShift(attrPtr, value->Size());
        }
        return ACLNN_SUCCESS;
    }

    aclnnStatus UpdateAttrArg(size_t idx, aclIntArray *value, void *&attrPtr)
    {
        auto *pv = static_cast<gert::ContinuousVector *>(attrPtr);
        if (value == nullptr || value->Size() == 0) {
            OP_LOGW("Update Attr NULL aclIntArray*: [%zu]", idx);
            pv->Init(0);
            attrPtr = PtrShift(attrPtr, sizeof(gert::ContinuousVector));
        } else {
            auto sz = value->Size();
            OP_LOGD("Update Attr aclIntArray*: [%zu], size: %zu", idx, sz);
            pv->Init(sz);
            pv->SetSize(sz);
            auto size = sizeof(*(value->GetData())) * sz;
            OP_CHECK(memcpy_s(pv->MutableData(), size, value->GetData(), size) == EOK,
                     OP_LOGW("Failed to memcpy in update attr arg for aclIntArray."),
                     ;);
            attrPtr = PtrShift(attrPtr, PtrOffset(pv, pv->GetData()) + size);
        }
        return ACLNN_SUCCESS;
    }

    aclnnStatus UpdateAttrArg(size_t idx, aclFloatArray *fvalue, void *&attrPtr)
    {
        auto *pv = static_cast<gert::ContinuousVector *>(attrPtr);
        if (fvalue == nullptr || fvalue->Size() == 0) {
            OP_LOGW("Update Attr NULL aclFloatArray*: [%zu]", idx);
            pv->Init(0);
            attrPtr = PtrShift(attrPtr, sizeof(gert::ContinuousVector));
        } else {
            auto sz = fvalue->Size();
            OP_LOGD("Update Attr aclFloatArray*: [%zu], size: %zu", idx, sz);
            pv->Init(sz);
            pv->SetSize(sz);
            auto size = sizeof(*(fvalue->GetData())) * sz;
            OP_CHECK(memcpy_s(pv->MutableData(), size, fvalue->GetData(), size) == EOK,
                     OP_LOGW("Failed to memcpy in update attr arg for aclFloatArray."),
                     ;);
            attrPtr = PtrShift(attrPtr, PtrOffset(pv, pv->GetData()) + size);
        }
        return ACLNN_SUCCESS;
    }

    aclnnStatus UpdateAttrArg(size_t idx, aclBoolArray *value, void *&attrPtr)
    {
        auto *pv = static_cast<gert::ContinuousVector *>(attrPtr);
        if (value == nullptr || value->Size() == 0) {
            OP_LOGW("Update Attr NULL aclBoolArray*: [%zu]", idx);
            pv->Init(0);
            attrPtr = PtrShift(attrPtr, sizeof(gert::ContinuousVector));
        } else {
            auto sz = value->Size();
            OP_LOGD("Update Attr aclBoolArray*: [%zu], size: %zu", idx, sz);
            pv->Init(sz);
            pv->SetSize(sz);
            auto size = sizeof(*(value->GetData())) * sz;
            OP_CHECK(memcpy_s(pv->MutableData(), size, value->GetData(), size) == EOK,
                     OP_LOGW("Failed to memcpy in update attr arg for aclBoolArray."),
                     ;);
            attrPtr = PtrShift(attrPtr, PtrOffset(pv, pv->GetData()) + size);
        }
        return ACLNN_SUCCESS;
    }

    aclnnStatus UpdateAttrArg(size_t idx, OpArg &arg, void *&attrPtr)
    {
        if (PtrOffset(attrDataStart_, attrPtr) >= ATTR_CAPACITY) {
            OP_LOGE(ACLNN_ERR_INNER, "attr too large. should less than [%zu]", ATTR_CAPACITY);
            return ACLNN_ERR_INNER;
        }
        attrDef_->offset[idx] = PtrOffset(attrDef_, attrPtr);
        switch (arg.type) {
            case OpArgType::OPARG_DATATYPE:
                return UpdateAttrArg(idx, static_cast<op::DataType>(arg->value), attrPtr);
            case OpArgType::OPARG_BOOL:
            case OpArgType::OPARG_INT:
            case OpArgType::OPARG_UINT:
            case OpArgType::OPARG_IMPLMODE:
                return UpdateAttrArg(idx, arg->ivalue, attrPtr);
            case OpArgType::OPARG_FLOAT:
                return UpdateAttrArg(idx, arg->fvalue, attrPtr);
            case OpArgType::OPARG_DOUBLE:
                return UpdateAttrArg(idx, arg->dvalue, attrPtr);
            case OpArgType::OPARG_STRING:
                return UpdateAttrArg(idx, reinterpret_cast<char *>(arg->pointer), attrPtr);
            case OpArgType::OPARG_ACLSCALAR:
                return UpdateAttrArg(idx, reinterpret_cast<aclScalar *>(arg->pointer), attrPtr);
            case OpArgType::OPARG_INT_LIST:
                return UpdateAttrArg(idx, reinterpret_cast<aclIntArray *>(arg->pointer), attrPtr);
            case OpArgType::OPARG_FLOAT_LIST:
                return UpdateAttrArg(idx, reinterpret_cast<aclFloatArray *>(arg->pointer), attrPtr);
            case OpArgType::OPARG_BOOL_LIST:
                return UpdateAttrArg(idx, reinterpret_cast<aclBoolArray *>(arg->pointer), attrPtr);
            default:
                OP_LOGE(ACLNN_ERR_INNER,
                        "Attr Type NOT SUPPORTED. supported type[ge::DataType, aclScalar, std::string, aclIntArray, aclFloatArray, aclBoolArray, arithmetic type]");
                return ACLNN_ERR_INNER;
        }
    }

    size_t irInputNum_{0};
    size_t irOutputNum_{0};
    size_t computeNodeInfoSize_{0};

    AnchorInstanceInfo *anchorInfo_{nullptr};
    AnchorInstanceInfo *outputAnchorInfo_{nullptr};
    CompileTimeTensorDesc *compileDesc_{nullptr};
    RuntimeAttrsDef *attrDef_{nullptr};
    size_t attrNum_{0};
};

} // namespace op::internal

#endif //OP_API_OP_API_COMMON_INC_OPDEV_INTERNAL_KERNEL_CONTEXT_HOLDER_H
