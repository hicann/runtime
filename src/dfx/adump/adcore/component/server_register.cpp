/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "server_register.h"
#include "memory_utils.h"
#include "log/adx_log.h"
using namespace Adx;
namespace Adx {
int32_t ServerRegister::RegisterComponent(int32_t serverType, std::unique_ptr<AdxComponent> &adxComponent)
{
    std::lock_guard<std::mutex> lk(mtx_);
    return services_[serverType].ComponentAdd(adxComponent) ? IDE_DAEMON_OK : IDE_DAEMON_ERROR;
}

int32_t ServerRegister::UnRegisterComponent(int32_t serverType, ComponentType cmpt)
{
    std::lock_guard<std::mutex> lk(mtx_);
    return services_[serverType].ComponentErase(cmpt) ? IDE_DAEMON_OK : IDE_DAEMON_ERROR;
}

int32_t ServerRegister::ComponentServerStartup(ServerInitInfo info) const
{
    return ServerRegister::Instance().ServerManagerInit(info) ? IDE_DAEMON_OK : IDE_DAEMON_ERROR;
}

int32_t ServerRegister::ComponentServerCleanup(int32_t serverType)
{
    std::lock_guard<std::mutex> lk(mtx_);
    (void)services_.erase(serverType);
    return (services_.count(serverType) == 0) ? IDE_DAEMON_OK : IDE_DAEMON_ERROR;
}

bool ServerRegister::ServerManagerInit(const ServerInitInfo info)
{
    drvHdcServiceType type = static_cast<drvHdcServiceType>(info.serverType);
    auto it = services_.find(type);
    if (it == services_.end()) {
        IDE_LOGE("Find server failed, serverType:%d", static_cast<int32_t>(type));
        return false;
    }
    std::unique_ptr<AdxEpoll> epoll(CreateAdxEpoll(EpollType::EPOLL_HDC));
    IDE_CTRL_VALUE_FAILED(epoll != nullptr, return false, "create epoll error");
    bool ret = it->second.RegisterEpoll(epoll);
    IDE_CTRL_VALUE_FAILED(ret, return false, "register epoll error");
    std::unique_ptr<AdxCommOpt> opt(CreateAdxCommOpt(OptType::COMM_HDC));
    IDE_CTRL_VALUE_FAILED(opt != nullptr, return false, "create commopt error");
    ret = it->second.RegisterCommOpt(opt, std::to_string(type));
    IDE_CTRL_VALUE_FAILED(ret, return false, "register commopt error");
    ret = it->second.ComponentInit();
    IDE_CTRL_VALUE_FAILED(ret, return false, "component init error");
    it->second.SetMode(info.mode);
    it->second.SetDeviceId(info.deviceId);
    it->second.SetThreadName(std::string("adx_get_file_thread"));
    it->second.Start();
    (void)it->second.Join();
    return true;
}

static IdeThreadArg AdxServerProcess(const IdeThreadArg arg)
{
    if (arg == nullptr) {
        return nullptr;
    }
    ServerInitInfo info = *static_cast<ServerInitInfo *>(arg);
    int32_t ret = ServerRegister::Instance().ComponentServerStartup(info);
    IDE_CTRL_VALUE_FAILED(ret == IDE_DAEMON_OK, return nullptr, "server process failed");
    return nullptr;
}
}

int32_t AdxRegisterComponentFunc(drvHdcServiceType serverType, std::unique_ptr<AdxComponent> &adxComponent)
{
    IDE_LOGI("Start to register, serverType:%d, componentType:%d", static_cast<int32_t>(serverType),
        static_cast<int32_t>(adxComponent->GetType()));
    return ServerRegister::Instance().RegisterComponent(serverType, adxComponent);
}

int32_t AdxComponentServerStartup(ServerInitInfo info)
{
    IDE_LOGI("Start to startup, serverType:%d", static_cast<int32_t>(info.serverType));
    static ServerInitInfo serverInfo{0, 0, 0};
    serverInfo = info;
    mmUserBlock_t funcBlock;
    funcBlock.procFunc = AdxServerProcess;
    funcBlock.pulArg = static_cast<IdeThreadArg>(&serverInfo);
    mmThread tid = 0;
    int32_t ret = Thread::CreateDetachTaskWithDefaultAttr(tid, funcBlock);
    return (ret != EN_OK) ? IDE_DAEMON_ERROR : IDE_DAEMON_OK;
}

int32_t AdxComponentServerCleanup(drvHdcServiceType serverType, ComponentType cmpt)
{
    IDE_LOGI("Start to cleanup, serverType:%d, componentType:%d", static_cast<int32_t>(serverType),
        static_cast<int32_t>(cmpt));
    if (cmpt == ComponentType::NR_COMPONENTS) {
        return ServerRegister::Instance().ComponentServerCleanup(serverType);
    }
    return ServerRegister::Instance().UnRegisterComponent(serverType, cmpt);
}