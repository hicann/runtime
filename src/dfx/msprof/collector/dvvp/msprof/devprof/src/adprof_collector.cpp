/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adprof_collector.h"
#include <string>
#include <cstdint>
#include <typeinfo>
#include <cstdlib>
#include "prof_perf_job.h"
#include "prof_sys_info_job.h"
#include "prof_hardware_mem_job.h"
#include "utils/utils.h"
#include "devprof_drv_adprof.h"
#include "platform/platform.h"
#include "config/config.h"
#include "error_code.h"
#include "adprof_collector_proxy.h"
#include "devprof_common.h"

using namespace Analysis::Dvvp::JobWrapper;
using namespace analysis::dvvp;
using namespace analysis::dvvp::message;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;

static bool g_isExit = false;

static void AdprofExit()
{
    g_isExit = true;
}

AdprofCollector::AdprofCollector() : started_{false}
{
}

AdprofCollector::~AdprofCollector()
{
    UnInit();
}

int32_t AdprofCollector::Init(std::map<std::string, std::string> &keyValuePairs)
{
    std::lock_guard<std::mutex> lk(mtx_);
    MSPROF_EVENT("Adprof start init");
    if (started_) {
        return PROFILING_SUCCESS;
    }
    if (keyValuePairs.find("dev_id") == keyValuePairs.end()) {
        MSPROF_LOGE("Adprof collector can not init without dev_id.");
        return PROFILING_FAILED;
    }
    keyValuePairs_ = keyValuePairs;
    started_ = true;
    return PROFILING_SUCCESS;
}

int32_t AdprofCollector::UnInit()
{
    std::lock_guard<std::mutex> lk(mtx_);
    if (started_) {
        for (auto job: jobs_) {
            job->Uninit();
        }
    }
    started_ = false;
    MSPROF_EVENT("Adprof collector end.");
    return PROFILING_SUCCESS;
}

bool AdprofCollector::AdprofStarted() const
{
    return started_;
}

SHARED_PTR_ALIA<CollectionJobCfg> AdprofCollector::MakeCfg() const
{
    SHARED_PTR_ALIA<CollectionJobCfg> collectionJobCfg = nullptr;
    MSVP_MAKE_SHARED0(collectionJobCfg, CollectionJobCfg, return collectionJobCfg);
    SHARED_PTR_ALIA<ProfileParams> params = nullptr;
    MSVP_MAKE_SHARED0(params, ProfileParams, return collectionJobCfg);
    SHARED_PTR_ALIA<JobContext> jobCtx = nullptr;
    MSVP_MAKE_SHARED0(jobCtx, JobContext, return collectionJobCfg);
    SHARED_PTR_ALIA<CollectionJobCommonParams> comParams = nullptr;
    MSVP_MAKE_SHARED0(comParams, CollectionJobCommonParams, return collectionJobCfg);
    comParams->params = params;
    comParams->jobCtx = jobCtx;
    collectionJobCfg->comParams = comParams;
    return collectionJobCfg;
}

void AdprofCollector::CollectCtrlCpu(SHARED_PTR_ALIA<CollectionJobCfg> collectionJobCfg)
{
    if (keyValuePairs_.count("cpu_profiling") == 0) {
        return;
    }
    ModifyParam(collectionJobCfg->comParams->params->cpu_profiling, "cpu_profiling");
    ModifyParam(collectionJobCfg->comParams->params->tsCpuProfiling, "tsCpuProfiling");
    ModifyParam(collectionJobCfg->comParams->params->ts_cpu_profiling_events, "ts_cpu_profiling_events");
    ModifyParam(collectionJobCfg->comParams->params->aiCtrlCpuProfiling, "aiCtrlCpuProfiling");
    ModifyParam(collectionJobCfg->comParams->params->ai_ctrl_cpu_profiling_events, "ai_ctrl_cpu_profiling_events");
    ModifyParam(collectionJobCfg->comParams->params->cpu_sampling_interval, "cpu_sampling_interval");
    SHARED_PTR_ALIA<ProfCtrlcpuJob> profCtrlCpuBasedJob = nullptr;
    MSVP_MAKE_SHARED0(profCtrlCpuBasedJob, ProfCtrlcpuJob, return);
    SHARED_PTR_ALIA<std::vector<std::string>> events = nullptr;
    MSVP_MAKE_SHARED0(events, std::vector<std::string>, return);
    *events = Utils::Split(collectionJobCfg->comParams->params->ai_ctrl_cpu_profiling_events, false, "", ",");
    collectionJobCfg->jobParams.events = events;
    auto ret = profCtrlCpuBasedJob->Init(collectionJobCfg);
    if (ret == PROFILING_SUCCESS) {
        MSPROF_LOGI("Adprof collector start collect ctrl cpu job.");
        profCtrlCpuBasedJob->Process();
        jobs_.push_back(profCtrlCpuBasedJob);
    }
}

void AdprofCollector::CollectAicpuHscbJob(SHARED_PTR_ALIA<CollectionJobCfg> collectionJobCfg)
{
    if (keyValuePairs_.count("cpu_profiling") == 0) {
        return;
    }
    // check and set params
    ModifyParam(collectionJobCfg->comParams->params->cpu_profiling, "cpu_profiling");
    ModifyParam(collectionJobCfg->comParams->params->cpu_sampling_interval, "cpu_sampling_interval");
    ModifyParam(collectionJobCfg->comParams->params->hscb, "hscb");
    // init job object
    SHARED_PTR_ALIA<ProfAicpuHscbJob> profAicpuHscbJob = nullptr;
    MSVP_MAKE_SHARED0(profAicpuHscbJob, ProfAicpuHscbJob, return);
    // set hscb events
    SHARED_PTR_ALIA<std::vector<std::string>> events = nullptr;
    MSVP_MAKE_SHARED0(events, std::vector<std::string>, return);
    std::string aicpuHscbEvents = "cpu_cycles,"   // 0x11
                                  "HSCB_BUS_ACCESS_RD_PERCYC," // 0x6189: bus read transactions in progress
                                  "HSCB_BUS_ACCESS_WR_PERCYC," // 0x618A: bus write transactions in progress
                                  "HSCB_BUS_REQ_RD," // 0x618B: bus request read
                                  "HSCB_BUS_REQ_WR"; // 0x618C: bus request write
    *events = Utils::Split(aicpuHscbEvents, false, "", ",");
    collectionJobCfg->jobParams.events = events;
    // Init and start hscb job
    auto ret = profAicpuHscbJob->Init(collectionJobCfg);
    if (ret == PROFILING_SUCCESS) {
        MSPROF_LOGI("Adprof collector start collect ctrl cpu job.");
        profAicpuHscbJob->Process();
        jobs_.push_back(profAicpuHscbJob);
    }
}

void AdprofCollector::CollectAllPidsJob(SHARED_PTR_ALIA<CollectionJobCfg> collectionJobCfg)
{
    if (keyValuePairs_.count("pid_profiling") == 0) {
        return;
    }
    ModifyParam(collectionJobCfg->comParams->params->pid_profiling, "pid_profiling");
    ModifyParam(collectionJobCfg->comParams->params->pid_sampling_interval, "pid_sampling_interval");

    SHARED_PTR_ALIA<ProfAllPidsJob> profAllPidsJob = nullptr;
    MSVP_MAKE_SHARED0(profAllPidsJob, ProfAllPidsJob, return);
    auto ret = profAllPidsJob->Init(collectionJobCfg);
    if (ret == PROFILING_SUCCESS) {
        MSPROF_LOGI("Adprof collector start collect all pids job.");
        profAllPidsJob->Process();
        jobs_.push_back(profAllPidsJob);
    }
}

void AdprofCollector::CollectSysJob(SHARED_PTR_ALIA<CollectionJobCfg> collectionJobCfg)
{
    if (keyValuePairs_.count("sys_profiling") == 0) {
        return;
    }
    ModifyParam(collectionJobCfg->comParams->params->sys_profiling, "sys_profiling");
    ModifyParam(collectionJobCfg->comParams->params->sys_sampling_interval, "sys_sampling_interval");
    CollectSysStatJob(collectionJobCfg);
    CollectSysMemJob(collectionJobCfg);
}

void AdprofCollector::CollectSysStatJob(SHARED_PTR_ALIA<CollectionJobCfg> collectionJobCfg)
{
    SHARED_PTR_ALIA<ProfSysStatJob> profSysStatJob = nullptr;
    MSVP_MAKE_SHARED0(profSysStatJob, ProfSysStatJob, return);
    auto ret = profSysStatJob->Init(collectionJobCfg);
    if (ret == PROFILING_SUCCESS) {
        MSPROF_LOGI("Adprof collector start collect sys stat job.");
        profSysStatJob->Process();
        jobs_.push_back(profSysStatJob);
    }
}

void AdprofCollector::CollectSysMemJob(SHARED_PTR_ALIA<CollectionJobCfg> collectionJobCfg)
{
    SHARED_PTR_ALIA<ProfSysMemJob> profSysMemJob = nullptr;
    MSVP_MAKE_SHARED0(profSysMemJob, ProfSysMemJob, return);
    auto ret = profSysMemJob->Init(collectionJobCfg);
    if (ret == PROFILING_SUCCESS) {
        MSPROF_LOGI("Adprof collector start collect sys mem job.");
        profSysMemJob->Process();
        jobs_.push_back(profSysMemJob);
    }
}

int32_t AdprofCollector::StartCollectJob()
{
    std::lock_guard<std::mutex> lk(mtx_);
    if (!started_) {
        return PROFILING_FAILED;
    }
    auto collectionJobCfg = MakeCfg();
    if (collectionJobCfg == nullptr) {
        MSPROF_LOGE("[StartCollectJob]collectionJobCfg is nullptr.");
        return PROFILING_FAILED;
    }
    int32_t devId = 0;
    Utils::StrToInt32(devId, keyValuePairs_["dev_id"]);
    (void)Analysis::Dvvp::Common::Platform::Platform::instance()->PlatformInitByDriver();
    collectionJobCfg->comParams->devId = devId;
    collectionJobCfg->comParams->devIdOnHost = devId;
    collectionJobCfg->comParams->params->hostProfiling = false;
    CollectCtrlCpu(collectionJobCfg);
    CollectAicpuHscbJob(collectionJobCfg);
    CollectSysJob(collectionJobCfg);
    CollectAllPidsJob(collectionJobCfg);
    return PROFILING_SUCCESS;
}

std::vector<ProfileFileChunk> AdprofCollector::SpilitChunk(
    ProfileFileChunk& fileChunk, const uint32_t chunkMaxLen) const
{
    std::vector<ProfileFileChunk> fileChunks;
    size_t chunkSize = fileChunk.chunkSize;
    size_t numChunks = (chunkSize + chunkMaxLen - 1) / chunkMaxLen;
    for (size_t i = 0; i < numChunks; ++i) {
        size_t start = i * chunkMaxLen;
        size_t end = std::min(start + chunkMaxLen, chunkSize);
        ProfileFileChunk subChunk;
        subChunk.isLastChunk = fileChunk.isLastChunk;
        subChunk.chunkSize = end - start;
        subChunk.offset = fileChunk.offset;
        subChunk.chunk = fileChunk.chunk.substr(start, end - start);
        subChunk.fileName = fileChunk.fileName;
        subChunk.extraInfo = fileChunk.extraInfo;
        subChunk.id = fileChunk.id;
        fileChunks.push_back(subChunk);
    }
    return fileChunks;
}

int32_t AdprofCollector::Report(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk) const
{
    if (!started_) {
        return PROFILING_FAILED;
    }
    if (fileChunk == nullptr) {
        return PROFILING_FAILED;
    }
    auto fileChunks = SpilitChunk(*fileChunk, TLV_VALUE_CHUNK_MAX_LEN);
    if (fileChunks.empty()) {
        return PROFILING_FAILED;
    }
    for (const auto& item : fileChunks) {
        ReportAdprofFileChunk(static_cast<const void*>(&item));
    }
    return PROFILING_SUCCESS;
}

STATIC int32_t StartAdprof()
{
    AdprofCollectorProxy::instance()->BindFunction(
        std::bind(&AdprofCollector::Report, AdprofCollector::instance(), std::placeholders::_1),
        std::bind(&AdprofCollector::AdprofStarted, AdprofCollector::instance())
    );
    MSPROF_LOGI("Adprof collector start.");
    AdprofCollector::instance()->StartCollectJob();
    return PROFILING_SUCCESS;
}

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

int32_t AdprofStart(int32_t argc, const char *argv[])
{
    std::map<std::string, std::string> kvPairs;
    const int32_t minArgc = 4;
    if (argc < minArgc) {
        MSPROF_LOGE("argc is less than %d.", minArgc);
        return PROFILING_FAILED;
    }
    for (int32_t i = 1; i < argc; i++) {
        std::string s = argv[i];
        auto index = s.find(":");
        if (index == std::string::npos) {
            MSPROF_LOGE("argv[%d]:%s invalid", i, argv[i]);
            return PROFILING_FAILED;
        }
        std::string key = s.substr(0, index);
        std::string value = s.substr(index + 1);
        kvPairs[key] = value;
    }
    if (kvPairs.empty()) {
        MSPROF_LOGE("Adprof cannot parse any argv, make sure argv[] is {\"key1:value1\", \"key2:value2\", ...}.");
        return PROFILING_FAILED;
    }
    int32_t ret = AdprofCollector::instance()->Init(kvPairs);
    if (ret == PROFILING_FAILED) {
        MSPROF_LOGE("Adprof collector init failed.");
        return PROFILING_FAILED;
    }
 
    uint32_t devId;
    if (!GetDeviceId(kvPairs, devId)) {
        return PROFILING_FAILED;
    }
    int32_t hostPid;
    if (!GetHostPid(kvPairs, hostPid)) {
        return PROFILING_FAILED;
    }
    AdprofCallBack adprofCallBack = {StartAdprof, AdprofStop, AdprofExit};
    uint32_t localDevId = devId;

    drvError_t err = drvGetLocalDevIDByHostDevID(devId, &localDevId);
    FUNRET_CHECK_EXPR_ACTION(err != DRV_ERROR_NONE, return PROFILING_FAILED,
        "Failed to get local device id, devId=%u, ret=%d.", devId, static_cast<int32_t>(err));
    MSPROF_LOGI("Get local device id %u by id %u.", localDevId, devId);

    ret = AdprofStartRegister(adprofCallBack, localDevId, hostPid);
    if (ret != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
 
    return PROFILING_SUCCESS;
}

bool GetDeviceId(const std::map<std::string, std::string> &kvPairs, uint32_t &devId)
{
    if (kvPairs.find("dev_id") == kvPairs.end()) {
        MSPROF_LOGE("not find device id");
        return false;
    }
    if (!Utils::StrToUint32(devId, kvPairs.at("dev_id"))) {
        MSPROF_LOGE("device id '%s' is invalid", kvPairs.at("dev_id").c_str());
        return false;
    }
    return true;
}

bool GetHostPid(const std::map<std::string, std::string> &kvPairs, int32_t &hostPid)
{
    if (kvPairs.find("host_pid") == kvPairs.end()) {
        MSPROF_LOGE("not find host pid");
        return false;
    }
    if (!Utils::StrToInt32(hostPid, kvPairs.at("host_pid"))) {
        MSPROF_LOGE("host pid '%s' is invalid", kvPairs.at("host_pid").c_str());
        return false;
    }
    return true;
}

int32_t AdprofStop()
{
    AdprofCollector::instance()->UnInit();
    return PROFILING_SUCCESS;
}

bool GetIsExit(void)
{
    return g_isExit;
}

#ifdef __cplusplus
}
#endif