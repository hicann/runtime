/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_STARSV2_INFO_HPP__
#define __CCE_RUNTIME_STARSV2_INFO_HPP__

#include "task_info.hpp"
#include "place_holder_sqe.h"
#include "aicpu_sqe.h"
#include "memcpy_sqe.h"
#include "ccu_sqe.h"
#include "starsv2_base.hpp"
using namespace std;

#define RT_STARSV2_IPCINT_MSGLEN_MAX 8
#define RT_STARSV2_ASYNC_CPY_SIZE    64U

#define RT_PRINT_DIRECT_WQE_SIZE_ONE  128
#define RT_PRINT_DIRECT_WQE_SIZE_TWO  192
#define RT_PRINT_UB_AYSNCDMA_SQE_SIZE 128

#define RT_CCU_SQE128B_ARGS_SIZE 13U
#define RT_CCU_SQE32B_ARGS_SIZE  1U
#define RT_CCU_MISSION_ID_MAX    15U

namespace cce {
namespace runtime {
constexpr uint32_t SHIFT_SIX_SIZE = 6U;
constexpr uint64_t RUNTIME_DAVINCI_MAX_TIMEOUT = 1091000000UL; // 1091s
// hcom_cpu:0, aicpu:1, aic:2, ccu die0:3, ccu die1:4
constexpr uint32_t RT_FUSION_HCOMCPU_BIT_MOVE = 0U;
constexpr uint32_t RT_FUSION_AICPU_BIT_MOVE = 1U;
constexpr uint32_t RT_FUSION_AIC_BIT_MOVE = 2U;

constexpr uint16_t RT_STARSV2_AIC_WRR_RD = 1U;
constexpr uint16_t RT_STARSV2_AIC_WRR_WR = 1U;
constexpr uint16_t RT_STARSV2_AIV_WRR_RD = 2U;
constexpr uint16_t RT_STARSV2_AIV_WRR_WR = 2U;

static constexpr uint32_t FUSION_SUBTASK_MOVE[RT_FUSION_CCU] = {
    RT_FUSION_HCOMCPU_BIT_MOVE,
    RT_FUSION_AICPU_BIT_MOVE,
    RT_FUSION_AIC_BIT_MOVE
};

enum rtStarsV2SqeType {
    RT_STARSV2_SQE_TYPE_AIC             = 0, // AIC
    RT_STARSV2_SQE_TYPE_AIV             = 1, // AIV
    RT_STARSV2_SQE_TYPE_FUSION          = 2, // FUSION
    RT_STARSV2_SQE_TYPE_PLACE_HOLDER    = 3, // PLACE_HOLDER
    RT_STARSV2_SQE_TYPE_AICPU_H         = 4, // AICPU_H
    RT_STARSV2_SQE_TYPE_AICPU_D         = 5, // AICPU_D
    RT_STARSV2_SQE_TYPE_NOTIFY_RECORD   = 6, // NOTIFY_RECORD
    RT_STARSV2_SQE_TYPE_NOTIFY_WAIT     = 7, // NOTIFY_WAIT
    RT_STARSV2_SQE_TYPE_WRITE_VALUE     = 8, // WRITE_VALUE
    RT_STARSV2_SQE_TYPE_UBDMA           = 9, // UBDMA
    RT_STARSV2_SQE_TYPE_ASYNCDMA        = 10, // ASYNCDMA
    RT_STARSV2_SQE_TYPE_SDMA            = 11, // SDMA
    RT_STARSV2_SQE_TYPE_VPC             = 12, // VPC
    RT_STARSV2_SQE_TYPE_JPEGE           = 13, // JPEGE
    RT_STARSV2_SQE_TYPE_JPEGD           = 14, // JPEGD
    RT_STARSV2_SQE_TYPE_CMO             = 15, // CMO
    RT_STARSV2_SQE_TYPE_CCU             = 16, // CCU
    RT_STARSV2_SQE_TYPE_NSC             = 18, // NSC
    RT_STARSV2_SQE_TYPE_DSS             = 19, // DSS
    RT_STARSV2_SQE_TYPE_COND            = 20, // condition
    RT_STARSV2_SQE_TYPE_END             = 21,
    RT_STARSV2_SQE_TYPE_INVALID         = 63, // invalid type
};

enum rtStarsV2NotifySubType {
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

enum class StarsV2TaskMapType : std::uint8_t {
    TASK_MAP_TYPE_RECORD_RESET_MAP            = 0U,
    TASK_MAP_TYPE_WAIT_MAP                    = 1U
};

#pragma pack(push)
#pragma pack (1)

struct RtStarsV2HostfuncCallbackSqe {
    /* word0-1 */
    rtStarsV2SqeHeader_t header;

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

struct RtStarsV2AicAivKernelSqe {
    /* word0-1 */
    rtStarsV2SqeHeader_t header;

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

struct RtStarsV2FunctionCallSqe {
    rtStarsV2SqeHeader_t header;

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

struct RtStarsV2NotifySqe {
    /* word0-1 */
    rtStarsV2SqeHeader_t header;

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
struct RtStarsV2WriteValueSqe {
    /* word0-1 */
    rtStarsV2SqeHeader_t header;

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
struct RtStarsV2WriteValuePtrSqe {
    /* word0-1 */
    rtStarsV2SqeHeader_t header;

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
struct RtStarsV2UbdmaDBmodeSqe {
    /* word0-1 */
    rtStarsV2SqeHeader_t header;

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

struct RtStarsV2UbdmaDirectWqemodeSqe {
    /* word0-1 */
    rtStarsV2SqeHeader_t header;

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

struct RtStarsV2DvppSqe {
    /* word0-1 */
    rtStarsV2SqeHeader_t header;

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

struct RtStarsV2GetFloatStatusSqe {
    rtStarsV2SqeHeader_t header;

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

struct RtStarsV2DqsSchedEndSqe {
    rtStarsV2SqeHeader_t header;
 
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

union rtStarsV2Sqe_t {
    rtStarsV2CommonSqe_t commonSqe;
    RtStarsV2AicAivKernelSqe aicAivSqe;
    RtStarsV2AicpuKernelSqe aicpuSqe;
    RtStarsV2HostfuncCallbackSqe callbackSqe;
    RtStarsV2PlaceHolderSqe phSqe;
    RtStarsV2NotifySqe notifySqe;
    RtStarsV2WriteValueSqe writeValueSqe;
    RtStarsV2WriteValuePtrSqe writeValuePtrSqe;
    RtStarsV2MemcpySqe memcpyAsyncSqe;
    RtStarsV2PcieDmaSqe pcieDmaSqe;
    RtStarsV2GetFloatStatusSqe getFloatStatusSqe;
    RtStarsV2FunctionCallSqe fuctionCallSqe;
    RtStarsV2AicpuControlSqe aicpuControlSqe;
    RtStarsV2DvppSqe dvppSqe;
    RtStarsV2MemcpyPtrSqe memcpyAsyncPtrSqe;
    RtStarsV2UbdmaDBmodeSqe starsv2UbdmaDbSqe;
    RtStarsV2UbdmaDirectWqemodeSqe starsv2UbdmaDirectSqe;
    RtStarsV2AsyncDmaSqe starsv2AsyncDmaDirectSqe;
    RtStarsV2CmoSqe cmoSqe;
    RtStarsV2CcuSqe ccuSqe;
    RtStarsV2CcuSqe32B ccuSqe32B[2];
    RtStarsV2DqsSchedEndSqe dqsSchedEndSqe;
};

#pragma pack(pop)

using PfnTaskToStarsV2Sqe = void (*)(TaskInfo *taskInfo, rtStarsV2Sqe_t * const starsv2Sqe, uint64_t sqBaseAddr);

PfnTaskToStarsV2Sqe *GetStarsV2SqeFuncAddr();

void ToConstructStarsV2Sqe(TaskInfo *taskInfo, rtStarsV2Sqe_t * const starsv2Sqe, uint64_t sqBaseAddr);
uint32_t GetSendStarsV2SqeNum(const TaskInfo* const taskInfo);
uint8_t GetHeadUpdateFlag(uint64_t allocTimes);
bool IsNeedRetryTask(const uint16_t sqeType);

template<typename T>
void PrintStarsV2Sqe(T const sqe, const char *desc, size_t size = 64)
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

void RegTaskToStarsV2Sqefunc(void);
const char_t* GetNotifySubType(const uint16_t subType);
void InitWriteValueSqe(RtStarsV2WriteValueSqe * const writeValueSqe,
    const rtWriteValueInfo_t * const writeValueInfo);
void AixKernelTaskInitForFusion(TaskInfo * const taskInfo, const rtAicAivFusionInfo_t * const aicAivInfo,
    const LaunchTaskCfgInfo_t * const launchTaskCfg);
void FusionKernelTaskInit(TaskInfo *taskInfo);
void AicpuMsgVersionTaskInit(TaskInfo *taskInfo);

rtError_t GetLaunchConfigAttr(rtLaunchAttribute_t *attr, LaunchTaskCfgInfo_t *launchTaskCfg);
rtError_t GetLaunchConfigInfo(const rtLaunchConfig_t * const launchConfig, LaunchTaskCfgInfo_t *launchTaskCfg);

rtError_t StarsV2EventRecordTaskInit(TaskInfo * const taskInfo, Event *const eventPtr,
    const int32_t newEventId);
void StarsV2EventWaitTaskInit(TaskInfo * const taskInfo, Event *const eventPtr, const int32_t eventIndex,
    const uint32_t timeout);
void StarsV2EventResetTaskInit(TaskInfo * const taskInfo, Event *const eventPtr, const int32_t eventIndex);
void StarsV2EventRecordTaskUnInit(TaskInfo * const taskInfo);
void StarsV2EventWaitTaskUnInit(TaskInfo * const taskInfo);
void StarsV2EventResetTaskUnInit(TaskInfo * const taskInfo);
void StarsV2UpdateAndTryToDestroyEvent(TaskInfo *taskInfo, Event **eventPtr, StarsV2TaskMapType taskMapType);
void ConstructStarsV2SqeForEventRecordTask(TaskInfo *const taskInfo, rtStarsV2Sqe_t *const command, uint64_t sqBaseAddr);
void ConstructStarsV2SqeForEventWaitTask(TaskInfo *taskInfo, rtStarsV2Sqe_t * const command, uint64_t sqBaseAddr);
void ConstructStarsV2SqeForEventResetTask(TaskInfo *taskInfo, rtStarsV2Sqe_t * const command, uint64_t sqBaseAddr);
void DoCompleteSuccessForStarsV2EventRecordTask(TaskInfo * const taskInfo, const uint32_t devId);
void DoCompleteSuccessForStarsV2EventWaitTask(TaskInfo * const taskInfo, const uint32_t devId);
void DoCompleteSuccessForStarsV2EventResetTask(TaskInfo * const taskInfo, const uint32_t devId);
void SetStarsResultForStarsV2EventRecordTask(TaskInfo * const taskInfo, const rtLogicCqReport_t &logicCq);
void PrintErrorInfoForStarsV2EventWaitTask(TaskInfo * const taskInfo, const uint32_t devId);
rtStarsV2Sqe_t *GetSqPosAddr(uint64_t sqBaseAddr, uint32_t pos);
void ConstructStarsV2SqeForHeadCommon(const TaskInfo *taskInfo, rtStarsV2Sqe_t * const sqe);
void ConstructStarsV2AICpuSqeForDavinciTaskBase(TaskInfo *const taskInfo, rtStarsV2Sqe_t *const starsv2Sqe, uint64_t sqBaseAddr);
void ConstructStarsV2AICpuSqeForDavinciTask(TaskInfo *const taskInfo, rtStarsV2Sqe_t *const starsv2Sqe, uint64_t sqBaseAddr);
void ConstructAicpuSubSqeBase(TaskInfo * const taskInfo, rtStarsV2Sqe_t * const starsv2Sqe, uint32_t &sqeIndex,
    uint32_t aicpuIndex, uint32_t taskIdx, uint64_t sqBaseAddr);
void ConstructAicpuSubSqe(TaskInfo * const taskInfo, rtStarsV2Sqe_t * const starsv2Sqe, uint32_t &sqeIndex,
    uint32_t aicpuIndex, uint32_t taskIdx, uint64_t sqBaseAddr);
void ConstructStarsV2SqeForCmoTask(TaskInfo * const taskInfo, rtStarsV2Sqe_t *const starsv2Sqe, uint64_t sqBaseAddr);
void ConstructStarsV2SqeForMemcpyAsyncTask(TaskInfo * const taskInfo, rtStarsV2Sqe_t *const starsv2Sqe,
    uint64_t sqBaseAddr);
void ConstructStarsV2SqeForUbDirectSendTask(TaskInfo *taskInfo, rtStarsV2Sqe_t * const command, uint64_t sqBaseAddr);
void ConstructStarsV2SqeForUbDbSendTask(TaskInfo *taskInfo, rtStarsV2Sqe_t * const command, uint64_t sqBaseAddr);
void ConstructStarsV2SqeForLabelSetTask(TaskInfo * const taskInfo, rtStarsV2Sqe_t * const starsv2Sqe, uint64_t sqBaseAddr);
void ConstructStarsV2SqeForStreamActiveTask(TaskInfo * const taskInfo, rtStarsV2Sqe_t * const starsv2Sqe, uint64_t sqBaseAddr);
void ConstructStarsV2SqeForStreamSwitchTask(TaskInfo * const taskInfo, rtStarsV2Sqe_t *const starsv2Sqe, uint64_t sqBaseAddr);
void ConstructStarsV2SqeForStreamLabelSwitchByIndexTask(TaskInfo * const taskInfo, rtStarsV2Sqe_t * const starsv2Sqe, uint64_t sqBaseAddr);
void ConstructStarsV2SqeForAicpuInfoLoadTask(TaskInfo *taskInfo, rtStarsV2Sqe_t * const starsv2Sqe, uint64_t sqBaseAddr);
void ConstructStarsV2SqeForModelUpdateTask(TaskInfo * const taskInfo, rtStarsV2Sqe_t *const command, uint64_t sqBaseAddr);
void ConstructStarsV2SqeForNopTask(TaskInfo * const taskInfo, rtStarsV2Sqe_t * const command, uint64_t sqBaseAddr);
void ConstructStarsV2SqeForNotifyWaitTask(TaskInfo *taskInfo, rtStarsV2Sqe_t *const command, uint64_t sqBaseAddr);
void ConstructStarsV2SqeForNotifyRecordTask(TaskInfo *taskInfo, rtStarsV2Sqe_t *const command, uint64_t sqBaseAddr);
void ConstructStarsV2SqeForMemWaitValueTask(TaskInfo* taskInfo, rtStarsV2Sqe_t *const starsv2Sqe, uint64_t sqBaseAddr);
void ConstructFirstStarsV2SqeForMemWaitValueTask(TaskInfo* taskInfo, rtStarsV2Sqe_t *const starsv2Sqe);
void ConstructSecondStarsV2SqeForMemWaitValueTask(TaskInfo* taskInfo, rtStarsV2Sqe_t *const starsv2Sqe,
    const RtStarsMemWaitValueInstrFcPara &fcPara);


void InitStarsSdmaSqeForStarsV2(RtStarsV2MemcpySqe *sdmaSqe, const rtTaskCfgInfo_t * const cfgInfo,
    const Stream *stm);
void ConstructStarsV2CmoSqe(TaskInfo * const taskInfo, rtStarsV2Sqe_t *const starsv2Sqe, uint64_t sqBaseAddr);
void ConstructStarsV2CmoAddrSqe(TaskInfo * const taskInfo, rtStarsV2Sqe_t *const starsv2Sqe, uint64_t sqBaseAddr);
void ConstructStarsV2CmoSdmaSqe(TaskInfo * const taskInfo, rtStarsV2Sqe_t *const starsv2Sqe, uint64_t sqBaseAddr);
void ConstructStarsV2MemcpySqe(TaskInfo * const taskInfo, rtStarsV2Sqe_t *const starsv2Sqe, uint64_t sqBaseAddr);
}  // namespace runtime
}  // namespace cce
#endif  // __CCE_RUNTIME_STARSV2_INFO_HPP__