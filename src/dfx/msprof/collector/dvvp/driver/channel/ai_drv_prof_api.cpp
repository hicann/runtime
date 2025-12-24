/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ai_drv_prof_api.h"
#include <cerrno>
#include <map>
#include "errno/error_code.h"
#include "securec.h"
#include "ai_drv_dev_api.h"
#include "ascend_inpackage_hal.h"
#include "json_parser.h"
namespace analysis {
namespace dvvp {
namespace driver {
using namespace analysis::dvvp::common::error;
using namespace Msprofiler::Parser;
// 32 * 1024 * 0.8  is the full threshold  of ai_core_sample
constexpr uint32_t AI_CORE_SAMPLE_FULL_THRESHOLD = static_cast<uint32_t>(32 * 1024 * 0.8);
constexpr int32_t DRV_NOT_ENOUGH_SUB_CHANNEL_RESOURCE = -10;  // PROF_NOT_ENOUGH_SUB_CHANNEL_RESOURCE
constexpr int32_t DRV_VF_SUB_RESOURCE_FULL = -11;  // PROF_VF_SUB_RESOURCE_FULL
constexpr int32_t DRV_TS_NOT_BIND_CP_PROCESS = 115; // 0x73
constexpr int32_t STRING_TO_LONG_WEIGHT = 16;
const std::string SOC_PMU_HA = "HA:";
const std::string SOC_PMU_MATA = "MATA:";
const std::string SOC_PMU_SMMU = "SMMU:";
const std::string SOC_PMU_NOC = "NOC:";

int32_t DrvGetChannels(struct DrvProfChannelsInfo &channels)
{
    MSPROF_EVENT("Begin to get channels, deviceId=%d", channels.deviceId);
    if (channels.deviceId < 0) {
        MSPROF_LOGE("DrvGetChannels, devId is invalid, deviceId=%d", channels.deviceId);
        return PROFILING_FAILED;
    }

    channel_list_t channelList;
    (void)memset_s(&channelList, sizeof(channel_list_t), 0, sizeof(channel_list_t));
    int32_t ret = prof_drv_get_channels(static_cast<uint32_t>(channels.deviceId), &channelList);
    if (ret != PROF_OK) {
        MSPROF_LOGE("DrvGetChannels get channels failed, deviceId=%d", channels.deviceId);
        return PROFILING_FAILED;
    }
    if (channelList.channel_num > PROF_CHANNEL_NUM_MAX || channelList.channel_num == 0) {
        MSPROF_LOGE("DrvGetChannels channel num is invalid, channelNum=%u", channelList.channel_num);
        return PROFILING_FAILED;
    }
    channels.chipType = channelList.chip_type;
    std::string channelIdStr = "";
    for (uint32_t i = 0; i < channelList.channel_num; i++) {
        struct DrvProfChannelInfo channel;
        if (channelList.channel[i].channel_id == 0 ||
            channelList.channel[i].channel_id > AI_DRV_CHANNEL::PROF_CHANNEL_MAX) {
            MSPROF_LOGE("Channel id is invalid, channelId=%u, i=%d", channelList.channel[i].channel_id, i);
            continue;
        }
        channel.channelId = static_cast<analysis::dvvp::driver::AI_DRV_CHANNEL>(channelList.channel[i].channel_id);
        channel.channelType = channelList.channel[i].channel_type;
        channel.channelName = std::string(channelList.channel[i].channel_name, PROF_CHANNEL_NAME_LEN);
        channelIdStr += std::to_string(channelList.channel[i].channel_id) + ",";
        channels.channels.push_back(channel);
    }
    channelIdStr.pop_back();
    MSPROF_EVENT("End to get channels, deviceId=%d, channelNum=%zu, channelId=%s", channels.deviceId,
        channels.channels.size(), channelIdStr.c_str());
    return PROFILING_SUCCESS;
}

AiDrvProfApi::AiDrvProfApi() {}

AiDrvProfApi::~AiDrvProfApi() {}

DrvChannelsMgr::DrvChannelsMgr() {}

DrvChannelsMgr::~DrvChannelsMgr() {}

int32_t DrvChannelsMgr::GetAllChannels(int32_t indexId)
{
    std::lock_guard<std::mutex> lk(mtxChannel_);
    MSPROF_LOGI("Begin to GetAllChannels, devIndexId %d", indexId);
    struct DrvProfChannelsInfo channels;
    channels.deviceId = indexId;
    if (DrvGetChannels(channels) != PROFILING_SUCCESS) {
        MSPROF_LOGE("DrvGetChannels failed, devId:%d", channels.deviceId);
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("GetAllChannels, devId:%d", channels.deviceId);
    devIdChannelsMap_[channels.deviceId] = channels;
    return PROFILING_SUCCESS;
}

bool DrvChannelsMgr::ChannelIsValid(int32_t devId, AI_DRV_CHANNEL channelId)
{
    std::lock_guard<std::mutex> lk(mtxChannel_);
    auto iter = devIdChannelsMap_.find(devId);
    if (iter == devIdChannelsMap_.end()) {
        MSPROF_LOGI("ChannelIsValid not find channel map, devId:%d", devId);
        return false;
    }
    if (!JsonParser::instance()->GetJsonChannelProfSwitch(static_cast<uint32_t>(channelId))) {
        MSPROF_LOGI("devId:%d, channelId:%d in Json file is configured to off", devId, static_cast<int32_t>(channelId));
        return false;
    }
    for (auto channel : iter->second.channels) {
        if (channel.channelId == channelId) {
            MSPROF_LOGI("ChannelIsValid find channel map, devId:%d, channelId:%d", devId,
                        static_cast<int32_t>(channelId));
            return true;
        }
    }
    MSPROF_LOGI("ChannelIsValid not find channel map, devid:%d", devId);
    return false;
}

int32_t DrvPeripheralStart(DrvPeripheralProfileCfg &peripheralCfg)
{
    MSPROF_EVENT("Begin to start profiling DrvPeripheralStart, profDeviceId=%d,"
                 " profChannel=%d, profSamplePeriod=%dms",
                 peripheralCfg.profDeviceId, static_cast<int32_t>(peripheralCfg.profChannel),
                 peripheralCfg.profSamplePeriod);
    struct prof_start_para profStartPara;
    profStartPara.channel_type = PROF_PERIPHERAL_TYPE;
    profStartPara.sample_period = (unsigned int)peripheralCfg.profSamplePeriod;
    profStartPara.real_time = PROFILE_REAL_TIME;
    profStartPara.user_data = peripheralCfg.configP;
    profStartPara.user_data_size = peripheralCfg.configSize;
    const int32_t ret = DrvStart(static_cast<uint32_t>(peripheralCfg.profDeviceId), peripheralCfg.profChannel,
        &profStartPara);
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start profiling DrvPeripheralStart, profDeviceId=%d,"
                    " profChannel=%d, profSamplePeriod=%dms, ret=%d",
                    peripheralCfg.profDeviceId, static_cast<int32_t>(peripheralCfg.profChannel),
                    peripheralCfg.profSamplePeriod, ret);
        return PROFILING_FAILED;
    }
    peripheralCfg.startSuccess = true;
    MSPROF_EVENT("Succeeded to start profiling DrvPeripheralStart, profDeviceId=%d,"
                 " profChannel=%d, profSamplePeriod=%dms",
                 peripheralCfg.profDeviceId, static_cast<int32_t>(peripheralCfg.profChannel),
                 peripheralCfg.profSamplePeriod);

    return PROFILING_SUCCESS;
}

template <typename T>
int32_t DoProfTsCpuStart(const DrvPeripheralProfileCfg &peripheralCfg, const std::vector<std::string> &profEvents,
                     TEMPLATE_T_PTR<T> configP, uint32_t configSize)
{
    if (configP == nullptr) {
        return PROF_ERROR;
    }
    const int32_t profDeviceId = peripheralCfg.profDeviceId;
    AI_DRV_CHANNEL profChannel = peripheralCfg.profChannel;
    uint32_t profSamplePeriod = (uint32_t)peripheralCfg.profSamplePeriod;

    (void)memset_s(configP, configSize, 0, configSize);
    configP->period = static_cast<uint32_t>(profSamplePeriod);
    configP->event_num = static_cast<uint32_t>(profEvents.size());
    std::string eventStr;
    for (uint32_t i = 0; i < static_cast<uint32_t>(profEvents.size()); i++) {
        configP->event[i] = static_cast<uint32_t>(strtol(profEvents[i].c_str(), nullptr, STRING_TO_LONG_WEIGHT));
        (void)eventStr.append(profEvents[i] + ",");
    }
    MSPROF_EVENT("Begin to start profiling DoProfTsCpuStart, profDeviceId=%d,"
                 " profChannel=%d, profSamplePeriod=%dms",
                 profDeviceId, static_cast<int32_t>(profChannel), profSamplePeriod);
    MSPROF_EVENT("DoProfTsCpuStart, period=%d, event_num=%d, events=%s", configP->period, configP->event_num,
                 eventStr.c_str());
    struct prof_start_para profStartPara;
    profStartPara.channel_type = PROF_TS_TYPE;
    profStartPara.sample_period = (unsigned int)peripheralCfg.profSamplePeriod;
    profStartPara.real_time = PROFILE_REAL_TIME;
    profStartPara.user_data = configP;
    profStartPara.user_data_size = configSize;
    int32_t ret = DrvStart(static_cast<uint32_t>(profDeviceId), profChannel, &profStartPara);
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start profiling DoProfTsCpuStart, profDeviceId=%d,"
                    " profChannel=%d, profSamplePeriod=%dms, ret=%d",
                    profDeviceId, static_cast<int32_t>(profChannel), profSamplePeriod, ret);
        return ret;
    }

    MSPROF_EVENT("Succeeded to start profiling DoProfTsCpuStart, profDeviceId=%d,"
                 " profChannel=%d, profSamplePeriod=%dms",
                 profDeviceId, static_cast<int32_t>(profChannel), profSamplePeriod);
    return PROFILING_SUCCESS;
}

int32_t DrvTscpuStart(const DrvPeripheralProfileCfg &peripheralCfg, const std::vector<std::string> &profEvents)
{
    uint32_t configSize = static_cast<uint32_t>(sizeof(TsTsCpuProfileConfigT) + profEvents.size() * sizeof(uint32_t));
    auto configP = static_cast<TsTsCpuProfileConfigT *>(malloc(configSize));
    if (configP == nullptr) {
        return PROFILING_FAILED;
    }
    const int32_t ret = DoProfTsCpuStart(peripheralCfg, profEvents, configP, configSize);
    free(configP);
    configP = nullptr;
    if (ret != PROF_OK) {
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

int32_t DrvAicoreStart(const DrvPeripheralProfileCfg &peripheralCfg, const std::vector<int32_t> &profCores,
                   const std::vector<std::string> &profEvents)
{
    if (profEvents.size() > PMU_EVENT_MAX_NUM) {
        MSPROF_LOGE("profiling events size over %d, event_num=%zu", PMU_EVENT_MAX_NUM, profEvents.size());
        return PROFILING_FAILED;
    }
    const int32_t profDeviceId = peripheralCfg.profDeviceId;
    AI_DRV_CHANNEL profChannel = peripheralCfg.profChannel;
    uint32_t profSamplePeriod = (uint32_t)peripheralCfg.profSamplePeriod;
    uint32_t configSize = static_cast<uint32_t>(sizeof(TsAiCoreProfileConfigT));

    auto configP = static_cast<TsAiCoreProfileConfigT *>(malloc(configSize));
    if (configP == nullptr) {
        return PROFILING_FAILED;
    }
    (void)memset_s(configP, configSize, 0, configSize);
    configP->type = (uint32_t)TS_PROF_TYPE_SAMPLE_BASE;
    configP->almost_full_threshold = AI_CORE_SAMPLE_FULL_THRESHOLD;
    configP->period = (uint32_t)profSamplePeriod;
    configP->tag = static_cast<uint32_t>(Utils::IsDynProfMode());
    for (uint32_t i = 0; i < static_cast<uint32_t>(profCores.size()); i++) {
        configP->core_mask |= (static_cast<uint32_t>(1) << static_cast<uint32_t>(profCores[i]));
    }
    std::string eventStr;
    configP->event_num = static_cast<uint32_t>(profEvents.size());
    for (uint32_t i = 0; i < static_cast<uint32_t>(profEvents.size()); i++) {
        configP->event[i] = static_cast<uint32_t>(strtol(profEvents[i].c_str(), nullptr, STRING_TO_LONG_WEIGHT));
        (void)eventStr.append(profEvents[i] + ",");
    }
    MSPROF_EVENT("Begin to start profiling DrvAicoreStart, profDeviceId=%d, profChannel=%d, profSamplePeriod=%dms",
                 profDeviceId, static_cast<int32_t>(profChannel), profSamplePeriod);
    MSPROF_EVENT("DrvAicoreStart, period=%d, event_num=%d, events=%s, tag=%d", configP->period, configP->event_num,
                 eventStr.c_str(), configP->tag);
    struct prof_start_para profStartPara;
    profStartPara.channel_type = PROF_TS_TYPE;
    profStartPara.sample_period = (unsigned int)peripheralCfg.profSamplePeriod;
    profStartPara.real_time = PROFILE_REAL_TIME;
    profStartPara.user_data = configP;
    profStartPara.user_data_size = configSize;
    int32_t ret = DrvStart(static_cast<uint32_t>(profDeviceId), profChannel, &profStartPara);
    free(configP);
    configP = nullptr;
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start profiling DrvAicoreStart, profDeviceId=%d, profChannel=%d,"
                    " profSamplePeriod=%dms, ret=%d",
                    profDeviceId, static_cast<int32_t>(profChannel), profSamplePeriod, ret);
        return PROFILING_FAILED;
    }
    MSPROF_EVENT("Succeeded to start profiling DrvAicoreStart, profDeviceId=%d, profChannel=%d, profSamplePeriod=%dms",
                 profDeviceId, static_cast<int32_t>(profChannel), profSamplePeriod);
    return PROFILING_SUCCESS;
}

int32_t DrvAicoreTaskBasedStart(int32_t profDeviceId, AI_DRV_CHANNEL profChannel,
    const std::vector<std::string> &profEvents)
{
    if (profEvents.size() > PMU_EVENT_MAX_NUM) {
        MSPROF_LOGE("profiling events size over %d, event_num=%zu", PMU_EVENT_MAX_NUM, profEvents.size());
        return PROFILING_FAILED;
    }
    uint32_t configSize = static_cast<uint32_t>(sizeof(TsAiCoreProfileConfigT));

    auto configP = static_cast<TsAiCoreProfileConfigT *>(malloc(configSize));
    if (configP == nullptr) {
        return PROFILING_FAILED;
    }

    (void)memset_s(configP, configSize, 0, configSize);
    configP->type = (uint32_t)TS_PROF_TYPE_TASK_BASE;
    configP->event_num = static_cast<uint32_t>(profEvents.size());
    configP->tag = static_cast<uint32_t>(Utils::IsDynProfMode());
    std::string eventStr;
    for (uint32_t i = 0, j = 0; i < static_cast<uint32_t>(profEvents.size()) && j < PMU_EVENT_MAX_NUM; i++, j++) {
        configP->event[i] = static_cast<uint32_t>(strtol(profEvents[i].c_str(), nullptr, STRING_TO_LONG_WEIGHT));
        (void)eventStr.append(profEvents[i] + ",");
    }
    MSPROF_EVENT("Begin to start profiling DrvAicoreTaskBasedStart, profDeviceId=%d, profChannel=%d,"
                 " configSize:%dbytes",
                 profDeviceId, static_cast<int32_t>(profChannel), configSize);
    MSPROF_EVENT("DrvAicoreTaskBasedStart, event_num=%d, events=%s, tag=%d", configP->event_num, eventStr.c_str(),
                 configP->tag);
    struct prof_start_para profStartPara;
    profStartPara.channel_type = PROF_TS_TYPE;
    profStartPara.sample_period = 0;
    profStartPara.real_time = PROFILE_REAL_TIME;
    profStartPara.user_data = configP;
    profStartPara.user_data_size = configSize;
    const int32_t ret = DrvStart(static_cast<uint32_t>(profDeviceId), profChannel, &profStartPara);

    free(configP);
    configP = nullptr;

    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start profiling DrvAicoreTaskBasedStart, profDeviceId=%d,"
                    " profChannel=%d, ret=%d",
                    profDeviceId, static_cast<int32_t>(profChannel), ret);
        return PROFILING_FAILED;
    }

    MSPROF_EVENT("Succeeded to start profiling DrvAicoreTaskBasedStart,"
                 " profDeviceId=%d, profChannel=%d",
                 profDeviceId, static_cast<int32_t>(profChannel));

    return PROFILING_SUCCESS;
}

int32_t DrvAicpuStart(uint32_t profDeviceId, AI_DRV_CHANNEL profChannel)
{
    constexpr uint32_t aicpuDrvSamplePeriod = 10U;
    struct prof_start_para profStartPara = { .channel_type = PROF_PERIPHERAL_TYPE,
                                             .sample_period = aicpuDrvSamplePeriod,
                                             .real_time = PROFILE_REAL_TIME,
                                             .user_data = nullptr,
                                             .user_data_size = 0 };
    const int32_t ret = DrvStart(profDeviceId, profChannel, &profStartPara);
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start profiling DrvAicpuStart, profDeviceId=%u, profChannel=%d, ret=%d", profDeviceId,
                    static_cast<int32_t>(profChannel), ret);
        return PROFILING_FAILED;
    }
    MSPROF_EVENT("Succeeded to start profiling DrvAicpuStart, profDeviceId=%u, profChannel=%d", profDeviceId,
                 static_cast<int32_t>(profChannel));
    return PROFILING_SUCCESS;
}

int32_t DrvSocPmuTaskStart(int32_t profDeviceId, AI_DRV_CHANNEL profChannel,
    std::string &multiSocPmuEvents)
{
    const size_t configSize = DrvPackSocPmuSize(multiSocPmuEvents);
    auto configP = malloc(configSize);
    if (configP == nullptr) {
        return PROFILING_FAILED;
    }
    (void)memset_s(configP, configSize, 0, configSize);
    size_t configPos = 0;
    // pack head tlv
    SocPmuTlvCfg headTlv;
    headTlv.eventType = 0;
    headTlv.eventLen = configSize;
    errno_t err = memcpy_s(configP, configSize, &headTlv, sizeof(SocPmuTlvCfg));
    if (err != EOK) {
        free(configP);
        MSPROF_LOGE("Failed to copy soc pmu head, err: %d", err);
        return PROFILING_FAILED;
    }
    configPos += sizeof(SocPmuTlvCfg);
    // pack soc pmu data
    std::vector<std::string> socPmuEventList = Utils::Split(multiSocPmuEvents, false, "", ";");
    for (uint32_t i = 0; i < static_cast<uint32_t>(socPmuEventList.size()); ++i) {
        if (configPos >= configSize) {
            MSPROF_LOGW("Unable to pack soc pmu param, config pos: %zu, config size: %zu.", configPos, configSize);
            break;
        }
        DrvPackSocPmuParam(socPmuEventList[i], configP, configSize, configPos);
    }

    MSPROF_EVENT("Begin to start profiling DrvSocPmuTaskStart, profDeviceId=%d, profChannel=%d", profDeviceId,
                 static_cast<int32_t>(profChannel));
    struct prof_start_para profStartPara;
    profStartPara.sample_period = 0;
    profStartPara.real_time = PROFILE_REAL_TIME;
    profStartPara.user_data = configP;
    profStartPara.user_data_size = configSize;
    profStartPara.channel_type = PROF_TS_TYPE;
    const int32_t ret = DrvStart(static_cast<uint32_t>(profDeviceId), profChannel, &profStartPara);
    free(configP);
    configP = nullptr;
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start profiling DrvSocPmuTaskStart, profDeviceId=%d,"
                    " profChannel=%d, ret=%d",
                    profDeviceId, static_cast<int32_t>(profChannel), ret);
        return PROFILING_FAILED;
    }

    MSPROF_EVENT("Succeeded to start profiling DrvSocPmuTaskStart, profDeviceId=%d, profChannel=%d", profDeviceId,
                 static_cast<int32_t>(profChannel));
    return PROFILING_SUCCESS;
}

size_t DrvPackSocPmuSize(const std::string &socPmuEvents)
{
    size_t socPmuSize = sizeof(SocPmuTlvCfg);
    if (socPmuEvents.find(SOC_PMU_HA) != std::string::npos) {
        socPmuSize += (sizeof(SocPmuTlvCfg) + sizeof(SocPmuConfig));
    }
    if (socPmuEvents.find(SOC_PMU_MATA) != std::string::npos) {
        socPmuSize += (sizeof(SocPmuTlvCfg) + sizeof(SocPmuConfig));
    }
    if (socPmuEvents.find(SOC_PMU_SMMU) != std::string::npos) {
        socPmuSize += (sizeof(SocPmuTlvCfg) + sizeof(SocPmuConfig));
    }
    if (socPmuEvents.find(SOC_PMU_NOC) != std::string::npos) {
        socPmuSize += (sizeof(SocPmuTlvCfg) + sizeof(SocPmuNocConfig));
    }
    if (socPmuEvents.find(":") == std::string::npos) {
        socPmuSize += (sizeof(SocPmuTlvCfg) + sizeof(SocPmuConfig));
    }
    MSPROF_EVENT("Get soc pmu size: %zu, events: %s", socPmuSize, socPmuEvents.c_str());
    return socPmuSize;
}

void DrvCopySocPmuParam(const std::vector<std::string> &eventsList, void *configP, size_t configSize,
    size_t &configPos)
{
    SocPmuConfig cfg;
    (void)memset_s(&cfg, sizeof(SocPmuConfig), 0, sizeof(SocPmuConfig));
    cfg.eventNum = static_cast<uint32_t>(eventsList.size());
    for (uint32_t i = 0; i < eventsList.size(); i++) {
        cfg.event[i] = static_cast<uint16_t>(strtol(eventsList[i].c_str(), nullptr,
            STRING_TO_LONG_WEIGHT));
        MSPROF_LOGD("Pack soc pmu param, eventNum=%u, event=0x%x.", cfg.eventNum, cfg.event[i]);
    }
    FUNRET_CHECK_EXPR_ACTION_LOGW((configPos + sizeof(SocPmuConfig)) > configSize, return,
        "Soc pmu param overflow, configSize: %zu, configPos: %zu.");
    errno_t err = memcpy_s(static_cast<uint8_t *>(configP) + configPos, sizeof(SocPmuConfig), &cfg,
        sizeof(SocPmuConfig));
    FUNRET_CHECK_EXPR_ACTION(err != EOK, return, "Failed to copy soc pmu param.");
    configPos += sizeof(SocPmuConfig);
}

void DrvCopySocPmuNocParam(const std::vector<std::string> &eventsList, void *configP, size_t configSize,
    size_t &configPos)
{
    SocPmuNocConfig cfg;
    (void)memset_s(&cfg, sizeof(SocPmuNocConfig), 0, sizeof(SocPmuNocConfig));
    cfg.nocNum = static_cast<uint32_t>(eventsList.size());
    for (uint32_t i = 0; i < eventsList.size(); i++) {
        cfg.nocEvent[i] = static_cast<uint16_t>(strtol(eventsList[i].c_str(), nullptr,
            STRING_TO_LONG_WEIGHT));
        MSPROF_LOGD("Pack soc pmu param, nocNum=%u, nocEvent=0x%x.", cfg.nocNum, cfg.nocEvent[i]);
    }
    FUNRET_CHECK_EXPR_ACTION_LOGW((configPos + sizeof(SocPmuNocConfig)) > configSize, return,
        "Soc pmu param overflow, configSize: %zu, configPos: %zu.");
    errno_t err = memcpy_s(static_cast<uint8_t *>(configP) + configPos, sizeof(SocPmuNocConfig), &cfg,
        sizeof(SocPmuNocConfig));
    FUNRET_CHECK_EXPR_ACTION(err != EOK, return, "Failed to copy soc pmu noc param.");
    configPos += sizeof(SocPmuNocConfig);
}

void DrvCopySocPmuTlv(analysis::dvvp::driver::SocPmuTlvType type, void *configP, size_t configSize,
    size_t &configPos)
{
    SocPmuTlvCfg tlv;
    (void)memset_s(&tlv, sizeof(SocPmuTlvCfg), 0, sizeof(SocPmuTlvCfg));
    tlv.eventType = static_cast<uint16_t>(type);
    if (type == analysis::dvvp::driver::SocPmuTlvType::SOC_PMU_NOC_CFG) {
        tlv.eventLen = sizeof(SocPmuNocConfig);
    } else {
        tlv.eventLen = sizeof(SocPmuConfig);
    }
    FUNRET_CHECK_EXPR_ACTION_LOGW((configPos + sizeof(SocPmuTlvCfg)) > configSize, return,
        "Soc pmu param overflow, configSize: %zu, configPos: %zu.");
    errno_t err = memcpy_s(static_cast<uint8_t *>(configP) + configPos, sizeof(SocPmuTlvCfg), &tlv,
        sizeof(SocPmuTlvCfg));
    FUNRET_CHECK_EXPR_ACTION(err != EOK, return, "Failed to copy soc pmu tlv.");
    configPos += sizeof(SocPmuTlvCfg);
}

void DrvPackSocPmuParam(const std::string &socPmuEvents, void *configP, size_t configSize, size_t &configPos)
{
    std::vector<std::string> eventsList;
    if (socPmuEvents.compare(0, SOC_PMU_HA.size(), SOC_PMU_HA) == 0) {
        // ha tlv and cfg
        DrvCopySocPmuTlv(analysis::dvvp::driver::SocPmuTlvType::SOC_PMU_HA_CFG, configP, configSize, configPos);
        eventsList = Utils::Split(socPmuEvents.substr(SOC_PMU_HA.size()), false, "", ",");
        DrvCopySocPmuParam(eventsList, configP, configSize, configPos);
    } else if (socPmuEvents.compare(0, SOC_PMU_MATA.size(), SOC_PMU_MATA) == 0) {
        // mata tlv and cfg
        DrvCopySocPmuTlv(analysis::dvvp::driver::SocPmuTlvType::SOC_PMU_HA_CFG, configP, configSize, configPos);
        eventsList = Utils::Split(socPmuEvents.substr(SOC_PMU_MATA.size()), false, "", ",");
        DrvCopySocPmuParam(eventsList, configP, configSize, configPos);
    } else if (socPmuEvents.compare(0, SOC_PMU_SMMU.size(), SOC_PMU_SMMU) == 0) {
        // smmu tlv and cfg
        DrvCopySocPmuTlv(analysis::dvvp::driver::SocPmuTlvType::SOC_PMU_SMMU_CFG, configP, configSize, configPos);
        eventsList = Utils::Split(socPmuEvents.substr(SOC_PMU_SMMU.size()), false, "", ",");
        DrvCopySocPmuParam(eventsList, configP, configSize, configPos);
    } else if (socPmuEvents.compare(0, SOC_PMU_NOC.size(), SOC_PMU_NOC) == 0) {
        // noc tlv and cfg
        DrvCopySocPmuTlv(analysis::dvvp::driver::SocPmuTlvType::SOC_PMU_NOC_CFG, configP, configSize, configPos);
        eventsList = Utils::Split(socPmuEvents.substr(SOC_PMU_NOC.size()), false, "", ",");
        DrvCopySocPmuNocParam(eventsList, configP, configSize, configPos);
    } else {
        // ha tlv and cfg
        DrvCopySocPmuTlv(analysis::dvvp::driver::SocPmuTlvType::SOC_PMU_HA_CFG, configP, configSize, configPos);
        eventsList = Utils::Split(socPmuEvents, false, "", ",");
        DrvCopySocPmuParam(eventsList, configP, configSize, configPos);
    }
}

int32_t DrvL2CacheTaskStart(int32_t profDeviceId, AI_DRV_CHANNEL profChannel,
    const std::vector<std::string> &profEvents)
{
    uint32_t configSize =
        static_cast<uint32_t>(sizeof(TagTsL2CacheProfileConfig) + profEvents.size() * sizeof(uint32_t));
    auto configP = static_cast<TagTsL2CacheProfileConfig *>(malloc(configSize));
    if (configP == nullptr) {
        return PROFILING_FAILED;
    }

    (void)memset_s(configP, configSize, 0, configSize);
    configP->eventNum = static_cast<uint32_t>(profEvents.size());
    std::string eventStr;
    for (uint32_t i = 0; i < static_cast<uint32_t>(profEvents.size()); i++) {
        configP->event[i] = static_cast<uint32_t>(strtol(profEvents[i].c_str(), nullptr, STRING_TO_LONG_WEIGHT));
        (void)eventStr.append(profEvents[i] + ",");
        MSPROF_LOGI("Receive DrvL2CacheTaskEvent EventId=%d, EventCode=0x%x", i, configP->event[i]);
    }
    MSPROF_EVENT("Begin to start profiling DrvL2CacheTaskStart, profDeviceId=%d, profChannel=%d", profDeviceId,
                 static_cast<int32_t>(profChannel));
    MSPROF_EVENT("DrvL2CacheTaskStart, eventNum=%d, events=%s", configP->eventNum, eventStr.c_str());
    struct prof_start_para profStartPara;
    profStartPara.sample_period = 0;
    profStartPara.real_time = PROFILE_REAL_TIME;
    profStartPara.user_data = configP;
    profStartPara.user_data_size = configSize;
    profStartPara.channel_type = PROF_TS_TYPE;
    int32_t ret = DrvStart(static_cast<uint32_t>(profDeviceId), profChannel, &profStartPara);
    free(configP);
    configP = nullptr;
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start profiling DrvL2CacheTaskStart, profDeviceId=%d,"
                    " profChannel=%d, ret=%d",
                    profDeviceId, static_cast<int32_t>(profChannel), ret);
        return PROFILING_FAILED;
    }

    MSPROF_EVENT("Succeeded to start profiling DrvL2CacheTaskStart, profDeviceId=%d, profChannel=%d", profDeviceId,
                 static_cast<int32_t>(profChannel));

    return PROFILING_SUCCESS;
}

int32_t DrvSetTsCommandType(TsTsFwProfileConfigT &configP,
                        const SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> profileParams)
{
    if (profileParams == nullptr) {
        return PROFILING_FAILED;
    }
    if (profileParams->ts_task_track.compare("on") == 0) {
        configP.ts_task_track = TS_PROFILE_COMMAND_TYPE_PROFILING_ENABLE;
    }
    if (profileParams->ts_cpu_usage.compare("on") == 0) {
        configP.ts_cpu_usage = TS_PROFILE_COMMAND_TYPE_PROFILING_ENABLE;
    }
    if (profileParams->ai_core_status.compare("on") == 0) {
        configP.ai_core_status = TS_PROFILE_COMMAND_TYPE_PROFILING_ENABLE;
    }
    if (profileParams->ts_timeline.compare("on") == 0) {
        configP.ts_timeline = TS_PROFILE_COMMAND_TYPE_PROFILING_ENABLE;
    }
    if (profileParams->ai_vector_status.compare("on") == 0) {
        configP.ai_vector_status = TS_PROFILE_COMMAND_TYPE_PROFILING_ENABLE;
    }
    if (profileParams->ts_keypoint.compare("on") == 0) {
        configP.ts_keypoint = TS_PROFILE_COMMAND_TYPE_PROFILING_ENABLE;
    }
    if (profileParams->ts_memcpy.compare("on") == 0) {
        configP.ts_memcpy |= static_cast<uint32_t>(TS_PROFILE_COMMAND_TS_FW_AICPU_ENABLE);
        configP.ts_memcpy |= static_cast<uint32_t>(TS_PROFILE_COMMAND_TS_FW_MEMCPY_ENABLE);
    }
    if (profileParams->taskTsfw.compare("on") == 0) {
        configP.ts_memcpy |= static_cast<uint32_t>(TS_PROFILE_COMMAND_TS_FW_MANAGEMENT_ENABLE);
    }
	configP.tsBlockdim = TS_PROFILE_COMMAND_TYPE_PROFILING_ENABLE;
    return PROFILING_SUCCESS;
}

int32_t DrvTsFwStart(const DrvPeripheralProfileCfg &peripheralCfg,
                 const SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> profileParams)
{
    if (profileParams == nullptr) {
        return PROFILING_FAILED;
    }
    const int32_t profDeviceId = peripheralCfg.profDeviceId;
    AI_DRV_CHANNEL profChannel = peripheralCfg.profChannel;
    uint32_t profSamplePeriod = (uint32_t)peripheralCfg.profSamplePeriod;
    TsTsFwProfileConfigT configP;
    (void)memset_s(&configP, sizeof(TsTsFwProfileConfigT), 0, sizeof(TsTsFwProfileConfigT));
    configP.period = (uint32_t)profSamplePeriod;
    int32_t ret = DrvSetTsCommandType(configP, profileParams);
    if (ret != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    MSPROF_EVENT("Begin to start profiling DrvTsFwStart, profDeviceId=%d, profChannel=%d", profDeviceId,
                 static_cast<int32_t>(profChannel));
    MSPROF_LOGI("DrvTsFwStart profDeviceId=%d, profChannel=%d, taskTrack=%u, cpuUsage=%u, aiCoreStatus=%u, timeLine=%u,"
                " aiVecStatus=%u, keyPoint=%u, memCpy=%x",
                profDeviceId, static_cast<int32_t>(profChannel), configP.ts_task_track, configP.ts_cpu_usage,
                configP.ai_core_status, configP.ts_timeline, configP.ai_vector_status, configP.ts_keypoint,
                configP.ts_memcpy);
    struct prof_start_para profStartPara;
    profStartPara.channel_type = PROF_TS_TYPE;
    profStartPara.sample_period = (unsigned int)peripheralCfg.profSamplePeriod;
    profStartPara.real_time = PROFILE_REAL_TIME;
    profStartPara.user_data = &configP;
    profStartPara.user_data_size = sizeof(TsTsFwProfileConfigT);
    ret = DrvStart(static_cast<uint32_t>(profDeviceId), profChannel, &profStartPara);
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start profiling DrvTsFwStart, profDeviceId=%d, profChannel=%d, ret=%d", profDeviceId,
                    static_cast<int32_t>(profChannel), ret);
        return PROFILING_FAILED;
    }
    MSPROF_EVENT("Succeeded to start profiling DrvTsFwStart, profDeviceId=%d, profChannel=%d", profDeviceId,
                 static_cast<int32_t>(profChannel));
    return PROFILING_SUCCESS;
}

int32_t DrvStarsSocLogStart(const DrvPeripheralProfileCfg &peripheralCfg,
                        const SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> profileParams)
{
    if (profileParams == nullptr) {
        return PROFILING_FAILED;
    }
    uint32_t profDeviceId = static_cast<uint32_t>(peripheralCfg.profDeviceId);
    AI_DRV_CHANNEL profChannel = peripheralCfg.profChannel;
    StarsSocLogConfigT configP;
    (void)memset_s(&configP, sizeof(StarsSocLogConfigT), 0, sizeof(StarsSocLogConfigT));
    configP.tag = static_cast<uint32_t>(Utils::IsDynProfMode());
    if (profileParams->stars_acsq_task.compare(analysis::dvvp::common::config::MSVP_PROF_ON) == 0) {
        configP.acsq_task = TS_PROFILE_COMMAND_TYPE_PROFILING_ENABLE;
        configP.ffts_context_task = TS_PROFILE_COMMAND_TYPE_PROFILING_ENABLE;
    }
    if (profileParams->taskBlock.compare(analysis::dvvp::common::config::MSVP_PROF_ON) == 0) {
        configP.ffts_block = TS_PROFILE_COMMAND_TYPE_PROFILING_ENABLE;
    }

    if (profileParams->taskBlockShink.compare(analysis::dvvp::common::config::MSVP_PROF_ON) == 0) {
        configP.blockShinkFlag = TS_PROFILE_COMMAND_TYPE_PROFILING_ENABLE;
    }
    MSPROF_LOGI("DrvStarsSocLogStart profDeviceId=%u, profChannel=%d, acsq_task=%u, accPmu=%u, cdqm_reg=%u, "
                "dvpp_vpc_block=%u, dvpp_jpegd_block=%u, dvpp_jpede_block=%u, "
                "ffts_context_task=%u, ffts_block=%u, sdma_dmu=%u, tag=%u, block shink=%u.",
                profDeviceId, static_cast<int32_t>(profChannel), configP.acsq_task, configP.accPmu, configP.cdqm_reg,
                configP.dvpp_vpc_block, configP.dvpp_jpegd_block, configP.dvpp_jpede_block, configP.ffts_context_task,
                configP.ffts_block, configP.sdma_dmu, configP.tag, configP.blockShinkFlag);

    struct prof_start_para profStartPara;
    profStartPara.channel_type = PROF_TS_TYPE;
    profStartPara.sample_period = static_cast<uint32_t>(peripheralCfg.profSamplePeriod);
    profStartPara.real_time = PROFILE_REAL_TIME;
    profStartPara.user_data = &configP;
    profStartPara.user_data_size = sizeof(StarsSocLogConfigT);
    const int32_t ret = DrvStart(profDeviceId, profChannel, &profStartPara);
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start profiling DrvStarsSocLogStart, profDeviceId=%u, profChannel=%d, ret=%d",
                    profDeviceId, static_cast<int32_t>(profChannel), ret);
        return PROFILING_FAILED;
    }
    MSPROF_EVENT("Succeeded to start profiling DrvStarsSocLogStart, profDeviceId=%u, profChannel=%d", profDeviceId,
                 static_cast<int32_t>(profChannel));
    return PROFILING_SUCCESS;
}

template <class T>
void DrvPackPmuParam(int32_t mode, T &configP, const DrvPeripheralProfileCfg &peripheralCfg,
                     const std::vector<int32_t> &aiCores, const std::vector<std::string> &aiEvents)
{
    configP.aiEventCfg[mode].type = peripheralCfg.aicMode;
    configP.aiEventCfg[mode].period = static_cast<uint32_t>((mode == static_cast<int32_t>(FFTS_PROF_MODE_AIC)) ?
                                                                peripheralCfg.profSamplePeriod :
                                                                peripheralCfg.profSamplePeriodHi);

    for (uint32_t i = 0; i < aiCores.size(); i++) {
        configP.aiEventCfg[mode].coreMask |= (static_cast<uint32_t>(1) << static_cast<uint32_t>(aiCores[i]));
    }

    std::string eventStr;
    configP.aiEventCfg[mode].eventNum = static_cast<uint32_t>(aiEvents.size());
    for (uint32_t i = 0; i < aiEvents.size(); i++) {
        configP.aiEventCfg[mode].event[i] =
            static_cast<uint16_t>(strtol(aiEvents[i].c_str(), nullptr, STRING_TO_LONG_WEIGHT));
        eventStr.append(aiEvents[i]);
        if (i < aiEvents.size() - 1) {
            eventStr.append(",");
        }
    }
    MSPROF_EVENT("DrvPackPmuParam, mode:%d, period=%u, event_num=%u, events=%s", mode, configP.aiEventCfg[mode].period,
                 configP.aiEventCfg[mode].eventNum, eventStr.c_str());
}

int32_t DrvFftsProfileStart(const DrvPeripheralProfileCfg &peripheralCfg, const std::vector<int32_t> &aicCores,
                        const std::vector<std::string> &aicEvents, const std::vector<int32_t> &aivCores,
                        const std::vector<std::string> &aivEvents)
{
    StarsAccProfileConfigT *inCfg = static_cast<StarsAccProfileConfigT *>(peripheralCfg.configP);
    const int32_t profDeviceId = peripheralCfg.profDeviceId;
    AI_DRV_CHANNEL profChannel = peripheralCfg.profChannel;
    const uint32_t configSize = sizeof(FftsProfileConfigT);
    FftsProfileConfigT configP;
    (void)memset_s(&configP, configSize, 0, configSize);
    configP.tag = static_cast<uint16_t>(Utils::IsDynProfMode());
    configP.cfgMode = peripheralCfg.cfgMode;  // 0-none,1-aic,2-aiv,3-aic&aiv
    configP.aicScale = static_cast<uint16_t>(inCfg->aicScale);
    DrvPackPmuParam(static_cast<int32_t>(FFTS_PROF_MODE_AIC), configP, peripheralCfg, aicCores, aicEvents);
    DrvPackPmuParam(static_cast<int32_t>(FFTS_PROF_MODE_AIV), configP, peripheralCfg, aivCores, aivEvents);

    MSPROF_EVENT("DrvFftsProfileStart : cfgMode=%u, aicScale=%hu, tag=%hu",
        configP.cfgMode, configP.aicScale, configP.tag);
    struct prof_start_para profStartPara;
    profStartPara.channel_type = PROF_TS_TYPE;
    profStartPara.sample_period = 0;
    profStartPara.real_time = PROFILE_REAL_TIME;
    profStartPara.user_data = &configP;
    profStartPara.user_data_size = configSize;
    int32_t ret = DrvStart(static_cast<uint32_t>(profDeviceId), profChannel, &profStartPara);
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start profiling DrvFftsProfileStart, profDeviceId=%d, profChannel=%d, ret=%d",
                    profDeviceId, static_cast<int32_t>(profChannel), ret);
        return PROFILING_FAILED;
    }
    MSPROF_EVENT("Succeeded to start profiling DrvFftsProfileStart, profDeviceId=%d, profChannel=%d", profDeviceId,
                 static_cast<int32_t>(profChannel));
    return PROFILING_SUCCESS;
}

int32_t DrvAccProfileStart(DrvPeripheralProfileCfg &peripheralCfg, const std::vector<int32_t> &aicCores,
                           const std::vector<std::string> &aicEvents, const std::vector<int32_t> &aivCores,
                           const std::vector<std::string> &aivEvents)
{
    StarsAccProfileConfigT *inCfg = static_cast<StarsAccProfileConfigT *>(peripheralCfg.configP);
    const int32_t profDeviceId = peripheralCfg.profDeviceId;
    AI_DRV_CHANNEL profChannel = peripheralCfg.profChannel;
    uint32_t configSize = sizeof(StarsAccProfileConfigT);
    StarsAccProfileConfigT configP;
    (void)memset_s(&configP, configSize, 0, configSize);
    configP.tag = static_cast<uint32_t>(Utils::IsDynProfMode());
    configP.cfgMode = peripheralCfg.cfgMode;  // 0-none,1-aic,2-aiv,3-aic&aiv
    configP.aicScale = inCfg->aicScale;
    DrvPackPmuParam(static_cast<int32_t>(FFTS_PROF_MODE_AIC), configP, peripheralCfg, aicCores, aicEvents);
    DrvPackPmuParam(static_cast<int32_t>(FFTS_PROF_MODE_AIV), configP, peripheralCfg, aivCores, aivEvents);
    MSPROF_EVENT("DrvAccProfileStart : cfgMode=%u, tag=%d, scale=%u.", configP.cfgMode, configP.tag, configP.aicScale);
    struct prof_start_para profStartPara;
    profStartPara.channel_type = PROF_TS_TYPE;
    profStartPara.sample_period = peripheralCfg.profSamplePeriod;
    profStartPara.real_time = PROFILE_REAL_TIME;
    profStartPara.user_data = &configP;
    profStartPara.user_data_size = configSize;
    int32_t ret = DrvStart(static_cast<uint32_t>(profDeviceId), profChannel, &profStartPara);
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start profiling DrvAccProfileStart, profDeviceId=%d, profChannel=%d, ret=%d",
                    profDeviceId, static_cast<int32_t>(profChannel), ret);
        return PROFILING_FAILED;
    }
    MSPROF_EVENT("Succeeded to start profiling DrvAccProfileStart, profDeviceId=%d, profChannel=%d", profDeviceId,
                 static_cast<int32_t>(profChannel));
    return PROFILING_SUCCESS;
}

int32_t DrvCcuStart(const int32_t deviceId, const AI_DRV_CHANNEL channelId)
{
    MSPROF_EVENT("DrvCcuStart: deviceId=%u, channelId=%d.", deviceId, static_cast<int32_t>(channelId));
    struct prof_start_para profStartPara;
    profStartPara.channel_type = PROF_TS_TYPE;
    profStartPara.sample_period = 0;
    profStartPara.real_time = PROFILE_REAL_TIME;
    profStartPara.user_data = nullptr;
    profStartPara.user_data_size = 0;
    int32_t ret = DrvStart(static_cast<uint32_t>(deviceId), channelId, &profStartPara);
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start profiling DrvCcuStart, profDeviceId=%d, profChannel=%d, ret=%d",
                    deviceId, static_cast<int32_t>(channelId), ret);
        return PROFILING_FAILED;
    }
    MSPROF_EVENT("Succeeded to start profiling DrvCcuStart, profDeviceId=%d, profChannel=%d", deviceId,
                 static_cast<int32_t>(channelId));
    return PROFILING_SUCCESS;
}

int32_t DrvInstrProfileStart(const uint32_t devId, const AI_DRV_CHANNEL channelId, void *userData, size_t dataSize)
{
    MSPROF_EVENT("Begin to start profiling DrvInstrProfileStart: profDeviceId=%u, profChannel=%u.",
        devId, static_cast<uint32_t>(channelId));

    prof_start_para profStartPara;
    profStartPara.channel_type = PROF_TS_TYPE;
    profStartPara.sample_period = 0;
    profStartPara.real_time = PROFILE_REAL_TIME;
    profStartPara.user_data = userData;
    profStartPara.user_data_size = dataSize;
    int32_t ret = DrvStart(devId, channelId, &profStartPara);
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start profiling DrvInstrProfileStart, ret=%d, profDeviceId=%u, profChannel=%u, "
            ,ret, devId, static_cast<uint32_t>(channelId));
        return PROFILING_FAILED;
    }
    MSPROF_EVENT("Succeeded to start profiling DrvInstrProfileStart, profDeviceId=%u, profChannel=%u."
        ,devId, static_cast<uint32_t>(channelId));
    return PROFILING_SUCCESS;
}

int32_t DrvHwtsLogStart(int32_t profDeviceId, AI_DRV_CHANNEL profChannel)
{
    const uint32_t configSize = sizeof(TsHwtsProfileConfigT);
    TsHwtsProfileConfigT configP;
    (void)memset_s(&configP, configSize, 0, configSize);
    configP.tag = static_cast<uint32_t>(Utils::IsDynProfMode());
    MSPROF_EVENT("Begin to start profiling DrvHwtsLogStart, profDeviceId=%d, profChannel=%d, tag=%d", profDeviceId,
                 static_cast<int32_t>(profChannel), configP.tag);
    struct prof_start_para profStartPara;
    profStartPara.channel_type = PROF_TS_TYPE;
    profStartPara.sample_period = 0;
    profStartPara.real_time = PROFILE_REAL_TIME;
    profStartPara.user_data = &configP;
    profStartPara.user_data_size = configSize;
    int32_t ret = DrvStart(static_cast<uint32_t>(profDeviceId), profChannel, &profStartPara);
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start profiling DrvHwtsLogStart, profDeviceId=%d,"
                    " profChannel=%d, ret=%d",
                    profDeviceId, static_cast<int32_t>(profChannel), ret);
        return PROFILING_FAILED;
    }
    MSPROF_EVENT("Succeeded to start profiling DrvHwtsLogStart, profDeviceId=%d, profChannel=%d", profDeviceId,
                 static_cast<int32_t>(profChannel));

    return PROFILING_SUCCESS;
}

int32_t DrvFmkDataStart(int32_t devId, AI_DRV_CHANNEL profChannel)
{
    const uint32_t configSize = sizeof(TsHwtsProfileConfigT);

    TsHwtsProfileConfigT configP;
    (void)memset_s(&configP, configSize, 0, configSize);
    MSPROF_EVENT("Begin to start profiling DrvFmkDataStart, devId=%d, profChannel=%d", devId,
                 static_cast<int32_t>(profChannel));
    struct prof_start_para profStartPara;
    profStartPara.channel_type = PROF_TS_TYPE;
    profStartPara.sample_period = 0;
    profStartPara.real_time = PROFILE_REAL_TIME;
    profStartPara.user_data = &configP;
    profStartPara.user_data_size = configSize;
    int32_t ret = DrvStart(static_cast<uint32_t>(devId), profChannel, &profStartPara);
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start profiling DrvFmkDataStart, devId=%d, profChannel=%d, ret=%d", devId,
                    static_cast<int32_t>(profChannel), ret);
        return PROFILING_FAILED;
    }

    MSPROF_EVENT("Succeeded to start profiling DrvFmkDataStart, devId=%d, profChannel=%d", devId,
                 static_cast<int32_t>(profChannel));

    return PROFILING_SUCCESS;
}

int32_t DrvAdprofStart(int32_t profDeviceId, AI_DRV_CHANNEL profChannel)
{
    constexpr uint32_t adprofDrvSamplePeriod = 40U;
    struct prof_start_para profStartPara = { .channel_type = PROF_PERIPHERAL_TYPE,
                                             .sample_period = adprofDrvSamplePeriod,
                                             .real_time = PROFILE_REAL_TIME,
                                             .user_data = nullptr,
                                             .user_data_size = 0 };
    int32_t ret = DrvStart(static_cast<uint32_t>(profDeviceId), profChannel, &profStartPara);
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to start profiling DrvAdprofStart, profDeviceId=%d, profChannel=%d, ret=%d", profDeviceId,
                    static_cast<int32_t>(profChannel), ret);
        return PROFILING_FAILED;
    }
    MSPROF_EVENT("Succeeded to start profiling DrvAdprofStart, profDeviceId=%d, profChannel=%d", profDeviceId,
                 static_cast<int32_t>(profChannel));
    return PROFILING_SUCCESS;
}

int32_t DrvStart(uint32_t profDeviceId, AI_DRV_CHANNEL profChannel, prof_start_para *data)
{
    const int32_t ret = prof_drv_start(profDeviceId, static_cast<uint32_t>(profChannel), data);
    if (ret == PROF_OK) {
        return PROF_OK;
    }
    if (ret == DRV_NOT_ENOUGH_SUB_CHANNEL_RESOURCE) {
        MSPROF_LOGE("Prof channel[%u] of device[%u] is occupied, which may cause by multi-process."
            "Please shut down previous process and retry.", static_cast<uint32_t>(profChannel), profDeviceId);
    }
    if (ret == DRV_VF_SUB_RESOURCE_FULL) {
        MSPROF_LOGE("Prof channel[%u] of device[%u] has not enough resource, which may cause by multi-process."
            "Please shut down previous process and retry.", static_cast<uint32_t>(profChannel), profDeviceId);
    }
    if (ret == DRV_TS_NOT_BIND_CP_PROCESS) {
        MSPROF_LOGE("Prof channel[%u] of device[%u] start failed, which may cause by cp process not bind."
            "Please set device and retry.", static_cast<uint32_t>(profChannel), profDeviceId);
    }
    return ret;
}

int32_t DrvStop(int32_t profDeviceId, AI_DRV_CHANNEL profChannel)
{
    MSPROF_EVENT("Begin to stop profiling prof_stop DrvStop, profDeviceId=%d, profChannel=%d", profDeviceId,
                 static_cast<int32_t>(profChannel));
    int ret = prof_stop((uint32_t)profDeviceId, profChannel);
    if (ret != PROF_OK) {
        MSPROF_LOGE("Failed to stop profiling prof_stop DrvStop, profDeviceId=%d, profChannel=%d, ret=%d", profDeviceId,
                    static_cast<int32_t>(profChannel), ret);
        return PROFILING_FAILED;
    }
    MSPROF_EVENT("Succeeded to stop profiling prof_stop DrvStop, profDeviceId=%d, profChannel=%d", profDeviceId,
                 static_cast<int32_t>(profChannel));

    return PROFILING_SUCCESS;
}

int32_t DrvChannelRead(int32_t profDeviceId, AI_DRV_CHANNEL profChannel, UNSIGNED_CHAR_PTR outBuf, uint32_t bufSize)
{
    if (outBuf == nullptr) {
        MSPROF_LOGE("outBuf is nullptr");
        return PROFILING_FAILED;
    }
    int ret = prof_channel_read((uint32_t)profDeviceId, profChannel, reinterpret_cast<CHAR_PTR>(outBuf), bufSize);
    if (ret < 0) {
        if (ret == PROF_STOPPED_ALREADY) {
            MSPROF_LOGW("profChannel has stopped already, profDeviceId=%d, profChannel=%d, bufSize=%dbytes",
                        profDeviceId, static_cast<int32_t>(profChannel), bufSize);
            return 0;  // data len is 0
        }
        MSPROF_LOGE("Failed to prof_channel_read, profDeviceId=%d, profChannel=%d, bufSize=%dbytes, ret=%d",
                    profDeviceId, static_cast<int32_t>(profChannel), bufSize, ret);
        return PROFILING_FAILED;
    }

    return ret;
}

int32_t DrvChannelPoll(PROF_POLL_INFO_PTR outBuf, int32_t num, int32_t timeout)
{
    if (outBuf == nullptr) {
        MSPROF_LOGE("outBuf is nullptr");
        return PROFILING_FAILED;
    }
    const int32_t ret = prof_channel_poll(outBuf, num, timeout);
    if (ret == PROF_ERROR || ret > num) {
        MSPROF_LOGE("Failed to prof_channel_poll, num=%d, timeout=%ds, ret=%d", num, timeout, ret);
        return PROFILING_FAILED;
    }

    return ret;
}

int32_t DrvProfFlush(uint32_t deviceId, uint32_t channelId, uint32_t &bufSize)
{
#if (defined(linux) || defined(__linux__))
    MSPROF_LOGI("Begin to flush drv buff. deviceId=%u, channelId=%u", deviceId, channelId);
    int32_t ret = halProfDataFlush(deviceId, channelId, &bufSize);
    if (ret == PROF_OK) {
        MSPROF_LOGI("End to flush drv buff. deviceId=%u, channelId=%u, bufSize=%ubytes", deviceId, channelId, bufSize);
        return PROFILING_SUCCESS;
    }
    if (ret == PROF_STOPPED_ALREADY) {
        MSPROF_LOGE("Failed to halProfDataFlush, channel already closed.deviceId=%u, channelId=%u", deviceId,
                    channelId);
        MSPROF_CALL_ERROR("EK9999", "Failed to halProfDataFlush, channel already closed.deviceId=%u, channelId=%u",
                          deviceId, channelId);
        return PROFILING_FAILED;
    } else {
        MSPROF_LOGE("Failed to halProfDataFlush.deviceId=%u, channelId=%u, ret=%d", deviceId, channelId, ret);
        MSPROF_CALL_ERROR("EK9999", "Failed to halProfDataFlush.deviceId=%u, channelId=%u, ret=%d", deviceId, channelId,
                          ret);
        return PROFILING_FAILED;
    }
#else
    MSPROF_LOGW("Function halProfDataFlush not supported, deviceId=%u, channelId=%u", deviceId, channelId);
    return PROFILING_FAILED;
#endif
}
}  // namespace driver
}  // namespace dvvp
}  // namespace analysis
