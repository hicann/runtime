/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/domain_socket_server.h"
#include "mmpa/mmpa_api.h"
#include "inc/internal_api.h"
#include "inc/message_parse_server.h"
#include "inc/log.h"
#include "inc/process_util_server.h"

#define SOCKET_PERMISSION_WRITE 0640
namespace {
    // 与device保持一致 最多2048个session
    constexpr uint32_t DOMAIN_SOCKET_SERVER_DEFAULT_MAX_SESSION_NUM = (2048U);
    constexpr int32_t LISTEN_QUEUE_LEN = 10;
}

namespace tsd {
    // domain socket对象的map表，
    std::map<uint32_t, std::shared_ptr<DomainSocketServer>> DomainSocketServer::domainSocketServerMap_;
    // deviceTd、type和Server指针对象的Map的锁
    std::mutex DomainSocketServer::mutextForDomainSocketServerMap_;
    DomainSocketServer::DomainSocketServer(const uint32_t devId)
        : DomainSocketCommon(),
          domainScoketServer_(-1),
          deviceId_(devId),
          recvRunSwitch_(true),
          acceptSwitch_(true),
          isServerClose_(true)
    {
        sessionIdNumVec_.reserve(DOMAIN_SOCKET_SERVER_DEFAULT_MAX_SESSION_NUM);
        for (uint32_t i = DOMAIN_SOCKET_SERVER_DEFAULT_MAX_SESSION_NUM; i >= 1U; i--) {
            sessionIdNumVec_.push_back(i);
        }
    }

    std::shared_ptr<DomainSocketServer> DomainSocketServer::GetInstance(const uint32_t devId)
    {
        std::shared_ptr<DomainSocketServer> curServerPtr = nullptr;
        {
            const std::lock_guard<std::mutex> lk(mutextForDomainSocketServerMap_);
            const auto iter = domainSocketServerMap_.find(devId);
            if (iter != domainSocketServerMap_.end()) {
                curServerPtr = iter->second;
            } else {
                curServerPtr.reset(new(std::nothrow)DomainSocketServer(devId));
                TSD_CHECK((curServerPtr != nullptr), nullptr, "Fail to create curServerPtr");
                (void)domainSocketServerMap_.insert(std::make_pair(devId, curServerPtr));
            }
        }
        return curServerPtr;
    }

    TSD_StatusT DomainSocketServer::SocketBindToAddress(int32_t serverSocket) const
    {
        sockaddr_un address = {0};
        address.sun_family = AF_UNIX;
        std::string curSocketPath;
        GetDomainSocketFilePath(curSocketPath);
        int32_t len = sprintf_s(address.sun_path, sizeof(address.sun_path), "%s_%d", curSocketPath.c_str(), deviceId_);
        if (len < 0) {
            TSD_ERROR("set socket path error");
            return TSD_HDC_SRV_CREATE_ERROR;
        }
        // remove the file，otherwise will receive EADDRINUSE
        (void)unlink(address.sun_path);
        int32_t pathLen = offsetof(struct sockaddr_un, sun_path) + len;
        if (bind(serverSocket, PtrToPtr<sockaddr_un, struct sockaddr>(&address), pathLen) < 0) {
            TSD_ERROR("bind domain socket error[%s],errorno[%d]", SafeStrerror().c_str(), errno);
            return TSD_HDC_SRV_CREATE_ERROR;
        }
        (void)chmod(address.sun_path, SOCKET_PERMISSION_WRITE);
        return TSD_OK;
    }

    TSD_StatusT DomainSocketServer::Init()
    {
        TSD_INFO("DomainSocketServer::Init Start");
        if (isServerClose_) {
            int32_t serverSocket = socket(AF_UNIX, SOCK_STREAM, 0);
            if (serverSocket < 0) {
                TSD_ERROR("create server socket error[%s],errorno[%d]", SafeStrerror().c_str(), errno);
                return TSD_HDC_SRV_CREATE_ERROR;
            }

            if (SocketBindToAddress(serverSocket) != TSD_OK) {
                TSD_ERROR("DomainSocketServer::bind socket to address error");
                return TSD_HDC_SRV_CREATE_ERROR;
            }

            if (listen(serverSocket, LISTEN_QUEUE_LEN) < 0) {
                TSD_ERROR("start listen error[%s],errorno[%d]", SafeStrerror().c_str(), errno);
                return TSD_HDC_SRV_CREATE_ERROR;
            }

            isServerClose_ = false;
            domainScoketServer_ = serverSocket;
            try {
                acceptThread_ = std::thread(&DomainSocketServer::Accept, this);
            } catch (std::exception &e) {
                TSD_ERROR("create tsd domainsocket accept thead failed:[%s]", e.what());
                return TSD_HDC_SRV_CREATE_ERROR;
            }
        }
        return TSD_OK;
    }

    TSD_StatusT DomainSocketServer::Accept()
    {
        (void)mmSetCurrentThreadName("Accept");
        TSD_INFO("DomainSocketServer::Accept thread[%d]", mmGetTid());

        uint32_t sessionID = 0U;
        while (acceptSwitch_ && domainScoketServer_ != -1) {
            const TSD_StatusT ret = AcceptDomainSocketSession(sessionID);
            if (!acceptSwitch_) {
                TSD_INFO("acceptSwitch has been set false");
                break;
            }
            if (ret == TSD_HDC_SRV_CLOSED) {
                TSD_ERROR("hdc server exit the accept thread");
                return ret;
            } else if (ret != TSD_OK) {
                TSD_ERROR("NO Connection, continue waiting for new connection");
            } else {
                TSD_INFO("[HdcSever] accept a session sessionId[%u], open recv thread", sessionID);
                SetRunSwitch(true);
                {
                    const std::lock_guard<std::mutex> lk(mutextForThreadSessionIDmap_);
                    try {
                        std::thread recvThread(&DomainSocketServer::RecvData, this, sessionID);
                        recvThread.detach();
                    } catch (std::exception &e) {
                        TSD_ERROR("create tsd domainsocket RecvData thead failed:[%s]", e.what());
                        return TSD_HDC_SRV_CREATE_ERROR;
                    }
                }
            }
        }
        return TSD_OK;
    }

    TSD_StatusT DomainSocketServer::AcceptDomainSocketSession(uint32_t& sessionId)
    {
        TSD_INFO("DomainSocketServer::AcceptConnection Start");
        if (isServerClose_) {
            TSD_ERROR("hdc server has been closed");
            return TSD_HDC_SRV_CLOSED;
        }
        if (sessionIdNumVec_.empty()) {
            TSD_ERROR("the connect session is greater than %d", DOMAIN_SOCKET_SERVER_DEFAULT_MAX_SESSION_NUM);
            return TSD_HDCSESSIONID_NOT_AVAILABLE;
        }
        sockaddr_un un;
        int32_t len = sizeof(un);
        // accept client msg
        int32_t socket = accept(domainScoketServer_, PtrToPtr<sockaddr_un, sockaddr>(&un), PtrToPtr<int32_t, socklen_t>(&len));
        if (socket < 0) {
            TSD_ERROR("accept error[%s],errorno[%d]", SafeStrerror().c_str(), errno);
            return TSD_HDC_SRV_ACCEPT_ERROR;
        }
        {
            // sessionIdNumVec_和hdcServerSessionMap_共用一把锁
            const std::lock_guard<std::mutex> lk(mutextForDomainSocketServerSessionMap_);
            sessionId = sessionIdNumVec_.back();
            sessionIdNumVec_.pop_back();
            domainSocketServerSessionMap_[sessionId] = socket;
        }
        TSD_RUN_INFO("accept a session and save to servermap success, sessionId[%u] socket[%d]", sessionId, socket);

        return TSD_OK;
    }

    bool DomainSocketServer::IsEndRecvDataThread(const HDCMessage &msg, const uint32_t sessionId)
    {
        if (msg.type() == HDCMessage::SOCKET_CLOSED) {
            return true;
        }

        if (msg.type() == HDCMessage::TSD_CLOSE_PROC_MSG) {
            const int32_t processExitTimeoutCount = 200;  // 200ms
            int32_t processExitCostCount = 0;
            int32_t session = -1;
            while ((GetDomainSocketSession(sessionId, session) != TSD_HDC_SESSION_DO_NOT_EXIST) &&
                   (processExitCostCount < processExitTimeoutCount)) {
                processExitCostCount++;
                (void)mmSleep(100U);  // ms
            }
            if (processExitCostCount < processExitTimeoutCount) {
                TSD_RUN_INFO("[deviceId=%u][sessionId=%u]Server exit normally after %d count.", deviceId_,
                             sessionId, processExitCostCount);
                return true;
            } else {
                TSD_RUN_INFO("[deviceId=%u][sessionId=%u]Server continue process.", deviceId_, sessionId);
            }
        }
        return false;
    }
    void DomainSocketServer::SetHdcMsgBasicInfo(HDCMessage &msg, const TSD_StatusT recvRt, const uint32_t sessionId)
    {
        msg.set_vf_id(0);
        if (recvRt == TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED) {
            TSD_RUN_WARN("recv no msg by socket closed, sessionId[%u], deviceId[%u]", sessionId, deviceId_);
            msg.set_type(HDCMessage::SOCKET_CLOSED);
        }
    }
    void DomainSocketServer::RecvData(const uint32_t sessionId)
    {
        (void)mmSetCurrentThreadName("tsdaemon");
        TSD_RUN_INFO("DomainSocketServer::RecvData deviceId[%u] thread[%d] sessionId[%u]", deviceId_, mmGetTid(),
                     sessionId);
        HDCMessage msg;
        while (recvRunSwitch_) {
            const TSD_StatusT recvRt = RecvMsg(sessionId, msg);
            SetHdcMsgBasicInfo(msg, recvRt, sessionId);
            if (recvRt != TSD_OK) {
                TSD_RUN_WARN("recv msg failed, sessionId[%u], deviceId[%u]", sessionId, deviceId_);
                break;
            }
            MessageParseServer::GetInstance()->ProcessMessage(sessionId, msg);
            if (IsEndRecvDataThread(msg, sessionId)) {
                break;
            }
        }
        TSD_RUN_INFO("deviceId[%u]sessionId[%u] RecvData has exited", deviceId_, sessionId);
        ExitRecvThread(sessionId);
        return;
    }

    void DomainSocketServer::ExitRecvThread(const uint32_t sessionId)
    {
        ClearSingleSession(sessionId);
        TSD_INFO("deviceId[%u]  sessionId[%u] the recv data pthread exit", deviceId_, sessionId);
    }

    void DomainSocketServer::SetAcceptSwitch(const bool acceptMode)
    {
        acceptSwitch_ = acceptMode;
    }

    void DomainSocketServer::SetRunSwitch(const bool runStatus)
    {
        recvRunSwitch_ = runStatus;
    }

    TSD_StatusT DomainSocketServer::GetDomainSocketSession(const uint32_t sessionId,  int32_t& session)
    {
        const std::lock_guard<std::mutex> lk(mutextForDomainSocketServerSessionMap_);
        uint32_t localSessionId = sessionId;
        if ((!domainSocketServerSessionMap_.empty()) && (localSessionId == 0U)) {
            localSessionId = domainSocketServerSessionMap_.begin()->first;
        }
        const auto iter = domainSocketServerSessionMap_.find(localSessionId);
        if (iter == domainSocketServerSessionMap_.end()) {
            TSD_RUN_INFO("DomainSocketServer::GetDomainSocketSession(): the session[%u] does not exist", localSessionId);
            return TSD_HDC_SESSION_DO_NOT_EXIST;
        }
        session = iter->second;
        return TSD_OK;
    }

    void DomainSocketServer::JoinAcceptThread()
    {
        if (acceptThread_.joinable()) {
            acceptThread_.join();
        }
    }

    void DomainSocketServer::ClearSingleSession(const uint32_t sessionId)
    {
        TSD_RUN_INFO("[HdcServer] start to ClearSingleSession sessionId=%u", sessionId);
        const std::lock_guard<std::mutex> lk(mutextForDomainSocketServerSessionMap_);
        const auto iter = domainSocketServerSessionMap_.find(sessionId);
        if (iter != domainSocketServerSessionMap_.end()) {
            close(iter->second);
            TSD_RUN_WARN("[DomainSocketServer] close session[%u] socket[%d] failed", sessionId, iter->second);
            (void)sessionIdNumVec_.insert(sessionIdNumVec_.begin(), sessionId);
            (void)domainSocketServerSessionMap_.erase(iter);
        }
        TSD_RUN_INFO("[DomainSocketServer] ClearSingleSession sessionId[%u] success", sessionId);
    }

    void DomainSocketServer::ClearAllSession()
    {
        const std::lock_guard<std::mutex> lk(mutextForDomainSocketServerSessionMap_);
        for (auto iter = domainSocketServerSessionMap_.begin(); iter != domainSocketServerSessionMap_.end(); ++iter) {
            close(iter->second);
            sessionIdNumVec_.push_back(iter->first);
        }
        domainSocketServerSessionMap_.clear();
    }

    void DomainSocketServer::ClearServerPtr()
    {
        const std::lock_guard<std::mutex> lk(mutextForDomainSocketServerMap_);
        const auto iter = domainSocketServerMap_.find(deviceId_);
        if (iter == domainSocketServerMap_.end()) {
            TSD_ERROR("delete devid[%u] hdcServerPtr from domainSocketServerMap_ failed", deviceId_);
            return;
        }
        (void)domainSocketServerMap_.erase(iter);
    }

    void DomainSocketServer::DestroyServer()
    {
        if (!isServerClose_) {
            close(domainScoketServer_);
            isServerClose_ = true;
            domainScoketServer_ = -1;
        }
    }

    TSD_StatusT DomainSocketServer::Destroy()
    {
        TSD_RUN_INFO("enter DomainSocketServer::Destroy() function");
        SetAcceptSwitch(false);
        SetRunSwitch(false);
        ClearAllSession();
        DestroyServer();
        ClearServerPtr();
        return TSD_OK;
    }

    DomainSocketServer::~DomainSocketServer()
    {
        pthread_cancel(acceptThread_.native_handle());
        JoinAcceptThread();
    }
} // namespace tsd
