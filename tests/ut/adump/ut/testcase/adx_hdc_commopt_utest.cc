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

#include "commopts/adx_comm_opt_manager.h"
#include "commopts/hdc_comm_opt.h"
#include "hdc_api.h"
#include "mmpa_api.h"
using namespace Adx;
class ADX_HDC_COMMOPT_UTEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};
/*
TEST_F(ADX_HDC_COMMOPT_UTEST, CommOptName)
{
    std::shared_ptr<Adx::AdxCommOpt> opt = nullptr;
    opt = std::make_shared<Adx::HdcCommOpt>();
    std::string name = opt->CommOptName();
    EXPECT_EQ(name, "HDC");
}

TEST_F(ADX_HDC_COMMOPT_UTEST, OpenServer)
{
    std::shared_ptr<Adx::AdxCommOpt> opt = nullptr;
    opt = std::make_shared<Adx::HdcCommOpt>();
    std::vector<std::string> info;
    OptHandle handle = opt->OpenServer(info);
    EXPECT_EQ(handle, ADX_OPT_INVALID_HANDLE);
    info.push_back("1");
    info.push_back("ggd");
    handle = opt->OpenServer(info);
    EXPECT_EQ(handle, ADX_OPT_INVALID_HANDLE);
    info.clear();
    info.push_back("-1");
    info.push_back("1");
    handle = opt->OpenServer(info);
    EXPECT_EQ(handle, ADX_OPT_INVALID_HANDLE);
    MOCKER(HdcServerCreate).stubs().will(returnValue((void*)nullptr));
    handle = opt->OpenServer(info);
    EXPECT_EQ(handle, ADX_OPT_INVALID_HANDLE);
}

TEST_F(ADX_HDC_COMMOPT_UTEST, OpenClient)
{
    std::shared_ptr<Adx::AdxCommOpt> opt = nullptr;
    opt = std::make_shared<Adx::HdcCommOpt>();
    std::vector<std::string> info;
    OptHandle handle = opt->OpenClient(info);
    EXPECT_EQ(handle, ADX_OPT_INVALID_HANDLE);
    info.push_back("ggd");
    handle = opt->OpenClient(info);
    EXPECT_EQ(handle, ADX_OPT_INVALID_HANDLE);
    info.clear();
    info.push_back("65530");
    std::cout<<"open client -> "<< info[0]<<std::endl;
    handle = opt->OpenClient(info);
    EXPECT_EQ(handle, ADX_OPT_INVALID_HANDLE);
    info.clear();
    info.push_back("1");
    std::cout<<"open client +>"<< info[0]<<std::endl;
    MOCKER(HdcClientCreate).stubs().will(returnValue((void*)nullptr));
    handle = opt->OpenClient(info);
    EXPECT_EQ(handle, ADX_OPT_INVALID_HANDLE);
}

TEST_F(ADX_HDC_COMMOPT_UTEST, Accept)
{
    std::shared_ptr<Adx::AdxCommOpt> opt = nullptr;
    opt = std::make_shared<Adx::HdcCommOpt>();
    OptHandle session = ADX_OPT_INVALID_HANDLE;
    OptHandle handle = opt->Accept(session);
    EXPECT_EQ(handle, ADX_OPT_INVALID_HANDLE);
    MOCKER(HdcServerAccept).stubs().will(returnValue((void*)nullptr));
    handle = opt->Accept(session);
    EXPECT_EQ(handle, ADX_OPT_INVALID_HANDLE);
}

TEST_F(ADX_HDC_COMMOPT_UTEST, Connect)
{
    std::shared_ptr<Adx::AdxCommOpt> opt = nullptr;
    opt = std::make_shared<Adx::HdcCommOpt>();
    std::string info;
    OptHandle session = ADX_OPT_INVALID_HANDLE;
    OptHandle handle = opt->Connect(session, info);
    EXPECT_EQ(handle, ADX_OPT_INVALID_HANDLE);
    session = 0x12345678;
    handle = opt->Connect(session, info);
    EXPECT_EQ(handle, ADX_OPT_INVALID_HANDLE);
    info = "-1";
    handle = opt->Connect(session, info);
    EXPECT_EQ(handle, ADX_OPT_INVALID_HANDLE);
    info = "abcd";
    handle = opt->Connect(session, info);
    EXPECT_EQ(handle, ADX_OPT_INVALID_HANDLE);
    MOCKER(HdcSessionConnect).stubs().will(returnValue(IDE_DAEMON_ERROR));
    info = "1";
    handle = opt->Connect(session, info);
    EXPECT_EQ(handle, ADX_OPT_INVALID_HANDLE);
}

TEST_F(ADX_HDC_COMMOPT_UTEST, Read)
{
    std::shared_ptr<Adx::AdxCommOpt> opt = nullptr;
    opt = std::make_shared<Adx::HdcCommOpt>();
    void *buffer = nullptr;
    int32_t length = 0;
    OptHandle session = ADX_OPT_INVALID_HANDLE;
    int32_t handle = opt->Read(session, &buffer, length, COMM_OPT_NOBLOCK);
    EXPECT_EQ(handle, IDE_DAEMON_ERROR);
    MOCKER(HdcReadNb).stubs().will(returnValue(IDE_DAEMON_RECV_NODATA));
    session = 0x12345678;
    handle = opt->Read(session, &buffer, length, COMM_OPT_NOBLOCK);
    EXPECT_EQ(handle, IDE_DAEMON_ERROR);
}
*/
