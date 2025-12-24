/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_DEVICE_MSG_HANDLER_HPP
#define CCE_DEVICE_MSG_HANDLER_HPP

#include "base.hpp"
#include "device.hpp"

namespace cce {
namespace runtime {

struct rtGetDevMsgCtrlInfo_t {
    uint32_t magic;  // used to judge whether the buffer is valid
    uint32_t pid;    // host pid, used to check message valid
    uint32_t bufferLen;
    uint32_t reserved;
};

struct rtStreamSnapshot_t {
    uint16_t streamId;
    uint16_t taskId;
    uint16_t sqId : 12;
    uint16_t sqFsm : 4;
    uint16_t acsqId : 8;
    uint16_t acsqFsm : 6;
    uint16_t isSwapIn : 1;
    uint16_t rsv : 1;
};

class DeviceMsgHandler {
public:
    static constexpr uint32_t DEVICE_GET_MSG_MAGIC = 0xA55A2021;

    DeviceMsgHandler(Device * const devInfo, const rtGetMsgCallback msgCallback);

    virtual ~DeviceMsgHandler() noexcept;

    virtual rtError_t Init();

    /**
     * @brief must make sure msg have saved to dev buf
     * @return RT_ERROR_NONE:success, other:failed
     */
    rtError_t HandleMsg();

    const void *GetDevMemAddr() const
    {
        return devMemAddr_;
    }

    uint32_t GetDevMemSize() const
    {
        return devMemSize_;
    }

protected:
    virtual rtError_t HandleMsgInHostBuf(const char_t * const msgBuff, const uint32_t msgBuffSize) = 0;

    void MsgNotify(const char_t * const msg, const uint32_t len) const;

private:
    rtError_t AllocDevMem();

    void FreeDevMem();

    rtError_t CheckGetDevMsgCtrlValid(const rtGetDevMsgCtrlInfo_t * const ctrlInfo) const;

protected:
    Device *dev_;

private:
    rtGetMsgCallback callback_;
    void *devMemAddr_ = nullptr;
    const uint32_t devMemSize_;
};

class DeviceErrMsgHandler : public DeviceMsgHandler {
public:
    using DeviceMsgHandler::DeviceMsgHandler;

    ~DeviceErrMsgHandler() override = default;

protected:
    rtError_t HandleMsgInHostBuf(const char_t * const msgBuff, const uint32_t msgBuffSize) override;
};

class DeviceStreamSnapshotHandler : public DeviceMsgHandler {
public:
    using DeviceMsgHandler::DeviceMsgHandler;

    ~DeviceStreamSnapshotHandler() override = default;

protected:
    rtError_t HandleMsgInHostBuf(const char_t * const msgBuff, const uint32_t msgBuffSize) override;

private:
    std::string GetActiveStreamSnapshot(const rtStreamSnapshot_t * const streamSnapshots, const uint32_t cnt) const;
};

}
}

#endif // CCE_DEVICE_MSG_HANDLER_HPP
