/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_BASIC_COMPONENT_DEVICE_COMM_TSD_HDC_CLIENT_H
#define TSD_BASIC_COMPONENT_DEVICE_COMM_TSD_HDC_CLIENT_H

#include <map>
#include <list>
#include <string>
#include <memory>

#include "proto/tsd_message.pb.h"
#include "device_comm.h"
#include "tsd_hdc_common.h"
#include "inc/tsd_message_parse_client.h"

namespace tsd {
    constexpr uint32_t HDC_CLIENT_WAIT_TIMEOUT_MS = 30000U; // 30s
    constexpr uint32_t OPEN_PKT_DEL_WAIT_TIMEOUT_MS = 120000U; // 120s
    class HdcClient : public DeviceComm {
    public:
        /**
        * @ingroup HdcClient
        * @brief HdcClient构造函数
        * param [in] devId : 设备device ID
        */
        explicit HdcClient(const uint32_t devId);

        /**
        * @ingroup HdcClient
        * @brief 初始化预处理函数
        * @return TSD_OK:成功，或者其他错误码
        */
        TSD_StatusT InitPre();

        /**
        * @ingroup HdcClient
        * @brief 初始化函数
        * @return TSD_OK:成功，或者其他错误码
        */
        TSD_StatusT CommInit(const uint32_t clientPid, const bool isAdcEnv) override;

        /**
         * @ingroup HdcClient
         * @brief 创建连接
         * @param [out] sessionId : 会话ID
         * @return TSD_OK:成功 或者其他错误码
         */
        TSD_StatusT CommCreateSession(uint32_t& sessionId) override;

        /**
        * @ingroup HdcClient
        * @brief 关闭HDC连接，消耗相关资源
        * @param 无
        */
        void CommDestroy() override;

        /**
        * @ingroup HdcClient
        * @brief 普通数据接收线程
        * @param [in] sessionId ： 某个连接sessionId
        */
        TSD_StatusT CommRecvData(const uint32_t sessionId, const bool ignoreRecvErr = false,
                                 const uint32_t timeout = 0U) override;

        /**
        * @ingroup HdcClient
        * @brief 验证 HDC 连接通道可用性，通过握手消息确认 device 端连接正常
        * @param [in] sessionId ： 某个连接sessionId
        */
        TSD_StatusT CheckHdcConnection(const uint32_t& sessionId);

        TSD_StatusT CommGetVersionVerify(const uint32_t sessionId,
                                          std::shared_ptr<VersionVerify> &inspector) override;

        /**
        * @ingroup HdcClient
        * @brief Get hdc session status
        * @param [in] hdcSessStat ： hdc session status
        */
        TSD_StatusT CommGetConctStatus(int32_t &sessStat) override;

        /**
        * @ingroup HdcClient
        * @brief 析构函数
        */
        ~HdcClient() override;

        TSD_StatusT CommSendMsg(const uint32_t sessionId, const HDCMessage& msg) override;

    private:

        TSD_StatusT RecvMsg(const uint32_t sessionId, HDCMessage& msg, const uint32_t timeout);
        /**
         * @ingroup HdcClient
         * @brief 根据sessionId获取 hdcsession
         * @param [in] sessionId ： 某个连接sessionId
         * @param [out] session : session 会话
         * @return TSD_OK:成功 或者其他错误码
         */
        TSD_StatusT GetHdcSession(const uint32_t sessionId,  HDC_SESSION& session);

        /**
         * @ingroup HdcClient
         * @brief 从DeviceComm::deviceCommMap_里面删除当前实例指针
         */
        void ClearClientPtr();

         /**
         * @ingroup HdcClient
         * @brief 关闭所有会话
         */
        void ClearAllSession();

        /**
        * @ingroup HdcClient
        * @brief 销毁HDC CLIENT
        */
        void DestroyClient();

        uint32_t GetDeviceId() const;

        HdcClient(const HdcClient&) = delete;
        HdcClient(HdcClient&&) = delete;
        HdcClient& operator=(const HdcClient&) = delete;
        HdcClient& operator=(HdcClient&) = delete;
        HdcClient& operator=(HdcClient&&) = delete;

    private:
        // HDC 父连接
        HDC_CLIENT  hdcClient_;
        // sessionId和hdcSession的Map
        std::map<uint32_t, HDC_SESSION> hdcClientSessionMap_;
        // sessionId和versionVerify的Map
        std::map<uint32_t, std::shared_ptr<VersionVerify>> hdcClientVerifyMap_;
        // sessionId和hdcSession的Map的锁
        std::recursive_mutex mutextForClientSessionMap_;
        // hdc建立连接和释放的Map锁
        std::mutex mutextForHdcFreeMemoryMap_;
        // 维护可用sessionId number
        std::vector<uint32_t> sessionIdNumVec_;
        // Client连接状态
        bool isClientClose_;

        uint32_t hostPid_; // used for device confirm relation between sessionId and hostPid

        HdcCommon hdcCommon_;
    };
}
#endif  // TSD_BASIC_COMPONENT_DEVICE_COMM_TSD_HDC_CLIENT_H
