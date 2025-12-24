/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DVVP_COLLECT_REPORT_MSPROF_REPORTER_MGR_H
#define DVVP_COLLECT_REPORT_MSPROF_REPORTER_MGR_H
#include <mutex>
#include <unordered_map>
#include "msprof_reporter.h"

namespace Dvvp {
namespace Collect {
namespace Report {
using namespace analysis::dvvp;
const std::map<uint16_t, std::map<uint32_t, std::string>> DEFAULT_TYPE_INFO = {
    { MSPROF_REPORT_NODE_LEVEL, {
        {MSPROF_REPORT_NODE_BASIC_INFO_TYPE, "node_basic_info"},
        {MSPROF_REPORT_NODE_TENSOR_INFO_TYPE, "tensor_info"},
        {MSPROF_REPORT_NODE_ATTR_INFO_TYPE, "node_attr_info"},
        {MSPROF_REPORT_NODE_FUSION_OP_INFO_TYPE, "fusion_op_info"},
        {MSPROF_REPORT_NODE_CONTEXT_ID_INFO_TYPE, "context_id_info"},
        {MSPROF_REPORT_NODE_LAUNCH_TYPE, "launch"},
        {MSPROF_REPORT_NODE_TASK_MEMORY_TYPE, "task_memory_info"},
        {MSPROF_REPORT_NODE_STATIC_OP_MEM_TYPE, "static_op_mem"},
    }},
    { MSPROF_REPORT_MODEL_LEVEL, {
        {MSPROF_REPORT_MODEL_GRAPH_ID_MAP_TYPE, "graph_id_map"},
        {MSPROF_REPORT_MODEL_EXEOM_TYPE, "model_exeom"},
        {MSPROF_REPORT_MODEL_LOGIC_STREAM_TYPE, "logic_stream_info"}
    }},
    { MSPROF_REPORT_HCCL_NODE_LEVEL, {
        {MSPROF_REPORT_HCCL_MASTER_TYPE, "master"},
        {MSPROF_REPORT_HCCL_SLAVE_TYPE, "slave"}
    }},
    { MSPROF_REPORT_TX_LEVEL, {
        {MSPROF_REPORT_TX_BASE_TYPE, "msproftx"}
    }}
};
class ProfReporterMgr : public analysis::dvvp::common::thread::Thread {
public:
    static ProfReporterMgr &GetInstance()
    {
        static ProfReporterMgr mgr;
        return mgr;
    }
    int32_t Start() override;
    int32_t Stop() override;
    void Run(const struct error_message::Context &errorContext) override;
    int32_t StartReporters();
    int32_t StartAdprofReporters();
    int32_t SendAdditionalData(SHARED_PTR_ALIA<ProfileFileChunk> fileChunk);
    void FlushAdditonalData();
    void FlushAllReporter();
    void FlushHostReporters();
    int32_t RegReportTypeInfo(uint16_t level, uint32_t typeId, const std::string &typeName);
    bool ValidateDataFormat(const std::string& dataFormatStr) const;
    int32_t RegReportDataFormat(uint16_t level, uint32_t typeId, const std::string &dataFormat);
    uint64_t GetHashId(const std::string &info) const;
    void GetReportTypeInfo(uint16_t level, uint32_t typeId, std::string& tag);
    int32_t StopReporters();
    void SetSyncReporter();
    void NotifyQuit();

private:
    void FillData(const std::string &saveHashData, SHARED_PTR_ALIA<ProfileFileChunk> fileChunk, bool isLastChunk, const std::string& filename) const;
    void SaveData(bool isLastChunk);
    void SaveDataFormat(bool isLastChunk);
    void FlushMstxData();
    ProfReporterMgr();
    ~ProfReporterMgr() override;
    bool isStarted_;
    bool isUploadStarted_;
    bool isSyncReporter_;
    std::mutex regTypeInfoMtx_;
    std::mutex regDataFormatMtx_;
    std::mutex startMtx_;
    std::mutex notifyMtx_;
    std::condition_variable cv_;
    std::unordered_map<uint16_t, std::unordered_map<uint32_t, std::string>> reportTypeInfoMap_;
    std::unordered_map<uint16_t, std::unordered_map<uint32_t, std::string>> reportDataFormatMap_;
    std::unordered_map<uint16_t, std::vector<std::pair<uint32_t, std::string>>> reportTypeInfoMapVec_;
    std::unordered_map<uint16_t, std::vector<std::pair<uint32_t, std::string>>> reportDataFormatMapVec_;
    std::unordered_map<uint16_t, uint32_t> indexMap_;
    std::vector<Msprof::Engine::MsprofReporter> reporters_;
    std::vector<Msprof::Engine::MsprofReporter> adprofReporters_;
};
}
}
}
#endif