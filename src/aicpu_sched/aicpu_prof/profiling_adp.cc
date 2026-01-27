/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpu_prof/profiling_adp.h"
#include <vector>
#include <string>
#include <pthread.h>
#include <securec.h>
#include <thread>
#include <atomic>
#include <fstream>
#include "common/type_def.h"
#include "aicpu_context.h"
#include "aicpu_prof.h"
#include "prof_so_manager.h"
#include "aprof_pub.h"

namespace aicpu {
namespace {
thread_local std::shared_ptr<ProfMessage> g_prof(nullptr);
std::atomic<bool> g_profFlag(false);
std::atomic<bool> g_modelProfFlag(false);
std::atomic<bool> g_profAdditionalFlag(false);

#ifdef RUN_ON_AICPU
inline void AsmCntvc(uint64_t &cntvct)
{
    asm volatile("mrs %0, cntvct_el0" : "=r" (cntvct));
}

inline void AsmCntfrq(uint64_t &cntfrq)
{
    asm volatile("mrs %0, cntfrq_el0" : "=r" (cntfrq));
}
#endif
}
constexpr int32_t MAX_INNER_SEND_DATA_LEN = 1024;

#ifdef __cplusplus
extern "C" {
#endif

bool IsProfOpen()
{
    return g_profFlag;
}

bool IsModelProfOpen()
{
    return g_modelProfFlag;
}

/*****************************************************************************
Description   : it is used to get current micros
Input         : NA
Output        : NA
Return Value  : current micros
*****************************************************************************/
uint64_t NowMicros()
{
#ifdef RUN_ON_AICPU
    uint64_t cntvct;
    uint64_t cntfrq;
    AsmCntvc(cntvct);
    AsmCntfrq(cntfrq);
    return static_cast<uint64_t>(cntvct * 1000000ULL / cntfrq); //lint !e573
#else
    struct timespec ts;
    clock_gettime(CLOCK_REALTIME, &ts);
    return (static_cast<uint64_t>(ts.tv_sec) * 1000000000ULL + // Seconds to nanos
        static_cast<uint64_t>(ts.tv_nsec)) / 1000ULL; // Nanos to micros
#endif
}

/*****************************************************************************
Prototype     : GetSystemTick
Description   : it is used to get cpu tick
Input         : NA
Output        : NA
Return Value  : uint64_t tick
*****************************************************************************/
uint64_t GetSystemTick()
{
#ifdef RUN_ON_AICPU
    uint64_t cntvct;
    AsmCntvc(cntvct);
    return cntvct;
#else
    return 0;
#endif
}

/*****************************************************************************
Prototype     : GetSystemTickFreq
Description   : it is used to get cpu tick freq
Input         : NA
Output        : NA
Return Value  : uint64_t tick freq
*****************************************************************************/
uint64_t GetSystemTickFreq()
{
#ifdef RUN_ON_AICPU
    uint64_t cntfrq;
    AsmCntfrq(cntfrq);
    return cntfrq;
#else
    return 0;
#endif
}

/*****************************************************************************
Prototype     : GetMicrosAndSysTick
Description   : it is used to get now microsecond and cpu tick
Input         : uint64_t &micros : now micros
                uint64_t &tick : system tick
Output        : NA
Return Value  : void
*****************************************************************************/
void GetMicrosAndSysTick(uint64_t &micros, uint64_t &tick)
{
#ifdef RUN_ON_AICPU
    uint64_t cntvct;
    uint64_t cntfrq;
    AsmCntvc(cntvct);
    AsmCntfrq(cntfrq);
    micros = static_cast<uint64_t>(cntvct * 1000000ULL / cntfrq);
    tick = cntvct;
#else
    struct timespec ts;
    clock_gettime(CLOCK_REALTIME, &ts);
    micros = (static_cast<uint64_t>(ts.tv_sec) * 1000000000ULL + // Seconds to nanos
        static_cast<uint64_t>(ts.tv_nsec)) / 1000ULL; // Nanos to micros
    // not support tick when not run on aicpu
    tick = 0;
#endif
}

/*****************************************************************************
Description   : it is used to initialize the ProfilingAdp object and
                register instance to profiling
Input         : deviceId real device ID
Input         : hostPid host pid
Input         ：channelId is used to distinguish aicpu process or cust-aicpu process
Output        : NA
Return Value  : NA
*****************************************************************************/
void InitProfiling(const uint32_t deviceId, const pid_t hostPid, const uint32_t channelId)
{
    AICPU_LOG_INFO("Start init profiling.");
    const int32_t ret = ProfilingAdp::GetInstance().InitAicpuProfiling(deviceId, hostPid, channelId);
    AICPU_LOG_WHEN(ret != static_cast<int32_t>(ProfStatusCode::PROFILINE_SUCCESS),
                   "Failed to init profiling(%d).", ret);
}

/*****************************************************************************
Description   : it is used to initialize the ProfilingAdp object data info
Input         : deviceId real device ID
Input         : hostPid host pid
Output        : NA
Return Value  : NA
*****************************************************************************/
void InitProfilingDataInfo(const uint32_t deviceId, const pid_t hostPid, const uint32_t channelId)
{
    AICPU_LOG_INFO("Start init profiling data info.");
    ProfilingAdp::GetInstance().InitAicpuProfilingDataInfo(deviceId, hostPid, channelId);
}

void SetProfilingFlagForKFC(const uint32_t flag)
{
    ProfilingAdp::GetInstance().SetAicpuProfilingFlagForKFC(flag);
    const int32_t retInit = ProfilingAdp::GetInstance().ProfilingModeOpenProcess();
    AICPU_LOG_WHEN(retInit != static_cast<int32_t>(ProfStatusCode::PROFILINE_SUCCESS),
        "Failed init profiling(%d).", retInit);
}
void LoadProfilingLib()
{
    aicpu::ProfSoManager::GetInstance()->LoadSo();
    return;
}
/*****************************************************************************
Description   : return weather profiling has been initialized
Input         : NA
Output        : NA
Return Value  : bool weather profiling has been initialized
*****************************************************************************/
bool IsProfilingValid()
{
    return ProfilingAdp::GetInstance().GetReportValid();
}

/*****************************************************************************
Description   : it is used to send data to profiling for ProfData
Input         : std::const string& sendData : the data which it is need send to profiling
                std::string mark      : the mark of dataset
Output        : NA
Return Value  : NA
*****************************************************************************/
namespace {
void SendToProfilingForSimplify(const char_t * const sendData, const std::string &mark)
{
    if (g_profFlag) {
        const int32_t ret = ProfilingAdp::GetInstance().Send(sendData, mark);
        AICPU_LOG_WHEN(ret != static_cast<int32_t>(ProfStatusCode::PROFILINE_SUCCESS),
            "Failed send profiling data, ret[%d].", ret);
        AICPU_LOG_INFO("End of report profiling data");
    }
}
}

/*****************************************************************************
Description   : it is used to provide interface to DP module which can send data to profiling
Input         : std::const string& sendData : the data which it is need send to profiling
                std::string mark      : the mark of dataset
Output        : NA
Return Value  : NA
*****************************************************************************/
void SendToProfiling(const std::string &sendData, const std::string &mark)
{
    SendToProfilingForSimplify(PtrToPtr<const std::string, const char_t>(&sendData), mark);
}

void UpdateMode(const bool mode)
{
    AICPU_LOG_INFO("UpdateMode:profilingMode[%s]", mode ? "OPEN":"CLOSE");
    if (mode) {
        ProfilingAdp::GetInstance().UpdateModeProcess(mode);
    }
    g_profFlag = mode;
}

void UpdateModelMode(const bool mode)
{
    AICPU_LOG_INFO("UpdateModelMode:module[%s].", mode ? "OPEN" : "CLOSE");
    g_modelProfFlag = mode;
}

/*****************************************************************************
Description   : it is used to provide interface to DP module which can flush data to profiling
Input         : std::const string& sendData : the data which it is need send to profiling
                std::string mark      : the mark of dataset
Output        : NA
Return Value  : NA
*****************************************************************************/
void ReleaseProfiling()
{
    int32_t ret = ProfilingAdp::GetInstance().UninitProcess();
    AICPU_LOG_WHEN(ret != static_cast<int32_t>(ProfStatusCode::PROFILINE_SUCCESS),
        "Failed unit profiling(%d).", ret);
}

int32_t SetProfHandle(const std::shared_ptr<ProfMessage> profMsg)
{
    g_prof = profMsg;
    return 0;
}

int32_t SetMsprofReporterCallback(MsprofReporterCallback reportCallback)
{
    AICPU_LOG_INFO("Start set reporter callback function");
    ProfilingAdp::GetInstance().SetReportCallbackValid(true, reportCallback);
    return static_cast<int32_t>(ProfStatusCode::PROFILINE_SUCCESS);
}

bool IsSupportedProfData()
{
    return true;
}

#ifndef __clang__
std::shared_ptr<ProfMessage> GetProfHandle()
{
    return g_prof;
}
#endif

#ifdef __cplusplus
}
#endif

#ifdef __clang__
std::shared_ptr<ProfMessage> GetProfHandle()
{
    return g_prof;
}
#endif

/*****************************************************************************
Description   : Construct an simple prof agent.
Input         : const char_t* tag
Output        : NA
*****************************************************************************/
ProfMessage::ProfMessage(const char_t *tag) : std::basic_ostringstream<char_t>(), tag_(tag), sendData_()
{
    const auto ret = memset_s(&sendData_, sizeof(sendData_), 0x00, sizeof(sendData_));
    if (ret != EOK) {
        AICPU_LOG_ERROR("memset error ret:%d", ret);
    }
    AICPU_LOG_INFO("sendData_ has inited");
    const std::string mark = tag;
    if (mark == "DP") {
        (void)SetTimeStamp(NowMicros());
    } else {
        AICPU_LOG_INFO("mark is [%s].", mark.c_str());
    }
}

/*****************************************************************************
Description   : Call prof interface at the end of the object declaration cycle
Input         : NA
Output        : NA
*****************************************************************************/
ProfMessage::~ProfMessage()
{
    const std::string mark(tag_);
    if (mark == "AICPU") {
        SendToProfilingForSimplify(PtrToPtr<MsprofAicpuProfData, const char_t>(&sendData_.aicpuProfData), mark);
    } else if (mark == "DP") {
        SendToProfilingForSimplify(PtrToPtr<MsprofDpProfData, const char_t>(&sendData_.dPProfData), mark);
    } else {
        AICPU_LOG_INFO("Not send data, mark=%s.", mark.c_str());
    }
}

/*****************************************************************************
Description   : it is used to set report callback function valid
Input         : bool flag : if it is true,it means can send data through profiling.
                            otherwise,it must stop send data to profiling.
                MsprofReporterCallback reportCallback: the send report callback of profiling
Output        : NA
Return Value  : NA
*****************************************************************************/
void ProfilingAdp::SetReportCallbackValid(bool flag, MsprofReporterCallback profReportCallback)
{
    (void)flag;
    AICPU_LOG_INFO("Start enable reporter callback.");
    reportCallback_ = profReportCallback;
}

MsprofReporterCallback ProfilingAdp::GetMsprofReporterCallback(void)
{
    MsprofReporterCallback repCallBack = reportCallback_;
    return repCallBack;
}

/*****************************************************************************
Description   : the function need to
Input         : NA
Output        : NA
Return Value  : return a global and unique instance of class MapMarkAndGlobal
*****************************************************************************/
bool ProfilingAdp::GetReportValid(void)
{
    const bool aviableFlag = initFlag_;
    return aviableFlag;
}

/*****************************************************************************
Description   : it is used to send data to profiling
Input         : ReporterData& data : it need to send to profiling
Output        : NA
Return Value  : PROFILINE_SUCCESS - send data success
                others - send data failed
*****************************************************************************/
int32_t ProfilingAdp::SendProcess(ReporterData &data)
{
    AICPU_LOG_INFO("Call SendProcess to report message.");
    int32_t ret = static_cast<int32_t>(ProfStatusCode::PROFILINE_SUCCESS);
    if (initFlag_) {
        if (reportCallback_ != nullptr) {
            AICPU_LOG_INFO("Start to report profiling data using report callback.");
            ret = reportCallback_(MSPROF_MODULE_DATA_PREPROCESS, MSPROF_REPORTER_REPORT,
                                  &data, static_cast<uint32_t>(sizeof(data)));
        } else if (isProfApiSo_ == true){
            ;
        } else {
            AICPU_LOG_INFO("Start to report profiling data using AdprofReportData, tag=%s, len=%zu.",
                           data.tag, data.dataLen);
            ret = AdprofReportDataFunc(&data, static_cast<uint32_t>(sizeof(data)));
        }
    }
    return ret;
}

int32_t ProfilingAdp::SendAdditionalProcess(MsprofAdditionalInfo &additionalReportData)
{
    int32_t ret = static_cast<int32_t>(ProfStatusCode::PROFILINE_SUCCESS);
    if (initFlag_) {
        if (isProfApiSo_ == true) {
            AICPU_LOG_INFO("Call MsprofReportAdditionalInfoFunc to report message.");
            ret = MsprofReportAdditionalInfoFunc(0U, static_cast<void *>(&additionalReportData),
                                                sizeof(additionalReportData));
        } else {
            AICPU_LOG_INFO("Call AdprofReportAdditionalInfo to report message.");
            ret = AdprofReportAdditionalInfoFunc(0U, static_cast<void *>(&additionalReportData),
                                                sizeof(additionalReportData));
        }
    }
    return ret;
}

/*****************************************************************************
Description   : it is used to uninit profiling
Input         : NA
Output        : NA
Return Value  : PROFILINE_SUCCESS - uninit success
                others - uninit failed
*****************************************************************************/
int32_t ProfilingAdp::UninitProcess()
{
    if (!initFlag_) {
        AICPU_LOG_INFO("Profiling was not initialized.");
        return static_cast<int32_t>(ProfStatusCode::PROFILINE_SUCCESS);
    }
    int32_t retUnInit = 0;
    if (reportCallback_ != nullptr) {
        // rc场景下仅需执行reportCallback_函数的退出
        retUnInit = reportCallback_(MSPROF_MODULE_DATA_PREPROCESS, MSPROF_REPORTER_UNINIT, nullptr, 0U);
    } else if ((!g_profAdditionalFlag) && (isProfApiSo_ == false)) {
        // 非rc场景，老的HDC上报流程需要执行AdprofAicpuStopFunc保证退出时不会漏数据
        retUnInit = AdprofAicpuStopFunc();
    }
    if (retUnInit == static_cast<int32_t>(ProfStatusCode::PROFILINE_SUCCESS)) {
        aicpu::ProfSoManager::GetInstance()->UnloadSo();
        profilingFlag_ = 0;
        initFlag_ = false;
    }
    return retUnInit;
}

/*****************************************************************************
Description   : it is used to initialize the ProfilingAdp object and
                register instance to profiling
Input         : uint32_t deviceId: real device ID
Input         : pid_t hostPid: host pid
Output        : NA
Return Value  : PROFILINE_SUCCESS - init success
                others - init failed
*****************************************************************************/
int32_t ProfilingAdp::InitAicpuProfiling(const uint32_t deviceId, const pid_t hostPid, const uint32_t channelId)
{
    InitAicpuProfilingDataInfo(deviceId, hostPid, channelId);
    ProfSoManager::GetInstance()->LoadSo();
    return ProfilingModeOpenProcess();
}

/*****************************************************************************
Description   : it is used to initialize the ProfilingAdp object and
                register instance to profiling
Input         : uint32_t deviceId: real device ID
Input         : pid_t hostPid: host pid
Output        : NA
Return Value  : NA
*****************************************************************************/
void ProfilingAdp::InitAicpuProfilingDataInfo(const uint32_t deviceId, const pid_t hostPid, const uint32_t channelId)
{
    deviceId_ = deviceId;
    hostPid_ = hostPid;
    channelId_ = channelId;
}

void ProfilingAdp::SetAicpuProfilingFlagForKFC(const uint32_t flag)
{
    profilingFlag_ = flag;
}

int32_t AicpuStartCallback()
{
    AICPU_RUN_INFO("call AicpuStartCallback.");
    g_profAdditionalFlag = true;
    return 0;
}

int32_t ProfilingAdp::ProfilingModeOpenProcess()
{
    int32_t retInit = 0;
    if (reportCallback_ != nullptr) {
        retInit = reportCallback_(MSPROF_MODULE_DATA_PREPROCESS, MSPROF_REPORTER_INIT, nullptr, 0U);
    } else {
        AICPU_LOG_INFO("call AdprofAicpuStartRegister. flag[%x], channelId[%u]", profilingFlag_, channelId_);
        AicpuStartPara regPara = {};
        regPara.devId = deviceId_;
        regPara.hostPid = static_cast<uint32_t>(hostPid_);
        regPara.channelId = channelId_;
        regPara.profConfig = profilingFlag_;
        if (isProfApiSo_ == true) {
            retInit = MsprofInitFunc(MSPROF_CTRL_INIT_AICPU, &regPara, sizeof(AicpuStartPara));
        } else {
            retInit = AdprofAicpuStartRegisterFunc(AicpuStartCallback, &regPara);
        }
    }
    return retInit;
}

/*****************************************************************************
Description   : it is used to initialize update mode
Input         : bool mode: true:open false:close
Output        : NA
Return Value  : NA
*****************************************************************************/
void ProfilingAdp::UpdateModeProcess(const bool mode)
{
    (void)mode;
    initFlag_ = true;
    return;
}

/*****************************************************************************
Description   : it is used to new memory to store data
Input         : int32_t sendSize             : the size of data
                const string& sendData         : the source data
                ReporterData& reportData : the data which need to send
Output        : NA
Return Value  : if it is true,it means success to new memory.
*****************************************************************************/
bool ProfilingAdp::NewMemoryToStoreData(int32_t sendSize,
                                        const std::string &sendData,
                                        ReporterData &reportData) const //lint !e1072
{
    const int32_t newLen = sendSize + 1;
    AICPU_RCHECK(newLen > 0, false, "Malloc size must be greater than zero, length is %d", newLen);
    uint8_t * const rdata = static_cast<uint8_t *>(
                                  malloc(sizeof(uint8_t) * static_cast<size_t>(newLen)));
    AICPU_RCHECK(rdata != nullptr, false, "Memory for new profiling data malloc failed");
    // met Exceptions, no need to checks for security functions
    auto ret = memset_s(rdata, static_cast<size_t>(newLen), 0, static_cast<size_t>(newLen));
    if (ret != EOK) {
        AICPU_LOG_ERROR("Set buffer failed, ret[%d]", ret);
        free(rdata);
        return false;
    }
    ret = memcpy_s(rdata, static_cast<size_t>(newLen),
                   sendData.c_str(), static_cast<size_t>(sendSize));
    if (ret != EOK) {
        AICPU_LOG_ERROR("Copy send data to buffer failed, ret[%d]", ret);
        free(rdata);
        return false;
    }

    reportData.data = rdata;

    return true;
}

/*****************************************************************************
Description   : it is used to create the content
Input         : const string& sendData         : the source data
                const string& mark             : the mark of dataset
                char_t buffer[]            : it is used to store data
                int32_t bufferlen        : the size of buffer
                bool& newflag            : if it is true,it means new memory to store data
                ReporterData& reportData : it is struct of profiling data package
Output        : NA
Return Value  : if it is true,it means success to create the content
*****************************************************************************/
bool ProfilingAdp::BuildSendContent(const std::string &sendData, const std::string &mark,
                                    char_t buffer[], const int32_t bufferlen,
                                    bool &newflag, ReporterData &reportData) const
{
    const int32_t sendSize = static_cast<int32_t>(sendData.size());
    reportData.deviceId = static_cast<int32_t>(deviceId_);
    reportData.dataLen = static_cast<size_t>(sendSize) + static_cast<size_t>(1LU);

    if (sendSize < bufferlen) {
        errno_t err = EOK;
        err = memcpy_s(buffer, static_cast<size_t>(bufferlen), sendData.c_str(), static_cast<size_t>(sendSize));
        AICPU_RCHECK(err == EOK, false, "Copy send data to buffer failed");
        reportData.data = PtrToPtr<char_t, uint8_t>(buffer);
        newflag = false;
    } else {
        AICPU_RCHECK(NewMemoryToStoreData(sendSize, sendData, reportData), false,
            "Malloc new memory for send data failed");
        newflag = true;
    }
    reportData.data[sendSize] = static_cast<uint8_t>('\0');
    const errno_t retCpy = strncpy_s(reportData.tag, static_cast<size_t>(MSPROF_ENGINE_MAX_TAG_LEN + 1),
                                     mark.c_str(), static_cast<size_t>(MSPROF_ENGINE_MAX_TAG_LEN));
    if (retCpy != EOK) {
        AICPU_LOG_WARN("copy reportData tag not success, retCpy=[%d].", retCpy);
    }

    reportData.tag[MSPROF_ENGINE_MAX_TAG_LEN] = '\0';
    return true;
}

/*****************************************************************************
Description   : it is used to create the content for AICPU
Input         : const ProfData& sendData         : the source data
                const string& mark             : the mark of dataset
                ReporterData& reportData : it is struct of profiling data package
Output        : NA
Return Value  : NA
*****************************************************************************/
template <typename T>
void ProfilingAdp::BuildProfData(const T &sendData, const std::string &mark,
                                 ReporterData &reportData) const
{
    reportData.deviceId = static_cast<int32_t>(deviceId_);
    reportData.dataLen = sizeof(sendData);
    reportData.data = reinterpret_cast<uint8_t *>(const_cast<T *>(&sendData));
    const errno_t retCpy = strncpy_s(reportData.tag, static_cast<size_t>(MSPROF_ENGINE_MAX_TAG_LEN + 1),
                                     mark.c_str(), static_cast<size_t>(MSPROF_ENGINE_MAX_TAG_LEN));
    if (retCpy != EOK) {
        AICPU_LOG_WARN("copy reportData tag not success, retCpy=[%d].", retCpy);
    }

    reportData.tag[MSPROF_ENGINE_MAX_TAG_LEN] = '\0';
}

void ProfilingAdp::BuildProfAicpuAdditionalData(const MsprofAicpuProfData &sendData,
                                                MsprofAdditionalInfo &reportData) const
{
    reportData.level = MSPROF_REPORT_AICPU_LEVEL;
    reportData.type = MSPROF_REPORT_AICPU_NODE_TYPE;
    reportData.threadId = sendData.threadId;
    reportData.timeStamp = GetSystemTick();

    auto data = reinterpret_cast<MsprofAicpuNodeAdditionalData *>(reportData.data);
    data->streamId = sendData.streamId;
    data->taskId = sendData.taskId;
    data->runStartTime = sendData.runStartTime;
    data->runStartTick = sendData.runStartTick;
    data->computeStartTime = sendData.computeStartTime;
    data->memcpyStartTime = sendData.memcpyStartTime;
    data->memcpyEndTime = sendData.memcpyEndTime;
    data->runEndTime = sendData.runEndTime;
    data->runEndTick = sendData.runEndTick;
    data->threadId = sendData.threadId;
    data->deviceId = sendData.deviceId;
    data->submitTick = sendData.submitTick;
    data->scheduleTick = sendData.scheduleTick;
    data->tickBeforeRun = sendData.tickBeforeRun;
    data->tickAfterRun = sendData.tickAfterRun;
    data->kernelType = sendData.kernelType;
    data->dispatchTime = sendData.dispatchTime;
    data->totalTime = sendData.totalTime;
    data->fftsThreadId = sendData.fftsThreadId;
    data->version = sendData.version;

    reportData.dataLen = sizeof(MsprofAicpuNodeAdditionalData);
    AICPU_LOG_INFO("aicpu prof message details: streamId[%hu], taskId[%hu], runStartTime[%llu], runStartTick[%llu], "
                   "computeStartTime[%llu], memcpyStartTime[%llu], memcpyEndTime[%llu], runEndTime[%llu], "
                   "runEndTick[%llu], threadId[%u], deviceId[%u], submitTick[%llu], scheduleTick[%llu], "
                   "tickBeforeRun[%llu], tickAfterRun[%llu], kernelType[%u], dispatchTime[%u]us, totalTime[%u]us, "
                   "fftsThreadId[%u], version[%u], dataLen[%u].", data->streamId, data->taskId, data->runStartTime,
                   data->runStartTick, data->computeStartTime, data->memcpyStartTime, data->memcpyEndTime,
                   data->runEndTime, data->runEndTick, data->threadId, data->deviceId, data->submitTick,
                   data->scheduleTick, data->tickBeforeRun, data->tickAfterRun, data->kernelType, data->dispatchTime,
                   data->totalTime, data->fftsThreadId, data->version, reportData.dataLen);
}

void ProfilingAdp::BuildProfDpAdditionalData(const MsprofDpProfData &sendData, MsprofAdditionalInfo &reportData) const
{
    reportData.level = MSPROF_REPORT_AICPU_LEVEL;
    reportData.type = MSPROF_REPORT_AICPU_DP_TYPE;
    reportData.threadId = 0xffffffff;
    reportData.timeStamp = GetSystemTick();

    auto data = reinterpret_cast<MsprofAicpuDpAdditionalData *>(reportData.data);
    errno_t retCpy = strncpy_s(data->action, static_cast<size_t>(MSPROF_DP_DATA_ACTION_LEN),
                               sendData.action, static_cast<size_t>(MSPROF_DP_DATA_ACTION_LEN));
    if (retCpy != EOK) {
        AICPU_LOG_WARN("copy sendData.action tag not success, retCpy=[%d].", retCpy);
    }
    retCpy = strncpy_s(data->source, static_cast<size_t>(MSPROF_DP_DATA_SOURCE_LEN),
                       sendData.source, static_cast<size_t>(MSPROF_DP_DATA_SOURCE_LEN));
    if (retCpy != EOK) {
        AICPU_LOG_WARN("copy sendData.source tag not success, retCpy=[%d].", retCpy);
    }
    data->index = sendData.index;
    data->size = sendData.size;

    reportData.dataLen = sizeof(MsprofAicpuDpAdditionalData);
    AICPU_LOG_INFO("dp prof message details: action[%s], source[%s], index[%llu], size[%llu], dataLen[%u].",
                   data->action, data->source, data->index, data->size, reportData.dataLen);
}

void ProfilingAdp::BuildProfMiAdditionalData(const std::string &sendData, MsprofAdditionalInfo &reportData) const
{
    reportData.level = MSPROF_REPORT_AICPU_LEVEL;
    reportData.type = MSPROF_REPORT_AICPU_MI_TYPE;
    reportData.threadId = 0xffffffff;
    reportData.timeStamp = GetSystemTick();

    std::vector<std::string> data;
    std::string tmpSendData = sendData + ",";
    auto posComma = tmpSendData.find(",");

    while (posComma != tmpSendData.npos) {
        std::string temp = tmpSendData.substr(0, posComma);
        auto posColon = temp.find(":");
        data.push_back(temp.substr(posColon + 1, temp.size() - posColon));
        tmpSendData = tmpSendData.substr(posComma + 1, tmpSendData.size());
        posComma = tmpSendData.find(",");
    }
    if (data.size() != TOTAL_LEN) {
        AICPU_LOG_ERROR("Data format is not as expected.");
        return;
    }

    auto repData = reinterpret_cast<MsprofAicpuMiAdditionalData *>(reportData.data);
    repData->nodeTag = GET_NEXT_DEQUEUE_WAIT;
    try {
        repData->queueSize = stoul(data[QUEUE_SIZE]);
        repData->runStartTime = stoul(data[RUN_START_TIME]);
        repData->runEndTime = stoul(data[RUN_END_TIME]);
    } catch(...) {
        AICPU_LOG_ERROR("mindspore prof message details: %s", sendData.c_str());
    }

    reportData.dataLen = sizeof(MsprofAicpuMiAdditionalData);
    AICPU_LOG_INFO("mindspore prof message details: node[%u], queueSize[%llu], runStartTime[%llu], "
                   "runEndTime[%llu], dataLen[%u].", repData->nodeTag, repData->queueSize,
                   repData->runStartTime, repData->runEndTime, reportData.dataLen);
}

int32_t ProfilingAdp::SendProfDataWithNewChannel(const char_t * const sendData, std::string mark)
{
    MsprofAdditionalInfo additionalReportData;
    if (mark == "AICPU") {
        BuildProfAicpuAdditionalData(*PtrToPtr<const char_t, const MsprofAicpuProfData>(sendData),
                                     additionalReportData);
    } else if (mark == "DP") {
        BuildProfDpAdditionalData(*PtrToPtr<const char_t, const MsprofDpProfData>(sendData), additionalReportData);
    } else {
        BuildProfMiAdditionalData(*PtrToPtr<const char_t, const std::string>(sendData), additionalReportData);
    }
    int32_t ret = SendAdditionalProcess(additionalReportData);
    return ret;
}

int32_t ProfilingAdp::SendProfDataWithOldChannel(const char_t * const sendData, std::string mark)
{
    ReporterData reportData;
    bool needNewFlag = false;
    if (mark == "AICPU") {
        BuildProfData<MsprofAicpuProfData>(*PtrToPtr<const char_t, const MsprofAicpuProfData>(sendData), mark,
                                           reportData);
    } else if (mark == "DP") {
        BuildProfData<MsprofDpProfData>(*PtrToPtr<const char_t, const MsprofDpProfData>(sendData), mark,
                                        reportData);
    } else {
        AICPU_RCHECK((PtrToPtr<const char_t, const std::string>(sendData))->size() > 0U,
                     static_cast<int32_t>(ProfStatusCode::PROFILINE_FAILED), "Check send size failed");
        char_t buffer[MAX_INNER_SEND_DATA_LEN] = {}; //lint !e813
        const bool ret = BuildSendContent(*PtrToPtr<const char_t, const std::string>(sendData),
                                          mark, &buffer[0], MAX_INNER_SEND_DATA_LEN, needNewFlag, reportData);
        AICPU_RCHECK(ret, static_cast<int32_t>(ProfStatusCode::PROFILINE_FAILED), "Build send content failed.");
    }
    int32_t ret = SendProcess(reportData);
    if (needNewFlag && (reportData.data != nullptr)) {
        // Newly created data memory needs to be released
        free(reportData.data);
        reportData.data = nullptr;
    }
    return ret;
}

/*****************************************************************************
Description   : it is used to provide interface to DP module which can send data to profiling
Input         : std::const string& sendData : the data which it is need send to profiling
                std::string mark      : the mark of dataset
Output        : NA
Return Value  : PROFILINE_SUCCESS - send success
                others - end failed
*****************************************************************************/
int32_t ProfilingAdp::Send(const char_t * const sendData, std::string mark)
{
    if (!GetReportValid()) {
        AICPU_LOG_WARN("Report invalid.");
        return static_cast<int32_t>(ProfStatusCode::PROFILINE_SUCCESS);
    }

    if (mark.empty()) {
        AICPU_LOG_WARN("No mark was set, use 'DEFAULT' as tag");
        mark = "DEFAULT";
    }
    int32_t ret = 0;
    if ((g_profAdditionalFlag && reportCallback_ == nullptr) || (isProfApiSo_ == true)) {
        ret = SendProfDataWithNewChannel(sendData, mark);
    } else {
        ret = SendProfDataWithOldChannel(sendData, mark);
    }

    if (ret == static_cast<int32_t>(ProfStatusCode::PROFILINE_SUCCESS) && mark == "AICPU") {
        counter.AicpuMesCountInc();
    } else if (ret == static_cast<int32_t>(ProfStatusCode::PROFILINE_SUCCESS) && mark == "DP") {
        counter.DpMesCountInc();
    } else if (ret == static_cast<int32_t>(ProfStatusCode::PROFILINE_SUCCESS)) {
        counter.MiMesCountInc();
    }
    return ret;
}

int32_t ProfModelMessage::SendProfModelMessageWithNewChannel()
{
    MsprofAdditionalInfo additionalReportData;
    BuildProfModelAdditionalData(additionalReportData);
    int32_t ret = ProfilingAdp::GetInstance().SendAdditionalProcess(additionalReportData);
    return ret;
}

int32_t ProfModelMessage::SendProfModelMessageWithOldChannel()
{
    ReporterData reportData;
    reportData.deviceId = static_cast<int32_t>(deviceId_);
    reportData.dataLen = sizeof(sendData_);
    reportData.data = PtrToPtr<void, uint8_t>(static_cast<void *>(&sendData_));
    AICPU_LOG_DEBUG("Report model profiling message, dev_id=%u, dataLen=%zu, timeStamp=%llu, tag_id=%u, "
                    "index_id=%llu, model_id=%u, event_id=%llu, dataTag=%u.", deviceId_, reportData.dataLen,
                    sendData_.aicpuModelProfData.timeStamp,
                    static_cast<uint32_t>(sendData_.aicpuModelProfData.tagId),
                    sendData_.aicpuModelProfData.indexId,
                    sendData_.aicpuModelProfData.modelId,
                    sendData_.aicpuModelProfData.eventId,
                    static_cast<uint32_t>(sendData_.aicpuModelProfData.dataTag));
    const std::string tagStr(tag_);
    const errno_t retCpy = strncpy_s(reportData.tag, static_cast<size_t>(MSPROF_ENGINE_MAX_TAG_LEN + 1),
                                     tagStr.c_str(), static_cast<size_t>(MSPROF_ENGINE_MAX_TAG_LEN));
    if (retCpy != EOK) {
        AICPU_LOG_WARN("copy reportData tag not success, retCpy=[%d].", retCpy);
    }
    reportData.tag[MSPROF_ENGINE_MAX_TAG_LEN] = '\0';
    int32_t ret = ProfilingAdp::GetInstance().SendProcess(reportData);
    return ret;
}

int32_t ProfModelMessage::ProfModelMessage::ReportProfModelMessage()
{
    int32_t ret = 0;
    if ((g_profAdditionalFlag && ProfilingAdp::GetInstance().GetMsprofReporterCallback() == nullptr) || (ProfilingAdp::GetInstance().IsProfApiSo() == true)) {
        ret = SendProfModelMessageWithNewChannel();
    } else {
        ret = SendProfModelMessageWithOldChannel();
    }

    if (ret == static_cast<int32_t>(ProfStatusCode::PROFILINE_SUCCESS)) {
        ProfilingAdp::GetInstance().counter.ModelMesCountInc();
    }
    return ret;
}

void ProfModelMessage::BuildProfModelAdditionalData(MsprofAdditionalInfo &reportData)
{
    reportData.level = MSPROF_REPORT_AICPU_LEVEL;
    reportData.type = MSPROF_REPORT_AICPU_MODEL_TYPE;
    reportData.threadId = 0xffffffff;
    reportData.timeStamp = sendData_.aicpuModelProfData.timeStamp;

    auto data = reinterpret_cast<MsprofAicpuModelAdditionalData *>(reportData.data);
    data->indexId = sendData_.aicpuModelProfData.indexId;
    data->modelId = sendData_.aicpuModelProfData.modelId;
    data->tagId = sendData_.aicpuModelProfData.tagId;
    data->eventId = sendData_.aicpuModelProfData.eventId;

    reportData.dataLen = sizeof(MsprofAicpuModelAdditionalData);
    AICPU_LOG_INFO("Model prof message details: indexId[%llu], modelId[%u], tagId[%hu], eventId[%llu], dataLen[%u].",
                   data->indexId, data->modelId, data->tagId, data->eventId, reportData.dataLen);
}
} // namespace aicpu