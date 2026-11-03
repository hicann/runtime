/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <chrono>
#include <csignal>
#include <memory>
#include <string>
#include <vector>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "errno/error_code.h"
#include "platform/platform.h"
#include "prof_acl_mgr.h"

#define private public
#define protected public
#include "runtime_system_mode_runner.h"
#undef protected
#undef private

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;

class SYSTEM_MODE_RUNNER_UTEST : public testing::Test {
protected:
    void SetUp() override
    {
        GlobalMockObject::reset();
        hostJobCount_ = 0;
    }

    void TearDown() override { GlobalMockObject::verify(); }

    static int32_t HostJob()
    {
        ++hostJobCount_;
        return PROFILING_SUCCESS;
    }

    static bool SigintShutdownInProgress() { return true; }

    static int32_t hostJobCount_;
};

int32_t SYSTEM_MODE_RUNNER_UTEST::hostJobCount_ = 0;

TEST_F(SYSTEM_MODE_RUNNER_UTEST, StartSysTaskStartsHostAndDevicesInOrder)
{
    auto params = std::make_shared<ProfileParams>();
    params->devices = "0,1";
    params->profiling_period = 0;
    params->host_cpu_profiling = "on";
    analysis::dvvp::runner::RuntimeSystemModeRunner runner(params, "PROF_test");

    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::RecordOutPut)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StartHostJobs)
        .stubs()
        .will(invoke(&SYSTEM_MODE_RUNNER_UTEST::HostJob));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StartDeviceJobs)
        .expects(exactly(2))
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StopTask).stubs();

    EXPECT_EQ(PROFILING_SUCCESS, runner.StartSysTask());
    EXPECT_EQ(1, hostJobCount_);
}

TEST_F(SYSTEM_MODE_RUNNER_UTEST, WaitSysTaskReturnsImmediatelyWithoutPeriod)
{
    auto params = std::make_shared<ProfileParams>();
    params->profiling_period = 0;
    analysis::dvvp::runner::RuntimeSystemModeRunner runner(params, "PROF_test");

    EXPECT_EQ(PROFILING_SUCCESS, runner.WaitSysTask());
}

TEST_F(SYSTEM_MODE_RUNNER_UTEST, WaitSysTaskReportsEarlySignalExit)
{
    auto params = std::make_shared<ProfileParams>();
    params->profiling_period = 60;
    analysis::dvvp::runner::RuntimeSystemModeRunner runner(params, "PROF_test");

    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsSigintShutdownInProgress)
        .stubs()
        .will(invoke(&SYSTEM_MODE_RUNNER_UTEST::SigintShutdownInProgress));
    MOCKER(Utils::UsleepInterupt).stubs();

    EXPECT_EQ(PROFILING_SUCCESS, runner.WaitSysTask());
}

TEST_F(SYSTEM_MODE_RUNNER_UTEST, DeviceFailureStopsStartedTasks)
{
    auto params = std::make_shared<ProfileParams>();
    params->devices = "0,1";
    params->profiling_period = 0;
    analysis::dvvp::runner::RuntimeSystemModeRunner runner(params, "PROF_test");

    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::RecordOutPut)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StartDeviceJobs)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StartHostJobs)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StopTask).expects(once());

    EXPECT_EQ(PROFILING_FAILED, runner.StartSysTask());
}

TEST_F(SYSTEM_MODE_RUNNER_UTEST, SigintInterruptsWaitWithoutLongBlocking)
{
    auto params = std::make_shared<ProfileParams>();
    params->host_cpu_profiling = "on";
    params->profiling_period = 60; // 60s. SIGINT must prevent the full wait.

    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::PlatformInitByDriver)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Msprofiler::Api::ProfAclMgr::IsSigintShutdownInProgress)
        .stubs()
        .will(invoke(&SYSTEM_MODE_RUNNER_UTEST::SigintShutdownInProgress));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::RecordOutPut)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StartHostJobs)
        .stubs()
        .will(invoke(&SYSTEM_MODE_RUNNER_UTEST::HostJob));
    MOCKER_CPP(&analysis::dvvp::runner::RuntimeSystemModeRunner::StopTask).stubs();

    const auto begin = std::chrono::steady_clock::now();
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::runner::RuntimeSystemModeRunner::Run(params, "PROF_test"));
    const auto elapsed = std::chrono::steady_clock::now() - begin;
    EXPECT_LT(std::chrono::duration_cast<std::chrono::milliseconds>(elapsed).count(), 500);
}
