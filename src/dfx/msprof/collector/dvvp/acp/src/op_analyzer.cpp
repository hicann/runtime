/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "op_analyzer.h"
#include "op_analyzer_base.h"
#include "op_data_manager.h"
#include "config/config.h"
#include "data_struct.h"
#include "errno/error_code.h"
#include "prof_params.h"
#include "pmu_calculator.h"
#include "ai_drv_dev_api.h"
#include "ai_drv_dsmi_api.h"

namespace Dvvp {
namespace Acp {
namespace Analyze {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::driver;
using namespace Analysis::Dvvp::Driver;
constexpr uint32_t FLOAT_PRECISION = 3;
constexpr uint32_t PRECISION_CONVERT = 1000;
constexpr uint16_t SEPARATE_BLOCK_DIM_NUM = 16;
constexpr uint32_t SEPARATE_BLOCK_DIM_BITS = 0xFFFF;
constexpr uint32_t NS_CONVERT_US = 1000;
constexpr float DEFAULT_FLOAT_VALUE = 0.0f;
constexpr uint32_t MAX_DAVID_MONITOR_NUM = 10;
constexpr uint32_t MAX_OP_SUMMARY_SUFFIX_START = 7;
constexpr uint32_t MAX_OP_SUMMARY_SUFFIX_LEN = 14;
const std::string OP_SUMMARY_NAME = "op_summary_";

OpAnalyzer::OpAnalyzer() : inited_(false), metricsPmuNum_(0),
    aicCoreNum_(0), aivCoreNum_(0), aicFreq_(0), highBlockDim_(0), lowBlockDim_(0),
    replayTime_(0)
{
    MSVP_MAKE_SHARED0(analyzerPmu_, OpAnalyzerPmu, return);
    MSVP_MAKE_SHARED0(analyzerBiu_, OpAnalyzerBiu, return);
    inited_ = true;
    if (Platform::instance()->InitOnlineAnalyzer() != PROFILING_SUCCESS) {
        inited_ = false;
        MSPROF_LOGE("Failed to init online analyzer, reset inited_ to false.");
    }
}

OpAnalyzer::~OpAnalyzer()
{}

void OpAnalyzer::InitAnalyzerByDeviceId(const std::string &deviceId)
{
    uint32_t devId = 0;
    if (!Utils::StrToUint32(devId, deviceId)) {
        inited_ = false;
        MSPROF_LOGE("Failed to convert device id: %s to uint32.", deviceId.c_str());
        return;
    }
    if ((analyzerPmu_->InitFrequency(devId) != PROFILING_SUCCESS)) {
        inited_ = false;
        MSPROF_LOGE("Failed to init frequency, reset inited_ to false.");
        return;
    }
    if (DrvGetAiCoreNum(devId, aicCoreNum_) != PROFILING_SUCCESS) {
        inited_ = false;
        MSPROF_LOGE("Failed to get aicore num, reset inited_ to false.");
        return;
    }
    if (DrvGetAivNum(devId, aivCoreNum_) != PROFILING_SUCCESS) {
        inited_ = false;
        MSPROF_LOGE("Failed to get aiv core num, reset inited_ to false.");
        return;
    }
    std::string aicFreq = DrvGeAicFrq(static_cast<int32_t>(devId));
    aicFreq_ = stod(aicFreq);
    analyzerBiu_->SetDeviceInfo(devId, analyzerPmu_->frequency_, aicFreq_);
    MSPROF_LOGI("Success to get device freq: %lf ghz, aic freq: %lf mhz, ai core num: %lld, "
        "aivector core num: %lld.", analyzerPmu_->frequency_, aicFreq_, aicCoreNum_, aivCoreNum_);
}

/**
 * @brief Analyze op data delivered by op transport
 * @param [in] fileChunkReq: file chunk
 * @return
 */
void OpAnalyzer::OnOpData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (!inited_) {
        MSPROF_LOGE("OpAnalyzer is not been inited!");
        return;
    }
    if (fileChunkReq == nullptr || fileChunkReq->fileName.empty()) {
        MSPROF_LOGW("OpAnalyzer get invalid data for analyzing.");
        return;
    }

    if (fileChunkReq->fileName.find("end_info") != std::string::npos) {
        std::string replayStr = Utils::GetInfoSuffix(fileChunkReq->fileName);
        FUNRET_CHECK_EXPR_ACTION(!Utils::StrToUint32(replayTime_, replayStr), return,
            "Failed to convert replay time string, file name: %s.", fileChunkReq->fileName.c_str());
        std::unique_lock<std::mutex> lk(flushMtx_);
        OpAssociation(fileChunkReq);
        uint32_t analyzeCnt = OpDataManager::instance()->GetAnalyzeCount();
        MSPROF_LOGI("OpAnalyzer get kernel replay time: %u, finish analyze count: %u.", replayTime_, analyzeCnt);
        if (analyzeCnt == KERNEL_EXECUTE_TIME * replayTime_) {
            FlushOpData(fileChunkReq);
            OpDataManager::instance()->UnInit();
        }
        analyzerPmu_->logInfo_.clear();
        analyzerPmu_->subTaskInfo_.clear();
        analyzerPmu_->blockInfo_.clear();
        flushCv_.notify_one();
        return;
    }
    DispatchOpData(fileChunkReq);
}

/**
 * @brief Dispatch op data by file name
 * @param [in] fileChunkReq: file chunk
 * @return
 */
void OpAnalyzer::DispatchOpData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    MSPROF_LOGI("Dispatch op data, name: %s.", fileChunkReq->fileName.c_str());
    if (analyzerPmu_->IsStarsData(fileChunkReq->fileName)) {
        analyzerPmu_->ParseStarsData(fileChunkReq);
    } else if (analyzerPmu_->IsFftsData(fileChunkReq->fileName)) {
        analyzerPmu_->ParseFftsData(fileChunkReq);
    } else if (pcSampling_.IsPcSamplingData(fileChunkReq->fileName)) {
        pcSampling_.ParsePcSamplingData(fileChunkReq);
    } else if (analyzerBiu_->IsBiuPerfData(fileChunkReq->fileName)) {
        analyzerBiu_->ParseBiuData(fileChunkReq);
    } else {
        MSPROF_LOGI("OpAnalyzer drop data, fileName: %s.", fileChunkReq->fileName.c_str());
        return;
    }
}

/**
 * @brief Op data association
 * @param [in] fileChunkReq: file chunk
 * @return
 */
void OpAnalyzer::OpAssociation(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    PreAssociation(fileChunkReq);
    // associate subtask info with block info
    if (!analyzerPmu_->blockInfo_.empty()) {
        BlockAssociation();
    }

    // associate log info with subtask info
    SubTaskAssociation();
    // save log info data to summary info
    StoreAssociation();
}

/**
 * @brief Prepare metrics and block dim for op data association
 * @param [in] fileChunkReq: file chunk
 * @return
 */
void OpAnalyzer::PreAssociation(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    analyzerPmu_->PrintStats();
    analyzerBiu_->PrintStats();
    std::string name = fileChunkReq->chunk;     // use chunk to pass pmu metrics type
    metricsPmuNum_ = Platform::instance()->GetMetricsPmuNum(name);
    FUNRET_CHECK_EXPR_PRINT(metricsPmuNum_ == 0, "Failed to get metrics pmu num, name: %s.", name.c_str());
    OpDataManager::instance()->AddMetrics(name);

    uint32_t blockDim = 0;
    FUNRET_CHECK_EXPR_PRINT(!Utils::StrToUint32(blockDim, fileChunkReq->id),
        "Failed to convert block dim from end_info data id str: %s.", fileChunkReq->id);
    lowBlockDim_ = blockDim & SEPARATE_BLOCK_DIM_BITS;
    highBlockDim_ = lowBlockDim_ + lowBlockDim_; // default set 1:2 ratio
    MSPROF_LOGI("Get main block dim: %u, slave block dim: %u.", lowBlockDim_, highBlockDim_);
}

/**
 * @brief Block data association, which associate subtask data with block data
 * @return
 */
void OpAnalyzer::BlockAssociation()
{
    for (auto iter = analyzerPmu_->subTaskInfo_.begin();
        iter != analyzerPmu_->subTaskInfo_.end(); iter++) {
        for (uint16_t n = 0; n < highBlockDim_; n++) {
            BlockInfoMatch(iter->first, iter->second);
        }
    }
}

/**
 * @brief Match subtask data with block data
 * @param [in] key: task id + stream id + context id
 * @param [in] value: kernel detail
 * @return
 */
void OpAnalyzer::BlockInfoMatch(std::string key, KernelDetail &value)
{
    // find first match
    auto iter = analyzerPmu_->blockInfo_.find(key);
    if (iter == analyzerPmu_->blockInfo_.end()) {
        return;
    }

    value.aicTotalCycle += iter->second.aicTotalCycle;
    value.aivTotalCycle += iter->second.aivTotalCycle;
    value.aicCnt += iter->second.aicCnt;
    value.aivCnt += iter->second.aivCnt;
    MSPROF_LOGI("BlockInfoMatch key: %s, aic total cycle: %llu, aiv total cycle: %llu, aic cnt: %llu, aiv cnt: %llu.",
        key.c_str(), iter->second.aicTotalCycle, iter->second.aivTotalCycle, iter->second.aicCnt, iter->second.aivCnt);
    uint32_t pmuLen = 2 * analyzerPmu_->pmuNum_;
    for (uint32_t i = 0; i < pmuLen; i++) {
        if ((i >= metricsPmuNum_ && i < analyzerPmu_->pmuNum_) ||
            i >= (metricsPmuNum_ + analyzerPmu_->pmuNum_)) {
            continue;
        }
        MSPROF_LOGI("BlockInfoMatch i: %u, subtask pmu: %llu, block pmu: %llu.", i, value.pmu[i],
            iter->second.pmu[i]);
        value.pmu[i] += iter->second.pmu[i];
    }
    // delete match block data
    analyzerPmu_->blockInfo_.erase(iter);
}

/**
 * @brief Subtask data association, which associate log data with subtask data
 * @return
 */
void OpAnalyzer::SubTaskAssociation()
{
    for (auto iter = analyzerPmu_->logInfo_.begin();
        iter != analyzerPmu_->logInfo_.end(); iter++) {
        SubTaskInfoMatch(iter->second);
    }
}

/**
 * @brief Match log data with subtask data
 * @param [in] value: kernel detail
 * @return
 */
void OpAnalyzer::SubTaskInfoMatch(KernelDetail &value)
{
    // find first match
    for (auto iter = analyzerPmu_->subTaskInfo_.begin();
        iter != analyzerPmu_->subTaskInfo_.end(); iter++) {
        if (value.taskId != iter->second.taskId || value.streamId != iter->second.streamId) {
            continue;
        }
        value.aicTotalCycle = iter->second.aicTotalCycle;
        value.aivTotalCycle = iter->second.aivTotalCycle;
        value.aicCnt = iter->second.aicCnt;
        value.aivCnt = iter->second.aivCnt;
        MSPROF_LOGI("SubTaskInfoMatch task id: %u, stream id: %u, aic total cycle: %llu, aiv total cycle: %llu, "
            "aic cnt: %llu, aiv cnt: %llu.", value.taskId, value.streamId, iter->second.aicTotalCycle,
            iter->second.aivTotalCycle, iter->second.aicCnt, iter->second.aivCnt);
        for (uint32_t i = 0; i < SUMMARY_PMU_LEN; i++) {
            if ((i >= metricsPmuNum_ && i < analyzerPmu_->pmuNum_) ||
                i >= (metricsPmuNum_ + analyzerPmu_->pmuNum_)) {
                continue;
            }
            MSPROF_LOGI("SubTaskInfoMatch i: %u, subtask pmu: %llu.", i, iter->second.pmu[i]);
            value.pmu[i] += iter->second.pmu[i];
        }
        // delete match sub task data
        analyzerPmu_->subTaskInfo_.erase(iter);
        return;
    }
}

/**
 * @brief Save log data to data manager and waiting for last kernel execution
 * @return
 */
void OpAnalyzer::StoreAssociation() const
{
    for (auto iter = analyzerPmu_->logInfo_.begin(); iter != analyzerPmu_->logInfo_.end(); ++iter) {
        MSPROF_LOGI("Save summary info key: %s, task id: %u, stream id: %u, begin time: %llu, end time: %llu, "
            "aic total cycle: %llu, aiv total cycle: %llu, main block dim: %u, slave block dim: %u, aic freq: %lf, "
            "aic core num: %lld, aiv core num: %lld.", iter->first.c_str(), iter->second.taskId,
            iter->second.streamId, iter->second.beginTime, iter->second.endTime, iter->second.aicTotalCycle,
            iter->second.aivTotalCycle, lowBlockDim_, highBlockDim_, aicFreq_, aicCoreNum_, aivCoreNum_);
        OpDataManager::instance()->AddSummaryInfo(iter->second);
    }
    OpDataManager::instance()->AddAnalyzeCount();
}

/**
 * @brief Create output csv file and write final average op data to them
 * @param [in] fileChunkReq: file chunk
 * @return
 */
void OpAnalyzer::FlushOpData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    std::string path = fileChunkReq->extraInfo; // use extraInfo to pass relative flush path
    // flush biu or pc sampling data
    if (analyzerBiu_->IsBiuMode()) {
        analyzerBiu_->SaveDataToFile(path);
        return;
    }

    if (pcSampling_.IsPcSamplingMode()) {
        pcSampling_.AnalyzePcSamplingDataAndSaveSummary(path);
        return;
    }
    // flush op_summary.csv
    std::string opProfSuffix = Utils::CreateProfDir(0, "");
    std::string summaryFile = CreateOpFile(path, OP_SUMMARY_NAME + opProfSuffix.substr(
        MAX_OP_SUMMARY_SUFFIX_START, MAX_OP_SUMMARY_SUFFIX_LEN));
    std::ofstream csvFile(summaryFile, std::ios::out | std::ios::app);
    if (csvFile.is_open()) {
        WriteOpTitle(csvFile);
        WriteOpData(csvFile);
    } else {
        MSPROF_LOGE("Failed to open op summary file, path: %s.", path.c_str());
        return;
    }
    csvFile.close();
    // flush <metrics>.csv
    std::string name = fileChunkReq->chunk;     // use chunk to pass pmu metrics type
    if (name.compare(0, CUSTOM_METRICS.length(), CUSTOM_METRICS) != 0 && replayTime_ == 1) {
        std::string metricsFile = CreateOpFile(path, name);
        csvFile.open(metricsFile, std::ios::out | std::ios::app);
    }
    if (csvFile.is_open()) {
        WriteOpTitle(csvFile);
        WriteOpData(csvFile);
    } else {
        MSPROF_LOGW("Unable to open op metrics file, path: %s, name: %s.", path.c_str(), name.c_str());
        return;
    }
    csvFile.close();
}

/**
 * @brief Create output csv file
 * @param [in] path: output path
 * @param [in] name: csv name
 * @return fileName: output file name with path
 */
std::string OpAnalyzer::CreateOpFile(const std::string &path, const std::string &name) const
{
    MSPROF_LOGI("Create op file, path: %s, name: %s.", path.c_str(), name.c_str());
    std::string fileName = path + name + ".csv";
    // create file and open ofstream
    int32_t fd = OsalOpen(fileName.c_str(), O_WRONLY | O_CREAT | O_APPEND, OSAL_IRUSR | OSAL_IWUSR);
    FUNRET_CHECK_EXPR_ACTION(fd < 0, return "", "Failed to create or open op file: %s.", fileName.c_str());
    (void)OsalClose(fd);
    fileName = Utils::CanonicalizePath(fileName);
    FUNRET_CHECK_EXPR_ACTION(fileName.empty(), return "", 
        "The fileName path: %s does not exist or permission denied.", fileName.c_str());
    return fileName; 
}

/**
 * @brief Write op title to csv file
 * @param [in] file: file stream
 * @return
 */
void OpAnalyzer::WriteOpTitle(std::ofstream& file) const
{
    // add table top name
    file << "task_id,stream_id,task_duration(us),aic_total_time(us),aic_total_cycle,"
        "aiv_total_time(us),aiv_total_cycle";
    std::vector<std::string> metricsVec = OpDataManager::instance()->GetMetricsInfo();
    for (auto &iter : metricsVec) {
        file << Platform::instance()->GetMetricsTopName(iter);
    }
    file << std::endl;
}

/**
 * @brief Write op data to csv file
 * @param [in] file: file stream
 * @return
 */
void OpAnalyzer::WriteOpData(std::ofstream& file)
{
    // check op data
    if (!OpDataManager::instance()->CheckSummaryInfoData(replayTime_)) {
        MSPROF_LOGE("Op data failed to pass data check, please check whether task run properly.");
        return;
    }
    std::vector<std::vector<KernelDetail>> dataVec = OpDataManager::instance()->GetSummaryInfo();
    // write op task data
    WriteOpBaseData(file, dataVec);
    // write op pmu data
    WriteOpPmuData(file, dataVec);
}

/**
 * @brief Write op base data without pmu to csv file
 * @param [in] file: file stream
 * @param [in] dataVec: summary info data
 * @return
 */
void OpAnalyzer::WriteOpBaseData(std::ofstream& file, std::vector<std::vector<KernelDetail>> &dataVec)
{
    uint64_t aicTotalCycleAvg = 0;
    uint64_t aivTotalCycleAvg = 0;
    uint32_t dataSize = replayTime_ * KERNEL_EXECUTE_TIME;
    float taskDurationAvg = DEFAULT_FLOAT_VALUE;
    float aicTotalTimeAvg = DEFAULT_FLOAT_VALUE;
    float aivTotalTimeAvg = DEFAULT_FLOAT_VALUE;
    // calculate average op data
    for (uint32_t time = 0; time < replayTime_; ++time) {
        for (uint32_t exec = 0; exec < KERNEL_EXECUTE_TIME; ++exec) {
            KernelDetail data = dataVec[time][exec];
            // total cycle
            aicTotalCycleAvg += (data.aicTotalCycle / dataSize);
            aivTotalCycleAvg += (data.aivTotalCycle / dataSize);
            // task duration
            taskDurationAvg += ((static_cast<float>(data.endTime - data.beginTime) / NS_CONVERT_US) / dataSize);
            // total time
            HandleOpTotalTime(data, aicTotalTimeAvg, aivTotalTimeAvg);
            MSPROF_LOGI("Acp calculate summary data, taskDuration: %f, aicTotalCycle: %llu, aivTotalCycle: %llu, "
                "aicTotalTime: %f, aivTotalTime: %f, vec location: %u, vec size: %u.", taskDurationAvg,
                aicTotalCycleAvg, aivTotalCycleAvg, aicTotalTimeAvg, aivTotalTimeAvg, time, dataSize);
        }
    }
    // write average data to local file
    file << dataVec[0][0].taskId;
    file << ",";
    file << dataVec[0][0].streamId;
    WriteFloatDataToFile(file, taskDurationAvg);
    WriteFloatDataToFile(file, aicTotalTimeAvg);
    file << ",";
    file << aicTotalCycleAvg;
    WriteFloatDataToFile(file, aivTotalTimeAvg);
    file << ",";
    file << aivTotalCycleAvg;
    MSPROF_LOGI("Save task duration: %f, aic total time: %f, aiv total time: %f.", taskDurationAvg, aicTotalTimeAvg,
        aivTotalTimeAvg);
}

/**
 * @brief Calculate op total time and add them to output value
 * @param [in] data: kernel detail
 * @param [in] aicTotalTimeAvg: output aic total time
 * @param [in] aivTotalTimeAvg: output aiv total time
 * @return
 */
void OpAnalyzer::HandleOpTotalTime(KernelDetail &data, float &aicTotalTimeAvg, float &aivTotalTimeAvg) const
{
    uint32_t dataSize = replayTime_ * KERNEL_EXECUTE_TIME;
    if (analyzerPmu_->IsExtPmu()) {
        aicTotalTimeAvg += ((static_cast<float>(data.aicCnt) / analyzerPmu_->frequency_) / NS_CONVERT_US) / dataSize;
        aivTotalTimeAvg += ((static_cast<float>(data.aivCnt) / analyzerPmu_->frequency_) / NS_CONVERT_US) / dataSize;
        return;
    }
    if (data.aicTotalCycle == 0 || data.aivTotalCycle == 0) { // not mix type
        aicTotalTimeAvg += Platform::instance()->GetTotalTime(data.aicTotalCycle, aicFreq_, lowBlockDim_,
            aicCoreNum_) / dataSize;
        aivTotalTimeAvg += Platform::instance()->GetTotalTime(data.aivTotalCycle, aicFreq_, lowBlockDim_,
            aivCoreNum_) / dataSize;
    } else if (data.coreType == CORE_TYPE_AIV || data.coreType == CORE_TYPE_AIC) { // slave core
        aicTotalTimeAvg += Platform::instance()->GetTotalTime(data.aicTotalCycle, aicFreq_, lowBlockDim_,
            aicCoreNum_) / dataSize;
        aivTotalTimeAvg += Platform::instance()->GetTotalTime(data.aivTotalCycle, aicFreq_, highBlockDim_,
            aivCoreNum_) / dataSize;
    }
}

/**
 * @brief Write op pmu data to csv file
 * @param [in] file: file stream
 * @param [in] dataVec: summary info data
 * @return
 */
void OpAnalyzer::WriteOpPmuData(std::ofstream& file, std::vector<std::vector<KernelDetail>> &dataVec)
{
    std::vector<std::string> metricsVec = OpDataManager::instance()->GetMetricsInfo();
    for (uint32_t time = 0; time < dataVec.size(); ++time) {
        float avgPmu[SUMMARY_PMU_LEN] = { 0 };
        // calculate and add avg pmu data
        for (uint32_t exec = 0; exec < KERNEL_EXECUTE_TIME; ++exec) {
            MSPROF_LOGI("Handle op event name: %s, replay time: %u, execute time: %u.", metricsVec[time].c_str(),
                time, exec);
            HandleOpPmuData(metricsVec[time], dataVec[time][exec], avgPmu, SUMMARY_PMU_LEN);
            continue;
        }
        uint32_t eventNum = Platform::instance()->GetMetricsPmuNum(metricsVec[time]);
        uint32_t maxPmuNum = analyzerPmu_->pmuNum_;
        // write pmu data and limit float data precision
        for (uint32_t i = 0; i < SUMMARY_PMU_LEN; ++i) {
            if ((i > eventNum - 1 && i < maxPmuNum) || (i > maxPmuNum + eventNum - 1)) {
                continue;
            }
            WriteFloatDataToFile(file, avgPmu[i]);
        }
    }
}

/**
 * @brief Calculate op pmu data and add them to output array
 * @param [in] name: aic metrics name
 * @param [in] data: kernel detail
 * @param [in] avg: output pmu array
 * @param [in] avgLen: len of output pmu array
 * @return
 */
void OpAnalyzer::HandleOpPmuData(const std::string &name, KernelDetail &data, float* avg, uint32_t avgLen) const
{
    uint32_t maxPmuNum = analyzerPmu_->pmuNum_;
    uint32_t allPmuNum = maxPmuNum * 2;
    for (uint32_t i = 0; i < allPmuNum; i++) {
        uint64_t totalCycle = data.aicTotalCycle;
        // change using total cycle
        if (i >= maxPmuNum) {
            totalCycle = data.aivTotalCycle;
        }
        // get metrics calculation
        PmuCalculationAttr* attr = Platform::instance()->GetMetricsFunc(name, i);
        if (attr == nullptr) {
            continue;
        }
        float output = attr->fomula(attr->attr, data.pmu[i], totalCycle, aicFreq_);
        // add avg pmu value
        (void)avgLen;
        avg[i] += output / KERNEL_EXECUTE_TIME;
        MSPROF_LOGI("Save summary info index: %u, pmu: %llu, output: %f, avg: %f.", i, data.pmu[i], output, avg[i]);
    }
}

/**
 * @brief Write precision float data to csv file
 * @param [in] file: file stream
 * @param [in] data: float data which need to write
 * @return
 */
void OpAnalyzer::WriteFloatDataToFile(std::ofstream& file, float &data)
{
    file << ",";
    file << std::fixed << std::setprecision(FLOAT_PRECISION) << CeilPrecision(data);
    if (file.fail()) {
        MSPROF_LOGE("Failed to write float data to pmu file.");
    }
}

/**
 * @brief Wait for op data analyzer done
 * @return
 */
void OpAnalyzer::WaitOpDone()
{
    std::unique_lock<std::mutex> lk(flushMtx_);
    bool status;
    static const int32_t WAIT_OP_TIMEOUT = 5000000;
    do {
        status = flushCv_.wait_for(lk, std::chrono::microseconds(WAIT_OP_TIMEOUT),
            [this] {
                return (analyzerPmu_->logInfo_.size() == 0 &&
                        analyzerPmu_->subTaskInfo_.size() == 0 &&
                        analyzerPmu_->blockInfo_.size() == 0);
            });
    } while (!status);
}

float OpAnalyzer::CeilPrecision(float value) const
{
    return std::ceil(value * PRECISION_CONVERT) / PRECISION_CONVERT;
}
}  // namespace Dvvp
}  // namespace Acp
}  // namespace Analysis
