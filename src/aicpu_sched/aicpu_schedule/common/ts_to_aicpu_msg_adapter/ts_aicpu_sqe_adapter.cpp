/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ts_aicpu_sqe_adapter.h"
#include "aicpusd_event_manager.h"
#include "aicpusd_event_process.h"
#include "aicpusd_msg_send.h"
#include "dump_task.h"
namespace AicpuSchedule {
TsAicpuSqeAdapter::TsAicpuSqeAdapter(const TsAicpuSqe& sqe)
    : TsMsgAdapter(sqe.pid, sqe.cmd_type, sqe.vf_id, sqe.tid, sqe.ts_id), aicpuSqe_(sqe), invalidSqe_(false)
{
    aicpusd_info("Adapter initialized: message_format=sqe.");
}

TsAicpuSqeAdapter::TsAicpuSqeAdapter() : TsMsgAdapter(), aicpuSqe_({}), invalidSqe_(true)
{
    aicpusd_info("Adapter initialized: message_format=sqe valid=false.");
}

bool TsAicpuSqeAdapter::IsAdapterInvaildParameter() const
{
    return invalidSqe_;
}

void TsAicpuSqeAdapter::GetAicpuDataDumpInfo(AicpuDataDumpInfo& info)
{
    TsToAicpuDataDump tmpInfo = aicpuSqe_.u.ts_to_aicpu_datadump;
    aicpusd_info(
        "Dump request(sqe): model=%u stream=%u task=%u debug_stream=%u debug_task=%u "
        "ack_stream=%u ack_task=%u.",
        tmpInfo.model_id, tmpInfo.stream_id, tmpInfo.task_id, tmpInfo.stream_id1, tmpInfo.task_id1,
        tmpInfo.ack_stream_id, tmpInfo.ack_task_id);
    info.dump_task_id = tmpInfo.task_id;
    info.dump_stream_id = tmpInfo.stream_id;
    info.debug_dump_task_id = tmpInfo.task_id1;
    info.debug_dump_stream_id = tmpInfo.stream_id1;
    info.is_model = (tmpInfo.model_id != INVALID_VALUE16);
    info.is_debug = ((tmpInfo.task_id1 != INVALID_VALUE16) && (tmpInfo.stream_id1 != INVALID_VALUE16));
    info.file_name_stream_id = info.is_debug ? tmpInfo.stream_id1 : tmpInfo.stream_id;
    info.file_name_task_id = info.is_debug ? tmpInfo.task_id1 : tmpInfo.task_id;
}

void TsAicpuSqeAdapter::GetAicpuDumpFFTSPlusDataInfo(AicpuDumpFFTSPlusDataInfo& info)
{
    aicpusd_info("Get FFTS+ dump info.");
    info.i = aicpuSqe_.u.ts_to_aicpu_ffts_plus_datadump;
    return;
}

bool TsAicpuSqeAdapter::IsOpMappingDumpTaskInfoVaild(const AicpuOpMappingDumpTaskInfo& info) const
{
    bool isOutOfRange = (info.proto_info_task_id > INVALID_VALUE16) || (info.proto_info_stream_id > INVALID_VALUE16) ||
                        (info.stream_id > INVALID_VALUE16) || (info.task_id > INVALID_VALUE16);
    return !isOutOfRange;
}

void TsAicpuSqeAdapter::GetAicpuDumpTaskInfo(AicpuOpMappingDumpTaskInfo& opmappingInfo, AicpuDumpTaskInfo& dumpTaskInfo)
{
    opmappingInfo.proto_info_task_id &= 0xFFFF;
    aicpusd_info(
        "Dump task mapping: proto_task=%u proto_stream=%u mapped_task=%u mapped_stream=%u",
        opmappingInfo.proto_info_task_id, opmappingInfo.proto_info_stream_id, opmappingInfo.task_id,
        opmappingInfo.stream_id);
    dumpTaskInfo.task_id =
        opmappingInfo.proto_info_task_id == INVALID_VALUE16 ? opmappingInfo.task_id : opmappingInfo.proto_info_task_id;
    dumpTaskInfo.stream_id = opmappingInfo.proto_info_stream_id == INVALID_VALUE16 ? opmappingInfo.stream_id :
                                                                                     opmappingInfo.proto_info_stream_id;
    dumpTaskInfo.context_id = INVALID_VALUE16;
    dumpTaskInfo.thread_id = INVALID_VALUE16;
}

void TsAicpuSqeAdapter::GetAicpuDataDumpInfoLoad(AicpuDataDumpInfoLoad& info)
{
    TsToAicpuDataDumpInfoLoad tmpinfo = aicpuSqe_.u.ts_to_aicpu_datadumploadinfo;
    aicpusd_info(
        "Dump load request: address=%p length=%u task=%u stream=%u.", tmpinfo.dumpinfoPtr,
        tmpinfo.length, tmpinfo.task_id, tmpinfo.stream_id);
    info.dumpinfoPtr = tmpinfo.dumpinfoPtr;
    info.length = tmpinfo.length;
    info.task_id = tmpinfo.task_id;
    info.stream_id = tmpinfo.stream_id;
}

int32_t TsAicpuSqeAdapter::AicpuDumpResponseToTs(const int32_t result)
{
    TsAicpuSqe aicpuSqe{};
    aicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    aicpuSqe.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    aicpuSqe.tid = tid_;
    aicpuSqe.ts_id = tsId_;
    aicpuSqe.cmd_type = AICPU_DATADUMP_RESPONSE;
    aicpuSqe.u.aicpu_dump_resp.result_code = static_cast<uint16_t>(result);
    aicpuSqe.u.aicpu_dump_resp.cmd_type = AICPU_DATADUMP_REPORT;
    uint32_t handleId = 0U;
    if (cmdType_ == AICPU_FFTS_PLUS_DATADUMP_REPORT) {
        aicpusd_info("Dump response path: mode=ffts_plus.");
        TsToAicpuFFTSPlusDataDump info = aicpuSqe_.u.ts_to_aicpu_ffts_plus_datadump;
        uint32_t ackStreamId = info.stream_id;
        uint32_t ackTaskId = info.task_id;
        if ((info.task_id1 != INVALID_VALUE16) && (info.stream_id1 != INVALID_VALUE16)) {
            ackStreamId = info.stream_id1;
            ackTaskId = info.task_id1;
        }
        aicpuSqe.u.aicpu_dump_resp.task_id = ackTaskId;
        aicpuSqe.u.aicpu_dump_resp.stream_id = ackStreamId;
        aicpuSqe.u.aicpu_dump_resp.reserved = info.reserved[0];
        handleId = info.model_id;
    } else {
        aicpuSqe.u.aicpu_dump_resp.task_id = aicpuSqe_.u.ts_to_aicpu_datadump.ack_task_id;
        aicpuSqe.u.aicpu_dump_resp.stream_id = aicpuSqe_.u.ts_to_aicpu_datadump.ack_stream_id;
        aicpuSqe.u.aicpu_dump_resp.reserved = aicpuSqe_.u.ts_to_aicpu_datadump.reserved[0];
        handleId = aicpuSqe_.u.ts_to_aicpu_datadump.model_id;
    }
    aicpusd_info(
        "Dump response: message_type=%u result=%u ack_stream=%u ack_task=%u.", aicpuSqe.cmd_type, result,
        aicpuSqe.u.aicpu_dump_resp.stream_id, aicpuSqe.u.aicpu_dump_resp.task_id);
    return ResponseToTs(aicpuSqe, handleId, AicpuDrvManager::GetInstance().GetDeviceId(), aicpuSqe.ts_id);
}

int32_t TsAicpuSqeAdapter::AicpuDataDumpLoadResponseToTs(const int32_t result)
{
    TsAicpuSqe aicpuSqe{};
    aicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    aicpuSqe.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    aicpuSqe.tid = tid_;
    aicpuSqe.ts_id = tsId_;
    aicpuSqe.cmd_type = AICPU_DATADUMP_RESPONSE;
    aicpuSqe.u.aicpu_dump_resp.result_code = static_cast<uint16_t>(result);
    aicpuSqe.u.aicpu_dump_resp.cmd_type = AICPU_DATADUMP_LOADINFO;
    aicpuSqe.u.aicpu_dump_resp.task_id = aicpuSqe_.u.ts_to_aicpu_datadumploadinfo.task_id;
    aicpuSqe.u.aicpu_dump_resp.stream_id = aicpuSqe_.u.ts_to_aicpu_datadumploadinfo.stream_id;
    aicpuSqe.u.aicpu_dump_resp.reserved = STARS_DATADUMP_LOAD_INFO;
    aicpusd_info(
        "Dump load response: message_type=%u result=%u stream=%u task=%u.", aicpuSqe.cmd_type, result,
        aicpuSqe.u.aicpu_dump_resp.stream_id, aicpuSqe.u.aicpu_dump_resp.task_id);
    return ResponseToTs(aicpuSqe, 0U, AicpuDrvManager::GetInstance().GetDeviceId(), aicpuSqe.ts_id);
}

void TsAicpuSqeAdapter::GetAicpuModelOperateInfo(AicpuModelOperateInfo& info)
{
    TsAicpuModelOperate tmpInfo = aicpuSqe_.u.aicpu_model_operate;
    aicpusd_info("Model operation request: argument=%p operation=%u model=%u task=%u.",
        tmpInfo.arg_ptr,
        tmpInfo.cmd_type,
        tmpInfo.model_id,
        tmpInfo.task_id);
    info.arg_ptr = tmpInfo.arg_ptr;
    info.cmd_type = tmpInfo.cmd_type;
    info.model_id = tmpInfo.model_id;
    info.stream_id = tmpInfo.sq_id;  // sq_id in rts actually is stream id
    info.task_id = tmpInfo.task_id;
    info.reserved[0] = tmpInfo.reserved;
    return;
}

int32_t TsAicpuSqeAdapter::AicpuModelOperateResponseToTs(const int32_t result, const uint32_t subEvent) 
{
    TsAicpuModelOperate tmpInfo = aicpuSqe_.u.aicpu_model_operate;
    TsAicpuSqe aicpuSqe = {};
    aicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    aicpuSqe.cmd_type = AICPU_MODEL_OPERATE_RESPONSE;
    aicpuSqe.vf_id = vfId_;
    aicpuSqe.tid = tid_;
    aicpuSqe.ts_id = tsId_;
    aicpuSqe.u.aicpu_model_operate_resp.cmd_type = AICPU_MODEL_OPERATE;
    aicpuSqe.u.aicpu_model_operate_resp.sub_cmd_type = tmpInfo.cmd_type;
    aicpuSqe.u.aicpu_model_operate_resp.model_id = tmpInfo.model_id;
    aicpuSqe.u.aicpu_model_operate_resp.result_code = static_cast<uint16_t>(result);
    aicpuSqe.u.aicpu_model_operate_resp.task_id = tmpInfo.task_id;
    aicpuSqe.u.aicpu_model_operate_resp.sq_id = tmpInfo.sq_id;
    aicpusd_info("Model operation response: message_type=%u result=%u", cmdType_, result);
    hwts_response_t hwtsResp = {};
    hwtsResp.result = static_cast<uint32_t>(result);
    hwtsResp.status =
        (result == AICPU_SCHEDULE_OK) ? static_cast<uint32_t>(TASK_SUCC) : static_cast<uint32_t>(TASK_FAIL);
    hwtsResp.msg = PtrToPtr<TsAicpuSqe, char_t>(&aicpuSqe);
    hwtsResp.len = static_cast<int32_t>(sizeof(TsAicpuSqe));
    return ResponseToTs(hwtsResp, AicpuDrvManager::GetInstance().GetDeviceId(), EVENT_TS_CTRL_MSG, subEvent);
}

void TsAicpuSqeAdapter::AicpuActiveStreamSetMsg(ActiveStreamInfo& info) 
{
    TsAicpuSqe aicpuSqe = {};
    aicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    aicpuSqe.cmd_type = AICPU_ACTIVE_STREAM;
    aicpuSqe.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    aicpuSqe.tid = 0U;  // no need tid
    aicpuSqe.ts_id = info.ts_id;
    aicpuSqe.u.aicpu_active_stream.stream_id = info.stream_id;
    aicpuSqe.u.aicpu_active_stream.aicpu_stamp = info.aicpu_stamp;
    aicpusd_info("Active stream update: message_type=%u stream=%u stamp=%u.",
        aicpuSqe.cmd_type,
        aicpuSqe.u.aicpu_active_stream.stream_id,
        aicpuSqe.u.aicpu_active_stream.aicpu_stamp);
    AicpuMsgSend::SetTsDevSendMsgAsync(info.device_id, info.ts_id, aicpuSqe, info.handle_id);
}

void TsAicpuSqeAdapter::GetAicpuMsgVersionInfo(AicpuMsgVersionInfo& info) 
{
    TsAicpuMsgVersion tmpInfo = aicpuSqe_.u.aicpu_msg_version;
    aicpusd_info("Version request: magic=%u version=%hu.", tmpInfo.magic_num, tmpInfo.version);
    info.magic_num = tmpInfo.magic_num;
    info.version = tmpInfo.version;
}

int32_t TsAicpuSqeAdapter::AicpuMsgVersionResponseToTs(const int32_t result) 
{
    TsAicpuMsgInfo msgInfo{};
    msgInfo.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    msgInfo.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    msgInfo.tid = tid_;
    msgInfo.ts_id = tsId_;
    msgInfo.cmd_type = cmdType_;
    msgInfo.u.aicpu_resp.result_code = static_cast<uint16_t>(result);
    msgInfo.u.aicpu_resp.task_id = INVALID_VALUE32;
    aicpusd_info("Version response: message_type=%u result=%u stream=%u task=%u.",
        msgInfo.cmd_type,
        msgInfo.u.aicpu_resp.result_code,
        msgInfo.u.aicpu_resp.stream_id,
        msgInfo.u.aicpu_resp.task_id);
    return ResponseToTs(msgInfo, 0U, AicpuDrvManager::GetInstance().GetDeviceId(), msgInfo.ts_id);
}

void TsAicpuSqeAdapter::GetAicpuTaskReportInfo(AicpuTaskReportInfo& info) 
{
    TsToAicpuTaskReport tmpInfo = aicpuSqe_.u.ts_to_aicpu_task_report;
    aicpusd_info("Task report request: task=%u model=%u result=%u stream=%u",
        tmpInfo.task_id,
        tmpInfo.model_id,
        tmpInfo.result_code,
        tmpInfo.stream_id);
    info.task_id = tmpInfo.task_id;
    info.model_id = tmpInfo.model_id;
    info.stream_id = tmpInfo.stream_id;
    info.result_code = tmpInfo.result_code;
}
int32_t TsAicpuSqeAdapter::ErrorMsgResponseToTs(ErrMsgRspInfo& rspInfo) 
{
    TsAicpuSqe aicpuSqe{};
    aicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    aicpuSqe.cmd_type = AICPU_ERR_MSG_REPORT;
    aicpuSqe.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    aicpuSqe.tid = 0U;  // no need tid
    aicpuSqe.ts_id = static_cast<uint8_t>(rspInfo.ts_id);
    aicpuSqe.u.aicpu_err_msg_report.result_code = rspInfo.err_code;
    aicpuSqe.u.aicpu_err_msg_report.stream_id = static_cast<uint16_t>(rspInfo.stream_id);
    aicpuSqe.u.aicpu_err_msg_report.task_id = static_cast<uint16_t>(rspInfo.task_id);
    aicpuSqe.u.aicpu_err_msg_report.offset = static_cast<uint16_t>(rspInfo.offset);
    aicpusd_info("Error response: message_type=%u result=%u response_stream=%u response_task=%u",
        aicpuSqe.cmd_type,
        rspInfo.err_code,
        rspInfo.stream_id,
        rspInfo.task_id);
    return ResponseToTs(aicpuSqe, rspInfo.model_id, AicpuDrvManager::GetInstance().GetDeviceId(), aicpuSqe.ts_id);
}

int32_t TsAicpuSqeAdapter::AicpuNoticeTsPidResponse(const uint32_t deviceId) const 
{
    TsAicpuSqe aicpuSqe = {};
    aicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());  // host pid
    aicpuSqe.cmd_type = AICPU_NOTICE_TS_PID;
    aicpuSqe.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    aicpusd_info("Notice TS pid response: device_id=%u pid=%u vf=%u.", deviceId, aicpuSqe.pid, aicpuSqe.vf_id);
    return ResponseToTs(aicpuSqe, 0U, deviceId, 0U);
}

void TsAicpuSqeAdapter::GetAicpuTimeOutConfigInfo(AicpuTimeOutConfigInfo& info) 
{
    aicpusd_info("Get timeout config.");
    info.i = aicpuSqe_.u.ts_to_aicpu_timeout_cfg;
    return;
}

int32_t TsAicpuSqeAdapter::AicpuTimeOutConfigResponseToTs(const int32_t result) 
{
    TsAicpuSqe aicpuSqe{};
    aicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    aicpuSqe.cmd_type = AICPU_TIMEOUT_CONFIG_RESPONSE;
    aicpuSqe.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    aicpuSqe.tid = tid_;
    aicpuSqe.ts_id = tsId_;
    aicpuSqe.u.aicpu_timeout_cfg_resp.result = result;
    aicpusd_info("Timeout config response: message_type=%u result=%u.", aicpuSqe.cmd_type, result);
    return ResponseToTs(aicpuSqe, 0U, AicpuDrvManager::GetInstance().GetDeviceId(), aicpuSqe.ts_id);
}

void TsAicpuSqeAdapter::GetAicpuInfoLoad(AicpuInfoLoad& info) 
{
    TsToAicpuInfoLoad tmpinfo = aicpuSqe_.u.ts_to_aicpu_info;
    aicpusd_info("Info load request: address=%p length=%u stream=%u task=%u",
        tmpinfo.aicpuInfoPtr,
        tmpinfo.length,
        tmpinfo.stream_id,
        tmpinfo.task_id);
    info.aicpuInfoPtr = tmpinfo.aicpuInfoPtr;
    info.length = tmpinfo.length;
    info.stream_id = tmpinfo.stream_id;
    info.task_id = tmpinfo.task_id;
}

int32_t TsAicpuSqeAdapter::AicpuInfoLoadResponseToTs(const int32_t result) 
{
    TsAicpuSqe aicpuSqe{};
    TsToAicpuInfoLoad tmpInfo = aicpuSqe_.u.ts_to_aicpu_info;
    aicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    aicpuSqe.tid = tid_;
    aicpuSqe.ts_id = tsId_;
    aicpuSqe.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    aicpuSqe.cmd_type = AICPU_INFO_LOAD_RESPONSE;
    aicpuSqe.u.aicpu_resp.cmd_type = AICPU_INFO_LOAD;
    aicpuSqe.u.aicpu_resp.task_id = tmpInfo.task_id;
    aicpuSqe.u.aicpu_resp.result_code = static_cast<uint16_t>(result);
    aicpuSqe.u.aicpu_resp.stream_id = tmpInfo.stream_id;
    aicpusd_info("Info load response: message_type=%u result=%u stream=%u task=%u.",
        aicpuSqe.cmd_type,
        result,
        tmpInfo.stream_id,
        tmpInfo.task_id);
    return ResponseToTs(aicpuSqe, 0U, AicpuDrvManager::GetInstance().GetDeviceId(), aicpuSqe.ts_id);
}

void TsAicpuSqeAdapter::GetAicErrReportInfo(AicErrReportInfo& info) 
{
    aicpusd_info("Get AIC error report info.");
    info.u.aicError = aicpuSqe_.u.ts_to_aicpu_aic_err_report;
    return;
}

int32_t TsAicpuSqeAdapter::AicpuRecordResponseToTs(AicpuRecordInfo& info) 
{
    TsAicpuSqe aicpuSqe;
    aicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    aicpuSqe.cmd_type = AICPU_RECORD;
    aicpuSqe.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    aicpuSqe.tid = 0U;  // notify is no need tid
    aicpuSqe.ts_id = info.ts_id;
    aicpuSqe.u.aicpu_record.record_type = info.record_type;
    aicpuSqe.u.aicpu_record.record_id = info.record_id;
    aicpuSqe.u.aicpu_record.fault_task_id = info.fault_task_id;
    aicpuSqe.u.aicpu_record.fault_stream_id = info.fault_stream_id;
    aicpuSqe.u.aicpu_record.ret_code = info.ret_code;
    const bool retSucc = info.ret_code == 0U ? true : false;
    aicpusd_info("Record response: pid=%u message_type=%u vf=%u tid=%u ts=%u record_type=%u "
                 "record_id=%u fault_task=%u fault_stream=%u result=%u",
        aicpuSqe.pid,
        aicpuSqe.cmd_type,
        aicpuSqe.vf_id,
        aicpuSqe.tid,
        aicpuSqe.ts_id,
        aicpuSqe.u.aicpu_record.record_type,
        aicpuSqe.u.aicpu_record.record_id,
        aicpuSqe.u.aicpu_record.fault_task_id,
        aicpuSqe.u.aicpu_record.fault_stream_id,
        aicpuSqe.u.aicpu_record.ret_code);
    if (!retSucc) {
        return ResponseToTs(aicpuSqe, 0U, info.dev_id, info.ts_id);
    }
    aicpusd_info("Record response: path=halTsDevRecord.");
    int32_t ret = halTsDevRecord(info.dev_id, info.ts_id, static_cast<uint32_t>(info.record_type), info.record_id);
    if (ret != static_cast<uint32_t>(DRV_ERROR_NONE)) {
        aicpusd_err(
            "Record notify failed: send_ret=%d notify_id=%u response_result=%d.", ret, info.record_id, info.ret_code);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    return AICPU_SCHEDULE_OK;
}
} // namespace AicpuSchedule
