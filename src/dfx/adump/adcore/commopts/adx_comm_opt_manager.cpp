/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adx_comm_opt_manager.h"
#include "log/adx_log.h"
namespace Adx {
AdxCommOptManager::~AdxCommOptManager()
{
    std::unique_lock<std::mutex> lock {commOptMapMtx_};
    commOptMap_.clear();
}


bool AdxCommOptManager::CommOptsRegister(std::unique_ptr<AdxCommOpt> &opt)
{
    if (opt == nullptr) {
        return false;
    }

    std::unique_lock<std::mutex> lock {commOptMapMtx_};
    if (commOptMap_.find(opt->GetOptType()) == commOptMap_.end()) {
        commOptMap_[opt->GetOptType()] = std::move(opt);
    }
    return true;
}

CommHandle AdxCommOptManager::OpenServer(OptType type, const std::map<std::string, std::string> &info)
{
    std::shared_ptr<AdxCommOpt> currCommOpt(nullptr);
    {
        std::unique_lock<std::mutex> lock {commOptMapMtx_};
        auto it = commOptMap_.find(type);
        if (it != commOptMap_.end()) {
            currCommOpt = it->second;
        }
    }
    if (currCommOpt != nullptr) {
        OptHandle opHandle = currCommOpt->OpenServer(info);
        return {type, opHandle, NR_COMPONENTS, -1, nullptr};
    }

    IDE_LOGW("commopt(%d) not registered", static_cast<int32_t>(type));
    return ADX_COMMOPT_INVALID_HANDLE(type);
}

int32_t AdxCommOptManager::CloseServer(const CommHandle &handle) const
{
    std::shared_ptr<AdxCommOpt> currCommOpt(nullptr);
    {
        std::unique_lock<std::mutex> lock {commOptMapMtx_};
        auto it = commOptMap_.find(handle.type);
        if (it != commOptMap_.end()) {
            currCommOpt = it->second;
        }
    }
    if (currCommOpt != nullptr) {
        return currCommOpt->CloseServer(handle.session);
    }
    return IDE_DAEMON_OK;
}

CommHandle AdxCommOptManager::OpenClient(OptType type, const std::map<std::string, std::string> &info)
{
    std::shared_ptr<AdxCommOpt> currCommOpt(nullptr);
    {
        std::unique_lock<std::mutex> lock {commOptMapMtx_};
        auto it = commOptMap_.find(type);
        if (it != commOptMap_.end()) {
            currCommOpt = it->second;
        }
    }
    if (currCommOpt != nullptr) {
        OptHandle opHandle = currCommOpt->OpenClient(info);
        return {type, opHandle, NR_COMPONENTS, -1, nullptr};
    }

    return ADX_COMMOPT_INVALID_HANDLE(type);
}

int32_t AdxCommOptManager::CloseClient(CommHandle &handle) const
{
    std::shared_ptr<AdxCommOpt> currCommOpt(nullptr);
    {
        std::unique_lock<std::mutex> lock {commOptMapMtx_};
        auto it = commOptMap_.find(handle.type);
        if (it != commOptMap_.end()) {
            currCommOpt = it->second;
        }
    }
    if (currCommOpt != nullptr) {
        return currCommOpt->CloseClient(handle.session);
    }
    return IDE_DAEMON_OK;
}

CommHandle AdxCommOptManager::Accept(const CommHandle &handle) const
{
    std::shared_ptr<AdxCommOpt> currCommOpt(nullptr);
    {
        std::unique_lock<std::mutex> lock {commOptMapMtx_};
        auto it = commOptMap_.find(handle.type);
        if (it != commOptMap_.end()) {
            currCommOpt = it->second;
        }
    }
    if (currCommOpt != nullptr) {
        OptHandle opHandle = currCommOpt->Accept(handle.session);
        return {handle.type, opHandle, NR_COMPONENTS, -1, nullptr};
    }

    return ADX_COMMOPT_INVALID_HANDLE(handle.type);
}

CommHandle AdxCommOptManager::Connect(const CommHandle &handle, const std::map<std::string, std::string> &info)
{
    std::shared_ptr<AdxCommOpt> currCommOpt(nullptr);
    {
        std::unique_lock<std::mutex> lock {commOptMapMtx_};
        auto it = commOptMap_.find(handle.type);
        if (it != commOptMap_.end()) {
            currCommOpt = it->second;
        }
    }
    if (currCommOpt != nullptr) {
        OptHandle opHandle = currCommOpt->Connect(handle.session, info);
        return {handle.type, opHandle, NR_COMPONENTS, -1, nullptr};
    }

    return ADX_COMMOPT_INVALID_HANDLE(handle.type);
}

int32_t AdxCommOptManager::Close(CommHandle &handle) const
{
    std::shared_ptr<AdxCommOpt> currCommOpt(nullptr);
    {
        std::unique_lock<std::mutex> lock {commOptMapMtx_};
        auto it = commOptMap_.find(handle.type);
        if (it != commOptMap_.end()) {
            currCommOpt = it->second;
        }
    }
    if (currCommOpt != nullptr) {
        return currCommOpt->Close(handle.session);
    }
    return IDE_DAEMON_OK;
}

int32_t AdxCommOptManager::Write(const CommHandle &handle, IdeSendBuffT buffer, int32_t length, int32_t flag)
{
    std::shared_ptr<AdxCommOpt> currCommOpt(nullptr);
    {
        std::unique_lock<std::mutex> lock {commOptMapMtx_};
        auto it = commOptMap_.find(handle.type);
        if (it != commOptMap_.end()) {
            currCommOpt = it->second;
        }
    }
    if (currCommOpt != nullptr) {
        return currCommOpt->Write(handle.session, buffer, length, flag);
    }

    return -1;
}

int32_t AdxCommOptManager::Read(const CommHandle &handle, IdeRecvBuffT buffer, int32_t &length, int32_t flag)
{
    std::shared_ptr<AdxCommOpt> currCommOpt(nullptr);
    {
        std::unique_lock<std::mutex> lock {commOptMapMtx_};
        auto it = commOptMap_.find(handle.type);
        if (it != commOptMap_.end()) {
            currCommOpt = it->second;
        }
    }
    if (currCommOpt != nullptr) {
        return currCommOpt->Read(handle.session, buffer, length, flag);
    }

    return -1;
}

SharedPtr<AdxDevice> AdxCommOptManager::GetDevice(OptType type)
{
    std::shared_ptr<AdxCommOpt> currCommOpt(nullptr);
    {
        std::unique_lock<std::mutex> lock {commOptMapMtx_};
        auto it = commOptMap_.find(type);
        if (it != commOptMap_.end()) {
            currCommOpt = it->second;
        }
    }
    if (currCommOpt != nullptr) {
        return currCommOpt->GetDevice();
    }

    return nullptr;
}

void AdxCommOptManager::Timer(OptType type) const
{
    std::shared_ptr<AdxCommOpt> currCommOpt(nullptr);
    {
        std::unique_lock<std::mutex> lock {commOptMapMtx_};
        auto it = commOptMap_.find(type);
        if (it != commOptMap_.end()) {
            currCommOpt = it->second;
        }
    }
    if (currCommOpt != nullptr) {
        currCommOpt->Timer();
    }
}
}
