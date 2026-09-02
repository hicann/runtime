/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "rt_allocator.h"
#include "acl/acl.h"
#include "acl/acl_rt_allocator.h"

namespace {
PyObject* g_allocFunc = nullptr;
PyObject* g_freeFunc = nullptr;
PyObject* g_allocAdviseFunc = nullptr;
PyObject* g_setGetAddrFunc = nullptr;
} // namespace

PyObject* WrapAclRtAllocatorCreateDesc(PyObject* /* self */, PyObject* /* args */)
{
    aclrtAllocatorDesc desc = aclrtAllocatorCreateDesc();
    return Py_BuildValue("k", desc);
}

PyObject* WrapAclRtAllocatorDestroyDesc(PyObject* /* self */, PyObject* args)
{
    aclrtAllocatorDesc desc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &desc), "acl.rt.allocator_destroy_desc args parse failed");

    aclError ret = aclrtAllocatorDestroyDesc(desc);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtAllocatorSetObjToDesc(PyObject* /* self */, PyObject* args)
{
    aclrtAllocatorDesc desc = nullptr;
    aclrtAllocator allocator = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &desc, &allocator), "acl.rt.allocator_set_obj_to_desc args parse failed");

    aclError ret = aclrtAllocatorSetObjToDesc(desc, &allocator);
    return Py_BuildValue("i", ret);
}

static void* AllocatorAllocFunc(const aclrtAllocator allocator, const size_t size)
{
    PyGILState_STATE state = PyGILState_Ensure();
    PyObject* argslist = Py_BuildValue("kI", allocator, size);

    PyObject* result = PyObject_CallObject(g_allocFunc, argslist);

    Py_XDECREF(argslist);
    if (result == nullptr) {
        ACL_APP_LOG(ACL_ERROR, "AllocatorAllocFunc wrong out");
        PyGILState_Release(state);
        return nullptr;
    }
    Py_XDECREF(result);
    PyGILState_Release(state);
    return nullptr;
}

PyObject* WrapAclRtAllocatorSetAllocFuncToDesc(PyObject* /* self */, PyObject* args)
{
    aclrtAllocatorDesc desc = nullptr;
    PyObject* pyFunc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kO", &desc, &pyFunc), "acl.rt.allocator_set_alloc_func_to_desc args parse failed");

    aclError ret = aclrtAllocatorSetAllocFuncToDesc(desc, AllocatorAllocFunc);
    if (ret == ACL_SUCCESS) {
        if (g_allocFunc != nullptr) {
            Py_XDECREF(g_allocFunc);
        }
        Py_XINCREF(pyFunc);
        g_allocFunc = pyFunc;
    }
    return Py_BuildValue("i", ret);
}

static void AllocatorFreeFunc(const aclrtAllocator allocator, const aclrtAllocatorBlock block)
{
    PyGILState_STATE state = PyGILState_Ensure();
    PyObject* argslist = Py_BuildValue("kk", allocator, block);

    PyObject* result = PyObject_CallObject(g_freeFunc, argslist);

    Py_XDECREF(argslist);
    if (result == nullptr) {
        ACL_APP_LOG(ACL_ERROR, "AllocatorFreeFunc wrong out");
        PyGILState_Release(state);
        return;
    }
    Py_XDECREF(result);
    PyGILState_Release(state);
    return;
}

PyObject* WrapAclRtAllocatorSetFreeFuncToDesc(PyObject* /* self */, PyObject* args)
{
    aclrtAllocatorDesc desc = nullptr;
    PyObject* pyFunc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kO", &desc, &pyFunc), "acl.rt.allocator_set_free_func_to_desc args parse failed");

    aclError ret = aclrtAllocatorSetFreeFuncToDesc(desc, AllocatorFreeFunc);
    if (ret == ACL_SUCCESS) {
        if (g_freeFunc != nullptr) {
            Py_XDECREF(g_freeFunc);
        }
        Py_XINCREF(pyFunc);
        g_freeFunc = pyFunc;
    }
    return Py_BuildValue("i", ret);
}

static void* AllocatorAllocAdviseFunc(const aclrtAllocator allocator, const size_t size, const aclrtAllocatorAddr addr)
{
    PyGILState_STATE state = PyGILState_Ensure();
    PyObject* argslist = Py_BuildValue("kIk", allocator, size, addr);

    PyObject* result = PyObject_CallObject(g_allocAdviseFunc, argslist);

    Py_XDECREF(argslist);
    if (result == nullptr) {
        ACL_APP_LOG(ACL_ERROR, "AllocatorAllocAdviseFunc wrong out");
        PyGILState_Release(state);
        return nullptr;
    }
    Py_XDECREF(result);
    PyGILState_Release(state);
    return nullptr;
}

PyObject* WrapAclRtAllocatorSetAllocAdviseFuncToDesc(PyObject* /* self */, PyObject* args)
{
    aclrtAllocatorDesc desc = nullptr;
    PyObject* pyFunc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kO", &desc, &pyFunc),
        "acl.rt.allocator_set_alloc_advise_func_to_desc args parse failed");

    aclError ret = aclrtAllocatorSetAllocAdviseFuncToDesc(desc, AllocatorAllocAdviseFunc);
    if (ret == ACL_SUCCESS) {
        if (g_allocAdviseFunc != nullptr) {
            Py_XDECREF(g_allocAdviseFunc);
        }
        Py_XINCREF(pyFunc);
        g_allocAdviseFunc = pyFunc;
    }
    return Py_BuildValue("i", ret);
}

static void* AllocatorSetGetAddrFromBlockFunc(const aclrtAllocatorBlock block)
{
    PyGILState_STATE state = PyGILState_Ensure();
    PyObject* argslist = Py_BuildValue("k", block);

    PyObject* result = PyObject_CallObject(g_setGetAddrFunc, argslist);

    Py_XDECREF(argslist);
    if (result == nullptr) {
        ACL_APP_LOG(ACL_ERROR, "AllocatorSetGetAddrFromBlockFunc wrong out");
        PyGILState_Release(state);
        return nullptr;
    }
    Py_XDECREF(result);
    PyGILState_Release(state);
    return nullptr;
}

PyObject* WrapAclRtAllocatorSetGetAddrFromBlockFuncToDesc(PyObject* /* self */, PyObject* args)
{
    aclrtAllocatorDesc desc = nullptr;
    PyObject* pyFunc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kO", &desc, &pyFunc),
        "acl.rt.allocator_set_get_addr_from_block_func_to_desc args parse failed");

    aclError ret = aclrtAllocatorSetGetAddrFromBlockFuncToDesc(desc, AllocatorSetGetAddrFromBlockFunc);
    if (ret == ACL_SUCCESS) {
        if (g_setGetAddrFunc != nullptr) {
            Py_XDECREF(g_setGetAddrFunc);
        }
        Py_XINCREF(pyFunc);
        g_setGetAddrFunc = pyFunc;
    }
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtAllocatorRegister(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;
    aclrtAllocatorDesc desc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &stream, &desc), "acl.rt.allocator_register args parse failed");

    aclError ret = aclrtAllocatorRegister(stream, desc);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtAllocatorUnregister(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &stream), "acl.rt.allocator_unregister args parse failed");

    aclError ret = aclrtAllocatorUnregister(stream);
    return Py_BuildValue("i", ret);
}