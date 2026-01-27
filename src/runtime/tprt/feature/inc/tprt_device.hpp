/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_TPRT_DEVICE_HPP__
#define __CCE_TPRT_DEVICE_HPP__

#include "tprt_worker.hpp"
#include <map>

namespace cce {
namespace tprt {

class TprtDevice {
public:
    TprtDevice(uint32_t devId);
    ~TprtDevice();
    uint32_t TprtDeviceStop();
    uint32_t TprtSqCqAlloc(const uint32_t sqId, const uint32_t cqId);
    uint32_t TprtSqCqDeAlloc(const uint32_t sqId, const uint32_t cqId);
    TprtSqHandle *TprtGetSqHandleBySqId(uint32_t sqId);
    TprtCqHandle *TprtGetCqHandleByCqId(uint32_t cqId);
    TprtWorker *TprtGetWorkHandleBySqHandle(TprtSqHandle *handle);

    uint32_t TprtDeleteDevice();
	uint32_t TprtDevOpSqCqInfo(TprtSqCqOpInfo_t *opInfo);
    uint32_t TprtDevGetDevId_() const
    {
        return devId_;
    }
private:
    uint32_t devId_;
    std::mutex sqCqWorkerMapLock_;
    std::unordered_map<uint32_t, TprtSqHandle *> sqHandleMap_;      // key is sqId, value is Stream
    std::unordered_map<uint32_t, TprtCqHandle *> cqHandleMap_;
    std::unordered_map<TprtSqHandle *, TprtWorker *> workerMap_;
};
}
}

#endif
