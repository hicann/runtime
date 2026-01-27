/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_SEND_PLATFORM_INFO_TO_CUSTOM_H
#define AICPU_SEND_PLATFORM_INFO_TO_CUSTOM_H

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
#include "aicpusd_info.h"

namespace AicpuSchedule {
class AicpuSdLoadPlatformInfoProcess {
public:
    static AicpuSdLoadPlatformInfoProcess &GetInstance();
    int32_t SendLoadPlatformInfoMessageToCustSync(const uint8_t * const msg, const uint32_t len) const;
    void LoadPlatformInfoSemPost();
    int32_t SendMsgToMain(const void * const msg, const uint32_t len);
    sem_t loadPlatformInfoProcessSem_;
};
}
#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus
    __attribute__((visibility("default"))) __attribute__((weak)) int32_t SendLoadPlatformInfoToCust(const struct TsdSubEventInfo * const msg);
#ifdef __cplusplus
}
#endif  // __cplusplus
#endif // AICPU_SEND_PLATFORM_INFO_TO_CUSTOM_H