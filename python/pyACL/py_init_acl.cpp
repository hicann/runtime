/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <Python.h>
#include <vector>
#include <string>
#include "acl/acl.h"
#include "rt/pyrt_methods.h"
#include "mdl/pymdl_methods.h"
#include "media/pymedia_methods.h"
#include "op/pyop_methods.h"
#include "blas/pyblas_methods.h"
#include "util/pyutil_methods.h"
#include "prof/pyprof_methods.h"
#include "himpi/pyhimpi_methods.h"
#include "fv/pyfv_methods.h"

#ifdef ASCEND_CI_LIMITED_PY37
#undef PyCFunction_NewEx
#endif

namespace {
PyObject* WrapAclInit(PyObject* /* self */, PyObject* args)
{
    const char* path = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "|s", &path), "acl.init args parse failed");

    aclError ret = aclInit(path);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclFinalize(PyObject* /* self */, PyObject* /* args */)
{
    aclError ret = aclFinalize();
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetVersion(PyObject* /* self */, PyObject* /* args */)
{
    int32_t majorVersion = 0;
    int32_t minorVersion = 0;
    int32_t patchVersion = 0;

    aclError ret = aclrtGetVersion(&majorVersion, &minorVersion, &patchVersion);
    return Py_BuildValue("iiii", majorVersion, minorVersion, patchVersion, ret);
}

PyObject* WrapAclRtGetSocName(PyObject* /* self */, PyObject* /* args */)
{
    const char* ret = aclrtGetSocName();
    return Py_BuildValue("s", ret);
}

PyObject* WrapAclFloat16ToFloat(PyObject* /* self */, PyObject* args)
{
    aclFloat16 value = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "H", &value), "acl.float16_to_float args parse failed");

    float output = aclFloat16ToFloat(value);
    return Py_BuildValue("f", output);
}

PyObject* WrapAclFloatToFloat16(PyObject* /* self */, PyObject* args)
{
    float value = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "f", &value), "acl.float_to_float16 args parse failed");

    aclFloat16 output = aclFloatToFloat16(value);
    return Py_BuildValue("H", output);
}

PyObject* WrapAclCreateDataBuffer(PyObject* /* self */, PyObject* args)
{
    void* data = nullptr;
    unsigned long size = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &data, &size), "acl.create_data_buffer args parse failed");

    aclDataBuffer* output = aclCreateDataBuffer(data, size);
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(output));
}

PyObject* WrapAclDestroyDataBuffer(PyObject* /* self */, PyObject* args)
{
    aclDataBuffer* dataBuffer = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &dataBuffer), "acl.destroy_data_buffer args parse failed");

    aclError ret = aclDestroyDataBuffer(dataBuffer);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclGetDataBufferAddr(PyObject* /* self */, PyObject* args)
{
    aclDataBuffer* dataBuffer = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &dataBuffer), "acl.get_data_buffer_addr args parse failed");

    void* addr = aclGetDataBufferAddr(dataBuffer);
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(addr));
}

PyObject* WrapAclGetDataBufferSize(PyObject* /* self */, PyObject* args)
{
    aclDataBuffer* dataBuffer = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &dataBuffer), "acl.get_data_buffer_size args parse failed");

    size_t bufSize = aclGetDataBufferSize(dataBuffer);
    return Py_BuildValue("k", bufSize);
}

PyObject* WrapAclGetDataBufferSizeV2(PyObject* /* self */, PyObject* args)
{
    aclDataBuffer* dataBuffer = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &dataBuffer), "acl.get_data_buffer_size_v2 args parse failed");

    size_t bufSize = aclGetDataBufferSizeV2(dataBuffer);
    return Py_BuildValue("k", bufSize);
}

PyObject* WrapAclUpdateDataBuffer(PyObject* /* self */, PyObject* args)
{
    aclDataBuffer* dataBuffer = nullptr;
    void* data = nullptr;
    unsigned long size = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kkk", &dataBuffer, &data, &size), "acl.update_data_buffer args parse failed");

    aclError ret = aclUpdateDataBuffer(dataBuffer, data, size);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclDataTypeSize(PyObject* /* self */, PyObject* args)
{
    aclDataType dataType = ACL_DT_UNDEFINED;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &dataType), "acl.data_type_size args parse failed");

    size_t size = aclDataTypeSize(dataType);
    return Py_BuildValue("k", size);
}

PyObject* WrapAclCreateTensorDesc(PyObject* /* self */, PyObject* args)
{
    aclDataType dataType = ACL_DT_UNDEFINED;
    aclFormat format = ACL_FORMAT_UNDEFINED;
    PyObject* pyDimsList = nullptr;
    aclTensorDesc* tensor = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOi", &dataType, &pyDimsList, &format), "acl.create_tensor_desc args parse failed");
    CHECK_NULL(PyList_Check(pyDimsList), "argument 2 is not list");

    int numDims = static_cast<int>(PyList_Size(pyDimsList));
    CHECK_NULL(numDims >= 0, "list is empty");
    std::vector<int64_t> dims(numDims + 1);
    CHECK_NULL(GetValuesFromPyList(pyDimsList, dims));

    tensor = aclCreateTensorDesc(dataType, numDims, dims.data(), format);
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(tensor));
}

PyObject* WrapAclDestroyTensorDesc(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* desc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &desc), "acl.destroy_tensor_desc args parse failed");

    aclDestroyTensorDesc(desc);
    Py_INCREF(Py_None);
    return Py_None;
}

PyObject* WrapAclGetTensorDescType(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* desc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &desc), "acl.get_tensor_desc_type args parse failed");

    aclDataType type = aclGetTensorDescType(desc);
    return Py_BuildValue("i", type);
}

PyObject* WrapAclGetTensorDescFormat(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* desc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &desc), "acl.get_tensor_desc_format args parse failed");

    aclFormat format = aclGetTensorDescFormat(desc);
    return Py_BuildValue("i", format);
}

PyObject* WrapAclGetTensorDescSize(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* desc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &desc), "acl.get_tensor_desc_size args parse failed");

    size_t size = aclGetTensorDescSize(desc);
    return Py_BuildValue("k", size);
}

PyObject* WrapAclGetTensorDescElementCount(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* desc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &desc), "acl.get_tensor_desc_element_count args parse failed");

    size_t count = aclGetTensorDescElementCount(desc);
    return Py_BuildValue("k", count);
}

PyObject* WrapAclGetTensorDescNumDims(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* desc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &desc), "acl.get_tensor_desc_num_dims args parse failed");

    size_t num = aclGetTensorDescNumDims(desc);
    return Py_BuildValue("k", num);
}

PyObject* WrapAclGetTensorDescDim(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* desc = nullptr;
    unsigned long index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &desc, &index), "acl.get_tensor_desc_dim args parse failed");

    int64_t size = aclGetTensorDescDim(desc, index);
    return Py_BuildValue("L", static_cast<long long>(size));
}

PyObject* WrapAclGetTensorDescName(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* desc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &desc), "acl.get_tensor_desc_name args parse failed");

    const char* name = aclGetTensorDescName(desc);
    return Py_BuildValue("s", name);
}

PyObject* WrapAclSetTensorDescName(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* desc = nullptr;
    const char* name = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "ks", &desc, &name), "acl.set_tensor_desc_name args parse failed");

    aclSetTensorDescName(desc, name);
    Py_INCREF(Py_None);
    return Py_None;
}

PyObject* WrapAclTransTensorDescFormat(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* srcDesc = nullptr;
    aclFormat format = ACL_FORMAT_UNDEFINED;

    CHECK_NULL(PyArg_ParseTuple(args, "ki", &srcDesc, &format), "acl.trans_tensor_desc_format args parse failed");

    aclTensorDesc* dstDesc = nullptr;
    aclError iRet = aclTransTensorDescFormat(srcDesc, format, &dstDesc);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(dstDesc), iRet);
}

PyObject* WrapAclAppLog(PyObject* /* self */, PyObject* args)
{
    int logLevel = 0;
    char* fmt = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "is", &logLevel, &fmt), "acl.app_log args parse failed");

    ACL_APP_LOG(static_cast<aclLogLevel>(logLevel), "%s", fmt);
    Py_INCREF(Py_None);
    return Py_None;
}

PyObject* WrapAclSetTensorStorageFormat(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* tensorDesc = nullptr;
    aclFormat format = ACL_FORMAT_UNDEFINED;

    CHECK_NULL(PyArg_ParseTuple(args, "ki", &tensorDesc, &format), "acl.set_tensor_storage_format args parse failed!");

    aclError ret = aclSetTensorStorageFormat(tensorDesc, static_cast<aclFormat>(format));
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclSetTensorFormat(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* tensorDesc = nullptr;
    aclFormat format = ACL_FORMAT_UNDEFINED;

    CHECK_NULL(PyArg_ParseTuple(args, "ki", &tensorDesc, &format), "acl.set_tensor_format args parse failed!");

    aclError ret = aclSetTensorFormat(tensorDesc, static_cast<aclFormat>(format));
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclSetTensorOriginFormat(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* tensorDesc = nullptr;
    aclFormat format = ACL_FORMAT_UNDEFINED;

    CHECK_NULL(PyArg_ParseTuple(args, "ki", &tensorDesc, &format), "acl.set_tensor_origin_format args parse failed!");

    aclError ret = aclSetTensorOriginFormat(tensorDesc, static_cast<aclFormat>(format));
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclSetTensorDynamicInput(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* tensorDesc = nullptr;
    const char* dynamicInputName = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ks", &tensorDesc, &dynamicInputName),
        "acl.set_tensor_dynamic_input args parse failed!");

    aclError ret = aclSetTensorDynamicInput(tensorDesc, dynamicInputName);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclSetTensorStorageShape(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* tensorDesc = nullptr;
    PyObject* dimsList = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kO", &tensorDesc, &dimsList), "acl.set_tensor_storage_shape args parse failed!");
    CHECK_NULL(PyList_Check(dimsList), "argument 2 is not list");

    int numDims = static_cast<int>(PyList_Size(dimsList));
    CHECK_NULL(numDims >= 0, "list is empty", PyExc_ValueError);
    std::vector<int64_t> dims(numDims + 1);
    CHECK_NULL(GetValuesFromPyList(dimsList, dims));

    aclError ret = aclSetTensorStorageShape(tensorDesc, numDims, dims.data());
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclSetTensorShape(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* tensorDesc = nullptr;
    PyObject* dimsList = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kO", &tensorDesc, &dimsList), "acl.set_tensor_shape args parse failed!");
    CHECK_NULL(PyList_Check(dimsList), "argument 2 is not list");

    int numDims = static_cast<int>(PyList_Size(dimsList));
    CHECK_NULL(numDims >= 0, "list is empty", PyExc_ValueError);
    std::vector<int64_t> dims(numDims + 1);
    CHECK_NULL(GetValuesFromPyList(dimsList, dims));

    aclError ret = aclSetTensorShape(tensorDesc, numDims, dims.data());
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclSetTensorOriginShape(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* tensorDesc = nullptr;
    PyObject* dimsList = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kO", &tensorDesc, &dimsList), "acl.set_tensor_origin_shape args parse failed!");
    CHECK_NULL(PyList_Check(dimsList), "argument 2 is not list");

    int numDims = static_cast<int>(PyList_Size(dimsList));
    CHECK_NULL(numDims >= 0, "list is empty", PyExc_ValueError);
    std::vector<int64_t> dims(numDims + 1);
    CHECK_NULL(GetValuesFromPyList(dimsList, dims));

    aclError ret = aclSetTensorOriginShape(tensorDesc, numDims, dims.data());
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclSetTensorShapeRange(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* tensorDesc = nullptr;
    PyObject* dimsList = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kO", &tensorDesc, &dimsList), "acl.set_tensor_shape_range args parse failed!");
    CHECK_NULL(PyList_Check(dimsList), "argument 2 is not list");

    ssize_t numDims = PyList_Size(dimsList);
    CHECK_NULL(numDims >= 0, "list is empty", PyExc_ValueError);
    int rangeSize = 2;
    ssize_t product = numDims * rangeSize;
    // 判断乘法溢出
    CHECK_NULL(product / rangeSize == numDims, "the length of list is too large", PyExc_ValueError);
    std::vector<int64_t> dims((product) + 1);
    CHECK_NULL(ConvertPyListToLongLongArrayV2(dimsList, static_cast<int>(numDims), rangeSize, dims));

    aclError ret = aclSetTensorShapeRange(tensorDesc, numDims, reinterpret_cast<int64_t(*)[2]>(dims.data()));
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclGetTensorDescAddress(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* tensorDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &tensorDesc), "acl.get_tensor_desc_address args parse failed!");

    void* tensor = aclGetTensorDescAddress(tensorDesc);
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(tensor));
}

PyObject* WrapAclGetTensorDescByIndex(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* tensorDesc = nullptr;
    size_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &tensorDesc, &index), "acl.get_tensor_desc_by_index args parse failed!");

    void* tensor = aclGetTensorDescByIndex(tensorDesc, index);
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(tensor));
}

PyObject* WrapAclGetTensorDescDimRange(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* tensorDesc = nullptr;
    size_t index = 0;
    size_t dimRangeNum = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkk", &tensorDesc, &index, &dimRangeNum),
        "acl.get_tensor_desc_dim_range args parse failed!");

    const size_t dimRangeNumLimit = 4096;
    if (dimRangeNum > dimRangeNumLimit) {
        ACL_APP_LOG(ACL_ERROR, "Invalid param of dim_range_num");
        return Py_BuildValue("Oi", Py_None, ACL_ERROR_INVALID_PARAM);
    }

    std::vector<int64_t> dimRange(dimRangeNum + 1);
    aclError ret = aclGetTensorDescDimRange(tensorDesc, index, dimRangeNum, dimRange.data());
    if (ret != ACL_SUCCESS) {
        ACL_APP_LOG(ACL_ERROR, "aclGetTensorDescDimRange failed, dimRangeNum = %d, ret = %d", dimRangeNum, ret);
        return Py_BuildValue("Oi", Py_None, ret);
    }

    PyObject* pList = PyList_New(dimRangeNum); // new reference
    CHECK_NULL(pList, "memory malloc failed", PyExc_MemoryError);
    for (size_t i = 0; i < dimRangeNum; ++i) {
        PyList_SetItem(pList, i, Py_BuildValue("l", dimRange[i])); // NPY_INT64
    }
    PyObject* obj = Py_BuildValue("Oi", pList, ret);
    Py_XDECREF(pList);
    return obj;
}

PyObject* WrapAclGetTensorDescDimV2(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* desc = nullptr;
    unsigned long index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &desc, &index), "acl.get_tensor_desc_dim_v2 args parse failed");

    int64_t size = 0;
    aclError ret = aclGetTensorDescDimV2(desc, index, &size);
    return Py_BuildValue("Li", static_cast<int64_t>(size), ret);
}

PyObject* WrapAclSetTensorConst(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* desc = nullptr;
    void* data = nullptr;
    unsigned long size;

    CHECK_NULL(PyArg_ParseTuple(args, "kkk", &desc, &data, &size), "acl.set_tensor_const args parse failed");

    aclError ret = aclSetTensorConst(desc, data, size);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclSetTensorPlaceMent(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* desc = nullptr;
    aclMemType memType = ACL_MEMTYPE_DEVICE;

    CHECK_NULL(PyArg_ParseTuple(args, "ki", &desc, &memType), "acl.set_tensor_place_ment args parse failed");

    aclError ret = aclSetTensorPlaceMent(desc, memType);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclGetRecentErrMsg(PyObject* /* self */, PyObject* /* args */)
{
    const char* ret = aclGetRecentErrMsg();
    return Py_BuildValue("s", ret);
}

PyObject* WrapAclSetTensorValueRange(PyObject* /* self */, PyObject* args)
{
    aclTensorDesc* desc = nullptr;
    PyObject* valueRangeObj = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kO", &desc, &valueRangeObj), "acl.set_tensor_value_range args parse failed!");

    CHECK_NULL(PyList_Check(valueRangeObj), "int64_t argument is not list");
    int count = static_cast<int>(PyList_Size(valueRangeObj));
    int len = ACL_TENSOR_VALUE_RANGE_NUM;
    std::vector<int64_t> valueRange(count * len);
    CHECK_NULL(ConvertPyListToLongLongArrayV2(valueRangeObj, count, len, valueRange));

    aclError ret = aclSetTensorValueRange(desc, count, reinterpret_cast<int64_t(*)[2]>(valueRange.data()));
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclGetCannAttributeList(PyObject* /* self */, PyObject* /* args */)
{
    const aclCannAttr* cannAttrList = nullptr;
    size_t num = 0;
    aclError ret = aclGetCannAttributeList(&cannAttrList, &num);
    PyObject* pyCannAttrList = GetPyListFromArray(cannAttrList, static_cast<int>(num));
    CHECK_NULL(pyCannAttrList);
    CHECK_NULL(PyList_Check(pyCannAttrList));
    PyObject* obj = Py_BuildValue("Oki", pyCannAttrList, num, ret);
    Py_XDECREF(pyCannAttrList);
    return obj;
}

PyObject* WrapAclGetCannAttribute(PyObject* /* self */, PyObject* args)
{
    aclCannAttr cannAttr = ACL_CANN_ATTR_UNDEFINED;
    int32_t value = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &cannAttr), "acl.get_cann_attribute args parse failed");

    aclError ret = aclGetCannAttribute(cannAttr, &value);
    return Py_BuildValue("ii", value, ret);
}

PyObject* WrapAclGetDeviceCapability(PyObject* /* self */, PyObject* args)
{
    uint32_t deviceId = 0;
    aclDeviceInfo deviceInfo = ACL_DEVICE_INFO_UNDEFINED;
    int64_t value = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "Ii", &deviceId, &deviceInfo), "acl.get_device_capability args parse failed");

    aclError ret = aclGetDeviceCapability(deviceId, deviceInfo, &value);
    return Py_BuildValue("Li", value, ret);
}

static PyObject* GetPyDictFromVersion(aclCANNPackageVersion& version)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "version", Py_BuildValue("s", version.version)));
    CHECK_NULL(SetItemToDict(pyDict, "major_version", Py_BuildValue("s", version.majorVersion)));
    CHECK_NULL(SetItemToDict(pyDict, "minor_version", Py_BuildValue("s", version.minorVersion)));
    CHECK_NULL(SetItemToDict(pyDict, "release_version", Py_BuildValue("s", version.releaseVersion)));
    CHECK_NULL(SetItemToDict(pyDict, "patch_version", Py_BuildValue("s", version.patchVersion)));
    CHECK_NULL(SetItemToDict(pyDict, "reserved", Py_BuildValue("s", version.reserved)));
    return pyDict;
}

PyObject* WrapAclsysGetCANNVersion(PyObject* /* self */, PyObject* args)
{
    aclCANNPackageName name = ACL_PKG_NAME_CANN;
    aclCANNPackageVersion version{};

    CHECK_NULL(PyArg_ParseTuple(args, "I", &name), "acl.get_cann_version args parse failed");

    aclError ret = aclsysGetCANNVersion(name, &version);

    PyObject* pyVersion = GetPyDictFromVersion(version);
    CHECK_NULL(pyVersion)
    PyObject* obj = Py_BuildValue("OI", pyVersion, ret);
    Py_XDECREF(pyVersion);
    return obj;
}

PyObject* WrapAclFinalizeReference(PyObject* /* self */, PyObject* /* args */)
{
    uint64_t refCount = 0;
    aclError ret = aclFinalizeReference(&refCount);
    return Py_BuildValue("Ki", refCount, ret);
}

PyObject* WrapAclsysGetVersionStr(PyObject* /* self */, PyObject* args)
{
    char* pkgName = nullptr;
    char versionStr[ACL_PKG_VERSION_MAX_SIZE] = {0};
    CHECK_NULL(PyArg_ParseTuple(args, "s", &pkgName), "acl.get_version_str args parse failed");
    aclError ret = aclsysGetVersionStr(pkgName, versionStr);
    return Py_BuildValue("si", versionStr, ret);
}

} // namespace

static PyMethodDef g_moduleMethods[] = {
    {"init", WrapAclInit, METH_VARARGS, "acl init"},
    {"finalize", WrapAclFinalize, METH_VARARGS, "acl finalize"},
    {"get_version", WrapAclRtGetVersion, METH_VARARGS, "acl get version"},
    {"get_soc_name", WrapAclRtGetSocName, METH_VARARGS, "get soc name"},
    {"float16_to_float", WrapAclFloat16ToFloat, METH_VARARGS, "aclFloat16 type to float"},
    {"float_to_float16", WrapAclFloatToFloat16, METH_VARARGS, "float to float16"},
    {"create_data_buffer", WrapAclCreateDataBuffer, METH_VARARGS, "create data buffer"},
    {"destroy_data_buffer", WrapAclDestroyDataBuffer, METH_VARARGS, "destroy data buffer"},
    {"get_data_buffer_addr", WrapAclGetDataBufferAddr, METH_VARARGS, "get data addr from databuffer"},
    {"get_data_buffer_size", WrapAclGetDataBufferSize, METH_VARARGS, "get data size from databuffer"},
    {"get_data_buffer_size_v2", WrapAclGetDataBufferSizeV2, METH_VARARGS, "get data size from databuffer v2"},
    {"update_data_buffer", WrapAclUpdateDataBuffer, METH_VARARGS, "update data buffer"},
    {"data_type_size", WrapAclDataTypeSize, METH_VARARGS, "get data type size"},
    {"create_tensor_desc", WrapAclCreateTensorDesc, METH_VARARGS, "create tensor desc"},
    {"destroy_tensor_desc", WrapAclDestroyTensorDesc, METH_VARARGS, "destroy tensor desc"},
    {"get_tensor_desc_type", WrapAclGetTensorDescType, METH_VARARGS, "get tensor desc type"},
    {"get_tensor_desc_format", WrapAclGetTensorDescFormat, METH_VARARGS, "get tensor desc format"},
    {"get_tensor_desc_size", WrapAclGetTensorDescSize, METH_VARARGS, "create tensor desc size"},
    {"get_tensor_desc_element_count", WrapAclGetTensorDescElementCount, METH_VARARGS, "get tensor desc element count"},
    {"get_tensor_desc_num_dims", WrapAclGetTensorDescNumDims, METH_VARARGS, "get tensor desc dims"},
    {"get_tensor_desc_dim", WrapAclGetTensorDescDim, METH_VARARGS, "get dim of someone tensor desc"},
    {"get_tensor_desc_name", WrapAclGetTensorDescName, METH_VARARGS, "get name of tensor desc"},
    {"set_tensor_desc_name", WrapAclSetTensorDescName, METH_VARARGS, "set name of tensor desc"},
    {"trans_tensor_desc_format", WrapAclTransTensorDescFormat, METH_VARARGS,
     "generate dstTensor according to srcTensor and dstformat, srcTensor remain unchanged"},
    {"app_log", WrapAclAppLog, METH_VARARGS, "record log"},
    {"set_tensor_storage_format", WrapAclSetTensorStorageFormat, METH_VARARGS, "set tensor storage format"},
    {"set_tensor_storage_shape", WrapAclSetTensorStorageShape, METH_VARARGS, "set tensor storage shape"},
    {"set_tensor_format", WrapAclSetTensorFormat, METH_VARARGS, "set tensor format"},
    {"set_tensor_shape", WrapAclSetTensorShape, METH_VARARGS, "set tensor shape"},
    {"set_tensor_origin_format", WrapAclSetTensorOriginFormat, METH_VARARGS, "set tensor origin format"},
    {"set_tensor_dynamic_input", WrapAclSetTensorDynamicInput, METH_VARARGS, "set tensor dynamic input"},
    {"set_tensor_origin_shape", WrapAclSetTensorOriginShape, METH_VARARGS, "set tensor origin shape"},
    {"set_tensor_shape_range", WrapAclSetTensorShapeRange, METH_VARARGS, "set tensor shape range"},
    {"get_tensor_desc_address", WrapAclGetTensorDescAddress, METH_VARARGS, "get tensor desc address"},
    {"get_tensor_desc_by_index", WrapAclGetTensorDescByIndex, METH_VARARGS, "get tensor desc by index"},
    {"get_tensor_desc_dim_range", WrapAclGetTensorDescDimRange, METH_VARARGS, "get tensor desc dim range"},
    {"get_tensor_desc_dim_v2", WrapAclGetTensorDescDimV2, METH_VARARGS, "get tensor desc dim v2"},
    {"set_tensor_place_ment", WrapAclSetTensorPlaceMent, METH_VARARGS, "set tensor place ment"},
    {"get_recent_err_msg", WrapAclGetRecentErrMsg, METH_VARARGS, "get recent err msg"},
    {"set_tensor_const", WrapAclSetTensorConst, METH_VARARGS, "set tensor const"},
    {"set_tensor_value_range", WrapAclSetTensorValueRange, METH_VARARGS, "set tensor value range"},
    {"get_cann_attribute_list", WrapAclGetCannAttributeList, METH_VARARGS, "get cann attribute list"},
    {"get_cann_attribute", WrapAclGetCannAttribute, METH_VARARGS, "get cann attribute"},
    {"get_device_capability", WrapAclGetDeviceCapability, METH_VARARGS, "get device capability"},
    {"get_cann_version", WrapAclsysGetCANNVersion, METH_VARARGS, "get cann version"},
    {"finalize_reference", WrapAclFinalizeReference, METH_VARARGS, "acl finalize reference"},
    {"get_version_str", WrapAclsysGetVersionStr, METH_VARARGS, "get version str"},
    {nullptr, nullptr, 0, nullptr}};

static struct PyModuleDef g_mylibMethods = {
    PyModuleDef_HEAD_INIT,
    "acl", // name of module
    "",    // module documentation, may be nullptr
    -1,    // size of per-interpreter state of the module, or -1 if the module keeps state in global variables.
    g_moduleMethods,
    nullptr,
    nullptr,
    nullptr,
    nullptr};

static void AddSubModule(PyObject* root, const char* name, PyMethodDef* methods)
{
    PyObject* d = PyModule_GetDict(root);
    std::string nameStr = name;
    std::string moduleName = "acl." + nameStr;
    PyObject* submod = PyDict_GetItemString(d, name);
    if (submod == nullptr) {
        submod = PyImport_AddModule(moduleName.c_str());
        PyDict_SetItemString(d, name, submod);
        Py_XDECREF(submod);
    }

    // populate module's dict
    d = PyModule_GetDict(submod);
    for (PyMethodDef* m = methods; m->ml_name != nullptr; ++m) {
        PyObject* methodObj = PyCFunction_NewEx(m, nullptr, nullptr);
        PyDict_SetItemString(d, m->ml_name, methodObj);
        Py_XDECREF(methodObj);
    }
}

#ifdef __cplusplus
extern "C" {
#endif

__attribute__((visibility("default"))) PyObject* PyInit_acl(void)
{
    PyObject* m = PyModule_Create(&g_mylibMethods);
    AddSubModule(m, "rt", GetRtMethods());
    AddSubModule(m, "mdl", GetMdlMethods());
    AddSubModule(m, "media", GetMediaMethods());
    AddSubModule(m, "op", GetOpMethods());
    AddSubModule(m, "blas", GetBlasMethods());
    AddSubModule(m, "util", GetUtilMethods());
    AddSubModule(m, "prof", GetProfMethods());
    AddSubModule(m, "himpi", GetHimpiMethods());
    AddSubModule(m, "fv", GetFvMethods());
    return m;
}

#ifdef __cplusplus
}
#endif
