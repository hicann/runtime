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
constexpr uint32_t MAX_PROCESS_DRAIN_TIMEOUT = 5000U; // max 5s to wait the process threads over
constexpr uint32_t FIRST_REQUEST_MAX_RETRY_TIMES = 142U;
constexpr uint32_t FIRST_REQUEST_TIMEOUT_MS = (FIRST_REQUEST_MAX_RETRY_TIMES - 1U) * FIRST_REQUEST_MAX_RETRY_TIMES / 2U;
} // namespace

AdxServerManager::AdxServerManager() noexcept
    : pid_(0),
      loadMode_(0),
      deviceId_(-1),
      type_(OptType::NR_COMM),
      info_(""),
      epoll_(nullptr),
      linkNum_(0),
      processingNum_(0)
{
    servers_.clear();
}

AdxServerManager::AdxServerManager(int32_t loadMode, int32_t deviceId) noexcept
    : pid_(0),
      loadMode_(loadMode),
      deviceId_(deviceId),
      type_(OptType::NR_COMM),
      info_(""),
      epoll_(nullptr),
      linkNum_(0),
      processingNum_(0)
{
    servers_.clear();
}

AdxServerManager::~AdxServerManager() { (void)Exit(); }

bool AdxServerManager::RegisterEpoll(std::unique_ptr<AdxEpoll>& epoll)
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

bool AdxServerManager::RegisterCommOpt(std::unique_ptr<AdxCommOpt>& opt, const std::string& info)
{
    if (opt == nullptr) {
        IDE_LOGE("register commopt input error");
        return false;
    }

    info_ = info;
    type_ = opt->GetOptType();
    return AdxCommOptManager::Instance().CommOptsRegister(opt);
}

bool AdxServerManager::ServerInit(const std::map<std::string, std::string>& info)
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

bool AdxServerManager::ComponentAdd(std::unique_ptr<AdxComponent>& comp)
{
    if (comp == nullptr) {
        IDE_LOGE("add component input error");
        return false;
    }

    const ComponentType type = comp->GetType();
    std::lock_guard<std::mutex> lck(compMtx_);
    auto it = compMap_.find(type);
    if (it != compMap_.end()) {
        return false;
    }
    IDE_LOGI("server manager add component (%d)", static_cast<int32_t>(type));
    compMap_[type] = std::shared_ptr<AdxComponent>(std::move(comp));
    return true;
}

bool AdxServerManager::ComponentErase(ComponentType type)
{
    std::lock_guard<std::mutex> lck(compMtx_);
    auto it = compMap_.find(type);
    if (it == compMap_.end()) {
        return false;
    }
    IDE_LOGI("server manager erase component (%d)", type);
    (void)compMap_.erase(type);
    return (compMap_.count(type) == 0);
}

std::shared_ptr<AdxComponent> AdxServerManager::GetComponent(ComponentType type) const
{
    std::lock_guard<std::mutex> lck(compMtx_);
    auto it = compMap_.find(type);
    return (it == compMap_.end()) ? nullptr : it->second;
}

bool AdxServerManager::ComponentInit() const
{
    if (epoll_ == nullptr) {
        return false;
    }

    // Snapshot under lock, call Init() outside to avoid re-entering compMtx_(eg: LibLoadServerInit)
    std::vector<std::shared_ptr<AdxComponent>> snapshot;
    {
        std::lock_guard<std::mutex> lck(compMtx_);
        snapshot.reserve(compMap_.size());
        for (const auto& item : compMap_) {
            snapshot.push_back(item.second);
        }
    }
    for (auto& component : snapshot) {
        (void)component->Init();
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
    PendingRequest request{
        conHandle.session, RequestClock::now() + std::chrono::milliseconds(FIRST_REQUEST_TIMEOUT_MS)};
    ProcessRequest(request);
}

bool AdxServerManager::WaitRequest(const PendingRequest& request)
{
    if (waitingRequests_.size() >= MAX_WAITING_REQUESTS) {
        IDE_LOGW("too many connections waiting for a request");
        return false;
    }

    auto result = waitingRequests_.emplace(request.handle, request);
    if (!result.second) {
        IDE_LOGW("request is already waiting, handle: %lx", request.handle);
        return false;
    }
    EpollEvent event{ADX_EPOLL_DATA_IN | ADX_EPOLL_HANG_UP, request.handle};
    if (epoll_->EpollAdd(request.handle, event) != IDE_DAEMON_OK) {
        waitingRequests_.erase(result.first);
        return false;
    }
    return true;
}

void AdxServerManager::ProcessRequest(const PendingRequest& request)
{
    CommHandle handle{type_, request.handle, NR_COMPONENTS, -1, nullptr};
    if (request.deadline <= RequestClock::now()) {
        (void)AdxCommOptManager::Instance().Close(handle);
        return;
    }

    SharedPtr<MsgProto> msgPtr;
    ComponentType comp = ComponentType::NR_COMPONENTS;
    const PrepareResult prepareResult = PrepareComponentProcess(handle, msgPtr, comp);
    if (prepareResult == PrepareResult::RETRY) {
        if (!WaitRequest(request)) {
            (void)AdxCommOptManager::Instance().Close(handle);
        }
        return;
    }
    if (prepareResult == PrepareResult::FAILED || !LaunchComponentProcess(handle, msgPtr, comp)) {
        (void)AdxCommOptManager::Instance().Close(handle);
    }
}

void AdxServerManager::HandleDataEvent(EpollHandle handle)
{
    auto it = waitingRequests_.find(handle);
    if (it == waitingRequests_.end()) {
        return;
    }

    EpollEvent event{ADX_EPOLL_DATA_IN | ADX_EPOLL_HANG_UP, handle};
    if (epoll_->EpollDel(handle, event) != IDE_DAEMON_OK) {
        CommHandle failedHandle{type_, handle, NR_COMPONENTS, -1, nullptr};
        (void)AdxCommOptManager::Instance().Close(failedHandle);
        waitingRequests_.erase(it);
        return;
    }

    const PendingRequest request = it->second;
    waitingRequests_.erase(it);
    ProcessRequest(request);
}

void AdxServerManager::HandleHangUpEvent(EpollHandle handle)
{
    auto it = waitingRequests_.find(handle);
    if (it == waitingRequests_.end()) {
        return;
    }

    EpollEvent event{ADX_EPOLL_DATA_IN | ADX_EPOLL_HANG_UP, handle};
    (void)epoll_->EpollDel(handle, event);
    CommHandle closedHandle{type_, handle, NR_COMPONENTS, -1, nullptr};
    (void)AdxCommOptManager::Instance().Close(closedHandle);
    waitingRequests_.erase(it);
}

void AdxServerManager::CloseExpiredRequests()
{
    const auto now = RequestClock::now();
    auto it = waitingRequests_.begin();
    while (it != waitingRequests_.end()) {
        if (it->second.deadline > now) {
            ++it;
            continue;
        }
        const EpollHandle handle = it->first;
        EpollEvent event{ADX_EPOLL_DATA_IN | ADX_EPOLL_HANG_UP, handle};
        (void)epoll_->EpollDel(handle, event);
        IDE_LOGW("no request received before timeout, handle: %lx", handle);
        CommHandle expiredHandle{type_, handle, NR_COMPONENTS, -1, nullptr};
        (void)AdxCommOptManager::Instance().Close(expiredHandle);
        it = waitingRequests_.erase(it);
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
        CloseExpiredRequests();
        TimerProcess();
        int32_t handles = epoll_->EpollWait(events, epollSize, DEFAULT_EPOLL_TIMEOUT);
        for (int32_t i = 0; i < handles && i < epollSize; i++) {
            IDE_LOGI("sock EpollWait accept event %d", handles);
            const bool waitingRequest = waitingRequests_.find(events[i].data) != waitingRequests_.end();
            if (waitingRequest && ((events[i].events & ADX_EPOLL_DATA_IN) != 0)) {
                IDE_LOGI("data in");
                HandleDataEvent(events[i].data);
            } else if (waitingRequest && ((events[i].events & ADX_EPOLL_HANG_UP) != 0)) {
                IDE_LOGW("hang up state");
                HandleHangUpEvent(events[i].data);
            } else if ((events[i].events & ADX_EPOLL_CONN_IN) != 0) {
                IDE_LOGI("sock connect EpollWait event %d", handles);
                CommHandle handle = {type_, events[i].data, NR_COMPONENTS, -1, nullptr};
                HandleConnectEvent(handle);
            } else if ((events[i].events & ADX_EPOLL_DATA_IN) != 0) {
                IDE_LOGI("data in");
                HandleDataEvent(events[i].data);
            } else if ((events[i].events & ADX_EPOLL_HANG_UP) != 0) {
                IDE_LOGW("hang up state");
                HandleHangUpEvent(events[i].data);
            } else {
                IDE_LOGW("other epoll state");
                epoll_->EpollErrorHandle();
            }
        }
        if (handles < 0) {
            epoll_->EpollErrorHandle();
        }
    }

    CloseWaitingRequests();
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

AdxServerManager::PrepareResult AdxServerManager::PrepareComponentProcess(
    CommHandle& handle, SharedPtr<MsgProto>& msgPtr, ComponentType& comp)
{
    MsgProto* req = nullptr;
    int32_t length = 0;
    int32_t ret = AdxCommOptManager::Instance().TryRead(handle, reinterpret_cast<IdeRecvBuffT>(&req), length);
    if (req != nullptr) {
        msgPtr = SharedPtr<MsgProto>(req, IdeXfree);
        req = nullptr;
    }
    if (ret == IDE_DAEMON_RECV_NODATA) {
        return PrepareResult::RETRY;
    }
    if (ret != IDE_DAEMON_OK || msgPtr == nullptr || length < static_cast<int32_t>(sizeof(MsgProto))) {
        IDE_LOGE("receive request failed ret %d, length(%d bytes)", ret, length);
        return PrepareResult::FAILED;
    }

    const uint32_t payloadLength = static_cast<uint32_t>(length) - sizeof(MsgProto);
    if (msgPtr->sliceLen != payloadLength) {
        IDE_LOGE("receive request package(%u bytes) length(%d bytes) exception", msgPtr->sliceLen, length);
        return PrepareResult::FAILED;
    }

    HDC_SESSION session = reinterpret_cast<HDC_SESSION>(handle.session);
    int32_t devId = -1;
    ret = IdeGetDevIdBySession(session, &devId);
    if (ret != IDE_DAEMON_OK || devId < 0 || devId > UINT16_MAX) {
        IDE_LOGE("get dev id by session fail, ret=%d", ret);
        return PrepareResult::FAILED;
    }
    msgPtr->devId = static_cast<uint16_t>(devId);
    comp = GetComponentTypeByReqType(static_cast<CmdClassT>(msgPtr->reqType));
    IDE_LOGI("commopt type(%d), request type(%u), device id(%d)", static_cast<int32_t>(type_), msgPtr->reqType, devId);
    return PrepareResult::SUCCESS;
}

bool AdxServerManager::AcquireComponentLink(ComponentType comp, HDC_SESSION session)
{
    if (comp != ComponentType::COMPONENT_GETD_FILE && comp != ComponentType::COMPONENT_LOG_LEVEL) {
        return true;
    }

    std::lock_guard<std::mutex> lck(linkMtx_);
    if (IsLinkOverload(session)) {
        return false;
    }
    ++linkNum_;
    return true;
}

void AdxServerManager::ReleaseComponentLink(ComponentType comp)
{
    if (comp != ComponentType::COMPONENT_GETD_FILE && comp != ComponentType::COMPONENT_LOG_LEVEL) {
        return;
    }

    std::lock_guard<std::mutex> lck(linkMtx_);
    if (linkNum_ > 0) {
        --linkNum_;
    }
}

bool AdxServerManager::LaunchComponentProcess(CommHandle& handle, SharedPtr<MsgProto>& msgPtr, ComponentType comp)
{
    const std::shared_ptr<AdxComponent> component = GetComponent(comp);
    if (component == nullptr) {
        IDE_LOGE("Unable to find the corresponding component type(%d)", static_cast<int32_t>(comp));
        return false;
    }

    handle.comp = comp;
    const HDC_SESSION session = reinterpret_cast<HDC_SESSION>(handle.session);
    if (!AcquireComponentLink(comp, session)) {
        return false;
    }

    AdxCommHandle processHandle = static_cast<AdxCommHandle>(IdeXmalloc(sizeof(CommHandle)));
    if (processHandle == nullptr) {
        ReleaseComponentLink(comp);
        return false;
    }
    *processHandle = handle;

    std::unique_ptr<ProcessTask> task(new (std::nothrow) ProcessTask{this, processHandle, msgPtr, comp, true});
    if (task == nullptr) {
        IDE_XFREE_AND_SET_NULL(processHandle);
        ReleaseComponentLink(comp);
        return false;
    }

    mmUserBlock_t funcBlock;
    funcBlock.procFunc = AdxServerManager::ProcessTaskThread;
    funcBlock.pulArg = task.get();
    mmThread tid = 0;
    {
        std::lock_guard<std::mutex> lck(processMtx_);
        ++processingNum_;
    }
    const int32_t ret = Thread::CreateDetachTask(tid, funcBlock);
    if (ret != EN_OK) {
        {
            std::lock_guard<std::mutex> lck(processMtx_);
            --processingNum_;
            processCv_.notify_all();
        }
        IDE_XFREE_AND_SET_NULL(task->handle);
        ReleaseComponentLink(comp);
        return false;
    }
    task.release();
    return true;
}

void AdxServerManager::RunProcessTask(ProcessTask& task)
{
    const std::shared_ptr<void> processGuard(nullptr, [this](void*) {
        std::lock_guard<std::mutex> lck(this->processMtx_);
        if (this->processingNum_ > 0U) {
            --this->processingNum_;
        }
        this->processCv_.notify_all();
    });

    std::unique_ptr<CommHandle, decltype(&IdeXfree)> handleGuard(task.handle, IdeXfree);

    const std::shared_ptr<AdxComponent> component = GetComponent(task.comp);
    bool processSuccess = false;
    if (component != nullptr && task.handle != nullptr) {
        const std::string compInfo = component->GetInfo();
        IDE_LOGI("begin to process [%s] component", compInfo.c_str());
        if (component->Process(*task.handle, task.msgPtr) != IDE_DAEMON_OK) {
            IDE_LOGE("end of processing [%s] component failed, req->type: %u", compInfo.c_str(), task.msgPtr->reqType);
        } else {
            processSuccess = true;
            IDE_LOGI("end of processing [%s] component successfully", compInfo.c_str());
        }
    }

    const bool persistentComponent =
        (task.comp == ComponentType::COMPONENT_LOG_BACKHAUL) || (task.comp == ComponentType::COMPONENT_TRACE) ||
        (task.comp == ComponentType::COMPONENT_SYS_REPORT) || (task.comp == ComponentType::COMPONENT_FILE_REPORT) ||
        (task.comp == ComponentType::COMPONENT_CPU_DETECT);
    if (!persistentComponent || !processSuccess) {
        if (task.handle != nullptr) {
            (void)AdxCommOptManager::Instance().Close(*task.handle);
            task.handle->session = ADX_OPT_INVALID_HANDLE;
        }
    } else {
        // Persistent components retain the handle through their session store.
        (void)handleGuard.release();
    }
    task.handle = nullptr;
    if (task.linkAcquired) {
        ReleaseComponentLink(task.comp);
    }
}

IdeThreadArg AdxServerManager::ProcessTaskThread(IdeThreadArg arg)
{
    if (arg == nullptr) {
        return nullptr;
    }
    std::unique_ptr<ProcessTask> task(static_cast<ProcessTask*>(arg));
    task->manager->RunProcessTask(*task);
    return nullptr;
}

void AdxServerManager::CloseWaitingRequests()
{
    for (const auto& item : waitingRequests_) {
        EpollEvent event{ADX_EPOLL_DATA_IN | ADX_EPOLL_HANG_UP, item.first};
        if (epoll_ != nullptr) {
            (void)epoll_->EpollDel(item.first, event);
        }
        CommHandle handle{type_, item.first, NR_COMPONENTS, -1, nullptr};
        (void)AdxCommOptManager::Instance().Close(handle);
    }
    waitingRequests_.clear();
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

    std::lock_guard<std::mutex> lck(serverMtx_);
    for (const auto& deviceId : devLogIds) {
        // filter the device that created HDC server(or not the specified device)
        if (servers_.find(deviceId) != servers_.end() || !(deviceId_ == -1 || std::to_string(deviceId_) == deviceId)) {
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
        // Stop the manager thread: Terminate stops accepting new client sessions
        Terminate();
        // Confirm the thread exited
        while (!waitOver_) {
            mmSleep(DEFAULT_EPOLL_TIMEOUT);
        }
    }

    // Stop the components: UnInit stops processing new client sessions,
    // then Terminate closes blocking client sessions
    std::vector<std::shared_ptr<AdxComponent>> stopSnapshot;
    {
        std::lock_guard<std::mutex> lck(compMtx_);
        stopSnapshot.reserve(compMap_.size());
        for (auto& item : compMap_) {
            stopSnapshot.push_back(item.second);
        }
    }
    for (auto& component : stopSnapshot) {
        (void)component->UnInit();
        (void)component->Terminate();
    }

    // Wait the client session threads over, they are still using the components and the sessions
    WaitProcessDrained();

    // Finalize the servers(delete epoll and close the listening handle)
    int32_t serverRet = IDE_DAEMON_OK;
    {
        std::lock_guard<std::mutex> lck(serverMtx_);
        auto it = servers_.begin();
        while (it != servers_.end()) {
            if (ServerUnInit(it->second)) {
                it = servers_.erase(it);
            } else {
                serverRet = IDE_DAEMON_ERROR;
                ++it;
            }
        }
    }
    if (serverRet != IDE_DAEMON_OK) {
        return serverRet;
    }

    // Clear the registered components. shared_ptr(not unique_ptr) is required here: on drain
    // timeout the straggler thread still holds its reference and destroys the component itself
    {
        std::lock_guard<std::mutex> lck(compMtx_);
        compMap_.clear();
    }

    if (epoll_ != nullptr) {
        if (epoll_->EpollDestroy() != IDE_DAEMON_OK) {
            return IDE_DAEMON_ERROR;
        }
        epoll_ = nullptr;
    }
    return IDE_DAEMON_OK;
}

void AdxServerManager::WaitProcessDrained()
{
    std::unique_lock<std::mutex> lck(processMtx_);
    if (!processCv_.wait_for(lck, std::chrono::milliseconds(MAX_PROCESS_DRAIN_TIMEOUT), [this]() {
            return this->processingNum_ == 0U;
        })) {
        IDE_LOGW(
            "still have %u component process threads running after waiting %ums", processingNum_,
            MAX_PROCESS_DRAIN_TIMEOUT);
    }
}

void AdxServerManager::SetMode(int32_t loadMode) { loadMode_ = loadMode; }

void AdxServerManager::SetDeviceId(int32_t deviceId) { deviceId_ = deviceId; }

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
} // namespace Adx
