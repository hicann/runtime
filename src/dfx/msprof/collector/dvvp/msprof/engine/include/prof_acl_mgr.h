/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSPROF_ENGINE_PROF_ACL_MGR_H
#define MSPROF_ENGINE_PROF_ACL_MGR_H

#include <condition_variable>
#include <string>
#include <array>
#include <atomic>
#include "acl/acl_prof.h"
#include "common/singleton/singleton.h"
#include "common/thread/thread.h"
#include "message/prof_params.h"
#include "utils/utils.h"
#include "prof_api_common.h"
#include "prof_params_adapter.h"
#include "runtime/base.h"
#include "transport/transport.h"
#include "prof_hal_api.h"

namespace Msprofiler {
namespace Api {
using namespace analysis::dvvp::common::utils;

enum class ProfConfigType {
    PROF_CONFIG_COMMAND_LINE = 0,
    PROF_CONFIG_ACL_JSON = 1,
    PROF_CONFIG_GE_OPTION = 2,
    PROF_CONFIG_HELPER = 4,
    PROF_CONFIG_PURE_CPU = 5,
    PROF_CONFIG_ACL_API = 6,
    PROF_CONFIG_ACL_SUBSCRIBE = 7,
    PROF_CONFIG_DYNAMIC = 0xFF,
};

using ProfImplRegisterTransport = SHARED_PTR_ALIA<analysis::dvvp::transport::ITransport> (*)();
// struct of subscribe model info
struct ProfSubscribeInfo {
    bool subscribed;
    uint32_t devId;
    int32_t *fd;
};

// vector of acljson start
const std::vector<std::string> ACLJSON_CONFIG_VECTOR = {
    "switch",
    "output",
    "aic_metrics",
    "aicpu",
    "l2",
    "storage_limit",
    "hccl",
    "msproftx",
    "instr_profiling",
    "instr_profiling_freq",
    "task_tsfw",
    "ascendcl",
    "task_trace",
    "task_time",
    "runtime_api",
    "ge_api",
    "task_memory",
    "sys_hardware_mem_freq",
    "sys_mem_serviceflow",
    "llc_profiling",
    "sys_io_sampling_freq",
    "sys_interconnection_freq",
    "sys_cpu_freq",
    "dvpp_freq",
    "host_sys",
    "host_sys_usage",
    "host_sys_usage_freq",
    "sys_lp_freq",
    "scale"
};

// vector of geoption start
const std::vector<std::string> GEOPTION_CONFIG_VECTOR = {
    "output",
    "training_trace",
    "task_trace",
    "task_time",
    "aicpu",
    "fp_point",
    "bp_point",
    "aic_metrics",
    "l2",
    "storage_limit",
    "task_block",
    "hccl",
    "msproftx",
    "instr_profiling",
    "instr_profiling_freq",
    "task_tsfw",
    "runtime_api",
    "ge_api",
    "task_memory",
    "sys_hardware_mem_freq",
    "sys_mem_serviceflow",
    "llc_profiling",
    "sys_io_sampling_freq",
    "sys_interconnection_freq",
    "sys_cpu_freq",
    "dvpp_freq",
    "host_sys",
    "host_sys_usage",
    "host_sys_usage_freq",
    "sys_lp_freq",
    "scale"
};

class ProfSubscribeKey {
public:
    ProfSubscribeKey(const uint32_t devId, const uint32_t threadId) : devId_(devId), threadId_(threadId)
    {
        modelId = std::numeric_limits<uint32_t>::max();
        key = std::to_string(threadId_) + "_" +std::to_string(modelId);
        keyInfo = "threadId: " + std::to_string(threadId_);
    }

    explicit ProfSubscribeKey(const uint32_t id) : modelId(id), devId_(std::numeric_limits<uint32_t>::max()),
        threadId_(std::numeric_limits<uint32_t>::max())
    {
        key = std::to_string(threadId_) + "_" +std::to_string(modelId);
        keyInfo = "devId: " + std::to_string(devId_) + ", threadId: " + std::to_string(threadId_);
    }
    std::string key;
    uint32_t modelId;
    std::string keyInfo;
private:
    uint32_t devId_;
    uint32_t threadId_;
};

/**
 * @name  WorkMode
 * @brief profiling api work mode
 */
enum WorkMode {
    WORK_MODE_OFF,          // profiling not at work
    WORK_MODE_CMD,          // profiling work on cmd mode
    WORK_MODE_API_CTRL,     // profiling work on api ctrl mode (ProfInit)
    WORK_MODE_SUBSCRIBE,    // profiling work on subscribe mode
};

void DeviceResponse(int32_t devId);

class ProfAclMgr : public analysis::dvvp::common::singleton::Singleton<ProfAclMgr> {
public:
    ProfAclMgr();
    ~ProfAclMgr() override;

public:
    int32_t Init();
    int32_t UnInit();

    /* Precheck rule:
     *               mode    OFF               CMD                API_CTRL        SUB
     *  api
     *  Callback-Init        ok                already run        conflict        conflict
     *  Callback-Finalize    ok                ok                 conflict        conflict
     *  Api-Init             ok                already run        repeat init     conflict
     *  Api-Start            not inited        already run        ok              conflict
     *  Api-Stop             not inited        already run        ok              conflict
     *  Api-Finalize         not inited        already run        ok              conflict
     *  Sub-Sub              ok                already run        conflict        ok
     *  Sub-UnSub            not subscribed    already run        conflict        ok
     */
    int32_t CallbackInitPrecheck();
    int32_t CallbackFinalizePrecheck();
    int32_t ProfInitPrecheck() const;
    int32_t ProfStartPrecheck() const;
    int32_t ProfSetConfigPrecheck() const;
    int32_t ProfStopPrecheck() const;
    int32_t ProfFinalizePrecheck() const;
    int32_t ProfSubscribePrecheck() const;
    void SetModeToCmd();
    void SetModeToOff();
    bool IsCmdMode() const;
    bool IsAclApiMode() const;
    bool IsAclApiReady() const;
    bool IsSubscribeMode() const;
    bool IsModeOff() const;
    bool IsPureCpuMode();
    int32_t StopProfConfigCheck(uint64_t dataTypeConfigStop, uint64_t dataTypeConfigStart);
    uint64_t GetProfSwitchHi(const uint64_t &dataTypeConfig) const;

    // api ctrl
    int32_t ProfAclInit(const std::string& profResultPath);
    bool IsInited();
    bool EnableRpcHelperMode(std::string msprofPath);
    int32_t InitUploader(const std::string& devIdStr);
    int32_t ProfAclFinalize();
    int32_t ProfAclGetDataTypeConfig(const uint32_t devId, uint64_t& dataTypeConfig);
    void HandleResponse(const uint32_t devId);

    // subscribe
    uint64_t ProfAclGetDataTypeConfig(const MsprofConfig *config) const;
    void ProfAclSetModelSubscribeType(uint32_t type);
    void FlushAllData(const std::string &devId) const;
    bool IsModelSubscribed(const std::string &key);
    int32_t GetSubscribeFdForModel(const ProfSubscribeKey &subscribeKey);
    // task info query
    void GetRunningDevices(std::vector<uint32_t> &devIds);
    uint64_t GetDeviceSubscribeCount(SHARED_PTR_ALIA<ProfSubscribeKey> subscribeKey, uint32_t &devId);
    uint64_t GetCmdModeDataTypeConfig();
    std::string GetParamJsonStr();
    // task datatypeconfig add
    void AddAiCpuModelConf(uint64_t &dataTypeConfig) const;
    void AddRuntimeTraceConf(uint64_t &dataTypeConfig) const;
    void AddProfLevelConf(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
                          const uint64_t dataTypeConfig) const;
    void ChangeLevelConf(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;
    void AddModelLoadConf(uint64_t &dataTypeConfig) const;
    void AddOpDetailConf(uint64_t &dataTypeConfig) const;
    void AddSubscribeConf(uint64_t &dataTypeConfig) const;
    void AddLowPowerConf(NanoJson::Json &jsonCfg);
    std::string GenerateHelperDirName(const std::string& devId, const std::string& helperDir);
    int32_t ProcessHelperHostConfig(const char *config, size_t configLength);
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> PackDataTrunk() const;
    void AddCcuInstruction(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;

public:
    int32_t MsprofInitAclJson(VOID_PTR data, uint32_t len);
    int32_t MsprofInitGeOptions(VOID_PTR data, uint32_t len);
    int32_t MsprofInitAclEnv(const std::string &envValue);
    int32_t MsprofInitHelper(VOID_PTR data, uint32_t len);
    int32_t MsprofInitPureCpu(VOID_PTR data, uint32_t len);
    int32_t MsprofResetDeviceHandle(uint32_t devId);
    int32_t MsprofFinalizeHandle(void);
    int32_t MsprofTxApiHandle(uint64_t dataTypeConfig);
    void MsprofTxHandle(void);
    void MsprofHostHandle(void);
    int32_t MsprofDeviceHandle(uint32_t devId);
    int32_t MsprofSetConfig(aclprofConfigType cfgType, const std::string &config);
    int32_t StartUploaderDumper() const;
    int32_t StartAdprofDumper() const;
    int32_t ProfStartCommon(const uint32_t *devIdList, uint32_t devNums);
    int32_t ProfStopCommon(const MsprofConfig *config);
    int32_t ProfStartPureCpu(const MsprofConfig *config);
    int32_t ProfStopPureCpu();
    int32_t PrepareStartAclApi(const MsprofConfig *config);
    int32_t PrepareStartAclApiParam(const MsprofConfig *config);
    int32_t PrepareStopAclApi(const MsprofConfig *config);
    int32_t CheckConfigConsistency(const MsprofConfig *config);
    int32_t PrepareStartAclSubscribe(const MsprofConfig *config);
    int32_t ProfStartAclSubscribe(const MsprofConfig *config);
    int32_t PrepareStopAclSubscribe(const MsprofConfig *config) const;
    int32_t ProfStopAclSubscribe(const MsprofConfig *config);
    SHARED_PTR_ALIA<ProfSubscribeKey> GenerateSubscribeKey(const MsprofConfig *config) const;

    void RegisterTransport(ProfImplRegisterTransport callback);
    void SetDeviceNotify(uint32_t deviceId, bool isOpenDevice);
    void SetDeviceNotifyAclApi(const uint32_t *deviceId, uint32_t devNums);
    int32_t GetAllActiveDevices(std::vector<uint32_t> &activeList);
    bool GetDevicesNotify(const uint32_t *deviceId, uint32_t devNums, std::vector<uint32_t> &notifyList);
    void DumpStartInfoFile(uint32_t device);
    void SetProfWarmup();
    void ResetProfWarmup();
    bool IsProfWarmup() const;
    void ChangeProfWarmupToStart(const std::vector<uint32_t> &devIds) const;

private:
    int32_t MsprofTxSwitchPrecheck();
    int32_t DoHostHandle();
    void DoFinalizeHandle(void) const;
    int32_t MsprofSetDeviceImpl(uint32_t devId);
    int32_t CheckSubscribeConfig(const MsprofConfig *config) const;
// struct of acltask info
struct ProfAclTaskInfo {
    uint64_t count;
    uint64_t dataTypeConfig;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params;
};

const std::map<int32_t, std::string> workModeStr = {
    {WORK_MODE_OFF, "Profiling is not enabled"},
    {WORK_MODE_CMD, "Profiling is working on cmd(msprofbin/acl json/env/options/helper) mode"},
    {WORK_MODE_API_CTRL, "Profiling is working on api(acl api/graph api) mode"},
    {WORK_MODE_SUBSCRIBE, "Profiling is working on subscribe mode"}
};

// class for waiting response from device
class DeviceResponseHandler : public analysis::dvvp::common::thread::Thread {
public:
    explicit DeviceResponseHandler(const uint32_t devId);
    virtual ~DeviceResponseHandler();

public:
    void HandleResponse();

private:
    void Run(const struct error_message::Context &errorContext) override;

private:
    uint32_t devId_;
    std::mutex mtx_;
    std::condition_variable cv_;
};

private:
    int32_t InitResources();
    int32_t RecordOutPut(const std::string &data);
    int32_t InitApiCtrlUploader(const std::string& devIdStr);
    int32_t InitSubscribeUploader(const std::string& devIdStr);
    int32_t CheckDeviceTask(const MsprofConfig *config);
    void ProfStartCfgToMsprofCfg(const uint64_t dataTypeConfig, ProfAicoreMetrics aicMetrics,
                                 SHARED_PTR_ALIA<Analysis::Dvvp::Host::Adapter::ProfApiStartReq> feature) const;
    void TaskBasedCfgTrfToReq(const uint64_t dataTypeConfig, ProfAicoreMetrics aicMetrics,
        SHARED_PTR_ALIA<Analysis::Dvvp::Host::Adapter::ProfApiStartReq> feature) const;
    void SampleBasedCfgTrfToReq(const uint64_t dataTypeConfig, ProfAicoreMetrics aicMetrics,
        SHARED_PTR_ALIA<Analysis::Dvvp::Host::Adapter::ProfApiStartReq> feature) const;
    void AicoreMetricsEnumToName(ProfAicoreMetrics aicMetrics, std::string &name) const;
    int32_t StartDeviceTask(const uint32_t devId, SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    void WaitAllDeviceResponse();
    void WaitDeviceResponse(const uint32_t devId);
    void GenerateSystemTraceConf(const uint64_t dataTypeConfig, ProfAicoreMetrics aicMetrics,
                                 SHARED_PTR_ALIA<Analysis::Dvvp::Host::Adapter::ProfApiStartReq> feature,
                                 SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params) const;
    int32_t ProfStartAscendProfHalTask(const uint64_t dataTypeConfig, const uint32_t devNums,
        CONST_UINT32_T_PTR devIdList) const;
    int32_t ProfStartHostServer(uint32_t moduleType, const uint32_t devNums,
                                CONST_UINT32_T_PTR devIdList) const;
    int32_t UpdateSubscribeInfo(const std::string &key, const uint32_t devId, const MsprofConfig *config);
    int32_t StartDeviceSubscribeTask(const std::string &key, const uint32_t devId,
                                 const MsprofConfig *config);
    std::string MsprofResultDirAdapter(const std::string &dir) const;
    void ProfDataTypeConfigHandle(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    void UpdateDataTypeConfigBySwitch(const std::string &sw, const uint64_t dataTypeConfig);
    std::string MsprofCheckAndGetChar(CHAR_PTR data, uint32_t dataLen) const;
    void MsprofAclJsonParamAdaper(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params);
    int32_t MsprofAclJsonParamConstruct(NanoJson::Json &acljsonCfg);
    int32_t MsprofAclJsonParamConstructTwo(NanoJson::Json &acljsonCfg);
    int32_t MsprofAclJsonMetricsConstruct(NanoJson::Json &acljsonCfg);
    int32_t CheckAclJsonConfigInvalid(const NanoJson::Json &acljsonCfg) const;
    int32_t MsprofGeOptionsParamConstruct(const std::string &jobInfo, NanoJson::Json &geoptionCfg);
    int32_t MsprofGeOptionMetricsConstruct(NanoJson::Json &geoptionCfg);
    int32_t CheckGeOptionConfigInvalid(const NanoJson::Json &geoptionCfg) const;
    void MsprofInitGeOptionsParamAdaper(SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params,
        const std::string &jobInfo, NanoJson::Json &geoptionCfg);
    void CloseSubscribeFdIfHostId(uint32_t devId);
    void CloseSubscribeFd(const uint32_t devId);
    void CloseSubscribeFd(const uint32_t devId, SHARED_PTR_ALIA<ProfSubscribeKey> subscribeKey);
    int32_t MsprofResultPathAdapter(const std::string &dir, std::string &resultPath) const;
    void PrintWorkMode(WorkMode mode);
    int32_t MsprofHelperParamConstruct(const std::string &msprofPath, const std::string &paramsJson);
    int32_t MsprofPureCpuParamConstruct(std::string &msprofPath, const std::string &paramsJson);
    std::string GetJsonMetricsParam(NanoJson::Json &jsonCfg, std::string jsonOpt, std::string emptyVal,
        std::string defaultVal) const;
    std::string GetJsonStringParam(NanoJson::Json &jsonCfg, std::string jsonOpt, std::string defaultVal) const;
    int32_t GetJsonIntParam(NanoJson::Json &jsonCfg, std::string jsonOpt, int32_t defaultVal) const;
    std::string GenerateProfMainName() const;
    std::string GenerateProfDirName(const std::string& devId);

private:
    bool isReady_;
    std::atomic<bool> isProfWarmup_;
    WorkMode mode_;
    std::string resultPath_;
    std::string baseDir_;
    std::string storageLimit_;
    std::string masterPid_;
    int64_t curDevId_;
    std::set<uint32_t> devSet_; // notify device mark
    std::set<uint32_t> aclApiDevSet_;
    std::map<uint32_t, ProfAclTaskInfo> devTasks_; // devId, info
    std::map<uint32_t, SHARED_PTR_ALIA<DeviceResponseHandler>> devResponses_;
    std::map<std::string, std::string> devUuid_;
    std::map<std::string, ProfSubscribeInfo> subscribeInfos_;
    std::vector<uint32_t> fdCloseInfos_;
    std::mutex mtx_; // mutex for start/stop
    std::mutex mtxUploader_; // mutex for uploader
    std::mutex mtxDevResponse_; // mutex for device response
    std::mutex mtxSubscribe_;
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params_;
    uint64_t dataTypeConfig_;
    uint64_t startIndex_;
    uint32_t subscribeType_;
    ProfImplRegisterTransport createTransport_{nullptr};
};
static std::mutex g_helperMtx;
int32_t SetHelperDirToTransport(const std::string id);
int32_t SendHelperData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
} // namespace Api
} // namespace Msprofiler

#endif
