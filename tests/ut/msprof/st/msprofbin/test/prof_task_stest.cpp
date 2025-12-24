/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mockcpp/mockcpp.hpp"
#include "gtest/gtest.h"
#include <iostream>
#include "errno/error_code.h"
#include "msprof_task.h"
#include "message/codec.h"
#include "config/config.h"
#include "config/config_manager.h"
#include "info_json.h"
#include "utils/utils.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Msprof;
using namespace analysis::dvvp::host;
using namespace analysis::dvvp::common::utils;

class PROF_TASK_UTEST : public testing::Test {
protected:
    virtual void SetUp() {
      GlobalMockObject::verify();
        result_dir = (".");
        start_time = ("1539226807454372");
        end_time = ("1539226807454372");
    }
    virtual void TearDown() {}
public:
    std::string result_dir;
    std::string start_time;
    std::string end_time;
};

TEST_F(PROF_TASK_UTEST, RpcTaskTest) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
    new analysis::dvvp::message::ProfileParams);
    SHARED_PTR_ALIA<ProfRpcTask> task(new ProfRpcTask(0, params));
    EXPECT_EQ(task->Init(), PROFILING_FAILED);;
    EXPECT_EQ(task->Stop(), PROFILING_SUCCESS);
    task->PostSyncDataCtrl();
    EXPECT_EQ(task->UnInit(), PROFILING_SUCCESS);
}

TEST_F(PROF_TASK_UTEST, GetRankId) {
    GlobalMockObject::verify();
    InfoJson infoJson(start_time, end_time, 1);
    const std::string rankId = "100";
    MOCKER_CPP(&Utils::IsAllDigit)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    MOCKER_CPP(&Utils::HandleEnvString)
        .stubs()
        .will(returnValue(rankId));
    EXPECT_EQ(-1, infoJson.GetRankId());
    EXPECT_EQ(100, infoJson.GetRankId());
}