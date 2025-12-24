/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CANN_DVVP_TEST_DEVICE_SIMULATOR_MANAGER_H
#define CANN_DVVP_TEST_DEVICE_SIMULATOR_MANAGER_H
#include <vector>
#include "device_simulator.h"
#include "queue.h"
namespace Cann {
namespace Dvvp {
namespace Test {
enum SocType {
    DEVICE = 0,
    HOST = 1,
    INVALID = 2
};

class DeviceSimulatorManager {
public:
    ~DeviceSimulatorManager() {}
    static DeviceSimulatorManager &GetInstance();
    uint32_t CreateDeviceSimulator(uint32_t num, StPlatformType platformType);
    uint32_t DelDeviceSimulator(uint32_t num, StPlatformType platformType);
    int32_t ProfDrvGetChannels(uint32_t deviceId, ChannelList &channels);
    int32_t ProfDrvStart(uint32_t deviceId, uint32_t channelId, const ProfStartPara &para);
    int32_t ProfDrvStop(uint32_t deviceId, uint32_t channelId);
    int32_t ProfChannelRead(uint32_t deviceId, uint32_t channelId, uint8_t *outBuffer, uint32_t bufferSize);
    int32_t ProfChannelPoll(ProfPollInfo *infoArray, int32_t num, int32_t timeout);
    int32_t GetDevNum(uint32_t &num_dev);
    int32_t GetGetDevIDs(uint32_t *devices, uint32_t len);
    void ProfSampleRegister(uint32_t dev_id, uint32_t chan_id, prof_sample_ops *ops);
    int32_t GetDeviceInfo(uint32_t deviceId, int32_t moduleType, int32_t infoType, int64_t *value);
    void SetSocSide(SocType socSide);
    void GetSocSide(uint32_t *info);
    uint32_t GetPlatformType();
    int32_t HalEschedAttachDevice(uint32_t devId);
    int32_t HalEschedDettachDevice(uint32_t devId);
    int32_t HalEschedCreateGrpEx(uint32_t devId, struct esched_grp_para *grpPara, uint32_t *grpId);
    int32_t HalEschedQueryInfo(uint32_t devId, ESCHED_QUERY_TYPE type,
                               struct esched_input_info *inPut, struct esched_output_info *outPut);
    int32_t HalEschedWaitEvent(uint32_t devId, uint32_t grpId, uint32_t threadId, int timeout, struct event_info *event);
    int32_t HalEschedSubmitEvent(uint32_t devId, struct event_summary *event);
    int32_t HalProfSampleDataReport(uint32_t dev_id, uint32_t chan_id, uint32_t sub_chan_id, struct prof_data_report_para *para);

private:
    DeviceSimulatorManager(): devNum_(0) {}
    std::vector<std::unique_ptr<DeviceSimulator>> devices_;
    uint32_t devNum_;
    uint32_t platformType_;
    Queue<ProfPollInfo> pollInfo_;
    uint32_t socSide_;
};
}
}
}

inline Cann::Dvvp::Test::DeviceSimulatorManager &SimulatorMgr()
{
    return Cann::Dvvp::Test::DeviceSimulatorManager::GetInstance();
}
#endif
