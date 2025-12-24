/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef OP_API_OP_API_COMMON_INC_OPDEV_OP_DEF_H_
#define OP_API_OP_API_COMMON_INC_OPDEV_OP_DEF_H_

#include <string>
#include <unordered_map>
#include <utility>
#include <vector>
#include "aclnn/aclnn_base.h"
#include "fast_vector.h"
#include "graph/ascend_string.h"

namespace op {

enum CoreType { AI_CORE = 0, AI_CPU, DVPP, NO_CALC };

enum OpIOType {
    OpInputType,
    OpOutputType,
    OpWorkspaceType
};

enum class OpImplMode : uint32_t {
    // ImplMode support OR operation
    IMPL_MODE_DEFAULT = 0x1,
    IMPL_MODE_HIGH_PERFORMANCE = 0x2,
    IMPL_MODE_HIGH_PRECISION = 0x4,
    IMPL_MODE_SUPER_PERFORMANCE = 0x8,
    IMPL_MODE_SUPPORT_OUT_OF_BOUND_INDEX = 0x10,
    IMPL_MODE_ENABLE_FLOAT32_EXECUTION = 0x20,
    IMPL_MODE_ENABLE_HI_FLOAT32_EXECUTION = 0x40,
    IMPL_MODE_KEEP_FP16 = 0x80,
    IMPL_MODE_RESERVED = 0xFFFFFFFF
};

enum class OpExecMode : uint32_t {
    // ImplMode support OR operation
    OP_EXEC_MODE_DEFAULT = 0,
    OP_EXEC_MODE_HF32 = 1,
    OP_EXEC_MODE_RESERVED = 0xFFFFFFFF
};

struct OpTypeDict {
    static aclnnStatus Add(uint32_t &id, const char *opName);
    static uint32_t ToOpType(const std::string &opName);
    static const ge::AscendString ToString(uint32_t opType);
    static size_t GetAllOpTypeSize();
    static std::vector<ge::AscendString> &opTypeName_;
    static std::unordered_map<std::string, uint32_t> &opTypeName2Id_;
};

struct BinConfigJsonDict {
    static uint32_t ToOpTypeByConfigJson(const std::string &op_config_json);
    static void UpdateConfigJsonPath(uint32_t opType, const std::string &opFile);
    static std::vector<std::vector<std::string>> opConfigJsonPath_;
    static std::unordered_map<std::string, uint32_t> opConfigJsonPath2Id_;
    static uint32_t transDataId_;
};

constexpr int MAX_DEV_NUM = 64;
constexpr const char *JSON_SUFFIX = ".json";
constexpr const char *BIN_SUFFIX = ".o";
constexpr const uint32_t INVALID_OP_TYPE_ID = 0xFFFFFFFF;

std::vector<std::string> GetOpConfigJsonFileName(uint32_t opType);
aclnnStatus ReadFile2String(const char *filename, std::string &content);
aclnnStatus ReadDirBySuffix(const std::string &dir, const std::string &suffix, std::vector<std::string> &paths);

OpImplMode ToOpImplMode(const std::string &implModeStr);
ge::AscendString ToString(OpImplMode implMode);
const ge::AscendString &ImplModeToString(OpImplMode implMode);
int64_t ToIndex(OpImplMode implMode);
wchar_t ToIndexChar(OpImplMode implMode);
} // namespace op

#endif // OP_API_OP_API_COMMON_INC_OPDEV_OP_DEF_H_
