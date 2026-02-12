/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef QUEUE_SCHEDULE_STUB_H
#define QUEUE_SCHEDULE_STUB_H

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mockcpp/ChainingMockHelper.h"

#include <condition_variable>
#include <algorithm>
#include <queue>
#include <utility>

#include "easy_comm.h"
#include "driver/ascend_hal.h"

#define private public
#define protected public
#include "bind_cpu_utils.h"
#include "bqs_status.h"
#include "queue_manager.h"
#include "queue_schedule.h"
#include "router_server.h"
#include "bind_relation.h"
#undef private
#undef protected

constexpr uint32_t HEAD_BUF_RSV_SIZE = 256 - sizeof(bqs::IdentifyInfo);
struct HeadBuf {
    char rsv[HEAD_BUF_RSV_SIZE];
    bqs::IdentifyInfo info;
};


constexpr const char *RELATION_QUEUE_NAME = "QSRelationEvent";
constexpr const char *F2NF_QUEUE_NAME = "QSF2NFEvent";
constexpr const char *HCCL_RECV_QUEUE_NAME = "QSHcclRecvEvent";
constexpr const char_t *ASYNC_MEM_BUFF_DEQ_QUEUE_NAME = "QSAsyncMemDeBuffEvent";
constexpr const char_t *ASYNC_MEM_BUFF_ENQ_QUEUE_NAME = "QSAsyncMemEnBuffEvent";
constexpr const char *COMM_CHANNEL_QUEUE_NAME_PREFIX = "CommChannelQueue_";
constexpr int32_t g_tagMbuf_int = 256U;


void ClearStock();

std::vector<uint32_t> &GetSubscribedData();

/**
* Exception function when pipe is broken.
* @return NA
*/
void PipBrokenException(int fd, void* data);

typedef void (*MsgProcCallback)(int, EzcomRequest*);

typedef void (*EzcomCallBack)(int, char*, int);

void DestroyResponseFake(struct EzcomResponse *resp);

int EzcomRegisterServiceHandlerFake(int fd, void(*handler)(int, struct EzcomRequest *));

int EzcomCfgInitServerFake(EzcomPipeServerAttr *attr);

int EzcomCreateServerFake(const struct EzcomServerAttr *attr);

int EzcomRPCSyncFake(int fd, struct EzcomRequest *req, struct EzcomResponse *resp);

int EzcomSendResponseFake(int fd, struct EzcomResponse *resp);

bool CheckDataSubcribeEmpty();

drvError_t halEschedWaitEventFake(unsigned int devId, unsigned int grpId,
                        unsigned int threadId, int timeout, struct event_info *event);

void F2NFThreadTaskFake(bqs::QueueSchedule *queue, uint32_t threadIndex, uint32_t bindCpuIndex, uint32_t groupId);

drvError_t halQueueCreateFake(unsigned int devid, const QueueAttr *queAttr, unsigned int *qid);

drvError_t halQueueCreateWithTransId(unsigned int devid, const QueueAttr *queAttr, unsigned int *qid);

drvError_t halQueueSubscribeFake(unsigned int devid, unsigned int qid, unsigned int groupId, int type);

drvError_t halQueueUnsubscribeFake(unsigned int devid, unsigned int qid);

drvError_t halQueueSubF2NFEventFake(unsigned int devid, unsigned int qid, unsigned int groupid);

drvError_t halQueueUnsubF2NFEventFake(unsigned int devid, unsigned int qid);

drvError_t halQueueSubEventFake(struct QueueSubPara *subPara);

drvError_t halQueueUnsubEventFake(struct QueueUnsubPara *unsubPara);

int DestroyBuffQueueFake(unsigned int devId, unsigned int qid);

int MbufAllocFake(unsigned int size, Mbuf **mbuf);

int MbufCopyFake(Mbuf *mbuf, Mbuf **newMbuf);

int MbufCopyRefFake(Mbuf *mbuf, Mbuf **newMbuf);

int GetQueueStatusFake(unsigned int devid, unsigned int qid, QUEUE_QUERY_ITEM queryItem, unsigned int len,  void *data);

int EnBuffQueueWithTransId(unsigned int devId, unsigned int qid, int32_t val, uint32_t transId);

int EnBuffQueueFake(unsigned int devId, unsigned int qid, void *mbuf);

drvError_t halQueueDeQueueFake(unsigned int devId, unsigned int qid, void **mbuf);

int32_t halMbufGetBuffAddrFake(Mbuf *mbuf, void **buf);

int halMbufGetPrivInfoFake(Mbuf *mbuf,  void **priv, unsigned int *size);

bqs::BqsStatus EnqueueRelationEventFake();

void MockBindSuccess();

void QueuScheduleStub();

bool VerifyQueueSize(uint32_t qid, int32_t size);
#endif //QUEUE_SCHEDULE_STUB_H
