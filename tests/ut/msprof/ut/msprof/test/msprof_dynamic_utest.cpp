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
#include "dyn_prof_thread.h"
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

class MSPROF_DYNAMIC_CLIENT_UTEST : public testing::Test {
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

// Unit Test For DynProfClient
TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfClient_SetParams)
{
    SHARED_PTR_ALIA<DynProfClient> dynProfClient;
    dynProfClient = std::make_shared<DynProfClient>();
    std::string params = "start";
    dynProfClient->SetParams(params);
    EXPECT_EQ(params, dynProfClient->dynProfParams_);
}

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfClient_Start)
{
    SHARED_PTR_ALIA<DynProfClient> dynProfClient;
    dynProfClient = std::make_shared<DynProfClient>();
    dynProfClient->cliStarted_ = true;
    int ret = dynProfClient->Start();
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    dynProfClient->cliStarted_ = false;
    dynProfClient->dynProfParams_ = "";
    ret = dynProfClient->Start();
    EXPECT_EQ(PROFILING_FAILED, ret);

    dynProfClient->dynProfParams_ = "start";
    MOCKER_CPP(&DynProfClient::DynProfCliCreate)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_SUCCESS));
    ret = dynProfClient->Start();
    EXPECT_EQ(PROFILING_FAILED, ret);

    MOCKER_CPP(&DynProfClient::DynProfCliSendParams)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_SUCCESS));
    ret = dynProfClient->Start();
    EXPECT_EQ(PROFILING_FAILED, ret);

    MOCKER(mmCreateTaskWithThreadAttr).stubs().will(returnValue(EN_ERROR)).then(returnValue(EN_OK));
    ret = dynProfClient->Start();
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = dynProfClient->Start();
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfClient_Stop)
{
    SHARED_PTR_ALIA<DynProfClient> dynProfClient = std::make_shared<DynProfClient>();
    MOCKER(mmJoinTask).stubs().will(returnValue(EN_OK));
    dynProfClient->cliStarted_ = true;
    EXPECT_EQ(PROFILING_SUCCESS, dynProfClient->Stop());
    EXPECT_EQ(false, dynProfClient->cliStarted_);
}

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfClient_RunSetSendTimeOutFail)
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

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfClient_DynProfCliInitProcFunc)
{
    SHARED_PTR_ALIA<DynProfClient> dynProfClient;
    dynProfClient = std::make_shared<DynProfClient>();
    dynProfClient->DynProfCliInitProcFunc();
    bool ret = (dynProfClient->procFuncMap_[DynProfCliCmd::DYN_PROF_CLI_CMD_START] != nullptr) ? true : false;

    EXPECT_EQ(ret, true);
}

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfClient_DynProfCliCreate)
{
    SHARED_PTR_ALIA<DynProfClient> dynProfClient;
    dynProfClient = std::make_shared<DynProfClient>();
    MOCKER(LocalSocket::Open)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, dynProfClient->DynProfCliCreate());

    MOCKER(LocalSocket::Connect)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, dynProfClient->DynProfCliCreate());

    MOCKER(LocalSocket::SetRecvTimeOut)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, dynProfClient->DynProfCliCreate());

    MOCKER(LocalSocket::SetSendTimeOut)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, dynProfClient->DynProfCliCreate());

    EXPECT_EQ(PROFILING_SUCCESS, dynProfClient->DynProfCliCreate());
}

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfClient_DynProfCliCreate_AppModeTimeOut)
{
    SHARED_PTR_ALIA<DynProfClient> dynProfClient = std::make_shared<DynProfClient>();
    DynProfCliMgr::instance()->SetAppMode();

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
        .will(returnValue(0));
    EXPECT_EQ(PROFILING_FAILED, dynProfClient->DynProfCliCreate());
}

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfClient_DynProfCliSendParams)
{
    SHARED_PTR_ALIA<DynProfClient> dynProfClient;
    dynProfClient = std::make_shared<DynProfClient>();
    EXPECT_EQ(PROFILING_FAILED, dynProfClient->DynProfCliSendParams());

    MOCKER(LocalSocket::Send, int(int, const void *, int, int))
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    DynProfMsg rsqMsgFail = { DynProfMsgType::DYN_PROF_PARAMS_RSQ, DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL };
    void *v = &rsqMsgFail;

    MOCKER(LocalSocket::Recv, int(int, void *, int, int))
        .stubs()
        .with(any(), outBoundP(v, sizeof(DynProfMsg)), any(), any())
        .will(returnValue(-1))
        .then(returnValue(sizeof(DynProfMsg)));
    EXPECT_EQ(PROFILING_FAILED, dynProfClient->DynProfCliSendParams());
    EXPECT_EQ(PROFILING_FAILED, dynProfClient->DynProfCliSendParams());
}

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfClient_DynProfCliSendCmd)
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

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfClient_DynProfCliProcStart)
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

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfClient_DynProfCliProcStop)
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

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfClient_DynProfCliProcQuit)
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

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfClient_DynProfCliHelpInfo)
{
    SHARED_PTR_ALIA<DynProfClient> dynProfClient;
    dynProfClient = std::make_shared<DynProfClient>();
    dynProfClient->cliStarted_ = true;
    dynProfClient->DynProfCliHelpInfo();
    EXPECT_EQ(dynProfClient->cliStarted_, true);
}

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfCliMgr_StartDynProfCli)
{
    std::string params;
    int ret = DynProfCliMgr::instance()->StartDynProfCli(params);
    EXPECT_EQ(PROFILING_FAILED, ret);

    params = "start";
    MOCKER_CPP(&DynProfClient::DynProfCliCreate).stubs().then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&DynProfClient::DynProfCliSendParams).stubs().then(returnValue(PROFILING_SUCCESS));
    MOCKER(mmCreateTaskWithThreadAttr).stubs().will(returnValue(EN_OK));
    ret = DynProfCliMgr::instance()->StartDynProfCli(params);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfCliMgr_StopDynProfCli)
{
    SHARED_PTR_ALIA<DynProfClient> dynProfClient;
    dynProfClient = std::make_shared<DynProfClient>();
    DynProfCliMgr::instance()->dynProfCli_ = dynProfClient;
    MOCKER(mmJoinTask).stubs().will(returnValue(EN_OK));
    DynProfCliMgr::instance()->StopDynProfCli();
    EXPECT_EQ(false, DynProfCliMgr::instance()->enabled_);
}

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfCliMgr_SetAppPid)
{
    int32_t pid = 10;
    DynProfCliMgr::instance()->SetKeyPid(pid);
    EXPECT_EQ(pid, DynProfCliMgr::instance()->keyPid_);
}

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfCliMgr_GetAppPid)
{
    EXPECT_EQ(0, DynProfCliMgr::instance()->GetKeyPid());
}

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfCliMgr_EnableDynProfCli)
{
    DynProfCliMgr::instance()->EnableDynProfCli();
    EXPECT_EQ(true, DynProfCliMgr::instance()->enabled_);
}

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfCliMgr_IsDynProfCliEnable)
{
    EXPECT_EQ(false, DynProfCliMgr::instance()->IsDynProfCliEnable());
    bool sw = true;
    DynProfCliMgr::instance()->enabled_ = true;
    EXPECT_EQ(sw, DynProfCliMgr::instance()->IsDynProfCliEnable());
}

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfCliMgr_GetDynProfEnv)
{
    DynProfCliMgr::instance()->enabled_ = true;
    EXPECT_EQ("PROFILING_MODE=dynamic", DynProfCliMgr::instance()->GetDynProfEnv());
    DynProfCliMgr::instance()->enabled_ = false;
    EXPECT_EQ("", DynProfCliMgr::instance()->GetDynProfEnv());
}

TEST_F(MSPROF_DYNAMIC_CLIENT_UTEST, DynProfClient_IsCliStarted)
{
    EXPECT_EQ(false, DynProfCliMgr::instance()->IsCliStarted());

    DynProfCliMgr::instance()->dynProfCli_ = std::make_shared<DynProfClient>();
    DynProfCliMgr::instance()->dynProfCli_->cliStarted_ = true;
    EXPECT_EQ(true, DynProfCliMgr::instance()->IsCliStarted());
}

// Unit Test For DynProfServer
class MSPROF_DYNAMIC_SERVER_UTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();

        DynProfMgr::instance()->isStarted_ = false;
        DynProfMgr::instance()->dynProfSrv_ = nullptr;
    }
};

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfServer_Start)
{
    SHARED_PTR_ALIA<DynProfServer> dynProfServer;
    dynProfServer = std::make_shared<DynProfServer>();
    dynProfServer->srvStarted_ = true;
    int ret = dynProfServer->Start();
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    dynProfServer->srvStarted_ = false;
    MOCKER_CPP(&DynProfServer::DynProfSrvCreate)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_SUCCESS));
    ret = dynProfServer->Start();
    EXPECT_EQ(PROFILING_FAILED, ret);

    MOCKER(mmCreateTaskWithThreadAttr).stubs().will(returnValue(EN_ERROR)).then(returnValue(EN_OK));
    MOCKER(mmJoinTask).stubs().will(returnValue(EN_OK));
    ret = dynProfServer->Start();
    EXPECT_EQ(PROFILING_FAILED, ret);
    ret = dynProfServer->Start();
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfServer_Stop)
{
    SHARED_PTR_ALIA<DynProfServer> dynProfServer = std::make_shared<DynProfServer>();
    MOCKER(mmJoinTask).stubs().will(returnValue(EN_OK));
    dynProfServer->srvStarted_ = true;
    EXPECT_EQ(PROFILING_SUCCESS, dynProfServer->Stop());
    EXPECT_EQ(false, dynProfServer->srvStarted_);
}

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfServer_Run)
{
    struct error_message::Context errorContext;
    SHARED_PTR_ALIA<DynProfServer> dynProfServer = std::make_shared<DynProfServer>();
    dynProfServer->DynProfSrvInitProcFunc();
    dynProfServer->srvStarted_ = true;

    MOCKER_CPP(&LocalSocket::Accept)
        .stubs()
        .will(returnValue(SOCKET_ERR_EAGAIN))
        .then(returnValue(PROFILING_FAILED))
        .then(returnValue(1));
    MOCKER_CPP(&LocalSocket::SetRecvTimeOut)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&DynProfServer::DynProfSrvRecvParams)
        .stubs()
        .will(returnValue(SOCKET_ERR_EAGAIN))
        .then(returnValue(PROFILING_FAILED));
    MOCKER_CPP(&LocalSocket::Close)
        .stubs()
        .with(outBound(-1))
        .will(ignoreReturnValue());

    dynProfServer->Run(errorContext);
    dynProfServer->Run(errorContext);
    dynProfServer->Run(errorContext);
    EXPECT_EQ(dynProfServer->cliSockFd_, -1);
}

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfServer_DynProfSrvInitProcFunc)
{
    SHARED_PTR_ALIA<DynProfServer> dynProfServer;
    dynProfServer = std::make_shared<DynProfServer>();
    dynProfServer->DynProfSrvInitProcFunc();
    bool ret = (dynProfServer->procFuncMap_[DynProfMsgType::DYN_PROF_START_REQ] != nullptr) ? true : false;
    EXPECT_EQ(ret, true);
}

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfServer_DynProfSrvCreate)
{
    SHARED_PTR_ALIA<DynProfServer> dynProfServer = std::make_shared<DynProfServer>();
    MOCKER(Utils::HandleEnvString)
        .stubs()
        .will(returnValue(std::string("")));
    MOCKER(Utils::GetPid)
        .stubs()
        .will(returnValue(321));
    MOCKER_CPP(&LocalSocket::Create)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(1));
    int ret = dynProfServer->DynProfSrvCreate();
    EXPECT_EQ(PROFILING_FAILED, ret);

    MOCKER_CPP(&LocalSocket::SetRecvTimeOut)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER(LocalSocket::Close)
        .stubs()
        .will(ignoreReturnValue());
    ret = dynProfServer->DynProfSrvCreate();
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = dynProfServer->DynProfSrvCreate();
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfServer_DynProfSrvCreate_appMode)
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

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfServer_DynProfSrvRecvParams)
{
    SHARED_PTR_ALIA<DynProfServer> dynProfServer;
    dynProfServer = std::make_shared<DynProfServer>();

    MOCKER(LocalSocket::Recv, int(int, void *, int, int))
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(SOCKET_ERR_EAGAIN))
        .then(returnValue(4100));
    int ret = dynProfServer->DynProfSrvRecvParams();
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = dynProfServer->DynProfSrvRecvParams();
    EXPECT_EQ(SOCKET_ERR_EAGAIN, ret);

    ret = dynProfServer->DynProfSrvRecvParams();
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfServer_DynProfSrvProc)
{
    SHARED_PTR_ALIA<DynProfServer> dynProfServer = std::make_shared<DynProfServer>();
    dynProfServer->srvStarted_ = true;
    dynProfServer->DynProfSrvInitProcFunc();

    MOCKER(LocalSocket::SetRecvTimeOut)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    DynProfMsg rsqMsgFail = { DynProfMsgType::DYN_PROF_QUIT_REQ, DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL };
    void *v = &rsqMsgFail;

    MOCKER(LocalSocket::Recv, int(int, void *, int, int))
        .stubs()
        .with(any(), outBoundP(v, sizeof(DynProfMsg)), any(), any())
        .will(returnValue(SOCKET_ERR_EAGAIN))
        .then(returnValue(-1))
        .then(returnValue(sizeof(DynProfMsg)));

    MOCKER(&DynProfServer::DynProfSrvProcQuit)
        .stubs()
        .will(ignoreReturnValue());
    dynProfServer->DynProfSrvProc();
    dynProfServer->DynProfSrvProc();
    dynProfServer->DynProfSrvProc();
    EXPECT_EQ(true, dynProfServer->srvStarted_);
}

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfServer_DynProfSrvProcStart)
{
    MOCKER(&Msprofiler::Api::ProfAclMgr::StartUploaderDumper)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    SHARED_PTR_ALIA<DynProfServer> dynProfServer;
    dynProfServer = std::make_shared<DynProfServer>();
    dynProfServer->profStarted_ = true;
    dynProfServer->DynProfSrvProcStart();

    dynProfServer->profStarted_ = false;
    dynProfServer->DynProfSrvProcStart();

    DynProfDeviceInfo data;
    data.chipId = 0;
    data.devId = 0;
    data.isOpenDevice = true;
    dynProfServer->devicesInfo_.insert(std::pair<uint32_t, DynProfDeviceInfo>(data.devId, data));
    MOCKER(&Msprofiler::Api::ProfAclMgr::MsprofInitAclEnv)
        .stubs()
        .will(returnValue(6))
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

    MOCKER(&Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice).stubs().will(returnValue(5)).then(returnValue(0));
    dynProfServer->DynProfSrvProcStart();
    EXPECT_EQ(false, dynProfServer->profStarted_);
    dynProfServer->DynProfSrvProcStart();
    EXPECT_EQ(true, dynProfServer->profStarted_);
}

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfServer_DynProfSrvProcStop)
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

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfServer_DynProfSrvProcQuit)
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

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfMgr_StartDynProf)
{
    DynProfMgr::instance()->isStarted_ = true;
    EXPECT_EQ(PROFILING_SUCCESS, DynProfMgr::instance()->StartDynProf());

    DynProfMgr::instance()->isStarted_ = false;
    EXPECT_EQ(PROFILING_FAILED, DynProfMgr::instance()->StartDynProf());

    MOCKER(mmCreateTaskWithThreadAttr).stubs().will(returnValue(EN_ERROR)).then(returnValue(EN_OK));
    MOCKER(mmJoinTask).stubs().will(returnValue(EN_OK));
    MOCKER(Utils::HandleEnvString)
        .stubs()
        .will(returnValue(std::string("dynamic")))
        .then(returnValue(std::string("")))
        .then(returnValue(std::string("dynamic")))
        .then(returnValue(std::string("")));
    EXPECT_EQ(PROFILING_FAILED, DynProfMgr::instance()->StartDynProf());

    DynProfMgr::instance()->isStarted_ = false;
    EXPECT_EQ(PROFILING_SUCCESS, DynProfMgr::instance()->StartDynProf());
    EXPECT_EQ(true, DynProfMgr::instance()->IsDynStarted());
    DynProfMgr::instance()->StopDynProf();
}

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfMgr_StopDynProf)
{
    DynProfMgr::instance()->isStarted_ = false;
    DynProfMgr::instance()->StopDynProf();

    DynProfMgr::instance()->isStarted_ = true;
    DynProfMgr::instance()->dynProfSrv_ = std::make_shared<DynProfServer>();
    DynProfMgr::instance()->dynProfSrv_->srvStarted_ = true;
    DynProfMgr::instance()->StopDynProf();
    EXPECT_EQ(false, DynProfMgr::instance()->dynProfSrv_->srvStarted_);
}

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfMgr_StartDynThread)
{
    MOCKER(mmCreateTaskWithThreadAttr).stubs().will(returnValue(EN_ERROR)).then(returnValue(EN_OK));
    MOCKER(mmJoinTask).stubs().will(returnValue(EN_OK));
    MOCKER(Utils::HandleEnvString)
        .stubs()
        .will(returnValue(std::string("delay_or_duration")));
    MOCKER_CPP(&DynProfThread::GetDelayAndDurationTime)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, DynProfMgr::instance()->StartDynProf());

    DynProfMgr::instance()->isStarted_ = false;
    EXPECT_EQ(PROFILING_SUCCESS, DynProfMgr::instance()->StartDynProf());
    EXPECT_EQ(true, DynProfMgr::instance()->IsDynStarted());
    DynProfMgr::instance()->StopDynProf();
}

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfMgr_RunDynThreadTask)
{
    MOCKER(mmCreateTaskWithThreadAttr).stubs().will(returnValue(EN_OK));
    MOCKER(mmJoinTask).stubs().will(returnValue(EN_OK));
    MOCKER(&Msprofiler::Api::ProfAclMgr::MsprofInitAclEnv).stubs().will(returnValue(0));
    MOCKER(&Msprofiler::Api::ProfAclMgr::Init).stubs().will(returnValue(PROFILING_SUCCESS));
    MOCKER(&Msprofiler::Api::ProfAclMgr::MsprofFinalizeHandle).stubs().will(returnValue(0));
    DynProfMgr::instance()->dynProfThread_ = std::make_shared<DynProfThread>();
    DynProfMgr::instance()->dynProfThread_->durationSet_ = true;
    DynProfMgr::instance()->dynProfThread_->started_ = true;
    DynProfMgr::instance()->dynProfThread_->Start();
    DynProfMgr::instance()->dynProfThread_->Stop();
    DynProfMgr::instance()->dynProfThread_->StartProfTask();
    EXPECT_EQ(true, DynProfMgr::instance()->dynProfThread_->profStarted_);
    DynProfMgr::instance()->dynProfThread_->StopProfTask();
    EXPECT_EQ(false, DynProfMgr::instance()->dynProfThread_->profStarted_);
}


TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfMgr_ServerSetDeviceInfo)
{
    DynProfMgr::instance()->isStarted_ = true;
    DynProfMgr::instance()->dynProfSrv_ = std::make_shared<DynProfServer>();
    DynProfMgr::instance()->dynProfSrv_->srvStarted_ = true;
    DynProfMgr::instance()->SaveDevicesInfo(1, 0, true);
    DynProfMgr::instance()->SaveDevicesInfo(1, 1, true);
    EXPECT_EQ(2, DynProfMgr::instance()->dynProfSrv_->devicesInfo_.size());
    DynProfMgr::instance()->SaveDevicesInfo(1, 1, false);
    EXPECT_EQ(1, DynProfMgr::instance()->dynProfSrv_->devicesInfo_.size());
    DynProfMgr::instance()->StopDynProf();
}

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfMgr_Multi_ServerSetDeviceInfo)
{
    DynProfMgr::instance()->isStarted_ = true;
    DynProfMgr::instance()->dynProfSrv_ = std::make_shared<DynProfServer>();
    DynProfMgr::instance()->dynProfSrv_->srvStarted_ = true;

    std::vector<std::thread> th;
    for (int i = 0; i < 10; i++) {
        th.push_back(std::thread([this]() -> void {
            DynProfMgr::instance()->SaveDevicesInfo(1, 0, true);
            DynProfMgr::instance()->SaveDevicesInfo(1, 1, true);
            DynProfMgr::instance()->SaveDevicesInfo(1, 2, true);
            DynProfMgr::instance()->SaveDevicesInfo(1, 3, true);
            DynProfMgr::instance()->SaveDevicesInfo(1, 4, true);
            DynProfMgr::instance()->SaveDevicesInfo(1, 5, true);
            DynProfMgr::instance()->SaveDevicesInfo(1, 6, true);
            DynProfMgr::instance()->SaveDevicesInfo(1, 7, true);
        }));
    }
    for_each(th.begin(), th.end(), std::mem_fn(&std::thread::join));
    EXPECT_EQ(8, DynProfMgr::instance()->dynProfSrv_->devicesInfo_.size());
    DynProfMgr::instance()->StopDynProf();
}

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfMgr_ThreadSetDeviceInfo)
{
    DynProfMgr::instance()->isStarted_ = true;
    DynProfMgr::instance()->dynProfThread_ = std::make_shared<DynProfThread>();
    DynProfMgr::instance()->SaveDevicesInfo(1, 0, true);
    DynProfMgr::instance()->SaveDevicesInfo(1, 1, true);
    EXPECT_EQ(2, DynProfMgr::instance()->dynProfThread_->devicesInfo_.size());
    DynProfMgr::instance()->SaveDevicesInfo(1, 1, false);
    EXPECT_EQ(1, DynProfMgr::instance()->dynProfThread_->devicesInfo_.size());
    DynProfMgr::instance()->StopDynProf();
}

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfMgr_Multi_ThreadSetDeviceInfo)
{
    DynProfMgr::instance()->isStarted_ = true;
    DynProfMgr::instance()->dynProfThread_ = std::make_shared<DynProfThread>();

    std::vector<std::thread> th;
    for (int i = 0; i < 10; i++) {
        th.push_back(std::thread([this]() -> void {
            DynProfMgr::instance()->SaveDevicesInfo(1, 0, true);
            DynProfMgr::instance()->SaveDevicesInfo(1, 1, true);
            DynProfMgr::instance()->SaveDevicesInfo(1, 2, true);
            DynProfMgr::instance()->SaveDevicesInfo(1, 3, true);
            DynProfMgr::instance()->SaveDevicesInfo(1, 4, true);
            DynProfMgr::instance()->SaveDevicesInfo(1, 5, true);
            DynProfMgr::instance()->SaveDevicesInfo(1, 6, true);
            DynProfMgr::instance()->SaveDevicesInfo(1, 7, true);
        }));
    }
    for_each(th.begin(), th.end(), std::mem_fn(&std::thread::join));
    EXPECT_EQ(8, DynProfMgr::instance()->dynProfThread_->devicesInfo_.size());
    DynProfMgr::instance()->StopDynProf();
}

TEST_F(MSPROF_DYNAMIC_SERVER_UTEST, DynProfMgr_IsProfStarted)
{
    EXPECT_EQ(false, DynProfMgr::instance()->IsProfStarted());
    DynProfMgr::instance()->dynProfSrv_ = std::make_shared<DynProfServer>();
    DynProfMgr::instance()->dynProfSrv_->profStarted_ = true;
    EXPECT_EQ(true, DynProfMgr::instance()->IsProfStarted());
}

class DYNAMIC_THREAD_UTEST : public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
    }
};

TEST_F(DYNAMIC_THREAD_UTEST, GetDelayAndDurationTime)
{
    SHARED_PTR_ALIA<DynProfThread> dynProfThread_ = std::make_shared<DynProfThread>();
    std::string emptyParams;
    std::string invalidParams = "xxxxxx";
    std::string validParamsWithDelayOrDurationUnset = "{\"delayTime\":\"\", \"durationTime\":\"\"}";
    std::string validParamsWithDelaySetInvalidValue = "{\"delayTime\":\"xx\", \"durationTime\":\"\"}";
    std::string validParamsWithDurationSetInvalidValue = "{\"delayTime\":\"\", \"durationTime\":\"xx\"}";
    std::string validParamsWithDelaySetValidValue = "{\"delayTime\":\"10\", \"durationTime\":\"\"}";
    std::string validParamsWithDurationSetValidValue = "{\"delayTime\":\"\", \"durationTime\":\"10\"}";
    std::string validParamsWithDelayAndDurationSetValidValue = "{\"delayTime\":\"20\", \"durationTime\":\"20\"}";
    MOCKER_CPP(&Utils::HandleEnvString)
        .stubs()
        .will(returnValue(emptyParams))
        .then(returnValue(invalidParams))
        .then(returnValue(validParamsWithDelayOrDurationUnset))
        .then(returnValue(validParamsWithDelaySetInvalidValue))
        .then(returnValue(validParamsWithDurationSetInvalidValue))
        .then(returnValue(validParamsWithDelaySetValidValue))
        .then(returnValue(validParamsWithDurationSetValidValue))
        .then(returnValue(validParamsWithDelayAndDurationSetValidValue));
    EXPECT_EQ(PROFILING_FAILED, dynProfThread_->GetDelayAndDurationTime());
    EXPECT_EQ(PROFILING_FAILED, dynProfThread_->GetDelayAndDurationTime());
    EXPECT_EQ(PROFILING_FAILED, dynProfThread_->GetDelayAndDurationTime());
    EXPECT_EQ(PROFILING_FAILED, dynProfThread_->GetDelayAndDurationTime());
    EXPECT_EQ(PROFILING_FAILED, dynProfThread_->GetDelayAndDurationTime());
    EXPECT_EQ(PROFILING_SUCCESS, dynProfThread_->GetDelayAndDurationTime());
    EXPECT_EQ(10, dynProfThread_->delayTime_); // 10 delay time from env
    EXPECT_EQ(PROFILING_SUCCESS, dynProfThread_->GetDelayAndDurationTime());
    EXPECT_EQ(10, dynProfThread_->durationTime_); // 10 duration time from env
    EXPECT_EQ(PROFILING_SUCCESS, dynProfThread_->GetDelayAndDurationTime());
    EXPECT_EQ(20, dynProfThread_->delayTime_); // 20 delay time from env
    EXPECT_EQ(20, dynProfThread_->durationTime_); // 20 duration time from env
}

TEST_F(DYNAMIC_THREAD_UTEST, DynProfThread_StopAfterDelay)
{
    SHARED_PTR_ALIA<DynProfThread> dynProfThread_ = std::make_shared<DynProfThread>();;
    std::string Params = "{\"delayTime\":\"1\"}";
    MOCKER_CPP(&Utils::HandleEnvString)
        .stubs()
        .will(returnValue(Params));
    dynProfThread_->Start(); // thread sleep 1s, then return
 
    // sleep 2s
    std::chrono::seconds sleepTime(2); // 2 sleep 2s as real task time
    std::this_thread::sleep_for(sleepTime);
    EXPECT_EQ(PROFILING_SUCCESS, dynProfThread_->Stop());
}

TEST_F(DYNAMIC_THREAD_UTEST, DynProfThread_StopBeforeDelay)
{
    SHARED_PTR_ALIA<DynProfThread> dynProfThread_ = std::make_shared<DynProfThread>();;
    std::string Params = "{\"delayTime\":\"10\"}";
    MOCKER_CPP(&Utils::HandleEnvString)
        .stubs()
        .will(returnValue(Params));
    dynProfThread_->Start(); // thread sleep 1s, then return
 
    // sleep 2s
    std::chrono::seconds sleepTime(2); // 2 sleep 2s as real task time
    std::this_thread::sleep_for(sleepTime);
    EXPECT_EQ(PROFILING_SUCCESS, dynProfThread_->Stop());
}

TEST_F(DYNAMIC_THREAD_UTEST, DynProfThread_StopBeforeDuration)
{
    SHARED_PTR_ALIA<DynProfThread> dynProfThread_ = std::make_shared<DynProfThread>();;
    std::string Params = "{\"durationTime\":\"10\"}";
    MOCKER_CPP(&Utils::HandleEnvString)
        .stubs()
        .will(returnValue(Params));
    dynProfThread_->Start(); // thread sleep 1s, then return
 
    // sleep 2s
    std::chrono::seconds sleepTime(2); // 2 sleep 2s as real task time
    std::this_thread::sleep_for(sleepTime);
    EXPECT_EQ(PROFILING_SUCCESS, dynProfThread_->Stop());
}

TEST_F(DYNAMIC_THREAD_UTEST, DynProfThread_StopAfterDuration)
{
    SHARED_PTR_ALIA<DynProfThread> dynProfThread_ = std::make_shared<DynProfThread>();;
    std::string Params = "{\"durationTime\":\"1\"}";
    MOCKER_CPP(&Utils::HandleEnvString)
        .stubs()
        .will(returnValue(Params));
    dynProfThread_->Start(); // thread sleep 1s, then return
 
    // sleep 2s
    std::chrono::seconds sleepTime(2); // 2 sleep 2s as real task time
    std::this_thread::sleep_for(sleepTime);
    EXPECT_EQ(PROFILING_SUCCESS, dynProfThread_->Stop());
}

TEST_F(DYNAMIC_THREAD_UTEST, DynProfThread_StopBetweenDelayAndDuration)
{
    SHARED_PTR_ALIA<DynProfThread> dynProfThread_ = std::make_shared<DynProfThread>();;
    std::string Params = "{\"delayTime\":\"1\", \"durationTime\":\"10\"}";
    MOCKER_CPP(&Utils::HandleEnvString)
        .stubs()
        .will(returnValue(Params));
    dynProfThread_->Start(); // thread sleep 1s, then return

    // sleep 2s
    std::chrono::seconds sleepTime(2); // 2 sleep 2s as real task time
    std::this_thread::sleep_for(sleepTime);
    EXPECT_EQ(PROFILING_SUCCESS, dynProfThread_->Stop());
}

class DYNAMIC_MGR_UTEST : public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
    }
};

TEST_F(DYNAMIC_MGR_UTEST, StartDynProf_ReturnFailed_WithInvalidProfilingMode)
{
    GlobalMockObject::verify();
    auto dynProfMgr = DynProfMgr::instance();
    std::string invalidMode;
    MOCKER_CPP(&Utils::HandleEnvString)
        .stubs()
        .will(returnValue(invalidMode));
    EXPECT_EQ(PROFILING_FAILED, dynProfMgr->StartDynProf());
}

TEST_F(DYNAMIC_MGR_UTEST, StartDynProfSrv_WithDynamicProfilingMode)
{
    GlobalMockObject::verify();
    auto dynProfMgr = DynProfMgr::instance();
    MOCKER_CPP(&Utils::HandleEnvString)
        .stubs()
        .will(returnValue(DYNAMIC_PROFILING_VALUE));
    MOCKER_CPP(&DynProfServer::DynProfSrvCreate)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, dynProfMgr->StartDynProf());
    EXPECT_EQ(false, dynProfMgr->IsDynStarted());
    dynProfMgr->StopDynProf(); // start failed, just return when StopDynProf is called
    
    EXPECT_EQ(PROFILING_SUCCESS, dynProfMgr->StartDynProf());
    EXPECT_EQ(true, dynProfMgr->IsDynStarted());
    // repeat start
    EXPECT_EQ(PROFILING_SUCCESS, dynProfMgr->StartDynProf());
    dynProfMgr->StopDynProf();
    EXPECT_EQ(false, dynProfMgr->IsDynStarted()); // success to stop when StopDynProf is called after start succeed
}

TEST_F(DYNAMIC_MGR_UTEST, StartDynProfThread_WithDelayOrDurationProfilingMode)
{
    GlobalMockObject::verify();
    auto dynProfMgr = DynProfMgr::instance();
    MOCKER_CPP(&Utils::HandleEnvString)
        .stubs()
        .will(returnValue(DELAY_DURARION_PROFILING_VALUE));
    MOCKER_CPP(&DynProfThread::GetDelayAndDurationTime)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_FAILED, dynProfMgr->StartDynProf());
    EXPECT_EQ(PROFILING_SUCCESS, dynProfMgr->StartDynProf());
    // repeat start
    EXPECT_EQ(PROFILING_SUCCESS, dynProfMgr->StartDynProf());
    EXPECT_EQ(true, dynProfMgr->IsDynStarted());
    dynProfMgr->SaveDevicesInfo(0, 0, true);
    dynProfMgr->StopDynProf();
    EXPECT_EQ(false, dynProfMgr->IsDynStarted()); // success to stop when StopDynProf is called after start succeed
}