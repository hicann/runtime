/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License");
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <fcntl.h>
#include <unistd.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#define protected public
#include "prof_acl_mgr.h"
#undef protected
#undef private
#include "prof_api.h"
#include "msprofiler_impl.h"

using namespace Msprofiler::Api;
using namespace analysis::dvvp::common::error;

namespace {
class ProfAclMgrStateStest : public testing::Test {
protected:
    void SetUp() override
    {
        GlobalMockObject::reset();
        auto* instance = ProfAclMgr::instance();
        instance->SetModeToOff();
        instance->params_ = nullptr;
        instance->devTasks_.clear();
        instance->subscribeInfos_.clear();
    }

    void TearDown() override
    {
        auto* instance = ProfAclMgr::instance();
        instance->SetModeToOff();
        instance->params_ = nullptr;
        instance->devTasks_.clear();
        instance->subscribeInfos_.clear();
        GlobalMockObject::verify();
    }

    static MsprofCommandHandleParams MakeCommand(const std::string& resultDir, const std::string& profileParams)
    {
        MsprofCommandHandleParams command = {};
        command.pathLen = static_cast<uint32_t>(resultDir.size());
        (void)strncpy(command.path, resultDir.c_str(), sizeof(command.path) - 1);
        command.profDataLen = static_cast<uint32_t>(profileParams.size());
        (void)strncpy(command.profData, profileParams.c_str(), sizeof(command.profData) - 1);
        command.storageLimit = 250;
        return command;
    }
};
} // namespace

TEST_F(ProfAclMgrStateStest, MsprofInitHelperRejectsInvalidInput)
{
    EXPECT_EQ(
        MSPROF_ERROR_CONFIG_INVALID, MsprofInit(MSPROF_CTRL_INIT_HELPER, nullptr, sizeof(MsprofCommandHandleParams)));
}

TEST_F(ProfAclMgrStateStest, MsprofInitHelperRejectsInvalidOutputPath)
{
    const std::string profileParams = R"({"result_dir":"/tmp", "devices":"1", "job_id":"1"})";
    auto command = MakeCommand("/tmp/prof-acl-invalid>", profileParams);
    EXPECT_EQ(MSPROF_ERROR_CONFIG_INVALID, MsprofInit(MSPROF_CTRL_INIT_HELPER, &command, sizeof(command)));
}

TEST_F(ProfAclMgrStateStest, MsprofInitHelperBuildsValidConfig)
{
    const std::string resultDir = "/tmp/prof-acl-helper-stest";
    const std::string profileParams = R"({"result_dir":"/tmp", "devices":"1", "job_id":"1"})";
    auto command = MakeCommand(resultDir, profileParams);
    Utils::RemoveDir(resultDir);
    ASSERT_EQ(PROFILING_SUCCESS, Utils::CreateDir(resultDir));

    EXPECT_EQ(MSPROF_ERROR_NONE, MsprofInit(MSPROF_CTRL_INIT_HELPER, &command, sizeof(command)));
    EXPECT_TRUE(ProfAclMgr::instance()->IsCmdMode());
    EXPECT_EQ(resultDir, ProfAclMgr::instance()->GetResultPath());

    Utils::RemoveDir(resultDir);
}

TEST_F(ProfAclMgrStateStest, SubscribeConfigRejectsInvalidFdAndMetrics)
{
    MsprofConfig config = {};
    uint32_t fd = 1;
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.cacheFlag = 1;
    config.metrics = 0;
    config.fd = static_cast<uintptr_t>(fd);
    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->CheckSubscribeConfig(&config));
    config.fd = 0;
    EXPECT_EQ(ACL_ERROR_INVALID_PARAM, ProfAclMgr::instance()->CheckSubscribeConfig(&config));
}

TEST_F(ProfAclMgrStateStest, SubscribeInfoTracksNewAndRepeatedModel)
{
    int32_t fd = 1024;
    MsprofConfig config = {};
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.fd = reinterpret_cast<uintptr_t>(&fd);
    config.cacheFlag = 1;
    config.metrics = 0;

    auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();
    params->ai_core_metrics = "ArithmeticUtilization";
    const uint64_t dataTypeConfig = ProfAclMgr::instance()->ProfAclGetDataTypeConfig(&config);
    ProfAclMgr::instance()->devTasks_[0] = {1, dataTypeConfig, params};

    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->UpdateSubscribeInfo("model-0", 0, &config));
    EXPECT_EQ(2, ProfAclMgr::instance()->devTasks_[0].count);
    EXPECT_TRUE(ProfAclMgr::instance()->IsModelSubscribed("model-0"));
    ProfSubscribeKey subscribeKey(0U);
    subscribeKey.key = "model-0";
    EXPECT_EQ(fd, ProfAclMgr::instance()->GetSubscribeFdForModel(subscribeKey));

    EXPECT_EQ(ACL_SUCCESS, ProfAclMgr::instance()->UpdateSubscribeInfo("model-0", 0, &config));
    EXPECT_EQ(3, ProfAclMgr::instance()->devTasks_[0].count);

    ProfAclMgr::instance()->devTasks_.clear();
    ProfAclMgr::instance()->subscribeInfos_.clear();
}

TEST_F(ProfAclMgrStateStest, ProfConfigStartRunsSubscribeValidation)
{
    MsprofConfig config = {};
    config.devNums = 1;
    config.devIdList[0] = 0;
    config.fd = 0;
    config.cacheFlag = 0;
    config.metrics = 0;
    EXPECT_EQ(
        ACL_ERROR_INVALID_PARAM,
        Analysis::Dvvp::ProfilerCommon::ProfConfigStart(
            static_cast<uint32_t>(ProfConfigType::PROF_CONFIG_ACL_SUBSCRIBE), &config, sizeof(config)));
}
