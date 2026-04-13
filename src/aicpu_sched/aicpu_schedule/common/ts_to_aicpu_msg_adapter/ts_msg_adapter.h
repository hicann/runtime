/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TS_MSG_ADAPTER_H
#define TS_MSG_ADAPTER_H
#include <memory>
#include "aicpusd_common.h"
#include "ts_msg_adapter_common.h"
#include "aicpusd_drv_manager.h"
#include "type_def.h"
#include "ts_api.h"
namespace AicpuSchedule {
class TsMsgAdapter {
public:
    TsMsgAdapter(const TsMsgAdapter&) = delete;
    TsMsgAdapter(TsMsgAdapter&&) = delete;
    TsMsgAdapter& operator=(const TsMsgAdapter&) = delete;
    TsMsgAdapter& operator=(TsMsgAdapter&&) = delete;
    TsMsgAdapter(const uint32_t pid, const uint8_t cmdType, const uint8_t vfId, const uint8_t tid, const uint8_t tsId);
    TsMsgAdapter();
    virtual ~TsMsgAdapter() = default;
    int32_t ResponseToTs(TsAicpuSqe& aicpuSqe, unsigned int handleId, unsigned int devId, unsigned int tsId) const;
    int32_t ResponseToTs(
        TsAicpuMsgInfo& aicpuMsgInfo, unsigned int handleId, unsigned int devId, unsigned int tsId) const;
    int32_t ResponseToTs(hwts_response_t& hwtsResp, uint32_t devId, EVENT_ID eventId, uint32_t subeventId) const;

    // invalid parameter
    virtual bool IsAdapterInvaildParameter() const = 0;

    // dump
    virtual void GetAicpuDataDumpInfo(AicpuDataDumpInfo& info) = 0;
    virtual bool IsOpMappingDumpTaskInfoVaild(const AicpuOpMappingDumpTaskInfo& info) const = 0;
    virtual void GetAicpuDumpTaskInfo(AicpuOpMappingDumpTaskInfo& opmappingInfo, AicpuDumpTaskInfo& dumpTaskInfo) = 0;
    virtual void GetAicpuDataDumpInfoLoad(AicpuDataDumpInfoLoad& info) = 0;
    virtual int32_t AicpuDumpResponseToTs(const int32_t result) = 0;
    virtual int32_t AicpuDataDumpLoadResponseToTs(const int32_t result) = 0;

    // model operator
    virtual void GetAicpuModelOperateInfo(AicpuModelOperateInfo& info) = 0;
    virtual int32_t AicpuModelOperateResponseToTs(const int32_t result, const uint32_t subEvent) = 0;
    virtual void AicpuActiveStreamSetMsg(ActiveStreamInfo& info) = 0;

    // version set
    virtual void GetAicpuMsgVersionInfo(AicpuMsgVersionInfo& info) = 0;
    virtual int32_t AicpuMsgVersionResponseToTs(const int32_t result) = 0;

    // task report
    virtual void GetAicpuTaskReportInfo(AicpuTaskReportInfo& info) = 0;
    virtual int32_t ErrorMsgResponseToTs(ErrMsgRspInfo& rspInfo) = 0;

    // pid notice
    virtual int32_t AicpuNoticeTsPidResponse(const uint32_t deviceId) const = 0;

    // timeout
    virtual void GetAicpuTimeOutConfigInfo(AicpuTimeOutConfigInfo& info) = 0;
    virtual int32_t AicpuTimeOutConfigResponseToTs(const int32_t result) = 0;

    // info load
    virtual void GetAicpuInfoLoad(AicpuInfoLoad& info) = 0;
    virtual int32_t AicpuInfoLoadResponseToTs(const int32_t result) = 0;

    // err report
    virtual void GetAicErrReportInfo(AicErrReportInfo& info) = 0;

    // record
    virtual int32_t AicpuRecordResponseToTs(AicpuRecordInfo& info) = 0;

protected:
    // member variables
    uint32_t pid_;
    uint8_t cmdType_;
    uint8_t vfId_;
    uint8_t tid_;
    uint8_t tsId_;
};
} // namespace AicpuSchedule
#endif // TS_MSG_ADAPTER_H