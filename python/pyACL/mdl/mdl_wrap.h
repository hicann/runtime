/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_MDL_H
#define WORD_MDL_H

#include <Python.h>
#include "utils_methods.h"

PyObject* WrapAclMdlLoadFromFile(PyObject* self, PyObject* args);
PyObject* WrapAclMdlUnload(PyObject* self, PyObject* args);
PyObject* WrapAclMdlQuerySize(PyObject* self, PyObject* args);
PyObject* WrapAclMdlExecute(PyObject* self, PyObject* args);
PyObject* WrapAclMdlExecuteAsync(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetDatasetBuffer(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetDatasetNumBuffers(PyObject* self, PyObject* args);
PyObject* WrapAclMdlAddDatasetBuffer(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetOutputSizeByIndex(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetNumInputs(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetNumOutputs(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetInputSizeByIndex(PyObject* self, PyObject* args);
PyObject* WrapAclMdlCreateDataset(PyObject* self, PyObject* args);
PyObject* WrapAclMdlDestroyDataset(PyObject* self, PyObject* args);
PyObject* WrapAclMdlCreateDesc(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetDesc(PyObject* self, PyObject* args);
PyObject* WrapAclMdlDestroyDesc(PyObject* self, PyObject* args);

PyObject* WrapAclMdlLoadFromMem(PyObject* self, PyObject* args);
PyObject* WrapAclMdlLoadFromFileWithMem(PyObject* self, PyObject* args);
PyObject* WrapAclMdlLoadFromMemWithMem(PyObject* self, PyObject* args);
PyObject* WrapAclMdlLoadFromFileWithQ(PyObject* self, PyObject* args);
PyObject* WrapAclMdlLoadFromMemWithQ(PyObject* self, PyObject* args);
PyObject* WrapAclMdlQuerySizeFromMem(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetDynamicBatchSize(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetDynamicHWSize(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetCurOutputDims(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetFirstAippInfo(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetDatasetTensorDesc(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetDatasetTensorDesc(PyObject* self, PyObject* args);

PyObject* WrapAclMdlCreateAIPP(PyObject* self, PyObject* args);
PyObject* WrapAclMdlDestroyAIPP(PyObject* self, PyObject* args);

PyObject* WrapAclMdlGetInputDims(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetInputDimsV2(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetOutputDims(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetInputNameByIndex(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetOutputNameByIndex(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetInputFormat(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetOutputFormat(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetInputDataType(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetOutputDataType(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetInputIndexByName(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetOutputIndexByName(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetDynamicBatch(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetDynamicHW(PyObject* self, PyObject* args);

PyObject* WrapAclMdlSetAIPPInputFormat(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetAIPPCscParams(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetAIPPRbuvSwapSwitch(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetAIPPAxSwapSwitch(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetAIPPSrcImageSize(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetAIPPScfParams(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetAIPPCropParams(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetAIPPPaddingParams(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetAIPPDtcPixelMean(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetAIPPDtcPixelMin(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetAIPPPixelVarReci(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetInputAIPP(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetInputDynamicDims(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetInputDynamicGearCount(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetInputDynamicDims(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetOpAttr(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetAippDataSize(PyObject* self, PyObject* args);

PyObject* WrapAclMdlCreateAndGetOpDesc(PyObject* self, PyObject* args);
PyObject* WrapAclMdlInitDump(PyObject* self, PyObject* args);
PyObject* WrapAclMdlFinalizeDump(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetAippType(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetAIPPByInputIndex(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetDump(PyObject* self, PyObject* args);
PyObject* WrapAclMdlDumpRegCallback(PyObject* self, PyObject* args);
PyObject* WrapAclMdlDumpUnregCallback(PyObject* self, PyObject* args);
PyObject* WrapAclMdlLoadWithConfig(PyObject* self, PyObject* args);
PyObject* WrapAclMdlCreateConfigHandle(PyObject* self, PyObject* args);
PyObject* WrapAclMdlDestroyConfigHandle(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetConfigOpt(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetTensorRealName(PyObject* self, PyObject* args);

// model execute with config handle
PyObject* WrapAclMdlCreateExecConfigHandle(PyObject* self, PyObject* args);
PyObject* WrapAclMdlDestroyExecConfigHandle(PyObject* self, PyObject* args);
PyObject* WrapAclMdlSetExecConfigOpt(PyObject* self, PyObject* args);
PyObject* WrapAclMdlExecuteV2(PyObject* self, PyObject* args);

PyObject* WrapAclMdlGetDescFromFile(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetDescFromMem(PyObject* self, PyObject* args);
PyObject* WrapAclMdlGetInputDimsRange(PyObject* self, PyObject* args);
PyObject* WrapAclMdlBundleLoadFromFile(PyObject* self, PyObject* args);
PyObject* WrapAclMdlBundleLoadFromMem(PyObject* self, PyObject* args);
PyObject* WrapAclMdlBundleUnload(PyObject* self, PyObject* args);
PyObject* WrapAclMdlBundleGetModelId(PyObject* self, PyObject* args);
PyObject* WrapAclMdlBundleGetModelNum(PyObject* self, PyObject* args);

#endif // WORD_MDL_H
