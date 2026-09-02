/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_PROF_H
#define WORD_PROF_H

#include <Python.h>
#include "utils_methods.h"

PyObject* WrapAclProfCreateConfig(PyObject* self, PyObject* args);
PyObject* WrapAclProfDestroyConfig(PyObject* self, PyObject* args);
PyObject* WrapAclProfInit(PyObject* self, PyObject* args);
PyObject* WrapAclProfFinalize(PyObject* self, PyObject* args);
PyObject* WrapAclProfStart(PyObject* self, PyObject* args);
PyObject* WrapAclProfStop(PyObject* self, PyObject* args);
PyObject* WrapAclProfModelSubscribe(PyObject* self, PyObject* args);
PyObject* WrapAclProfModelUnSubscribe(PyObject* self, PyObject* args);
PyObject* WrapAclProfCreateSubscribeConfig(PyObject* self, PyObject* args);
PyObject* WrapAclProfDestroySubscribeConfig(PyObject* self, PyObject* args);
PyObject* WrapAclProfGetOpDescSize(PyObject* self, PyObject* args);
PyObject* WrapAclProfGetOpNum(PyObject* self, PyObject* args);
PyObject* WrapAclProfGetOpType(PyObject* self, PyObject* args);
PyObject* WrapAclProfGetOpName(PyObject* self, PyObject* args);
PyObject* WrapAclProfGetOpTypeV2(PyObject* self, PyObject* args);
PyObject* WrapAclProfGetOpNameV2(PyObject* self, PyObject* args);
PyObject* WrapAclProfGetOpStart(PyObject* self, PyObject* args);
PyObject* WrapAclProfGetOpEnd(PyObject* self, PyObject* args);
PyObject* WrapAclProfGetOpDuration(PyObject* self, PyObject* args);
PyObject* WrapAclProfGetModelId(PyObject* self, PyObject* args);
PyObject* WrapAclProfGetOpTypeLen(PyObject* self, PyObject* args);
PyObject* WrapAclProfGetOpNameLen(PyObject* self, PyObject* args);
PyObject* WrapAclProfGetStepTimestamp(PyObject* self, PyObject* args);
PyObject* WrapAclProfCreateStepInfo(PyObject* self, PyObject* args);
PyObject* WrapAclProfDestroyStepInfo(PyObject* self, PyObject* args);
PyObject* WrapAclProfCreateStamp(PyObject* self, PyObject* args);
PyObject* WrapAclProfDestroyStamp(PyObject* self, PyObject* args);
PyObject* WrapAclProfPush(PyObject* self, PyObject* args);
PyObject* WrapAclProfPop(PyObject* self, PyObject* args);
PyObject* WrapAclProfRangeStart(PyObject* self, PyObject* args);
PyObject* WrapAclProfRangeStop(PyObject* self, PyObject* args);
PyObject* WrapAclProfSetStampTraceMessage(PyObject* self, PyObject* args);
PyObject* WrapAclProfMark(PyObject* self, PyObject* args);
PyObject* WrapAclProfMarkEx(PyObject* self, PyObject* args);
PyObject* WrapAclProfSetConfig(PyObject* self, PyObject* args);
#endif // WORD_PROF_H
