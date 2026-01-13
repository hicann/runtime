/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_JOB_WRAPPER_COLLECTION_JOB_H
#define ANALYSIS_DVVP_JOB_WRAPPER_COLLECTION_JOB_H
#include <memory>
#include <map>
#include <functional>
#include "message/prof_params.h"
#include "ai_drv_prof_api.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
enum ProfCollectionJobE {
    DDR_DRV_COLLECTION_JOB = 0,
    HBM_DRV_COLLECTION_JOB,
    LLC_DRV_COLLECTION_JOB,
    DVPP_COLLECTION_JOB,
    NIC_COLLECTION_JOB,
    PCIE_DRV_COLLECTION_JOB,
    HCCS_DRV_COLLECTION_JOB,
    UB_DRV_COLLECTION_JOB,
    ROCE_DRV_COLLECTION_JOB,
    NETDEV_STATS_COLLECTION_JOB,
    APP_MEM_COLLECTION_JOB,
    DEV_MEM_COLLECTION_JOB,
    AISTACK_MEM_COLLECTION_JOB,
    LPM_FREQ_COLLECTION_JOB,
    QOS_COLLECTION_JOB,
    AICPU_COLLECTION_JOB,
    AI_CUSTOM_CPU_COLLECTION_JOB,
    CCU_INSTR_COLLECTION_JOB,
    CCU_STAT_COLLECTION_JOB,
    // ts
    TS_CPU_DRV_COLLECTION_JOB,
    TS_TRACK_DRV_COLLECTION_JOB,
    AIV_TS_TRACK_DRV_COLLECTION_JOB,
    AI_CORE_SAMPLE_DRV_COLLECTION_JOB,
    AI_CORE_TASK_DRV_COLLECTION_JOB,
    AIV_SAMPLE_DRV_COLLECTION_JOB,
    AIV_TASK_DRV_COLLECTION_JOB,
    HWTS_LOG_COLLECTION_JOB,
    AIV_HWTS_LOG_COLLECTION_JOB,
    FMK_COLLECTION_JOB,
    SOC_PMU_TASK_COLLECTION_JOB,
    L2_CACHE_TASK_COLLECTION_JOB,
    STARS_SOC_LOG_COLLECTION_JOB,
    STARS_BLOCK_LOG_COLLECTION_JOB,
    STARS_SOC_PROFILE_COLLECTION_JOB,
    FFTS_PROFILE_COLLECTION_JOB,
    INSTR_PROFILING_COLLECTION_JOB,
    BIU_PERF_COLLECTION_JOB,
    // system
    ADPROF_COLLECTION_JOB,
    CTRLCPU_PERF_COLLECTION_JOB,
    SYSSTAT_PROC_COLLECTION_JOB,
    SYSMEM_PROC_COLLECTION_JOB,
    ALLPID_PROC_COLLECTION_JOB,
    // host system
    HOST_CPU_COLLECTION_JOB,
    HOST_MEM_COLLECTION_JOB,
    HOST_ALL_PID_COLLECTION_JOB,
    HOST_NETWORK_COLLECTION_JOB,
    HOST_SYSCALLS_COLLECTION_JOB,
    HOST_PTHREAD_COLLECTION_JOB,
    HOST_DISKIO_COLLECTION_JOB,
    // diagnostic collection
    DIAGNOSTIC_COLLECTION_JOB,
    NR_MAX_COLLECTION_JOB
};

struct CollectionJobParams {
    int32_t coreNum;
    ProfCollectionJobE jobTag;
    std::string dataPath;
    SHARED_PTR_ALIA<std::vector<int32_t>> cores;
    SHARED_PTR_ALIA<std::vector<std::string>> events;
    SHARED_PTR_ALIA<std::vector<int32_t>> aivCores;
    SHARED_PTR_ALIA<std::vector<std::string>> aivEvents;
};

struct CollectionJobCommonParams {
    int32_t devId;
    int32_t devIdOnHost;
    int32_t devIdFlush;
    std::string tmpResultDir;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params;
    SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx;
};

struct CollectionJobCfg {
    CollectionJobParams jobParams;
    SHARED_PTR_ALIA<CollectionJobCommonParams> comParams;
};

class ICollectionJob;
struct CollectionJobT {
    CollectionJobT()
        : jobTag(NR_MAX_COLLECTION_JOB),
          jobCfg(nullptr),
          collectionJob(nullptr)
    {
    }
    Analysis::Dvvp::JobWrapper::ProfCollectionJobE jobTag;
    SHARED_PTR_ALIA<Analysis::Dvvp::JobWrapper::CollectionJobCfg> jobCfg;
    SHARED_PTR_ALIA<Analysis::Dvvp::JobWrapper::ICollectionJob> collectionJob;
};

class ICollectionJob {
public:
    ICollectionJob();
    ICollectionJob(int32_t collectionId, const std::string &name);
    virtual ~ICollectionJob();
    virtual int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) = 0;
    virtual int32_t Process() = 0;
    virtual int32_t Uninit() = 0;
    virtual bool IsGlobalJobLevel();
    virtual int32_t GetCollectionId();
    virtual std::string JobFileName();

    int32_t collectionId_;
    std::string fileName_;
};

class CollectionJobReflection {
public:
    template<typename T>
    static void RegisterCollectionJobClass(const int32_t collectionId)
    {
        collectionJobMap_[collectionId] = []() -> SHARED_PTR_ALIA<ICollectionJob> {
            return SHARED_PTR_ALIA<T>(new (std::nothrow)T);
        };
    }

    static SHARED_PTR_ALIA<ICollectionJob> CreateCollectionJob(const int32_t collectionId)
    {
        auto it = collectionJobMap_.find(collectionId);
        if (it != collectionJobMap_.end()) {
            return it->second();
        }
        return nullptr;
    }

private:
    // <collection id, function of collection job>
    static std::map<int32_t, std::function<SHARED_PTR_ALIA<ICollectionJob>()>> collectionJobMap_;
};

template<typename T>
class CollectionJobRegister {
public:
    explicit CollectionJobRegister(const int32_t collectionId)
    {
        CollectionJobReflection::RegisterCollectionJobClass<T>(collectionId);
    }
};

#define COLLECTION_JOB_REGISTER(collectionId, collectionJob) \
    CollectionJobRegister<collectionJob> g_##collectionJob##collectionId(collectionId)

}
}
}
#endif