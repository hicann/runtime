/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <dlfcn.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mmpa_stub.h"
#include <unistd.h>
#include <memory>
#include <thread>
#include <sstream>
#include <iostream>
#include <string>
#include "errno/error_code.h"
#include "securec.h"
#include "message/codec.h"
#include "utils/utils.h"
#include "prof_engine.h"
#include "prof_reporter.h"
#include "engine_mgr.h"
#include "config/config_manager.h"
#include "proto/profiler.pb.h"
#include "uploader_mgr.h"
#include "prof_stamp_pool.h"
#include "msprof_tx_manager.h"
#include "prof_acl_mgr.h"
#include "receive_data.h"
#include "prof_tx_plugin.h"
#include "rpc_data_handle.h"

static uint8_t g_device_id = 0;
static bool createPluginTrue = true;
static bool pluginInitTrue = true;
static std::string moduleName= "counter";
using namespace analysis::dvvp::common::error;
using namespace Msprof::Engine;
using namespace Msprof::MsprofTx;
using namespace analysis::dvvp::proto;

class MSPROF_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

void func_counter(Reporter* reporter) {
    uint64_t loop = 0;
    std::string data_str = "This is func counter test, second send data test.\n";

    while (loop < 5) {
        loop++;
        unsigned char * data = (unsigned char *)malloc(1024);
        memset(data, '\0', 1024);
        memcpy(data, data_str.c_str(), data_str.size());
        ReporterData r_data;
        r_data.deviceId = g_device_id;
        r_data.data = data;
        memcpy(r_data.tag, "tag", 4);
        r_data.dataLen = data_str.size();
        reporter->Report(&r_data);
        free(data);
        usleep(100);
    }
    printf("send data discardable==true finished %lu\n", loop);
    reporter->Flush();
}

class PluginImpl: public PluginIntf {
public:
    explicit PluginImpl(const std::string & module)
    : reporter_(nullptr)
    , module_(module) {

    }
    virtual ~PluginImpl() {
    }

public:
    virtual int Init(const Reporter* reporter) {
        if (pluginInitTrue) {
            reporter_ = const_cast<Reporter*>(reporter);
            t1_ = std::make_shared<std::thread>(&func_counter, reporter_);
            return 0; //PROFILING_SUCCESS;
        } else {
            return -1; //PROFILING_FAILED
        }
    }

    int OnNewConfig(const ModuleJobConfig * config) {
        if (config == nullptr) {
            printf("Input parameter is null\n");
            return -1;
        }

        std::cout<<"==> Module Started:"<<module_<<std::endl;
        for (auto iter = config->switches.begin(); iter != config->switches.end(); ++iter) {
            std::cout<<iter->first<<"="<<iter->second<<std::endl;
        }
        return 0;
    }

    virtual int UnInit() {
        std::cout<<"==> Module Ended:"<<module_<<std::endl;
        t1_->join();
        t1_.reset();
        printf("OnJobEnd finished\n\n");
        return 0;
    }

private:
    Reporter* reporter_;
    std::string module_;
    std::shared_ptr<std::thread> t1_;
};

class EngineImpl_0 : public EngineIntf {
public:
    EngineImpl_0() {}
    virtual ~EngineImpl_0() {}

public:
    virtual PluginIntf * CreatePlugin() {
        if (createPluginTrue) {
            return new PluginImpl(moduleName);
        } else {
            return nullptr;
        }
    }

    virtual int ReleasePlugin(PluginIntf * plugin) {
        if (plugin) {
            delete plugin;
            plugin = nullptr;
        }
        return 0;
    }
};

int GetDiskFreeSpaceStub(const char *path, mmDiskSize *diskSize) {
    std::string paths(path);
    try {
        diskSize->availSize = 6*1024*1024;
    } catch(...) {
        return -1;
    }
    return EN_OK;
}

TEST_F(MSPROF_TEST, init_engine) {
    GlobalMockObject::verify();
    static EngineImpl_0 engine_0;

    MOCKER_CPP(&Msprof::Engine::RpcDataHandle::TryToConnect).stubs().will(returnValue(PROFILING_SUCCESS));

    moduleName = "DATA_PREPROCESS";
    int ret = Msprof::Engine::Init(moduleName, &engine_0);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    moduleName = "DATA_PREPROCESS";
    ret = Msprof::Engine::Init(moduleName, &engine_0);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = Msprof::Engine::Init("aaa", &engine_0);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = EngineMgr::instance()->ProfStart("DATA_PREPROCESS"); //start the module again
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = EngineMgr::instance()->ProfStop("DATA_PREPROCESS"); //stop the registered module
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = EngineMgr::instance()->UnInit("DATA_PREPROCESS");
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(MSPROF_TEST, uninit_engine) {
    GlobalMockObject::verify();
    static EngineImpl_0 engine_0;

    MOCKER_CPP(&Msprof::Engine::RpcDataHandle::TryToConnect).stubs().will(returnValue(PROFILING_SUCCESS));

    moduleName = "DATA_PREPROCESS";
    int ret = Msprof::Engine::Init(moduleName, &engine_0);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = Msprof::Engine::UnInit(moduleName);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = Msprof::Engine::UnInit(moduleName);
    EXPECT_EQ(PROFILING_FAILED, ret);
}

TEST_F(MSPROF_TEST, DoReport) {
    GlobalMockObject::verify();
    Msprof::Engine::ReceiveData recData;
    recData.started_ = true;
    ReporterData reporterData;
    reporterData.tag[0] = 't';
    reporterData.tag[1] = 'e';
    reporterData.tag[2] = 's';
    reporterData.tag[3] = 't';
    reporterData.tag[4] = 0;
    reporterData.deviceId = 64;
    reporterData.dataLen = 5;
    unsigned char data[100] = {"test"};
    reporterData.data = data;

    MOCKER_CPP(&ReceiveData::DoReportData, int32_t (ReceiveData::*)(const ReporterDataChunk &dataChunk))
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, recData.DoReport(&reporterData));
    reporterData.data = nullptr;

    EXPECT_EQ(PROFILING_FAILED, recData.DoReport(&reporterData));
    EXPECT_EQ(PROFILING_FAILED, recData.DoReport(nullptr));
    reporterData.data = data;
    reporterData.dataLen = 321;
    EXPECT_EQ(PROFILING_FAILED, recData.DoReport(&reporterData));
    
    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(-1));
    reporterData.dataLen = 320;
    EXPECT_EQ(PROFILING_FAILED, recData.DoReport(&reporterData));
    EXPECT_EQ(PROFILING_FAILED, recData.DoReport(&reporterData));
}

TEST_F(MSPROF_TEST, ConfigHandler)
{
    GlobalMockObject::verify();

    auto config = std::make_shared<Msprof::Engine::ProfilerJobConfig>();
    EXPECT_EQ(PROFILING_FAILED, EngineMgr::instance()->ConfigHandler("", config));
    EXPECT_EQ(PROFILING_FAILED, EngineMgr::instance()->ConfigHandler("test", config));
    EngineMgr::instance()->jobs_["test"] = nullptr;
    EXPECT_EQ(PROFILING_FAILED, EngineMgr::instance()->ConfigHandler("test", config));
}

TEST_F(MSPROF_TEST, ModuleJob)
{
    GlobalMockObject::verify();
    static EngineImpl_0 engine_0;

    MOCKER_CPP(&Msprof::Engine::RpcDataHandle::TryToConnect).stubs().will(returnValue(PROFILING_SUCCESS));

    ModuleJob moduleJob("DATA_PREPROCESS", engine_0);
    auto config = std::make_shared<Msprof::Engine::ProfilerJobConfig>();
    EXPECT_EQ(PROFILING_FAILED, moduleJob.ProfConfig(config)); // !isStarted_
    EXPECT_EQ(PROFILING_SUCCESS, moduleJob.ProfStart());
    EXPECT_EQ(PROFILING_SUCCESS, moduleJob.ProfStart());

    ModuleConfig moduleConfig;
    moduleConfig.switches["test"] = "test";
    config->modules["DATA_PREPROCESS"] = {moduleConfig};
    EXPECT_EQ(PROFILING_SUCCESS, moduleJob.ProfConfig(config));

    moduleJob.ProfStop();
    MOCKER(&ModuleJob::StartPlugin).stubs().will(returnValue(-1));
    EXPECT_EQ(PROFILING_FAILED, moduleJob.ProfStart());

    MOCKER(&ModuleJob::CreateDumper).stubs().will(returnValue((SHARED_PTR_ALIA<DataDumper>)nullptr));
    EXPECT_EQ(PROFILING_FAILED, moduleJob.ProfStart());
}

TEST_F(MSPROF_TEST, TaskBasedCfgTrfToReq) {
    std::string metrics;
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::DC_TYPE));

    SHARED_PTR_ALIA<Analysis::Dvvp::Host::Adapter::ProfApiStartReq> feature = nullptr;
    feature = std::make_shared<Analysis::Dvvp::Host::Adapter::ProfApiStartReq>();

    Msprofiler::Api::ProfAclMgr::instance()->TaskBasedCfgTrfToReq(
        PROF_AICORE_METRICS_MASK, PROF_AICORE_ARITHMETIC_UTILIZATION, feature);
    EXPECT_EQ("", feature->hwtsLog);

    Msprofiler::Api::ProfAclMgr::instance()->TaskBasedCfgTrfToReq(
        PROF_TASK_TIME_MASK, PROF_AICORE_ARITHMETIC_UTILIZATION, feature);
    EXPECT_EQ("on", feature->hwtsLog);

    Msprofiler::Api::ProfAclMgr::instance()->TaskBasedCfgTrfToReq(
        PROF_AICORE_METRICS_MASK, PROF_AICORE_L2_CACHE, feature);
    EXPECT_EQ("on", feature->hwtsLog);
}

TEST_F(MSPROF_TEST, MsprofTxMemPool)
{
    GlobalMockObject::verify();
    std::shared_ptr<ProfStampPool> stampPool;
    MSVP_MAKE_SHARED0(stampPool, ProfStampPool, break);

    EXPECT_EQ(PROFILING_FAILED, stampPool->Init(10001));
    int ret = stampPool->Init(100);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = stampPool->Init(100);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    MsprofStampInstance *instance = stampPool->CreateStamp();
    EXPECT_NE(nullptr, instance);

    ret = stampPool->MsprofStampPush(instance);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = stampPool->MsprofStampPush(nullptr);
    EXPECT_EQ(PROFILING_FAILED, ret);

    int id = stampPool->GetIdByStamp(instance);
    EXPECT_EQ(0, id);

    MsprofStampInstance *instanceTmp = stampPool->GetStampById(id);
    EXPECT_EQ(instance, instanceTmp);

    id = stampPool->GetIdByStamp(nullptr);
    EXPECT_EQ(PROFILING_FAILED, id);

    instanceTmp = stampPool->MsprofStampPop();
    EXPECT_EQ(instance, instanceTmp);

    instanceTmp = stampPool->MsprofStampPop();
    EXPECT_EQ(nullptr, instanceTmp);

    ret = stampPool->UnInit();
    EXPECT_EQ(PROFILING_FAILED, ret);

    stampPool->DestroyStamp(instance);

    ret = stampPool->UnInit();
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = stampPool->UnInit();
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

int32_t MsprofAdditionalBufPushCallbackStub(uint32_t aging, const VOID_PTR data, uint32_t len)
{
    return 0;
}

TEST_F(MSPROF_TEST, MsprofTxManager)
{
    GlobalMockObject::verify();
    std::shared_ptr<MsprofTxManager> manager;
    MSVP_MAKE_SHARED0(manager, MsprofTxManager, break);

    int ret = manager->Init();
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = manager->SetCategoryName(1, "test");
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = manager->SetStampCategory(nullptr, 1);
    EXPECT_EQ(PROFILING_FAILED, ret);

    std::string msg = "Test msg";
    ret = manager->SetStampTraceMessage(nullptr, msg.c_str(), msg.size());
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = manager->SetStampPayload(nullptr, 0, nullptr);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = manager->Mark(nullptr);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = manager->Push(nullptr);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = manager->Pop();
    EXPECT_EQ(PROFILING_FAILED, ret);

    uint32_t rangeId;
    ret = manager->RangeStart(nullptr, &rangeId);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = manager->RangeStop(rangeId);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ACL_PROF_STAMP_PTR stamp = manager->CreateStamp();
    EXPECT_EQ(nullptr, stamp);

    manager->DestroyStamp(stamp);

    manager->RegisterReporterCallback(MsprofAdditionalBufPushCallbackStub);

    ret = manager->Init();
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = manager->Init();
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    stamp = manager->CreateStamp();
    EXPECT_NE(nullptr, stamp);

    ret = manager->SetCategoryName(1, "test");
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = manager->SetStampCategory(stamp, 1);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = manager->SetStampTraceMessage(stamp, msg.c_str(), msg.size());
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = manager->SetStampPayload(stamp, 0, nullptr);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = manager->Mark(stamp);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = manager->Mark(nullptr);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = manager->Push(stamp);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = manager->Push(nullptr);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = manager->Pop();
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = manager->RangeStart(stamp, &rangeId);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = manager->RangeStop(rangeId);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    manager->DestroyStamp(stamp);
    manager->UnInit();
}

TEST_F(MSPROF_TEST, MsprofTxReportBase)
{
    std::shared_ptr<MsprofTxReporter> report;
    MSVP_MAKE_SHARED0(report, MsprofTxReporter, return);

    MsprofTxInfo data = { 0 };
    // ReporterCallback_ is nullptr
    int32_t ret = report->Report(data);
    EXPECT_EQ(MSPROF_ERROR, ret);
    // Reporter is not inited
    report->SetReporterCallback(MsprofAdditionalBufPushCallbackStub);
    ret = report->Report(data);
    EXPECT_EQ(MSPROF_ERROR, ret);
    // success
    report->Init();
    ret = report->Report(data);
    EXPECT_EQ(0, ret);
    report->UnInit();
}

class EngineImplFmk : public EngineIntf {
public:
    EngineImplFmk() {}
    virtual ~EngineImplFmk() {}

public:
    PluginIntf * CreatePlugin() {
        return new PluginImpl("runtime");
    }

    int ReleasePlugin(PluginIntf * plugin) {
        if (plugin) {
            delete plugin;
            plugin = nullptr;
        }
        return 0;
    }
};
