/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_ASYNC_HWTS_ENGINE_HPP
#define CCE_RUNTIME_ASYNC_HWTS_ENGINE_HPP

#include "hwts_engine.hpp"
#include "device.hpp"
#include "runtime.hpp"

namespace cce {
namespace runtime {
class AsyncHwtsEngine : public HwtsEngine {
public:
    explicit AsyncHwtsEngine(Device * const dev);
    ~AsyncHwtsEngine() override;

    rtError_t Init() override;

    // Start the engine process.
    rtError_t Start() override;

    // Stop the engine process.
    rtError_t Stop() override;

    // sending and receiving running entry
    virtual void Run(const void * const param) override;

    bool CheckSendThreadAlive() override;
    bool CheckReceiveThreadAlive() override;

protected:
    rtError_t SubmitSend(TaskInfo * const workTask, uint32_t * const flipTaskId = nullptr) override;

private:
    void SendingRun(void);
    // Entry of receiving process, called in receiving thread.
    void ReceivingRun(void);
    void ProcessTaskReport(const rtTsReport_t &taskReport);
    void ProcessErrorReport(const rtTsReport_t &errorReport) const;
    void GetReportCommonInfo(const rtTsReport_t &tsReport, uint16_t &streamId, uint16_t &taskId,
        uint16_t &sqId, uint16_t &sqHead, uint16_t &errorBit) const;
    // Entry of sending process, called in sending thread.
    void TaskToCommand(TaskInfo * const runTask, rtTsCommand_t &cmdLocal, rtTsCmdSqBuf_t * const command) const;
    void SendingWait(Stream * const stm, uint8_t &failCount) override;
    void SendingNotify() override;

    uint16_t GetPackageType(const rtTsReport_t &report) const;
    void GetTsReportByIdx(void * const reportAddr, int32_t const idx, rtTsReport_t &tsReport) const;

    // Submit task to process.
    rtError_t SubmitPush(TaskInfo * const workTask, uint32_t * const flipTaskId = nullptr);
    rtError_t PushFlipTask(const uint16_t preTaskId, Stream *stm);

    Notifier *GetNotifier() const
    {
        return notifier_;
    }

    void SetNotifier(Notifier *notifier)
    {
        notifier_ = notifier;
    }

    Scheduler *GetScheduler() const
    {
        return scheduler_;
    }

    void SetScheduler(Scheduler *scheduler)
    {
        scheduler_ = scheduler;
    }

    void DisableReceiveRunFlag()
    {
        receiveRunFlag_ = false;
    }

    void DisableSendRunFlag()
    {
        sendRunFlag_ = false;
    }

    std::atomic<bool> wflag_;
    Notifier *notifier_;
    Scheduler *scheduler_;
    Thread *sendThread_;
    Thread *receiveThread_;
    volatile bool sendRunFlag_ = false;
    volatile bool receiveRunFlag_ = false;
}; // class AsyncHwtsEngine
}  // namespace runtime
}  // namespace cce

#endif  // CCE_RUNTIME_ASYNC_HWTS_ENGINE_HPP
