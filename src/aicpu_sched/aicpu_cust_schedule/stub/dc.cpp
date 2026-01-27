/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_queue.h"
#include "tdt/status.h"
#include "ascend_hal.h"

int SetQueueWorkMode(unsigned int devid, unsigned int qid, int mode)
{
    (void)devid;
    (void)qid;
    (void)mode;
    return DRV_ERROR_NONE;
}

drvError_t halQueueInit(unsigned int devid)
{
    (void)devid;
    return DRV_ERROR_NONE;
}

drvError_t halQueueSubscribe(unsigned int devid, unsigned int qid, unsigned int groupId, int type)
{
    (void)devid;
    (void)qid;
    (void)groupId;
    (void)type;
    return DRV_ERROR_NONE;
}

drvError_t halQueueUnsubscribe(unsigned int devid, unsigned int qid)
{
    (void)devid;
    (void)qid;
    return DRV_ERROR_NONE;
}

drvError_t halQueueSubF2NFEvent(unsigned int devid, unsigned int qid, unsigned int groupid)
{
    (void)devid;
    (void)qid;
    (void)groupid;
    return DRV_ERROR_NONE;
}

drvError_t halQueueUnsubF2NFEvent(unsigned int devid, unsigned int qid)
{
    (void)devid;
    (void)qid;
    return DRV_ERROR_NONE;
}

drvError_t halQueueDeQueue(unsigned int devId, unsigned int qid, void **mbuf)
{
    (void)devId;
    (void)qid;
    (void)mbuf;
    return DRV_ERROR_NONE;
}

drvError_t halQueueEnQueue(unsigned int devId, unsigned int qid, void *mbuf)
{
    (void)devId;
    (void)qid;
    (void)mbuf;
    return DRV_ERROR_NONE;
}

int halMbufAlloc(unsigned int size, Mbuf **mbuf)
{
    (void)size;
    (void)mbuf;
    return DRV_ERROR_NONE;
}

int halMbufFree(Mbuf *mbuf)
{
    (void)mbuf;
    return DRV_ERROR_NONE;
}

int halMbufGetPrivInfo (Mbuf *mbuf,  void **priv, unsigned int *size)
{
    (void)mbuf;
    (void)priv;
    (void)size;
    return DRV_ERROR_NONE;
}

int buff_get_phy_addr (void *buf, unsigned long long *phyAddr)
{
    (void)buf;
    (void)phyAddr;
    return 0;
}

int halGrpQuery(GroupQueryCmdType cmd,
    void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen)
{
    (void)cmd;
    (void)inBuff;
    (void)inLen;
    (void)outBuff;
    *outLen = 0;
    return DRV_ERROR_NONE;
}

int halGrpAddProc(const char *name, int pid, GroupShareAttr attr)
{
    (void)name;
    (void)pid;
    (void)attr;
    return DRV_ERROR_NONE;
}

int halGrpAttach(const char *name, int timeout)
{
    (void)name;
    (void)timeout;
    return DRV_ERROR_NONE;
}

int halBuffInit(BuffCfg *cfg)
{
    (void)cfg;
    return DRV_ERROR_NONE;
}
namespace DataPreprocess {
    TaskQueueMgr& TaskQueueMgr::GetInstance()
    {
        static TaskQueueMgr instance;
        return instance;
    }

    TaskQueueMgr::TaskQueueMgr()
    {
        for (int32_t i = TASK_QUEUE_LOW_PRIORITY; i < TASK_QUEUE_MAX_PRIORITY; ++i) {
            preprocessEventfds_[i] = -1; // initialize fd
        }
    }
    TaskQueueMgr::~TaskQueueMgr() {}
    void TaskQueueMgr::OnPreprocessEvent(uint32_t eventId) {}
}
#ifdef  __cplusplus
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

    void StatusFactory::RegisterErrorNo(const uint32_t err, const std::string& desc) {}

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
}
#endif