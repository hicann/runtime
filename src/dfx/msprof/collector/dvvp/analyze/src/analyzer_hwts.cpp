/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "analyzer_hwts.h"
#include "acl.h"
#include "acl_prof.h"
#include "data_struct.h"

namespace Analysis {
namespace Dvvp {
namespace Analyze {
bool AnalyzerHwts::IsHwtsData(const std::string &fileName)
{
    // hwts data contains "hwts.data"
    if (fileName.find("hwts.data") != std::string::npos) {
        return true;
    }
    return false;
}

uint8_t AnalyzerHwts::GetRptType(CONST_CHAR_PTR data, uint32_t len)
{
    if (len >= sizeof(uint8_t)) {
        auto firstByte = reinterpret_cast<const uint8_t *>(data);
        uint8_t rptType = (*firstByte) & 0x7;  // bit 0-3
        return rptType;
    } else {
        return HWTS_INVALID_TYPE;
    }
}

void AnalyzerHwts::PrintStats()
{
    MSPROF_EVENT("total_size_analyze, module: HWTS, analyzed %" PRIu64 ", total %" PRIu64 ", "
                 "hwts time %u, merge %u",
        analyzedBytes_,
        totalBytes_,
        totalHwtsTimes_,
        totalHwtsMerges_);
}

void AnalyzerHwts::HwtsParse(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (fileChunkReq == nullptr) {
        return;
    }
    MSPROF_LOGI("Start to analyze device file: %s", fileChunkReq->fileName.c_str());
    totalBytes_ += fileChunkReq->chunkSize;
    ParseOptimizeHwtsData(fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize);
}

void AnalyzerHwts::ParseOptimizeHwtsData(CONST_CHAR_PTR data, uint32_t len)
{
    AppendToBufferedData(data, len);
    uint32_t offset = 0;
    while (dataPtr_ != nullptr && offset < dataLen_) {
        uint32_t remainingLen = dataLen_ - offset;
        if (remainingLen < HWTS_DATA_SIZE) {
            MSPROF_LOGI("Hwts remains %u bytes unparsed, which is incomplete data", remainingLen);
            break;
        }

        uint8_t rptType = GetRptType(dataPtr_ + offset, remainingLen);
        if (rptType == HWTS_TASK_START_TYPE || rptType == HWTS_TASK_END_TYPE) {
            HandleOptimizeStartEndData(dataPtr_ + offset, rptType);
            analyzedBytes_ += HWTS_DATA_SIZE;
            totalHwtsTimes_++;
        }
        offset += HWTS_DATA_SIZE;
    }
    BufferRemainingData(offset);
}

void AnalyzerHwts::HandleOptimizeStartEndData(CONST_CHAR_PTR data, uint8_t rptType)
{
    auto hwtsData = reinterpret_cast<const HwtsProfileType01 *>(data);
    std::string key = std::to_string(hwtsData->taskId) + KEY_SEPARATOR + std::to_string(hwtsData->streamId);
    auto devIter = AnalyzerBase::tsOpInfo_.find(key);
    if (devIter == AnalyzerBase::tsOpInfo_.end()) {
        RtOpInfo opInfo = {0, 0, 0, 0, true, 0, 0, ACL_SUBSCRIBE_OP, UINT16_MAX, 0};
        devIter = AnalyzerBase::tsOpInfo_.insert(std::make_pair(key, opInfo)).first;
    }

    uint64_t sysTime = static_cast<uint64_t>(hwtsData->syscnt / frequency_);
    if (rptType == HWTS_TASK_START_TYPE) {
        devIter->second.start = sysTime;
    } else if (rptType == HWTS_TASK_END_TYPE) {
        devIter->second.end = sysTime;
    }

    if (devIter->second.start > 0 && devIter->second.end > 0) {
        HandleDeviceData(key, devIter->second, totalHwtsMerges_);
    }
}

}  // namespace Analyze
}  // namespace Dvvp
}  // namespace Analysis
