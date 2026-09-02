/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "himpi_vdec.h"

static bool GetVdecVideoAttrFromPydict(PyObject* pyDict, hi_vdec_video_attr& attr)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vdec_video_attr argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "ref_frame_num", attr.ref_frame_num));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "temporal_mvp_en", attr.temporal_mvp_en));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "tmv_buf_size", attr.tmv_buf_size));

    return true;
}

static bool GetVdecChnAttrFromPydict(PyObject* pyDict, hi_vdec_chn_attr& attr)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vpc_chn_attr argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "type", attr.type));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "mode", attr.mode));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "pic_width", attr.pic_width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "pic_height", attr.pic_height));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "stream_buf_size", attr.stream_buf_size));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "frame_buf_size", attr.frame_buf_size));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "frame_buf_cnt", attr.frame_buf_cnt));

    PyObject* pyVideoAttr = PyDict_GetItemString(pyDict, "video_attr");
    CHECK_BOOL(GetVdecVideoAttrFromPydict(pyVideoAttr, attr.video_attr));

    return true;
}

PyObject* WrapHiMpiVdecCreateChn(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;
    PyObject* pyDict = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyDict), "acl.himpi.vdec_create_chn args parse failed!");

    hi_vdec_chn_attr attr{};
    CHECK_NULL(GetVdecChnAttrFromPydict(pyDict, attr));

    hi_s32 ret = hi_mpi_vdec_create_chn(chn, &attr);
    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiVdecDestroyChn(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.vdec_destroy_chn args parse failed!");

    hi_s32 ret = hi_mpi_vdec_destroy_chn(chn);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromVdecVideoAttr(hi_vdec_video_attr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "ref_frame_num", Py_BuildValue("I", attr.ref_frame_num)));
    CHECK_NULL(SetItemToDict(pyDict, "temporal_mvp_en", Py_BuildValue("i", attr.temporal_mvp_en)));
    CHECK_NULL(SetItemToDict(pyDict, "tmv_buf_size", Py_BuildValue("I", attr.tmv_buf_size)));

    return pyDict;
}

static PyObject* GetPydictFromVdecChnAttr(hi_vdec_chn_attr& attr)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "type", Py_BuildValue("i", attr.type)));
    CHECK_NULL(SetItemToDict(pyDict, "mode", Py_BuildValue("i", attr.mode)));
    CHECK_NULL(SetItemToDict(pyDict, "pic_width", Py_BuildValue("I", attr.pic_width)));
    CHECK_NULL(SetItemToDict(pyDict, "pic_height", Py_BuildValue("I", attr.pic_height)));
    CHECK_NULL(SetItemToDict(pyDict, "stream_buf_size", Py_BuildValue("I", attr.stream_buf_size)));
    CHECK_NULL(SetItemToDict(pyDict, "frame_buf_size", Py_BuildValue("I", attr.frame_buf_size)));
    CHECK_NULL(SetItemToDict(pyDict, "frame_buf_cnt", Py_BuildValue("I", attr.frame_buf_cnt)));
    CHECK_NULL(SetItemToDict(pyDict, "video_attr", GetPydictFromVdecVideoAttr(attr.video_attr)));

    return pyDict;
}

PyObject* WrapHiMpiVdecGetChnAttr(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;
    hi_vdec_chn_attr attr{};

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.vdec_get_chn_attr args parse failed!");

    hi_s32 ret = hi_mpi_vdec_get_chn_attr(chn, &attr);
    PyObject* pyDict = GetPydictFromVdecChnAttr(attr);
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyDict, ret);
    Py_XDECREF(pyDict);

    return obj;
}

PyObject* WrapHiMpiVdecSetChnAttr(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;
    PyObject* pyDict = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyDict), "acl.himpi.vdec_set_chn_attr args parse failed!");

    hi_vdec_chn_attr attr{};
    CHECK_NULL(GetVdecChnAttrFromPydict(pyDict, attr));

    hi_s32 ret = hi_mpi_vdec_set_chn_attr(chn, &attr);
    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiVdecStartRecvStream(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.vdec_start_recv_stream args parse failed!");

    hi_s32 ret = hi_mpi_vdec_start_recv_stream(chn);
    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiVdecStopRecvStream(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.vdec_stop_recv_stream args parse failed!");

    hi_s32 ret = hi_mpi_vdec_stop_recv_stream(chn);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromVdecDecErr(hi_vdec_dec_err& err)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "set_pic_size_err", Py_BuildValue("i", err.set_pic_size_err)));
    CHECK_NULL(SetItemToDict(pyDict, "set_protocol_num_err", Py_BuildValue("i", err.set_protocol_num_err)));
    CHECK_NULL(SetItemToDict(pyDict, "set_ref_num_err", Py_BuildValue("i", err.set_ref_num_err)));
    CHECK_NULL(SetItemToDict(pyDict, "set_pic_buf_size_err", Py_BuildValue("i", err.set_pic_buf_size_err)));
    CHECK_NULL(SetItemToDict(pyDict, "format_err", Py_BuildValue("i", err.format_err)));
    CHECK_NULL(SetItemToDict(pyDict, "stream_unsupport", Py_BuildValue("i", err.stream_unsupport)));
    CHECK_NULL(SetItemToDict(pyDict, "pack_err", Py_BuildValue("i", err.pack_err)));
    CHECK_NULL(SetItemToDict(pyDict, "stream_size_over", Py_BuildValue("i", err.stream_size_over)));
    CHECK_NULL(SetItemToDict(pyDict, "stream_not_release", Py_BuildValue("i", err.stream_not_release)));

    return pyDict;
}

static PyObject* GetPydictFromVdecChnStatus(hi_vdec_chn_status& status)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "type", Py_BuildValue("i", status.type)));
    CHECK_NULL(SetItemToDict(pyDict, "left_stream_bytes", Py_BuildValue("I", status.left_stream_bytes)));
    CHECK_NULL(SetItemToDict(pyDict, "left_stream_frames", Py_BuildValue("I", status.left_stream_frames)));
    CHECK_NULL(SetItemToDict(pyDict, "left_decoded_frames", Py_BuildValue("I", status.left_decoded_frames)));
    CHECK_NULL(SetItemToDict(pyDict, "is_started", Py_BuildValue("i", status.is_started)));
    CHECK_NULL(SetItemToDict(pyDict, "recv_stream_frames", Py_BuildValue("I", status.recv_stream_frames)));
    CHECK_NULL(SetItemToDict(pyDict, "dec_stream_frames", Py_BuildValue("I", status.dec_stream_frames)));
    CHECK_NULL(SetItemToDict(pyDict, "dec_err", GetPydictFromVdecDecErr(status.dec_err)));
    CHECK_NULL(SetItemToDict(pyDict, "width", Py_BuildValue("I", status.width)));
    CHECK_NULL(SetItemToDict(pyDict, "height", Py_BuildValue("I", status.height)));
    CHECK_NULL(SetItemToDict(pyDict, "latest_frame_pts", Py_BuildValue("K", status.latest_frame_pts)));

    return pyDict;
}

PyObject* WrapHiMpiVdecQueryStatus(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;
    hi_vdec_chn_status status{};

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.vdec_query_status args parse failed!");

    hi_s32 ret = hi_mpi_vdec_query_status(chn, &status);
    PyObject* pyDict = GetPydictFromVdecChnStatus(status);
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyDict, ret);
    Py_XDECREF(pyDict);

    return obj;
}

PyObject* WrapHiMpiVdecResetChn(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.vdec_reset_chn args parse failed!");

    hi_s32 ret = hi_mpi_vdec_reset_chn(chn);
    return Py_BuildValue("I", ret);
}

static bool GetVdecVideoParamFromPydict(PyObject* pyDict, hi_vdec_video_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vdec_video_param argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "composite_dec_en", param.composite_dec_en));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "slice_input_en", param.slice_input_en));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "err_threshold", param.err_threshold));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "dec_mode", param.dec_mode));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "out_order", param.out_order));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "compress_mode", param.compress_mode));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "video_format", param.video_format));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "quick_mark_mode", param.quick_mark_mode));

    return true;
}

static bool GetVdecPicParamFromPydict(PyObject* pyDict, hi_vdec_pic_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vdec_pic_param argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "pixel_format", param.pixel_format));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "alpha", param.alpha));

    return true;
}

static bool GetVdecChnParamFromPydict(PyObject* pyDict, hi_vdec_chn_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vdec_chn_param argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "type", param.type));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "display_frame_num", param.display_frame_num));

    if (param.type == HI_PT_H264 || param.type == HI_PT_H265) {
        PyObject* pyVideoParam = PyDict_GetItemString(pyDict, "video_param");
        CHECK_BOOL(GetVdecVideoParamFromPydict(pyVideoParam, param.video_param));
    } else if (param.type == HI_PT_JPEG) {
        PyObject* pyPictureParam = PyDict_GetItemString(pyDict, "pic_param");
        CHECK_BOOL(GetVdecPicParamFromPydict(pyPictureParam, param.pic_param));
    }

    return true;
}

PyObject* WrapHiMpiVdecSetChnParam(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;
    PyObject* pyDict = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyDict), "acl.himpi.vdec_set_chn_param args parse failed!");

    hi_vdec_chn_param chnParam{};
    CHECK_NULL(GetVdecChnParamFromPydict(pyDict, chnParam));

    hi_s32 ret = hi_mpi_vdec_set_chn_param(chn, &chnParam);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromVdecVideoParam(hi_vdec_video_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "composite_dec_en", Py_BuildValue("i", param.composite_dec_en)));
    CHECK_NULL(SetItemToDict(pyDict, "slice_input_en", Py_BuildValue("i", param.slice_input_en)));
    CHECK_NULL(SetItemToDict(pyDict, "err_threshold", Py_BuildValue("i", param.err_threshold)));
    CHECK_NULL(SetItemToDict(pyDict, "dec_mode", Py_BuildValue("i", param.dec_mode)));
    CHECK_NULL(SetItemToDict(pyDict, "out_order", Py_BuildValue("i", param.out_order)));
    CHECK_NULL(SetItemToDict(pyDict, "compress_mode", Py_BuildValue("i", param.compress_mode)));
    CHECK_NULL(SetItemToDict(pyDict, "video_format", Py_BuildValue("i", param.video_format)));
    CHECK_NULL(SetItemToDict(pyDict, "quick_mark_mode", Py_BuildValue("i", param.quick_mark_mode)));

    return pyDict;
}

static PyObject* GetPydictFromVdecPicParam(hi_vdec_pic_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "pixel_format", Py_BuildValue("i", param.pixel_format)));
    CHECK_NULL(SetItemToDict(pyDict, "alpha", Py_BuildValue("I", param.alpha)));

    return pyDict;
}

static PyObject* GetPydictFromVdecChnParam(hi_vdec_chn_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "type", Py_BuildValue("i", param.type)));
    CHECK_NULL(SetItemToDict(pyDict, "display_frame_num", Py_BuildValue("I", param.display_frame_num)));

    if (param.type == HI_PT_H264 || param.type == HI_PT_H265) {
        CHECK_NULL(SetItemToDict(pyDict, "video_param", GetPydictFromVdecVideoParam(param.video_param)));
    } else if (param.type == HI_PT_JPEG) {
        CHECK_NULL(SetItemToDict(pyDict, "pic_param", GetPydictFromVdecPicParam(param.pic_param)));
    }

    return pyDict;
}

PyObject* WrapHiMpiVdecGetChnParam(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;
    hi_vdec_chn_param chnParam{};

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.vdec_get_chn_param args parse failed!");

    hi_s32 ret = hi_mpi_vdec_get_chn_param(chn, &chnParam);
    PyObject* pyDict = GetPydictFromVdecChnParam(chnParam);
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyDict, ret);
    Py_XDECREF(pyDict);

    return obj;
}

static bool GetH265ProtocoParamFromPydict(PyObject* pyDict, hi_h265_protocol_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_h265_protocol_param argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_slice_segment_num", param.max_slice_segment_num));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_vps_num", param.max_vps_num));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_sps_num", param.max_sps_num));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "max_pps_num", param.max_pps_num));

    return true;
}

static bool GetH264ProtocoParamFromPydict(PyObject* pyDict, hi_h264_protocol_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_h264_protocol_param argument is not dict");
    GetValueFromPyDict(pyDict, "max_slice_num", param.max_slice_num);
    GetValueFromPyDict(pyDict, "max_sps_num", param.max_sps_num);
    GetValueFromPyDict(pyDict, "max_pps_num", param.max_pps_num);

    return true;
}

static bool GetVdecProtocoParamFromPydict(PyObject* pyDict, hi_vdec_protocol_param& param)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vdec_protocol_param argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "type", param.type));

    if (param.type == HI_PT_H264) {
        PyObject* pyH264Param = PyDict_GetItemString(pyDict, "h264_param");
        CHECK_BOOL(GetH264ProtocoParamFromPydict(pyH264Param, param.h264_param));
    } else if (param.type == HI_PT_H265) {
        PyObject* pyH265Param = PyDict_GetItemString(pyDict, "h265_param");
        CHECK_BOOL(GetH265ProtocoParamFromPydict(pyH265Param, param.h265_param));
    }

    return true;
}

PyObject* WrapHiMpiVdecSetProtocolParam(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;
    PyObject* pyDict = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyDict), "acl.himpi.vdec_set_protocol_param args parse failed!");

    hi_vdec_protocol_param protocolParam{};
    protocolParam.type = HI_PT_BUTT;
    CHECK_NULL(GetVdecProtocoParamFromPydict(pyDict, protocolParam));

    hi_s32 ret = hi_mpi_vdec_set_protocol_param(chn, &protocolParam);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromH265ProtocolParam(hi_h265_protocol_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "max_slice_segment_num", Py_BuildValue("i", param.max_slice_segment_num)));
    CHECK_NULL(SetItemToDict(pyDict, "max_vps_num", Py_BuildValue("i", param.max_vps_num)));
    CHECK_NULL(SetItemToDict(pyDict, "max_sps_num", Py_BuildValue("i", param.max_sps_num)));
    CHECK_NULL(SetItemToDict(pyDict, "max_pps_num", Py_BuildValue("i", param.max_pps_num)));

    return pyDict;
}

static PyObject* GetPydictFromH264ProtocolParam(hi_h264_protocol_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "max_slice_num", Py_BuildValue("i", param.max_slice_num)));
    CHECK_NULL(SetItemToDict(pyDict, "max_sps_num", Py_BuildValue("i", param.max_sps_num)));
    CHECK_NULL(SetItemToDict(pyDict, "max_pps_num", Py_BuildValue("i", param.max_pps_num)));

    return pyDict;
}

static PyObject* GetPydictFromVdecProtocolParam(hi_vdec_protocol_param& param)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "type", Py_BuildValue("i", param.type)));

    if (param.type == HI_PT_H264) {
        CHECK_NULL(SetItemToDict(pyDict, "h264_param", GetPydictFromH264ProtocolParam(param.h264_param)));
    } else if (param.type == HI_PT_H265) {
        CHECK_NULL(SetItemToDict(pyDict, "h265_param", GetPydictFromH265ProtocolParam(param.h265_param)));
    }

    return pyDict;
}

PyObject* WrapHiMpiVdecGetProtocolParam(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;
    hi_vdec_protocol_param protocolParam{};

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.vdec_get_protocol_param args parse failed!");

    hi_s32 ret = hi_mpi_vdec_get_protocol_param(chn, &protocolParam);
    PyObject* pyDict = GetPydictFromVdecProtocolParam(protocolParam);
    CHECK_NULL(pyDict != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyDict, ret);
    Py_XDECREF(pyDict);

    return obj;
}

static bool GetVdecStreamFromPydict(PyObject* pyDict, hi_vdec_stream& stream)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vpc_lut_remap argument is not dict");
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "end_of_frame", stream.end_of_frame));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "end_of_stream", stream.end_of_stream));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "need_display", stream.need_display));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "pts", stream.pts));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "private_data", stream.private_data));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "len", stream.len));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "addr", reinterpret_cast<void*&>(stream.addr)));

    return true;
}

static bool GetVdecPicInfoFromPydict(PyObject* pyDict, hi_vdec_pic_info& picInfo)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_vpc_lut_remap argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "width", picInfo.width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "height", picInfo.height));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "width_stride", picInfo.width_stride));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "height_stride", picInfo.height_stride));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "pixel_format", picInfo.pixel_format));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "vir_addr", reinterpret_cast<void*&>(picInfo.vir_addr)));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "buffer_size", picInfo.buffer_size));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "offset_top", picInfo.offset_top));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "offset_bottom", picInfo.offset_bottom));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "offset_left", picInfo.offset_left));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "offset_right", picInfo.offset_right));

    return true;
}

PyObject* WrapHiMpiVdecSendStream(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;
    PyObject* pyStreamDict = nullptr;
    PyObject* pyPicInfoDict = nullptr;
    hi_s32 milliSec = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iOOi", &chn, &pyStreamDict, &pyPicInfoDict, &milliSec),
        "acl.himpi.vdec_send_stream args parse failed!");

    hi_vdec_stream stream{};
    CHECK_NULL(GetVdecStreamFromPydict(pyStreamDict, stream));

    hi_vdec_pic_info vdecPicInfo{};
    CHECK_NULL(GetVdecPicInfoFromPydict(pyPicInfoDict, vdecPicInfo));

    hi_s32 ret = hi_mpi_vdec_send_stream(chn, &stream, &vdecPicInfo, milliSec);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromVideoSupplement(hi_video_supplement& info)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "misc_info_phys_addr", Py_BuildValue("K", info.misc_info_phys_addr)));
    CHECK_NULL(SetItemToDict(pyDict, "jpeg_dcf_phys_addr", Py_BuildValue("K", info.jpeg_dcf_phys_addr)));
    CHECK_NULL(SetItemToDict(pyDict, "isp_info_phys_addr", Py_BuildValue("K", info.isp_info_phys_addr)));
    CHECK_NULL(SetItemToDict(pyDict, "low_delay_phys_addr", Py_BuildValue("K", info.low_delay_phys_addr)));
    CHECK_NULL(SetItemToDict(pyDict, "bnr_rnt_phys_addr", Py_BuildValue("K", info.bnr_rnt_phys_addr)));
    CHECK_NULL(SetItemToDict(pyDict, "motion_data_phys_addr", Py_BuildValue("K", info.motion_data_phys_addr)));
    CHECK_NULL(SetItemToDict(pyDict, "frame_dng_phys_addr", Py_BuildValue("K", info.frame_dng_phys_addr)));
    CHECK_NULL(SetItemToDict(pyDict, "misc_info_virt_addr", Py_BuildValue("k", info.misc_info_virt_addr)));
    CHECK_NULL(SetItemToDict(pyDict, "jpeg_dcf_virt_addr", Py_BuildValue("k", info.jpeg_dcf_virt_addr)));
    CHECK_NULL(SetItemToDict(pyDict, "isp_info_virt_addr", Py_BuildValue("k", info.isp_info_virt_addr)));
    CHECK_NULL(SetItemToDict(pyDict, "low_delay_virt_addr", Py_BuildValue("k", info.low_delay_virt_addr)));
    CHECK_NULL(SetItemToDict(pyDict, "bnr_mot_virt_addr", Py_BuildValue("k", info.bnr_mot_virt_addr)));
    CHECK_NULL(SetItemToDict(pyDict, "motion_data_virt_addr", Py_BuildValue("k", info.motion_data_virt_addr)));
    CHECK_NULL(SetItemToDict(pyDict, "frame_dng_virt_addr", Py_BuildValue("k", info.frame_dng_virt_addr)));

    return pyDict;
}

static PyObject* GetPydictFromVideoFrame(hi_video_frame& info)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "width", Py_BuildValue("I", info.width)));
    CHECK_NULL(SetItemToDict(pyDict, "height", Py_BuildValue("I", info.height)));
    CHECK_NULL(SetItemToDict(pyDict, "field", Py_BuildValue("i", info.field)));
    CHECK_NULL(SetItemToDict(pyDict, "pixel_format", Py_BuildValue("i", info.pixel_format)));
    CHECK_NULL(SetItemToDict(pyDict, "video_format", Py_BuildValue("i", info.video_format)));
    CHECK_NULL(SetItemToDict(pyDict, "compress_mode", Py_BuildValue("i", info.compress_mode)));
    CHECK_NULL(SetItemToDict(pyDict, "dynamic_range", Py_BuildValue("i", info.dynamic_range)));
    CHECK_NULL(SetItemToDict(pyDict, "color_gamut", Py_BuildValue("i", info.color_gamut)));
    CHECK_NULL(SetItemToDict(pyDict, "header_stride", GetPyListFromArray(info.header_stride, HI_MAX_COLOR_COMPONENT)));
    CHECK_NULL(SetItemToDict(pyDict, "width_stride", GetPyListFromArray(info.width_stride, HI_MAX_COLOR_COMPONENT)));
    CHECK_NULL(SetItemToDict(pyDict, "height_stride", GetPyListFromArray(info.height_stride, HI_MAX_COLOR_COMPONENT)));
    CHECK_NULL(
        SetItemToDict(pyDict, "header_phys_addr", GetPyListFromArray(info.header_phys_addr, HI_MAX_COLOR_COMPONENT)));
    CHECK_NULL(SetItemToDict(pyDict, "phys_addr", GetPyListFromArray(info.phys_addr, HI_MAX_COLOR_COMPONENT)));
    CHECK_NULL(
        SetItemToDict(pyDict, "header_virt_addr", GetPyListFromArray(info.header_virt_addr, HI_MAX_COLOR_COMPONENT)));
    CHECK_NULL(SetItemToDict(pyDict, "virt_addr", GetPyListFromArray(info.virt_addr, HI_MAX_COLOR_COMPONENT)));
    CHECK_NULL(SetItemToDict(pyDict, "time_ref", Py_BuildValue("I", info.time_ref)));
    CHECK_NULL(SetItemToDict(pyDict, "pts", Py_BuildValue("K", info.pts)));
    CHECK_NULL(SetItemToDict(pyDict, "user_data", GetPyListFromArray(info.user_data, HI_MAX_USER_DATA_NUM)));
    CHECK_NULL(SetItemToDict(pyDict, "frame_flag", Py_BuildValue("I", info.frame_flag)));
    CHECK_NULL(SetItemToDict(pyDict, "supplement", GetPydictFromVideoSupplement(info.supplement)));

    return pyDict;
}

static PyObject* GetPydictFromVideoFrameInfo(hi_video_frame_info& info)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "v_frame", GetPydictFromVideoFrame(info.v_frame)));
    CHECK_NULL(SetItemToDict(pyDict, "pool_id", Py_BuildValue("I", info.pool_id)));
    CHECK_NULL(SetItemToDict(pyDict, "mod_id", Py_BuildValue("i", info.mod_id)));

    return pyDict;
}

static PyObject* GetPydictFromVdecVideoSupplementInfo(hi_vdec_video_supplement_info& info)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "frame_type", Py_BuildValue("i", info.frame_type)));
    CHECK_NULL(SetItemToDict(pyDict, "err_rate", Py_BuildValue("I", info.err_rate)));
    CHECK_NULL(SetItemToDict(pyDict, "poc", Py_BuildValue("I", info.poc)));

    return pyDict;
}

static PyObject* GetPydictFromVdecSupplementInfo(hi_vdec_supplement_info& info)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "type", Py_BuildValue("i", info.type)));
    CHECK_NULL(SetItemToDict(
        pyDict, "video_supplement_info", GetPydictFromVdecVideoSupplementInfo(info.video_supplement_info)));

    return pyDict;
}

static PyObject* GetPydictFromVdecStream(hi_vdec_stream& stream)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "end_of_frame", Py_BuildValue("i", stream.end_of_frame)));
    CHECK_NULL(SetItemToDict(pyDict, "end_of_stream", Py_BuildValue("i", stream.end_of_stream)));
    CHECK_NULL(SetItemToDict(pyDict, "need_display", Py_BuildValue("i", stream.need_display)));
    CHECK_NULL(SetItemToDict(pyDict, "pts", Py_BuildValue("K", stream.pts)));
    CHECK_NULL(SetItemToDict(pyDict, "private_data", Py_BuildValue("K", stream.private_data)));
    CHECK_NULL(SetItemToDict(pyDict, "len", Py_BuildValue("I", stream.len)));
    CHECK_NULL(SetItemToDict(pyDict, "addr", Py_BuildValue("k", stream.addr)));

    return pyDict;
}

PyObject* WrapHiMpiVdecGetFrame(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;
    hi_video_frame_info frameInfo{};
    hi_vdec_supplement_info supplement{};
    hi_vdec_stream stream{};
    hi_s32 milliSec = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "ii", &chn, &milliSec), "acl.himpi.vdec_get_frame args parse failed!");

    hi_s32 ret = hi_mpi_vdec_get_frame(chn, &frameInfo, &supplement, &stream, milliSec);
    PyObject* pyFrameInfo = GetPydictFromVideoFrameInfo(frameInfo);
    CHECK_NULL(pyFrameInfo != nullptr);

    PyObject* pySupplement = GetPydictFromVdecSupplementInfo(supplement);
    if (pySupplement == nullptr) {
        Py_XDECREF(pyFrameInfo);
        return nullptr;
    }

    PyObject* pyStream = GetPydictFromVdecStream(stream);
    if (pyStream == nullptr) {
        Py_XDECREF(pyFrameInfo);
        Py_XDECREF(pySupplement);
        return nullptr;
    }

    PyObject* obj = Py_BuildValue("OOOI", pyFrameInfo, pySupplement, pyStream, ret);
    Py_XDECREF(pyFrameInfo);
    Py_XDECREF(pySupplement);
    Py_XDECREF(pyStream);

    return obj;
}

static bool GetVideoFrameInfoFromPydict(PyObject* pyDict, hi_video_frame_info& info)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_video_frame_info argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "pool_id", info.pool_id));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "mod_id", info.mod_id));

    PyObject* pyVideoFrame = PyDict_GetItemString(pyDict, "v_frame");
    CHECK_BOOL(GetVideoFrameFromPydict(pyVideoFrame, info.v_frame));

    return true;
}

PyObject* WrapHiMpiVdecReleaseFrame(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;
    PyObject* pyDict = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &chn, &pyDict), "acl.himpi.vdec_release_frame args parse failed!");

    hi_video_frame_info frameInfo{};
    CHECK_NULL(GetVideoFrameInfoFromPydict(pyDict, frameInfo));

    hi_s32 ret = hi_mpi_vdec_release_frame(chn, &frameInfo);
    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiVdecGetFd(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.vdec_get_fd args parse failed!");

    hi_s32 ret = hi_mpi_vdec_get_fd(chn);
    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiVdecCloseFd(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.vdec_close_fd args parse failed!");

    hi_s32 ret = hi_mpi_vdec_close_fd(chn);
    return Py_BuildValue("I", ret);
}

static bool GetPicBufAttrFromPydict(PyObject* pyDict, hi_pic_buf_attr& attr)
{
    CHECK_STRUCT_DICT(pyDict, "the hi_pic_buf_attr argument is not dict");
    CHECK_BOOL(GetValueFromPyDict(pyDict, "width", attr.width));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "height", attr.height));
    CHECK_BOOL(GetValueFromPyDict(pyDict, "align", attr.align));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "bit_width", attr.bit_width));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "pixel_format", attr.pixel_format));
    CHECK_BOOL(GetEnumValueFromPyDict(pyDict, "compress_mode", attr.compress_mode));

    return true;
}

PyObject* WrapHiMpiVdecGetPicBufSize(PyObject* /* self */, PyObject* args)
{
    hi_payload_type payType = HI_PT_VPC;
    PyObject* pyAttr = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "iO", &payType, &pyAttr), "acl.himpi.vdec_get_pic_buf_size args parse failed!");

    hi_pic_buf_attr attr{};
    CHECK_NULL(GetPicBufAttrFromPydict(pyAttr, attr));

    hi_u32 ret = hi_vdec_get_pic_buf_size(payType, &attr);
    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiVdecGetTmvBufSize(PyObject* /* self */, PyObject* args)
{
    hi_payload_type payType = HI_PT_VPC;
    hi_u32 width = 0;
    hi_u32 height = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iII", &payType, &width, &height), "acl.himpi.vdec_get_tmv_buf_size args parse failed!");

    hi_u32 ret = hi_vdec_get_tmv_buf_size(payType, width, height);
    return Py_BuildValue("I", ret);
}

static PyObject* GetPydictFromImgInfo(hi_img_info& info)
{
    PyObject* pyDict = PyDict_New();
    CHECK_NULL(SetItemToDict(pyDict, "width", Py_BuildValue("I", info.width)));
    CHECK_NULL(SetItemToDict(pyDict, "height", Py_BuildValue("I", info.height)));
    CHECK_NULL(SetItemToDict(pyDict, "width_stride", Py_BuildValue("I", info.width_stride)));
    CHECK_NULL(SetItemToDict(pyDict, "height_stride", Py_BuildValue("I", info.height_stride)));
    CHECK_NULL(SetItemToDict(pyDict, "img_buf_size", Py_BuildValue("I", info.img_buf_size)));
    CHECK_NULL(SetItemToDict(pyDict, "pixel_format", Py_BuildValue("i", info.pixel_format)));
    CHECK_NULL(
        SetItemToDict(pyDict, "reserved", GetPyListFromArray(info.reserved, sizeof(info.reserved) / sizeof(hi_u32))));

    return pyDict;
}

PyObject* WrapHiMpiDvppGetImageInfo(PyObject* /* self */, PyObject* args)
{
    hi_payload_type imgType = HI_PT_H264;
    PyObject* pyStreamDict = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iO", &imgType, &pyStreamDict), "acl.himpi.dvpp_get_image_info args parse failed!");

    hi_vdec_stream stream{};
    CHECK_NULL(GetVdecStreamFromPydict(pyStreamDict, stream));

    hi_img_info imgInfo{};
    hi_s32 ret = hi_mpi_dvpp_get_image_info(imgType, &stream, &imgInfo);
    PyObject* pyImgInfo = GetPydictFromImgInfo(imgInfo);
    CHECK_NULL(pyImgInfo != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyImgInfo, ret);
    Py_XDECREF(pyImgInfo);

    return obj;
}

PyObject* WrapHiMpiVdecSetJpegdPrecisionMode(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;
    hi_jpegd_precision_mode precisionMode = YUVOUT_ALIGN_DOWN;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iI", &chn, &precisionMode),
        "acl.himpi.vdec_set_jpegd_precision_mode args parse failed!");
    hi_s32 ret = hi_mpi_vdec_set_jpegd_precision_mode(chn, precisionMode);

    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiVdecGetJpegdOutputInfo(PyObject* /* self */, PyObject* args)
{
    PyObject* pyStream = nullptr;
    hi_pixel_format outputFormat = HI_PIXEL_FORMAT_UNKNOWN;

    CHECK_NULL(
        PyArg_ParseTuple(args, "Oi", &pyStream, &outputFormat),
        "acl.himpi.vdec_get_jpegd_output_info args parse failed");

    hi_vdec_stream stream{};
    CHECK_NULL(GetVdecStreamFromPydict(pyStream, stream));

    hi_img_info imgInfo{};
    hi_s32 ret = hi_mpi_vdec_get_jpegd_output_info(&stream, outputFormat, &imgInfo);
    PyObject* pyImgInfo = GetPydictFromImgInfo(imgInfo);
    CHECK_NULL(pyImgInfo != nullptr);
    PyObject* obj = Py_BuildValue("OI", pyImgInfo, ret);
    Py_XDECREF(pyImgInfo);
    return obj;
}

PyObject* WrapHiMpiVdecSetDisplayMode(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;
    hi_video_display_mode mode = HI_VIDEO_DISPLAY_MODE_PREVIEW;

    CHECK_NULL(PyArg_ParseTuple(args, "iI", &chn, &mode), "acl.himpi.vdec_set_display_mode args parse failed!");
    hi_s32 ret = hi_mpi_vdec_set_display_mode(chn, mode);

    return Py_BuildValue("I", ret);
}

PyObject* WrapHiMpiVdecGetDisplayMode(PyObject* /* self */, PyObject* args)
{
    hi_vdec_chn chn = 0;
    hi_video_display_mode mode = HI_VIDEO_DISPLAY_MODE_PREVIEW;

    CHECK_NULL(PyArg_ParseTuple(args, "i", &chn), "acl.himpi.vdec_get_display_mode args parse failed!");

    hi_s32 ret = hi_mpi_vdec_get_display_mode(chn, &mode);
    return Py_BuildValue("II", mode, ret);
}