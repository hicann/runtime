/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_worker.h"

#include <csignal>
#include <cstring>
#include <cerrno>
#include <sys/wait.h>
#include <algorithm>

#include "tsd.h"
#include "aicpusd_status.h"
#include "aicpusd_util.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_monitor.h"
#include "aicpusd_event_manager.h"
#include "aicpusd_context.h"
#include "aicpu_context.h"
#include "ProcMgrSysOperatorAgent.h"
#include "aicpusd_hal_interface_ref.h"
#include "aicpusd_so_manager.h"
#include "aicpu_pulse.h"
#include "aicpusd_feature_ctrl.h"
#include "aicpusd_message_queue.h"

namespace {
    // user event id starts from EVENT_USR_START(48) to EVENT_USR_END(63), we should make sure that eventIds in
    // one process should not conflict, considering the first 3 user_event_id has been used by qs, so here we start by
    // offset 8
    constexpr uint64_t EVENT_PROXY_MSG = static_cast<uint64_t>(EVENT_ID::EVENT_USR_START) + 8U;

    constexpr uint64_t CP_EVENT_MASK =
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_RANDOM_KERNEL)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_DVPP_MSG)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_FR_MSG)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_TS_HWTS_KERNEL)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_TS_HWTS_KERNEL)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_AICPU_MSG)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_TS_CTRL_MSG)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_QUEUE_EMPTY_TO_NOT_EMPTY)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_QUEUE_FULL_TO_NOT_FULL)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_TDT_ENQUEUE)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_ACPU_MSG_TYPE1)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_DVPP_MPI_MSG)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_SPLIT_KERNEL)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_CDQ_MSG)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_QUEUE_ENQUEUE)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_QS_MSG)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_DRV_MSG)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << static_cast<uint64_t>(EVENT_FFTS_PLUS_MSG)) |
        static_cast<uint64_t>(static_cast<uint64_t>(1U) << EVENT_PROXY_MSG);
    constexpr const uint32_t SLEEP_USECS = 50000U;
}

namespace AicpuSchedule {
    ThreadPool &ThreadPool::Instance()
    {
        static ThreadPool threadPoolInstance;
        return threadPoolInstance;
    }

    ThreadPool::ThreadPool() : semInitedNum_(0UL)
    {
        aicpusd_run_info("ThreadPool");
    }

    ThreadPool::~ThreadPool()
    {
        ClearPulseNotifyFunc();
        Clear();
    }

    void ThreadPool::Clear()
    {
        AicpuSchedule::AicpuEventManager::GetInstance().SetRunningFlag(false);
        WaitForStop();
        for (auto &sem : sems_) {
            (void)sem_destroy(&sem);
        }
        semInitedNum_ = 0UL;
        threadStatusList_.clear();
        threadIdLists_.clear();
    }

    int32_t ThreadPool::CreateWorker(const AicpuSchedMode schedMode)
    {
        Clear();
        AicpuSchedule::AicpuEventManager::GetInstance().SetRunningFlag(true);
        schedMode_ = schedMode;
        size_t aicpuNum = AicpuDrvManager::GetInstance().GetAicpuNum();
        const std::vector<uint32_t> deviceVec = AicpuDrvManager::GetInstance().GetDeviceList();
        if (aicpuNum == 0UL) {
            aicpusd_run_info("aicpu total num=[0], create a aicpu worker");
            aicpuNum = 1UL;
            hasAicpu_ = false;
        }
        sems_ = std::vector<sem_t>(static_cast<size_t>(aicpuNum));
        for (size_t i = 0UL; i < aicpuNum; ++i) {
            const int32_t semInitRet = sem_init(&(sems_[i]), 0, 0U);
            if (semInitRet == -1) {
                aicpusd_err("sem[%zu] init failed, %s", i, strerror(errno));
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
            semInitedNum_ = i + 1UL;
        }
        threadStatusList_ = std::vector<ThreadStatus>(static_cast<size_t>(aicpuNum), ThreadStatus::THREAD_INIT);
        threadIdLists_ = std::vector<pid_t>(static_cast<size_t>(aicpuNum), 0);

        sighandler_t const oldHandler = signal(SIGCHLD, SIG_DFL);
        aicpusd_info("set SIGCHLD to %d, old sighandler[%d], errno[%d]", SIG_DFL, oldHandler, errno);

        const size_t aicpuNumPerDev = hasAicpu_ ? AicpuDrvManager::GetInstance().GetAicpuNumPerDevice() : 1UL;
        if (aicpuNumPerDev == 0) {
            aicpusd_err("aicpu Number error, %lu", aicpuNumPerDev);
            (void)signal(SIGCHLD, oldHandler);
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }

        int32_t ret = AICPU_SCHEDULE_OK;
        for (size_t i = 0UL; i < aicpuNum; ++i) {
            // aicpuNumPerDev is not 0
            const size_t deviceVecInx = i / aicpuNumPerDev;
            ret = CreateOneWorker(i, deviceVec[deviceVecInx]);
            if (ret != AICPU_SCHEDULE_OK) {
                (void)signal(SIGCHLD, oldHandler);
                return ret;
            }
        }

        for (size_t i = 0UL; i < aicpuNum; i++) {
            const int32_t semWaitRet = sem_wait(&(sems_[i]));
            if (semWaitRet == -1) {
                (void)signal(SIGCHLD, oldHandler);
                aicpusd_err("sem[%zu] wait failed, %s", i, strerror(errno));
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
            if (threadStatusList_[i] != ThreadStatus::THREAD_RUNNING) {
                (void)signal(SIGCHLD, oldHandler);
                aicpusd_err("create thread[%zu] failed", i);
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
        }
        aicpusd_info("set SIGCHLD to old sighandler[%d]", oldHandler);
        (void)signal(SIGCHLD, oldHandler);

        ret = AicpuSchedule::AicpuMonitor::GetInstance().Run();
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("aicpu monitor run failed, ret[%d]", ret);
            return ret;
        }

        return AICPU_SCHEDULE_OK;
    }

    int32_t ThreadPool::CreateOneWorker(const size_t threadIndex,
                                        const uint32_t deviceId)
    {
        try {
            aicpusd_info("CreateOneWorker device[%u]:thread[%zu] started.", deviceId, threadIndex);
            std::thread th(&ThreadPool::Work, threadIndex, deviceId, schedMode_);
            workers_.emplace_back(std::move(th));
        } catch (std::exception &threadException) {
            aicpusd_err("create aicpu worker[%zu] failed, %s", threadIndex, threadException.what());
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }

        return AICPU_SCHEDULE_OK;
    }

    void ThreadPool::WaitForStop()
    {
        aicpusd_run_info("Wait for stop begin.");
        for (auto &worker : workers_) {
            if (worker.joinable()) {
                worker.join();
            }
        }
        workers_.clear();
        aicpusd_run_info("Wait for stop end.");
    }

    void ThreadPool::Work(const size_t threadIndex, const uint32_t deviceId, const AicpuSchedMode schedMode)
    {
        aicpusd_info("Aicpu device[%u]:thread[%zu] started.", deviceId, threadIndex);
        aicpu::aicpuContext_t context;
        context.tsId = 0U;
        context.hostPid = AicpuDrvManager::GetInstance().GetHostPid();
        context.vfId = AicpuDrvManager::GetInstance().GetVfId();
        context.deviceId = deviceId;
        aicpu::SetUniqueVfId(AicpuDrvManager::GetInstance().GetUniqueVfId());
        if (aicpu::aicpuSetContext(&context) != aicpu::AICPU_ERROR_NONE) {
            aicpusd_err("Set aicpu context failed, deviceId[%u], thread[%zu].", deviceId, threadIndex);
            AicpuSchedule::ThreadPool::Instance().PostSem(threadIndex);
            return;
        }

        DeployContext deployCtx = DeployContext::DEVICE;
        const StatusCode ctxRet = GetAicpuDeployContext(deployCtx);
        if (ctxRet != AICPU_SCHEDULE_OK) {
            aicpusd_err("Get current deploy ctx failed.");
            return;
        }

        if ((deployCtx == DeployContext::DEVICE) || (deployCtx == DeployContext::HOSTCPU)) {
            if (AicpuSchedule::ThreadPool::Instance().SetAffinity(threadIndex, deviceId) != AICPU_SCHEDULE_OK) {
                AicpuSchedule::ThreadPool::Instance().PostSem(threadIndex);
                return;
            }
        } else {
            AicpuSchedule::ThreadPool::Instance().SetThreadStatus(threadIndex, ThreadStatus::THREAD_RUNNING);
        }
        AicpuSchedule::ThreadPool::Instance().SetThreadIdRelation(threadIndex, static_cast<pid_t>(GetTid()));

        const int32_t ret = (schedMode == SCHED_MODE_MSGQ) ? InitMessageQueueWorker(threadIndex) :
                                                             InitInterruptWorker(deviceId, threadIndex);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Init work for sched mode failed, mode=%u", schedMode);
            AicpuSchedule::ThreadPool::Instance().PostSem(threadIndex);
            return;
        }

        (void)aicpu::SetAicpuThreadIndex(static_cast<uint32_t>(threadIndex));
        // virtual device：给dvpp传递deviceId
        if (FeatureCtrl::IsVfModeCheckedByDeviceId(deviceId)) {
            AicpuSoManager::GetInstance().SetDeviceIdToDvpp(deviceId);
        }

        // should not add any process between PostSem and LoopProcess
        AicpuSchedule::ThreadPool::Instance().PostSem(threadIndex);
        AicpuSchedule::AicpuEventManager::GetInstance().LoopProcess(static_cast<uint32_t>(threadIndex));

        aicpusd_info("Aicpu device[%u]:thread[%u] stopped.", deviceId, threadIndex);
    }

    int32_t ThreadPool::InitInterruptWorker(const uint32_t deviceId, const size_t threadIndex)
    {
        const int32_t ret = halEschedSubscribeEvent(deviceId, CP_DEFAULT_GROUP_ID,
                                                    static_cast<uint32_t>(threadIndex), CP_EVENT_MASK);
        if (ret != DRV_ERROR_NONE) {
            aicpusd_err("Subscribe event failed, deviceId[%u], groupId[%u], threadIndex[%zu] "
                        "eventBitmap[%llu].", deviceId, CP_DEFAULT_GROUP_ID, threadIndex, CP_EVENT_MASK);
            return ret;
        }

        aicpusd_info("halEschedSubscribeEvent success, deviceId[%u], groupId[%u], threadIndex[%zu] eventBitmap[%llu].",
                     deviceId, CP_DEFAULT_GROUP_ID, threadIndex, CP_EVENT_MASK);

        /**
         * In some multi-thread scenarios, the queue for esched may not be created before the RTS delivers
         * the AICPU task. As a result, the abnormal status will be send to RTS. Therefore, need to invoke
         * the halEschedWaitEvent in advance to create a waiting queue for esched.
         */
        (void)AicpuSchedule::AicpuEventManager::GetInstance().DoOnce(static_cast<uint32_t>(threadIndex), deviceId, 0);

        return AICPU_SCHEDULE_OK;
    }

    int32_t ThreadPool::InitMessageQueueWorker(const size_t threadIndex)
    {
        return MessageQueue::GetInstance().InitMessageQueueForThread(threadIndex);
    }

    int32_t ThreadPool::WriteTidForAffinity(const size_t threadIndex)
    {
        if (threadIndex >= threadStatusList_.size()) {
            aicpusd_err("threadIndex[%zu], out of rank[0, %zu]",
                threadIndex, threadStatusList_.size());
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }

        std::string command = "sudo /var/add_aicpu_tid_to_tasks.sh";
        std::string pathStr = "/var/add_aicpu_tid_to_tasks.sh";
        if (access(pathStr.c_str(), F_OK) != 0) {
            aicpusd_info("Not find add_aicpu_tid_to_tasks.sh.");
            return AICPU_SCHEDULE_OK;
        }
        command = command + " " + std::to_string(GetTid());

        // 使用system命令会对父进程进行拷贝，浪费了系统资源。在esl等环境中还会存在由于资源较少无法fork导致system卡住的问题.
        // 使用vfork替换system命令，由于与父进程共享资源，因此可解决资源浪费/卡住的问题.
        const int32_t ret = AicpuUtil::ExecuteCmd(command);
        if (ret != 0) {
            threadStatusList_[threadIndex] = ThreadStatus::THREAD_EXIT;
            aicpusd_err("write tid[%llu] to /sys/fs/cgroup/cpuset/AICPU/tasks failed, ret[%d], strerror[%s]",
                GetTid(), ret, strerror(errno));
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }

        return AICPU_SCHEDULE_OK;
    }

    int32_t ThreadPool::AddPidToTask(const size_t threadIndex)
    {
        DeployContext deployCtx = DeployContext::DEVICE;
        (void)GetAicpuDeployContext(deployCtx);
        if (deployCtx == DeployContext::HOSTCPU) {
            return AICPU_SCHEDULE_OK;
        }

        if (FeatureCtrl::IsBindPidByHal()) {
            if (&halBindCgroup != nullptr) {
               aicpusd_info("Bind pid by hal index:%zu.", threadIndex);
                const drvError_t drvRet = halBindCgroup(BIND_AICPU_CGROUP);
                if (drvRet != DRV_ERROR_NONE) {
                    aicpusd_err("halBindCgroup failed, ret[%d]", drvRet);
                    return AICPU_SCHEDULE_ERROR_FROM_DRV;
                }
                aicpusd_info("halBindCgroup success");
            }
        } else {
            aicpusd_run_info("AddPidToTask by WriteTidForAffinity");
            const auto ret = WriteTidForAffinity(threadIndex);
            if (ret != static_cast<int32_t>(AICPU_SCHEDULE_OK)) {
                aicpusd_err("WriteTidForAffinity failed, ret[%d]", ret);
                return static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INIT_FAILED);
            }
            aicpusd_info("WriteTidForAffinity success");
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t ThreadPool::SetAffinityBySelf(const size_t threadIndex, const uint32_t deviceId)
    {
        if (hasAicpu_ && (AddPidToTask(threadIndex) != AICPU_SCHEDULE_OK)) {
            aicpusd_err("AddPidToTask failed");
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        cpu_set_t mask;
        CPU_ZERO(&mask);
        const uint32_t aicpuLogIndex = hasAicpu_?
            static_cast<uint32_t>(threadIndex) % AicpuDrvManager::GetInstance().GetAicpuNumPerDevice(): 0U;

        uint32_t physIndex = 0;
        uint32_t devNum = 0U;
        if ((FeatureCtrl::IsVfModeCheckedByDeviceId(deviceId)) && (&halGetVdevNum != nullptr)) {
            const int32_t result = halGetVdevNum(&devNum);
            if (result != 0) {
                aicpusd_err("halGetVdevNum, failed result[%d]", result);
                return AICPU_SCHEDULE_ERROR_FROM_DRV;
            }
        }
        if (!hasAicpu_) {
            physIndex = AicpuDrvManager::GetInstance().GetCcpuPhysIndex(aicpuLogIndex, deviceId);
        } else if (devNum > 0U) {
            physIndex = AicpuDrvManager::GetInstance().GetAicpuPhysIndexInVfMode(aicpuLogIndex, deviceId);
        } else {
            physIndex = AicpuDrvManager::GetInstance().GetAicpuPhysIndex(aicpuLogIndex, deviceId);
        }
        aicpusd_info("[hw]SetAffinityBySelf, physIndex[%u], devNum[%u]", physIndex, devNum);
        if (physIndex == INVALID_AICPU_ID) {
            threadStatusList_[threadIndex] = ThreadStatus::THREAD_RUNNING;
            return static_cast<int32_t>(AICPU_SCHEDULE_OK);
        }
        // cannot overflow, aicpu num < 65535, max [64=4*16]
        CPU_SET(static_cast<int32_t>(physIndex), &mask);
        const int32_t ret = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &mask);
        if (ret != 0) {
            threadStatusList_[threadIndex] = ThreadStatus::THREAD_EXIT;
            aicpusd_err("set affinity failed ret[%d], aicpu logical index[%zu], aicpu physical index[%u], "
                "device id[%u]", ret, threadIndex, physIndex, deviceId);
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        threadStatusList_[threadIndex] = ThreadStatus::THREAD_RUNNING;
        aicpusd_info("set affinity success, aicpu logical index[%zu], aicpu physical index[%u], device id[%u]",
            threadIndex, physIndex, deviceId);
        return AICPU_SCHEDULE_OK;
    }

    int32_t ThreadPool::SetAffinityByPm(const size_t threadIndex, const uint32_t deviceId)
    {
        const uint32_t aicpuLogIndex = hasAicpu_?
            static_cast<uint32_t>(threadIndex) % AicpuDrvManager::GetInstance().GetAicpuNumPerDevice(): 0U;
        uint32_t physIndex;
        if (FeatureCtrl::IsVfModeCheckedByDeviceId(deviceId)) {
            physIndex = AicpuDrvManager::GetInstance().GetAicpuPhysIndex(aicpuLogIndex,
                                                                         (deviceId - VDEVICE_MIN_CPU_NUM));
        } else {
            physIndex = hasAicpu_?
                        AicpuDrvManager::GetInstance().GetAicpuPhysIndex(aicpuLogIndex, deviceId):
                        AicpuDrvManager::GetInstance().GetCcpuPhysIndex(aicpuLogIndex, deviceId);
        }
        const pid_t tid = static_cast<pid_t>(GetTid());

        std::vector<uint32_t> coreAffinity;
        coreAffinity.push_back(physIndex);
        aicpusd_info("begin to ProcMgrBindThread, tid:%d, physIndex:%u, hasAicpu_:%d", tid, physIndex, hasAicpu_);
        auto ret = ProcMgrBindThread(tid, coreAffinity);
        aicpusd_info("end to ProcMgrBindThread, ret:%d", ret);
        uint32_t tryTimes = 0;
        while ((ret != 0U) && (tryTimes <= 1)) {
            aicpusd_warn("set affinity failed ret[%d], will try again", ret);
            (void)usleep(SLEEP_USECS);
            ret = ProcMgrBindThread(tid, coreAffinity);
            tryTimes++;
        }
        if (ret != 0U) {
            threadStatusList_[threadIndex] = ThreadStatus::THREAD_EXIT;
            aicpusd_err("set affinity failed ret[%d], aicpu logical index[%zu], "
                        "aicpu physical index[%u],tid[%u], device id[%u]",
                        ret, threadIndex, physIndex, tid, AicpuDrvManager::GetInstance().GetDeviceId());
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        threadStatusList_[threadIndex] = ThreadStatus::THREAD_RUNNING;
        aicpusd_info("set affinity success, aicpu logical index[%zu], aicpu physical index[%u], device id[%u]",
            threadIndex, physIndex, AicpuDrvManager::GetInstance().GetDeviceId());
        return AICPU_SCHEDULE_OK;
    }

    int32_t ThreadPool::SetAffinity(const size_t threadIndex, const uint32_t deviceId)
    {
        int32_t res = static_cast<int32_t>(AICPU_SCHEDULE_OK);
        if (AicpuUtil::IsEnvValEqual(ENV_NAME_PROCMGR_AICPU_CPUSET, "1")) {
            res = SetAffinityByPm(threadIndex, deviceId);
            aicpusd_run_info("aicpu bind tid by pm, index[%zu], deviceId[%u], res[%d].", threadIndex, deviceId, res);
        } else {
            res = SetAffinityBySelf(threadIndex, deviceId);
            aicpusd_info("aicpu bind tid by self, index[%zu], deviceId[%u], res[%d].", threadIndex, deviceId, res);
        }
        return res;
    }

    void ThreadPool::SetThreadStatus(const size_t threadIndex, const ThreadStatus threadStat)
    {
        threadStatusList_[threadIndex] = threadStat;
    }

    void ThreadPool::PostSem(const size_t threadIndex)
    {
        (void)sem_post(&(sems_[threadIndex]));
    }

    void ThreadPool::SetThreadIdRelation(const size_t threadIndex, const pid_t threadId)
    {
        threadIdLists_[threadIndex] = threadId;
        aicpusd_info("set thread index:%zu and tid:%d relation to List", threadIndex,
                      static_cast<int32_t>(threadIdLists_[threadIndex]));
    }

    void ThreadPool::SetThreadSchedModeByTsd()
    {
        const size_t relationSize = threadIdLists_.size();
        if (relationSize > MAX_THREAD_ID_CNT) {
            aicpusd_err("current list to long size:%zu", relationSize);
            return;
        }
        SubProcScheduleModeInfo curInfo = {};
        curInfo.totalNum = static_cast<uint32_t>(relationSize);
        (void)std::copy(threadIdLists_.begin(), threadIdLists_.end(), curInfo.threadIdList);
        const std::vector<uint32_t> deviceVec = AicpuDrvManager::GetInstance().GetDeviceList();
        if (deviceVec.empty()) {
            aicpusd_err("the device vector is empty");
            return;
        }
        if (SetSubProcScheduleMode(deviceVec[0],
                                   static_cast<uint32_t>(TsdWaitType::TSD_COMPUTE),
                                   static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid()),
                                   AicpuDrvManager::GetInstance().GetVfId(), &curInfo) != 0) {
            aicpusd_err("send msg to tsd failed");
            return;
        }
    }
}  // namespace AicpuSchedule
