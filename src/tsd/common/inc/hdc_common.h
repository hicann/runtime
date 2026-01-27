/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef COMMON_COMMON_INC_HDC_COMMON_H
#define COMMON_COMMON_INC_HDC_COMMON_H

#include <functional>
#include <mutex>
#include <future>
#include "proto/tsd_message.pb.h"
#include "driver/ascend_hal.h"
#include "tsd/status.h"
#include "inc/basic_define.h"
#include "inc/version_verify.h"
#include "inc/log.h"

namespace tsd {
    // 返回给tsdclient的open/close确认码
    enum class ResponseCode {
        SUCCESS = 0,
        FAIL = 1
    };
    inline uint64_t KeyCompose(const uint32_t &devId, const HDCServiceType &type)
    {
        return ((static_cast<uint64_t>(devId)) << 32U) | (static_cast<uint64_t>(type));
    }

    class HdcCommon {
    public:
        /**
        * @ingroup HdcCommon
        * @brief   SendMsg 发送消息
        * @param   [in] : sessionId
        * @param   [in] msg:消息
        * return Status成功TSD_OK，失败：其他错误码
        */
        TSD_StatusT SendMsg(const uint32_t sessionId, const HDCMessage& msg, const bool isClose = false);

        /**
         * @ingroup HdcCommon
         * @brief 创建VersionVerify实例
         * @return  VersionVerify实例
         */
        std::shared_ptr<VersionVerify> MakeVersionVerifyNoThrow() const;

        /**
        * @ingroup HdcCommon
        * @brief   纯虚函数 GetHdcSession 获得HDC会话
        * @param   [in] sessionId : sessionId
        * @param   [out] session : 会话
        * return Status成功TSD_OK，失败：其他错误码
        */
        virtual TSD_StatusT GetHdcSession(const uint32_t sessionId, HDC_SESSION& session) = 0;

    protected:
        /**
        * @ingroup HdcCommon
        * @brief   RecvMsg 接收消息
        * @param   [in] session : deviceId
        * @param   [out] msg :消息
        * @param   [in] timeout : 超时时间
        * return Status成功TSD_OK，失败：其他错误码
        */
        TSD_StatusT RecvMsg(const uint32_t sessionId, HDCMessage& msg, const uint32_t timeout = 0U,
                            const bool waitFlag = true);

        /**
        * @ingroup HdcCommon
        * @brief 虚函数 GetDeviceId 获得设备ID
        * return 设备ID
        */
        virtual uint32_t GetDeviceId() const = 0;

        /**
        * @ingroup HdcCommon
        * @brief   纯虚函数 GetHdcServiceType 获得 HdcServiceType
        * return HdcServiceType
        */
        virtual HDCServiceType GetHdcServiceType() const = 0;

    protected:
        HdcCommon();
        virtual ~HdcCommon() = default;
        HdcCommon(const HdcCommon&) = delete;
        HdcCommon(HdcCommon&&) = delete;
        HdcCommon& operator=(const HdcCommon&) = delete;
        HdcCommon& operator=(HdcCommon&&) = delete;

        /**
        * @ingroup HdcCommon
        * @brief   InitMsgSize 初始化Msg长度
        * return Status成功TSD_OK，失败：其他错误码
        */
        TSD_StatusT InitMsgSize();

        /**
        * @ingroup HdcCommon
        * @brief   GetMsgMaxSize 获取msg最大长度
        * return msg最大长度
        */
        inline uint32_t GetMsgMaxSize() const
        {
            return msgMaxSize_;
        }

        /**
        * @ingroup HdcCommon
        * @brief   SendNormalMsg 发送普通消息
        * @param   [in] msg : 普通消息
        * @param   [int] session : 会话
        * return Status成功TSD_OK，失败：其他错误码
        */
        TSD_StatusT SendNormalMsg(const HDCMessage& msg, HDC_SESSION const session, const bool isClose);

        virtual TSD_StatusT GetVersionVerify(const uint32_t sessionId, std::shared_ptr<VersionVerify> &inspector) = 0;

        std::mutex hdcSessionMutex_;

        std::map<uint32_t, uint64_t> logPrintMap_;

        std::mutex logPrintMapMutex_;

        bool isAdcEnv_;

    private:
        /**
        * @ingroup HdcCommon
        * @brief   SendNormalShortMsg 获得普通的短消息
        * @param   [in] msg : 短消息
        * @param   [in] size :长度
        * @param   [in] session : 会话
        * return Status成功TSD_OK，失败：其他错误码
        */
        TSD_StatusT SendNormalShortMsg(const HDCMessage& msg, const uint32_t size,
                                    HDC_SESSION const session, const bool isClose);

        /**
        * @ingroup HdcCommon
        * @brief   Send 发送
        * @param   [in] session : 会话
        * @param   [in] hdcMsgBuf : 消息buffer
        * @param   [in] size : 消息buffer长度
        * return Status成功TSD_OK，失败：其他错误码
        */
        TSD_StatusT SendHdcDefaultMsg(HDC_SESSION const session, char_t * const hdcMsgBuf,
                                      const uint32_t size, const bool isClose);

        /**
        * @ingroup HdcCommon
        * @brief   print log
        * @param   [in] hdcRet : hdc错误码
        * @param   [int] status : hdc session status
        */
        void CheckHdcSessionPrintLog(const drvError_t hdcRet, const int32_t status);

        /**
        * @ingroup HdcCommon
        * @brief   Receive 接收
        * @param   [in] session : 会话
        * @param   [int] drvMsg : 驱动hdc消息
        * @param   [out] buffer : 解析后的buffer
        * @param   [out] bufferLengthOut : 解析后的buffer长度
        * @param   [in] timeout : 超时时长
        * return Status成功TSD_OK，失败：其他错误码
        */
        TSD_StatusT RecvHdcDefaultMsg(const HDC_SESSION& session, drvHdcMsg* drvMsg, char_t*& buffer,
                                      uint32_t& bufferLengthOut, const uint32_t timeout, const bool waitFlag);

        /**
        * @ingroup HdcCommon
        * @brief   GetClientFlag 获取client标签
        * return true：是client，false：不是client
        */
        virtual bool GetClientFlag() const = 0;

    private:
        std::mutex idMutex_;
        std::mutex idMcMutex_;
        uint32_t msgMaxSize_;
        uint32_t msgShortHeadDataMaxSize_;
        uint32_t msgLongHeadDataMaxSize_;
    };
}
#endif  // COMMON_COMMON_INC_HDC_COMMON_H
