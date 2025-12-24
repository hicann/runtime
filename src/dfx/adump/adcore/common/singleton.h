/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADX_COMMON_SINGLETON_SINGLETON_H
#define ADX_COMMON_SINGLETON_SINGLETON_H

namespace Adx {
namespace Common {
namespace Singleton {
template<class T>
class Singleton {
public:
    static T& Instance()
    {
        static T instance;
        return instance;
    }
    virtual ~Singleton()     {}                           // dtor hidden
    Singleton(Singleton const &) = delete;                // copy ctor hidden
    Singleton &operator=(Singleton const &) = delete;     // assign op. hidden
protected:
    Singleton()    {}                                     // ctor hidden
};
}  // namespace singleton
}  // namespace common
}  // namespace analysis

#endif
