/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "rt_device.h"
#include "utils_methods.h"
#include "acl/acl.h"

PyObject* WrapAclRtSetDevice(PyObject* /* self */, PyObject* args)
{
    int deviceId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &deviceId), "acl.rt.set_device args parse failed");

    aclError ret = aclrtSetDevice(deviceId);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtResetDevice(PyObject* /* self */, PyObject* args)
{
    int deviceId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &deviceId), "acl.rt.reset_device args parse failed");

    aclError ret = aclrtResetDevice(deviceId);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtResetDeviceForce(PyObject* /* self */, PyObject* args)
{
    int deviceId = 0;
    CHECK_NULL(PyArg_ParseTuple(args, "i", &deviceId), "acl.rt.reset_device_force args parse failed");

    aclError ret = aclrtResetDeviceForce(deviceId);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetDevice(PyObject* /* self */, PyObject* /* args */)
{
    int deviceId = 0;

    aclError ret = aclrtGetDevice(&deviceId);
    return Py_BuildValue("ii", deviceId, ret);
}

PyObject* WrapAclRtSetDeviceSatMode(PyObject* /* self */, PyObject* args)
{
    aclrtFloatOverflowMode mode = ACL_RT_OVERFLOW_MODE_SATURATION;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &mode), "acl.rt.set_device_sat_mode args parse failed");

    aclError ret = aclrtSetDeviceSatMode(mode);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetDeviceSatMode(PyObject* /* self */, PyObject* /* args */)
{
    aclrtFloatOverflowMode mode = ACL_RT_OVERFLOW_MODE_SATURATION;
    aclError ret = aclrtGetDeviceSatMode(&mode);
    return Py_BuildValue("ki", mode, ret);
}

PyObject* WrapAclRtGetRunMode(PyObject* /* self */, PyObject* /* args */)
{
    aclrtRunMode runMode = ACL_DEVICE;

    aclError ret = aclrtGetRunMode(&runMode);
    return Py_BuildValue("ii", runMode, ret);
}

PyObject* WrapAclRtSetTsDevice(PyObject* /* self */, PyObject* args)
{
    aclrtTsId tsId = ACL_TS_ID_AICORE;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &tsId), "acl.rt.set_ts_device args parse failed");

    aclError ret = aclrtSetTsDevice(tsId);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetDeviceCount(PyObject* /* self */, PyObject* /* args */)
{
    uint32_t count = 0;

    aclError ret = aclrtGetDeviceCount(&count);
    return Py_BuildValue("Ii", count, ret);
}

static PyObject* GetPyDictFromUtilizationInfo(aclrtUtilizationInfo& info)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "cube_utilization", Py_BuildValue("i", info.cubeUtilization)));
    CHECK_NULL(SetItemToDict(pyDict, "vector_utilization", Py_BuildValue("i", info.vectorUtilization)));
    CHECK_NULL(SetItemToDict(pyDict, "aicpu_utilization", Py_BuildValue("i", info.aicpuUtilization)));
    CHECK_NULL(SetItemToDict(pyDict, "memory_utilization", Py_BuildValue("i", info.memoryUtilization)));
    CHECK_NULL(SetItemToDict(pyDict, "utilization_extend", Py_BuildValue("k", info.utilizationExtend)));
    return pyDict;
}

PyObject* WrapAclRtGetDeviceUtilizationRate(PyObject* /* self */, PyObject* args)
{
    int32_t deviceId = 0;
    CHECK_NULL(PyArg_ParseTuple(args, "i", &deviceId), "acl.rt.get_device_utilization_rate args parse failed");
    aclrtUtilizationInfo utilizationInfo{
        .cubeUtilization = 0,
        .vectorUtilization = 0,
        .aicpuUtilization = 0,
        .memoryUtilization = 0,
        .utilizationExtend = nullptr};
    aclError ret = aclrtGetDeviceUtilizationRate(deviceId, &utilizationInfo);
    PyObject* pyUtilizationInfo = GetPyDictFromUtilizationInfo(utilizationInfo);
    CHECK_NULL(pyUtilizationInfo)
    PyObject* obj = Py_BuildValue("OI", pyUtilizationInfo, ret);
    Py_XDECREF(pyUtilizationInfo);
    return obj;
}

PyObject* WrapAclRtQueryDeviceStatus(PyObject* /* self */, PyObject* args)
{
    int32_t deviceId = 0;
    CHECK_NULL(PyArg_ParseTuple(args, "i", &deviceId), "acl.rt.query_device_status args parse failed");
    aclrtDeviceStatus status = ACL_RT_DEVICE_STATUS_END;
    aclError ret = aclrtQueryDeviceStatus(deviceId, &status);
    return Py_BuildValue("Ii", status, ret);
}

PyObject* WrapAclRtDeviceTaskAbort(PyObject* /* self */, PyObject* args)
{
    int32_t deviceId = 0;
    uint32_t timeout = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "iI", &deviceId, &timeout), "acl.rt.device_task_abort args parse failed");

    aclError ret = aclrtDeviceTaskAbort(deviceId, timeout);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetDeviceInfo(PyObject* /* self */, PyObject* args)
{
    uint32_t deviceId = 0;
    int64_t value = 0;
    aclrtDevAttr attr = ACL_DEV_ATTR_AICPU_CORE_NUM;

    CHECK_NULL(PyArg_ParseTuple(args, "II", &deviceId, &attr), "acl.rt.get_device_info args parse failed");

    aclError ret = aclrtGetDeviceInfo(deviceId, attr, &value);
    return Py_BuildValue("ii", value, ret);
}

PyObject* WrapAclRtDeviceGetStreamPriorityRange(PyObject* /* self */, PyObject* /* args */)
{
    int32_t leastPriority = 0;
    int32_t greatestPriority = 0;
    aclError ret = aclrtDeviceGetStreamPriorityRange(&leastPriority, &greatestPriority);
    return Py_BuildValue("iii", leastPriority, greatestPriority, ret);
}

PyObject* WrapAclRtGetDeviceCapability(PyObject* /* self */, PyObject* args)
{
    int32_t deviceId = 0;
    int32_t value = 0;
    aclrtDevFeatureType devFeatureType = ACL_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV;
    CHECK_NULL(
        PyArg_ParseTuple(args, "iI", &deviceId, &devFeatureType), "acl.rt.get_device_capability args parse failed");

    aclError ret = aclrtGetDeviceCapability(deviceId, devFeatureType, &value);
    return Py_BuildValue("ii", value, ret);
}

PyObject* WrapAclRtGetDeviceResLimit(PyObject* /* self */, PyObject* args)
{
    int32_t deviceId = 0;
    uint32_t value = 0;
    aclrtDevResLimitType type = ACL_RT_DEV_RES_CUBE_CORE;
    CHECK_NULL(PyArg_ParseTuple(args, "iI", &deviceId, &type), "acl.rt.get_device_res_limit args parse failed");

    aclError ret = aclrtGetDeviceResLimit(deviceId, type, &value);
    return Py_BuildValue("Ii", value, ret);
}

PyObject* WrapAclRtSetDeviceResLimit(PyObject* /* self */, PyObject* args)
{
    int32_t deviceId = 0;
    uint32_t value = 0;
    aclrtDevResLimitType type = ACL_RT_DEV_RES_CUBE_CORE;
    CHECK_NULL(
        PyArg_ParseTuple(args, "iII", &deviceId, &type, &value), "acl.rt.set_device_res_limit args parse failed");
    aclError ret = aclrtSetDeviceResLimit(deviceId, type, value);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtResetDeviceResLimit(PyObject* /* self */, PyObject* args)
{
    int32_t deviceId = 0;
    CHECK_NULL(PyArg_ParseTuple(args, "i", &deviceId), "acl.rt.reset_device_res_limit args parse failed");
    aclError ret = aclrtResetDeviceResLimit(deviceId);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetDevicesTopo(PyObject* /* self */, PyObject* args)
{
    uint32_t deviceId = 0;
    uint32_t otherDeviceId = 0;
    uint64_t value = 0;
    CHECK_NULL(
        PyArg_ParseTuple(args, "II", &deviceId, &otherDeviceId), "acl.rt.reset_device_res_limit args parse failed");
    aclError ret = aclrtGetDevicesTopo(deviceId, otherDeviceId, &value);
    return Py_BuildValue("Ii", value, ret);
}

PyObject* WrapAclRtGetLogicDevIdByUserDevId(PyObject* /* self */, PyObject* args)
{
    int32_t userDevId = 0;
    int32_t logicDevId = 0;
    CHECK_NULL(PyArg_ParseTuple(args, "i", &userDevId), "acl.rt.get_logic_dev_id_by_user_dev_id args parse failed");
    aclError ret = aclrtGetLogicDevIdByUserDevId(userDevId, &logicDevId);
    return Py_BuildValue("ii", logicDevId, ret);
}

PyObject* WrapAclRtGetUserDevIdByLogicDevId(PyObject* /* self */, PyObject* args)
{
    int32_t logicDevId = 0;
    int32_t userDevId = 0;
    CHECK_NULL(PyArg_ParseTuple(args, "i", &logicDevId), "acl.rt.get_user_dev_id_by_logic_dev_id args parse failed");
    aclError ret = aclrtGetUserDevIdByLogicDevId(logicDevId, &userDevId);
    return Py_BuildValue("ii", userDevId, ret);
}

PyObject* WrapAclRtGetLogicDevIdByPhyDevId(PyObject* /* self */, PyObject* args)
{
    int32_t phyDevId = 0;
    int32_t logicDevId = 0;
    CHECK_NULL(PyArg_ParseTuple(args, "i", &phyDevId), "acl.rt.get_logic_dev_id_by_phy_dev_id args parse failed");
    aclError ret = aclrtGetLogicDevIdByPhyDevId(phyDevId, &logicDevId);
    return Py_BuildValue("ii", logicDevId, ret);
}

PyObject* WrapAclRtGetPhyDevIdByLogicDevId(PyObject* /* self */, PyObject* args)
{
    int32_t logicDevId = 0;
    int32_t phyDevId = 0;
    CHECK_NULL(PyArg_ParseTuple(args, "i", &logicDevId), "acl.rt.get_phy_dev_id_by_logic_dev_id args parse failed");
    aclError ret = aclrtGetPhyDevIdByLogicDevId(logicDevId, &phyDevId);
    return Py_BuildValue("ii", phyDevId, ret);
}

static PyObject* GetPydictFromUuid(aclrtUuid uuid)
{
    const size_t maxLen = 16;
    PyObject* pDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pDict, "bytes", GetPyListFromArray(uuid.bytes, maxLen)));
    return pDict;
}

PyObject* WrapAclRtDeviceGetUuid(PyObject* /* self */, PyObject* args)
{
    int32_t deviceId = 0;
    CHECK_NULL(PyArg_ParseTuple(args, "i", &deviceId), "acl.rt.device_get_uuid args parse failed");

    aclrtUuid uuid{};
    aclError ret = aclrtDeviceGetUuid(deviceId, &uuid);
    PyObject* pyDict = GetPydictFromUuid(uuid);
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("Oi", pyDict, ret);
    Py_XDECREF(pyDict);
    return obj;
}

PyObject* WrapAclRtDevicePeerAccessStatus(PyObject* /* self */, PyObject* args)
{
    int32_t deviceId = 0;
    int32_t peerDeviceId = 0;
    int32_t status = 0;
    CHECK_NULL(
        PyArg_ParseTuple(args, "ii", &deviceId, &peerDeviceId), "acl.rt.device_peer_access_status args parse failed");
    aclError ret = aclrtDevicePeerAccessStatus(deviceId, peerDeviceId, &status);
    return Py_BuildValue("ii", status, ret);
}