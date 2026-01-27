/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "file_slice.h"
#include "file_ageing.h"
#include "config/config.h"
#include "logger/msprof_dlog.h"
#include "utils/utils.h"

using namespace Analysis::Dvvp::Common::Statistics;

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::utils;

FileSlice::FileSlice(int32_t sliceFileMaxKByte, const std::string &storageDir, const std::string &storageLimit)
    : sliceFileMaxKByte_(sliceFileMaxKByte), storageDir_(storageDir), needSlice_(true), storageLimit_(storageLimit)
{
}

FileSlice::~FileSlice() {}

int32_t FileSlice::Init(bool needSlice)
{
    static const std::string WRITE_PERFCOUNT_MODULE_NAME = std::string("FileSlice");
    MSVP_MAKE_SHARED1(writeFilePerfCount_, PerfCount, WRITE_PERFCOUNT_MODULE_NAME, return PROFILING_FAILED);
    if (!Utils::IsDirAccessible(storageDir_)) {
        MSPROF_LOGE("para err, storageDir_:%s, storageDirLen:%d",
                    Utils::BaseName(storageDir_).c_str(), storageDir_.length());
        return PROFILING_FAILED;
    }
    MSVP_MAKE_SHARED2(fileAgeing_, FileAgeing, storageDir_, storageLimit_, return PROFILING_FAILED);
    if (fileAgeing_->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to init file ageing engine");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("StorageDir_:%s, sliceFileMaxKByte:%d, needSlice_:%d, storage_limit:%s",
                Utils::BaseName(storageDir_).c_str(), sliceFileMaxKByte_, needSlice_, storageLimit_.c_str());
    Utils::EnsureEndsInSlash(storageDir_);
    needSlice_ = needSlice;

    return PROFILING_SUCCESS;
}

/**
 * @brief Set slice suffix and get slice key
 * @param [in] dir: absolute dir to flush data
 * @param [in] fileName: filename to flush data
 * @return : dir/fileName.slice_
 */
std::string FileSlice::GetSliceKey(const std::string &dir, std::string &fileName)
{
    if (needSlice_) {
        fileName.append(".slice_");
    }
    std::vector<std::string> absolutePathV;
    absolutePathV.push_back(dir);
    absolutePathV.push_back(fileName);
    std::string key = Utils::JoinPath(absolutePathV);
    const auto iter = sliceNum_.find(key);
    if (iter == sliceNum_.end()) {
        sliceNum_[key] = 0;
        totalSize_[key] = 0;
    }

    return key;
}

/**
 * @brief  : set start time or end time
 * @param  : [in] std::string key :
 * @param  : [in] uint64_t startTime :
 * @param  : [in] uint64_t endTime :
 * @return : PROFILING_FAILED (-1) failed
 *         : PROFILING_SUCCES (0)  success
 */
int32_t FileSlice::SetChunkTime(const std::string &key, uint64_t startTime, uint64_t endTime)
{
    if (key.length() == 0) {
        MSPROF_LOGE("key err");
        return PROFILING_FAILED;
    }

    if (!needSlice_) {
        return PROFILING_SUCCESS;
    }

    std::string sliceName = key;
    if (sliceNum_.find(key) == sliceNum_.end()) {
        sliceNum_[key] = 0;
    }
    sliceName.append(std::to_string(sliceNum_[key]));
    if (!(Utils::IsFileExist(sliceName)) || Utils::GetFileSize(sliceName) == 0) {
        chunkStartTime_[sliceName] = startTime;
        MSPROF_LOGD("Set start time, slicename:%s, starttime:%lld ns", sliceName.c_str(), startTime);
    }
    chunkEndTime_[sliceName] = endTime;
    return PROFILING_SUCCESS;
}

/**
 * @brief  : write data to slice files
 * @param  : [in] std::string key :
 * @param  : [in] const char* data :
 * @param  : [in] int32_t dataLen :
 * @param  : [in] int32_t offset :
 * @param  : [in] bool isLastChunk :
 * @return : PROFILING_FAILED (-1) failed
 *         : PROFILING_SUCCES (0)  success
 */
int32_t FileSlice::WriteToLocalFiles(const std::string &key, CONST_CHAR_PTR data, int32_t dataLen,
    int32_t offset, bool isLastChunk, std::string &fileName)
{
    int32_t res = WriteDataToFile(key, data, dataLen, offset);
    if (res != PROFILING_SUCCESS) {
        return res;
    }

    return HandleFileCompletion(key, fileName, isLastChunk);
}

int32_t FileSlice::WriteDataToFile(const std::string &key, CONST_CHAR_PTR data, int32_t dataLen, int32_t offset)
{
    if (key.length() == 0) {
        MSPROF_LOGE("para err!");
        return PROFILING_FAILED;
    }

    if (sliceNum_.find(key) == sliceNum_.end()) {
        sliceNum_[key] = 0;
    }
    std::string absolutePath = key;
    if (needSlice_) {
        absolutePath.append(std::to_string(sliceNum_[key]));
    }

    if (data != nullptr && dataLen > 0) {
        const uint64_t startRawTime = Utils::GetClockMonotonicRaw();
        std::ofstream out;
        out.open(absolutePath, std::ofstream::app | std::ios::binary);
        if (!out.is_open()) {
            const int32_t errorNo = OsalGetErrorCode();
            char errBuf[MAX_ERR_STRING_LEN + 1] = {0};
            MSPROF_LOGE("Failed to open %s, ErrorCode:%d, errinfo:%s", Utils::BaseName(absolutePath).c_str(),
                errorNo, OsalGetErrorFormatMessage(errorNo, errBuf, MAX_ERR_STRING_LEN));
            return PROFILING_FAILED;
        }
        if (offset != -1) {
            out.seekp(offset);
        }
        out.write(data, dataLen);
        out.flush();
        out.close();
        totalSize_[key] += dataLen;
        const uint64_t endRawTime = Utils::GetClockMonotonicRaw();
        writeFilePerfCount_->UpdatePerfInfo(startRawTime, endRawTime, dataLen); // update the PerfCount info
    }

    return PROFILING_SUCCESS;
}

int32_t FileSlice::HandleFileCompletion(const std::string &key, const std::string &fileName, bool isLastChunk)
{
    std::string absolutePath = key;
    if (needSlice_) {
        absolutePath.append(std::to_string(sliceNum_[key]));
    }

    int64_t fileSize = Utils::GetFileSize(absolutePath);
    if (fileName.find("capture_op_info") != std::string::npos) {
        if ((isLastChunk && Utils::IsFileExist(absolutePath)) && !(CreateDoneFile(absolutePath, std::to_string(fileSize), std::to_string(chunkStartTime_[absolutePath]),
            std::to_string(chunkEndTime_[absolutePath]), absolutePath))) {
                MSPROF_LOGE("Failed to create file:%s_%" PRIu64, Utils::BaseName(key).c_str(), sliceNum_[key]);
                return PROFILING_FAILED; 
        }
        MSPROF_LOGI("create done file:%s.done", Utils::BaseName(absolutePath).c_str());
        return PROFILING_SUCCESS;
    }
    if ((fileSize >= sliceFileMaxKByte_ * MEGABYTE_CONVERT || (isLastChunk && Utils::IsFileExist(absolutePath)))
        && (fileName.find("stars_soc.data") == std::string::npos || (fileSize % 64 == 0))) {
        if (!(CreateDoneFile(absolutePath, std::to_string(fileSize), std::to_string(chunkStartTime_[absolutePath]),
            std::to_string(chunkEndTime_[absolutePath]), absolutePath))) {
            MSPROF_LOGE("Failed to create file:%s_%" PRIu64, Utils::BaseName(key).c_str(), sliceNum_[key]);
            return PROFILING_FAILED;
        }
        MSPROF_LOGI("create done file:%s.done", Utils::BaseName(absolutePath).c_str());
        sliceNum_[key]++;
    }

    return PROFILING_SUCCESS;
}

/**
 * @brief Check PROF dir and ProfileFileChunk before start flush data
 * @param [in] fileChunkReq: ProfileFileChunk message
 * @param [in] storageDir: absolute dir to flush data
 * @return: PROFILING_SUCCESS
            PROFILING_FAILED
 */
int32_t FileSlice::CheckDirAndMessage(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq,
    const std::string &storageDir) const
{
    if (fileChunkReq == nullptr) {
        MSPROF_LOGE("para err!");
        return PROFILING_FAILED;
    }
    if (fileChunkReq->isLastChunk && fileChunkReq->chunkSize == 0) {
        return PROFILING_SUCCESS;
    }

    if (fileChunkReq->fileName.length() == 0 || (!(fileChunkReq->isLastChunk) && fileChunkReq->chunkSize == 0)) {
        MSPROF_LOGE("para err! filename.length:%d, chunksizeinbytes:%d",
            fileChunkReq->fileName.length(), fileChunkReq->chunkSize);

        return PROFILING_FAILED;
    }

    std::string dir = Utils::DirName(storageDir + fileChunkReq->fileName);
    if (dir.empty()) {
        MSPROF_LOGE("Failed to get dirname of filechunk, storageDir: %s", storageDir.c_str());
        return PROFILING_FAILED;
    }
    if (Utils::CreateDir(dir) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create dir %s for writing file", Utils::BaseName(dir).c_str());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t FileSlice::WriteCtrlDataToFile(const std::string &absolutePath, const std::string &data, int32_t dataLen)
{
    std::ofstream file;
    std::unique_lock<std::mutex> lk(sliceFileMtx_);

    if (Utils::IsFileExist(absolutePath)) {
        MSPROF_LOGI("file exist: %s", Utils::BaseName(absolutePath).c_str());
        return PROFILING_SUCCESS;
    }

    if (data.empty() || dataLen <= 0 || dataLen > MSVP_SMALL_FILE_MAX_LEN) {
        MSPROF_LOGE("Invalid ctrl data length");
        return PROFILING_FAILED;
    }
    file.open(absolutePath, std::ios::out | std::ios::trunc | std::ios::binary);
    if (!file.is_open()) {
        MSPROF_LOGE("Failed to open %s", Utils::BaseName(absolutePath).c_str());
        return PROFILING_FAILED;
    }
    file.write(data.c_str(), dataLen);
    file.flush();
    file.close();

    if (!(CreateDoneFile(absolutePath, std::to_string(dataLen), "", "", ""))) {
        MSPROF_LOGE("set device done file failed");
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

/**
 * @brief Final check and judging progress to flush data to local files
 * @param [in] fileChunkReq: ProfileFileChunk message
 * @param [in] storageDir: absolute dir to flush data
 * @return: PROFILING_SUCCESS
            PROFILING_FAILED
 */
int32_t FileSlice::SaveDataToLocalFiles(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq,
    const std::string &storageDir)
{
    int32_t ret = PROFILING_FAILED;
    if (fileChunkReq == nullptr) {
        MSPROF_LOGE("failed to cast to FileTrunkReq");
        return ret;
    }

    std::string fileName = fileChunkReq->fileName;
    std::string devId = Utils::GetInfoSuffix(fileChunkReq->extraInfo);
    if (CheckDirAndMessage(fileChunkReq, storageDir) == PROFILING_FAILED) {
        return PROFILING_FAILED;
    }

    if (fileChunkReq->chunkSize == 0 && fileChunkReq->isLastChunk) {
        return FileSliceFlushByJobID(storageDir + fileName, devId);
    }
    if (fileChunkReq->chunkModule == FileChunkDataModule::PROFILING_IS_CTRL_DATA) {
        return WriteCtrlDataToFile(storageDir + fileName,
                                   fileChunkReq->chunk, fileChunkReq->chunkSize);
    }

    std::unique_lock<std::mutex> lk(sliceFileMtx_);
    std::string key = GetSliceKey(storageDir, fileName);
    if (key.length() == 0) {
        MSPROF_LOGE("get key err");
        return PROFILING_FAILED;
    }
    if (fileChunkReq->chunkSize > 0 && fileChunkReq->chunk.c_str() != nullptr) {
        ret = SetChunkTime(key, 0, 0);
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to set chunk time");
            return PROFILING_FAILED;
        }
    }
    if (fileChunkReq->chunkModule == FileChunkDataModule::PROFILING_IS_FROM_MSPROF_HOST) {
        const int64_t fileSize = Utils::GetFileSize(key);
        if (fileSize >= 0) {
            fileChunkReq->offset = fileSize;
        }
    }
    ret = WriteToLocalFiles(key, fileChunkReq->chunk.c_str(), fileChunkReq->chunkSize,
        fileChunkReq->offset, fileChunkReq->isLastChunk, fileChunkReq->fileName);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to write local files, fileName: %s", Utils::BaseName(fileName).c_str());
        return PROFILING_FAILED;
    }

    return PROFILING_SUCCESS;
}

bool FileSlice::CreateDoneFile(const std::string &absolutePath, const std::string &fileSize,
    const std::string &startTime, const std::string &endTime, const std::string &timeKey)
{
    if (!needSlice_) {
        return true;
    }
    std::string tempPath = absolutePath + ".done";
    std::ofstream file;
    file.open(tempPath);
    if (!file.is_open()) {
        const int32_t errorNo = OsalGetErrorCode();
        char errBuf[MAX_ERR_STRING_LEN + 1] = {0};
        MSPROF_LOGE("Failed to open %s, ErrorCode:%d, errinfo:%s", Utils::BaseName(tempPath).c_str(), errorNo,
                    OsalGetErrorFormatMessage(errorNo, errBuf, MAX_ERR_STRING_LEN));
        return false;
    }
    file << "filesize:" << fileSize << std::endl;
    if (!timeKey.empty()) {
        file << "starttime:" << startTime << std::endl;
        file << "endtime  :" << endTime << std::endl;
    }
    file.flush();
    file.close();
    const int64_t doneFileSize = Utils::GetFileSize(tempPath);
    fileAgeing_->AppendAgeingFile(absolutePath, tempPath, stoull(fileSize), static_cast<uint64_t>(doneFileSize));
    if (fileAgeing_->IsNeedAgeingFile()) {
        fileAgeing_->RemoveAgeingFile();
    }

    // when gen .done file, erase related key in chunkStartTime_ & chunkEndTime_ map
    auto iter = chunkStartTime_.find(timeKey);
    if (iter != chunkStartTime_.end()) {
        chunkStartTime_.erase(timeKey);
        MSPROF_LOGD("erase key (%s) in chunkStartTime map", Utils::BaseName(timeKey).c_str());
    }
    iter = chunkEndTime_.find(timeKey);
    if (iter != chunkEndTime_.end()) {
        chunkEndTime_.erase(timeKey);
        MSPROF_LOGD("erase key (%s) in chunkEndTime map", Utils::BaseName(timeKey).c_str());
    }
    return true;
}

bool FileSlice::FileSliceFlush()
{
    if (!needSlice_) {
        return true;
    }
    std::map<std::string, uint64_t>::iterator it;
    std::unique_lock<std::mutex> lk(sliceFileMtx_);
    for (it = sliceNum_.begin(); it != sliceNum_.end(); ++it) {
        const std::string absolutePath = it->first + std::to_string(it->second);
        if (Utils::IsFileExist(absolutePath)) {
            MSPROF_EVENT("[FileSliceFlush]file:%s, total_size_file:%" PRIu64" bytes",
                        Utils::BaseName(it->first).c_str(), totalSize_[it->first]);
            int64_t fileSize = Utils::GetFileSize(absolutePath);
            if (fileSize < 0) {
                MSPROF_LOGE("[fileSize:%d error", fileSize);
            }
            if (!(CreateDoneFile(absolutePath, std::to_string(fileSize), std::to_string(chunkStartTime_[absolutePath]),
                std::to_string(chunkEndTime_[absolutePath]), absolutePath))) {
                MSPROF_LOGE("[FileSliceFlush]Failed to create file:%s", Utils::BaseName(absolutePath).c_str());
                return false;
            }
            MSPROF_LOGI("[FileSliceFlush]create done file:%s.done", Utils::BaseName(absolutePath).c_str());
            sliceNum_[it->first]++;
        }
    }

    static bool perfPrint = false;
    if (!perfPrint) {
        writeFilePerfCount_->OutPerfInfo("FileSliceFlush");
        perfPrint = true;
    }
    return true;
}

int32_t FileSlice::FileSliceFlushByJobID(const std::string &jobIDRelative, const std::string &devID)
{
    if (!needSlice_) {
        return PROFILING_SUCCESS;
    }
    std::map<std::string, uint64_t>::iterator it;
    std::string fileSliceName = "";

    MSPROF_LOGI("[FileSliceFlushByJobID]jobIDRelativePath:%s, devID:%s",
                Utils::BaseName(jobIDRelative).c_str(), devID.c_str());
    fileSliceName.append(".").append(devID).append(".slice_");
    std::unique_lock<std::mutex> lk(sliceFileMtx_);
    for (it = sliceNum_.begin(); it != sliceNum_.end(); ++it) {
        if (it->first.find(fileSliceName) == std::string::npos ||
            it->first.find(jobIDRelative) == std::string::npos) {
            continue;
        }
        std::string absolutePath = it->first + std::to_string(it->second);
        MSPROF_EVENT("[FileSliceFlushByJobID]file:%s, total_size_file:%" PRIu64,
                    Utils::BaseName(it->first).c_str(), totalSize_[it->first]);
        if (Utils::IsFileExist(absolutePath)) {
            MSPROF_LOGI("[FileSliceFlushByJobID]create done file for:%s", Utils::BaseName(absolutePath).c_str());
            const int64_t fileSize = Utils::GetFileSize(absolutePath);
            if (fileSize < 0) {
                MSPROF_LOGE("[fileSize:%d error", fileSize);
            }
            if (!(CreateDoneFile(absolutePath, std::to_string(fileSize), std::to_string(chunkStartTime_[absolutePath]),
                std::to_string(chunkEndTime_[absolutePath]), absolutePath))) {
                MSPROF_LOGE("[FileSliceFlushByJobID]Failed to create file:%s", Utils::BaseName(absolutePath).c_str());
                return PROFILING_FAILED;
            }
            MSPROF_LOGI("[FileSliceFlushByJobID]create done file:%s.done", Utils::BaseName(absolutePath).c_str());
            sliceNum_[it->first]++;
        }
    }

    return PROFILING_SUCCESS;
}
}
}
}
