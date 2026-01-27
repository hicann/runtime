/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef AICPUSD_SQE_ADAPTER_H
#define AICPUSD_SQE_ADAPTER_H

#include "aicpusd_common.h"
#include "aicpusd_drv_manager.h"
#include "type_def.h"
#include "ts_api.h"

namespace AicpuSchedule {
struct ErrLogRptInfo;
class AicpuSqeAdapter {
public:
    static constexpr uint16_t INVALID_VALUE16 = 0xFFFF;
    static constexpr uint32_t INVALID_VALUE32 = 0xFFFFFFFF;
    static constexpr uint8_t STARS_DATADUMP_LOAD_INFO = 8;
    static constexpr uint8_t VERSION_0 = 0;
    static constexpr uint8_t VERSION_1 = 1;
    static constexpr uint8_t MSG_EVENT_SUB_EVENTID_RECORD = 1;

    struct AicpuTaskReportInfo {
        volatile uint16_t model_id;
        volatile uint16_t result_code;
        volatile uint16_t stream_id;
        volatile uint32_t task_id;
    };

    struct AicpuModelOperateInfo {
        volatile uint64_t arg_ptr;
        volatile uint16_t stream_id;
        volatile uint16_t task_id;
        volatile uint16_t model_id;
        volatile uint8_t cmd_type;
        volatile uint8_t reserved[3];
    };

    struct AicpuDataDumpInfo {
        volatile bool is_debug;
        volatile uint32_t dump_task_id;
        volatile uint16_t dump_stream_id;
        volatile uint32_t debug_dump_task_id;
        volatile uint16_t debug_dump_stream_id;
        volatile bool is_model;
        volatile uint32_t file_name_task_id;
        volatile uint16_t file_name_stream_id;
    };

    struct AicpuDumpFFTSPlusDataInfo {
        TsToAicpuFFTSPlusDataDump i;
    };

    struct AicpuDataDumpInfoLoad {
        volatile uint64_t dumpinfoPtr;
        volatile uint32_t length;
        volatile uint16_t stream_id;
        volatile uint32_t task_id;
    };

    struct AicpuTimeOutConfigInfo {
        TsToAicpuTimeOutConfig i;
    };

    struct AicpuInfoLoad {
        volatile uint64_t aicpuInfoPtr;
        volatile uint32_t length;
        volatile uint16_t stream_id;
        volatile uint32_t task_id;
    };

    struct AicErrReportInfo {
        union {
            TsToAicpuAicErrReport aicError;
            TsToAicpuAicErrMsgReport aicErrorMsg;
        } u;
    };

    struct AicpuMsgVersionInfo {
        volatile uint16_t magic_num;
        volatile uint16_t version;
    };

    struct AicpuOpMappingDumpTaskInfo {
        AicpuOpMappingDumpTaskInfo(uint32_t protoTaskId, uint32_t protoStreamId, uint32_t taskId, uint32_t streamId)
            : proto_info_task_id(protoTaskId), proto_info_stream_id(protoStreamId), task_id(taskId), stream_id(streamId)
        {}
        volatile uint32_t proto_info_task_id;
        volatile uint32_t proto_info_stream_id;
        volatile uint32_t task_id;
        volatile uint32_t stream_id;
    };

    struct AicpuDumpTaskInfo {
        volatile uint32_t task_id;
        volatile uint32_t stream_id;
        volatile uint32_t context_id;
        volatile uint32_t thread_id;
    };

    struct AicpuRecordInfo {
        AicpuRecordInfo(uint32_t recordId, uint8_t recordType, uint16_t retCode, uint8_t tsId, uint32_t taskId,
            uint16_t streamId, uint32_t devId)
            : record_id(recordId), record_type(recordType), ret_code(retCode), ts_id(tsId), fault_task_id(taskId),
              fault_stream_id(streamId), dev_id(devId){};
        volatile uint32_t record_id;
        volatile uint8_t record_type;
        volatile uint16_t ret_code;
        volatile uint8_t ts_id;
        volatile uint32_t fault_task_id;
        volatile uint32_t fault_stream_id;
        volatile uint32_t dev_id;
    };

    struct ActiveStreamInfo {
        ActiveStreamInfo(uint16_t streamId, uint8_t tsId, uint64_t aicpuStamp, uint32_t deviceId, uint32_t handleId)
            : stream_id(streamId), ts_id(tsId), aicpu_stamp(aicpuStamp), device_id(deviceId), handle_id(handleId){};
        volatile uint16_t stream_id;
        volatile uint8_t ts_id;
        volatile uint64_t aicpu_stamp;
        volatile uint32_t device_id;
        volatile uint32_t handle_id;
    };

#pragma pack(push, 1)
    struct ErrMsgRspInfo {
        ErrMsgRspInfo(
            uint32_t off, uint32_t errCode, uint32_t streamId, uint32_t taskId, uint32_t modelId, uint32_t tsId)
            : offset(off), err_code(errCode), stream_id(streamId), task_id(taskId), model_id(modelId), ts_id(tsId){};
        uint32_t offset;
        uint32_t err_code;
        uint32_t stream_id;
        uint32_t task_id;
        uint32_t model_id;
        uint32_t ts_id;
    };
#pragma pack(pop)

    AicpuSqeAdapter(const TsAicpuSqe &sqe, const int16_t version);

    AicpuSqeAdapter(const TsAicpuMsgInfo &msgInfo, const int16_t version);

    AicpuSqeAdapter(const int16_t version);

    AicpuSqeAdapter(const AicpuSqeAdapter &) = delete;

    AicpuSqeAdapter(AicpuSqeAdapter &&) = delete;

    AicpuSqeAdapter &operator=(const AicpuSqeAdapter &) = delete;

    AicpuSqeAdapter &operator=(AicpuSqeAdapter &&) = delete;

    ~AicpuSqeAdapter() = default;

    uint8_t GetCmdType() const;

    void InitAdapterFuncMap();

    bool IsAdapterInvalidParameter() const;

    void GetAicpuDataDumpInfo(AicpuDataDumpInfo &info);

    int32_t AicpuDumpResponseToTs(const int32_t ret);

    bool IsOpMappingDumpTaskInfoVaild(const AicpuOpMappingDumpTaskInfo &info) const;

    void GetAicpuDumpTaskInfo(AicpuOpMappingDumpTaskInfo &opmappingInfo, AicpuDumpTaskInfo &dumpTaskInfo);

    void GetAicpuDumpFFTSPlusDataInfo(AicpuDumpFFTSPlusDataInfo &info);

    void GetAicpuModelOperateInfo(AicpuModelOperateInfo &info);

    int32_t AicpuModelOperateResponseToTs(const int32_t ret, const uint32_t subEvent);

    void GetAicpuTaskReportInfo(AicpuTaskReportInfo &info);

    int32_t ErrorMsgResponseToTs(ErrMsgRspInfo &rspInfo);

    void AicpuActiveStreamSetMsg(ActiveStreamInfo &info);

    int32_t GetAicpuNotifyResponse();

    int32_t AicpuMsgVersionResponseToTs(const int32_t ret);

    void GetAicpuDataDumpInfoLoad(AicpuDataDumpInfoLoad &info);

    int32_t AicpuDataDumpLoadResponseToTs(const int32_t ret);

    int32_t GetTaskActiveForWaitResponse();

    int32_t AicpuNoticeTsPidResponse(const uint32_t deviceId) const;

    int32_t AicpuRecordResponseToTs();

    void GetAicpuTimeOutConfigInfo(AicpuTimeOutConfigInfo &info);

    int32_t AicpuTimeOutConfigResponseToTs(const int32_t ret);

    void GetAicpuInfoLoad(AicpuInfoLoad &info);

    int32_t AicpuInfoLoadResponseToTs(const int32_t ret);

    void GetAicErrReportInfo(AicErrReportInfo &info);

    void GetAicpuMsgVersionInfo(AicpuMsgVersionInfo &info);

    int32_t AicpuRecordResponseToTs(AicpuRecordInfo &info);

private:
    void GetAicErrReportInfoV0(AicErrReportInfo &info);

    void GetAicErrReportInfoV1(AicErrReportInfo &info);

    void GetAicpuModelOperateInfoV0(AicpuModelOperateInfo &info);

    void GetAicpuModelOperateInfoV1(AicpuModelOperateInfo &info);

    int32_t AicpuModelOperateResponseToTsV0(const int32_t ret, const uint32_t subEvent);

    int32_t AicpuModelOperateResponseToTsV1(const int32_t ret, const uint32_t subEvent);

    void GetAicpuDataDumpInfoV0(AicpuDataDumpInfo &info);

    void GetAicpuDataDumpInfoV1(AicpuDataDumpInfo &info);

    void GetAicpuDumpTaskInfoV0(AicpuOpMappingDumpTaskInfo &opmappingInfo, AicpuDumpTaskInfo &dumpTaskInfo);

    void GetAicpuDumpTaskInfoV1(AicpuOpMappingDumpTaskInfo &opmappingInfo, AicpuDumpTaskInfo &dumpTaskInfo);

    int32_t AicpuDumpResponseToTsV1(const int32_t ret);

    int32_t AicpuDumpResponseToTsV0(const int32_t ret);

    void GetAicpuDataDumpInfoLoadV0(AicpuDataDumpInfoLoad &info);

    void GetAicpuDataDumpInfoLoadV1(AicpuDataDumpInfoLoad &info);

    int32_t AicpuDataDumpLoadResponseToTsV1(const int32_t ret);

    int32_t AicpuDataDumpLoadResponseToTsV0(const int32_t ret);

    void GetAicpuTaskReportInfoV0(AicpuTaskReportInfo &info);

    void GetAicpuTaskReportInfoV1(AicpuTaskReportInfo &info);

    int32_t ErrorMsgResponseToTsV0(ErrMsgRspInfo &rspInfo);

    int32_t ErrorMsgResponseToTsV1(ErrMsgRspInfo &rspInfo);

    int32_t AicpuTimeOutConfigResponseToTsV0(const int32_t ret);

    int32_t AicpuTimeOutConfigResponseToTsV1(const int32_t ret);

    void GetAicpuInfoLoadV0(AicpuInfoLoad &info);

    void GetAicpuInfoLoadV1(AicpuInfoLoad &info);

    int32_t AicpuInfoLoadResponseToTsV0(const int32_t ret);

    int32_t AicpuInfoLoadResponseToTsV1(const int32_t ret);

    int32_t AicpuRecordResponseToTsV0(AicpuRecordInfo &info);

    int32_t AicpuRecordResponseToTsV1(AicpuRecordInfo &info);

    void AicpuActiveStreamSetMsgV0(ActiveStreamInfo &info);

    void AicpuActiveStreamSetMsgV1(ActiveStreamInfo &info);

    int32_t ResponseToTs(TsAicpuSqe &aicpuSqe, unsigned int handleId, unsigned int devId, unsigned int tsId) const;

    int32_t ResponseToTs(
        TsAicpuMsgInfo &aicpuMsgInfo, unsigned int handleId, unsigned int devId, unsigned int tsId) const;

    int32_t ResponseToTs(hwts_response_t &hwtsResp, uint32_t devId, EVENT_ID eventId, uint32_t subeventId) const;

    using getModelOperateInfoFunc = void (AicpuSqeAdapter::*)(AicpuModelOperateInfo &);

    using getRspFunc = int32_t (AicpuSqeAdapter::*)(const int32_t);

    using getModelOperateRspFunc = int32_t (AicpuSqeAdapter::*)(const int32_t, const uint32_t);

    std::map<uint16_t, getModelOperateInfoFunc> getModelOperateInfoFuncMap_;

    std::map<uint16_t, getModelOperateRspFunc> getModelOperateRspFuncMap_;

    using getDataDumpInfoFunc = void (AicpuSqeAdapter::*)(AicpuDataDumpInfo &);

    std::map<uint16_t, getDataDumpInfoFunc> getDataDumpInfoFuncMap_;

    std::map<uint16_t, getRspFunc> getDataDumpRspFuncMap_;

    using getDataDumpLoadInfoFunc = void (AicpuSqeAdapter::*)(AicpuDataDumpInfoLoad &);

    std::map<uint16_t, getDataDumpLoadInfoFunc> getDataDumpLoadInfoFuncMap_;

    std::map<uint16_t, getRspFunc> getDataDumpLoadRspFuncMap_;

    using getTaskReportInfoFunc = void (AicpuSqeAdapter::*)(AicpuTaskReportInfo &);

    using getErrorMsgRspFunc = int32_t (AicpuSqeAdapter::*)(ErrMsgRspInfo &);

    std::map<uint16_t, getTaskReportInfoFunc> getTaskReportInfoFuncMap_;

    std::map<uint16_t, getErrorMsgRspFunc> getErrorMsgRspFuncMap_;

    std::map<uint16_t, getRspFunc> getTimeOutConfigRspFuncMap_;

    using getLoadInfoFunc = void (AicpuSqeAdapter::*)(AicpuInfoLoad &);

    std::map<uint16_t, getLoadInfoFunc> getLoadInfoFuncMap_;

    std::map<uint16_t, getRspFunc> getInfoLoadRspFuncMap_;

    using getDumpTaskInfoFunc = void (AicpuSqeAdapter::*)(AicpuOpMappingDumpTaskInfo &, AicpuDumpTaskInfo &);

    std::map<uint16_t, getDumpTaskInfoFunc> getDumpTaskInfoFuncMap_;

    using getRecordRspFunc = int32_t (AicpuSqeAdapter::*)(AicpuRecordInfo &);

    std::map<uint16_t, getRecordRspFunc> getRecordRspFuncMap_;

    using activeStreamSetMsgFunc = void (AicpuSqeAdapter::*)(ActiveStreamInfo &);

    std::map<uint16_t, activeStreamSetMsgFunc> activeStreamSetMsgFuncMap_;

    using getAicErrReportInfoFunc = void (AicpuSqeAdapter::*)(AicErrReportInfo &);

    std::map<uint16_t, getAicErrReportInfoFunc> getAicErrReportInfoFuncMap_;

    uint32_t pid_ = 0U;

    uint8_t cmd_type_ = 0U;

    uint8_t vf_id_ = 0U;

    uint8_t tid_ = 0U;

    uint8_t ts_id_ = 0U;

    TsAicpuSqe sqe_ = { };

    TsAicpuMsgInfo msg_Info_ = { };

    uint16_t version_ = 0U;

    bool invalid_msg_info_ = false;

    bool invalid_sqe_ = false;
};

}  // namespace AicpuSchedule
#endif