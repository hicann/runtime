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

namespace AicpuSchedule {

AicpuSqeAdapter::AicpuSqeAdapter(const TsAicpuSqe &sqe, const int16_t version)
    : pid_(sqe.pid), cmd_type_(sqe.cmd_type), vf_id_(sqe.vf_id), tid_(sqe.tid), ts_id_(sqe.ts_id), sqe_(sqe),
      version_(version), invalid_sqe_(false)
{
    aicpusd_info(
        "Enter cust aicpuSqeAdapter constructor, using TsAicpuSqe init, pid[%u], cmd_type[%u], vf id[%u], tid[%u], "
        "ts id[%u], version[%hu]",
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
    aicpusd_info("Enter cust aicpuSqeAdapter constructor, using TsAicpuMsgInfo init, pid[%u], cmd_type[%u], vf "
                 "id[%u], tid[%u], "
                 "ts id[%u], version[%hu]",
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

void AicpuSqeAdapter::InitAdapterFuncMap()
{
    getDataDumpLoadInfoFuncMap_[VERSION_0] = &AicpuSqeAdapter::GetAicpuDataDumpInfoLoadV0;
    getDataDumpLoadInfoFuncMap_[VERSION_1] = &AicpuSqeAdapter::GetAicpuDataDumpInfoLoadV1;

    getDataDumpLoadRspFuncMap_[VERSION_0] = &AicpuSqeAdapter::AicpuDataDumpLoadResponseToTsV0;
    getDataDumpLoadRspFuncMap_[VERSION_1] = &AicpuSqeAdapter::AicpuDataDumpLoadResponseToTsV1;
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

int32_t AicpuSqeAdapter::ResponseToTs(
    TsAicpuSqe &aicpuSqe, unsigned int handleId, unsigned int devId, unsigned int tsId)
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
    TsAicpuMsgInfo &aicpuMsgInfo, unsigned int handleId, unsigned int devId, unsigned int tsId)
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

int32_t AicpuSqeAdapter::ResponseToTs(hwts_response_t &hwtsResp, uint32_t devId, EVENT_ID eventId, uint32_t subeventId)
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