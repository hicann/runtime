/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_RT_DEVICE_FUNCS_H
#define WORD_RT_DEVICE_FUNCS_H

#include <Python.h>
#include "utils_methods.h"

PyObject* WrapAclRtSetDevice(PyObject* self, PyObject* args);
PyObject* WrapAclRtResetDevice(PyObject* self, PyObject* args);
PyObject* WrapAclRtResetDeviceForce(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetDevice(PyObject* self, PyObject* args);
PyObject* WrapAclRtSetDeviceSatMode(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetDeviceSatMode(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetRunMode(PyObject* self, PyObject* args);
PyObject* WrapAclRtSetTsDevice(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetDeviceCount(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetDeviceUtilizationRate(PyObject* self, PyObject* args);
PyObject* WrapAclRtQueryDeviceStatus(PyObject* self, PyObject* args);
PyObject* WrapAclRtDeviceTaskAbort(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetDeviceInfo(PyObject* self, PyObject* args);
PyObject* WrapAclRtDeviceGetStreamPriorityRange(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetDeviceCapability(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetDeviceResLimit(PyObject* self, PyObject* args);
PyObject* WrapAclRtSetDeviceResLimit(PyObject* self, PyObject* args);
PyObject* WrapAclRtResetDeviceResLimit(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetDevicesTopo(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetLogicDevIdByUserDevId(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetUserDevIdByLogicDevId(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetLogicDevIdByPhyDevId(PyObject* self, PyObject* args);
PyObject* WrapAclRtGetPhyDevIdByLogicDevId(PyObject* self, PyObject* args);
PyObject* WrapAclRtDeviceGetUuid(PyObject* self, PyObject* args);
PyObject* WrapAclRtDevicePeerAccessStatus(PyObject* self, PyObject* args);

#endif // WORD_RT_DEVICE_FUNCS_H