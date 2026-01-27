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

rtError_t CmoTaskInitStub(TaskInfo *taskInfo, const rtCmoTaskInfo_t *const cmoTaskInfo, const Stream * const stm,
                      const uint32_t flag)
{
    (void)flag;
    taskInfo->typeName = "CMO";
    taskInfo->type = TS_TASK_TYPE_CMO;
    taskInfo->u.cmoTask.cmoid = 0U;
 
    return RT_ERROR_MODEL_NULL;
}

class RtOthersApiTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        (void)rtSetSocVersion("Ascend310");
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
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
rtStream_t RtOthersApiTest::stream_ = NULL;
rtEvent_t RtOthersApiTest::event_ = NULL;
void* RtOthersApiTest::binHandle_ = nullptr;
char  RtOthersApiTest::function_ = 'a';
uint32_t RtOthersApiTest::binary_[32] = {};
Driver* RtOthersApiTest::driver_ = NULL;

TEST_F(RtOthersApiTest, api_rtsSetCmoDesc)
{
    rtError_t error;
    rtCmoAddrInfo cmoAddrInfo;
    void *srcAddr = nullptr;

    error = rtsSetCmoDesc(&cmoAddrInfo, srcAddr, 64);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(RtOthersApiTest, capture_api_05)
{
    rtError_t error;
    rtStream_t stream;
    rtStream_t addStream;
    rtModel_t model = nullptr;
    rtStreamCaptureStatus status;
    rtModel_t captureMdl = nullptr;

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamCreate(&addStream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamGetCaptureInfo(stream, &status, &captureMdl);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamAddToModel(addStream, model);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    error = rtModelDebugDotPrint(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(addStream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(RtOthersApiTest, capture_api_36)
{
    rtError_t error;
    rtStream_t stream;
    rtTaskGrp_t taskGrpHandle = nullptr;
 
    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
 
    error = rtsStreamBeginTaskGrp(stream);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_NOT_CAPTURED);
 
    error = rtsStreamEndTaskGrp(stream, &taskGrpHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_STREAM_NOT_CAPTURED);
 
    error = rtsStreamBeginTaskUpdate(stream, taskGrpHandle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    error = rtsStreamEndTaskUpdate(stream);
    EXPECT_EQ(error, ACL_ERROR_STREAM_TASK_GROUP_STATUS);
 
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

rtError_t GetThreadIdByStreamIdStub(CbSubscribe *cbSubscribe, const uint32_t devId, const int32_t streamId,
    uint64_t *const threadId)
{
    UNUSED(cbSubscribe);
    UNUSED(devId);
    UNUSED(streamId);
    *threadId = 1LLU;
    return RT_ERROR_NONE;
}

TEST_F(RtOthersApiTest, capture_api_37)
{
    rtError_t error;
    rtStream_t stream;
    rtModel_t  model;
    rtModel_t captureMdl;
    rtCallback_t stub_func = (rtCallback_t)0x12345;

    MOCKER_CPP(&Model::LoadCompleteByStreamPostp).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Context::CreateContextCallBackThread).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&CbSubscribe::GetThreadIdByStreamId)
        .stubs()
        .will(invoke(GetThreadIdByStreamIdStub));
    MOCKER_CPP(&DevInfoManage::IsSupportChipFeature).stubs().will(returnValue(true));

    error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsLaunchHostFunc(stream, stub_func, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamEndCapture(stream, &model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtModelDestroy(model);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}