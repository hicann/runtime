/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "blas.h"

namespace {
PyMethodDef g_methodsBlas[] = {
    {"gemv_ex", WrapAclblasGemvEx, METH_VARARGS, "execute matrix-vector multiplication"},
    {"create_handle_for_gemv_ex", WrapAclblasCreateHandleForGemvEx, METH_VARARGS,
     "create execute matrix-vector multiplication handle"},
    {"hgemv", WrapAclblasHgemv, METH_VARARGS,
     "execute matrix-vector multiplication with input data and output type is float16"},
    {"create_handle_for_hgemv", WrapAclblasCreateHandleForHgemv, METH_VARARGS,
     "create execute matrix-vector multiplication handle of input data is float16"},
    {"s8gemv", WrapAclblasS8gemv, METH_VARARGS, "execute matrix-vector multiplication with input data is int8_t"},
    {"create_handle_for_s8gemv", WrapAclblasCreateHandleForS8gemv, METH_VARARGS,
     "create execute matrix-vector multiplication handle of input data is int8_t"},
    {"gemm_ex", WrapAclblasGemmEx, METH_VARARGS, "execute matrix-matrix multiplication"},
    {"create_handle_for_gemm_ex", WrapAclblasCreateHandleForGemmEx, METH_VARARGS,
     "create execute matrix-matrix multiplication handle"},
    {"hgemm", WrapAclblasHgemm, METH_VARARGS, "execute matrix-matrix input and output data type is float16"},
    {"create_handle_for_hgemm", WrapAclblasCreateHandleForHgemm, METH_VARARGS,
     "create execute matrix-matrix multiplication handle input and output data type is float16"},
    {"s8gemm", WrapAclblasS8gemm, METH_VARARGS, "execute matrix-matrix input data type is int8_t"},
    {"create_handle_for_s8gemm", WrapAclblasCreateHandleForS8gemm, METH_VARARGS,
     "create execute matrix-matrix multiplication handle input type is int8_t"},
    {nullptr, nullptr, 0, nullptr}};
}

PyMethodDef* GetBlasMethods() { return g_methodsBlas; }