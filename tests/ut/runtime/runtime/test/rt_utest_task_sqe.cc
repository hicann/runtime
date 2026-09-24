/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime_task_manager.h"

#include <cstddef>
#include <type_traits>

#include "gtest/gtest.h"

namespace cce {
namespace runtime {

using UnifiedTaskToSqe = void (*)(TaskInfo*, void*, const TaskSqeInfo&);
static_assert(std::is_same<PfnTaskToSqe, UnifiedTaskToSqe>::value, "PfnTaskToSqe must use the unified SQE contract");
static_assert(
    std::is_same<decltype(&ToConstructSqe), UnifiedTaskToSqe>::value,
    "ToConstructSqe must use the unified SQE contract");
static_assert(SQE_SIZE_UNIT == 64U, "SQE unit must remain 64 bytes");
static_assert(SQE_NUM_PER_TASK_MAX == SQE_NUM_PER_DAVID_TASK_MAX, "task SQE capacity must cover David");
static_assert(SQE_SIZE_PER_TASK_MAX == 320U, "task SQE buffer must remain 320 bytes");
static_assert(sizeof(TaskSqeInfo) == 16U, "TaskSqeInfo layout must remain stable");
static_assert(offsetof(TaskSqeInfo, sqBaseAddr) == 0U, "unexpected sqBaseAddr offset");
static_assert(offsetof(TaskSqeInfo, rsv) == 8U, "unexpected reserved-field offset");
static_assert(std::is_standard_layout<TaskSqeInfo>::value, "TaskSqeInfo must remain standard layout");
static_assert(sizeof(TaskSqeBuffer) == SQE_SIZE_PER_TASK_MAX, "TaskSqeBuffer must not add padding");
static_assert(alignof(TaskSqeBuffer) == alignof(uint8_t), "TaskSqeBuffer must preserve byte alignment");
static_assert(sizeof(rtStarsSqe_t) == SQE_SIZE_UNIT, "native STARS SQE must occupy one unit");
static_assert(GetTaskSqeBytes(5U) == 320U, "SQE byte calculation changed");
static_assert(GetSqeAddr(uint64_t{0x100000ULL}, 3U) == 0x1000C0ULL, "SQE address calculation changed");

TEST(TaskSqeContract, UsesFixed64ByteUnits)
{
    EXPECT_EQ(SQE_SIZE_UNIT, 64U);
    EXPECT_EQ(SQE_NUM_PER_TASK_MAX, 5U);
    EXPECT_EQ(SQE_SIZE_PER_TASK_MAX, 320U);
    EXPECT_EQ(sizeof(TaskSqeInfo), 16U);
    EXPECT_EQ(sizeof(TaskSqeBuffer), SQE_SIZE_PER_TASK_MAX);
    EXPECT_EQ(alignof(TaskSqeBuffer), alignof(uint8_t));
}

TEST(TaskSqeContract, CalculatesBytesAndAddressesBySqeNum)
{
    TaskSqeBuffer buffer = {};
    EXPECT_EQ(GetTaskSqeBytes(0U), 0U);
    EXPECT_EQ(GetTaskSqeBytes(1U), 64U);
    EXPECT_EQ(GetTaskSqeBytes(SQE_NUM_PER_TASK_MAX), 320U);
    EXPECT_EQ(GetSqeAddr(buffer.data, 0U), buffer.data);
    EXPECT_EQ(GetSqeAddr(buffer.data, 3U), buffer.data + 192U);
    EXPECT_EQ(GetSqeAddr(0x100000ULL, 3U), 0x1000C0ULL);

    const TaskSqeBuffer& constBuffer = buffer;
    EXPECT_EQ(GetSqeAddr(constBuffer.data, 4U), constBuffer.data + 256U);
}

TEST(TaskSqeContract, NativeSqeLayoutsUseOneUnit) { EXPECT_EQ(sizeof(rtStarsSqe_t), SQE_SIZE_UNIT); }

} // namespace runtime
} // namespace cce
