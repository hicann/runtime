/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <map>
#include "mmpa_api.h"
#include "utils.h"
#include "prof_api.h"
#include "prof_report_api.h"
#include "prof_acl_intf.h"
#include "prof_api_common.h"
#include "msprofiler_acl_api.h"
#include "msprofiler_impl.h"
#include "ascend_hal.h"
#include "device_drv_prof_stub.h"
#include "acl/acl_base.h"
#include "runtime/base.h"

using namespace Msprof::Engine::Intf;
using namespace analysis::dvvp::common::utils;

rtError_t rtProfilerTraceExStub(uint64_t indexId, uint64_t modelId, uint16_t tagId, rtStream_t stm)
{
    (void)indexId;
    (void)modelId;
    (void)tagId;
    (void)stm;
    return RT_ERROR_NONE;
}

int32_t g_handle;
extern "C" int32_t MsprofInit(uint32_t dataType, VOID_PTR data, uint32_t dataLen);
extern "C" int32_t MsprofStart(uint32_t dataType, const void *data, uint32_t length);
extern "C" int32_t MsprofStop(uint32_t dataType, const void *data, uint32_t length);
extern "C" int32_t MsprofSetConfig(uint32_t configType, const char *config, size_t configLength);
extern "C" int32_t MsprofRegisterCallback(uint32_t moduleId, ProfCommandHandle handle);
extern "C" int32_t MsprofReportData(uint32_t moduleId, uint32_t type, VOID_PTR data, uint32_t len);
extern "C" size_t ProfImplGetImplInfo(ProfImplInfo& info);
extern "C" void ProfImplSetApiBufPop(const ProfApiBufPopCallback func);
extern "C" void ProfImplSetCompactBufPop(const ProfCompactBufPopCallback func);
extern "C" void ProfImplSetAdditionalBufPop(const ProfAdditionalBufPopCallback func);
extern "C" void ProfImplIfReportBufEmpty(const ProfReportBufEmptyCallback func);
extern "C" int32_t ProfImplReportRegTypeInfo(uint16_t level, uint32_t type, const std::string &typeName);
extern "C" uint64_t ProfImplReportGetHashId(const std::string &info);
extern "C" void ProfImplSetAdditionalBufPush(const ProfAdditionalBufPushCallback func);
extern "C" void ProfImplSetMarkEx(const ProfMarkExCallback func);
extern "C" int32_t MsprofSetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId);
extern "C" int32_t MsprofNotifySetDevice(uint32_t chipId, uint32_t deviceId, bool isOpen);
extern "C" int32_t MsprofFinalize();
extern "C" int32_t MsprofUnsetDeviceIdByGeModelIdx(const uint32_t geModelIdx, const uint32_t deviceId);
extern "C" void* ProfAclCreateStamp();
extern "C" int32_t ProfAclMarkEx(const char *msg, size_t msgLen, aclrtStream stream);
extern "C" int32_t ProfAclInit(ProfType type, const char *profilerPath, uint32_t length);
extern "C" int32_t ProfAclStart(ProfType type, PROF_CONFIG_CONST_PTR profilerConfig);
extern "C" int32_t ProfAclStop(ProfType type, PROF_CONFIG_CONST_PTR profilerConfig);
extern "C" int32_t ProfAclFinalize(ProfType type);
extern "C" int32_t ProfAclSetConfig(aclprofConfigType type, const char *config, size_t configLength);
extern "C" int32_t ProfAclGetCompatibleFeatures(size_t *featuresSize, void **featuresData);
extern "C" int32_t ProfAclSubscribe(ProfType type, uint32_t modelId, const aclprofSubscribeConfig *profSubscribeConfig);
extern "C" Msprofiler::AclApi::ProfCreateTransportFunc ProfCreateParsertransport();
extern "C" void ProfRegisterTransport(Msprofiler::AclApi::ProfCreateTransportFunc callback);
extern "C" int32_t ProfAclUnSubscribe(ProfType type, uint32_t modelId);
extern "C" int32_t ProfOpSubscribe(uint32_t devId, PROFAPI_SUBSCRIBECONFIG_CONST_PTR profSubscribeConfig);
extern "C" int32_t ProfOpUnSubscribe(uint32_t devId);
extern "C" int32_t ProfAclDrvGetDevNum();
extern "C" uint64_t ProfAclGetOpTime(uint32_t type, CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index);
extern "C" size_t ProfAclGetId(ProfType type, CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index);
extern "C" int32_t ProfAclGetOpVal(uint32_t type, CONST_VOID_PTR opInfo, size_t opInfoLen, uint32_t index, VOID_PTR data, size_t len);
extern "C" const char *ProfAclGetOpAttriVal(uint32_t type, const void *opInfo, size_t opInfoLen, uint32_t index, uint32_t attri);
extern "C" uint64_t ProfGetOpExecutionTime(CONST_VOID_PTR data, uint32_t len, uint32_t index);

const std::map<std::string, void*> g_map = {
    {"MsprofInit", (void *)MsprofInit},
    {"MsprofSetConfig", (void *)MsprofSetConfig},
    {"MsprofRegisterCallback", (void *)MsprofRegisterCallback},
    {"MsprofReportData", (void *)MsprofReportData},
    {"ProfImplGetImplInfo", (void *)ProfImplGetImplInfo},
    {"ProfImplSetApiBufPop", (void *)ProfImplSetApiBufPop},
    {"ProfImplSetCompactBufPop", (void *)ProfImplSetCompactBufPop},
    {"ProfImplSetAdditionalBufPop", (void *)ProfImplSetAdditionalBufPop},
    {"ProfImplIfReportBufEmpty", (void *)ProfImplIfReportBufEmpty},
    {"ProfImplReportRegTypeInfo", (void *)ProfImplReportRegTypeInfo},
    {"ProfImplReportGetHashId", (void *)ProfImplReportGetHashId},
    {"ProfImplSetAdditionalBufPush", (void *)ProfImplSetAdditionalBufPush},
    {"ProfImplSetMarkEx", (void *)ProfImplSetMarkEx},
    {"MsprofSetDeviceIdByGeModelIdx", (void *)MsprofSetDeviceIdByGeModelIdx},
    {"MsprofNotifySetDevice", (void *)MsprofNotifySetDevice},
    {"MsprofFinalize", (void *)MsprofFinalize},
    {"MsprofUnsetDeviceIdByGeModelIdx", (void *)MsprofUnsetDeviceIdByGeModelIdx},
    {"ProfAclCreateStamp", (void *)ProfAclCreateStamp},
    {"ProfAclMarkEx", (void *)ProfAclMarkEx},
    {"ProfAclInit", (void *)ProfAclInit},
    {"ProfAclStart", (void *)ProfAclStart},
    {"ProfAclStop", (void *)ProfAclStop},
    {"ProfAclFinalize", (void *)ProfAclFinalize},
    {"ProfAclSetConfig", (void *)ProfAclSetConfig},
    {"ProfAclGetCompatibleFeatures", (void *)ProfAclGetCompatibleFeatures},
    {"ProfAclSubscribe", (void *)ProfAclSubscribe},
    {"ProfAclUnSubscribe", (void *)ProfAclUnSubscribe},
    {"ProfOpSubscribe", (void *)ProfOpSubscribe},
    {"ProfOpUnSubscribe", (void *)ProfOpUnSubscribe},
    {"ProfAclDrvGetDevNum", (void *)ProfAclDrvGetDevNum},
    {"ProfAclGetOpTime", (void *)ProfAclGetOpTime},
    {"ProfAclGetId", (void *)ProfAclGetId},
    {"ProfAclGetOpVal", (void *)ProfAclGetOpVal},
    {"ProfGetOpExecutionTime", (void *)ProfGetOpExecutionTime},
    {"ProfAclGetOpAttriVal", (void *)ProfAclGetOpAttriVal},
    {"ProfCreateParsertransport", (void *)ProfCreateParsertransport},
    {"ProfRegisterTransport", (void *)ProfRegisterTransport},
    {"halGetAPIVersion", (void *)halGetAPIVersion},
    {"drvGetDeviceSplitMode", (void *)drvGetDeviceSplitMode},
    {"halGetDeviceInfoByBuff", (void *)halGetDeviceInfoByBuff},
    {"halEschedQueryInfo", (void *)halEschedQueryInfo},
    {"halEschedCreateGrpEx", (void *)halEschedCreateGrpEx},
    {"rtProfilerTraceEx", (void *)rtProfilerTraceExStub},
    {"MsprofStart", (void *)MsprofStart},
    {"MsprofStop", (void *)MsprofStop}
};


void *mmDlsym(void *handle, const char* funcName)
{
    auto it = g_map.find(funcName);
    if (it != g_map.end()) {
        return it->second;
    }
    return nullptr;
}

char *mmDlerror(void)
{
    return nullptr;
}

void * mmDlopen(const char *fileName, int mode)
{
    if (strcmp(fileName, "libprofimpl.so") == 0 ||
        strcmp(fileName, "libascend_hal.so") == 0 ||
        strcmp(fileName, "libruntime.so") == 0) {
        return &g_handle;
    }
    return nullptr;
}

int mmDlclose(void *handle)
{
    return 0;
}