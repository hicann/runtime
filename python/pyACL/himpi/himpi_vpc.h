/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_HIMPI_VPC_FUNCS_H
#define WORD_HIMPI_VPC_FUNCS_H

#include <Python.h>
#include "utils_methods.h"

// 视频、图像解码
PyObject* WrapHiMpiVpcCreateChn(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcDestroyChn(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcResize(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcCrop(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcCropResize(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcCropResizePaste(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcConvertColor(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcConvertColorV2(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcConvertColorToYuv420(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcCopyMakeBorder(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcPyrdown(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcCalcHist(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcCalcHistV2(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcEqualizeHist(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcGetProcessResult(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcSysCreateChn(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcCropResizeMakeBorder(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcBatchCropResizePaste(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcBatchCropResizeMakeBorder(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcCropResizeResizePaste(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcDilate(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcDrawCover(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcDrawLine(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcDrawMosaic(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcDrawOsd(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcErode(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcFilter2d(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcFlip(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcGetAffineLut(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcGetLutMemSize(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcGetAffineTransform(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcGetPerspectiveLut(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcGetRemapLut(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcGetRotationMatrix(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcLutRemap(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcSetChnWorkspace(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcMedianBlur(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcRotate(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcWarpAffine(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcBlur(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcGaussianBlur(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVpcSetChnOptAttr(PyObject* self, PyObject* args);
#endif // WORD_HIMPI_VPC_FUNCS_H