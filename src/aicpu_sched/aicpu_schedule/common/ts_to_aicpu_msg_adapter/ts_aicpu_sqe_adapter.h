/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TS_AICPU_SQE_ADAPTER_H
#define TS_AICPU_SQE_ADAPTER_H
#include "ts_msg_adapter.h"
namespace AicpuSchedule {
class TsAicpuSqeAdapter final : public TsMsgAdapter {
public:
    TsAicpuSqeAdapter(const TsAicpuSqeAdapter&) = delete;
    TsAicpuSqeAdapter(TsAicpuSqeAdapter&&) = delete;
    TsAicpuSqeAdapter& operator=(const TsAicpuSqeAdapter&) = delete;
    TsAicpuSqeAdapter& operator=(TsAicpuSqeAdapter&&) = delete;
    ~TsAicpuSqeAdapter() override = default;
    TsAicpuSqeAdapter(const TsAicpuSqe& sqe);
    TsAicpuSqeAdapter();

    // invalid parameter
    bool IsAdapterInvaildParameter() const override;

    // dump
    void GetAicpuDataDumpInfo(AicpuDataDumpInfo& info) override;
    void GetAicpuDumpFFTSPlusDataInfo(AicpuDumpFFTSPlusDataInfo& info);
    bool IsOpMappingDumpTaskInfoVaild(const AicpuOpMappingDumpTaskInfo& info) const override;
    void GetAicpuDumpTaskInfo(AicpuOpMappingDumpTaskInfo& opmappingInfo, AicpuDumpTaskInfo& dumpTaskInfo) override;
    void GetAicpuDataDumpInfoLoad(AicpuDataDumpInfoLoad& info) override;
    int32_t AicpuDumpResponseToTs(const int32_t result) override;
    int32_t AicpuDataDumpLoadResponseToTs(const int32_t result) override;

    // model operator
    void GetAicpuModelOperateInfo(AicpuModelOperateInfo& info) override;
    int32_t AicpuModelOperateResponseToTs(const int32_t result, const uint32_t subEvent) override;
    void AicpuActiveStreamSetMsg(ActiveStreamInfo& info) override;

    // version set
    void GetAicpuMsgVersionInfo(AicpuMsgVersionInfo& info) override;
    int32_t AicpuMsgVersionResponseToTs(const int32_t result) override;

    // task report
    void GetAicpuTaskReportInfo(AicpuTaskReportInfo& info) override;
    int32_t ErrorMsgResponseToTs(ErrMsgRspInfo& rspInfo) override;

    // pid notice
    int32_t AicpuNoticeTsPidResponse(const uint32_t deviceId) const override;

    // timeout
    void GetAicpuTimeOutConfigInfo(AicpuTimeOutConfigInfo& info) override;
    int32_t AicpuTimeOutConfigResponseToTs(const int32_t result) override;

    // info load
    void GetAicpuInfoLoad(AicpuInfoLoad& info) override;
    int32_t AicpuInfoLoadResponseToTs(const int32_t result) override;

    // err report
    void GetAicErrReportInfo(AicErrReportInfo& info) override;

    // record
    int32_t AicpuRecordResponseToTs(AicpuRecordInfo& info) override;
private:
    TsAicpuSqe aicpuSqe_;
    bool invalidSqe_;
};
} // namespace AicpuSchedule
#endif // TS_AICPU_SQE_ADAPTER_H