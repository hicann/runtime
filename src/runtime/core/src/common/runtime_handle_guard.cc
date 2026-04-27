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

namespace cce {
namespace runtime {
namespace {

const char *GetResourceNameByMagic(const uint64_t magic)
{
    switch (magic) {
        case RT_MODEL_MAGIC:
            return "model";
        case RT_LABEL_MAGIC:
            return "label";
        case RT_STREAM_MAGIC:
            return "stream";
        case RT_EVENT_MAGIC:
            return "event";
        case RT_NOTIFY_MAGIC:
            return "notify";
        case RT_CNTNOTIFY_MAGIC:
            return "cntnotify";
        default:
            return "unknown";
    }
}

rtError_t ValidateInnerObject(const void *handle, const uint64_t expectedMagic)
{
    const auto * const innerObject = static_cast<const rtInnerObject *>(handle);
    const uint64_t actualMagic = innerObject->magic.load();

    if (actualMagic != expectedMagic) {
        const char * const objectName = GetResourceNameByMagic(expectedMagic);
        RT_LOG(RT_LOG_ERROR, "Validate %s failed, magic mismatch, expected=%#" PRIx64 ", actual=%#" PRIx64 ". %s",
               objectName, expectedMagic, actualMagic, (actualMagic == 0 ? "(Already destroyed)" : ""));
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

} // namespace

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

    const auto *inner = static_cast<const rtInnerObject *>(handle);
    outRealObj = inner->object;
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
