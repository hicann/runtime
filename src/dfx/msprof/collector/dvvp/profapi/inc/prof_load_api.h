/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PROF_LOAD_API_H
#define PROF_LOAD_API_H
#include <string>
#include <dlfcn.h>

namespace ProfAPI {
using VOID_PTR = void *;
class ProfLoadApi {
public:
    void ProfLoadApiInit(const VOID_PTR &handle);
    VOID_PTR LoadApi(const std::string &apiName) const;
    template <typename T>
    T LoadProfTxApi(const std::string &apiName) const
    {
        return reinterpret_cast<T>(LoadApi(apiName));
    }
private:
    VOID_PTR handle_{nullptr};
};

inline void ProfLoadApi::ProfLoadApiInit(const VOID_PTR &handle)
{
    handle_ = handle;
}

inline VOID_PTR ProfLoadApi::LoadApi(const std::string &apiName) const
{
    if (handle_ != nullptr) {
        return dlsym(handle_, apiName.c_str());
    }

    return nullptr;
}
}
#endif