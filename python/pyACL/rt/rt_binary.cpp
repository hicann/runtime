/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "rt_binary.h"
#include "acl/acl.h"

static bool GetBinOptionFromPyDict(PyObject* pyOption, aclrtBinaryLoadOption& binOption)
{
    CHECK_STRUCT_DICT(pyOption, "the bin_option argument is not dict");
    int type = 0;
    uint32_t value = 0;
    CHECK_BOOL(GetValueFromPyDict(pyOption, "type", type));
    CHECK_BOOL(GetValueFromPyDict(pyOption, "value", value));
    binOption.type = static_cast<aclrtBinaryLoadOptionType>(type);
    binOption.value.isLazyLoad = value;
    return true;
}

static bool GetBinOptionsFromPyList(
    PyObject* pyOptions, aclrtBinaryLoadOptions& options, std::vector<aclrtBinaryLoadOption>& optionsVec)
{
    CHECK_BOOL(PyList_Check(pyOptions), "argument 2 only support the format of list", PyExc_ValueError);

    int numOpt = static_cast<int>(PyList_Size(pyOptions));
    optionsVec.assign(numOpt + 1, {});
    CHECK_BOOL(ConvertPyListToStructArray(pyOptions, numOpt, optionsVec.data(), GetBinOptionFromPyDict));
    options.options = (numOpt > 0) ? optionsVec.data() : nullptr;
    options.numOpt = static_cast<size_t>(numOpt);
    return true;
}

PyObject* WrapAclRtBinaryLoadFromFile(PyObject* /* self */, PyObject* args)
{
    const char* binPath = nullptr;
    PyObject* pyOptions = nullptr;
    aclrtBinHandle binHandle = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "sO", &binPath, &pyOptions), "acl.rt.binary_load_from_file args parse failed!");
    aclrtBinaryLoadOptions options{};
    std::vector<aclrtBinaryLoadOption> optionsVec;
    CHECK_NULL(GetBinOptionsFromPyList(pyOptions, options, optionsVec));
    aclrtBinaryLoadOptions* optionsPtr = (options.numOpt > 0) ? &options : nullptr;

    aclError ret = aclrtBinaryLoadFromFile(binPath, optionsPtr, &binHandle);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(binHandle), ret);
}

PyObject* WrapAclRtBinaryLoadFromData(PyObject* /* self */, PyObject* args)
{
    const void* data = nullptr;
    size_t length = 0;
    PyObject* pyOptions = nullptr;
    aclrtBinHandle binHandle = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkO", &data, &length, &pyOptions), "acl.rt.binary_load_from_data args parse failed!");
    aclrtBinaryLoadOptions options{};
    std::vector<aclrtBinaryLoadOption> optionsVec;
    CHECK_NULL(GetBinOptionsFromPyList(pyOptions, options, optionsVec));
    aclrtBinaryLoadOptions* optionsPtr = (options.numOpt > 0) ? &options : nullptr;

    aclError ret = aclrtBinaryLoadFromData(data, length, optionsPtr, &binHandle);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(binHandle), ret);
}

PyObject* WrapAclRtGetFunctionAddr(PyObject* /* self */, PyObject* args)
{
    aclrtFuncHandle funcHandle = nullptr;
    void* aicAddr = nullptr;
    void* aivAddr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &funcHandle), "acl.rt.get_function_addr args parse failed!");

    aclError ret = aclrtGetFunctionAddr(funcHandle, &aicAddr, &aivAddr);
    return Py_BuildValue("kki", reinterpret_cast<uintptr_t>(aicAddr), reinterpret_cast<uintptr_t>(aivAddr), ret);
}

PyObject* WrapAclRtGetFunctionName(PyObject* /* self */, PyObject* args)
{
    aclrtFuncHandle funcHandle = nullptr;
    uint32_t maxLen = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kI", &funcHandle, &maxLen), "acl.rt.get_function_name args parse failed!");

    const uint32_t maxLenLimit = 1024;
    CHECK_NULL(maxLen < maxLenLimit, "maxLen should be less than 1024", PyExc_ValueError);
    std::vector<char> name(maxLen + 1);
    aclError ret = aclrtGetFunctionName(funcHandle, maxLen, name.data());
    return Py_BuildValue("si", name.data(), ret);
}

PyObject* WrapAclRtRegisterCpuFunc(PyObject* /* self */, PyObject* args)
{
    aclrtBinHandle binHandle = nullptr;
    const char* funcName = nullptr;
    const char* kernelName = nullptr;
    aclrtFuncHandle funcHandle = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kss", &binHandle, &funcName, &kernelName),
        "acl.rt.register_cpu_func args parse failed!");
    CHECK_NULL(funcName[0] != '\0' && kernelName[0] != '\0', "argument 2 or 3 must not be empty", PyExc_ValueError);

    aclError ret = aclrtRegisterCpuFunc(binHandle, funcName, kernelName, &funcHandle);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(funcHandle), ret);
}

PyObject* WrapAclRtCreateBinary(PyObject* /* self */, PyObject* args)
{
    void* data = nullptr;
    size_t dataLen = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &data, &dataLen), "acl.rt.create_binary args parse failed");

    aclrtBinary ret = aclrtCreateBinary(data, dataLen);

    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(ret));
}

PyObject* WrapAclRtDestroyBinary(PyObject* /* self */, PyObject* args)
{
    aclrtBinary binary = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &binary), "acl.rt.destroy_binary args parse failed");

    aclError ret = aclrtDestroyBinary(binary);

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtBinaryLoad(PyObject* /* self */, PyObject* args)
{
    aclrtBinary binary = nullptr;
    // typdef void* aclrtBinHandle
    aclrtBinHandle binHandle = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &binary), "acl.rt.binary_load args parse failed");

    aclError ret = aclrtBinaryLoad(binary, &binHandle);

    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(binHandle), ret);
}

PyObject* WrapAclRtBinaryUnLoad(PyObject* /* self */, PyObject* args)
{
    aclrtBinHandle binHandle = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &binHandle), "acl.rt.binary_unload args parse failed");

    aclError ret = aclrtBinaryUnLoad(binHandle);

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtBinaryGetFunction(PyObject* /* self */, PyObject* args)
{
    aclrtBinHandle binHandle = nullptr;
    const char* kernelName = nullptr;
    aclrtFuncHandle funcHandle = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "ks", &binHandle, &kernelName), "acl.rt.binary_get_function args parse failed");

    aclError ret = aclrtBinaryGetFunction(binHandle, kernelName, &funcHandle);

    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(funcHandle), ret);
}

PyObject* WrapAclRtLaunchKernel(PyObject* /* self */, PyObject* args)
{
    aclrtFuncHandle funcHandle = nullptr;
    uint32_t blockDim = 0;
    void* argsData = nullptr;
    size_t argsSize = 0;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kIkkk", &funcHandle, &blockDim, &argsData, &argsSize, &stream),
        "acl.rt.launch_kernel args parse failed");

    aclError ret = aclrtLaunchKernel(funcHandle, blockDim, argsData, argsSize, stream);

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtKernelArgsInit(PyObject* /* self */, PyObject* args)
{
    aclrtFuncHandle funcHandle = nullptr;
    aclrtArgsHandle argsHandle = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &funcHandle), "acl.rt.kernel_args_init args parse failed");

    aclError ret = aclrtKernelArgsInit(funcHandle, &argsHandle);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(argsHandle), ret);
}

PyObject* WrapAclRtKernelArgsInitByUserMem(PyObject* /* self */, PyObject* args)
{
    aclrtFuncHandle funcHandle = nullptr;
    aclrtArgsHandle argsHandle = nullptr;
    void* userHostMem = nullptr;
    size_t actualArgsSize = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkk", &funcHandle, &argsHandle, &userHostMem, &actualArgsSize),
        "acl.rt.kernel_args_init_by_user_mem args parse failed");

    aclError ret = aclrtKernelArgsInitByUserMem(funcHandle, argsHandle, userHostMem, actualArgsSize);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtKernelArgsGetMemSize(PyObject* /* self */, PyObject* args)
{
    aclrtFuncHandle funcHandle = nullptr;
    size_t userArgsSize = 0;
    size_t actualArgsSize = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kk", &funcHandle, &userArgsSize, &actualArgsSize),
        "acl.rt.kernel_args_get_mem_size args parse failed");

    aclError ret = aclrtKernelArgsGetMemSize(funcHandle, userArgsSize, &actualArgsSize);
    return Py_BuildValue("ki", actualArgsSize, ret);
}

PyObject* WrapAclRtKernelArgsGetHandleMemSize(PyObject* /* self */, PyObject* args)
{
    aclrtFuncHandle funcHandle = nullptr;
    size_t memSize = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &funcHandle), "acl.rt.kernel_args_get_handle_mem_size args parse failed");

    aclError ret = aclrtKernelArgsGetHandleMemSize(funcHandle, &memSize);
    return Py_BuildValue("ki", memSize, ret);
}

PyObject* WrapAclRtKernelArgsAppend(PyObject* /* self */, PyObject* args)
{
    aclrtArgsHandle argsHandle = nullptr;
    void* param = nullptr;
    size_t paramSize = 0;
    aclrtParamHandle paramHandle = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkk", &argsHandle, &param, &paramSize), "acl.rt.kernel_args_append args parse failed");

    aclError ret = aclrtKernelArgsAppend(argsHandle, param, paramSize, &paramHandle);
    return Py_BuildValue("ki", paramHandle, ret);
}

PyObject* WrapAclRtKernelArgsAppendPlaceHolder(PyObject* /* self */, PyObject* args)
{
    aclrtArgsHandle argsHandle = nullptr;
    aclrtParamHandle paramHandle = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &argsHandle), "acl.rt.kernel_args_append_place_holder args parse failed");

    aclError ret = aclrtKernelArgsAppendPlaceHolder(argsHandle, &paramHandle);
    return Py_BuildValue("ki", paramHandle, ret);
}

PyObject* WrapAclRtKernelArgsGetPlaceHolderBuffer(PyObject* /* self */, PyObject* args)
{
    aclrtArgsHandle argsHandle = nullptr;
    aclrtParamHandle paramHandle = nullptr;
    size_t dataSize = 0;
    void* bufferAddr = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkk", &argsHandle, &paramHandle, &dataSize),
        "acl.rt.kernel_args_get_place_holder_buffer args parse failed");

    aclError ret = aclrtKernelArgsGetPlaceHolderBuffer(argsHandle, paramHandle, dataSize, &bufferAddr);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(bufferAddr), ret);
}

PyObject* WrapAclRtKernelArgsParaUpdate(PyObject* /* self */, PyObject* args)
{
    aclrtArgsHandle argsHandle = nullptr;
    aclrtParamHandle paramHandle = nullptr;
    void* param = nullptr;
    size_t paramSize = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkk", &argsHandle, &paramHandle, &param, &paramSize),
        "acl.rt.kernel_args_para_update args parse failed");

    aclError ret = aclrtKernelArgsParaUpdate(argsHandle, paramHandle, param, paramSize);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtKernelArgsFinalize(PyObject* /* self */, PyObject* args)
{
    aclrtArgsHandle argsHandle = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &argsHandle), "acl.rt.kernel_args_finalize args parse failed");

    aclError ret = aclrtKernelArgsFinalize(argsHandle);
    return Py_BuildValue("i", ret);
}

static bool GetKernelAttrFromPyDict(PyObject* pyAttr, aclrtLaunchKernelAttr& attr)
{
    CHECK_STRUCT_DICT(pyAttr, "the cfg argument is not dict");

    int id = 0;
    uint32_t value = 0;
    CHECK_BOOL(GetValueFromPyDict(pyAttr, "id", id));
    CHECK_BOOL(GetValueFromPyDict(pyAttr, "value", value));
    attr.id = static_cast<aclrtLaunchKernelAttrId>(id);
    attr.value.blockDimOffset = value;
    return true;
}

static bool GetKernelCfgFromPyList(
    PyObject* pyCfg, aclrtLaunchKernelCfg& cfg, std::vector<aclrtLaunchKernelAttr>& attrs)
{
    CHECK_BOOL(PyList_Check(pyCfg), "argument 2 only support the format of list", PyExc_ValueError);

    int numAttrs = static_cast<int>(PyList_Size(pyCfg));
    attrs.assign(numAttrs + 1, {});
    CHECK_BOOL(ConvertPyListToStructArray(pyCfg, numAttrs, attrs.data(), GetKernelAttrFromPyDict));
    cfg.attrs = (numAttrs > 0) ? attrs.data() : nullptr;
    cfg.numAttrs = static_cast<size_t>(numAttrs);
    return true;
}

PyObject* WrapAclRtLaunchKernelWithConfig(PyObject* /* self */, PyObject* args)
{
    aclrtFuncHandle funcHandle = nullptr;
    uint32_t blockDim = 0;
    aclrtStream stream = nullptr;
    PyObject* pyCfg = nullptr;
    aclrtArgsHandle argsHandle = nullptr;
    void* reserve = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kIkOkk", &funcHandle, &blockDim, &stream, &pyCfg, &argsHandle, &reserve),
        "acl.rt.launch_kernel_with_config args parse failed");

    aclrtLaunchKernelCfg cfg{};
    std::vector<aclrtLaunchKernelAttr> attrs;
    CHECK_NULL(GetKernelCfgFromPyList(pyCfg, cfg, attrs));
    aclrtLaunchKernelCfg* cfgPtr = (cfg.numAttrs > 0) ? &cfg : nullptr;

    aclError ret = aclrtLaunchKernelWithConfig(funcHandle, blockDim, stream, cfgPtr, argsHandle, reserve);
    return Py_BuildValue("i", ret);
}