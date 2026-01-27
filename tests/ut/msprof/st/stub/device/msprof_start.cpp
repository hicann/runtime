/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <fstream>
#include <set>
#include "msprof_start.h"
#include "acl/acl.h"
#include "acl/acl_prof.h"
#include "data_check.h"
#include "data_report_manager.h"
#include "msprof_main.h"
#include "../../st/cli/stub/cli_stub.h"

using namespace std;

namespace Cann {
namespace Dvvp {
namespace Test {
MsprofStart &MsprofStart::GetInstance()
{
    static MsprofStart manager;
    return manager;
}

void MsprofStart::UnInit()
{
    inputSwitch_.clear();
    deviceCheckList_.clear();
    hostCheckList_.clear();
    bitCheckList_.clear();
}

void MsprofStart::ClearSingleton()
{
    ::ClearSingleton();
}

void MsprofStart::GetProfilingInput(map<string, string> &sv)
{
    if (inputSwitch_.empty()) {
        MSPROF_LOGE("Failed to get msprof input switch which is empty");
        return;
    }

    for (auto iter = inputSwitch_.begin(); iter != inputSwitch_.end(); iter++) {
        MSPROF_LOGI("Success to get msprof input switch: %s", iter->first.c_str());
        sv[iter->first] = iter->second;
    }

    MSPROF_EVENT("Success to get all msprof input switch");
}

void MsprofStart::DivideProtoJsonInput(int argvCount, nlohmann::json argv)
{
    std::set<string> digital = {"sys_hardware_mem_freq", "sys_io_sampling_freq", "sys_interconnection_freq", "dvpp_freq", "host_sys_usage_freq", "sys_cpu_freq"};
    if (argvCount == 0) {
        return;
    }
    inputSwitch_.erase(inputSwitch_.begin(), inputSwitch_.end());
    for (auto &it : argv.items()) {
        if (digital.find(it.key()) != digital.end()) {
            inputSwitch_[it.key()] = to_string(it.value());
            MSPROF_LOGI("Success to divide json input switch[%s: %s]", it.key().c_str(), to_string(it.value()));
        } else {
            inputSwitch_[it.key()] = it.value();
            MSPROF_LOGI("Success to divide json input switch[%s: %s]", it.key().c_str(), to_string(it.value()).c_str());
        }
    }

    MSPROF_EVENT("Success to divide all json input switch");
}

void MsprofStart::DivideMsprofInput(int32_t argc, const char *argv[])
{
    inputSwitch_.erase(inputSwitch_.begin(), inputSwitch_.end());
    for(int i = 1; i < argc; i++) {
        string argd(argv[i]);
        if (argd.compare(CROSSBAR.length(), APPLICATION.length(), APPLICATION) == 0 ||
            argd.compare(CROSSBAR.length(), OUTPUT.length(), OUTPUT) == 0) {
            continue;
        }

        string::size_type pos = argd.find(EQAL);
        if (pos == std::string::npos) {
            continue;
        }
        string sw = argd.substr(CROSSBAR.length(), pos - CROSSBAR.length());
        string val = argd.substr(pos + 1);
        inputSwitch_[sw] = val;
        MSPROF_LOGI("Success to divide msprof input switch[%s: %s]", sw.c_str(), val.c_str());
        MSPROF_EVENT("Success to divide msprof input switch[%s: %s]", sw.c_str(), val.c_str());
    }

    MSPROF_EVENT("Success to divide all msprof input switch");
}

void MsprofStart::SetPcSampling(bool pcSample)
{
    DataReportMgr().SetPcSampling(pcSample);
}

void MsprofStart::SetMsprofTx(bool ret)
{
    DataReportMgr().SetMsprofTx(ret);
}

void MsprofStart::SetSleepTime(int32_t sleepTime)
{
    DataReportMgr().SetSleepTime(sleepTime);
}

void MsprofStart::GetCheckList(vector<string> &dataList, vector<string> &blackDataList, string dataType)
{
    dataList.clear();
    if (dataType == DEVICE_DIR) {
        for (auto &it : deviceCheckList_) {
            dataList.emplace_back(it);
        }
        deviceCheckList_.clear();
        for (auto &it : deviceBlackCheckList_) {
            blackDataList.emplace_back(it);
        }
        deviceBlackCheckList_.clear();
    } else if (dataType == HOST_DIR) {
        for (auto &it : hostCheckList_) {
            dataList.emplace_back(it);
        }
        hostCheckList_.clear();
        for (auto &it : hostBlackCheckList_) {
            blackDataList.emplace_back(it);
        }
        hostBlackCheckList_.clear();
    }
}

void MsprofStart::SetCheckList(const vector<string> &srcDataList, const vector<string> &srcBlackDataList,
    vector<string> &dstDataList, vector<string> &dstBlackDataList)
{
    dstDataList.clear();
    for (auto &it : srcDataList) {
        dstDataList.emplace_back(it);
    }
    dstBlackDataList.clear();
    for (auto &it : srcBlackDataList) {
        dstBlackDataList.emplace_back(it);
    }
}

void MsprofStart::SetDeviceCheckList(const vector<string> &dataList, const vector<string> &blackDataList)
{
    SetCheckList(dataList, blackDataList, deviceCheckList_, deviceBlackCheckList_);
}

void MsprofStart::SetHostCheckList(const vector<string> &dataList, const vector<string> &blackDataList)
{
    SetCheckList(dataList, blackDataList, hostCheckList_, hostBlackCheckList_);
}

void MsprofStart::SetBitSwitchCheckList(const vector<uint64_t> &dataList, const vector<uint64_t> &blackDataList)
{
    bitCheckList_.clear();
    bitBlackCheckList_.clear();
    for (auto &it : dataList) {
        bitCheckList_.emplace_back(it);
    }
    for (auto &it : blackDataList) {
        bitBlackCheckList_.emplace_back(it);
    }
}

void MsprofStart::GetBitSwitch(vector<uint64_t> &dataList, uint64_t &bitSwitch, vector<uint64_t> &blackDataList)
{
    dataList.clear();
    blackDataList.clear();
    for (auto &it : bitCheckList_) {
        dataList.emplace_back(it);
    }
    for (auto &it : bitBlackCheckList_) {
        blackDataList.emplace_back(it);
    }
    bitSwitch = DataReportMgr().GetBitSwitch();
}

/*
 * @berif  : Start profiling by Commandline type
 */
int32_t MsprofStart::MsprofStartByAppMode(int subArgvCount, const char **subArgv)
{
    const char* envp[1] = {nullptr};
    const char* BaseArgv[] = {"msprof", "--application=./cli", "--output=./clistest_workspace/output",};
    int BaseArgvLenth = sizeof(BaseArgv) / sizeof(char *);

    ClearSingleton();

    if (subArgvCount == 0) {
        DivideMsprofInput(BaseArgvLenth, BaseArgv);
        return LltMain(BaseArgvLenth, BaseArgv, envp);
    }

    int MergeArgvLenth = sizeof(BaseArgv) / sizeof(char *) + subArgvCount;
    const char* MergeArv[MergeArgvLenth];
    for (int i = 0; i < MergeArgvLenth; i++) {
        if (i < BaseArgvLenth) {
            MergeArv[i] = BaseArgv[i];
        } else {
            MergeArv[i] = subArgv[i - BaseArgvLenth];
        }
        MSPROF_LOGI("MergeArv: %s", string(MergeArv[i]).c_str());
    }

    DivideMsprofInput(MergeArgvLenth, MergeArv);
    return LltMain(MergeArgvLenth, MergeArv, envp);
}

int32_t MsprofStart::MsprofStartByAppModeTwo(int subArgvCount, const char **subArgv)
{
    const char* envp[1] = {nullptr};
    const char* BaseArgv[] = {"msprof", "--output=./clistest_workspace/output"}; // use cli at rear in subArgv
    int BaseArgvLenth = sizeof(BaseArgv) / sizeof(char *);

    ClearSingleton();

    if (subArgvCount == 0) {
        DivideMsprofInput(BaseArgvLenth, BaseArgv);
        return LltMain(BaseArgvLenth, BaseArgv, envp);
    }

    int MergeArgvLenth = sizeof(BaseArgv) / sizeof(char *) + subArgvCount;
    const char* MergeArv[MergeArgvLenth];
    for (int i = 0; i < MergeArgvLenth; i++) {
        if (i < BaseArgvLenth) {
            MergeArv[i] = BaseArgv[i];
        } else {
            MergeArv[i] = subArgv[i - BaseArgvLenth];
        }
        MSPROF_LOGI("MergeArv: %s", string(MergeArv[i]).c_str());
    }

    DivideMsprofInput(MergeArgvLenth, MergeArv);
    return LltMain(MergeArgvLenth, MergeArv, envp);
}

int32_t MsprofStart::MsprofStartBySysMode(int subArgvCount, const char **subArgv)
{
    const char* envp[1] = {nullptr};
    const char* BaseArgv[] = {"msprof", "--output=./clistest_workspace/output", "--sys-period=1", "--sys-devices=0"};
    int BaseArgvLenth = sizeof(BaseArgv) / sizeof(char *);

    ClearSingleton();

    if (subArgvCount == 0) {
        DivideMsprofInput(BaseArgvLenth, BaseArgv);
        return LltMain(BaseArgvLenth, BaseArgv, envp);
    }

    int MergeArgvLenth = sizeof(BaseArgv) / sizeof(char *) + subArgvCount;
    const char* MergeArv[MergeArgvLenth];
    for (int i = 0; i < MergeArgvLenth; i++) {
        if (i < BaseArgvLenth) {
            MergeArv[i] = BaseArgv[i];
        } else {
            MergeArv[i] = subArgv[i - BaseArgvLenth];
        }
        MSPROF_LOGI("MergeArv: %s", string(MergeArv[i]).c_str());
    }

    DivideMsprofInput(MergeArgvLenth, MergeArv);
    if (LltMain(MergeArgvLenth, MergeArv, envp) == -1) {
        return -1;
    }
    Cann::Dvvp::Test::DataCheck CheckInstance;
    uint32_t platformType = CheckInstance.GetPlatformType();
    auto iter = CLI_CHECK_OUTPUT.find(platformType);
    if (iter == CLI_CHECK_OUTPUT.end() || CheckInstance.flushDataChecker(iter->second, "system") != 0) {
        return -1;
    }
    return 0;
}

/*
 * @berif  : Start profiling by acljson type
 */
int32_t MsprofStart::AclJsonStart(int argvCount, nlohmann::json argv)
{
    ClearSingleton();

    DivideProtoJsonInput(argvCount, argv);
    if (argv["output"].empty()) {
        argv["output"] = "./acljsonstest_workspace/output";
    }
    argv["switch"] = "on";

    ofstream jsonFile;
    string acljsonPath = argv["output"];
    // test_dir_test folder for test iterations will not be created
    int32_t pos = acljsonPath.find("test_dir_test");
    if (pos != string::npos) {
        acljsonPath = acljsonPath.substr(0, pos);
    }
    string cmd = "mkdir -p " + acljsonPath;
    system(cmd.c_str());
    acljsonPath += "/acl.json";
    jsonFile.open(acljsonPath, ios::out | ios::app);
    if (!jsonFile.is_open()) {
        MSPROF_LOGE("Can't find or create acl.json file");
    }
    jsonFile << setw(4) << argv;
    jsonFile.close();
    Cann::Dvvp::Test::DataCheck CheckInstance;
    const char * aclConfigPath = static_cast<const char *>(acljsonPath.c_str());
    if (aclInit(aclConfigPath) != ACL_SUCCESS) {
        return -1;
    }

    if (aclrtSetDevice(0) != ACL_SUCCESS) {
        return -1;
    }

    // check if bitSwitch match request
    if (CheckInstance.bitSwitchChecker() != 0) {
        MSPROF_LOGE("bitSwitchChecker failed");
        return -1;
    }

    // report host data by old interface
    if (DataReportMgr().SimulateReport() != 0) {
        return -1;
    }

    uint32_t modelId = 0;
    // load model and report host data
    if (aclmdlLoadFromFile(nullptr, &modelId) != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclmdlLoadFromFile failed");
        return ACL_ERROR_INVALID_PARAM;
    }
#ifndef MSPROF_C
    void *stream = &modelId; // fake stream
    if (DataReportMgr().GetMsprofTx() && aclprofMarkEx("model execute start", strlen("model execute start"), stream) != 0) {
        MSPROF_LOGE("aclprofMarkEx failed");
        return ACL_ERROR_INVALID_PARAM;
    }
#endif
    if (aclmdlExecute(modelId, nullptr, nullptr) != 0) {
        MSPROF_LOGE("aclmdlExecute failed");
        return ACL_ERROR_INVALID_PARAM;
    }

    if (aclmdlUnload(modelId) != 0) {
        MSPROF_LOGE("aclUnLoad failed");
        return ACL_ERROR_INVALID_PARAM;
    }

    if (aclFinalize() != 0) {
        return -1;
    }

    // check if flush file match request
    if (CheckInstance.flushDataChecker(argv["output"], "proto") != 0) {
        return -1;
    }

    return 0;
}

/*
 * @berif  : Start profiling by geoption type
 */
int32_t MsprofStart::GeOptionStart(int argvCount, nlohmann::json argv)
{
    ClearSingleton();

    DivideProtoJsonInput(argvCount, argv);
    if (argv["output"].empty()) {
        argv["output"] = "./geoptionstest_workspace/output";
    }
    argv["aic_metrics"] = "ArithmeticUtilization";
    argv["fp_point"] = "";
    argv["bp_point"] = "";
    argv["training_trace"] = "on";
    argv["task_trace"] = "on";

    ofstream jsonFile;
    jsonFile.open("./geoption.json", ios::out | ios::app);
    if (!jsonFile.is_open()) {
        MSPROF_LOGE("Can't find or create geoption.json file");
    }
    jsonFile << setw(4) << argv;
    jsonFile.close();

    Cann::Dvvp::Test::DataCheck CheckInstance;
    const char * geConfigPath = "./geoption.json";
    if (aclInit(geConfigPath) != ACL_SUCCESS) {
        return -1;
    }

    if (aclrtSetDevice(0) != ACL_SUCCESS) {
        return -1;
    }
    MSPROF_EVENT("Success to aclrtSetDevice");
    // check if bitSwitch match request
    if (CheckInstance.bitSwitchChecker() != 0) {
        return -1;
    }

    // report host data by old interface
    if (DataReportMgr().SimulateReport() != 0) {
        return -1;
    }
    MSPROF_EVENT("Success to SimulateReport");
    uint32_t modelId = 0;
    // load model and report host data
    if (aclmdlLoadFromFile(nullptr, &modelId) != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclmdlLoadFromFile failed");
        return ACL_ERROR_INVALID_PARAM;
    }
#ifndef MSPROF_C
    void *stream = &modelId; // fake stream
    if (DataReportMgr().GetMsprofTx() && aclprofMarkEx("model execute start", strlen("model execute start"), stream) != 0) {
        MSPROF_LOGE("aclprofMarkEx failed");
        return ACL_ERROR_INVALID_PARAM;
    }
#endif
    MSPROF_EVENT("Start to aclmdlExecute");
    if (aclmdlExecute(modelId, nullptr, nullptr) != 0) {
        MSPROF_LOGE("aclmdlExecute failed");
        return ACL_ERROR_INVALID_PARAM;
    }
    MSPROF_EVENT("End to aclmdlExecute");
    if (aclmdlUnload(modelId) != 0) {
        MSPROF_LOGE("aclUnLoad failed");
        return ACL_ERROR_INVALID_PARAM;
    }

    if (aclFinalize() != 0) {
        return -1;
    }

    // check if flush file match request
    if (CheckInstance.flushDataChecker(argv["output"], "proto") != 0) {
        return -1;
    }

    return 0;
}

int32_t MsprofStart::AcpProfileStartByAppMode(int subArgvCount, const char **subArgv)
{
    const char* envp[1] = {nullptr};
    const char* BaseArgv[] = {"acp", "profile", "--output=./cliAcpStest_workspace/output",};
    int BaseArgvLenth = sizeof(BaseArgv) / sizeof(char *);

    ClearSingleton();

    if (subArgvCount == 0) {
        DivideMsprofInput(BaseArgvLenth, BaseArgv);
        return LltAcpMain(BaseArgvLenth, BaseArgv, envp);
    }

    int MergeArgvLenth = sizeof(BaseArgv) / sizeof(char *) + subArgvCount + 1;
    const char* MergeArv[MergeArgvLenth];
    for (int i = 0; i < MergeArgvLenth - 1; i++) {
        if (i < BaseArgvLenth) {
            MergeArv[i] = BaseArgv[i];
        } else {
            MergeArv[i] = subArgv[i - BaseArgvLenth];
        }
        MSPROF_LOGI("MergeArv: %s", string(MergeArv[i]).c_str());
    }
    MergeArv[MergeArgvLenth - 1] = "./cli";
    DivideMsprofInput(MergeArgvLenth, MergeArv);
    return LltAcpMain(MergeArgvLenth, MergeArv, envp);
}

void MsprofStart::SetProfDir(std::string dir)
{
    profDir_ = dir;
}
 
std::string MsprofStart::GetProfDir()
{
    return profDir_;
}

void MsprofStart::SetMsprofConfig(StProfConfigType type)
{
    DataReportMgr().SetMsprofConfig(type);
}
}
}
}