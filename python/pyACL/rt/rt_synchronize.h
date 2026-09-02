/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ACL_PYTHON_RT_SYNCHRONIZE_H
#define ACL_PYTHON_RT_SYNCHRONIZE_H

#include <Python.h>
#include "utils_methods.h"

PyObject* WrapAclRtCreateEvent(PyObject* self, PyObject* args);
PyObject* WrapAclRtCreateEventWithFlag(PyObject* self, PyObject* args);
PyObject* WrapAclRtCreateEventExWithFlag(PyObject* self, PyObject* args);
PyObject* WrapAclRtDestroyEvent(PyObject* self, PyObject* args);
PyObject* WrapAclRtSynchronizeStream(PyObject* self, PyObject* args);
PyObject* WrapAclRtSynchronizeStreamWithTimeout(PyObject* self, PyObject* args);
PyObject* WrapAclRtProcessReport(PyObject* self, PyObject* args);
PyObject* WrapAclRtSubscribeReport(PyObject* self, PyObject* args);
PyObject* WrapAclRtUnSubscribeReport(PyObject* self, PyObject* args);
PyObject* WrapAclRtLaunchCallback(PyObject* self, PyObject* args);
PyObject* WrapAclRtSynchronizeDevice(PyObject* self, PyObject* args);
PyObject* WrapAclRtRecordEvent(PyObject* self, PyObject* args);
PyObject* WrapAclRtResetEvent(PyObject* self, PyObject* args);
PyObject* WrapAclRtQueryEvent(PyObject* self, PyObject* args);
PyObject* WrapAclRtQueryEventStatus(PyObject* self, PyObject* args);
PyObject* WrapAclRtQueryEventWaitStatus(PyObject* self, PyObject* args);
PyObject* WrapAclRtSynchronizeEvent(PyObject* self, PyObject* args);
PyObject* WrapAclRtSynchronizeEventWithTimeout(PyObject* self, PyObject* args);
PyObject* WrapAclRtEventElapsedTime(PyObject* self, PyObject* args);
PyObject* WrapAclRtEventGetTimestamp(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetEventId(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetEventAvailNum(PyObject* self, PyObject* args);
PyObject* WrapAclRtStreamWaitEvent(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetThreadLastTaskId(PyObject* self, PyObject* args);
PyObject* WrapAclRtReduceAsync(PyObject* self, PyObject* args);

PyObject* WrapAclRtSetExceptionInfoCallback(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetErrorCodeFromExceptionInfo(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetTaskIdFromExceptionInfo(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetStreamIdFromExceptionInfo(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetThreadIdFromExceptionInfo(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetDeviceIdFromExceptionInfo(PyObject* self, PyObject* args);
PyObject* WrapAclRtSetOpWaitTimeout(PyObject* self, PyObject* args);
PyObject* WrapAclRtSetOpExecuteTimeOut(PyObject* self, PyObject* args);
PyObject* WrapAclRtSetOpExecuteTimeOutV2(PyObject* self, PyObject* args);

PyObject* WrapAclRtPeekAtLastError(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetLastError(PyObject* self, PyObject* args);
PyObject* WrapAclRtSynchronizeDeviceWithTimeout(PyObject* self, PyObject* args);
PyObject* WrapAclRtCmoAsync(PyObject* self, PyObject* args);
PyObject* WrapAclGetOpTimeOutInterval(PyObject* self, PyObject* args);
PyObject* WrapAclGetOpExecuteTimeOut(PyObject* self, PyObject* args);
#endif // ACL_PYTHON_RT_SYNCHRONIZE_H
