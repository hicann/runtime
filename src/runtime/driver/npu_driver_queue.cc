/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "npu_driver.hpp"
#include "driver/ascend_hal.h"
#include "driver/ascend_inpackage_hal.h"
#include "errcode_manage.hpp"
#include "error_message_manage.hpp"
#include "rt_log.h"
#include "driver_enum_desc.hpp"

namespace {
constexpr int32_t MEMQ_EVENT_CROSS_DEV_VERSION = 0x72316; // MAJOR:0x07, MINOR:0x23, PATCH:0x16
constexpr uint32_t MEM_QUEUE_SUPPORT_VERSION = 0x06U;
constexpr uint32_t MAJOR_VERSION_OFFSET = 16U;
constexpr uint32_t MAJOR_VERSION_MASK = 0x00FF0000U;
constexpr uint32_t MAX_BUF_CNT = 128U;
uint32_t g_maxBufCnt = MAX_BUF_CNT;
} // namespace

/******************************************************************************
 * Core Category: Queue related
 ******************************************************************************/

namespace cce {
namespace runtime {

/* ========================================================
 * Subcategory: Normal Buf
 * ======================================================== */

rtError_t NpuDriver::BuffAlloc(const uint64_t size, void** buff)
{
    RT_LOG(RT_LOG_INFO, "alloc buff, size=%" PRIu64, size);
    COND_RETURN_WARN(&halBuffAlloc == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halBuffAlloc does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halBuffAlloc(size, buff));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halBuffAlloc failed, drvRetCode=%d, size=%" PRIu64 "(bytes).",
            static_cast<int32_t>(drvRet), size);
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::BuffFree(void* const buff)
{
    RT_LOG(RT_LOG_INFO, "free buff");
    COND_RETURN_WARN(&halBuffFree == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halBuffFree does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halBuffFree(buff));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Call driver api halBuffFree failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::BuffConfirm(void* const buff, const uint64_t size)
{
    RT_LOG(RT_LOG_INFO, "determine whether buff is shared memory");
    COND_RETURN_WARN(&halBuffGet == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halBuffGet does not exist.");
    const drvError_t drvRet = static_cast<drvError_t>(halBuffGet(nullptr, buff, size));
    if (drvRet != DRV_ERROR_NONE) {
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    COND_RETURN_WARN(&halBuffPut == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halBuffPut does not exist.");
    halBuffPut(nullptr, buff);

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::BuffGetInfo(
    const rtBuffGetCmdType type, const void* const inBuff, const uint32_t inLen, void* const outBuff,
    uint32_t* const outLen)
{
    RT_LOG(RT_LOG_INFO, "buff get info, type=%d.", static_cast<int32_t>(type));

    COND_RETURN_WARN(
        &halBuffGetInfo == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halBuffGetInfo does not exist.");
    const BuffGetCmdType drvType = static_cast<BuffGetCmdType>(type);
    void* const drvInBuff = const_cast<void*>(inBuff);

    const drvError_t drvRet = static_cast<drvError_t>(halBuffGetInfo(drvType, drvInBuff, inLen, outBuff, outLen));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halBuffGetInfo failed, drvRetCode=%d, type=%s(%d).", static_cast<int32_t>(drvRet),
            BuffGetCmdTypeName(drvType), static_cast<int32_t>(drvType));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

/* ========================================================
 * Subcategory: Memory Group
 * ======================================================== */

rtError_t NpuDriver::MemGrpCreate(const char_t* const name, const rtMemGrpConfig_t* const cfg)
{
    RT_LOG(RT_LOG_INFO, "create mem group, deviceId=0.");

    COND_RETURN_WARN(&halGrpCreate == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halGrpCreate does not exist.");
    GroupCfg drvCfg = {};
    drvCfg.maxMemSize = cfg->maxMemSize;
    drvCfg.cacheAllocFlag = cfg->cacheAllocFlag;
    drvCfg.privMbufFlag = BUFF_ENABLE_PRIVATE_MBUF; // judge priv for compatibility after C85
    drvCfg.addGrpTimeout = cfg->addGrpTimeout;
    const drvError_t drvRet = static_cast<drvError_t>(halGrpCreate(name, &drvCfg));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halGrpCreate failed, drvRetCode=%d, drvDevId=0.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemGrpCacheAlloc(
    const char_t* const name, const int32_t devId, const rtMemGrpCacheAllocPara* const para)
{
    RT_LOG(RT_LOG_INFO, "group mem pre alloc, drv devId=%d, group=%s.", devId, name);

    COND_RETURN_WARN(
        &halGrpCacheAlloc == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halGrpCacheAlloc does not exist.");
    GrpCacheAllocPara drvPara = {};
    drvPara.memSize = para->memSize;
    drvPara.memFlag = para->memFlag;

    const drvError_t drvRet = static_cast<drvError_t>(halGrpCacheAlloc(name, static_cast<uint32_t>(devId), &drvPara));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halGrpCacheAlloc failed, drvRetCode=%d, drvDevId=%d, group=%s.",
            static_cast<int32_t>(drvRet), devId, name);
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemGrpAddProc(const char_t* const name, const int32_t pid, const rtMemGrpShareAttr_t* const attr)
{
    RT_LOG(RT_LOG_INFO, "add process for mem group, deviceId=0.");

    COND_RETURN_WARN(
        &halGrpAddProc == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halGrpAddProc does not exist.");
    GroupShareAttr drvAttr = {};
    drvAttr.admin = attr->admin;
    drvAttr.read = attr->read;
    drvAttr.write = attr->write;
    drvAttr.alloc = attr->alloc;
    const drvError_t drvRet = static_cast<drvError_t>(halGrpAddProc(name, pid, drvAttr));
    COND_RETURN_WARN(drvRet == DRV_ERROR_REPEATED_INIT, RT_GET_DRV_ERRCODE(drvRet), "repeated init"); // special state
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halGrpAddProc failed, drvRetCode=%d, drvDevId=0.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

static rtError_t MemGrpQueryGroupsOfProcess(
    const rtMemGrpQueryInput_t* const input, rtMemGrpQueryOutput_t* const output)
{
    GroupQueryInput drvInput;
    errno_t ret = memset_s(&drvInput, sizeof(drvInput), 0, sizeof(drvInput));
    COND_LOG_ERROR(ret != EOK, "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(drvInput), ret);
    drvInput.grpQueryGroupsOfProc.pid = input->grpQueryByProc.pid;
    const uint32_t drvInputLen = static_cast<uint32_t>(sizeof(drvInput));

    const std::unique_ptr<GroupQueryOutput> drvOutputUniquePtr(new (std::nothrow)(GroupQueryOutput));
    COND_RETURN_AND_MSG_OUTER(
        drvOutputUniquePtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
        std::to_string(sizeof(GroupQueryOutput)).c_str(), "new");
    GroupQueryOutput* const drvOutput = drvOutputUniquePtr.get();

    ret = memset_s(RtPtrToPtr<void*>(drvOutput), sizeof(GroupQueryOutput), 0, sizeof(GroupQueryOutput));
    COND_LOG_ERROR(ret != EOK, "memset_s failed, size=%zu(bytes), retCode=%d.", sizeof(GroupQueryOutput), ret);
    uint32_t drvOutputLen = static_cast<uint32_t>(sizeof(GroupQueryOutput));

    const drvError_t drvRet = static_cast<drvError_t>(
        halGrpQuery(GRP_QUERY_GROUPS_OF_PROCESS, &drvInput, drvInputLen, drvOutput, &drvOutputLen));
    COND_RETURN_ERROR(
        drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halQueueQuery failed: device_id=0, drvRetCode=%d.", static_cast<int32_t>(drvRet));

    // only GRP_QUERY_GROUPS_OF_PROCESS
    output->resultNum = (static_cast<size_t>(drvOutputLen)) / sizeof(GrpQueryGroupsOfProcInfo);
    if ((output->groupsOfProc == nullptr) || (output->maxNum == 0ULL)) {
        return RT_ERROR_NONE;
    }
    output->resultNum = (output->resultNum <= output->maxNum) ? output->resultNum : output->maxNum;
    if (output->resultNum > static_cast<size_t>(BUFF_GRP_MAX_NUM)) {
        output->resultNum = static_cast<size_t>(BUFF_GRP_MAX_NUM);
    }
    for (size_t i = 0U; i < output->resultNum; ++i) {
        output->groupsOfProc[i].attr.admin = drvOutput->grpQueryGroupsOfProcInfo[i].attr.admin;
        output->groupsOfProc[i].attr.read = drvOutput->grpQueryGroupsOfProcInfo[i].attr.read;
        output->groupsOfProc[i].attr.write = drvOutput->grpQueryGroupsOfProcInfo[i].attr.write;
        output->groupsOfProc[i].attr.alloc = drvOutput->grpQueryGroupsOfProcInfo[i].attr.alloc;

        ret = strcpy_s(
            output->groupsOfProc[i].groupName, sizeof(output->groupsOfProc[i].groupName),
            drvOutput->grpQueryGroupsOfProcInfo[i].groupName);
        COND_RETURN_ERROR(ret != EOK, RT_ERROR_SEC_HANDLE, "strcpy_s failed, retCode=%d!", ret);
    }
    return RT_ERROR_NONE;
}

static rtError_t MemGrpQueryGroupId(const rtMemGrpQueryInput_t* const input, rtMemGrpQueryOutput_t* const output)
{
    GroupQueryInput drvInput;
    errno_t ret = memset_s(&drvInput, sizeof(drvInput), 0, sizeof(drvInput));
    COND_LOG_ERROR(ret != EOK, "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(drvInput), ret);

    ret = strcpy_s(
        drvInput.grpQueryGroupId.grpName, sizeof(drvInput.grpQueryGroupId.grpName), input->grpQueryGroupId.grpName);
    COND_RETURN_ERROR(ret != EOK, RT_ERROR_SEC_HANDLE, "strcpy_s failed, retCode=%d!", ret);
    const uint32_t drvInputLen = static_cast<uint32_t>(sizeof(drvInput));

    const std::unique_ptr<GroupQueryOutput> drvOutputUniquePtr(new (std::nothrow)(GroupQueryOutput));
    COND_RETURN_AND_MSG_OUTER(
        drvOutputUniquePtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
        std::to_string(sizeof(GroupQueryOutput)).c_str(), "new");
    GroupQueryOutput* const drvOutput = drvOutputUniquePtr.get();

    ret = memset_s(RtPtrToPtr<void*>(drvOutput), sizeof(GroupQueryOutput), 0, sizeof(GroupQueryOutput));
    COND_LOG_ERROR(ret != EOK, "memset_s failed, size=%zu(bytes), retCode=%d.", sizeof(GroupQueryOutput), ret);
    uint32_t drvOutputLen = static_cast<uint32_t>(sizeof(GroupQueryOutput));

    const drvError_t drvRet =
        static_cast<drvError_t>(halGrpQuery(GRP_QUERY_GROUP_ID, &drvInput, drvInputLen, drvOutput, &drvOutputLen));
    COND_RETURN_ERROR(
        drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halQueueQuery failed: device_id=0, drvRetCode=%d.", static_cast<int32_t>(drvRet));

    // only GRP_QUERY_GROUP_ID
    if (output->groupIdInfo == nullptr) {
        RT_LOG(RT_LOG_ERROR, "group id info is nullptr, please check.");
        return RT_ERROR_INVALID_VALUE;
    }
    output->groupIdInfo->groupId = drvOutput->grpQueryGroupIdInfo.groupId;
    return RT_ERROR_NONE;
}

static rtError_t MemGrpGrpQueryGroupAddrInfo(
    const rtMemGrpQueryInput_t* const input, rtMemGrpQueryOutput_t* const output)
{
    COND_RETURN_ERROR((output->groupAddrInfo == nullptr), RT_ERROR_INVALID_VALUE, "invalid output nullptr");
    COND_RETURN_ERROR((output->maxNum == 0ULL), RT_ERROR_INVALID_VALUE, "invalid output, maxNum=%u.", output->maxNum);

    GroupQueryInput drvInput;
    errno_t ret = memset_s(&drvInput, sizeof(drvInput), 0, sizeof(drvInput));
    COND_RETURN_ERROR(
        ret != EOK, RT_ERROR_SEC_HANDLE, "memset_s failed, size=%zu(bytes), retCode=%d.", sizeof(drvInput), ret);
    ret = strcpy_s(
        drvInput.grpQueryGroupAddrPara.grpName, sizeof(drvInput.grpQueryGroupAddrPara.grpName),
        input->grpQueryGroupAddrPara.grpName);
    COND_RETURN_ERROR(ret != EOK, RT_ERROR_SEC_HANDLE, "strcpy_s failed, retCode=%d!", ret);
    drvInput.grpQueryGroupAddrPara.devId = input->grpQueryGroupAddrPara.devId;

    const std::unique_ptr<GroupQueryOutput> drvOutputUniquePtr(new (std::nothrow)(GroupQueryOutput));
    COND_RETURN_AND_MSG_OUTER(
        drvOutputUniquePtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
        std::to_string(sizeof(GroupQueryOutput)).c_str(), "new");
    GroupQueryOutput* const drvOutput = drvOutputUniquePtr.get();
    ret = memset_s(RtPtrToPtr<void*>(drvOutput), sizeof(GroupQueryOutput), 0, sizeof(GroupQueryOutput));
    COND_RETURN_ERROR(
        ret != EOK, RT_ERROR_SEC_HANDLE, "memset_s failed, size=%zu(bytes), retCode=%d.", sizeof(GroupQueryOutput),
        ret);
    uint32_t drvOutputLen = static_cast<uint32_t>(sizeof(GroupQueryOutput));
    const drvError_t drvRet = static_cast<drvError_t>(halGrpQuery(
        GRP_QUERY_GROUP_ADDR_INFO, &drvInput, static_cast<uint32_t>(sizeof(drvInput)), drvOutput, &drvOutputLen));
    COND_RETURN_ERROR(
        drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halGrpQuery failed:"
        "device_id=%u, drvRetCode=%d.",
        input->grpQueryGroupAddrPara.devId, static_cast<int32_t>(drvRet));

    // only GRP_QUERY_GROUP_ADDR_INFO
    output->resultNum = (static_cast<size_t>(drvOutputLen)) / sizeof(GrpQueryGroupAddrInfo);
    output->resultNum = (output->resultNum <= output->maxNum) ? output->resultNum : output->maxNum;
    if (output->resultNum > static_cast<size_t>(BUFF_GRP_MAX_NUM)) {
        output->resultNum = static_cast<size_t>(BUFF_GRP_MAX_NUM);
    }
    for (size_t i = 0U; i < output->resultNum; ++i) {
        output->groupAddrInfo[i].addr = drvOutput->grpQueryGroupAddrInfo[i].addr;
        output->groupAddrInfo[i].size = drvOutput->grpQueryGroupAddrInfo[i].size;
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemGrpQuery(const rtMemGrpQueryInput_t* const input, rtMemGrpQueryOutput_t* const output)
{
    RT_LOG(RT_LOG_INFO, "query mem group, deviceId=0.");

    COND_RETURN_WARN(&halGrpQuery == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halGrpQuery does not exist.");
    rtError_t ret = RT_ERROR_NONE;
    const GroupQueryCmdType drvCmd = static_cast<GroupQueryCmdType>(input->cmd);
    switch (drvCmd) {
        case GRP_QUERY_GROUPS_OF_PROCESS: {
            ret = MemGrpQueryGroupsOfProcess(input, output);
            break;
        }
        case GRP_QUERY_GROUP_ID: {
            ret = MemGrpQueryGroupId(input, output);
            break;
        }
        case GRP_QUERY_GROUP_ADDR_INFO: {
            ret = MemGrpGrpQueryGroupAddrInfo(input, output);
            break;
        }
        default: {
            RT_LOG(RT_LOG_ERROR, "invalid cmd=%d.", input->cmd);
            ret = RT_ERROR_INVALID_VALUE;
        }
    }
    return ret;
}

rtError_t NpuDriver::MemGrpAttach(const char_t* const name, const int32_t timeout)
{
    RT_LOG(RT_LOG_INFO, "attach mem group, deviceId=0.");

    COND_RETURN_WARN(&halGrpAttach == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halGrpAttach does not exist.");

    const drvError_t drvRet = static_cast<drvError_t>(halGrpAttach(name, timeout));
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halGrpAttach failed, drvRetCode=%d, drvDevId=0.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    return RT_ERROR_NONE;
}

rtError_t NpuDriver::BufEventTrigger(const char_t* const name)
{
    RT_LOG(RT_LOG_INFO, "BufEventTrigger begin.");
    COND_RETURN_WARN(
        &halBufEventReport == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halBufEventReport does not exist.");

    const drvError_t drvRet = halBufEventReport(name);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halBufEventReport failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

/* ========================================================
 * Subcategory: Memory Queue
 * ======================================================== */

rtError_t NpuDriver::MemQueueCreate(const int32_t devId, const rtMemQueueAttr_t* const queAttr, uint32_t* const qid)
{
    COND_RETURN_WARN(
        &halQueueCreate == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueueCreate does not exist.");
    if (queAttr->depth < RT_MQ_DEPTH_MIN) {
        RT_LOG_OUTER_MSG_INVALID_PARAM_WITH_DESC(
            "Memory queue creation", queAttr->depth, std::to_string(RT_MQ_DEPTH_MIN));
        return RT_ERROR_INVALID_VALUE;
    }

    QueueAttr attr = {};
    const errno_t ret = strcpy_s(attr.name, sizeof(attr.name), queAttr->name);
    COND_LOG_ERROR(ret != EOK, "strcpy_s failed, size=%zu(bytes), retCode=%d!", sizeof(attr.name), ret);
    attr.depth = queAttr->depth;
    attr.workMode = queAttr->workMode;
    attr.flowCtrlFlag = queAttr->flowCtrlFlag;
    attr.flowCtrlDropTime = queAttr->flowCtrlDropTime;
    attr.overWriteFlag = queAttr->overWriteFlag;
    attr.deploy_type = queAttr->deployType;
    RT_LOG(RT_LOG_INFO, "create mem queue, drv devId=%d, name=%s.", devId, attr.name);

    const drvError_t drvRet = halQueueCreate(static_cast<uint32_t>(devId), &attr, qid);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halQueueCreate failed, drvRetCode=%d, drvDevId=%d, name=%s.",
            static_cast<int32_t>(drvRet), devId, attr.name);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueDestroy(const int32_t devId, const uint32_t qid)
{
    RT_LOG(RT_LOG_INFO, "drv devId=%d, qid=%u.", devId, qid);
    COND_RETURN_WARN(
        &halQueueDestroy == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueueDestroy does not exist.");
    const drvError_t drvRet = halQueueDestroy(static_cast<uint32_t>(devId), qid);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halQueueDestroy failed, drvRetCode=%d, drvDevId=%d, qid=%u.",
            static_cast<int32_t>(drvRet), devId, qid);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

static rtError_t CheckMemQueueSupported(bool& isSupported)
{
    int32_t halAPIVersion = 0;
    const drvError_t drvRet = halGetAPIVersion(&halAPIVersion);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halGetAPIVersion failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    const uint32_t majorVersion = ((static_cast<uint32_t>(halAPIVersion) & MAJOR_VERSION_MASK) >> MAJOR_VERSION_OFFSET);
    RT_LOG(RT_LOG_INFO, "get majorVersion %u", majorVersion);
    if (majorVersion < MEM_QUEUE_SUPPORT_VERSION) {
        isSupported = false;
    } else {
        isSupported = true;
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueInit(const int32_t devId)
{
    RT_LOG(RT_LOG_INFO, "init mem queue, drv devId=%d.", devId);
    COND_RETURN_WARN(&halQueueInit == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueueInit does not exist.");
    bool isSupported = true;
    const rtError_t ret = CheckMemQueueSupported(isSupported);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "CheckMemQueueSupported failed");
    if (!isSupported) {
        RT_LOG(RT_LOG_INFO, "mem queue feature is not supported, drv devId=%d.", devId);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    drvError_t drvRet = halQueueInit(static_cast<uint32_t>(devId));
    COND_RETURN_WARN(drvRet == DRV_ERROR_REPEATED_INIT, RT_GET_DRV_ERRCODE(drvRet), "repeated init"); // special state
    COND_RETURN_WARN(drvRet == DRV_ERROR_NOT_SUPPORT, RT_GET_DRV_ERRCODE(drvRet), "not support");     // special state
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halQueueInit failed, drvRetCode=%d, drvDevId=%d.", static_cast<int32_t>(drvRet),
            devId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    // get max mbuf cnt in queue init
    QueueQueryCmdType drvCmd = QUEUE_QUERY_MAX_IOVEC_NUM;
    QueueQueryInputPara inputPara = {nullptr, 0U};

    const std::unique_ptr<QueueQueryOutput> outputUniquePtr(new (std::nothrow)(QueueQueryOutput));
    COND_RETURN_AND_MSG_OUTER(
        outputUniquePtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
        std::to_string(sizeof(QueueQueryOutput)).c_str(), "new");
    QueueQueryOutput* const output = outputUniquePtr.get();

    const errno_t rc = memset_s(RtPtrToPtr<void*>(output), sizeof(QueueQueryOutput), 0, sizeof(QueueQueryOutput));
    COND_LOG_ERROR(rc != EOK, "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(QueueQueryOutput), rc);
    QueueQueryOutputPara outputPara = {output, static_cast<uint32_t>(sizeof(QueueQueryOutput))};

    drvRet = halQueueQuery(static_cast<uint32_t>(devId), drvCmd, &inputPara, &outputPara);
    COND_RETURN_ERROR(
        ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_NOT_SUPPORT)), RT_GET_DRV_ERRCODE(drvRet),
        "query max queue num failed"); // special state
    // only success g_maxBufCnt can be replaced
    if (drvRet == DRV_ERROR_NONE) {
        g_maxBufCnt = output->queQueryMaxIovecNum.count;
    }
    RT_LOG(RT_LOG_INFO, "get max queue cnt %u success.", g_maxBufCnt);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueReset(const int32_t devId, const uint32_t qid)
{
    RT_LOG(RT_LOG_INFO, "drv devId=%d, qid=%u.", devId, qid);
    COND_RETURN_WARN(
        &halQueueReset == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueueReset does not exist.");
    const drvError_t drvRet = halQueueReset(static_cast<uint32_t>(devId), qid);
    COND_RETURN_WARN(
        drvRet == DRV_ERROR_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueueReset does not support.");
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halQueueReset failed, drvRetCode=%d, drvDevId=%d, qid=%u.",
            static_cast<int32_t>(drvRet), devId, qid);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueExport(
    const int32_t devId, const uint32_t qid, const int32_t peerDevId, const char* const shareName)
{
    COND_RETURN_WARN(
        &halQueueExport == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueueExport does not exist.");
    RT_LOG(RT_LOG_INFO, "Export mem queue, drv devId=%d, qid=%u, peerDevId=%d.", devId, qid, peerDevId);

    shareQueInfo queInfo = {};
    queInfo.peerDevId = peerDevId;
    errno_t ret = strcpy_s(queInfo.shareQueName, SHARE_QUEUE_NAME_LEN, shareName);
    COND_RETURN_WARN(ret != EOK, RT_ERROR_INVALID_VALUE, "strcpy_s failed!");

    const drvError_t drvRet = halQueueExport(devId, qid, &queInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halQueueExport failed, drvRetCode=%d, drvDevId=%d, qid=%u, peerDevId=%d.",
            static_cast<int32_t>(drvRet), devId, qid, peerDevId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueUnExport(
    const int32_t devId, const uint32_t qid, const int32_t peerDevId, const char* const shareName)
{
    COND_RETURN_WARN(
        &halQueueUnexport == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueueUnexport does not exist.");
    RT_LOG(RT_LOG_INFO, "UnExport mem queue, drv devId=%d, qid=%u, peerDevId=%d.", devId, qid, peerDevId);

    shareQueInfo queInfo = {};
    queInfo.peerDevId = peerDevId;
    errno_t ret = strcpy_s(queInfo.shareQueName, SHARE_QUEUE_NAME_LEN, shareName);
    COND_RETURN_WARN(ret != EOK, RT_ERROR_INVALID_VALUE, "strcpy_s failed!");

    const drvError_t drvRet = halQueueUnexport(devId, qid, &queInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halQueueUnexport failed, drvRetCode=%d, drvDevId=%d, qid=%u, peerDevId=%d.",
            static_cast<int32_t>(drvRet), devId, qid, peerDevId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueImport(
    const int32_t devId, const int32_t peerDevId, const char* const shareName, uint32_t* const qid)
{
    COND_RETURN_WARN(
        &halQueueImport == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueueImport does not exist.");
    RT_LOG(RT_LOG_INFO, "Import mem queue, drv devId=%d, peerDevId=%d.", devId, peerDevId);

    shareQueInfo queInfo = {};
    queInfo.peerDevId = peerDevId;
    errno_t ret = strcpy_s(queInfo.shareQueName, SHARE_QUEUE_NAME_LEN, shareName);
    COND_RETURN_WARN(ret != EOK, RT_ERROR_INVALID_VALUE, "strcpy_s failed!");

    const drvError_t drvRet = halQueueImport(devId, &queInfo, qid);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halQueueImport failed, drvRetCode=%d, drvDevId=%d, peerDevId=%d.",
            static_cast<int32_t>(drvRet), devId, peerDevId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueUnImport(
    const int32_t devId, const uint32_t qid, const int32_t peerDevId, const char* const shareName)
{
    COND_RETURN_WARN(
        &halQueueUnimport == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueueUnimport does not exist.");
    RT_LOG(RT_LOG_INFO, "UnImport mem queue, drv devId=%d, qid=%u, peerDevId=%d.", devId, qid, peerDevId);

    shareQueInfo queInfo = {};
    queInfo.peerDevId = peerDevId;
    errno_t ret = strcpy_s(queInfo.shareQueName, SHARE_QUEUE_NAME_LEN, shareName);
    COND_RETURN_WARN(ret != EOK, RT_ERROR_INVALID_VALUE, "strcpy_s failed!");

    const drvError_t drvRet = halQueueUnimport(devId, qid, &queInfo);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halQueueUnimport failed, drvRetCode=%d, drvDevId=%d, peerDevId=%d.",
            static_cast<int32_t>(drvRet), devId, peerDevId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueGrant(
    const int32_t devId, const uint32_t qid, const int32_t pid, const rtMemQueueShareAttr_t* const attr)
{
    RT_LOG(RT_LOG_INFO, "grant mem queue, drv devId=%d, qid=%u, pid=%d.", devId, qid, pid);

    COND_RETURN_WARN(
        &halQueueGrant == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueueGrant does not exist.");
    QueueShareAttr drvAttr = {};
    drvAttr.manage = attr->manage;
    drvAttr.read = attr->read;
    drvAttr.write = attr->write;
    const drvError_t drvRet = halQueueGrant(static_cast<uint32_t>(devId), static_cast<int32_t>(qid), pid, drvAttr);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halQueueGrant failed, drvRetCode=%d, drvDevId=%d, qid=%u, pid=%d.",
            static_cast<int32_t>(drvRet), devId, qid, pid);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueSet(
    const int32_t devId, const rtMemQueueSetCmdType cmd, const rtMemQueueSetInputPara* const input)
{
    COND_RETURN_WARN(&halQueueSet == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueueSet does not exist.");
    COND_RETURN_ERROR(input == nullptr, RT_ERROR_DRV_INPUT, "input is nullptr");

    QueueSetCmdType const type = static_cast<QueueSetCmdType>(cmd);
    QueueSetInputPara para;
    para.inBuff = input->inBuff;
    para.inLen = input->inLen;
    RT_LOG(RT_LOG_INFO, "drv devId=%d, type=%d.", devId, static_cast<int32_t>(cmd));

    const drvError_t drvRet = halQueueSet(static_cast<uint32_t>(devId), type, &para);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halQueueSet failed, drvRetCode=%d, drvDevId=%d, type=%s(%d).",
            static_cast<int32_t>(drvRet), devId, MemQueueSetCmdTypeName(cmd), static_cast<int32_t>(cmd));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueEnQueue(const int32_t devId, const uint32_t qid, void* const memBuf)
{
    RT_LOG(RT_LOG_INFO, "Enqueue, drv devId=%d, qid=%u.", devId, qid);
    COND_RETURN_WARN(
        &halQueueEnQueue == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueueEnQueue does not exist.");
    const drvError_t drvRet = halQueueEnQueue(static_cast<uint32_t>(devId), qid, memBuf);
    COND_RETURN_WARN(drvRet == DRV_ERROR_QUEUE_FULL, RT_GET_DRV_ERRCODE(drvRet), "queue full"); // special state
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halQueueEnQueue failed, drvRetCode=%d, drvDevId=%d, qid=%u.",
            static_cast<int32_t>(drvRet), devId, qid);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueDeQueue(const int32_t devId, const uint32_t qid, void** const memBuf)
{
    RT_LOG(RT_LOG_INFO, "dequeue, drv devId=%d, qid=%u.", devId, qid);
    COND_RETURN_WARN(
        &halQueueDeQueue == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueueDeQueue does not exist.");
    const drvError_t drvRet = halQueueDeQueue(static_cast<uint32_t>(devId), qid, memBuf);
    COND_RETURN_WARN(drvRet == DRV_ERROR_QUEUE_EMPTY, RT_GET_DRV_ERRCODE(drvRet), "queue empty"); // special state
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halQueueDeQueue failed, drvRetCode=%d, drvDevId=%d, qid=%u.",
            static_cast<int32_t>(drvRet), devId, qid);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

static rtError_t GetBuffIovec(struct buff_iovec* const vec, const rtMemQueueBuff_t* const inBuf, bool& baseNeedFree)
{
    baseNeedFree = false;
    if (vec->count == inBuf->buffCount) {
        for (uint32_t i = 0U; i < inBuf->buffCount; ++i) {
            vec->ptr[i].iovec_base = inBuf->buffInfo[i].addr;
            vec->ptr[i].len = inBuf->buffInfo[i].len;
        }
        return RT_ERROR_NONE;
    }

    size_t len = 0U;
    for (uint32_t i = 0U; i < inBuf->buffCount; ++i) {
        COND_RETURN_ERROR(
            len > (SIZE_MAX - inBuf->buffInfo[i].len), RT_ERROR_INVALID_VALUE,
            "Overflow occur when calculate total size, current len is %zu, added len is %zu.", len,
            inBuf->buffInfo[i].len);
        len += inBuf->buffInfo[i].len;
    }
    COND_RETURN_ERROR(len == 0U, RT_ERROR_INVALID_VALUE, "malloc len can not be 0");
    char_t* tempBuff = new (std::nothrow) char_t[len];
    COND_RETURN_AND_MSG_OUTER(
        tempBuff == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, std::to_string(len).c_str(), "new");
    size_t offset = 0U;
    for (uint32_t i = 0U; i < inBuf->buffCount; ++i) {
        const drvError_t drvRet = drvMemcpy(
            static_cast<DVdeviceptr>(RtPtrToPtr<uintptr_t>(tempBuff) + offset), (len - offset),
            RtPtrToPtr<DVdeviceptr>((inBuf->buffInfo[i].addr)), inBuf->buffInfo[i].len);
        if (drvRet != DRV_ERROR_NONE) {
            delete[] tempBuff;
            tempBuff = nullptr;
            DRV_ERROR_PROCESS(
                drvRet, "Call driver api drvMemcpy failed, drvRetCode=%d, copy size is %zu.",
                static_cast<int32_t>(drvRet), inBuf->buffInfo[i].len);
            return RT_GET_DRV_ERRCODE(drvRet);
        }
        offset += inBuf->buffInfo[i].len;
    }
    baseNeedFree = true;
    vec->ptr[0].iovec_base = tempBuff; // array count is 1
    vec->ptr[0].len = len;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueEnQueueBuff(
    const int32_t devId, const uint32_t qid, const rtMemQueueBuff_t* const inBuf, const int32_t timeout)
{
    RT_LOG(RT_LOG_INFO, "drv devId=%d, qid=%u, timeout=%dms, maxBufCnt is %u.", devId, qid, timeout, g_maxBufCnt);

    COND_RETURN_WARN(
        &halQueueEnQueueBuff == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueueEnQueueBuff does not exist.");

    uint32_t buffCnt = inBuf->buffCount;
    if (buffCnt > g_maxBufCnt) {
        RT_LOG(RT_LOG_WARNING, "buffCount %u larger than %u", inBuf->buffCount, g_maxBufCnt);
        buffCnt = 1U;
    }

    const size_t totalLen = sizeof(struct buff_iovec) + (buffCnt * sizeof(struct iovec_info));
    const std::unique_ptr<char_t[]> vecUniquePtr(new (std::nothrow) char_t[totalLen]);
    COND_RETURN_AND_MSG_OUTER(
        vecUniquePtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, std::to_string(totalLen).c_str(),
        "new");
    struct buff_iovec* const vec = RtPtrToPtr<buff_iovec*>(vecUniquePtr.get());

    vec->context_base = inBuf->contextAddr;
    vec->context_len = inBuf->contextLen;
    vec->count = buffCnt;
    bool baseNeedFree = false;
    const rtError_t ret = GetBuffIovec(vec, inBuf, baseNeedFree);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "GetBuffIovec failed");

    const drvError_t drvRet = halQueueEnQueueBuff(static_cast<uint32_t>(devId), qid, vec, timeout);
    if (baseNeedFree) {
        delete[] RtPtrToPtr<char_t*>(vec->ptr[0].iovec_base);
        vec->ptr[0].iovec_base = nullptr;
    }
    COND_RETURN_WARN(drvRet == DRV_ERROR_QUEUE_FULL, RT_GET_DRV_ERRCODE(drvRet), "queue full"); // special state
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halQueueEnQueueBuff failed, drvRetCode=%d, drvDevId=%d, qid=%u, timeout=%dms.",
            static_cast<int32_t>(drvRet), devId, qid, timeout);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueDeQueueBuff(
    const int32_t devId, const uint32_t qid, const rtMemQueueBuff_t* const outBuf, const int32_t timeout)
{
    RT_LOG(RT_LOG_INFO, "DeQueueBuff, drv devId=%d, qid=%u, timeout=%dms.", devId, qid, timeout);

    COND_RETURN_WARN(
        &halQueueDeQueueBuff == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueueDeQueueBuff does not exist.");

    const size_t totalLen = sizeof(struct buff_iovec) + (outBuf->buffCount * sizeof(struct iovec_info));
    const std::unique_ptr<char_t[]> vecUniquePtr(new (std::nothrow) char_t[totalLen]);
    COND_RETURN_AND_MSG_OUTER(
        vecUniquePtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, std::to_string(totalLen).c_str(),
        "new");
    struct buff_iovec* const vec = RtPtrToPtr<buff_iovec*>(vecUniquePtr.get());

    vec->context_base = outBuf->contextAddr;
    vec->context_len = outBuf->contextLen;
    vec->count = outBuf->buffCount;
    for (uint32_t i = 0U; i < outBuf->buffCount; ++i) {
        vec->ptr[i].iovec_base = outBuf->buffInfo[i].addr;
        vec->ptr[i].len = outBuf->buffInfo[i].len;
    }

    const drvError_t drvRet = halQueueDeQueueBuff(static_cast<uint32_t>(devId), qid, vec, timeout);
    COND_RETURN_WARN(drvRet == DRV_ERROR_QUEUE_EMPTY, RT_GET_DRV_ERRCODE(drvRet), "queue empty"); // special state
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halQueueDeQueueBuff failed, drvRetCode=%d, drvDevId=%d, qid=%u, timeout=%dms.",
            static_cast<int32_t>(drvRet), devId, qid, timeout);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueuePeek(const int32_t devId, const uint32_t qid, size_t* const bufLen, const int32_t timeout)
{
    RT_LOG(RT_LOG_INFO, "peek mem queue, drv devId=%d, qid=%u, timeout=%dms.", devId, qid, timeout);

    COND_RETURN_WARN(&halQueuePeek == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueuePeek does not exist.");

    uint64_t len = 0ULL;

    const drvError_t drvRet = halQueuePeek(static_cast<uint32_t>(devId), qid, &len, timeout);
    COND_RETURN_WARN(drvRet == DRV_ERROR_QUEUE_EMPTY, RT_GET_DRV_ERRCODE(drvRet), "queue empty"); // special state
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halQueuePeek failed, drvRetCode=%d, drvDevId=%d, qid=%u, timeout=%dms.",
            static_cast<int32_t>(drvRet), devId, qid, timeout);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    *bufLen = static_cast<size_t>(len);
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueQuery(
    const int32_t devId, const rtMemQueueQueryCmd_t cmd, const void* const inBuff, const uint32_t inLen,
    void* const outBuff, const uint32_t* const outLen)
{
    RT_LOG(RT_LOG_INFO, "query mem queue, drv devId=%d, cmd=%d.", devId, static_cast<int32_t>(cmd));

    COND_RETURN_WARN(
        &halQueueQuery == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueueQuery does not exist.");
    COND_RETURN_WARN(
        cmd != RT_MQ_QUERY_QUE_ATTR_OF_CUR_PROC, RT_ERROR_INVALID_VALUE, "[drv api] cmd=%d is not supported.",
        static_cast<int32_t>(cmd));
    COND_RETURN_WARN(
        static_cast<size_t>(inLen) < sizeof(int32_t), RT_ERROR_INVALID_VALUE,
        "[drv api] outputLen=%u(bytes) < %zu(bytes).", inLen, sizeof(int32_t));
    COND_RETURN_WARN(
        static_cast<size_t>(*outLen) < sizeof(rtMemQueueShareAttr_t), RT_ERROR_INVALID_VALUE,
        "[drv api] outputLen=%u(bytes) < %zu(bytes).", inLen, sizeof(rtMemQueueShareAttr_t));

    const QueueQueryCmdType drvCmd = static_cast<QueueQueryCmdType>(cmd);

    // input
    QueueQueryInput input;
    errno_t ret = memset_s(&input, sizeof(input), 0, sizeof(input));
    COND_LOG_ERROR(ret != EOK, "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(input), ret);
    input.queQueryQueueAttr.qid = *(RtPtrToPtr<const int32_t*>(inBuff));
    QueueQueryInputPara inputPara = {&input, static_cast<uint32_t>(sizeof(input))};

    // output, the length is too large, malloc is required.
    const std::unique_ptr<QueueQueryOutput> outputUniquePtr(new (std::nothrow)(QueueQueryOutput));
    COND_RETURN_AND_MSG_OUTER(
        outputUniquePtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
        std::to_string(sizeof(QueueQueryOutput)).c_str(), "new");
    QueueQueryOutput* const output = outputUniquePtr.get();

    ret = memset_s(RtPtrToPtr<void*>(output), sizeof(QueueQueryOutput), 0, sizeof(QueueQueryOutput));
    COND_LOG_ERROR(ret != EOK, "memset_s failed, size=%zu(bytes), retCode=%d!", sizeof(QueueQueryOutput), ret);
    QueueQueryOutputPara outputPara = {output, static_cast<uint32_t>(sizeof(QueueQueryOutput))};

    const drvError_t drvRet = halQueueQuery(static_cast<uint32_t>(devId), drvCmd, &inputPara, &outputPara);
    COND_RETURN_ERROR(
        drvRet != DRV_ERROR_NONE, RT_GET_DRV_ERRCODE(drvRet),
        "[drv api] halQueueQuery failed: drv devId=%d, drvRetCode=%d.", devId, static_cast<int32_t>(drvRet));
    rtMemQueueShareAttr_t* const rtsAttr = RtPtrToPtr<rtMemQueueShareAttr_t*>(outBuff);
    rtsAttr->manage = output->queQueryQueueAttrInfo.attr.manage;
    rtsAttr->read = output->queQueryQueueAttrInfo.attr.read;
    rtsAttr->write = output->queQueryQueueAttrInfo.attr.write;
    rtsAttr->rsv = output->queQueryQueueAttrInfo.attr.rsv;
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueGetQidByName(const int32_t devId, const char_t* const name, uint32_t* const qId)
{
    RT_LOG(RT_LOG_INFO, "Esched attach device, drv devId=%d.", devId);

    COND_RETURN_WARN(
        &halQueueGetQidbyName == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT,
        "[drv api] halQueueGetQidbyName does not exist.");

    const drvError_t drvRet = halQueueGetQidbyName(static_cast<uint32_t>(devId), name, qId);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halQueueGetQidbyName failed, drvRetCode=%d, drvDevId=%d.",
            static_cast<int32_t>(drvRet), devId);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQueueAttach(const int32_t devId, const uint32_t qid, const int32_t timeout)
{
    RT_LOG(RT_LOG_INFO, "attach mem queue, drv devId=%d, qid=%u, timeout=%dms.", devId, qid, timeout);

    COND_RETURN_WARN(
        &halQueueAttach == nullptr, RT_ERROR_FEATURE_NOT_SUPPORT, "[drv api] halQueueAttach does not exist.");

    const drvError_t drvRet = halQueueAttach(static_cast<uint32_t>(devId), qid, timeout);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halQueueAttach failed, drvRetCode=%d, drvDevId=%d, qid=%u, timeout=%dms.",
            static_cast<int32_t>(drvRet), devId, qid, timeout);
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    return RT_ERROR_NONE;
}

rtError_t NpuDriver::MemQEventCrossDevSupported(int32_t* const isSupported)
{
    int32_t halAPIVersion = 0;
    const drvError_t drvRet = halGetAPIVersion(&halAPIVersion);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(
            drvRet, "Call driver api halGetAPIVersion failed, drvRetCode=%d.", static_cast<int32_t>(drvRet));
        return RT_GET_DRV_ERRCODE(drvRet);
    }

    RT_LOG(RT_LOG_INFO, "get halAPIVersion %d", halAPIVersion);
    if (halAPIVersion < MEMQ_EVENT_CROSS_DEV_VERSION) {
        *isSupported = static_cast<int32_t>(false);
    } else {
        *isSupported = static_cast<int32_t>(true);
    }
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
