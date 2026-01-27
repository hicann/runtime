/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "prof_channel_manager.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace Analysis::Dvvp::JobWrapper;

class PROF_CHANNEL_MANAGER_UTEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {

    }
};

TEST_F(PROF_CHANNEL_MANAGER_UTEST, ProfChannelManager_Init) {
    auto entry = ProfChannelManager::instance();
    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK));
    EXPECT_EQ(entry->Init(), PROFILING_SUCCESS);
    EXPECT_NE(nullptr, entry->GetChannelPoller());
}

TEST_F(PROF_CHANNEL_MANAGER_UTEST, ProfChannelManager_UnInit) {
    auto entry = ProfChannelManager::instance();
    // MOCKER_CPP(&analysis::dvvp::transport::ChannelPoll::Stop)
    //     .stubs()
    //     .will(returnValue(PROFILING_SUCCESS));
    MOCKER(mmJoinTask)
        .stubs()
        .will(returnValue(EN_OK));
    EXPECT_NE(nullptr, entry);
    entry->FlushChannel();
    entry->UnInit();
}
