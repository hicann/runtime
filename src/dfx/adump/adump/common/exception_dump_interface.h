/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_EXCEPTION_DUMP_INTERFACE_H
#define ADUMP_COMMON_EXCEPTION_DUMP_INTERFACE_H

#include <cstdint>

namespace Adx {

// Exception Dump（L1）特性下的平台子行为差异。L1 主路径全平台一致，仅 MC2 spaces dump 与
// args 数据类型基准两个子行为有平台差异。所有平台都注册此接口，未覆盖的方法走基类默认值。
class ExceptionDumpInterface {
public:
    virtual ~ExceptionDumpInterface() = default;

    virtual bool SupportMc2SpacesDump() const { return false; }
    virtual uint64_t GetMc2StructSize() const { return 0; }        // 910_93 子型号判断内聚于 V2 实现
    virtual bool IsArgsDataTypeSizeByByte() const { return false; }
};

} // namespace Adx
#endif // ADUMP_COMMON_EXCEPTION_DUMP_INTERFACE_H
