/**
Copyright (c) 2026 Huawei Technologies Co., Ltd.
This program is free software, you can redistribute it and/or modify it under the terms and conditions of
CANN Open Software License Agreement Version 2.0 (the "License").
Please refer to the License for details. You may not use this file except in compliance with the License.
THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
See LICENSE in the root of the software repository for the full text of the License.
*/
#ifndef RUNTIME_HANDLE_GUARD_H
#define RUNTIME_HANDLE_GUARD_H

#include <atomic>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "base.hpp"

namespace cce {
namespace runtime {

// Magic Constants
constexpr uint64_t RT_MODEL_MAGIC     = 0x4D4F444Cull; // MODL
constexpr uint64_t RT_LABEL_MAGIC     = 0x4C41424Cull; // LABL
constexpr uint64_t RT_STREAM_MAGIC    = 0x5354524Dull; // STRM
constexpr uint64_t RT_EVENT_MAGIC     = 0x45564E54ull; // EVNT
constexpr uint64_t RT_NOTIFY_MAGIC    = 0x4E544659ull; // NTFY
constexpr uint64_t RT_CNTNOTIFY_MAGIC = 0x434E5446ull; // CNTF

template <typename T>
struct RtMagicTraits;

#define REGISTER_RT_MAGIC(Type, MagicValue) \
template <>                                 \
struct RtMagicTraits<Type> {                \
    static constexpr uint64_t value = MagicValue; \
};

class Model;
class Label;
class Stream;
class Event;
class Notify;
class CountNotify;

// Register all magic constants
REGISTER_RT_MAGIC(Model,     RT_MODEL_MAGIC)
REGISTER_RT_MAGIC(Label,     RT_LABEL_MAGIC)
REGISTER_RT_MAGIC(Stream,    RT_STREAM_MAGIC)
REGISTER_RT_MAGIC(Event,     RT_EVENT_MAGIC)
REGISTER_RT_MAGIC(Notify,    RT_NOTIFY_MAGIC)
REGISTER_RT_MAGIC(CountNotify, RT_CNTNOTIFY_MAGIC)

/**
 * @ingroup
 * @brief Generic inner object shared by runtime resource handles.
 */
struct rtInnerObject {
    std::atomic<uint64_t> magic;
    void *object;
};

rtError_t GetValidatedObjectImpl(void *handle, uint64_t expectedMagic, void *&outRealObj);

template <typename T>
void InitEmbeddedInnerHandle(T *realObj)
{
    auto *inner = realObj->GetInnerHandle();
    inner->object = static_cast<void *>(realObj);
    inner->magic.store(RtMagicTraits<T>::value);
}

template <typename T>
void ResetEmbeddedInnerHandle(T *realObj)
{
    auto *inner = realObj->GetInnerHandle();
    inner->magic.store(0U);
    inner->object = nullptr;
}

// Validate object
template <typename T>
rtError_t GetValidatedObject(void *handle, T *&outRealObj)
{
    constexpr uint64_t expectedMagic = RtMagicTraits<T>::value;
    void *realObj = nullptr;
    const rtError_t ret = GetValidatedObjectImpl(handle, expectedMagic, realObj);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }
    outRealObj = static_cast<T *>(realObj);
    return RT_ERROR_NONE;
}

template <typename T, typename HandleT>
rtError_t GetValidatedObjectArray(HandleT *handles, size_t count, std::vector<T *> &outRealObjs)
{
    outRealObjs.clear();
    if (handles == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Check param failed, handle array can not be null.");
        return RT_ERROR_INVALID_VALUE;
    }
    if (count == 0U) {
        return RT_ERROR_NONE;
    }

    outRealObjs.reserve(count);
    for (size_t i = 0U; i < count; ++i) {
        T *realObj = nullptr;
        const rtError_t ret = GetValidatedObject<T>(handles[i], realObj);
        if (ret != RT_ERROR_NONE) {
            return ret;
        }
        outRealObjs.push_back(realObj);
    }
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce

#endif // RUNTIME_HANDLE_GUARD_H
