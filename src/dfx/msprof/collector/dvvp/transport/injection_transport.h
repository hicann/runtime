/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_TRANSPORT_INJECTION_TRANSPORT_H
#define ANALYSIS_DVVP_TRANSPORT_INJECTION_TRANSPORT_H

#include <atomic>
#include <condition_variable>
#include <mutex>
#include "transport.h"

namespace analysis {
namespace dvvp {
namespace transport {

class InjectionTransport : public ITransport {
public:
    explicit InjectionTransport(MsprofRawDataCallback callback);
    ~InjectionTransport() override;

    int32_t SendBuffer(CONST_VOID_PTR buffer, int32_t length) override;
    int32_t SendBuffer(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq) override;
    int32_t CloseSession() override;
    void WriteDone() override;
    void RegisterRawDataCallback(MsprofRawDataCallback callback) override;
    void UnRegisterRawDataCallback() override;
    bool IsRegisterRawDataCallback() override;
    uint64_t GetCallbackFailedCount() const;
    uint64_t GetCallbackFailedBytes() const;
    int32_t WaitAllCallbackDone(uint32_t timeoutSec) const;

private:
    class SendBufferGuard {
    public:
        explicit SendBufferGuard(InjectionTransport& transport);
        ~SendBufferGuard();

    private:
        InjectionTransport& transport_;
    };

    bool IsSupportedChannelFile(const std::string& fileName) const;
    RawDataType ConvertRawDataType(const std::string& fileName) const;
    bool ParseDeviceId(const std::string& extraInfo, uint32_t& deviceId) const;
    MsprofRawDataCallback GetRawDataCallback() const;
    int32_t PushRawData(const MsprofRawData& rawData);

private:
    MsprofRawDataCallback callback_;
    mutable std::mutex callbackMutex_;
    std::atomic<uint64_t> callbackFailedCount_;
    std::atomic<uint64_t> callbackFailedBytes_;
    mutable std::mutex sendBufferMutex_;
    mutable std::condition_variable sendBufferDoneCv_;
    std::atomic<uint32_t> pendingSendBuffers_;
};

} // namespace transport
} // namespace dvvp
} // namespace analysis

#endif
