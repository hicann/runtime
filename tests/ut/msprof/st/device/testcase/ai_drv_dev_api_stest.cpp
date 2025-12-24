/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "ai_drv_dev_api.h"
#include "ai_drv_prof_api.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "ascend_hal.h"
#include "config/config_manager.h"
#include "validation/param_validation.h"
#include "utils.h"

using namespace analysis::dvvp::driver;
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::validation;

class DRV_DEV_API_STEST : public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(DRV_DEV_API_STEST, DrvGetPlatformInfo)
{
    GlobalMockObject::verify();
    MOCKER(drvGetPlatformInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(MSPROF_HELPER_HOST))
        .then(returnValue(DRV_ERROR_INVALID_VALUE));
    uint32_t platformInfo;
    EXPECT_EQ(PROFILING_SUCCESS, DrvGetPlatformInfo(platformInfo));
    EXPECT_EQ(PROFILING_SUCCESS, DrvGetPlatformInfo(platformInfo));
    EXPECT_EQ(PROFILING_FAILED, DrvGetPlatformInfo(platformInfo));
}

TEST_F(DRV_DEV_API_STEST, DrvCheckIfHelperHost)
{
    GlobalMockObject::verify();
    MOCKER(drvGetDevNum)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(MSPROF_HELPER_HOST));
    EXPECT_EQ(false, analysis::dvvp::driver::DrvCheckIfHelperHost());
    EXPECT_EQ(true, analysis::dvvp::driver::DrvCheckIfHelperHost());
}

TEST_F(DRV_DEV_API_STEST, DrvGetAivNum)
{
    GlobalMockObject::verify();
    uint32_t deviceId = 0;
    int64_t aivNum = 0;
    ConfigManager::instance()->configMap_["type"] = std::to_string(static_cast<uint64_t>(PlatformType::CHIP_V4_1_0));
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetAivNum(deviceId, aivNum));
    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvGetAivNum(deviceId, aivNum));
    ConfigManager::instance()->configMap_["type"] = std::to_string(static_cast<uint64_t>(PlatformType::DC_TYPE));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetAivNum(deviceId, aivNum));
}

TEST_F(DRV_DEV_API_STEST, DrvGetEnvType) {
    GlobalMockObject::verify();

    uint32_t  deviceId = 0;
    int64_t envType = 0;

    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvGetEnvType(deviceId, envType));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetEnvType(deviceId, envType));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetEnvType(deviceId, envType));
}

TEST_F(DRV_DEV_API_STEST, DrvGetCtrlCpuId) {
    GlobalMockObject::verify();

    uint32_t  deviceId = 0;
    int64_t ctrlCpuId = 0;

    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvGetCtrlCpuId(deviceId, ctrlCpuId));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetCtrlCpuId(deviceId, ctrlCpuId));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetCtrlCpuId(deviceId, ctrlCpuId));
}

TEST_F(DRV_DEV_API_STEST, DrvGetCtrlCpuCoreNum) {
    GlobalMockObject::verify();

    uint32_t  deviceId = 0;
    int64_t ctrlCpuCoreNum = 0;

    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvGetCtrlCpuCoreNum(deviceId, ctrlCpuCoreNum));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetCtrlCpuCoreNum(deviceId, ctrlCpuCoreNum));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetCtrlCpuCoreNum(deviceId, ctrlCpuCoreNum));
}

TEST_F(DRV_DEV_API_STEST, DrvGetCtrlCpuEndianLittle) {
    GlobalMockObject::verify();

    uint32_t  deviceId = 0;
    int64_t ctrlCpuEndianLittle = 0;

    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvGetCtrlCpuEndianLittle(deviceId, ctrlCpuEndianLittle));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetCtrlCpuEndianLittle(deviceId, ctrlCpuEndianLittle));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetCtrlCpuEndianLittle(deviceId, ctrlCpuEndianLittle));
}

TEST_F(DRV_DEV_API_STEST, DrvGetAiCpuCoreNum) {
    GlobalMockObject::verify();

    uint32_t  deviceId = 0;
    int64_t aiCpuCoreNum = 0;

    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvGetAiCpuCoreNum(deviceId, aiCpuCoreNum));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetAiCpuCoreNum(deviceId, aiCpuCoreNum));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetAiCpuCoreNum(deviceId, aiCpuCoreNum));
}

TEST_F(DRV_DEV_API_STEST, DrvGetAiCpuCoreId) {
    GlobalMockObject::verify();

    uint32_t  deviceId = 0;
    int64_t aiCpuCoreId = 0;

    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvGetAiCpuCoreId(deviceId, aiCpuCoreId));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetAiCpuCoreId(deviceId, aiCpuCoreId));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetAiCpuCoreId(deviceId, aiCpuCoreId));
}

TEST_F(DRV_DEV_API_STEST, DrvGetAiCpuOccupyBitmap) {
    GlobalMockObject::verify();

    uint32_t  deviceId = 0;
    int64_t aiCpuOccupyBitmap = 0;

    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvGetAiCpuOccupyBitmap(deviceId, aiCpuOccupyBitmap));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetAiCpuOccupyBitmap(deviceId, aiCpuOccupyBitmap));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetAiCpuOccupyBitmap(deviceId, aiCpuOccupyBitmap));
}

TEST_F(DRV_DEV_API_STEST, DrvGetTsCpuCoreNum) {
    GlobalMockObject::verify();

    uint32_t  deviceId = 0;
    int64_t tsCpuCoreNum = 0;

    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvGetTsCpuCoreNum(deviceId, tsCpuCoreNum));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetTsCpuCoreNum(deviceId, tsCpuCoreNum));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetTsCpuCoreNum(deviceId, tsCpuCoreNum));
}

TEST_F(DRV_DEV_API_STEST, DrvGetAiCoreId) {
    GlobalMockObject::verify();

    uint32_t  deviceId = 0;
    int64_t aiCoreId = 0;

    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvGetAiCoreId(deviceId, aiCoreId));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetAiCoreId(deviceId, aiCoreId));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetAiCoreId(deviceId, aiCoreId));
}

TEST_F(DRV_DEV_API_STEST, DrvGetAiCoreNum) {
    GlobalMockObject::verify();

    uint32_t  deviceId = 0;
    int64_t aiCoreNum = 0;

    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvGetAiCoreNum(deviceId, aiCoreNum));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetAiCoreNum(deviceId, aiCoreNum));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetAiCoreNum(deviceId, aiCoreNum));
}

TEST_F(DRV_DEV_API_STEST, DrvGetDeviceTime) {
    GlobalMockObject::verify();

    uint32_t  deviceId = 0;
    uint64_t startMono = 0;
    uint64_t cntvct = 0;

    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT))
        .then(returnValue(DRV_ERROR_NOT_SUPPORT));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvGetDeviceTime(deviceId, startMono, cntvct));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetDeviceTime(deviceId, startMono, cntvct));
    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvGetDeviceTime(deviceId, startMono, cntvct));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvGetDeviceTime(deviceId, startMono, cntvct));
}

TEST_F(DRV_DEV_API_STEST, DrvChannelRead) {
    GlobalMockObject::verify();

    int prof_device_id = 0;
    analysis::dvvp::driver::AI_DRV_CHANNEL prof_channel = analysis::dvvp::driver::PROF_CHANNEL_HBM;
    unsigned char out_buf[4096];
    uint32_t buf_size = 4096;

    MOCKER(prof_channel_read)
        .stubs()
        .will(returnValue(PROF_ERROR))
        .then(returnValue(64))
	.then(returnValue(PROF_STOPPED_ALREADY));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvChannelRead(
        prof_device_id, prof_channel, nullptr, 0));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvChannelRead(
        prof_device_id, prof_channel, out_buf, buf_size));

    EXPECT_EQ(64, analysis::dvvp::driver::DrvChannelRead(
        prof_device_id, prof_channel, out_buf, buf_size));
    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvChannelRead(
        prof_device_id, prof_channel, out_buf, buf_size));
}

TEST_F(DRV_DEV_API_STEST, DrvChannelPoll) {
    GlobalMockObject::verify();

    struct prof_poll_info out_buf[2];

    MOCKER(prof_channel_poll)
        .stubs()
        .will(returnValue(PROF_ERROR))
        .then(returnValue(PROF_OK));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvChannelPoll(
        nullptr, 0, 1));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvChannelPoll(
        out_buf, 2, 1));

    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvChannelPoll(
        out_buf, 2, 1));
}

TEST_F(DRV_DEV_API_STEST, DrvProfFlush) {
    GlobalMockObject::verify();

    MOCKER(halProfDataFlush)
        .stubs()
        .will(returnValue(PROF_ERROR))
        .then(returnValue(PROF_STOPPED_ALREADY))
        .then(returnValue(PROF_OK));
    unsigned int bufSize = 0;
    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvProfFlush(
        0, 0, bufSize));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::driver::DrvProfFlush(
        0, 2, bufSize));

    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::driver::DrvProfFlush(
        0, 2, bufSize));
}