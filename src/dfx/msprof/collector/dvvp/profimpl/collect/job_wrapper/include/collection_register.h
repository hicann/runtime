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

#include <memory>
#include "collection_job.h"
#include "singleton/singleton.h"
#include "utils/utils.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
static const std::string COLLECTION_JOB_FILENAME[NR_MAX_COLLECTION_JOB] = {
    "data/ddr.data",
    "data/hbm.data",
    "data/llc.data",
    "data/dvpp.data",
    "data/nic.data",
    "data/pcie.data",
    "data/hccs.data",
    "data/ub.data",
    "data/roce.data",
    "data/npu_mem.app",
    "data/npu_mem.data",
    "data/npu_module_mem.data",
    "data/lpmFreqConv.data",
    "data/qos.data",
    "data/aicpu.data",
    "data/aicpu.data",
    "data/ccu",
    "data/ccu",
    "data/tscpu.data",
    "data/ts_track.data",
    "data/ts_track.aiv_data",
    "data/aicore.data",
    "data/aicore.data",
    "data/aiVectorCore.data",
    "data/aiVectorCore.data",
    "data/hwts.data",
    "data/hwts.aiv_data",
    "data/training_trace.data",
    "data/socpmu.data",
    "data/l2_cache.data",
    "data/stars_soc.data",
    "data/stars_block.data",
    "data/stars_soc_profile.data",
    "data/ffts_profile.data",
    "data/instr",
    "data/instr",  // acp biu perf job
    "data/adprof.data",
    "data/ai_ctrl_cpu.data",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
};

class CollectionRegisterMgr : public analysis::dvvp::common::singleton::Singleton<CollectionRegisterMgr> {
public:
    CollectionRegisterMgr();
    ~CollectionRegisterMgr() override;

    int32_t CollectionJobRegisterAndRun(int32_t devId,
                                    const ProfCollectionJobE jobTag,
                                    const SHARED_PTR_ALIA<ICollectionJob> job);
    int32_t CollectionJobRun(int32_t devId, const ProfCollectionJobE jobTag);
    int32_t CollectionJobUnregisterAndStop(int32_t devId, const ProfCollectionJobE jobTag);

private:
    bool CheckCollectionJobIsNoRegister(int32_t &devId, const ProfCollectionJobE jobTag) const;
    bool InsertCollectionJob(int32_t devId, const ProfCollectionJobE jobTag, const SHARED_PTR_ALIA<ICollectionJob> job);
    bool GetAndDelCollectionJob(int32_t devId, const ProfCollectionJobE jobTag, SHARED_PTR_ALIA<ICollectionJob> &job);

    std::map<int32_t, std::map<ProfCollectionJobE, SHARED_PTR_ALIA<ICollectionJob>>> collectionJobs_;
    std::mutex collectionJobsMutex_;
};
}}}
#endif