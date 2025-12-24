/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSPROF_ENGINE_RECEIVE_DATA_H
#define MSPROF_ENGINE_RECEIVE_DATA_H

#include <atomic>
#include <fstream>
#include <iostream>
#include <map>
#include <set>
#include <memory>
#include <thread>
#include "memory/chunk_pool.h"
#include "prof_api.h"
#include "prof_reporter.h"
#include "queue/ring_buffer.h"
#include "config/config.h"
#include "prof_report_api.h"

namespace Msprof {
namespace Engine {
using namespace analysis::dvvp;
using namespace analysis::dvvp::common::memory;
using namespace analysis::dvvp::common::config;
using CONST_REPORT_DATA_PTR = const ReporterData *;
constexpr int32_t WAIT_BUFF_EMPTY_TIMEOUT_US = 5000000;
struct ModuleIdName {
    uint32_t id;
    std::string name;
    size_t ringBufSize;
};

enum class ProfileDataType {
    MSPROF_DEFAULT_PROFILE_DATA_TYPE             = 0,
    MSPROF_API_PROFILE_DATA_TYPE                 = 1,
    MSPROF_COMPACT_PROFILE_DATA_TYPE             = 2,
    MSPROF_ADDITIONAL_PROFILE_DATA_TYPE          = 3,
    ADPROF_ADDITIONAL_PROFILE_DATA_TYPE          = 4,
    MSPROF_VARIABLE_ADDITIONAL_PROFILE_DATA_TYPE = 5,
};

const std::vector<ModuleIdName> MSPROF_MODULE_ID_NAME_MAP = {
    {MSPROF_MODULE_DATA_PREPROCESS, "DATA_PREPROCESS", RING_BUFF_CAPACITY},
    {MSPROF_MODULE_MSPROF, "Msprof", PROFTX_RING_BUFF_CAPACITY},
};

const std::vector<ModuleIdName> MSPROF_MODULE_REPORT_TABLE = {
    {API_EVENT,               "api_event",        RING_BUFF_CAPACITY},
    {COMPACT,                 "compact",          COMPACT_RING_BUFF_CAPACITY},
    {ADDITIONAL,              "additional",       ADDITIONAL_RING_BUFF_CAPACITY},
    {VARIABLE_ADDINFO,        "variable",         VARIABLE_ADDITIONAL_BUFF_CAPACITY},
};

const std::vector<ModuleIdName> ADPROF_MODULE_REPORT_TABLE = {
    {ADPROF,        "adprof",         ADPROF_BUFF_CAPACITY}
};

struct ReporterDataChunk {
    char tag[MSPROF_ENGINE_MAX_TAG_LEN + 1];
    int32_t deviceId;
    uint64_t reportTime;
    uint64_t dataLen;
    uint8_t data[RECEIVE_CHUNK_SIZE];
};

class ReceiveData {
public:
    ReceiveData();
    virtual ~ReceiveData();

public:
    virtual int32_t SendData(SHARED_PTR_ALIA<ProfileFileChunk> fileChunk);
    static ProfApiBufPopCallback apiTryPop_;
    static ProfCompactBufPopCallback compactTryPop_;
    static ProfAdditionalBufPopCallback additionalTryPop_;
    static ProfReportBufEmptyCallback reportBufEmpty_;
    static ProfBatchAddBufPopCallback batchAdditionalTryPop_;
    static ProfBatchAddBufIndexShiftCallBack batchAdditionalBufferIndexShift_;
    static ProfVarAddBlockBufPopCallback varAdditionalTryPop_;
    static ProfVarAddBufIndexShiftCallBack varAdditionalBufferIndexShift_;

protected:
    virtual void StopReceiveData();
    virtual int32_t Flush();
    virtual int32_t FlushAll();
    virtual void TimedTask();
    virtual void DoReportRun();
    virtual int32_t Dump(std::vector<SHARED_PTR_ALIA<ProfileFileChunk>> &message);
    virtual void WriteDone();

    void RunDefaultProfileData(std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks);
    void SetBufferEmptyEvent();
    void WaitAllBufferEmptyEvent(uint64_t us);
    int32_t Init();
    int32_t DoReport(CONST_REPORT_DATA_PTR rData) const;
    void PrintTotalSize();
    template<typename T>
    int32_t DumpData(std::vector<T> &message, SHARED_PTR_ALIA<ProfileFileChunk> fileChunk, uint32_t ageFlag);
    template<typename T>
    void DumpProfileData(std::vector<T> &message, std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks,
        uint32_t ageFlag);
    void ApiRun(std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks);
    void CompactRun(std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks);
    void AdditionalRun(std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks);
    void RunProfileData(std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks);

    void AdprofRun(std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks);
    void DumpAdprofData(void *outPtr, size_t outSize, SHARED_PTR_ALIA<ProfileFileChunk> fileChunk) const;

    void VariableAdditionalRun(std::vector<SHARED_PTR_ALIA<ProfileFileChunk>>& fileChunks);
    void DumpVariableData(void *outPtr, size_t outSize, SHARED_PTR_ALIA<ProfileFileChunk> fileChunk) const;

protected:
    volatile bool started_;
    volatile bool stopped_;
    std::string moduleName_;
    uint32_t moduleId_;
    std::set<std::string> devIds_;
    ProfileDataType profileDataType_;
    uint64_t totalPopCount_;
    uint64_t totalPopSize_;
    unsigned long long timeStamp_;

private:
    std::condition_variable cvBufferEmpty_;
    std::mutex cvBufferEmptyMtx_;
    std::atomic<uint64_t> totalPushCount_;
    std::atomic<uint64_t> totalPushSize_;
    std::atomic<uint64_t> totalDataLengthFailed_;
};
}}
#endif

