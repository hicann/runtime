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
    constexpr uint32_t DEVICE_ERR_MSG_MAGIC = 0xA55A2021U;
    constexpr uint32_t MAX_CORE_BLOCK_NUM  = 50U;
    constexpr uint32_t MAX_CORE_NUM  = 75U;
    constexpr uint32_t RINGBUFFER_ERROR_MSG_MAX_LEN  = 400U;
    constexpr uint32_t RINGBUFFER_ERRCODE0_OFFSET = 0U;
    constexpr uint32_t RINGBUFFER_ERRCODE2_OFFSET = 64U;
    constexpr uint32_t RINGBUFFER_ERRCODE4_OFFSET = 128U;
    constexpr uint32_t RINGBUFFER_HCCL_FFTSPLUS_MAX_CONTEXT_NUM = 8U;
	constexpr uint32_t MAX_CORE_BLOCK_NUM_ON_DAVID  = 72U;
    constexpr uint32_t MAX_TASK_NUM_ONE_CORE = 2U;
    constexpr uint32_t RT_STARS_V2_AICORE_NUM = 36U;
    constexpr uint32_t RT_STARS_V2_AIVECTOR_NUM = 72U;
    constexpr uint32_t STARS_CORE_ERROR_EXT_RSV_NUM = 28U;
    constexpr uint32_t STARS_V2_CORE_ERROR_EXT_RSV_NUM = 64U;
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

// 仅用作解析RingBuffer, 不用做逻辑处理。
// 后续不得在末尾或中间新增字段；新增寄存器必须放到对应Ext结构中。
struct DavidOneCoreErrorInfoRingBuffer {
    uint64_t coreId;
    uint64_t pcStart;
    uint64_t currentPC;
    uint64_t scErrInfo;
    uint64_t suErrInfo[4];
    uint64_t mteErrInfo[3];
    uint64_t vecErrInfo[3];
    uint64_t cubeErrInfo;
    uint64_t l1ErrInfo;
    uint64_t aicErrorMask;
    uint64_t paraBase;
    uint32_t runStall;
    uint32_t aiCoreInt;
    uint32_t eccEn;
    uint32_t axiClampCtrl;
    uint64_t scError;
    uint64_t suError;
    uint64_t mteError[2];
    uint64_t vecError;
    uint64_t cubeError;
    uint64_t l1Error;
    uint64_t clkGateMask;
    uint64_t dbgAddr;
    uint64_t dbgData0;
    uint64_t dbgData1;
    uint64_t dbgData2;
    uint64_t dbgData3;
    uint64_t dfxData;
    uint32_t subErrType;
    uint32_t isConcurrentExe;
    starsOstTaskOneCoreInfo ostTaskOneCore[MAX_TASK_NUM_ONE_CORE];
};

struct DavidCoreErrorInfoRingBuffer {
    StarsErrorCommonInfo comm;
    DavidOneCoreErrorInfoRingBuffer info[MAX_CORE_BLOCK_NUM_ON_DAVID];
};

// 仅用作解析RingBuffer中aic/aiv扩展, 不用做逻辑处理。
// validSize表示从aicCond开始的连续有效payload字节数；后续新增Ext寄存器只能追加在aicCond之后、rsv之前。
// 并确保DavidOneCoreErrorInfo从aicCond开始的payload布局一致。
struct DavidOneCoreErrorInfoExt {
    uint32_t coreId;
    uint32_t validSize;
    uint64_t aicCond;
    uint64_t rsv[STARS_V2_CORE_ERROR_EXT_RSV_NUM];
};

struct DavidCoreErrorInfoExt {
    StarsErrorCommonInfo comm;
    DavidOneCoreErrorInfoExt info[MAX_CORE_BLOCK_NUM_ON_DAVID];
};

// 汇聚 DavidOneCoreErrorInfoRingBuffer和DavidOneCoreErrorInfoExt 寄存器信息，用于后续逻辑处理。
// base字段必须与DavidOneCoreErrorInfoRingBuffer保持前缀布局一致；Ext字段只能从aicCond开始追加。
struct DavidOneCoreErrorInfo {
    uint64_t coreId;
    uint64_t pcStart;
    uint64_t currentPC;
    uint64_t scErrInfo;
    uint64_t suErrInfo[4];
    uint64_t mteErrInfo[3];
    uint64_t vecErrInfo[3];
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
    uint64_t mteError[2];
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
    uint32_t isConcurrentExe; // aic是否同时执行两个task的标记位
    starsOstTaskOneCoreInfo ostTaskOneCore[MAX_TASK_NUM_ONE_CORE];
    uint64_t aicCond; // 汇聚aicCond
    // 从aicCond开始的payload布局必须与DavidOneCoreErrorInfoExt从aicCond开始的payload布局一致。
    // 后续新增Ext寄存器只能在尾部追加，并通过validSize控制实际拷贝长度。
    uint64_t rsvExt[STARS_V2_CORE_ERROR_EXT_RSV_NUM];
};

struct DavidCoreErrorInfo {
    StarsErrorCommonInfo comm;
    DavidOneCoreErrorInfo info[MAX_CORE_BLOCK_NUM_ON_DAVID];
};

// 仅用作ringbuffer解析，不用于逻辑处理。
// 新增寄存器必须放到对应Ext结构中。
struct StarsOneCoreErrorInfoRingBuffer {
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

struct StarsCoreErrorInfoRingBuffer {
    StarsErrorCommonInfo comm;
    StarsOneCoreErrorInfoRingBuffer info[MAX_CORE_BLOCK_NUM];
};

// 仅用作解析RingBuffer中aic/aiv扩展, 不用做逻辑处理。
// validSize表示从aicCond开始的连续有效payload字节数；后续新增Ext寄存器只能追加在aicCond之后、rsv之前。
// 修改该结构时必须同步TS侧协议，并确保StarsOneCoreErrorInfo从aicCond开始的payload布局一致。
struct StarsOneCoreErrorInfoExt {
    uint32_t coreId;
    uint32_t validSize;
    uint64_t aicCond;
    uint64_t rsv[STARS_CORE_ERROR_EXT_RSV_NUM];
};

struct StarsCoreErrorInfoExt {
    StarsErrorCommonInfo comm;
    StarsOneCoreErrorInfoExt info[MAX_CORE_BLOCK_NUM];
};

// 汇聚 StarsOneCoreErrorInfoRingBuffer和StarsOneCoreErrorInfoExt 寄存器信息，用于后续逻辑处理。
// base字段必须与StarsOneCoreErrorInfoRingBuffer保持前缀布局一致；Ext字段只能从aicCond开始追加。
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
    uint64_t aicCond;
    // 从aicCond开始的payload布局必须与StarsOneCoreErrorInfoExt从aicCond开始的payload布局一致。
    // 后续新增Ext寄存器只能在尾部追加，并通过validSize控制实际拷贝长度。
    uint64_t rsvExt[STARS_CORE_ERROR_EXT_RSV_NUM];
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

struct StarsV2OneCoreTimeoutDfxInfo {
    uint64_t currentPc;
    uint16_t coreId;
    uint16_t subError;
    uint16_t coreType;
    uint16_t streamId;
    uint32_t taskSn;
    uint16_t sqHead;
    uint16_t rsv;
};

struct StarsV2CoreTimeoutDfxInfo {
    StarsErrorCommonInfo comm;
    StarsV2OneCoreTimeoutDfxInfo coreInfo[RT_STARS_V2_AICORE_NUM + RT_STARS_V2_AIVECTOR_NUM];
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

struct StarsCcuDfxInfo{
 	uint8_t dieId;
 	uint8_t missionId;
 	uint8_t status;
 	uint8_t subStatus;
 	uint8_t panicLog[MAX_CCU_EXCEPTION_INFO_SIZE];
};

struct StarsCcuErrorInfo {
    StarsErrorCommonInfo comm;
    rtDavidSqe_t davidSqe[SQE_NUM_PER_DAVID_TASK_MAX - 1U];
    StarsCcuDfxInfo dfxInfo[FUSION_SUB_TASK_MAX_CCU_NUM];
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

// 仅用作RingBuffer解析，不用于逻辑处理
struct StarsFusionKernelErrorInfoRingBuffer {
    StarsErrorCommonInfo comm;
    uint16_t sqeLength;
    uint16_t subType;
    uint32_t cqeStatus;
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
    DavidCoreErrorInfoRingBuffer aicInfo;
    DavidCoreErrorInfoRingBuffer aivInfo;
};

// it is format data in one element from ringbuffer, constrained by 48128.
// 仅用于解析ringbuffer base payload；Ext payload由Collect*ExtInfos单独解析，不作为该union分支。
// 修改Ext结构时必须保证RingBufferElementInfo + Ext payload不超过对应elementSize。
struct StarsDeviceErrorInfoRingBuffer {
    union {
        StarsCoreErrorInfoRingBuffer coreErrorInfo;
        DavidCoreErrorInfoRingBuffer davidCoreErrorInfo;
        StarsSdmaErrorInfo           sdmaErrorInfo;
        StarsAicpuErrorInfo          aicpuErrorInfo;
        StarsDvppErrorInfo           dvppErrorInfo;
        StarsSqeErrorInfo            sqeErrorInfo;
        StarsTimeoutErrorInfo        timeoutErrorInfo;
        StarsHcclFftsplusTimeoutInfo hcclFftsplusTimeoutInfo;
        StarsDsaErrorInfo            dsaErrorInfo;
        StarsFusionKernelErrorInfoRingBuffer   fusionKernelErrorInfo;
        StarsCcuErrorInfo            ccuErrorInfo;
        StarsCoreTimeoutDfxInfo      coreTimeoutDfxInfo;
        StarsV2CoreTimeoutDfxInfo    starsV2CoreTimeoutDfxInfo;
    } u;
};

static_assert(
    (sizeof(RingBufferElementInfo) + sizeof(StarsDeviceErrorInfoRingBuffer)) <=
        RINGBUFFER_EXT_ONE_ELEMENT_LENGTH_ON_DAVID,
    "Element info exceeds single element capacity.");

static_assert(
    (sizeof(RingBufferElementInfo) + sizeof(StarsCoreErrorInfoExt)) <= RINGBUFFER_EXT_ONE_ELEMENT_LENGTH,
    "Stars ext payload exceeds single element capacity.");

static_assert(
    (sizeof(RingBufferElementInfo) + sizeof(DavidCoreErrorInfoExt)) <= RINGBUFFER_EXT_ONE_ELEMENT_LENGTH_ON_DAVID,
    "Stars V2 ext payload exceeds single element capacity.");

// processing layer struct, no size constraint, contains merged ext info.
// 用在逻辑处理中，与StarsDeviceErrorInfoRingBuffer搭配
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
        StarsV2CoreTimeoutDfxInfo    starsV2CoreTimeoutDfxInfo;
    }u;
};
}
}

#endif
