/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "file_transport.h"
#include "hash_data.h"
#include "config/config.h"
#include "errno/error_code.h"
#include "osal.h"
#include "msprof_dlog.h"
#include "securec.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::utils;

FILETransport::FILETransport(const std::string &storageDir, const std::string &storageLimit)
    : fileSlice_(nullptr), storageDir_(storageDir), storageLimit_(storageLimit), needSlice_(true), stopped_(false),
    parseStr2IdStart_(false), hashDataGenIdFuncPtr_(nullptr)
{
}

FILETransport::~FILETransport()
{
    helperStorageMap_.clear();
}

int32_t FILETransport::Init()
{
    const int32_t sliceFileMaxKbyte = 2048; // size is about 2MB per file
    MSVP_MAKE_SHARED3(fileSlice_, FileSlice, sliceFileMaxKbyte, storageDir_, storageLimit_, return PROFILING_FAILED);
    if (fileSlice_->Init(needSlice_) != PROFILING_SUCCESS) {
        MSPROF_LOGE("file slice init failed.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

void FILETransport::SetAbility(bool needSlice)
{
    needSlice_ = needSlice;
}

void FILETransport::WriteDone()
{
    fileSlice_->FileSliceFlush();
}

int32_t FILETransport::SendBuffer(CONST_VOID_PTR /* buffer */, int32_t /* length */)
{
    MSPROF_LOGW("No need to send buffer");
    return 0;
}

int32_t FILETransport::SendBuffer(
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    if (fileChunkReq == nullptr) {
        MSPROF_LOGW("Unable to parse fileChunkReq");
        return PROFILING_SUCCESS;
    }
    MSPROF_LOGD("FileChunk filename:%s, module:%d",
        fileChunkReq->fileName.c_str(), fileChunkReq->chunkModule);
    if (fileChunkReq->chunkModule == FileChunkDataModule::PROFILING_IS_FROM_DEVICE ||
        fileChunkReq->chunkModule == FileChunkDataModule::PROFILING_IS_FROM_MSPROF ||
        fileChunkReq->chunkModule == FileChunkDataModule::PROFILING_IS_FROM_MSPROF_DEVICE ||
        fileChunkReq->chunkModule == FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST) {
        if (fileChunkReq->extraInfo.empty()) {
            MSPROF_LOGE("FileChunk info is empty in SendBuffer.");
            return PROFILING_FAILED;
        }
        if (fileChunkReq->fileName.find("adprof.data") != std::string::npos) {
            return ParseTlvChunk(fileChunkReq);
        }
        if (fileChunkReq->fileName.find("aicpu.data") != std::string::npos) {
            if (ParseStr2IdChunk(fileChunkReq) == PROFILING_SUCCESS) {
                return PROFILING_SUCCESS;
            }
        }
        std::string devId = Utils::GetInfoSuffix(fileChunkReq->extraInfo);
        std::string jobId = Utils::GetInfoPrefix(fileChunkReq->extraInfo);
        if (UpdateFileName(fileChunkReq, devId) != PROFILING_SUCCESS) {
            if (jobId.compare("64") == 0) {
                return PROFILING_SUCCESS;
            }
            MSPROF_LOGE("Failed to update file name");
            return PROFILING_FAILED;
        }
    }
    int32_t ret;
    if (helperStorageMap_.empty() || fileChunkReq->id.empty()) {
        ret = fileSlice_->SaveDataToLocalFiles(fileChunkReq, storageDir_);
    } else {
        std::unique_lock<std::mutex> guard(helperMtx_, std::defer_lock);
        guard.lock();
        std::string helperPath = helperStorageMap_[fileChunkReq->id];
        guard.unlock();
        ret = fileSlice_->SaveDataToLocalFiles(fileChunkReq, helperPath);
    }
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("write data to local files failed, fileName: %s", fileChunkReq->fileName.c_str());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t FILETransport::CloseSession()
{
    return PROFILING_SUCCESS;
}

int32_t FILETransport::UpdateFileName(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq,
    const std::string &devId) const
{
    std::string fileName = fileChunkReq->fileName;
    const size_t pos = fileName.find_last_of("/\\");
    if (pos != std::string::npos && pos + 1 < fileName.length()) {
        fileName = fileName.substr(pos + 1, fileName.length());
    }

    std::string tag = Utils::GetInfoSuffix(fileName);
    std::string fileNameOri = Utils::GetInfoPrefix(fileName);
    if (fileChunkReq->chunkModule != FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST) {
        uint32_t deviceId = 0;
        if (!Utils::StrToUint32(deviceId, devId) || deviceId >= DEFAULT_HOST_ID) {
            MSPROF_LOGW("dev_id is not valid: %s.", devId.c_str());
            return PROFILING_FAILED;
        }
        if (tag.length() == 0 || tag == "null") {
            fileName = fileNameOri.append(".").append(devId);
        } else {
            fileName = fileName.append(".").append(devId);
        }
    } else {
        if (tag.length() == 0 || tag == "null") {
            fileName = fileNameOri;
        }
    }
    fileChunkReq->fileName = "data" + std::string(MSVP_SLASH) + fileName;
    return PROFILING_SUCCESS;
}

/**
 * @brief parse data block that contains multiple tlv chunk for adprof, and save to target file
 * @param [in] fileChunkReq: ProfileFileChunk type shared_ptr
 * @return 0:SUCCESS, !0:FAILED
 */
int32_t FILETransport::ParseTlvChunk(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq)
{
    SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk;
    MSVP_MAKE_SHARED0(fileChunk, analysis::dvvp::ProfileFileChunk, return PROFILING_FAILED);
    fileChunk->extraInfo = fileChunkReq->extraInfo;

    const uint32_t structSize = sizeof(ProfTlv);
    const char *data = fileChunkReq->chunk.data();
    std::string &fileName = fileChunkReq->fileName;

    // If there is cached data, some data in front of the chunk belongs to the previous chunk.
    if (channelBuffer_.find(fileName) != channelBuffer_.end() && channelBuffer_[fileName].size() != 0 &&
        channelBuffer_[fileName].size() < structSize) {
        const uint32_t prevDataSize = channelBuffer_[fileName].size();
        const uint32_t leftDataSize = structSize - prevDataSize;
        if (fileChunkReq->chunkSize < leftDataSize) {
            MSPROF_LOGE("fileChunk size smaller than expected, expected minimum size %u, received size %zu",
                leftDataSize, fileChunkReq->chunkSize);
            return PROFILING_FAILED;
        }
        channelBuffer_[fileName].append(data, leftDataSize);
        if (SaveChunk(channelBuffer_[fileName].data(), fileChunk) != PROFILING_SUCCESS) {
            return PROFILING_FAILED;
        }
        channelBuffer_[fileName].clear();
        data += leftDataSize;
        fileChunkReq->chunkSize -= leftDataSize;
    }

    // Store complete struct
    const uint32_t structNum = fileChunkReq->chunkSize / structSize;
    for (uint32_t i = 0; i < structNum; ++i) {
        if (SaveChunk(data, fileChunk) != PROFILING_SUCCESS) {
            return PROFILING_FAILED;
        }
        data += structSize;
    }

    // Cache last truncated struct data
    const uint32_t dataLeft = fileChunkReq->chunkSize - structNum * structSize;
    if (dataLeft != 0) {
        MSPROF_LOGI("Cache truncated data, fileName: %s, cache size: %u", fileName.c_str(), dataLeft);
        channelBuffer_[fileName].reserve(structSize + 1);
        channelBuffer_[fileName].append(data, dataLeft);
    }

    return PROFILING_SUCCESS;
}

void FILETransport::AddHashData(const std::string& input) const{
    if (hashDataGenIdFuncPtr_ == nullptr) {
        MSPROF_LOGE("hashDataGenIdFuncPtr_ is null");
        return;
    }
    std::stringstream ss(input);
    std::string item;
    while (std::getline(ss, item, STR2ID_DELIMITER[0])) {
        uint64_t uid = hashDataGenIdFuncPtr_(item);
        MSPROF_LOGD("add str2id:%s uid:%u from adprof into hash data ", item.c_str(), uid);
    }
}

/**
 * @brief remove str2id info header mark
 * @param [in] data string
 * @return true: header mark matched, false: not matched
 */
bool removeStr2IdHeaderMark(std::string& str) {
    // keep mark the same as ReportStr2IdInfoToHost in devprof_drv_aicpu
    const std::string mark = "###drv_hashdata###";
    if (str.compare(0, mark.length(), mark) == 0) {
        str.erase(0, mark.length());
        return true;
    }
    return false;
}

/**
 * @brief parse data block that contains str2id info chunk for adprof, and save to target file
 * @param [in] fileChunkReq: ProfileFileChunk type shared_ptr
 * @return 0:SUCCESS, !0:FAILED
 */
int32_t FILETransport::ParseStr2IdChunk(const SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq) {
    if (fileChunkReq == nullptr) {
        MSPROF_LOGW("Unable to parse fileChunkReq");
        return (parseStr2IdStart_ ? PROFILING_SUCCESS : PROFILING_FAILED);
    }
    if (fileChunkReq->chunk.length() == 0) {
        MSPROF_LOGW("str2id fileChunk length is 0");
        return (parseStr2IdStart_ ? PROFILING_SUCCESS : PROFILING_FAILED);
    }
    if (parseStr2IdStart_) {
        MSPROF_LOGD("parse str2id fileChunk data size:%u", fileChunkReq->chunk.length());
        AddHashData(fileChunkReq->chunk);
        return PROFILING_SUCCESS;
    } else if (removeStr2IdHeaderMark(fileChunkReq->chunk)) {
        MSPROF_LOGI("start parse drv str2id info");
        parseStr2IdStart_ = true;
        AddHashData(fileChunkReq->chunk);
        return PROFILING_SUCCESS;
    }
    return PROFILING_FAILED;
}

/**
 * @brief save ProfileFileChunk to local file
 * @param [in] data: struct data pointer
 * @param [in] fileChunk: ProfileFileChunk type shared_ptr
 * @return 0:SUCCESS, !0:FAILED
 */
int32_t FILETransport::SaveChunk(const char *data, SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunk) const
{
    FUNRET_CHECK_EXPR_ACTION_LOGW(data == nullptr, return PROFILING_SUCCESS,
        "Unable to parse struct data, pointer is null");

    const ProfTlv *packet = reinterpret_cast<const ProfTlv *>(data);
    if (packet->head != TLV_HEAD) {
        MSPROF_LOGE("Check tlv head failed");
        return PROFILING_FAILED;
    }
    const ProfTlvValue *tlvValue = reinterpret_cast<const ProfTlvValue *>(packet->value);
    fileChunk->isLastChunk = tlvValue->isLastChunk;
    fileChunk->chunkModule = tlvValue->chunkModule;
    fileChunk->chunkSize = tlvValue->chunkSize;
    fileChunk->offset = tlvValue->offset;
    fileChunk->chunk = std::string(tlvValue->chunk, tlvValue->chunkSize);
    fileChunk->fileName = tlvValue->fileName;

    std::string jobId = Utils::GetInfoPrefix(fileChunk->extraInfo);
    std::string devId = Utils::GetInfoSuffix(fileChunk->extraInfo);
    if (UpdateFileName(fileChunk, devId) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to update file name");
        return PROFILING_FAILED;
    }

    if (fileSlice_->SaveDataToLocalFiles(fileChunk, storageDir_) != PROFILING_SUCCESS) {
        MSPROF_LOGE("write data to local files failed, fileName: %s", fileChunk->fileName.c_str());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

/**
 * @brief transport absolute helper device path to file_slice
 * @param [in] id: devId + devPid
 * @param [in] helperPath: absolute helper path
 */
void FILETransport::SetHelperDir(const std::string &id, const std::string &helperPath)
{
    std::unique_lock<std::mutex> lk(helperMtx_);
    MSPROF_LOGI("SetHelperDir, id: %s, helperPath: %s", id.c_str(), helperPath.c_str());
    helperStorageMap_[id] = helperPath;
}

SHARED_PTR_ALIA<ITransport> FileTransportFactory::CreateFileTransport(
    const std::string &storageDir, const std::string &storageLimit, bool needSlice) const
{
    SHARED_PTR_ALIA<FILETransport> fileTransport;
    MSVP_MAKE_SHARED2(fileTransport, FILETransport, storageDir, storageLimit, return fileTransport);
    MSVP_MAKE_SHARED2(fileTransport->perfCount_, PerfCount, FILE_PERFCOUNT_MODULE_NAME,
        TRANSPORT_PRI_FREQ, return nullptr);
    fileTransport->SetAbility(needSlice);

    if (fileTransport->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("fileTransport init failed");
        MSPROF_INNER_ERROR("EK9999", "fileTransport init failed");
        return nullptr;
    }
    return fileTransport;
}

void FILETransport::SetStopped()
{
    stopped_ = true;
}

void FILETransport::RegisterHashDataGenIdFuncPtr(HashDataGenIdFuncPtr *ptr)
{
    hashDataGenIdFuncPtr_ = ptr;
}

} // namespace transport
} // namespace dvvp
} // namespace analysis
