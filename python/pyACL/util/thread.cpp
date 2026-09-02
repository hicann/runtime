/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "thread.h"
#include <map>
#include <vector>
#include <string>
#include <csignal>
#include "acl/acl.h"

namespace {
struct PyFuncStruct {
    PyObject* pyFunc = nullptr;
    PyObject* pyFuncArgs = nullptr;
};

std::map<pthread_t, std::vector<std::string>> g_errMsgMap;
pthread_mutex_t g_errMsgMutex;
} // anonymous namespace

static void CheckAndSetException(pthread_t tid, const char* msg)
{
    if (!msg || strlen(msg) == 0) {
        return;
    }
    if (PyErr_Occurred()) {
        PyObject* exception = nullptr;
        PyObject* value = nullptr;
        PyObject* traceback = nullptr;
        PyErr_Fetch(&exception, &value, &traceback);
        if (!exception || !value) {
            return;
        }
        PyErr_Display(exception, value, traceback);
        std::string errMsg = "exception=" + std::string(Py_TYPE(value)->tp_name) + ",msg=" + std::string(msg);
        {
            pthread_mutex_lock(&g_errMsgMutex);
            g_errMsgMap[tid].push_back(errMsg);
            pthread_mutex_unlock(&g_errMsgMutex);
        }
        ACL_APP_LOG(ACL_ERROR, "tid=%lu,msg=%s", tid, errMsg.c_str());
    }
    return;
}

static std::string GetExceptionInfo(pthread_t tid)
{
    std::string exceptionInfo = "";
    for (auto const& str : g_errMsgMap[tid]) {
        exceptionInfo += str + ";";
    }
    return exceptionInfo;
}

static void* ThrFunc(void* userData)
{
    PyGILState_STATE state = PyGILState_Ensure();
    ACL_APP_LOG(ACL_DEBUG, "ThrFunc in");

    if (userData == nullptr) {
        ACL_APP_LOG(ACL_ERROR, "ThrFunc args error");
        return nullptr;
    }
    auto data = (PyFuncStruct*)userData;
    PyObject* argslist = nullptr;
    if ((data->pyFuncArgs != nullptr) && (PyObject_TypeCheck(data->pyFuncArgs, &_PyNone_Type) == 0)) {
        argslist = Py_BuildValue("(O)", data->pyFuncArgs);
        CheckAndSetException(pthread_self(), "invalid argument");
    }
    PyObject* result = PyObject_CallObject(data->pyFunc, argslist);
    CheckAndSetException(pthread_self(), "thread call failed");
    Py_XDECREF(argslist);
    Py_XDECREF(data->pyFunc);
    Py_XDECREF(data->pyFuncArgs);
    if (result == nullptr) {
        delete data;
        data = nullptr;
        ACL_APP_LOG(ACL_ERROR, "ThrFunc wrong out");
        PyGILState_Release(state);
        return nullptr;
    }
    ACL_APP_LOG(ACL_DEBUG, "PyObject_CallObject ok");
    Py_XDECREF(result);
    delete data;
    data = nullptr;
    ACL_APP_LOG(ACL_DEBUG, "ThrFunc out");
    PyGILState_Release(state);
    return nullptr;
}

PyObject* WrapStartThread(PyObject* /* self */, PyObject* args)
{
    // Set python func to PyObject
    PyObject* pyFunc = nullptr;
    PyObject* pyFuncArgs = nullptr;

    if (PyArg_ParseTuple(args, "OO", &pyFunc, &pyFuncArgs)) {
        CHECK_NULL(PyCallable_Check(pyFunc), "parameter must be callable");
        Py_XINCREF(pyFunc);
        Py_XINCREF(pyFuncArgs);
    } else {
        ACL_APP_LOG(ACL_ERROR, "acl.util.start_thread args parse failed");
        return nullptr;
    }

    auto data = new (std::nothrow) PyFuncStruct;
    CHECK_NULL(data, "new failed", PyExc_MemoryError);
    data->pyFunc = pyFunc;
    data->pyFuncArgs = pyFuncArgs;

    pthread_t thrId = 0;
    int thrErr = 0;
    {
        PyThreadState* state = PyEval_SaveThread();
        ACL_APP_LOG(ACL_DEBUG, "thread create start");
        thrErr = pthread_create(&thrId, nullptr, ThrFunc, static_cast<void*>(data));
        ACL_APP_LOG(ACL_DEBUG, "thread create end");
        signal(SIGINT, nullptr);
        PyEval_RestoreThread(state);
    }

    return Py_BuildValue("Ki", thrId, thrErr);
}

PyObject* WrapStopThread(PyObject* /* self */, PyObject* args)
{
    pthread_t thrId = 0;
    CHECK_NULL(PyArg_ParseTuple(args, "K", &thrId), "acl.util.stop_thread args parse failed");

    int thrErr = 0;
    {
        PyThreadState* state = PyEval_SaveThread();
        ACL_APP_LOG(ACL_DEBUG, "thread join start");
        thrErr = pthread_join(thrId, nullptr);
        ACL_APP_LOG(ACL_DEBUG, "thread join end");
        PyEval_RestoreThread(state);
    }
    if (g_errMsgMap.count(thrId) != 0) {
        std::string errMsg;
        pthread_mutex_lock(&g_errMsgMutex);
        if (g_errMsgMap.count(thrId) != 0) {
            errMsg = GetExceptionInfo(thrId);
            g_errMsgMap.erase(thrId);
        }
        pthread_mutex_unlock(&g_errMsgMutex);
        if (!errMsg.empty()) {
            PyErr_SetString(PyExc_RuntimeError, errMsg.c_str());
            return nullptr;
        }
    }
    return Py_BuildValue("i", thrErr);
}
