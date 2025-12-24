/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "rpc_dumper.h"
#include <algorithm>
#include "codec.h"
#include "config/config.h"
#include "error_code.h"
#include "prof_params.h"
#include "msprof_dlog.h"
#include "rpc_data_handle.h"
#include "utils.h"
#include "param_validation.h"

namespace Msprof {
namespace Engine {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::validation;
using namespace Analysis::Dvvp::MsprofErrMgr;
/**
* @brief RpcDumper: the construct function
* @param [in] module: the path of profiling data to be saved
*/
RpcDumper::RpcDumper(const std::string &module)
    : DataDumper(), moduleNameWithId_(module), hostPid_(-1), devId_(-1), dataHandle_(nullptr)
{
}

RpcDumper::~RpcDumper()
{
    Stop();
}

int32_t RpcDumper::GetNameAndId(const std::string &module)
{
    MSPROF_LOGI("GetNameAndId module:%s", module.c_str());
    size_t posTmp = module.find_first_of("-");
    if (posTmp == std::string::npos) {
        module_ = module;
        return PROFILING_SUCCESS;
    }
    size_t pos = module.find_last_of("-");
    if (posTmp >= pos) {
        MSPROF_LOGE("get pos failed, module:%s", module.c_str());
        MSPROF_INNER_ERROR("EK9999", "get pos failed, module:%s", module.c_str());
        return PROFILING_FAILED;
    }
    module_ = module.substr(0, posTmp);
    std::string hostPidStr = module.substr(posTmp + 1, pos - posTmp - 1);
    try {
        hostPid_ = std::stoi(hostPidStr);
    } catch (...) {
        MSPROF_LOGE("Failed to transfer hostPidStr(%s) to integer.", hostPidStr.c_str());
        MSPROF_INNER_ERROR("EK9999", "Failed to transfer hostPidStr(%s) to integer.", hostPidStr.c_str());
        return PROFILING_FAILED;
    }
    std::string devIdStr = module.substr(pos + 1, module.size());
    try {
        devId_ = std::stoi(devIdStr);
    } catch (...) {
        MSPROF_LOGE("Failed to transfer hostPidStr(%s) to integer.", devIdStr.c_str());
        MSPROF_INNER_ERROR("EK9999", "Failed to transfer hostPidStr(%s) to integer.", devIdStr.c_str());
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("Get module:%s, hostPid:%d, devId:%d success", module_.c_str(), hostPid_, devId_);
    return PROFILING_SUCCESS;
}

/**
* @brief Start: init variables of RpcDumper for can receive data from user plugin
*               start a new thread to check the data from user and write data to local files
* @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
*/
int32_t RpcDumper::Start()
{
    if (started_) {
        MSPROF_LOGW("this reporter has been started!");
        return PROFILING_SUCCESS;
    }
    int32_t ret = GetNameAndId(moduleNameWithId_);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("RpcDumper GetNameAndId failed");
        MSPROF_INNER_ERROR("EK9999", "RpcDumper GetNameAndId failed");
        return PROFILING_FAILED;
    }
    ReceiveData::moduleName_ = module_;
    MSVP_MAKE_SHARED4(dataHandle_, RpcDataHandle, moduleNameWithId_, module_, hostPid_, devId_,
        return PROFILING_FAILED);
    ret = dataHandle_->Init();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("RpcDumper dataHandle init failed");
        MSPROF_INNER_ERROR("EK9999", "RpcDumper dataHandle init failed");
        return PROFILING_FAILED;
    }
    ret = dataHandle_->TryToConnect();
    FUNRET_CHECK_EXPR_ACTION_LOGW(ret != PROFILING_SUCCESS, return PROFILING_FAILED,
        "RpcDumper dataHandle try connect unsuccessfully.");

    Thread::SetThreadName(analysis::dvvp::common::config::MSVP_RPC_DUMPER_THREAD_NAME);
    ret = Thread::Start();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to start the reporter %s in RpcDumper::Start().", moduleNameWithId_.c_str());
        MSPROF_INNER_ERROR("EK9999", "Failed to start the reporter %s in RpcDumper::Start().",
            moduleNameWithId_.c_str());
        return PROFILING_FAILED;
    } else {
        MSPROF_LOGI("Succeeded in starting the reporter %s in RpcDumper::Start().", moduleNameWithId_.c_str());
    }

    size_t capacity = RING_BUFF_CAPACITY;
    auto iter = std::find_if(std::begin(MSPROF_MODULE_ID_NAME_MAP), std::end(MSPROF_MODULE_ID_NAME_MAP),
        [&](ModuleIdName m) { return m.name == module_; });
    if (iter != std::end(MSPROF_MODULE_ID_NAME_MAP)) {
        ReceiveData::moduleId_ = iter->id;
        capacity = iter->ringBufSize;
    }
    ret = ReceiveData::Init();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("ReceiveData Init failed");
        MSPROF_INNER_ERROR("EK9999", "ReceiveData Init failed");
        return PROFILING_FAILED;
    }
    started_ = true;
    MSPROF_LOGI("start reporter success. module:%s, capacity:%" PRIu64, module_.c_str(), capacity);
    return PROFILING_SUCCESS;
}

int32_t RpcDumper::Report(CONST_REPORT_DATA_PTR rData)
{
    return DoReport(rData);
}

uint32_t RpcDumper::GetReportDataMaxLen() const
{
    MSPROF_LOGI("GetReporterMaxLen from module: %s", module_.c_str());
    return RECEIVE_CHUNK_SIZE;
}

/**
* @brief Run: the thread function to deal with user datas
*/
void RpcDumper::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    DoReportRun();
}

/**
* @brief Run: read datas from ring buffer to build ProfileFileChunk,
*             the read data times is MAX_LOOP_TIMES
* @param [out] fileChunks: data from user to write to local file or send to remote host
*/
void RpcDumper::RunDefaultProfileData(const std::vector<SHARED_PTR_ALIA<FileChunkReq>>& fileChunks) const
{
    (void)fileChunks;
}

void RpcDumper::DoReportRun()
{
    std::vector<SHARED_PTR_ALIA<FileChunkReq> > fileChunks;
    unsigned long sleepIntevalNs = 50000000; // 50,000,000 : 50ms
    timeStamp_ = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();

    for (;;) {
        fileChunks.clear();
        RunDefaultProfileData(fileChunks);
        size_t size = fileChunks.size();
        if (size == 0) {
            SetBufferEmptyEvent();
            if (stopped_) {
                WriteDone();
                MSPROF_LOGI("Exit the Run thread");
                break;
            }
            analysis::dvvp::common::utils::Utils::UsleepInterupt(SLEEP_INTEVAL_US);
            unsigned long long curTimeStamp = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
            if ((curTimeStamp - timeStamp_) >= sleepIntevalNs || (timeStamp_ == 0)) {
                TimedTask();
                timeStamp_ = curTimeStamp;
            }
            continue;
        }
        if (Dump(fileChunks) != PROFILING_SUCCESS) {
            MSPROF_LOGE("Dump Received Data failed");
        }
    }
}

/**
* @brief Stop: wait data write finished, then stop the thread, which check data from user
*/
int32_t RpcDumper::Stop()
{
    int32_t ret = PROFILING_SUCCESS;
    if (started_) {
        started_ = false;
        ReceiveData::StopReceiveData();
        ret = Thread::Stop();
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to stop the reporter %s in RpcDumper::Stop().", module_.c_str());
            MSPROF_INNER_ERROR("EK9999", "Failed to stop the reporter %s in RpcDumper::Stop().", module_.c_str());
            return PROFILING_FAILED;
        } else {
            MSPROF_LOGI("Succeeded in stopping the reporter %s in RpcDumper::Stop().", module_.c_str());
        }
        dataHandle_->UnInit();
        ReceiveData::PrintTotalSize();
        MSPROF_LOGI("RpcDumper stop module:%s", moduleNameWithId_.c_str());
    }
    return ret;
}

void RpcDumper::WriteDone()
{
    SHARED_PTR_ALIA<FileChunkReq> fileChunk;
    MSVP_MAKE_SHARED0(fileChunk, FileChunkReq, return);
    fileChunk->set_filename(module_);
    fileChunk->set_datamodule(analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_MSPROF);
    fileChunk->set_islastchunk(true);
    fileChunk->set_needack(false);
    fileChunk->set_offset(-1);
    fileChunk->set_chunksizeinbytes(0);

    SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx = nullptr;
    MSVP_MAKE_SHARED0(jobCtx, analysis::dvvp::message::JobContext, return);
    jobCtx->module = module_;
    jobCtx->dataModule = analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_MSPROF;
    MSPROF_LOGI("RpcDumper WriteDone for module %s", moduleNameWithId_.c_str());

    auto iter = devIds_.begin();
    for (; iter != devIds_.end(); iter++) {
        jobCtx->dev_id = *iter;
        fileChunk->mutable_hdr()->set_job_ctx(jobCtx->ToString());

        std::string data = analysis::dvvp::message::EncodeMessage(fileChunk);
        if (data.size() > 0) {
            if (dataHandle_->SendData(data.c_str(), data.size(), module_.c_str(), jobCtx->ToString().c_str())
                != PROFILING_SUCCESS) {
                MSPROF_LOGE("send last FileChunk package failed");
                MSPROF_INNER_ERROR("EK9999", "send last FileChunk package failed");
                continue;
            }
        } else {
            MSPROF_LOGE("Encode the last FileChunk failed");
            MSPROF_INNER_ERROR("EK9999", "Encode the last FileChunk failed");
            continue;
        }
    }
}

/**
* @brief Flush: write all datas from user to local files
* @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
*/
int32_t RpcDumper::Flush()
{
    if (!started_) {
        MSPROF_LOGW("this reporter has been stopped");
        return PROFILING_SUCCESS;
    }
    MSPROF_LOGD("[RpcDumper::Flush]Begin to flush data, module:%s", moduleNameWithId_.c_str());
    ReceiveData::Flush();
    TimedTask();
    MSPROF_LOGD("[RpcDumper::Flush]End to flush data, module:%s", moduleNameWithId_.c_str());
    return PROFILING_SUCCESS;
}

void RpcDumper::TimedTask()
{
    dataHandle_->Flush();
}

/**
* @brief DumpData: deal with the data from user to build FileChunkReq struct for store or send
* @param [in] message: data saved in the ring buffer
* @param [out] fileChunk: data build from message for store or send
* @return : success return PROFILING_SUCCESS, failed return PROFILING_FAILED
*/
int32_t RpcDumper::DumpData(std::vector<ReporterDataChunk> &message, SHARED_PTR_ALIA<FileChunkReq> fileChunk)
{
    if (fileChunk == nullptr) {
        MSPROF_LOGE("fileChunk or dataPool is nullptr");
        return PROFILING_FAILED;
    }
    SHARED_PTR_ALIA<analysis::dvvp::message::JobContext> jobCtx = nullptr;
    MSVP_MAKE_SHARED0(jobCtx, analysis::dvvp::message::JobContext, return PROFILING_FAILED);
    size_t chunkLen = 0;
    std::string chunk = "";
    bool isFirstMessage = true;
    for (size_t i = 0; i < message.size(); i++) {
        size_t messageLen = static_cast<size_t>(message[i].dataLen);
        CHAR_PTR dataPtr = reinterpret_cast<CHAR_PTR>(&message[i].data[0]);
        if (dataPtr == nullptr) {
            return PROFILING_FAILED;
        }
        if (isFirstMessage) { // deal with the data only need to init once
            jobCtx->dev_id = std::to_string(DEFAULT_HOST_ID);
            jobCtx->tag = std::string(message[i].tag, strlen(message[i].tag));
            fileChunk->set_filename(moduleName_);
            fileChunk->set_offset(-1);
            chunkLen = messageLen;
            chunk = std::string(dataPtr, chunkLen);
            fileChunk->set_islastchunk(false);
            fileChunk->set_needack(false);
            fileChunk->set_tag(std::string(message[i].tag, strlen(message[i].tag)));
            fileChunk->set_tagsuffix(jobCtx->dev_id);
            fileChunk->set_chunkstarttime(message[i].reportTime);
            fileChunk->set_chunkendtime(message[i].reportTime);
            isFirstMessage = false;
            devIds_.insert(jobCtx->dev_id);
        } else { // deal with the data need to update according every message
            chunk.insert(chunkLen, std::string(dataPtr, messageLen));
            chunkLen += messageLen;
            fileChunk->set_chunkendtime(message[i].reportTime);
        }
    }
    jobCtx->module = moduleName_;
    jobCtx->chunkStartTime = fileChunk->chunkstarttime();
    jobCtx->chunkEndTime = fileChunk->chunkendtime();
    jobCtx->dataModule = analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST;
    fileChunk->mutable_hdr()->set_job_ctx(jobCtx->ToString());
    fileChunk->set_chunk(chunk);
    fileChunk->set_chunksizeinbytes(chunkLen);
    return PROFILING_SUCCESS;
}

int32_t RpcDumper::Dump(std::vector<SHARED_PTR_ALIA<ProfileFileChunk>> &message)
{
    UNUSED(message);
    MSPROF_LOGD("message size is : %zu", message.size());
    return PROFILING_SUCCESS;
}

/**
* @brief Dump: write the user datas in messages into local files
* @param [in] messages: the vector saved the user datas to be write to local files
* @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
*/
int32_t RpcDumper::Dump(std::vector<SHARED_PTR_ALIA<FileChunkReq>> &messages)
{
    int32_t ret = PROFILING_SUCCESS;
    if (!(dataHandle_->IsReady()) && (messages.size() > 0)) {
        dataHandle_->TryToConnect();
    }
    for (size_t i = 0; i < messages.size(); i++) {
        if (messages[i] == nullptr) {
            continue;
        }
        std::string tag = messages[i]->tag();
        if (!ParamValidation::instance()->CheckDataTagIsValid(tag)) {
            MSPROF_LOGE("UploaderDumper::Dump, Check tag failed, module:%s, tag:%s",
                module_.c_str(), messages[i]->tag().c_str());
            MSPROF_INNER_ERROR("EK9999", "UploaderDumper::Dump, Check tag failed, module:%s, tag:%s",
                module_.c_str(), messages[i]->tag().c_str());
            continue;
        }
        messages[i]->set_datamodule(FileChunkDataModule::PROFILING_IS_FROM_MSPROF);
        // update total_size
        std::string encoded = analysis::dvvp::message::EncodeMessage(messages[i]);
        std::string fileName = module_ + "." + messages[i]->tag() + "." + messages[i]->tagsuffix();
        ret = dataHandle_->SendData(encoded.c_str(), encoded.size(), fileName, messages[i]->hdr().job_ctx().c_str());
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("RpcDumper::Dump, UploadData failed, fileName:%s, chunkLen:%d",
                module_.c_str(), messages[i]->chunksizeinbytes());
            MSPROF_INNER_ERROR("EK9999", "RpcDumper::Dump, UploadData failed, fileName:%s, chunkLen:%d",
                module_.c_str(), messages[i]->chunksizeinbytes());
        }
    }
    return ret;
}
}
}
