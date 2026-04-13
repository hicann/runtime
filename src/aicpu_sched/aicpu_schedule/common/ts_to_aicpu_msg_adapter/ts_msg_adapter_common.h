/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TS_MSG_ADAPTER_COMMON_H
#define TS_MSG_ADAPTER_COMMON_H
namespace AicpuSchedule {
struct ErrLogRptInfo;
constexpr uint16_t INVALID_VALUE16 = 0xFFFF;
constexpr uint32_t INVALID_VALUE32 = 0xFFFFFFFF;
constexpr uint8_t VERSION_0 = 0;
constexpr uint8_t VERSION_1 = 1;
constexpr uint8_t MSG_EVENT_SUB_EVENTID_RECORD = 1;

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
    AicpuOpMappingDumpTaskInfo() = default;
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
    AicpuRecordInfo() = default;
    AicpuRecordInfo(
        uint32_t recordId, uint8_t recordType, uint16_t retCode, uint8_t tsId, uint32_t taskId, uint16_t streamId,
        uint32_t devId)
        : record_id(recordId),
          record_type(recordType),
          ret_code(retCode),
          ts_id(tsId),
          fault_task_id(taskId),
          fault_stream_id(streamId),
          dev_id(devId) {};
    volatile uint32_t record_id;
    volatile uint8_t record_type;
    volatile uint16_t ret_code;
    volatile uint8_t ts_id;
    volatile uint32_t fault_task_id;
    volatile uint32_t fault_stream_id;
    volatile uint32_t dev_id;
};

struct ActiveStreamInfo {
    ActiveStreamInfo() = default;
    ActiveStreamInfo(uint16_t streamId, uint8_t tsId, uint64_t aicpuStamp, uint32_t deviceId, uint32_t handleId)
        : stream_id(streamId), ts_id(tsId), aicpu_stamp(aicpuStamp), device_id(deviceId), handle_id(handleId) {};
    volatile uint16_t stream_id;
    volatile uint8_t ts_id;
    volatile uint64_t aicpu_stamp;
    volatile uint32_t device_id;
    volatile uint32_t handle_id;
};

#pragma pack(push, 1)
struct ErrMsgRspInfo {
    ErrMsgRspInfo() = default;
    ErrMsgRspInfo(uint32_t off, uint32_t errCode, uint32_t streamId, uint32_t taskId, uint32_t modelId, uint32_t tsId)
        : offset(off), err_code(errCode), stream_id(streamId), task_id(taskId), model_id(modelId), ts_id(tsId) {};
    uint32_t offset;
    uint32_t err_code;
    uint32_t stream_id;
    uint32_t task_id;
    uint32_t model_id;
    uint32_t ts_id;
};
#pragma pack(pop)

} // namespace AicpuSchedule
#endif // TS_MSG_ADAPTER_COMMON_H