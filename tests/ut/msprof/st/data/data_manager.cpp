/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string.h>
#include "data_manager.h"
#include "data_struct.h"
#include "msprof_stub.h"
#include "securec.h"

#include "prof_api.h"
#ifdef MSPROF_C_CPP
#include "msprof_dlog.h"
#endif

using namespace std;

namespace Cann {
namespace Dvvp {
namespace Test {

DataManager &DataManager::GetInstance()
{
    static DataManager manager;
    return manager;
}

std::string DataManager::GetCaseName(const char* testcase)
{
    size_t len = strlen(testcase);
    std::string casename;
    for (size_t i = 0; i < len; i++) {
        if(std::isupper(testcase[i])) {
            if (i != 0) {
                casename += "_";
            }
            casename += std::tolower(testcase[i]);
        } else {
            casename += testcase[i];
        }
    }
    return casename;
}

void DataManager::Init(std::string socType, const char* testcase)
{
    std::string casename = GetCaseName(testcase);
    socType_ = socType;
    dataDir_ = LLT_DATA_DIR + socType_ + "/" + casename;
    MSPROF_LOGD("Init data manager by testcase : %s", dataDir_.c_str());
}

void DataManager::SetDataDir(const char* dirName)
{
    dataDir_ = LLT_DATA_DIR + socType_ + "/" + dirName;
    MSPROF_LOGD("Set data dir : %s", dataDir_.c_str());
}


void DataManager::UnInit()
{
    dataDir_ = "";
    MSPROF_LOGD("UnInit data manager");
}

void DataManager::SetModelId(uint32_t modelId)
{
    modelId_ = modelId;
}

void DataManager::SetStreamId(uint32_t streamId)
{
    streamId_ = streamId;
}

uint32_t DataManager::GetModelId()
{
    return modelId_;
}

uint32_t DataManager::GetStreamId()
{
    return streamId_;
}

int32_t DataManager::ReadFile(std::string filename, ReportDataCallback callback, bool needExist, bool once)
{
    if (dataDir_.empty()) {
        MSPROF_LOGE("Data manager has not been init, %s", dataDir_.c_str());
        return -1;
    }
    MSPROF_LOGI("ReadFile dataDir_: %s, filename: %s", dataDir_.c_str(), filename.c_str());
    std::string dataFile(dataDir_ + "/" + filename);
    ifstream ifs;
    ifs.open(dataFile, std::ios::in);
    if (!ifs.is_open()) {
        if (needExist) {
            MSPROF_LOGE("File %s not exist.", dataFile.c_str());
            return -1;
        }
        return 0;
    }

    while(!ifs.eof()) {
        if (callback(ifs) != 0) {
            return -1;
        }
        if (once) {
            break;
        }
    }
    return 0;
}


int32_t DataManager::ReportTsTimelineData(std::queue<struct Buff> &channelData)
{
    return ReadFile("device_ts_timeline_data.txt", [&channelData](ifstream &ifs){
        struct Buff buffer;
        buffer.len = sizeof(TsProfileTimeline);
        buffer.data = malloc(buffer.len);
        auto  tsData = (TsProfileTimeline *)buffer.data;

        // bit0-2:Type, bit3:Res0, bit4-7:Cnt
        ifs >> tsData->taskState;
        ifs >> tsData->thread;
        ifs >> tsData->deviceId;
        ifs >> tsData->streamId;
        ifs >> tsData->taskId;
        ifs >> tsData->timestamp;
        tsData->head.rptType = TS_TIMELINE_RPT_TYPE;
        tsData->head.mode = 1;
        tsData->taskType = 1;
        tsData->head.bufSize = buffer.len;
        channelData.push(buffer);
        return 0;
    });
}

int32_t DataManager::ReportTsKeypointData(std::queue<struct Buff> &channelData)
{
    return ReadFile("device_ts_keypoint_data.txt", [&channelData](ifstream &ifs){
        struct Buff buffer;
        buffer.len = sizeof(TsProfileKeypoint);
        buffer.data = malloc(buffer.len);
        auto  tsData = (TsProfileKeypoint *)buffer.data;
        ifs >> tsData->tagId;
        ifs >> tsData->indexId;
        ifs >> tsData->modelId;
        ifs >> tsData->streamId;
        ifs >> tsData->taskId;
        ifs >> tsData->timestamp;
        tsData->head.rptType = TS_KEYPOINT_RPT_TYPE;
        tsData->head.mode = 1;
        tsData->head.bufSize = buffer.len;
        channelData.push(buffer);
        return 0;
    });
}

int32_t DataManager::ReportHwtsData(std::queue<struct Buff> &channelData)
{
    return ReadFile("device_hwts_data.txt", [&channelData](ifstream &ifs){
        struct Buff buffer;
        buffer.len = sizeof(HwtsProfileType01);
        buffer.data = malloc(buffer.len);
        HwtsProfileType01* hwtsData = (HwtsProfileType01 *)buffer.data;

        // bit0-2:Type, bit3:Res0, bit4-7:Cnts
        uint8_t cnt = 1;
        uint8_t rType;
        ifs >> rType;
        ifs >> hwtsData->reserved;
        ifs >> hwtsData->taskId;
        ifs >> hwtsData->streamId;
        ifs >> hwtsData->syscnt;
        hwtsData->cntRes0Type = rType + (cnt << 4);
        hwtsData->hex6bd3 = 0x6bd3;
        channelData.push(buffer);
        return 0;
    });
}

int32_t DataManager::ReportFftsAcsqData(std::queue<struct Buff> &channelData)
{
    return ReadFile("device_ffts_acsq_data.txt", [&channelData](ifstream &ifs){
        struct Buff buffer;
        buffer.len = sizeof(StarsAcsqLog);
        buffer.data = malloc(buffer.len);
        StarsAcsqLog* acsqData = (StarsAcsqLog *)buffer.data;
        uint16_t logType;
        ifs >> logType;
        acsqData->head.logType = logType;
        ifs >> acsqData->taskId;
        ifs >> acsqData->streamId;
        ifs >> acsqData->sysCountHigh;
        ifs >> acsqData->sysCountLow;
        channelData.push(buffer);
        return 0;
    }, false, false);
}

int32_t DataManager::ReportFftsCtxData(std::queue<struct Buff> &channelData)
{
    return ReadFile("device_ffts_ctx_data.txt", [&channelData](ifstream &ifs){
        struct Buff buffer;
        buffer.len = sizeof(StarsCxtLog);
        buffer.data = malloc(buffer.len);
        StarsCxtLog* ctxData = (StarsCxtLog *)buffer.data;
        uint16_t logType;
        ifs >> logType;
        ctxData->head.logType = logType;
        ifs >> ctxData->taskId;
        ifs >> ctxData->streamId;
        ifs >> ctxData->sysCountHigh;
        ifs >> ctxData->sysCountLow;
        channelData.push(buffer);
        return 0;
    });
}

int32_t DataManager::ReportOpStarsAcsqData(std::queue<struct Buff> &channelData)
{
    return ReadFile("device_stars_acsq_data.txt", [&channelData](ifstream &ifs){
        struct Buff buffer;
        buffer.len = sizeof(StarsAcsqLog);
        buffer.data = malloc(buffer.len);
        StarsAcsqLog* acsqData = (StarsAcsqLog *)buffer.data;
        uint16_t logType;
        ifs >> logType;
        acsqData->head.logType = logType;
        ifs >> acsqData->taskId;
        ifs >> acsqData->streamId;
        ifs >> acsqData->sysCountHigh;
        ifs >> acsqData->sysCountLow;
        channelData.push(buffer);
        return 0;
    }, false, false);
}

int32_t DataManager::ReportOpFftsPmuData(std::queue<struct Buff> &channelData)
{
    return ReadFile("device_ffts_pmu_data.txt", [&channelData](ifstream &ifs){
        struct Buff buffer;
        buffer.len = sizeof(Analysis::Dvvp::Analyze::FftsSubProfile);
        buffer.data = malloc(buffer.len);
        Analysis::Dvvp::Analyze::FftsSubProfile* subData = (Analysis::Dvvp::Analyze::FftsSubProfile *)buffer.data;
        uint16_t funcType;
        ifs >> funcType;
        subData->head.funcType = funcType;
        MSPROF_LOGE("ReportOpFftsPmuData funcType = %u", subData->head.funcType);
        ifs >> subData->taskId;
        ifs >> subData->streamId;
        ifs >> subData->contextId;
        uint16_t fftsType;
        ifs >> fftsType;
        subData->fftsType = fftsType;
        subData->contextType = 0;
        ifs >> subData->totalCycle;
        ifs >> subData->pmu[0];
        ifs >> subData->pmu[1];
        ifs >> subData->pmu[2];
        ifs >> subData->pmu[3];
        ifs >> subData->pmu[4];
        ifs >> subData->pmu[5];
        ifs >> subData->pmu[6];
        ifs >> subData->pmu[7];
        channelData.push(buffer);
        return 0;
    }, false, true);
}

int32_t DataManager::ReportOpDavidPmuData(std::queue<struct Buff> &channelData)
{
    return ReadFile("device_david_pmu_data.txt", [&channelData](ifstream &ifs){
        struct Buff buffer;
        buffer.len = sizeof(Analysis::Dvvp::Analyze::DavidProfile);
        buffer.data = malloc(buffer.len);
        Analysis::Dvvp::Analyze::DavidProfile* subData = (Analysis::Dvvp::Analyze::DavidProfile *)buffer.data;
        uint16_t funcType;
        ifs >> funcType;
        subData->head.funcType = funcType;
        ifs >> subData->taskId;
        ifs >> subData->streamId;
        ifs >> subData->contextId;
        ifs >> subData->startCnt;
        ifs >> subData->endCnt;
        subData->contextType = 0;
        ifs >> subData->totalCycle;
        ifs >> subData->pmu[0];
        ifs >> subData->pmu[1];
        ifs >> subData->pmu[2];
        ifs >> subData->pmu[3];
        ifs >> subData->pmu[4];
        ifs >> subData->pmu[5];
        ifs >> subData->pmu[6];
        ifs >> subData->pmu[7];
        ifs >> subData->pmu[8];
        ifs >> subData->pmu[9];
        channelData.push(buffer);
        return 0;
    }, false, true);
}

int32_t DataManager::ReportBiuPerfData(std::queue<struct Buff> &channelData)
{
    const std::vector<std::vector<uint16_t>> biuData = {{0b1110, 0b000000010111, 0b0000000000001110},
        {0b1110, 0b000000010110, 0b0000000000001000}, {0b1110, 0b000000010110, 0b0000000000001000},
        {0b1110, 0b000000010110, 0b0000000000001000}, {0b0011, 0b000000010101, 0b1000000100001111},
        {0b1111, 0b000001111111, 0b1000000000111111}, {0b1111, 0b000000000000, 0b1000000000111111}};
    for (auto row : biuData) {
        struct Buff buffer;
        buffer.len = sizeof(Analysis::Dvvp::Analyze::BiuPerfProfile);
        buffer.data = malloc(buffer.len);
        Analysis::Dvvp::Analyze::BiuPerfProfile* biuperf = (Analysis::Dvvp::Analyze::BiuPerfProfile *)buffer.data;
        biuperf->ctrlType = row[0];
        biuperf->events = row[1];
        biuperf->timeData = row[2];
        channelData.push(buffer);
    }
    return 0;
}

int32_t DataManager::ReportStarsNanoData(std::queue<struct Buff> & /* channelData */)
{
    return 0;
}
int32_t DataManager::ReportDefaultData(std::queue<struct Buff> &channelData)
{
    struct Buff buffer;
    buffer.len = 1024;
    buffer.data = malloc(buffer.len);
    memset_s(buffer.data, 1024, 0, 1024);
    channelData.push(buffer);
    return 0;
}

int32_t DataManager::CheckSubscribeResult(std::set<RunnerOpInfo> &modelOpInfo, std::string resultFile)
{
    auto ret = ReadFile(resultFile, [&](ifstream &ifs){
        RunnerOpInfo opInfo;
        ifs >> opInfo.flag;
        ifs >> opInfo.threadId;
        ifs >> opInfo.opName;
        ifs >> opInfo.opType;
        ifs >> opInfo.opCostTime;
        ifs >> opInfo.start;
        ifs >> opInfo.end;
        ifs >> opInfo.aicoreCostTime;
        MSPROF_LOGD("[Expect] opName : %s, opType : %s, opCostTime : %llu, start ： %llu, end :%llu, aicoreCostTime: %llu",
            opInfo.opName.c_str(), opInfo.opType.c_str(), opInfo.opCostTime, opInfo.start, opInfo.end, opInfo.aicoreCostTime);
        if (modelOpInfo.find(opInfo) == modelOpInfo.end()) {
            MSPROF_LOGE("Cannot find expcet op info");
            for (auto &iter : modelOpInfo) {
                MSPROF_LOGD("[Unmatched] opName : %s, opType : %s, opCostTime : %llu, start ： %llu, end :%llu, aicoreCostTime: %llu",
                    iter.opName.c_str(), iter.opType.c_str(), iter.opCostTime, iter.start, iter.end, iter.aicoreCostTime);
            }
            return -1;
        }
        modelOpInfo.erase(opInfo);
        return 0;
    }, true);
    if (ret != 0) {
        return ret;
    }
    return 0;
}

}
}
}