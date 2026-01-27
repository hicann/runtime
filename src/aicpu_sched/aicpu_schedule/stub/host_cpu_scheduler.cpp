/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <list>
#include "profiling_adp.h"
#include "aicpu_engine.h"
#include "ascend_hal.h"
#include "task_queue.h"
#include "dump_task.h"
#include "aicpusd_status.h"
#include "aicpu_async_event.h"
#include "aicpusd_mpi_mgr.h"
#include "aicpusd_task_queue.h"
#include "aicpusd_queue_event_process.h"
#include "aicpusd_context.h"
#include "tdt/status.h"
#include "tsd.h"
#include "common/type_def.h"

namespace aicpu {
#ifdef __cplusplus
extern "C" {
#endif

bool IsProfOpen()
{
    return false;
}

bool IsModelProfOpen()
{
    return false;
}

void UpdateMode(bool mode) 
{
    (void)mode;
}
void UpdateModelMode(const bool mode) 
{
    (void)mode;
}

uint64_t GetSystemTick()
{
    return 0;
}

uint64_t GetSystemTickFreq()
{
    return 0;
}

void SendToProfiling(const std::string &sendData, const std::string &mark)
{
    UNUSED(sendData);
    UNUSED(mark);
}

int32_t SetProfHandle(std::shared_ptr<ProfMessage> prof)
{
    UNUSED(prof);
    return 0;
}

uint64_t NowMicros()
{
    return 1;
}

void ReleaseProfiling()
{
}

void InitProfiling(const uint32_t deviceId, const pid_t hostPid, const uint32_t channelId)
{
    UNUSED(deviceId);
    UNUSED(hostPid);
    UNUSED(channelId);
}

void InitProfilingDataInfo(const uint32_t deviceId, const pid_t hostPid, const uint32_t channelId)
{
    UNUSED(deviceId);
    UNUSED(hostPid);
    UNUSED(channelId);
}

void SetProfilingFlagForKFC(const uint32_t flag)
{
    UNUSED(flag);
}
void LoadProfilingLib()
{
}
#ifdef __cplusplus
}
#endif

ProfMessage::ProfMessage(const char* tag) : tag_(tag)
{
}

ProfMessage::~ProfMessage()
{
}

int32_t ProfModelMessage::ReportProfModelMessage()
{
    return 0;
}

int32_t SetMsprofReporterCallback(MsprofReporterCallback reportCallback)
{
    UNUSED(reportCallback);
    return 0;
}
} // namespace aicpu

int32_t aeCallInterface(const void * const addr)
{
    UNUSED(addr);
    return AE_STATUS_SUCCESS;
}

aeStatus_t aeBatchLoadKernelSo(const uint32_t kernelType,
                               const uint32_t loadSoNum,
                               const char * const * const soNames)
{
    UNUSED(kernelType);
    UNUSED(loadSoNum);
    UNUSED(soNames);
    return AE_STATUS_SUCCESS;
}

aeStatus_t aeCloseSo(uint32_t kernelType, const char *soName)
{
    UNUSED(kernelType);
    UNUSED(soName);
    return AE_STATUS_SUCCESS;
}

drvError_t drvHdcGetCapacity(struct drvHdcCapacity *capacity)
{
    UNUSED(capacity);
    return DRV_ERROR_NONE;
}

int32_t TsdDestroy(const uint32_t deviceId, const TsdWaitType waitType, const uint32_t hostPid, const uint32_t vfId)
{
    UNUSED(deviceId);
    UNUSED(waitType);
    UNUSED(hostPid);
    UNUSED(vfId);
    return 0;
}

int32_t StartupResponse(const uint32_t deviceId, const TsdWaitType waitType,
                        const uint32_t hostPid, const uint32_t vfId)
{
    UNUSED(deviceId);
    UNUSED(waitType);
    UNUSED(hostPid);
    UNUSED(vfId);
    return 0;
}

int32_t WaitForShutDown(const uint32_t deviceId)
{
    UNUSED(deviceId);
    return 0;
}

int32_t StopWaitForCustAicpu()
{
    return 0;
}

namespace AicpuSchedule {
StatusCode GetAicpuDeployContext(DeployContext &deployContext)
{
    deployContext = DeployContext::HOST;
    return AICPU_SCHEDULE_OK;
}

OpDumpTaskManager &OpDumpTaskManager::GetInstance()
{
    static OpDumpTaskManager instance;
    return instance;
}

void OpDumpTaskManager::ClearResource()
{
}

int32_t OpDumpTaskManager::DumpOpInfo(TaskInfoExt &dumpTaskInfo,
                                      const uint32_t streamId, const uint32_t taskId,
                                      const uint32_t contextId, const uint32_t threadId) 
{
    UNUSED(dumpTaskInfo);
    UNUSED(streamId);
    UNUSED(taskId);
    UNUSED(contextId);
    UNUSED(threadId);
    return AICPU_SCHEDULE_OK;
} 
int32_t OpDumpTaskManager::DumpOpInfo(const uint32_t streamId, const uint32_t taskId,
                                      const uint32_t streamId1, const uint32_t taskId1)
{
    UNUSED(streamId);
    UNUSED(taskId);
    UNUSED(streamId1);
    UNUSED(taskId1);
    return AICPU_SCHEDULE_OK;
}


int32_t OpDumpTaskManager::DumpOpInfo(TaskInfoExt &dumpTaskInfo,
                                      const DumpFileName &dumpFileName)
{
    UNUSED(dumpTaskInfo);
    UNUSED(dumpFileName);
    return AICPU_SCHEDULE_OK;
}

int32_t OpDumpTaskManager::DumpOpInfoForUnknowShape(const uint64_t opMappingInfoAddr,
                                                    const uint64_t opMappingInfoLen) const
{
    UNUSED(opMappingInfoAddr);
    UNUSED(opMappingInfoLen);
    return AICPU_SCHEDULE_OK;
}

int32_t OpDumpTaskManager::LoadOpMappingInfo(const char_t * const infoAddr, const uint32_t len,
                                             AicpuSqeAdapter &aicpuSqeAdapter)
{
    UNUSED(infoAddr);
    UNUSED(len);
    UNUSED(aicpuSqeAdapter);
    return AICPU_SCHEDULE_OK;
}
int32_t OpDumpTaskManager::LoadOpMappingInfo(const char_t * const infoAddr, const uint32_t len) 
{
    UNUSED(infoAddr);
    UNUSED(len);
    return AICPU_SCHEDULE_OK;
}

int32_t AicpuQueueEventProcess::ProcessQsMsg(const event_info &event)
{
    UNUSED(event);
    return AICPU_SCHEDULE_OK;
}

int32_t AicpuQueueEventProcess::ProcessDrvMsg(const event_info &event)
{
    UNUSED(event);
    return AICPU_SCHEDULE_OK;
}

int32_t AicpuQueueEventProcess::ProcessProxyMsg(const event_info &event)
{
    UNUSED(event);
    return AICPU_SCHEDULE_OK;
}

AicpuQueueEventProcess &AicpuQueueEventProcess::GetInstance()
{
    static AicpuQueueEventProcess instance;
    return instance;
}

namespace mpi {
MpiDvppStatisticManager &MpiDvppStatisticManager::Instance()
{
    static MpiDvppStatisticManager statisticManagerInstance;
    return statisticManagerInstance;
}

MpiDvppStatisticManager::~MpiDvppStatisticManager()
{
}

int32_t MpiDvppStatisticManager::PrintStatisticInfo() const
{
    return AicpuSchedule::AICPU_SCHEDULE_OK;
}

void MpiDvppStatisticManager::Record()
{
}

void MpiDvppStatisticManager::InitMpiDvpp()
{
}

void MpiDvppStatisticManager::OnPulse(const MpiDvppTimePoint &nowTimePoint)
{
    UNUSED(nowTimePoint);
}
} // namepsace mpi

bool TaskQueue::Enqueue(const aicpu::Closure &closure)
{
    UNUSED(closure);
    return true;
}

bool TaskQueue::Dequeue(aicpu::Closure &closure)
{
    UNUSED(closure);
    return true;
}

void TaskQueue::Clear()
{
}

std::string TaskQueue::DebugString() {return "";}

bool TaskMap::BatchAddTask(const AICPUSharderTaskInfo &taskInfo,
                           const std::queue<aicpu::Closure> &queue)
{
    UNUSED(taskInfo);
    UNUSED(queue);
    return true;
}

bool TaskMap::PopTask(const AICPUSharderTaskInfo &taskInfo, aicpu::Closure &closure)
{
    UNUSED(taskInfo);
    UNUSED(closure);
    return true;
}

void TaskMap::Clear() {}

std::string TaskMap::DebugString() {return "";}

} // namespace AicpuSchedule

namespace aicpu {
AsyncEventManager::AsyncEventManager() {}

AsyncEventManager::~AsyncEventManager() {}

AsyncEventManager &AsyncEventManager::GetInstance()
{
    static AsyncEventManager asyncEventManager;
    return asyncEventManager;
}

void AsyncEventManager::Register(const NotifyFunc &notify)
{
    UNUSED(notify);
    return;
}

void AsyncEventManager::NotifyWait(void *notifyParam, const uint32_t paramLen)
{
    UNUSED(notifyParam);
    UNUSED(paramLen);
    return;
}

bool AsyncEventManager::RegEventCb(const uint32_t eventId, const uint32_t subEventId,
                                   const EventProcessCallBack &cb, const int32_t times)
{
    UNUSED(eventId);
    UNUSED(subEventId);
    UNUSED(cb);
    UNUSED(times);
    return true;
}

void AsyncEventManager::ProcessEvent(const uint32_t eventId, const uint32_t subEventId, void *param)
{
    UNUSED(eventId);
    UNUSED(subEventId);
    UNUSED(param);
    return;
}

bool AsyncEventManager::RegOpEventCb(const uint32_t eventId, const uint32_t subEventId, const EventProcessCallBack &cb)
const {
    UNUSED(eventId);
    UNUSED(subEventId);
    UNUSED(cb);
    return true;
}

void AsyncEventManager::UnregOpEventCb(const uint32_t eventId, const uint32_t subEventId) const
{
    UNUSED(eventId);
    UNUSED(subEventId);
}

void AsyncEventManager::ProcessOpEvent(const uint32_t eventId, const uint32_t subEventId, void * const param) const
{
    UNUSED(eventId);
    UNUSED(subEventId);
    UNUSED(param);
}
} // namespace aicpu

namespace DataPreprocess {
    TaskQueueMgr& TaskQueueMgr::GetInstance()
    {
        static TaskQueueMgr instance;
        return instance;
    }

    TaskQueueMgr::TaskQueueMgr() {}
    TaskQueueMgr::~TaskQueueMgr() {}
    void TaskQueueMgr::OnPreprocessEvent(uint32_t eventId) 
    {
        UNUSED(eventId);
    }
} // namespace DataPreprocess

namespace tdt {
    int32_t TDTServerInit(const uint32_t deviceID, const std::list<uint32_t>& bindCoreList)
    {
        UNUSED(deviceID);
        UNUSED(bindCoreList);
        return 0;
    }

    int32_t TDTServerStop()
    {
        return 0;
    }

    StatusFactory* StatusFactory::GetInstance()
    {
        static StatusFactory instance;
        return &instance;
    }

    void StatusFactory::RegisterErrorNo(const uint32_t err, const std::string& desc) 
    {
        UNUSED(err);
        UNUSED(desc);
    }

    std::string StatusFactory::GetErrDesc(const uint32_t err)
    {
        UNUSED(err);
        return "";
    }

    std::string StatusFactory::GetErrCodeDesc(uint32_t errCode)
    {
        UNUSED(errCode);
        return "";
    }

    StatusFactory::StatusFactory() {}
} // namespace tdt

int halTsDevRecord(unsigned int devId, unsigned int tsId, unsigned int record_type, unsigned int record_Id)
{
    (void)devId;
    (void)tsId;
    (void)record_type;
    (void)record_Id;
    return 0;
}

#ifdef __cplusplus
extern "C" {
#endif

int32_t CreateOrFindCustPid(const uint32_t deviceId, const uint32_t loadLibNum,
    const char * const loadLibName[], const uint32_t hostPid, const uint32_t vfId, const char *groupNameList,
    const uint32_t groupNameNum, int32_t *custProcPid, bool *firstStart)
{
    UNUSED(deviceId);
    UNUSED(loadLibNum);
    UNUSED(loadLibName);
    UNUSED(vfId);
    UNUSED(groupNameList);
    UNUSED(hostPid);
    UNUSED(groupNameNum);
    UNUSED(firstStart);
    UNUSED(custProcPid);
    return 0;
}

int tsDevSendMsgAsync(unsigned int devId, unsigned int tsId, char *msg, unsigned int msgLen,
    unsigned int handleId)
{
    UNUSED(devId);
    UNUSED(tsId);
    UNUSED(msg);
    UNUSED(handleId);
    UNUSED(msgLen);
    return 0;
}


int32_t SendUpdateProfilingRspToTsd(const uint32_t deviceId, const uint32_t waitType,
                                    const uint32_t hostPid, const uint32_t vfId)
{
    UNUSED(deviceId);
    UNUSED(waitType);
    UNUSED(hostPid);
    UNUSED(vfId);
    return 0;
}
int32_t SetSubProcScheduleMode(const uint32_t deviceId, const uint32_t waitType,
                               const uint32_t hostPid, const uint32_t vfId,
                               const struct SubProcScheduleModeInfo *scheInfo)
{
    UNUSED(deviceId);
    UNUSED(waitType);
    UNUSED(hostPid);
    UNUSED(vfId);
    UNUSED(scheInfo);
    return 0;
}
#ifdef __cplusplus
}
#endif

