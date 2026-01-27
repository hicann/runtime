/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "op_analyzer_biu.h"
#include <algorithm>
#include "ai_drv_dev_api.h"
#include "ai_drv_dsmi_api.h"
#include "json/json.h"

namespace Dvvp {
namespace Acp {
namespace Analyze {
    
using namespace Analysis::Dvvp::Driver;

OpAnalyzerBiu::OpAnalyzerBiu() : inited_(false), countTimes_(0), group_(0), groupTag_(0), aicFreq_(0.0), aivFreq_(0.0)
{
    instructionMap_ = {
        {0, "SU"}, {1, "Vector"}, {2, "Cube"}, {3, "MTE1"}, {4, "MTE2"}, {5, "MTE3"}, {6, "Fixp"}
    };
    mappingList_ = {{"aic", 0}, {"aiv0", 1}, {"aiv1", 2}};
}

bool OpAnalyzerBiu::IsBiuPerfData(const std::string &fileName) const
{
    if (fileName.find("biu_perf_group") != std::string::npos && (fileName.find("aic") != std::string::npos ||
        fileName.find("aiv0") != std::string::npos || fileName.find("aiv1") != std::string::npos)) {
        return true;
    }
    return false;
}

/**
 * @brief      Set the basic time of the host-device. collectionTimeBegin is based on host time with unit ns.
 * @param [in] freq: Device frequency.
 * @param [in] deviceId: Device id.
 * @return     void
 */
void OpAnalyzerBiu::SetDeviceInfo(uint32_t deviceId, double freq, double aicFreq)
{
    frequency_ = freq; // 1 / GHZ = ns
    FUNRET_CHECK_EXPR_ACTION(frequency_ <= 0, return, "The frequency %lf is less than or equal to 0.", frequency_);
    aicFreq_ = aicFreq; // 1 / MHZ = us
    FUNRET_CHECK_EXPR_ACTION(aicFreq_ <= 0, return, "The aic freq %lf is less than or equal to 0. %s", aicFreq_);
    std::string aivFreq = DrvGeAivFrq(static_cast<int32_t>(deviceId));
    FUNRET_CHECK_EXPR_ACTION(!Utils::StrToDouble(aivFreq_, aivFreq) || aivFreq_ <= 0, return,
        "Convert aivFreq failed or aiv freq equal to 0, value is %s", aivFreq.c_str());
    inited_ = true;
}

/**
 * @brief      The file name is parsed, the group number and group target(aic, aiv0, aiv1) are obtained.
 * @param [in] fileName: File name, read from filechunk.
 * @return     true: Parsing the name succeeded. 
 *             false: Parsing the name failed.
 */
bool OpAnalyzerBiu::SplitFileName(const std::string &fileName)
{
    size_t groupPos = fileName.find("biu_perf_group");
    size_t underline = fileName.find_last_of("_");
    size_t dotPos = fileName.find_last_of(".");
    if (groupPos == std::string::npos || underline == std::string::npos || dotPos == std::string::npos) {
        MSPROF_LOGE("Can not find target in %s", fileName.c_str());
        return false;
    }
    FUNRET_CHECK_EXPR_ACTION(groupPos >= underline || underline >= dotPos, return false, "The obtained cursor is"
        "abnormal. group pos is %" PRIu64 ", underline is %" PRIu64 ", dot pos is %" PRIu64 ", in fileName %s.",
        groupPos, underline, dotPos, fileName.c_str());
    std::string groupNumber = fileName.substr(groupPos + GROUP_STR_LEN, underline - groupPos - GROUP_STR_LEN);
    std::string groupTag = fileName.substr(underline + 1, dotPos - underline - 1);
    if (!Utils::StrToUint32(group_, groupNumber)) {
        MSPROF_LOGE("Handle group number %s failed.", groupNumber.c_str());
        return false;
    }
    FUNRET_CHECK_EXPR_ACTION(group_ >= GROUP_NUM_MAX, return false, "Group number %u exceeds the maximum value %d.",
        group_, GROUP_NUM_MAX);
    auto iter = mappingList_.find(groupTag);
    if (iter != mappingList_.end()) {
        groupTag_ = iter->second;
    } else {
        MSPROF_LOGE("Handle group tag %s failed.", groupTag.c_str());
        return false;
    }
    MSPROF_LOGD("Split file name to group %u and tag %u.", group_, groupTag_);
    return true;
}

/**
 * @brief      The main entry of biu perf data. It parses data and distributes different ctrl types of data to
 *              corresponding parsing modules.
 * @param [in] fileChunkReq: Data struct packed from the channel data.
 * @return     void
 */
void OpAnalyzerBiu::ParseBiuData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    FUNRET_CHECK_EXPR_ACTION(!inited_, return, "ParseBiuData is not been initialized.");
    FUNRET_CHECK_EXPR_ACTION(fileChunkReq == nullptr, return, "Received nullptr filechunk data.");
    dataPtr_ = fileChunkReq->chunk.c_str();
    dataLen_ = fileChunkReq->chunkSize;
    if (!SplitFileName(fileChunkReq->fileName)) {
        MSPROF_LOGE("Split file name %s failed, when parse biu data.", fileChunkReq->fileName.c_str());
        return;
    }
    MSPROF_LOGD("ParseBiuData received %u bytes data.", dataLen_);
    uint32_t offset = 0;
    while (dataPtr_ != nullptr && offset < dataLen_) {
        uint32_t remainingLen = dataLen_ - offset;
        if (remainingLen < BIU_DATA_SIZE) {
            break;
        }
        countTimes_++;
        auto biuPerfData = reinterpret_cast<const BiuPerfProfile *>(dataPtr_ + offset);
        switch (static_cast<CtrlType>(biuPerfData->ctrlType)) {
            case CtrlType::CTRL_SU:
            case CtrlType::CTRL_VEC:
            case CtrlType::CTRL_CUBE:
            case CtrlType::CTRL_MTE1:
            case CtrlType::CTRL_MTE2:
            case CtrlType::CTRL_MTE3:
            case CtrlType::CTRL_FIXP:
                HandleStampData(biuPerfData);
                break;
            case CtrlType::CTRL_START_STAMP:
                HandleSyscnt(biuPerfData);
                break;
            case CtrlType::CTRL_STATE:
                HandleStatusData(biuPerfData);
                break;
            default:
                MSPROF_LOGW("Unexpected ctrl type %hu received.", biuPerfData->ctrlType);
                break;
        }
        offset += BIU_DATA_SIZE;
    }
    if (offset < dataLen_) {
        MSPROF_LOGE("Biu perf data remains %u bytes unparsed.", (dataLen_ - offset));
    }
}

/**
 * @brief      Process the timestamp data (with ctrl type 0,1,2,3,4,5,10). In this part, the data is directly saved to
 *              json, as the durations is 0.
 * @param [in] data: A piece of biu perf data converted by BiuPerfProfile.
 * @return     void
 */
void OpAnalyzerBiu::HandleStampData(const BiuPerfProfile *data)
{
    if (biuData_[group_][groupTag_].initTimes != SYSCNT_DATA_TIMES) {
        MSPROF_LOGE("HandleStampData failed in group %u tag %u as syscnt data only have %u.",
            group_, groupTag_, biuData_[group_][groupTag_].initTimes);
        return;
    }
    if (groupTag_ == 0) { // aic is 0, aiv is 1 or 2
        biuData_[group_][groupTag_].baseTime += data->timeData / aicFreq_; // us
    } else {
        biuData_[group_][groupTag_].baseTime += data->timeData / aivFreq_; // us
    }
    NanoJson::Json metaData;
    metaData["name"] = ""; // No need to name this
    metaData["ph"] = "X"; // Complete events
    metaData["pid"] = group_;
    metaData["tid"] = ConvCtrlToInstr(data->ctrlType);
    metaData["ts"] = biuData_[group_][groupTag_].baseTime;
    metaData["dur"] = 0; // No need to set
    metaData["args"]["block id"] = biuData_[group_][groupTag_].blockId;
    metaData["args"]["registered id"] = data->events;
    metaData["args"]["begin time"] = biuData_[group_][groupTag_].baseTime;
    biuData_[group_][groupTag_].data += metaData.ToString() + ",";
    MSPROF_LOGD("StampData from group %u-%u with data %s", group_, groupTag_, biuData_[group_][groupTag_].data.c_str());
}

/**
 * @brief      Basic time information processing. This part needs to be executed four times for each channel to assemble
 *              complete time information.
 * @param [in] data: A piece of biu perf data converted by BiuPerfProfile.
 * @return     void
 */
void OpAnalyzerBiu::HandleSyscnt(const BiuPerfProfile *data)
{
    if (biuData_[group_][groupTag_].initTimes >= SYSCNT_DATA_TIMES) {
        MSPROF_LOGE("HandleSyscnt reads an unexpected amount of data in group %u tag %u", group_, groupTag_);
        return;
    }
    // assemble the syscnt
    constexpr uint32_t offset16Bit = 16;
    constexpr uint32_t offset8Bit = 8;
    biuData_[group_][groupTag_].sysCnt |= (static_cast<uint64_t>(data->timeData) <<
        (offset16Bit * biuData_[group_][groupTag_].initTimes));
    // assemble the block id
    if (biuData_[group_][groupTag_].initTimes < BLOCK_ID_TIMES) {
        biuData_[group_][groupTag_].blockId |= (static_cast<uint16_t>(data->events) <<
        (offset8Bit * biuData_[group_][groupTag_].initTimes));
    }
    biuData_[group_][groupTag_].initTimes++;
    if (biuData_[group_][groupTag_].initTimes == SYSCNT_DATA_TIMES) {
        SaveCntData();
    }
}

void OpAnalyzerBiu::SaveCntData()
{
    // This will trigger only once for each channel of data
    biuData_[group_][groupTag_].baseTime = biuData_[group_][groupTag_].sysCnt / (frequency_ * US_CONVERT_NS); // us
    // create group
    NanoJson::Json metaData;
    metaData["name"] = "process_name"; // The name is fixed.
    metaData["ph"] = "M"; // Metadate events
    metaData["pid"] = group_;
    metaData["args"]["name"] = "group" + std::to_string(group_);
    metaData["args"]["begin time"] = biuData_[group_][groupTag_].baseTime;
    biuData_[group_][groupTag_].data += metaData.ToString() + ",";
    // create instruction for group
    for(auto it = instructionMap_.begin(); it != instructionMap_.end(); it++) {
        NanoJson::Json metaDataThread;
        metaDataThread["name"] = "thread_name"; // The name is fixed.
        metaDataThread["ph"] = "M";
        metaDataThread["pid"] = group_;
        metaDataThread["tid"] = it->first;
        metaDataThread["args"]["name"] = it->second;
        metaDataThread["args"]["begin time"] = biuData_[group_][groupTag_].baseTime;
        biuData_[group_][groupTag_].data += metaDataThread.ToString() + ",";
    }
    MSPROF_LOGD("Syscnt from group %u-%u with data %s", group_, groupTag_, biuData_[group_][groupTag_].data.c_str());
}

/**
 * @brief      Cycle time of instructions processed. The value 1 or 0 of the corresponding bit indicates the busy or
 *              idle status. When the value is 1, the current time is recorded. When the value changes to 0, the
 *              durations is computed and json data is generated.
 * @param [in] data: A piece of biu perf data converted by BiuPerfProfile.
 * @return     void
 */
void OpAnalyzerBiu::HandleStatusData(const BiuPerfProfile *data)
{
    if (biuData_[group_][groupTag_].initTimes != SYSCNT_DATA_TIMES) {
        MSPROF_LOGE("HandleStatusData failed in group %u tag %u as syscnt data only have %u.",
            group_, groupTag_, biuData_[group_][groupTag_].initTimes);
        return;
    }
    std::vector<uint16_t> checkList = CheckBits(data->events);
    if (groupTag_ == 0) { // aic is 0, aiv is 1 or 2
        biuData_[group_][groupTag_].baseTime += data->timeData / aicFreq_; // us
    } else {
        biuData_[group_][groupTag_].baseTime += data->timeData / aivFreq_; // us
    }

    for (uint32_t idx = 0; idx < INSTR_TYPE_NUM_MAX; idx++) {
        bool isChanged = CheckNumberExist(checkList, idx);
        // Both in busy or idle status, nothing need to do.
        if (isChanged == biuData_[group_][groupTag_].instrMap[idx].isBusy) {
            continue;
        }
        // ready for start, save start time and status(busy)
        if (isChanged && !biuData_[group_][groupTag_].instrMap[idx].isBusy) {
            HandleInstrStart(idx);
            continue;
        }
        // time to stop, compute dur and save data to json
        if (!isChanged && biuData_[group_][groupTag_].instrMap[idx].isBusy) {
            HandleInstrStop(idx);
            continue;
        }
    }
}

/**
 * @brief      Record the active status of the instruction of the corresponding channel.
 * @param [in] idx: Which instruction is change to 1(busy)
 * @return     void
 */
void OpAnalyzerBiu::HandleInstrStart(uint32_t idx)
{
    biuData_[group_][groupTag_].instrMap[idx].timeStart = biuData_[group_][groupTag_].baseTime;
    biuData_[group_][groupTag_].instrMap[idx].isBusy = true;
}

/**
 * @brief      Record the idle status of the instruction of the corresponding channel.
 * @param [in] idx: Which instruction is change to 0(idle)
 * @return     void
 */
void OpAnalyzerBiu::HandleInstrStop(uint32_t idx)
{
    FUNRET_CHECK_EXPR_ACTION(biuData_[group_][groupTag_].instrMap[idx].timeStart >
        biuData_[group_][groupTag_].baseTime, return, "The end of time %f is lower than %f.",
        biuData_[group_][groupTag_].baseTime, biuData_[group_][groupTag_].instrMap[idx].timeStart);
    NanoJson::Json eventData;
    eventData["name"] = ""; // No need to named it.
    eventData["ph"] = "X";  // Complete events
    eventData["pid"] = group_;
    eventData["tid"] = idx;
    eventData["ts"] = biuData_[group_][groupTag_].instrMap[idx].timeStart;
    eventData["dur"] = biuData_[group_][groupTag_].baseTime - biuData_[group_][groupTag_].instrMap[idx].timeStart;
    eventData["args"]["block id"] = biuData_[group_][groupTag_].blockId;
    eventData["args"]["begin time"] = biuData_[group_][groupTag_].instrMap[idx].timeStart;
    biuData_[group_][groupTag_].data += eventData.ToString() + ",";
    biuData_[group_][groupTag_].instrMap[idx].isBusy = false;
    MSPROF_LOGD("Syscnt from group %u-%u with data %s", group_, groupTag_, biuData_[group_][groupTag_].data.c_str());
}

std::vector<uint16_t> OpAnalyzerBiu::CheckBits(uint16_t instrStatus) const
{
    // Check which status changes to 1
    std::vector<uint16_t> result;
    for (uint16_t idx = 0; idx < EVENT_BIT_WIDTH_NUM; idx++) {
        if ((instrStatus & (1 << idx)) != 0) {
            result.push_back(idx);
        }
    }
    return result;
}

bool OpAnalyzerBiu::CheckNumberExist(std::vector<uint16_t> checkList, uint16_t num) const
{
    // true: this number exists. false: this number not exists.
    return std::find(checkList.begin(), checkList.end(), num) != checkList.end();
}

void OpAnalyzerBiu::SaveDataToFile(std::string path)
{
    // true: this number exists. false: this number not exists.
    std::string biuStringData;
    for (uint32_t group = 0; group < GROUP_NUM_MAX; group++) {
        for (uint32_t groupTag = 0; groupTag < GROUP_TYPE_NUM_MAX; groupTag++) {
            if (biuData_[group][groupTag].data.empty()) {
                continue;
            }
            biuStringData.append(biuData_[group][groupTag].data);
        }
    }
    if (biuStringData.empty()) {
        MSPROF_LOGI("Biu data is empty, nothing need to do.");
        return;
    }
    // remove comma at the end of string
    if (biuStringData.back() == ',') {
        biuStringData.pop_back();
    }
    // Prevents file collisions when creating multiple times
    static uint64_t createTimes = 0;
    path += "instr_timeline_" + std::to_string(createTimes) + ".json";
    Utils::GenTimeLineJsonFile(path, biuStringData);
    createTimes++;
    FUNRET_CHECK_EXPR_ACTION_LOGW(createTimes >= UINT64_MAX, createTimes = 0, "Overflow detected! Resetting json file"
        "creation times.")
    MSPROF_LOGI("The Json file has been created, path: %s.", path.c_str());
}

uint16_t OpAnalyzerBiu::ConvCtrlToInstr(uint16_t ctrlType) const
{
    // fixp type is different from ctrl type.
    if (ctrlType == INSTR_FIXP_CTRL_TYPE_NUM) {
        ctrlType = INSTR_FIXP_TYPE_NUM;
    }
    return ctrlType;
}

void OpAnalyzerBiu::PrintStats() const
{
    MSPROF_EVENT("OpAnalyzerBiu total_size_biu, data processed %" PRIu64 " times, data size %" PRIu64 " bytes.",
        countTimes_, countTimes_ * BIU_DATA_SIZE);
}

bool OpAnalyzerBiu::IsBiuMode() const
{
    if (countTimes_ > 0) {
        return true;
    }
    return false;
}
}
}
}