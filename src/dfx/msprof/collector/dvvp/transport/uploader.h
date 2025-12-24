/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_TRANSPORT_UPLOADER_H
#define ANALYSIS_DVVP_TRANSPORT_UPLOADER_H

#include <cstddef>
#include "config/config.h"
#include "queue/bound_queue.h"
#include "thread/thread.h"
#include "transport/transport.h"

namespace analysis {
namespace dvvp {
namespace transport {
using UploaderQueue = analysis::dvvp::common::queue::BoundQueue<SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> >;
class Uploader : public analysis::dvvp::common::thread::Thread {
using analysis::dvvp::common::thread::Thread::Stop;
public:
    explicit Uploader(SHARED_PTR_ALIA<ITransport> transport);

    virtual ~Uploader();

public:
    int32_t Init(size_t size = analysis::dvvp::common::config::UPLOADER_QUEUE_CAPACITY);
    int32_t Uinit();
    int32_t UploadData(CONST_VOID_PTR data, int32_t len);
    int32_t UploadData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    int32_t Stop(bool force);
    void SetTransportStopped();
    void SetPipeTransport(SHARED_PTR_ALIA<ITransport> trans);
    int32_t RegisterPipeTransportCallback(MsprofRawDataCallback callback);
    int32_t UnRegisterPipeTransportCallback();
    void RegisterTransportGenHashIdFuncPtr(HashDataGenIdFuncPtr* ptr);
    void Flush() const;
    void CloseTransport();
    SHARED_PTR_ALIA<ITransport> GetTransport();

protected:
    void Run(const struct error_message::Context &errorContext) override;

private:
    SHARED_PTR_ALIA<ITransport> transport_;
    SHARED_PTR_ALIA<ITransport> pipeTransport_;
    SHARED_PTR_ALIA<UploaderQueue> queue_;
    bool isInited_;
    volatile bool forceQuit_;
    volatile bool isStopped_;
};
}  // namespace transport
}  // namespace dvvp
}  // namespace analysis

#endif
