/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef MSPROF_START_H
#define MSPROF_START_H
#include <map>
#include <memory>
#include <string>
#include <vector>
#include <iostream>
#include "nlohmann/json.hpp"
#include "mmpa_api.h"
#include "prof_acl_api.h"
#include "msprof_stub.h"

namespace Cann {
namespace Dvvp {
namespace Test {

class MsprofStart {
public:
    ~MsprofStart() {
        deviceCheckList_.clear();
        hostCheckList_.clear();
        inputSwitch_.erase(inputSwitch_.begin(), inputSwitch_.end());
    }
    static MsprofStart &GetInstance();
    void UnInit();
    void ClearSingleton();
    void GetProfilingInput(std::map<std::string, std::string> &sv);
    void DivideMsprofInput(int32_t argc, const char *argv[]);
    int32_t MsprofStartByAppMode(int subArgvCount, const char **subArgv);
    int32_t MsprofStartByAppModeTwo(int subArgvCount, const char **subArgv);
    int32_t MsprofStartBySysMode(int subArgvCount, const char **subArgv);
    int32_t AcpProfileStartByAppMode(int subArgvCount, const char **subArgv);
    void DivideProtoJsonInput(int argvCount, nlohmann::json argv);
    int32_t AclJsonStart(int argvCount, nlohmann::json argv);
    int32_t GeOptionStart(int argvCount, nlohmann::json argv);
    void SetPcSampling(bool pcSample);
    void SetMsprofTx(bool ret);
    void GetCheckList(std::vector<std::string> &dataList, std::vector<std::string> &blackDataList, std::string dataType);
    void SetDeviceCheckList(const std::vector<std::string> &dataList,
        const std::vector<std::string> &blackDataList = std::vector<std::string>());
    void SetHostCheckList(const std::vector<std::string> &dataList,
        const std::vector<std::string> &blackDataList = std::vector<std::string>());
    void SetBitSwitchCheckList(const std::vector<uint64_t> &dataList,
        const std::vector<uint64_t> &blackDataList = std::vector<uint64_t>());
    void GetBitSwitch(std::vector<uint64_t> &dataList, uint64_t &bitSwitch, std::vector<uint64_t> &blackDataList);
    void SetProfDir(std::string dir);
    std::string GetProfDir();
    void SetMsprofConfig(StProfConfigType type);
    void SetSleepTime(int32_t sleepTime);

private:
    MsprofStart() {}
    void SetCheckList(const std::vector<std::string> &srcDataList, const std::vector<std::string> &srcBlackDataList,
        std::vector<std::string> &dstDataList, std::vector<std::string> &dstBlackDataList);
    std::unordered_map<std::string, std::string> inputSwitch_;
    std::vector<std::string> deviceCheckList_;
    std::vector<std::string> deviceBlackCheckList_;
    std::vector<std::string> hostBlackCheckList_;
    std::vector<std::string> hostCheckList_;
    std::vector<uint64_t> bitCheckList_;
    std::vector<uint64_t> bitBlackCheckList_;
    std::string profDir_;
};

}
}
}

inline Cann::Dvvp::Test::MsprofStart &MsprofMgr()
{
    return Cann::Dvvp::Test::MsprofStart::GetInstance();
}
#endif