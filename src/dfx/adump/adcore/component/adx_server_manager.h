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
#include <queue>
#include <mutex>
#include "ascend_hal.h"
#include "common/thread.h"
#include "bound_queue.h"
#include "adx_component.h"
#include "epoll/adx_epoll.h"
#include "adx_comm_opt_manager.h"
#include "extra_config.h"
namespace Adx {
constexpr uint32_t DEFAULT_EPOLL_HANDLE_QUEUE_SIZE = 256;
class AdxServerManager : public Runnable {
public:
    AdxServerManager() noexcept;
    explicit AdxServerManager(int32_t loadMode, int32_t deviceId) noexcept;
    ~AdxServerManager();
    bool RegisterEpoll(std::unique_ptr<AdxEpoll> &epoll);
    bool RegisterCommOpt(std::unique_ptr<AdxCommOpt> &opt,
        const std::string &info);
    bool ComponentAdd(std::unique_ptr<AdxComponent> &comp);
    bool ComponentErase(ComponentType type);
    bool ComponentInit() const;
    bool ComponentWaitEvent();
    void Run();
    void ComponentProcess();
    bool SubComponentProcess(CommHandle &handle, ComponentType &comp);
    static IdeThreadArg ThreadProcess(IdeThreadArg arg);
    int32_t Exit();
    void SetMode(int32_t loadMode);
    void SetDeviceId(int32_t deviceId);
    bool WaitServerInitted() const;
private:
    void TimerProcess(void);
    bool ServerInit(const std::map<std::string, std::string> &info);
    bool ServerUnInit(OptHandle epHandle);
    ComponentType GetComponentTypeByReqType(CmdClassT cmdType) const;
    void HandleConnectEvent(CommHandle handle);
    bool IsLinkOverload(HDC_SESSION session) const;
    bool DispatchComponent(CommHandle &handle, SharedPtr<MsgProto> &msgPtr, HDC_SESSION session, ComponentType &comp);
private:
    bool waitOver_;
    int32_t pid_;
    int32_t loadMode_; // 0 default, 1 virtual
    int32_t deviceId_; // set -1 is all
    OptType type_;
    std::string info_;
    std::unique_ptr<AdxEpoll> epoll_;
    std::map<ComponentType, std::unique_ptr<AdxComponent>> compMap_;
    std::map<std::string, EpollHandle> servers_;
    std::map<std::string, uint32_t> faultyDevices_;
    BoundQueue<EpollHandle> handleQue_;
    int32_t linkNum_;
    std::mutex linkMtx_;
    bool serverInittedFlag_;
};
}
#endif
