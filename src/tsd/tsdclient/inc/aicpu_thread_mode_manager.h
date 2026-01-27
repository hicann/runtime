/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef INNER_INC_AICPU_THREAD_MODE_MANAGER_H
#define INNER_INC_AICPU_THREAD_MODE_MANAGER_H

#include "proto/tsd_message.pb.h"
#include "inc/process_mode_manager.h"
#include "inc/thread_mode_manager.h"

namespace tsd {
using ReleaseProfiling = void (*)();
class AicpuThreadModeManager : public ProcessModeManager {
public:
    explicit AicpuThreadModeManager(const uint32_t &deviceId, const uint32_t deviceMode);
    TSD_StatusT Open(const uint32_t rankSize) override;
    TSD_StatusT Close(const uint32_t flag) override;
    TSD_StatusT GetHdcConctStatus(int32_t &hdcSessStat) override;
    TSD_StatusT ProcessCloseSubProcList(const ProcStatusParam *closeList, const uint32_t listSize) override;
    TSD_StatusT GetSubProcListStatus(ProcStatusParam *pidInfo, const uint32_t arrayLen) override;
    ~AicpuThreadModeManager() override;
    TSD_StatusT UpdateProfilingConf(const uint32_t &flag) override;
    TSD_StatusT ProcessOpenSubProc(ProcOpenArgs *openArgs) override;
    void DetectAndReconnectToServer(int32_t &hdcSessStat, const bool needConect);
private:
    ThreadModeManager threadInstance_;
    uint32_t deviceId_;
    SubProcessStatus runningStat_;
};
}
#endif
