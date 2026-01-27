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

static void MakeDir(const char * const dirName)
{
    const std::string cmd = "mkdir -p ";
    const std::string name = dirName;
    const std::string full_command = cmd + name;

    system(full_command.c_str());
}

static void CreateACorrectIniFile(const char * const filename)
{
    std::ofstream myfile;
    myfile.open(filename);

    myfile<<"[Global Config]\n";
    myfile<<"IsStreamSyncEschedMode=1\n";

    myfile.close();
}


class ApiDCDisableThreadOfflineTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_3));
        (void)rtSetSocVersion("Ascend310P");
        flag = ((Runtime *)Runtime::Instance())->GetDisableThread();
        ((Runtime *)Runtime::Instance())->SetDisableThread(true);
        originType_ = Runtime::Instance()->GetChipType();
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(CHIP_DC);
        GlobalContainer::SetRtChipType(CHIP_DC);

        const std::string pathDirPrefix = "/tmp";
        const std::string pathDirPosfix = "/runtime/conf/";
        const std::string pathDir = pathDirPrefix + pathDirPosfix;
        const std::string pathFilename = "RuntimeConfig.ini";
        const std::string pathFull = pathDir + pathFilename;
        MakeDir(pathDir.c_str());
        CreateACorrectIniFile(pathFull.c_str());
        setenv("ASCEND_LATEST_INSTALL_PATH", pathDirPrefix.c_str(), 1);
        rtInstance->ReadStreamSyncModeFromConfigIni();
        EXPECT_EQ(rtInstance->isStreamSyncEsched_, true);

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

        unsetenv("ASCEND_LATEST_INSTALL_PATH");

        std::cout<<"api  test start:"<<error1<<", "<<error2<<", "<<error3<<", "<<error4<<std::endl;
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
    static bool flag;
};

rtStream_t ApiDCDisableThreadOfflineTest::stream_ = NULL;
rtEvent_t ApiDCDisableThreadOfflineTest::event_ = NULL;
void* ApiDCDisableThreadOfflineTest::binHandle_ = nullptr;
char  ApiDCDisableThreadOfflineTest::function_ = 'a';
uint32_t ApiDCDisableThreadOfflineTest::binary_[32] = {};
rtChipType_t ApiDCDisableThreadOfflineTest::originType_ = CHIP_CLOUD;
bool ApiDCDisableThreadOfflineTest::flag = false;

TEST_F(ApiDCDisableThreadOfflineTest, StreamSync_Esched)
{
    rtError_t error;
    rtRunMode mode;
    rtStream_t stm = NULL;

    MOCKER(memcpy_s).stubs().will(returnValue(NULL));

    const bool isDisableThread = Runtime::Instance()->GetDisableThread();
    EXPECT_EQ(isDisableThread, true);

    error = rtGetRunMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_RUN_MODE_OFFLINE);

    // tid not in rtInstance->eschedMap_
    error = rtStreamCreate(&stm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // tid in rtInstance->eschedMap_
    error = rtStreamCreate(&stm, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // tid in rtInstance->eschedMap_
    error = rtStreamSynchronize(stm);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // tid not in rtInstance->eschedMap_
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->eschedMap_.clear();
    error = rtStreamSynchronize(stm);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDCDisableThreadOfflineTest, read_streamSync_mode)
{
    char_t *env = nullptr;
    MOCKER(getenv).stubs().will(returnValue(env));
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtInstance->ReadStreamSyncModeFromConfigIni();
    EXPECT_EQ(rtInstance->isStreamSyncEsched_, false);
    GlobalMockObject::verify();
}