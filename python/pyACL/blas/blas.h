/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_BLAS_FUNCS_H
#define WORD_BLAS_FUNCS_H

#include <Python.h>
#include "utils_methods.h"

PyObject* WrapAclblasGemvEx(PyObject* self, PyObject* args);
PyObject* WrapAclblasCreateHandleForGemvEx(PyObject* self, PyObject* args);
PyObject* WrapAclblasHgemv(PyObject* self, PyObject* args);
PyObject* WrapAclblasCreateHandleForHgemv(PyObject* self, PyObject* args);
PyObject* WrapAclblasS8gemv(PyObject* self, PyObject* args);
PyObject* WrapAclblasCreateHandleForS8gemv(PyObject* self, PyObject* args);
PyObject* WrapAclblasGemmEx(PyObject* self, PyObject* args);
PyObject* WrapAclblasCreateHandleForGemmEx(PyObject* self, PyObject* args);
PyObject* WrapAclblasHgemm(PyObject* self, PyObject* args);
PyObject* WrapAclblasCreateHandleForHgemm(PyObject* self, PyObject* args);
PyObject* WrapAclblasS8gemm(PyObject* self, PyObject* args);
PyObject* WrapAclblasCreateHandleForS8gemm(PyObject* self, PyObject* args);

#endif // WORD_BLAS_FUNCS_H