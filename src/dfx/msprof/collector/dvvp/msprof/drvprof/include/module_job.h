/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSPROF_ENGINE_MODULE_JOB_H
#define MSPROF_ENGINE_MODULE_JOB_H

#include <map>
#include <string>
#include "prof_engine.h"
#include "data_dumper.h"

namespace Msprof {
namespace Engine {
struct ModuleConfig {
    std::map<std::string, std::string> switches;
};
struct ProfilerJobConfig {
    std::map<std::string, ModuleConfig> modules;
};
class ModuleJob {
public:
    /**
    * @brief ModuleJob: the construct function
    * @param [in] module: the name of the module
    * @param [in] engine: the engine of user
    */
    ModuleJob(const std::string& module, EngineIntf &engine);
    virtual ~ModuleJob();

public:
    /**
    * @brief ProfStart: create a Reporter according the platform  and create a plugin with the API of engine,
    *                   then init the plugin with the new reporter
    * @param [in] taskId: the task id created by EngineMgr, only for host
    * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
    */
    int32_t ProfStart();

    /**
    * @brief ProfConfig: config the plugin of user self-defined
    * @param [in] config: config info from FMK
    * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
    */
    int32_t ProfConfig(const SHARED_PTR_ALIA<ProfilerJobConfig>& config);

    /**
    * @brief ProfStop: stop the plugin of user self-defined, then stop and reset the reporter
    * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
    */
    int32_t ProfStop();

private:
    /**
    * @brief StartPlugin: create a plugin with engine, then init the plugin with a new Reporter
    * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
    */
    int32_t StartPlugin();

    /**
    * @brief StopPlugin: stop the plugin, then call the engine API to release the plugin
    * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
    */
    int32_t StopPlugin();

    SHARED_PTR_ALIA<DataDumper> CreateDumper(const std::string& module) const;

private:
    std::string module_; // module name
    EngineIntf *engine_; // engine of user defined
    PluginIntf *plugin_; // the plugin create with API of engine
    volatile bool isStarted_; // whether the module has been started
    // for host,  API for save data to local disk by FileDumper
    // for device, API for send data to host by StreamDumper
    SHARED_PTR_ALIA<Msprof::Engine::DataDumper> reporter_;
};
}}
#endif
