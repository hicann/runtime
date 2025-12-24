/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <iostream>
#include <memory>
#include "device_simulator_manager.h"
#include "stars_device_simulator.h"
#include "cloud_device_simulator.h"
#include "dc_device_simulator.h"
#include "mdc_device_simulator.h"
#include "mini_device_simulator.h"
#include "tiny_device_simulator.h"
#include "nano_device_simulator.h"
#include "mdc_mini_v3_device_simulator.h"
#include "mdc_lite_device_simulator.h"
#include "mini_stars_device_simulator.h"
#include "david_device_simulator.h"
#include "david_v121_device_simulator.h"
#include "msprof_stub.h"

namespace Cann {
namespace Dvvp {
namespace Test {
DeviceSimulatorManager &DeviceSimulatorManager::GetInstance()
{
    static DeviceSimulatorManager manager;
    return manager;
}

uint32_t DeviceSimulatorManager::CreateDeviceSimulator(uint32_t num, StPlatformType platformType)
{
    MSPROF_LOGI("[CreateDeviceSimulator] Create %u Device which Platform is %d", num, platformType);
    std::unique_ptr<DeviceSimulator> simulator = nullptr;
    for (uint32_t i = 0; i < num; i++) {
        if (platformType == StPlatformType::CHIP_V4_1_0) {
            simulator = std::unique_ptr<DeviceSimulator>(new(std::nothrow) StarsDeviceSimulator(static_cast<uint32_t>(platformType)));
            if (simulator == nullptr) {
                return 0;
            }
            devices_.emplace_back(std::move(simulator));
        }
        if (platformType == StPlatformType::CHIP_CLOUD_V3) {
            simulator = std::unique_ptr<DeviceSimulator>(new(std::nothrow) DavidDeviceSimulator(static_cast<uint32_t>(platformType)));
            if (simulator == nullptr) {
                return 0;
            }
            devices_.emplace_back(std::move(simulator));
        }
        if (platformType == StPlatformType::CHIP_CLOUD_V4) {
            simulator = std::unique_ptr<DeviceSimulator>(new(std::nothrow) DavidV121DeviceSimulator(static_cast<uint32_t>(platformType)));
            if (simulator == nullptr) {
                return 0;
            }
            devices_.emplace_back(std::move(simulator));
        }
        if (platformType == StPlatformType::MINI_V3_TYPE) {
            simulator = std::unique_ptr<DeviceSimulator>(new(std::nothrow) MiniStarsDeviceSimulator(static_cast<uint32_t>(platformType)));
            if (simulator == nullptr) {
                return 0;
            }
            devices_.emplace_back(std::move(simulator));
        }
        if (platformType == StPlatformType::CLOUD_TYPE) {
            simulator = std::unique_ptr<DeviceSimulator>(new(std::nothrow) CloudDeviceSimulator());
            if (simulator == nullptr) {
                return 0;
            }
            devices_.emplace_back(std::move(simulator));
        }
        if (platformType == StPlatformType::DC_TYPE) {
            simulator = std::unique_ptr<DeviceSimulator>(new(std::nothrow) DcDeviceSimulator());
            if (simulator == nullptr) {
                return 0;
            }
            devices_.emplace_back(std::move(simulator));
        }
        if (platformType == StPlatformType::MDC_TYPE) {
            simulator = std::unique_ptr<DeviceSimulator>(new(std::nothrow) MdcDeviceSimulator(static_cast<uint32_t>(platformType)));
            if (simulator == nullptr) {
                return 0;
            }
            devices_.emplace_back(std::move(simulator));
        }
        if (platformType == StPlatformType::MINI_TYPE) {
            simulator = std::unique_ptr<DeviceSimulator>(new(std::nothrow) MiniDeviceSimulator());
            if (simulator == nullptr) {
                return 0;
            }
            devices_.emplace_back(std::move(simulator));
        }
        if (platformType == StPlatformType::CHIP_TINY_V1) {
            simulator = std::unique_ptr<DeviceSimulator>(new(std::nothrow) TinyDeviceSimulator());
            if (simulator == nullptr) {
                return 0;
            }
            devices_.emplace_back(std::move(simulator));
        }
        if (platformType == StPlatformType::CHIP_NANO_V1) {
            simulator = std::unique_ptr<DeviceSimulator>(new(std::nothrow) NanoDeviceSimulator(static_cast<uint32_t>(platformType)));
            if (simulator == nullptr) {
                return 0;
            }
            devices_.emplace_back(std::move(simulator));
        }
        if (platformType == StPlatformType::CHIP_MDC_MINI_V3) {
            simulator = std::unique_ptr<DeviceSimulator>(new(std::nothrow) MdcMiniV3DeviceSimulator(static_cast<uint32_t>(platformType)));
            if (simulator == nullptr) {
                return 0;
            }
            devices_.emplace_back(std::move(simulator));
        }
        if (platformType == StPlatformType::CHIP_MDC_LITE) {
            simulator = std::unique_ptr<DeviceSimulator>(new(std::nothrow) MdcLiteDeviceSimulator(static_cast<uint32_t>(platformType)));
            if (simulator == nullptr) {
                return 0;
            }
            devices_.emplace_back(std::move(simulator));
        }
    }
    platformType_ = static_cast<uint32_t>(platformType);
    devNum_ = num;
    socSide_ = SocType::DEVICE;
    return devices_.size();
}

uint32_t DeviceSimulatorManager::DelDeviceSimulator(uint32_t num, StPlatformType platformType)
{
    MSPROF_LOGI("[DelDeviceSimulator] del %u Device which Platform is %u", num, static_cast<uint32_t>(platformType));
    devices_.clear();
    socSide_ = SocType::INVALID;
    return num;
}

int32_t DeviceSimulatorManager::ProfDrvGetChannels(uint32_t deviceId, ChannelList &channels)
{
    return devices_[deviceId]->ProfDrvGetChannels(channels);
}

int32_t DeviceSimulatorManager::ProfDrvStart(uint32_t deviceId, uint32_t channelId, const ProfStartPara &para)
{
    auto ret = devices_[deviceId]->ProfDrvStart(channelId, para);
    ProfPollInfo info;
    info.device_id = deviceId;
    info.channel_id = channelId;
    pollInfo_.Push(info);
    return ret;
}

int32_t DeviceSimulatorManager::ProfDrvStop(uint32_t deviceId, uint32_t channelId)
{
    pollInfo_.NotifyQuit();
    return devices_[deviceId]->ProfDrvStop(channelId);
}

int32_t DeviceSimulatorManager::ProfChannelRead(uint32_t deviceId, uint32_t channelId, uint8_t *outBuffer, uint32_t bufferSize)
{
    return devices_[deviceId]->ProfChannelRead(channelId, outBuffer, bufferSize);
}

void DeviceSimulatorManager::ProfSampleRegister(uint32_t deviceId, uint32_t channelId, prof_sample_ops *ops)
{
    devices_[deviceId]->ProfSampleRegister(channelId, ops);
}

int32_t DeviceSimulatorManager::GetDeviceInfo(uint32_t deviceId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    return devices_[deviceId]->GetDeviceInfo(moduleType, infoType, value);
}

int32_t DeviceSimulatorManager::ProfChannelPoll(ProfPollInfo *infoArray, int32_t num, int32_t timeout)
{
    if (infoArray == nullptr || num <= 0 || num > PROF_CHANNEL_NUM_MAX) {
        return -1;
    }
    if (pollInfo_.Empty()) {
#ifdef MSPROF_C
        return 0;
#else
        return PROF_STOPPED_ALREADY;
#endif
    }

    return pollInfo_.Pop(infoArray, num);
}

int32_t DeviceSimulatorManager::GetDevNum(uint32_t &num_dev)
{
    if (devNum_ == static_cast<uint32_t>(0)) {
         return -1;
    }

    num_dev = devNum_;
    return 0;
}

int32_t DeviceSimulatorManager::GetGetDevIDs(uint32_t *devices, uint32_t len)
{
    if (devNum_ == static_cast<uint32_t>(0)) {
         return -1;
    }

    len = devNum_;
    for (uint32_t i = 0; i < len; i++) {
        devices[i] = i;
    }
    return 0;
}

uint32_t DeviceSimulatorManager::GetPlatformType()
{
    return platformType_;
}

void DeviceSimulatorManager::SetSocSide(SocType socSide)
{
    socSide_ = socSide; // 0: device; 1: host;2: INVALID
}

void DeviceSimulatorManager::GetSocSide(uint32_t *info)
{
    *info = socSide_;
}

int32_t DeviceSimulatorManager::HalEschedAttachDevice(uint32_t devId)
{
    return devices_[devId]->HalEschedAttachDevice();
}

int32_t DeviceSimulatorManager::HalEschedDettachDevice(uint32_t devId)
{
    return devices_[devId]->HalEschedDettachDevice();
}

int32_t DeviceSimulatorManager::HalEschedCreateGrpEx(uint32_t devId, struct esched_grp_para *grpPara, uint32_t *grpId)
{
    return devices_[devId]->HalEschedCreateGrpEx(grpPara, grpId);
}

int32_t DeviceSimulatorManager::HalEschedQueryInfo(uint32_t devId, ESCHED_QUERY_TYPE type,
                                                   struct esched_input_info *inPut, struct esched_output_info *outPut)
{
    return devices_[devId]->HalEschedQueryInfo(type, inPut, outPut);
}

int32_t DeviceSimulatorManager::HalEschedWaitEvent(uint32_t devId, uint32_t grpId, uint32_t threadId,
                                                   int timeout, struct event_info *event)
{
    return devices_[devId]->HalEschedWaitEvent(grpId, threadId, timeout, event);
}

int32_t DeviceSimulatorManager::HalEschedSubmitEvent(uint32_t devId, struct event_summary *event)
{
    return devices_[devId]->HalEschedSubmitEvent(event);
}

int32_t DeviceSimulatorManager::HalProfSampleDataReport(unsigned int dev_id, unsigned int chan_id, unsigned int sub_chan_id,
    struct prof_data_report_para *para)
{
    return devices_[dev_id]->HalProfSampleDataReport(dev_id, chan_id, sub_chan_id, para);
}

}
}
}
