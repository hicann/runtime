/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/hdc_server.h"
#include "driver/ascend_hal.h"
#include "mmpa/mmpa_api.h"
#include "inc/internal_api.h"
#include "inc/message_parse_server.h"
#include "inc/log.h"
#include "inc/version_verify.h"
#include "inc/process_util_server.h"
#include "inc/tsdaemon.h"
#include "inc/tsd_feature_ctrl.h"
namespace {
    // server默认的最大session个数
    constexpr uint32_t HDC_SERVER_DEFAULT_MAX_SESSION_NUM(2048U);
    // 最多尝试连接次数
    constexpr uint32_t HDC_SERVER_RETRY_MAX_NUM = 120U;
    constexpr uint32_t HDC_SERVER_RETRY_WAIT_TIMEOUT = 1000U; // 1s
    // 延迟10ms后关闭session
    constexpr uint32_t SESSION_CLOSE_DELAY_TIME = 10U;
    constexpr uint64_t PER_NUMA_NODE_MIN_SPACE = 5000UL;
}

namespace tsd {
    std::map<uint64_t, std::shared_ptr<HdcServer>> HdcServer::hdcServerMap_;
    std::recursive_mutex HdcServer::mutextForHdcServerMap_;
    /**
    * @ingroup HdcServer
    * @param [in] devId : 目标设备Id
    * @param [in] type : 创建的链接类型
    * @brief HdcServer构造函数
    */
    HdcServer::HdcServer(const uint32_t devId, const HDCServiceType hdcType)
        : HdcCommon(),
          tdtMainPid_(0),
          hdcServer_(nullptr),
          deviceId_(devId),
          type_(hdcType),
          index_(KeyCompose(devId, hdcType)),
          sessionIdForPid_(0xffffffffU),
          recvRunSwitch_(true),
          acceptSwitch_(true),
          isServerClose_(true),
          isAbnormalExit_(false)
    {
        sessionIdNumVec_.reserve(HDC_SERVER_DEFAULT_MAX_SESSION_NUM);
        for (uint32_t i = HDC_SERVER_DEFAULT_MAX_SESSION_NUM; i >= 1U; i--) {
            sessionIdNumVec_.push_back(i);
        }
    }

    /**
    * @ingroup HdcServer
    * @brief 静态函数，获得单例类实例
    * @param [in] devId : 目标设备Id
    * @param [in] hdcType : 目标链接类型
    * @return HdcServer单例类实例
    */
    std::shared_ptr<HdcServer> HdcServer::GetInstance(const uint32_t devId, const HDCServiceType hdcType)
    {
        if (devId >= MAX_DEVNUM_PER_OS) {
            TSD_ERROR("deviceId=%u is not supported, not in [0-%u]", devId, MAX_DEVNUM_PER_OS);
            return nullptr;
        }

        uint64_t hdcIndex = KeyCompose(devId, hdcType);
        std::shared_ptr<HdcServer> hdcServerPtr = nullptr;
        {
            const std::lock_guard<std::recursive_mutex> lk(mutextForHdcServerMap_);
            const auto iter = hdcServerMap_.find(hdcIndex);
            if (iter != hdcServerMap_.end()) {
                hdcServerPtr = iter->second;
            } else {
                hdcServerPtr.reset(new(std::nothrow)HdcServer(devId, hdcType));
                TSD_CHECK((hdcServerPtr != nullptr), nullptr, "Fail to create hdcServerPtr");
                (void)hdcServerMap_.insert(std::make_pair(hdcIndex, hdcServerPtr));
            }
        }
        return hdcServerPtr;
    }

    /**
    * @ingroup HdcServer
    * @brief 初始化函数，建立hdcserver，开启accept 线程
    * @return TSD_OK : 成功，other : TDT错误码
    */
    TSD_StatusT HdcServer::Init(const bool isAdcEnv)
    {
        TSD_INFO("HdcServer::Init Start");
        if (isServerClose_) {
            hdcError_t retVal = DRV_ERROR_NONE;
            const drvHdcServiceType drvType = HDC_SERVICE_TYPE_TSD;
            for (uint32_t tryNum = 0U; tryNum <= HDC_SERVER_RETRY_MAX_NUM; tryNum++) {
                retVal = drvHdcServerCreate(static_cast<int32_t>(deviceId_), drvType, &hdcServer_);
                if (retVal == DRV_ERROR_NONE) {
                    isServerClose_ = false;
                    break;
                }
                if (tryNum >= HDC_SERVER_RETRY_MAX_NUM) {
                    TSD_ERROR("deviceId=%u: drvtype=%d drv hdc server create failed, ret = %d", deviceId_, drvType,
                              retVal);
                    return TSD_HDC_SRV_CREATE_ERROR;
                }
                (void)mmSleep(HDC_SERVER_RETRY_WAIT_TIMEOUT);
            }
        }

        const TSD_StatusT tsdRet = InitMsgSize();
        if (tsdRet != TSD_OK) {
            TSD_ERROR("initMsgSize() fail");
            return TSD_HDC_SRV_CREATE_ERROR;
        }
        isAdcEnv_ = isAdcEnv;
        try {
            acceptThread_ = std::thread(&HdcServer::Accept, this);
        } catch (std::exception &e) {
            TSD_ERROR("create tsd hdcserver accept thead failed:[%s]", e.what());
            return TSD_HDC_SRV_CREATE_ERROR;
        }

        return TSD_OK;
    }

    /**
     * @ingroup HdcServer
     * @brief 普通数据接收线程Job
     * @param [in] sessionId : 某个连接sessionId
     */
    void HdcServer::RecvData(const uint32_t sessionId)
    {
        (void)mmSetCurrentThreadName("tsdaemon"); // name max length (contain \0) is 15
        TSD_RUN_INFO("Receive data deviceId = %u thread = %d, sessionId[%u]", deviceId_, mmGetTid(), sessionId);
        int32_t vfId = 0;
        const TSD_StatusT ret = GetHdcVfId(sessionId, vfId);
        if (ret != TSD_OK) {
            ClearRecvSession(sessionId);
            TSD_ERROR("[sessionId=%u] Get hdc vfid failed", sessionId);
            return;
        }
        HDCMessage msg;
        while (recvRunSwitch_) {
            TSD_StatusT recvRt = TSD_OK;
            const uint32_t timeout = 0U;
            if ((ProcessUtilServer::IsHeterogeneousRemote()) || (isAdcEnv_) || (ProcessUtilServer::Is310P())) {
                recvRt = RecvMsg(sessionId, msg, timeout, true);
            } else {
                recvRt = RecvMsg(sessionId, msg, timeout, false);
            }
            // 调用注册的回调函数，回传时填写的DEVICEID用创建时的补充
            msg.set_device_id(deviceId_);
            msg.set_vf_id(vfId);
            if (recvRt != TSD_OK) {
                if (recvRt == TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED) {
                    msg.set_type(HDCMessage::SOCKET_CLOSED);
                    TSD_RUN_WARN("Receive no msg by socket closed, sessionId[%u], deviceId[%u]",
                                 sessionId, deviceId_);
                } else {
                    msg.set_type(HDCMessage::HDC_RECV_ERROR);
                    TSD_RUN_WARN("Receive no msg by hdc down, sessionId[%u], deviceId[%u]", sessionId, deviceId_);
                }
                MessageParseServer::GetInstance()->ProcessMessage(sessionId, msg);
                break;
            }
            MessageParseServer::GetInstance()->ProcessMessage(sessionId, msg);
            if (msg.type() == HDCMessage::TSD_CLOSE_PROC_MSG) {
                const int32_t processExitTimeoutCount = 200;  // 200ms
                int32_t processExitCostCount = 0;
                HDC_SESSION session = nullptr;
                while ((GetHdcSession(sessionId, session) != TSD_HDC_SESSION_DO_NOT_EXIST) &&
                    (processExitCostCount < processExitTimeoutCount)) {
                    processExitCostCount++;
                    (void)mmSleep(100U);  // ms
                }
                if (processExitCostCount < processExitTimeoutCount) {
                    TSD_RUN_INFO("[deviceId=%u][sessionId=%u]Server exit normally after %d count.", deviceId_,
                                 sessionId, processExitCostCount);
                    break;
                } else {
                    TSD_RUN_INFO("[deviceId=%u][sessionId=%u]Server continue process.", deviceId_, sessionId);
                }
            }
        }
        TSD_RUN_INFO("[deviceId=%u][sessionId=%u] Receive data has exited", deviceId_, sessionId);
        ClearRecvSession(sessionId);
        return;
    }

    /**
     * @ingroup HdcServer
     *  @param [in] sessionId ： 某个连接sessionId
     * @brief 退出该session的recv线程
     */
    void HdcServer::ClearRecvSession(const uint32_t sessionId)
    {
        ClearSingleSession(sessionId);
        ClearPidBySessionId(sessionId);
        int32_t tid = mmGetTid();
        if (tid >= 0) {
            const std::lock_guard<std::mutex> lk(logPrintMapMutex_);
            const auto iter = logPrintMap_.find(tid);
            if (iter != logPrintMap_.end()) {
                (void)logPrintMap_.erase(iter);
            }
        }
        TSD_INFO("[deviceId=%u] the recv data pthread exit", deviceId_);
    }

    /**
     * @ingroup HdcServer
     * @param [in] acceptMode : 接受连接开关
     * @brief accept 线程开关
     */
    void HdcServer::SetAcceptSwitch(const bool acceptMode)
    {
        acceptSwitch_ = acceptMode;
    }
    /**
     * @ingroup HdcServer
     * @param [in] runStatus : 执行消息接收开关
     * @brief recv 线程开关
     */
    void HdcServer::SetRunSwitch(const bool runStatus)
    {
        recvRunSwitch_ = runStatus;
    }
    /**
     * @ingroup HdcServer
     * @brief accept 线程接收连接请求
     * @return TSD_OK:成功 或者其他错误码
     */
    TSD_StatusT HdcServer::Accept()
    {
        (void)mmSetCurrentThreadName("Accept"); // name max length (contain \0) is 15
        TSD_INFO("HdcServer::Accept thread = %d", mmGetTid());

        uint32_t sessionID = 0U;
        while (acceptSwitch_) {
            const TSD_StatusT ret = AcceptHdcSession(sessionID);
            if (!acceptSwitch_) {
                TSD_INFO("acceptSwitch has been set false");
                break;
            }
            if (ret == TSD_HDCSESSIONID_NOT_AVAILABLE) {
                TSD_RUN_INFO("not enough sessionid");
                isAbnormalExit_ = true;
                return ret;
            } else if (ret == TSD_HDC_SRV_CLOSED) {
                TSD_RUN_INFO("hdc server exit the accept thread");
                return ret;
            } else if (ret != TSD_OK) {
                if (FeatureCtrl::IsVfModeCheckedByDeviceId(deviceId_)) {
                    TSD_RUN_INFO("NO Connection, continue waiting for new connection");
                } else {
                    TSD_ERROR("NO Connection, continue waiting for new connection");
                }
            } else {
                if (IsOccurOOM(sessionID)) {
                    ClearRecvSession(sessionID);
                    TSD_ERROR("out of memory happend, current message dropped, order Id:%u", sessionID);
                    continue;
                }
                TSD_INFO("[HdcSever] accept a session sessionId=%u, open recv thread", sessionID);
                SetRunSwitch(true);
                {
                    const std::lock_guard<std::recursive_mutex> lk(mutextForThreadSessionIDmap_);
                    try {
                        std::thread recvThread(&HdcServer::RecvData, this, sessionID);
                        recvThread.detach();
                    } catch (std::exception &e) {
                        TSD_ERROR("create tsd RecvData thead failed:[%s]", e.what());
                    }
                }
            }
        }
        return TSD_OK;
    }
    /**
     * @ingroup HdcServer
     * @brief 监听连接
     * @param [in] sessionId : 会话ID
     * @return 错误码
     */
    TSD_StatusT HdcServer::AcceptHdcSession(uint32_t& sessionId)
    {
        TSD_INFO("HdcServer::AcceptConnection Start");
        if (isServerClose_) {
            TSD_ERROR("hdc server has been closed");
            return TSD_HDC_SRV_CLOSED;
        }
        if (sessionIdNumVec_.empty()) {
            TSD_ERROR("the connect session is greater than %d", HDC_SERVER_DEFAULT_MAX_SESSION_NUM);
            return TSD_HDCSESSIONID_NOT_AVAILABLE;
        }
        HDC_SESSION session = nullptr;
        TSD_RUN_INFO("HdcServer::Accept session start deviceId[%u], timestamp[%llu]", deviceId_, GetCurrentTime());
        const hdcError_t retVal = drvHdcSessionAccept(hdcServer_, &session);
        TSD_RUN_INFO("HdcServer::Accept session end deviceId[%u], timestamp[%llu]", deviceId_, GetCurrentTime());
        if (retVal != DRV_ERROR_NONE) {
            if (!acceptSwitch_) {
                TSD_INFO("drv accept exception, because acceptSwitch has been set false, ret=%d", retVal);
            } else {
                if (FeatureCtrl::IsVfModeCheckedByDeviceId(deviceId_)) {
                    TSD_RUN_INFO("[HdcSever] drv accept a session not success, ret=%d", retVal);
                } else {
                    TSD_ERROR("[HdcSever] drv accept a session failed, ret=%d", retVal);
                }
            }
            return TSD_HDC_SRV_ACCEPT_ERROR;
        }
        TSD_RUN_INFO("HdcServer::Set session reference start deviceId[%u], timestamp[%llu]", deviceId_, GetCurrentTime());
        const hdcError_t ret = drvHdcSetSessionReference(session);
        TSD_RUN_INFO("HdcServer::Set session reference end deviceId[%u], timestamp[%llu]", deviceId_, GetCurrentTime());
        if (ret != DRV_ERROR_NONE) {
            TSD_ERROR("[deviceId=%u] drvHdcSetSessionReference failed, "
                "need to close session, ret = %d", deviceId_, ret);
            if (drvHdcSessionClose(session) != DRV_ERROR_NONE) {
                TSD_ERROR("HdcSever::Destroy the session failed");
            }
            return TSD_SET_HDCSESSION_REFERENCE_FAILED;
        }

        {
            // sessionIdNumVec_和hdcServerSessionMap_共用一把锁
            const std::lock_guard<std::recursive_mutex> lk(mutextForServerSessionMap_);
            sessionId = sessionIdNumVec_.back();
            sessionIdNumVec_.pop_back();
            hdcServerSessionMap_[sessionId] = session;
            hdcServerVerifyMap_[sessionId] = MakeVersionVerifyNoThrow();
        }
        TSD_INFO("[HdcSever] Driver accept a session and drvHdcSetSessionReference success, sessionId=%u.", sessionId);

        return TSD_OK;
    }

    /**
     * @ingroup HdcServer
     * @brief 根据sessionId获取 hdcsession
     * @param [in] sessionId : 某个连接sessionId
     * @param [out] session : session 会话
     * @return TSD_OK:成功 或者其他错误码
     */
    TSD_StatusT HdcServer::GetHdcSession(const uint32_t sessionId,  HDC_SESSION& session)
    {
        const std::lock_guard<std::recursive_mutex> lk(mutextForServerSessionMap_);
        uint32_t localSessionId = sessionId;
        if ((!hdcServerSessionMap_.empty()) && (localSessionId == 0U)) {
            localSessionId = hdcServerSessionMap_.begin()->first;
        }
        const auto iter = hdcServerSessionMap_.find(localSessionId);
        if (iter == hdcServerSessionMap_.end()) {
            TSD_RUN_INFO("HdcServer::GetHdcSession(): the %u session does not exist", localSessionId);
            return TSD_HDC_SESSION_DO_NOT_EXIST;
        }
        session = iter->second;
        return TSD_OK;
    }

    /**
     * @ingroup HdcServer
     * @brief 根据sessionId获取versionVerify
     * @param [in] sessionId : session通道对应的版本校验
     * @return shared_ptr<VersionVerify> : 版本校验对象指针
     */
    TSD_StatusT HdcServer::GetVersionVerify(const uint32_t sessionId, std::shared_ptr<VersionVerify> &inspector)
    {
        const std::lock_guard<std::recursive_mutex> lk(mutextForServerSessionMap_);
        uint32_t localSessionId = sessionId;
        if ((!hdcServerSessionMap_.empty()) && (localSessionId == 0U)) {
            localSessionId = hdcServerSessionMap_.begin()->first;
        }
        const auto iter = hdcServerVerifyMap_.find(localSessionId);
        if (iter == hdcServerVerifyMap_.end()) {
            TSD_RUN_INFO("HdcServer::GetVersionVerify(): the %u VersionVerify does not exist", localSessionId);
            return TSD_HDC_SESSION_DO_NOT_EXIST;
        }
        inspector = iter->second;
        return TSD_OK;
    }

    /**
     * @ingroup HdcServer
     * @brief 根据sessionId获取 hdcsession
     * @param [in] sessionId : 某个连接sessionId
     * @param [out] vfId : 虚拟化vfId
     * @return TSD_OK:成功 或者其他错误码
     */
    TSD_StatusT HdcServer::GetHdcVfId(const uint32_t sessionId, int32_t &vfId)
    {
        const std::lock_guard<std::recursive_mutex> lk(mutextForServerSessionMap_);
        HDC_SESSION session = nullptr;
        const TSD_StatusT ret = GetHdcSession(sessionId, session);
        if (ret != TSD_OK) {
            TSD_ERROR("get session by sessionId[%u] fail", sessionId);
            return ret;
        }
        const hdcError_t drvRet = halHdcGetSessionAttr(session, HDC_SESSION_ATTR_VFID, &vfId);
        if (drvRet != DRV_ERROR_NONE) {
            TSD_ERROR("[HdcSever] halHdcGetSessionAttr get vfId fail, ret=%d", drvRet);
            return TSD_HDC_SRV_ACCEPT_ERROR;
        }
        TSD_INFO("[HdcSever] Session[%u] get vfId success, vfId=%d", sessionId, vfId);
        return TSD_OK;
    }

    /**
     * @ingroup HdcServer
     * @brief join accept 线程
     */
    void HdcServer::JoinAcceptThread()
    {
        if (acceptThread_.joinable()) {
            acceptThread_.join();
        }
    }
    /**
     * @ingroup HdcServer
     * @brief join recv 线程
     */
    void HdcServer::JoinAllRecvThread()
    {
        const std::lock_guard<std::recursive_mutex> lk(mutextForThreadSessionIDmap_);
        for (auto it = threadSessionIDmap_.begin(); it != threadSessionIDmap_.end(); ++it) {
            std::thread& th = it->second;
            if (th.joinable()) {
                th.join();
            }
        }
    }
    /**
     * @ingroup HdcServer
     * @brief 清空 recv线程 vector
     */
    void HdcServer::ClearAll()
    {
        const std::lock_guard<std::recursive_mutex> lk(mutextForThreadSessionIDmap_);
        threadSessionIDmap_.clear();
    }

    /**
     * @ingroup HdcServer
     * @param [in] sessionId : 某个连接sessionId
     * @brief 清空某个会话的pid值
     */
    void HdcServer::ClearPidBySessionId(const uint32_t sessionId)
    {
        if (sessionIdForPid_.load() == sessionId) {
            TSD_ERROR("[HdcServer] SessionIdPidMsg enter into ClearPidBySessionId sessionId:%u, pid:%d",
                sessionIdForPid_.load(), tdtMainPid_.load());
            ClearSessionIdPid();
        }
    }

    /**
     * @ingroup HdcServer
     * @brief tdtMainPid_,sessionIdForPid_重新赋初值
     */
    void HdcServer::ClearSessionIdPid()
    {
        tdtMainPid_ = 0;
        sessionIdForPid_ = 0xffffffffU;
    }

    /**
     * @ingroup HdcServer
     * @param [in] sessionId : 某个连接sessionId
     * @brief 关闭某个会话
     */
    void HdcServer::ClearSingleSession(const uint32_t sessionId)
    {
        TSD_RUN_INFO("[HdcServer] Start to clear the single session with sessionId=%u.", sessionId);
        const std::lock_guard<std::recursive_mutex> lk(mutextForServerSessionMap_);
        const auto iterVerify = hdcServerVerifyMap_.find(sessionId);
        if (iterVerify != hdcServerVerifyMap_.end()) {
            (void)hdcServerVerifyMap_.erase(iterVerify);
        }
        TSD_INFO("end to destroy hdc versionVerify.");

        const auto iter = hdcServerSessionMap_.find(sessionId);
        if (iter != hdcServerSessionMap_.end()) {
            if (drvHdcSessionClose(iter->second) != DRV_ERROR_NONE) {
                TSD_ERROR("[HdcServer] Clear the %u session failed", sessionId);
                return;
            }
            (void)sessionIdNumVec_.insert(sessionIdNumVec_.begin(), sessionId);
            (void)hdcServerSessionMap_.erase(iter);
        }
        TSD_INFO("[HdcServer] Clear the single session with sessionId=%u success.", sessionId);
    }

    /**
     * @ingroup HdcServer
     * @brief 关闭所有会话
     */
    void HdcServer::ClearAllSession()
    {
        const std::lock_guard<std::recursive_mutex> lk(mutextForServerSessionMap_);
        hdcServerVerifyMap_.clear();
        for (auto iter = hdcServerSessionMap_.begin(); iter != hdcServerSessionMap_.end(); ++iter) {
            if (drvHdcSessionClose(iter->second) != DRV_ERROR_NONE) {
                TSD_ERROR("HdcServer::Destroy the %d session failed", iter->first);
            }
            sessionIdNumVec_.push_back(iter->first);
        }
        hdcServerSessionMap_.clear();
    }

    /**
     * @ingroup HdcServer
     * @brief 从hdcServerMap里面删除hdcsever指针
     */
    void HdcServer::ClearServerPtr()
    {
        const std::lock_guard<std::recursive_mutex> lk(mutextForHdcServerMap_);
        const auto iter = hdcServerMap_.find(index_);
        if (iter == hdcServerMap_.end()) {
            TSD_ERROR("delete the %d hdcServerPtr from hdcServerMap_ failed", index_);
            return;
        }
        (void)hdcServerMap_.erase(iter);
    }

    /**
    * @ingroup HdcServer
    * @brief 销毁当前Hdc server
    */
    void HdcServer::DestroyServer()
    {
        if (!isServerClose_) {
            const hdcError_t retVal = drvHdcServerDestroy(hdcServer_);
            if (retVal != DRV_ERROR_NONE) {
                TSD_ERROR("drvHdcServerDestroy() return %d", retVal);
            }
            isServerClose_ = true;
        }
    }

    /**
    * @ingroup HdcServer
    * @brief 关闭HDC连接，消耗相关资源
    * @return TSD_OK:成功 或者其他错误码
    */
    TSD_StatusT HdcServer::Destroy()
    {
        TSD_INFO("enter HdcServer::Destroy() function");
        SetAcceptSwitch(false);
        SetRunSwitch(false);
        // 休眠10ms，再调用驱动closesession，规避drvHdcAllocMsg报错
        (void)mmSleep(SESSION_CLOSE_DELAY_TIME);
        ClearAllSession();
        JoinAllRecvThread();
        DestroyServer();
        JoinAcceptThread();
        ClearServerPtr();
        ClearAll();
        ClearSessionIdPid();
        return TSD_OK;
    }

    /**
    * @ingroup HdcCommon
    * @brief 虚函数 GetDeviceId 获得设备ID
    * return 设备ID
    */
    uint32_t HdcServer::GetDeviceId() const
    {
        return deviceId_;
    }

    /**
    * @ingroup HdcCommon
    * @brief 纯虚函数 GetHdcServiceType 获得 HdcServiceType
    * return HdcServiceType
    */
    HDCServiceType HdcServer::GetHdcServiceType() const
    {
        return type_;
    }

    /**
    * @ingroup HdcClient
    * @brief 析构函数
    */
    HdcServer::~HdcServer() {}

    bool HdcServer::GetAITypeNumaId(std::vector<uint32_t> &nodeListVec) const
    {
        MemInfo memInfo = {};
        const auto getRet = halMemGetInfo(deviceId_, MEM_INFO_TYPE_AI_NUMA_INFO, &memInfo);
        if (getRet != DRV_ERROR_NONE) {
            TSD_RUN_WARN("get numa node info unsuccessfully, deviceId[%u]", deviceId_);
            return false;;
        }
        const uint64_t nodeNum = static_cast<uint64_t>(memInfo.numa_info.node_cnt);
        if (nodeNum > sizeof(memInfo.numa_info.node_id) / sizeof(int32_t)) {
            TSD_RUN_WARN("numa node num[%lu] is invalid, deviceId[%u]", nodeNum, deviceId_);
            return false;
        }

        for (uint64_t index = 0UL; index < nodeNum; index++) {
            nodeListVec.push_back(static_cast<uint32_t>(memInfo.numa_info.node_id[index]));
            TSD_RUN_INFO("get numa node id[%lu], deviceId[%u]", static_cast<uint32_t>(memInfo.numa_info.node_id[index]), deviceId_);
        }

        return true;
    }

    bool HdcServer::IsOccurOOM(const uint32_t sessionId) const
    {
        if (!FeatureCtrl::IsNeedCheckOOM()) {
            TSD_INFO("no need check oom dev:%u, order Id:%u", deviceId_, sessionId);
            return false;
        }

        std::vector<uint32_t> nodeListVec;
        if (!GetAITypeNumaId(nodeListVec)) {
            TSD_RUN_WARN("get AI type numa node info unsuccessfully, deviceId[%u]", deviceId_);
            return false;
        }

        TSD_INFO("start detect oom dev:%u, order Id:%u", deviceId_, sessionId);
        uint64_t curMem = 0UL;
        for (const auto nodeId : nodeListVec) {
            const std::string queryNodeId = NUMA_NODE_FILE_NAME_PREFIX + std::to_string(nodeId) + NUMA_NODE_FILE_NAME_SUFFIX;
            const std::string queryInfo = NUMA_NODE_FILE_FREE_PREFIX + std::to_string(nodeId) + NUMA_NODE_FILE_FREE_SUFFIX;
            if (ProcessUtilServer::GetNumNodeMemInfo(queryNodeId, queryInfo, curMem) != TSD_OK) {
                TSD_RUN_WARN("get numa node info unsuccessfully, nodeId[%lu] deviceId[%u]", nodeId, deviceId_);
                return false;
            }
            if (curMem >= PER_NUMA_NODE_MIN_SPACE) {
                return false;
            }
        }

        return true;
    }
} // namespace tsd
