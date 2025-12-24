/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "../../rt_utest_api.hpp"

class FftsPlusTaskLaunchTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        (void)rtSetDevice(0);
        (void)rtSetTSDevice(1);
        rtError_t error1 = rtStreamCreate(&stream_, 0);
        rtError_t error2 = rtEventCreate(&event_);
 
        for (uint32_t i = 0; i < sizeof(binary_)/sizeof(uint32_t); i++)
        {
            binary_[i] = i;
        }
 
        rtDevBinary_t devBin;
        devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
        devBin.version = 1;
        devBin.length = sizeof(binary_);
        devBin.data = binary_;
        rtError_t error3 = rtDevBinaryRegister(&devBin, &binHandle_);
 
        rtError_t error4 = rtFunctionRegister(binHandle_, &function_, "foo", NULL, 0);
        delete rawDevice;

        std::cout<<"api test start:"<<error1<<", "<<error2<<", "<<error3<<", "<<error4<<std::endl;
    }
 
    static void TearDownTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtError_t error1 = rtStreamDestroy(stream_);
        rtError_t error2 = rtEventDestroy(event_);
        rtError_t error3 = rtDevBinaryUnRegister(binHandle_);
        std::cout<<"api test start end : "<<error1<<", "<<error2<<", "<<error3<<std::endl;
        GlobalMockObject::verify();
        rtDeviceReset(0);
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        (void)rtSetSocVersion("");
    }
 
    virtual void SetUp()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        delete rawDevice;
    }
 
    virtual void TearDown()
    {
         GlobalMockObject::verify();
    }
 
public:
    static rtStream_t stream_;
    static rtEvent_t  event_;
    static void      *binHandle_;
    static char       function_;
    static uint32_t   binary_[32];
    static Driver*    driver_;
};

rtStream_t FftsPlusTaskLaunchTest::stream_ = NULL;
rtEvent_t FftsPlusTaskLaunchTest::event_ = NULL;
void* FftsPlusTaskLaunchTest::binHandle_ = nullptr;
char  FftsPlusTaskLaunchTest::function_ = 'a';
uint32_t FftsPlusTaskLaunchTest::binary_[32] = {};
Driver* FftsPlusTaskLaunchTest::driver_ = NULL;

TEST_F(FftsPlusTaskLaunchTest, FftsPlusTaskLaunch)
{
    rtFftsPlusSqe_t fftsSqe = {{0}, 0};
    void *descBuf = malloc(100);         // device memory
    uint32_t descBufLen=100;

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}};

    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(&fftsPlusTaskInfo));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    rtError_t error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_FFTS_PLUS);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    free(descBuf);
}

TEST_F(FftsPlusTaskLaunchTest, FftsPlusTaskLaunchApi)
{
    ApiImpl impl;
    rtError_t error = RT_ERROR_NONE;
    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {};
    rtStream_t stream;
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Context::FftsPlusTaskLaunch).stubs().will(returnValue(RT_ERROR_NONE));
    impl.FftsPlusTaskLaunch(&fftsPlusTaskInfo, static_cast<Stream *>(stream), 0);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(FftsPlusTaskLaunchTest, FftsPlusTaskLaunch_readyNum)
{
    rtFftsPlusSqe_t fftsSqe = {{0}, 0};
    fftsSqe.readyContextNum = 1;
    void *descBuf = malloc(100);         // device memory
    uint32_t descBufLen=100;
    fftsSqe.totalContextNum = descBufLen;
    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}};
    std::vector<uintptr_t> input;
    input.push_back(reinterpret_cast<uintptr_t>(&fftsPlusTaskInfo));
    input.push_back(reinterpret_cast<uintptr_t>(stream_));
    rtError_t error = rtGeneralCtrl(input.data(), input.size(), RT_GNL_CTRL_TYPE_FFTS_PLUS);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    free(descBuf);
}

TEST_F(FftsPlusTaskLaunchTest, FftsPlusTaskLaunchWithFlag)
{
    rtFftsPlusSqe_t fftsSqe = {{0}, 0};
    void *descBuf = malloc(100);         // device memory
    uint32_t descBufLen=100;
    uint32_t flag = 2;

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}};

    rtError_t error = rtFftsPlusTaskLaunchWithFlag(&fftsPlusTaskInfo, stream_, flag);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    free(descBuf);
}

TEST_F(FftsPlusTaskLaunchTest, FftsPlusTaskLaunchWithFlagForGetDevAddr)
{

    rtFftsPlusSqe_t fftsSqe = {{0}, 0};
    void *descBuf = malloc(1000);         // device memory
    uint32_t descBufLen=1000;
    uint32_t flag = 2;

    rtFftsPlusTaskInfo_t fftsPlusTaskInfo = {&fftsSqe, descBuf, descBufLen, {NULL, NULL, 0, 0}};
    uint64_t arg = 0x1234567890;
    rtArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    void *handleInfo[2] = {nullptr, nullptr};
    void *devArgsAddr = nullptr, *argsHandle = nullptr;
    rtError_t error = rtGetDevArgsAddr(stream_, &argsInfo, &devArgsAddr, &argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    printf("==44===%p %p\r\n", devArgsAddr, argsHandle);
    handleInfo[0] = (void *)malloc(128);
    fftsPlusTaskInfo.argsHandleInfoNum = 1;
    fftsPlusTaskInfo.argsHandleInfoPtr = handleInfo;

    fftsSqe.readyContextNum = 1;
    rtFftsPlusTaskLaunchWithFlag(&fftsPlusTaskInfo, stream_, flag);

    free(descBuf);
    free(handleInfo[0]);
}