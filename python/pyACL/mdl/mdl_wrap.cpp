/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "mdl_wrap.h"
#include <vector>
#include <securec.h>
#include "acl/acl.h"
#include "acl/acl_dump.h"

namespace {
PyObject* g_dumpCallback = nullptr;
} // anonymous namespace

PyObject* WrapAclMdlLoadFromFile(PyObject* /* self */, PyObject* args)
{
    const char* modelPath = nullptr;
    uint32_t modelId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "s", &modelPath), "acl.mdl.load_from_file args parse failed!");

    aclError ret = aclmdlLoadFromFile(modelPath, &modelId);
    return Py_BuildValue("Ii", modelId, ret);
}

PyObject* WrapAclMdlLoadFromMem(PyObject* /* self */, PyObject* args)
{
    const void* model = nullptr;
    size_t modelSize = 0;
    uint32_t modelId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &model, &modelSize), "acl.mdl.load_from_mem args parse failed!");

    aclError ret = aclmdlLoadFromMem(model, modelSize, &modelId);
    return Py_BuildValue("Ii", modelId, ret);
}

PyObject* WrapAclMdlLoadFromFileWithMem(PyObject* /* self */, PyObject* args)
{
    const char* modelPath = nullptr;
    void* workPtr = nullptr;
    size_t workSize = 0;
    void* weightPtr = nullptr;
    size_t weightSize = 0;
    uint32_t modelId = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "skkkk", &modelPath, &workPtr, &workSize, &weightPtr, &weightSize),
        "acl.mdl.load_from_file_with_mem args parse failed!");

    aclError ret = aclmdlLoadFromFileWithMem(modelPath, &modelId, workPtr, workSize, weightPtr, weightSize);

    return Py_BuildValue("Ii", modelId, ret);
}

PyObject* WrapAclMdlLoadFromMemWithMem(PyObject* /* self */, PyObject* args)
{
    const void* model = nullptr;
    size_t modelSize = 0;
    void* workPtr = nullptr;
    size_t workSize = 0;
    void* weightPtr = nullptr;
    size_t weightSize = 0;
    uint32_t modelId = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkkk", &model, &modelSize, &workPtr, &workSize, &weightPtr, &weightSize),
        "acl.mdl.load_from_mem_with_mem args parse failed!");

    aclError ret = aclmdlLoadFromMemWithMem(model, modelSize, &modelId, workPtr, workSize, weightPtr, weightSize);
    return Py_BuildValue("Ii", modelId, ret);
}

PyObject* WrapAclMdlUnload(PyObject* /* self */, PyObject* args)
{
    uint32_t modelId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "I", &modelId), "acl.mdl.unload args parse failed!");

    aclError ret = aclmdlUnload(modelId);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlQuerySize(PyObject* /* self */, PyObject* args)
{
    const char* fileName = nullptr;
    size_t workSize = 0;
    size_t weightSize = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "s", &fileName), "acl.mdl.query_size args parse failed!");

    aclError ret = aclmdlQuerySize(fileName, &workSize, &weightSize);
    return Py_BuildValue("kki", workSize, weightSize, ret);
}

PyObject* WrapAclMdlQuerySizeFromMem(PyObject* /* self */, PyObject* args)
{
    const void* model = nullptr;
    size_t modelSize = 0;
    size_t workSize = 0;
    size_t weightSize = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &model, &modelSize), "acl.mdl.query_size_from_mem args parse failed!");

    aclError ret = aclmdlQuerySizeFromMem(model, modelSize, &workSize, &weightSize);
    return Py_BuildValue("kki", workSize, weightSize, ret);
}

PyObject* WrapAclMdlSetDynamicBatchSize(PyObject* /* self */, PyObject* args)
{
    uint32_t modelId = 0;
    aclmdlDataset* dataset = nullptr;
    size_t index = 0;
    uint64_t batchSize = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "IkkK", &modelId, &dataset, &index, &batchSize),
        "acl.mdl.set_dynamic_batch_size args parse failed!");

    aclError ret = aclmdlSetDynamicBatchSize(modelId, dataset, index, batchSize);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlSetDynamicHWSize(PyObject* /* self */, PyObject* args)
{
    uint32_t modelId = 0;
    aclmdlDataset* dataset = nullptr;
    size_t index = 0;
    uint64_t height = 0;
    uint64_t width = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "IkkKK", &modelId, &dataset, &index, &height, &width),
        "acl.mdl.set_dynamic_hw_size args parse failed!");

    aclError ret = aclmdlSetDynamicHWSize(modelId, dataset, index, height, width);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlExecute(PyObject* /* self */, PyObject* args)
{
    uint32_t modelId = 0;
    const aclmdlDataset* input = nullptr;
    aclmdlDataset* output = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "Ikk", &modelId, &input, &output), "acl.mdl.execute args parse failed!");

    aclError ret = aclmdlExecute(modelId, input, output);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlExecuteAsync(PyObject* /* self */, PyObject* args)
{
    uint32_t modelId = 0;
    const aclmdlDataset* input = nullptr;
    aclmdlDataset* output = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "Ikkk", &modelId, &input, &output, &stream), "acl.mdl.execute_async args parse failed!");

    aclError ret = aclmdlExecuteAsync(modelId, input, output, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlGetDatasetBuffer(PyObject* /* self */, PyObject* args)
{
    const aclmdlDataset* dataset = nullptr;
    size_t index = 0;
    aclDataBuffer* pRet = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &dataset, &index), "acl.mdl.get_dataset_buffer args parse failed!");

    pRet = aclmdlGetDatasetBuffer(dataset, index);
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(pRet));
}

PyObject* WrapAclMdlGetDatasetNumBuffers(PyObject* /* self */, PyObject* args)
{
    const aclmdlDataset* dataset = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &dataset), "acl.mdl.get_dataset_num_buffers args parse failed!");

    size_t index = aclmdlGetDatasetNumBuffers(dataset);
    return Py_BuildValue("k", index);
}

PyObject* WrapAclMdlAddDatasetBuffer(PyObject* /* self */, PyObject* args)
{
    aclmdlDataset* dataset = nullptr;
    aclDataBuffer* dateBuffer = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &dataset, &dateBuffer), "acl.mdl.add_dataset_buffer args parse failed!");

    aclError ret = aclmdlAddDatasetBuffer(dataset, dateBuffer);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(dataset), ret);
}

PyObject* WrapAclMdlGetOutputSizeByIndex(PyObject* /* self */, PyObject* args)
{
    aclmdlDesc* modelDesc = nullptr;
    size_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &modelDesc, &index), "acl.mdl.get_output_size_by_index args parse failed!");

    index = aclmdlGetOutputSizeByIndex(modelDesc, index);
    return Py_BuildValue("k", index);
}

PyObject* WrapAclMdlGetNumInputs(PyObject* /* self */, PyObject* args)
{
    aclmdlDesc* modelDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &modelDesc), "acl.mdl.get_num_inputs args parse failed!");

    size_t ret = aclmdlGetNumInputs(modelDesc);
    return Py_BuildValue("k", ret);
}

PyObject* WrapAclMdlGetNumOutputs(PyObject* /* self */, PyObject* args)
{
    aclmdlDesc* modelDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &modelDesc), "acl.mdl.get_num_outputs args parse failed!");

    size_t ret = aclmdlGetNumOutputs(modelDesc);
    return Py_BuildValue("k", ret);
}

PyObject* WrapAclMdlGetInputSizeByIndex(PyObject* /* self */, PyObject* args)
{
    aclmdlDesc* modelDesc = nullptr;
    size_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &modelDesc, &index), "acl.mdl.get_input_size_by_index args parse failed!");

    index = aclmdlGetInputSizeByIndex(modelDesc, index);
    return Py_BuildValue("k", index);
}

PyObject* WrapAclMdlCreateDataset(PyObject* /* self */, PyObject* /* args */)
{
    aclmdlDataset* mdlDataset = nullptr;

    mdlDataset = aclmdlCreateDataset();

    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(mdlDataset));
}

PyObject* WrapAclMdlDestroyDataset(PyObject* /* self */, PyObject* args)
{
    const aclmdlDataset* dataset = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &dataset), "acl.mdl.destroy_dataset args parse failed!");

    aclError ret = aclmdlDestroyDataset(dataset);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlCreateDesc(PyObject* /* self */, PyObject* /* args */)
{
    aclmdlDesc* mdlDesc = nullptr;

    mdlDesc = aclmdlCreateDesc();

    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(mdlDesc));
}

PyObject* WrapAclMdlGetDesc(PyObject* /* self */, PyObject* args)
{
    aclmdlDesc* modelDesc = nullptr;
    uint32_t modelId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kI", &modelDesc, &modelId), "acl.mdl.get_desc args parse failed!");

    aclError ret = aclmdlGetDesc(modelDesc, modelId);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlDestroyDesc(PyObject* /* self */, PyObject* args)
{
    aclmdlDesc* modelDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &modelDesc), "acl.mdl.destroy_desc args parse failed!");

    aclError ret = aclmdlDestroyDesc(modelDesc);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlCreateAIPP(PyObject* /* self */, PyObject* args)
{
    uint64_t batchSize = 0;
    aclmdlAIPP* pRet = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "K", &batchSize), "acl.mdl.create_aipp args parse failed!");

    pRet = aclmdlCreateAIPP(batchSize);
    return Py_BuildValue("k", pRet);
}

PyObject* WrapAclMdlDestroyAIPP(PyObject* /* self */, PyObject* args)
{
    const aclmdlAIPP* aippParmsSet = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &aippParmsSet), "acl.mdl.destroy_aipp args parse failed!");

    aclError ret = aclmdlDestroyAIPP(aippParmsSet);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlGetInputDims(PyObject* /* self */, PyObject* args)
{
    const aclmdlDesc* modelDesc = nullptr;
    size_t index = 0;
    aclmdlIODims dims;
    CHECK_NULL(PyArg_ParseTuple(args, "kk", &modelDesc, &index), "acl.mdl.get_input_dims args parse failed!");

    // dict
    PyObject* pDict = PyDict_New(); // new reference
    CHECK_NULL(pDict, "memory malloc failed", PyExc_MemoryError);

    aclError ret = aclmdlGetInputDims(modelDesc, index, &dims);
    if (ret != 0) {
        PyObject* obj = Py_BuildValue("Oi", pDict, ret);
        Py_XDECREF(pDict);
        return obj;
    }

    // add name
    CHECK_NULL(SetItemToDict(pDict, "name", Py_BuildValue("s", dims.name)));
    // add counts
    CHECK_NULL(SetItemToDict(pDict, "dimCount", Py_BuildValue("k", dims.dimCount)));
    // array
    PyObject* pList = PyList_New(dims.dimCount); // new reference
    if (!pList) {
        Py_XDECREF(pDict);
        PyErr_SetString(PyExc_MemoryError, "memory malloc failed");
        return nullptr;
    }
    for (uint i = 0; i < dims.dimCount; ++i) {
        PyList_SetItem(pList, i, Py_BuildValue("l", dims.dims[i])); // NPY_INT64
    }
    // add array
    CHECK_NULL(SetItemToDict(pDict, "dims", pList));
    PyObject* obj = Py_BuildValue("Oi", pDict, ret);
    Py_XDECREF(pDict);

    return obj;
}

PyObject* WrapAclMdlGetInputDimsV2(PyObject* /* self */, PyObject* args)
{
    const aclmdlDesc* modelDesc = nullptr;
    size_t index = 0;
    aclmdlIODims dims;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &modelDesc, &index), "acl.mdl.get_input_dims_v2 args parse failed!");

    // dict
    PyObject* pDict = PyDict_New(); // new reference
    CHECK_NULL(pDict, "memory malloc failed", PyExc_MemoryError);

    aclError ret = aclmdlGetInputDimsV2(modelDesc, index, &dims);
    if (ret != 0) {
        PyObject* obj = Py_BuildValue("Oi", pDict, ret);
        Py_XDECREF(pDict);
        return obj;
    }

    // add name
    CHECK_NULL(SetItemToDict(pDict, "name", Py_BuildValue("s", dims.name)));
    // add counts
    CHECK_NULL(SetItemToDict(pDict, "dimCount", Py_BuildValue("k", dims.dimCount)));
    // array
    PyObject* pList = PyList_New(dims.dimCount); // new reference
    if (!pList) {
        Py_XDECREF(pDict);
        PyErr_SetString(PyExc_MemoryError, "memory malloc failed");
        return nullptr;
    }
    for (uint i = 0; i < dims.dimCount; ++i) {
        PyList_SetItem(pList, i, Py_BuildValue("l", dims.dims[i])); // NPY_INT64
    }
    // add array
    CHECK_NULL(SetItemToDict(pDict, "dims", pList));
    PyObject* obj = Py_BuildValue("Oi", pDict, ret);
    Py_XDECREF(pDict);

    return obj;
}

PyObject* WrapAclMdlGetOutputDims(PyObject* /* self */, PyObject* args)
{
    const aclmdlDesc* modelDesc = nullptr;
    size_t index = 0;
    aclmdlIODims dims;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &modelDesc, &index), "acl.mdl.get_output_dims args parse failed!");

    // dict
    PyObject* pDict = PyDict_New(); // new reference
    CHECK_NULL(pDict, "memory malloc failed", PyExc_MemoryError);

    aclError ret = aclmdlGetOutputDims(modelDesc, index, &dims);
    if (ret != 0) {
        PyObject* obj = Py_BuildValue("Oi", pDict, ret);
        Py_XDECREF(pDict);
        return obj;
    }

    // add name
    CHECK_NULL(SetItemToDict(pDict, "name", Py_BuildValue("s", dims.name)));
    // add counts
    CHECK_NULL(SetItemToDict(pDict, "dimCount", Py_BuildValue("k", dims.dimCount)));
    // array
    PyObject* pList = PyList_New(dims.dimCount); // new reference
    if (!pList) {
        Py_XDECREF(pDict);
        PyErr_SetString(PyExc_MemoryError, "memory malloc failed");
        return nullptr;
    }
    for (uint i = 0; i < dims.dimCount; ++i) {
        PyList_SetItem(pList, i, Py_BuildValue("l", dims.dims[i])); // NPY_INT64
    }
    // add array
    CHECK_NULL(SetItemToDict(pDict, "dims", pList));
    PyObject* obj = Py_BuildValue("Oi", pDict, ret);
    Py_XDECREF(pDict);

    return obj;
}

PyObject* WrapAclMdlGetInputNameByIndex(PyObject* /* self */, PyObject* args)
{
    const aclmdlDesc* modelDesc = nullptr;
    size_t index = 0;
    const char* strInputName = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &modelDesc, &index), "acl.mdl.get_input_name_by_index args parse failed!");

    strInputName = aclmdlGetInputNameByIndex(modelDesc, index);

    return Py_BuildValue("s", strInputName);
}

PyObject* WrapAclMdlGetOutputNameByIndex(PyObject* /* self */, PyObject* args)
{
    const aclmdlDesc* modelDesc = nullptr;
    size_t index = 0;
    const char* strOutputName = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &modelDesc, &index), "acl.mdl.get_output_name_by_index args parse failed!");

    strOutputName = aclmdlGetOutputNameByIndex(modelDesc, index);
    return Py_BuildValue("s", strOutputName);
}

PyObject* WrapAclMdlGetInputFormat(PyObject* /* self */, PyObject* args)
{
    const aclmdlDesc* modelDesc = nullptr;
    size_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &modelDesc, &index), "acl.mdl.get_input_format args parse failed!");

    aclFormat format = aclmdlGetInputFormat(modelDesc, index);
    return Py_BuildValue("i", format);
}

PyObject* WrapAclMdlGetOutputFormat(PyObject* /* self */, PyObject* args)
{
    const aclmdlDesc* modelDesc = nullptr;
    size_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &modelDesc, &index), "acl.mdl.get_output_format args parse failed!");

    aclFormat format = aclmdlGetOutputFormat(modelDesc, index);
    return Py_BuildValue("i", format);
}

PyObject* WrapAclMdlGetInputDataType(PyObject* /* self */, PyObject* args)
{
    const aclmdlDesc* modelDesc = nullptr;
    size_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &modelDesc, &index), "acl.mdl.get_input_data_type args parse failed!");

    aclDataType ret = aclmdlGetInputDataType(modelDesc, index);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlGetOutputDataType(PyObject* /* self */, PyObject* args)
{
    const aclmdlDesc* modelDesc = nullptr;
    size_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &modelDesc, &index), "acl.mdl.get_output_data_type args parse failed!");

    aclDataType ret = aclmdlGetOutputDataType(modelDesc, index);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlGetInputIndexByName(PyObject* /* self */, PyObject* args)
{
    const aclmdlDesc* modelDesc = nullptr;
    const char* name = nullptr;
    size_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "ks", &modelDesc, &name), "acl.mdl.get_input_index_by_name args parse failed!");

    aclError ret = aclmdlGetInputIndexByName(modelDesc, name, &index);
    return Py_BuildValue("ki", index, ret);
}

PyObject* WrapAclMdlGetOutputIndexByName(PyObject* /* self */, PyObject* args)
{
    const aclmdlDesc* modelDesc = nullptr;
    const char* name = nullptr;
    size_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "ks", &modelDesc, &name), "acl.mdl.get_output_index_by_name args parse failed!");

    aclError ret = aclmdlGetOutputIndexByName(modelDesc, name, &index);
    return Py_BuildValue("ki", index, ret);
}

PyObject* WrapAclMdlGetDynamicBatch(PyObject* /* self */, PyObject* args)
{
    const aclmdlDesc* modelDesc = nullptr;
    aclmdlBatch batch{};

    CHECK_NULL(PyArg_ParseTuple(args, "k", &modelDesc), "acl.mdl.get_dynamic_batch args parse failed!");

    PyObject* pDict = PyDict_New(); // new reference
    CHECK_NULL(pDict, "memory malloc failed", PyExc_MemoryError);

    aclError ret = aclmdlGetDynamicBatch(modelDesc, &batch);
    if (ret != 0) {
        PyObject* obj = Py_BuildValue("Oi", pDict, ret);
        Py_XDECREF(pDict);
        return obj;
    }

    CHECK_NULL(SetItemToDict(pDict, "batchCount", Py_BuildValue("I", batch.batchCount)));

    PyObject* pList = PyList_New(batch.batchCount); // new reference
    if (!pList) {
        Py_XDECREF(pDict);
        PyErr_SetString(PyExc_MemoryError, "memory malloc failed");
        return nullptr;
    }
    for (uint i = 0; i < batch.batchCount; ++i) {
        PyList_SetItem(pList, i, Py_BuildValue("k", batch.batch[i])); // NPY_UINT64
    }

    CHECK_NULL(SetItemToDict(pDict, "batch", pList));
    PyObject* obj = Py_BuildValue("Oi", pDict, ret);
    Py_XDECREF(pDict);

    return obj;
}

PyObject* WrapAclMdlGetDynamicHW(PyObject* /* self */, PyObject* args)
{
    const aclmdlDesc* modelDesc = nullptr;
    size_t index = -1;
    aclmdlHW hw{};

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &modelDesc, &index), "acl.mdl.get_dynamic_hw args parse failed!");

    PyObject* pDict = PyDict_New(); // new reference
    CHECK_NULL(pDict, "memory malloc failed", PyExc_MemoryError);

    aclError ret = aclmdlGetDynamicHW(modelDesc, index, &hw);
    if (ret != 0) {
        PyObject* obj = Py_BuildValue("Oi", pDict, ret);
        Py_XDECREF(pDict);
        return obj;
    }

    CHECK_NULL(SetItemToDict(pDict, "hwCount", Py_BuildValue("I", hw.hwCount))); //

    PyObject* pList = PyList_New(hw.hwCount);                                    // new reference
    if (!pList) {
        PyObject* obj = Py_BuildValue("Oi", pDict, ret);
        Py_XDECREF(pDict);
        return obj;
    }
    for (uint i = 0; i < hw.hwCount; ++i) {
        int hwSize = 2;                           // a set of height&width data array
        PyObject* pListTemp = PyList_New(hwSize); // new reference
        if (!pListTemp) {
            Py_XDECREF(pDict);
            Py_XDECREF(pList);
            return nullptr;
        }
        for (int j = 0; j < hwSize; j++) {
            PyList_SetItem(pListTemp, j, Py_BuildValue("k", hw.hw[i][j])); // NPY_UINT64
        }
        PyList_SetItem(pList, i, pListTemp);                               // uint64
    }

    CHECK_NULL(SetItemToDict(pDict, "hw", pList));
    PyObject* obj = Py_BuildValue("Oi", pDict, ret);
    Py_XDECREF(pDict);

    return obj;
}

PyObject* WrapAclMdlGetCurOutputDims(PyObject* /* self */, PyObject* args)
{
    const aclmdlDesc* modelDesc = nullptr;
    size_t index = 0;
    aclmdlIODims dims{};

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &modelDesc, &index), "acl.mdl.get_cur_output_dims args parse failed!");

    // dict
    PyObject* pDict = PyDict_New(); // new reference
    CHECK_NULL(pDict, "memory malloc failed", PyExc_MemoryError);

    aclError ret = aclmdlGetCurOutputDims(modelDesc, index, &dims);
    if (ret != 0) {
        PyObject* obj = Py_BuildValue("Oi", pDict, ret);
        Py_XDECREF(pDict);
        return obj;
    }

    // add name
    CHECK_NULL(SetItemToDict(pDict, "name", Py_BuildValue("s", dims.name)));
    // add counts
    CHECK_NULL(SetItemToDict(pDict, "dimCount", Py_BuildValue("k", dims.dimCount)));
    // array
    PyObject* pList = PyList_New(dims.dimCount); // new reference
    if (!pList) {
        Py_XDECREF(pDict);
        PyErr_SetString(PyExc_MemoryError, "memory malloc failed");
        return nullptr;
    }
    for (uint i = 0; i < dims.dimCount; ++i) {
        PyList_SetItem(pList, i, Py_BuildValue("l", dims.dims[i])); // NPY_INT64
    }
    // add array
    CHECK_NULL(SetItemToDict(pDict, "dims", pList));
    PyObject* obj = Py_BuildValue("Oi", pDict, ret);
    Py_XDECREF(pDict);

    return obj;
}

static bool SetAIPPCscParams(PyObject* pDict, const aclAippInfo& aippinfo)
{
    CHECK_STRUCT_DICT(pDict, "the aclAippInfo argument is not dict");
    CHECK_BOOL(SetItemToDict(pDict, "cscSwitch", Py_BuildValue("b", aippinfo.cscSwitch)));
    CHECK_BOOL(SetItemToDict(pDict, "matrixR0C0", Py_BuildValue("i", aippinfo.matrixR0C0)));
    CHECK_BOOL(SetItemToDict(pDict, "matrixR0C1", Py_BuildValue("i", aippinfo.matrixR0C1)));
    CHECK_BOOL(SetItemToDict(pDict, "matrixR1C0", Py_BuildValue("i", aippinfo.matrixR1C0)));
    CHECK_BOOL(SetItemToDict(pDict, "matrixR1C1", Py_BuildValue("i", aippinfo.matrixR1C1)));
    CHECK_BOOL(SetItemToDict(pDict, "matrixR1C2", Py_BuildValue("i", aippinfo.matrixR1C2)));
    CHECK_BOOL(SetItemToDict(pDict, "matrixR2C2", Py_BuildValue("i", aippinfo.matrixR2C2)));
    CHECK_BOOL(SetItemToDict(pDict, "outputBias0", Py_BuildValue("i", aippinfo.outputBias0)));
    CHECK_BOOL(SetItemToDict(pDict, "outputBias1", Py_BuildValue("i", aippinfo.outputBias1)));
    CHECK_BOOL(SetItemToDict(pDict, "outputBias2", Py_BuildValue("i", aippinfo.outputBias2)));
    CHECK_BOOL(SetItemToDict(pDict, "inputBias0", Py_BuildValue("i", aippinfo.inputBias0)));
    CHECK_BOOL(SetItemToDict(pDict, "inputBias1", Py_BuildValue("i", aippinfo.inputBias1)));
    CHECK_BOOL(SetItemToDict(pDict, "inputBias2", Py_BuildValue("i", aippinfo.inputBias2)));

    return true;
}

static bool SetAIPPInfo(PyObject* pDict, const aclAippInfo& aippinfo)
{
    CHECK_STRUCT_DICT(pDict, "the aclAippInfo argument is not dict");
    CHECK_BOOL(SetItemToDict(pDict, "rbuvSwapSwitch", Py_BuildValue("b", aippinfo.rbuvSwapSwitch)));
    CHECK_BOOL(SetItemToDict(pDict, "axSwapSwitch", Py_BuildValue("b", aippinfo.axSwapSwitch)));
    CHECK_BOOL(SetItemToDict(pDict, "singleLineMode", Py_BuildValue("b", aippinfo.singleLineMode)));
    CHECK_BOOL(SetItemToDict(pDict, "srcImageSizeW", Py_BuildValue("i", aippinfo.srcImageSizeW)));
    CHECK_BOOL(SetItemToDict(pDict, "srcImageSizeH", Py_BuildValue("i", aippinfo.srcImageSizeH)));
    CHECK_BOOL(SetItemToDict(pDict, "srcFormat", Py_BuildValue("I", aippinfo.srcFormat)));
    CHECK_BOOL(SetItemToDict(pDict, "srcDatatype", Py_BuildValue("I", aippinfo.srcDatatype)));
    CHECK_BOOL(SetItemToDict(pDict, "srcDimNum", Py_BuildValue("K", aippinfo.srcDimNum)));
    CHECK_BOOL(SetItemToDict(pDict, "shapeCount", Py_BuildValue("K", aippinfo.shapeCount)));
    CHECK_BOOL(SetItemToDict(pDict, "inputFormat", Py_BuildValue("I", aippinfo.inputFormat)));
    CHECK_BOOL(SetItemToDict(pDict, "aippExtend", Py_BuildValue("k", aippinfo.aippExtend)));

    return true;
}

static bool SetAIPPCropParams(PyObject* pDict, const aclAippInfo& aippinfo)
{
    CHECK_STRUCT_DICT(pDict, "the aclAippInfo argument is not dict");
    CHECK_BOOL(SetItemToDict(pDict, "cropSwitch", Py_BuildValue("b", aippinfo.cropSwitch)));
    CHECK_BOOL(SetItemToDict(pDict, "loadStartPosW", Py_BuildValue("i", aippinfo.loadStartPosW)));
    CHECK_BOOL(SetItemToDict(pDict, "loadStartPosH", Py_BuildValue("i", aippinfo.loadStartPosH)));
    CHECK_BOOL(SetItemToDict(pDict, "cropSizeW", Py_BuildValue("i", aippinfo.cropSizeW)));
    CHECK_BOOL(SetItemToDict(pDict, "cropSizeH", Py_BuildValue("i", aippinfo.cropSizeH)));
    CHECK_BOOL(SetItemToDict(pDict, "resizeSwitch", Py_BuildValue("b", aippinfo.resizeSwitch)));
    CHECK_BOOL(SetItemToDict(pDict, "resizeOutputW", Py_BuildValue("i", aippinfo.resizeOutputW)));
    CHECK_BOOL(SetItemToDict(pDict, "resizeOutputH", Py_BuildValue("i", aippinfo.resizeOutputH)));

    return true;
}

static bool SetAIPPPaddingParams(PyObject* pDict, const aclAippInfo& aippinfo)
{
    CHECK_STRUCT_DICT(pDict, "the aclAippInfo argument is not dict");
    CHECK_BOOL(SetItemToDict(pDict, "paddingSwitch", Py_BuildValue("b", aippinfo.paddingSwitch)));
    CHECK_BOOL(SetItemToDict(pDict, "leftPaddingSize", Py_BuildValue("i", aippinfo.leftPaddingSize)));
    CHECK_BOOL(SetItemToDict(pDict, "rightPaddingSize", Py_BuildValue("i", aippinfo.rightPaddingSize)));
    CHECK_BOOL(SetItemToDict(pDict, "topPaddingSize", Py_BuildValue("i", aippinfo.topPaddingSize)));
    CHECK_BOOL(SetItemToDict(pDict, "bottomPaddingSize", Py_BuildValue("i", aippinfo.bottomPaddingSize)));

    return true;
}

static bool SetAIPPDtcPixelMean(PyObject* pDict, const aclAippInfo& aippinfo)
{
    CHECK_STRUCT_DICT(pDict, "the aclAippInfo argument is not dict");
    CHECK_BOOL(SetItemToDict(pDict, "meanChn0", Py_BuildValue("i", aippinfo.meanChn0)));
    CHECK_BOOL(SetItemToDict(pDict, "meanChn1", Py_BuildValue("i", aippinfo.meanChn1)));
    CHECK_BOOL(SetItemToDict(pDict, "meanChn2", Py_BuildValue("i", aippinfo.meanChn2)));
    CHECK_BOOL(SetItemToDict(pDict, "meanChn3", Py_BuildValue("i", aippinfo.meanChn3)));

    return true;
}

static bool SetAIPPDtcPixelMin(PyObject* pDict, const aclAippInfo& aippinfo)
{
    CHECK_STRUCT_DICT(pDict, "the aclAippInfo argument is not dict");
    CHECK_BOOL(SetItemToDict(pDict, "minChn0", Py_BuildValue("f", aippinfo.minChn0)));
    CHECK_BOOL(SetItemToDict(pDict, "minChn1", Py_BuildValue("f", aippinfo.minChn1)));
    CHECK_BOOL(SetItemToDict(pDict, "minChn2", Py_BuildValue("f", aippinfo.minChn2)));
    CHECK_BOOL(SetItemToDict(pDict, "minChn3", Py_BuildValue("f", aippinfo.minChn3)));

    return true;
}

static bool SetAIPPPixelVarReci(PyObject* pDict, const aclAippInfo& aippinfo)
{
    CHECK_STRUCT_DICT(pDict, "the aclAippInfo argument is not dict");
    CHECK_BOOL(SetItemToDict(pDict, "varReciChn0", Py_BuildValue("f", aippinfo.varReciChn0)));
    CHECK_BOOL(SetItemToDict(pDict, "varReciChn1", Py_BuildValue("f", aippinfo.varReciChn1)));
    CHECK_BOOL(SetItemToDict(pDict, "varReciChn2", Py_BuildValue("f", aippinfo.varReciChn2)));
    CHECK_BOOL(SetItemToDict(pDict, "varReciChn3", Py_BuildValue("f", aippinfo.varReciChn3)));

    return true;
}

static PyObject* GetPydictFromAIPPIODims(const aclmdlIODims& aippIoDims)
{
    PyObject* pDict = PyDict_New(); // new reference
    CHECK_NULL(SetItemToDict(pDict, "name", Py_BuildValue("s", aippIoDims.name)));
    CHECK_NULL(SetItemToDict(pDict, "dimCount", Py_BuildValue("k", aippIoDims.dimCount)));
    CHECK_NULL(
        SetItemToDict(pDict, "dims", GetPyListFromArray(aippIoDims.dims, static_cast<int>(aippIoDims.dimCount))));

    return pDict;
}

static PyObject* GetPydictFromAIPPDims(const aclAippDims& aippDims)
{
    PyObject* pDict = PyDict_New(); // new reference
    CHECK_NULL(SetItemToDict(pDict, "srcDims", GetPydictFromAIPPIODims(aippDims.srcDims)));
    CHECK_NULL(SetItemToDict(pDict, "srcSize", Py_BuildValue("k", aippDims.srcSize)));
    CHECK_NULL(SetItemToDict(pDict, "aippOutdims", GetPydictFromAIPPIODims(aippDims.aippOutdims)));
    CHECK_NULL(SetItemToDict(pDict, "aippOutSize", Py_BuildValue("k", aippDims.aippOutSize)));

    return pDict;
}

static PyObject* GetPydictFromAIPPInfo(const aclAippInfo& aippinfo)
{
    PyObject* pDict = PyDict_New();

    CHECK_NULL(SetAIPPCscParams(pDict, aippinfo));
    CHECK_NULL(SetAIPPInfo(pDict, aippinfo));
    CHECK_NULL(SetAIPPCropParams(pDict, aippinfo));
    CHECK_NULL(SetAIPPPaddingParams(pDict, aippinfo));
    CHECK_NULL(SetAIPPDtcPixelMean(pDict, aippinfo));
    CHECK_NULL(SetAIPPDtcPixelMin(pDict, aippinfo));
    CHECK_NULL(SetAIPPPixelVarReci(pDict, aippinfo));
    CHECK_NULL(SetItemToDict(
        pDict, "outDims", GetPyListFromStructArray(aippinfo.outDims, aippinfo.shapeCount, GetPydictFromAIPPDims)));

    return pDict;
}

PyObject* WrapAclMdlGetFirstAippInfo(PyObject* /* self */, PyObject* args)
{
    uint32_t modelId = 0;
    size_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "Ik", &modelId, &index), "acl.mdl.get_first_aipp_info args parse failed!");

    aclAippInfo* aippInfo = new (std::nothrow) aclAippInfo;
    CHECK_NULL(aippInfo, "memory new failed", PyExc_MemoryError);

    errno_t sRet = memset_s(aippInfo, sizeof(aclAippInfo), 0, sizeof(aclAippInfo));
    if (sRet != EOK) {
        PyErr_SetString(PyExc_TypeError, "memory memset failed!");
        delete aippInfo;
        return nullptr;
    }

    aclError ret = aclmdlGetFirstAippInfo(modelId, index, aippInfo);
    if (ret != 0) {
        PyObject* obj = Py_BuildValue("Oi", Py_None, ret);
        delete aippInfo;
        return obj;
    }

    PyObject* pDict = GetPydictFromAIPPInfo(*aippInfo);
    delete aippInfo;
    CHECK_NULL(pDict);
    PyObject* obj = Py_BuildValue("Oi", pDict, ret);
    Py_XDECREF(pDict);
    return obj;
}

PyObject* WrapAclMdlSetAIPPInputFormat(PyObject* /* self */, PyObject* args)
{
    aclmdlAIPP* aippParmsSet = nullptr;
    aclAippInputFormat inputFormat = ACL_YUV420SP_U8;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &aippParmsSet, &inputFormat), "acl.mdl.set_aipp_input_format args parse failed!");

    aclError ret = aclmdlSetAIPPInputFormat(aippParmsSet, inputFormat);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlSetAIPPCscParams(PyObject* /* self */, PyObject* args)
{
    aclmdlAIPP* aippParmsSet = nullptr;
    int8_t cscSwitch = 0;
    int16_t cscMatrixR0C0 = 0;
    int16_t cscMatrixR0C1 = 0;
    int16_t cscMatrixR0C2 = 0;
    int16_t cscMatrixR1C0 = 0;
    int16_t cscMatrixR1C1 = 0;
    int16_t cscMatrixR1C2 = 0;
    int16_t cscMatrixR2C0 = 0;
    int16_t cscMatrixR2C1 = 0;
    int16_t cscMatrixR2C2 = 0;
    uint8_t cscOutputBiasR0 = 0;
    uint8_t cscOutputBiasR1 = 0;
    uint8_t cscOutputBiasR2 = 0;
    uint8_t cscInputBiasR0 = 0;
    uint8_t cscInputBiasR1 = 0;
    uint8_t cscInputBiasR2 = 0;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "kbhhhhhhhhhBBBBBB", &aippParmsSet, &cscSwitch, &cscMatrixR0C0, &cscMatrixR0C1, &cscMatrixR0C2,
            &cscMatrixR1C0, &cscMatrixR1C1, &cscMatrixR1C2, &cscMatrixR2C0, &cscMatrixR2C1, &cscMatrixR2C2,
            &cscOutputBiasR0, &cscOutputBiasR1, &cscOutputBiasR2, &cscInputBiasR0, &cscInputBiasR1, &cscInputBiasR2),
        "acl.mdl.set_aipp_csc_params args parse failed!");

    aclError ret = aclmdlSetAIPPCscParams(
        aippParmsSet, cscSwitch, cscMatrixR0C0, cscMatrixR0C1, cscMatrixR0C2, cscMatrixR1C0, cscMatrixR1C1,
        cscMatrixR1C2, cscMatrixR2C0, cscMatrixR2C1, cscMatrixR2C2, cscOutputBiasR0, cscOutputBiasR1, cscOutputBiasR2,
        cscInputBiasR0, cscInputBiasR1, cscInputBiasR2);

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlSetAIPPRbuvSwapSwitch(PyObject* /* self */, PyObject* args)
{
    aclmdlAIPP* aippParmsSet = nullptr;
    int8_t rbuvSwapSwitch = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kb", &aippParmsSet, &rbuvSwapSwitch),
        "acl.mdl.set_aipp_rbuv_swap_switch args parse failed!");

    aclError ret = aclmdlSetAIPPRbuvSwapSwitch(aippParmsSet, rbuvSwapSwitch);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlSetAIPPAxSwapSwitch(PyObject* /* self */, PyObject* args)
{
    aclmdlAIPP* aippParmsSet = nullptr;
    int8_t rbuvSwapSwitch = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kb", &aippParmsSet, &rbuvSwapSwitch),
        "acl.mdl.set_aipp_ax_swap_switch args parse failed!");

    aclError ret = aclmdlSetAIPPAxSwapSwitch(aippParmsSet, rbuvSwapSwitch);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlSetAIPPSrcImageSize(PyObject* /* self */, PyObject* args)
{
    aclmdlAIPP* aippParmsSet = nullptr;
    int32_t srcImageSizeW = 0;
    int32_t srcImageSizeH = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kii", &aippParmsSet, &srcImageSizeW, &srcImageSizeH),
        "acl.mdl.set_aipp_src_image_size args parse failed!");

    aclError ret = aclmdlSetAIPPSrcImageSize(aippParmsSet, srcImageSizeW, srcImageSizeH);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlSetAIPPCropParams(PyObject* /* self */, PyObject* args)
{
    aclmdlAIPP* aippParmsSet = nullptr;
    int8_t cropSwitch = 0;
    int32_t cropStartPosW = 0;
    int32_t cropStartPosH = 0;
    int32_t cropSizeW = 0;
    int32_t cropSizeH = 0;
    uint64_t batchIndex = 0;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "kbiiiiK", &aippParmsSet, &cropSwitch, &cropStartPosW, &cropStartPosH, &cropSizeW, &cropSizeH,
            &batchIndex),
        "acl.mdl.set_aipp_crop_params args parse failed!");

    aclError ret = aclmdlSetAIPPCropParams(
        aippParmsSet, cropSwitch, cropStartPosW, cropStartPosH, cropSizeW, cropSizeH, batchIndex);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlSetAIPPPaddingParams(PyObject* /* self */, PyObject* args)
{
    aclmdlAIPP* aippParmsSet = nullptr;
    int8_t paddingSwitch = 0;
    int32_t paddingSizeTop = 0;
    int32_t paddingSizeBottom = 0;
    int32_t paddingSizeLeft = 0;
    int32_t paddingSizeRight = 0;
    uint64_t batchIndex = 0;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "kbiiiiK", &aippParmsSet, &paddingSwitch, &paddingSizeTop, &paddingSizeBottom, &paddingSizeLeft,
            &paddingSizeRight, &batchIndex),
        "acl.mdl.set_aipp_padding_params args parse failed!");

    aclError ret = aclmdlSetAIPPPaddingParams(
        aippParmsSet, paddingSwitch, paddingSizeTop, paddingSizeBottom, paddingSizeLeft, paddingSizeRight, batchIndex);

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlSetAIPPDtcPixelMean(PyObject* /* self */, PyObject* args)
{
    aclmdlAIPP* aippParmsSet = nullptr;
    int16_t dtcPixelMeanChn0 = 0;
    int16_t dtcPixelMeanChn1 = 0;
    int16_t dtcPixelMeanChn2 = 0;
    int16_t dtcPixelMeanChn3 = 0;
    uint64_t batchIndex = 0;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "khhhhK", &aippParmsSet, &dtcPixelMeanChn0, &dtcPixelMeanChn1, &dtcPixelMeanChn2, &dtcPixelMeanChn3,
            &batchIndex),
        "acl.mdl.set_aipp_dtc_pixel_mean args parse failed!");

    aclError ret = aclmdlSetAIPPDtcPixelMean(
        aippParmsSet, dtcPixelMeanChn0, dtcPixelMeanChn1, dtcPixelMeanChn2, dtcPixelMeanChn3, batchIndex);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlSetAIPPDtcPixelMin(PyObject* /* self */, PyObject* args)
{
    aclmdlAIPP* aippParmsSet = nullptr;
    float dtcPixelMinChn0 = 0;
    float dtcPixelMinChn1 = 0;
    float dtcPixelMinChn2 = 0;
    float dtcPixelMinChn3 = 0;
    uint64_t batchIndex = 0;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "kffffK", &aippParmsSet, &dtcPixelMinChn0, &dtcPixelMinChn1, &dtcPixelMinChn2, &dtcPixelMinChn3,
            &batchIndex),
        "acl.mdl.set_aipp_dtc_pixel_min args parse failed!");

    aclError ret = aclmdlSetAIPPDtcPixelMin(
        aippParmsSet, dtcPixelMinChn0, dtcPixelMinChn1, dtcPixelMinChn2, dtcPixelMinChn3, batchIndex);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlSetAIPPPixelVarReci(PyObject* /* self */, PyObject* args)
{
    aclmdlAIPP* aippParmsSet = nullptr;
    float dtcPixelVarReciChn0 = 0;
    float dtcPixelVarReciChn1 = 0;
    float dtcPixelVarReciChn2 = 0;
    float dtcPixelVarReciChn3 = 0;
    uint64_t batchIndex = 0;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "kffffK", &aippParmsSet, &dtcPixelVarReciChn0, &dtcPixelVarReciChn1, &dtcPixelVarReciChn2,
            &dtcPixelVarReciChn3, &batchIndex),
        "acl.mdl.set_aipp_pixel_var_reci args parse failed!");

    aclError ret = aclmdlSetAIPPPixelVarReci(
        aippParmsSet, dtcPixelVarReciChn0, dtcPixelVarReciChn1, dtcPixelVarReciChn2, dtcPixelVarReciChn3, batchIndex);

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlSetInputAIPP(PyObject* /* self */, PyObject* args)
{
    uint32_t modelId = 0;
    aclmdlDataset* dataset = nullptr;
    size_t index = 0;
    const aclmdlAIPP* aippParmsSet = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "Ikkk", &modelId, &dataset, &index, &aippParmsSet),
        "acl.mdl.set_input_aipp args parse failed!");

    aclError ret = aclmdlSetInputAIPP(modelId, dataset, index, aippParmsSet);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlSetInputDynamicDims(PyObject* /* self */, PyObject* args)
{
    uint32_t modelId = 0;
    aclmdlDataset* dataset = nullptr;
    size_t index = 0;
    aclmdlIODims dims{};
    PyObject* pDict = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "IkkO", &modelId, &dataset, &index, &pDict),
        "acl.mdl.set_input_dynamic_dims args parse failed!");
    CHECK_NULL(PyDict_Check(pDict), "argument 4 is not dict");

    PyObject* pyCount = PyDict_GetItemString(pDict, "dimCount");
    dims.dimCount = PyLong_AsSize_t(pyCount);
    PyObject* pyStrName = PyDict_GetItemString(pDict, "name");
    if (pyStrName != nullptr) {
        PyObject* bytes = PyUnicode_AsUTF8String(pyStrName);
        CHECK_NULL(bytes, "PyUnicode_AsUTF8String failed", PyExc_RuntimeError);
        char* strName = PyBytes_AsString(bytes);
        if (strName == nullptr) {
            Py_XDECREF(bytes);
            PyErr_SetString(PyExc_RuntimeError, "PyBytes_AsString failed");
            return nullptr;
        }
        for (int j = 0; j < ACL_MAX_TENSOR_NAME_LEN && strName[j] != 0; j++) {
            dims.name[j] = strName[j];
        }
        Py_XDECREF(bytes);
    }
    PyObject* pyListDims = PyDict_GetItemString(pDict, "dims");
    CHECK_NULL(pyListDims && PyList_Check(pyListDims) != 0, "The dims of parameter 4 is not a list.");
    for (uint i = 0; i < dims.dimCount; ++i) {
        PyObject* object = PyList_GetItem(pyListDims, i);
        if ((object == nullptr) || (PyObject_TypeCheck(object, &PyLong_Type) == 0)) {
            PyErr_SetString(PyExc_TypeError, "the dims of fourth parameter is not list of int");
            return nullptr;
        }
        dims.dims[i] = PyLong_AsLongLong(object);
        CHECK_NULL(PyErr_Occurred() == nullptr, "PyLong_AsLongLong failed", PyExc_ValueError);
    }
    aclError ret = aclmdlSetInputDynamicDims(modelId, dataset, index, &dims);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlGetInputDynamicGearCount(PyObject* /* self */, PyObject* args)
{
    const aclmdlDesc* modelDesc = nullptr;
    size_t index = 0;
    size_t gearCount = 0;
    CHECK_NULL(
        PyArg_ParseTuple(args, "kk", &modelDesc, &index), "acl.mdl.get_input_dynamic_gear_count args parse failed!");

    aclError ret = aclmdlGetInputDynamicGearCount(modelDesc, index, &gearCount);
    return Py_BuildValue("ki", gearCount, ret);
}

PyObject* WrapAclMdlGetInputDynamicDims(PyObject* /* self */, PyObject* args)
{
    const aclmdlDesc* modelDesc = nullptr;
    size_t index = 0;
    size_t gearCount = 0;
    CHECK_NULL(
        PyArg_ParseTuple(args, "kkk", &modelDesc, &index, &gearCount),
        "acl.mdl.get_input_dynamic_dims args parse failed!");

    const size_t gearCountLimit = 4096;
    if (gearCount > gearCountLimit) {
        ACL_APP_LOG(ACL_ERROR, "Invalid param of gear_count");
        return Py_BuildValue("Oi", Py_None, ACL_ERROR_INVALID_PARAM);
    }

    std::vector<aclmdlIODims> dims(gearCount + 1);
    PyObject* pListDims = PyList_New(gearCount);
    CHECK_NULL(pListDims, "memory malloc failed", PyExc_MemoryError);

    aclError ret = aclmdlGetInputDynamicDims(modelDesc, index, dims.data(), gearCount);
    if (ret != 0) {
        PyObject* obj = Py_BuildValue("Oi", pListDims, ret);
        Py_XDECREF(pListDims);
        return obj;
    }

    for (size_t i = 0; i < gearCount; ++i) {
        PyObject* pDict = PyDict_New();
        if (!pDict) {
            Py_XDECREF(pListDims);
            PyErr_SetString(PyExc_MemoryError, "memory malloc failed");
            return nullptr;
        }
        CHECK_NULL(SetItemToDict(pDict, "name", Py_BuildValue("s", dims[i].name)));
        CHECK_NULL(SetItemToDict(pDict, "dimCount", Py_BuildValue("k", dims[i].dimCount)));
        PyObject* pListDimsItem = PyList_New(dims[i].dimCount);
        if (!pListDimsItem) {
            Py_XDECREF(pDict);
            Py_XDECREF(pListDims);
            PyErr_SetString(PyExc_MemoryError, "memory malloc failed");
            return nullptr;
        }
        for (size_t j = 0; j < dims[i].dimCount; ++j) {
            PyList_SetItem(pListDimsItem, j, Py_BuildValue("k", dims[i].dims[j]));
        }
        CHECK_NULL(SetItemToDict(pDict, "dims", pListDimsItem));
        PyList_SetItem(pListDims, i, pDict);
    }

    PyObject* obj = Py_BuildValue("Oi", pListDims, ret);
    Py_XDECREF(pListDims);

    return obj;
}

PyObject* WrapAclMdlCreateAndGetOpDesc(PyObject* /* self */, PyObject* args)
{
    uint32_t deviceId = 0;
    uint32_t streamId = 0;
    uint32_t taskId = 0;
    size_t opNameLen = 0;
    aclTensorDesc* inputDesc = nullptr;
    size_t numInputs = 0;
    aclTensorDesc* outputDesc = nullptr;
    size_t numOutputs = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "IIIk", &deviceId, &streamId, &taskId, &opNameLen),
        "acl.mdl.create_and_get_op_desc args parse failed!");

    const size_t opNameLenLimit = 4096;
    if (opNameLen > opNameLenLimit) {
        ACL_APP_LOG(ACL_ERROR, "Invalid param of op_name_len");
        return Py_BuildValue("skkkki", "", 0, 0, 0, 0, ACL_ERROR_INVALID_PARAM);
    }

    std::vector<char> opName(opNameLen + 1);
    aclError ret = aclmdlCreateAndGetOpDesc(
        deviceId, streamId, taskId, opName.data(), opNameLen, &inputDesc, &numInputs, &outputDesc, &numOutputs);
    opName[opNameLen] = '\0';
    return Py_BuildValue(
        "skkkki", opName.data(), reinterpret_cast<uintptr_t>(inputDesc), numInputs,
        reinterpret_cast<uintptr_t>(outputDesc), numOutputs, ret);
}

PyObject* WrapAclMdlInitDump(PyObject* /* self */, PyObject* /* args */)
{
    aclError ret = aclmdlInitDump();
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlFinalizeDump(PyObject* /* self */, PyObject* /* args */)
{
    aclError ret = aclmdlFinalizeDump();
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlGetAippType(PyObject* /* self */, PyObject* args)
{
    uint32_t modelId = 0;
    size_t index = 0;
    aclmdlInputAippType type = ACL_DATA_WITHOUT_AIPP;
    size_t dynamicAttachedDataIndex = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "Ik", &modelId, &index), "acl.mdl.get_aipp_type args parse failed!");

    aclError ret = aclmdlGetAippType(modelId, index, &type, &dynamicAttachedDataIndex);
    return Py_BuildValue("iki", type, dynamicAttachedDataIndex, ret);
}

PyObject* WrapAclMdlSetAIPPByInputIndex(PyObject* /* self */, PyObject* args)
{
    uint32_t modelId = 0;
    aclmdlDataset* dataset = nullptr;
    size_t index = 0;
    const aclmdlAIPP* aippParmsSet = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "Ikkk", &modelId, &dataset, &index, &aippParmsSet),
        "acl.mdl.set_aipp_by_input_index args parse failed!");

    aclError ret = aclmdlSetAIPPByInputIndex(modelId, dataset, index, aippParmsSet);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlSetDump(PyObject* /* self */, PyObject* args)
{
    const char* dumpCfgPath = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "|s", &dumpCfgPath), "acl.mdl.set_dump args parse failed!");

    aclError ret = aclmdlSetDump(dumpCfgPath);
    return Py_BuildValue("i", ret);
}

static PyObject* GetPyDictFromDumpChunk(const acldumpChunk& dumpChunk)
{
    PyObject* pyDumpChunk = PyDict_New();
    CHECK_NULL(pyDumpChunk != nullptr);
    CHECK_NULL(SetItemToDict(pyDumpChunk, "file_name", Py_BuildValue("s", dumpChunk.fileName)));
    CHECK_NULL(
        SetItemToDict(pyDumpChunk, "data_buf", Py_BuildValue("k", reinterpret_cast<uintptr_t>(dumpChunk.dataBuf))));
    CHECK_NULL(SetItemToDict(pyDumpChunk, "buf_len", Py_BuildValue("I", dumpChunk.bufLen)));
    CHECK_NULL(SetItemToDict(pyDumpChunk, "is_last_chunk", Py_BuildValue("I", dumpChunk.isLastChunk)));
    CHECK_NULL(SetItemToDict(pyDumpChunk, "offset", Py_BuildValue("k", dumpChunk.offset)));
    CHECK_NULL(SetItemToDict(pyDumpChunk, "flag", Py_BuildValue("i", dumpChunk.flag)));
    return pyDumpChunk;
}

static int32_t DumpCallback(const acldumpChunk* dumpChunk, int32_t /* len */)
{
    PyGILState_STATE state = PyGILState_Ensure();
    PyObject* pyDumpChunk = GetPyDictFromDumpChunk(*dumpChunk);
    PyObject* argslist = Py_BuildValue("(O)", pyDumpChunk);

    PyObject* result = PyObject_CallObject(g_dumpCallback, argslist);

    Py_XDECREF(argslist);
    Py_XDECREF(pyDumpChunk);
    if (result == nullptr) {
        ACL_APP_LOG(ACL_ERROR, "DumpCallback wrong out");
        PyGILState_Release(state);
        return -1;
    }
    Py_XDECREF(result);
    PyGILState_Release(state);
    return 0;
}

PyObject* WrapAclMdlDumpRegCallback(PyObject* /* self */, PyObject* args)
{
    PyObject* pyFunc = nullptr;
    int32_t flag = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "Oi", &pyFunc, &flag), "acl.mdl.dump_reg_callback args parse failed!");
    aclError ret = acldumpRegCallback(DumpCallback, flag);
    if (ret == ACL_SUCCESS) {
        if (g_dumpCallback != nullptr) {
            Py_XDECREF(g_dumpCallback);
        }
        Py_XINCREF(pyFunc);
        g_dumpCallback = pyFunc;
    }
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlDumpUnregCallback(PyObject* /* self */, PyObject* /* args */)
{
    (void)acldumpUnregCallback();
    if (g_dumpCallback != nullptr) {
        Py_XDECREF(g_dumpCallback);
        g_dumpCallback = nullptr;
    }
    Py_INCREF(Py_None);
    return Py_None;
}

PyObject* WrapAclMdlLoadWithConfig(PyObject* /* self */, PyObject* args)
{
    const aclmdlConfigHandle* handle = nullptr;
    uint32_t modelId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &handle), "acl.mdl.load_with_config args parse failed");

    aclError ret = aclmdlLoadWithConfig(handle, &modelId);
    return Py_BuildValue("Ii", modelId, ret);
}

PyObject* WrapAclMdlCreateConfigHandle(PyObject* /* self */, PyObject* /* args */)
{
    aclmdlConfigHandle* handle = aclmdlCreateConfigHandle();
    return Py_BuildValue("k", handle);
}

PyObject* WrapAclMdlDestroyConfigHandle(PyObject* /* self */, PyObject* args)
{
    aclmdlConfigHandle* handle = nullptr;
    CHECK_NULL(PyArg_ParseTuple(args, "k", &handle), "acl.mdl.destroy_config_handle args parse failed");

    aclError ret = aclmdlDestroyConfigHandle(handle);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlSetConfigOpt(PyObject* /* self */, PyObject* args)
{
    aclmdlConfigHandle* handle = nullptr;
    aclmdlConfigAttr attr = ACL_MDL_PRIORITY_INT32;
    PyObject* param = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kiO", &handle, &attr, &param), "acl.mdl.set_config_opt args parse failed");

    int32_t value = 0;
    const char* modelPath = nullptr;
    const void* addrPtr = nullptr;
    uint64_t attrValue = 0;
    aclError ret = ACL_SUCCESS;
    switch (static_cast<aclmdlConfigAttr>(attr)) {
        case ACL_MDL_PRIORITY_INT32:
            CHECK_NULL(PyArg_Parse(param, "i", &value), "acl.mdl.set_config_opt args parse failed!");
            ret = aclmdlSetConfigOpt(handle, attr, reinterpret_cast<const void*>(&value), sizeof(value));
            break;
        case ACL_MDL_PATH_PTR:
            CHECK_NULL(PyArg_Parse(param, "s", &modelPath), "acl.mdl.set_config_opt args parse failed!");
            ret = aclmdlSetConfigOpt(handle, attr, reinterpret_cast<const void*>(&modelPath), sizeof(void*));
            break;
        case ACL_MDL_MEM_ADDR_PTR:
        case ACL_MDL_WEIGHT_ADDR_PTR:
        case ACL_MDL_WORKSPACE_ADDR_PTR:
        case ACL_MDL_WEIGHT_PATH_PTR:
            CHECK_NULL(PyArg_Parse(param, "k", &addrPtr), "acl.mdl.set_config_opt args parse failed!");
            ret = aclmdlSetConfigOpt(handle, attr, &addrPtr, sizeof(void*));
            break;
        default:
            CHECK_NULL(PyArg_Parse(param, "K", &attrValue), "acl.mdl.set_config_opt args parse failed!");
            ret = aclmdlSetConfigOpt(handle, attr, reinterpret_cast<const void*>(&attrValue), sizeof(attrValue));
    }
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlGetTensorRealName(PyObject* /* self */, PyObject* args)
{
    const aclmdlDesc* modelDesc = nullptr;
    const char* name = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "ks", &modelDesc, &name), "acl.mdl.get_tensor_real_name args parse failed");

    const char* realName = aclmdlGetTensorRealName(modelDesc, name);
    return Py_BuildValue("s", realName);
}

PyObject* WrapAclMdlSetDatasetTensorDesc(PyObject* /* self */, PyObject* args)
{
    aclmdlDataset* dataset = nullptr;
    aclTensorDesc* tensorDesc = nullptr;
    size_t index = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkk", &dataset, &tensorDesc, &index),
        "acl.mdl.set_dataset_tensor_desc args parse failed");

    aclError ret = aclmdlSetDatasetTensorDesc(dataset, tensorDesc, index);
    return Py_BuildValue("ki", dataset, ret);
}

PyObject* WrapAclMdlGetDatasetTensorDesc(PyObject* /* self */, PyObject* args)
{
    aclmdlDataset* dataset = nullptr;
    size_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &dataset, &index), "acl.mdl.get_dataset_tensor_desc args parse failed");

    aclTensorDesc* tensorDesc = aclmdlGetDatasetTensorDesc(dataset, index);
    return Py_BuildValue("k", tensorDesc);
}

PyObject* WrapAclMdlGetOpAttr(PyObject* /* self */, PyObject* args)
{
    aclmdlDesc* modelDesc = nullptr;
    const char* opName = nullptr;
    const char* attr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kss", &modelDesc, &opName, &attr), "acl.mdl.get_op_attr args parse failed");

    const char* ret = aclmdlGetOpAttr(modelDesc, opName, attr);
    return Py_BuildValue("s", ret);
}

PyObject* WrapAclMdlGetAippDataSize(PyObject* /* self */, PyObject* args)
{
    uint64_t batchSize = 0;
    size_t memSize = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "K", &batchSize), "acl.mdl.get_aipp_data_size args parse failed");

    aclError ret = aclmdlGetAippDataSize(batchSize, &memSize);
    return Py_BuildValue("Ii", memSize, ret);
}

PyObject* WrapAclMdlCreateExecConfigHandle(PyObject* /* self */, PyObject* /* args */)
{
    aclmdlExecConfigHandle* handle = nullptr;
    handle = aclmdlCreateExecConfigHandle();
    return Py_BuildValue("k", handle);
}

PyObject* WrapAclMdlDestroyExecConfigHandle(PyObject* /* self */, PyObject* args)
{
    aclmdlExecConfigHandle* handle = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &handle), "acl.mdl.destroy_exec_config_handle args parse failed");

    aclError ret = aclmdlDestroyExecConfigHandle(handle);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlSetExecConfigOpt(PyObject* /* self */, PyObject* args)
{
    aclmdlExecConfigHandle* handle = nullptr;
    aclmdlExecConfigAttr attr{};
    uint32_t attrValue = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkI", &handle, &attr, &attrValue), "acl.mdl.set_exec_config_opt args parse failed!");

    aclError ret = aclmdlSetExecConfigOpt(handle, attr, &attrValue, sizeof(attrValue));
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlExecuteV2(PyObject* /* self */, PyObject* args)
{
    uint32_t modelId = 0;
    const aclmdlDataset* input = nullptr;
    aclmdlDataset* output = nullptr;
    aclrtStream stream = nullptr;
    const aclmdlExecConfigHandle* handle = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "Ikkkk", &modelId, &input, &output, &stream, &handle),
        "acl.mdl.execute_v2 args parse failed!");

    aclError ret = aclmdlExecuteV2(modelId, input, output, stream, handle);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlGetDescFromFile(PyObject* /* self */, PyObject* args)
{
    aclmdlDesc* modelDesc = nullptr;
    const char* modelPath = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "ks", &modelDesc, &modelPath), "acl.mdl.get_desc_from_file args parse failed!");

    aclError ret = aclmdlGetDescFromFile(modelDesc, modelPath);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlGetDescFromMem(PyObject* /* self */, PyObject* args)
{
    aclmdlDesc* modelDesc = nullptr;
    const void* model = nullptr;
    size_t modelSize = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkk", &modelDesc, &model, &modelSize), "acl.mdl.get_desc_from_mem args parse failed!");

    aclError ret = aclmdlGetDescFromMem(modelDesc, model, modelSize);
    return Py_BuildValue("i", ret);
}

static PyObject* GetPydictFromAclMdlIODimdRange(aclmdlIODimsRange& range)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(SetItemToDict(pyDict, "rangeCount", Py_BuildValue("k", range.rangeCount)));
    CHECK_NULL(SetItemToDict(
        pyDict, "range", GetPyListFromArray(range.range, static_cast<int>(range.rangeCount), ACL_DIM_ENDPOINTS)));

    return pyDict;
}

PyObject* WrapAclMdlGetInputDimsRange(PyObject* /* self */, PyObject* args)
{
    aclmdlDesc* modelDesc = nullptr;
    size_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &modelDesc, &index), "acl.mdl.get_input_dims_range args parse failed!");

    aclmdlIODimsRange dimsRange{};
    aclError ret = aclmdlGetInputDimsRange(modelDesc, index, &dimsRange);

    PyObject* pyDict = GetPydictFromAclMdlIODimdRange(dimsRange);
    CHECK_NULL(pyDict);
    PyObject* obj = Py_BuildValue("Oi", pyDict, ret);
    Py_XDECREF(pyDict);

    return obj;
}

PyObject* WrapAclMdlBundleLoadFromFile(PyObject* /* self */, PyObject* args)
{
    const char* modelPath = nullptr;
    uint32_t bundleId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "s", &modelPath), "acl.mdl.bundle_load_from_file args parse failed!");

    aclError ret = aclmdlBundleLoadFromFile(modelPath, &bundleId);
    return Py_BuildValue("Ii", bundleId, ret);
}

PyObject* WrapAclMdlBundleLoadFromMem(PyObject* /* self */, PyObject* args)
{
    const void* model = nullptr;
    size_t modelSize = 0;
    uint32_t bundleId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &model, &modelSize), "acl.mdl.bundle_load_from_mem args parse failed!");

    aclError ret = aclmdlBundleLoadFromMem(model, modelSize, &bundleId);
    return Py_BuildValue("Ii", bundleId, ret);
}

PyObject* WrapAclMdlBundleUnload(PyObject* /* self */, PyObject* args)
{
    uint32_t bundleId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "I", &bundleId), "acl.mdl.bundle_unload args parse failed!");

    aclError ret = aclmdlBundleUnload(bundleId);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlBundleGetModelId(PyObject* /* self */, PyObject* args)
{
    uint32_t bundleId = 0;
    size_t index = 0;
    uint32_t modelId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "Ik", &bundleId, &index), "acl.mdl.bundle_get_model_id args parse failed!");

    aclError ret = aclmdlBundleGetModelId(bundleId, index, &modelId);
    return Py_BuildValue("Ii", modelId, ret);
}

PyObject* WrapAclMdlBundleGetModelNum(PyObject* /* self */, PyObject* args)
{
    uint32_t bundleId = 0;
    size_t modelNum = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "I", &bundleId), "acl.mdl.bundle_get_model_num args parse failed!");

    aclError ret = aclmdlBundleGetModelNum(bundleId, &modelNum);
    return Py_BuildValue("Ii", modelNum, ret);
}

#ifdef USE_MDL
PyObject* WrapAclMdlSetAIPPScfParams(PyObject* /* self */, PyObject* args)
{
    aclmdlAIPP* aippParmsSet = nullptr;
    int8_t scfSwitch = 0;
    int32_t scfInputSizeW = 0;
    int32_t scfInputSizeH = 0;
    int32_t scfOutputSizeW = 0;
    int32_t scfOutputSizeH = 0;
    uint64_t batchIndex = 0;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "kbiiiiK", &aippParmsSet, &scfSwitch, &scfInputSizeW, &scfInputSizeH, &scfOutputSizeW,
            &scfOutputSizeH, &batchIndex),
        "acl.mdl.set_aipp_scf_params args parse failed!");

    aclError ret = aclmdlSetAIPPScfParams(
        aippParmsSet, scfSwitch, scfInputSizeW, scfInputSizeH, scfOutputSizeW, scfOutputSizeH, batchIndex);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclMdlLoadFromFileWithQ(PyObject* /* self */, PyObject* args)
{
    const char* modelPath = nullptr;
    const uint32_t* inputQ = nullptr;
    size_t inputQNum = 0;
    const uint32_t* outputQ = nullptr;
    size_t outputQNum = 0;
    uint32_t modelId = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "skkkk", &modelPath, &inputQ, &inputQNum, &outputQ, &outputQNum),
        "acl.mdl.load_from_file_with_q args parse failed!");

    aclError ret = aclmdlLoadFromFileWithQ(modelPath, &modelId, inputQ, inputQNum, outputQ, outputQNum);
    return Py_BuildValue("Ii", modelId, ret);
}

PyObject* WrapAclMdlLoadFromMemWithQ(PyObject* /* self */, PyObject* args)
{
    const void* model = nullptr;
    size_t modelSize = 0;
    const uint32_t* inputQ = nullptr;
    size_t inputQNum = 0;
    const uint32_t* outputQ = nullptr;
    size_t outputQNum = 0;
    uint32_t modelId = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkkk", &model, &modelSize, &inputQ, &inputQNum, &outputQ, &outputQNum),
        "acl.mdl.load_from_mem_with_q args parse failed!");

    aclError ret = aclmdlLoadFromMemWithQ(model, modelSize, &modelId, inputQ, inputQNum, outputQ, outputQNum);
    return Py_BuildValue("Ii", modelId, ret);
}
#endif // USE_MDL