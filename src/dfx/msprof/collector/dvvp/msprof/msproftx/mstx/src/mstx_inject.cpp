/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <atomic>
#include "mstx_inject.h"
#include <algorithm>
#include <set>
#include <unordered_map>
#include "msprof_dlog.h"
#include "errno/error_code.h"
#include "mstx_data_handler.h"
#include "mstx_resource_name_util.h"
#include "mstx_domain_mgr.h"

using namespace Collector::Dvvp::Mstx;
using namespace analysis::dvvp::common::error;

static std::mutex g_mutex;
static std::unordered_map<uint64_t, aclrtStream> g_eventIdsWithStream;
static std::unordered_map<uint64_t, std::unordered_set<uint64_t>> g_domainWithEventIds_;

namespace MsprofMstxApi {
constexpr uint64_t MSTX_MODEL_ID = 0xFFFFFFFFU;
constexpr uint16_t MSTX_TAG_ID = 11;

static bool IfStrStartsWithInvalidChar(const char* str)
{
    // 为防止tx数据引起csv注入安全问题，要校验首字符
    static std::set<char> InvalidCharList = {'\0', '=', '+', '-', '@'};
    return InvalidCharList.count(*str);
}

static bool IsMsgValid(const char* oriMsg)
{
    if (oriMsg == nullptr) {
        MSPROF_LOGE("Input Params msg is null");
        return false;
    } else if (IfStrStartsWithInvalidChar(oriMsg)) {
        MSPROF_LOGE("Input Params msg is with invalid first char");
        return false;
    }
    return true;
}

static bool IsDomainNameValid(const char* name)
{
    if (name == nullptr || IfStrStartsWithInvalidChar(name)) {
        MSPROF_LOGE("Input Params domain name is null or with invalid first char");
        return false;
    }
    constexpr size_t maxDomainNameLen = 1024;
    if (strnlen(name, maxDomainNameLen) == maxDomainNameLen) {
        MSPROF_LOGE("Input Params domain name length exceeds the maximum value %d", maxDomainNameLen);
        return false;
    }
    return true;
}

static void MsTxMarkAImpl(const char* msg, aclrtStream stream, uint64_t domainName)
{
    uint64_t mstxEventId = MsprofTxManager::instance()->GetTxEventId();
    if (stream && MsprofTxManager::instance()->LaunchDeviceTxTask(mstxEventId, stream, false) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to run mstx task for mark");
        return;
    }
    if (MstxDataHandler::instance()->SaveMstxData(msg, mstxEventId, MstxDataType::DATA_MARK, domainName) !=
        PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to save data for mark, msg: %s", msg);
        return;
    }
    MSPROF_LOGI("Successfully to execute mark");
}

static uint64_t MsTxRangeStartAImpl(const char* msg, aclrtStream stream, uint64_t domainName)
{
    uint64_t mstxEventId = MsprofTxManager::instance()->GetTxEventId();
    if (stream && MsprofTxManager::instance()->LaunchDeviceTxTask(mstxEventId, stream, true) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to run mstx task for range start");
        return MSTX_INVALID_RANGE_ID;
    }
    if (MstxDataHandler::instance()->SaveMstxData(msg, mstxEventId, MstxDataType::DATA_RANGE_START, domainName) !=
        PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to save data for range start, msg: %s", msg);
        return MSTX_INVALID_RANGE_ID;
    }
    {
        std::lock_guard<std::mutex> lock(g_mutex);
        if (stream) {
            g_eventIdsWithStream[mstxEventId] = stream;
        }
        g_domainWithEventIds_[domainName].insert(mstxEventId);
    }
    MSPROF_LOGI("Successfully to execute range start, range id %lu", mstxEventId);
    return mstxEventId;
}

static void MstxRangeEndImpl(uint64_t id, uint64_t domainName)
{
    {
        std::lock_guard<std::mutex> lock(g_mutex);
        auto domainNameIter = g_domainWithEventIds_.find(domainName);
        if (domainNameIter == g_domainWithEventIds_.end() || domainNameIter->second.count(id) == 0) {
            MSPROF_LOGE("Domain and range id for mstx range start func and range end func do not match");
            return;
        }
        domainNameIter->second.erase(id);
        auto it = g_eventIdsWithStream.find(id);
        if (it != g_eventIdsWithStream.end()) {
            if (it->second == nullptr) {
                MSPROF_LOGE("Stream for range id %lu is null", id);
                return;
            }
            if (MsprofTxManager::instance()->LaunchDeviceTxTask(id, it->second, true) != PROFILING_SUCCESS) {
                MSPROF_LOGE("Failed to run mstx task for range end, range id %lu", id);
                return;
            }
            g_eventIdsWithStream.erase(it);
        }
    }
    if (MstxDataHandler::instance()->SaveMstxData(nullptr, id, MstxDataType::DATA_RANGE_END) != PROFILING_SUCCESS) {
        MSPROF_LOGE("Failed to save data for range end, range id %lu", id);
        return;
    }
    MSPROF_LOGI("Successfully to execute range end, range id %lu", id);
}

void MstxMarkAFunc(const char* msg, aclrtStream stream)
{
    MSPROF_LOGI("Start to execute %s", __func__);
    if (!MstxDataHandler::instance()->IsStart()) {
        MSPROF_LOGW("Mstx manager is not started");
        return;
    }
    auto domainNameHash = MstxDomainMgr::instance()->GetDefaultDomainNameHash();
    if (!MstxDomainMgr::instance()->IsDomainEnabled(domainNameHash)) {
        return;
    }
    if (!IsMsgValid(msg)) {
        return;
    }
    MsTxMarkAImpl(msg, stream, domainNameHash);
}

uint64_t MstxRangeStartAFunc(const char* msg, aclrtStream stream)
{
    MSPROF_LOGI("Start to execute %s", __func__);
    if (!MstxDataHandler::instance()->IsStart()) {
        MSPROF_LOGW("Mstx manager is not started");
        return MSTX_INVALID_RANGE_ID;
    }
    auto domainNameHash = MstxDomainMgr::instance()->GetDefaultDomainNameHash();
    if (!MstxDomainMgr::instance()->IsDomainEnabled(domainNameHash)) {
        return MSTX_INVALID_RANGE_ID;
    }
    if (!IsMsgValid(msg)) {
        return MSTX_INVALID_RANGE_ID;
    }
    return MsTxRangeStartAImpl(msg, stream, domainNameHash);
}

void MstxRangeEndFunc(uint64_t id)
{
    MSPROF_LOGI("Start to execute %s", __func__);
    if (!MstxDataHandler::instance()->IsStart()) {
        MSPROF_LOGW("Mstx manager is not started");
        return;
    }
    if (id == MSTX_INVALID_RANGE_ID) {
        return;
    }
    auto domainNameHash = MstxDomainMgr::instance()->GetDefaultDomainNameHash();
    if (!MstxDomainMgr::instance()->IsDomainEnabled(domainNameHash)) {
        return;
    }
    MstxRangeEndImpl(id, MstxDomainMgr::instance()->GetDefaultDomainNameHash());
}

mstxDomainHandle_t MstxDomainCreateAFunc(const char* name)
{
    if (!IsDomainNameValid(name)) {
        return nullptr;
    }
    return MstxDomainMgr::instance()->CreateDomainHandle(name);
}

void MstxDomainDestroyFunc(mstxDomainHandle_t domain) { MstxDomainMgr::instance()->DestroyDomainHandle(domain); }

void MstxDomainMarkAFunc(mstxDomainHandle_t domain, const char* msg, aclrtStream stream)
{
    if (!MstxDataHandler::instance()->IsStart()) {
        MSPROF_LOGW("Mstx manager is not started");
        return;
    }
    uint64_t domainNameHash = 0;
    if (!MstxDomainMgr::instance()->GetDomainNameHashByHandle(domain, domainNameHash)) {
        MSPROF_LOGE("Failed to find domain name for %s", __func__);
        return;
    }
    if (!MstxDomainMgr::instance()->IsDomainEnabled(domainNameHash)) {
        return;
    }
    if (!IsMsgValid(msg)) {
        return;
    }
    MsTxMarkAImpl(msg, stream, domainNameHash);
}

uint64_t MstxDomainRangeStartAFunc(mstxDomainHandle_t domain, const char* msg, aclrtStream stream)
{
    if (!MstxDataHandler::instance()->IsStart()) {
        MSPROF_LOGW("Mstx manager is not started");
        return MSTX_INVALID_RANGE_ID;
    }
    uint64_t domainNameHash = 0;
    if (!MstxDomainMgr::instance()->GetDomainNameHashByHandle(domain, domainNameHash)) {
        MSPROF_LOGE("Failed to find domain name for %s", __func__);
        return MSTX_INVALID_RANGE_ID;
    }
    if (!MstxDomainMgr::instance()->IsDomainEnabled(domainNameHash)) {
        return MSTX_INVALID_RANGE_ID;
    }
    if (!IsMsgValid(msg)) {
        return MSTX_INVALID_RANGE_ID;
    }
    return MsTxRangeStartAImpl(msg, stream, domainNameHash);
}

void MstxDomainRangeEndFunc(mstxDomainHandle_t domain, uint64_t id)
{
    MSPROF_LOGI("Start to execute %s", __func__);
    if (!MstxDataHandler::instance()->IsStart()) {
        MSPROF_LOGW("Mstx manager is not started");
        return;
    }
    if (id == MSTX_INVALID_RANGE_ID) {
        return;
    }
    uint64_t domainNameHash = 0;
    if (!MstxDomainMgr::instance()->GetDomainNameHashByHandle(domain, domainNameHash)) {
        MSPROF_LOGE("Failed to find domain name for %s", __func__);
        return;
    }
    if (!MstxDomainMgr::instance()->IsDomainEnabled(domainNameHash)) {
        return;
    }
    MstxRangeEndImpl(id, domainNameHash);
}

namespace {
// 名称校验：非空、首字符合法（与 mark/range 复用同一套规则）、长度截断到 MSTX_RESOURCE_NAME_MAX_LEN
bool IsResourceNameValid(const char* name)
{
    if (name == nullptr || name[0] == '\0') {
        return false;
    }
    if (IfStrStartsWithInvalidChar(name)) {
        MSPROF_LOGW("Resource name starts with invalid char, ignored");
        return false;
    }
    return true;
}

// 域名哈希：nullptr 解析为真实默认域；非法/已销毁 domain 视为无效并丢弃记录
bool ResolveDomainHash(mstxDomainHandle_t domain, uint64_t& domainNameHash)
{
    if (domain == nullptr) {
        domainNameHash = MstxDomainMgr::instance()->GetDefaultDomainNameHash();
        return true;
    }
    if (!MstxDomainMgr::instance()->GetDomainNameHashByHandle(domain, domainNameHash)) {
        MSPROF_LOGE("Failed to find domain name hash for resource naming, record dropped");
        return false;
    }
    return true;
}

void SaveName(
    uint32_t resourceType, uint64_t identifier, uint32_t identifierKind, const char* name, uint32_t category,
    mstxDomainHandle_t domain)
{
    if (!IsResourceNameValid(name)) {
        return;
    }
    uint64_t domainNameHash = 0;
    if (!ResolveDomainHash(domain, domainNameHash)) {
        return;
    }
    // 与 mark/range 一致：被 mstx_domain_exclude 排除的域不产生记录
    if (!MstxDomainMgr::instance()->IsDomainEnabled(domainNameHash)) {
        return;
    }
    if (!MstxDataHandler::instance()->IsStart()) {
        return;
    }
    if (MstxDataHandler::instance()->SaveMstxResourceName(
            resourceType, identifier, identifierKind, name, category, domainNameHash) != 0) {
        MSPROF_LOGW("Resource name dropped: buffer full or record rejected, type %u", resourceType);
    }
}
} // namespace

void MstxNameOsThreadAFunc(uint32_t threadId, const char* name)
{
    if (threadId == 0) {
        return;
    }
    SaveName(MSTX_RESOURCE_TYPE_OS_THREAD, static_cast<uint64_t>(threadId), 0, name, 0, nullptr);
}

void MstxNameDeviceAFunc(int32_t deviceId, const char* name)
{
    if (deviceId < 0) {
        return;
    }
    SaveName(MSTX_RESOURCE_TYPE_DEVICE, static_cast<uint64_t>(deviceId), 0, name, 0, nullptr);
}

void MstxNameStreamAFunc(aclrtStream stream, const char* name)
{
    // RFC Q3：stream 句柄到 profiler 流 ID 的换算接口待确认，首版回退记录句柄值并置 identifierKind=1
    if (stream == nullptr) {
        return;
    }
    SaveName(MSTX_RESOURCE_TYPE_STREAM, reinterpret_cast<uint64_t>(stream), 1, name, 0, nullptr);
}

void MstxNameEventAFunc(void* event, const char* name)
{
    if (event == nullptr) {
        return;
    }
    SaveName(MSTX_RESOURCE_TYPE_EVENT, reinterpret_cast<uint64_t>(event), 1, name, 0, nullptr);
}

void MstxNameCategoryAFunc(uint32_t categoryId, const char* name)
{
    SaveName(MSTX_RESOURCE_TYPE_CATEGORY, static_cast<uint64_t>(categoryId), 0, name, categoryId, nullptr);
}

uint64_t MstxDomainResourceCreateFunc(mstxDomainHandle_t domain, const MstxResourceAttributes* attr)
{
    if (attr == nullptr || attr->version != 1 || attr->size != sizeof(MstxResourceAttributes)) {
        MSPROF_LOGE("Invalid resource attributes for %s", __func__);
        return 0;
    }
    const uint32_t resourceType = static_cast<uint32_t>(attr->resourceType);
    if (!MstxIsValidResourceType(resourceType)) {
        MSPROF_LOGE("Invalid resource type %u for naming, rejected", resourceType);
        return 0;
    }
    if (!IsResourceNameValid(attr->name)) {
        return 0;
    }
    uint32_t identifierKind = (attr->resourceType == MSTX_RESOURCE_TYPE_GENERIC_POINTER) ? 1 : 0;
    uint64_t identifier =
        (identifierKind == 1) ? reinterpret_cast<uint64_t>(attr->identifier.ptrValue) : attr->identifier.idValue;
    SaveName(resourceType, identifier, identifierKind, attr->name, attr->category, domain);
    static std::atomic<uint64_t> handleSeed{1};
    return handleSeed.fetch_add(1);
}

void MstxDomainResourceDestroyFunc(uint64_t resource)
{
    // 命名注销：采集侧不需要保留句柄状态，记录一次销毁语义由分析侧按"最后一次生效"处理
    (void)resource;
}

void SetMstxModuleCoreNameApi(MstxFuncTable outTable, unsigned int size)
{
    if (size > static_cast<unsigned int>(MSTX_FUNC_NAME_OS_THREAD)) {
        *(outTable[MSTX_FUNC_NAME_OS_THREAD]) = (MstxFuncPointer)MstxNameOsThreadAFunc;
    }
    if (size > static_cast<unsigned int>(MSTX_FUNC_NAME_DEVICE)) {
        *(outTable[MSTX_FUNC_NAME_DEVICE]) = (MstxFuncPointer)MstxNameDeviceAFunc;
    }
    if (size > static_cast<unsigned int>(MSTX_FUNC_NAME_STREAM)) {
        *(outTable[MSTX_FUNC_NAME_STREAM]) = (MstxFuncPointer)MstxNameStreamAFunc;
    }
    if (size > static_cast<unsigned int>(MSTX_FUNC_NAME_EVENT)) {
        *(outTable[MSTX_FUNC_NAME_EVENT]) = (MstxFuncPointer)MstxNameEventAFunc;
    }
    if (size > static_cast<unsigned int>(MSTX_FUNC_NAME_CATEGORY)) {
        *(outTable[MSTX_FUNC_NAME_CATEGORY]) = (MstxFuncPointer)MstxNameCategoryAFunc;
    }
    if (size > static_cast<unsigned int>(MSTX_FUNC_NAME_RESOURCE_CREATE)) {
        *(outTable[MSTX_FUNC_NAME_RESOURCE_CREATE]) = (MstxFuncPointer)MstxDomainResourceCreateFunc;
    }
    if (size > static_cast<unsigned int>(MSTX_FUNC_NAME_RESOURCE_DESTROY)) {
        *(outTable[MSTX_FUNC_NAME_RESOURCE_DESTROY]) = (MstxFuncPointer)MstxDomainResourceDestroyFunc;
    }
}

void SetMstxModuleCoreApi(MstxFuncTable outTable, unsigned int size)
{
    if (size >= static_cast<unsigned int>(MSTX_FUNC_MARKA)) {
        *(outTable[MSTX_FUNC_MARKA]) = (MstxFuncPointer)MstxMarkAFunc;
    }
    if (size >= static_cast<unsigned int>(MSTX_FUNC_RANGE_STARTA)) {
        *(outTable[MSTX_FUNC_RANGE_STARTA]) = (MstxFuncPointer)MstxRangeStartAFunc;
    }
    if (size >= static_cast<unsigned int>(MSTX_FUNC_RANGE_END)) {
        *(outTable[MSTX_FUNC_RANGE_END]) = (MstxFuncPointer)MstxRangeEndFunc;
    }
}

void SetMstxModuleCoreDomainApi(MstxFuncTable outTable, unsigned int size)
{
    if (size >= static_cast<unsigned int>(MSTX_FUNC_DOMAIN_CREATEA)) {
        *(outTable[MSTX_FUNC_DOMAIN_CREATEA]) = (MstxFuncPointer)MstxDomainCreateAFunc;
    }
    if (size >= static_cast<unsigned int>(MSTX_FUNC_DOMAIN_DESTROY)) {
        *(outTable[MSTX_FUNC_DOMAIN_DESTROY]) = (MstxFuncPointer)MstxDomainDestroyFunc;
    }
    if (size >= static_cast<unsigned int>(MSTX_FUNC_DOMAIN_MARKA)) {
        *(outTable[MSTX_FUNC_DOMAIN_MARKA]) = (MstxFuncPointer)MstxDomainMarkAFunc;
    }
    if (size >= static_cast<unsigned int>(MSTX_FUNC_DOMAIN_RANGE_STARTA)) {
        *(outTable[MSTX_FUNC_DOMAIN_RANGE_STARTA]) = (MstxFuncPointer)MstxDomainRangeStartAFunc;
    }
    if (size >= static_cast<unsigned int>(MSTX_FUNC_DOMAIN_RANGE_END)) {
        *(outTable[MSTX_FUNC_DOMAIN_RANGE_END]) = (MstxFuncPointer)MstxDomainRangeEndFunc;
    }
}

static_assert(
    static_cast<int>(MSTX_API_MODULE_CORE_NAME) == 4,
    "MSTX_API_MODULE_CORE_NAME must match mstx client enum (CORE_MEM occupies 3)");

int GetModuleTableFunc(MstxGetModuleFuncTableFunc getFuncTable)
{
    int retVal = MSTX_SUCCESS;
    unsigned int outSize = 0;
    MstxFuncTable outTable;
    static std::vector<unsigned int> CheckOutTableSizes = {
        0, MSTX_FUNC_END, MSTX_FUNC_DOMAIN_END, 0, MSTX_FUNC_NAME_END};
    for (size_t i = MSTX_API_MODULE_CORE; i < MSTX_API_MODULE_SIZE; i++) {
        if (getFuncTable(static_cast<MstxFuncModule>(i), &outTable, &outSize) != MSTX_SUCCESS) {
            MSPROF_LOGW("Failed to get func table for module %zu", i);
            continue;
        }
        switch (i) {
            case MSTX_API_MODULE_CORE:
                SetMstxModuleCoreApi(outTable, outSize);
                break;
            case MSTX_API_MODULE_CORE_DOMAIN:
                SetMstxModuleCoreDomainApi(outTable, outSize);
                break;
            case MSTX_API_MODULE_CORE_MEM:
                // 本仓不实现 mstx mem 系列接口，跳过但不算失败
                break;
            case MSTX_API_MODULE_CORE_NAME:
                SetMstxModuleCoreNameApi(outTable, outSize);
                break;
            default:
                MSPROF_LOGE("Invalid func module type");
                retVal = MSTX_FAIL;
                break;
        }
        if (retVal == MSTX_FAIL) {
            break;
        }
        MSPROF_LOGI("Succeed to get func table for module %zu", i);
    }
    return retVal;
}

int InitInjectionMstx(MstxGetModuleFuncTableFunc getFuncTable)
{
    if (getFuncTable == nullptr) {
        MSPROF_LOGE("Input null mstx getfunctable pointer");
        return MSTX_FAIL;
    }
    if (MsprofMstxApi::GetModuleTableFunc(getFuncTable) != MSTX_SUCCESS) {
        MSPROF_LOGE("Failed to init mstx funcs");
        return MSTX_FAIL;
    }
    return MSTX_SUCCESS;
}
} // namespace MsprofMstxApi
