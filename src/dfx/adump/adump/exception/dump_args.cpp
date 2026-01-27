/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dump_args.h"
#include <cinttypes>
#include "path.h"
#include "dump_file.h"
#include "sys_utils.h"
#include "dump_memory.h"
#include "log/hdc_log.h"
#include "exception_info_common.h"
#include "dump_tensor_plugin.h"
#include "adump_dsmi.h"
#include "log/adx_log.h"
#include <set>

namespace Adx {
namespace {
constexpr uint32_t ATOMIC_AND_INPUT_NUM_OFFSET = 2;     // 2 - atomic index | input num(or total context size num)
constexpr uint32_t CONTEXTID_AND_INPUT_NUM_OFFSET = 2;  // 2 - context id | input num
constexpr uint32_t SKIP_NUM_SHIFT_BITS = 32;
constexpr uint64_t SKIP_NUM_MASK = 0x0FFFFFFFF00000000;   // high 32 bits
constexpr uint64_t INPUT_NUM_MASK = 0x0FFFFFFFF;          // low 32 bits
constexpr uint64_t SIZE_TYPE_MASK = 0x0FF00000000000000;  // high 8 bits
constexpr uint64_t SIZE_MASK = 0x0FFFFFFFFFFFFFF;         // low 56 bits
constexpr uint32_t SIZE_TYPE_SHIFT_BITS = 56;
constexpr uint8_t NORMAL_TENSOR = 0;
constexpr uint8_t NORMAL_PTR_TENSOR = 1;
constexpr uint8_t SHAPE_PTR_TENSOR = 2;
constexpr uint8_t TILING_DATA_PTR = 3;
constexpr uint8_t WORKSPACE_TENSOR = 4;
constexpr uint32_t ARGS_PER_STRING_MAX_LEN = 20;
constexpr uint32_t BUFFER_ID_SHIFT_BITS = 31;
constexpr uint64_t BUFFER_ID_MASK = 0x080000000;  // 32nd bit
constexpr uint64_t OFFSET_MASK = 0x0FFFFFF;       // low 24 bits
constexpr uint64_t MAGIC_NUM = 0xA5A5A5A500000000;
constexpr uint64_t MAGIC_NUM_MASK = 0xFFFFFFFF00000000;  // high 32 bits
constexpr uint64_t SPACE_MASK = 0x00000000FFFFFFFF;      // low 32 bits
constexpr uint64_t ATOMIC_INDEX_SIZE = 8;
}  // namespace

template <typename T>
int32_t DumpArgs::GetPointerValueByBigEndian(const uint8_t **ptr, T &value, uint64_t &currentDfxSize,
                                             uint16_t totalDfxSize) const
{
    uint16_t bitOfByte = 8;
    for (size_t i = 0; i < sizeof(T); ++i) {
        if (currentDfxSize >= totalDfxSize) {
            IDE_LOGE("The dfx data size[%" PRIu64 "] is larger than the total dfx size[%" PRIu16 "].", currentDfxSize,
                     totalDfxSize);
            return ADUMP_FAILED;
        }
        value = (value) | (static_cast<uint64_t>(**ptr) << ((sizeof(T) - i - 1) * bitOfByte));
        currentDfxSize++;
        (*ptr)++;
    }

    return ADUMP_SUCCESS;
}

template <typename T>
int32_t DumpArgs::GetPointerValueByLittleEndian(const uint8_t **ptr, T &value, uint64_t &currentDfxSize,
                                                uint16_t totalDfxSize) const
{
    uint16_t bitOfByte = 8;
    for (size_t i = 0; i < sizeof(T); ++i) {
        if (currentDfxSize >= totalDfxSize) {
            IDE_LOGE("The dfx data size[%" PRIu64 "] is larger than the total dfx size[%" PRIu16 "].", currentDfxSize,
                     totalDfxSize);
            return ADUMP_FAILED;
        }
        value = (value) | (static_cast<uint64_t>(**ptr) << (i * bitOfByte));
        currentDfxSize++;
        (*ptr)++;
    }

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::GetAddressBias(uint64_t &addrBias, const void *argAddr, void *baseAddr, uint64_t argsSize) const
{
    addrBias = reinterpret_cast<uint64_t>(argAddr) - reinterpret_cast<uint64_t>(baseAddr);
    if (addrBias >= argsSize) {
        IDE_LOGE("Address bias[%p - %p] is over args size[%" PRIu64 "], invalid.", argAddr, baseAddr, argsSize);
        return ADUMP_FAILED;
    }

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::CheckAddressOverArgs(const uint64_t *address, const void **argOnHost, uint64_t maxArgNum) const
{
    uint64_t *endArgAddr = reinterpret_cast<uint64_t *>(argOnHost + maxArgNum);
    if (address >= endArgAddr) {
        IDE_LOGE("Args address[%p] is over args end address[%p].", address, endArgAddr);
        return ADUMP_FAILED;
    }

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::CheckShapeDataAddress() const
{
    if (shapeDataAddr_ >= shapeDataMaxAddr_) {
        IDE_LOGE("The shape data address[%p] is over the max address[%p].", shapeDataAddr_, shapeDataMaxAddr_);
        return ADUMP_FAILED;
    }

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::GetShapeData(uint64_t atomicIndex)
{
    IDE_LOGI("The atomicIndex is %" PRIu64, atomicIndex);
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
    if (chunkAddr == nullptr) {
        IDE_LOGE("The chunk memory is nullptr.");
        return ADUMP_FAILED;
    }
    if (offset >= chunkSize) {
        IDE_LOGE("The offset[%" PRIu32 "] is over the max offset[%" PRIu32 "].", offset, chunkSize);
        return ADUMP_FAILED;
    }

    uint64_t magicAndSpace = chunkAddr[offset];
    uint64_t magicNum = magicAndSpace & MAGIC_NUM_MASK;
    uint32_t space = static_cast<uint32_t>(magicAndSpace & SPACE_MASK);
    IDE_LOGI("The space is %" PRIu32, space);
    if (magicNum != MAGIC_NUM) {
        IDE_LOGE("The magic number is invalid, magic number:%" PRIu64, magicNum);
        return ADUMP_FAILED;
    }
    if (space > DFX_MAX_TENSOR_NUM) {
        IDE_LOGE("The space[%" PRIu32 "] is over the max space[%" PRIu32 "].", space, DFX_MAX_TENSOR_NUM);
        return ADUMP_FAILED;
    }

    uint64_t dumpAtomicIndex = chunkAddr[offset + 1];
    if (dumpAtomicIndex != atomicIndex) {
        IDE_LOGE("The atomic index:%" PRIu64 " is not equal %" PRIu64, atomicIndex, dumpAtomicIndex);
        return ADUMP_FAILED;
    }

    shapeDataAddr_ = chunkAddr + offset + RESERVE_SPACE;
    shapeDataMaxAddr_ = shapeDataAddr_ + space;
    std::stringstream ss;
    for (uint32_t i = 0; i < space; i++) {
        ss << *(shapeDataAddr_ + i) << ", ";
    }
    IDE_LOGI("The shape item size: %s", ss.str().c_str());
    return ADUMP_SUCCESS;
}

bool DumpArgs::CheckMagicMemory(const uint8_t *address) const
{
    for (uint16_t i = 0; i < 4; ++i) {  // verify that 4 consecutive bytes are 0xA5
        if (*(address + i) != 0xA5) {
            return false;
        }
    }

    return true;
}

int32_t DumpArgs::InitTensorModeInfoInner(const uint8_t *exceptionDfxPtr, uint64_t &currDfxSize, uint32_t currArgsIndex)
{
    IDE_LOGI("Find tiling data, the mode is dynamic");
    dynamicModeFlag_ = true;

    uint64_t tilingDataSize = 0;
    int32_t ret = GetPointerValueByBigEndian(&exceptionDfxPtr, tilingDataSize, currDfxSize, exceptionDfxSize_);
    IDE_CHECK_RET(ret, return ADUMP_FAILED);

    if (tilingDataSize < ATOMIC_INDEX_SIZE) {
        IDE_LOGE("The tiling data size[%" PRIu64 "] is less than the min size[" PRIu64 "].", tilingDataSize,
                 ATOMIC_INDEX_SIZE);
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
        for (size_t i = 4; i <= tilingDataSize - 4; ++i) {  // 4 -- reserve for atomicIndex 4 bytes
            if (!CheckMagicMemory(addr + i)) {
                continue;
            }
            uint64_t atomicIndex = *reinterpret_cast<uint64_t *>(addr + i - 4);  // 4 -- atomicIndex low 4 bytes
            if (GetShapeData(atomicIndex) == ADUMP_SUCCESS) {
                return ADUMP_SUCCESS;
            }
        }
        IDE_LOGE("Can not find shape info.");
        return ADUMP_FAILED;
    } else {
        uint64_t atomicIndex = *reinterpret_cast<uint64_t *>(addr + tilingDataSize - ATOMIC_INDEX_SIZE);
        ret = GetShapeData(atomicIndex);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
    }

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::InitTensorModeInfo(const uint8_t *exceptionDfxPtr)
{
    uint64_t currDfxSize = 0;
    uint32_t currArgsIndex = 0;
    while (currDfxSize < exceptionDfxSize_) {
        std::stringstream exceptionDfxStr;
        for (size_t i = 0; i < (exceptionDfxSize_ - currDfxSize); ++i) {
            exceptionDfxStr << int32_t(*(exceptionDfxPtr + i)) << ", ";
        }
        IDE_LOGI("current arg index[%" PRIu32 "], Tiling current exception dfx raw data:%s ", currArgsIndex,
                 exceptionDfxStr.str().c_str());

        if (currArgsIndex >= maxArgNum_) {
            IDE_LOGE("The current arg index[%" PRIu32 "] is greater than the max arg number[%" PRIu64 "]",
                     currArgsIndex, maxArgNum_);
            return ADUMP_FAILED;
        }

        uint16_t argsInfoType = 0;
        int32_t ret = GetPointerValueByBigEndian(&exceptionDfxPtr, argsInfoType, currDfxSize, exceptionDfxSize_);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        uint16_t argsInfoNum = 0;
        ret = GetPointerValueByBigEndian(&exceptionDfxPtr, argsInfoNum, currDfxSize, exceptionDfxSize_);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        if (argsInfoNum == 0) {
            IDE_LOGE("The dfx args info num[%" PRIu16 "] is invalid.", argsInfoNum);
            return ADUMP_FAILED;
        }

        if (argsInfoType == TYPE_L0_EXCEPTION_DFX_ARGS_INFO) {
            uint64_t typeInfo = 0;
            ret = GetPointerValueByBigEndian(&exceptionDfxPtr, typeInfo, currDfxSize, exceptionDfxSize_);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
            DfxTensorType tensorType = static_cast<DfxTensorType>(typeInfo & TENSOR_TYPE_MASK);
            if (tensorType == DfxTensorType::TILING_DATA) {
                ret = InitTensorModeInfoInner(exceptionDfxPtr, currDfxSize, currArgsIndex);
                return ret;
            }
            currDfxSize += sizeof(uint64_t) * (argsInfoNum - 1);
            exceptionDfxPtr += sizeof(uint64_t) * (argsInfoNum - 1);
            ++currArgsIndex;
        } else {
            currDfxSize += sizeof(uint64_t) * argsInfoNum;
            exceptionDfxPtr += sizeof(uint64_t) * argsInfoNum;
        }
        IDE_LOGI("Current dfx total size is %" PRIu64, currDfxSize);
    }

    if (currDfxSize > exceptionDfxSize_) {
        IDE_LOGE("The dfx info size[%" PRIu64 "] is over the max size[%" PRIu16 "].", currDfxSize, exceptionDfxSize_);
        return ADUMP_FAILED;
    }

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::FindExceptionDfx(const rtExceptionArgsInfo_t &exceptionArgsInfo)
{
    const uint8_t *metaDfxPtr = static_cast<const uint8_t *>(exceptionArgsInfo.exceptionKernelInfo.dfxAddr);
    uint16_t metaDfxSize = exceptionArgsInfo.exceptionKernelInfo.dfxSize;
    std::stringstream metaDfxStr;
    for (uint16_t i = 0; i < metaDfxSize; ++i) {
        metaDfxStr << int32_t(*(metaDfxPtr + i)) << ", ";
    }
    IDE_LOGI("The meta dfx raw data:%s ", metaDfxStr.str().c_str());

    uint64_t currDfxSize = 0;
    while (currDfxSize < metaDfxSize) {
        uint16_t dfxType = 0;
        uint16_t dfxLength = 0;
        int32_t ret = ADUMP_SUCCESS;
        if (exceptionArgsInfo.exceptionKernelInfo.elfDataFlag == ELF_DATA2MSB) {
            ret = GetPointerValueByBigEndian(&metaDfxPtr, dfxType, currDfxSize, metaDfxSize);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
            ret = GetPointerValueByBigEndian(&metaDfxPtr, dfxLength, currDfxSize, metaDfxSize);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
        } else {
            ret = GetPointerValueByLittleEndian(&metaDfxPtr, dfxType, currDfxSize, metaDfxSize);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
            ret = GetPointerValueByLittleEndian(&metaDfxPtr, dfxLength, currDfxSize, metaDfxSize);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
        }
        IDE_LOGI("The dfx type[%" PRIu16 "], dfx length[%" PRIu16 "]", dfxType, dfxLength);
        if (dfxType == TYPE_L0_EXCEPTION_DFX) {
            exceptionDfxPtr_ = metaDfxPtr;
            exceptionDfxSize_ = dfxLength;
        }

        if (dfxType == TYPE_L0_EXCEPTION_DFX_IS_TIK) {
            uint32_t isTik = 0;
            if (exceptionArgsInfo.exceptionKernelInfo.elfDataFlag == ELF_DATA2MSB) {
                ret = GetPointerValueByBigEndian(&metaDfxPtr, isTik, currDfxSize, metaDfxSize);
            } else {
                ret = GetPointerValueByLittleEndian(&metaDfxPtr, isTik, currDfxSize, metaDfxSize);
            }
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
            isTik_ = (isTik == 1U) ? true : false;
        } else {
            metaDfxPtr += dfxLength;
            currDfxSize += dfxLength;
        }
    }

    if (exceptionDfxPtr_ == nullptr || exceptionDfxSize_ == 0) {
        IDE_LOGE("No exception dfx info, dfxAddr[%p]|dfxSize[%" PRIu16 "].", exceptionDfxPtr_, exceptionDfxSize_);
        return ADUMP_FAILED;
    }

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::LoadTensorShapeAndSize(TensorBuffer &tensorBuffer, uint64_t *dynamicTensorAddr, void **tensorAddr,
                                         uint64_t shapeInfoCount)
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
        tensorBuffer.dimension = tensorDim;
        IDE_LOGI("The tensor dimension[%u], count[%u].", tensorDim, tensorCount);
        dynamicTensorAddr++;
        currShapeCount++;
        uint64_t size = 1;
        std::vector<uint64_t> tmpShapeVec;
        for (uint32_t i = 0; i < tensorDim; ++i) {
            ret = CheckAddressOverArgs(dynamicTensorAddr, argOnHost_, maxArgNum_);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
            size *= *dynamicTensorAddr;
            IDE_LOGI("The tensor shape[%" PRIu64 "].", *dynamicTensorAddr);
            tmpShapeVec.push_back(*dynamicTensorAddr);
            dynamicTensorAddr++;
            currShapeCount++;
        }
        tensorBuffer.shape = tmpShapeVec;
        tensorBuffer.size = size;

        const void **endArgAddr = argOnHost_ + maxArgNum_;
        for (uint32_t i = 0; i < tensorCount; ++i) {
            if (tensorAddr >= endArgAddr) {
                IDE_LOGE("Args address[%p] is over args end address[%p].", tensorAddr, endArgAddr);
                return ADUMP_FAILED;
            }
            tensorBuffer.addr = *tensorAddr;
            tensorBuffer_.push_back(tensorBuffer);
            oss_ << "[Dump][Exception] exception info dump args data, addr:" << *tensorAddr
                 << "; size:" << tensorBuffer.GetTotalByteSize() << " bytes";
            RecordCurrentLog();
            tensorAddr++;
        }
    }

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::LoadDfxL2ShapePtrTensor(TensorBuffer &tensorBuffer)
{
    uint64_t addrBias = 0;
    int32_t ret = GetAddressBias(addrBias, tensorBuffer.addr, argAddr_, argSize_);
    IDE_CHECK_RET(ret, return ADUMP_FAILED);
    uint64_t *dynamicTensorAddr = reinterpret_cast<uint64_t *>(addrBias + reinterpret_cast<uint64_t>(argOnHost_));
    ret = CheckAddressOverArgs(dynamicTensorAddr, argOnHost_, maxArgNum_);
    IDE_CHECK_RET(ret, return ADUMP_FAILED);
    uint64_t offset = *dynamicTensorAddr;
    dynamicTensorAddr++;
    void **tensorAddr = reinterpret_cast<void **>(reinterpret_cast<uint64_t>(argOnHost_) + addrBias + offset);
    uint64_t shapeInfoCount = (offset - sizeof(uint64_t)) / sizeof(uint64_t);
    ret = LoadTensorShapeAndSize(tensorBuffer, dynamicTensorAddr, tensorAddr, shapeInfoCount);
    IDE_CHECK_RET(ret, return ADUMP_FAILED);
    shapeDataAddr_++;

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::LoadDfxL1PtrTensor(TensorBuffer &tensorBuffer, uint64_t &currExceptionDfxSize)
{
    int32_t ret = ADUMP_SUCCESS;
    if (dynamicModeFlag_) {
        exceptionDfxPtr_ += sizeof(uint64_t);
        currExceptionDfxSize += sizeof(uint64_t);
        ret = CheckShapeDataAddress();
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        tensorBuffer.size = *shapeDataAddr_;
        shapeDataAddr_++;
        tensorBuffer_.push_back(tensorBuffer);
        IDE_LOGE("[Dump][Exception] tensor type:%" PRIu16 ", pointer type:%" PRIu16,
                 static_cast<uint16_t>(tensorBuffer.tensorType), static_cast<uint16_t>(tensorBuffer.pointerType));
        oss_ << "[Dump][Exception] exception info dump args data, addr:" << tensorBuffer.addr
             << "; size:" << tensorBuffer.size << " bytes";
        RecordCurrentLog();
    } else {
        uint64_t size = 0;
        ret = GetPointerValueByBigEndian(&exceptionDfxPtr_, size, currExceptionDfxSize, exceptionDfxSize_);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        IDE_LOGI("The tensor size[%" PRIu64 "].", size);
        tensorBuffer.size = size;
        uint64_t dimension = 0;
        ret = GetPointerValueByBigEndian(&exceptionDfxPtr_, dimension, currExceptionDfxSize, exceptionDfxSize_);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        IDE_LOGI("The tensor dimension[%" PRIu64 "].", dimension);
        tensorBuffer.dimension = dimension;
        for (uint64_t i = 0; i < dimension; ++i) {
            uint64_t shape = 0;
            ret = GetPointerValueByBigEndian(&exceptionDfxPtr_, shape, currExceptionDfxSize, exceptionDfxSize_);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
            IDE_LOGI("The tensor shape[%" PRIu64 "].", shape);
            tensorBuffer.shape.push_back(shape);
        }
        tensorBuffer_.push_back(tensorBuffer);
        IDE_LOGE("[Dump][Exception] tensor type:%" PRIu16 ", pointer type:%" PRIu16,
                 static_cast<uint16_t>(tensorBuffer.tensorType), static_cast<uint16_t>(tensorBuffer.pointerType));
        oss_ << "[Dump][Exception] exception info dump args data, addr:" << tensorBuffer.addr
             << "; size:" << tensorBuffer.size << " bytes";
        RecordCurrentLog();
    }

    return ADUMP_SUCCESS;
}

bool DumpArgs::GetIsDataTypeSizeByte(bool &isDataTypeSizeByte) const
{
    static const std::set<PlatformType> platforms = {PlatformType::CHIP_CLOUD_V2, PlatformType::CHIP_DC_TYPE};
    uint32_t platformType = 0;
    IDE_CTRL_VALUE_FAILED(AdumpDsmi::DrvGetPlatformType(platformType), return false, "Get platform type failed.");
    auto it = platforms.find(static_cast<PlatformType>(platformType));
    // david以前支持dfx的芯片上，二级指针的datatype size单位是byte；david后可能会新增小于1byte的datatype，因此该字段单位改为bit
    isDataTypeSizeByte = it != platforms.end() ? true: false;
    return true;
}

int32_t DumpArgs::LoadDfxTensor(TensorBuffer &tensorBuffer, uint64_t &currExceptionDfxSize, uint16_t argsInfoNum)
{
    int32_t ret = ADUMP_SUCCESS;
    if (tensorBuffer.pointerType == DfxPointerType::LEVEL_2_POINTER_WITH_SHAPE) {
        exceptionDfxPtr_ += sizeof(uint64_t);
        currExceptionDfxSize += sizeof(uint64_t);
        uint64_t dataTypeSize = 0;
        ret = GetPointerValueByBigEndian(&exceptionDfxPtr_, dataTypeSize, currExceptionDfxSize, exceptionDfxSize_);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        IDE_LOGI("The tensor datatype size[%" PRIu64 "].", dataTypeSize);
        IDE_CTRL_VALUE_FAILED(GetIsDataTypeSizeByte(tensorBuffer.isDataTypeSizeByte), return ADUMP_FAILED,
                              "Load data type size unit failed.");
        tensorBuffer.dataTypeSize = dataTypeSize;
        const void *shapeTensorAddr = tensorBuffer.addr;
        oss_ << "[Dump][Exception] begin to load shape pointer tensor, index:" << tensorBuffer.argIndex
             << ", addr:" << shapeTensorAddr;
        RecordCurrentLog();
        ret = LoadDfxL2ShapePtrTensor(tensorBuffer);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        oss_ << "[Dump][Exception] end to load shape pointer tensor, index:" << tensorBuffer.argIndex
             << ", addr:" << shapeTensorAddr;
        RecordCurrentLog();
    } else if (tensorBuffer.pointerType == DfxPointerType::LEVEL_1_POINTER ||
               tensorBuffer.pointerType == DfxPointerType::SHAPE_TENSOR_PLACEHOLD) {
        oss_ << "[Dump][Exception] begin to load normal tensor, index:" << tensorBuffer.argIndex;
        RecordCurrentLog();
        ret = LoadDfxL1PtrTensor(tensorBuffer, currExceptionDfxSize);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        oss_ << "[Dump][Exception] end to load normal tensor, index:" << tensorBuffer.argIndex;
        RecordCurrentLog();
    } else {
        exceptionDfxPtr_ += sizeof(uint64_t) * (argsInfoNum - 1);
        currExceptionDfxSize += sizeof(uint64_t) * (argsInfoNum - 1);
        oss_ << "[Dump][Exception] begin to load normal pointer tensor, index:" << tensorBuffer.argIndex
             << ", addr:" << tensorBuffer.addr;
        RecordCurrentLog();
        oss_ << "[Dump][Exception] end to load normal pointer tensor, index:" << tensorBuffer.argIndex
             << ", addr:" << tensorBuffer.addr;
        RecordCurrentLog();
    }

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::LoadDfxWorkspace(const TensorBuffer &tensorBuffer, uint64_t &currExceptionDfxSize)
{
    int32_t ret = ADUMP_SUCCESS;
    DumpWorkspace workspace;
    workspace.addr = tensorBuffer.addr;
    workspace.argsOffset = tensorBuffer.argIndex;
    IDE_LOGE("[Dump][Exception] begin to load workspace, index:%" PRIu32, tensorBuffer.argIndex);
    if (dynamicModeFlag_) {
        ret = CheckShapeDataAddress();
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        workspace.bytes = *shapeDataAddr_;
        shapeDataAddr_++;
        oss_ << "[Dump][Exception] exception info dump args data, addr:" << tensorBuffer.addr
             << "; size:" << workspace.bytes << " bytes";
        RecordCurrentLog();
    } else {
        uint64_t size = 0;
        ret = GetPointerValueByBigEndian(&exceptionDfxPtr_, size, currExceptionDfxSize, exceptionDfxSize_);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        IDE_LOGI("The tensor size[%" PRIu64 "].", size);
        workspace.bytes = size;
        oss_ << "[Dump][Exception] exception info dump args data, addr:" << tensorBuffer.addr << "; size:" << size
             << " bytes";
        RecordCurrentLog();
    }
    workspace_.push_back(workspace);
    IDE_LOGE("[Dump][Exception] end to load workspace, index:%" PRIu32, tensorBuffer.argIndex);

    return ADUMP_SUCCESS;
}

void DumpArgs::LoadDfxMc2(const TensorBuffer &tensorBuffer)
{
    IDE_LOGE("[Dump][Exception] begin to load mc2, index:%" PRIu32, tensorBuffer.argIndex);
    DumpWorkspace workspace;
    workspace.addr = tensorBuffer.addr;
    workspace.argsOffset = tensorBuffer.argIndex;
    workspace.bytes = 0;
    mc2Space_.push_back(workspace);
    shapeDataAddr_++;
    oss_ << "[Dump][Exception] exception info dump mc2 data, addr:" << workspace.addr
            << "; size:" << workspace.bytes << " bytes";
    RecordCurrentLog();
    IDE_LOGE("[Dump][Exception] end to load mc2, index:%" PRIu32, tensorBuffer.argIndex);
}

int32_t DumpArgs::LoadDfxShapeData()
{
    int32_t ret = ADUMP_SUCCESS;
    size_t tensorBufferSize = tensorBuffer_.size();
    IDE_LOGI("The tensor buffer size[%" PRIu64 "].", tensorBufferSize);
    for (size_t i = 0; i < tensorBufferSize; ++i) {
        DfxPointerType localPointerType = tensorBuffer_[i].pointerType;
        if ((localPointerType == DfxPointerType::LEVEL_1_POINTER) && tensorBuffer_[i].size != 0 &&
            tensorBuffer_[i].tensorType != DfxTensorType::SHAPE_TENSOR) {
            ret = CheckShapeDataAddress();
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
            uint64_t tensorDim = *shapeDataAddr_;
            IDE_LOGI("The tensor dimension[%" PRIu64 "].", tensorDim);
            tensorBuffer_[i].dimension = tensorDim;
            shapeDataAddr_++;
            for (uint64_t dim = 0; dim < tensorDim; ++dim) {
                ret = CheckShapeDataAddress();
                IDE_CHECK_RET(ret, {
                    tensorBuffer_[i].dimension = 0;
                    return ADUMP_FAILED;
                });
                IDE_LOGI("The tensor shape[%" PRIu64 "].", *shapeDataAddr_);
                tensorBuffer_[i].shape.push_back(*shapeDataAddr_);
                shapeDataAddr_++;
            }
        }
    }

    return ret;
}

int32_t DumpArgs::LoadDfxTilingData(TensorBuffer &tensorBuffer, uint64_t &currExceptionDfxSize)
{
    IDE_LOGE("[Dump][Exception] begin to load tiling data, index:%" PRIu32, tensorBuffer.argIndex);
    uint64_t tilingDataSize = 0;
    int32_t ret =
        GetPointerValueByBigEndian(&exceptionDfxPtr_, tilingDataSize, currExceptionDfxSize, exceptionDfxSize_);
    IDE_CHECK_RET(ret, return ADUMP_FAILED);
    IDE_LOGI("The tiling data size[%" PRIu64 "].", tilingDataSize);
    tensorBuffer.size = tilingDataSize;

    // TBE算子无法区分tensor和workspace，当前GE框架无法识别TBE算子，对workspace不会添加dim和shape信息，解析到shape地址越界报错时，忽略错误
    (void)LoadDfxShapeData();
    tensorBuffer_.push_back(tensorBuffer);
    oss_ << "[Dump][Exception] exception info dump args data, addr:" << tensorBuffer.addr << "; size:" << tilingDataSize
         << " bytes";
    RecordCurrentLog();
    IDE_LOGE("[Dump][Exception] end to load tiling data, index:%" PRIu32, tensorBuffer.argIndex);
    return ADUMP_SUCCESS;
}

int32_t DumpArgs::LoadDfxInfo(uint64_t &currExceptionDfxSize, uint32_t &currArgsIndex)
{
    uint16_t argsInfoType = 0;
    int32_t ret = GetPointerValueByBigEndian(&exceptionDfxPtr_, argsInfoType, currExceptionDfxSize, exceptionDfxSize_);
    IDE_CHECK_RET(ret, return ADUMP_FAILED);
    uint16_t argsInfoNum = 0;
    ret = GetPointerValueByBigEndian(&exceptionDfxPtr_, argsInfoNum, currExceptionDfxSize, exceptionDfxSize_);
    IDE_CHECK_RET(ret, return ADUMP_FAILED);
    IDE_LOGI("The arg info type: %" PRIu16 ", info num:%" PRIu16, argsInfoType, argsInfoNum);
    if (argsInfoNum == 0) {
        IDE_LOGE("The dfx args info num[%" PRIu16 "] is invalid.", argsInfoNum);
        return ADUMP_FAILED;
    }

    if (argsInfoType == TYPE_L0_EXCEPTION_DFX_ARGS_INFO) {
        uint64_t typeInfo = 0;
        ret = GetPointerValueByBigEndian(&exceptionDfxPtr_, typeInfo, currExceptionDfxSize, exceptionDfxSize_);
        IDE_CHECK_RET(ret, return ADUMP_FAILED);
        DfxTensorType tensorType = static_cast<DfxTensorType>(typeInfo & TENSOR_TYPE_MASK);
        DfxPointerType pointerType =
            static_cast<DfxPointerType>((typeInfo & POINTER_TYPE_MASK) >> POINTER_TYPE_SHIFT_BITS);
        IDE_LOGI("The arg type info: %" PRIu64 ", tensor type: %" PRIu16 " , pointer type: %" PRIu16, typeInfo,
                 static_cast<uint16_t>(tensorType), static_cast<uint16_t>(pointerType));

        TensorBuffer tensorBuffer(argOnHost_[currArgsIndex], currArgsIndex, tensorType, pointerType);
        if ((tensorType <= DfxTensorType::OUTPUT_TENSOR && tensorType > DfxTensorType::INVALID_TENSOR) ||
            tensorType == DfxTensorType::SHAPE_TENSOR) {
            ret = LoadDfxTensor(tensorBuffer, currExceptionDfxSize, argsInfoNum);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
        } else if (tensorType == DfxTensorType::WORKSPACE_TENSOR) {
            ret = LoadDfxWorkspace(tensorBuffer, currExceptionDfxSize);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
        } else if (tensorType == DfxTensorType::TILING_DATA) {
            ret = LoadDfxTilingData(tensorBuffer, currExceptionDfxSize);
            IDE_CHECK_RET(ret, return ADUMP_FAILED);
        } else if (tensorType == DfxTensorType::MC2_CTX) {
            LoadDfxMc2(tensorBuffer);
        } else {
            IDE_LOGE("[Dump][Exception] args dump dfx info, addr:%p, tensor type:%" PRIu16 ", pointer type:%" PRIu16
                     ", index: %" PRIu32,
                     argOnHost_[currArgsIndex], static_cast<uint16_t>(tensorType), static_cast<uint16_t>(pointerType),
                     currArgsIndex);
            exceptionDfxPtr_ += sizeof(uint64_t) * (argsInfoNum - 1);
            currExceptionDfxSize += sizeof(uint64_t) * (argsInfoNum - 1);
        }
        ++currArgsIndex;
    } else {
        IDE_LOGW("The dfx args info type[%" PRIu16 "] is not allowed, except the type[%" PRIu16 "]", argsInfoType,
                 TYPE_L0_EXCEPTION_DFX_ARGS_INFO);
        exceptionDfxPtr_ += sizeof(uint64_t) * argsInfoNum;
        currExceptionDfxSize += sizeof(uint64_t) * argsInfoNum;
    }

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::LoadArgsInfoWithDfx(const rtExceptionArgsInfo_t &exceptionArgsInfo)
{
    // Except the aic/aiv error, other exceptions are also called back. Therefore, warning logs are generated here.
    if (exceptionArgsInfo.argAddr == nullptr || exceptionArgsInfo.argsize == 0 ||
        exceptionArgsInfo.exceptionKernelInfo.dfxAddr == nullptr ||
        exceptionArgsInfo.exceptionKernelInfo.dfxSize == 0) {
        IDE_LOGE("In argAddr[%p]|argSize[%" PRIu32 "]|dfxAddr[%p]|dfxSize[%" PRIu16 "] has invalid attribute.",
                 exceptionArgsInfo.argAddr, exceptionArgsInfo.argsize, exceptionArgsInfo.exceptionKernelInfo.dfxAddr,
                 exceptionArgsInfo.exceptionKernelInfo.dfxSize);
        return ADUMP_FAILED;
    }

    argAddr_ = exceptionArgsInfo.argAddr;
    argSize_ = exceptionArgsInfo.argsize;
    int32_t ret = DumpArgs::FindExceptionDfx(exceptionArgsInfo);
    IDE_CHECK_RET(ret, return ADUMP_FAILED);
    IDE_LOGI("The dfx address[%p] and dfx size[%" PRIu16 "].", exceptionDfxPtr_, exceptionDfxSize_);

    auto data = DumpMemory::CopyDeviceToHostEx(argAddr_, argSize_);
    if (data == nullptr) {
        IDE_LOGE("Copy device args to host failed.");
        return ADUMP_FAILED;
    }
    HOST_RT_MEMORY_GUARD(data);
    argOnHost_ = static_cast<const void **>(data);
    maxArgNum_ = argSize_ / sizeof(uint64_t);
    LogArgsInfo(argOnHost_, maxArgNum_);

    ret = InitTensorModeInfo(exceptionDfxPtr_);
    if (ret != ADUMP_SUCCESS) {
        return ret;
    }
    uint32_t currArgsIndex = 0;
    uint64_t currExceptionDfxSize = 0;
    while (currExceptionDfxSize < exceptionDfxSize_) {
        std::stringstream exceptionDfxStr;
        for (size_t i = 0; i < (exceptionDfxSize_ - currExceptionDfxSize); ++i) {
            exceptionDfxStr << int32_t(*(exceptionDfxPtr_ + i)) << ", ";
        }
        IDE_LOGI("Current exception dfx raw data:%s ", exceptionDfxStr.str().c_str());

        if (currArgsIndex >= maxArgNum_) {
            IDE_LOGE("The current arg index[%" PRIu32 "] is greater than the max arg number[%" PRIu64 "]",
                     currArgsIndex, maxArgNum_);
            return ADUMP_FAILED;
        }

        ret = LoadDfxInfo(currExceptionDfxSize, currArgsIndex);
        if (ret != ADUMP_SUCCESS) {
            return ret;
        }
    }

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::LoadArgsInfoWithSizeInfo(const rtExceptionArgsInfo_t &exceptionArgsInfo,
                                           const rtExceptionExpandInfo_t &exceptionExpandInfo)
{
    if (CheckParam(exceptionArgsInfo, exceptionExpandInfo) != ADUMP_SUCCESS) {
        return ADUMP_FAILED;
    }

    if (InitAttributes(exceptionArgsInfo, exceptionExpandInfo) != ADUMP_SUCCESS) {
        return ADUMP_FAILED;
    }

    uint32_t maxArgNum = argSize_ / sizeof(uint64_t);
    if (static_cast<uint64_t>(skipNum_) + inputNum_ > maxArgNum) {
        IDE_LOGE("[Dump][Exception] skip num[%" PRIu32 "] plus input num[%" PRIu32 "] is over the max arg num[%" PRIu32
                 "], load failed.",
                 skipNum_, inputNum_, maxArgNum);
        return ADUMP_FAILED;
    }

    auto data = DumpMemory::CopyDeviceToHostEx(argAddr_, argSize_);
    if (data == nullptr) {
        IDE_LOGE("Copy device args to host failed.");
        return ADUMP_FAILED;
    }
    const void **argOnHost = static_cast<const void **>(data);
    if (exceptionExpandInfo.type == RT_EXCEPTION_FFTS_PLUS) {
        LogArgsInfo(argOnHost, maxArgNum);
    }

    uint32_t argIndex = skipNum_;
    IDE_LOGE("[Dump][Exception] the begin tensor's index of args is:%" PRIu32 ", args dump count[%" PRIu32 "]",
             argIndex, inputNum_);
    for (uint64_t sizeInfoIdx = sizeBeginIndex_; sizeInfoIdx < inputNum_ + sizeBeginIndex_; ++sizeInfoIdx) {
        int64_t size = *(reinterpret_cast<int64_t *>(&sizeInfo_[sizeInfoIdx]));
        // the size of the level-2 pointer is a negative number in earlier versions.
        if (size < 0) {
            size = std::abs(size);
            if (size > maxArgNum) {
                IDE_LOGE("[Dump][Exception] size[%" PRId64 "] over arg max[%" PRIu32 "] is invalid, load failed.", size,
                         maxArgNum);
                HOST_RT_MEMORY_GUARD(data);
                return ADUMP_FAILED;
            }
            sizeInfoIdx += size;
        } else {
            int32_t ret = LoadInputBuffer(argOnHost, argIndex, sizeInfoIdx);
            if (ret != ADUMP_SUCCESS) {
                HOST_RT_MEMORY_GUARD(data);
                return ADUMP_FAILED;
            }
        }
        argIndex++;
    }
    LoadTilingData();
    HOST_RT_MEMORY_GUARD(data);

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::LoadArgsExceptionInfo(const rtExceptionInfo &exception)
{
    rtExceptionArgsInfo_t exceptionArgsInfo{};
    rtExceptionExpandType_t exceptionTaskType = exception.expandInfo.type;
    rtExceptionExpandInfo_t exceptionExpandInfo = exception.expandInfo;
    if (ExceptionInfoCommon::GetExceptionInfo(exception, exceptionTaskType, exceptionArgsInfo) != ADUMP_SUCCESS) {
        IDE_LOGE("Get exception args info failed.");
        return ADUMP_FAILED;
    }
    kernelCollector_->LoadKernelInfo(exceptionArgsInfo);

    if (LoadArgsInfoWithDfx(exceptionArgsInfo) == ADUMP_SUCCESS) {
        dumpWithDfxFlag_ = true;
    } else {
        IDE_LOGI("Can not load args info with dfx, use load args info with size info instead of it.");
        if (LoadArgsInfoWithSizeInfo(exceptionArgsInfo, exceptionExpandInfo) != ADUMP_SUCCESS) {
            return ADUMP_FAILED;
        }
    }

    streamId_ = std::to_string(exception.streamid);
    taskId_ = std::to_string(exception.taskid);

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::CheckParam(const rtExceptionArgsInfo_t &exceptionArgsInfo,
                             const rtExceptionExpandInfo_t &exceptionExpandInfo) const
{
    // Except the aic/aiv error, other exceptions are also called back. Therefore, warning logs are generated here.
    if (exceptionArgsInfo.sizeInfo.infoAddr == nullptr || exceptionArgsInfo.sizeInfo.atomicIndex == 0 ||
        exceptionArgsInfo.argAddr == nullptr) {
        IDE_LOGW("[Dump][Exception] in infoAddr[%p]|atomicIndex[%" PRIu32 "]|argAddr[%p] has invalid attribute.",
                 exceptionArgsInfo.sizeInfo.infoAddr, exceptionArgsInfo.sizeInfo.atomicIndex,
                 exceptionArgsInfo.argAddr);
        return ADUMP_FAILED;
    }
    // RT_EXCEPTION_AICORE indicates the normal mode
    if (exceptionExpandInfo.type == RT_EXCEPTION_AICORE && exceptionArgsInfo.argsize == 0) {
        IDE_LOGW("[Dump][Exception] the arg size[%" PRIu32 "] is invalid.", exceptionArgsInfo.argsize);
        return ADUMP_FAILED;
    }

    uint64_t *sizeInfo = static_cast<uint64_t *>(exceptionArgsInfo.sizeInfo.infoAddr);
    if (sizeInfo < g_chunk || sizeInfo > (g_chunk + RING_CHUNK_SIZE - 1)) {
        IDE_LOGE("[Dump][Exception] the size info[%p] address may out of the chunk[%p] address range.", sizeInfo,
                 g_chunk);
        return ADUMP_FAILED;
    }
    if (sizeInfo[0] != exceptionArgsInfo.sizeInfo.atomicIndex) {
        IDE_LOGE("[Dump][Exception] args exception atomic index between %" PRIu64 " and %" PRIu32 " is different.",
                 sizeInfo[0], exceptionArgsInfo.sizeInfo.atomicIndex);
        return ADUMP_FAILED;
    }

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::InitAttributes(const rtExceptionArgsInfo_t &exceptionArgsInfo,
                                 const rtExceptionExpandInfo_t &exceptionExpandInfo)
{
    sizeInfo_ = static_cast<uint64_t *>(exceptionArgsInfo.sizeInfo.infoAddr);
    argAddr_ = exceptionArgsInfo.argAddr;

    // RT_EXCEPTION_AICORE indicates the normal mode
    if (exceptionExpandInfo.type == RT_EXCEPTION_AICORE) {
        sizeBeginIndex_ = ATOMIC_AND_INPUT_NUM_OFFSET;
        skipNum_ = (sizeInfo_[1] & SKIP_NUM_MASK) >> SKIP_NUM_SHIFT_BITS;
        inputNum_ = sizeInfo_[1] & INPUT_NUM_MASK;
        if (sizeInfo_ + inputNum_ + ATOMIC_AND_INPUT_NUM_OFFSET > g_chunk + RING_CHUNK_SIZE + MAX_TENSOR_NUM) {
            IDE_LOGE("[Dump][Exception] the value of size info[%p] plus input num[%" PRIu32
                     "] may exceed the chunk[%p] address range.",
                     sizeInfo_, inputNum_, g_chunk);
            return ADUMP_FAILED;
        }
        argSize_ = exceptionArgsInfo.argsize;
        return ADUMP_SUCCESS;
    }

    // RT_EXCEPTION_FFTS_PLUS indicates the ffts+ mode
    if (exceptionExpandInfo.type == RT_EXCEPTION_FFTS_PLUS) {
        uint64_t totalContextSizeNum = sizeInfo_[1];
        if (sizeInfo_ + totalContextSizeNum + ATOMIC_AND_INPUT_NUM_OFFSET >
            g_chunk + RING_CHUNK_SIZE + MAX_TENSOR_NUM) {
            IDE_LOGE("[Dump][Exception] the value of size info[%p] plus total num[%" PRIu64
                     "] may exceed the chunk[%p] address range.",
                     sizeInfo_, totalContextSizeNum, g_chunk);
            return ADUMP_FAILED;
        }
        uint32_t contextBeginIndex = ATOMIC_AND_INPUT_NUM_OFFSET;
        for (uint64_t sizeInfoIdx = contextBeginIndex; sizeInfoIdx < totalContextSizeNum + contextBeginIndex;
             ++sizeInfoIdx) {
            uint32_t inputNumBeginIndex = sizeInfoIdx + CONTEXTID_AND_INPUT_NUM_OFFSET;
            skipNum_ = (sizeInfo_[inputNumBeginIndex] & SKIP_NUM_MASK) >> SKIP_NUM_SHIFT_BITS;
            inputNum_ = sizeInfo_[inputNumBeginIndex] & INPUT_NUM_MASK;
            IDE_LOGI("[Dump][Exception] the context id[%" PRIu64 "] of size info and context id[%" PRIu16
                     "] of exception info",
                     sizeInfo_[sizeInfoIdx], exceptionExpandInfo.u.fftsPlusInfo.contextId);
            if (sizeInfo_[sizeInfoIdx] == exceptionExpandInfo.u.fftsPlusInfo.contextId) {
                argSize_ = sizeInfo_[sizeInfoIdx + 1];
                sizeBeginIndex_ = sizeInfoIdx + 3;  // 3 - context id | args size | input num
                return ADUMP_SUCCESS;
            }
            sizeInfoIdx += inputNum_ + CONTEXTID_AND_INPUT_NUM_OFFSET;
        }
    }

    // log warning - the arg data in ffts+ mode may be in others contextid
    IDE_LOGW("Data mismatch, some attribute values cannot be obtained.");
    return ADUMP_FAILED;
}

void DumpArgs::LogArgsInfo(const void **argOnHost, uint32_t maxArgNum)
{
    const uint32_t argsLogTimes = (maxArgNum % ARGS_PER_STRING_MAX_LEN > 0) ?
                                      ((maxArgNum / ARGS_PER_STRING_MAX_LEN) + 1) :
                                      (maxArgNum / ARGS_PER_STRING_MAX_LEN);
    for (uint32_t i = 1; i <= argsLogTimes; ++i) {
        std::stringstream ss;
        uint32_t endIndex = maxArgNum > (i * ARGS_PER_STRING_MAX_LEN) ? (i * ARGS_PER_STRING_MAX_LEN) : maxArgNum;
        for (uint32_t j = (i - 1) * ARGS_PER_STRING_MAX_LEN; j < endIndex; ++j) {
            ss << *(argOnHost + j) << ", ";
        }
        oss_ << "[AIC_INFO] args(" << (i - 1) * ARGS_PER_STRING_MAX_LEN << " to " << endIndex
             << ") after execute:" << ss.str().c_str();
        RecordCurrentLog();
    }
    IDE_LOGE("[AIC_INFO] after execute:args print end");
}

int32_t DumpArgs::LoadInputBuffer(const void **argOnHost, const uint32_t argIndex, uint64_t &sizeInfoIdx)
{
    uint8_t sizeType = (sizeInfo_[sizeInfoIdx] & SIZE_TYPE_MASK) >> SIZE_TYPE_SHIFT_BITS;
    if (sizeType == NORMAL_TENSOR || sizeType == WORKSPACE_TENSOR) {
        oss_ << "[Dump][Exception] begin to load normal tensor, index:" << argIndex;
        RecordCurrentLog();
        uint64_t tensorSize = sizeInfo_[sizeInfoIdx] & SIZE_MASK;
        oss_ << "[Dump][Exception] exception info dump args data, addr:" << argOnHost[argIndex]
             << "; size:" << tensorSize << " bytes";
        RecordCurrentLog();
        inputBuffer_.emplace_back(argOnHost[argIndex], tensorSize, argIndex);
        oss_ << "[Dump][Exception] end to load normal tensor, index:" << argIndex;
        RecordCurrentLog();
    } else if (sizeType == NORMAL_PTR_TENSOR || sizeType == SHAPE_PTR_TENSOR) {
        if (LoadPointerTensor(argOnHost, argIndex, sizeInfoIdx) != ADUMP_SUCCESS) {
            return ADUMP_FAILED;
        }
    } else if (sizeType == TILING_DATA_PTR) {
        IDE_LOGE("[Dump][Exception] save tiling data, index:%" PRIu32, argIndex);
        tilingData_.emplace_back(argOnHost[argIndex], (sizeInfo_[sizeInfoIdx] & SIZE_MASK), argIndex);
    } else {
        IDE_LOGE("[Dump][Exception] args exception size type[%" PRIu8 "] is error.", sizeType);
        return ADUMP_FAILED;
    }

    return ADUMP_SUCCESS;
}

int32_t DumpArgs::LoadPointerTensor(const void **argOnHost, const uint32_t argIndex, uint64_t &sizeInfoIdx)
{
    uint64_t addrBias = reinterpret_cast<uint64_t>(argOnHost[argIndex]) - reinterpret_cast<uint64_t>(argAddr_);
    if (addrBias >= argSize_) {
        IDE_LOGE("[Dump][Exception]address bias[%p - %p] is over args size[%" PRIu64 "], invalid.", argOnHost[argIndex],
                 argAddr_, argSize_);
        return ADUMP_FAILED;
    }

    uint64_t inputPtrAddr = addrBias + reinterpret_cast<uint64_t>(argOnHost);
    void *inputPtr = nullptr;
    std::string pointerType = "";
    uint8_t sizeType = (sizeInfo_[sizeInfoIdx] & SIZE_TYPE_MASK) >> SIZE_TYPE_SHIFT_BITS;
    if (sizeType == NORMAL_PTR_TENSOR) {
        inputPtr = reinterpret_cast<void *>(inputPtrAddr);
        pointerType = "normal pointer tensor";
    } else if (sizeType == SHAPE_PTR_TENSOR) {
        uint64_t offset = *(reinterpret_cast<uint64_t *>(inputPtrAddr));
        inputPtr = reinterpret_cast<void *>(inputPtrAddr + offset);
        pointerType = "shape pointer tensor";
    } else {
        IDE_LOGE("[Dump][Exception] args exception size type[%" PRIu8 "] is error.", sizeType);
        return ADUMP_FAILED;
    }

    IDE_LOGE("[Dump][Exception] begin to load %s, index:%" PRIu32 ", addr:%p", pointerType.c_str(), argIndex,
             argOnHost[argIndex]);

    const void **endArgAddr = argOnHost + argSize_ / sizeof(uint64_t);
    uint64_t inputPtrNum = sizeInfo_[sizeInfoIdx] & SIZE_MASK;
    for (uint64_t i = 0; i < inputPtrNum; ++i) {
        uint64_t inputPtrSize = sizeInfo_[sizeInfoIdx + 1 + i];
        void **tensorPtr = static_cast<void **>(inputPtr) + i;
        oss_ << "[Dump][Exception] exception info dump args data, addr:" << *(tensorPtr) << "; size:" << inputPtrSize
             << " bytes";
        RecordCurrentLog();
        if (tensorPtr > endArgAddr) {
            IDE_LOGE("[Dump][Exception] args address[%p] is over args end address[%p].", tensorPtr, endArgAddr);
            return ADUMP_FAILED;
        }
        inputBuffer_.emplace_back(*(tensorPtr), inputPtrSize, argIndex);
    }
    sizeInfoIdx += inputPtrNum;

    IDE_LOGE("[Dump][Exception] end to load %s, index:%" PRIu32 ", addr:%p", pointerType.c_str(), argIndex,
             argOnHost[argIndex]);

    return ADUMP_SUCCESS;
}

void DumpArgs::LoadTilingData()
{
    if (tilingData_.size() == 0) {
        return;
    }
    IDE_LOGE("[Dump][Exception] begin to load tiling data.");
    for (const auto &it : tilingData_) {
        oss_ << "[Dump][Exception] exception info dump args data, addr:" << it.addr << "; size:" << it.length
             << " bytes";
        RecordCurrentLog();
        inputBuffer_.emplace_back(it.addr, it.length, it.argIndex);
    }
    IDE_LOGE("[Dump][Exception] end to load tiling data.");
}

int32_t DumpArgs::DumpArgsExceptionFile(const uint32_t deviceId, const std::string &dumpPath)
{
    std::string dumpFilePath = GetDumpFilePath(dumpPath);
    IDE_LOGI("[Dump][Exception] The exception dump file path is %s", dumpFilePath.c_str());

    DumpFile dumpFile(deviceId, dumpFilePath);
    dumpFile.SetHeader("");
    if (dumpWithDfxFlag_) {
        dumpFile.SetTensorBuffer(tensorBuffer_);
        dumpFile.SetWorkspaces(workspace_);
#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
        dumpFile.SetMc2spaces(mc2Space_);
#endif
    } else {
        dumpFile.SetInputBuffer(inputBuffer_);
    }
    AdxLogFlush();
    int32_t ret = dumpFile.Dump(logRecord_);
    if (ret != ADUMP_SUCCESS) {
        IDE_LOGE("[Dump][Exception] write exception to file failed, file: %s", dumpFilePath.c_str());
        return ADUMP_FAILED;
    }

    (void)mmChmod(dumpFilePath.c_str(), M_IRUSR);  // readonly, 400
    IDE_LOGE("[Dump][Exception] dump exception to file, file: %s", dumpFilePath.c_str());

    IDE_LOGI("[Dump][Exception] Dump exception info success.");
    return ADUMP_SUCCESS;
}

int32_t DumpArgs::DumpArgsExceptionInfo(const uint32_t deviceId, const std::string &dumpPath)
{
    int32_t ret = ADUMP_SUCCESS;
    if (DumpArgsExceptionFile(deviceId, dumpPath) != ADUMP_SUCCESS) {
        ret = ADUMP_FAILED;
    }
    if (StartCollectKernelAsync(kernelCollector_, dumpPath) != ADUMP_SUCCESS) {
        ret = ADUMP_FAILED;
    }
    return ret;
}

std::string DumpArgs::GetDumpFilePath(const std::string &dumpPath) const
{
    std::string opType = "exception_info";
    std::string dumpFileName =
        opType + "." + streamId_ + "." + taskId_ + "." + SysUtils::GetCurrentTimeWithMillisecond();
    Path dumpFilePath(dumpPath);
    dumpFilePath.Concat(dumpFileName);
    dumpFilePath.RealPath();
    return dumpFilePath.GetString();
}

void DumpArgs::RecordCurrentLog()
{
    IDE_LOGE("%s", oss_.str().c_str());
    logRecord_.emplace_back(oss_.str() + "\n");
    oss_.str("");
}

bool DumpArgs::DumpArgsDumpWithDfxFlag() const
{
    return dumpWithDfxFlag_;
}

const std::vector<InputBuffer> &DumpArgs::DumpArgsGetInputBuffer() const
{
    return inputBuffer_;
}

const std::vector<TensorBuffer> &DumpArgs::DumpArgsGetTensorBuffer() const
{
    return tensorBuffer_;
}

const std::vector<DumpWorkspace> &DumpArgs::DumpArgsGetWorkSpace() const
{
    return workspace_;
}

}  // namespace Adx