/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_HIMPI_PNGD_FUNCS_H
#define WORD_HIMPI_PNGD_FUNCS_H

#include <Python.h>
#include "utils_methods.h"

// pngd图像解码
PyObject* WrapHiMpiPngdCreateChn(PyObject* self, PyObject* args);
PyObject* WrapHiMpiPngdDestroyChn(PyObject* self, PyObject* args);
PyObject* WrapHiMpiPngdSendStream(PyObject* self, PyObject* args);
PyObject* WrapHiMpiPngdGetImageData(PyObject* self, PyObject* args);
PyObject* WrapHiMpiPngGetImageInfo(PyObject* self, PyObject* args);

#endif // WORD_HIMPI_PNGD_FUNCS_H