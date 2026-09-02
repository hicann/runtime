/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "bytes_convert.h"
#include <new>
#include <vector>
#include "acl/acl.h"

PyObject* WrapBytesToPtr(PyObject* /* self */, PyObject* args)
{
    PyObject* inBytes = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "O", &inBytes), "acl.util.bytes_to_ptr args parse failed");
    CHECK_NULL(PyBytes_Check(inBytes), "needs an byte as argument", PyExc_ValueError);

    auto inData = PyBytes_AsString(inBytes);
    CHECK_NULL(inData, "convert bytes to c pointer failed", PyExc_ValueError);

    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(inData));
}

PyObject* WrapPtrToBytes(PyObject* /* self */, PyObject* args)
{
    void* ptr = nullptr;
    size_t size = 0;
    PyObject* bytesObj = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &ptr, &size), "acl.util.ptr_to_bytes args parse failed");

    bytesObj = PyBytes_FromStringAndSize(reinterpret_cast<const char*>(ptr), size);
    CHECK_NULL(bytesObj, "convert c pointer to bytes failed", PyExc_ValueError);

    return bytesObj;
}