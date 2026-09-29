/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_THREAD_AICPU_DATA_DUMP_TLV_HPP
#define RUNTIME_THREAD_AICPU_DATA_DUMP_TLV_HPP

#include <cstdint>

namespace cce {
namespace runtime_thread_aicpu {
namespace datadump {
namespace tlv {

constexpr uint32_t DATA_VERSION = 0U;
constexpr uint32_t DATA_MAGIC = 0x5A5A5A5AU;

enum class Level1Type : uint32_t {
    MODEL_NAME = 0U,
    OP_DESC = 1U,
    MODEL_DESC = 2U,
    DUMP_PATH = 3U,
};

enum class Level2Type : uint32_t {
    OP_NAME = 0U,
    OP_TYPE = 1U,
    ORIGINAL_OP_NAME = 2U,
    L1_SUB_GRAPH_NO = 3U,
    INPUT_DESC = 4U,
    OUTPUT_DESC = 5U,
    WORKSPACE_DESC = 6U,
    OP_BUFFER = 7U,
    MEMORY_INFO = 8U,
};

enum class TensorLevel3Type : uint32_t {
    SHAPE = 0U,
    ORIGINAL_SHAPE = 1U,
    ORIGINAL_NAME = 2U,
};

#pragma pack(push, 1)

struct DataHeader {
    uint32_t version;
    uint32_t magic;
};

struct TlvHeader {
    uint32_t type;
    uint32_t length;
};

struct ListPrefix {
    uint32_t count;
};

struct OpDescPrefix {
    uint32_t taskId;
    uint32_t streamId;
    uint32_t logicStreamId;
    int32_t taskType;
    uint32_t blockDim;
    uint8_t isMultiOp;
    uint32_t nestedLength;
};

struct ModelDescPrefix {
    uint32_t action;
    uint32_t modelId;
    uint64_t stepIdAddress;
    uint64_t iterationsPerLoopAddress;
    uint64_t loopCondAddress;
    uint32_t dumpMode;
    uint64_t dumpData;
    uint32_t nestedLength;
};

struct InputDescPrefix {
    int32_t dataType;
    int32_t format;
    int32_t addressType;
    uint64_t address;
    uint64_t offset;
    uint64_t size;
    uint32_t nestedLength;
};

struct OutputDescPrefix {
    int32_t dataType;
    int32_t format;
    int32_t addressType;
    int32_t originalIndex;
    int32_t originalDataType;
    int32_t originalFormat;
    uint64_t address;
    uint64_t offset;
    uint64_t size;
    uint32_t nestedLength;
};

struct WorkspaceDescPrefix {
    int32_t type;
    uint64_t dataAddress;
    uint64_t size;
    uint32_t nestedLength;
};

struct OpBufferPrefix {
    uint8_t type;
    uint64_t address;
    uint64_t size;
    uint32_t nestedLength;
};

struct MemoryInfoPrefix {
    uint64_t inputSize;
    uint64_t outputSize;
    uint64_t weightSize;
    uint64_t workspaceSize;
    uint64_t totalSize;
    uint32_t nestedLength;
};

#pragma pack(pop)

static_assert(sizeof(DataHeader) == 8U, "DataDump data header layout changed");
static_assert(sizeof(TlvHeader) == 8U, "DataDump TLV header layout changed");
static_assert(sizeof(ListPrefix) == 4U, "DataDump list prefix layout changed");
static_assert(sizeof(OpDescPrefix) == 25U, "DataDump op prefix layout changed");
static_assert(sizeof(ModelDescPrefix) == 48U, "DataDump model prefix layout changed");
static_assert(sizeof(InputDescPrefix) == 40U, "DataDump input prefix layout changed");
static_assert(sizeof(OutputDescPrefix) == 52U, "DataDump output prefix layout changed");
static_assert(sizeof(WorkspaceDescPrefix) == 24U, "DataDump workspace prefix layout changed");
static_assert(sizeof(OpBufferPrefix) == 21U, "DataDump op buffer prefix layout changed");
static_assert(sizeof(MemoryInfoPrefix) == 44U, "DataDump memory info prefix layout changed");

} // namespace tlv
} // namespace datadump
} // namespace runtime_thread_aicpu
} // namespace cce

#endif
