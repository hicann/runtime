/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <iostream>
#include <stdexcept>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "message/prof_params.h"

using namespace analysis::dvvp::message;

///////////////////////////////////////////////////////////////////
class MESSAGE_MESSAGE_STATUSINFO_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(MESSAGE_MESSAGE_STATUSINFO_TEST, ToObject) {
    GlobalMockObject::verify();

    std::string info = "this is test";
    StatusInfo status("1", ERR, info);

    NanoJson::Json object;
    status.ToObject(object);

    EXPECT_NE(std::string::npos, object.ToString().find("\"info\":\"this is test\""));
    EXPECT_NE(std::string::npos, object.ToString().find("\"status\":1"));
    EXPECT_NE(std::string::npos, object.ToString().find("\"dev_id\":\"1\""));
}

TEST_F(MESSAGE_MESSAGE_STATUSINFO_TEST, FromObject) {
    GlobalMockObject::verify();

    std::string info = "this is test";
    StatusInfo status("1", ERR, info);

    NanoJson::Json object;
    status.ToObject(object);

    StatusInfo status1;
    status1.FromObject(object);

    EXPECT_EQ(status.dev_id, status1.dev_id);
    EXPECT_EQ(status.status, status1.status);
}

TEST_F(MESSAGE_MESSAGE_STATUSINFO_TEST, ToString) {
    GlobalMockObject::verify();

    std::string info = "this is test";
    StatusInfo status("1", ERR, info);

    EXPECT_NE(std::string::npos, status.ToString().find("\"info\":\"this is test\""));
    EXPECT_NE(std::string::npos, status.ToString().find("\"status\":1"));
    EXPECT_NE(std::string::npos, status.ToString().find("\"dev_id\":\"1\""));
}

TEST_F(MESSAGE_MESSAGE_STATUSINFO_TEST, FromString) {
    GlobalMockObject::verify();

    std::string info = "this is test";
    StatusInfo status("1", ERR, info);
    StatusInfo status1;
    EXPECT_FALSE(status1.FromString("{"));
    EXPECT_FALSE(status1.FromString(""));
    EXPECT_TRUE(status1.FromString(status.ToString()));
}

///////////////////////////////////////////////////////////////////
class MESSAGE_MESSAGE_STATUS_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(MESSAGE_MESSAGE_STATUS_TEST, ToObject) {
    GlobalMockObject::verify();

    std::string info = "this is test";
    StatusInfo status_info("1", ERR, info);

    Status status;
    status.AddStatusInfo(status_info);

    NanoJson::Json object;
    status.ToObject(object);
    std::string str = "{\"info\":[{\"info\":\"this is test\",\"status\":1,\"dev_id\":\"1\"}],\"status\":1}";

    EXPECT_NE(std::string::npos, object.ToString().find("\"info\":\"this is test\""));
    EXPECT_NE(std::string::npos, object.ToString().find("\"status\":1"));
    EXPECT_NE(std::string::npos, object.ToString().find("\"dev_id\":\"1\""));
}

TEST_F(MESSAGE_MESSAGE_STATUS_TEST, FromObject) {
    GlobalMockObject::verify();

    std::string info = "this is test";
    StatusInfo status_info("1", ERR, info);

    Status status;
    status.AddStatusInfo(status_info);

    NanoJson::Json object;
    status.ToObject(object);

    Status status1;
    status1.FromObject(object);

    EXPECT_EQ(status.status, status1.status);
}

TEST_F(MESSAGE_MESSAGE_STATUS_TEST, ToString) {
    GlobalMockObject::verify();

    std::string info = "this is test";
    StatusInfo status_info("1", ERR, info);

    Status status;
    status.AddStatusInfo(status_info);
    std::string str = "{\"info\":[{\"info\":\"this is test\",\"status\":1,\"dev_id\":\"1\"}],\"status\":1}";
    EXPECT_NE(std::string::npos, status.ToString().find("\"info\":\"this is test\""));
    EXPECT_NE(std::string::npos, status.ToString().find("\"status\":1"));
    EXPECT_NE(std::string::npos, status.ToString().find("\"dev_id\":\"1\""));
}

TEST_F(MESSAGE_MESSAGE_STATUS_TEST, FromString) {
    GlobalMockObject::verify();

    std::string info = "this is test";
    StatusInfo status_info("1", ERR, info);

    Status status;
    status.AddStatusInfo(status_info);

    Status status1;
    EXPECT_FALSE(status1.FromString("{"));
    EXPECT_FALSE(status1.FromString(""));
    EXPECT_TRUE(status1.FromString(status.ToString()));
}

///////////////////////////////////////////////////////////////////
class MESSAGE_MESSAGE_PROFILEPARAMS_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};


TEST_F(MESSAGE_MESSAGE_PROFILEPARAMS_TEST, DISABLED_FromObject) {
    GlobalMockObject::verify();

    ProfileParams params;

    NanoJson::Json object;
    params.ToObject(object);

    ProfileParams params1;
    params1.FromObject(object);

    EXPECT_EQ(params1.aicore_sampling_interval, params.aicore_sampling_interval);
    EXPECT_EQ(params1.cpu_sampling_interval, params.cpu_sampling_interval);
    EXPECT_EQ(params1.sys_sampling_interval, params.sys_sampling_interval);
    EXPECT_EQ(params1.pid_sampling_interval, params.pid_sampling_interval);
    EXPECT_EQ(params1.hardware_mem_sampling_interval, params.hardware_mem_sampling_interval);
    EXPECT_EQ(params1.llc_interval, params.llc_interval);
    EXPECT_EQ(params1.ddr_interval, params.ddr_interval);
    EXPECT_EQ(params1.hbmInterval, params.hbmInterval);
    EXPECT_EQ(params1.io_sampling_interval, params.io_sampling_interval);
    EXPECT_EQ(params1.nicInterval, params.nicInterval);
    EXPECT_EQ(params1.roceInterval, params.roceInterval);
    EXPECT_EQ(params1.interconnection_sampling_interval, params.interconnection_sampling_interval);
    EXPECT_EQ(params1.hccsInterval, params.hccsInterval);
    EXPECT_EQ(params1.pcieInterval, params.pcieInterval);
    EXPECT_EQ(params1.dvpp_sampling_interval, params.dvpp_sampling_interval);
}

TEST_F(MESSAGE_MESSAGE_PROFILEPARAMS_TEST, DISABLED_ToString) {
    GlobalMockObject::verify();

    ProfileParams params;
    std::string str = "{\"hostAllPidMemProfiling\":\"off\",\"hcclTrace\":\"\",\"runtimeApi\":\"off\",\"aicore_sampling_interval\":10,\"qosProfiling\":\"\",\"dvpp_sampling_interval\":20,\"aicpuTrace\":\"\",\"aiv_sampling_interval\":10,\"ccuInstr\":\"off\",\"host_mem_profiling\":\"off\",\"host_osrt_profiling\":\"off\",\"hostProfiling\":false,\"io_sampling_interval\":10,\"host_network_profiling\":\"off\",\"nicProfiling\":\"off\",\"ts_cpu_hot_function\":\"\",\"instrProfilingFreq\":1000,\"ai_core_profiling_metrics\":\"\",\"dvpp_profiling\":\"off\",\"ubProfiling\":\"off\",\"interconnection_sampling_interval\":20,\"l2CacheTaskProfilingEvents\":\"\",\"sys_sampling_interval\":100,\"cpu_sampling_interval\":20,\"ai_core_profiling_mode\":\"\",\"devices\":\"\",\"runtimeTrace\":\"\",\"app_parameters\":\"\",\"host_cpu_profiling\":\"off\",\"interconnection_profiling\":\"off\",\"pcieProfiling\":\"\",\"npuEvents\":\"\",\"ts_memcpy\":\"\",\"memServiceflow\":\"\",\"sys_profiling\":\"off\",\"ai_core_status\":\"\",\"profiling_options\":\"\",\"pcSampling\":\"off\",\"roceProfiling\":\"off\",\"aiCtrlCpuProfiling\":\"off\",\"tsCpuProfiling\":\"off\",\"pureCpu\":\"off\",\"hardware_mem_sampling_interval\":20000,\"io_profiling\":\"off\",\"cpu_profiling\":\"off\",\"instrProfiling\":\"\",\"host_sys\":\"\",\"app_dir\":\"\",\"memProfiling\":\"off\",\"ts_cpu_profiling_events\":\"\",\"hostSysUsage\":\"\",\"storageLimit\":\"\",\"ai_core_profiling\":\"\",\"app_env\":\"\",\"hscb\":\"off\",\"result_dir\":\"\",\"profiling_mode\":\"\",\"llc_interval\":20,\"jobInfo\":\"\",\"hwts_log1\":\"\",\"pid_sampling_interval\":100,\"aiv_profiling_metrics\":\"\",\"aiv_profiling_events\":\"\",\"aiv_profiling_mode\":\"\",\"hardware_mem\":\"off\",\"msprof\":\"off\",\"taskTrace\":\"on\",\"msprof_llc_profiling\":\"\",\"prof_level\":\"off\",\"scaleName\":\"\",\"ts_keypoint\":\"\",\"job_id\":\"\",\"app_location\":\"\",\"app\":\"\",\"ai_core_lpm\":\"off\",\"ubInterval\":20,\"aiv_profiling\":\"\",\"hbmProfiling\":\"\",\"ts_task_track\":\"\",\"ai_core_metrics\":\"\",\"ts_fw_training\":\"\",\"ts_cpu_usage\":\"\",\"taskTime\":\"on\",\"ts_timeline\":\"\",\"stars_acsq_task\":\"\",\"ai_vector_status\":\"\",\"fwkSchedule\":\"off\",\"sysLp\":\"off\",\"taskTsfw\":\"off\",\"hwts_log\":\"\",\"l2CacheTaskProfiling\":\"\",\"profiling_period\":-1,\"ai_core_profiling_events\":\"\",\"hccsProfiling\":\"off\",\"hccsInterval\":20,\"ai_ctrl_cpu_profiling_events\":\"\",\"nicInterval\":10,\"taskBlock\":\"\",\"aiv_metrics\":\"\",\"pcieInterval\":20,\"isCancel\":false,\"roceInterval\":10,\"pid_profiling\":\"off\",\"llc_profiling\":\"\",\"scaleType\":\"\",\"llc_profiling_events\":\"\",\"durationTime\":\"\",\"taskMemory\":\"off\",\"memInterval\":20,\"ddr_profiling\":\"\",\"ddr_interval\":20,\"msprofBinPid\":-1,\"ddr_master_id\":0,\"hbm_profiling_events\":\"\",\"hbmInterval\":20,\"ddr_profiling_events\":\"\",\"host_sys_pid\":-1,\"host_disk_profiling\":\"off\",\"msproftx\":\"off\",\"host_disk_freq\":50,\"sysLpFreq\":10000,\"aicScale\":\"all\",\"profMode\":\"\",\"delayTime\":\"\",\"qosEvents\":\"\",\"hostProfilingSamplingInterval\":20,\"acl\":\"\",\"hostAllPidCpuProfiling\":\"off\"}";
    EXPECT_STREQ(str.c_str(), params.ToString().c_str());
}

TEST_F(MESSAGE_MESSAGE_PROFILEPARAMS_TEST, FromString) {
    GlobalMockObject::verify();

    ProfileParams params;

    ProfileParams params1;
    EXPECT_FALSE(params1.FromString("{"));
    EXPECT_FALSE(params1.FromString(""));
    EXPECT_TRUE(params1.FromString(params.ToString()));
}

///////////////////////////////////////////////////////////////////
class MESSAGE_MESSAGE_JOBCONTEXT_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(MESSAGE_MESSAGE_JOBCONTEXT_TEST, ToObject) {
    GlobalMockObject::verify();

    JobContext ctx;

    NanoJson::Json object;
    ctx.ToObject(object);

    EXPECT_NE(std::string::npos, object.ToString().find("\"dataModule\":0"));
    EXPECT_NE(std::string::npos, object.ToString().find("\"chunkEndTime\":0"));
    EXPECT_NE(std::string::npos, object.ToString().find("\"stream_enabled\":\"\""));
    EXPECT_NE(std::string::npos, object.ToString().find("\"chunkStartTime\":0"));
    EXPECT_NE(std::string::npos, object.ToString().find("\"dev_id\":\"\""));
    EXPECT_NE(std::string::npos, object.ToString().find("\"tag\":\"\""));
    EXPECT_NE(std::string::npos, object.ToString().find("\"module\":\"\""));
    EXPECT_NE(std::string::npos, object.ToString().find("\"job_id\":\"\""));
    EXPECT_NE(std::string::npos, object.ToString().find("\"result_dir\":\"\""));
}

TEST_F(MESSAGE_MESSAGE_JOBCONTEXT_TEST, ToString) {
    GlobalMockObject::verify();

    JobContext ctx;

    EXPECT_NE(std::string::npos, ctx.ToString().find("\"dataModule\":0"));
    EXPECT_NE(std::string::npos, ctx.ToString().find("\"chunkEndTime\":0"));
    EXPECT_NE(std::string::npos, ctx.ToString().find("\"stream_enabled\":\"\""));
    EXPECT_NE(std::string::npos, ctx.ToString().find("\"chunkStartTime\":0"));
    EXPECT_NE(std::string::npos, ctx.ToString().find("\"dev_id\":\"\""));
    EXPECT_NE(std::string::npos, ctx.ToString().find("\"tag\":\"\""));
    EXPECT_NE(std::string::npos, ctx.ToString().find("\"module\":\"\""));
    EXPECT_NE(std::string::npos, ctx.ToString().find("\"job_id\":\"\""));
    EXPECT_NE(std::string::npos, ctx.ToString().find("\"result_dir\":\"\""));
}

TEST_F(MESSAGE_MESSAGE_JOBCONTEXT_TEST, FromString) {
    GlobalMockObject::verify();

    JobContext ctx;

    JobContext ctx1;
    EXPECT_FALSE(ctx1.FromString("{"));
    EXPECT_FALSE(ctx1.FromString(""));
    EXPECT_TRUE(ctx1.FromString(ctx.ToString()));
}
