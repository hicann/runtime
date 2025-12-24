/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "device_simulator.h"
#include <cstring>
#include <algorithm>
#include "prof_dev_api.h"
#include "osal.h"

#ifndef MSPROF_C
#include "config/config.h"
#include "devprof_drv_aicpu.h"
#endif

namespace Cann {
namespace Dvvp {
namespace Test {
// predefined for driver
const uint32_t BUFF_LEN = 1024 * 1024;    // 1M

DeviceSimulator::~DeviceSimulator()
{
    for (auto &channel : channelData_) {
        while (!channel.second.empty()) {
            struct Buff buffer = channel.second.front();
            channel.second.pop();
            free(buffer.data);
        }
    }
}

int32_t DeviceSimulator::GetDeviceInfo(int32_t moduleType, int32_t infoType, int64_t *value)
{
    return -1;
}

int32_t DeviceSimulator::ProfDrvGetChannels(ChannelList &channels)
{
    return 0;
}

int32_t DeviceSimulator::ProfDrvStart(uint32_t channelId, const ProfStartPara &para)
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
        case CHANNEL_HWTS_LOG:
            DataMgr().ReportHwtsData(dataQueue);
            break;
        case CHANNEL_STARS_SOC_LOG_BUFFER:
            DataMgr().ReportOpStarsAcsqData(dataQueue);
            DataMgr().ReportFftsAcsqData(dataQueue);
            DataMgr().ReportFftsCtxData(dataQueue);
            break;
        case CHANNEL_FFTS_PROFILE_BUFFER_TASK:
            DataMgr().ReportOpFftsPmuData(dataQueue);
            break;
        case CHANNEL_STARS_NANO_PROFILE:
            DataMgr().ReportStarsNanoData(dataQueue);
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
            profSampleOps_[channelId].start_func(&profPara); // 驱动调用 devprof 注册的 start_fun，devprof 会调用aicpu注册的 start
            MsprofAdditionalInfo info;
            info.magicNumber = 0x5A5AU;
            info.level = 6000; // aicpu
            info.type = 2;
            info.timeStamp = 151515151;
            void *addPtr = malloc(1024); // 1024byte
            (void)memset_s(addPtr, 1024, 0, 1024);
            (void)memcpy_s(addPtr, 256, &info, 256);
            (void)memcpy_s(addPtr + 256, 256, &info, 256);
            (void)memcpy_s(addPtr + 512, 256, &info, 256);
            (void)memcpy_s(addPtr + 768, 256, &info, 256);
            for (int32_t i = 0; i < 10; i++) {
                (void)AdprofReportBatchAdditionalInfo(1, addPtr, 4 * sizeof(MsprofAdditionalInfo));
            }
            free(addPtr);
            break;
        }
        case CHANNEL_ADPROF:
            MSPROF_EVENT("driver call devprof start_func");
            profSampleOps_[channelId].start_func(&profPara);
            SampleData(channelId, dataQueue);
            break;
        #endif
        case CHANNEL_BIU_GROUP0_AIC:
        case CHANNEL_BIU_GROUP0_AIV0:
        case CHANNEL_BIU_GROUP0_AIV1:
            if (profPara.user_data_len == 16 && (reinterpret_cast<uint32_t *>(para.user_data))[1] == 1) {
                channelName_ = "pc_sampling";
                MSPROF_EVENT("driver call pc sampling start_func");
            } else {
                channelName_ = "biu_perf";
                MSPROF_EVENT("driver call biu perf start_func");
            }
            break;
        default:
            DataMgr().ReportDefaultData(dataQueue);
            break;
    }
    if (dataQueue.empty()) {
        DataMgr().ReportDefaultData(dataQueue);
    }
    std::unique_lock<std::mutex> lk(channelDataMtx_);
    channelData_[channelId] = dataQueue;
    
    profReadStatus_[channelId] = false;
    return 0;
}

int32_t DeviceSimulator::ProfDrvStop(uint32_t channelId)
{
    if (channelId == CHANNEL_AICPU || channelId == CHANNEL_CUS_AICPU || channelId == CHANNEL_ADPROF) {
        prof_sample_stop_para profPara = {0, 0, {0}};
        profSampleOps_[channelId].stop_func(&profPara);
    }
    std::unique_lock<std::mutex> lk(channelDataMtx_);
    std::queue<struct Buff> &queue = channelData_[channelId];
    int32_t count = 0;
    while (!queue.empty()) {
        queue = channelData_[channelId];
        cvDataRead_[channelId].wait_for(lk, std::chrono::microseconds(50000), [this, &queue] { return queue.empty(); });
        if (count >= 2) {
            break;
        }
        count++;
    }

    while (!queue.empty()) {
        struct Buff buffer = queue.front();
        queue.pop();
        free(buffer.data);
    }
    channelData_.erase(channelId);
    profReadStatus_.erase(channelId);

    switch (channelId) {
        case CHANNEL_AICPU:
            isAicpuChannelRegister_ = false;
            break;
        case CHANNEL_CUS_AICPU:
            isCustomCpuChannelRegister_ = false;
            break;
        case CHANNEL_ADPROF:
            isAdprofChannelRegister_ = false;
            break;
        default:
            break;
    }

    return 0;
}

int32_t DeviceSimulator::ProfChannelRead(uint32_t channelId, uint8_t *outBuffer, uint32_t bufferSize)
{
#ifdef API_STEST
    std::unique_lock<std::mutex> lk(channelDataMtx_);
    auto &dataQueue = channelData_[channelId];
    if (dataQueue.empty()) {
        cvDataRead_[channelId].notify_one();
        return 0;
    }
    struct Buff buffer = dataQueue.front();
    dataQueue.pop();
    memcpy(outBuffer, buffer.data, buffer.len);
    free(buffer.data);
    cvDataRead_[channelId].notify_one();
    return buffer.len;
#else
    std::unique_lock<std::mutex> lk(channelDataMtx_);
    if (profReadStatus_[channelId]) {
        cvDataRead_[channelId].notify_one();
        return 0;
    }
    if (channelData_.find(channelId) != channelData_.end()) {
        auto &dataQueue = channelData_[channelId];
        if (dataQueue.empty()) {
            return 0;
        }
        struct Buff buffer = dataQueue.front();
        dataQueue.pop();
        memcpy(outBuffer, buffer.data, buffer.len);
        free(buffer.data);
        cvDataRead_[channelId].notify_one();
        return buffer.len;
    }

    if (outBuffer != nullptr) {
        *outBuffer = 1024;
        profReadStatus_[channelId] = true;
        cvDataRead_[channelId].notify_one();
        return 1024;
    } else {
        cvDataRead_[channelId].notify_one();
        return 0;
    }
#endif
}

// 模拟驱动 prof_sample_register 接口，接收 devprof 的注册
void DeviceSimulator::ProfSampleRegister(uint32_t channelId, struct prof_sample_ops *ops)
{
    MSPROF_EVENT("devprof registe prof_sample_ops to driver");
    if (ops != nullptr) {
        profSampleOps_[channelId] = *ops;
    }
    switch (channelId) {
        case CHANNEL_AICPU:
            isAicpuChannelRegister_ = true;
            break;
        case CHANNEL_CUS_AICPU:
            isCustomCpuChannelRegister_ = true;
            break;
        case CHANNEL_ADPROF:
            isAdprofChannelRegister_ = true;
            break;
    }
}

#if defined (MSPROF_C) || defined (API_STEST)
#else
using namespace analysis::dvvp::common::config;

void DeviceSimulator::SampleData(uint32_t channelId, std::queue<struct Buff> &dataQueue)
{
    if (channelId == CHANNEL_AICPU || channelId == CHANNEL_CUS_AICPU) {
        
        return;
    }

    MSPROF_EVENT("driver call devprof sample_func to get data and sand to host");
    struct Buff buffer;
    buffer.len = BUFF_LEN;
    buffer.data = malloc(buffer.len);
 
    prof_sample_para para;
    para.dev_id = 0;
    para.sample_flag = SAMPLE_DATA_WITH_HEADER;
    para.buff_len = buffer.len;
    para.buff = buffer.data;
    profSampleOps_[channelId].sample_func(&para);
    MSPROF_EVENT("get data from channel:%u, data size: %u", channelId, para.report_len);
    if (para.report_len == 0) {
        CreateTlvData(&para);
    }

    buffer.len = para.report_len;
    dataQueue.push(buffer);
    return;
}

int32_t DeviceSimulator::CreateTlvData(prof_sample_para *para)
{
    uint32_t tlvValueSize = static_cast<uint32_t>(sizeof(ProfTlvValue));
    uint64_t totalReportLen = 0;
    ProfTlv *tlvBuff = static_cast<ProfTlv *>(para->buff);
    std::vector<std::string> fileNames = {
        "SystemCpuUsage.data",
        "Memory.data",
        "ai_ctrl_cpu.data",
        "1-CpuUsage.data",
        "1-Memory.data"
    };

    std::string data("1234");
    for (std::string &fileName : fileNames) {
        tlvBuff->head = TLV_HEAD;
        tlvBuff->version = 0x00000100;
        tlvBuff->type = 1;
        tlvBuff->len = tlvValueSize;

        ProfTlvValue *tlvValue = reinterpret_cast<ProfTlvValue *>(tlvBuff->value);
        memcpy(tlvValue->chunk, data.c_str(), data.size());
        tlvValue->chunkSize = data.size();
        tlvValue->isLastChunk = false;
        tlvValue->chunkModule = 4;
        tlvValue->offset = -1;
        memset(tlvValue->fileName, 0, TLV_VALUE_FILENAME_MAX_LEN);
        memcpy(tlvValue->fileName, fileName.c_str(), fileName.size());
        memcpy(tlvValue->extraInfo, "0.0", 3);
        memcpy(tlvValue->id, "1", 1);

        totalReportLen += sizeof(ProfTlv);
        tlvBuff++;
    }

    para->report_len = totalReportLen;
    return 0;
}

#endif

int32_t DeviceSimulator::HalEschedAttachDevice()
{
    std::lock_guard<std::mutex> lock(attachMtx_);
    attachCount_++;
    return 0;
}
int32_t DeviceSimulator::HalEschedDettachDevice()
{
    std::lock_guard<std::mutex> lock(attachMtx_);
    attachCount_--;
    if (attachCount_ < 0) {
        return 1;
    }
    return 0;
}

int32_t DeviceSimulator::HalEschedCreateGrpEx(struct esched_grp_para *grpPara, unsigned int *grpId)
{
    std::lock_guard<std::mutex> lock(attachMtx_);
    static uint32_t groupId = 32;
    if (groupMap_.find(grpPara->grp_name) != groupMap_.end()) {
        return 1;
    }
    *grpId = groupId++;
    groupMap_[std::string(grpPara->grp_name)] = *grpId;
    return 0;
}

int32_t DeviceSimulator::HalEschedQueryInfo(ESCHED_QUERY_TYPE type, struct esched_input_info *inPut,
    struct esched_output_info *outPut)
{
    std::lock_guard<std::mutex> lock(attachMtx_);
    struct esched_query_gid_input *gidIn = (struct esched_query_gid_input *)inPut->inBuff;
    std::string grpName(gidIn->grp_name);
    if (groupMap_.find(grpName) == groupMap_.end()) {
        return 1;
    }
    struct esched_query_gid_output *gidOut = (struct esched_query_gid_output *)outPut->outBuff;
    gidOut->grp_id = groupMap_[grpName];
    return 0;
}

int32_t DeviceSimulator::HalEschedWaitEvent(uint32_t grpId, uint32_t threadId, int32_t timeout,
                                            struct event_info *event)
{
    auto it = event_.find(grpId);
    if (it == event_.end()) {
        OsalSleep(1);
        return DRV_ERROR_SCHED_WAIT_TIMEOUT;
    }
    event->comm.event_id = EVENT_USR_START;
    event_.erase(it);
    return DRV_ERROR_NONE;
}

int32_t DeviceSimulator::HalEschedSubmitEvent(struct event_summary *event)
{
    MSPROF_EVENT("send event grpId %d", event->grp_id);
    event_.insert(event->grp_id);
    return DRV_ERROR_NONE;
}

int32_t DeviceSimulator::HalProfSampleDataReport(uint32_t dev_id, uint32_t chan_id, uint32_t sub_chan_id,
    struct prof_data_report_para *para)
{
    std::unique_lock<std::mutex> lk(channelDataMtx_);
    std::queue<struct Buff> &dataQueue = channelData_[chan_id];
    struct Buff buffer;
    buffer.len = para->data_len;
    buffer.data = malloc(buffer.len);
    memcpy_s(buffer.data, buffer.len, para->data, para->data_len);
    dataQueue.push(buffer);
    return DRV_ERROR_NONE;
}

}
}
}
