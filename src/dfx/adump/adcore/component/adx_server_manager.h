/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADX_COMPONENTS_MANAGER_H
#define ADX_COMPONENTS_MANAGER_H
#include <map>
#include <memory>
#include <mutex>
#include <atomic>
#include <chrono>
#include <condition_variable>
#include "ascend_hal.h"
#include "common/thread.h"
#include "adx_component.h"
#include "epoll/adx_epoll.h"
#include "adx_comm_opt_manager.h"
#include "extra_config.h"
namespace Adx {
constexpr uint32_t MAX_WAITING_REQUESTS = 256;
class AdxServerManager : public Runnable {
public:
    AdxServerManager() noexcept;
    explicit AdxServerManager(int32_t loadMode, int32_t deviceId) noexcept;
    ~AdxServerManager();
    bool RegisterEpoll(std::unique_ptr<AdxEpoll>& epoll);
    bool RegisterCommOpt(std::unique_ptr<AdxCommOpt>& opt, const std::string& info);
    bool ComponentAdd(std::unique_ptr<AdxComponent>& comp);
    bool ComponentErase(ComponentType type);
    bool ComponentInit() const;
    bool ComponentWaitEvent();
    void Run();
    int32_t Exit();
    void SetMode(int32_t loadMode);
    void SetDeviceId(int32_t deviceId);
    bool WaitServerInitted() const;

private:
    using RequestClock = std::chrono::steady_clock;

    enum class PrepareResult { SUCCESS, RETRY, FAILED };

    struct PendingRequest {
        EpollHandle handle;
        RequestClock::time_point deadline;
    };

    struct ProcessTask {
        AdxServerManager* manager;
        AdxCommHandle handle;
        SharedPtr<MsgProto> msgPtr;
        ComponentType comp;
        bool linkAcquired;
    };

    void TimerProcess(void);
    bool ServerInit(const std::map<std::string, std::string>& info);
    bool ServerUnInit(OptHandle epHandle);
    ComponentType GetComponentTypeByReqType(CmdClassT cmdType) const;
    void HandleConnectEvent(CommHandle handle);
    void HandleDataEvent(EpollHandle handle);
    void HandleHangUpEvent(EpollHandle handle);
    bool WaitRequest(const PendingRequest& request);
    void ProcessRequest(const PendingRequest& request);
    void CloseExpiredRequests();
    void CloseWaitingRequests();
    bool IsLinkOverload(HDC_SESSION session) const;
    PrepareResult PrepareComponentProcess(CommHandle& handle, SharedPtr<MsgProto>& msgPtr, ComponentType& comp);
    bool AcquireComponentLink(ComponentType comp, HDC_SESSION session);
    void ReleaseComponentLink(ComponentType comp);
    bool LaunchComponentProcess(CommHandle& handle, SharedPtr<MsgProto>& msgPtr, ComponentType comp);
    void RunProcessTask(ProcessTask& task);
    static IdeThreadArg ProcessTaskThread(IdeThreadArg arg);
    std::shared_ptr<AdxComponent> GetComponent(ComponentType type) const;
    void WaitProcessDrained();

private:
    std::atomic<bool> waitOver_{true};
    int32_t pid_;
    int32_t loadMode_; // 0 default, 1 virtual
    int32_t deviceId_; // set -1 is all
    OptType type_;
    std::string info_;
    std::unique_ptr<AdxEpoll> epoll_;
    std::map<ComponentType, std::shared_ptr<AdxComponent>> compMap_;
    mutable std::mutex compMtx_;
    std::map<std::string, EpollHandle> servers_;
    mutable std::mutex serverMtx_;
    std::map<std::string, uint32_t> faultyDevices_;
    std::map<EpollHandle, PendingRequest> waitingRequests_;
    int32_t linkNum_;
    std::mutex linkMtx_;
    std::atomic<bool> serverInittedFlag_{false};
    uint32_t processingNum_;
    mutable std::mutex processMtx_;
    std::condition_variable processCv_;
};
} // namespace Adx
#endif
