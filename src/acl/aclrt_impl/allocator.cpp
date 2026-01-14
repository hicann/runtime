/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <memory>
#include <mutex>
#include <map>
#include "common/prof_reporter.h"
#include "common/log_inner.h"
#include "acl_rt_impl.h"
#include "common/resource_statistics.h"

namespace {
class AllocatorDesc {
public:
    AllocatorDesc() = default;
    ~AllocatorDesc() = default;
    AllocatorDesc(aclrtAllocator allocator,
                  aclrtAllocatorAllocFunc allocFunc,
                  aclrtAllocatorFreeFunc freeFunc,
                  aclrtAllocatorAllocAdviseFunc allocAdviseFunc,
                  aclrtAllocatorGetAddrFromBlockFunc getAddrFromBlockFunc)
    {
        this->obj = allocator;
        this->allocFunc = allocFunc;
        this->freeFunc = freeFunc;
        this->allocAdviseFunc = allocAdviseFunc;
        this->getAddrFromBlockFunc = getAddrFromBlockFunc;
    }
    aclrtAllocator obj;
    aclrtAllocatorAllocFunc allocFunc;
    aclrtAllocatorFreeFunc freeFunc;
    aclrtAllocatorAllocAdviseFunc allocAdviseFunc;
    aclrtAllocatorGetAddrFromBlockFunc getAddrFromBlockFunc;
};
std::mutex g_AllocatorDescMutex;
// The first aclrtAllocatorDesc is created by the user, while the second AllocatorDesc is a saved copy.
std::map<aclrtStream, std::pair<aclrtAllocatorDesc, AllocatorDesc>> g_AllocatorDesMap;
}

aclrtAllocatorDesc aclrtAllocatorCreateDescImpl()
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtAllocatorCreateDesc);
    ACL_ADD_APPLY_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_ALLOCATOR_DESC);
    ACL_LOG_INFO("Create allocator description.");
    AllocatorDesc *allocatorDesc = new(std::nothrow) AllocatorDesc;
    if (allocatorDesc == nullptr) {
        ACL_LOG_INNER_ERROR("alloc AllocatorDesc memory failed");
        return nullptr;
    }
    ACL_ADD_APPLY_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_ALLOCATOR_DESC);
    return static_cast<aclrtAllocatorDesc>(allocatorDesc);
}

aclError aclrtAllocatorDestroyDescImpl(aclrtAllocatorDesc allocatorDesc)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtAllocatorDestroyDesc);
    ACL_LOG_INFO("Destroy allocator description, allocatorDesc %p.", allocatorDesc);
    ACL_ADD_RELEASE_TOTAL_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_ALLOCATOR_DESC);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(allocatorDesc);
    delete static_cast<AllocatorDesc *>(allocatorDesc);
    allocatorDesc = nullptr;
    ACL_ADD_RELEASE_SUCCESS_COUNT(acl::ACL_STATISTICS_CREATE_DESTROY_ALLOCATOR_DESC);
    return ACL_SUCCESS;
}

aclError aclrtAllocatorSetObjToDescImpl(aclrtAllocatorDesc allocatorDesc, aclrtAllocator allocator)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(allocatorDesc);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(allocator);
    ACL_LOG_INFO("Set allocator to allocator description, allocatorDesc %p.", allocatorDesc);
    static_cast<AllocatorDesc *>(allocatorDesc)->obj = allocator;
    return ACL_SUCCESS;
}

aclError aclrtAllocatorSetAllocFuncToDescImpl(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorAllocFunc func)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(allocatorDesc);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(func);
    ACL_LOG_INFO("Set alloc function to allocator description, allocatorDesc %p.", allocatorDesc);
    static_cast<AllocatorDesc *>(allocatorDesc)->allocFunc = func;
    return ACL_SUCCESS;
}

aclError aclrtAllocatorSetFreeFuncToDescImpl(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorFreeFunc func)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(allocatorDesc);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(func);
    ACL_LOG_INFO("Set free function to allocator description, allocatorDesc %p.", allocatorDesc);
    static_cast<AllocatorDesc *>(allocatorDesc)->freeFunc = func;
    return ACL_SUCCESS;
}

aclError aclrtAllocatorSetAllocAdviseFuncToDescImpl(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorAllocAdviseFunc func)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(allocatorDesc);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(func);
    ACL_LOG_INFO("Set alloc advise function to allocator description, allocatorDesc %p.", allocatorDesc);
    static_cast<AllocatorDesc *>(allocatorDesc)->allocAdviseFunc = func;
    return ACL_SUCCESS;
}

aclError aclrtAllocatorSetGetAddrFromBlockFuncToDescImpl(aclrtAllocatorDesc allocatorDesc,
                                                     aclrtAllocatorGetAddrFromBlockFunc func)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(allocatorDesc);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(func);
    ACL_LOG_INFO("Set get_addr_from_block function to allocator description, allocatorDesc %p.", allocatorDesc);
    static_cast<AllocatorDesc *>(allocatorDesc)->getAddrFromBlockFunc = func;
    return ACL_SUCCESS;
}

aclError aclrtAllocatorRegisterImpl(aclrtStream stream, aclrtAllocatorDesc allocatorDesc)
{
    // stream must be not null when register external allocator
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(allocatorDesc);

    AllocatorDesc *allocDesc = static_cast<AllocatorDesc *>(allocatorDesc);
    if (allocDesc->obj == nullptr) {
        ACL_LOG_INNER_ERROR("Should call aclrtAllocatorSetObjToDesc first.");
        return ACL_ERROR_INVALID_PARAM;
    }
    if (allocDesc->allocFunc == nullptr) {
        ACL_LOG_INNER_ERROR("Should call aclrtAllocatorSetAllocFuncToDesc first.");
        return ACL_ERROR_INVALID_PARAM;
    }
    if (allocDesc->freeFunc == nullptr) {
        ACL_LOG_INNER_ERROR("Should call aclrtAllocatorSetFreeFuncToDesc first.");
        return ACL_ERROR_INVALID_PARAM;
    }
    if (allocDesc->getAddrFromBlockFunc == nullptr) {
        ACL_LOG_INNER_ERROR("Should call aclrtAllocatorSetGetAddrFromBlockFuncToDesc first.");
        return ACL_ERROR_INVALID_PARAM;
    }
    AllocatorDesc allocDescCopy = AllocatorDesc(allocDesc->obj,
                                                allocDesc->allocFunc,
                                                allocDesc->freeFunc,
                                                allocDesc->allocAdviseFunc,
                                                allocDesc->getAddrFromBlockFunc);
    std::pair<aclrtAllocatorDesc, AllocatorDesc> allocatorDescPair(allocatorDesc, allocDescCopy);
    const std::unique_lock<std::mutex> lk(g_AllocatorDescMutex);
    g_AllocatorDesMap[stream] = allocatorDescPair;
    ACL_LOG_INFO("Register external allocator success, stream %p, allocatorDesc %p.", stream, allocatorDesc);
    return ACL_SUCCESS;
}

aclError aclrtAllocatorGetByStreamImpl(aclrtStream stream,
                                   aclrtAllocatorDesc *allocatorDesc,
                                   aclrtAllocator *allocator,
                                   aclrtAllocatorAllocFunc *allocFunc,
                                   aclrtAllocatorFreeFunc *freeFunc,
                                   aclrtAllocatorAllocAdviseFunc *allocAdviseFunc,
                                   aclrtAllocatorGetAddrFromBlockFunc *getAddrFromBlockFunc)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(allocatorDesc);
    const std::unique_lock<std::mutex> lk(g_AllocatorDescMutex);
    const auto iter = g_AllocatorDesMap.find(stream);
    if (iter == g_AllocatorDesMap.end()) {
        return ACL_ERROR_INVALID_PARAM;
    }
    *allocatorDesc = iter->second.first;
    AllocatorDesc &desc = iter->second.second;
    if (allocator != nullptr) {
        *allocator = desc.obj;
    }
    if (allocFunc != nullptr) {
        *allocFunc = desc.allocFunc;
    }
    if (freeFunc != nullptr) {
        *freeFunc = desc.freeFunc;
    }
    if (allocAdviseFunc != nullptr) {
        *allocAdviseFunc = desc.allocAdviseFunc;
    }
    if (getAddrFromBlockFunc != nullptr) {
        *getAddrFromBlockFunc = desc.getAddrFromBlockFunc;
    }
    ACL_LOG_INFO("Get allocator By Stream success, stream %p.", stream);
    return ACL_SUCCESS;
}

aclError aclrtAllocatorUnregisterImpl(aclrtStream stream)
{
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);
    const std::unique_lock<std::mutex> lk(g_AllocatorDescMutex);
    g_AllocatorDesMap.erase(stream);
    ACL_LOG_INFO("Unregister external allocator success, stream %p.", stream);
    return ACL_SUCCESS;
}
