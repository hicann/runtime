/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_STARS_COND_ISA_PARA_HPP__
#define __CCE_RUNTIME_STARS_COND_ISA_PARA_HPP__

#include "base.hpp"

namespace cce {
namespace runtime {

struct RtDqsMbufFreeFcPara {
    uint64_t ctrlSpaceAddr; // ctrlSpace的地址
    uint64_t mbufFreeAddr; // 存放mbuf pool寄存器的地址
    uint64_t mbufHandleAddr; // 存放mbufHandle的
    uint16_t mbufPoolIndexMax; // pool的下标 和 mbufHandle的下标一致
};

struct RtStarsDqsFcPara {
    uint64_t dfxAddr;
    uint64_t gqmAddr;
    uint64_t ctrlSpaceAddr; // ctrlSpace的地址
    uint64_t inputMbufHandleAddr;
    uint64_t ouputMbufHandleAddr;
    uint16_t mbufPoolIndexMax;
    uint64_t rtSqEnableAddr;
    uint64_t streamExecTimesAddr;
    uint64_t enqueOpAddr;
    uint64_t prodqOwAddr;
    uint32_t sqId;
    RtDqsMbufFreeFcPara mbufFreePara;
};

struct RtStarsDqsBatchDeqFcPara {
    uint64_t dfxAddr;
    uint64_t gqmAddr;
    uint64_t inputMbufHandleAddr;
    uint64_t mbufFreeAddr; // 存放mbuf pool寄存器的地址
    uint64_t cntNotifyReadAddr;
    uint64_t cntNotifyClearAddr;
    uint32_t sqId; 
    uint8_t cntOffset;
	uint8_t sizeofHandleCache;
	uint16_t mbufPoolIndexMax;
};

struct RtStarsDqsPrepareFcPara {
    uint64_t dfxMbufAllocPoolIdx;
    uint64_t dfxMbufAllocResult;
    uint64_t ctrlSpacePtr;
    uint16_t outputQueueNum;
    // addrs in ctrl space -- input
    uint64_t csPtrInputMbufHandleAddr;
    uint64_t csPtrInputHeadPoolBaseAddr; // 含offset
    uint64_t csPtrInputHeadPoolBlockSize; 
    // addrs in ctrl space -- output
    uint64_t csPtrOutputMbufAllocAddr;
    uint64_t csPtrOutputMbufHandleAddr;
    uint64_t csPtrOutputHeadPoolBaseAddr; // 含offset
    uint64_t csPtrOutputHeadPoolBlockSize;
};

struct RtStarsDqsZeroCopyPara {
    uint64_t mbufHandleAddr;
    uint64_t mbufBaseAddr;
    uint64_t blockSizeAddr;
    uint64_t offsetAddr;
    uint64_t destAddr;
    uint64_t count;
    bool     isCpyAddrLow32First;  // 零拷贝时，64bit的地址拆分为两个32bit地址，分为高32和低32，true代表拷贝时低32位在前，高32位在后
};

struct RtStarsDqsConditionCopyPara {
    uint64_t conditionAddr;
    uint64_t dstAddr;
    uint64_t srcAddr;
    uint64_t count;
};

struct RtStarsDqsInterChipPreProcPara {
    uint64_t dstMbufHandleAddr;
    uint64_t dstMbuffAllocAddr;

    uint64_t dstMbufHeadBlockSizeAddr;
    uint64_t dstMbufDataBlockSizeAddr;
    uint64_t dstMbufHeadBaseAddr;
    uint64_t dstMbufDataBaseAddr;

    uint64_t mbufDataSdmaSqeAddr; // mbuf data sdma
    uint64_t mbufHeadSdmaSqeAddr; // mbuf head sdma
};

struct RtStarsDqsInterChipPostProcPara {
    uint64_t srcMbufHandleAddr;
    uint64_t dstMbufHandleAddr;
    
    uint64_t dstQueueAddr;
    uint64_t srcMbufFreeAddr;
    uint64_t dstMbufFreeAddr;
    uint64_t dstQmngrOwAddr;
};

struct RtStarsDqsAdspcFcPara {
    uint8_t  cqeSize;
    uint8_t  cqDepth;
    uint8_t  cqeHeadTailMask;
    uint32_t mbufHandle;
    uint64_t mbufFreeRegAddr;
    uint64_t qmngrEnqRegAddr;
    uint64_t qmngrOwRegAddr;
    uint64_t cqeBaseAddr;
    uint64_t cqeCopyAddr;
    uint64_t cqHeadRegAddr;
    uint64_t cqTailRegAddr;
    uint64_t dfxAddr;
};

struct RtStarsDqsFrameAlignFcPara {
    uint64_t frameAlignResAddr;
    uint64_t sqId;
};
}
}
#endif