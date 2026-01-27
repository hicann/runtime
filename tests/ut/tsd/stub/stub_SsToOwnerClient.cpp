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
#include "SsToOwnerClient.h"
SsToOwnerClientStub  g_changeAppStateStubFlag;
SsToOwnerClientStub  g_QueryAppStateStubFlag;

void SetSsToOwnStubFlag(const SsToOwnerClientStub changeFlag, const SsToOwnerClientStub queryFlag)
{
    g_changeAppStateStubFlag = changeFlag;
    g_QueryAppStateStubFlag = queryFlag;
}

SsToOwnerClient &SsToOwnerClient::GetInstance()
{
    static SsToOwnerClient instance;
    return instance;
}

uint32_t SsToOwnerClient::ChangeAppState(const std::vector<AppInfo> &changeAppList,
    std::vector<AppChangeInfo> &changeResult, const int32_t timeOut)
{
    std::cout<<"this is fake ChangeAppState" <<std::endl;
    if (g_changeAppStateStubFlag == SsToOwnerClientStub::START_PROC_SUCCESS) {
        AppChangeInfo tempInfo;
        tempInfo.appName = changeAppList[0].appName;
        if (g_QueryAppStateStubFlag  == SsToOwnerClientStub::QUERY_APP_FAIL_RES_STATUS_FAIL) {
            tempInfo.changeState = AppChangeState::START_FAILED;
        } else {
            tempInfo.changeState = AppChangeState::SUCCESS;
        }
        
        changeResult.push_back(tempInfo);
    } else if (g_changeAppStateStubFlag == SsToOwnerClientStub::START_PROC_FAIL_RES_EMPTY) {
        return 0;
    } else if (g_changeAppStateStubFlag == SsToOwnerClientStub::START_PROC_FAIL_RES_STATUES_FAIL &&
               g_QueryAppStateStubFlag != SsToOwnerClientStub::QUERY_APP_FAIL_RES_STATUS_FAIL) {
        AppChangeInfo tempInfo;
        tempInfo.appName = changeAppList[0].appName;
        tempInfo.changeState = AppChangeState::START_FAILED;
        changeResult.push_back(tempInfo);
    } else if (g_changeAppStateStubFlag == SsToOwnerClientStub::START_PROC_FAIL_RES_STATUES_FAIL &&
               g_QueryAppStateStubFlag == SsToOwnerClientStub::QUERY_APP_FAIL_RES_STATUS_FAIL) {
        return 1;
    }
    return 0;
}

uint32_t SsToOwnerClient::QueryAppState(const std::vector<std::string> &appList, std::vector<AppStatus> &result,
    const int32_t timeOut)
{
    std::cout<<"this is fake QueryAppState" <<std::endl;
    AppStatus tempInfo;
    tempInfo.appName = appList[0];
    tempInfo.pid = 1;
    if (g_QueryAppStateStubFlag == SsToOwnerClientStub::QUERY_APP_SUCCES) {
        tempInfo.status = static_cast<uint32_t>(PorcDetailStatus::SUB_PROC_STATUS_NORMAL);
        result.push_back(tempInfo);
    } else if (g_changeAppStateStubFlag == SsToOwnerClientStub::QUERY_APP_FAIL_RES_EMPTY) {
        return 0;
    } else if (g_changeAppStateStubFlag == SsToOwnerClientStub::QUERY_APP_FAIL_RES_STATUS_FAIL) {
        tempInfo.status = static_cast<uint32_t>(PorcDetailStatus::SUB_PROC_STATUS_EXITED);
        result.push_back(tempInfo);
    } else if (g_changeAppStateStubFlag == SsToOwnerClientStub::START_PROC_FAIL_RES_STATUES_FAIL &&
               g_QueryAppStateStubFlag == SsToOwnerClientStub::QUERY_APP_FAIL_RES_STATUS_FAIL) {
        return 1;
    }
    return 0;
}
