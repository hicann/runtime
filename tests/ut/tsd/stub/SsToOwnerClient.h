/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROCMGR_SSTOOWNERCLIENT_H
#define PROCMGR_SSTOOWNERCLIENT_H
#include "SsToOwnerMessage.h"
class SsToOwnerClient {
public:
    SsToOwnerClient(SsToOwnerClient const &) = delete;

    virtual ~SsToOwnerClient() {}

    static SsToOwnerClient &GetInstance();

    uint32_t ChangeAppState(const std::vector<AppInfo> &changeAppList,
                            std::vector<AppChangeInfo> &changeResult, const int32_t timeOut = 5000);
    uint32_t QueryAppState(const std::vector<std::string> &appList, std::vector<AppStatus> &result,
                           const int32_t timeOut = 5000);
    SsToOwnerClient() {}
};

void SetSsToOwnStubFlag(const SsToOwnerClientStub changeFlag, const SsToOwnerClientStub queryFlag);
#endif