/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "common/profiler_struct.hpp"
#include "runtime/base.h"
#include "profile_log_record.hpp"
#include "profiler.hpp"

namespace cce {
namespace runtime {
ProfileLogRecord::ProfileLogRecord(const uint16_t recordType, const uint16_t opType, const Profiler* const profilerInfo)
{
    record_.type = recordType;
    record_.rtOpType = opType;
    record_.pid = profilerInfo->GetProcessId();
    record_.tid = profilerInfo->GetThreadId();
    profilerInfo->SeqAdd();
    record_.seqId = profilerInfo->GetSeq();
    record_.startStamp = GetTickCount();
    return;
}

ProfileLogRecord::ProfileLogRecord(const uint16_t opType, const Profiler* const profilerInfo)
    : ProfileLogRecord(PROFILE_RECORD_TYPE_RT_CALL_RT, opType, profilerInfo)
{}

void ProfileLogRecord::PrintRecord(const rtProfileRecordSyncRt_t& recordSyncRt) const
{
    RT_LOG(
        RT_LOG_INFO,
        "RtApiCall: RecordType=" RT_ENUM_LOG_FORMAT("%u") " OperationType=%hu"
                                                          " pid=%u tid=%u seq=%u start=%" PRIu64 " end=%" PRIu64 "",
        RT_ENUM_LOG_VALUE(
            static_cast<uint32_t>(recordSyncRt.type),
            (recordSyncRt.type <= PROFILE_RECORD_TYPE_END ?
                 RtProfileRecordTypeToString(static_cast<rtProfileRecordType_t>(recordSyncRt.type)) :
                 "UNKNOWN")),
        recordSyncRt.rtOpType, recordSyncRt.pid, recordSyncRt.tid, recordSyncRt.seqId, recordSyncRt.startStamp,
        recordSyncRt.endStamp);
}

void ProfileLogRecord::SaveRecord()
{
    record_.endStamp = GetTickCount();
    PrintRecord(record_);
    return;
}

} // namespace runtime
} // namespace cce
