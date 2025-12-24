/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dump_tensor.h"
#include "log/hdc_log.h"

namespace Adx {
DumpTensor::DumpTensor(const TensorInfoV2 &tensorInfo)
    : dataType_(tensorInfo.dataType),
      format_(tensorInfo.format),
      shape_(tensorInfo.shape),
      originShape_(tensorInfo.originShape),
      size_(tensorInfo.tensorSize),
      address_(tensorInfo.tensorAddr),
      addrType_(tensorInfo.addrType),
      argsOffSet_(tensorInfo.argsOffSet)
{};

int32_t DumpTensor::GetDataType() const
{
    return dataType_;
}

int32_t DumpTensor::GetFormat() const
{
    return format_;
}

std::vector<int64_t> DumpTensor::GetShape() const
{
    return shape_;
}

std::vector<int64_t> DumpTensor::GetOriginShape() const
{
    return originShape_;
}

size_t DumpTensor::GetSize() const
{
    return size_;
}

const void *DumpTensor::GetAddress() const
{
    return address_;
}

void DumpTensor::SetAddress(const void *address)
{
    address_ = address;
}

AddressType DumpTensor::GetAddressType() const
{
    return addrType_;
}

uint32_t DumpTensor::GetArgsOffSet() const
{
    return argsOffSet_;
}
} // namespace Adx