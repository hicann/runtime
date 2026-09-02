/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_PYTHON_RT_BINARY_H
#define ACL_PYTHON_RT_BINARY_H

#include <Python.h>
#include "utils_methods.h"

PyObject* WrapAclRtBinaryLoadFromFile(PyObject* /* self */, PyObject* args);
PyObject* WrapAclRtBinaryLoadFromData(PyObject* /* self */, PyObject* args);
PyObject* WrapAclRtGetFunctionAddr(PyObject* /* self */, PyObject* args);
PyObject* WrapAclRtGetFunctionName(PyObject* /* self */, PyObject* args);
PyObject* WrapAclRtRegisterCpuFunc(PyObject* /* self */, PyObject* args);
PyObject* WrapAclRtCreateBinary(PyObject* self, PyObject* args);
PyObject* WrapAclRtDestroyBinary(PyObject* self, PyObject* args);
PyObject* WrapAclRtBinaryLoad(PyObject* self, PyObject* args);
PyObject* WrapAclRtBinaryUnLoad(PyObject* self, PyObject* args);
PyObject* WrapAclRtBinaryGetFunction(PyObject* self, PyObject* args);
PyObject* WrapAclRtLaunchKernel(PyObject* self, PyObject* args);
PyObject* WrapAclRtKernelArgsInit(PyObject* self, PyObject* args);
PyObject* WrapAclRtKernelArgsInitByUserMem(PyObject* self, PyObject* args);
PyObject* WrapAclRtKernelArgsGetMemSize(PyObject* self, PyObject* args);
PyObject* WrapAclRtKernelArgsGetHandleMemSize(PyObject* self, PyObject* args);
PyObject* WrapAclRtKernelArgsAppend(PyObject* self, PyObject* args);
PyObject* WrapAclRtKernelArgsAppendPlaceHolder(PyObject* self, PyObject* args);
PyObject* WrapAclRtKernelArgsGetPlaceHolderBuffer(PyObject* self, PyObject* args);
PyObject* WrapAclRtKernelArgsParaUpdate(PyObject* self, PyObject* args);
PyObject* WrapAclRtKernelArgsFinalize(PyObject* self, PyObject* args);
PyObject* WrapAclRtLaunchKernelWithConfig(PyObject* self, PyObject* args);

#endif // ACL_PYTHON_RT_BINARY_H
