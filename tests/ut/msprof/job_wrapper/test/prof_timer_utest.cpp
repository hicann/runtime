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
#include <mutex>
#include "thread/thread.h"
#include "prof_timer.h"
#include "transport/transport.h"
#include "transport/hdc/hdc_transport.h"
#include "utils/utils.h"


using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::JobWrapper;
using namespace Analysis::Dvvp::MsprofErrMgr;

class PROF_STAT_FILE_HANDLER_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        param = std::make_shared<analysis::dvvp::message::ProfileParams>();
        jobCtx = std::make_shared<analysis::dvvp::message::JobContext>();

        auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
                new analysis::dvvp::transport::HDCTransport(session));
        upLoader = std::make_shared<analysis::dvvp::transport::Uploader>(transport);
    }
    virtual void TearDown() {
    }
public:
    unsigned int devId = 0;
    unsigned int bufSize = 10;
    unsigned int sampleIntervalMs = 100;
    std::string srcFileName = "srcFileName";
    std::string retFileName = "retFileName";
    std::shared_ptr<analysis::dvvp::message::ProfileParams> param;
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx;

    HDC_SESSION session = (HDC_SESSION)0x12345678;
    std::shared_ptr<analysis::dvvp::transport::Uploader> upLoader;
};

/////////////////////////////////////////////////////////////
TEST_F(PROF_STAT_FILE_HANDLER_TEST, Init) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::common::memory::Chunk::Init)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_SYS_STAT, devId, bufSize,
        sampleIntervalMs});
    attr->srcFileName = srcFileName;
    attr->retFileName = retFileName;
    ProcStatFileHandler statHandler(attr, param, jobCtx, upLoader);
    //Inited
    statHandler.isInited_ = true;
    EXPECT_EQ(PROFILING_FAILED, statHandler.Init());
    //buf init failed
    statHandler.isInited_ = false;
    EXPECT_EQ(PROFILING_FAILED, statHandler.Init());
    //succ
    EXPECT_EQ(PROFILING_SUCCESS, statHandler.Init());
}

TEST_F(PROF_STAT_FILE_HANDLER_TEST, UInit) {
    GlobalMockObject::verify();

    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_SYS_STAT, devId, bufSize,
        sampleIntervalMs});
    attr->srcFileName = srcFileName;
    attr->retFileName = retFileName;
    ProcStatFileHandler statHandler(attr, param, jobCtx, upLoader);
    statHandler.isInited_ = false;
    //UInited
    EXPECT_EQ(PROFILING_SUCCESS, statHandler.Uinit());
    //succ
    statHandler.isInited_ = true;
    EXPECT_EQ(PROFILING_SUCCESS, statHandler.Uinit());
}

TEST_F(PROF_STAT_FILE_HANDLER_TEST, Execute) {
    GlobalMockObject::verify();

    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_SYS_STAT, devId, bufSize,
        sampleIntervalMs});
    attr->srcFileName = srcFileName;
    attr->retFileName = retFileName;
    ProcStatFileHandler statHandler(attr, param, jobCtx, upLoader);

    //Not Inited
    EXPECT_EQ(PROFILING_SUCCESS, statHandler.Execute());
    //prevTimeStamp_ break;
    MOCKER(analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw)
        .stubs()
        .will(returnValue((unsigned long long)1));
    EXPECT_EQ(PROFILING_SUCCESS, statHandler.Init());
    statHandler.prevTimeStamp_ = 1;
    statHandler.sampleIntervalNs_= 1;
    EXPECT_EQ(PROFILING_SUCCESS, statHandler.Execute());
    //open file failed
    statHandler.prevTimeStamp_ = 0;
    statHandler.srcFileName_ = "./test/test";
    EXPECT_EQ(PROFILING_SUCCESS, statHandler.Execute());
    //srcFileName is empty
    statHandler.srcFileName_ = "";
    MOCKER_CPP_VIRTUAL(&statHandler, &Analysis::Dvvp::JobWrapper::ProcStatFileHandler::ParseProcFile)
        .stubs();
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProcTimerHandler::StoreData)
        .stubs();
    EXPECT_EQ(PROFILING_SUCCESS, statHandler.Execute());
    //succ
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProcTimerHandler::PacketData)
        .stubs();
    statHandler.srcFileName_ = "./test";
    EXPECT_EQ(PROFILING_SUCCESS, statHandler.Execute());
}

TEST_F(PROF_STAT_FILE_HANDLER_TEST, PacketData) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::common::memory::Chunk::Init)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_SYS_STAT, devId, bufSize,
        sampleIntervalMs});
    attr->srcFileName = srcFileName;
    attr->retFileName = retFileName;
    ProcStatFileHandler statHandler(attr, param, jobCtx, upLoader);
    EXPECT_EQ(PROFILING_FAILED, statHandler.Init());
    EXPECT_EQ(PROFILING_SUCCESS, statHandler.Init());

    std::string dest;
    std::string data;
    unsigned int headSize = 1;
    //data null
    statHandler.PacketData(dest, data, headSize);
    //succ
    data = "test";
    statHandler.PacketData(dest, data, headSize);
}

TEST_F(PROF_STAT_FILE_HANDLER_TEST, SendData) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::common::memory::Chunk::Init)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_SYS_STAT, devId, bufSize,
        sampleIntervalMs});
    attr->srcFileName = srcFileName;
    attr->retFileName = retFileName;
    ProcStatFileHandler statHandler(attr, param, jobCtx, upLoader);
    EXPECT_EQ(PROFILING_FAILED, statHandler.Init());
    EXPECT_EQ(PROFILING_SUCCESS, statHandler.Init());

    MOCKER_CPP(&analysis::dvvp::transport::Uploader::UploadData,
        int(analysis::dvvp::transport::Uploader::*)(const void *, int))
        .stubs()
        .will(returnValue(0));

    std::string buf("test");

    statHandler.SendData(nullptr, 0);
    statHandler.SendData((const unsigned char*)buf.c_str(), buf.size());
}

TEST_F(PROF_STAT_FILE_HANDLER_TEST, FlushBuf) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::common::memory::Chunk::Init)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_SYS_STAT, devId, bufSize,
        sampleIntervalMs});
    attr->srcFileName = srcFileName;
    attr->retFileName = retFileName;
    ProcStatFileHandler statHandler(attr, param, jobCtx, upLoader);
    EXPECT_EQ(PROFILING_FAILED, statHandler.Init());
    EXPECT_EQ(PROFILING_SUCCESS, statHandler.Init());

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProcTimerHandler::SendData)
        .stubs();
    statHandler.buf_.usedSize_ = 1;
    statHandler.isInited_ = true;

    statHandler.FlushBuf();
    statHandler.isInited_ = false;
}

TEST_F(PROF_STAT_FILE_HANDLER_TEST, StoreData) {
    GlobalMockObject::verify();
    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_SYS_STAT, devId, bufSize,
        sampleIntervalMs});
    attr->srcFileName = srcFileName;
    attr->retFileName = retFileName;
    ProcStatFileHandler statHandler(attr, param, jobCtx, upLoader);

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProcTimerHandler::SendData)
        .stubs();
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProcTimerHandler::FlushBuf)
        .stubs();
    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(EOF))
        .then(returnValue(EOK));

    EXPECT_EQ(PROFILING_SUCCESS, statHandler.Init());
    //size = 0
    std::string data;
    statHandler.StoreData(data);
    //memcpy failed
    data = "123";
    statHandler.StoreData(data);
    //free > size; bufSize = 10
    data = "123";
    statHandler.StoreData(data);
    statHandler.StoreData(data);
    //free < size
    data = "1234567890a";
    statHandler.StoreData(data);

    data = "123356789";
    statHandler.StoreData(data);
    EXPECT_EQ(PROFILING_SUCCESS, statHandler.Uinit());
}

TEST_F(PROF_STAT_FILE_HANDLER_TEST, ParseProcFile) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::common::memory::Chunk::Init)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_SYS_STAT, devId, bufSize,
        sampleIntervalMs});
    attr->srcFileName = srcFileName;
    attr->retFileName = retFileName;
    ProcStatFileHandler statHandler(attr, param, jobCtx, upLoader);
    EXPECT_EQ(PROFILING_FAILED, statHandler.Init());
    EXPECT_EQ(PROFILING_SUCCESS, statHandler.Init());

    std::ofstream ofs("./test");
    ofs << "cpu" << std::endl;
    ofs << "cpu" << std::endl;
    ofs << "test" << std::endl;
    ofs.close();

    std::string data;
    std::ifstream ifs("./test");
    statHandler.ParseProcFile(ifs, data);
    ifs.close();

    remove("./test");
}
///////////////////////////////////////////////////////////////////////////////////
class PROF_PID_STAT_FILE_HANDLER_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        param = std::make_shared<analysis::dvvp::message::ProfileParams>();
        jobCtx = std::make_shared<analysis::dvvp::message::JobContext>();

        auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
                new analysis::dvvp::transport::HDCTransport(session));
        upLoader = std::make_shared<analysis::dvvp::transport::Uploader>(transport);
    }
    virtual void TearDown() {
    }
public:
    unsigned int devId = 0;
    unsigned int bufSize = 10;
    unsigned int sampleIntervalMs = 100;
    std::string srcFileName = "srcFileName";
    std::string retFileName = "retFileName";
    std::shared_ptr<analysis::dvvp::message::ProfileParams> param;
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx;

    HDC_SESSION session = (HDC_SESSION)0x12345678;
    std::shared_ptr<analysis::dvvp::transport::Uploader> upLoader;
    unsigned int pid = 1;
};

TEST_F(PROF_PID_STAT_FILE_HANDLER_TEST, ParseProcFile) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::common::memory::Chunk::Init)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_SYS_STAT, devId, bufSize,
        sampleIntervalMs});
    attr->srcFileName = srcFileName;
    attr->retFileName = retFileName;
    attr->pid = pid;
    ProcPidStatFileHandler pidStatHandler(attr, param, jobCtx, upLoader);
    EXPECT_EQ(PROFILING_FAILED, pidStatHandler.Init());
    EXPECT_EQ(PROFILING_SUCCESS, pidStatHandler.Init());

    std::ofstream ofs("./test");
    ofs << "cpu" << std::endl;
    ofs << "cpu" << std::endl;
    ofs << "test" << std::endl;
    ofs.close();

    std::string data;
    std::ifstream ifs("./test");
    pidStatHandler.ParseProcFile(ifs, data);
    ifs.close();

    remove("./test");
}

///////////////////////////////////////////////////////////////////////////////////
class PROF_HOST_CPU_HANDLER_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        param = std::make_shared<analysis::dvvp::message::ProfileParams>();
        jobCtx = std::make_shared<analysis::dvvp::message::JobContext>();

        auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
                new analysis::dvvp::transport::HDCTransport(session));
        upLoader = std::make_shared<analysis::dvvp::transport::Uploader>(transport);
    }
    virtual void TearDown() {
    }
public:
    unsigned int devId = 0;
    unsigned int bufSize = 10;
    unsigned int sampleIntervalMs = 20;
    std::string srcFileName = "";
    std::string retFileName = "retFileName";
    std::shared_ptr<analysis::dvvp::message::ProfileParams> param;
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx;

    HDC_SESSION session = (HDC_SESSION)0x12345678;
    std::shared_ptr<analysis::dvvp::transport::Uploader> upLoader;
};

TEST_F(PROF_HOST_CPU_HANDLER_TEST, ParseProcFile) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::common::memory::Chunk::Init)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_HOST_PROC_CPU, 0, bufSize,
        sampleIntervalMs});
    attr->retFileName = retFileName;
    ProcHostCpuHandler hostCpuHandler(attr, param, jobCtx, upLoader);
    EXPECT_EQ(PROFILING_FAILED, hostCpuHandler.Init());
    EXPECT_EQ(PROFILING_SUCCESS, hostCpuHandler.Init());

    std::string data;
    std::ifstream ifs;
    hostCpuHandler.ParseProcFile(ifs, data);
    hostCpuHandler.ParseProcFile(ifs, data);
}

TEST_F(PROF_HOST_CPU_HANDLER_TEST, ParseSysTime) {
    GlobalMockObject::verify();

    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_HOST_PROC_CPU, 0, bufSize,
        sampleIntervalMs});
    attr->retFileName = retFileName;
    ProcHostCpuHandler hostCpuHandler(attr, param, jobCtx, upLoader);
    std::string data = "PROF_HOST_CPU_HANDLER_TEST/ParseSysTime";
    hostCpuHandler.ParseSysTime(data);
    bool check = false;
    char lastChar = data.back();
    if (data.length() > 0 && lastChar == '\n') {
        check = true;
    }
    EXPECT_TRUE(check);
}

TEST_F(PROF_HOST_CPU_HANDLER_TEST, ParseProcTidStat) {
    GlobalMockObject::verify();

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProcTimerHandler::CheckFileSize)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_HOST_PROC_CPU, 0, bufSize,
        sampleIntervalMs});
    attr->retFileName = retFileName;
    ProcHostCpuHandler hostCpuHandler(attr, param, jobCtx, upLoader);

    analysis::dvvp::common::utils::Utils::CreateDir("/tmp/PROF_HOST_CPU_HANDLER_TEST/ParseSysTime");
    hostCpuHandler.taskSrc_ = "/tmp/PROF_HOST_CPU_HANDLER_TEST";
    std::string data = "PROF_HOST_CPU_HANDLER_TEST.ParseSysTime";
    hostCpuHandler.ParseProcTidStat(data);
    hostCpuHandler.ParseProcTidStat(data);
    EXPECT_EQ(data, "PROF_HOST_CPU_HANDLER_TEST.ParseSysTime");
    analysis::dvvp::common::utils::Utils::RemoveDir("/tmp/PROF_HOST_CPU_HANDLER_TEST/");
}
///////////////////////////////////////////////////////////////////////////////////
class PROF_HOST_MEM_HANDLER_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        param = std::make_shared<analysis::dvvp::message::ProfileParams>();
        jobCtx = std::make_shared<analysis::dvvp::message::JobContext>();

        auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
                new analysis::dvvp::transport::HDCTransport(session));
        upLoader = std::make_shared<analysis::dvvp::transport::Uploader>(transport);
    }
    virtual void TearDown() {
    }
public:
    unsigned int devId = 0;
    unsigned int bufSize = 10;
    unsigned int sampleIntervalMs = 20;
    std::string srcFileName = "";
    std::string retFileName = "retFileName";
    std::shared_ptr<analysis::dvvp::message::ProfileParams> param;
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx;

    HDC_SESSION session = (HDC_SESSION)0x12345678;
    std::shared_ptr<analysis::dvvp::transport::Uploader> upLoader;
};

TEST_F(PROF_HOST_MEM_HANDLER_TEST, ParseProcFile) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::common::memory::Chunk::Init)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_HOST_PROC_MEM, 0, bufSize,
        sampleIntervalMs});
    attr->retFileName = retFileName;
    ProcHostMemHandler hostMemHandler(attr, param, jobCtx, upLoader);
    EXPECT_EQ(PROFILING_FAILED, hostMemHandler.Init());
    EXPECT_EQ(PROFILING_SUCCESS, hostMemHandler.Init());

    std::string data;
    std::ifstream ifs;
    hostMemHandler.ParseProcFile(ifs, data);
    hostMemHandler.ParseProcFile(ifs, data);
}

///////////////////////////////////////////////////////////////////////////////////
class PROF_HOST_NETWORK_HANDLER_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        param = std::make_shared<analysis::dvvp::message::ProfileParams>();
        jobCtx = std::make_shared<analysis::dvvp::message::JobContext>();

        auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
                new analysis::dvvp::transport::HDCTransport(session));
        upLoader = std::make_shared<analysis::dvvp::transport::Uploader>(transport);
    }
    virtual void TearDown() {
    }
public:
    unsigned int devId = 0;
    unsigned int bufSize = 10;
    unsigned int sampleIntervalMs = 20;
    std::string srcFileName = "";
    std::string retFileName = "retFileName";
    std::shared_ptr<analysis::dvvp::message::ProfileParams> param;
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx;

    HDC_SESSION session = (HDC_SESSION)0x12345678;
    std::shared_ptr<analysis::dvvp::transport::Uploader> upLoader;
};

TEST_F(PROF_HOST_NETWORK_HANDLER_TEST, ParseProcFile) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::common::memory::Chunk::Init)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_HOST_SYS_NETWORK, 0, bufSize,
        sampleIntervalMs});
    attr->retFileName = retFileName;
    ProcHostNetworkHandler hostNetworkHandler(attr, param, jobCtx, upLoader);
    EXPECT_EQ(PROFILING_FAILED, hostNetworkHandler.Init());
    EXPECT_EQ(PROFILING_SUCCESS, hostNetworkHandler.Init());

    std::string data;
    std::ifstream ifs;
    hostNetworkHandler.ParseProcFile(ifs, data);
    hostNetworkHandler.ParseProcFile(ifs, data);
}

///////////////////////////////////////////////////////////////////////////////////
class PROF_MEM_FILE_HANDLER_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        param = std::make_shared<analysis::dvvp::message::ProfileParams>();
        jobCtx = std::make_shared<analysis::dvvp::message::JobContext>();

        auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
                new analysis::dvvp::transport::HDCTransport(session));
        upLoader = std::make_shared<analysis::dvvp::transport::Uploader>(transport);
    }
    virtual void TearDown() {
    }
public:
    unsigned int devId = 0;
    unsigned int bufSize = 10;
    unsigned int sampleIntervalMs = 100;
    std::string srcFileName = "srcFileName";
    std::string retFileName = "retFileName";
    std::shared_ptr<analysis::dvvp::message::ProfileParams> param;
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx;

    HDC_SESSION session = (HDC_SESSION)0x12345678;
    std::shared_ptr<analysis::dvvp::transport::Uploader> upLoader;
};

TEST_F(PROF_MEM_FILE_HANDLER_TEST, ParseProcFile) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::common::memory::Chunk::Init)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_SYS_MEM, devId, bufSize,
        sampleIntervalMs});
    attr->srcFileName = srcFileName;
    attr->retFileName = retFileName;
    ProcMemFileHandler memHandler(attr, param, jobCtx, upLoader);
    EXPECT_EQ(PROFILING_FAILED, memHandler.Init());
    EXPECT_EQ(PROFILING_SUCCESS, memHandler.Init());

    std::ofstream ofs("./test");
    ofs << "cpu" << std::endl;
    ofs << "cpu" << std::endl;
    ofs << "test" << std::endl;
    ofs.close();

    std::string data;
    std::ifstream ifs("./test");
    memHandler.ParseProcFile(ifs, data);
    ifs.close();

    remove("./test");
}

///////////////////////////////////////////////////////////////////////////////////
class PROF_PID_MEM_FILE_HANDLER_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        param = std::make_shared<analysis::dvvp::message::ProfileParams>();
        jobCtx = std::make_shared<analysis::dvvp::message::JobContext>();

        auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
                new analysis::dvvp::transport::HDCTransport(session));
        upLoader = std::make_shared<analysis::dvvp::transport::Uploader>(transport);
    }
    virtual void TearDown() {
    }
public:
    unsigned int devId = 0;
    unsigned int bufSize = 10;
    unsigned int sampleIntervalMs = 100;
    std::string srcFileName = "srcFileName";
    std::string retFileName = "retFileName";
    std::shared_ptr<analysis::dvvp::message::ProfileParams> param;
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx;

    HDC_SESSION session = (HDC_SESSION)0x12345678;
    std::shared_ptr<analysis::dvvp::transport::Uploader> upLoader;
    unsigned int pid = 1;
};

TEST_F(PROF_PID_MEM_FILE_HANDLER_TEST, ParseProcFile) {
    GlobalMockObject::verify();

    MOCKER_CPP(&analysis::dvvp::common::memory::Chunk::Init)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));
    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_SYS_MEM, devId, bufSize,
        sampleIntervalMs});
    attr->srcFileName = srcFileName;
    attr->retFileName = retFileName;
    attr->pid = pid;
    ProcPidMemFileHandler pidMemHandler(attr, param, jobCtx, upLoader);
    EXPECT_EQ(PROFILING_FAILED, pidMemHandler.Init());
    EXPECT_EQ(PROFILING_SUCCESS, pidMemHandler.Init());

    std::ofstream ofs("./test");
    ofs << "cpu" << std::endl;
    ofs << "cpu" << std::endl;
    ofs << "test" << std::endl;
    ofs.close();

    std::string data;
    std::ifstream ifs("./test");
    pidMemHandler.ParseProcFile(ifs, data);
    ifs.close();

    remove("./test");
}

///////////////////////////////////////////////////////////////////////////////////
class PROF_ALL_PID_FILE_HANDLER_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        param = std::make_shared<analysis::dvvp::message::ProfileParams>();
        jobCtx = std::make_shared<analysis::dvvp::message::JobContext>();

        auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
                new analysis::dvvp::transport::HDCTransport(session));
        upLoader = std::make_shared<analysis::dvvp::transport::Uploader>(transport);
    }
    virtual void TearDown() {
    }
public:
    unsigned int devId = 0;
    unsigned int sampleIntervalMs = 100;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> param;
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx;

    HDC_SESSION session = (HDC_SESSION)0x12345678;
    std::shared_ptr<analysis::dvvp::transport::Uploader> upLoader;
};

void fake_get_child_dirs(const std::string &dir, bool is_recur, std::vector<std::string>& pidDirs)
{
    pidDirs.push_back("/proc/1");
    pidDirs.push_back("/proc/2");
    pidDirs.push_back("/proc/test");
}

TEST_F(PROF_ALL_PID_FILE_HANDLER_TEST, Init) {
    GlobalMockObject::verify();

    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_ALL_PID, devId, 0,
        sampleIntervalMs});
    ProcAllPidsFileHandler allPidsHandler(attr, param, jobCtx, upLoader);

    MOCKER(analysis::dvvp::common::utils::Utils::GetChildDirs)
        .stubs()
        .will(invoke(fake_get_child_dirs));
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProcAllPidsFileHandler::GetNewExitPids)
        .stubs();
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProcAllPidsFileHandler::HandleExitPids)
        .stubs();
    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::ProcAllPidsFileHandler::HandleNewPids)
        .stubs();
    //Init
    EXPECT_EQ(PROFILING_SUCCESS, allPidsHandler.Init());
    //Execute
    EXPECT_EQ(PROFILING_SUCCESS, allPidsHandler.Execute());
    //ParseProcFile
    std::ifstream ifs;
    std::string data;
    allPidsHandler.ParseProcFile(ifs, data);
    //GetProcessname
    allPidsHandler.GetProcessName(0, data);
}

TEST_F(PROF_ALL_PID_FILE_HANDLER_TEST, GetNewExitPids) {
    GlobalMockObject::verify();

    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_ALL_PID, devId, 0,
        sampleIntervalMs});
    ProcAllPidsFileHandler allPidsHandler(attr, param, jobCtx, upLoader);

    //GetNewExitPids
    std::vector<unsigned int> newPids;
    std::vector<unsigned int> exitPids;

    std::vector<unsigned int> curPids;
    curPids.push_back(1);
    curPids.push_back(2);
    curPids.push_back(5);
    std::vector<unsigned int> prevPids;
    prevPids.push_back(1);
    prevPids.push_back(4);

    allPidsHandler.GetNewExitPids(curPids, prevPids, newPids, exitPids);

    //prevPidsSize > curPidsSize
    prevPids.push_back(6);
    allPidsHandler.GetNewExitPids(curPids, prevPids, newPids, exitPids);

    EXPECT_EQ(curPids[1], newPids[0]);
    EXPECT_EQ(prevPids[1], exitPids[0]);

    //HandleNewPids
    allPidsHandler.HandleNewPids(prevPids);
    allPidsHandler.HandleNewPids(newPids);
    //HandleExitPids
    allPidsHandler.HandleExitPids(exitPids);
    //Execute
    allPidsHandler.Execute();
}

///////////////////////////////////////////////////////////////////////////////////
class PROF_TIMER_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        param = std::make_shared<analysis::dvvp::message::ProfileParams>();
        jobCtx = std::make_shared<analysis::dvvp::message::JobContext>();

        auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
                new analysis::dvvp::transport::HDCTransport(session));
        upLoader = std::make_shared<analysis::dvvp::transport::Uploader>(transport);
    }
    virtual void TearDown() {
    }
public:
    unsigned int devId = 0;
    unsigned int sampleIntervalMs = 100;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> param;
    std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx;

    HDC_SESSION session = (HDC_SESSION)0x12345678;
    std::shared_ptr<analysis::dvvp::transport::Uploader> upLoader;
};

TEST_F(PROF_TIMER_TEST, Handler) {
    GlobalMockObject::verify();

    std::shared_ptr<TimerParam> timerParam(
            new TimerParam(1000));
    ProfTimer timerHandler(timerParam);
    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_ALL_PID, devId, 0,
        sampleIntervalMs});
    std::shared_ptr<ProcAllPidsFileHandler> allPidsHandler(
            new ProcAllPidsFileHandler(attr, param, jobCtx, upLoader));

    EXPECT_EQ(PROFILING_SUCCESS, timerHandler.RegisterTimerHandler(PROF_ALL_PID, allPidsHandler));
    EXPECT_EQ(1, timerHandler.Handler());
    EXPECT_EQ(PROFILING_SUCCESS, timerHandler.RemoveTimerHandler(PROF_ALL_PID));
}

TEST_F(PROF_TIMER_TEST, Start) {
    GlobalMockObject::verify();

    //MOCKER_CPP(&analysis::dvvp::common::thread::Thread::Start)
    //    .stubs()
    //    .will(returnValue(PROFILING_SUCCESS));
    MOCKER(mmCreateTaskWithThreadAttr)
        .stubs()
        .will(returnValue(EN_OK));
    //MOCKER_CPP(&analysis::dvvp::common::thread::Thread::Stop)
    //    .stubs()
    //    .will(returnValue(PROFILING_SUCCESS));
    MOCKER(mmJoinTask)
        .stubs()
        .will(returnValue(EN_OK));

    MOCKER(setitimer)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0))
        .then(returnValue(-1))
        .then(returnValue(0));

    std::shared_ptr<TimerParam> timerParam(
            new TimerParam(1000));
    ProfTimer timerHandler(timerParam);
    //start failed
    timerHandler.isStarted_ = true;
    EXPECT_EQ(PROFILING_FAILED, timerHandler.Start());
    //setitimer failed
    timerHandler.isStarted_ = false;
    EXPECT_EQ(PROFILING_SUCCESS, timerHandler.Start());
    //start succ
    EXPECT_EQ(PROFILING_FAILED, timerHandler.Start());
    //stop faile setitimer failed
    EXPECT_EQ(PROFILING_SUCCESS, timerHandler.Stop());
    //stop succ
    std::shared_ptr<TimerAttr> attr(new TimerAttr{PROF_ALL_PID, devId, 0,
        sampleIntervalMs});
    std::shared_ptr<ProcAllPidsFileHandler> allPidsHandler(
            new ProcAllPidsFileHandler(attr, param, jobCtx, upLoader));

    EXPECT_EQ(PROFILING_SUCCESS, timerHandler.RegisterTimerHandler(PROF_ALL_PID, allPidsHandler));
    timerHandler.isStarted_ = true;
    EXPECT_EQ(PROFILING_SUCCESS, timerHandler.Stop());
}

TEST_F(PROF_TIMER_TEST, run) {
    GlobalMockObject::verify();

    std::shared_ptr<TimerParam> timerParam(
            new TimerParam(1000));
    EXPECT_NE(nullptr, timerParam);
    ProfTimer timerHandler(timerParam);
    auto errorContext = MsprofErrorManager::instance()->GetErrorManagerContext();
    timerHandler.Run(errorContext);
}