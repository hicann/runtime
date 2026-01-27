/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpu_cust_sd_dump_process.h"
 
#include <string.h>
#include <sched.h>
#include <semaphore.h>
#include "aicpusd_drv_manager.h"
#include "aicpusd_info.h"
#include "aicpusd_util.h"
#include "ProcMgrSysOperatorAgent.h"
#include "aicpusd_interface_process.h"
#include "aicpu_cust_platform_info_process.h"

namespace AicpuSchedule {
    namespace {
        constexpr const uint32_t DATA_DUMP_GRUOP_ID = 31U;
        constexpr const uint32_t DATA_DUMP_THREAD_INDEX = 0U;
        constexpr const uint64_t DATA_DUMP_EVENT_MASK = (1ULL << static_cast<uint32_t>(EVENT_CCPU_CTRL_MSG));
        constexpr const int32_t  DATA_DUMP_TIMEOUT_INTERVAL = 3000;
        constexpr const uint32_t SLEEP_USECS = 50000U;
    };

    AicpuCustDumpProcess &AicpuCustDumpProcess::GetInstance()
    {
        static AicpuCustDumpProcess instance;
        return instance;
    }

    AicpuCustDumpProcess::~AicpuCustDumpProcess()
    {
        UnitDataDumpProcess();
    }

    AicpuCustDumpProcess::AicpuCustDumpProcess()
        : deviceId_(0U), runningFlag_(false), initFlag_(false)
    {
    }

    int32_t AicpuCustDumpProcess::InitDumpProcess(const uint32_t deviceId, const uint32_t workCnt)
    {
        const std::lock_guard<std::mutex> lk(initMutex_);
        uint32_t runMode;
        const aicpu::status_t status = aicpu::GetAicpuRunMode(runMode);
        if (status != aicpu::AICPU_ERROR_NONE) {
            aicpusd_err("Get current aicpu ctx failed.");
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }
        if (runMode != aicpu::AicpuRunMode::PROCESS_PCIE_MODE) {
            aicpusd_info("not pcie mode no need this thread");
            return AICPU_SCHEDULE_OK;
        }
        if ((initFlag_) || (workCnt == 0U)) {
            aicpusd_info("workcnt:%u", workCnt);
            return AICPU_SCHEDULE_OK;
        }
        initFlag_ = true;
        deviceId_ = deviceId;
        runningFlag_ = true;
        if (InitWaitConVec(workCnt) != AICPU_SCHEDULE_OK) {
            aicpusd_err("InitWaitConVec init failed");
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        const int32_t semRet = sem_init(&workerSme_, 0, 0U);
        if (semRet == -1) {
            aicpusd_err("workerSme_ init failed, %s", strerror(errno));
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }

        try {
            msgThread_ = std::thread(&AicpuCustDumpProcess::StartProcessEvent, this);
        } catch (std::exception &e) {
            aicpusd_err("create thread file:%s", e.what());
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        const int32_t semWaitRet = sem_wait(&workerSme_);
        if (semWaitRet == -1) {
            aicpusd_err("workerSme wait failed, %s", strerror(errno));
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustDumpProcess::SetDataDumpThreadAffinity() const
    {
        std::vector<uint32_t> ccpuIds = AicpuDrvManager::GetInstance().GetCcpuList();
        if (ccpuIds.empty()) {
            aicpusd_run_info("ccpu list is empty no need bind core");
            return AICPU_SCHEDULE_OK;
        }
        if (AicpuUtil::IsEnvValEqual(ENV_NAME_PROCMGR_AICPU_CPUSET, "1")) {
            const pid_t tid = static_cast<pid_t>(GetTid());
            auto ret = ProcMgrBindThread(tid, ccpuIds);
            uint32_t tryTimes = 0;
            while ((ret != 0U) && (tryTimes <= 1)) {
                aicpusd_warn("set affinity failed ret[%d], will try again", ret);
                (void)usleep(SLEEP_USECS);
                ret = ProcMgrBindThread(tid, ccpuIds);
                tryTimes++;
            }
            if (ret != 0) {
                aicpusd_err("aicpu bind tid by pm res[%d].", ret);
                return AICPU_SCHEDULE_ERROR_INNER_ERROR;
            } else {
                aicpusd_run_info("aicpu bind by pm success");
                return AICPU_SCHEDULE_OK;
            }
        } else {
            pthread_t threadId = pthread_self();
            cpu_set_t cpuset;
            CPU_ZERO(&cpuset);
            for (const auto cpuId: ccpuIds) {
                CPU_SET(cpuId, &cpuset);
                aicpusd_info("prepare bind threadId=%lu to cpuId=%u", threadId, static_cast<uint32_t>(cpuId));
            }
            const int32_t ret = pthread_setaffinity_np(threadId, sizeof(cpu_set_t), &cpuset);
            if (ret != 0) {
                aicpusd_run_warn("Datadump thread bind ctrl cpu not success, will run in aicpu. ret=%d, reason=%s",
                                 ret, strerror(errno));
            } else {
                aicpusd_run_info("aicpu bind by self success");
            }
        }

        return AICPU_SCHEDULE_OK;
    }

    void AicpuCustDumpProcess::StartProcessEvent()
    {
        int32_t ret = halEschedCreateGrp(deviceId_, DATA_DUMP_GRUOP_ID, GRP_TYPE_BIND_CP_CPU);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("halEschedCreateGrp dev[%u] group[%u] type[%d] failed, result[%d].",
                        deviceId_, DATA_DUMP_GRUOP_ID, GRP_TYPE_BIND_CP_CPU, ret);
            sem_post(&workerSme_);
            return;
        }
 
        if (SetDataDumpThreadAffinity() != AICPU_SCHEDULE_OK) {
            aicpusd_err("datadump thread bind core failed");
            sem_post(&workerSme_);
            return;
        }
        ret = halEschedSubscribeEvent(deviceId_, DATA_DUMP_GRUOP_ID, DATA_DUMP_THREAD_INDEX, DATA_DUMP_EVENT_MASK);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("halEschedSubscribeEvent failed, deviceId[%u], groupId[%u], threadIndex[%u]",
                        deviceId_, DATA_DUMP_GRUOP_ID, DATA_DUMP_THREAD_INDEX);
            sem_post(&workerSme_);
            return;
        }
        ProcessMessage(0U);
        sem_post(&workerSme_);
        aicpusd_run_info("post work sem finish, dump process init finish. deviceId[%u]", deviceId_);
        LoopProcessEvent();
        aicpusd_run_info("dump thread stopped");
    }
    void AicpuCustDumpProcess::LoopProcessEvent()
    {
        while (runningFlag_) {
            ProcessMessage(DATA_DUMP_TIMEOUT_INTERVAL);
        }
    }

    int32_t AicpuCustDumpProcess::InitWaitConVec(const uint32_t workCnt)
    {
        waitCondVec_.resize(workCnt);
        for (size_t index = 0; index < waitCondVec_.size(); index++) {
            waitCondVec_[index].streamId = 0U;
            waitCondVec_[index].taskId = 0U;
            if (sem_init(&(waitCondVec_[index].waitFlag), 0, 0U) != 0) {
                waitCondVec_.clear();
                aicpusd_err("sem init failed %s", strerror(errno));
                return AICPU_SCHEDULE_ERROR_INNER_ERROR;
            }
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustDumpProcess::ProcessDumpMessage(const event_info &drvEventInfo)
    {
        if (static_cast<size_t>(drvEventInfo.priv.msg_len) != sizeof(AICPUDumpCustInfo)) {
            aicpusd_err("The len[%u] is not correct[%zu].",
                drvEventInfo.priv.msg_len, sizeof(AICPUDumpCustInfo));
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        const AICPUDumpCustInfo * const info = PtrToPtr<const char_t, const AICPUDumpCustInfo>(drvEventInfo.priv.msg);
        // find process function of the subevent id.
        const AICPUCustSubEvent drvEventId = static_cast<AICPUCustSubEvent>(drvEventInfo.comm.subevent_id);
        if (drvEventId != AICPU_SUB_EVENT_REPORT_CUST_DUMPDATA) {
            aicpusd_err("invalid subevent %u", static_cast<uint32_t>(drvEventId));
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        uint32_t threadIndex = info->threadIndex;
        uint32_t streamId = info->streamId;
        uint32_t taskId = info->taskId;
        aicpusd_info("Begin dump info, threadindex:%u, streamid:%u, taskid:%u.", threadIndex, streamId, taskId);
        if (waitCondVec_.size() > threadIndex) {
            if ((waitCondVec_[threadIndex].streamId == streamId) && (waitCondVec_[threadIndex].taskId == taskId)) {
                waitCondVec_[threadIndex].dumpRet = info->retCode;
                if (sem_post(&(waitCondVec_[threadIndex].waitFlag)) != 0) {
                    aicpusd_err("sem post threadindex:%u failed, error:%s", threadIndex, strerror(errno));
                    return AICPU_SCHEDULE_ERROR_INNER_ERROR;
                } else {
                    aicpusd_info("active threadIndex:%u, streamId:%u, taskId:%u", threadIndex, streamId, taskId);
                    return AICPU_SCHEDULE_OK;
                }
            } else {
                aicpusd_err("threadinex:%u, basestreamid:%u, basetaskid:%u, infostreamId:%u, infotaskId:%u",
                            threadIndex, waitCondVec_[threadIndex].streamId, waitCondVec_[threadIndex].taskId,
                            streamId, taskId);
                return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
            }
        } else {
            aicpusd_err("invalid thread index:%u", threadIndex);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    int32_t AicpuCustDumpProcess::ProcessPlatformInfoMessage(const event_info &drvEventInfo) const
    {
        return CustProcessLoadPlatform(&drvEventInfo);
    }
    int32_t AicpuCustDumpProcess::ActiveTheBlockThread(const event_info &drvEventInfo)
    {
        const AICPUCustSubEvent drvEventId = static_cast<AICPUCustSubEvent>(drvEventInfo.comm.subevent_id);
        if (drvEventId == AICPU_SUB_EVENT_REPORT_CUST_DUMPDATA) {
            return ProcessDumpMessage(drvEventInfo);
        }
        if (drvEventId == AICPU_SUB_EVENT_CUST_LOAD_PLATFORM) {
            return ProcessPlatformInfoMessage(drvEventInfo);
        }
        aicpusd_err("invalid Subevent Id [%u]", static_cast<uint32_t>(drvEventId));
        return AICPU_SCHEDULE_OK;
    }
    int32_t AicpuCustDumpProcess::ProcessMessage(const int32_t timeout)
    {
        event_info drvEventInfo;
        const int32_t retVal = halEschedWaitEvent(deviceId_, DATA_DUMP_GRUOP_ID, DATA_DUMP_THREAD_INDEX,
                                                  timeout, &drvEventInfo);
        if (retVal == DRV_ERROR_NONE) {
            (void) ActiveTheBlockThread(drvEventInfo);
        } else if ((retVal == DRV_ERROR_SCHED_WAIT_TIMEOUT) || (retVal == DRV_ERROR_NO_EVENT)) {
            // if timeout, will continue wait event.
        } else if ((retVal == DRV_ERROR_SCHED_PROCESS_EXIT) || (retVal == DRV_ERROR_SCHED_PARA_ERR)) {
            if (runningFlag_) {
                runningFlag_ = false;
            }
            aicpusd_warn("Failed to get event, error code=%d, deviceId[%u], groupId[%u], threadIndex[%u]",
                         retVal, deviceId_, DATA_DUMP_GRUOP_ID, DATA_DUMP_THREAD_INDEX);
        } else if (retVal == DRV_ERROR_SCHED_RUN_IN_ILLEGAL_CPU) {
            runningFlag_ = false;
            aicpusd_err("Cpu Illegal get event, error code[%d], deviceId[%u], groupId[%u], threadIndex[%u]",
                        retVal, deviceId_, DATA_DUMP_GRUOP_ID, DATA_DUMP_THREAD_INDEX);
        } else {
            // record a error code
            aicpusd_err("Failed to get event, error code[%d], deviceId[%u], groupId[%u], threadIndex[%u]",
                        retVal, deviceId_, DATA_DUMP_GRUOP_ID, DATA_DUMP_THREAD_INDEX);
        }
        return retVal;
    }

    int32_t AicpuCustDumpProcess::GetDataDumpRetCode(const uint32_t threadIndex)
    {
        int32_t retCode = waitCondVec_[threadIndex].dumpRet;
        waitCondVec_[threadIndex].dumpRet = -1;
        aicpusd_info("dump task finish retcode:%d, streamid:%u, taskId:%u, threadIndex:%u",
                     retCode, waitCondVec_[threadIndex].streamId, waitCondVec_[threadIndex].taskId, threadIndex);
        return retCode;
    }

    void AicpuCustDumpProcess::UnitDataDumpProcess()
    {
        aicpusd_info("UnitDataDumpProcess start");
        const std::lock_guard<std::mutex> lk(initMutex_);
        if (!initFlag_) {
            aicpusd_info("already uninit no need uninit");
            return;
        }
        initFlag_ = false;
        for (size_t index = 0; index < waitCondVec_.size(); index++) {
            sem_post(&(waitCondVec_[index].waitFlag));
        }
        runningFlag_=false;
        aicpusd_info("sem post finish");
        if (msgThread_.joinable()) {
            msgThread_.join();
        }
        aicpusd_info("UnitDataDumpProcess finish");
    }

    int32_t AicpuCustDumpProcess::SendDumpMessageToAicpuSd(char_t *msg, const uint32_t msgLen) const
    {
        pid_t aicpuPid = AicpuScheduleInterface::GetInstance().GetAicpuSdProcId();
        event_summary drvEvent = {};
        drvEvent.dst_engine = CCPU_DEVICE;
        drvEvent.policy = ONLY;
        drvEvent.pid = aicpuPid;
        drvEvent.grp_id = DATA_DUMP_GRUOP_ID;
        drvEvent.event_id = EVENT_CCPU_CTRL_MSG;
        drvEvent.subevent_id = static_cast<uint32_t>(AICPU_SUB_EVENT_REPORT_CUST_DUMPDATA);
        drvEvent.msg_len = msgLen;
        drvEvent.msg = msg;
        const int32_t ret = halEschedSubmitEvent(deviceId_, &drvEvent);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("halEschedSubmitEvent failed, ret:%d, devid:%u", ret, deviceId_);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        aicpusd_info("send dump msg success");
        return AICPU_SCHEDULE_OK;
    }

    int32_t AicpuCustDumpProcess::BeginDatadumpTask(const uint32_t threadIndex, const uint32_t streamId,
                                                    const uint32_t taskId)
    {
        if (threadIndex >= waitCondVec_.size()) {
            aicpusd_err("invalid threadindex:%u", threadIndex);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }
        waitCondVec_[threadIndex].streamId = streamId;
        waitCondVec_[threadIndex].taskId = taskId;
        AICPUDumpCustInfo subEventInfo = { };
        subEventInfo.retCode = -1;
        subEventInfo.streamId = streamId;
        subEventInfo.taskId = taskId;
        subEventInfo.threadIndex = threadIndex;
        if (SendDumpMessageToAicpuSd(PtrToPtr<AICPUDumpCustInfo, char_t>(&subEventInfo),
                                     static_cast<uint32_t>(sizeof(AICPUDumpCustInfo))) != AICPU_SCHEDULE_OK) {
            aicpusd_err("send msg failed streamid:%u, taskId:%u, threadIndex:%u", streamId, taskId, threadIndex);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        aicpusd_info("dump task begin success streamid:%u, taskId:%u, threadIndex:%u", streamId, taskId, threadIndex);
        if (sem_wait(&(waitCondVec_[threadIndex].waitFlag)) == -1) {
            aicpusd_err("try to wait by loop threadindex:%u", threadIndex);
            return AICPU_SCHEDULE_ERROR_DUMP_TASK_WAIT_ERROR;
        }
        const int32_t dumpRet = GetDataDumpRetCode(threadIndex);
        aicpusd_info("dump task finish streamid:%u, taskId:%u, threadIndex:%u, dumpRet:%d",
                     streamId, taskId, threadIndex, dumpRet);
        return dumpRet;
    }
}