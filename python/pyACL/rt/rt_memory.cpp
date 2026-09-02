/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "rt_memory.h"
#include "acl/acl.h"

PyObject* WrapAclRtMalloc(PyObject* /* self */, PyObject* args)
{
    size_t size = 0;
    int policy = 0;
    void* devPtr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "ki", &size, &policy), "acl.rt.malloc args parse failed");

    aclError ret = aclrtMalloc(&devPtr, size, static_cast<aclrtMemMallocPolicy>(policy));
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(devPtr), ret);
}

PyObject* WrapAclRtMallocAlign32(PyObject* /* self */, PyObject* args)
{
    size_t size = 0;
    int policy = 0;
    void* devPtr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "ki", &size, &policy), "acl.rt.malloc_align32 args parse failed");

    aclError ret = aclrtMallocAlign32(&devPtr, size, static_cast<aclrtMemMallocPolicy>(policy));
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(devPtr), ret);
}

PyObject* WrapAclRtFree(PyObject* /* self */, PyObject* args)
{
    void* devPtr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &devPtr), "acl.rt.free args parse failed");

    aclError ret = aclrtFree(devPtr);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtMallocHost(PyObject* /* self */, PyObject* args)
{
    size_t size = 0;
    void* hostPtr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &size), "acl.rt.malloc_host args parse failed");

    aclError ret = aclrtMallocHost(&hostPtr, size);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(hostPtr), ret);
}

PyObject* WrapAclRtFreeHost(PyObject* /* self */, PyObject* args)
{
    void* hostPtr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &hostPtr), "acl.rt.free_host args parse failed");

    aclError ret = aclrtFreeHost(hostPtr);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtMemset(PyObject* /* self */, PyObject* args)
{
    void* devPtr = nullptr;
    size_t maxCount = 0;
    int32_t value = 0;
    size_t count = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kkik", &devPtr, &maxCount, &value, &count), "acl.rt.memset args parse failed");

    aclError ret = aclrtMemset(devPtr, maxCount, value, count);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtMemsetAsync(PyObject* /* self */, PyObject* args)
{
    void* devPtr = nullptr;
    size_t maxCount = 0;
    int32_t value = 0;
    size_t count = 0;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkikk", &devPtr, &maxCount, &value, &count, &stream),
        "acl.rt.memset_async args parse failed");

    aclError ret = aclrtMemsetAsync(devPtr, maxCount, value, count, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtMemcpy(PyObject* /* self */, PyObject* args)
{
    void* dst = nullptr;
    size_t dstMax = 0;
    void* src = nullptr;
    size_t count = 0;
    int memcpyKind = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkki", &dst, &dstMax, &src, &count, &memcpyKind), "acl.rt.memcpy args parse failed");

    aclError ret = aclrtMemcpy(dst, dstMax, src, count, static_cast<aclrtMemcpyKind>(memcpyKind));
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtMemcpyAsync(PyObject* /* self */, PyObject* args)
{
    void* dst = nullptr;
    size_t dstMax = 0;
    void* src = nullptr;
    size_t count = 0;
    int memcpyKind = 0;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkik", &dst, &dstMax, &src, &count, &memcpyKind, &stream),
        "acl.rt.memcpy_async args parse failed");

    aclError ret = aclrtMemcpyAsync(dst, dstMax, src, count, static_cast<aclrtMemcpyKind>(memcpyKind), stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtMallocCached(PyObject* /* self */, PyObject* args)
{
    size_t size = 0;
    int policy = 0;
    void* devPtr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "ki", &size, &policy), "acl.rt.malloc_cached args parse failed");

    aclError ret = aclrtMallocCached(&devPtr, size, static_cast<aclrtMemMallocPolicy>(policy));
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(devPtr), ret);
}

PyObject* WrapAclRtMemFlush(PyObject* /* self */, PyObject* args)
{
    void* devPtr = nullptr;
    size_t size = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &devPtr, &size), "acl.rt.mem_flush args parse failed");

    aclError ret = aclrtMemFlush(devPtr, size);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtMemInvalidate(PyObject* /* self */, PyObject* args)
{
    void* devPtr = nullptr;
    size_t size = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kk", &devPtr, &size), "acl.rt.mem_invalidate args parse failed");

    aclError ret = aclrtMemInvalidate(devPtr, size);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtDeviceCanAccessPeer(PyObject* /* self */, PyObject* args)
{
    int32_t deviceId = 0;
    int32_t peerDeviceId = 0;
    int32_t canAccessPeer = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ii", &deviceId, &peerDeviceId), "acl.rt.device_can_access_peer args parse failed");

    aclError ret = aclrtDeviceCanAccessPeer(&canAccessPeer, deviceId, peerDeviceId);
    return Py_BuildValue("ii", canAccessPeer, ret);
}

PyObject* WrapAclRtDeviceEnablePeerAccess(PyObject* /* self */, PyObject* args)
{
    int32_t peerDeviceId = 0;
    uint32_t flags = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iI", &peerDeviceId, &flags), "acl.rt.device_enable_peer_access args parse failed");

    aclError ret = aclrtDeviceEnablePeerAccess(peerDeviceId, flags);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtDeviceDisablePeerAccess(PyObject* /* self */, PyObject* args)
{
    int32_t peerDeviceId = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &peerDeviceId), "acl.rt.device_disable_peer_access args parse failed");

    aclError ret = aclrtDeviceDisablePeerAccess(peerDeviceId);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetMemInfo(PyObject* /* self */, PyObject* args)
{
    size_t freeMem = 0;
    size_t total = 0;
    aclrtMemAttr attr = ACL_DDR_MEM;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &attr), "acl.rt.get_mem_info args parse failed");

    aclError ret = aclrtGetMemInfo(attr, &freeMem, &total);
    return Py_BuildValue("kki", freeMem, total, ret);
}

PyObject* WrapAclRtMemcpy2d(PyObject* /* self */, PyObject* args)
{
    void* dst = nullptr;
    size_t dpitch = 0;
    const void* src = nullptr;
    size_t spitch = 0;
    size_t width = 0;
    size_t height = 0;
    aclrtMemcpyKind kind = ACL_MEMCPY_HOST_TO_HOST;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkkki", &dst, &dpitch, &src, &spitch, &width, &height, &kind),
        "acl.rt.memcpy2d args parse failed");

    aclError ret = aclrtMemcpy2d(dst, dpitch, src, spitch, width, height, kind);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtMemcpy2dAsync(PyObject* /* self */, PyObject* args)
{
    void* dst = nullptr;
    size_t dpitch = 0;
    const void* src = nullptr;
    size_t spitch = 0;
    size_t width = 0;
    size_t height = 0;
    aclrtMemcpyKind kind = ACL_MEMCPY_HOST_TO_HOST;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkkkik", &dst, &dpitch, &src, &spitch, &width, &height, &kind, &stream),
        "acl.rt.memcpy2d_async args parse failed");

    aclError ret = aclrtMemcpy2dAsync(dst, dpitch, src, spitch, width, height, kind, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtReserveMemAddress(PyObject* /* self */, PyObject* args)
{
    void* virPtr = nullptr;
    size_t size = 0;
    size_t alignment = 0;
    void* expectPtr = nullptr;
    uint64_t flags = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkK", &size, &alignment, &expectPtr, &flags),
        "acl.rt.reserve_mem_address args parse failed");

    aclError ret = aclrtReserveMemAddress(&virPtr, size, alignment, expectPtr, flags);
    return Py_BuildValue("ki", virPtr, ret);
}

PyObject* WrapAclRtReleaseMemAddress(PyObject* /* self */, PyObject* args)
{
    void* virPtr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &virPtr), "acl.rt.release_mem_address args parse failed");

    aclError ret = aclrtReleaseMemAddress(virPtr);
    return Py_BuildValue("i", ret);
}

static bool GetMemLocationFromPydict(PyObject* pyDict, const char* keyName, aclrtMemLocation& location)
{
    PyObject* pyLocation = PyDict_GetItemString(pyDict, keyName);
    CHECK_STRUCT_DICT(pyLocation, "the aclrtMemLocation argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyLocation, "id", location.id));
    CHECK_BOOL(GetEnumValueFromPyDict(pyLocation, "type", location.type));
    return true;
}

static bool GetPhysicalMemPropFromPydict(PyObject* pyDict, aclrtPhysicalMemProp& prop)
{
    CHECK_STRUCT_DICT(pyDict, "the aclrtPhysicalMemProp argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "handleType", prop.handleType));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "allocationType", prop.allocationType));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "memAttr", prop.memAttr));
    CHECK_BOOL(GetMemLocationFromPydict(pyDict, "location", prop.location));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "reserve", prop.reserve));
    return true;
}

PyObject* WrapAclRtMallocPhysical(PyObject* /* self */, PyObject* args)
{
    aclrtDrvMemHandle handle = nullptr;
    size_t size = 0;
    PyObject* pyProp = nullptr;
    uint64_t flags = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kOK", &size, &pyProp, &flags), "acl.rt.malloc_physical args parse failed");

    aclrtPhysicalMemProp prop = {};
    CHECK_NULL(GetPhysicalMemPropFromPydict(pyProp, prop));
    aclError ret = aclrtMallocPhysical(&handle, size, &prop, flags);
    return Py_BuildValue("ki", handle, ret);
}

PyObject* WrapAclRtFreePhysical(PyObject* /* self */, PyObject* args)
{
    aclrtDrvMemHandle handle = nullptr;
    CHECK_NULL(PyArg_ParseTuple(args, "k", &handle), "acl.rt.free_physical args parse failed");

    aclError ret = aclrtFreePhysical(handle);
    return Py_BuildValue("i", ret);
}

static bool GetUnionValueFromPyDict(PyObject* pyDict, const char* keyName, aclrtMallocAttrValue& value)
{
    PyObject* pyValue = PyDict_GetItemString(pyDict, keyName);
    CHECK_STRUCT_DICT(pyValue, "the aclrtMallocAttrValue argument is not dict");

    if (PyDict_GetItemString(pyValue, "moduleId") != nullptr) {
        PyObject* pyModuleId = PyDict_GetItemString(pyValue, "moduleId");
        value.moduleId = static_cast<uint16_t>(PyLong_AsUnsignedLong(pyModuleId));
        CHECK_BOOL(PyErr_Occurred() == nullptr, "PyLong_AsUnsignedLong failed", PyExc_ValueError);
    } else if (PyDict_GetItemString(pyValue, "deviceId") != nullptr) {
        PyObject* pyDeviceId = PyDict_GetItemString(pyValue, "deviceId");
        value.deviceId = static_cast<uint32_t>(PyLong_AsUnsignedLong(pyDeviceId));
        CHECK_BOOL(PyErr_Occurred() == nullptr, "PyLong_AsUnsignedLong failed", PyExc_ValueError);
    } else if (PyDict_GetItemString(pyValue, "rsv") != nullptr) {
        PyObject* pyRsv = PyDict_GetItemString(pyValue, "rsv");
        Py_ssize_t size = PyList_Size(pyRsv);
        int loopLimit = (size < 8) ? static_cast<int>(size) : 8;
        for (int i = 0; i < loopLimit; ++i) {
            PyObject* pyItem = PyList_GetItem(pyRsv, i);
            value.rsv[i] = static_cast<uint8_t>(PyLong_AsUnsignedLong(pyItem));
            CHECK_BOOL(PyErr_Occurred() == nullptr, "PyLong_AsUnsignedLong failed", PyExc_ValueError);
        }
    } else {
        PyErr_SetString(PyExc_KeyError, "No valid key found in aclrtMallocAttrValue");
        return false;
    }

    return true;
}

static bool GetMallocAttributeFromPyDict(PyObject* pyDict, aclrtMallocAttribute& tmpAttr)
{
    CHECK_STRUCT_DICT(pyDict, "the aclrtMallocWithCfg argument is not dict");

    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "attr", tmpAttr.attr));
    CHECK_BOOL(GetUnionValueFromPyDict(pyDict, "value", tmpAttr.value));

    return true;
}

static bool GetMallocAttributeFromPyList(
    PyObject* pyDict, const char* keyName, size_t numAttrs, aclrtMallocAttribute*& attrs)
{
    PyObject* pyAttrs = PyDict_GetItemString(pyDict, keyName);
    CHECK_BOOL(pyAttrs, "the aclrtMallocAttrValue argument is not dict");
    Py_ssize_t size = PyList_Size(pyAttrs);
    if (size != static_cast<int>(numAttrs)) {
        PyErr_SetString(PyExc_KeyError, "The numAttrs inputed does not match the expected numAttrs");
        return false;
    }

    for (int i = 0; i < size; ++i) {
        PyObject* tmpPyAttrs = PyList_GetItem(pyAttrs, i);
        CHECK_BOOL(GetMallocAttributeFromPyDict(tmpPyAttrs, attrs[i]));
    }

    return true;
}

static bool GetMallocConfigFromPydict(PyObject* pyDict, aclrtMallocConfig& cfg)
{
    CHECK_BOOL(GetValueFromPyDict(pyDict, "numAttrs", cfg.numAttrs));
    CHECK_BOOL(GetMallocAttributeFromPyList(pyDict, "attrs", cfg.numAttrs, cfg.attrs));

    return true;
}

PyObject* WrapAclRtMallocWithCfg(PyObject* /* self */, PyObject* args)
{
    void* devPtr = nullptr;
    size_t size = 0;
    int policy = 0;
    PyObject* pyCfg = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kiO", &size, &policy, &pyCfg), "acl.rt.malloc_with_cfg args parse failed!");
    CHECK_NULL(PyDict_Check(pyCfg), "pyCfg is not dict!");

    if (PyDict_Size(pyCfg) == 0) {
        aclError ret = aclrtMallocWithCfg(&devPtr, size, static_cast<aclrtMemMallocPolicy>(policy), nullptr);
        return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(devPtr), ret);
    }

    PyObject* pyAttrs = PyDict_GetItemString(pyCfg, "attrs");
    CHECK_NULL(pyAttrs, "the aclrtMallocAttrValue argument is not dict");
    Py_ssize_t pyAttrsSize = PyList_Size(pyAttrs);
    aclrtMallocConfig cfg = {};
    cfg.attrs = (aclrtMallocAttribute*)calloc(pyAttrsSize, sizeof(aclrtMallocAttribute));
    CHECK_NULL(cfg.attrs != nullptr, "cfg.attrs malloc failed!");

    if (!GetMallocConfigFromPydict(pyCfg, cfg)) {
        free(cfg.attrs);
        cfg.attrs = nullptr;
        return nullptr;
    }

    aclError ret = aclrtMallocWithCfg(&devPtr, size, static_cast<aclrtMemMallocPolicy>(policy), &cfg);
    free(cfg.attrs);
    cfg.attrs = nullptr;

    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(devPtr), ret);
}

PyObject* WrapAclRtMallocForTaskScheduler(PyObject* /* self */, PyObject* args)
{
    void* devPtr = nullptr;
    size_t size = 0;
    int policy = 0;
    PyObject* pyCfg = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kiO", &size, &policy, &pyCfg), "acl.rt.malloc_for_task_scheduler args parse failed!");
    CHECK_NULL(PyDict_Check(pyCfg), "pyCfg is not dict!");

    if (PyDict_Size(pyCfg) == 0) {
        aclError ret = aclrtMallocForTaskScheduler(&devPtr, size, static_cast<aclrtMemMallocPolicy>(policy), nullptr);
        return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(devPtr), ret);
    }

    PyObject* pyAttrs = PyDict_GetItemString(pyCfg, "attrs");
    CHECK_NULL(pyAttrs, "the aclrtMallocAttrValue argument is not dict");
    Py_ssize_t pyAttrsSize = PyList_Size(pyAttrs);
    aclrtMallocConfig cfg = {};
    cfg.attrs = (aclrtMallocAttribute*)calloc(pyAttrsSize, sizeof(aclrtMallocAttribute));
    CHECK_NULL(cfg.attrs != nullptr, "cfg.attrs malloc failed!");

    if (!GetMallocConfigFromPydict(pyCfg, cfg)) {
        free(cfg.attrs);
        cfg.attrs = nullptr;
        return nullptr;
    }

    aclError ret = aclrtMallocForTaskScheduler(&devPtr, size, static_cast<aclrtMemMallocPolicy>(policy), &cfg);
    free(cfg.attrs);
    cfg.attrs = nullptr;

    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(devPtr), ret);
}

PyObject* WrapAclRtMallocHostWithCfg(PyObject* /* self */, PyObject* args)
{
    size_t size = 0;
    void* hostPtr = nullptr;
    PyObject* pyCfg = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kO", &size, &pyCfg), "acl.rt.malloc_host_with_cfg args parse failed");
    CHECK_NULL(PyDict_Check(pyCfg), "pyCfg is not dict!");

    if (PyDict_Size(pyCfg) == 0) {
        aclError ret = aclrtMallocHostWithCfg(&hostPtr, size, nullptr);
        return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(hostPtr), ret);
    }

    PyObject* pyAttrs = PyDict_GetItemString(pyCfg, "attrs");
    CHECK_NULL(pyAttrs, "the aclrtMallocAttrValue argument is not dict");
    Py_ssize_t pyAttrsSize = PyList_Size(pyAttrs);
    aclrtMallocConfig cfg = {};
    cfg.attrs = (aclrtMallocAttribute*)calloc(pyAttrsSize, sizeof(aclrtMallocAttribute));
    CHECK_NULL(cfg.attrs != nullptr, "cfg.attrs malloc failed!");

    if (!GetMallocConfigFromPydict(pyCfg, cfg)) {
        free(cfg.attrs);
        cfg.attrs = nullptr;
        return nullptr;
    }

    aclError ret = aclrtMallocHostWithCfg(&hostPtr, size, &cfg);
    free(cfg.attrs);
    cfg.attrs = nullptr;

    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(hostPtr), ret);
}

PyObject* WrapAclRtMapMem(PyObject* /* self */, PyObject* args)
{
    void* virPtr = nullptr;
    size_t size = 0;
    size_t offset = 0;
    aclrtDrvMemHandle handle = nullptr;
    uint64_t flags = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkK", &virPtr, &size, &offset, &handle, &flags), "acl.rt.map_mem args parse failed");

    aclError ret = aclrtMapMem(virPtr, size, offset, handle, flags);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtUnmapMem(PyObject* /* self */, PyObject* args)
{
    void* virPtr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &virPtr), "acl.rt.unmap_mem args parse failed");

    aclError ret = aclrtUnmapMem(virPtr);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtMemExportToShareableHandle(PyObject* /* self */, PyObject* args)
{
    aclrtDrvMemHandle handle = nullptr;
    aclrtMemHandleType handleType = ACL_MEM_HANDLE_TYPE_NONE;
    uint64_t flags = 0;
    uint64_t shareableHandle = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kiK", &handle, &handleType, &flags),
        "acl.rt.mem_export_to_shareable_handle args parse failed");

    aclError ret = aclrtMemExportToShareableHandle(handle, handleType, flags, &shareableHandle);
    return Py_BuildValue("Ki", shareableHandle, ret);
}

PyObject* WrapAclRtDeviceGetBareTgid(PyObject* /* self */, PyObject* /* args */)
{
    int32_t pid;
    aclError ret = aclrtDeviceGetBareTgid(&pid);
    return Py_BuildValue("ii", pid, ret);
}

PyObject* WrapAclRtMemSetPidToShareableHandle(PyObject* /* self */, PyObject* args)
{
    uint64_t shareableHandle = 0;
    PyObject* pidsObj = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "KO", &shareableHandle, &pidsObj),
        "acl.rt.mem_set_pid_to_shareable_handle args parse failed");

    int32_t* pid = nullptr;
    size_t pidNum = 0;
    std::vector<int32_t> pids;

    CHECK_NULL(PyList_Check(pidsObj), "argument 2 only support the format of list", PyExc_ValueError);
    CHECK_NULL(GetValuesFromPyList(pidsObj, pids), "get values from PyList failed", PyExc_ValueError);
    pid = pids.data();
    pidNum = static_cast<size_t>(PyList_Size(pidsObj));
    CHECK_NULL(pid, "convert argument 2 to int32_t* failed")

    aclError ret = aclrtMemSetPidToShareableHandle(shareableHandle, pid, pidNum);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtMemImportFromShareableHandle(PyObject* /* self */, PyObject* args)
{
    uint64_t shareableHandle = 0;
    int32_t deviceId = 0;
    aclrtDrvMemHandle handle = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "Ki", &shareableHandle, &deviceId),
        "acl.rt.mem_import_from_shareable_handle args parse failed");

    aclError ret = aclrtMemImportFromShareableHandle(shareableHandle, deviceId, &handle);
    return Py_BuildValue("ki", handle, ret);
}

PyObject* WrapAclRtMemGetAllocationGranularity(PyObject* /* self */, PyObject* args)
{
    size_t granularity = 0;
    PyObject* pyProp = nullptr;
    aclrtMemGranularityOptions option = ACL_RT_MEM_ALLOC_GRANULARITY_UNDEF;

    CHECK_NULL(
        PyArg_ParseTuple(args, "Oi", &pyProp, &option), "acl.rt.mem_get_allocation_granularity args parse failed");

    aclrtPhysicalMemProp prop = {};
    CHECK_NULL(GetPhysicalMemPropFromPydict(pyProp, prop));

    aclError ret = aclrtMemGetAllocationGranularity(&prop, option, &granularity);
    return Py_BuildValue("ki", granularity, ret);
}

static PyObject* GetPydictFromMemUceInfoArray(aclrtMemUceInfo& info)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(SetItemToDict(pyDict, "addr", Py_BuildValue("k", info.addr)));
    CHECK_NULL(SetItemToDict(pyDict, "len", Py_BuildValue("k", info.len)));
    CHECK_NULL(SetItemToDict(pyDict, "reserved", GetPyListFromArray(info.reserved, UCE_INFO_RESERVED_SIZE)));

    return pyDict;
}

PyObject* WrapAclRtGetMemUceInfo(PyObject* /* self */, PyObject* args)
{
    int32_t deviceId = 0;
    size_t arraySize = 0;
    size_t retSize = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "iI", &deviceId, &arraySize), "acl.rt.get_mem_uce_info args parse failed!");

    aclrtMemUceInfo* memUceInfoArray = new (std::nothrow) aclrtMemUceInfo[arraySize];
    CHECK_NULL(memUceInfoArray, "memory new failed", PyExc_MemoryError);
    CHECK_NULL(MemsetStructArrayArgu(memUceInfoArray, arraySize));

    aclError ret = aclrtGetMemUceInfo(deviceId, memUceInfoArray, arraySize, &retSize);
    PyObject* pyDict = GetPyListFromStructArray(memUceInfoArray, retSize, GetPydictFromMemUceInfoArray);
    delete[] memUceInfoArray;
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("Oi", pyDict, ret);
    Py_XDECREF(pyDict);

    return obj;
}

static bool GetMemUceInfoArrayFromPydict(PyObject* pyDict, aclrtMemUceInfo& info)
{
    CHECK_STRUCT_DICT(pyDict, "the aclrtMemUceInfo argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "addr", info.addr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "len", info.len));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "reserved", info.reserved, UCE_INFO_RESERVED_SIZE));
    return true;
}

PyObject* WrapAclRtMemUceRepair(PyObject* /* self */, PyObject* args)
{
    int32_t deviceId = 0;
    PyObject* pyDict = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &deviceId, &pyDict), "acl.rt.mem_uce_repair args parse failed!");

    CHECK_NULL(PyList_Check(pyDict), "aclrtMemUceInfo argument is not list");
    size_t arraySize = static_cast<size_t>(PyList_Size(pyDict));
    std::vector<aclrtMemUceInfo> uceInfos(arraySize + 1);
    CHECK_NULL(
        ConvertPyListToStructArray(pyDict, static_cast<int>(arraySize), uceInfos.data(), GetMemUceInfoArrayFromPydict));

    aclError ret = aclrtMemUceRepair(deviceId, uceInfos.data(), arraySize);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtMemcpyAsyncWithCondition(PyObject* /* self */, PyObject* args)
{
    void* dst = nullptr;
    size_t dstMax = 0;
    void* src = nullptr;
    size_t count = 0;
    aclrtMemcpyKind kind = ACL_MEMCPY_HOST_TO_HOST;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkik", &dst, &dstMax, &src, &count, &kind, &stream),
        "acl.rt.memcpy_async_with_condition args parse failed");

    aclError ret = aclrtMemcpyAsyncWithCondition(dst, dstMax, src, count, kind, stream);
    return Py_BuildValue("i", ret);
}

static PyObject* GetPyDictFromMemLocation(aclrtMemLocation& location)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "id", Py_BuildValue("I", location.id)));
    CHECK_NULL(SetItemToDict(pyDict, "type", Py_BuildValue("I", location.type)));
    return pyDict;
}

static PyObject* GetPyDictFromPtrAttributes(aclrtPtrAttributes& attributes)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "location", GetPyDictFromMemLocation(attributes.location)));
    CHECK_NULL(SetItemToDict(pyDict, "page_size", Py_BuildValue("I", attributes.pageSize)));
    CHECK_NULL(
        SetItemToDict(pyDict, "rsv", GetPyListFromArray(attributes.rsv, sizeof(attributes.rsv) / sizeof(uint32_t))));

    return pyDict;
}

PyObject* WrapAclRtPointerGetAttributes(PyObject* /* self */, PyObject* args)
{
    void* ptr = nullptr;
    aclrtPtrAttributes attributes{};

    CHECK_NULL(PyArg_ParseTuple(args, "k", &ptr), "acl.rt.pointer_get_attributes args parse failed");

    aclError ret = aclrtPointerGetAttributes(ptr, &attributes);

    PyObject* pyDict = GetPyDictFromPtrAttributes(attributes);
    CHECK_NULL(pyDict);
    PyObject* obj = Py_BuildValue("Oi", pyDict, ret);
    Py_XDECREF(pyDict);
    return obj;
}

PyObject* WrapAclRtHostRegister(PyObject* /* self */, PyObject* args)
{
    void* ptr = nullptr;
    uint64_t size = 0;
    aclrtHostRegisterType type = ACL_HOST_REGISTER_MAPPED;
    void* devPtr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kki", &ptr, &size, &type), "acl.rt.host_register args parse failed");

    aclError ret = aclrtHostRegister(ptr, size, type, &devPtr);
    return Py_BuildValue("ki", devPtr, ret);
}

PyObject* WrapAclRtHostUnregister(PyObject* /* self */, PyObject* args)
{
    void* ptr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &ptr), "acl.rt.host_unregister args parse failed");

    aclError ret = aclrtHostUnregister(ptr);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtGetMemcpyDescSize(PyObject* /* self */, PyObject* args)
{
    size_t descSize = 0;
    aclrtMemcpyKind kind = ACL_MEMCPY_INNER_DEVICE_TO_DEVICE;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &kind), "acl.rt.get_memcpy_desc_size args parse failed");
    aclError ret = aclrtGetMemcpyDescSize(kind, &descSize);
    return Py_BuildValue("ki", descSize, ret);
}

PyObject* WrapAclRtSetMemcpyDesc(PyObject* /* self */, PyObject* args)
{
    void* desc = nullptr;
    void* srcAddr = nullptr;
    void* dstAddr = nullptr;
    size_t count = 0;
    void* config = nullptr;
    aclrtMemcpyKind kind = ACL_MEMCPY_INNER_DEVICE_TO_DEVICE;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kikkkk", &desc, &kind, &srcAddr, &dstAddr, &count, &config),
        "acl.rt.set_memcpy_desc args parse failed");
    aclError ret = aclrtSetMemcpyDesc(desc, kind, srcAddr, dstAddr, count, config);
    return Py_BuildValue("ki", desc, ret);
}

PyObject* WrapAclRtMemcpyAsyncWithDesc(PyObject* /* self */, PyObject* args)
{
    void* desc = nullptr;
    aclrtMemcpyKind kind = ACL_MEMCPY_INNER_DEVICE_TO_DEVICE;
    aclrtStream stream = nullptr;
    CHECK_NULL(PyArg_ParseTuple(args, "kik", &desc, &kind, &stream), "acl.rt.memcpy_async_with_desc args parse failed");
    aclError ret = aclrtMemcpyAsyncWithDesc(desc, kind, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtIpcMemGetExportKey(PyObject* /* self */, PyObject* args)
{
    void* devPtr = nullptr;
    size_t size = 0;
    size_t len = 0;
    uint64_t flag = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkK", &devPtr, &size, &len, &flag), "acl.rt.ipc_mem_get_export_key args parse failed");

    const size_t maxKeyLen = 1024;
    CHECK_NULL(len < maxKeyLen, "key len should be less than 1024", PyExc_ValueError);
    std::vector<char> key(len + 1);
    aclError ret = aclrtIpcMemGetExportKey(devPtr, size, key.data(), len, flag);
    return Py_BuildValue("si", key.data(), ret);
}

PyObject* WrapAclRtIpcMemSetImportPid(PyObject* /* self */, PyObject* args)
{
    const char* key = nullptr;
    PyObject* pyPids = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "sO", &key, &pyPids), "acl.rt.ipc_mem_set_import_pid args parse failed");
    CHECK_NULL(PyList_Check(pyPids), "argument 2 only support the format of list", PyExc_ValueError);

    std::vector<int32_t> pids;
    CHECK_NULL(GetValuesFromPyList(pyPids, pids), "get values from PyList failed", PyExc_ValueError);
    size_t num = static_cast<size_t>(PyList_Size(pyPids));
    aclError ret = aclrtIpcMemSetImportPid(key, pids.data(), num);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtIpcMemImportByKey(PyObject* /* self */, PyObject* args)
{
    const char* key = nullptr;
    uint64_t flag = 0;
    void* devPtr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "sK", &key, &flag), "acl.rt.ipc_mem_import_by_key args parse failed");

    aclError ret = aclrtIpcMemImportByKey(&devPtr, key, flag);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(devPtr), ret);
}

PyObject* WrapAclRtIpcMemClose(PyObject* /* self */, PyObject* args)
{
    const char* key = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "s", &key), "acl.rt.ipc_mem_close args parse failed");

    aclError ret = aclrtIpcMemClose(key);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtValueWrite(PyObject* /* self */, PyObject* args)
{
    void* devAddr = nullptr;
    uint64_t value = 0;
    uint32_t flag = 0;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkIk", &devAddr, &value, &flag, &stream), "acl.rt.value_write args parse failed");
    aclError ret = aclrtValueWrite(devAddr, value, flag, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtValueWait(PyObject* /* self */, PyObject* args)
{
    void* devAddr = nullptr;
    uint64_t value = 0;
    uint32_t flag = 0;
    aclrtStream stream = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "kkIk", &devAddr, &value, &flag, &stream), "acl.rt.value_wait args parse failed");
    aclError ret = aclrtValueWait(devAddr, value, flag, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtHostRegisterV2(PyObject* /* self */, PyObject* args)
{
    void* ptr = nullptr;
    uint64_t size = 0;
    uint32_t flag = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "KKI", &ptr, &size, &flag), "acl.rt.host_register_v2 args parse failed");
    aclError ret = aclrtHostRegisterV2(ptr, size, flag);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclRtHostGetDevicePointer(PyObject* /* self */, PyObject* args)
{
    void* pHost = nullptr;
    void* pDevice = nullptr;
    uint32_t flag = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "KI", &pHost, &flag), "acl.rt.host_get_device_pointer parse failed");
    aclError ret = aclrtHostGetDevicePointer(pHost, &pDevice, flag);
    return Py_BuildValue("Ki", pDevice, ret);
}