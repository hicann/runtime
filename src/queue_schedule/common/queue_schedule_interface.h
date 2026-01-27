/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_INTERFACE_H
#define QUEUE_SCHEDULE_INTERFACE_H

#include <cstdint>
#include <sys/types.h>

extern "C" {
/**
 * @brief it is used to init aicpu scheduler for acl.
 * @param [in] deviceId : The id of self cpu.
 * @param [in] reschedInterval : reshedule time in ctrl cpu
 * @param [in] deployMode : 0 single process 1 muti process 2 muti thread.
 * @return AICPU_SCHEDULE_SUCCESS: sucess  other: error code in ErrorCode
 */
__attribute__((visibility("default"))) int32_t InitQueueScheduler(const uint32_t deviceId,
                                                                  const uint32_t reschedInterval);
}
#endif  // QUEUEU_SCHEDULE_INTERFACE_H
