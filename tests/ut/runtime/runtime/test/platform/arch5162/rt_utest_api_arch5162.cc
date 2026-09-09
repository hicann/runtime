/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "runtime/rt.h"
#include "api_impl.hpp"
#include "api_error.hpp"
#include "aicpu_dfx.hpp"

using namespace cce::runtime;

TEST(Arch5162ApiTest, KernelArgsApiImplStub_NotSupport)
{
    ApiImpl apiImpl;

    EXPECT_EQ(apiImpl.KernelArgsGetHandleMemSize(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.KernelArgsFinalize(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.KernelArgsInitByUserMem(nullptr, nullptr, nullptr, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.KernelArgsGetMemSize(nullptr, 0U, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.KernelArgsInit(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.KernelArgsAppendPlaceHolder(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.KernelArgsGetPlaceHolderBuffer(nullptr, nullptr, 0U, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiImpl.KernelArgsAppend(nullptr, nullptr, 0U, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST(Arch5162ApiTest, AicpuFifoPrintfDfxDisabled) { EXPECT_EQ(SetupAicpuPrintfDfx(nullptr, 0U), RT_ERROR_NONE); }

TEST(Arch5162ApiTest, GetDeviceReturnsFixedDeviceId)
{
    int32_t deviceId = -1;

    EXPECT_EQ(rtGetDevice(&deviceId), RT_ERROR_NONE);
    EXPECT_EQ(deviceId, 0);
}

TEST(Arch5162ApiTest, GetDeviceRejectsNullOutput) { EXPECT_EQ(rtGetDevice(nullptr), ACL_ERROR_RT_PARAM_INVALID); }

TEST(Arch5162ApiTest, ModelTaskUpdateApiErrorStub_NotSupport)
{
    ApiErrorDecorator api(nullptr);
    EXPECT_EQ(api.ModelTaskUpdate(nullptr, 0U, nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);

    rtMdlTaskUpdateInfo_t updateInfo = {};
    EXPECT_EQ(api.ModelTaskUpdate(nullptr, 0U, nullptr, &updateInfo), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtModelTaskUpdate(nullptr, 0U, nullptr, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
