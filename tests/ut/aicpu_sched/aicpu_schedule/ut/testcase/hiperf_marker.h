/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TESTS_UT_AICPU_SCHED_AICPU_SCHEDULE_UT_TESTCASE_HIPERF_MARKER_H_
#define TESTS_UT_AICPU_SCHED_AICPU_SCHEDULE_UT_TESTCASE_HIPERF_MARKER_H_

#include <cstdint>
#include <string>
#include "hiperf_common.h"

void InitMarker();
void FiniMarker();

namespace Hiva {
void SetMarkerMode(uint32_t mode);
uint64_t MarkerAicpuScheduler(KernelTrack& m);
uint32_t PerfDurationBegin(uint64_t seq, uint64_t begin);
uint32_t PerfDurationEnd(unsigned long seq, unsigned long end, unsigned long threshold, KernelTrack& m);
} // namespace Hiva

#endif // TESTS_UT_AICPU_SCHED_AICPU_SCHEDULE_UT_TESTCASE_HIPERF_MARKER_H_
