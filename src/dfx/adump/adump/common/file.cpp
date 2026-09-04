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
#include <cinttypes>
#include "path.h"
#include "adump_pub.h"
#include "log/adx_log.h"
#include "extra_config.h"

namespace Adx {
namespace {
constexpr int32_t INVALID_FILE_FD = -1;
constexpr mmMode_t READ_WRITE_MODE = M_IRUSR | M_IWUSR;
constexpr int64_t MAX_BUFFER_LENGTH = 512;
// 单次处理1GB
constexpr int64_t MAX_IO_CHUNK_SIZE = 1LL << 30;
static const std::string MAPPING_FILE_NAME = "mapping.csv";
} // namespace

File::File(const std::string& path, int32_t flag, mmMode_t mode, bool lazyOpen)
    : filePath_(path), fd_(INVALID_FILE_FD), flag_(flag), mode_(mode)
{
    if (lazyOpen) {
        return;
    }
    if (Open(flag, mode) != ADUMP_SUCCESS) {
        fd_ = INVALID_FILE_FD;
    }
}

int32_t File::EnsureOpen()
{
    if (fd_ != INVALID_FILE_FD) {
        return ADUMP_SUCCESS;
    }
    if (Open(flag_, mode_) != ADUMP_SUCCESS) {
        fd_ = INVALID_FILE_FD;
        return ADUMP_FAILED;
    }
    return ADUMP_SUCCESS;
}

File::~File() { (void)Close(); }

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
    IDE_LOGW(
        "File name [ %s ] too long rename as [ %s ] and the mapping record in %s", fileName.c_str(),
        realFilePath.c_str(), MAPPING_FILE_NAME.c_str());
    fd_ = mmOpen2(realFilePath.c_str(), O_APPEND | M_RDWR | M_CREAT, M_IREAD | M_IWRITE);
    IDE_CTRL_VALUE_FAILED(fd_ >= 0, return ADUMP_FAILED, "Open hash file failed, fd: %d", fd_);
    return ADUMP_SUCCESS;
}

int32_t File::GetFileDiscriptor() const { return fd_; }

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

int64_t File::Write(const char* const buffer, int64_t length) const
{
    if (length < 0 || (length > 0 && buffer == nullptr)) {
        IDE_LOGE("Write data failed, invalid buffer or length: buffer=%p, length=%" PRId64, buffer, length);
        return static_cast<int64_t>(EN_INVALID_PARAM);
    }
    int64_t written = 0;
    while (written < length) {
        const int64_t remain = length - written;
        const UINT32 chunk = static_cast<UINT32>((remain > MAX_IO_CHUNK_SIZE) ? MAX_IO_CHUNK_SIZE : remain);
        const mmSsize_t ret = mmWrite(fd_, const_cast<char*>(buffer) + written, chunk);
        if ((ret == EN_ERROR) && (mmGetErrorCode() == EINTR)) {
            continue;
        }
        // ret == 0 表示无法继续推进(继续循环会死循环)，ret > chunk 表示底层返回值异常，均按失败处理；
        // 统一返回负错误码，避免调用方的 `ret >= 0` 判断把未写完当成成功。
        // 打印 errno 便于区分磁盘满等根因(mmWrite 返回 0 时不带错误码)。
        if ((ret == 0) || (static_cast<int64_t>(ret) > static_cast<int64_t>(chunk))) {
            IDE_LOGE(
                "Write data failed, buff: %p, length: %" PRId64 ", written: %" PRId64 ", ret: %zd, errno: %d", buffer,
                length, written, ret, mmGetErrorCode());
            return static_cast<int64_t>(EN_ERROR);
        }
        if (ret < 0) {
            IDE_LOGE(
                "Write data failed, buff: %p, length: %" PRId64 ", written: %" PRId64 ", ret: %zd", buffer, length,
                written, ret);
            return static_cast<int64_t>(ret);
        }
        written += static_cast<int64_t>(ret);
    }
    return written;
}

int64_t File::Read(char* buffer, int64_t length) const
{
    if (length < 0) {
        IDE_LOGE("Read data failed, invalid length: %" PRId64, length);
        return static_cast<int64_t>(EN_INVALID_PARAM);
    }
    int64_t read = 0;
    while (read < length) {
        const int64_t remain = length - read;
        const UINT32 chunk = static_cast<UINT32>((remain > MAX_IO_CHUNK_SIZE) ? MAX_IO_CHUNK_SIZE : remain);
        const mmSsize_t ret = mmRead(fd_, buffer + read, chunk);
        if ((ret == EN_ERROR) && (mmGetErrorCode() == EINTR)) {
            continue;
        }
        if (ret < 0) {
            IDE_LOGE(
                "Read data failed, buff: %p, length: %" PRId64 " bytes, read: %" PRId64 ", ret: %zd", buffer, length,
                read, ret);
            return static_cast<int64_t>(ret);
        }
        if (ret == 0) {
            break;
        }
        read += static_cast<int64_t>(ret);
    }
    return read;
}

int32_t File::Copy(const std::string& srcPath, const std::string& dstPath)
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

    char buffer[MAX_BUFFER_LENGTH] = {0};
    int64_t size = 0;
    do {
        size = srcFile.Read(buffer, MAX_BUFFER_LENGTH);
        if (size < 0) {
            IDE_LOGE("Read file failed, file: %s", srcPath.c_str());
            return ADUMP_FAILED;
        }
        IDE_LOGD("Read file size: %" PRId64 " bytes", size);
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
int32_t File::AddMapping(const std::string& filePath, const std::string& fileName, const std::string& hashName)
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
        mmSsize_t writeLen =
            mmWrite(fd_, const_cast<AdxStringBuffer>(mapping.c_str()) + (mappingLen - residLen), residLen);
        // writeLen 为 0 时 residLen -= 0 恒不变，循环无法推进会死循环，故并入失败分支
        if (writeLen <= 0) {
            IDE_LOGE(
                "Write failed, info: %s, write length: %zd bytes, errno: %d", strerror(errno), writeLen,
                mmGetErrorCode());
            (void)Close();
            return ADUMP_FAILED;
        }
        if (residLen >= static_cast<uint32_t>(writeLen)) {
            residLen -= static_cast<uint32_t>(writeLen);
        } else {
            IDE_LOGE("Write failed, info: %s, write length larger than remaining length", strerror(errno));
            (void)Close();
            return ADUMP_FAILED;
        }
    } while (residLen != 0);

    (void)Close();
    return ADUMP_SUCCESS;
}
} // namespace Adx
