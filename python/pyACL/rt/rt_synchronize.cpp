/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "rt_synchronize.h"
#include "acl/acl.h"

PyObject* WrapAclRtCreateEvent(PyObject* /* self */, PyObject* /* args */)
{
    aclrtEvent event = nullptr;
    aclError ret = aclrtCreateEvent(&event);

    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(event), ret);
}

PyObject* WrapAclRtCreateEventWithFlag(PyObject* /* self */, PyObject* args)
{
    uint32_t flag = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "I", &flag), "acl.rt.create_event_with_flag args parse failed");

    aclrtEvent event = nullptr;
    aclError ret = aclrtCreateEventWithFlag(&event, flag);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(event), ret);
}

PyObject* WrapAclRtCreateEventExWithFlag(PyObject* /* self */, PyObject* args)
{
    uint32_t flag = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "I", &flag), "acl.rt.create_event_ex_with_flag args parse failed");

    aclrtEvent event = nullptr;
    aclError ret = aclrtCreateEventExWithFlag(&event, flag);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(event), ret);
}

PyObject* WrapAclRtDestroyEvent(PyObject* /* self */, PyObject* args)
{
    aclrtEvent event = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &event), "acl.rt.destroy_event args parse failed");

    aclError ret = aclrtDestroyEvent(event);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtSynchronizeStream(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &stream), "acl.rt.synchronize_stream args parse failed");

    aclError ret = 0;
    {
        PyThreadState* state = PyEval_SaveThread();
        ret = aclrtSynchronizeStream(stream);
        PyEval_RestoreThread(state);
    }

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtSynchronizeStreamWithTimeout(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;
    int32_t timeout = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ki", &stream, &timeout), "acl.rt.synchronize_stream_with_timeout args parse failed");

    aclError ret = 0;
    {
        PyThreadState* state = PyEval_SaveThread();
        ret = aclrtSynchronizeStreamWithTimeout(stream, timeout);
        PyEval_RestoreThread(state);
    }
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtProcessReport(PyObject* /* self */, PyObject* args)
{
    int32_t timeout = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &timeout), "acl.rt.process_report args parse failed");

    aclError ret = 0;
    {
        PyThreadState* state = PyEval_SaveThread();
        ret = aclrtProcessReport(timeout);
        PyEval_RestoreThread(state);
    }

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtSubscribeReport(PyObject* /* self */, PyObject* args)
{
    uint64_t threadId = 0;
    aclrtStream stream = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "Kk", &threadId, &stream), "acl.rt.subscribe_report args parse failed");

    aclError ret = aclrtSubscribeReport(threadId, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtUnSubscribeReport(PyObject* /* self */, PyObject* args)
{
    uint64_t threadId = 0;
    aclrtStream stream = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "Kk", &threadId, &stream), "acl.rt.unsubscribe_report args parse failed");

    aclError ret = aclrtUnSubscribeReport(threadId, stream);
    return Py_BuildValue("i", ret);
}

struct PyFuncStruct {
    PyObject* pyFunc = nullptr;
    PyObject* pyFuncArgs = nullptr;
};

static void LaunchCallFunc(void* userData)
{
    PyGILState_STATE state = PyGILState_Ensure();
    ACL_APP_LOG(ACL_DEBUG, "LaunchCallFunc in");
    if (userData == nullptr) {
        ACL_APP_LOG(ACL_ERROR, "LaunchCallFunc args error");
        return;
    }
    auto data = (PyFuncStruct*)userData;
    PyObject* argslist = Py_BuildValue("(O)", data->pyFuncArgs);

    PyObject* result = PyObject_CallObject(data->pyFunc, argslist);
    ACL_APP_LOG(ACL_DEBUG, "PyObject_CallObject ok");

    Py_XDECREF(argslist);
    Py_XDECREF(data->pyFunc);
    Py_XDECREF(data->pyFuncArgs);
    if (result == nullptr) {
        delete data;
        data = nullptr;
        ACL_APP_LOG(ACL_ERROR, "LaunchCallFunc wrong out");
        PyGILState_Release(state);
        return;
    }
    Py_XDECREF(result);
    delete data;
    data = nullptr;
    ACL_APP_LOG(ACL_DEBUG, "LaunchCallFunc out");
    PyGILState_Release(state);
    return;
}

PyObject* WrapAclRtLaunchCallback(PyObject* /* self */, PyObject* args)
{
    PyObject* fn = nullptr;
    PyObject* pyInputsList = nullptr;
    int blockType = 0;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "OOik", &fn, &pyInputsList, &blockType, &stream),
        "acl.rt.launch_callback args parse failed");

    CHECK_NULL(PyCallable_Check(fn), "parameter must be callable");

    Py_XINCREF(fn);
    Py_XINCREF(pyInputsList);

    // set callback
    auto data = new (std::nothrow) PyFuncStruct;
    CHECK_NULL(data, "new failed", PyExc_MemoryError);
    data->pyFunc = fn;
    data->pyFuncArgs = pyInputsList;

    aclError ret = aclrtLaunchCallback(
        LaunchCallFunc, static_cast<void*>(data), static_cast<aclrtCallbackBlockType>(blockType), stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtSynchronizeDevice(PyObject* /* self */, PyObject* /* args */)
{
    aclError ret = 0;
    {
        PyThreadState* state = PyEval_SaveThread();
        ret = aclrtSynchronizeDevice();
        PyEval_RestoreThread(state);
    }

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtRecordEvent(PyObject* /* self */, PyObject* args)
{
    aclrtEvent event = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &event, &stream), "acl.rt.record_event args parse failed");

    aclError ret = aclrtRecordEvent(event, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtResetEvent(PyObject* /* self */, PyObject* args)
{
    aclrtEvent event = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &event, &stream), "acl.rt.reset_event args parse failed");

    aclError ret = aclrtResetEvent(event, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtQueryEvent(PyObject* /* self */, PyObject* args)
{
    aclrtEvent event = nullptr;
    aclrtEventStatus status = ACL_EVENT_STATUS_COMPLETE;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &event), "acl.rt.query_event args parse failed");

    aclError ret = aclrtQueryEvent(event, &status);
    return Py_BuildValue("Ii", static_cast<unsigned int>(status), ret); // review
}

PyObject* WrapAclRtQueryEventStatus(PyObject* /* self */, PyObject* args)
{
    aclrtEvent event = nullptr;
    aclrtEventRecordedStatus status = ACL_EVENT_RECORDED_STATUS_NOT_READY;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &event), "acl.rt.query_event_status args parse failed");

    aclError ret = aclrtQueryEventStatus(event, &status);
    return Py_BuildValue("Ii", static_cast<unsigned int>(status), ret); // review
}

PyObject* WrapAclRtQueryEventWaitStatus(PyObject* /* self */, PyObject* args)
{
    aclrtEvent event = nullptr;
    aclrtEventWaitStatus status = ACL_EVENT_WAIT_STATUS_COMPLETE;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &event), "acl.rt.query_event_wait_status args parse failed");

    aclError ret = aclrtQueryEventWaitStatus(event, &status);
    return Py_BuildValue("ki", status, ret);
}

PyObject* WrapAclRtSynchronizeEvent(PyObject* /* self */, PyObject* args)
{
    aclrtEvent event = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &event), "acl.rt.synchronize_event args parse failed");

    aclError ret = 0;
    {
        PyThreadState* state = PyEval_SaveThread();
        ret = aclrtSynchronizeEvent(event);
        PyEval_RestoreThread(state);
    }

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtSynchronizeEventWithTimeout(PyObject* /* self */, PyObject* args)
{
    aclrtEvent event = nullptr;
    int32_t timeout = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ki", &event, &timeout), "acl.rt.synchronize_event_with_timeout args parse failed!");

    aclError ret = 0;
    {
        PyThreadState* state = PyEval_SaveThread();
        ret = aclrtSynchronizeEventWithTimeout(event, timeout);
        PyEval_RestoreThread(state);
    }

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtEventElapsedTime(PyObject* /* self */, PyObject* args)
{
    aclrtEvent start = nullptr;
    aclrtEvent end = nullptr;
    float ms = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &start, &end), "acl.rt.event_elapsed_time args parse failed");

    aclError ret = aclrtEventElapsedTime(&ms, start, end);
    return Py_BuildValue("fi", ms, ret); // review
}

PyObject* WrapAclRtEventGetTimestamp(PyObject* /* self */, PyObject* args)
{
    aclrtEvent event = nullptr;
    uint64_t timestamp = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &event), "acl.rt.event_get_timestamp args parse failed");

    aclError ret = aclrtEventGetTimestamp(event, &timestamp);
    return Py_BuildValue("Ki", timestamp, ret);
}

PyObject* WrapAclRtGetEventId(PyObject* /* self */, PyObject* args)
{
    aclrtEvent event = nullptr;
    uint32_t eventId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &event, "acl.rt.get_event_id args parse failed"));

    aclError ret = aclrtGetEventId(event, &eventId);
    return Py_BuildValue("ki", eventId, ret);
}

PyObject* WrapAclRtGetEventAvailNum(PyObject* /* self */, PyObject* /* args */)
{
    uint32_t eventCount = 0;

    aclError ret = aclrtGetEventAvailNum(&eventCount);
    return Py_BuildValue("ki", eventCount, ret);
}

PyObject* WrapAclRtStreamWaitEvent(PyObject* /* self */, PyObject* args)
{
    aclrtStream stream = nullptr;
    aclrtEvent event = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &stream, &event), "acl.rt.stream_wait_event args parse failed");

    aclError ret = 0;
    {
        PyThreadState* state = PyEval_SaveThread();
        ret = aclrtStreamWaitEvent(stream, event);
        PyEval_RestoreThread(state);
    }

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetThreadLastTaskId(PyObject* /* self */, PyObject* /* args */)
{
    uint32_t taskId = 0;
    aclError ret = 0;

    ret = aclrtGetThreadLastTaskId(&taskId);

    return Py_BuildValue("Ki", taskId, ret);
}

PyObject* WrapAclRtReduceAsync(PyObject* /* self */, PyObject* args)
{
    void* dst = nullptr;
    const void* src = nullptr;
    uint64_t count = 0;
    aclrtReduceKind kind = ACL_RT_MEMCPY_SDMA_AUTOMATIC_SUM;
    aclDataType type = ACL_FLOAT;
    aclrtStream stream = nullptr;
    void* reserve = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkiikk", &dst, &src, &count, &kind, &type, &stream, &reserve),
        "acl.rt.reduce_async args parse failed");

    aclError ret = aclrtReduceAsync(dst, src, count, kind, type, stream, reserve);
    return Py_BuildValue("i", ret);
}

static PyObject* g_pyFunc = nullptr;
static void InfoCallback(aclrtExceptionInfo* info)
{
    PyGILState_STATE state = PyGILState_Ensure();
    ACL_APP_LOG(ACL_DEBUG, "InfoCallback in");

    PyObject* argslist = Py_BuildValue("(K)", info);
    PyObject* result = PyObject_CallObject(g_pyFunc, argslist);

    Py_XDECREF(argslist);
    if (result == nullptr) {
        Py_XDECREF(g_pyFunc);
        g_pyFunc = nullptr;
        ACL_APP_LOG(ACL_ERROR, "InfoCallback wrong out");
        PyGILState_Release(state);
        return;
    }
    Py_XDECREF(result);
    ACL_APP_LOG(ACL_DEBUG, "InfoCallback out");
    PyGILState_Release(state);
}

PyObject* WrapAclRtSetExceptionInfoCallback(PyObject* /* self */, PyObject* args)
{
    PyObject* fn = nullptr;
    aclError ret = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "|O", &fn), "acl.rt.set_exception_info_callback args parse failed");

    if (PyCallable_Check(fn)) {
        Py_XINCREF(fn);
        if (g_pyFunc != nullptr) {
            Py_XDECREF(g_pyFunc);
        }
        g_pyFunc = fn;
        ret = aclrtSetExceptionInfoCallback(InfoCallback);
    } else if (fn == nullptr || fn == Py_None) {
        // C10版本接口支持 aclrtSetExceptionInfoCallback 取消设置回调操作
        Py_XDECREF(g_pyFunc);
        g_pyFunc = nullptr;
        ret = aclrtSetExceptionInfoCallback(nullptr);
    } else {
        PyErr_SetString(PyExc_TypeError, "acl.rt.set_exception_info_callback args parse failed");
        return nullptr;
    }

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetErrorCodeFromExceptionInfo(PyObject* /* self */, PyObject* args)
{
    const aclrtExceptionInfo* info = nullptr;
    uint32_t errorCode = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &info), "acl.rt.get_error_code_from_exception_info args parse failed");

    errorCode = aclrtGetErrorCodeFromExceptionInfo(info);
    return Py_BuildValue("I", errorCode);
}

PyObject* WrapAclRtGetTaskIdFromExceptionInfo(PyObject* /* self */, PyObject* args)
{
    const aclrtExceptionInfo* info = nullptr;
    uint32_t taskId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &info), "acl.rt.get_task_id_from_exception_info args parse failed");

    taskId = aclrtGetTaskIdFromExceptionInfo(info);
    return Py_BuildValue("I", taskId);
}

PyObject* WrapAclRtGetStreamIdFromExceptionInfo(PyObject* /* self */, PyObject* args)
{
    const aclrtExceptionInfo* info = nullptr;
    uint32_t streamId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &info), "acl.rt.get_stream_id_from_exception_info args parse failed");

    streamId = aclrtGetStreamIdFromExceptionInfo(info);
    return Py_BuildValue("I", streamId);
}

PyObject* WrapAclRtGetThreadIdFromExceptionInfo(PyObject* /* self */, PyObject* args)
{
    const aclrtExceptionInfo* info = nullptr;
    uint32_t threadId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &info), "acl.rt.get_thread_id_from_exception_info args parse failed");

    threadId = aclrtGetThreadIdFromExceptionInfo(info);
    return Py_BuildValue("I", threadId);
}

PyObject* WrapAclRtGetDeviceIdFromExceptionInfo(PyObject* /* self */, PyObject* args)
{
    const aclrtExceptionInfo* info = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &info), "acl.rt.get_device_id_from_exception_info args parse failed");

    uint32_t deviceId = aclrtGetDeviceIdFromExceptionInfo(info);
    return Py_BuildValue("I", deviceId);
}

PyObject* WrapAclRtSetOpWaitTimeout(PyObject* /* self */, PyObject* args)
{
    uint32_t timeout = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "I", &timeout), "acl.rt.set_op_wait_timeout args parse failed!");

    aclError ret = aclrtSetOpWaitTimeout(timeout);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtSetOpExecuteTimeOut(PyObject* /* self */, PyObject* args)
{
    uint32_t timeout = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "I", &timeout), "acl.rt.set_op_execute_timeout args parse failed!");

    aclError ret = aclrtSetOpExecuteTimeOut(timeout);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtPeekAtLastError(PyObject* /* self */, PyObject* args)
{
    aclrtLastErrLevel level = ACL_RT_THREAD_LEVEL;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &level), "acl.rt.peek_at_last_error args parse failed!");

    aclError ret = aclrtPeekAtLastError(level);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetLastError(PyObject* /* self */, PyObject* args)
{
    aclrtLastErrLevel level = ACL_RT_THREAD_LEVEL;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &level), "acl.rt.get_last_error args parse failed!");

    aclError ret = aclrtGetLastError(level);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtSynchronizeDeviceWithTimeout(PyObject* /* self */, PyObject* args)
{
    int32_t timeout = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &timeout), "acl.rt.synchronize_device_with_timeout args parse failed!");

    aclError ret = aclrtSynchronizeDeviceWithTimeout(timeout);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtCmoAsync(PyObject* /* self */, PyObject* args)
{
    void* src = nullptr;
    size_t size = 0;
    aclrtCmoType cmoType = ACL_RT_CMO_TYPE_PREFETCH;
    aclrtStream stream = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kkik", &src, &size, &cmoType, &stream), "acl.rt.cmo_async args parse failed!");

    aclError ret = aclrtCmoAsync(src, size, cmoType, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtSetOpExecuteTimeOutV2(PyObject* /* self */, PyObject* args)
{
    uint64_t timeout = 0;
    uint64_t actualTimeout = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "K", &timeout), "acl.rt.set_op_execute_timeout_v2 args parse failed!");

    aclError ret = aclrtSetOpExecuteTimeOutV2(timeout, &actualTimeout);
    return Py_BuildValue("Ki", actualTimeout, ret);
}

PyObject* WrapAclGetOpTimeOutInterval(PyObject* /* self */, PyObject* /* args */)
{
    uint64_t interval = 0;
    aclError ret = aclrtGetOpTimeOutInterval(&interval);
    return Py_BuildValue("Ki", interval, ret);
}

PyObject* WrapAclGetOpExecuteTimeOut(PyObject* /* self */, PyObject* /* args */)
{
    uint32_t timeoutMs = 0;
    aclError ret = aclrtGetOpExecuteTimeout(&timeoutMs);
    return Py_BuildValue("Ii", timeoutMs, ret);
}