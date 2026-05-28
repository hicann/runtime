/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DFX_ARGS_PARSER_H
#define DFX_ARGS_PARSER_H

#include <cstdint>
#include <vector>
#include <string>
#include "str_utils.h"
#include "adump_pub.h"
#include "dump_args.h"
#include "log/hdc_log.h"

namespace Adx {

class DfxArgsParser {
public:
    DfxArgsParser() = default;
    ~DfxArgsParser();
    DfxArgsParser(const DfxArgsParser&) = delete;
    DfxArgsParser& operator=(const DfxArgsParser&) = delete;
    DfxArgsParser(DfxArgsParser&&) = delete;
    DfxArgsParser& operator=(DfxArgsParser&&) = delete;

    int32_t Init(void *argAddr, uint64_t argSize, const uint8_t *dfxAddr, uint16_t dfxSize);

    int32_t InitTensorModeInfo();

    int32_t ParseAll();

    const std::vector<TensorBuffer> &GetTensors() const { return tensors_; }
    const std::vector<DumpWorkspace> &GetWorkspaces() const { return workspaces_; }
    const std::vector<DumpWorkspace> &GetMc2Space() const { return mc2Space_; }
    const std::vector<std::string> &GetLogRecords() const { return logRecords_; }
    bool IsDynamicMode() const { return dynamicModeFlag_; }
    const void **GetArgOnHost() const { return argOnHost_; }
    uint64_t GetMaxArgNum() const { return maxArgNum_; }

    void SetIsTik(bool isTik) { isTik_ = isTik; }
    bool GetIsTik() const { return isTik_; }

private:
    void *hostArgsData_{nullptr};
    const void **argOnHost_{nullptr};
    uint64_t maxArgNum_{0};
    void *argAddr_{nullptr};
    uint64_t argSize_{0};

    const uint8_t *dfxAddr_{nullptr};
    uint16_t dfxSize_{0};
    uint64_t currDfxSize_{0};

    bool dynamicModeFlag_{false};
    bool isTik_{false};
    uint64_t *shapeDataAddr_{nullptr};
    uint64_t *shapeDataMaxAddr_{nullptr};

    std::vector<TensorBuffer> tensors_;
    std::vector<DumpWorkspace> workspaces_;
    std::vector<DumpWorkspace> mc2Space_;
    std::vector<std::string> logRecords_;

    void RecordDumpLog(const std::string &log);
    void LogArgsInfo();

    template <typename T>
    static int32_t GetPointerValueByBigEndian(const uint8_t **ptr, T &value,
                                               uint64_t &currSize, uint16_t totalSize);

    static const char* GetTensorTypeName(DfxTensorType tensorType);
    static const char* GetPointerTypeName(DfxPointerType pointerType);

    static int32_t GetAddressBias(uint64_t &addrBias, const void *argAddr,
                                  void *baseAddr, uint64_t argsSize);

    static int32_t CheckAddressOverArgs(const uint64_t *address,
                                        const void **argOnHost, uint64_t maxArgNum);

    int32_t InitTensorModeInfoInner(uint32_t currArgsIndex, const uint8_t *&dfxAddr, uint64_t &currDfxSize);
    int32_t LoadDfxInfo(uint32_t &currArgsIndex);
    int32_t LoadDfxTensor(TensorBuffer &tensor, uint16_t argsInfoNum);
    int32_t LoadDfxL1PtrTensor(TensorBuffer &tensor);
    int32_t LoadDfxL2ShapePtrTensor(TensorBuffer &tensor);
    int32_t LoadDfxWorkspace(TensorBuffer &tensor);
    int32_t LoadDfxTilingData(TensorBuffer &tensor);
    void LoadDfxMc2(const TensorBuffer &tensor);
    int32_t LoadDfxShapeData();
    int32_t GetShapeData(uint64_t atomicIndex);
    int32_t CheckShapeDataAddress() const;
    bool CheckMagicMemory(const uint8_t *address) const;
    int32_t LoadTensorShapeAndSize(TensorBuffer &tensor, uint64_t *dynamicTensorAddr,
                                   void **tensorAddr, uint64_t shapeInfoCount);
    bool GetIsDataTypeSizeByte(bool &isDataTypeSizeByte) const;
};

template <typename T>
int32_t DfxArgsParser::GetPointerValueByBigEndian(const uint8_t **ptr, T &value,
                                                  uint64_t &currSize, uint16_t totalSize)
{
    constexpr uint16_t bitOfByte = 8;
    value = 0;

    for (size_t i = 0; i < sizeof(T); ++i) {
        if (currSize >= totalSize) {
            IDE_LOGE("The dfx data size[%llu] is larger than the total dfx size[%u].", currSize, totalSize);
            return ADUMP_FAILED;
        }
        value = value | (static_cast<uint64_t>(**ptr) << ((sizeof(T) - i - 1) * bitOfByte));
        currSize++;
        (*ptr)++;
    }

    return ADUMP_SUCCESS;
}

} // namespace Adx

#endif // DFX_ARGS_PARSER_H
