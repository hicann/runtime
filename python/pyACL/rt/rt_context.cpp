/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "rt_context.h"
#include "acl/acl.h"

PyObject* WrapAclRtCreateContext(PyObject* /* self */, PyObject* args)
{
    int deviceId = 0;
    aclrtContext context = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &deviceId), "acl.rt.create_context args parse failed");

    aclError ret = aclrtCreateContext(&context, deviceId);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(context), ret);
}

PyObject* WrapAclRtDestroyContext(PyObject* /* self */, PyObject* args)
{
    aclrtContext context = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &context), "acl.rt.destroy_context args parse failed");

    aclError ret = aclrtDestroyContext(context);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtSetCurrentContext(PyObject* /* self */, PyObject* args)
{
    aclrtContext context = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &context), "acl.rt.set_context args parse failed");

    aclError ret = aclrtSetCurrentContext(context);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetCurrentContext(PyObject* /* self */, PyObject* /* args */)
{
    aclrtContext context = nullptr;

    aclError ret = aclrtGetCurrentContext(&context);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(context), ret);
}

PyObject* WrapAclRtGetOverflowStatus(PyObject* /* self */, PyObject* args)
{
    void* outputAddr = nullptr;
    size_t outputSize = 0;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkk", &outputAddr, &outputSize, &stream),
        "acl.rt.get_overflow_status args parse failed!");

    aclError ret = aclrtGetOverflowStatus(outputAddr, outputSize, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtResetOverflowStatus(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &stream), "acl.rt.reset_overflow_status args parse failed!");

    aclError ret = aclrtResetOverflowStatus(stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtCtxSetSysParamOpt(PyObject* /* self */, PyObject* args)
{
    aclSysParamOpt opt = ACL_OPT_DETERMINISTIC;
    int64_t value = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "il", &opt, &value), "acl.rt.ctx_set_sys_param_opt args parse failed");

    aclError ret = aclrtCtxSetSysParamOpt(opt, value);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtCtxGetSysParamOpt(PyObject* /* self */, PyObject* args)
{
    aclSysParamOpt opt = ACL_OPT_DETERMINISTIC;
    int64_t value = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &opt), "acl.rt.ctx_get_sys_param_opt args parse failed");

    aclError ret = aclrtCtxGetSysParamOpt(opt, &value);
    return Py_BuildValue("li", value, ret);
}

PyObject* WrapAclRtSetSysParamOpt(PyObject* /* self */, PyObject* args)
{
    aclSysParamOpt opt = ACL_OPT_DETERMINISTIC;
    int64_t value = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "il", &opt, &value), "acl.rt.set_sys_param_opt args parse faild");

    aclError ret = aclrtSetSysParamOpt(opt, value);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetSysParamOpt(PyObject* /* self */, PyObject* args)
{
    aclSysParamOpt opt = ACL_OPT_DETERMINISTIC;
    int64_t value = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &opt), "acl.rt.get_sys_param_opt args parse faild");

    aclError ret = aclrtGetSysParamOpt(opt, &value);
    return Py_BuildValue("li", value, ret);
}

PyObject* WrapAclRtCtxGetCurrentDefaultStream(PyObject* /* self */, PyObject* /* args */)
{
    aclrtStream stream = nullptr;

    aclError ret = aclrtCtxGetCurrentDefaultStream(&stream);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(stream), ret);
}

PyObject* WrapAclRtCtxGetPrimaryCtxState(PyObject* /* self */, PyObject* args)
{
    int32_t deviceId = 0;
    uint32_t* flags = nullptr;
    int32_t active = 0;
    CHECK_NULL(PyArg_ParseTuple(args, "i", &deviceId), "acl.rt.get_primary_ctx_state args parse failed");
    aclError ret = aclrtGetPrimaryCtxState(deviceId, flags, &active);
    return Py_BuildValue("iki", active, flags, ret);
}