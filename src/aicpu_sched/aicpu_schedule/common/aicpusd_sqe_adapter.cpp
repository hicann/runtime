/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_sqe_adapter.h"
#include "aicpusd_msg_send.h"

namespace AicpuSchedule {
AicpuSqeAdapter::AicpuSqeAdapter(const TsAicpuSqe &sqe, const int16_t version)
    : pid_(sqe.pid), cmd_type_(sqe.cmd_type), vf_id_(sqe.vf_id), tid_(sqe.tid), ts_id_(sqe.ts_id), sqe_(sqe),
      version_(version), invalid_sqe_(false)
{
    aicpusd_info("Enter AicpuSqeAdapter constructor, using TsAicpuSqe init, pid[%u], cmd_type[%u], vf id[%u],"
                 "tid[%u], ts id[%u], version[%hu]",
        pid_,
        cmd_type_,
        vf_id_,
        tid_,
        ts_id_,
        version_);
    InitAdapterFuncMap();
}

AicpuSqeAdapter::AicpuSqeAdapter(const TsAicpuMsgInfo &msgInfo, const int16_t version)
    : pid_(msgInfo.pid), cmd_type_(msgInfo.cmd_type), vf_id_(msgInfo.vf_id), tid_(msgInfo.tid), ts_id_(msgInfo.ts_id),
      msg_Info_(msgInfo), version_(version), invalid_msg_info_(false)
{
    aicpusd_info("Enter AicpuSqeAdapter constructor, using TsAicpuMsgInfo init, pid[%u], cmd_type[%u], vf id[%u],"
                 "tid[%u], ts id[%u], version[%hu]",
        pid_,
        cmd_type_,
        vf_id_,
        tid_,
        ts_id_,
        version_);
    InitAdapterFuncMap();
}

AicpuSqeAdapter::AicpuSqeAdapter(const int16_t version) : version_(version), invalid_msg_info_(true), invalid_sqe_(true)
{
    aicpusd_info("Enter AicpuSqeAdapter constructor,  using version init, version[%hu]", version_);
    InitAdapterFuncMap();
}

uint8_t AicpuSqeAdapter::GetCmdType() const
{
    return cmd_type_;
}

bool AicpuSqeAdapter::IsAdapterInvalidParameter() const
{
    return invalid_sqe_ && invalid_msg_info_;
}

bool AicpuSqeAdapter::IsOpMappingDumpTaskInfoVaild(const AicpuOpMappingDumpTaskInfo &info) const
{
    if (version_ == VERSION_0) {
        bool isOutOfRange = (info.proto_info_task_id > INVALID_VALUE16) ||
                            (info.proto_info_stream_id > INVALID_VALUE16) || (info.stream_id > INVALID_VALUE16) ||
                            (info.task_id > INVALID_VALUE16);
        return !isOutOfRange;
    }
    return true;
}

void AicpuSqeAdapter::InitAdapterFuncMap()
{
    getModelOperateInfoFuncMap_[VERSION_0] = &AicpuSqeAdapter::GetAicpuModelOperateInfoV0;
    getModelOperateInfoFuncMap_[VERSION_1] = &AicpuSqeAdapter::GetAicpuModelOperateInfoV1;

    getModelOperateRspFuncMap_[VERSION_0] = &AicpuSqeAdapter::AicpuModelOperateResponseToTsV0;
    getModelOperateRspFuncMap_[VERSION_1] = &AicpuSqeAdapter::AicpuModelOperateResponseToTsV1;

    getDataDumpInfoFuncMap_[VERSION_0] = &AicpuSqeAdapter::GetAicpuDataDumpInfoV0;
    getDataDumpInfoFuncMap_[VERSION_1] = &AicpuSqeAdapter::GetAicpuDataDumpInfoV1;

    getDataDumpRspFuncMap_[VERSION_0] = &AicpuSqeAdapter::AicpuDumpResponseToTsV0;
    getDataDumpRspFuncMap_[VERSION_1] = &AicpuSqeAdapter::AicpuDumpResponseToTsV1;

    getDataDumpLoadInfoFuncMap_[VERSION_0] = &AicpuSqeAdapter::GetAicpuDataDumpInfoLoadV0;
    getDataDumpLoadInfoFuncMap_[VERSION_1] = &AicpuSqeAdapter::GetAicpuDataDumpInfoLoadV1;

    getDataDumpLoadRspFuncMap_[VERSION_0] = &AicpuSqeAdapter::AicpuDataDumpLoadResponseToTsV0;
    getDataDumpLoadRspFuncMap_[VERSION_1] = &AicpuSqeAdapter::AicpuDataDumpLoadResponseToTsV1;

    getTaskReportInfoFuncMap_[VERSION_0] = &AicpuSqeAdapter::GetAicpuTaskReportInfoV0;
    getTaskReportInfoFuncMap_[VERSION_1] = &AicpuSqeAdapter::GetAicpuTaskReportInfoV1;

    getErrorMsgRspFuncMap_[VERSION_0] = &AicpuSqeAdapter::ErrorMsgResponseToTsV0;
    getErrorMsgRspFuncMap_[VERSION_1] = &AicpuSqeAdapter::ErrorMsgResponseToTsV1;

    getTimeOutConfigRspFuncMap_[VERSION_0] = &AicpuSqeAdapter::AicpuTimeOutConfigResponseToTsV0;
    getTimeOutConfigRspFuncMap_[VERSION_1] = &AicpuSqeAdapter::AicpuTimeOutConfigResponseToTsV1;

    getLoadInfoFuncMap_[VERSION_0] = &AicpuSqeAdapter::GetAicpuInfoLoadV0;
    getLoadInfoFuncMap_[VERSION_1] = &AicpuSqeAdapter::GetAicpuInfoLoadV1;

    getInfoLoadRspFuncMap_[VERSION_0] = &AicpuSqeAdapter::AicpuInfoLoadResponseToTsV0;
    getInfoLoadRspFuncMap_[VERSION_1] = &AicpuSqeAdapter::AicpuInfoLoadResponseToTsV1;

    getDumpTaskInfoFuncMap_[VERSION_0] = &AicpuSqeAdapter::GetAicpuDumpTaskInfoV0;
    getDumpTaskInfoFuncMap_[VERSION_1] = &AicpuSqeAdapter::GetAicpuDumpTaskInfoV1;

    getRecordRspFuncMap_[VERSION_0] = &AicpuSqeAdapter::AicpuRecordResponseToTsV0;
    getRecordRspFuncMap_[VERSION_1] = &AicpuSqeAdapter::AicpuRecordResponseToTsV1;

    activeStreamSetMsgFuncMap_[VERSION_0] = &AicpuSqeAdapter::AicpuActiveStreamSetMsgV0;
    activeStreamSetMsgFuncMap_[VERSION_1] = &AicpuSqeAdapter::AicpuActiveStreamSetMsgV1;

    getAicErrReportInfoFuncMap_[VERSION_0] = &AicpuSqeAdapter::GetAicErrReportInfoV0;
    getAicErrReportInfoFuncMap_[VERSION_1] = &AicpuSqeAdapter::GetAicErrReportInfoV1;
}

void AicpuSqeAdapter::GetAicpuMsgVersionInfo(AicpuMsgVersionInfo &info)
{
    TsAicpuMsgVersion tmpInfo = sqe_.u.aicpu_msg_version;
    aicpusd_info("Get msg version msg: magic num[%u], version[%hu].", tmpInfo.magic_num, tmpInfo.version);
    info.magic_num = tmpInfo.magic_num;
    info.version = tmpInfo.version;
}

int32_t AicpuSqeAdapter::AicpuMsgVersionResponseToTs(const int32_t ret)
{
    TsAicpuMsgInfo msgInfo{};
    msgInfo.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    msgInfo.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    msgInfo.tid = tid_;
    msgInfo.ts_id = ts_id_;
    msgInfo.cmd_type = cmd_type_;
    msgInfo.u.aicpu_resp.result_code = static_cast<uint16_t>(ret);
    msgInfo.u.aicpu_resp.task_id = INVALID_VALUE32;
    aicpusd_info("Msg version response info: cmd_type[%u], ret code[%u], stream id[%u], task id[%u].",
        msgInfo.cmd_type,
        msgInfo.u.aicpu_resp.result_code,
        msgInfo.u.aicpu_resp.stream_id,
        msgInfo.u.aicpu_resp.task_id);
    return ResponseToTs(msgInfo, 0U, AicpuDrvManager::GetInstance().GetDeviceId(), msgInfo.ts_id);
}

void AicpuSqeAdapter::GetAicpuModelOperateInfo(AicpuModelOperateInfo &info)
{
    if (getModelOperateInfoFuncMap_.find(version_) == getModelOperateInfoFuncMap_.end()) {
        aicpusd_err("The version[%hu] does not have a corresponding get model operate info Function.", version_);
        return;
    }
    (this->*getModelOperateInfoFuncMap_[version_])(info);
    return;
}

void AicpuSqeAdapter::GetAicpuModelOperateInfoV0(AicpuModelOperateInfo &info)
{
    TsAicpuModelOperate tmpInfo = sqe_.u.aicpu_model_operate;
    aicpusd_info("Aicpu model operator info: arg_ptr[%p], cmd_type[%u], model_id[%u], task_id[%u].",
        tmpInfo.arg_ptr,
        tmpInfo.cmd_type,
        tmpInfo.model_id,
        tmpInfo.task_id);
    info.arg_ptr = tmpInfo.arg_ptr;
    info.cmd_type = tmpInfo.cmd_type;
    info.model_id = tmpInfo.model_id;
    info.stream_id = tmpInfo.sq_id;  // sq_id in rts acturally is stream id
    info.task_id = tmpInfo.task_id;
    info.reserved[0] = tmpInfo.reserved;
    return;
}

void AicpuSqeAdapter::GetAicpuModelOperateInfoV1(AicpuModelOperateInfo &info)
{
    TsAicpuModelOperateMsg tmpInfo = msg_Info_.u.aicpu_model_operate;
    aicpusd_info("Aicpu model operator info: arg_ptr[%p], cmd_type[%u], model_id[%u].",
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

int32_t AicpuSqeAdapter::AicpuModelOperateResponseToTs(const int32_t ret, const uint32_t subEvent)
{
    if (getModelOperateRspFuncMap_.find(version_) == getModelOperateRspFuncMap_.end()) {
        aicpusd_err("The version[%hu] does not have a corresponding get model operate response function.", version_);
        return AICPU_SCHEDULE_ERROR_NOT_FOUND_FUNCTION;
    }
    return (this->*getModelOperateRspFuncMap_[version_])(ret, subEvent);
}

int32_t AicpuSqeAdapter::AicpuModelOperateResponseToTsV0(const int32_t ret, const uint32_t subEvent)
{
    TsAicpuModelOperate tmpInfo = sqe_.u.aicpu_model_operate;
    TsAicpuSqe aicpuSqe = {};
    aicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    aicpuSqe.cmd_type = AICPU_MODEL_OPERATE_RESPONSE;
    aicpuSqe.vf_id = vf_id_;
    aicpuSqe.tid = tid_;
    aicpuSqe.ts_id = ts_id_;
    aicpuSqe.u.aicpu_model_operate_resp.cmd_type = AICPU_MODEL_OPERATE;
    aicpuSqe.u.aicpu_model_operate_resp.sub_cmd_type = tmpInfo.cmd_type;
    aicpuSqe.u.aicpu_model_operate_resp.model_id = tmpInfo.model_id;
    aicpuSqe.u.aicpu_model_operate_resp.result_code = static_cast<uint16_t>(ret);
    aicpuSqe.u.aicpu_model_operate_resp.task_id = tmpInfo.task_id;
    aicpuSqe.u.aicpu_model_operate_resp.sq_id = tmpInfo.sq_id;
    aicpusd_info("Aicpu model operate response info: cmd_type[%u], ret[%u]", cmd_type_, ret);
    hwts_response_t hwtsResp = {};
    hwtsResp.result = static_cast<uint32_t>(ret);
    hwtsResp.status = (ret == AICPU_SCHEDULE_OK) ? static_cast<uint32_t>(TASK_SUCC) : static_cast<uint32_t>(TASK_FAIL);
    hwtsResp.msg = PtrToPtr<TsAicpuSqe, char_t>(&aicpuSqe);
    hwtsResp.len = static_cast<int32_t>(sizeof(TsAicpuSqe));
    return ResponseToTs(hwtsResp, AicpuDrvManager::GetInstance().GetDeviceId(), EVENT_TS_CTRL_MSG, subEvent);
}

int32_t AicpuSqeAdapter::AicpuModelOperateResponseToTsV1(const int32_t ret, const uint32_t subEvent)
{
    TsAicpuMsgInfo aicpuMsgInfo = {};
    aicpuMsgInfo.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    aicpuMsgInfo.cmd_type = cmd_type_;
    aicpuMsgInfo.vf_id = vf_id_;
    aicpuMsgInfo.tid = tid_;
    aicpuMsgInfo.ts_id = ts_id_;
    aicpuMsgInfo.u.aicpu_resp.result_code = static_cast<uint16_t>(ret);
    aicpuMsgInfo.u.aicpu_resp.stream_id = INVALID_VALUE16;
    aicpuMsgInfo.u.aicpu_resp.task_id = INVALID_VALUE32;
    aicpuMsgInfo.u.aicpu_resp.reserved = 0;
    aicpusd_info("Aicpu model operate response info: cmd_type[%u], ret[%u], stream_id[%u], task_id[%u]",
        cmd_type_,
        ret,
        aicpuMsgInfo.u.aicpu_resp.stream_id,
        aicpuMsgInfo.u.aicpu_resp.task_id);
    hwts_response_t hwtsResp = {};
    hwtsResp.result = static_cast<uint32_t>(ret);
    hwtsResp.status = (ret == AICPU_SCHEDULE_OK) ? static_cast<uint32_t>(TASK_SUCC) : static_cast<uint32_t>(TASK_FAIL);
    hwtsResp.msg = PtrToPtr<TsAicpuMsgInfo, char_t>(&aicpuMsgInfo);
    hwtsResp.len = static_cast<int32_t>(sizeof(TsAicpuMsgInfo));
    return ResponseToTs(hwtsResp, AicpuDrvManager::GetInstance().GetDeviceId(), EVENT_TS_CTRL_MSG, subEvent);
}

void AicpuSqeAdapter::GetAicpuTaskReportInfoV0(AicpuTaskReportInfo &info)
{
    TsToAicpuTaskReport tmpInfo = sqe_.u.ts_to_aicpu_task_report;
    aicpusd_info("Get aicpu task report info: task_id[%u], model_id[%u], result_code[%u], stream_id[%u]",
        tmpInfo.task_id,
        tmpInfo.model_id,
        tmpInfo.result_code,
        tmpInfo.stream_id);
    info.task_id = tmpInfo.task_id;
    info.model_id = tmpInfo.model_id;
    info.result_code = tmpInfo.result_code;
    info.stream_id = tmpInfo.stream_id;
}

void AicpuSqeAdapter::GetAicpuTaskReportInfoV1(AicpuTaskReportInfo &info)
{
    TsToAicpuTaskReportMsg tmpInfo = msg_Info_.u.ts_to_aicpu_task_report;
    aicpusd_info("Get aicpu task report info: task_id[%u], model_id[%u], result_code[%u], stream_id[%u]",
        tmpInfo.task_id,
        tmpInfo.model_id,
        tmpInfo.result_code,
        tmpInfo.stream_id);
    info.task_id = tmpInfo.task_id;
    info.model_id = tmpInfo.model_id;
    info.result_code = tmpInfo.result_code;
    info.stream_id = tmpInfo.stream_id;
}

void AicpuSqeAdapter::GetAicpuTaskReportInfo(AicpuTaskReportInfo &info)
{
    if (getTaskReportInfoFuncMap_.find(version_) == getTaskReportInfoFuncMap_.end()) {
        aicpusd_err("The version[%hu] does not have a corresponding get task report function.", version_);
        return;
    }
    (this->*getTaskReportInfoFuncMap_[version_])(info);
    return;
}

void AicpuSqeAdapter::GetAicpuDumpTaskInfoV0(AicpuOpMappingDumpTaskInfo &opmappingInfo, AicpuDumpTaskInfo &dumpTaskInfo)
{
    opmappingInfo.proto_info_task_id &= 0xFFFF;
    aicpusd_info("Dump data from proto: task id[%u], stream id[%u], form adaper: task id[%u], stream id[%u]",
        opmappingInfo.proto_info_task_id,
        opmappingInfo.proto_info_stream_id,
        opmappingInfo.task_id,
        opmappingInfo.stream_id);
    dumpTaskInfo.task_id =
        opmappingInfo.proto_info_task_id == INVALID_VALUE16 ? opmappingInfo.task_id : opmappingInfo.proto_info_task_id;
    dumpTaskInfo.stream_id = opmappingInfo.proto_info_stream_id == INVALID_VALUE16 ? opmappingInfo.stream_id
                                                                                   : opmappingInfo.proto_info_stream_id;
    dumpTaskInfo.context_id = INVALID_VALUE16;
    dumpTaskInfo.thread_id = INVALID_VALUE16;
}

void AicpuSqeAdapter::GetAicpuDumpTaskInfoV1(AicpuOpMappingDumpTaskInfo &opmappingInfo, AicpuDumpTaskInfo &dumpTaskInfo)
{
    aicpusd_info("Dump data from proto: task id[%u], stream id[%u], form adaper: task id[%u], stream id[%u]",
        opmappingInfo.proto_info_task_id,
        opmappingInfo.proto_info_stream_id,
        opmappingInfo.task_id,
        opmappingInfo.stream_id);
    dumpTaskInfo.task_id = opmappingInfo.proto_info_task_id;
    dumpTaskInfo.stream_id = INVALID_VALUE16;
    dumpTaskInfo.context_id = INVALID_VALUE16;
    dumpTaskInfo.thread_id = INVALID_VALUE16;
}

void AicpuSqeAdapter::GetAicpuDumpTaskInfo(AicpuOpMappingDumpTaskInfo &opmappingInfo, AicpuDumpTaskInfo &dumpTaskInfo)
{
    if (getDumpTaskInfoFuncMap_.find(version_) == getDumpTaskInfoFuncMap_.end()) {
        aicpusd_err("The version[%hu] does not have a corresponding get dump task info function.", version_);
        return;
    }
    (this->*getDumpTaskInfoFuncMap_[version_])(opmappingInfo, dumpTaskInfo);
}

void AicpuSqeAdapter::GetAicpuDataDumpInfoV1(AicpuDataDumpInfo &info)
{
    switch (cmd_type_) {
        case TS_AICPU_DEBUG_DATADUMP_REPORT: {
            TsToAicpuDebugDataDumpMsg tmpInfo = msg_Info_.u.ts_to_aicpu_debug_datadump;
            aicpusd_info("Debug data dump info : dump_task_id[%u], debug_dump_task_id[%u], dump_stream_id[%u],"
                         "is_model[%u], dumptype[%u], reserved[%u].",
                tmpInfo.dump_task_id,
                tmpInfo.debug_dump_task_id,
                tmpInfo.dump_stream_id,
                tmpInfo.is_model,
                tmpInfo.dump_type,
                tmpInfo.rsv);
            info.is_debug = true;
            info.dump_task_id = tmpInfo.dump_task_id;
            info.dump_stream_id = INVALID_VALUE16;
            info.debug_dump_task_id = tmpInfo.debug_dump_task_id;
            info.debug_dump_stream_id = INVALID_VALUE16;
            info.is_model = (tmpInfo.is_model == 1);
            break;
        }
        case TS_AICPU_NORMAL_DATADUMP_REPORT: {
            TsToAicpuNormalDataDumpMsg tmpInfo = msg_Info_.u.ts_to_aicpu_normal_datadump;
            aicpusd_info("Data dump info : dump_task_id[%u], dump_stream_id[%u],"
                         "is_model[%u], dumptype[%u], reserved[%u].",
                tmpInfo.dump_task_id,
                tmpInfo.dump_stream_id,
                tmpInfo.is_model,
                tmpInfo.dump_type,
                tmpInfo.rsv);
            info.is_debug = false;
            info.dump_task_id = tmpInfo.dump_task_id;
            info.dump_stream_id = INVALID_VALUE16;
            info.debug_dump_task_id = INVALID_VALUE32;
            info.debug_dump_stream_id = INVALID_VALUE16;
            info.is_model = (tmpInfo.is_model == 1);
            break;
        }
        default:
            aicpusd_err("The cmd type not found, cmd type[%u], Version[%d]", cmd_type_, version_);
    }
    info.file_name_stream_id = info.dump_stream_id;
    info.file_name_task_id = info.dump_task_id;
    return;
}

void AicpuSqeAdapter::GetAicpuDataDumpInfoV0(AicpuDataDumpInfo &info)
{
    TsToAicpuDataDump tmpInfo = sqe_.u.ts_to_aicpu_datadump;
    aicpusd_info("Data dump info: model_id[%u], stream_id[%u], task_id[%u], stream_id1[%u], task_id1[%u],"
                 "ack_stream_id[%u], ack_task_id[%u].",
        tmpInfo.model_id,
        tmpInfo.stream_id,
        tmpInfo.task_id,
        tmpInfo.stream_id1,
        tmpInfo.task_id1,
        tmpInfo.ack_stream_id,
        tmpInfo.ack_task_id);
    info.dump_task_id = tmpInfo.task_id;
    info.dump_stream_id = tmpInfo.stream_id;
    info.debug_dump_task_id = tmpInfo.task_id1;
    info.debug_dump_stream_id = tmpInfo.stream_id1;
    info.is_model = (tmpInfo.model_id != INVALID_VALUE16);
    info.is_debug = ((tmpInfo.task_id1 != INVALID_VALUE16) && (tmpInfo.stream_id1 != INVALID_VALUE16));
    info.file_name_stream_id = info.is_debug ? tmpInfo.stream_id1 : tmpInfo.stream_id;
    info.file_name_task_id = info.is_debug ? tmpInfo.task_id1 : tmpInfo.task_id;
}

void AicpuSqeAdapter::GetAicpuDataDumpInfo(AicpuDataDumpInfo &info)
{
    aicpusd_info("Get aicpu  datadump Info.");
    if (getDataDumpInfoFuncMap_.find(version_) == getDataDumpInfoFuncMap_.end()) {
        aicpusd_err("The version[%hu] does not have a corresponding get data dump info Function.", version_);
        return;
    }
    (this->*getDataDumpInfoFuncMap_[version_])(info);
    return;
}

int32_t AicpuSqeAdapter::AicpuDumpResponseToTsV1(const int32_t ret)
{
    TsAicpuMsgInfo msgInfo{};
    msgInfo.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    msgInfo.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    msgInfo.tid = tid_;
    msgInfo.ts_id = ts_id_;
    msgInfo.cmd_type = cmd_type_;
    msgInfo.u.aicpu_resp.result_code = static_cast<uint16_t>(ret);
    switch (cmd_type_) {
        case TS_AICPU_NORMAL_DATADUMP_REPORT: {
            TsToAicpuNormalDataDumpMsg tmpInfo = msg_Info_.u.ts_to_aicpu_normal_datadump;
            msgInfo.u.aicpu_resp.task_id = tmpInfo.dump_task_id;
            msgInfo.u.aicpu_resp.stream_id = tmpInfo.dump_stream_id;
            msgInfo.u.aicpu_resp.reserved = tmpInfo.dump_type;
            break;
        }
        case TS_AICPU_DEBUG_DATADUMP_REPORT: {
            TsToAicpuDebugDataDumpMsg tmpInfo = msg_Info_.u.ts_to_aicpu_debug_datadump;
            msgInfo.u.aicpu_resp.task_id = tmpInfo.debug_dump_task_id;
            msgInfo.u.aicpu_resp.stream_id = tmpInfo.dump_stream_id;
            msgInfo.u.aicpu_resp.reserved = tmpInfo.dump_type;
            break;
        }
        default: {
            aicpusd_err("The cmd type not found, cmd type[%u], Version[%u]", cmd_type_, version_);
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
    }
    aicpusd_info("Aicpu dump response info: cmd_type[%u], ret[%u], task_id[%u], stream_id[%u]",
        cmd_type_,
        msgInfo.u.aicpu_resp.result_code,
        msgInfo.u.aicpu_resp.task_id,
        msgInfo.u.aicpu_resp.stream_id);
    return ResponseToTs(msgInfo, 0U, AicpuDrvManager::GetInstance().GetDeviceId(), msgInfo.ts_id);
}

int32_t AicpuSqeAdapter::AicpuDumpResponseToTsV0(const int32_t ret)
{
    TsAicpuSqe aicpuSqe{};
    aicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    aicpuSqe.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    aicpuSqe.tid = tid_;
    aicpuSqe.ts_id = ts_id_;
    aicpuSqe.cmd_type = AICPU_DATADUMP_RESPONSE;
    aicpuSqe.u.aicpu_dump_resp.result_code = static_cast<uint16_t>(ret);
    aicpuSqe.u.aicpu_dump_resp.cmd_type = AICPU_DATADUMP_REPORT;
    uint32_t handleId = 0U;
    if (cmd_type_ == AICPU_FFTS_PLUS_DATADUMP_REPORT) {
        aicpusd_info("Ffts plus dump response.");
        TsToAicpuFFTSPlusDataDump info = sqe_.u.ts_to_aicpu_ffts_plus_datadump;
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
        aicpuSqe.u.aicpu_dump_resp.task_id = sqe_.u.ts_to_aicpu_datadump.ack_task_id;
        aicpuSqe.u.aicpu_dump_resp.stream_id = sqe_.u.ts_to_aicpu_datadump.ack_stream_id;
        aicpuSqe.u.aicpu_dump_resp.reserved = sqe_.u.ts_to_aicpu_datadump.reserved[0];
        handleId = sqe_.u.ts_to_aicpu_datadump.model_id;
    }
    aicpusd_info("Aicpu dump response info: cmd_type[%u], ret[%u], ack_stream_id[%u], ack_task_id[%u].",
        aicpuSqe.cmd_type,
        ret,
        aicpuSqe.u.aicpu_dump_resp.stream_id,
        aicpuSqe.u.aicpu_dump_resp.task_id);
    return ResponseToTs(aicpuSqe, handleId, AicpuDrvManager::GetInstance().GetDeviceId(), aicpuSqe.ts_id);
}

int32_t AicpuSqeAdapter::AicpuDumpResponseToTs(const int32_t ret)
{
    aicpusd_info("Aicpu dump response to ts.");
    if (getDataDumpRspFuncMap_.find(version_) == getDataDumpRspFuncMap_.end()) {
        aicpusd_err("The version[%hu] does not have a corresponding get data dump respone Function.", version_);
        return AICPU_SCHEDULE_ERROR_NOT_FOUND_FUNCTION;
    }
    return (this->*getDataDumpRspFuncMap_[version_])(ret);
}

void AicpuSqeAdapter::GetAicpuDumpFFTSPlusDataInfo(AicpuDumpFFTSPlusDataInfo &info)
{
    aicpusd_info("Get aicpu dump FFTSPlus data Info.");
    info.i = sqe_.u.ts_to_aicpu_ffts_plus_datadump;
    return;
}

void AicpuSqeAdapter::GetAicpuDataDumpInfoLoadV0(AicpuDataDumpInfoLoad &info)
{
    TsToAicpuDataDumpInfoLoad tmpinfo = sqe_.u.ts_to_aicpu_datadumploadinfo;
    aicpusd_info("Get aicpu data dump load info: dumpinfoPtr[%p], length[%u], task_id[%u],stream_id[%u].",
        tmpinfo.dumpinfoPtr,
        tmpinfo.length,
        tmpinfo.task_id,
        tmpinfo.stream_id);
    info.dumpinfoPtr = tmpinfo.dumpinfoPtr;
    info.length = tmpinfo.length;
    info.task_id = tmpinfo.task_id;
    info.stream_id = tmpinfo.stream_id;
}

void AicpuSqeAdapter::GetAicpuDataDumpInfoLoadV1(AicpuDataDumpInfoLoad &info)
{
    TsToAicpuDataDumpInfoloadMsg tmpinfo = msg_Info_.u.ts_to_aicpu_datadump_info_load;
    aicpusd_info("Get aicpu data dump load info: dumpinfoPtr[%p], length[%u], task_id[%u],stream_id[%u].",
        tmpinfo.dumpinfoPtr,
        tmpinfo.length,
        tmpinfo.task_id,
        tmpinfo.stream_id);
    info.dumpinfoPtr = tmpinfo.dumpinfoPtr;
    info.length = tmpinfo.length;
    info.task_id = tmpinfo.task_id;
    info.stream_id = tmpinfo.stream_id;
}

void AicpuSqeAdapter::GetAicpuDataDumpInfoLoad(AicpuDataDumpInfoLoad &info)
{
    aicpusd_info("Get aicpu datadump Info load.");
    if (getDataDumpLoadInfoFuncMap_.find(version_) == getDataDumpLoadInfoFuncMap_.end()) {
        aicpusd_err("The version[%hu] does not have a corresponding get data dump load info Function.", version_);
        return;
    }
    (this->*getDataDumpLoadInfoFuncMap_[version_])(info);
    return;
}

int32_t AicpuSqeAdapter::AicpuDataDumpLoadResponseToTsV1(const int32_t ret)
{
    TsAicpuMsgInfo msgInfo{};
    msgInfo.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    msgInfo.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    msgInfo.tid = tid_;
    msgInfo.ts_id = ts_id_;
    msgInfo.cmd_type = cmd_type_;
    msgInfo.u.aicpu_resp.result_code = static_cast<uint16_t>(ret);
    msgInfo.u.aicpu_resp.stream_id = msg_Info_.u.ts_to_aicpu_datadump_info_load.stream_id;
    msgInfo.u.aicpu_resp.task_id = msg_Info_.u.ts_to_aicpu_datadump_info_load.task_id;
    aicpusd_info("Aicpu data dump load response info: cmd_type[%u], ret[%u], streamid[%u], taskid[%u].",
        msgInfo.cmd_type,
        ret,
        msgInfo.u.aicpu_resp.stream_id,
        msgInfo.u.aicpu_resp.task_id);
    return ResponseToTs(msgInfo, 0U, AicpuDrvManager::GetInstance().GetDeviceId(), msgInfo.ts_id);
}

int32_t AicpuSqeAdapter::AicpuDataDumpLoadResponseToTsV0(const int32_t ret)
{
    TsAicpuSqe aicpuSqe{};
    aicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    aicpuSqe.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    aicpuSqe.tid = tid_;
    aicpuSqe.ts_id = ts_id_;
    aicpuSqe.cmd_type = AICPU_DATADUMP_RESPONSE;
    aicpuSqe.u.aicpu_dump_resp.result_code = static_cast<uint16_t>(ret);
    aicpuSqe.u.aicpu_dump_resp.cmd_type = AICPU_DATADUMP_LOADINFO;
    aicpuSqe.u.aicpu_dump_resp.task_id = sqe_.u.ts_to_aicpu_datadumploadinfo.task_id;
    aicpuSqe.u.aicpu_dump_resp.stream_id = sqe_.u.ts_to_aicpu_datadumploadinfo.stream_id;
    aicpuSqe.u.aicpu_dump_resp.reserved = STARS_DATADUMP_LOAD_INFO;
    aicpusd_info("Aicpu data dump load response info: cmd_type[%u], ret[%u], streamid[%u], taskid[%u].",
        aicpuSqe.cmd_type,
        ret,
        aicpuSqe.u.aicpu_dump_resp.stream_id,
        aicpuSqe.u.aicpu_dump_resp.task_id);
    return ResponseToTs(aicpuSqe, 0U, AicpuDrvManager::GetInstance().GetDeviceId(), aicpuSqe.ts_id);
}

int32_t AicpuSqeAdapter::AicpuDataDumpLoadResponseToTs(const int32_t ret)
{
    aicpusd_info("Aicpu datadump load response to ts.");
    if (getDataDumpLoadRspFuncMap_.find(version_) == getDataDumpLoadRspFuncMap_.end()) {
        aicpusd_err("The version[%hu] does not have a corresponding get data dump load respone Function.", version_);
        return AICPU_SCHEDULE_ERROR_NOT_FOUND_FUNCTION;
    }
    return (this->*getDataDumpLoadRspFuncMap_[version_])(ret);
}

void AicpuSqeAdapter::GetAicpuTimeOutConfigInfo(AicpuTimeOutConfigInfo &info)
{
    aicpusd_info("Get aicpu timeout config Info.");
    if (version_ == 1) {
        info.i = msg_Info_.u.ts_to_aicpu_timeout_cfg;
    } else {
        info.i = sqe_.u.ts_to_aicpu_timeout_cfg;
    }
    return;
}

void AicpuSqeAdapter::GetAicpuInfoLoadV0(AicpuInfoLoad &info)
{
    TsToAicpuInfoLoad tmpinfo = sqe_.u.ts_to_aicpu_info;
    aicpusd_info("Get aicpu info: aicpuInfoPtr[%p], length[%u], stream_id[%u], task_id[%u]",
        tmpinfo.aicpuInfoPtr,
        tmpinfo.length,
        tmpinfo.stream_id,
        tmpinfo.task_id);
    info.aicpuInfoPtr = tmpinfo.aicpuInfoPtr;
    info.length = tmpinfo.length;
    info.stream_id = tmpinfo.stream_id;
    info.task_id = tmpinfo.task_id;
}

void AicpuSqeAdapter::GetAicpuInfoLoadV1(AicpuInfoLoad &info)
{
    TsToAicpuInfoLoadMsg tmpinfo = msg_Info_.u.ts_to_aicpu_info_load;
    aicpusd_info("Get aicpu common info: aicpuInfoPtr[%p], length[%u], stream_id[%u], task_id[%u]",
        tmpinfo.aicpu_info_ptr,
        tmpinfo.length,
        tmpinfo.stream_id,
        tmpinfo.task_id);
    info.aicpuInfoPtr = tmpinfo.aicpu_info_ptr;
    info.length = tmpinfo.length;
    info.stream_id = tmpinfo.stream_id;
    info.task_id = tmpinfo.task_id;
}

void AicpuSqeAdapter::GetAicpuInfoLoad(AicpuInfoLoad &info)
{
    aicpusd_info("Get aicpu info load.");
    if (getLoadInfoFuncMap_.find(version_) == getLoadInfoFuncMap_.end()) {
        aicpusd_err("The version[%hu] does not have a corresponding get aicpu load info Function.", version_);
        return;
    }
    (this->*getLoadInfoFuncMap_[version_])(info);
    return;
}

void AicpuSqeAdapter::GetAicErrReportInfoV0(AicErrReportInfo &info)
{
    aicpusd_info("Info is aic error.");
    info.u.aicError = sqe_.u.ts_to_aicpu_aic_err_report;
    return;
}

void AicpuSqeAdapter::GetAicErrReportInfoV1(AicErrReportInfo &info)
{
    aicpusd_info("Info is aic error msg.");
    info.u.aicErrorMsg = msg_Info_.u.aic_err_msg;
    return;
}

void AicpuSqeAdapter::GetAicErrReportInfo(AicErrReportInfo &info)
{
    aicpusd_info("Get aic err report Info.");
    if (getAicErrReportInfoFuncMap_.find(version_) == getAicErrReportInfoFuncMap_.end()) {
        aicpusd_err("The version[%hu] does not have a corresponding get aic error.", version_);
        return;
    }
    return (this->*getAicErrReportInfoFuncMap_[version_])(info);
}

int32_t AicpuSqeAdapter::ErrorMsgResponseToTsV0(ErrMsgRspInfo &rspInfo)
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
    aicpusd_info("Error msg response info: cmd_type[%u], result_code[%u], rsp stream id[%u], rsp task id[%u]",
        aicpuSqe.cmd_type,
        rspInfo.err_code,
        rspInfo.stream_id,
        rspInfo.task_id);
    return ResponseToTs(aicpuSqe, rspInfo.model_id, AicpuDrvManager::GetInstance().GetDeviceId(), aicpuSqe.ts_id);
}

int32_t AicpuSqeAdapter::ErrorMsgResponseToTsV1(ErrMsgRspInfo &rspInfo)
{
    TsAicpuMsgInfo msgInfo{};
    msgInfo.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    msgInfo.cmd_type = cmd_type_;
    msgInfo.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    msgInfo.tid = 0U;  // no need tid
    msgInfo.ts_id = static_cast<uint8_t>(rspInfo.ts_id);
    msgInfo.u.aicpu_resp.result_code = rspInfo.err_code;
    msgInfo.u.aicpu_resp.stream_id = static_cast<uint16_t>(rspInfo.stream_id);
    msgInfo.u.aicpu_resp.task_id = rspInfo.task_id;
    aicpusd_info("Error msg response info: cmd_type[%u], result_code[%u], rsp stream id[%u], rsp task id[%u]",
        msgInfo.cmd_type,
        rspInfo.err_code,
        rspInfo.stream_id,
        rspInfo.task_id);
    return ResponseToTs(msgInfo, rspInfo.model_id, AicpuDrvManager::GetInstance().GetDeviceId(), msgInfo.ts_id);
}

int32_t AicpuSqeAdapter::AicpuSqeAdapter::ErrorMsgResponseToTs(ErrMsgRspInfo &rspInfo)
{
    aicpusd_info("Error msg response to ts.");
    if (getErrorMsgRspFuncMap_.find(version_) == getErrorMsgRspFuncMap_.end()) {
        aicpusd_err("The version[%hu] does not have a corresponding get error msg respone Function.", version_);
        return AICPU_SCHEDULE_ERROR_NOT_FOUND_FUNCTION;
    }
    return (this->*getErrorMsgRspFuncMap_[version_])(rspInfo);
}

void AicpuSqeAdapter::AicpuActiveStreamSetMsgV0(ActiveStreamInfo &info)
{
    TsAicpuSqe aicpuSqe = {};
    aicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    aicpuSqe.cmd_type = AICPU_ACTIVE_STREAM;
    aicpuSqe.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    aicpuSqe.tid = 0U;  // no need tid
    aicpuSqe.ts_id = info.ts_id;
    aicpuSqe.u.aicpu_active_stream.stream_id = info.stream_id;
    aicpuSqe.u.aicpu_active_stream.aicpu_stamp = info.aicpu_stamp;
    aicpusd_info("Active stream set sqe info: cmd_type[%u], stream id[%u], stamp[%u].",
        aicpuSqe.cmd_type,
        aicpuSqe.u.aicpu_active_stream.stream_id,
        aicpuSqe.u.aicpu_active_stream.aicpu_stamp);
    AicpuMsgSend::SetTsDevSendMsgAsync(info.device_id, info.ts_id, aicpuSqe, info.handle_id);
}

void AicpuSqeAdapter::AicpuActiveStreamSetMsgV1(ActiveStreamInfo &info)
{
    TsAicpuMsgInfo msgInfo = {};
    msgInfo.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    msgInfo.cmd_type = TS_AICPU_ACTIVE_STREAM;
    msgInfo.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    msgInfo.tid = 0U;  // no need tid
    msgInfo.ts_id = info.ts_id;
    msgInfo.u.aicpu_active_stream.aicpu_stamp = info.aicpu_stamp;
    msgInfo.u.aicpu_active_stream.stream_id = info.stream_id;
    aicpusd_info("Active stream set msg info: cmd_type[%u], stream id[%u], stamp[%u].",
        msgInfo.cmd_type,
        msgInfo.u.aicpu_active_stream.stream_id,
        msgInfo.u.aicpu_active_stream.aicpu_stamp);
    AicpuMsgSend::SetTsDevSendMsgAsync(info.device_id, info.ts_id, msgInfo, info.handle_id);
}

void AicpuSqeAdapter::AicpuActiveStreamSetMsg(ActiveStreamInfo &info)
{
    aicpusd_info("Aicpu active stream set msg.");
    if (activeStreamSetMsgFuncMap_.find(version_) == activeStreamSetMsgFuncMap_.end()) {
        aicpusd_err("The version[%hu] does not have a corresponding get error msg respone Function.", version_);
        return;
    }
    return (this->*activeStreamSetMsgFuncMap_[version_])(info);
}

int32_t AicpuSqeAdapter::AicpuNoticeTsPidResponse(const uint32_t deviceId) const
{
    aicpusd_info("Aicpu notice ts pid response.");
    TsAicpuSqe aicpuSqe = {};
    aicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());  // host pid
    aicpuSqe.cmd_type = AICPU_NOTICE_TS_PID;
    aicpuSqe.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    return ResponseToTs(aicpuSqe, 0U, deviceId, 0U);
}

int32_t AicpuSqeAdapter::AicpuRecordResponseToTsV0(AicpuRecordInfo &info)
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
    aicpusd_info("Record response to ts : pid[%u], cmd type[%u], vf_id[%u], tid[%u], ts_id[%u], record type[%u], "
                 "record_id[%u], fault_task_id[%u], fault_stream_id[%u], ret[%u]",
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
    aicpusd_info("Use hal ts dev record response.");
    int32_t ret = halTsDevRecord(info.dev_id, info.ts_id, static_cast<uint32_t>(info.record_type), info.record_id);
    if (ret != static_cast<uint32_t>(DRV_ERROR_NONE)) {
        aicpusd_err(
            "Send event notify to ts failed, sendRet=%d, notifyId=%u, retVal=%d.", ret, info.record_id, info.ret_code);
        return AICPU_SCHEDULE_ERROR_FROM_DRV;
    }
    return AICPU_SCHEDULE_OK;
}

int32_t AicpuSqeAdapter::AicpuRecordResponseToTsV1(AicpuRecordInfo &info)
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
    aicpusd_info("Record response to ts : pid[%u], cmd type[%u], vf_id[%u], tid[%u], ts_id[%u], record type[%u], "
                 "record_id[%u], fault_task_id[%u], ret[%u], hand id[%u]",
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

int32_t AicpuSqeAdapter::AicpuRecordResponseToTs(AicpuRecordInfo &info)
{
    if (getRecordRspFuncMap_.find(version_) == getRecordRspFuncMap_.end()) {
        aicpusd_err("The version[%hu] does not have a corresponding get record response Function.", version_);
        return AICPU_SCHEDULE_ERROR_NOT_FOUND_FUNCTION;
    }
    return (this->*getRecordRspFuncMap_[version_])(info);
}

int32_t AicpuSqeAdapter::AicpuTimeOutConfigResponseToTsV0(const int32_t ret)
{
    TsAicpuSqe aicpuSqe{};
    aicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    aicpuSqe.cmd_type = AICPU_TIMEOUT_CONFIG_RESPONSE;
    aicpuSqe.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    aicpuSqe.tid = tid_;
    aicpuSqe.ts_id = ts_id_;
    aicpuSqe.u.aicpu_timeout_cfg_resp.result = ret;
    aicpusd_info("Aicpu time out config response info: cmd_type[%u], ret[%u].", aicpuSqe.cmd_type, ret);
    return ResponseToTs(aicpuSqe, 0U, AicpuDrvManager::GetInstance().GetDeviceId(), aicpuSqe.ts_id);
}

int32_t AicpuSqeAdapter::AicpuTimeOutConfigResponseToTsV1(const int32_t ret)
{
    TsAicpuMsgInfo msgInfo;
    msgInfo.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    msgInfo.cmd_type = cmd_type_;
    msgInfo.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    msgInfo.tid = tid_;
    msgInfo.ts_id = ts_id_;
    msgInfo.u.aicpu_resp.result_code = static_cast<uint16_t>(ret);
    msgInfo.u.aicpu_resp.stream_id = INVALID_VALUE16;
    msgInfo.u.aicpu_resp.task_id = INVALID_VALUE32;
    aicpusd_info("Aicpu time out config response info: cmd_type[%u], ret[%u], stream id[%u], task id[%u].",
        msgInfo.cmd_type,
        ret,
        INVALID_VALUE16,
        INVALID_VALUE32);
    return ResponseToTs(msgInfo, 0U, AicpuDrvManager::GetInstance().GetDeviceId(), msgInfo.ts_id);
}

int32_t AicpuSqeAdapter::AicpuTimeOutConfigResponseToTs(const int32_t ret)
{
    aicpusd_info("Aicpu timeout config response to ts.");
    if (getTimeOutConfigRspFuncMap_.find(version_) == getTimeOutConfigRspFuncMap_.end()) {
        aicpusd_err("The version[%hu] does not have a corresponding get time out config respone Function.", version_);
        return AICPU_SCHEDULE_ERROR_NOT_FOUND_FUNCTION;
    }
    return (this->*getTimeOutConfigRspFuncMap_[version_])(ret);
}

int32_t AicpuSqeAdapter::AicpuInfoLoadResponseToTsV0(const int32_t ret)
{
    TsAicpuSqe aicpuSqe{};
    TsToAicpuInfoLoad tmpInfo = sqe_.u.ts_to_aicpu_info;
    aicpuSqe.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    aicpuSqe.tid = tid_;
    aicpuSqe.ts_id = ts_id_;
    aicpuSqe.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    aicpuSqe.cmd_type = AICPU_INFO_LOAD_RESPONSE;
    aicpuSqe.u.aicpu_resp.cmd_type = AICPU_INFO_LOAD;
    aicpuSqe.u.aicpu_resp.task_id = tmpInfo.task_id;
    aicpuSqe.u.aicpu_resp.result_code = static_cast<uint16_t>(ret);
    aicpuSqe.u.aicpu_resp.stream_id = tmpInfo.stream_id;
    aicpusd_info("Aicpu load info response info: cmd_type[%u], ret[%u], stream id[%u], task id[%u].",
        aicpuSqe.cmd_type,
        ret,
        tmpInfo.stream_id,
        tmpInfo.task_id);
    return ResponseToTs(aicpuSqe, 0U, AicpuDrvManager::GetInstance().GetDeviceId(), aicpuSqe.ts_id);
}

int32_t AicpuSqeAdapter::AicpuInfoLoadResponseToTsV1(const int32_t ret)
{
    TsAicpuMsgInfo msgInfo{};
    TsToAicpuInfoLoadMsg tmpInfo = msg_Info_.u.ts_to_aicpu_info_load;
    msgInfo.pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
    msgInfo.tid = tid_;
    msgInfo.ts_id = ts_id_;
    msgInfo.vf_id = static_cast<uint8_t>(AicpuDrvManager::GetInstance().GetVfId());
    msgInfo.cmd_type = cmd_type_;
    msgInfo.u.aicpu_resp.stream_id = tmpInfo.stream_id;
    msgInfo.u.aicpu_resp.task_id = tmpInfo.task_id;
    msgInfo.u.aicpu_resp.result_code = static_cast<uint16_t>(ret);
    msgInfo.u.aicpu_resp.reserved = 0;
    aicpusd_info("Aicpu load info response info: cmd_type[%u], ret[%u], stream id[%u], task id[%u].",
        msgInfo.cmd_type,
        ret,
        tmpInfo.stream_id,
        tmpInfo.task_id);
    return ResponseToTs(msgInfo, 0U, AicpuDrvManager::GetInstance().GetDeviceId(), msgInfo.ts_id);
}

int32_t AicpuSqeAdapter::AicpuInfoLoadResponseToTs(const int32_t ret)
{
    aicpusd_info("Aicpu  info load response to ts.");
    if (getInfoLoadRspFuncMap_.find(version_) == getInfoLoadRspFuncMap_.end()) {
        aicpusd_err("The version[%hu] does not have a corresponding get load info respone Function.", version_);
        return AICPU_SCHEDULE_ERROR_NOT_FOUND_FUNCTION;
    }
    return (this->*getInfoLoadRspFuncMap_[version_])(ret);
}

int32_t AicpuSqeAdapter::ResponseToTs(
    TsAicpuSqe &aicpuSqe, unsigned int handleId, unsigned int devId, unsigned int tsId) const
{
    aicpusd_info("Begin to response use TsAicpuSqe.");
    const auto ret = tsDevSendMsgAsync(devId,
        static_cast<uint32_t>(tsId),
        PtrToPtr<TsAicpuSqe, char_t>(&aicpuSqe),
        static_cast<uint32_t>(sizeof(TsAicpuSqe)),
        handleId);
    AICPUSD_CHECK((ret == DRV_ERROR_NONE),
        AICPU_SCHEDULE_ERROR_INNER_ERROR,
        "Response to ts use"
        "tsDevSendMsgAsync failed, ret[%d]",
        ret);
    aicpusd_info("Finished to response use TsAicpuSqe.");
    return AICPU_SCHEDULE_OK;
}

int32_t AicpuSqeAdapter::ResponseToTs(
    TsAicpuMsgInfo &aicpuMsgInfo, unsigned int handleId, unsigned int devId, unsigned int tsId) const
{
    aicpusd_info("Begin to response use TsAicpuMsgInfo.");
    const auto ret = tsDevSendMsgAsync(devId,
        static_cast<uint32_t>(tsId),
        PtrToPtr<TsAicpuMsgInfo, char_t>(&aicpuMsgInfo),
        static_cast<uint32_t>(sizeof(TsAicpuMsgInfo)),
        handleId);
    AICPUSD_CHECK((ret == DRV_ERROR_NONE),
        AICPU_SCHEDULE_ERROR_INNER_ERROR,
        "Response to ts use"
        "tsDevSendMsgAsync failed, ret[%d]",
        ret);
    aicpusd_info("Finished to response use TsAicpuMsgInfo.");
    return AICPU_SCHEDULE_OK;
}

int32_t AicpuSqeAdapter::ResponseToTs(
    hwts_response_t &hwtsResp, uint32_t devId, EVENT_ID eventId, uint32_t subeventId) const
{
    aicpusd_info("Begin to response use hwtsResp.");
    const drvError_t ret = halEschedAckEvent(devId,
        eventId,
        subeventId,
        PtrToPtr<hwts_response_t, char_t>(&hwtsResp),
        static_cast<uint32_t>(sizeof(hwts_response_t)));
    AICPUSD_CHECK((ret == DRV_ERROR_NONE),
        AICPU_SCHEDULE_ERROR_INNER_ERROR,
        "Response to ts use"
        "halEschedAckEvent failed, ret[%d]",
        ret);
    aicpusd_info("Finished to response use hwtsResp.");
    return AICPU_SCHEDULE_OK;
}
}  // namespace AicpuSchedule