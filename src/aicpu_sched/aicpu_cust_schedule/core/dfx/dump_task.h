/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef AICPUSD_DUMP_TASK_H
#define AICPUSD_DUMP_TASK_H

#include <map>
#include <memory>
#include <mutex>
#include <set>
#include <string>
#include <vector>
#include "aicpusd_status.h"
#include "dump_data.pb.h"
#include "op_mapping_info.pb.h"
#include "adump/ide_daemon_api.h"
#include "aicpusd_common.h"
#include "aicpusd_sqe_adapter.h"

namespace AicpuSchedule {
constexpr uint32_t INVALID_VAL = 65535U;
constexpr uint8_t STARS_DATADUMP_LOAD_INFO = 8;

struct MappingInfoOptionalParam {
    MappingInfoOptionalParam() : hasModelName(false),
                                 hasModelId(false),
                                 modelId(0U),
                                 hasStepId(false),
                                 stepIdAddr(nullptr),
                                 hasIterationsPerLoop(false),
                                 iterationsPerLoopAddr(nullptr),
                                 hasLoopCond(false),
                                 loopCondAddr(nullptr) {}

    bool hasModelName;
    std::string modelName;
    bool hasModelId;
    uint32_t modelId;
    bool hasStepId;
    uint64_t *stepIdAddr;
    bool hasIterationsPerLoop;
    uint64_t *iterationsPerLoopAddr;
    bool hasLoopCond;
    uint64_t *loopCondAddr;
};

struct IntervalStep {
    uint64_t start;
    uint64_t end;
};

struct DumpStep {
    std::set<uint64_t> singleStep;
    std::vector<IntervalStep> intervalStep;
    std::string DebugString();
};

struct TaskInfo {
    TaskInfo() : streamId_(0U),
                 taskId_(0U) {};

    TaskInfo(const uint32_t streamId, const uint32_t taskId) : streamId_(streamId),
                                                               taskId_(taskId) {};

    uint32_t streamId_;
    uint32_t taskId_;
    friend bool operator < (const TaskInfo &item1, const TaskInfo &item2);
};

inline bool operator < (const TaskInfo &item1, const TaskInfo &item2)
{
    if (item1.streamId_ == item2.streamId_) {
        return item1.taskId_ < item2.taskId_;
    }
    return item1.streamId_ < item2.streamId_;
}

class OpDumpTask {
public:
    explicit OpDumpTask(const int32_t hostPid, const uint32_t deviceId);
    ~OpDumpTask() = default;

     /**
     * Preprocess op mapping info.
     * @param  task task info from op mapping info
     * @param  basePath base dump path
     * @param  param optional param
     * @param  dumpStep step need dump
     * @param  isSingleOrUnknowShapeOp is single op or unknow shape op or not
     * @return whather preprocess success
     */
    StatusCode PreProcessOpMappingInfo(const aicpu::dump::Task &task,
                                       const std::string &basePath,
                                       const MappingInfoOptionalParam &param,
                                       const DumpStep &dumpStep,
                                       const bool isSingleOrUnknowShapeOp = false);

    /**
     * Deal with dump info event.
     * @return whather dump success
     */
    StatusCode DumpOpInfo(const uint32_t streamId = INVALID_VAL, const uint32_t taskId = INVALID_VAL,
                          const std::string &dumpDebugInfo = "");

    /**
     * Get model id of this task.
     * @param  modelId model id
     * @return whather get model id success
     */
    bool GetModelId(uint32_t &modelId) const;

    /**
     * Check this task is end graph task or not.
     * @return whather is end graph task
     */
    bool IsEndGraph() const;

    /**
     * Update dump number.
     * @return void
     */
    void UpdateDumpNum();

    /**
     * Get op name.
     * @return op name
     */
    std::string GetOpName() const;

    /**
     * Clear baseDumpData_.
     * @return void
     */
    void ClearBaseDumpData();

private:
    /**
     * Get dump number
     * @param  dumpNum task dump number
     * @return whather get dump param success
     */
    StatusCode GetDumpNumber(uint64_t &dumpNum);

    /**
     * This step need dump or not
     * @param  step task dump number
     * @return whather need dump
     */
    bool NeedDump(const uint64_t step);

    StatusCode PreProcessOutput(const aicpu::dump::Task &task,
                                ::toolkit::dumpdata::DumpData &dumpData);

    StatusCode PreProcessInput(const aicpu::dump::Task &task,
                               ::toolkit::dumpdata::DumpData &dumpData);

    StatusCode PreProcessOpBuffer(const aicpu::dump::Task &task,
                                  ::toolkit::dumpdata::DumpData &dumpData);
    StatusCode PreProcessWorkspace(const aicpu::dump::Task &task,
                                   ::toolkit::dumpdata::DumpData &dumpData);
    StatusCode ProcessInputDump(const ::toolkit::dumpdata::DumpData &dumpData,
                                const std::string &path,
                                const IDE_SESSION ideSession);

    StatusCode ProcessOutputDump(const ::toolkit::dumpdata::DumpData &dumpData,
                                 const std::string &path,
                                 const IDE_SESSION ideSession);

    StatusCode ProcessOpBufferDump(const ::toolkit::dumpdata::DumpData &dumpData,
                                   const std::string &path,
                                   const IDE_SESSION ideSession);

    StatusCode ProcessOpWorkspaceDump(const ::toolkit::dumpdata::DumpData &dumpData,
                                      const std::string &path,
                                      const IDE_SESSION ideSession);

    StatusCode Dump(const std::string &path,
                    char_t * const data,
                    const uint64_t len,
                    const IDE_SESSION ideSession,
                    const bool isLastSlice) const;

    std::string DumpPath(const uint64_t nowTime, const uint64_t dumpNumber,
                         const uint32_t streamId, const uint32_t taskId,
                         const bool debugFlag = false);

    StatusCode DoDump(const std::string &dumpFilePath, const std::string &dumpDebugFilePath = "",
                      const std::string &dumpDebugInfo = "");

private:
    std::mutex dumpMtx_;
    ::toolkit::dumpdata::DumpData baseDumpData_;
    std::string baseDumpPath_;
    std::string opName_;
    std::string opType_;
    MappingInfoOptionalParam optionalParam_;
    uint64_t taskDumpNum_;
    TaskInfo taskInfo_;
    DumpStep dumpStep_;
    bool endGraph_;
    std::vector<uint64_t> inputsBaseAddr_;
    std::vector<uint64_t> outputsBaseAddr_;
    std::vector<uint64_t> opBufferAddr_;
    std::vector<uint64_t> opWorkspaceAddr_;
    uint64_t inputTotalSize_;
    uint64_t outputTotalSize_;
    uint64_t opBufferTotalSize_;
    uint64_t opWorkspaceTotalSize_;
    std::unique_ptr<char_t[]> buff_;
    uint64_t buffSize_;
    uint64_t offset_;
    bool isSingleOrUnknowShapeOp_;
    int32_t hostPid_;
    uint32_t deviceId_;
};  // class OpDumpTask

class OpDumpTaskManager {
public:
    static OpDumpTaskManager &GetInstance();
    OpDumpTaskManager() = default;
    ~OpDumpTaskManager() = default;

    /**
     * Load op mapping info
     * @param  infoAddr info address pointer
     * @param  len info length
     * @return whather load success
     */
    int32_t LoadOpMappingInfo(const char_t * const infoAddr, const uint32_t len);

    /**
     * Deal with dump info event for know shape.
     * @param  streamId stream id
     * @param  taskId task id
     * @return whather dump success
     */
    int32_t DumpOpInfo(const uint32_t streamId, const uint32_t taskId,
                       const uint32_t streamId1 = INVALID_VAL, const uint32_t taskId1 = INVALID_VAL,
                       const std::string &dumpDebugInfo = "");

    /**
     * Deal with dump info event for unknow shape.
     * @param  opMappingInfoAddr op mapping info addr
     * @param  opMappingInfoLen op mapping info length
     * @return whather dump success
     */
    int32_t DumpOpInfoForUnknowShape(const uint64_t opMappingInfoAddr, const uint64_t opMappingInfoLen) const;

    /**
     * clear all resource od data dump for ctrl cpu and minirc
     * @return void
     */
    void ClearResource();

    int32_t DoDump(const aicpu::dump::OpMappingInfo &opMappingInfo) const;

private:
    OpDumpTaskManager(const OpDumpTaskManager &) = delete;
    OpDumpTaskManager &operator=(const OpDumpTaskManager &) = delete;
    OpDumpTaskManager(OpDumpTaskManager&&) = delete;
    OpDumpTaskManager& operator=(OpDumpTaskManager&&) = delete;

    /**
     * Get optional param from op mapping info proto
     * @param  opMappingInfo op mapping info
     * @param  optionalParam optional param
     * @return void
     */
    void GetOptionalParam(const aicpu::dump::OpMappingInfo &opMappingInfo,
                          MappingInfoOptionalParam &optionalParam) const;

    /**
     * Update all task dump number of according model id
     * @param  modelId model id
     * @return void
     */
    void UpdateDumpNumByModelId(const uint32_t modelId);

    /**
     * Porcess end graph task if it exist in opDumptasks
     * @param  opDumptasks tasks
     * @return void
     */
    void ProcessEndGraph(const std::vector<std::shared_ptr<OpDumpTask>> &opDumptasks);

    /**
     * Parse dump step from string, like 0|1-20
     * @param  str dump step string
     * @param  dumpStep dump step of parse result
     * @return whather parse success
     */
    bool GetDumpStepFromString(const std::string &str, DumpStep &dumpStep) const;

    /**
     * Parse dump step from step string
     * @param  step step string
     * @param  tmpDumpStep dump step of parse result
     * @return whather parse success
     */
    bool MatchAndInsert(const std::string &step, DumpStep &tmpDumpStep) const;

    /**
     * load mapping info
     * @param  opMappingInfo op mapping info proto
     * @return whather load success
     */
    int32_t Load(const aicpu::dump::OpMappingInfo &opMappingInfo);

    /**
     * unload mapping info
     * @param  opMappingInfo op mapping info proto
     * @return whather unload success
     */
    int32_t Unload(const aicpu::dump::OpMappingInfo &opMappingInfo);
    
    /**
     * clear baseDumpData
     * @param  TaskInfo taskInfo
     * @return void
     */
    void UnloadClearTaskInfo(const TaskInfo &taskInfo);

private:
    std::multimap<TaskInfo, std::shared_ptr<OpDumpTask>> dumpTaskMap_;
    std::mutex dumpTaskMapMtx_;
    std::map<uint32_t, std::set<TaskInfo>> modelIdToTask_;
};
}   // namespace aicpu

#endif
