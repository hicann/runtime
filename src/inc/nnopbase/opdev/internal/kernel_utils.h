/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __ACL_KERNEL_UTILS_H__
#define __ACL_KERNEL_UTILS_H__

#include <stdint.h>
#include <type_traits>
#include <mutex>

#include "base/registry/op_impl_space_registry_v2.h"
#include "aclnn/acl_meta.h"
#include "opdev/op_log.h"
#include "opdev/op_dfx.h"
#include "graph/op_desc.h"
#include "mmpa/mmpa_api.h"

#define ADD_TRY_CATCH(expr0, expr1)       \
    try {                                 \
        expr0;                            \
    } catch (...) {                       \
        expr1;                            \
    }

namespace op {
namespace internal {

constexpr uint32_t KERNEL_UTILS_THIRTY_TWO_BIT = 32;

// Aligns the supplied size to the specified PowerOfTwo
inline size_t AlignSize(size_t sizeToAlign, size_t powerOfTwo)
{
    return (sizeToAlign + powerOfTwo - 1) & ~(powerOfTwo - 1);
}

template<typename T, typename V>
inline size_t PtrOffset(const T *left, const V *right)
{
    return PtrCastTo<const uint8_t>(right) - PtrCastTo<const uint8_t>(left);
}

template<typename T>
inline const T *PtrShift(const T *ptr, int64_t offset)
{
    return PtrCastTo<const T>(PtrCastTo<const uint8_t>(ptr) + offset);
}

template<typename T>
inline T *PtrShift(T *ptr, int64_t offset)
{
    return PtrCastTo<T>(PtrCastTo<uint8_t>(ptr) + offset);
}

#define FREE(ptr)               \
    do {                        \
        if ((ptr)) {            \
            std::free((ptr));   \
            (ptr) = nullptr;    \
        }                       \
    } while (false)

constexpr size_t SPLIT_DATA_LEN = 768;

inline void SplitDataAndPrint(const std::string dataHeader, const std::string &data)
{
    OP_CHECK(!data.empty(), OP_LOGW("%s data is empty!", dataHeader.c_str()), return);
    size_t n = data.length() / SPLIT_DATA_LEN; // 子串个数
    size_t i = 0;
    for (; i < n; i++) {
        std::string sub = data.substr(i * SPLIT_DATA_LEN, SPLIT_DATA_LEN);
        OP_LOGI("%s[%zu]: %s", dataHeader.c_str(), i, sub.c_str());
    }
    if (data.length() % SPLIT_DATA_LEN != 0) {
        std::string sub = data.substr(n * SPLIT_DATA_LEN);
        OP_LOGI("%s[%zu]: %s", dataHeader.c_str(), i, sub.c_str());
    }
}

template<typename T>
class InitOnceVar {
public:
    template<typename F>
    aclnnStatus InitVar(const F &initFunc)
    {
        auto f = [&initFunc](aclnnStatus &res, T &var) {
            res = initFunc(var);
        };
        std::call_once(onceFlag_, f, initRes_, var_);
        return initRes_;
    }

    const T& GetVar() const
    {
        return var_;
    }

private:
    T var_;
    aclnnStatus initRes_;
    std::once_flag onceFlag_;
};

ge::OppImplVersion GetOppVersion();
gert::OppImplVersionTag GetOppImplVersion();
aclnnStatus GetOppKernelPath(std::string &oppKernelPath);

struct ThreadCoreNum{
    ThreadCoreNum() = default;
    ThreadCoreNum(uint32_t aicNum, uint32_t aivNum) : aicNum_(aicNum), aivNum_(aivNum) {}
    ThreadCoreNum(const ThreadCoreNum &rhs)
    {
        aicNum_ = rhs.aicNum_;
        aivNum_ = rhs.aivNum_;
    }

    ThreadCoreNum &operator=(const ThreadCoreNum &rhs)
    {
        if (this != &rhs) {
            aicNum_ = rhs.aicNum_;
            aivNum_ = rhs.aivNum_;
        }
        return *this;
    }

    bool operator==(const ThreadCoreNum &rhs) const {
        return aicNum_ == rhs.aicNum_ && aivNum_ == rhs.aivNum_;
    }

    struct Hash {
        uint64_t operator()(const ThreadCoreNum &t) const {
            uint32_t a = t.aicNum_;
            uint32_t b = t.aivNum_;
            return ((static_cast<uint64_t>(a) << KERNEL_UTILS_THIRTY_TWO_BIT) | b);
        }
    };

    uint32_t aicNum_;
    uint32_t aivNum_;
};

} // namespace internal
} // namespace op

#endif
