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

#include "adx_log.h"
#include "component/adx_server_manager.h"
#include "adx_datadump_server.h"
#include "adx_dump_record.h"

using namespace Adx;

class ADX_DUMP_SERVER_STUB_UTEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_DUMP_SERVER_STUB_UTEST, AdxDataDumpServerInit)
{
    EXPECT_EQ(0, AdxDataDumpServerInit());
}

TEST_F(ADX_DUMP_SERVER_STUB_UTEST, AdxDataDumpServerUnInit)
{
    EXPECT_EQ(0, AdxDataDumpServerUnInit());
}