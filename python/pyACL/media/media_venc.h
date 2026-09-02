/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_MEDIA_VENC_FUNCS_H
#define WORD_MEDIA_VENC_FUNCS_H

#include <Python.h>
#include "utils_methods.h"

PyObject* WrapAclVencCreateChannel(PyObject* self, PyObject* args);
PyObject* WrapAclVencDestroyChannel(PyObject* self, PyObject* args);
PyObject* WrapAclVencSendFrame(PyObject* self, PyObject* args);
PyObject* WrapAclVencCreateChannelDesc(PyObject* self, PyObject* args);
PyObject* WrapAclVencDestroyChannelDesc(PyObject* self, PyObject* args);
PyObject* WrapAclVencSetChannelDescThreadId(PyObject* self, PyObject* args);
PyObject* WrapAclVencSetChannelDescCallback(PyObject* self, PyObject* args);
PyObject* WrapAclVencSetChannelDescEnType(PyObject* self, PyObject* args);
PyObject* WrapAclVencSetChannelDescPicFormat(PyObject* self, PyObject* args);
PyObject* WrapAclVencSetChannelDescPicWidth(PyObject* self, PyObject* args);
PyObject* WrapAclVencSetChannelDescPicHeight(PyObject* self, PyObject* args);
PyObject* WrapAclVencSetChannelDescKeyFrameInterval(PyObject* self, PyObject* args);
PyObject* WrapAclVencGetChannelDescChannelId(PyObject* self, PyObject* args);
PyObject* WrapAclVencGetChannelDescThreadId(PyObject* self, PyObject* args);
PyObject* WrapAclVencGetChannelDescCallback(PyObject* self, PyObject* args);
PyObject* WrapAclVencGetChannelDescEnType(PyObject* self, PyObject* args);
PyObject* WrapAclVencGetChannelDescPicFormat(PyObject* self, PyObject* args);
PyObject* WrapAclVencGetChannelDescPicWidth(PyObject* self, PyObject* args);
PyObject* WrapAclVencGetChannelDescPicHeight(PyObject* self, PyObject* args);
PyObject* WrapAclVencGetChannelDescKeyFrameInterval(PyObject* self, PyObject* args);
PyObject* WrapAclVencCreateFrameConfig(PyObject* self, PyObject* args);
PyObject* WrapAclVencDestroyFrameConfig(PyObject* self, PyObject* args);
PyObject* WrapAclVencSetFrameConfigForceIFrame(PyObject* self, PyObject* args);
PyObject* WrapAclVencSetFrameConfigEos(PyObject* self, PyObject* args);
PyObject* WrapAclVencGetFrameConfigForceIFrame(PyObject* self, PyObject* args);
PyObject* WrapAclVencGetFrameConfigEos(PyObject* self, PyObject* args);
PyObject* WrapAclVencGetChannelDescBufAddr(PyObject* self, PyObject* args);
PyObject* WrapAclVencSetChannelDescBufAddr(PyObject* self, PyObject* args);
PyObject* WrapAclVencGetChannelDescBufSize(PyObject* self, PyObject* args);
PyObject* WrapAclVencSetChannelDescBufSize(PyObject* self, PyObject* args);
PyObject* WrapAclVencGetChannelDescMaxBitRate(PyObject* self, PyObject* args);
PyObject* WrapAclVencSetChannelDescMaxBitRate(PyObject* self, PyObject* args);
PyObject* WrapAclVencGetChannelDescRcMode(PyObject* self, PyObject* args);
PyObject* WrapAclVencSetChannelDescRcMode(PyObject* self, PyObject* args);
PyObject* WrapAclVencGetChannelDescSrcRate(PyObject* self, PyObject* args);
PyObject* WrapAclVencSetChannelDescSrcRate(PyObject* self, PyObject* args);
PyObject* WrapAclVencGetChannelDescParam(PyObject* self, PyObject* args);
PyObject* WrapAclVencSetChannelDescParam(PyObject* self, PyObject* args);
#endif // WORD_MEDIA_VENC_FUNCS_H
