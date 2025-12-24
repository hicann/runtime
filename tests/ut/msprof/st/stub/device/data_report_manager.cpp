/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "data_report_manager.h"
#include <algorithm>
#include <unistd.h>
#include "prof_common.h"
#include "prof_acl_api.h"
#include "securec.h"

namespace Cann {
namespace Dvvp {
namespace Test {
DataReportManager &DataReportManager::GetInstance()
{
    static DataReportManager manager;
    return manager;
}

int32_t DataReportManager::SimulateReport()
{
    if (msprofTx_) {
        ProcessMsprofTxSwitch();
    }

    std::shared_ptr<DataReport> report = nullptr;
    reports_.clear();
    th_.clear();
    rt_ = true;
    for (auto module : modules_) {
        try {
            report = std::make_shared<DataReport>(module);
            reports_[module] = report;
        } catch (std::exception& e) {
            MSPROF_LOGE("Failed to make shared for DataReport, error message: %s", e.what());
            return REPORT_FAILED;
        }
    }

    auto ret = ModuleReport();
    if (ret != 0) {
        return REPORT_FAILED;
    }

    modules_.clear();
    return REPORT_SUCCESS;
}

int32_t DataReportManager::ModuleReport()
{
    for (auto &report : reports_) {
        th_.push_back(std::thread([this, report]() -> void {
            if (this->ReportData(report.second) != REPORT_SUCCESS) {
                this->rt_ = false;
        }}));
    }

    for_each(th_.begin(), th_.end(), std::mem_fn(&std::thread::join));
    if (!rt_) {
        return REPORT_FAILED;
    }

    return REPORT_SUCCESS;
}

int32_t DataReportManager::ReportData(std::shared_ptr<DataReport> report_)
{
    usleep(rand() % 10);

    if (report_->InitReport() != 0) {
        return REPORT_FAILED;
    }

    if (report_->StartReport() != 0) {
        return REPORT_FAILED;
    }

    if (report_->HashReport() != 0) {
        return REPORT_FAILED;
    }

    if (report_->MaxLenReport() != 0) {
        return REPORT_FAILED;
    }

    if (report_->StopReport() != 0) {
        return REPORT_FAILED;
    }

    return REPORT_SUCCESS;
}

int32_t DataReportManager::ProcessSwitch(SwitchProcessCb callback, void *const data, const uint32_t len)
{
    if (data == nullptr) {
        MSPROF_LOGE("Process switch data is nullptr.");
        return REPORT_FAILED;
    }

    const size_t commandLen = sizeof(MsprofCommandHandle);
    if (len < commandLen) {
        MSPROF_LOGE("len: %u is invalid, it should not be smaller than %u.", len, commandLen);
        return REPORT_FAILED;
    }

    MsprofCommandHandle *const profilerConfig = static_cast<MsprofCommandHandle *>(data);
    const uint64_t profSwitch = profilerConfig->profSwitch;
    const uint32_t type = profilerConfig->type;

    return callback(profSwitch, type);
}

int32_t DataReportManager::ProcessAclSwitch(void *const data, const uint32_t len)
{
    return ProcessSwitch([this](uint64_t profSwitch, uint32_t type){
        if (((profSwitch & PROF_ACL_API) != 0U) && (type == 1U)) {
            this->modules_.emplace_back(REPORT_MODULE_MAP.at("Acl"));
            MSPROF_EVENT("modules_ insert, Acl.");
        }
        return REPORT_SUCCESS;
    }, data, len);
}

int32_t DataReportManager::ProcessGeSwitch(void *const data, const uint32_t len)
{
    int32_t ret = ProcessSwitch([this](uint64_t profSwitch, uint32_t type){
        if (((profSwitch & PROF_GE_API_L1) != 0U) && (type == 1U)) {
            this->modules_.emplace_back(REPORT_MODULE_MAP.at("Ge"));
            MSPROF_EVENT("modules_ insert, Ge.");
        }
        return REPORT_SUCCESS;
    }, data, len);
    // simulate UDF save profiling callback switch 
    if (ret == REPORT_SUCCESS && msprofConfig_ != StProfConfigType::PROF_CONFIG_DYNAMIC) {
        MsprofCommandHandle *const profilerConfig = static_cast<MsprofCommandHandle *>(data);
        cfg_.profSwitch = profilerConfig->profSwitch;
        cfg_.profSwitchHi = profilerConfig->profSwitch;
        cfg_.type = profilerConfig->type;
        cfg_.devNums = 1;
        cfg_.devIdList[1] = {64};
        (void)strcpy_s(cfg_.dumpPath, MAX_DUMP_PATH_LEN, "64");
        (void)strcpy_s(cfg_.sampleConfig, MAX_SAMPLE_CONFIG_LEN, profilerConfig->params.profData);
    }
    return ret;
}

int32_t DataReportManager::ProcessAicpuSwitch(void *const data, const uint32_t len)
{
    return ProcessSwitch([this](uint64_t profSwitch, uint32_t type){
        if (((profSwitch & PROF_AICPU_TRACE) != 0U) && (type == 1U)) {
            this->modules_.emplace_back(REPORT_MODULE_MAP.at("Aicpu"));
            MSPROF_EVENT("modules_ insert, Aicpu.");
        }
        return REPORT_SUCCESS;
    }, data, len);
}

int32_t DataReportManager::ProcessHcclSwitch(void *const data, const uint32_t len)
{
    return ProcessSwitch([this](uint64_t profSwitch, uint32_t type){
        if (((profSwitch & PROF_HCCL_TRACE) != 0U) && (type == 1U)) {
            this->modules_.emplace_back(REPORT_MODULE_MAP.at("Hccl"));
            MSPROF_EVENT("modules_ insert, Hccl.");
        }
        return REPORT_SUCCESS;
    }, data, len);
}

int32_t DataReportManager::ProcessRuntimeSwitch(void *const data, const uint32_t len)
{
    return ProcessSwitch([this](uint64_t profSwitch, uint32_t type){
        if (((profSwitch & PROF_RUNTIME_API) != 0U) && (type == 1U)) {
            this->modules_.emplace_back(REPORT_MODULE_MAP.at("Runtime"));
            MSPROF_EVENT("modules_ insert, Runtime.");
        }
        return REPORT_SUCCESS;
    }, data, len);
}

void DataReportManager::ProcessMsprofTxSwitch()
{
    modules_.emplace_back(REPORT_MODULE_MAP.at("MsprofTx"));
    MSPROF_EVENT("modules_ insert, MsprofTx.");
}

void DataReportManager::SetPcSampling(bool pcSample)
{
    pcSampling_ = pcSample;
}

bool DataReportManager::GetPcSampling()
{
    return pcSampling_;
}

void DataReportManager::SetMsprofTx(bool msprofTx)
{
    msprofTx_ = msprofTx;
}

bool DataReportManager::GetMsprofTx()
{
    return msprofTx_;
}

void DataReportManager::SetSleepTime(int32_t sleepTime)
{
    sleepTime_ = sleepTime;
}

int32_t DataReportManager::GetSleepTime(void)
{
    return sleepTime_;
}

int32_t DataReportManager::ProcessBitSwitch(void *const data, const uint32_t len)
{
    return ProcessSwitch([this](uint64_t profSwitch, uint32_t type){
        if (type == 1U) {
            bitSwitch_ = profSwitch;
            MSPROF_EVENT("Set bitSwitch: %llx ULL when type is 1.", profSwitch);
        } else if (type == 2U) {
            uint64_t dataSwtich = 1;
            while (true) {
                if ((profSwitch & dataSwtich) && (bitSwitch_ & dataSwtich)) {
                    bitSwitch_ ^= dataSwtich;
                }
                if (dataSwtich == PROF_MODEL_LOAD_MASK) {
                    break;
                }
                dataSwtich <<= 1;
            }
            MSPROF_EVENT("Set bitSwitch to: %llx ULL when type is 1.", profSwitch);
        }
        return REPORT_SUCCESS;
    }, data, len);
}

uint64_t DataReportManager::GetBitSwitch()
{
    return bitSwitch_;
}

void DataReportManager::SetMsprofConfig(StProfConfigType type)
{
    msprofConfig_ = type;
}
 
StProfConfigType DataReportManager::GetMsprofConfig()
{
    return msprofConfig_;
}
 
MsprofConfig * DataReportManager::GetMsprofConfigData()
{
    return &cfg_;
}
}
}
}