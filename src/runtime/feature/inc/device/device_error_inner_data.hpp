/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_DEVICE_ERROR_INNER_DATA_HPP
#define CCE_RUNTIME_DEVICE_ERROR_INNER_DATA_HPP

#include "stars_base.hpp"
#include "device_error_info.hpp"
#include "stars_david.hpp"

namespace {
    constexpr uint32_t MAX_BIT_LEN = 64U;
    constexpr uint32_t RINGBUFFER_MAGIC = 0xA55A2020U;
    constexpr uint32_t RINGBUFFER_ONE_ELEMENT_LENGTH = 4096U;
    constexpr uint32_t RINGBUFFER_EXT_ONE_ELEMENT_LENGTH = 12288U; // 4K + 8K
    constexpr uint32_t RINGBUFFER_LEN = 10U;
    // total 2M, used:element(42k) * 30, stream snap shot:17k, TSCH_CAPABILITY_LEN:10k
    constexpr uint32_t RINGBUFFER_LEN_DAVID = 30U;
    constexpr uint32_t DEVICE_ERR_MSG_MAGIC = 0xA55A2021U;
    constexpr uint32_t MAX_CORE_BLOCK_NUM  = 50U;
    constexpr uint32_t MAX_CORE_NUM  = 75U;
    constexpr uint32_t RINGBUFFER_ERROR_MSG_MAX_LEN  = 400U;
    constexpr uint32_t RINGBUFFER_ERRCODE0_OFFSET = 0U;
    constexpr uint32_t RINGBUFFER_ERRCODE2_OFFSET = 64U;
    constexpr uint32_t RINGBUFFER_ERRCODE4_OFFSET = 128U;
    constexpr uint32_t MAX_STREAM_NUM_CLOUD = 2048U;
    constexpr uint32_t RINGBUFFER_HCCL_FFTSPLUS_MAX_CONTEXT_NUM = 8U;
	constexpr uint32_t MAX_CORE_BLOCK_NUM_ON_DAVID  = 72U;
    constexpr uint32_t RINGBUFFER_EXT_ONE_ELEMENT_LENGTH_ON_DAVID = 43008U; // 42K For David
    constexpr uint32_t MAX_AIC_ID = 64U;
    constexpr uint32_t MAX_AIV_ID = 64U;
    constexpr uint32_t MAX_DEV_ID = 16U;
    constexpr uint32_t MAX_TASK_NUM_ONE_CORE = 2U;
}

namespace cce {
namespace runtime {
/*********************************** ringbuffer for STARS ***********************************/
struct DavidSdmaScheErrorInfo {
    uint32_t irqStatus;                 // sdma ecc err, bus error
    uint32_t cqeStatus;                 // sdma cqe status
    uint8_t sdmaChannelId;
    uint8_t sdmaChFsmState;            // sdma channel fsm status
    uint8_t sdmaChFree;                 // sdma channle status busy status, 1:not busy 0:busy
    uint8_t rsv;
};

struct StarsSdmaScheErrorInfo {
    uint8_t sdmaChannelId;
    uint8_t sdmaBlkFsmState;            // sdma channel fsm status
    uint8_t dfxSdmaBlkFsmOstCnt;        // sdma channle stars config status, 1:stars config 0:not stars config
    uint8_t sdmaChFree;                 // sdma channle status busy status, 1:not busy 0:busy
    uint32_t irqStatus;                 // sdma ecc err, bus error
    uint32_t cqeStatus;                 // sdma cqe status
};

struct FftsPlusSdmaErrorInfo {
    uint8_t sdmaChannelId;
    uint8_t sdmaState;
    uint8_t sdmaTslotid;
    uint8_t reserve;
    uint16_t sdmaCxtid;
    uint16_t sdmaThreadid;
    uint32_t irqStatus;                 // sdma ecc err, bus error
    uint32_t cqeStatus;                 // sdma cqe status
};

struct StarsErrorCommonInfo {
    uint16_t type;
    uint16_t coreNum; // exception core num
    uint16_t exceptionSlotId;
    uint8_t flag; // MTE ERROR FLAG
    uint8_t slotNum; // exception slot num
    uint32_t chipId;
    uint32_t dieId;
    uint16_t streamId;
    uint16_t taskId;
};

// for fast ringbuffer
struct StarsOpExceptionInfo {
    uint32_t sqeType;
    uint32_t streamId;
    uint32_t sqId;
    uint32_t sqHead;
    uint32_t taskId;
    uint32_t chipId;
    uint32_t dieId;
    uint32_t errorCode;
};

struct StarsSdmaErrorInfo {
    StarsErrorCommonInfo comm;
    union {
        StarsSdmaScheErrorInfo starsInfo[MAX_RECORD_CORE_NUM];
        FftsPlusSdmaErrorInfo fftsPlusInfo[MAX_RECORD_CORE_NUM];
        DavidSdmaScheErrorInfo starsInfoForDavid[MAX_RECORD_CORE_NUM];
    } sdma;
};

struct StarsDsaChanErrorInfo {
    uint8_t chanId;
    uint8_t chanErr;
    uint16_t ctxId;
    uint16_t threadId;
    uint16_t rsv;
};

struct StarsDsaErrorInfo {
    uint16_t type;
    uint16_t coreNum;
    uint16_t exceptionSlotId;
    uint16_t resvere;
    uint32_t chipId;
    uint32_t dieId;
    rtStarsCommonSqe_t sqe;
    StarsDsaChanErrorInfo info[MAX_RECORD_CORE_NUM];
};

struct StarsAicpuRspErrorInfo {
    uint64_t errcode;
    uint32_t streamId;
    uint32_t taskId;
};

struct FftsPlusAicpuErrorInfo {
    uint8_t aicpuId;
    uint8_t aicpuState;
    uint8_t aicpuTslotid;
    uint8_t reserve;
    uint16_t aicpuCxtid;
    uint16_t aicpuThreadid;
};

struct StarsAicpuErrorInfo {
    StarsErrorCommonInfo comm;
    union {
        StarsAicpuRspErrorInfo rspErrorInfo;
        FftsPlusAicpuErrorInfo info[MAX_RECORD_CORE_NUM];
    } aicpu;
};

struct StarsDvppErrorInfo {
    uint16_t sqeType;
    uint16_t exceptionType;
    uint16_t streamId;
    uint16_t taskId;
    uint32_t chipId;
    uint32_t dieId;
};

struct starsOstTaskOneCoreInfo {
    uint16_t streamId;
    uint16_t taskId;
    uint64_t pcStart;
};

struct DavidOneCoreErrorInfo {
    uint64_t coreId;
    uint64_t pcStart;
    uint64_t currentPC;
    uint64_t scErrInfo;
    uint64_t suErrInfo[4];
    uint64_t mteErrInfo;
    uint64_t vecErrInfo;
    uint64_t cubeErrInfo;
    uint64_t l1ErrInfo;
    uint64_t aicErrorMask;
    uint64_t paraBase;
    // aicore status registers
    uint32_t runStall;
    uint32_t aiCoreInt;
    uint32_t eccEn;
    uint32_t axiClampCtrl;
    // aicore error registers, some register has been read in ts_one_core_error_info
    uint64_t scError;
    uint64_t suError;
    uint64_t mteError;
    uint64_t vecError;
    uint64_t cubeError;
    uint64_t l1Error;
    // debug mode and dfx mode
    uint64_t clkGateMask;
    uint64_t dbgAddr;
    uint64_t dbgData0;
    uint64_t dbgData1;
    uint64_t dbgData2;
    uint64_t dbgData3;
    uint64_t dfxData;
    uint32_t subErrType;
    uint32_t isConcurrentExe; //aic是否同时执行两个task的标记位
    starsOstTaskOneCoreInfo ostTaskOneCore[MAX_TASK_NUM_ONE_CORE];
};

struct DavidCoreErrorInfo {
    StarsErrorCommonInfo comm;
    DavidOneCoreErrorInfo info[MAX_CORE_BLOCK_NUM_ON_DAVID];
};

struct StarsOneCoreErrorInfo {
    uint64_t coreId;
    uint64_t aicError[3];
    uint64_t pcStart;
    uint64_t currentPC;
    uint64_t vecErrInfo;
    uint64_t mteErrInfo;
    uint64_t ifuErrInfo;
    uint64_t ccuErrInfo;
    uint64_t cubeErrInfo;
    uint64_t biuErrInfo;
    uint32_t fixPError0;
    uint32_t fixPError1;
    uint64_t aicErrorMask;
    uint64_t paraBase;
    uint32_t fsmId;
    uint32_t fsmTslotId;
    uint32_t fsmThreadId;
    uint32_t fsmCxtId;
    uint32_t fsmBlkId;
    uint32_t fsmSublkId;
    uint32_t subErrType;
};

struct StarsCoreErrorInfo {
    StarsErrorCommonInfo comm;
    StarsOneCoreErrorInfo info[MAX_CORE_BLOCK_NUM];
};

struct StarsOneTimeoutCoreDfxInfo {
    uint16_t coreId;
    uint16_t slotId;
    uint16_t subError;
    uint16_t coreType;
    uint64_t currentPc;
};

struct StarsOneTimeoutSlotDfxInfo {
    uint16_t slotId;
    uint16_t streamId;
    uint16_t taskId;
    uint16_t fftsType;
    uint32_t threadId;
    uint32_t cxtId;
    uint64_t pcStart;
    uint64_t aicOwnBitmap;
    uint64_t aivOwnBitmap0;
    uint64_t aivOwnBitmap1;
} ;

struct StarsCoreTimeoutDfxInfo {
    StarsErrorCommonInfo comm;
    StarsOneTimeoutSlotDfxInfo slotInfo[8];
    StarsOneTimeoutCoreDfxInfo coreInfo[MAX_CORE_NUM];
};

struct StarsSqeErrorInfo {
    uint16_t streamId;
    uint16_t sqId;
    uint16_t sqHead;
    uint16_t taskId;
    uint32_t chipId;
    uint32_t dieId;
    rtStarsCommonSqe_t sqe;
};

struct notifyErrorInfo {
    uint32_t notifyId;
    uint32_t timeout;
};

struct eventErrorInfo {
    uint32_t eventId;
    uint32_t timeout;
};

struct fusionKernelErrorInfo {
    uint32_t subType;
    uint32_t timeout;
};

struct ccuErrorInfo {
    uint16_t missionId;
    uint16_t dieId;
    uint16_t ccuSize;
    uint16_t timeout;
};

struct davidNotifyErrorInfo {
    uint32_t notifyId : 17;
    uint32_t cntFlag : 1;
    uint32_t clrFlag : 1;
    uint32_t waitMode : 2;
    uint32_t bitmap : 1;
    uint32_t subType : 10;
    uint32_t cntValue;
    uint32_t timeout;
};

struct StarsTimeoutErrorInfo {
    uint8_t  waitType;
    uint8_t  reserve;
    uint16_t streamId;
    uint16_t sqId;
    uint16_t taskId;
    uint32_t chipId;
    uint32_t dieId;
    union {
        notifyErrorInfo notifyInfo;
        eventErrorInfo eventInfo;
        fusionKernelErrorInfo fusionInfo;
        davidNotifyErrorInfo errorInfo;
        ccuErrorInfo ccuInfo;
    } wait;
};

struct FftsplusTimeoutCommonInfo {
    uint16_t streamId;
    uint16_t sqId;
    uint16_t taskId;
    uint16_t timeout;
    uint32_t chipId;
    uint32_t dieId;
};

struct NotifyContextInfo {
    uint16_t contextId;
    uint16_t notifyId;
};

struct StarsHcclFftsplusTimeoutInfo {
    uint32_t errConetxtNum;
    FftsplusTimeoutCommonInfo common;
    union {
        NotifyContextInfo notifyInfo[RINGBUFFER_HCCL_FFTSPLUS_MAX_CONTEXT_NUM];
    } contextInfo;
};

struct StarsCcuErrorInfo {
    StarsErrorCommonInfo comm;
    rtDavidSqe_t davidSqe[SQE_NUM_PER_DAVID_TASK_MAX - 1U];
    uint8_t panicLog[FUSION_SUB_TASK_MAX_CCU_NUM][MAX_CCU_EXCEPTION_INFO_SIZE];
};

struct StarsFusionKernelErrorInfo {
    StarsErrorCommonInfo comm;
    uint16_t sqeLength;
    uint16_t subType;
    uint32_t cqeStatus;           /* 0xFFFFFFFF means invalid value */
    uint32_t aicError : 1;
    uint32_t aivError : 1;
    uint32_t aicpuError : 1;
    uint32_t ccuError : 1;
    uint32_t resv : 28;
    rtDavidSqe_t davidSqe[SQE_NUM_PER_DAVID_TASK_MAX];
    union {
        StarsAicpuErrorInfo aicpuInfo;
        StarsCcuErrorInfo ccuInfo;
    } u;
    DavidCoreErrorInfo aicInfo;
    DavidCoreErrorInfo aivInfo;
};

// it is format data in one element from ringbuffer.
struct StarsDeviceErrorInfo {
    union {
        StarsCoreErrorInfo           coreErrorInfo;
        DavidCoreErrorInfo           davidCoreErrorInfo;
        StarsSdmaErrorInfo           sdmaErrorInfo;
        StarsAicpuErrorInfo          aicpuErrorInfo;
        StarsDvppErrorInfo           dvppErrorInfo;
        StarsSqeErrorInfo            sqeErrorInfo;
        StarsTimeoutErrorInfo        timeoutErrorInfo;
        StarsHcclFftsplusTimeoutInfo hcclFftsplusTimeoutInfo;
        StarsDsaErrorInfo            dsaErrorInfo;
        StarsFusionKernelErrorInfo   fusionKernelErrorInfo;
        StarsCcuErrorInfo            ccuErrorInfo;
        StarsCoreTimeoutDfxInfo      coreTimeoutDfxInfo;
    }u;
};
/*********************************** ringbuffer for STARS ***********************************/

// it is control info in device ringbuffer.
struct DevRingBufferCtlInfo {
    uint32_t magic;  // used to judge whether the buffer is valid
    uint32_t head;   // read pointer
    uint32_t tail;   // write pointer
    uint32_t ringBufferLen;
    uint64_t pid;    // host pid
    uint32_t elementSize; // one ringbuffer element size
    uint32_t reserved; // 8Byte alion
};

struct RtsTimeoutStreamSnapshotInfo {
    uint16_t stream_id;
    uint16_t task_id;
    uint16_t sq_id : 12;
    uint16_t sq_fsm : 4;
    uint16_t acsq_id : 8;
    uint16_t acsq_fsm : 6;
    uint16_t is_swap_in : 1;
    uint16_t rsv : 1;
};

struct RtsTimeoutStreamSnapshot {
    uint16_t stream_num;
    uint16_t rsv;
    RtsTimeoutStreamSnapshotInfo detailInfo[MAX_STREAM_NUM_CLOUD];
};

struct AicErrorInfo final {
    uint64_t last_error_pc[MAX_AIC_ID + MAX_AIV_ID];
};

constexpr uint32_t DEVICE_ERROR_RINGBUFFER_SIZE =
    ((RINGBUFFER_ONE_ELEMENT_LENGTH * RINGBUFFER_LEN) + sizeof(DevRingBufferCtlInfo) + 100U);
constexpr uint32_t DEVICE_ERROR_EXT_RINGBUFFER_SIZE =
    ((RINGBUFFER_EXT_ONE_ELEMENT_LENGTH * RINGBUFFER_LEN) + sizeof(DevRingBufferCtlInfo) + 100U);
}
}

#endif