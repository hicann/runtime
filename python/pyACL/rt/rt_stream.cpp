/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "rt_stream.h"
#include "acl/acl.h"

PyObject* WrapAclRtCreateStream(PyObject* /* self */, PyObject* /* args */)
{
    aclrtStream stream = nullptr;
    aclError ret = aclrtCreateStream(&stream);

    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(stream), ret);
}

PyObject* WrapAclRtCreateStreamWithConfig(PyObject* /* self */, PyObject* args)
{
    uint32_t priority = 0;
    uint32_t flag = 0;
    aclrtStream stream = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "ii", &priority, &flag), "acl.rt.create_stream_with_config args parse failed");

    aclError ret = aclrtCreateStreamWithConfig(&stream, priority, flag);
    return Py_BuildValue("ki", stream, ret);
}

PyObject* WrapAclRtDestroyStream(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &stream), "acl.rt.destroy_stream args parse failed");

    aclError ret = aclrtDestroyStream(stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtDestroyStreamForce(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &stream), "acl.rt.destroy_stream_force args parse failed");

    aclError ret = aclrtDestroyStreamForce(stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtSetStreamOverflowSwitch(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;
    uint32_t flag = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kI", &stream, &flag), "acl.rt.set_stream_overflow_switch args parse failed");

    aclError ret = aclrtSetStreamOverflowSwitch(stream, flag);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetStreamOverflowSwitch(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;
    uint32_t flag = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &stream), "acl.rt.get_stream_overflow_switch args parse failed");

    aclError ret = aclrtGetStreamOverflowSwitch(stream, &flag);
    return Py_BuildValue("ki", flag, ret);
}

PyObject* WrapAclRtSetStreamFailureMode(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;
    uint32_t mode = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kI", &stream, &mode), "acl.rt.set_stream_failure_mode args parse failed!");

    aclError ret = aclrtSetStreamFailureMode(stream, mode);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtStreamQuery(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;
    aclrtStreamStatus status = ACL_STREAM_STATUS_RESERVED;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &stream), "acl.rt.stream_query args parse failed!");

    aclError ret = aclrtStreamQuery(stream, &status);
    return Py_BuildValue("Ii", status, ret);
}

PyObject* WrapAclRtStreamAbort(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &stream), "acl.rt.stream_abort args parse failed");

    aclError ret = aclrtStreamAbort(stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtStreamGetId(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;
    int32_t streamId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &stream), "acl.rt.stream_get_id args parse failed");

    aclError ret = aclrtStreamGetId(stream, &streamId);
    return Py_BuildValue("ii", streamId, ret);
}

PyObject* WrapAclRtGetStreamAvailableNum(PyObject* /* self */, PyObject* /* args */)
{
    uint32_t streamCount = 0;

    aclError ret = aclrtGetStreamAvailableNum(&streamCount);
    return Py_BuildValue("Ii", streamCount, ret);
}

static bool GetStreamAttrValueFromPyUnion(PyObject* pyDict, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue& value)
{
    CHECK_STRUCT_DICT(pyDict, "the aclrtStreamAttrValue argument is not dict");
    if (stmAttrType == ACL_STREAM_ATTR_FAILURE_MODE) {
        CHECK_BOOL(GetValueFromPyDict(pyDict, "failureMode", value.failureMode));
    } else if (stmAttrType == ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK) {
        CHECK_BOOL(GetValueFromPyDict(pyDict, "overflowSwitch", value.overflowSwitch));
    } else if (stmAttrType == ACL_STREAM_ATTR_USER_CUSTOM_TAG) {
        CHECK_BOOL(GetValueFromPyDict(pyDict, "userCustomTag", value.userCustomTag));
    } else {
        CHECK_BOOL(GetValueFromPyDict(pyDict, "reserved", value.reserve, sizeof(value.reserve) / sizeof(uint32_t)));
    }
    return true;
}

PyObject* WrapAclRtSetStreamAttribute(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;
    aclrtStreamAttr stmAttrType = ACL_STREAM_ATTR_FAILURE_MODE;
    PyObject* pyValue = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kiO", &stream, &stmAttrType, &pyValue),
        "acl.rt.set_stream_attribute args parse failed!");

    aclrtStreamAttrValue value = {};
    CHECK_NULL(GetStreamAttrValueFromPyUnion(pyValue, stmAttrType, value));

    aclError ret = aclrtSetStreamAttribute(stream, stmAttrType, &value);
    return Py_BuildValue("i", ret);
}

static PyObject* GetPyUnionFromStreamAttrValue(aclrtStreamAttrValue value, aclrtStreamAttr stmAttrType)
{
    PyObject* pyDict = PyDict_New();

    if (stmAttrType == ACL_STREAM_ATTR_FAILURE_MODE) {
        CHECK_NULL(SetItemToDict(pyDict, "failureMode", Py_BuildValue("K", value.failureMode)));
    } else if (stmAttrType == ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK) {
        CHECK_NULL(SetItemToDict(pyDict, "overflowSwitch", Py_BuildValue("I", value.overflowSwitch)));
    } else if (stmAttrType == ACL_STREAM_ATTR_USER_CUSTOM_TAG) {
        CHECK_NULL(SetItemToDict(pyDict, "userCustomTag", Py_BuildValue("I", value.userCustomTag)));
    } else {
        CHECK_NULL(SetItemToDict(
            pyDict, "reserved", GetPyListFromArray(value.reserve, sizeof(value.reserve) / sizeof(uint32_t))));
    }

    return pyDict;
}

PyObject* WrapAclRtGetStreamAttribute(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;
    aclrtStreamAttr stmAttrType = ACL_STREAM_ATTR_FAILURE_MODE;
    aclrtStreamAttrValue value = {};

    CHECK_NULL(PyArg_ParseTuple(args, "ki", &stream, &stmAttrType), "acl.rt.get_stream_attribute args parse failed!");

    aclError ret = aclrtGetStreamAttribute(stream, stmAttrType, &value);

    PyObject* pyUnion = GetPyUnionFromStreamAttrValue(value, stmAttrType);
    CHECK_NULL(pyUnion);
    PyObject* obj = Py_BuildValue("Oi", pyUnion, ret);
    Py_XDECREF(pyUnion);
    return obj;
}

PyObject* WrapAclRtGetStreamResLimit(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;
    aclrtDevResLimitType type = ACL_RT_DEV_RES_CUBE_CORE;
    uint32_t value = 0;
    CHECK_NULL(PyArg_ParseTuple(args, "ki", &stream, &type), "acl.rt.get_stream_res_limit parse failed");
    aclError ret = aclrtGetStreamResLimit(stream, type, &value);
    return Py_BuildValue("Ii", value, ret);
}

PyObject* WrapAclRtSetStreamResLimit(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;
    aclrtDevResLimitType type = ACL_RT_DEV_RES_CUBE_CORE;
    uint32_t value = 0;
    CHECK_NULL(PyArg_ParseTuple(args, "kiI", &stream, &type, &value), "acl.rt.set_stream_res_limit parse failed");
    aclError ret = aclrtSetStreamResLimit(stream, type, value);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtResetStreamResLimit(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;
    CHECK_NULL(PyArg_ParseTuple(args, "k", &stream), "acl.rt.reset_stream_res_limit parse failed");
    aclError ret = aclrtResetStreamResLimit(stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtUseStreamResInCurrentThread(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;
    CHECK_NULL(PyArg_ParseTuple(args, "k", &stream), "acl.rt.use_stream_res_in_current_thread parse failed");
    aclError ret = aclrtUseStreamResInCurrentThread(stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtUnuseStreamResInCurrentThread(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;
    CHECK_NULL(PyArg_ParseTuple(args, "k", &stream), "acl.rt.unuse_stream_res_in_current_thread parse failed");
    aclError ret = aclrtUnuseStreamResInCurrentThread(stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetResInCurrentThread(PyObject* /* self */, PyObject* args)
{
    aclrtDevResLimitType type = ACL_RT_DEV_RES_CUBE_CORE;
    uint32_t value = 0;
    CHECK_NULL(PyArg_ParseTuple(args, "i", &type), "acl.rt.get_res_in_current_thread parse failed");
    aclError ret = aclrtGetResInCurrentThread(type, &value);
    return Py_BuildValue("Ii", value, ret);
}