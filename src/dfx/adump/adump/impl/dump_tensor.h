/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DUMP_TENSOR_H
#define DUMP_TENSOR_H

#include "adump_pub.h"

namespace Adx {
class DumpTensor {
public:
    DumpTensor(const TensorInfoV2 &tensorInfo);
    ~DumpTensor() = default;
    int32_t GetDataType() const;
    int32_t GetFormat() const;
    std::vector<int64_t> GetShape() const;
    std::vector<int64_t> GetOriginShape() const;
    size_t GetSize() const;
    const void *GetAddress() const;
    void SetAddress(const void *address);
    AddressType GetAddressType() const;
    uint32_t GetArgsOffSet() const;

private:
    int32_t dataType_;
    int32_t format_;
    std::vector<int64_t> shape_;
    std::vector<int64_t> originShape_;
    size_t size_;
    const void *address_;
    AddressType addrType_;
    uint32_t argsOffSet_;
};
} // namespace Adx
#endif // DUMP_TENSOR_H