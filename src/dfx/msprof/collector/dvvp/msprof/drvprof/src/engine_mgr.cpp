/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "engine_mgr.h"
#include "error_code.h"
#include "msprof_dlog.h"
#include "utils.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;

namespace Msprof {
namespace Engine {
EngineMgr::EngineMgr()
{
}

EngineMgr::~EngineMgr()
{
}

/* *
 * @brief Init: Initialize an engine to profiling
 * @param [in] module: the module name
 * @param [in] engine: the profiling engine of user defined
 * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
 */
int32_t EngineMgr::Init(const std::string& module, CONST_ENGINE_INTF_PTR engine)
{
    std::lock_guard<std::mutex> lk(mtx_);
    if (module.find("DATA_PREPROCESS") == std::string::npos) {
        MSPROF_LOGE("Initialization failed, module %s is not supported", module.c_str());
        return PROFILING_FAILED;
    }

    if (!module.empty() && engine != nullptr) {
        auto iter = engines_.find(module); // check whether the module has been init
        if (iter == engines_.end()) {
            engines_[module] = const_cast<EngineIntf *>(engine); // add the engine into the map
            MSPROF_LOGI("Initialized module %s successfully.", module.c_str());
            return PROFILING_SUCCESS;
        } else {
            MSPROF_LOGE("Module %s has been initialized, cannot initialize a module with the same name.",
                        module.c_str());
        }
    }
    return PROFILING_FAILED;
}

/* *
 * @brief UnInit: De-initialize the engine to profiling
 * @param [in] module: the module name
 * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
 */
int32_t EngineMgr::UnInit(const std::string &module)
{
    std::lock_guard<std::mutex> lk(mtx_); // lock
    if (!module.empty()) {
        auto iter = engines_.find(module); // check whether the module has been init
        if (iter != engines_.end()) {
            engines_.erase(iter); // Remove engines_ [module] from the map
            MSPROF_LOGI("UnInit module %s successfully.", module.c_str());
            return PROFILING_SUCCESS;
        } else {
            MSPROF_LOGE("Module %s has been de-initialized.", module.c_str());
        }
    }
    return PROFILING_FAILED;
}

/**
* @brief ProfStart: according the module name to start the engine, it will create a reporter for user
* @param [in] module: the module name
* @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
*/
int32_t EngineMgr::ProfStart(const std::string& module)
{
    std::lock_guard<std::mutex> lk(mtx_);
    int32_t ret = PROFILING_FAILED;
    auto job = jobs_.find(module); // check whether the module has been inserted into the jobs_
    if (job == jobs_.end()) {
        auto iter = engines_.find(module); // get the engine according the name
        if (iter != engines_.end()) {
            auto engine = iter->second;
            SHARED_PTR_ALIA<ModuleJob> mJob;
            MSVP_MAKE_SHARED2(mJob, ModuleJob, module, *engine, return PROFILING_FAILED);
            jobs_[module] = mJob; // insert the module into the jobs_
            ret = mJob->ProfStart();
        } else {
            MSPROF_LOGE("Cannot find the module:%s in engines_", module.c_str());
        }
    } else {
        MSPROF_LOGE("Find the module:%s in jobs_", module.c_str());
    }
    return ret;
}

/* *
 * @brief ProfConfig: according the config msg to config the engine
 * @param [in] module: the module name
 * @param [in] config: the config info from FMK
 * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
 */
int32_t EngineMgr::ProfConfig(const std::string &module,
                          const SHARED_PTR_ALIA<ProfilerJobConfig> &config)
{
    std::lock_guard<std::mutex> lk(mtx_);
    int32_t ret = PROFILING_FAILED;
    auto job = jobs_.find(module);
    if (job != jobs_.end()) {
        SHARED_PTR_ALIA<ModuleJob> mJob = job->second;
        if (mJob != nullptr) {
            ret = mJob->ProfConfig(config); // start to config the module
        } else {
            MSPROF_LOGE("job->sencod is nullptr");
        }
    } else {
        MSPROF_LOGE("Cannot find the module:%s in jobs_", module.c_str());
    }
    return ret;
}

/* *
 * @brief ProfStop: according the module name to stop the engine, it's the inverse process of ProfStart
 * @param [in] module: the module name
 * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
 */
int32_t EngineMgr::ProfStop(const std::string &module)
{
    std::lock_guard<std::mutex> lk(mtx_);
    int32_t ret = PROFILING_FAILED;
    auto job = jobs_.find(module);
    if (job != jobs_.end()) {
        SHARED_PTR_ALIA<ModuleJob> mJob = job->second;
        if (mJob != nullptr) {
            ret = mJob->ProfStop(); // stop the module
        } else {
            MSPROF_LOGE("job->second is nullptr");
        }
        jobs_.erase(job); // delete the module from the jobs_
    } else {
        MSPROF_LOGE("cannot find the module:%s in jobs_", module.c_str());
    }
    return ret;
}

/* *
 * @brief ConfigHandler: call ProfConfig to config the module, it's a call back function for ConfigMgr
 * @param [in] module: the module name
 * @param [in] config: the config info from FMK
 * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
 */
int32_t EngineMgr::ConfigHandler(const std::string &module,
                             const SHARED_PTR_ALIA<ProfilerJobConfig> &config)
{
    if (module.empty() || config == nullptr) {
        MSPROF_LOGE("Input parameter is error, module name is empty or config is nullptr");
        return PROFILING_FAILED;
    }
    return EngineMgr::instance()->ProfConfig(module, config);
}

/* *
 * @brief Init: the API for user to init engine and auto start the engine
 * @param [in] module: the module name
 * @param [in] engine: the user self-defined engine
 * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
 */
int32_t Init(const std::string &module, CONST_ENGINE_INTF_PTR engine)
{
    if (!module.empty() && engine != nullptr) {
        MSPROF_EVENT("[Init]Received request to init engine %s", module.c_str());
        if (EngineMgr::instance()->Init(module, engine) == PROFILING_SUCCESS) {
            return EngineMgr::instance()->ProfStart(module);
        } else {
            MSPROF_LOGE("EngineMgr::Init failed");
        }
    } else {
        MSPROF_LOGE("Initialization engine failed, module name is empty or engine is nullptr");
    }
    return PROFILING_FAILED;
}

/* *
 * @brief UnInit: the API for user to uninit engine
 * @param [in] module: the module name
 * @return : success return UNPROFILING_SUCCESS, failed return UNPROFIING_FAILED
 */
int32_t UnInit(const std::string &module)
{
    int32_t ret = PROFILING_SUCCESS;
    if (!module.empty()) {
        MSPROF_EVENT("[UnInit]Received request to uninit engine %s", module.c_str());
        if (EngineMgr::instance()->ProfStop(module) == PROFILING_FAILED) {
            ret = PROFILING_FAILED;
        }
        if (EngineMgr::instance()->UnInit(module) == PROFILING_FAILED) {
            ret = PROFILING_FAILED;
        }
        if (ret == PROFILING_FAILED) {
            MSPROF_LOGE("EngineMgr::UnInit failed");
        }
    } else {
        MSPROF_LOGE("Failed to UnInit the engine, module name is empty or engine is nullptr");
        ret = PROFILING_FAILED;
    }
    return ret;
}
} // namespace Engine
} // namespace Msprof
