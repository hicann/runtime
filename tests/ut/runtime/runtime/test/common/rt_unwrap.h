/**
Copyright (c) 2026 Huawei Technologies Co., Ltd.
This program is free software, you can redistribute it and/or modify it under the terms and conditions of
CANN Open Software License Agreement Version 2.0 (the "License").
Please refer to the License for details. You may not use this file except in compliance with the License.
THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
See LICENSE in the root of the software repository for the full text of the License.
*/
#ifndef RUNTIME_UT_HELPER_H
#define RUNTIME_UT_HELPER_H

#include <gtest/gtest.h>
#include "runtime_handle_guard.h"
#include "runtime/rt.h"

namespace rt_ut {
template <class T, class HandleT>
inline T *UnwrapOrNull(HandleT handle)
{
    T *out = nullptr;
    EXPECT_EQ(::cce::runtime::GetValidatedObject<T>(handle, out), RT_ERROR_NONE);
    return out;
}

} // namespace rt_ut

#define UT_UNWRAP(type, handle, out_ptr)                                     \
    do {                                                                     \
        (out_ptr) = nullptr;                                                 \
        EXPECT_EQ(::cce::runtime::GetValidatedObject<type>((handle), (out_ptr)), \
            RT_ERROR_NONE);                                                  \
    } while (false)

#endif // RUNTIME_UT_HELPER_H
