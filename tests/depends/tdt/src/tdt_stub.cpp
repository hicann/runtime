/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "tdt/tdt_host_interface.h"
#include "acl_stub.h"

int32_t aclStub::TdtHostInit(uint32_t deviceId)
{
    return 0;
}

int32_t aclStub::TdtHostPreparePopData()
{
    return 0;
}

int32_t aclStub::TdtHostStop(const std::string &channelName)
{
    return 0;
}

int32_t aclStub::TdtHostDestroy()
{
    return 0;
}

int32_t aclStub::TdtHostPushData(const std::string &channelName, const std::vector<tdt::DataItem> &item, uint32_t deviceId)
{
    return 0;
}

int32_t aclStub::TdtHostPopData(const std::string &channelName, std::vector<tdt::DataItem> &item)
{
    return 0;
}

namespace tdt {
    int32_t TdtHostInit(uint32_t deviceId)
    {
        return MockFunctionTest::aclStubInstance().TdtHostInit(deviceId);
    }

    int32_t TdtHostPreparePopData()
    {
        return MockFunctionTest::aclStubInstance().TdtHostPreparePopData();
    }

    int32_t TdtHostStop(const std::string &channelName)
    {
        return MockFunctionTest::aclStubInstance().TdtHostStop(channelName);
    }

    int32_t TdtHostDestroy()
    {
        return MockFunctionTest::aclStubInstance().TdtHostDestroy();
    }

    int32_t TdtHostPushData(const std::string &channelName, const std::vector<DataItem> &item, uint32_t deviceId)
    {
        return MockFunctionTest::aclStubInstance().TdtHostPushData(channelName, item, deviceId);
    }

    int32_t TdtHostPopData(const std::string &channelName, std::vector<DataItem> &item)
    {
        return MockFunctionTest::aclStubInstance().TdtHostPopData(channelName, item);
    }

} //namespace tdt
