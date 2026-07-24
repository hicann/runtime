/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef INNER_INC_PROCESS_SHARED_CONTEXT_H
#define INNER_INC_PROCESS_SHARED_CONTEXT_H

#include <string>
#include "inc/client_manager.h"
#include "tsd/tsd_client.h"

namespace tsd {

struct ProcessSharedContext {
    ResponseCode rspCode = ResponseCode::FAIL;
    std::string errMsg;
    std::string errorLog;
    std::string startOrStopFailCode;

    uint32_t openSubPid = 0;
    ProcStatusInfo* pidArry = nullptr;
    uint32_t pidArryLen = 0;
    ProcStatusParam* pidList = nullptr;

    uint32_t logicDeviceId = 0;
    bool isAdcEnv = false;
    uint32_t platInfoMode = 0;
    uint32_t profilingMode = 0;
    uint64_t aicpuSchedMode = 0;
    std::string logLevel;
    std::string ccecpuLogLevel;
    std::string aicpuLogLevel;

    void ResetResponseState()
    {
        rspCode = ResponseCode::FAIL;
        errMsg.clear();
        errorLog.clear();
        startOrStopFailCode.clear();
    }
};

} // namespace tsd

#endif // INNER_INC_PROCESS_SHARED_CONTEXT_H
