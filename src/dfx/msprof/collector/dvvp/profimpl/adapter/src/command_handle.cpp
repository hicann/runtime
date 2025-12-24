/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "command_handle.h"
#include <map>
#include <thread>
#include <algorithm>
#include "prof_api.h"
#include "prof_api_common.h"
#include "msprof_dlog.h"
#include "prof_acl_mgr.h"
#include "platform/platform.h"
#include "json_parser.h"
#include "prof_reporter_mgr.h"

namespace Analysis {
namespace Dvvp {
namespace ProfilerCommon {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Msprofiler::Parser;

ProfModuleReprotMgr::~ProfModuleReprotMgr()
{
}

int32_t ProfRegisterCallback(uint32_t moduleId, ProfCommandHandle callback)
{
    return ProfModuleReprotMgr::GetInstance().ModuleRegisterCallback(moduleId, callback);
}

int32_t CommandHandleProfInit()
{
    return ProfModuleReprotMgr::GetInstance().ModuleReportInit();
}

int32_t CommandHandleProfStart(const uint32_t devIdList[], uint32_t devNums, uint64_t profSwitch,
    uint64_t profSwitchHi)
{
    return ProfModuleReprotMgr::GetInstance().ModuleReportStart(devIdList, devNums, profSwitch, profSwitchHi);
}

int32_t CommandHandleProfStop(const uint32_t devIdList[], uint32_t devNums, uint64_t profSwitch, uint64_t profSwitchHi)
{
    return ProfModuleReprotMgr::GetInstance().ModuleReportStop(devIdList, devNums, profSwitch, profSwitchHi);
}

int32_t CommandHandleProfFinalize()
{
    return ProfModuleReprotMgr::GetInstance().ModuleReportFinalize();
}

int32_t CommandHandleProfUnSubscribe(uint32_t modelId)
{
    return ProfModuleReprotMgr::GetInstance().ModuleReportUnSubscribe(modelId);
}

void CommandHandleFinalizeGuard()
{
    ProfModuleReprotMgr::GetInstance().ProfSetFinalizeGuard();
}

void ProfModuleReprotMgr::ProfSetFinalizeGuard()
{
    finalizeGuard_ = true;
}

int32_t ProfModuleReprotMgr::ProfSetProCommand(ProfCommand &command)
{
    std::unique_lock<std::mutex> lock(regCallback_, std::defer_lock);
    lock.lock();
    std::vector<uint32_t> origOrder;
    std::for_each(moduleCallbacks_.cbegin(), moduleCallbacks_.cend(),
        [&origOrder](const std::pair<uint32_t, std::set<ProfCommandHandle>> &kv) {
            if (kv.first != RUNTIME && kv.first != ASCENDCL && kv.first != GE) {
                origOrder.push_back(kv.first);
            }
        });
    lock.unlock();
    std::vector<uint32_t> callbackOrder;
    if (command.type == PROF_COMMANDHANDLE_TYPE_INIT || command.type == PROF_COMMANDHANDLE_TYPE_START ||
        command.type == PROF_COMMANDHANDLE_TYPE_MODEL_SUBSCRIBE) {
        callbackOrder = { RUNTIME, ASCENDCL, GE };
    } else if (command.type == PROF_COMMANDHANDLE_TYPE_STOP || command.type == PROF_COMMANDHANDLE_TYPE_FINALIZE ||
        command.type == PROF_COMMANDHANDLE_TYPE_MODEL_UNSUBSCRIBE) {
        callbackOrder = { GE, ASCENDCL, RUNTIME };
    }
    callbackOrder.insert(callbackOrder.cend(), origOrder.cbegin(), origOrder.cend());
    for (const auto &k : callbackOrder) {
        lock.lock();
        auto it = moduleCallbacks_.find(k);
        if (it == moduleCallbacks_.cend() || it->second.empty() ||
            !JsonParser::instance()->GetJsonModuleProfSwitch(k)) {
            lock.unlock();
            continue;
        }
        lock.unlock();
        if (finalizeGuard_ && k != RUNTIME) {
            continue;
        }
        MSPROF_LOGI("call %u callback, type:%u, switch:%" PRIu64 ", switchHi:%" PRIu64 ", model:%u, devNums:%u, "
            "dev:%u, cache: %u, finalizeGuard: %u",
            k, command.type, command.profSwitch, command.profSwitchHi, command.modelId, command.devNums,
            command.devIdList[0], command.cacheFlag, finalizeGuard_);
        for (auto& handle : it->second) {
            handle(static_cast<uint32_t>(PROF_CTRL_SWITCH), Utils::ReinterpretCast<VOID, ProfCommand>(&command),
                    sizeof(ProfCommand));
        }
    }
    command_ = command;
    return ACL_SUCCESS;
}

int32_t ProfModuleReprotMgr::SetCommandHandleProf(ProfCommand &command) const
{
    // msprof param
    std::string msprofParams = Msprofiler::Api::ProfAclMgr::instance()->GetParamJsonStr();
    if (msprofParams.size() > PARAM_LEN_MAX) {
        MSPROF_LOGE("tparamsLen:%zu bytes, exceeds:%d bytes", msprofParams.size(), PARAM_LEN_MAX);
        return ACL_ERROR;
    }

    command.params.profDataLen = msprofParams.size();
    errno_t err = strncpy_s(command.params.profData, PARAM_LEN_MAX, msprofParams.c_str(), msprofParams.size() + 1);
    if (err != EOK) {
        MSPROF_LOGE("string copy failed, err: %d", err);
        return ACL_ERROR;
    }

    return ACL_SUCCESS;
}

void ProfModuleReprotMgr::ProcessDeviceList(ProfCommand &command, const uint32_t devIdList[], uint32_t devNums) const
{
    for (uint32_t j = 0; j < devNums && j < MSVP_MAX_DEV_NUM; j++) {
        if (devIdList[j] == DEFAULT_HOST_ID) {
            command.devNums -= 1;
            continue;
        }
        command.devIdList[j] = devIdList[j];
    }
}

int32_t ProfModuleReprotMgr::ModuleRegisterCallback(uint32_t moduleId, ProfCommandHandle callback)
{
    std::unique_lock<std::mutex> lock(regCallback_);
    if (callback == nullptr) {
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Module[%u] register callback of ctrl handle.", moduleId);
    auto it = moduleCallbacks_.find(moduleId);
    if (it != moduleCallbacks_.cend() && it->second.count(callback) > 0) {
        MSPROF_LOGW("Callback has already registered.");
        return PROFILING_SUCCESS;
    }
    moduleCallbacks_[moduleId].insert(callback);
    if (command_.type != PROF_COMMANDHANDLE_TYPE_MAX) {
        auto callbackBind = std::bind(&ProfModuleReprotMgr::DoCallbackHandle, this, callback);
        std::thread callbackThread(callbackBind);
        callbackThread.detach();
    }
    return ACL_SUCCESS;
}

void ProfModuleReprotMgr::DoCallbackHandle(ProfCommandHandle callback)
{
    ProfCommand commandInit;
    switch (command_.type) {
        case PROF_COMMANDHANDLE_TYPE_INIT:
            callback(static_cast<uint32_t>(PROF_CTRL_SWITCH),
                Utils::ReinterpretCast<VOID_PTR, ProfCommand>(&command_), sizeof(command_));
                break;
        case PROF_COMMANDHANDLE_TYPE_START:
            commandInit = command_;
            commandInit.type = PROF_COMMANDHANDLE_TYPE_INIT;
            callback(static_cast<uint32_t>(PROF_CTRL_SWITCH),
                Utils::ReinterpretCast<VOID_PTR, ProfCommand>(&commandInit), sizeof(commandInit));
            callback(static_cast<uint32_t>(PROF_CTRL_SWITCH),
                Utils::ReinterpretCast<VOID_PTR, ProfCommand>(&command_), sizeof(command_));
            break;
        case PROF_COMMANDHANDLE_TYPE_MODEL_SUBSCRIBE:
            callback(static_cast<uint32_t>(PROF_CTRL_SWITCH),
                Utils::ReinterpretCast<VOID_PTR, ProfCommand>(&command_), sizeof(command_));
            break;
        default:
            MSPROF_LOGD("Register callback success, waiting for the operation."); // regist, stop, finalize, unsubscribe
    }
}

int32_t ProfModuleReprotMgr::ModuleReportInit()
{
    ProfCommand command;
    const auto ret = memset_s(&command, sizeof(command), 0, sizeof(command));
    FUNRET_CHECK_RET_VALUE(ret != EOK, return PROFILING_FAILED);
    command.type = PROF_COMMANDHANDLE_TYPE_INIT;
    if (SetCommandHandleProf(command) != ACL_SUCCESS) {
        MSPROF_LOGE("ProfInit CommandHandle set failed");
        MSPROF_INNER_ERROR("EK9999", "ProfInit CommandHandle set failed");
        return ACL_ERROR;
    }
    return ProfSetProCommand(command);
}

int32_t ProfModuleReprotMgr::ModuleReportStart(const uint32_t devIdList[], uint32_t devNums, uint64_t profSwitch,
    uint64_t profSwitchHi)
{
    ProfCommand command;
    const auto ret = memset_s(&command, sizeof(command), 0, sizeof(command));
    FUNRET_CHECK_RET_VALUE(ret != EOK, return PROFILING_FAILED);
    command.profSwitch = profSwitch;
    command.profSwitchHi = profSwitchHi;
    command.type = PROF_COMMANDHANDLE_TYPE_START;
    command.devNums = devNums;
    command.modelId = PROF_INVALID_MODE_ID;
    // Set 1 to enable clean event to ge and runtime to clear cache after report once
    command.cacheFlag = (Msprofiler::Api::ProfAclMgr::instance()->IsSubscribeMode()) ? 1 : 0;
    ProcessDeviceList(command, devIdList, devNums);
    if (command.devNums == 0 && (profSwitch & PROF_PURE_CPU) == 0) {
        if (!Platform::instance()->PlatformIsHelperHostSide()) {
            return ACL_SUCCESS;
        }
    }
    if (SetCommandHandleProf(command) != ACL_SUCCESS) {
        MSPROF_LOGE("ProfStart CommandHandle set failed");
        MSPROF_INNER_ERROR("EK9999", "ProfStart CommandHandle set failed");
        return ACL_ERROR;
    }

    return ProfSetProCommand(command);
}

int32_t ProfModuleReprotMgr::ModuleReportStop(const uint32_t devIdList[], uint32_t devNums, uint64_t profSwitch,
    uint64_t profSwitchHi)
{
    ProfCommand command;
    const auto ret = memset_s(&command, sizeof(command), 0, sizeof(command));
    FUNRET_CHECK_RET_VALUE(ret != EOK, return PROFILING_FAILED);
    command.profSwitch = profSwitch;
    command.profSwitchHi = profSwitchHi;
    command.type = PROF_COMMANDHANDLE_TYPE_STOP;
    command.devNums = devNums;
    command.modelId = PROF_INVALID_MODE_ID;
    ProcessDeviceList(command, devIdList, devNums);
    if (command.devNums == 0 && (profSwitch & PROF_PURE_CPU) == 0) {
        if (!Platform::instance()->PlatformIsHelperHostSide() ||
            Platform::instance()->PlatformIsNeedHelperServer()) {
            return ACL_SUCCESS;
        }
    }
    if (SetCommandHandleProf(command) != ACL_SUCCESS) {
        MSPROF_LOGE("ProfStop CommandHandle set failed");
        MSPROF_INNER_ERROR("EK9999", "ProfStop CommandHandle set failed");
        return ACL_ERROR;
    }

    auto res = ProfSetProCommand(command);
    if (res != ACL_SUCCESS) {
        return ACL_ERROR;
    }

    ::Dvvp::Collect::Report::ProfReporterMgr::GetInstance().FlushHostReporters();
    return ACL_SUCCESS;
}

int32_t ProfModuleReprotMgr::ModuleReportFinalize()
{
    ProfCommand command;
    const auto ret = memset_s(&command, sizeof(command), 0, sizeof(command));
    FUNRET_CHECK_RET_VALUE(ret != EOK, return PROFILING_FAILED);
    command.type = PROF_COMMANDHANDLE_TYPE_FINALIZE;
    if (SetCommandHandleProf(command) != ACL_SUCCESS) {
        MSPROF_LOGE("ProfFinalize CommandHandle set failed");
        MSPROF_INNER_ERROR("EK9999", "ProfFinalize CommandHandle set failed");
        return ACL_ERROR;
    }

    if (::Dvvp::Collect::Report::ProfReporterMgr::GetInstance().StopReporters() != PROFILING_SUCCESS) {
        return ACL_ERROR;
    }

    return ProfSetProCommand(command);
}

int32_t ProfModuleReprotMgr::ModuleReportUnSubscribe(uint32_t modelId)
{
    ProfCommand command;
    const auto ret = memset_s(&command, sizeof(command), 0, sizeof(command));
    FUNRET_CHECK_RET_VALUE(ret != EOK, return PROFILING_FAILED);
    command.modelId = modelId;
    command.type = PROF_COMMANDHANDLE_TYPE_MODEL_UNSUBSCRIBE;
    if (SetCommandHandleProf(command) != ACL_SUCCESS) {
        MSPROF_LOGE("ProfUnSubscribe Set params failed!");
        MSPROF_INNER_ERROR("EK9999", "ProfUnSubscribe Set params failed!");
        return ACL_ERROR;
    }
    return ProfSetProCommand(command);
}
}  // namespace ProfilerCommon
}  // namespace Dvvp
}  // namespace Analysis
