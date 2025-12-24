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
#include <functional>
#include <atomic>
#include <fstream>
#include "msprof_stub.h"
#include "prof_common.h"
#include "msprof_stub.h"
#include "prof_api.h"
#include "data_manager.h"
#include "securec.h"
#include "prof_data_config.h"
#include "data_report_manager.h"
#ifdef MSPROF_C_CPP
#include "msprof_dlog.h"
#endif
using namespace std;

#ifndef MSPROF_C
#ifndef API_STEST
// if libprofapi.so is not linked, call inner api directly
extern "C" int32_t ProfImplReportRegTypeInfo(uint16_t level, uint32_t type, const std::string &typeName);
extern "C" uint64_t ProfImplReportGetHashId(const std::string &info);
uint64_t ProfImplReportGetHashIdStub(const char *hashInfo, size_t length) {return ProfImplReportGetHashId(std::string(hashInfo, length));}

#define MsprofRegTypeInfo ProfImplReportRegTypeInfo
#define MsprofGetHashId ProfImplReportGetHashIdStub
#endif
#endif
namespace ge {
std::atomic<uint32_t> g_subscribe_count;
MsprofReporterModuleId g_moduleId = MSPROF_MODULE_FRAMEWORK;
uint64_t g_modelId = 4;
uint16_t g_deviceId = 0;

int32_t ReportData(uint8_t * data, const size_t dataLen, const std::string &tag_name) {
    struct ReporterData reporterData{};
    reporterData.dataLen = dataLen;
    reporterData.data = data;
    if (strncpy_s(reporterData.tag, sizeof(reporterData.tag), tag_name.c_str(), tag_name.size()) != 0) {
        return -1;
    }
    int32_t ret = MsprofReportData(g_moduleId, MsprofReporterCallbackType::MSPROF_REPORTER_REPORT,
        static_cast<void *>(&reporterData), static_cast<uint32_t>(sizeof(struct ReporterData)));
    return ret;
}

int32_t Init()
{
    static uint32_t reporter_max_len = 1;
    auto ret = MsprofReportData(g_moduleId, MSPROF_REPORTER_INIT, nullptr, 0);
    if (ret != 0) {
        return -1;
    }
    // report max len
    ret = MsprofReportData(g_moduleId, MSPROF_REPORTER_DATA_MAX_LEN, &reporter_max_len, sizeof(uint32_t));
    if (ret != 0) {
        return -1;
    }
    return 0;
}

int32_t UnInit()
{
    auto ret = MsprofReportData(g_moduleId, MSPROF_REPORTER_UNINIT, nullptr, 0);
    if (ret != 0) {
        return -1;
    }
    return 0;
}


int32_t ReportRuntimeTrackData()
{
    return DataMgr().ReadFile("host_runtime_track_data.txt", [](ifstream &ifs){
        MsprofCompactInfo data;
        bool ageFlag;
        data.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
        data.dataLen = 0;
        data.data.runtimeTrack.taskType = 0;
        ifs >> ageFlag;
        ifs >> data.type;
        ifs >> data.level;
        ifs >> data.threadId;
        ifs >> data.timeStamp;
        ifs >> data.data.runtimeTrack.deviceId;
        ifs >> data.data.runtimeTrack.streamId;
        ifs >> data.data.runtimeTrack.taskId;
        MsprofRegTypeInfo(MSPROF_REPORT_RUNTIME_LEVEL, data.type, "task_track");
        auto ret = MsprofReportCompactInfo(ageFlag, (void *)&data, sizeof(MsprofCompactInfo));
        if (ret != 0 ) {
            return -1;
        }
        return 0;
    });
}

int32_t ReportNodeBasicInfoData()
{
    return DataMgr().ReadFile("host_node_basic_data.txt", [](ifstream &ifs){

        MsprofCompactInfo data;
        bool ageFlag;
        data.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
        data.dataLen = 0;
        data.data.nodeBasicInfo.taskType = 0;
        data.data.nodeBasicInfo.blockDim = 0;
        data.data.nodeBasicInfo.opFlag = 0;
        string opName;
        string opType;
        ifs >> ageFlag;
        ifs >> data.type;
        ifs >> data.level;
        ifs >> data.threadId;
        ifs >> data.timeStamp;
        ifs >> opName;
        ifs >> opType;
        data.data.nodeBasicInfo.opName = MsprofGetHashId(opName.c_str(), opName.size());
        data.data.nodeBasicInfo.opType = MsprofGetHashId(opType.c_str(), opType.size());
        MsprofRegTypeInfo(MSPROF_REPORT_NODE_LEVEL, data.type,  "node_basic_info");
        MSPROF_LOGI("ReportNodeBasicInfoData");
        auto ret = MsprofReportCompactInfo(ageFlag, (void *)&data, sizeof(MsprofCompactInfo));
        if (ret != 0 ) {
            return -1;
        }
        return 0;
    });
}

int32_t ReportApiData()
{
    return DataMgr().ReadFile("host_api_data.txt", [](ifstream &ifs){
        MsprofApi data;
        bool ageFlag;
        data.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
        data.itemId = 0;
        ifs >> ageFlag;
        ifs >> data.type;
        ifs >> data.level;
        ifs >> data.threadId;
        ifs >> data.beginTime;
        ifs >> data.endTime;
        auto ret = MsprofReportApi(ageFlag, &data);
        if (ret != 0 ) {
            return -1;
        }
        return 0;
    });
}

int32_t ReportEventData()
{
    return DataMgr().ReadFile("host_event_data.txt", [](ifstream &ifs){
        MsprofEvent data;
        bool ageFlag;
        data.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
        data.itemId = 0;
        ifs >> ageFlag;
        ifs >> data.type;
        ifs >> data.level;
        ifs >> data.threadId;
        ifs >> data.timeStamp;
        ifs >> data.itemId;
        auto ret = MsprofReportEvent(ageFlag, &data);
        if (ret != 0 ) {
            return -1;
        }
        return 0;
    });
}

int32_t ReportContextData()
{
     // kDevice
    return DataMgr().ReadFile("host_context_data.txt", [](ifstream &ifs){
        MsprofAdditionalInfo data;
        bool ageFlag;
        data.magicNumber = MSPROF_REPORT_DATA_MAGIC_NUM;
        MsprofContextIdInfo *contextInfo = reinterpret_cast<MsprofContextIdInfo *>(&data.data);
        ifs >> ageFlag;
        ifs >> data.type;
        ifs >> data.level;
        ifs >> data.threadId;
        ifs >> data.timeStamp;
        uint64_t opName;
        uint32_t ctxIdNum;
        uint32_t ctxIds;
        ifs >> opName;
        ifs >> ctxIdNum;
        ifs >> ctxIds;
        contextInfo->opName = opName;
        contextInfo->ctxIdNum = ctxIdNum;
        contextInfo->ctxIds[0] = ctxIds;
        auto ret = MsprofReportAdditionalInfo(ageFlag, (void *)&data, sizeof(MsprofAdditionalInfo));
        if (ret != 0 ) {
            return -1;
        }
        return 0;
    });
}

int32_t ReportProfilingData()
{
    MSPROF_LOGI("ReportNodeBasicInfoData");
    if (ReportNodeBasicInfoData() != 0) {
        return -1;
    }
    MSPROF_LOGI("ReportRuntimeTrackData");
    if (ReportRuntimeTrackData() != 0) {
        return -1;
    }
    MSPROF_LOGI("ReportApiData");
    if (ReportApiData() != 0) {
        return -1;
    }
    MSPROF_LOGI("ReportEventData");
    if (ReportEventData() != 0) {
        return -1;
    }
    MSPROF_LOGI("ReportContextData");
    if (ReportContextData() != 0) {
        return -1;
    }
    return 0;
}

int32_t ExecuteOp()
{
    if (ReportNodeBasicInfoData() != 0) {
        return -1;
    }
    if (ReportRuntimeTrackData() != 0) {
        return -1;
    }
    if (ReportApiData() != 0) {
        return -1;
    }
    if (ReportContextData() != 0) {
        return -1;
    }
    return 0;
}

int32_t HandleProfInitCommand(const MsprofCommandHandle * /* command */)
{
    Init();
    return 0;
}

int32_t HandleProfFinalizeCommand(const MsprofCommandHandle * /* command */)
{
    UnInit();
    return 0;
}

int32_t HandleProfStartCommand(const MsprofCommandHandle * /* command */)
{
    if (g_subscribe_count == 0) {
        Init();
    }
    g_subscribe_count++;
    return 0;
}

int32_t HandleProfStopCommand(const MsprofCommandHandle * /* command */)
{
    g_subscribe_count--;
    if (g_subscribe_count == 0) {
        UnInit();
    }
    return 0;
}

int32_t HandleProfModelSubscribeCommand(const MsprofCommandHandle * /* command */)
{
    return 0;
}

int32_t HandleProfModelUnsubscribeCommand(const MsprofCommandHandle * /* command */)
{
    return 0;
}

int32_t LoadModel(uint32_t *modelId)
{
    if (MsprofSetDeviceIdByGeModelIdx(*modelId, g_deviceId) != 0) {
        return -1;
    }
    return 0;
}

int32_t UnloadModel(uint32_t /* modelId */)
{
    return 0;
}

int32_t ExecuteModel(uint32_t /* modelId */)
{
    return ReportProfilingData();
}

int32_t HandleSwitch(MsprofCommandHandle* command)
{
    auto type = command->type;
    static const std::map<uint32_t, std::function<uint32_t(const MsprofCommandHandle *)>> cmds = {
        {PROF_COMMANDHANDLE_TYPE_INIT, &HandleProfInitCommand},
        {PROF_COMMANDHANDLE_TYPE_FINALIZE, &HandleProfFinalizeCommand},
        {PROF_COMMANDHANDLE_TYPE_START, &HandleProfStartCommand},
        {PROF_COMMANDHANDLE_TYPE_STOP, &HandleProfStopCommand},
        {PROF_COMMANDHANDLE_TYPE_MODEL_SUBSCRIBE, &HandleProfModelSubscribeCommand},
        {PROF_COMMANDHANDLE_TYPE_MODEL_UNSUBSCRIBE, &HandleProfModelUnsubscribeCommand}};
    const auto iter = cmds.find(type);
    if (iter == cmds.end()) {
        MSPROF_LOGE("Unsupported command check");
        return -1;
    } else {
        return iter->second(command);
    }
    return 0;
}

int32_t HandleCtrlSetStepInfo()
{
    return 0;
}

int32_t ProfCtrlHandle(uint32_t dataType, void *data, uint32_t dataLen)
{
    if (data == nullptr || dataLen == 0) {
        MSPROF_LOGE("invalid data or dataLen");
        return -1;
    }
    MsprofCommandHandle* command = (MsprofCommandHandle*)data;
    switch (dataType) {
        case PROF_CTRL_SWITCH:
            HandleSwitch(command);
            break;
        case PROF_CTRL_STEPINFO:
            HandleCtrlSetStepInfo();
            break;
        default:
            break;
    }
    return 0;

}
}