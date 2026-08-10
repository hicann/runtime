/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_JOB_WRAPPER_COLLECTION_REGISTER_H
#define ANALYSIS_DVVP_JOB_WRAPPER_COLLECTION_REGISTER_H

#include <array>
#include <memory>
#include "collection_job.h"
#include "singleton/singleton.h"
#include "utils/utils.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
static const std::array<std::string, NR_MAX_COLLECTION_JOB> COLLECTION_JOB_FILENAME = []() {
    std::array<std::string, NR_MAX_COLLECTION_JOB> fileNames = {};
    fileNames[DDR_DRV_COLLECTION_JOB] = "data/ddr.data";
    fileNames[HBM_DRV_COLLECTION_JOB] = "data/hbm.data";
    fileNames[LLC_DRV_COLLECTION_JOB] = "data/llc.data";
    fileNames[DVPP_COLLECTION_JOB] = "data/dvpp.data";
    fileNames[NIC_COLLECTION_JOB] = "data/nic.data";
    fileNames[PCIE_DRV_COLLECTION_JOB] = "data/pcie.data";
    fileNames[HCCS_DRV_COLLECTION_JOB] = "data/hccs.data";
    fileNames[UB_DRV_COLLECTION_JOB] = "data/ub.data";
    fileNames[ROCE_DRV_COLLECTION_JOB] = "data/roce.data";
    fileNames[NETDEV_STATS_COLLECTION_JOB] = "data/netdev_stats.data";
    fileNames[APP_MEM_COLLECTION_JOB] = "data/npu_mem.app";
    fileNames[DEV_MEM_COLLECTION_JOB] = "data/npu_mem.data";
    fileNames[AISTACK_MEM_COLLECTION_JOB] = "data/npu_module_mem.data";
    fileNames[LPM_FREQ_COLLECTION_JOB] = "data/lpmFreqConv.data";
    fileNames[QOS_COLLECTION_JOB] = "data/qos.data";
    fileNames[AICPU_COLLECTION_JOB] = "data/aicpu.data";
    fileNames[AI_CUSTOM_CPU_COLLECTION_JOB] = "data/aicpu.data";
    fileNames[CCU_INSTR_COLLECTION_JOB] = "data/ccu";
    fileNames[CCU_STAT_COLLECTION_JOB] = "data/ccu";
    fileNames[TS_CPU_DRV_COLLECTION_JOB] = "data/tscpu.data";
    fileNames[TS_TRACK_DRV_COLLECTION_JOB] = "data/ts_track.data";
    fileNames[AIV_TS_TRACK_DRV_COLLECTION_JOB] = "data/ts_track.aiv_data";
    fileNames[AI_CORE_SAMPLE_DRV_COLLECTION_JOB] = "data/aicore.data";
    fileNames[AI_CORE_TASK_DRV_COLLECTION_JOB] = "data/aicore.data";
    fileNames[AIV_SAMPLE_DRV_COLLECTION_JOB] = "data/aiVectorCore.data";
    fileNames[AIV_TASK_DRV_COLLECTION_JOB] = "data/aiVectorCore.data";
    fileNames[HWTS_LOG_COLLECTION_JOB] = "data/hwts.data";
    fileNames[AIV_HWTS_LOG_COLLECTION_JOB] = "data/hwts.aiv_data";
    fileNames[FMK_COLLECTION_JOB] = "data/training_trace.data";
    fileNames[SOC_PMU_TASK_COLLECTION_JOB] = "data/socpmu.data";
    fileNames[L2_CACHE_TASK_COLLECTION_JOB] = "data/l2_cache.data";
    fileNames[STARS_SOC_LOG_COLLECTION_JOB] = "data/stars_soc.data";
    fileNames[STARS_BLOCK_LOG_COLLECTION_JOB] = "data/stars_block.data";
    fileNames[STARS_SOC_PROFILE_COLLECTION_JOB] = "data/stars_soc_profile.data";
    fileNames[FFTS_PROFILE_COLLECTION_JOB] = "data/ffts_profile.data";
    fileNames[INSTR_PROFILING_COLLECTION_JOB] = "data/instr";
    fileNames[BIU_PERF_COLLECTION_JOB] = "data/instr";
    fileNames[ADPROF_COLLECTION_JOB] = "data/adprof.data";
    fileNames[CTRLCPU_PERF_COLLECTION_JOB] = "data/ai_ctrl_cpu.data";
    fileNames[NTS_PMU_COLLECTION_JOB] = "data/nts_pmu.data";
    fileNames[NTS_TASK_COLLECTION_JOB] = "data/nts_task.data";
    return fileNames;
}();

class CollectionRegisterMgr : public analysis::dvvp::common::singleton::Singleton<CollectionRegisterMgr> {
public:
    CollectionRegisterMgr();
    ~CollectionRegisterMgr() override;

    int32_t CollectionJobRegisterAndRun(
        int32_t devId, const ProfCollectionJobE jobTag, const SHARED_PTR_ALIA<ICollectionJob> job);
    int32_t CollectionJobRun(int32_t devId, const ProfCollectionJobE jobTag);
    int32_t CollectionJobUnregisterAndStop(int32_t devId, const ProfCollectionJobE jobTag);

private:
    bool CheckCollectionJobIsNoRegister(int32_t& devId, const ProfCollectionJobE jobTag) const;
    bool InsertCollectionJob(int32_t devId, const ProfCollectionJobE jobTag, const SHARED_PTR_ALIA<ICollectionJob> job);
    bool GetAndDelCollectionJob(int32_t devId, const ProfCollectionJobE jobTag, SHARED_PTR_ALIA<ICollectionJob>& job);

    std::map<int32_t, std::map<ProfCollectionJobE, SHARED_PTR_ALIA<ICollectionJob>>> collectionJobs_;
    std::mutex collectionJobsMutex_;
};
} // namespace JobWrapper
} // namespace Dvvp
} // namespace Analysis
#endif
