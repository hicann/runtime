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
#include "msprof_params_adapter.h"
#include "message/codec.h"
#include "config/config.h"
#include "config/open/config_manager.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Msprof;

class PROF_PARAM_ADAPTER_OPEN_STEST : public testing::Test {
protected:
  virtual void SetUp() {}
  virtual void TearDown() {}
};

TEST_F(PROF_PARAM_ADAPTER_OPEN_STEST, GenerateLlcEvents) {
    GlobalMockObject::verify();
    std::shared_ptr<Analysis::Dvvp::Msprof::MsprofParamsAdapter> paramsAdapter(
        new Analysis::Dvvp::Msprof::MsprofParamsAdapter);
    std::shared_ptr<analysis::dvvp::message::ProfileParams> srcParams(
            new analysis::dvvp::message::ProfileParams);

    srcParams->hardware_mem = "on";
    srcParams->llc_profiling = "write";
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
            .stubs()
            .will(returnValue(1));
    paramsAdapter->GenerateLlcEvents(srcParams);
    EXPECT_EQ(srcParams->llc_profiling_events, "write");
}


TEST_F(PROF_PARAM_ADAPTER_OPEN_STEST, UpdateParams) {
    GlobalMockObject::verify();
    std::shared_ptr<Analysis::Dvvp::Msprof::MsprofParamsAdapter> paramsAdapter(
        new Analysis::Dvvp::Msprof::MsprofParamsAdapter);
    std::shared_ptr<analysis::dvvp::message::ProfileParams> srcParams(
            new analysis::dvvp::message::ProfileParams);

    srcParams->io_profiling = "on";
    srcParams->interconnection_profiling = "on";
    srcParams->hardware_mem = "on";
    srcParams->cpu_profiling = "on";
    EXPECT_EQ(PROFILING_FAILED, paramsAdapter->UpdateParams(nullptr));
    EXPECT_EQ(PROFILING_SUCCESS, paramsAdapter->UpdateParams(srcParams));

}