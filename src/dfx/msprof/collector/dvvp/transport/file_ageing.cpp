/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "file_ageing.h"
#include <cstdio>
#include <cstring>
#include <sys/types.h>
#include "config/config.h"
#include "config_manager.h"
#include "logger/msprof_dlog.h"
#include "utils/utils.h"

namespace analysis {
namespace dvvp {
namespace transport {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Common::Config;
constexpr uint64_t MOVE_BIT = 20;
constexpr uint64_t STORAGE_RESERVED_VOLUME = (STORAGE_LIMIT_DOWN_THD / 10) << MOVE_BIT;

FileAgeing::FileAgeing(const std::string &storageDir, const std::string &storageLimit)
    : inited_(false), overThdSize_(0), storagedFileSize_(0), storageVolumeUpThd_(0),
      storageVolumeDownThd_(0), storageDir_(storageDir), storageLimit_(storageLimit)
{
}

FileAgeing::~FileAgeing()
{
}

void FileAgeing::InitAgeingParams(uint64_t limit)
{
    storageVolumeUpThd_ = limit - STORAGE_RESERVED_VOLUME;
    storageVolumeDownThd_ = STORAGE_RESERVED_VOLUME;
    MSPROF_LOGI("init storage_limit success, limit:%" PRIu64 " (%lluMB), storageVolumeUpThd_:%" PRIu64 " (%lluMB), "
                "storageVolumeDownThd_:%" PRIu64 " (%lluMB)",
                limit, (limit >> MOVE_BIT),
                storageVolumeUpThd_, (storageVolumeUpThd_ >> MOVE_BIT),
                storageVolumeDownThd_, (storageVolumeDownThd_ >> MOVE_BIT));

    overThdSize_ = 0;
    storagedFileSize_ = 0;
    unPairCount_[HWTS_DATA] = 0;
    unPairCount_[AICORE_DATA] = 0;
    noAgeingFile_ = {std::string("model_load_info"), std::string("task_desc_info"), std::string("id_map_info"),
                     std::string("fusion_op_info"), std::string("tensor_data_info"),
                     std::string("step_info"), std::string("training_trace"), std::string("info.json"),
                     std::string("hash_dic"), std::string("start_info"), std::string("end_info"),
                     std::string("host_start"), std::string("dev_start"), std::string("sample.json"),
                     std::string("unaging")};
    inited_ = true;
}

uint64_t FileAgeing::GetStorageLimit() const
{
    if (storageLimit_.empty()) {
        return 0;
    }
    const size_t strLen = storageLimit_.size();
    if (strLen <= strlen(STORAGE_LIMIT_UNIT)) {
        return 0;
    }
    std::string digitStr = storageLimit_.substr(0, strLen - strlen(STORAGE_LIMIT_UNIT));
    const uint64_t limit = (stoull(digitStr) >> 1);
    return (limit << MOVE_BIT);
}

bool FileAgeing::IsNeedAgeingFile()
{
    if (!inited_) {
        return false;
    }

    if (storagedFileSize_ > storageVolumeUpThd_) {
        overThdSize_ = storagedFileSize_ - storageVolumeUpThd_;
        MSPROF_LOGD("storagedFileSize_:%" PRIu64 ", storageVolumeUpThd_:%" PRIu64 ", overThdSize_:%" PRIu64,
                    storagedFileSize_, storageVolumeUpThd_, overThdSize_);
        return true;
    }

    unsigned long long dirFreeSize = 0;
    if (Utils::GetVolumeSize(storageDir_, dirFreeSize, VolumeSize::FREE_SIZE) == PROFILING_FAILED) {
        MSPROF_LOGE("GetFreeVolume failed");
        return false;
    }
    if (dirFreeSize < storageVolumeDownThd_) {
        overThdSize_ = storageVolumeDownThd_ - dirFreeSize;
        MSPROF_LOGD("storageVolumeUpThd_:%" PRIu64 ", storageVolumeDownThd_:%" PRIu64 ", dirFreeSize:%" PRIu64
            ", overThdSize_:%" PRIu64, storageVolumeUpThd_, storageVolumeDownThd_, dirFreeSize, overThdSize_);
        return true;
    }
    return false;
}

bool FileAgeing::IsNoAgeingFile(const std::string &fileName) const
{
    for (auto iter = noAgeingFile_.begin(); iter != noAgeingFile_.end(); ++iter) {
        if (fileName.find(*iter) != std::string::npos) {
            return true;
        }
    }
    return false;
}

int32_t FileAgeing::CutSliceNum(const std::string &fileName, std::string &cutFileName) const
{
    const std::string::size_type pos = fileName.find_last_of('.');
    if (pos == std::string::npos) {
        MSPROF_LOGE("fileName:%s invalid", Utils::BaseName(fileName).c_str());
        return PROFILING_FAILED;
    }
    cutFileName = fileName.substr(0, pos);
    return PROFILING_SUCCESS;
}

void FileAgeing::PairInsertList(const std::string &pairedFileTag, ToBeAgedFile &insertedFile)
{
    uint32_t rInd = 0;
    uint32_t insertPos = 0;

    if (unPairCount_[pairedFileTag] > 0) {
        for (auto iter = ageingFileList_.begin(); iter != ageingFileList_.end(); ++iter) {
            if (!iter->isValid) {
                *iter = insertedFile;
                iter->isNeedPair = true;
                iter->isPaired = true;
                unPairCount_[pairedFileTag] -= 1;
                return;
            }
        }
        MSPROF_LOGE("not find ToBeAgedFile struct, unPairCount_[%s]:%u",
                    pairedFileTag.c_str(), unPairCount_[pairedFileTag]);
        PrintAgeingFile();
    }

    for (auto rIter = ageingFileList_.rbegin(); rIter != ageingFileList_.rend(); ++rIter, ++rInd) {
        if (rIter->fileName.find(pairedFileTag) != std::string::npos) {
            if (!rIter->isPaired) {
                insertPos = ageingFileList_.size() - rInd;
            } else {
                break;
            }
        }
    }
    if (insertPos == 0) {
        ageingFileList_.push_back(insertedFile);
    } else {
        auto iter = begin(ageingFileList_);
        advance(iter, insertPos - 1);
        iter->isPaired = true;
        insertedFile.isPaired = true;
        ++iter;
        ageingFileList_.insert(iter, insertedFile);
    }
}

void FileAgeing::AppendAgeingFile(const std::string &filePath, const std::string &doneFilePath,
                                  uint64_t fileSize, uint64_t doneFileSize)
{
    if (!inited_) {
        return;
    }

    MSPROF_LOGD("Try append ageing file. filePath:%s doneFilePath:%s",
                Utils::BaseName(filePath).c_str(), Utils::BaseName(doneFilePath).c_str());
    constexpr uint64_t maxStoragedFileSize = static_cast<uint64_t>(1) << 50; // (2^50)Byte = 1024T
    if (storagedFileSize_ >= maxStoragedFileSize) {
        MSPROF_LOGE("storagedFileSize_:%" PRIu64 " is over normal range", storagedFileSize_);
        return;
    }
    if (filePath.empty() || doneFilePath.empty()) {
        MSPROF_LOGE("filePath:%s, doneFilePath:%s, file path invalid",
                    Utils::BaseName(filePath).c_str(), Utils::BaseName(doneFilePath).c_str());
        return;
    }

    std::string fileName = Utils::BaseName(filePath);
    std::string doneFileName = Utils::BaseName(doneFilePath);
    if (IsNoAgeingFile(fileName)) {
        storagedFileSize_ += fileSize + doneFileSize;
        MSPROF_LOGD("%s can not be ageing", Utils::BaseName(filePath).c_str());
        return;
    }

    std::string cutSliceNumName;
    if (CutSliceNum(fileName, cutSliceNumName) == PROFILING_FAILED) {
        MSPROF_LOGE("CutSliceNum failed, fileName:%s", Utils::BaseName(fileName).c_str());
        return;
    }
    ToBeAgedFile file = {true, false, false, fileSize, doneFileSize, fileName, doneFileName,
                         filePath, doneFilePath, cutSliceNumName, ""};

    const auto iter = fileCount_.find(cutSliceNumName);
    if (iter == fileCount_.end()) {
        fileCount_[cutSliceNumName] = 1;
    } else {
        fileCount_[cutSliceNumName] += 1;
    }

    if (fileName.find(AICORE_DATA) != std::string::npos) {
        file.isNeedPair = true;
        file.pairFileTag = AICORE_DATA;
        PairInsertList(HWTS_DATA, file);
    } else if (fileName.find(HWTS_DATA) != std::string::npos) {
        file.isNeedPair = true;
        file.pairFileTag = HWTS_DATA;
        PairInsertList(AICORE_DATA, file);
    } else {
        ageingFileList_.push_back(file);
    }
    storagedFileSize_ += fileSize + doneFileSize;
}

bool FileAgeing::IsLastFile(const std::string &fileCountTag)
{
    if (fileCount_.find(fileCountTag) == fileCount_.end()) {
        MSPROF_LOGE("file:%s not find in fileCount_", fileCountTag.c_str());
        return true;
    }
    if (fileCount_[fileCountTag] <= 1) {
        MSPROF_LOGD("file:%s is last file", fileCountTag.c_str());
        return true;
    }
    return false;
}

void FileAgeing::RemoveFile(const ToBeAgedFile &file, uint64_t &removeFileSize)
{
    if (remove(file.filePath.c_str()) != EOK) {
        MSPROF_LOGE("remove file:%s failed", Utils::BaseName(file.filePath).c_str());
    } else {
        removeFileSize += file.fileSize;
    }
    if (remove(file.doneFilePath.c_str()) != EOK) {
        MSPROF_LOGE("remove file:%s failed", Utils::BaseName(file.doneFilePath).c_str());
    } else {
        removeFileSize += file.doneFizeSize;
    }
    fileCount_[file.fileCountTag] -= 1;
    MSPROF_LOGD("remove fileName:%s, filePath:%s, fileCount_[%s]:%u",
                file.fileName.c_str(), Utils::BaseName(file.filePath).c_str(),
                file.fileCountTag.c_str(), fileCount_[file.fileCountTag]);
}

void FileAgeing::RemoveAgeingFile()
{
    uint64_t removeFileSize = 0;

    MSPROF_LOGD("RemoveAgeingFile begin, storagedFileSize:%" PRIu64 " overThdSize:%" PRIu64 ", ageingFileList.size:%zu",
                storagedFileSize_, overThdSize_, ageingFileList_.size());
    for (auto iter = ageingFileList_.begin(); iter != ageingFileList_.end();) {
        if (!iter->isValid || IsLastFile(iter->fileCountTag)) {
            ++iter;
            continue;
        }

        RemoveFile(*iter, removeFileSize);
        if (iter->isNeedPair && !iter->isPaired) {
            unPairCount_[iter->pairFileTag] += 1;
            iter->isValid = false;
            ++iter;
        } else {
            iter = ageingFileList_.erase(iter);
        }

        if (removeFileSize >= overThdSize_) {
            if (removeFileSize > storagedFileSize_) {
                MSPROF_LOGE("removeFileSize error, removeFileSize:%" PRIu64 ", storagedFileSize_:%" PRIu64,
                            removeFileSize, storagedFileSize_);
                PrintAgeingFile();
                storagedFileSize_ = 0;
            } else {
                storagedFileSize_ -= removeFileSize;
            }
            overThdSize_ = 0;
            break;
        }
    }
    MSPROF_LOGD("RemoveAgeingFile end, storagedFileSize:%" PRIu64 " overThdSize:%" PRIu64 ", "
                "ageingFileList.size:%zu, removeFileSize:%" PRIu64,
                storagedFileSize_, overThdSize_, ageingFileList_.size(), removeFileSize);
}

void FileAgeing::PrintAgeingFile() const
{
    MSPROF_LOGD("print ageing file list: ");
    for (auto iter = ageingFileList_.begin(); iter != ageingFileList_.end(); ++iter) {
        MSPROF_LOGD("isValid:%u, isNeedPair:%u, isPaired:%u, filePath:%s, fileSize:%" PRIu64,
                    iter->isValid, iter->isNeedPair, iter->isPaired,
                    Utils::BaseName(iter->filePath).c_str(), iter->fileSize);
    }
}
}
}
}