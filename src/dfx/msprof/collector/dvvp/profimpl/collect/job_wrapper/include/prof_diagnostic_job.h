/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_JOB_WRAPPER_PROF_DIAGNOSTIC_JOB_H
#define ANALYSIS_DVVP_JOB_WRAPPER_PROF_DIAGNOSTIC_JOB_H

#include <set>
#include <mutex>
#include <condition_variable>
#include "prof_common.h"
#include "thread/thread.h"
#include "dsmi_common_interface.h"
#include "uploader_mgr.h"
#include "collection_job.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::transport;
using DsmiReadFaultEventFunc = int32_t (*) (int32_t deviceId, int32_t timeout, struct dsmi_event_filter filter,
    struct dsmi_event *event);
static std::set<uint32_t> g_eventIdSet = {0x81AD8605, 0x81A38605, 0x81078605, 0x80E00209, 0x819B8605};

struct ProfFaultEvent {
    uint8_t severity;     /* 事件级别 0：提示，1：次要，2：重要，3：紧急 */
    uint8_t assertion;    /* 事件类型 0：故障恢复，1：故障产生，2：一次性事件 */
    uint16_t deviceId;    /* 设备ID */
    uint32_t eventId;     /* 事件ID */
    uint64_t reasonHash;  /* 故障原因 包含事件描述和附加信息 */
};

class MsprofDiagnostic : public analysis::dvvp::common::thread::Thread {
public:
    MsprofDiagnostic();
    ~MsprofDiagnostic() override;
    int32_t Start() override;
    void Run(const struct error_message::Context &errorContext) override;
    int32_t Stop() override;
    static bool IsTriggered();

protected:
    void PostStopReplay();
    void EventHandler(struct dsmi_event *event) const;
    void DumpData(dms_fault_event dmsEvent) const;
    void DataTransport(MsprofAdditionalInfo &additionalInfo) const;

protected:
    VOID_PTR drvDsmiLibHandle_{nullptr};
    DsmiReadFaultEventFunc dsmiReadFaultEvent_{nullptr};
    static bool isTriggered_;
    static std::mutex dataMtx_;
};

class ProfDiagnostic : public ICollectionJob {
public:
    ProfDiagnostic();
    ~ProfDiagnostic() override {}
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;

private:
    SHARED_PTR_ALIA<MsprofDiagnostic> diagnostic_;
};

} // JobWrapper
} // Dvvp
} // Analysis
#endif