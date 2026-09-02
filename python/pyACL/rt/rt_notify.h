/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_PYTHON_RT_NOTIFY_H
#define ACL_PYTHON_RT_NOTIFY_H

#include <Python.h>
#include "utils_methods.h"

PyObject* WrapAclRtCreateNotify(PyObject* self, PyObject* args);
PyObject* WrapAclRtDestroyNotify(PyObject* self, PyObject* args);
PyObject* WrapAclRtRecordNotify(PyObject* self, PyObject* args);
PyObject* WrapAclRtWaitAndResetNotify(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetNotifyId(PyObject* self, PyObject* args);
PyObject* WrapAclRtNotifyBatchReset(PyObject* self, PyObject* args);
PyObject* WrapAclRtNotifyGetExportKey(PyObject* self, PyObject* args);
PyObject* WrapAclRtNotifySetImportPid(PyObject* self, PyObject* args);
PyObject* WrapAclRtNotifyImportByKey(PyObject* self, PyObject* args);
#endif // ACL_PYTHON_RT_NOTIFY_H