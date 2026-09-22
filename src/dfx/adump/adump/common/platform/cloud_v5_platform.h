/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_PLATFORM_CLOUD_V5_PLATFORM_H
#define ADUMP_COMMON_PLATFORM_CLOUD_V5_PLATFORM_H

#include "coredump_register_interface.h"
#include "cloud_v4_platform.h"

namespace Adx {

// CHIP_CLOUD_V5 各特性域实现。寄存器/异常/数据 dump 行为当前与 V4 一致，通过继承 V4 实现复用；
// coredump 域使用 V5 专用的 PcFixer/Register。
class CloudV5Features : public FeaturesSupportInterface {
public:
    CloudV5Features();
};

class CloudV5Coredump : public CloudV4Coredump {
public:
    std::unique_ptr<PcFixerInterface> CreatePcFixer() const override;
    std::shared_ptr<RegisterInterface> CreateRegister() const override;
    uint16_t ConvertCoreId(uint8_t coreType, uint16_t coreId) const override;
};

// 异常/数据 dump 行为与 V4 一致，直接复用 V4 实现。
class CloudV5Exception : public CloudV4Exception {};

class CloudV5DataDump : public CloudV4DataDump {
public:
    uint64_t GetKfcStackSize() const override;
    std::vector<std::string> GetKfcBinNames() const override;
    size_t GetCoreTypeIDOffset() const override;
    size_t GetBlockNum() const override;
};

// 寄存器配置
// V5 寄存器配置：继承 V4（共用错误寄存器基表与公共段函数）。
class CloudV5Register : public CloudV4Register {
public:
    CloudV5Register();
    ~CloudV5Register() override{};

protected:
    std::vector<RegisterTable> GenAicDbgRegSuAddr() override;
    std::vector<RegisterTable> GenAicDbgRegMteAddr() override;
    std::vector<RegisterTable> GenAicDbgRegCubeAddr() override;
    std::vector<RegisterTable> GenAicDbgRegL1Addr() override;
    std::vector<RegisterTable> GenAicDfxRegAddr() override;
    std::vector<RegisterTable> GenAivDbgRegSuAddr() override;
    std::vector<RegisterTable> GenAivDbgRegVecAddr() override;
    std::vector<RegisterTable> GenAivDfxRegAddr() override;
    void GenAICOffsetAddr() override;
    void GenAIVOffsetAddr() override;

private:
    static std::vector<RegisterTable> ScSuDfxAddr();
    static std::vector<RegisterTable> OffCommonHeadAddr();
    static std::vector<RegisterTable> OffCommon9xAddr();
    static std::vector<RegisterTable> OffCommonBxAddr();
    void InitErrorRegisters() override;
};

} // namespace Adx
#endif // ADUMP_COMMON_PLATFORM_CLOUD_V5_PLATFORM_H
