/**
Copyright (c) 2026 Huawei Technologies Co., Ltd.
This program is free software, you can redistribute it and/or modify it under the terms and conditions of
CANN Open Software License Agreement Version 2.0 (the "License").
Please refer to the License for details. You may not use this file except in compliance with the License.
THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
See LICENSE in the root of the software repository for the full text of the License.
*/
#include <cinttypes>

#include "runtime_handle_guard.h"
#include "securec.h"

namespace cce {
namespace runtime {
namespace {

const rtInnerObject *GetInnerObject(const void *handle)
{
    return static_cast<const rtInnerObject *>(handle);
}

constexpr size_t INVALID_HANDLE_REASON_MAX_LEN = 128U;

const char *GetResourceNameByMagic(const uint64_t magic)
{
    const char *resourceName = "unknown";
    switch (magic) {
        case RT_MODEL_MAGIC:
            resourceName = "model";
            break;
        case RT_LABEL_MAGIC:
            resourceName = "label";
            break;
        case RT_STREAM_MAGIC:
            resourceName = "stream";
            break;
        case RT_EVENT_MAGIC:
            resourceName = "event";
            break;
        case RT_NOTIFY_MAGIC:
            resourceName = "notify";
            break;
        case RT_CNTNOTIFY_MAGIC:
            resourceName = "cntnotify";
            break;
        case RT_COND_HANDLE_MAGIC:
            resourceName = "cond_handle";
            break;
        default:
            break;
    }
    return resourceName;
}

rtError_t ValidateInnerObject(const void *handle, const uint64_t expectedMagic)
{
    const char * const objectName = GetResourceNameByMagic(expectedMagic);
    const auto * const innerObject = GetInnerObject(handle);
    const uint64_t actualMagic = innerObject->magic.load();

    if (actualMagic != expectedMagic) {
        const char * const destroyedMsg = (actualMagic == 0U) ? "(Already destroyed)" : "";
        RT_LOG(RT_LOG_ERROR, "Validate %s failed, magic mismatch, expected=%#" PRIx64 ", actual=%#" PRIx64 ". %s",
               objectName, expectedMagic, actualMagic, destroyedMsg);
        char reason[INVALID_HANDLE_REASON_MAX_LEN] = {0};
        const int32_t ret = snprintf_s(reason, sizeof(reason), sizeof(reason) - 1U,
            "1. The %s handle has been destroyed. 2. The handle type must be %s", objectName, objectName);
        if (ret < 0) {
            reason[0] = '\0';
        }
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1017, "Object validation", objectName, reason);
        return RT_ERROR_INVALID_HANDLE;
    }
    return RT_ERROR_NONE;
}

} // namespace

void InitializeInnerObject(rtInnerObject &inner, uint64_t magic, void *object)
{
    inner.object = object;
    inner.magic.store(magic);
}

void ResetInnerObject(rtInnerObject &inner)
{
    inner.magic.store(0U);
    inner.object = nullptr;
}

rtError_t GetValidatedObjectImpl(void *handle, uint64_t expectedMagic, void *&outRealObj)
{
    if (handle == nullptr) {
        outRealObj = nullptr;
        return RT_ERROR_NONE;
    }

    const rtError_t ret = ValidateInnerObject(handle, expectedMagic);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }

    const auto *inner = GetInnerObject(handle);
    outRealObj = inner->object;
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
