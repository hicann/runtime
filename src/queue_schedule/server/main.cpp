/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdint>
#include <string>
#include <sstream>
#include <unistd.h>
#include <csignal>
#include <dlfcn.h>
#include <fstream>
#include "driver/ascend_hal.h"
#include "common/bqs_status.h"
#include "common/bqs_log.h"
#include "common/bqs_util.h"
#include "qs_interface_process.h"
#include "server/bind_cpu_utils.h"
#include "tsd.h"
#include "securec.h"
#include "queue_schedule/qs_client.h"
#include "bqs_weak_log.h"
#include "server/qs_args_parser.h"
#include "queue_schedule_sub_module_interface.h"
#include "bqs_feature_ctrl.h"

namespace bqs {
namespace {
void *g_aicpuSdlibHandle = nullptr;
const std::string AICPU_SCHEDULER_SO_NAME = "libaicpu_scheduler.so";
// mutex for condition variable
std::mutex g_kMtx;
// condition variable
std::condition_variable g_kCv;
// exit flag
#ifndef aicpusd_UT
std::atomic<bool> g_kExitFlag{false};
#else
std::atomic<bool> g_kExitFlag{true};
#endif

/**
 * wait for shutdown.
 * @return  void
 */
static void WaitShutdown()
{
    std::unique_lock<std::mutex> lk(bqs::g_kMtx);
    while (!bqs::g_kExitFlag.load()) {
        bqs::g_kCv.wait(lk);
    }
    BQS_LOG_INFO("Exit WaitShutdown");
}

/**
 * handle SIGTERM sig.
 * @return  void
 */
static void HandleSignal(const int32_t sig)
{
    (void) sig;
    bqs::g_kExitFlag = true;
    bqs::g_kCv.notify_one();
}
}

void ReportErrorMsg(const int32_t errCode, const uint32_t deviceId, const pid_t hostPid, const uint32_t vfId)
{
    BQS_LOG_RUN_WARN("ReportErrorMsg errcode is %d.", errCode);
    std::string errStr;
    switch (errCode) {
        case BQS_STATUS_ATTACH_GROUP_FALED: {
            errStr = ERROR_MSG_ATTACH_GROUP_FAILED;
            break;
        }
        default: {
            errStr = ERROR_MSG_QS_INIT_FAILED;
            break;
        }
    }
    BQS_LOG_RUN_INFO("ReportErrorMsg msg is %s.", errStr.c_str());
    (void) TsdReportStartOrStopErrCode(deviceId, TSD_QS, static_cast<uint32_t>(hostPid), vfId, errStr.c_str(),
                                       static_cast<uint32_t>(errStr.size()));
}

void RegAicpuSchedulerModuleCallBack()
{
    g_aicpuSdlibHandle = dlopen(AICPU_SCHEDULER_SO_NAME.c_str(), RTLD_LAZY);
    if (g_aicpuSdlibHandle == nullptr) {
        BQS_LOG_WARN("cannot open so %s", AICPU_SCHEDULER_SO_NAME.c_str());
        return;
    }

    const SubProcEventCallBackFuncInfo startAicpuSdFunc =
        reinterpret_cast<SubProcEventCallBackFuncInfo>(dlsym(g_aicpuSdlibHandle, "StartAicpuSchedulerModule"));
    if (startAicpuSdFunc == nullptr) {
        BQS_LOG_ERROR("cannot find StartAicpuSchedulerModule");
        (void)dlclose(g_aicpuSdlibHandle);
        g_aicpuSdlibHandle = nullptr;
        return;
    }

    SubProcEventCallBackInfo startCallBackInfo;
    startCallBackInfo.callBackFunc = startAicpuSdFunc;
    startCallBackInfo.eventType = TSD_EVENT_START_AICPU_SD_MODULE;
    int32_t ret = RegEventMsgCallBackFunc(&startCallBackInfo);
    if (ret != 0) {
        BQS_LOG_ERROR("reg StartAicpuSchedulerModule failed");
        (void)dlclose(g_aicpuSdlibHandle);
        g_aicpuSdlibHandle = nullptr;
        return;
    }

    const SubProcEventCallBackFuncInfo stopAicpuSdFunc =
        reinterpret_cast<SubProcEventCallBackFuncInfo>(dlsym(g_aicpuSdlibHandle, "StopAicpuSchedulerModule"));
    if (stopAicpuSdFunc == nullptr) {
        UnRegEventMsgCallBackFunc(TSD_EVENT_START_AICPU_SD_MODULE);
        BQS_LOG_ERROR("cannot find StopAicpuSchedulerModule");
        (void)dlclose(g_aicpuSdlibHandle);
        g_aicpuSdlibHandle = nullptr;
        return;
    }

    SubProcEventCallBackInfo stopCallBackInfo;
    stopCallBackInfo.callBackFunc = stopAicpuSdFunc;
    stopCallBackInfo.eventType = TSD_EVENT_STOP_AICPU_SD_MODULE;

    ret = RegEventMsgCallBackFunc(&stopCallBackInfo);
    if (ret != 0) {
        UnRegEventMsgCallBackFunc(TSD_EVENT_START_AICPU_SD_MODULE);
        BQS_LOG_ERROR("reg StopAicpuSchedulerModule failed");
        (void)dlclose(g_aicpuSdlibHandle);
        g_aicpuSdlibHandle = nullptr;
        return;
    }
    BQS_LOG_RUN_INFO("RegAicpuSchedulerModuleCallBack success");
    return;
}
void StopAiCpuSubModuleInQs(const uint32_t deviceId, const uint32_t hostPid, const uint32_t vfId)
{
    if (g_aicpuSdlibHandle == nullptr) {
        BQS_LOG_WARN("cannot open so %s .", AICPU_SCHEDULER_SO_NAME.c_str());
        return;
    }
    TsdSubEventInfo eventInfo = {};
    eventInfo.deviceId = deviceId;
    eventInfo.hostPid = hostPid;
    eventInfo.vfId = vfId;
    const SubProcEventCallBackFuncInfo stopAicpuSdFunc =
        reinterpret_cast<SubProcEventCallBackFuncInfo>(dlsym(g_aicpuSdlibHandle, "StopAicpuSchedulerModule"));
    if (stopAicpuSdFunc == nullptr) {
        BQS_LOG_ERROR("cannot find StopAicpuSchedulerModule");
        (void)dlclose(g_aicpuSdlibHandle);
        g_aicpuSdlibHandle = nullptr;
        return;
    }
    const int32_t ret = stopAicpuSdFunc(&eventInfo);
    if (ret != 0) {
        BQS_LOG_ERROR("StopAicpuSchedulerModule fail");
    }
    (void)dlclose(g_aicpuSdlibHandle);
    g_aicpuSdlibHandle = nullptr;
}

void CloseAicpuSdlibHandle()
{
    if (g_aicpuSdlibHandle != nullptr) {
        (void)dlclose(g_aicpuSdlibHandle);
        g_aicpuSdlibHandle = nullptr;
        return;
    }
}

void GetEnv(const char_t * const envName, std::string &envValue)
{
    const size_t envValueMaxLen = 1024UL * 1024UL;
    const char_t * const envTemp = std::getenv(envName);
    if ((envTemp == nullptr) || (strnlen(envTemp, envValueMaxLen) >= envValueMaxLen)) {
        BQS_LOG_WARN("Get env[%s] failed.", envName);
        return;
    }
    envValue = envTemp;
}

void SetLogLevelWithEnv(bqs::ArgsParser &startParams)
{
    std::string envLogLevel;
    std::string envEventLevel;
    GetEnv("ASCEND_GLOBAL_LOG_LEVEL", envLogLevel);
    GetEnv("ASCEND_GLOBAL_EVENT_ENABLE", envEventLevel);
    BQS_LOG_RUN_INFO("Set log with env, envLogLevel[%s], envEventLevel[%s]",
                     envLogLevel.c_str(), envEventLevel.c_str());
    int32_t logLevel;
    int32_t eventLevel;
    if (!TransStrToInt(envLogLevel, logLevel)) {
        logLevel = ERROR_LOG;
    }
    if (!TransStrToInt(envEventLevel, eventLevel)) {
        eventLevel = EVENT_LOG;
    }
    startParams.SetLogLevel(logLevel, eventLevel);
}

void InitQsInitParams(bqs::InitQsParams &initQsParams, const uint32_t deviceId,
                      const uint32_t hostPid, const uint32_t vfId,
                      const std::vector<uint32_t> resVec, const bqs::ArgsParser &startParams)
{
    initQsParams.deviceId = deviceId;
    initQsParams.enqueGroupId = static_cast<uint32_t>(bqs::EventGroupId::ENQUEUE_GROUP_ID);
    initQsParams.f2nfGroupId = static_cast<uint32_t>(bqs::EventGroupId::F2NF_GROUP_ID);
    initQsParams.reschedInterval = static_cast<uint32_t>(startParams.GetReschedInterval());
    initQsParams.runMode = startParams.GetDeployMode();
    initQsParams.pid = hostPid;
    initQsParams.vfId = vfId;
    initQsParams.pidSign = startParams.GetPidSign();
    initQsParams.qsInitGrpName = startParams.GetGroupName();
    initQsParams.schedPolicy = startParams.GetSchedPolicy();
    initQsParams.starter = startParams.GetStarter();
    initQsParams.profCfgData = startParams.GetProfCfgData();
    initQsParams.abnormalInterVal = static_cast<uint32_t>(startParams.GetAbnormalInterval());
    initQsParams.profFlag = startParams.GetProfFlag();
    initQsParams.enqueGroupIdExtra = bqs::EventGroupId::ENQUEUE_GROUP_ID_EXTRA;
    initQsParams.f2nfGroupIdExtra = bqs::EventGroupId::F2NF_GROUP_ID_EXTRA;
    uint32_t extraDevceId = 0U;
    if (resVec.size() > 1U) {
        extraDevceId = (resVec[0U] == deviceId) ? resVec[1U] : resVec[0U];
    }
    initQsParams.deviceIdExtra = extraDevceId;
    initQsParams.numaFlag = (resVec.size() > 1U);
    initQsParams.devIdVec = startParams.GetDevIdVec();
    initQsParams.needAttachGroup = true;
}
}

/**
 * main of queue schedule
 * @param  argc argv length
 * @param  argv arg values
 * @return 0:success, other:failed
 */
#ifndef aicpusd_UT
int32_t main(int32_t argc, char_t *argv[])
#else
int32_t QueueScheduleMain(int32_t argc, char_t *argv[])
#endif
{
    try {
        BQS_LOG_RUN_INFO("QueueSchedule begin");
        bqs::ArgsParser startParams;
        if (!startParams.ParseArgs(argc, argv)) {
            BQS_LOG_ERROR("Parse args failed");
            return -1;
        }

        BQS_LOG_RUN_INFO("Start parameter. %s", startParams.GetParaParsedStr().c_str());

        if (!startParams.GetWithLogLevel()) {
            bqs::SetLogLevelWithEnv(startParams);
        }

        const uint32_t vfId = startParams.GetVfId();
        const uint32_t hostPid = startParams.GetHostPid();
        uint32_t deviceId = startParams.GetDeviceId();
        const std::vector<uint32_t> resVec = startParams.GetResvec();
        BQS_LOG_RUN_INFO("resVec size is %zu", resVec.size());
        if (resVec.size() >= 1) {
            deviceId = resVec[0];
        }
        if ((bqs::GetRunContext() == bqs::RunContext::DEVICE) && (!bqs::BindCpuUtils::AddToCgroup(deviceId, vfId))) {
            return -1;
        }

        bqs::RegAicpuSchedulerModuleCallBack();

        auto& qsInterface = bqs::QueueScheduleInterface::GetInstance();

        bqs::InitQsParams initQsParams = {};
        bqs::InitQsInitParams(initQsParams, deviceId, hostPid, vfId, resVec, startParams);
        const auto bsqStatus = qsInterface.InitQueueScheduler(initQsParams);
        if (bsqStatus != bqs::BQS_STATUS_OK) {
            BQS_LOG_ERROR("QueueSchedule start failed, ret=%d .", bsqStatus);
            bqs::ReportErrorMsg(bsqStatus, deviceId, hostPid, vfId);
            bqs::CloseAicpuSdlibHandle();
            return -1;
        }
        BQS_LOG_RUN_INFO("QueueSchedule start success");
        // wait for shutdown
        int32_t waitRet = 0;
        if ((startParams.GetStarter() == bqs::QsStartType::START_BY_TSD) &&
            (bqs::GetRunContext() != bqs::RunContext::HOST)) {
            waitRet = TsdWaitForShutdown(deviceId, TSD_QS, hostPid, vfId);
        } else {
            // register a signal handler
            (void) std::signal(SIGTERM, static_cast<sighandler_t>(&bqs::HandleSignal));
            bqs::WaitShutdown();
        }
        int32_t ret = 0;
        if (waitRet != 0) {
            BQS_LOG_ERROR("Tsd wait for shut down return not ok, error code[%d].", waitRet);
            ret = -1;
        } else {
            BQS_LOG_INFO("Tsd wait for shut down success");
            ret = 0;
        }

        bqs::StopAiCpuSubModuleInQs(deviceId, hostPid, vfId);
        qsInterface.WaitForStop();
        (void)qsInterface.Destroy();
        BQS_LOG_RUN_INFO("QueueSchedule exit");
        return ret;
    } catch(...) {
        BQS_LOG_ERROR("QueueSchedule run exception.");
        return -1;
    }
}
