/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "utils_methods.h"
#include <climits>

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, unsigned short& value)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if (pyObj == nullptr || (PyLong_Check(pyObj) == 0)) {
        return true;
    }

    unsigned short tmp = static_cast<unsigned short>(PyLong_AsUnsignedLong(pyObj));
    if (PyErr_Occurred()) {
        PyErr_SetString(PyExc_ValueError, "PyLong_AsUnsignedLong failed");
        return false;
    }
    value = tmp;
    return true;
}

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, unsigned char& value)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if (pyObj == nullptr || (PyLong_Check(pyObj) == 0)) {
        return true;
    }

    unsigned char tmp = static_cast<unsigned char>(PyLong_AsUnsignedLong(pyObj));
    if (PyErr_Occurred()) {
        PyErr_SetString(PyExc_ValueError, "PyLong_AsUnsignedLong failed");
        return false;
    }
    value = tmp;
    return true;
}

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, unsigned int& value)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if (pyObj == nullptr || (PyLong_Check(pyObj) == 0)) {
        return true;
    }

    unsigned int tmp = static_cast<unsigned int>(PyLong_AsUnsignedLong(pyObj));
    if (PyErr_Occurred()) {
        PyErr_SetString(PyExc_ValueError, "PyLong_AsUnsignedLong failed");
        return false;
    }
    value = tmp;
    return true;
}

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, int& value)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if (pyObj == nullptr || (PyLong_Check(pyObj) == 0)) {
        return true;
    }

    int tmp = static_cast<int>(PyLong_AsLong(pyObj));
    if (PyErr_Occurred()) {
        PyErr_SetString(PyExc_ValueError, "PyLong_AsLong failed");
        return false;
    }
    value = tmp;
    return true;
}

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, short& value)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if (pyObj == nullptr || (PyLong_Check(pyObj) == 0)) {
        return true;
    }

    short tmp = static_cast<short>(PyLong_AsLong(pyObj));
    if (PyErr_Occurred()) {
        PyErr_SetString(PyExc_ValueError, "PyLong_AsLong failed");
        return false;
    }
    value = tmp;
    return true;
}

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, float& value)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if (pyObj == nullptr || ((PyFloat_Check(pyObj) == 0) && (PyLong_Check(pyObj) == 0))) {
        return true;
    }

    float tmp = static_cast<float>(PyFloat_AsDouble(pyObj));
    if (PyErr_Occurred()) {
        PyErr_SetString(PyExc_ValueError, "PyFloat_AsDouble failed");
        return false;
    }
    value = tmp;
    return true;
}

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, unsigned long long& value)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if (pyObj == nullptr || (PyLong_Check(pyObj) == 0)) {
        return true;
    }

    unsigned long long tmp = PyLong_AsUnsignedLongLong(pyObj);
    if (PyErr_Occurred()) {
        PyErr_SetString(PyExc_ValueError, "PyLong_AsUnsignedLongLong failed");
        return false;
    }
    value = tmp;
    return true;
}

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, unsigned long& value)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if (pyObj == nullptr || (PyLong_Check(pyObj) == 0)) {
        return true;
    }

    unsigned long tmp = PyLong_AsUnsignedLong(pyObj);
    if (PyErr_Occurred()) {
        PyErr_SetString(PyExc_ValueError, "PyLong_AsUnsignedLong failed");
        return false;
    }
    value = tmp;
    return true;
}

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, double& value)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if (pyObj == nullptr || ((PyFloat_Check(pyObj) == 0) && (PyLong_Check(pyObj) == 0))) {
        return true;
    }

    double tmp = PyFloat_AsDouble(pyObj);
    if (PyErr_Occurred()) {
        PyErr_SetString(PyExc_ValueError, "PyFloat_AsDouble failed");
        return false;
    }
    value = tmp;
    return true;
}

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, hi_u8* value, int size)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if (pyObj == nullptr || (PyList_Check(pyObj) == 0)) {
        return true;
    }

    int len = static_cast<int>(PyList_Size(pyObj));
    if (len > size) {
        std::string errMsg =
            "The length of " + std::string(keyName) + " should be no greater than " + std::to_string(size);
        PyErr_SetString(PyExc_ValueError, errMsg.c_str());
        return false;
    }
    for (int i = 0; i < len; i++) {
        PyObject* obj = PyList_GetItem(pyObj, i);
        if (obj == nullptr || (PyLong_Check(obj) == 0)) {
            return true;
        }

        hi_u8 tmp = static_cast<hi_u8>(PyLong_AsUnsignedLong(obj));
        if (PyErr_Occurred()) {
            PyErr_SetString(PyExc_ValueError, "PyLong_AsUnsignedLong failed");
            return false;
        }
        value[i] = tmp;
    }
    return true;
}

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, void*& value)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if (pyObj == nullptr || pyObj == Py_None) {
        value = nullptr;
        return true;
    }

    void* tmp = PyLong_AsVoidPtr(pyObj);
    if (tmp == nullptr && PyErr_Occurred()) {
        PyErr_SetString(PyExc_ValueError, "PyLong_AsVoidPtr failed");
        return false;
    }
    value = tmp;
    return true;
}

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, void* value[], int size)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if (pyObj == nullptr || (PyList_Check(pyObj) == 0)) {
        return true;
    }

    int len = static_cast<int>(PyList_Size(pyObj));
    if (len > size) {
        std::string errMsg =
            "The length of " + std::string(keyName) + " should be no greater than " + std::to_string(size);
        PyErr_SetString(PyExc_ValueError, errMsg.c_str());
        return false;
    }
    for (int i = 0; i < len; i++) {
        PyObject* obj = PyList_GetItem(pyObj, i);
        if (obj == nullptr) {
            return true;
        }

        void* tmp = PyLong_AsVoidPtr(obj);
        if (tmp == nullptr && PyErr_Occurred()) {
            PyErr_SetString(PyExc_ValueError, "PyLong_AsVoidPtr failed");
            return false;
        }
        value[i] = tmp;
    }
    return true;
}

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, double* value, int size)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if (pyObj == nullptr || (PyList_Check(pyObj) == 0)) {
        return true;
    }

    int len = static_cast<int>(PyList_Size(pyObj));
    if (len > size) {
        std::string errMsg =
            "The length of " + std::string(keyName) + " should be no greater than " + std::to_string(size);
        PyErr_SetString(PyExc_ValueError, errMsg.c_str());
        return false;
    }
    for (int i = 0; i < len; i++) {
        PyObject* obj = PyList_GetItem(pyObj, i);
        if (obj == nullptr || (PyFloat_Check(obj) == 0 && PyLong_Check(obj) == 0)) {
            return true;
        }

        double tmp = PyFloat_AsDouble(obj);
        if (PyErr_Occurred()) {
            PyErr_SetString(PyExc_ValueError, "PyFloat_AsDouble failed");
            return false;
        }
        value[i] = tmp;
    }
    return true;
}

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, int* value, int size)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if (pyObj == nullptr || (PyList_Check(pyObj) == 0)) {
        return true;
    }

    int len = static_cast<int>(PyList_Size(pyObj));
    if (len > size) {
        std::string errMsg =
            "The length of " + std::string(keyName) + " should be no greater than " + std::to_string(size);
        PyErr_SetString(PyExc_ValueError, errMsg.c_str());
        return false;
    }
    for (int i = 0; i < len; i++) {
        PyObject* obj = PyList_GetItem(pyObj, i);
        if (obj == nullptr || (PyLong_Check(obj) == 0)) {
            return true;
        }

        long tmp = PyLong_AsLong(obj);
        if (PyErr_Occurred()) {
            PyErr_SetString(PyExc_ValueError, "PyLong_AsLong failed");
            return false;
        }
        if (INT32_MAX < tmp || INT32_MIN > tmp) {
            PyErr_SetString(PyExc_ValueError, "The value exceeds the maximum and minimum values of type 'int' ");
            return false;
        }
        value[i] = static_cast<int>(tmp);
    }
    return true;
}

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, unsigned int* value, int size)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if (pyObj == nullptr || (PyList_Check(pyObj) == 0)) {
        return true;
    }

    int len = static_cast<int>(PyList_Size(pyObj));
    if (len > size) {
        std::string errMsg =
            "The length of " + std::string(keyName) + " should be no greater than " + std::to_string(size);
        PyErr_SetString(PyExc_ValueError, errMsg.c_str());
        return false;
    }
    for (int i = 0; i < len; i++) {
        PyObject* obj = PyList_GetItem(pyObj, i);
        if (obj == nullptr || (PyLong_Check(obj) == 0)) {
            return true;
        }

        unsigned int tmp = static_cast<unsigned int>(PyLong_AsUnsignedLong(obj));
        if (PyErr_Occurred()) {
            PyErr_SetString(PyExc_ValueError, "PyLong_AsUnsignedLong failed");
            return false;
        }
        value[i] = tmp;
    }
    return true;
}

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, hi_u64* value, int size)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if (pyObj == nullptr || (PyList_Check(pyObj) == 0)) {
        return true;
    }

    int len = static_cast<int>(PyList_Size(pyObj));
    if (len > size) {
        std::string errMsg =
            "The length of " + std::string(keyName) + " should be no greater than " + std::to_string(size);
        PyErr_SetString(PyExc_ValueError, errMsg.c_str());
        return false;
    }
    for (int i = 0; i < len; i++) {
        PyObject* obj = PyList_GetItem(pyObj, i);
        if (obj == nullptr || (PyLong_Check(obj) == 0)) {
            return true;
        }

        hi_u64 tmp = PyLong_AsUnsignedLongLong(obj);
        if (PyErr_Occurred()) {
            PyErr_SetString(PyExc_ValueError, "PyLong_AsUnsignedLongLong failed");
            return false;
        }
        value[i] = tmp;
    }
    return true;
}

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, unsigned long* value, int size)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if (pyObj == nullptr || (PyList_Check(pyObj) == 0)) {
        return true;
    }

    int len = static_cast<int>(PyList_Size(pyObj));
    if (len > size) {
        std::string errMsg =
            "The length of " + std::string(keyName) + " should be no greater than " + std::to_string(size);
        PyErr_SetString(PyExc_ValueError, errMsg.c_str());
        return false;
    }
    for (int i = 0; i < len; i++) {
        PyObject* obj = PyList_GetItem(pyObj, i);
        if (obj == nullptr || (PyLong_Check(obj) == 0)) {
            return true;
        }

        hi_u64 tmp = PyLong_AsUnsignedLong(obj);
        if (PyErr_Occurred()) {
            PyErr_SetString(PyExc_ValueError, "PyLong_AsUnsignedLong failed");
            return false;
        }
        value[i] = tmp;
    }
    return true;
}

void SetItem(PyObject* pyList, int index, unsigned long value)
{
    PyList_SetItem(pyList, index, Py_BuildValue("k", value));
}

void SetItem(PyObject* pyList, int index, unsigned int value)
{
    PyList_SetItem(pyList, index, Py_BuildValue("I", value));
}

void SetItem(PyObject* pyList, int index, int value) { PyList_SetItem(pyList, index, Py_BuildValue("i", value)); }

void SetItem(PyObject* pyList, int index, unsigned long long value)
{
    PyList_SetItem(pyList, index, Py_BuildValue("K", value));
}

void SetItem(PyObject* pyList, int index, const void* value)
{
    PyList_SetItem(pyList, index, Py_BuildValue("K", value));
}

void SetItem(PyObject* pyList, int index, int64_t value) { PyList_SetItem(pyList, index, Py_BuildValue("L", value)); }

void SetItem(PyObject* pyList, int index, float value) { PyList_SetItem(pyList, index, Py_BuildValue("f", value)); }

void SetItem(PyObject* pyList, int index, PyObject* pyObj) { PyList_SetItem(pyList, index, pyObj); }

bool GetValuesFromPyList(PyObject* object, std::vector<uint8_t>& values)
{
    constexpr int uint8MaxValue = 255;
    if (PyList_Check(object) == false) {
        PyErr_SetString(PyExc_TypeError, "input must be list");
        return false;
    }
    int numValues = static_cast<int>(PyList_Size(object));
    values.assign(numValues + 1, 0);
    for (int i = 0; i < numValues; i++) {
        PyObject* objectItem = PyList_GetItem(object, i);
        if ((objectItem == nullptr) || (PyObject_TypeCheck(objectItem, &PyLong_Type) == 0)) {
            PyErr_SetString(PyExc_TypeError, "invalid data type");
            return false;
        }
        long value = PyLong_AsLong(objectItem);
        if (PyErr_Occurred()) {
            PyErr_SetString(PyExc_ValueError, "PyLong_AsLong failed");
            return false;
        }
        if (value < 0 || value > uint8MaxValue) {
            PyErr_SetString(PyExc_ValueError, "the value must between 0 and 255");
            return false;
        }
        values[i] = static_cast<uint8_t>(value);
    }
    return true;
}

bool GetValuesFromPyList(PyObject* object, std::vector<int64_t>& values)
{
    if (PyList_Check(object) == false) {
        PyErr_SetString(PyExc_TypeError, "input must be list");
        return false;
    }
    int numValues = static_cast<int>(PyList_Size(object));
    values.assign(numValues + 1, 0);
    for (int i = 0; i < numValues; i++) {
        PyObject* objectItem = PyList_GetItem(object, i);
        if ((objectItem == nullptr) || (PyObject_TypeCheck(objectItem, &PyLong_Type) == 0)) {
            PyErr_SetString(PyExc_TypeError, "invalid data type");
            return false;
        }
        int64_t tmp = PyLong_AsLongLong(objectItem);
        if (PyErr_Occurred()) {
            PyErr_SetString(PyExc_ValueError, "PyLong_AsLongLong failed");
            return false;
        }
        values[i] = tmp;
    }
    return true;
}

bool GetValuesFromPyList(PyObject* object, std::vector<int32_t>& values)
{
    if (PyList_Check(object) == false) {
        PyErr_SetString(PyExc_TypeError, "input must be list");
        return false;
    }
    int numValues = static_cast<int>(PyList_Size(object));
    values.assign(numValues + 1, 0);
    for (int i = 0; i < numValues; i++) {
        PyObject* objectItem = PyList_GetItem(object, i);
        if ((objectItem == nullptr) || (PyObject_TypeCheck(objectItem, &PyLong_Type) == 0)) {
            PyErr_SetString(PyExc_TypeError, "invalid data type");
            return false;
        }
        long value = PyLong_AsLong(objectItem);
        if (PyErr_Occurred()) {
            PyErr_SetString(PyExc_ValueError, "PyLong_AsLong failed");
            return false;
        }
        if (value < INT_MIN || value > INT_MAX) {
            PyErr_SetString(PyExc_ValueError, "value overflow");
            return false;
        }
        values[i] = static_cast<int32_t>(value);
    }
    return true;
}

bool GetValuesFromPyList(PyObject* object, std::vector<float>& values)
{
    if (PyList_Check(object) == false) {
        PyErr_SetString(PyExc_TypeError, "input must be list");
        return false;
    }
    int numValues = static_cast<int>(PyList_Size(object));
    values.assign(numValues + 1, 0);
    for (int i = 0; i < numValues; i++) {
        PyObject* objectItem = PyList_GetItem(object, i);
        if ((objectItem == nullptr) || (PyObject_TypeCheck(objectItem, &PyFloat_Type) == 0)) {
            PyErr_SetString(PyExc_TypeError, "invalid data type");
            return false;
        }
        float tmp = static_cast<float>(PyFloat_AsDouble(objectItem));
        if (PyErr_Occurred()) {
            PyErr_SetString(PyExc_ValueError, "PyFloat_AsDouble failed");
            return false;
        }
        values[i] = tmp;
    }
    return true;
}

PyObject* SetItemToDict(PyObject* pyDict, const char* key, PyObject* obj)
{
    if (pyDict == nullptr || PyDict_Check(pyDict) == false || obj == nullptr) {
        Py_XDECREF(obj);
        Py_XDECREF(pyDict);
        return nullptr;
    }
    if (PyDict_SetItemString(pyDict, key, obj) == -1) {
        Py_XDECREF(obj);
        Py_XDECREF(pyDict);
        return nullptr;
    }
    Py_XDECREF(obj);
    return pyDict;
}

bool GetImgStreamFromPydict(PyObject* pyDict, hi_img_stream& imgStream)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_img_stream argument is not dict");
    CHECK_BOOL(MemsetStructArgu(imgStream));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "type", imgStream.type));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "addr", reinterpret_cast<void*&>(imgStream.addr)));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "len", imgStream.len));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "pts", imgStream.pts));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "reserved", imgStream.reserved, sizeof(imgStream.reserved) / sizeof(hi_s32)));

    return true;
}

static bool GetVideoSupplementFromPydict(PyObject* pyDict, hi_video_supplement& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_video_supplement argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "misc_info_phys_addr", info.misc_info_phys_addr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "jpeg_dcf_phys_addr", info.jpeg_dcf_phys_addr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "isp_info_phys_addr", info.isp_info_phys_addr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "low_delay_phys_addr", info.low_delay_phys_addr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "bnr_rnt_phys_addr", info.bnr_rnt_phys_addr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "motion_data_phys_addr", info.motion_data_phys_addr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "frame_dng_phys_addr", info.frame_dng_phys_addr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "misc_info_virt_addr", info.misc_info_virt_addr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "jpeg_dcf_virt_addr", info.jpeg_dcf_virt_addr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "isp_info_virt_addr", info.isp_info_virt_addr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "low_delay_virt_addr", info.low_delay_virt_addr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "bnr_mot_virt_addr", info.bnr_mot_virt_addr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "motion_data_virt_addr", info.motion_data_virt_addr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "frame_dng_virt_addr", info.frame_dng_virt_addr));

    return true;
}

bool GetVideoFrameFromPydict(PyObject* pyDict, hi_video_frame& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_video_frame argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "width", info.width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "height", info.height));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "field", info.field));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "pixel_format", info.pixel_format));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "video_format", info.video_format));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "compress_mode", info.compress_mode));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "dynamic_range", info.dynamic_range));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "color_gamut", info.color_gamut));
    CHECK_BOOL(
        GetValueFromPyDict(pyDict, "header_stride", info.header_stride, sizeof(info.header_stride) / sizeof(hi_u32)));
    CHECK_BOOL(
        GetValueFromPyDict(pyDict, "width_stride", info.width_stride, sizeof(info.width_stride) / sizeof(hi_u32)));
    CHECK_BOOL(
        GetValueFromPyDict(pyDict, "height_stride", info.height_stride, sizeof(info.height_stride) / sizeof(hi_u32)));
    CHECK_BOOL(GetValueFromPyDict(
        pyDict, "header_phys_addr", info.header_phys_addr, sizeof(info.header_phys_addr) / sizeof(hi_u64)));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "phys_addr", info.phys_addr, sizeof(info.phys_addr) / sizeof(hi_u64)));
    CHECK_BOOL(GetValueFromPyDict(
        pyDict, "header_virt_addr", info.header_virt_addr, sizeof(info.header_virt_addr) / sizeof(hi_void*)));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "virt_addr", info.virt_addr, sizeof(info.virt_addr) / sizeof(hi_void*)));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "time_ref", info.time_ref));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "pts", info.pts));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "user_data", info.user_data, sizeof(info.user_data) / sizeof(hi_u64)));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "frame_flag", info.frame_flag));

    PyObject* pySupplement = PyDict_GetItemString(pyDict, "supplement");
    CHECK_BOOL(GetVideoSupplementFromPydict(pySupplement, info.supplement));

    return true;
}
