/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PROFILER_MSPROFTXMANAGER_H
#define PROFILER_MSPROFTXMANAGER_H

#include <mutex>
#include <map>
#include <atomic>
#include "utils.h"
#include "common/singleton/singleton.h"
#include "msprof_tx_reporter.h"
#include "prof_stamp_pool.h"
#include "acl/acl_base.h"
namespace Msprof {
namespace MsprofTx {
using ACL_PROF_STAMP_PTR = MsprofStampInstance *;
using CONST_CHAR_PTR = const char *;

enum class EventType {
    MARK = 0,
    PUSH_OR_POP,
    START_OR_STOP,
    MARK_EX
};

class MsprofTxManager : public analysis::dvvp::common::singleton::Singleton<MsprofTxManager> {
public:

    MsprofTxManager();
    ~MsprofTxManager() override;

    // create stamp memory pool, init plugin and push stack
    int32_t Init();
    // destroy resource
    void UnInit();

    // get stamp from memory pool
    ACL_PROF_STAMP_PTR CreateStamp() const;
    // destroy stamp
    void DestroyStamp(const ACL_PROF_STAMP_PTR stamp) const;

    //  save category and name relation
    int32_t SetCategoryName(uint32_t category, const std::string categoryName) const;

    // stamp message manage
    int32_t SetStampCategory(ACL_PROF_STAMP_PTR stamp, uint32_t category) const;
    int32_t SetStampPayload(ACL_PROF_STAMP_PTR stamp, const int32_t type, const void *value) const;
    int32_t SetStampTraceMessage(ACL_PROF_STAMP_PTR stamp, CONST_CHAR_PTR msg, uint32_t msgLen) const;

    // mark stamp
    int32_t Mark(ACL_PROF_STAMP_PTR stamp) const;
    // mark ex
    int32_t MarkEx(CONST_CHAR_PTR msg, size_t msgLen, aclrtStream stream);

    // stamp stack manage
    int32_t Push(ACL_PROF_STAMP_PTR stamp) const;
    int32_t Pop() const;

    // stamp map manage
    int RangeStart(ACL_PROF_STAMP_PTR stamp, uint32_t *rangeId) const;
    int32_t RangeStop(uint32_t rangeId) const;
    void RegisterReporterCallback(const ProfAdditionalBufPushCallback func);
    void RegisterRuntimeTxCallback(const ProfMarkExCallback func);
    int32_t ReportData(MsprofTxInfo &info) const;

    uint64_t GetTxEventId();
    int32_t LaunchDeviceTxTask(uint64_t indexId, VOID_PTR stm);

private:
    int32_t MarkExPoint(aclrtStream stream, MsprofTxInfo &info);

private:
    int32_t ReportStampData(MsprofStampInstance *stamp) const;

    bool isInit_;
    std::mutex mtx_;
    std::shared_ptr<MsprofTxReporter> reporter_;
    std::shared_ptr<ProfStampPool> stampPool_;
    std::map<uint32_t, std::string> categoryNameMap_;
    std::atomic<uint32_t> markExIndex_;
    ProfMarkExCallback rtProfilerTraceExFunc_;
    std::mutex markExMtx_;
    std::atomic<uint64_t> txEventId_;
};

}
}

#endif // PROFILER_MSPROFTXMANAGER_H
