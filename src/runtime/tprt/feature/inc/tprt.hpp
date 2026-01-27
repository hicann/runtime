/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_TPRT_HPP__
#define __CCE_TPRT_HPP__
#include <mutex>
#include "tprt_type.h"
#include "tprt_device.hpp"

namespace cce {
namespace tprt {

class TprtManage {
public:
    static TprtManage *Instance()
    {
        // tprt_:The caller controls the application to ensure that the destructor is released.
        return tprt_;
    }
    TprtManage();
    ~TprtManage();

    void TprtInitCfg(const TprtCfgInfo_t *cfg);
    uint32_t TprtDeviceOpen(const uint32_t devId, const TprtCfgInfo_t *cfg);
    uint32_t TprtDeviceClose(const uint32_t devId);
    TprtDevice *GetDeviceByDevId(const uint32_t devId);
    void TprtDeleteDeviceByDevId(const uint32_t devId);
	uint32_t TprtGetSqMaxDepth() const
    {
        return sqcqMaxDepth_;
    }
    uint32_t TprtGetSqCqMaxNum() const
    {
        return sqcqMaxNum_;
    }
    bool IsQueueFull(const uint16_t head, const uint16_t tail, const uint32_t allocNum) const;
    static TprtManage *tprt_;
private:
    uint32_t sqcqMaxNum_{0U};
    uint32_t sqcqMaxDepth_{0U};
    uint32_t timeoutMonitorUint_{0U};  // unit:ms
    uint32_t defaultExeTimeout_{0U};  // unit:ms
    std::mutex deviceIdToDeviceMapLock_;
    std::unordered_map<uint32_t, TprtDevice *> deviceMap_;      // key is deviceId, value is device
};
}
}

#endif