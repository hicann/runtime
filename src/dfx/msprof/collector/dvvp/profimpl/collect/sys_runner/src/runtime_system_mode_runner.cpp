/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "profimpl/collect/sys_runner/include/runtime_system_mode_runner.h"
#include <atomic>
#include <csignal>
#include <fstream>
#include <string>
#include <vector>
#include "cmd_log/cmd_log.h"
#include "config_manager.h"
#include "errno/error_code.h"
#include "msprof_task.h"
#include "msprof_dlog.h"
#include "platform/platform.h"
#include "task_relationship_mgr.h"
#include "transport/file_transport.h"
#include "transport/hdc/data_handle.h"
#include "transport/uploader_mgr.h"
#include "utils/utils.h"
#include "prof_acl_mgr.h"

using namespace analysis::dvvp::common::cmdlog;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::message;
using namespace Analysis::Dvvp::Msprof;
using namespace Analysis::Dvvp::Common::Config;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::TaskHandle;

namespace analysis {
namespace dvvp {
namespace runner {
namespace {
constexpr int32_t SYSTEM_MODE_WAIT_SLICE_US = 500000;
constexpr int32_t WAIT_SLICES_PER_SECOND = HZ_CONVERT_US / SYSTEM_MODE_WAIT_SLICE_US;
constexpr int32_t SYSTEM_MODE_FILE_MODE = 0640;
} // namespace

RuntimeSystemModeRunner::RuntimeSystemModeRunner(
    const SHARED_PTR_ALIA<message::ProfileParams>& params, const std::string& baseDir)
    : params_(params), baseDir_(baseDir)
{}

int32_t RuntimeSystemModeRunner::Run(const SHARED_PTR_ALIA<message::ProfileParams>& params, const std::string& baseDir)
{
    if (params == nullptr || baseDir.empty()) {
        MSPROF_LOGE("System mode runner params or base dir is invalid.");
        return PROFILING_FAILED;
    }
    if (Platform::instance()->PlatformInitByDriver() != PROFILING_SUCCESS) {
        MSPROF_LOGE("System mode runner init platform by driver failed.");
        return PROFILING_FAILED;
    }
    RuntimeSystemModeRunner runner(params, baseDir);
    return runner.Start();
}

int32_t RuntimeSystemModeRunner::Start() { return StartSysTask(); }

int32_t RuntimeSystemModeRunner::StartSysTask()
{
    std::vector<std::string> devices = Utils::Split(params_->devices, false, "", ",");
    params_->PrintAllFields();
    if (RecordOutPut() != PROFILING_SUCCESS) {
        MSPROF_LOGW("Unable to record output dir: %s", Utils::BaseName(baseDir_).c_str());
    }
    if (params_->IsHostProfiling()) {
        const int32_t ret = StartHostJobs();
        if (ret != PROFILING_SUCCESS) {
            StopTask();
            return ret;
        }
    }
    for (const auto& device : devices) {
        const int32_t ret = StartDeviceJobs(device);
        if (ret != PROFILING_SUCCESS) {
            StopTask();
            return ret;
        }
    }
    const int32_t waitRet = WaitSysTask();
    if (waitRet != PROFILING_SUCCESS) {
        MSPROF_LOGE("Wait system task failed.");
        StopTask();
        return waitRet;
    }
    StopTask();
    return waitRet;
}

int32_t RuntimeSystemModeRunner::CreateJobDir(const std::string& device, std::string& resultDir) const
{
    resultDir = params_->result_dir + MSVP_SLASH + baseDir_ + MSVP_SLASH;
    resultDir.append(Utils::CreateResultPath(device));
    if (Utils::CreateDir(resultDir) != PROFILING_SUCCESS) {
        char errBuf[MAX_ERR_STRING_LEN + 1] = {0};
        CmdLog::CmdErrorLog(
            "Create dir (%s) failed.ErrorCode: %d, ErrorInfo: %s.", Utils::BaseName(resultDir).c_str(),
            OsalGetErrorCode(), OsalGetErrorFormatMessage(OsalGetErrorCode(), errBuf, MAX_ERR_STRING_LEN));
        return PROFILING_FAILED;
    }
    Utils::EnsureEndsInSlash(resultDir);
    return PROFILING_SUCCESS;
}

int32_t RuntimeSystemModeRunner::RecordOutPut() const
{
    const std::string pidStr = std::to_string(params_->msprofBinPid);
    const std::string recordFile = pidStr + MSVP_UNDERLINE + OUTPUT_RECORD;
    const std::string absolutePath = params_->result_dir + MSVP_SLASH + recordFile;
    std::ofstream file;
    file.open(absolutePath, std::ios::out | std::ios::app);
    if (!file.is_open()) {
        MSPROF_LOGE("Failed to open %s", Utils::BaseName(recordFile).c_str());
        return PROFILING_FAILED;
    }
    if (OsalChmod(absolutePath.c_str(), SYSTEM_MODE_FILE_MODE) != OSAL_EN_OK) {
        file.close();
        MSPROF_LOGE("Failed to change file mode for %s", Utils::BaseName(recordFile).c_str());
        return PROFILING_FAILED;
    }
    file << baseDir_ << std::endl << std::flush;
    file.close();
    return PROFILING_SUCCESS;
}

SHARED_PTR_ALIA<message::ProfileParams> RuntimeSystemModeRunner::GenerateHostParam(
    const SHARED_PTR_ALIA<message::ProfileParams>& params) const
{
    if (params == nullptr) {
        return nullptr;
    }
    SHARED_PTR_ALIA<message::ProfileParams> dstParams = nullptr;
    MSVP_MAKE_SHARED0(dstParams, message::ProfileParams, return nullptr);
    const std::string dstParamsStr = params->ToString();
    if (!dstParams->FromString(dstParamsStr)) {
        MSPROF_LOGE("Failed to parse host params.");
        return nullptr;
    }
    const uintptr_t addr = reinterpret_cast<uintptr_t>(dstParams.get());
    dstParams->job_id = Utils::ProfCreateId(static_cast<uint64_t>(addr));
    if (dstParams->ai_core_profiling_mode.empty()) {
        dstParams->ai_core_profiling_mode = PROFILING_MODE_SAMPLE_BASED;
    }
    if (dstParams->aiv_profiling_mode.empty()) {
        dstParams->aiv_profiling_mode = PROFILING_MODE_SAMPLE_BASED;
    }
    dstParams->msprof_llc_profiling = params->msprof_llc_profiling;
    dstParams->host_sys_pid = params->host_sys_pid;
    dstParams->profiling_period = params->profiling_period;
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_V4_1_0) {
        dstParams->instrProfiling = params->instrProfiling;
        dstParams->instrProfilingFreq = params->instrProfilingFreq;
    }
    return dstParams;
}

bool RuntimeSystemModeRunner::IsDeviceJob() const
{
    if (params_ == nullptr) {
        return false;
    }
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE &&
        params_->hardware_mem.compare("on") == 0) {
        return true;
    }
    return params_->cpu_profiling.compare("on") == 0 || params_->sys_profiling.compare("on") == 0 ||
           params_->pid_profiling.compare("on") == 0;
}

SHARED_PTR_ALIA<message::ProfileParams> RuntimeSystemModeRunner::GenerateDeviceParam(
    const SHARED_PTR_ALIA<message::ProfileParams>& params) const
{
    if (params == nullptr) {
        return nullptr;
    }
    SHARED_PTR_ALIA<message::ProfileParams> dstParams = nullptr;
    MSVP_MAKE_SHARED0(dstParams, message::ProfileParams, return nullptr);
    dstParams->result_dir = params->result_dir;
    dstParams->sys_profiling = params->sys_profiling;
    dstParams->sys_sampling_interval = params->sys_sampling_interval;
    dstParams->pid_profiling = params->pid_profiling;
    dstParams->pid_sampling_interval = params->pid_sampling_interval;
    dstParams->cpu_profiling = params->cpu_profiling;
    dstParams->cpu_sampling_interval = params->cpu_sampling_interval;
    dstParams->aiCtrlCpuProfiling = params->aiCtrlCpuProfiling;
    dstParams->ai_ctrl_cpu_profiling_events = params->ai_ctrl_cpu_profiling_events;
    dstParams->profiling_period = params->profiling_period;
    const uintptr_t addr = reinterpret_cast<uintptr_t>(dstParams.get());
    dstParams->job_id = Utils::ProfCreateId(static_cast<uint64_t>(addr));
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE) {
        dstParams->llc_profiling_events = params->llc_profiling_events;
        dstParams->llc_profiling = params->llc_profiling;
        dstParams->msprof_llc_profiling = params->msprof_llc_profiling;
    }
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::CHIP_V4_1_0) {
        dstParams->instrProfiling = params->instrProfiling;
        dstParams->instrProfilingFreq = params->instrProfilingFreq;
    }
    return dstParams;
}

bool RuntimeSystemModeRunner::CreateSampleJsonFile(
    const SHARED_PTR_ALIA<message::ProfileParams>& params, const std::string& resultDir) const
{
    if (resultDir.empty()) {
        return true;
    }
    const std::string fileName = SAMPLE_JSON;
    if (Utils::CreateDir(resultDir) != PROFILING_SUCCESS) {
        MSPROF_LOGE("create dir error , %s", Utils::BaseName(resultDir).c_str());
        Utils::PrintSysErrorMsg();
        return false;
    }
    const std::string paramsStr = params->ToString();
    const int32_t ret = WriteCtrlDataToFile(resultDir + fileName, paramsStr, static_cast<int32_t>(paramsStr.size()));
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to write local files");
        return false;
    }
    return true;
}

bool RuntimeSystemModeRunner::CreateDoneFile(const std::string& absolutePath, const std::string& fileSize) const
{
    std::ofstream file;
    file.open(absolutePath, std::ios::out);
    if (!file.is_open()) {
        MSPROF_LOGE("Failed to open %s", Utils::BaseName(absolutePath).c_str());
        return false;
    }
    if (OsalChmod(absolutePath.c_str(), SYSTEM_MODE_FILE_MODE) != OSAL_EN_OK) {
        file.close();
        MSPROF_LOGE("Failed to change file mode for %s", Utils::BaseName(absolutePath).c_str());
        return false;
    }
    file << "filesize: " << fileSize << std::endl;
    file.flush();
    file.close();
    return true;
}

int32_t RuntimeSystemModeRunner::WriteCtrlDataToFile(
    const std::string& absolutePath, const std::string& data, int32_t dataLen) const
{
    std::ofstream file;
    if (Utils::IsFileExist(absolutePath)) {
        MSPROF_LOGI("file exist: %s", Utils::BaseName(absolutePath).c_str());
        return PROFILING_SUCCESS;
    }
    if (data.empty() || dataLen <= 0) {
        MSPROF_LOGE("Failed to open %s", Utils::BaseName(absolutePath).c_str());
        return PROFILING_FAILED;
    }
    file.open(absolutePath, std::ios::out | std::ios::trunc);
    if (!file.is_open()) {
        MSPROF_LOGE("Failed to open %s", Utils::BaseName(absolutePath).c_str());
        return PROFILING_FAILED;
    }
    if (OsalChmod(absolutePath.c_str(), SYSTEM_MODE_FILE_MODE) != OSAL_EN_OK) {
        file.close();
        MSPROF_LOGE("Failed to change file mode for %s", Utils::BaseName(absolutePath).c_str());
        return PROFILING_FAILED;
    }
    file.write(data.c_str(), dataLen);
    file.flush();
    file.close();
    if (!CreateDoneFile(absolutePath + ".done", std::to_string(dataLen))) {
        MSPROF_LOGE("set device done file failed");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t RuntimeSystemModeRunner::CreateUploader(const std::string& jobId, const std::string& resultDir) const
{
    if (jobId.empty() || resultDir.empty()) {
        return PROFILING_FAILED;
    }
    auto transport = transport::FileTransportFactory().CreateFileTransport(resultDir, params_->storageLimit, true);
    if (transport == nullptr) {
        MSPROF_LOGE("CreateFileTransport failed, key:%s", jobId.c_str());
        return PROFILING_FAILED;
    }
    const int32_t ret = transport::UploaderMgr::instance()->CreateUploader(jobId, transport);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("CreateUploader failed, key:%s", jobId.c_str());
        return PROFILING_FAILED;
    }
    TaskRelationshipMgr::instance()->AddLocalFlushJobId(jobId);
    return PROFILING_SUCCESS;
}

int32_t RuntimeSystemModeRunner::StartHostTask(const std::string& resultDir, uint32_t deviceId)
{
    auto params = GenerateHostParam(params_);
    if (params == nullptr) {
        MSPROF_LOGE("GenerateHostParam failed.");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("StartHostTask : %u, job_id : %s", deviceId, params->job_id.c_str());
    params->devices = std::to_string(deviceId);
    if (deviceId == DEFAULT_HOST_ID) {
        params->hostProfiling = true;
    } else if (params->hardware_mem.compare(MSVP_PROF_ON) == 0) {
        params->qosProfiling = MSVP_PROF_ON;
        Platform::instance()->GetQosProfileInfo(deviceId, params->qosEvents, params->qosEventId);
    }
    if (!CreateSampleJsonFile(params, resultDir)) {
        MSPROF_LOGE("CreateSampleJsonFile failed");
        return PROFILING_FAILED;
    }
    params->result_dir = resultDir;
    if (CreateUploader(params->job_id, resultDir) != PROFILING_SUCCESS) {
        MSPROF_LOGE("CreateUploader failed");
        return PROFILING_FAILED;
    }
    SHARED_PTR_ALIA<Analysis::Dvvp::Msprof::ProfSocTask> task = nullptr;
    MSVP_MAKE_SHARED2(task, Analysis::Dvvp::Msprof::ProfSocTask, deviceId, params, return PROFILING_FAILED);
    int32_t ret = task->Init();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("DeviceTask init failed, deviceId:%u", deviceId);
        return PROFILING_FAILED;
    }
    ret = task->Start();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("DeviceTask start failed, deviceId:%u", deviceId);
        return PROFILING_FAILED;
    }
    HdcTransportDataHandle::RegisterTask(params->job_id, task);
    taskList_.push_back(task);
    return PROFILING_SUCCESS;
}

int32_t RuntimeSystemModeRunner::StartDeviceTask(const std::string& resultDir, const std::string& device)
{
    MSPROF_LOGD("StartDeviceTask : %s", device.c_str());
    auto params = GenerateDeviceParam(params_);
    if (params == nullptr) {
        MSPROF_LOGE("GenerateDeviceParam failed.");
        return PROFILING_FAILED;
    }
    params->devices = device;
    if (CreateUploader(params->job_id, resultDir) != PROFILING_SUCCESS) {
        MSPROF_LOGE("CreateUploader failed");
        return PROFILING_FAILED;
    }
    int32_t devId = 0;
    FUNRET_CHECK_EXPR_ACTION(
        !Utils::StrToInt32(devId, device), return PROFILING_FAILED, "device %s is invalid", device.c_str());
    SHARED_PTR_ALIA<Analysis::Dvvp::Msprof::ProfRpcTask> task = nullptr;
    MSVP_MAKE_SHARED2(task, Analysis::Dvvp::Msprof::ProfRpcTask, devId, params, return PROFILING_FAILED);
    int32_t ret = task->Init();
    if (ret != PROFILING_SUCCESS) {
        if (ret != PROFILING_NOTSUPPORT) {
            MSPROF_LOGE("DeviceTask init failed, deviceId:%s", device.c_str());
        }
        return ret;
    }
    ret = task->Start();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("DeviceTask start failed, deviceId:%s", device.c_str());
        return PROFILING_FAILED;
    }
    HdcTransportDataHandle::RegisterTask(params->job_id, task);
    taskList_.push_back(task);
    return PROFILING_SUCCESS;
}

void RuntimeSystemModeRunner::StopTask()
{
    if (taskList_.empty()) {
        return;
    }
    for (auto task = taskList_.rbegin(); task != taskList_.rend(); ++task) {
        (*task)->Stop();
        (*task)->Wait();
    }
    HdcTransportDataHandle::UnregisterAllTask();
    taskList_.clear();
}

int32_t RuntimeSystemModeRunner::WaitSysTask() const
{
    uint32_t times = 0;
    uint32_t cycles = 0;
    if (params_->profiling_period > 0) {
        cycles = static_cast<uint32_t>(params_->profiling_period * WAIT_SLICES_PER_SECOND);
    }
    while ((times < cycles) && (!Msprofiler::Api::ProfAclMgr::instance()->IsSigintShutdownInProgress())) {
        Utils::UsleepInterupt(SYSTEM_MODE_WAIT_SLICE_US);
        times++;
    }
    if (times < cycles) {
        MSPROF_LOGI("System mode wait exited early by signal, waited %u slices, configured %u slices", times, cycles);
    }
    return PROFILING_SUCCESS;
}

int32_t RuntimeSystemModeRunner::StartDeviceJobs(const std::string& device)
{
    std::string resultDir;
    int32_t ret = CreateJobDir(device, resultDir);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    uint32_t devId = 0;
    if (!Utils::StrToUint32(devId, device)) {
        MSPROF_LOGE("Convert device id:%s to uint32 failed", device.c_str());
        return PROFILING_FAILED;
    }
    ret = StartHostTask(resultDir, devId);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("StartHostTask failed");
        return ret;
    }
    if (IsDeviceJob() && (!Platform::instance()->PlatformIsSocSide()) &&
        ((Platform::instance()->GetPlatformType() == CHIP_MINI_V3) ||
         (!Platform::instance()->CheckIfSupportAdprof(devId)))) {
        ret = StartDeviceTask(resultDir, device);
        if (ret != PROFILING_SUCCESS) {
            if (ret != PROFILING_NOTSUPPORT) {
                MSPROF_LOGE("StartDeviceTask failed");
            }
            return ret;
        }
    }
    return PROFILING_SUCCESS;
}

int32_t RuntimeSystemModeRunner::StartHostJobs()
{
    MSPROF_LOGI("StartHostJobs");
    std::string resultDir;
    int32_t ret = CreateJobDir(std::to_string(DEFAULT_HOST_ID), resultDir);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    ret = StartHostTask(resultDir, DEFAULT_HOST_ID);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("StartHostTask failed");
        return ret;
    }
    return PROFILING_SUCCESS;
}
} // namespace runner
} // namespace dvvp
} // namespace analysis
