/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSPROF_ENGINE_ENGINE_MGR_H
#define MSPROF_ENGINE_ENGINE_MGR_H

#include <map>
#include <memory>
#include <string>
#include "module_job.h"
#include "prof_engine.h"
#include "singleton/singleton.h"

namespace Msprof {
namespace Engine {
using CONST_ENGINE_INTF_PTR = const EngineIntf *;
class EngineMgr : public analysis::dvvp::common::singleton::Singleton<EngineMgr> {
public:
    EngineMgr();
    ~EngineMgr() override;

public:
    /**
    * @brief Init: Initialize an engine to profiling
    * @param [in] module: the module name
    * @param [in] engine: the profiling engine of user defined
    * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
    */
    int32_t Init(const std::string& module, CONST_ENGINE_INTF_PTR engine);

    /**
    * @brief UnInit: De-initialize the engine to profiling
    * @param [in] module: the module name
    * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
    */
    int32_t UnInit(const std::string& module);

    /**
    * @brief ProfStart: according the module name to start the engine, it will create a reporter for user
    * @param [in] module: the module name
    * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
    */
    int32_t ProfStart(const std::string& module);

    /**
    * @brief ProfStop: according the module name to stop the engine, it's the inverse process of ProfStart
    * @param [in] module: the module name
    * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
    */
    int32_t ProfStop(const std::string& module);

private:
    /**
    * @brief ProfConfig: according the config msg to config the engine
    * @param [in] module: the module name
    * @param [in] config: the config info from FMK
    * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
    */
    int32_t ProfConfig(const std::string& module,
                   const SHARED_PTR_ALIA<ProfilerJobConfig>& config);

    /**
    * @brief ConfigHandler: call ProfConfig to config the module, it's a call back function for ConfigMgr
    * @param [in] module: the module name
    * @param [in] config: the config info from FMK
    * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
    */
    static int32_t ConfigHandler(const std::string &module,
                             const SHARED_PTR_ALIA<ProfilerJobConfig> &config);

private:
    std::map<std::string, EngineIntf *> engines_; // the map of module name and engine
    std::map<std::string, SHARED_PTR_ALIA<ModuleJob>> jobs_; // the map of module name and job
    std::mutex mtx_;
};
}}
#endif
