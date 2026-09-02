/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "op.h"
#define NPY_NO_DEPRECATED_API NPY_1_7_API_VERSION
#pragma GCC diagnostic ignored "-Wcast-qual"
#pragma GCC diagnostic ignored "-Wconversion"
#include <numpy/arrayobject.h>
#include <string>
#include <vector>
#include <map>
#include <memory>
#include "acl/acl.h"

namespace {
PyObject* g_pyAclopCompileFuncCallback = nullptr;
std::map<const std::string, PyObject*> g_mapOpCompileFuncCallback;
} // anonymous namespace

static aclError AclOpCompileFuncCallback(
    int numInputs, const aclTensorDesc* const inputDesc[], int numOutputs, const aclTensorDesc* const outputDesc[],
    const aclopAttr* opAttr, aclopKernelDesc* kernelDesc)
{
    if (g_pyAclopCompileFuncCallback == nullptr) {
        return 0;
    }
    PyObject* pInList = PyList_New(numInputs);
    if (!pInList) {
        return 0;
    }
    PyObject* pOutList = PyList_New(numOutputs);
    if (!pOutList) {
        Py_XDECREF(pInList);
        return 0;
    }
    for (int i = 0; i < numInputs; i++) {
        PyList_SetItem(pInList, i, Py_BuildValue("k", reinterpret_cast<uintptr_t>(inputDesc[i])));
    }
    for (int i = 0; i < numOutputs; i++) {
        PyList_SetItem(pOutList, i, Py_BuildValue("k", reinterpret_cast<uintptr_t>(outputDesc[i])));
    }

    PyObject* argslist = Py_BuildValue(
        "(iOiOkk)", numInputs, pInList, numOutputs, pOutList, reinterpret_cast<uintptr_t>(opAttr),
        reinterpret_cast<uintptr_t>(kernelDesc));
    PyObject* result = PyObject_CallObject(g_pyAclopCompileFuncCallback, argslist);

    Py_XDECREF(argslist);
    Py_XDECREF(pInList);
    Py_XDECREF(pOutList);
    if (result == nullptr) {
        ACL_APP_LOG(ACL_ERROR, "AclOpCompileFuncCallback wrong out");
        return 0;
    }
    Py_XDECREF(result);
    return 0;
}

static void AclDataDeallocatorCallback(void* data, size_t /* length */)
{
    if (data == nullptr) {
        return;
    }

    aclrtRunMode runMode = ACL_DEVICE;
    aclError ret = aclrtGetRunMode(&runMode);
    if (ret != 0) {
        ACL_APP_LOG(ACL_ERROR, "acl.rt.get_run_mode failed");
        return;
    }

    if (runMode == ACL_DEVICE) {
        aclrtFree(data);
    } else {
        aclrtFreeHost(data);
    }

    return;
}

PyObject* WrapAclOpSetModelDir(PyObject* /* self */, PyObject* args)
{
    const char* modelDir = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "s", &modelDir), "acl.op.set_model_dir args parse failed");

    aclError iRet = aclopSetModelDir(modelDir);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpLoad(PyObject* /* self */, PyObject* args)
{
    void* model = nullptr;
    unsigned long modelSize = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &model, &modelSize), "acl.op.load args parse failed");

    aclError iRet = aclopLoad(model, modelSize);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpExecute(PyObject* /* self */, PyObject* args)
{
    const char* opType = nullptr;
    aclopAttr* attr = nullptr;
    aclrtStream stream = nullptr;
    PyObject* pyInputDescList = nullptr;
    PyObject* pyInputsList = nullptr;
    PyObject* pyOutputDescList = nullptr;
    PyObject* pyOutputsList = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "sOOOOkk", &opType, &pyInputDescList, &pyInputsList, &pyOutputDescList, &pyOutputsList, &attr,
            &stream),
        "acl.op.execute args parse failed");
    CHECK_NULL(
        PyList_Check(pyInputDescList) != 0 && PyList_Check(pyInputsList) != 0 && PyList_Check(pyOutputDescList) != 0 &&
            PyList_Check(pyOutputsList) != 0,
        "argument 2, 3, 4, or 5 is not list");

    int inputDescSize = static_cast<int>(PyList_Size(pyInputDescList));
    int inputsSize = static_cast<int>(PyList_Size(pyInputsList));
    int outputDescSize = static_cast<int>(PyList_Size(pyOutputDescList));
    int outputsSize = static_cast<int>(PyList_Size(pyOutputsList));
    CHECK_NULL(
        inputDescSize >= 0 && inputsSize >= 0 && outputDescSize >= 0 && outputsSize >= 0, "list is empty",
        PyExc_ValueError);
    std::vector<aclTensorDesc*> inputDesc(inputDescSize + 1, nullptr);
    std::vector<aclDataBuffer*> inputs(inputsSize + 1, nullptr);
    std::vector<aclTensorDesc*> outputDesc(outputDescSize + 1, nullptr);
    std::vector<aclDataBuffer*> outputs(outputsSize + 1, nullptr);
    CHECK_NULL(ConvertPyListToPtrArray(pyInputDescList, inputDescSize, inputDesc.data()));
    CHECK_NULL(ConvertPyListToPtrArray(pyInputsList, inputsSize, inputs.data()));
    CHECK_NULL(ConvertPyListToPtrArray(pyOutputDescList, outputDescSize, outputDesc.data()));
    CHECK_NULL(ConvertPyListToPtrArray(pyOutputsList, outputsSize, outputs.data()));

    aclError iRet = aclopExecute(
        opType, inputsSize, inputDesc.data(), inputs.data(), outputsSize, outputDesc.data(), outputs.data(), attr,
        stream);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpExecWithHandle(PyObject* /* self */, PyObject* args)
{
    aclopHandle* handle = nullptr;
    PyObject* pyInputsList = nullptr;
    PyObject* pyOutputsList = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kOOk", &handle, &pyInputsList, &pyOutputsList, &stream),
        "acl.op.execute_with_handle args parse failed");
    CHECK_NULL(PyList_Check(pyInputsList) != 0 && PyList_Check(pyOutputsList) != 0, "argument 2 or 3 is not list");

    int inputsSize = static_cast<int>(PyList_Size(pyInputsList));
    int outputsSize = static_cast<int>(PyList_Size(pyOutputsList));
    CHECK_NULL(inputsSize >= 0 && outputsSize >= 0, "list is empty", PyExc_ValueError);

    std::vector<aclDataBuffer*> inputs(inputsSize + 1, nullptr);
    std::vector<aclDataBuffer*> outputs(outputsSize + 1, nullptr);
    CHECK_NULL(ConvertPyListToPtrArray(pyInputsList, inputsSize, inputs.data()));
    CHECK_NULL(ConvertPyListToPtrArray(pyOutputsList, outputsSize, outputs.data()));

    aclError iRet = aclopExecWithHandle(handle, inputsSize, inputs.data(), outputsSize, outputs.data(), stream);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpCast(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* srcDesc = nullptr;
    aclDataBuffer* srcBuffer = nullptr;
    aclTensorDesc* dstDesc = nullptr;
    aclDataBuffer* dstBuffer = nullptr;
    uint8_t truncate = 0;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkBk", &srcDesc, &srcBuffer, &dstDesc, &dstBuffer, &truncate, &stream),
        "acl.op.cast args parse failed");

    aclError iRet = aclopCast(srcDesc, srcBuffer, dstDesc, dstBuffer, truncate, stream);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpCreateHandleForCast(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* srcDesc = nullptr;
    aclTensorDesc* dstDesc = nullptr;
    uint8_t truncate = 0;
    aclopHandle* handle = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkB", &srcDesc, &dstDesc, &truncate),
        "acl.op.create_handle_for_cast args parse failed");

    aclError iRet = aclopCreateHandleForCast(srcDesc, dstDesc, truncate, &handle);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(handle), iRet);
}

PyObject* WrapAclOpCreateAttr(PyObject* /* self */, PyObject* /* args */)
{
    aclopAttr* opAttr = nullptr;
    opAttr = aclopCreateAttr();
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(opAttr));
}
PyObject* WrapAclOpDestroyAttr(PyObject* /* self */, PyObject* args)
{
    aclopAttr* attr = nullptr;
    CHECK_NULL(PyArg_ParseTuple(args, "k", &attr), "acl.op.destroy_attr args parse failed");

    aclopDestroyAttr(attr);
    Py_INCREF(Py_None);
    return Py_None;
}

PyObject* WrapAclOpSetAttrBool(PyObject* /* self */, PyObject* args)
{
    aclopAttr* attr = nullptr;
    const char* attrName = nullptr;
    uint8_t attrValue = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "ksB", &attr, &attrName, &attrValue), "acl.op.set_attr_bool args parse failed");

    aclError iRet = aclopSetAttrBool(attr, attrName, attrValue);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpSetAttrInt(PyObject* /* self */, PyObject* args)
{
    aclopAttr* attr = nullptr;
    const char* attrName = nullptr;
    int64_t attrValue = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "ksL", &attr, &attrName, &attrValue), "acl.op.set_attr_int args parse failed");

    aclError iRet = aclopSetAttrInt(attr, attrName, attrValue);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpSetAttrFloat(PyObject* /* self */, PyObject* args)
{
    aclopAttr* attr = nullptr;
    const char* attrName = nullptr;
    float attrValue = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "ksf", &attr, &attrName, &attrValue), "acl.op.set_attr_float args parse failed");

    aclError iRet = aclopSetAttrFloat(attr, attrName, attrValue);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpSetAttrString(PyObject* /* self */, PyObject* args)
{
    aclopAttr* attr = nullptr;
    const char* attrName = nullptr;
    char* attrValue = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kss", &attr, &attrName, &attrValue), "acl.op.set_attr_string args parse failed");

    aclError iRet = aclopSetAttrString(attr, attrName, attrValue);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpSetAttrListBool(PyObject* /* self */, PyObject* args)
{
    aclopAttr* attr = nullptr;
    const char* attrName = nullptr;
    PyObject* valuesObj = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ksO", &attr, &attrName, &valuesObj), "acl.op.set_attr_list_bool args parse failed");

    uint8_t* valuesPtr = nullptr;
    int numValues = 0;
    std::vector<uint8_t> values;
    if (PyList_Check(valuesObj) == true) {
        CHECK_NULL(GetValuesFromPyList(valuesObj, values), "get values from PyList failed", PyExc_ValueError);
        valuesPtr = values.data();
        numValues = static_cast<int>(PyList_Size(valuesObj));
    } else {
        constexpr int stackLevel = 1;
        PyErr_WarnEx(PyExc_Warning, "argument 3 only support the format of list in the future.", stackLevel);
        import_array();
        CHECK_NULL(PyArray_Check(valuesObj), "argument 3 is not list or numpy array");
        valuesPtr = reinterpret_cast<uint8_t*>(PyArray_DATA(reinterpret_cast<PyArrayObject*>(valuesObj)));
        numValues = PyArray_SIZE(reinterpret_cast<PyArrayObject*>(valuesObj));
    }

    CHECK_NULL(valuesPtr, "convert argument 3 to uint8_t* failed", PyExc_ValueError);
    aclError iRet = aclopSetAttrListBool(attr, attrName, numValues, valuesPtr);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpSetAttrListInt(PyObject* /* self */, PyObject* args)
{
    aclopAttr* attr = nullptr;
    const char* attrName = nullptr;
    PyObject* valuesObj = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ksO", &attr, &attrName, &valuesObj), "acl.op.set_attr_list_int args parse failed");

    int numValues = 0;
    int64_t* valuesPtr = nullptr;
    std::vector<int64_t> values;
    if (PyList_Check(valuesObj) == true) {
        CHECK_NULL(GetValuesFromPyList(valuesObj, values), "get values from PyList failed", PyExc_ValueError);
        valuesPtr = values.data();
        numValues = static_cast<int>(PyList_Size(valuesObj));
    } else {
        constexpr int stackLevel = 1;
        PyErr_WarnEx(PyExc_Warning, "argument 3 only support the format of list in the future.", stackLevel);
        import_array();
        CHECK_NULL(PyArray_Check(valuesObj), "argument 3 is not list or numpy array");
        valuesPtr = reinterpret_cast<int64_t*>(PyArray_DATA(reinterpret_cast<PyArrayObject*>(valuesObj)));
        numValues = PyArray_SIZE(reinterpret_cast<PyArrayObject*>(valuesObj));
    }

    CHECK_NULL(valuesPtr, "convert argument 3 to int64_t* failed", PyExc_ValueError);
    aclError iRet = aclopSetAttrListInt(attr, attrName, numValues, valuesPtr);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpSetAttrListFloat(PyObject* /* self */, PyObject* args)
{
    aclopAttr* attr = nullptr;
    const char* attrName = nullptr;
    PyObject* valuesObj = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ksO", &attr, &attrName, &valuesObj), "acl.op.set_attr_list_float args parse failed");

    float* valuesPtr = nullptr;
    int numValues = 0;
    std::vector<float> values;
    if (PyList_Check(valuesObj) == true) {
        CHECK_NULL(GetValuesFromPyList(valuesObj, values), "get values from PyList failed", PyExc_ValueError);
        valuesPtr = values.data();
        numValues = static_cast<int>(PyList_Size(valuesObj));
    } else {
        constexpr int stackLevel = 1;
        PyErr_WarnEx(PyExc_Warning, "argument 3 only support the format of list in the future.", stackLevel);
        import_array();
        CHECK_NULL(PyArray_Check(valuesObj), "argument 3 is not list or numpy array");
        valuesPtr = reinterpret_cast<float*>(PyArray_DATA(reinterpret_cast<PyArrayObject*>(valuesObj)));
        numValues = PyArray_SIZE(reinterpret_cast<PyArrayObject*>(valuesObj));
    }

    CHECK_NULL(valuesPtr, "convert argument 3 to float* failed", PyExc_ValueError);
    aclError iRet = aclopSetAttrListFloat(attr, attrName, numValues, valuesPtr);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpSetAttrListString(PyObject* /* self */, PyObject* args)
{
    aclopAttr* attr = nullptr;
    const char* attrName = nullptr;
    PyObject* pyValuesList = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ksO", &attr, &attrName, &pyValuesList),
        "acl.op.set_attr_list_string args parse failed");
    CHECK_NULL(PyList_Check(pyValuesList), "argument 3 is not list");

    int size = static_cast<int>(PyList_Size(pyValuesList));
    CHECK_NULL(size >= 0, "list is empty", PyExc_ValueError);
    std::vector<std::string> fileNameArray;
    std::vector<const char*> values(size + 1, nullptr);
    for (int i = 0; i < size; i++) {
        PyObject* object = PyList_GetItem(pyValuesList, i);
        PyObject* bytes = PyUnicode_AsUTF8String(object);
        CHECK_NULL(bytes, "PyUnicode_AsUTF8String failed", PyExc_RuntimeError);
        char* str = PyBytes_AsString(bytes);
        if (str == nullptr) {
            Py_XDECREF(bytes);
            PyErr_SetString(PyExc_RuntimeError, "PyBytes_AsString failed");
            return nullptr;
        }
        fileNameArray.push_back(str);
        Py_XDECREF(bytes);
        values[i] = fileNameArray[i].data();
    }
    aclError iRet = aclopSetAttrListString(attr, attrName, size, values.data());
    return Py_BuildValue("i", iRet);
}

static bool ParseListListInt(
    PyObject* pyValuesList, std::vector<std::vector<int64_t>>& valuesData, std::vector<int>& numValues,
    std::vector<int64_t*>& values)
{
    int numLists = static_cast<int>(PyList_Size(pyValuesList));
    int64_t* valuesPtr = nullptr;
    int valuesSize = 0;

    for (int i = 0; i < numLists; i++) {
        PyObject* object = PyList_GetItem(pyValuesList, i);
        CHECK_BOOL(object, "there is none in the list");
        if (PyList_Check(object) == true) {
            CHECK_BOOL(GetValuesFromPyList(object, valuesData[i]), "get values from PyList failed", PyExc_ValueError);
            valuesPtr = valuesData[i].data();
            valuesSize = static_cast<int>(PyList_Size(object));
        } else {
            constexpr int stackLevel = 1;
            PyErr_WarnEx(PyExc_Warning, "argument 3 only support the format of list in the future.", stackLevel);
            import_array();
            CHECK_BOOL(PyArray_Check(object), "arg is not list or numpy array");
            valuesPtr = reinterpret_cast<int64_t*>(PyArray_DATA(reinterpret_cast<PyArrayObject*>(object)));
            valuesSize = PyArray_SIZE(reinterpret_cast<PyArrayObject*>(object));
        }
        values[i] = valuesPtr;
        numValues[i] = valuesSize;
    }
    return true;
}

PyObject* WrapAclOpSetAttrListListInt(PyObject* /* self */, PyObject* args)
{
    aclopAttr* attr = nullptr;
    const char* attrName = nullptr;
    PyObject* pyValuesList = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ksO", &attr, &attrName, &pyValuesList),
        "acl.op.set_attr_list_list_int args parse failed");
    CHECK_NULL(PyList_Check(pyValuesList), "argument 3 is not list");

    int numLists = static_cast<int>(PyList_Size(pyValuesList));
    CHECK_NULL(numLists >= 0, "list is empty", PyExc_ValueError);
    std::vector<int> numValues(numLists + 1);
    std::vector<int64_t*> values(numLists + 1, nullptr);
    std::vector<std::vector<int64_t>> valuesData(numLists + 1, std::vector<int64_t>());
    CHECK_NULL(
        ParseListListInt(pyValuesList, valuesData, numValues, values), "parse argument 3 failed", PyExc_ValueError);

    aclError iRet = aclopSetAttrListListInt(attr, attrName, numLists, numValues.data(), values.data());
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpCreateHandle(PyObject* /* self */, PyObject* args)
{
    const char* opType = nullptr;
    PyObject* inputDescList = nullptr;
    PyObject* outputDescList = nullptr;
    aclopAttr* opAttr = nullptr;
    aclopHandle* handle = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "sOOk", &opType, &inputDescList, &outputDescList, &opAttr),
        "acl.op.create_handle args parse failed");
    CHECK_NULL(PyList_Check(inputDescList) != 0 && PyList_Check(outputDescList) != 0, "argument 2 or 3 is not list");

    int numInputs = static_cast<int>(PyList_Size(inputDescList));
    int numOutputs = static_cast<int>(PyList_Size(outputDescList));
    CHECK_NULL(numInputs >= 0 && numOutputs >= 0, "list is empty", PyExc_ValueError);

    std::vector<aclTensorDesc*> inputDesc(numInputs + 1, nullptr);
    std::vector<aclTensorDesc*> outputDesc(numOutputs + 1, nullptr);
    CHECK_NULL(ConvertPyListToPtrArray(inputDescList, numInputs, inputDesc.data()));
    CHECK_NULL(ConvertPyListToPtrArray(outputDescList, numOutputs, outputDesc.data()));

    aclError iRet =
        aclopCreateHandle(opType, numInputs, inputDesc.data(), numOutputs, outputDesc.data(), opAttr, &handle);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(handle), iRet);
}

PyObject* WrapAclOpDestroyHandle(PyObject* /* self */, PyObject* args)
{
    aclopHandle* handle = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &handle), "acl.op.destroy_handle args parse failed");

    aclopDestroyHandle(handle);
    Py_INCREF(Py_None);
    return Py_None;
}

PyObject* WrapAclOpStartDumpArgs(PyObject* /* self */, PyObject* args)
{
    uint32_t dumpType = 0;
    const char* path = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "Is", &dumpType, &path), "acl.op.start_dump_args args parse failed");

    aclError ret = aclopStartDumpArgs(dumpType, path);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclOpStopDumpArgs(PyObject* /* self */, PyObject* args)
{
    uint32_t dumpType = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "I", &dumpType), "acl.op.stop_dump_args args parse failed");

    aclError ret = aclopStopDumpArgs(dumpType);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclOpRegisterCompileFunc(PyObject* /* self */, PyObject* args)
{
    const char* opType = nullptr;
    PyObject* func = nullptr;

    if (PyArg_ParseTuple(args, "sO", &opType, &func) != 0) {
        CHECK_NULL(PyCallable_Check(func), "argument 2 must be a callback function.");
        Py_XINCREF(func);
    } else {
        ACL_APP_LOG(ACL_ERROR, "acl.op.register_compile_func args parse failed");
        return nullptr;
    }

    Py_XDECREF(g_mapOpCompileFuncCallback[opType]);
    g_mapOpCompileFuncCallback[opType] = func;
    aclError iRet = aclopRegisterCompileFunc(opType, AclOpCompileFuncCallback);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpUnregisterCompileFunc(PyObject* /* self */, PyObject* args)
{
    const char* opType = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "s", &opType), "acl.op.unregister_compile_func args parse failed");

    std::map<std::string, PyObject*>::const_iterator it = g_mapOpCompileFuncCallback.find(opType);
    if (it != g_mapOpCompileFuncCallback.cend()) {
        Py_XDECREF(g_mapOpCompileFuncCallback[opType]);
        g_mapOpCompileFuncCallback.erase(it);
    }
    aclError iRet = aclopUnregisterCompileFunc(opType);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpCreateKernel(PyObject* /* self */, PyObject* args)
{
    const char* opType = nullptr;
    const char* kernelId = nullptr;
    const char* kernelName = nullptr;
    void* binData = nullptr;
    int binSize = 0;
    aclopEngineType enginetype = ACL_ENGINE_SYS;
    int deallocator = 0;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "ssskiii", &opType, &kernelId, &kernelName, &binData, &binSize, &enginetype, &deallocator),
        "acl.op.create_kernel args parse failed");

    aclError iRet = 0;
    if (deallocator != 0) {
        iRet =
            aclopCreateKernel(opType, kernelId, kernelName, binData, binSize, enginetype, AclDataDeallocatorCallback);
    } else {
        iRet = aclopCreateKernel(opType, kernelId, kernelName, binData, binSize, enginetype, nullptr);
    }
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpSetKernelArgs(PyObject* /* self */, PyObject* args)
{
    aclopKernelDesc* kernelDesc = nullptr;
    const char* kernelId = nullptr;
    uint32_t blockDim = 0;
    const void* pArgs = nullptr;
    uint32_t argSize = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ksIkI", &kernelDesc, &kernelId, &blockDim, &pArgs, &argSize),
        "acl.op.set_kernel_args args parse failed");

    aclError iRet = aclopSetKernelArgs(kernelDesc, kernelId, blockDim, pArgs, argSize);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpSetKernelWorkspaceSizes(PyObject* /* self */, PyObject* args)
{
    aclopKernelDesc* kernelDesc = nullptr;
    int numWorkspaces = 0;
    size_t* workspaceSizes = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kik", &kernelDesc, &numWorkspaces, &workspaceSizes),
        "acl.op.set_kernel_workspace_sizes args parse failed");

    aclError iRet = aclopSetKernelWorkspaceSizes(kernelDesc, numWorkspaces, workspaceSizes);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpUpdateParams(PyObject* /* self */, PyObject* args)
{
    const char* opType = nullptr;
    PyObject* pyInputDescList = nullptr;
    PyObject* pyOutputDescList = nullptr;
    const aclopAttr* attr = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "sOOk", &opType, &pyInputDescList, &pyOutputDescList, &attr),
        "acl.op.update_params args parse failed");
    CHECK_NULL(
        PyList_Check(pyInputDescList) != 0 && PyList_Check(pyOutputDescList) != 0, "argument 2 or 3 is not list");

    int numInputs = static_cast<int>(PyList_Size(pyInputDescList));
    int numOutputs = static_cast<int>(PyList_Size(pyOutputDescList));
    CHECK_NULL(numInputs >= 0 && numOutputs >= 0, "list is empty", PyExc_ValueError);

    std::vector<aclTensorDesc*> inputDesc(numInputs + 1, nullptr);
    std::vector<aclTensorDesc*> outputDesc(numOutputs + 1, nullptr);
    CHECK_NULL(ConvertPyListToPtrArray(pyInputDescList, numInputs, inputDesc.data()));
    CHECK_NULL(ConvertPyListToPtrArray(pyOutputDescList, numOutputs, outputDesc.data()));

    PyGILState_STATE state = PyGILState_Ensure();
    std::map<std::string, PyObject*>::const_iterator it = g_mapOpCompileFuncCallback.find(opType);
    if (it != g_mapOpCompileFuncCallback.cend()) {
        g_pyAclopCompileFuncCallback = it->second;
    }
    aclError iRet = aclopUpdateParams(opType, numInputs, inputDesc.data(), numOutputs, outputDesc.data(), attr);
    g_pyAclopCompileFuncCallback = nullptr;
    PyGILState_Release(state);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpExecuteV2(PyObject* /* self */, PyObject* args)
{
    const char* opType = nullptr;
    aclopAttr* attr = nullptr;
    aclrtStream stream = nullptr;
    PyObject* pyInputDescList = nullptr;
    PyObject* pyInputsList = nullptr;
    PyObject* pyOutputDescList = nullptr;
    PyObject* pyOutputsList = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "sOOOOkk", &opType, &pyInputDescList, &pyInputsList, &pyOutputDescList, &pyOutputsList, &attr,
            &stream),
        "acl.op.execute_v2 args parse failed");

    CHECK_NULL(
        PyList_Check(pyInputDescList) != 0 && PyList_Check(pyInputsList) != 0 && PyList_Check(pyOutputDescList) != 0 &&
            PyList_Check(pyOutputsList) != 0,
        "argument 2, 3, 4, or 5 is not list");
    int inputDescSize = static_cast<int>(PyList_Size(pyInputDescList));
    int inputsSize = static_cast<int>(PyList_Size(pyInputsList));
    int outputDescSize = static_cast<int>(PyList_Size(pyOutputDescList));
    int outputsSize = static_cast<int>(PyList_Size(pyOutputsList));
    CHECK_NULL(
        inputDescSize >= 0 && inputsSize >= 0 && outputDescSize >= 0 && outputsSize >= 0, "list is empty",
        PyExc_ValueError);

    std::vector<aclTensorDesc*> inputDesc(inputDescSize + 1, nullptr);
    std::vector<aclDataBuffer*> inputs(inputsSize + 1, nullptr);
    std::vector<aclTensorDesc*> outputDesc(outputDescSize + 1, nullptr);
    std::vector<aclDataBuffer*> outputs(outputsSize + 1, nullptr);
    CHECK_NULL(ConvertPyListToPtrArray(pyInputDescList, inputDescSize, inputDesc.data()));
    CHECK_NULL(ConvertPyListToPtrArray(pyInputsList, inputsSize, inputs.data()));
    CHECK_NULL(ConvertPyListToPtrArray(pyOutputDescList, outputDescSize, outputDesc.data()));
    CHECK_NULL(ConvertPyListToPtrArray(pyOutputsList, outputsSize, outputs.data()));

    aclError iRet = aclopExecuteV2(
        opType, inputsSize, inputDesc.data(), inputs.data(), outputsSize, outputDesc.data(), outputs.data(), attr,
        stream);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpInferShape(PyObject* /* self */, PyObject* args)
{
    const char* opType = nullptr;
    aclopAttr* attr = nullptr;
    PyObject* pyInputDescList = nullptr;
    PyObject* pyInputsList = nullptr;
    int numOutputs = 0;
    PyObject* pyOutputDescList = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "sOOiOk", &opType, &pyInputDescList, &pyInputsList, &numOutputs, &pyOutputDescList, &attr),
        "acl.op.infer_shape args parse failed");

    CHECK_NULL(
        PyList_Check(pyInputDescList) != 0 && PyList_Check(pyInputsList) != 0 && PyList_Check(pyOutputDescList) != 0,
        "argument 2, 3, or 5 is not list");
    int inputDescSize = static_cast<int>(PyList_Size(pyInputDescList));
    int inputsSize = static_cast<int>(PyList_Size(pyInputsList));
    int outputDescSize = static_cast<int>(PyList_Size(pyOutputDescList));
    CHECK_NULL(inputDescSize >= 0 && inputsSize >= 0 && outputDescSize >= 0, "list is empty", PyExc_ValueError);

    std::vector<aclTensorDesc*> inputDesc(inputDescSize + 1, nullptr);
    std::vector<aclDataBuffer*> inputs(inputsSize + 1, nullptr);
    std::vector<aclTensorDesc*> outputDesc(outputDescSize + 1, nullptr);
    CHECK_NULL(ConvertPyListToPtrArray(pyInputDescList, inputDescSize, inputDesc.data()));
    CHECK_NULL(ConvertPyListToPtrArray(pyInputsList, inputsSize, inputs.data()));
    CHECK_NULL(ConvertPyListToPtrArray(pyOutputDescList, outputDescSize, outputDesc.data()));

    aclError iRet =
        aclopInferShape(opType, inputsSize, inputDesc.data(), inputs.data(), numOutputs, outputDesc.data(), attr);
    return Py_BuildValue("i", iRet);
}

PyObject* WrapAclOpSetAttrDataType(PyObject* /* self */, PyObject* args)
{
    aclopAttr* attr = nullptr;
    const char* attrName = nullptr;
    aclDataType attrValue = ACL_DT_UNDEFINED;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ksi", &attr, &attrName, &attrValue), "acl.op.set_attr_data_type args parse failed");

    aclError ret = aclopSetAttrDataType(attr, attrName, attrValue);
    return Py_BuildValue("ki", attr, ret);
}

PyObject* WrapAclOpSetAttrListDataType(PyObject* /* self */, PyObject* args)
{
    aclopAttr* attr = nullptr;
    const char* attrName = nullptr;
    PyObject* valuesObj = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ksO", &attr, &attrName, &valuesObj),
        "acl.op.set_attr_list_data_type args parse failed");

    CHECK_NULL(PyList_Check(valuesObj), "the third argument is not list");

    ssize_t valuesSize = PyList_Size(valuesObj);
    std::vector<aclDataType> values(valuesSize + 1);
    CHECK_NULL(ConvertPyListToLongArray(valuesObj, static_cast<int>(valuesSize), values.data()));

    aclError ret = aclopSetAttrListDataType(attr, attrName, static_cast<int>(valuesSize), values.data());
    return Py_BuildValue("ki", attr, ret);
}

PyObject* WrapAclOpSetMaxOpQueueNum(PyObject* /* self */, PyObject* args)
{
    uint64_t maxOpNum = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "K", &maxOpNum), "acl.op.set_max_op_queue_num args parse failed");

    aclError ret = aclopSetMaxOpQueueNum(maxOpNum);
    return Py_BuildValue("i", ret);
}