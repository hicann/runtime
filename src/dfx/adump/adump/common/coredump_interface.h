/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_COREDUMP_INTERFACE_H
#define ADUMP_COMMON_COREDUMP_INTERFACE_H

#include <cstdint>
#include <memory>

namespace Adx {

class PcFixerInterface;
class RegisterInterface;
class DumpCore;

// Coredump 特性下的平台差异处理。仅支持 coredump 的平台（V2/V4）注册此接口；
// 不支持的平台（如 DC）不注册，CoredumpManager::Get() 返回 nullptr。
class CoredumpInterface {
public:
    virtual ~CoredumpInterface() = default;

    virtual std::unique_ptr<PcFixerInterface> CreatePcFixer() const = 0;
    virtual std::shared_ptr<RegisterInterface> CreateRegister() const = 0;
    virtual void DumpRegister(DumpCore& core, uint8_t coreType, uint16_t coreId) const = 0;
    virtual uint16_t ConvertCoreId(uint8_t coreType, uint16_t coreId) const = 0;
};

} // namespace Adx
#endif // ADUMP_COMMON_COREDUMP_INTERFACE_H
