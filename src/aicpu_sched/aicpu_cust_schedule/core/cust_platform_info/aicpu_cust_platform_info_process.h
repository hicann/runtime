/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_CUST_PLATFORM_INFO_PROCESS_H
#define AICPU_CUST_PLATFORM_INFO_PROCESS_H

#include <atomic>
#include <vector>
#include <mutex>
#include <semaphore.h>
#include <thread>

#include "tsd.h"
#include "aicpu_event_struct.h"
#include "ascend_hal.h"
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#include "aicpu_context.h"

namespace AicpuSchedule {
using AicpuPlatformFuncPtr = int32_t(*)(uint64_t, uint32_t);
class AicpuCustomSdLoadPlatformInfoProcess {
public:
    AicpuPlatformFuncPtr GetAicpuPlatformFuncPtr();
    AicpuCustomSdLoadPlatformInfoProcess();
    ~AicpuCustomSdLoadPlatformInfoProcess();
    static AicpuCustomSdLoadPlatformInfoProcess &GetInstance();
    int32_t ProcessLoadPlatform(const uint8_t * const msgInfo, const uint32_t infoLen);
    int32_t DoSubmitEventSync(const uint8_t * const msg, const uint32_t len, struct event_proc_result &rsp) const;
private:
    std::mutex mutexForPlatformPtr;
    AicpuPlatformFuncPtr platformFuncPtr;
};
}
#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus
    __attribute__((visibility("default"))) __attribute__((weak)) int32_t CustProcessLoadPlatform(const struct event_info * const msg);
#ifdef __cplusplus
}
#endif  // __cplusplus
#endif // AICPU_CUST_PLATFORM_INFO_PROCESS_H