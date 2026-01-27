/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adx_server_manager.h"
#include "log/adx_log.h"
#include "memory_utils.h"
#include "device/adx_hdc_device.h"
#include "hdc_api.h"
#include "adcore_api.h"
namespace Adx {
namespace {
constexpr uint32_t RECONNECT_TIMES = 3U;
}

AdxServerManager::AdxServerManager() noexcept
    : waitOver_(true),
      pid_(0),
      loadMode_(0),
      deviceId_(-1),
      type_(OptType::NR_COMM),
      info_(""),
      epoll_(nullptr),
      handleQue_(DEFAULT_EPOLL_HANDLE_QUEUE_SIZE),
      linkNum_(0),
      serverInittedFlag_(false)
{
    servers_.clear();
}

AdxServerManager::AdxServerManager(int32_t loadMode, int32_t deviceId) noexcept
    : waitOver_(true),
      pid_(0),
      loadMode_(loadMode),
      deviceId_(deviceId),
      type_(OptType::NR_COMM),
      info_(""),
      epoll_(nullptr),
      handleQue_(DEFAULT_EPOLL_HANDLE_QUEUE_SIZE),
      linkNum_(0),
      serverInittedFlag_(false)
{
    servers_.clear();
}

AdxServerManager::~AdxServerManager()
{
    (void)Exit();
}

bool AdxServerManager::RegisterEpoll(std::unique_ptr<AdxEpoll> &epoll)
{
    if (epoll == nullptr) {
        IDE_LOGE("register epoll input error");
        return false;
    }

    if (epoll_ == nullptr) {
        epoll_ = std::move(epoll);
        return true;
    }

    return false;
}

bool AdxServerManager::RegisterCommOpt(std::unique_ptr<AdxCommOpt> &opt,
    const std::string &info)
{
    if (opt == nullptr) {
        IDE_LOGE("register commopt input error");
        return false;
    }

    info_ = info;
    type_ = opt->GetOptType();
    return AdxCommOptManager::Instance().CommOptsRegister(opt);
}

bool AdxServerManager::ServerInit(const std::map<std::string, std::string> &info)
{
    EpollEvent event;
    if (epoll_ == nullptr || type_ == OptType::NR_COMM || info.empty()) {
        IDE_LOGE("server init failed for epoll not register");
        return false;
    }

    CommHandle handle = AdxCommOptManager::Instance().OpenServer(type_, info);
    if (handle.session == ADX_OPT_INVALID_HANDLE) {
        return false;
    }

    event.events = ADX_EPOLL_CONN_IN;
    event.data = handle.session;
    if (epoll_->EpollCreate(DEFAULT_EPOLL_SIZE) == IDE_DAEMON_ERROR) {
        IDE_LOGE("create epoll failed");
        (void)AdxCommOptManager::Instance().CloseServer(handle);
        return false;
    }

    if (epoll_->EpollAdd(handle.session, event) != IDE_DAEMON_OK) {
        IDE_LOGE("epoll add listen event failed");
        (void)AdxCommOptManager::Instance().CloseServer(handle);
        return false;
    }

    auto it = info.find(OPT_DEVICE_KEY);
    if (it != info.end()) {
        servers_[it->second] = handle.session;
    }
    IDE_LOGI("create server info");
    return true;
}

bool AdxServerManager::ServerUnInit(OptHandle epHandle)
{
    EpollEvent event;
    if (epoll_ == nullptr || epHandle == ADX_OPT_INVALID_HANDLE) {
        IDE_LOGE("server uninit failed for epoll not register");
        return false;
    }
    event.events = ADX_EPOLL_CONN_IN;
    event.data = epHandle;
    if (epoll_->EpollDel(epHandle, event) == IDE_DAEMON_ERROR) {
        IDE_LOGE("epoll del listen event failed");
        return false;
    }

    CommHandle handle = {type_, epHandle, NR_COMPONENTS, -1, nullptr};
    if (AdxCommOptManager::Instance().CloseServer(handle) != IDE_DAEMON_OK) {
        IDE_LOGE("close server failed");
        return false;
    }

    return true;
}

bool AdxServerManager::ComponentAdd(std::unique_ptr<AdxComponent> &comp)
{
    if (comp == nullptr) {
        IDE_LOGE("add component input error");
        return false;
    }

    auto it = compMap_.find(comp->GetType());
    if (it != compMap_.end()) {
        return false;
    }
    IDE_LOGI("server manager add component (%d)", static_cast<int32_t>(comp->GetType()));
    compMap_[comp->GetType()] = std::move(comp);
    return true;
}

bool AdxServerManager::ComponentErase(ComponentType type)
{
    auto it = compMap_.find(type);
    if (it == compMap_.end()) {
        return false;
    }
    IDE_LOGI("server manager erase component (%d)", type);
    (void)compMap_.erase(type);
    return (compMap_.count(type) == 0);
}

bool AdxServerManager::ComponentInit() const
{
    if (epoll_ == nullptr) {
        return false;
    }

    auto it = compMap_.begin();
    while (it != compMap_.end()) {
        (void)it->second->Init();
        it++;
    }
    IDE_LOGI("server manager components init successfully");
    return true;
}

void AdxServerManager::HandleConnectEvent(CommHandle handle)
{
    CommHandle conHandle = AdxCommOptManager::Instance().Accept(handle);
    if (conHandle.session == ADX_OPT_INVALID_HANDLE) {
        return;
    }
    handleQue_.Push(conHandle.session);
    IDE_LOGD("handle queue push: %lx", conHandle.session);
    mmUserBlock_t funcBlock;
    funcBlock.procFunc = AdxServerManager::ThreadProcess;
    funcBlock.pulArg = this;
    mmThread tid = 0;
    int32_t ret = Thread::CreateDetachTask(tid, funcBlock);
    if (ret != EN_OK) {
        EpollHandle epHandle = ADX_INVALID_HANDLE;
        if (handleQue_.Pop(epHandle) == true) {
            IDE_LOGD("handle queue pop: %lx", epHandle);
            CommHandle curHandle {type_, epHandle, NR_COMPONENTS, -1, nullptr};
            (void)AdxCommOptManager::Instance().Close(curHandle);
        }
        char errBuf[MAX_ERRSTR_LEN + 1] = {0};
        IDE_LOGE("create component process thread failed, strerror is %s",
                 mmGetErrorFormatMessage(mmGetErrorCode(), errBuf, MAX_ERRSTR_LEN));
    }
}
bool AdxServerManager::ComponentWaitEvent()
{
    IDE_CTRL_VALUE_FAILED(epoll_ != nullptr, return false, "epoll_ check failed, nullptr");
    const int32_t epollSize = epoll_->EpollGetSize();
    std::vector<EpollEvent> events(epollSize);
    for (int32_t i = 0; i < epollSize; i++) {
        events[i].data = 0;
        events[i].events = 0;
    }
    IDE_RUN_LOGI("Run Server(%d) Process", static_cast<int32_t>(type_));
    waitOver_ = false;
    while (!IsQuit()) {
        TimerProcess();
        int32_t handles = epoll_->EpollWait(events, epollSize, DEFAULT_EPOLL_TIMEOUT);
        for (int32_t i = 0; i < handles && i < epollSize; i++) {
            IDE_LOGI("sock EpollWait accept event %d", handles);
            if ((events[i].events & ADX_EPOLL_CONN_IN) != 0) {
                IDE_LOGI("sock connect EpollWait event %d", handles);
                CommHandle handle = {type_, events[i].data, NR_COMPONENTS, -1, nullptr};
                HandleConnectEvent(handle);
            } else if ((events[i].events & ADX_EPOLL_DATA_IN) != 0) {
                IDE_LOGI("data in");
            } else if ((events[i].events & ADX_EPOLL_HANG_UP) != 0) {
                IDE_LOGW("hang up state");
            } else {
                IDE_LOGW("other epoll state");
                epoll_->EpollErrorHandle();
            }
        }
        if (handles < 0) {
            epoll_->EpollErrorHandle();
        }
    }

    waitOver_ = true;
    return true;
}

void AdxServerManager::Run()
{
    pid_ = mmGetPid();
    if (ComponentWaitEvent()) {
        IDE_RUN_LOGI("server manager stop");
    }
}

IdeThreadArg AdxServerManager::ThreadProcess(IdeThreadArg arg)
{
    if (arg == nullptr) {
        return nullptr;
    }
    auto runnable = reinterpret_cast<AdxServerManager *>(arg);
    (void)mmSetCurrentThreadName("adx_component_process");
    runnable->ComponentProcess();
    return nullptr;
}

void AdxServerManager::ComponentProcess()
{
    EpollHandle epHandle = ADX_INVALID_HANDLE;
    IDE_LOGI("process new connect");
    if (handleQue_.Pop(epHandle) == false) {
        return;
    }
    IDE_LOGD("handle queue pop: %lx", epHandle);

    if (epHandle == ADX_INVALID_HANDLE) {
        IDE_LOGE("server run process handle invalid");
        return;
    }

    AdxCommHandle handle = static_cast<AdxCommHandle>(IdeXmalloc(sizeof(CommHandle)));
    IDE_CTRL_VALUE_FAILED(handle != nullptr, return, "malloc handle failed.");
    handle->type = type_;
    handle->session = epHandle;
    handle->comp = ComponentType::NR_COMPONENTS;
    handle->timeout = 0;
    handle->client = nullptr;
    ComponentType comp = ComponentType::NR_COMPONENTS;
    bool ret = SubComponentProcess(*handle, comp);
    if (((comp != ComponentType::COMPONENT_LOG_BACKHAUL) && (comp != ComponentType::COMPONENT_TRACE) &&
        (comp != ComponentType::COMPONENT_SYS_REPORT) && (comp != ComponentType::COMPONENT_FILE_REPORT) &&
        (comp != ComponentType::COMPONENT_CPU_DETECT)) || !ret) {
        (void)AdxCommOptManager::Instance().Close(*handle);
        handle->session = ADX_OPT_INVALID_HANDLE;
        IDE_XFREE_AND_SET_NULL(handle);
    }
}

bool AdxServerManager::SubComponentProcess(CommHandle &handle, ComponentType &comp)
{
    MsgProto *req = nullptr;
    int32_t length = 0;

    int32_t ret = AdxCommOptManager::Instance().Read(handle, reinterpret_cast<IdeRecvBuffT>(&req), length,
        COMM_OPT_NOBLOCK);
    if (ret == IDE_DAEMON_ERROR || req == nullptr || length <= 0) {
        IDE_LOGE("receive request failed ret %d, length(%d bytes)", ret, length);
        return false;
    }

    SharedPtr<MsgProto> msgPtr(req, IdeXfree);
    req = nullptr;
    if (msgPtr->sliceLen + sizeof(MsgProto) != (uint32_t)length) {
        IDE_LOGE("receive request package(%u bytes) length(%d bytes) exception", msgPtr->sliceLen, length);
        return false;
    }

    HDC_SESSION session = reinterpret_cast<HDC_SESSION>(handle.session);
    int32_t devId = -1;
    ret = IdeGetDevIdBySession(session, &devId);
    if (ret != IDE_DAEMON_OK || devId < 0 || devId > UINT16_MAX) {
        IDE_LOGE("get dev id by session fail, ret=%d", ret);
        return false;
    }
    msgPtr->devId = static_cast<uint16_t>(devId);

    IDE_LOGI("commopt type(%d), request type(%u), device id(%d)", static_cast<int32_t>(type_), msgPtr->reqType, devId);
    return DispatchComponent(handle, msgPtr, session, comp);
}

bool AdxServerManager::DispatchComponent(CommHandle &handle, SharedPtr<MsgProto> &msgPtr, HDC_SESSION session,
    ComponentType &comp)
{
    comp = GetComponentTypeByReqType(static_cast<CmdClassT>(msgPtr->reqType));
    auto it = compMap_.find(comp);
    if (it == compMap_.end()) {
        IDE_LOGE("Unable to find the corresponding component type(%d)", static_cast<int32_t>(comp));
        return false;
    }

    handle.comp = comp;
    if (handle.comp == ComponentType::COMPONENT_GETD_FILE || handle.comp == COMPONENT_LOG_LEVEL) {
        std::lock_guard<std::mutex> lck(linkMtx_);
        if (IsLinkOverload(session)) {
            return false;
        }
        linkNum_++;
    }
    std::string compInfo = it->second->GetInfo();
    IDE_LOGI("begin to process [%s] component", compInfo.c_str());
    if (it->second->Process(handle, msgPtr) != IDE_DAEMON_OK) {
        IDE_LOGE("end of processing [%s] component failed, req->type: %u", compInfo.c_str(), msgPtr->reqType);
    } else {
        IDE_LOGI("end of processing [%s] component successfully", compInfo.c_str());
    }
    if (handle.comp == ComponentType::COMPONENT_GETD_FILE || handle.comp == COMPONENT_LOG_LEVEL) {
        std::lock_guard<std::mutex> lck(linkMtx_);
        linkNum_--;
    }
    return true;
}

ComponentType AdxServerManager::GetComponentTypeByReqType(CmdClassT cmdType) const
{
    ComponentType cmptType = ComponentType::NR_COMPONENTS;
    for (uint32_t i = 0; i < ARRAY_LEN(g_componentsInfo, AdxComponentMap); i++) {
        if (cmdType == g_componentsInfo[i].cmdType) {
            cmptType = g_componentsInfo[i].cmptType;
            break;
        }
    }
    return cmptType;
}

void AdxServerManager::TimerProcess()
{
    std::vector<std::string> devLogIds;
    SharedPtr<AdxDevice> device = AdxCommOptManager::Instance().GetDevice(type_);
    if (device == nullptr) {
        return;
    }

    // initialize the devices on the first time(AdxCommOptManager is singleton object)
    // create HDC server on th enable device
    device->GetAllEnableDevices(loadMode_, deviceId_, devLogIds);
    std::map<std::string, std::string> info;
    info[OPT_SERVICE_KEY] = info_;
    for (const auto& deviceId : devLogIds) {
        auto server = servers_.find(deviceId);
        // filter the device that created HDC server(or not the specified device)
        if (server != servers_.end() || !(deviceId_ == -1 || std::to_string(deviceId_) == deviceId)) {
            continue;
        }

        IDE_LOGI("device up %s", deviceId.c_str());
        info[OPT_DEVICE_KEY] = deviceId;
        if (ServerInit(info)) {
            faultyDevices_.erase(deviceId);
            continue;
        }

        // record retry times of connection for the faulty device
        auto faultDevice = faultyDevices_.find(deviceId);
        if (faultDevice == faultyDevices_.end()) {
            faultyDevices_[deviceId] = 1;
            continue;
        }
        ++(faultDevice->second);
        if (faultDevice->second >= RECONNECT_TIMES) {
            faultyDevices_.erase(faultDevice);
            // set the device to disable if connection is timeout
            device->DisableNotify(deviceId);
        }
    }

    device->GetDisableDevices(devLogIds);
    for (const auto& deviceId : devLogIds) {
        auto server = servers_.find(deviceId);
        if (server == servers_.end()) {
            continue;
        }
        IDE_LOGI("device suspend %s", deviceId.c_str());
        if (ServerUnInit(server->second)) {
            servers_.erase(server);
        }
    }
    serverInittedFlag_ = true;
    AdxCommOptManager::Instance().Timer(type_);
}

int32_t AdxServerManager::Exit()
{
    serverInittedFlag_ = false;
    if (pid_ == mmGetPid()) { // not fork
        Terminate();
        // wait epoll wait timeout
        while (!waitOver_) {
            mmSleep(DEFAULT_EPOLL_TIMEOUT);
        }
    }

    // terminate the running components before close servers(close client sessions)
    for (auto& component : compMap_) {
        (void)component.second->Terminate();
    }

    // finalize the servers(delete epoll and close session)
    for (auto& server : servers_) {
        if (!ServerUnInit(server.second)) {
            return IDE_DAEMON_ERROR;
        }
    }
    servers_.clear();

    // finalize the components
    for (auto& component : compMap_) {
        (void)component.second->UnInit();
    }
    // make sure no longer use it in ComponentProcess/SubComponentProcess
    compMap_.clear();

    if (epoll_ != nullptr) {
        if (epoll_->EpollDestroy() != IDE_DAEMON_OK) {
            return IDE_DAEMON_ERROR;
        }
        epoll_ = nullptr;
    }
    return IDE_DAEMON_OK;
}

void AdxServerManager::SetMode(int32_t loadMode)
{
    loadMode_ = loadMode;
}

void AdxServerManager::SetDeviceId(int32_t deviceId)
{
    deviceId_ = deviceId;
}

bool AdxServerManager::IsLinkOverload(HDC_SESSION session) const
{
    const int32_t maxLinkNum = 16; // limit max links num is 16 at the same time
    if (linkNum_ >= maxLinkNum) {
        int32_t pid = -1;
        (void)IdeGetPidBySession(session, &pid);
        IDE_LOGE("server manager overload, pid: %d.", pid);
        return true;
    }
    return false;
}

bool AdxServerManager::WaitServerInitted() const
{
    // 最大等待60s，等待serverInittedFlag_为true，每等待一轮等待时间增加1毫秒
    const int32_t maxRetryTimes = 346; // 60s (1 + 2 + ... + 346)ms
    int32_t retryTime = 1;
    while (retryTime < maxRetryTimes) {
        if (serverInittedFlag_) {
            IDE_LOGI("The server is initialized after waiting %d times.", retryTime);
            return true;
        }
        mmSleep(retryTime);
        retryTime++;
    }

    if (retryTime >= maxRetryTimes) {
        IDE_LOGW("The server is not initialized after waiting %d times.", retryTime);
    }

    return false;
}
}
