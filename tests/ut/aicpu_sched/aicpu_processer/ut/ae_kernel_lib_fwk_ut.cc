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
#define private public
#include "ae_kernel_lib_fwk.hpp"
#undef private

using namespace cce;
using namespace std;

class AeKernelLibFwkTest : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AeKernelLibFwkTest SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AeKernelLibFwkTest TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AeKernelLibFwkTest SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AeKernelLibFwkTest TearDown" << std::endl;
    }
};

TEST_F(AeKernelLibFwkTest, DestroyInstance_01) {
    AIKernelsLibFWK::DestroyInstance();
    EXPECT_EQ(AIKernelsLibFWK::instance_, nullptr);
}

TEST_F(AeKernelLibFwkTest, DestroyInstance_02) {
    MOCKER_CPP(&FWKKernelTfImpl::GetTensorflowThreadModeSoPath).stubs().will(returnValue(0));
    AIKernelsLibFWK *instance = AIKernelsLibFWK::GetInstance();
    EXPECT_NE(instance, nullptr);
    EXPECT_NE(AIKernelsLibFWK::instance_, nullptr);
    AIKernelsLibFWK::DestroyInstance();
    EXPECT_EQ(AIKernelsLibFWK::instance_, nullptr);
}

TEST_F(AeKernelLibFwkTest, TransformKernelErrorCode) {
    auto ret = FWKKernelTfImpl::TransformKernelErrorCode(0, 1000);
    EXPECT_EQ(ret, AE_STATUS_SUCCESS);
    ret = FWKKernelTfImpl::TransformKernelErrorCode(aicpu::FWKAdapter::FWK_ADPT_NATIVE_END_OF_SEQUENCE, 1000);
    EXPECT_EQ(ret, AE_STATUS_END_OF_SEQUENCE);
    ret = FWKKernelTfImpl::TransformKernelErrorCode(3, 1000);
    EXPECT_EQ(ret, 3);
}


const std::string rootPath = "/root";
const std::string userPath = "/home/HwHiAiUser";

char *GetHomeEnvForRoot (const char *__name)
{
    return const_cast<char *>(rootPath.data());
}

char *GetHomeEnvForUser (const char *__name)
{
    return const_cast<char *>(userPath.data());
}

char *GetHomeEnvFail (const char *__name)
{
    return nullptr;
}

aicpu::status_t GetAicpuRunModeStub(aicpu::AicpuRunMode &runMode)
{
    runMode = aicpu::AicpuRunMode::THREAD_MODE;
    return aicpu::AICPU_ERROR_NONE;
}

TEST_F(AeKernelLibFwkTest, GetThreadModeSoPathSuccess01)
{
    // for root
    FWKKernelTfImpl fwkImpl;
    MOCKER(getenv).stubs().will(invoke(GetHomeEnvForRoot));
    std::string soPath = "";
    MOCKER_CPP(&FWKKernelTfImpl::GetTensorflowThreadModeSoPath).stubs().will(returnValue(0));
    const auto ret = fwkImpl.GetTfThreadModeSoPath(soPath);
    EXPECT_EQ(ret, AE_STATUS_SUCCESS);
    EXPECT_STREQ(soPath.c_str(), "/root/aicpu_kernels/0/aicpu_kernels_device/");
}

TEST_F(AeKernelLibFwkTest, GetThreadModeSoPathSuccess02)
{
    // for root
    FWKKernelTfImpl fwkImpl;
    MOCKER(getenv).stubs().will(invoke(GetHomeEnvForUser));
    std::string soPath = "";
    MOCKER_CPP(&FWKKernelTfImpl::GetTensorflowThreadModeSoPath).stubs().will(returnValue(0));
    const auto ret = fwkImpl.GetTfThreadModeSoPath(soPath);
    EXPECT_EQ(ret, AE_STATUS_SUCCESS);
    EXPECT_STREQ(soPath.c_str(), "/home/HwHiAiUser/aicpu_kernels/0/aicpu_kernels_device/");
}

TEST_F(AeKernelLibFwkTest, GetThreadModeSoPathSuccess03)
{
    // for root
    FWKKernelTfImpl fwkImpl;
    MOCKER(getenv).stubs().will(invoke(GetHomeEnvForUser));
    std::string soPath = "";
    MOCKER_CPP(&FWKKernelTfImpl::GetTensorflowThreadModeSoPath).stubs().will(returnValue(0));
    const auto ret = fwkImpl.GetTfThreadModeSoPath(soPath);
    EXPECT_EQ(ret, AE_STATUS_SUCCESS);
    EXPECT_STREQ(soPath.c_str(), "/home/HwHiAiUser/aicpu_kernels/0/aicpu_kernels_device/");
}

TEST_F(AeKernelLibFwkTest, GetThreadModeSoPathFail01)
{
    // for root
    FWKKernelTfImpl fwkImpl;
    MOCKER(getenv).stubs().will(invoke(GetHomeEnvForRoot));
    MOCKER_CPP(&FWKKernelTfImpl::GetTensorflowThreadModeSoPath).stubs().will(returnValue(0));
    std::string soPath = "";
    const auto ret = fwkImpl.GetTfThreadModeSoPath(soPath);
    EXPECT_EQ(ret, AE_STATUS_SUCCESS);
}

TEST_F(AeKernelLibFwkTest, GetThreadModelTfKernelPathTest)
{
    // for root
    FWKKernelTfImpl fwkImpl;
    std::string inputStr;
    MOCKER(aicpu::GetAicpuRunMode).stubs().will(invoke(GetAicpuRunModeStub));
    MOCKER_CPP(&FWKKernelTfImpl::GetTfThreadModeSoPath).stubs().will(returnValue(0));
    std::string soPath = "";
    fwkImpl.GetThreadModelSoPath(inputStr);
    EXPECT_EQ(soPath, "");
}

TEST_F(AeKernelLibFwkTest, GetThreadModelTfKernelPathTest_01)
{
    // for root
    FWKKernelTfImpl fwkImpl;
    std::string inputStr;
    MOCKER(aicpu::GetAicpuRunMode).stubs().will(invoke(GetAicpuRunModeStub));
    MOCKER_CPP(&FWKKernelTfImpl::GetTfThreadModeSoPath).stubs().will(returnValue(1));
    std::string soPath = "";
    fwkImpl.GetThreadModelSoPath(inputStr);
    EXPECT_EQ(soPath, "");
    GlobalMockObject::verify();
}

TEST_F(AeKernelLibFwkTest, GetThreadModelTfKernelPathTest_02)
{
    // for root
    FWKKernelTfImpl fwkImpl;
    std::string inputStr;
    MOCKER(aicpu::GetAicpuRunMode).stubs().will(returnValue(1U));
    MOCKER_CPP(&FWKKernelTfImpl::GetTfThreadModeSoPath).stubs().will(returnValue(1));
    std::string soPath = "";
    fwkImpl.GetThreadModelSoPath(inputStr);
    EXPECT_EQ(soPath, "");
    GlobalMockObject::verify();
}