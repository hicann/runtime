/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_PLATFORM_CLOUD_V2_PLATFORM_H
#define ADUMP_COMMON_PLATFORM_CLOUD_V2_PLATFORM_H

#include "features_support_interface.h"
#include "coredump_interface.h"
#include "exception_dump_interface.h"
#include "data_dump_interface.h"

namespace Adx {

// CHIP_CLOUD_TYPE (Ascend910/910A) 仅复用 L1 exception dump 的 MC2 spaces 子能力。
class CloudLegacyException : public ExceptionDumpInterface {
public:
    bool SupportMc2SpacesDump() const override;
    uint64_t GetMc2StructSize() const override;
};

// CHIP_CLOUD_V2 (Ascend910B) 各特性域实现。
class CloudV2Features : public FeaturesSupportInterface {
public:
    CloudV2Features();
};

class CloudV2Coredump : public CoredumpInterface {
public:
    std::unique_ptr<PcFixerInterface> CreatePcFixer() const override;
    std::shared_ptr<RegisterInterface> CreateRegister() const override;
    void DumpRegister(DumpCore& core, uint8_t coreType, uint16_t coreId) const override;
    uint16_t ConvertCoreId(uint8_t coreType, uint16_t coreId) const override;
};

class CloudV2Exception : public ExceptionDumpInterface {
public:
    bool SupportMc2SpacesDump() const override;
    uint64_t GetMc2StructSize() const override;
    bool IsArgsDataTypeSizeByByte() const override;
};

class CloudV2DataDump : public DataDumpInterface {
public:
    uint64_t GetKfcStackSize() const override;
    std::string GetKfcBinName() const override;
    bool IsUbFromAiCore() const override;
};

} // namespace Adx
#endif // ADUMP_COMMON_PLATFORM_CLOUD_V2_PLATFORM_H
