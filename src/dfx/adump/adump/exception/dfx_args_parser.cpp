/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <sstream>
#include "securec.h"
#include "dfx_args_parser.h"
#include "dump_memory.h"
#include "adump_platform_manager.h"
#include "log/adx_log.h"

namespace Adx {
uint64_t GetDFXInfoChunkCursor(uint8_t bufferId);

namespace {
constexpr uint32_t ATOMIC_INDEX_SIZE = 8;
constexpr uint32_t BUFFER_ID_SHIFT_BITS = 31;
constexpr uint64_t BUFFER_ID_MASK = 0x080000000;
constexpr uint64_t OFFSET_MASK = 0x0FFFFFF;
constexpr uint64_t MAGIC_NUM = 0xA5A5A5A500000000;
constexpr uint64_t MAGIC_NUM_MASK = 0xFFFFFFFF00000000;
constexpr uint64_t SPACE_MASK = 0x00000000FFFFFFFF;
constexpr uint32_t ARGS_PER_STRING_MAX_LEN = 20;

uint64_t ReadAtomicIndex(const uint8_t *data)
{
    uint64_t atomicIndex = 0;
    if (memcpy_s(&atomicIndex, sizeof(atomicIndex), data, sizeof(atomicIndex)) != EOK) {
        IDE_LOGE("Read atomicIndex failed, data=%p.", data);
        return 0U;
    }
    return atomicIndex;
}
}

DfxArgsParser::~DfxArgsParser()
{
    if (hostArgsData_ != nullptr) {
        DumpMemory::FreeHost(hostArgsData_);
        hostArgsData_ = nullptr;
    }
}

int32_t DfxArgsParser::Init(void *argAddr, uint64_t argSize, const uint8_t *dfxAddr, uint16_t dfxSize)
{
    IDE_CTRL_VALUE_FAILED(argAddr != nullptr && argSize != 0, return ADUMP_FAILED,
        "Invalid arg. argAddr=%p, argSize=%llu.", argAddr, argSize);
    IDE_CTRL_VALUE_FAILED(dfxAddr != nullptr && dfxSize != 0, return ADUMP_FAILED,
        "Invalid dfx. dfxAddr=%p, dfxSize=%u.", dfxAddr, dfxSize);

    argAddr_ = argAddr;
    argSize_ = argSize;

    hostArgsData_ = DumpMemory::CopyDeviceToHostEx(argAddr, argSize);
    IDE_CTRL_VALUE_FAILED(hostArgsData_ != nullptr, return ADUMP_FAILED,
        "Copy device args to host failed. argAddr=%p, argSize=%llu.", argAddr, argSize);

    argOnHost_ = static_cast<const void **>(hostArgsData_);
    maxArgNum_ = argSize / sizeof(uint64_t);

    dfxAddr_ = dfxAddr;
    dfxSize_ = dfxSize;
    currDfxSize_ = 0;

    LogArgsInfo();
    return ADUMP_SUCCESS;
}

void DfxArgsParser::LogArgsInfo()
{
    const uint32_t argsLogTimes = (maxArgNum_ % ARGS_PER_STRING_MAX_LEN > 0) ?
                                      ((maxArgNum_ / ARGS_PER_STRING_MAX_LEN) + 1) :
                                      (maxArgNum_ / ARGS_PER_STRING_MAX_LEN);
    for (uint32_t i = 1; i <= argsLogTimes; ++i) {
        std::stringstream ss;
        uint32_t endIndex = maxArgNum_ > (i * ARGS_PER_STRING_MAX_LEN) ? (i * ARGS_PER_STRING_MAX_LEN) : maxArgNum_;
        for (uint32_t j = (i - 1) * ARGS_PER_STRING_MAX_LEN; j < endIndex; ++j) {
            ss << *(argOnHost_ + j) << ", ";
        }
        RecordDumpLog(StrUtils::Format("[AIC_INFO] args(%u to %u) after execute:%s",
            (i - 1) * ARGS_PER_STRING_MAX_LEN, endIndex, ss.str().c_str()));
    }
    IDE_LOGE("[AIC_INFO] after execute:args print end");
}

void DfxArgsParser::RecordDumpLog(const std::string &log)
{
    IDE_LOGE("%s", log.c_str());
    logRecords_.emplace_back(log + "\n");
}

int32_t DfxArgsParser::GetAddressBias(uint64_t &addrBias, const void *argAddr, void *baseAddr, uint64_t argsSize)
{
    addrBias = reinterpret_cast<uint64_t>(argAddr) - reinterpret_cast<uint64_t>(baseAddr);
    if (addrBias >= argsSize) {
        IDE_LOGE("Address bias[%llu] >= argsSize[%llu], invalid.", addrBias, argsSize);
        return ADUMP_FAILED;
    }
    return ADUMP_SUCCESS;
}

int32_t DfxArgsParser::CheckAddressOverArgs(const uint64_t *address, const void **argOnHost, uint64_t maxArgNum)
{
    uint64_t *endArgAddr = reinterpret_cast<uint64_t *>(argOnHost + maxArgNum);
    if (address >= endArgAddr) {
        IDE_LOGE("Address[%p] >= endArgAddr[%p], over args range.", address, endArgAddr);
        return ADUMP_FAILED;
    }
    return ADUMP_SUCCESS;
}

int32_t DfxArgsParser::CheckShapeDataAddress() const
{
    if (shapeDataAddr_ == nullptr || shapeDataMaxAddr_ == nullptr) {
        IDE_LOGE("The shape data addr[%p] or max addr[%p] is nullptr.", shapeDataAddr_, shapeDataMaxAddr_);
        return ADUMP_FAILED;
    }
    if (shapeDataAddr_ >= shapeDataMaxAddr_) {
        IDE_LOGE("The shape data addr[%p] is over max addr[%p].", shapeDataAddr_, shapeDataMaxAddr_);
        return ADUMP_FAILED;
    }
    return ADUMP_SUCCESS;
}

bool DfxArgsParser::CheckMagicMemory(const uint8_t *address) const
{
    for (uint16_t i = 0; i < 4; ++i) {
        if (*(address + i) != 0xA5) {
            return false;
        }
    }
    return true;
}

const char* DfxArgsParser::GetTensorTypeName(DfxTensorType tensorType)
{
    switch (tensorType) {
        case DfxTensorType::INPUT_TENSOR: return "INPUT_TENSOR";
        case DfxTensorType::OUTPUT_TENSOR: return "OUTPUT_TENSOR";
        case DfxTensorType::WORKSPACE_TENSOR: return "WORKSPACE_TENSOR";
        case DfxTensorType::TILING_DATA: return "TILING_DATA";
        case DfxTensorType::MC2_CTX: return "MC2_CTX";
        case DfxTensorType::SHAPE_TENSOR: return "SHAPE_TENSOR";
        case DfxTensorType::GENERAL_TENSOR: return "GENERAL_TENSOR";
        default: return "UNKNOWN";
    }
}

const char* DfxArgsParser::GetPointerTypeName(DfxPointerType pointerType)
{
    switch (pointerType) {
        case DfxPointerType::LEVEL_1_POINTER: return "L1_POINTER";
        case DfxPointerType::LEVEL_2_POINTER: return "L2_POINTER";
        case DfxPointerType::LEVEL_2_POINTER_WITH_SHAPE: return "L2_POINTER_WITH_SHAPE";
        case DfxPointerType::SHAPE_TENSOR_PLACEHOLD: return "SHAPE_TENSOR_PLACEHOLD";
        default: return "INVALID_POINTER";
    }
}

int32_t DfxArgsParser::GetShapeData(uint64_t atomicIndex)
{
    uint8_t bufferId = static_cast<uint8_t>((atomicIndex & BUFFER_ID_MASK) >> BUFFER_ID_SHIFT_BITS);
    uint32_t offset = static_cast<uint32_t>(atomicIndex & OFFSET_MASK);
    uint32_t chunkSize = 0;
    uint64_t *chunkAddr = nullptr;
    if (bufferId == 0U) {
        chunkSize = DYNAMIC_RING_CHUNK_SIZE;
        chunkAddr = g_dynamicChunk;
    } else {
        chunkSize = STATIC_RING_CHUNK_SIZE;
        chunkAddr = g_staticChunk;
    }
    IDE_LOGI("Decode atomicIndex, atomicIndex=0x%llx, bufferId=%u, offset=%u, chunkAddr=%p, chunkSize=%u.",
        atomicIndex, bufferId, offset, chunkAddr, chunkSize);

    IDE_CTRL_VALUE_FAILED(chunkAddr != nullptr, return ADUMP_FAILED, "GetShapeData failed, the chunk memory is null.");
    IDE_CTRL_VALUE_FAILED(offset < chunkSize, return ADUMP_FAILED,
        "GetShapeData failed, offset is over chunk size, atomicIndex=0x%llx, bufferId=%u, offset=%u, chunkSize=%u.",
        atomicIndex, bufferId, offset, chunkSize);

    uint64_t magicAndSpace = chunkAddr[offset];
    uint64_t magicNum = magicAndSpace & MAGIC_NUM_MASK;
    uint32_t space = static_cast<uint32_t>(magicAndSpace & SPACE_MASK);
    IDE_LOGI("Parse chunk header, magicAndSpace=0x%llx, magicNum=0x%llx, space=%u.", magicAndSpace, magicNum, space);

    IDE_CTRL_VALUE_FAILED(magicNum == MAGIC_NUM, return ADUMP_FAILED,
        "GetShapeData failed, magic is invalid, atomicIndex=0x%llx, magicAndSpace=0x%llx, magic=0x%llx, "
        "magicMask=0x%llx.", atomicIndex, magicAndSpace, magicNum, MAGIC_NUM_MASK);
    IDE_CTRL_VALUE_FAILED(space <= DFX_MAX_TENSOR_NUM, return ADUMP_FAILED,
        "GetShapeData failed, space is over max, atomicIndex=0x%llx, magicAndSpace=0x%llx, space=%u, maxSpace=%u.",
        atomicIndex, magicAndSpace, space, DFX_MAX_TENSOR_NUM);

    uint64_t dumpAtomicIndex = chunkAddr[offset + 1];
    uint64_t chunkCursor = GetDFXInfoChunkCursor(bufferId);
    uint64_t chunkRound = chunkCursor / chunkSize;
    uint32_t chunkOffset = static_cast<uint32_t>(chunkCursor % chunkSize);
    IDE_CTRL_VALUE_FAILED(dumpAtomicIndex == atomicIndex, return ADUMP_FAILED,
        "GetShapeData failed, atomic index mismatch, atomicIndex=0x%llx, dumpAtomicIndex=0x%llx, chunkRound=%llu, "
        "chunkOffset=%u.", atomicIndex, dumpAtomicIndex, chunkRound, chunkOffset);

    shapeDataAddr_ = chunkAddr + offset + RESERVE_SPACE;
    shapeDataMaxAddr_ = shapeDataAddr_ + space;
    std::stringstream ss;
    for (uint32_t i = 0; i < space; i++) {
        ss << *(shapeDataAddr_ + i) << ", ";
    }
    IDE_LOGI("The shape item size: %s", ss.str().c_str());
    return ADUMP_SUCCESS;
}

bool DfxArgsParser::GetIsDataTypeSizeByte(bool &isDataTypeSizeByte) const
{
    auto *plat = ExceptionDumpManager::Get();
    if (plat == nullptr) {
        // 未注册平台沿用默认语义：视为非按字节并继续解析，保持与平台工厂化前一致
        isDataTypeSizeByte = false;
        return true;
    }
    isDataTypeSizeByte = plat->IsArgsDataTypeSizeByByte();
    return true;
}

int32_t DfxArgsParser::InitTensorModeInfoInner(uint32_t currArgsIndex, const uint8_t *&dfxAddr, uint64_t &currDfxSize)
{
    IDE_LOGI("Find tiling data, the mode is dynamic");
    dynamicModeFlag_ = true;

    uint64_t tilingDataSize = 0;
    int32_t ret = GetPointerValueByBigEndian(&dfxAddr, tilingDataSize, currDfxSize, dfxSize_);
    IDE_CHECK_RET(ret, return ADUMP_FAILED);

    if (tilingDataSize < ATOMIC_INDEX_SIZE) {
        IDE_LOGE("The tiling data size[%llu] is less than the min size[%u].", tilingDataSize, ATOMIC_INDEX_SIZE);
        return ADUMP_FAILED;
    }

    void *tilingDataAddr = DumpMemory::CopyDeviceToHostEx(argOnHost_[currArgsIndex], tilingDataSize);
    if (tilingDataAddr == nullptr) {
        IDE_LOGE("Copy device tiling to host failed.");
        return ADUMP_FAILED;
    }
    HOST_RT_MEMORY_GUARD(tilingDataAddr);

    auto addr = static_cast<uint8_t *>(tilingDataAddr);
    if (isTik_) {
        for (size_t i = 4; i <= tilingDataSize - 4; ++i) {
            if (!CheckMagicMemory(addr + i)) {
                continue;
            }
            uint64_t atomicIndex = ReadAtomicIndex(addr + i - 4);
            if (GetShapeData(atomicIndex) == ADUMP_SUCCESS) {
                return ADUMP_SUCCESS;
            }
        }
        IDE_LOGE("Can not find shape info. tiling data addr=%p, size=%llu", argOnHost_[currArgsIndex], tilingDataSize);
        return ADUMP_FAILED;
    } else {
        uint64_t atomicIndex = ReadAtomicIndex(addr + tilingDataSize - ATOMIC_INDEX_SIZE);
        ret = GetShapeData(atomicIndex);
        IDE_CTRL_VALUE_FAILED(ret == ADUMP_SUCCESS, return ADUMP_FAILED,
            "Can not find shape info. tiling data addr=%p, size=%llu", argOnHost_[currArgsIndex], tilingDataSize);
    }

    return ADUMP_SUCCESS;
}

int32_t DfxArgsParser::InitTensorModeInfo()
{
    uint64_t currDfxSize = 0;
    const uint8_t *dfxAddr = dfxAddr_;
    uint32_t currArgsIndex = 0;
    while (currDfxSize < dfxSize_) {
        std::stringstream exceptionDfxStr;
        for (size_t i = 0; i < (dfxSize_ - currDfxSize); ++i) {
            exceptionDfxStr << int32_t(*(dfxAddr + i)) << ", ";
        }
        IDE_LOGI("current arg index[%u], Tiling current exception dfx raw data:%s ", currArgsIndex,
                 exceptionDfxStr.str().c_str());

        if (currArgsIndex >= maxArgNum_) {
            IDE_LOGE("The current arg index[%u] is greater than the max arg number[%llu]",
                     currArgsIndex, maxArgNum_);
            return ADUMP_FAILED;
        }

        uint16_t argsInfoType = 0;
        int32_t ret = GetPointerValueByBigEndian(&dfxAddr, argsInfoType, currDfxSize, dfxSize_);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        uint16_t argsInfoNum = 0;
        ret = GetPointerValueByBigEndian(&dfxAddr, argsInfoNum, currDfxSize, dfxSize_);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        if (argsInfoNum == 0) {
            IDE_LOGE("The dfx args info num[%u] is invalid.", argsInfoNum);
            return ADUMP_FAILED;
        }

        if (argsInfoType == TYPE_L0_EXCEPTION_DFX_ARGS_INFO) {
            uint64_t typeInfo = 0;
            ret = GetPointerValueByBigEndian(&dfxAddr, typeInfo, currDfxSize, dfxSize_);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
            DfxTensorType tensorType = static_cast<DfxTensorType>(typeInfo & TENSOR_TYPE_MASK);
            if (tensorType == DfxTensorType::TILING_DATA) {
                ret = InitTensorModeInfoInner(currArgsIndex, dfxAddr, currDfxSize);
                return ret;
            }
            currDfxSize += sizeof(uint64_t) * (argsInfoNum - 1);
            dfxAddr += sizeof(uint64_t) * (argsInfoNum - 1);
            ++currArgsIndex;
        } else {
            currDfxSize += sizeof(uint64_t) * argsInfoNum;
            dfxAddr += sizeof(uint64_t) * argsInfoNum;
        }
        IDE_LOGI("Current dfx total size is %llu", currDfxSize);
    }

    if (currDfxSize > dfxSize_) {
        IDE_LOGE("The dfx info size[%llu] is over the max size[%u].", currDfxSize, dfxSize_);
        return ADUMP_FAILED;
    }

    return ADUMP_SUCCESS;
}

int32_t DfxArgsParser::LoadDfxL1PtrTensor(TensorBuffer &tensor)
{
    int32_t ret = ADUMP_SUCCESS;
    if (dynamicModeFlag_) {
        dfxAddr_ += sizeof(uint64_t);
        currDfxSize_ += sizeof(uint64_t);
        ret = CheckShapeDataAddress();
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        tensor.size = *shapeDataAddr_;
        shapeDataAddr_++;
        tensors_.push_back(tensor);
        IDE_LOGE("[Dump][Exception] tensor type:%u(%s), pointer type:%u(%s)",
                 static_cast<uint16_t>(tensor.tensorType), GetTensorTypeName(tensor.tensorType),
                 static_cast<uint16_t>(tensor.pointerType), GetPointerTypeName(tensor.pointerType));
        RecordDumpLog(StrUtils::Format("[Dump][Exception] exception info dump args data, addr:%p; size:%llu bytes",
            tensor.addr, tensor.size));
    } else {
        uint64_t size = 0;
        ret = GetPointerValueByBigEndian(&dfxAddr_, size, currDfxSize_, dfxSize_);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        IDE_LOGI("Tensor size[%llu].", size);
        tensor.size = size;

        uint64_t dimension = 0;
        ret = GetPointerValueByBigEndian(&dfxAddr_, dimension, currDfxSize_, dfxSize_);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        IDE_LOGI("Tensor dimension[%llu].", dimension);
        tensor.dimension = dimension;

        for (uint64_t i = 0; i < dimension; ++i) {
            uint64_t shape = 0;
            ret = GetPointerValueByBigEndian(&dfxAddr_, shape, currDfxSize_, dfxSize_);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
            IDE_LOGI("Tensor shape[%llu].", shape);
            tensor.shape.push_back(shape);
        }

        tensors_.push_back(tensor);
        IDE_LOGE("[Dump][Exception] tensor type:%u(%s), pointer type:%u(%s)",
                 static_cast<uint16_t>(tensor.tensorType), GetTensorTypeName(tensor.tensorType),
                 static_cast<uint16_t>(tensor.pointerType), GetPointerTypeName(tensor.pointerType));
        RecordDumpLog(StrUtils::Format("[Dump][Exception] exception info dump args data, addr:%p; size:%llu bytes",
            tensor.addr, tensor.size));
    }

    return ADUMP_SUCCESS;
}

int32_t DfxArgsParser::LoadDfxL2ShapePtrTensor(TensorBuffer &tensor)
{
    uint64_t addrBias = 0;
    int32_t ret = GetAddressBias(addrBias, tensor.addr, argAddr_, argSize_);
    IDE_CHECK_RET(ret, return ADUMP_FAILED);

    uint64_t *dynamicTensorAddr = reinterpret_cast<uint64_t *>(addrBias + reinterpret_cast<uint64_t>(argOnHost_));
    ret = CheckAddressOverArgs(dynamicTensorAddr, argOnHost_, maxArgNum_);
    IDE_CHECK_RET(ret, return ADUMP_FAILED);

    uint64_t offset = *dynamicTensorAddr;
    dynamicTensorAddr++;

    void **tensorAddr = reinterpret_cast<void **>(reinterpret_cast<uint64_t>(argOnHost_) + addrBias + offset);
    uint64_t shapeInfoCount = (offset - sizeof(uint64_t)) / sizeof(uint64_t);
    ret = LoadTensorShapeAndSize(tensor, dynamicTensorAddr, tensorAddr, shapeInfoCount);
    IDE_CHECK_RET(ret, return ADUMP_FAILED);
    shapeDataAddr_++;

    return ADUMP_SUCCESS;
}

int32_t DfxArgsParser::LoadTensorShapeAndSize(TensorBuffer &tensor, uint64_t *dynamicTensorAddr,
                                               void **tensorAddr, uint64_t shapeInfoCount)
{
    int32_t ret = ADUMP_SUCCESS;
    uint64_t currShapeCount = 0;
    while (currShapeCount < shapeInfoCount) {
        ret = CheckAddressOverArgs(dynamicTensorAddr, argOnHost_, maxArgNum_);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        uint64_t dimAndCnt = *dynamicTensorAddr;
        if (dimAndCnt == 0) {
            IDE_LOGI("The tensor dimension and count are 0, which is an empty address.");
            break;
        }
        uint32_t tensorDim = static_cast<uint32_t>(dimAndCnt & TENSOR_DIMENSION_MASK);
        uint32_t tensorCount = static_cast<uint32_t>((dimAndCnt & TENSOR_COUNT_MASK) >> TENSOR_COUNT_SHIFT_BITS);
        tensor.dimension = tensorDim;
        IDE_LOGI("The tensor dimension[%u], count[%u].", tensorDim, tensorCount);
        dynamicTensorAddr++;
        currShapeCount++;
        uint64_t size = 1;
        std::vector<uint64_t> tmpShapeVec;
        for (uint32_t i = 0; i < tensorDim; ++i) {
            ret = CheckAddressOverArgs(dynamicTensorAddr, argOnHost_, maxArgNum_);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
            size *= *dynamicTensorAddr;
            IDE_LOGI("The tensor shape[%llu].", *dynamicTensorAddr);
            tmpShapeVec.push_back(*dynamicTensorAddr);
            dynamicTensorAddr++;
            currShapeCount++;
        }
        tensor.shape = tmpShapeVec;
        tensor.size = size;

        const void **endArgAddr = argOnHost_ + maxArgNum_;
        for (uint32_t i = 0; i < tensorCount; ++i) {
            if (tensorAddr >= endArgAddr) {
                IDE_LOGE("Args address[%p] is over args end address[%p].", tensorAddr, endArgAddr);
                return ADUMP_FAILED;
            }
            tensor.addr = *tensorAddr;
            tensors_.push_back(tensor);
            RecordDumpLog(StrUtils::Format("[Dump][Exception] exception info dump args data, addr:%p; size:%llu bytes",
                *tensorAddr, tensor.GetTotalByteSize()));
            tensorAddr++;
        }
    }

    return ADUMP_SUCCESS;
}

int32_t DfxArgsParser::LoadDfxTensor(TensorBuffer &tensor, uint16_t argsInfoNum)
{
    int32_t ret = ADUMP_SUCCESS;
    RecordDumpLog(StrUtils::Format(
        "[Dump][Exception] begin to load normal tensor, index:%u, tensor type:%u(%s), pointer type:%u(%s)",
        tensor.argIndex, static_cast<uint16_t>(tensor.tensorType), GetTensorTypeName(tensor.tensorType),
        static_cast<uint16_t>(tensor.pointerType), GetPointerTypeName(tensor.pointerType)));
    if (tensor.pointerType == DfxPointerType::LEVEL_2_POINTER_WITH_SHAPE) {
        dfxAddr_ += sizeof(uint64_t);
        currDfxSize_ += sizeof(uint64_t);
        uint64_t dataTypeSize = 0;
        ret = GetPointerValueByBigEndian(&dfxAddr_, dataTypeSize, currDfxSize_, dfxSize_);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        IDE_LOGI("The tensor datatype size[%llu].", dataTypeSize);
        IDE_CTRL_VALUE_FAILED(GetIsDataTypeSizeByte(tensor.isDataTypeSizeByte), return ADUMP_FAILED,
            "Load data type size unit failed.");
        tensor.dataTypeSize = dataTypeSize;
        ret = LoadDfxL2ShapePtrTensor(tensor);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
    } else if (tensor.pointerType == DfxPointerType::LEVEL_1_POINTER ||
               tensor.pointerType == DfxPointerType::SHAPE_TENSOR_PLACEHOLD) {
        ret = LoadDfxL1PtrTensor(tensor);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
    } else {
        dfxAddr_ += sizeof(uint64_t) * (argsInfoNum - 1);
        currDfxSize_ += sizeof(uint64_t) * (argsInfoNum - 1);
        tensor.size = 0;
    }
    RecordDumpLog(StrUtils::Format("[Dump][Exception] end to load normal tensor, index:%u", tensor.argIndex));
    return ADUMP_SUCCESS;
}

int32_t DfxArgsParser::LoadDfxWorkspace(TensorBuffer &tensor)
{
    RecordDumpLog(StrUtils::Format("[Dump][Exception] begin to load workspace, index:%u", tensor.argIndex));
    
    DumpWorkspace workspace;
    workspace.addr = tensor.addr;
    workspace.argsOffset = tensor.argIndex;
    
    if (dynamicModeFlag_) {
        int32_t ret = CheckShapeDataAddress();
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        workspace.bytes = *shapeDataAddr_;
        shapeDataAddr_++;
    } else {
        uint64_t size = 0;
        int32_t ret = GetPointerValueByBigEndian(&dfxAddr_, size, currDfxSize_, dfxSize_);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        IDE_LOGI("Workspace size[%llu].", size);
        workspace.bytes = size;
    }

    workspaces_.push_back(workspace);
    RecordDumpLog(StrUtils::Format("[Dump][Exception] exception info dump workspace data, addr:%p; size:%llu bytes",
        workspace.addr, workspace.bytes));
    RecordDumpLog(StrUtils::Format("[Dump][Exception] end to load workspace, index:%u", tensor.argIndex));

    return ADUMP_SUCCESS;
}

int32_t DfxArgsParser::LoadDfxTilingData(TensorBuffer &tensor)
{
    RecordDumpLog(StrUtils::Format("[Dump][Exception] begin to load tiling data, index:%u", tensor.argIndex));
    uint64_t tilingDataSize = 0;
    int32_t ret = GetPointerValueByBigEndian(&dfxAddr_, tilingDataSize, currDfxSize_, dfxSize_);
    IDE_CHECK_RET(ret, return ADUMP_FAILED);
    IDE_LOGI("The tiling data size=%llu.", tilingDataSize);
    tensor.size = tilingDataSize;

    // TBE算子无法区分tensor和workspace，当前GE框架无法识别TBE算子，
    // 对workspace不会添加dim和shape信息，解析到shape地址越界报错时，忽略错误
    (void)LoadDfxShapeData();
    tensors_.push_back(tensor);
    RecordDumpLog(StrUtils::Format("[Dump][Exception] exception info dump tiling data, addr:%p; size:%llu bytes",
        tensor.addr, tilingDataSize));
    RecordDumpLog(StrUtils::Format("[Dump][Exception] end to load tiling data, index:%u", tensor.argIndex));
    return ADUMP_SUCCESS;
}

int32_t DfxArgsParser::LoadDfxShapeData()
{
    int32_t ret = ADUMP_SUCCESS;
    size_t tensorBufferSize = tensors_.size();
    IDE_LOGI("The tensor buffer size=%llu.", tensorBufferSize);
    for (size_t i = 0; i < tensorBufferSize; ++i) {
        DfxPointerType localPointerType = tensors_[i].pointerType;
        if ((localPointerType == DfxPointerType::LEVEL_1_POINTER) && tensors_[i].size != 0 &&
            tensors_[i].tensorType != DfxTensorType::SHAPE_TENSOR) {
            ret = CheckShapeDataAddress();
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
            uint64_t tensorDim = *shapeDataAddr_;
            IDE_LOGI("The tensor dimension[%llu].", tensorDim);
            tensors_[i].dimension = tensorDim;
            shapeDataAddr_++;
            for (uint64_t dim = 0; dim < tensorDim; ++dim) {
                ret = CheckShapeDataAddress();
                IDE_CHECK_RET(ret, {
                    tensors_[i].dimension = 0;
                    return ADUMP_FAILED;
                });
                IDE_LOGI("The tensor shape[%llu].", *shapeDataAddr_);
                tensors_[i].shape.push_back(*shapeDataAddr_);
                shapeDataAddr_++;
            }
        }
    }

    return ret;
}

void DfxArgsParser::LoadDfxMc2(const TensorBuffer &tensor)
{
    RecordDumpLog(StrUtils::Format("[Dump][Exception] begin to load mc2, index:%u", tensor.argIndex));
    DumpWorkspace workspace;
    workspace.addr = tensor.addr;
    workspace.argsOffset = tensor.argIndex;
    workspace.bytes = 0;
    mc2Space_.push_back(workspace);
    shapeDataAddr_++;
    RecordDumpLog(StrUtils::Format("[Dump][Exception] exception info dump mc2 data, addr:%p; size:%llu bytes",
        workspace.addr, workspace.bytes));
    RecordDumpLog(StrUtils::Format("[Dump][Exception] end to load mc2, index:%u", tensor.argIndex));
}

int32_t DfxArgsParser::LoadDfxInfo(uint32_t &currArgsIndex)
{
    uint16_t argsInfoType = 0;
    int32_t ret = GetPointerValueByBigEndian(&dfxAddr_, argsInfoType, currDfxSize_, dfxSize_);
    IDE_CHECK_RET(ret, return ADUMP_FAILED);
    uint16_t argsInfoNum = 0;
    ret = GetPointerValueByBigEndian(&dfxAddr_, argsInfoNum, currDfxSize_, dfxSize_);
    IDE_CHECK_RET(ret, return ADUMP_FAILED);
    IDE_LOGI("The arg info type: %u, info num:%u", argsInfoType, argsInfoNum);
    IDE_CTRL_VALUE_FAILED(argsInfoNum != 0, return ADUMP_FAILED,
        "The dfx args info num[%u] is invalid.", argsInfoNum);

    if (argsInfoType == TYPE_L0_EXCEPTION_DFX_ARGS_INFO) {
        uint64_t typeInfo = 0;
        ret = GetPointerValueByBigEndian(&dfxAddr_, typeInfo, currDfxSize_, dfxSize_);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        DfxTensorType tensorType = static_cast<DfxTensorType>(typeInfo & TENSOR_TYPE_MASK);
        DfxPointerType pointerType =
            static_cast<DfxPointerType>((typeInfo & POINTER_TYPE_MASK) >> POINTER_TYPE_SHIFT_BITS);
        IDE_LOGI("The arg type info: %llu, tensor type: %u(%s), pointer type: %u(%s)", typeInfo,
                 static_cast<uint16_t>(tensorType), GetTensorTypeName(tensorType),
                 static_cast<uint16_t>(pointerType), GetPointerTypeName(pointerType));

        TensorBuffer tensor(argOnHost_[currArgsIndex], currArgsIndex, tensorType, pointerType);
        if ((tensorType <= DfxTensorType::OUTPUT_TENSOR && tensorType > DfxTensorType::INVALID_TENSOR) ||
            tensorType == DfxTensorType::SHAPE_TENSOR) {
            ret = LoadDfxTensor(tensor, argsInfoNum);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
        } else if (tensorType == DfxTensorType::WORKSPACE_TENSOR) {
            ret = LoadDfxWorkspace(tensor);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
        } else if (tensorType == DfxTensorType::TILING_DATA) {
            ret = LoadDfxTilingData(tensor);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
        } else if (tensorType == DfxTensorType::MC2_CTX) {
            LoadDfxMc2(tensor);
        } else {
            IDE_LOGE("[Dump][Exception] args dump dfx info, addr:%p, tensor type:%u, pointer type:%u, index: %u",
                     argOnHost_[currArgsIndex], static_cast<uint16_t>(tensorType), static_cast<uint16_t>(pointerType),
                     currArgsIndex);
            dfxAddr_ += sizeof(uint64_t) * (argsInfoNum - 1);
            currDfxSize_ += sizeof(uint64_t) * (argsInfoNum - 1);
        }
        ++currArgsIndex;
    } else {
        IDE_LOGW("The dfx args info type[%u] is not allowed", argsInfoType);
        dfxAddr_ += sizeof(uint64_t) * argsInfoNum;
        currDfxSize_ += sizeof(uint64_t) * argsInfoNum;
    }

    return ADUMP_SUCCESS;
}

int32_t DfxArgsParser::ParseAll()
{
    uint32_t currArgsIndex = 0;
    while (currDfxSize_ < dfxSize_) {
        std::stringstream exceptionDfxStr;
        for (size_t i = 0; i < (dfxSize_ - currDfxSize_); ++i) {
            exceptionDfxStr << int32_t(*(dfxAddr_ + i)) << ", ";
        }
        IDE_LOGI("Current exception dfx raw data:%s ", exceptionDfxStr.str().c_str());

        if (currArgsIndex >= maxArgNum_) {
            IDE_LOGE("The current arg index[%u] is greater than the max arg number[%llu]",
                     currArgsIndex, maxArgNum_);
            return ADUMP_FAILED;
        }

        int32_t ret = LoadDfxInfo(currArgsIndex);
        if (ret != ADUMP_SUCCESS) {
            return ret;
        }
    }

    return ADUMP_SUCCESS;
}

} // namespace Adx
