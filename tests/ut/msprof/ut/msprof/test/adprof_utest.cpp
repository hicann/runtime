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
#include "error_code.h"
#include "config.h"
#include "utils.h"
#include "adprof_collector.h"
#include "adprof_collector_proxy.h"
#include "aicpu_report_hdc.h"
#include "prof_perf_job.h"
#include "prof_sys_info_job.h"
#include "platform/platform.h"
#include "devprof_drv_adprof.h"
#include "rpc_data_handle.h"
#include "prof_dev_api.h"
#include "ascend_inpackage_hal.h"

using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::JobWrapper;

extern int32_t CheckBindHostPid(const char *arg);
extern int32_t StartAdprof();
extern "C" bool GetIsExit(void);
extern int32_t ProfStopAdprof(struct prof_sample_stop_para *para);

drvError_t drvGetLocalDevIDByHostDevID(uint32_t devIndex, uint32_t *hostDeviceId)
{
    *hostDeviceId = devIndex;
    return DRV_ERROR_NONE;
}

class ADPROF_UTEST : public testing::Test {
protected:
    virtual void SetUp()
    {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(ADPROF_UTEST, CheckBindHostPid)
{
    std::string hostPid("");
    EXPECT_EQ(PROFILING_FAILED, CheckBindHostPid(hostPid.c_str()));
    hostPid = "host_pid:test";
    EXPECT_EQ(PROFILING_FAILED, CheckBindHostPid(hostPid.c_str()));
    uint32_t getHostPid = OsalGetPid();
    hostPid = "host_pid:" + std::to_string(getHostPid);
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .with(any(), any(), any(), outBoundP(&getHostPid, sizeof(getHostPid)), any())
        .will(returnValue(DRV_ERROR_NO_PROCESS))
        .then(returnValue(DRV_ERROR_INVALID_VALUE))
        .then(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(PROFILING_FAILED, CheckBindHostPid(hostPid.c_str()));
    EXPECT_EQ(PROFILING_SUCCESS, CheckBindHostPid(hostPid.c_str()));
}

TEST_F(ADPROF_UTEST, AdprofInit)
{
    EXPECT_EQ(false, AdprofCollector::instance()->AdprofStarted());
    EXPECT_EQ(PROFILING_FAILED, AdprofCollector::instance()->StartCollectJob());
    std::map<std::string, std::string> kvPairs;
    kvPairs["dev_id"] = "0";
    kvPairs["cpu_profiling"] = "on";
    kvPairs["sys_profiling"] = "on";
    kvPairs["pid_profiling"] = "on";
    kvPairs["msprof_llc_profiling"] = "on";
    kvPairs["profiling_period"] = "10";
    auto ret = AdprofCollector::instance()->Init(kvPairs);

    EXPECT_EQ(PROFILING_SUCCESS, ret);
    EXPECT_EQ(true, AdprofCollector::instance()->AdprofStarted());
    EXPECT_EQ(false, GetIsExit());
    EXPECT_EQ(PROFILING_SUCCESS, AdprofCollector::instance()->StartCollectJob());
    EXPECT_EQ(PROFILING_SUCCESS, AdprofCollector::instance()->UnInit());
    EXPECT_EQ(false, AdprofCollector::instance()->AdprofStarted());
}

TEST_F(ADPROF_UTEST, AdprofCollectorProxy) 
{
    analysis::dvvp::ProfileFileChunk dataChunk1;
    dataChunk1.isLastChunk = false;
    dataChunk1.chunkModule = 0;
    dataChunk1.chunk = "22222222222222222222";
    dataChunk1.offset = -1;
    dataChunk1.chunkSize = 20;
    dataChunk1.fileName = "";
    dataChunk1.extraInfo = "";
    dataChunk1.id = "";
    auto dataChunkPtr1 = std::make_shared<analysis::dvvp::ProfileFileChunk>(dataChunk1);

    auto retStarted = AdprofCollectorProxy::instance()->AdprofStarted();
    EXPECT_EQ(false, retStarted);
    auto retReport = AdprofCollectorProxy::instance()->Report(dataChunkPtr1);
    EXPECT_EQ(PROFILING_FAILED, retReport);

    AdprofCollectorProxy::instance()->BindFunction(
        std::bind(&AdprofCollector::Report, AdprofCollector::instance(), std::placeholders::_1),
        std::bind(&AdprofCollector::AdprofStarted, AdprofCollector::instance())
    );
    std::map<std::string, std::string> kvPairs = {
        {"host_pid", "123"}, {"dev_id", "0"}, {"sys_profiling", "on"}
    };
    AdprofCollector::instance()->Init(kvPairs);
    EXPECT_EQ(true, AdprofCollectorProxy::instance()->AdprofStarted());
    MOCKER_CPP(ReportAdprofFileChunk)
    .stubs()
    .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, AdprofCollectorProxy::instance()->Report(dataChunkPtr1));
    AdprofStop();
}

TEST_F(ADPROF_UTEST, AdprofBinFunc)
{
    constexpr int argc = 4;
    char* argv[argc] = {"adprof", "host_pid:123", "dev_id:1", "profiling_period:1"};
    EXPECT_EQ(PROFILING_FAILED, AdprofStart(0, (const char**)argv));
    EXPECT_EQ(PROFILING_SUCCESS, AdprofStart(argc, (const char**)argv));
    prof_sample_stop_para stopPara = {0};
    EXPECT_EQ(PROFILING_SUCCESS, ProfStopAdprof(&stopPara));
}

TEST_F(ADPROF_UTEST, StartAdprof) 
{
    std::map<std::string, std::string> kvPairs = {
        {"host_pid", "123"}, {"job_id", "1"}, {"dev_id", "0"}, {"profiling_period", "1"} 
    };
    AdprofCollector::instance()->Init(kvPairs);
    EXPECT_EQ(PROFILING_SUCCESS, StartAdprof());
}

extern int LltMain(int argc, const char *argv[]);
TEST_F(ADPROF_UTEST, AdprofBin)
{
    constexpr int argc = 2;
    char* argv[argc];
    argv[0] = "adprof";
    argv[1] = "profiling_period:10";
    EXPECT_EQ(PROFILING_FAILED, LltMain(argc, (const char**)argv));
}

TEST_F(ADPROF_UTEST, AdprofBinGetHostPidFailed) 
{
    char* argv [] = {"adprof", "profiling_period:10", "0", "", ""};
    // get host pid failed
    EXPECT_EQ(PROFILING_FAILED, LltMain(sizeof(argv) / sizeof(argv[0]), (const char**)argv));
}

TEST_F(ADPROF_UTEST, AdprofBinUTestCheckHostPidFailed)
{
    char* argv[] = {"adprof", "host_pid:12345", "0", "", ""};
    // Check bind host pid failed
    EXPECT_EQ(PROFILING_FAILED, LltMain(sizeof(argv) / sizeof(argv[0]), (const char**)argv));
}

TEST_F(ADPROF_UTEST, AdprofBinUTestGetDevicePidFailed)
{
    uint32_t getHostPid = 12345;
    char* argv[] = {"adprof", "host_pid:12345", "0", "", ""};
    //  not find device id
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .with(any(), any(), any(), outBoundP(&getHostPid), any())
        .will(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(PROFILING_FAILED, LltMain(sizeof(argv) / sizeof(argv[0]), (const char**)argv));
}

TEST_F(ADPROF_UTEST, AdprofBinDlopenFailed)
{
    uint32_t getHostPid = 12345;
    char* argv[] = {"adprof", "host_pid:12345", "dev_id:0", "", ""};
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .with(any(), any(), any(), outBoundP(&getHostPid, sizeof(uint32_t)), any())
        .will(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(PROFILING_SUCCESS, LltMain(sizeof(argv) / sizeof(argv[0]), (const char**)argv));
}

TEST_F(ADPROF_UTEST, AdprofBinDlsymFailed)
{
    uint32_t getHostPid = 12345;
    char* argv[] = {"adprof", "host_pid:12345", "dev_id:0", "", ""};
    void *handle = (void*)1;
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .with(any(), any(), any(), outBoundP(&getHostPid, sizeof(uint32_t)), any())
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(mmDlopen)
        .stubs()
        .will(returnValue(handle));
    MOCKER(mmDlclose)
        .stubs()
        .will(returnValue(0));
    MOCKER(mmDlsym)
        .stubs()
        .will(returnValue((void*)nullptr));
    EXPECT_EQ(PROFILING_SUCCESS, LltMain(sizeof(argv) / sizeof(argv[0]), (const char**)argv));
}

int32_t AdprofStartStub(int32_t argc, const char** argv) { return 0; }
bool GetIsExitStub(void) { return true; }
TEST_F(ADPROF_UTEST, AdprofBinDlsymGetIsExitFailed)
{
    uint32_t getHostPid = 12345;
    char* argv[] = {"adprof", "host_pid:12345", "dev_id:0", "", ""};
    void *handle = (void*)1;
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .with(any(), any(), any(), outBoundP(&getHostPid, sizeof(uint32_t)), any())
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(mmDlopen)
        .stubs()
        .will(returnValue(handle));
    MOCKER(mmDlclose)
        .stubs()
        .will(returnValue(0));
    MOCKER(mmDlsym)
        .stubs()
        .will(returnValue((void*)&AdprofStartStub))
        .then(returnValue((void*)nullptr));
    EXPECT_EQ(PROFILING_SUCCESS, LltMain(sizeof(argv) / sizeof(argv[0]), (const char**)argv));
}

TEST_F(ADPROF_UTEST, AdprofBinSuccess)
{
    uint32_t getHostPid = 12345;
    char* argv[] = {"adprof", "host_pid:12345", "dev_id:0", "", ""};
    void *handle = (void*)1;
    MOCKER(drvQueryProcessHostPid)
        .stubs()
        .with(any(), any(), any(), outBoundP(&getHostPid, sizeof(uint32_t)), any())
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(mmDlopen)
        .stubs()
        .will(returnValue(handle));
    MOCKER(mmDlclose)
        .stubs()
        .will(returnValue(0));
    MOCKER(mmDlsym)
        .stubs()
        .will(returnValue((void*)&AdprofStartStub))
        .then(returnValue((void*)&GetIsExitStub));
    EXPECT_EQ(PROFILING_SUCCESS, LltMain(sizeof(argv) / sizeof(argv[0]), (const char**)argv));
}

TEST_F(ADPROF_UTEST, AicpuReportHdc)
{
    EXPECT_EQ(false, AicpuReportHdc::instance()->started_);

    char *data = "1111";
    ReporterData reporterData = {"DATA_PREPROCESS", 1, strlen(data), (unsigned char *)data};
    int32_t ret = AdprofReportData(static_cast<VOID_PTR>(&reporterData), static_cast<uint32_t>(sizeof(ReporterData)));
    EXPECT_EQ(PROFILING_FAILED, ret);

    std::string moduleName = "DATA_PREPROCESS-123-1";
    MOCKER_CPP(&Msprof::Engine::RpcDataHandle::TryToConnect)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, AicpuReportHdc::instance()->Init(moduleName));
    EXPECT_EQ(true, AicpuReportHdc::instance()->started_);

    ret = AdprofReportData(static_cast<VOID_PTR>(&reporterData), static_cast<uint32_t>(sizeof(ReporterData)));
    EXPECT_EQ(PROFILING_SUCCESS, ret);
    EXPECT_EQ(PROFILING_SUCCESS, AdprofAicpuStop());
}

TEST_F(ADPROF_UTEST, AdprofModifyParam)
{
    AdprofCollector::instance()->UnInit();
    int myInt = 10;
    std::map<std::string, std::string> myMap = {{"dev_id", "1"}, {"job_id", "1"}, {"key1", "20"}};
    AdprofCollector::instance()->Init(myMap);
    AdprofCollector::instance()->ModifyParam(myInt, "key1");
    AdprofCollector::instance()->UnInit();
    EXPECT_EQ(20, myInt);

    std::string myString = "fixme";
    std::map<std::string, std::string> myMap3 = {{"dev_id", "1"}, {"job_id", "1"}, {"key3", "fixed"}};
    AdprofCollector::instance()->Init(myMap3);
    AdprofCollector::instance()->ModifyParam(myString, "key3");
    AdprofCollector::instance()->UnInit();
    EXPECT_EQ("fixed", myString);
}

TEST_F(ADPROF_UTEST, AdprofSpilitChunk)
{
    analysis::dvvp::ProfileFileChunk dataChunk;
    dataChunk.isLastChunk = false;
    dataChunk.chunkModule = 3;
    dataChunk.chunk = "1perf test";
    dataChunk.offset = 18446744073709551615;
    dataChunk.chunkSize = 10;
    dataChunk.fileName = "data/ai_ctrl_cpu.data.";
    dataChunk.extraInfo = ".";
    dataChunk.id = "";
    auto dataChunkPtr = std::make_shared<analysis::dvvp::ProfileFileChunk>(dataChunk);
    auto fileChunks = AdprofCollector::instance()->SpilitChunk(*dataChunkPtr, 1031);
    for (const auto& fileChunk : fileChunks) {
        EXPECT_EQ(10, fileChunk.chunk.length());
        EXPECT_EQ(10, fileChunk.chunkSize);
    }

    analysis::dvvp::ProfileFileChunk dataChunk1;
    dataChunk1.isLastChunk = false;
    dataChunk1.chunkModule = 0;
    dataChunk1.chunk = "22222222222222222222";
    dataChunk1.offset = -1;
    dataChunk1.chunkSize = 20;
    dataChunk1.fileName = "";
    dataChunk1.extraInfo = "";
    dataChunk1.id = "";
    auto dataChunkPtr1 = std::make_shared<analysis::dvvp::ProfileFileChunk>(dataChunk1);
    auto fileChunks1 = AdprofCollector::instance()->SpilitChunk(*dataChunkPtr1, 3);
    EXPECT_EQ(7, fileChunks1.size());
    for (const auto& fileChunk : fileChunks1) {
        EXPECT_EQ(true, fileChunk.chunk.length() <= 3);
    }
}

class AnotherClass {
public:
    AnotherClass(
        std::function<int(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk>)> reportFunc=nullptr,
        std::function<bool()> AdprofStartedFunc=nullptr
    ) : ReportFunctionPointer(reportFunc),  AdprofStartedFunctionPointer(AdprofStartedFunc) {}

    int Report(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk) {
        if (ReportFunctionPointer == nullptr) {
            return PROFILING_FAILED;
        } 
        return ReportFunctionPointer(fileChunk);
    }

    bool AdprofStarted() {
        if (AdprofStartedFunctionPointer == nullptr) {
            return false;
        }
        return AdprofStartedFunctionPointer();
    }

private:
    std::function<int(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk>)> ReportFunctionPointer;
    std::function<bool()> AdprofStartedFunctionPointer;
};

TEST_F(ADPROF_UTEST, FuncBind)
{
    analysis::dvvp::ProfileFileChunk dataChunk1;
    dataChunk1.isLastChunk = false;
    dataChunk1.chunkModule = 0;
    dataChunk1.chunk = "22222222222222222222";
    dataChunk1.offset = -1;
    dataChunk1.chunkSize = 20;
    dataChunk1.fileName = "";
    dataChunk1.extraInfo = "";
    dataChunk1.id = "";
    auto dataChunkPtr1 = std::make_shared<analysis::dvvp::ProfileFileChunk>(dataChunk1);
 
    AnotherClass aclass(
        std::bind(&AdprofCollector::Report, AdprofCollector::instance(), std::placeholders::_1),
        std::bind(&AdprofCollector::AdprofStarted, AdprofCollector::instance())
    );
    aclass.Report(dataChunkPtr1);
    AdprofCollector::instance()->UnInit();
    auto ret = aclass.AdprofStarted();
    EXPECT_EQ(false, ret);
}
