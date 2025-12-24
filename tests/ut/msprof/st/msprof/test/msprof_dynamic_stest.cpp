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
#include <string.h>
#include <google/protobuf/util/json_util.h>
#include "dyn_prof_def.h"
#include "dyn_prof_server.h"
#include "dyn_prof_client.h"
#include "dyn_prof_mgr.h"
#include "cmd_log/cmd_log.h"
#include "config/config.h"
#include "errno/error_code.h"
#include "socket/local_socket.h"
#include "msprof_dlog.h"
#include "utils/utils.h"
#include "msprofiler_impl.h"
#include "prof_acl_mgr.h"

using namespace Collector::Dvvp::DynProf;
using namespace analysis::dvvp::common::cmdlog;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::socket;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::thread;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::MsprofErrMgr;

class MSPROF_DYNAMIC_STEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();

        DynProfCliMgr::instance()->enabled_ = false;
        DynProfCliMgr::instance()->keyPid_ = 0;
        DynProfCliMgr::instance()->isAppMode_ = false;
        DynProfCliMgr::instance()->dynProfCli_ = nullptr;

        DynProfMgr::instance()->isStarted_ = false;
        DynProfMgr::instance()->dynProfSrv_ = nullptr;
    }
};

TEST_F(MSPROF_DYNAMIC_STEST, dynamic_socket_connect)
{
    MOCKER(Utils::HandleEnvString)
        .stubs()
        .will(returnValue(std::string("dynamic")))
        .then(returnValue(std::string("")));
    MOCKER(LocalSocket::SetSendTimeOut)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(PROFILING_SUCCESS, DynProfMgr::instance()->StartDynProf());
    EXPECT_EQ(true, DynProfMgr::instance()->IsDynStarted());

    std::string params = "";
    DynProfCliMgr::instance()->EnableDynProfCli();
    EXPECT_EQ(PROFILING_FAILED, DynProfCliMgr::instance()->StartDynProfCli(params));
    params = "xxx";
    EXPECT_EQ(PROFILING_FAILED, DynProfCliMgr::instance()->StartDynProfCli(params));

    DynProfMgr::instance()->StopDynProf();
    DynProfCliMgr::instance()->StopDynProfCli();
}

class MSPROF_DYNAMIC_CLIENT_STEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        DynProfCliMgr::instance()->enabled_ = false;
        DynProfCliMgr::instance()->keyPid_ = 0;
        DynProfCliMgr::instance()->dynProfCli_ = nullptr;
        DynProfCliMgr::instance()->isAppMode_ = false;
    }
};

TEST_F(MSPROF_DYNAMIC_CLIENT_STEST, DynProfClient_RunSetSendTimeOutFail)
{
    struct error_message::Context errorContext;
    SHARED_PTR_ALIA<DynProfClient> dynProfClient = std::make_shared<DynProfClient>();
    dynProfClient->cliStarted_ = true;
    MOCKER(LocalSocket::SetRecvTimeOut)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER(LocalSocket::SetSendTimeOut)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    dynProfClient->Run(errorContext);
    EXPECT_EQ(false, dynProfClient->cliStarted_);
}

TEST_F(MSPROF_DYNAMIC_CLIENT_STEST, DynProfClient_DynProfCliCreate_AppModeTimeOut)
{
    SHARED_PTR_ALIA<DynProfClient> dynProfClient = std::make_shared<DynProfClient>();

    MOCKER_CPP(&DynProfCliMgr::IsAppMode)
        .stubs()
        .will(returnValue(true));
    MOCKER(LocalSocket::Open)
        .stubs()
        .will(returnValue(1));
    MOCKER(LocalSocket::Connect)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    MOCKER(LocalSocket::Close)
        .stubs()
        .will(ignoreReturnValue());
    MOCKER(Utils::UsleepInterupt)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, dynProfClient->DynProfCliCreate());
}

TEST_F(MSPROF_DYNAMIC_CLIENT_STEST, DynProfClient_DynProfCliSendCmd)
{
    SHARED_PTR_ALIA<DynProfClient> dynProfClient;
    dynProfClient = std::make_shared<DynProfClient>();
    DynProfMsgType req = DynProfMsgType::DYN_PROF_START_REQ;
    EXPECT_EQ(DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL, dynProfClient->DynProfCliSendCmd(req));

    dynProfClient->cliSockFd_ = 10;
    MOCKER(LocalSocket::Send, int(int, const void *, int, int)).stubs().will(returnValue(PROFILING_SUCCESS));
    DynProfMsg rsqMsg;
    void *v = &rsqMsg;
    MOCKER(LocalSocket::Recv, int(int, void *, int, int))
        .stubs()
        .with(any(), outBoundP(v, sizeof(DynProfMsg)), any(), any())
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL, dynProfClient->DynProfCliSendCmd(req));
}


TEST_F(MSPROF_DYNAMIC_CLIENT_STEST, DynProfClient_DynProfCliProcStart)
{
    DynProfCliMgr::instance()->dynProfCli_ = std::make_shared<DynProfClient>();
    DynProfCliMgr::instance()->dynProfCli_->cliStarted_ = true;
    MOCKER_CPP(&DynProfClient::DynProfCliSendCmd)
        .stubs()
        .will(returnValue(DynProfMsgRsqCode::DYN_PROF_RSQ_SUCCESS))
        .then(returnValue(DynProfMsgRsqCode::DYN_PROF_RSQ_ALREADY_START))
        .then(returnValue(DynProfMsgRsqCode::DYN_PROF_RSQ_NOT_SET_DEVICE))
        .then(returnValue(DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL));
    DynProfCliMgr::instance()->dynProfCli_->DynProfCliProcStart();
    EXPECT_EQ(DynProfCliMgr::instance()->dynProfCli_->cliStarted_, true);
    DynProfCliMgr::instance()->dynProfCli_->DynProfCliProcStart();
    EXPECT_EQ(DynProfCliMgr::instance()->dynProfCli_->cliStarted_, true);
    DynProfCliMgr::instance()->dynProfCli_->DynProfCliProcStart();
    EXPECT_EQ(DynProfCliMgr::instance()->dynProfCli_->cliStarted_, true);
    DynProfCliMgr::instance()->dynProfCli_->DynProfCliProcStart();
    EXPECT_EQ(DynProfCliMgr::instance()->dynProfCli_->cliStarted_, false);
}

TEST_F(MSPROF_DYNAMIC_CLIENT_STEST, DynProfClient_DynProfCliProcStop)
{
    DynProfCliMgr::instance()->dynProfCli_ = std::make_shared<DynProfClient>();
    DynProfCliMgr::instance()->dynProfCli_->cliStarted_ = true;
    MOCKER_CPP(&DynProfClient::DynProfCliSendCmd)
        .stubs()
        .will(returnValue(DynProfMsgRsqCode::DYN_PROF_RSQ_SUCCESS))
        .then(returnValue(DynProfMsgRsqCode::DYN_PROF_RSQ_NOT_START))
        .then(returnValue(DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL));
    DynProfCliMgr::instance()->dynProfCli_->DynProfCliProcStop();
    EXPECT_EQ(DynProfCliMgr::instance()->dynProfCli_->cliStarted_, true);
    DynProfCliMgr::instance()->dynProfCli_->DynProfCliProcStop();
    EXPECT_EQ(DynProfCliMgr::instance()->dynProfCli_->cliStarted_, true);
    DynProfCliMgr::instance()->dynProfCli_->DynProfCliProcStop();
    EXPECT_EQ(DynProfCliMgr::instance()->dynProfCli_->cliStarted_, false);
}

TEST_F(MSPROF_DYNAMIC_CLIENT_STEST, DynProfClient_DynProfCliProcQuit)
{
    DynProfCliMgr::instance()->dynProfCli_ = std::make_shared<DynProfClient>();
    DynProfCliMgr::instance()->dynProfCli_->cliStarted_ = true;
    MOCKER_CPP(&DynProfClient::DynProfCliSendCmd)
        .stubs()
        .will(returnValue(DynProfMsgRsqCode::DYN_PROF_RSQ_SUCCESS))
        .then(returnValue(DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL));
    MOCKER(mmJoinTask).stubs().will(returnValue(EN_OK)).then(returnValue(EN_OK));
    DynProfCliMgr::instance()->dynProfCli_->DynProfCliProcQuit();
    EXPECT_EQ(DynProfCliMgr::instance()->dynProfCli_->cliStarted_, false);
    DynProfCliMgr::instance()->dynProfCli_->DynProfCliProcQuit();
    EXPECT_EQ(DynProfCliMgr::instance()->dynProfCli_->cliStarted_, false);
}

TEST_F(MSPROF_DYNAMIC_CLIENT_STEST, DynProfClient_DynProfCliHelpInfo)
{
    SHARED_PTR_ALIA<DynProfClient> dynProfClient;
    dynProfClient = std::make_shared<DynProfClient>();
    dynProfClient->cliStarted_ = true;
    dynProfClient->DynProfCliHelpInfo();
    EXPECT_EQ(dynProfClient->cliStarted_, true);
}

TEST_F(MSPROF_DYNAMIC_CLIENT_STEST, DynProfClient_IsCliStarted)
{
    EXPECT_EQ(false, DynProfCliMgr::instance()->IsCliStarted());

    DynProfCliMgr::instance()->dynProfCli_ = std::make_shared<DynProfClient>();
    DynProfCliMgr::instance()->dynProfCli_->cliStarted_ = true;
    EXPECT_EQ(true, DynProfCliMgr::instance()->IsCliStarted());
}

class MSPROF_DYNAMIC_SERVER_STEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        DynProfMgr::instance()->isStarted_ = false;
        DynProfMgr::instance()->dynProfSrv_ = nullptr;
    }
};

TEST_F(MSPROF_DYNAMIC_SERVER_STEST, DynProfServer_DynProfSrvCreate_appMode)
{
    SHARED_PTR_ALIA<DynProfServer> dynProfServer = std::make_shared<DynProfServer>();
    MOCKER(Utils::HandleEnvString)
        .stubs()
        .will(returnValue(std::string("123")));
    MOCKER(Utils::GetPid)
        .stubs()
        .will(returnValue(321));
    MOCKER_CPP(&LocalSocket::Create)
        .stubs()
        .will(returnValue(SOCKET_ERR_EADDRINUSE))
        .then(returnValue(1));
    MOCKER_CPP(&LocalSocket::SetRecvTimeOut)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));

    EXPECT_EQ(PROFILING_SUCCESS, dynProfServer->DynProfSrvCreate());
}

TEST_F(MSPROF_DYNAMIC_SERVER_STEST, DynProfServer_DynProfSrvProcStart)
{
    MOCKER(&Msprofiler::Api::ProfAclMgr::StartUploaderDumper)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    SHARED_PTR_ALIA<DynProfServer> dynProfServer;
    dynProfServer = std::make_shared<DynProfServer>();
    dynProfServer->profStarted_ = true;
    dynProfServer->DynProfSrvProcStart();

    dynProfServer->profStarted_ = false;
    dynProfServer->devicesInfo_ = {};
    dynProfServer->DynProfSrvProcStart();

    DynProfDeviceInfo data;
    data.chipId = 0;
    data.devId = 0;
    data.isOpenDevice = true;
    dynProfServer->devicesInfo_.insert(std::pair<uint32_t, DynProfDeviceInfo>(data.devId, data));

    MOCKER(&Msprofiler::Api::ProfAclMgr::MsprofInitAclEnv)
        .stubs()
        .will(returnValue(1))
        .then(returnValue(0))
        .then(returnValue(0))
        .then(returnValue(0));
    dynProfServer->DynProfSrvProcStart();

    MOCKER(&Msprofiler::Api::ProfAclMgr::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_SUCCESS));
    dynProfServer->DynProfSrvProcStart();

    MOCKER(&Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice).stubs().will(returnValue(1)).then(returnValue(0));
    dynProfServer->DynProfSrvProcStart();

    dynProfServer->DynProfSrvProcStart();
    EXPECT_EQ(true, dynProfServer->profStarted_);
}

TEST_F(MSPROF_DYNAMIC_SERVER_STEST, DynProfServer_DynProfSrvProcStop)
{
    SHARED_PTR_ALIA<DynProfServer> dynProfServer;
    dynProfServer = std::make_shared<DynProfServer>();
    dynProfServer->profStarted_ = false;
    dynProfServer->DynProfSrvProcStop();

    MOCKER(&Msprofiler::Api::ProfAclMgr::MsprofFinalizeHandle).stubs().will(returnValue(1)).then(returnValue(0));
    dynProfServer->profStarted_ = true;
    dynProfServer->DynProfSrvProcStop();
    EXPECT_EQ(false, dynProfServer->srvStarted_);

    dynProfServer->DynProfSrvProcStop();
    EXPECT_EQ(false, dynProfServer->profStarted_);
}

TEST_F(MSPROF_DYNAMIC_SERVER_STEST, DynProfServer_DynProfSrvProcQuit)
{
    SHARED_PTR_ALIA<DynProfServer> dynProfServer;
    dynProfServer = std::make_shared<DynProfServer>();
    dynProfServer->profStarted_ = true;
    MOCKER(&Msprofiler::Api::ProfAclMgr::MsprofFinalizeHandle).stubs().will(returnValue(1));
    dynProfServer->DynProfSrvProcQuit();
    EXPECT_EQ(false, dynProfServer->srvStarted_);

    dynProfServer->profStarted_ = false;
    MOCKER(&DynProfServer::DynProfSrvCreate).stubs().will(returnValue(PROFILING_FAILED));
    dynProfServer->DynProfSrvProcQuit();
    EXPECT_EQ(false, dynProfServer->srvStarted_);
}

TEST_F(MSPROF_DYNAMIC_SERVER_STEST, DynProfServer_deviceInfo)
{
    MOCKER(Utils::HandleEnvString)
        .stubs()
        .will(returnValue(std::string("dynamic")))
        .then(returnValue(std::string("")));
    EXPECT_EQ(PROFILING_SUCCESS, DynProfMgr::instance()->StartDynProf());
    DynProfMgr::instance()->SaveDevicesInfo(1, 2, true);
    EXPECT_EQ(1, DynProfMgr::instance()->dynProfSrv_->devicesInfo_.size());
    auto devInfo = DynProfMgr::instance()->dynProfSrv_->devicesInfo_[2];
    EXPECT_EQ(1, devInfo.chipId);
    EXPECT_EQ(2, devInfo.devId);
    EXPECT_EQ(true, devInfo.isOpenDevice);
    DynProfMgr::instance()->SaveDevicesInfo(1, 2, true);
    DynProfMgr::instance()->SaveDevicesInfo(1, 2, false);
    EXPECT_EQ(0, DynProfMgr::instance()->dynProfSrv_->devicesInfo_.size());
    DynProfMgr::instance()->StopDynProf();
}

TEST_F(MSPROF_DYNAMIC_SERVER_STEST, DynProfMgr_IsProfStarted)
{
    EXPECT_EQ(false, DynProfMgr::instance()->IsProfStarted());
    DynProfMgr::instance()->dynProfSrv_ = std::make_shared<DynProfServer>();
    DynProfMgr::instance()->dynProfSrv_->profStarted_ = true;
    EXPECT_EQ(true, DynProfMgr::instance()->IsProfStarted());
}