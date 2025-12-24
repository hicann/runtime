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
#include "hdc-log-stub.h"
#include "proto/profiler.pb.h"
#include "ai_drv_dev_api.h"
#include "errno/error_code.h"
#include "message/codec.h"
#include "prof_host_core.h"
#include "prof_manager.h"
#include "collect_io_server.h"
#include "securec.h"
#include "device.h"
#include "job_device_rpc.h"
#include "uploader_mgr.h"

using namespace analysis::dvvp::host;
using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::transport;
using namespace analysis::dvvp::common::error;

class HOST_PROF_DEVICE_TEST: public testing::Test {
public:
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params;
    std::shared_ptr<analysis::dvvp::message::ProfileParams> params_sample_based;
    std::string dev_id = "1";
    HDC_SESSION session = (HDC_SESSION)0x12345678;

    std::string params_str_task_based = "{\"ai_core_profiling\":\"on\",\"ai_core_profiling_events\":\"0x8,0x11\",\"aicore_sampling_interval\":1,\"ai_core_profiling_mode\":\"task-based\",\"aiCtrlCpuProfiling\":\"on\",\"ai_cpu_profiling_events\":\"0x11,0x8\",\"ai_cpu_profiling_function\":\"off\",\"analysis_type\":\"ai\",\"app\":\"\",\"app_dir\":\"/root/profiler-app/HIAI_PROJECTS/workspacembya66flwgau15rd//test/out/main\",\"app_parameters\":\"\",\"app_working_dir\":\"\",\"autotuning\":\"\",\"cmd\":\"profile\",\"collect_only\":false,\"cpu_sampling_interval\":10,\"aiCtrlCpuProfiling\":\"on\",\"ai_ctrl_cpu_profiling_events\":\"0x11,0x8,0x19,0x20,0x10,0x23\",\"devices\":\"0\",\"dir\":\"\",\"host_cpu_profiling\":\"\",\"host_cpu_profiling_events\":\"\",\"is_cancel\":false,\"job_id\":\"5276fa60-8b2a-11e8-9084-0242ac110002\",\"peripheral_prof_interval\":1,\"profiling_mode\":\"online\",\"result_dir\":\"/tmp/profiler/5276fa60-8b2a-11e8-9084-0242ac110002\",\"tsCpuProfiling\":\"off\",\"ts_cpu_profiling_events\":\"0x11,0x8\",\"llc_profiling\":\"on\",\"llc_profiling_events\":\"e1,e2,e3\",\"ddr_profiling\":\"on\",\"ddr_profiling_events\":\"e1,e2,e3\"}";

    std::string params_str_sample_based = "{\"ai_core_profiling\":\"on\",\"ai_core_profiling_events\":\"0x8,0x11,012,0x15,0x18,0x19,0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x9,0x10,0x13,0x14,0x16,0x17,0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x30,0x31,0x32,0x33,0x34,0x35\",\"aicore_sampling_interval\":1,\"ai_core_profiling_mode\":\"sample-based\",\"aiCtrlCpuProfiling\":\"on\",\"ai_cpu_profiling_events\":\"0x11,0x8\",\"ai_cpu_profiling_function\":\"off\",\"analysis_type\":\"ai\",\"app\":\"\",\"app_dir\":\"/root/profiler-app/HIAI_PROJECTS/workspacembya66flwgau15rd//test/out/main\",\"app_parameters\":\"\",\"app_working_dir\":\"\",\"autotuning\":\"\",\"cmd\":\"profile\",\"collect_only\":false,\"cpu_sampling_interval\":10,\"aiCtrlCpuProfiling\":\"on\",\"ai_ctrl_cpu_profiling_events\":\"0x11,0x8,0x10,0x12,0x15,0x16,0x17,0x17,0x20,0x21,0x22,0x23,0x24,0x25,002\",\"devices\":\"0\",\"dir\":\"\",\"host_cpu_profiling_events\":\"\",\"is_cancel\":false,\"job_id\":\"5276fa60-8b2a-11e8-9084-0242ac110002\",\"peripheral_prof_interval\":1,\"profiling_mode\":\"online\",\"result_dir\":\"/tmp/profiler/5276fa60-8b2a-11e8-9084-0242ac110002\",\"tsCpuProfiling\":\"on\",\"ts_cpu_profiling_events\":\"0x11,0x8\",\"llc_profiling\":\"on\",\"llc_profiling_events\":\"e1,e2,e3\",\"ddr_profiling\":\"on\",\"ddr_profiling_events\":\"e1,e2,e3\"}";

    std::shared_ptr<ITransport> trans;
    std::shared_ptr<ITransport> fake_trans;
protected:
    virtual void SetUp() {
    
        params = std::make_shared<analysis::dvvp::message::ProfileParams> ();
        params->FromString(params_str_task_based);
        params_sample_based = std::make_shared<analysis::dvvp::message::ProfileParams> ();
        params_sample_based->FromString(params_str_sample_based);
        std::cout<<"params:"<<params->ToString()<<std::endl;

        trans = std::make_shared<HDCTransport>(session);
    }
    virtual void TearDown() {
    }
};

void DeviceCallbackFun(int dev, const std::string &job, const std::string &value)
{
    return;
}

TEST_F(HOST_PROF_DEVICE_TEST, SetResponseCallback) {
    GlobalMockObject::verify();

    Device dev(params, dev_id);
    DeviceCallback fn = DeviceCallbackFun;
    
    EXPECT_EQ(PROFILING_FAILED, dev.SetResponseCallback(nullptr));
    EXPECT_EQ(PROFILING_SUCCESS, dev.SetResponseCallback(fn));
}

TEST_F(HOST_PROF_DEVICE_TEST, InitFailed) {
    GlobalMockObject::verify();
    Device dev(params, "-1");
    EXPECT_EQ(PROFILING_FAILED, dev.Init());
}

TEST_F(HOST_PROF_DEVICE_TEST, run_online)
{
    GlobalMockObject::verify();
    Device dev(params, dev_id);
    dev.Init(); 

    HDC_SESSION session = (HDC_SESSION)0x12345678;
    auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
            new analysis::dvvp::transport::HDCTransport(session));
    EXPECT_NE(nullptr, transport);

    MOCKER_CPP(&Device::WaitSyncDataCtrl)
        .stubs();
    
    dev.SetResponseCallback(DeviceCallbackFun);
    params->profiling_mode = "def_mode";
    //init_tran failed
    dev.Init();
    dev.Run();

    //SendStartJobMessage failed
    dev.Run();
    
    //SendStopJobMessage failed
    dev.Run();
    //success
    dev.Run();

    MOCKER_CPP(&Analysis::Dvvp::JobWrapper::JobDeviceRpc::SendMsgAndHandleResponse)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::UploadFileData)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    dev.Run();

}

TEST_F(HOST_PROF_DEVICE_TEST, run_sample_based)
{
    GlobalMockObject::verify();
    Device dev(params_sample_based, dev_id);

    HDC_SESSION session = (HDC_SESSION)0x12345678;
    auto transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
            new analysis::dvvp::transport::HDCTransport(session));
    EXPECT_NE(nullptr, transport);

    MOCKER_CPP(&Device::WaitSyncDataCtrl)
        .stubs();

    MOCKER_CPP(&Device::WaitStopReplay)
        .stubs();

    dev.SetResponseCallback(DeviceCallbackFun);
    //drv_get_dev_info failed sample based
    dev.Init();
    dev.Run();
    //sample based success
    dev.isQuited_ = false;
    dev.params_->profiling_mode = "def_mode";
    dev.Run();
    //start_replay failed
    dev.isQuited_ = false;
    dev.Run();
    //stop_replay failed
    dev.isQuited_ = false;
    dev.Run();
    //success
    dev.isQuited_ = false;
    dev.Run();
}

TEST_F(HOST_PROF_DEVICE_TEST, GetAiCoreEventsStr)
{
    GlobalMockObject::verify();
    Device dev(params, dev_id); 
    dev.Init(); 
    dev.aiCoreEventsStr_ = "";
    EXPECT_STREQ("", dev.GetAiCoreEventsStr().c_str());
}

TEST_F(HOST_PROF_DEVICE_TEST, stop)
{
    GlobalMockObject::verify();
    Device dev(params, dev_id); 
    dev.Init(); 
    EXPECT_EQ(0, dev.Stop());
}

TEST_F(HOST_PROF_DEVICE_TEST, Wait)
{
    GlobalMockObject::verify();
    Device dev(params, dev_id); 
    dev.Init(); 
    
    std::shared_ptr<analysis::dvvp::common::thread::Thread>  thread(
        new Device(params, dev_id));    

    dev.indexIdStr_ = "1";
    dev.SetResponseCallback(DeviceCallbackFun);

    MOCKER_CPP(&analysis::dvvp::common::thread::Thread::Join)
        .stubs()
        .will(returnValue(0));
    params->profiling_mode = "def_mode";
    EXPECT_EQ(0, dev.Wait());
}

TEST_F(HOST_PROF_DEVICE_TEST, GetStatus)
{
    GlobalMockObject::verify();
    Device dev(params, dev_id); 
    dev.Init(); 

    dev.status_->status = analysis::dvvp::message::ERR;   
    EXPECT_EQ(analysis::dvvp::message::ERR,
        dev.GetStatus()->status);
}

TEST_F(HOST_PROF_DEVICE_TEST, PackAiCoreEvents)
{
    GlobalMockObject::verify();
    Device dev(params, dev_id);
    dev.Init(); 

    std::string cpu_profiling_events = "0x11";
    std::vector<std::vector<std::string> > cpu_events;
    
    EXPECT_EQ(0, dev.PackAiCoreEvents(cpu_profiling_events, cpu_events));

    cpu_profiling_events = "12,0x12";

    EXPECT_EQ(0, dev.PackAiCoreEvents(cpu_profiling_events, cpu_events));
}

TEST_F(HOST_PROF_DEVICE_TEST, GetAllEvents)
{
    GlobalMockObject::verify();
    Device dev(params, dev_id);
    dev.Init(); 

    std::string cpu_profiling_events = "0x11";
    std::vector<std::vector<std::string> > cpu_events;
    
    EXPECT_EQ(0, dev.PackCpuEvents(cpu_profiling_events, cpu_events));

    cpu_profiling_events = "12,0x12";

    EXPECT_EQ(0, dev.PackCpuEvents(cpu_profiling_events, cpu_events));
}

TEST_F(HOST_PROF_DEVICE_TEST, PackCpuEvents)
{
    GlobalMockObject::verify();
    Device dev(params, dev_id);
    dev.Init(); 

    std::string cpu_profiling_events = "0x11";
    std::vector<std::vector<std::string> > cpu_events;
    
    EXPECT_EQ(0, dev.PackCpuEvents(cpu_profiling_events, cpu_events));

    cpu_profiling_events = "12,0x12";

    EXPECT_EQ(0, dev.PackCpuEvents(cpu_profiling_events, cpu_events));
}
////////////////////////////////////////////////////////////////////////////

void fake_get_child_dirs(const std::string &dir, bool is_recur, std::vector<std::string>& app_dirs)
{
    app_dirs.push_back("/path/to/app/app1");
    app_dirs.push_back("/path/to/app/app2");
    app_dirs.push_back("/path/to/app/app1/child");
}

void fake_replace_dirs(const std::vector<std::string> &old_dirs,
                                int begin_pos, int end_pos, const std::string &dst_str,
                                std::vector<std::string> &device_app_dirs)
{
    device_app_dirs.push_back("/path/to/device/app1");
    device_app_dirs.push_back("/path/to/device/app2");
    device_app_dirs.push_back("/path/to/device/app1/child");
}


TEST_F(HOST_PROF_DEVICE_TEST, PackLlcEvents)
{

    GlobalMockObject::verify();
    Device dev(params, dev_id);
    dev.Init(); 
    std::string llc_profiling_events = "event1,event2,event3,event4,event5,event6,e7,e8,e9";
    std::vector<std::vector<std::string> > llc_events;
    EXPECT_EQ(PROFILING_SUCCESS, dev.PackLlcEvents(llc_profiling_events, llc_events));
    EXPECT_EQ((size_t)2, llc_events.size());
}

TEST_F(HOST_PROF_DEVICE_TEST, PackDdrEvents)
{
    GlobalMockObject::verify();
    Device dev(params, dev_id);
    dev.Init(); 
    std::string ddr_profiling_events = "event1,event2,event3,event4,event5,event6,e7,e8,e9";
    std::vector<std::vector<std::string> > ddr_events;
    EXPECT_EQ(PROFILING_SUCCESS, dev.PackDdrEvents(8, ddr_profiling_events, ddr_events));
    EXPECT_EQ((size_t)2, ddr_events.size());

}

TEST_F(HOST_PROF_DEVICE_TEST, WaitStopReplay)
{
    GlobalMockObject::verify();
    Device dev(params, dev_id);
    dev.Init(); 
    dev.isQuited_ = true;
    dev.isStopReplayReady = true;
    dev.WaitStopReplay();
    EXPECT_FALSE(dev.isStopReplayReady);
}

TEST_F(HOST_PROF_DEVICE_TEST, GetIsQuited)
{
    GlobalMockObject::verify();
    Device dev(params, dev_id);
    dev.Init(); 

    EXPECT_FALSE(dev.GetIsQuited());
}
///////////////////////////////////////////////////
TEST_F(HOST_PROF_DEVICE_TEST, RepackAiCoreEventByCore)
{
    GlobalMockObject::verify();
	std::vector<std::string> ai_core_event(33, "0");
	std::vector<std::vector<std::string> > ai_core_events;
    ai_core_events.push_back(ai_core_event);
	std::vector<std::vector<int> >  ai_cores;
    std::vector<std::vector<std::string> > ai_core_events_flat;
    Device dev(params, dev_id);
    EXPECT_EQ(0, dev.RepackAiCoreEventByCore(2, ai_core_events, ai_cores, ai_core_events_flat));
}

TEST_F(HOST_PROF_DEVICE_TEST, RepackAiCoreEventByCore2)
{
    GlobalMockObject::verify();
    std::vector<std::string> ai_core_event(31, "0");
    std::vector<std::vector<std::string> > ai_core_events;
    ai_core_events.push_back(ai_core_event);
    std::vector<std::vector<int> >  ai_cores;
    std::vector<std::vector<std::string> > ai_core_events_flat;
    Device dev(params, dev_id);
    EXPECT_EQ(0, dev.RepackAiCoreEventByCore(2, ai_core_events, ai_cores, ai_core_events_flat));
}

TEST_F(HOST_PROF_DEVICE_TEST, RepackAiCoreEventByCoreContinue)
{
    GlobalMockObject::verify();
    std::vector<std::string> ai_core_event(33, "0");
    std::vector<std::vector<std::string> > ai_core_events(1, ai_core_event);
    std::vector<std::vector<int> >  ai_cores;
    std::vector<std::vector<std::string> > ai_core_events_flat;
    params->profiling_mode = "online";
    Device dev(params, dev_id);
    EXPECT_EQ(0, dev.RepackAiCoreEventByCore(2, ai_core_events, ai_cores, ai_core_events_flat));
}

///////////////////////////////////////////////////
TEST_F(HOST_PROF_DEVICE_TEST, SetIsQuited)
{
    GlobalMockObject::verify();
    Device dev(params, dev_id);
    EXPECT_EQ(PROFILING_SUCCESS, dev.Init());

    dev.SetIsQuited();
}

TEST_F(HOST_PROF_DEVICE_TEST, PostSyncDataCtrl)
{
    GlobalMockObject::verify();
    Device dev(params, dev_id);
    dev.PostSyncDataCtrl();
    EXPECT_TRUE(dev.isDataChannelEnd_);

}

TEST_F(HOST_PROF_DEVICE_TEST, WaitSyncDataCtrl)
{
    GlobalMockObject::verify();
    Device dev(params, dev_id);
    EXPECT_EQ(PROFILING_SUCCESS, dev.Init());
    dev.isDataChannelEnd_ = true;
    dev.WaitSyncDataCtrl();
}

TEST_F(HOST_PROF_DEVICE_TEST, CreatePmuEventConfig)
{
    GlobalMockObject::verify();
    ProfilingEvents profilingEvents;
    Device dev(params, dev_id);
    dev.ctrlCPUEvents_ = new std::vector<std::string>();
    dev.tsCPUEvents_ = new std::vector<std::string>();
    dev.aiCoreEvents_ = new std::vector<std::string>();
    dev.aiCoreEventsCoreIds_ = new std::vector<int>();
    dev.aivEvents_ = new std::vector<std::string>();
    dev.aivEventsCoreIds_ = new std::vector<int>();
    dev.llcEvents_ = new std::vector<std::string>();
    dev.ddrEvents_ = new std::vector<std::string>();
    EXPECT_NE(nullptr, dev.CreatePmuEventConfig());
    delete dev.ctrlCPUEvents_;
    delete dev.tsCPUEvents_;
    delete dev.aiCoreEvents_;
    delete dev.aiCoreEventsCoreIds_;
    delete dev.aivEvents_;
    delete dev.aivEventsCoreIds_;
    delete dev.llcEvents_;
    delete dev.ddrEvents_;
}

