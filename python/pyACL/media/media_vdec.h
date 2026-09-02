/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_MEDIA_VDEC_FUNCS_H
#define WORD_MEDIA_VDEC_FUNCS_H

#include <Python.h>
#include "utils_methods.h"

PyObject* WrapAclVdecCreateChannel(PyObject* self, PyObject* args);
PyObject* WrapAclVdecDestroyChannel(PyObject* self, PyObject* args);
PyObject* WrapAclVdecCreateChannelDesc(PyObject* self, PyObject* args);
PyObject* WrapAclVdecDestroyChannelDesc(PyObject* self, PyObject* args);
PyObject* WrapAclVdecSetChannelDescChannelId(PyObject* self, PyObject* args);
PyObject* WrapAclVdecSetChannelDescThreadId(PyObject* self, PyObject* args);
PyObject* WrapAclVdecSetChannelDescCallback(PyObject* self, PyObject* args);
PyObject* WrapAclVdecSetChannelDescEnType(PyObject* self, PyObject* args);
PyObject* WrapAclVdecSetChannelDescOutPicFormat(PyObject* self, PyObject* args);
PyObject* WrapAclVdecSetChannelDescOutPicWidth(PyObject* self, PyObject* args);
PyObject* WrapAclVdecSetChannelDescOutPicHeight(PyObject* self, PyObject* args);
PyObject* WrapAclVdecSetChannelDescRefFrameNum(PyObject* self, PyObject* args);
PyObject* WrapAclVdecGetChannelDescChannelId(PyObject* self, PyObject* args);
PyObject* WrapAclVdecGetChannelDescThreadId(PyObject* self, PyObject* args);
PyObject* WrapAclVdecGetChannelDescCallback(PyObject* self, PyObject* args);
PyObject* WrapAclVdecGetChannelDescEnType(PyObject* self, PyObject* args);
PyObject* WrapAclVdecGetChannelDescOutPicFormat(PyObject* self, PyObject* args);
PyObject* WrapAclVdecGetChannelDescOutPicWidth(PyObject* self, PyObject* args);
PyObject* WrapAclVdecGetChannelDescOutPicHeight(PyObject* self, PyObject* args);
PyObject* WrapAclVdecGetChannelDescRefFrameNum(PyObject* self, PyObject* args);
PyObject* WrapAclVdecSendFrame(PyObject* self, PyObject* args);
PyObject* WrapAclVdecSendSkippedFrame(PyObject* self, PyObject* args);
PyObject* WrapAclVdecCreateFrameConfig(PyObject* self, PyObject* args);
PyObject* WrapAclVdecDestroyFrameConfig(PyObject* self, PyObject* args);
PyObject* WrapAclVdecGetChannelDescOutMode(PyObject* self, PyObject* args);
PyObject* WrapAclVdecSetChannelDescOutMode(PyObject* self, PyObject* args);
PyObject* WrapAclVdecGetChannelDescBitDepth(PyObject* self, PyObject* args);
PyObject* WrapAclVdecSetChannelDescBitDepth(PyObject* self, PyObject* args);
PyObject* WrapAclVdecSetChannelDescParam(PyObject* self, PyObject* args);
PyObject* WrapAclVdecGetChannelDescParam(PyObject* self, PyObject* args);

#endif // WORD_MEDIA_VDEC_FUNCS_H
