/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef WORD_HIMPI_VENC_FUNCS_H
#define WORD_HIMPI_VENC_FUNCS_H

#include <Python.h>
#include "utils_methods.h"

// 视频、图像解码
PyObject* WrapHiMpiVencCreateChn(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencDestroyChn(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencStartChn(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencStopChn(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencQueryStatus(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetStream(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencReleaseStream(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencSendFrame(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencSendFrameEx(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencSetModParam(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetModParam(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencRequestIdr(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetFd(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencCloseFd(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencSetJpegParam(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetJpegParam(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencSetChnParam(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetChnParam(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetChnAttr(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencSetChnAttr(PyObject* self, PyObject* args);

PyObject* WrapHiMpiVencSetSceneMode(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetSceneMode(PyObject* self, PyObject* args);

PyObject* WrapHiMpiVencSetRcParam(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetRcParam(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencSetJpegHuffmanParam(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetJpegHuffmanParam(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencCompactJpegTables(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencSendJpegeFrame(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetJpegePredictedSize(PyObject* self, PyObject* args);

PyObject* WrapHiMpiVencSetCuPred(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetCuPred(PyObject* self, PyObject* args);

PyObject* WrapHiMpiVencSetH264Vui(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetH264Vui(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencSetH265Vui(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetH265Vui(PyObject* self, PyObject* args);

PyObject* WrapHiMpiVencSetIntraRefresh(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetIntraRefresh(PyObject* self, PyObject* args);

PyObject* WrapHiMpiVencSetRefParam(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetRefParam(PyObject* self, PyObject* args);

PyObject* WrapHiMpiVencSetRoiAttr(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetRoiAttr(PyObject* self, PyObject* args);

PyObject* WrapHiMpiVencSetSliceSplit(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetSliceSplit(PyObject* self, PyObject* args);

PyObject* WrapHiMpiVencGetQpmapStride(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetQpmapSize(PyObject* self, PyObject* args);

PyObject* WrapHiMpiVencSetStreamcopyParam(PyObject* self, PyObject* args);
PyObject* WrapHiMpiVencGetStreamcopyParam(PyObject* self, PyObject* args);

template <typename T>
bool GetVencH26ModParamFromPydict(PyObject* pyDict, T& param)
{
    if ((pyDict) == nullptr) {
        return true;
    } else if (PyDict_Check(pyDict) == false) {
        PyErr_SetString(PyExc_TypeError, "the venc h25 mod param is not dict");
        return false;
    }

    GetValueFromPyDict(pyDict, "one_stream_buf", param.one_stream_buf);
    GetValueFromPyDict(pyDict, "mini_buf_mode", param.mini_buf_mode);
    GetValueFromPyDict(pyDict, "low_power_mode", param.low_power_mode);
    GetEnumValueFromPyDict(pyDict, "vb_src", param.vb_src);
    GetEnumValueFromPyDict(pyDict, "qp_hist_en", param.qp_hist_en);
    GetValueFromPyDict(pyDict, "max_user_data_len", param.max_user_data_len);

    return true;
}

template <typename T>
bool GetVencCbrFromPydict(PyObject* pyDict, T& attr)
{
    if (pyDict == nullptr || PyDict_Check(pyDict) == 0) {
        PyErr_SetString(PyExc_TypeError, "the venc cbr argument is not dict");
        return false;
    }

    GetValueFromPyDict(pyDict, "gop", attr.gop);
    GetValueFromPyDict(pyDict, "stats_time", attr.stats_time);
    GetValueFromPyDict(pyDict, "src_frame_rate", attr.src_frame_rate);
    GetValueFromPyDict(pyDict, "dst_frame_rate", attr.dst_frame_rate);
    GetValueFromPyDict(pyDict, "bit_rate", attr.bit_rate);

    return true;
}

template <typename T>
bool GetVencVbrFromPydict(PyObject* pyDict, T& attr)
{
    if (pyDict == nullptr || PyDict_Check(pyDict) == 0) {
        PyErr_SetString(PyExc_TypeError, "the venc vbr argument is not dict");
        return false;
    }

    GetValueFromPyDict(pyDict, "gop", attr.gop);
    GetValueFromPyDict(pyDict, "stats_time", attr.stats_time);
    GetValueFromPyDict(pyDict, "src_frame_rate", attr.src_frame_rate);
    GetValueFromPyDict(pyDict, "dst_frame_rate", attr.dst_frame_rate);
    GetValueFromPyDict(pyDict, "max_bit_rate", attr.max_bit_rate);

    return true;
}

template <typename T>
bool GetVencAVbrFromPydict(PyObject* pyDict, T& attr)
{
    if (pyDict == nullptr || PyDict_Check(pyDict) == 0) {
        PyErr_SetString(PyExc_TypeError, "the venc avbr argument is not dict");
        return false;
    }

    GetValueFromPyDict(pyDict, "gop", attr.gop);
    GetValueFromPyDict(pyDict, "stats_time", attr.stats_time);
    GetValueFromPyDict(pyDict, "src_frame_rate", attr.src_frame_rate);
    GetValueFromPyDict(pyDict, "dst_frame_rate", attr.dst_frame_rate);
    GetValueFromPyDict(pyDict, "max_bit_rate", attr.max_bit_rate);

    return true;
}

template <typename T>
bool GetVencQVbrFromPydict(PyObject* pyDict, T& attr)
{
    if (pyDict == nullptr || PyDict_Check(pyDict) == 0) {
        PyErr_SetString(PyExc_TypeError, "the venc qvbr argument is not dict");
        return false;
    }

    GetValueFromPyDict(pyDict, "gop", attr.gop);
    GetValueFromPyDict(pyDict, "stats_time", attr.stats_time);
    GetValueFromPyDict(pyDict, "src_frame_rate", attr.src_frame_rate);
    GetValueFromPyDict(pyDict, "dst_frame_rate", attr.dst_frame_rate);
    GetValueFromPyDict(pyDict, "target_bit_rate", attr.target_bit_rate);

    return true;
}

template <typename T>
bool GetVencCVbrFromPydict(PyObject* pyDict, T& attr)
{
    if (pyDict == nullptr || PyDict_Check(pyDict) == 0) {
        PyErr_SetString(PyExc_TypeError, "the venc cvbr argument is not dict");
        return false;
    }

    GetValueFromPyDict(pyDict, "gop", attr.gop);
    GetValueFromPyDict(pyDict, "stats_time", attr.stats_time);
    GetValueFromPyDict(pyDict, "src_frame_rate", attr.src_frame_rate);
    GetValueFromPyDict(pyDict, "dst_frame_rate", attr.dst_frame_rate);
    GetValueFromPyDict(pyDict, "max_bit_rate", attr.max_bit_rate);
    GetValueFromPyDict(pyDict, "short_term_stats_time", attr.short_term_stats_time);
    GetValueFromPyDict(pyDict, "long_term_stats_time", attr.long_term_stats_time);
    GetValueFromPyDict(pyDict, "long_term_max_bit_rate", attr.long_term_max_bit_rate);
    GetValueFromPyDict(pyDict, "long_term_min_bit_rate", attr.long_term_min_bit_rate);

    return true;
}

template <typename T>
bool GetVencFixqpFromPydict(PyObject* pyDict, T& attr)
{
    if (pyDict == nullptr || PyDict_Check(pyDict) == 0) {
        PyErr_SetString(PyExc_TypeError, "the venc fixqp argument is not dict");
        return false;
    }

    GetValueFromPyDict(pyDict, "gop", attr.gop);
    GetValueFromPyDict(pyDict, "src_frame_rate", attr.src_frame_rate);
    GetValueFromPyDict(pyDict, "dst_frame_rate", attr.dst_frame_rate);
    GetValueFromPyDict(pyDict, "i_qp", attr.i_qp);
    GetValueFromPyDict(pyDict, "p_qp", attr.p_qp);
    GetValueFromPyDict(pyDict, "b_qp", attr.b_qp);

    return true;
}
#endif // WORD_HIMPI_VENC_FUNCS_H