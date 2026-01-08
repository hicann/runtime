/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CPU_KERNELS_CONTEXT_H
#define CPU_KERNELS_CONTEXT_H
#include <string>
#include <unordered_map>
#include <vector>

#include "cpu_types.h"
#include "cpu_tensor.h"
#include "cpu_attr_value.h"

namespace aicpu {
class Device;
class NodeDef;
class AICPU_VISIBILITY CpuKernelContext {
    friend class CpuKernelUtils;
    friend class CustCpuKernelUtils;
    friend class CustCpuKernelDlogUtils;
public:
    explicit CpuKernelContext(DeviceType type);
    CpuKernelContext() = delete;
    ~CpuKernelContext() = default;
    CpuKernelContext(const CpuKernelContext &) = delete;
    CpuKernelContext(CpuKernelContext &&) = delete;
    CpuKernelContext &operator = (const CpuKernelContext &) = delete;
    CpuKernelContext &operator = (CpuKernelContext &&) = delete;

    uint32_t Init(NodeDef *nodeDef);

    // format aicpuops::NodeDef *nodeDef
    uint32_t Init(void *nodeDef);

    /*
     * get op type.
     * @return string: op type
     */
    std::string GetOpType() const;

    /*
     * get input tensor.
     * @return Tensor *: not null->success, null->failed
     */
    Tensor *Input(uint32_t index) const;

    /*
     * get output tensor.
     * @return Tensor *: not null->success, null->failed
     */
    Tensor *Output(uint32_t index) const;

    /*
     * get attr.
     * @return AttrValue *: not null->success, null->failed
     */
    AttrValue *GetAttr(std::string name) const;

    /*
     * get input size.
     * @return uint32_t: input size
     */
    uint32_t GetInputsSize() const;

    /*
     * get output size.
     * @return uint32_t: output size
     */
    uint32_t GetOutputsSize() const;

private:
    std::string op_;                                           // op type
    std::vector<std::shared_ptr<Tensor> > inputs_;             // input tensor list
    std::vector<std::shared_ptr<Tensor> > outputs_;            // out tensor list
    std::unordered_map<std::string, std::shared_ptr<AttrValue> > attrs_; // attr list
    std::shared_ptr<Device> device_ { nullptr };
    uint64_t workspace_size_{0UL};
    uint64_t workspace_addr_{0UL};
};
} // namespace aicpu
#endif // CPU_KERNELS_CONTEXT_H
