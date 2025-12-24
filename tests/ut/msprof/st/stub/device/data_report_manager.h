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
#include <cstdint>
#include <unordered_map>
#include <memory>
#include <vector>
#include <thread>
#include <functional>
#include "data_report.h"
#include "prof_api.h"
#include "msprof_stub.h"

namespace Cann {
namespace Dvvp {
namespace Test {
using SwitchProcessCb = std::function<int32_t(uint64_t, uint32_t)>;
using ProfApiBufPopBind = std::function<bool(uint32_t &, MsprofApi&)>;
using ProfCompactBufPopBind = std::function<bool(uint32_t &, MsprofCompactInfo&)>;
using ProfAdditionalBufPopBind = std::function<bool(uint32_t &, MsprofAdditionalInfo&)>;
const std::unordered_map<std::string, MsprofReporterModuleId> REPORT_MODULE_MAP = {
    {"Acl",      MSPROF_MODULE_ACL},
    {"Aicpu",    MSPROF_MODULE_DATA_PREPROCESS},
    {"Ge",       MSPROF_MODULE_FRAMEWORK},
    {"Hccl",     MSPROF_MODULE_HCCL},
    {"MsprofTx", MSPROF_MODULE_MSPROF},
    {"Runtime",  MSPROF_MODULE_RUNTIME},
};

class DataReportManager {
public:
    ~DataReportManager() {}
    static DataReportManager &GetInstance();
    int32_t SimulateReport();
    int32_t ProcessAclSwitch(void *const data, const uint32_t len);
    int32_t ProcessGeSwitch(void *const data, const uint32_t len);
    int32_t ProcessAicpuSwitch(void *const data, const uint32_t len);
    int32_t ProcessHcclSwitch(void *const data, const uint32_t len);
    int32_t ProcessRuntimeSwitch(void *const data, const uint32_t len);
    void SetPcSampling(bool pcSample);
    bool GetPcSampling();
    void SetMsprofTx(bool msprofTx);
    bool GetMsprofTx();
    int32_t ProcessBitSwitch(void *const data, const uint32_t len);
    uint64_t GetBitSwitch();
    void SetMsprofConfig(StProfConfigType type);
    StProfConfigType GetMsprofConfig();
    MsprofConfig *GetMsprofConfigData();
    void SetSleepTime(int32_t sleepTime);
    int32_t GetSleepTime(void);

private:
    int32_t ModuleReport();
    int32_t ReportData(std::shared_ptr<DataReport> report_);
    int32_t ProcessSwitch(SwitchProcessCb callback, void *const data, const uint32_t len);
    void ProcessMsprofTxSwitch();
    DataReportManager(): rt_(true), pcSampling_(false), msprofTx_(false), msprofConfig_(StProfConfigType::PROF_CONFIG_DYNAMIC), cfg_({}), bitSwitch_(0) {}

    bool rt_;
    bool pcSampling_;
    bool msprofTx_;
    int32_t sleepTime_{0};
    StProfConfigType msprofConfig_;
    MsprofConfig cfg_;
    std::vector<std::thread> th_;
    std::vector<MsprofReporterModuleId> modules_;
    std::unordered_map<MsprofReporterModuleId, std::shared_ptr<DataReport>> reports_;
    uint64_t bitSwitch_;
};

bool ReportBufEmpty();
}
}
}

inline Cann::Dvvp::Test::DataReportManager &DataReportMgr()
{
    return Cann::Dvvp::Test::DataReportManager::GetInstance();
}
#endif
