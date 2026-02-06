/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_inner_api.h"
#include "msprof_dlog.h"
#include "prof_api.h"
#include "prof_acl_plugin.h"
#include "prof_cann_plugin.h"
#include "prof_atls_plugin.h"
#include "prof_tx_plugin.h"
#include "prof_plugin_manager.h"
#include "prof_mstx_plugin.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
// API for atls using
MSVP_PROF_API int32_t profRegReporterCallback(MsprofReportHandle reporter)
{
    return ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterReporter(reporter);
}

MSVP_PROF_API int32_t profRegCtrlCallback(MsprofCtrlHandle handle)
{
    ProfAPI::ProfPluginManager::instance()->SetProfPlugin(ProfAPI::ProfAtlsPlugin::instance());
    return ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterCtrl(handle);
}

MSVP_PROF_API int32_t profRegDeviceStateCallback(MsprofSetDeviceHandle handle)
{
    return ProfAPI::ProfAtlsPlugin::instance()->ProfRegisterDeviceNotify(handle);
}

MSVP_PROF_API int32_t profGetDeviceIdByGeModelIdx(const uint32_t modelIdx, uint32_t *deviceId)
{
    return ProfAPI::ProfAtlsPlugin::instance()->ProfGetDeviceIdByGeModelIdx(modelIdx, deviceId);
}

MSVP_PROF_API int32_t profSetProfCommand(VOID_PTR command, uint32_t len)
{
    return ProfAPI::ProfAtlsPlugin::instance()->ProfSetProfCommand(command, len);
}

MSVP_PROF_API int32_t MsprofRegisterProfileCallback(int32_t callbackType, VOID_PTR callback, uint32_t len)
{
    return ProfAPI::ProfAtlsPlugin::instance()->RegisterProfileCallback(callbackType, callback, len);
}

// API for cann & atlas using
MSVP_PROF_API int32_t profSetStepInfo(const uint64_t indexId, const uint16_t tagId, void* const stream)
{
    ProfAPI::ProfPlugin *plugin = ProfAPI::ProfPluginManager::instance()->GetProfPlugin();
    return plugin->ProfSetStepInfo(indexId, tagId, stream);
}

// prof acl api
MSVP_PROF_API int32_t ProfAclSubscribe(uint32_t type, uint32_t modelId, PROFAPI_SUBSCRIBECONFIG_CONST_PTR config)
{
    ProfAPI::ProfCannPlugin::instance()->ProfApiInit();
    ProfAPI::ProfCannPlugin::instance()->ProfInitReportBuf();
    return ProfAPI::ProfAclPlugin::instance()->ProfAclSubscribe(type, modelId, config);
}

MSVP_PROF_API int32_t ProfAclUnSubscribe(uint32_t type, uint32_t modelId)
{
    return ProfAPI::ProfAclPlugin::instance()->ProfAclUnSubscribe(type, modelId);
}

MSVP_PROF_API int32_t ProfOpSubscribe(uint32_t devId, PROFAPI_SUBSCRIBECONFIG_CONST_PTR profSubscribeConfig)
{
    ProfAPI::ProfCannPlugin::instance()->ProfInitReportBuf();
    return ProfAPI::ProfAclPlugin::instance()->ProfOpSubscribe(devId, profSubscribeConfig);
}

MSVP_PROF_API int32_t ProfOpUnSubscribe(uint32_t devId)
{
    return ProfAPI::ProfAclPlugin::instance()->ProfOpUnSubscribe(devId);
}

MSVP_PROF_API uint64_t ProfAclGetOpTime(uint32_t type, const void *opInfo, size_t opInfoLen, uint32_t index)
{
    return ProfAPI::ProfAclPlugin::instance()->ProfAclGetOpTime(type, opInfo, opInfoLen, index);
}

MSVP_PROF_API size_t ProfAclGetId(uint32_t type, const void *opInfo, size_t opInfoLen, uint32_t index)
{
    return ProfAPI::ProfAclPlugin::instance()->ProfAclGetId(type, opInfo, opInfoLen, index);
}

MSVP_PROF_API int32_t ProfAclGetOpVal(uint32_t type, const void *opInfo, size_t opInfoLen,
                                      uint32_t index, void *data, size_t len)
{
    return ProfAPI::ProfAclPlugin::instance()->ProfAclGetOpVal(type, opInfo, opInfoLen, index, data, len);
}

MSVP_PROF_API uint64_t ProfGetOpExecutionTime(const void *data, uint32_t len, uint32_t index)
{
    return ProfAPI::ProfAclPlugin::instance()->ProfGetOpExecutionTime(data, len, index);
}

MSVP_PROF_API const char *ProfAclGetOpAttriVal(uint32_t type, const void *opInfo, size_t opInfoLen,
    uint32_t index, uint32_t attri)
{
    return ProfAPI::ProfAclPlugin::instance()->ProfGetOpAttriVal(type, opInfo, opInfoLen, index, attri);
}
// prof tx
MSVP_PROF_API void *ProfAclCreateStamp()
{
    return ProfAPI::ProfTxPlugin::GetProftxInstance().ProftxCreateStamp();
}

MSVP_PROF_API void ProfAclDestroyStamp(void *stamp)
{
    return ProfAPI::ProfTxPlugin::GetProftxInstance().ProftxDestroyStamp(stamp);
}

MSVP_PROF_API int32_t ProfAclPush(void *stamp)
{
    return ProfAPI::ProfTxPlugin::GetProftxInstance().ProftxPush(stamp);
}

MSVP_PROF_API int32_t ProfAclPop()
{
    return ProfAPI::ProfTxPlugin::GetProftxInstance().ProftxPop();
}

MSVP_PROF_API int32_t ProfAclRangeStart(void *stamp, uint32_t *rangeId)
{
    return ProfAPI::ProfTxPlugin::GetProftxInstance().ProftxRangeStart(stamp, rangeId);
}

MSVP_PROF_API int32_t ProfAclRangeStop(uint32_t rangeId)
{
    return ProfAPI::ProfTxPlugin::GetProftxInstance().ProftxRangeStop(rangeId);
}

MSVP_PROF_API int32_t ProfAclSetStampTraceMessage(void *stamp, const char *msg, uint32_t msgLen)
{
    return ProfAPI::ProfTxPlugin::GetProftxInstance().ProftxSetStampTraceMessage(stamp, msg, msgLen);
}

MSVP_PROF_API int32_t ProfAclMark(void *stamp)
{
    return ProfAPI::ProfTxPlugin::GetProftxInstance().ProftxMark(stamp);
}

MSVP_PROF_API int32_t ProfAclMarkEx(const char *msg, size_t msgLen, aclrtStream stream)
{
    return ProfAPI::ProfTxPlugin::GetProftxInstance().ProftxMarkEx(msg, msgLen, stream);
}

MSVP_PROF_API int32_t ProfAclSetCategoryName(uint32_t category, const char *categoryName)
{
    return ProfAPI::ProfTxPlugin::GetProftxInstance().ProftxSetCategoryName(category, categoryName);
}

MSVP_PROF_API int32_t ProfAclSetStampCategory(VOID_PTR stamp, uint32_t category)
{
    return ProfAPI::ProfTxPlugin::GetProftxInstance().ProftxSetStampCategory(stamp, category);
}

MSVP_PROF_API int32_t ProfAclSetStampPayload(VOID_PTR stamp, const int32_t type, VOID_PTR value)
{
    return ProfAPI::ProfTxPlugin::GetProftxInstance().ProftxSetStampPayload(stamp, type, value);
}

MSVP_PROF_API int32_t AdprofReportAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length)
{
    return MsprofReportAdditionalInfo(nonPersistantFlag, static_cast<VOID_PTR>(const_cast<void *>(data)), length);
}

MSVP_PROF_API int32_t AdprofReportBatchAdditionalInfo(uint32_t nonPersistantFlag, const void *data, uint32_t length)
{
    return MsprofReportBatchAdditionalInfo(nonPersistantFlag, static_cast<VOID_PTR>(const_cast<void *>(data)), length);
}

MSVP_PROF_API size_t AdprofGetBatchReportMaxSize(uint32_t type)
{
    return MsprofGetBatchReportMaxSize(type);
}

MSVP_PROF_API uint64_t AdprofGetHashId(const char *hashInfo, size_t length)
{
    return MsprofGetHashId(hashInfo, length);
}

MSVP_PROF_API int32_t AdprofCheckFeatureIsOn(uint64_t feature)
{
    return ProfAPI::ProfCannPlugin::instance()->ProfAdprofCheckFeatureIsOn(feature);
}

MSVP_PROF_API int32_t MsprofSubscribeRawData(MsprofRawDataCallback callback)
{
    int32_t ret = 0;
    if (callback == nullptr) {
        MSPROF_LOGE("MsprofSubscribeRawData param callback is null");
        return -1;
    }
    ret = ProfAPI::ProfCannPlugin::instance()->ProfSubscribeRawData(callback);
    MSPROF_LOGD("MsprofSubscribeRawData ok");
    return ret;
}

MSVP_PROF_API int32_t MsprofUnSubscribeRawData()
{
    int32_t ret = 0;
    ret = ProfAPI::ProfCannPlugin::instance()->ProfUnSubscribeRawData();
    MSPROF_LOGD("MsprofUnsubscribeRawData ok");
    return ret;
}

MSVP_PROF_API uint64_t ProfStr2Id(const char *hashInfo, size_t length)
{
    return MsprofGetHashId(hashInfo, length);
}

MSVP_PROF_API int32_t ProfAclRangePushEx(ACLPROF_EVENT_ATTR_PTR attr)
{
    return ProfAPI::ProfTxPlugin::GetProftxInstance().ProftxRangePushEx(attr);
}

MSVP_PROF_API int32_t ProfAclRangePop()
{
    return ProfAPI::ProfTxPlugin::GetProftxInstance().ProftxRangePop();
}

#ifdef __cplusplus
}
#endif
