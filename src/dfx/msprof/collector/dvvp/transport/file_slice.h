/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_STREAMIO_COMMON_FILE_SLICE_H
#define ANALYSIS_DVVP_STREAMIO_COMMON_FILE_SLICE_H

#include <map>
#include "file_ageing.h"
#include "message/prof_params.h"
#include "queue/bound_queue.h"
#include "statistics/perf_count.h"
#include "thread/thread.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace Analysis::Dvvp::Common::Statistics;
using namespace analysis::dvvp::common::utils;

constexpr int32_t MEGABYTE_CONVERT = 1024;

class FileSlice {
public:
    FileSlice(int32_t sliceFileMaxKByte, const std::string &storageDir, const std::string &storageLimit);
    ~FileSlice();

public:
    int32_t Init(bool needSlice = true);
    bool FileSliceFlush();
    int32_t SaveDataToLocalFiles(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq,
        const std::string &storageDir);

private:
    int32_t FileSliceFlushByJobID(const std::string &jobIDRelative, const std::string &devID);
    bool CreateDoneFile(const std::string &absolutePath, const std::string &fileSize,
                        const std::string &startTime, const std::string &endTime, const std::string &timeKey);
    std::string GetSliceKey(const std::string &dir, std::string &fileName);
    int32_t SetChunkTime(const std::string &key, uint64_t startTime, uint64_t endTime);
    int32_t WriteToLocalFiles(const std::string &key, CONST_CHAR_PTR data, int32_t dataLen, int32_t offset, bool isLastChunk, std::string &fileName);
    int32_t WriteDataToFile(const std::string &key, CONST_CHAR_PTR data, int32_t dataLen, int32_t offset);
    int32_t HandleFileCompletion(const std::string &key, const std::string &fileName, bool isLastChunk);
    int32_t CheckDirAndMessage(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq,
        const std::string &storageDir) const;
    int32_t WriteCtrlDataToFile(const std::string &absolutePath, const std::string &data, int32_t dataLen);

private:
    int32_t sliceFileMaxKByte_;
    std::map<std::string, uint64_t> sliceNum_;
    std::map<std::string, uint64_t> totalSize_;
    std::map<std::string, uint64_t> chunkStartTime_;
    std::map<std::string, uint64_t> chunkEndTime_;
    std::mutex sliceFileMtx_;
    SHARED_PTR_ALIA<PerfCount> writeFilePerfCount_;
    std::string storageDir_;
    bool needSlice_;
    std::string storageLimit_;
    SHARED_PTR_ALIA<FileAgeing> fileAgeing_;
};
}
}
}
#endif  // _ANALYSIS_DVVP_STREAMIO_COMMON_FILE_SLICE_H
