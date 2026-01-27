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

#include <map>
#include "aicpusd_common.h"
#include "aicpusd_drv_manager.h"
#include "type_def.h"
#include "ts_api.h"

namespace AicpuSchedule {
class AicpuSqeAdapter {
public:
    static constexpr uint16_t INVALID_VALUE16 = 0xFFFF;
    static constexpr uint32_t INVALID_VALUE32 = 0xFFFFFFFF;
    static constexpr uint8_t STARS_DATADUMP_LOAD_INFO = 8;
    static constexpr uint8_t VERSION_0 = 0;
    static constexpr uint8_t VERSION_1 = 1;

    struct AicpuDataDumpInfoLoad {
        volatile uint64_t dumpinfoPtr;
        volatile uint32_t length;
        volatile uint16_t stream_id;
        volatile uint32_t task_id;
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

    AicpuSqeAdapter(const TsAicpuSqe &sqe, const int16_t version);

    AicpuSqeAdapter(const TsAicpuMsgInfo &msgInfo, const int16_t version);

    AicpuSqeAdapter(const int16_t version);

    AicpuSqeAdapter(const AicpuSqeAdapter &) = delete;

    AicpuSqeAdapter(AicpuSqeAdapter &&) = delete;

    AicpuSqeAdapter &operator=(const AicpuSqeAdapter &) = delete;

    AicpuSqeAdapter &operator=(AicpuSqeAdapter &&) = delete;

    ~AicpuSqeAdapter() = default;

    void InitAdapterFuncMap();

    uint8_t GetCmdType() const;

    bool IsAdapterInvalidParameter() const;

    bool IsOpMappingDumpTaskInfoVaild(AicpuOpMappingDumpTaskInfo &info);

    void GetAicpuDataDumpInfoLoad(AicpuDataDumpInfoLoad &info);

    int32_t AicpuDataDumpLoadResponseToTs(const int32_t ret);

    void GetAicpuMsgVersionInfo(AicpuMsgVersionInfo &info);

    int32_t AicpuMsgVersionResponseToTs(const int32_t ret);

private:
    void GetAicpuDataDumpInfoLoadV0(AicpuDataDumpInfoLoad &info);

    void GetAicpuDataDumpInfoLoadV1(AicpuDataDumpInfoLoad &info);

    int32_t AicpuDataDumpLoadResponseToTsV1(const int32_t ret);

    int32_t AicpuDataDumpLoadResponseToTsV0(const int32_t ret);

    void GetAicpuDumpTaskInfoV0(AicpuOpMappingDumpTaskInfo &opmappingInfo, AicpuDumpTaskInfo &dumpTaskInfo);

    void GetAicpuDumpTaskInfoV1(AicpuOpMappingDumpTaskInfo &opmappingInfo, AicpuDumpTaskInfo &dumpTaskInfo);

    int32_t ResponseToTs(TsAicpuSqe &aicpuSqe, unsigned int handleId, unsigned int devId, unsigned int tsId);

    int32_t ResponseToTs(TsAicpuMsgInfo &aicpuMsgInfo, unsigned int handleId, unsigned int devId, unsigned int tsId);

    int32_t ResponseToTs(hwts_response_t &hwtsResp, uint32_t devId, EVENT_ID eventId, uint32_t subeventId);

    using getRspFunc = int32_t (AicpuSqeAdapter::*)(const int32_t);

    using getDataDumpLoadInfoFunc = void (AicpuSqeAdapter::*)(AicpuDataDumpInfoLoad &);

    std::map<uint16_t, getDataDumpLoadInfoFunc> getDataDumpLoadInfoFuncMap_;

    std::map<uint16_t, getRspFunc> getDataDumpLoadRspFuncMap_;

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