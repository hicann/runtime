/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"
#define protected public
#define private public

#include "adx_common_component.h"
#include "extra_config.h"

using namespace Adx;
class ADX_COMM_COMPONENT_STEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

int32_t InitStub()
{
    return IDE_DAEMON_OK;
}

int32_t ProcessStub(const CommHandle *, const void *, uint32_t len)
{
    return IDE_DAEMON_OK;
}

int32_t UninitStub()
{
    return IDE_DAEMON_ERROR;
}

TEST_F(ADX_COMM_COMPONENT_STEST, CommonCptFunc)
{
    ComponentType componentType;
    AdxCommonComponent commonComp(InitStub, ProcessStub, UninitStub, componentType);
    CommHandle handle{OptType::COMM_HDC, 1};
    SharedPtr<MsgProto> proto{new MsgProto};
    proto->sliceLen = 0;
    EXPECT_EQ(IDE_DAEMON_OK, commonComp.Init());
    EXPECT_EQ(ProcessStub(&handle, proto.get(), 0), commonComp.Process(handle, proto));
    EXPECT_EQ(IDE_DAEMON_ERROR, commonComp.UnInit());
    EXPECT_EQ("Common hdc server process", commonComp.GetInfo());
    commonComp.SetType(ComponentType::COMPONENT_GETD_FILE);
    EXPECT_EQ(ComponentType::COMPONENT_GETD_FILE, commonComp.GetType());
}