/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_atls_plugin.h"
#include "errno/error_code.h"
#include "prof_api.h"
#include "prof_common.h"
#include "securec.h"
#include "slog.h"
#include "msprof_dlog.h"
#include "utils/utils.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
namespace ProfAPI {
struct ProfSetDevPara {
    uint32_t chipId;
    uint32_t deviceId;
    bool isOpen;
};

using ProfSetDevParaT = struct ProfSetDevPara;

ProfAtlsPlugin::ProfAtlsPlugin()
{
    (void)memset_s(&command_, sizeof(ProfCommand), 0, sizeof(ProfCommand));
    command_.type = PROF_COMMANDHANDLE_TYPE_MAX;
}

int32_t ProfAtlsPlugin::ProfRegisterReporter(MsprofReportHandle reporter)
{
    reporter_ = reporter;
    return PROFILING_SUCCESS;
}

int32_t ProfAtlsPlugin::ProfRegisterCtrl(MsprofCtrlHandle handle)
{
    profCtrl_ = handle;
    return PROFILING_SUCCESS;
}

int32_t ProfAtlsPlugin::ProfRegisterDeviceNotify(MsprofSetDeviceHandle handle)
{
    if (handle == nullptr) {
        return PROFILING_FAILED;
    }
    profSetDevice_ = handle;
    return PROFILING_SUCCESS;
}

void ProfAtlsPlugin::ProfNotifyCacheDevice(MsprofSetDeviceHandle handle)
{
    for (const auto&device : deviceStateMaps_) {
        uint32_t chipId = static_cast<uint32_t>(device.first >> 32);
        uint32_t deviceId = static_cast<uint32_t>(device.first & 0xFFFFFFFFU);
        ProfSetDevParaT para;
        para.chipId = chipId;
        para.deviceId = deviceId;
        para.isOpen = device.second;
        handle(reinterpret_cast<VOID_PTR>(&para), sizeof(ProfSetDevParaT));
    }
}

int32_t ProfAtlsPlugin::ProfSetProfCommand(VOID_PTR command, uint32_t len)
{
    (void)len;
    std::map<uint32_t, std::set<ProfCommandHandle>> callbacks;
    {
        std::unique_lock<std::mutex> lock(ProfPlugin::callbackMutex_);
        callbacks = ProfPlugin::moduleCallbacks_;
    }
    for (auto it = callbacks.cbegin(); it != callbacks.cend(); ++it) {
        for (auto& handle : it->second) {
            handle(static_cast<uint32_t>(PROF_CTRL_SWITCH), command, sizeof(ProfCommand));
        }
    }
    if (command != nullptr) {
        command_ = *reinterpret_cast<ProfCommand *>(command);
    }
    return PROFILING_SUCCESS;
}

int32_t ProfAtlsPlugin::RegisterProfileCallbackC(int32_t callbackType, VOID_PTR callback)
{
    if (callback == nullptr) {
        return PROFILING_FAILED;
    }
    auto ret = PROFILING_SUCCESS;
    switch (callbackType) {
        case PROFILE_REPORT_REG_TYPE_INFO_C_CALLBACK:
            profReportRegTypeInfoC_ = reinterpret_cast<decltype(profReportRegTypeInfoC_)>(callback);
            break;
        case PROFILE_REPORT_REG_DATA_FORMAT_C_CALLBACK:
            profReportRegDataFormatC_ = reinterpret_cast<decltype(profReportRegDataFormatC_)>(callback);
            break;
        case PROFILE_REPORT_GET_HASH_ID_CALLBACK:
            profReportGetHashId_ = reinterpret_cast<decltype(profReportGetHashId_)>(callback);
            break;
        case PROFILE_REPORT_GET_HASH_ID_C_CALLBACK:
            profReportGetHashIdC_ = reinterpret_cast<decltype(profReportGetHashIdC_)>(callback);
            break;
        case PROFILE_HOST_FREQ_IS_ENABLE_CALLBACK:
            profHostFreqIsEnable_ = reinterpret_cast<decltype(profHostFreqIsEnable_)>(callback);
            profHostFreqIsEnableC_ = nullptr;
            break;
        case PROFILE_HOST_FREQ_IS_ENABLE_C_CALLBACK:
            profHostFreqIsEnableC_ = reinterpret_cast<decltype(profHostFreqIsEnableC_)>(callback);
            profHostFreqIsEnable_ = nullptr;
            break;
        case PROFILE_DEVICE_STATE_C_CALLBACK:
            profSetDeviceC_ = reinterpret_cast<decltype(profSetDeviceC_)>(callback);
            profSetDevice_ = nullptr;
            ProfNotifyCacheDevice(profSetDeviceC_);
            break;
        default:
            ret = PROFILING_FAILED;
            break;
    }
    return ret;
}

int32_t ProfAtlsPlugin::RegisterProfileCallback(int32_t callbackType, VOID_PTR callback, uint32_t /* len */)
{
    if (callback == nullptr) {
        return PROFILING_FAILED;
    }

    MSPROF_EVENT("RegisterProfileCallback, callback type is %u", callbackType);
    auto ret = PROFILING_SUCCESS;
    switch (callbackType) {
        case PROFILE_CTRL_CALLBACK:
            profCtrl_ = reinterpret_cast<decltype(profCtrl_)>(callback);
            break;
        case PROFILE_DEVICE_STATE_CALLBACK:
            profSetDevice_ = reinterpret_cast<decltype(profSetDevice_)>(callback);
            profSetDeviceC_ = nullptr;
            break;
        case PROFILE_REPORT_API_CALLBACK:
            profReportApi_ = reinterpret_cast<decltype(profReportApi_)>(callback);
            profReportApiC_ = nullptr;
            break;
        case PROFILE_REPORT_API_C_CALLBACK:
            profReportApiC_ = reinterpret_cast<decltype(profReportApiC_)>(callback);
            profReportApi_ = nullptr;
            break;
        case PROFILE_REPORT_EVENT_CALLBACK:
            profReportEvent_ = reinterpret_cast<decltype(profReportEvent_)>(callback);
            profReportEventC_ = nullptr;
            break;
        case PROFILE_REPORT_EVENT_C_CALLBACK:
            profReportEventC_ = reinterpret_cast<decltype(profReportEventC_)>(callback);
            profReportEvent_ = nullptr;
            break;
        case PROFILE_REPORT_COMPACT_CALLBACK:
            profReportCompactInfo_ = reinterpret_cast<decltype(profReportCompactInfo_)>(callback);
            break;
        case PROFILE_REPORT_ADDITIONAL_CALLBACK:
            profReportAdditionalInfo_ = reinterpret_cast<decltype(profReportAdditionalInfo_)>(callback);
            break;
        case PROFILE_REPORT_REG_TYPE_INFO_CALLBACK:
            profReportRegTypeInfo_ = reinterpret_cast<decltype(profReportRegTypeInfo_)>(callback);
            break;
        case PROFILE_REPORT_REG_DATA_FORMAT_CALLBACK:
            profReportRegDataFormat_ = reinterpret_cast<decltype(profReportRegDataFormat_)>(callback);
            break;
        default:
            ret = RegisterProfileCallbackC(callbackType, callback);
            break;
    }

    return ret;
}

int32_t ProfAtlsPlugin::ProfSetStepInfo(const uint64_t indexId, const uint16_t tagId, void* const stream)
{
    if (ProfAPI::ProfRuntimePlugin::instance()->RuntimeApiInit() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to execute RuntimeApiInit.");
        return PROFILING_FAILED;
    }
    const uint64_t modelId = 0xFFFFFFFFU;
    const uint32_t apiType = 11;
    const auto beginTime = MsprofSysCycleTime();
    rtError_t ret = ProfAPI::ProfRuntimePlugin::instance()->ProfMarkEx(indexId, modelId, tagId, stream);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }
    const auto endTime = MsprofSysCycleTime();
    return ReportApiInfo(beginTime, endTime, static_cast<uint64_t>(tagId), apiType);
}

int32_t ProfAtlsPlugin::ReportApiInfo(const uint64_t beginTime, const uint64_t endTime, const uint64_t itemId, const uint32_t apiType)
{
    MsprofApi apiInfo{};
    BuildApiInfo({beginTime, endTime}, apiType, itemId, apiInfo);
    const int32_t ret = MsprofReportApi(true, &apiInfo);
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("MsprofReportApi interface handle Failed, beginTime is %u, endTime is %u, itemId is %u, apiType is %u", beginTime, endTime, itemId, apiType);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

void ProfAtlsPlugin::BuildApiInfo(const std::pair<uint64_t, uint64_t> &profTime, const uint32_t apiType, const uint64_t itemId, MsprofApi &api)
{
    api.itemId = itemId;
    api.beginTime = profTime.first;
    api.endTime = profTime.second;
    api.type = apiType;
    api.level = MSPROF_REPORT_NODE_LEVEL;
    thread_local const auto tid = mmGetTid();
    api.threadId = static_cast<uint32_t>(tid);
}

int32_t ProfAtlsPlugin::ProfInit(uint32_t type, VOID_PTR data, uint32_t dataLen)
{
    if (profCtrl_ == nullptr) {
        return PROFILING_FAILED;
    }
    return profCtrl_(type, data, dataLen);
}

int32_t ProfAtlsPlugin::ProfStart(uint32_t /* dataType */, const void * /* data */, uint32_t /* length */)
{
    return PROFILING_SUCCESS;
}
 
int32_t ProfAtlsPlugin::ProfStop(uint32_t /* dataType */, const void * /* data */, uint32_t /* length */)
{
    return PROFILING_SUCCESS;
}

int32_t ProfAtlsPlugin::ProfSetConfig(uint32_t /* configType */, const char * /* config */,
    size_t /* configLength */)
{
    return PROFILING_SUCCESS;
}

int32_t ProfAtlsPlugin::ProfReportBatchAdditionalInfo(uint32_t /* agingFlag */, const VOID_PTR /* data */, uint32_t /* len */)
{
    return PROFILING_SUCCESS;
}

size_t ProfAtlsPlugin::ProfGetBatchReportMaxSize(uint32_t /* type */)
{
    return 0;
}

int32_t ProfAtlsPlugin::ProfRegisterCallback(uint32_t moduleId, ProfCommandHandle handle)
{
    if (handle == nullptr) {
        MSPROF_LOGE("Register callback with invalid handle nullptr, module[%u]", moduleId);
        return PROFILING_FAILED;
    }
    std::unique_lock<std::mutex> lock(ProfPlugin::callbackMutex_);
    auto it = ProfPlugin::moduleCallbacks_.find(moduleId);
    if (it != ProfPlugin::moduleCallbacks_.cend() && it->second.count(handle) > 0) {
        MSPROF_LOGW("handle has already registered.");
        return PROFILING_SUCCESS;
    }
    MSPROF_EVENT("Module[%u] register callback of ctrl handle.", moduleId);
    ProfPlugin::moduleCallbacks_[moduleId].insert(handle);
    ProfCommand commandInit;
    switch (command_.type) {
        case PROF_COMMANDHANDLE_TYPE_INIT:
            MSPROF_LOGI("ProfRegisterCallback, init [%u] handle.", moduleId);
            handle(static_cast<uint32_t>(PROF_CTRL_SWITCH),
                reinterpret_cast<VOID_PTR>(&command_), sizeof(command_));
                break;
        case PROF_COMMANDHANDLE_TYPE_START:
            MSPROF_LOGI("ProfRegisterCallback, start [%u] handle.", moduleId);
            commandInit = command_;
            commandInit.type = PROF_COMMANDHANDLE_TYPE_INIT;
            handle(static_cast<uint32_t>(PROF_CTRL_SWITCH),
                reinterpret_cast<VOID_PTR>(&commandInit), sizeof(commandInit));
            handle(static_cast<uint32_t>(PROF_CTRL_SWITCH),
                reinterpret_cast<VOID_PTR>(&command_), sizeof(command_));
            break;
        case PROF_COMMANDHANDLE_TYPE_MODEL_SUBSCRIBE:
            handle(static_cast<uint32_t>(PROF_CTRL_SWITCH),
                reinterpret_cast<VOID_PTR>(&command_), sizeof(command_));
            break;
        default:
            break;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfAtlsPlugin::ProfReportData(uint32_t moduleId, uint32_t type, VOID_PTR data, uint32_t len)
{
    if (reporter_ == nullptr) {
        return PROFILING_FAILED;
    }
    return reporter_(moduleId, type, data, len);
}

int32_t ProfAtlsPlugin::ProfReportApi(uint32_t agingFlag, const MsprofApi* api)
{
    if (profReportApiC_ != nullptr) {
        return profReportApiC_(agingFlag, api);
    }
    if (profReportApi_ != nullptr) {
        return profReportApi_(agingFlag, *api);
    }
    return 0;
}

int32_t ProfAtlsPlugin::ProfReportEvent(uint32_t agingFlag, const MsprofEvent* event)
{
    if (profReportEventC_ != nullptr) {
        return profReportEventC_(agingFlag, event);
    }
    if (profReportEvent_ != nullptr) {
        return profReportEvent_(agingFlag, *event);
    }
    return 0;
}

int32_t ProfAtlsPlugin::ProfReportCompactInfo(uint32_t agingFlag, const VOID_PTR data, uint32_t len)
{
    if (profReportCompactInfo_ != nullptr) {
        return profReportCompactInfo_(agingFlag, data, len);
    }
    return 0;
}

int32_t ProfAtlsPlugin::ProfReportAdditionalInfo(uint32_t agingFlag, const VOID_PTR data, uint32_t len)
{
    if (profReportAdditionalInfo_ != nullptr) {
        return profReportAdditionalInfo_(agingFlag, data, len);
    }
    return 0;
}

int32_t ProfAtlsPlugin::ProfReportRegTypeInfo(uint16_t level, uint32_t typeId, const char* typeName, size_t len)
{
    if (profReportRegTypeInfoC_ != nullptr) {
        (void)profReportRegTypeInfoC_(level, typeId, typeName, len);
    }
    if (profReportRegTypeInfo_ != nullptr) {
        (void)profReportRegTypeInfo_(level, typeId, std::string(typeName, len));
    }
    return 0;
}

int32_t ProfAtlsPlugin::ProfReportRegDataFormat(uint16_t level, uint32_t typeId, const char* dataFormat, size_t len)
{
    if (profReportRegDataFormatC_ != nullptr) {
        (void)profReportRegDataFormatC_(level, typeId, dataFormat, len);
    }
    if (profReportRegDataFormat_ != nullptr) {
        (void)profReportRegDataFormat_(level, typeId, std::string(dataFormat, len));
    }
    return 0;
}

uint64_t ProfAtlsPlugin::ProfReportGetHashId(const char* info, size_t len)
{
    uint64_t hashId = 0;
    if (profReportGetHashIdC_ != nullptr) {
        hashId = profReportGetHashIdC_(info, len);
    }
    if (profReportGetHashId_ != nullptr) {
        hashId = profReportGetHashId_(std::string(info, len));
    }
    return hashId;
}

int32_t ProfAtlsPlugin::ProfSetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId)
{
    std::unique_lock<std::mutex> lock(atlasDeviceMapsMutex_);
    (void)deviceIdMaps_.insert(std::make_pair(geModelIdx, deviceId));
    return PROFILING_SUCCESS;
}

int32_t ProfAtlsPlugin::ProfUnSetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId)
{
    std::unique_lock<std::mutex> lock(atlasDeviceMapsMutex_);
    (void)deviceId;
    (void)deviceIdMaps_.erase(geModelIdx);
    return PROFILING_SUCCESS;
}

int32_t ProfAtlsPlugin::ProfGetDeviceIdByGeModelIdx(const uint32_t geModelIdx, uint32_t *deviceId)
{
    std::unique_lock<std::mutex> lock(atlasDeviceMapsMutex_);
    const auto it = deviceIdMaps_.find(geModelIdx);
    if (it != deviceIdMaps_.end()) {
        *deviceId = it->second;
        return PROFILING_SUCCESS;
    }
    return PROFILING_FAILED;
}

int32_t ProfAtlsPlugin::ProfNotifySetDevice(uint32_t chipId, uint32_t deviceId, bool isOpen)
{
    uint64_t id = deviceId;
    id |= static_cast<uint64_t>(chipId) << 32;
    {
        std::unique_lock<std::mutex> lock(atlasDeviceStateMutex_);
        deviceStateMaps_[id] = isOpen;
    }
    ProfSetDevParaT para;
    para.chipId = chipId;
    para.deviceId = deviceId;
    para.isOpen = isOpen;

    if (profSetDeviceC_ != nullptr) {
        return profSetDeviceC_(reinterpret_cast<VOID_PTR>(&para), sizeof(ProfSetDevParaT));
    }
    if (profSetDevice_ != nullptr) {
        return profSetDevice_(reinterpret_cast<VOID_PTR>(&para), sizeof(ProfSetDevParaT));
    }
    return PROFILING_SUCCESS;
}

int32_t ProfAtlsPlugin::ProfFinalize()
{
    if (profCtrl_ == nullptr) {
        return PROFILING_FAILED;
    }
    return profCtrl_(MSPROF_CTRL_FINALIZE, nullptr, 0);
}

bool ProfAtlsPlugin::ProfHostFreqIsEnable()
{
    if (profHostFreqIsEnableC_ != nullptr) {
        return profHostFreqIsEnableC_() != 0;
    }
    if (profHostFreqIsEnable_ != nullptr) {
        return profHostFreqIsEnable_();
    }
    return false;
}
}
