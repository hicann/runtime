/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_PLATFORM_DC_PLATFORM_H
#define ADUMP_COMMON_PLATFORM_DC_PLATFORM_H

#include "features_support_interface.h"
#include "exception_dump_interface.h"
#include "data_dump_interface.h"

namespace Adx {

// CHIP_DC_TYPE (Ascend310P) 各特性域实现。不支持 coredump，故不注册 CoredumpInterface。
class DcFeatures : public FeaturesSupportInterface {
public:
    DcFeatures();
};

class DcException : public ExceptionDumpInterface {
public:
    bool IsArgsDataTypeSizeByByte() const override;
};

class DcDataDump : public DataDumpInterface {
public:
    uint64_t GetKfcStackSize() const override;
    std::string GetKfcBinName() const override;
};

} // namespace Adx
#endif // ADUMP_COMMON_PLATFORM_DC_PLATFORM_H
