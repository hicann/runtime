/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <algorithm>
#include <atomic>
#include <memory>
#include <set>
#include <thread>
#include <vector>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "runtime/rt.h"
#include "rt_external_model.h"
#define private public
#define protected public
#include "api_impl.hpp"
#include "api_error.hpp"
#include "api_handle_guard.h"
#include "capture_model.hpp"
#include "context.hpp"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "stream.hpp"
#include "runtime/feature/aclgraph/capture_session.hpp"
#undef protected
#undef private
#include "rt_unwrap.h"
#include "rt_capture_model_mock_helper.hpp"

using namespace testing;
using namespace cce::runtime;

class HcclModelStreamApiTest : public testing::Test {
protected:
    void SetUp() override
    {
        ASSERT_EQ(rtSetDevice(0), ACL_RT_SUCCESS);
        rtContext_t ctx = nullptr;
        ASSERT_EQ(rtCtxGetCurrent(&ctx), ACL_RT_SUCCESS);
        context_ = static_cast<Context*>(ctx);
    }

    void TearDown() override
    {
        GlobalMockObject::verify();
        for (auto it = models_.rbegin(); it != models_.rend(); ++it) {
            EXPECT_EQ(rtModelDestroy(*it), ACL_RT_SUCCESS);
        }
        for (auto it = streams_.rbegin(); it != streams_.rend(); ++it) {
            EXPECT_EQ(rtStreamDestroy(*it), ACL_RT_SUCCESS);
        }
        EXPECT_EQ(rtDeviceReset(0), ACL_RT_SUCCESS);
    }

    rtModel_t CreateModel()
    {
        rtModel_t model = nullptr;
        EXPECT_EQ(rtModelCreate(&model, 0U), ACL_RT_SUCCESS);
        models_.push_back(model);
        return model;
    }

    rtStream_t CreateStream(uint32_t flags = 0U)
    {
        rtStream_t stream = nullptr;
        EXPECT_EQ(rtStreamCreateWithFlags(&stream, 0, flags), ACL_RT_SUCCESS);
        streams_.push_back(stream);
        return stream;
    }

    void BeginCapture(rtStream_t stream, rtModel_t& model)
    {
        ASSERT_EQ(rtStreamBeginCapture(stream, RT_STREAM_CAPTURE_MODE_GLOBAL), ACL_RT_SUCCESS);
        rtStreamCaptureStatus status = RT_STREAM_CAPTURE_STATUS_NONE;
        ASSERT_EQ(rtStreamGetCaptureInfo(stream, &status, &model), ACL_RT_SUCCESS);
        ASSERT_EQ(status, RT_STREAM_CAPTURE_STATUS_ACTIVE);
        models_.push_back(model);
    }

    void EndCapture(rtStream_t stream, rtModel_t model)
    {
        MOCK_CAPTURE_MODEL_LOAD_COMPLETE(stream);
        rtModel_t result = nullptr;
        ASSERT_EQ(rtStreamEndCapture(stream, &result), ACL_RT_SUCCESS);
        EXPECT_EQ(result, model);
    }

    Context* context_ = nullptr;
    std::vector<rtModel_t> models_;
    std::vector<rtStream_t> streams_;
};

class HcclModelStreamQueryApiTest : public HcclModelStreamApiTest, public WithParamInterface<ModelType> {
protected:
    void CreateRegistration(rtModel_t& model, rtStream_t& stream)
    {
        stream = CreateStream();
        if (GetParam() == RT_MODEL_NORMAL) {
            model = CreateModel();
            ASSERT_EQ(rtModelAddHcclStream(stream, model), ACL_RT_SUCCESS);
            return;
        }
        const rtStream_t origin = CreateStream();
        BeginCapture(origin, model);
        ASSERT_EQ(rtModelAddHcclStream(stream, model), ACL_RT_SUCCESS);
        EndCapture(origin, model);
    }

    void CheckQuery(rtModel_t model, rtStream_t expectedStream)
    {
        uint32_t count = 17U;
        ASSERT_EQ(rtModelGetHcclStream(model, nullptr, &count), ACL_RT_SUCCESS);
        EXPECT_EQ(count, 1U);
        rtStream_t streams[2] = {nullptr, expectedStream};
        count = 2U;
        ASSERT_EQ(rtModelGetHcclStream(model, streams, &count), ACL_RT_SUCCESS);
        EXPECT_EQ(count, 1U);
        EXPECT_EQ(streams[0], expectedStream);
        EXPECT_EQ(streams[1], expectedStream);
    }
};

TEST_P(HcclModelStreamQueryApiTest, QueryWorksFromAnotherContextWithoutRelaxingRegistration)
{
    rtModel_t model = nullptr;
    rtStream_t stream = nullptr;
    CreateRegistration(model, stream);
    ASSERT_NE(model, nullptr);
    ASSERT_NE(stream, nullptr);
    rtContext_t otherContext = nullptr;
    ASSERT_EQ(rtCtxCreate(&otherContext, 0U, 0), ACL_RT_SUCCESS);
    const auto destroyContext = [this](rtContext_t ctx) {
        EXPECT_EQ(rtCtxSetCurrent(context_), ACL_RT_SUCCESS);
        EXPECT_EQ(rtCtxDestroy(ctx), ACL_RT_SUCCESS);
    };
    const std::unique_ptr<void, decltype(destroyContext)> contextGuard(otherContext, destroyContext);

    CheckQuery(model, stream);
    rtContext_t current = nullptr;
    EXPECT_EQ(rtCtxGetCurrent(&current), ACL_RT_SUCCESS);
    EXPECT_EQ(current, otherContext);
    EXPECT_EQ(rtModelAddHcclStream(stream, model), ACL_ERROR_RT_STREAM_CONTEXT);
}

TEST_P(HcclModelStreamQueryApiTest, QueryDoesNotRequireOrSetCurrentContext)
{
    rtModel_t model = nullptr;
    rtStream_t stream = nullptr;
    CreateRegistration(model, stream);
    ASSERT_NE(model, nullptr);
    ASSERT_NE(stream, nullptr);
    std::thread query([&]() {
        EXPECT_EQ(Runtime::Instance()->CurrentContext(), nullptr);
        CheckQuery(model, stream);
        EXPECT_EQ(Runtime::Instance()->CurrentContext(), nullptr);
    });
    query.join();
}

INSTANTIATE_TEST_SUITE_P(ModelTypes, HcclModelStreamQueryApiTest, Values(RT_MODEL_NORMAL, RT_MODEL_CAPTURE_MODEL));

TEST_F(HcclModelStreamApiTest, NormalRegistrationDeduplicatesWithoutExecutionBinding)
{
    const rtModel_t model = CreateModel();
    const rtStream_t stream = CreateStream();
    Model* const modelObj = rt_ut::UnwrapOrNull<Model>(model);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    const auto flags = streamObj->Flags();
    const auto modelStreams = modelObj->streams_.size();
    ASSERT_EQ(rtModelAddHcclStream(stream, model), ACL_RT_SUCCESS);
    ASSERT_EQ(rtModelAddHcclStream(stream, model), ACL_RT_SUCCESS);
    ApiDecorator forwarding(Api::Instance());
    ASSERT_EQ(forwarding.HcclStreamAddToModel(streamObj, modelObj), RT_ERROR_NONE);
    EXPECT_EQ(streamObj->Model_(), nullptr);
    EXPECT_EQ(streamObj->Flags(), flags);
    EXPECT_EQ(modelObj->streams_.size(), modelStreams);
    EXPECT_EQ(streamObj->Context_(), context_);
    EXPECT_EQ(streamObj->GetCaptureStream(), nullptr);
    uint32_t count = 99U;
    EXPECT_EQ(rtModelGetHcclStream(model, nullptr, &count), ACL_RT_SUCCESS);
    EXPECT_EQ(count, 1U);
    rtModel_t bound = model;
    EXPECT_EQ(rtGetModelByStream(stream, &bound), ACL_RT_SUCCESS);
    EXPECT_EQ(bound, nullptr);
    EXPECT_EQ(rtStreamAddToModel(stream, model), ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(HcclModelStreamApiTest, SharedOriginalStreamSurvivesModelDestruction)
{
    const rtModel_t first = CreateModel();
    const rtModel_t second = CreateModel();
    const rtStream_t stream = CreateStream();
    ASSERT_EQ(rtModelAddHcclStream(stream, first), ACL_RT_SUCCESS);
    ASSERT_EQ(rtModelAddHcclStream(stream, second), ACL_RT_SUCCESS);
    ASSERT_EQ(rtModelDestroy(first), ACL_RT_SUCCESS);
    models_.erase(models_.begin());
    rtStream_t result = nullptr;
    uint32_t count = 1U;
    EXPECT_EQ(rtModelGetHcclStream(second, &result, &count), ACL_RT_SUCCESS);
    EXPECT_EQ(result, stream);
    Stream* streamObj = nullptr;
    EXPECT_EQ(ValidateStreamHandleForApi(result, streamObj, __func__), RT_ERROR_NONE);
    EXPECT_EQ(streamObj, rt_ut::UnwrapOrNull<Stream>(stream));
}

TEST_P(HcclModelStreamQueryApiTest, ArrayQueriesRespectInputCapacity)
{
    const rtStream_t first = CreateStream();
    const rtStream_t second = CreateStream();
    const rtStream_t sentinel = CreateStream();
    rtModel_t model = nullptr;
    rtStream_t origin = nullptr;
    if (GetParam() == RT_MODEL_NORMAL) {
        model = CreateModel();
    } else {
        origin = CreateStream();
        BeginCapture(origin, model);
    }
    ASSERT_EQ(rtModelAddHcclStream(first, model), ACL_RT_SUCCESS);
    ASSERT_EQ(rtModelAddHcclStream(second, model), ACL_RT_SUCCESS);
    for (uint32_t capacity : {0U, 1U, 2U, 3U}) {
        rtStream_t result[3] = {sentinel, sentinel, sentinel};
        uint32_t count = capacity;
        const rtError_t expected = capacity < 2U ? ACL_ERROR_RT_INSUFFICIENT_INPUT_ARRAY : ACL_RT_SUCCESS;
        ASSERT_EQ(rtModelGetHcclStream(model, result, &count), expected);
        EXPECT_EQ(count, capacity < 2U ? capacity : 2U);
        if (capacity < 2U) {
            EXPECT_EQ(result[0], sentinel);
            EXPECT_EQ(result[1], sentinel);
        } else {
            EXPECT_EQ((std::set<rtStream_t>{result[0], result[1]}), (std::set<rtStream_t>{first, second}));
        }
        EXPECT_EQ(result[2], sentinel);
    }
    if (origin != nullptr) {
        EndCapture(origin, model);
    }
}

TEST_F(HcclModelStreamApiTest, EmptyModelQueriesNeverWriteArrayElements)
{
    const rtModel_t model = CreateModel();
    const rtStream_t sentinel = CreateStream();
    for (uint32_t initialCount : {0U, UINT32_MAX}) {
        uint32_t count = initialCount;
        EXPECT_EQ(rtModelGetHcclStream(model, nullptr, &count), ACL_RT_SUCCESS);
        EXPECT_EQ(count, 0U);
    }
    for (uint32_t capacity : {0U, 1U}) {
        rtStream_t result = sentinel;
        uint32_t count = capacity;
        EXPECT_EQ(rtModelGetHcclStream(model, &result, &count), ACL_RT_SUCCESS);
        EXPECT_EQ(count, 0U);
        EXPECT_EQ(result, sentinel);
    }
}

TEST_P(HcclModelStreamQueryApiTest, TwoStepQueryRetriesAfterRegistrationGrowth)
{
    const rtStream_t first = CreateStream();
    const rtStream_t second = CreateStream();
    const rtStream_t sentinel = CreateStream();
    rtModel_t model = nullptr;
    rtStream_t origin = nullptr;
    if (GetParam() == RT_MODEL_NORMAL) {
        model = CreateModel();
    } else {
        origin = CreateStream();
        BeginCapture(origin, model);
    }
    ASSERT_EQ(rtModelAddHcclStream(first, model), ACL_RT_SUCCESS);
    uint32_t count = UINT32_MAX;
    ASSERT_EQ(rtModelGetHcclStream(model, nullptr, &count), ACL_RT_SUCCESS);
    ASSERT_EQ(count, 1U);
    rtStream_t insufficient[2] = {sentinel, sentinel};
    ASSERT_EQ(rtModelAddHcclStream(second, model), ACL_RT_SUCCESS);
    ASSERT_EQ(rtModelGetHcclStream(model, insufficient, &count), ACL_ERROR_RT_INSUFFICIENT_INPUT_ARRAY);
    EXPECT_EQ(count, 1U);
    EXPECT_EQ(insufficient[0], sentinel);
    EXPECT_EQ(insufficient[1], sentinel);
    ASSERT_EQ(rtModelGetHcclStream(model, nullptr, &count), ACL_RT_SUCCESS);
    ASSERT_EQ(count, 2U);
    std::vector<rtStream_t> result(count, nullptr);
    ASSERT_EQ(rtModelGetHcclStream(model, result.data(), &count), ACL_RT_SUCCESS);
    EXPECT_EQ(count, 2U);
    EXPECT_EQ((std::set<rtStream_t>{result[0], result[1]}), (std::set<rtStream_t>{first, second}));
    if (origin != nullptr) {
        EndCapture(origin, model);
    }
}

TEST_F(HcclModelStreamApiTest, InvalidArgumentsPreserveOutputs)
{
    const rtModel_t model = CreateModel();
    const rtStream_t stream = CreateStream();
    EXPECT_EQ(rtModelAddHcclStream(nullptr, model), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(rtModelAddHcclStream(stream, nullptr), ACL_ERROR_RT_PARAM_INVALID);
    rtStream_t result = stream;
    uint32_t count = 17U;
    EXPECT_EQ(rtModelGetHcclStream(nullptr, &result, &count), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(count, 17U);
    EXPECT_EQ(result, stream);
    EXPECT_EQ(rtModelGetHcclStream(model, &result, nullptr), ACL_ERROR_RT_PARAM_INVALID);
    rtModel_t bound = model;
    EXPECT_EQ(rtGetModelByStream(nullptr, &bound), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(bound, model);
    MOCKER_CPP(&ApiImpl::CurrentContext).expects(never());
    EXPECT_EQ(rtGetModelByStream(stream, nullptr), ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(HcclModelStreamApiTest, WrongHandleTypesAreRejected)
{
    const rtModel_t model = CreateModel();
    const rtStream_t stream = CreateStream();
    EXPECT_EQ(rtModelAddHcclStream(model, model), ACL_ERROR_RT_INVALID_HANDLE);
    EXPECT_EQ(rtModelAddHcclStream(stream, stream), ACL_ERROR_RT_INVALID_HANDLE);
    rtStream_t result = stream;
    uint32_t count = 17U;
    EXPECT_EQ(rtModelGetHcclStream(stream, &result, &count), ACL_ERROR_RT_INVALID_HANDLE);
    EXPECT_EQ(count, 17U);
    EXPECT_EQ(result, stream);
    rtModel_t bound = model;
    EXPECT_EQ(rtGetModelByStream(model, &bound), ACL_ERROR_RT_INVALID_HANDLE);
    EXPECT_EQ(bound, model);
}

TEST_F(HcclModelStreamApiTest, RegistrationRejectsContextMismatches)
{
    const rtModel_t model = CreateModel();
    const rtStream_t stream = CreateStream();
    Model* const modelObj = rt_ut::UnwrapOrNull<Model>(model);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    streamObj->SetContext(nullptr);
    EXPECT_NE(rtModelAddHcclStream(stream, model), ACL_RT_SUCCESS);
    streamObj->SetContext(context_);
    modelObj->context_ = nullptr;
    EXPECT_NE(rtModelAddHcclStream(stream, model), ACL_RT_SUCCESS);
    modelObj->context_ = context_;
    uint32_t count = 17U;
    ASSERT_EQ(rtModelGetHcclStream(model, nullptr, &count), ACL_RT_SUCCESS);
    EXPECT_EQ(count, 0U);
}

TEST_F(HcclModelStreamApiTest, ReverseQueryTracksUnbindAndRebind)
{
    const rtModel_t first = CreateModel();
    const rtModel_t second = CreateModel();
    const rtStream_t stream = CreateStream(RT_STREAM_PERSISTENT);
    ASSERT_EQ(rtModelBindStream(first, stream, RT_MODEL_STREAM_FLAG_HEAD), ACL_RT_SUCCESS);
    rtModel_t bound = nullptr;
    ASSERT_EQ(rtGetModelByStream(stream, &bound), ACL_RT_SUCCESS);
    EXPECT_EQ(bound, first);
    Model* modelObj = nullptr;
    EXPECT_EQ(ValidateModelHandleForApi(bound, modelObj, __func__), RT_ERROR_NONE);
    ASSERT_EQ(rtModelUnbindStream(first, stream), ACL_RT_SUCCESS);
    ASSERT_EQ(rtGetModelByStream(stream, &bound), ACL_RT_SUCCESS);
    EXPECT_EQ(bound, nullptr);
    ASSERT_EQ(rtModelBindStream(second, stream, RT_MODEL_STREAM_FLAG_HEAD), ACL_RT_SUCCESS);
    ASSERT_EQ(rtGetModelByStream(stream, &bound), ACL_RT_SUCCESS);
    EXPECT_EQ(bound, second);
    EXPECT_EQ(rtModelUnbindStream(second, stream), ACL_RT_SUCCESS);
}

TEST_F(HcclModelStreamApiTest, ReverseQueryReturnsModelFromAnotherContext)
{
    const rtStream_t stream = CreateStream(RT_STREAM_PERSISTENT);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ASSERT_NE(streamObj, nullptr);
    rtContext_t modelContext = nullptr;
    ASSERT_EQ(rtCtxCreate(&modelContext, 0U, 0), ACL_RT_SUCCESS);
    const auto destroyContext = [this](rtContext_t ctx) {
        EXPECT_EQ(rtCtxSetCurrent(context_), ACL_RT_SUCCESS);
        EXPECT_EQ(rtCtxDestroy(ctx), ACL_RT_SUCCESS);
    };
    const std::unique_ptr<void, decltype(destroyContext)> contextGuard(modelContext, destroyContext);

    rtModel_t model = nullptr;
    ASSERT_EQ(rtModelCreate(&model, 0U), ACL_RT_SUCCESS);
    const auto destroyModel = [modelContext, streamObj](rtModel_t mdl) {
        EXPECT_EQ(rtCtxSetCurrent(modelContext), ACL_RT_SUCCESS);
        Model* const modelObj = rt_ut::UnwrapOrNull<Model>(mdl);
        if (streamObj->Model_() == modelObj) {
            // Keep the foreign stream in its original Context during cleanup.
            EXPECT_EQ(modelObj->UnbindStream(streamObj), RT_ERROR_NONE);
        }
        EXPECT_EQ(rtModelDestroy(mdl), ACL_RT_SUCCESS);
    };
    const std::unique_ptr<void, decltype(destroyModel)> modelGuard(model, destroyModel);
    ASSERT_EQ(rtModelBindStream(model, stream, RT_MODEL_STREAM_FLAG_HEAD), ACL_RT_SUCCESS);

    rtModel_t bound = nullptr;
    EXPECT_EQ(rtGetModelByStream(stream, &bound), ACL_RT_SUCCESS);
    EXPECT_EQ(bound, model);
    ASSERT_EQ(rtCtxSetCurrent(context_), ACL_RT_SUCCESS);
    EXPECT_EQ(rtGetModelByStream(stream, &bound), ACL_RT_SUCCESS);
    EXPECT_EQ(bound, model);
    EXPECT_EQ(streamObj->Context_(), context_);
}

TEST_F(HcclModelStreamApiTest, ReverseQueryDoesNotRequireOrSetCurrentContext)
{
    const rtModel_t model = CreateModel();
    const rtStream_t boundStream = CreateStream(RT_STREAM_PERSISTENT);
    const rtStream_t unboundStream = CreateStream();
    ASSERT_EQ(rtModelBindStream(model, boundStream, RT_MODEL_STREAM_FLAG_HEAD), ACL_RT_SUCCESS);
    std::thread query([&]() {
        EXPECT_EQ(Runtime::Instance()->CurrentContext(), nullptr);
        rtModel_t bound = nullptr;
        EXPECT_EQ(rtGetModelByStream(boundStream, &bound), ACL_RT_SUCCESS);
        EXPECT_EQ(bound, model);
        EXPECT_EQ(rtGetModelByStream(unboundStream, &bound), ACL_RT_SUCCESS);
        EXPECT_EQ(bound, nullptr);
        EXPECT_EQ(Runtime::Instance()->CurrentContext(), nullptr);
    });
    query.join();
}

TEST_F(HcclModelStreamApiTest, NormalRegistrationIgnoresCaptureFeatureAndFlagRestrictions)
{
    const rtModel_t model = CreateModel();
    const rtStream_t stream = CreateStream();
    const auto chip = GlobalContainer::GetRtChipType();
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    const auto flags = streamObj->flags_;
    streamObj->flags_ = RT_STREAM_AICPU | RT_STREAM_PERSISTENT;
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    EXPECT_EQ(rtModelAddHcclStream(stream, model), ACL_RT_SUCCESS);
    uint32_t count = 0U;
    EXPECT_EQ(rtModelGetHcclStream(model, nullptr, &count), ACL_RT_SUCCESS);
    EXPECT_EQ(count, 1U);
    rtModel_t bound = model;
    EXPECT_EQ(rtGetModelByStream(stream, &bound), ACL_RT_SUCCESS);
    EXPECT_EQ(bound, nullptr);
    GlobalContainer::SetRtChipType(chip);
    streamObj->flags_ = flags;
}

TEST_F(HcclModelStreamApiTest, CaptureRegistrationSharesLegacyDeduplicationAndReturnsOriginalStreams)
{
    const rtStream_t origin = CreateStream();
    const rtStream_t first = CreateStream();
    const rtStream_t second = CreateStream();
    rtModel_t model = nullptr;
    BeginCapture(origin, model);
    ASSERT_EQ(rtModelAddHcclStream(first, model), ACL_RT_SUCCESS);
    ASSERT_EQ(rtStreamAddToModel(first, model), ACL_RT_SUCCESS);
    ASSERT_EQ(rtStreamAddToModel(second, model), ACL_RT_SUCCESS);
    ASSERT_EQ(rtModelAddHcclStream(second, model), ACL_RT_SUCCESS);
    rtStream_t result[3] = {nullptr, nullptr, origin};
    uint32_t count = 3U;
    ASSERT_EQ(rtModelGetHcclStream(model, result, &count), ACL_RT_SUCCESS);
    EXPECT_EQ(count, 2U);
    EXPECT_EQ((std::set<rtStream_t>{result[0], result[1]}), (std::set<rtStream_t>{first, second}));
    EXPECT_EQ(result[2], origin);
    for (auto stream : {origin, first, second}) {
        rtModel_t bound = model;
        EXPECT_EQ(rtGetModelByStream(stream, &bound), ACL_RT_SUCCESS);
        EXPECT_EQ(bound, nullptr);
        Stream* const sink = rt_ut::UnwrapOrNull<Stream>(stream)->GetCaptureStream();
        ASSERT_NE(sink, nullptr);
        EXPECT_EQ(rtGetModelByStream(ExportEmbeddedHandle<rtStream_t>(sink), &bound), ACL_RT_SUCCESS);
        EXPECT_EQ(bound, model);
    }
    EndCapture(origin, model);
    EXPECT_EQ(rtModelAddHcclStream(first, model), ACL_RT_SUCCESS);
    const rtStream_t lateStream = CreateStream();
    EXPECT_NE(rtModelAddHcclStream(lateStream, model), ACL_RT_SUCCESS);
}

TEST_F(HcclModelStreamApiTest, CaptureSpecificValidationAndDefaultStreamRestrictions)
{
    const rtStream_t origin = CreateStream();
    const rtStream_t stream = CreateStream();
    rtModel_t model = nullptr;
    BeginCapture(origin, model);
    const auto chip = GlobalContainer::GetRtChipType();
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    EXPECT_EQ(rtModelAddHcclStream(stream, model), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    GlobalContainer::SetRtChipType(chip);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    const auto flags = streamObj->flags_;
    streamObj->flags_ = RT_STREAM_AICPU;
    EXPECT_NE(rtModelAddHcclStream(stream, model), ACL_RT_SUCCESS);
    streamObj->flags_ = flags;
    EXPECT_EQ(
        rtModelAddHcclStream(ExportEmbeddedHandle<rtStream_t>(context_->DefaultStream_()), model),
        ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    CaptureModel* const capture = dynamic_cast<CaptureModel*>(rt_ut::UnwrapOrNull<Model>(model));
    capture->SetSubCaptureModelEnable();
    EXPECT_EQ(rtModelAddHcclStream(stream, model), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    uint32_t count = 77U;
    EXPECT_EQ(rtModelGetHcclStream(model, nullptr, &count), ACL_RT_SUCCESS);
    EXPECT_EQ(count, 0U);
    capture->isSubCaptureModel_ = false;
    EndCapture(origin, model);
}

TEST_F(HcclModelStreamApiTest, CaptureCollectionUsesModelPolymorphismAndOnlyMapKeys)
{
    const rtStream_t first = CreateStream();
    const rtStream_t second = CreateStream();
    Stream* const firstObj = rt_ut::UnwrapOrNull<Stream>(first);
    Stream* const secondObj = rt_ut::UnwrapOrNull<Stream>(second);
    Model* model = nullptr;
    ASSERT_EQ(context_->ModelCreate(&model, RT_MODEL_CAPTURE_MODEL), RT_ERROR_NONE);
    models_.push_back(ExportEmbeddedHandle<rtModel_t>(model));
    CaptureModel* const capture = dynamic_cast<CaptureModel*>(model);
    ASSERT_NE(capture, nullptr);
    capture->SetAddStreamMap(firstObj, secondObj);
    capture->SetAddStreamMap(firstObj, firstObj);
    std::vector<Stream*> result{secondObj};
    EXPECT_EQ(model->CollectHcclStreams(result), RT_ERROR_NONE);
    ASSERT_EQ(result.size(), 1U);
    EXPECT_EQ(result[0], firstObj);
    capture->addStreamMap_.clear();
}

TEST_F(HcclModelStreamApiTest, ConcurrentNormalRegistrationsAndSnapshotsHaveNoDuplicates)
{
    const rtModel_t model = CreateModel();
    Model* const modelObj = rt_ut::UnwrapOrNull<Model>(model);
    std::set<Stream*> expected;
    for (uint32_t i = 0U; i < 8U; ++i) {
        expected.insert(rt_ut::UnwrapOrNull<Stream>(CreateStream()));
    }
    std::atomic<bool> start{false};
    std::atomic<uint32_t> finished{0U};
    std::vector<std::thread> writers;
    for (uint32_t i = 0U; i < 3U; ++i) {
        writers.emplace_back([&]() {
            while (!start.load()) {
                std::this_thread::yield();
            }
            for (uint32_t round = 0U; round < 100U; ++round) {
                for (Stream* stream : expected) {
                    EXPECT_EQ(modelObj->RegisterHcclStream(stream), RT_ERROR_NONE);
                }
            }
            ++finished;
        });
    }
    start = true;
    do {
        std::vector<Stream*> result;
        EXPECT_EQ(modelObj->CollectHcclStreams(result), RT_ERROR_NONE);
        const std::set<Stream*> actual(result.begin(), result.end());
        EXPECT_EQ(actual.size(), result.size());
        EXPECT_TRUE(std::includes(expected.begin(), expected.end(), actual.begin(), actual.end()));
    } while (finished.load() != 3U);
    for (auto& writer : writers) {
        writer.join();
    }
    std::vector<Stream*> result{nullptr};
    EXPECT_EQ(modelObj->CollectHcclStreams(result), RT_ERROR_NONE);
    EXPECT_EQ((std::set<Stream*>(result.begin(), result.end())), expected);
}

TEST_F(HcclModelStreamApiTest, InternalErrorChecksRejectNullAndUnknownModelTypes)
{
    ApiImpl impl;
    ApiDecorator forwarding(&impl);
    ApiErrorDecorator error(&forwarding);
    const rtModel_t model = CreateModel();
    const rtStream_t stream = CreateStream();
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    Model* const modelObj = rt_ut::UnwrapOrNull<Model>(model);
    std::vector<Stream*> result;
    EXPECT_EQ(error.HcclStreamAddToModel(nullptr, modelObj), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(error.HcclStreamAddToModel(streamObj, nullptr), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(error.ModelGetHcclStream(nullptr, result), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(error.GetModelByStream(nullptr, nullptr), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(error.GetModelByStream(streamObj, nullptr), RT_ERROR_INVALID_VALUE);
    Model unknown(RT_MODEL_MAX);
    EXPECT_EQ(error.HcclStreamAddToModel(streamObj, &unknown), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(error.ModelGetHcclStream(&unknown, result), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(error.HcclStreamAddToModel(streamObj, modelObj), RT_ERROR_NONE);
    EXPECT_EQ(error.ModelGetHcclStream(modelObj, result), RT_ERROR_NONE);
    EXPECT_EQ(result, (std::vector<Stream*>{streamObj}));
    Model* bound = modelObj;
    EXPECT_EQ(error.GetModelByStream(streamObj, &bound), RT_ERROR_NONE);
    EXPECT_EQ(bound, nullptr);
}

TEST_F(HcclModelStreamApiTest, NormalRegistrationRequiresCurrentContext)
{
    const rtModel_t model = CreateModel();
    const rtStream_t stream = CreateStream();
    Model* const modelObj = rt_ut::UnwrapOrNull<Model>(model);
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    ApiImpl impl;
    MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(static_cast<Context*>(nullptr)));
    EXPECT_EQ(impl.HcclStreamAddToNormalModel(streamObj, modelObj), RT_ERROR_CONTEXT_NULL);
}

TEST_F(HcclModelStreamApiTest, QueryBackendErrorsPreservePublicOutputs)
{
    ApiImpl impl;
    const rtModel_t model = CreateModel();
    const rtStream_t stream = CreateStream();
    uint32_t count = 19U;
    rtStream_t result = stream;
    MOCKER_CPP_VIRTUAL(&impl, &ApiImpl::ModelGetHcclStream).stubs().will(returnValue(RT_ERROR_MEMORY_ALLOCATION));
    EXPECT_NE(rtModelGetHcclStream(model, &result, &count), ACL_RT_SUCCESS);
    EXPECT_EQ(count, 19U);
    EXPECT_EQ(result, stream);
    MOCKER_CPP_VIRTUAL(&impl, &ApiImpl::GetModelByStream).stubs().will(returnValue(RT_ERROR_STREAM_CONTEXT));
    rtModel_t bound = model;
    EXPECT_NE(rtGetModelByStream(stream, &bound), ACL_RT_SUCCESS);
    EXPECT_EQ(bound, model);
}

TEST_F(HcclModelStreamApiTest, UnsupportedQueryProvidersPreservePublicOutputs)
{
    ApiImpl impl;
    const rtModel_t model = CreateModel();
    const rtStream_t stream = CreateStream();
    MOCKER_CPP_VIRTUAL(&impl, &ApiImpl::ModelGetHcclStream).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    MOCKER_CPP_VIRTUAL(&impl, &ApiImpl::GetModelByStream).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    uint32_t count = 19U;
    rtStream_t result = stream;
    rtModel_t bound = model;
    EXPECT_EQ(rtModelGetHcclStream(model, &result, &count), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(count, 19U);
    EXPECT_EQ(result, stream);
    EXPECT_EQ(rtGetModelByStream(stream, &bound), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(bound, model);
}

TEST_F(HcclModelStreamApiTest, CaptureBackendFailureInvalidatesCaptureWithoutRegistration)
{
    const rtStream_t origin = CreateStream();
    const rtStream_t stream = CreateStream();
    rtModel_t model = nullptr;
    BeginCapture(origin, model);
    MOCKER_CPP(&CaptureSession::StreamAddToCaptureModelProc).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    EXPECT_EQ(rtModelAddHcclStream(stream, model), ACL_ERROR_RT_PARAM_INVALID);
    uint32_t count = 99U;
    EXPECT_EQ(rtModelGetHcclStream(model, nullptr, &count), ACL_RT_SUCCESS);
    EXPECT_EQ(count, 0U);
    rtModel_t result = nullptr;
    EXPECT_EQ(rtStreamEndCapture(origin, &result), ACL_ERROR_RT_STREAM_CAPTURE_INVALIDATED);
    models_.pop_back(); // The failed capture is destroyed by the existing end-capture cleanup.
}

TEST_F(HcclModelStreamApiTest, MissingApiProviderPreservesOutputs)
{
    const rtModel_t model = CreateModel();
    const rtStream_t stream = CreateStream();
    MOCKER(Api::Instance).stubs().will(returnValue(static_cast<Api*>(nullptr)));
    EXPECT_NE(rtModelAddHcclStream(stream, model), ACL_RT_SUCCESS);
    uint32_t count = 19U;
    rtStream_t result = stream;
    EXPECT_NE(rtModelGetHcclStream(model, &result, &count), ACL_RT_SUCCESS);
    EXPECT_EQ(count, 19U);
    EXPECT_EQ(result, stream);
    rtModel_t bound = model;
    EXPECT_NE(rtGetModelByStream(stream, &bound), ACL_RT_SUCCESS);
    EXPECT_EQ(bound, model);
}

TEST_F(HcclModelStreamApiTest, HostExitCleanupReleasesOnlyRegistrationNodes)
{
    const rtStream_t stream = CreateStream();
    Stream* const streamObj = rt_ut::UnwrapOrNull<Stream>(stream);
    Model model;
    ASSERT_EQ(model.RegisterHcclStream(streamObj), RT_ERROR_NONE);
    model.FinalizeHostStateOnExit();
    std::vector<Stream*> result{streamObj};
    EXPECT_EQ(model.CollectHcclStreams(result), RT_ERROR_NONE);
    EXPECT_TRUE(result.empty());
    Stream* borrowed = nullptr;
    EXPECT_EQ(ValidateStreamHandleForApi(stream, borrowed, __func__), RT_ERROR_NONE);
    EXPECT_EQ(borrowed, streamObj);
}

TEST_F(HcclModelStreamApiTest, RuntimeInitializationFailurePreservesOutputs)
{
    const rtModel_t model = CreateModel();
    const rtStream_t stream = CreateStream();
    MOCKER(Runtime::Instance).stubs().will(returnValue(static_cast<Runtime*>(nullptr)));
    EXPECT_NE(rtModelAddHcclStream(stream, model), ACL_RT_SUCCESS);
    uint32_t count = 19U;
    rtStream_t result = stream;
    EXPECT_NE(rtModelGetHcclStream(model, &result, &count), ACL_RT_SUCCESS);
    EXPECT_EQ(count, 19U);
    EXPECT_EQ(result, stream);
    rtModel_t bound = model;
    EXPECT_NE(rtGetModelByStream(stream, &bound), ACL_RT_SUCCESS);
    EXPECT_EQ(bound, model);
}
