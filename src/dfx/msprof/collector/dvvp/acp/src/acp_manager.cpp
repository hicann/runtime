/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "acp_manager.h"
#include "securec.h"
#include "acp_pipe_transfer.h"
#include "errno/error_code.h"
#include "error_codes/rt_error_codes.h"
#include "cmd_log/cmd_log.h"
#include "uploader_mgr.h"
#include "op_transport.h"
#include "prof_channel_manager.h"
#include "platform/platform.h"
#include "config/config.h"
#include "config_manager.h"

namespace Collector {
namespace Dvvp {
namespace Acp {
using namespace analysis::dvvp::common::cmdlog;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Common::Platform;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::transport;
using namespace analysis::dvvp::message;

AcpManager::AcpManager() : blockDim_(0), binaryHandle_(nullptr), jobAdapter_(nullptr), params_(nullptr),
    devBinaryMap_({}), mallocVec_({}), memoryVec_({}), metrics_({}), rtMallocFunc_(nullptr), rtFreeFunc_(nullptr),
    rtMemcpyAsyncFunc_(nullptr)
{
}

AcpManager::~AcpManager()
{
    UnInit();
}

int32_t AcpManager::Init(int32_t devId)
{
    if (GetAndCheckParams(devId) != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("AcpManager init success, device: %d, output path: %s.", devId, params_->result_dir.c_str());
    return PROFILING_SUCCESS;
}

void AcpManager::UnInit()
{
    ClearMallocMemory();
    ClearMallocAddr();
    jobAdapter_.reset();
    params_.reset();
    metrics_.clear();
}

int32_t AcpManager::TaskStart()
{
    FUNRET_CHECK_EXPR_ACTION(params_ == nullptr, return PROFILING_FAILED,
        "Acp task start failed, the params is nullptr.");
    int32_t ret = InitAcpUploader();
    FUNRET_CHECK_EXPR_ACTION(ret != PROFILING_SUCCESS, return PROFILING_FAILED, "Acp uploader init failed.");
    // if instr-profiling or pc-sampling opened, send config message to runtime
    FUNRET_CHECK_EXPR_ACTION(NotifyRtSwitchConfig(PROF_COMMANDHANDLE_TYPE_START) != PROFILING_SUCCESS,
        return PROFILING_FAILED, "Start set biu or pc sampling config to runtime failed.");
    ret = JobStart();
    FUNRET_CHECK_EXPR_ACTION(ret != PROFILING_SUCCESS, return PROFILING_FAILED, "Acp job start failed.");
    MSPROF_LOGI("Acp task started successfully.");
    return PROFILING_SUCCESS;
}

void AcpManager::SetTaskBlockDim(const uint32_t blockDim)
{
    MSPROF_LOGI("SetTaskBlockDim receive block dim [%u].", blockDim);
    blockDim_ = blockDim;
}

int32_t AcpManager::InitAcpUploader()
{
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    UploaderMgr::instance()->GetUploader(params_->devices, uploader);
    if (uploader != nullptr) {
        MSPROF_LOGI("Device %d has already created uploader.", params_->devices.c_str());
        return PROFILING_SUCCESS;
    }

    if (Utils::CreateDir(params_->result_dir) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create device dir: %s", Utils::BaseName(params_->result_dir).c_str());
        MSPROF_INNER_ERROR("EK9999", "Failed to create device dir: %s", Utils::BaseName(params_->result_dir).c_str());
        Utils::PrintSysErrorMsg();
        return PROFILING_FAILED;
    }

    SHARED_PTR_ALIA<ITransport> opTransport = nullptr;
    opTransport = OpTransportFactory().CreateOpTransport(params_->devices);
    if (opTransport == nullptr) {
        MSPROF_LOGE("Failed to create parsertransport for acp tools.");
        MSPROF_INNER_ERROR("EK9999", "Failed to create parsertransport for acp tools.");
        return PROFILING_FAILED;
    }
    const size_t uploaderCapacity = 512; // uploader capacity
    int32_t ret = UploaderMgr::instance()->CreateUploader(params_->devices, opTransport, uploaderCapacity);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create uploader for acp tools.");
        MSPROF_INNER_ERROR("EK9999", "Failed to create uploader for acp tools.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t AcpManager::JobStart()
{
    MSPROF_LOGI("Start to acp job manager.");
    int32_t deviceId = -1;
    if (!Utils::StrToInt32(deviceId, params_->devices) || deviceId < 0) {
        MSPROF_LOGE("Failed to convert the character string to a number, id is %s.", params_->devices.c_str());
        return PROFILING_FAILED;
    }
    if (jobAdapter_ != nullptr) {
        return PROFILING_SUCCESS;
    }
    MSVP_MAKE_SHARED1(jobAdapter_, AcpComputeDeviceJob, deviceId, return PROFILING_FAILED);

    return jobAdapter_->StartProf(params_);
}

int32_t AcpManager::TaskStop()
{
    FUNRET_CHECK_EXPR_ACTION(params_ == nullptr, return PROFILING_FAILED,
        "Acp task stop failed, the params is nullptr.");
    FUNRET_CHECK_EXPR_ACTION(NotifyRtSwitchConfig(PROF_COMMANDHANDLE_TYPE_STOP) != PROFILING_SUCCESS,
        return PROFILING_FAILED, "Stop set biu or pc sampling config to runtime failed.");
    int32_t ret = JobStop();
    UploaderMgr::instance()->DelAllUploader();
    (void)UploaderMgr::instance()->Uninit();
    jobAdapter_ = nullptr;
    return ret;
}

int32_t AcpManager::JobStop()
{
    MSPROF_LOGI("Stop acp job manager.");
    if (jobAdapter_ == nullptr) {
        MSPROF_LOGE("JobAdapter is nullptr, job cannot stop.");
        return PROFILING_FAILED;
    }
    int32_t ret = jobAdapter_->StopProf();
    FUNRET_CHECK_EXPR_PRINT(ret != PROFILING_SUCCESS, "JobAdapter execute failed in the stop phase.");
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    UploaderMgr::instance()->GetUploader(params_->devices, uploader);
    if (uploader == nullptr) {
        MSPROF_LOGE("uploader is nullptr, and cannot send end info to op transport.");
        return PROFILING_FAILED;
    }
    ProfChannelManager::instance()->FlushChannel();
    ret = SaveBasicOpInfo(uploader);
    uploader->Flush();
    auto transport = uploader->GetTransport();
    if (transport != nullptr) {
        transport->WriteDone();
    }
    return ret;
}

void AcpManager::AddBinary(VOID_PTR handle, const RtDevBinary &binary)
{
    FUNRET_CHECK_EXPR_ACTION(handle == nullptr, return, "Add binary handle is invalid.");
    FUNRET_CHECK_EXPR_ACTION(((binary.data == nullptr) || (binary.length == 0)), return,
     "Binary is invalid, binary data is nullptr or length is 0");
    AcpDevBinary bin;
    bin.magic = binary.magic;
    bin.version = binary.version;
    bin.length = binary.length;
    bin.data.reserve(binary.length);
    const errno_t ret = memcpy_s(bin.data.data(), bin.data.capacity(), binary.data, binary.length);
    FUNRET_CHECK_EXPR_ACTION(ret != EOK, return, "Binary memcpy_s failed with error.");
    const std::lock_guard<std::mutex> lk(binaryMtx_);
    auto it = devBinaryMap_.find(handle);
    if (it != devBinaryMap_.cend()) {
        bin.baseAddr = it->second.baseAddr;
        it->second = std::move(bin);
        MSPROF_LOGI("Update device binary with handle %p", handle);
    } else {
        MSPROF_LOGI("Associated device binary with handle %p", handle);
        devBinaryMap_[handle] = std::move(bin);
    }
}

void AcpManager::RemoveBinary(VOID_PTR handle)
{
    const std::lock_guard<std::mutex> lk(binaryMtx_);
    auto it = devBinaryMap_.find(handle);
    if (it != devBinaryMap_.cend()) {
        devBinaryMap_.erase(it);
        MSPROF_LOGD("Removed device binary for handle %p", handle);
    } else {
        MSPROF_LOGW("Unable to find device binary associated with handle %p", handle);
    }
}

void AcpManager::DumpBinary(VOID_PTR handle)
{
    const std::lock_guard<std::mutex> lk(binaryMtx_);
    auto it = devBinaryMap_.find(handle);
    if (it == devBinaryMap_.cend()) {
        MSPROF_LOGE("Failed to find binary by handle[%p].", handle);
        return ;
    }

    binaryObjectPath_ = Utils::CanonicalizePath(params_->result_dir);
    if (binaryObjectPath_.empty()) {
        MSPROF_LOGE("Binary dump path is invalid.");
        return;
    }

    binaryObjectPath_ = binaryObjectPath_ + "/" + "object_" + std::to_string(Utils::GetClockMonotonicRaw()) + ".o";
    int32_t fd = OsalOpen(binaryObjectPath_.c_str(), O_WRONLY | O_CREAT | O_APPEND, OSAL_IRUSR | OSAL_IWUSR);
    if (fd < 0) {
        MSPROF_LOGE("Failed to create or open binary file: %s, error info %s.",
            binaryObjectPath_.c_str(), strerror(errno));
        return;
    }
    (void)OsalClose(fd);
    std::ofstream file(binaryObjectPath_, std::ofstream::app | std::ios::binary);
    if (!file.is_open()) {
        MSPROF_LOGE("Failed to open %s, errinfo:%s", binaryObjectPath_.c_str(), strerror(OsalGetErrorCode()));
        return;
    }
    file.write(reinterpret_cast<const char *>(it->second.data.data()), it->second.length);
    file.flush();
    file.close();
    MSPROF_LOGI("Device binary file[%s] dump successfully.", binaryObjectPath_.c_str());
}

void AcpManager::AddBinaryBaseAddr(VOID_PTR handle, VOID_PTR baseAddr)
{
    const std::lock_guard<std::mutex> lk(binaryMtx_);
    auto it = devBinaryMap_.find(handle);
    if (it != devBinaryMap_.cend()) {
        it->second.baseAddr = baseAddr;
        MSPROF_LOGD("Add binary base address for handle %p", handle);
    } else {
        MSPROF_LOGW("Unable to find device binary associated with handle %p", handle);
    }
}

void AcpManager::SaveBinaryHandle(VOID_PTR &handle)
{
    if (handle == nullptr) {
        MSPROF_LOGE("Save binary handle failed, handle is nullptr.");
        return;
    }

    if (binaryHandle_ != nullptr) {
        MSPROF_LOGW("Repeated save binary handle, the old handle is %p, the new handle is %p", binaryHandle_, handle);
        return;
    }
    binaryHandle_ = handle;
}

int32_t AcpManager::NotifyRtSwitchConfig(MsprofCommandHandleType connamdType)
{
    if (params_->instrProfiling.compare(MSVP_PROF_ON) == 0 || params_->pcSampling.compare(MSVP_PROF_ON) == 0) {
        auto func = AcpApiPlugin::instance()->GetPluginApiStubFunc("rtProfSetProSwitch");
        FUNRET_CHECK_EXPR_ACTION(func == nullptr, return PROFILING_FAILED,
            "dlopen rtProfSetProSwitch failed which is nullptr.");
        MsprofCommandHandle command;
        int32_t ret = memset_s(&command, sizeof(command), 0, sizeof(command));
        FUNRET_CHECK_EXPR_ACTION(ret != EOK, return PROFILING_FAILED, "Memset data to command failed, ret is %d", ret);
        command.profSwitch = PROF_INSTR;
        command.type = connamdType;
        command.modelId = 0xFFFFFFFFUL;
        command.cacheFlag = 0;
        command.devNums = 1;
        FUNRET_CHECK_EXPR_ACTION(!Utils::StrToUint32(command.devIdList[0], params_->devices), return PROFILING_FAILED,
            "Convert device string %s to uint32 failed.", params_->devices.c_str());
        ret = reinterpret_cast<RtProfSetProSwitchFunc>(func)(reinterpret_cast<VOID_PTR>(&command),
            sizeof(MsprofCommandHandle));
        FUNRET_CHECK_EXPR_ACTION(ret != ACL_RT_SUCCESS, return PROFILING_FAILED,
            "Set config to runtime by rtProfSetProSwitch failed with ret %d.", ret);
        MSPROF_LOGI("Success to notify runtime set config with command type %u", connamdType);
    }
    return PROFILING_SUCCESS;
}

VOID_PTR AcpManager::GetBinaryHandle() const
{
    return binaryHandle_;
}

bool AcpManager::PcSamplingIsEnable() const
{
    return params_->pcSampling.compare("on") == 0;
}

std::string AcpManager::GetBinaryObjectPath() const
{
    return binaryObjectPath_;
}

int32_t AcpManager::SaveBasicOpInfo(SHARED_PTR_ALIA<Uploader> uploader)
{
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk;
    MSVP_MAKE_SHARED0(fileChunk, analysis::dvvp::ProfileFileChunk, return PROFILING_FAILED);
    fileChunk->fileName = Utils::PackDotInfo("end_info", std::to_string(GetKernelReplayTime()));
    fileChunk->offset = -1;
    fileChunk->chunk = params_->aiv_metrics;
    fileChunk->chunkSize = fileChunk->chunk.size();
    fileChunk->isLastChunk = false;
    fileChunk->chunkModule = FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST;
    fileChunk->extraInfo = params_->result_dir;
    fileChunk->id = std::to_string(blockDim_);
    return uploader->UploadData(fileChunk);
}

int32_t AcpManager::GetAndCheckParams(int32_t devId)
{
    if (devId < 0 || devId >= MSVP_MAX_DEV_NUM) {
        MSPROF_LOGE("Acp get invalid devId: %d.", devId);
        return PROFILING_FAILED;
    }

    if (params_ != nullptr) {
        MSPROF_LOGI("Acp params has already inited.");
        params_->job_id = std::to_string(devId);
        params_->devices = std::to_string(devId); // update device id
        return PROFILING_SUCCESS;
    }

    params_ = AcpPipeRead();
    if (params_ == nullptr) {
        MSPROF_LOGE("Acp received nullptr params, devId: %d.", devId);
        return PROFILING_FAILED;
    }

    SetDefaultParams(devId);
    HandleAcpMetrics();
    return PROFILING_SUCCESS;
}

void AcpManager::SetDefaultParams(int32_t devId)
{
    params_->ai_core_profiling = "on";
    params_->aiv_profiling = "on";
    params_->ai_core_profiling_mode = PROFILING_MODE_TASK_BASED;
    params_->aiv_profiling_mode = PROFILING_MODE_TASK_BASED;
    if (Platform::instance()->CheckIfSupport(PLATFORM_TASK_STARS_ACSQ)) {
        params_->stars_acsq_task = MSVP_PROF_ON;
    }
    params_->ts_memcpy = "on";
    params_->job_id = std::to_string(devId);
    params_->devices = std::to_string(devId);
    params_->result_dir += MSVP_SLASH + Utils::CreateProfDir(0, "OPPROF_") + MSVP_SLASH;
}

/**
 * @brief Handle aic metrics and prepare for kernel replay
 * @return
 */
void AcpManager::HandleAcpMetrics()
{
    if (params_->ai_core_metrics.compare(0, CUSTOM_METRICS.length(), CUSTOM_METRICS) == 0) {
        MSPROF_LOGI("Acp handle custom metrics: %s.", params_->ai_core_metrics.c_str());
        std::string aicoreEvent = params_->ai_core_metrics.substr(CUSTOM_METRICS.length());
        std::vector<std::string> pmuEvents = Utils::Split(aicoreEvent, false, "", ",");
        aicoreEvent = "";
        uint16_t maxPmuEvents = Platform::instance()->GetMaxMonitorNumber();
        for (uint16_t i = 0; i < static_cast<uint16_t>(pmuEvents.size()); ++i) {
            if ((i + 1) % maxPmuEvents == 0) {
                aicoreEvent += pmuEvents[i];
                MSPROF_LOGI("Acp split pmu events: %s", aicoreEvent.c_str());
                metrics_.emplace_back(std::move(aicoreEvent));
                aicoreEvent = "";
            } else {
                aicoreEvent += pmuEvents[i] + ",";
            }
        }
        if (!aicoreEvent.empty()) {
            aicoreEvent.pop_back();
            MSPROF_LOGI("Acp split last pmu events: %s", aicoreEvent.c_str());
            metrics_.emplace_back(std::move(aicoreEvent));
        }
    } else {
        MSPROF_LOGI("Acp handle group metrics: %s.", params_->ai_core_metrics.c_str());
        metrics_ = Utils::Split(params_->ai_core_metrics, false, "", ",");
    }
}

/**
 * @brief Get kernel replay times
 * @return
 */
uint32_t AcpManager::GetKernelReplayTime() const
{
    return static_cast<uint32_t>(metrics_.size());
}

/**
 * @brief Set aic metrics for kernel replay
 * @param [in] time: kernel replay time
 * @return
 */
void AcpManager::SetKernelReplayMetrics(const uint32_t time)
{
    FUNRET_CHECK_EXPR_ACTION(params_ == nullptr, return, "Set replay metrics failed, the params is nullptr.");
    FUNRET_CHECK_EXPR_ACTION(time > metrics_.size() - 1, return, "Set replay metrics failed, invalid time: %u.", time);

    bool ifGroupMode = (params_->ai_core_metrics.find(CUSTOM_METRICS, 0) == std::string::npos) ? true : false;
    if (ifGroupMode) { // group mode
        params_->ai_core_metrics = metrics_[time];
        params_->aiv_metrics = params_->ai_core_metrics;
        ConfigManager::instance()->GetVersionSpecificMetrics(params_->ai_core_metrics);
        int32_t ret = Platform::instance()->GetAicoreEvents(params_->ai_core_metrics, params_->ai_core_profiling_events);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("The ai_core_metrics: %s is invalid.", params_->ai_core_metrics.c_str());
            return;
        }
        ret = Platform::instance()->GetAicoreEvents(params_->aiv_metrics, params_->aiv_profiling_events);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("The aiv_metrics: %s is invalid.", params_->aiv_metrics.c_str());
            return;
        }
    } else { // customize mode
        params_->ai_core_metrics = CUSTOM_METRICS + metrics_[time];
        params_->aiv_metrics = params_->ai_core_metrics;
        params_->ai_core_profiling_events = metrics_[time];
        params_->aiv_profiling_events = params_->ai_core_profiling_events;
    }

    MSPROF_LOGI("Acp kernel replay set ai core metrics: %s, pmu events: %s, time: %u.",
        params_->ai_core_metrics.c_str(), params_->ai_core_profiling_events.c_str(), time);
}

/**
 * @brief Register rtMalloc and rtFree function
 * @param [in] mallocFunc: rtMalloc function ptr
 * @param [in] freeFunc: rtFree function ptr
 * @return
 */
void AcpManager::RegisterRtMallocFunc(RtMallocFunc mallocFunc, RtFreeFunc freeFunc)
{
    if (rtMallocFunc_ != nullptr && rtFreeFunc_ != nullptr) {
        return;
    }

    rtMallocFunc_ = mallocFunc;
    rtFreeFunc_ = freeFunc;
}

/**
 * @brief Register rtMemcpyAsync function
 * @param [in] memcpyAsyncFunc: rtMemcpyAsync function ptr
 * @return
 */
void AcpManager::RegisterRtMemcpyFunc(RtMemcpyAsyncFunc memcpyAsyncFunc)
{
    if (rtMemcpyAsyncFunc_ != nullptr) {
        return;
    }

    rtMemcpyAsyncFunc_ = memcpyAsyncFunc;
}

/**
 * @brief Save rtMalloc attribute
 * @param [in] attr: back up attribute applied by the user
 * @return
 */
void AcpManager::SaveRtMallocAttr(AcpBackupAttr &attr)
{
    if (attr.addr == nullptr) {
        MSPROF_LOGI("Acp failed to save nullptr malloc attr.");
        return;
    }
    mallocVec_.emplace_back(attr);
    MSPROF_LOGI("Acp save malloc attr, addr: %p, size: %llu, type: %u, moduleId: %u.",
        attr.addr, attr.size, attr.type, attr.moduleId);
}

/**
 * @brief Release rtMalloc ptr if exist address
 * @param [in] ptr: rtMalloc ptr which need to be free
 * @return
 */
void AcpManager::ReleaseRtMallocAddr(const void* ptr)
{
    for (auto &it : mallocVec_) {
        if (it.addr == ptr) {
            MSPROF_LOGI("Acp release malloc addr: %p.", it.addr);
            it.addr = nullptr;
        }
    }
}

/**
 * @brief Save malloc memory if exist
 * @param [in] stream: stream id
 * @return
 */
void AcpManager::SaveMallocMemory(rtStream_t stream)
{
    // if rtMallocFunc_ and rtFreeFunc_ registered, save those memory
    if (rtMallocFunc_ != nullptr && rtFreeFunc_ != nullptr) {
        SaveRtMallocMemory(stream);
    }
}

/**
 * @brief MemcpyAsync malloc memory applied by rtMalloc
 * @param [in] stream: stream id
 * @return
 */
void AcpManager::SaveRtMallocMemory(rtStream_t stream)
{
    rtError_t ret = ACL_RT_SUCCESS;
    for (auto &it : mallocVec_) {
        if (it.size == 0 || it.addr == nullptr) {
            AcpBackupAttr attr = {nullptr, 0, 0, 0};
            memoryVec_.emplace_back(attr);
            MSPROF_LOGW("Acp save nullptr memory, type: %u, moduleId: %u.", it.type, it.moduleId);
            continue;
        }
        // malloc and memcpy memory ptr
        void *ptr = nullptr;
        void **upPtr = reinterpret_cast<void **>(&ptr);
        ret = rtMallocFunc_(upPtr, it.size, static_cast<rtMemType_t>(it.type), it.moduleId);
        FUNRET_CHECK_EXPR_ACTION(ret != ACL_RT_SUCCESS, break, "Failed to malloc back up ptr, ret: %d.", ret);
        ret = rtMemcpyAsyncFunc_(ptr, it.size, it.addr, it.size, RT_MEMCPY_DEVICE_TO_DEVICE, stream);
        FUNRET_CHECK_EXPR_PRINT(ret != ACL_RT_SUCCESS, "Failed to memcpy malloc ptr, ret: %d.", ret);
        // save memory ptr in vector
        AcpBackupAttr attr = {ptr, it.size, it.type, it.moduleId};
        memoryVec_.emplace_back(attr);
        MSPROF_LOGI("Acp save malloc memory, addr: %p, size: %llu, type: %u, moduleId: %u.", attr.addr, attr.size,
            attr.type, attr.moduleId);
    }
    ret = AcpApiPlugin::instance()->ApiRtStreamSynchronize(stream);
    FUNRET_CHECK_EXPR_PRINT(ret != ACL_RT_SUCCESS, "Failed to execute rtStreamSynchronize.");
}

/**
 * @brief reset malloc memory if exist
 * @param [in] stream: stream id
 * @return
 */
void AcpManager::ResetMallocMemory(rtStream_t stream)
{
    // if rtMallocFunc_ and rtFreeFunc_ registered, reset those memory
    if (rtMallocFunc_ != nullptr && rtFreeFunc_ != nullptr) {
        ResetRtMallocMemory(stream);
    }
}

/**
 * @brief reset malloc memory applied by rtMalloc before kernel execute
 * @param [in] stream: stream id
 * @return
 */
void AcpManager::ResetRtMallocMemory(rtStream_t stream)
{
    if (mallocVec_.size() != memoryVec_.size()) {
        MSPROF_LOGE("Malloc size %zu not match memory size %zu.", mallocVec_.size(), memoryVec_.size());
        return;
    }

    rtError_t ret = ACL_RT_SUCCESS;
    for (uint32_t i = 0; i < static_cast<uint32_t>(mallocVec_.size()); i++) {
        if (mallocVec_[i].addr == nullptr) {
            MSPROF_LOGD("Malloc addr already free, index: %u.", i);
            continue;
        }
        // reset malloc memory
        ret = rtMemcpyAsyncFunc_(mallocVec_[i].addr, mallocVec_[i].size, memoryVec_[i].addr, memoryVec_[i].size,
            RT_MEMCPY_DEVICE_TO_DEVICE, stream);
        FUNRET_CHECK_EXPR_ACTION(ret != ACL_RT_SUCCESS, break, "Failed to memcpy back up ptr, ret: %d.", ret);
        MSPROF_LOGI("Acp reset malloc memory, addr: %p, size: %llu, type: %u, moduleId: %u.", mallocVec_[i].addr,
            mallocVec_[i].size, mallocVec_[i].type, mallocVec_[i].moduleId);
    }
    ret = AcpApiPlugin::instance()->ApiRtStreamSynchronize(stream);
    FUNRET_CHECK_EXPR_PRINT(ret != ACL_RT_SUCCESS, "Failed to execute rtStreamSynchronize.");
}

/**
 * @brief clear malloc memory if exist
 * @return
 */
void AcpManager::ClearMallocMemory()
{
    // if rtMallocFunc_ and rtFreeFunc_ registered, clear those memory
    if (rtMallocFunc_ != nullptr && rtFreeFunc_ != nullptr) {
        ClearRtMallocMemory();
    }
}

/**
 * @brief clear malloc memory applied by rtMalloc
 * @return
 */
void AcpManager::ClearRtMallocMemory()
{
    for (auto &it : memoryVec_) {
        if (it.addr != nullptr) {
            (void)rtFreeFunc_(it.addr);
        }
    }
    memoryVec_.clear();
}

/**
 * @brief clear malloc address if exist
 * @return
 */
void AcpManager::ClearMallocAddr()
{
    // if rtMallocFunc_ and rtFreeFunc_ registered, clear those address
    if (rtMallocFunc_ != nullptr && rtFreeFunc_ != nullptr) {
        ClearRtMallocAddr();
    }
}

/**
 * @brief clear malloc address applied by rtMalloc
 * @return
 */
void AcpManager::ClearRtMallocAddr()
{
    for (auto &it : mallocVec_) {
        it.addr = nullptr;
    }
    mallocVec_.clear();
}
}
}
}