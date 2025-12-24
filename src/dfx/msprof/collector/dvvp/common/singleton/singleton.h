/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_COMMON_SINGLETON_SINGLETON_H
#define ANALYSIS_DVVP_COMMON_SINGLETON_SINGLETON_H

#include <mutex>

namespace analysis {
namespace dvvp {
namespace common {
namespace singleton {
template<class T>
class Singleton {
public:
    static T *instance()
    {
        static T value;
        return &value;
    }
    virtual ~Singleton() {}                   // dtor hidden

protected:
    Singleton() {}                            // ctor hidden
    Singleton(Singleton const &);             // copy ctor hidden
    Singleton &operator=(Singleton const &);  // assign op. hidden
};
}  // namespace singleton
}  // namespace common
}  // namespace dvvp
}  // namespace analysis

#endif