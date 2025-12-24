/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef COLLECT_IO_SENDER_H_INCLUDED
#define COLLECT_IO_SENDER_H_INCLUDED

#include <condition_variable>
#include <chrono>
#include <mutex>
#include <google/protobuf/message.h>
#include "file.h"
#include "osal.h"
#include "queue/bound_queue.h"
#include "singleton/singleton.h"
#include "thread/thread_pool.h"
#include "utils/utils.h"
#include "transport/transport.h"

namespace analysis {
namespace dvvp {
namespace streamio {
namespace client {
using namespace analysis::dvvp::transport;
typedef analysis::dvvp::common::queue::BoundQueue<SHARED_PTR_ALIA<File>> FileQueue;

struct DataChunk {
    char* relativeFileName;   // from subpath begin; For example: subA/subB/example.txt; Note: the begin don't has '/';
    unsigned char* dataBuf;   // the pointer to the data
    uint32_t bufLen;      // the len of dataBuf
    uint32_t isLastChunk; // = 1, the last chunk of the file; != 1, not the last chunk of the file
    long long offset;         // the begin location of the file to write; if the offset is -1, directly append data.
};

class Sender : public analysis::dvvp::common::thread::Task, public std::enable_shared_from_this<Sender> {
public:
    Sender(SHARED_PTR_ALIA<ITransport> transport, const std::string &engineName,
           SHARED_PTR_ALIA<analysis::dvvp::common::memory::ChunkPool> chunkPool);
    ~Sender() override;

public:
    int32_t Init();
    void Uninit();

    int32_t Send(const std::string &jobCtxJson, const struct DataChunk &data);
    void Flush();

public:
    int32_t Execute() override;
    size_t HashId() override;

private:
    void FlushFileCache();
    SHARED_PTR_ALIA<File> GetFirstFileFromCache();
    SHARED_PTR_ALIA<std::mutex> GetMutexByFileName(const std::string &fileName);
    void DispatchFile(SHARED_PTR_ALIA<File> file);
    void WaitEmpty();
    SHARED_PTR_ALIA<File> InitNewCustomFile(const std::string &jobCtxJson,
                                            const std::string &fileName,
                                            const size_t chunkSize) const;
    int32_t SaveFileData(const std::string &jobCtxJson, const struct DataChunk &data);
    void CloseFileFds();
    int32_t OpenWriteFile(const std::string &fileName);
    int32_t GetFileFd(const std::string &fileName);
    void SetFileFd(const std::string &fileName, int32_t fd);
    int32_t SendData(CONST_CHAR_PTR buffer, int32_t size);
    void ExecuteStreamMode(SHARED_PTR_ALIA<File> file);
    void ExecuteFileMode(SHARED_PTR_ALIA<File> file);
    SHARED_PTR_ALIA<std::string> EncodeData(SHARED_PTR_ALIA<File> file) const;
    int32_t DoSaveFileData(const std::string &fileName, SHARED_PTR_ALIA<File> &file, const struct DataChunk &data);

private:
    Sender &operator=(const Sender &sender);
    Sender(const Sender &sender);

private:
    SHARED_PTR_ALIA<ITransport> transport_;
    std::string engineName_;
    SHARED_PTR_ALIA<analysis::dvvp::common::memory::ChunkPool> chunkPool_;
    volatile bool isInited_;
    volatile bool isFinished_;
    size_t hashId_;
    std::mutex fileFdLock_;
    std::map<std::string, int32_t> fileFdMap_;
    SHARED_PTR_ALIA<FileQueue> fileQueue_;
    std::mutex fileMapLock_;
    std::map<std::string, SHARED_PTR_ALIA<File>> fileMap_;
    std::mutex fileMutexMapLock_;
    std::map<std::string, SHARED_PTR_ALIA<std::mutex>> fileMutexMap_;
    std::condition_variable cv_;
    std::mutex cvLock_;
};

class SenderPool : public analysis::dvvp::common::singleton::Singleton<SenderPool> {
public:
    SenderPool();
    ~SenderPool() override;

public:
    int32_t Init();
    void Uninit();

public:
    int32_t Dispatch(SHARED_PTR_ALIA<Sender> sender);

private:
    volatile bool inited_;
    SHARED_PTR_ALIA<analysis::dvvp::common::thread::ThreadPool> senderPool_;
    std::mutex mtx_;
};
}  // namespace client
}  // namespace streamio
}  // namespace dvvp
}  // namespace analysis

#endif