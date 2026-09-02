/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "media_jpeg.h"
#include "acl/acl.h"
#include "acl/ops/acl_dvpp.h"

PyObject* WrapAclDvppJpegDecodeAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    void* data = nullptr;
    uint32_t size = 0;
    acldvppPicDesc* outputDesc = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkIkk", &channelDesc, &data, &size, &outputDesc, &stream),
        "acl.media.dvpp_jpeg_decode_async args parse failed");

    aclError ret = acldvppJpegDecodeAsync(channelDesc, data, size, outputDesc, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppJpegGetImageInfo(PyObject* /* self */, PyObject* args)
{
    void* data = nullptr;
    uint32_t size = 0;
    uint32_t width = 0;
    uint32_t height = 0;
    int32_t components = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kI", &data, &size), "acl.media.dvpp_jpeg_get_image_info args parse failed");

    aclError ret = acldvppJpegGetImageInfo(data, size, &width, &height, &components);
    return Py_BuildValue("IIii", width, height, components, ret);
}

PyObject* WrapAclDvppJpegGetImageInfoV2(PyObject* /* self */, PyObject* args)
{
    const void* data = nullptr;
    uint32_t size = 0;
    uint32_t width = 0;
    uint32_t height = 0;
    int32_t components = 0;
    acldvppJpegFormat format = ACL_JPEG_CSS_UNKNOWN;

    CHECK_NULL(PyArg_ParseTuple(args, "kI", &data, &size), "acl.media.dvpp_jpeg_get_image_info_v2 args parse failed");

    aclError ret = acldvppJpegGetImageInfoV2(data, size, &width, &height, &components, &format);
    return Py_BuildValue("IIiii", width, height, components, format, ret);
}

PyObject* WrapAclDvppJpegPredictDecSize(PyObject* /* self */, PyObject* args)
{
    void* data = nullptr;
    uint32_t dataSize = 0;
    int outputPixelFormat = 0;
    uint32_t decSize = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kIi", &data, &dataSize, &outputPixelFormat),
        "acl.media.dvpp_jpeg_predict_dec_size args parse failed");

    aclError ret =
        acldvppJpegPredictDecSize(data, dataSize, static_cast<acldvppPixelFormat>(outputPixelFormat), &decSize);
    return Py_BuildValue("Ii", decSize, ret);
}

PyObject* WrapAclDvppJpegEncodeAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    acldvppPicDesc* inputDesc = nullptr;
    void* data = nullptr;
    uint32_t* size = nullptr;
    acldvppJpegeConfig* config = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkkk", &channelDesc, &inputDesc, &data, &size, &config, &stream),
        "acl.media.dvpp_jpeg_encode_async args parse failed");

    aclError ret = acldvppJpegEncodeAsync(channelDesc, inputDesc, data, size, config, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppJpegPredictEncSize(PyObject* /* self */, PyObject* args)
{
    acldvppPicDesc* inputDesc = nullptr;
    acldvppJpegeConfig* config = nullptr;
    uint32_t size = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kk", &inputDesc, &config), "acl.media.dvpp_jpeg_predict_enc_size args parse failed");

    aclError ret = acldvppJpegPredictEncSize(inputDesc, config, &size);
    return Py_BuildValue("Ii", size, ret);
}

PyObject* WrapAclDvppCreateJpegeConfig(PyObject* /* self */, PyObject* /* args */)
{
    acldvppJpegeConfig* jpegeConfig = acldvppCreateJpegeConfig();
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(jpegeConfig));
}

PyObject* WrapAclDvppDestroyJpegeConfig(PyObject* /* self */, PyObject* args)
{
    acldvppJpegeConfig* jpegeConfig = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &jpegeConfig), "acl.media.dvpp_destroy_jpege_config args parse failed");

    aclError ret = acldvppDestroyJpegeConfig(jpegeConfig);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetJpegeConfigLevel(PyObject* /* self */, PyObject* args)
{
    acldvppJpegeConfig* jpegeConfig = nullptr;
    uint32_t level = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &jpegeConfig, &level), "acl.media.dvpp_set_jpege_config_level args parse failed");

    aclError ret = acldvppSetJpegeConfigLevel(jpegeConfig, level);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppGetJpegeConfigLevel(PyObject* /* self */, PyObject* args)
{
    acldvppJpegeConfig* jpegeConfig = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &jpegeConfig), "acl.media.dvpp_get_jpege_config_level args parse failed!");

    uint32_t level = acldvppGetJpegeConfigLevel(jpegeConfig);
    return Py_BuildValue("I", level);
}