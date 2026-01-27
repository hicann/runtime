/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROCMGR_SSTOOWNERMESSAGE_H
#define PROCMGR_SSTOOWNERMESSAGE_H

#include <string>
#include <vector>
#include <map>

enum class ChangeAppResult : uint32_t {
    SUCCESS = 0U,
    FAILED,
    BUSY, // if you call ChangeAppState secondly when the firstly not return, then return BUSY
};
enum class StateResult : uint32_t {
    SUCCESS = 0U,
    FAILED,
};
enum class SsOperSysType : uint32_t {
    DP = 0U,
    SD,
    SEA,
};
enum class GroupOwner : uint32_t {
    DATAMASTER = 0U,
    IAM,
    APPMGR
};
enum class OptionType : uint32_t {
    START = 0U,
    TERM,
    RESTART
};

struct AppInfo {
    AppInfo(const SsOperSysType type, const GroupOwner groupOwner, const std::string name, const OptionType opt)
        : osType(type), groupName(groupOwner), appName(name), optionType(opt){};
    AppInfo()
        : osType(SsOperSysType::DP), groupName(GroupOwner::DATAMASTER), appName(""), optionType(OptionType::START){};
    SsOperSysType osType;
    GroupOwner groupName;
    std::string appName;
    OptionType optionType;
    std::vector<std::string> argument;
    std::map<int32_t, std::vector<std::string>> dynamicPara;
};

enum class AppChangeState : uint32_t {
    SUCCESS = 0U,
    TERM_FAILED,
    START_FAILED,
    RESTART_FAILED,
    INIT,
    PROCESSING,
    START_FAILED_BY_EIO,
};

struct AppChangeInfo {
    AppChangeInfo(const std::string name, const AppChangeState state) : appName(name), changeState(state){};
    AppChangeInfo() = default;
    std::string appName;        // 应用名称
    AppChangeState changeState; // 应用启动/停止的结果
};

enum class SstoOwnerRequestType : uint32_t {
    CHANGE_APP = 0U,
    GET_STATE,
    SET_SYSTEM_STATE,
    RELOAD_CFG,
    DUMP,
    STOP_ALL_APP,
    QUERY_APP_LIST,
    INIT,
    VERIFY,
    QUERY_APP_STATE
};

struct AppInfoForServer {
    AppInfoForServer(const std::string &name, const std::vector<std::string> &argVec)
        : appName(name), arguments(argVec){};
    AppInfoForServer(const std::string &name, const std::vector<std::string> &argVec,
        const std::map<int, std::vector<std::string>> &para)
        : appName(name), arguments(argVec), dynamicPara(para){};
    AppInfoForServer() = default;
    std::string appName;
    std::vector<std::string> arguments;
    std::map<int32_t, std::vector<std::string>> dynamicPara;
};

enum class SysEvent : uint32_t {
    EVENT_WAKEUP = 0U,
};

struct CoreAffinityConfig {
    uint8_t state = 0U;
    int8_t checkNum = 3;
    bool isWakeUpEnable = false;
    uint32_t checkInterval = 1000U; // ms
};

enum class DynamicParaIndex : int32_t {
    EXECV_PATH = 0,
    DEVICE_ID,
    ENV,
    MAX
};

enum class PorcDetailStatus : uint32_t {
    SUB_PROC_STATUS_NORMAL = 0U,
    SUB_PROC_STATUS_EXITED,
    SUB_PROC_STATUS_STOPED,
    SUB_PROC_STATUS_MAX
};

struct AppStatus {
    std::string appName;
    int32_t pid = -1;
    uint32_t status = static_cast<uint32_t>(PorcDetailStatus::SUB_PROC_STATUS_MAX);
};

enum class SsToOwnerClientStub : uint32_t {
    START_PROC_SUCCESS = 0U,
    START_PROC_FAIL_RES_EMPTY,
    START_PROC_FAIL_RES_STATUES_FAIL,
    QUERY_APP_SUCCES,
    QUERY_APP_FAIL_RES_EMPTY,
    QUERY_APP_FAIL_RES_STATUS_FAIL
};
#endif // PROCMGR_SSTOOWNERMESSAGE_H