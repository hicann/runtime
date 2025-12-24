/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "collection_register.h"
namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::error;
CollectionRegisterMgr::CollectionRegisterMgr()
{
}

CollectionRegisterMgr::~CollectionRegisterMgr()
{
    collectionJobs_.clear();
}

/**
 * @berif  : jugde the job is exist or not
 * @param  : [in] devId   : device id
 * @param  : [in] jobTag : collection job Tag
 * @return : true : exist Job; false : not exist Job
 */
bool CollectionRegisterMgr::CheckCollectionJobIsNoRegister(int32_t &devId, const ProfCollectionJobE jobTag) const
{
    if (devId < 0 || jobTag >= NR_MAX_COLLECTION_JOB) {
        return false;
    }
    // GLOBAL LEVEL
    for (auto iter = collectionJobs_.begin(); iter != collectionJobs_.end(); ++iter) {
        auto it = iter->second.find(jobTag);
        if (it != iter->second.end() && it->second->IsGlobalJobLevel()) {
            devId = iter->first;
            MSPROF_LOGW("IsGlobalJobLevel, devId:%d jobTag:%d", iter->first, jobTag);
            return false;
        }
    }

    // DEVICE LEVEL
    auto iter = collectionJobs_.find(devId);
    if (iter == collectionJobs_.end()) {
        return true;
    }

    auto it = iter->second.find(jobTag);
    if (it == iter->second.end() || it->second == nullptr) {
        return true;
    }

    return false;
}

/**
 * @berif  : register the job and run the job
 * @param  : [in] devId   : device id
 * @param  : [in] jobTag : collection job Tag
 * @return : true : exist Job; false : not exist Job
 */
int32_t CollectionRegisterMgr::CollectionJobRegisterAndRun(int32_t devId,
    const ProfCollectionJobE jobTag, const SHARED_PTR_ALIA<ICollectionJob> job)
{
    if (devId < 0 || jobTag >= NR_MAX_COLLECTION_JOB || job == nullptr) {
        return PROFILING_FAILED;
    }
    std::lock_guard<std::mutex> lk(collectionJobsMutex_);
    if (InsertCollectionJob(devId, jobTag, job)) {
        MSPROF_LOGD("Collection Job Registeter, devId:%d jobTag:%d", devId, jobTag);
        return job->Process();
    }

    return PROFILING_FAILED;
}

int32_t CollectionRegisterMgr::CollectionJobRun(int32_t devId, const ProfCollectionJobE jobTag)
{
    if (devId < 0 || jobTag >= NR_MAX_COLLECTION_JOB) {
        return PROFILING_FAILED;
    }

    std::unique_lock<std::mutex> lk(collectionJobsMutex_);
    if (collectionJobs_.find(devId) == collectionJobs_.end() ||
        collectionJobs_[devId].find(jobTag) == collectionJobs_[devId].end()) {
        MSPROF_LOGI("Collection job not registeter, devId:%d jobTag:%d", devId, jobTag);
        return PROFILING_FAILED;
    }
    return collectionJobs_[devId][jobTag]->Process();
}

/**
 * @berif  : unregister the job and uninit the job
 * @param  : [in] devId   : device id
 * @param  : [in] jobTag : collection job Tag
 * @return : true : exist Job; false : not exist Job
 */
int32_t CollectionRegisterMgr::CollectionJobUnregisterAndStop(int32_t devId, const ProfCollectionJobE jobTag)
{
    if (devId < 0 || jobTag >= NR_MAX_COLLECTION_JOB) {
        return PROFILING_FAILED;
    }
    SHARED_PTR_ALIA<ICollectionJob> job = nullptr;
    std::unique_lock<std::mutex> lk(collectionJobsMutex_, std::defer_lock);
    lk.lock();
    const bool ret = GetAndDelCollectionJob(devId, jobTag, job);
    lk.unlock();
    if (ret) {
        MSPROF_LOGD("Collection Job Unregisteter, devId:%d jobTag:%d", devId, jobTag);
        if (job != nullptr) {
            return job->Uninit();
        }
    }

    return PROFILING_FAILED;
}

/**
 * @berif  : insert collection job
 * @param  : [in] devId   : device id
 * @param  : [in] jobTag : collection job Tag
 * @param  : [in] SHARED_PTR_ALIA<ICollectionJob> job : collection job
 * @return : true : exist Job; false : not exist Job
 */
bool CollectionRegisterMgr::InsertCollectionJob(int32_t devId,
    const ProfCollectionJobE jobTag, const SHARED_PTR_ALIA<ICollectionJob> job)
{
    if (devId < 0 || jobTag >= NR_MAX_COLLECTION_JOB || job == nullptr) {
        return false;
    }
    std::map<ProfCollectionJobE, SHARED_PTR_ALIA<ICollectionJob>> colJob;
    // no register
    if (CheckCollectionJobIsNoRegister(devId, jobTag)) {
        const auto iter = collectionJobs_.find(devId);
        if (iter != collectionJobs_.end()) {
            colJob = collectionJobs_[devId];
        }

        colJob[jobTag] = job;
        collectionJobs_[devId] = colJob;
        return true;
    }

    return false;
}

/**
 * @berif  : get collection job and delete the job
 * @param  : [in] devId   : device id
 * @param  : [in] jobTag : collection job Tag
 * @param  : [out] SHARED_PTR_ALIA<ICollectionJob> job : collection job
 * @return : true : exist Job; false : not exist Job
 */
bool CollectionRegisterMgr::GetAndDelCollectionJob(int32_t devId,
    const ProfCollectionJobE jobTag, SHARED_PTR_ALIA<ICollectionJob> &job)
{
    if (devId < 0 || jobTag >= NR_MAX_COLLECTION_JOB) {
        return false;
    }

    int32_t checkId = devId;
    if (!CheckCollectionJobIsNoRegister(checkId, jobTag) && checkId == devId) {
        auto collectionJob = collectionJobs_[devId];
        job = collectionJob[jobTag];
        (void)collectionJob.erase(jobTag);
        collectionJobs_[devId] = collectionJob;
        return true;
    }

    return false;
}
}}}
