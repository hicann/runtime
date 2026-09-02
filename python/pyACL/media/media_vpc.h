/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_MEDIA_VPC_FUNCS_H
#define WORD_MEDIA_VPC_FUNCS_H

#include <Python.h>
#include "utils_methods.h"

PyObject* WrapAclDvppVpcResizeAsync(PyObject* self, PyObject* args);
PyObject* WrapAclDvppVpcCropAsync(PyObject* self, PyObject* args);
PyObject* WrapAclDvppVpcBatchCropAsync(PyObject* self, PyObject* args);
PyObject* WrapAclDvppVpcCropAndPasteAsync(PyObject* self, PyObject* args);
PyObject* WrapAclDvppVpcBatchCropAndPasteAsync(PyObject* self, PyObject* args);
PyObject* WrapAclDvppVpcConvertColorAsync(PyObject* self, PyObject* args);
PyObject* WrapAclDvppVpcPyrDownAsync(PyObject* self, PyObject* args);
PyObject* WrapAclDvppCreateRoiConfig(PyObject* self, PyObject* args);
PyObject* WrapAclDvppDestroyRoiConfig(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetRoiConfig(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetRoiConfigLeft(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetRoiConfigRight(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetRoiConfigTop(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetRoiConfigBottom(PyObject* self, PyObject* args);
PyObject* WrapAclDvppCreateResizeConfig(PyObject* self, PyObject* args);
PyObject* WrapAclDvppDestroyResizeConfig(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetResizeConfigInterpolation(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetResizeConfigInterpolation(PyObject* self, PyObject* args);
PyObject* WrapAclDvppVpcEqualizeHistAsync(PyObject* self, PyObject* args);
PyObject* WrapAclDvppVpcMakeBorderAsync(PyObject* self, PyObject* args);
PyObject* WrapAclDvppVpcCalcHistAsync(PyObject* self, PyObject* args);
PyObject* WrapAclDvppVpcCropResizeAsync(PyObject* self, PyObject* args);
PyObject* WrapAclDvppVpcBatchCropResizeAsync(PyObject* self, PyObject* args);
PyObject* WrapAclDvppVpcCropResizePasteAsync(PyObject* self, PyObject* args);
PyObject* WrapAclDvppVpcBatchCropResizePasteAsync(PyObject* self, PyObject* args);
PyObject* WrapAclDvppVpcBatchCropResizeMakeBorderAsync(PyObject* self, PyObject* args);

#endif // WORD_MEDIA_VPC_FUNCS_H
