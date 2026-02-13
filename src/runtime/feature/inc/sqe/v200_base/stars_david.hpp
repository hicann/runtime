/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_STARS_DAVID_HPP__
#define __CCE_RUNTIME_STARS_DAVID_HPP__

#include "task_info.hpp"
#include "place_holder_sqe.h"
#include "aicpu_sqe.h"
#include "memcpy_sqe.h"
#include "ccu_sqe.h"

using namespace std;

#define RT_DAVID_IPCINT_MSGLEN_MAX 8
#define RT_DAVID_ASYNC_CPY_SIZE    64U

#define RT_PRINT_DIRECT_WQE_SIZE_ONE  128
#define RT_PRINT_DIRECT_WQE_SIZE_TWO  192
#define RT_PRINT_UB_AYSNCDMA_SQE_SIZE 128

#define RT_CCU_SQE128B_ARGS_SIZE 13U
#define RT_CCU_SQE32B_ARGS_SIZE  1U
#define RT_CCU_MISSION_ID_MAX    15U

namespace cce {
namespace runtime {
constexpr uint32_t RT_AICPU_ERROR_CODE_BIT_MOVE = 16U;  /* 32bit swStatus=[16bit:aicpu error code | 16bit:aicpu exe status] */
constexpr uint32_t SHIFT_SIX_SIZE = 6U;
constexpr uint64_t RUNTIME_DAVINCI_MAX_TIMEOUT = 1091000000UL; // 1091s
// hcom_cpu:0, aicpu:1, aic:2, ccu die0:3, ccu die1:4
constexpr uint32_t RT_FUSION_HCOMCPU_BIT_MOVE = 0U;
constexpr uint32_t RT_FUSION_AICPU_BIT_MOVE = 1U;
constexpr uint32_t RT_FUSION_AIC_BIT_MOVE = 2U;

constexpr uint16_t RT_DAVID_AIC_WRR_RD = 1U;
constexpr uint16_t RT_DAVID_AIC_WRR_WR = 1U;
constexpr uint16_t RT_DAVID_AIV_WRR_RD = 2U;
constexpr uint16_t RT_DAVID_AIV_WRR_WR = 2U;

static constexpr uint32_t FUSION_SUBTASK_MOVE[RT_FUSION_CCU] = {
    RT_FUSION_HCOMCPU_BIT_MOVE,
    RT_FUSION_AICPU_BIT_MOVE,
    RT_FUSION_AIC_BIT_MOVE
};

enum rtDavidStarsSqeType {
    RT_DAVID_SQE_TYPE_AIC             = 0, // AIC
    RT_DAVID_SQE_TYPE_AIV             = 1, // AIV
    RT_DAVID_SQE_TYPE_FUSION          = 2, // FUSION
    RT_DAVID_SQE_TYPE_PLACE_HOLDER    = 3, // PLACE_HOLDER
    RT_DAVID_SQE_TYPE_AICPU_H         = 4, // AICPU_H
    RT_DAVID_SQE_TYPE_AICPU_D         = 5, // AICPU_D
    RT_DAVID_SQE_TYPE_NOTIFY_RECORD   = 6, // NOTIFY_RECORD
    RT_DAVID_SQE_TYPE_NOTIFY_WAIT     = 7, // NOTIFY_WAIT
    RT_DAVID_SQE_TYPE_WRITE_VALUE     = 8, // WRITE_VALUE
    RT_DAVID_SQE_TYPE_UBDMA           = 9, // UBDMA
    RT_DAVID_SQE_TYPE_ASYNCDMA        = 10, // ASYNCDMA
    RT_DAVID_SQE_TYPE_SDMA            = 11, // SDMA
    RT_DAVID_SQE_TYPE_VPC             = 12, // VPC
    RT_DAVID_SQE_TYPE_JPEGE           = 13, // JPEGE
    RT_DAVID_SQE_TYPE_JPEGD           = 14, // JPEGD
    RT_DAVID_SQE_TYPE_CMO             = 15, // CMO
    RT_DAVID_SQE_TYPE_CCU             = 16, // CCU
    RT_DAVID_SQE_TYPE_NSC             = 18, // NSC
    RT_DAVID_SQE_TYPE_DSS             = 19, // DSS
    RT_DAVID_SQE_TYPE_COND            = 20, // condition
    RT_DAVID_SQE_TYPE_END             = 21,
    RT_DAVID_SQE_TYPE_INVALID         = 63, // invalid type
};

enum rtDavidNotifySubType {
    NOTIFY_SUB_TYPE_SINGLE_NOTIFY_RECORD            = 0U,
    NOTIFY_SUB_TYPE_SINGLE_NOTIFY_WAIT              = 1U,
    NOTIFY_SUB_TYPE_COUNT_NOTIFY_RECORD             = 2U,
    NOTIFY_SUB_TYPE_COUNT_NOTIFY_WAIT               = 3U,
    NOTIFY_SUB_TYPE_EVENT_USE_SINGLE_NOTIFY_RECORD  = 4U,
    NOTIFY_SUB_TYPE_EVENT_USE_SINGLE_NOTIFY_WAIT    = 5U,
    NOTIFY_SUB_TYPE_EVENT_USE_COUNT_NOTIFY_RECORD   = 6U,
    NOTIFY_SUB_TYPE_EVENT_USE_COUNT_NOTIFY_WAIT     = 7U,
    NOTIFY_SUB_TYPE_EVENT_RESET_USE_SINGLE_NOTIFY   = 8U,
    NOTIFY_SUB_TYPE_EVENT_RESET_USE_COUNT_NOTIFY    = 9U,
    NOTIFY_SUB_TYPE_MAX                             = 10U
};

enum class DavidTaskMapType : std::uint8_t {
    TASK_MAP_TYPE_RECORD_RESET_MAP            = 0U,
    TASK_MAP_TYPE_WAIT_MAP                    = 1U
};

#pragma pack(push)
#pragma pack (1)
struct RtDavidStarsHostfuncCallbackSqe {
    /* word0-1 */
    rtDavidStarsSqeHeader_t header;

    /* word2 */
    uint16_t res1;
    uint16_t kernelType : 7;  //use reserved field
    uint16_t batchMode : 1;  //use reserved field
    uint16_t topicType : 4;  //use reserved field
    uint16_t qos : 3;  //use reserved field
    uint16_t res2 : 1;

    /* word3 */
    uint16_t sqeIndex;  //use reserved field
    uint16_t kernelCredit : 8;
    uint16_t res3 : 8;

    /* words4-11 use reserved field */
    /* word4-5 */
    uint16_t cbCqId;
    uint16_t cbGroupId;
    uint16_t devId;
    uint16_t streamId;

    /* word6-7 */
    uint16_t eventId;
    uint16_t isBlock;
    uint16_t taskId;
    uint16_t res4;

    /* word8-11 */
    uint32_t hostfuncAddrLow;
    uint32_t hostfuncAddrHigh;
    uint32_t fndataLow;
    uint32_t fndataHigh;

    /* word12-13 */
    uint32_t res5;               // noly vf & topic AICPU & callback msg use for hostpid.
    uint32_t res6;

    /* word14 */
    uint32_t subTopicId : 12;
    uint32_t topicId : 6;
    uint32_t groupId : 6;
    uint32_t usrDataLen : 8;

    /* word15 */
    uint32_t destPid;
};

struct RtDavidStarsAicAivKernelSqe {
    /* word0-1 */
    rtDavidStarsSqeHeader_t header;

    /* word2 */
    uint16_t groupDim;
    uint16_t groupBlockdim;

    /* word3 */
    uint8_t featureFlag;     // used for DATADUMP BIUPERF L2CACHE DCACHE LOCK flag
    uint8_t res1;
    uint8_t kernelCredit;
    uint8_t dieFriendly : 1;
    uint8_t mix : 1;
    uint8_t loose : 1;
    uint8_t res2 : 2;
    uint8_t sqeLength : 3;

    /* word4-5 */
    uint32_t stackPhyBaseLow;
    uint32_t stackPhyBaseHigh;

    /* word6 */
    uint16_t aicPmg : 2;
    uint16_t aicNs : 1; // nonuse
    uint16_t aicPartId : 8;
    uint16_t piMix : 1;
    uint16_t aicQos : 4;
    uint16_t aicWrrRd : 3;
    uint16_t aicWrrWr : 3;
    uint16_t aicIcachePrefetchCnt : 5;
    uint16_t aivIcachePrefetchCnt : 5;

    /* word7 */
    uint16_t aivPmg : 2;
    uint16_t aivNs : 1; // nonuse
    uint16_t aivPartId : 8;
    uint16_t res4 : 1;
    uint16_t aivQos : 4;
    uint16_t aivWrrRd : 3;
    uint16_t aivWrrWr : 3;
    uint16_t schem : 2;
    uint16_t ratio : 8;

    /* word8-9 */
    uint32_t aicStartPcLow;
    uint32_t aivStartPcLow;

    /* word10 */
    uint16_t aicStartPcHigh;
    uint16_t aivStartPcHigh;

    /* word11-15 */
    uint32_t aivSimtDcuSmSize;
    uint32_t aicTaskParamPtrLow;
    uint32_t aicTaskParamPtrHigh;
    uint32_t aivTaskParamPtrLow;
    uint32_t aivTaskParamPtrHigh;
};

struct RtDavidStarsFunctionCallSqe {
    rtDavidStarsSqeHeader_t header;

    uint8_t condsSubType;  // use reserved filed
    uint16_t reserved0;
    uint8_t reserved1 : 7;
    uint8_t csc : 1;  // use reserved filed
    uint16_t reserved2;
    uint8_t kernelCredit;
    uint8_t reserved3 : 4;
    uint8_t debugFlag : 1;
    uint8_t sqeLength : 3;  // use reserved filed

    /* use reserved filed */
    RtStarsCondOpLHWI lhwi1;
    RtStarsCondOpLLWI llwi1;
    RtStarsCondOpLHWI lhwi2;
    RtStarsCondOpLLWI llwi2;
    RtStarsCondOpFuncCall funcCall;
    RtStarsCondOpNop nop[5];
};

struct RtDavidStarsNotifySqe {
    /* word0-1 */
    rtDavidStarsSqeHeader_t header;

    /* word2 */
    uint32_t notifyId : 17;
    uint32_t res2 :13;
    uint32_t cntFlag :1;
    uint32_t clrFlag :1;

    /* word3 */
    uint16_t subType; // This field is reserved and used by software.
    uint8_t  kernelCredit;
    uint8_t  res4 : 5;
    uint8_t  sqeLength : 3;

    /* word4 */
    uint32_t cntValue;

    /* word5 */
    uint32_t waitModeBit : 2; // bit 0:equal, bit 1:bigger
    uint32_t recordModeBit : 3; // bit 0:add, bit 1:write, bit 2:clear
    uint32_t bitmap : 1; // only use for conut notify wait, 1 means comapre with count value by bit
    uint32_t res5 : 26;

    /* word6 */
    uint32_t timeout; // This field is reserved and used by software.

    /* word7 */
    uint32_t exeResult; // for Two-phase operator

    /* word8-15 */
    uint32_t res7[8];
};

//ptrMode = 0
struct RtDavidStarsWriteValueSqe {
    /* word0-1 */
    rtDavidStarsSqeHeader_t header;

    /* word2 */
    uint32_t res1;

    /* word3 */
    uint16_t res2;
    uint8_t kernelCredit;
    uint8_t res3;

    /* word4 */
    uint32_t writeAddrLow;

    /* word5 */
    uint32_t writeAddrHigh : 17;
    uint32_t res4 : 3;
    uint32_t awsize : 3;
    uint32_t snoop : 1;
    uint32_t awcache : 4;
    uint32_t awprot : 3;
    uint32_t va : 1;

    /* word6-7 */
    uint32_t res5;
    uint32_t subType;  //use reserved filed

    /* word8-15 */
    uint32_t writeValuePart[8];  // write value field
};

//ptrMode = 1
struct RtDavidStarsWriteValuePtrSqe {
    /* word0-1 */
    rtDavidStarsSqeHeader_t header;

    /* word2 */
    uint32_t res1;

    /* word3 */
    uint32_t res2 : 16;
    uint32_t kernelCredit : 8;
    uint32_t res3 : 8;

    /* word4 */
    uint32_t writeValueNewSqeAddrLow;

    /* word5 */
    uint32_t writeValueNewSqeAddrHigh : 17;
    uint32_t res4 : 14;
    uint32_t va : 1;

    /* word6-15 */
    uint32_t res5[10];
};

// UB DBmode  mode = 1
struct RtDavidStarsUbdmaDBmodeSqe {
    /* word0-1 */
    rtDavidStarsSqeHeader_t header;

    /* word2 */
    uint16_t mode : 1;
    uint16_t doorbellNum : 2;
    uint16_t res0 : 13;
    uint16_t res1;

    /* word3 */
    uint16_t res2;
    uint8_t kernelCredit;
    uint8_t res3 : 5;
    uint8_t sqeLength : 3;

    /* word4 */
    uint32_t jettyId1 : 16;
    uint32_t res4 : 9;
    uint32_t funcId1 : 7;

    /* word5 */
    uint16_t piValue1;
    uint16_t res5 : 15;
    uint16_t dieId1 : 1;

    /* word6 */
    uint32_t jettyId2 : 16;
    uint32_t res6 : 9;
    uint32_t funcId2 : 7;

    /* word7 */
    uint16_t piValue2;
    uint16_t res7 : 15;
    uint16_t dieId2 : 1;

    /* word8-15 */
    uint32_t res8[8];
};

struct RtDavidStarsUbdmaDirectWqemodeSqe {
    /* word0-1 */
    rtDavidStarsSqeHeader_t header;

    /* word2 */
    uint16_t mode : 1;
    uint16_t wqeSize : 1;
    uint16_t res1 : 14;
    uint16_t res2;

    /* word3 */
    uint16_t res3;
    uint8_t kernelCredit;
    uint8_t res4 : 5;
    uint8_t sqeLength : 3;

    /* word4 */
    uint32_t jettyId : 16;
    uint32_t res5 : 9;
    uint32_t funcId : 7;

    /* word5 */
    uint32_t res6 : 31;
    uint32_t dieId : 1;
    /* word6-word15 */
    uint32_t res7[10];
};

struct RtDavidStarsDvppSqe {
    /* word0-1 */
    rtDavidStarsSqeHeader_t header;

    /* word2 */
    uint32_t cmdBufSize;

    /* word3 */
    uint16_t res1;
    uint8_t kernelCredit;
    uint8_t res2 : 1;
    uint8_t taskPos : 7;  //use reserved filed

    /* word4-15 */
    uint32_t usrData[12];
};

struct RtDavidStarsGetFloatStatusSqe {
    rtDavidStarsSqeHeader_t header;

    uint8_t condsSubType;  // use reserved filed
    uint16_t reserved0;
    uint8_t reserved1 : 7;
    uint8_t csc : 1;  // use reserved filed
    uint16_t reserved2;
    uint8_t kernelCredit;
    uint8_t reserved3 : 4;
    uint8_t debugFlag : 1;
    uint8_t sqeLength : 3;  // use reserved filed

    RtStarsCondOpLoadImm ldi;
    RtStarsCondOpLLWI llwi;
    RtStarsCondOpStore sdOverflowCnt;
    RtStarsCondOpStore sdZero[7];
};

struct RtDavidStarsDqsSchedEndSqe {
    rtDavidStarsSqeHeader_t header;
 
    uint8_t condsSubType;  // use reserved filed
    uint16_t reserved0;
    uint8_t reserved1 : 7;
    uint8_t csc : 1;  // use reserved filed
    uint16_t reserved2;
    uint8_t kernelCredit;
    uint8_t reserved3 : 5;
    uint8_t sqeLength : 3;  // use reserved filed
 
    RtStarsCondOpLLWI          llwi;
    RtStarsCondOpLHWI          lhwi;
    RtStarsCondOpStreamGotoR   gotor;
    RtStarsCondOpNop           nop[8];
};

union rtDavidSqe_t {
    rtDavidStarsCommonSqe_t commonSqe;
    RtDavidStarsAicAivKernelSqe aicAivSqe;
    RtDavidStarsAicpuKernelSqe aicpuSqe;
    RtDavidStarsHostfuncCallbackSqe callbackSqe;
    RtDavidPlaceHolderSqe phSqe;
    RtDavidStarsNotifySqe notifySqe;
    RtDavidStarsWriteValueSqe writeValueSqe;
    RtDavidStarsWriteValuePtrSqe writeValuePtrSqe;
    RtDavidStarsMemcpySqe memcpyAsyncSqe;
    RtDavidStarsPcieDmaSqe pcieDmaSqe;
    RtDavidStarsGetFloatStatusSqe getFloatStatusSqe;
    RtDavidStarsFunctionCallSqe fuctionCallSqe;
    RtDavidStarsAicpuControlSqe aicpuControlSqe;
    RtDavidStarsDvppSqe dvppSqe;
    RtDavidStarsMemcpyPtrSqe memcpyAsyncPtrSqe;
    RtDavidStarsUbdmaDBmodeSqe davidUbdmaDbSqe;
    RtDavidStarsUbdmaDirectWqemodeSqe davidUbdmaDirectSqe;
    RtDavidStarsAsyncDmaSqe davidAsyncDmaDirectSqe;
    RtDavidStarsCmoSqe cmoSqe;
    RtDavidStarsCcuSqe ccuSqe;
    RtDavidStarsCcuSqe32B ccuSqe32B[2];
    RtDavidStarsDqsSchedEndSqe dqsSchedEndSqe;
};

#pragma pack(pop)

using PfnTaskToDavidSqe = void (*)(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr);

PfnTaskToDavidSqe *GetDavidSqeFuncAddr();

void ToConstructDavidSqe(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr);
uint32_t GetSendDavidSqeNum(const TaskInfo* const taskInfo);
uint8_t GetHeadUpdateFlag(uint64_t allocTimes);
bool IsNeedRetryTask(const uint16_t sqeType);

template<typename T>
void PrintDavidSqe(T const sqe, const char *desc, size_t size = 64)
{
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 0) {
        return;
    }
    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(sqe);
    for (size_t i = 0UL; i < (size / sizeof(uint32_t)); i += 8U) {
        RT_LOG(RT_LOG_DEBUG, "%s: %08x %08x %08x %08x %08x %08x %08x %08x", desc,
            cmd[i], cmd[i + 1U], cmd[i + 2U], cmd[i + 3U], cmd[i + 4U], cmd[i + 5U], cmd[i + 6U],
            cmd[i + 7U]);
    }
}

void RegTaskToDavidSqefunc(void);
const char_t* GetNotifySubType(const uint16_t subType);
void InitWriteValueSqe(RtDavidStarsWriteValueSqe * const writeValueSqe,
    const rtWriteValueInfo_t * const writeValueInfo);
void AixKernelTaskInitForFusion(TaskInfo * const taskInfo, const rtAicAivFusionInfo_t * const aicAivInfo,
    const LaunchTaskCfgInfo_t * const launchTaskCfg);
void FusionKernelTaskInit(TaskInfo *taskInfo);
void AicpuMsgVersionTaskInit(TaskInfo *taskInfo);

rtError_t GetLaunchConfigAttr(rtLaunchAttribute_t *attr, LaunchTaskCfgInfo_t *launchTaskCfg);
rtError_t GetLaunchConfigInfo(const rtLaunchConfig_t * const launchConfig, LaunchTaskCfgInfo_t *launchTaskCfg);

rtError_t DavidEventRecordTaskInit(TaskInfo * const taskInfo, Event *const eventPtr,
    const int32_t newEventId);
void DavidEventWaitTaskInit(TaskInfo * const taskInfo, Event *const eventPtr, const int32_t eventIndex,
    const uint32_t timeout);
void DavidEventResetTaskInit(TaskInfo * const taskInfo, Event *const eventPtr, const int32_t eventIndex);
void DavidEventRecordTaskUnInit(TaskInfo * const taskInfo);
void DavidEventWaitTaskUnInit(TaskInfo * const taskInfo);
void DavidEventResetTaskUnInit(TaskInfo * const taskInfo);
void DavidUpdateAndTryToDestroyEvent(TaskInfo *taskInfo, Event **eventPtr, DavidTaskMapType taskMapType);
void ConstructDavidSqeForEventRecordTask(TaskInfo *const taskInfo, rtDavidSqe_t *const command, uint64_t sqBaseAddr);
void ConstructDavidSqeForEventWaitTask(TaskInfo *taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr);
void ConstructDavidSqeForEventResetTask(TaskInfo *taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr);
void DoCompleteSuccessForDavidEventRecordTask(TaskInfo * const taskInfo, const uint32_t devId);
void DoCompleteSuccessForDavidEventWaitTask(TaskInfo * const taskInfo, const uint32_t devId);
void DoCompleteSuccessForDavidEventResetTask(TaskInfo * const taskInfo, const uint32_t devId);
void SetStarsResultForDavidEventRecordTask(TaskInfo * const taskInfo, const rtLogicCqReport_t &logicCq);
void PrintErrorInfoForDavidEventWaitTask(TaskInfo * const taskInfo, const uint32_t devId);
rtDavidSqe_t *GetSqPosAddr(uint64_t sqBaseAddr, uint32_t pos);
void ConstructDavidSqeForHeadCommon(const TaskInfo *taskInfo, rtDavidSqe_t * const sqe);
void ConstructDavidAICpuSqeForDavinciTaskBase(TaskInfo *const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr);
void ConstructDavidAICpuSqeForDavinciTask(TaskInfo *const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr);
void ConstructAicpuSubSqeBase(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint32_t &sqeIndex,
    uint32_t aicpuIndex, uint32_t taskIdx, uint64_t sqBaseAddr);
void ConstructAicpuSubSqe(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint32_t &sqeIndex,
    uint32_t aicpuIndex, uint32_t taskIdx, uint64_t sqBaseAddr);
void ConstructDavidSqeForCmoTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr);
void ConstructDavidSqeForMemcpyAsyncTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr);
void ConstructDavidSqeForUbDirectSendTask(TaskInfo *taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr);
void ConstructDavidSqeForUbDbSendTask(TaskInfo *taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr);
void ConstructDavidSqeForLabelSetTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr);
void ConstructDavidSqeForStreamActiveTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr);
void ConstructDavidSqeForStreamSwitchTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr);
void ConstructDavidSqeForStreamLabelSwitchByIndexTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr);
void ConstructDavidSqeForAicpuInfoLoadTask(TaskInfo *taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr);
void ConstructDavidSqeForModelUpdateTask(TaskInfo * const taskInfo, rtDavidSqe_t *const command, uint64_t sqBaseAddr);
void ConstructDavidSqeForNopTask(TaskInfo * const taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr);
void ConstructDavidSqeForNotifyWaitTask(TaskInfo *taskInfo, rtDavidSqe_t *const command, uint64_t sqBaseAddr);
void ConstructDavidSqeForNotifyRecordTask(TaskInfo *taskInfo, rtDavidSqe_t *const command, uint64_t sqBaseAddr);
void ConstructDavidSqeForMemWaitValueTask(TaskInfo* taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr);
void ConstructFirstDavidSqeForMemWaitValueTask(TaskInfo* taskInfo, rtDavidSqe_t *const davidSqe);
void ConstructSecondDavidSqeForMemWaitValueTask(TaskInfo* taskInfo, rtDavidSqe_t *const davidSqe,
    const RtStarsMemWaitValueInstrFcPara &fcPara);
void ConstructNopSqeForMemWaitValueTask(TaskInfo* taskInfo, rtDavidSqe_t *const davidSqe);


void InitStarsSdmaSqeForDavid(RtDavidStarsMemcpySqe *sdmaSqe, const rtTaskCfgInfo_t * const cfgInfo,
    const Stream *stm);
void ConstructDavidCmoSqe(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr);
void ConstructDavidCmoAddrSqe(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr);
void ConstructDavidCmoSdmaSqe(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr);
void ConstructDavidMemcpySqe(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr);
}  // namespace runtime
}  // namespace cce
#endif  // __CCE_RUNTIME_STARS_DAVID_HPP__