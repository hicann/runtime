/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROFILING_ADP_H
#define PROFILING_ADP_H

#include <string>
#include <cstring>
#include <ostream>
#include <sstream>
#include <memory>
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include "securec.h"
#include "prof_api.h"
#include "prof_dev_api.h"
#include "dlog_pub.h"
#include "common/type_def.h"

#ifdef __cplusplus
#ifndef LOG_CPP
extern "C" {
#endif
#endif // __cplusplus
LOG_FUNC_VISIBILITY int32_t __attribute__((weak)) CheckLogLevel(int32_t moduleId, int32_t logLevel);
LOG_FUNC_VISIBILITY void __attribute((weak)) DlogRecord(int32_t moduleId, int32_t level, const char *fmt, ...);
#ifdef __cplusplus
#ifndef LOG_CPP
}
#endif // LOG_CPP
#endif // __cplusplus

namespace aicpu {
constexpr uint8_t AICPU_PROF_VERSION = 0U;
constexpr uint32_t MODEL_EXECUTE_START = 0U;
constexpr uint32_t MODEL_EXECUTE_END = 1U;

constexpr uint32_t PROFILING_FEATURE_SWITCH = 0U;       // bit0 means profiling start or profiling stop
constexpr uint32_t PROFILING_FEATURE_KERNEL_MODE = 1U;  // bit1 means profiling mode of kernel
constexpr uint32_t PROFILING_FEATURE_MODEL_MODE = 2U;   // bit2 means profiling mode of model

union ProfData {
    ProfData() {}
    ~ProfData() {}
    MsprofAicpuProfData aicpuProfData;
    MsprofDpProfData dPProfData;
};

struct ProfModelData {
    ProfModelData() {}
    ~ProfModelData() {}
    MsprofAicpuModelProfData aicpuModelProfData;
};

inline uint64_t ProfGetTid()
{
    thread_local static const uint64_t TID = static_cast<uint64_t>(syscall(__NR_gettid));
    return TID;
}

#define AICPU_LOG_DEBUG(format, ...)                                                                                \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                                  \
        dlog_debug(static_cast<int32_t>(CCECPU), "[tid:%lu]:" format, ProfGetTid, ##__VA_ARGS__);                   \
    }
#define AICPU_LOG_INFO(format, ...)                                                                                 \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                                  \
        dlog_info(static_cast<int32_t>(CCECPU), "[tid:%lu]:" format, ProfGetTid, ##__VA_ARGS__);                    \
    }
#define AICPU_LOG_WARN(format, ...)                                                                                 \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                                  \
        dlog_warn(static_cast<int32_t>(CCECPU), "[tid:%lu]:" format, ProfGetTid, ##__VA_ARGS__);                    \
    }
#define AICPU_LOG_ERROR(format, ...)                                                                                \
    if (&DlogRecord != nullptr) {                                                                                   \
        dlog_error(static_cast<int32_t>(CCECPU), "[tid:%lu]:" format, ProfGetTid, ##__VA_ARGS__);                   \
    }
#define AICPU_RUN_INFO(format, ...)                                                                                 \
    if ((&CheckLogLevel != nullptr) && (&DlogRecord != nullptr)) {                                                  \
        dlog_info(static_cast<int32_t>(static_cast<uint32_t>(CCECPU) | static_cast<uint32_t>(RUN_LOG_MASK)),        \
                  "[tid:%lu]:" format, ProfGetTid, ##__VA_ARGS__);                                                  \
    }

#define AICPU_LOG_WHEN(cond, log, ...)         \
    if (cond) {                          \
        AICPU_LOG_ERROR(log, ##__VA_ARGS__) \
    }

#define AICPU_RCHECK(cond, ret, log, ...)      \
    if (!(cond)) {                       \
        AICPU_LOG_ERROR(log, ##__VA_ARGS__) \
        return ret;                      \
    }

class ProfMessage;

#ifdef __cplusplus
extern "C" {
#endif

/*****************************************************************************
Prototype     : IsProfOpen
Description   : judge if profiling is open
Input         : NA
Output        : NA
Return Value  : bool profiling flag
1.Date        : 2021/10/09
Modification  : Created function

*****************************************************************************/
bool __attribute__((weak)) IsProfOpen();

/*****************************************************************************
Prototype     : IsModelProfOpen
Description   : judge if model level profiling is open
Input         : NA
Output        : NA
Return Value  : bool profiling flag
1.Date        : 2022/2/11
Modification  : Created function

*****************************************************************************/
bool __attribute__((weak)) IsModelProfOpen();

/*****************************************************************************
Prototype     : NowMicros
Description   : it is used to get current micros
Input         : NA
Output        : NA
Return Value  : uint64_t current micros
Calls         : NA NA
Called By     : cp custcp

History       : NA
1.Date        : 2019/4/12
Modification  : Created function

*****************************************************************************/
uint64_t __attribute__((weak)) NowMicros();
/*****************************************************************************
Prototype     : GetSystemTick
Description   : it is used to get cpu tick
Input         : NA
Output        : NA
Return Value  : uint64_t tick
Calls         : NA
Called By     : cp custcp

History       : NA
1.Date        : 2020/6/12
Modification  : Created function

*****************************************************************************/
uint64_t __attribute__((weak)) GetSystemTick();
/*****************************************************************************
Prototype     : GetSystemTickFreq
Description   : it is used to get cpu tick freq
Input         : NA
Output        : NA
Return Value  : uint64_t tick freq
Calls         : NA
Called By     : cp custcp

History       : NA
1.Date        : 2020/6/22
Modification  : Created function

*****************************************************************************/
uint64_t __attribute__((weak)) GetSystemTickFreq();
/*****************************************************************************
Prototype     : GetMicrosAndSysTick
Description   : it is used to get now microsecond and cpu tick
Input         : uint64_t &micros : now micros
                uint64_t &tick : system tick
Output        : NA
Return Value  : void
Calls         : NA
Called By     : cp custcp

History       : NA
1.Date        : 2020/6/22
Modification  : Created function

*****************************************************************************/
void __attribute__((weak)) GetMicrosAndSysTick(uint64_t &micros, uint64_t &tick);
/*****************************************************************************
Prototype     : InitProfiling
Description   : it is used to initialize the ProfilingAdp object and
                register instance to profiling
Input         : deviceId real device ID
Input         : hostPid host pid
Output        : NA
Return Value  : NA
Calls         : NA
Called By     : cp custcp

History       : NA
1.Date        : 2019/4/12
Modification  : Created function

*****************************************************************************/
void __attribute__((weak)) InitProfiling(const uint32_t deviceId, const pid_t hostPid, const uint32_t channelId);
/*****************************************************************************
Prototype     : IsProfilingValid
Description   : return weather profiling has been initialized
Input         : NA
Output        : NA
Return Value  : bool weather profiling has been initialized
Calls         : NA
Called By     : cp custcp modules who call send

History       : NA
1.Date        : 2019/4/12
Modification  : Created function

*****************************************************************************/
bool __attribute__((weak)) IsProfilingValid();
/*****************************************************************************
Prototype     : SendToProfiling
Description   : it is used to provide interface to DP module which can send data to profiling
Input         : const std::string& sendData : the data which it is need send to profiling
                std::string mark      : the mark of dataset
Output        : NA
Return Value  : NA
Calls         : NA
Called By     : cp custcp

History       : NA
1.Date        : 2019/4/12
Modification  : Created function

*****************************************************************************/
void __attribute__((weak)) SendToProfiling(const std::string &sendData, const std::string &mark);
/*****************************************************************************
Prototype     : UpdateMode
Description   : it is used to provide interface to DP module which can update profiling mode
Input         : bool mode : OPEN or CLOSE
Output        : NA
Return Value  : NA
Calls         : NA
Called By     : cp custcp

History       : NA
1.Date        : 2020/11/02
Modification  : Created function

*****************************************************************************/
void __attribute__((weak)) UpdateMode(const bool mode);

/*****************************************************************************
Prototype     : UpdateModelMode
Description   : it is used to provide interface to set model level switch
Input         : const bool mode : profiling model level switch
Output        : NA
Return Value  : NA
Calls         : NA
Called By     : cp custcp

History       : NA
1.Date        : 2022/2/11
Modification  : Created function

*****************************************************************************/
void __attribute__((weak)) UpdateModelMode(const bool mode);

/*****************************************************************************
Prototype     : ReleaseProfiling
Description   : it is used to release all resource.
                register instance to profiling
Input         : NA
Output        : NA
Return Value  : NA
Calls         : NA
Called By     : cp custcp

History       : NA
1.Date        : 2019/4/12
Modification  : Created function

*****************************************************************************/
void __attribute__((weak)) ReleaseProfiling(void);

/*****************************************************************************
Prototype     : SetProfHandle
Description   : it is used to set prof handle
Input         : profMsg prof handle
Output        : NA
Return Value  : int32 0:succes, other: fail
Calls         : NA
Called By     : cp custcp

History       : NA
1.Date        : 2020/9/18
Modification  : Created function

*****************************************************************************/
int32_t __attribute__((weak)) SetProfHandle(const std::shared_ptr<ProfMessage> profMsg);

/*****************************************************************************
Prototype     : SetMsprofReporterCallback
Description   : it is used to set report callback function
Input         : report callback function
Output        : NA
Return Value  : int32 0:succes, other: fail
Calls         : NA
Called By     : cp custcp

History       : NA
1.Date        : 2020/12/11
Modification  : Created function

*****************************************************************************/
int32_t __attribute__((weak)) SetMsprofReporterCallback(MsprofReporterCallback reportCallback);

/*****************************************************************************
Prototype     : IsSupportedProfData
Description   : it is used to judge whether ProfData is supported
Input         : NA
Output        : NA
Return Value  : bool whether ProfData is supported
Calls         : NA
Called By     : cp custcp

History       : NA
1.Date        : 2021/11/15
Modification  : Created function

*****************************************************************************/
bool __attribute__((weak)) IsSupportedProfData();

/*****************************************************************************
Prototype     : GetProfHandle
Description   : it is used to get prof handle
Input         : NA
Output        : NA
Return Value  : ProfMessage prof handle
Calls         :
Called By     :

History       :
1.Date        : 2020/9/18
Modification  : Created function

*****************************************************************************/
#ifndef __clang__
std::shared_ptr<ProfMessage> __attribute__((weak)) GetProfHandle();
#endif

int32_t __attribute__((weak)) AicpuStartCallback();

#ifdef __cplusplus
}
#endif

/*****************************************************************************
Prototype     : GetProfHandle
Description   : it is used to get prof handle
Input         : NA
Output        : NA
Return Value  : ProfMessage prof handle
Calls         :
Called By     :

History       :
1.Date        : 2020/9/18
Modification  : Created function

*****************************************************************************/
#ifdef __clang__
std::shared_ptr<ProfMessage> __attribute__((weak)) GetProfHandle();
#endif

enum class ProfStatusCode : int32_t {
    PROFILINE_FAILED = -1,
    PROFILINE_SUCCESS = 0
};

class ProfModelMessage : public std::basic_ostringstream<char_t> {
public:
    explicit ProfModelMessage(const char_t *tag) : std::basic_ostringstream<char_t>(), tag_(tag),
                                                   sendData_(), deviceId_(UINT16_MAX) {};
    virtual ~ProfModelMessage() = default;
    ProfModelMessage *SetDataTagId(const uint16_t dataTagId)
    {
        sendData_.aicpuModelProfData.dataTag = dataTagId;
        return this;
    }
    ProfModelMessage *SetAicpuModelIterId(const uint16_t indexId)
    {
        sendData_.aicpuModelProfData.indexId = indexId;
        return this;
    }
    ProfModelMessage *SetAicpuModelTimeStamp(const uint64_t timeStamp)
    {
        sendData_.aicpuModelProfData.timeStamp = timeStamp;
        return this;
    }
    ProfModelMessage *SetAicpuModelId(const uint32_t modelId)
    {
        sendData_.aicpuModelProfData.modelId = modelId;
        return this;
    }
    ProfModelMessage *SetAicpuTagId(const uint16_t tagId)
    {
        sendData_.aicpuModelProfData.tagId = tagId;
        return this;
    }
    ProfModelMessage *SetEventId(const uint16_t eventId)
    {
        sendData_.aicpuModelProfData.eventId = eventId;
        return this;
    }
    ProfModelMessage *SetDeviceId(const uint32_t deviceId)
    {
        deviceId_ = deviceId;
        return this;
    }
    int32_t ReportProfModelMessage();

    int32_t SendProfModelMessageWithNewChannel();

    int32_t SendProfModelMessageWithOldChannel();

    void BuildProfModelAdditionalData(MsprofAdditionalInfo &reportData);
private:
    ProfModelMessage(const ProfModelMessage&) = delete;
    ProfModelMessage& operator=(const ProfModelMessage&) = delete;
    const char_t *tag_;
    ProfModelData sendData_;
    uint32_t deviceId_;
};

class ProfMessage : public std::basic_ostringstream<char_t> {
public:
    explicit ProfMessage(const char_t* tag);
    virtual ~ProfMessage();
    ProfMessage *SetAicpuMagicNumber(const uint16_t aicpuMagicNumber)
    {
        sendData_.aicpuProfData.magicNumber = aicpuMagicNumber;
        return this;
    }
    ProfMessage *SetAicpuDataTag(const uint16_t aicpuDataTag)
    {
        sendData_.aicpuProfData.dataTag = aicpuDataTag;
        return this;
    }
    ProfMessage *SetStreamId(const uint16_t streamId)
    {
        sendData_.aicpuProfData.streamId = streamId;
        return this;
    }
    ProfMessage *SetTaskId(const uint16_t taskId)
    {
        sendData_.aicpuProfData.taskId = taskId;
        return this;
    }
    ProfMessage *SetRunStartTime(const uint64_t runStartTime)
    {
        sendData_.aicpuProfData.runStartTime = runStartTime;
        return this;
    }
    ProfMessage *SetRunStartTick(const uint64_t runStartTick)
    {
        sendData_.aicpuProfData.runStartTick = runStartTick;
        return this;
    }
    ProfMessage *SetComputeStartTime(const uint64_t computeStartTime)
    {
        sendData_.aicpuProfData.computeStartTime = computeStartTime;
        return this;
    }
    ProfMessage *SetMemcpyStartTime(const uint64_t memcpyStartTime)
    {
        sendData_.aicpuProfData.memcpyStartTime = memcpyStartTime;
        return this;
    }
    ProfMessage *SetMemcpyEndTime(const uint64_t memcpyEndTime)
    {
        sendData_.aicpuProfData.memcpyEndTime = memcpyEndTime;
        return this;
    }
    ProfMessage *SetRunEndTime(const uint64_t runEndTime)
    {
        sendData_.aicpuProfData.runEndTime = runEndTime;
        return this;
    }
    ProfMessage *SetRunEndTick(const uint64_t runEndTick)
    {
        sendData_.aicpuProfData.runEndTick = runEndTick;
        return this;
    }
    ProfMessage *SetThreadId(const uint32_t threadId)
    {
        sendData_.aicpuProfData.threadId = threadId;
        return this;
    }
    ProfMessage *SetDeviceId(const uint32_t deviceId)
    {
        sendData_.aicpuProfData.deviceId = deviceId;
        return this;
    }
    ProfMessage *SetKernelType(const uint32_t aicpuKernelType)
    {
        sendData_.aicpuProfData.kernelType = aicpuKernelType;
        return this;
    }
    ProfMessage *SetSubmitTick(const uint64_t submitTick)
    {
        sendData_.aicpuProfData.submitTick = submitTick;
        return this;
    }
    ProfMessage *SetScheduleTick(const uint64_t scheduleTick)
    {
        sendData_.aicpuProfData.scheduleTick = scheduleTick;
        return this;
    }
    ProfMessage *SetTickBeforeRun(const uint64_t tickBeforeRun)
    {
        sendData_.aicpuProfData.tickBeforeRun = tickBeforeRun;
        return this;
    }
    ProfMessage *SetTickAfterRun(const uint64_t tickAfterRun)
    {
        sendData_.aicpuProfData.tickAfterRun = tickAfterRun;
        return this;
    }
    ProfMessage *SetDispatchTime(const uint32_t dispatchTime)
    {
        sendData_.aicpuProfData.dispatchTime = dispatchTime;
        return this;
    }
    ProfMessage *SetTotalTime(const uint32_t totalTime)
    {
        sendData_.aicpuProfData.totalTime = totalTime;
        return this;
    }
    ProfMessage *SetFFTSThreadId(const uint16_t fftsThreadId)
    {
        sendData_.aicpuProfData.fftsThreadId = fftsThreadId;
        return this;
    }
    ProfMessage *SetVersion(const uint8_t aicpuProfVersion)
    {
        sendData_.aicpuProfData.version = aicpuProfVersion;
        return this;
    }
    ProfMessage *SetDPMagicNumber(const uint16_t dPMagicNumber)
    {
        sendData_.dPProfData.magicNumber = dPMagicNumber;
        return this;
    }
    ProfMessage *SetDPDataTag(const uint16_t dPDataTag)
    {
        sendData_.dPProfData.dataTag = dPDataTag;
        return this;
    }
    ProfMessage *SetAction(const std::string &action)
    {
        const auto ret = strcpy_s(sendData_.dPProfData.action,
                                  static_cast<size_t>(MSPROF_DP_DATA_ACTION_LEN),
                                  action.c_str());
        if (ret != EOK) {
            AICPU_LOG_WARN("Copy action[%s] failed, ret=[%d].", action.c_str(), ret);
        }
        return this;
    }
    ProfMessage *SetSource(const std::string &source)
    {
        const auto ret = strcpy_s(sendData_.dPProfData.source,
                                  static_cast<size_t>(MSPROF_DP_DATA_SOURCE_LEN),
                                  source.c_str());
        if (ret != EOK) {
            AICPU_LOG_WARN("Copy source[%s] failed, ret=[%d].", source.c_str(), ret);
        }
        return this;
    }
    ProfMessage *SetIndex(const uint64_t queueIndex)
    {
        sendData_.dPProfData.index = queueIndex;
        return this;
    }
    ProfMessage *SetSize(const uint64_t size)
    {
        sendData_.dPProfData.size = size;
        return this;
    }
    ProfMessage *SetTimeStamp(const uint64_t timeStamp)
    {
        sendData_.dPProfData.timeStamp = timeStamp;
        return this;
    }
private:
    ProfMessage(const ProfMessage&) = delete;
    ProfMessage& operator=(const ProfMessage&) = delete;
    const char_t* tag_;
    ProfData sendData_;
};
// Micros for calling the profiling interface friendly
// eg. `PROF(CCECPU) << "My id: " << 5;` will send `[timestap] My id: 5` to profing data
// which timestap is when this micros call
#define PROF(tag) \
    if (aicpu::IsProfilingValid()) \
        aicpu::ProfMessage(#tag)

} // namespace aicpu
#endif
