

/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hwts_kernel_queue.h"

#include "ascend_hal.h"
#include "aicpusd_monitor.h"
#include "aicpusd_drv_manager.h"
#include "hwts_kernel_common.h"

namespace AicpuSchedule {
namespace {
const std::string CREATE_QUEUE = "CreateQueue";
const std::string DESTROY_QUEUE = "DestroyQueue";
constexpr uint64_t TO_US = 1000000UL;
constexpr GroupShareAttr GROUP_WITH_ALL_ATTR = {1U, 1U, 1U, 1U, 0U}; // admin + read + write + alloc
}  // namespace

int32_t CreateQueueTsKernel::DoQueueSubscrible(const QueueAttr &queAttr, uint32_t *queueId) const
{
    const uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
    auto drvRet = halQueueInit(deviceId);
    if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_REPEATED_INIT)) {
        aicpusd_err("halQueueInit error, deviceId[%u], drvRet[%d]", deviceId, drvRet);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    drvRet = halQueueCreate(deviceId, &queAttr, queueId);
    if (drvRet != DRV_ERROR_NONE) {
        aicpusd_err("Create buff queue[%s] error, depth[%u], ret[%d]", queAttr.name, queAttr.depth, drvRet);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    const int32_t ret = SubscribeEvent(deviceId, *queueId);
    if (ret != AICPU_SCHEDULE_OK) {
        (void)halQueueDestroy(deviceId, *queueId);
        return ret;
    }

    return AICPU_SCHEDULE_OK;
}

int32_t CreateQueueTsKernel::Compute(const aicpu::HwtsTsKernel &tsKernelInfo)
{
    const aicpu::HwtsCceKernel &kernel = tsKernelInfo.kernelBase.cceKernel;
    // create queue op param : queueId(uint64_t) + queueName(128 char) + queueDepth(uint32_t)
    constexpr size_t len = sizeof(aicpu::AicpuParamHead) + sizeof(uint64_t) +
                           static_cast<size_t>(QUEUE_MAX_STR_LEN) + sizeof(uint32_t);
    size_t offset = sizeof(aicpu::AicpuParamHead);
    const auto baseAddr = PtrToPtr<void, char_t>(ValueToPtr(kernel.paramBase));
    const aicpu::AicpuParamHead * const paramHead = PtrToPtr<char_t, aicpu::AicpuParamHead>(baseAddr);
    if (paramHead == nullptr) {
        aicpusd_err("ParamHead for create queue is nullptr");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    if (static_cast<size_t>(paramHead->length) != len) {
        aicpusd_err("Create queue param length[%u] should be [%zu]", paramHead->length, len);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const int32_t ret = CreateGrp();
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("CreateGrp abnormal, ret = %d.", ret);
        return ret;
    }

    const uint64_t queueIdAddr = *PtrToPtr<const char_t, const uint64_t>(PtrAdd<const char_t>(baseAddr, len, offset));
    const auto queueId = PtrToPtr<void, uint32_t>(ValueToPtr(queueIdAddr));

    offset += sizeof(uint64_t);
    const auto queueName = PtrAdd<const char_t>(baseAddr, static_cast<size_t>(paramHead->length), offset);

    QueueAttr queAttr = {};
    const auto memcpyRet = memcpy_s(queAttr.name, static_cast<size_t>(QUEUE_MAX_STR_LEN),
                                    queueName, static_cast<size_t>(QUEUE_MAX_STR_LEN));
    if (memcpyRet != EOK) {
        aicpusd_err("Memcpy_s failed, ret=%d.", memcpyRet);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    offset += static_cast<size_t>(QUEUE_MAX_STR_LEN);
    const uint32_t queueDepth = *PtrToPtr<const char_t, const uint32_t>(PtrAdd<const char_t>(baseAddr, len, offset));
    queAttr.depth = queueDepth;
    queAttr.workMode = QUEUE_MODE_PULL;

    return DoQueueSubscrible(queAttr, queueId);
}

int32_t CreateQueueTsKernel::CreateGrp() const
{
    const pid_t curPid = drvDeviceGetBareTgid();
    std::map<std::string, GroupShareAttr> buffGrpInfo;
    const auto ret = AicpuDrvManager::GetInstance().QueryProcBuffInfo(static_cast<uint32_t>(curPid), buffGrpInfo);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Fail to get group info of master aicpusd[%d]", curPid);
        return ret;
    }
    // 0 group need to create group
    if (buffGrpInfo.size() == 0UL) {
        aicpusd_info("There is no group for master aicpusd[%d]. Create new group", curPid);
        struct timeval tv = {};
        (void)gettimeofday(&tv, nullptr);
        const uint64_t groupNameAddition =
            (static_cast<uint64_t>(tv.tv_sec) * TO_US) + (static_cast<uint64_t>(tv.tv_usec));
        const std::string groupName = "Aicpusd" + std::to_string(groupNameAddition);
        GroupCfg groupConf = {};
        groupConf.privMbufFlag = static_cast<uint32_t>(BUFF_ENABLE_PRIVATE_MBUF);
        // 1.create group
        auto drvRet = halGrpCreate(groupName.c_str(), &groupConf);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Create group failed in aicpusd[%d], result[%d]", curPid, drvRet);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }

        // 2.add current process to new group
        drvRet = halGrpAddProc(groupName.c_str(), curPid, GROUP_WITH_ALL_ATTR);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Add group[%s] for master aicpusd[%d] failed, ret[%d]",
                groupName.c_str(), curPid, drvRet);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }

        drvRet = halGrpAttach(groupName.c_str(), 0);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Attach group[%s] for master aicpusd[%d] failed, ret[%d]",
                groupName.c_str(), curPid, drvRet);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }

        // 3.initial process
        BuffCfg buffCfg = {};
        drvRet = halBuffInit(&buffCfg);
        if (drvRet != DRV_ERROR_NONE) {
            aicpusd_err("Buffer initial failed for master aicpusd[%d], ret[%d]", curPid, drvRet);
            return AICPU_SCHEDULE_ERROR_DRV_ERR;
        }
        aicpusd_info("Create new group[%s] for master aicpusd[%d] success", groupName.c_str(), curPid);
    }
    return AICPU_SCHEDULE_OK;
}

int32_t CreateQueueTsKernel::SubscribeEvent(const uint32_t deviceId, const uint32_t queueId) const
{
    int32_t ret = halQueueSubscribe(deviceId, queueId, 0U, QUEUE_TYPE_SINGLE);
    if ((ret != DRV_ERROR_NONE) && (ret != DRV_ERROR_QUEUE_RE_SUBSCRIBED)) {
        aicpusd_err("Subscribe queue[%u] failed, ret[%d].", queueId, ret);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    if ((ret == DRV_ERROR_QUEUE_RE_SUBSCRIBED) && (Resubscribe(deviceId, queueId) != AICPU_SCHEDULE_OK)) {
        aicpusd_err("Resubscribe queue[%u] failed.", queueId);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    ret = halQueueSubF2NFEvent(deviceId, queueId, 0U);
    if ((ret != DRV_ERROR_NONE) && (ret != DRV_ERROR_QUEUE_RE_SUBSCRIBED)) {
        aicpusd_err("Subscribe queue[%u] F2NF event failed, ret[%d].", queueId, ret);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    if ((ret == DRV_ERROR_QUEUE_RE_SUBSCRIBED) && (ResubscribeF2NF(deviceId, queueId) != AICPU_SCHEDULE_OK)) {
        aicpusd_err("Resubscribe queue[%u] F2NF event failed.", queueId);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }
    return AICPU_SCHEDULE_OK;
}

int32_t CreateQueueTsKernel::Resubscribe(const uint32_t deviceId, const uint32_t queueId) const
{
    int32_t queueStatus = halQueueUnsubscribe(deviceId, queueId);
    if ((queueStatus != DRV_ERROR_NONE) && (queueStatus != DRV_ERROR_NOT_EXIST)) {
        aicpusd_err("Unsubscribe queue[%u] failed, ret[%d].", queueId, queueStatus);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    queueStatus = halQueueSubscribe(deviceId, queueId, 0U, QUEUE_TYPE_SINGLE);
    if (queueStatus != DRV_ERROR_NONE) {
        aicpusd_err("Subscribe queue[%u] failed, ret[%d].", queueId, queueStatus);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }
    return AICPU_SCHEDULE_OK;
}

int32_t CreateQueueTsKernel::ResubscribeF2NF(const uint32_t deviceId, const uint32_t queueId) const
{
    int32_t queueStatus = halQueueUnsubF2NFEvent(deviceId, queueId);
    if ((queueStatus != DRV_ERROR_NONE) && (queueStatus != DRV_ERROR_NOT_EXIST)) {
        aicpusd_err("Unsub F2NF event for queue[%u] failed, ret[%d].", queueId, queueStatus);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    queueStatus = halQueueSubF2NFEvent(deviceId, queueId, 0U);
    if (queueStatus != DRV_ERROR_NONE) {
        aicpusd_err("Sub F2NF event for queue[%u] failed, ret=%d.", queueId, queueStatus);
        return AICPU_SCHEDULE_ERROR_DRV_ERR;
    }
    return AICPU_SCHEDULE_OK;
}

int32_t DestroyQueueTsKernel::Compute(const aicpu::HwtsTsKernel &tsKernelInfo)
{
    const aicpu::HwtsCceKernel &kernel = tsKernelInfo.kernelBase.cceKernel;
    // destroy queue op param : queueId(uint32_t)
    constexpr uint64_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(uint32_t);
    constexpr uint64_t offset = sizeof(aicpu::AicpuParamHead);
    const auto baseAddr = PtrToPtr<void, char_t>(ValueToPtr(kernel.paramBase));
    const aicpu::AicpuParamHead * const paramHead = PtrToPtr<char_t, aicpu::AicpuParamHead>(baseAddr);
    if (paramHead == nullptr) {
        aicpusd_err("ParamHead for DumpDataKernel is nullptr");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    if (paramHead->length != len) {
        aicpusd_err("Destroy queue param length[%u] should be [%lu]", paramHead->length, len);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const uint32_t queueId = *PtrToPtr<const char_t, const uint32_t>(PtrAdd<const char_t>(baseAddr, len, offset));
    const uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();

    int32_t eventRet = AICPU_SCHEDULE_OK;
    int32_t ret = halQueueUnsubscribe(deviceId, queueId);
    if ((ret != DRV_ERROR_NONE) && (ret != DRV_ERROR_NOT_EXIST)) {
        aicpusd_err("Unsubscribe queue[%u] failed, ret[%d].", queueId, ret);
        eventRet = AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    ret = halQueueUnsubF2NFEvent(deviceId, queueId);
    if ((ret != DRV_ERROR_NONE) && (ret != DRV_ERROR_NOT_EXIST)) {
        aicpusd_err("Unsubscribe  queue[%u] F2NF event failed, ret[%d].", queueId, ret);
        eventRet = AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    ret = halQueueDestroy(deviceId, queueId);
    if (ret != DRV_ERROR_NONE) {
        aicpusd_err("Destroy queue[%u] error, ret[%d]", queueId, ret);
        eventRet = AICPU_SCHEDULE_ERROR_DRV_ERR;
    }

    return eventRet;
}

REGISTER_HWTS_KERNEL(CREATE_QUEUE, CreateQueueTsKernel);
REGISTER_HWTS_KERNEL(DESTROY_QUEUE, DestroyQueueTsKernel);
}  // namespace AicpuSchedule