/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "himpi_common.h"
#include "acl/dvpp/hi_dvpp_sys.h"

PyObject* WrapHiMpiSysInit(PyObject* /* self */, PyObject* /* args */)
{
    hi_s32 ret = hi_mpi_sys_init();
    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiSysExit(PyObject* /* self */, PyObject* /* args */)
{
    hi_s32 ret = hi_mpi_sys_exit();
    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiDvppMalloc(PyObject* /* self */, PyObject* args)
{
    hi_s32 devId = 0;
    hi_u64 size = 0;
    hi_void* devPtr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "ik", &devId, &size), "acl.himpi.dvpp_malloc args parse failed!");

    hi_s32 ret = hi_mpi_dvpp_malloc(devId, &devPtr, size);
    return Py_BuildValue("kI", devPtr, ret);
}

PyObject* WrapHiMpiDvppFree(PyObject* /* self */, PyObject* args)
{
    hi_void* devPtr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &devPtr), "acl.himpi.dvpp_free args parse failed!");

    hi_s32 ret = hi_mpi_dvpp_free(devPtr);
    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiDvppGetVersion(PyObject* /* self */, PyObject* /* args */)
{
    hi_s32 majorVersion = 0;
    hi_s32 minorVersion = 0;
    hi_s32 patchVersion = 0;

    hi_s32 ret = hi_mpi_dvpp_get_version(&majorVersion, &minorVersion, &patchVersion);
    return Py_BuildValue("iiiI", majorVersion, minorVersion, patchVersion, ret);
}

PyObject* WrapHiMpiSysCreateEpoll(PyObject* /* self */, PyObject* args)
{
    hi_s32 size = 0;
    hi_s32 epollFd = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &size), "acl.himpi.sys_create_epoll args parse failed!");

    hi_s32 ret = hi_mpi_sys_create_epoll(size, &epollFd);
    return Py_BuildValue("iI", epollFd, ret);
}

static bool GetDvppEpollEventFromPydict(PyObject* pyDict, hi_dvpp_epoll_event& event)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_dvpp_epoll_event argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "events", event.events));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "data", event.data));

    return true;
}

PyObject* WrapHiMpiSysCtlEpoll(PyObject* /* self */, PyObject* args)
{
    hi_s32 epollFd = 0;
    hi_s32 operation = 0;
    hi_s32 fd = 0;
    PyObject* pyEvent = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iiiO", &epollFd, &operation, &fd, &pyEvent),
        "acl.himpi.sys_ctl_epoll args parse failed!");

    hi_dvpp_epoll_event event{};
    CHECK_NULL(GetDvppEpollEventFromPydict(pyEvent, event));

    hi_s32 ret = hi_mpi_sys_ctl_epoll(epollFd, operation, fd, &event);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromDvppEpollEvent(hi_dvpp_epoll_event& event)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "events", Py_BuildValue("I", event.events)));
    CHECK_NULL(SetItemToDict(pyDict, "data", Py_BuildValue("k", event.data)));

    return pyDict;
}

PyObject* WrapHiMpiSysWaitEpoll(PyObject* /* self */, PyObject* args)
{
    hi_s32 epollFd = 0;
    hi_s32 maxEvents = 0;
    hi_s32 timeout = 0;
    hi_s32 eventNum = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iii", &epollFd, &maxEvents, &timeout), "acl.himpi.sys_wait_epoll args parse failed!");

    const hi_s32 minLimit = 0;
    const hi_s32 maxLimit = 4096;
    CHECK_NULL(maxEvents <= maxLimit && maxEvents >= minLimit, "invalid num of maxEvents");
    std::vector<hi_dvpp_epoll_event> events(maxEvents + 1, hi_dvpp_epoll_event{});
    hi_s32 ret = hi_mpi_sys_wait_epoll(epollFd, events.data(), maxEvents, timeout, &eventNum);
    PyObject* pyEvents = GetPyListFromStructArray(events.data(), maxEvents, GetPydictFromDvppEpollEvent);
    CHECK_NULL(pyEvents != nullptr);
    PyObject* obj = Py_BuildValue("OiI", pyEvents, eventNum, ret);
    Py_XDECREF(pyEvents);
    return obj;
}

PyObject* WrapHiMpiSysCloseEpoll(PyObject* /* self */, PyObject* args)
{
    hi_s32 epollFd = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &epollFd), "acl.himpi.sys_close_epoll args parse failed!");

    hi_s32 ret = hi_mpi_sys_close_epoll(epollFd);
    return Py_BuildValue("I", ret);
}

static bool GetCoefficientFromPydict(PyObject* pyDict, hi_coefficient& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_coefficient argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "csc_matrix_r0_c0", param.csc_matrix_r0_c0));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "csc_matrix_r0_c1", param.csc_matrix_r0_c1));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "csc_matrix_r0_c2", param.csc_matrix_r0_c2));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "csc_matrix_r1_c0", param.csc_matrix_r1_c0));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "csc_matrix_r1_c1", param.csc_matrix_r1_c1));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "csc_matrix_r1_c2", param.csc_matrix_r1_c2));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "csc_matrix_r2_c0", param.csc_matrix_r2_c0));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "csc_matrix_r2_c1", param.csc_matrix_r2_c1));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "csc_matrix_r2_c2", param.csc_matrix_r2_c2));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "csc_bias_r0", param.csc_bias_r0));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "csc_bias_r1", param.csc_bias_r1));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "csc_bias_r2", param.csc_bias_r2));

    return true;
}

static bool GetCscCoefficientFromPydict(PyObject* pyDict, hi_csc_coefficient& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_csc_coefficient argument is not dict");

    PyObject* pyYuv = PyDict_GetItemString(pyDict, "yuv_to_rgb_coefficient");
    CHECK_BOOL(GetCoefficientFromPydict(pyYuv, param.yuv_to_rgb_coefficient));

    PyObject* pyRgb = PyDict_GetItemString(pyDict, "rgb_to_yuv_coefficient");
    CHECK_BOOL(GetCoefficientFromPydict(pyRgb, param.rgb_to_yuv_coefficient));

    return true;
}

PyObject* WrapHiMpiSysSetChnCscMatrix(PyObject* /* self */, PyObject* args)
{
    hi_mod_id mode = HI_ID_CMPI;
    hi_s32 chn = 0;
    hi_csc_matrix cscMatrix = HI_CSC_MATRIX_BT601_WIDE;
    PyObject* pyCoefficient = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iiiO", &mode, &chn, &cscMatrix, &pyCoefficient),
        "acl.himpi.sys_set_chn_csc_matrix args parse failed!");

    hi_csc_coefficient cscCoefficient{};
    CHECK_NULL(GetCscCoefficientFromPydict(pyCoefficient, cscCoefficient));

    hi_s32 ret = hi_mpi_sys_set_chn_csc_matrix(mode, chn, cscMatrix, &cscCoefficient);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromCoefficient(hi_coefficient param)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(SetItemToDict(pyDict, "csc_matrix_r0_c0", Py_BuildValue("d", param.csc_matrix_r0_c0)));
    CHECK_NULL(SetItemToDict(pyDict, "csc_matrix_r0_c1", Py_BuildValue("d", param.csc_matrix_r0_c1)));
    CHECK_NULL(SetItemToDict(pyDict, "csc_matrix_r0_c2", Py_BuildValue("d", param.csc_matrix_r0_c2)));
    CHECK_NULL(SetItemToDict(pyDict, "csc_matrix_r1_c0", Py_BuildValue("d", param.csc_matrix_r1_c0)));
    CHECK_NULL(SetItemToDict(pyDict, "csc_matrix_r1_c1", Py_BuildValue("d", param.csc_matrix_r1_c1)));
    CHECK_NULL(SetItemToDict(pyDict, "csc_matrix_r1_c2", Py_BuildValue("d", param.csc_matrix_r1_c2)));
    CHECK_NULL(SetItemToDict(pyDict, "csc_matrix_r2_c0", Py_BuildValue("d", param.csc_matrix_r2_c0)));
    CHECK_NULL(SetItemToDict(pyDict, "csc_matrix_r2_c1", Py_BuildValue("d", param.csc_matrix_r2_c1)));
    CHECK_NULL(SetItemToDict(pyDict, "csc_matrix_r2_c2", Py_BuildValue("d", param.csc_matrix_r2_c2)));
    CHECK_NULL(SetItemToDict(pyDict, "csc_bias_r0", Py_BuildValue("d", param.csc_bias_r0)));
    CHECK_NULL(SetItemToDict(pyDict, "csc_bias_r1", Py_BuildValue("d", param.csc_bias_r1)));
    CHECK_NULL(SetItemToDict(pyDict, "csc_bias_r2", Py_BuildValue("d", param.csc_bias_r2)));

    return pyDict;
}

static PyObject* GetPydictFromCscCoefficient(hi_csc_coefficient event)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(SetItemToDict(pyDict, "yuv_to_rgb_coefficient", GetPydictFromCoefficient(event.yuv_to_rgb_coefficient)));
    CHECK_NULL(SetItemToDict(pyDict, "rgb_to_yuv_coefficient", GetPydictFromCoefficient(event.rgb_to_yuv_coefficient)));

    return pyDict;
}

PyObject* WrapHiMpiSysGetChnCscMatrix(PyObject* /* self */, PyObject* args)
{
    hi_mod_id mode = HI_ID_CMPI;
    hi_s32 chn = 0;
    hi_csc_matrix cscMatrix = HI_CSC_MATRIX_BT601_WIDE;
    hi_csc_coefficient cscCoefficient{};

    CHECK_NULL(PyArg_ParseTuple(args, "ii", &mode, &chn), "acl.himpi.sys_get_chn_csc_matrix args parse failed!");

    hi_s32 ret = hi_mpi_sys_get_chn_csc_matrix(mode, chn, &cscMatrix, &cscCoefficient);
    PyObject* pyDict = GetPydictFromCscCoefficient(cscCoefficient);
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("iOI", cscMatrix, pyDict, ret);
    Py_XDECREF(pyDict);
    return obj;
}

static PyObject* GetPydictFromImgAlignInfo(hi_img_align_info& info)
{
    PyObject* pyDict = PyDict_New();
    const int size = 2;

    CHECK_NULL(SetItemToDict(pyDict, "width_stride", Py_BuildValue("I", info.width_stride)));
    CHECK_NULL(SetItemToDict(pyDict, "height_stride", Py_BuildValue("I", info.height_stride)));
    CHECK_NULL(SetItemToDict(pyDict, "img_buf_size", Py_BuildValue("k", info.img_buf_size)));
    CHECK_NULL(SetItemToDict(pyDict, "reserved", GetPyListFromArray(info.reserved, size)));

    return pyDict;
}

static bool GetImgBaseInfoFromPydict(PyObject* pyDict, hi_img_base_info& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_img_base_info argument is not dict");
    CHECK_BOOL(MemsetStructArgu(info));

    CHECK_BOOL(GetValueFromPyDict(pyDict, "width", info.width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "height", info.height));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "pixel_format", info.pixel_format));

    hi_u32 length = sizeof(info.reserved) / sizeof(info.reserved[0]);
    PyObject* pyReserved = PyDict_GetItemString(pyDict, "reserved");
    CHECK_BOOL(ConvertPyListToLongArray(pyReserved, length, info.reserved));
    return true;
}

PyObject* WrapHiMpiSysGetImageAlignInfo(PyObject* /* self */, PyObject* args)
{
    PyObject* pyModuleType = nullptr;
    hi_u32 modeNum = 0;
    PyObject* pyImgBaseInfo = nullptr;
    hi_img_align_info imgAlignInfo{};

    CHECK_NULL(
        PyArg_ParseTuple(args, "OiO", &pyModuleType, &modeNum, &pyImgBaseInfo),
        "acl.himpi.sys_get_image_align_info args parse failed!");

    CHECK_NULL(PyList_Check(pyModuleType), "hi_module_type argument is not list");
    hi_u32 len = static_cast<hi_u32>(PyList_Size(pyModuleType));
    CHECK_NULL(len == modeNum, "the length of mode_type is not equal with mod_num!");
    std::vector<hi_module_type> modules(len + 1);
    CHECK_NULL(ConvertPyListToLongArray(pyModuleType, len, modules.data()));

    hi_img_base_info imgBaseInfo{};
    CHECK_NULL(GetImgBaseInfoFromPydict(pyImgBaseInfo, imgBaseInfo));
    hi_s32 ret = hi_mpi_sys_get_image_align_info(modules.data(), modeNum, &imgBaseInfo, &imgAlignInfo);
    PyObject* pyDict = GetPydictFromImgAlignInfo(imgAlignInfo);
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyDict, ret);
    Py_XDECREF(pyDict);
    return obj;
}