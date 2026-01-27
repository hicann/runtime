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

#include <cmath>
#include <map>
#include <memory>
#include <mutex>
#include <set>
#include <sstream>
#include <string>
#include <vector>
#include "Eigen/Dense"
#include "aicpusd_status.h"
#include "dump_data.pb.h"
#include "op_mapping_info.pb.h"
#include "adump/ide_daemon_api.h"
#include "aicpusd_common.h"
#include "type_def.h"
#include "datadump_kfc_interface.h"
#include "aicpusd_sqe_adapter.h"

#define DATADUMP_MAKE_SHARED(exec_expr0, exec_expr1)                     \
  try {                                                                              \
    exec_expr0;                                                                      \
  } catch (const std::bad_alloc &err) {                                              \
    aicpusd_err("bad alloc for object, reason is [%s]", err.what());                 \
    exec_expr1;                                                                      \
  } catch (const std::exception &err) {                                              \
    aicpusd_err("make shared failed for object failed, reason is [%s]", err.what()); \
    exec_expr1;                                                                      \
  } catch (...) {                                                                    \
	aicpusd_err("make shared failed. reason is [%s]", strerror(errno));              \
	exec_expr1;                                                                      \
  }

namespace AicpuSchedule {
constexpr uint32_t INVALID_VAL = 65535U;
constexpr uint8_t STARS_DATADUMP_LOAD_INFO = 8;
// datadump for kfc
using AicpuKfcDumpFuncPtr = uint32_t(*)(void *);

using DumpMode = ::aicpu::dump::DumpData;

static inline void ReplaceStringElem(std::string &str)
{
    (void)for_each(str.begin(), str.end(),
        [](char_t &ch) {
            if ((ch == ' ') ||
                (ch == '.') ||
                (ch == '/') ||
                (ch == '\\')) { ch = '_'; }
        });
}
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
    std::string DebugString() const;
};

struct TaskInfo {
    TaskInfo() : streamId_(0U),
                 taskId_(0U),
                 contextId_(INVALID_VAL),
                 threadId_(INVALID_VAL) {};

    TaskInfo(const uint32_t streamId,
             const uint32_t taskId,
             const uint32_t contextId = INVALID_VAL,
             const uint32_t threadId = INVALID_VAL) : streamId_(streamId), taskId_(taskId),
                                                      contextId_(contextId),
                                                      threadId_(threadId) {};

    uint32_t streamId_;
    uint32_t taskId_;
    uint32_t contextId_ = INVALID_VAL;
    uint32_t threadId_ = INVALID_VAL;
    friend bool operator < (const TaskInfo &item1, const TaskInfo &item2);
};

struct TaskInfoExt {
    TaskInfoExt() : streamId_(INVALID_VAL),
                    taskId_(INVALID_VAL),
                    contextId_(INVALID_VAL),
                    threadId_(INVALID_VAL),
                    indexId_(INVALID_VAL) {};

    TaskInfoExt(const uint32_t streamId,
              const uint32_t taskId,
              const uint32_t contextId = INVALID_VAL,
              const uint32_t threadId = INVALID_VAL,
              const uint32_t indexId = INVALID_VAL) : streamId_(streamId), taskId_(taskId),
                                                       contextId_(contextId),
                                                       threadId_(threadId),
                                                       indexId_(indexId) {};

    uint32_t streamId_;
    uint32_t taskId_;
    uint32_t contextId_;
    uint32_t threadId_;
    uint32_t indexId_;
};

struct DumpFileName {
    DumpFileName(const uint32_t streamId,
                 const uint32_t taskId,
                 const uint32_t contextId = INVALID_VAL,
                 const uint32_t threadId = INVALID_VAL) :
                 streamId_(streamId), taskId_(taskId), contextId_(contextId), threadId_(threadId) {};
    uint32_t streamId_;
    uint32_t taskId_;
    uint32_t contextId_;
    uint32_t threadId_;
};

inline bool operator < (const TaskInfo &item1, const TaskInfo &item2)
{
    if (item1.streamId_ != item2.streamId_) {
        return item1.streamId_ < item2.streamId_;
    }
    if (item1.taskId_ != item2.taskId_) {
        return item1.taskId_ < item2.taskId_;
    }
    if (item1.contextId_ != item2.contextId_) {
        return item1.contextId_ < item2.contextId_;
    }
    return item1.threadId_ < item2.threadId_;
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
                                       const DumpMode dumpMode,
                                       const bool isSingleOrUnknowShapeOp = false);
    StatusCode UpdatePreProcessFftsPlusInputAndOutput(const aicpu::dump::Context &item);
    StatusCode PreProcessUdfOpMappingInfo(uint8_t *dumpInfo, uint64_t length);
    /**
     * Deal with dump info event.
     * @return whather dump success
     */
    StatusCode DumpOpInfo(const TaskInfoExt &dumpTaskInfo, const DumpFileName &dumpFileName);
    StatusCode DumpOpInfo(const uint32_t streamId = INVALID_VAL, const uint32_t taskId = INVALID_VAL);

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
    bool IsSupportKfcDump();
    const std::string &GetDumpPath()
    {
        return dumpPath_;
    }
    const uint32_t GetDeviceId()
    {
        return deviceId_;
    }
    const int32_t GetHostPid()
    {
        return hostPid_;
    }
    const std::string &GetOpName()
    {
        return opName_;
    }
    void GetKfcDumpInfo(std::shared_ptr<KfcDumpInfo> dumpInfo);
    StatusCode Dump(const std::string &path,
                    char_t * const data,
                    const uint64_t len,
                    const IDE_SESSION ideSession,
                    const bool isLastSlice) const;
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
    bool NeedDump(const uint64_t step) const;

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

    std::string DumpPath(const uint64_t nowTime, const uint64_t dumpNumber,
                         const DumpFileName &dumpFileName,
                         const bool debugFlag = false);

    StatusCode DoDumpTensor(const std::string &dumpFilePath);

    StatusCode ProcessngNoTiliInput();

    StatusCode ProcessngNoTiliOutput();

    void UpdateDumpData();
    void UpdateUdfDumpDataTotalSize();
    /**
     * Get Input DataAddr
     * @param  i index
     * @return void
     */
    void GetInputDataAddr(uint64_t &dataAddr, const int32_t i);

    /**
     * Get Output DataAddr
     * @param  i index
     * @return void
     */
    void GetOutputDataAddr(uint64_t &dataAddr, const int32_t i);

    StatusCode ProcessDumpOpInfo(const TaskInfoExt &dumpTaskInfo, const std::string &dumpFilePath);
    StatusCode ProcessDumpTensor(const std::string &dumpFilePath);
    StatusCode ProcessDumpStats(const std::string &dumpFilePath);
    StatusCode ProcessDumpStatistic(const TaskInfoExt &dumpTaskInfo, const std::string &dumpFilePath);
    StatusCode DoDumpStats(const std::string &dumpFilePath, const std::string &content);
    std::string GenerateDataStatsInfo(uint64_t dataAddr, uint64_t dataSize,
                                     ::toolkit::dumpdata::OutputDataType dataType) const;
    std::string GenerateDataDimInfo(::toolkit::dumpdata::Shape dataShape) const;
    std::string GetDataFormatStr(::toolkit::dumpdata::OutputFormat dataFormat) const;
    std::string GetDataTypeStr(::toolkit::dumpdata::OutputDataType dataType) const;
    StatusCode ProcessKfcDumpStats(KfcDumpTask &taskInfo, const std::string &dumpFilePath);
    bool CheckAndGetKfcDumpStatsAPI();
    std::string ShapeDebugString(std::vector<uint64_t> shapeInfo) const;

    std::mutex dumpMtx_;
    ::toolkit::dumpdata::DumpData baseDumpData_;
    std::string baseDumpPath_;
    std::string dumpPath_;
    std::string opName_;
    std::string opType_;
    MappingInfoOptionalParam optionalParam_;
    uint64_t taskDumpNum_;
    TaskInfo taskInfo_;
    ::aicpu::dump::Task::TaskType taskType_;
    DumpStep dumpStep_;
    std::vector<uint64_t> inputsSize_;
    std::vector<uint64_t> outputSize_;
    std::vector<uint64_t> inputsOffset_;
    std::vector<uint64_t> outputOffset_;
    bool endGraph_;
    std::vector<uint64_t> inputsBaseAddr_;
    std::vector<int32_t> inputsDataType_;
    std::vector<int32_t> inputsFormat_;
    std::vector<std::vector<uint64_t>> inputsShape_;
    std::vector<std::vector<uint64_t>> inputsOriginShape_;
    std::vector<uint64_t> outputsBaseAddr_;
    std::vector<int32_t> outputsDataType_;
    std::vector<int32_t> outputsFormat_;
    std::vector<std::vector<uint64_t>> outputsShape_;
    std::vector<std::vector<uint64_t>> outputsOriginShape_;
    std::vector<int32_t> inputsAddrType_;
    std::vector<int32_t> outputsAddrType_;
    std::vector<uint64_t> opBufferAddr_;
    std::vector<uint64_t> opWorkspaceAddr_;
    std::vector<uint64_t> opWorkspaceSize_;
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
    DumpMode dumpMode_;
    AicpuKfcDumpFuncPtr kfcDumpFunc_ = nullptr;
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
    int32_t LoadOpMappingInfo(const char_t * const infoAddr, const uint32_t len, AicpuSqeAdapter &aicpuSqeAdapter);

    int32_t LoadOpMappingInfo(const char_t * const infoAddr, const uint32_t len);

    /**
     * Deal with dump info event for know shape.
     * @param  dumpTaskInfo Dump Task Info
     * @param  streamId Stream id
     * @param  taskId Task id
     * @return whather dump success
     */
    int32_t DumpOpInfo(TaskInfoExt &dumpTaskInfo,
                       const DumpFileName &dumpFileName);
    int32_t DumpOpInfo(const uint32_t streamId, const uint32_t taskId,
                       const uint32_t streamId1 = INVALID_VAL, const uint32_t taskId1 = INVALID_VAL);
    int32_t DumpOpInfo(TaskInfoExt &dumpTaskInfo,
                                      const uint32_t streamId, const uint32_t taskId,
                                      const uint32_t contextId, const uint32_t threadId);               
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
    void MakeDumpOpInfoforKfc(const KfcDumpTask &taskinfo, std::shared_ptr<OpDumpTask> dumpTask);
    int32_t GetDumpOpTaskDataforKfc(const KfcDumpTask &taskKey, KfcDumpInfo **dumpInfo);
    int32_t DumpOpTaskDataforKfc(const KfcDumpTask &taskKey, void *dumpData, uint32_t length) const;
    bool IsCustDumpTask(const uint32_t streamId, const uint32_t taskId);
    int32_t SetCustDumpTaskFlag(const uint32_t streamId, const uint32_t taskId, const bool flag);
    void ClearKfcDumpTaskInfo(const KfcDumpTask &kfcTaskinfo);

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
    int32_t Load(const aicpu::dump::OpMappingInfo &opMappingInfo, AicpuSqeAdapter &aicpuSqeAdapter);

    /**
     * unload mapping info
     * @param  opMappingInfo op mapping info proto
     * @return whather unload success
     */
    int32_t Unload(const aicpu::dump::OpMappingInfo &opMappingInfo, AicpuSqeAdapter &aicpuSqeAdapter);

    /**
     * clear baseDumpData
     * @param  TaskInfo taskInfo
     * @return void
     */
    void UnloadClearTaskInfo(const TaskInfo &dumpTaskInfo);
    /**
     * create OpDumpTask
     * @param  opDumpTaskPtr hostPid deviceId
     * @return create success
     */
    int32_t CreateOpDumpTask(std::shared_ptr<OpDumpTask> &opDumpTaskPtr,
        const int32_t hostPid, const uint32_t deviceId) const;
    /**
     * create KfcDumpInfo
     * @param  kfcDumpInfoPtr
     * @return create success
     */
    int32_t CreateKfcDumpInfo(std::shared_ptr<KfcDumpInfo> &kfcDumpInfoPtr) const;

private:
    std::multimap<TaskInfo, std::shared_ptr<OpDumpTask>> dumpTaskMap_;
    std::mutex dumpTaskMapMtx_;
    std::mutex kfcDumpTaskMapMtx_;
    std::map<uint32_t, std::set<TaskInfo>> modelIdToTask_;
    std::map<KfcDumpTask, std::shared_ptr<OpDumpTask>> kfcDumpTaskMap_;
    std::map<KfcDumpTask, std::shared_ptr<KfcDumpInfo>> kfcDumpInfoMap_;
    std::map<TaskInfo, bool> custDumpTaskMap_;
};

template <typename T>
class DataStats {
public:
    DataStats(uint64_t dataAddr, uint64_t dataSize) : maxValue_(0),
                                                      minValue_(0),
                                                      avgValue_(0.0),
                                                      count_(0UL),
                                                      nanCount_(0UL),
                                                      negInfCount_(0UL),
                                                      posInfCount_(0UL),
                                                      data_(nullptr),
                                                      dataSize_(dataSize)
    {
        data_ = PtrToPtr<void, T>(ValueToPtr(dataAddr));
        count_ = dataSize_ / sizeof(T);
    };

    virtual ~DataStats() = 0;

    virtual inline std::string GetDataStatsStr()
    {
        this->Stats();
        std::ostringstream oss;
        oss << maxValue_ << "," << minValue_ << "," << avgValue_ << "," << count_ << "," << nanCount_ << ","
            << negInfCount_ << "," << posInfCount_;
        return oss.str();
    };

protected:
    virtual inline bool IsNan(T ele) const
    {
        (void)ele;
        return true;
    }

    virtual inline bool IsInf(T ele) const
    {
        (void)ele;
        return true;
    }

    virtual inline void UpdateAvgValue(T ele, uint64_t i)
    {
        avgValue_ += (static_cast<double>(ele) - avgValue_) / static_cast<double>(i + 1);
    }

    virtual inline void AdjustAvgValue()
    {
        if ((negInfCount_ > 0UL) && (posInfCount_ == 0UL)) {
            avgValue_ = -INFINITY;
        } else if ((negInfCount_ == 0UL) && (posInfCount_ > 0UL)) {
            avgValue_ = INFINITY;
        }
        return;
    }

    void Stats();

    T maxValue_;
    T minValue_;
    double avgValue_;
    uint64_t count_;
    uint64_t nanCount_;
    uint64_t negInfCount_;
    uint64_t posInfCount_;

private:
    inline void ResetStats()
    {
        avgValue_ = static_cast<double>(0.0);
        nanCount_ = 0UL;
        negInfCount_ = 0UL;
        posInfCount_ = 0UL;
        return;
    }

    DataStats(DataStats const&) = delete;
    DataStats& operator=(DataStats const&) = delete;
    DataStats(DataStats&&) = delete;
    DataStats& operator=(DataStats&&) = delete;

    T *data_;
    uint64_t dataSize_;
};

template <typename T>
class NormalDataStats : public DataStats<T> {
public:
    NormalDataStats(uint64_t dataAddr, uint64_t dataSize) : DataStats<T>(dataAddr, dataSize) {}
    ~NormalDataStats() = default;
protected:
    inline bool IsNan(T ele) const
    {
        return std::isnan(ele);
    }

    inline bool IsInf(T ele) const
    {
        return std::isinf(ele);
    }
private:
    NormalDataStats(NormalDataStats const&) = delete;
    NormalDataStats& operator=(NormalDataStats const&) = delete;
    NormalDataStats(NormalDataStats&&) = delete;
    NormalDataStats& operator=(NormalDataStats&&) = delete;
};

class Uint8DataStats : public NormalDataStats<uint8_t> {
public:
    Uint8DataStats(uint64_t dataAddr, uint64_t dataSize) : NormalDataStats<uint8_t>(dataAddr, dataSize) {}
    ~Uint8DataStats() = default;

    inline std::string GetDataStatsStr()
    {
        Stats();
        std::ostringstream oss;
        oss << static_cast<uint32_t>(maxValue_) << "," << static_cast<uint32_t>(minValue_) << "," << avgValue_ << ","
            << count_ << "," << nanCount_ << "," << negInfCount_ << "," << posInfCount_;
        return oss.str();
    };
private:
    Uint8DataStats(Uint8DataStats const&) = delete;
    Uint8DataStats& operator=(Uint8DataStats const&) = delete;
    Uint8DataStats(Uint8DataStats&&) = delete;
    Uint8DataStats& operator=(Uint8DataStats&&) = delete;
};

class Int8DataStats : public NormalDataStats<int8_t> {
public:
    Int8DataStats(uint64_t dataAddr, uint64_t dataSize) : NormalDataStats<int8_t>(dataAddr, dataSize) {}
    ~Int8DataStats() = default;

    inline std::string GetDataStatsStr()
    {
        Stats();
        std::ostringstream oss;
        oss << static_cast<int32_t>(maxValue_) << "," << static_cast<int32_t>(minValue_) << "," << avgValue_ << ","
            << count_ << "," << nanCount_ << "," << negInfCount_ << "," << posInfCount_;
        return oss.str();
    };
private:
    Int8DataStats(Int8DataStats const&) = delete;
    Int8DataStats& operator=(Int8DataStats const&) = delete;
    Int8DataStats(Int8DataStats&&) = delete;
    Int8DataStats& operator=(Int8DataStats&&) = delete;
};

class EigenDataStats : public DataStats<Eigen::half> {
public:
    EigenDataStats(uint64_t dataAddr, uint64_t dataSize) : DataStats<Eigen::half>(dataAddr, dataSize) {}
    ~EigenDataStats() = default;

protected:
    inline bool IsNan(Eigen::half ele) const
    {
        return Eigen::numext::isnan(ele);
    }

    inline bool IsInf(Eigen::half ele) const
    {
        return Eigen::numext::isinf(ele);
    }

private:
    EigenDataStats(EigenDataStats const&) = delete;
    EigenDataStats& operator=(EigenDataStats const&) = delete;
    EigenDataStats(EigenDataStats&&) = delete;
    EigenDataStats& operator=(EigenDataStats&&) = delete;
};
}   // namespace aicpu

#endif
