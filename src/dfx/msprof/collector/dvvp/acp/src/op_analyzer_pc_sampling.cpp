/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "op_analyzer_pc_sampling.h"
#include <regex>
#include <memory>
#include <sstream>
#include <fstream>
#include <unordered_map>
#include "utils/utils.h"
#include "acp_manager.h"

namespace Dvvp {
namespace Acp {
namespace Analyze {
using namespace analysis::dvvp::common::utils;
using namespace Collector::Dvvp::Acp;
constexpr uint8_t INSTRUCTION_PC_PLACE = 1;
constexpr uint8_t FILE_PATH_PLACE = 1;
constexpr uint8_t HEX_BASE = 16;
constexpr char PC_SAMPLING_INSTR_SUMMARY_HEADER[] = "address,ibuf_empty,nop_stall,scoreboard_not_ready,"
    "register_bank_conflict,resource_conflict,warp_level_sync,divergence_stack_spill,other";
constexpr char PC_SAMPLING_SOURCE_SUMMARY_HEADER[] = "file,line,ibuf_empty,nop_stall,scoreboard_not_ready,"
    "register_bank_conflict,resource_conflict,warp_level_sync,divergence_stack_spill,other";

struct SamplingInstrRecord {
    SamplingInstrRecord() : pcAddr(0), active(0) {}
    uint32_t pcAddr : 24;
    uint32_t active : 8;
    uint8_t ibufEmpty{ 0 };
    uint8_t nopStall{ 0 };
    uint8_t scoreboardNotReady{ 0 };
    uint8_t registerBankConflict{ 0 };
    uint8_t resourceConflict{ 0 };
    uint8_t warpLevelSync{ 0 };
    uint8_t divergenceStackSpill{ 0 };
    uint8_t other{ 0 };
};

bool OpAnalyzerPcSampling::IsPcSamplingData(const std::string &fileName) const
{
    return fileName.find("pc_sampling") != std::string::npos;
}

void OpAnalyzerPcSampling::ParsePcSamplingData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    isSamplingEnable_ = true;
    auto it = pcSamplingData_.find(fileChunkReq->fileName);
    if (it == pcSamplingData_.end()) {
        pcSamplingData_[fileChunkReq->fileName] = PcSamplingAnalyzerData();
    }
    it = pcSamplingData_.find(fileChunkReq->fileName);
    it->second.data.append(fileChunkReq->chunk, 0, fileChunkReq->chunkSize);
    it->second.size += fileChunkReq->chunkSize;
    it->second.totalSize += fileChunkReq->chunkSize;
    size_t offset = 0;
    while (it->second.size >= sizeof(SamplingInstrRecord) && offset <= it->second.size - sizeof(SamplingInstrRecord)) {
        auto sampling = reinterpret_cast<const SamplingInstrRecord*>(it->second.data.c_str() + offset);
        auto &record = it->second.pcSamplingRecord[sampling->pcAddr];
        record.pcAddr = sampling->pcAddr;
        record.active += sampling->active;
        record.ibufEmpty += sampling->ibufEmpty;
        record.nopStall += sampling->nopStall;
        record.scoreboardNotReady += sampling->scoreboardNotReady;
        record.registerBankConflict += sampling->registerBankConflict;
        record.resourceConflict += sampling->resourceConflict;
        record.warpLevelSync += sampling->warpLevelSync;
        record.divergenceStackSpill += sampling->divergenceStackSpill;
        record.other += sampling->other;
        offset += sizeof(SamplingInstrRecord);
    }
    it->second.data.erase(0, offset);
    it->second.size -= offset;
}

void OpAnalyzerPcSampling::AnalyzePcSamplingDataAndSaveSummary(const std::string &output)
{
    if (!isSamplingEnable_) {
        return;
    }

    AnalyzeBinaryObject();
    for (auto &it : pcSamplingData_) {
        MSPROF_EVENT("total_size_analyze, pc_sampling, file: %s, analyze bytes: %zu",
            Utils::BaseName(it.first).c_str(), it.second.totalSize);
        for (auto &record : it.second.pcSamplingRecord) {
            auto &summary = pcSamplingRecord_[record.second.pcAddr];
            summary.pcAddr = record.second.pcAddr;
            summary.active += record.second.active;
            summary.ibufEmpty += record.second.ibufEmpty;
            summary.nopStall += record.second.nopStall;
            summary.scoreboardNotReady += record.second.scoreboardNotReady;
            summary.registerBankConflict += record.second.registerBankConflict;
            summary.resourceConflict += record.second.resourceConflict;
            summary.warpLevelSync += record.second.warpLevelSync;
            summary.divergenceStackSpill += record.second.divergenceStackSpill;
            summary.other += record.second.other;
        }
    }
    isSamplingEnable_ = false;
    GenerateSummary(output);
}

void OpAnalyzerPcSampling::AnalyzeBinaryObject()
{
    std::string path = AcpManager::instance()->GetBinaryObjectPath();
    std::string objdumpCmd("llvm-objdump");
    std::string objdumpFile = path + ".objdump"; // llvm-objdump 解析输出的文件
    std::vector<std::string> envsVec;
    int32_t exitCode = analysis::dvvp::common::utils::INVALID_EXIT_CODE;
    std::vector<std::string> argsVec = {
        path,
        "-d",
        "--source",
        "--line-numbers"
    };

    ExecCmdParams execCmdParams(objdumpCmd, true, objdumpFile);
    OsalProcess objdumpProcess = -1;
    int32_t ret = Utils::ExecCmd(execCmdParams, argsVec, envsVec, exitCode, objdumpProcess);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to launch llvm-objdump, ret: %d", ret);
        return;
    }
    bool isExited = false;
    ret = Utils::WaitProcess(objdumpProcess, isExited, exitCode, true);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to wait llvm-objdump process");
        return;
    }

    ReadObjdumpFile(objdumpFile);
}

void OpAnalyzerPcSampling::ReadObjdumpFile(const std::string &file)
{
    std::regex instructionPattern("^\\s*([a-f0-9]+):\\s+");
    std::regex filePatern("^\\s*;*\\s*(\\/(?:[a-zA-Z0-9\\._\\- ]*\\/)*"
                          "(?!__davinci|__clang)[a-zA-Z0-9\\._\\- ]*)"
                          ":([0-9]+)$");
    std::ifstream in(file);
    if (!in.is_open()) {
        MSPROF_LOGE("Open objdump file failed, path: %s", file.c_str());
        return;
    }

    std::string line;
    std::string curFile;
    while (std::getline(in, line)) {
        if (line.empty()) {
            continue;
        }
        std::smatch match;
        if (std::regex_match(line, match, filePatern)) {
            // ; /home/xxx/demo/add.cpp:60
            curFile = match.str(FILE_PATH_PLACE);
            continue;
        }

        if (curFile.empty()) {
            continue;
        }

        if (std::regex_match(line, match, instructionPattern)) {
            // 13f6: 48 8b 55 f8                    movq -8(%rbp), %rdx
            try {
                uint64_t pcAddr = std::stoul(match.str(INSTRUCTION_PC_PLACE).c_str(), nullptr, HEX_BASE);
                objectData_[pcAddr] = curFile;
            } catch (const std::exception &ex) {
                MSPROF_LOGE("Convert pc addr to uint64_t failed, ex: %s, pcAddr: %s", ex.what(), match.str(1).c_str());
            }
        }
    }
    in.close();
}

void OpAnalyzerPcSampling::GeneratePcSummary(const std::string &output)
{
    std::string pcSamplingInstrSummaryCsv = output + "/pc_sampling_instr_summary.csv";
    std::stringstream s;
    s << PC_SAMPLING_INSTR_SUMMARY_HEADER<<"\n";
    for (auto &it : pcSamplingRecord_) {
        s << it.second.pcAddr << "," << it.second.ibufEmpty << "," << it.second.nopStall << ",";
        s << it.second.scoreboardNotReady << "," << it.second.registerBankConflict << ",";
        s << it.second.resourceConflict << "," << it.second.warpLevelSync << ",";
        s << it.second.divergenceStackSpill << "," << it.second.other << "\n";
    }
    (void)Utils::DumpFile(pcSamplingInstrSummaryCsv, s.str().c_str(), s.str().size());
}

void OpAnalyzerPcSampling::GenerateSourceSummary(const std::string &output)
{
    std::string pcSamplingSourceSummaryCsv = output + "/pc_sampling_source_summary.csv";
    std::stringstream s;
    s << PC_SAMPLING_SOURCE_SUMMARY_HEADER<<"\n";
    for (auto &it : pcSamplingRecord_) {
        auto &fileLine = objectData_[it.second.pcAddr];
        s << fileLine << "," << it.second.ibufEmpty << "," << it.second.nopStall << ",";
        s << it.second.scoreboardNotReady << "," << it.second.registerBankConflict << ",";
        s << it.second.resourceConflict << "," << it.second.warpLevelSync << ",";
        s << it.second.divergenceStackSpill << "," << it.second.other << "\n";
    }

    (void)Utils::DumpFile(pcSamplingSourceSummaryCsv, s.str().c_str(), s.str().size());
}

void OpAnalyzerPcSampling::GenerateSummary(const std::string &output)
{
    GeneratePcSummary(output);
    GenerateSourceSummary(output);
}

bool OpAnalyzerPcSampling::IsPcSamplingMode() const
{
    if (!pcSamplingData_.empty()) {
        return true;
    }
    return false;
}
}
}
}