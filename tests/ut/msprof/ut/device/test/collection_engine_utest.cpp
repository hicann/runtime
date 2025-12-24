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
#include <sys/wait.h>
#include <sys/time.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libgen.h>
#include <sys/stat.h>
#include <string>
#include <fstream>
#include <iostream>
#include <sstream>
#include "utils/utils.h"
#include "collection_entry.h"
#include "collect_engine.h"
#include "ai_drv_dev_api.h"
#include "ai_drv_prof_api.h"
#include "app/application.h"
#include "prof_timer.h"
#include "uploader_mgr.h"
#include "param_validation.h"
#include "config_manager.h"
#include "prof_channel_manager.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::message;
using namespace Analysis::Dvvp::JobWrapper;

class DEVICE_COLLECTION_ENGINE_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        HDC_SESSION session = (HDC_SESSION)0x12345678;
        _transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
            new analysis::dvvp::transport::HDCTransport(session));
    }
    virtual void TearDown() {
        _transport.reset();
    }
public:
    std::shared_ptr<analysis::dvvp::transport::HDCTransport> _transport;
};

TEST_F(DEVICE_COLLECTION_ENGINE_TEST, CollectEngine_destructor) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::CollectEngine> engine(
            new analysis::dvvp::device::CollectEngine());
    EXPECT_EQ(PROFILING_SUCCESS, engine->Init());
    EXPECT_EQ(PROFILING_SUCCESS, engine->Uinit());
    engine.reset();
}


TEST_F(DEVICE_COLLECTION_ENGINE_TEST, Init) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::CollectEngine> engine(
            new analysis::dvvp::device::CollectEngine());

    EXPECT_EQ(PROFILING_SUCCESS, engine->Init());
}

TEST_F(DEVICE_COLLECTION_ENGINE_TEST, SetDevIdOnHost) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::CollectEngine> engine(
            new analysis::dvvp::device::CollectEngine());

    EXPECT_EQ(PROFILING_SUCCESS, engine->Init());

    engine->collectionJobCommCfg_ =
        std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams>(
        new Analysis::Dvvp::JobWrapper::CollectionJobCommonParams());

    engine->SetDevIdOnHost(0);
    EXPECT_EQ(PROFILING_SUCCESS, engine->Uinit());
}

TEST_F(DEVICE_COLLECTION_ENGINE_TEST, Uinit) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::CollectEngine> engine(
            new analysis::dvvp::device::CollectEngine());

    MOCKER_CPP(&analysis::dvvp::device::CollectEngine::CollectStop)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    engine->isInited_ = true;
    engine->_is_started = true;
    EXPECT_EQ(PROFILING_FAILED, engine->Uinit());
    EXPECT_EQ(PROFILING_SUCCESS, engine->Uinit());
}

static int _drv_get_dev_ids(int num_devices, std::vector<int> & dev_ids) {
    static int phase = 0;
    if (phase == 0) {
        phase++;
        return PROFILING_FAILED;
    }

    if (phase >= 1) {
        dev_ids.push_back(0);
        return PROFILING_SUCCESS;
    }
}

TEST_F(DEVICE_COLLECTION_ENGINE_TEST, CollectStart) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::CollectEngine> engine(
            new analysis::dvvp::device::CollectEngine());
    std::string sampleConfig;
    analysis::dvvp::message::StatusInfo status;

    engine->Init(0);
    engine->isInited_  = true;
    engine->tmpResultDir_ = "./tmp/to/project_dir";
    engine->collectionJobCommCfg_->params = std::shared_ptr<analysis::dvvp::message::ProfileParams>(
        new analysis::dvvp::message::ProfileParams());

    MOCKER_CPP(&analysis::dvvp::device::CollectEngine::InitBeforeCollectStart)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_SUCCESS, engine->CollectStart(sampleConfig, status));
}

TEST_F(DEVICE_COLLECTION_ENGINE_TEST, CollectStop) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::CollectEngine> engine(
            new analysis::dvvp::device::CollectEngine());
    analysis::dvvp::message::StatusInfo status;
    EXPECT_EQ(PROFILING_FAILED, engine->CollectStop(status));
    engine->Init(0);
    engine->_is_started = true;
    engine->tmpResultDir_ = "./tmp/to/project_dir";
    engine->collectionJobCommCfg_->params = std::shared_ptr<analysis::dvvp::message::ProfileParams>(
        new analysis::dvvp::message::ProfileParams());

    MOCKER_CPP(&analysis::dvvp::device::CollectEngine::CollectStopReplay)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER(analysis::dvvp::common::utils::Utils::RemoveDir)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER_CPP(&analysis::dvvp::device::CollectionEntry::FinishCollection)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_FAILED, engine->CollectStop(status));

    engine->_is_started = true;
    engine->tmpResultDir_ = "./tmp/to/project_dir";

    EXPECT_EQ(PROFILING_SUCCESS, engine->CollectStop(status));
}

TEST_F(DEVICE_COLLECTION_ENGINE_TEST, CollectStartReplay) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::CollectEngine> engine(
            new analysis::dvvp::device::CollectEngine());
    engine->Init(1);
    auto ctrl_cpu_event = std::make_shared<std::vector<std::string>>();
    auto ts_cpu_event = std::make_shared<std::vector<std::string>>();
    auto ai_core_event = std::make_shared<std::vector<std::string>>();
    auto ai_core_event_cores = std::make_shared<std::vector<int>>();
    auto aiv_event = std::make_shared<std::vector<std::string>>();
    auto aiv_event_cores = std::make_shared<std::vector<int>>();
    analysis::dvvp::message::StatusInfo status;
    //llc
    auto llc_event = std::make_shared<std::vector<std::string>>();
    //ddr
    auto ddr_event = std::make_shared<std::vector<std::string>>();

    ctrl_cpu_event->push_back("0x11");
    ts_cpu_event->push_back("0x11");
    ai_core_event->push_back("0x11");
    ai_core_event_cores->push_back(1);
    aiv_event->push_back("0x11");
    aiv_event_cores->push_back(1);
    llc_event->push_back("e1,e2");
    ddr_event->push_back("read");
    ddr_event->push_back("write");
    ddr_event->push_back("master_id");

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams);
    params->ai_core_profiling = "on";
    params->ai_core_profiling_mode = "sample-based";
    engine->collectionJobCommCfg_->params = params;
    engine->collectionJobCommCfg_->params->dvpp_profiling = "on";
    engine->collectionJobCommCfg_->params->nicProfiling = "on";
    engine->collectionJobCommCfg_->params->llc_interval = 100;
    engine->collectionJobCommCfg_->params->ddr_interval = 100;
    engine->collectionJobCommCfg_->params->hbmProfiling = "on";
    engine->collectionJobCommCfg_->params->hbm_profiling_events = "read,write";

    MOCKER(analysis::dvvp::common::utils::Utils::ExecCmd)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK));

    engine->_is_started = false;
    EXPECT_EQ(PROFILING_FAILED, engine->CollectStartReplay(
            ctrl_cpu_event,
            status,
            llc_event));
    engine->_is_started = true;
    EXPECT_EQ(PROFILING_FAILED, engine->CollectStartReplay(
            ctrl_cpu_event,
            status,
            llc_event));
}

TEST_F(DEVICE_COLLECTION_ENGINE_TEST, CollectStopReplay) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::CollectEngine> engine(
            new analysis::dvvp::device::CollectEngine());

    auto ctrl_cpu_event = std::make_shared<std::vector<std::string>>();
    auto ts_cpu_event = std::make_shared<std::vector<std::string>>();
    auto ai_cpu_event = std::make_shared<std::vector<std::string>>();
    auto ai_core_event = std::make_shared<std::vector<std::string>>();
    auto ai_core_event_cores = std::make_shared<std::vector<int>>();
    analysis::dvvp::message::StatusInfo status;

    ctrl_cpu_event->push_back("0x11");
    ts_cpu_event->push_back("0x11");
    ai_cpu_event->push_back("0x11");
    ai_core_event->push_back("0x11");
    ai_core_event_cores->push_back(1);

    engine->collectionJobCommCfg_ =
        std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams>(
        new Analysis::Dvvp::JobWrapper::CollectionJobCommonParams());
    engine->collectionJobCommCfg_->devId = 0;
    engine->CreateCollectionJobArray();

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams);
    engine->collectionJobCommCfg_->params = params;
    engine->collectionJobCommCfg_->params->dvpp_profiling = "on";
    engine->collectionJobCommCfg_->params->nicProfiling = "on";

    MOCKER(analysis::dvvp::common::utils::Utils::ExecCmd)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    engine->_is_started = false;
    EXPECT_EQ(PROFILING_FAILED, engine->CollectStopReplay(status));

    engine->_is_started = true;
    EXPECT_EQ(PROFILING_SUCCESS, engine->CollectStopReplay(status));
    EXPECT_EQ(analysis::dvvp::message::SUCCESS, status.status);
    EXPECT_EQ(PROFILING_SUCCESS, engine->CollectStopReplay(status));
    EXPECT_EQ(analysis::dvvp::message::SUCCESS, status.status);

    engine->_is_started = true;
    engine->tmpResultDir_ = "./tmp_result_dir";

    //MOCKER_CPP(&analysis::dvvp::common::thread::Thread::Stop)
    //    .stubs()
    //    .will(returnValue(PROFILING_SUCCESS));
    MOCKER(mmJoinTask)
        .stubs()
        .will(returnValue(EN_OK));

    EXPECT_EQ(PROFILING_SUCCESS, engine->CollectStopReplay(status));
    EXPECT_EQ(analysis::dvvp::message::SUCCESS, status.status);

    engine->_is_started = true;
    engine->tmpResultDir_ = "./tmp_result_dir";
    analysis::dvvp::common::utils::Utils::CreateDir(engine->tmpResultDir_ + "/data");
    EXPECT_EQ(PROFILING_SUCCESS, engine->CollectStopReplay(status));
    EXPECT_EQ(analysis::dvvp::message::SUCCESS, status.status);
    analysis::dvvp::common::utils::Utils::RemoveDir(engine->tmpResultDir_);
}

void fake_get_files(const std::string & dir, bool is_recur, std::vector<std::string>& files) {
    std::string ctrl_cpu_data_path = "./path/to/ctrl_cpu_data_path";
    files.push_back(ctrl_cpu_data_path + ".1");
    files.push_back(ctrl_cpu_data_path + ".2");
    files.push_back("./not_data");
}

int DrvGetDevIds(int num_devices, std::vector<int> & dev_ids) {
    dev_ids.push_back(0);
    return PROFILING_SUCCESS;
}

TEST_F(DEVICE_COLLECTION_ENGINE_TEST, CreateTmpDir) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::CollectEngine> engine(
            new analysis::dvvp::device::CollectEngine());

    engine->collectionJobCommCfg_ =
        std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams>(
        new Analysis::Dvvp::JobWrapper::CollectionJobCommonParams());

    auto app_dirs = std::make_shared<std::vector<std::string>>();
    app_dirs->push_back("./tmp/path/to/app");
    app_dirs->push_back("./tmp/path/to/app/conf");
    app_dirs->push_back("./tmp/path/to/app/bin");
    app_dirs->push_back("./tmp/path/to/app/conf/1.conf");

    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams);
    engine->collectionJobCommCfg_->params = params;
    engine->collectionJobCommCfg_->params->job_id = "123";
    std::string tmp;

    MOCKER(&analysis::dvvp::common::utils::Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    const std::string path = "/tmp/PROFILER_UT/";

    EXPECT_EQ(PROFILING_FAILED, engine->CreateTmpDir(tmp));
    EXPECT_EQ(PROFILING_FAILED, engine->CreateTmpDir(tmp));
    EXPECT_EQ(PROFILING_SUCCESS, engine->CreateTmpDir(tmp));
}

TEST_F(DEVICE_COLLECTION_ENGINE_TEST, CleanupResults) {
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::device::CollectEngine> engine(
            new analysis::dvvp::device::CollectEngine());
    engine->collectionJobCommCfg_ =
        std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCommonParams>(
        new Analysis::Dvvp::JobWrapper::CollectionJobCommonParams());

        //on
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
        new analysis::dvvp::message::ProfileParams);
    engine->collectionJobCommCfg_->params = params;
    engine->collectionJobCommCfg_->params->job_id = "123";
    //null param
    EXPECT_EQ(PROFILING_SUCCESS, engine->CleanupResults());
    engine->tmpResultDir_ = "./tmp/folder";
    EXPECT_EQ(PROFILING_SUCCESS, engine->CleanupResults());

    auto app_dirs = std::make_shared<std::vector<std::string>>();
    app_dirs->push_back("./tmp/path/to/app");
    app_dirs->push_back("./tmp/path/to/app/conf");
    app_dirs->push_back("./tmp/path/to/app/bin");
    app_dirs->push_back("./tmp/path/to/app/conf/1.conf");




    MOCKER(&analysis::dvvp::common::utils::Utils::RemoveDir)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    engine->tmpResultDir_ = "./tmp/folder";
    EXPECT_EQ(PROFILING_SUCCESS, engine->CleanupResults());
}

TEST_F(DEVICE_COLLECTION_ENGINE_TEST, BindFileWithChannel) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::CollectEngine> engine(
            new analysis::dvvp::device::CollectEngine());

    std::string org_file = "1.data";
    EXPECT_STREQ("1.data.1", engine->BindFileWithChannel(org_file, 1).c_str());
}

TEST_F(DEVICE_COLLECTION_ENGINE_TEST, CreateCollectionJobArray) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::CollectEngine> engine(
            new analysis::dvvp::device::CollectEngine());
    EXPECT_NE(nullptr, engine);
     engine->CreateCollectionJobArray();
}

TEST_F(DEVICE_COLLECTION_ENGINE_TEST, CheckPmuEventIsValid) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::CollectEngine> engine(
            new analysis::dvvp::device::CollectEngine());
    EXPECT_NE(nullptr, engine);

    auto ctrl_cpu_event = std::make_shared<std::vector<std::string>>();
    //llc
    auto llc_event = std::make_shared<std::vector<std::string>>();

    ctrl_cpu_event->push_back("0x11");
    llc_event->push_back("e1,e2");


    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckCtrlCpuEventIsValid)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    MOCKER_CPP(&analysis::dvvp::common::validation::ParamValidation::CheckLlcEventsIsValid)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    EXPECT_EQ(PROFILING_FAILED, engine->CheckPmuEventIsValid(ctrl_cpu_event, llc_event));
    EXPECT_EQ(PROFILING_FAILED, engine->CheckPmuEventIsValid(ctrl_cpu_event, llc_event));
    EXPECT_EQ(PROFILING_SUCCESS, engine->CheckPmuEventIsValid(ctrl_cpu_event, llc_event));
}

