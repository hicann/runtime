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
#include "api_impl_creator.hpp"
#include "api_impl.hpp"
#include "api_error.hpp"
#include "aicpu_dfx.hpp"
#include "model.hpp"
#include "snapshot_socket.hpp"

using namespace cce::runtime;

TEST(Arch5162ApiTest, GetDevMsg_NullCallback_ReturnsSuccess)
{
    ApiImpl api;

    const rtGetDevMsgType_t messageTypes[] = {
        RT_GET_DEV_ERROR_MSG, RT_GET_DEV_RUNNING_STREAM_SNAPSHOT_MSG, RT_GET_DEV_PID_SNAPSHOT_MSG};
    for (const auto messageType : messageTypes) {
        EXPECT_EQ(api.GetDevMsg(messageType, nullptr), RT_ERROR_NONE);
    }
}

TEST(Arch5162ApiTest, GetDevMsg_ReturnsSuccessWithoutInvokingCallback)
{
    ApiImpl api;
    const rtGetMsgCallback callback = [](const char_t*, uint32_t) {
        ADD_FAILURE() << "GetDevMsg must not invoke the callback when device messages are disabled.";
    };
    const rtGetDevMsgType_t messageTypes[] = {
        RT_GET_DEV_ERROR_MSG, RT_GET_DEV_RUNNING_STREAM_SNAPSHOT_MSG, RT_GET_DEV_PID_SNAPSHOT_MSG};
    for (const auto messageType : messageTypes) {
        EXPECT_EQ(api.GetDevMsg(messageType, callback), RT_ERROR_NONE);
    }
}

TEST(Arch5162ApiTest, SnapshotApiImplStub_NotSupport)
{
    EXPECT_FALSE(IsImplSnapshotSupported());
    ApiSnapshot* apiImplSnapshot = CreateImplSnapshotAndGet();
    EXPECT_EQ(apiImplSnapshot, nullptr);
    DestroyImplSnapshot(apiImplSnapshot);
}

TEST(Arch5162ApiTest, SnapshotSocketStubDoesNotStartServiceOrChangeQueryOutput)
{
    SnapshotService service;
    EXPECT_EQ(service.StartSnapshotService(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(service.GetSnapshotThreadId(), 0);
    service.StopSnapshotService();
    uint32_t value = 123U;
    const rtSnapshotOp operations[] = {rtSnapshotOp::LOCK,      rtSnapshotOp::BACKUP,
                                       rtSnapshotOp::RESTORE,   rtSnapshotOp::UNLOCK,
                                       rtSnapshotOp::GET_STATE, rtSnapshotOp::GET_RESTORE_THREAD_ID};
    for (const auto op : operations) {
        EXPECT_EQ(SnapshotSocketCall(mmGetPid(), op, nullptr, value), RT_ERROR_FEATURE_NOT_SUPPORT);
        EXPECT_EQ(value, 123U);
    }
}

TEST(Arch5162ApiTest, KernelArgsImplLifecycleNotSupport)
{
    EXPECT_FALSE(IsImplKernelArgsSupported());

    ApiKernelArgs* apiImplKernelArgs = CreateImplKernelArgsAndGet();
    EXPECT_EQ(apiImplKernelArgs, nullptr);

    DestroyImplKernelArgs(apiImplKernelArgs);
    EXPECT_EQ(apiImplKernelArgs, nullptr);
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

TEST(Arch5162ApiTest, HcclModelStreamPublicApisBehaviors)
{
    uint32_t count = 17U;
    rtStream_t stream = static_cast<void*>(&count);
    rtModel_t model = static_cast<void*>(&count);
    EXPECT_EQ(rtModelAddHcclStream(nullptr, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtModelAddHcclStream(stream, model), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtModelGetHcclStream(nullptr, nullptr, nullptr), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(rtModelGetHcclStream(model, &stream, &count), ACL_ERROR_RT_INVALID_HANDLE);
    EXPECT_EQ(count, 17U);
    EXPECT_EQ(stream, static_cast<void*>(&count));
    EXPECT_EQ(rtGetModelByStream(nullptr, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtGetModelByStream(stream, &model), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(model, static_cast<void*>(&count));
}

TEST(Arch5162ApiTest, HcclModelStreamInternalProvidersBehaviors)
{
    ApiImpl impl;
    EXPECT_EQ(impl.HcclStreamAddToModel(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    Model model;
    Model* bound = &model;
    std::vector<Stream*> streams{nullptr};
    EXPECT_EQ(impl.ModelGetHcclStream(&model, streams), RT_ERROR_NONE);
    EXPECT_EQ(streams, (std::vector<Stream*>{}));

    ApiErrorDecorator error(&impl);
    EXPECT_EQ(error.HcclStreamAddToModel(nullptr, nullptr), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(error.ModelGetHcclStream(&model, streams), RT_ERROR_NONE);
    EXPECT_EQ(error.GetModelByStream(nullptr, &bound), RT_ERROR_INVALID_VALUE);

    EXPECT_EQ(model.RegisterHcclStream(nullptr), RT_ERROR_NONE);
    EXPECT_EQ(model.CollectHcclStreams(streams), RT_ERROR_NONE);
    EXPECT_EQ(bound, &model);
    EXPECT_EQ(streams, (std::vector<Stream*>{nullptr}));
}

TEST(Arch5162ApiTest, SimtDimensionValidation_NotSupport)
{
    const rtDim3 validDim = {1U, 1U, 1U};
    const rtDim3 invalidDim = {0U, 0U, 0U};
    for (const bool isDim3Form : {false, true}) {
        EXPECT_EQ(CheckSimtDims(validDim, validDim, isDim3Form), RT_ERROR_FEATURE_NOT_SUPPORT);
        EXPECT_EQ(CheckSimtDims(invalidDim, invalidDim, isDim3Form), RT_ERROR_FEATURE_NOT_SUPPORT);
    }
}
