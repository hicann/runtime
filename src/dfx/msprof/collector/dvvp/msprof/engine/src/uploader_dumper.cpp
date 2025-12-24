/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "uploader_dumper.h"
#include<algorithm>
#include "config/config.h"
#include "error_code.h"
#include "prof_params.h"
#include "msprof_dlog.h"
#include "prof_acl_mgr.h"
#include "transport/transport.h"
#include "transport/uploader.h"
#include "transport/uploader_mgr.h"
#include "utils.h"
#include "param_validation.h"
#include "json_parser.h"
#include "dyn_prof_server.h"

using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Statistics;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::transport;
using namespace Analysis::Dvvp::MsprofErrMgr;
using namespace Collector::Dvvp::DynProf;

namespace Msprof {
namespace Engine {
using namespace analysis::dvvp::common::validation;
using namespace Msprofiler::Parser;
/**
* @brief UploaderDumper: the construct function
* @param [in] module: the path of profiling data to be saved
*/
UploaderDumper::UploaderDumper(const std::string& module)
    : DataDumper(), module_(module)
{
    if (module_ == "Framework") {
        needCache_ = true;
    } else {
        needCache_ = false;
    }
}

UploaderDumper::~UploaderDumper()
{
    Stop();
}

/**
* @brief Start: init variables of UploaderDumper for can receive data from user plugin
*               start a new thread to check the data from user and write data to local files
* @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
*/
int32_t UploaderDumper::Start()
{
    if (started_) {
        MSPROF_LOGW("this reporter has been started!");
        return PROFILING_SUCCESS;
    }

    int32_t ret = PROFILING_SUCCESS;
    auto iter1 = std::find_if(std::begin(ADPROF_MODULE_REPORT_TABLE), std::end(ADPROF_MODULE_REPORT_TABLE),
        [this](ModuleIdName m) { return m.name == this->module_; });
    if (iter1 != std::end(ADPROF_MODULE_REPORT_TABLE)) {
        ReceiveData::moduleId_ = iter1->id;
        ReceiveData::moduleName_ = module_;
        ret = ReceiveData::Init();
    }
    auto iter2 = std::find_if(std::begin(MSPROF_MODULE_REPORT_TABLE), std::end(MSPROF_MODULE_REPORT_TABLE),
        [this](ModuleIdName m) { return m.name == this->module_; });
    if (iter2 != std::end(MSPROF_MODULE_REPORT_TABLE)) {
        ReceiveData::moduleId_ = iter2->id;
        ReceiveData::moduleName_ = module_;
        ret = ReceiveData::Init();
    }
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("ReceiveData Init failed");
        MSPROF_INNER_ERROR("EK9999", "ReceiveData Init failed");
        return PROFILING_FAILED;
    }

    Thread::SetThreadName(analysis::dvvp::common::config::MSVP_UPLOADER_DUMPER_THREAD_NAME);
    ret = Thread::Start();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to start the reporter %s in UploaderDumper::Start().", module_.c_str());
        MSPROF_INNER_ERROR("EK9999", "Failed to start the reporter %s in UploaderDumper::Start().",
            module_.c_str());
        return PROFILING_FAILED;
    } else {
        MSPROF_LOGI("Succeeded in starting the reporter %s in UploaderDumper::Start().", module_.c_str());
    }
    started_ = true;
    MSPROF_LOGI("UploaderDumper start reporter success. module:%s.", module_.c_str());
    return PROFILING_SUCCESS;
}

int32_t UploaderDumper::Report(CONST_REPORT_DATA_PTR rData)
{
    return DoReport(rData);
}

uint32_t UploaderDumper::GetReportDataMaxLen() const
{
    MSPROF_LOGI("GetReporterMaxLen from module: %s", module_.c_str());
    return RECEIVE_CHUNK_SIZE;
}

/**
* @brief Run: the thread function to deal with user datas
*/
void UploaderDumper::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    DoReportRun();
}

/**
* @brief Stop: wait data write finished, then stop the thread, which check data from user
*/
int32_t UploaderDumper::Stop()
{
    int32_t ret = PROFILING_SUCCESS;
    if (started_) {
        started_ = false;
        ReceiveData::StopReceiveData();
        ret = Thread::Stop();
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to stop the reporter %s in UploaderDumper::Stop().", module_.c_str());
            MSPROF_INNER_ERROR("EK9999", "Failed to stop the reporter %s in UploaderDumper::Stop().", module_.c_str());
            return PROFILING_FAILED;
        } else {
            MSPROF_LOGI("Succeeded in stopping the reporter %s in UploaderDumper::Stop().", module_.c_str());
        }
        ReceiveData::PrintTotalSize();
    }
    MSPROF_LOGI("UploaderDumper stop module:%s", module_.c_str());
    return ret;
}

void UploaderDumper::WriteDone()
{
    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    for (std::string devId : devIds_) {
        MSPROF_LOGI("UploaderDumper WriteDone for device %s", devId.c_str());
        UploaderMgr::instance()->GetUploader(devId, uploader);
        if (uploader != nullptr) {
            auto transport = uploader->GetTransport();
            if (transport != nullptr) {
                transport->WriteDone();
            }
        }
    }
}

/**
* @brief Flush: write all datas from user to local files
* @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
*/
int32_t UploaderDumper::Flush()
{
    if (!started_) {
        MSPROF_LOGW("this reporter has been stopped");
        return PROFILING_SUCCESS;
    }
    MSPROF_LOGD("[UploaderDumper::Flush]Begin to flush data, module:%s", module_.c_str());
    ReceiveData::FlushAll();
    WriteDone();
    MSPROF_LOGD("[UploaderDumper::Flush]End to flush data, module:%s", module_.c_str());
    return PROFILING_SUCCESS;
}

void UploaderDumper::TimedTask()
{
}

int32_t UploaderDumper::SendData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk)
{
    MSPROF_LOGI("UploaderDumper::SendData");
    if (fileChunk == nullptr) {
        MSPROF_LOGE("fileChunk is nullptr");
        MSPROF_INNER_ERROR("EK9999", "fileChunk is nullptr");
        return PROFILING_FAILED;
    }
    std::vector<SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> > fileChunks;
    fileChunks.clear();
    fileChunks.push_back(fileChunk); // insert the data into the new vector
    return Dump(fileChunks);
}

/**
* @brief Dump: write the user datas in messages into local files
* @param [in] messages: the vector saved the user datas to be write to local files
* @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
*/
int32_t UploaderDumper::Dump(std::vector<SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk>> &messages)
{
    for (size_t i = 0; i < messages.size(); i++) {
        if (messages[i] == nullptr) {
            continue;
        }
        if (messages[i]->extraInfo.empty()) {
            MSPROF_LOGE("FileChunk info is empty in Dump, skip message");
            continue;
        }
        std::string tag = Utils::GetInfoSuffix(messages[i]->fileName);
        if (!ParamValidation::instance()->CheckDataTagIsValid(tag)) {
            MSPROF_LOGE("UploaderDumper::Dump, Check tag failed, module:%s, tag:%s",
                module_.c_str(), tag.c_str());
            MSPROF_INNER_ERROR("EK9999", "UploaderDumper::Dump, Check tag failed, module:%s, tag:%s",
                module_.c_str(), tag.c_str());
            continue;
        }

        AddToUploader(messages[i]);
    }
    return PROFILING_SUCCESS;
}

void UploaderDumper::AddToUploader(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> message) const
{
    std::string devId = Utils::GetInfoSuffix(message->extraInfo);
    if (devId == std::to_string(DEFAULT_HOST_ID)) {
        message->chunkModule = FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST;
    } else {
        message->chunkModule = FileChunkDataModule::PROFILING_IS_FROM_MSPROF;
    }

    SHARED_PTR_ALIA<Uploader> uploader = nullptr;
    analysis::dvvp::transport::UploaderMgr::instance()->GetUploader(devId, uploader);
    if (uploader == nullptr) {
        MSPROF_LOGW("UploaderDumper::AddToUploader, get uploader[%s] unsuccessfully, fileName:%s, chunkLen:%zu",
            devId.c_str(), module_.c_str(), message->chunkSize);
        return;
    }
    int32_t ret = analysis::dvvp::transport::UploaderMgr::instance()->UploadData(devId, message);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("UploaderDumper::AddToUploader, UploadData failed, fileName:%s, chunkLen:%zu bytes",
                    module_.c_str(), message->chunkSize);
        MSPROF_INNER_ERROR("EK9999", "UploaderDumper::AddToUploader, UploadData failed, fileName:%s, "
            "chunkLen:%zu bytes", module_.c_str(), message->chunkSize);
    }
}
}
}
