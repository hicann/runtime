/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROF_STAMP_POOL_H
#define PROF_STAMP_POOL_H

#include <map>
#include <mutex>
#include <vector>
#include "prof_common.h"
#include "prof_api.h"
#include "prof_report_api.h"

namespace Msprof {
namespace MsprofTx {

// Specification
constexpr int32_t MAX_STAMP_SIZE = 10000;
constexpr uint32_t CURRENT_STAMP_SIZE = 100;

struct MsprofStampInstance {
    MsprofTxInfo txInfo;
    int32_t id;
    struct MsprofStampInstance* next;
    struct MsprofStampInstance* prev;
};

struct MsprofStampCtrlHandle {
    struct MsprofStampInstance* memPool;
    struct MsprofStampInstance* freelist;
    struct MsprofStampInstance* usedlist;
    uint32_t freeCnt;
    uint32_t usedCnt;
    uint32_t instanceSize;
};

class ProfStampPool {
public:
    ProfStampPool();
    virtual ~ProfStampPool();

    // create stamp memory pool
    int32_t Init(uint32_t size);
    // destroy memory pool
    int32_t UnInit() const;

    // get stamp from memory pool
    MsprofStampInstance* CreateStamp();
    // destroy stamp
    void DestroyStamp(MsprofStampInstance* stamp);

    // push/pob
    int32_t MsprofStampPush(MsprofStampInstance* stamp);
    MsprofStampInstance* MsprofStampPop();

    MsprofStampInstance* GetStampById(uint32_t id) const;
    int32_t GetIdByStamp(const MsprofStampInstance* const stamp) const;

private:
    std::vector<MsprofStampInstance *> singleTStack_;
    std::mutex singleTStackMtx_;
    std::mutex memoryListMtx_;
};

}
}

#endif // PROF_STAMP_POOL_H
