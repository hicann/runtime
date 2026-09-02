/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_RT_ALLOCATOR_FUNCS_H
#define WORD_RT_ALLOCATOR_FUNCS_H

#include <Python.h>
#include "utils_methods.h"

PyObject* WrapAclRtAllocatorCreateDesc(PyObject* self, PyObject* args);
PyObject* WrapAclRtAllocatorDestroyDesc(PyObject* self, PyObject* args);

PyObject* WrapAclRtAllocatorSetObjToDesc(PyObject* self, PyObject* args);
PyObject* WrapAclRtAllocatorSetAllocFuncToDesc(PyObject* self, PyObject* args);
PyObject* WrapAclRtAllocatorSetFreeFuncToDesc(PyObject* self, PyObject* args);
PyObject* WrapAclRtAllocatorSetAllocAdviseFuncToDesc(PyObject* self, PyObject* args);
PyObject* WrapAclRtAllocatorSetGetAddrFromBlockFuncToDesc(PyObject* self, PyObject* args);

PyObject* WrapAclRtAllocatorRegister(PyObject* self, PyObject* args);
PyObject* WrapAclRtAllocatorUnregister(PyObject* self, PyObject* args);

#endif // WORD_RT_ALLOCATOR_FUNCS_H
