/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_DRIVER_TYPES_HPP__
#define __CCE_RUNTIME_DRIVER_TYPES_HPP__

#include <array>
#include <cstdint>
#include <string>
#include "runtime/base.h"
#include "driver/ascend_hal_define.h"

#define ASYNC_CPY_2D_IN_RSV_LEN 8
#define ASYNC_CPY_2D_DESTROY_RSV_LEN 8
#define ASYNC_CPY_BATCH_IN_RSV_LEN 8
#define ASYNC_CPY_BATCH_DESTROY_RSV_LEN 8

namespace cce {
namespace runtime {

struct ipcMemInfo_t {
    std::string name;
    bool locked;
    int32_t ref;
};

struct LogicCqWaitInfo {
    uint32_t devId;
    uint32_t tsId;
    uint32_t cqId;
    bool isFastCq;
    int32_t timeout;
    uint32_t streamId;
    uint32_t taskId;
};

struct AsyncSqeUpdateInfo {
    uint32_t sqId;
    uint32_t sqe_pos;
};

struct AsyncDmaWqeInputInfo {
    void* src;
    uint64_t size;
    uint32_t sqId;
    uint32_t tsId;
    uint32_t cpyType;
    union {
        void* destPtr;
        struct AsyncSqeUpdateInfo info;
    };
};

struct AsyncDmaWqeOutputInfo {
    union {
        struct {
            uint16_t dieId;
            uint16_t functionId;
            uint16_t jettyId;
            uint8_t* wqe;
            int32_t wqeLen;
            uint32_t pi;
            union {
                uint64_t fixedSize;
                uint64_t fixedCnt;
            };
        };
        struct DMA_ADDR dmaAddr;
    };
};

struct AsyncDmaWqeDestroyInfo {
    uint32_t tsId;
    uint32_t sqId;
    union {
        struct {
            uint8_t* wqe;
            int32_t size;
        };
        struct DMA_ADDR* dmaAddr;
    };
};

struct AsyncDmaWqeInputInfo2D {
    drvSqCqType_t type;
    uint32_t tsId;
    uint32_t sqId;
    uint32_t dir;
    void* dst;
    uint64_t dpitch;
    void* src;
    uint64_t destAddr;
    uint64_t spitch;
    uint64_t width;
    uint64_t height;
    uint64_t fixedSize;
    std::array<uint32_t, ASYNC_CPY_2D_IN_RSV_LEN> rsv;
};

struct AsyncDmaWqeDestroyInfo2D {
    drvSqCqType_t type;
    uint32_t tsId;
    uint32_t sqId;
    uint32_t ci;
    std::array<uint32_t, ASYNC_CPY_2D_DESTROY_RSV_LEN> rsv;
};

struct AsyncDmaBatchInfo {
    void** dsts;
    void** srcs;
    uint64_t* sizes;
    uint64_t count;
    uint64_t fixedCnt;
    uint64_t fixedSize;
};

struct AsyncDmaWqeInputInfoBatch {
    drvSqCqType_t type;
    uint32_t tsId;
    uint32_t sqId;
    uint32_t dir;
    void** dsts;
    void** srcs;
    uint64_t* lens;
    uint64_t count;
    uint64_t fixedCnt;
    std::array<uint32_t, ASYNC_CPY_BATCH_IN_RSV_LEN> rsv;
};

struct AsyncDmaWqeDestroyInfoBatch {
    drvSqCqType_t type;
    uint32_t tsId;
    uint32_t sqId;
    uint32_t ci;
    std::array<uint32_t, ASYNC_CPY_BATCH_DESTROY_RSV_LEN> rsv;
};

struct IpcNotifyOpenPara {
    const char_t* name;
    uint32_t flag;
    uint32_t localDevId;
    uint32_t localTsId;
};

struct AsyncDmaJettyHandle {
    uint64_t handle;
    std::array<uint32_t, 8> rsv; // 8 rsv cnt
};

struct AsyncWqeNormalInfo {
    uint8_t* src;
    uint8_t* dst;
    uint64_t len;
};

struct AsyncWqeBatchInfo {
    uint64_t* src;
    uint64_t* dst;
    uint64_t* len;
    uint64_t count;
};

struct AsyncWqeMatrix2dInfo {
    uint64_t* src;
    uint64_t* dst;
    uint64_t dpitch;
    uint64_t spitch;
    uint64_t width;
    uint64_t height;
    uint64_t fixedSize;
};

struct AsyncWqeNopInfo {
    uint64_t nopCnt;
};

struct AsyncWqeInputPara {
    uint32_t wqeType;   /* 见drv_async_dma_type */
    uint8_t* wqeBuffer; /* 入参buffer, 直接传入wqe buffer地址，不做二次拷贝 */
    uint32_t size;      /* 入参buffer大小 size */
    union {
        AsyncWqeNormalInfo normal;
        AsyncWqeBatchInfo batch;
        AsyncWqeMatrix2dInfo matrix2d;
        AsyncWqeNopInfo nop;
    };
    std::array<uint32_t, 20> rsv; // 20 rsv cnt
};

struct AsyncWqeOutputPara {
    uint32_t wqeCnt; /* 转化出返回多少个wqe */
    /*
     * batch: already complete-converted array element;
     * others: 0 for partially-converted, 1 for complete-converted
     */
    uint64_t fixedCnt;
    /*
     * batch: the actual-converted size for the next partially-converted array element;
     * others: fixedSize return the actual-converted size if fixedCnt is 0, otherwhise return 0
     */
    uint64_t fixedSize;
    std::array<uint32_t, 8> rsv; // 8 rsv cnt
};

struct AsyncWqeFillInfo {
    struct AsyncDmaJettyHandle jettyHandle;
    uint32_t offset;
    void* srcWqe;
    uint64_t size;
    uint32_t flag;
    std::array<uint32_t, 16> rsv; // 16 rsv cnt
};

} // namespace runtime
} // namespace cce

#endif // __CCE_RUNTIME_DRIVER_TYPES_HPP__
