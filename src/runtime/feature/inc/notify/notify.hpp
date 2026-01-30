/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_NOTIFY_HPP__
#define __CCE_RUNTIME_NOTIFY_HPP__

#include <string>
#include "context.hpp"
#include "device.hpp"

#define RT_NOTIFY_GET_EVENT_ID(key) ((key) & 0x3FFU)
#define RT_NOTIFY_FLAG_SHR_ID_SHADOW (0x1U << 6)
#define RT_NOTIFY_INVALID_SRV_ID (0xFFFFU)
#define RT_NOTIFY_MAX_SRV_ID (47U)
namespace cce {
namespace runtime {
constexpr uint32_t RT_NOTIFY_REVISED_OFFSET = 15U;
class Context;
class Device;

class Notify : public NoCopy {
public:
    Notify(const uint32_t devId, const uint32_t taskSchId);
    ~Notify() noexcept override;
    rtError_t GetNotifyAddress(Stream * const streamIn, uint64_t &addr);
    rtError_t Record(Stream * const streamIn);
    rtError_t Setup();
    rtError_t ReAllocId() const;
    rtError_t Wait(Stream * const streamIn, const uint32_t timeOut, const bool isEndGraphNotify = false,
        Model* const captureModel = nullptr);
    rtError_t Reset(Stream * const streamIn) const;
    rtError_t CreateIpcNotify(char_t * const ipcNotifyName, const uint32_t len);
    rtError_t OpenIpcNotify(const char_t * const ipcNotifyName, uint32_t flag);
    rtError_t SetName(const char_t * const nameIn);
    rtError_t GetAddrOffset(uint64_t * const devAddrOffset);
    rtError_t CheckIpcNotifyDevId();
    uint32_t GetPhyDevId() const
    {
        return phyId_;
    }
    uint32_t GetTsId() const
    {
        return tsId_;
    }
    uint32_t GetNotifyId() const
    {
        return notifyid_;
    }
    uint32_t GetDieId() const
    {
        return dieId_;
    }

    uint32_t GetAdcDieId() const
    {
        return adcDieId_;
    }

    void SetEndGraphModel(Model * const model)
    {
        endGraphModel_ = model;
    }
    Model *GetEndGraphModel() const
    {
        return endGraphModel_;
    }

    void SetNotifyFlag(uint32_t flag)
    {
        notifyFlag_ = flag;
    }

    uint32_t GetServiceId() const
    {
        return srvId_;
    }

    uint32_t GetChipId() const
    {
        return chipId_;
    }
    uint32_t GetDeviceId() const
    {
        return deviceId_;
    }

    bool IsPod() const
    {
        return isPod_;
    }
    uint32_t GetLastLocalId() const
    {
        return lastLocalId_;
    }

    bool GetLastIsPcie() const
    {
        return lastIsPcie_;
    }

    uint64_t GetLastBaseAddr() const
    {
        return lastBaseAddr_;
    }
    void SetNotifylastBaseAddr(uint64_t lastBaseAddr)
    {
        lastBaseAddr_ = lastBaseAddr;
    }

    void SetNotifylastLocalId(uint32_t lastLocalId)
    {
        lastLocalId_ = lastLocalId;
    }

    void SetNotifylastIsPcie(bool lastIsPcie)
    {
        lastIsPcie_ = lastIsPcie;
    }

    const std::string &GetIpcName() const
    {
        return ipcName_;
    }

    bool IsIpcNotify() const
    {
        return isIpcNotify_;
    }

    bool IsIpcCreator() const
    {
        return isIpcCreator_;
    }
    rtError_t AllocId();
    rtError_t FreeId();
private:
    rtError_t RevisedWait(Stream * const streamIn, const uint32_t timeout = 0);
    uint32_t notifyid_;
    uint32_t phyId_;
    std::string name_;
    bool isIpcNotify_;
    bool isIpcCreator_;
    std::string ipcName_;
    Driver *driver_;
    uint32_t tsId_;
    uint32_t deviceId_;
    uint32_t dieId_;
    uint32_t adcDieId_;  // The adcDieId_ variable indicates the dieid in the ADC form.
    Model *endGraphModel_;
    uint32_t lastLocalId_;
    uint64_t lastBaseAddr_;
    bool lastIsPcie_;
    uint32_t notifyFlag_;
    uint32_t localDevId_;
    uint32_t srvId_;
    uint32_t chipId_;
    bool isPod_;
    Device *dev_{nullptr};
};
}
}

#endif  // __CCE_RUNTIME_NOTIFY_HPP__
