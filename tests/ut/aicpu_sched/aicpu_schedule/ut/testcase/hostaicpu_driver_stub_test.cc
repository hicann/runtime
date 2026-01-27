/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "ascend_hal.h"
#include "ascend_inpackage_hal.h"
#include "tsd.h"
#include "ts_api.h"
#include "gtest/gtest.h"

class HostCpu1971DriverStubUt : public ::testing::Test {
public:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {}
};

TEST_F(HostCpu1971DriverStubUt, HostCpu1971DriverStubUtSuccess)
{
    Mbuf *mbuf = nullptr;
    uint64_t len = 0;
    poolHandle pHandle;
    halMbufChainGetMbuf(mbuf, 0, &mbuf);
    unsigned int num;
    halMbufChainGetMbufNum(mbuf, &num);
    halMbufChainAppend(mbuf, mbuf);
    halMbufGetDataLen(mbuf, &len);
    halMbufSetDataLen(mbuf, 0);
    halMbufAllocByPool(pHandle, &mbuf);
    halMbufAllocEx(0, 0, 0, 0, &mbuf);

    mpAttr attr;
    struct mempool_t *mp = nullptr;;
    halBuffCreatePool(&attr, &mp);
    halBuffDeletePool(mp);

    halTsDevRecord(0, 0, 0, 0);
    tsDevSendMsgAsync(0, 0, nullptr, 0, 0);
    EXPECT_EQ(CreateOrFindCustPid(0, 0, nullptr, 0, 0, nullptr, 0, nullptr, nullptr), 0);
}