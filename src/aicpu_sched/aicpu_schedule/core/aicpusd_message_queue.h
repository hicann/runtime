/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPUSD_MESSAGE_QUEUE_H
#define AICPUSD_MESSAGE_QUEUE_H

#include <vector>
#include <cstdint>
#include <cstddef>
#include <memory>
#include "ascend_hal_define.h"


namespace AicpuSchedule {
// MSQ0_STATUS_EL0
struct MsqStatus {
    uint32_t valid : 1;  // [0:0]
    uint32_t size  : 3;  // [3:1]
    uint32_t comp  : 1;  // [4:4]
    uint64_t res   : 59; // [63:5]
};

// MSQ_DATA_EL0
struct MsqDatas {
    uint64_t data0;
    uint64_t data1;
    uint64_t data2;
    uint64_t data3;
    uint64_t data4;
    uint64_t data5;
    uint64_t data6;
    uint64_t data7;
};

class MsqImpl;

class MessageQueue {
public:
    MessageQueue() : deviceId_(0U), aicpuPhyIds_({}), isEnableHardThread_(false), cqeBaseAddr_(nullptr) {}
    ~MessageQueue() = default;

    static MessageQueue &GetInstance();
    int32_t InitMessageQueue(const uint32_t deviceId, const std::vector<uint32_t> &aicpuPhyIds);
    int32_t InitMessageQueueForThread(const size_t threadIndex) const;
    static bool WaitMsqInfoOnce(MsqDatas &datas);
    static void SendResponse(const uint32_t errCode, const uint32_t status);

    using MsqStatusFunc = MsqStatus (*)();
    using MsqDataFunc = void (*)(const uint32_t, MsqDatas&);
    using MsqRspFunc = void (*)();
private:
    uint32_t *MapResAddr(const res_addr_type resType) const;
    int32_t InitMsqImpl() const;
    int32_t InitCqeBaseAddr();

    int32_t ResetMessageQueueStatus(const size_t threadIndex) const;
    int32_t ResetMsqT0Status() const;
    int32_t ResetMsqT1Status() const;
    int32_t InitMessageQueueStatusReadFunc(const size_t threadIndex) const;
    static MsqStatus ReadMsqT0Status();
    static MsqStatus ReadMsqT1Status();
    int32_t InitMessageQueueDataReadFunc(const size_t threadIndex) const;
    static void ReadMsqT0Data(const uint32_t msgSize, MsqDatas &datas);
    static void ReadMsqT1Data(const uint32_t msgSize, MsqDatas &datas);
    int32_t InitMessageQueueRspFunc(const size_t threadIndex) const;
    int32_t InitCqeAddr(const size_t threadIndex) const;

    static void SendMsqT0Response();
    static void SendMsqT1Response();
    static void SetCQE(const uint32_t errCode, const uint32_t status);
    static void WaitForEvent();
    static bool IsUseMsqT0(const size_t threadIndex);

    uint32_t deviceId_;
    std::vector<uint32_t> aicpuPhyIds_;
    bool isEnableHardThread_;
    uint32_t *cqeBaseAddr_;
    thread_local static MsqStatusFunc readMsqStatusFunc_;
    thread_local static MsqDataFunc readMsqDataFunc_;
    thread_local static MsqRspFunc sendMsqRspFunc_;
    thread_local static uint32_t *cqeAddr_;
    static std::shared_ptr<MsqImpl> impl_;
};

class MsqImpl {
public:
    explicit MsqImpl() = default;
    virtual ~MsqImpl() = default;

    virtual int32_t ResetMsqT0Status() const = 0;
    virtual int32_t ResetMsqT1Status() const = 0;
    virtual MsqStatus ReadMsqT0Status() const = 0;
    virtual MsqStatus ReadMsqT1Status() const = 0;
    virtual void ReadMsqT0Data(const uint32_t msgSize, MsqDatas &datas) const = 0;
    virtual void ReadMsqT1Data(const uint32_t msgSize, MsqDatas &datas) const = 0;
    virtual void SendMsqT0Response() const = 0;
    virtual void SendMsqT1Response() const = 0;
};

class MsqImplV1 : public MsqImpl {
public:
    explicit MsqImplV1() : MsqImpl() {};
    ~MsqImplV1() override = default;

    int32_t ResetMsqT0Status() const override;
    int32_t ResetMsqT1Status() const override;
    MsqStatus ReadMsqT0Status() const override;
    MsqStatus ReadMsqT1Status() const override;
    void ReadMsqT0Data(const uint32_t msgSize, MsqDatas &datas) const override;
    void ReadMsqT1Data(const uint32_t msgSize, MsqDatas &datas) const override;
    void SendMsqT0Response() const override;
    void SendMsqT1Response() const override;
};

class MsqImplV2 : public MsqImplV1 {
public:
    explicit MsqImplV2() : MsqImplV1() {};
    ~MsqImplV2() override = default;

    int32_t ResetMsqT0Status() const override;
    int32_t ResetMsqT1Status() const override;
    MsqStatus ReadMsqT1Status() const override;
    void ReadMsqT1Data(const uint32_t msgSize, MsqDatas &datas) const override;
    void SendMsqT1Response() const override;
};

}  // namespace AicpuSchedule
#endif
