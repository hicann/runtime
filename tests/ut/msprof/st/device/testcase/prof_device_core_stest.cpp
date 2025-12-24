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
#include <map>
#include <iostream>
#include "securec.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "proto/profiler.pb.h"
#include "errno/error_code.h"
#include "message/codec.h"
#include "collection_entry.h"
#include "prof_device_core.h"
#include "devdrv_runtime_api_stub.h"
#include "profile_drv_user_stub.h"
#include "hdc-api-stub.h"
#include "utils/utils.h"
#include "mmpa_stub.h"
#include "uploader_mgr.h"
#include "config/config_manager.h"
#include "adx_prof_api.h"

#define SET_PROTOMSG_JOBCTX(msg, devId, jobId) do {                               \
    analysis::dvvp::message::JobContext __jobCtx;                   \
    __jobCtx.dev_id = devId;                                       \
    __jobCtx.job_id = jobId;                              \
    msg->mutable_hdr()->set_job_ctx(__jobCtx.ToString());          \
} while(0)
#define MAX_BUFFER_SIZE (1024 * 1024 * 2)
#define MAX_THRESHOLD_SIZE (MAX_BUFFER_SIZE * 0.8)
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;
using namespace analysis::dvvp::host;
using namespace Analysis::Dvvp::Adx;
using namespace analysis::dvvp::transport;
class DEVICE_PROF_DEVICE_CORE_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        GlobalMockObject::verify();
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
public:
    HDC_CLIENT client = (HDC_CLIENT)0x12345678;
    std::string dev_id = "0";
};

static void * fake_dlsym(void *handle, const char *symbol) {
    std::string symbol_str = symbol;

    if (symbol_str == "prof_drv_start") {
        return (void *)prof_drv_start;
    }

    if (symbol_str == "prof_stop") {
        return (void *)prof_stop;
    }

    if (symbol_str == "prof_channel_read") {
        return (void *)prof_channel_read;
    }

    if (symbol_str == "prof_channel_poll") {
        return (void *)prof_channel_poll;
    }

    if (symbol_str == "drvGetPlatformInfo") {
        return (void *)drvGetPlatformInfo;
    }

    if (symbol_str == "drvGetDevNum") {
        return (void *)drvGetDevNum;
    }

    if (symbol_str == "drvGetDevIDs") {
        return (void *)drvGetDevIDs;
    }

    if (symbol_str == "halGetDeviceInfo") {
        return (void *)halGetDeviceInfo;
    }

    return (void *)0x87654321;
}

void fake_get_child_dirs(const std::string &dir, bool is_recur, std::vector<std::string>& app_dirs)
{
    app_dirs.push_back("/sys/firmware/devicetree/base/soc/ddrc1");
    app_dirs.push_back("/sys/firmware/devicetree/base/soc/ddrc2");
    app_dirs.push_back("/sys/firmware/devicetree/base/soc/test");
    app_dirs.push_back("/proc/1");
    app_dirs.push_back("/proc/2");
    app_dirs.push_back("/proc/999");
    app_dirs.push_back("/proc/10");
    app_dirs.push_back("/proc/10000");
}

static void device_mocker_common() {
    MOCKER(dlopen)
        .stubs()
        .will(returnValue((void *)0x12345678));

    MOCKER(dlclose)
        .stubs()
        .will(returnValue(0));

    MOCKER(dlsym)
        .stubs()
        .will(invoke(fake_dlsym));

    static pid_t pid = 1234;
    MOCKER(fork)
        .stubs()
        .will(returnValue(pid++));

    MOCKER(dup2)
        .stubs()
        .will(returnValue(0));

    MOCKER(execvpe)
        .stubs()
        .will(returnValue(0));

    MOCKER(perror)
        .stubs();

    MOCKER(_exit)
        .stubs();

    int wait_status = 0;
    MOCKER(waitpid)
        .stubs()
        .with(any(), outBoundP(&wait_status), any())
        .will(returnValue(0));
    MOCKER(analysis::dvvp::common::utils::Utils::GetChildDirs)
        .stubs()
        .will(invoke(fake_get_child_dirs));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
}

TEST_F(DEVICE_PROF_DEVICE_CORE_TEST, IdeDeviceProfileInit) {
    GlobalMockObject::verify();

    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileInit());
}

TEST_F(DEVICE_PROF_DEVICE_CORE_TEST, IdeDeviceProfileCleanup) {
    GlobalMockObject::verify();

    device_mocker_common();

    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileInit());
    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileCleanup());
}

TEST_F(DEVICE_PROF_DEVICE_CORE_TEST, IdeDeviceProfileProcess_invalid_params) {
    GlobalMockObject::verify();

    //invalid message
    std::string buffer_invalid("12345566");
    struct tlv_req * req_invalid = (struct tlv_req *)new char[sizeof(struct tlv_req) + buffer_invalid.size()];
    req_invalid->len = (int)buffer_invalid.size();
    memcpy_s(req_invalid->value, req_invalid->len, buffer_invalid.c_str(), buffer_invalid.size());
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    //null params
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(NULL, req_invalid));

    //null req
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, NULL));

    //handle req
    device_mocker_common();

    //uinit
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, req_invalid));

    //init
    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileInit());

    //invalid message
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, req_invalid));

    delete [] ((char*)req_invalid);
}

TEST_F(DEVICE_PROF_DEVICE_CORE_TEST, IdeDeviceProfileProcess_data) {
    GlobalMockObject::verify();

    device_mocker_common();

    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileInit());

    //data message
    std::shared_ptr<analysis::dvvp::proto::DataChannelHandshake> data(
        new analysis::dvvp::proto::DataChannelHandshake);
    data->set_jobid("jobid");
    data->set_devid(0);
    data->set_mode("def_mode");
    std::string buffer_data = analysis::dvvp::message::EncodeMessage(data);
    struct tlv_req * req_data = (struct tlv_req *)new char[sizeof(struct tlv_req) + buffer_data.size()];
    req_data->len = (int)buffer_data.size();
    memcpy_s(req_data->value, req_data->len, buffer_data.c_str(), buffer_data.size());

    //data channel
    HDC_SESSION data_session = (HDC_SESSION)0x12345687;
    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileProcess(data_session, req_data));

    delete [] ((char*)req_data);
}

static int fake_ctrl_HdcRead_not_started(HDC_SESSION session, void **buf, int *recv_len) {
    static int state = 0;
    std::string devId = "0";
    std::string jobId = "0x123456780";
    int phase = state++ % 10;
    switch (phase) {
    case 0: {
        std::shared_ptr<analysis::dvvp::proto::JobStartReq> start(
            new analysis::dvvp::proto::JobStartReq);
        SET_PROTOMSG_JOBCTX(start, devId, jobId);
        std::string buffer_start = analysis::dvvp::message::EncodeMessage(start);
        int start_len = sizeof(struct tlv_req) + buffer_start.size();
        struct tlv_req * req_start = (struct tlv_req *)malloc(start_len);
        req_start->len = (int)buffer_start.size();
        memcpy_s(req_start->value, req_start->len, buffer_start.c_str(), buffer_start.size());
        *buf = (void *)req_start;
        *recv_len = start_len;
    }
        break;
    case 1: {
        std::shared_ptr<analysis::dvvp::proto::ReplayStartReq> start_replay(
            new analysis::dvvp::proto::ReplayStartReq);
        SET_PROTOMSG_JOBCTX(start_replay, devId, jobId);
        std::string buffer_start_replay = analysis::dvvp::message::EncodeMessage(start_replay);
        int start_replay_len = sizeof(struct tlv_req) + buffer_start_replay.size();
        struct tlv_req * req_start_replay = (struct tlv_req *)malloc(start_replay_len);
        req_start_replay->len = (int)buffer_start_replay.size();
        memcpy_s(req_start_replay->value, req_start_replay->len, buffer_start_replay.c_str(), buffer_start_replay.size());
        *buf = (void *)req_start_replay;
        *recv_len = start_replay_len;
    }
        break;
    case 2: {
        std::shared_ptr<analysis::dvvp::proto::ReplayStopReq> stop_replay(
            new analysis::dvvp::proto::ReplayStopReq);
        SET_PROTOMSG_JOBCTX(stop_replay, devId, jobId);
        std::string buffer_stop_replay = analysis::dvvp::message::EncodeMessage(stop_replay);
        int stop_replay_len = sizeof(struct tlv_req) + buffer_stop_replay.size();
        struct tlv_req * req_stop_replay = (struct tlv_req *)malloc(stop_replay_len);
        req_stop_replay->len = (int)buffer_stop_replay.size();
        memcpy_s(req_stop_replay->value, req_stop_replay->len, buffer_stop_replay.c_str(), buffer_stop_replay.size());
        *buf = (void *)req_stop_replay;
        *recv_len = stop_replay_len;
    }
        break;
    case 3: {
        std::shared_ptr<analysis::dvvp::proto::JobStopReq> stop(
            new analysis::dvvp::proto::JobStopReq);
        SET_PROTOMSG_JOBCTX(stop, devId, jobId);
        std::string buffer_stop = analysis::dvvp::message::EncodeMessage(stop);
        int stop_len = sizeof(struct tlv_req) + buffer_stop.size();
        struct tlv_req * req_stop = (struct tlv_req *)malloc(stop_len);
        req_stop->len = (int)buffer_stop.size();
        memcpy_s(req_stop->value, req_stop->len, buffer_stop.c_str(), buffer_stop.size());
        *buf = (void *)req_stop;
        *recv_len = stop_len;
    }
        break;
    default:
        return IDE_DAEMON_ERROR;
    }

    MSPROF_LOGI("buf=%p, recv_len=%d", *buf, *recv_len);

    return IDE_DAEMON_OK;
}

static int fake_ctrl_HdcRead_started(HDC_SESSION session, void **buf, int *recv_len) {
    static int state = 0;

    static int ai_core_mode = 0;
    int phase = state++ % 5;
    MSPROF_LOGI("state=%d, phase=%d", state - 1, phase);
    std::string devId = "0";
    std::string jobId = "0x123456789";

    switch (phase) {
    case 0: {
        std::shared_ptr<analysis::dvvp::message::ProfileParams> params(
            new analysis::dvvp::message::ProfileParams);
        params->tsCpuProfiling = "on";
        params->ai_core_status = "on";
        params->ai_core_profiling = "on";
        params->cpu_sampling_interval = 10;
        params->aicore_sampling_interval = 10;
        if (ai_core_mode == 0) {
            params->ai_core_profiling_mode = PROFILING_MODE_TASK_BASED;
            ai_core_mode = 1;
        } else {
            ai_core_mode = 0;
            params->ai_core_profiling_mode = PROFILING_MODE_SAMPLE_BASED;
        }
        params->dvpp_profiling = "on";
        params->nicProfiling = "on";
        params->job_id = jobId;
        params->result_dir = "/tmp/profiler_st/1/";
        params->app_dir = "./tmp/path/to/app";
        params->app = "bin/main";
        params->app_parameters = "-n 1";
        params->hbmProfiling = "on";
        params->hbm_profiling_events = "read";
        params->pcieProfiling = "on";
        params->pcieInterval = 20;
        params->hccsProfiling = "on";
        params->hccsInterval = 20;
        params->l2CacheTaskProfiling = "on";
        params->l2CacheTaskProfilingEvents = "0x5b,0x5c";
        params->llc_profiling = "on";
        params->llc_interval = 20;
        params->ddr_profiling = "on";
        params->ddr_interval = 20;
        params->sys_profiling = "on";
        params->pid_profiling = "on";
        params->sys_sampling_interval = 20;
        params->pid_sampling_interval = 20;
        params->ts_fw_training = "on";
        params->profiling_mode = "system-wide";
        params->hwts_log = "on";
        params->hwts_log1 = "on";
        params->devices = "0";
        std::shared_ptr<analysis::dvvp::proto::JobStartReq> start(
            new analysis::dvvp::proto::JobStartReq);
        start->set_sampleconfig(params->ToString());

        SET_PROTOMSG_JOBCTX(start, devId, jobId);

        std::string buffer_start = analysis::dvvp::message::EncodeMessage(start);
        int start_len = sizeof(struct tlv_req) + buffer_start.size();
        struct tlv_req * req_start = (struct tlv_req *)malloc(start_len);
        req_start->len = (int)buffer_start.size();
        memcpy_s(req_start->value, req_start->len, buffer_start.c_str(), buffer_start.size());
        *recv_len = start_len;
        *buf = (void *)req_start;
    }
        break;
    case 1: {
        auto ctrl_cpu_event = std::make_shared<std::vector<std::string>>();
        auto ts_cpu_event = std::make_shared<std::vector<std::string>>();
        auto ai_cpu_event = std::make_shared<std::vector<std::string>>();
        auto ai_core_event = std::make_shared<std::vector<std::string>>();
        auto ai_core_event_cores = std::make_shared<std::vector<int>>();
        auto llc_event = std::make_shared<std::vector<std::string>>();
        auto ddr_event = std::make_shared<std::vector<std::string>>();

        ctrl_cpu_event->push_back("0x11");
        ts_cpu_event->push_back("0x11");
        ai_cpu_event->push_back("0x11");
        ai_core_event->push_back("0x11");
        ai_core_event_cores->push_back(1);
        llc_event->push_back("0xll");
        ddr_event->push_back("read");
        ddr_event->push_back("write");
        ddr_event->push_back("master_id");

        std::shared_ptr<analysis::dvvp::proto::ReplayStartReq> start_replay(
            new analysis::dvvp::proto::ReplayStartReq);
        SET_PROTOMSG_JOBCTX(start_replay, devId, jobId);
        for(auto iter = ctrl_cpu_event->begin(); iter != ctrl_cpu_event->end(); iter++) {
            start_replay->add_ctrl_cpu_events(iter->c_str());
        }
        for(auto iter = ts_cpu_event->begin(); iter != ts_cpu_event->end(); iter++) {
            start_replay->add_ts_cpu_events(iter->c_str());
        }
        for(auto iter = ai_cpu_event->begin(); iter != ai_cpu_event->end(); iter++) {
            start_replay->add_ai_cpu_events(iter->c_str());
        }
        for(auto iter = ai_core_event->begin(); iter != ai_core_event->end(); iter++) {
            start_replay->add_ai_core_events(iter->c_str());    
        }
        for(auto iter = ai_core_event_cores->begin(); iter != ai_core_event_cores->end(); iter++) {
            start_replay->add_ai_core_events_cores(*iter);
        }
        for(auto iter = llc_event->begin(); iter != llc_event->end(); iter++) {
            start_replay->add_llc_events(*iter);
        }
        for(auto iter = ddr_event->begin(); iter != ddr_event->end(); iter++) {
            start_replay->add_ddr_events(*iter);
        }

        std::string buffer_start_replay = analysis::dvvp::message::EncodeMessage(start_replay);
        int start_replay_len = sizeof(struct tlv_req) + buffer_start_replay.size();
        struct tlv_req * req_start_replay = (struct tlv_req *)malloc(start_replay_len);
        req_start_replay->len = (int)buffer_start_replay.size();
        memcpy_s(req_start_replay->value, req_start_replay->len, buffer_start_replay.c_str(), buffer_start_replay.size());
        *buf = (void *)req_start_replay;
        *recv_len = start_replay_len;
    }
        break;
    case 2: {
        std::shared_ptr<analysis::dvvp::proto::ReplayStopReq> stop_replay(
            new analysis::dvvp::proto::ReplayStopReq);
        SET_PROTOMSG_JOBCTX(stop_replay, devId, jobId);
        std::string buffer_stop_replay = analysis::dvvp::message::EncodeMessage(stop_replay);
        int stop_replay_len = sizeof(struct tlv_req) + buffer_stop_replay.size();
        struct tlv_req * req_stop_replay = (struct tlv_req *)malloc(stop_replay_len);
        req_stop_replay->len = (int)buffer_stop_replay.size();
        memcpy_s(req_stop_replay->value, req_stop_replay->len, buffer_stop_replay.c_str(), buffer_stop_replay.size());
        *buf = (void *)req_stop_replay;
        *recv_len = stop_replay_len;
    }
        break;
    case 3: {
        std::shared_ptr<analysis::dvvp::proto::JobStopReq> stop(
            new analysis::dvvp::proto::JobStopReq);
        SET_PROTOMSG_JOBCTX(stop, devId, jobId);
        std::string buffer_stop = analysis::dvvp::message::EncodeMessage(stop);
        int stop_len = sizeof(struct tlv_req) + buffer_stop.size();
        struct tlv_req * req_stop = (struct tlv_req *)malloc(stop_len);
        req_stop->len = (int)buffer_stop.size();
        memcpy_s(req_stop->value, req_stop->len, buffer_stop.c_str(), buffer_stop.size());
        *buf = (void *)req_stop;
        *recv_len = stop_len;
    }
        break;

    default:
        return IDE_DAEMON_ERROR;
    }

    MSPROF_LOGI("buf=%p, recv_len=%d", *buf, *recv_len);

    return IDE_DAEMON_OK;
}

static void fake_ctrl_ide_free_packet(void *buf) {
    MSPROF_LOGI("free buf=%p", buf);
    free(buf);
}

TEST_F(DEVICE_PROF_DEVICE_CORE_TEST, IdeDeviceProfileProcess_ctrl_not_started) {
    GlobalMockObject::verify();

    device_mocker_common();

    //ctrl message
    std::shared_ptr<analysis::dvvp::proto::CtrlChannelHandshake> ctrl(
        new analysis::dvvp::proto::CtrlChannelHandshake);
    ctrl->set_jobid("0x123456789");
    ctrl->set_devid(0);
    std::string buffer = analysis::dvvp::message::EncodeMessage(ctrl);
    int ctrl_len = sizeof(struct tlv_req) + buffer.size();
    struct tlv_req * req_ctrl = (struct tlv_req *)new char[ctrl_len];
    req_ctrl->len = (int)buffer.size();
    memcpy_s(req_ctrl->value, req_ctrl->len, buffer.c_str(), buffer.size());

    HDC_SESSION session = (HDC_SESSION)0x12345678;

    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileInit());

    MOCKER(IdeFreePacket)
        .stubs()
        .will(invoke(fake_ctrl_ide_free_packet));

    MOCKER(HdcRead)
        .stubs()
        .will(invoke(fake_ctrl_HdcRead_not_started));

    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileProcess(session, req_ctrl));
    auto entry = analysis::dvvp::device::CollectionEntry::instance();
    auto receiver = entry->GetReceiver("0x123456789", 0);
    if (receiver != nullptr) {
        receiver->Join();
    }
    delete [] ((char*)req_ctrl);
}

TEST_F(DEVICE_PROF_DEVICE_CORE_TEST, IdeDeviceProfileProcess_ctrl_started) {
    GlobalMockObject::verify();

    device_mocker_common();

    //ctrl message
    std::shared_ptr<analysis::dvvp::proto::CtrlChannelHandshake> ctrl(
        new analysis::dvvp::proto::CtrlChannelHandshake);
    ctrl->set_jobid("0x123456789");
    ctrl->set_devid(0);
    std::string buffer = analysis::dvvp::message::EncodeMessage(ctrl);
    int ctrl_len = sizeof(struct tlv_req) + buffer.size();
    struct tlv_req * req_ctrl = (struct tlv_req *)new char[ctrl_len];
    req_ctrl->len = (int)buffer.size();
    memcpy_s(req_ctrl->value, req_ctrl->len, buffer.c_str(), buffer.size());

    HDC_SESSION session = (HDC_SESSION)0x12345678;
    const std::string path = "/tmp/profiler_st/devicetest/";
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPerfDataDir)
        .stubs()
        .will(returnValue(path));

    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetDefaultWorkDir)
        .stubs()
        .will(returnValue(path));

    MOCKER(IdeFreePacket)
        .stubs()
        .will(invoke(fake_ctrl_ide_free_packet));

    MOCKER(IdeFreePacket)
        .stubs()
        .will(invoke(fake_ctrl_ide_free_packet));

    MOCKER(HdcRead)
        .stubs()
        .will(invoke(fake_ctrl_HdcRead_started));

    uint32_t num_dev = 2;
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&num_dev))
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    uint32_t *devices = new uint32_t[num_dev];
    devices[0] = 0;
    devices[1] = 2;

    MOCKER(drvGetDevIDs)
        .stubs()
        .with(outBoundP(devices, num_dev * sizeof(uint32_t)))
        .will(returnValue(PROFILING_SUCCESS));

    const std::string jobId("0x123456789");

    HDC_SESSION session1 = (HDC_SESSION)0x12345677;
    auto transport = std::shared_ptr<HDCTransport>(
            new HDCTransport(session1));
    auto uploader = std::make_shared<Uploader>(transport);
    uploader->Init();
    uploader->Start();
    UploaderMgr::instance()->AddUploader("0x123456789", uploader);
    MOCKER_CPP(&Uploader::UploadData, int(Uploader::*)(CONST_VOID_PTR, int))
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));;
    MOCKER_CPP(&Uploader::UploadData, int(Uploader::*)(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk>))
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileInit());

    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileProcess(session, req_ctrl));
    auto entry = analysis::dvvp::device::CollectionEntry::instance();
    auto receiver = entry->GetReceiver("0x123456789", 0);
    if (receiver != nullptr) {
        receiver->Join();
    }

    delete [] ((char*)req_ctrl);
    delete [] devices;
}

class TRANSPORT_PROF_CHANNELREADER_UTEST: public testing::Test {
protected:
    virtual void SetUp() {
        std::shared_ptr<analysis::dvvp::message::JobContext> jobCtx(
            new analysis::dvvp::message::JobContext);
        _job_ctx = jobCtx;
    }
    virtual void TearDown() {
    }
public:
    std::shared_ptr<analysis::dvvp::message::JobContext> _job_ctx;
};

TEST_F(TRANSPORT_PROF_CHANNELREADER_UTEST, Execute) {
    GlobalMockObject::verify();

    std::shared_ptr<ChannelReader> reader(
        new ChannelReader(
            0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU, "data/ts.12.0.0",
            _job_ctx));

    reader->Init();    
    MOCKER(&analysis::dvvp::driver::DrvChannelRead)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(64))
        .then(returnValue(0));


    MOCKER_CPP(&Uploader::UploadData, int(Uploader::*)(CONST_VOID_PTR, int))
        .stubs()
        .will(returnValue(PROFILING_FAILED));;
    MOCKER_CPP(&Uploader::UploadData, int(Uploader::*)(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk>))
        .stubs()
        .will(returnValue(PROFILING_FAILED));

    reader->dataSize_ = MAX_THRESHOLD_SIZE + 1;

    EXPECT_EQ(PROFILING_SUCCESS, reader->Execute());
    EXPECT_EQ(PROFILING_SUCCESS, reader->Execute());
    EXPECT_EQ(PROFILING_SUCCESS, reader->Execute());

    reader->SetChannelStopped();
    EXPECT_EQ(PROFILING_SUCCESS, reader->Execute());

    reader.reset();
}

TEST_F(TRANSPORT_PROF_CHANNELREADER_UTEST, HashId) {
    GlobalMockObject::verify();

    std::shared_ptr<ChannelReader> reader(
        new ChannelReader(
            0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU, "data/ts.12.0.0",
            _job_ctx));
    reader->Init();

    EXPECT_NE((size_t)0, reader->HashId());

    reader.reset();
}

////////////////////////////////////////////////////////////////////
TEST_F(TRANSPORT_PROF_CHANNELREADER_UTEST, SetChannelStopped) {
    GlobalMockObject::verify();

    MOCKER_CPP(&ChannelReader::UploadData)
        .stubs();

    std::shared_ptr<ChannelReader> reader(
        new ChannelReader(
            0, analysis::dvvp::driver::PROF_CHANNEL_TS_CPU, "data/ts.12.0.0",
            _job_ctx));
    EXPECT_EQ(PROFILING_SUCCESS, reader->Init());
    reader->dataSize_ = 10;
    reader->SetChannelStopped();
    reader.reset();
}

class PROF_TASK_STEST: public testing::Test {
protected:
    virtual void SetUp() {
        HDC_SESSION session = (HDC_SESSION)0x12345678;
        _transport = std::shared_ptr<HDCTransport>(
            new HDCTransport(session));
    }
    virtual void TearDown() {
        _transport.reset();
    }
public:
    std::shared_ptr<HDCTransport> _transport;
};

TEST_F(PROF_TASK_STEST, OnReplayEnd) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());

    MOCKER_CPP(&analysis::dvvp::device::CollectEngine::CollectStopReplay)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED));

    job->Init(0, "0x12345678", _transport);

    std::shared_ptr<analysis::dvvp::proto::ReplayStopReq> req(
        new analysis::dvvp::proto::ReplayStopReq);
    analysis::dvvp::message::StatusInfo status_info;

    EXPECT_EQ(PROFILING_FAILED, job->OnReplayEnd(nullptr, status_info));

    job->_is_started = false;
    EXPECT_EQ(PROFILING_FAILED, job->OnReplayEnd(req, status_info));
    EXPECT_EQ(analysis::dvvp::message::ERR, status_info.status);

    job->_is_started = true;
    EXPECT_EQ(PROFILING_FAILED, job->OnReplayEnd(req, status_info));
    EXPECT_EQ(PROFILING_FAILED, job->OnReplayEnd(req, status_info));
}

TEST_F(PROF_TASK_STEST, OnConnectionReset) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::device::ProfJobHandler> job(
        new analysis::dvvp::device::ProfJobHandler());

    MOCKER_CPP(&analysis::dvvp::device::CollectEngine::CollectStop)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    job->Init(0, "0x12345678", _transport);

    job->_is_started = true;
    EXPECT_EQ(PROFILING_FAILED, job->OnConnectionReset());
    analysis::dvvp::message::StatusInfo status_info;
    job->_is_started = false;
    job->InitEngine(status_info);
    job->_is_started = true;
    EXPECT_EQ(PROFILING_SUCCESS, job->OnConnectionReset());
}

int32_t AdxIdeGetVfIdBySessionVfidStub(HDC_SESSION session, int32_t &vfId)
{
    vfId = 32;
    return IDE_DAEMON_OK;
}

extern int32_t IdeGetVfIdBySession(HDC_SESSION session, int32_t &vfId);
TEST_F(DEVICE_PROF_DEVICE_CORE_TEST, IdeDeviceProfileProcessVfidFailed)
{
    GlobalMockObject::verify();
    std::shared_ptr<analysis::dvvp::proto::CtrlChannelHandshake> message(
        new analysis::dvvp::proto::CtrlChannelHandshake);

    std::string buffer = analysis::dvvp::message::EncodeMessage(message);
    struct tlv_req * req = (struct tlv_req *)new char[sizeof(struct tlv_req) + buffer.size()];
    req->len = (int)buffer.size();
    memcpy_s(req->value, req->len, buffer.c_str(), buffer.size());
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    MOCKER(Analysis::Dvvp::Adx::AdxIdeGetVfIdBySession)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(invoke(AdxIdeGetVfIdBySessionVfidStub));

    std::shared_ptr<AdxTransport>nullTran;
    std::shared_ptr<AdxTransport> dataTran;
    dataTran = std::make_shared<HDCTransport>(client);
    MOCKER_CPP(&HDCTransportFactory::CreateHdcTransport,
    std::shared_ptr<AdxTransport>(HDCTransportFactory::*)(HDC_SESSION session) const)
        .stubs()
        .will(returnValue(nullTran))
        .then(returnValue(dataTran));

    auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
        new HDCTransport(session));
    MOCKER_CPP_VIRTUAL(*transport.get(), &analysis::dvvp::transport::HDCTransport::SendBuffer,
        int(analysis::dvvp::transport::HDCTransport::*)(CONST_VOID_PTR, int))
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER_CPP_VIRTUAL(*transport.get(), &analysis::dvvp::transport::HDCTransport::SendBuffer,
    int(analysis::dvvp::transport::HDCTransport::*)(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk>))
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    // get vfid failed
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, req));

    // create hdc failed
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, req));

    // send buffer failes
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, req));

    // vfid != 0
    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileProcess(session, req));
    delete [] ((char*)req);
}

TEST_F(PROF_TASK_STEST, IdeDeviceProfileProcess) {
    GlobalMockObject::verify();

    std::shared_ptr<analysis::dvvp::proto::CtrlChannelHandshake> message(
        new analysis::dvvp::proto::CtrlChannelHandshake);

    std::string buffer = analysis::dvvp::message::EncodeMessage(message);
    struct tlv_req * req = (struct tlv_req *)new char[sizeof(struct tlv_req) + buffer.size()];
    req->len = (int)buffer.size();
    memcpy_s(req->value, req->len, buffer.c_str(), buffer.size());

    //null params
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(NULL, req));

    //null req
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, NULL));

    MOCKER(Analysis::Dvvp::Adx::AdxIdeGetVfIdBySession)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(analysis::dvvp::common::utils::Utils::CheckStringIsNonNegativeIntNum)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true))
        .then(returnValue(true));

    MOCKER_CPP(&analysis::dvvp::device::CollectionEntry::Handle)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    HDC_CLIENT client = (HDC_CLIENT)0x12345678;
    std::shared_ptr<AdxTransport> data_tran = std::make_shared<HDCTransport>(client);

    std::shared_ptr<AdxTransport> trans;
    trans.reset();

    MOCKER_CPP(&HDCTransportFactory::CreateHdcTransport,
        std::shared_ptr<AdxTransport>(HDCTransportFactory::*)(HDC_SESSION session) const)
        .stubs()
        .will(returnValue(trans))
        .then(returnValue(data_tran));

    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, req));
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, req));
    EXPECT_EQ(PROFILING_FAILED, IdeDeviceProfileProcess(session, req));
    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileProcess(session, req));
    EXPECT_EQ(PROFILING_SUCCESS, IdeDeviceProfileProcess(session, req));

    delete [] ((char*)req);
}