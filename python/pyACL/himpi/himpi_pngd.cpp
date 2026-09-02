/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "himpi_pngd.h"
#include "acl/dvpp/hi_dvpp_pngd.h"

static bool GetPngdChnAttrFromPydict(PyObject* pyDict, hi_pngd_chn_attr& attr)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_pngd_chn_attr argument is not dict");
    CHECK_BOOL(MemsetStructArgu(attr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "stream_que_cnt", attr.stream_que_cnt));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "reserved", attr.reserved, sizeof(attr.reserved) / sizeof(hi_u64)));

    return true;
}

PyObject* WrapHiMpiPngdCreateChn(PyObject* /* self */, PyObject* args)
{
    hi_pngd_chn chn = 0;
    PyObject* pyDict = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyDict), "acl.himpi.pngd_create_chn args parse failed!");

    hi_pngd_chn_attr attr{};
    CHECK_NULL(GetPngdChnAttrFromPydict(pyDict, attr));

    hi_s32 ret = hi_mpi_pngd_create_chn(chn, &attr);
    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiPngdDestroyChn(PyObject* /* self */, PyObject* args)
{
    hi_pngd_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.pngd_destroy_chn args parse failed!");

    hi_s32 ret = hi_mpi_pngd_destroy_chn(chn);
    return Py_BuildValue("I", ret);
}

static bool GetPicInfoFromPydict(PyObject* pyDict, hi_pic_info& attr)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_pic_info argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "picture_address", attr.picture_address));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "picture_buffer_size", attr.picture_buffer_size));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "picture_width", attr.picture_width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "picture_height", attr.picture_height));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "picture_width_stride", attr.picture_width_stride));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "picture_height_stride", attr.picture_height_stride));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "picture_format", attr.picture_format));

    return true;
}

PyObject* WrapHiMpiPngdSendStream(PyObject* /* self */, PyObject* args)
{
    hi_pngd_chn chn = 0;
    PyObject* pyStream = nullptr;
    PyObject* pyPicInfo = nullptr;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOOi", &chn, &pyStream, &pyPicInfo, &milliSec),
        "acl.himpi.pngd_send_stream args parse failed!");

    hi_img_stream stream{};
    CHECK_NULL(GetImgStreamFromPydict(pyStream, stream));

    hi_pic_info picInfo{};
    CHECK_NULL(GetPicInfoFromPydict(pyPicInfo, picInfo));

    hi_s32 ret = hi_mpi_pngd_send_stream(chn, &stream, &picInfo, milliSec);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromPicInfo(hi_pic_info& info)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "picture_address", Py_BuildValue("k", info.picture_address)));
    CHECK_NULL(SetItemToDict(pyDict, "picture_buffer_size", Py_BuildValue("I", info.picture_buffer_size)));
    CHECK_NULL(SetItemToDict(pyDict, "picture_width", Py_BuildValue("I", info.picture_width)));
    CHECK_NULL(SetItemToDict(pyDict, "picture_height", Py_BuildValue("I", info.picture_height)));
    CHECK_NULL(SetItemToDict(pyDict, "picture_width_stride", Py_BuildValue("I", info.picture_width_stride)));
    CHECK_NULL(SetItemToDict(pyDict, "picture_height_stride", Py_BuildValue("I", info.picture_height_stride)));
    CHECK_NULL(SetItemToDict(pyDict, "picture_format", Py_BuildValue("i", info.picture_format)));

    return pyDict;
}

static PyObject* GetPydictFromImgStream(hi_img_stream& info)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "type", Py_BuildValue("i", info.type)));
    CHECK_NULL(SetItemToDict(pyDict, "addr", Py_BuildValue("k", info.addr)));
    CHECK_NULL(SetItemToDict(pyDict, "len", Py_BuildValue("I", info.len)));
    CHECK_NULL(SetItemToDict(pyDict, "pts", Py_BuildValue("K", info.pts)));
    CHECK_NULL(
        SetItemToDict(pyDict, "reserved", GetPyListFromArray(info.reserved, sizeof(info.reserved) / sizeof(hi_s32))));

    return pyDict;
}

PyObject* WrapHiMpiPngdGetImageData(PyObject* /* self */, PyObject* args)
{
    hi_pngd_chn chn = 0;
    hi_pic_info picInfo;
    hi_s32 milliSec = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "ii", &chn, &milliSec), "acl.himpi.pngd_get_image_data args parse failed!");

    hi_img_stream stream{};
    hi_s32 ret = hi_mpi_pngd_get_image_data(chn, &picInfo, &stream, milliSec);

    PyObject* pyPicInfo = GetPydictFromPicInfo(picInfo);
    CHECK_NULL(pyPicInfo != nullptr);
    PyObject* pyStream = GetPydictFromImgStream(stream);
    CHECK_NULL(pyStream != nullptr);
    PyObject* obj = Py_BuildValue("OOI", pyPicInfo, pyStream, ret);
    Py_XDECREF(pyPicInfo);
    Py_XDECREF(pyStream);

    return obj;
}

static PyObject* GetPydictFromImgInfo(hi_img_info& info)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "width", Py_BuildValue("I", info.width)));
    CHECK_NULL(SetItemToDict(pyDict, "height", Py_BuildValue("I", info.height)));
    CHECK_NULL(SetItemToDict(pyDict, "width_stride", Py_BuildValue("I", info.width_stride)));
    CHECK_NULL(SetItemToDict(pyDict, "height_stride", Py_BuildValue("I", info.height_stride)));
    CHECK_NULL(SetItemToDict(pyDict, "img_buf_size", Py_BuildValue("I", info.img_buf_size)));
    CHECK_NULL(SetItemToDict(pyDict, "pixel_format", Py_BuildValue("I", info.pixel_format)));
    CHECK_NULL(
        SetItemToDict(pyDict, "reserved", GetPyListFromArray(info.reserved, sizeof(info.reserved) / sizeof(hi_u32))));

    return pyDict;
}

PyObject* WrapHiMpiPngGetImageInfo(PyObject* /* self */, PyObject* args)
{
    PyObject* pyStream = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "O", &pyStream), "acl.himpi.png_get_image_info args parse failed!");

    hi_img_stream stream{};
    CHECK_NULL(GetImgStreamFromPydict(pyStream, stream));

    hi_img_info imgInfo{};
    hi_s32 ret = hi_mpi_png_get_image_info(&stream, &imgInfo);
    PyObject* pyImgInfo = GetPydictFromImgInfo(imgInfo);
    CHECK_NULL(pyImgInfo != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyImgInfo, ret);
    Py_XDECREF(pyImgInfo);

    return obj;
}