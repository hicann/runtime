/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "david_device_simulator.h"
#ifndef MSPROF_C
#include "devprof_drv_aicpu.h"
#endif

namespace Cann {
namespace Dvvp {
namespace Test {
int32_t DavidDeviceSimulator::ProfDrvGetChannels(ChannelList &channels)
{
    const std::vector<int> blackList = {2, 5, 7, 43, 45, 46, 48, 49, 51, 85, 150};
    std::string channelStr = "";
    std::string pattern = ",";

    for (int i = 1; i < 99; i++) {
        if (std::find(blackList.begin(), blackList.end(), i) != blackList.end()) {
            continue;
        }
        channelStr += std::to_string(i);
        channelStr += pattern;
    }

    for (int j = 129; j < 143; j++) {
        channelStr += std::to_string(j);
        channelStr += pattern;
    }

    for (int i = 146; i < 152; i++) {
        if (std::find(blackList.begin(), blackList.end(), i) != blackList.end()) {
            continue;
        }
        channelStr += std::to_string(i);
        channelStr += pattern;
    }

    if (isAicpuChannelRegister_) {
        channelStr += "143";
        channelStr += pattern;
    }
    if (isCustomCpuChannelRegister_) {
        channelStr += "144";
        channelStr += pattern;
    }
    if (isAdprofChannelRegister_) {
        channelStr += "145";
        channelStr += pattern;
    }

    std::string::size_type pos;
    std::vector<std::string> res;
    std::string str = channelStr;
    std::string::size_type size = str.size();
    int ic = 0;

    for (std::string::size_type i = 0; i < size; i++) {
        pos = str.find(pattern, i);
        if (pos < size) {
            std::string ss = str.substr(i, pos - i);
            res.push_back(ss);
            channels.channel[ic].channel_id = std::stoi(ss);
            channels.channel[ic].channel_type = 1;
            i = pos;
            ic++;
        }
    }

    channels.channel_num = res.size();
    channels.chip_type = 5;
    return 0;
}

int32_t DavidDeviceSimulator::GetDeviceInfo(int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (moduleType == MODULE_TYPE_SYSTEM &&
        infoType == INFO_TYPE_VERSION) {
        *value = (int64_t)StPlatformType::CHIP_CLOUD_V3 << 8;
    }

    if (moduleType == MODULE_TYPE_AICORE &&
        infoType == INFO_TYPE_CORE_NUM) {
        *value = 18;
    }

    if (moduleType == MODULE_TYPE_VECTOR_CORE &&
        infoType == INFO_TYPE_CORE_NUM) {
        *value = 18;
    }

    if (moduleType == MODULE_TYPE_AICPU &&
        infoType == INFO_TYPE_CORE_NUM) {
        *value = 8;
    }

    return 0;
}

int32_t DavidDeviceSimulator::ProfDrvStart(uint32_t channelId, const ProfStartPara &para)
{
    prof_sample_start_para profPara;
    profPara.dev_id = 0;
    profPara.user_data = para.user_data;
    profPara.user_data_len = para.user_data_size;

    std::queue<struct Buff> dataQueue;
    switch (channelId) {
        case CHANNEL_TSFW:
            DataMgr().ReportTsKeypointData(dataQueue);
            DataMgr().ReportTsTimelineData(dataQueue);
            break;
        case CHANNEL_STARS_SOC_LOG_BUFFER:
            DataMgr().ReportOpStarsAcsqData(dataQueue);
            break;
        case CHANNEL_FFTS_PROFILE_BUFFER_TASK:
            DataMgr().ReportOpDavidPmuData(dataQueue);
            break;
        case CHANNEL_BIU_GROUP1_AIC:
        case CHANNEL_BIU_GROUP1_AIV0:
        case CHANNEL_BIU_GROUP1_AIV1:
        case CHANNEL_BIU_GROUP2_AIC:
        case CHANNEL_BIU_GROUP2_AIV0:
        case CHANNEL_BIU_GROUP2_AIV1:
            if (!(profPara.user_data_len == 16 && (reinterpret_cast<uint32_t *>(para.user_data))[1] == 1)) {
                DataMgr().ReportBiuPerfData(dataQueue);
            }
            break;
        #if defined (MSPROF_C) || defined (API_STEST)
        #else
        case CHANNEL_AICPU:
        case CHANNEL_CUS_AICPU: {
            MSPROF_EVENT("driver call aicpu start_func");
            DeviceSimulator::profSampleOps_[channelId].start_func(&profPara); // 驱动调用 devprof 注册的 start_fun，devprof 会调用aicpu注册的 start
            MsprofAdditionalInfo info;
            for (int32_t i = 0; i < 1024; i++) {
                (void)AdprofReportAdditionalInfo(1, &info, sizeof(MsprofAdditionalInfo));
            }
            break;
        }
        case CHANNEL_ADPROF:
            MSPROF_EVENT("driver call devprof start_func");
            DeviceSimulator::profSampleOps_[channelId].start_func(&profPara);
            SampleData(channelId, dataQueue);
            break;
        #endif
        case CHANNEL_BIU_GROUP0_AIC:
        case CHANNEL_BIU_GROUP0_AIV0:
        case CHANNEL_BIU_GROUP0_AIV1:
            if (profPara.user_data_len == 16 && (reinterpret_cast<uint32_t *>(para.user_data))[1] == 1) {
                DeviceSimulator::channelName_ = "pc_sampling";
                MSPROF_EVENT("driver call pc sampling start_func");
            } else {
                DeviceSimulator::channelName_ = "biu_perf";
                MSPROF_EVENT("driver call biu perf start_func");
            }
            break;
        default:
            break;
    }
    if (dataQueue.empty()) {
        DataMgr().ReportDefaultData(dataQueue);
    }
    std::unique_lock<std::mutex> lk(DeviceSimulator::channelDataMtx_);
    DeviceSimulator::channelData_[channelId] = dataQueue;
    
    DeviceSimulator::profReadStatus_[channelId] = false;
    return 0;
}
}
}
}
