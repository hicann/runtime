/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_MEDIA_COMMON_FUNCS_H
#define WORD_MEDIA_COMMON_FUNCS_H

#include <Python.h>
#include "utils_methods.h"

// 媒体数据处理
PyObject* WrapAclDvppMalloc(PyObject* self, PyObject* args);
PyObject* WrapAclDvppMallocWithCfg(PyObject* self, PyObject* args);
PyObject* WrapAclDvppFree(PyObject* self, PyObject* args);
// 通道创建与释放
PyObject* WrapAclDvppCreateChannel(PyObject* self, PyObject* args);
PyObject* WrapAclDvppDestroyChannel(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetChannelDescParam(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetChannelDescParam(PyObject* self, PyObject* args);
// acldvppChannelDesc
PyObject* WrapAclDvppCreateChannelDesc(PyObject* self, PyObject* args);
PyObject* WrapAclDvppDestroyChannelDesc(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetChannelDescChannelId(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetChannelDescMode(PyObject* self, PyObject* args);
// acldvppPicDesc
PyObject* WrapAclDvppCreatePicDesc(PyObject* self, PyObject* args);
PyObject* WrapAclDvppDestroyPicDesc(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetPicDescData(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetPicDescSize(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetPicDescFormat(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetPicDescWidth(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetPicDescHeight(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetPicDescWidthStride(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetPicDescHeightStride(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetPicDescRetCode(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetPicDescData(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetPicDescSize(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetPicDescFormat(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetPicDescWidth(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetPicDescHeight(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetPicDescWidthStride(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetPicDescHeightStride(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetPicDescRetCode(PyObject* self, PyObject* args);
// acldvppStreamDesc
PyObject* WrapAclDvppCreateStreamDesc(PyObject* self, PyObject* args);
PyObject* WrapAclDvppDestroyStreamDesc(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetStreamDescData(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetStreamDescSize(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetStreamDescFormat(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetStreamDescTimestamp(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetStreamDescRetCode(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetStreamDescEos(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetStreamDescData(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetStreamDescSize(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetStreamDescFormat(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetStreamDescTimestamp(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetStreamDescRetCode(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetStreamDescEos(PyObject* self, PyObject* args);
// acldvppBatchPicDesc
PyObject* WrapAclDvppCreateBatchPicDesc(PyObject* self, PyObject* args);
PyObject* WrapAclDvppDestroyBatchPicDesc(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetPicDesc(PyObject* self, PyObject* args);
// acldvppLutMap
PyObject* WrapAclDvppCreateLutMap(PyObject* self, PyObject* args);
PyObject* WrapAclDvppDestroyLutMap(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetLutMapData(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetLutMapDims(PyObject* self, PyObject* args);
// acldvppBorderConfig
PyObject* WrapAclDvppCreateBorderConfig(PyObject* self, PyObject* args);
PyObject* WrapAclDvppDestroyBorderConfig(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetBorderConfigValue(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetBorderConfigBorderType(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetBorderConfigTop(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetBorderConfigBottom(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetBorderConfigLeft(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetBorderConfigRight(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetBorderConfigValue(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetBorderConfigBorderType(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetBorderConfigTop(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetBorderConfigBottom(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetBorderConfigLeft(PyObject* self, PyObject* args);
PyObject* WrapAclDvppSetBorderConfigRight(PyObject* self, PyObject* args);
// acldvppHist
PyObject* WrapAclDvppClearHist(PyObject* self, PyObject* args);
PyObject* WrapAclDvppCreateHist(PyObject* self, PyObject* args);
PyObject* WrapAclDvppDestroyHist(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetHistData(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetHistDims(PyObject* self, PyObject* args);
PyObject* WrapAclDvppGetHistRetCode(PyObject* self, PyObject* args);
// PNGD功能
PyObject* WrapAclDvppPngDecodeAsync(PyObject* self, PyObject* args);
PyObject* WrapAclDvppPngGetImageInfo(PyObject* self, PyObject* args);
PyObject* WrapAclDvppPngPredictDecSize(PyObject* self, PyObject* args);

#endif // WORD_MEDIA_COMMON_FUNCS_H
