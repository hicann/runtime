/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSTX_DOMAIN_MGR_H
#define MSTX_DOMAIN_MGR_H

#include <atomic>
#include <map>
#include <memory>
#include <mutex>
#include <unordered_set>
#include "singleton/singleton.h"
#include "mstx_def.h"

namespace Collector {
namespace Dvvp {
namespace Mstx {

constexpr uint32_t MARK_MAX_CACHE_NUM = std::numeric_limits<uint32_t>::max();

struct mstxDomainAttr {
    mstxDomainAttr() = default;
    ~mstxDomainAttr() = default;

    std::shared_ptr<MstxDomainHandle> handle{nullptr};
    uint64_t nameHash{0};

    // true by default;
    // will set to false if this domain in mstx domain exclude or not in mstx domain include
    bool enabled{true};
};

class MstxDomainMgr : public analysis::dvvp::common::singleton::Singleton<MstxDomainMgr> {
public:
    MstxDomainMgr() = default;
    ~MstxDomainMgr() = default;

    mstxDomainHandle_t CreateDomainHandle(const char* name);
    void DestroyDomainHandle(mstxDomainHandle_t domain);
    bool GetDomainNameHashByHandle(mstxDomainHandle_t domain, uint64_t &name);
    uint64_t GetDefaultDomainNameHash();
    void SetMstxDomainsEnabled(const std::string &mstxDomainInclude, const std::string &mstxDomainExclude);
    bool IsDomainEnabled(const uint64_t &domainNameHash);

private:
    struct mstxDomainSetting {
        mstxDomainSetting() = default;
        ~mstxDomainSetting() = default;

        // true if set mstx domain include;
        // false if set mstx domain exclude
        bool domainInclude{false};
        std::unordered_set<uint64_t> setDomains_;
    };

    // domainHandle, domainAttr
    static std::map<mstxDomainHandle_t, std::shared_ptr<mstxDomainAttr>> domainHandleMap_;
    std::mutex domainHandleMutex_;

    // save mstx domain include/exclude setting
    std::atomic<bool> domainSet_{false};
    mstxDomainSetting domainSetting_;
};
}
}
}
#endif
