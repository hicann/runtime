/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "sender.h"
#include "config/config.h"
#include "errno/error_code.h"
#include "message/codec.h"
#include "message/prof_params.h"
#include "securec.h"

#include "proto/profiler.pb.h"

using namespace analysis::dvvp::proto;

namespace analysis {
namespace dvvp {
namespace streamio {
namespace client {
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::config;

Sender::Sender(SHARED_PTR_ALIA<ITransport> transport, const std::string &engineName,
               SHARED_PTR_ALIA<analysis::dvvp::common::memory::ChunkPool> chunkPool)
    : transport_(transport),
      engineName_(engineName), chunkPool_(chunkPool),
      isInited_(false), isFinished_(true)
{
    hashId_ = std::hash<std::string>()(engineName_);
}

Sender::~Sender()
{
    if (isInited_) {
        fileMap_.clear();
        fileMutexMap_.clear();
        WaitEmpty();
        CloseFileFds();

        isInited_ = false;
    }
}

int32_t Sender::Init()
{
    int32_t ret = PROFILING_FAILED;

    MSPROF_LOGI("sender Init.");
    do {
        MSVP_MAKE_SHARED1_NODO(fileQueue_, FileQueue, MSVP_CLN_SENDER_QUEUE_CAPCITY, break);
        fileQueue_->SetQueueName("Sender");
        fileFdMap_.clear();
        fileMap_.clear();
        fileMutexMap_.clear();

        ret = PROFILING_SUCCESS;
        isInited_ = true;
    } while (0);

    MSPROF_LOGI("sender Init success.");

    return ret;
}

void Sender::Uninit()
{
    if (isInited_) {
        MSPROF_LOGI("[%s]sender Uninit begin.", engineName_.c_str());
        FlushFileCache();
        WaitEmpty();
        CloseFileFds();

        isInited_ = false;
        MSPROF_LOGI("[%s]sender Uninit end.", engineName_.c_str());
    }
}

void Sender::FlushFileCache()
{
    std::lock_guard<std::mutex> lk(fileMapLock_);

    for (auto iter = fileMap_.begin(); iter != fileMap_.end(); ++iter) {
        MSPROF_LOGD("FlushFileCache file:%s size:%u", iter->first.c_str(), iter->second->GetChunk()->GetUsedSize());
        DispatchFile(iter->second);
    }
    fileMap_.clear();
    fileMutexMap_.clear();
}

SHARED_PTR_ALIA<std::mutex> Sender::GetMutexByFileName(const std::string &fileName)
{
    std::lock_guard<std::mutex> lk(fileMutexMapLock_);

    auto iter = fileMutexMap_.find(fileName);
    if (iter != fileMutexMap_.end()) {
        return iter->second;
    }

    SHARED_PTR_ALIA<std::mutex> fileNameLock;
    MSVP_MAKE_SHARED0(fileNameLock, std::mutex, return nullptr);
    fileMutexMap_[fileName] = fileNameLock;

    return fileNameLock;
}

void Sender::DispatchFile(SHARED_PTR_ALIA<File> file)
{
    if (file != nullptr) {
        fileQueue_->Push(file);
        isFinished_ = false;
        try {
            SenderPool::instance()->Dispatch(shared_from_this());
        } catch (std::bad_weak_ptr &e) {
            MSPROF_LOGE("DispatchFile error, because shared_from_this return nullptr.");
        }
    }
}

void Sender::WaitEmpty()
{
    const int32_t waitBuffEmptyTimeoutUs = 1000;
    std::unique_lock<std::mutex> lk(cvLock_);
    cv_.wait_for(lk, std::chrono::microseconds(waitBuffEmptyTimeoutUs), [=] { return isFinished_; });
}

SHARED_PTR_ALIA<File> Sender::InitNewCustomFile(const std::string &jobCtxJson,
                                                const std::string &fileName,
                                                const size_t chunkSize) const
{
    SHARED_PTR_ALIA<analysis::dvvp::common::memory::Chunk> chunk = nullptr;
    MSVP_MAKE_SHARED1(chunk, analysis::dvvp::common::memory::Chunk, chunkSize, return nullptr);
    if (!chunk->Init()) {
        MSPROF_LOGE("Failed to Init new custom chunk, fileName:%s", fileName.c_str());
        return nullptr;
    }

    SHARED_PTR_ALIA<File> file = nullptr;
    MSVP_MAKE_SHARED4(file, File, nullptr, chunk, jobCtxJson, fileName, return nullptr);
    if (file->Init() != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to Init new custom fileName:%s.", fileName.c_str());
        return nullptr;
    }

    return file;
}

int32_t Sender::DoSaveFileData(const std::string &fileName, SHARED_PTR_ALIA<File> &file, const struct DataChunk &data)
{
    if (file == nullptr) {
        return PROFILING_SUCCESS;
    }

    auto chunk = file->GetChunk();
    if (data.bufLen != 0) {
        errno_t err = memcpy_s(static_cast<void *>(const_cast<UNSIGNED_CHAR_PTR>(chunk->GetBuffer())),
            chunk->GetFreeSize(), data.dataBuf, data.bufLen);
        if (err != EOK) {
            MSPROF_LOGE("chunk[%s] memcpy_s failed, chunkFreeSize:%u, bufLen:%u, err:%u",
                        fileName.c_str(), chunk->GetFreeSize(), data.bufLen, err);
            return PROFILING_FAILED;
        }
    }
    chunk->SetUsedSize(data.bufLen);
    DispatchFile(file);

    return PROFILING_SUCCESS;
}

int32_t Sender::SaveFileData(const std::string &jobCtxJson, const struct DataChunk &data)
{
    // get file from cache, otherwise create a new file
    std::string fileName = data.relativeFileName;

    SHARED_PTR_ALIA<std::mutex> fileNameLock = GetMutexByFileName(fileName);
    std::lock_guard<std::mutex> lk(*fileNameLock);

    auto file = InitNewCustomFile(jobCtxJson, fileName, data.bufLen);
    if (DoSaveFileData(fileName, file, data) == PROFILING_FAILED) {
        return PROFILING_FAILED;
    }
    if (file == nullptr) {
        return PROFILING_FAILED;
    } else {
        return PROFILING_SUCCESS;
    }
}

void Sender::CloseFileFds()
{
    std::lock_guard<std::mutex> lk(fileFdLock_);

    int32_t ret = OSAL_EN_OK;

    for (auto iter = fileFdMap_.begin(); iter != fileFdMap_.end(); iter++) {
        ret = OsalClose(iter->second);
        if (ret != OSAL_EN_OK) {
            MSPROF_LOGE("Failed to OsalClose ret:%d fd:%d", ret, iter->second);
        }
        fileFdMap_[iter->first] = -1;
    }

    fileFdMap_.clear();
}

int32_t Sender::OpenWriteFile(const std::string &fileName)
{
    const size_t index = fileName.find_last_of(MSVP_SLASH);
    std::string dir = fileName.substr(0, index == std::string::npos ? 0 : index);
    if (analysis::dvvp::common::utils::Utils::CreateDir(dir) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to create dir %s", Utils::BaseName(dir).c_str());
        analysis::dvvp::common::utils::Utils::PrintSysErrorMsg();
        return -1;
    }

    const int32_t fd = OsalOpen(fileName.c_str(), O_WRONLY | O_CREAT, OSAL_IRUSR | OSAL_IWUSR);
    if (fd < 0) {
        MSPROF_LOGE("open file %s failed.", fileName.c_str());
        return fd;
    }

    SetFileFd(fileName, fd);
    MSPROF_LOGI("open file %s success(fd=%d)", fileName.c_str(), fd);

    return fd;
}

int32_t Sender::GetFileFd(const std::string &fileName)
{
    std::lock_guard<std::mutex> lk(fileFdLock_);

    auto iter = fileFdMap_.find(fileName);
    if (iter != fileFdMap_.end()) {
        return iter->second;
    }

    return -1;
}

void Sender::SetFileFd(const std::string &fileName, int32_t fd)
{
    std::lock_guard<std::mutex> lk(fileFdLock_);

    fileFdMap_[fileName] = fd;
}

int32_t Sender::Send(const std::string &jobCtxJson, const struct DataChunk &data)
{
    if (!isInited_) {
        return PROFILING_FAILED;
    }

    return SaveFileData(jobCtxJson, data);
}

void Sender::Flush()
{
    if (isInited_) {
        MSPROF_LOGD("[%s]sender Flush begin.", engineName_.c_str());
        FlushFileCache();
        WaitEmpty();
        CloseFileFds();
        MSPROF_LOGD("[%s]sender Flush end.", engineName_.c_str());
    }
}

int32_t Sender::SendData(CONST_CHAR_PTR buffer, int32_t size)
{
    int32_t sentLen = 0;

    if (buffer != nullptr && size > 0 && transport_ != nullptr) {
        sentLen = transport_->SendBuffer(reinterpret_cast<const void *>(buffer), size);
        if (sentLen != size) {
            MSPROF_LOGE("Failed to SendData, data_len=%d, sent len=%d", size, sentLen);
        } else {
            MSPROF_LOGD("[%s]sended data %d", engineName_.c_str(), size);
        }
    }

    return sentLen;
}

SHARED_PTR_ALIA<std::string> Sender::EncodeData(SHARED_PTR_ALIA<File> file) const
{
    SHARED_PTR_ALIA<FileChunkReq> fileChunk;
    MSVP_MAKE_SHARED0(fileChunk, FileChunkReq, return nullptr);

    if (file != nullptr) {
        auto chunk = file->GetChunk();

        // fill the jobCtxJson
        fileChunk->mutable_hdr()->set_job_ctx(file->GetJobCtx());
        fileChunk->set_filename(file->GetModule());
        fileChunk->set_offset(-1);
        fileChunk->set_chunksizeinbytes(chunk->GetUsedSize());
        fileChunk->set_datamodule(file->GetChunkDataModule());
        fileChunk->set_needack(false);
        if (chunk->GetUsedSize() == 0) {
            fileChunk->set_islastchunk(true);
        } else {
            fileChunk->set_islastchunk(false);
            fileChunk->set_chunk((UNSIGNED_CHAR_PTR)chunk->GetBuffer(), chunk->GetUsedSize());
            fileChunk->set_tag(file->GetTag());
            fileChunk->set_chunkstarttime(file->GetChunkStartTime());
            fileChunk->set_chunkendtime(file->GetChunkEndTime());
        }
    }

    return analysis::dvvp::message::EncodeMessageShared(fileChunk);
}

void Sender::ExecuteStreamMode(SHARED_PTR_ALIA<File> file)
{
    auto encode = EncodeData(file);
    FUNRET_CHECK_EXPR_ACTION(encode == nullptr, return, "[Sender::ExecuteStreamMode] Failed to encode data, "
        "fileName: %s", file->GetFileName().c_str());
    const int32_t currentSize = encode->size();
    MSPROF_LOGD("[Sender::ExecuteStreamMode] fileName = %s", file->GetFileName().c_str());
    const int32_t ret = SendData(encode->c_str(), currentSize);
    if (ret < currentSize) {
        MSPROF_LOGE("[%s] send data size = %u", engineName_.c_str(), ret);
        return;
    }
}

void Sender::ExecuteFileMode(SHARED_PTR_ALIA<File> file)
{
    auto chunk = file->GetChunk();
    auto fileName = file->GetWriteFileName();

    int32_t fd = GetFileFd(fileName);
    if (fd < 0) {
        fd = OpenWriteFile(fileName);
        MSPROF_LOGI("%s is not exist, create file:%d", fileName.c_str(), static_cast<int32_t>(fd));
        if (fd < 0) {
            MSPROF_LOGE("create %s failed fd[%d].", fileName.c_str(), static_cast<int32_t>(fd));
            return;
        }
    }

    const size_t size = chunk->GetUsedSize();
    int32_t ret = OsalWrite(fd, static_cast<void *>(const_cast<UNSIGNED_CHAR_PTR>(chunk->GetBuffer())), size);
    if (static_cast<size_t>(ret) != size) {
        MSPROF_LOGE("write[%d] fileName = %s data size = %u, written size = %d",
                    static_cast<int32_t>(fd), fileName.c_str(),
                    size, ret);
    }
}

int32_t Sender::Execute()
{
    const int32_t maxPopCount = 64;
    std::vector<SHARED_PTR_ALIA<File> > file(maxPopCount);

    file.clear();
    if (!fileQueue_->TryBatchPop(maxPopCount, file)) {
        return PROFILING_FAILED;
    }

    const size_t count = file.size();

    for (uint32_t i = 0; i < count; ++i) {
        if (file[i]->IsStreamMode()) {
            ExecuteStreamMode(file[i]);
        } else {
            ExecuteFileMode(file[i]);
        }
        file[i]->Uinit();
    }
    MSPROF_LOGD("[Sender::Execute] Execute success, count:%lu", count);

    std::lock_guard<std::mutex> lk(cvLock_);
    if (fileQueue_->Size() == 0) {
        isFinished_ = true;
        cv_.notify_all();
    }

    return PROFILING_SUCCESS;
}

size_t Sender::HashId()
{
    return hashId_;
}

SenderPool::SenderPool()
    : inited_(false)
{
}

SenderPool::~SenderPool()
{
    Uninit();
}

int32_t SenderPool::Init()
{
    int32_t ret = PROFILING_FAILED;

    do {
        std::lock_guard<std::mutex> lk(mtx_);
        if (inited_) {
            ret = PROFILING_SUCCESS;
            break;
        }

        MSPROF_LOGI("createing sender pool");
        MSVP_MAKE_SHARED2_NODO(senderPool_, analysis::dvvp::common::thread::ThreadPool,
            analysis::dvvp::common::thread::LOAD_BALANCE_METHOD::ID_MOD, MSVP_CLN_SENDER_POOL_THREAD_NUM, break);

        senderPool_->SetThreadPoolNamePrefix(MSVP_SENDER_POOL_NAME_PREFIX);
        senderPool_->SetThreadPoolQueueSize(SENDERPOOL_THREAD_QUEUE_SIZE);
        ret = senderPool_->Start();
        if (ret != PROFILING_SUCCESS) {
            MSPROF_LOGE("Failed to start sender pool, ret=%d", ret);
            break;
        }
        inited_ = true;
    } while (0);

    return ret;
}

void SenderPool::Uninit()
{
    std::lock_guard<std::mutex> lk(mtx_);
    if (inited_) {
        (void)senderPool_->Stop();
        inited_ = false;
    }
}

int32_t SenderPool::Dispatch(SHARED_PTR_ALIA<Sender> sender)
{
    std::lock_guard<std::mutex> lk(mtx_);
    if (inited_) {
        senderPool_->Dispatch(sender);
        return PROFILING_SUCCESS;
    }

    return PROFILING_FAILED;
}
}  // namespace client
}  // namespace streamio
}  // namespace dvvp
}  // namespace analysis
