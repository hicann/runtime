/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */


#ifndef __OP_CTX_DEF_H__
#define __OP_CTX_DEF_H__
#include <cstddef>
#include <sstream>
#include <vector>

#include "exe_graph/runtime/continuous_vector.h"
#include "opdev/common_types.h"
#include "opdev/op_def.h"

// Structs blow are from GE RT2.0. Must keep sync with GE.
namespace op::internal {

using AttrPtr = void *;
struct ComputeNodeInfo {
    const ge::char_t *node_type_;
    const ge::char_t *node_name_;
    size_t ir_inputs_num_;
    size_t inputs_num_;
    size_t outputs_num_;
    size_t ir_outputs_num_;
    size_t attr_size_;
    uint8_t reserved_[24]; // Reserved field, 32+8, do not directly use when only 8-byte left
    // following by input-AnchorInstanceInfo, inputs-outputs-CompileTimeTensorDesc, RuntimeAttrs,
    // output-AnchorInstanceInfo
    uint64_t place_holder;

    /*
    AnchorInstanceInfo[ir_inputs_num_]
    CompileTimeTensorDesc[inputs_num_ + outputs_num_]
    RuntimeAttrsDef
    */
};

struct AnchorInstanceInfo {
    uint32_t instance_start_;
    uint32_t instantiation_num_;
    uint8_t reserved_[40];
};

struct CompileTimeTensorDesc {
    DataType data_type_;
    gert::StorageFormat storage_format_;
    uint8_t reserved_[40];
};

struct RuntimeAttrsDef {
    size_t attr_num;
    uint8_t reserved_[40]; // Reserved field, 32+8, do not directly use when only 8-byte left
    size_t offset[0];
};

struct KernelExtendInfo {
    const ge::char_t *kernel_name_;
    const ge::char_t *kernel_type_;
};

struct TilingData {
    size_t capacity_;
    size_t data_size_;
    void *data_;
    uint8_t reserved_[40];
};

// Tiling output
struct TilingCtxOutput {
    uint64_t *tilingKey_;
    int64_t *blockDim_;
    bool *atomicCleanFlag_;
    TilingData *tilingData_;
    gert::TypedContinuousVector<size_t> *workspaceSize_;
    int64_t *tilingCond_;
    uint8_t *scheduleMode_;
    uint32_t *localMemorySize_;

    size_t inputNum_;
    size_t outputNum_;
};

constexpr size_t MAX_WORKSPACE_NUM = 64;            // max number of op workspace
constexpr size_t LAUNCH_ARG_SIZE = 128 * 1024;        // kernel launch arg size before tiling data
constexpr size_t MAX_TILING_DATA_SIZE = 800 * 1024; // max raw tiling data size

constexpr size_t MAX_ATTR_STRING_SIZE = 1024; // max op attr string length
constexpr size_t ATTR_CAPACITY = 32 * 1024;   // max total op attr data size in Bytes
constexpr size_t MAX_OP_ARG_NUM = 1024;        // max op input/output arg count
constexpr size_t MAX_OP_TYPE_COUNT = 512;  // max registed op type

} // namespace op::internal

#endif
