/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "init_callback_manager.h"
#include "acl/acl_base.h"
#include "acl_rt_impl_base.h"

namespace acl {
namespace {
template <typename CallbackMapT, typename CallbackFuncT>
aclError UnregisterCallbackImpl(CallbackMapT &callbackMap, std::recursive_mutex &mutex,
                                aclRegisterCallbackType type, CallbackFuncT cbFunc)
{
    if (cbFunc == nullptr) {
        return ACL_ERROR_INVALID_PARAM;
    }
    std::lock_guard<std::recursive_mutex> lock(mutex);
    if (callbackMap.count(type) == 0U) {
        return ACL_ERROR_INTERNAL_ERROR;
    }
    const auto range = callbackMap.equal_range(type);
    for (auto it = range.first; it != range.second; ++it) {
        if (it->second.first == cbFunc) {
            (void)callbackMap.erase(it);
            return ACL_SUCCESS;
        }
    }
    return ACL_ERROR_INTERNAL_ERROR;
}

template <typename CallbackMapT, typename NotifyInvokerT>
aclError NotifyCallbackImpl(CallbackMapT &callbackMap, std::recursive_mutex &mutex,
                            aclRegisterCallbackType type, const NotifyInvokerT &notifyInvoker)
{
    std::lock_guard<std::recursive_mutex> lock(mutex);
    const auto range = callbackMap.equal_range(type);
    for (auto it = range.first; it != range.second; ++it) {
        const aclError ret = notifyInvoker(it->second);
        if (ret != ACL_SUCCESS) {
            return ret;
        }
    }
    return ACL_SUCCESS;
}
}  // namespace

InitCallbackManager &InitCallbackManager::GetInstance()
{
    // 单例模式上下文不做判空和捕获异常，内存分配失败这种极端情况让程序正常终止，比引入更复杂的错误处理逻辑更合理
    // 这里单例在堆上申请且内存不显式释放，是考虑到so卸载顺序的问题，延长单例的生命周期确保不引入异常
    static InitCallbackManager *instance = new InitCallbackManager();
    return *instance;
}

InitCallbackManager::InitCallbackManager(){}

aclError InitCallbackManager::RegInitCallback(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc, void *userData)
{
    if (cbFunc == nullptr) {
        return ACL_ERROR_INVALID_PARAM;
    }
    std::lock_guard<std::recursive_mutex> lock(mutex_);
    if (type != ACL_REG_TYPE_OTHER && initCallbackMap_.count(type) != 0U) {
        return ACL_ERROR_INTERNAL_ERROR;
    }
    initCallbackMap_.insert({type, {cbFunc, userData}});
    // 已经初始化的情况下，需要立即执行
    if (GetAclInitFlag()) {
        auto &configData = GetConfigPathStr();
        (void)cbFunc(configData.c_str(), configData.size(), userData);
    }
    return ACL_SUCCESS;
}

aclError InitCallbackManager::UnRegInitCallback(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc)
{
    return UnregisterCallbackImpl(initCallbackMap_, mutex_, type, cbFunc);
}

aclError InitCallbackManager::NotifyInitCallback(aclRegisterCallbackType type,
                                                 const char *configStr, size_t len)
{
    return NotifyCallbackImpl(initCallbackMap_, mutex_, type,
        [configStr, len](const std::pair<aclInitCallbackFunc, void *> &callbackEntry) {
            return callbackEntry.first(configStr, len, callbackEntry.second);
        });
}

aclError InitCallbackManager::RegFinalizeCallback(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc,
    void *userData)
{
    if (cbFunc == nullptr) {
        return ACL_ERROR_INVALID_PARAM;
    }
    std::lock_guard<std::recursive_mutex> lock(mutex_);
    if (type != ACL_REG_TYPE_OTHER && finalizeCallbackMap_.count(type) != 0U) {
        return ACL_ERROR_INTERNAL_ERROR;
    }
    finalizeCallbackMap_.insert({type, {cbFunc, userData}});
    return ACL_SUCCESS;
}

aclError InitCallbackManager::UnRegFinalizeCallback(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc)
{
    return UnregisterCallbackImpl(finalizeCallbackMap_, mutex_, type, cbFunc);
}

aclError InitCallbackManager::NotifyFinalizeCallback(aclRegisterCallbackType type)
{
    return NotifyCallbackImpl(finalizeCallbackMap_, mutex_, type,
        [](const std::pair<aclFinalizeCallbackFunc, void *> &callbackEntry) {
            return callbackEntry.first(callbackEntry.second);
        });
}
}  // namespace acl
