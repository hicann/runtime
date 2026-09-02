/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "media_vpc.h"
#include <vector>
#include "acl/acl.h"
#include "acl/ops/acl_dvpp.h"

namespace {
constexpr int MAX_CROP_SIZE = 256;
} // anonymous namespace
PyObject* WrapAclDvppVpcResizeAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    acldvppPicDesc* inputDesc = nullptr;
    acldvppPicDesc* outputDesc = nullptr;
    acldvppResizeConfig* resizeConfig = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkk", &channelDesc, &inputDesc, &outputDesc, &resizeConfig, &stream),
        "acl.media.dvpp_vpc_resize_async args parse failed!");

    aclError ret = acldvppVpcResizeAsync(channelDesc, inputDesc, outputDesc, resizeConfig, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppVpcCropAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    acldvppPicDesc* inputDesc = nullptr;
    acldvppPicDesc* outputDesc = nullptr;
    acldvppRoiConfig* cropArea = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkk", &channelDesc, &inputDesc, &outputDesc, &cropArea, &stream),
        "acl.media.dvpp_vpc_crop_async args parse failed!");

    aclError ret = acldvppVpcCropAsync(channelDesc, inputDesc, outputDesc, cropArea, stream);
    return Py_BuildValue("i", ret);
}

static bool ProcessArray(PyObject& numList, uint32_t& numArray, int size)
{
    unsigned long tmp = 0;

    for (int i = 0; i < size; i++) {
        PyObject* object = PyList_GetItem(&numList, i);
        tmp = PyLong_AsUnsignedLong(object);
        if (tmp > MAX_CROP_SIZE) {
            PyErr_SetString(PyExc_ValueError, "number of crop areas must be between 1 and 256");
            return false;
        }
        (&numArray)[i] = static_cast<uint32_t>(tmp);
    }
    return true;
}

PyObject* WrapAclDvppVpcBatchCropAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    acldvppBatchPicDesc* srcBatchPicDescs = nullptr;
    acldvppBatchPicDesc* dstBatchPicDescs = nullptr;
    PyObject* cropAreasList = nullptr;
    aclrtStream stream = nullptr;
    PyObject* roiNumsList = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "kkOkOk", &channelDesc, &srcBatchPicDescs, &roiNumsList, &dstBatchPicDescs, &cropAreasList, &stream),
        "acl.media.dvpp_vpc_batch_crop_async args parse failed");
    CHECK_NULL(PyList_Check(roiNumsList) != 0 && PyList_Check(cropAreasList) != 0, "argument 3 or 5 is not list");

    int size = static_cast<int>(PyList_Size(roiNumsList));
    int cropSize = static_cast<int>(PyList_Size(cropAreasList));
    CHECK_NULL(
        size > 0 && size <= MAX_CROP_SIZE && cropSize > 0 && cropSize <= MAX_CROP_SIZE,
        "number of crop areas must be between 1 and 256", PyExc_ValueError);

    std::vector<uint32_t> roiNums(size + 1);
    CHECK_NULL(ProcessArray(*roiNumsList, *(roiNums.data()), size))
    std::vector<acldvppRoiConfig*> cropAreas(cropSize + 1, nullptr);
    CHECK_NULL(ConvertPyListToPtrArray(cropAreasList, cropSize, cropAreas.data()));

    aclError ret = acldvppVpcBatchCropAsync(
        channelDesc, srcBatchPicDescs, roiNums.data(), size, dstBatchPicDescs, cropAreas.data(), stream);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(dstBatchPicDescs), ret);
}

PyObject* WrapAclDvppVpcCropAndPasteAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    acldvppPicDesc* inputDesc = nullptr;
    acldvppPicDesc* outputDesc = nullptr;
    acldvppRoiConfig* cropArea = nullptr;
    acldvppRoiConfig* pasteArea = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkkk", &channelDesc, &inputDesc, &outputDesc, &cropArea, &pasteArea, &stream),
        "acl.media.dvpp_vpc_crop_and_paste_async args parse failed!");

    aclError ret = acldvppVpcCropAndPasteAsync(channelDesc, inputDesc, outputDesc, cropArea, pasteArea, stream);
    return Py_BuildValue("i", ret);
}

static bool CheckArgsAndGetSize(
    PyObject& roiNumsList, PyObject& cropAreasList, PyObject& pasteAreasList, int& size, int& cropSize)
{
    CHECK_BOOL(
        PyList_Check(&roiNumsList) != 0 && PyList_Check(&cropAreasList) != 0 && PyList_Check(&pasteAreasList) != 0,
        "argument 3, 5 or 6 is not list");

    size = static_cast<int>(PyList_Size(&roiNumsList));
    cropSize = static_cast<int>(PyList_Size(&cropAreasList));
    CHECK_BOOL(
        size > 0 && size <= MAX_CROP_SIZE && cropSize > 0 && cropSize <= MAX_CROP_SIZE &&
            PyList_Size(&pasteAreasList) == cropSize,
        "number of crop areas must be between 1 and 256", PyExc_ValueError);
    return true;
}

PyObject* WrapAclDvppVpcBatchCropAndPasteAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    acldvppBatchPicDesc* srcBatchPicDesc = nullptr;
    acldvppBatchPicDesc* dstBatchPicDesc = nullptr;
    PyObject* cropAreasList = nullptr;
    PyObject* pasteAreasList = nullptr;
    aclrtStream stream = nullptr;
    PyObject* roiNumsList = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "kkOkOOk", &channelDesc, &srcBatchPicDesc, &roiNumsList, &dstBatchPicDesc, &cropAreasList,
            &pasteAreasList, &stream),
        "acl.media.dvpp_vpc_batch_crop_and_paste_async args parse failed");

    int size = 0;
    int cropSize = 0;
    CHECK_NULL(CheckArgsAndGetSize(*roiNumsList, *cropAreasList, *pasteAreasList, size, cropSize));
    std::vector<uint32_t> roiNums(size + 1);
    CHECK_NULL(ProcessArray(*roiNumsList, *(roiNums.data()), size));
    std::vector<acldvppRoiConfig*> cropAreas(cropSize + 1, nullptr);
    std::vector<acldvppRoiConfig*> pasteAreas(cropSize + 1, nullptr);
    CHECK_NULL(ConvertPyListToPtrArray(cropAreasList, cropSize, cropAreas.data()));
    CHECK_NULL(ConvertPyListToPtrArray(pasteAreasList, cropSize, pasteAreas.data()));

    aclError ret = acldvppVpcBatchCropAndPasteAsync(
        channelDesc, srcBatchPicDesc, roiNums.data(), size, dstBatchPicDesc, cropAreas.data(), pasteAreas.data(),
        stream);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(dstBatchPicDesc), ret);
}

PyObject* WrapAclDvppVpcConvertColorAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    acldvppPicDesc* inputDesc = nullptr;
    acldvppPicDesc* outputDesc = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkk", &channelDesc, &inputDesc, &outputDesc, &stream),
        "acl.media.dvpp_vpc_convert_color_async args parse failed!");

    aclError ret = acldvppVpcConvertColorAsync(channelDesc, inputDesc, outputDesc, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppVpcPyrDownAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    acldvppPicDesc* inputDesc = nullptr;
    acldvppPicDesc* outputDesc = nullptr;
    void* reserve = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkk", &channelDesc, &inputDesc, &outputDesc, &reserve, &stream),
        "acl.media.dvpp_vpc_pyr_down_async args parse failed!");

    aclError ret = acldvppVpcPyrDownAsync(channelDesc, inputDesc, outputDesc, reserve, stream);
    return Py_BuildValue("i", ret);
}

#ifdef USE_MDL
PyObject* WrapAclDvppVpcEqualizeHistAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    acldvppPicDesc* inputDesc = nullptr;
    acldvppPicDesc* outputDesc = nullptr;
    const acldvppLutMap* lutMap = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkk", &channelDesc, &inputDesc, &outputDesc, &lutMap, &stream),
        "acl.media.dvpp_vpc_equalize_hist_async args parse failed!");

    aclError ret = acldvppVpcEqualizeHistAsync(channelDesc, inputDesc, outputDesc, lutMap, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppVpcMakeBorderAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    acldvppPicDesc* inputDesc = nullptr;
    acldvppPicDesc* outputDesc = nullptr;
    const acldvppBorderConfig* borderConfig = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkk", &channelDesc, &inputDesc, &outputDesc, &borderConfig, &stream),
        "acl.media.dvpp_vpc_make_border_async args parse failed!");

    aclError ret = acldvppVpcMakeBorderAsync(channelDesc, inputDesc, outputDesc, borderConfig, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppVpcCalcHistAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    acldvppPicDesc* srcPicDesc = nullptr;
    acldvppHist* hist = nullptr;
    void* reserve = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkk", &channelDesc, &srcPicDesc, &hist, &reserve, &stream),
        "acl.media.dvpp_vpc_calc_hist_async args parse failed!");

    aclError ret = acldvppVpcCalcHistAsync(channelDesc, srcPicDesc, hist, reserve, stream);
    return Py_BuildValue("i", ret);
}
#endif // USE_MDL

PyObject* WrapAclDvppCreateRoiConfig(PyObject* /* self */, PyObject* args)
{
    uint32_t left = 0;
    uint32_t right = 0;
    uint32_t top = 0;
    uint32_t bottom = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "IIII", &left, &right, &top, &bottom),
        "acl.media.dvpp_create_roi_config args parse failed!");

    acldvppRoiConfig* roiConfig = acldvppCreateRoiConfig(left, right, top, bottom);
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(roiConfig));
}

PyObject* WrapAclDvppDestroyRoiConfig(PyObject* /* self */, PyObject* args)
{
    acldvppRoiConfig* roiConfig = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &roiConfig), "acl.media.dvpp_destroy_roi_config args parse failed!");

    aclError ret = acldvppDestroyRoiConfig(roiConfig);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetRoiConfig(PyObject* /* self */, PyObject* args)
{
    acldvppRoiConfig* config = nullptr;
    uint32_t left = 0;
    uint32_t right = 0;
    uint32_t top = 0;
    uint32_t bottom = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kIIII", &config, &left, &right, &top, &bottom),
        "acl.media.dvpp_set_roi_config args parse failed!");

    aclError ret = acldvppSetRoiConfig(config, left, right, top, bottom);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetRoiConfigLeft(PyObject* /* self */, PyObject* args)
{
    acldvppRoiConfig* config = nullptr;
    uint32_t left = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kI", &config, &left), "acl.media.dvpp_set_roi_config_left args parse failed!");

    aclError ret = acldvppSetRoiConfigLeft(config, left);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetRoiConfigRight(PyObject* /* self */, PyObject* args)
{
    acldvppRoiConfig* config = nullptr;
    uint32_t right = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kI", &config, &right), "acl.media.dvpp_set_roi_config_right args parse failed!");

    aclError ret = acldvppSetRoiConfigRight(config, right);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetRoiConfigTop(PyObject* /* self */, PyObject* args)
{
    acldvppRoiConfig* config = nullptr;
    uint32_t top = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kI", &config, &top), "acl.media.dvpp_set_roi_config_top args parse failed!");

    aclError ret = acldvppSetRoiConfigTop(config, top);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetRoiConfigBottom(PyObject* /* self */, PyObject* args)
{
    acldvppRoiConfig* config = nullptr;
    uint32_t bottom = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &config, &bottom), "acl.media.dvpp_set_roi_config_bottom args parse failed!");

    aclError ret = acldvppSetRoiConfigBottom(config, bottom);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppCreateResizeConfig(PyObject* /* self */, PyObject* /* args */)
{
    acldvppResizeConfig* resizeConfig = acldvppCreateResizeConfig();
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(resizeConfig));
}

PyObject* WrapAclDvppDestroyResizeConfig(PyObject* /* self */, PyObject* args)
{
    acldvppResizeConfig* resizeConfig = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &resizeConfig), "acl.media.dvpp_destroy_resize_config args parse failed!");

    aclError ret = acldvppDestroyResizeConfig(resizeConfig);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppSetResizeConfigInterpolation(PyObject* /* self */, PyObject* args)
{
    acldvppResizeConfig* resizeConfig = nullptr;
    uint32_t interpolation = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &resizeConfig, &interpolation),
        "acl.media.dvpp_set_resize_config_interpolation args parse failed!");

    aclError ret = acldvppSetResizeConfigInterpolation(resizeConfig, interpolation);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppGetResizeConfigInterpolation(PyObject* /* self */, PyObject* args)
{
    acldvppResizeConfig* resizeConfig = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &resizeConfig),
        "acl.media.dvpp_get_resize_config_interpolation args parse failed!");

    uint32_t interpolation = acldvppGetResizeConfigInterpolation(resizeConfig);
    return Py_BuildValue("I", interpolation);
}

PyObject* WrapAclDvppVpcCropResizeAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    acldvppPicDesc* inputDesc = nullptr;
    acldvppPicDesc* outputDesc = nullptr;
    acldvppRoiConfig* cropArea = nullptr;
    acldvppResizeConfig* resizeConfig = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkkk", &channelDesc, &inputDesc, &outputDesc, &cropArea, &resizeConfig, &stream),
        "acl.media.dvpp_vpc_crop_resize_async args parse failed");

    aclError ret = acldvppVpcCropResizeAsync(channelDesc, inputDesc, outputDesc, cropArea, resizeConfig, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppVpcBatchCropResizeAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    acldvppBatchPicDesc* srcBatchPicDescs = nullptr;
    PyObject* roiNumsObj = nullptr;
    acldvppBatchPicDesc* dstBatchPicDescs = nullptr;
    PyObject* cropAreasObj = nullptr;
    acldvppResizeConfig* resizeConfig = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "kkOkOkk", &channelDesc, &srcBatchPicDescs, &roiNumsObj, &dstBatchPicDescs, &cropAreasObj,
            &resizeConfig, &stream),
        "acl.media.dvpp_vpc_batch_crop_resize_async args parse failed");

    CHECK_NULL(PyList_Check(roiNumsObj), "argument 3 is not list");
    ssize_t roiNumsSize = PyList_Size(roiNumsObj);
    std::vector<uint32_t> roiNums(roiNumsSize + 1);
    CHECK_NULL(ConvertPyListToUnsignedLongArray(roiNumsObj, static_cast<int>(roiNumsSize), roiNums.data()));

    CHECK_NULL(PyList_Check(cropAreasObj), "argument 5 is not list");
    ssize_t cropAreasSize = PyList_Size(cropAreasObj);
    std::vector<acldvppRoiConfig*> cropAreas(cropAreasSize + 1, nullptr);
    CHECK_NULL(ConvertPyListToPtrArray(cropAreasObj, static_cast<int>(cropAreasSize), cropAreas.data()));

    aclError ret = acldvppVpcBatchCropResizeAsync(
        channelDesc, srcBatchPicDescs, roiNums.data(), static_cast<int>(roiNumsSize), dstBatchPicDescs,
        cropAreas.data(), resizeConfig, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppVpcCropResizePasteAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    acldvppPicDesc* inputDesc = nullptr;
    acldvppPicDesc* outputDesc = nullptr;
    acldvppRoiConfig* cropArea = nullptr;
    acldvppRoiConfig* pasteArea = nullptr;
    acldvppResizeConfig* resizeConfig = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "kkkkkkk", &channelDesc, &inputDesc, &outputDesc, &cropArea, &pasteArea, &resizeConfig, &stream),
        "acl.media.dvpp_vpc_crop_resize_paste_async args parse failed");

    aclError ret =
        acldvppVpcCropResizePasteAsync(channelDesc, inputDesc, outputDesc, cropArea, pasteArea, resizeConfig, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppVpcBatchCropResizePasteAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    acldvppBatchPicDesc* srcBatchPicDescs = nullptr;
    PyObject* roiNumsObj = nullptr;
    acldvppBatchPicDesc* dstBatchPicDescs = nullptr;
    PyObject* cropAreasObj = nullptr;
    PyObject* pasteAreasObj = nullptr;
    acldvppResizeConfig* resizeConfig = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "kkOkOOkk", &channelDesc, &srcBatchPicDescs, &roiNumsObj, &dstBatchPicDescs, &cropAreasObj,
            &pasteAreasObj, &resizeConfig, &stream),
        "acl.media.dvpp_vpc_batch_crop_resize_paste_async args parse failed");

    CHECK_NULL(PyList_Check(roiNumsObj), "argument 3 is not list");
    ssize_t roiNumsSize = PyList_Size(roiNumsObj);
    std::vector<uint32_t> roiNums(roiNumsSize + 1);
    CHECK_NULL(ConvertPyListToUnsignedLongArray(roiNumsObj, static_cast<int>(roiNumsSize), roiNums.data()));

    CHECK_NULL(PyList_Check(cropAreasObj), "argument 5 is not list");
    ssize_t cropAreasSize = PyList_Size(cropAreasObj);
    std::vector<acldvppRoiConfig*> cropAreas(cropAreasSize + 1, nullptr);
    CHECK_NULL(ConvertPyListToPtrArray(cropAreasObj, static_cast<int>(cropAreasSize), cropAreas.data()));

    CHECK_NULL(PyList_Check(pasteAreasObj), "argument 6 is not list");
    ssize_t pasteAreasSize = PyList_Size(pasteAreasObj);
    std::vector<acldvppRoiConfig*> pasteAreas(pasteAreasSize + 1, nullptr);
    CHECK_NULL(ConvertPyListToPtrArray(pasteAreasObj, static_cast<int>(pasteAreasSize), pasteAreas.data()));

    aclError ret = acldvppVpcBatchCropResizePasteAsync(
        channelDesc, srcBatchPicDescs, roiNums.data(), static_cast<int>(roiNumsSize), dstBatchPicDescs,
        cropAreas.data(), pasteAreas.data(), resizeConfig, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDvppVpcBatchCropResizeMakeBorderAsync(PyObject* /* self */, PyObject* args)
{
    acldvppChannelDesc* channelDesc = nullptr;
    acldvppBatchPicDesc* srcBatchPicDescs = nullptr;
    PyObject* roiNumsObj = nullptr;
    acldvppBatchPicDesc* dstBatchPicDescs = nullptr;
    PyObject* cropAreasObj = nullptr;
    PyObject* borderCfgsObj = nullptr;
    acldvppResizeConfig* resizeConfig = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "kkOkOOkk", &channelDesc, &srcBatchPicDescs, &roiNumsObj, &dstBatchPicDescs, &cropAreasObj,
            &borderCfgsObj, &resizeConfig, &stream),
        "acl.media.dvpp_vpc_batch_crop_resize_make_border_async args parse failed");

    CHECK_NULL(PyList_Check(roiNumsObj), "the third argument is not list");
    ssize_t roiNumsSize = PyList_Size(roiNumsObj);
    std::vector<uint32_t> roiNums(roiNumsSize + 1);
    CHECK_NULL(ConvertPyListToUnsignedLongArray(roiNumsObj, static_cast<int>(roiNumsSize), roiNums.data()));

    CHECK_NULL(PyList_Check(cropAreasObj), "the fifth argument is not list");
    ssize_t cropAreasSize = PyList_Size(cropAreasObj);
    std::vector<acldvppRoiConfig*> cropAreas(cropAreasSize + 1, nullptr);
    CHECK_NULL(ConvertPyListToPtrArray(cropAreasObj, static_cast<int>(cropAreasSize), cropAreas.data()));

    CHECK_NULL(PyList_Check(borderCfgsObj), "the sixth argument is not list");
    ssize_t borderCfgsSize = PyList_Size(borderCfgsObj);
    std::vector<acldvppBorderConfig*> borderCfgs(borderCfgsSize + 1, nullptr);
    CHECK_NULL(ConvertPyListToPtrArray(borderCfgsObj, static_cast<int>(borderCfgsSize), borderCfgs.data()));

    aclError ret = acldvppVpcBatchCropResizeMakeBorderAsync(
        channelDesc, srcBatchPicDescs, roiNums.data(), static_cast<int>(roiNumsSize), dstBatchPicDescs,
        cropAreas.data(), borderCfgs.data(), resizeConfig, stream);
    return Py_BuildValue("i", ret);
}