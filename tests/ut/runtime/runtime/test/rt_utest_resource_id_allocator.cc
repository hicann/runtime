/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "resource_id_allocator.hpp"
#include <memory>

using namespace cce::runtime;

class ResourceIdAllocatorTest : public testing::Test {
protected:
    void SetUp() override
    {
        allocator_.reset(CreateResourceIdAllocator());
        ASSERT_NE(allocator_, nullptr);
        ASSERT_EQ(allocator_->Init(4U, 3U), 0);
    }

    std::unique_ptr<ResourceIdAllocator> allocator_;
};

TEST_F(ResourceIdAllocatorTest, KeepStreamAndModelIdSpacesIndependent)
{
    EXPECT_EQ(allocator_->AllocStreamId(), 0);
    EXPECT_EQ(allocator_->AllocStreamId(), 1);
    EXPECT_EQ(allocator_->AllocModelId(), 0);
}

TEST_F(ResourceIdAllocatorTest, ReuseReleasedIds)
{
    const int32_t streamId = allocator_->AllocStreamId();
    const int32_t modelId = allocator_->AllocModelId();
    allocator_->FreeStreamId(streamId);
    allocator_->FreeModelId(modelId);

    EXPECT_EQ(allocator_->AllocStreamId(), streamId);
    EXPECT_EQ(allocator_->AllocModelId(), modelId);
}

TEST_F(ResourceIdAllocatorTest, SkipOccupiedIds)
{
    allocator_->OccupyStreamId(0);
    allocator_->OccupyModelId(0);

    EXPECT_EQ(allocator_->AllocStreamId(), 1);
    EXPECT_EQ(allocator_->AllocModelId(), 1);
}

TEST(ResourceIdAllocatorStandaloneTest, RespectConfiguredIdLimits)
{
    std::unique_ptr<ResourceIdAllocator> allocator(CreateResourceIdAllocator());
    ASSERT_NE(allocator, nullptr);
    ASSERT_EQ(allocator->Init(2U, 1U), 0);

    EXPECT_EQ(allocator->AllocStreamId(), 0);
    EXPECT_EQ(allocator->AllocStreamId(), 1);
    EXPECT_EQ(allocator->AllocStreamId(), -1);
    EXPECT_EQ(allocator->AllocModelId(), 0);
    EXPECT_EQ(allocator->AllocModelId(), -1);
}
