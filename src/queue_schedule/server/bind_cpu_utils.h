/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_SCHEDULE_BIND_CPU_UTILS_H
#define QUEUE_SCHEDULE_BIND_CPU_UTILS_H

#include <cstdint>
#include <vector>
#include <pthread.h>
#include "common/bqs_status.h"

namespace bqs {
struct CpuInfo {
    int64_t ccpuNum;
    int64_t ccpuOsSched;
    int64_t dcpuNum;
    int64_t dcpuOsSched;
    int64_t aicpuNum;
    int64_t aicpuOsSched;
    int64_t tscpuNum;
    int64_t tscpuOsSched;
};
/**
 * bind cpu utils
 */
class BindCpuUtils {
public:

    /**
     * bind aicpu.
     * @param bindCpuIndex bind aicpu index
     * @return BQS_STATUS_OK:success, other:failed
     */
    static BqsStatus BindAicpu(const uint32_t bindCpuIndex);

    /**
     * set thread affinity to cpu ids
     * @param [in] threadId : thread id
     * @param [in] cpuIds : cpu ids
     * @return BQS_STATUS_OK:success, other:failed
     */
    static BqsStatus SetThreadAffinity(const pthread_t &threadId, const std::vector<uint32_t> &cpuIds);

    /**
     * Init semaphore.
     * @return BQS_STATUS_OK:success, other:failed
     */
    static BqsStatus InitSem();

    /**
     * Wait semaphore.
     * @return BQS_STATUS_OK:success, other:failed
     */
    static BqsStatus WaitSem();

    /**
     * Post semaphore.
     * @return BQS_STATUS_OK:success, other:failed
     */
    static BqsStatus PostSem();

    /**
     * Set thread FIFO.
     */
    static void SetThreadFIFO(const uint32_t deviceId);

    /**
     * Destroy semaphore.
     * @return BQS_STATUS_OK:success, other:failed
     */
    static void DestroySem();

    /**
     * Get cpu info.
     * @return BQS_STATUS_OK:success, other:failed
     */
    static BqsStatus GetDevCpuInfo(const uint32_t deviceId, std::vector<uint32_t> &aiCpuIds,
                                   std::vector<uint32_t> &ctrlCpuIds, uint32_t &coreNumPerDev, uint32_t &aicpuNum,
                                   uint32_t &aicpuBaseId);

    /**
     * AddToCgroup
     * @return true:success, false:failed
     */
    __attribute__((visibility("default"))) static bool AddToCgroup(const uint32_t deviceId, const uint32_t vfId);

    BindCpuUtils() = delete;

    ~BindCpuUtils() = delete;

private:
    /**
     * write tid to cpuset file.
     * @return BQS_STATUS_OK:success, other:failed
     */
    static BqsStatus WriteTidToCpuSet();

    /**
     * bind aicpu by self.
     * @param bindCpuIndex bind aicpu index
     * @return BQS_STATUS_OK:success, other:failed
     */
    static BqsStatus BindAicpuBySelf(uint32_t bindCpuIndex);

    /**
     * bind aicpu use pm api.
     * @param bindCpuIndex bind aicpu index
     * @return BQS_STATUS_OK:success, other:failed
     */
    static BqsStatus BindAicpuByPm(const uint32_t bindCpuIndex);
};
}  // namespace bqs

#endif  // QUEUE_SCHEDULE_BIND_CPU_UTILS_H
