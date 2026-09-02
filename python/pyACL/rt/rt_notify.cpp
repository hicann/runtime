/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "rt_notify.h"
#include "acl/acl.h"

constexpr int64_t MAX_UINT32_PLUS_ONE = 4294967296;

PyObject* WrapAclRtCreateNotify(PyObject* /* self */, PyObject* args)
{
    aclrtNotify notify = nullptr;
    uint64_t flag = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "K", &flag), "acl.rt.create_notify args parse failed");

    aclError ret = aclrtCreateNotify(&notify, flag);
    return Py_BuildValue("ki", notify, ret);
}

PyObject* WrapAclRtDestroyNotify(PyObject* /* self */, PyObject* args)
{
    aclrtNotify notify = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &notify), "acl.rt.destroy_notify args parse failed");

    aclError ret = aclrtDestroyNotify(notify);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtRecordNotify(PyObject* /* self */, PyObject* args)
{
    aclrtNotify notify = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &notify, &stream), "acl.rt.record_notify args parse failed");

    aclError ret = aclrtRecordNotify(notify, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtWaitAndResetNotify(PyObject* /* self */, PyObject* args)
{
    aclrtNotify notify = nullptr;
    aclrtStream stream = nullptr;
    int64_t timeout = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkL", &notify, &stream, &timeout), "acl.rt.wait_and_reset_notify args parse failed");

    CHECK_NULL(timeout >= 0, "timeout can't be a negative number!")
    CHECK_NULL(timeout < MAX_UINT32_PLUS_ONE, "timeout should be less than 2**32!")

    aclError ret = aclrtWaitAndResetNotify(notify, stream, static_cast<uint32_t>(timeout));
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetNotifyId(PyObject* /* self */, PyObject* args)
{
    aclrtNotify notify = nullptr;
    uint32_t notifyId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &notify), "acl.rt.get_notify_id args parse failed");

    aclError ret = aclrtGetNotifyId(notify, &notifyId);
    return Py_BuildValue("Ii", notifyId, ret);
}

static bool GetNotifyPointersFromPyList(PyObject* object, std::vector<void*>& notifies)
{
    CHECK_BOOL(PyList_Check(object), "argument 1 only support the format of list", PyExc_ValueError);

    int numValues = static_cast<int>(PyList_Size(object));
    notifies.resize(numValues + 1);

    for (int i = 0; i < numValues; i++) {
        PyObject* objectItem = PyList_GetItem(object, i);
        if ((objectItem == nullptr) || (PyObject_TypeCheck(objectItem, &PyLong_Type) == 0)) {
            PyErr_SetString(PyExc_TypeError, "all elements must be integers");
            return false;
        }

        uintptr_t address = PyLong_AsUnsignedLongLong(objectItem);
        if (PyErr_Occurred()) {
            PyErr_SetString(PyExc_ValueError, "PyLong_AsUnsignedLongLong failed");
            return false;
        }

        notifies[i] = reinterpret_cast<void*>(address);
    }

    return true;
}

PyObject* WrapAclRtNotifyBatchReset(PyObject* /* self */, PyObject* args)
{
    PyObject* pyNotifies = nullptr;
    CHECK_NULL(PyArg_ParseTuple(args, "O", &pyNotifies), "acl.rt.notify_batch_reset args parse failed");
    CHECK_NULL(PyList_Check(pyNotifies), "argument only support the format of list", PyExc_ValueError);

    std::vector<aclrtNotify> notifies;
    CHECK_NULL(
        GetNotifyPointersFromPyList(pyNotifies, notifies), "get notify pointers from PyList failed", PyExc_ValueError);
    size_t num = static_cast<size_t>(PyList_Size(pyNotifies));

    aclError ret = aclrtNotifyBatchReset(notifies.data(), num);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtNotifyGetExportKey(PyObject* /* self */, PyObject* args)
{
    aclrtNotify notify = nullptr;
    size_t len = 0;
    uint64_t flag = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kkK", &notify, &len, &flag), "acl.rt.notify_get_export_key args parse failed");

    const size_t maxKeyLen = 1024;
    CHECK_NULL(len < maxKeyLen, "key len should be less than 1024", PyExc_ValueError);
    std::vector<char> key(len + 1);

    aclError ret = aclrtNotifyGetExportKey(notify, key.data(), len, flag);
    return Py_BuildValue("si", key.data(), ret);
}

PyObject* WrapAclRtNotifySetImportPid(PyObject* /* self */, PyObject* args)
{
    aclrtNotify notify = nullptr;
    PyObject* pyPids = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kO", &notify, &pyPids), "acl.rt.notify_set_import_pid args parse failed");
    CHECK_NULL(PyList_Check(pyPids), "argument 2 only support the format of list", PyExc_ValueError);

    std::vector<int32_t> pids;
    CHECK_NULL(GetValuesFromPyList(pyPids, pids), "get values from PyList failed", PyExc_ValueError);
    size_t num = static_cast<size_t>(PyList_Size(pyPids));

    aclError ret = aclrtNotifySetImportPid(notify, pids.data(), num);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtNotifyImportByKey(PyObject* /* self */, PyObject* args)
{
    aclrtNotify notify = nullptr;
    const char* key = nullptr;
    uint64_t flag = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "sK", &key, &flag), "acl.rt.notify_import_by_key args parse failed");
    aclError ret = aclrtNotifyImportByKey(&notify, key, flag);
    return Py_BuildValue("ki", notify, ret);
}