/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "bind_cpu_utils.h"
#include <sstream>
#include <fcntl.h>
#include <semaphore.h>
#include <cstring>
#include <signal.h>
#include <stdlib.h>
#include "qs_interface_process.h"
#include "driver/ascend_hal.h"
#include "common/bqs_log.h"
#include "ProcMgrSysOperatorAgent.h"
#include "common/bqs_feature_ctrl.h"
#include "queue_schedule_feature_ctrl.h"

namespace bqs {
namespace {
sem_t g_sem;
bool g_semInited = false;
}

static drvError_t GetCpuInfo(const uint32_t deviceId, CpuInfo &cpuInfo)
{
    drvError_t ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_CCPU),
                                      static_cast<int32_t>(INFO_TYPE_CORE_NUM), &(cpuInfo.ccpuNum));
    if (ret != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("get device[%u] cpu info failed, ret = %d.", deviceId, static_cast<int32_t>(ret));
        return ret;
    }

    ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_DCPU),
                           static_cast<int32_t>(INFO_TYPE_CORE_NUM), &(cpuInfo.dcpuNum));
    if (ret != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("get device[%u] cpu info failed, ret = %d.", deviceId, static_cast<int32_t>(ret));
        return ret;
    }

    ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_AICPU),
                           static_cast<int32_t>(INFO_TYPE_CORE_NUM), &(cpuInfo.aicpuNum));
    if (ret != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("get device[%u] cpu info failed, ret = %d.", deviceId, static_cast<int32_t>(ret));
        return ret;
    }

    ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_TSCPU),
                           static_cast<int32_t>(INFO_TYPE_CORE_NUM), &(cpuInfo.tscpuNum));
    if (ret != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("get device[%u] cpu info failed, ret = %d.", deviceId, static_cast<int32_t>(ret));
        return ret;
    }

    ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_CCPU),
                           static_cast<int32_t>(INFO_TYPE_OS_SCHED), &(cpuInfo.ccpuOsSched));
    if (ret != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("get device[%u] cpu info failed, ret = %d.", deviceId, static_cast<int32_t>(ret));
        return ret;
    }

    ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_DCPU),
                           static_cast<int32_t>(INFO_TYPE_OS_SCHED), &(cpuInfo.dcpuOsSched));
    if (ret != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("get device[%u] cpu info failed, ret = %d.", deviceId, static_cast<int32_t>(ret));
        return ret;
    }

    ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_AICPU),
                           static_cast<int32_t>(INFO_TYPE_OS_SCHED), &(cpuInfo.aicpuOsSched));
    if (ret != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("get device[%u] cpu info failed, ret = %d.", deviceId, static_cast<int32_t>(ret));
        return ret;
    }

    ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_TSCPU),
                           static_cast<int32_t>(INFO_TYPE_OS_SCHED), &(cpuInfo.tscpuOsSched));
    if (ret != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("get device[%u] cpu info failed, ret = %d.", deviceId, static_cast<int32_t>(ret));
        return ret;
    }

    return ret;
}

BqsStatus BindCpuUtils::InitSem()
{
    if (!g_semInited) {
        const int32_t semInitRet = sem_init(&g_sem, 0, 0U);
        if (semInitRet == -1) {
            BQS_LOG_ERROR("sem init failed, %s", strerror(errno));
            return BQS_STATUS_INNER_ERROR;
        }
        g_semInited = true;
    }
    return BQS_STATUS_OK;
}

BqsStatus BindCpuUtils::WaitSem()
{
    if (g_semInited) {
        const int32_t semWaitRet = sem_wait(&g_sem);
        if (semWaitRet == -1) {
            BQS_LOG_ERROR("sem wait failed, %s", strerror(errno));
            return BQS_STATUS_INNER_ERROR;
        }
        return BQS_STATUS_OK;
    }
    BQS_LOG_ERROR("sem wait failed, sem not init");
    return BQS_STATUS_INNER_ERROR;
}

BqsStatus BindCpuUtils::PostSem()
{
    if (g_semInited) {
        const int32_t semPostRet = sem_post(&g_sem);
        if (semPostRet == -1) {
            BQS_LOG_ERROR("sem post failed, %s", strerror(errno));
            return BQS_STATUS_INNER_ERROR;
        }
        return BQS_STATUS_OK;
    }
    BQS_LOG_ERROR("sem post failed, sem not init");
    return BQS_STATUS_INNER_ERROR;
}

void BindCpuUtils::DestroySem()
{
    if (g_semInited) {
        (void)sem_destroy(&g_sem);
        g_semInited = false;
    }
}

BqsStatus BindCpuUtils::WriteTidToCpuSet()
{
    const pid_t tid = static_cast<pid_t>(GetTid());
    std::string command = "cd /var/ && sudo ./add_aicpu_tid_to_tasks.sh";
    command = command + " " + std::to_string(static_cast<uint64_t>(tid));
    // system() may fail due to  "No child processes".
    // if SIGCHLD is set to SIG_IGN, waitpid() may report ECHILD error because it cannot find the child process.
    // The reason is that the system() relies on a feature of the system, that is,
    // when the kernel initializes the process, the processing mode of SIGCHLD signal is SIG_IGN.
    const int32_t ret = system(command.c_str());
    if (ret != 0) {
        BQS_LOG_WARN("write tid[%d] to /sys/fs/cgroup/cpuset/AICPU/tasks failed, ret[%d], strerror[%s]",
            tid, ret, strerror(errno));
        return BQS_STATUS_INNER_ERROR;
    }

    return BQS_STATUS_OK;
}

BqsStatus BindCpuUtils::BindAicpuBySelf(uint32_t bindCpuIndex)
{
    // On device, it must write tid to aicpu set file, when you need bind aicpu.
    const BqsStatus writeRet = WriteTidToCpuSet();
    if (writeRet != BQS_STATUS_OK) {
        BQS_LOG_WARN(
            "Write tid to cpuset file failed, maybe cause bind cpu failed, ret=%d.", static_cast<int32_t>(writeRet));
    }

    cpu_set_t mask;
    CPU_ZERO(&mask);
    CPU_SET(bindCpuIndex, &mask);
    int32_t ret = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &mask);
    if (ret != 0) {
        BQS_LOG_ERROR("Set affinity with cpu[%u] failed, ret=%d.", bindCpuIndex, ret);
        return BQS_STATUS_INNER_ERROR;
    }

    CPU_ZERO(&mask);
    // check set result
    ret = pthread_getaffinity_np(pthread_self(), sizeof(cpu_set_t), &mask);
    if (ret != 0) {
        BQS_LOG_ERROR("Getaffinity failed, ret=%d", ret);
        return BQS_STATUS_INNER_ERROR;
    }
    // check bind result
    if (CPU_ISSET(bindCpuIndex, &mask) == 0U) {
        BQS_LOG_INFO("Check CPU_ISSET with cpu[%u] not success", bindCpuIndex);
        return BQS_STATUS_INNER_ERROR;
    }
    BQS_LOG_INFO("Set affinity with cpu[%u] successful", bindCpuIndex);
    return BQS_STATUS_OK;
}

BqsStatus BindCpuUtils::SetThreadAffinity(const pthread_t &threadId, const std::vector<uint32_t> &cpuIds)
{
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    for (const auto cpuId: cpuIds) {
        CPU_SET(cpuId, &cpuset);
        BQS_LOG_INFO("prepare bind threadId=%lu to cpuId=%u", threadId, static_cast<uint32_t>(cpuId));
    }
    BQS_LOG_RUN_INFO("begin call pthread_setaffinity_np threadId=%lu", threadId);
    // 设置线程亲和性
    int32_t ret = pthread_setaffinity_np(threadId, sizeof(cpu_set_t), &cpuset);
    if (ret != 0) {
        BQS_LOG_ERROR("BindCpu threadId=%lu setaffinity failed, ret=%d", threadId, ret);
        return BQS_STATUS_INNER_ERROR;
    }
    // 检查线程实际亲和性
    ret = pthread_getaffinity_np(threadId, sizeof(cpu_set_t), &cpuset);
    if (ret != 0) {
        BQS_LOG_ERROR("BindCpu threadId=%lu getaffinity failed, ret=%d", threadId, ret);
        return BQS_STATUS_INNER_ERROR;
    }
    for (int32_t cpuId = 0; cpuId < CPU_SETSIZE; cpuId++) {
        if (CPU_ISSET(cpuId, &cpuset) != 0) {
            BQS_LOG_INFO("BindCpu threadId=%lu to cpuId=%d success", threadId, static_cast<int32_t>(cpuId));
        }
    }
    return BQS_STATUS_OK;
}

BqsStatus BindCpuUtils::BindAicpuByPm(const uint32_t bindCpuIndex)
{
    const pid_t tid = static_cast<pid_t>(GetTid());

    std::vector<uint32_t> coreAffinity;
    coreAffinity.push_back(bindCpuIndex);
    const auto ret = ProcMgrBindThread(tid, coreAffinity);
    if (ret != 0U) {
        BQS_LOG_ERROR("set affinity failed ret[%d], aicpu bindCpuIndex[%u], tid[%u]",
            ret, bindCpuIndex, tid);
        return BQS_STATUS_INNER_ERROR;
    }
    return BQS_STATUS_OK;
}

BqsStatus BindCpuUtils::BindAicpu(const uint32_t bindCpuIndex)
{
    std::string cpuSetFlag;
    const char * const envValue = std::getenv("PROCMGR_AICPU_CPUSET");
    if (envValue != nullptr) {
        cpuSetFlag = std::string(envValue);
    }

    BqsStatus res = BQS_STATUS_OK;
    if (cpuSetFlag == "1") {
        res = BindAicpuByPm(bindCpuIndex);
        BQS_LOG_RUN_INFO("Qs bind tid by pm, cpuSetFlag:[%s], index[%u], res[%d].",
                         cpuSetFlag.c_str(), bindCpuIndex, static_cast<int32_t>(res));
    } else {
        res = BindAicpuBySelf(bindCpuIndex);
        BQS_LOG_RUN_INFO("Qs bind tid by self, cpuSetFlag:[%s] index[%u], res[%d].",
                         cpuSetFlag.c_str(), bindCpuIndex, static_cast<int32_t>(res));
    }
    return res;
}

void BindCpuUtils::SetThreadFIFO(const uint32_t deviceId)
{
    if (QSFeatureCtrl::ShouldSetThreadFIFO(deviceId)) {
        struct sched_param param;
        param.sched_priority = sched_get_priority_max(SCHED_FIFO);
        if (param.sched_priority == -1) {
            BQS_LOG_WARN("QueueSchedule sched_get_priority_max failed, errno[%d].", errno);
        } else if (sched_setscheduler(0, SCHED_FIFO, &param) == -1) {
            BQS_LOG_WARN("QueueSchedule sched_setscheduler failed, errno[%d].", errno);
        } else {
            BQS_LOG_INFO("QueueSchedule sched_setscheduler and sched_get_priority_max success.");
        }
    }
}

BqsStatus BindCpuUtils::GetDevCpuInfo(const uint32_t deviceId, std::vector<uint32_t> &aiCpuIds,
                                      std::vector<uint32_t> &ctrlCpuIds, uint32_t &coreNumPerDev, uint32_t &aicpuNum,
                                      uint32_t &aicpuBaseId)
{
    CpuInfo cpuInfo = {};
    uint32_t deviceIdTmp = deviceId;
    uint32_t ret;
    if (FeatureCtrl::IsVfModeDie1(deviceId)) {
        int64_t pfDeviceId = 0;
        ret = halGetDeviceInfo(deviceId, MODULE_TYPE_SYSTEM, INFO_TYPE_PHY_DIE_ID, &pfDeviceId);
        if (ret != DRV_ERROR_NONE) {
            BQS_LOG_ERROR("halGetDeviceInfo get pfDeviceId fail in device[%d], ret[%d]", deviceId, ret);
            return BQS_STATUS_DRIVER_ERROR;
        }
        deviceIdTmp = static_cast<uint32_t>(pfDeviceId);
    }
    ret = GetCpuInfo(deviceIdTmp, cpuInfo);
    if (ret != DRV_ERROR_NONE) {
        BQS_LOG_ERROR("get device[%u] cpu info failed, ret = %d.", deviceIdTmp, ret);
        return BQS_STATUS_DRIVER_ERROR;
    }
    coreNumPerDev = static_cast<uint32_t>(cpuInfo.ccpuNum) * static_cast<uint32_t>(cpuInfo.ccpuOsSched) +
                    static_cast<uint32_t>(cpuInfo.dcpuNum) * static_cast<uint32_t>(cpuInfo.dcpuOsSched) +
                    static_cast<uint32_t>(cpuInfo.aicpuNum) * static_cast<uint32_t>(cpuInfo.aicpuOsSched) +
                    static_cast<uint32_t>(cpuInfo.tscpuNum) * static_cast<uint32_t>(cpuInfo.tscpuOsSched);
    BQS_LOG_INFO("get device[%u] cpu num [%u] success", deviceIdTmp, coreNumPerDev);
    if (FeatureCtrl::IsAosCore()) {
        aicpuNum = static_cast<uint32_t>(cpuInfo.aicpuNum);
        aicpuBaseId = 0U;
        if (cpuInfo.ccpuOsSched != 0U) {
            aicpuBaseId += cpuInfo.ccpuNum;
        }
        if (cpuInfo.dcpuOsSched != 0U) {
            aicpuBaseId += cpuInfo.dcpuNum;
        }
        BQS_LOG_INFO("get device[%u] aicpu cpu info success, aicpuBaseId[%u], aicpuNum[%u]",
                     deviceIdTmp, aicpuBaseId, aicpuNum);
    } else {
        int64_t aicpuNumTmp = 0;
        int64_t aicpuBitMap = 0;
        if (FeatureCtrl::IsVfModeCheckedByDeviceId(deviceId)) {
            ret = halGetDeviceInfo(deviceId, MODULE_TYPE_AICPU, INFO_TYPE_PF_CORE_NUM, &aicpuNumTmp) +
                  halGetDeviceInfo(deviceId, MODULE_TYPE_AICPU, INFO_TYPE_PF_OCCUPY, &aicpuBitMap);
        } else {
            ret = halGetDeviceInfo(deviceId, MODULE_TYPE_AICPU, INFO_TYPE_CORE_NUM, &aicpuNumTmp) +
                  halGetDeviceInfo(deviceId, MODULE_TYPE_AICPU, INFO_TYPE_OCCUPY, &aicpuBitMap);
        }
        BQS_LOG_INFO("get device[%u] aicpu cpu info success, aicpuBitMap[%lld], aicpuNum[%u]",
                     deviceId, aicpuBitMap, aicpuNumTmp);
        aicpuNum = aicpuNumTmp;
        aiCpuIds.clear();
        uint32_t id = 0;
        while (aicpuBitMap != 0) {
            if ((static_cast<uint64_t>(aicpuBitMap) & static_cast<uint64_t>(0x1)) != 0) {
                aiCpuIds.push_back(id);
            }
            aicpuBitMap = static_cast<uint64_t>(aicpuBitMap) >> 1;
            id++;
        }
    }

    BQS_LOG_INFO("get device[%u] ctrl cpu info success, ccpuNum[%d], ccpuOsSched[%d]",
                 deviceId, cpuInfo.ccpuNum, cpuInfo.ccpuOsSched);
    if (cpuInfo.ccpuOsSched > 0L && !FeatureCtrl::IsVfModeDie1(deviceId)) {
        for (auto i = 0L; i < cpuInfo.ccpuNum; i++) {
            ctrlCpuIds.emplace_back(coreNumPerDev * deviceId + static_cast<uint32_t>(i));
        }
    }
    return BQS_STATUS_OK;
}

bool BindCpuUtils::AddToCgroup(const uint32_t deviceId, const uint32_t vfId)
{
    if (!QSFeatureCtrl::ShouldAddToCGroup(deviceId)) {
        return true;
    }

    BQS_LOG_RUN_INFO("AddToCgroup, deviceId = %u, vfId = %u", deviceId, vfId);
    const int32_t pid = drvDeviceGetBareTgid();
    std::string command = "cd /var/ && sudo ./tsdaemon_add_to_usermemory.sh";
    const std::string pathStr = "/var/tsdaemon_add_to_usermemory.sh";
    if (access(pathStr.c_str(), F_OK) != 0) {
        command = "cd /usr/local/Ascend/driver/tools/ && sudo ./tsdaemon_add_to_usermemory.sh";
    }
    (void)command.append(" memory ")
        .append(std::to_string(pid))
        .append(" ")
        .append(std::to_string(deviceId))
        .append(" ")
        .append(std::to_string(vfId));
    const sighandler_t oldHandler = signal(SIGCHLD, SIG_DFL);

    // system() may fail due to  "No child processes".
    // if SIGCHLD is set to SIG_IGN, waitpid() may report ECHILD error because it cannot find the child process.
    // The reason is that the system() relies on a feature of the system, that is,
    // when the kernel initializes the process, the processing mode of SIGCHLD signal is SIG_IGN.
    const int32_t ret = system(command.c_str());
    (void)signal(SIGCHLD, oldHandler);
    if (ret != 0) {
        BQS_LOG_ERROR("Add to cgroup failed, ret:[%d], cmd:[%s]", ret, command.c_str());
        return false;
    }
    BQS_LOG_RUN_INFO("Add to cgroup successfully, cmd:[%s].", command.c_str());
    return true;
}
}  // namespace bqs
