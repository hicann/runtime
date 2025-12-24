/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADX_DUMP_RECORE_H
#define ADX_DUMP_RECORE_H
#include <mutex>
#include <string>
#include <cstdint>
#include <sstream>
#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
#include "proto/dump_task.pb.h"
#endif
#include "bound_queue_memory.h"
#include "common/singleton.h"
#include "adx_msg_proto.h"
#include "adx_dump_process.h"
namespace Adx {
constexpr int32_t COUNT_HEADER_COMPATIBLE = 3;
constexpr int32_t FILENAME_CHECK_SIZE_MAX = 10;
constexpr int32_t MAX_STATS_RESULT_NUM = 10;
constexpr int32_t MAX_SHAPE_SIZE = 25;
constexpr int32_t MAX_STATS_NUM = 64;

enum class RecordType {
    RECORD_INVALID,
    RECORD_QUEUE,
    RECORD_FILE,
};

struct UihostDumpDataInfo {
    bool isEndFlag;
    std::string pathInUihost;
    std::string pathInHost;
};

struct HostDumpDataInfo {
    std::shared_ptr<MsgProto> msg;
    uint32_t recvLen;
};

union DataTypeUnion {
    int64_t longIntValue;
    float floatValue;
    int32_t intValue[2];
};

#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
struct TensorStatsResult {
    int64_t size;
    toolkit::dump::OutputDataType dType;
    toolkit::dump::OutputFormat format;
    int32_t shapeSize;
    uint32_t shape[MAX_SHAPE_SIZE];
    uint32_t result; // 0:success; 1:failed
    int32_t statsLen;
    int64_t stats[MAX_STATS_NUM];
    int32_t io; // 0 input; 1 output
    int32_t index;
};

struct OpStatsResult {
    int32_t tensorNum;
    int32_t res;
    uint64_t statItem;
    TensorStatsResult stat[MAX_STATS_RESULT_NUM];
};
#endif

bool SendDumpMsgToRemote(const std::string &msg, uint16_t flag);
class AdxDumpRecord : public Adx::Common::Singleton::Singleton<AdxDumpRecord> {
public:
    AdxDumpRecord();
    virtual ~AdxDumpRecord();
    int32_t GetDumpInitNum() const;
    void UpdateDumpInitNum(bool isPlus);
    int32_t Init(const std::string &hostPid);
    int32_t UnInit();
    void SetWorkPath(const std::string &path);
    void RecordDumpInfo();
    bool RecordDumpDataToQueue(HostDumpDataInfo &info);
    bool DumpDataQueueIsEmpty() const;
    AdxDumpRecord(AdxDumpRecord const &) = delete;
    AdxDumpRecord &operator=(AdxDumpRecord const &) = delete;
#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
    void SetOptimizationMode(uint64_t statsItem);
#endif
    void SetDumpPath(const std::string &dumpPath);

private:
    bool RecordDumpDataToDisk(const DumpChunk &dumpChunk) const;
    bool JudgeRemoteFalg(const std::string &msg) const;
#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
    bool DumpDataToCallback(const std::string &filename, const std::string &dumpData, int64_t offSet, int32_t flag);
    bool StatsDataParsing(const DumpChunk &dumpChunk);
    bool CheckFileNameExist(const std::string &filename);
    void AppendFileName(const std::string &filename);
    bool GenerateFileData(std::stringstream &strStream, const std::string &filename,
        std::shared_ptr<OpStatsResult> statsResult);
    bool FileNameCheck(const DumpChunk &dumpChunk) const;
    std::string Int32DataHandle(const int64_t &data) const;
    std::string FloatDataHandle(const int64_t &data) const;
    std::string TypeDataHandle(const int64_t &data, toolkit::dump::OutputDataType dType) const;
    std::string GetStatsString(toolkit::dump::OutputDataType dType, uint16_t pos, const int64_t &data);
    template <typename T>
    std::string GetStringName(T key, const std::map<T, std::string> &stringMap) const;
    std::string GetShapeString(const uint32_t shape[], int32_t shapeSize, int64_t &count) const;
    void StatisticsData(std::stringstream &strStream, std::shared_ptr<OpStatsResult> statsResult,
        const int64_t &count, const int32_t &idx);
#endif

private:
    bool dumpRecordFlag_;
    std::string dumpPath_;
    std::string workPath_;
    BoundQueueMemory<HostDumpDataInfo> hostDumpDataInfoQueue_;
    int32_t dumpInitNum_;
#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
    uint64_t dumpStatsItem_{0};
    uint32_t filenameIndex_{0};
    std::string statsHeader_;
    std::vector<uint16_t> statsList_;
    std::map<int16_t, std::function<std::string(const int64_t &, toolkit::dump::OutputDataType dType)>> funcMap_;
    std::vector<std::string> fileNameStatus_;
    bool compatible_{false};
#endif
};
}
#endif
