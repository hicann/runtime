/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ts_aicpu_msg_info_adapter.h"
#include "aicpusd_event_manager.h"
#include "aicpusd_event_process.h"
#include "aicpusd_msg_send.h"
namespace AicpuSchedule {
TsAicpuMsgInfoAdapter::TsAicpuMsgInfoAdapter(const TsAicpuMsgInfo& msgInfo)
    : TsMsgAdapter(msgInfo.pid, msgInfo.cmd_type, msgInfo.vf_id, msgInfo.tid, msgInfo.ts_id),
      aicpuMsgInfo_(msgInfo),
      invalidMsgInfo_(false)
{
    aicpusd_info("Adapter initialized: message_format=msg_info.");
}

TsAicpuMsgInfoAdapter::TsAicpuMsgInfoAdapter() : aicpuMsgInfo_({}), invalidMsgInfo_(true)
{
    aicpusd_info("Adapter initialized: message_format=msg_info valid=false.");
}

bool TsAicpuMsgInfoAdapter::IsAdapterInvaildParameter() const
{
    return invalidMsgInfo_;
}

// dump
void TsAicpuMsgInfoAdapter::GetAicpuDataDumpInfo(AicpuDataDumpInfo& info)
{
    switch (cmdType_) {
        case TS_AICPU_DEBUG_DATADUMP_REPORT: {
            TsToAicpuDebugDataDumpMsg tmpInfo = aicpuMsgInfo_.u.ts_to_aicpu_debug_datadump;
            aicpusd_info(
                "Dump request(debug): dump_task=%u debug_dump_task=%u dump_stream=%u "
                "is_model=%u dump_type=%u reserved=%u.",
                tmpInfo.dump_task_id, tmpInfo.debug_dump_task_id, tmpInfo.dump_stream_id, tmpInfo.is_model,
                tmpInfo.dump_type, tmpInfo.rsv);
            info.is_debug = true;
            info.dump_task_id = tmpInfo.dump_task_id;
            info.dump_stream_id = INVALID_VALUE16;
            info.debug_dump_task_id = tmpInfo.debug_dump_task_id;
            info.debug_dump_stream_id = INVALID_VALUE16;
            info.is_model = (tmpInfo.is_model == 1);
            break;
        }
        case TS_AICPU_NORMAL_DATADUMP_REPORT: {
            TsToAicpuNormalDataDumpMsg tmpInfo = aicpuMsgInfo_.u.ts_to_aicpu_normal_datadump;
            aicpusd_info(
                "Dump request(normal): dump_task=%u dump_stream=%u is_model=%u dump_type=%u reserved=%u.",
                tmpInfo.dump_task_id, tmpInfo.dump_stream_id, tmpInfo.is_model, tmpInfo.dump_type, tmpInfo.rsv);
            info.is_debug = false;
            info.dump_task_id = tmpInfo.dump_task_id;
            info.dump_stream_id = INVALID_VALUE16;
            info.debug_dump_task_id = INVALID_VALUE32;
            info.debug_dump_stream_id = INVALID_VALUE16;
            info.is_model = (tmpInfo.is_model == 1);
            break;
        }
        default:
            aicpusd_err("Unsupported message type: message_type=%u", cmdType_);
    }
    info.file_name_stream_id = info.dump_stream_id;
    info.file_name_task_id = info.dump_task_id;
    return;
}

bool TsAicpuMsgInfoAdapter::IsOpMappingDumpTaskInfoVaild(const AicpuOpMappingDumpTaskInfo& info) const 
{
    return true;
}

void TsAicpuMsgInfoAdapter::GetAicpuDumpTaskInfo(AicpuOpMappingDumpTaskInfo& opmappingInfo, AicpuDumpTaskInfo& dumpTaskInfo) 
{
    aicpusd_info("Dump task mapping: proto_task=%u proto_stream=%u mapped_task=%u mapped_stream=%u",
        opmappingInfo.proto_info_task_id,
        opmappingInfo.proto_info_stream_id,
        opmappingInfo.task_id,
        opmappingInfo.stream_id);
    dumpTaskInfo.task_id = opmappingInfo.proto_info_task_id;
    dumpTaskInfo.stream_id = INVALID_VALUE16;
    dumpTaskInfo.context_id = INVALID_VALUE16;
    dumpTaskInfo.thread_id = INVALID_VALUE16;
}

void TsAicpuMsgInfoAdapter::GetAicpuDataDumpInfoLoad(AicpuDataDumpInfoLoad& info) 
{
    TsToAicpuDataDumpInfoloadMsg tmpinfo = aicpuMsgInfo_.u.ts_to_aicpu_datadump_info_load;
    aicpusd_info("Dump load request: address=%p length=%u task=%u stream=%u.",
        tmpinfo.dumpinfoPtr,
        tmpinfo.length,
        tmpinfo.task_id,
        tmpinfo.stream_id);
    info.dumpinfoPtr = tmpinfo.dumpinfoPtr;
    info.length = tmpinfo.length;
    info.task_id = tmpinfo.task_id;
    info.stream_id = tmpinfo.stream_id;
}
int32_t TsAicpuMsgInfoAdapter::AicpuDumpResponseToTs(const int32_t result) 
{
    TsAicpuMsgInfo msgInfo{};
    msgInfo.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    msgInfo.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    msgInfo.tid = tid_;
    msgInfo.ts_id = tsId_;
    msgInfo.cmd_type = cmdType_;
    msgInfo.u.aicpu_resp.result_code = static_cast<uint16_t>(result);
    switch (cmdType_) {
        case TS_AICPU_NORMAL_DATADUMP_REPORT: {
            TsToAicpuNormalDataDumpMsg tmpInfo = aicpuMsgInfo_.u.ts_to_aicpu_normal_datadump;
            msgInfo.u.aicpu_resp.task_id = tmpInfo.dump_task_id;
            msgInfo.u.aicpu_resp.stream_id = tmpInfo.dump_stream_id;
            msgInfo.u.aicpu_resp.reserved = tmpInfo.dump_type;
            break;
        }
        case TS_AICPU_DEBUG_DATADUMP_REPORT: {
            TsToAicpuDebugDataDumpMsg tmpInfo = aicpuMsgInfo_.u.ts_to_aicpu_debug_datadump;
            msgInfo.u.aicpu_resp.task_id = tmpInfo.debug_dump_task_id;
            msgInfo.u.aicpu_resp.stream_id = tmpInfo.dump_stream_id;
            msgInfo.u.aicpu_resp.reserved = tmpInfo.dump_type;
            break;
        }
        default: {
            aicpusd_err("Unsupported message type: message_type=%u", cmdType_);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
    }
    aicpusd_info("Dump response: message_type=%u result=%u task=%u stream=%u",
        cmdType_,
        msgInfo.u.aicpu_resp.result_code,
        msgInfo.u.aicpu_resp.task_id,
        msgInfo.u.aicpu_resp.stream_id);
    return ResponseToTs(msgInfo, 0U, AicpuDrvManager::GetInstance().GetDeviceId(), msgInfo.ts_id);
}
int32_t TsAicpuMsgInfoAdapter::AicpuDataDumpLoadResponseToTs(const int32_t result) 
{
    TsAicpuMsgInfo msgInfo{};
    msgInfo.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    msgInfo.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    msgInfo.tid = tid_;
    msgInfo.ts_id = tsId_;
    msgInfo.cmd_type = cmdType_;
    msgInfo.u.aicpu_resp.result_code = static_cast<uint16_t>(result);
    msgInfo.u.aicpu_resp.stream_id = aicpuMsgInfo_.u.ts_to_aicpu_datadump_info_load.stream_id;
    msgInfo.u.aicpu_resp.task_id = aicpuMsgInfo_.u.ts_to_aicpu_datadump_info_load.task_id;
    aicpusd_info("Dump load response: message_type=%u result=%u stream=%u task=%u.",
        msgInfo.cmd_type,
        result,
        msgInfo.u.aicpu_resp.stream_id,
        msgInfo.u.aicpu_resp.task_id);
    return ResponseToTs(msgInfo, 0U, AicpuDrvManager::GetInstance().GetDeviceId(), msgInfo.ts_id);
}

// model operator
void TsAicpuMsgInfoAdapter::GetAicpuModelOperateInfo(AicpuModelOperateInfo& info) 
{
    TsAicpuModelOperateMsg tmpInfo = aicpuMsgInfo_.u.aicpu_model_operate;
    aicpusd_info("Model operation request: argument=%p operation=%u model=%u.",
        tmpInfo.arg_ptr,
        tmpInfo.cmd_type,
        tmpInfo.model_id);
    info.arg_ptr = tmpInfo.arg_ptr;
    info.cmd_type = tmpInfo.cmd_type;
    info.model_id = tmpInfo.model_id;
    info.stream_id = tmpInfo.stream_id;
    info.task_id = INVALID_VALUE16;
    info.reserved[0] = tmpInfo.reserved[0];
    return;
}

int32_t TsAicpuMsgInfoAdapter::AicpuModelOperateResponseToTs(const int32_t result, const uint32_t subEvent) 
{
    TsAicpuMsgInfo aicpuMsgInfo = {};
    aicpuMsgInfo.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    aicpuMsgInfo.cmd_type = cmdType_;
    aicpuMsgInfo.vf_id = vfId_;
    aicpuMsgInfo.tid = tid_;
    aicpuMsgInfo.ts_id = tsId_;
    aicpuMsgInfo.u.aicpu_resp.result_code = static_cast<uint16_t>(result);
    aicpuMsgInfo.u.aicpu_resp.stream_id = INVALID_VALUE16;
    aicpuMsgInfo.u.aicpu_resp.task_id = INVALID_VALUE32;
    aicpuMsgInfo.u.aicpu_resp.reserved = 0;
    aicpusd_info("Model operation response: message_type=%u result=%u stream=%u task=%u",
        cmdType_,
        result,
        aicpuMsgInfo.u.aicpu_resp.stream_id,
        aicpuMsgInfo.u.aicpu_resp.task_id);
    hwts_response_t hwtsResp = {};
    hwtsResp.result = static_cast<uint32_t>(result);
    hwtsResp.status =
        (result == AICPU_SCHEDULE_OK) ? static_cast<uint32_t>(TASK_SUCC) : static_cast<uint32_t>(TASK_FAIL);
    hwtsResp.msg = PtrToPtr<TsAicpuMsgInfo, char_t>(&aicpuMsgInfo);
    hwtsResp.len = static_cast<int32_t>(sizeof(TsAicpuMsgInfo));
    return ResponseToTs(hwtsResp, AicpuDrvManager::GetInstance().GetDeviceId(), EVENT_TS_CTRL_MSG, subEvent);
}

void TsAicpuMsgInfoAdapter::AicpuActiveStreamSetMsg(ActiveStreamInfo& info) 
{
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    msgInfo.cmd_type = TS_AICPU_ACTIVE_STREAM;
    msgInfo.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    msgInfo.tid = 0U;  // no need tid
    msgInfo.ts_id = info.ts_id;
    msgInfo.u.aicpu_active_stream.aicpu_stamp = info.aicpu_stamp;
    msgInfo.u.aicpu_active_stream.stream_id = info.stream_id;
    aicpusd_info("Active stream update: message_type=%u stream=%u stamp=%u.",
        msgInfo.cmd_type,
        msgInfo.u.aicpu_active_stream.stream_id,
        msgInfo.u.aicpu_active_stream.aicpu_stamp);
    AicpuMsgSend::SetTsDevSendMsgAsync(info.device_id, info.ts_id, msgInfo, info.handle_id);
}

// version set
void TsAicpuMsgInfoAdapter::GetAicpuMsgVersionInfo(AicpuMsgVersionInfo& info) 
{
    (void)info;
    aicpusd_warn("Version update is not supported in current message format.");
    return;
}

int32_t TsAicpuMsgInfoAdapter::AicpuMsgVersionResponseToTs(const int32_t result) 
{
    (void)result;
    return AICPU_SCHEDULE_OK;
}

// task report
void TsAicpuMsgInfoAdapter::GetAicpuTaskReportInfo(AicpuTaskReportInfo& info) 
{
    TsToAicpuTaskReportMsg tmpInfo = aicpuMsgInfo_.u.ts_to_aicpu_task_report;
    aicpusd_info("Task report request: task=%u model=%u result=%u stream=%u",
        tmpInfo.task_id,
        tmpInfo.model_id,
        tmpInfo.result_code,
        tmpInfo.stream_id);
    info.task_id = tmpInfo.task_id;
    info.model_id = tmpInfo.model_id;
    info.result_code = tmpInfo.result_code;
    info.stream_id = tmpInfo.stream_id;
}

int32_t TsAicpuMsgInfoAdapter::ErrorMsgResponseToTs(ErrMsgRspInfo& rspInfo) 
{
    TsAicpuMsgInfo msgInfo{};
    msgInfo.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    msgInfo.cmd_type = cmdType_;
    msgInfo.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    msgInfo.tid = 0U;  // no need tid
    msgInfo.ts_id = static_cast<uint8_t>(rspInfo.ts_id);
    msgInfo.u.aicpu_resp.result_code = rspInfo.err_code;
    msgInfo.u.aicpu_resp.stream_id = static_cast<uint16_t>(rspInfo.stream_id);
    msgInfo.u.aicpu_resp.task_id = rspInfo.task_id;
    aicpusd_info("Error response: message_type=%u result=%u response_stream=%u response_task=%u",
        msgInfo.cmd_type,
        rspInfo.err_code,
        rspInfo.stream_id,
        rspInfo.task_id);
    return ResponseToTs(msgInfo, rspInfo.model_id, AicpuDrvManager::GetInstance().GetDeviceId(), msgInfo.ts_id);
}

// pid notice
int32_t TsAicpuMsgInfoAdapter::AicpuNoticeTsPidResponse(const uint32_t deviceId) const 
{
    TsAicpuSqe aicpuSqe = {};
    aicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());  // host pid
    aicpuSqe.cmd_type = AICPU_NOTICE_TS_PID;
    aicpuSqe.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    aicpusd_info("Notice TS pid response: device_id=%u pid=%u vf=%u.", deviceId, aicpuSqe.pid, aicpuSqe.vf_id);
    return ResponseToTs(aicpuSqe, 0U, deviceId, 0U);
}

// time out
void TsAicpuMsgInfoAdapter::GetAicpuTimeOutConfigInfo(AicpuTimeOutConfigInfo& info) 
{
    aicpusd_info("Get timeout config.");
    info.i = aicpuMsgInfo_.u.ts_to_aicpu_timeout_cfg;
    return;
}

int32_t TsAicpuMsgInfoAdapter::AicpuTimeOutConfigResponseToTs(const int32_t result) 
{
    TsAicpuMsgInfo msgInfo;
    msgInfo.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    msgInfo.cmd_type = cmdType_;
    msgInfo.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    msgInfo.tid = tid_;
    msgInfo.ts_id = tsId_;
    msgInfo.u.aicpu_resp.result_code = static_cast<uint16_t>(result);
    msgInfo.u.aicpu_resp.stream_id = INVALID_VALUE16;
    msgInfo.u.aicpu_resp.task_id = INVALID_VALUE32;
    aicpusd_info("Timeout config response: message_type=%u result=%u stream=%u task=%u.",
        msgInfo.cmd_type,
        msgInfo.u.aicpu_resp.result_code,
        msgInfo.u.aicpu_resp.stream_id,
        msgInfo.u.aicpu_resp.task_id);
    return ResponseToTs(msgInfo, 0U, AicpuDrvManager::GetInstance().GetDeviceId(), msgInfo.ts_id);
}

// info load
void TsAicpuMsgInfoAdapter::GetAicpuInfoLoad(AicpuInfoLoad& info) 
{
    TsToAicpuInfoLoadMsg tmpinfo = aicpuMsgInfo_.u.ts_to_aicpu_info_load;
    aicpusd_info("Info load request: address=%p length=%u stream=%u task=%u",
        tmpinfo.aicpu_info_ptr,
        tmpinfo.length,
        tmpinfo.stream_id,
        tmpinfo.task_id);
    info.aicpuInfoPtr = tmpinfo.aicpu_info_ptr;
    info.length = tmpinfo.length;
    info.stream_id = tmpinfo.stream_id;
    info.task_id = tmpinfo.task_id;
}

int32_t TsAicpuMsgInfoAdapter::AicpuInfoLoadResponseToTs(const int32_t result) 
{
    TsAicpuMsgInfo msgInfo{};
    TsToAicpuInfoLoadMsg tmpInfo = aicpuMsgInfo_.u.ts_to_aicpu_info_load;
    msgInfo.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    msgInfo.tid = tid_;
    msgInfo.ts_id = tsId_;
    msgInfo.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    msgInfo.cmd_type = cmdType_;
    msgInfo.u.aicpu_resp.stream_id = tmpInfo.stream_id;
    msgInfo.u.aicpu_resp.task_id = tmpInfo.task_id;
    msgInfo.u.aicpu_resp.result_code = static_cast<uint16_t>(result);
    msgInfo.u.aicpu_resp.reserved = 0;
    aicpusd_info("Info load response: message_type=%u result=%u stream=%u task=%u.",
        msgInfo.cmd_type,
        result,
        tmpInfo.stream_id,
        tmpInfo.task_id);
    return ResponseToTs(msgInfo, 0U, AicpuDrvManager::GetInstance().GetDeviceId(), msgInfo.ts_id);
}

// err report
void TsAicpuMsgInfoAdapter::GetAicErrReportInfo(AicErrReportInfo& info) 
{
    aicpusd_info("Get AIC error report.");
    info.u.aicErrorMsg = aicpuMsgInfo_.u.aic_err_msg;
    return;
}

// record
int32_t TsAicpuMsgInfoAdapter::AicpuRecordResponseToTs(AicpuRecordInfo& info) 
{
    TsAicpuMsgInfo msgInfo;
    msgInfo.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    msgInfo.cmd_type = TS_AICPU_RECORD;
    msgInfo.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    msgInfo.tid = 0U;  // notify is no need tid
    msgInfo.ts_id = info.ts_id;
    msgInfo.u.aicpu_record.record_id = info.record_id;
    msgInfo.u.aicpu_record.record_type = info.record_type;
    msgInfo.u.aicpu_record.ret_code = info.ret_code;
    msgInfo.u.aicpu_record.fault_task_id = info.fault_task_id;
    uint32_t handleId = info.ret_code == 0 ? MSG_EVENT_SUB_EVENTID_RECORD : 0U;
    aicpusd_info("Record response: pid=%u message_type=%u vf=%u tid=%u ts=%u record_type=%u "
                 "record_id=%u fault_task=%u result=%u handle=%u",
        msgInfo.pid,
        msgInfo.cmd_type,
        msgInfo.vf_id,
        msgInfo.tid,
        msgInfo.ts_id,
        msgInfo.u.aicpu_record.record_type,
        msgInfo.u.aicpu_record.record_id,
        msgInfo.u.aicpu_record.fault_task_id,
        msgInfo.u.aicpu_record.ret_code,
        handleId);
    return ResponseToTs(msgInfo, handleId, info.dev_id, msgInfo.ts_id);
}
} // namespace AicpuSchedule
