/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
 
#include "inc/thread_mode_manager.h"
#include "driver/ascend_hal.h"
#include "inc/log.h"
#include "inc/internal_api.h"
#include "env_internal_api.h"
#ifdef WIN_TSD
#else
#include "inc/package_worker.h"
#include "inc/package_worker_utils.h"
#endif

namespace {
    const uint32_t SUB_PROC_PARAM_LIST_MAX_COUNT = 128U;
    constexpr uint32_t MAX_PROCESS_PID_CNT = 1024U;
}  // namespace
namespace tsd {
ThreadModeManager::ThreadModeManager(const uint32_t &deviceId)
    : ClientManager(deviceId),
      startAicpu_(nullptr),
      stopAicpu_(nullptr),
      updateProfiling_(nullptr),
      setAicpuCallback_(nullptr),
      handle_(nullptr),
      vfId_(0),
      qsHandle_(nullptr),
      tfSoHandle_(nullptr),
      startQs_(nullptr),
      adprofHandle_(nullptr),
      startAdprof_(nullptr),
      stopAdprof_(nullptr) {}

void ThreadModeManager::OpenTfSo(const uint32_t vfId)
{
    if (tfSoHandle_ != nullptr) {
        return;
    }
    std::string homeEnv = "";
    GetEnvFromMmSys(MM_ENV_HOME, "HOME", homeEnv);
    if (homeEnv == "") {
        TSD_RUN_INFO("get HOME PATH abnormal.");
        return;
    }
    std::string tfLibraryPath =
        homeEnv + "/aicpu_kernels/" + std::to_string(vfId) + "/aicpu_kernels_device/sand_box/";
    if (access(tfLibraryPath.c_str(), R_OK) != 0) {
        TSD_RUN_INFO("access tf path %s abnormal:%s.", tfLibraryPath.c_str(), SafeStrerror().c_str());
        return;
    }
    tfLibraryPath += "libtensorflow.so";
    tfSoHandle_ = mmDlopen(tfLibraryPath.c_str(),  RTLD_GLOBAL|RTLD_NOW);
    if (tfSoHandle_ == nullptr) {
        TSD_RUN_INFO("cannot open %s: [%s]", tfLibraryPath.c_str(), dlerror());
        return;
    }
    TSD_INFO("OpenTfSo success home[%s], vfid[%u][%s]", homeEnv.c_str(), vfId, tfLibraryPath.c_str());
}

TSD_StatusT ThreadModeManager::Open(const uint32_t rankSize)
{
    TSD_RUN_INFO("[ThreadModeManager] enter into open process deviceId[%u] rankSize[%u]", logicDeviceId_, rankSize);
    const TSD_StatusT ret = LoadSysOpKernel();
    if (ret != TSD_OK) {
        TSD_ERROR("[ThreadModeManager] check aicpu opkernel failed");
        if (ret >= TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT) {
            return ret;
        }
        return TSD_CLT_OPEN_FAILED;
    }
    (void)OpenTfSo(vfId_);
    if (StartCallAICPU() != TSD_OK) {
        TSD_ERROR("[ThreadModeManager] failed call aicpu.");
        return TSD_CLT_OPEN_FAILED;
    }
    return TSD_OK;
}

TSD_StatusT ThreadModeManager::OpenAicpuSd()
{
    TSD_ERROR("[ThreadModeManager] OpenAicpuSd not support");
    return TSD_INTERNAL_ERROR;
}

TSD_StatusT ThreadModeManager::CapabilityGet(const int32_t type, const uint64_t ptr)
{
    if (type == TSD_CAPABILITY_ADPROF) {
        bool * const resultPtr = reinterpret_cast<bool *>(static_cast<uintptr_t>(ptr));
        if (resultPtr == nullptr) {
            TSD_ERROR("input ptr is null");
            return TSD_INTERNAL_ERROR;
        }
        *resultPtr = true;
    }
    return TSD_OK;
}

TSD_StatusT ThreadModeManager::StartCallAICPU()
{
    TSD_StatusT ret = TSD_OK;
    if (handle_ == nullptr) {
        const std::string libPath = "/usr/lib64/libaicpu_scheduler.so";
        handle_ = mmDlopen(libPath.c_str(), MMPA_RTLD_NOW | MMPA_RTLD_GLOBAL);
        if (handle_ == nullptr) {
            TSD_RUN_WARN("[ThreadModeManager] Can not open libaicpu_scheduler.so, deviceId[%u], reason[%s]",
                         logicDeviceId_, dlerror());
            const std::string helperPath = "libaicpu_scheduler.so";
            handle_ = mmDlopen(helperPath.c_str(), MMPA_RTLD_NOW | MMPA_RTLD_GLOBAL);
            if (handle_ == nullptr) {
                ret = TSD_INTERNAL_ERROR;
                TSD_ERROR("[ThreadModeManager] failed open libaicpu_scheduler.so, deviceId[%u], reason[%s]",
                          logicDeviceId_, dlerror());
                return ret;
            }
        }
        startAicpu_ = reinterpret_cast<StartAICPU>(mmDlsym(handle_, "InitAICPUScheduler"));
        stopAicpu_ = reinterpret_cast<StopAICPU>(mmDlsym(handle_, "StopAICPUScheduler"));
        updateProfiling_ = reinterpret_cast<UpdateProfiling>(mmDlsym(handle_, "UpdateProfilingMode"));
        setAicpuCallback_ = reinterpret_cast<SetAICPUCallback>(mmDlsym(handle_, "AicpuSetMsprofReporterCallback"));
        if ((startAicpu_ == nullptr) || (stopAicpu_ == nullptr) || (updateProfiling_ == nullptr) ||
            (setAicpuCallback_ == nullptr)) {
            TSD_ERROR("[ThreadModeManager] failed mmDlsym aicpu-sd function, deviceId[%u]", logicDeviceId_);
            return TSD_INTERNAL_ERROR;
        }
    }
    SetAICPUProfilingCallback();
#ifdef WIN_TSD
    const int32_t devicePid = static_cast<int32_t>(drvDeviceGetBareTgid());
#else
    const int32_t devicePid = static_cast<int32_t>(getpid());
#endif
    TSD_INFO("[ThreadModeManager] InitAICPUScheduler, deviceId[%u], devicePid[%d], profilingMode_[%d]", logicDeviceId_,
             devicePid, profilingMode_);
#ifdef NOT_COVERAGE_BY_UT
    const uint32_t deviceId = logicDeviceId_;
    const int32_t result = (*startAicpu_)(deviceId, devicePid, profilingMode_);
    if (result != 0) {
        ret = TSD_INTERNAL_ERROR;
        TSD_ERROR("[ThreadModeManager] failed call aicpu interface, logicDeviceId_=%u, result=%d", logicDeviceId_,
                  result);
    }
#endif
    return ret;
}

void ThreadModeManager::SetAICPUProfilingCallback() const
{
    const std::lock_guard<std::mutex> lk(g_profilingCallbackMut);
    if (g_profilingCallback == nullptr) {
        TSD_RUN_INFO("[ThreadModeManager] profiling callback is nullptr, skip set aicpu profiling callback");
        return;
    }

#ifdef NOT_COVERAGE_BY_UT
    const int32_t result = (*setAicpuCallback_)(g_profilingCallback);
    if (result != 0) {
        TSD_ERROR("[ThreadModeManager] failed call aicpu AicpuSetMsprofReporterCallback interface, "
                  "deviceId_[%u], result[%d]",
                  logicDeviceId_, result);
    }
#endif
    TSD_RUN_INFO("[ThreadModeManager] profiling callback call finish");
}

TSD_StatusT ThreadModeManager::Close(const uint32_t flag)
{
    (void)flag;
    TSD_StatusT ret = TSD_OK;
    if (handle_ == nullptr) {
        TSD_INFO("[TsdClient] don't need to stop because no start");
        return ret;
    }
#ifdef WIN_TSD
    const int32_t devicePid = static_cast<int32_t>(drvDeviceGetBareTgid());
#else
    const int32_t devicePid = static_cast<int32_t>(getpid());
#endif
    TSD_INFO("[TsdClient] StopAICPUScheduler, deviceId[%u], devicePid[%d]", logicDeviceId_, devicePid);
#ifdef NOT_COVERAGE_BY_UT
    const int32_t result = (*stopAicpu_)(logicDeviceId_, devicePid);
    if (result != 0) {
        ret = TSD_DEVICEID_ERROR;
        TSD_ERROR("[TsdClient] failed call aicpu interface, logicDeviceId=%u, result=%d", logicDeviceId_, result);
    }
#endif
    return ret;
}

TSD_StatusT ThreadModeManager::UpdateProfilingConf(const uint32_t &flag)
{
    TSD_StatusT ret = TSD_OK;
    if (handle_ == nullptr) {
        TSD_ERROR("[TsdClient] don't need to update profiling mode because no start");
        return TSD_CLT_UPDATE_PROFILING_FAILED;
    }

#ifdef NOT_COVERAGE_BY_UT
#ifdef WIN_TSD
    const int32_t devicePid = static_cast<int32_t>(drvDeviceGetBareTgid());
#else
    const int32_t devicePid = static_cast<int32_t>(getpid());
#endif
    TSD_INFO("[TsdClient] UpdateProfilingCallAICPU, logicDeviceId=%u, devicePid=%d", logicDeviceId_, devicePid);
    const int32_t result = (*updateProfiling_)(logicDeviceId_, devicePid, flag);
    if (result != 0) {
        ret = TSD_DEVICEID_ERROR;
        TSD_ERROR("[TsdClient] failed call aicpu update profiling interface, logicDeviceId=%u, result=%d",
                  logicDeviceId_, result);
    }
#endif
    return ret;
}

TSD_StatusT ThreadModeManager::LoadSysOpKernel()
{
    if (!CheckPackageExists()) {
        TSD_RUN_INFO("[TsdClient][deviceId_=%u] can not find aicpu packages", logicDeviceId_);
        return TSD_OK;
    }

    std::vector<uint32_t> packageTypes;
    packageTypes.push_back(static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL));
    packageTypes.push_back(static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL));

    TSD_StatusT ret = 0;
    for (const uint32_t packageType : packageTypes) {
        ret = HandleAICPUPackage(packageType);
        if (ret != TSD_OK) {
            TSD_ERROR("[TsdClient][deviceId_=%u] handle aicpu package to device failed, ret[%u]", logicDeviceId_, ret);
            if (ret >= TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT) {
                return ret;
            }
            return TSD_INTERNAL_ERROR;
        }
    }

    return TSD_OK;
}

TSD_StatusT ThreadModeManager::HandleAICPUPackage(const uint32_t packageType) const
{
    if (packageName_[packageType] == "") {
        TSD_RUN_INFO("[TsdClient][deviceId_=%u] package is not existed, skip send, packageType[%u]", logicDeviceId_, packageType);
        return TSD_OK;
    }

    const uint32_t vfId = static_cast<uint32_t>(vfId_);
    const std::shared_ptr<PackageWorker> worker = PackageWorker::GetInstance(logicDeviceId_, vfId);
    TSD_CHECK_NULLPTR(worker, TSD_MEMORY_EXHAUSTED, "PackageWorker is nullptr");

    const std::string srcPath = packagePath_[packageType];
    TSD_StatusT ret = TSD_OK;
    if (packageType == static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)) {
        ret = worker->LoadPackage(PackageWorkerType::PACKAGE_WORKER_AICPU_THREAD, srcPath, packageName_[packageType]);
    } else if (packageType == static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)) {
        ret = worker->LoadPackage(PackageWorkerType::PACKAGE_WORKER_EXTEND_THREAD, srcPath, packageName_[packageType]);
    }
    if (ret != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId_=%u] Load package file[%s] failed, path[%s] packageType[%u]", logicDeviceId_, 
                  packageName_[packageType].c_str(), srcPath.c_str(), packageType);
        if (ret >= TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT) {
            return ret;
        }
        return TSD_INTERNAL_ERROR;
    }

    return TSD_OK;
}

void ThreadModeManager::Destroy()
{
    if (tfSoHandle_ != nullptr) {
        (void)mmDlclose(tfSoHandle_);
        TSD_INFO("[TsdClient] close aicpu-sd so");
        tfSoHandle_ = nullptr;
    }
    if (handle_ != nullptr) {
        (void)mmDlclose(handle_);
        TSD_INFO("[TsdClient] close aicpu-sd so");
        handle_ = nullptr;
        startAicpu_ = nullptr;
        stopAicpu_ = nullptr;
        updateProfiling_ = nullptr;
        setAicpuCallback_ = nullptr;
    }
    if (qsHandle_ != nullptr) {
        (void)mmDlclose(qsHandle_);
        TSD_INFO("[TsdClient] close QS so");
        qsHandle_ = nullptr;
        startQs_ = nullptr;
    }
    if (adprofHandle_ != nullptr) {
        (void)mmDlclose(adprofHandle_);
        TSD_INFO("[TsdClient] close adporf so");
        adprofHandle_ = nullptr;
        startAdprof_ = nullptr;
        stopAdprof_ = nullptr;
    }
}

ThreadModeManager::~ThreadModeManager()
{
    Destroy();
}

TSD_StatusT ThreadModeManager::InitQs(const InitFlowGwInfo * const initInfo)
{
    (void)initInfo;
    if (StartCallQS(logicDeviceId_) != TSD_OK) {
        TSD_ERROR("[TsdClient] handle aicpu package to device failed");
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO("[TsdClient][logicDeviceId_=%u] start QS process success", logicDeviceId_);
    return TSD_OK;
}

TSD_StatusT ThreadModeManager::StartCallQS(const uint32_t logicDeviceId)
{
    TSD_StatusT ret = TSD_OK;
    if (qsHandle_ == nullptr) {
        const std::string libPath = "/usr/lib64/libqueue_schedule.so";
        qsHandle_ = mmDlopen(libPath.c_str(), MMPA_RTLD_NOW);
        if (qsHandle_ == nullptr) {
            const std::string helperPath = "libqueue_schedule.so";
            qsHandle_ = mmDlopen(helperPath.c_str(), MMPA_RTLD_NOW);
            if (qsHandle_ == nullptr) {
                ret = TSD_INTERNAL_ERROR;
                TSD_ERROR("[ThreadModeManager] failed open libqueue_schedule.so, deviceId[%u], reason[%s]",
                          logicDeviceId_, mmDlerror());
                return ret;
            }
        }
        if (mmDlsym(qsHandle_, "InitQueueScheduler") == nullptr) {
            TSD_ERROR("[TsdClient] InitQueueScheduler is nullptr, symbol lost");
        }
        startQs_ = reinterpret_cast<StartQS>(mmDlsym(qsHandle_, "InitQueueScheduler"));
        if (startQs_ == nullptr) {
            (void)mmDlclose(qsHandle_);
            qsHandle_ = nullptr;
            ret = TSD_INTERNAL_ERROR;
            TSD_ERROR("[TsdClient] failed mmDlsym QS function, logicDeviceId=%u", logicDeviceId);
            return ret;
        }
    }
#ifdef NOT_COVERAGE_BY_UT
    TSD_INFO("[TsdClient] QS Initial, logicDeviceId=%u", logicDeviceId);
    uint32_t qsReschedIntervalValue = 0U;
    std::string qsReschedInterval;
    GetEnvFromMmSys(MM_ENV_QS_RESCHED_INTEVAL, "QS_RESCHED_INTEVAL", qsReschedInterval);
    if (qsReschedInterval.empty()) {
        TSD_INFO("QS_RESCHED_INTEVAL[%s] env variable does not exist or its value is invalid",
            qsReschedInterval.c_str());
    } else {
        try {
            qsReschedIntervalValue = static_cast<uint32_t>(std::stoi(qsReschedInterval));
        } catch(...) {
            TSD_INFO("QS_RESCHED_INTEVAL[%s] env variable can not convert to uint32 value", qsReschedInterval.c_str());
        }
    }
    const int32_t result = (*startQs_)(logicDeviceId, static_cast<uint32_t>(qsReschedIntervalValue));
    if (result != 0) {
        ret = TSD_INTERNAL_ERROR;
        TSD_ERROR("[TsdClient] failed call QS interface, logicDeviceId=%u, result=%d, reschedInterval=%d",
            logicDeviceId, result, qsReschedIntervalValue);
    }
#endif
    return ret;
}

TSD_StatusT ThreadModeManager::LoadFileToDevice(const char_t *const filePath, const uint64_t pathLen,
                                                const char_t *const fileName, const uint64_t fileNameLen)
{
    (void)filePath;
    (void)pathLen;
    (void)fileName;
    (void)fileNameLen;
    return TSD_INTERNAL_ERROR;
}

TSD_StatusT ThreadModeManager::ProcessOpenSubProc(ProcOpenArgs *openArgs)
{
    if (openArgs == nullptr) {
        TSD_ERROR("openArgs is nullptr");
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO("[ThreadModeManager] enter into ProcessOpenSubProc subtype:%u",
                 static_cast<uint32_t>(openArgs->procType));
    if (openArgs->procType != TSD_SUB_PROC_ADPROF) {
        TSD_ERROR("[ThreadModeManager] not support open in thread mode, procType:%u",
                  static_cast<uint32_t>(openArgs->procType));
        return TSD_INTERNAL_ERROR;
    }
    if (adprofHandle_ == nullptr) {
        // 只传soname，LD_LIBRARY_PATH由调用者profiling侧保证
        const std::string adprofLibName = "libascend_devprof.so";
        adprofHandle_ = mmDlopen(adprofLibName.c_str(), MMPA_RTLD_NOW | MMPA_RTLD_GLOBAL);
        if (adprofHandle_ == nullptr) {
            TSD_ERROR("[ThreadModeManager] failed open libascend_devprof.so, deviceId[%u], reason[%s]",
                      logicDeviceId_, mmDlerror());
            return TSD_INTERNAL_ERROR;
        }
        if (startAdprof_ == nullptr) {
            startAdprof_ = reinterpret_cast<StartAdprof>(mmDlsym(adprofHandle_, "AdprofStart"));
            if (startAdprof_ == nullptr) {
                TSD_ERROR("[ThreadModeManager] failed mmDlsym startAdprof function, deviceId[%u], reason[%s]",
                          logicDeviceId_, mmDlerror());
                return TSD_INTERNAL_ERROR;
            }
        }
    }

    if (openArgs->extParamCnt > SUB_PROC_PARAM_LIST_MAX_COUNT) {
        TSD_ERROR("extParamList too long, extParamCnt:%u", static_cast<uint32_t>(openArgs->extParamCnt));
        return TSD_INTERNAL_ERROR;
    }
    char_t *argv[SUB_PROC_PARAM_LIST_MAX_COUNT + 1] = {nullptr};
    std::vector<std::string> extParamList;
    for (uint64_t index = 0; index < openArgs->extParamCnt; index++) {
        std::string extParam(openArgs->extParamList[index].paramInfo, openArgs->extParamList[index].paramLen);
        TSD_INFO("index:%llu, extra parameters:%s, len:%llu",
                 index, extParam.c_str(), openArgs->extParamList[index].paramLen);
        extParamList.push_back(extParam);
        argv[index] = const_cast<char *>(extParamList[index].c_str());
    }
    int32_t argc = static_cast<int32_t>(openArgs->extParamCnt);
    const int32_t result = (*startAdprof_)(argc, (const char *)(&argv[0]));
    if (result != 0) {
        TSD_ERROR("[ThreadModeManager] failed call startAdprof logicDeviceId_=%u, result=%d", logicDeviceId_,
                  result);
        return TSD_INTERNAL_ERROR;
    }

    return TSD_OK;
}

TSD_StatusT ThreadModeManager::ProcessCloseSubProc(const pid_t closePid)
{
    (void)closePid;
    return TSD_INTERNAL_ERROR;
}

TSD_StatusT ThreadModeManager::GetSubProcStatus(ProcStatusInfo *pidInfo, const uint32_t arrayLen)
{
    (void)pidInfo;
    (void)arrayLen;
    return TSD_INTERNAL_ERROR;
}

TSD_StatusT ThreadModeManager::RemoveFileOnDevice(const char_t *const filePath, const uint64_t pathLen)
{
    (void)filePath;
    (void)pathLen;
    return TSD_INTERNAL_ERROR;
}

TSD_StatusT ThreadModeManager::NotifyPmToStartTsdaemon()
{
    return TSD_INTERNAL_ERROR;
}

TSD_StatusT ThreadModeManager::ProcessCloseSubProcList(const ProcStatusParam *closeList, const uint32_t listSize)
{
    if ((listSize == 0U) || (closeList == nullptr)) {
        TSD_ERROR("[ThreadModeManager]closeList is nullptr or pid list size invalid:%u", listSize);
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO("[ThreadModeManager] enter ExecuteClosePidList cnt:%u, procType:%u", listSize, closeList[0].procType);
    if (closeList[0].procType != TSD_SUB_PROC_ADPROF) {
        TSD_ERROR("[ThreadModeManager]not support close in thread mode, procType:%u",
                  static_cast<uint32_t>(closeList[0].procType));
        return TSD_INTERNAL_ERROR;
    }

    if (adprofHandle_ == nullptr) {
        TSD_RUN_INFO("[ThreadModeManager] don't need to stop because no start");
        return TSD_OK;
    }

    if (stopAdprof_ == nullptr) {
        stopAdprof_ = reinterpret_cast<StopAdprof>(mmDlsym(adprofHandle_, "AdprofStop"));
        if (stopAdprof_ == nullptr) {
            TSD_ERROR("[ThreadModeManager] failed mmDlsym stopAdprof function, deviceId[%u]", logicDeviceId_);
            return TSD_INTERNAL_ERROR;
        }
    }

    TSD_INFO("[ThreadModeManager] stopAdprof, deviceId[%u]", logicDeviceId_);
    const int32_t result = (*stopAdprof_)();
    if (result != 0) {
        TSD_ERROR("[ThreadModeManager] failed call stopAdprof logicDeviceId_=%u, result=%d", logicDeviceId_,
                  result);
        return TSD_INTERNAL_ERROR;
    }

    return TSD_OK;
}

TSD_StatusT ThreadModeManager::GetSubProcListStatus(ProcStatusParam *pidInfo, const uint32_t arrayLen)
{
    if ((pidInfo == nullptr) || (arrayLen == 0U) || (arrayLen > MAX_PROCESS_PID_CNT)) {
        TSD_ERROR("input param is error");
        return TSD_INTERNAL_ERROR;
    }

    TSD_RUN_INFO("[ThreadModeManager] enter into GetSubProcListStatus, arrayLen:%u, procType:%u",
                 arrayLen, pidInfo[0].procType);
    if (pidInfo[0].procType == TSD_SUB_PROC_ADPROF) {
        pidInfo[0].curStat = SUB_PROCESS_STATUS_NORMAL;
    }

    return TSD_OK;
}
TSD_StatusT ThreadModeManager::CloseNetService()
{
    return TSD_CLOSE_NOT_SUPPORT_NET_SERVICE;
}
TSD_StatusT ThreadModeManager::OpenNetService(const NetServiceOpenArgs *args)
{
    return TSD_OPEN_NOT_SUPPORT_NET_SERVICE;
}
}  // namespace tsd
