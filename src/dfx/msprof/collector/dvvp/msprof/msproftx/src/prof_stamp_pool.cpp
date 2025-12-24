/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_stamp_pool.h"
#include <iostream>
#include "config/config.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "msprof_error_manager.h"
#include "utils.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;

namespace Msprof {
namespace MsprofTx {
using MsprofStampCtrlHandle = struct MsprofStampCtrlHandle;

MsprofStampCtrlHandle* g_stampPoolHandle = nullptr;
MsprofStampInstance* g_stampInstanceAddr[CURRENT_STAMP_SIZE];

ProfStampPool::ProfStampPool()
{
}

ProfStampPool::~ProfStampPool()
{
}

int32_t ProfStampPool::Init(uint32_t size)
{
    if (size > MAX_STAMP_SIZE || size == 0) {
        MSPROF_LOGE("Init Stamp Pool Failed, Invalid input size %u bytes.", size);
        return PROFILING_FAILED;
    }
    if (g_stampPoolHandle != nullptr) {
        return PROFILING_SUCCESS;
    }
    MSPROF_LOGI("Init Stamp Pool, Input Size:%u", size);
    singleTStack_.reserve(size);
    g_stampPoolHandle = new (std::nothrow) MsprofStampCtrlHandle();
    FUNRET_CHECK_RET_VALUE(g_stampPoolHandle == nullptr, return PROFILING_FAILED);
    g_stampPoolHandle->freeCnt = size;
    g_stampPoolHandle->usedCnt = 0;

    g_stampPoolHandle->memPool =
        (struct MsprofStampInstance*) calloc(1, size * sizeof(struct MsprofStampInstance));
    if (g_stampPoolHandle->memPool == nullptr) {
        MSPROF_LOGE("Init Stamp Pool Failed, Memory Not Enough.");
        return PROFILING_FAILED;
    }
    g_stampPoolHandle->instanceSize = size;
    g_stampPoolHandle->freelist = g_stampPoolHandle->memPool;

    MsprofStampInstance* node = nullptr;
    for (uint32_t i = 0; i < size; i++) {
        node = g_stampPoolHandle->memPool + i;
        node->id = static_cast<int32_t>(i);
        g_stampInstanceAddr[i] = node;
        if (i == size - 1) {
            node->next = nullptr;
        } else {
            node->next = g_stampPoolHandle->memPool + i + 1;
        }
        node->txInfo.infoType = 0;
        node->txInfo.value.stampInfo.processId = static_cast<uint32_t>(OsalGetPid());
        node->txInfo.value.stampInfo.dataTag = MSPROF_MSPROFTX_DATA_TAG;
        node->txInfo.value.stampInfo.magicNumber = static_cast<uint16_t>(MSPROF_DATA_HEAD_MAGIC_NUM);
    }
    return PROFILING_SUCCESS;
}

int32_t ProfStampPool::UnInit() const
{
    if (g_stampPoolHandle == nullptr) {
        return PROFILING_SUCCESS;
    }

    if (g_stampPoolHandle->usedCnt != 0) {
        /* stamp is used, can not free */
        return PROFILING_FAILED;
    }

    free(g_stampPoolHandle->memPool);

    delete g_stampPoolHandle;
    g_stampPoolHandle = nullptr;
    return PROFILING_SUCCESS;
}

MsprofStampInstance* ProfStampPool::CreateStamp()
{
    std::lock_guard<std::mutex> lk(memoryListMtx_);

    if (g_stampPoolHandle->usedCnt >= g_stampPoolHandle->instanceSize) {
        MSPROF_LOGE("[CreateStamp]Failed to create stamp because the number of used has reached the online!");
        return nullptr;
    }

    /* take freeNode out from freelist's head */
    struct MsprofStampInstance* freeNode = g_stampPoolHandle->freelist;
    g_stampPoolHandle->freelist = freeNode->next;

    /* insert freeNode to usedlist's head */
    struct MsprofStampInstance* usedNode = g_stampPoolHandle->usedlist;
    freeNode->next = usedNode;
    if (usedNode != nullptr) {
        usedNode->prev = freeNode;
    }
    g_stampPoolHandle->usedlist = freeNode;

    /* update cnt info */
    g_stampPoolHandle->usedCnt++;
    g_stampPoolHandle->freeCnt--;

    return freeNode;
}

void ProfStampPool::DestroyStamp(MsprofStampInstance* stamp)
{
    std::lock_guard<std::mutex> lk(memoryListMtx_);

    if (g_stampPoolHandle->usedCnt == 0 || stamp == nullptr) {
        return;
    }

    /* take stamp node out from usedlist */
    if (g_stampPoolHandle->usedlist == stamp) { // the stamp is first node in usedlist
        g_stampPoolHandle->usedlist = stamp->next;
    } else if (stamp->next == nullptr) { // the stamp is last node in usedlist
        stamp->prev->next = nullptr;
    } else { // the stamp is middle node in usedlist
        stamp->prev->next = stamp->next;
        stamp->next->prev = stamp->prev;
    }
     /* insert stamp not to freelist */
    stamp->next = g_stampPoolHandle->freelist;
    g_stampPoolHandle->freelist = stamp;

    /* update cnt info */
    g_stampPoolHandle->usedCnt--;
    g_stampPoolHandle->freeCnt++;
}

int32_t ProfStampPool::MsprofStampPush(MsprofStampInstance *stamp)
{
    if (stamp == nullptr) {
        return PROFILING_FAILED;
    }
    std::lock_guard<std::mutex> lk(singleTStackMtx_);
    singleTStack_.push_back(stamp);
    return PROFILING_SUCCESS;
}

MsprofStampInstance* ProfStampPool::MsprofStampPop()
{
    std::lock_guard<std::mutex> lk(singleTStackMtx_);
    if (singleTStack_.size() == 0) {
        MSPROF_LOGE("[MsprofStampPop]stamp pop failed , stack size is 0!");
        return nullptr;
    }

    MsprofStampInstance *stamp = singleTStack_.back();
    singleTStack_.pop_back();
    return stamp;
}

MsprofStampInstance* ProfStampPool::GetStampById(uint32_t id) const
{
    if (id >= CURRENT_STAMP_SIZE) {
        return nullptr;
    }
    return g_stampInstanceAddr[id];
}

int32_t ProfStampPool::GetIdByStamp(const MsprofStampInstance* const stamp) const
{
    if (stamp == nullptr) {
        return PROFILING_FAILED;
    }

    return stamp->id;
}
}
}
