/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_OP_FUNCS_H
#define WORD_OP_FUNCS_H

#include <Python.h>
#include "utils_methods.h"

PyObject* WrapAclOpSetModelDir(PyObject* self, PyObject* args);
PyObject* WrapAclOpLoad(PyObject* self, PyObject* args);
PyObject* WrapAclOpExecute(PyObject* self, PyObject* args);
PyObject* WrapAclOpExecWithHandle(PyObject* self, PyObject* args);
PyObject* WrapAclOpCast(PyObject* self, PyObject* args);
PyObject* WrapAclOpCreateHandleForCast(PyObject* self, PyObject* args);
PyObject* WrapAclOpCreateAttr(PyObject* self, PyObject* args);
PyObject* WrapAclOpDestroyAttr(PyObject* self, PyObject* args);
PyObject* WrapAclOpSetAttrBool(PyObject* self, PyObject* args);
PyObject* WrapAclOpSetAttrInt(PyObject* self, PyObject* args);
PyObject* WrapAclOpSetAttrFloat(PyObject* self, PyObject* args);
PyObject* WrapAclOpSetAttrString(PyObject* self, PyObject* args);
PyObject* WrapAclOpSetAttrListBool(PyObject* self, PyObject* args);
PyObject* WrapAclOpSetAttrListInt(PyObject* self, PyObject* args);
PyObject* WrapAclOpSetAttrListFloat(PyObject* self, PyObject* args);
PyObject* WrapAclOpSetAttrListString(PyObject* self, PyObject* args);
PyObject* WrapAclOpSetAttrListListInt(PyObject* self, PyObject* args);
PyObject* WrapAclOpCreateHandle(PyObject* self, PyObject* args);
PyObject* WrapAclOpDestroyHandle(PyObject* self, PyObject* args);
PyObject* WrapAclOpStartDumpArgs(PyObject* self, PyObject* args);
PyObject* WrapAclOpStopDumpArgs(PyObject* self, PyObject* args);
PyObject* WrapAclOpRegisterCompileFunc(PyObject* self, PyObject* args);
PyObject* WrapAclOpUnregisterCompileFunc(PyObject* self, PyObject* args);
PyObject* WrapAclOpCreateKernel(PyObject* self, PyObject* args);
PyObject* WrapAclOpSetKernelArgs(PyObject* self, PyObject* args);
PyObject* WrapAclOpSetKernelWorkspaceSizes(PyObject* self, PyObject* args);
PyObject* WrapAclOpUpdateParams(PyObject* self, PyObject* args);
PyObject* WrapAclOpExecuteV2(PyObject* self, PyObject* args);
PyObject* WrapAclOpInferShape(PyObject* self, PyObject* args);
PyObject* WrapAclOpSetAttrDataType(PyObject* self, PyObject* args);
PyObject* WrapAclOpSetAttrListDataType(PyObject* self, PyObject* args);
PyObject* WrapAclOpSetMaxOpQueueNum(PyObject* self, PyObject* args);

#endif // WORD_OP_FUNCS_H