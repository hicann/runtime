/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "npu_driver_record.hpp"
#include "profiler.hpp"
#include "runtime.hpp"

namespace cce {
namespace runtime {
NpuDriverRecord::NpuDriverRecord(const uint16_t opType)
{
    const Profiler * const curProfiler = Runtime::Instance()->Profiler_();
    needSave_ = false;
    if (curProfiler == nullptr) {
        return;
    }
    if (curProfiler->GetProfLogEnable()) {
        needSave_ = true;
        record_.type = PROFILE_RECORD_TYPE_RT_CALL_DRV;
        record_.drvOpType = opType;
        record_.pid = curProfiler->GetProcessId();
        record_.tid = curProfiler->GetThreadId();
        record_.seqId = curProfiler->GetSeq();
        record_.startStamp = GetTickCount();
    }
    return;
}

void NpuDriverRecord::PrintRecord(const rtProfileRecordSyncDrv_t &recordSyncDrv) const
{
    RT_LOG(RT_LOG_INFO, "DrvApiCall: RecordType=%hu OperationType=%hu"
        " pid=%u tid=%u seq=%u start=%" PRIu64 " end=%" PRIu64 "",
        recordSyncDrv.type, recordSyncDrv.drvOpType,
        recordSyncDrv.pid, recordSyncDrv.tid, recordSyncDrv.seqId,
        recordSyncDrv.startStamp, recordSyncDrv.endStamp);
    return;
}

void NpuDriverRecord::SaveRecord()
{
    if (needSave_) {
        record_.endStamp = GetTickCount();
        PrintRecord(record_);
    }
    return;
}

}  // namespace runtime
}  // namespace cce
