/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dump_task.h"
 
#include <algorithm>
#include <regex>
#include <sstream>
#include <vector>
#include <dlfcn.h>
#include "aicpusd_drv_manager.h"
#include "aicpusd_status.h"
#include "aicpusd_monitor.h"
#include "aicpusd_model_execute.h"
#include "common/aicpusd_util.h"
#include "securec.h"
#include "external/graph/types.h"

namespace AicpuSchedule {
const size_t INTERNAL_STEP_SIZE = 2U;
const uint32_t VERSION_0 = 0U;

OpDumpTaskManager &OpDumpTaskManager::GetInstance()
{
    static OpDumpTaskManager instance;
    return instance;
}

void OpDumpTaskManager::GetOptionalParam(const aicpu::dump::OpMappingInfo &opMappingInfo,
                                         MappingInfoOptionalParam &optionalParam) const
{
    if (opMappingInfo.model_name_param_case() == aicpu::dump::OpMappingInfo::kModelName) {
        optionalParam.modelName = opMappingInfo.model_name();
        ReplaceStringElem(optionalParam.modelName);
        optionalParam.hasModelName = true;
    }
    if (opMappingInfo.model_id_param_case() == aicpu::dump::OpMappingInfo::kModelId) {
        optionalParam.modelId = opMappingInfo.model_id();
        optionalParam.hasModelId = true;
    }
    if (opMappingInfo.step_id_case() == aicpu::dump::OpMappingInfo::kStepIdAddr) {
        optionalParam.stepIdAddr =
            PtrToPtr<void, uint64_t>(ValueToPtr(opMappingInfo.step_id_addr()));
        optionalParam.hasStepId = true;
    }
    if (opMappingInfo.iterations_per_loop_case() == aicpu::dump::OpMappingInfo::kIterationsPerLoopAddr) {
        optionalParam.iterationsPerLoopAddr =
            PtrToPtr<void, uint64_t>(ValueToPtr(opMappingInfo.iterations_per_loop_addr()));
        optionalParam.hasIterationsPerLoop = true;
    }
    if (opMappingInfo.loop_cond_case() == aicpu::dump::OpMappingInfo::kLoopCondAddr) {
        optionalParam.loopCondAddr =
            PtrToPtr<void, uint64_t>(ValueToPtr(opMappingInfo.loop_cond_addr()));
        optionalParam.hasLoopCond = true;
    }
}
int32_t OpDumpTaskManager::CreateOpDumpTask(std::shared_ptr<OpDumpTask> &opDumpTaskPtr,
    const int32_t hostPid, const uint32_t deviceId) const
{
    DATADUMP_MAKE_SHARED(opDumpTaskPtr = std::make_shared<OpDumpTask>(hostPid, deviceId),
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    return AICPU_SCHEDULE_OK;
}

int32_t OpDumpTaskManager::Load(const aicpu::dump::OpMappingInfo &opMappingInfo, AicpuSqeAdapter &aicpuSqeAdapter)
{
    const std::string dumpPath = opMappingInfo.dump_path();
    MappingInfoOptionalParam optionalParam;
    GetOptionalParam(opMappingInfo, optionalParam);
    const std::string dumpStepStr = opMappingInfo.dump_step();

    uint32_t streamId  = INVALID_VAL;
    uint32_t taskId = INVALID_VAL;
    if (!aicpuSqeAdapter.IsAdapterInvalidParameter()) {
        AicpuSqeAdapter::AicpuDataDumpInfoLoad info {};
        aicpuSqeAdapter.GetAicpuDataDumpInfoLoad(info);
        streamId = info.stream_id;
        taskId = info.task_id;
    }

    DumpStep dumpStep;
    if (!GetDumpStepFromString(dumpStepStr, dumpStep)) {
        aicpusd_err("Step error[%s].", dumpStepStr.c_str());
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    const int32_t hostPid = static_cast<int32_t>(AicpuSchedule::AicpuDrvManager::GetInstance().GetHostPid());
    const uint32_t deviceId = AicpuSchedule::AicpuDrvManager::GetInstance().GetDeviceId();
    {
        std::set<TaskInfo> tasksInfo;
        const std::lock_guard<std::mutex> mapLock(dumpTaskMapMtx_);
        int32_t ret = AICPU_SCHEDULE_OK;
        for (int32_t i = 0; i < opMappingInfo.task_size(); ++i) {
            aicpu::dump::Task task = opMappingInfo.task(i);
            aicpusd_info("Get load dump data from proto task id[%u], stream id[%u]", task.task_id(), task.stream_id());
            AicpuSqeAdapter::AicpuOpMappingDumpTaskInfo opmappingInfo(task.task_id(), task.stream_id(), taskId, streamId);
            const bool isOpMappingDumpTaskInfoVaild = 
                                            aicpuSqeAdapter.IsOpMappingDumpTaskInfoVaild(opmappingInfo);
            if (!isOpMappingDumpTaskInfoVaild) {
                aicpusd_err("streamId or taskId is INVALID_VAL, task.task_id()[%u], task.stream_id()[%u], "
                            "streamId[%u], taskId[%u]", opmappingInfo.proto_info_task_id, 
                            opmappingInfo.proto_info_stream_id, opmappingInfo.stream_id, opmappingInfo.task_id);
            }
            AicpuSqeAdapter::AicpuDumpTaskInfo dumpTaskInfo{};
            aicpuSqeAdapter.GetAicpuDumpTaskInfo(opmappingInfo, dumpTaskInfo);
            uint32_t contextIdTmp = INVALID_VAL;
            uint32_t threadIdTmp = INVALID_VAL;
            if (task.tasktype() == aicpu::dump::Task::FFTSPLUS) {
                const auto &contextFromMapInfo = task.context();
                uint32_t contextFromMapInfoSize = static_cast<uint32_t>(contextFromMapInfo.size());
                for (uint32_t j = 0U; j < contextFromMapInfoSize; ++j) {
                    std::shared_ptr<OpDumpTask> opDumpTaskPtr = nullptr;
                    ret = CreateOpDumpTask(opDumpTaskPtr, hostPid, deviceId);
                    if (ret != AICPU_SCHEDULE_OK) {
                        aicpusd_err("Create opDumpTask failed, hostPid[%d], deviceId[%u]", hostPid, deviceId);
                        return ret;
                    }
                    aicpusd_memory_log("MallocMemory, func=new, size=%zu, purpose=data dumper", sizeof(OpDumpTask));
                    if (opDumpTaskPtr == nullptr) {
                        aicpusd_err("malloc memory for OpDumpTask object failed");
                        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
                    }
                    DumpMode dumpMode = opMappingInfo.dump_data();
                    aicpusd_info("Load Dump data is %d", static_cast<int32_t>(dumpMode));
                    ret = opDumpTaskPtr->PreProcessOpMappingInfo(task,
                                                                 dumpPath,
                                                                 optionalParam,
                                                                 dumpStep,
                                                                 dumpMode);
                    if (ret != AICPU_SCHEDULE_OK) {
                        // when error occur, ge call unload op mapping info
                        aicpusd_err("pre process op mapping info failed");
                        return ret;
                    }
                    auto &item = contextFromMapInfo.at(j);
                    opDumpTaskPtr->UpdatePreProcessFftsPlusInputAndOutput(item);
                    contextIdTmp = item.context_id();
                    threadIdTmp = item.thread_id();
                    TaskInfo taskInfo(dumpTaskInfo.stream_id, dumpTaskInfo.task_id, contextIdTmp, threadIdTmp);
                    aicpusd_info("[stream id:%u, task id:%u, context id:%u, thread id:%u]",
                        dumpTaskInfo.stream_id, dumpTaskInfo.task_id, contextIdTmp, threadIdTmp);
                    (void)dumpTaskMap_.insert(std::make_pair(taskInfo, std::move(opDumpTaskPtr)));
                    (void)tasksInfo.insert(taskInfo);
                }
            } else {
                contextIdTmp = INVALID_VAL;
                threadIdTmp = INVALID_VAL;
                std::shared_ptr<OpDumpTask> opDumpTaskPtr = nullptr;
                ret = CreateOpDumpTask(opDumpTaskPtr, hostPid, deviceId);
                if (ret != AICPU_SCHEDULE_OK) {
                    aicpusd_err("Create opDumpTask failed");
                    return ret;
                }
                aicpusd_memory_log("MallocMemory, func=new, size=%zu, purpose=data dumper", sizeof(OpDumpTask));
                if (opDumpTaskPtr == nullptr) {
                    aicpusd_err("malloc memory for OpDumpTask object failed");
                    return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
                }
                DumpMode dumpMode = opMappingInfo.dump_data();
                aicpusd_info("Load Dump data is %d", static_cast<int32_t>(dumpMode));
                ret = opDumpTaskPtr->PreProcessOpMappingInfo(task,
                                                             dumpPath,
                                                             optionalParam,
                                                             dumpStep,
                                                             dumpMode);
                if (ret != AICPU_SCHEDULE_OK) {
                    // when error occur, ge call unload op mapping info
                    aicpusd_err("pre process op mapping info failed");
                    return ret;
                }
                TaskInfo taskInfo(dumpTaskInfo.stream_id, dumpTaskInfo.task_id, contextIdTmp, threadIdTmp);
                aicpusd_info("[stream id:%u, task id:%u, context id:%u, thread id:%u]",
                    dumpTaskInfo.stream_id, dumpTaskInfo.task_id, contextIdTmp, threadIdTmp);
                (void)dumpTaskMap_.insert(std::make_pair(taskInfo, std::move(opDumpTaskPtr)));
                (void)tasksInfo.insert(taskInfo);
            }
        }
        if (optionalParam.hasModelId) {
            const auto iter = modelIdToTask_.find(optionalParam.modelId);
            if (iter == modelIdToTask_.end()) {
                (void)modelIdToTask_.insert(std::make_pair(optionalParam.modelId, std::move(tasksInfo)));
            } else {
                for (const auto item : tasksInfo) {
                    (void)iter->second.insert(item);
                }
            }
        }
    }
    return AICPU_SCHEDULE_OK;
}

void OpDumpTaskManager::UnloadClearTaskInfo(const TaskInfo &dumpTaskInfo)
{
    const auto range = dumpTaskMap_.equal_range(dumpTaskInfo);
    if (range.first != range.second) {
        for (auto item = range.first; item != range.second; ++item) {
            item->second->ClearBaseDumpData();
        }
    }
    (void)dumpTaskMap_.erase(dumpTaskInfo);
    return;
}

int32_t OpDumpTaskManager::Unload(const aicpu::dump::OpMappingInfo &opMappingInfo,
                                  AicpuSqeAdapter &aicpuSqeAdapter)
{
    const std::lock_guard<std::mutex> mapLock(dumpTaskMapMtx_);
    uint32_t streamId  = INVALID_VAL;
    uint32_t taskId = INVALID_VAL;
    if (!aicpuSqeAdapter.IsAdapterInvalidParameter()) {
        AicpuSqeAdapter::AicpuDataDumpInfoLoad info {};
        aicpuSqeAdapter.GetAicpuDataDumpInfoLoad(info);
        streamId = info.stream_id;
        taskId = info.task_id;
    }
    for (int32_t i = 0; i < opMappingInfo.task_size(); ++i) {
        const aicpu::dump::Task task = opMappingInfo.task(i);
        AicpuSqeAdapter::AicpuOpMappingDumpTaskInfo opmappingInfo(task.task_id(), task.stream_id(), taskId, streamId);
        AicpuSqeAdapter::AicpuDumpTaskInfo taskInfo{};
        aicpuSqeAdapter.GetAicpuDumpTaskInfo(opmappingInfo, taskInfo);
        uint32_t contextIdTmp = INVALID_VAL;
        uint32_t threadIdTmp = INVALID_VAL;
        const auto &contextFromMapInfo = task.context();
        uint32_t contextFromMapInfoSize = static_cast<uint32_t>(contextFromMapInfo.size());
        bool isFftsPlusUnload = false;
        for (uint32_t j = 0U; j < contextFromMapInfoSize; ++j) {
            auto &item = contextFromMapInfo.at(j);
            contextIdTmp = item.context_id();
            threadIdTmp = item.thread_id();
            const TaskInfo dumpTaskInfo(taskInfo.stream_id, taskInfo.task_id, contextIdTmp, threadIdTmp);
            UnloadClearTaskInfo(dumpTaskInfo);
            aicpusd_info("Unload stream id[%u], task id[%u], streamIdTmp[%u], taskIdTmp[%u],"
                " context id[%u], threadIdTmp[%u].", streamId, taskId, taskInfo.stream_id, taskInfo.task_id,
                contextIdTmp, threadIdTmp);
            isFftsPlusUnload = true;
        }
        if (isFftsPlusUnload == false) {
            const TaskInfo dumpTaskInfo(taskInfo.stream_id, taskInfo.task_id, contextIdTmp, threadIdTmp);
            UnloadClearTaskInfo(dumpTaskInfo);
            aicpusd_info("Unload op mapping info, stream id[%u], task id[%u], streamIdTmp[%u], taskIdTmp[%u],"
                " context id[%u], threadIdTmp[%u].", streamId, taskId, taskInfo.stream_id, taskInfo.task_id,
                contextIdTmp, threadIdTmp);
        }
    }
    MappingInfoOptionalParam optionalParam;
    GetOptionalParam(opMappingInfo, optionalParam);
    if (optionalParam.hasModelId) {
        const auto iter = modelIdToTask_.find(optionalParam.modelId);
        if (iter == modelIdToTask_.end()) {
            aicpusd_warn("no model id[%u], unload dump model failed", optionalParam.modelId);
            return AICPU_SCHEDULE_OK;
        }
        for (const auto taskInfo : iter->second) {
            UnloadClearTaskInfo(taskInfo);
            aicpusd_info("Check and clean data dump task resource, stream id[%u], task id[%u]"
                " context id[%u], thread id [%u].",
                taskInfo.streamId_, taskInfo.taskId_, taskInfo.contextId_, taskInfo.threadId_);
        }
        (void)modelIdToTask_.erase(iter);
        aicpusd_info("unload model id[%u] success", optionalParam.modelId);
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OpDumpTaskManager::LoadOpMappingInfo(const char_t * const infoAddr, const uint32_t len)
{
    AicpuSqeAdapter aicpuSqeAdapter(0U);
    return LoadOpMappingInfo(infoAddr, len, aicpuSqeAdapter);
}

int32_t OpDumpTaskManager::LoadOpMappingInfo(const char_t * const infoAddr, const uint32_t len, AicpuSqeAdapter &aicpuSqeAdapter)
{
    uint32_t streamId  = INVALID_VAL;
    uint64_t taskId = INVALID_VAL;
    if (!aicpuSqeAdapter.IsAdapterInvalidParameter()) {
        AicpuSqeAdapter::AicpuDataDumpInfoLoad info {};
        aicpuSqeAdapter.GetAicpuDataDumpInfoLoad(info);
        streamId = info.stream_id;
        taskId = info.task_id;
    }
    aicpusd_info("Load op mapping info, size[%u], streamId[%u], taskId[%u]", len, streamId, taskId);
    if (infoAddr == nullptr) {
        aicpusd_err("op mapping info addr is null");
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    aicpu::dump::OpMappingInfo opMappingInfo;
    const std::string protoInfo(infoAddr, static_cast<uint64_t>(len));
    const bool parseRet = opMappingInfo.ParseFromString(protoInfo);
    if (!parseRet) {
        aicpusd_err("parse op mapping info failed");
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    if (opMappingInfo.flag() == 0x01U) {
        return Load(opMappingInfo, aicpuSqeAdapter);
    } else if (opMappingInfo.flag() == 0x00U) {
        return Unload(opMappingInfo, aicpuSqeAdapter);
    } else {
        aicpusd_err("Flag [%d] invalid, allow [0x00, 0x01]", opMappingInfo.flag());
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OpDumpTaskManager::DumpOpInfo(const uint32_t streamId, const uint32_t taskId,
                                      const uint32_t streamId1, const uint32_t taskId1)
{
    TaskInfoExt dumpTaskInfo;
    dumpTaskInfo.streamId_ = streamId;
    dumpTaskInfo.taskId_ = taskId;
    dumpTaskInfo.contextId_ = INVALID_VAL;
    dumpTaskInfo.threadId_ = INVALID_VAL;
    bool isDebug = ((streamId1 != INVALID_VAL) && (taskId1 != INVALID_VAL));
    uint32_t fileNameStreamId = isDebug ? streamId1 : streamId;
    uint32_t fileNameTaskId = isDebug ? taskId1 : taskId;
    DumpFileName dumpFileName(fileNameStreamId, fileNameTaskId);
    return DumpOpInfo(dumpTaskInfo, dumpFileName);
}

int32_t OpDumpTaskManager::DumpOpInfo(TaskInfoExt &dumpTaskInfo,
                                      const uint32_t streamId, const uint32_t taskId,
                                      const uint32_t contextId, const uint32_t threadId) 
{
    DumpFileName dumpFileName(streamId, taskId, contextId, threadId);
    return DumpOpInfo(dumpTaskInfo, dumpFileName);
}

int32_t OpDumpTaskManager::DumpOpInfo(TaskInfoExt &dumpTaskInfo,
                                      const DumpFileName &dumpFileName)
{
    TaskInfo curTaskInfo(dumpTaskInfo.streamId_, dumpTaskInfo.taskId_,
                         dumpTaskInfo.contextId_, dumpTaskInfo.threadId_);
    dumpTaskMapMtx_.lock();
    const auto range = dumpTaskMap_.equal_range(curTaskInfo);
    if (range.first == range.second) {
        dumpTaskMapMtx_.unlock();
        aicpusd_warn("task required to dump does not exist, stream id[%u], task id[%u], " \
            "context id[%u], thread id[%u].", dumpTaskInfo.streamId_,
            dumpTaskInfo.taskId_, dumpTaskInfo.contextId_, dumpTaskInfo.threadId_);
        return AICPU_SCHEDULE_OK;
    } else {
        std::vector<std::shared_ptr<OpDumpTask>> opDumptasks;
        for (auto item = range.first; item != range.second; ++item) {
            std::shared_ptr<OpDumpTask> opDumpTask = item->second;
            opDumptasks.push_back(std::move(opDumpTask));
        }
        int32_t ret = AICPU_SCHEDULE_OK;
        dumpTaskMapMtx_.unlock();
        aicpusd_run_info("require to dump op info, stream id=%u, task id=%u, context id=%u, " \
            "thread id=%u, task number=%zu", dumpTaskInfo.streamId_, dumpTaskInfo.taskId_,
            dumpTaskInfo.contextId_, dumpTaskInfo.threadId_, opDumptasks.size());
        uint32_t indexId = 0;
        for (auto item : opDumptasks) {
            auto startTime = std::chrono::steady_clock::now();
            const KfcDumpTask kfcDumpTaskinfo(dumpTaskInfo.streamId_, dumpTaskInfo.taskId_, indexId);
            MakeDumpOpInfoforKfc(kfcDumpTaskinfo, item);
            dumpTaskInfo.indexId_ = indexId;
            aicpusd_run_info("start to dump op info, stream id=%u, task id=%u, context id=%u, " \
                "thread id=%u, op name=%s", dumpTaskInfo.streamId_, dumpTaskInfo.taskId_,
                dumpTaskInfo.contextId_, dumpTaskInfo.threadId_, item->GetOpName().c_str());
            ret = item->DumpOpInfo(dumpTaskInfo, dumpFileName);
            auto endTime = std::chrono::steady_clock::now();
            double drUs = std::chrono::duration<double, std::micro>(endTime - startTime).count();
            aicpusd_run_info("end of dump op info, result=%d, stream id=%u, task id=%u, " \
                "context id=%u, thread id=%u, op name=%s, cost time is [%.2lf]us", ret, dumpTaskInfo.streamId_,
                dumpTaskInfo.taskId_, dumpTaskInfo.contextId_, dumpTaskInfo.threadId_,
                item->GetOpName().c_str(), drUs);
            UNUSED(drUs);
            if (ret != AICPU_SCHEDULE_OK) {
                ClearKfcDumpTaskInfo(kfcDumpTaskinfo);
                return ret;
            }
            indexId++;
            ClearKfcDumpTaskInfo(kfcDumpTaskinfo);
        }
        // process if task is end graph
        ProcessEndGraph(opDumptasks);
    }
    return AICPU_SCHEDULE_OK;
}

int32_t OpDumpTaskManager::DumpOpInfoForUnknowShape(const uint64_t opMappingInfoAddr,
                                                    const uint64_t opMappingInfoLen) const
{
    aicpusd_info("load op mapping info for single op or unknown shape op, size[%llu]", opMappingInfoLen);
    if (opMappingInfoAddr == 0U) {
        aicpusd_err("op mapping info addr is null");
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    aicpu::dump::OpMappingInfo opMappingInfo;
    const std::string protoInfo(PtrToPtr<const void, const char_t>(ValueToPtr(opMappingInfoAddr)),
        opMappingInfoLen);
    const bool parseRet = opMappingInfo.ParseFromString(protoInfo);
    if (!parseRet) {
        aicpusd_err("parse op mapping info failed, size[%u]", opMappingInfoLen);
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    const int32_t taskSize = opMappingInfo.task_size();
    if (taskSize != 1) {
        aicpusd_err("task number[%d] should be only one, op mapping info: %s",
            opMappingInfo.task_size(), opMappingInfo.DebugString().c_str());
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    return DoDump(opMappingInfo);
}

int32_t OpDumpTaskManager::DoDump(const aicpu::dump::OpMappingInfo &opMappingInfo) const
{
    const std::string dumpPath = opMappingInfo.dump_path();
    MappingInfoOptionalParam optionalParam;
    GetOptionalParam(opMappingInfo, optionalParam);
    const std::string dumpStepStr = opMappingInfo.dump_step();

    DumpStep dumpStep;
    if (!GetDumpStepFromString(dumpStepStr, dumpStep)) {
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    const int32_t hostPid = static_cast<int32_t>(AicpuSchedule::AicpuDrvManager::GetInstance().GetHostPid());
    const uint32_t deviceId = AicpuSchedule::AicpuDrvManager::GetInstance().GetDeviceId();
    std::shared_ptr<OpDumpTask> opDumpTaskPtr = nullptr;
    int32_t ret = CreateOpDumpTask(opDumpTaskPtr, hostPid, deviceId);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Create opDumpTask failed, hostPid[%d], deviceId[%u]", hostPid, deviceId);
        return ret;
    }
    aicpusd_memory_log("MallocMemory, func=new, size=%zu, purpose=data dumper", sizeof(OpDumpTask));
    if (opDumpTaskPtr == nullptr) {
        aicpusd_err("malloc memory for OpDumpTask object failed");
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    const aicpu::dump::Task task = opMappingInfo.task(0);
    DumpMode dumpMode = opMappingInfo.dump_data();
    aicpusd_info("isSingleOrUnknowShapeOp[true], hasStepId[%u], task_id[%u], stream_id[%u] dumpMode[%d]",
        static_cast<uint32_t>(optionalParam.hasStepId), task.task_id(), task.stream_id(),
        static_cast<int32_t>(dumpMode));
    ret = opDumpTaskPtr->PreProcessOpMappingInfo(task,
                                                 dumpPath,
                                                 optionalParam,
                                                 dumpStep,
                                                 dumpMode,
                                                 true);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("pre process op mapping info failed, op mapping info: %s",
            opMappingInfo.DebugString().c_str());
        return ret;
    }
    AicpuSqeAdapter adapter(FeatureCtrl::GetTsMsgVersion());
    AicpuSqeAdapter::AicpuOpMappingDumpTaskInfo opmappingInfo(task.task_id(), task.stream_id(), INVALID_VAL, INVALID_VAL);
    AicpuSqeAdapter::AicpuDumpTaskInfo taskInfo{};
    adapter.GetAicpuDumpTaskInfo(opmappingInfo, taskInfo);
    auto startTime = std::chrono::steady_clock::now();
    aicpusd_run_info("start to dump op info, op name=%s", opDumpTaskPtr->GetOpName().c_str());
    const KfcDumpTask kfcDumpTaskinfo(taskInfo.stream_id, taskInfo.task_id, 0);
    const_cast<OpDumpTaskManager *>(this)->MakeDumpOpInfoforKfc(kfcDumpTaskinfo, opDumpTaskPtr);
    const TaskInfoExt dumpTaskInfo(taskInfo.stream_id, taskInfo.task_id, INVALID_VAL, INVALID_VAL, 0);
    DumpFileName dumpFileName(taskInfo.stream_id, taskInfo.task_id);
    ret = opDumpTaskPtr->DumpOpInfo(dumpTaskInfo, dumpFileName);
    auto endTime = std::chrono::steady_clock::now();
    double drUs = std::chrono::duration<double, std::micro>(endTime - startTime).count();
    aicpusd_run_info("end of dump op info, result=%d, op name=%s, cost time is [%.2lf]us",
        ret, opDumpTaskPtr->GetOpName().c_str(), drUs);
    UNUSED(drUs);
    opDumpTaskPtr->ClearBaseDumpData();
    const_cast<OpDumpTaskManager *>(this)->ClearKfcDumpTaskInfo(kfcDumpTaskinfo);
    return ret;
}

void OpDumpTaskManager::ProcessEndGraph(const std::vector<std::shared_ptr<OpDumpTask>> &opDumptasks)
{
    for (const auto &item : opDumptasks) {
        if (item->IsEndGraph()) {
            uint32_t modelId;
            if (item->GetModelId(modelId)) {
                UpdateDumpNumByModelId(modelId);
            } else {
                item->UpdateDumpNum();
            }
        }
    }
}

void OpDumpTaskManager::UpdateDumpNumByModelId(const uint32_t modelId)
{
    std::vector<std::shared_ptr<OpDumpTask>> opDumptasks;
    {
        const std::lock_guard<std::mutex> mapLock(dumpTaskMapMtx_);
        const auto iter = modelIdToTask_.find(modelId);
        if (iter != modelIdToTask_.end()) {
            for (auto &taskInfo : iter->second) {
                const auto range = dumpTaskMap_.equal_range(taskInfo);
                for (auto item = range.first; item != range.second; ++item) {
                    std::shared_ptr<OpDumpTask> opDumpTask = item->second;
                    opDumptasks.push_back(std::move(opDumpTask));
                }
            }
        }
    }

    for (auto &dumpTask : opDumptasks) {
        dumpTask->UpdateDumpNum();
    }
}


static void DoSplit(const std::string &externStr, std::vector<std::string> &ret, const std::string &delim)
{
    size_t i = 0UL;
    while (i < externStr.size()) {
        const size_t pos = externStr.find(delim, i);
        if (pos != std::string::npos) {
            std::string s = externStr.substr(i, pos - i);
            if (!s.empty()) {
                ret.push_back(std::move(s));
            }
            i = pos + delim.size() - 1UL;
        }
        ++i;
    }
}

static std::vector<std::string> Split(const std::string &str, const std::string &delim)
{
    std::vector<std::string> ret;
    if (!str.empty()) {
        const std::string externStr = str + delim;
        DoSplit(externStr, ret, delim);
    }
    return ret;
}

bool OpDumpTaskManager::MatchAndInsert(const std::string &step, DumpStep &tmpDumpStep) const
{
    // smatch result
    const std::regex singleStepPatten("(\\s*)(\\d+)(\\s*)");
    const std::regex intervalStepPatten("((\\s*)(\\d+)(\\s*)){1}(-(\\s*)(\\d+)(\\s*))");
    if (std::regex_match(step, singleStepPatten)) {
        (void)tmpDumpStep.singleStep.insert(static_cast<uint64_t>(std::stoull(step)));
    } else if (std::regex_match(step, intervalStepPatten)) {
        const std::vector<std::string> intervalStepStr = Split(step, "-");
        if (intervalStepStr.size() == INTERNAL_STEP_SIZE) {
            IntervalStep intervalStep;
            intervalStep.start = static_cast<uint64_t>(std::stoull(intervalStepStr[0U]));
            intervalStep.end = static_cast<uint64_t>(std::stoull(intervalStepStr[1U]));
            if (intervalStep.start > intervalStep.end) {
                std::swap(intervalStep.start, intervalStep.end);
            }
            tmpDumpStep.intervalStep.push_back(std::move(intervalStep));
        }
    } else {
        aicpusd_err("invalid step[%s], please check.", step.c_str());
        return false;
    }
    return true;
}

bool OpDumpTaskManager::GetDumpStepFromString(const std::string &str, DumpStep &dumpStep) const
{
    // split by |, such as "0|5-10"
    aicpusd_info("Step need to dump[%s].", str.c_str());
    const std::vector<std::string> steps = Split(str, "|");
    DumpStep tmpDumpStep;
    for (const auto &step : steps) {
        try {
            if (!MatchAndInsert(step, tmpDumpStep)) {
                return false;
            }
        } catch (std::out_of_range &e) {
            aicpusd_err("out of range of uint64_max[%llu], invalid step[%s], msg[%s], please check.",
                        UINT64_MAX, step.c_str(), e.what());
            return false;
        } catch (...) {
            aicpusd_err("invalid step[%s], please check.", step.c_str());
            return false;
        }
    }
    dumpStep = std::move(tmpDumpStep);
    return true;
}

void OpDumpTaskManager::ClearResource()
{
    const std::lock_guard<std::mutex> mapLock(dumpTaskMapMtx_);
    aicpusd_run_info("clear all resource of data dump");
    dumpTaskMap_.clear();
    modelIdToTask_.clear();
    kfcDumpTaskMap_.clear();
    kfcDumpInfoMap_.clear();
    custDumpTaskMap_.clear();
}

/*
 * 清除资源
 */
void OpDumpTaskManager::ClearKfcDumpTaskInfo(const KfcDumpTask &kfcTaskinfo)
{
    const std::lock_guard<std::mutex> mapLock(kfcDumpTaskMapMtx_);
    if (kfcDumpTaskMap_.find(kfcTaskinfo) != kfcDumpTaskMap_.end()) {
        (void)kfcDumpTaskMap_.erase(kfcTaskinfo);
        aicpusd_info("erase key of dump task map : streamId[%u], taskId[%u], index[%u]", kfcTaskinfo.streamId_, kfcTaskinfo.taskId_, kfcTaskinfo.index_);
    }
    if (kfcDumpInfoMap_.find(kfcTaskinfo) != kfcDumpInfoMap_.end()) {
        (void)kfcDumpInfoMap_.erase(kfcTaskinfo);
        aicpusd_info("erase key of dump info map : streamId[%u], taskId[%u], index[%u]", kfcTaskinfo.streamId_, kfcTaskinfo.taskId_, kfcTaskinfo.index_);
    }
    TaskInfo taskInfo(kfcTaskinfo.streamId_ , kfcTaskinfo.taskId_);
    if (custDumpTaskMap_.find(taskInfo) != custDumpTaskMap_.end()) {
        (void)custDumpTaskMap_.erase(taskInfo);
        aicpusd_info("erase key of cust dump task map : streamId[%u], taskId[%u], index[%u]", kfcTaskinfo.streamId_, kfcTaskinfo.taskId_, kfcTaskinfo.index_);
    }
    return;
}


/*
 * 查询是否是aicpu cust dump 任务
 */
bool OpDumpTaskManager::IsCustDumpTask(const uint32_t streamId, const uint32_t taskId)
{
    TaskInfo taskInfo(streamId, taskId);
    const auto iter = custDumpTaskMap_.find(taskInfo);
    if (iter == custDumpTaskMap_.end()) {
        aicpusd_info("Can not find dump task [streamId:%u, taskId:%u] in cust dump task map.", streamId, taskId);
        return false;
    }
    aicpusd_info("Get dump task [streamId:%u, taskId:%u] flag is [%d].", streamId, taskId, iter->second);
    return iter->second;
}

/*
 * 获取是否是aicpu cust dump 任务
 */
int32_t OpDumpTaskManager::SetCustDumpTaskFlag(const uint32_t streamId, const uint32_t taskId, const bool flag)
{
    TaskInfo taskInfo(streamId, taskId);
    custDumpTaskMap_.insert(std::make_pair(taskInfo, flag));
    aicpusd_info("Set dump task [streamId:%u, taskId:%u] flag [%d] in cust dump task map.", streamId, taskId, flag);
    return AICPU_SCHEDULE_OK;
}

/*
 * 构造kfc需要的dump信息映射关系{steamid taskid index, task}
 */
void OpDumpTaskManager::MakeDumpOpInfoforKfc(const KfcDumpTask &taskinfo, std::shared_ptr<OpDumpTask> dumpTask)
{
    const std::lock_guard<std::mutex> mapLock(kfcDumpTaskMapMtx_);
    if (!(dumpTask->IsSupportKfcDump())) {
        aicpusd_info("task not support kfc statistical dump, streamId[%u], taskId[%u].", taskinfo.streamId_, taskinfo.taskId_);
        return;
    }
    kfcDumpTaskMap_.insert(std::make_pair(taskinfo, dumpTask));
    aicpusd_info("Make kfc dump task map, streamId[%u], taskId[%u], index[%u]", taskinfo.streamId_, taskinfo.taskId_, taskinfo.index_);
    return;
}
int32_t OpDumpTaskManager::CreateKfcDumpInfo(std::shared_ptr<KfcDumpInfo> &kfcDumpInfoPtr) const
{
    DATADUMP_MAKE_SHARED(kfcDumpInfoPtr = std::make_shared<KfcDumpInfo>(),
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    return AICPU_SCHEDULE_OK;
}
/*
 * 向kfc提供dump查询信息接口
 */
int32_t OpDumpTaskManager::GetDumpOpTaskDataforKfc(const KfcDumpTask &taskKey, KfcDumpInfo **dumpInfo)
{
    const std::lock_guard<std::mutex> mapLock(kfcDumpTaskMapMtx_);
    aicpusd_info("Get dump info for kfc, streamId[%u], taskId[%u], index[%u].", 
                  taskKey.streamId_, taskKey.taskId_, taskKey.index_);
    // dumpInfo 是否为空在上层调用处保证
    const auto iter = kfcDumpTaskMap_.find(taskKey);
    if (iter == kfcDumpTaskMap_.end()) {
        aicpusd_err("Can not find dump task info key for kfc. streamId[%u], taskId[%u], index[%u].",
                     taskKey.streamId_, taskKey.taskId_, taskKey.index_);
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    if (iter->second == nullptr) {
        aicpusd_err("Get dump task info failed. streamId[%u], taskId[%u], index[%u]",
                     taskKey.streamId_, taskKey.taskId_, taskKey.index_);
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }

    std::shared_ptr<KfcDumpInfo> kfcDumpInfoPtr = nullptr;
    int32_t ret = CreateKfcDumpInfo(kfcDumpInfoPtr);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Create opDumpTask failed streamId[%u], taskId[%u], index[%u]",
                     taskKey.streamId_, taskKey.taskId_, taskKey.index_);
        return ret;
    }
    if (kfcDumpInfoPtr == nullptr) {
        aicpusd_err("malloc memory for KfcDumpInfo object failed");
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    iter->second->GetKfcDumpInfo(kfcDumpInfoPtr);
    kfcDumpInfoMap_.insert(std::make_pair(taskKey, kfcDumpInfoPtr));
    *dumpInfo = kfcDumpInfoPtr.get();
    return AICPU_SCHEDULE_OK;
}

/*
 * 向kfc提供dump数据接口
 */
int32_t OpDumpTaskManager::DumpOpTaskDataforKfc(const KfcDumpTask &taskKey, void *dumpData, uint32_t length) const
{
    aicpusd_info("dump op task data for kfc, length [%u], streamId[%u], taskId[%u], index[%u]",
                  length, taskKey.streamId_, taskKey.taskId_, taskKey.index_);
    // dumpData 是否为空在上层调用处保证
    const auto iter = kfcDumpTaskMap_.find(taskKey);
    if (iter == kfcDumpTaskMap_.end()) {
        aicpusd_err("Not get dump info for kfc. length [%u], streamId[%u], taskId[%u], index[%u].",
                     length, taskKey.streamId_, taskKey.taskId_, taskKey.index_);
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    if (iter->second == nullptr) {
        aicpusd_err("Get dump task failed. length [%u], streamId[%u], taskId[%u], index[%u]",
                     length, taskKey.streamId_, taskKey.taskId_, taskKey.index_);
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    const std::string filePath = iter->second->GetDumpPath();
    const std::string dumpFilePath = filePath + ".bin";
    int32_t hostPid = iter->second->GetHostPid();
    uint32_t deviceId = iter->second->GetDeviceId();
    const std::string opName = iter->second->GetOpName();
    const std::string privateInfo = "127.0.0.1:22118;" + std::to_string(deviceId) + ";" + std::to_string(hostPid);
    aicpusd_info("op name[%s], ide dump start private info[%s]", opName.c_str(), privateInfo.c_str());
    const IDE_SESSION ideSession = IdeDumpStart(privateInfo.c_str());
    if (ideSession == nullptr) {
        aicpusd_err("op name[%s], call IdeDumpStart failed, path[%s] private info[%s]. length [%u], streamId[%u], taskId[%u], index[%u]",
                    opName.c_str(), dumpFilePath.c_str(), privateInfo.c_str(), length, taskKey.streamId_, taskKey.taskId_, taskKey.index_);
        return AICPU_SCHEDULE_ERROR_DUMP_FAILED;
    }
    const ScopeGuard ideSessGuard([&ideSession]() {
            IdeDumpEnd(ideSession);
    });

    return iter->second->Dump(dumpFilePath, PtrToPtr<void, char>(dumpData), length, ideSession, true);
}
}  // namespace aicpu