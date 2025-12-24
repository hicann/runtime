/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DEVPROF_DRV_AICPU_H
#define DEVPROF_DRV_AICPU_H

#include "singleton/singleton.h"
#include "queue/block_buffer.h"
#include "utils/utils.h"
#include "prof_dev_api.h"
#include "thread/thread.h"

class DevprofDrvAicpu : public analysis::dvvp::common::singleton::Singleton<DevprofDrvAicpu>,
    public analysis::dvvp::common::thread::Thread {
public:
    DevprofDrvAicpu();
    ~DevprofDrvAicpu() override;
    int32_t Init(const struct AicpuStartPara *para);
    int32_t Start() override;
    int32_t Stop() override;
    bool IsRegister(void) const;
    void SetProfConfig(uint64_t profConfig);
    uint64_t GetProfConfig() const;
    int32_t CheckFeatureIsOn(uint64_t feature) const;
    bool CheckProfilingIsOn(uint64_t profConfig);
    int32_t ReportAdditionalInfo(uint32_t agingFlag, ConstVoidPtr data, uint32_t length);
    size_t GetBatchReportMaxSize(uint32_t type) const;
    int32_t AdprofInit(const AicpuStartPara *para);
    int32_t ModuleRegisterCallback(uint32_t moduleId, ProfCommandHandle commandHandle);
    void DoCallbackHandle(uint32_t moduleId, ProfCommandHandle commandHandle);
    void CommandHandleLaunch();
    void DeviceReportStart();
    void DeviceReportStop();
    int32_t SendAddtionalInfo();
    void AddStr2IdIntoBuffer(std::string& str);
    int32_t ReportStr2IdInfoToHost(std::string& dataStr);
#ifdef __PROF_LLT
    void Reset(void);
#endif

protected:
    void Run(const struct error_message::Context &errorContext) override;

private:
    int32_t RegisterDrvChannel(uint32_t devId, uint32_t channelId);

    volatile bool stopped_;
    uint32_t devId_;
    uint32_t channelId_;
    volatile uint64_t profConfig_;
    bool isRegister_;
    analysis::dvvp::common::queue::BlockBuffer<MsprofAdditionalInfo> aicpuAdditionalBuffer_{};
    MsprofCommandHandle command_;
    std::map<uint32_t, std::set<ProfCommandHandle>> moduleCallbacks_;
    std::mutex aicpuRegisterMutex_;
};

#endif