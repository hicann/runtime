/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "media_venc.h"
#include <map>
#include "acl/acl.h"
#include "acl/ops/acl_dvpp.h"

namespace {
struct WrapDataStruct {
    PyObject* pyFunc = nullptr;
    PyObject* userData = nullptr;
};

std::map<const aclvencChannelDesc*, PyObject*> g_callbackMapVenc;
} // anonymous namespace

static void VencCallback(acldvppPicDesc* input, acldvppStreamDesc* output, void* userData)
{
    PyGILState_STATE state = PyGILState_Ensure();
    ACL_APP_LOG(ACL_DEBUG, "VencCallback in");
    if (userData == nullptr) {
        ACL_APP_LOG(ACL_ERROR, "VencCallback args error");
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
        delete wrapData;
        wrapData = nullptr;
        ACL_APP_LOG(ACL_ERROR, "VencCallback wrong");
        PyGILState_Release(state);
        return;
    }
    Py_XDECREF(result);
    delete wrapData;
    wrapData = nullptr;
    ACL_APP_LOG(ACL_DEBUG, "VencCallback");
    PyGILState_Release(state);
    return;
}

PyObject* WrapAclVencCreateChannel(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.venc_create_channel args parse failed!");

    aclError ret = aclvencCreateChannel(channelDesc);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencDestroyChannel(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.venc_destroy_channel args parse failed!");

    PyThreadState* state = PyEval_SaveThread();
    aclError ret = aclvencDestroyChannel(channelDesc);
    PyEval_RestoreThread(state);
    Py_XDECREF(g_callbackMapVenc[channelDesc]);
    g_callbackMapVenc[channelDesc] = nullptr;

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencSendFrame(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;
    acldvppPicDesc* input = nullptr;
    void* reserve = nullptr;
    aclvencFrameConfig* config = nullptr;
    PyObject* userData = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkkkO", &channelDesc, &input, &reserve, &config, &userData),
        "acl.media.venc_send_frame args parse failed!");

    PyObject* pyFunc = nullptr;
    if (g_callbackMapVenc.count(channelDesc) != 0) {
        ACL_APP_LOG(ACL_DEBUG, "already has channelDesc");
        pyFunc = g_callbackMapVenc[channelDesc];
    } else {
        PyErr_SetString(PyExc_RuntimeError, "did not set callback, failed");
        return nullptr;
    }

    Py_XINCREF(userData);
    auto wrapData = new (std::nothrow) WrapDataStruct();
    CHECK_NULL(wrapData, "new failed", PyExc_MemoryError);

    wrapData->pyFunc = pyFunc;
    wrapData->userData = userData;

    PyThreadState* state = PyEval_SaveThread();
    aclError ret = aclvencSendFrame(channelDesc, input, reserve, config, reinterpret_cast<void*>(wrapData));
    PyEval_RestoreThread(state);

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencCreateChannelDesc(PyObject* /* self */, PyObject* /* args */)
{
    aclvencChannelDesc* channelDesc = aclvencCreateChannelDesc();

    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(channelDesc));
}

PyObject* WrapAclVencDestroyChannelDesc(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.venc_destroy_channel_desc args parse failed!");

    aclError ret = aclvencDestroyChannelDesc(channelDesc);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencSetChannelDescThreadId(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;
    uint64_t threadId = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kK", &channelDesc, &threadId),
        "acl.media.venc_set_channel_desc_thread_id args parse failed!");

    aclError ret = aclvencSetChannelDescThreadId(channelDesc, threadId);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencSetChannelDescCallback(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;
    PyObject* pyFunc = nullptr;

    if (PyArg_ParseTuple(args, "kO", &channelDesc, &pyFunc)) {
        CHECK_NULL(PyCallable_Check(pyFunc), "parameter must be callable");
        Py_XINCREF(pyFunc);
    } else {
        ACL_APP_LOG(ACL_ERROR, "acl.media.venc_set_channel_desc_callback args parse failed!");
        return nullptr;
    }

    if (g_callbackMapVenc.count(channelDesc) != 0) {
        ACL_APP_LOG(ACL_DEBUG, "already has channelDesc");
        Py_XDECREF(g_callbackMapVenc[channelDesc]);
        g_callbackMapVenc[channelDesc] = pyFunc;
    } else {
        g_callbackMapVenc.insert(std::pair<aclvencChannelDesc*, PyObject*>(channelDesc, pyFunc));
        ACL_APP_LOG(ACL_DEBUG, "set channelDesc");
    }

    aclError ret = aclvencSetChannelDescCallback(channelDesc, VencCallback);

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencSetChannelDescEnType(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;
    int enType = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ki", &channelDesc, &enType),
        "acl.media.venc_set_channel_desc_entype args parse failed!");

    aclError ret = aclvencSetChannelDescEnType(channelDesc, static_cast<acldvppStreamFormat>(enType));
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencSetChannelDescPicFormat(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;
    int picFormat = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ki", &channelDesc, &picFormat),
        "acl.media.venc_set_channel_desc_pic_format args parse failed!");

    aclError ret = aclvencSetChannelDescPicFormat(channelDesc, static_cast<acldvppPixelFormat>(picFormat));
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencSetChannelDescPicWidth(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;
    uint32_t picWidth = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &channelDesc, &picWidth),
        "acl.media.venc_set_channel_desc_pic_width args parse failed!");

    aclError ret = aclvencSetChannelDescPicWidth(channelDesc, picWidth);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencSetChannelDescPicHeight(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;
    uint32_t picHeight = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &channelDesc, &picHeight),
        "acl.media.venc_set_channel_desc_pic_height args parse failed!");

    aclError ret = aclvencSetChannelDescPicHeight(channelDesc, picHeight);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencSetChannelDescKeyFrameInterval(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;
    uint32_t keyFrameInterval = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &channelDesc, &keyFrameInterval),
        "acl.media.venc_set_channel_desc_key_frame_interval args parse failed!");

    aclError ret = aclvencSetChannelDescKeyFrameInterval(channelDesc, keyFrameInterval);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencGetChannelDescChannelId(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.venc_get_channel_desc_channel_id args parse failed!");

    uint32_t channelId = aclvencGetChannelDescChannelId(channelDesc);
    return Py_BuildValue("I", channelId);
}

PyObject* WrapAclVencGetChannelDescThreadId(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.venc_get_channel_desc_thread_id args parse failed!");

    uint64_t threadId = aclvencGetChannelDescThreadId(channelDesc);
    return Py_BuildValue("K", threadId);
}

PyObject* WrapAclVencGetChannelDescCallback(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.venc_get_channel_desc_callback args parse failed!");

    PyObject* pyFunc = nullptr;
    if (g_callbackMapVenc.count(channelDesc) != 0) {
        ACL_APP_LOG(ACL_DEBUG, "already has channelDesc");
        pyFunc = g_callbackMapVenc[channelDesc];
    } else {
        PyErr_SetString(PyExc_RuntimeError, "did not set callback, failed");
        return nullptr;
    }

    return Py_BuildValue("O", pyFunc);
}

PyObject* WrapAclVencGetChannelDescEnType(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.venc_get_channel_desc_entype args parse failed!");

    int enType = aclvencGetChannelDescEnType(channelDesc);
    return Py_BuildValue("i", enType);
}

PyObject* WrapAclVencGetChannelDescPicFormat(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.venc_get_channel_desc_pic_format args parse failed!");

    int picFormat = aclvencGetChannelDescPicFormat(channelDesc);
    return Py_BuildValue("i", picFormat);
}

PyObject* WrapAclVencGetChannelDescPicWidth(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.venc_get_channel_desc_pic_width args parse failed!");

    uint32_t picWidth = aclvencGetChannelDescPicWidth(channelDesc);
    return Py_BuildValue("I", picWidth);
}

PyObject* WrapAclVencGetChannelDescPicHeight(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.venc_get_channel_desc_pic_height args parse failed!");

    uint32_t picHeight = aclvencGetChannelDescPicHeight(channelDesc);
    return Py_BuildValue("I", picHeight);
}

PyObject* WrapAclVencGetChannelDescKeyFrameInterval(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc),
        "acl.media.venc_get_channel_desc_key_frame_interval args parse failed!");

    uint32_t keyFrameInterval = aclvencGetChannelDescKeyFrameInterval(channelDesc);
    return Py_BuildValue("I", keyFrameInterval);
}

PyObject* WrapAclVencCreateFrameConfig(PyObject* /* self */, PyObject* /* args */)
{
    aclvencFrameConfig* frameConfig = aclvencCreateFrameConfig();

    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(frameConfig));
}

PyObject* WrapAclVencDestroyFrameConfig(PyObject* /* self */, PyObject* args)
{
    aclvencFrameConfig* frameConfig = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &frameConfig), "acl.media.venc_destroy_frame_config args parse failed!");

    aclError ret = aclvencDestroyFrameConfig(frameConfig);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencSetFrameConfigForceIFrame(PyObject* /* self */, PyObject* args)
{
    aclvencFrameConfig* config = nullptr;
    uint8_t forceIFrame = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kB", &config, &forceIFrame),
        "acl.media.venc_set_frame_config_force_i_frame args parse failed!");

    aclError ret = aclvencSetFrameConfigForceIFrame(config, forceIFrame);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencSetFrameConfigEos(PyObject* /* self */, PyObject* args)
{
    aclvencFrameConfig* config = nullptr;
    uint8_t eos = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "kB", &config, &eos), "acl.media.venc_set_frame_config_eos args parse failed!");

    aclError ret = aclvencSetFrameConfigEos(config, eos);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencGetFrameConfigForceIFrame(PyObject* /* self */, PyObject* args)
{
    aclvencFrameConfig* config = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &config), "acl.media.venc_get_frame_config_force_i_frame args parse failed!");

    uint8_t ret = aclvencGetFrameConfigForceIFrame(config);
    return Py_BuildValue("B", ret);
}

PyObject* WrapAclVencGetFrameConfigEos(PyObject* /* self */, PyObject* args)
{
    aclvencFrameConfig* config = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &config), "acl.media.venc_get_frame_config_eos args parse failed!");

    uint8_t ret = aclvencGetFrameConfigEos(config);
    return Py_BuildValue("B", ret);
}

PyObject* WrapAclVencGetChannelDescBufAddr(PyObject* /* self */, PyObject* args)
{
    const aclvencChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.venc_get_channel_desc_buf_addr args parse failed!");

    void* bufAddr = aclvencGetChannelDescBufAddr(channelDesc);
    return Py_BuildValue("k", bufAddr);
}

PyObject* WrapAclVencSetChannelDescBufAddr(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;
    void* bufAddr = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kk", &channelDesc, &bufAddr),
        "acl.media.venc_set_channel_desc_buf_addr args parse failed!");

    aclError ret = aclvencSetChannelDescBufAddr(channelDesc, bufAddr);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencGetChannelDescBufSize(PyObject* /* self */, PyObject* args)
{
    const aclvencChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.venc_get_channel_desc_buf_size args parse failed!");

    uint32_t bufSize = aclvencGetChannelDescBufSize(channelDesc);
    return Py_BuildValue("I", bufSize);
}

PyObject* WrapAclVencSetChannelDescBufSize(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;
    uint32_t bufSize = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &channelDesc, &bufSize),
        "acl.media.venc_set_channel_desc_buf_size args parse failed!");

    aclError ret = aclvencSetChannelDescBufSize(channelDesc, bufSize);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencGetChannelDescMaxBitRate(PyObject* /* self */, PyObject* args)
{
    const aclvencChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.venc_get_channel_desc_max_bit_rate args parse failed!");

    uint32_t maxbitRate = aclvencGetChannelDescMaxBitRate(channelDesc);
    return Py_BuildValue("I", maxbitRate);
}

PyObject* WrapAclVencSetChannelDescMaxBitRate(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;
    uint32_t maxBitRate = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &channelDesc, &maxBitRate),
        "acl.media.venc_set_channel_desc_max_bit_rate args parse failed!");

    aclError ret = aclvencSetChannelDescMaxBitRate(channelDesc, maxBitRate);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencGetChannelDescRcMode(PyObject* /* self */, PyObject* args)
{
    const aclvencChannelDesc* channelDesc = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.venc_get_channel_desc_rc_mode args parse failed!");

    uint32_t rcMode = aclvencGetChannelDescRcMode(channelDesc);
    return Py_BuildValue("I", rcMode);
}

PyObject* WrapAclVencSetChannelDescRcMode(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;
    uint32_t rcMode = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &channelDesc, &rcMode),
        "acl.media.venc_set_channel_desc_rc_mode args parse failed!");

    aclError ret = aclvencSetChannelDescRcMode(channelDesc, rcMode);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencGetChannelDescSrcRate(PyObject* /* self */, PyObject* args)
{
    const aclvencChannelDesc* channelDesc = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "k", &channelDesc), "acl.media.venc_get_channel_desc_src_rate args parse failed!");

    uint32_t srcRate = aclvencGetChannelDescSrcRate(channelDesc);
    return Py_BuildValue("I", srcRate);
}

PyObject* WrapAclVencSetChannelDescSrcRate(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;
    uint32_t srcRate = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kI", &channelDesc, &srcRate),
        "acl.media.venc_set_channel_desc_src_rate args parse failed!");

    aclError ret = aclvencSetChannelDescSrcRate(channelDesc, srcRate);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclVencGetChannelDescParam(PyObject* /* self */, PyObject* args)
{
    const aclvencChannelDesc* channelDesc = nullptr;
    int paramType = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "ki", &channelDesc, &paramType),
        "acl.media.venc_get_channel_desc_param args parse failed!");

    PyObject* pyFunc = nullptr;
    size_t paramRetSize = 0;
    void* bufAddr = nullptr;
    uint64_t attrValueUint64 = 0;
    uint64_t attrValueUint32 = 0;
    aclError ret = ACL_SUCCESS;
    switch (static_cast<aclvencChannelDescParamType>(paramType)) {
        case ACL_VENC_CALLBACK_PTR:
            if (g_callbackMapVenc.count(channelDesc) != 0) {
                ACL_APP_LOG(ACL_DEBUG, "already has channelDesc");
                pyFunc = g_callbackMapVenc[channelDesc];
            } else {
                PyErr_SetString(PyExc_RuntimeError, "did not set callback, failed");
                return nullptr;
            }
            return Py_BuildValue("Oi", pyFunc, ACL_SUCCESS);
        case ACL_VENC_BUF_ADDR_PTR:
            ret = aclvencGetChannelDescParam(
                channelDesc, static_cast<aclvencChannelDescParamType>(paramType), sizeof(void*), &paramRetSize,
                &bufAddr);
            return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(bufAddr), ret);
        case ACL_VENC_THREAD_ID_UINT64:
            ret = aclvencGetChannelDescParam(
                channelDesc, static_cast<aclvencChannelDescParamType>(paramType), sizeof(uint64_t), &paramRetSize,
                &attrValueUint64);
            return Py_BuildValue("Ki", attrValueUint64, ret);
        default:
            ret = aclvencGetChannelDescParam(
                channelDesc, static_cast<aclvencChannelDescParamType>(paramType), sizeof(uint32_t), &paramRetSize,
                &attrValueUint32);
            return Py_BuildValue("Ki", attrValueUint32, ret);
    }
}

static aclError SetVencCallback(
    aclvencChannelDesc* channelDesc, aclvencChannelDescParamType paramType, PyObject* pyFunc)
{
    if ((channelDesc == nullptr) || (pyFunc == nullptr)) {
        ACL_APP_LOG(ACL_ERROR, "SetVencCallback args error");
        return ACL_ERROR_INVALID_PARAM;
    }
    if (PyCallable_Check(pyFunc) == 0) {
        PyErr_SetString(PyExc_TypeError, "parameter must be callable");
        return ACL_ERROR_INVALID_PARAM;
    }
    Py_XINCREF(pyFunc);
    if (g_callbackMapVenc.count(channelDesc) != 0) {
        ACL_APP_LOG(ACL_DEBUG, "already has channelDesc");
        Py_XDECREF(g_callbackMapVenc[channelDesc]);
        g_callbackMapVenc[channelDesc] = pyFunc;
    } else {
        g_callbackMapVenc.insert(std::pair<aclvencChannelDesc*, PyObject*>(channelDesc, pyFunc));
        ACL_APP_LOG(ACL_DEBUG, "set channelDesc");
    }
    void* func = reinterpret_cast<void*>(VencCallback);
    aclError ret = aclvencSetChannelDescParam(
        channelDesc, static_cast<aclvencChannelDescParamType>(paramType), sizeof(void*), &func);
    return ret;
}

PyObject* WrapAclVencSetChannelDescParam(PyObject* /* self */, PyObject* args)
{
    aclvencChannelDesc* channelDesc = nullptr;
    int paramType = 0;
    PyObject* param = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kiO", &channelDesc, &paramType, &param),
        "acl.media.venc_set_channel_desc_param args parse failed!");

    aclError ret = 0;
    const void* bufAddr = nullptr;
    uint64_t attrValueUint64 = 0;
    uint32_t attrValueUint32 = 0;
    switch (static_cast<aclvencChannelDescParamType>(paramType)) {
        case ACL_VENC_CALLBACK_PTR:
            ret = SetVencCallback(channelDesc, static_cast<aclvencChannelDescParamType>(paramType), param);
            break;
        case ACL_VENC_BUF_ADDR_PTR:
            CHECK_NULL(PyArg_Parse(param, "k", &bufAddr), "acl.media.venc_set_channel_desc_param args parse failed!");
            ret = aclvencSetChannelDescParam(
                channelDesc, static_cast<aclvencChannelDescParamType>(paramType), sizeof(void*), &bufAddr);
            break;
        case ACL_VENC_THREAD_ID_UINT64:
            CHECK_NULL(
                PyArg_Parse(param, "K", &attrValueUint64), "acl.media.venc_set_channel_desc_param args parse failed!");
            ret = aclvencSetChannelDescParam(
                channelDesc, static_cast<aclvencChannelDescParamType>(paramType), sizeof(uint64_t),
                reinterpret_cast<const void*>(&attrValueUint64));
            break;
        default:
            CHECK_NULL(
                PyArg_Parse(param, "I", &attrValueUint32), "acl.media.venc_set_channel_desc_param args parse failed!");
            ret = aclvencSetChannelDescParam(
                channelDesc, static_cast<aclvencChannelDescParamType>(paramType), sizeof(uint32_t),
                reinterpret_cast<const void*>(&attrValueUint32));
    }
    return Py_BuildValue("i", ret);
}
