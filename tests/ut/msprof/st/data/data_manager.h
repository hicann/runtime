/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DATA_MANAGER_H
#define DATA_MANAGER_H

#include <string>
#include <fstream>
#include <functional>
#include <queue>
#include <set>
#include "data_struct_stub.h"

struct RunnerOpInfo {
    uint32_t flag;
    uint32_t threadId;
    std::string opName;
    uint64_t opCostTime;
    uint64_t aicoreCostTime;
    // gradient_split only
    std::string modelName;
    std::string opType;
    uint64_t start;
    uint64_t end;
    bool operator < (const struct RunnerOpInfo &other) const
    {
        if (opCostTime != other.opCostTime) {
            return opCostTime < other.opCostTime;
        }
        if (aicoreCostTime != other.aicoreCostTime) {
            return aicoreCostTime < other.aicoreCostTime;
        }
        if (start != other.start) {
            return start < other.start;
        }
        if (end != other.end) {
            return end < other.end;
        }
        if (opType != other.opType) {
            return opType < other.opType;
        }
        if (opName != other.opName) {
            return opName < other.opName;
        }
        return false;
    }
};

using ReportDataCallback = std::function<int32_t(std::ifstream&)>;
namespace Cann {
namespace Dvvp {
namespace Test {
struct Buff {
    void *data;
    size_t len;
};

class DataManager {
public:
    DataManager()
    {
        dataDir_ = "";
        modelId_ = 0;
        streamId_ = 0;
    }
    static DataManager &GetInstance();
    void Init(std::string socType, const char* testcase);
    void UnInit();
    void SetDataDir(const char* dirName);
    int32_t ReadFile(std::string filename, ReportDataCallback callback,  bool needExist = false, bool once = false);
    // report device data
    int32_t ReportTsTimelineData(std::queue<struct Buff> &channelData);
    int32_t ReportTsKeypointData(std::queue<struct Buff> &channelData);
    int32_t ReportHwtsData(std::queue<struct Buff> &channelData);
    int32_t ReportFftsAcsqData(std::queue<struct Buff> &channelData);
    int32_t ReportFftsCtxData(std::queue<struct Buff> &channelData);
    int32_t ReportOpStarsAcsqData(std::queue<struct Buff> &channelData);
    int32_t ReportOpFftsPmuData(std::queue<struct Buff> &channelData);
    int32_t ReportOpDavidPmuData(std::queue<struct Buff> &channelData);
    int32_t ReportStarsNanoData(std::queue<struct Buff> &channelData);
    int32_t ReportDefaultData(std::queue<struct Buff> &channelData);
    int32_t ReportBiuPerfData(std::queue<struct Buff> &channelData);
    // check result
    int32_t CheckSubscribeResult(std::set<RunnerOpInfo> &modelOpInfo, std::string resultFile = "result.txt");
    void SetModelId(uint32_t modelId);
    void SetStreamId(uint32_t stramId);
    uint32_t GetModelId();
    uint32_t GetStreamId();
private:
    std::string socType_;
    std::string dataDir_;
    std::string GetCaseName(const char *testcase);
    uint32_t modelId_;
    uint32_t streamId_;
};
}
}
}

inline Cann::Dvvp::Test::DataManager &DataMgr()
{
    return Cann::Dvvp::Test::DataManager::GetInstance();
}

#endif