/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/hdc_client.h"
#include <thread>
#include "driver/ascend_hal.h"
#include "driver/ascend_hal_define.h"
#include "mmpa/mmpa_api.h"
#include "inc/internal_api.h"
#include "inc/message_parse_client.h"
#include "inc/log.h"
#include "inc/version_verify.h"
#include "tsd/status.h"

namespace {
    // 保留的flag标记位，当前不适用，填0
    constexpr uint32_t HDC_RESERVE_VALUE(0U);

    // client默认的最大session个数
    constexpr uint32_t HDC_CLIENT_DEFAULT_MAX_SESSION_NUM(96U);

    // 驱动支持查询socket链路状态的最小版本(不包含该版本)
    constexpr int32_t HDC_SOCKET_STATUS_GET_VERSION(0x05090E);
    constexpr uint32_t HDC_CLIENT_RETRY_MAX_NUM = 10U; // 最多尝试连接次数
    constexpr uint32_t HDC_CLIENT_RETRY_WAIT_TIMEOUT = 1000U; // 1s
    constexpr uint32_t FPGA_HDC_CLIENT_WAIT_TIMEOUT_MS = 3000000U; // 3000s
    constexpr uint32_t WAITFOR_INTERVAL = 30000U; // 单位毫秒
    constexpr uint32_t FPGA_WAITFOR_INTERVAL = 300000U; // 单位毫秒
}

namespace tsd {
    std::map<uint64_t, std::shared_ptr<HdcClient>> HdcClient::hdcClientMap_;
    std::recursive_mutex HdcClient::mutexForhdcClientMap_;
    /**
    * @ingroup HdcClient
    * @brief HdcClient构造函数
    */
    HdcClient::HdcClient(const uint32_t devId, const HDCServiceType hdcType)
        : HdcCommon(),
          hdcClient_(nullptr),
          deviceId_(devId),
          type_(hdcType),
          index_(KeyCompose(devId, hdcType)),
          isClientClose_(true),
          hostPid_(0U)
    {
        sessionIdNumVec_.reserve(static_cast<size_t>(HDC_CLIENT_DEFAULT_MAX_SESSION_NUM));
        for (uint32_t i = HDC_CLIENT_DEFAULT_MAX_SESSION_NUM; i >= 1U; i--) {
            sessionIdNumVec_.push_back(i);
        }
    }

    /**
    * @ingroup HdcClient
    * @brief 静态函数，获得单例类实例
    * @param [in] devId : 建立连接的Device设备ID
    * @param [in] type : 建立的连接类型
    * @return  HdcClient单例类实例
    */
    std::shared_ptr<HdcClient> HdcClient::GetInstance(const uint32_t devId, const HDCServiceType hdcType)
    {
        // 校验Client端，device ID范围[0-128]
        if (devId >= MAX_DEVNUM_PER_HOST) {
            TSD_ERROR("deviceId=%u is not supported, not in [0-128]", devId);
            return nullptr;
        }
        uint64_t hdcIndex = KeyCompose(devId, hdcType);
        std::shared_ptr<HdcClient> hdcClientPtr = nullptr;
        {
            const std::lock_guard<std::recursive_mutex> lk(mutexForhdcClientMap_);
            const auto iter = hdcClientMap_.find(hdcIndex);
            if (iter != hdcClientMap_.end()) {
                hdcClientPtr = iter->second;
            } else {
                hdcClientPtr.reset(new(std::nothrow)HdcClient(devId, hdcType));
                TSD_CHECK((hdcClientPtr != nullptr), nullptr, "Fail to create hdcClientPtr");
                (void)hdcClientMap_.insert(std::make_pair(hdcIndex, hdcClientPtr));
            }
        }
        return hdcClientPtr;
    }

    /**
    * @ingroup HdcClient
    * @brief 初始化函数，建立hdcclient
    * @return TSD_OK : 成功，other：TDT错误码
    */
    TSD_StatusT HdcClient::InitPre()
    {
        if (isClientClose_) {
            uint32_t tryNum = 0U;
            const drvHdcServiceType drvType = HDC_SERVICE_TYPE_TSD;
            while ((drvHdcClientCreate(&hdcClient_, static_cast<int32_t>(HDC_CLIENT_DEFAULT_MAX_SESSION_NUM), drvType,
                static_cast<int32_t>(HDC_RESERVE_VALUE))) != DRV_ERROR_NONE) {
                if (tryNum >= HDC_CLIENT_RETRY_MAX_NUM) {
                    TSD_ERROR("deviceId=%u,drvtype=%u,hdcclient failed", deviceId_, drvType);
                    return TSD_HDC_CLIENT_INIT_ERROR;
                }
                ++tryNum;
                (void)mmSleep(HDC_CLIENT_RETRY_WAIT_TIMEOUT);
            }
            isClientClose_ = false;
        }
        return TSD_OK;
    }

    /**
    * @ingroup HdcClient
    * @brief 初始化函数，建立hdcclient
    * @return TSD_OK : 成功，other：TDT错误码
    */
    TSD_StatusT HdcClient::Init(const uint32_t clientPid, const bool isAdcEnv)
    {
        hostPid_ = clientPid;
        TSD_StatusT tdtRet = InitPre();
        TSD_CHECK(tdtRet == TSD_OK, tdtRet, "hdc client init pre failed");
        tdtRet = InitMsgSize();
        if (tdtRet != TSD_OK) {
            TSD_ERROR("initMsgSize() fail");
            return TSD_HDC_CLIENT_INIT_ERROR;
        }
        isAdcEnv_ = isAdcEnv;
        return tdtRet;
    }

    /**
     * @ingroup HdcClient
     * @brief 普通数据接收线程
     * @param [in] sessionId ：某个连接sessionId
     */
    TSD_StatusT HdcClient::TsdRecvData(const uint32_t sessionId, const bool ignoreRecvErr, const uint32_t timeout)
    {
        HDCMessage hdcMsg;
        TSD_StatusT recvResult = TSD_OK;
        if (IsFpgaEnv()) {
            recvResult = RecvMsg(sessionId, hdcMsg, FPGA_HDC_CLIENT_WAIT_TIMEOUT_MS, true);
        } else {
            uint32_t normalTimeout = HDC_CLIENT_WAIT_TIMEOUT_MS + OPEN_PKT_DEL_WAIT_TIMEOUT_MS;
            if (timeout != 0U) {
                normalTimeout = timeout;
            }

            TSD_INFO("recv timeout is:%u ms", normalTimeout);
            recvResult = RecvMsg(sessionId, hdcMsg, normalTimeout, true);
        }
        if (recvResult != TSD_OK) {
            if (ignoreRecvErr) {
                TSD_RUN_INFO("recv msg result:%u is not TSD_OK", recvResult);
            } else {
                TSD_CHECK_NO_RETURN_RUNINFO_LOG(recvResult != TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED,
                                              "recv no msg by socket closed");
                TSD_CHECK_NO_RETURN(recvResult == TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED,
                                    "[deviceId=%u][sessionId=%u] recv msg failed",
                                    deviceId_, sessionId);
            }
            return recvResult;
        }

        hdcMsg.set_device_id(deviceId_); // 回传时填写的DEVICEID用创建时的补充
        MessageParseClient::GetInstance()->ProcessMessage(sessionId, hdcMsg);
        TSD_INFO("[deviceId=%u] the Tsd recv data already", deviceId_);
        return TSD_OK;
    }


    /**
     * @ingroup HdcClient
     * @brief 创建连接
     * @return TSD_OK:成功 或者其他错误码
     */
    TSD_StatusT HdcClient::CreateHdcSession(uint32_t& sessionId)
    {
        TSD_INFO("HdcClient::CreateHdcSession Start");
        if (isClientClose_) {
            TSD_ERROR("hdc client has been closed");
            return TSD_HDC_CLIENT_CLOSED;
        }
        if (sessionIdNumVec_.empty()) {
            TSD_ERROR("the connect session is greater than %u", HDC_CLIENT_DEFAULT_MAX_SESSION_NUM);
            return TSD_HDCSESSIONID_NOT_AVAILABLE;
        }
        HDC_SESSION session = nullptr;
        hdcError_t retVal;
        {
            const std::lock_guard<std::mutex> lk(mutextForHdcFreeMemoryMap_);
            retVal = drvHdcSessionConnect(0, static_cast<int32_t>(deviceId_), hdcClient_, &session);
        }
        if (retVal != DRV_ERROR_NONE) {
            TSD_ERROR("deviceId: %u drvHdcSessionConnect failed, ret = %d",
                deviceId_, retVal);
            if ((retVal == DRV_ERROR_REPEATED_INIT) || (retVal == DRV_ERROR_REMOTE_NOT_LISTEN)) {
                return retVal;
            }
            return TSD_HDC_CREATE_SESSION_FAILED;
        }

        TSD_INFO("[HdcClient] deviceId: %u connect session", deviceId_);

        const hdcError_t ret = drvHdcSetSessionReference(session);
        if (ret != DRV_ERROR_NONE) {
            TSD_ERROR("deviceId: %u drvHdcSetSessionReference failed, "
                "need to close session, ret = %d", deviceId_, ret);
            if (drvHdcSessionClose(session) != DRV_ERROR_NONE) {
                TSD_ERROR("HdcClient::Destroy the session failed");
            }
            return TSD_SET_HDCSESSION_REFERENCE_FAILED;
        }
        TSD_INFO("[HdcClient] drvHdcSetSessionReference success");

        {
            // sessionIdNumVec_和hdcClientSessionMap_共用一把锁
            const std::lock_guard<std::recursive_mutex> lk(mutextForClientSessionMap_);
            sessionId = sessionIdNumVec_.back();
            sessionIdNumVec_.pop_back();
            hdcClientSessionMap_[sessionId] = session;
            hdcClientVerifyMap_[sessionId] = MakeVersionVerifyNoThrow();
        }
        TSD_INFO("[HdcClient] deviceId: %u connect session and drvHdcSetSessionReference success, sessionId=%u",
            deviceId_, sessionId);
        if (CheckHdcConnection(sessionId) != TSD_OK) {
            return TSD_HDC_RECV_MSG_ERROR;
        }
        return TSD_OK;
    }

    TSD_StatusT HdcClient::CheckHdcConnection(const uint32_t& sessionId)
    {
        HDCMessage hdcMsg;
        ProcessSignPid * const proSignPid = hdcMsg.mutable_proc_sign_pid();
        if (proSignPid == nullptr) {
            return TSD_INTERNAL_ERROR;
        }
        proSignPid->set_proc_pid(hostPid_);
        hdcMsg.set_type(HDCMessage::TEST_HDC_SEND);
        std::shared_ptr<VersionVerify> inspector = nullptr;
        (void)GetVersionVerify(sessionId, inspector);
        TSD_CHECK_NULLPTR(inspector, TSD_HDC_RECV_MSG_ERROR, "no VersionVerify available");
        inspector->SetVersionInfo(hdcMsg);
        const TSD_StatusT ret = SendMsg(sessionId, hdcMsg);
        if (ret != TSD_OK) {
            TSD_ERROR("SendMsg Failed, SendPidMsg sessionId=%u", sessionId);
            return ret;
        }
        TSD_StatusT recvResult = TSD_OK;
        if (IsFpgaEnv()) {
            recvResult = RecvMsg(sessionId, hdcMsg, FPGA_WAITFOR_INTERVAL, true);
        } else {
            recvResult = RecvMsg(sessionId, hdcMsg, WAITFOR_INTERVAL, true);
        }

        if (recvResult != TSD_OK) {
            TSD_CHECK_NO_RETURN_RUNINFO_LOG(recvResult != TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED,
                                          "recv no msg by socket closed");
            TSD_CHECK_NO_RETURN(recvResult == TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED,
                                "[deviceId=%u][sessionId=%u] recv msg failed", deviceId_, sessionId);
            return recvResult;
        }
        if (hdcMsg.type() != HDCMessage::TEST_HDC_RSP) {
            TSD_INFO("Service[%u] create hdc not success", static_cast<uint32_t>(type_));
            return TSD_HDC_RECV_MSG_ERROR;
        }
        TSD_CHECK(inspector->PeerVersionCheck(hdcMsg.version_info()), TSD_HDC_RECV_MSG_ERROR,
                  "client and server version is inconsistent, you need to update your software");
        TSD_RUN_INFO("Service[%u] create hdc successfully.", static_cast<uint32_t>(type_));
        return TSD_OK;
    }

    /**
     * @ingroup HdcClient
     * @brief 根据sessionId获取 hdcsession
     * @param [in] sessionId ： 某个连接sessionId
     * @param [out] session : session 会话
     * @return TSD_OK:成功 或者其他错误码
     */
    TSD_StatusT HdcClient::GetHdcSession(const uint32_t sessionId, HDC_SESSION& session)
    {
        const std::lock_guard<std::recursive_mutex> lk(mutextForClientSessionMap_);
        uint32_t localSessionId = sessionId;
        if ((!hdcClientSessionMap_.empty()) && (localSessionId == 0U)) {
            localSessionId = hdcClientSessionMap_.begin()->first;
        }
        const auto iter = hdcClientSessionMap_.find(localSessionId);
        if (iter == hdcClientSessionMap_.end()) {
            TSD_RUN_INFO("[TsdEVENT] HdcClient::GetHdcSession(): the %d session does not exist", localSessionId);
            return TSD_HDC_SESSION_DO_NOT_EXIST;
        }
        session = hdcClientSessionMap_[localSessionId];
        return TSD_OK;
    }

    TSD_StatusT HdcClient::GetVersionVerify(const uint32_t sessionId, std::shared_ptr<VersionVerify> &inspector)
    {
        const std::lock_guard<std::recursive_mutex> lk(mutextForClientSessionMap_);
        uint32_t localSessionId = sessionId;
        if ((!hdcClientSessionMap_.empty()) && (localSessionId == 0U)) {
            localSessionId = hdcClientSessionMap_.begin()->first;
        }

        const auto iter = hdcClientVerifyMap_.find(localSessionId);
        if (iter == hdcClientVerifyMap_.end()) {
            TSD_RUN_INFO("HdcServer::GetVersionVerify(): the %u VersionVerify does not exist", localSessionId);
            return TSD_HDC_SESSION_DO_NOT_EXIST;
        }
        inspector = iter->second;
        return TSD_OK;
    }

    TSD_StatusT HdcClient::GetHdcConctStatus(int32_t &hdcSessStat)
    {
        hdcSessStat = HDC_SESSION_STATUS_CONNECT;
        int32_t halVersion;
        drvError_t ret = halGetAPIVersion(&halVersion);
        if (ret != DRV_ERROR_NONE) {
            TSD_ERROR("Get driver api version failed, ret[%d].", static_cast<int32_t>(ret));
            return TSD_HDC_SESSION_STATUS_GET_FAILED;
        }
        if (halVersion > HDC_SOCKET_STATUS_GET_VERSION) {
            const std::lock_guard<std::recursive_mutex> lkSessionMap(mutextForClientSessionMap_);
            for (auto iter = hdcClientSessionMap_.cbegin(); iter != hdcClientSessionMap_.cend(); iter++) {
                {
                    const std::lock_guard<std::mutex> lk(hdcSessionMutex_);
                    ret = halHdcGetSessionAttr(iter->second, HDC_SESSION_ATTR_STATUS, &hdcSessStat);
                }
                if (ret != DRV_ERROR_NONE) {
                    TSD_ERROR("halHdcGetSessionStatus failed, ret[%d].", ret);
                    return TSD_HDC_SESSION_STATUS_GET_FAILED;
                }
                if (hdcSessStat == HDC_SESSION_STATUS_CLOSE) {
                    auto const sessionId = iter->first;
                    TSD_RUN_INFO("Hdc socket close, sessionId[%u].", sessionId);
                    (void)hdcClientVerifyMap_.erase(sessionId);
                    (void)drvHdcSessionClose(iter->second);
                    sessionIdNumVec_.push_back(sessionId);
                    (void)hdcClientSessionMap_.erase(iter);
                    return TSD_OK;
                }
            }
        }
        return TSD_OK;
    }

     /**
     * @ingroup HdcClient
     * @brief 关闭所有会话
     */
    void HdcClient::ClearAllSession()
    {
        const std::lock_guard<std::recursive_mutex> lk(mutextForClientSessionMap_);
        hdcClientVerifyMap_.clear();
        for (auto iter = hdcClientSessionMap_.begin(); iter != hdcClientSessionMap_.end(); iter++) {
            if (drvHdcSessionClose(iter->second) != DRV_ERROR_NONE) {
                TSD_ERROR("HdcClient::Destroy the %u session failed", iter->first);
            } else {
                sessionIdNumVec_.push_back(iter->first);
            }
        }
        hdcClientSessionMap_.clear();
    }

    /**
     * @ingroup HdcClient
     * @brief 从hdcClientMap里面删除hdcclient指针
     */
    void HdcClient::ClearClientPtr()
    {
        TSD_INFO("begin HdcClient::ClearClientPtr");
        const std::lock_guard<std::recursive_mutex> lk(mutexForhdcClientMap_);
        const auto iter = hdcClientMap_.find(index_);
        if (iter == hdcClientMap_.end()) {
            TSD_ERROR("delete the %lu hdcClientPtr from hdcClientMap_ failed", index_);
            return;
        }
        (void)hdcClientMap_.erase(iter);
        TSD_INFO("end HdcClient::ClearClientPtr");
    }

    /**
    * @ingroup HdcClient
    * @brief 销毁HDC CLIENT
    */
    void HdcClient::DestroyClient()
    {
        TSD_INFO("begin drvHdcClientDestroy");
        const hdcError_t retVal = drvHdcClientDestroy(hdcClient_);
        if (retVal != DRV_ERROR_NONE) {
            TSD_ERROR("drvHdcClientDestroy() return %d", retVal);
        }
        TSD_INFO("end drvHdcClientDestroy");
        isClientClose_ = true;
    }

    /**
    * @ingroup HdcClient
    * @brief 关闭HDC连接，消耗相关资源
    * @param 无
    * @return TSD_OK:成功 或者其他错误码
    */
    void HdcClient::Destroy()
    {
        TSD_INFO("enter HdcClient::Destroy() function");
        if (!isClientClose_) {
            const std::lock_guard<std::mutex> lk(mutextForHdcFreeMemoryMap_);
            ClearAllSession();
            DestroyClient();
            ClearClientPtr();
            isClientClose_ = true;
            TSD_INFO("end HdcClient::Destroy() function");
        }
    }

    /**
    * @ingroup HdcCommon
    * @brief 虚函数 GetDeviceId 获得设备ID
    * return 设备ID
    */
    uint32_t HdcClient::GetDeviceId() const
    {
        return deviceId_;
    }

    /**
    * @ingroup HdcCommon
    * @brief   纯虚函数 GetHdcServiceType 获得 HdcServiceType
    * return HdcServiceType
    */
    HDCServiceType HdcClient::GetHdcServiceType() const
    {
        return type_;
    }

    /**
    * @ingroup HdcClient
    * @brief 析构函数
    */
    HdcClient::~HdcClient() {}
} // namespace tsd
