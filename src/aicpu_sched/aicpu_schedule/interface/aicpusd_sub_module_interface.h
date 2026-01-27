/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef INTERFACE_AICPUSD_SUB_MODULE_INTERFACE_H
#define INTERFACE_AICPUSD_SUB_MODULE_INTERFACE_H

#include <string>
#include <atomic>
#include "tsd.h"
#include "aicpusd_args_parser.h"

namespace AicpuSchedule {
class SubModuleInterface {
public:
    struct TsdEventKey {
        uint32_t deviceId;
        uint32_t hostPid;
        uint32_t vfId;
    };

    static SubModuleInterface &GetInstance()
    {
        static SubModuleInterface instance;
        return instance;
    }
    int32_t StartAicpuSchedulerModule(const struct TsdSubEventInfo * const eventInfo);
    int32_t StopAicpuSchedulerModule(const struct TsdSubEventInfo * const eventInfo);

    inline bool GetStartFlag() const
    {
        return startFlag_.load();
    }

private:
    SubModuleInterface() = default;
    ~SubModuleInterface() = default;

    void SetTsdEventKey(const struct TsdSubEventInfo * const eventInfo);
    bool ParseArgsFromFile(ArgsParser &startParas) const;
    std::string BuildArgsFilePath() const;
    static void DeleteArgsFile(const std::string &argsFilePath);

    void ReportErrMsgToTsd(const int32_t errCode) const;
    static bool AttachHostGroup(const ArgsParser &startParas);
    void SendPidQosMsgToTsd(const uint32_t pidQos) const;
    int32_t SendSubModuleRsponse(const uint32_t eventType) const;

    TsdEventKey tsdEventKey_;
    std::atomic<bool> startFlag_;
};

} // namespace AicpuSchedule

extern "C"
{
__attribute__((visibility("default"))) int32_t StartAicpuSchedulerModule(const struct TsdSubEventInfo *const eventInfo);
__attribute__((visibility("default"))) int32_t StopAicpuSchedulerModule(const struct TsdSubEventInfo *const eventInfo);
}

#endif // INTERFACE_AICPUSD_SUB_MODULE_INTERFACE_H
