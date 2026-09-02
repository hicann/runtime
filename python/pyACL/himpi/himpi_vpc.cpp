/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "himpi_vpc.h"
#include <vector>
#include "acl/dvpp/hi_dvpp_vpc.h"
#include "securec.h"

static bool GetVpcChnAttrFromPydict(PyObject* pyDict, hi_vpc_chn_attr& attr)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vpc_chn_attr argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "attr", attr.attr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "pic_width", attr.pic_width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "pic_height", attr.pic_height));

    return true;
}

PyObject* WrapHiMpiVpcCreateChn(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pyDict = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyDict), "acl.himpi.vpc_create_chn args parse failed!");

    hi_vpc_chn_attr attr{};
    CHECK_NULL(GetVpcChnAttrFromPydict(pyDict, attr));

    hi_s32 ret = hi_mpi_vpc_create_chn(chn, &attr);
    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiVpcDestroyChn(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.vpc_destroy_chn args parse failed!");

    hi_s32 ret = hi_mpi_vpc_destroy_chn(chn);
    return Py_BuildValue("I", ret);
}

static bool GetVpcPicInfoFromPydict(PyObject* pyDict, hi_vpc_pic_info& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vpc_pic_info argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "picture_address", info.picture_address));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "picture_buffer_size", info.picture_buffer_size));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "picture_width", info.picture_width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "picture_height", info.picture_height));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "picture_width_stride", info.picture_width_stride));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "picture_height_stride", info.picture_height_stride));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "picture_format", info.picture_format));

    return true;
}

PyObject* WrapHiMpiVpcResize(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pySourcePic = nullptr;
    PyObject* pyDestPic = nullptr;
    hi_double fx = 0;
    hi_double fy = 0;
    hi_u32 interpolation = 0;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOOddIi", &chn, &pySourcePic, &pyDestPic, &fx, &fy, &interpolation, &milliSec),
        "acl.himpi.vpc_resize args parse failed!");

    hi_vpc_pic_info sourcePic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pySourcePic, sourcePic));

    hi_vpc_pic_info destPic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pyDestPic, destPic));

    hi_s32 ret = hi_mpi_vpc_resize(chn, &sourcePic, &destPic, fx, fy, interpolation, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

static bool GetVpcCropRegionFromPydict(PyObject* pyDict, hi_vpc_crop_region& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vpc_crop_region argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "top_offset", info.top_offset));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "left_offset", info.left_offset));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "crop_width", info.crop_width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "crop_height", info.crop_height));

    return true;
}

static bool GetVpcCropRegionInfoFromPydict(PyObject* pyDict, hi_vpc_crop_region_info& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vpc_crop_region_info argument is not dict");

    PyObject* pyPicInfo = PyDict_GetItemString(pyDict, "dest_pic_info");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pyPicInfo, info.dest_pic_info));

    PyObject* pyCropRegion = PyDict_GetItemString(pyDict, "crop_region");
    CHECK_BOOL(GetVpcCropRegionFromPydict(pyCropRegion, info.crop_region));

    return true;
}

PyObject* WrapHiMpiVpcCrop(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pySourcePic = nullptr;
    PyObject* pyCropInfo = nullptr;
    hi_u32 count = 0;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOOIi", &chn, &pySourcePic, &pyCropInfo, &count, &milliSec),
        "acl.himpi.vpc_crop args parse failed!");

    hi_vpc_pic_info sourcePic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pySourcePic, sourcePic));

    CHECK_NULL(PyList_Check(pyCropInfo), "hi_vpc_pic_info argument is not list");
    hi_u32 len = static_cast<hi_u32>(PyList_Size(pyCropInfo));
    CHECK_NULL(len == count, "the lenth of crop info is not equal with count!");
    std::vector<hi_vpc_crop_region_info> cropInfos(count + 1);
    CHECK_NULL(ConvertPyListToStructArray(pyCropInfo, count, cropInfos.data(), GetVpcCropRegionInfoFromPydict));

    hi_s32 ret = hi_mpi_vpc_crop(chn, &sourcePic, cropInfos.data(), count, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

static bool GetVpcResizeInfoFromPydict(PyObject* pyDict, hi_vpc_resize_info& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vpc_resize_info argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "resize_width", info.resize_width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "resize_height", info.resize_height));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "interpolation", info.interpolation));

    return true;
}

static bool GetVpcCropResizeRegionFromPydict(PyObject* pyDict, hi_vpc_crop_resize_region& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vpc_crop_resize_region argument is not dict");

    PyObject* pyPicInfo = PyDict_GetItemString(pyDict, "dest_pic_info");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pyPicInfo, info.dest_pic_info));

    PyObject* pyCropRegion = PyDict_GetItemString(pyDict, "crop_region");
    CHECK_BOOL(GetVpcCropRegionFromPydict(pyCropRegion, info.crop_region));

    PyObject* pyResizeInfo = PyDict_GetItemString(pyDict, "resize_info");
    CHECK_BOOL(GetVpcResizeInfoFromPydict(pyResizeInfo, info.resize_info));

    return true;
}

PyObject* WrapHiMpiVpcCropResize(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pySourcePic = nullptr;
    PyObject* pyCropInfo = nullptr;
    hi_u32 count = 0;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOOIi", &chn, &pySourcePic, &pyCropInfo, &count, &milliSec),
        "acl.himpi.vpc_crop args parse failed!");

    hi_vpc_pic_info sourcePic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pySourcePic, sourcePic));

    CHECK_NULL(PyList_Check(pyCropInfo), "hi_vpc_crop_resize_region argument is not list");
    hi_u32 len = static_cast<hi_u32>(PyList_Size(pyCropInfo));
    CHECK_NULL(len == count, "the lenth of crop resize info is not equal with count!");
    std::vector<hi_vpc_crop_resize_region> cropInfos(count + 1);
    CHECK_NULL(ConvertPyListToStructArray(pyCropInfo, count, cropInfos.data(), GetVpcCropResizeRegionFromPydict));

    hi_s32 ret = hi_mpi_vpc_crop_resize(chn, &sourcePic, cropInfos.data(), count, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

static bool GetVpcCropResizePasteRegionFromPydict(PyObject* pyDict, hi_vpc_crop_resize_paste_region& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vpc_crop_resize_paste_region argument is not dict");

    PyObject* pyPicInfo = PyDict_GetItemString(pyDict, "dest_pic_info");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pyPicInfo, info.dest_pic_info));

    PyObject* pyCropRegion = PyDict_GetItemString(pyDict, "crop_region");
    CHECK_BOOL(GetVpcCropRegionFromPydict(pyCropRegion, info.crop_region));

    PyObject* pyResizeInfo = PyDict_GetItemString(pyDict, "resize_info");
    CHECK_BOOL(GetVpcResizeInfoFromPydict(pyResizeInfo, info.resize_info));

    CHECK_BOOL(GetValueFromPyDict(pyDict, "dest_top_offset", info.dest_top_offset));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "dest_left_offset", info.dest_left_offset));

    return true;
}

PyObject* WrapHiMpiVpcCropResizePaste(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pySourcePic = nullptr;
    PyObject* pyCropInfo = nullptr;
    hi_u32 count = 0;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOOIi", &chn, &pySourcePic, &pyCropInfo, &count, &milliSec),
        "acl.himpi.vpc_crop_resize_paste args parse failed!");

    hi_vpc_pic_info sourcePic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pySourcePic, sourcePic));

    CHECK_NULL(PyList_Check(pyCropInfo), "hi_vpc_crop_resize_paste_region argument is not list");
    hi_u32 len = static_cast<hi_u32>(PyList_Size(pyCropInfo));
    CHECK_NULL(len == count, "the lenth of crop resize info is not equal with count!");
    std::vector<hi_vpc_crop_resize_paste_region> cropInfos(count + 1);
    CHECK_NULL(ConvertPyListToStructArray(pyCropInfo, count, cropInfos.data(), GetVpcCropResizePasteRegionFromPydict));

    hi_s32 ret = hi_mpi_vpc_crop_resize_paste(chn, &sourcePic, cropInfos.data(), count, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

PyObject* WrapHiMpiVpcConvertColor(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pySourcePic = nullptr;
    PyObject* pyDestPic = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOOi", &chn, &pySourcePic, &pyDestPic, &milliSec),
        "acl.himpi.vpc_convert_color args parse failed!");

    hi_vpc_pic_info sourcePic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pySourcePic, sourcePic));

    hi_vpc_pic_info destPic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pyDestPic, destPic));

    hi_s32 ret = hi_mpi_vpc_convert_color(chn, &sourcePic, &destPic, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

static bool GetCscConfFromPydict(PyObject* pyDict, hi_csc_conf& conf)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_csc_conf argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "alpha", conf.alpha));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "attr", conf.attr, sizeof(conf.attr) / sizeof(hi_u32)));

    return true;
}

PyObject* WrapHiMpiVpcConvertColorV2(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pySourcePic = nullptr;
    PyObject* pyDestPic = nullptr;
    PyObject* pyConf = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOOOi", &chn, &pySourcePic, &pyDestPic, &pyConf, &milliSec),
        "acl.himpi.vpc_convert_color_v2 args parse failed!");

    hi_vpc_pic_info sourcePic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pySourcePic, sourcePic));

    hi_vpc_pic_info destPic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pyDestPic, destPic));

    hi_csc_conf conf{};
    CHECK_NULL(GetCscConfFromPydict(pyConf, conf));

    hi_s32 ret = hi_mpi_vpc_convert_color_v2(chn, &sourcePic, &destPic, &conf, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

PyObject* WrapHiMpiVpcConvertColorToYuv420(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pySourcePic = nullptr;
    PyObject* pyDestPic = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOOi", &chn, &pySourcePic, &pyDestPic, &milliSec),
        "acl.himpi.vpc_convert_color_to_yuv420 args parse failed!");

    hi_vpc_pic_info sourcePic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pySourcePic, sourcePic));

    hi_vpc_pic_info destPic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pyDestPic, destPic));

    hi_s32 ret = hi_mpi_vpc_convert_color_to_yuv420(chn, &sourcePic, &destPic, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

static bool GetVpcScalarFromPydict(PyObject* pyDict, hi_vpc_scalar& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vpc_scalar argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "val", info.val, sizeof(info.val) / sizeof(hi_double)));
    return true;
}

static bool GetVpcMakeBorderInfoFromPydict(PyObject* pyDict, hi_vpc_make_border_info& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vpc_make_border_info argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "top", info.top));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "bottom", info.bottom));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "left", info.left));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "right", info.right));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "border_type", info.border_type));

    PyObject* pyScalarValue = PyDict_GetItemString(pyDict, "scalar_value");
    CHECK_BOOL(GetVpcScalarFromPydict(pyScalarValue, info.scalar_value));

    return true;
}

PyObject* WrapHiMpiVpcCopyMakeBorder(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pySourcePic = nullptr;
    PyObject* pyDestPic = nullptr;
    PyObject* pyBorderInfo = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOOOi", &chn, &pySourcePic, &pyDestPic, &pyBorderInfo, &milliSec),
        "acl.himpi.vpc_copy_make_border args parse failed!");

    hi_vpc_pic_info sourcePic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pySourcePic, sourcePic));

    hi_vpc_pic_info destPic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pyDestPic, destPic));

    hi_vpc_make_border_info makeBorderInfo{};
    CHECK_NULL(GetVpcMakeBorderInfoFromPydict(pyBorderInfo, makeBorderInfo));

    hi_s32 ret = hi_mpi_vpc_copy_make_border(chn, &sourcePic, &destPic, makeBorderInfo, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

static bool CheckAndFillFilter(PyObject* pyGaussianFilter, hi_s8 filter[5][5])
{
    CHECK_BOOL(PyList_Check(pyGaussianFilter));
    Py_ssize_t countH = PyList_Size(pyGaussianFilter);
    // 检查是否为 5*5,并填充到数组中
    CHECK_BOOL(countH == 5)
    for (Py_ssize_t i = 0; i < countH; ++i) {
        PyObject* column = PyList_GetItem(pyGaussianFilter, i);
        CHECK_BOOL(column && PyList_Check(column) != 0);
        Py_ssize_t countW = PyList_Size(column);
        // 检查宽度是否为5
        CHECK_BOOL(countW == 5)
        for (Py_ssize_t j = 0; j < countW; ++j) {
            PyObject* PyNum = PyList_GetItem(column, j);
            CHECK_BOOL(PyLong_Check(PyNum));
            long cnum = PyLong_AsLong(PyNum);
            CHECK_BOOL(PyErr_Occurred() == nullptr);
            CHECK_BOOL(cnum >= INT8_MIN && cnum <= INT8_MAX);
            filter[i][j] = static_cast<hi_s8>(cnum);
        }
    }
    return true;
};

PyObject* WrapHiMpiVpcPyrdown(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pySourcePic = nullptr;
    PyObject* pyDestPics = nullptr;
    hi_u32 filterLevel = 0;
    PyObject* pyGaussianFilter = nullptr;
    hi_u16 divisor = 0;
    PyObject* pyBorderInfo = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "iOOIOHOi", &chn, &pySourcePic, &pyDestPics, &filterLevel, &pyGaussianFilter, &divisor, &pyBorderInfo,
            &milliSec),
        "acl.himpi.vpc_pyrdown args parse failed!");

    hi_vpc_pic_info sourcePic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pySourcePic, sourcePic));

    CHECK_NULL(PyList_Check(pyDestPics), "hi_vpc_pic_info argument is not list");
    int count = static_cast<int>(PyList_Size(pyDestPics));
    std::vector<hi_vpc_pic_info> destPics(count + 1);
    CHECK_NULL(ConvertPyListToStructArray(pyDestPics, count, destPics.data(), GetVpcPicInfoFromPydict));
    hi_vpc_make_border_info makeBorderInfo{};
    CHECK_NULL(GetVpcMakeBorderInfoFromPydict(pyBorderInfo, makeBorderInfo));
    // 如果用户传入None则为默认值
    if (pyGaussianFilter != Py_None) {
        // 检查是否为 5*5,并填充到数组中
        hi_s8 filter[5][5]{};
        CHECK_NULL(CheckAndFillFilter(pyGaussianFilter, filter), "gaussian_filter argument is not a 5*5 int8 list")
        hi_s32 ret = hi_mpi_vpc_pyrdown(
            chn, &sourcePic, destPics.data(), filterLevel, filter, divisor, makeBorderInfo, &taskId, milliSec);
        return Py_BuildValue("II", taskId, ret);
    }
    hi_s32 ret = hi_mpi_vpc_pyrdown(
        chn, &sourcePic, destPics.data(), filterLevel, nullptr, divisor, makeBorderInfo, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

static PyObject* GetPydictFromVpcHistogramConfig(hi_vpc_histogram_config& config)
{
    PyObject* pyDict = PyDict_New();

    int histogramLen = 256;
    CHECK_NULL(SetItemToDict(pyDict, "histogram_y_or_r", GetPyListFromArray(config.histogram_y_or_r, histogramLen)));
    CHECK_NULL(SetItemToDict(pyDict, "histogram_u_or_g", GetPyListFromArray(config.histogram_u_or_g, histogramLen)));
    CHECK_NULL(SetItemToDict(pyDict, "histogram_v_or_b", GetPyListFromArray(config.histogram_v_or_b, histogramLen)));

    return pyDict;
}

PyObject* WrapHiMpiVpcCalcHist(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pySourcePic = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;
    PyErr_WarnEx(
        PyExc_Warning,
        "acl.himpi.vpc_calc_hist will be deprecated. "
        "Please use acl.himpi.vpc_calc_hist_v2 instead.",
        0);
    CHECK_NULL(
        PyArg_ParseTuple(args, "iOi", &chn, &pySourcePic, &milliSec), "acl.himpi.vpc_calc_hist args parse failed!");

    hi_vpc_pic_info sourcePic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pySourcePic, sourcePic));

    hi_vpc_histogram_config histConfig{};

    PyObject* pyDict = GetPydictFromVpcHistogramConfig(histConfig);
    CHECK_NULL(pyDict != nullptr);
    const hi_s32 ret = 0;
    PyObject* obj = Py_BuildValue("OII", pyDict, taskId, ret);
    Py_XDECREF(pyDict);

    return obj;
}

PyObject* WrapHiMpiVpcCalcHistV2(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pySourcePic = nullptr;
    hi_vpc_histogram_config* histConfig = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOik", &chn, &pySourcePic, &milliSec, &histConfig),
        "acl.himpi.vpc_calc_hist_v2 args parse failed!");

    hi_vpc_pic_info sourcePic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pySourcePic, sourcePic));

    hi_s32 ret = hi_mpi_vpc_calc_hist(chn, &sourcePic, histConfig, &taskId, milliSec);
    PyObject* obj = Py_BuildValue("II", taskId, ret);

    return obj;
}

static bool GetVpcLutRemapFromPydict(PyObject* pyDict, hi_vpc_lut_remap& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vpc_lut_remap argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(
        pyDict, "map_value_y_or_r", info.map_value_y_or_r, sizeof(info.map_value_y_or_r) / sizeof(hi_u8)));
    CHECK_BOOL(GetValueFromPyDict(
        pyDict, "map_value_u_or_g", info.map_value_u_or_g, sizeof(info.map_value_u_or_g) / sizeof(hi_u8)));
    CHECK_BOOL(GetValueFromPyDict(
        pyDict, "map_value_v_or_b", info.map_value_v_or_b, sizeof(info.map_value_v_or_b) / sizeof(hi_u8)));

    return true;
}

PyObject* WrapHiMpiVpcEqualizeHist(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pySourcePic = nullptr;
    PyObject* pyDestPic = nullptr;
    PyObject* pyLutRemap = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOOOi", &chn, &pySourcePic, &pyDestPic, &pyLutRemap, &milliSec),
        "acl.himpi.vpc_equalize_hist args parse failed!");

    hi_vpc_pic_info sourcePic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pySourcePic, sourcePic));

    hi_vpc_pic_info destPic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pyDestPic, destPic));

    hi_vpc_lut_remap lutRemap{};
    CHECK_NULL(GetVpcLutRemapFromPydict(pyLutRemap, lutRemap));

    hi_s32 ret = hi_mpi_vpc_equalize_hist(chn, &sourcePic, &destPic, &lutRemap, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

PyObject* WrapHiMpiVpcGetProcessResult(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iIi", &chn, &taskId, &milliSec), "acl.himpi.vpc_get_process_result args parse failed!");

    hi_s32 ret = hi_mpi_vpc_get_process_result(chn, taskId, milliSec);
    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiVpcSysCreateChn(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chnl = 0;
    PyObject* pyDict = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "O", &pyDict), "acl.himpi.vpc_sys_create_chn args parse failed!");

    hi_vpc_chn_attr attr{};
    CHECK_NULL(GetVpcChnAttrFromPydict(pyDict, attr));

    hi_s32 ret = hi_mpi_vpc_sys_create_chn(&chnl, &attr);
    return Py_BuildValue("iI", chnl, ret);
}

static bool GetVpcCropResizeBorderRegionFromPydict(PyObject* pyDict, hi_vpc_crop_resize_border_region& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vpc_crop_resize_border_region argument is not dict");

    PyObject* pyPicInfo = PyDict_GetItemString(pyDict, "dest_pic_info");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pyPicInfo, info.dest_pic_info));

    PyObject* pyCropRegion = PyDict_GetItemString(pyDict, "crop_region");
    CHECK_BOOL(GetVpcCropRegionFromPydict(pyCropRegion, info.crop_region));

    PyObject* pyResizeInfo = PyDict_GetItemString(pyDict, "resize_info");
    CHECK_BOOL(GetVpcResizeInfoFromPydict(pyResizeInfo, info.resize_info));

    PyObject* pyScalarValue = PyDict_GetItemString(pyDict, "scalar_value");
    CHECK_BOOL(GetVpcScalarFromPydict(pyScalarValue, info.scalar_value));

    CHECK_BOOL(GetValueFromPyDict(pyDict, "dest_top_offset", info.dest_top_offset));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "dest_left_offset", info.dest_left_offset));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "border_type", info.border_type));

    return true;
}

PyObject* WrapHiMpiVpcCropResizeMakeBorder(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pySourcePic = nullptr;
    PyObject* pyCropInfos = nullptr;
    hi_u32 count = 0;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOOIi", &chn, &pySourcePic, &pyCropInfos, &count, &milliSec),
        "acl.himpi.vpc_crop_resize_make_border args parse failed!");

    hi_vpc_pic_info sourcePic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pySourcePic, sourcePic));

    CHECK_NULL(PyList_Check(pyCropInfos), "hi_vpc_crop_resize_border_region argument is not list");
    hi_u32 len = static_cast<hi_u32>(PyList_Size(pyCropInfos));
    CHECK_NULL(len == count, "the lenth of crop resize info is not equal with count!");
    std::vector<hi_vpc_crop_resize_border_region> cropInfos(count + 1);
    CHECK_NULL(
        ConvertPyListToStructArray(pyCropInfos, count, cropInfos.data(), GetVpcCropResizeBorderRegionFromPydict));

    hi_s32 ret = hi_mpi_vpc_crop_resize_make_border(chn, &sourcePic, cropInfos.data(), count, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

PyObject* WrapHiMpiVpcBatchCropResizePaste(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pySourcePics = nullptr;
    hi_u32 picNum = 0;
    PyObject* pyCropInfos = nullptr;
    PyObject* pyCounts = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOIOOi", &chn, &pySourcePics, &picNum, &pyCropInfos, &pyCounts, &milliSec),
        "acl.himpi.vpc_batch_crop_resize_paste args parse failed!");

    CHECK_NULL(PyList_Check(pySourcePics), "hi_vpc_pic_info argument is not list");
    int len = static_cast<int>(PyList_Size(pySourcePics));
    std::vector<hi_vpc_pic_info*> sourcePtr(len + 1, nullptr);
    std::vector<hi_vpc_pic_info> sourcePics(len + 1);
    CHECK_NULL(ConvertPyListToStructAddressArray(
        pySourcePics, len, sourcePics.data(), sourcePtr.data(), GetVpcPicInfoFromPydict));

    CHECK_NULL(PyList_Check(pyCropInfos), "hi_vpc_crop_resize_paste_region argument is not list");
    len = static_cast<int>(PyList_Size(pyCropInfos));
    std::vector<hi_vpc_crop_resize_paste_region> cropInfos(len + 1);
    CHECK_NULL(ConvertPyListToStructArray(pyCropInfos, len, cropInfos.data(), GetVpcCropResizePasteRegionFromPydict));

    CHECK_NULL(PyList_Check(pyCounts), "hi_u32 argument is not list");
    len = static_cast<int>(PyList_Size(pyCounts));
    std::vector<hi_u32> counts(len + 1);
    CHECK_NULL(ConvertPyListToLongArray(pyCounts, len, counts.data()));

    hi_s32 ret = hi_mpi_vpc_batch_crop_resize_paste(
        chn, const_cast<const hi_vpc_pic_info**>(sourcePtr.data()), picNum, cropInfos.data(), counts.data(), &taskId,
        milliSec);

    return Py_BuildValue("II", taskId, ret);
}

PyObject* WrapHiMpiVpcBatchCropResizeMakeBorder(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pySourcePics = nullptr;
    hi_u32 picNum = 0;
    PyObject* pyCropInfos = nullptr;
    PyObject* pyCounts = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOIOOi", &chn, &pySourcePics, &picNum, &pyCropInfos, &pyCounts, &milliSec),
        "acl.himpi.vpc_batch_crop_resize_make_border args parse failed!");

    CHECK_NULL(PyList_Check(pySourcePics), "hi_vpc_pic_info argument is not list");
    int len = static_cast<int>(PyList_Size(pySourcePics));
    std::vector<hi_vpc_pic_info*> sourcePtr(len + 1, nullptr);
    std::vector<hi_vpc_pic_info> sourcePics(len + 1);
    CHECK_NULL(ConvertPyListToStructAddressArray(
        pySourcePics, len, sourcePics.data(), sourcePtr.data(), GetVpcPicInfoFromPydict));

    CHECK_NULL(PyList_Check(pyCropInfos), "hi_vpc_crop_resize_border_region argument is not list");
    len = static_cast<int>(PyList_Size(pyCropInfos));
    std::vector<hi_vpc_crop_resize_border_region> cropInfos(len + 1);
    CHECK_NULL(ConvertPyListToStructArray(pyCropInfos, len, cropInfos.data(), GetVpcCropResizeBorderRegionFromPydict));

    CHECK_NULL(PyList_Check(pyCounts), "hi_u32 argument is not list");
    len = static_cast<int>(PyList_Size(pyCounts));
    std::vector<hi_u32> counts(len + 1);
    CHECK_NULL(ConvertPyListToLongArray(pyCounts, len, counts.data()));

    hi_s32 ret = hi_mpi_vpc_batch_crop_resize_make_border(
        chn, const_cast<const hi_vpc_pic_info**>(sourcePtr.data()), picNum, cropInfos.data(), counts.data(), &taskId,
        milliSec);

    return Py_BuildValue("II", taskId, ret);
}

static bool GetVpcCropResizeResizePasteRegionFromPydict(PyObject* pyDict, hi_vpc_crop_resize_resize_paste_region& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vpc_crop_resize_resize_paste_region argument is not dict");
    CHECK_BOOL(MemsetStructArgu(info));

    PyObject* pyPicInfo = PyDict_GetItemString(pyDict, "dest_pic_info");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pyPicInfo, info.dest_pic_info));

    PyObject* pyCropRegion = PyDict_GetItemString(pyDict, "crop_region");
    CHECK_BOOL(GetVpcCropRegionFromPydict(pyCropRegion, info.crop_region));

    PyObject* pyResizeInfo1 = PyDict_GetItemString(pyDict, "resize_info1");
    CHECK_BOOL(GetVpcResizeInfoFromPydict(pyResizeInfo1, info.resize_info1));

    PyObject* pyResizeInfo2 = PyDict_GetItemString(pyDict, "resize_info2");
    CHECK_BOOL(GetVpcResizeInfoFromPydict(pyResizeInfo2, info.resize_info2));

    CHECK_BOOL(GetValueFromPyDict(pyDict, "dest_top_offset", info.dest_top_offset));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "dest_left_offset", info.dest_left_offset));

    int reservedNum = 2;
    CHECK_BOOL(GetValueFromPyDict(pyDict, "reserved", info.reserved, reservedNum));

    return true;
}

PyObject* WrapHiMpiVpcCropResizeResizePaste(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pySourcePic = nullptr;
    PyObject* pyCropInfos = nullptr;
    hi_u32 count = 0;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOOii", &chn, &pySourcePic, &pyCropInfos, &count, &milliSec),
        "acl.himpi.vpc_crop_resize_resize_paste args parse failed!");

    hi_vpc_pic_info sourcePic{};
    CHECK_NULL(GetVpcPicInfoFromPydict(pySourcePic, sourcePic));

    CHECK_NULL(PyList_Check(pyCropInfos), "hi_vpc_crop_resize_resize_paste_region argument is not list");
    hi_u32 len = static_cast<hi_u32>(PyList_Size(pyCropInfos));
    CHECK_NULL(len == count, "the lenth of crop resize info is not equal with count!");
    std::vector<hi_vpc_crop_resize_resize_paste_region> cropInfos(count + 1);
    CHECK_NULL(
        ConvertPyListToStructArray(pyCropInfos, count, cropInfos.data(), GetVpcCropResizeResizePasteRegionFromPydict));

    hi_s32 ret = hi_mpi_vpc_crop_resize_resize_paste(chn, &sourcePic, cropInfos.data(), count, &taskId, milliSec);

    return Py_BuildValue("II", taskId, ret);
}

static bool GetSizeFromPydict(PyObject* pyDict, hi_size& size)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_size argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "width", size.width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "height", size.height));

    return true;
}

static bool GetPointFromPydict(PyObject* pyDict, hi_point& point)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_point argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "x", point.x));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "y", point.y));

    return true;
}

static bool GetBlurCfgFromPydict(PyObject* pyDict, hi_blur_config& config)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_blur_config argument is not dict");

    PyObject* pySize = PyDict_GetItemString(pyDict, "kernel_size");
    CHECK_BOOL(GetSizeFromPydict(pySize, config.kernel_size));

    PyObject* pyPoint = PyDict_GetItemString(pyDict, "anchor");
    CHECK_BOOL(GetPointFromPydict(pyPoint, config.anchor));

    PyObject* pyScalarValue = PyDict_GetItemString(pyDict, "scalar_value");
    CHECK_BOOL(GetVpcScalarFromPydict(pyScalarValue, config.scalar_value));

    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "morph_shapes", config.morph_shapes));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "iterations", config.iterations));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "border_type", config.border_type));

    return true;
}

static bool GetBlurParamFromPydict(PyObject* pyDict, hi_blur_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_blur_param argument is not dict");

    PyObject* pySrcInfo = PyDict_GetItemString(pyDict, "src");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pySrcInfo, param.src));

    PyObject* pyDstInfo = PyDict_GetItemString(pyDict, "dst");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pyDstInfo, param.dst));

    PyObject* pyBlurCfg = PyDict_GetItemString(pyDict, "blur_cfg");
    CHECK_BOOL(GetBlurCfgFromPydict(pyBlurCfg, param.blur_cfg));

    return true;
}

PyObject* WrapHiMpiVpcDilate(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pyBlurParam = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "iOi", &chn, &pyBlurParam, &milliSec), "acl.himpi.vpc_dilate args parse failed!");

    hi_blur_param blurParam{};
    CHECK_NULL(GetBlurParamFromPydict(pyBlurParam, blurParam));

    hi_s32 ret = hi_mpi_vpc_dilate(chn, &blurParam, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

PyObject* WrapHiMpiVpcBlur(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pyBlurParam = nullptr;
    hi_s32 milliSec = 0;
    hi_u32 taskId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "iOi", &chn, &pyBlurParam, &milliSec), "acl.himpi.vpc_blur args parse failed!");

    hi_blur_param blurParam{};
    CHECK_NULL(GetBlurParamFromPydict(pyBlurParam, blurParam));

    hi_s32 ret = hi_mpi_vpc_blur(chn, &blurParam, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

static bool GetVpcGaussianBlurConfig(PyObject* pyDict, hi_gaussian_blur_config& config)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_gaussian_blur_config argument is not dict");
    CHECK_BOOL(MemsetStructArgu(config));

    PyObject* pySize = PyDict_GetItemString(pyDict, "kernel_size");
    CHECK_BOOL(GetSizeFromPydict(pySize, config.kernel_size));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "sigma_x", config.sigma_x));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "sigma_y", config.sigma_y));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "border_type", config.border_type));

    PyObject* pyScalarValue = PyDict_GetItemString(pyDict, "scalar_value");
    CHECK_BOOL(GetVpcScalarFromPydict(pyScalarValue, config.scalar_value));

    hi_u32 length = sizeof(config.reserved) / sizeof(hi_u32);
    PyObject* pyReserved = PyDict_GetItemString(pyDict, "reserved");
    CHECK_BOOL(ConvertPyListToLongArray(pyReserved, length, config.reserved));
    return true;
}

static bool GetVpcGaussianBlurParam(PyObject* pyDict, hi_gaussian_blur_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_gaussian_blur_param argument is not dict");
    PyObject* pySrcInfo = PyDict_GetItemString(pyDict, "src");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pySrcInfo, param.src));

    PyObject* pyDstInfo = PyDict_GetItemString(pyDict, "dst");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pyDstInfo, param.dst));

    PyObject* pyGaussianBlurCfg = PyDict_GetItemString(pyDict, "gaussian_blur_cfg");
    CHECK_BOOL(GetVpcGaussianBlurConfig(pyGaussianBlurCfg, param.gaussian_blur_cfg));
    return true;
}

PyObject* WrapHiMpiVpcGaussianBlur(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pyGaussianBlurParam = nullptr;
    hi_s32 milliSec = 0;
    hi_u32 taskId = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOi", &chn, &pyGaussianBlurParam, &milliSec),
        "acl.himpi.vpc_gaussian_blur args parse failed!");

    hi_gaussian_blur_param gaussianBlurParam{};
    CHECK_NULL(GetVpcGaussianBlurParam(pyGaussianBlurParam, gaussianBlurParam));

    hi_s32 ret = hi_mpi_vpc_gaussian_blur(chn, &gaussianBlurParam, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

static bool GetRectFromPydict(PyObject* pyDict, hi_rect& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_rect argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "x", param.x));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "y", param.y));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "width", param.width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "height", param.height));

    return true;
}

static bool GetQuadCoverFromPydict(PyObject* pyDict, hi_quad_cover& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_quad_cover argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "is_solid", param.is_solid));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "thick", param.thick));

    int len = 4;
    PyObject* pyPoint = PyDict_GetItemString(pyDict, "point");
    CHECK_BOOL(ConvertPyListToStructArray(pyPoint, len, param.point, GetPointFromPydict));

    return true;
}

static bool GetCoverFromPydict(PyObject* pyDict, hi_cover& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_cover argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "type", param.type));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "color", param.color));

    if (param.type == HI_COVER_RECT) {
        PyObject* pyRect = PyDict_GetItemString(pyDict, "rect");
        CHECK_BOOL(GetRectFromPydict(pyRect, param.rect));
    } else if (param.type == HI_COVER_QUAD) {
        PyObject* pyQuad = PyDict_GetItemString(pyDict, "quad");
        CHECK_BOOL(GetQuadCoverFromPydict(pyQuad, param.quad));
    }

    return true;
}

static bool GetCoverParamFromPydict(PyObject* pyDict, hi_cover_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_cover_param argument is not dict");

    PyObject* pySrcInfo = PyDict_GetItemString(pyDict, "src");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pySrcInfo, param.src));

    PyObject* pyDstInfo = PyDict_GetItemString(pyDict, "dst");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pyDstInfo, param.dst));

    PyObject* pyCover = PyDict_GetItemString(pyDict, "cover");
    CHECK_BOOL(PyList_Check(pyCover));
    hi_u32 len = static_cast<hi_u32>(PyList_Size(pyCover));
    CHECK_BOOL(len == param.count, "count is not equal with the length of cover");
    CHECK_BOOL(ConvertPyListToStructArray(pyCover, len, param.cover, GetCoverFromPydict));

    return true;
}

PyObject* WrapHiMpiVpcDrawCover(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pyCoverParam = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOi", &chn, &pyCoverParam, &milliSec), "acl.himpi.vpc_draw_cover args parse failed!");

    hi_cover_param coverParam{};
    // 获取coverParam.count长度并进行校验
    CHECK_NULL(GetValueFromPyDict(pyCoverParam, "count", coverParam.count));
    const size_t minLimit = 1;
    const size_t maxLimit = 100;
    CHECK_NULL(coverParam.count <= maxLimit && coverParam.count >= minLimit, "invalid count of coverParam");
    // 对coverParam.cover指针进行堆内存分配以及初始化
    const size_t len = coverParam.count * sizeof(hi_cover);
    coverParam.cover = (hi_cover*)malloc(len);
    CHECK_NULL(coverParam.cover != nullptr, "hi_cover malloc failed!");
    (void)memset_s(coverParam.cover, len, 0, len);
    // 对参数进行解析处理，解析失败则释放内存
    if (!GetCoverParamFromPydict(pyCoverParam, coverParam)) {
        free(coverParam.cover);
        coverParam.cover = nullptr;
        return nullptr;
    }

    hi_s32 ret = hi_mpi_vpc_draw_cover(chn, &coverParam, &taskId, milliSec);
    free(coverParam.cover);
    coverParam.cover = nullptr;
    return Py_BuildValue("II", taskId, ret);
}

static bool GetLineFromPydict(PyObject* pyDict, hi_line& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_line argument is not dict");

    PyObject* pyStart = PyDict_GetItemString(pyDict, "start_point");
    CHECK_BOOL(GetPointFromPydict(pyStart, param.start_point));

    PyObject* pyEnd = PyDict_GetItemString(pyDict, "end_point");
    CHECK_BOOL(GetPointFromPydict(pyEnd, param.end_point));

    CHECK_BOOL(GetValueFromPyDict(pyDict, "thick", param.thick));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "color", param.color));

    return true;
}

static bool GetLineParamFromPydict(PyObject* pyDict, hi_line_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_line_param argument is not dict");

    PyObject* pySrcInfo = PyDict_GetItemString(pyDict, "src");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pySrcInfo, param.src));

    PyObject* pyDstInfo = PyDict_GetItemString(pyDict, "dst");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pyDstInfo, param.dst));

    PyObject* pyLine = PyDict_GetItemString(pyDict, "line");
    CHECK_BOOL(PyList_Check(pyLine));
    hi_u32 len = static_cast<hi_u32>(PyList_Size(pyLine));
    CHECK_BOOL(len == param.count, "count is not equal with the length of line");
    CHECK_BOOL(ConvertPyListToStructArray(pyLine, len, param.line, GetLineFromPydict));

    return true;
}

PyObject* WrapHiMpiVpcDrawLine(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pyLineParam = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOi", &chn, &pyLineParam, &milliSec), "acl.himpi.vpc_draw_line args parse failed!");

    hi_line_param lineParam{};
    // 获取lineParam.line长度并进行校验
    CHECK_NULL(GetValueFromPyDict(pyLineParam, "count", lineParam.count));
    const size_t minLimit = 1;
    const size_t maxLimit = 100;
    CHECK_NULL(lineParam.count <= maxLimit && lineParam.count >= minLimit, "invalid count of lineParam");
    // 对lineParam.line指针进行堆内存分配以及初始化
    const size_t len = lineParam.count * sizeof(hi_line);
    lineParam.line = (hi_line*)malloc(len);
    CHECK_NULL(lineParam.line != nullptr, "hi_line malloc failed!");
    (void)memset_s(lineParam.line, len, 0, len);
    // 对参数进行解析处理，解析失败则释放内存
    if (!GetLineParamFromPydict(pyLineParam, lineParam)) {
        free(lineParam.line);
        lineParam.line = nullptr;
        return nullptr;
    }

    hi_s32 ret = hi_mpi_vpc_draw_line(chn, &lineParam, &taskId, milliSec);
    free(lineParam.line);
    lineParam.line = nullptr;
    return Py_BuildValue("II", taskId, ret);
}

static bool GetMosaicFromPydict(PyObject* pyDict, hi_mosaic& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_mosaic argument is not dict");

    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "blk_size", param.blk_size));

    PyObject* pyRect = PyDict_GetItemString(pyDict, "rect");
    CHECK_BOOL(GetRectFromPydict(pyRect, param.rect));

    return true;
}

static bool GetMosaicParamFromPydict(PyObject* pyDict, hi_mosaic_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_mosaic_param argument is not dict");

    PyObject* pySrcInfo = PyDict_GetItemString(pyDict, "src");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pySrcInfo, param.src));

    PyObject* pyDstInfo = PyDict_GetItemString(pyDict, "dst");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pyDstInfo, param.dst));

    PyObject* pyMosaic = PyDict_GetItemString(pyDict, "mosaic");
    CHECK_BOOL(PyList_Check(pyMosaic));
    const hi_u32 len = static_cast<hi_u32>(PyList_Size(pyMosaic));
    CHECK_BOOL(len == param.count, "count is not equal with the length of mosaic");
    CHECK_BOOL(ConvertPyListToStructArray(pyMosaic, len, param.mosaic, GetMosaicFromPydict));

    return true;
}

PyObject* WrapHiMpiVpcDrawMosaic(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pyMosaicParam = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOi", &chn, &pyMosaicParam, &milliSec), "acl.himpi.vpc_draw_mosaic args parse failed!");

    hi_mosaic_param mosaicParam{};
    // 获取mosaicParam.mosaic长度并进行校验
    CHECK_NULL(GetValueFromPyDict(pyMosaicParam, "count", mosaicParam.count));
    const size_t minLimit = 1;
    const size_t maxLimit = 100;
    CHECK_NULL(mosaicParam.count <= maxLimit && mosaicParam.count >= minLimit, "invalid count of mosaicParam");
    // 对mosaicParam.mosaic指针进行堆内存分配以及初始化
    const size_t len = mosaicParam.count * sizeof(hi_mosaic);
    mosaicParam.mosaic = (hi_mosaic*)malloc(len);
    CHECK_NULL(mosaicParam.mosaic != nullptr, "hi_mosaic malloc failed!");
    (void)memset_s(mosaicParam.mosaic, len, 0, len);
    // 对参数进行解析处理，解析失败则释放内存
    if (!GetMosaicParamFromPydict(pyMosaicParam, mosaicParam)) {
        free(mosaicParam.mosaic);
        mosaicParam.mosaic = nullptr;
        return nullptr;
    }

    hi_s32 ret = hi_mpi_vpc_draw_mosaic(chn, &mosaicParam, &taskId, milliSec);
    free(mosaicParam.mosaic);
    mosaicParam.mosaic = nullptr;
    return Py_BuildValue("II", taskId, ret);
}

static bool GetOsdFromPydict(PyObject* pyDict, hi_osd& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_osd argument is not dict");

    PyObject* pyRect = PyDict_GetItemString(pyDict, "rect");
    CHECK_BOOL(GetRectFromPydict(pyRect, param.rect));

    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "pixel_format", param.pixel_format));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "picture_address", param.picture_address));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "stride", param.stride));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "bg_alpha", param.bg_alpha));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "fg_alpha", param.fg_alpha));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "osd_inverted_color", param.osd_inverted_color));

    return true;
}

static bool GetOsdParamFromPydict(PyObject* pyDict, hi_osd_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_osd_param argument is not dict");

    PyObject* pySrcInfo = PyDict_GetItemString(pyDict, "src");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pySrcInfo, param.src));

    PyObject* pyDstInfo = PyDict_GetItemString(pyDict, "dst");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pyDstInfo, param.dst));

    const int len = 16;
    PyObject* pyClut = PyDict_GetItemString(pyDict, "clut");
    CHECK_BOOL(ConvertPyListToLongArray(pyClut, len, param.clut));

    PyObject* pyOsd = PyDict_GetItemString(pyDict, "osd");
    CHECK_BOOL(PyList_Check(pyOsd));
    const hi_u32 osdLen = static_cast<hi_u32>(PyList_Size(pyOsd));
    CHECK_BOOL(osdLen == param.count, "count is not equal with the length of osd");
    CHECK_BOOL(ConvertPyListToStructArray(pyOsd, osdLen, param.osd, GetOsdFromPydict));

    return true;
}

PyObject* WrapHiMpiVpcDrawOsd(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pyOsdParam = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOi", &chn, &pyOsdParam, &milliSec), "acl.himpi.vpc_draw_osd args parse failed!");

    hi_osd_param osdParam{};
    // 获取osdParam.osd长度并进行校验
    CHECK_NULL(GetValueFromPyDict(pyOsdParam, "count", osdParam.count));
    const size_t minLimit = 1;
    const size_t maxLimit = 100;
    CHECK_NULL(osdParam.count <= maxLimit && osdParam.count >= minLimit, "invalid count of osdParam");
    // 对osdParam.osd指针进行堆内存分配以及初始化
    const size_t len = osdParam.count * sizeof(hi_osd);
    osdParam.osd = (hi_osd*)malloc(len);
    CHECK_NULL(osdParam.osd != nullptr, "hi_osd malloc failed!");
    (void)memset_s(osdParam.osd, len, 0, len);
    // 对参数进行解析处理，解析失败则释放内存
    if (!GetOsdParamFromPydict(pyOsdParam, osdParam)) {
        free(osdParam.osd);
        osdParam.osd = nullptr;
        return nullptr;
    }

    hi_s32 ret = hi_mpi_vpc_draw_osd(chn, &osdParam, &taskId, milliSec);
    free(osdParam.osd);
    osdParam.osd = nullptr;
    return Py_BuildValue("II", taskId, ret);
}

PyObject* WrapHiMpiVpcErode(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pyBlurParam = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "iOi", &chn, &pyBlurParam, &milliSec), "acl.himpi.vpc_erode args parse failed!");

    hi_blur_param blurParam{};
    CHECK_NULL(GetBlurParamFromPydict(pyBlurParam, blurParam));

    hi_s32 ret = hi_mpi_vpc_erode(chn, &blurParam, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

static bool GetFilter2dConfigFromPydict(PyObject* pyDict, hi_filter_2d_config& config)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_filter_2d_config argument is not dict");
    CHECK_BOOL(MemsetStructArgu(config));

    PyObject* pySize = PyDict_GetItemString(pyDict, "kernel_size");
    CHECK_BOOL(GetSizeFromPydict(pySize, config.kernel_size));
    const size_t maxSize = 5;
    // width必须为 1, 3, 5<=>小于5的奇数,整除2余数为1
    CHECK_BOOL(
        config.kernel_size.width <= maxSize and config.kernel_size.width % 2 == 1,
        "the width of filter is not in [1 ,3, 5]!");
    // height必须为 1, 3, 5<=>小于5的奇数,整除2余数为1
    CHECK_BOOL(
        config.kernel_size.height <= maxSize and config.kernel_size.height % 2 == 1,
        "the height of filter is not in [1 ,3, 5]!");
    PyObject* pyFilter = PyDict_GetItemString(pyDict, "filter");
    CHECK_BOOL(PyList_Check(pyFilter));
    hi_u32 height = static_cast<hi_u32>(PyList_Size(pyFilter));
    CHECK_BOOL(config.kernel_size.height == height, "the width of filter is not equal with kernel_size!");

    hi_u32 width = static_cast<hi_u32>(PyList_Size(PyList_GetItem(pyFilter, 0)));
    CHECK_BOOL(config.kernel_size.width == width, "the height of filter is not equal with kernel_size!");

    std::vector<hi_double> filter(width * height);
    CHECK_BOOL(ConvertPyListToDoubleArrayV2(pyFilter, height, width, filter));
    // 居中填充filter
    const size_t x = maxSize / 2 - width / 2;
    const size_t y = maxSize / 2 - height / 2;
    for (size_t yOffset = 0; yOffset < height; yOffset++) {
        for (size_t xOffset = 0; xOffset < width; xOffset++) {
            config.filter[y + yOffset][x + xOffset] = filter[width * yOffset + xOffset];
        }
    }
    PyObject* pyPoint = PyDict_GetItemString(pyDict, "anchor");
    CHECK_BOOL(GetPointFromPydict(pyPoint, config.anchor));

    PyObject* pyScalarValue = PyDict_GetItemString(pyDict, "scalar_value");
    CHECK_BOOL(GetVpcScalarFromPydict(pyScalarValue, config.scalar_value));

    CHECK_BOOL(GetValueFromPyDict(pyDict, "delta", config.delta));
    hi_u32 reserveLen = sizeof(config.reserved) / sizeof(hi_u32);
    CHECK_BOOL(GetValueFromPyDict(pyDict, "reserved", config.reserved, reserveLen));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "border_type", config.border_type));

    return true;
}

static bool GetFilterParamFromPydict(PyObject* pyDict, hi_filter_2d_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_filter_2d_param argument is not dict");

    PyObject* pySrcInfo = PyDict_GetItemString(pyDict, "src");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pySrcInfo, param.src));

    PyObject* pyDstInfo = PyDict_GetItemString(pyDict, "dst");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pyDstInfo, param.dst));

    PyObject* pyCfg = PyDict_GetItemString(pyDict, "filter_2d_cfg");
    CHECK_BOOL(GetFilter2dConfigFromPydict(pyCfg, param.filter_2d_cfg));

    return true;
}

PyObject* WrapHiMpiVpcFilter2d(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pyFilterParam = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOi", &chn, &pyFilterParam, &milliSec), "acl.himpi.vpc_filter2d args parse failed!");

    hi_filter_2d_param filterParam{};
    CHECK_NULL(GetFilterParamFromPydict(pyFilterParam, filterParam));

    hi_s32 ret = hi_mpi_vpc_filter2d(chn, &filterParam, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

static bool GetFlipParamFromPydict(PyObject* pyDict, hi_flip_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_flip_param argument is not dict");

    PyObject* pySrcInfo = PyDict_GetItemString(pyDict, "src");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pySrcInfo, param.src));

    PyObject* pyDstInfo = PyDict_GetItemString(pyDict, "dst");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pyDstInfo, param.dst));

    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "flip_mode", param.flip_mode));
    return true;
}

PyObject* WrapHiMpiVpcFlip(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pyFlipParam = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "iOi", &chn, &pyFlipParam, &milliSec), "acl.himpi.vpc_flip args parse failed!");

    hi_flip_param flipParam{};
    CHECK_NULL(GetFlipParamFromPydict(pyFlipParam, flipParam));

    hi_s32 ret = hi_mpi_vpc_flip(chn, &flipParam, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

static bool GetFloatPointFromPydict(PyObject* pyDict, hi_float_point& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_float_point argument is not dict");

    CHECK_BOOL(GetValueFromPyDict(pyDict, "x", param.x));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "y", param.y));
    return true;
}

static bool GetPointPairInfoFromPydict(PyObject* pyDict, hi_point_pair_info& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_point_pair_info argument is not dict");

    CHECK_BOOL(GetValueFromPyDict(pyDict, "src_point_count", info.src_point_count));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "dest_point_count", info.dest_point_count));

    const int len = 4;
    CHECK_BOOL(info.src_point_count <= len, "src_point_count is invalid");
    CHECK_BOOL(info.dest_point_count <= len, "dest_point_count is invalid");

    PyObject* pySrcPonit = PyDict_GetItemString(pyDict, "src_point");
    CHECK_BOOL(PyList_Check(pySrcPonit), "src_point is not list");
    CHECK_BOOL(
        PyList_Size(pySrcPonit) == info.src_point_count, "the length of src_point is not equal with src_point_count");
    CHECK_BOOL(ConvertPyListToStructArray(pySrcPonit, info.src_point_count, info.src_point, GetFloatPointFromPydict));

    PyObject* pyDestPonit = PyDict_GetItemString(pyDict, "dest_point");
    CHECK_BOOL(PyList_Check(pyDestPonit), "dest_point is not list");
    CHECK_BOOL(
        PyList_Size(pyDestPonit) == info.dest_point_count,
        "the length of dest_point is not equal with dest_point_count");
    CHECK_BOOL(
        ConvertPyListToStructArray(pyDestPonit, info.dest_point_count, info.dest_point, GetFloatPointFromPydict));

    return true;
}

static bool GetRemapLutFromPydict(PyObject* pyDict, hi_remap_lut& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_remap_lut argument is not dict");
    CHECK_BOOL(MemsetStructArgu(param));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "src_pic_width", param.src_pic_width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "src_pic_height", param.src_pic_height));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "dest_pic_width", param.dest_pic_width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "dest_pic_height", param.dest_pic_height));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "lut", param.lut));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "lut_size", param.lut_size));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "reserved", param.reserved));
    return true;
}

static PyObject* GetPydictFromRemapLut(hi_remap_lut& info)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(SetItemToDict(pyDict, "src_pic_width", Py_BuildValue("I", info.src_pic_width)));
    CHECK_NULL(SetItemToDict(pyDict, "src_pic_height", Py_BuildValue("I", info.src_pic_height)));
    CHECK_NULL(SetItemToDict(pyDict, "dest_pic_width", Py_BuildValue("I", info.dest_pic_width)));
    CHECK_NULL(SetItemToDict(pyDict, "dest_pic_height", Py_BuildValue("I", info.dest_pic_height)));
    CHECK_NULL(SetItemToDict(pyDict, "lut", Py_BuildValue("k", info.lut)));
    CHECK_NULL(SetItemToDict(pyDict, "lut_size", Py_BuildValue("I", info.lut_size)));
    CHECK_NULL(SetItemToDict(pyDict, "reserved", Py_BuildValue("k", info.reserved)));

    return pyDict;
}

PyObject* WrapHiMpiVpcGetAffineLut(PyObject* /* self */, PyObject* args)
{
    PyObject* pyInfo = nullptr;
    hi_u32 interpolation = 0;
    PyObject* pyLut = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "OIO", &pyInfo, &interpolation, &pyLut),
        "acl.himpi.vpc_get_affine_lut args parse failed!");

    hi_point_pair_info info{};
    CHECK_NULL(GetPointPairInfoFromPydict(pyInfo, info));

    hi_remap_lut lut{};
    CHECK_NULL(GetRemapLutFromPydict(pyLut, lut));

    hi_s32 ret = hi_mpi_vpc_get_affine_lut(&info, interpolation, &lut);
    PyObject* pyDict = GetPydictFromRemapLut(lut);
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyDict, ret);
    Py_XDECREF(pyDict);

    return obj;
}

PyObject* WrapHiMpiVpcGetLutMemSize(PyObject* /* self */, PyObject* args)
{
    hi_u32 width = 0;
    hi_u32 height = 0;
    hi_u32 lutSize = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "II", &width, &height), "acl.himpi.vpc_get_lut_mem_size args parse failed!");

    hi_s32 ret = hi_mpi_vpc_get_lut_mem_size(width, height, &lutSize);
    return Py_BuildValue("II", lutSize, ret);
}

static PyObject* GetPydictFromTransformMatrix(hi_transform_matrix& info)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(SetItemToDict(pyDict, "matrix_type", Py_BuildValue("I", info.matrix_type)));
    int row = 3;
    int col = 4;
    CHECK_NULL(SetItemToDict(pyDict, "matrix", GetPyListFromArray(info.matrix, row, col)));

    return pyDict;
}

PyObject* WrapHiMpiVpcGetAffineTransform(PyObject* /* self */, PyObject* args)
{
    PyObject* pyInfo = nullptr;
    hi_transform_matrix matrix{};

    CHECK_NULL(PyArg_ParseTuple(args, "O", &pyInfo), "acl.himpi.vpc_get_affine_transform args parse failed!");

    hi_point_pair_info info{};
    CHECK_NULL(GetPointPairInfoFromPydict(pyInfo, info));

    hi_s32 ret = hi_mpi_vpc_get_affine_transform(&info, &matrix);
    PyObject* pyDict = GetPydictFromTransformMatrix(matrix);
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyDict, ret);
    Py_XDECREF(pyDict);

    return obj;
}

PyObject* WrapHiMpiVpcGetPerspectiveLut(PyObject* /* self */, PyObject* args)
{
    PyObject* pyInfo = nullptr;
    hi_u32 interpolation = 0;
    PyObject* pyLut = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "OIO", &pyInfo, &interpolation, &pyLut),
        "acl.himpi.vpc_get_perspective_lut args parse failed!");

    hi_point_pair_info info{};
    CHECK_NULL(GetPointPairInfoFromPydict(pyInfo, info));

    hi_remap_lut lut{};
    CHECK_NULL(GetRemapLutFromPydict(pyLut, lut));

    hi_s32 ret = hi_mpi_vpc_get_perspective_lut(&info, interpolation, &lut);
    PyObject* pyDict = GetPydictFromRemapLut(lut);
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyDict, ret);
    Py_XDECREF(pyDict);

    return obj;
}

static bool GetMapParamFromPydict(PyObject* pyDict, hi_map_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_map_param argument is not dict");

    CHECK_BOOL(GetValueFromPyDict(pyDict, "map1", param.map1));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "map2", param.map2));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "map_size", param.map_size));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "src_pic_width", param.src_pic_width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "src_pic_height", param.src_pic_height));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "dest_pic_width", param.dest_pic_width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "dest_pic_height", param.dest_pic_height));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "reserved", param.reserved));
    return true;
}

PyObject* WrapHiMpiVpcGetRemapLut(PyObject* /* self */, PyObject* args)
{
    PyObject* pyParam = nullptr;
    PyObject* pyLut = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "OO", &pyParam, &pyLut), "acl.himpi.vpc_get_remap_lut args parse failed!");

    hi_map_param param{};
    CHECK_NULL(GetMapParamFromPydict(pyParam, param));

    hi_remap_lut lut{};
    CHECK_NULL(GetRemapLutFromPydict(pyLut, lut));

    hi_s32 ret = hi_mpi_vpc_get_remap_lut(&param, &lut);
    PyObject* pyDict = GetPydictFromRemapLut(lut);
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyDict, ret);
    Py_XDECREF(pyDict);

    return obj;
}

PyObject* WrapHiMpiVpcGetRotationMatrix(PyObject* /* self */, PyObject* args)
{
    PyObject* pyPoint = nullptr;
    hi_double angle = 0;
    hi_double scale = 0;
    hi_transform_matrix matrix{};

    CHECK_NULL(
        PyArg_ParseTuple(args, "Odd", &pyPoint, &angle, &scale),
        "acl.himpi.vpc_get_rotation_matrix args parse failed!");

    hi_float_point centerPoint{};
    CHECK_NULL(GetFloatPointFromPydict(pyPoint, centerPoint));

    hi_s32 ret = hi_mpi_vpc_get_rotation_matrix(centerPoint, angle, scale, &matrix);
    PyObject* pyDict = GetPydictFromTransformMatrix(matrix);
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyDict, ret);
    Py_XDECREF(pyDict);

    return obj;
}

static bool GetTransformConfigFromPydict(PyObject* pyDict, hi_transform_config& config)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_transform_config argument is not dict");

    CHECK_BOOL(GetValueFromPyDict(pyDict, "interpolation", config.interpolation));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "border_type", config.border_type));

    PyObject* pyScalarValue = PyDict_GetItemString(pyDict, "scalar_value");
    CHECK_BOOL(GetVpcScalarFromPydict(pyScalarValue, config.scalar_value));

    return true;
}

static bool GetWarpTransformParamFromPydict(PyObject* pyDict, hi_warp_transform_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_warp_transform_param argument is not dict");

    PyObject* pySrcInfo = PyDict_GetItemString(pyDict, "src");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pySrcInfo, param.src));

    PyObject* pyDstInfo = PyDict_GetItemString(pyDict, "dst");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pyDstInfo, param.dst));

    PyObject* pyConfig = PyDict_GetItemString(pyDict, "transform_config");
    CHECK_BOOL(GetTransformConfigFromPydict(pyConfig, param.transform_config));

    return true;
}

PyObject* WrapHiMpiVpcLutRemap(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pyParam = nullptr;
    PyObject* pyLut = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOOi", &chn, &pyParam, &pyLut, &milliSec),
        "acl.himpi.vpc_lut_remap args parse failed!");

    hi_warp_transform_param transformParam{};
    CHECK_NULL(GetWarpTransformParamFromPydict(pyParam, transformParam));

    hi_remap_lut lut{};
    CHECK_NULL(GetRemapLutFromPydict(pyLut, lut));

    hi_s32 ret = hi_mpi_vpc_lut_remap(chn, &transformParam, &lut, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

static bool GetVpcWorkspaceParamFromPydict(PyObject* pyDict, hi_vpc_workspace_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vpc_workspace_param argument is not dict");
    CHECK_BOOL(MemsetStructArgu(param));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "func", param.func));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_source_pic_width", param.max_source_pic_width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_source_pic_height", param.max_source_pic_height));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_dest_pic_width", param.max_dest_pic_width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_dest_pic_height", param.max_dest_pic_height));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "reserved", param.reserved));
    return true;
}

PyObject* WrapHiMpiVpcSetChnWorkspace(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pyParam = nullptr;
    hi_u32 paramCnt = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOI", &chn, &pyParam, &paramCnt), "acl.himpi.vpc_set_chn_workspace args parse failed!");

    CHECK_NULL(PyList_Check(pyParam), "hi_vpc_workspace_param argument is not list");
    hi_u32 len = static_cast<hi_u32>(PyList_Size(pyParam));
    CHECK_NULL(len == paramCnt, "the lenth of crop info is not equal with count!");
    std::vector<hi_vpc_workspace_param> params(paramCnt + 1);
    CHECK_NULL(ConvertPyListToStructArray(pyParam, paramCnt, params.data(), GetVpcWorkspaceParamFromPydict));

    hi_s32 ret = hi_mpi_vpc_set_chn_workspace(chn, params.data(), paramCnt);
    return Py_BuildValue("I", ret);
}

static bool GetMedianBlurConfigFromPydict(PyObject* pyDict, hi_median_blur_config& config)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_median_blur_config argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "kernel_size", config.kernel_size));
    return true;
}

static bool GetMedianBlurParamFromPydict(PyObject* pyDict, hi_median_blur_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_median_blur_param argument is not dict");

    PyObject* pySrcInfo = PyDict_GetItemString(pyDict, "src");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pySrcInfo, param.src));

    PyObject* pyDstInfo = PyDict_GetItemString(pyDict, "dst");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pyDstInfo, param.dst));

    PyObject* pyConfig = PyDict_GetItemString(pyDict, "median_blur_cfg");
    CHECK_BOOL(GetMedianBlurConfigFromPydict(pyConfig, param.median_blur_cfg));

    return true;
}

PyObject* WrapHiMpiVpcMedianBlur(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pyParam = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOi", &chn, &pyParam, &milliSec), "acl.himpi.vpc_median_blur args parse failed!");

    hi_median_blur_param param{};
    GetMedianBlurParamFromPydict(pyParam, param);

    hi_s32 ret = hi_mpi_vpc_median_blur(chn, &param, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

static bool GetRotateParamFromPydict(PyObject* pyDict, hi_rotate_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_rotate_param argument is not dict");

    PyObject* pySrcInfo = PyDict_GetItemString(pyDict, "src");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pySrcInfo, param.src));

    PyObject* pyDstInfo = PyDict_GetItemString(pyDict, "dst");
    CHECK_BOOL(GetVpcPicInfoFromPydict(pyDstInfo, param.dst));

    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "angle", param.angle));
    return true;
}

PyObject* WrapHiMpiVpcRotate(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pyParam = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "iOi", &chn, &pyParam, &milliSec), "acl.himpi.vpc_rotate args parse failed!");

    hi_rotate_param param{};
    GetRotateParamFromPydict(pyParam, param);

    hi_s32 ret = hi_mpi_vpc_rotate(chn, &param, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

static bool GetTransformMatrixFromPydict(PyObject* pyDict, hi_transform_matrix& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_transform_matrix argument is not dict");

    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "matrix_type", param.matrix_type));
    int col = 3;
    int row = 4;
    PyObject* pyMatrix = PyDict_GetItemString(pyDict, "matrix");
    CHECK_BOOL(PyList_Check(pyMatrix));
    std::vector<hi_float> matrix(col * row);
    CHECK_BOOL(ConvertPyListToDoubleArrayV2(pyMatrix, col, row, matrix));
    errno_t sRet = memcpy_s(param.matrix, sizeof(param.matrix), matrix.data(), sizeof(param.matrix));
    CHECK_BOOL(sRet == EOK);
    return true;
}

PyObject* WrapHiMpiVpcWarpAffine(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pyMatrix = nullptr;
    PyObject* pyParam = nullptr;
    hi_u32 taskId = 0;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOOi", &chn, &pyMatrix, &pyParam, &milliSec),
        "acl.himpi.vpc_warp_affine args parse failed!");

    hi_transform_matrix matrix{};
    CHECK_NULL(GetTransformMatrixFromPydict(pyMatrix, matrix));

    hi_warp_transform_param transformParam{};
    CHECK_NULL(GetWarpTransformParamFromPydict(pyParam, transformParam));

    hi_s32 ret = hi_mpi_vpc_warp_affine(chn, &matrix, &transformParam, &taskId, milliSec);
    return Py_BuildValue("II", taskId, ret);
}

static bool GetOptAttrFromPydict(PyObject* pyDict, hi_opt_attr& attr)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_opt_attr argument is not dict");

    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "attr_type", attr.attr_type));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "len", attr.len));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "value", attr.value));
    return true;
}

PyObject* WrapHiMpiVpcSetChnOptAttr(PyObject* /* self */, PyObject* args)
{
    hi_vpc_chn chn = 0;
    PyObject* pyOptAttr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyOptAttr), "acl.himpi.vpc_set_chn_opt_attr args parse failed!");

    hi_opt_attr optAttr{};
    GetOptAttrFromPydict(pyOptAttr, optAttr);

    hi_s32 ret = hi_mpi_vpc_set_chn_opt_attr(chn, &optAttr);
    return Py_BuildValue("I", ret);
}