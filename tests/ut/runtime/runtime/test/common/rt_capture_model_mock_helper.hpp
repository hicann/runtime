/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RT_CAPTURE_MODEL_MOCK_HELPER_HPP
#define RT_CAPTURE_MODEL_MOCK_HELPER_HPP

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "runtime/rt.h"
#include "rt_unwrap.h"
#include "stream.hpp"
#include "model.hpp"
#include "capture_model.hpp"

namespace cce {
namespace runtime {
namespace ut {
inline CaptureModel* GetCaptureModelFromCaptureStream(Stream* stream)
{
    EXPECT_NE(stream, nullptr);
    if (stream == nullptr) {
        return nullptr;
    }
    Stream* captureStream = stream->GetCaptureStream();
    EXPECT_NE(captureStream, nullptr);
    if (captureStream == nullptr) {
        return nullptr;
    }
    CaptureModel* model = dynamic_cast<CaptureModel*>(captureStream->Model_());
    EXPECT_NE(model, nullptr);
    return model;
}

inline CaptureModel* GetCaptureModelFromStream(Stream* stream) { return GetCaptureModelFromCaptureStream(stream); }

inline CaptureModel* GetCaptureModelFromStream(rtStream_t streamHandle)
{
    Stream* stream = ::rt_ut::UnwrapOrNull<Stream>(streamHandle);
    return GetCaptureModelFromCaptureStream(stream);
}

inline CaptureModel* GetCaptureModelFromModel(rtModel_t modelHandle)
{
    Model* model = ::rt_ut::UnwrapOrNull<Model>(modelHandle);
    EXPECT_NE(model, nullptr);
    if (model == nullptr) {
        return nullptr;
    }
    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(model);
    EXPECT_NE(captureModel, nullptr);
    return captureModel;
}
} // namespace ut
} // namespace runtime
} // namespace cce

#define MOCK_CAPTURE_MODEL_LOAD_COMPLETE(STREAM)                                                                     \
    do {                                                                                                             \
        ::cce::runtime::CaptureModel* captureModelForMock = ::cce::runtime::ut::GetCaptureModelFromStream((STREAM)); \
        ASSERT_NE(captureModelForMock, nullptr);                                                                     \
        MOCKER_CPP_VIRTUAL(captureModelForMock, &::cce::runtime::CaptureModel::LoadCompleteByStreamPostp)            \
            .stubs()                                                                                                 \
            .will(returnValue(RT_ERROR_NONE));                                                                       \
    } while (0)

#define MOCK_CAPTURE_MODEL_LOAD_COMPLETE_BY_MODEL(MODEL)                                                           \
    do {                                                                                                           \
        ::cce::runtime::CaptureModel* captureModelForMock = ::cce::runtime::ut::GetCaptureModelFromModel((MODEL)); \
        ASSERT_NE(captureModelForMock, nullptr);                                                                   \
        MOCKER_CPP_VIRTUAL(captureModelForMock, &::cce::runtime::CaptureModel::LoadCompleteByStreamPostp)          \
            .stubs()                                                                                               \
            .will(returnValue(RT_ERROR_NONE));                                                                     \
    } while (0)

#endif // RT_CAPTURE_MODEL_MOCK_HELPER_HPP
