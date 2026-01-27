/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_XPU_DRIVER_HPP
#define CCE_RUNTIME_XPU_DRIVER_HPP

#include "driver.hpp"
#include "npu_driver.hpp"
#include "tprt_api.h"
#include "base.hpp"

namespace cce {
namespace runtime {

// Real driver
class XpuDriver : public NpuDriver {
public:
    XpuDriver();
    ~XpuDriver() override = default;
    rtError_t XpuDriverDeviceSqCqAlloc(const uint32_t devId, const uint32_t sqId, const uint32_t cqId);
    rtError_t XpuDriverDeviceOpen(const uint32_t devId, TprtCfgInfo_t *devInfo) const;
    rtError_t XpuDriverDeviceClose(const uint32_t devId) const;
    rtError_t XpuDriverSetSqCqStatus(const uint32_t devId, const uint32_t sqId);
    rtError_t XpuDriverSqCqDestroy(const uint32_t devId, const uint32_t sqId, const uint32_t cqId);

    static Driver *Instance_()
    {
        return new (std::nothrow) XpuDriver();
    }
	rtError_t GetSqState(const uint32_t deviceId, const uint32_t sqId, uint32_t &status);
    rtError_t LogicCqReportV2(const LogicCqWaitInfo &waitInfo, uint8_t *report, uint32_t reportCnt,
        uint32_t &realCnt) override;
    rtError_t GetCqeStatus(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, bool &status) override;
    rtError_t GetSqHead(const uint32_t deviceId, const uint32_t tsId, const uint32_t sqId, uint16_t &head, bool needLog) override;
    void InitDrvErrCodeMap();
    rtError_t GetDrvErrCode(const uint32_t errCode);
private:
    std::map<uint32_t, rtError_t> tprtErrMap_;
};

}  // namespace runtime
}  // namespace cce

#endif  // CCE_RUNTIME_NPU_DRIVER_HPP
