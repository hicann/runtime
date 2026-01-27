/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include<iostream>
#include<stdint.h>
#include<unistd.h>
#include"gtest/gtest.h"
#include"mockcpp/mockcpp.hpp"
#include"select_operation.h"

using namespace analysis::dvvp::streamio::common;

class SELECT_OPERATION_TEST:public testing::Test {
protected:
	virtual void SetUp() {
	}
	virtual void TearDown() {
	}
};

TEST_F(SELECT_OPERATION_TEST, SelectIsSet) {
	GlobalMockObject::verify();
	SelectOperation select_fd;

    select_fd.SelectAdd(-1);
    EXPECT_EQ(false, select_fd.SelectIsSet(-1));
    select_fd.SelectDel(-1);

    select_fd.SelectAdd(1);
    select_fd.SelectAdd(2);
    EXPECT_EQ(true, select_fd.SelectIsSet(1));
    EXPECT_EQ(true, select_fd.SelectIsSet(2));
    select_fd.SelectDel(1);
    EXPECT_EQ(false, select_fd.SelectIsSet(1));
    EXPECT_EQ(true, select_fd.SelectIsSet(2));
    select_fd.SelectClear();
    EXPECT_EQ(false, select_fd.SelectIsSet(1));
    EXPECT_EQ(false, select_fd.SelectIsSet(2));
}
