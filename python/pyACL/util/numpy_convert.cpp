/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "numpy_convert.h"
#include <vector>
#define NPY_NO_DEPRECATED_API NPY_1_7_API_VERSION
#pragma GCC diagnostic ignored "-Wcast-qual"
#pragma GCC diagnostic ignored "-Wconversion"
#include <numpy/arrayobject.h>
#include "acl/acl.h"

PyObject* WrapNumpyToPtr(PyObject* /* self */, PyObject* args)
{
    constexpr int stackLevel = 1;
    PyErr_WarnEx(
        PyExc_Warning,
        "acl.util.numpy_to_ptr will be deprecated. "
        "Please use acl.util.bytes_to_ptr instead.",
        stackLevel);
    import_array();
    PyObject* inArg = nullptr;
    PyArrayObject* inArr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "O", &inArg), "acl.util.numpy_to_ptr args parse failed");
    CHECK_NULL(PyArray_Check(inArg), "needs an ndarray as argument", PyExc_ValueError);

    inArr = reinterpret_cast<PyArrayObject*>(inArg); // PyArray_FROM_OF
    if (PyArray_ISCONTIGUOUS(inArr) == 0) {
        PyErr_WarnEx(
            PyExc_Warning,
            "The input ndarray is discontiguous. "
            "Please use acl.util.bytes_to_ptr instead.",
            stackLevel);
    }

    auto inData = PyArray_BYTES(inArr); // PyArray_DATA
    // check nullptr
    CHECK_NULL(inData, "convert numpy object to c pointer failed", PyExc_ValueError);
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(inData));
}

PyObject* WrapNumpyContiguousToPtr(PyObject* /* self */, PyObject* args)
{
    constexpr int stackLevel = 1;
    PyErr_WarnEx(
        PyExc_Warning,
        "acl.util.numpy_contiguous_to_ptr will be deprecated. "
        "Please use acl.util.bytes_to_ptr instead.",
        stackLevel);
    import_array();
    PyObject* inArg = nullptr;
    PyArrayObject* inArr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "O", &inArg), "acl.util.numpy_contiguous_to_ptr args parse failed");

    CHECK_NULL(PyArray_Check(inArg), "needs an ndarray as argument", PyExc_ValueError);

    inArr = reinterpret_cast<PyArrayObject*>(inArg); // PyArray_FROM_OF
    PyArrayObject* arrContiguous = PyArray_GETCONTIGUOUS(inArr);
    CHECK_NULL(arrContiguous, "convert input to a contiguous ndarray failed", PyExc_ValueError);

    auto inData = PyArray_BYTES(arrContiguous); // PyArray_DATA
    // check nullptr
    CHECK_NULL(inData, "convert numpy object to c pointer failed", PyExc_ValueError);

    PyObject* obj = Py_BuildValue("kO", reinterpret_cast<uintptr_t>(inData), arrContiguous);
    Py_XDECREF(arrContiguous);
    return obj;
}

PyObject* WrapPtrToNumpy(PyObject* self, PyObject* args)
{
    constexpr int stackLevel = 1;
    PyErr_WarnEx(
        PyExc_Warning,
        "acl.util.ptr_to_numpy will be deprecated. "
        "Please use acl.util.ptr_to_bytes instead.",
        stackLevel);
    import_array();
    void* ptr = nullptr;
    int dataType = 0;
    PyObject* pyInputsTuple = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kOi", &ptr, &pyInputsTuple, &dataType), "acl.util.ptr_to_numpy args parse failed");

    int inputsSize = static_cast<int>(PyTuple_Size(pyInputsTuple));
    CHECK_NULL(inputsSize >= 0, "shape is empty", PyExc_ValueError);

    std::vector<npy_intp> dims(inputsSize + 1);
    for (int i = 0; i < inputsSize; i++) {
        PyObject* object = PyTuple_GetItem(pyInputsTuple, i);
        CHECK_NULL(
            (object && (PyObject_TypeCheck(object, &PyLong_Type) != 0)), "the second argument is not list of int");
        dims[i] = reinterpret_cast<npy_intp>(PyLong_AsVoidPtr(object));
        CHECK_NULL(PyErr_Occurred() == nullptr, "PyLong_AsVoidPtr failed", PyExc_ValueError);
    }

    PyObject* outPut = PyArray_NewFromDescr(
        &PyArray_Type, PyArray_DescrFromType(static_cast<NPY_TYPES>(dataType)), inputsSize, dims.data(), nullptr, ptr,
        NPY_ARRAY_WRITEABLE, self);

    PyObject* obj = Py_BuildValue("O", outPut);
    Py_XDECREF(outPut);
    return obj;
}