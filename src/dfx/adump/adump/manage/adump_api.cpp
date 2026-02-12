/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <atomic>
#include "adump_pub.h"
#include "adump_api.h"
#include "dump_manager.h"
#include "dump_printf.h"

namespace Adx {
namespace {
std::atomic<uint64_t> g_dynamicWriteIdx{0};
std::atomic<uint64_t> g_staticWriteIdx{0};

constexpr uint64_t MAGIC_NUM = 0xA5A5A5A500000000;
constexpr uint64_t FLIP_NUM_MASK = 0b01111111;
constexpr uint16_t FLIP_NUM_SHIFT_BITS = 24;
constexpr uint64_t STATIC_BUFFER_ID = 0x080000000;
}  // namespace

void *AdumpGetDFXInfoAddrForDynamic(uint32_t space, uint64_t &atomicIndex)
{
    if (space > DFX_MAX_TENSOR_NUM || g_dynamicChunk == nullptr) {
        return nullptr;
    }

    auto nextWriteCursor = g_dynamicWriteIdx.fetch_add(space + RESERVE_SPACE);
    uint64_t flipNum = nextWriteCursor / DYNAMIC_RING_CHUNK_SIZE;
    uint64_t offset = nextWriteCursor % DYNAMIC_RING_CHUNK_SIZE;
    atomicIndex = MAGIC_NUM | ((flipNum & FLIP_NUM_MASK) << FLIP_NUM_SHIFT_BITS) | offset;
    g_dynamicChunk[offset] = MAGIC_NUM | space;
    g_dynamicChunk[offset + 1] = atomicIndex;
    return g_dynamicChunk + offset + RESERVE_SPACE;
}

void *AdumpGetDFXInfoAddrForStatic(uint32_t space, uint64_t &atomicIndex)
{
    if (space > DFX_MAX_TENSOR_NUM || g_staticChunk == nullptr) {
        return nullptr;
    }

    auto nextWriteCursor = g_staticWriteIdx.fetch_add(space + RESERVE_SPACE);
    uint64_t flipNum = nextWriteCursor / STATIC_RING_CHUNK_SIZE;
    uint64_t offset = nextWriteCursor % STATIC_RING_CHUNK_SIZE;
    atomicIndex = MAGIC_NUM | STATIC_BUFFER_ID | ((flipNum & FLIP_NUM_MASK) << FLIP_NUM_SHIFT_BITS) | offset;
    g_staticChunk[offset] = MAGIC_NUM | space;
    g_staticChunk[offset + 1] = atomicIndex;
    return g_staticChunk + offset + RESERVE_SPACE;
}

uint64_t AdumpGetDumpSwitch(const DumpType dumpType)
{
    bool isEnable = DumpManager::Instance().IsEnableDump(dumpType);
    if (dumpType == DumpType::OPERATOR && isEnable) {
        return DumpManager::Instance().AdumpGetDumpSwitch();
    }
    return isEnable;
}

bool AdumpIsDumpEnable(DumpType dumpType)
{
    return DumpManager::Instance().IsEnableDump(dumpType);
}

bool AdumpIsDumpEnable(DumpType dumpType, uint64_t &dumpSwitch)
{
    dumpSwitch = DumpManager::Instance().AdumpGetDumpSwitch();
    return DumpManager::Instance().IsEnableDump(dumpType);
}

int32_t AdumpSetDumpConfig(DumpType dumpType, const DumpConfig &dumpConfig)
{
    return DumpManager::Instance().SetDumpConfig(dumpType, dumpConfig);
}

int32_t AdumpSetDump(const char *dumpConfigData, size_t dumpConfigSize)
{
    return DumpManager::Instance().SetDumpConfig(dumpConfigData, dumpConfigSize);
}

int32_t AdumpUnSetDump()
{
    return DumpManager::Instance().UnSetDumpConfig();
}

int32_t AdumpDumpTensor(const std::string &opType, const std::string &opName, const std::vector<TensorInfo> &tensors,
                        aclrtStream stream)
{
    return DumpManager::Instance().DumpOperator(opType, opName, tensors, stream);
}

int32_t AdumpDumpTensorV2(const std::string &opType, const std::string &opName, const std::vector<TensorInfoV2> &tensors,
                        aclrtStream stream)
{
    return DumpManager::Instance().DumpOperatorV2(opType, opName, tensors, stream);
}

int32_t AdumpAddExceptionOperatorInfo(const OperatorInfo &opInfo)
{
    DumpManager::Instance().AddExceptionOp(opInfo);
    return ADUMP_SUCCESS;
}

int32_t AdumpAddExceptionOperatorInfoV2(const OperatorInfoV2 &opInfo)
{
    DumpManager::Instance().AddExceptionOpV2(opInfo);
    return ADUMP_SUCCESS;
}

int32_t AdumpDelExceptionOperatorInfo(uint32_t deviceId, uint32_t streamId)
{
    return DumpManager::Instance().DelExceptionOp(deviceId, streamId);
}

void AdumpPrintWorkSpace(const void *workSpaceAddr, const size_t dumpWorkSpaceSize, aclrtStream stream,
                         const char *opType)
{
    AdxPrintWorkSpace(workSpaceAddr, dumpWorkSpaceSize, stream, opType, true);
}

void AdumpPrintWorkSpace(const void *workSpaceAddr, const size_t dumpWorkSpaceSize, aclrtStream stream,
                         const char *opType, bool enableSync)
{
    AdxPrintWorkSpace(workSpaceAddr, dumpWorkSpaceSize, stream, opType, enableSync);
}

void AdumpPrintAndGetTimeStampInfo(const void *workSpaceAddr, const size_t dumpWorkSpaceSize, aclrtStream stream,
    const char *opType, std::vector<MsprofAicTimeStampInfo> &timeStampInfo)
{
    AdxPrintTimeStamp(workSpaceAddr, dumpWorkSpaceSize, stream, opType, timeStampInfo);
}

void AdumpPrintSetConfig(const AdumpPrintConfig &config)
{
    AdxPrintSetConfig(config);
}

#ifndef __ADUMP_LLT
static void __attribute__((constructor)) AdumpInit(void)
{
    (void)DumpManager::Instance();
}
#endif
}  // namespace Adx