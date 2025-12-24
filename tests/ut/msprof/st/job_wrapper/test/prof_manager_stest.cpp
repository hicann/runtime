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
#include "prof_manager.h"
#include "message.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"

using namespace analysis::dvvp::host;
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::transport;

class JOB_WRAPPER_PROF_MANAGER_STEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(JOB_WRAPPER_PROF_MANAGER_STEST, Handle_IdeCloudProfileProcess) {
    GlobalMockObject::verify();
    MOCKER_CPP(&ProfManager::CheckIfDevicesOnline)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    MOCKER_CPP(&ProfManager::CheckHandleSuc)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));

    MOCKER_CPP(&ProfManager::ProcessHandleFailed)
        .stubs()
        .will(returnValue(PROFILING_FAILED));

    auto entry = analysis::dvvp::host::ProfManager::instance();
    entry->isInited_ = true;
    EXPECT_EQ(PROFILING_FAILED, entry->Handle(nullptr));

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(new analysis::dvvp::message::ProfileParams());
    params->FromString("{\"result_dir\":\"/tmp/\", \"devices\":\"1\",\"is_cancel\":true,\"profiling_mode\":\"def_mode\",\"host_profiling\":\"false\"}");
    entry->isInited_ = false;
    EXPECT_EQ(PROFILING_FAILED, entry->Handle(params));

    entry->isInited_ = true;
    EXPECT_EQ(PROFILING_FAILED, entry->Handle(params));  // Failed to CheckIfDevicesOnline
    EXPECT_EQ(PROFILING_SUCCESS, entry->Handle(params)); // Success to CheckHandleSuc
    EXPECT_EQ(PROFILING_FAILED, entry->Handle(params));  // Failed to ProcessHandleFailed
}
