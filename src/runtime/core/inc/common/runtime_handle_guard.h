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
#include "runtime/base.h"
#include "common/internal_error_define.hpp"

struct RtArgsHandle;
struct ParaDetail;

namespace cce {
namespace runtime {

void RecordErrorLog(const char *file, const int32_t line, const char *fun, const char *fmt, ...);

// Magic Constants
constexpr uint64_t RT_COND_HANDLE_MAGIC = 0x434F4E44ULL; // COND
constexpr uint64_t RT_MODEL_MAGIC     = 0x4D4F444CULL; // MODL
constexpr uint64_t RT_LABEL_MAGIC     = 0x4C41424CULL; // LABL
constexpr uint64_t RT_STREAM_MAGIC    = 0x5354524DULL; // STRM
constexpr uint64_t RT_EVENT_MAGIC     = 0x45564E54ULL; // EVNT
constexpr uint64_t RT_NOTIFY_MAGIC    = 0x4E544659ULL; // NTFY
constexpr uint64_t RT_CNTNOTIFY_MAGIC = 0x434E5446ULL; // CNTF
constexpr uint64_t RT_PROGRAM_MAGIC   = 0x50524F47ULL; // PROG
constexpr uint64_t RT_KERNEL_MAGIC    = 0x4B45524EULL; // KERN
constexpr uint64_t RT_ARGS_MAGIC      = 0x41524753ULL; // ARGS
constexpr uint64_t RT_PARAM_MAGIC     = 0x50415241ULL; // PARA
constexpr uint64_t RT_LAUNCH_ARGS_MAGIC = 0x4C415247ULL; // LARG

template <typename T>
struct RtMagicTraits;

#define REGISTER_RT_MAGIC(Type, MagicValue) \
template <>                                 \
struct RtMagicTraits<Type> {                \
    static constexpr uint64_t value = MagicValue; \
}

class CondHandle;
class Model;
class Label;
class Stream;
class Event;
class Notify;
class CountNotify;
class Program;
class Kernel;
struct rtLaunchArgs_t;

// Register all magic constants
REGISTER_RT_MAGIC(CondHandle, RT_COND_HANDLE_MAGIC);
REGISTER_RT_MAGIC(Model,     RT_MODEL_MAGIC);
REGISTER_RT_MAGIC(Label,     RT_LABEL_MAGIC);
REGISTER_RT_MAGIC(Stream,    RT_STREAM_MAGIC);
REGISTER_RT_MAGIC(Event,     RT_EVENT_MAGIC);
REGISTER_RT_MAGIC(Notify,    RT_NOTIFY_MAGIC);
REGISTER_RT_MAGIC(CountNotify, RT_CNTNOTIFY_MAGIC);
REGISTER_RT_MAGIC(Program, RT_PROGRAM_MAGIC);
REGISTER_RT_MAGIC(Kernel,    RT_KERNEL_MAGIC);
REGISTER_RT_MAGIC(::RtArgsHandle, RT_ARGS_MAGIC);
REGISTER_RT_MAGIC(::ParaDetail, RT_PARAM_MAGIC);
REGISTER_RT_MAGIC(rtLaunchArgs_t, RT_LAUNCH_ARGS_MAGIC);

/**
 * @ingroup
 * @brief Generic inner object shared by runtime resource handles.
 */
struct rtInnerObject {
    std::atomic<uint64_t> magic;
    void *object;
};

template <typename T>
struct RtInnerHandleAccessor {
    static rtInnerObject *Get(T *realObj)
    {
        return realObj->GetInnerHandle();
    }
};

rtError_t GetValidatedObjectImpl(const void *handle, uint64_t expectedMagic, void *&outRealObj);
void InitializeInnerObject(rtInnerObject &inner, uint64_t magic, void *object);
void ResetInnerObject(rtInnerObject &inner);

template <typename T>
void InitEmbeddedInnerHandle(T *realObj)
{
    auto *inner = RtInnerHandleAccessor<T>::Get(realObj);
    InitializeInnerObject(*inner, RtMagicTraits<T>::value, static_cast<void *>(realObj));
}

template <typename T>
void ResetEmbeddedInnerHandle(T *realObj)
{
    auto *inner = RtInnerHandleAccessor<T>::Get(realObj);
    ResetInnerObject(*inner);
}

// Validate object
template <typename T>
rtError_t GetValidatedObject(const void *handle, T *&outRealObj)
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
        cce::runtime::RecordErrorLog(__FILE__, __LINE__, &__func__[0],
            "Check param failed, handle array can not be null.\n");
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
