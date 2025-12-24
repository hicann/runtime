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
#include"epoll_operation.h"

using namespace analysis::dvvp::streamio::common;

class EPOLL_OPERATION_TEST:public testing::Test {
protected:
	virtual void SetUp() {
	}
	virtual void TearDown() {
	}
};

TEST_F(EPOLL_OPERATION_TEST, epoll_add) {
	GlobalMockObject::verify();
	EpollOperation epoll_fd;

    EXPECT_EQ(-1, epoll_fd.epoll_add(99999999));
	EXPECT_EQ(0, epoll_fd.epoll_add(1));
	EXPECT_EQ(0, epoll_fd.epoll_add(2));
}

TEST_F(EPOLL_OPERATION_TEST, epoll_del) {
	std::cout<<"epoll_del begin"<<std::endl;
	EpollOperation epoll_fd;

    EXPECT_EQ(-1, epoll_fd.epoll_del(99999999));
	EXPECT_EQ(0, epoll_fd.epoll_del(1));
}

TEST_F(EPOLL_OPERATION_TEST, epoll_is_set) {
	GlobalMockObject::verify();
	EpollOperation epoll_fd;

    epoll_fd.epoll_add(1);

    EXPECT_EQ(false, epoll_fd.epoll_is_set(99999999));
    EXPECT_EQ(false, epoll_fd.epoll_is_set(2));
    EXPECT_EQ(true, epoll_fd.epoll_is_set(1));

}

TEST_F(EPOLL_OPERATION_TEST, epoll_waits) {
	GlobalMockObject::verify();
	EpollOperation epoll_fd;
    struct timeval tv = {1, 0};

	MOCKER(select)
		.stubs()
		.with(any(), any(), any(), any(), any())
		.will(returnValue(0))
		.then(returnValue(-1));
	
	EXPECT_EQ(1, epoll_fd.epoll_waits(&tv));
	EXPECT_EQ(-1, epoll_fd.epoll_waits(&tv));
}
