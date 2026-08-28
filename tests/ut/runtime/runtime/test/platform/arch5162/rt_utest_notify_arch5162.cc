/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "runtime/rt.h"
#include "runtime/rts/rts_event.h"
#include "api_impl.hpp"

using namespace cce::runtime;

class Arch5162NotifyTest : public testing::Test {
protected:
    static void SetUpTestCase() { std::cout << "Arch5162NotifyTest test start" << std::endl; }

    static void TearDownTestCase() { std::cout << "Arch5162NotifyTest test start end" << std::endl; }

    virtual void SetUp() {}

    virtual void TearDown() { GlobalMockObject::verify(); }
};

TEST_F(Arch5162NotifyTest, api_impl_stub)
{
    ApiImpl impl;
    EXPECT_EQ(impl.NotifyGetAddrOffset(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.GetNotifyAddress(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.GetNotifyPhyInfo(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.NotifyReset(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);

    // ipc notify
    EXPECT_EQ(impl.IpcSetNotifyName(nullptr, nullptr, 0, 0), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.IpcOpenNotify(nullptr, nullptr, 0), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.SetIpcNotifyPid(nullptr, nullptr, 0), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.ShrIdSetPodPid(nullptr, 0, 0), RT_ERROR_FEATURE_NOT_SUPPORT);

    // cnt notify
    EXPECT_EQ(impl.CntNotifyCreate(0, nullptr, 0), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.CntNotifyDestroy(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.CntNotifyRecord(nullptr, nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.CntNotifyWaitWithTimeout(nullptr, nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.CntNotifyReset(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.GetCntNotifyAddress(nullptr, nullptr, NOTIFY_TYPE_MAX), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.GetCntNotifyId(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
}
