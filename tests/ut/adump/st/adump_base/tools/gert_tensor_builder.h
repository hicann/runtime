/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef GERT_TENSOR_BUILDER_H
#define GERT_TENSOR_BUILDER_H

#include <memory>
#include "exe_graph/runtime/tensor.h"
#include "graph/ge_tensor.h"

namespace gert {

struct TensorHolder {
public:
    void SetTensor(std::unique_ptr<Tensor> &&tensor)
    {
        tensor_ = std::move(tensor);
    }

    void SetFollowingTensor(std::unique_ptr<uint8_t[]> &&followingTensor)
    {
        followingTensor_ = std::move(followingTensor);
    }

    Tensor *GetTensor()
    {
        if (tensor_ != nullptr) {
            return tensor_.get();
        }

        if (followingTensor_ != nullptr) {
            return reinterpret_cast<Tensor *>(followingTensor_.get());
        }
        return nullptr;
    }

    std::vector<uint8_t> GetData()
    {
        std::vector<uint8_t> td;
        if (tensor_ == nullptr) {
            return td;
        }
        td.resize(tensor_->GetSize());
        memcpy(td.data(), tensor_->GetAddr(), tensor_->GetSize());
        return td;
    }

private:
    std::unique_ptr<Tensor> tensor_;
    std::unique_ptr<uint8_t[]> followingTensor_;
};

class TensorBuilder {
public:
    TensorBuilder &Shape(std::initializer_list<int64_t> shape);
    TensorBuilder &OriginShape(std::initializer_list<int64_t> shape);
    TensorBuilder &StorageShape(std::initializer_list<int64_t> shape);

    TensorBuilder &Format(ge::Format format);
    TensorBuilder &OriginFormat(ge::Format format);
    TensorBuilder &StorageFormat(ge::Format format);
    TensorBuilder &DataType(ge::DataType dt);
    TensorBuilder &Placement(TensorPlacement placement);
    TensorHolder Build() const;

    template <typename T>
    TensorBuilder &Value(const std::vector<T> &value) {
        tensorValue_.resize(sizeof(T) * value.size());
        memcpy(tensorValue_.data(), value.data(), tensorValue_.size());
        return *this;
    }
private:
    Tensor tensor_{
        {{}, {}},                            // shape
        {ge::FORMAT_ND, ge::FORMAT_ND, {}},  // format
        kOnHost,                             // placement
        ge::DT_FLOAT,                        // data type
        nullptr                              // address
    };

    std::vector<uint8_t> tensorValue_;
};
} // namespace gert

#endif // GERT_TENSOR_BUILDER_H