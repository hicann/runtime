/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "mstx_domain_mgr.h"
#include "msprof_dlog.h"
#include "errno/error_code.h"
#include "utils/utils.h"
#include "transport/hash_data.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::transport;

namespace Collector {
namespace Dvvp {
namespace Mstx {

std::map<mstxDomainHandle_t, std::shared_ptr<mstxDomainAttr>> MstxDomainMgr::domainHandleMap_;

mstxDomainHandle_t MstxDomainMgr::CreateDomainHandle(const char* name)
{
    if (strcmp("default", name) == 0) {
        MSPROF_LOGE("domain name can not be 'default'!");
        return nullptr;
    }
    std::lock_guard<std::mutex> lk(domainHandleMutex_);
    if (domainHandleMap_.size() > MARK_MAX_CACHE_NUM) {
        MSPROF_LOGE("Cache domain name failed, current size: %u, limit size: %u",
            domainHandleMap_.size(), MARK_MAX_CACHE_NUM);
        return nullptr;
    }
    std::string nameStr(name);
    uint64_t hashId = HashData::instance()->GenHashId(nameStr);
    for (const auto &iter : domainHandleMap_) {
        if (iter.second->nameHash == hashId) {
            return iter.first;
        }
    }
    SHARED_PTR_ALIA<mstxDomainAttr> domainAttrPtr;
    MSVP_MAKE_SHARED0(domainAttrPtr, mstxDomainAttr, return nullptr);
    if (domainAttrPtr == nullptr) {
        MSPROF_LOGE("Failed to malloc for domain attr for %s", name);
        return nullptr;
    }
    MSVP_MAKE_SHARED0(domainAttrPtr->handle, MstxDomainHandle, return nullptr);
    if (domainAttrPtr->handle == nullptr) {
        MSPROF_LOGE("Failed to malloc for domain handle for %s", name);
        return nullptr;
    }
    domainAttrPtr->nameHash = hashId;
    domainAttrPtr->enabled = IsDomainEnabled(hashId);
    domainHandleMap_.insert(std::make_pair(domainAttrPtr->handle.get(), domainAttrPtr));
    return domainAttrPtr->handle.get();
}

void MstxDomainMgr::DestroyDomainHandle(mstxDomainHandle_t domain)
{
    std::lock_guard<std::mutex> lk(domainHandleMutex_);
    domainHandleMap_.erase(domain);
}

bool MstxDomainMgr::GetDomainNameHashByHandle(mstxDomainHandle_t domain, uint64_t &name)
{
    std::lock_guard<std::mutex> lk(domainHandleMutex_);
    auto iter = domainHandleMap_.find(domain);
    if (iter == domainHandleMap_.end()) {
        MSPROF_LOGW("input domain is invalid");
        return false;
    }
    name = iter->second->nameHash;
    return true;
}

uint64_t MstxDomainMgr::GetDefaultDomainNameHash()
{
    static uint64_t defaultDomainNameHash = HashData::instance()->GenHashId("default");
    return defaultDomainNameHash;
}

bool MstxDomainMgr::IsDomainEnabled(const uint64_t &domainNameHash)
{
    if (!domainSet_.load()) {
        return true;
    }
    if (domainSetting_.domainInclude) {
        return domainSetting_.setDomains_.count(domainNameHash) != 0;
    } else {
        return domainSetting_.setDomains_.count(domainNameHash) == 0;
    }
}

void MstxDomainMgr::SetMstxDomainsEnabled(const std::string &mstxDomainInclude,
    const std::string &mstxDomainExclude)
{
    // reset these params in case that repeat prof with different switches in one process;
    domainSet_.store(false);
    domainSetting_.domainInclude = false;
    domainSetting_.setDomains_.clear();

    if (!mstxDomainInclude.empty() && !mstxDomainExclude.empty()) {
        MSPROF_LOGW("mstx domain include and exclude are both set at the same time");
        return;
    }
    std::vector<std::string> setDomains;
    if (!mstxDomainInclude.empty()) {
        domainSetting_.domainInclude = true;
        setDomains = Utils::Split(mstxDomainInclude, false, "", ",");
        for (auto &domain : setDomains) {
            domainSetting_.setDomains_.insert(HashData::instance()->GenHashId(domain));
        }
    } else if (!mstxDomainExclude.empty()) {
        domainSetting_.domainInclude = false;
        setDomains = Utils::Split(mstxDomainExclude, false, "", ",");
        for (auto &domain : setDomains) {
            domainSetting_.setDomains_.insert(HashData::instance()->GenHashId(domain));
        }
    } else {
        MSPROF_LOGI("neither mstx domain include nor exclude is set");
        return;
    }
    std::lock_guard<std::mutex> lk(domainHandleMutex_);
    for (auto &domainHandle : domainHandleMap_) {
        domainHandle.second->enabled = (domainSetting_.setDomains_.count(domainHandle.second->nameHash) > 0) ?
            domainSetting_.domainInclude : !domainSetting_.domainInclude;
    }
    domainSet_.store(true);
}

}
}
}