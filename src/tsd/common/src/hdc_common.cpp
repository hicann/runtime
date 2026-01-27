/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/hdc_common.h"
#include <string>
#include <securec.h>
#include "inc/internal_api.h"
namespace tsd {
    namespace {
        // message head size
        constexpr uint32_t MAX_HEAP_BUFF_BYTE = 0x20000000U;

        // 保留的flag标记位，当前不适用，填0
        constexpr uint32_t HDC_DEFAULT_FLAG_VALUE(0U);

        // 收发消息中,默认的buf使用个数
        constexpr uint32_t HDC_DEFAULT_BUFF_COUNT(1U);

        // 获取接收消息的buff index，当前只有1个buff，固定为0
        constexpr uint32_t HDC_DEFAULT_BUFF_INDEX(0U);

        // 消息的头部各字段偏移（int32_t）
        constexpr uint32_t HDC_MSG_SEG_COUNT_OFFSET(1U);

        // 0: 非Image type 非0： Image Data
        constexpr uint32_t HDC_MSG_SIZE_OFFSET(2U);

        // 短头消息头部长度 12 字节
        // msg size(4) + seg count(4) + type size(4)
        constexpr uint32_t HDC_MSG_SHORT_HEAD_SIZE(12U);

        // 长头消息头部长度 24 字节
        // msg size(4) + seg count(4) + seg index(4)
        // + id(4) + total size(4) + type size(4)
        constexpr uint32_t HDC_MSG_LONG_HEAD_SIZE(24U);

        // halHdcSend接口超时时间
        constexpr uint32_t HDC_CLIENT_SEND_WAIT_TIMEOUT_MS = 150000U; // 150s
#ifndef tsd_UT
        // 校验hdc session状态日志打印间隔
        constexpr uint32_t HDC_SESSION_CHECK_PRINTLOG_INTERVAL_S = 1800U; // 30min
#else
        // 校验hdc session状态日志打印间隔ut
        constexpr uint32_t HDC_SESSION_CHECK_PRINTLOG_INTERVAL_S = 1U; // 1s
#endif
    }

    HdcCommon::HdcCommon()
        : isAdcEnv_(false),
          msgMaxSize_(0U),
          msgShortHeadDataMaxSize_(0U),
          msgLongHeadDataMaxSize_(0U) {}

    /**
    * @ingroup HdcCommon
    * @brief   InitMsgSize 初始化Msg长度
    * return Status成功TSD_OK，失败：其他错误码
    */
    TSD_StatusT HdcCommon::InitMsgSize()
    {
        TSD_INFO("HdcCommon::InitMsgSize Start");
        drvHdcCapacity drvHdcCapacityObj;
        const hdcError_t drvRet = drvHdcGetCapacity(&drvHdcCapacityObj);
        if ((drvRet != DRV_ERROR_NONE) || (drvHdcCapacityObj.maxSegment <= HDC_MSG_LONG_HEAD_SIZE)) {
            TSD_ERROR("drvHdcCapacityObj.maxSegment = %u bytes", drvHdcCapacityObj.maxSegment);
            return TSD_INTERNAL_ERROR;
        }

        msgMaxSize_ = drvHdcCapacityObj.maxSegment;

        msgShortHeadDataMaxSize_ = msgMaxSize_ - HDC_MSG_SHORT_HEAD_SIZE;
        msgLongHeadDataMaxSize_ = msgMaxSize_ - HDC_MSG_LONG_HEAD_SIZE;
        TSD_INFO("msgMaxSize_ = %u bytes, msgShortHeadDataMaxSize_ = %u bytes, msgLongHeadDataMaxSize_ = %u bytes",
            msgMaxSize_, msgShortHeadDataMaxSize_, msgLongHeadDataMaxSize_);
        return TSD_OK;
    }

    /**
    * @ingroup HdcCommon
    * @brief   SendNormalShortMsg 获得普通的短消息
    * @param   [in] msg : 短消息
    * @param   [in] size : 长度，上级调用保证size小于GetMsgShortHeadDataMaxSize
    * @param   [in] session : 会话
    * return Status成功TSD_OK，失败：其他错误码
    */
    TSD_StatusT HdcCommon::SendNormalShortMsg(const HDCMessage &msg, const uint32_t size,
                                              HDC_SESSION const session, const bool isClose)
    {
        if (size == 0U) {
            TSD_ERROR("SendNormalShortMsg cannot send msg when size = 0");
            return TSD_HDC_SEND_MSG_ERROR;
        }

        if (size > (MAX_HEAP_BUFF_BYTE - HDC_MSG_SHORT_HEAD_SIZE)) {
            TSD_ERROR("Message size[%u] must less than %u", size,
                      MAX_HEAP_BUFF_BYTE - HDC_MSG_SHORT_HEAD_SIZE);
            return TSD_INTERGER_REVERSED;
        }

        const uint32_t serialMsgSizeCur = HDC_MSG_SHORT_HEAD_SIZE + size;
        char_t *serializedMsg = new (std::nothrow) char_t[serialMsgSizeCur];
        if (serializedMsg == nullptr) {
            TSD_ERROR("Create serializedMsg failed.");
            return TSD_HDC_SEND_MSG_ERROR;
        }
        const ScopeGuard memoryGuard([&serializedMsg]() {
            delete[] serializedMsg;
            serializedMsg = nullptr;
        });
        if (memset_s(serializedMsg, static_cast<size_t>(serialMsgSizeCur), '\0',
                     static_cast<size_t>(serialMsgSizeCur)) != 0) {
            TSD_ERROR("Set memory for serializedMsg failed.");
            return TSD_HDC_SEND_MSG_ERROR;
        }
        *(PtrToPtr<char_t, uint32_t>(serializedMsg)) = size + HDC_MSG_SHORT_HEAD_SIZE;
        *(PtrToPtr<char_t, uint32_t>(serializedMsg) + HDC_MSG_SEG_COUNT_OFFSET) = 1U;
        *(PtrToPtr<char_t, uint32_t>(serializedMsg) + HDC_MSG_SIZE_OFFSET) = 0U;
        (void)msg.SerializePartialToArray(serializedMsg + HDC_MSG_SHORT_HEAD_SIZE, static_cast<int32_t>(size));
        const TSD_StatusT result = SendHdcDefaultMsg(session, serializedMsg, serialMsgSizeCur, isClose);
        if (result != TSD_OK) {
            TSD_CHECK_EQ_RETURN_RUNWARN_LOG(result == TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED,
                                            TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED, "halHdcSend return socket close");
            if (isClose && (result == DRV_ERROR_SEND_MESG)) {
                TSD_INFO("Send ret[%u]", result);
                return result;
            }
            TSD_CHECK_NO_RETURN(result == TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED,
                                "Send failed ret[%u]", result);
            return TSD_HDC_SEND_MSG_ERROR;
        }
        return TSD_OK;
    }

    /**
    * @ingroup HdcCommon
    * @brief   SendNormalMsg 发送普通消息
    * @param   [in] msg : 普通消息
    * @param   [int] session : 会话
    * return Status成功TSD_OK，失败：其他错误码
    */
    TSD_StatusT HdcCommon::SendNormalMsg(const HDCMessage& msg, HDC_SESSION const session, const bool isClose)
    {
        // 上层调用会打日志，比如扩缩
        const uint32_t size = static_cast<uint32_t>(msg.ByteSizeLong());  // msg length
        return SendNormalShortMsg(msg, size, session, isClose);
    }

    /**
    * @ingroup HdcCommon
    * @brief   SendMsg 发送消息
    * @param   [in] sessionId : 发送连接唯一标识
    * @param   [in] msg : 消息体
    * return Status成功TSD_OK，失败：其他错误码
    */
    TSD_StatusT HdcCommon::SendMsg(const uint32_t sessionId, const HDCMessage& msg, const bool isClose)
    {
        HDC_SESSION session = nullptr;
        const TSD_StatusT ret = GetHdcSession(sessionId, session);
        if (ret != TSD_OK) {
            TSD_RUN_WARN("GetHdcSession not success ret[%d]", ret);
            return TSD_HDC_SEND_MSG_ERROR;
        }
        // check client and server feature_list
        std::shared_ptr<VersionVerify> inspector = nullptr;
        (void)GetVersionVerify(sessionId, inspector);
        TSD_CHECK_NULLPTR(inspector, TSD_HDC_RECV_MSG_ERROR, "VersionVerify does not exist.");
        TSD_CHECK(inspector->SpecialFeatureCheck(msg.type()), TSD_HDC_RECV_MSG_ERROR,
                  "client and server feature_list is inconsistent, you need to update your software.");
        return SendNormalMsg(msg, session, isClose);
    }

    /**
    * @ingroup HdcCommon
    * @brief   Send 发送
    * @param   [in] session : 会话连接信息
    * @param   [in] hdcMsgBuf : 消息buffer
    * @param   [in] size : 消息buffer长度
    * return Status成功TSD_OK，失败：其他错误码
    */
    TSD_StatusT HdcCommon::SendHdcDefaultMsg(HDC_SESSION const session, char_t * const hdcMsgBuf,
                                             const uint32_t size, const bool isClose)
    {
        drvHdcMsg* drvMsg = nullptr;
        hdcError_t drvRet = drvHdcAllocMsg(session, &drvMsg, static_cast<int32_t>(HDC_DEFAULT_BUFF_COUNT));
        if (drvMsg == nullptr) {
            TSD_ERROR("drvHdcAllocMsg failed ret[%d]", drvRet);
            return TSD_HDC_SEND_ERROR;
        }

        drvRet = drvHdcAddMsgBuffer(drvMsg, hdcMsgBuf, static_cast<int32_t>(size));
        if (drvRet != DRV_ERROR_NONE) {
            TSD_ERROR("drvHdcAddMsgBuffer failed ret[%d]", drvRet);
            drvRet = drvHdcFreeMsg(drvMsg);
            TSD_CHECK_NO_RETURN(drvRet == DRV_ERROR_NONE,
                                "drvHdcFreeMsg failed ret[%d]", drvRet);
            return TSD_HDC_SEND_ERROR;
        }

        if (GetClientFlag()) {
            const std::lock_guard<std::mutex> lk(hdcSessionMutex_);
            drvRet = halHdcSend(session, drvMsg, static_cast<uint64_t>(HDC_FLAG_WAIT_TIMEOUT),
                                HDC_CLIENT_SEND_WAIT_TIMEOUT_MS);
        } else {
            drvRet = halHdcSend(session, drvMsg, HDC_DEFAULT_FLAG_VALUE, 0U);
        }
        if (drvRet != DRV_ERROR_NONE) {
            const hdcError_t drvRetTmp = drvHdcFreeMsg(drvMsg);
            TSD_CHECK_NO_RETURN(drvRetTmp == DRV_ERROR_NONE,
                                "drvHdcFreeMsg failed ret[%d]", drvRetTmp);
            TSD_CHECK_EQ_RETURN_RUNWARN_LOG(drvRet == DRV_ERROR_SOCKET_CLOSE,
                TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED, "halHdcSend return socket close");
            if (isClose && (drvRet == DRV_ERROR_SEND_MESG)) {
                TSD_INFO("halHdcSend ret[%d]", drvRet);
                return drvRet;
            }
            TSD_CHECK_NO_RETURN(drvRet == DRV_ERROR_SOCKET_CLOSE,
                                "halHdcSend failed ret[%d]", drvRet);
            return TSD_HDC_SEND_ERROR;
        }

        drvRet = drvHdcFreeMsg(drvMsg);
        if (drvRet != DRV_ERROR_NONE) {
            TSD_ERROR("drvHdcFreeMsg failed ret[%d]", drvRet);
            return TSD_HDC_SEND_ERROR;
        }
        return TSD_OK;
    }

    /**
    * @ingroup HdcCommon
    * @brief   RecvMsg 接收消息
    * @param   [in] session : 会话连接唯一标识
    * @param   [out] msg :消息
    * return Status成功TSD_OK，失败：其他错误码
    */
    TSD_StatusT HdcCommon::RecvMsg(const uint32_t sessionId, HDCMessage& msg, const uint32_t timeout,
                                   const bool waitFlag)
    {
        HDC_SESSION session = nullptr;
        TSD_StatusT ret = GetHdcSession(sessionId, session);
        if (ret != TSD_OK) {
            TSD_RUN_WARN("[TsdEVENT] GetHdcSession not success ret[%d]", ret);
            return TSD_HDC_RECV_MSG_ERROR;
        }

        drvHdcMsg* hdcMsg = nullptr;
        hdcError_t drvRet = drvHdcAllocMsg(session, &hdcMsg, static_cast<int32_t>(HDC_DEFAULT_BUFF_COUNT));
        if (hdcMsg == nullptr) {
            TSD_ERROR("drvHdcAllocMsg failed ret[%d]", drvRet);
            return TSD_HDC_RECV_MSG_ERROR;
        }
        char_t *tempBuf = nullptr;
        uint32_t bufferLengthOut = 0U;
        // 此处是hiaiengine中hdc代码移植过来，去除了长消息发送功能
        ret = RecvHdcDefaultMsg(session, hdcMsg, tempBuf, bufferLengthOut, timeout, waitFlag);
        if ((ret != TSD_OK) || (tempBuf == nullptr) || (bufferLengthOut < HDC_MSG_SHORT_HEAD_SIZE)) {
            TSD_WARN("Receive not success ret[%d], bufferLengthOut[%u]", ret, bufferLengthOut);
        } else {
            (void)msg.ParseFromArray(tempBuf + HDC_MSG_SHORT_HEAD_SIZE,
                static_cast<int32_t>(bufferLengthOut) - static_cast<int32_t>(HDC_MSG_SHORT_HEAD_SIZE));
        }
        drvRet = drvHdcFreeMsg(hdcMsg);
        if (drvRet != DRV_ERROR_NONE) {
            TSD_ERROR("drvHdcFreeMsg failed ret[%d]", drvRet);
            return TSD_HDC_RECV_MSG_ERROR;
        }
        return  ret;
    }

    void HdcCommon::CheckHdcSessionPrintLog(const drvError_t hdcRet, const int32_t status)
    {
        const int32_t tid = mmGetTid();
        if (tid >= 0) {
            const std::lock_guard<std::mutex> lk(logPrintMapMutex_);
            if (logPrintMap_[tid] == 0) {
                logPrintMap_[tid] = GetCurrentTime();
            } else {
                if ((GetCurrentTime() - logPrintMap_[tid]) >= HDC_SESSION_CHECK_PRINTLOG_INTERVAL_S * S_TO_NS) {
                    TSD_RUN_INFO("get remote session attr, ret[%d], status[%d]", hdcRet, status);
                    logPrintMap_[tid] = GetCurrentTime();
                }
            }
        }
    }

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
    TSD_StatusT HdcCommon::RecvHdcDefaultMsg(const HDC_SESSION& session, drvHdcMsg* drvMsg, char_t*& buffer,
                                             uint32_t& bufferLengthOut, const uint32_t timeout, const bool waitFlag)
    {
        int32_t recvBufCounter = 0;
        int32_t receivedLenEachTime = 0;
        hdcError_t drvRet = DRV_ERROR_NONE;
        if (GetClientFlag()) {
            const std::lock_guard<std::mutex> lk(hdcSessionMutex_);
            drvRet = halHdcRecv(session, drvMsg, static_cast<int32_t>(GetMsgMaxSize()),
                static_cast<uint64_t>(HDC_FLAG_WAIT_TIMEOUT), &recvBufCounter, timeout);
        } else {
            if (waitFlag) {
                drvRet = halHdcRecv(session, drvMsg, static_cast<int32_t>(GetMsgMaxSize()),
                    HDC_DEFAULT_FLAG_VALUE, &recvBufCounter, 0U);
            } else {
                int32_t status = HDC_SESSION_STATUS_CONNECT;
                do {
                    drvRet = halHdcRecv(session, drvMsg, static_cast<int32_t>(GetMsgMaxSize()),
                        static_cast<uint64_t>(HDC_FLAG_NOWAIT), &recvBufCounter, timeout);
                    if (drvRet == DRV_ERROR_NON_BLOCK) {
                        const drvError_t hdcRet = halHdcGetSessionAttr(session, HDC_SESSION_ATTR_STATUS, &status);
                        if ((hdcRet == DRV_ERROR_NONE) && (status == HDC_SESSION_STATUS_CLOSE)) {
                            TSD_RUN_INFO("get remote session attr close");
                            return TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED;
                        } else {
                            CheckHdcSessionPrintLog(hdcRet, status);
                        }
                    }
                } while (drvRet == DRV_ERROR_NON_BLOCK);
            }
        }
        if (drvRet != DRV_ERROR_NONE) {
            if (GetClientFlag() && !isAdcEnv_) {
                const std::lock_guard<std::mutex> lk(hdcSessionMutex_);
                int32_t value = 0;
                const auto ret = halHdcGetSessionAttr(session, HDC_SESSION_ATTR_DFX, &value);
                if (ret != DRV_ERROR_NONE) {
                    TSD_RUN_INFO("halHdcGetSessionAttr HDC_SESSION_ATTR_DFX not success, ret[%d].", ret);
                }
                if (value < 0) {
                    TSD_RUN_INFO("halHdcGetSessionAttr HDC_SESSION_ATTR_DFX not success, value[%d].", value);
                }
                TSD_INFO("halHdcGetSessionAttr HDC_SESSION_ATTR_DFX finish");
            } 
            TSD_RUN_INFO("halHdcRecv ret[%d]", drvRet);
            if (drvRet == DRV_ERROR_SOCKET_CLOSE) {
                return TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED;
            }
            return TSD_HDC_RECV_MSG_ERROR;
        }

        drvRet = drvHdcGetMsgBuffer(
            drvMsg, static_cast<int32_t>(HDC_DEFAULT_BUFF_INDEX), &buffer, &receivedLenEachTime);
        if (drvRet != DRV_ERROR_NONE) {
            TSD_ERROR("drvHdcGetMsgBuffer failed ret[%d]", drvRet);
            return TSD_HDC_RECV_MSG_ERROR;
        }

        if (buffer == nullptr) {
            TSD_ERROR("drvHdcGetMsgBuffer buffer is null");
            return TSD_HDC_RECV_MSG_ERROR;
        }
        // start check head
        const uint32_t currMsgSize = *(PtrToPtr<char_t, uint32_t>(buffer));
        if (static_cast<uint32_t>(receivedLenEachTime) != currMsgSize) {
            TSD_ERROR("length not match receivedLenEachTime[%d], currMsgSize[%u]", receivedLenEachTime, currMsgSize);
            return TSD_HDC_RECV_MSG_ERROR;
        }
        bufferLengthOut = static_cast<uint32_t>(receivedLenEachTime);
        return TSD_OK;
    }

    /**
    * @ingroup HdcCommon
    * @brief 创建VersionVerify实例
    * @return  VersionVerify实例
    */
    std::shared_ptr<VersionVerify> HdcCommon::MakeVersionVerifyNoThrow() const
    {
        try {
            return std::make_shared<VersionVerify>();
        } catch (...) {
            return std::shared_ptr<VersionVerify>();
        }
    }
}  // namespace tsd
