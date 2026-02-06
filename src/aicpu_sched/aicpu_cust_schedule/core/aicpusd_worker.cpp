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
#include <fstream>

#include "aicpusd_status.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_monitor.h"
#include "aicpusd_event_manager.h"
#include "aicpu_context.h"
#include "aicpusd_common.h"
#include "ProcMgrSysOperatorAgent.h"
#include "aicpusd_hal_interface_ref.h"
#include "aicpusd_util.h"
#include "feature_ctrl.h"
#ifndef _AOSCORE_
#include "seccomp.h"
#endif

namespace {
    constexpr uint32_t EVENT_MASK =
        (static_cast<uint32_t>(1U) << static_cast<uint32_t>(EVENT_RANDOM_KERNEL)) |
        (static_cast<uint32_t>(1U) << static_cast<uint32_t>(EVENT_TS_HWTS_KERNEL)) |
        (static_cast<uint32_t>(1U) << static_cast<uint32_t>(EVENT_AICPU_MSG)) |
        (static_cast<uint32_t>(1U) << static_cast<uint32_t>(EVENT_TS_CTRL_MSG)) |
        (static_cast<uint32_t>(1U) << static_cast<uint32_t>(EVENT_SPLIT_KERNEL)) |
        (static_cast<uint32_t>(1U) << static_cast<uint32_t>(EVENT_FFTS_PLUS_MSG));
    constexpr const char_t *SYSCALL_WHITE_LIST = "/var/aicpu_custom_syscall_whitelist";
}

namespace AicpuSchedule {
    ThreadPool &ThreadPool::Instance()
    {
        static ThreadPool threadPool;
        return threadPool;
    }

    ThreadPool::ThreadPool()
        : semInitedNum_(0U) {}

    ThreadPool::~ThreadPool()
    {
        for (size_t i = 0UL; i < semInitedNum_; ++i) {
            (void)sem_destroy(&(sems_[i]));
        }
    }

    int32_t ThreadPool::CreateWorker()
    {
        const uint32_t aicpuNum = AicpuDrvManager::GetInstance().GetAicpuNum();
        if (aicpuNum == 0U) {
            aicpusd_run_info("aicpu num[0], not need create aicpu worker");
        } else {
            try {
                sems_ = std::move(std::vector<sem_t>(static_cast<size_t>(aicpuNum)));
            } catch (std::exception &e) {
                aicpusd_err("create sems failed, %s", e.what());
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
            for (uint32_t threadIndex = 0U; threadIndex < aicpuNum; ++threadIndex) {
                const int32_t semInitRet = sem_init(&(sems_[static_cast<size_t>(threadIndex)]), 0, 0U);
                if (semInitRet == -1) {
                    aicpusd_err("sem[%u] init failed, %s", threadIndex, strerror(errno));
                    return AICPU_SCHEDULE_ERROR_INIT_FAILED;
                }
                semInitedNum_ = threadIndex + 1U;
            }
            try {
                threadStatus_ = std::move(std::vector<ThreadStatus>(static_cast<size_t>(aicpuNum),
                                        ThreadStatus::THREAD_INIT));
            } catch (std::exception &e) {
                aicpusd_err("create ThreadStatus failed, %s", e.what());
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
            int32_t ret = AICPU_SCHEDULE_OK;
            const sighandler_t oldHandler = signal(SIGCHLD, SIG_DFL);
            aicpusd_info("Set SIGCHLD to %d, old sighandler[%d]", SIG_DFL, oldHandler);
            GetExpandedSysCalls(SYSCALL_WHITE_LIST);
            for (uint32_t threadIndex = 0U; threadIndex < aicpuNum; ++threadIndex) {
                ret = CreateOneWorker(threadIndex);
                if (ret != AICPU_SCHEDULE_OK) {
                    (void)signal(SIGCHLD, oldHandler);
                    return ret;
                }
            }
            for (size_t threadIndex = 0UL; threadIndex < static_cast<size_t>(aicpuNum); threadIndex++) {
                const int32_t semWaitRet = sem_wait(&(sems_[threadIndex]));
                if (semWaitRet == -1) {
                    (void)signal(SIGCHLD, oldHandler);
                    aicpusd_err("sem[%zu] wait failed, %s", threadIndex, strerror(errno));
                    return AICPU_SCHEDULE_ERROR_INIT_FAILED;
                }
                if (threadStatus_[threadIndex] != ThreadStatus::THREAD_RUNNING) {
                    (void)signal(SIGCHLD, oldHandler);
                    aicpusd_err("create thread[%zu] failed, status[%d]", threadIndex, threadStatus_[threadIndex]);
                    return AICPU_SCHEDULE_ERROR_INIT_FAILED;
                }
            }
            aicpusd_info("set SIGCHLD to old sighandler[%d]", oldHandler);
            (void)signal(SIGCHLD, oldHandler);
        }
        // GetInstance is not null, checked in InitAICPUScheduler
        auto ret = AicpuSchedule::AicpuMonitor::GetInstance().Run();
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("aicpu monitor run failed, ret[%d]", ret);
            return ret;
        }

        return AICPU_SCHEDULE_OK;
    }

    int32_t ThreadPool::CreateOneWorker(const uint32_t threadIndex)
    {
        aicpusd_info("CreateOneWorker index[%d]", threadIndex);
        try {
            std::thread th(&ThreadPool::Work, threadIndex);
            workers_.emplace_back(std::move(th));
        } catch (std::exception &e) {
            aicpusd_err("create aicpu worker[%u] failed, %s", threadIndex, e.what());
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        try {
            workers_[static_cast<size_t>(threadIndex)].detach();
        } catch (std::exception &e) {
            aicpusd_err("thread[%u] detach failed, %s", threadIndex, e.what());
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }

        return AICPU_SCHEDULE_OK;
    }

    void ThreadPool::GetExpandedSysCalls(const char_t * const whitelist)
    {
        std::ifstream inFile(whitelist);
        if ((access(whitelist, R_OK) != 0) || !inFile) {
            aicpusd_info("syscall file: %s is invalid", whitelist);
            return;
        }
        const ScopeGuard fileGuard([&inFile] () { inFile.close(); });

        std::string syscallStr;
        while (getline(inFile, syscallStr)) {
            aicpusd_info("read syscall: %s", syscallStr.c_str());
            const int32_t syscallNo = seccomp_syscall_resolve_name(syscallStr.c_str());
            if (syscallNo < 0) {
                aicpusd_run_warn("Unknown syscall: %s, ret is %d.", syscallStr.c_str(), syscallNo);
                continue;
            }
            aicpusd_info("syscall: %s, syscallNo: %d", syscallStr.c_str(), syscallNo);
            (void) expandedSystemCalls_.insert(syscallNo);
        }
    }

    void ThreadPool::ExpandSysCallList(std::unordered_set<int32_t> &filterSystemCalls) {
        for (const auto expandedSystemCall : expandedSystemCalls_) {
            const auto insertRet = filterSystemCalls.insert(expandedSystemCall);
            if (insertRet.second) {
                aicpusd_run_info("Expand syscallNo: %d.", expandedSystemCall);
            }
        }
    }

    int32_t ThreadPool::SecureCompute(const uint32_t threadIndex)
    {
        if ((FeatureCtrl::IsAosCore() || (!AicpuSchedule::AicpuDrvManager::GetInstance().GetSafeVerifyFlag()))) {
            threadStatus_[static_cast<size_t>(threadIndex)] = ThreadStatus::THREAD_RUNNING;
            aicpusd_info("Execute seccomp_load success.");
            return AICPU_SCHEDULE_OK;
        }
        std::unordered_set<int32_t> filterSystemCalls = {
            SCMP_SYS(open),
            SCMP_SYS(close),
            SCMP_SYS(faccessat),
            SCMP_SYS(fstat),
            SCMP_SYS(futex),
            SCMP_SYS(getpid),
            SCMP_SYS(gettid),
            SCMP_SYS(ioctl),
            SCMP_SYS(lseek),
            SCMP_SYS(nanosleep),
            SCMP_SYS(openat),
            SCMP_SYS(newfstatat),
            SCMP_SYS(pselect6),
            SCMP_SYS(read),
            SCMP_SYS(readlinkat),
            SCMP_SYS(rt_sigaction),
            SCMP_SYS(mmap),
            SCMP_SYS(mprotect),
            SCMP_SYS(exit),
            SCMP_SYS(exit_group),
            SCMP_SYS(madvise),
            SCMP_SYS(sched_getaffinity),
            SCMP_SYS(rt_sigprocmask),
            SCMP_SYS(set_robust_list),
            SCMP_SYS(munmap),
            SCMP_SYS(sysinfo),
            SCMP_SYS(clock_nanosleep),
            SCMP_SYS(uname),
            SCMP_SYS(getcpu),
            SCMP_SYS(write),
            SCMP_SYS(getrandom)
        };
        ExpandSysCallList(filterSystemCalls);

        // filter enable system calls
        const scmp_filter_ctx ctx = seccomp_init(SCMP_ACT_ERRNO(1U));
        int32_t ret = 0;
        for (auto filterSystemCall : filterSystemCalls) {
            ret = seccomp_rule_add(ctx, SCMP_ACT_ALLOW, filterSystemCall, 0U);
            if (ret != 0) {
                threadStatus_[static_cast<size_t>(threadIndex)] = ThreadStatus::THREAD_EXIT;
                aicpusd_err("Add the system call failed, thread threadIndex[%u], ret[%d],"
                            " syscall number[%d].",
                            threadIndex, ret, filterSystemCall);
                return AICPU_SCHEDULE_ERROR_COMMON_ERROR;
            }
        }

        ret = seccomp_load(ctx);
        if (ret != 0) {
            threadStatus_[static_cast<size_t>(threadIndex)] = ThreadStatus::THREAD_EXIT;
            aicpusd_err("Execute seccomp_load failed, thread threadIndex[%u], ret[%d].", threadIndex, ret);
            return AICPU_SCHEDULE_ERROR_COMMON_ERROR;
        }
        threadStatus_[static_cast<size_t>(threadIndex)] = ThreadStatus::THREAD_RUNNING;
        aicpusd_info("Execute seccomp_load success.");
        return AICPU_SCHEDULE_OK;
    }

    void ThreadPool::Work(const uint32_t threadIndex)
    {
        const uint32_t deviceId = AicpuSchedule::AicpuDrvManager::GetInstance().GetDeviceId();
        aicpu::aicpuContext_t context;
        context.tsId = 0U;
        context.deviceId = deviceId;
        context.hostPid = AicpuDrvManager::GetInstance().GetHostPid();
        context.vfId = AicpuDrvManager::GetInstance().GetVfId();
        aicpu::SetUniqueVfId(AicpuDrvManager::GetInstance().GetUniqueVfId());
        const auto aicpuRet = aicpu::aicpuSetContext(&context);
        if (aicpuRet != aicpu::AICPU_ERROR_NONE) {
            aicpusd_err("Set aicpu context failed, deviceId[%u], thread[%u].", deviceId, threadIndex);
            AicpuSchedule::ThreadPool::Instance().PostSem(threadIndex);
            return;
        }
        aicpusd_info("Aicpu device[%u]:thread[%u] started.", deviceId, threadIndex);
        const auto ret = halEschedSubscribeEvent(deviceId, DEFAULT_GROUP_ID, threadIndex, EVENT_MASK);
        if (ret != static_cast<int32_t>(DRV_ERROR_NONE)) {
            aicpusd_err("halEschedSubscribeEvent failed, deviceId[%u], groupId[%u], threadIndex[%u] eventBitmap[%llu].",
                        deviceId, DEFAULT_GROUP_ID, threadIndex, EVENT_MASK);
            AicpuSchedule::ThreadPool::Instance().PostSem(threadIndex);
            return;
        }
        aicpusd_info("halEschedSubscribeEvent success, deviceId[%u], groupId[%u], threadIndex[%u] eventBitmap[%llu].",
                     deviceId, DEFAULT_GROUP_ID, threadIndex, EVENT_MASK);
        if (AicpuSchedule::ThreadPool::Instance().SetAffinity(static_cast<size_t>(threadIndex), deviceId) !=
            AICPU_SCHEDULE_OK) {
            AicpuSchedule::ThreadPool::Instance().PostSem(threadIndex);
            return;
        }
        if (AicpuSchedule::ThreadPool::Instance().SecureCompute(threadIndex) !=
            AICPU_SCHEDULE_OK) {
            AicpuSchedule::ThreadPool::Instance().PostSem(threadIndex);
            return;
        }
        AicpuSchedule::ThreadPool::Instance().PostSem(threadIndex);
        (void)aicpu::SetAicpuThreadIndex(threadIndex);
        AicpuSchedule::AicpuEventManager::GetInstance().LoopProcess(threadIndex);
        aicpusd_info("Aicpu device[%u]:thread[%u] stopped.", deviceId, threadIndex);
    }

    int32_t ThreadPool::WriteTidForAffinity(const size_t threadIndex)
    {
        if (threadIndex >= threadStatus_.size()) {
            aicpusd_err("threadIndex[%zu], out of rank[0, %zu]",
                        threadIndex, threadStatus_.size());
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }

        std::string command = "sudo /var/add_aicpu_tid_to_tasks.sh";
        std::string pathStr = "/var/add_aicpu_tid_to_tasks.sh";
        if (access(pathStr.c_str(), F_OK) != 0) {
            aicpusd_info("Not find add_aicpu_tid_to_tasks.sh.");
            return AICPU_SCHEDULE_OK;
        }
        command = command + " " + std::to_string(GetTid());

        // system() may fail due to  "No child processes".
        // if SIGCHLD is set to SIG_IGN, waitpid() may report ECHILD error because it cannot find the child process.
        // The reason is that the system() relies on a feature of the system, that is,
        // when the kernel initializes the process, the processing mode of SIGCHLD signal is SIG_IGN.
        const int32_t ret = AicpuSchedule::AicpuUtil::ExecuteCmd(command);
        if (ret != 0) {
            threadStatus_[threadIndex] = ThreadStatus::THREAD_EXIT;
            aicpusd_err("write tid[%lu] to /sys/fs/cgroup/cpuset/AICPU/tasks failed, ret[%d], strerror[%s]",
                GetTid(), ret, strerror(errno));
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        return AICPU_SCHEDULE_OK;
    }

    int32_t ThreadPool::AddPidToTask(const size_t threadIndex)
    {
        if (FeatureCtrl::IsBindPidByHal()) {
            if (&halBindCgroup != nullptr) {
                aicpusd_info("Bind pid by hal index:%zu.", threadIndex);
                const drvError_t drvRet = halBindCgroup(BIND_AICPU_CGROUP);
                if (drvRet != DRV_ERROR_NONE) {
                    aicpusd_err("halBindCgroup failed, ret[%d]", drvRet);
                    return AICPU_SCHEDULE_ERROR_INIT_FAILED;
                }
                aicpusd_info("halBindCgroup success");
            } else {
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
        } else {
            aicpusd_run_info("AddPidToTask by WriteTidForAffinity");
            auto ret = WriteTidForAffinity(threadIndex);
            if (ret != static_cast<int32_t>(AICPU_SCHEDULE_OK)) {
                aicpusd_err("WriteTidForAffinity failed, ret[%d]", ret);
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
            aicpusd_info("WriteTidForAffinity success");
        }
        return AICPU_SCHEDULE_OK;
    }


    int32_t ThreadPool::SetAffinityByPm(const size_t threadIndex)
    {
        const uint32_t physIndex = AicpuDrvManager::GetInstance().GetAicpuPhysIndex(static_cast<uint32_t>(threadIndex));
        const pid_t tid = static_cast<pid_t>(GetTid());

        std::vector<uint32_t> coreAffinity;
        coreAffinity.push_back(physIndex);
        const auto ret = ProcMgrBindThread(tid, coreAffinity);
        if (ret != 0U) {
            threadStatus_[threadIndex] = ThreadStatus::THREAD_EXIT;
            aicpusd_err("set affinity failed ret[%d], aicpu logical threadIndex[%zu], "
                        "aicpu physical threadIndex[%u],tid[%u], device id[%u]",
                        ret, threadIndex, physIndex, tid, AicpuDrvManager::GetInstance().GetDeviceId());
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        threadStatus_[threadIndex] = ThreadStatus::THREAD_RUNNING;
        aicpusd_info(
            "set affinity success, aicpu logical threadIndex[%zu], aicpu physical threadIndex[%u], device id[%u]",
            threadIndex, physIndex, AicpuDrvManager::GetInstance().GetDeviceId());
        return AICPU_SCHEDULE_OK;
    }

    int32_t ThreadPool::SetAffinityBySelf(const size_t threadIndex)
    {
        if (AddPidToTask(threadIndex) != AICPU_SCHEDULE_OK) {
            aicpusd_err("AddPidToTask failed");
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }

        cpu_set_t mask;
        CPU_ZERO(&mask);

        uint32_t physIndex = 0;
        uint32_t devNum = 0U;
        if (&halGetVdevNum != nullptr) {
            int32_t result = halGetVdevNum(&devNum);
            if (result != 0) {
                aicpusd_err("custom halGetVdevNum, failed result[%d]", result);
                return AICPU_SCHEDULE_ERROR_INIT_FAILED;
            }
        }
        if (devNum > 0U) {
            physIndex = AicpuDrvManager::GetInstance().GetAicpuPhysIndexInVfMode(static_cast<uint32_t>(threadIndex),
                        AicpuDrvManager::GetInstance().GetDeviceId());
        } else {
            physIndex = AicpuDrvManager::GetInstance().GetAicpuPhysIndex(static_cast<uint32_t>(threadIndex));
        }
        aicpusd_info("[custom]SetAffinityBySelf, threadIndex[%u], physIndex[%u], devNum[%u]",
                         static_cast<uint32_t>(threadIndex), physIndex, devNum);

        // cannot overflow, aicpu num < 65535, max [64=4*16]
        CPU_SET(static_cast<int32_t>(physIndex), &mask);
        const int32_t ret = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &mask);
        if (ret != 0) {
            threadStatus_[threadIndex] = ThreadStatus::THREAD_EXIT;
            aicpusd_err("set affinity failed ret[%d], aicpu logical threadIndex[%u], aicpu physical threadIndex[%u], "
                        "device id[%u]",
                ret, threadIndex, physIndex, AicpuDrvManager::GetInstance().GetDeviceId());
            return AICPU_SCHEDULE_ERROR_INIT_FAILED;
        }
        threadStatus_[threadIndex] = ThreadStatus::THREAD_RUNNING;
        aicpusd_info(
            "set affinity success, aicpu logical threadIndex[%u], aicpu physical threadIndex[%u], device id[%u]",
            threadIndex, physIndex, AicpuDrvManager::GetInstance().GetDeviceId());
        return AICPU_SCHEDULE_OK;
    }

    int32_t ThreadPool::SetAffinity(const size_t threadIndex, const uint32_t deviceId)
    {
        (void)deviceId;
        std::string cpuSetFlag;
        const char_t *const envValue = std::getenv("PROCMGR_AICPU_CPUSET");
        if (envValue != nullptr) {
            cpuSetFlag = std::string(envValue);
        }

        int32_t res = AICPU_SCHEDULE_OK;
        if (cpuSetFlag == "1") {
            res = SetAffinityByPm(threadIndex);
            aicpusd_run_info("aicpu bind tid by pm, cpuSetFlag:[%s], threadIndex[%zu], deviceId[%u], res[%d].",
                             cpuSetFlag.c_str(), threadIndex, AicpuDrvManager::GetInstance().GetDeviceId(), res);
        } else {
            res = SetAffinityBySelf(threadIndex);
            aicpusd_run_info("aicpu bind tid by self, cpuSetFlag:[%s], threadIndex[%zu], deviceId[%u], res[%d].",
                             cpuSetFlag.c_str(), threadIndex, AicpuDrvManager::GetInstance().GetDeviceId(), res);
        }
        return res;
    }

    void ThreadPool::PostSem(const uint32_t threadIndex)
    {
        (void)sem_post(&(sems_[static_cast<size_t>(threadIndex)]));
    }
}  // namespace AicpuSchedule
