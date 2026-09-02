/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_UTILS_METHODS_CONTENT_H
#define WORD_UTILS_METHODS_CONTENT_H

#include <Python.h>
#include <string>
#include <securec.h>
#include <vector>
#include "acl/dvpp/hi_dvpp_vdec.h"
#include "acl/dvpp/hi_media_type.h"

#define CHECK_STRUCT_DICT(pyDict, str)          \
    if ((pyDict) == nullptr) {                  \
        return true;                            \
    } else if (PyDict_Check(pyDict) == false) { \
        PyErr_SetString(PyExc_TypeError, str);  \
        return false;                           \
    }

#define VARGS_HELPER(_3, _2, _1, N, ...) N
#define VARGS(...) VARGS_HELPER(__VA_ARGS__, 3, 2, 1, 0)
#define CONCAT_HELPER(a, b) a##b
#define CONCAT(a, b) CONCAT_HELPER(a, b)

#define CHECK_NULL_3(cond, str, err_type)           \
    if ((cond) == 0) {                              \
        std::string log = str;                      \
        if (!log.empty()) {                         \
            PyErr_SetString(err_type, log.c_str()); \
        }                                           \
        return nullptr;                             \
    }

#define CHECK_NULL_1(cond) CHECK_NULL_3(cond, "", nullptr)
#define CHECK_NULL_2(cond, str) CHECK_NULL_3(cond, str, PyExc_TypeError)
#define CHECK_NULL(...) CONCAT(CHECK_NULL_, VARGS(__VA_ARGS__))(__VA_ARGS__)

#define CHECK_BOOL_3(cond, str, err_type)           \
    if ((cond) == 0) {                              \
        std::string log = str;                      \
        if (!log.empty()) {                         \
            PyErr_SetString(err_type, log.c_str()); \
        }                                           \
        return false;                               \
    }

#define CHECK_BOOL_1(cond) CHECK_BOOL_3(cond, "", nullptr)
#define CHECK_BOOL_2(cond, str) CHECK_BOOL_3(cond, str, PyExc_TypeError)
#define CHECK_BOOL(...) CONCAT(CHECK_BOOL_, VARGS(__VA_ARGS__))(__VA_ARGS__)

bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, unsigned int& value);
bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, int& value);
bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, short& value);
bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, unsigned long long& value);
bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, unsigned long& value);
bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, double& value);
bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, hi_u8* value, int size);
bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, void*& value);
bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, void* value[], int size);
bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, double* value, int size);
bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, int* value, int size);
bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, unsigned int* value, int size);
bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, unsigned long* value, int size);
bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, hi_u64* value, int size);
bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, float& value);
bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, unsigned char& value);
bool GetValueFromPyDict(PyObject* pyDict, const char* keyName, unsigned short& value);
void SetItem(PyObject* pyList, int index, unsigned long value);
void SetItem(PyObject* pyList, int index, unsigned int value);
void SetItem(PyObject* pyList, int index, int value);
void SetItem(PyObject* pyList, int index, unsigned long long value);
void SetItem(PyObject* pyList, int index, const void* value);
void SetItem(PyObject* pyList, int index, int64_t value);
void SetItem(PyObject* pyList, int index, float value);
void SetItem(PyObject* pyList, int index, PyObject* pyObj);

template <typename T>
bool MemsetStructArgu(T& argu, int value = 0)
{
    errno_t sRet = memset_s(&argu, sizeof(argu), value, sizeof(argu));
    if (sRet != EOK) {
        PyErr_SetString(PyExc_TypeError, "memory memset failed!");
        return false;
    }

    return true;
}

template <typename T>
bool MemsetStructArrayArgu(T& argu, size_t size, int value = 0)
{
    errno_t sRet = memset_s(argu, sizeof(*argu) * size, value, sizeof(*argu) * size);
    if (sRet != EOK) {
        PyErr_SetString(PyExc_TypeError, "memory memset failed!");
        return false;
    }

    return true;
}

template <typename T>
PyObject* GetPyListFromArray(T* datas, int size)
{
    PyObject* pyList = PyList_New(size);
    if (!pyList) {
        PyErr_SetString(PyExc_MemoryError, "memory malloc failed");
        return nullptr;
    }

    for (int i = 0; i < size; i++) {
        SetItem(pyList, i, datas[i]);
    }
    return pyList;
}

template <typename T>
PyObject* GetPyListFromArray(T* datas, int row, int col)
{
    PyObject* pyList = PyList_New(row);
    if (!pyList) {
        PyErr_SetString(PyExc_MemoryError, "memory malloc failed");
        return nullptr;
    }

    for (int i = 0; i < row; i++) {
        PyObject* pyListV2 = PyList_New(col);
        if (!pyListV2) {
            PyErr_SetString(PyExc_MemoryError, "memory malloc failed");
            return nullptr;
        }
        for (int j = 0; j < col; j++) {
            SetItem(pyListV2, j, datas[i][j]);
        }
        SetItem(pyList, i, pyListV2);
    }
    return pyList;
}

bool GetValuesFromPyList(PyObject* object, std::vector<uint8_t>& values);
bool GetValuesFromPyList(PyObject* object, std::vector<int32_t>& values);
bool GetValuesFromPyList(PyObject* object, std::vector<int64_t>& values);
bool GetValuesFromPyList(PyObject* object, std::vector<float>& values);
PyObject* SetItemToDict(PyObject* pyDict, const char* key, PyObject* obj);
bool GetImgStreamFromPydict(PyObject* pyDict, hi_img_stream& imgStream);
bool GetVideoFrameFromPydict(PyObject* pyDict, hi_video_frame& info);

template <typename T>
bool GetArrayFromPyDict(PyObject* pyDict, const char* key, size_t listLen, T* ptr, const size_t maxLen)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, key);
    if (pyObj == nullptr) {
        return true;
    } else if ((PyList_Check(pyObj) == 0)) {
        std::string errMsg = "The type of " + std::string(key) + " is not a list!";
        PyErr_SetString(PyExc_ValueError, errMsg.c_str());
        return false;
    }

    int len = PyList_Size(pyObj);
    if (len != listLen || listLen > maxLen) {
        std::string errMsg = "The length of " + std::string(key) + " is not equal to " + std::to_string(listLen) +
                             " or greater than " + std::to_string(maxLen);
        PyErr_SetString(PyExc_ValueError, errMsg.c_str());
        return false;
    }
    for (size_t i = 0; i < len; i++) {
        PyObject* obj = PyList_GetItem(pyObj, i);

        if (obj == nullptr || PyLong_Check(obj) != true) {
            std::string errMsg = "The element in " + std::string(key) + " is not a number.";
            PyErr_SetString(PyExc_ValueError, errMsg.c_str());
            return false;
        }

        ptr[i] = static_cast<T>(PyLong_AsLong(obj));
        if (PyErr_Occurred()) {
            PyErr_SetString(PyExc_ValueError, "Can not convert some elements.");
            return false;
        }
    }
    return true;
}

template <typename T>
bool GetEnumValueFromPyDict(PyObject* pyDict, const char* keyName, T& value)
{
    PyObject* pyObj = PyDict_GetItemString(pyDict, keyName);
    if ((pyObj == nullptr) || (PyLong_Check(pyObj) == 0)) {
        return true;
    }

    T tmp = static_cast<T>(PyLong_AsLong(pyObj));
    if (PyErr_Occurred()) {
        PyErr_SetString(PyExc_ValueError, "PyLong_AsLong failed");
        return false;
    }
    value = tmp;
    return true;
}

template <typename T>
PyObject* GetPyListFromStructArray(T* array, size_t size, PyObject* func(T&))
{
    CHECK_NULL(array, "array is NULL", PyExc_RuntimeError);
    PyObject* pyList = PyList_New(size);
    if (!pyList) {
        PyErr_SetString(PyExc_MemoryError, "memory malloc failed");
        return nullptr;
    }

    for (size_t i = 0; i < size; i++) {
        PyList_SetItem(pyList, i, func(array[i]));
    }
    return pyList;
}

template <typename T>
bool ConvertPyListToLongArray(PyObject* pyList, int len, T* array)
{
    for (int i = 0; i < len; i++) {
        PyObject* obj = PyList_GetItem(pyList, i);
        if ((obj == nullptr) || (PyObject_TypeCheck(obj, &PyLong_Type) == 0)) {
            PyErr_SetString(PyExc_TypeError, "the list argument is not list of int");
            return false;
        }
        array[i] = static_cast<T>(PyLong_AsLong(obj));
        CHECK_BOOL(PyErr_Occurred() == nullptr, "PyLong_AsLong failed", PyExc_ValueError);
    }
    return true;
}

template <typename T>
bool ConvertPyListToUnsignedLongArray(PyObject* pyList, int len, T* array)
{
    for (int i = 0; i < len; i++) {
        PyObject* obj = PyList_GetItem(pyList, i);
        if ((obj == nullptr) || (PyObject_TypeCheck(obj, &PyLong_Type) == 0)) {
            PyErr_SetString(PyExc_TypeError, "the list argument is not list of int");
            return false;
        }
        array[i] = static_cast<T>(PyLong_AsUnsignedLong(obj));
        CHECK_BOOL(PyErr_Occurred() == nullptr, "PyLong_AsUnsignedLong failed", PyExc_ValueError);
    }
    return true;
}

template <typename T>
bool ConvertPyListToPtrArray(PyObject* pyList, int len, T* array)
{
    for (int i = 0; i < len; i++) {
        PyObject* obj = PyList_GetItem(pyList, i);
        if ((obj == nullptr) || (PyObject_TypeCheck(obj, &PyLong_Type) == 0)) {
            PyErr_SetString(PyExc_TypeError, "the list argument is not list of int");
            return false;
        }
        array[i] = reinterpret_cast<T>(PyLong_AsVoidPtr(obj));
        CHECK_BOOL(PyErr_Occurred() == nullptr, "PyLong_AsVoidPtr failed", PyExc_ValueError);
    }
    return true;
}

template <typename T>
bool ConvertPyListToStructArray(PyObject* pyList, int len, T* array, bool func(PyObject*, T&))
{
    for (int i = 0; i < len; i++) {
        PyObject* pyDict = PyList_GetItem(pyList, i);
        if (!func(pyDict, array[i])) {
            return false;
        }
    }
    return true;
}

template <typename T>
bool ConvertPyListToStructAddressArray(PyObject* pyList, int len, T* array, T** addrArray, bool func(PyObject*, T&))
{
    for (int i = 0; i < len; i++) {
        PyObject* pyDict = PyList_GetItem(pyList, i);
        if (!func(pyDict, array[i])) {
            return false;
        }
        addrArray[i] = &array[i];
    }
    return true;
}

template <typename T>
bool ConvertPyListToLongLongArrayV2(PyObject* pyList, int row, int col, std::vector<T>& array)
{
    for (int i = 0; i < row; i++) {
        PyObject* object = PyList_GetItem(pyList, i);
        if ((object == nullptr) || (PyList_Check(object) == 0)) {
            PyErr_SetString(PyExc_TypeError, "the list argument is not list");
            return false;
        }

        for (int j = 0; j < col; j++) {
            PyObject* obj = PyList_GetItem(object, j);
            if ((obj == nullptr) || (PyObject_TypeCheck(obj, &PyLong_Type) == 0)) {
                PyErr_SetString(PyExc_TypeError, "the list argument is not list of int");
                return false;
            }
            array[i * col + j] = static_cast<T>(PyLong_AsLongLong(obj));
            CHECK_BOOL(PyErr_Occurred() == nullptr, "PyLong_AsLongLong failed", PyExc_ValueError);
        }
    }
    return true;
}

template <typename T>
bool ConvertPyListToLongArrayV2(PyObject* pyList, int row, int col, std::vector<T>& array)
{
    for (int i = 0; i < row; i++) {
        PyObject* object = PyList_GetItem(pyList, i);
        if ((object == nullptr) || (PyList_Check(object) == 0)) {
            PyErr_SetString(PyExc_TypeError, "the list argument is not list");
            return false;
        }

        for (int j = 0; j < col; j++) {
            PyObject* obj = PyList_GetItem(object, j);
            if ((obj == nullptr) || (PyObject_TypeCheck(obj, &PyLong_Type) == 0)) {
                PyErr_SetString(PyExc_TypeError, "the list argument is not list of int");
                return false;
            }
            array[i * col + j] = static_cast<T>(PyLong_AsLong(obj));
            CHECK_BOOL(PyErr_Occurred() == nullptr, "PyLong_AsLong failed", PyExc_ValueError);
        }
    }
    return true;
}

template <typename T>
bool ConvertPyListToDoubleArrayV2(PyObject* pyList, int row, int col, std::vector<T>& array)
{
    for (int i = 0; i < row; i++) {
        PyObject* object = PyList_GetItem(pyList, i);
        if (object == nullptr || (PyList_Check(object) == 0)) {
            PyErr_SetString(PyExc_TypeError, "the list argument is not list");
            return false;
        }

        for (int j = 0; j < col; j++) {
            PyObject* obj = PyList_GetItem(object, j);
            if ((obj == nullptr) || (PyObject_TypeCheck(obj, &PyFloat_Type) == 0)) {
                PyErr_SetString(PyExc_TypeError, "the list argument is not list of float/double");
                return false;
            }
            array[i * col + j] = static_cast<T>(PyFloat_AsDouble(obj));
            CHECK_BOOL(PyErr_Occurred() == nullptr, "PyFloat_AsDouble failed", PyExc_ValueError);
        }
    }
    return true;
}

#endif // WORD_UTILS_METHODS_CONTENT_H