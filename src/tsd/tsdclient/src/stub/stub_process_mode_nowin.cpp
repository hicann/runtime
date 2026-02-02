/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "inc/process_mode_manager.h"
#include "inc/weak_ascend_hal.h"
#include "driver/ascend_hal.h"
#include "common/type_def.h"
namespace tsd {
namespace {
// 每个OS上的1980芯片数目,每个芯片上每一种类型的进程都要创建一个，所以以芯片数为依据
constexpr uint32_t DEVICE_MAX_NUM = 32U;
const std::string TSDAEMON_HOST_NAME = "/var/tsdaemon";
constexpr uint32_t DOMAIN_SOCKET_CLIENT_DEFAULT_SESSIONID = 0U;
std::mutex g_hostStartFlagMut;
bool g_isStartHostAicpu = false;
constexpr uint32_t MAX_QUEUE_ID_NUM = 8192U;
}  // namespace
TSD_StatusT ProcessModeManager::ProcessQueueForAdc()
{
    if ((GetPlatInfoMode() != static_cast<uint32_t>(ModeType::OFFLINE)) || !IsAdcEnv()) {
        TSD_RUN_INFO("[TsdClient] it is unnecessary for current mode[%u] to grant queue auth to aicpusd",
            static_cast<uint32_t>(ModeType::OFFLINE));
        return TSD_OK;
    }
    const auto ret = SyncQueueAuthority();
    if (ret != TSD_OK) {
        constexpr uint32_t flag = 0;
        const auto closeRet = Close(flag);
        if (closeRet != TSD_OK) {
            TSD_RUN_WARN("[TsdClient]Sync queue authority failed, call close failed!");
            return closeRet;
        }
        TSD_RUN_WARN("[TsdClient]Sync queue authority failed, call close success!");
        return ret;
    }
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::ProcessQueueGrant(const QueueQueryOutputPara &queueInfoOutBuff,
                                                  const QueueQueryOutput * const queueInfoList,
                                                  const pid_t aicpuPid) const
{
    const uint32_t outLen = queueInfoOutBuff.outLen;
    if (outLen == 0U) {
        TSD_RUN_INFO("[TsdClient] Current process does not create queue yet. need not to sync");
        return TSD_OK;
    }
    if ((outLen % sizeof(queueInfoList->queQueryQuesOfProcInfo[0U])) != 0U) {
        TSD_ERROR("[TsdClient] QueueInfo outbuff size[%d] is invalid", outLen);
        return TSD_INTERNAL_ERROR;
    }
    const uint32_t queueNum = static_cast<uint32_t>(outLen / sizeof(queueInfoList->queQueryQuesOfProcInfo[0U]));
    TSD_RUN_INFO("[TsdClient] ProcessQueueGrant queueNum[%u]", queueNum);
    for (uint32_t i = 0U; i < queueNum; ++i) {
        const uint32_t queueId = static_cast<uint32_t>(queueInfoList->queQueryQuesOfProcInfo[i].qid);
        if (queueId >= MAX_QUEUE_ID_NUM) {
            TSD_ERROR("Get invalid queueid[%d]", queueId);
            return TSD_INTERNAL_ERROR;
        }
        if (!static_cast<bool>(queueInfoList->queQueryQuesOfProcInfo[i].attr.manage)) {
            continue;
        }
        const auto drvRet = halQueueGrant(logicDeviceId_, static_cast<int32_t>(queueId),
            aicpuPid, queueInfoList->queQueryQuesOfProcInfo[i].attr);
        if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_NOT_SUPPORT)) {
            TSD_ERROR("[TsdClient]Grant qid[%u] failed, ret[%d]", queueId, drvRet);
            return TSD_INTERNAL_ERROR;
        }
    }
    TSD_RUN_INFO("[TsdClient] ProcessQueueGrant process success");
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::SyncQueueAuthority() const
{
    TSD_RUN_INFO("[TsdClient] Current type is ADC. Sync queue auth start.");
    auto drvRet = halQueueInit(logicDeviceId_);
    if ((drvRet != DRV_ERROR_NONE) && (drvRet != DRV_ERROR_REPEATED_INIT) && (drvRet != DRV_ERROR_NOT_SUPPORT)) {
        TSD_ERROR("[TsdClient] halQueueInit error, drvRet[%d]", drvRet);
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO("[TsdClient]Interface halQueueInit success.");
    pid_t aicpuPid = -1;
    const auto ret = GetAicpusdPid(aicpuPid);
    if ((aicpuPid == -1) || (ret != TSD_OK)) {
        return ret;
    }
    // get all queue ids and attributes of host process
    pid_t srcPid = drvDeviceGetBareTgid();
    std::unique_ptr<QueueQueryOutput> queueInfoListPtr(new (std::nothrow) QueueQueryOutput());
    if (queueInfoListPtr == nullptr) {
        TSD_ERROR("[TsdClient] fail to alloc queueInfoListPtr");
        return TSD_INTERNAL_ERROR;
    }
    QueueQueryOutput *queueInfoList = queueInfoListPtr.get();
    if (queueInfoList == nullptr) {
        TSD_ERROR("[TsdClient] queueInfoList is null");
        return TSD_INTERNAL_ERROR;
    }
    QueueQueryOutputPara queueInfoOutBuff = {PtrToPtr<QueueQueryOutput, void>(queueInfoList),
                                             static_cast<uint32_t>(sizeof(QueueQueryOutput))};
    QueueQueryInputPara queueInput = {PtrToPtr<pid_t, void>(&srcPid), static_cast<uint32_t>(sizeof(srcPid))};
    drvRet = halQueueQuery(logicDeviceId_, QUEUE_QUERY_QUES_OF_CUR_PROC, &queueInput, &queueInfoOutBuff);
    if (drvRet == DRV_ERROR_NOT_SUPPORT) {
        TSD_RUN_INFO("[TsdClient] halQueueQuery is not supported in current chip type.");
        return TSD_OK;
    }
    if (drvRet != DRV_ERROR_NONE) {
        TSD_ERROR("[TsdClient] halQueueQuery execute failed, ret[%d]", drvRet);
        return TSD_INTERNAL_ERROR;
    }

    return ProcessQueueGrant(queueInfoOutBuff, queueInfoList, aicpuPid);
}

TSD_StatusT ProcessModeManager::GetAicpusdPid(pid_t &aicpusdPid) const
{
    aicpusdPid = -1;
    const pid_t srcPid = drvDeviceGetBareTgid();
    if (&halQueryDevpid == nullptr) {
        TSD_RUN_INFO("[TsdClient] halQueryDevpid is nullptr, interface is not supported in current version.");
        return TSD_OK;
    }
    halQueryDevpidInfo para = {};
    para.hostpid = srcPid;
    para.proc_type = DEVDRV_PROCESS_CP1;
    para.vfid = 0U;
    para.devid = logicDeviceId_;
    const auto drvRet = halQueryDevpid(para, &aicpusdPid);
    if (drvRet == DRV_ERROR_NOT_SUPPORT) {
        TSD_RUN_INFO("[TsdClient] halQueryDevpid is not supported in current chip type.");
        return TSD_OK;
    }
    if ((drvRet != DRV_ERROR_NONE) || (aicpusdPid == -1)) {
        TSD_ERROR("[TsdClient]Get aicpusd pid failed, result[%d]", drvRet);
        return TSD_INTERNAL_ERROR;
    }
    TSD_RUN_INFO(
        "Get aicpusd[%d] from host[%d] success.", static_cast<int32_t>(srcPid), static_cast<int32_t>(aicpusdPid));
    return TSD_OK;
}

}