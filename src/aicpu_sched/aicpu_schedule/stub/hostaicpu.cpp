/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <list>
#include <string>
#include "tdt/status.h"
#include "task_queue.h"
#include "aicpusd_status.h"
#include "aicpusd_context.h"
#include "aicpusd_hccl_api.h"
#include "aicpusd_so_manager.h"
#include "aicpusd_event_manager.h"
#include "profiling_adp.h"
#include "aicpu_engine.h"
#include "aicpu_async_event.h"

namespace AicpuSchedule {
StatusCode GetAicpuDeployContext(DeployContext &deployContext)
{
    deployContext = DeployContext::HOSTCPU;
    return AICPU_SCHEDULE_OK;
}
AicpuSoManager &AicpuSoManager::GetInstance()
{
    static AicpuSoManager instance;
    return instance;
}
void AicpuSoManager::SetDeviceIdToDvpp(uint32_t deviceId)
{
    (void)deviceId;
    return;
}
AicpuSoManager::~AicpuSoManager()
{
}
}
namespace DataPreprocess {
    TaskQueueMgr& TaskQueueMgr::GetInstance()
    {
        static TaskQueueMgr instance;
        return instance;
    }

    TaskQueueMgr::TaskQueueMgr() {}
    TaskQueueMgr::~TaskQueueMgr() {}
    void TaskQueueMgr::OnPreprocessEvent(uint32_t eventId)
    {
        (void)eventId;
    }
} // namespace DataPreprocess

namespace tdt {
    int32_t TDTServerInit(const uint32_t deviceID, const std::list<uint32_t>& bindCoreList)
    {
        (void)deviceID;
        (void)bindCoreList;
        return 0;
    }

    int32_t TDTServerStop()
    {
        return 0;
    }

    StatusFactory* StatusFactory::GetInstance()
    {
        static StatusFactory instance_;
        return &instance_;
    }

    void StatusFactory::RegisterErrorNo(const uint32_t err, const std::string& desc)
    {
        (void)err;
        (void)desc;
    }

    std::string StatusFactory::GetErrDesc(const uint32_t err)
    {
        (void)err;
        return "";
    }

    std::string StatusFactory::GetErrCodeDesc(uint32_t errCode)
    {
        (void)errCode;
        return "";
    }

    StatusFactory::StatusFactory() {}
} // namespace tdt

#ifdef __cplusplus
extern "C" {
#endif
int halMbufChainGetMbuf(Mbuf *mbufChainHead, unsigned int index, Mbuf **mbuf)
{
    (void)mbufChainHead;
    (void)index;
    (void)mbuf;
    return DRV_ERROR_NONE;
}

int halBuffDeletePool(struct mempool_t *mp)
{
    (void)mp;
    return DRV_ERROR_NONE;
}

int halMbufGetDataLen(Mbuf *mbuf, uint64_t *len)
{
    (void)mbuf;
    (void)len;
    return DRV_ERROR_NONE;
}

int halMbufAllocByPool(poolHandle pHandle, Mbuf **mbuf)
{
    (void)pHandle;
    (void)mbuf;
    return DRV_ERROR_NONE;
}

int halBuffCreatePool(mpAttr *attr, struct mempool_t **mp)
{
    (void)attr;
    (void)mp;
    return DRV_ERROR_NONE;
}

int halMbufChainGetMbufNum(Mbuf *mbufChainHead, unsigned int *num)
{
    (void)mbufChainHead;
    (void)num;
    return DRV_ERROR_NONE;
}

int halMbufSetDataLen(Mbuf *mbuf, uint64_t len)
{
    (void)mbuf;
    (void)len;
    return DRV_ERROR_NONE;
}

int halMbufAllocEx(uint64_t size, unsigned int align, unsigned long flag, int grp_id, Mbuf **mbuf)
{
    (void)size;
    (void)align;
    (void)flag;
    (void)grp_id;
    (void)mbuf;
    return DRV_ERROR_NONE;
}

int halMbufChainAppend(Mbuf *mbufChainHead, Mbuf *mbuf)
{
    (void)mbufChainHead;
    (void)mbuf;
    return DRV_ERROR_NONE;
}

int halTsDevRecord(unsigned int devId, unsigned int tsId, unsigned int record_type, unsigned int record_Id)
{
    (void)devId;
    (void)tsId;
    (void)record_type;
    (void)record_Id;
    return 0;
}

int tsDevSendMsgAsync(unsigned int devId, unsigned int tsId, char *msg, unsigned int msgLen,
    unsigned int handleId)
{
    (void)devId;
    (void)tsId;
    (void)msg;
    (void)msgLen;
    (void)handleId;
    return 0;
}
int32_t CreateOrFindCustPid(const uint32_t deviceId, const uint32_t loadLibNum,
    const char * const loadLibName[], const uint32_t hostPid, const uint32_t vfId, const char *groupNameList,
    const uint32_t groupNameNum, int32_t *custProcPid, bool *firstStart)
{
    (void)deviceId;
    (void)loadLibNum;
    (void)loadLibName;
    (void)hostPid;
    (void)vfId;
    (void)groupNameList;
    (void)groupNameNum;
    (void)custProcPid;
    (void)firstStart;
    return 0;
}


int32_t SendUpdateProfilingRspToTsd(const uint32_t deviceId, const uint32_t waitType,
                                    const uint32_t hostPid, const uint32_t vfId)
{
    return 0;
}

int32_t SetSubProcScheduleMode(const uint32_t deviceId, const uint32_t waitType,
                               const uint32_t hostPid, const uint32_t vfId,
                               const struct SubProcScheduleModeInfo *scheInfo)
{
    (void)deviceId;
    (void)waitType;
    (void)hostPid;
    (void)vfId;
    (void)scheInfo;
    return 0;
}
#ifdef __cplusplus
}
#endif