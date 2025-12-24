/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_JOB_WRAPPER_PROF_PERF_H
#define ANALYSIS_DVVP_JOB_WRAPPER_PROF_PERF_H
#include "prof_comm_job.h"
#include "message/message.h"
#include "memory/chunk_pool.h"
#include "thread/thread.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
class PerfExtraTask : public analysis::dvvp::common::thread::Thread {
public:
    PerfExtraTask(uint32_t bufSize, const std::string &retDir,
                  SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx,
                  SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param);
    ~PerfExtraTask() override;
    void SetJobCtx(SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx);
    int32_t Init();
    int32_t UnInit();

private:
    void Run(const struct error_message::Context &errorContext) override;
    void PerfScriptTask();
    void ResolvePerfRecordData(const std::string &fileName) const;
    void StoreData(const std::string &fileName);

private:
    volatile bool isInited_;
    long long dataSize_;
    std::string retDir_;
    analysis::dvvp::common::memory::Chunk buf_;
    SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx_;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> param_;
};

class ProfCtrlcpuJob : public ICollectionJob {
public:
    ProfCtrlcpuJob();
    ~ProfCtrlcpuJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;
    bool IsGlobalJobLevel() override
    {
        return true;
    }
private:
    int32_t GetCollectCtrlCpuEventCmd(const std::vector<std::string> &events, std::string &profCtrlcpuCmd);
    int32_t PrepareDataDir(std::string &cpuDataFile);

private:
    OsalProcess ctrlcpuProcess_;
    SHARED_PTR_ALIA<CollectionJobCfg> collectionJobCfg_;
    SHARED_PTR_ALIA<PerfExtraTask> perfExtraTask_;
};

class ProfAicpuHscbJob : public ProfPeripheralJob {
public:
    ProfAicpuHscbJob();
    ~ProfAicpuHscbJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;
 
private:
    int32_t GetAicpuHscbCmd(int32_t devId, const std::vector<std::string> &events,
        std::string &hscbCmd) const;
    void SendData() const;
    void SendPerfTimeData() const;
 
private:
    OsalProcess hscbProcess_;
    SHARED_PTR_ALIA<CollectionJobCfg> collectionJobCfg_;
    uint64_t deviceMonotonic_;
    uint64_t deviceSysCnt_;
};
}
}
}

#endif