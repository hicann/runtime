/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_RT_CONTEXT_FUNCS_H
#define WORD_RT_CONTEXT_FUNCS_H

#include <Python.h>
#include "utils_methods.h"

PyObject* WrapAclRtCreateContext(PyObject* self, PyObject* args);
PyObject* WrapAclRtDestroyContext(PyObject* self, PyObject* args);
PyObject* WrapAclRtSetCurrentContext(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetCurrentContext(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetOverflowStatus(PyObject* self, PyObject* args);
PyObject* WrapAclRtResetOverflowStatus(PyObject* self, PyObject* args);
PyObject* WrapAclRtCtxSetSysParamOpt(PyObject* self, PyObject* args);
PyObject* WrapAclRtCtxGetSysParamOpt(PyObject* self, PyObject* args);
PyObject* WrapAclRtSetSysParamOpt(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetSysParamOpt(PyObject* self, PyObject* args);
PyObject* WrapAclRtCtxGetCurrentDefaultStream(PyObject* self, PyObject* args);
PyObject* WrapAclRtCtxGetPrimaryCtxState(PyObject* self, PyObject* args);

#endif // WORD_RT_CONTEXT_FUNCS_H
