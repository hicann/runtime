/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_TENSOR_TRAITS_H_
#define ACL_TENSOR_TRAITS_H_

#include "opdev/common_types.h"
#include "opdev/fast_vector.h"
#include <vector>

namespace op {
namespace internal {

template<typename T>
[[maybe_unused]] static void AddToList([[maybe_unused]] std::vector<const aclTensor *> &v, [[maybe_unused]] T &t)
{
}

[[maybe_unused]] static void AddToList(std::vector<const aclTensor *> &v, aclTensor *t)
{
    if (t == nullptr)
        return;
    v.push_back(t);
}

[[maybe_unused]] static void AddToListAndIdx(std::vector<const aclTensor *> &v, std::vector<uint32_t> &idxs,
    bool genPlaceholder, aclTensor *t, int32_t &currentIdx)
{
    if (t == nullptr && !(genPlaceholder)) {
        return;
    }
    ++currentIdx;

    if (t != nullptr) {
        v.push_back(t);
        idxs.push_back(static_cast<uint32_t>(currentIdx));
    }
}

[[maybe_unused]] static void AddToListAndIdx(std::vector<const aclTensor *> &v, std::vector<uint32_t> &idxs,
    bool genPlaceholder, aclTensor *t, int32_t &currentIdx, std::vector<int32_t> &tensorOffset)
{
    if (t == nullptr && !(genPlaceholder)) {
        return;
    }
    ++currentIdx;

    if (t != nullptr) {
        v.push_back(t);
        if (static_cast<size_t>(currentIdx) < tensorOffset.size()) {
            idxs.push_back(static_cast<uint32_t>(tensorOffset[currentIdx]));
        }
    }
}

[[maybe_unused]] static void AddToListAndIdx(std::vector<const aclTensor *> &v, std::vector<uint32_t> &idxs,
    bool genPlaceholder, aclTensorList *t, int32_t &currentIdx)
{
    if (t == nullptr) {
        return;
    }
    for (uint64_t i = 0; i < t->Size(); i++) {
        AddToListAndIdx(v, idxs, genPlaceholder, const_cast<aclTensor *>((*t)[i]), currentIdx);
    }
}

[[maybe_unused]] static void AddToListAndIdx(std::vector<const aclTensor *> &v, std::vector<uint32_t> &idxs,
    bool genPlaceholder, aclTensorList *t, int32_t &currentIdx, std::vector<int32_t> &tensorOffset)
{
    if (t == nullptr) {
        return;
    }
    for (uint64_t i = 0; i < t->Size(); i++) {
        AddToListAndIdx(v, idxs, genPlaceholder, const_cast<aclTensor *>((*t)[i]), currentIdx, tensorOffset);
    }
}

[[maybe_unused]] static void AddToList(std::vector<const aclTensor *> &v, const aclTensor *const t)
{
    if (t == nullptr)
        return;
    aclTensor *p = const_cast<aclTensor *>(t);
    v.push_back(p);
}

[[maybe_unused]] static void AddToList(std::vector<const aclTensor *> &v, aclTensorList *t)
{
    if (t == nullptr)
        return;
    for (uint64_t i = 0; i < t->Size(); i++) {
        aclTensor *p = const_cast<aclTensor *>((*t)[i]);
        v.push_back(p);
    }
}

[[maybe_unused]] static void AddToList(std::vector<const aclTensor *> &v, const aclTensorList *const t)
{
    if (t == nullptr)
        return;
    for (uint64_t i = 0; i < t->Size(); i++) {
        aclTensor *p = const_cast<aclTensor *>((*t)[i]);
        v.push_back(p);
    }
}

template<typename T>
[[maybe_unused]] static void AddToList([[maybe_unused]] FVector<aclTensor *> &v, [[maybe_unused]] T &t)
{
}

[[maybe_unused]] static void AddToList(FVector<aclTensor *> &v, aclTensor *t)
{
    if (t == nullptr)
        return;
    v.push_back(t);
}

[[maybe_unused]] static void AddToList(FVector<aclTensor *> &v, const aclTensor *const t)
{
    if (t == nullptr)
        return;
    aclTensor *p = const_cast<aclTensor *>(t);
    v.push_back(p);
}

[[maybe_unused]] static void AddToList(FVector<aclTensor *> &v, aclTensorList *t)
{
    if (t == nullptr)
        return;
    for (uint64_t i = 0; i < t->Size(); i++) {
        aclTensor *p = const_cast<aclTensor *>((*t)[i]);
        v.push_back(p);
    }
}

[[maybe_unused]] static void AddToList(FVector<aclTensor *> &v, const aclTensorList *const t)
{
    if (t == nullptr)
        return;
    for (uint64_t i = 0; i < t->Size(); i++) {
        aclTensor *p = const_cast<aclTensor *>((*t)[i]);
        v.push_back(p);
    }
}

template<typename T>
[[maybe_unused]] static void AddToList([[maybe_unused]] FVector<const aclTensor*>& v, [[maybe_unused]] T& t)
{
}

[[maybe_unused]] static void AddToList(FVector<const aclTensor*>& v, aclTensor* t)
{
    if (t == nullptr) return;
    v.push_back(t);
}

[[maybe_unused]] static void AddToList(FVector<const aclTensor*>& v, const aclTensor* const t)
{
    if (t == nullptr) return;
    aclTensor * p = const_cast<aclTensor*>(t);
    v.push_back(p);
}

[[maybe_unused]] static void AddToList(FVector<const aclTensor*>& v, aclTensorList* t)
{
    if (t == nullptr) return;
    for (uint64_t i = 0; i < t->Size(); i++) {
        aclTensor * p = const_cast<aclTensor*>((*t)[i]);
        v.push_back(p);
    }
}

[[maybe_unused]] static void AddToList(FVector<const aclTensor*>& v, const aclTensorList* const t)
{
    if (t == nullptr) return;
    for (uint64_t i = 0; i < t->Size(); i++) {
        aclTensor * p = const_cast<aclTensor*>((*t)[i]);
        v.push_back(p);
    }
}

} // namespace internal
} // namespace op

#endif
