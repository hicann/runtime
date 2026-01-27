/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TDT_DEVICE_INNER_INC_HDC_SERVER_H
#define TDT_DEVICE_INNER_INC_HDC_SERVER_H

#include <iostream>
#include <thread>
#include <memory>
#include "proto/tsd_message.pb.h"
#include "mmpa/mmpa_api.h"
#include "inc/hdc_common.h"

namespace tsd {
    class HdcServer : public HdcCommon {
    public:
        /**
        * @ingroup HdcServer
        * @brief hdcServer 根据devId和type获得单例类实例
        * param [in] devId : 设备device ID
        * param [in] hdcType : 服务类型 HDC Server Type
        * @return  hdcServer单例类实例
        */
        static std::shared_ptr<HdcServer> GetInstance(const uint32_t devId, const HDCServiceType hdcType);

        /**
        * @ingroup HdcServer
        * @brief 初始化函数
        * @return TSD_OK:成功，或者其他错误码
        */
        TSD_StatusT Init(const bool isAdcEnv);

        /**
        * @ingroup HdcServer
        * @brief 关闭HDC连接，消耗相关资源
        * @param 无
        * @return TSD_OK:成功 或者其他错误码
        */
        TSD_StatusT Destroy();

        /**
        * @ingroup HdcServer
        * @param [in] sessionId ： 某个连接sessionId
        * @brief 关闭某个会话
        */
        void ClearSingleSession(const uint32_t sessionId);

        /**
         * @ingroup HdcServer
         * @brief 根据sessionId获取versionVerify
         * @param [in] sessionId : session通道对应的版本校验
         * @return shared_ptr<VersionVerify> : 版本校验对象指针
         */
        TSD_StatusT GetVersionVerify(const uint32_t sessionId, std::shared_ptr<VersionVerify> &inspector) override;

        /**
         * @ingroup HdcServer
         * @brief 根据sessionId获取 vfId
         * @param [in] sessionId ： 某个连接sessionId
         * @param [out] vfId : vf Id用来区分不同租户
         * @return TSD_OK:成功 或者其他错误码
         */
        TSD_StatusT GetHdcVfId(const uint32_t sessionId, int32_t &vfId);

        /**
         * @ingroup HdcServer
         * @brief 根据sessionId获取 hdcsession
         * @param [in] sessionId ： 某个连接sessionId
         * @param [out] session : session 会话
         * @return TSD_OK:成功 或者其他错误码
         */
        TSD_StatusT GetHdcSession(const uint32_t sessionId, HDC_SESSION& session) override;

        /**
        * @ingroup HdcServer
        * @brief 析构函数
        */
        ~HdcServer() override;

        bool IsAbnormalExit() const
        {
            return isAbnormalExit_;
        }
        bool IsOccurOOM(const uint32_t sessionId) const;

        bool GetAITypeNumaId(std::vector<uint32_t> &nodeListVec) const;

        /**
         * @ingroup HdcServer
         * @brief 关闭所有会话
         */
        void ClearAllSession();
    private:
        /**
        * @ingroup HdcServer
        * @brief HdcServer构造函数
        * param [in] devId : 设备device ID
        * param [in] type : 服务类型 HDC Server Type
        */
        HdcServer(const uint32_t devId, const HDCServiceType hdcType);
        /**
         * @ingroup HdcServer
         * @brief 监听连接
         * @param [out] sessionId : 会话ID
         * @return TSD_OK:成功 或者其他错误码
         */
        TSD_StatusT AcceptHdcSession(uint32_t& sessionId);
        /**
         * @ingroup HdcServer
         * @brief accept 线程
         * @return TSD_OK:成功 或者其他错误码
         */
        TSD_StatusT Accept();
        /**
         * @ingroup HdcServer
         * @brief accept 线程开关
         */
        void SetAcceptSwitch(const bool acceptMode);
        /**
         * @ingroup HdcServer
         * @brief recv 线程开关
         */
        void SetRunSwitch(const bool runStatus);

        /**
         * @ingroup HdcServer
         * @brief 普通数据接收线程
         *  @param [in] sessionId ： 某个连接sessionId
         */
        void RecvData(const uint32_t sessionId);
        /**
         * @ingroup HdcServer
         * @brief join accept 线程
         */
        void JoinAcceptThread();
        /**
         * @ingroup HdcServer
         * @brief join recv 线程
         */
        void JoinAllRecvThread();
        /**
         * @ingroup HdcServer
         * @brief 清空 recv线程 vector
         */
        void ClearAll();
        /**
         * @ingroup HdcServer
         *  @param [in] sessionId ： 某个连接sessionId
         * @brief 清空某个会话的pid值
         */
        void ClearPidBySessionId(const uint32_t sessionId);
        /**
         * @ingroup HdcServer
         * @brief tdtMainPid_,sessionIdForPid_重新赋初值
         */
        void ClearSessionIdPid();
        /**
         * @ingroup HdcServer
         * @brief 从hdcServerMap里面删除hdcsever指针
         */
        void ClearServerPtr();

        /**
        * @ingroup HdcServer
        * @brief 销毁HDC SERVER
        */
        void DestroyServer();
        /**
         * @ingroup HdcServer
         *  @param [in] sessionId ： 某个连接sessionId
         * @brief 退出该session的recv线程
         */
        void ClearRecvSession(const uint32_t sessionId);

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
        * @ingroup HdcCommon
        * @brief 获取client标签
        * return client标签
        */
        bool GetClientFlag() const override
        {
            return false;
        }

        HdcServer(const HdcServer&) = delete;
        HdcServer(HdcServer&&) = delete;
        HdcServer& operator=(const HdcServer&) = delete;
        HdcServer& operator=(HdcServer&&) = delete;

    private:
        std::atomic<int32_t> tdtMainPid_;
        // HDC 父连接
        HDC_SERVER  hdcServer_;
        // sessionId和hdcSession的Map
        std::map<uint32_t, HDC_SESSION> hdcServerSessionMap_;
        // sessionId和versionVerify的Map
        std::map<uint32_t, std::shared_ptr<VersionVerify>> hdcServerVerifyMap_;
        // sessionId和hdcSession的Map的锁
        std::recursive_mutex mutextForServerSessionMap_;
        // 维护可用sessionId number
        std::vector<uint32_t> sessionIdNumVec_;
        // 可用sessionId number的锁
        std::mutex mutextForsessionIdNumVec_;
        // deviceTd、type和HdcServer指针对象的Map
        static std::map<uint64_t, std::shared_ptr<HdcServer>> hdcServerMap_;
        // deviceTd、type和HdcServer指针对象的Map的锁
        static std::recursive_mutex mutextForHdcServerMap_;
        // 设备 ID
        uint32_t deviceId_;
        // 服务类型
        HDCServiceType type_;
        // 设备ID和服务类型的组合数
        uint64_t index_;
        std::atomic<uint32_t> sessionIdForPid_;

        // 接收线程开关
        volatile bool recvRunSwitch_;
        // accept 线程开关
        volatile bool acceptSwitch_;
        // 存储接收线程
        std::thread acceptThread_;
        // sessionID 和 recvThread map的锁
        std::recursive_mutex mutextForThreadSessionIDmap_;

        // sessionID 和 recvThread map
        std::multimap<uint32_t, std::thread> threadSessionIDmap_;
        // Server连接状态
        bool isServerClose_;
        // 是否已经异常退出
        std::atomic<bool> isAbnormalExit_;
    };
}
#endif  // TDT_DEVICE_INNER_INC_HDC_SERVER_H
