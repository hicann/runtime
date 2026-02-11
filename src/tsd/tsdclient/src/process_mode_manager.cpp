/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inc/process_mode_manager.h"
#include <sstream>
#include <fstream>
#include <iostream>
#include <string>
#include <regex>
#include <chrono>
#include <sys/file.h>
#include <dlfcn.h>
#include "driver/ascend_hal.h"
#include "error_manager.h"
#include "inc/log.h"
#include "inc/tsd_util.h"
#include "inc/weak_log.h"
#include "driver/ascend_inpackage_hal.h"
#include "tsd/status.h"
#include "inc/weak_ascend_hal.h"
#include "inc/internal_api.h"
#include "env_internal_api.h"
#include "inc/package_process_config.h"
#include "inc/process_util_common.h"

namespace {
// 每个OS上的1980芯片数目,每个芯片上每一种类型的进程都要创建一个，所以以芯片数为依据
constexpr uint32_t PER_OS_CHIP_NUM(4U);
constexpr uint32_t DEFAULT_QS_RANKSIZE = 0U;
const std::string TSDAEMON_HOST_NAME = "/var/tsdaemon";
const std::string RUNTIME_PKG_NAME = "Ascend-runtime_device-minios.tar.gz";
const std::string DSHAPE_PKG_NAME = "Ascend-opp_rt-minios.aarch64.tar.gz";
const std::string UDF_PKG_NAME = "cann-udf-compat.tar.gz";
const std::string HCCD_PKG_NAME = "cann-hccd-compat.tar.gz";
constexpr uint32_t COMMON_SUPPORT_TIMEOUT = 10000U;
constexpr uint32_t OMFILE_LOAD_TIMEOUT = 200000U;
constexpr uint32_t HELPER_PKG_LOAD_TIMEOUT = 10000U;
constexpr uint64_t HELPER_INPUT_MAX_FILE_PATH_LEN = 4096UL;
constexpr uint64_t HELPER_INPUT_MAX_FILE_NAME_LEN = 256UL;
constexpr uint64_t PROCESS_OPEN_MAX_ENV_CNT = 128UL;
constexpr uint64_t PROCESS_OPEN_MAX_EXT_PARAM_CNT = 128UL;
constexpr uint64_t TSD_SUPPORT_OM_INNER_DEC = 1UL;
constexpr uint64_t TSD_NOT_SUPPORT_OM_INNER_DEC = 0UL;
constexpr uint32_t SUPPORT_OM_INNER_DEC_MSG_TIMEOUT = 10000U;
constexpr uint32_t ASAN_OPEN_TIMEOUT = 3600000U; // 1hour
const std::string TSDEMON_START_APP = "TSDaemon";
constexpr int32_t TSD_START_TIMEOUT = 5000;
constexpr uint32_t MAX_PROCESS_PID_CNT = 1024U;
constexpr uint32_t CLOSE_PID_PER_LOOP = 50U;
const std::string START_APP_SO = "/usr/lib64/libgroup_client.so";
const std::string DRIVER_EXTEND_PKG_NAME = "Ascend-device-sw-plugin.tar.gz";
constexpr uint32_t DRIVER_EXTEND_MAX_PROCESS_TIME = 140U;
const std::string QUEUE_SCHEDULE_SO = "libqueue_schedule.so";
constexpr uint32_t INVALID_NUMBER = 0xffffffffU;
constexpr uint32_t DEFUALT_NET_SERVICE = 2U;
const std::map<std::string, std::vector<tsd::ChipType_t>> PKG_CHIP_SUPPORT_MAP = {
    {"aicpu_hccl.tar.gz", {tsd::CHIP_ASCEND_910B, tsd::CHIP_ASCEND_950, tsd::CHIP_CLOUD_V5}},
    {"aicpu_hcomm.tar.gz", {tsd::CHIP_DC, tsd::CHIP_ASCEND_910B, tsd::CHIP_ASCEND_950, tsd::CHIP_CLOUD_V5}},
    {"cann-hcomm-compat.tar.gz", {tsd::CHIP_ASCEND_910B, tsd::CHIP_ASCEND_950, tsd::CHIP_CLOUD_V5}},
    {HCCD_PKG_NAME, {tsd::CHIP_ASCEND_910B}},
    {"cann-tsch-compat.tar.gz", {tsd::CHIP_ASCEND_910B}},
    {UDF_PKG_NAME, {tsd::CHIP_ASCEND_910B}}
};
const int64_t SUPPORT_MAX_DEVICE_PER_HOST = 8;
const std::string MUTEX_FILE_PREFIX = "sink_file_mutex_";
using TimePoint = std::chrono::high_resolution_clock::time_point;
}  // namespace

namespace tsd {
TSD_StatusT ProcessModeManager::Open(const uint32_t rankSize)
{
    if (IsAdcEnv()) {
        TSD_INFO("skip to start aicpu-sd process.");
        return TSD_OPEN_NOT_SUPPORT_FOR_ADC; // depend on runtime defined
    }
    return OpenProcess(rankSize);
}

TSD_StatusT ProcessModeManager::OpenAicpuSd()
{
    return OpenProcess(0U);
}

TSD_StatusT ProcessModeManager::OpenProcess(const uint32_t rankSize)
{
    TSD_RUN_INFO("[ProcessModeManager] enter into open process deviceId[%u] rankSize[%u]", logicDeviceId_, rankSize);
    TsdStartStatusInfo startInfo = { };
    const TimePoint beginOpen = std::chrono::high_resolution_clock::now();
    if (!CheckNeedToOpen(rankSize, startInfo)) {
        TSD_INFO("Open has already done before.");
        return TSD_OK;
    }

    LoadPackageConfigInfoToDevice();
    const TimePoint finLoadCfg = std::chrono::high_resolution_clock::now();

    TSD_StatusT ret = LoadSysOpKernel();
    TSD_CHECK(ret == TSD_OK, ret, "Send aicpu package to device failed.");
    const TimePoint finLoadOpKernel = std::chrono::high_resolution_clock::now();

    ret = LoadPackageToDeviceByConfig();
    TSD_CHECK(ret == TSD_OK, ret, "load package to device by config failed");
    const TimePoint finLoadSinkPkg = std::chrono::high_resolution_clock::now();

    ret = InitTsdClient();
    TSD_CHECK(ret == TSD_OK, ret, "Init hdc client failed.");
    startInfo.startQs_ = false;
    ret = SendOpenMsg(rankSize, startInfo);
    TSD_CHECK(ret == TSD_OK, ret, "Send open message to device failed.");
    const TimePoint finSendOpenMsg = std::chrono::high_resolution_clock::now();

    TSD_RUN_INFO("[ProcessModeManager] deviceId[%u] sessionId[%u] rankSize[%u], wait subprocess start response", logicDeviceId_, tsdSessionId_, rankSize);
    if (IsAsanMmSysEnv()) {
        ret = WaitRsp(ASAN_OPEN_TIMEOUT);
    } else {
        ret = WaitRsp(0U);
    }
    const TimePoint finRecvRsp = std::chrono::high_resolution_clock::now();
    if (ret != TSD_OK) {
        REPORT_INPUT_ERROR("E39007", std::vector<std::string>(), std::vector<std::string>());
        TSD_ERROR("Wait open response from device failed.");
        return ret;
    }
    SetTsdStartInfo(startInfo.startCp_, startInfo.startHccp_, false);

    ret = ProcessQueueForAdc();
    if (ret != TSD_OK) {
        TSD_ERROR("ProcessQueueForAdc error");
        return ret;
    }
    const TimePoint finOpen = std::chrono::high_resolution_clock::now();
    TSD_RUN_INFO("[TsdClient][deviceId=%u] [sessionId=%u] start hccp and computer process success,"
        "whole process spent time as follows:"
        "phase1:[%zu]ms load sink package config to device,"
        "phase2:[%zu]ms load opkernel to device,"
        "phase3:[%zu]ms load sink package to device,"
        "phase4:[%zu]ms send open message to device,"
        "phase5:[%zu]ms receive open message to device,"
        "phase6:[%zu]ms process for adc on host,"
        "whole duration:[%zu]ms",
        logicDeviceId_,
        tsdSessionId_,
        std::chrono::duration_cast<std::chrono::milliseconds>(finLoadCfg - beginOpen).count(),
        std::chrono::duration_cast<std::chrono::milliseconds>(finLoadOpKernel - finLoadCfg).count(),
        std::chrono::duration_cast<std::chrono::milliseconds>(finLoadSinkPkg - finLoadOpKernel).count(),
        std::chrono::duration_cast<std::chrono::milliseconds>(finSendOpenMsg - finLoadSinkPkg).count(),
        std::chrono::duration_cast<std::chrono::milliseconds>(finRecvRsp - finSendOpenMsg).count(),
        std::chrono::duration_cast<std::chrono::milliseconds>(finOpen - finRecvRsp).count(),
        std::chrono::duration_cast<std::chrono::milliseconds>(finOpen - beginOpen).count()
    );

    return TSD_OK;
}

TSD_StatusT ProcessModeManager::ConstructCloseMsg(HDCMessage &msg)
{
    msg.set_device_id(logicDeviceId_ % PER_OS_CHIP_NUM);
    // 传递真实的deviceId在回调的时候做校验使用,替代reqId
    msg.set_real_device_id(logicDeviceId_);
    msg.set_type(HDCMessage::TSD_CLOSE_PROC_MSG);
    msg.set_rank_size(rankSize_);
    // protobuf method, no need check null
    ProcessSignPid * const signPid = msg.mutable_proc_sign_pid();
    if (signPid == nullptr) {
        TSD_ERROR("protobuf new pidSign error");
        return TSD_INTERNAL_ERROR;
    }
    signPid->set_proc_pid(static_cast<uint32_t>(procSign_.tgid));
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::Close(const uint32_t flag)
{
    if (!initFlag_) {
        TSD_RUN_INFO("[TsdClient] tsd client no need to close");
        return TSD_OK;
    }
    // check hdcTsdClient_
    TSD_CHECK_NULLPTR(hdcTsdClient_, TSD_INSTANCE_NOT_INITIALED, "[TsdClient] hdcTsdClient_ is null in Close function");
    TsdCloseFlag tsdCloseFlag = {};
    ParseTsdCloseFlag(flag, tsdCloseFlag);
    if (tsdCloseFlag.quickCloseFlag != ProcessModeManager::QUICK_CLOSE_MODE) {
        TSD_RUN_INFO(
            "[TsdClient] Close [deviceId=%u][sessionId=%u] hccp and computer enter", logicDeviceId_, tsdSessionId_);
        TSD_StatusT ret = SendCloseMsg();
        TSD_CHECK(ret == TSD_OK, ret, "Send close message to device failed.");
        TSD_RUN_INFO("[TsdClient][deviceId=%u] [sessionId=%u] wait hccp and computer process close response",
            logicDeviceId_, tsdSessionId_);
        ret = WaitRsp(0U, false, true);
        TSD_CHECK(ret == TSD_OK, ret, "Wait open response from device failed.");
        TSD_RUN_INFO("[TsdClient][logicDeviceId_=%u]has recv close hccp and computer process response", logicDeviceId_);
    } else {
        TSD_RUN_INFO("Enable quick tsd close, close will only in host.");
    }

    hdcTsdClient_->Destroy();
    hdcTsdClient_ = nullptr;
    rspCode_ = ResponseCode::FAIL;
    initFlag_ = false;
    isStartedHccp_ = false;
    hccpPid_ = 0;
    SetTsdStartInfo(false, false, false);
    aicpuPackageExistInDevice_ = false;
    TSD_RUN_INFO("[TsdClient][deviceId=%u] [sessionId=%u] close hccp and "
                 "computer process success", logicDeviceId_, tsdSessionId_);
    return TSD_OK;
}

bool ProcessModeManager::IsSupportCommonSink()
{
    if (!hasGetHostSoPath_) {
        hostSoPath_ = GetHostSoPath();
        hasGetHostSoPath_ = true;
    }

    if (!hostSoPath_.empty()) {
        const std::string mutexFile = hostSoPath_ + MUTEX_FILE_PREFIX + "0.cfg";
        if (CheckRealPath(mutexFile)) {
            TSD_RUN_INFO("mutexFile[%s] found means supporting common sink", mutexFile.c_str());
            return true;
        }
    }

    TSD_INFO("hostSoPath is %s.", hostSoPath_.c_str());
    return IsSupportCommonInterface(TSD_SUPPORT_COMMON_SINK_PKG_CONFIG);
}

TSD_StatusT ProcessModeManager::LoadSysOpKernel()
{
    bool loadAicpuKernelFlag = true;
    if (IsSupportCommonSink()) {
        std::string packageTitle;
        (void)GetPackageTitle(packageTitle);
        std::string pkgName = packageTitle + "-aicpu_legacy.tar.gz";
        PackageProcessConfig *pkgConInst = PackageProcessConfig::GetInstance();
        if (!pkgConInst->GetPackageHostTruePath(pkgName).empty()) {
            TSD_RUN_INFO("[TsdClient][logicDeviceId_=%u] use legacy package", logicDeviceId_);
            loadAicpuKernelFlag = false;
        }
    }
    if (!CheckPackageExists(loadAicpuKernelFlag)) {
        TSD_RUN_INFO("[TsdClient][logicDeviceId_=%u] can not find aicpu packages", logicDeviceId_);
        return TSD_OK;
    }

    TSD_StatusT ret = GetDeviceCheckCode();
    if (ret == TSD_AICPUPACKAGE_EXISTED) {
        return TSD_OK;
    }
    if (ret != TSD_OK) {
        if (ret >= TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT) {
            return ret;
        }
        return TSD_DEVICEID_ERROR;
    }

    // if find package in process offline mode, just ignore following operation
    if (GetPlatInfoMode() == static_cast<uint32_t>(ModeType::OFFLINE)) {
        TSD_RUN_INFO("[TsdClient]in process offline mode, ignore send any package!");
        return TSD_OK;
    }

    constexpr int32_t peerNode = 0;
    constexpr uint32_t hdcNameMax = 256U;
    char_t path[hdcNameMax] = { };
    const int32_t drvRet = drvHdcGetTrustedBasePath(peerNode, static_cast<int32_t>(logicDeviceId_), &path[0], hdcNameMax);
    if (drvRet != DRV_ERROR_NONE) {
        TSD_ERROR("[TsdClient][deviceId_=%u] drvHdcGetTrustedBasePath failed, ret[%d]", logicDeviceId_, drvRet);
        return TSD_INTERNAL_ERROR;
    }

    // send aicpu ops package to device through hdc channel
    ret = SendAICPUPackage(peerNode, std::string(path));
    if (ret != TSD_OK) {
        REPORT_INPUT_ERROR("E39006", std::vector<std::string>(), std::vector<std::string>());
        TSD_ERROR("[TsdClient][deviceId=%u] send aicpu package to device failed", logicDeviceId_);
        return ret;
    }

    // send extend ops package to device through hdc channel
    ret = SendCommonPackage(peerNode, std::string(path), static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL));
    if (ret != TSD_OK) {
        REPORT_INPUT_ERROR("E39006", std::vector<std::string>(), std::vector<std::string>());
        TSD_ERROR("[TsdClient][deviceId=%u] send extend package to device failed", logicDeviceId_);
        return ret;
    }

    // send ascendcpp ops package to device through hdc channel
    ret = SendCommonPackage(peerNode, std::string(path), static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP));
    if (ret != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId=%u] send ascendcpp package to device failed", logicDeviceId_);
        return ret;
    }
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::WaitRsp(const uint32_t timeout, const bool ignoreRecvErr, const bool isClose)
{
    const TSD_StatusT ret = hdcTsdClient_->TsdRecvData(tsdSessionId_, ignoreRecvErr, timeout);
    // 针对close消息，如果对端已经关闭了通道，则证明消息已经发送，如果没有收到此消息也按照成功处理
    if (!IsAdcEnv()) {
        if (isClose && (ret == TSD_HDC_SERVER_CLIENT_SOCKET_CLOSED)) {
            TSD_RUN_INFO("close rsp not receive, server close the session");
            return TSD_OK;
        }
    }

    if ((ret != TSD_OK) || (static_cast<uint32_t>(rspCode_) != 0U)) {
        std::ostringstream reportMsg;
        reportMsg << "tsd client wait response fail, hostpid:" << static_cast<uint32_t>(procSign_.tgid);
        if (ret != TSD_OK) {
            reportMsg << ", receive device response data failed, check hdc service.";
        } else {
            reportMsg << ", device response code[" << static_cast<uint32_t>(rspCode_) << "]";
            if (!errMsg_.empty()) {
                reportMsg << ". " << errMsg_;
                reportMsg << ", error stack:\n" << errorLog_;
            } else {
                reportMsg << ". unknown device error.";
            }
            if (!startOrStopFailCode_.empty()) {
                REPORT_INPUT_ERROR(startOrStopFailCode_.c_str(), std::vector<std::string>(),
                                   std::vector<std::string>());
            }
        }
        if (!ignoreRecvErr) {
            TSD_ERROR("%s", reportMsg.str().c_str());
            TSD_REPORT_INNER_ERROR("%s", reportMsg.str().c_str());
        }
        if (startOrStopFailCode_ == "E30003") {
            return TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT;
        } else if (startOrStopFailCode_ == "E30004") {
            return TSD_SUBPROCESS_BINARY_FILE_DAMAGED;
        } else if (startOrStopFailCode_ == "E30006") {
            return TSD_VERIFY_OPP_FAIL;
        } else if (startOrStopFailCode_ == "E30007") {
            return TSD_ADD_AICPUSD_TO_CGROUP_FAILED;
        } else {
            return TSD_CLT_OPEN_FAILED;
        }
    }

    return TSD_OK;
}

TSD_StatusT ProcessModeManager::SendAICPUPackageSimple(const int32_t peerNode, const std::string &orgFile,
                                                       const std::string &dstFile, bool useCannPath)
{
    TSD_RUN_INFO("[TsdClient][deviceId=%u] no equal to begin send file[%s] to [%s]", logicDeviceId_,
                 orgFile.c_str(), dstFile.c_str());
    if (useCannPath) {
        const auto ret = drvHdcSendFileV2(peerNode, static_cast<int32_t>(logicDeviceId_), orgFile.c_str(),
                                          dstFile.c_str(), nullptr);
        if (ret != DRV_ERROR_NONE) {
            TSD_ERROR("[TsdClient][deviceId=%u] drvHdcSendFile file[%s] to [%s] failed ret = %d",
                    logicDeviceId_, orgFile.c_str(), dstFile.c_str(), ret);
            return TSD_INTERNAL_ERROR;
        }
    } else {
        const auto ret = drvHdcSendFile(peerNode, static_cast<int32_t>(logicDeviceId_), orgFile.c_str(),
                                        dstFile.c_str(), nullptr);
        if (ret != DRV_ERROR_NONE) {
            TSD_ERROR("[TsdClient][deviceId=%u] drvHdcSendFile file[%s] to [%s] failed ret = %d",
                    logicDeviceId_, orgFile.c_str(), dstFile.c_str(), ret);
            return TSD_INTERNAL_ERROR;
        }
    }
    
    TSD_RUN_INFO("[TsdClient][deviceId=%u] hdc send file[%s] to [%s] success", logicDeviceId_, orgFile.c_str(),
             dstFile.c_str());
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::SendMsgAndHostPackage(const int32_t peerNode, const std::string &orgFile,
                                                      const std::string &dstFile, HDCMessage &msg,
                                                      const std::function<bool(void)> &compareCallBack,
                                                      bool useCannPath)
{
    msg.set_wait_flag(false);
    TSD_StatusT ret = GetDeviceCheckCodeRetry(msg);
    if (ret != TSD_OK) {
        if (ret >= TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT) {
            return ret;
        }
        return TSD_INTERNAL_ERROR;
    }
    if (compareCallBack()) {
        TSD_INFO("host check and compare to device, no need to load package");
        return TSD_OK;
    }

    if (SendAICPUPackageSimple(peerNode, orgFile, dstFile, useCannPath) != TSD_OK) {
        return TSD_INTERNAL_ERROR;
    }

    msg.set_wait_flag(true);
    ret = GetDeviceCheckCodeRetry(msg);
    if (ret != TSD_OK) {
        if (ret >= TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT) {
            return ret;
        }
        return TSD_INTERNAL_ERROR;
    }

    return TSD_OK;
}
TSD_StatusT ProcessModeManager::SendHostPackageComplex(const int32_t peerNode, const std::string &orgFile,
                                                       const std::string &dstFile, HDCMessage &msg,
                                                       const std::function<bool(void)> &compareCallBack,
                                                       bool useCannPath)
{
    if (!hasGetHostSoPath_) {
        hostSoPath_ = GetHostSoPath();
        hasGetHostSoPath_ = true;
    }

    if (hostSoPath_ == "") {
        return SendMsgAndHostPackage(peerNode, orgFile, dstFile, msg, compareCallBack, useCannPath);
    }
    const std::string mutexFileName = GetCurHostMutexFile(useCannPath);
    const std::string mutexFile = hostSoPath_ + mutexFileName;
    TSD_RUN_INFO("get host mutex file:%s, logicDeviceId:%u", mutexFile.c_str(), logicDeviceId_);
    if (!CheckRealPath(mutexFile)) {
        TSD_INFO("Can not get realpath of mutexFile[%s]", mutexFile.c_str());
        return SendMsgAndHostPackage(peerNode, orgFile, dstFile, msg, compareCallBack, useCannPath);
    }
    const int32_t fileData = open(mutexFile.c_str(), O_RDONLY);
    if (fileData < 0) {
        TSD_INFO("Open qs so not success [%s], strerror[%s]", mutexFile.c_str(), SafeStrerror().c_str());
        return SendMsgAndHostPackage(peerNode, orgFile, dstFile, msg, compareCallBack, useCannPath);
    } else {
        TSD_INFO("Open qs so [%s] success", mutexFile.c_str());
    }
    /*
    * The purpose of adding a file lock is to ensure the serial loading of packages,
    * so as to avoid excessive consumption of device memory caused by the concurrent send of packages.
    * The mounted file system does not support file lock, so the behaviour of this function is degraded to
    * concurrent execution.
    */
    const ScopeGuard fileDataGuard([&fileData]() { (void)close(fileData); });
    const uint64_t beginTime = GetCurrentTime();
    const int32_t flockRet = flock(fileData, LOCK_EX);
    if (flockRet == -1) {
        TSD_RUN_WARN("File lock is not success, ret[%d], errno[%d], strerror[%s] ",
                     flockRet, errno, SafeStrerror().c_str());
    }

    // guard file lock
    const ScopeGuard fileLockGuard([&fileData]() { (void)flock(fileData, LOCK_UN); });
    const uint64_t endTime = GetCurrentTime();
    if ((endTime - beginTime) >= (HDC_CLIENT_WAIT_TIMEOUT_MS + OPEN_PKT_DEL_WAIT_TIMEOUT_MS) * MS_TO_NS) {
        TSD_RUN_INFO("Other process has sent aicpu package to device, skip");
        return TSD_OK;
    }
    return SendMsgAndHostPackage(peerNode, orgFile, dstFile, msg, compareCallBack, useCannPath);
}

TSD_StatusT ProcessModeManager::SendAICPUPackage(const int32_t peerNode, const std::string &path)
{
    const uint32_t packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL);
    if (packageName_[packageType] == "") {
        TSD_RUN_INFO("[TsdClient][deviceId_=%u] aicpu package is not existed, skip send package", logicDeviceId_);
        return TSD_OK;
    }

    // check aicpu need to send
    if (packageHostCheckCode_[packageType] == packagePeerCheckCode_[packageType]) {
        TSD_RUN_INFO("[TsdClient][deviceId_=%u] the checksum of host package[%u] is the same as device[%u], skip send package.",
                     logicDeviceId_, packageHostCheckCode_[packageType], packagePeerCheckCode_[packageType]);
        return TSD_OK;
    }

    const std::string orgFile = packagePath_[packageType] + packageName_[packageType];
    const std::string dstFile = std::string(path) + "/" + std::to_string(procSign_.tgid) + "_" + packageName_[packageType];
    if ((!getCheckCodeRetrySupport_) || (IsAsanMmSysEnv()) || (IsFpgaMmSysEnv())) {
        return SendAICPUPackageSimple(peerNode, orgFile, dstFile, false);
    } else {
        HDCMessage msg;
        msg.set_real_device_id(logicDeviceId_);
        msg.set_type(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
        msg.set_check_code(packageHostCheckCode_[packageType]);
        msg.set_package_type(packageType);
        auto aicpuPkgCompareMethd = [this]() {
            if (this->packageHostCheckCode_[packageType] == this->packagePeerCheckCode_[packageType]) {
                TSD_INFO("[TsdClient] after lock, the checksum of aicpu package[%u] is same as device[%u], skip send",
                    this->packageHostCheckCode_[packageType], this->packagePeerCheckCode_[packageType]);
                return true;
            }
            return false;
        };
        return SendHostPackageComplex(peerNode, orgFile, dstFile, msg, aicpuPkgCompareMethd, false);
    }
}

TSD_StatusT ProcessModeManager::InitTsdClient()
{
    // tsd支持重入，如果实例已经初始化过则不需要再次初始化，使用初始化过的sessionId发送数据
    if (initFlag_) {
        TSD_INFO("[TsdClient] tsd client has been inited before");
        return TSD_OK;
    }
    // 获取当前进程号，通过驱动接口可以区分容器 虚拟机 hostpid会有相同的情况
    const drvError_t ret = drvGetProcessSign(&procSign_);
    if ((ret != DRV_ERROR_NONE)) {
        TSD_ERROR("driver get process sign failed. ret[%d].", ret);
        return TSD_CLT_OPEN_FAILED;
    }
    TSD_INFO("[TsdClient][deviceId=%u] get process sign success, procPid[%u]", logicDeviceId_,
             static_cast<uint32_t>(procSign_.tgid));

    if (logicDeviceId_ >= MAX_DEVNUM_PER_HOST) {
        TSD_ERROR("[TsdClient] deviceId[%u] is not supported, not in [0-127] exit open function",
                  logicDeviceId_);
        return TSD_DEVICEID_ERROR;
    }
    TSD_RUN_INFO("[TsdClient] deviceId[%u] begin to init hdc client", logicDeviceId_);
    hdcTsdClient_ = HdcClient::GetInstance(logicDeviceId_, HDCServiceType::TSD);
    TSD_CHECK_NULLPTR(hdcTsdClient_, TSD_INSTANCE_NOT_FOUND, "[TsdClient] hdcTsdClient_ is null in Open function");
    TSD_StatusT hdcRet = hdcTsdClient_->Init(static_cast<uint32_t>(procSign_.tgid), IsAdcEnv());
    if (hdcRet != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId=%u] Init tsdclient failed in Open function", logicDeviceId_);
        return hdcRet;
    }
    uint32_t sessionId = 0U;
    hdcRet = hdcTsdClient_->CreateHdcSession(sessionId);
    if (hdcRet != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId=%u]CreateSession for TSD failed in Open function", logicDeviceId_);
        if (hdcRet == DRV_ERROR_REPEATED_INIT) {
            // External error codes will only be convertes intp internal error codes when the tsdclinet supports the new error codes. Replace error code E30005 with E39009
            REPORT_INPUT_ERROR("E39009", std::vector<std::string>(), std::vector<std::string>());
        } else if (hdcRet == DRV_ERROR_REMOTE_NOT_LISTEN) {
            REPORT_INPUT_ERROR("E39005", std::vector<std::string>(), std::vector<std::string>());
        }
        return TSD_HDC_CREATE_SESSION_FAILED;
    }
    tsdSessionId_ = sessionId;
    initFlag_ = true;
    return hdcRet;
}

TSD_StatusT ProcessModeManager::ConstructOpenMsg(HDCMessage &hdcMsg, const TsdStartStatusInfo &startInfo)
{
    hdcMsg.set_rank_size(rankSize_);
    hdcMsg.set_start_hccp(startInfo.startHccp_);
    hdcMsg.set_start_cp(startInfo.startCp_);
    hdcMsg.set_profiling_mode(static_cast<uint32_t>(profilingMode_));
    hdcMsg.set_device_id(logicDeviceId_ % PER_OS_CHIP_NUM);
    // method from protobuf, no need check null
    LogLevel * const level = hdcMsg.mutable_log_level();
    if (level == nullptr) {
        TSD_ERROR("mutable log level error");
        return TSD_INTERNAL_ERROR;
    }
    level->set_log_level(logLevel_);
    CcecpuLogLevel * const ccecpuLogLevel = hdcMsg.mutable_ccecpu_log_level();
    if (ccecpuLogLevel != nullptr) {
        ccecpuLogLevel->set_ccecpu_log_level(ccecpuLogLevel_);
    }
    AicpuLogLevel * const aicpuLogLevel = hdcMsg.mutable_aicpu_log_level();
    if (aicpuLogLevel != nullptr) {
        aicpuLogLevel->set_aicpu_log_level(aicpuLogLevel_);
    }
    // 传递真实的deviceId在回调的时候做校验使用,替代reqId
    hdcMsg.set_real_device_id(logicDeviceId_);
    // method from protobuf, no need check null
    ProcessSignPid * const proSignPid = hdcMsg.mutable_proc_sign_pid();
    if (proSignPid == nullptr) {
        TSD_ERROR("mutable proSignPid error");
        return TSD_INTERNAL_ERROR;
    }
    proSignPid->set_proc_pid(static_cast<uint32_t>(procSign_.tgid));
    const std::string signStr(procSign_.sign);
    proSignPid->set_proc_sign(signStr);
    TSD_RUN_INFO("[TsdClient] tsd get process sign successfully, procpid[%u] signSize[%u]",
              static_cast<uint32_t>(procSign_.tgid), signStr.length());
    hdcMsg.set_check_code(packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL)]);
    hdcMsg.set_extendpkg_check_code(
            packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)]);
    hdcMsg.set_ascendcpppkg_check_code(
            packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP)]);
    hdcMsg.set_type(HDCMessage::TSD_START_PROC_MSG);
    hdcMsg.set_device_mode(aicpuDeviceMode_);
    hdcMsg.set_aicpu_sched_mode(static_cast<uint32_t>(aicpuSchedMode_));
    uint32_t tsdclientCapabilityLevel = SetTsdClientCapabilityLevel();
    hdcMsg.set_tsdclient_capability_level(tsdclientCapabilityLevel);
    std::string aicpuPath;
    GetEnvFromMmSys(MM_ENV_ASCEND_AICPU_PATH, "ASCEND_AICPU_PATH", aicpuPath);
    // method from protobuf, no need check null
    AscendAicpuPath * const ascendAicpuPath = hdcMsg.mutable_ascend_aicpu_path();
    if (ascendAicpuPath == nullptr) {
        TSD_ERROR("mutable ascend aicpu path error");
        return TSD_INTERNAL_ERROR;
    }
    ascendAicpuPath->set_ascend_aicpu_path(aicpuPath);
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::SendOpenMsg(const uint32_t rankSize, const TsdStartStatusInfo startInfo)
{
    rankSize_ = rankSize;
    // 当TSDClient连接成功后向TSDaemon发送拉起命令
    HDCMessage hdcMsg;
    if (ConstructOpenMsg(hdcMsg, startInfo) != TSD_OK) {
        TSD_ERROR("ConstructOpenMsg open msg error");
        return TSD_CLT_OPEN_FAILED;
    }
    if (startInfo.startQs_) {
        hdcMsg.set_type(HDCMessage::TSD_START_QS_MSG);
        qsInitGroupName * const groupName = hdcMsg.mutable_qs_init_group_name();
        if (groupName == nullptr) {
            return TSD_INTERNAL_ERROR;
        }
        groupName->set_qs_init_group_name(qsInitGrpName_);
        hdcMsg.set_sched_policy(schedPolicy_);
        std::string installPath;
        GetAscendLatestIntallPath(installPath);
        if (!installPath.empty()) {
            hdcMsg.set_ascend_install_path(installPath);
        }
    } else {
        rankSize_ = rankSize;
        hdcMsg.set_type(HDCMessage::TSD_START_PROC_MSG);
        if (isStartedHccp_) {
            hdcMsg.set_start_hccp(true);
        }
    }
    const TSD_StatusT ret = hdcTsdClient_->SendMsg(tsdSessionId_, hdcMsg);
    if (ret != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId=%u][rankSize_=%u][procpid =%u] "
                  "tsdclient start hccp and computer process failed",
                  logicDeviceId_, rankSize_, static_cast<uint32_t>(procSign_.tgid));
        return TSD_CLT_OPEN_FAILED;
    }
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::SendCloseMsg()
{
    // TSDClient向TSDaemon发送关闭命令
    HDCMessage msg;
    if (ConstructCloseMsg(msg) != TSD_OK) {
        TSD_ERROR("ConstructCloseMsg failed");
        return TSD_INTERNAL_ERROR;
    }
    const TSD_StatusT ret = hdcTsdClient_->SendMsg(tsdSessionId_, msg);
    if (ret != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId=%u] tsdclient close hccp and "
                  "computer process failed",
                  logicDeviceId_);
        return TSD_CLT_CLOSE_FAILED;
    }

    return TSD_OK;
}

TSD_StatusT ProcessModeManager::UpdateProfilingConf(const uint32_t &flag)
{
    TSD_RUN_INFO("[TsdClient] Update profiling mode [deviceId=%u][sessionId=%u][flag=%u]", logicDeviceId_,
                 tsdSessionId_, flag);

    // 更新profiling状态前先判断是否已经open
    if (!initFlag_) {
        TSD_WARN("[TsdClient] tsd client need open first");
        return TSD_OK;
    }
    // 判空
    TSD_CHECK_NULLPTR(hdcTsdClient_, TSD_INSTANCE_NOT_INITIALED,
                      "[TsdClient] hdcTsdClient_ is null in update profiling function");
    TSD_StatusT ret = SendUpdateProfilingMsg(flag);
    TSD_CHECK(ret == TSD_OK, ret, "Send profiling message to tsdaemon failed.");

    TSD_RUN_INFO("[TsdClient][deviceId=%u] [sessionId=%u] wait update profiling msg response", logicDeviceId_,
                 tsdSessionId_);

    ret = WaitRsp(0U);
    TSD_CHECK(ret == TSD_OK, ret, "Wait UpdateProfiling response from device failed.");
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::SendUpdateProfilingMsg(const uint32_t flag)
{
    // TSDClient向TSDaemon发送更新profiling状态的消息
    HDCMessage msg;
    msg.set_device_id(logicDeviceId_ % PER_OS_CHIP_NUM);
    msg.set_real_device_id(logicDeviceId_);  // 传递真实的deviceId在回调的时候做校验使用,替代reqId
    msg.set_type(HDCMessage::TSD_UPDATE_PROIFILING_MSG);
    msg.set_profiling_mode(flag);
    msg.set_rank_size(rankSize_);
    // method from protobuf, no need check null
    ProcessSignPid * const signPid = msg.mutable_proc_sign_pid();
    if (signPid == nullptr) {
        return TSD_INTERNAL_ERROR;
    }
    signPid->set_proc_pid(static_cast<uint32_t>(procSign_.tgid));
    const TSD_StatusT ret = hdcTsdClient_->SendMsg(tsdSessionId_, msg);
    if (ret != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId=%u] tsdclient update profiling mode failed", logicDeviceId_);
        return TSD_CLT_UPDATE_PROFILING_FAILED;
    }

    return TSD_OK;
}

TSD_StatusT ProcessModeManager::GetHdcConctStatus(int32_t &hdcSessStat)
{
    if (hdcTsdClient_ != nullptr) {
        return hdcTsdClient_->GetHdcConctStatus(hdcSessStat);
    }
    TSD_WARN("[ProcessModeManager] hdcTsdClient_ is null in Open function");
    if (IsAdcEnv()) {
        hdcSessStat = HDC_SESSION_STATUS_CONNECT;
    } else {
        hdcSessStat = HDC_SESSION_STATUS_CLOSE;
    }
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::GetDeviceCheckCodeOnce(const HDCMessage msg)
{
    auto ret = hdcTsdClient_->SendMsg(tsdSessionId_, msg);
    if (ret != TSD_OK) {
        TSD_ERROR("Send check_code search message failed.");
        return ret;
    }

    TSD_RUN_INFO("[TsdClient][deviceId=%u] [sessionId=%u] wait package info response", logicDeviceId_, tsdSessionId_);
    ret = hdcTsdClient_->TsdRecvData(tsdSessionId_);
    if (ret != TSD_OK) {
        TSD_RUN_INFO("not receive TSD_CHECK_PACKAGE rsp msg, just send pkg to server");
    }
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::GetDeviceCheckCode()
{
    if (aicpuPackageExistInDevice_) {
        TSD_RUN_INFO("[ProcessModeManager][deviceId=%u] aicpu package already exist in device", logicDeviceId_);
        return TSD_AICPUPACKAGE_EXISTED;
    }

    const TSD_StatusT ret = InitTsdClient();
    if (ret != TSD_OK) {
        TSD_RUN_WARN("[ProcessModeManager][deviceId=%u] init failed for send aicpu package", logicDeviceId_);
        if (ret >= TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT) {
            return ret;
        }
        return TSD_HDC_CREATE_SESSION_FAILED;
    }
    TSD_CHECK_NULLPTR(hdcTsdClient_, TSD_INSTANCE_NOT_FOUND,
                      "[ProcessModeManager] hdcTsdClient_ is null in Open function");
    // tsd client only can hold one hdc session at the same time, so it need to be free before send package
    const ScopeGuard destroySessionGuard([this]() {
        this->hdcTsdClient_->Destroy();
        hdcTsdClient_ = nullptr;
    });

    // check whether device support search checkcode before send package
    // need to be deleted in next version(accompanies with g_tdtFeatureList)
    std::shared_ptr<VersionVerify> versionVerify = nullptr;
    (void)hdcTsdClient_->GetVersionVerify(tsdSessionId_, versionVerify);
    TSD_CHECK_NULLPTR(versionVerify, TSD_INTERNAL_ERROR, "no VersionVerify available.");

    if (!versionVerify->SpecialFeatureCheck(HDCMessage::TSD_CHECK_PACKAGE)) {
        TSD_RUN_INFO("[TsdClient] Device does not support search check_code before send aicpu package.");
        initFlag_ = false;
        aicpuPackageExistInDevice_ = true;
        return TSD_OK;
    }

    HDCMessage msg;
    msg.set_real_device_id(logicDeviceId_);
    msg.set_type(HDCMessage::TSD_CHECK_PACKAGE);
    msg.set_asan(IsAsanMmSysEnv());
    SetHostAicpuCheckCode(msg);
    SetHostExtendCheckCode(msg);
    SetHostAscendcppCheckCode(msg);
    if (GetDeviceCheckCodeOnce(msg) != TSD_OK) {
        initFlag_ = false;
        TSD_ERROR("get check code once failed.");
        return TSD_INTERNAL_ERROR;
    }
    GetDeviceCheckCodeRetrySupport();

    initFlag_ = false;
    aicpuPackageExistInDevice_ = true;

    return TSD_OK;
}

void ProcessModeManager::GetDeviceCheckCodeRetrySupport()
{
    // check whether device support check package retry
    std::shared_ptr<VersionVerify> versionVerify = nullptr;
    (void)hdcTsdClient_->GetVersionVerify(tsdSessionId_, versionVerify);
    if (versionVerify == nullptr) {
        TSD_ERROR("no VersionVerify available.");
        return;
    }

    getCheckCodeRetrySupport_ = versionVerify->SpecialFeatureCheck(HDCMessage::TSD_CHECK_PACKAGE_RETRY);
}

TSD_StatusT ProcessModeManager::GetDeviceCheckCodeRetry(const HDCMessage &msg)
{
    const TSD_StatusT ret = InitTsdClient();
    if (ret != TSD_OK) {
        TSD_RUN_WARN("[ProcessModeManager][deviceId=%u] init failed for send aicpu package", logicDeviceId_);
        if (ret >= TSD_SUBPROCESS_NUM_EXCEED_THE_LIMIT) {
            return ret;
        }
        return TSD_HDC_CREATE_SESSION_FAILED;
    }
    TSD_CHECK_NULLPTR(hdcTsdClient_, TSD_INSTANCE_NOT_FOUND,
                      "[ProcessModeManager] hdcTsdClient_ is null in Open function");
    // tsd client only can hold one hdc session at the same time, so it need to be free before send package
    const ScopeGuard destroySessionGuard([this]() {
        this->hdcTsdClient_->Destroy();
        hdcTsdClient_ = nullptr;
    });
    if (GetDeviceCheckCodeOnce(msg) != TSD_OK) {
        initFlag_ = false;
        TSD_ERROR("get check code once failed.");
        return TSD_INTERNAL_ERROR;
    }
    initFlag_ = false;
    return TSD_OK;
}

ProcessModeManager::~ProcessModeManager() {}

TSD_StatusT ProcessModeManager::InitQs(const InitFlowGwInfo * const initInfo)
{
    TSD_RUN_INFO("[ProcessModeManager][logicDeviceId_=%u] begin to prepare send open message", logicDeviceId_);
    if (initInfo == nullptr) {
        TSD_ERROR("TsdInitQs failed, initInfo is nullptr.");
        return tsd::TSD_INTERNAL_ERROR;
    }

    const char_t * const groupName = initInfo->groupName;
    // tsd支持重入, 判断本次open QS是否需要
    if (tsdStartStatus_.startQs_) {
        TSD_INFO("[ProcessModeManager] QS has opened already, no need open again");
        return TSD_OK;
    }
    TSD_StatusT ret = InitTsdClient();
    TSD_CHECK(ret == TSD_OK, ret, "Init hdc client failed.");

    if (groupName != nullptr) {
        TSD_INFO("[TsdClient]QS open with group[%s]", groupName);
        qsInitGrpName_ = groupName;
    } else {
        TSD_INFO("[TsdClient]QS open with empty groupName");
        qsInitGrpName_.clear();
    }
    schedPolicy_ = initInfo->schedPolicy;

    constexpr TsdStartStatusInfo startInfo = {false, false, true};
    ret = SendOpenMsg(DEFAULT_QS_RANKSIZE, startInfo);
    TSD_CHECK(ret == TSD_OK, ret, "Send InitQs message to device failed.");

    ret = WaitRsp(0U);
    TSD_CHECK(ret == TSD_OK, ret, "Wait InitQs response from device failed.");

    tsdStartStatus_.startQs_ = true;
    TSD_RUN_INFO("[TsdClient][logicDeviceId_=%u] [sessionId=%u] start QS process success",
                 logicDeviceId_, tsdSessionId_);
    return TSD_OK;
}

void ProcessModeManager::SetCapabilityMsgType(HDCMessage &msg, const int32_t type) const
{
    switch (type) {
        case TSD_CAPABILITY_PIDQOS: {
            msg.set_type(HDCMessage::TSD_GET_PID_QOS);
            break;
        }
        case TSD_CAPABILITY_LEVEL:
        case TSD_CAPABILITY_BUILTIN_UDF: 
        case TSD_CAPABILITY_MUTIPLE_HCCP: {
            msg.set_type(HDCMessage::TSD_GET_SUPPORT_CAPABILITY_LEVEL);
            break;
        }
        case TSD_CAPABILITY_OM_INNER_DEC: {
            msg.set_type(HDCMessage::TSD_SUPPORT_OM_INNER_DEC);
            break;
        }
        case TSD_CAPABILITY_ADPROF: {
            msg.set_type(HDCMessage::TSD_GET_SUPPORT_ADPROF);
            break;
        }
        default: {
            break;
        }
    }
}

void ProcessModeManager::ConstructCapabilityMsg(HDCMessage &msg, const int32_t type)
{
    SetCapabilityMsgType(msg, type);
    msg.set_device_id(logicDeviceId_ % PER_OS_CHIP_NUM);
    msg.set_real_device_id(logicDeviceId_);
    ProcessSignPid * const signPid = msg.mutable_proc_sign_pid();
    if (signPid == nullptr) {
        return;
    }
    signPid->set_proc_pid(static_cast<uint32_t>(procSign_.tgid));
}

bool ProcessModeManager::IsOkToGetCapability(const int32_t type) const
{
    bool ret = false;
    switch (type) {
        case TSD_CAPABILITY_PIDQOS: {
            if ((tsdStartStatus_.startCp_) && (hdcTsdClient_ != nullptr)) {
                ret = true;
            }
            break;
        }
        case TSD_CAPABILITY_LEVEL:
        case TSD_CAPABILITY_OM_INNER_DEC:
        case TSD_CAPABILITY_BUILTIN_UDF:
        case TSD_CAPABILITY_DRIVER_VERSION:
        case TSD_CAPABILITY_ADPROF: 
        case TSD_CAPABILITY_MUTIPLE_HCCP: {
            ret = true;
            break;
        }
        default: {
            break;
        }
    }
    return ret;
}

TSD_StatusT ProcessModeManager::SendCapabilityMsg(const int32_t type)
{
    if (!initFlag_) {
        TSD_WARN("[TsdClient] tsd client need open first");
        return TSD_OK;
    }
    HDCMessage msg;
    ConstructCapabilityMsg(msg, type);
    const TSD_StatusT ret = hdcTsdClient_->SendMsg(tsdSessionId_, msg);
    return ret;
}

bool ProcessModeManager::UseStoredCapabityInfo(const int32_t type, const uint64_t ptr)
{
    if ((type == TSD_CAPABILITY_LEVEL) && (TSD_BITMAP_GET(tsdSupportLevel_, TSD_SUPPORT_HS_AISERVER_FEATURE_BIT) != 0U)) {
        uint32_t * const resultPtr = PtrToPtr<void, uint32_t>(ValueToPtr(static_cast<uintptr_t>(ptr)));
        *resultPtr = tsdSupportLevel_;
        return true;
    }
    if ((type == TSD_CAPABILITY_OM_INNER_DEC) && (supportOmInnerDec_)) {
        uint64_t * const resultPtr = reinterpret_cast<uint64_t *>(static_cast<uintptr_t>(ptr));
        *resultPtr = TSD_SUPPORT_OM_INNER_DEC;
        return true;
    }

    if ((type == TSD_CAPABILITY_BUILTIN_UDF) && (TSD_BITMAP_GET(tsdSupportLevel_, TSD_SUPPORT_BUILTIN_UDF_BIT))) {
        bool * const resultPtr = reinterpret_cast<bool *>(static_cast<uintptr_t>(ptr));
        *resultPtr = true;
        return true;
    }

    if (type == TSD_CAPABILITY_DRIVER_VERSION) {
        if (GetCurDriverPkgVersion(ptr) == TSD_OK) {
            return true;
        }
    }

    if (type == TSD_CAPABILITY_ADPROF) {
        if (adprofSupport_) {
            return true;
        }
    }

    if ((type == TSD_CAPABILITY_MUTIPLE_HCCP) && (TSD_BITMAP_GET(tsdSupportLevel_, TSD_SUPPORT_MUL_HCCP) != 0U)) {
        bool * const resultPtr = reinterpret_cast<bool *>(static_cast<uintptr_t>(ptr));
        *resultPtr = true;
        return true;
    }
    return false;
}

TSD_StatusT ProcessModeManager::WaitCapabilityRsp(const int32_t type, const uint64_t ptr)
{
    TSD_StatusT ret = TSD_OK;
    bool ignorFail = false;
    switch (type) {
        case TSD_CAPABILITY_LEVEL:
        case TSD_CAPABILITY_ADPROF:
        case TSD_CAPABILITY_BUILTIN_UDF: 
        case TSD_CAPABILITY_MUTIPLE_HCCP: {
            ret = WaitRsp(COMMON_SUPPORT_TIMEOUT, true, false);
            ignorFail = true;
            break;
        }
        case TSD_CAPABILITY_OM_INNER_DEC: {
            ret = WaitRsp(SUPPORT_OM_INNER_DEC_MSG_TIMEOUT, true, false);
            ignorFail = true;
            break;
        }
        default: {
            ret = WaitRsp(0U);
            break;
        }
    }
    if ((ignorFail) && (ret != TSD_OK)) {
        TSD_RUN_INFO("not recv capability:%d rsp", type);
        if (type == TSD_CAPABILITY_OM_INNER_DEC) {
            uint64_t * const resultPtr = reinterpret_cast<uint64_t *>(static_cast<uintptr_t>(ptr));
            *resultPtr = TSD_NOT_SUPPORT_OM_INNER_DEC;
        }
        return TSD_OK;
    }
    TSD_CHECK(ret == TSD_OK, ret, "Wait capability response from device failed.");
    ret = SaveCapabilityResult(type, ptr);
    TSD_CHECK(ret == TSD_OK, ret, "SaveCapabilityResult failed.");
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::CapabilityGet(const int32_t type, const uint64_t ptr)
{
    if ((!initFlag_) && (type == TSD_CAPABILITY_PIDQOS)) {
        TSD_WARN("[TsdClient] tsd client need open first");
        return TSD_OK;
    }

    TSD_RUN_INFO("[ProcessModeManager] enter into CapabilityGet process deviceId[%u] type[%d].", logicDeviceId_, type);
    if (ptr == 0UL) {
        TSD_ERROR("input ptr is null");
        return TSD_CLT_OPEN_FAILED;
    }
    if (!IsOkToGetCapability(type)) {
        TSD_ERROR("[TsdClient] startCp[%u],type[%d],sessionid[%u]",
                  static_cast<uint32_t>(tsdStartStatus_.startCp_), type, tsdSessionId_);
        return TSD_CLT_OPEN_FAILED;
    }
    if (UseStoredCapabityInfo(type, ptr)) {
        return TSD_OK;
    }
    TSD_StatusT ret = InitTsdClient();
    TSD_CHECK(ret == TSD_OK, ret, "Init hdc client failed.");

    TSD_CHECK_NULLPTR(hdcTsdClient_, TSD_INSTANCE_NOT_INITIALED,
                      "[TsdClient] hdcTsdClient_ is null in Close function.");
    ret = SendCapabilityMsg(type);
    TSD_CHECK(ret == TSD_OK, ret, "SendCapabilityMsg failed.");

    TSD_RUN_INFO(
        "[TsdClient][deviceId=%u] [sessionId=%u] [type=%d]send capability successfully. ",
        logicDeviceId_, tsdSessionId_, type);

    ret = WaitCapabilityRsp(type, ptr);

    TSD_RUN_INFO("[TsdClient][logicDeviceId_=%u][type=%d][pidQos=%lld][ret=%u]recv capability response finished.",
                 logicDeviceId_, type, pidQos_, ret);
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::SaveCapabilityResult(const int32_t type, const uint64_t ptr) const
{
    TSD_StatusT ret = TSD_OK;
    switch (type) {
        case TSD_CAPABILITY_PIDQOS: {
            uint64_t * const resultPtr = reinterpret_cast<uint64_t *>(static_cast<uintptr_t>(ptr));
            if (resultPtr == nullptr) {
                TSD_ERROR("input ptr is null");
                return TSD_CLT_OPEN_FAILED;
            }
            if (pidQos_ != -1) {
                *resultPtr = static_cast<uint64_t>(pidQos_);
            }
            break;
        }
        case TSD_CAPABILITY_LEVEL: {
            uint32_t * const resultPtr = PtrToPtr<void, uint32_t>(ValueToPtr(static_cast<uintptr_t>(ptr)));
            if (resultPtr == nullptr) {
                TSD_ERROR("input ptr is null");
                return TSD_CLT_OPEN_FAILED;
            }
            *resultPtr = static_cast<uint32_t>(tsdSupportLevel_);
            break;
        }
        case TSD_CAPABILITY_OM_INNER_DEC: {
            uint64_t * const resultPtr = reinterpret_cast<uint64_t *>(static_cast<uintptr_t>(ptr));
            *resultPtr = supportOmInnerDec_ ? TSD_SUPPORT_OM_INNER_DEC : TSD_NOT_SUPPORT_OM_INNER_DEC;
            break;
        }
        case TSD_CAPABILITY_BUILTIN_UDF: {
            bool * const resultPtr = reinterpret_cast<bool *>(static_cast<uintptr_t>(ptr));
            *resultPtr = TSD_BITMAP_GET(tsdSupportLevel_, TSD_SUPPORT_BUILTIN_UDF_BIT) ? true : false;
            break;
        }
        case TSD_CAPABILITY_ADPROF: {
            bool * const resultPtr = reinterpret_cast<bool *>(static_cast<uintptr_t>(ptr));
            if (resultPtr == nullptr) {
                TSD_ERROR("input ptr is null");
                return TSD_CLT_OPEN_FAILED;
            }
            *resultPtr = adprofSupport_;
            break;
        }
        case TSD_CAPABILITY_MUTIPLE_HCCP: {
            bool * const resultPtr = reinterpret_cast<bool *>(static_cast<uintptr_t>(ptr));
            *resultPtr = TSD_BITMAP_GET(tsdSupportLevel_, TSD_SUPPORT_MUL_HCCP) != 0U ? true : false;
            break;
        }
        default: {
            ret = TSD_CLT_OPEN_FAILED;
            break;
        }
    }
    return ret;
}

bool ProcessModeManager::IsOkToLoadFileToDevice(const char_t *const fileName, const uint64_t fileNameLen)
{
    if ((fileName == nullptr) || (fileNameLen == 0UL) || (fileNameLen >= HELPER_INPUT_MAX_FILE_NAME_LEN)) {
        TSD_ERROR("input param is error");
        return false;
    }
    if (!IsSupportHeterogeneousInterface()) {
        TSD_ERROR("cur device does not support heterogeneous AIServer");
        return false;
    }
    try {
        std::string loadFile(fileName, fileNameLen);
        TSD_RUN_INFO("loadfile name:%s", loadFile.c_str());
    } catch (std::exception &e) {
        TSD_ERROR("input fileName is invalid reason:%s", e.what());
        return false;
    }
    return true;
}
TSD_StatusT ProcessModeManager::LoadOmFileToDevice(const char_t *const filePath, const uint64_t pathLen,
                                                   const char_t *const fileName, const uint64_t fileNameLen)
{
    if ((filePath == nullptr) || (pathLen == 0UL) || (pathLen >= HELPER_INPUT_MAX_FILE_PATH_LEN)) {
        TSD_ERROR("input param is error");
        return TSD_INTERNAL_ERROR;
    }
    try {
        std::string filePathStr(filePath, pathLen);
        TSD_RUN_INFO("file path is:%s", filePathStr.c_str());
    } catch (std::exception &e) {
        TSD_ERROR("input str is invalid reason:%s", e.what());
        return TSD_INTERNAL_ERROR;
    }
    auto ret = SendFileToDevice(filePath, pathLen, fileName, fileNameLen, true);
    TSD_CHECK(ret == TSD_OK, ret, "SendFileToDevice failed.");

    ret = InitTsdClient();
    TSD_CHECK(ret == TSD_OK, ret, "Init hdc client failed.");
    TSD_CHECK_NULLPTR(hdcTsdClient_, TSD_INSTANCE_NOT_FOUND, "hdcTsdClient_ is null in send function");
    std::string curFile(fileName, fileNameLen);
    HDCMessage msg;
    msg.set_device_id(logicDeviceId_ % PER_OS_CHIP_NUM);
    msg.set_real_device_id(logicDeviceId_);
    msg.set_type(HDCMessage::TSD_OM_PKG_DECOMPRESS_STATUS);
    const std::string curPid = std::to_string(procSign_.tgid);
    curFile = curPid + "_" + curFile;
    TSD_INFO("Load om file name:%s to device logic device id:%u", curFile.c_str(), logicDeviceId_);
    msg.set_omfile_name(curFile);
    ProcessSignPid * const signPid = msg.mutable_proc_sign_pid();
    TSD_CHECK_NULLPTR(signPid, TSD_INTERNAL_ERROR, "signPid is null.");
    signPid->set_proc_pid(static_cast<uint32_t>(procSign_.tgid));
    ret = hdcTsdClient_->SendMsg(tsdSessionId_, msg);
    TSD_CHECK(ret == TSD_OK, ret, "send TSD_OM_PKG_DECOMPRESS_STATUS msg failed.");
    ret = WaitRsp(OMFILE_LOAD_TIMEOUT);
    TSD_CHECK(ret == TSD_OK, ret, "Wait TSD_OM_PKG_DECOMPRESS_STATUS response from device failed.");
    TSD_INFO("LoadOmFileToDevice success filepath:%s, filename:%s", filePath, fileName);
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::LoadFileToDevice(const char_t *const filePath, const uint64_t pathLen,
                                                 const char_t *const fileName, const uint64_t fileNameLen)
{
    if (!IsOkToLoadFileToDevice(fileName, fileNameLen)) {
        TSD_ERROR("IsOkToLoadFileToDevice is false");
        return TSD_INTERNAL_ERROR;
    }
    // 针对显示调用动态shape包和runtime的加载，路径填空，名字为具体的包名
    const std::string loadFile(fileName, fileNameLen);
    TSD_RUN_INFO("begin load file:%s", loadFile.c_str());
    if (loadFile == RUNTIME_PKG_NAME) {
        return LoadRuntimePkgToDevice();
    } else if (loadFile == DSHAPE_PKG_NAME) {
        return LoadDShapePkgToDevice();
    } else {
        return LoadOmFileToDevice(filePath, pathLen, fileName, fileNameLen);
    }
}

TSD_StatusT ProcessModeManager::SendFileToDevice(const char_t *const filePath, const uint64_t pathLen,
    const char_t *const fileName, const uint64_t fileNameLen, const bool addPreFix)
{
    TSD_RUN_INFO("[TsdClient] [deviceId=%u][pathLen=%llu] SendFileToDevice enter", logicDeviceId_, pathLen);
    constexpr int32_t peerNode = 0;
    constexpr uint32_t hdcNameMax = 256U;
    char_t path[hdcNameMax] = { };
    int32_t ret = drvHdcGetTrustedBasePath(peerNode, static_cast<int32_t>(logicDeviceId_), &path[0], hdcNameMax);
    if (ret != DRV_ERROR_NONE) {
        TSD_ERROR("[TsdClient][deviceId_=%u] drvHdcGetTrustedBasePath failed, ret[%d]", logicDeviceId_, ret);
        return TSD_INTERNAL_ERROR;
    }
    std::string curPid;
    if (initFlag_) {
        curPid = std::to_string(procSign_.tgid);
    } else {
        process_sign processSign;
        ret = drvGetProcessSign(&processSign);
        if (ret != DRV_ERROR_NONE) {
            TSD_ERROR("driver get process sign failed. ret[%d].", ret);
            return TSD_INTERNAL_ERROR;
        }
        curPid = std::to_string(processSign.tgid);
    }
    std::string curFile(fileName, fileNameLen);
    std::string dstFile = std::string(path) + "/";
    if (addPreFix) {
        dstFile += curPid + "_";
    }
    dstFile += curFile;
    std::string orgPath(filePath, pathLen);
    std::string orgFile;
    if ((orgPath.length() > 0U) && ((orgPath.at((orgPath.length()) - 1U)) == '/')) {
        orgFile = orgPath + curFile;
    } else {
        orgFile = orgPath + "/" + curFile;
    }
    ret = drvHdcSendFile(peerNode, static_cast<int32_t>(logicDeviceId_), orgFile.c_str(), dstFile.c_str(), nullptr);
    if (ret != DRV_ERROR_NONE) {
        TSD_ERROR("[TsdClient][deviceId=%u] drvHdcSendFile file[%s] to [%s] failed, "
                  "ret = %d", logicDeviceId_, orgFile.c_str(), dstFile.c_str(), ret);
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO("[TsdClient][deviceId=%u] hdc send file[%s] to [%s] success", logicDeviceId_, orgFile.c_str(),
                 dstFile.c_str());
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::GetDeviceHsPkgCheckCode(const uint32_t checkCode, const HDCMessage::MsgType msgType,
                                                        const bool beforeSendFlag)
{
    TSD_StatusT ret = InitTsdClient();
    if (ret != TSD_OK) {
        TSD_ERROR("InitTsdClient failed");
        return TSD_INTERNAL_ERROR;
    }
    HDCMessage msg;
    msg.set_real_device_id(logicDeviceId_);
    msg.set_type(msgType);
    msg.set_check_code(checkCode);
    msg.set_before_send_pkg(beforeSendFlag);
    ProcessSignPid * const proSignPid = msg.mutable_proc_sign_pid();
    if (proSignPid != nullptr) {
        proSignPid->set_proc_pid(static_cast<uint32_t>(procSign_.tgid));
        const std::string signStr(procSign_.sign);
        proSignPid->set_proc_sign(signStr);
        TSD_RUN_INFO("[TsdClient] tsd get process sign procpid[%u]", static_cast<uint32_t>(procSign_.tgid));
    }
    ret = hdcTsdClient_->SendMsg(tsdSessionId_, msg);
    if (ret != TSD_OK) {
        initFlag_ = false;
        TSD_ERROR("Send runtime checkcode failed msgtype:%u.", static_cast<uint32_t>(msgType));
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO("[TsdClient][deviceId=%u] [sessionId=%u] wait package info response msgType:%u",
                 logicDeviceId_, tsdSessionId_, static_cast<uint32_t>(msgType));
    ret = WaitRsp(HELPER_PKG_LOAD_TIMEOUT);
    if (ret != TSD_OK) {
        if (beforeSendFlag) {
            TSD_RUN_INFO("not receive TSD_CHECK_PACKAGE rsp msg, just send pkg to server");
        } else {
            TSD_ERROR("not receive TSD_CHECK_PACKAGE failed Msgtype:%u", static_cast<uint32_t>(msgType));
            return TSD_INTERNAL_ERROR;
        }
    }
    TSD_RUN_INFO("GetDeviceHsPkgCheckCode success Msgtype:%u", static_cast<uint32_t>(msgType));
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::LoadRuntimePkgToDevice()
{
    if (IsSupportCommonSink() &&
        (&drvHdcSendFileV2 != nullptr) &&
        (&drvHdcGetTrustedBasePathV2 != nullptr)) {
        LoadPackageConfigInfoToDevice();
        if (LoadCannHsPkgToDevice(UDF_PKG_NAME) != TSD_OK) {
            TSD_ERROR("Load package failed, package:%s", UDF_PKG_NAME.c_str());
            return TSD_INTERNAL_ERROR;
        }
        if (LoadCannHsPkgToDevice(HCCD_PKG_NAME) != TSD_OK) {
            TSD_ERROR("Load package failed, package:%s", HCCD_PKG_NAME.c_str());
            return TSD_INTERNAL_ERROR;
        }
        TSD_RUN_INFO("Load udf and hccd package success.");
        return TSD_OK;
    }

    // 使用ASCEND_LATEST_INSTALL_PATH配置的路径
    std::string runtimePkgPath;
    GetAscendLatestIntallPath(runtimePkgPath);
    if ((runtimePkgPath.length() > 0U) && ((runtimePkgPath.at((runtimePkgPath.length()) - 1U)) == '/')) {
        runtimePkgPath = runtimePkgPath + "runtime/lib64/";
    } else {
        runtimePkgPath = runtimePkgPath + "/runtime/lib64/";
    }
    const std::string runtimePkgNameStr = runtimePkgPath + RUNTIME_PKG_NAME;
    TSD_INFO("target runtime path:%s pkg:%s", runtimePkgPath.c_str(), runtimePkgNameStr.c_str());
    if ((mmAccess(runtimePkgPath.c_str()) != EN_OK) || (mmIsDir(runtimePkgPath.c_str()) != EN_OK)) {
        TSD_ERROR("[TsdClient] path[%s] does not exist, deviceId[%u]", runtimePkgPath.c_str(), logicDeviceId_);
        return TSD_INTERNAL_ERROR;
    }
    if (mmAccess(runtimePkgNameStr.c_str()) != EN_OK) {
        TSD_ERROR("[TsdClient] file[%s] does not exist, deviceId[%u]", runtimePkgNameStr.c_str(), logicDeviceId_);
        return TSD_INTERNAL_ERROR;
    }
    // device侧可能会删除包, 必须把host保存的peercheckcode初始化
    packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_RUNTIME)] = 0U;
    const uint32_t hostRuntimeCheckCode = CalFileSize(runtimePkgNameStr.c_str());
    const auto ret = SendFileToDevice(runtimePkgPath.c_str(), runtimePkgPath.length(), RUNTIME_PKG_NAME.c_str(),
                                      RUNTIME_PKG_NAME.length(), true);
    TSD_CHECK(ret == TSD_OK, ret, "send runtime pkg to device failed.");
    // helper要求解压的同步性，解压完成后再返回给上层
    if (GetDeviceHsPkgCheckCode(hostRuntimeCheckCode, HDCMessage::TSD_GET_DEVICE_RUNTIME_CHECKCODE, false) != TSD_OK) {
        TSD_ERROR("GetDeviceHsPkgCheckCode failed");
        return TSD_INTERNAL_ERROR;
    }
    if (hostRuntimeCheckCode !=
        packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_RUNTIME)]) {
        TSD_ERROR("checode verify is failed hostRuntimeCheckCode:%u, peerRuntimeCheckCode:%u",
                  hostRuntimeCheckCode,
                  packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_RUNTIME)]);
        return TSD_INTERNAL_ERROR;
    }
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::LoadCannHsPkgToDevice(const std::string &pkgPureName)
{
    int32_t peerNode = 0;
    constexpr uint32_t hdcNameMax = 256U;
    char_t path[hdcNameMax] = { };
    const int32_t drvRet = drvHdcGetTrustedBasePathV2(peerNode, static_cast<int32_t>(logicDeviceId_), &path[0],
        hdcNameMax);
    if (drvRet != DRV_ERROR_NONE) {
        TSD_ERROR("[TsdClient][deviceId_=%u] Get hdc trusted path failed, ret[%d]", logicDeviceId_, drvRet);
        return TSD_INTERNAL_ERROR;
    }

    PackageProcessConfig *pkgConInst = PackageProcessConfig::GetInstance();
    std::map<std::string, PackConfDetail> configMap = pkgConInst->GetAllPackageConfigInfo();
    std::string dstDirPreFix = std::string(path);
    std::string orgFile;
    std::string dstFile = dstDirPreFix;
    if (pkgConInst->GetPkgHostAndDeviceDstPath(pkgPureName, orgFile, dstFile, procSign_.tgid) != TSD_OK) {
        return TSD_INTERNAL_ERROR;
    }
    if (orgFile.empty()) {
        TSD_RUN_WARN("cannot find package:%s, optional is true skip", pkgPureName.c_str());
        return TSD_OK;
    }

    const std::string hostHash = ProcessUtilCommon::CalFileSha256HashValue(orgFile);
    SetHostCommonSinkPackHashValue(pkgPureName, hostHash);
    if (IsCommonSinkHostAndDevicePkgSame(pkgPureName)) {
        TSD_INFO("current package:%s is same as device, skip load", pkgPureName.c_str());
        return TSD_OK;
    }

    if (LoadFileAndWaitRsp(pkgPureName, hostHash, peerNode, orgFile, dstFile) != TSD_OK) {
        TSD_ERROR("compare and send package to device failed");
        return TSD_INTERNAL_ERROR;
    }

    if (static_cast<uint32_t>(rspCode_) != 0U) {
        TSD_ERROR("host and device check code compare failed, package:%s", pkgPureName.c_str());
        return TSD_INTERNAL_ERROR;
    }

    TSD_RUN_INFO("Load package success, package:%s", pkgPureName.c_str());
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::LoadFileAndWaitRsp(const std::string &pkgPureName,
    const std::string &hostPkgHash, const int32_t peerNode, const std::string &orgFile, const std::string &dstFile)
{
    if (SendAICPUPackageSimple(peerNode, orgFile, dstFile, true) != TSD_OK) {
        TSD_ERROR("send package to device failed, package:%s", pkgPureName.c_str());
        return TSD_INTERNAL_ERROR;
    }

    if (GetCannHsPkgCheckCode(pkgPureName, hostPkgHash) != TSD_OK) {
        TSD_ERROR("get check code from device failed, package:%s", pkgPureName.c_str());
        return TSD_INTERNAL_ERROR;
    }

    return TSD_OK;
}

TSD_StatusT ProcessModeManager::GetCannHsPkgCheckCode(const std::string &pkgPureName, const std::string &hostPkgHash)
{
    TSD_StatusT ret = InitTsdClient();
    if (ret != TSD_OK) {
        TSD_ERROR("InitTsdClient failed");
        return TSD_INTERNAL_ERROR;
    }

    HDCMessage msg;
    msg.set_real_device_id(logicDeviceId_);
    msg.set_type(HDCMessage::TSD_GET_DEVICE_CANN_HS_CHECKCODE);
    msg.set_package_max_process_time(DRIVER_EXTEND_MAX_PROCESS_TIME);
    msg.set_package_worker_type(static_cast<uint32_t>(PackageWorkerType::PACKAGE_WORKER_COMMON_SINK));
    msg.set_package_type(static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_COMMON_SINK));
    SinkPackageHashCodeInfo *pkgHostInfo = msg.add_package_hash_code_list();
    pkgHostInfo->set_package_name(pkgPureName);
    pkgHostInfo->set_hash_code(hostPkgHash);
    ret = hdcTsdClient_->SendMsg(tsdSessionId_, msg);
    if (ret != TSD_OK) {
        TSD_ERROR("Send cann hs check code failed");
        return TSD_INTERNAL_ERROR;
    }

    TSD_RUN_INFO("[TsdClient][deviceId=%u] [sessionId=%u] wait cann package info response for %s",
                 logicDeviceId_, tsdSessionId_, pkgPureName.c_str());
    ret = WaitRsp(DRIVER_EXTEND_MAX_PROCESS_TIME * 1000U);
    if (ret != TSD_OK) {
        TSD_ERROR("Wait response for package %s failed", pkgPureName.c_str());
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO("Get check code for package %s success", pkgPureName.c_str());
    return TSD_OK;
}

bool ProcessModeManager::SetCommonOpenParamList(HDCMessage &hdcMsg, const ProcOpenArgs *const procArgs) const
{
    if ((procArgs->envCnt > PROCESS_OPEN_MAX_ENV_CNT) || (procArgs->extParamCnt > PROCESS_OPEN_MAX_EXT_PARAM_CNT)) {
        TSD_ERROR("input param error envCnt:%llu, extParamCnt:%llu", procArgs->envCnt, procArgs->extParamCnt);
        return false;
    }
    HelperSubProcess * const subProcessInfo = hdcMsg.mutable_helper_sub_proc();
    try {
        subProcessInfo->set_process_type(static_cast<uint32_t>(procArgs->procType));
        if ((procArgs->filePath != nullptr) && (procArgs->pathLen != 0)) {
            const std::string filePath(procArgs->filePath, procArgs->pathLen);
            subProcessInfo->set_file_path(filePath);
            TSD_INFO("filePath:%s", filePath.c_str());
        }
        if ((procArgs->procType == TSD_SUB_PROC_BUILTIN_UDF) || (procArgs->procType == TSD_SUB_PROC_UDF)) {
            for (uint64_t index = 0; index < procArgs->envCnt; index++) {
                EnvPara *evnParam = subProcessInfo->add_env_list();
                if (evnParam == nullptr) {
                    return false;
                }
                const std::string envName(procArgs->envParaList[index].envName, procArgs->envParaList[index].nameLen);
                const std::string envValue(procArgs->envParaList[index].envValue, procArgs->envParaList[index].valueLen);
                TSD_INFO("input envName:%s, envValue:%s", envName.c_str(), envValue.c_str());
                evnParam->set_env_name(envName);
                evnParam->set_env_value(envValue);
            }
        }
        for (uint64_t cnt = 0; cnt < procArgs->extParamCnt; cnt++) {
            const std::string extParam(procArgs->extParamList[cnt].paramInfo, procArgs->extParamList[cnt].paramLen);
            TSD_INFO("cnt:%llu, extra parameters:%s, len:%llu", cnt, extParam.c_str(), procArgs->extParamList[cnt].paramLen);
            subProcessInfo->add_ext_param_list(extParam);
        }
    } catch (std::exception &e) {
        TSD_ERROR("input str is invalid reason:%s", e.what());
        return false;
    }
    return true;
}
TSD_StatusT ProcessModeManager::ConstructCommonOpenMsg(HDCMessage &hdcMsg, const ProcOpenArgs *procArgs) const
{
    if (!SetCommonOpenParamList(hdcMsg, procArgs)) {
        TSD_ERROR("input param is error, SetCommonOpenParamList failed");
        return TSD_INTERNAL_ERROR;
    }

    std::string runtimePkgPath;
    GetAscendLatestIntallPath(runtimePkgPath);
    if (!runtimePkgPath.empty()) {
        hdcMsg.set_ascend_install_path(runtimePkgPath);
        TSD_RUN_INFO("runtimePkgPath:%s", runtimePkgPath.c_str());
    }

    if (procArgs->procType == SubProcType::TSD_SUB_PROC_HCCP) {
        LogLevel * const level = hdcMsg.mutable_log_level();
        if (level != nullptr) {
            level->set_log_level(logLevel_);
        }
    }
    hdcMsg.set_type(HDCMessage::TSD_OPEN_SUB_PROC);
    hdcMsg.set_device_id(logicDeviceId_ % PER_OS_CHIP_NUM);
    hdcMsg.set_real_device_id(logicDeviceId_);
    ProcessSignPid * const proSignPid = hdcMsg.mutable_proc_sign_pid();
    TSD_CHECK_NULLPTR(proSignPid, TSD_INTERNAL_ERROR, "signPid is null.");
    proSignPid->set_proc_pid(static_cast<uint32_t>(procSign_.tgid));
    const std::string signStr(procSign_.sign);
    proSignPid->set_proc_sign(signStr);
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::SendCommonOpenMsg(const ProcOpenArgs *procArgs) const
{
    HDCMessage hdcMsg;
    if (ConstructCommonOpenMsg(hdcMsg, procArgs) != TSD_OK) {
        TSD_ERROR("construct open msg error");
        return TSD_INTERNAL_ERROR;
    }
    const TSD_StatusT ret = hdcTsdClient_->SendMsg(tsdSessionId_, hdcMsg);
    if (ret != TSD_OK) {
        TSD_ERROR("send msg to device error");
        return TSD_INTERNAL_ERROR;
    }
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::ProcessOpenSubProc(ProcOpenArgs *openArgs)
{
    if (openArgs == nullptr) {
        TSD_ERROR("openArgs is null");
        return TSD_INTERNAL_ERROR;
    }
    if (openArgs->subPid == nullptr) {
        TSD_ERROR("openArgs->subPid is null");
        return TSD_INTERNAL_ERROR;
    }

    TSD_RUN_INFO("enter into ProcessOpenSubProc subtype:%u", static_cast<uint32_t>(openArgs->procType));
    bool retCheck = false;
    const auto iter = versionCheckMap_.find(static_cast<SubProcType>(openArgs->procType));
    if (iter != versionCheckMap_.end()) {
        retCheck = (this->*(iter->second))();
        if (!retCheck) {
            TSD_ERROR("ProcessOpenSubProc versionCheck failed, subtype[%u], ret[%u]",
                      static_cast<uint32_t>(openArgs->procType), retCheck);
            return TSD_INTERNAL_ERROR;
        }
    }

    auto ret = InitTsdClient();
    TSD_CHECK(ret == TSD_OK, ret, "Init hdc client failed.");

    ret = SendCommonOpenMsg(openArgs);
    TSD_CHECK(ret == TSD_OK, ret, "SendCommonOpenMsg failed.");

    ret = WaitRsp(0U);
    // for test
    TSD_CHECK(ret == TSD_OK, ret, "wait heterogeneous open msg rsp failed.");

    *(openArgs->subPid) = static_cast<pid_t>(openSubPid_);
    if (openArgs->procType == SubProcType::TSD_SUB_PROC_HCCP) {
        isStartedHccp_ = true;
        hccpPid_ = openSubPid_;
    }
    TSD_RUN_INFO("OpenSubProc success type:%u, pid:%u", static_cast<uint32_t>(openArgs->procType), openSubPid_);
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::ProcessCloseSubProc(const pid_t closePid)
{
    if (closePid <= 0) {
        TSD_ERROR("input param is error");
        return TSD_INTERNAL_ERROR;
    }
    if (!IsSupportHeterogeneousInterface()) {
        TSD_ERROR("cur device does not support heterogeneous AIServer");
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO("enter into ProcessCloseSubProc subpid:%d", closePid);
    TSD_CHECK_NULLPTR(hdcTsdClient_, TSD_INSTANCE_NOT_INITIALED, "[TsdClient] hdcTsdClient_ is null in Close function");
    HDCMessage msg;
    msg.set_device_id(logicDeviceId_ % PER_OS_CHIP_NUM);
    msg.set_real_device_id(logicDeviceId_);
    msg.set_type(HDCMessage::TSD_CLOSE_SUB_PROC);
    msg.set_close_sub_proc_pid(static_cast<uint32_t>(closePid));
    ProcessSignPid * const signPid = msg.mutable_proc_sign_pid();
    TSD_CHECK_NULLPTR(signPid, TSD_INTERNAL_ERROR, "signPid is null.");
    signPid->set_proc_pid(static_cast<uint32_t>(procSign_.tgid));

    if (isStartedHccp_ && (static_cast<uint32_t>(closePid) == hccpPid_)) {
        isStartedHccp_ = false;
        hccpPid_ = 0;
    }

    TSD_StatusT ret = hdcTsdClient_->SendMsg(tsdSessionId_, msg);
    if (ret != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId=%u] send remove msg to device error", logicDeviceId_);
        return TSD_INTERNAL_ERROR;
    }
    ret = WaitRsp(0U);
    TSD_CHECK(ret == TSD_OK, ret, "Wait open response from device failed.");
    TSD_RUN_INFO("leave ProcessCloseSubProc subpid:%u", closePid);
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::GetSubProcStatus(ProcStatusInfo *pidInfo, const uint32_t arrayLen)
{
    if ((pidInfo == nullptr) || (arrayLen == 0U)) {
        TSD_ERROR("input param is error");
        return TSD_INTERNAL_ERROR;
    }

    TSD_DEBUG("enter into GetSubProcStatus");
    TSD_CHECK_NULLPTR(hdcTsdClient_, TSD_INSTANCE_NOT_INITIALED, "[TsdClient] hdcTsdClient_ is null in Close function");
    HDCMessage msg;
    msg.set_device_id(logicDeviceId_ % PER_OS_CHIP_NUM);
    msg.set_real_device_id(logicDeviceId_);
    msg.set_type(HDCMessage::TSD_GET_SUB_PROC_STATUS);
    ProcessSignPid * const signPid = msg.mutable_proc_sign_pid();
    TSD_CHECK_NULLPTR(signPid, TSD_INTERNAL_ERROR, "signPid is null.");
    signPid->set_proc_pid(static_cast<uint32_t>(procSign_.tgid));
    for (uint32_t index = 0; index < arrayLen; index++) {
        SubProcStatus *curStatus = msg.add_sub_proc_status_list();
        curStatus->set_sub_proc_pid(static_cast<uint32_t>(pidInfo[index].pid));
    }
    const ScopeGuard closeFileGuard([this]() {
        pidArry_ = nullptr;
        pidArryLen_ = 0U;
    });
    pidArry_ = pidInfo;
    pidArryLen_ = arrayLen;
    TSD_StatusT ret = hdcTsdClient_->SendMsg(tsdSessionId_, msg);
    TSD_CHECK(ret == TSD_OK, ret, "send GetSubProcStatus msg to device failed.");
    ret = WaitRsp(0U);
    TSD_CHECK(ret == TSD_OK, ret, "Wait GetSubProcStatus response from device failed.");
    TSD_DEBUG("leave GetSubProcStatus");
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::RemoveFileOnDevice(const char_t *const filePath, const uint64_t pathLen)
{
    if ((filePath == nullptr) || (pathLen == 0UL) || (pathLen >= HELPER_INPUT_MAX_FILE_PATH_LEN)) {
        TSD_ERROR("input param is error");
        return TSD_INTERNAL_ERROR;
    }
    try {
        const std::string dstPath(filePath, pathLen);
        TSD_RUN_INFO("input dstpath:%s", dstPath.c_str());
        if (!CheckValidatePath(dstPath)) {
            TSD_ERROR("dstPath[%s] is not correct", dstPath.c_str());
            return TSD_INTERNAL_ERROR;
        }
        if (dstPath.find("..") != std::string::npos) {
            TSD_ERROR("input path:%s is error", dstPath.c_str());
            return TSD_INTERNAL_ERROR;
        }
    } catch (std::exception &e) {
        TSD_ERROR("input fileName is invalid reason:%s", e.what());
        return TSD_INTERNAL_ERROR;
    }
    if (!IsSupportHeterogeneousInterface()) {
        TSD_ERROR("cur device does not support heterogeneous AIServer");
        return TSD_INTERNAL_ERROR;
    }
    TSD_CHECK_NULLPTR(hdcTsdClient_, TSD_INSTANCE_NOT_INITIALED, "[TsdClient] hdcTsdClient_ is null in Close function");
    HDCMessage msg;
    const std::string remvePath(filePath, pathLen);
    msg.set_device_id(logicDeviceId_ % PER_OS_CHIP_NUM);
    msg.set_real_device_id(logicDeviceId_);
    msg.set_type(HDCMessage::TSD_REMOVE_FILE);
    msg.set_remove_file_path(remvePath);
    ProcessSignPid * const signPid = msg.mutable_proc_sign_pid();
    TSD_CHECK_NULLPTR(signPid, TSD_INTERNAL_ERROR, "signPid is null.");
    signPid->set_proc_pid(static_cast<uint32_t>(procSign_.tgid));
    TSD_StatusT ret = hdcTsdClient_->SendMsg(tsdSessionId_, msg);
    if (ret != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId=%u] send remove msg to device error", logicDeviceId_);
        return TSD_INTERNAL_ERROR;
    }
    ret = WaitRsp(0U);
    TSD_CHECK(ret == TSD_OK, ret, "Wait open response from device failed.");
    return TSD_OK;
}

bool ProcessModeManager::IsSupportCommonInterface(const uint32_t level)
{
    if (tsdSupportLevel_ != 0) {
        if (TSD_BITMAP_GET(tsdSupportLevel_, level)) {
            return true;
        } else {
            return false;
        }
    }

    TSD_StatusT ret = InitTsdClient();
    if ((ret != TSD_OK) || (hdcTsdClient_ == nullptr)) {
        TSD_ERROR("Init hdc client failed.");
        return false;
    }
    ret = SendCapabilityMsg(TSD_CAPABILITY_LEVEL);
    if (ret != TSD_OK) {
        TSD_ERROR("SendCapabilityMsg failed");
        return false;
    }
    ret = hdcTsdClient_->TsdRecvData(tsdSessionId_, true, COMMON_SUPPORT_TIMEOUT);
    if (ret != TSD_OK) {
        TSD_RUN_INFO("not support TSD_CAPABILITY_LEVEL");
        return false;
    }
    if (TSD_BITMAP_GET(tsdSupportLevel_, level)) {
        return true;
    }

    TSD_RUN_INFO("IsSupportCommonInterface check not success, level[%u], tsd support level[%u]", level, tsdSupportLevel_);
    return false;
}

bool ProcessModeManager::IsSupportHeterogeneousInterface()
{
    return IsSupportCommonInterface(TSD_SUPPORT_HS_AISERVER_FEATURE_BIT);
}

bool ProcessModeManager::IsSupportBuiltinUdfInterface()
{
    return IsSupportCommonInterface(TSD_SUPPORT_BUILTIN_UDF_BIT);
}

bool ProcessModeManager::IsSupportAdprofInterface()
{
    return IsSupportCommonInterface(TSD_SUPPORT_ADPROF_BIT);
}

TSD_StatusT ProcessModeManager::LoadDShapePkgToDevice()
{
    // 使用ASCEND_LATEST_INSTALL_PATH配置的路径
    std::string curPkgPath;
    GetAscendLatestIntallPath(curPkgPath);
    if ((curPkgPath.length() > 0U) && ((curPkgPath.at((curPkgPath.length()) - 1U)) == '/')) {
        curPkgPath = curPkgPath + "ops/built-in/";
    } else {
        curPkgPath = curPkgPath + "/ops/built-in/";
    }
    const std::string curPkgName = curPkgPath + DSHAPE_PKG_NAME;
    TSD_INFO("target pkg path:%s pkgName:%s", curPkgPath.c_str(), curPkgName.c_str());
    if ((mmAccess(curPkgPath.c_str()) != EN_OK) || (mmIsDir(curPkgPath.c_str()) != EN_OK)) {
        TSD_ERROR("[TsdClient] path[%s] does not exist, deviceId[%u]", curPkgPath.c_str(), logicDeviceId_);
        return TSD_INTERNAL_ERROR;
    }
    if (mmAccess(curPkgName.c_str()) != EN_OK) {
        TSD_ERROR("[TsdClient] file[%s] does not exist, deviceId[%u]", curPkgName.c_str(), logicDeviceId_);
        return TSD_INTERNAL_ERROR;
    }
    // device侧可能会删除包, 必须把host保存的peercheckcode初始化
    packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DSHAPE)] = 0U;
    const uint32_t checkCode = CalFileSize(curPkgName.c_str());
    const auto ret = SendFileToDevice(curPkgPath.c_str(), curPkgPath.length(), DSHAPE_PKG_NAME.c_str(),
                                      DSHAPE_PKG_NAME.length(), true);
    TSD_CHECK(ret == TSD_OK, ret, "send dshape pkg to device failed.");
    // helper要求解压的同步性，解压完成后再返回给上层
    if (GetDeviceHsPkgCheckCode(checkCode, HDCMessage::TSD_GET_DEVICE_DSHAPE_CHECKCODE, false) != TSD_OK) {
        TSD_ERROR("GetDeviceHsPkgCheckCode failed");
        return TSD_INTERNAL_ERROR;
    }
    if (checkCode != packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DSHAPE)]) {
        TSD_ERROR("checkode verify is failed checkCode:%u, peerDShapeCheckCode_:%u",
                  checkCode, packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DSHAPE)]);
        return TSD_INTERNAL_ERROR;
    }
    return TSD_OK;
}


void ProcessModeManager::GetAscendLatestIntallPath(std::string &pkgBasePath) const
{
    GetEnvFromMmSys(MM_ENV_ASCEND_LATEST_INSTALL_PATH, "ASCEND_LATEST_INSTALL_PATH", pkgBasePath);
    if (pkgBasePath.empty()) {
        GetEnvFromMmSys(MM_ENV_ASCEND_HOME_PATH, "ASCEND_HOME_PATH", pkgBasePath);
        if (pkgBasePath.empty()) {
            pkgBasePath = "/usr/local/Ascend/latest/";
            TSD_INFO("[TsdClient][logicDeviceId_=%u] ASCEND_LATEST_INSTALL_PATH is not set, use default value[%s]",
                     logicDeviceId_, pkgBasePath.c_str());
        }
    }
    TSD_RUN_INFO("latest install path:%s", pkgBasePath.c_str());
}

TSD_StatusT ProcessModeManager::GetCurDriverPkgVersion(const uint64_t ptr)
{
    if (ptr == 0UL) {
        TSD_ERROR("input is nullptr");
        return TSD_INTERNAL_ERROR;
    }
    uint64_t * const resultPtr = reinterpret_cast<uint64_t *>(static_cast<uintptr_t>(ptr));
    if (tsdVersion_ != 0UL) {
        (*resultPtr) = tsdVersion_;
        return TSD_OK;
    }

    uint64_t halVersion;
    const auto ret = GetDriverVersion(&halVersion);
    if ((ret != TSD_OK) && (ret != TSD_NO_VERSION_SO)) {
        TSD_ERROR("halGetAPIVersion error ret:%d", ret);
        return TSD_INTERNAL_ERROR;
    }

    (*resultPtr) = halVersion;
    tsdVersion_ = halVersion;
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::NotifyPmToStartTsdaemon()
{
    void *handle = dlopen(START_APP_SO.c_str(),
        ((static_cast<uint32_t>(RTLD_LAZY))|(static_cast<uint32_t>(RTLD_GLOBAL))));
    if (handle == nullptr) {
        TSD_ERROR("open libgroup_client.so error:%s", dlerror());
        return TSD_INTERNAL_ERROR;
    }
    const ScopeGuard closeHandleGuard([&handle]() {
        dlclose(handle);
    });
    using StartAppFunc = int32_t (*)(const char *appName, const size_t nameLen, const int32_t timeout);
    const StartAppFunc tsdStartFuncPtr = reinterpret_cast<StartAppFunc>(dlsym(handle, "GrpOwnerClientStartApp"));
    if (tsdStartFuncPtr == nullptr) {
        TSD_ERROR("dlsym GrpOwnerClientStartApp error:%s", dlerror());
        return TSD_INTERNAL_ERROR;
    }
    const auto ret = tsdStartFuncPtr(TSDEMON_START_APP.c_str(), TSDEMON_START_APP.size(), TSD_START_TIMEOUT);
    if (ret != 0U) {
        TSD_ERROR("tsdStartFuncPtr errorRet:%u", ret);
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO("NotifyPmToStartTsdaemon success");
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::ProcessCloseSubProcList(const ProcStatusParam *closeList, const uint32_t listSize)
{
    TSD_RUN_INFO("enter ExecuteClosePidList cnt:%u, tsdSupportLevel_:%u", listSize, tsdSupportLevel_);
    if ((listSize > MAX_PROCESS_PID_CNT) || (listSize == 0U) || (closeList == nullptr)) {
        TSD_ERROR("pid list size invalid:%u", listSize);
        return TSD_INTERNAL_ERROR;
    }
    if (hdcTsdClient_ == nullptr) {
        TSD_RUN_INFO("hdcTsdClient_ is null");
        return TSD_HDC_CLIENT_CLOSED_EXTERNAL;
    }
    if (!TSD_BITMAP_GET(tsdSupportLevel_, TSD_SUPPORT_CLOSE_LIST_BIT)) {
        TSD_StatusT singleCloseRet = TSD_OK;
        for (uint32_t index = 0U; index < listSize; index++) {
            if (ProcessCloseSubProc(closeList[index].pid) != TSD_OK) {
                singleCloseRet = TSD_INTERNAL_ERROR;
                TSD_ERROR("close pid:%d failed", closeList[index].pid);
            }
        }
        return singleCloseRet;
    }

    const uint32_t loopCnt = listSize / CLOSE_PID_PER_LOOP;
    const uint32_t reserveCnt = listSize % CLOSE_PID_PER_LOOP;
    for (uint32_t cnt = 0U; cnt < loopCnt; cnt++) {
        if (ExecuteClosePidList(closeList, cnt * CLOSE_PID_PER_LOOP, CLOSE_PID_PER_LOOP) != TSD_OK) {
            TSD_ERROR("ExecuteClosePidList failed cnt:%u", cnt);
            return TSD_INTERNAL_ERROR;
        }
        TSD_RUN_INFO("ExecuteClosePidList success cnt:%u", cnt);
    }

    if (ExecuteClosePidList(closeList, loopCnt * CLOSE_PID_PER_LOOP, reserveCnt) != TSD_OK) {
        TSD_ERROR("ExecuteClosePidList failed reserveCnt:%u", reserveCnt);
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO("ExecuteClosePidList success reserveCnt:%u", reserveCnt);
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::ExecuteClosePidList(const ProcStatusParam *closeList, const uint32_t startIndex,
                                                   const uint32_t pidCnt)
{
    if ((closeList == nullptr) || (pidCnt == 0U) || (pidCnt > MAX_PROCESS_PID_CNT)) {
        TSD_ERROR("input param is error");
        return TSD_INTERNAL_ERROR;
    }

    TSD_CHECK_NULLPTR(hdcTsdClient_, TSD_INSTANCE_NOT_INITIALED, "[TsdClient] hdcTsdClient_ is null");
    HDCMessage msg;
    msg.set_device_id(logicDeviceId_ % PER_OS_CHIP_NUM);
    msg.set_real_device_id(logicDeviceId_);
    msg.set_type(HDCMessage::TSD_CLOSE_SUB_PROC_LIST);
    ProcessSignPid * const signPid = msg.mutable_proc_sign_pid();
    TSD_CHECK_NULLPTR(signPid, TSD_INTERNAL_ERROR, "signPid is null.");
    signPid->set_proc_pid(static_cast<uint32_t>(procSign_.tgid));
    for (uint32_t index = 0U; index < pidCnt; index++) {
        SubProcStatus *curStatus = msg.add_close_sub_list();
        msg.add_sub_proc_type_list(static_cast<uint32_t>(closeList[index + startIndex].procType));
        curStatus->set_sub_proc_pid(static_cast<uint32_t>(closeList[index + startIndex].pid));
        TSD_INFO("add close subproc:%d, proctype:%u", closeList[index + startIndex].pid,
                 static_cast<uint32_t>(closeList[index + startIndex].procType));
        if (isStartedHccp_ &&
            (closeList[index + startIndex].procType == SubProcType::TSD_SUB_PROC_HCCP) &&
            (static_cast<uint32_t>(closeList[index + startIndex].pid) == hccpPid_)) {
            isStartedHccp_ = false;
            hccpPid_ = 0;
        }
    }
    TSD_StatusT ret = hdcTsdClient_->SendMsg(tsdSessionId_, msg);
    if (ret != TSD_OK) {
        TSD_ERROR("[TsdClient][deviceId=%u] send close pid array msg to device error", logicDeviceId_);
        return TSD_INTERNAL_ERROR;
    }
    ret = WaitRsp(0U);
    TSD_CHECK(ret == TSD_OK, ret, "Wait close pid array response from device failed.");
    TSD_RUN_INFO("leave ExecuteClosePidList startindex:%u, cnt:%u", startIndex, pidCnt);
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::GetSubProcListStatus(ProcStatusParam *pidInfo, const uint32_t arrayLen)
{
    if ((pidInfo == nullptr) || (arrayLen == 0U) || (arrayLen > MAX_PROCESS_PID_CNT)) {
        TSD_ERROR("input param is error");
        return TSD_INTERNAL_ERROR;
    }

    TSD_INFO("enter into GetSubProcListStatus");
    TSD_CHECK_NULLPTR(hdcTsdClient_, TSD_INSTANCE_NOT_INITIALED, "[TsdClient] hdcTsdClient_ is null");
    HDCMessage msg;
    msg.set_device_id(logicDeviceId_ % PER_OS_CHIP_NUM);
    msg.set_real_device_id(logicDeviceId_);
    msg.set_type(HDCMessage::TSD_GET_SUB_PROC_STATUS);
    ProcessSignPid * const signPid = msg.mutable_proc_sign_pid();
    TSD_CHECK_NULLPTR(signPid, TSD_INTERNAL_ERROR, "signPid is null.");
    signPid->set_proc_pid(static_cast<uint32_t>(procSign_.tgid));
    for (uint32_t index = 0; index < arrayLen; index++) {
        SubProcStatus *curStatus = msg.add_sub_proc_status_list();
        msg.add_sub_proc_type_list(static_cast<uint32_t>(pidInfo[index].procType));
        curStatus->set_sub_proc_pid(static_cast<uint32_t>(pidInfo[index].pid));
    }
    const ScopeGuard closeFileGuard([this]() {
        pidList_ = nullptr;
        pidArryLen_ = 0U;
    });
    pidList_ = pidInfo;
    pidArryLen_ = arrayLen;
    TSD_StatusT ret = hdcTsdClient_->SendMsg(tsdSessionId_, msg);
    TSD_CHECK(ret == TSD_OK, ret, "send GetSubProcListStatus msg to device failed.");
    ret = WaitRsp(0U);
    TSD_CHECK(ret == TSD_OK, ret, "Wait GetSubProcListStatus response from device failed.");
    TSD_INFO("leave GetSubProcListStatus");
    return TSD_OK;
}

void ProcessModeManager::DestroyHdcClientConnectChannel()
{
    if (hdcTsdClient_ != nullptr) {
        hdcTsdClient_->Destroy();
        hdcTsdClient_ = nullptr;
        TSD_RUN_INFO("hdcTsdClient destroy finish");
    }
    initFlag_ = false;
    TSD_RUN_INFO("DestroyHdcClientConnectChannel finish");
}

TSD_StatusT ProcessModeManager::SendCommonPackage(const int32_t peerNode, const std::string &path, const uint32_t packageType)
{
    if (packageName_[packageType] == "") {
        TSD_RUN_INFO("[TsdClient][deviceId_=%u] package is not existed, skip send, packageType[%u]", logicDeviceId_, packageType);
        return TSD_OK;
    }

    uint32_t supportLevelName = INVALID_NUMBER;
    if (packageType == static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL)) {
        supportLevelName = TSD_SUPPORT_EXTEND_PKG;
    } else if (packageType == static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP)) {
        supportLevelName = TSD_SUPPORT_ASCENDCPP_PKG;
    }
    if (TSD_BITMAP_GET(tsdSupportLevel_, supportLevelName) == 0U) {
        packageHostCheckCode_[packageType] = 0U;
        TSD_RUN_INFO("[TsdClient][deviceId_=%u] device does not support, skip send, packageType[%u]", logicDeviceId_, packageType);
        return TSD_OK;
    }

    if (packageHostCheckCode_[packageType] == packagePeerCheckCode_[packageType]) {
        TSD_INFO("[TsdClient][deviceId_=%u] the checksum of host package[%u] is same as device[%u], skip send package, packageType[%u]",
                 logicDeviceId_, packageHostCheckCode_[packageType], packagePeerCheckCode_[packageType], packageType);
        return TSD_OK;
    }

    const std::string orgFile = packagePath_[packageType] + packageName_[packageType];
    const std::string dstFile = std::string(path) + "/" + std::to_string(procSign_.tgid) + "_" +
                                packageName_[packageType];
    TSD_INFO("[TsdClient][deviceId=%u] hostCheckCode[%u] no equal to deviceCheckCode[%u], begin send file[%s] to [%s], packageType[%u]",
             logicDeviceId_, packageHostCheckCode_[packageType], packagePeerCheckCode_[packageType],
             orgFile.c_str(), dstFile.c_str(), packageType);
    const auto ret = drvHdcSendFile(peerNode, static_cast<int32_t>(logicDeviceId_), orgFile.c_str(), dstFile.c_str(),
                                    nullptr);
    if (ret != DRV_ERROR_NONE) {
        TSD_ERROR("[TsdClient][deviceId=%u] drvHdcSendFile file[%s] to [%s] failed, ret[%d], packageType[%u]",
                  logicDeviceId_, orgFile.c_str(), dstFile.c_str(), ret, packageType);
        packageHostCheckCode_[packageType] = 0U;
        return TSD_INTERNAL_ERROR;
    }
    TSD_INFO("[TsdClient][deviceId=%u] hdc send file[%s] to [%s] success, packageType[%u]", logicDeviceId_, orgFile.c_str(),
             dstFile.c_str(), packageType);
    return TSD_OK;
}

void ProcessModeManager::SetHostAicpuCheckCode(HDCMessage &msg)
{
    const uint32_t packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_KERNEL);
    if (!packageName_[packageType].empty()) {
        const std::string orgFile = packagePath_[packageType] + packageName_[packageType];
        packageHostCheckCode_[packageType] = CalFileSize(orgFile.c_str());
        msg.set_check_code(packageHostCheckCode_[packageType]);
    }
}

void ProcessModeManager::SetHostExtendCheckCode(HDCMessage &msg)
{
    const uint32_t packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_AICPU_EXTEND_KERNEL);
    if (!packageName_[packageType].empty()) {
        const std::string orgFile = packagePath_[packageType] + packageName_[packageType];
        packageHostCheckCode_[packageType] = CalFileSize(orgFile.c_str());
        msg.set_extendpkg_check_code(packageHostCheckCode_[packageType]);
    }
}

void ProcessModeManager::SetHostAscendcppCheckCode(HDCMessage &msg)
{
    const uint32_t packageType = static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_ASCENDCPP);
    if (!packageName_[packageType].empty()) {
        const std::string orgFile = packagePath_[packageType] + packageName_[packageType];
        packageHostCheckCode_[packageType] = CalFileSize(orgFile.c_str());
        msg.set_ascendcpppkg_check_code(packageHostCheckCode_[packageType]);
    }
}

void ProcessModeManager::ParseTsdCloseFlag(const uint32_t flag, TsdCloseFlag &tsdCloseFlag) const
{
    TSD_RUN_INFO("Parse tsd close flag [%u]", flag);
    tsdCloseFlag.quickCloseFlag = TSD_BITMAP_GET(flag, 0U);
    return;
}
TSD_StatusT ProcessModeManager::GetDriverExtendPkgName(std::string &orgFile, std::string &dstFile, int32_t &peerNode)
{
    std::string pkgPath;
    GetEnvFromMmSys(MM_ENV_ASCEND_HOME_PATH, "ASCEND_HOME_PATH", pkgPath);
    if (pkgPath.empty()) {
        pkgPath = "/usr/local/Ascend/latest";
        TSD_INFO("ASCEND_AICPU_PATH is not set, use default value[%s]", pkgPath.c_str());
    }
    if ((pkgPath.length() > 0U) && ((pkgPath.at((pkgPath.length()) - 1U)) == '/')) {
        pkgPath = pkgPath + "device-sw-plugin/";
    } else {
        pkgPath = pkgPath + "/device-sw-plugin/";
    }
    if (access(pkgPath.c_str(), F_OK) != 0) {
        TSD_RUN_WARN("cannot get package path:%s, reason:%s", pkgPath.c_str(), SafeStrerror().c_str());
        return TSD_OK;
    }

    if (access((pkgPath + DRIVER_EXTEND_PKG_NAME).c_str(), F_OK) != 0) {
        TSD_ERROR("cannot get package file:%s, reason:%s", pkgPath.c_str(), SafeStrerror().c_str());
        return TSD_INTERNAL_ERROR;
    }
    constexpr uint32_t hdcNameMax = 256U;
    char_t path[hdcNameMax] = { };
    const int32_t drvRet = drvHdcGetTrustedBasePath(peerNode, static_cast<int32_t>(logicDeviceId_), &path[0], hdcNameMax);
    if (drvRet != DRV_ERROR_NONE) {
        TSD_ERROR("[TsdClient][deviceId_=%u] drvHdcGetTrustedBasePath failed, ret[%d]", logicDeviceId_, drvRet);
        return TSD_INTERNAL_ERROR;
    }
    orgFile = pkgPath + DRIVER_EXTEND_PKG_NAME;
    dstFile = std::string(path) + "/" + std::to_string(procSign_.tgid) + "_" + DRIVER_EXTEND_PKG_NAME;
    return TSD_OK;
}
TSD_StatusT ProcessModeManager::LoadDriverExtendPkg()
{
    if(IsSupportCommonInterface(TSD_SUPPORT_DRIVER_EXTEND_BIT) == false) {
        packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DRIVER_EXTEND)] = 0U;
        TSD_RUN_INFO("The device-sw-plugin package not found; skipping send to device.");
        return TSD_OK;
    }

    std::string orgFile;
    std::string dstFile;
    int32_t peerNode = 0;
    if (GetDriverExtendPkgName(orgFile, dstFile, peerNode) != TSD_OK) {
        TSD_ERROR("Could not get the device-sw-plugin package.");
        return TSD_INTERNAL_ERROR;
    }
    if (orgFile.empty()) {
        TSD_RUN_INFO("The device-sw-plugin package was not found, so the system skipped the loading process.");
        return TSD_OK;
    }
    packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DRIVER_EXTEND)] =
        CalFileSize(orgFile.c_str());
    HDCMessage msg;
    msg.set_real_device_id(logicDeviceId_);
    msg.set_type(HDCMessage::TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL);
    msg.set_check_code(packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DRIVER_EXTEND)]);
    msg.set_package_worker_type(static_cast<uint32_t>(PackageWorkerType::PACKAGE_WORKER_DRIVER_EXTEND));
    msg.set_package_max_process_time(DRIVER_EXTEND_MAX_PROCESS_TIME);
    msg.set_package_type(static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DRIVER_EXTEND));
    auto driverExtendPkgCompareMethd = [this]() {
        if ((this->packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DRIVER_EXTEND)] ==
            this->packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DRIVER_EXTEND)]) ||
            (!(this->deviceIdle_))) {
            TSD_INFO("Driver package checksum [%u] matches device [%u]. Idle state [%d]. Skipping send.",
                this->packageHostCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DRIVER_EXTEND)],
                this->packagePeerCheckCode_[static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_DRIVER_EXTEND)],
                this->deviceIdle_);
            return true;
        }
        return false;
    };
    if (SendHostPackageComplex(peerNode, orgFile, dstFile, msg, driverExtendPkgCompareMethd, false) != TSD_OK) {
        TSD_ERROR("The complex host package sending operation failed.");
        return TSD_INTERNAL_ERROR;
    }

    if (static_cast<uint32_t>(rspCode_) != 0U) {
        TSD_ERROR("The checkcode comparison between the host and device failed.");
        return TSD_INTERNAL_ERROR;
    }
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::OpenNetService(const NetServiceOpenArgs *args)
{
    if(!IsSupportCommonInterface(TSD_SUPPORT_MUL_HCCP)) {
        TSD_RUN_INFO("current package not support open net service with args");
        if (Open(DEFUALT_NET_SERVICE) != TSD_OK) {
            TSD_ERROR("open default net service failed");
            return TSD_OPEN_DEFAULT_NET_SERVICE_FAILED;
        } else {
            return TSD_OK;
        }
    } else {
        if (args == nullptr) {
            TSD_ERROR("openArgs is null");
            return TSD_INTERNAL_ERROR;
        }
        ProcOpenArgs openArgs;
        pid_t subPid = 0;
        openArgs.procType = SubProcType::TSD_SUB_PROC_HCCP;
        openArgs.envParaList = nullptr;
        openArgs.envCnt = 0UL;
        openArgs.filePath = nullptr;
        openArgs.pathLen = 0UL;
        openArgs.extParamCnt = args->extParamCnt;
        openArgs.extParamList = args->extParamList;
        openArgs.subPid = &subPid;
        return ProcessOpenSubProc(&openArgs);
    }
}

TSD_StatusT ProcessModeManager::CloseNetService()
{
    if(!IsSupportCommonInterface(TSD_SUPPORT_MUL_HCCP)) {
        TSD_RUN_INFO("current package not support close net service with args");
        return TsdClose(0U);
    } else {
        ProcStatusParam closeList;
        closeList.pid = hccpPid_;
        closeList.curStat = SubProcessStatus::SUB_PROCESS_STATUS_NORMAL;
        closeList.procType = SubProcType::TSD_SUB_PROC_HCCP;
        return ProcessCloseSubProcList(&closeList, 1U);
    }
}

TSD_StatusT ProcessModeManager::LoadPackageConfigInfoToDevice()
{
    if ((IsSupportCommonSink() == false) ||
        (&drvHdcSendFileV2 == nullptr) ||
        (&drvHdcGetTrustedBasePathV2 == nullptr) ||
        IsAdcEnv()) {
        TSD_RUN_INFO("device does not support common sink package config info");
        return TSD_OK;
    }

    if (hasSendConfigFile_) {
        TSD_RUN_INFO("The package config file has send to device, no need send again. deviceId=%u",
                     logicDeviceId_);
        return TSD_OK;
    }

    TSD_StatusT ret = InitTsdClient();
    if (ret != DRV_ERROR_NONE) {
        TSD_ERROR("[TsdClient][deviceId_=%u] InitTsdClient failed, ret[%d]", logicDeviceId_, ret);
        return TSD_INTERNAL_ERROR;
    }
    TSD_CHECK_NULLPTR(hdcTsdClient_, TSD_INSTANCE_NOT_FOUND, "hdcTsdClient is null");
    std::string packageTitle;
    (void)GetPackageTitle(packageTitle);
    PackageProcessConfig *pkgConInst = PackageProcessConfig::GetInstance();
    ret = pkgConInst->ParseConfigDataFromFile(packageTitle);
    if (ret != TSD_OK) {
        TSD_RUN_INFO("parse config data not success");
        return TSD_INTERNAL_ERROR;
    }

    HDCMessage msg;
    msg.set_real_device_id(logicDeviceId_);
    msg.set_type(HDCMessage::TSD_UPDATE_PACKAGE_PROCESS_CONFIG);
    pkgConInst->ConstructPkgConfigMsg(msg);

    ret = hdcTsdClient_->SendMsg(tsdSessionId_, msg);
    if (ret != TSD_OK) {
        TSD_ERROR("Send update package config message failed.");
        return ret;
    }

    ret = hdcTsdClient_->TsdRecvData(tsdSessionId_);
    TSD_RUN_INFO("recive load package config response result:%u", ret);

    hasSendConfigFile_ = true;

    return TSD_OK;
}

TSD_StatusT ProcessModeManager::CompareAndSendCommonSinkPkg(const std::string &pkgPureName,
    const std::string &hostPkgHash, const int32_t peerNode, const std::string &orgFile, const std::string &dstFile)
{
    HDCMessage msg;
    msg.set_real_device_id(logicDeviceId_);
    msg.set_type(HDCMessage::TSD_GET_DEVICE_PACKAGE_CHECKCODE_NORMAL);
    SinkPackageHashCodeInfo *pkgHostInfo = msg.add_package_hash_code_list();
    pkgHostInfo->set_package_name(pkgPureName);
    pkgHostInfo->set_hash_code(hostPkgHash);
    msg.set_package_worker_type(static_cast<uint32_t>(PackageWorkerType::PACKAGE_WORKER_COMMON_SINK));
    msg.set_package_max_process_time(DRIVER_EXTEND_MAX_PROCESS_TIME);
    msg.set_package_type(static_cast<uint32_t>(TsdLoadPackageType::TSD_PKG_TYPE_COMMON_SINK));
    auto commonSinkPkgCompareMethd = [this, pkgPureName]() {
        if (this->IsCommonSinkHostAndDevicePkgSame(pkgPureName)) {
            TSD_INFO("checksum of driver package[%s] is same as device[%u], idle[%d], skip send",
                this->GetHostCommonSinkPackHashValue(pkgPureName).c_str(),
                this->deviceIdle_);
            return true;
        }
        return false;
    };
    if (SendHostPackageComplex(peerNode, orgFile, dstFile, msg, commonSinkPkgCompareMethd, true) != TSD_OK) {
        TSD_ERROR("send common sink package to device failed");
        return TSD_INTERNAL_ERROR;
    }
    return TSD_OK;
}

bool ProcessModeManager::SupportLoadPkg(const std::string &pkgName) const
{
    const auto iter = PKG_CHIP_SUPPORT_MAP.find(pkgName);
    if (iter == PKG_CHIP_SUPPORT_MAP.end()) {
        TSD_INFO("current package:%s dose not need to check chiptype", pkgName.c_str());
        return true;
    }

    if ((pkgName == UDF_PKG_NAME) || (pkgName == HCCD_PKG_NAME)) {
        TSD_INFO("package is not need load, name:%s", pkgName.c_str());
        return false;
    }

    uint32_t currentChipType = GetPlatInfoChipType();
    const size_t vecSize = iter->second.size();
    for (size_t index = 0; index < vecSize; index++) {
        if (currentChipType == static_cast<uint32_t>(iter->second[index])) {
            TSD_INFO("current device chip:%u support package:%s", currentChipType, pkgName.c_str());
            return true;
        }
    }

    TSD_INFO("current device chip:%u dose not support package:%s", currentChipType, pkgName.c_str());
    return false;
}

TSD_StatusT ProcessModeManager::LoadPackageToDeviceByConfig()
{
    if ((IsSupportCommonSink() == false) ||
        (&drvHdcSendFileV2 == nullptr) ||
        (&drvHdcGetTrustedBasePathV2 == nullptr) ||
        IsAdcEnv()) {
        TSD_RUN_INFO("device does not support common sink package config info");
        return TSD_OK;
    }

    int32_t peerNode = 0;
    constexpr uint32_t hdcNameMax = 256U;
    char_t path[hdcNameMax] = { };
    const int32_t drvRet = drvHdcGetTrustedBasePathV2(peerNode, static_cast<int32_t>(logicDeviceId_), &path[0],
        hdcNameMax);
    if (drvRet != DRV_ERROR_NONE) {
        TSD_ERROR("[TsdClient][deviceId_=%u] drvHdcGetTrustedBasePathV2 failed, ret[%d]", logicDeviceId_, drvRet);
        return TSD_INTERNAL_ERROR;
    }
    
    PackageProcessConfig *pkgConInst = PackageProcessConfig::GetInstance();
    std::map<std::string, PackConfDetail> configMap = pkgConInst->GetAllPackageConfigInfo();
    std::string dstDirPreFix = std::string(path);

    for (auto iter = configMap.begin(); iter != configMap.end(); iter++) {
        std::string pkgPureName = iter->first;
        std::string orgFile;
        std::string dstFile = dstDirPreFix;
        TSD_RUN_INFO("begin to load package:%s to device:%u", pkgPureName.c_str(), logicDeviceId_);
        if (!SupportLoadPkg(pkgPureName)) {
            TSD_RUN_INFO("current package package:%s dose not need to load to device:%u", pkgPureName.c_str(), logicDeviceId_);
            continue;
        }
        if (pkgConInst->GetPkgHostAndDeviceDstPath(iter->first, orgFile, dstFile, procSign_.tgid) != TSD_OK) {
            return TSD_INTERNAL_ERROR;
        }
        if (orgFile.empty()) {
            TSD_RUN_WARN("cannot find package:%s, optional is true skip", pkgPureName.c_str());
            continue;
        }

        const std::string hostPkgHash = ProcessUtilCommon::CalFileSha256HashValue(orgFile);
        SetHostCommonSinkPackHashValue(pkgPureName, hostPkgHash);
        if (IsCommonSinkHostAndDevicePkgSame(pkgPureName)) {
            TSD_RUN_INFO("current package:%s is same as device, skip load", pkgPureName.c_str());
            continue;
        }
        
        if (CompareAndSendCommonSinkPkg(pkgPureName, hostPkgHash, peerNode, orgFile, dstFile) != TSD_OK) {
            TSD_ERROR("compare and send package to device failed package:%s", pkgPureName.c_str());
            return TSD_INTERNAL_ERROR;
        }

        if (static_cast<uint32_t>(rspCode_) != 0U) {
            if (!loadPackageErrorMsg_.empty()) {
                TSD_ERROR("[Device error message] %s", loadPackageErrorMsg_.c_str());
                loadPackageErrorMsg_ = "";
            }
            TSD_ERROR("host and device checkcode compare failed package:%s", pkgPureName.c_str());
            return TSD_INTERNAL_ERROR;
        }
        TSD_RUN_INFO("load package:%s to device:%u success", pkgPureName.c_str(), logicDeviceId_);
    }

    return TSD_OK;
}

std::string ProcessModeManager::GetCurHostMutexFile(bool useCannPath) const
{
    if (!useCannPath) {
        return QUEUE_SCHEDULE_SO;
    } else {
        int64_t masterId = 0;
        uint32_t phyId = 0U;
        auto drvRet = drvDeviceGetPhyIdByIndex(logicDeviceId_, &phyId);
        if (drvRet != DRV_ERROR_NONE) {
            TSD_RUN_WARN("get physical ID not success, retCode[%d] deviceId[%u]", drvRet, logicDeviceId_);
            return QUEUE_SCHEDULE_SO;
        }
        TSD_INFO("deviceId[%u] physical ID[%u]", logicDeviceId_, phyId);
        drvRet = halGetDeviceInfo(phyId, MODULE_TYPE_SYSTEM, INFO_TYPE_MASTERID, &masterId);
        if (drvRet != DRV_ERROR_NONE) {
            TSD_RUN_WARN("get halGetDeviceInfo not success, retCode[%d] deviceId[%u] physical ID[%u]", drvRet, logicDeviceId_, phyId);
            return QUEUE_SCHEDULE_SO;
        }
        const int64_t devOsId = masterId % SUPPORT_MAX_DEVICE_PER_HOST;
        std::string mutexFile = MUTEX_FILE_PREFIX + std::to_string(devOsId) + ".cfg";
        TSD_RUN_INFO("get masterId:%lld, logicDeviceId:%u, physicalDeviceId[%u],devOsId:%lld, mutexFile:%s, maxcount:%lld",
            masterId, logicDeviceId_, phyId, devOsId, mutexFile.c_str(), SUPPORT_MAX_DEVICE_PER_HOST);
        return mutexFile;
    }
}
}  // namespace tsd
