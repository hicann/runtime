/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DUMP_SETTING_H
#define DUMP_SETTING_H

#include <string>
#include "adump_pub.h"
#include "path.h"
#include "adump_dsmi.h"
#include "adump_api.h"

namespace Adx {
constexpr uint32_t DUMP_MODE_INPUT = 1U << 0;
constexpr uint32_t DUMP_MODE_OUTPUT = 1U << 1;
constexpr uint32_t DUMP_MODE_WORKSPACE = 1U << 2;
constexpr char DUMP_TENSOR_DATA[] = "tensor";
constexpr char DUMP_STATS_DATA[] = "stats";
constexpr uint64_t DUMP_SWITCH_MASK = 0x00000000FFFFFFFF;
constexpr uint64_t DUMP_EXTERN_SWITCH_MASK = 0xFFFFFFFF00000000;

class DumpSetting {
public:
    DumpSetting() = default;
    int32_t Init(const DumpType type, const DumpConfig &dumpConfig);
    std::string GetDumpPath() const;
    uint32_t GetDumpMode() const;
    bool GetDumpStatus() const;
    bool GetDumpDebugStatus() const;
    bool InitDumpStatus(const std::string &dumpStatus, bool &status) const;
    const std::string GetDumpData() const;
    uint64_t GetDumpSwitch() const;
    uint64_t GetDumpStatsItem() const;
    PlatformType GetPlatformType() const;
    void InitDumpSwitch(uint64_t dumpSwitch);

private:
    int32_t DumpOperatorInit(const DumpConfig &dumpConfig);
    int32_t DumpOverflowInit(const DumpConfig &dumpConfig);
    bool InitDumpPath(const std::string &dumpPath);
    bool InitDumpMode(const std::string &dumpMode);
    void InitDumpData(const std::string &dumpData);
    bool InitDumpStatsItem(const std::vector<std::string> &dumpStatsItem);

    Path dumpPath_;
    uint32_t dumpMode_{ 0 };
    bool dumpStatus_{ false };
    bool dumpDebugStatus_{ false };
    std::string dumpData_{ DUMP_TENSOR_DATA };
    uint64_t dumpSwitch_{ 0 };
    uint64_t dumpStatsItem_{ 0 };
    uint32_t platformType_{ 0 };
};
}  // namespace Adx
#endif  // DUMP_SETTING_H