/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_LOGIC_SQ_HPP__
#define __CCE_RUNTIME_LOGIC_SQ_HPP__

#include <cstdint>
#include <map>
#include "base.hpp"

namespace cce {
namespace runtime {

class Device;
class SqAddrMemoryOrder;

class LogicSq {
public:
    explicit LogicSq(Device* const device) : device_(device) {}
    ~LogicSq();
    Device* Device_() const { return device_; }
    rtError_t SetUp(const uint32_t logicSqId, const uint32_t reserveSqeNum);
    rtError_t AllocDeviceSqeAddr(const uint32_t additionalSqeNum);

    bool GetStreamIdAndPosByHwPos(const uint32_t hwPos, uint32_t& streamId, uint32_t& pos) const;
    void SetHwPosMapping(const uint32_t hwPos, const uint32_t streamId, const uint32_t pos);

    uint32_t Id_() const { return id_; }

    uint16_t GetRtsqId() const { return rtsqId_; }
    void SetRtsqId(const uint16_t id) { rtsqId_ = id; }

    uint8_t* GetHostSqeAddr() const { return hostSqeAddr_; }
    void SetHostSqeAddr(uint8_t* const addr) { hostSqeAddr_ = addr; }

    uint32_t GetHostSqeSize() const { return hostSqeSize_; }
    void SetHostSqeSize(const uint32_t size) { hostSqeSize_ = size; }

    void* GetDeviceSqeAddr() const { return deviceSqeAddr_; }
    void SetDeviceSqeAddr(void* const addr) { deviceSqeAddr_ = addr; }

    uint32_t GetDeviceSqeSize() const { return deviceSqeSize_; }
    void SetDeviceSqeSize(const uint32_t size) { deviceSqeSize_ = size; }

    uint32_t GetSqMemOrderType() const { return sqMemOrderType_; }
    void SetSqMemOrderType(const uint32_t memOrderType) { sqMemOrderType_ = memOrderType; }

    uint32_t GetSqeNum() const { return sqeNum_; }
    void SetSqeNum(const uint32_t num) { sqeNum_ = num; }

    uint32_t GetLogicSqDepth() const { return logicSqDepth_; }
    void SetLogicSqDepth(const uint32_t depth) { logicSqDepth_ = depth; }

    uint32_t GetReserveSqeNum() const { return reserveSqeNum_; }

    uint64_t GetSqIdMemAddr() const { return sqIdMemAddr_; }
    void SetSqIdMemAddr(const uint64_t addr) { sqIdMemAddr_ = addr; }

    uint32_t GetStreamId() const { return streamId_; }
    void SetStreamId(const uint32_t id) { streamId_ = id; }

    bool HasActiveSqe() const { return nextLogicSqId_ != UINT32_MAX; }
    uint32_t GetNextLogicSqId() const { return nextLogicSqId_; }
    void SetNextLogicSqId(const uint32_t id) { nextLogicSqId_ = id; }

private:
    Device* device_{nullptr};
    uint32_t id_{UINT32_MAX};
    uint16_t rtsqId_{UINT16_MAX};
    uint8_t* hostSqeAddr_{nullptr};
    uint32_t hostSqeSize_{0U};
    void* deviceSqeAddr_{nullptr};
    uint32_t deviceSqeSize_{0U};
    uint32_t sqMemOrderType_{UINT32_MAX};
    uint32_t sqeNum_{0U};
    uint32_t logicSqDepth_{0U};
    uint32_t reserveSqeNum_{32U};
    uint64_t sqIdMemAddr_{0UL};
    uint32_t streamId_{UINT32_MAX};
    uint32_t nextLogicSqId_{UINT32_MAX};
    std::map<uint32_t, std::pair<uint32_t, uint32_t>> hwPosToTask_; // key: hwPos, pair<streamId, pos>
};

} // namespace runtime
} // namespace cce

#endif // __CCE_RUNTIME_LOGIC_SQ_HPP__
