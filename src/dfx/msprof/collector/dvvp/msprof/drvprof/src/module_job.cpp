/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "module_job.h"
#include "error_code.h"
#include "msprof_dlog.h"
#include "utils.h"
#include "data_dumper.h"
#include "rpc_dumper.h"

using namespace analysis::dvvp::common::error;

namespace Msprof {
namespace Engine {
/* *
 * @brief ModuleJob: the construct function
 * @param [in] module: the name of the module
 * @param [in] engine: the engine of user
 */
ModuleJob::ModuleJob(const std::string& module, EngineIntf &engine)
    : module_(module), engine_(&engine), plugin_(nullptr), isStarted_(false)
{
}

ModuleJob::~ModuleJob()
{
    ProfStop(); // stop the module first
}

/* *
 * @brief StartPlugin: create a plugin with engine, then init the plugin with a new Reporter
 * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
 */
int32_t ModuleJob::StartPlugin()
{
    plugin_ = engine_->CreatePlugin();
    if (plugin_ != nullptr) {
        if (plugin_->Init(reporter_.get()) == PROFILING_SUCCESS) {
            isStarted_ = true;
            MSPROF_LOGI("Plug-in started successfully, module is %s", module_.c_str());
            return PROFILING_SUCCESS;
        } else {
            MSPROF_LOGE("Plugin Init failed, please check the plugin code");
            if (engine_->ReleasePlugin(plugin_) != PROFILING_SUCCESS) {
                MSPROF_LOGE("Engine ReleasePlugin failed, please check the plugin code");
            } else {
                plugin_ = nullptr;
                MSPROF_LOGI("Engine ReleasePlugin successfully.");
            }
        }
    } else {
        MSPROF_LOGE("Engine CreatePlugin failed, please check the plugin code");
    }
    return PROFILING_FAILED;
}

/* *
 * @brief ProfStart: create a Reporter according the platform  and create a plugin with the API of engine,
 * then init the plugin with the new reporter
 * @param [in] taskId: the task id created by EngineMgr, only for host
 * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
 */
int32_t ModuleJob::ProfStart()
{
    MSPROF_LOGI("ModuleJob, module:%s ProfStart", module_.c_str());
    if (isStarted_) {
        MSPROF_LOGW("This module has been started, needn't start again");
        return PROFILING_SUCCESS;
    }

    reporter_ = CreateDumper(module_);
    if (reporter_ == nullptr) {
        MSPROF_LOGE("Failed to create reporter %s", module_.c_str());
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("The report %s is created successfully.", module_.c_str());
    int32_t ret = reporter_->Start();
    if (ret != PROFILING_SUCCESS) {
        reporter_.reset();
        MSPROF_LOGE("Reporter Start failed");
        return ret;
    }

    ret = StartPlugin();
    if (ret != PROFILING_SUCCESS) {
        int32_t ret1 = reporter_->Stop();
        if (ret1 != PROFILING_SUCCESS) {
            MSPROF_LOGE("%s reporter stop failed", module_.c_str());
        }
        reporter_.reset();
        MSPROF_LOGE("Engine CreatePlugin failed, please check the plugin code");
    }
    return ret;
}

/* *
 * @brief ProfConfig: config the plugin of user self-defined
 * @param [in] config: config info from FMK
 * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
 */
int32_t ModuleJob::ProfConfig(const SHARED_PTR_ALIA<ProfilerJobConfig> &config)
{
    int32_t ret = PROFILING_FAILED;
    if (config == nullptr || !isStarted_) {
        MSPROF_LOGE("Input parameter config is nullptr or module isn't started");
        return ret;
    }
    auto modules = config->modules;
    auto iter = modules.find(module_);
    if (iter != modules.end()) {
        SHARED_PTR_ALIA<ModuleJobConfig> jobConfig;
        MSVP_MAKE_SHARED0(jobConfig, ModuleJobConfig, return PROFILING_FAILED);
        jobConfig->switches = iter->second.switches;
        MSPROF_LOGI("Call OnNewConfig to config module:%s", module_.c_str());
        ret = plugin_->OnNewConfig(jobConfig.get());
        FUNRET_CHECK_EXPR_LOGW(ret != PROFILING_SUCCESS, "The plugin OnNewConfig did not proceed as intended, "
            "please check the plugin code %d", ret);
    } else {
        MSPROF_LOGE("Cannot find the module info in the config");
    }
    return ret;
}

/* *
 * @brief StopPlugin: stop the plugin, then call the engine API to release the plugin
 * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
 */
int32_t ModuleJob::StopPlugin()
{
    int32_t ret = PROFILING_SUCCESS;
    if (plugin_ != nullptr) {
        if (plugin_->UnInit() == PROFILING_SUCCESS) {
            MSPROF_LOGI("Plugin UnInit Success.");
        } else {
            MSPROF_LOGE("Plugin UnInit failed, please check the plugin code");
            ret = PROFILING_FAILED;
        }

        if (engine_->ReleasePlugin(plugin_) == PROFILING_SUCCESS) {
            MSPROF_LOGI("Engine ReleasePlugin Success.");
        } else {
            MSPROF_LOGE("Engine ReleasePlugin failed, please check the plugin code");
            ret = PROFILING_FAILED;
        }

        if (ret == PROFILING_SUCCESS) {
            plugin_ = nullptr;
        }
    } else {
        MSPROF_LOGW("ModuleJob plugin_ is NULL");
        ret = PROFILING_FAILED;
    }
    return ret;
}

/* *
 * @brief ProfStop: stop the plugin of user self-defined, then stop and reset the reporter
 * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
 */
int32_t ModuleJob::ProfStop()
{
    MSPROF_LOGI("ModuleJob, module:%s ProfStop", module_.c_str());
    int32_t ret = PROFILING_SUCCESS;
    if (isStarted_) {
        ret = StopPlugin();
        int32_t thrRet = reporter_->Stop();
        if (thrRet != PROFILING_SUCCESS) {
            MSPROF_LOGE("reporter_ stop failed. %s", module_.c_str());
        }
        reporter_.reset();
        isStarted_ = false;
    } else {
        MSPROF_LOGW("ModuleJob not started, so needn't to stop");
        ret = PROFILING_FAILED;
    }
    return ret;
}

SHARED_PTR_ALIA<DataDumper> ModuleJob::CreateDumper(const std::string &module) const
{
    std::string moduleName = module;
    size_t pos = module.find_first_of("-");
    if (pos != std::string::npos) {
        moduleName = module.substr(0, pos);
    }
    SHARED_PTR_ALIA<DataDumper> reporter;
    MSPROF_LOGI("CreateDumper NotInProcessDumper, module:%s", module.c_str());
    MSVP_MAKE_SHARED1(reporter, RpcDumper, module, return nullptr);
    return reporter;
}
} // namespace Engine
} // namespace Msprof
