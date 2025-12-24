/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <iostream>
#include <algorithm>
#include "device_simulator_manager.h"
#include "data_check.h"
#include "msprof_start.h"
#include "mmpa_api.h"
#include "msprof_stub.h"

namespace Cann {
namespace Dvvp {
namespace Test {
int32_t DataCheck::PreParamsChecker(std::string env)
{
    std::cout<< "Start to pre-check params by msprof input switch" << std::endl;
    MsprofMgr().GetProfilingInput(PreCheckSwitch_);

    if (PreCheckSwitch_.empty()) {
        if (PreCheckDefault(env) != PRE_PARAMS_CHECK_SUCCESS) {
            MSPROF_LOGE("Fail to pass the default pre-params-check");
            return PRE_PARAMS_CHECK_FAILED;
        }

        return PRE_PARAMS_CHECK_SUCCESS;
    }

    for (auto iter = PreCheckSwitch_.begin(); iter != PreCheckSwitch_.end(); iter++) {
        if (PreCheckOnOff(iter->first, iter->second, env) != PRE_PARAMS_CHECK_SUCCESS) {
            MSPROF_LOGE("Coin Switch[%s:%s]: Fail to pass the pre-params-check", iter->first.c_str(), iter->second.c_str());
            return PRE_PARAMS_CHECK_FAILED;
        }

        if (PreCheckBound(iter->first, iter->second, env) != PRE_PARAMS_CHECK_SUCCESS) {
            MSPROF_LOGE("Bound Switch[%s:%s]: Fail to pass the pre-params-check", iter->first.c_str(), iter->second.c_str());
            return PRE_PARAMS_CHECK_FAILED;
        }

        if (PreCheckMapping(env) != PRE_PARAMS_CHECK_SUCCESS) {
            MSPROF_LOGE("Mapping Switch[%s:%s]: Fail to pass the pre-params-check", iter->first.c_str(), iter->second.c_str());
            return PRE_PARAMS_CHECK_FAILED;
        }

        if (PreCheckStorageLimit(iter->first, iter->second, env) != PRE_PARAMS_CHECK_SUCCESS) {
            MSPROF_LOGE("Storage Switch[%s:%s]: Fail to pass the pre-params-check", iter->first.c_str(), iter->second.c_str());
            return PRE_PARAMS_CHECK_FAILED;
        }
        MSPROF_LOGD("Success to pre-check switch[%s:%s].", iter->first.c_str(), iter->second.c_str());
    }

    PreCheckSwitch_.erase(PreCheckSwitch_.begin(), PreCheckSwitch_.end());
    return PRE_PARAMS_CHECK_SUCCESS;
}

int32_t DataCheck::PreCheckOnOff(std::string sw, std::string val, std::string env)
{
    if (val != "on" && val != "off") {
        return PRE_PARAMS_CHECK_SUCCESS;
    }

    std::string point = SLASH + INTERNAL_SWITCH_MAP.at(sw) + COLON + val + SLASH;
    if (env.find(point) != std::string::npos) {
        return PRE_PARAMS_CHECK_SUCCESS;
    }

    return PRE_PARAMS_CHECK_FAILED;
}

int32_t DataCheck::PreCheckBound(std::string sw, std::string val, std::string env)
{
    if (PreCheckIfNumberSwitch(sw, val) == -1) {
        return PRE_PARAMS_CHECK_SUCCESS;
    }

    std::string point = INTERNAL_SWITCH_MAP.at(sw);
    std::string::size_type posFront = env.find(point);
    std::string posBackStr = env.substr(posFront + point.length() + 2);
    std::string::size_type posBack = posBackStr.find_first_of(COMMA);
    uint32_t checkBound = std::stoul(posBackStr.substr(0, posBack));
    if (checkBound >= BOUND_MAP.at(sw)[0] && checkBound <= BOUND_MAP.at(sw)[1]) {
        return PRE_PARAMS_CHECK_SUCCESS;
    }

    return PRE_PARAMS_CHECK_FAILED;
}

int32_t DataCheck::PreCheckMapping(std::string env)
{
    for (auto iter = MAPPING_MAP.begin(); iter != MAPPING_MAP.end(); iter++) {
        std::string point = SLASH + iter->first + COLON + "on" + SLASH;
        if (env.find(point) == std::string::npos) {
            continue;
        }

        for (auto iter2 : iter->second) {
            std::string subPoint = SLASH + iter2 + COLON + "on" + SLASH;
            if (env.find(point) == std::string::npos) {
                return PRE_PARAMS_CHECK_FAILED;
            }
        }
    }

    return PRE_PARAMS_CHECK_SUCCESS;
}

int32_t DataCheck::PreCheckDefault(std::string env)
{
    for (auto iter = DEFAULT_MAP.begin(); iter != DEFAULT_MAP.end(); iter++) {
        std::string point = SLASH + iter->first + COLON + iter->second + SLASH;
        if (env.find(point) == std::string::npos) {
            MSPROF_LOGE("Fail to find: %s", point.c_str());
            return PRE_PARAMS_CHECK_FAILED;
        }
    }

    uint32_t platformType = GetPlatformType();
    for (auto iter = DEFAULT_PLATFORM_MAP.begin(); iter != DEFAULT_PLATFORM_MAP.end(); iter++) {
        if (static_cast<uint32_t>(iter->first) == platformType) {
            std::string point2 = SLASH + iter->second + COLON + "on" + SLASH;
            if (env.find(point2) == std::string::npos) {
                MSPROF_LOGE("Fail to find: %s", point2.c_str());
                return PRE_PARAMS_CHECK_FAILED;
            }
        }
    }
    MSPROF_LOGD("Success to pre-check default switch.");
    return PRE_PARAMS_CHECK_SUCCESS;
}

int32_t DataCheck::PreCheckStorageLimit(std::string sw, std::string val, std::string env)
{
    if (sw.compare("storage-limit") != 0) {
        return PRE_PARAMS_CHECK_SUCCESS;
    }

    int32_t point_n = std::stol(val.substr(0, val.length() - 2));
    if (point_n < BOUND_MAP.at(sw)[0] || point_n > BOUND_MAP.at(sw)[1]) {
        return PRE_PARAMS_CHECK_FAILED;
    }

    std::string point = SLASH + INTERNAL_SWITCH_MAP.at(sw) + COLON + val + SLASH;
    if (env.find(point) != std::string::npos) {
        return PRE_PARAMS_CHECK_SUCCESS;
    }

    return PRE_PARAMS_CHECK_FAILED;
}

int32_t DataCheck::PreCheckIfNumberSwitch(std::string sw, std::string val)
{
    if (sw.compare("sys-devices") == 0) {
        return -1;
    }

    if (sw.compare("delay") == 0 || sw.compare("duration") == 0) {
        return -1;
    }

    for (unsigned int i = 0; i < val.length(); ++i) {
        if (val[i] < '0' || val[i] > '9') {
            return -1;
        }
    }

    return 0;
}

int32_t DataCheck::bitSwitchChecker()
{
    std::vector<uint64_t> bitSwitchCheckList = {};
    std::vector<uint64_t> bitSwitchBlackList = {};
    uint64_t bitSwitch = 0;
    MsprofMgr().GetBitSwitch(bitSwitchCheckList, bitSwitch, bitSwitchBlackList);
    if (bitSwitchCheckList.empty() && bitSwitchBlackList.empty()) {
        return 0;
    }

    if (bitSwitch == 0) {
        MSPROF_LOGE("bitSwitch is 0");
        return -1;
    }

    for (auto &it : bitSwitchCheckList){
        MSPROF_LOGI("Start to check bitSwitch: %llx", it);
        if ((bitSwitch & it) == 0U) {
            MSPROF_LOGE("bitSwitch: %llx not match %llx", bitSwitch, it);
            return -1;
        }
    }

    for (auto &it : bitSwitchBlackList){
        MSPROF_LOGI("Start to check black bitSwitch: %llx", it);
        if ((bitSwitch & it) != 0U) {
            MSPROF_LOGE("bitSwitch: %llx match %llx", bitSwitch, it);
            return -1;
        }
    }

    MSPROF_EVENT("Success to check all bitSwitch in checklist");
    return 0;
}

int32_t DataCheck::flushDataChecker(std::string path, std::string mode)
{
    return HandleDataCheck(path);
}

int32_t DataCheck::CheckData(std::vector<std::string> &dataList, std::vector<std::string> &blackDataList,
    std::string dataPath, std::string dataType)
{
    int32_t ret = ReadDataDir(dataPath, dataType, DATA_DIR);
    if (ret != FLUSH_DATA_CHECK_SUCCESS) {
        MSPROF_LOGE("Fail to get %s data path.", dataType.c_str());
        return FLUSH_DATA_CHECK_FAILED;
    }
    for (auto &data : dataList) {
        MSPROF_LOGI("Data path: %s.", data.c_str());
        MSPROF_LOGI("Start to search flush data for %s.", data.c_str());
        ret = CheckIfFileExist(dataPath, data, true);
        if (ret != FLUSH_DATA_CHECK_SUCCESS) {
            return ret;
        }
    }
    for (auto &data : blackDataList) {
        MSPROF_LOGI("Start to search flush data for %s.", data.c_str());
        ret = CheckIfFileExist(dataPath, data, false);
        if (ret != FLUSH_DATA_CHECK_SUCCESS) {
            return ret;
        }
    }
    return FLUSH_DATA_CHECK_SUCCESS;
}

int32_t DataCheck::HandleDataCheck(std::string &dataPath, std::string dataType)
{
    std::vector<std::string> dataList;
    std::vector<std::string> blackDataList;
    MsprofMgr().GetCheckList(dataList, blackDataList, dataType);
    if (dataList.empty() && blackDataList.empty()) {
        return FLUSH_DATA_CHECK_SUCCESS;
    }
    int32_t deviceRet = CheckData(dataList, blackDataList, dataPath, dataType);
    if (deviceRet != FLUSH_DATA_CHECK_SUCCESS) {
        return deviceRet;
    }
    return FLUSH_DATA_CHECK_SUCCESS;
}

int32_t DataCheck::HandleDataCheck(std::string &dataPath)
{
    auto ret = HandleDataCheck(dataPath, DEVICE_DIR);
    if (ret != FLUSH_DATA_CHECK_SUCCESS) {
        return ret;
    }
    ret = HandleDataCheck(dataPath, HOST_DIR);
    if (ret != FLUSH_DATA_CHECK_SUCCESS) {
        return ret;
    }
    return FLUSH_DATA_CHECK_SUCCESS;
}

int32_t DataCheck::ReadDataDir(std::string &path, std::string dirType, std::string inType)
{
    std::string profDir = MsprofMgr().GetProfDir().empty()? PROF_DIR: MsprofMgr().GetProfDir();
    if (ReadNextDir(path, profDir) != FLUSH_DATA_CHECK_SUCCESS) {
        MSPROF_LOGE("Failed to read prof dir: %s", path.c_str());
        return FLUSH_DATA_CHECK_FAILED;
    }

    if (profDir == "OPPROF") {
        MSPROF_LOGD("Success to read data dir: %s", path.c_str());
        return FLUSH_DATA_CHECK_SUCCESS;
    }

    if (ReadNextDir(path, dirType) != FLUSH_DATA_CHECK_SUCCESS) {
        MSPROF_LOGE("Failed to read %s dir: %s", dirType.c_str(), path.c_str());
        return FLUSH_DATA_CHECK_FAILED;
    }

    path += "/" + inType;
    MSPROF_LOGD("Success to read data dir: %s", path.c_str());
    return FLUSH_DATA_CHECK_SUCCESS;
}

int32_t DataCheck::ReadNextDir(std::string &path, std::string pattern)
{
    bool isExist = false;
    DIR *dir = NULL;
    struct dirent *item = NULL;

    if (path.empty()) {
        MSPROF_LOGE("Failed to find input path");
        return FLUSH_DATA_CHECK_FAILED;
    }

    const char *nextPath = const_cast<char *>(path.c_str());
    if(nextPath != nullptr && nextPath[0] == '\0') {
        MSPROF_LOGE("Failed to find input path");
        return FLUSH_DATA_CHECK_FAILED;
    }
    dir = opendir(nextPath);

    while(true) {
        if (dir == nullptr) {
            MSPROF_LOGE("Failed to find input path");
            return FLUSH_DATA_CHECK_FAILED;
        }
        item = readdir(dir);
        if (item == NULL) {
            break;
        }

        std::string filename = item->d_name;
        MSPROF_LOGI("filename: %s, filename length %d, pattern length: %d", filename.c_str(), filename.length(), pattern.length());
        if (filename.compare(0, pattern.length(), pattern) == 0) { //0: ".";1: "..";2: "PROF*"
            isExist = true;
            std::string currentDir = std::string(item->d_name);
            path += "/" + currentDir;
            break;
        }
    }

    closedir(dir);
    if (!isExist) {
        MSPROF_LOGE("Failed to find data pattern : %s in path : %s", pattern.c_str(), path.c_str());
        return FLUSH_DATA_CHECK_FAILED;
    }

    return FLUSH_DATA_CHECK_SUCCESS;
}

std::string DataCheck::Ltrim(const std::string &str, const std::string &tripString)
{
    size_t start = str.find_first_not_of(tripString);
    return (start == std::string::npos) ? "" : str.substr(start);
}

int32_t DataCheck::CheckIfFileExist(std::string path, std::string pattern, bool exist)
{
    bool isExist = false;
    DIR *dir = NULL;
    struct dirent *item = NULL;
    const std::string tripString = "0123456789-";

    const char *checkPath = const_cast<char *>(path.c_str());
    dir = opendir(checkPath);
    if (dir == nullptr) {
        MSPROF_LOGE("Open path %s faild", path.c_str());        
        return FLUSH_DATA_CHECK_FAILED;
    }

    while(true) {
        item = readdir(dir);
        if (item == NULL) {
            break;
        }
        std::string filename = Ltrim(item->d_name, tripString);
        if (filename.find(pattern) == 0) { // must start with pattern
            isExist = true;
            MSPROF_LOGI("Success to find data: %s", filename.c_str());
            break;
        }
    }

    closedir(dir);
    if (isExist != exist) {
        if (exist) {
            MSPROF_LOGE("Failed to find data pattern : %s in path : %s", pattern.c_str(), path.c_str());
        } else {
            MSPROF_LOGE("File %s expect not exist, but found in path : %s", pattern.c_str(), path.c_str());
        }
        return FLUSH_DATA_CHECK_FAILED;
    }

    return FLUSH_DATA_CHECK_SUCCESS;
}

uint32_t DataCheck::GetPlatformType()
{
    return SimulatorMgr().GetPlatformType();
}
}
}
}