/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "msprofiler_adaptor.h"
#include "command_handle.h"
#include "prof_api_common.h"
#include "msprofiler_impl.h"
#include "platform/platform.h"
#include "json_parser.h"
#include "msprof_dlog.h"
#include "dyn_prof_mgr.h"
#include "prof_reporter_mgr.h"
#include "receive_data.h"

using namespace Analysis::Dvvp::Common::Platform;
using namespace Msprofiler::Parser;
using namespace Msprof::Engine::Intf;
using namespace Collector::Dvvp::DynProf;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::error;

extern "C" MSVP_PROF_API int32_t MsprofSetConfig(uint32_t configType, const char *config, size_t configLength)
{
    return Analysis::Dvvp::ProfilerCommon::ProfSetConfig(configType, config, configLength);
}

extern "C" MSVP_PROF_API int32_t MsprofReportData(uint32_t moduleId, uint32_t type, VOID_PTR data, uint32_t len)
{
    return Analysis::Dvvp::ProfilerCommon::ProfReportData(moduleId, type, data, len);
}

extern "C" MSVP_PROF_API int32_t MsprofRegisterCallback(uint32_t moduleId, ProfCommandHandle handle)
{
    if (moduleId == AICPU) {
        return Analysis::Dvvp::ProfilerCommon::ProfAdprofRegisterCallback(moduleId, handle);
    }
    return Analysis::Dvvp::ProfilerCommon::ProfRegisterCallback(moduleId, handle);
}

extern "C" MSVP_PROF_API int32_t MsprofInit(uint32_t dataType, VOID_PTR data, uint32_t dataLen)
{
    JsonParser::instance()->Init(PROF_JSON_PATH);
    if (Platform::instance()->Init() != PROFILING_SUCCESS) {
        return MSPROF_ERROR;
    }
    if (dataType == MSPROF_CTRL_INIT_AICPU) {
        return Analysis::Dvvp::ProfilerCommon::ProfAdprofInit(data, dataLen);
    }
    return Analysis::Dvvp::ProfilerCommon::ProfInit(dataType, data, dataLen);
}

extern "C" MSVP_PROF_API int32_t MsprofStart(uint32_t dataType, const void *data, uint32_t length)
{
    return Analysis::Dvvp::ProfilerCommon::ProfConfigStart(dataType, data, length);
}
 
extern "C" MSVP_PROF_API int32_t MsprofStop(uint32_t dataType, const void *data, uint32_t length)
{
    return Analysis::Dvvp::ProfilerCommon::ProfConfigStop(dataType, data, length);
}

extern "C" MSVP_PROF_API int32_t MsprofNotifySetDevice(uint32_t chipId, uint32_t deviceId, bool isOpen)
{
    if (Utils::IsDynProfMode() && !DynProfMgr::instance()->IsProfStarted()) {
        return Analysis::Dvvp::ProfilerCommon::ProfNotifySetDeviceForDynProf(chipId, deviceId, isOpen);
    }
    return Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(chipId, deviceId, isOpen);
}

extern "C" MSVP_PROF_API int32_t MsprofFinalize()
{
    return Analysis::Dvvp::ProfilerCommon::ProfFinalize();
}

extern "C" MSVP_PROF_API int32_t MsprofSetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId)
{
    return  Analysis::Dvvp::ProfilerCommon::ProfSetDeviceIdByGeModelIdx(geModelIdx, deviceId);
}

extern "C" MSVP_PROF_API int32_t MsprofUnsetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId)
{
    return Analysis::Dvvp::ProfilerCommon::ProfUnsetDeviceIdByGeModelIdx(geModelIdx, deviceId);
}

extern "C" MSVP_PROF_API uint64_t ProfGetOpExecutionTime(CONST_VOID_PTR data, uint32_t len, uint32_t index)
{
    return Msprofiler::Api::ProfGetOpExecutionTime(data, len, index);
}

extern "C" MSVP_PROF_API int32_t ProfAclInit(ProfType type, const char *profilerPath, uint32_t length)
{
    JsonParser::instance()->Init(PROF_JSON_PATH);
    if (Platform::instance()->Init() != PROFILING_SUCCESS) {
        return MSPROF_ERROR;
    }
    return Msprofiler::AclApi::ProfInit(type, profilerPath, length);
}

extern "C" MSVP_PROF_API int32_t ProfAclWarmup(ProfType type, PROF_CONFIG_CONST_PTR profilerConfig)
{
    return Msprofiler::AclApi::ProfWarmup(type, profilerConfig);
}

extern "C" MSVP_PROF_API int32_t ProfAclStart(ProfType type, PROF_CONFIG_CONST_PTR profilerConfig)
{
    return Msprofiler::AclApi::ProfStart(type, profilerConfig);
}

extern "C" MSVP_PROF_API int32_t ProfAclStop(ProfType type, PROF_CONFIG_CONST_PTR profilerConfig)
{
    return Msprofiler::AclApi::ProfStop(type, profilerConfig);
}

extern "C" MSVP_PROF_API int32_t ProfAclFinalize(ProfType type)
{
    return  Msprofiler::AclApi::ProfFinalize(type);
}

extern "C" MSVP_PROF_API int32_t ProfAclSetConfig(aclprofConfigType type, const char *config, size_t configLength)
{
    return Msprofiler::AclApi::ProfSetConfig(type, config, configLength);
}

extern "C" MSVP_PROF_API int32_t ProfAclSubscribe(
    ProfType type, uint32_t modelId, const aclprofSubscribeConfig *profSubscribeConfig)
{
    JsonParser::instance()->Init(PROF_JSON_PATH);
    if (Platform::instance()->Init() != PROFILING_SUCCESS) {
        return MSPROF_ERROR;
    }
    return Msprofiler::AclApi::ProfModelSubscribe(type, modelId, profSubscribeConfig);
}

extern "C" MSVP_PROF_API Msprofiler::AclApi::ProfCreateTransportFunc ProfCreateParsertransport()
{
    return  Msprofiler::AclApi::CreateParserTransport;
}

extern "C" MSVP_PROF_API void ProfRegisterTransport(Msprofiler::AclApi::ProfCreateTransportFunc callback)
{
    Msprofiler::AclApi::ProfRegisterTransport(callback);
}

extern "C" MSVP_PROF_API int32_t ProfAclUnSubscribe(ProfType type, uint32_t modelId)
{
    return  Msprofiler::AclApi::ProfModelUnSubscribe(type, modelId);
}

extern "C" MSVP_PROF_API int32_t ProfOpSubscribe(uint32_t devId, PROFAPI_SUBSCRIBECONFIG_CONST_PTR profSubscribeConfig)
{
    JsonParser::instance()->Init(PROF_JSON_PATH);
    if (Platform::instance()->Init() != PROFILING_SUCCESS) {
        return MSPROF_ERROR;
    }
    return  Msprofiler::AclApi::ProfOpSubscribe(devId,
        static_cast<const aclprofSubscribeConfig *>(profSubscribeConfig));
}

extern "C" MSVP_PROF_API int32_t ProfOpUnSubscribe(uint32_t devId)
{
    return  Msprofiler::AclApi::ProfOpUnSubscribe(devId);
}

extern "C" MSVP_PROF_API int32_t ProfAclDrvGetDevNum()
{
    return Msprofiler::AclApi::ProfAclDrvGetDevNum();
}

extern "C" MSVP_PROF_API uint64_t ProfAclGetOpTime(
    uint32_t type, CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index)
{
    return Msprofiler::AclApi::ProfAclGetOpTime(type, opInfo, opInfoLen, index);
}

extern "C" MSVP_PROF_API size_t ProfAclGetId(ProfType type, CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index)
{
    return Msprofiler::AclApi::ProfGetModelId(type, opInfo, opInfoLen, index);
}

extern "C" MSVP_PROF_API int32_t ProfAclGetOpVal(uint32_t type, CONST_VOID_PTR opInfo, size_t opInfoLen,
                                   uint32_t index, VOID_PTR data, size_t len)
{
    return Msprofiler::AclApi::ProfAclGetOpVal(type, opInfo, opInfoLen, index, data, len);
}

extern "C" MSVP_PROF_API const char *ProfAclGetOpAttriVal(uint32_t type, const void *opInfo, size_t opInfoLen,
                                            uint32_t index, uint32_t attri)
{
    return Msprofiler::AclApi::ProfAclGetOpAttriVal(type, opInfo, opInfoLen, index, attri);
}

extern "C" MSVP_PROF_API int32_t ProfImplReportRegTypeInfo(uint16_t level, uint32_t type, const std::string &typeName)
{
    return Dvvp::Collect::Report::ProfReporterMgr::GetInstance().RegReportTypeInfo(level, type, typeName);
}

extern "C" MSVP_PROF_API int32_t ProfImplReportDataFormat(uint16_t level, uint32_t type, const std::string &dataFormat)
{
    return Dvvp::Collect::Report::ProfReporterMgr::GetInstance().RegReportDataFormat(level, type, dataFormat);
}

extern "C" MSVP_PROF_API uint64_t ProfImplReportGetHashId(const std::string &info)
{
    return Dvvp::Collect::Report::ProfReporterMgr::GetInstance().GetHashId(info);
}

extern "C" MSVP_PROF_API bool ProfImplHostFreqIsEnable()
{
    return Platform::instance()->PlatformHostFreqIsEnable();
}

extern "C" MSVP_PROF_API void ProfImplGetImplInfo(ProfImplInfo& info)
{
    return Analysis::Dvvp::ProfilerCommon::ProfGetImplInfo(info);
}

extern "C" MSVP_PROF_API void ProfImplSetApiBufPop(const ProfApiBufPopCallback func)
{
    Msprof::Engine::ReceiveData::apiTryPop_ = func;
}

extern "C" MSVP_PROF_API void ProfImplSetCompactBufPop(const ProfCompactBufPopCallback func)
{
    Msprof::Engine::ReceiveData::compactTryPop_ = func;
}

extern "C" MSVP_PROF_API void ProfImplSetAdditionalBufPop(const ProfAdditionalBufPopCallback func)
{
    Msprof::Engine::ReceiveData::additionalTryPop_ = func;
}

extern "C" MSVP_PROF_API void ProfImplIfReportBufEmpty(const ProfReportBufEmptyCallback func)
{
    Msprof::Engine::ReceiveData::reportBufEmpty_ = func;
}

extern "C" MSVP_PROF_API int32_t ProfAclGetCompatibleFeatures(size_t *featuresSize, void **featuresData)
{
    return Msprofiler::AclApi::ProfAclGetCompatibleFeatures(featuresSize, featuresData);
}

extern "C" MSVP_PROF_API int32_t ProfAclGetCompatibleFeaturesV2(size_t *featuresSize, void **featuresData)
{
    return Msprofiler::AclApi::ProfAclGetCompatibleFeaturesV2(featuresSize, featuresData);
}

extern "C" MSVP_PROF_API int ProfAclRegisterDeviceCallback()
{
    return Msprofiler::AclApi::ProfAclRegisterDeviceCallback();
}

extern "C" MSVP_PROF_API void ProfImplSetBatchAddBufPop(const ProfBatchAddBufPopCallback func)
{
    Msprof::Engine::ReceiveData::batchAdditionalTryPop_ = func;
}

extern "C" MSVP_PROF_API void ProfImplSetBatchAddBufIndexShift(const ProfBatchAddBufIndexShiftCallBack func)
{
    Msprof::Engine::ReceiveData::batchAdditionalBufferIndexShift_ = func;
}

extern "C" MSVP_PROF_API int32_t ProfImplGetFeatureIsOn(uint64_t feature)
{
    return Analysis::Dvvp::ProfilerCommon::ProfAdprofGetFeatureIsOn(feature);
}

extern "C" MSVP_PROF_API int32_t ProfImplSubscribeRawData(MsprofRawDataCallback callback)
{
    int32_t ret = Analysis::Dvvp::ProfilerCommon::MsptiSubscribeRawData(callback);
    return ret;
}

extern "C" MSVP_PROF_API int32_t ProfImplUnSubscribeRawData()
{
    int32_t ret = Analysis::Dvvp::ProfilerCommon::MsptiUnSubscribeRawData();
    return ret;
}

extern "C" MSVP_PROF_API void ProfImplSetVarAddBlockBufBatchPop(const ProfVarAddBlockBufPopCallback func)
{
    Msprof::Engine::ReceiveData::varAdditionalTryPop_ = func;
}

extern "C" MSVP_PROF_API void ProfImplSetVarAddBlockBufIndexShift(const ProfVarAddBufIndexShiftCallBack func)
{
    Msprof::Engine::ReceiveData::varAdditionalBufferIndexShift_ = func;
}