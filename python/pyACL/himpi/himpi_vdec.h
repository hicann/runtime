/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_HIMPI_VDEC_FUNCS_H
#define WORD_HIMPI_VDEC_FUNCS_H

#include <Python.h>
#include "utils_methods.h"

// 视频、图像解码
PyObject* WrapHiMpiVdecCreateChn(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecDestroyChn(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecGetChnAttr(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecSetChnAttr(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecStartRecvStream(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecStopRecvStream(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecQueryStatus(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecResetChn(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecSetChnParam(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecGetChnParam(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecSetProtocolParam(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecGetProtocolParam(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecSendStream(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecGetFrame(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecReleaseFrame(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecGetFd(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecCloseFd(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecGetPicBufSize(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecGetTmvBufSize(PyObject* self, PyObject* args);
PyObject* WrapHiMpiDvppGetImageInfo(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecSetJpegdPrecisionMode(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecGetJpegdOutputInfo(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecSetDisplayMode(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVdecGetDisplayMode(PyObject* self, PyObject* args);
#endif // WORD_HIMPI_VDEC_FUNCS_H