/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_PYTHON_RT_STREAM_H
#define ACL_PYTHON_RT_STREAM_H

#include <Python.h>
#include "utils_methods.h"

PyObject* WrapAclRtCreateStream(PyObject* self, PyObject* args);
PyObject* WrapAclRtCreateStreamWithConfig(PyObject* self, PyObject* args);
PyObject* WrapAclRtDestroyStream(PyObject* self, PyObject* args);
PyObject* WrapAclRtDestroyStreamForce(PyObject* self, PyObject* args);
PyObject* WrapAclRtSetStreamOverflowSwitch(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetStreamOverflowSwitch(PyObject* self, PyObject* args);
PyObject* WrapAclRtSetStreamFailureMode(PyObject* self, PyObject* args);
PyObject* WrapAclRtStreamQuery(PyObject* self, PyObject* args);
PyObject* WrapAclRtStreamAbort(PyObject* self, PyObject* args);
PyObject* WrapAclRtStreamGetId(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetStreamAvailableNum(PyObject* self, PyObject* args);
PyObject* WrapAclRtSetStreamAttribute(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetStreamAttribute(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetStreamResLimit(PyObject* self, PyObject* args);
PyObject* WrapAclRtSetStreamResLimit(PyObject* self, PyObject* args);
PyObject* WrapAclRtResetStreamResLimit(PyObject* self, PyObject* args);
PyObject* WrapAclRtUseStreamResInCurrentThread(PyObject* self, PyObject* args);
PyObject* WrapAclRtUnuseStreamResInCurrentThread(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetResInCurrentThread(PyObject* self, PyObject* args);
#endif // ACL_PYTHON_RT_STREAM_H
