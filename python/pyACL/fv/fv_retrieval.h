/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_FV_RETRIEVAL_FUNCS_H
#define WORD_FV_RETRIEVAL_FUNCS_H

#include <Python.h>
#include "utils_methods.h"

PyObject* WrapAclfvCreateInitPara(PyObject* self, PyObject* args);
PyObject* WrapAclfvDestroyInitPara(PyObject* self, PyObject* args);
PyObject* WrapAclfvSet1NTopNum(PyObject* self, PyObject* args);
PyObject* WrapAclfvSetNMTopNum(PyObject* self, PyObject* args);
PyObject* WrapAclfvInit(PyObject* self, PyObject* args);
PyObject* WrapAclfvRelease(PyObject* self, PyObject* args);
PyObject* WrapAclfvCreateFeatureInfo(PyObject* self, PyObject* args);
PyObject* WrapAclfvDestroyFeatureInfo(PyObject* self, PyObject* args);
PyObject* WrapAclfvCreateRepoRange(PyObject* self, PyObject* args);
PyObject* WrapAclfvDestroyRepoRange(PyObject* self, PyObject* args);
PyObject* WrapAclfvRepoAdd(PyObject* self, PyObject* args);
PyObject* WrapAclfvRepoDel(PyObject* self, PyObject* args);
PyObject* WrapAclfvDel(PyObject* self, PyObject* args);
PyObject* WrapAclfvModify(PyObject* self, PyObject* args);
PyObject* WrapAclfvCreateQueryTable(PyObject* self, PyObject* args);
PyObject* WrapAclfvDestroyQueryTable(PyObject* self, PyObject* args);
PyObject* WrapAclfvCreateSearchInput(PyObject* self, PyObject* args);
PyObject* WrapAclfvDestroySearchInput(PyObject* self, PyObject* args);
PyObject* WrapAclfvCreateSearchResult(PyObject* self, PyObject* args);
PyObject* WrapAclfvDestroySearchResult(PyObject* self, PyObject* args);
PyObject* WrapAclfvSearch(PyObject* self, PyObject* args);
#endif // WORD_FV_RETRIEVAL_FUNCS_H
