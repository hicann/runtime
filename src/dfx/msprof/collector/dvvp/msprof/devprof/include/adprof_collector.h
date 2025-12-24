/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADPROF_COLLECTOR_H
#define ADPROF_COLLECTOR_H
#include <map>
#include <string>
#include "singleton/singleton.h"
#include "utils/utils.h"
#include "collection_job.h"
#include "prof_dev_api.h"

class AdprofCollector : public analysis::dvvp::common::singleton::Singleton<AdprofCollector> {
public:
    AdprofCollector();
    ~AdprofCollector() override;
public:
    int32_t Init(std::map<std::string, std::string> &keyValuePairs);
    int32_t UnInit();
    int32_t StartCollectJob();
    int32_t GetProfilingPeriod();
    bool AdprofStarted() const;
    int32_t Report(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk) const;
    std::vector<analysis::dvvp::ProfileFileChunk> SpilitChunk(
        analysis::dvvp::ProfileFileChunk& fileChunk, const uint32_t chunkMaxLen) const;
    template<typename T>
    void ModifyParam(T& paramNeedModify, const std::string& key)
    {
        FUNRET_CHECK_EXPR_ACTION_LOGW(keyValuePairs_.count(key) == 0, return,
            "adprof kvPairs missing key: %s", key.c_str());
        std::string value = keyValuePairs_[key];
        std::istringstream iss(value);
        if (std::is_same<T, int32_t>::value) {
            int32_t intVal = 0;
            FUNRET_CHECK_EXPR_ACTION_LOGW(!analysis::dvvp::common::utils::Utils::StrToInt32(intVal, value),
                return, "adprof kvPairs %s: '%s' is invalid", key.c_str(), value.c_str());
            paramNeedModify = intVal;
        } else if (std::is_same<T, std::string>::value) {
            T val;
            iss >> val;
            paramNeedModify = val;
        } else {
            MSPROF_LOGW("adprof unsupported value : %s", value.c_str());
        }
    }
private:
    SHARED_PTR_ALIA<Analysis::Dvvp::JobWrapper::CollectionJobCfg> MakeCfg() const;
    void CollectCtrlCpu(SHARED_PTR_ALIA<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg);
    void CollectAicpuHscbJob(SHARED_PTR_ALIA<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg);
    void CollectAllPidsJob(SHARED_PTR_ALIA<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg);
    void CollectSysJob(SHARED_PTR_ALIA<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg);
    void CollectSysStatJob(SHARED_PTR_ALIA<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg);
    void CollectSysMemJob(SHARED_PTR_ALIA<Analysis::Dvvp::JobWrapper::CollectionJobCfg> collectionJobCfg);
private:
    std::map<std::string, std::string> keyValuePairs_;
    std::mutex mtx_;
    bool started_;
    std::vector<SHARED_PTR_ALIA<Analysis::Dvvp::JobWrapper::ICollectionJob>> jobs_;
};

extern "C" MSVP_PROF_API bool GetIsExit(void);
#endif