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
#include "config_manager.h"
#include "proto/profiler.pb.h"
#include "uploader_mgr.h"
#include "prof_stamp_pool.h"
#include "prof_tx_plugin.h"
#define private public
#define protected public
#include "msprof_tx_manager.h"
#include "rpc_dumper.h"
#include "rpc_data_handle.h"
#undef protected
#undef private

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
    MOCKER_CPP(&ReceiveData::WaitAllBufferEmptyEvent)
        .stubs();
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
    MOCKER_CPP(&ReceiveData::WaitAllBufferEmptyEvent)
        .stubs();
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
    MOCKER_CPP(&ReceiveData::WaitAllBufferEmptyEvent)
        .stubs();
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

TEST_F(MSPROF_TEST, DISABLED_MsprofTxMemPool)
{
    GlobalMockObject::verify();
    std::shared_ptr<ProfStampPool> stampPool;
    MSVP_MAKE_SHARED0(stampPool, ProfStampPool, break);

    int ret = stampPool->Init(100);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = stampPool->Init(100);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = stampPool->Init(-1);
    EXPECT_EQ(PROFILING_FAILED, ret);

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

TEST_F(MSPROF_TEST, MsprofTxManager_FAIL)
{
    GlobalMockObject::verify();
    std::shared_ptr<MsprofTxManager> manager;
    MSVP_MAKE_SHARED0(manager, MsprofTxManager, break);

    manager->RegisterReporterCallback(MsprofAdditionalBufPushCallbackStub);
    MOCKER_CPP(&Msprof::MsprofTx::ProfStampPool::Init).stubs().will(returnValue(0));
    MOCKER_CPP(&Msprof::MsprofTx::MsprofTxReporter::Init).stubs().will(returnValue(-1));
    int ret = manager->Init();
    EXPECT_EQ(PROFILING_FAILED, ret);
}

TEST_F(MSPROF_TEST, MsprofTxManager)
{
    GlobalMockObject::verify();
    std::shared_ptr<MsprofTxManager> manager;
    MSVP_MAKE_SHARED0(manager, MsprofTxManager, break);

    MsprofStampInstance stampTest;

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
    
    ret = manager->SetStampTraceMessage(stamp, msg.c_str(), 129);
    EXPECT_EQ(PROFILING_FAILED, ret);

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

int32_t MsprofMarkExCallbackStub(uint64_t indexId, uint64_t modelId, uint16_t tagId, VOID_PTR stm)
{
    return 0;
}


TEST_F(MSPROF_TEST, MarkExBase)
{
    std::shared_ptr<MsprofTxManager> manager;
    MSVP_MAKE_SHARED0(manager, MsprofTxManager, return);
    manager->RegisterReporterCallback(MsprofAdditionalBufPushCallbackStub);
    aclrtStream stream = nullptr;
    // MsprofTxManager is not inited yet
    int32_t ret = manager->MarkEx("abc", strlen("abc"), stream);
    EXPECT_EQ(ret, PROFILING_FAILED);
    // Invalid input param for markEx
    EXPECT_EQ(manager->Init(), PROFILING_SUCCESS);
    ret = manager->MarkEx("abc", strlen("abc"), stream);
    EXPECT_EQ(ret, PROFILING_FAILED);
    // Invalid input param for markEx
    uint32_t tmp = 0;
    stream = &tmp;
    ret = manager->MarkEx(nullptr, 0, stream);
    EXPECT_EQ(ret, PROFILING_FAILED);
    // Invalid input param for markEx
    ret = manager->MarkEx("abc", 1, stream);
    EXPECT_EQ(ret, PROFILING_FAILED);
    // The length of input message should be in range of 1~127
    const char *msg128 = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
    ret = manager->MarkEx(msg128, 128, stream);
    EXPECT_EQ(ret, PROFILING_FAILED);
    ret = manager->MarkEx("", 0, stream);
    EXPECT_EQ(ret, PROFILING_FAILED);
    // Failed to call nullptr rtProfilerTraceEx
    const char *msg127 = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
    ret = manager->MarkEx(msg127, 127, stream);
    EXPECT_EQ(ret, PROFILING_FAILED);
    // Failed to call rtProfilerTraceEx
    manager->RegisterRuntimeTxCallback(MsprofMarkExCallbackStub);
    MOCKER(MsprofMarkExCallbackStub)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    ret = manager->MarkEx(msg127, 127, stream);
    EXPECT_EQ(ret, PROFILING_FAILED);
    // Report profiling data failed
    MOCKER_CPP(&Msprof::MsprofTx::MsprofTxReporter::Report)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    ret = manager->MarkEx(msg127, 127, stream);
    EXPECT_EQ(ret, PROFILING_FAILED);
    // success
    ret = manager->MarkEx(msg127, 127, stream);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    manager->UnInit();
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

TEST_F(MSPROF_TEST, RpcDumper_GetNameAndId_Variants)
{
    GlobalMockObject::verify();
    RpcDumper dumper("");
    // No dash → use module as is
    EXPECT_EQ(PROFILING_SUCCESS, dumper.GetNameAndId("foo"));
    // Single dash, posTmp == pos → fail
    EXPECT_EQ(PROFILING_FAILED, dumper.GetNameAndId("foo-1"));
    // Bad pid integer → fail
    EXPECT_EQ(PROFILING_FAILED, dumper.GetNameAndId("foo-abc-1"));
    // Bad devid integer → fail
    EXPECT_EQ(PROFILING_FAILED, dumper.GetNameAndId("foo-1-abc"));
    // Success: module-pid-devid
    EXPECT_EQ(PROFILING_SUCCESS, dumper.GetNameAndId("foo-100-2"));
}

TEST_F(MSPROF_TEST, RpcDumper_StopFlushNotStarted)
{
    GlobalMockObject::verify();
    RpcDumper dumper("foo-1-2");
    // Not started → Stop returns SUCCESS (no-op branch)
    EXPECT_EQ(PROFILING_SUCCESS, dumper.Stop());
    // Not started → Flush returns SUCCESS (no-op branch)
    EXPECT_EQ(PROFILING_SUCCESS, dumper.Flush());
    // GetReportDataMaxLen always returns RECEIVE_CHUNK_SIZE
    EXPECT_NE(0u, dumper.GetReportDataMaxLen());
}

TEST_F(MSPROF_TEST, RpcDumper_Start_GetNameAndIdFailed)
{
    GlobalMockObject::verify();
    // single dash -> GetNameAndId fails -> Start fails
    RpcDumper dumper("badmod-1");
    EXPECT_EQ(PROFILING_FAILED, dumper.Start());
}

TEST_F(MSPROF_TEST, RpcDumper_Start_TryToConnectFailed)
{
    GlobalMockObject::verify();
    MOCKER_CPP(&Msprof::Engine::RpcDataHandle::TryToConnect)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    RpcDumper dumper("DATA_PREPROCESS-100-2");
    EXPECT_EQ(PROFILING_FAILED, dumper.Start());
}

TEST_F(MSPROF_TEST, RpcDumper_DumpProfileFileChunk_Empty)
{
    GlobalMockObject::verify();
    RpcDumper dumper("foo-1-2");
    std::vector<SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk>> message;
    // Overload that just takes ProfileFileChunk vector - returns SUCCESS
    EXPECT_EQ(PROFILING_SUCCESS, dumper.Dump(message));
}

TEST_F(MSPROF_TEST, RpcDumper_DumpData_NullFileChunk)
{
    GlobalMockObject::verify();
    RpcDumper dumper("foo-1-2");
    std::vector<ReporterDataChunk> message;
    SHARED_PTR_ALIA<FileChunkReq> fileChunk = nullptr;
    // fileChunk is nullptr -> failed
    EXPECT_EQ(PROFILING_FAILED, dumper.DumpData(message, fileChunk));
}

TEST_F(MSPROF_TEST, RpcDumper_DumpData_Success)
{
    GlobalMockObject::verify();
    RpcDumper dumper("foo-1-2");
    std::vector<ReporterDataChunk> message;
    ReporterDataChunk chunk;
    memset(&chunk, 0, sizeof(chunk));
    memcpy(chunk.tag, "tag1", 4);
    chunk.dataLen = 4;
    memcpy(chunk.data, "data", 4);
    chunk.reportTime = 100;
    chunk.deviceId = 0;
    message.push_back(chunk);
    // Two messages -> exercise both branches in DumpData (isFirstMessage and follow-up)
    chunk.reportTime = 200;
    message.push_back(chunk);
    SHARED_PTR_ALIA<FileChunkReq> fileChunk(new FileChunkReq());
    EXPECT_EQ(PROFILING_SUCCESS, dumper.DumpData(message, fileChunk));
}

TEST_F(MSPROF_TEST, RpcDumper_RunDefaultProfileData)
{
    GlobalMockObject::verify();
    RpcDumper dumper("foo-1-2");
    std::vector<SHARED_PTR_ALIA<FileChunkReq>> fileChunks;
    // RunDefaultProfileData is a no-op for RpcDumper -> just exercise it
    dumper.RunDefaultProfileData(fileChunks);
}

TEST_F(MSPROF_TEST, RpcDataHandle_Init_Uninit)
{
    GlobalMockObject::verify();
    RpcDataHandle handle("DATA_PREPROCESS-100-2", "DATA_PREPROCESS", 100, 2);
    // Init is a no-op returning SUCCESS
    EXPECT_EQ(PROFILING_SUCCESS, handle.Init());
    // dataHandle_ is null -> IsReady false
    EXPECT_FALSE(handle.IsReady());
    // dataHandle_ null -> UnInit returns SUCCESS
    EXPECT_EQ(PROFILING_SUCCESS, handle.UnInit());
    // dataHandle_ null -> Flush returns SUCCESS
    EXPECT_EQ(PROFILING_SUCCESS, handle.Flush());
}

TEST_F(MSPROF_TEST, RpcDataHandle_SendData_InvalidParam)
{
    GlobalMockObject::verify();
    RpcDataHandle handle("DATA_PREPROCESS-100-2", "DATA_PREPROCESS", 100, 2);
    // null data -> failed
    EXPECT_EQ(PROFILING_FAILED, handle.SendData(nullptr, 10, "f", "ctx"));
    char data[8] = {0};
    // dataLen 0 -> failed
    EXPECT_EQ(PROFILING_FAILED, handle.SendData(data, 0, "f", "ctx"));
    // dataHandle_ null -> SendData returns SUCCESS (warn branch)
    EXPECT_EQ(PROFILING_SUCCESS, handle.SendData(data, 8, "f", "ctx"));
}

TEST_F(MSPROF_TEST, HdcDataHandle_SendData_InvalidParam)
{
    GlobalMockObject::verify();
    HdcDataHandle handle("DATA_PREPROCESS-100-2", 100, 2);
    // null data -> failed
    EXPECT_EQ(PROFILING_FAILED, handle.SendData(nullptr, 10, "f", "ctx"));
    char data[8] = {0};
    // dataLen 0 -> failed
    EXPECT_EQ(PROFILING_FAILED, handle.SendData(data, 0, "f", "ctx"));
    // hdcSender_ nullptr -> failed
    EXPECT_EQ(PROFILING_FAILED, handle.SendData(data, 8, "f", "ctx"));
    // Flush hdcSender null -> SUCCESS
    EXPECT_EQ(PROFILING_SUCCESS, handle.Flush());
    // UnInit hdcSender null -> SUCCESS
    EXPECT_EQ(PROFILING_SUCCESS, handle.UnInit());
}
