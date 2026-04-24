/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_BASIC_COMPONENT_DEVICE_COMM_HDC_COMMON_H
#define TSD_BASIC_COMPONENT_DEVICE_COMM_HDC_COMMON_H

#include <functional>
#include <mutex>
#include <future>
#include "proto/tsd_message.pb.h"
#include "driver/ascend_hal.h"
#include "tsd/status.h"
#include "inc/basic_define.h"
#include "inc/version_verify.h"
#include "log.h"

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
        * @brief   SendNormalMsg 发送普通消息
        * @param   [in] msg : 普通消息
        * @param   [int] session : 会话
        * return Status成功TSD_OK，失败：其他错误码
        */
        TSD_StatusT SendNormalMsg(const HDCMessage& msg, HDC_SESSION const session);

        /**
         * @ingroup HdcCommon
         * @brief 创建VersionVerify实例
         * @return  VersionVerify实例
         */
        std::shared_ptr<VersionVerify> MakeVersionVerifyNoThrow() const;

        /**
        * @ingroup HdcCommon
        * @brief   RecvMsg 接收消息
        * @param   [in] session : deviceId
        * @param   [out] msg :消息
        * @param   [in] timeout : 超时时间
        * return Status成功TSD_OK，失败：其他错误码
        */
        TSD_StatusT RecvMsg(HDC_SESSION session, HDCMessage& msg, const uint32_t timeout = 0U);

        TSD_StatusT GetHdcAttrStatus(HDC_SESSION session, int32_t &hdcSessStat);

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

        void SetAdcEnv(const bool isAdcEnv)
        {
            isAdcEnv_ = isAdcEnv;
        }
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
                                    HDC_SESSION const session);

        /**
        * @ingroup HdcCommon
        * @brief   Send 发送
        * @param   [in] session : 会话
        * @param   [in] hdcMsgBuf : 消息buffer
        * @param   [in] size : 消息buffer长度
        * return Status成功TSD_OK，失败：其他错误码
        */
        TSD_StatusT SendHdcDefaultMsg(HDC_SESSION const session, char_t * const hdcMsgBuf,
                                      const uint32_t size);


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
                                      uint32_t& bufferLengthOut, const uint32_t timeout);

    private:
        std::mutex hdcSessionMutex_;
        bool isAdcEnv_;
        uint32_t msgMaxSize_;
        uint32_t msgShortHeadDataMaxSize_;
        uint32_t msgLongHeadDataMaxSize_;
    };
}
#endif  // TSD_BASIC_COMPONENT_DEVICE_COMM_HDC_COMMON_H