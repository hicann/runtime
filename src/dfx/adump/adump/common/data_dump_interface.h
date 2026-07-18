/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_DATA_DUMP_INTERFACE_H
#define ADUMP_COMMON_DATA_DUMP_INTERFACE_H

#include <cstddef>
#include <cstdint>
#include <string>

namespace Adx {

// Data Dump 特性下的平台差异处理，涵盖 KFC stats 参数与 dump_printf 参数。所有平台都注册
// 此接口，未覆盖的方法走基类默认值（默认值对齐原 dump_printf 非 Ascend950 分支取值）。
class DataDumpInterface {
public:
    virtual ~DataDumpInterface() = default;

    // KFC stats
    virtual uint64_t GetKfcStackSize() const { return 0; }
    virtual std::string GetKfcBinName() const { return ""; }
    virtual bool IsUbFromAiCore() const { return false; }  // 原 CHIP_CORE_MAP

    // dump_printf 参数（原 Ascend950 专属逻辑，芯片身份消失）
    virtual size_t GetCoreTypeIDOffset() const { return 50U; }
    virtual size_t GetBlockNum() const { return 75U; }
    virtual int32_t GetStreamSyncTimeout() const { return 60000; }
    virtual bool IsSimtDumpEnabled(size_t /* dumpWorkSpaceSize */) const { return false; }

protected:
    static uint64_t CalcKfcStackSize(uint32_t opStackCount)
    {
        constexpr uint32_t BLOCK_MIN_SIZE = 32;
        constexpr uint32_t INTEGER_KILOBYTE = 1024;
        return static_cast<uint64_t>(opStackCount) * BLOCK_MIN_SIZE * INTEGER_KILOBYTE;
    }
};

} // namespace Adx
#endif // ADUMP_COMMON_DATA_DUMP_INTERFACE_H
