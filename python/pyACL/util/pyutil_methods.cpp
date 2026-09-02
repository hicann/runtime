/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "pyutil_methods.h"

namespace {
PyMethodDef g_methodsUtil[] = {
    {"numpy_to_ptr", WrapNumpyToPtr, METH_VARARGS, "numpy_to_ptr"},
    {"numpy_contiguous_to_ptr", WrapNumpyContiguousToPtr, METH_VARARGS, "numpy_contiguous_to_ptr"},
    {"ptr_to_numpy", WrapPtrToNumpy, METH_VARARGS, "ptr_to_numpy"},
    {"bytes_to_ptr", WrapBytesToPtr, METH_VARARGS, "bytes_to_ptr"},
    {"ptr_to_bytes", WrapPtrToBytes, METH_VARARGS, "ptr_to_bytes"},
    {"start_thread", WrapStartThread, METH_VARARGS, "start thread"},
    {"stop_thread", WrapStopThread, METH_VARARGS, "stop thread"},
    {nullptr, nullptr, 0, nullptr}};
}

PyMethodDef* GetUtilMethods() { return g_methodsUtil; }