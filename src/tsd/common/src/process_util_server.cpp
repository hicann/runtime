/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "inc/process_util_server.h"
#include "inc/process_util_common.h"
#include <fstream>
#include <unistd.h>
#include <cstring>
#include <dlfcn.h>
#include "inc/internal_api.h"
#include "inc/log.h"
#include "inc/tsd_util.h"
#include "inc/weak_ascend_hal.h"
#include "driver/ascend_hal.h"
#include "inc/weak_log.h"
#include "inc/tsdaemon.h"
#include "inc/tsd_feature_ctrl.h"
#include "inc/tsd_path_mgr.h"

#ifdef TSD_SET_FIFO_MODE
#include "ProcMgrSysOperatorAgent.h"
#endif
namespace {
    constexpr const char *VM_RSS_NAME = "VmRSS:";
    constexpr const char *VM_HWM_NAME = "VmHWM:";
    constexpr const char *THREADS_NAME = "Threads:";
    const std::string MEM_LIMIT_TYPE_FILE = "/proc/ccfg/numa_id/memctrol_type";
    const std::string UNSHARED_MEM_LIMIT_TYPE = "unshared";
    constexpr uint32_t RETRY_TIMES_LONG = 1500U;
    constexpr uint32_t RETRY_TIMES = 500U;
    constexpr uint32_t RETRY_INTERVAL = 10U;
    constexpr uint32_t LOG_OUT_STEP = 100U;
    constexpr uint32_t READ_LINE_MAX_TIME = 20U;
    // 设置tsd 记录子进程id的时延
    constexpr const uint32_t PID_SET_FINISH_MAX_TIME = 12000U;
    constexpr uint32_t PID_SET_FINISH_CHECK_RETRY_INTERVAL = 10U;
    const std::map<TsdSubEventType, TsdSubEventType> NORMAL_SUB_EVENT_MAP = {
        {TsdSubEventType::TSD_EVENT_START_RSP, TsdSubEventType::TSD_EVENT_START_RSP},
        {TsdSubEventType::TSD_EVENT_SHUTDOWN_RSP, TsdSubEventType::TSD_EVENT_SHUTDOWN_RSP},
        {TsdSubEventType::TSD_EVENT_NOTIFY_AICPUINFO, TsdSubEventType::TSD_EVENT_NOTIFY_AICPUINFO},
        {TsdSubEventType::TSD_EVENT_LOAD_SO, TsdSubEventType::TSD_EVENT_LOAD_SO},
        {TsdSubEventType::TSD_EVENT_START_OR_STOP_FAIL, TsdSubEventType::TSD_EVENT_START_OR_STOP_FAIL},
        {TsdSubEventType::TSD_EVENT_ABNORMAL, TsdSubEventType::TSD_EVENT_ABNORMAL},
        {TsdSubEventType::TSD_EVENT_GET_CAPABILITY, TsdSubEventType::TSD_EVENT_GET_CAPABILITY},
        {TsdSubEventType::TSD_EVENT_START_QS_MODULE_RSP, TsdSubEventType::TSD_EVENT_START_QS_MODULE_RSP},
        {TsdSubEventType::TSD_EVENT_START_AICPU_SD_MODULE_RSP, TsdSubEventType::TSD_EVENT_START_AICPU_SD_MODULE_RSP},
        {TsdSubEventType::TSD_EVENT_UPDATE_PROFILING_RSP, TsdSubEventType::TSD_EVENT_UPDATE_PROFILING_RSP},
        {TsdSubEventType::TSD_EVENT_SET_SCHEDULE_MODE, TsdSubEventType::TSD_EVENT_SET_SCHEDULE_MODE}
    };

    const std::map<TsdSubEventType, TsdSubEventType> CUST_SUB_EVENT_MAP = {
        {TsdSubEventType::TSD_EVENT_START_RSP, TsdSubEventType::TSD_EVENT_START_RSP},
        {TsdSubEventType::TSD_EVENT_SHUTDOWN_RSP, TsdSubEventType::TSD_EVENT_SHUTDOWN_RSP},
        {TsdSubEventType::TSD_EVENT_START_OR_STOP_FAIL, TsdSubEventType::TSD_EVENT_START_OR_STOP_FAIL},
        {TsdSubEventType::TSD_EVENT_ABNORMAL, TsdSubEventType::TSD_EVENT_ABNORMAL},
        {TsdSubEventType::TSD_EVENT_UPDATE_PROFILING_RSP, TsdSubEventType::TSD_EVENT_UPDATE_PROFILING_RSP}
    };
}
namespace tsd {
    using SetMempolicyFunc = long(*)(int mode, const unsigned long *nodemask, unsigned long maxnode);
    static bool qsBindHostPidFlag = false;
    static drvBindHostpidInfo qsBindHostPidInfo = { };

TSD_StatusT ProcessUtilServer::AddSubProcessToGroups(const int32_t &pid,
                                                     const std::map<std::string, GroupShareAttr> &groups)
{
    for (auto grpElement : groups) {
        grpElement.second.admin = 1U;
        const auto ret = halGrpAddProc(grpElement.first.c_str(), pid, grpElement.second);
        if ((ret != static_cast<int>(DRV_ERROR_NONE)) && (ret != static_cast<int>(DRV_ERROR_REPEATED_INIT))) {
            TSD_ERROR("[TSDaemon]Fail to add dstPid[%d] in group[%s] ret[%d]", pid, grpElement.first.c_str(), ret);
            return static_cast<uint32_t>(TSD_INTERNAL_ERROR);
        }
        TSD_RUN_INFO(
            "[ProcessUtil] Add group[%s] authority to subProcPid[%d] end. admin[%u] alloc[%u] read[%u] write[%u]",
            grpElement.first.c_str(), pid, grpElement.second.admin, grpElement.second.alloc,
            grpElement.second.read, grpElement.second.write);
    }
    return TSD_OK;
}

TSD_StatusT ProcessUtilServer::SetCustAicpuSecurityCtx()
{
    if (!FeatureCtrl::IsSupportSelinux()) {
        return TSD_OK;
    }

    TSD_RUN_INFO("[TSDaemon]Start Set Cust Aicpu Security Context.");

    static void *handle = nullptr;
    if (handle == nullptr) {
        const std::string libPath = "/usr/lib64/libselinux.so";
        handle = dlopen(libPath.c_str(), RTLD_NOW);
        if (handle == nullptr) {
            TSD_ERROR("[TSDaemon]Get Selinux So Failed.");
            return static_cast<uint32_t>(TSD_SET_SECURITY_CTX_FAILED);
        }
    }

    const SetSecCtx setExec = PtrToFunctionPtr<void, SetSecCtx>(dlsym(handle, "setexeccon"));
    if (setExec == nullptr) {
        TSD_ERROR("[TSDaemon]Get setexeccon From So Failed.");
        return static_cast<uint32_t>(TSD_SET_SECURITY_CTX_FAILED);
    }

    const std::string secCtx = "unconfined_u:unconfined_r:guest_ai_cpu_t:s0";
    const int ret = (*setExec)(secCtx.c_str());
    if (ret != 0) {
        TSD_ERROR("[TSDaemon]Call setexeccon Failed. Ret = %d.", ret);
        return static_cast<uint32_t>(TSD_SET_SECURITY_CTX_FAILED);
    }

    return TSD_OK;
}

void ProcessUtilServer::SetMempolicy(int32_t mode, const unsigned long *nodemask, unsigned long maxnode)
{
    void *handle = dlopen("libnuma.so.1", static_cast<int32_t>(
        (static_cast<uint32_t>(RTLD_GLOBAL)) | (static_cast<uint32_t>(RTLD_NOW))));
    if (handle == nullptr) {
        return;
    }

    SetMempolicyFunc const pt = PtrToFunctionPtr<void, SetMempolicyFunc>(dlsym(handle, "set_mempolicy"));
    if (pt == nullptr) {
        (void)dlclose(handle);
        return;
    }
    pt(mode, nodemask, maxnode);
    (void)dlclose(handle);
    handle = nullptr;
}

bool ProcessUtilServer::IsNeedSetMemPolicy()
{
    std::string memType;
    const TSD_StatusT ret = ProcessUtilCommon::ReadCurMemCtrolType(MEM_LIMIT_TYPE_FILE, memType);
    if (ret != TSD_OK) {
        return false;
    }

    if (memType.length() < UNSHARED_MEM_LIMIT_TYPE.length()) {
        return false;
    }

    if (strncmp(UNSHARED_MEM_LIMIT_TYPE.c_str(), memType.c_str(), UNSHARED_MEM_LIMIT_TYPE.length()) == 0) {
        return true;
    }
    return false;
}

TSD_StatusT ProcessUtilServer::UnBindHostPid(const TsdSubProcessType procType, const uint32_t devId,
    const int32_t vfId, const uint32_t hostpid, const int32_t subProcId)
{
    if ((subProcId == -1) || (&drvUnbindHostPid == nullptr)) {
        TSD_RUN_INFO("not need UnBind procType[%d], device id[%u], host pid[%u], vf id[%u] devpid[%d]",
            procType, devId, hostpid, vfId, subProcId);
        return TSD_OK;
    }
    struct drvBindHostpidInfo para = {};
    if (BuildBindParaInfo(para, procType, devId, vfId, hostpid, subProcId) != TSD_OK) {
        TSD_ERROR("build bind param error,procType[%d], device id[%u], host pid[%u], vf id[%u] devpid[%d]",
            procType, devId, hostpid, vfId, subProcId);
        return TSD_INTERNAL_ERROR;
    }
    // 类似于bindhostpid, drvUnbindHostPid里面有加锁的行为，可能会时间超长，这个日志为了定界使用
    TSD_RUN_INFO("before Call unbind device id[%u], host pid[%u], mode[%d], cp type[%d] vf id[%u] devpid[%d]",
                 devId, static_cast<uint32_t>(para.host_pid), para.mode, para.cp_type, vfId, subProcId);
    auto startTime = std::chrono::steady_clock::now();
    const drvError_t drvRet = drvUnbindHostPid(para);
    auto endTime = std::chrono::steady_clock::now();
    double drUs = std::chrono::duration<double, std::micro>(endTime - startTime).count();
    if (drvRet != DRV_ERROR_NONE) {
        // drvUnbindHostPid失败了，忽略掉，继续停进程。
        TSD_RUN_WARN("drvUnbindHostPid not success, ret[%d],device id[%u],host pid[%u],mode[%d], "
            "cp type[%d],vfId[%u],devpid[%d],cost time[%.2lf]us",
            drvRet, devId, static_cast<uint32_t>(para.host_pid), para.mode, para.cp_type, vfId, subProcId, drUs);
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO("Call drvUnbindHostPid success device id[%u], host pid[%u], mode[%d], "
        "cp type[%d] vf id[%u] devpid[%d],cost time[%.2lf]us",
        devId, static_cast<uint32_t>(para.host_pid), para.mode, para.cp_type, vfId, subProcId, drUs);
    return TSD_OK;
}

void ProcessUtilServer::SetSubProcessMemPolicy(uint32_t devId)
{
    if (!IsNeedSetMemPolicy()) {
        return;
    }
    MemInfo vfMemInfo;
    const auto getRet = halMemGetInfo(devId, MEM_INFO_TYPE_AI_NUMA_INFO, &vfMemInfo);
    if (getRet != DRV_ERROR_NONE) {
        return;
    }
    const uint64_t nodeNum = static_cast<uint64_t>(vfMemInfo.numa_info.node_cnt);
    if (nodeNum > sizeof(vfMemInfo.numa_info.node_id) / sizeof(int32_t)) {
        return;
    }
    unsigned long nodeMask[2UL] = {0UL, 0UL}; // less than 128
    constexpr unsigned long bitsMaxNum = 128UL;
    for (uint64_t index = 0UL; index < nodeNum; index++) {
        constexpr size_t bitsOfUint64 = 64UL;
        size_t nodeIndex = static_cast<size_t>(vfMemInfo.numa_info.node_id[index]);
        if (nodeIndex >= bitsMaxNum) {
            return;
        }
        if (nodeIndex >= bitsOfUint64) {
            nodeIndex -= bitsOfUint64;
            nodeMask[1UL] |= (1UL << nodeIndex);
        } else {
            nodeMask[0UL] |= (1UL << nodeIndex);
        }
    }
    constexpr int32_t mpolBind = 2;
    SetMempolicy(mpolBind, nodeMask, bitsMaxNum);
}

devdrv_process_type ProcessUtilServer::ParseSubProcTypeToDrvType(const TsdSubProcessType procType)
{
    enum devdrv_process_type cpType = DEVDRV_PROCESS_CPTYPE_MAX;
    switch (procType) {
        case TsdSubProcessType::PROCESS_COMPUTE:
        case TsdSubProcessType::PROCESS_NN: {
            cpType = DEVDRV_PROCESS_CP1;
            break;
        }
        case TsdSubProcessType::PROCESS_CUSTOM_COMPUTE: {
            cpType = DEVDRV_PROCESS_CP2;
            break;
        }
        case TsdSubProcessType::PROCESS_HCCP: {
            cpType = DEVDRV_PROCESS_HCCP;
            break;
        }
        case TsdSubProcessType::PROCESS_QUEUE_SCHEDULE: {
            cpType = DEVDRV_PROCESS_QS;
            break;
        }
        case TsdSubProcessType::PROCESS_UDF:
        case TsdSubProcessType::PROCESS_BUILTIN_UDF:
        case TsdSubProcessType::PROCESS_ADPROF: {
            cpType = DEVDRV_PROCESS_USER;
            break;
        }
        default: {
            TSD_ERROR("Fork subprocess failed, unknown procType[%d]", procType);
            cpType = DEVDRV_PROCESS_CPTYPE_MAX;
        }
    }
    return cpType;
}
TSD_StatusT ProcessUtilServer::BuildBindParaInfo(struct drvBindHostpidInfo &para, const TsdSubProcessType procType,
                                                const uint32_t devId, const int32_t vfId, const uint32_t hostpid,
                                                const int32_t subProcId)
{
    enum devdrv_process_type cpType = ParseSubProcTypeToDrvType(procType);
    if (cpType == DEVDRV_PROCESS_CPTYPE_MAX) {
        TSD_ERROR("get procType:%u error", static_cast<uint32_t>(procType));
        return TSD_INTERNAL_ERROR;
    }
    drvHdcCapacity capacity;
    capacity.chanType = HDC_CHAN_TYPE_SOCKET;
    capacity.maxSegment = 0U;
    const hdcError_t hdcRet = drvHdcGetCapacity(&capacity);
    if (hdcRet != DRV_ERROR_NONE) {
        TSD_ERROR("Tsd get capacity failed, ret[%d].", hdcRet);
        return TSD_INTERNAL_ERROR;
    }
    AICPUSDPlat mode = AICPUSDPlat::AICPUSD_ONLINE_PLAT;
    // online: with host, offline: without host only device
    if (capacity.chanType == HDC_CHAN_TYPE_SOCKET) {
        mode = AICPUSDPlat::AICPUSD_OFFLINE_PLAT;
    }
    // 针对device侧由tsd拉起的nn和udf，不与host进程交互，适配事件调度要求自己绑定自己
    if (procType == TsdSubProcessType::PROCESS_NN) {
        para.host_pid = static_cast<pid_t>(subProcId);
        mode = AICPUSDPlat::AICPUSD_OFFLINE_PLAT;
    } else {
        para.host_pid = static_cast<pid_t>(hostpid);
    }
    para.vfid = static_cast<uint32_t>(vfId);
    para.len = static_cast<uint32_t>(PROCESS_SIGN_LENGTH);
    para.mode = static_cast<int32_t>(mode);
    para.cp_type = cpType;
    para.chip_id = devId;

    errno_t memRet = memcpy_s(para.sign, static_cast<size_t>(PROCESS_SIGN_LENGTH), &subProcId, sizeof(int32_t));
    if (memRet != EOK) {
        TSD_ERROR("Memcpy_s failed, ret=[%d]", memRet);
        return TSD_INTERNAL_ERROR;
    }
    return TSD_OK;
}
TSD_StatusT ProcessUtilServer::BindHostPidAndSubProcess(const TsdSubProcessType procType, const uint32_t devId,
                                                        const int32_t vfId, const uint32_t hostpid,
                                                        const int32_t subProcId)
{
    if ((subProcId == -1) || (&drvBindHostPid == nullptr)) {
        TSD_ERROR("input param error subProcId:%d", subProcId);
        return TSD_INTERNAL_ERROR;
    }
    struct drvBindHostpidInfo para = {};
    if (BuildBindParaInfo(para, procType, devId, vfId, hostpid, subProcId) != TSD_OK) {
        TSD_ERROR("build bind param error");
        return TSD_INTERNAL_ERROR;
    }
    // bindhostpid 里面有加锁的行为，可能会时间超长，这个日志为了定界使用，不要删除
    TSD_RUN_INFO("before Call bind device id[%u], host pid[%u], mode[%d], cp type[%d] vf id[%u] devpid[%d]",
                 devId, static_cast<uint32_t>(para.host_pid), para.mode, para.cp_type, vfId, subProcId);
    const drvError_t drvRet = drvBindHostPid(para);
    if (drvRet != DRV_ERROR_NONE) {
        TSD_ERROR("drvBindHostPid failed, ret[%d],device id[%u],host pid[%u],mode[%d],cp type[%d],vfId[%u],devpid[%d]",
                  drvRet, devId, static_cast<uint32_t>(para.host_pid), para.mode, para.cp_type, vfId, subProcId);
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO("Call drvBindHostPidsuccess device id[%u], host pid[%u], mode[%d], cp type[%d] vf id[%u] devpid[%d]",
                 devId, static_cast<uint32_t>(para.host_pid), para.mode, para.cp_type, vfId, subProcId);

    if (procType == TsdSubProcessType::PROCESS_QUEUE_SCHEDULE) {
        auto memRet = memcpy_s(&qsBindHostPidInfo, sizeof(drvBindHostpidInfo), &para, sizeof(drvBindHostpidInfo));
        if (memRet != EOK) {
            TSD_ERROR("Memcpy_s failed, ret=[%d]", memRet);
            return TSD_INTERNAL_ERROR;
        }
        TSD_INFO("save qsBindHostInfo success");
        qsBindHostPidFlag = true;
    }

    return TSD_OK;
}

TSD_StatusT ProcessUtilServer::ReconnectedToDatamster(const int32_t dmPid)
{
    if (qsBindHostPidFlag) {
        if (&drvUnbindHostPid != nullptr) {
            auto ret = drvUnbindHostPid(qsBindHostPidInfo);
            if (ret != DRV_ERROR_NONE) {
                TSD_ERROR("Call drvUnbindHostPid failed, ret[%d], hostpid[%d]", ret,
                          static_cast<int32_t>(qsBindHostPidInfo.host_pid));
                return TSD_INTERNAL_ERROR;
            }
            TSD_INFO("Unbind host pid[%d] success", static_cast<int32_t>(qsBindHostPidInfo.host_pid));
            qsBindHostPidFlag = false;
            qsBindHostPidInfo.host_pid = static_cast<pid_t>(dmPid);
            ret = drvBindHostPid(qsBindHostPidInfo);
            if (ret != DRV_ERROR_NONE) {
                TSD_ERROR("Call drvBindHostPid failed, ret[%d], hostpid[%d]", ret,
                          static_cast<int32_t>(qsBindHostPidInfo.host_pid));
                return TSD_INTERNAL_ERROR;
            }
            TSD_INFO("bind host pid[%d] success", static_cast<int32_t>(qsBindHostPidInfo.host_pid));
            qsBindHostPidFlag = true;
            return TSD_OK;
        } else {
            TSD_ERROR("drvUnbindHostPid is not found");
            return TSD_INTERNAL_ERROR;
        }
    } else {
        TSD_ERROR("No qsBindHostPidInfo before");
        return TSD_INTERNAL_ERROR;
    }
}

TSD_StatusT ProcessUtilServer::WaitPidForSubProcess(const uint32_t subProcPid, const bool isNeedReport)
{
    const uint32_t maxTimes = isNeedReport ? RETRY_TIMES : RETRY_TIMES_LONG;
    TSD_INFO("[TSDaemon] current maxTimes:[%u].", maxTimes);
    uint32_t tryTimes = 0U;
    while (tryTimes < maxTimes) {
        int32_t waitStatus = 0;
        const pid_t retPid = waitpid(static_cast<pid_t>(subProcPid), &waitStatus, WNOHANG);
        if ((tryTimes % LOG_OUT_STEP) == 0) {
            TSD_INFO("[TSDaemon] waitpid finish. retPid is [%d], subProcPid is [%u], waitStatus is [%d]",
                     retPid, subProcPid, waitStatus);
        }
        if (retPid != 0) {
            TSD_RUN_INFO("[TsdImpl] pid[%d] wait success, waitpid[%d] tryTimes[%u]",
                      subProcPid, retPid, tryTimes);
            return TSD_OK;
        }
        (void)mmSleep(RETRY_INTERVAL);
        ++tryTimes;
    }
    return TSD_INTERNAL_ERROR;
}

bool ProcessUtilServer::WaitPidOnce(const pid_t pid)
{
    bool ret = false;
    int32_t waitStatus = 0;
    const pid_t retPid = waitpid(pid, &waitStatus, WNOHANG);
    TSD_INFO("[TSDaemon] Waitpid finish, ret=%d, pid=%d, status=%d", static_cast<int32_t>(retPid),
             static_cast<int32_t>(pid), waitStatus);
    if (retPid < 0) {
        // subprocess not exist
        TSD_RUN_INFO("[TSDaemon] Waitpid subprocess does not exist, ret=%d, pid=%d, status=%d",
                     static_cast<int32_t>(retPid), static_cast<int32_t>(pid), waitStatus);
        ret = true;
    } else if (retPid == 0) {
        // subprocess unterminated
        ret = false;
    } else {
        // subprocess terminated
        TSD_RUN_INFO("[TSDaemon] Waitpid success, ret=%d, pid=%d, status=%d", static_cast<int32_t>(retPid),
                     static_cast<int32_t>(pid), waitStatus);
        ret = true;
    }

    return ret;
}

void ProcessUtilServer::KillProcessByTerm(const std::vector<uint32_t> &pidVec, const uint32_t termWaitCnt,
                                          const uint32_t sigKillWaitCnt)
{
    TSD_INFO("[TSDaemon] termWaitCnt:%u, sigKillWaitCnt:%u.", termWaitCnt, sigKillWaitCnt);
    for (const uint32_t pid : pidVec) {
        if ((pid == 0U) || (pid == 1U)) { // Skipping the Abnormal Process PID
            continue;
        }
        if (kill(static_cast<pid_t>(pid), 0) == 0) {
            TSD_INFO("[TSDaemon] find pid:%u need to be killed", pid);
            if (kill(static_cast<pid_t>(pid), SIGTERM) != 0) {
                TSD_INFO("[TSDaemon] the pid:%u to kill does not exist", pid);
                continue;
            }
            if (ProcessUtilServer::WaitSubProcPid(pid, termWaitCnt) != TSD_OK) {
                if (kill(static_cast<pid_t>(pid), SIGKILL) != 0) {
                    TSD_INFO("[TSDaemon] the pid:%u to kill does not exist", pid);
                    continue;
                }
                ProcessUtilServer::WaitSubProcPid(pid, sigKillWaitCnt);
            }
        } else {
            TSD_INFO("[TSDaemon] the pid:%u does not exist", pid);
        }
    }
}

TSD_StatusT ProcessUtilServer::WaitSubProcPid(const uint32_t subProcPid, const uint32_t waitCnt)
{
    uint32_t tryTimes = 0U;
    while (tryTimes < waitCnt) {
        int32_t waitStatus = 0;
        const pid_t retPid = waitpid(static_cast<pid_t>(subProcPid), &waitStatus, WNOHANG);
        if ((tryTimes % LOG_OUT_STEP) == 0) {
            TSD_INFO("[TSDaemon] waitpid finish. retPid is [%d], subProcPid is [%u], waitStatus is [%d]",
                     retPid, subProcPid, waitStatus);
        }
        if (retPid != 0) {
            TSD_RUN_INFO("[TsdImpl] pid[%d] wait success, waitpid[%d] tryTimes[%u]",
                         subProcPid, retPid, tryTimes);
            return TSD_OK;
        }
        (void)mmSleep(RETRY_INTERVAL);
        ++tryTimes;
    }
    return TSD_INTERNAL_ERROR;
}

TSD_StatusT ProcessUtilServer::GetNumNodeMemInfo(const std::string &numaFileName, const std::string &infoPreFix,
                                                 uint64_t &infoValue)
{
    std::ifstream fs;
    fs.open(numaFileName);
    if (!fs.is_open()) {
        TSD_RUN_WARN("open file:%s nok, error:%s", numaFileName.c_str(), strerror(errno));
        return static_cast<uint32_t>(TSD_INTERNAL_ERROR);
    }
    const ScopeGuard fileGuard([&fs] () { fs.close(); });
    std::string numaMemInfo;
    std::string inputLine;
    while (getline(fs, inputLine)) {
        if (inputLine.compare(0, infoPreFix.length(), infoPreFix) == 0) {
            numaMemInfo = std::move(inputLine);
            break;
        }
    }
    if (numaMemInfo.empty()) {
        TSD_RUN_WARN("cannot get prefix:%s info from file:%s", infoPreFix.c_str(), numaFileName.c_str());
        return static_cast<uint32_t>(TSD_INTERNAL_ERROR);
    }

    try {
        infoValue = std::stoull(numaMemInfo.substr(infoPreFix.length()));
    } catch (...) {
        TSD_RUN_WARN("parse info:%s value nok reason:%s", numaMemInfo.c_str(), strerror(errno));
        return static_cast<uint32_t>(TSD_INTERNAL_ERROR);
    }
    TSD_INFO("numafile:%s, numaMemInfo:%s, value:%llu", numaFileName.c_str(), infoPreFix.c_str(), infoValue);
    return TSD_OK;
}

bool ProcessUtilServer::IsHeterogeneousRemote()
{
#ifdef HELPER_310P
    return true;
#else
    return false;
#endif
}

bool ProcessUtilServer::Is310P()
{
#ifdef TSD_310P
    return true;
#else
    return false;
#endif
}

void ProcessUtilServer::GetProcessRunningStat(std::string &statusFile)
{
    std::ifstream ifFile(statusFile);
    if (!ifFile) {
        return;
    }
    const ScopeGuard fileGuard([&ifFile] () { ifFile.close(); });
    std::string vmRssStr;
    std::string vmHwmStr;
    std::string threadStr;
    std::string inputLine;
    while (getline(ifFile, inputLine)) {
        if (inputLine.compare(0, strlen(VM_RSS_NAME), VM_RSS_NAME) == 0) {
            vmRssStr = std::move(inputLine);
        } else if (inputLine.compare(0, strlen(VM_HWM_NAME), VM_HWM_NAME) == 0) {
            vmHwmStr = std::move(inputLine);
        } else if (inputLine.compare(0, strlen(THREADS_NAME), THREADS_NAME) == 0) {
            threadStr = std::move(inputLine);
        } else {
            continue;
        }
        if ((!vmRssStr.empty()) && (!vmHwmStr.empty()) && (!threadStr.empty())) {
            break;
        }
    }
    if ((vmRssStr.empty()) || (vmHwmStr.empty()) || (threadStr.empty())) {
        return;
    }
    uint64_t rssValue = 0UL;
    uint64_t hwmValue = 0UL;
    uint64_t threadsValue = 0UL;
    if (!TransStrToull(vmRssStr.substr(strlen(VM_RSS_NAME)), rssValue)) {
        return;
    }

    if (!TransStrToull(vmHwmStr.substr(strlen(VM_HWM_NAME)), hwmValue)) {
        return;
    }

    if (!TransStrToull(threadStr.substr(strlen(THREADS_NAME)), threadsValue)) {
        return;
    }
    TSD_RUN_INFO("vmRss:%llu KB, vmHwm:%llu KB, thread count:%llu.", rssValue, hwmValue, threadsValue);
}

void ProcessUtilServer::AddToFrameWorkGroup()
{
#ifdef ADD_FRAME_WORK_GROUP
    const std::string cmd = "cd /var/ && sudo ./tsdaemon_add_to_fwkmemory.sh " + std::to_string(getpid());
    const auto ret = PackSystem(cmd.c_str());
    if (ret != 0) {
        TSD_ERROR("Add to framework group failed. Cmd=%s, ret=%d, reason=%s.", cmd.c_str(), ret, SafeStrerror().c_str());
        return;
    }
    TSD_RUN_INFO("Add to framework group success.");
#else
    TSD_RUN_INFO("No need to add framework group.");
#endif
}

void ProcessUtilServer::LoadFileAndSetEnv(const std::string &fileName)
{
    TSD_INFO("[ProcessUtilServer] load file and set env.");
    std::fstream f;
    f.open(fileName.c_str(), std::fstream::in);
    if (!f.is_open()) {
        TSD_INFO("[ProcessUtilServer] Open config file not success.");
        return;
    }
    std::string timedLine;
    uint32_t num = 0U;
    while (getline(f, timedLine) && (num < READ_LINE_MAX_TIME)) {
        num++;
        // Skip comments and empty lines
        if (timedLine.empty()) {
            TSD_INFO("[ProcessUtilServer] Skip empty line.");
            continue;
        }
        Trim(timedLine);
        if (timedLine[0UL] == '#') {
            TSD_INFO("[ProcessUtilServer] Skip annotation line %s.", timedLine.c_str());
            continue;
        }
        const std::string bMsg("export");
        if (timedLine.rfind(bMsg, 0UL) != 0UL) {
            TSD_INFO("[ProcessUtilServer] Skip annotation line %s.", timedLine.c_str());
            continue;
        }
        timedLine = timedLine.substr(bMsg.length());
        const auto posTrenner = timedLine.find('=');
        if (posTrenner == std::string::npos) {
            TSD_INFO("[ProcessUtilServer] Skip invalid item %s", timedLine.c_str());
            continue;
        }
        std::string key = timedLine.substr(0UL, posTrenner);
        Trim(key);
        std::string envValue = timedLine.substr(posTrenner + 1UL);
        Trim(envValue);
        TSD_INFO("[ProcessUtilServer] Set [%s] to [%s].", key.c_str(), envValue.c_str());
        (void)setenv(key.c_str(), envValue.c_str(), 1);
    }
    f.close();
    TSD_INFO("[ProcessUtilServer] Finish load file and set env.");
}
bool ProcessUtilServer::IsSupportAicpuCustSafeStart()
{
#ifdef AICPU_CUST_SAFE_START
    return true;
#else
    return false;
#endif
}

bool ProcessUtilServer::IsSupportAicpuCustVfMode()
{
#ifdef TSD_VF_MODE
    TSD_RUN_INFO("IsSupportAicpuCustVfMode true");
    return true;
#else
    TSD_RUN_INFO("IsSupportAicpuCustVfMode false");
    return false;
#endif
}

bool ProcessUtilServer::IsSupportAicpuCustVDeviceMode()
{
#ifdef TSD_VDEVICE_MODE
    TSD_RUN_INFO("IsSupportAicpuCustVDeviceMode true");
    return true;
#else
    TSD_RUN_INFO("IsSupportAicpuCustVDeviceMode false");
    return false;
#endif
}

TSD_StatusT ProcessUtilServer::GetHostGrpName(std::map<std::string, GroupShareAttr> &appGroupNameList,
                                              std::string &appGroupNameStr, const uint32_t fmkPid)
{
    TSD_RUN_INFO("Start get host group name from host[%u]", fmkPid);
    const std::unique_ptr<GroupQueryOutput> groupInfoPtr(new (std::nothrow) GroupQueryOutput());
    if (groupInfoPtr == nullptr) {
        TSD_ERROR("[TSDaemon]Malloc group info ptr failed");
        return TSD_INTERNAL_ERROR;
    }

    GroupQueryOutput &groupInfoOutBuff = *(groupInfoPtr.get());
    uint32_t outLen = 0U;
    uint32_t hostPid = fmkPid;
    const auto ret = halGrpQuery(GRP_QUERY_GROUPS_OF_PROCESS, &hostPid, static_cast<uint32_t>(sizeof(hostPid)),
                                 PtrToPtr<GroupQueryOutput, void>(&groupInfoOutBuff), &outLen);
    if (ret != DRV_ERROR_NONE) {
        TSD_ERROR("[TSDaemon]Fail to query group info for pid[%u], ret[%d]", fmkPid, ret);
        return TSD_INTERNAL_ERROR;
    }
    if (outLen == 0U) {
        TSD_RUN_INFO("[TSDaemon]Current host process does not create group yet.");
        return TSD_OK;
    }
    if ((outLen % sizeof(groupInfoOutBuff.grpQueryGroupsOfProcInfo[0])) != 0UL) {
        TSD_ERROR("[TSDaemon]GroupInfo outbuff size[%u] is invalid", outLen);
        return TSD_INTERNAL_ERROR;
    }
    // 前两个异常判断后能保证groupNum>=1
    const uint32_t groupNum =
        static_cast<uint32_t>(outLen / sizeof(groupInfoOutBuff.grpQueryGroupsOfProcInfo[0]));
    for (auto i = 0U; i < groupNum; ++i) {
        const char_t * const grpName = groupInfoOutBuff.grpQueryGroupsOfProcInfo[i].groupName;
        if (grpName == nullptr) {
            TSD_ERROR("[TSDaemon]Group name from out buffer is null");
            return TSD_INTERNAL_ERROR;
        }
        const auto attachRet = TSDaemon::GetInstance()->AttachBuffGroup(grpName, 0);
        if (attachRet != TSD_OK) {
            TSD_ERROR("[TSDaemon]TSD fail to attach groupName[%s]", grpName);
            return TSD_INTERNAL_ERROR;
        }
        appGroupNameList[grpName] = groupInfoOutBuff.grpQueryGroupsOfProcInfo[i].attr;
        (void)appGroupNameStr.append(grpName).append(",");
        TSD_RUN_INFO("Get group[%s] from host[%u] success. read[%u] write[%u] alloc[%u] admin[%u]",
                        grpName, fmkPid, groupInfoOutBuff.grpQueryGroupsOfProcInfo[i].attr.read,
                        groupInfoOutBuff.grpQueryGroupsOfProcInfo[i].attr.write,
                        groupInfoOutBuff.grpQueryGroupsOfProcInfo[i].attr.alloc,
                        groupInfoOutBuff.grpQueryGroupsOfProcInfo[i].attr.admin);
    }
    if (groupNum != 0U) {
        appGroupNameStr = appGroupNameStr.substr(0U, appGroupNameStr.length() - 1U);
    }
    TSD_INFO("[TSDaemon] Generate host group name string format[%s]", appGroupNameStr.c_str());
    return TSD_OK;
}

bool ProcessUtilServer::IsValidEventType(const uint32_t eventType, const bool isCust)
{
    TsdSubEventType curType = static_cast<TsdSubEventType>(eventType);
    if (isCust) {
        auto iter = CUST_SUB_EVENT_MAP.find(curType);
        if (iter != CUST_SUB_EVENT_MAP.end()) {
            return true;
        }
        return false;
    } else {
        auto iter = NORMAL_SUB_EVENT_MAP.find(curType);
        if (iter != NORMAL_SUB_EVENT_MAP.end()) {
            return true;
        }
        return false;
    }
}

#ifdef TSD_SET_FIFO_MODE
bool ProcessUtilServer::SetShedPolicyFIFO(std::vector<pid_t> threadIdList)
{
    if (IsFpgaEnv()) {
        return true;
    }

    const int32_t SCHEDULE_PRIORITY_10 = 10;
    const size_t threadCnt = threadIdList.size();
    TSD_RUN_INFO("Begin setting the scheduler thread count:%zu.", threadCnt);
    std::vector<SetSchedulerInfo> schTask;
    for (size_t index = 0UL; index < threadCnt; index++) {
        SetSchedulerInfo tmpNode = {};
        tmpNode.threadId = threadIdList[index];
        tmpNode.policy = SCHED_FIFO;
        tmpNode.priority = SCHEDULE_PRIORITY_10;
        schTask.push_back(tmpNode);
    }
    const uint32_t ret = ProcMgrSetScheduler(schTask);
    if (ret != 0) {
        TSD_ERROR("set sched error ret:%u",  ret);
        return false;
    }
    TSD_RUN_INFO("SetSchedulerPolicy succeeded with thread count:%zu.", schTask.size());
    return true;
}
bool ProcessUtilServer::IsSupportSetFIFOMode()
{
    if (IsFpgaEnv()) {
        return false;
    }
    TSD_INFO("IsSupportAicpuCustVDeviceMode true");
    return true;
}
#else
bool ProcessUtilServer::SetShedPolicyFIFO(std::vector<pid_t> threadIdList)
{
    TSD_RUN_WARN("enter fake SetShedPolicy cnt:%zu", threadIdList.size());
    return true;
}
bool ProcessUtilServer::IsSupportSetFIFOMode()
{
    TSD_INFO("IsSupportSetFIFOMode false");
    return false;
}
#endif

#ifdef EVENT_SCH_SENDER_CHECK
bool ProcessUtilServer::CheckSubProcValid(const int32_t *subProcId, const int32_t basePid)
{
    if ((*subProcId == basePid)) {
        TSD_INFO("compare subproc success");
        return true;
    }
    uint32_t tryTimes = 0U;
    while (tryTimes < PID_SET_FINISH_MAX_TIME) {
        if ((*subProcId) == basePid) {
            TSD_INFO("check mode finish loopcnt:%u, cnt:%d", tryTimes, basePid);
            return true;
        }
        (void)mmSleep(PID_SET_FINISH_CHECK_RETRY_INTERVAL);
        ++tryTimes;
    }
    TSD_ERROR("compare subproc failed");
    return false;
}
#else
bool ProcessUtilServer::CheckSubProcValid(const int32_t *subProcId, const int32_t basePid)
{
    (void)(subProcId);
    (void)(basePid);
    TSD_INFO("check value:%u, gap:%u", PID_SET_FINISH_MAX_TIME, PID_SET_FINISH_CHECK_RETRY_INTERVAL);
    return true;
}
#endif
}  // namespace tsd