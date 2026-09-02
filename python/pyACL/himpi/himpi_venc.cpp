/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "himpi_venc.h"
#include "acl/acl.h"
#include "acl/dvpp/hi_dvpp_venc.h"

namespace {
bool GetVencH264CbrFromPydict(PyObject* pyDict, hi_venc_h264_cbr_param& param);
bool GetVencH264VbrFromPydict(PyObject* pyDict, hi_venc_h264_vbr_param& param);
bool GetVencH264AvbrFromPydict(PyObject* pyDict, hi_venc_h264_avbr_param& param);
bool GetVencH264QvbrFromPydict(PyObject* pyDict, hi_venc_h264_qvbr_param& param);
bool GetVencH264CvbrFromPydict(PyObject* pyDict, hi_venc_h264_cvbr_param& param);
bool GetVencH265CbrFromPydict(PyObject* pyDict, hi_venc_h265_cbr_param& param);
bool GetVencH265VbrFromPydict(PyObject* pyDict, hi_venc_h265_vbr_param& param);
bool GetVencH265AvbrFromPydict(PyObject* pyDict, hi_venc_h265_avbr_param& param);
bool GetVencH265QvbrFromPydict(PyObject* pyDict, hi_venc_h265_qvbr_param& param);
bool GetVencH265CvbrFromPydict(PyObject* pyDict, hi_venc_h265_cvbr_param& param);
bool GetVencMjpegCbrFromPydict(PyObject* pyDict, hi_venc_mjpeg_cbr_param& param);
bool GetVencMjpegVbrFromPydict(PyObject* pyDict, hi_venc_mjpeg_vbr_param& param);

PyObject* GetPydictFromVencH264CbrParam(hi_venc_h264_cbr_param& param);
PyObject* GetPydictFromVencH264VbrParam(hi_venc_h264_vbr_param& param);
PyObject* GetPydictFromVencH264AvbrParam(hi_venc_h264_avbr_param& param);
PyObject* GetPydictFromVencH264QvbrParam(hi_venc_h264_qvbr_param& param);
PyObject* GetPydictFromVencH264CvbrParam(hi_venc_h264_cvbr_param& param);
PyObject* GetPydictFromVencH265CbrParam(hi_venc_h265_cbr_param& param);
PyObject* GetPydictFromVencH265VbrParam(hi_venc_h265_vbr_param& param);
PyObject* GetPydictFromVencH265AvbrParam(hi_venc_h265_avbr_param& param);
PyObject* GetPydictFromVencH265QvbrParam(hi_venc_h265_qvbr_param& param);
PyObject* GetPydictFromVencH265CvbrParam(hi_venc_h265_cvbr_param& param);
PyObject* GetPydictFromVencMjpegCbrParam(hi_venc_mjpeg_cbr_param& param);
PyObject* GetPydictFromVencMjpegVbrParam(hi_venc_mjpeg_vbr_param& param);
} // namespace

static bool GetVencH264AttrFromPydict(PyObject* pyDict, hi_venc_h264_attr& attr)
{
    if (pyDict == nullptr) {
        return true;
    }

    CHECK_STRUCT_DICT(pyDict, "the type of hi_venc_h264_attr argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "rcn_ref_share_buf_en", attr.rcn_ref_share_buf_en));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "frame_buf_ratio", attr.frame_buf_ratio));
    return true;
}

static bool GetVencH265AttrFromPydict(PyObject* pyDict, hi_venc_h265_attr& attr)
{
    if (pyDict == nullptr) {
        return true;
    }

    CHECK_STRUCT_DICT(pyDict, "the type of hi_venc_h265_attr argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "rcn_ref_share_buf_en", attr.rcn_ref_share_buf_en));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "frame_buf_ratio", attr.frame_buf_ratio));
    return true;
}

static bool GetVencAttrFromPydict(PyObject* pyDict, hi_venc_attr& attr)
{
    CHECK_STRUCT_DICT(pyDict, "the type of hi_venc_attr argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "type", attr.type));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_pic_width", attr.max_pic_width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_pic_height", attr.max_pic_height));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "buf_size", attr.buf_size));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "profile", attr.profile));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "is_by_frame", attr.is_by_frame));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "pic_width", attr.pic_width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "pic_height", attr.pic_height));

    if (attr.type == HI_PT_H264) {
        PyObject* pyH264Attr = PyDict_GetItemString(pyDict, "h264_attr");
        CHECK_BOOL(GetVencH264AttrFromPydict(pyH264Attr, attr.h264_attr));
    } else if (attr.type == HI_PT_H265) {
        PyObject* pyH265Attr = PyDict_GetItemString(pyDict, "h265_attr");
        CHECK_BOOL(GetVencH265AttrFromPydict(pyH265Attr, attr.h265_attr));
    }
    return true;
}

static bool GetVencRcAttrFromPydict(PyObject* pyDict, hi_venc_rc_attr& attr)
{
    attr.rc_mode = HI_VENC_RC_MODE_BUTT;
    CHECK_STRUCT_DICT(pyDict, "the type of hi_venc_rc_attr argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "rc_mode", attr.rc_mode));

    if (attr.rc_mode == HI_VENC_RC_MODE_H264_CBR) {
        CHECK_BOOL(GetVencCbrFromPydict(PyDict_GetItemString(pyDict, "h264_cbr"), attr.h264_cbr));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H264_VBR) {
        CHECK_BOOL(GetVencVbrFromPydict(PyDict_GetItemString(pyDict, "h264_vbr"), attr.h264_vbr));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H264_AVBR) {
        CHECK_BOOL(GetVencAVbrFromPydict(PyDict_GetItemString(pyDict, "h264_avbr"), attr.h264_avbr));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H264_QVBR) {
        CHECK_BOOL(GetVencQVbrFromPydict(PyDict_GetItemString(pyDict, "h264_qvbr"), attr.h264_qvbr));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H264_CVBR) {
        CHECK_BOOL(GetVencCVbrFromPydict(PyDict_GetItemString(pyDict, "h264_cvbr"), attr.h264_cvbr));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H264_FIXQP) {
        CHECK_BOOL(GetVencFixqpFromPydict(PyDict_GetItemString(pyDict, "h264_fixqp"), attr.h264_fixqp));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H265_CBR) {
        CHECK_BOOL(GetVencCbrFromPydict(PyDict_GetItemString(pyDict, "h265_cbr"), attr.h265_cbr));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H265_VBR) {
        CHECK_BOOL(GetVencVbrFromPydict(PyDict_GetItemString(pyDict, "h265_vbr"), attr.h265_vbr));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H265_AVBR) {
        CHECK_BOOL(GetVencAVbrFromPydict(PyDict_GetItemString(pyDict, "h265_avbr"), attr.h265_avbr));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H265_QVBR) {
        CHECK_BOOL(GetVencQVbrFromPydict(PyDict_GetItemString(pyDict, "h265_qvbr"), attr.h265_qvbr));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H265_CVBR) {
        CHECK_BOOL(GetVencCVbrFromPydict(PyDict_GetItemString(pyDict, "h265_cvbr"), attr.h265_cvbr));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H265_FIXQP) {
        CHECK_BOOL(GetVencFixqpFromPydict(PyDict_GetItemString(pyDict, "h265_fixqp"), attr.h265_fixqp));
    }

    return true;
}

static bool GetVencGopAttrFromPydict(PyObject* pyDict, hi_venc_gop_attr& attr)
{
    attr.gop_mode = HI_VENC_GOP_MODE_BUTT;
    CHECK_STRUCT_DICT(pyDict, "the type of hi_venc_gop_attr argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "gop_mode", attr.gop_mode));
    if (attr.gop_mode == HI_VENC_GOP_MODE_NORMAL_P) {
        PyObject* pyNormal = PyDict_GetItemString(pyDict, "normal_p");
        CHECK_BOOL(GetValueFromPyDict(pyNormal, "ip_qp_delta", attr.normal_p.ip_qp_delta));
    } else if (attr.gop_mode == HI_VENC_GOP_MODE_DUAL_P) {
        PyObject* pyDual = PyDict_GetItemString(pyDict, "dual_p");
        CHECK_BOOL(GetValueFromPyDict(pyDual, "sp_interval", attr.dual_p.sp_interval));
        CHECK_BOOL(GetValueFromPyDict(pyDual, "sp_qp_delta", attr.dual_p.sp_qp_delta));
        CHECK_BOOL(GetValueFromPyDict(pyDual, "ip_qp_delta", attr.dual_p.ip_qp_delta));
    } else if (attr.gop_mode == HI_VENC_GOP_MODE_SMART_P) {
        PyObject* pySmart = PyDict_GetItemString(pyDict, "smart_p");
        CHECK_BOOL(GetValueFromPyDict(pySmart, "bg_interval", attr.smart_p.bg_interval));
        CHECK_BOOL(GetValueFromPyDict(pySmart, "bg_qp_delta", attr.smart_p.bg_qp_delta));
        CHECK_BOOL(GetValueFromPyDict(pySmart, "vi_qp_delta", attr.smart_p.vi_qp_delta));
    }

    return true;
}

static bool GetVencChnAttrFromPydict(PyObject* pyDict, hi_venc_chn_attr& attr)
{
    CHECK_STRUCT_DICT(pyDict, "the type of hi_venc_chn_attr argument is not dict");
    PyObject* pyVencAttr = PyDict_GetItemString(pyDict, "venc_attr");
    CHECK_BOOL(GetVencAttrFromPydict(pyVencAttr, attr.venc_attr));

    PyObject* pyVencRcAttr = PyDict_GetItemString(pyDict, "rc_attr");
    CHECK_BOOL(GetVencRcAttrFromPydict(pyVencRcAttr, attr.rc_attr));

    PyObject* pyVencGopAttr = PyDict_GetItemString(pyDict, "gop_attr");
    CHECK_BOOL(GetVencGopAttrFromPydict(pyVencGopAttr, attr.gop_attr));
    return true;
}

PyObject* WrapHiMpiVencCreateChn(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pDict = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pDict), "acl.himpi.venc_create_chn args parse failed!");

    hi_venc_chn_attr attr{};
    CHECK_NULL(GetVencChnAttrFromPydict(pDict, attr));

    hi_s32 ret = hi_mpi_venc_create_chn(chn, &attr);
    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiVencDestroyChn(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.venc_destroy_chn args parse failed!");

    hi_s32 ret = hi_mpi_venc_destroy_chn(chn);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromH264Attr(hi_venc_h264_attr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "rcn_ref_share_buf_en", Py_BuildValue("i", attr.rcn_ref_share_buf_en)));
    CHECK_NULL(SetItemToDict(pyDict, "frame_buf_ratio", Py_BuildValue("I", attr.frame_buf_ratio)));

    return pyDict;
}

static PyObject* GetPydictFromH265Attr(hi_venc_h265_attr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "rcn_ref_share_buf_en", Py_BuildValue("i", attr.rcn_ref_share_buf_en)));
    CHECK_NULL(SetItemToDict(pyDict, "frame_buf_ratio", Py_BuildValue("I", attr.frame_buf_ratio)));

    return pyDict;
}

static PyObject* GetPydictFromVencAttr(hi_venc_attr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "type", Py_BuildValue("i", attr.type)));
    CHECK_NULL(SetItemToDict(pyDict, "max_pic_width", Py_BuildValue("I", attr.max_pic_width)));
    CHECK_NULL(SetItemToDict(pyDict, "max_pic_height", Py_BuildValue("I", attr.max_pic_height)));
    CHECK_NULL(SetItemToDict(pyDict, "buf_size", Py_BuildValue("I", attr.buf_size)));
    CHECK_NULL(SetItemToDict(pyDict, "profile", Py_BuildValue("I", attr.profile)));
    CHECK_NULL(SetItemToDict(pyDict, "is_by_frame", Py_BuildValue("i", attr.is_by_frame)));
    CHECK_NULL(SetItemToDict(pyDict, "pic_width", Py_BuildValue("I", attr.pic_width)));
    CHECK_NULL(SetItemToDict(pyDict, "pic_height", Py_BuildValue("I", attr.pic_height)));

    if (attr.type == HI_PT_H264) {
        CHECK_NULL(SetItemToDict(pyDict, "h264_attr", GetPydictFromH264Attr(attr.h264_attr)));
    } else if (attr.type == HI_PT_H265) {
        CHECK_NULL(SetItemToDict(pyDict, "h265_attr", GetPydictFromH265Attr(attr.h265_attr)));
    }
    return pyDict;
}

static PyObject* GetPydictFromH264Cbr(hi_venc_h264_cbr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "gop", Py_BuildValue("I", attr.gop)));
    CHECK_NULL(SetItemToDict(pyDict, "stats_time", Py_BuildValue("I", attr.stats_time)));
    CHECK_NULL(SetItemToDict(pyDict, "src_frame_rate", Py_BuildValue("I", attr.src_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "dst_frame_rate", Py_BuildValue("I", attr.dst_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "bit_rate", Py_BuildValue("I", attr.bit_rate)));

    return pyDict;
}

static PyObject* GetPydictFromH264Vbr(hi_venc_h264_vbr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "gop", Py_BuildValue("I", attr.gop)));
    CHECK_NULL(SetItemToDict(pyDict, "stats_time", Py_BuildValue("I", attr.stats_time)));
    CHECK_NULL(SetItemToDict(pyDict, "src_frame_rate", Py_BuildValue("I", attr.src_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "dst_frame_rate", Py_BuildValue("I", attr.dst_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "max_bit_rate", Py_BuildValue("I", attr.max_bit_rate)));

    return pyDict;
}

static PyObject* GetPydictFromH264AVbr(hi_venc_h264_avbr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "gop", Py_BuildValue("I", attr.gop)));
    CHECK_NULL(SetItemToDict(pyDict, "stats_time", Py_BuildValue("I", attr.stats_time)));
    CHECK_NULL(SetItemToDict(pyDict, "src_frame_rate", Py_BuildValue("I", attr.src_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "dst_frame_rate", Py_BuildValue("I", attr.dst_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "max_bit_rate", Py_BuildValue("I", attr.max_bit_rate)));

    return pyDict;
}

static PyObject* GetPydictFromH264QVbr(hi_venc_h264_qvbr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "gop", Py_BuildValue("I", attr.gop)));
    CHECK_NULL(SetItemToDict(pyDict, "stats_time", Py_BuildValue("I", attr.stats_time)));
    CHECK_NULL(SetItemToDict(pyDict, "src_frame_rate", Py_BuildValue("I", attr.src_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "dst_frame_rate", Py_BuildValue("I", attr.dst_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "target_bit_rate", Py_BuildValue("I", attr.target_bit_rate)));

    return pyDict;
}

static PyObject* GetPydictFromH264CVbr(hi_venc_h264_cvbr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "gop", Py_BuildValue("I", attr.gop)));
    CHECK_NULL(SetItemToDict(pyDict, "stats_time", Py_BuildValue("I", attr.stats_time)));
    CHECK_NULL(SetItemToDict(pyDict, "src_frame_rate", Py_BuildValue("I", attr.src_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "dst_frame_rate", Py_BuildValue("I", attr.dst_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "max_bit_rate", Py_BuildValue("I", attr.max_bit_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "short_term_stats_time", Py_BuildValue("I", attr.short_term_stats_time)));
    CHECK_NULL(SetItemToDict(pyDict, "long_term_stats_time", Py_BuildValue("I", attr.long_term_stats_time)));
    CHECK_NULL(SetItemToDict(pyDict, "long_term_max_bit_rate", Py_BuildValue("I", attr.long_term_max_bit_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "long_term_min_bit_rate", Py_BuildValue("I", attr.long_term_min_bit_rate)));

    return pyDict;
}

static PyObject* GetPydictFromH264Fixqp(hi_venc_h264_fixqp& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "gop", Py_BuildValue("I", attr.gop)));
    CHECK_NULL(SetItemToDict(pyDict, "src_frame_rate", Py_BuildValue("I", attr.src_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "dst_frame_rate", Py_BuildValue("I", attr.dst_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "i_qp", Py_BuildValue("I", attr.i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "p_qp", Py_BuildValue("I", attr.p_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "b_qp", Py_BuildValue("I", attr.b_qp)));

    return pyDict;
}

static PyObject* GetPydictFromH265Cbr(hi_venc_h265_cbr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "gop", Py_BuildValue("I", attr.gop)));
    CHECK_NULL(SetItemToDict(pyDict, "stats_time", Py_BuildValue("I", attr.stats_time)));
    CHECK_NULL(SetItemToDict(pyDict, "src_frame_rate", Py_BuildValue("I", attr.src_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "dst_frame_rate", Py_BuildValue("I", attr.dst_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "bit_rate", Py_BuildValue("I", attr.bit_rate)));

    return pyDict;
}

static PyObject* GetPydictFromH265Vbr(hi_venc_h265_vbr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "gop", Py_BuildValue("I", attr.gop)));
    CHECK_NULL(SetItemToDict(pyDict, "stats_time", Py_BuildValue("I", attr.stats_time)));
    CHECK_NULL(SetItemToDict(pyDict, "src_frame_rate", Py_BuildValue("I", attr.src_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "dst_frame_rate", Py_BuildValue("I", attr.dst_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "max_bit_rate", Py_BuildValue("I", attr.max_bit_rate)));

    return pyDict;
}

static PyObject* GetPydictFromH265AVbr(hi_venc_h265_avbr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "gop", Py_BuildValue("I", attr.gop)));
    CHECK_NULL(SetItemToDict(pyDict, "stats_time", Py_BuildValue("I", attr.stats_time)));
    CHECK_NULL(SetItemToDict(pyDict, "src_frame_rate", Py_BuildValue("I", attr.src_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "dst_frame_rate", Py_BuildValue("I", attr.dst_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "max_bit_rate", Py_BuildValue("I", attr.max_bit_rate)));

    return pyDict;
}

static PyObject* GetPydictFromH265QVbr(hi_venc_h265_qvbr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "gop", Py_BuildValue("I", attr.gop)));
    CHECK_NULL(SetItemToDict(pyDict, "stats_time", Py_BuildValue("I", attr.stats_time)));
    CHECK_NULL(SetItemToDict(pyDict, "src_frame_rate", Py_BuildValue("I", attr.src_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "dst_frame_rate", Py_BuildValue("I", attr.dst_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "target_bit_rate", Py_BuildValue("I", attr.target_bit_rate)));

    return pyDict;
}

static PyObject* GetPydictFromH265CVbr(hi_venc_h265_cvbr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "gop", Py_BuildValue("I", attr.gop)));
    CHECK_NULL(SetItemToDict(pyDict, "stats_time", Py_BuildValue("I", attr.stats_time)));
    CHECK_NULL(SetItemToDict(pyDict, "src_frame_rate", Py_BuildValue("I", attr.src_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "dst_frame_rate", Py_BuildValue("I", attr.dst_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "max_bit_rate", Py_BuildValue("I", attr.max_bit_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "short_term_stats_time", Py_BuildValue("I", attr.short_term_stats_time)));
    CHECK_NULL(SetItemToDict(pyDict, "long_term_stats_time", Py_BuildValue("I", attr.long_term_stats_time)));
    CHECK_NULL(SetItemToDict(pyDict, "long_term_max_bit_rate", Py_BuildValue("I", attr.long_term_max_bit_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "long_term_min_bit_rate", Py_BuildValue("I", attr.long_term_min_bit_rate)));

    return pyDict;
}

static PyObject* GetPydictFromH265Fixqp(hi_venc_h265_fixqp& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "gop", Py_BuildValue("I", attr.gop)));
    CHECK_NULL(SetItemToDict(pyDict, "src_frame_rate", Py_BuildValue("I", attr.src_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "dst_frame_rate", Py_BuildValue("I", attr.dst_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "i_qp", Py_BuildValue("I", attr.i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "p_qp", Py_BuildValue("I", attr.p_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "b_qp", Py_BuildValue("I", attr.b_qp)));

    return pyDict;
}

static PyObject* GetPydictFromRcAttr(hi_venc_rc_attr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "rc_mode", Py_BuildValue("i", attr.rc_mode)));
    if (attr.rc_mode == HI_VENC_RC_MODE_H264_CBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h264_cbr", GetPydictFromH264Cbr(attr.h264_cbr)));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H264_VBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h264_vbr", GetPydictFromH264Vbr(attr.h264_vbr)));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H264_AVBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h264_avbr", GetPydictFromH264AVbr(attr.h264_avbr)));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H264_QVBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h264_qvbr", GetPydictFromH264QVbr(attr.h264_qvbr)));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H264_CVBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h264_cvbr", GetPydictFromH264CVbr(attr.h264_cvbr)));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H264_FIXQP) {
        CHECK_NULL(SetItemToDict(pyDict, "h264_fixqp", GetPydictFromH264Fixqp(attr.h264_fixqp)));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H265_CBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h265_cbr", GetPydictFromH265Cbr(attr.h265_cbr)));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H265_VBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h265_vbr", GetPydictFromH265Vbr(attr.h265_vbr)));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H265_AVBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h265_avbr", GetPydictFromH265AVbr(attr.h265_avbr)));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H265_QVBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h265_qvbr", GetPydictFromH265QVbr(attr.h265_qvbr)));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H265_CVBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h265_cvbr", GetPydictFromH265CVbr(attr.h265_cvbr)));
    } else if (attr.rc_mode == HI_VENC_RC_MODE_H265_FIXQP) {
        CHECK_NULL(SetItemToDict(pyDict, "h265_fixqp", GetPydictFromH265Fixqp(attr.h265_fixqp)));
    }

    return pyDict;
}

static PyObject* GetPydictFromVencNormalP(hi_venc_gop_normal_p& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "ip_qp_delta", Py_BuildValue("i", attr.ip_qp_delta)));

    return pyDict;
}

static PyObject* GetPydictFromVencDualP(hi_venc_gop_dual_p& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "sp_interval", Py_BuildValue("I", attr.sp_interval)));
    CHECK_NULL(SetItemToDict(pyDict, "sp_qp_delta", Py_BuildValue("i", attr.sp_qp_delta)));
    CHECK_NULL(SetItemToDict(pyDict, "ip_qp_delta", Py_BuildValue("i", attr.ip_qp_delta)));

    return pyDict;
}

static PyObject* GetPydictFromVencSmartP(hi_venc_gop_smart_p& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "bg_interval", Py_BuildValue("I", attr.bg_interval)));
    CHECK_NULL(SetItemToDict(pyDict, "bg_qp_delta", Py_BuildValue("i", attr.bg_qp_delta)));
    CHECK_NULL(SetItemToDict(pyDict, "vi_qp_delta", Py_BuildValue("i", attr.vi_qp_delta)));

    return pyDict;
}

static PyObject* GetPydictFromGopAttr(hi_venc_gop_attr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "gop_mode", Py_BuildValue("i", attr.gop_mode)));
    CHECK_NULL(SetItemToDict(pyDict, "normal_p", GetPydictFromVencNormalP(attr.normal_p)));
    CHECK_NULL(SetItemToDict(pyDict, "dual_p", GetPydictFromVencDualP(attr.dual_p)));
    CHECK_NULL(SetItemToDict(pyDict, "smart_p", GetPydictFromVencSmartP(attr.smart_p)));
    return pyDict;
}

static PyObject* GetPydictFromVencChnAttr(hi_venc_chn_attr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "venc_attr", GetPydictFromVencAttr(attr.venc_attr)));
    CHECK_NULL(SetItemToDict(pyDict, "rc_attr", GetPydictFromRcAttr(attr.rc_attr)));
    CHECK_NULL(SetItemToDict(pyDict, "gop_attr", GetPydictFromGopAttr(attr.gop_attr)));

    return pyDict;
}

PyObject* WrapHiMpiVencGetChnAttr(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    hi_venc_chn_attr attr{};

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.venc_get_chn_attr args parse failed!");

    hi_s32 ret = hi_mpi_venc_get_chn_attr(chn, &attr);
    PyObject* pyDict = GetPydictFromVencChnAttr(attr);

    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyDict, ret);
    Py_XDECREF(pyDict);

    return obj;
}

PyObject* WrapHiMpiVencSetChnAttr(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pyDict = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyDict), "acl.himpi.venc_set_chn_attr args parse failed!");

    hi_venc_chn_attr attr{};
    CHECK_NULL(GetVencChnAttrFromPydict(pyDict, attr));

    hi_s32 ret = hi_mpi_venc_set_chn_attr(chn, &attr);
    return Py_BuildValue("I", ret);
}

static bool GetVencStartParamFromPydict(PyObject* pyDict, hi_venc_start_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_start_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "recv_pic_num", param.recv_pic_num));
    return true;
}

PyObject* WrapHiMpiVencStartChn(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pDict = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pDict), "acl.himpi.venc_start_chn args parse failed!");

    hi_venc_start_param recvParam{};
    CHECK_NULL(GetVencStartParamFromPydict(pDict, recvParam));

    hi_s32 ret = hi_mpi_venc_start_chn(chn, &recvParam);
    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiVencStopChn(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.venc_stop_chn args parse failed!");

    hi_s32 ret = hi_mpi_venc_stop_chn(chn);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromVencStreamInfo(hi_venc_stream_info& info)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "ref_type", Py_BuildValue("i", info.ref_type)));
    CHECK_NULL(SetItemToDict(pyDict, "pic_bytes", Py_BuildValue("I", info.pic_bytes)));
    CHECK_NULL(SetItemToDict(pyDict, "pic_cnt", Py_BuildValue("I", info.pic_cnt)));
    CHECK_NULL(SetItemToDict(pyDict, "start_qp", Py_BuildValue("I", info.start_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "mean_qp", Py_BuildValue("I", info.mean_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "is_p_skip", Py_BuildValue("i", info.is_p_skip)));
    CHECK_NULL(SetItemToDict(pyDict, "residual_bits", Py_BuildValue("I", info.residual_bits)));
    CHECK_NULL(SetItemToDict(pyDict, "head_bits", Py_BuildValue("I", info.head_bits)));
    CHECK_NULL(SetItemToDict(pyDict, "madi_val", Py_BuildValue("I", info.madi_val)));
    CHECK_NULL(SetItemToDict(pyDict, "madp_val", Py_BuildValue("I", info.madp_val)));
    CHECK_NULL(SetItemToDict(pyDict, "sse_sum", Py_BuildValue("K", info.sse_sum)));
    CHECK_NULL(SetItemToDict(pyDict, "sse_lcu_cnt", Py_BuildValue("I", info.sse_lcu_cnt)));
    CHECK_NULL(SetItemToDict(pyDict, "psnr_val", Py_BuildValue("d", info.psnr_val)));

    return pyDict;
}

static PyObject* GetPydictFromVencChnStatus(hi_venc_chn_status& status)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "left_pics", Py_BuildValue("I", status.left_pics)));
    CHECK_NULL(SetItemToDict(pyDict, "left_stream_bytes", Py_BuildValue("I", status.left_stream_bytes)));
    CHECK_NULL(SetItemToDict(pyDict, "left_stream_frames", Py_BuildValue("I", status.left_stream_frames)));
    CHECK_NULL(SetItemToDict(pyDict, "cur_packs", Py_BuildValue("I", status.cur_packs)));
    CHECK_NULL(SetItemToDict(pyDict, "left_recv_pics", Py_BuildValue("I", status.left_recv_pics)));
    CHECK_NULL(SetItemToDict(pyDict, "left_enc_pics", Py_BuildValue("I", status.left_enc_pics)));
    CHECK_NULL(SetItemToDict(pyDict, "is_jpeg_snap_end", Py_BuildValue("i", status.is_jpeg_snap_end)));
    CHECK_NULL(SetItemToDict(pyDict, "release_pic_pts", Py_BuildValue("K", status.release_pic_pts)));
    CHECK_NULL(SetItemToDict(pyDict, "stream_info", GetPydictFromVencStreamInfo(status.stream_info)));

    return pyDict;
}

PyObject* WrapHiMpiVencQueryStatus(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    hi_venc_chn_status status{};

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.venc_query_status args parse failed!");

    hi_s32 ret = hi_mpi_venc_query_status(chn, &status);
    PyObject* pyStatus = GetPydictFromVencChnStatus(status);
    CHECK_NULL(pyStatus != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyStatus, ret);
    Py_XDECREF(pyStatus);
    return obj;
}

static PyObject* GetPydictFromVencPack(hi_venc_pack& pack)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "phys_addr", Py_BuildValue("K", pack.phys_addr)));
    CHECK_NULL(SetItemToDict(pyDict, "input_addr", Py_BuildValue("K", pack.input_addr)));
    CHECK_NULL(SetItemToDict(pyDict, "addr", Py_BuildValue("k", pack.addr)));
    CHECK_NULL(SetItemToDict(pyDict, "len", Py_BuildValue("I", pack.len)));
    CHECK_NULL(SetItemToDict(pyDict, "pts", Py_BuildValue("K", pack.pts)));
    CHECK_NULL(SetItemToDict(pyDict, "is_frame_end", Py_BuildValue("i", pack.is_frame_end)));
    CHECK_NULL(SetItemToDict(pyDict, "offset", Py_BuildValue("I", pack.offset)));
    CHECK_NULL(SetItemToDict(pyDict, "data_num", Py_BuildValue("I", pack.data_num)));

    return pyDict;
}

static PyObject* GetPydictFromVencStream(hi_venc_stream& stream)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "pack_cnt", Py_BuildValue("I", stream.pack_cnt)));
    CHECK_NULL(SetItemToDict(pyDict, "seq", Py_BuildValue("I", stream.seq)));
    CHECK_NULL(SetItemToDict(
        pyDict, "pack",
        GetPyListFromStructArray(stream.pack, static_cast<size_t>(stream.pack_cnt), GetPydictFromVencPack)));
    return pyDict;
}

PyObject* WrapHiMpiVencGetStream(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pyStream = nullptr;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOi", &chn, &pyStream, &milliSec), "acl.himpi.venc_get_stream args parse failed!");

    hi_venc_stream stream{};
    // 对stream.pack指针进行堆内存分配以及初始化
    CHECK_NULL(GetValueFromPyDict(pyStream, "pack_cnt", stream.pack_cnt));
    const size_t len = stream.pack_cnt * sizeof(hi_venc_pack);
    stream.pack = (hi_venc_pack*)malloc(len);
    CHECK_NULL(stream.pack != nullptr, "hi_venc_stream malloc failed!");
    (void)memset_s(stream.pack, len, 0, len);

    hi_s32 ret = hi_mpi_venc_get_stream(chn, &stream, milliSec);
    if (ret == HI_SUCCESS) {
        PyObject* pyDict = GetPydictFromVencStream(stream);
        free(stream.pack);
        stream.pack = nullptr;
        CHECK_NULL(pyDict != nullptr, "GetPydictFromVencStream failed!");
        PyObject* obj = Py_BuildValue("OI", pyDict, ret);
        Py_XDECREF(pyDict);
        return obj;
    }

    free(stream.pack);
    stream.pack = nullptr;
    PyObject* obj = Py_BuildValue("OI", pyStream, ret);
    return obj;
}

static bool GetVencPackFromPydict(PyObject* pyDict, hi_venc_pack& pack)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_pack argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "addr", reinterpret_cast<void*&>(pack.addr)));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "phys_addr", reinterpret_cast<void*&>(pack.phys_addr)));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "input_addr", reinterpret_cast<void*&>(pack.input_addr)));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "len", pack.len));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "pts", pack.pts));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "is_frame_end", pack.is_frame_end));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "offset", pack.offset));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "data_num", pack.data_num));

    return true;
}

static bool GetVencStreamFromPydict(PyObject* pyDict, hi_venc_stream& stream)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_stream argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "seq", stream.seq));

    PyObject* pyPack = PyDict_GetItemString(pyDict, "pack");
    if (!pyPack) {
        return true;
    }

    for (hi_u32 i = 0; i < stream.pack_cnt; i++) {
        GetVencPackFromPydict(PyList_GetItem(pyPack, i), stream.pack[i]);
    }

    return true;
}

PyObject* WrapHiMpiVencReleaseStream(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pyStream = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyStream), "acl.himpi.venc_release_stream args parse failed!");

    hi_venc_stream stream{};
    // 对stream.pack指针进行堆内存分配以及初始化
    CHECK_NULL(GetValueFromPyDict(pyStream, "pack_cnt", stream.pack_cnt));
    const size_t len = stream.pack_cnt * sizeof(hi_venc_pack);
    stream.pack = (hi_venc_pack*)malloc(len);
    CHECK_NULL(stream.pack != nullptr, "hi_venc_stream malloc failed!");
    (void)memset_s(stream.pack, len, 0, len);

    if (!GetVencStreamFromPydict(pyStream, stream)) {
        free(stream.pack);
        stream.pack = nullptr;
        return nullptr;
    }

    hi_s32 ret = hi_mpi_venc_release_stream(chn, &stream);
    free(stream.pack);
    stream.pack = nullptr;
    return Py_BuildValue("I", ret);
}

static bool GetVedioFrameInfoFromPydict(PyObject* pyDict, hi_video_frame_info& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_video_frame_info argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "pool_id", info.pool_id));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "mod_id", info.mod_id));

    PyObject* pyVideoFrame = PyDict_GetItemString(pyDict, "v_frame");
    CHECK_BOOL(GetVideoFrameFromPydict(pyVideoFrame, info.v_frame));

    return true;
}

PyObject* WrapHiMpiVencSendFrame(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pyVideoFrameInfo = nullptr;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOi", &chn, &pyVideoFrameInfo, &milliSec),
        "acl.himpi.venc_send_frame args parse failed!");

    hi_video_frame_info frame{};
    CHECK_NULL(GetVedioFrameInfoFromPydict(pyVideoFrameInfo, frame));

    hi_s32 ret = hi_mpi_venc_send_frame(chn, &frame, milliSec);
    return Py_BuildValue("I", ret);
}

static bool GetUserRcInfoFromPydict(PyObject* pyDict, hi_user_rc_info& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_user_rc_info argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "qp_map_valid", info.qp_map_valid));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "skip_weight_valid", info.skip_weight_valid));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "blk_start_qp", info.blk_start_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "qp_map_phy_addr", info.qp_map_phy_addr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "skip_weight_phy_addr", info.skip_weight_phy_addr));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "frame_type", info.frame_type));

    return true;
}

static bool GetUserRoiMapFromPydict(PyObject* pyDict, hi_user_roi_map& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_user_roi_map argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "valid", info.valid));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "phy_addr", info.phy_addr));

    return true;
}

static bool GetUserFrameInfoFromPydict(PyObject* pyDict, hi_user_frame_info& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_user_frame_info argument is not dict");

    PyObject* pyVideoFrameInfo = PyDict_GetItemString(pyDict, "user_frame");
    CHECK_BOOL(GetVedioFrameInfoFromPydict(pyVideoFrameInfo, info.user_frame));

    PyObject* pyUserRcInfo = PyDict_GetItemString(pyDict, "user_rc_info");
    CHECK_BOOL(GetUserRcInfoFromPydict(pyUserRcInfo, info.user_rc_info));

    PyObject* pyUserRoiMap = PyDict_GetItemString(pyDict, "user_roi_map");
    CHECK_BOOL(GetUserRoiMapFromPydict(pyUserRoiMap, info.user_roi_map));

    return true;
}

PyObject* WrapHiMpiVencSendFrameEx(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pyVideoFrameInfo = nullptr;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOi", &chn, &pyVideoFrameInfo, &milliSec),
        "acl.himpi.venc_send_frame_ex args parse failed!");

    hi_user_frame_info frame{};
    CHECK_NULL(GetUserFrameInfoFromPydict(pyVideoFrameInfo, frame));

    hi_s32 ret = hi_mpi_venc_send_frame_ex(chn, &frame, milliSec);
    return Py_BuildValue("I", ret);
}

static bool GetVencVencModParamFromPydict(PyObject* pyDict, hi_venc_venc_mod_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_venc_mod_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "buf_cache", param.buf_cache));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "frame_buf_recycle", param.frame_buf_recycle));

    return true;
}

static bool GetVencJpegModParamFromPydict(PyObject* pyDict, hi_venc_jpeg_mod_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_jpeg_mod_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "one_stream_buf", param.one_stream_buf));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "mini_buf_mode", param.mini_buf_mode));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "clear_stream_buf", param.clear_stream_buf));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "dering_mode", param.dering_mode));

    return true;
}

static bool GetVencModParamFromPydict(PyObject* pyDict, hi_venc_mod_param& param)
{
    param.mod_type = HI_VENC_MOD_BUTT;
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_mod_param argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "mod_type", param.mod_type));
    if (param.mod_type == HI_VENC_MOD_VENC) {
        CHECK_BOOL(GetVencVencModParamFromPydict(PyDict_GetItemString(pyDict, "venc_mod_param"), param.venc_mod_param));
    } else if (param.mod_type == HI_VENC_MOD_H264) {
        CHECK_BOOL(GetVencH26ModParamFromPydict(PyDict_GetItemString(pyDict, "h264_mod_param"), param.h264_mod_param));
    } else if (param.mod_type == HI_VENC_MOD_H265) {
        CHECK_BOOL(GetVencH26ModParamFromPydict(PyDict_GetItemString(pyDict, "h265_mod_param"), param.h265_mod_param));
    } else if (param.mod_type == HI_VENC_MOD_JPEG) {
        CHECK_BOOL(GetVencJpegModParamFromPydict(PyDict_GetItemString(pyDict, "jpeg_mod_param"), param.jpeg_mod_param));
    }

    return true;
}

PyObject* WrapHiMpiVencSetModParam(PyObject* /* self */, PyObject* args)
{
    PyObject* pyParam = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "O", &pyParam), "acl.himpi.venc_set_mod_param args parse failed!");

    hi_venc_mod_param modParam{};
    CHECK_NULL(GetVencModParamFromPydict(pyParam, modParam));

    hi_s32 ret = hi_mpi_venc_set_mod_param(&modParam);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromVencModParam(hi_venc_mod_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "mod_type", Py_BuildValue("i", param.mod_type)));

    PyObject* pyUnion = PyDict_New();
    if (param.mod_type == HI_VENC_MOD_VENC) {
        CHECK_NULL(SetItemToDict(pyUnion, "buf_cache", Py_BuildValue("I", param.venc_mod_param.buf_cache)));
        CHECK_NULL(
            SetItemToDict(pyUnion, "frame_buf_recycle", Py_BuildValue("I", param.venc_mod_param.frame_buf_recycle)));
        CHECK_NULL(SetItemToDict(pyDict, "venc_mod_param", pyUnion));
    } else if (param.mod_type == HI_VENC_MOD_H264) {
        CHECK_NULL(SetItemToDict(pyUnion, "one_stream_buf", Py_BuildValue("I", param.h264_mod_param.one_stream_buf)));
        CHECK_NULL(SetItemToDict(pyUnion, "mini_buf_mode", Py_BuildValue("I", param.h264_mod_param.mini_buf_mode)));
        CHECK_NULL(SetItemToDict(pyUnion, "low_power_mode", Py_BuildValue("I", param.h264_mod_param.low_power_mode)));
        CHECK_NULL(SetItemToDict(pyUnion, "vb_src", Py_BuildValue("i", param.h264_mod_param.vb_src)));
        CHECK_NULL(SetItemToDict(pyUnion, "qp_hist_en", Py_BuildValue("i", param.h264_mod_param.qp_hist_en)));
        CHECK_NULL(
            SetItemToDict(pyUnion, "max_user_data_len", Py_BuildValue("I", param.h264_mod_param.max_user_data_len)));
        CHECK_NULL(SetItemToDict(pyDict, "h264_mod_param", pyUnion));
    } else if (param.mod_type == HI_VENC_MOD_H265) {
        CHECK_NULL(SetItemToDict(pyUnion, "one_stream_buf", Py_BuildValue("I", param.h265_mod_param.one_stream_buf)));
        CHECK_NULL(SetItemToDict(pyUnion, "mini_buf_mode", Py_BuildValue("I", param.h265_mod_param.mini_buf_mode)));
        CHECK_NULL(SetItemToDict(pyUnion, "low_power_mode", Py_BuildValue("I", param.h265_mod_param.low_power_mode)));
        CHECK_NULL(SetItemToDict(pyUnion, "vb_src", Py_BuildValue("i", param.h265_mod_param.vb_src)));
        CHECK_NULL(SetItemToDict(pyUnion, "qp_hist_en", Py_BuildValue("i", param.h265_mod_param.qp_hist_en)));
        CHECK_NULL(
            SetItemToDict(pyUnion, "max_user_data_len", Py_BuildValue("I", param.h265_mod_param.max_user_data_len)));
        CHECK_NULL(SetItemToDict(pyDict, "h265_mod_param", pyUnion));
    } else if (param.mod_type == HI_VENC_MOD_JPEG) {
        CHECK_NULL(SetItemToDict(pyUnion, "one_stream_buf", Py_BuildValue("I", param.jpeg_mod_param.one_stream_buf)));
        CHECK_NULL(SetItemToDict(pyUnion, "mini_buf_mode", Py_BuildValue("I", param.jpeg_mod_param.mini_buf_mode)));
        CHECK_NULL(
            SetItemToDict(pyUnion, "clear_stream_buf", Py_BuildValue("I", param.jpeg_mod_param.clear_stream_buf)));
        CHECK_NULL(SetItemToDict(pyUnion, "dering_mode", Py_BuildValue("I", param.jpeg_mod_param.dering_mode)));
        CHECK_NULL(SetItemToDict(pyDict, "jpeg_mod_param", pyUnion));
    }

    return pyDict;
}

PyObject* WrapHiMpiVencGetModParam(PyObject* /* self */, PyObject* args)
{
    PyObject* pyParam = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "O", &pyParam), "acl.himpi.venc_get_mod_param args parse failed!");

    hi_venc_mod_param modParam{};
    CHECK_NULL(GetVencModParamFromPydict(pyParam, modParam));

    hi_s32 ret = hi_mpi_venc_get_mod_param(&modParam);
    PyObject* pyDict = GetPydictFromVencModParam(modParam);
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyDict, ret);
    Py_XDECREF(pyDict);

    return obj;
}

PyObject* WrapHiMpiVencRequestIdr(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    hi_bool instant = HI_FALSE;

    CHECK_NULL(PyArg_ParseTuple(args, "ii", &chn, &instant), "acl.himpi.venc_request_idr args parse failed!");

    hi_s32 ret = hi_mpi_venc_request_idr(chn, instant);
    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiVencGetFd(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.venc_get_fd args parse failed!");

    hi_s32 ret = hi_mpi_venc_get_fd(chn);
    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiVencCloseFd(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.venc_close_fd args parse failed!");

    hi_s32 ret = hi_mpi_venc_close_fd(chn);
    return Py_BuildValue("I", ret);
}

static bool GetVencJpegParamInfoFromPydict(PyObject* pyDict, hi_venc_jpeg_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_jpeg_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "qfactor", param.qfactor));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "y_qt", param.y_qt, sizeof(param.y_qt) / sizeof(hi_u8)));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "cb_qt", param.cb_qt, sizeof(param.cb_qt) / sizeof(hi_u8)));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "cr_qt", param.cr_qt, sizeof(param.cr_qt) / sizeof(hi_u8)));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "mcu_per_ecs", param.mcu_per_ecs));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "ecs_output_en", param.ecs_output_en));

    return true;
}

PyObject* WrapHiMpiVencSetJpegParam(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pyParam = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyParam), "acl.himpi.venc_set_jpeg_param args parse failed!");

    hi_venc_jpeg_param jpegParam{};
    CHECK_NULL(GetVencJpegParamInfoFromPydict(pyParam, jpegParam));

    hi_s32 ret = hi_mpi_venc_set_jpeg_param(chn, &jpegParam);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromVencJpegParam(hi_venc_jpeg_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "qfactor", Py_BuildValue("I", param.qfactor)));
    int len = 64;
    CHECK_NULL(SetItemToDict(pyDict, "y_qt", GetPyListFromArray(param.y_qt, len)));
    CHECK_NULL(SetItemToDict(pyDict, "cb_qt", GetPyListFromArray(param.cb_qt, len)));
    CHECK_NULL(SetItemToDict(pyDict, "cr_qt", GetPyListFromArray(param.cr_qt, len)));
    CHECK_NULL(SetItemToDict(pyDict, "mcu_per_ecs", Py_BuildValue("I", param.mcu_per_ecs)));
    CHECK_NULL(SetItemToDict(pyDict, "ecs_output_en", Py_BuildValue("i", param.ecs_output_en)));

    return pyDict;
}

PyObject* WrapHiMpiVencGetJpegParam(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    hi_venc_jpeg_param jpegParam{};

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.venc_get_jpeg_param args parse failed!");

    hi_s32 ret = hi_mpi_venc_get_jpeg_param(chn, &jpegParam);
    PyObject* pyDict = GetPydictFromVencJpegParam(jpegParam);
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyDict, ret);
    Py_XDECREF(pyDict);

    return obj;
}

static bool GetVencChnParamInfoFromPydict(PyObject* pyDict, hi_venc_chn_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_chn_param argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "color_to_grey_en", param.color_to_grey_en));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "priority", param.priority));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_stream_cnt", param.max_stream_cnt));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "poll_wake_up_frame_cnt", param.poll_wake_up_frame_cnt));

    return true;
}

PyObject* WrapHiMpiVencSetChnParam(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pyParam = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyParam), "acl.himpi.venc_set_chn_param args parse failed!");

    hi_venc_chn_param chnParam{};
    CHECK_NULL(GetVencChnParamInfoFromPydict(pyParam, chnParam));

    hi_s32 ret = hi_mpi_venc_set_chn_param(chn, &chnParam);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromRect(hi_rect& data)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "x", Py_BuildValue("i", data.x)));
    CHECK_NULL(SetItemToDict(pyDict, "y", Py_BuildValue("i", data.y)));
    CHECK_NULL(SetItemToDict(pyDict, "width", Py_BuildValue("I", data.width)));
    CHECK_NULL(SetItemToDict(pyDict, "height", Py_BuildValue("I", data.height)));

    return pyDict;
}

static PyObject* GetPydictFromCropInfo(hi_crop_info& info)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "enable", Py_BuildValue("i", info.enable)));
    CHECK_NULL(SetItemToDict(pyDict, "rect", GetPydictFromRect(info.rect)));

    return pyDict;
}

static PyObject* GetPydictFromFrameRate(hi_frame_rate_ctrl& info)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "src_frame_rate", Py_BuildValue("i", info.src_frame_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "dst_frame_rate", Py_BuildValue("i", info.dst_frame_rate)));

    return pyDict;
}

static PyObject* GetPydictFromVencChnParam(hi_venc_chn_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "color_to_grey_en", Py_BuildValue("i", param.color_to_grey_en)));
    CHECK_NULL(SetItemToDict(pyDict, "priority", Py_BuildValue("I", param.priority)));
    CHECK_NULL(SetItemToDict(pyDict, "max_stream_cnt", Py_BuildValue("I", param.max_stream_cnt)));
    CHECK_NULL(SetItemToDict(pyDict, "poll_wake_up_frame_cnt", Py_BuildValue("I", param.poll_wake_up_frame_cnt)));
    CHECK_NULL(SetItemToDict(pyDict, "crop_info", GetPydictFromCropInfo(param.crop_info)));
    CHECK_NULL(SetItemToDict(pyDict, "frame_rate", GetPydictFromFrameRate(param.frame_rate)));

    return pyDict;
}

PyObject* WrapHiMpiVencGetChnParam(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    hi_venc_chn_param chnParam{};

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.venc_get_chn_param args parse failed!");

    hi_s32 ret = hi_mpi_venc_get_chn_param(chn, &chnParam);
    PyObject* pyDict = GetPydictFromVencChnParam(chnParam);
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyDict, ret);
    Py_XDECREF(pyDict);

    return obj;
}

PyObject* WrapHiMpiVencSetSceneMode(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    hi_venc_scene_mode sceneMode = HI_VENC_SCENE_0;

    CHECK_NULL(PyArg_ParseTuple(args, "ii", &chn, &sceneMode), "acl.himpi.venc_set_scene_mode args parse failed!");

    hi_s32 ret = hi_mpi_venc_set_scene_mode(chn, sceneMode);
    return Py_BuildValue("I", ret);
}

static bool GetVencSceneChgDetectFromPydict(PyObject* pyDict, hi_venc_scene_chg_detect& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_scene_chg_detect argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "detect_scene_chg_en", param.detect_scene_chg_en));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "adapt_insert_idr_frame_en", param.adapt_insert_idr_frame_en));

    return true;
}

static bool GetVencRcParamFromPydict(PyObject* pyDict, hi_venc_rc_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_rc_param argument is not dict");
    CHECK_BOOL(
        GetValueFromPyDict(pyDict, "threshold_i", param.threshold_i, sizeof(param.threshold_i) / sizeof(hi_u32)));
    CHECK_BOOL(
        GetValueFromPyDict(pyDict, "threshold_p", param.threshold_p, sizeof(param.threshold_p) / sizeof(hi_u32)));
    CHECK_BOOL(
        GetValueFromPyDict(pyDict, "threshold_b", param.threshold_b, sizeof(param.threshold_b) / sizeof(hi_u32)));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "direction", param.direction));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "row_qp_delta", param.row_qp_delta));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "first_frame_start_qp", param.first_frame_start_qp));

    PyObject* pyScene = PyDict_GetItemString(pyDict, "scene_chg_detect");
    CHECK_BOOL(GetVencSceneChgDetectFromPydict(pyScene, param.scene_chg_detect));

    CHECK_BOOL(GetVencH264CbrFromPydict(PyDict_GetItemString(pyDict, "h264_cbr_param"), param.h264_cbr_param));
    CHECK_BOOL(GetVencH264VbrFromPydict(PyDict_GetItemString(pyDict, "h264_vbr_param"), param.h264_vbr_param));
    CHECK_BOOL(GetVencH264AvbrFromPydict(PyDict_GetItemString(pyDict, "h264_avbr_param"), param.h264_avbr_param));
    CHECK_BOOL(GetVencH264QvbrFromPydict(PyDict_GetItemString(pyDict, "h264_qvbr_param"), param.h264_qvbr_param));
    CHECK_BOOL(GetVencH264CvbrFromPydict(PyDict_GetItemString(pyDict, "h264_cvbr_param"), param.h264_cvbr_param));
    CHECK_BOOL(GetVencH265CbrFromPydict(PyDict_GetItemString(pyDict, "h265_cbr_param"), param.h265_cbr_param));
    CHECK_BOOL(GetVencH265VbrFromPydict(PyDict_GetItemString(pyDict, "h265_vbr_param"), param.h265_vbr_param));
    CHECK_BOOL(GetVencH265AvbrFromPydict(PyDict_GetItemString(pyDict, "h265_avbr_param"), param.h265_avbr_param));
    CHECK_BOOL(GetVencH265QvbrFromPydict(PyDict_GetItemString(pyDict, "h265_qvbr_param"), param.h265_qvbr_param));
    CHECK_BOOL(GetVencH265CvbrFromPydict(PyDict_GetItemString(pyDict, "h265_cvbr_param"), param.h265_cvbr_param));
    CHECK_BOOL(GetVencMjpegCbrFromPydict(PyDict_GetItemString(pyDict, "mjpeg_cbr_param"), param.mjpeg_cbr_param));
    CHECK_BOOL(GetVencMjpegVbrFromPydict(PyDict_GetItemString(pyDict, "mjpeg_vbr_param"), param.mjpeg_vbr_param));

    return true;
}

PyObject* WrapHiMpiVencSetRcParam(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pyParam = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyParam), "acl.himpi.venc_set_rc_param args parse failed!");

    hi_venc_rc_param rcParam{};
    CHECK_NULL(GetVencRcParamFromPydict(pyParam, rcParam));

    hi_s32 ret = hi_mpi_venc_set_rc_param(chn, &rcParam);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromVencSceneChgDetect(hi_venc_scene_chg_detect& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "detect_scene_chg_en", Py_BuildValue("i", param.detect_scene_chg_en)));
    CHECK_NULL(SetItemToDict(pyDict, "adapt_insert_idr_frame_en", Py_BuildValue("i", param.adapt_insert_idr_frame_en)));

    return pyDict;
}

static PyObject* GetPydictFromVencRcParam(hi_venc_rc_param& param, hi_venc_rc_mode mode)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(
        SetItemToDict(pyDict, "threshold_i", GetPyListFromArray(param.threshold_i, HI_VENC_TEXTURE_THRESHOLD_SIZE)));
    CHECK_NULL(
        SetItemToDict(pyDict, "threshold_p", GetPyListFromArray(param.threshold_p, HI_VENC_TEXTURE_THRESHOLD_SIZE)));
    CHECK_NULL(
        SetItemToDict(pyDict, "threshold_b", GetPyListFromArray(param.threshold_b, HI_VENC_TEXTURE_THRESHOLD_SIZE)));
    CHECK_NULL(SetItemToDict(pyDict, "direction", Py_BuildValue("I", param.direction)));
    CHECK_NULL(SetItemToDict(pyDict, "row_qp_delta", Py_BuildValue("I", param.row_qp_delta)));
    CHECK_NULL(SetItemToDict(pyDict, "first_frame_start_qp", Py_BuildValue("i", param.first_frame_start_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "scene_chg_detect", GetPydictFromVencSceneChgDetect(param.scene_chg_detect)));

    if (mode == HI_VENC_RC_MODE_H264_CBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h264_cbr_param", GetPydictFromVencH264CbrParam(param.h264_cbr_param)));
    } else if (mode == HI_VENC_RC_MODE_H264_VBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h264_vbr_param", GetPydictFromVencH264VbrParam(param.h264_vbr_param)));
    } else if (mode == HI_VENC_RC_MODE_H264_AVBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h264_avbr_param", GetPydictFromVencH264AvbrParam(param.h264_avbr_param)));
    } else if (mode == HI_VENC_RC_MODE_H264_QVBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h264_qvbr_param", GetPydictFromVencH264QvbrParam(param.h264_qvbr_param)));
    } else if (mode == HI_VENC_RC_MODE_H264_CVBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h264_cvbr_param", GetPydictFromVencH264CvbrParam(param.h264_cvbr_param)));
    } else if (mode == HI_VENC_RC_MODE_H265_CBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h265_cbr_param", GetPydictFromVencH265CbrParam(param.h265_cbr_param)));
    } else if (mode == HI_VENC_RC_MODE_H265_VBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h265_vbr_param", GetPydictFromVencH265VbrParam(param.h265_vbr_param)));
    } else if (mode == HI_VENC_RC_MODE_H265_AVBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h265_avbr_param", GetPydictFromVencH265AvbrParam(param.h265_avbr_param)));
    } else if (mode == HI_VENC_RC_MODE_H265_QVBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h265_qvbr_param", GetPydictFromVencH265QvbrParam(param.h265_qvbr_param)));
    } else if (mode == HI_VENC_RC_MODE_H265_CVBR) {
        CHECK_NULL(SetItemToDict(pyDict, "h265_cvbr_param", GetPydictFromVencH265CvbrParam(param.h265_cvbr_param)));
    } else if (mode == HI_VENC_RC_MODE_MJPEG_CBR) {
        CHECK_NULL(SetItemToDict(pyDict, "mjpeg_cbr_param", GetPydictFromVencMjpegCbrParam(param.mjpeg_cbr_param)));
    } else if (mode == HI_VENC_RC_MODE_MJPEG_VBR) {
        CHECK_NULL(SetItemToDict(pyDict, "mjpeg_vbr_param", GetPydictFromVencMjpegVbrParam(param.mjpeg_vbr_param)));
    }

    return pyDict;
}

PyObject* WrapHiMpiVencGetRcParam(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    hi_venc_rc_mode rcMode = HI_VENC_RC_MODE_H264_CBR;
    hi_venc_rc_param rcParam{};

    CHECK_NULL(PyArg_ParseTuple(args, "ii", &chn, &rcMode), "acl.himpi.venc_get_rc_param args parse failed!");

    hi_s32 ret = hi_mpi_venc_get_rc_param(chn, &rcParam);
    PyObject* pyDict = GetPydictFromVencRcParam(rcParam, rcMode);
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyDict, ret);
    Py_XDECREF(pyDict);

    return obj;
}

static bool GetVencHuffmanDcTableFromPydict(PyObject* pyDict, hi_venc_huffman_dc_table& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_huffman_dc_table argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "dc_bits", param.dc_bits, sizeof(param.dc_bits) / sizeof(hi_u8)));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "dc_value", param.dc_value, sizeof(param.dc_value) / sizeof(hi_u8)));

    return true;
}

static bool GetVencHuffmanAcTableFromPydict(PyObject* pyDict, hi_venc_huffman_ac_table& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_huffman_ac_table argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "ac_bits", param.ac_bits, sizeof(param.ac_bits) / sizeof(hi_u8)));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "ac_value", param.ac_value, sizeof(param.ac_value) / sizeof(hi_u8)));

    return true;
}

static bool GetVencJpegHuffmanParamFromPydict(PyObject* pyDict, hi_venc_jpeg_huffman_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_jpeg_huffman_param argument is not dict");
    CHECK_BOOL(MemsetStructArgu(param));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "reserved", param.reserved, sizeof(param.reserved) / sizeof(hi_u32)));

    PyObject* pyDcTables = PyDict_GetItemString(pyDict, "dc_tables");
    int len = static_cast<int>(PyList_Size(pyDcTables));
    for (int i = 0; i < len; i++) {
        CHECK_BOOL(GetVencHuffmanDcTableFromPydict(PyList_GetItem(pyDcTables, i), param.dc_tables[i]));
    }

    PyObject* pyAcTables = PyDict_GetItemString(pyDict, "ac_tables");
    len = static_cast<int>(PyList_Size(pyAcTables));
    for (int i = 0; i < len; i++) {
        CHECK_BOOL(GetVencHuffmanAcTableFromPydict(PyList_GetItem(pyAcTables, i), param.ac_tables[i]));
    }

    return true;
}

PyObject* WrapHiMpiVencSetJpegHuffmanParam(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pyParam = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iO", &chn, &pyParam), "acl.himpi.venc_set_jpeg_huffman_param args parse failed!");

    hi_venc_jpeg_huffman_param jpegHuffmanParam{};
    CHECK_NULL(GetVencJpegHuffmanParamFromPydict(pyParam, jpegHuffmanParam));

    hi_s32 ret = hi_mpi_venc_set_jpeg_huffman_param(chn, &jpegHuffmanParam);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromVencHuffmanDcTable(hi_venc_huffman_dc_table& param)
{
    PyObject* pyDict = PyDict_New();
    int bitLen = 16;
    int valueLen = 12;
    CHECK_NULL(SetItemToDict(pyDict, "dc_bits", GetPyListFromArray(param.dc_bits, bitLen)));
    CHECK_NULL(SetItemToDict(pyDict, "dc_value", GetPyListFromArray(param.dc_value, valueLen)));

    return pyDict;
}

static PyObject* GetPydictFromVencHuffmanAcTable(hi_venc_huffman_ac_table& param)
{
    PyObject* pyDict = PyDict_New();
    int bitLen = 16;
    int valueLen = 162;
    CHECK_NULL(SetItemToDict(pyDict, "ac_bits", GetPyListFromArray(param.ac_bits, bitLen)));
    CHECK_NULL(SetItemToDict(pyDict, "ac_value", GetPyListFromArray(param.ac_value, valueLen)));

    return pyDict;
}

static PyObject* GetPydictFromVencJepgHuffmanParam(hi_venc_jpeg_huffman_param& param)
{
    PyObject* pyDict = PyDict_New();
    size_t tablesLen = 3;
    CHECK_NULL(SetItemToDict(
        pyDict, "dc_tables", GetPyListFromStructArray(param.dc_tables, tablesLen, GetPydictFromVencHuffmanDcTable)));
    CHECK_NULL(SetItemToDict(
        pyDict, "ac_tables", GetPyListFromStructArray(param.ac_tables, tablesLen, GetPydictFromVencHuffmanAcTable)));
    int reserveLen = 2;
    CHECK_NULL(SetItemToDict(pyDict, "reserved", GetPyListFromArray(param.reserved, reserveLen)));

    return pyDict;
}

PyObject* WrapHiMpiVencGetJpegHuffmanParam(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.venc_get_jpeg_huffman_param args parse failed!");

    hi_venc_jpeg_huffman_param jpegHuffmanParam{};
    hi_s32 ret = hi_mpi_venc_get_jpeg_huffman_param(chn, &jpegHuffmanParam);

    PyObject* pyDict = GetPydictFromVencJepgHuffmanParam(jpegHuffmanParam);
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyDict, ret);
    Py_XDECREF(pyDict);
    return obj;
}

PyObject* WrapHiMpiVencCompactJpegTables(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    hi_u32 tableType = 0;
    hi_bool enable = HI_FALSE;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iIi", &chn, &tableType, &enable),
        "acl.himpi.venc_compact_jpeg_tables args parse failed!");

    hi_s32 ret = hi_mpi_venc_compact_jpeg_tables(chn, tableType, enable);
    return Py_BuildValue("I", ret);
}

namespace {
bool GetVencH264CbrFromPydict(PyObject* pyDict, hi_venc_h264_cbr_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_h264_cbr_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_proportion", param.max_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_proportion", param.min_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_qp", param.max_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_qp", param.min_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_qp", param.max_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_qp", param.min_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_reencode_times", param.max_reencode_times));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "qpmap_en", param.qpmap_en));

    return true;
}

bool GetVencH264VbrFromPydict(PyObject* pyDict, hi_venc_h264_vbr_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_h264_vbr_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "chg_pos", param.chg_pos));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_proportion", param.max_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_proportion", param.min_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_reencode_times", param.max_reencode_times));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "qpmap_en", param.qpmap_en));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_qp", param.max_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_qp", param.min_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_qp", param.max_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_qp", param.min_i_qp));

    return true;
}

bool GetVencH264AvbrFromPydict(PyObject* pyDict, hi_venc_h264_avbr_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_h264_avbr_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "chg_pos", param.chg_pos));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_proportion", param.max_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_proportion", param.min_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_reencode_times", param.max_reencode_times));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "qpmap_en", param.qpmap_en));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_still_percent", param.min_still_percent));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_still_qp", param.max_still_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_still_psnr", param.min_still_psnr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_qp", param.max_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_qp", param.min_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_qp", param.max_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_qp", param.min_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_qp_delta", param.min_qp_delta));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "motion_sensitivity", param.motion_sensitivity));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "save_bitrate_en", param.save_bitrate_en));

    return true;
}

bool GetVencH264QvbrFromPydict(PyObject* pyDict, hi_venc_h264_qvbr_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_h264_qvbr_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_proportion", param.max_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_proportion", param.min_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_reencode_times", param.max_reencode_times));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "qpmap_en", param.qpmap_en));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_qp", param.max_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_qp", param.min_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_qp", param.max_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_qp", param.min_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_bit_percent", param.max_bit_percent));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_bit_percent", param.min_bit_percent));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_psnr_fluctuate", param.max_psnr_fluctuate));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_psnr_fluctuate", param.min_psnr_fluctuate));

    return true;
}

bool GetVencH264CvbrFromPydict(PyObject* pyDict, hi_venc_h264_cvbr_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_h264_cvbr_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_proportion", param.max_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_proportion", param.min_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_reencode_times", param.max_reencode_times));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "qpmap_en", param.qpmap_en));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_qp", param.max_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_qp", param.min_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_qp", param.max_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_qp", param.min_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_qp_delta", param.max_qp_delta));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_qp_delta", param.min_qp_delta));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "extra_bit_percent", param.extra_bit_percent));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "long_term_stats_time_unit", param.long_term_stats_time_unit));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "save_bitrate_en", param.save_bitrate_en));

    return true;
}

bool GetVencH265CbrFromPydict(PyObject* pyDict, hi_venc_h265_cbr_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_h265_cbr_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_proportion", param.max_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_proportion", param.min_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_qp", param.max_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_qp", param.min_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_qp", param.max_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_qp", param.min_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_reencode_times", param.max_reencode_times));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "qpmap_en", param.qpmap_en));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "qpmap_mode", param.qpmap_mode));

    return true;
}

bool GetVencH265VbrFromPydict(PyObject* pyDict, hi_venc_h265_vbr_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_h265_vbr_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "chg_pos", param.chg_pos));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_proportion", param.max_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_proportion", param.min_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_reencode_times", param.max_reencode_times));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_qp", param.max_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_qp", param.min_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_qp", param.max_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_qp", param.min_i_qp));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "qpmap_en", param.qpmap_en));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "qpmap_mode", param.qpmap_mode));

    return true;
}

bool GetVencH265AvbrFromPydict(PyObject* pyDict, hi_venc_h265_avbr_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_h265_avbr_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "chg_pos", param.chg_pos));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_proportion", param.max_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_proportion", param.min_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_reencode_times", param.max_reencode_times));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_still_percent", param.min_still_percent));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_still_qp", param.max_still_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_still_psnr", param.min_still_psnr));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_qp", param.max_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_qp", param.min_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_qp", param.max_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_qp", param.min_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_qp_delta", param.min_qp_delta));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "motion_sensitivity", param.motion_sensitivity));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "qpmap_en", param.qpmap_en));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "qpmap_mode", param.qpmap_mode));

    return true;
}

bool GetVencH265QvbrFromPydict(PyObject* pyDict, hi_venc_h265_qvbr_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_h265_qvbr_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_proportion", param.max_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_proportion", param.min_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_reencode_times", param.max_reencode_times));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "qpmap_en", param.qpmap_en));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "qpmap_mode", param.qpmap_mode));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_qp", param.max_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_qp", param.min_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_qp", param.max_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_qp", param.min_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_bit_percent", param.max_bit_percent));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_bit_percent", param.min_bit_percent));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_psnr_fluctuate", param.max_psnr_fluctuate));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_psnr_fluctuate", param.min_psnr_fluctuate));

    return true;
}

bool GetVencH265CvbrFromPydict(PyObject* pyDict, hi_venc_h265_cvbr_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_h265_cvbr_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_proportion", param.max_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_proportion", param.min_i_proportion));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_reencode_times", param.max_reencode_times));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "qpmap_en", param.qpmap_en));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "qpmap_mode", param.qpmap_mode));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_qp", param.max_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_qp", param.min_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_i_qp", param.max_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_i_qp", param.min_i_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_qp_delta", param.max_qp_delta));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_qp_delta", param.min_qp_delta));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "extra_bit_percent", param.extra_bit_percent));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "long_term_stats_time_unit", param.long_term_stats_time_unit));

    return true;
}

bool GetVencMjpegCbrFromPydict(PyObject* pyDict, hi_venc_mjpeg_cbr_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_mjpeg_cbr_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_qfactor", param.max_qfactor));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_qfactor", param.min_qfactor));

    return true;
}

bool GetVencMjpegVbrFromPydict(PyObject* pyDict, hi_venc_mjpeg_vbr_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_mjpeg_vbr_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "chg_pos", param.chg_pos));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_qfactor", param.max_qfactor));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "min_qfactor", param.min_qfactor));

    return true;
}

PyObject* GetPydictFromVencH264CbrParam(hi_venc_h264_cbr_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "max_i_proportion", Py_BuildValue("I", param.max_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_proportion", Py_BuildValue("I", param.min_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "max_qp", Py_BuildValue("I", param.max_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_qp", Py_BuildValue("I", param.min_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "max_i_qp", Py_BuildValue("I", param.max_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_qp", Py_BuildValue("I", param.min_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "max_reencode_times", Py_BuildValue("i", param.max_reencode_times)));
    CHECK_NULL(SetItemToDict(pyDict, "qpmap_en", Py_BuildValue("i", param.qpmap_en)));

    return pyDict;
}

PyObject* GetPydictFromVencH264VbrParam(hi_venc_h264_vbr_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "chg_pos", Py_BuildValue("i", param.chg_pos)));
    CHECK_NULL(SetItemToDict(pyDict, "max_i_proportion", Py_BuildValue("I", param.max_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_proportion", Py_BuildValue("I", param.min_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "max_reencode_times", Py_BuildValue("i", param.max_reencode_times)));
    CHECK_NULL(SetItemToDict(pyDict, "qpmap_en", Py_BuildValue("i", param.qpmap_en)));
    CHECK_NULL(SetItemToDict(pyDict, "max_qp", Py_BuildValue("I", param.max_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_qp", Py_BuildValue("I", param.min_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "max_i_qp", Py_BuildValue("I", param.max_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_qp", Py_BuildValue("I", param.min_i_qp)));

    return pyDict;
}

PyObject* GetPydictFromVencH264AvbrParam(hi_venc_h264_avbr_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "chg_pos", Py_BuildValue("i", param.chg_pos)));
    CHECK_NULL(SetItemToDict(pyDict, "max_i_proportion", Py_BuildValue("I", param.max_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_proportion", Py_BuildValue("I", param.min_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "max_reencode_times", Py_BuildValue("i", param.max_reencode_times)));
    CHECK_NULL(SetItemToDict(pyDict, "qpmap_en", Py_BuildValue("i", param.qpmap_en)));
    CHECK_NULL(SetItemToDict(pyDict, "min_still_percent", Py_BuildValue("i", param.min_still_percent)));
    CHECK_NULL(SetItemToDict(pyDict, "max_still_qp", Py_BuildValue("I", param.max_still_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_still_psnr", Py_BuildValue("I", param.min_still_psnr)));
    CHECK_NULL(SetItemToDict(pyDict, "max_qp", Py_BuildValue("I", param.max_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_qp", Py_BuildValue("I", param.min_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "max_i_qp", Py_BuildValue("I", param.max_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_qp", Py_BuildValue("I", param.min_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_qp_delta", Py_BuildValue("I", param.min_qp_delta)));
    CHECK_NULL(SetItemToDict(pyDict, "motion_sensitivity", Py_BuildValue("I", param.motion_sensitivity)));
    CHECK_NULL(SetItemToDict(pyDict, "save_bitrate_en", Py_BuildValue("i", param.save_bitrate_en)));

    return pyDict;
}

PyObject* GetPydictFromVencH264QvbrParam(hi_venc_h264_qvbr_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "max_i_proportion", Py_BuildValue("I", param.max_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_proportion", Py_BuildValue("I", param.min_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "max_reencode_times", Py_BuildValue("i", param.max_reencode_times)));
    CHECK_NULL(SetItemToDict(pyDict, "qpmap_en", Py_BuildValue("i", param.qpmap_en)));
    CHECK_NULL(SetItemToDict(pyDict, "max_qp", Py_BuildValue("I", param.max_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_qp", Py_BuildValue("I", param.min_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "max_i_qp", Py_BuildValue("I", param.max_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_qp", Py_BuildValue("I", param.min_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "max_bit_percent", Py_BuildValue("i", param.max_bit_percent)));
    CHECK_NULL(SetItemToDict(pyDict, "min_bit_percent", Py_BuildValue("i", param.min_bit_percent)));
    CHECK_NULL(SetItemToDict(pyDict, "max_psnr_fluctuate", Py_BuildValue("i", param.max_psnr_fluctuate)));
    CHECK_NULL(SetItemToDict(pyDict, "min_psnr_fluctuate", Py_BuildValue("i", param.min_psnr_fluctuate)));

    return pyDict;
}

PyObject* GetPydictFromVencH264CvbrParam(hi_venc_h264_cvbr_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "max_i_proportion", Py_BuildValue("I", param.max_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_proportion", Py_BuildValue("I", param.min_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "max_reencode_times", Py_BuildValue("i", param.max_reencode_times)));
    CHECK_NULL(SetItemToDict(pyDict, "qpmap_en", Py_BuildValue("i", param.qpmap_en)));
    CHECK_NULL(SetItemToDict(pyDict, "max_qp", Py_BuildValue("I", param.max_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_qp", Py_BuildValue("I", param.min_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "max_i_qp", Py_BuildValue("I", param.max_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_qp", Py_BuildValue("I", param.min_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_qp_delta", Py_BuildValue("I", param.min_qp_delta)));
    CHECK_NULL(SetItemToDict(pyDict, "max_qp_delta", Py_BuildValue("I", param.max_qp_delta)));
    CHECK_NULL(SetItemToDict(pyDict, "extra_bit_percent", Py_BuildValue("I", param.extra_bit_percent)));
    CHECK_NULL(SetItemToDict(pyDict, "long_term_stats_time_unit", Py_BuildValue("I", param.long_term_stats_time_unit)));
    CHECK_NULL(SetItemToDict(pyDict, "save_bitrate_en", Py_BuildValue("i", param.save_bitrate_en)));

    return pyDict;
}

PyObject* GetPydictFromVencH265CbrParam(hi_venc_h265_cbr_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "max_i_proportion", Py_BuildValue("I", param.max_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_proportion", Py_BuildValue("I", param.min_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "max_qp", Py_BuildValue("I", param.max_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_qp", Py_BuildValue("I", param.min_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "max_i_qp", Py_BuildValue("I", param.max_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_qp", Py_BuildValue("I", param.min_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "max_reencode_times", Py_BuildValue("i", param.max_reencode_times)));
    CHECK_NULL(SetItemToDict(pyDict, "qpmap_en", Py_BuildValue("i", param.qpmap_en)));
    CHECK_NULL(SetItemToDict(pyDict, "qpmap_mode", Py_BuildValue("i", param.qpmap_mode)));

    return pyDict;
}

PyObject* GetPydictFromVencH265VbrParam(hi_venc_h265_vbr_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "chg_pos", Py_BuildValue("i", param.chg_pos)));
    CHECK_NULL(SetItemToDict(pyDict, "max_i_proportion", Py_BuildValue("I", param.max_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_proportion", Py_BuildValue("I", param.min_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "max_reencode_times", Py_BuildValue("i", param.max_reencode_times)));
    CHECK_NULL(SetItemToDict(pyDict, "max_qp", Py_BuildValue("I", param.max_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_qp", Py_BuildValue("I", param.min_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "max_i_qp", Py_BuildValue("I", param.max_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_qp", Py_BuildValue("I", param.min_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "qpmap_en", Py_BuildValue("i", param.qpmap_en)));
    CHECK_NULL(SetItemToDict(pyDict, "qpmap_mode", Py_BuildValue("i", param.qpmap_mode)));

    return pyDict;
}

PyObject* GetPydictFromVencH265AvbrParam(hi_venc_h265_avbr_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "chg_pos", Py_BuildValue("i", param.chg_pos)));
    CHECK_NULL(SetItemToDict(pyDict, "max_i_proportion", Py_BuildValue("I", param.max_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_proportion", Py_BuildValue("I", param.min_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "max_reencode_times", Py_BuildValue("i", param.max_reencode_times)));
    CHECK_NULL(SetItemToDict(pyDict, "min_still_percent", Py_BuildValue("i", param.min_still_percent)));
    CHECK_NULL(SetItemToDict(pyDict, "max_still_qp", Py_BuildValue("I", param.max_still_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_still_psnr", Py_BuildValue("I", param.min_still_psnr)));
    CHECK_NULL(SetItemToDict(pyDict, "max_qp", Py_BuildValue("I", param.max_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_qp", Py_BuildValue("I", param.min_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "max_i_qp", Py_BuildValue("I", param.max_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_qp", Py_BuildValue("I", param.min_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_qp_delta", Py_BuildValue("I", param.min_qp_delta)));
    CHECK_NULL(SetItemToDict(pyDict, "motion_sensitivity", Py_BuildValue("I", param.motion_sensitivity)));
    CHECK_NULL(SetItemToDict(pyDict, "qpmap_en", Py_BuildValue("i", param.qpmap_en)));
    CHECK_NULL(SetItemToDict(pyDict, "qpmap_mode", Py_BuildValue("i", param.qpmap_mode)));

    return pyDict;
}

PyObject* GetPydictFromVencH265QvbrParam(hi_venc_h265_qvbr_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "max_i_proportion", Py_BuildValue("I", param.max_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_proportion", Py_BuildValue("I", param.min_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "max_reencode_times", Py_BuildValue("i", param.max_reencode_times)));
    CHECK_NULL(SetItemToDict(pyDict, "qpmap_en", Py_BuildValue("i", param.qpmap_en)));
    CHECK_NULL(SetItemToDict(pyDict, "qpmap_mode", Py_BuildValue("i", param.qpmap_mode)));
    CHECK_NULL(SetItemToDict(pyDict, "max_qp", Py_BuildValue("I", param.max_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_qp", Py_BuildValue("I", param.min_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "max_i_qp", Py_BuildValue("I", param.max_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_qp", Py_BuildValue("I", param.min_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "max_bit_percent", Py_BuildValue("i", param.max_bit_percent)));
    CHECK_NULL(SetItemToDict(pyDict, "min_bit_percent", Py_BuildValue("i", param.min_bit_percent)));
    CHECK_NULL(SetItemToDict(pyDict, "max_psnr_fluctuate", Py_BuildValue("i", param.max_psnr_fluctuate)));
    CHECK_NULL(SetItemToDict(pyDict, "min_psnr_fluctuate", Py_BuildValue("i", param.min_psnr_fluctuate)));

    return pyDict;
}

PyObject* GetPydictFromVencH265CvbrParam(hi_venc_h265_cvbr_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "max_i_proportion", Py_BuildValue("I", param.max_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_proportion", Py_BuildValue("I", param.min_i_proportion)));
    CHECK_NULL(SetItemToDict(pyDict, "max_reencode_times", Py_BuildValue("i", param.max_reencode_times)));
    CHECK_NULL(SetItemToDict(pyDict, "qpmap_en", Py_BuildValue("i", param.qpmap_en)));
    CHECK_NULL(SetItemToDict(pyDict, "qpmap_mode", Py_BuildValue("i", param.qpmap_mode)));
    CHECK_NULL(SetItemToDict(pyDict, "max_qp", Py_BuildValue("I", param.max_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_qp", Py_BuildValue("I", param.min_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "max_i_qp", Py_BuildValue("I", param.max_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_i_qp", Py_BuildValue("I", param.min_i_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "min_qp_delta", Py_BuildValue("I", param.min_qp_delta)));
    CHECK_NULL(SetItemToDict(pyDict, "max_qp_delta", Py_BuildValue("I", param.max_qp_delta)));
    CHECK_NULL(SetItemToDict(pyDict, "extra_bit_percent", Py_BuildValue("I", param.extra_bit_percent)));
    CHECK_NULL(SetItemToDict(pyDict, "long_term_stats_time_unit", Py_BuildValue("I", param.long_term_stats_time_unit)));

    return pyDict;
}

PyObject* GetPydictFromVencMjpegCbrParam(hi_venc_mjpeg_cbr_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "max_qfactor", Py_BuildValue("I", param.max_qfactor)));
    CHECK_NULL(SetItemToDict(pyDict, "min_qfactor", Py_BuildValue("I", param.min_qfactor)));

    return pyDict;
}

PyObject* GetPydictFromVencMjpegVbrParam(hi_venc_mjpeg_vbr_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "chg_pos", Py_BuildValue("i", param.chg_pos)));
    CHECK_NULL(SetItemToDict(pyDict, "max_qfactor", Py_BuildValue("I", param.max_qfactor)));
    CHECK_NULL(SetItemToDict(pyDict, "min_qfactor", Py_BuildValue("I", param.min_qfactor)));

    return pyDict;
}
} // namespace

PyObject* WrapHiMpiVencSendJpegeFrame(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pyVideoFrameInfo = nullptr;
    PyObject* pyStream = nullptr;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOOI", &chn, &pyVideoFrameInfo, &pyStream, &milliSec),
        "acl.himpi.venc_send_jpege_frame args parse failed!");

    hi_video_frame_info frame{};
    CHECK_NULL(GetVedioFrameInfoFromPydict(pyVideoFrameInfo, frame));
    hi_img_stream stream{};
    CHECK_NULL(GetImgStreamFromPydict(pyStream, stream));
    hi_s32 ret = hi_mpi_venc_send_jpege_frame(chn, &frame, &stream, milliSec);

    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiVencGetJpegePredictedSize(PyObject* /* self */, PyObject* args)
{
    PyObject* pyVideoFrameInfo = nullptr;
    PyObject* pyParam = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "OO", &pyVideoFrameInfo, &pyParam),
        "acl.himpi.venc_get_jpege_predicted_size args parse failed!");

    hi_video_frame_info frame{};
    CHECK_NULL(GetVedioFrameInfoFromPydict(pyVideoFrameInfo, frame));
    hi_venc_jpeg_param jpegParam{};
    CHECK_NULL(GetVencJpegParamInfoFromPydict(pyParam, jpegParam));
    hi_u32 predictedSize = 0;
    hi_s32 ret = hi_mpi_venc_get_jpege_predicted_size(&frame, &jpegParam, &predictedSize);

    return Py_BuildValue("II", predictedSize, ret);
}

static PyObject* GetPydictFromVencCuPrediction(hi_venc_cu_prediction& data)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "pred_mode", Py_BuildValue("i", data.pred_mode)));
    CHECK_NULL(SetItemToDict(pyDict, "intra32_cost", Py_BuildValue("I", data.intra32_cost)));
    CHECK_NULL(SetItemToDict(pyDict, "intra16_cost", Py_BuildValue("I", data.intra16_cost)));
    CHECK_NULL(SetItemToDict(pyDict, "intra8_cost", Py_BuildValue("I", data.intra8_cost)));
    CHECK_NULL(SetItemToDict(pyDict, "intra4_cost", Py_BuildValue("I", data.intra4_cost)));
    CHECK_NULL(SetItemToDict(pyDict, "inter64_cost", Py_BuildValue("I", data.inter64_cost)));
    CHECK_NULL(SetItemToDict(pyDict, "inter32_cost", Py_BuildValue("I", data.inter32_cost)));
    CHECK_NULL(SetItemToDict(pyDict, "inter16_cost", Py_BuildValue("I", data.inter16_cost)));
    CHECK_NULL(SetItemToDict(pyDict, "inter8_cost", Py_BuildValue("I", data.inter8_cost)));

    return pyDict;
}

PyObject* WrapHiMpiVencGetCuPred(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    hi_venc_cu_prediction cuPred{};

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.venc_get_cu_pred args parse failed");

    hi_s32 ret = hi_mpi_venc_get_cu_pred(chn, &cuPred);
    PyObject* pyCuPred = GetPydictFromVencCuPrediction(cuPred);
    CHECK_NULL(pyCuPred != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyCuPred, ret);
    Py_XDECREF(pyCuPred);
    return obj;
}

static bool GetVencCuPredictionFromPydict(PyObject* pyDict, hi_venc_cu_prediction& data)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_cu_prediction argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "pred_mode", data.pred_mode));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "intra32_cost", data.intra32_cost));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "intra16_cost", data.intra16_cost));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "intra8_cost", data.intra8_cost));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "intra4_cost", data.intra4_cost));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "inter64_cost", data.inter64_cost));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "inter32_cost", data.inter32_cost));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "inter16_cost", data.inter16_cost));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "inter8_cost", data.inter8_cost));

    return true;
}

PyObject* WrapHiMpiVencSetCuPred(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pyCuPred = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyCuPred), "acl.himpi.venc_set_cu_pred args parse failed");

    hi_venc_cu_prediction cuPred{};
    CHECK_NULL(GetVencCuPredictionFromPydict(pyCuPred, cuPred));

    hi_s32 ret = hi_mpi_venc_set_cu_pred(chn, &cuPred);
    return Py_BuildValue("I", ret);
}

static bool GetVencIntraRefreshFromPydict(PyObject* pyDict, hi_venc_intra_refresh& data)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_intra_refresh argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "refresh_enable", data.refresh_enable));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "intra_refresh_mode", data.intra_refresh_mode));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "refresh_num", data.refresh_num));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "req_i_qp", data.req_i_qp));

    return true;
}

PyObject* WrapHiMpiVencGetSceneMode(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    hi_venc_scene_mode sceneMode = HI_VENC_SCENE_0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.venc_get_scene_mode args parse failed");

    hi_s32 ret = hi_mpi_venc_get_scene_mode(chn, &sceneMode);
    return Py_BuildValue("kI", sceneMode, ret);
}

static bool GetVencVuiBitstreamRestricFromPydict(PyObject* pyDict, hi_venc_vui_bitstream_restric& data)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_vui_bitstream_restric argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "bitstream_restriction_flag", data.bitstream_restriction_flag));

    return true;
}

static bool GetVencVuiVideoSignalFromPydict(PyObject* pyDict, hi_venc_vui_video_signal& data)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_vui_video_signal argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "video_signal_type_present_flag", data.video_signal_type_present_flag));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "video_format", data.video_format));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "video_full_range_flag", data.video_full_range_flag));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "colour_description_present_flag", data.colour_description_present_flag));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "colour_primaries", data.colour_primaries));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "transfer_characteristics", data.transfer_characteristics));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "matrix_coefficients", data.matrix_coefficients));

    return true;
}

static bool GetVencVuiH264TimeInfoFromPydict(PyObject* pyDict, hi_venc_vui_h264_time_info& data)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_vui_h264_time_info argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "timing_info_present_flag", data.timing_info_present_flag));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "fixed_frame_rate_flag", data.fixed_frame_rate_flag));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "num_units_in_tick", data.num_units_in_tick));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "time_scale", data.time_scale));

    return true;
}

static bool GetVencVuiAspectRatioFromPydict(PyObject* pyDict, hi_venc_vui_aspect_ratio& data)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_vui_aspect_ratio argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "aspect_ratio_info_present_flag", data.aspect_ratio_info_present_flag));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "aspect_ratio_idc", data.aspect_ratio_idc));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "overscan_info_present_flag", data.overscan_info_present_flag));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "overscan_appropriate_flag", data.overscan_appropriate_flag));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "sar_width", data.sar_width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "sar_height", data.sar_height));

    return true;
}

static bool GetVencH264VuiFromPydict(PyObject* pyDict, hi_venc_h264_vui& data)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_h264_vui argument is not dict");

    PyObject* pyVencVuiAspectRatio = PyDict_GetItemString(pyDict, "vui_aspect_ratio");
    CHECK_BOOL(GetVencVuiAspectRatioFromPydict(pyVencVuiAspectRatio, data.vui_aspect_ratio));

    PyObject* pyVencVuiH264TimeInfo = PyDict_GetItemString(pyDict, "vui_time_info");
    CHECK_BOOL(GetVencVuiH264TimeInfoFromPydict(pyVencVuiH264TimeInfo, data.vui_time_info));

    PyObject* pyVencVuiVideoSignal = PyDict_GetItemString(pyDict, "vui_video_signal");
    CHECK_BOOL(GetVencVuiVideoSignalFromPydict(pyVencVuiVideoSignal, data.vui_video_signal));

    PyObject* pyVencVuiBitstreamRestric = PyDict_GetItemString(pyDict, "vui_bitstream_restric");
    CHECK_BOOL(GetVencVuiBitstreamRestricFromPydict(pyVencVuiBitstreamRestric, data.vui_bitstream_restric));

    return true;
}

PyObject* WrapHiMpiVencSetH264Vui(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pyH264Vui = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyH264Vui), "acl.himpi.venc_set_h264_vui args parse failed");

    hi_venc_h264_vui h264Vui{};
    CHECK_NULL(GetVencH264VuiFromPydict(pyH264Vui, h264Vui));

    hi_s32 ret = hi_mpi_venc_set_h264_vui(chn, &h264Vui);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromVencVuiAspectRatio(hi_venc_vui_aspect_ratio& data)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(SetItemToDict(
        pyDict, "aspect_ratio_info_present_flag", Py_BuildValue("I", data.aspect_ratio_info_present_flag)));
    CHECK_NULL(SetItemToDict(pyDict, "aspect_ratio_idc", Py_BuildValue("I", data.aspect_ratio_idc)));
    CHECK_NULL(
        SetItemToDict(pyDict, "overscan_info_present_flag", Py_BuildValue("I", data.overscan_info_present_flag)));
    CHECK_NULL(SetItemToDict(pyDict, "overscan_appropriate_flag", Py_BuildValue("I", data.overscan_appropriate_flag)));
    CHECK_NULL(SetItemToDict(pyDict, "sar_width", Py_BuildValue("I", data.sar_width)));
    CHECK_NULL(SetItemToDict(pyDict, "sar_height", Py_BuildValue("I", data.sar_height)));

    return pyDict;
}

static PyObject* GetPydictFromVencVuiH264TimeInfo(hi_venc_vui_h264_time_info& data)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(SetItemToDict(pyDict, "timing_info_present_flag", Py_BuildValue("I", data.timing_info_present_flag)));
    CHECK_NULL(SetItemToDict(pyDict, "fixed_frame_rate_flag", Py_BuildValue("I", data.fixed_frame_rate_flag)));
    CHECK_NULL(SetItemToDict(pyDict, "num_units_in_tick", Py_BuildValue("I", data.num_units_in_tick)));
    CHECK_NULL(SetItemToDict(pyDict, "time_scale", Py_BuildValue("I", data.time_scale)));

    return pyDict;
}

static PyObject* GetPydictFromVencVuiVideoSignal(hi_venc_vui_video_signal& data)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(SetItemToDict(
        pyDict, "video_signal_type_present_flag", Py_BuildValue("I", data.video_signal_type_present_flag)));
    CHECK_NULL(SetItemToDict(pyDict, "video_format", Py_BuildValue("I", data.video_format)));
    CHECK_NULL(SetItemToDict(pyDict, "video_full_range_flag", Py_BuildValue("I", data.video_full_range_flag)));
    CHECK_NULL(SetItemToDict(
        pyDict, "colour_description_present_flag", Py_BuildValue("I", data.colour_description_present_flag)));
    CHECK_NULL(SetItemToDict(pyDict, "colour_primaries", Py_BuildValue("I", data.colour_primaries)));
    CHECK_NULL(SetItemToDict(pyDict, "transfer_characteristics", Py_BuildValue("I", data.transfer_characteristics)));
    CHECK_NULL(SetItemToDict(pyDict, "matrix_coefficients", Py_BuildValue("I", data.matrix_coefficients)));

    return pyDict;
}

static PyObject* GetPydictFromVencVuiBitstreamRestric(hi_venc_vui_bitstream_restric& data)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(
        SetItemToDict(pyDict, "bitstream_restriction_flag", Py_BuildValue("I", data.bitstream_restriction_flag)));

    return pyDict;
}

static PyObject* GetPydictFromVencH264Vui(hi_venc_h264_vui& data)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(SetItemToDict(pyDict, "vui_aspect_ratio", GetPydictFromVencVuiAspectRatio(data.vui_aspect_ratio)));
    CHECK_NULL(SetItemToDict(pyDict, "vui_time_info", GetPydictFromVencVuiH264TimeInfo(data.vui_time_info)));
    CHECK_NULL(SetItemToDict(pyDict, "vui_video_signal", GetPydictFromVencVuiVideoSignal(data.vui_video_signal)));
    CHECK_NULL(SetItemToDict(
        pyDict, "vui_bitstream_restric", GetPydictFromVencVuiBitstreamRestric(data.vui_bitstream_restric)));

    return pyDict;
}

PyObject* WrapHiMpiVencGetH264Vui(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.venc_get_h264_vui args parse failed");

    hi_venc_h264_vui h264Vui{};
    hi_s32 ret = hi_mpi_venc_get_h264_vui(chn, &h264Vui);
    PyObject* pyH264Vui = GetPydictFromVencH264Vui(h264Vui);
    CHECK_NULL(pyH264Vui != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyH264Vui, ret);
    Py_XDECREF(pyH264Vui);
    return obj;
}

static bool GetVencVuiH265TimeInfoFromPydict(PyObject* pyDict, hi_venc_vui_h265_time_info& data)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_vui_h265_time_info argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "timing_info_present_flag", data.timing_info_present_flag));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "num_units_in_tick", data.num_units_in_tick));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "time_scale", data.time_scale));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "num_ticks_poc_diff_one_minus1", data.num_ticks_poc_diff_one_minus1));

    return true;
}

static bool GetVencH265VuiFromPydict(PyObject* pyDict, hi_venc_h265_vui& data)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_h265_vui argument is not dict");

    PyObject* pyVencVuiAspectRatio = PyDict_GetItemString(pyDict, "vui_aspect_ratio");
    CHECK_BOOL(GetVencVuiAspectRatioFromPydict(pyVencVuiAspectRatio, data.vui_aspect_ratio));

    PyObject* pyVencVuiH265TimeInfo = PyDict_GetItemString(pyDict, "vui_time_info");
    CHECK_BOOL(GetVencVuiH265TimeInfoFromPydict(pyVencVuiH265TimeInfo, data.vui_time_info));

    PyObject* pyVencVuiVideoSignal = PyDict_GetItemString(pyDict, "vui_video_signal");
    CHECK_BOOL(GetVencVuiVideoSignalFromPydict(pyVencVuiVideoSignal, data.vui_video_signal));

    PyObject* pyVencVuiBitstreamRestric = PyDict_GetItemString(pyDict, "vui_bitstream_restric");
    CHECK_BOOL(GetVencVuiBitstreamRestricFromPydict(pyVencVuiBitstreamRestric, data.vui_bitstream_restric));

    return true;
}

PyObject* WrapHiMpiVencSetH265Vui(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pyH265Vui = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyH265Vui), "acl.himpi.venc_set_h265_vui args parse failed");

    hi_venc_h265_vui h265Vui{};
    CHECK_NULL(GetVencH265VuiFromPydict(pyH265Vui, h265Vui));

    hi_s32 ret = hi_mpi_venc_set_h265_vui(chn, &h265Vui);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromVencVuiH265TimeInfo(hi_venc_vui_h265_time_info& data)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(SetItemToDict(pyDict, "timing_info_present_flag", Py_BuildValue("I", data.timing_info_present_flag)));
    CHECK_NULL(SetItemToDict(pyDict, "num_units_in_tick", Py_BuildValue("I", data.num_units_in_tick)));
    CHECK_NULL(SetItemToDict(pyDict, "time_scale", Py_BuildValue("I", data.time_scale)));
    CHECK_NULL(
        SetItemToDict(pyDict, "num_ticks_poc_diff_one_minus1", Py_BuildValue("I", data.num_ticks_poc_diff_one_minus1)));

    return pyDict;
}

static PyObject* GetPydictFromVencH265Vui(hi_venc_h265_vui& data)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(SetItemToDict(pyDict, "vui_aspect_ratio", GetPydictFromVencVuiAspectRatio(data.vui_aspect_ratio)));
    CHECK_NULL(SetItemToDict(pyDict, "vui_time_info", GetPydictFromVencVuiH265TimeInfo(data.vui_time_info)));
    CHECK_NULL(SetItemToDict(pyDict, "vui_video_signal", GetPydictFromVencVuiVideoSignal(data.vui_video_signal)));
    CHECK_NULL(SetItemToDict(
        pyDict, "vui_bitstream_restric", GetPydictFromVencVuiBitstreamRestric(data.vui_bitstream_restric)));

    return pyDict;
}

PyObject* WrapHiMpiVencGetH265Vui(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.venc_get_h265_vui args parse failed");

    hi_venc_h265_vui h265Vui{};
    hi_s32 ret = hi_mpi_venc_get_h265_vui(chn, &h265Vui);
    PyObject* pyH265Vui = GetPydictFromVencH265Vui(h265Vui);
    CHECK_NULL(pyH265Vui != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyH265Vui, ret);
    Py_XDECREF(pyH265Vui);
    return obj;
}

PyObject* WrapHiMpiVencSetIntraRefresh(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pyIntraRefresh = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iO", &chn, &pyIntraRefresh), "acl.himpi.venc_set_intra_refresh args parse failed");

    hi_venc_intra_refresh intraRefresh{};
    CHECK_NULL(GetVencIntraRefreshFromPydict(pyIntraRefresh, intraRefresh));

    hi_s32 ret = hi_mpi_venc_set_intra_refresh(chn, &intraRefresh);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromVencIntraRefresh(hi_venc_intra_refresh& data)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(SetItemToDict(pyDict, "refresh_enable", Py_BuildValue("i", data.refresh_enable)));
    CHECK_NULL(SetItemToDict(pyDict, "intra_refresh_mode", Py_BuildValue("i", data.intra_refresh_mode)));
    CHECK_NULL(SetItemToDict(pyDict, "refresh_num", Py_BuildValue("I", data.refresh_num)));
    CHECK_NULL(SetItemToDict(pyDict, "req_i_qp", Py_BuildValue("I", data.req_i_qp)));

    return pyDict;
}

PyObject* WrapHiMpiVencGetIntraRefresh(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    hi_venc_intra_refresh intraRefresh{};

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.venc_get_intra_refresh args parse failed");

    hi_s32 ret = hi_mpi_venc_get_intra_refresh(chn, &intraRefresh);
    PyObject* pyIntraRefresh = GetPydictFromVencIntraRefresh(intraRefresh);
    CHECK_NULL(pyIntraRefresh != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyIntraRefresh, ret);
    Py_XDECREF(pyIntraRefresh);
    return obj;
}

static bool GetVencRefParamFromPydict(PyObject* pyDict, hi_venc_ref_param& data)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_ref_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "base", data.base));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "enhance", data.enhance));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "pred_en", data.pred_en));

    return true;
}

PyObject* WrapHiMpiVencSetRefParam(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pyRefParam = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyRefParam), "acl.himpi.venc_set_ref_param args parse failed");

    hi_venc_ref_param refParam{};
    CHECK_NULL(GetVencRefParamFromPydict(pyRefParam, refParam));

    hi_s32 ret = hi_mpi_venc_set_ref_param(chn, &refParam);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromVencRefParam(hi_venc_ref_param& data)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(SetItemToDict(pyDict, "base", Py_BuildValue("i", data.base)));
    CHECK_NULL(SetItemToDict(pyDict, "enhance", Py_BuildValue("i", data.enhance)));
    CHECK_NULL(SetItemToDict(pyDict, "pred_en", Py_BuildValue("I", data.pred_en)));

    return pyDict;
}

PyObject* WrapHiMpiVencGetRefParam(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.venc_get_ref_param args parse failed");

    hi_venc_ref_param refParam{};
    hi_s32 ret = hi_mpi_venc_get_ref_param(chn, &refParam);

    PyObject* pyRefParam = GetPydictFromVencRefParam(refParam);
    CHECK_NULL(pyRefParam != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyRefParam, ret);
    Py_XDECREF(pyRefParam);
    return obj;
}

static bool GetRectFromPydict(PyObject* pyDict, hi_rect& data)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_rect argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "x", data.x));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "y", data.y));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "width", data.width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "height", data.height));

    return true;
}

static bool GetVencRoiAttrFromPydict(PyObject* pyDict, hi_venc_roi_attr& data)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_roi_attr argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "idx", data.idx));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "enable", data.enable));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "is_abs_qp", data.is_abs_qp));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "qp", data.qp));

    PyObject* pyRect = PyDict_GetItemString(pyDict, "rect");
    CHECK_BOOL(GetRectFromPydict(pyRect, data.rect));

    return true;
}

PyObject* WrapHiMpiVencSetRoiAttr(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pyRoiAttr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyRoiAttr), "acl.himpi.venc_set_roi_attr args parse failed");

    hi_venc_roi_attr roiAttr{};
    CHECK_NULL(GetVencRoiAttrFromPydict(pyRoiAttr, roiAttr));

    hi_s32 ret = hi_mpi_venc_set_roi_attr(chn, &roiAttr);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromVencRoiAttr(hi_venc_roi_attr& data)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(SetItemToDict(pyDict, "idx", Py_BuildValue("i", data.idx)));
    CHECK_NULL(SetItemToDict(pyDict, "enable", Py_BuildValue("I", data.enable)));
    CHECK_NULL(SetItemToDict(pyDict, "is_abs_qp", Py_BuildValue("I", data.is_abs_qp)));
    CHECK_NULL(SetItemToDict(pyDict, "qp", Py_BuildValue("i", data.qp)));
    CHECK_NULL(SetItemToDict(pyDict, "rect", GetPydictFromRect(data.rect)));

    return pyDict;
}

PyObject* WrapHiMpiVencGetRoiAttr(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    hi_u32 idx = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "iI", &chn, &idx), "acl.himpi.venc_get_roi_attr args parse failed");

    hi_venc_roi_attr roiAttr{};
    hi_s32 ret = hi_mpi_venc_get_roi_attr(chn, idx, &roiAttr);

    PyObject* pyRoiAttr = GetPydictFromVencRoiAttr(roiAttr);
    CHECK_NULL(pyRoiAttr != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyRoiAttr, ret);
    Py_XDECREF(pyRoiAttr);
    return obj;
}

static bool GetVencSliceSplitFromPydict(PyObject* pyDict, hi_venc_slice_split& data)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_slice_split argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "split_enable", data.split_enable));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "split_mode", data.split_mode));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "split_size", data.split_size));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "slice_output_en", data.slice_output_en));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "reserved", data.reserved, sizeof(data.reserved) / sizeof(hi_u32)));
    return true;
}

PyObject* WrapHiMpiVencSetSliceSplit(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pySliceSplit = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pySliceSplit), "acl.himpi.venc_set_slice_split args parse failed");

    hi_venc_slice_split sliceSplit{};
    CHECK_NULL(GetVencSliceSplitFromPydict(pySliceSplit, sliceSplit));

    hi_s32 ret = hi_mpi_venc_set_slice_split(chn, &sliceSplit);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromVencSliceSplit(hi_venc_slice_split& data)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(SetItemToDict(pyDict, "split_enable", Py_BuildValue("I", data.split_enable)));
    CHECK_NULL(SetItemToDict(pyDict, "split_mode", Py_BuildValue("I", data.split_mode)));
    CHECK_NULL(SetItemToDict(pyDict, "split_size", Py_BuildValue("I", data.split_size)));
    CHECK_NULL(SetItemToDict(pyDict, "slice_output_en", Py_BuildValue("I", data.slice_output_en)));
    CHECK_NULL(
        SetItemToDict(pyDict, "reserved", GetPyListFromArray(data.reserved, sizeof(data.reserved) / sizeof(hi_u32))));

    return pyDict;
}

PyObject* WrapHiMpiVencGetSliceSplit(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.venc_get_slice_split args parse failed");

    hi_venc_slice_split sliceSplit{};
    hi_s32 ret = hi_mpi_venc_get_slice_split(chn, &sliceSplit);
    PyObject* pySliceSplit = GetPydictFromVencSliceSplit(sliceSplit);
    CHECK_NULL(pySliceSplit);
    PyObject* obj = Py_BuildValue("OI", pySliceSplit, ret);
    Py_XDECREF(pySliceSplit);
    return obj;
}

PyObject* WrapHiMpiVencGetQpmapStride(PyObject* /* self */, PyObject* args)
{
    hi_u32 width = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "I", &width), "acl.himpi.venc_get_qpmap_stride args parse failed");

    hi_s32 stride = hi_mpi_venc_get_qpmap_stride(width);
    return Py_BuildValue("i", stride);
}

PyObject* WrapHiMpiVencGetQpmapSize(PyObject* /* self */, PyObject* args)
{
    hi_payload_type type = HI_PT_PCMU;
    hi_u32 width = 0;
    hi_u32 height = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iII", &type, &width, &height), "acl.himpi.venc_get_qpmap_size args parse failed");

    hi_s32 size = hi_mpi_venc_get_qpmap_size(type, width, height);
    return Py_BuildValue("i", size);
}

static bool GetPydictFromVencStreamcopyParam(PyObject* pyDict, hi_venc_streamcopy_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_venc_streamcopy_param argument is not dict");

    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "copy_en", param.copy_en));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "copy_interval", param.copy_interval));

    return true;
}

PyObject* WrapHiMpiVencSetStreamcopyParam(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;
    PyObject* pyParam = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyParam), "acl.himpi.venc_set_streamcopy_param args parse failed");

    hi_venc_streamcopy_param param{};
    CHECK_NULL(GetPydictFromVencStreamcopyParam(pyParam, param));

    hi_s32 ret = hi_mpi_venc_set_streamcopy_param(chn, &param);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromVencSetStreamcopyParam(hi_venc_streamcopy_param& param)
{
    PyObject* pyDict = PyDict_New();

    CHECK_NULL(SetItemToDict(pyDict, "copy_en", Py_BuildValue("I", param.copy_en)));
    CHECK_NULL(SetItemToDict(pyDict, "copy_interval", Py_BuildValue("I", param.copy_interval)));

    return pyDict;
}

PyObject* WrapHiMpiVencGetStreamcopyParam(PyObject* /* self */, PyObject* args)
{
    hi_venc_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.venc_get_streamcopy_param args parse failed");

    hi_venc_streamcopy_param param{};
    hi_s32 ret = hi_mpi_venc_get_streamcopy_param(chn, &param);
    PyObject* pyParam = GetPydictFromVencSetStreamcopyParam(param);
    CHECK_NULL(pyParam);
    PyObject* obj = Py_BuildValue("OI", pyParam, ret);
    Py_XDECREF(pyParam);
    return obj;
}