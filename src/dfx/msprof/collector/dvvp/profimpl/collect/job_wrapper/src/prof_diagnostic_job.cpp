/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_diagnostic_job.h"
#include <dlfcn.h>
#include "logger/msprof_dlog.h"
#include "platform/platform.h"
#include "hash_data.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {

using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::MsprofErrMgr;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::config;

const std::string DRV_DSMI_LIB_PATH = "libdrvdsmi_host.so";
bool MsprofDiagnostic::isTriggered_ = false;
std::mutex MsprofDiagnostic::dataMtx_;

/*
 * @brief Load the driver so during construction.If this step can be performed, the platform determines
 *  that the driver supports this function.
 */
MsprofDiagnostic::MsprofDiagnostic()
{
    if (drvDsmiLibHandle_ == nullptr) {
        MSPROF_LOGI("Init api handle from %s", DRV_DSMI_LIB_PATH.c_str());
        drvDsmiLibHandle_ = dlopen(DRV_DSMI_LIB_PATH.c_str(), RTLD_NOW | RTLD_GLOBAL | RTLD_NODELETE);
    }
    if (drvDsmiLibHandle_ == nullptr) {
        MSPROF_LOGW("Unable to dlopen api from %s, return code: %s\n", DRV_DSMI_LIB_PATH.c_str(), dlerror());
    }
}

MsprofDiagnostic::~MsprofDiagnostic()
{
    if (drvDsmiLibHandle_ != nullptr) {
        dlclose(drvDsmiLibHandle_);
    }
}

int32_t MsprofDiagnostic::Start()
{
    if (drvDsmiLibHandle_ == nullptr) {
        return PROFILING_FAILED;
    }
    dsmiReadFaultEvent_ = reinterpret_cast<DsmiReadFaultEventFunc>(dlsym(drvDsmiLibHandle_, "dsmi_read_fault_event"));
    if (dsmiReadFaultEvent_ == nullptr) {
        MSPROF_LOGE("Dlsym api dsmi_read_fault_event failed.");
        return PROFILING_FAILED;
    }

    Thread::SetThreadName(analysis::dvvp::common::config::MSVP_DIAGNOSTIC_THREAD_NAME);

    if (Thread::Start() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to start the upload in MsprofDiagnostic::Start().");
        return PROFILING_FAILED;
    }

    MSPROF_EVENT("Succeeded in starting the upload in MsprofDiagnostic::Start().");
    return PROFILING_SUCCESS;
}

void MsprofDiagnostic::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    do {
        dsmi_event event;
        (void)memset_s(&event, sizeof(event), 0, sizeof(event));
        dsmi_event_filter filter = {0, 0, 0, 0, {0}}; // Do not use filtering
        const int32_t timeout = 20; // waiting for 20ms
        int32_t ret = dsmiReadFaultEvent_(-1, timeout, filter, &event);
        if (ret == DRV_ERROR_WAIT_TIMEOUT) {
            continue;
        }
        if (ret != DRV_ERROR_NONE) {
            MSPROF_LOGW("dsmi_read_fault_event execution exception, ret is %d.", ret);
            break;
        }
        EventHandler(&event);
        MSPROF_LOGI("dsmi_read_fault_event handle an message successfully.");
    } while (!IsQuit());
}

int32_t MsprofDiagnostic::Stop()
{
    MSPROF_LOGI("Stop diagnostic thread begin.");

    int32_t ret = Thread::Stop();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Diagnostic upload Thread stop failed.");
        return PROFILING_FAILED;
    }
    MSPROF_EVENT("Diagnostic thread stopped success.");
    return PROFILING_SUCCESS;
}

void MsprofDiagnostic::EventHandler(struct dsmi_event *event) const
{
    MSPROF_LOGI("Received an exception message from dsmi_subscribe_fault_event.");
    if (event == nullptr) {
        MSPROF_LOGW("Received an nullptr exception message.");
        return;
    }
    if (event->type != DMS_FAULT_EVENT ||
        g_eventIdSet.find(event->event_t.dms_event.event_id) == g_eventIdSet.end() ||
        event->event_t.dms_event.deviceid >= MSVP_MAX_DEV_NUM) {
        MSPROF_LOGD("This exception message types[%d] with event id[%u] in device[%hu] do not need to be processed.",
            event->type, event->event_t.dms_event.event_id, event->event_t.dms_event.deviceid);
        return;
    }

    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    UploaderMgr::instance()->GetUploader(std::to_string(DEFAULT_HOST_ID), uploader);
    if (uploader == nullptr) { // Check whether a task is started on the DEFAULT_HOST_ID by obtaining the uploader.
        MSPROF_LOGD("The uploader with device id %d does not exist.", DEFAULT_HOST_ID);
        return;
    }
    DumpData(event->event_t.dms_event);
}

void MsprofDiagnostic::DumpData(dms_fault_event dmsEvent) const
{
    MSPROF_LOGI("Start to dump data to additional struct.");
    std::string faultData = Utils::PackDotInfo(std::string(dmsEvent.event_name, strlen(dmsEvent.event_name)),
        std::string(dmsEvent.additional_info, strlen(dmsEvent.additional_info)));
    ProfFaultEvent faultEvent = {dmsEvent.severity, dmsEvent.assertion, dmsEvent.deviceid, dmsEvent.event_id,
        HashData::instance()->GenHashId(faultData)};

    MsprofAdditionalInfo additionalInfo;
    additionalInfo.level = MSPROF_REPORT_PROF_LEVEL;
    additionalInfo.type = MSPROF_REPORT_DIAGNOSTIC_INFO_TYPE;
    additionalInfo.threadId = OsalGetTid();
    additionalInfo.dataLen = sizeof(ProfFaultEvent);
    auto err = memcpy_s(additionalInfo.data, additionalInfo.dataLen, &faultEvent, additionalInfo.dataLen);
    if (err != EOK) {
        MSPROF_LOGE("memcpy_s diagnostic data failed, ret is %d.", err);
        return;
    }
    additionalInfo.timeStamp = Utils::GreenwichToMonotonic(dmsEvent.alarm_raised_time);
    DataTransport(additionalInfo);
}

void MsprofDiagnostic::DataTransport(MsprofAdditionalInfo &additionalInfo) const
{
    MSPROF_LOGI("Start to dump data to additional struct.");
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk = nullptr;
    MSVP_MAKE_SHARED0_NODO(fileChunk, analysis::dvvp::ProfileFileChunk, return);
    const size_t chunkLen = sizeof(MsprofAdditionalInfo);
    CHAR_PTR dataPtr = reinterpret_cast<CHAR_PTR>(&additionalInfo);
    if (dataPtr == nullptr) {
        MSPROF_LOGW("The obtained structure address is a null pointer.");
        return;
    }
    fileChunk->fileName = "unaging.additional.diagnostic";
    fileChunk->offset = -1;
    fileChunk->chunk = std::string(dataPtr, chunkLen);
    fileChunk->isLastChunk = false;
    fileChunk->extraInfo = Utils::PackDotInfo(NULL_CHUNK, std::to_string(DEFAULT_HOST_ID));
    fileChunk->chunkModule = analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST;
    fileChunk->chunkSize = chunkLen;

    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    UploaderMgr::instance()->GetUploader(std::to_string(DEFAULT_HOST_ID), uploader);
    if (uploader != nullptr) {
        MSPROF_LOGI("Start to upload a piece of diagnostic data.");
        uploader->UploadData(fileChunk);
    }
    MSPROF_LOGI("DataTransport finished.");
}

/*
 * @brief This prevents an error from being reported when the profiling thread is started
 *  for multiple times in a process.
 */
bool MsprofDiagnostic::IsTriggered()
{
    std::unique_lock<std::mutex> lk(dataMtx_);
    if (MsprofDiagnostic::isTriggered_) {
        return true;
    }
    MsprofDiagnostic::isTriggered_ = true;
    return false;
}

ProfDiagnostic::ProfDiagnostic() : diagnostic_(nullptr)
{
}

/*
 * @brief Depends on the startup of host collection and the platform feature.
 * @param [in] cfg: pointer of CollectionJobCfg which saves various parameters.
 * @return PROFILING_SUCCESS:supported Features, PROFILING_NOTSUPPORT:unsupported Features
 */
int32_t ProfDiagnostic::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    if (!(cfg->comParams->params->hostProfiling) ||
        cfg->comParams->params->pureCpu.compare(MSVP_PROF_ON) == 0 ||
        !Platform::instance()->CheckIfSupport(PLATFORM_DIAGNOSTIC_COLLECTION)) {
        MSPROF_LOGI("Current thread is not support diagnostic collection.");
        return PROFILING_NOTSUPPORT;
    }
    if (MsprofDiagnostic::IsTriggered()) {
        MSPROF_LOGW("Current thread has been launched once.");
        return PROFILING_NOTSUPPORT;
    }
    MSPROF_LOGI("ProfDiagnostic init success, diagnostic collection is about to start.");
    return PROFILING_SUCCESS;
}

int32_t ProfDiagnostic::Process()
{
    MSVP_MAKE_SHARED0_NODO(diagnostic_, MsprofDiagnostic, return PROFILING_FAILED);
    int32_t ret = diagnostic_->Start();
    if (ret != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfDiagnostic::Uninit()
{
    MSPROF_LOGI("ProfDiagnostic start to uninit.");
    return diagnostic_->Stop();
}

}
}
}