/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_PROFILE_LOG_RECORD_HPP
#define CCE_RUNTIME_PROFILE_LOG_RECORD_HPP

#include "profiler_struct.hpp"

namespace cce {
namespace runtime {
class Profiler;

class ProfileLogRecord {
public:
    ProfileLogRecord(const uint16_t recordType, const uint16_t opType, const Profiler * const profilerInfo);
    ProfileLogRecord(const uint16_t opType, const Profiler * const profilerInfo);
    ~ProfileLogRecord() = default;
    void SaveRecord();
private:
    void PrintRecord(const rtProfileRecordSyncRt_t &recordSyncRt) const;
    rtProfileRecordSyncRt_t record_{};
};
}  // namespace runtime
}  // namespace cce

#endif  // CCE_RUNTIME_PROFILE_LOG_RECORD_HPP
