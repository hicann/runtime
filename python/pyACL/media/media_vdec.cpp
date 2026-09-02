/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "media_vdec.h"
#include <map>
#include "acl/acl.h"
#include "acl/ops/acl_dvpp.h"

namespace {
struct WrapDataStruct {
    PyObject* pyFunc = nullptr;
    PyObject* userData = nullptr;
};

std::map<const aclvdecChannelDesc*, PyObject*> g_callbackMap;
} // anonymous namespace

static void VdecCallback(acldvppStreamDesc* input, acldvppPicDesc* output, void* userData)
{
    PyGILState_STATE state = PyGILState_Ensure();
    ACL_APP_LOG(ACL_DEBUG, "VdecCallback in");
    if (userData == nullptr) {
        ACL_APP_LOG(ACL_ERROR, "VdecCallback data is null");
        return;
    }
    auto wrapData = (WrapDataStruct*)userData;
    PyObject* pData = wrapData->userData;
    PyObject* argslist =
        Py_BuildValue("(kkO)", reinterpret_cast<uintptr_t>(input), reinterpret_cast<uintptr_t>(output), pData);

    PyObject* result = PyObject_CallObject(wrapData->pyFunc, argslist);
    ACL_APP_LOG(ACL_DEBUG, "PyObject_CallObject ok");

    Py_XDECREF(argslist);
    Py_XDECREF(pData);
    if (result == nullptr) {
        if (wrapData != nullptr) {
            delete wrapData;
            wrapData = nullptr;
        }
        ACL_APP_LOG(ACL_ERROR, "VdecCallback wrong out");
        PyGILState_Release(state);
        return;
    }
    Py_XDECREF(result);
    if (wrapData != nullptr) {
        delete wrapData;
        wrapData = nullptr;
    }
    ACL_APP_LOG(ACL_DEBUG, "VdecCallback out");
    PyGILState_Release(state);
    return;
}

PyObject* WrapAclVdecCreateChannel(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.vdec_create_channel args parse failed!");

    aclError ret = aclvdecCreateChannel(channelDesc);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVdecDestroyChannel(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.vdec_destroy_channe args parse failed!");

    aclError ret;
    {
        PyThreadState* state = PyEval_SaveThread();
        ret = aclvdecDestroyChannel(channelDesc);
        PyEval_RestoreThread(state);
    }
    Py_XDECREF(g_callbackMap[channelDesc]);
    g_callbackMap[channelDesc] = nullptr;

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVdecCreateChannelDesc(PyObject* /* self */, PyObject* /* args */)
{
    aclvdecChannelDesc* channelDesc = aclvdecCreateChannelDesc();
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(channelDesc));
}

PyObject* WrapAclVdecDestroyChannelDesc(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.vdec_destroy_channel_desc args parse failed!");

    aclError ret = aclvdecDestroyChannelDesc(channelDesc);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVdecSetChannelDescChannelId(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;
    uint32_t channelId = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &channelDesc, &channelId),
        "acl.media.vdec_set_channel_desc_channel_id args parse failed!");

    aclError ret = aclvdecSetChannelDescChannelId(channelDesc, channelId);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVdecSetChannelDescThreadId(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;
    uint64_t threadId = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kK", &channelDesc, &threadId),
        "acl.media.vdec_set_channel_desc_thread_id args parse failed!");

    aclError ret = aclvdecSetChannelDescThreadId(channelDesc, threadId);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVdecSetChannelDescCallback(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;
    PyObject* pyFunc = nullptr;

    if (PyArg_ParseTuple(args, "kO", &channelDesc, &pyFunc)) {
        CHECK_NULL(PyCallable_Check(pyFunc), "parameter must be callable");
        Py_XINCREF(pyFunc);
    } else {
        ACL_APP_LOG(ACL_ERROR, "acl.media.vdec_set_channel_desc_callback args parse failed!");
        return nullptr;
    }

    if (g_callbackMap.count(channelDesc) != 0) {
        ACL_APP_LOG(ACL_DEBUG, "already has channelDesc");
        Py_XDECREF(g_callbackMap[channelDesc]);
        g_callbackMap[channelDesc] = pyFunc;
    } else {
        g_callbackMap.insert(std::pair<aclvdecChannelDesc*, PyObject*>(channelDesc, pyFunc));
        ACL_APP_LOG(ACL_DEBUG, "set channelDesc");
    }

    aclError ret = aclvdecSetChannelDescCallback(channelDesc, VdecCallback);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVdecSetChannelDescEnType(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;
    int enType = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ki", &channelDesc, &enType),
        "acl.media.vdec_set_channel_desc_entype args parse failed!");

    aclError ret = aclvdecSetChannelDescEnType(channelDesc, static_cast<acldvppStreamFormat>(enType));
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVdecSetChannelDescOutPicFormat(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;
    int outPicFormat = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ki", &channelDesc, &outPicFormat),
        "acl.media.vdec_set_channel_desc_out_pic_format args parse failed!");

    aclError ret = aclvdecSetChannelDescOutPicFormat(channelDesc, static_cast<acldvppPixelFormat>(outPicFormat));
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVdecSetChannelDescOutPicWidth(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;
    uint32_t outPicWidth = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &channelDesc, &outPicWidth),
        "acl.media.vdec_set_channel_desc_out_pic_width args parse failed!");

    aclError ret = aclvdecSetChannelDescOutPicWidth(channelDesc, outPicWidth);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVdecSetChannelDescOutPicHeight(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;
    uint32_t outPicHeight = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &channelDesc, &outPicHeight),
        "acl.media.vdec_set_channel_desc_out_pic_height args parse failed!");

    aclError ret = aclvdecSetChannelDescOutPicHeight(channelDesc, outPicHeight);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVdecSetChannelDescRefFrameNum(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;
    uint32_t refFrameNum = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &channelDesc, &refFrameNum),
        "acl.media.vdec_set_channel_desc_ref_frame_num args parse failed!");

    aclError ret = aclvdecSetChannelDescRefFrameNum(channelDesc, refFrameNum);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVdecGetChannelDescChannelId(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.vdec_get_channel_desc_channel_id args parse failed!");

    uint32_t channelId = aclvdecGetChannelDescChannelId(channelDesc);
    return Py_BuildValue("I", channelId);
}

PyObject* WrapAclVdecGetChannelDescThreadId(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.vdec_get_channel_desc_thread_id args parse failed!");

    uint64_t threadId = aclvdecGetChannelDescThreadId(channelDesc);
    return Py_BuildValue("K", threadId);
}

PyObject* WrapAclVdecGetChannelDescCallback(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.vdec_get_channel_desc_callback args parse failed!");

    PyObject* pyFunc = nullptr;
    CHECK_NULL(g_callbackMap.count(channelDesc), "did not set callback, failed", PyExc_RuntimeError);
    ACL_APP_LOG(ACL_DEBUG, "already has channelDesc");
    pyFunc = g_callbackMap[channelDesc];
    return Py_BuildValue("O", pyFunc);
}

PyObject* WrapAclVdecGetChannelDescEnType(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.vdec_get_channel_desc_entype args parse failed!");

    int enType = aclvdecGetChannelDescEnType(channelDesc);
    return Py_BuildValue("i", enType);
}

PyObject* WrapAclVdecGetChannelDescOutPicFormat(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.vdec_get_channel_desc_out_pic_format args parse failed!");

    int outPicFormat = aclvdecGetChannelDescOutPicFormat(channelDesc);
    return Py_BuildValue("i", outPicFormat);
}

PyObject* WrapAclVdecGetChannelDescOutPicWidth(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.vdec_get_channel_desc_out_pic_width args parse failed!");

    uint32_t outPicWidth = aclvdecGetChannelDescOutPicWidth(channelDesc);
    return Py_BuildValue("I", outPicWidth);
}

PyObject* WrapAclVdecGetChannelDescOutPicHeight(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.vdec_get_channel_desc_out_pic_height args parse failed!");

    uint32_t outPicHeight = aclvdecGetChannelDescOutPicHeight(channelDesc);
    return Py_BuildValue("I", outPicHeight);
}

PyObject* WrapAclVdecGetChannelDescRefFrameNum(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.vdec_get_channel_desc_ref_frame_num args parse failed!");

    uint32_t refFrameNum = aclvdecGetChannelDescRefFrameNum(channelDesc);
    return Py_BuildValue("I", refFrameNum);
}

PyObject* WrapAclVdecSendFrame(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;
    acldvppStreamDesc* input = nullptr;
    acldvppPicDesc* output = nullptr;
    aclvdecFrameConfig* config = nullptr;
    PyObject* userData = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkO", &channelDesc, &input, &output, &config, &userData),
        "acl.media.vdec_send_frame args parse failed!");

    PyObject* pyFunc = nullptr;
    CHECK_NULL(g_callbackMap.count(channelDesc), "did not set callback, failed", PyExc_RuntimeError);
    ACL_APP_LOG(ACL_DEBUG, "already has channelDesc");
    pyFunc = g_callbackMap[channelDesc];

    Py_XINCREF(userData);
    auto wrapData = new (std::nothrow) WrapDataStruct();
    CHECK_NULL(wrapData, "new failed", PyExc_MemoryError);
    wrapData->pyFunc = pyFunc;
    wrapData->userData = userData;

    PyThreadState* state = PyEval_SaveThread();
    aclError ret = aclvdecSendFrame(channelDesc, input, output, config, reinterpret_cast<void*>(wrapData));
    PyEval_RestoreThread(state);

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVdecSendSkippedFrame(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;
    acldvppStreamDesc* input = nullptr;
    aclvdecFrameConfig* config = nullptr;
    PyObject* userData = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkO", &channelDesc, &input, &config, &userData),
        "acl.media.vdec_send_skipped_frame args parse failed!");

    PyObject* pyFunc = nullptr;
    CHECK_NULL(g_callbackMap.count(channelDesc), "did not set callback, failed", PyExc_RuntimeError);
    ACL_APP_LOG(ACL_DEBUG, "already has channelDesc");
    pyFunc = g_callbackMap[channelDesc];

    Py_XINCREF(userData);
    auto wrapData = new (std::nothrow) WrapDataStruct();
    CHECK_NULL(wrapData, "new failed", PyExc_MemoryError);
    wrapData->pyFunc = pyFunc;
    wrapData->userData = userData;

    PyThreadState* state = PyEval_SaveThread();
    aclError ret = aclvdecSendSkippedFrame(channelDesc, input, config, reinterpret_cast<void*>(wrapData));
    PyEval_RestoreThread(state);

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVdecCreateFrameConfig(PyObject* /* self */, PyObject* /* args */)
{
    aclvdecFrameConfig* frameConfig = aclvdecCreateFrameConfig();
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(frameConfig));
}

PyObject* WrapAclVdecDestroyFrameConfig(PyObject* /* self */, PyObject* args)
{
    aclvdecFrameConfig* frameConfig = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &frameConfig), "acl.media.vdec_destroy_frame_config args parse failed!");

    aclError ret = aclvdecDestroyFrameConfig(frameConfig);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVdecGetChannelDescOutMode(PyObject* /* self */, PyObject* args)
{
    const aclvdecChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.vdec_get_channel_desc_out_mode args parse failed!");

    uint32_t outMode = aclvdecGetChannelDescOutMode(channelDesc);
    return Py_BuildValue("I", outMode);
}

PyObject* WrapAclVdecSetChannelDescOutMode(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;
    uint32_t outMode = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &channelDesc, &outMode),
        "acl.media.vdec_set_channel_desc_out_mode args parse failed!");

    aclError ret = aclvdecSetChannelDescOutMode(channelDesc, outMode);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVdecGetChannelDescBitDepth(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.vdec_get_channel_desc_bit_depth args parse failed!");

    aclError outBitDepth = static_cast<aclError>(aclvdecGetChannelDescBitDepth(channelDesc));
    return Py_BuildValue("i", outBitDepth);
}

PyObject* WrapAclVdecSetChannelDescBitDepth(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;
    uint32_t outBitDepth = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &channelDesc, &outBitDepth),
        "acl.media.vdec_set_channel_desc_bit_depth args parse failed!");

    aclError ret = aclvdecSetChannelDescBitDepth(channelDesc, outBitDepth);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVdecSetChannelDescParam(PyObject* /* self */, PyObject* args)
{
    aclvdecChannelDesc* channelDesc = nullptr;
    aclvdecChannelDescParamType paramType = ACL_VDEC_CSC_MATRIX_UINT32;
    size_t length = 0;
    const void* param = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kik", &channelDesc, &paramType, &param),
        "acl.media.vdec_set_channel_desc_param args parse failed");

    switch (static_cast<aclvdecChannelDescParamType>(paramType)) {
        case ACL_VDEC_CSC_MATRIX_UINT32:
            length = sizeof(uint32_t);
            break;
        default:
            length = 0;
    }

    aclError ret = aclvdecSetChannelDescParam(channelDesc, paramType, length, reinterpret_cast<const void*>(&param));
    return Py_BuildValue("ki", channelDesc, ret);
}

PyObject* WrapAclVdecGetChannelDescParam(PyObject* /* self */, PyObject* args)
{
    const aclvdecChannelDesc* channelDesc = nullptr;
    aclvdecChannelDescParamType paramType = ACL_VDEC_CSC_MATRIX_UINT32;
    size_t length = 0;
    size_t paramRetSize = 0;
    void* param = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ki", &channelDesc, &paramType),
        "acl.media.vdec_get_channel_desc_param args parse failed");

    switch (static_cast<aclvdecChannelDescParamType>(paramType)) {
        case ACL_VDEC_CSC_MATRIX_UINT32:
            length = sizeof(uint32_t);
            break;
        default:
            length = 0;
    }

    aclError ret =
        aclvdecGetChannelDescParam(channelDesc, paramType, length, &paramRetSize, reinterpret_cast<void*>(&param));
    return Py_BuildValue("kki", paramRetSize, param, ret);
}