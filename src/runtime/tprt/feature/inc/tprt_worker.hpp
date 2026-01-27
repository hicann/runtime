/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_TPRT_WORKER_HPP__
#define __CCE_TPRT_WORKER_HPP__
#include <thread>
#include "tprt_cqhandle.hpp"

enum TprtWorkerState : uint32_t {
    TPRT_WORKER_STATE_RUNNING = 0U,
    TPRT_WORKER_STATE_QUIT,
    TPRT_WORKER_STATE_INVALID
};

namespace cce {
namespace tprt {

class TprtWorker {
public:
    explicit TprtWorker(uint32_t devId, TprtSqHandle *sqHandle, TprtCqHandle *cqHandle);
    ~TprtWorker();
    uint32_t TprtWorkerStop();
    void  TprtWokerScheduleSq();
    uint32_t TprtWorkerStart();
    void TprtWorkerFree();
    void TprtWorkerScheduleSq();
    void WorkerWakeUp();
    TprtSqHandle *&GetSqHandle()
    {
        return sqHandle_;
    }
    TprtCqHandle *&GetCqHandle()
    {
        return cqHandle_;
    }
    void TprtWorkerProcessErrorCqe(TprtErrorType errorType, uint32_t errorCode, TprtSqe_t *task);

private:
    uint32_t devId_{0xFFFFFFFFU};
    // the pattern of worker name is : {$sqId}_{$pid}_{$devId}
    std::string workerName_;
    //std::mutex stateMtx;
    std::atomic<bool> workerRunningFlag_{false};
    TprtSqHandle *sqHandle_{nullptr};
    TprtCqHandle *cqHandle_{nullptr};
    std::thread workerThread_;
    mmSem_t workerThreadSem_;
};
}
}

#endif
