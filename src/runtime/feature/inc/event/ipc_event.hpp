/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_IPC_EVENT_HPP
#define CCE_RUNTIME_IPC_EVENT_HPP

#include "event.hpp"
#include "task_info.hpp"
#include "stream.hpp"
#include "memory_task.h"
#include "driver/ascend_hal.h"
#include <unordered_set>

namespace cce {
namespace runtime {
class Event;
class Context;
class Device;

constexpr uint64_t IPC_EVENT_P2P_NO_CHECK_FLAG = 1U;
constexpr uint32_t DEV_MEM_MAP_FLAG = 0x1U;
constexpr uint32_t HOST_MEM_MAP_FLAG = 0x2U;
constexpr uint32_t IPC_HANDLE_MAP_FLAG = 0x4U;
constexpr uint32_t MEM_SET_ACCESS_NUM = 1U;
constexpr uint16_t IPC_EVENT_P2P_SIZE = 8192U;
constexpr int32_t  IMPORT_DEVICE_ID = 65U;

enum class LockStatus : uint8_t {
    LOCK_RELEASED = 0,        /* not occupied */
    LOCK_OCCUPIED = 1,        /* occupied */
};

struct IpcHandleVa {
    uint64_t  volatile lockStatus;   // atomic lock
    void*     deviceMemHandle;
    uint64_t  deviceMemRef[IPC_EVENT_P2P_SIZE];
    uint16_t  currentIndex;
};

class IpcEvent : public Event {
public :
    IpcEvent(Device *device, uint64_t eventFlag, Context *ctx);
    ~IpcEvent() noexcept override;
    rtError_t Setup() override;
    rtError_t IpcGetEventHandle(rtIpcEventHandle_t *handle);
    rtError_t IpcOpenEventHandle(rtIpcEventHandle_t *ipcEventHandle);
    rtError_t EnableP2PForIpc(uint64_t deviceMemHandle) const;
    rtError_t IpcEventRecord(Stream * const stm);
    rtError_t IpcVaAndPaOperation(size_t granularity, rtDrvMemProp_t *prop, uint64_t *deviceMemHandle);
    rtError_t IpcHandleAllocAndExport(size_t granularity, rtDrvMemProp_t *prop, uint64_t* ipcHandle);
    rtError_t IpcHandleAllocAndImport(size_t granularity, rtIpcEventHandle_t* ipcEventHandle);
    rtError_t IpcMemHandleImport(size_t granularity, bool hostFlag, uint64_t deviceMemHandle);
    rtError_t IpcEventWait(Stream * const stm);
    rtError_t IpcEventQuery(rtEventStatus_t * const status);
    rtError_t IpcEventSync(int32_t timeout = -1);
    rtError_t GetIpcRecordIndex(uint16_t *curIndex);
    bool TryFreeEventIdAndCheckCanBeDelete(const int32_t id, bool isNeedDestroy) override;
    void FreeMemForVaUse();
    rtError_t ReleaseDrvResource();
    void IpcEventCountAdd()
    {
        totalTaskCnt_++;
    }
    void IpcEventCountSub()
    {
        totalTaskCnt_--;
    }
    Device *Device_() const override
    {
        return device_;
    }
    Context *Context_() const override
    {
        return context_;
    }
    uint64_t GetEventFlag() const override
    {
        return eventFlag_;
    }
    void SetIsNeedDestroy(bool flag) override {
        isNeedDestroy_.Set(flag);
    }
    IpcHandleVa* GetIpcHandleVa() 
    {
        return ipcHandleVa_;
    }
    uint8_t* GetCurrentHostMem()
    {
        return RtPtrToPtr<uint8_t*>(currentHostMem_);
    }
    void IpcVaLockInit()
    {
        ipcHandleVa_->lockStatus = static_cast<uint64_t>(LockStatus::LOCK_RELEASED);
    }
    void IpcVaLock()
    {
        while (!CompareAndExchange(&ipcHandleVa_->lockStatus, static_cast<uint64_t>(LockStatus::LOCK_RELEASED),
            static_cast<uint64_t>(LockStatus::LOCK_OCCUPIED)));
    }
    void IpcVaUnLock()
    {
        while (!CompareAndExchange(&ipcHandleVa_->lockStatus, static_cast<uint64_t>(LockStatus::LOCK_OCCUPIED),
            static_cast<uint64_t>(LockStatus::LOCK_RELEASED)));
    }

    void EventDestroyLock(void)
    {
        eventDestroyLock_.lock();
    }

    void EventDestroyUnLock(void)
    {
        eventDestroyLock_.unlock();
    }

    void SetIpcFinished(void)
    {
        eventStatus_ = RECORDED;
    }

    bool IsIpcFinished() const
    {
        return (eventStatus_ == RECORDED) ? true : false;
    }

    size_t GetAlignedSize(size_t handleSize, size_t granularity) const
    {
        // granularity 4k or 64k;
        return (handleSize + granularity - 1U) & (~(granularity - 1U));
    }
protected:
    Device           *device_;
    uint64_t         eventFlag_;
    Context          *context_;
private:
    void* ipcHandlePa_;
    IpcHandleVa* ipcHandleVa_;
    void* currentDeviceMem_;
    void* currentHostMem_;
    rtDrvMemHandle deviceMemPa_;
    rtDrvMemHandle hostMemPa_;
    uint64_t ipcHandle_;            // ipc handle for user
    uint64_t deviceMemSize_;
    uint64_t totalTaskCnt_;
    Atomic<bool> isNeedDestroy_;
    uint32_t mapFlag_;
    rtEventState_t eventStatus_;
    std::mutex eventResLock_;
    std::mutex eventDestroyLock_;
};
}
}

#endif  // CCE_RUNTIME_IPC_EVENT_HPP