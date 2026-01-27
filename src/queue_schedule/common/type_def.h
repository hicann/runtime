/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef AICPU_TYPE_DEF_H
#define AICPU_TYPE_DEF_H
 
#include <cstdint>
#include <cstddef>
#ifndef char_t
typedef char char_t;
#endif
 
#ifndef float32_t
typedef float float32_t;
#endif
 
#ifndef float64_t
typedef double float64_t;
#endif
 
inline uint64_t PtrToValue(const void *ptr)
{
    return static_cast<uint64_t>(reinterpret_cast<uintptr_t>(ptr));
}
 
inline void *ValueToPtr(const uint64_t value)
{
    return reinterpret_cast<void *>(static_cast<uintptr_t>(value));
}
 
template<typename TI, typename TO>
inline TO *PtrToPtr(TI *ptr)
{
    return reinterpret_cast<TO *>(ptr);
}
 
template<typename TI, typename TO>
inline const TO *PtrToPtr(const TI *const ptr)
{
    return reinterpret_cast<const TO *>(ptr);
}
 
template<typename TI, typename TO>
inline TO PtrToFunctionPtr(TI *const ptr)
{
    return reinterpret_cast<TO>(ptr);
}
 
template<typename TI, typename TO>
inline const TO PtrToFunctionPtr(const TI *const ptr)
{
    return reinterpret_cast<const TO>(ptr);
}
 
template<typename T>
inline T *PtrAdd(T * const ptr, const size_t maxIdx, const size_t idx)
{
    if ((ptr != nullptr) && (idx < maxIdx)) {
        return reinterpret_cast<T *>(ptr + idx);
    }
    return nullptr;
}
#endif  // AICPU_TYPE_DEF_H