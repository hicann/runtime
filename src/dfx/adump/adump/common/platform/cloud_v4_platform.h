/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_PLATFORM_CLOUD_V4_PLATFORM_H
#define ADUMP_COMMON_PLATFORM_CLOUD_V4_PLATFORM_H

#include "features_support_interface.h"
#include "coredump_interface.h"
#include "exception_dump_interface.h"
#include "data_dump_interface.h"

namespace Adx {

// CHIP_CLOUD_V4 (Ascend950) 各特性域实现。
class CloudV4Features : public FeaturesSupportInterface {
public:
    CloudV4Features();
};

class CloudV4Coredump : public CoredumpInterface {
public:
    std::unique_ptr<PcFixerInterface> CreatePcFixer() const override;
    std::shared_ptr<RegisterInterface> CreateRegister() const override;
    void DumpRegister(DumpCore& core, uint8_t coreType, uint16_t coreId) const override;
    uint16_t ConvertCoreId(uint8_t coreType, uint16_t coreId) const override;
};

class CloudV4Exception : public ExceptionDumpInterface {
public:
    bool IsArgsDataTypeSizeByByte() const override;
};

class CloudV4DataDump : public DataDumpInterface {
public:
    uint64_t GetKfcStackSize() const override;
    std::string GetKfcBinName() const override;
    bool IsUbFromAiCore() const override;
    size_t GetCoreTypeIDOffset() const override;
    size_t GetBlockNum() const override;
    int32_t GetStreamSyncTimeout() const override;
    bool IsSimtDumpEnabled(size_t dumpWorkSpaceSize) const override;
};

} // namespace Adx
#endif // ADUMP_COMMON_PLATFORM_CLOUD_V4_PLATFORM_H
