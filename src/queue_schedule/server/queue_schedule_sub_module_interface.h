/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_SUB_MODULE_INTERFACE_H
#define QUEUE_SCHEDULE_SUB_MODULE_INTERFACE_H

#include <string>
#include <atomic>
#include "tsd.h"
#include "qs_args_parser.h"

namespace bqs {
const std::string ERROR_MSG_ATTACH_GROUP_FAILED = "EM9001";
const std::string ERROR_MSG_QS_INIT_FAILED = "EM9002";
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
    int32_t StartQueueScheduleModule(const struct TsdSubEventInfo * const eventInfo);
    int32_t StopQueueScheduleModule(const struct TsdSubEventInfo * const eventInfo);

    inline bool GetStartFlag() const
    {
        return startFlag_.load();
    }

    static bool QsSubModuleAttachGroup(const ArgsParser &startParams);

private:
    SubModuleInterface() = default;
    ~SubModuleInterface() = default;

    void SetTsdEventKey(const struct TsdSubEventInfo * const eventInfo);
    bool ParseArgsFromFile(ArgsParser &startParams) const;
    std::string BuildArgsFilePath() const;
    static void DeleteArgsFile(const std::string &argsFilePath);
    int32_t SendSubModuleRsponse(const uint32_t eventType) const;
    void QsSubModuleInitQsInitParams(InitQsParams &initQsParams, const ArgsParser &startParams);
    void ReportErrMsgToTsd(const int32_t errCode) const;
    TsdEventKey tsdEventKey_;
    std::atomic<bool> startFlag_;
};

} // namespace bqs

extern "C"
{
__attribute__((visibility("default"))) int32_t StartQueueScheduleModule(const struct TsdSubEventInfo * const eventInfo);
__attribute__((visibility("default"))) int32_t StopQueueScheduleModule(const struct TsdSubEventInfo * const eventInfo);
}

#endif // QUEUE_SCHEDULE_SUB_MODULE_INTERFACE_H