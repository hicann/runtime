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
#include <iostream>
#include <vector>
#include <fstream>
#include <unistd.h>
#include "prof_mgr.h"
#include "msprof_dlog.h"
#include "config/config_manager.h"
#include <sys/inotify.h>
#include "prof_mgr_core.h"
#include "prof_mgr.h"

using namespace Msprof::Engine;
using namespace analysis::dvvp::common::error;

static const std::string feature="{\"startCfg\":[{\"deviceID\":\"1\",\"features\":[{\"name\":\"training_trace\"},{\"name\":\"task_trace\"}]}, \
{\"deviceID\":\"0\",\"features\":[{\"name\":\"training_trace\"},{\"name\":\"task_trace\"}]}]}";

void DO_NOTHING() {}

class PROF_MGR_CORE_STEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(PROF_MGR_CORE_STEST, ProfMgrStartUp)
{
    ProfMgrCfg cfg;
    cfg.startCfg = "{\"startCfg\":[{\"deviceID\":\"1\", \
                                    \"jobID\":\"10086abc-def-ghi\", \
                                    \"features\":[{\"name\":\"training_trace\"}]}]}";
    MOCKER_CPP(&Msprof::Engine::ProfMgr::CreateUuidFile)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    int test = 1;
    MOCKER_CPP(&Msprof::Engine::ProfMgr::NotifyHostStart)
        .stubs()
        .will(returnValue((void*)&test));

    MOCKER_CPP(&Msprof::Engine::ProfMgr::StopParseCfgByFeature)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Msprof ::Engine::ProfMgr::WriteCfgToFile)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Msprof ::Engine::ProfMgr::InotifyCheckResponse)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    void* handle;
    // nullptr
    handle = ProfMgrStartUp(nullptr);
    EXPECT_EQ(nullptr, handle);
    // ok
    handle = ProfMgrStartUp(&cfg);
    EXPECT_EQ(&test, (int*)handle);
    // already started
    handle = ProfMgrStartUp(&cfg);
    EXPECT_EQ(nullptr, handle);
}

TEST_F(PROF_MGR_CORE_STEST, ProfMgrGetConf)
{
    ProfMgrConf *cfg = nullptr;
    ProfMgrGetConf("test", cfg);
    EXPECT_EQ(PROFILING_FAILED, ProfMgrGetConf("test", cfg));
}

class PROF_MGR_STEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(PROF_MGR_STEST, InotifyCheckResponse)
{
    std::shared_ptr<Msprof::Engine::ProfMgr> profMgr(
        new Msprof::Engine::ProfMgr);

    char event_buf[MAX_EVENT_BUFFER_SIZE] = {0};
    struct inotify_event *event = (struct inotify_event*)(event_buf);
    event->len = strlen("test") + 4;
    event->mask = IN_CLOSE_WRITE;
    strcpy(event->name, "test");
    int len = sizeof(struct inotify_event) + event->len;
    MOCKER(read)
        .stubs()
        .with(any(), outBoundP((void *)event, len), any())
        .will(returnValue(0))
        .then(returnValue(len));

    std::string response = "0";
    MOCKER_CPP(&ProfMgr::ReadCfgToFile)
        .stubs()
        .with(any(), outBound(response))
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    std::string name = "test";
    int responseRet = PROFILING_FAILED;

    EXPECT_EQ(PROFILING_FAILED, profMgr->InotifyCheckResponse(name, responseRet));
    EXPECT_EQ(PROFILING_SUCCESS, profMgr->InotifyCheckResponse(name, responseRet));
    EXPECT_EQ(PROFILING_SUCCESS, profMgr->InotifyCheckResponse(name, responseRet));

}

TEST_F(PROF_MGR_STEST, InotifyCheckResponseFail)
{
    std::shared_ptr<Msprof::Engine::ProfMgr> profMgr(
        new Msprof::Engine::ProfMgr);

    char event_buf[MAX_EVENT_BUFFER_SIZE] = {0};
    struct inotify_event *event = (struct inotify_event*)(event_buf);
    event->len = 0;
    int len = sizeof(struct inotify_event) + event->len;
    MOCKER(read)
        .stubs()
        .with(any(), outBoundP((void *)event, len), any())
        .will(returnValue(len));

    std::string name = "test";
    int responseRet = PROFILING_FAILED;
    EXPECT_EQ(PROFILING_FAILED, profMgr->InotifyCheckResponse(name, responseRet));
}

TEST_F(PROF_MGR_STEST, InotifyResponse)
{
    MOCKER(inotify_init)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(select)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(1));

    MOCKER(inotify_rm_watch)
        .stubs()
        .will(returnValue(-1));

    int responseRet = PROFILING_SUCCESS;
    MOCKER_CPP(&Msprof::Engine::ProfMgr::InotifyCheckResponse)
        .stubs()
        .with(any(), outBound(responseRet))
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    std::shared_ptr<Msprof::Engine::ProfMgr> profMgr(
        new Msprof::Engine::ProfMgr);

    std::string name = "test";

    MOCKER(&analysis::dvvp::common::utils::Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    int ret = profMgr->InotifyResponse(name);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = profMgr->InotifyResponse(name);
    EXPECT_EQ(PROFILING_FAILED, ret);
    ret = profMgr->InotifyResponse(name);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(PROF_MGR_STEST, WriteCfgToFileFailed)
{
    std::shared_ptr<Msprof::Engine::ProfMgr> profMgr(
        new Msprof::Engine::ProfMgr);

    std::string file = "/home/test/test_profiling.log";
    std::string context = "";
    int ret = profMgr->WriteCfgToFile(file, context);
    EXPECT_EQ(PROFILING_FAILED, ret);
}

TEST_F(PROF_MGR_STEST, ProcessResultDir)
{
    std::shared_ptr<Msprof::Engine::ProfMgr> profMgr(
        new Msprof::Engine::ProfMgr);

    std::shared_ptr<analysis::dvvp::proto::MsProfStartReq> feature(
        new analysis::dvvp::proto::MsProfStartReq);

    std::string path("/tmp/default/profiler");
    MOCKER(analysis::dvvp::common::utils::Utils::GetSelfPath)
        .stubs()
        .will(returnValue(path));
    MOCKER(analysis::dvvp::common::utils::Utils::IsDir)
        .stubs()
        .will(returnValue(1));

    // use default
    EXPECT_EQ(PROFILING_SUCCESS, profMgr->ProcessResultDir("", feature));
    // nullptr
    EXPECT_EQ(PROFILING_FAILED, profMgr->ProcessResultDir("test", nullptr));
    // default
    EXPECT_EQ(PROFILING_SUCCESS, profMgr->ProcessResultDir("default", feature));
    EXPECT_EQ("/tmp/default/", feature->result_path());
    // user set
    system("mkdir -p /tmp/user_set");
    EXPECT_EQ(PROFILING_SUCCESS, profMgr->ProcessResultDir("/tmp/user_set", feature));
    EXPECT_EQ("/tmp/user_set", feature->result_path());
}

TEST_F(PROF_MGR_STEST, StartParseCfgByFeature)
{
    MOCKER_CPP(&Msprof::Engine::ProfMgr::ProcessByFeature)
        .stubs()
        .will(returnValue(PROFILING_FAILED));

    Msprof::Engine::MsprofStartCfg cfg;
    cfg.startCfg = "test";

    std::shared_ptr<Msprof::Engine::ProfMgr> profMgr(
        new Msprof::Engine::ProfMgr);

    std::vector<std::string> feat;
    feat.push_back("0");
    feat.push_back("test");
    Msprof::Engine::MsprofStartCfg *ptr = profMgr->StartParseCfgByFeature(feat);
    EXPECT_TRUE(ptr != nullptr);

    delete ptr;
}

TEST_F(PROF_MGR_STEST, StopParseCfgByFeature)
{
    MOCKER_CPP(&Msprof::Engine::ProfMgr::ProcessByFeature)
        .stubs()
        .will(returnValue(PROFILING_FAILED));


    Msprof::Engine::MsprofStartCfg cfg;
    cfg.startCfg = "{}";
    cfg.feature.push_back("0");
    cfg.feature.push_back("1");
    cfg.feature.push_back("default_path");
    cfg.feature.push_back("task_trace");

    std::shared_ptr<Msprof::Engine::ProfMgr> profMgr(
        new Msprof::Engine::ProfMgr);

    int ret = profMgr->StopParseCfgByFeature(cfg);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(PROF_MGR_STEST, ReadCfgToFile)
{
    std::shared_ptr<Msprof::Engine::ProfMgr> profMgr(
        new Msprof::Engine::ProfMgr);

    std::string file = "/home/no_exist_dir/file_name";
    std::string context = "test1234";
    int ret = profMgr->ReadCfgToFile(file, context);
    EXPECT_EQ(PROFILING_FAILED, ret);

    file = "profiling.cfg";
    system("mkdir -p /tmp/msprof/event");
    ret = profMgr->WriteCfgToFile(file, context);

    file = "/tmp/msprof/event/profiling.cfg";
    std::string result;

    system("rm /tmp/msprof/event/profiling.cfg");
    system("touch /tmp/msprof/event/profiling.cfg");
    ret = profMgr->ReadCfgToFile(file, result);
    EXPECT_EQ(PROFILING_FAILED, ret);

    system("rm -rf /tmp/msprof/event");
}

TEST_F(PROF_MGR_STEST, ReadCfgToFileEmpty)
{
    std::shared_ptr<Msprof::Engine::ProfMgr> profMgr(
        new Msprof::Engine::ProfMgr);

    std::string file = "hwts.log.xxxxx";
    std::string context = "";
    int ret = profMgr->ReadCfgToFile(file, context);
    EXPECT_EQ(PROFILING_FAILED, ret);
}

TEST_F(PROF_MGR_STEST, GetConf)
{
    GlobalMockObject::verify();
    std::shared_ptr<Msprof::Engine::ProfMgr> profMgr(
        new Msprof::Engine::ProfMgr);
    ProfMgrConf profMgrconf = {};
    EXPECT_EQ(PROFILING_FAILED, profMgr->GetConf("", &profMgrconf));
    const std::string profPath("./profile.cfg");
    std::string cfg ="events={\"events\":[{\"ai_core_events\":\"asd\",\"L2_cache_events\":\"asd\"},{\"ai_core_events\":\"asd\"}]}";

    std::ofstream ifs(profPath);
    ifs << cfg;
    ifs.close();

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetProfCfgPath)
        .stubs()
        .will(returnValue(profPath));
    int ret = profMgr->GetConf("test", &profMgrconf);
    EXPECT_EQ(PROFILING_FAILED, ret);
    ::remove(profPath.c_str());
}

TEST_F(PROF_MGR_STEST, ProfRunBeat)
{
    std::shared_ptr<Msprof::Engine::ProfMgr> profMgr(new Msprof::Engine::ProfMgr);
    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK));

    EXPECT_EQ(PROFILING_SUCCESS, profMgr->ProfRunBeat("JOBXXX", "0"));
}

TEST_F(PROF_MGR_STEST, HeartbeatRun)
{
    std::shared_ptr<ProfMgr::ProfMgrHeartbeat> hb(new ProfMgr::ProfMgrHeartbeat("JOBXXX", "invalid_path"));
    hb->Run();
}

TEST_F(PROF_MGR_STEST, NotifyHostStart)
{
    std::shared_ptr<Msprof::Engine::ProfMgr> profMgr(new Msprof::Engine::ProfMgr);
    MOCKER_CPP(&Msprof::Engine::ProfMgr::WriteCfgToFile)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Msprof::Engine::ProfMgr::InotifyResponse)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK));

    std::vector<std::string> fes;
    std::string taskId = "JOBXXX";
    std::string devId = "1";
    fes.push_back(devId);
    // write error
    EXPECT_EQ(nullptr, profMgr->NotifyHostStart(fes, taskId, devId));
    // notify error
    EXPECT_EQ(nullptr, profMgr->NotifyHostStart(fes, taskId, devId));
    // ok
    EXPECT_TRUE(profMgr->NotifyHostStart(fes, taskId, devId) != nullptr);
}
