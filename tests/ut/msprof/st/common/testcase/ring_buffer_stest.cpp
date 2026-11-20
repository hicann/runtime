/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string>
#include <memory>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "queue/ring_buffer.h"
#include "queue/report_buffer.h"

using namespace analysis::dvvp::common::queue;

class COMMON_QUEUE_RING_BUFFER_STEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {}
};

TEST_F(COMMON_QUEUE_RING_BUFFER_STEST, ReportBuffer_GetUsedSize)
{
    std::shared_ptr<ReportBuffer<int> > bq(new ReportBuffer<int>(-1));
    int data1 = 1;
    int data2 = 2;
    int data3 = 3;
    int data4 = 4;
    int data5 = 5;

    std::string name = "test";
    bq->Init(4, name);
    EXPECT_EQ(4, bq->capacity_);

    EXPECT_EQ(MSPROF_ERROR_NONE, bq->TryPush(1, data1));
    EXPECT_EQ(1, bq->GetUsedSize());
    EXPECT_EQ(MSPROF_ERROR_NONE, bq->TryPush(1, data2));
    EXPECT_EQ(2, bq->GetUsedSize());
    EXPECT_EQ(MSPROF_ERROR_NONE, bq->TryPush(1, data3));
    EXPECT_EQ(3, bq->GetUsedSize());
    EXPECT_EQ(MSPROF_ERROR_NONE, bq->TryPush(1, data4));
    // The counter uses modulo capacity and cannot distinguish an empty queue from a full one.
    EXPECT_EQ(0U, bq->GetUsedSize());

    EXPECT_EQ(0, bq->readIndex_.load());
    EXPECT_EQ(4, bq->writeIndex_.load());

    uint32_t aging = 0;
    int popData = 0;
    EXPECT_FALSE(bq->TryPop(aging, popData));

    EXPECT_EQ(MSPROF_ERROR_NONE, bq->TryPush(1, data5));
    EXPECT_EQ(1U, bq->GetUsedSize());

    EXPECT_TRUE(bq->TryPop(aging, popData));
    EXPECT_EQ(5, popData);
    EXPECT_EQ(0U, bq->GetUsedSize());

    EXPECT_FALSE(bq->TryPop(aging, popData));
    bq->UnInit();
}
