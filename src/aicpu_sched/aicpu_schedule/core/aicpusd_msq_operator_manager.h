/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPUSD_MSQ_OPERATOR_MANAGER_H
#define AICPUSD_MSQ_OPERATOR_MANAGER_H

#include <cstdint>
#include <mutex>

#include "aicpusd_message_queue.h"

namespace AicpuSchedule {
class MsqOperatorManager {
public:
    MsqOperatorManager() = delete;
    ~MsqOperatorManager() = delete;
    MsqOperatorManager(const MsqOperatorManager&) = delete;
    MsqOperatorManager& operator=(const MsqOperatorManager&) = delete;

    static int32_t Init();
    static void Finalize();

    static void CallV1ResetT0Status();
    static void CallV1ResetT1Status();
    static MsqStatus CallV1ReadT0Status();
    static MsqStatus CallV1ReadT1Status();
    static void CallV1ReadT0Data(uint32_t msgSize, MsqDatas* datas);
    static void CallV1ReadT1Data(uint32_t msgSize, MsqDatas* datas);
    static void CallV1SendT0Response();
    static void CallV1SendT1Response();

    static void CallV2ResetT0Status();
    static void CallV2ResetT1Status();
    static MsqStatus CallV2ReadT1Status();
    static void CallV2ReadT1Data(uint32_t msgSize, MsqDatas* datas);
    static void CallV2SendT1Response();
    static void CallWait();

private:
    using MsqResetFunc = void (*)();
    using MsqReadStatusFunc = MsqStatus (*)();
    using MsqReadDataFunc = void (*)(uint32_t, MsqDatas*);
    using MsqSendRspFunc = void (*)();
    using RawFuncPtr = void (*)();
    using WaitFunc = void (*)();

    static bool LoadAllSymbols();

    static void* handle_;
    static bool inited_;
    static std::mutex mutex_;

    static MsqResetFunc v1ResetT0Status_;
    static MsqResetFunc v1ResetT1Status_;
    static MsqReadStatusFunc v1ReadT0Status_;
    static MsqReadStatusFunc v1ReadT1Status_;
    static MsqReadDataFunc v1ReadT0Data_;
    static MsqReadDataFunc v1ReadT1Data_;
    static MsqSendRspFunc v1SendT0Response_;
    static MsqSendRspFunc v1SendT1Response_;

    static MsqResetFunc v2ResetT0Status_;
    static MsqResetFunc v2ResetT1Status_;
    static MsqReadStatusFunc v2ReadT1Status_;
    static MsqReadDataFunc v2ReadT1Data_;
    static MsqSendRspFunc v2SendT1Response_;
    static WaitFunc waitFunc_;
};
} // namespace AicpuSchedule

#endif
