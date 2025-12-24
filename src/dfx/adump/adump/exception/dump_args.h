/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DUMP_ARGS_H
#define DUMP_ARGS_H

#include <string>
#include <vector>
#include <sstream>
#include "adump_pub.h"
#include "adump_api.h"
#include "dump_operator.h"
#include "runtime/rt.h"
#include "kernel_info_collector.h"
#include "log/adx_log.h"
#include "adx_exception_callback.h"

namespace Adx {
#define IDE_CHECK_RET(ret, action)    \
    do {                              \
        if ((ret) != ADUMP_SUCCESS) { \
            action;                   \
        }                             \
    } while (0)

constexpr uint16_t TYPE_L0_EXCEPTION_DFX = 4U;
constexpr uint16_t TYPE_L0_EXCEPTION_DFX_ARGS_INFO = 5U;
constexpr uint16_t TYPE_L0_EXCEPTION_DFX_IS_TIK = 6U;
constexpr uint64_t TENSOR_TYPE_MASK = 0x0FFFF;              // 0~15 bit
constexpr uint64_t POINTER_TYPE_MASK = 0x0FFFF0000;         // 16~31 bit
constexpr uint64_t TENSOR_COUNT_MASK = 0xFFFFFFFF00000000;  // high 32 bits
constexpr uint64_t TENSOR_DIMENSION_MASK = 0x0FFFFFFFF;     // low 32 bits
constexpr uint32_t TENSOR_COUNT_SHIFT_BITS = 32;
constexpr uint32_t POINTER_TYPE_SHIFT_BITS = 16;
constexpr int32_t ELF_DATA2MSB = 2;
constexpr uint32_t BITS_PER_BYTE = 8U;

enum class DfxPointerType : uint16_t {
    INVALID_POINTER = 0,
    LEVEL_1_POINTER = 1,
    LEVEL_2_POINTER,
    LEVEL_2_POINTER_WITH_SHAPE,
    SHAPE_TENSOR_PLACEHOLD
};

struct InputBuffer {
    InputBuffer(const void *argAddr, uint64_t len, uint32_t index) : addr(argAddr), length(len), argIndex(index) {}
    const void *addr;
    uint64_t length;
    uint32_t argIndex;
};

struct TensorBuffer {
    TensorBuffer(const void *argAddr, uint32_t index, DfxTensorType dfxTensorType, DfxPointerType dfxPointerType)
        : addr(argAddr),
          argIndex(index),
          tensorType(dfxTensorType),
          pointerType(dfxPointerType)
    {
    }
    const void *addr{nullptr};
    uint64_t size{0U};
    uint64_t dataTypeSize{1U};  // 无data type size情况下，默认值为1，size为实际内存大小
    bool isDataTypeSizeByte{true};  // 标记dataTypeSize以bit还是byte为单位
    uint64_t dimension{0U};
    std::vector<uint64_t> shape;
    uint32_t argIndex;
    DfxTensorType tensorType;
    DfxPointerType pointerType;
    uint64_t GetTotalByteSize() const
    {
        if (isDataTypeSizeByte) {
            return dataTypeSize * size;
        }
        uint64_t totalBits = dataTypeSize * size;
        uint32_t remainder = totalBits % BITS_PER_BYTE == 0 ? 0 : 1;  // 向上取整
        return totalBits / BITS_PER_BYTE + remainder;
    }
};

extern uint64_t g_chunk[RING_CHUNK_SIZE + MAX_TENSOR_NUM];

class DumpArgs {
public:
    DumpArgs()
        : sizeInfo_(nullptr),
          sizeBeginIndex_(0),
          skipNum_(0),
          inputNum_(0),
          argAddr_(nullptr),
          argSize_(0),
          dynamicModeFlag_(false),
          dumpWithDfxFlag_(false),
          isTik_(false),
          shapeDataAddr_(nullptr),
          shapeDataMaxAddr_(nullptr),
          exceptionDfxPtr_(nullptr),
          exceptionDfxSize_(0),
          maxArgNum_(0),
          argOnHost_(nullptr),
          kernelCollector_(std::make_shared<KernelInfoCollector>()){};
    ~DumpArgs() = default;
    int32_t LoadArgsExceptionInfo(const rtExceptionInfo &exception);
    int32_t DumpArgsExceptionInfo(const uint32_t deviceId, const std::string &dumpPath);

    bool DumpArgsDumpWithDfxFlag() const;
    const std::vector<InputBuffer> &DumpArgsGetInputBuffer() const;
    const std::vector<TensorBuffer> &DumpArgsGetTensorBuffer() const;
    const std::vector<DumpWorkspace> &DumpArgsGetWorkSpace() const;

private:
    int32_t DumpArgsExceptionFile(const uint32_t deviceId, const std::string &dumpPath);
    std::string GetDumpFilePath(const std::string &dumpPath) const;
    int32_t CheckParam(const rtExceptionArgsInfo_t &exceptionArgsInfo,
                       const rtExceptionExpandInfo_t &exceptionExpandInfo) const;
    int32_t InitAttributes(const rtExceptionArgsInfo_t &exceptionArgsInfo,
                           const rtExceptionExpandInfo_t &exceptionExpandInfo);
    int32_t InitTensorModeInfo(const uint8_t *exceptionDfxPtr);
    int32_t InitTensorModeInfoInner(const uint8_t *exceptionDfxPtr, uint64_t &currDfxSize, uint32_t currArgsIndex);
    int32_t LoadArgsInfoWithDfx(const rtExceptionArgsInfo_t &exceptionArgsInfo);
    int32_t LoadArgsInfoWithSizeInfo(const rtExceptionArgsInfo_t &exceptionArgsInfo,
                                     const rtExceptionExpandInfo_t &exceptionExpandInfo);
    void LogArgsInfo(const void **argOnHost, uint32_t maxArgNum);
    int32_t LoadInputBuffer(const void **argOnHost, const uint32_t argIndex, uint64_t &sizeInfoIdx);
    int32_t LoadPointerTensor(const void **argOnHost, const uint32_t argIndex, uint64_t &sizeInfoIdx);
    void LoadTilingData();

    template <typename T>
    int32_t GetPointerValueByBigEndian(const uint8_t **ptr, T &value, uint64_t &currentDfxSize,
                                       uint16_t totalDfxSize) const;
    template <typename T>
    int32_t GetPointerValueByLittleEndian(const uint8_t **ptr, T &value, uint64_t &currentDfxSize,
                                          uint16_t totalDfxSize) const;
    int32_t FindExceptionDfx(const rtExceptionArgsInfo_t &exceptionArgsInfo);
    int32_t CheckAddressOverArgs(const uint64_t *address, const void **argOnHost, uint64_t maxArgNum) const;
    int32_t GetAddressBias(uint64_t &addrBias, const void *argAddr, void *baseAddr, uint64_t argsSize) const;
    int32_t LoadDfxInfo(uint64_t &currExceptionDfxSize, uint32_t &currArgsIndex);
    int32_t LoadDfxTensor(TensorBuffer &tensorBuffer, uint64_t &currExceptionDfxSize, uint16_t argsInfoNum);
    int32_t LoadDfxL1PtrTensor(TensorBuffer &tensorBuffer, uint64_t &currExceptionDfxSize);
    int32_t LoadTensorShapeAndSize(TensorBuffer &tensorBuffer, uint64_t *dynamicTensorAddr, void **tensorAddr,
                                   uint64_t shapeInfoCount);
    int32_t LoadDfxL2ShapePtrTensor(TensorBuffer &tensorBuffer);
    int32_t LoadDfxWorkspace(const TensorBuffer &tensorBuffer, uint64_t &currExceptionDfxSize);
    void LoadDfxMc2(const TensorBuffer &tensorBuffer);
    int32_t LoadDfxTilingData(TensorBuffer &tensorBuffer, uint64_t &currExceptionDfxSize);
    int32_t LoadDfxShapeData();
    int32_t GetShapeData(uint64_t atomicIndex);
    bool CheckMagicMemory(const uint8_t *address) const;
    int32_t CheckShapeDataAddress() const;
    void RecordCurrentLog();
    bool GetIsDataTypeSizeByte(bool &isDataTypeSizeByte) const;
    std::string taskId_;
    std::string streamId_;
    std::vector<InputBuffer> inputBuffer_;
    std::vector<InputBuffer> tilingData_;
    std::vector<TensorBuffer> tensorBuffer_;
    std::vector<DumpWorkspace> workspace_;
    std::vector<DumpWorkspace> mc2Space_;
    uint64_t *sizeInfo_;
    uint32_t sizeBeginIndex_;
    uint32_t skipNum_;
    uint32_t inputNum_;
    void *argAddr_;
    uint64_t argSize_;
    bool dynamicModeFlag_;
    bool dumpWithDfxFlag_;
    bool isTik_;
    uint64_t *shapeDataAddr_;
    uint64_t *shapeDataMaxAddr_;
    const uint8_t *exceptionDfxPtr_;
    uint16_t exceptionDfxSize_;
    uint64_t maxArgNum_;
    const void **argOnHost_;
    std::shared_ptr<KernelInfoCollector> kernelCollector_;
    // log record
    std::vector<std::string> logRecord_;
    std::ostringstream oss_;
};
}  // namespace Adx
#endif
