/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "rt_group.h"
#ifdef USE_MDL
#include <acl/acl.h>

PyObject* WrapAclRtSetGroup(PyObject* /* self */, PyObject* args)
{
    uint32_t groupId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "I", &groupId), "acl.rt.set_group args parse failed");

    aclError ret = aclrtSetGroup(groupId);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetGroupCount(PyObject* /* self */, PyObject* args)
{
    uint32_t count = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "I", &count), "acl.rt.get_group_count args parse failed");

    aclError ret = aclrtGetGroupCount(&count);
    return Py_BuildValue("Ii", count, ret);
}

PyObject* WrapAclRtCreateGroupInfo(PyObject* /* self */, PyObject* /* args */)
{
    aclrtGroupInfo* groupInfo = aclrtCreateGroupInfo();
    return Py_BuildValue("k", groupInfo);
}

PyObject* WrapAclRtDestroyGroupInfo(PyObject* /* self */, PyObject* args)
{
    aclrtGroupInfo* groupInfo = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &groupInfo), "acl.rt.destroy_group_info args parse failed");

    aclError ret = aclrtDestroyGroupInfo(groupInfo);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetAllGroupInfo(PyObject* /* self */, PyObject* args)
{
    aclrtGroupInfo* groupInfo = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &groupInfo), "acl.rt.get_all_group_info args parse failed");

    aclError ret = aclrtGetAllGroupInfo(groupInfo);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetGroupInfoDetail(PyObject* /* self */, PyObject* args)
{
    const aclrtGroupInfo* groupInfo = nullptr;
    int32_t groupId = 0;
    aclrtGroupAttr attr = ACL_GROUP_AICORE_INT;
    int32_t attrValue[0x100];
    const size_t valueLen = 0x100;
    size_t paramRetRize = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kii", &groupInfo, &groupId, &attr), "acl.rt.get_group_info_detail args parse failed");

    aclError ret = aclrtGetGroupInfoDetail(groupInfo, groupId, attr, attrValue, valueLen, &paramRetRize);
    if (ret != 0 || paramRetRize == 0) {
        ACL_APP_LOG(ACL_ERROR, "aclrtGetGroupInfoDetail failed, paramRetRize = %d, ret = %d", paramRetRize, ret);
        PyErr_SetString(PyExc_RuntimeError, "aclrtGetGroupInfoDetail failed");
        return nullptr;
    }
    PyObject* pList = PyList_New(paramRetRize); // new reference
    CHECK_NULL(pList, "memory malloc failed", PyExc_MemoryError);

    for (size_t i = 0; i < paramRetRize; ++i) {
        PyList_SetItem(pList, i, Py_BuildValue("i", attrValue[i])); // NPY_INT
    }

    PyObject* obj = Py_BuildValue("Oi", pList, ret);
    Py_XDECREF(pList);
    return obj;
}
#endif // USE_MDL