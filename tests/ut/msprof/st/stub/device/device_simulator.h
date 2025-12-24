/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CANN_DVVP_TEST_DEVICE_SIMULATOR_H
#define CANN_DVVP_TEST_DEVICE_SIMULATOR_H
#include <cstdint>
#include <memory>
#include <queue>
#include <map>
#include <mutex>
#include <chrono>
#include <condition_variable>
#include <unordered_map>
#include "device_drv_prof_stub.h"
#include "data_manager.h"
#include "msprof_stub.h"

namespace Cann {
namespace Dvvp {
namespace Test {
using ChannelList = channel_list_t;
using ProfStartPara = struct prof_start_para;
using ProfPollInfo = struct prof_poll_info;
using ChannelInfo = struct channel_info;
using ChannelList = struct channel_list;
struct ChannelBuffer {
    std::shared_ptr<uint8_t> outBuffer;
    uint32_t bufferSize;
};

class DeviceSimulator {
public:
    DeviceSimulator() {}
    virtual ~DeviceSimulator();
    virtual int32_t GetDeviceInfo(int32_t moduleType, int32_t infoType, int64_t *value);
    virtual int32_t ProfDrvGetChannels(ChannelList &channels);
    virtual int32_t ProfDrvStart(uint32_t channelId, const ProfStartPara &para);
    int32_t ProfDrvStop(uint32_t channelId);
    int32_t ProfChannelRead(uint32_t channelId, uint8_t *outBuffer, uint32_t bufferSize);
    void ProfSampleRegister(uint32_t channelId, prof_sample_ops *ops);
    int32_t HalEschedAttachDevice();
    int32_t HalEschedDettachDevice();
    int32_t HalEschedCreateGrpEx(struct esched_grp_para *grpPara, unsigned int *grpId);
    int32_t HalEschedQueryInfo(ESCHED_QUERY_TYPE type, struct esched_input_info *inPut,
                               struct esched_output_info *outPut);
    int32_t HalEschedWaitEvent(uint32_t grpId, uint32_t threadId, int32_t timeout, struct event_info *event);
    int32_t HalEschedSubmitEvent(struct event_summary *event);
    int32_t HalProfSampleDataReport(uint32_t dev_id, uint32_t chan_id, uint32_t sub_chan_id, struct prof_data_report_para *para);

protected:
    bool isAicpuChannelRegister_{false};
    bool isCustomCpuChannelRegister_{false};
    bool isAdprofChannelRegister_{false};

private:
    void SampleData(uint32_t channelId, std::queue<struct Buff> &dataQueue);
    void AicpuRegister(uint32_t channelId);
    int32_t CreateTlvData(prof_sample_para *para);

protected:
    std::mutex channelDataMtx_;
    std::string channelName_;
    std::map<uint32_t, std::queue<struct Buff>> channelData_;
    std::map<uint32_t, bool> profReadStatus_;

private:
    ChannelList channels_;
    std::unordered_map<uint32_t, std::queue<ChannelBuffer>> channelBuffer_;
    std::map<uint32_t, prof_sample_ops> profSampleOps_;
    std::mutex attachMtx_;
    int32_t attachCount_{0};
    std::map<std::string, uint32_t> groupMap_;
    std::set<uint32_t> event_;
    std::condition_variable cvDataRead_[CHANNEL_IDS_MAX];
};
}
}
}
 #endif
