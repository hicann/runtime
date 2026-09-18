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

#include "api_impl_creator.hpp"
#include "rt_error_codes.h"
#include "runtime/rt.h"
#include "runtime/rts/rts_context.h"
#include "runtime/rts/rts_device.h"
#include "runtime/rts/rts_stream.h"

using namespace cce::runtime;

TEST(ApiRtConfigStubTest, RtConfigImplLifecycleNotSupport)
{
    EXPECT_FALSE(IsImplRtConfigSupported());
    ApiRtConfig* apiImplRtConfig = CreateImplRtConfigAndGet();
    EXPECT_EQ(apiImplRtConfig, nullptr);

    DestroyImplRtConfig(apiImplRtConfig);

    EXPECT_EQ(apiImplRtConfig, nullptr);
}

TEST(ApiRtConfigStubTest, RtConfigApisNotSupport)
{
    uint32_t value = 0U;
    int64_t configValue = 0;

    EXPECT_EQ(rtSetSysParamOpt(SYS_OPT_DETERMINISTIC, 0), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtGetSysParamOpt(SYS_OPT_DETERMINISTIC, &configValue), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsSetSysParamOpt(SYS_OPT_DETERMINISTIC, 0), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsGetSysParamOpt(SYS_OPT_DETERMINISTIC, &configValue), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtCtxSetSysParamOpt(SYS_OPT_DETERMINISTIC, 0), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtCtxGetSysParamOpt(SYS_OPT_DETERMINISTIC, &configValue), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsCtxSetSysParamOpt(SYS_OPT_DETERMINISTIC, 0), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsCtxGetSysParamOpt(SYS_OPT_DETERMINISTIC, &configValue), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    EXPECT_EQ(rtsGetDeviceResLimit(0, RT_DEV_RES_CUBE_CORE, &value), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsSetDeviceResLimit(0, RT_DEV_RES_CUBE_CORE, 0U), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsResetDeviceResLimit(0), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsGetStreamResLimit(nullptr, RT_DEV_RES_CUBE_CORE, &value), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsSetStreamResLimit(nullptr, RT_DEV_RES_CUBE_CORE, 0U), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsResetStreamResLimit(nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsUseStreamResInCurrentThread(nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsNotUseStreamResInCurrentThread(nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsGetResInCurrentThread(RT_DEV_RES_CUBE_CORE, &value), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
