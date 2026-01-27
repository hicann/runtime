/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef AICPU_PROF_H
#define AICPU_PROF_H
#include "aicpu_prof/profiling_adp.h"
namespace aicpu {
#ifdef __cplusplus
extern "C" {
#endif
    void InitProfilingDataInfo(const uint32_t deviceId, const pid_t hostPid, const uint32_t channelId);
    void SetProfilingFlagForKFC(const uint32_t flag);
    void LoadProfilingLib();
#ifdef __cplusplus
}
#endif

enum AicpumiMessageIndex {
    QUEUE_SIZE = 1,
    RUN_START_TIME,
    RUN_END_TIME,
    TOTAL_LEN,
};

class ProfMessageCount {
public:
    static ProfMessageCount &getInstance()
    {
        static ProfMessageCount instance;
        return instance;
    }

    void AicpuMesCountInc()
    {
        aicpuMesCount++;
    }

    void DpMesCountInc()
    {
        dpMesCount++;
    }

    void ModelMesCountInc()
    {
        modelMesCount++;
    }

    void MiMesCountInc()
    {
        miMesCount++;
    }
private:
    uint64_t aicpuMesCount;
    uint64_t dpMesCount;
    uint64_t modelMesCount;
    uint64_t miMesCount;

    ProfMessageCount() : aicpuMesCount(0U), dpMesCount(0U), modelMesCount(0U), miMesCount(0U) {}

    ~ProfMessageCount()
    {
        AICPU_LOG_INFO("The total data is: aicpu[%llu], dp[%llu], model[%llu], aicpumi[%llu]",
                       aicpuMesCount, dpMesCount, modelMesCount, miMesCount);
    }
};

class ProfilingAdp {
    friend ProfModelMessage;
public:
    /**
    * it is a constructor function.
    */
    ProfilingAdp() : reportCallback_(nullptr), deviceId_(0U),
        hostPid_(0), initFlag_(false), channelId_(0U), profilingFlag_(0U), isProfApiSo_(false) {}
    /**
    * it is a Destructor function.
    */
    virtual ~ProfilingAdp() {}
    /**
    * it is a Singleton mode,get a global and unique instance of class ProfilingAdp.
    * @return a global and unique instance of class ProfilingAdp
    */
    static ProfilingAdp &GetInstance()
    {
        static ProfilingAdp instance;
        return instance;
    }
    /**
    * it is used to initialize the ProfilingAdp object.
    * @param [in]deviceId real device ID
    * @param [in]hostPid real host process ID
    * @return status whether this operation success
    */
    int32_t InitAicpuProfiling(const uint32_t deviceId, const pid_t hostPid, const uint32_t channelId);
    /**
    * it is used to provide interface to DP module which can send data to profiling.
    * @param [in]sendData the data ptr which it is need send to profiling
    * @param [in]mark the mark of dataset
    * @return status whether this operation success
    */
    int32_t Send(const char_t * const sendData, std::string mark);
    /**
    * it is used to set report callback function valid.
    * @param [in]flag report flag
    * @param [in]reportCallback report callback function
    */
    void SetReportCallbackValid(bool flag, MsprofReporterCallback profReportCallback);
    /**
    * it is used to know the data whether can send to profiling.
    * @return status whether the data can send to profiling
    */
    bool GetReportValid(void);
    /**
    * it is used to update mode.
    * @return status whether the data can send to profiling
    */
    void UpdateModeProcess(const bool mode);
    /**
    * it is used to uninit profiling.
    * @return NA
    */
    int32_t UninitProcess();
    /**
    * it is used to initialize the ProfilingAdp object data info.
    * @param [in]deviceId real device ID
    * @param [in]hostPid real host process ID
    * @return NA
    */
    void InitAicpuProfilingDataInfo(const uint32_t deviceId, const pid_t hostPid, const uint32_t channelId);
    /**
    * it is used to set the kfc op profiling switch.
    * @param [in]flag
    * @return NA
    */
    void SetAicpuProfilingFlagForKFC(const uint32_t flag);
    MsprofReporterCallback GetMsprofReporterCallback(void);

    /**
    * it is used to update mode open process.
    * @param NA
    * @param NA
    * @return status whether this operation success
    */
    int32_t ProfilingModeOpenProcess();
    bool IsProfApiSo() const
    {
        return isProfApiSo_;
    }
    void SetNewSoFlag(bool flag)
    {
        isProfApiSo_ = flag;
        return;
    }
protected:
    /**
    * it is used to send data to profiling.
    * @param [in]data the data which it is need send to profiling
    * @return status whether this operation success
    */
    int32_t SendProcess(ReporterData &data);

    /**
    * it is used to send data to profiling with MsprofAdditionalInfo.
    * @param [in]data the data which it is need send to profiling
    * @return status whether this operation success
    */
    int32_t SendAdditionalProcess(MsprofAdditionalInfo &additionalReportData);

private:
    /**
    * it is used to new memory to store data.
    * @param [in]sendSize the size of data
    * @param [in]sendData the source data
    * @param [in]reportData the data which need to send
    * @return status whether this operation success
    */
    bool NewMemoryToStoreData(int32_t sendSize, const std::string &sendData, ReporterData &reportData) const;
    /**
    * it is used to create the content.
    * @param [in]sendData the source data
    * @param [in]mark the mark of dataset
    * @param [in]buffer it is used to store data
    * @param [in]bufferlen the size of buffer
    * @param [in]newflag if it is true,it means new memory to store data
    * @param [in]reportData it is struct of profiling data package
    * @return status whether this operation success
    */
    bool BuildSendContent(const std::string &sendData, const std::string &mark,
                          char_t buffer[], const int32_t bufferlen,
                          bool &newflag, ReporterData &reportData) const;
    /**
    * it is used to create the content.
    * @param [in]sendData the source data
    * @param [in]mark the mark of dataset
    * @param [in]reportData it is struct of profiling data package
    */
    template <typename T>
    void BuildProfData(const T &sendData, const std::string &mark, ReporterData &reportData) const;

    void BuildProfAicpuAdditionalData(const MsprofAicpuProfData &sendData, MsprofAdditionalInfo &reportData) const;

    void BuildProfDpAdditionalData(const MsprofDpProfData &sendData, MsprofAdditionalInfo &reportData) const;

    void BuildProfMiAdditionalData(const std::string &sendData, MsprofAdditionalInfo &reportData) const;

    int32_t SendProfDataWithNewChannel(const char_t * const sendData, std::string mark);

    int32_t SendProfDataWithOldChannel(const char_t * const sendData, std::string mark);
private:
    // the send callBack function of profiling
    MsprofReporterCallback reportCallback_;

    // real device ID.
    uint32_t deviceId_;

    // host pid
    pid_t hostPid_;

    // profiling init flag
    bool initFlag_;

    uint32_t channelId_;
    uint32_t profilingFlag_;
    bool isProfApiSo_;
    ProfMessageCount &counter = ProfMessageCount::getInstance();
};
} // namespace aicpu
#endif