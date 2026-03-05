/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <thread>
#include "mockcpp/mockcpp.hpp"
#include "gtest/gtest.h"
#include "msprof_dlog.h"
#include "prof_acl_plugin.h"
#include "prof_cann_plugin.h"
#include "prof_runtime_plugin.h"
#include "errno/error_code.h"
#include "mmpa_api.h"
#include "acl/acl_base.h"
#include "runtime/base.h"
#include "prof_plugin.h"

using namespace analysis::dvvp::common::error;
using namespace ProfAPI;
class PROF_API_PLUGIN_STTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {}
};

rtError_t rtProfilerTraceExStub3(uint64_t indexId, uint64_t modelId, uint16_t tagId, rtStream_t stm)
{
    (void)indexId;
    (void)modelId;
    (void)tagId;
    (void)stm;
    return -1;
}
 
TEST_F(PROF_API_PLUGIN_STTEST, RuntimePluginBase)
{
    std::shared_ptr<ProfRuntimePlugin> plugin;
    plugin = std::make_shared<ProfRuntimePlugin>();
    // Failed to get api stub[rtProfilerTraceEx] func
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RuntimeApiInit());
    EXPECT_EQ(PROFILING_FAILED, plugin->ProfMarkEx(0, 0, 0, nullptr));
    MOCKER(&ProfRuntimePlugin::GetPluginApiFunc)
        .stubs()
        .will(returnValue((void *)&rtProfilerTraceExStub3));
    EXPECT_EQ(PROFILING_FAILED, plugin->ProfMarkEx(0, 0, 0, nullptr));
    plugin->runtimeLibHandle_ = nullptr;
    plugin->runtimeApiInfoMap_.clear();
}

static int32_t ProfStartFuncStub(uint32_t dataType, const void *data, uint32_t length)
{
    (void)dataType;
    (void)data;
    (void)length;
    return 0;
}

static int32_t ProfStopFuncStub(uint32_t dataType, const void *data, uint32_t length)
{
    (void)dataType;
    (void)data;
    (void)length;
    return 0;
}

TEST_F(PROF_API_PLUGIN_STTEST, PROF_START_STOP)
{
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfStart(0, nullptr, 0));
    ProfAPI::ProfCannPlugin::instance()->profStart_ = ProfStartFuncStub;
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfStart(0, nullptr, 0));

    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfStop(0, nullptr, 0));
    ProfAPI::ProfCannPlugin::instance()->profStop_ = ProfStopFuncStub;
    EXPECT_EQ(0, ProfAPI::ProfCannPlugin::instance()->ProfStop(0, nullptr, 0));
}
