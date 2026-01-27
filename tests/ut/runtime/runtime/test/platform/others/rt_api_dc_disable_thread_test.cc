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
class ApiDCDisableThreadTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        (void)rtSetSocVersion("Ascend310P");
        flag = ((Runtime *)Runtime::Instance())->GetDisableThread();
        ((Runtime *)Runtime::Instance())->SetDisableThread(true);
        originType_ = Runtime::Instance()->GetChipType();
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(CHIP_DC);
        GlobalContainer::SetRtChipType(CHIP_DC);

        int64_t hardwareVersion = CHIP_DC << 8;
        driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver_,
            &Driver::GetDevInfo).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(),outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        MOCKER(halGetSocVersion).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any()).will(returnValue(DRV_ERROR_NOT_SUPPORT));
        MOCKER(halGetDeviceInfo).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion))).will(returnValue(RT_ERROR_NONE));

        (void)rtSetDevice(0);
        (void)rtSetTSDevice(0);
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

        std::cout<<"api test start:"<<error1<<", "<<error2<<", "<<error3<<", "<<error4<<std::endl;
    }

    static void TearDownTestCase()
    {
        rtError_t error1 = rtStreamDestroy(stream_);
        rtError_t error2 = rtEventDestroy(event_);
        rtError_t error3 = rtDevBinaryUnRegister(binHandle_);
        std::cout<<"api test start end : "<<error1<<", "<<error2<<", "<<error3<<std::endl;
        rtDeviceReset(0);
        (void)rtSetSocVersion("");
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(flag);      // Recover.
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
    static rtChipType_t originType_;
    static Driver    *driver_;
    static bool flag;
};

rtStream_t ApiDCDisableThreadTest::stream_ = NULL;
rtEvent_t ApiDCDisableThreadTest::event_ = NULL;
void* ApiDCDisableThreadTest::binHandle_ = nullptr;
char  ApiDCDisableThreadTest::function_ = 'a';
uint32_t ApiDCDisableThreadTest::binary_[32] = {};
rtChipType_t ApiDCDisableThreadTest::originType_ = CHIP_CLOUD;
Driver* ApiDCDisableThreadTest::driver_ = NULL;
bool ApiDCDisableThreadTest::flag = false;

TEST_F(ApiDCDisableThreadTest, kernel_launch)
{
    rtError_t error;
    void *args[] = {&error, NULL};
    void *stubFunc;

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    const bool isDisableThread = Runtime::Instance()->GetDisableThread();
    EXPECT_EQ(isDisableThread, true);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtGetFunctionByName("foo", &stubFunc);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(stubFunc, (void*)&function_);

    error = rtGetFunctionByName("fooooo", &stubFunc);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtGetFunctionByName(NULL, &stubFunc);
    EXPECT_NE(error, RT_ERROR_NONE);

    error = rtStreamSynchronize(stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDCDisableThreadTest, kernel_launch_unsupport_mc2)
{
    rtError_t error;
    rtSmDesc_t desc;
    char_t* name = "opName";

    void *args[] = { &error, NULL };
    rtAicpuArgsEx_t argsInfo0 = {};
    argsInfo0.args = args;
    argsInfo0.argsSize = sizeof(args);
    error = rtAicpuKernelLaunchExWithArgs(5, name, 1, &argsInfo0, &desc, stream_, 2);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiDCDisableThreadTest, creat_event_with_mc2)
{
    rtError_t error;
    rtEvent_t event;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_MC2_RTS_SUPPORT_HCCL_DC);

    error = rtEventCreateWithFlag(&event, RT_EVENT_MC2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    device->SetTschVersion(version);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiDCDisableThreadTest, creat_event_mc2_or_other_flags)
{
    rtError_t error;
    rtEvent_t event;

    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    int32_t version = device->GetTschVersion();
    device->SetTschVersion(TS_VERSION_MC2_RTS_SUPPORT_HCCL_DC);

    error = rtEventCreateWithFlag(&event, RT_EVENT_MC2 | RT_EVENT_DDSYNC_NS);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    device->SetTschVersion(version);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(ApiDCDisableThreadTest, kernel_launch_with_timeout)
{
    rtError_t error;
    rtSmDesc_t desc;
    char_t* name = "opName";

    void *args[] = { &error, NULL };
    rtAicpuArgsEx_t argsInfo0 = {};
    argsInfo0.args = args;
    argsInfo0.argsSize = sizeof(args);
    argsInfo0.timeout = 100;

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t type = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD);
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtAicpuKernelLaunchExWithArgs(KERNEL_TYPE_AICPU_CUSTOM, name, 1, &argsInfo0, &desc, stream_, RT_KERNEL_CUSTOM_AICPU | RT_KERNEL_USE_SPECIAL_TIMEOUT);
    argsInfo0.timeout = 100000;
    rtSetOpExecuteTimeOut(10);
    error = rtAicpuKernelLaunchExWithArgs(KERNEL_TYPE_AICPU_CUSTOM, name, 1, &argsInfo0, &desc, stream_, RT_KERNEL_CUSTOM_AICPU | RT_KERNEL_USE_SPECIAL_TIMEOUT);
    rtInstance->SetChipType(type);
    GlobalContainer::SetRtChipType(type);

    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

//okay
TEST_F(ApiDCDisableThreadTest, create_external_event)
{
    rtError_t error;
    rtEvent_t event = nullptr;

    error = rtEventCreateWithFlag(&event, RT_EVENT_EXTERNAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventCreateExWithFlag(&event, RT_EVENT_EXTERNAL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtEventCreateWithFlag(&event, RT_EVENT_EXTERNAL | RT_EVENT_MC2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtEventCreateExWithFlag(&event, RT_EVENT_EXTERNAL | RT_EVENT_MC2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtEventCreateWithFlag(&event, RT_EVENT_EXTERNAL | RT_EVENT_DEFAULT);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtEventCreateExWithFlag(&event, RT_EVENT_EXTERNAL | RT_EVENT_DEFAULT);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsEventCreateEx(&event, RT_EVENT_FLAG_EXTERNAL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    error = rtsEventCreateEx(&event, RT_EVENT_FLAG_EXTERNAL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
 
    error = rtsEventCreateEx(&event, RT_EVENT_FLAG_EXTERNAL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDCDisableThreadTest, create_event_RT_EVENT_MAX)
{
    rtError_t error;
    rtEvent_t event = nullptr;

    error = rtEventCreateWithFlag(&event, RT_EVENT_FLAG_MAX);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtEventCreateExWithFlag(&event, RT_EVENT_FLAG_MAX);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    uint32_t flag = (RT_EVENT_FLAG_MAX & (~(RT_EVENT_MC2 | RT_EVENT_EXTERNAL)));
    error = rtEventCreateExWithFlag(&event, flag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDCDisableThreadTest, query_external_event)
{
    rtError_t error;
    rtEvent_t event = nullptr;

    error = rtEventCreateWithFlag(&event, RT_EVENT_EXTERNAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventQuery(event);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtEventStatus_t status = RT_EVENT_INIT;
    error = rtEventQueryStatus(event, &status);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    rtEventWaitStatus_t wait_status = EVENT_STATUS_MAX;
    error = rtEventQueryWaitStatus(event, &wait_status);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    uint64_t timestamp = 0;
    error = rtEventGetTimeStamp(&timestamp, event);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    float32_t time_interval = 0;
    error = rtEventElapsedTime(&time_interval, event, event);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDCDisableThreadTest, synchronize_external_event)
{
    rtError_t error;
    rtEvent_t event = nullptr;

    error = rtEventCreateWithFlag(&event, RT_EVENT_EXTERNAL);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtEventSynchronize(event);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtEventSynchronizeWithTimeout(event, -1);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtEventDestroy(event);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDCDisableThreadTest, user_logic_devid_00)
{
    uint32_t devNum = 8U;
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(DRV_ERROR_NONE));

    int32_t cnt = -1;
    int32_t userDeviceId = -1;
    int32_t logicDeviceId = -1;

    rtError_t error = rtGetDeviceCount(&cnt);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(cnt, devNum);

    error = rtGetLogicDevIdByUserDevId(-1, &logicDeviceId);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
    error = rtGetLogicDevIdByUserDevId(0, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t visible_device[] = {3, 4, 5, 6, 7};
    size_t visible_device_cnt = sizeof(visible_device) / sizeof(visible_device[0]);

    for (size_t idx = 0; idx < visible_device_cnt; idx++) {
        error = rtGetLogicDevIdByUserDevId(idx, &logicDeviceId);
        EXPECT_EQ(error, ACL_RT_SUCCESS);
        EXPECT_EQ(logicDeviceId, idx);
    }
    for (size_t idx = 0; idx < visible_device_cnt; idx++) {
        error = rtGetUserDevIdByLogicDevId(visible_device[idx], &userDeviceId);
        EXPECT_EQ(error, ACL_RT_SUCCESS);
        EXPECT_EQ(userDeviceId, visible_device[idx]);
    }
}

TEST_F(ApiDCDisableThreadTest, user_logic_devid_01)
{
    uint32_t devNum = 8U;
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(DRV_ERROR_NONE));

    int32_t cnt = -1;
    int32_t userDeviceId = -1;
    int32_t logicDeviceId = -1;

    rtError_t error = rtGetDeviceCount(&cnt);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(cnt, devNum);

    error = rtGetLogicDevIdByUserDevId(-1, &logicDeviceId);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
    error = rtGetLogicDevIdByUserDevId(0, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t visible_device[] = {3, 4, 5, 6, 7};
    size_t visible_device_cnt = sizeof(visible_device) / sizeof(visible_device[0]);
    char env_visible_device[128] = "";
    for (size_t i = 0; i < visible_device_cnt; i++) {
        std::strcat(env_visible_device, std::to_string(visible_device[i]).c_str());
        std::strcat(env_visible_device, ",");
    }
    env_visible_device[std::strlen(env_visible_device) - 1] = '\0';

    setenv("ASCEND_RT_VISIBLE_DEVICES", env_visible_device, 1);
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    const bool haveDevice = rtInstance->isHaveDevice_;
    rtInstance->isHaveDevice_ = true;

    rtError_t ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);
    for (size_t idx = 0; idx < visible_device_cnt; idx++) {
        error = rtGetLogicDevIdByUserDevId(idx, &logicDeviceId);
        EXPECT_EQ(error, ACL_RT_SUCCESS);
        EXPECT_EQ(logicDeviceId, visible_device[idx]);
    }
    for (size_t idx = 0; idx < visible_device_cnt; idx++) {
        error = rtGetUserDevIdByLogicDevId(visible_device[idx], &userDeviceId);
        EXPECT_EQ(error, ACL_RT_SUCCESS);
        EXPECT_EQ(userDeviceId, idx);
    }

    unsetenv("ASCEND_RT_VISIBLE_DEVICES");
    rtInstance->isSetVisibleDev = false;
    rtInstance->userDeviceCnt = 0;
    rtInstance->isHaveDevice_ = haveDevice;
}

TEST_F(ApiDCDisableThreadTest, user_logic_devid_02)
{
    uint32_t devNum = 8U;
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(DRV_ERROR_NONE));

    int32_t cnt = -1;
    int32_t userDeviceId = -1;

    rtError_t error = rtGetDeviceCount(&cnt);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(cnt, devNum);

    error = rtGetUserDevIdByLogicDevId(-1, &userDeviceId);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
    error = rtGetUserDevIdByLogicDevId(0, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t visible_device[] = {5, 4, 3, 6, 7};
    size_t visible_device_cnt = sizeof(visible_device) / sizeof(visible_device[0]);
    char env_visible_device[128] = "";
    for (size_t i = 0; i < visible_device_cnt; i++) {
        std::strcat(env_visible_device, std::to_string(visible_device[i]).c_str());
        std::strcat(env_visible_device, ",");
    }
    env_visible_device[std::strlen(env_visible_device) - 1] = '\0';

    setenv("ASCEND_RT_VISIBLE_DEVICES", env_visible_device, 1);
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    const bool haveDevice = rtInstance->isHaveDevice_;
    rtInstance->isHaveDevice_ = true;

    rtError_t ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    error = rtGetDeviceCount(&cnt);
    EXPECT_EQ(error, ACL_ERROR_RT_NO_DEVICE);

    error = rtSetDevice(0);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);

    unsetenv("ASCEND_RT_VISIBLE_DEVICES");
    rtInstance->isSetVisibleDev = false;
    rtInstance->userDeviceCnt = 0;
    rtInstance->isHaveDevice_ = haveDevice;
}

TEST_F(ApiDCDisableThreadTest, user_logic_devid_03)
{
    uint32_t devNum = 8U;
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(DRV_ERROR_NONE));

    int32_t cnt = -1;
    int32_t userDeviceId = -1;
    int32_t logicDeviceId = -1;

    rtError_t error = rtGetDeviceCount(&cnt);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(cnt, devNum);

    error = rtGetLogicDevIdByUserDevId(-1, &logicDeviceId);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
    error = rtGetLogicDevIdByUserDevId(0, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    int32_t visible_device[] = {3, 4, 6, 5, 7};
    size_t visible_device_cnt = sizeof(visible_device) / sizeof(visible_device[0]);
    char env_visible_device[128] = "";
    for (size_t i = 0; i < visible_device_cnt; i++) {
        std::strcat(env_visible_device, std::to_string(visible_device[i]).c_str());
        std::strcat(env_visible_device, ",");
    }
    env_visible_device[std::strlen(env_visible_device) - 1] = '\0';

    setenv("ASCEND_RT_VISIBLE_DEVICES", env_visible_device, 1);
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    const bool haveDevice = rtInstance->isHaveDevice_;
    rtInstance->isHaveDevice_ = true;

    rtError_t ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    error = rtGetDeviceCount(&cnt);
    EXPECT_EQ(error, ACL_ERROR_RT_NO_DEVICE);

    for (size_t idx = 0; idx < visible_device_cnt; idx++) {
        error = rtGetLogicDevIdByUserDevId(idx, &logicDeviceId);
        EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
    }
    for (size_t idx = 0; idx < visible_device_cnt; idx++) {
        error = rtGetUserDevIdByLogicDevId(visible_device[idx], &userDeviceId);
        EXPECT_EQ(error, ACL_ERROR_RT_INVALID_DEVICEID);
    }

    unsetenv("ASCEND_RT_VISIBLE_DEVICES");
    rtInstance->isSetVisibleDev = false;
    rtInstance->isHaveDevice_ = haveDevice;
    rtInstance->userDeviceCnt = 0;
}

TEST_F(ApiDCDisableThreadTest, GetDeviceIDs_00)
{
    uint32_t devices[10] = { -1 };
    size_t arrayLen = sizeof(devices) / sizeof(devices[0]);
    uint32_t devNum = static_cast<uint32_t>(arrayLen);
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(drvGetDevIDs).stubs().will(invoke(drvGetDevIDs_stub_00));

    rtError_t ret = rtGetDeviceIDs(devices, devNum);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    for (size_t i = 0; i < arrayLen; i++) {
        EXPECT_EQ(i, devices[i]);
    }
}

TEST_F(ApiDCDisableThreadTest, GetDeviceIDs_01)
{
    uint32_t devNum = 8U;
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(DRV_ERROR_NONE));

    MOCKER(drvGetDevIDs).stubs().will(invoke(drvGetDevIDs_stub_00));

    int32_t visible_device[] = {3, 4, 6, 7};
    size_t visible_device_cnt = sizeof(visible_device) / sizeof(visible_device[0]);
    char env_visible_device[128] = "";
    for (size_t i = 0; i < visible_device_cnt; i++) {
        std::strcat(env_visible_device, std::to_string(visible_device[i]).c_str());
        std::strcat(env_visible_device, ",");
    }
    env_visible_device[std::strlen(env_visible_device) - 1] = '\0';

    setenv("ASCEND_RT_VISIBLE_DEVICES", env_visible_device, 1);
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    const bool haveDevice = rtInstance->isHaveDevice_;
    rtInstance->isHaveDevice_ = true;
    rtError_t ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    uint32_t devices[10];
    (void)memset_s(devices, sizeof(devices), 0xff, sizeof(devices));
    ret = rtGetDeviceIDs(devices, sizeof(devices) / sizeof(devices[0]));
    EXPECT_EQ(ret, RT_ERROR_NONE);
    for (size_t i = 0; i < sizeof(devices) / sizeof(devices[0]); i++) {
        if (i < visible_device_cnt) {
            EXPECT_EQ(i, devices[i]);
        } else {
            EXPECT_EQ(UINT32_MAX, devices[i]);
        }
    }

    unsetenv("ASCEND_RT_VISIBLE_DEVICES");
    rtInstance->isHaveDevice_ = haveDevice;
    rtInstance->isSetVisibleDev = false;
}

TEST_F(ApiDCDisableThreadTest, GetDeviceIDs_02)
{
    uint32_t devNum = 8U;
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(DRV_ERROR_NONE));

    MOCKER(drvGetDevIDs).stubs().will(invoke(drvGetDevIDs_stub_01));

    int32_t visible_device[] = {3, 4, 6, 7};
    size_t visible_device_cnt = sizeof(visible_device) / sizeof(visible_device[0]);
    char env_visible_device[128] = "";
    for (size_t i = 0; i < visible_device_cnt; i++) {
        std::strcat(env_visible_device, std::to_string(visible_device[i]).c_str());
        std::strcat(env_visible_device, ",");
    }
    env_visible_device[std::strlen(env_visible_device) - 1] = '\0';

    setenv("ASCEND_RT_VISIBLE_DEVICES", env_visible_device, 1);
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    const bool haveDevice = rtInstance->isHaveDevice_;
    rtInstance->isHaveDevice_ = true;
    rtError_t ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    uint32_t devices[10];
    (void)memset_s(devices, sizeof(devices), 0xff, sizeof(devices));
    ret = rtGetDeviceIDs(devices, sizeof(devices) / sizeof(devices[0]));
    EXPECT_EQ(ret, RT_ERROR_NONE);
    for (size_t i = 0; i < sizeof(devices) / sizeof(devices[0]); i++) {
        if (i < visible_device_cnt) {
            EXPECT_EQ(i, devices[i]);
        } else {
            EXPECT_EQ(UINT32_MAX, devices[i]);
        }
    }

    unsetenv("ASCEND_RT_VISIBLE_DEVICES");
    rtInstance->isHaveDevice_ = haveDevice;
    rtInstance->isSetVisibleDev = false;
}

TEST_F(ApiDCDisableThreadTest, drvGetDevNum_invalid)
{
    uint32_t devNum = 128U;
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(DRV_ERROR_NONE));

    int32_t visible_device[] = {3, 4, 6, 7};
    size_t visible_device_cnt = sizeof(visible_device) / sizeof(visible_device[0]);
    char env_visible_device[128] = "";
    for (size_t i = 0; i < visible_device_cnt; i++) {
        std::strcat(env_visible_device, std::to_string(visible_device[i]).c_str());
        std::strcat(env_visible_device, ",");
    }
    env_visible_device[std::strlen(env_visible_device) - 1] = '\0';

    setenv("ASCEND_RT_VISIBLE_DEVICES", env_visible_device, 1);
    Runtime *rtInstance = ((Runtime *)Runtime::Instance());
    const bool haveDevice = rtInstance->isHaveDevice_;
    rtInstance->isHaveDevice_ = true;
    rtError_t ret = rtInstance->GetVisibleDevices();
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(rtInstance->isSetVisibleDev, true);

    int32_t count = 0;
    ret = rtGetDeviceCount(&count);
    EXPECT_EQ(ret, ACL_ERROR_RT_NO_DEVICE);

    unsetenv("ASCEND_RT_VISIBLE_DEVICES");
    rtInstance->isHaveDevice_ = haveDevice;
    rtInstance->isSetVisibleDev = false;
}

TEST_F(ApiDCDisableThreadTest, GetDeviceIDs_03)
{
    uint32_t devices[10];
    (void)memset_s(devices, sizeof(devices), 0xff, sizeof(devices));
    size_t arrayLen = sizeof(devices) / sizeof(devices[0]);
    uint32_t devNum = static_cast<uint32_t>(arrayLen);
    MOCKER(drvGetDevNum)
        .stubs()
        .with(outBoundP(&devNum, sizeof(devNum)))
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(drvGetDevIDs).stubs().will(invoke(drvGetDevIDs_stub_00));

    uint32_t limit = 8U;
    rtError_t ret = rtGetDeviceIDs(devices, limit);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    for (size_t i = 0; i < arrayLen; i++) {
        if (i < limit) {
            EXPECT_EQ(i, devices[i]);
        } else {
            EXPECT_EQ(UINT32_MAX, devices[i]);
        }
    }
}