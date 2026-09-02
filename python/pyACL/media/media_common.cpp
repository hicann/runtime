/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "media_common.h"
#include "acl/acl.h"
#include "acl/ops/acl_dvpp.h"

// 内存申请与释放
PyObject* WrapAclDvppMalloc(PyObject* /* self */, PyObject* args)
{
    size_t size = 0;
    void* devPtr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &size), "acl.media.dvpp_malloc args parse failed!");

    aclError ret = acldvppMalloc(&devPtr, size);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(devPtr), ret);
}

static bool GetUnionValueFromPyDict(PyObject* pyDict, const char* keyName, aclrtMallocAttrValue& value)
{
    PyObject* pyValue = PyDict_GetItemString(pyDict, keyName);
    CHECK_STRUCT_DICT(pyValue, "the aclrtMallocAttrValue argument is not dict");

    if (PyDict_GetItemString(pyValue, "moduleId") != nullptr) {
        PyObject* pyModuleId = PyDict_GetItemString(pyValue, "moduleId");
        value.moduleId = static_cast<uint16_t>(PyLong_AsUnsignedLong(pyModuleId));
        CHECK_BOOL(PyErr_Occurred() == nullptr, "PyLong_AsUnsignedLong failed", PyExc_ValueError);
    } else if (PyDict_GetItemString(pyValue, "deviceId") != nullptr) {
        PyObject* pyDeviceId = PyDict_GetItemString(pyValue, "deviceId");
        value.deviceId = static_cast<uint32_t>(PyLong_AsUnsignedLong(pyDeviceId));
        CHECK_BOOL(PyErr_Occurred() == nullptr, "PyLong_AsUnsignedLong failed", PyExc_ValueError);
    } else if (PyDict_GetItemString(pyValue, "rsv") != nullptr) {
        PyObject* pyRsv = PyDict_GetItemString(pyValue, "rsv");
        Py_ssize_t size = PyList_Size(pyRsv);
        int loopLimit = (size < 8) ? static_cast<int>(size) : 8;
        for (int i = 0; i < loopLimit; ++i) {
            PyObject* pyItem = PyList_GetItem(pyRsv, i);
            value.rsv[i] = static_cast<uint8_t>(PyLong_AsUnsignedLong(pyItem));
            CHECK_BOOL(PyErr_Occurred() == nullptr, "PyLong_AsUnsignedLong failed", PyExc_ValueError);
        }
    } else {
        PyErr_SetString(PyExc_KeyError, "No valid key found in aclrtMallocAttrValue");
        return false;
    }

    return true;
}

static bool GetMallocAttributeFromPyDict(PyObject* pyDict, aclrtMallocAttribute& tmpAttr)
{
    CHECK_STRUCT_DICT(pyDict, "the aclrtMallocWithCfg argument is not dict");

    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "attr", tmpAttr.attr));
    CHECK_BOOL(GetUnionValueFromPyDict(pyDict, "value", tmpAttr.value));

    return true;
}

static bool GetMallocAttributeFromPyList(
    PyObject* pyDict, const char* keyName, size_t numAttrs, aclrtMallocAttribute*& attrs)
{
    PyObject* pyAttrs = PyDict_GetItemString(pyDict, keyName);
    CHECK_BOOL(pyAttrs, "the aclrtMallocAttrValue argument is not dict");
    Py_ssize_t size = PyList_Size(pyAttrs);
    if (size != static_cast<int>(numAttrs)) {
        PyErr_SetString(PyExc_KeyError, "The numAttrs inputed does not match the expected numAttrs");
        return false;
    }

    for (int i = 0; i < size; ++i) {
        PyObject* tmpPyAttrs = PyList_GetItem(pyAttrs, i);
        CHECK_BOOL(GetMallocAttributeFromPyDict(tmpPyAttrs, attrs[i]));
    }

    return true;
}

static bool GetMallocConfigFromPydict(PyObject* pyDict, aclrtMallocConfig& cfg)
{
    CHECK_BOOL(GetValueFromPyDict(pyDict, "numAttrs", cfg.numAttrs));
    CHECK_BOOL(GetMallocAttributeFromPyList(pyDict, "attrs", cfg.numAttrs, cfg.attrs));

    return true;
}

PyObject* WrapAclDvppMallocWithCfg(PyObject* /* self */, PyObject* args)
{
    void* devPtr = nullptr;
    size_t size = 0;
    int policy = 0;
    PyObject* pyCfg = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kiO", &size, &policy, &pyCfg), "acl.media.dvpp_malloc_with_cfg args parse failed!");
    CHECK_NULL(PyDict_Check(pyCfg), "pyCfg is not dict!");

    if (PyDict_Size(pyCfg) == 0) {
        aclError ret = acldvppMallocWithCfg(&devPtr, size, static_cast<aclrtMemMallocPolicy>(policy), nullptr);
        return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(devPtr), ret);
    }

    PyObject* pyAttrs = PyDict_GetItemString(pyCfg, "attrs");
    CHECK_NULL(pyAttrs, "the aclrtMallocAttrValue argument is not dict");
    Py_ssize_t pyAttrsSize = PyList_Size(pyAttrs);
    aclrtMallocConfig cfg = {};
    cfg.attrs = (aclrtMallocAttribute*)calloc(pyAttrsSize, sizeof(aclrtMallocAttribute));
    CHECK_NULL(cfg.attrs != nullptr, "cfg.attrs malloc failed!");

    if (!GetMallocConfigFromPydict(pyCfg, cfg)) {
        free(cfg.attrs);
        cfg.attrs = nullptr;
        return nullptr;
    }

    aclError ret = acldvppMallocWithCfg(&devPtr, size, static_cast<aclrtMemMallocPolicy>(policy), &cfg);
    free(cfg.attrs);
    cfg.attrs = nullptr;

    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(devPtr), ret);
}

PyObject* WrapAclDvppFree(PyObject* /* self */, PyObject* args)
{
    void* devPtr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &devPtr), "acl.media.dvpp_free args parse failed!");

    aclError ret = acldvppFree(devPtr);
    return Py_BuildValue("i", ret);
}
// 通道创建与释放
PyObject* WrapAclDvppCreateChannel(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.dvpp_create_channel args parse failed!");

    aclError ret = acldvppCreateChannel(channelDesc);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppDestroyChannel(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.dvpp_destroy_channel args parse failed!");

    aclError ret = acldvppDestroyChannel(channelDesc);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppCreateChannelDesc(PyObject* /* self */, PyObject* /* args */)
{
    acldvppChannelDesc* channelDesc = acldvppCreateChannelDesc();
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(channelDesc));
}

PyObject* WrapAclDvppDestroyChannelDesc(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.dvpp_destroy_channel_desc args parse failed!");

    aclError ret = acldvppDestroyChannelDesc(channelDesc);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppGetChannelDescChannelId(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.dvpp_get_channel_desc_channel_id args parse failed!");

    uint64_t channelId = acldvppGetChannelDescChannelId(channelDesc);
    return Py_BuildValue("K", channelId);
}

PyObject* WrapAclDvppSetChannelDescMode(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    uint32_t mode = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &channelDesc, &mode), "acl.media.dvpp_set_channel_desc_mode args parse failed!");

    aclError ret = acldvppSetChannelDescMode(channelDesc, mode);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppCreatePicDesc(PyObject* /* self */, PyObject* /* args */)
{
    acldvppPicDesc* picDesc = acldvppCreatePicDesc();
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(picDesc));
}

PyObject* WrapAclDvppDestroyPicDesc(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* picDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &picDesc), "acl.media.dvpp_destroy_pic_desc args parse failed!");

    aclError ret = acldvppDestroyPicDesc(picDesc);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetPicDescData(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* picDesc = nullptr;
    void* dataDev = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &picDesc, &dataDev), "acl.media.dvpp_set_pic_desc_data args parse failed!");

    aclError ret = acldvppSetPicDescData(picDesc, dataDev);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetPicDescSize(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* picDesc = nullptr;
    uint32_t size = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kI", &picDesc, &size), "acl.media.dvpp_set_pic_desc_size args parse failed!");

    aclError ret = acldvppSetPicDescSize(picDesc, size);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetPicDescFormat(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* picDesc = nullptr;
    int format = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ki", &picDesc, &format), "acl.media.dvpp_set_pic_desc_format args parse failed!");

    aclError ret = acldvppSetPicDescFormat(picDesc, static_cast<acldvppPixelFormat>(format));
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetPicDescWidth(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* picDesc = nullptr;
    uint32_t width = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kI", &picDesc, &width), "acl.media.dvpp_set_pic_desc_width args parse failed!");

    aclError ret = acldvppSetPicDescWidth(picDesc, width);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetPicDescHeight(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* picDesc = nullptr;
    uint32_t height = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &picDesc, &height), "acl.media.dvpp_set_pic_desc_height args parse failed!");

    aclError ret = acldvppSetPicDescHeight(picDesc, height);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetPicDescWidthStride(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* picDesc = nullptr;
    uint32_t widthStride = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &picDesc, &widthStride),
        "acl.media.dvpp_set_pic_desc_width_stride args parse failed!");

    aclError ret = acldvppSetPicDescWidthStride(picDesc, widthStride);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetPicDescHeightStride(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* picDesc = nullptr;
    uint32_t heightStride = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &picDesc, &heightStride),
        "acl.media.dvpp_set_pic_desc_height_stride args parse failed!");

    aclError ret = acldvppSetPicDescHeightStride(picDesc, heightStride);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetPicDescRetCode(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* picDesc = nullptr;
    uint32_t retCode = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &picDesc, &retCode), "acl.media.dvpp_set_pic_desc_ret_code args parse failed!");

    aclError ret = acldvppSetPicDescRetCode(picDesc, retCode);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppGetPicDescData(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* picDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &picDesc), "acl.media.dvpp_get_pic_desc_data args parse failed!");

    void* dataDev = acldvppGetPicDescData(picDesc);
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(dataDev));
}

PyObject* WrapAclDvppGetPicDescSize(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* picDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &picDesc), "acl.media.dvpp_get_pic_desc_size args parse failed!");

    uint32_t size = acldvppGetPicDescSize(picDesc);
    return Py_BuildValue("I", size);
}

PyObject* WrapAclDvppGetPicDescFormat(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* picDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &picDesc), "acl.media.dvpp_get_pic_desc_format args parse failed!");

    int pixelFormat = acldvppGetPicDescFormat(picDesc);
    return Py_BuildValue("i", pixelFormat);
}

PyObject* WrapAclDvppGetPicDescWidth(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* picDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &picDesc), "acl.media.dvpp_get_pic_desc_width args parse failed!");

    uint32_t width = acldvppGetPicDescWidth(picDesc);
    return Py_BuildValue("I", width);
}

PyObject* WrapAclDvppGetPicDescHeight(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* picDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &picDesc), "acl.media.dvpp_get_pic_desc_height args parse failed!");

    uint32_t height = acldvppGetPicDescHeight(picDesc);
    return Py_BuildValue("I", height);
}

PyObject* WrapAclDvppGetPicDescWidthStride(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* picDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &picDesc), "acl.media.dvpp_get_pic_desc_width_stride args parse failed!");

    uint32_t widthStride = acldvppGetPicDescWidthStride(picDesc);
    return Py_BuildValue("I", widthStride);
}

PyObject* WrapAclDvppGetPicDescHeightStride(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* picDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &picDesc), "acl.media.dvpp_get_pic_desc_height_stride args parse failed!");

    uint32_t heightStride = acldvppGetPicDescHeightStride(picDesc);
    return Py_BuildValue("I", heightStride);
}

PyObject* WrapAclDvppGetPicDescRetCode(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* picDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &picDesc), "acl.media.dvpp_get_pic_desc_ret_code args parse failed!");

    uint32_t retCode = acldvppGetPicDescRetCode(picDesc);
    return Py_BuildValue("I", retCode);
}

PyObject* WrapAclDvppCreateStreamDesc(PyObject* /* self */, PyObject* /* args */)
{
    acldvppStreamDesc* streamDesc = acldvppCreateStreamDesc();
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(streamDesc));
}

PyObject* WrapAclDvppDestroyStreamDesc(PyObject* /* self */, PyObject* args)
{
    acldvppStreamDesc* streamDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &streamDesc), "acl.media.dvpp_destroy_stream_desc args parse failed!");

    aclError ret = acldvppDestroyStreamDesc(streamDesc);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetStreamDescData(PyObject* /* self */, PyObject* args)
{
    acldvppStreamDesc* streamDesc = nullptr;
    void* dataDev = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kk", &streamDesc, &dataDev), "acl.media.dvpp_set_stream_desc_data args parse failed!");

    aclError ret = acldvppSetStreamDescData(streamDesc, dataDev);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetStreamDescSize(PyObject* /* self */, PyObject* args)
{
    acldvppStreamDesc* streamDesc = nullptr;
    uint32_t size = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &streamDesc, &size), "acl.media.dvpp_set_stream_desc_size args parse failed!");

    aclError ret = acldvppSetStreamDescSize(streamDesc, size);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetStreamDescFormat(PyObject* /* self */, PyObject* args)
{
    acldvppStreamDesc* streamDesc = nullptr;
    int format = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ki", &streamDesc, &format), "acl.media.dvpp_set_stream_desc_format args parse failed!");

    aclError ret = acldvppSetStreamDescFormat(streamDesc, static_cast<acldvppStreamFormat>(format));
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetStreamDescTimestamp(PyObject* /* self */, PyObject* args)
{
    acldvppStreamDesc* streamDesc = nullptr;
    uint64_t timestamp = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kK", &streamDesc, &timestamp),
        "acl.media.dvpp_set_stream_desc_timestamp args parse failed!");

    aclError ret = acldvppSetStreamDescTimestamp(streamDesc, timestamp);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetStreamDescRetCode(PyObject* /* self */, PyObject* args)
{
    acldvppStreamDesc* streamDesc = nullptr;
    uint32_t retCode = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &streamDesc, &retCode),
        "acl.media.dvpp_set_stream_desc_ret_code args parse failed!");

    aclError ret = acldvppSetStreamDescRetCode(streamDesc, retCode);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetStreamDescEos(PyObject* /* self */, PyObject* args)
{
    acldvppStreamDesc* streamDesc = nullptr;
    uint8_t eos = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kB", &streamDesc, &eos), "acl.media.dvpp_set_stream_desc_eos args parse failed!");

    aclError ret = acldvppSetStreamDescEos(streamDesc, eos);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppGetStreamDescData(PyObject* /* self */, PyObject* args)
{
    acldvppStreamDesc* streamDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &streamDesc), "acl.media.dvpp_get_stream_desc_data args parse failed!");

    void* dataDev = acldvppGetStreamDescData(streamDesc);
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(dataDev));
}

PyObject* WrapAclDvppGetStreamDescSize(PyObject* /* self */, PyObject* args)
{
    acldvppStreamDesc* streamDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &streamDesc), "acl.media.dvpp_get_stream_desc_size args parse failed!");

    uint32_t size = acldvppGetStreamDescSize(streamDesc);
    return Py_BuildValue("I", size);
}

PyObject* WrapAclDvppGetStreamDescFormat(PyObject* /* self */, PyObject* args)
{
    acldvppStreamDesc* streamDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &streamDesc), "acl.media.dvpp_get_stream_desc_format args parse failed!");

    int streamFormat = acldvppGetStreamDescFormat(streamDesc);
    return Py_BuildValue("i", streamFormat);
}

PyObject* WrapAclDvppGetStreamDescTimestamp(PyObject* /* self */, PyObject* args)
{
    acldvppStreamDesc* streamDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &streamDesc), "acl.media.dvpp_get_stream_desc_timestamp args parse failed!");

    uint64_t timestamp = acldvppGetStreamDescTimestamp(streamDesc);
    return Py_BuildValue("K", timestamp);
}

PyObject* WrapAclDvppGetStreamDescRetCode(PyObject* /* self */, PyObject* args)
{
    acldvppStreamDesc* streamDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &streamDesc), "acl.media.dvpp_get_stream_desc_ret_code args parse failed!");

    uint32_t retCode = acldvppGetStreamDescRetCode(streamDesc);
    return Py_BuildValue("I", retCode);
}

PyObject* WrapAclDvppGetStreamDescEos(PyObject* /* self */, PyObject* args)
{
    acldvppStreamDesc* streamDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &streamDesc), "acl.media.dvpp_get_stream_desc_eos args parse failed!");

    uint8_t eos = acldvppGetStreamDescEos(streamDesc);
    return Py_BuildValue("B", eos);
}

PyObject* WrapAclDvppCreateBatchPicDesc(PyObject* /* self */, PyObject* args)
{
    uint32_t batchSize = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "I", &batchSize), "acl.media.dvpp_create_batch_pic_desc args parse failed!");

    acldvppBatchPicDesc* batchPicDesc = acldvppCreateBatchPicDesc(batchSize);
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(batchPicDesc));
}

PyObject* WrapAclDvppDestroyBatchPicDesc(PyObject* /* self */, PyObject* args)
{
    acldvppBatchPicDesc* batchPicDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &batchPicDesc), "acl.media.dvpp_destroy_batch_pic_desc args parse failed!");

    aclError ret = acldvppDestroyBatchPicDesc(batchPicDesc);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppGetPicDesc(PyObject* /* self */, PyObject* args)
{
    acldvppBatchPicDesc* batchPicDesc = nullptr;
    uint32_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kI", &batchPicDesc, &index), "acl.media.dvpp_get_pic_desc args parse failed!");

    acldvppPicDesc* picDesc = acldvppGetPicDesc(batchPicDesc, index);
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(picDesc));
}

#ifdef USE_MDL
PyObject* WrapAclDvppCreateHist(PyObject* /* self */, PyObject* /* args */)
{
    acldvppHist* hist = acldvppCreateHist();
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(hist));
}

PyObject* WrapAclDvppDestroyHist(PyObject* /* self */, PyObject* args)
{
    acldvppHist* hist = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &hist), "acl.media.dvpp_destroy_hist args parse failed!");

    aclError ret = acldvppDestroyHist(hist);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppGetHistDims(PyObject* /* self */, PyObject* args)
{
    acldvppHist* hist = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &hist), "acl.media.dvpp_get_hist_dims args parse failed!");

    uint32_t ret = acldvppGetHistDims(hist);
    return Py_BuildValue("I", ret);
}

PyObject* WrapAclDvppGetHistData(PyObject* /* self */, PyObject* args)
{
    acldvppHist* hist = nullptr;
    uint32_t dim = 0;
    uint32_t* data = nullptr;
    uint16_t len = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kI", &hist, &dim), "acl.media.dvpp_get_hist_data args parse failed!");

    aclError ret = acldvppGetHistData(hist, dim, &data, &len);
    return Py_BuildValue("kIi", reinterpret_cast<uintptr_t>(data), static_cast<uint32_t>(len), ret);
}

PyObject* WrapAclDvppGetHistRetCode(PyObject* /* self */, PyObject* args)
{
    acldvppHist* hist = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &hist), "acl.media.dvpp_get_hist_ret_code args parse failed!");

    uint32_t ret = acldvppGetHistRetCode(hist);
    return Py_BuildValue("I", ret);
}

PyObject* WrapAclDvppClearHist(PyObject* /* self */, PyObject* args)
{
    acldvppHist* hist = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &hist), "acl.media.dvpp_clear_hist args parse failed!");

    aclError ret = acldvppClearHist(hist);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppCreateLutMap(PyObject* /* self */, PyObject* /* args */)
{
    acldvppLutMap* lutMap = acldvppCreateLutMap();
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(lutMap));
}

PyObject* WrapAclDvppDestroyLutMap(PyObject* /* self */, PyObject* args)
{
    acldvppLutMap* lutMap = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &lutMap), "acl.media.dvpp_destroy_lut_map args parse failed!");

    aclError ret = acldvppDestroyLutMap(lutMap);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppGetLutMapDims(PyObject* /* self */, PyObject* args)
{
    acldvppLutMap* lutMap = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &lutMap), "acl.media.dvpp_get_lut_map_dims args parse failed!");

    uint32_t ret = acldvppGetLutMapDims(lutMap);
    return Py_BuildValue("I", ret);
}

PyObject* WrapAclDvppGetLutMapData(PyObject* /* self */, PyObject* args)
{
    acldvppLutMap* lutMap = nullptr;
    uint32_t dim = 0;
    uint8_t* data = nullptr;
    uint32_t len = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kI", &lutMap, &dim), "acl.media.dvpp_get_lut_map_data args parse failed!");

    aclError ret = acldvppGetLutMapData(lutMap, dim, &data, &len);
    return Py_BuildValue("kIi", reinterpret_cast<uintptr_t>(data), len, ret);
}
#endif // USE_MDL

PyObject* WrapAclDvppCreateBorderConfig(PyObject* /* self */, PyObject* /* args */)
{
    acldvppBorderConfig* dvppBorderConfig = acldvppCreateBorderConfig();
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(dvppBorderConfig));
}

PyObject* WrapAclDvppDestroyBorderConfig(PyObject* /* self */, PyObject* args)
{
    acldvppBorderConfig* borderConfig = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &borderConfig), "acl.media.dvpp_destroy_border_config args parse failed!");

    aclError ret = acldvppDestroyBorderConfig(borderConfig);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppGetBorderConfigValue(PyObject* /* self */, PyObject* args)
{
    acldvppBorderConfig* borderConfig = nullptr;
    uint32_t index = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &borderConfig, &index),
        "acl.media.dvpp_get_border_config_value args parse failed!");

    double ret = acldvppGetBorderConfigValue(borderConfig, index);
    return Py_BuildValue("d", ret);
}

PyObject* WrapAclDvppGetBorderConfigBorderType(PyObject* /* self */, PyObject* args)
{
    acldvppBorderConfig* borderConfig = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &borderConfig), "acl.media.dvpp_get_border_config_border_type args parse failed!");

    acldvppBorderType ret = acldvppGetBorderConfigBorderType(borderConfig);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppGetBorderConfigTop(PyObject* /* self */, PyObject* args)
{
    acldvppBorderConfig* borderConfig = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &borderConfig), "acl.media.dvpp_get_border_config_Top args parse failed!");

    uint32_t ret = acldvppGetBorderConfigTop(borderConfig);
    return Py_BuildValue("I", ret);
}

PyObject* WrapAclDvppGetBorderConfigBottom(PyObject* /* self */, PyObject* args)
{
    acldvppBorderConfig* borderConfig = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &borderConfig), "acl.media.dvpp_get_border_config_bottom args parse failed!");

    uint32_t ret = acldvppGetBorderConfigBottom(borderConfig);
    return Py_BuildValue("I", ret);
}

PyObject* WrapAclDvppGetBorderConfigLeft(PyObject* /* self */, PyObject* args)
{
    acldvppBorderConfig* borderConfig = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &borderConfig), "acl.media.dvpp_get_border_config_left args parse failed!");

    uint32_t ret = acldvppGetBorderConfigLeft(borderConfig);
    return Py_BuildValue("I", ret);
}

PyObject* WrapAclDvppGetBorderConfigRight(PyObject* /* self */, PyObject* args)
{
    acldvppBorderConfig* borderConfig = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &borderConfig), "acl.media.dvpp_get_border_config_right args parse failed!");

    uint32_t ret = acldvppGetBorderConfigRight(borderConfig);
    return Py_BuildValue("I", ret);
}

PyObject* WrapAclDvppSetBorderConfigValue(PyObject* /* self */, PyObject* args)
{
    acldvppBorderConfig* borderConfig = nullptr;
    uint32_t index = 0;
    double value = 0.0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kId", &borderConfig, &index, &value),
        "acl.media.dvpp_set_border_config_value args parse failed!");

    aclError ret = acldvppSetBorderConfigValue(borderConfig, index, value);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetBorderConfigBorderType(PyObject* /* self */, PyObject* args)
{
    acldvppBorderConfig* borderConfig = nullptr;
    acldvppBorderType borderType = BORDER_CONSTANT;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ki", &borderConfig, &borderType),
        "acl.media.dvpp_set_border_config_border_type args parse failed!");

    aclError ret = acldvppSetBorderConfigBorderType(borderConfig, borderType);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetBorderConfigBottom(PyObject* /* self */, PyObject* args)
{
    acldvppBorderConfig* borderConfig = nullptr;
    uint32_t bottom = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &borderConfig, &bottom),
        "acl.media.dvpp_set_border_config_bottom args parse failed!");

    aclError ret = acldvppSetBorderConfigBottom(borderConfig, bottom);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetBorderConfigTop(PyObject* /* self */, PyObject* args)
{
    acldvppBorderConfig* borderConfig = nullptr;
    uint32_t top = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &borderConfig, &top), "acl.media.dvpp_set_border_config_Top args parse failed!");

    aclError ret = acldvppSetBorderConfigTop(borderConfig, top);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetBorderConfigLeft(PyObject* /* self */, PyObject* args)
{
    acldvppBorderConfig* borderConfig = nullptr;
    uint32_t left = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &borderConfig, &left), "acl.media.dvpp_set_border_config_left args parse failed!");

    aclError ret = acldvppSetBorderConfigLeft(borderConfig, left);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetBorderConfigRight(PyObject* /* self */, PyObject* args)
{
    acldvppBorderConfig* borderConfig = nullptr;
    uint32_t right = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &borderConfig, &right),
        "acl.media.dvpp_set_border_config_right args parse failed!");

    aclError ret = acldvppSetBorderConfigRight(borderConfig, right);
    return Py_BuildValue("i", ret);
}

// PNGD功能
PyObject* WrapAclDvppPngDecodeAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    void* data = nullptr;
    uint32_t size = 0;
    acldvppPicDesc* outputDesc = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkIkk", &channelDesc, &data, &size, &outputDesc, &stream),
        "acl.media.dvpp_png_decode_async args parse failed!");

    aclError ret = acldvppPngDecodeAsync(channelDesc, data, size, outputDesc, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppPngGetImageInfo(PyObject* /* self */, PyObject* args)
{
    void* data = nullptr;
    uint32_t size = 0;
    uint32_t width = 0;
    uint32_t height = 0;
    int32_t components = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kI", &data, &size), "acl.media.dvpp_png_get_image_info args parse failed!");

    aclError ret = acldvppPngGetImageInfo(data, size, &width, &height, &components);
    return Py_BuildValue("IIii", width, height, components, ret);
}

PyObject* WrapAclDvppPngPredictDecSize(PyObject* /* self */, PyObject* args)
{
    void* data = nullptr;
    uint32_t dataSize = 0;
    acldvppPixelFormat outputPixelFormat = PIXEL_FORMAT_UNKNOWN;
    uint32_t decSize = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kIi", &data, &dataSize, &outputPixelFormat),
        "acl.media.dvpp_png_predict_dec_size args parse failed!");

    aclError ret = acldvppPngPredictDecSize(data, dataSize, outputPixelFormat, &decSize);
    return Py_BuildValue("Ii", decSize, ret);
}

PyObject* WrapAclDvppSetChannelDescParam(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    acldvppChannelDescParamType paramType = ACL_DVPP_CSC_MATRIX_UINT32;
    size_t length = 0;
    const void* param = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kik", &channelDesc, &paramType, &param),
        "acl.media.dvpp_set_channel_desc_param args parse failed!");

    switch (static_cast<acldvppChannelDescParamType>(paramType)) {
        case ACL_DVPP_CSC_MATRIX_UINT32:
            length = sizeof(uint32_t);
            break;
        default:
            length = 0;
    }

    aclError ret = acldvppSetChannelDescParam(channelDesc, paramType, length, reinterpret_cast<const void*>(&param));
    return Py_BuildValue("ki", channelDesc, ret);
}

PyObject* WrapAclDvppGetChannelDescParam(PyObject* /* self */, PyObject* args)
{
    const acldvppChannelDesc* channelDesc = nullptr;
    acldvppChannelDescParamType paramType = ACL_DVPP_CSC_MATRIX_UINT32;
    size_t length = 0;
    size_t paramRetSize = 0;
    uint64_t param = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ki", &channelDesc, &paramType),
        "acl.media.dvpp_get_channel_desc_param args parse failed!");

    switch (static_cast<acldvppChannelDescParamType>(paramType)) {
        case ACL_DVPP_CSC_MATRIX_UINT32:
            length = sizeof(uint32_t);
            break;
        default:
            length = 0;
    }

    aclError ret = acldvppGetChannelDescParam(channelDesc, paramType, length, &paramRetSize, &param);
    return Py_BuildValue("kKi", paramRetSize, param, ret);
}