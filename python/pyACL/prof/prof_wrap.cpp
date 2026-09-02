/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_wrap.h"
#include <vector>
#include "acl/acl.h"
#include "acl/acl_prof.h"

PyObject* WrapAclProfCreateConfig(PyObject* /* self */, PyObject* args)
{
    PyObject* pyDeviceIdList = nullptr;
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_ARITHMETIC_UTILIZATION;
    aclprofAicoreEvents* aicoreEvents = nullptr;
    uint64_t dataTypeConfig = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "OikK", &pyDeviceIdList, &aicoreMetrics, &aicoreEvents, &dataTypeConfig),
        "acl.prof.create_config args parse failed!");

    CHECK_NULL(PyList_Check(pyDeviceIdList), "argument 1 is not list");

    ssize_t deviceNums = PyList_Size(pyDeviceIdList);
    CHECK_NULL(deviceNums >= 0, "list is empty");

    std::vector<uint32_t> deviceIdList(deviceNums + 1);
    for (ssize_t i = 0; i < deviceNums; i++) {
        PyObject* object = PyList_GetItem(pyDeviceIdList, i);
        if ((object == nullptr) || (PyObject_TypeCheck(object, &PyLong_Type) == 0)) {
            PyErr_SetString(PyExc_TypeError, "the first argument is not list of int");
            return nullptr;
        }
        deviceIdList[i] = static_cast<uint32_t>(PyLong_AsUnsignedLong(object));
        CHECK_NULL(PyErr_Occurred() == nullptr, "PyLong_AsUnsignedLong failed", PyExc_ValueError);
    }
    void* config = aclprofCreateConfig(
        deviceIdList.data(), static_cast<uint32_t>(deviceNums), aicoreMetrics, aicoreEvents, dataTypeConfig);
    return Py_BuildValue("k", config);
}

PyObject* WrapAclProfDestroyConfig(PyObject* /* self */, PyObject* args)
{
    const aclprofConfig* profilerConfig = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &profilerConfig), "acl.prof.destroy_config args parse failed!");

    aclError ret = aclprofDestroyConfig(profilerConfig);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclProfInit(PyObject* /* self */, PyObject* args)
{
    const char* profilerResultPath = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "s", &profilerResultPath), "acl.prof.Init args parse failed!");

    aclError ret = aclprofInit(profilerResultPath, strlen(profilerResultPath));
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclProfFinalize(PyObject* /* self */, PyObject* /* args */)
{
    aclError ret = aclprofFinalize();
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclProfStart(PyObject* /* self */, PyObject* args)
{
    const aclprofConfig* profilerConfig = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &profilerConfig), "acl.prof.start args parse failed!");

    aclError ret = aclprofStart(profilerConfig);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclProfStop(PyObject* /* self */, PyObject* args)
{
    const aclprofConfig* profilerConfig = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &profilerConfig), "acl.prof.stop args parse failed!");

    aclError ret = aclprofStop(profilerConfig);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclProfModelSubscribe(PyObject* /* self */, PyObject* args)
{
    uint32_t modelId = 0;
    const aclprofSubscribeConfig* profSubscribeConfig = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "Ik", &modelId, &profSubscribeConfig), "acl.prof.model_subscribe args parse failed");

    aclError ret = aclprofModelSubscribe(modelId, profSubscribeConfig);
    PyObject* obj = Py_BuildValue("i", ret);
    return obj;
}

PyObject* WrapAclProfModelUnSubscribe(PyObject* /* self */, PyObject* args)
{
    uint32_t modelId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "I", &modelId), "acl.prof.model_unsubscribe args parse failed");

    aclError ret = aclprofModelUnSubscribe(modelId);
    PyObject* obj = Py_BuildValue("i", ret);
    return obj;
}

namespace {
std::vector<int> g_pipeFd;
}
PyObject* WrapAclProfCreateSubscribeConfig(PyObject* /* self */, PyObject* args)
{
    int8_t timeInfoSwitch = 0;
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_NONE;
    int fd = -1;

    CHECK_NULL(
        PyArg_ParseTuple(args, "bii", &timeInfoSwitch, &aicoreMetrics, &fd),
        "acl.prof.create_subscribe_config args parse failed");

    g_pipeFd.push_back(fd);
    aclprofSubscribeConfig* ret = aclprofCreateSubscribeConfig(timeInfoSwitch, aicoreMetrics, &g_pipeFd.back());
    PyObject* obj = Py_BuildValue("k", ret);
    return obj;
}

PyObject* WrapAclProfDestroySubscribeConfig(PyObject* /* self */, PyObject* args)
{
    const aclprofSubscribeConfig* profSubscribeConfig = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &profSubscribeConfig), "acl.prof.destroy_subscribe_config args parse failed");

    aclError ret = aclprofDestroySubscribeConfig(profSubscribeConfig);
    PyObject* obj = Py_BuildValue("i", ret);
    return obj;
}

PyObject* WrapAclProfGetOpDescSize(PyObject* /* self */, PyObject* /* args */)
{
    size_t opDescSize = 0;
    aclError ret = aclprofGetOpDescSize(&opDescSize);
    PyObject* obj = Py_BuildValue("ki", opDescSize, ret);
    return obj;
}

PyObject* WrapAclProfGetOpNum(PyObject* /* self */, PyObject* args)
{
    const void* opInfo = nullptr;
    size_t opInfoLen = 0;
    uint32_t opNumber = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &opInfo, &opInfoLen), "acl.prof.get_op_num args parse failed");

    aclError ret = aclprofGetOpNum(opInfo, opInfoLen, &opNumber);
    PyObject* obj = Py_BuildValue("ki", opNumber, ret);
    return obj;
}

PyObject* WrapAclProfGetOpType(PyObject* /* self */, PyObject* args)
{
    const void* opInfo = nullptr;
    size_t opInfoLen = 0;
    uint32_t index = 0;
    size_t opTypeLen = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkIk", &opInfo, &opInfoLen, &index, &opTypeLen),
        "acl.prof.get_op_type args parse failed");

    const size_t opTypeLenLimit = 4096;
    if (opTypeLen > opTypeLenLimit) {
        ACL_APP_LOG(ACL_ERROR, "Invalid param of op_type_len");
        return Py_BuildValue("si", "", ACL_ERROR_INVALID_PARAM);
    }
    std::vector<char> opType(opTypeLen + 1);
    aclError ret = aclprofGetOpType(opInfo, opInfoLen, index, opType.data(), opTypeLen);
    PyObject* obj = Py_BuildValue("si", opType.data(), ret);
    return obj;
}

PyObject* WrapAclProfGetOpName(PyObject* /* self */, PyObject* args)
{
    const void* opInfo = nullptr;
    size_t opInfoLen = 0;
    uint32_t index = 0;
    size_t opNameLen = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkIk", &opInfo, &opInfoLen, &index, &opNameLen),
        "acl.prof.get_op_name args parse failed");

    const size_t opNameLenLimit = 4096;
    if (opNameLen > opNameLenLimit) {
        ACL_APP_LOG(ACL_ERROR, "Invalid param of op_name_len");
        return Py_BuildValue("si", "", ACL_ERROR_INVALID_PARAM);
    }
    std::vector<char> opName(opNameLen + 1);
    aclError ret = aclprofGetOpName(opInfo, opInfoLen, index, opName.data(), opNameLen);
    PyObject* obj = Py_BuildValue("si", opName.data(), ret);
    return obj;
}

PyObject* WrapAclProfGetOpTypeV2(PyObject* /* self */, PyObject* args)
{
    const void* opInfo = nullptr;
    size_t opInfoLen = 0;
    uint32_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kkI", &opInfo, &opInfoLen, &index), "acl.prof.get_op_type args parse failed");

    size_t opTypeLen = 0;
    aclError ret = aclprofGetOpTypeLen(opInfo, opInfoLen, index, &opTypeLen);
    if (ret != ACL_SUCCESS) {
        ACL_APP_LOG(ACL_ERROR, "aclprofGetOpTypeLen failed, ret = %d", ret);
        PyObject* obj = Py_BuildValue("Oi", Py_None, ret);
        return obj;
    }

    std::vector<char> opType(opTypeLen + 1);
    ret = aclprofGetOpType(opInfo, opInfoLen, index, opType.data(), opTypeLen);
    return Py_BuildValue("si", opType.data(), ret);
}

PyObject* WrapAclProfGetOpNameV2(PyObject* /* self */, PyObject* args)
{
    const void* opInfo = nullptr;
    size_t opInfoLen = 0;
    uint32_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kkI", &opInfo, &opInfoLen, &index), "acl.prof.get_op_name args parse failed");

    size_t opNameLen = 0;
    aclError ret = aclprofGetOpNameLen(opInfo, opInfoLen, index, &opNameLen);
    if (ret != ACL_SUCCESS) {
        ACL_APP_LOG(ACL_ERROR, "aclprofGetOpNameLen failed, ret = %d", ret);
        PyObject* obj = Py_BuildValue("Oi", Py_None, ret);
        return obj;
    }

    std::vector<char> opName(opNameLen + 1);
    ret = aclprofGetOpName(opInfo, opInfoLen, index, opName.data(), opNameLen);
    return Py_BuildValue("si", opName.data(), ret);
}

PyObject* WrapAclProfGetOpStart(PyObject* /* self */, PyObject* args)
{
    const void* opInfo = nullptr;
    size_t opInfoLen = 0;
    uint32_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kkI", &opInfo, &opInfoLen, &index), "acl.prof.get_op_start args parse failed");

    uint64_t ret = aclprofGetOpStart(opInfo, opInfoLen, index);
    PyObject* obj = Py_BuildValue("K", ret);
    return obj;
}

PyObject* WrapAclProfGetOpEnd(PyObject* /* self */, PyObject* args)
{
    const void* opInfo = nullptr;
    size_t opInfoLen = 0;
    uint32_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kkI", &opInfo, &opInfoLen, &index), "acl.prof.get_op_end args parse failed");

    uint64_t ret = aclprofGetOpEnd(opInfo, opInfoLen, index);
    PyObject* obj = Py_BuildValue("K", ret);
    return obj;
}

PyObject* WrapAclProfGetOpDuration(PyObject* /* self */, PyObject* args)
{
    const void* opInfo = nullptr;
    size_t opInfoLen = 0;
    uint32_t index = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkI", &opInfo, &opInfoLen, &index), "acl.prof.get_op_duration args parse failed");

    uint64_t ret = aclprofGetOpDuration(opInfo, opInfoLen, index);
    PyObject* obj = Py_BuildValue("K", ret);
    return obj;
}

PyObject* WrapAclProfGetModelId(PyObject* /* self */, PyObject* args)
{
    const void* opInfo = nullptr;
    size_t opInfoLen = 0;
    uint32_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kkI", &opInfo, &opInfoLen, &index), "acl.prof.get_model_id args parse failed");

    size_t ret = aclprofGetModelId(opInfo, opInfoLen, index);
    PyObject* obj = Py_BuildValue("k", ret);
    return obj;
}

PyObject* WrapAclProfGetOpTypeLen(PyObject* /* self */, PyObject* args)
{
    const void* opInfo = nullptr;
    size_t opInfoLen = 0;
    uint32_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kkI", &opInfo, &opInfoLen, &index), "acl.prof.get_op_type args parse failed");

    size_t opTypeLen = 0;
    aclError ret = aclprofGetOpTypeLen(opInfo, opInfoLen, index, &opTypeLen);
    return Py_BuildValue("ki", opTypeLen, ret);
}

PyObject* WrapAclProfGetOpNameLen(PyObject* /* self */, PyObject* args)
{
    const void* opInfo = nullptr;
    size_t opInfoLen = 0;
    uint32_t index = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kkI", &opInfo, &opInfoLen, &index), "acl.prof.get_op_name args parse failed");

    size_t opNameLen = 0;
    aclError ret = aclprofGetOpNameLen(opInfo, opInfoLen, index, &opNameLen);
    return Py_BuildValue("ki", opNameLen, ret);
}

PyObject* WrapAclProfGetStepTimestamp(PyObject* /* self */, PyObject* args)
{
    aclprofStepInfo* stepInfo = nullptr;
    aclprofStepTag tag = ACL_STEP_START;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kik", &stepInfo, &tag, &stream), "acl.prof.get_step_timestamp args parse failed");

    aclError ret = aclprofGetStepTimestamp(stepInfo, tag, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclProfCreateStepInfo(PyObject* /* self */, PyObject* /* args */)
{
    aclprofStepInfo* stepInfo = aclprofCreateStepInfo();
    return Py_BuildValue("k", stepInfo);
}

PyObject* WrapAclProfDestroyStepInfo(PyObject* /* self */, PyObject* args)
{
    aclprofStepInfo* stepinfo = nullptr;
    CHECK_NULL(PyArg_ParseTuple(args, "k", &stepinfo), "acl.prof.destroy_step_info args parse failed");

    aclprofDestroyStepInfo(stepinfo);
    Py_INCREF(Py_None);
    return Py_None;
}

PyObject* WrapAclProfCreateStamp(PyObject* /* self */, PyObject* /* args */)
{
    void* ret = aclprofCreateStamp();
    return Py_BuildValue("k", ret);
}

PyObject* WrapAclProfDestroyStamp(PyObject* /* self */, PyObject* args)
{
    void* stamp = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &stamp), "acl.prof.destroy_stamp args parse failed!");

    aclprofDestroyStamp(stamp);
    Py_INCREF(Py_None);
    return Py_None;
}

PyObject* WrapAclProfPush(PyObject* /* self */, PyObject* args)
{
    void* stamp = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &stamp), "acl.prof.push args parse failed!");

    aclError ret = aclprofPush(stamp);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclProfPop(PyObject* /* self */, PyObject* /* args */)
{
    aclError ret = aclprofPop();
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclProfRangeStart(PyObject* /* self */, PyObject* args)
{
    void* stamp = nullptr;
    uint32_t rangeId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &stamp), "acl.prof.range_start args parse failed!");

    aclError ret = aclprofRangeStart(stamp, &rangeId);
    return Py_BuildValue("Ii", rangeId, ret);
}

PyObject* WrapAclProfRangeStop(PyObject* /* self */, PyObject* args)
{
    uint32_t rangeId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "I", &rangeId), "acl.prof.range_stop args parse failed!");

    aclError ret = aclprofRangeStop(rangeId);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclProfSetStampTraceMessage(PyObject* /* self */, PyObject* args)
{
    void* stamp = nullptr;
    char* msg = nullptr;
    uint32_t msgLen = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ksI", &stamp, &msg, &msgLen), "acl.prof.set_stamp_trace_message args parse failed!");

    aclError ret = aclprofSetStampTraceMessage(stamp, msg, msgLen);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclProfMark(PyObject* /* self */, PyObject* args)
{
    void* stamp = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &stamp), "acl.prof.mark args parse failed!");

    aclError ret = aclprofMark(stamp);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclProfMarkEx(PyObject* /* self */, PyObject* args)
{
    const char* msg = nullptr;
    aclrtStream stream = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "sk", &msg, &stream), "acl.prof.mark_ex args parse failed!");

    aclError ret = aclprofMarkEx(msg, strlen(msg), stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclProfSetConfig(PyObject* /* self */, PyObject* args)
{
    aclprofConfigType configType = ACL_PROF_ARGS_MIN;
    const char* config = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "is", &configType, &config), "acl.prof.set_config args parse failed!")

    aclError ret = aclprofSetConfig(configType, config, strlen(config));
    return Py_BuildValue("i", ret);
}