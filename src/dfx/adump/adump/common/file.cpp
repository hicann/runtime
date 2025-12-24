/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "file.h"
#include "path.h"
#include "adump_pub.h"
#include "log/adx_log.h"
#include "extra_config.h"

namespace Adx {
namespace {
constexpr int32_t INVALID_FILE_FD = -1;
constexpr mmMode_t READ_WRITE_MODE = M_IRUSR | M_IWUSR;
constexpr int64_t MAX_BUFFER_LENGTH = 512;
static const std::string MAPPING_FILE_NAME = "mapping.csv";
}  // namespace

File::File(const std::string &path, int32_t flag, mmMode_t mode) : filePath_(path), fd_(INVALID_FILE_FD)
{
    if (Open(flag, mode) != ADUMP_SUCCESS) {
        fd_ = INVALID_FILE_FD;
    }
}

File::~File()
{
    (void)Close();
}

int32_t File::Open(int32_t flag, mmMode_t mode)
{
    Path filePath(filePath_);
    std::string fileName = filePath.GetFileName();
    Path parentPath = filePath.ParentPath();
    if (!parentPath.Empty() && !parentPath.RealPath()) {
        IDE_LOGE("Real file path failed, file: %s", filePath_.c_str());
        return ADUMP_FAILED;
    }

    std::string realFilePath = parentPath.Concat(fileName).GetString();
    fd_ = mmOpen2(realFilePath.c_str(), flag, mode);
    if (fd_ >= 0) {
        return ADUMP_SUCCESS;
    }
    if (mmGetErrorCode() != ENAMETOOLONG) {
        IDE_LOGE("Open file failed. file: %s, fd: %d, message: %s", realFilePath.c_str(), fd_, strerror(errno));
        return ADUMP_FAILED;
    }
    parentPath = filePath.ParentPath();
    if (!parentPath.Empty() && !parentPath.RealPath()) {
        IDE_LOGE("Real long name file path failed, file: %s", filePath_.c_str());
        return ADUMP_FAILED;
    }
    std::string hashName = std::to_string(std::hash<std::string>{}(fileName));
    if (AddMapping(parentPath.GetString(), fileName, hashName) != ADUMP_SUCCESS) {
        IDE_LOGE("Add mapping item [ %s ] failed", hashName.c_str());
    }
    realFilePath = parentPath.Concat(hashName).GetString();
    IDE_LOGW("File name [ %s ] too long rename as [ %s ] and the mapping record in %s",
        fileName.c_str(), realFilePath.c_str(), MAPPING_FILE_NAME.c_str());
    fd_ = mmOpen2(realFilePath.c_str(), O_APPEND | M_RDWR | M_CREAT, M_IREAD | M_IWRITE);
    IDE_CTRL_VALUE_FAILED(fd_ >= 0, return ADUMP_FAILED, "Open hash file failed, fd: %d", fd_);
    return ADUMP_SUCCESS;
}

int32_t File::GetFileDiscriptor() const
{
    return fd_;
}

int32_t File::IsFileOpen() const
{
    if (fd_ == INVALID_FILE_FD) {
        return ADUMP_FAILED;
    }
    return ADUMP_SUCCESS;
}

int32_t File::Close()
{
    if (fd_ == INVALID_FILE_FD) {
        return ADUMP_SUCCESS;
    }

    const int32_t ret = mmClose(fd_);
    if (ret != EN_OK) {
        IDE_LOGW("Can not close file handle, file: %s, ret: %d.", filePath_.c_str(), ret);
        return ADUMP_FAILED;
    }
    fd_ = INVALID_FILE_FD;
    return ADUMP_SUCCESS;
}

int64_t File::Write(const char *const buffer, int64_t length) const
{
    mmSsize_t ret = 0;
    UINT32 reserve = static_cast<UINT32>(length);
    do {
        ret = mmWrite(fd_, const_cast<char *>(buffer) + (static_cast<UINT32>(length) - reserve), reserve);
        if ((ret == EN_ERROR) && (mmGetErrorCode() == EINTR)) {
            continue;
        }
        if (ret < 0 || static_cast<UINT32>(ret) > reserve) {
            IDE_LOGE("Write data failed, buff: %p, length: %ld, ret: %zd", buffer, length, ret);
            break;
        }
        reserve -= ret;
        if (reserve == 0) {
            break;
        }
    } while (true);

    return static_cast<int64_t>(ret);
}

int64_t File::Read(char *buffer, int64_t length) const
{
    mmSsize_t ret;
    do {
        ret = mmRead(fd_, buffer, static_cast<UINT32>(length));
    } while (ret == EN_ERROR && mmGetErrorCode() == EINTR);

    if (ret == EN_ERROR) {
        IDE_LOGE("Read data failed, buff: %p, length: %ld bytes, ret: %zd", buffer, length, ret);
    }
    return static_cast<int64_t>(ret);
}

int32_t File::Copy(const std::string &srcPath, const std::string &dstPath)
{
    IDE_LOGI("copy file from %s to %s", srcPath.c_str(), dstPath.c_str());
    File srcFile(srcPath, M_RDONLY);
    int32_t ret = srcFile.IsFileOpen();
    if (ret != ADUMP_SUCCESS) {
        IDE_LOGE("Open src file failed, file: %s", srcPath.c_str());
        return ret;
    }

    File dstFile(dstPath, M_CREAT | M_WRONLY | M_TRUNC, READ_WRITE_MODE);
    ret = dstFile.IsFileOpen();
    if (ret != ADUMP_SUCCESS) {
        IDE_LOGE("Open dst file failed, file: %s", dstPath.c_str());
        return ret;
    }

    char buffer[MAX_BUFFER_LENGTH] = { 0 };
    int64_t size = 0;
    do {
        size = srcFile.Read(buffer, MAX_BUFFER_LENGTH);
        if (size < 0) {
            IDE_LOGE("Read file failed, file: %s", srcPath.c_str());
            return ADUMP_FAILED;
        }
        IDE_LOGD("Read file size: %ld bytes", size);
        if (size > 0) {
            const auto writeSize = dstFile.Write(buffer, size);
            if (writeSize < 0) {
                IDE_LOGE("Write file failed, file: %s", dstPath.c_str());
                return ADUMP_FAILED;
            }
        }
    } while (size > 0);
    return ADUMP_SUCCESS;
}

 /**
 * @brief       : add map item into mapping.csv
 * @param [in]  : filePath    file path
 * @param [in]  : hashName    hash value of file name
 * @return      : ADUMP_SUCCESS: success; ADUMP_FAILED: failed
 */
int32_t File::AddMapping(const std::string &filePath, const std::string &fileName, const std::string &hashName)
{
    IDE_CTRL_VALUE_FAILED(!filePath.empty(), return ADUMP_FAILED, "FilePath is empty");
    IDE_CTRL_VALUE_FAILED(!hashName.empty(), return ADUMP_FAILED, "HashName is empty");

    Path parentPath(filePath);
    std::string mappingFile = parentPath.Concat('/' + MAPPING_FILE_NAME).GetString();
    fd_ = mmOpen2(mappingFile.c_str(), O_APPEND | M_RDWR | M_CREAT, M_IRUSR | M_IWRITE);
    IDE_CTRL_VALUE_FAILED(fd_ >= 0, return ADUMP_FAILED, "Open mapping file failed, fd: %d", fd_);

    std::string mapping = hashName + ',' + fileName + '\n';
    uint32_t mappingLen = mapping.length();
    uint32_t residLen = mappingLen;

    do {
        mmSsize_t writeLen = mmWrite(fd_, const_cast<AdxStringBuffer>(mapping.c_str()) + (mappingLen - residLen),
            residLen);
        if (writeLen < 0) {
            IDE_LOGE("Write failed, info: %s, write length: %ld bytes", strerror(errno), writeLen);
            (void)Close();
            return ADUMP_FAILED;
        }
        if (residLen >= static_cast<uint32_t>(writeLen)) {
            residLen -= static_cast<uint32_t>(writeLen);
        } else {
            IDE_LOGE("Write failed, info: %s, write length larger than resid length", strerror(errno));
            (void)Close();
            return ADUMP_FAILED;
        }
    } while (residLen != 0);

    (void)Close();
    return ADUMP_SUCCESS;
}
}  // namespace Adx