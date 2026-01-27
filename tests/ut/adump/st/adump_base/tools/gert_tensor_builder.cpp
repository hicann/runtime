/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gert_tensor_builder.h"
#include "graph/ge_tensor.h"

namespace gert {
namespace {

struct StubHostTensorHead {
  size_t count;
  static void *Create(size_t size)
  {
        auto head = static_cast<StubHostTensorHead *>(malloc(sizeof(StubHostTensorHead) + size));
        head->count = 1;
        return head + 1;
  }
};

ge::graphStatus StubHostTensorManager(TensorAddress addr, TensorOperateType operateType, void **out)
{
    auto head = static_cast<StubHostTensorHead *>(addr) - 1;
    switch (operateType) {
        case kGetTensorAddress:
            *out = addr;
            break;
        case kPlusShareCount:
            head->count++;
            break;
        case kFreeTensor:
            if (--head->count == 0) {
                free(head);
            }
            break;
        default:
            return ge::GRAPH_FAILED;
    }
    return ge::GRAPH_SUCCESS;
}
} // namespapce

TensorBuilder &TensorBuilder::Shape(std::initializer_list<int64_t> shape)
{
    return OriginShape(shape).StorageShape(shape);
}

TensorBuilder &TensorBuilder::OriginShape(std::initializer_list<int64_t> shape)
{
    tensor_.MutableOriginShape() = shape;
    return *this;
}

TensorBuilder &TensorBuilder::StorageShape(std::initializer_list<int64_t> shape)
{
    tensor_.MutableStorageShape() = shape;
    return *this;
}

TensorBuilder &TensorBuilder::Format(ge::Format format)
{
    return OriginFormat(format).StorageFormat(format);
}

TensorBuilder &TensorBuilder::OriginFormat(ge::Format format)
{
    tensor_.MutableFormat().SetOriginFormat(format);
    return *this;
}

TensorBuilder &TensorBuilder::StorageFormat(ge::Format format)
{
    tensor_.MutableFormat().SetStorageFormat(format);
    return *this;
}

TensorBuilder &TensorBuilder::DataType(ge::DataType dt) {
    tensor_.SetDataType(dt);
    return *this;
}

TensorBuilder &TensorBuilder::Placement(TensorPlacement placement)
{
    tensor_.SetPlacement(placement);
    return *this;
}

TensorHolder TensorBuilder::Build() const
{
    TensorHolder th;
    if (tensor_.GetPlacement() == kFollowing) {
        size_t totalSize;
        th.SetFollowingTensor(Tensor::CreateFollowing(tensor_.GetStorageShape().GetShapeSize(), tensor_.GetDataType(), totalSize));
    } else {
        th.SetTensor(std::unique_ptr<Tensor>(new Tensor));
        auto tensorSize = ge::GetSizeInBytes(tensor_.GetStorageShape().GetShapeSize(), tensor_.GetDataType());

        TensorData td;
        td.SetAddr(StubHostTensorHead::Create(tensorSize), StubHostTensorManager);
        td.SetSize(tensorSize);
        td.SetPlacement(tensor_.GetPlacement());
        th.GetTensor()->SetData(std::move(td));
    }
    th.GetTensor()->MutableFormat() = tensor_.GetFormat();
    th.GetTensor()->MutableOriginShape() = tensor_.GetOriginShape();
    th.GetTensor()->MutableStorageShape() = tensor_.GetStorageShape();
    th.GetTensor()->SetDataType(tensor_.GetDataType());
    th.GetTensor()->SetPlacement(tensor_.GetPlacement());

    if (!tensorValue_.empty()) {
        memcpy(th.GetTensor()->GetAddr(), tensorValue_.data(), tensorValue_.size());
    }
    return th;
}
} // namespace gert