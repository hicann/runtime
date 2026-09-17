/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "rt_utest_api.hpp"

#include "api_rt_config.hpp"

using namespace cce::runtime;
using namespace testing;

namespace {
constexpr uint32_t kReturnedValue = 17U;
constexpr int64_t kReturnedConfigValue = 23;

class ApiRtConfigRouteStub : public ApiRtConfig {
public:
    rtError_t CtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal) override
    {
        ++ctxSetSysParamCount_;
        configOpt_ = configOpt;
        configVal_ = configVal;
        return RT_ERROR_NONE;
    }

    rtError_t CtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t* const configVal) override
    {
        ++ctxGetSysParamCount_;
        configOpt_ = configOpt;
        *configVal = kReturnedConfigValue;
        return RT_ERROR_NONE;
    }

    rtError_t SetDeviceResLimit(const uint32_t devId, const rtDevResLimitType_t type, const uint32_t value) override
    {
        ++setDeviceCount_;
        devId_ = devId;
        type_ = type;
        value_ = value;
        return RT_ERROR_NONE;
    }

    rtError_t ResetDeviceResLimit(const uint32_t devId) override
    {
        ++resetDeviceCount_;
        devId_ = devId;
        return RT_ERROR_NONE;
    }

    rtError_t GetDeviceResLimit(const uint32_t devId, const rtDevResLimitType_t type, uint32_t* const value) override
    {
        ++getDeviceCount_;
        devId_ = devId;
        type_ = type;
        *value = kReturnedValue;
        return RT_ERROR_NONE;
    }

    rtError_t SetStreamResLimit(Stream* const stm, const rtDevResLimitType_t type, const uint32_t value) override
    {
        ++setStreamCount_;
        stream_ = stm;
        type_ = type;
        value_ = value;
        return RT_ERROR_NONE;
    }

    rtError_t ResetStreamResLimit(Stream* const stm) override
    {
        ++resetStreamCount_;
        stream_ = stm;
        return RT_ERROR_NONE;
    }

    rtError_t GetStreamResLimit(const Stream* const stm, const rtDevResLimitType_t type, uint32_t* const value) override
    {
        ++getStreamCount_;
        stream_ = stm;
        type_ = type;
        *value = kReturnedValue;
        return RT_ERROR_NONE;
    }

    rtError_t UseStreamResInCurrentThread(const Stream* const stm) override
    {
        ++useStreamCount_;
        stream_ = stm;
        return RT_ERROR_NONE;
    }

    rtError_t NotUseStreamResInCurrentThread(const Stream* const stm) override
    {
        ++notUseStreamCount_;
        stream_ = stm;
        return RT_ERROR_NONE;
    }

    rtError_t GetResInCurrentThread(const rtDevResLimitType_t type, uint32_t* const value) override
    {
        ++getThreadCount_;
        type_ = type;
        *value = kReturnedValue;
        return RT_ERROR_NONE;
    }

    uint32_t ctxSetSysParamCount_ = 0U;
    uint32_t ctxGetSysParamCount_ = 0U;
    uint32_t setDeviceCount_ = 0U;
    uint32_t resetDeviceCount_ = 0U;
    uint32_t getDeviceCount_ = 0U;
    uint32_t setStreamCount_ = 0U;
    uint32_t resetStreamCount_ = 0U;
    uint32_t getStreamCount_ = 0U;
    uint32_t useStreamCount_ = 0U;
    uint32_t notUseStreamCount_ = 0U;
    uint32_t getThreadCount_ = 0U;
    uint32_t devId_ = 0U;
    rtDevResLimitType_t type_ = RT_DEV_RES_CUBE_CORE;
    uint32_t value_ = 0U;
    rtSysParamOpt configOpt_ = SYS_OPT_DETERMINISTIC;
    int64_t configVal_ = 0;
    const Stream* stream_ = nullptr;
};

class ApiRtConfigRouteTest : public Test {
protected:
    void SetUp() override
    {
        runtime_ = Runtime::Instance();
        ASSERT_NE(runtime_, nullptr);
        oldApiRtConfig_ = runtime_->apiRtConfig_;
        runtime_->apiRtConfig_ = &apiRtConfig_;
    }

    void TearDown() override
    {
        runtime_->apiRtConfig_ = oldApiRtConfig_;
        GlobalMockObject::verify();
    }

    Runtime* runtime_ = nullptr;
    ApiRtConfig* oldApiRtConfig_ = nullptr;
    ApiRtConfigRouteStub apiRtConfig_;
};
} // namespace

TEST_F(ApiRtConfigRouteTest, RoutesClassBackedApisToApiRtConfig)
{
    constexpr int32_t devId = 3;
    constexpr uint32_t inputValue = 11U;
    constexpr int64_t inputConfigValue = 2;
    uint32_t value = 0U;
    int64_t configValue = 0;

    EXPECT_EQ(rtCtxSetSysParamOpt(SYS_OPT_DETERMINISTIC, inputConfigValue), ACL_RT_SUCCESS);
    EXPECT_EQ(rtCtxGetSysParamOpt(SYS_OPT_DETERMINISTIC, &configValue), ACL_RT_SUCCESS);
    EXPECT_EQ(configValue, kReturnedConfigValue);
    EXPECT_EQ(rtsCtxSetSysParamOpt(SYS_OPT_DETERMINISTIC, inputConfigValue), ACL_RT_SUCCESS);
    EXPECT_EQ(rtsCtxGetSysParamOpt(SYS_OPT_DETERMINISTIC, &configValue), ACL_RT_SUCCESS);
    EXPECT_EQ(configValue, kReturnedConfigValue);

    EXPECT_EQ(rtsSetDeviceResLimit(devId, RT_DEV_RES_VECTOR_CORE, inputValue), ACL_RT_SUCCESS);
    EXPECT_EQ(rtsResetDeviceResLimit(devId), ACL_RT_SUCCESS);
    EXPECT_EQ(rtsGetDeviceResLimit(devId, RT_DEV_RES_VECTOR_CORE, &value), ACL_RT_SUCCESS);
    EXPECT_EQ(value, kReturnedValue);
    EXPECT_EQ(rtsSetStreamResLimit(nullptr, RT_DEV_RES_VECTOR_CORE, inputValue), ACL_RT_SUCCESS);
    EXPECT_EQ(rtsResetStreamResLimit(nullptr), ACL_RT_SUCCESS);
    EXPECT_EQ(rtsGetStreamResLimit(nullptr, RT_DEV_RES_VECTOR_CORE, &value), ACL_RT_SUCCESS);
    EXPECT_EQ(value, kReturnedValue);
    EXPECT_EQ(rtsUseStreamResInCurrentThread(nullptr), ACL_RT_SUCCESS);
    EXPECT_EQ(rtsNotUseStreamResInCurrentThread(nullptr), ACL_RT_SUCCESS);
    EXPECT_EQ(rtsGetResInCurrentThread(RT_DEV_RES_VECTOR_CORE, &value), ACL_RT_SUCCESS);
    EXPECT_EQ(value, kReturnedValue);

    EXPECT_EQ(apiRtConfig_.ctxSetSysParamCount_, 2U);
    EXPECT_EQ(apiRtConfig_.ctxGetSysParamCount_, 2U);
    EXPECT_EQ(apiRtConfig_.configOpt_, SYS_OPT_DETERMINISTIC);
    EXPECT_EQ(apiRtConfig_.configVal_, inputConfigValue);
    EXPECT_EQ(apiRtConfig_.setDeviceCount_, 1U);
    EXPECT_EQ(apiRtConfig_.resetDeviceCount_, 1U);
    EXPECT_EQ(apiRtConfig_.getDeviceCount_, 1U);
    EXPECT_EQ(apiRtConfig_.setStreamCount_, 1U);
    EXPECT_EQ(apiRtConfig_.resetStreamCount_, 1U);
    EXPECT_EQ(apiRtConfig_.getStreamCount_, 1U);
    EXPECT_EQ(apiRtConfig_.useStreamCount_, 1U);
    EXPECT_EQ(apiRtConfig_.notUseStreamCount_, 1U);
    EXPECT_EQ(apiRtConfig_.getThreadCount_, 1U);
    EXPECT_EQ(apiRtConfig_.devId_, static_cast<uint32_t>(devId));
    EXPECT_EQ(apiRtConfig_.type_, RT_DEV_RES_VECTOR_CORE);
    EXPECT_EQ(apiRtConfig_.value_, inputValue);
    EXPECT_EQ(apiRtConfig_.stream_, nullptr);
}

TEST_F(ApiRtConfigRouteTest, RejectsNegativeDeviceIdBeforeDispatch)
{
    uint32_t value = 0U;

    EXPECT_EQ(rtsSetDeviceResLimit(-1, RT_DEV_RES_CUBE_CORE, 0U), ACL_ERROR_RT_INVALID_DEVICEID);
    EXPECT_EQ(rtsResetDeviceResLimit(-1), ACL_ERROR_RT_INVALID_DEVICEID);
    EXPECT_EQ(rtsGetDeviceResLimit(-1, RT_DEV_RES_CUBE_CORE, &value), ACL_ERROR_RT_INVALID_DEVICEID);
    EXPECT_EQ(apiRtConfig_.setDeviceCount_, 0U);
    EXPECT_EQ(apiRtConfig_.resetDeviceCount_, 0U);
    EXPECT_EQ(apiRtConfig_.getDeviceCount_, 0U);
}

TEST_F(ApiRtConfigRouteTest, ReturnsInternalErrorWhenApiRtConfigMissing)
{
    runtime_->apiRtConfig_ = nullptr;
    EXPECT_EQ(rtsResetDeviceResLimit(0), ACL_ERROR_RT_INTERNAL_ERROR);
}

TEST_F(ApiRtConfigRouteTest, ProcessSysParamApisDoNotDependOnApiRtConfig)
{
    runtime_->apiRtConfig_ = nullptr;
    int64_t configValue = 0;

    EXPECT_EQ(rtSetSysParamOpt(SYS_OPT_DETERMINISTIC, 2), ACL_RT_SUCCESS);
    EXPECT_EQ(rtGetSysParamOpt(SYS_OPT_DETERMINISTIC, &configValue), ACL_RT_SUCCESS);
    EXPECT_EQ(configValue, 2);
    EXPECT_EQ(rtsSetSysParamOpt(SYS_OPT_DETERMINISTIC, 3), ACL_RT_SUCCESS);
    EXPECT_EQ(rtsGetSysParamOpt(SYS_OPT_DETERMINISTIC, &configValue), ACL_RT_SUCCESS);
    EXPECT_EQ(configValue, 3);
}
