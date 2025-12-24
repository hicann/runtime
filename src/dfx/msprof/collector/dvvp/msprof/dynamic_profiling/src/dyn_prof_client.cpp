/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dyn_prof_client.h"
#include "cmd_log/cmd_log.h"
#include "config/config.h"
#include "errno/error_code.h"
#include "socket/local_socket.h"
#include "msprof_dlog.h"
#include "utils/utils.h"

namespace Collector {
namespace Dvvp {
namespace DynProf {
const std::map<std::string, DynProfCliCmd> DYN_PROF_CLI_CMD_MAP = {
    { "start", DynProfCliCmd::DYN_PROF_CLI_CMD_START }, { "stop", DynProfCliCmd::DYN_PROF_CLI_CMD_STOP },
    { "quit", DynProfCliCmd::DYN_PROF_CLI_CMD_QUIT },   { "q", DynProfCliCmd::DYN_PROF_CLI_CMD_QUIT },
    { "help", DynProfCliCmd::DYN_PROF_CLI_CMD_HELP },   { "h", DynProfCliCmd::DYN_PROF_CLI_CMD_HELP }
};

using namespace analysis::dvvp::common::cmdlog;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::socket;
using namespace analysis::dvvp::common::thread;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::MsprofErrMgr;

void DynProfClient::SetParams(const std::string &params)
{
    if (params.size() >= DYN_PROF_PARAMS_MAX_LEN || params.empty()) {
        MSPROF_LOGE("dynamic profiling param length error, len=%zu bytes.", params.size());
        return;
    }
    MSPROF_LOGD("set params, size:%zu", params.size());
    dynProfParams_ = params;
}

int32_t DynProfClient::Start()
{
    MSPROF_LOGI("dynamic profiling begin to init client.");
    if (cliStarted_) {
        MSPROF_LOGW("dynamic profiling client thread has been started.");
        return PROFILING_SUCCESS;
    }
    if (dynProfParams_.empty()) {
        MSPROF_LOGE("must set params first");
        return PROFILING_FAILED;
    }
    DynProfCliInitProcFunc();
    if (DynProfCliCreate() != PROFILING_SUCCESS) {
        MSPROF_LOGE("dynamic profiling create client socket failed.");
        return PROFILING_FAILED;
    }
    if (DynProfCliSendParams() != PROFILING_SUCCESS) {
        MSPROF_LOGE("dynamic profiling create client socket failed.");
        return PROFILING_FAILED;
    }
    cliStarted_ = true;
    Thread::SetThreadName(MSVP_DYN_PROF_CLIENT_THREAD_NAME);
    if (Thread::Start() != PROFILING_SUCCESS) {
        (void)Stop();
        MSPROF_LOGE("dynamic profiling start thread failed.");
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("dynamic profiling init client success.");
    return PROFILING_SUCCESS;
}

int32_t DynProfClient::Stop()
{
    MSPROF_LOGI("dynamic profiling stop client.");
    if (cliStarted_) {
        cliStarted_ = false;
        LocalSocket::Close(cliSockFd_);
        return Thread::Stop();
    }
    return PROFILING_SUCCESS;
}

bool DynProfClient::IsCliStarted() const
{
    return cliStarted_;
}

void DynProfClient::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);

    if (LocalSocket::SetRecvTimeOut(cliSockFd_, DYN_PROF_PROC_TIME_OUT, 0) == PROFILING_FAILED ||
        LocalSocket::SetSendTimeOut(cliSockFd_, DYN_PROF_PROC_TIME_OUT, 0) == PROFILING_FAILED) {
        (void)Stop();
        MSPROF_LOGE("set client recv time out failed.");
        return;
    }

    while (cliStarted_) {
        std::cout << "(msprof) ";
        std::string inputCmd;
        (void)getline(std::cin, inputCmd);
        inputCmd = Utils::Trim(inputCmd);
        if (inputCmd.empty() || !cliStarted_) {
            continue;
        }
        auto it = DYN_PROF_CLI_CMD_MAP.find(inputCmd);
        if (it == DYN_PROF_CLI_CMD_MAP.cend()) {
            CmdLog::CmdLogNoLevel("invalid option -- '%s'\n", inputCmd.c_str());
            DynProfCliHelpInfo();
            continue;
        }
        procFuncMap_[it->second]();
    }
}

void DynProfClient::DynProfCliInitProcFunc()
{
    procFuncMap_[DynProfCliCmd::DYN_PROF_CLI_CMD_START] = std::bind(&DynProfClient::DynProfCliProcStart, this);
    procFuncMap_[DynProfCliCmd::DYN_PROF_CLI_CMD_STOP] = std::bind(&DynProfClient::DynProfCliProcStop, this);
    procFuncMap_[DynProfCliCmd::DYN_PROF_CLI_CMD_QUIT] = std::bind(&DynProfClient::DynProfCliProcQuit, this);
    procFuncMap_[DynProfCliCmd::DYN_PROF_CLI_CMD_HELP] = std::bind(&DynProfClient::DynProfCliHelpInfo, this);
}

int32_t DynProfClient::DynProfCliCreate()
{
    cliSockFd_ = LocalSocket::Open();
    if (cliSockFd_ == PROFILING_FAILED) {
        MSPROF_LOGE("open client socket failed");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("open client socket: %d", cliSockFd_);

    auto srvSockDomain = DYN_PROF_SOCK_UNIX_DOMAIN + std::to_string(DynProfCliMgr::instance()->GetKeyPid());
    // app 场景下, 每秒重试一次直到超时或者连接上
    const int32_t sleepIntervalUs = 1000000;
    const uint32_t timeout = 60;
    if (DynProfCliMgr::instance()->IsAppMode()) {
        uint32_t tryTimes = 0;
        while (true) {
            auto ret = LocalSocket::Connect(cliSockFd_, srvSockDomain);
            if (ret == PROFILING_SUCCESS) {
                break;
            }
            if (tryTimes >= timeout) {
                LocalSocket::Close(cliSockFd_);
                CmdLog::CmdErrorLog("cannot connect to server, timeout");
                MSPROF_LOGE("cannot connect to server, timeout");
                return PROFILING_FAILED;
            }
            (void)Utils::UsleepInterupt(sleepIntervalUs);
            tryTimes++;
        }
    } else {
        if (LocalSocket::Connect(cliSockFd_, srvSockDomain) == PROFILING_FAILED) {
            LocalSocket::Close(cliSockFd_);
            CmdLog::CmdErrorLog("cannot connect to server, maybe server is closed");
            MSPROF_LOGE("cannot connect to server, maybe server is closed");
            return PROFILING_FAILED;
        }
    }
    if (LocalSocket::SetRecvTimeOut(cliSockFd_, 1, 0) == PROFILING_FAILED) {
        LocalSocket::Close(cliSockFd_);
        MSPROF_LOGE("set client recv time out failed.");
        return PROFILING_FAILED;
    }
    if (LocalSocket::SetSendTimeOut(cliSockFd_, 1, 0) == PROFILING_FAILED) {
        LocalSocket::Close(cliSockFd_);
        MSPROF_LOGE("set client send time out failed.");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("connect to server, key:%s", srvSockDomain.c_str());
    return PROFILING_SUCCESS;
}

int32_t DynProfClient::DynProfCliSendParams() const
{
    DynProfParams params;
    params.dataLen = dynProfParams_.size();
    (void)memcpy_s(params.data, sizeof(params.data), dynProfParams_.c_str(), dynProfParams_.size());

    if (LocalSocket::Send(cliSockFd_, &params, sizeof(params), 0) == PROFILING_FAILED) {
        MSPROF_LOGE("send params failed");
        return PROFILING_FAILED;
    }
    // 接收回执
    DynProfMsg rsqMsg;
    auto ret = LocalSocket::Recv(cliSockFd_, &rsqMsg, sizeof(rsqMsg), 0);
    if (ret == SOCKET_ERR_EAGAIN) {
        CmdLog::CmdErrorLog("recv parmas timeout, server has been connected to another client.");
        MSPROF_LOGE("recv parmas timeout, server has been connected to another client.");
        return PROFILING_FAILED;
    } else if (ret != sizeof(rsqMsg)) {
        MSPROF_LOGE("recv parmas rsq failed.");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("recv params rsq: %d,%d", rsqMsg.msgType, rsqMsg.statusCode);
    if (rsqMsg.msgType != DynProfMsgType::DYN_PROF_PARAMS_RSQ ||
        rsqMsg.statusCode != DynProfMsgRsqCode::DYN_PROF_RSQ_SUCCESS) {
        MSPROF_LOGE("server recv params rsq error");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

DynProfMsgRsqCode DynProfClient::DynProfCliSendCmd(DynProfMsgType req) const
{
    DynProfMsg reqMsg;
    reqMsg.msgType = req;
    if (LocalSocket::Send(cliSockFd_, &reqMsg, sizeof(reqMsg), 0) == PROFILING_FAILED) {
        MSPROF_LOGE("send req: %d failed", req);
        return DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL;
    }
    MSPROF_LOGI("client send req: %d", req);
    // 接收回执
    DynProfMsg rsqMsg;
    if (LocalSocket::Recv(cliSockFd_, &(rsqMsg), sizeof(rsqMsg), 0) != sizeof(rsqMsg)) {
        MSPROF_LOGE("recv server rsq failed");
        return DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL;
    }
    MSPROF_LOGI("client recv rsq: %d(%d)", rsqMsg.msgType, rsqMsg.statusCode);
    // rsq在req后
    if (static_cast<int32_t>(rsqMsg.msgType) != static_cast<int32_t>(req) + 1) {
        MSPROF_LOGE("req type:%d and rsq type:%d is not matched", req, rsqMsg.msgType);
        return DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL;
    }
    return rsqMsg.statusCode;
}

void DynProfClient::DynProfCliProcStart() const
{
    MSPROF_LOGI("dynamic profiling start message proc.");
    auto rsq = DynProfCliSendCmd(DynProfMsgType::DYN_PROF_START_REQ);
    switch (rsq) {
        case DynProfMsgRsqCode::DYN_PROF_RSQ_SUCCESS:
            CmdLog::CmdLogNoLevel("dynamic profiling start success......");
            MSPROF_LOGI("dynamic profiling start success");
            break;
        case DynProfMsgRsqCode::DYN_PROF_RSQ_ALREADY_START:
            CmdLog::CmdWarningLog("dynamic profiling already started......");
            MSPROF_LOGW("dynamic profiling already started");
            break;
        case DynProfMsgRsqCode::DYN_PROF_RSQ_NOT_SET_DEVICE:
            CmdLog::CmdWarningLog("dynamic profiling device has not been set up......");
            MSPROF_LOGW("dynamic profiling device has not been set up");
            break;
        case DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL:
        default:
            CmdLog::CmdErrorLog("dynamic profiling start failed......");
            MSPROF_LOGE("dynamic profiling start failed");
            DynProfCliMgr::instance()->StopDynProfCli();
            break;
    }
}

void DynProfClient::DynProfCliProcStop() const
{
    MSPROF_LOGI("dynamic profiling stop message proc.");
    auto rsq = DynProfCliSendCmd(DynProfMsgType::DYN_PROF_STOP_REQ);
    switch (rsq) {
        case DynProfMsgRsqCode::DYN_PROF_RSQ_SUCCESS:
            CmdLog::CmdLogNoLevel("dynamic profiling stop success......");
            MSPROF_LOGI("dynamic profiling stop success");
            break;
        case DynProfMsgRsqCode::DYN_PROF_RSQ_NOT_START:
            CmdLog::CmdWarningLog("dynamic profiling has not started......");
            MSPROF_LOGW("dynamic profiling has not started");
            break;
        case DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL:
        default:
            CmdLog::CmdErrorLog("dynamic profiling stop failed......");
            MSPROF_LOGE("dynamic profiling stop failed");
            DynProfCliMgr::instance()->StopDynProfCli();
            break;
    }
}

void DynProfClient::DynProfCliProcQuit() const
{
    MSPROF_LOGI("dynamic profiling quit message proc.");
    auto rsq = DynProfCliSendCmd(DynProfMsgType::DYN_PROF_QUIT_REQ);
    switch (rsq) {
        case DynProfMsgRsqCode::DYN_PROF_RSQ_SUCCESS:
            CmdLog::CmdLogNoLevel("dynamic profiling quit success......");
            MSPROF_LOGI("dynamic profiling quit success");
            break;
        case DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL:
        default:
            CmdLog::CmdErrorLog("dynamic profiling stop failed......");
            MSPROF_LOGE("dynamic profiling stop failed");
            break;
    }
    DynProfCliMgr::instance()->StopDynProfCli();
}

void DynProfClient::DynProfCliHelpInfo() const
{
    CmdLog::CmdLogNoLevel("Usage:\n"
                          "\t start:                 Start a collection in interactive mode.\n"
                          "\t stop:                  Stop a collection that was started in interactive mode.\n"
                          "\t quit:                  Stop collection and quit interactive mode.");
}

DynProfCliMgr::~DynProfCliMgr()
{
}

int32_t DynProfCliMgr::StartDynProfCli(const std::string &params)
{
    MSVP_MAKE_SHARED0(dynProfCli_, DynProfClient, return PROFILING_FAILED);
    dynProfCli_->SetParams(params);
    if (dynProfCli_->Start() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Dynamic profiling start client thread fail.");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Dynamic profiling start client.");
    return PROFILING_SUCCESS;
}

void DynProfCliMgr::StopDynProfCli()
{
    if (dynProfCli_ != nullptr) {
        (void)dynProfCli_->Stop();
    }
    MSPROF_LOGI("Dynamic profiling stop client.");
}

void DynProfCliMgr::SetKeyPid(int32_t pid)
{
    MSPROF_LOGD("set pid: %d", pid);
    keyPid_ = pid;
}

int32_t DynProfCliMgr::GetKeyPid() const
{
    return keyPid_;
}

std::string DynProfCliMgr::GetKeyPidEnv() const
{
    return isAppMode_ ? DYNAMIC_PROFILING_KEY_PID_ENV + "=" + std::to_string(keyPid_) : "";
}

void DynProfCliMgr::EnableDynProfCli()
{
    enabled_ = true;
}

bool DynProfCliMgr::IsDynProfCliEnable() const
{
    return enabled_;
}

std::string DynProfCliMgr::GetDynProfEnv() const
{
    return enabled_ ? PROFILING_MODE_ENV + "=" + DYNAMIC_PROFILING_VALUE : "";
}

void DynProfCliMgr::SetAppMode()
{
    isAppMode_ = true;
}

bool DynProfCliMgr::IsAppMode() const
{
    return isAppMode_;
}

bool DynProfCliMgr::IsCliStarted() const
{
    if (dynProfCli_ != nullptr) {
        return dynProfCli_->IsCliStarted();
    }
    return false;
}

void DynProfCliMgr::WaitQuit()
{
    if (dynProfCli_ != nullptr) {
        dynProfCli_->Join();
    }
}
}  // namespace DynProf
}  // namespace Dvvp
}  // namespace Collector
