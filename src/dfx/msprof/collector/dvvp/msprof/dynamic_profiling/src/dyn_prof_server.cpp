/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dyn_prof_server.h"
#include "config/config.h"
#include "errno/error_code.h"
#include "socket/local_socket.h"
#include "msprof_dlog.h"
#include "utils/utils.h"
#include "prof_acl_mgr.h"
#include "msprofiler_impl.h"

namespace Collector {
namespace Dvvp {
namespace DynProf {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::socket;
using namespace analysis::dvvp::common::thread;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::MsprofErrMgr;

int32_t DynProfServer::Start()
{
    MSPROF_LOGI("Dynamic profiling begin to init server.");
    if (srvStarted_) {
        MSPROF_LOGW("Dynamic profiling server thread has been started.");
        return PROFILING_SUCCESS;
    }
    DynProfSrvInitProcFunc();
    if (DynProfSrvCreate() == PROFILING_FAILED) {
        MSPROF_LOGE("Dynamic profiling create server socket failed.");
        return PROFILING_FAILED;
    }
    srvStarted_ = true;
    Thread::SetThreadName(MSVP_DYN_PROF_SERVER_THREAD_NAME);
    if (Thread::Start() != PROFILING_SUCCESS) {
        (void)Stop();
        MSPROF_LOGE("Dynamic profiling start thread failed.");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Dynamic profiling init server success.");
    return PROFILING_SUCCESS;
}

int32_t DynProfServer::Stop()
{
    MSPROF_LOGI("Dynamic profiling stop server.");
    if (srvStarted_) {
        srvStarted_ = false;
        LocalSocket::Close(srvSockFd_);
        LocalSocket::Close(cliSockFd_);
        return Thread::Stop();
    }
    return PROFILING_SUCCESS;
}

bool DynProfServer::IsProfStarted()
{
    std::unique_lock<std::mutex> lk(devMtx_);
    return profStarted_;
}

void DynProfServer::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);

    while (srvStarted_) {
        cliSockFd_ = LocalSocket::Accept(srvSockFd_);
        if (cliSockFd_ == SOCKET_ERR_EAGAIN) {
            continue;
        }
        if (cliSockFd_ == PROFILING_FAILED) {
            MSPROF_LOGE("accept client failed.");
            break;
        }
        MSPROF_LOGI("accept client fd: %d", cliSockFd_);
        if (LocalSocket::SetRecvTimeOut(cliSockFd_, 1, 0) == PROFILING_FAILED) {
            LocalSocket::Close(cliSockFd_);
            MSPROF_LOGE("set client recv time out failed.");
            break;
        }
        const auto ret = DynProfSrvRecvParams();
        if (ret == SOCKET_ERR_EAGAIN) {
            continue;
        } else if (ret == PROFILING_FAILED) {
            LocalSocket::Close(cliSockFd_);
            break;
        }
        DynProfSrvProc();
    }
}

void DynProfServer::DynProfSrvInitProcFunc()
{
    procFuncMap_[DynProfMsgType::DYN_PROF_START_REQ] = std::bind(&DynProfServer::DynProfSrvProcStart, this);
    procFuncMap_[DynProfMsgType::DYN_PROF_STOP_REQ] = std::bind(&DynProfServer::DynProfSrvProcStop, this);
    procFuncMap_[DynProfMsgType::DYN_PROF_QUIT_REQ] = std::bind(&DynProfServer::DynProfSrvProcQuit, this);
}

int32_t DynProfServer::DynProfSrvCreate()
{
    std::string appModeKeyPid;
    MSPROF_GET_ENV(MM_ENV_DYNAMIC_PROFILING_KEY_PID, appModeKeyPid);
    std::string key;
    int32_t value = 0;
    if (!appModeKeyPid.empty() && !Utils::StrToInt32(value, appModeKeyPid)) {
        return PROFILING_FAILED;
    }
    if (!appModeKeyPid.empty() && value > 0) {
        // app mode --application
        key = DYN_PROF_SOCK_UNIX_DOMAIN + appModeKeyPid;
        srvSockFd_ = LocalSocket::Create(key);
        if (srvSockFd_ == SOCKET_ERR_EADDRINUSE) {
            MSPROF_LOGW("socket key %s already in use, try to create with app's pid.", key.c_str());
            key = DYN_PROF_SOCK_UNIX_DOMAIN + std::to_string(Utils::GetPid());
            srvSockFd_ = LocalSocket::Create(key);
        }
    } else {
        // attach mode --pid
        key = DYN_PROF_SOCK_UNIX_DOMAIN + std::to_string(Utils::GetPid());
        srvSockFd_ = LocalSocket::Create(key);
    }
    if (srvSockFd_ < 0) {
        MSPROF_LOGE("create server failed.");
        return PROFILING_FAILED;
    }
    if (LocalSocket::SetRecvTimeOut(srvSockFd_, 1, 0) == PROFILING_FAILED) {
        LocalSocket::Close(srvSockFd_);
        MSPROF_LOGE("set server recv time out failed.");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("create server, key:%s, fd: %d.", key.c_str(), srvSockFd_);
    return PROFILING_SUCCESS;
}

int32_t DynProfServer::DynProfSrvRecvParams()
{
    DynProfParams params;
    const auto recvLen = LocalSocket::Recv(cliSockFd_, &params, sizeof(params), 0);
    if (recvLen == SOCKET_ERR_EAGAIN) {
        MSPROF_LOGW("recv params timeout.");
        return SOCKET_ERR_EAGAIN;
    }
    if (recvLen != sizeof(params)) {
        MSPROF_LOGE("recv params incomplete, recvLen=%d bytes, needLen=%zu bytes", recvLen, sizeof(params));
        DynProfSrvRsqMsg(DynProfMsgType::DYN_PROF_PARAMS_RSQ, DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL);
        return PROFILING_FAILED;
    }
    dynProfParams_ = std::string(params.data, params.dataLen);
    MSPROF_LOGD("recv parmas, size:%zu", dynProfParams_.size());
    DynProfSrvRsqMsg(DynProfMsgType::DYN_PROF_PARAMS_RSQ, DynProfMsgRsqCode::DYN_PROF_RSQ_SUCCESS);
    return PROFILING_SUCCESS;
}

void DynProfServer::DynProfSrvRsqMsg(DynProfMsgType type, DynProfMsgRsqCode rsqCode) const
{
    DynProfMsg rsqMsg;
    rsqMsg.msgType = type;
    rsqMsg.statusCode = rsqCode;
    if (LocalSocket::Send(cliSockFd_, &rsqMsg, sizeof(rsqMsg), 0) == PROFILING_FAILED) {
        MSPROF_LOGE("send rsq: %d(%d) failed", type, rsqCode);
    }
    MSPROF_LOGI("server send rsq: %d,%d", type, rsqCode);
}

void DynProfServer::DynProfSrvProc() const
{
    while (srvStarted_) {
        DynProfMsg reqMsg;
        const auto recvLen = LocalSocket::Recv(cliSockFd_, &(reqMsg), sizeof(reqMsg), 0);
        if (recvLen == SOCKET_ERR_EAGAIN) {
            continue;
        }
        if (recvLen != sizeof(reqMsg)) {
            MSPROF_LOGE("recv client cmd failed");
            break;
        }
        MSPROF_LOGI("server received msg: %d,%d", reqMsg.msgType, reqMsg.statusCode);
        auto it = procFuncMap_.find(reqMsg.msgType);
        if (it == procFuncMap_.cend()) {
            MSPROF_LOGE("recv client cmd: %d invalid", reqMsg.msgType);
            break;
        }
        (it->second)();
        if (reqMsg.msgType == DynProfMsgType::DYN_PROF_QUIT_REQ) {
            break;
        }
    }
}

void DynProfServer::DynProfSrvProcStart()
{
    std::unique_lock<std::mutex> lk(devMtx_);
    MSPROF_LOGI("Dynamic profiling start message process.");
    if (profStarted_) {
        MSPROF_LOGW("Dynamic profiling has already started.");
        DynProfSrvRsqMsg(DynProfMsgType::DYN_PROF_START_RSQ, DynProfMsgRsqCode::DYN_PROF_RSQ_ALREADY_START);
        return;
    }
    if (devicesInfo_.empty()) {
        MSPROF_LOGW("Dynamic profiling has not set device.");
        DynProfSrvRsqMsg(DynProfMsgType::DYN_PROF_START_RSQ, DynProfMsgRsqCode::DYN_PROF_RSQ_NOT_SET_DEVICE);
        return;
    }

    int32_t ret = Msprofiler::Api::ProfAclMgr::instance()->MsprofInitAclEnv(dynProfParams_);
    if (ret != MSPROF_ERROR_NONE) {
        MSPROF_LOGE("Dynamic profiling start init acl env failed, ret=%d.", ret);
        DynProfSrvRsqMsg(DynProfMsgType::DYN_PROF_START_RSQ, DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL);
        return;
    }

    if (Msprofiler::Api::ProfAclMgr::instance()->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Dynamic profiling failed to init acl manager");
        DynProfSrvRsqMsg(DynProfMsgType::DYN_PROF_START_RSQ, DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL);
        Msprofiler::Api::ProfAclMgr::instance()->SetModeToOff();
        return;
    }

    std::unique_lock<std::mutex> devLk(devInfoMtx_, std::defer_lock);
    devLk.lock();
    std::vector<DynProfDeviceInfo> notifyInfo;
    for (auto iter = devicesInfo_.begin(); iter != devicesInfo_.end(); iter++) {
        notifyInfo.push_back(iter->second);
    }
    devLk.unlock();

    for (auto &devInfo : notifyInfo) {
        ret = Analysis::Dvvp::ProfilerCommon::ProfNotifySetDevice(devInfo.chipId, devInfo.devId, devInfo.isOpenDevice);
        if (ret != MSPROF_ERROR_NONE) {
            MSPROF_LOGE("Dynamic profiling start set device failed, ret=%d.", ret);
            DynProfSrvRsqMsg(DynProfMsgType::DYN_PROF_START_RSQ, DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL);
            return;
        }
    }

    profStarted_ = true;
    MSPROF_LOGI("Dynamic profiling start message process success.");
    DynProfSrvRsqMsg(DynProfMsgType::DYN_PROF_START_RSQ, DynProfMsgRsqCode::DYN_PROF_RSQ_SUCCESS);
}

void DynProfServer::DynProfSrvProcStop()
{
    MSPROF_LOGI("Dynamic profiling stop message process.");
    if (!profStarted_) {
        MSPROF_LOGW("Dynamic profiling has not started.");
        DynProfSrvRsqMsg(DynProfMsgType::DYN_PROF_STOP_RSQ, DynProfMsgRsqCode::DYN_PROF_RSQ_NOT_START);
        return;
    }
    int32_t ret = Msprofiler::Api::ProfAclMgr::instance()->MsprofFinalizeHandle();
    if (ret != MSPROF_ERROR_NONE) {
        MSPROF_LOGE("Dynamic profiling call msprof finalize failed");
        DynProfSrvRsqMsg(DynProfMsgType::DYN_PROF_STOP_RSQ, DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL);
        return;
    }

    profStarted_ = false;
    MSPROF_LOGI("Dynamic profiling stop message process success.");
    DynProfSrvRsqMsg(DynProfMsgType::DYN_PROF_STOP_RSQ, DynProfMsgRsqCode::DYN_PROF_RSQ_SUCCESS);
}

void DynProfServer::DynProfSrvProcQuit()
{
    MSPROF_LOGI("Dynamic profiling quit message process.");
    if (profStarted_) {
        int32_t ret = Msprofiler::Api::ProfAclMgr::instance()->MsprofFinalizeHandle();
        if (ret != MSPROF_ERROR_NONE) {
            MSPROF_LOGE("Dynamic profiling call msprof finalize failed");
            DynProfSrvRsqMsg(DynProfMsgType::DYN_PROF_QUIT_RSQ, DynProfMsgRsqCode::DYN_PROF_RSQ_FAIL);
            profStarted_ = false;
            return;
        }
    }
    profStarted_ = false;
    DynProfSrvRsqMsg(DynProfMsgType::DYN_PROF_QUIT_RSQ, DynProfMsgRsqCode::DYN_PROF_RSQ_SUCCESS);
    MSPROF_LOGI("Dynamic profiling quit message process success.");
}

void DynProfServer::SaveDevicesInfo(DynProfDeviceInfo data)
{
    std::unique_lock<std::mutex> devLk(devInfoMtx_);
    auto iter = devicesInfo_.find(data.devId);
    if (iter == devicesInfo_.end()) {
        if (data.isOpenDevice) {
            devicesInfo_.insert(std::pair<uint32_t, DynProfDeviceInfo>(data.devId, data));
        }
    } else {
        if (!data.isOpenDevice) {
            devicesInfo_.erase(iter);
        }
    }
}

} // namespace DynProf
} // namespace Dvvp
} // namespace Collector
