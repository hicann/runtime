/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TDT_HOST_INNER_INC_HDC_CLIENT_H
#define TDT_HOST_INNER_INC_HDC_CLIENT_H

#include <map>
#include <list>
#include <string>
#include <memory>

#include "proto/tsd_message.pb.h"
#include "inc/hdc_common.h"
#include "inc/message_parse_client.h"

namespace tsd {
    constexpr uint32_t HDC_CLIENT_WAIT_TIMEOUT_MS = 30000U; // 30s
    constexpr uint32_t OPEN_PKT_DEL_WAIT_TIMEOUT_MS = 120000U; // 120s
    class HdcClient : public HdcCommon {
    public:
        /**
        * @ingroup HdcClient
        * @brief hdcClient 根据devId和type获得单例类实例
        * param [in] devId : 设备device ID
        * param [in] type : 服务类型 HDC Server Type
        * @return  hdcClient单例类实例
        */
        static std::shared_ptr<HdcClient> GetInstance(const uint32_t devId, const HDCServiceType hdcType);

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
        TSD_StatusT Init(const uint32_t clientPid, const bool isAdcEnv);

        /**
         * @ingroup HdcClient
         * @brief 创建连接
         * @param [out] sessionId : 会话ID
         * @return TSD_OK:成功 或者其他错误码
         */
        TSD_StatusT CreateHdcSession(uint32_t& sessionId);

        /**
        * @ingroup HdcClient
        * @brief 关闭HDC连接，消耗相关资源
        * @param 无
        */
        void Destroy();

        /**
        * @ingroup HdcCommon
        * @brief 虚函数 GetDeviceId 获得设备ID
        * return 设备ID
        */
        uint32_t GetDeviceId() const override;

        /**
        * @ingroup HdcCommon
        * @brief   纯虚函数 GetHdcServiceType 获得 HdcServiceType
        * return HdcServiceType
        */
        HDCServiceType GetHdcServiceType() const override;

        /**
        * @ingroup HdcClient
        * @brief 普通数据接收线程
        * @param [in] sessionId ： 某个连接sessionId
        */
        TSD_StatusT TsdRecvData(const uint32_t sessionId, const bool ignoreRecvErr = false,
                                const uint32_t timeout = 0U);

        /**
        * @ingroup HdcClient
        * @brief Test new session connection
        * @param [in] sessionId ： 某个连接sessionId
        */
        TSD_StatusT CheckHdcConnection(const uint32_t& sessionId);

        TSD_StatusT GetVersionVerify(const uint32_t sessionId, std::shared_ptr<VersionVerify> &inspector) override;

        /**
        * @ingroup HdcClient
        * @brief Get hdc session status
        * @param [in] hdcSessStat ： hdc session status
        */
        TSD_StatusT GetHdcConctStatus(int32_t &hdcSessStat);

        /**
        * @ingroup HdcClient
        * @brief 析构函数
        */
        ~HdcClient() override;

    private:
        /**
        * @ingroup HdcClient
        * @brief HdcClient构造函数
        * param [in] devId : 设备device ID
        * param [in] hdcType : 服务类型 HDC Server Type
        */
        HdcClient(const uint32_t devId, const HDCServiceType hdcType);

        /**
         * @ingroup HdcClient
         * @brief 根据sessionId获取 hdcsession
         * @param [in] sessionId ： 某个连接sessionId
         * @param [out] session : session 会话
         * @return TSD_OK:成功 或者其他错误码
         */
        TSD_StatusT GetHdcSession(const uint32_t sessionId,  HDC_SESSION& session) override;

        /**
         * @ingroup HdcClient
         * @brief 从hdcClientMap里面删除hdcclient指针
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

        /**
        * @ingroup HdcClient
        * @brief 获取client标签
        */
        bool GetClientFlag() const override
        {
            return true;
        }

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

        // deviceTd、type和HdcServer指针对象的Map
        static std::map<uint64_t, std::shared_ptr<HdcClient>> hdcClientMap_;
        // deviceTd、type和HdcServer指针对象的Map的锁
        static std::recursive_mutex mutexForhdcClientMap_;
        // 设备 ID
        uint32_t deviceId_;
        // 服务类型
        HDCServiceType type_;
        // 设备ID和服务类型的组合数
        uint64_t index_;
        // Client连接状态
        bool isClientClose_;

        uint32_t hostPid_; // used for device confirm relation between sessionId and hostPid
    };
}
#endif  // TDT_HOST_INNER_INC_HDC_CLIENT_H
