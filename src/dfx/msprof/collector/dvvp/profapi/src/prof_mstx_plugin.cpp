/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_mstx_plugin.h"
#include <vector>
#include <atomic>
#include <mutex>
#include <unordered_map>
#include <array>
#include "prof_load_api.h"
#include "msprof_dlog.h"

namespace {
template <typename T, size_t N>
constexpr size_t LengthOf(T (&)[N]) noexcept
{
    return N;
}
} // namespace

namespace ProfApi {
namespace MstxPlugin {
struct MstxContext_t {
    MstxGetModuleFuncTableFunc getModuleFuncTable;

    MstxMarkAFunc mstxMarkAPtr;
    MstxRangeStartAFunc mstxRangeStartAPtr;
    MstxRangeEndFunc mstxRangeEndPtr;
    MstxGetToolIdFunc mstxGetToolIdPtr;

    MstxDomainCreateAFunc mstxDomainCreateAPtr;
    MstxDomainDestroyFunc mstxDomainDestroyPtr;
    MstxDomainMarkAFunc mstxDomainMarkAPtr;
    MstxDomainRangeStartAFunc mstxDomainRangeStartAPtr;
    MstxDomainRangeEndFunc mstxDomainRangeEndPtr;

    MstxFuncPointer* funcTableCore[MSTX_FUNC_END + 1];
    MstxFuncPointer* funcTableCore2[MSTX_FUNC_DOMAIN_END + 1];
};

class MstxContextManager {
public:
    static MstxContextManager& GetInstance()
    {
        static MstxContextManager instance;
        return instance;
    }

    const MstxContext_t& GetCurContext() { return GetContext(curModule.load()); }

    const MstxContext_t& GetContext(ProfModule module)
    {
        if (module == PROF_MODULE_MSPROF) {
            return msprofMstxContext;
        }
        return msptiMstxContext;
    }

    ProfModule GetCurModule() { return curModule; }

    void EnableMstxFunc(ProfModule module) { curModule = module; }

    void RecordDomainHandle(mstxDomainHandle_t profDomainHandle, mstxDomainHandle_t ptiDomainHandle)
    {
        if (!profDomainHandle || !ptiDomainHandle) {
            return;
        }
        std::lock_guard<std::mutex> lk(domainMutex_);
        connectDomainMap[PROF_MODULE_MSPROF][ptiDomainHandle] = profDomainHandle;
        connectDomainMap[PROF_MODULE_MSPTI][profDomainHandle] = ptiDomainHandle;
    }

    void RemoveDomainHandle(mstxDomainHandle_t domainHandle, ProfModule curModule)
    {
        if (!domainHandle) {
            return;
        }
        std::lock_guard<std::mutex> lk(domainMutex_);
        connectDomainMap[curModule].erase(domainHandle);
    }

    mstxDomainHandle_t GetRealDomainHandle(mstxDomainHandle_t domainHandle, ProfModule curModule)
    {
        if (!domainHandle) {
            return domainHandle;
        }
        std::lock_guard<std::mutex> lk(domainMutex_);
        const auto& domainMap = connectDomainMap[curModule];
        auto it = domainMap.find(domainHandle);
        if (it == domainMap.end()) {
            return domainHandle;
        }
        return it->second;
    }

    int MstxGetModuleFuncTable(
        MstxFuncModule module, MstxFuncTable* outTable, unsigned int* outSize, ProfModule profModule)
    {
        if (!outSize || !outTable) {
            return MSTX_FAIL;
        }
        MstxContext_t* context = (profModule == PROF_MODULE_MSPROF) ? &msprofMstxContext : &msptiMstxContext;
        switch (module) {
            case MSTX_API_MODULE_CORE:
                *outTable = context->funcTableCore;
                *outSize = LengthOf(context->funcTableCore);
                break;
            case MSTX_API_MODULE_CORE_DOMAIN:
                *outTable = context->funcTableCore2;
                *outSize = LengthOf(context->funcTableCore);
                break;
            default:
                return MSTX_FAIL;
        }
        return MSTX_SUCCESS;
    }

private:
    MstxContextManager()
    {
        msprofMstxContext = {
            ProfApi::MstxPlugin::MsprofMstxGetModuleFuncTable,

            nullptr,
            nullptr,
            nullptr,
            nullptr,
            nullptr,
            nullptr,
            nullptr,
            nullptr,
            nullptr,

            {nullptr, reinterpret_cast<MstxFuncPointer*>(&msprofMstxContext.mstxMarkAPtr),
             reinterpret_cast<MstxFuncPointer*>(&msprofMstxContext.mstxRangeStartAPtr),
             reinterpret_cast<MstxFuncPointer*>(&msprofMstxContext.mstxRangeEndPtr),
             reinterpret_cast<MstxFuncPointer*>(&msprofMstxContext.mstxGetToolIdPtr), nullptr},
            {nullptr, reinterpret_cast<MstxFuncPointer*>(&msprofMstxContext.mstxDomainCreateAPtr),
             reinterpret_cast<MstxFuncPointer*>(&msprofMstxContext.mstxDomainDestroyPtr),
             reinterpret_cast<MstxFuncPointer*>(&msprofMstxContext.mstxDomainMarkAPtr),
             reinterpret_cast<MstxFuncPointer*>(&msprofMstxContext.mstxDomainRangeStartAPtr),
             reinterpret_cast<MstxFuncPointer*>(&msprofMstxContext.mstxDomainRangeEndPtr), nullptr}};

        msptiMstxContext = {
            ProfApi::MstxPlugin::MsptiMstxGetModuleFuncTable,

            nullptr,
            nullptr,
            nullptr,
            nullptr,
            nullptr,
            nullptr,
            nullptr,
            nullptr,
            nullptr,

            {nullptr, reinterpret_cast<MstxFuncPointer*>(&msptiMstxContext.mstxMarkAPtr),
             reinterpret_cast<MstxFuncPointer*>(&msptiMstxContext.mstxRangeStartAPtr),
             reinterpret_cast<MstxFuncPointer*>(&msptiMstxContext.mstxRangeEndPtr),
             reinterpret_cast<MstxFuncPointer*>(&msptiMstxContext.mstxGetToolIdPtr), nullptr},
            {nullptr, reinterpret_cast<MstxFuncPointer*>(&msptiMstxContext.mstxDomainCreateAPtr),
             reinterpret_cast<MstxFuncPointer*>(&msptiMstxContext.mstxDomainDestroyPtr),
             reinterpret_cast<MstxFuncPointer*>(&msptiMstxContext.mstxDomainMarkAPtr),
             reinterpret_cast<MstxFuncPointer*>(&msptiMstxContext.mstxDomainRangeStartAPtr),
             reinterpret_cast<MstxFuncPointer*>(&msptiMstxContext.mstxDomainRangeEndPtr), nullptr}};
    }
    MstxContext_t msprofMstxContext;
    MstxContext_t msptiMstxContext;
    std::mutex domainMutex_;
    std::array<std::unordered_map<mstxDomainHandle_t, mstxDomainHandle_t>, PROF_MODULE_SIZE> connectDomainMap;
    std::atomic<ProfModule> curModule{PROF_MODULE_MSPROF};
};

void MstxMarkAImpl(const char* message, aclrtStream stream)
{
    auto& curContext = MstxContextManager::GetInstance().GetCurContext();
    if (curContext.mstxMarkAPtr) {
        curContext.mstxMarkAPtr(message, stream);
    }
}

mstxRangeId MstxRangeStartAImpl(const char* message, aclrtStream stream)
{
    auto& curContext = MstxContextManager::GetInstance().GetCurContext();
    if (curContext.mstxRangeStartAPtr) {
        return curContext.mstxRangeStartAPtr(message, stream);
    }
    return MSTX_INVALID_RANGE_ID;
}

void MstxRangeEndImpl(mstxRangeId id)
{
    auto& curContext = MstxContextManager::GetInstance().GetCurContext();
    if (curContext.mstxRangeEndPtr) {
        curContext.mstxRangeEndPtr(id);
    }
}

void MstxGetToolIdImpl(uint64_t* id) { *id = MSTX_TOOLS_MSPROF_ID; }

mstxDomainHandle_t MstxDomainCreateAImpl(const char* name)
{
    auto& contextManager = MstxContextManager::GetInstance();
    auto& profContext = contextManager.GetContext(PROF_MODULE_MSPROF);
    mstxDomainHandle_t profDomain = nullptr;
    if (profContext.mstxDomainCreateAPtr) {
        profDomain = profContext.mstxDomainCreateAPtr(name);
    }

    auto& ptiContext = contextManager.GetContext(PROF_MODULE_MSPTI);
    mstxDomainHandle_t ptiDomain = nullptr;
    if (ptiContext.mstxDomainCreateAPtr) {
        ptiDomain = ptiContext.mstxDomainCreateAPtr(name);
    }
    contextManager.RecordDomainHandle(profDomain, ptiDomain);
    if (contextManager.GetCurModule() == PROF_MODULE_MSPROF) {
        return profDomain;
    }
    return ptiDomain;
}

void MstxDomainDestroyImpl(mstxDomainHandle_t domain)
{
    auto& contextManager = MstxContextManager::GetInstance();
    auto& profContext = contextManager.GetContext(PROF_MODULE_MSPROF);

    if (profContext.mstxDomainDestroyPtr) {
        auto profDomain = contextManager.GetRealDomainHandle(domain, PROF_MODULE_MSPROF);
        profContext.mstxDomainDestroyPtr(profDomain);
        contextManager.RemoveDomainHandle(domain, PROF_MODULE_MSPROF);
    }

    auto& ptiContext = contextManager.GetContext(PROF_MODULE_MSPTI);
    if (ptiContext.mstxDomainDestroyPtr) {
        auto ptiDomain = contextManager.GetRealDomainHandle(domain, PROF_MODULE_MSPTI);
        ptiContext.mstxDomainDestroyPtr(ptiDomain);
        contextManager.RemoveDomainHandle(domain, PROF_MODULE_MSPTI);
    }
}

void MstxDomainMarkAImpl(mstxDomainHandle_t domain, const char* message, aclrtStream stream)
{
    auto& curContext = MstxContextManager::GetInstance().GetCurContext();
    ProfModule curModule = MstxContextManager::GetInstance().GetCurModule();
    if (curContext.mstxDomainMarkAPtr) {
        auto realDomain = MstxContextManager::GetInstance().GetRealDomainHandle(domain, curModule);
        curContext.mstxDomainMarkAPtr(realDomain, message, stream);
    }
}

mstxRangeId MstxDomainRangeStartAImpl(mstxDomainHandle_t domain, const char* message, aclrtStream stream)
{
    auto& curContext = MstxContextManager::GetInstance().GetCurContext();
    ProfModule curModule = MstxContextManager::GetInstance().GetCurModule();
    if (curContext.mstxDomainRangeStartAPtr) {
        auto realDomain = MstxContextManager::GetInstance().GetRealDomainHandle(domain, curModule);
        return curContext.mstxDomainRangeStartAPtr(realDomain, message, stream);
    }
    return MSTX_INVALID_RANGE_ID;
}

void MstxDomainRangeEndImpl(mstxDomainHandle_t domain, mstxRangeId id)
{
    auto& curContext = MstxContextManager::GetInstance().GetCurContext();
    ProfModule curModule = MstxContextManager::GetInstance().GetCurModule();
    if (curContext.mstxDomainRangeEndPtr) {
        auto realDomain = MstxContextManager::GetInstance().GetRealDomainHandle(domain, curModule);
        curContext.mstxDomainRangeEndPtr(realDomain, id);
    }
}

void SetMstxModuleCoreApi(MstxFuncTable outTable, unsigned int size)
{
    if (size >= static_cast<unsigned int>(MSTX_FUNC_MARKA)) {
        *(outTable[MSTX_FUNC_MARKA]) = reinterpret_cast<MstxFuncPointer>(MstxMarkAImpl);
    }
    if (size >= static_cast<unsigned int>(MSTX_FUNC_RANGE_STARTA)) {
        *(outTable[MSTX_FUNC_RANGE_STARTA]) = reinterpret_cast<MstxFuncPointer>(MstxRangeStartAImpl);
    }
    if (size >= static_cast<unsigned int>(MSTX_FUNC_RANGE_END)) {
        *(outTable[MSTX_FUNC_RANGE_END]) = reinterpret_cast<MstxFuncPointer>(MstxRangeEndImpl);
    }
}

void SetMstxModuleCoreDomainApi(MstxFuncTable outTable, unsigned int size)
{
    if (size >= static_cast<unsigned int>(MSTX_FUNC_DOMAIN_CREATEA)) {
        *(outTable[MSTX_FUNC_DOMAIN_CREATEA]) = reinterpret_cast<MstxFuncPointer>(MstxDomainCreateAImpl);
    }
    if (size >= static_cast<unsigned int>(MSTX_FUNC_DOMAIN_DESTROY)) {
        *(outTable[MSTX_FUNC_DOMAIN_DESTROY]) = reinterpret_cast<MstxFuncPointer>(MstxDomainDestroyImpl);
    }
    if (size >= static_cast<unsigned int>(MSTX_FUNC_DOMAIN_MARKA)) {
        *(outTable[MSTX_FUNC_DOMAIN_MARKA]) = reinterpret_cast<MstxFuncPointer>(MstxDomainMarkAImpl);
    }
    if (size >= static_cast<unsigned int>(MSTX_FUNC_DOMAIN_RANGE_STARTA)) {
        *(outTable[MSTX_FUNC_DOMAIN_RANGE_STARTA]) = reinterpret_cast<MstxFuncPointer>(MstxDomainRangeStartAImpl);
    }
    if (size >= static_cast<unsigned int>(MSTX_FUNC_DOMAIN_RANGE_END)) {
        *(outTable[MSTX_FUNC_DOMAIN_RANGE_END]) = reinterpret_cast<MstxFuncPointer>(MstxDomainRangeEndImpl);
    }
}

namespace {
// 本通道实现的 mstx 模块表填充清单。只遍历本仓真正实现的模块：
// 对端枚举里多出来的模块号既不查询也不当作失败——注入返回失败会让 mstx 客户端
// 清空全部函数指针（mark/range 等入口），表现为打点数据整体缺失且无日志。
const MstxModuleBinder kMstxModuleBinders[] = {
    {MSTX_API_MODULE_CORE, SetMstxModuleCoreApi},
    {MSTX_API_MODULE_CORE_DOMAIN, SetMstxModuleCoreDomainApi},
};
} // namespace

int GetModuleTableFunc(MstxGetModuleFuncTableFunc getFuncTable)
{
    unsigned int outSize = 0;
    MstxFuncTable outTable = nullptr;
    for (const auto& binder : kMstxModuleBinders) {
        if (getFuncTable(binder.module, &outTable, &outSize) != MSTX_SUCCESS) {
            MSPROF_LOGW("Failed to get func table for module %d", static_cast<int>(binder.module));
            continue;
        }
        if (outTable == nullptr || outSize == 0) {
            continue;
        }
        binder.setter(outTable, outSize);
        MSPROF_LOGI("Succeed to get func table for module %d", static_cast<int>(binder.module));
    }
    return MSTX_SUCCESS;
}

int MsprofMstxGetModuleFuncTable(MstxFuncModule module, MstxFuncTable* outTable, unsigned int* outSize)
{
    return MstxContextManager::GetInstance().MstxGetModuleFuncTable(module, outTable, outSize, PROF_MODULE_MSPROF);
}

int MsptiMstxGetModuleFuncTable(MstxFuncModule module, MstxFuncTable* outTable, unsigned int* outSize)
{
    return MstxContextManager::GetInstance().MstxGetModuleFuncTable(module, outTable, outSize, PROF_MODULE_MSPTI);
}

void ProfRegisteMstxFunc(MstxInitInjectionFunc mstxInitFunc, ProfModule module)
{
    if (mstxInitFunc) {
        if (module == PROF_MODULE_MSPROF) {
            mstxInitFunc(MsprofMstxGetModuleFuncTable);
        } else if (module == PROF_MODULE_MSPTI) {
            mstxInitFunc(MsptiMstxGetModuleFuncTable);
        }
    }
}

void EnableMstxFunc(ProfModule module) { MstxContextManager::GetInstance().EnableMstxFunc(module); }
} // namespace MstxPlugin
} // namespace ProfApi

// for mstx to init mstx impl functions injection
MSVP_PROF_API int32_t InitInjectionMstx(MstxGetModuleFuncTableFunc getFuncTable)
{
    if (getFuncTable == nullptr) {
        return MSTX_FAIL;
    }
    return ProfApi::MstxPlugin::GetModuleTableFunc(getFuncTable);
}

// for msprof and mspti to register mstx functions
MSVP_PROF_API void ProfRegisterMstxFunc(MstxInitInjectionFunc mstxInitFunc, ProfModule module)
{
    ProfApi::MstxPlugin::ProfRegisteMstxFunc(mstxInitFunc, module);
}

// for msprof and mspti to enable current mstx module
MSVP_PROF_API void ProfEnableMstxFunc(ProfModule module) { ProfApi::MstxPlugin::EnableMstxFunc(module); }