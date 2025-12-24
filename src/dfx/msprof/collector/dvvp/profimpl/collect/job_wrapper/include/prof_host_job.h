/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_JOB_WRAPPER_PROF_HOST_JOB_H
#define ANALYSIS_DVVP_JOB_WRAPPER_PROF_HOST_JOB_H

#include "prof_timer.h"
#include "collection_register.h"
#include "osal.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
enum HostTimerHandlerTag {
    PROF_HOST_SYS_CALL = 0,
    PROF_HOST_SYS_PTHREAD,
    PROF_HOST_SYS_DISK,
    PROF_HOST_MAX_TAG
};

static const std::string PROF_HOST_TOOL_NAME[PROF_HOST_MAX_TAG] = {
    "perf",
    "ltrace",
    "iotop"
};

const std::string PROF_HOST_OUTDATA[PROF_HOST_MAX_TAG] = {
    "data/host_syscall.data",
    "data/host_pthreadcall.data",
    "data/host_disk.data"
};

struct ProfHostWriteDoneInfo {
    std::string fileSize;
    std::string startTime;
    std::string endTime;
};

constexpr uint32_t PROC_HOST_PROC_DATA_BUF_SIZE = (1 << 13); // 1 << 13  means 8k

// task interface
class ProfHostDataBase : public ICollectionJob {
public:
    ProfHostDataBase() : sampleIntervalNs_(0)
    {
    }
    ~ProfHostDataBase() override {}
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Uninit() override;
    int32_t CheckHostProfiling(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) const;

protected:
    SHARED_PTR_ALIA<CollectionJobCfg> collectionJobCfg_;
    SHARED_PTR_ALIA<analysis::dvvp::transport::Uploader> upLoader_;
    unsigned long long sampleIntervalNs_;
};

class ProfHostCpuJob : public ProfHostDataBase {
public:
    ProfHostCpuJob();
    ~ProfHostCpuJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;
    bool IsGlobalJobLevel() override
    {
        return true;
    }
};

class ProfHostMemJob : public ProfHostDataBase {
public:
    ProfHostMemJob();
    ~ProfHostMemJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;
    bool IsGlobalJobLevel() override
    {
        return true;
    }
};

class ProfHostAllPidJob : public ProfHostDataBase {
public:
    ProfHostAllPidJob();
    ~ProfHostAllPidJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;
    bool IsGlobalJobLevel() override
    {
        return true;
    }
private:
    TimerHandlerTag tag_ = PROF_NONE;
};

class ProfHostNetworkJob : public ProfHostDataBase {
public:
    ProfHostNetworkJob();
    ~ProfHostNetworkJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;
    bool IsGlobalJobLevel() override
    {
        return true;
    }
};

class ProfHostService : public analysis::dvvp::common::thread::Thread {
public:
    ProfHostService();
    ~ProfHostService() override;
public:
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg,
                const HostTimerHandlerTag hostTimerTag);
    int32_t Process();
    int32_t Uninit();
    int32_t Start() override;
    int32_t Stop() override;

public:
    void WakeupTimeoutEnd();
    void WaitTimeoutEnd();

protected:
    volatile bool isStarted_{false};

private:
    void Run(const struct error_message::Context &errorContext) override;
    int32_t Handler();
    void StoreData() const;
    int32_t GetCollectSysCallsCmd(int32_t pid, std::string &profHostCmd);
    int32_t GetCollectPthreadsCmd(int32_t pid, std::string &profHostCmd);
    int32_t GetCollectIOTopCmd(int32_t pid, std::string &profHostCmd);
    int32_t GetCmdStr(int32_t hostSysPid, std::string &profHostCmd);
    int32_t CollectToolIsRun();
    int32_t WaitCollectToolStart();
    int32_t WaitCollectToolEnd();
    void PrintFileContent(const std::string filePath) const;
    int32_t KillToolAndWaitHostProcess() const;

private:
    std::string profHostOutDir_;
    std::string toolName_;
    HostTimerHandlerTag hostTimerTag_;
    OsalProcess hostProcess_;
    SHARED_PTR_ALIA<CollectionJobCfg> collectionJobCfg_;
    struct ProfHostWriteDoneInfo hostWriteDoneInfo_;
    std::mutex needUnintMtx_;
    std::condition_variable isJobUnint_;
    std::string startProcessCmd_;
};

class ProfHostSysCallsJob : public ProfHostDataBase {
public:
    ProfHostSysCallsJob();
    ~ProfHostSysCallsJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;

private:
    SHARED_PTR_ALIA<ProfHostService> profHostService_{nullptr};
};

class ProfHostPthreadJob : public ProfHostDataBase {
public:
    ProfHostPthreadJob();
    ~ProfHostPthreadJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;

private:
    SHARED_PTR_ALIA<ProfHostService> profHostService_{nullptr};
};

class ProfHostDiskJob : public ProfHostDataBase {
public:
    ProfHostDiskJob();
    ~ProfHostDiskJob() override;
    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;

private:
    SHARED_PTR_ALIA<ProfHostService> profHostService_{nullptr};
};
}}}
#endif
