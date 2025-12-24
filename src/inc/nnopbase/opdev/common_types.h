/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OP_API_COMMON_INC_OPDEV_COMMON_TYPES_H_
#define OP_API_COMMON_INC_OPDEV_COMMON_TYPES_H_

#include <map>
#include <securec.h>
#include <unordered_set>
#include <type_traits>

#include <complex>

#include "exe_graph/runtime/tensor.h"
#include "fast_vector.h"
#include "fp16_t.h"
#include "bfloat16.h"
#include "object.h"
#include "op_def.h"
#include "graph/ascend_string.h"

namespace op {
constexpr uint64_t MAX_DIM_NUM = 25;

using Strides = FVector<int64_t, MAX_DIM_NUM>;
using ShapeVector = FVector<int64_t, MAX_DIM_NUM>;
using Shape = gert::Shape;
using Format = ge::Format;
using DataType = ge::DataType;
using Tensor = gert::Tensor;
using StorageShape = gert::StorageShape;
using StorageFormat = gert::StorageFormat;
using TensorPlacement = gert::TensorPlacement;

ge::AscendString ToString(op::DataType dataType);
size_t TypeSize(DataType dataType);
void ToContiguousStrides(const op::Shape &shape, op::Strides &strides);
} // namespace op

namespace mem {
class KernelGraph;
}

class aclStorage : public op::Object {
public:
    aclStorage() = default;
    ~aclStorage() override;
    explicit aclStorage(void *addr);
    explicit aclStorage(bool fromWorkspace);
    aclStorage(void *addr, bool fromWorkspace);
    void *GetAddr() const;
    void SetAddr(void *addr);
    void SetWorkspaceOffset(uint64_t offset);
    uint64_t GetWorkspaceOffset() const;
    void SetFromWorkspace(bool fromWorkspace);
    bool IsFromWorkspace() const;
    void SetExtend(void *extend);
    void *GetExtend() const;

    void SetStorageOffset(int64_t offset);
    int64_t GetStorageOffset() const;

private:
    void *addr_{nullptr};
    uint64_t workspaceOffset_{0};
    int64_t storageOffset_{0};
    bool fromWorkspace_{false};
    /* This is degisned for the following scenario:
     * Op1 --->  ViewCopy or Reshape ---> op2
     * ViewCopy and Reshape is special op which will not call
     * ADD_TO_AICORE_KERNEL_LAUNCH_LIST, so they do not have
     * corresponding kernel nodes.
     * The only relation is Op1's output aclTensor's storage pointer is
     * as same as the storage pointer of input's aclTensor of op2.
     * We use this extend pointer to link them in KernelGraph. */
    void *extend_{nullptr};
    uint8_t reserved_field_[8];
};

template<typename T>
class aclArray : public op::Object {
public:
    ~aclArray() override;

    T &operator[](uint64_t i);

    const T &operator[](uint64_t i) const;

    uint64_t Size() const;

    const T *GetData() const;

    ge::AscendString ToString() const;

protected:
    aclArray(const T *value, uint64_t size);

private:
    T *value_{nullptr};
    uint64_t size_{0};
    uint8_t reserved_field_[8];
};

#define ACL_ARRAY(Type, T)                                                              \
    class acl##Type##Array : public aclArray<T> {                                       \
        friend struct aclOpExecutor;                                                    \
        friend acl##Type##Array *aclCreate##Type##Array(const T *value, uint64_t size); \
        friend aclnnStatus aclDestroy##Type##Array(const acl##Type##Array *array);      \
                                                                                        \
    private:                                                                            \
        acl##Type##Array(const T *value, uint64_t size)                                 \
            : aclArray<T>(value, size)                                                  \
        {                                                                               \
        }                                                                               \
        ~acl##Type##Array() override                                                    \
        {}                                                                              \
    }

ACL_ARRAY(Bool, bool);
ACL_ARRAY(Int, int64_t);
ACL_ARRAY(Float, float);
ACL_ARRAY(Fp16, op::fp16_t);
ACL_ARRAY(Bf16, op::bfloat16);

class aclTensor : public op::Object {
    friend class aclOpExecutor;
    friend mem::KernelGraph;
    friend class aclTensorList;
    friend aclTensor *aclCreateTensor(const int64_t *viewDims, uint64_t viewDimsNum, aclDataType dataType,
                                      const int64_t *stride, int64_t offset, aclFormat format,
                                      const int64_t *storageDims, uint64_t storageDimsNum,
                                      void *tensorData);
    friend aclnnStatus aclDestroyTensor(const aclTensor *tensor);

public:
    const op::Shape &GetStorageShape() const;
    void SetStorageShape(const op::Shape &shape) const;

    const op::Shape &GetOriginalShape() const;
    void SetOriginalShape(const op::Shape &shape) const;

    const op::Shape &GetViewShape() const;
    void SetViewShape(const op::Shape &shape);

    op::Format GetStorageFormat() const;
    void SetStorageFormat(op::Format format);

    op::Format GetOriginalFormat() const;
    void SetOriginalFormat(op::Format format);

    op::Format GetViewFormat() const;
    void SetViewFormat(op::Format format);

    const op::Strides &GetViewStrides() const;
    void SetViewStrides(const op::Strides &strides);
    void SetViewStrides(op::Strides &&strides);

    aclTensor &operator=(const aclTensor &other) = delete;
    aclTensor &operator=(aclTensor &&other) = delete;
    aclTensor(aclTensor &&other) = delete;
    op::Tensor *GetTensor() const;
    void *GetData() const;
    void *GetStorageAddr() const;
    const aclStorage *GetStorage() const;
    int64_t Size() const;
    /**
     * Get the number of elements in this tensor
     */
    int64_t Numel() const;
    op::DataType GetDataType() const;
    int64_t GetViewOffset() const;
    int64_t GetStorageOffset() const;

    void SetStorageAddr(void *addr) const;

    void SetViewOffset(int64_t offset) const;
    void SetStorageOffset(int64_t offset);

    void SetWorkspaceOffset(uint64_t offset) const;
    uint64_t GetWorkspaceOffset() const;

    void SetExtend(void *extend) const;
    void *GetExtend() const;

    op::TensorPlacement GetPlacement() const;
    bool IsEmpty() const;

    ge::AscendString ToString() const;
    void SetFromWorkspace(bool from_workspace) const;
    bool IsFromWorkspace() const;

    template<typename T>
    void SetData(int64_t index, const T value, op::DataType dataType);
    template<typename T>
    void SetData(const T *value, uint64_t size, op::DataType dataType);
    void SetDataType(op::DataType dataType);
    void SetBoolData(const bool *value, uint64_t size, op::DataType dataType);
    void SetIntData(const int64_t *value, uint64_t size, op::DataType dataType);
    void SetFloatData(const float *value, uint64_t size, op::DataType dataType);
    void SetFp16Data(const op::fp16_t *value, uint64_t size, op::DataType dataType);
    void SetBf16Data(const op::bfloat16 *value, uint64_t size, op::DataType dataType);
    void InitTensor(const int64_t *viewDims, uint64_t viewDimsNum, aclDataType dataType,
                    const int64_t *stride, int64_t offset, aclFormat format,
                    const int64_t *storageDims, uint64_t storageDimsNum,
                    void *tensorDataAddr);

private:
    aclTensor(const int64_t *viewDims, uint64_t viewDimsNum, aclDataType dataType, const int64_t *stride,
              int64_t offset, const aclFormat format, const int64_t *storageDims, uint64_t storageDimsNum,
              void *tensorDataAddr);
    aclTensor(op::DataType dataType, op::Format storageFormat, op::Format originFormat);
    aclTensor(const op::Shape &shape, op::DataType dataType, op::Format format, void *tensorDataAddr);
    aclTensor(const op::Shape &storageShape, const op::Shape &originShape, op::DataType dataType,
              op::Format storageFormat, op::Format originFormat, void *tensorDataAddr);
    aclTensor(const op::Shape &shape, op::DataType dataType, op::Format format);
    aclTensor(const op::Shape &storageShape, const op::Shape &originShape, op::DataType dataType,
              op::Format storageFormat, op::Format originFormat);
    aclTensor(const aclTensor &other, const op::Shape &shape, int64_t offset);
    aclTensor(const aclIntArray *value, op::DataType dataType);
    aclTensor(const aclBoolArray *value, op::DataType dataType);
    aclTensor(const aclFloatArray *value, op::DataType dataType);
    aclTensor(const aclFp16Array *value, op::DataType dataType);
    aclTensor(const aclBf16Array *value, op::DataType dataType);
    ~aclTensor() override;
    template<typename T>
    aclTensor(const T *value, uint64_t size, op::DataType dataType);
    aclTensor(const aclScalar *value, op::DataType dataType);
    bool IsView() const;
    void SetView(bool is_view);

private:
    mutable op::Tensor *tensor_{nullptr};
    mutable aclStorage *storage_{nullptr};
    mutable int64_t viewOffset_{0};
    op::Strides viewStrides_{};
    op::Shape viewShape_{0};
    op::Format viewFormat_;
    bool isView_{false};
    uint8_t reserved_field_[8]{0};
};

struct aclTensorList : public op::Object {
    friend class aclOpExecutor;
    friend aclTensorList *aclCreateTensorList(const aclTensor *const *value, uint64_t size);
    friend aclnnStatus aclDestroyTensorList(const aclTensorList *array);

public:
    aclTensor *&operator[](uint64_t i);
    const aclTensor *operator[](uint64_t i) const;
    uint64_t Size() const;
    const aclTensor *const *GetData() const;
    ge::AscendString ToString() const;

private:
    aclTensor **tensors_{nullptr};
    uint64_t size_{0};
    uint8_t reserved_field_[8];

private:
    aclTensorList(const aclTensor *const *tensors, uint64_t size);
    ~aclTensorList() override;
};

namespace op {
template<typename T>
class InputArg;
}

class aclScalar : public op::Object {
    friend class aclOpExecutor;
    friend class aclScalarList;

public:
    aclScalar(const void *data, op::DataType dataType);
    const void *GetData() const;
    uint64_t Size() const;
    op::DataType GetDataType() const;
    ~aclScalar() override {}
    float ToFloat() const;
    double ToDouble() const;
    bool ToBool() const;
    int8_t ToInt8() const;
    int16_t ToInt16() const;
    int32_t ToInt32() const;
    int64_t ToInt64() const;
    uint8_t ToUint8() const;
    uint16_t ToUint16() const;
    uint32_t ToUint32() const;
    uint64_t ToUint64() const;
    op::fp16_t ToFp16() const;
    op::bfloat16 ToBf16() const;
    std::complex<float> ToComplex64() const;
    std::complex<double> ToComplex128() const;
    ge::AscendString ToString() const;
    /**
     * 检查scalar转换成目标数据类型是否会溢出
     * @tparam to 目标数据类型
     * @return true:溢出, false:不溢出
     */
    template<typename to>
    bool CheckOverflows() const;

private:
    explicit aclScalar(int32_t value);
    explicit aclScalar(int64_t value);
    explicit aclScalar(int16_t value);
    explicit aclScalar(int8_t value);
    explicit aclScalar(uint32_t value);
    explicit aclScalar(uint64_t value);
    explicit aclScalar(uint16_t value);
    explicit aclScalar(uint8_t value);
    explicit aclScalar(float value);
    explicit aclScalar(double value);
    explicit aclScalar(op::fp16_t value);
    explicit aclScalar(op::bfloat16 value);
    explicit aclScalar(bool value);
    template<typename T>
    T To() const;
    ge::AscendString ToStr() const;
    op::bfloat16 BFloat16() const
    {
        return op::bfloat16(v.ui16, op::bfloat16::from_bits());
    }

private:
    op::DataType dataType_;
    union v_t {
        float f;
        int8_t i8;
        uint8_t ui8;
        int16_t i16;
        uint16_t ui16;
        int32_t i32;
        uint32_t ui32;
        double d;
        int64_t i64;
        uint64_t ui64;
        std::complex<float> complex64;
        std::complex<double> complex128;
        v_t() {};
    } v;
};

struct aclScalarList : public op::Object {
    friend class aclOpExecutor;
    friend aclScalarList *aclCreateScalarList(const aclScalar *const *value, uint64_t size);
    friend aclnnStatus aclDestroyScalarList(const aclScalarList *array);

public:
    aclScalar *&operator[](uint64_t i);
    const aclScalar *operator[](uint64_t i) const;
    uint64_t Size() const;
    const aclScalar *const *GetData() const;
    ge::AscendString ToString() const;

private:
    aclScalar **scalars_{nullptr};
    uint64_t size_{0};
    uint8_t reserved_field_[16];

private:
    aclScalarList(const aclScalar *const *scalars, uint64_t size);
    ~aclScalarList() override;
};

ge::AscendString ToString(const aclTensor* t);
ge::AscendString ToString(const aclTensorList* t);
ge::AscendString ToString(const aclIntArray* t);
ge::AscendString ToString(const aclBoolArray* t);
ge::AscendString ToString(const aclFloatArray* t);
ge::AscendString ToString(const aclFp16Array* t);
ge::AscendString ToString(const aclBf16Array* t);
ge::AscendString ToString(const aclScalar* t);
ge::AscendString ToString(const aclScalarList* t);

ge::AscendString ToString(const aclTensor& t);
ge::AscendString ToString(const aclTensorList& t);
ge::AscendString ToString(const aclIntArray& t);
ge::AscendString ToString(const aclBoolArray& t);
ge::AscendString ToString(const aclFloatArray& t);
ge::AscendString ToString(const aclFp16Array& t);
ge::AscendString ToString(const aclBf16Array& t);
ge::AscendString ToString(const aclScalar& t);
ge::AscendString ToString(const aclScalarList& t);

ge::AscendString ToString(aclDataType dataType);


#endif // OP_API_COMMON_INC_OPDEV_COMMON_TYPES_H_
