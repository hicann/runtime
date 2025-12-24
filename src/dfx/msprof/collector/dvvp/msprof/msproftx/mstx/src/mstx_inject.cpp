/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "mstx_inject.h"
#include <algorithm>
#include <unordered_map>
#include "msprof_dlog.h"
#include "errno/error_code.h"
#include "mstx_data_handler.h"
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

static bool GetMsgPtrToSave(const char* oriMsg, SHARED_PTR_ALIA<std::string> &saveMsg)
{
    if (oriMsg == nullptr || IfStrStartsWithInvalidChar(oriMsg)) {
        MSPROF_LOGE("Input Params msg is null");
        return false;
    }
    /*
    pytorch/mindspore 内置通信打点数据样例如下:
    "{\\\"count\\\": \\\"16\\\",\\\"dataType\\\": \\\"fp32\\\",\\\"groupName\\\": \\\"hccl_world_group\\\",
      \\\"opName\\\": \\\"HcclSend\\\",\\\"destRank\\\": \\\"10000\\\",\\\"streamId\\\": \\\"0\\\"}"
    长度可能超过MAX_MESSAGE_LEN, 因此需要删除\符号以减小数据长度，保证数据不截断
    */
    if (*oriMsg != '{') {
        if (strnlen(oriMsg, MAX_MESSAGE_LEN) == MAX_MESSAGE_LEN) {
            MSPROF_LOGE("Input Params msg length exceeds the maximum value %d", MAX_MESSAGE_LEN);
            return false;
        }
        return true;
    }
    SHARED_PTR_ALIA<std::string> saveMsgStr;
    MSVP_MAKE_SHARED1(saveMsgStr, std::string, oriMsg, return false);
    saveMsgStr->erase(std::remove(saveMsgStr->begin(), saveMsgStr->end(), '\\'), saveMsgStr->end());
    if (strnlen(saveMsgStr->c_str(), MAX_MESSAGE_LEN) == MAX_MESSAGE_LEN) {
        MSPROF_LOGE("Input Params msg length exceeds the maximum value %d", MAX_MESSAGE_LEN);
        return false;
    }
    saveMsg = std::move(saveMsgStr);
    return true;
}

static bool IsDomainNameValid(const char* name)
{
    if (name == nullptr || IfStrStartsWithInvalidChar(name)) {
        MSPROF_LOGE("Input Params domain name is null");
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
    if (stream && MsprofTxManager::instance()->LaunchDeviceTxTask(mstxEventId, stream) != PROFILING_SUCCESS) {
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
    if (stream && MsprofTxManager::instance()->LaunchDeviceTxTask(mstxEventId, stream) != PROFILING_SUCCESS) {
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
            if (MsprofTxManager::instance()->LaunchDeviceTxTask(id, it->second) != PROFILING_SUCCESS) {
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
    SHARED_PTR_ALIA<std::string> saveMsg = nullptr;
    if (!GetMsgPtrToSave(msg, saveMsg)) {
        return;
    }
    if (saveMsg != nullptr) {
        MsTxMarkAImpl(saveMsg->c_str(), stream, domainNameHash);
    } else {
        MsTxMarkAImpl(msg, stream, domainNameHash);
    }
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
    SHARED_PTR_ALIA<std::string> saveMsg = nullptr;
    if (!GetMsgPtrToSave(msg, saveMsg)) {
        return MSTX_INVALID_RANGE_ID;
    }
    if (saveMsg != nullptr) {
        return MsTxRangeStartAImpl(saveMsg->c_str(), stream, domainNameHash);
    } else {
        return MsTxRangeStartAImpl(msg, stream, domainNameHash);
    }
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

void MstxDomainDestroyFunc(mstxDomainHandle_t domain)
{
    MstxDomainMgr::instance()->DestroyDomainHandle(domain);
}

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
    SHARED_PTR_ALIA<std::string> saveMsg = nullptr;
    if (!GetMsgPtrToSave(msg, saveMsg)) {
        return;
    }
    if (saveMsg != nullptr) {
        MsTxMarkAImpl(saveMsg->c_str(), stream, domainNameHash);
    } else {
        MsTxMarkAImpl(msg, stream, domainNameHash);
    }
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
    SHARED_PTR_ALIA<std::string> saveMsg = nullptr;
    if (!GetMsgPtrToSave(msg, saveMsg)) {
        return MSTX_INVALID_RANGE_ID;
    }
    if (saveMsg != nullptr) {
        return MsTxRangeStartAImpl(saveMsg->c_str(), stream, domainNameHash);
    } else {
        return MsTxRangeStartAImpl(msg, stream, domainNameHash);
    }
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

int GetModuleTableFunc(MstxGetModuleFuncTableFunc getFuncTable)
{
    int retVal = MSTX_SUCCESS;
    unsigned int outSize = 0;
    MstxFuncTable outTable;
    static std::vector<unsigned int> CheckOutTableSizes = {
        0,
        MSTX_FUNC_END,
        MSTX_FUNC_DOMAIN_END,
        0
    };
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
}
