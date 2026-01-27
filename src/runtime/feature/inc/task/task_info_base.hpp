/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_TASK_INFO_BASE_HPP
#define CCE_RUNTIME_TASK_INFO_BASE_HPP

#include "pctrace.hpp"
#include "profiler_struct.hpp"
#include "ffts.hpp"
#include "task_base.hpp"
#include "stars_cond_isa_define.hpp"
#include "module.hpp"
#include "stars_base.hpp"

#define RTS_LITE_PCIE_BAR_COPY_SIZE (1024U)
#define UB_DIRECT_WQE_MIN_LEN (64)
#define UB_DIRECT_WQE_MAX_LEN (128)
#define UB_DOORBELL_NUM_MIN   (1)
#define UB_DOORBELL_NUM_MAX   (2)
#define UB_DB_SEND_MAX_NUM (4)
#define RT_CCU_SQE_ARGS_LEN     (13U)
#define RT_CCU_SQE_ARGS_LEN_128B     (13U)
#define RT_CCU_SQE_ARGS_LEN_32B     (1U)
#define CCU_1ST_SQE_ARGS_LEN    (10)
#define CCU_2ND_SQE_LEFT_LEN    ((RT_CCU_SQE_ARGS_LEN * 2) - CCU_1ST_SQE_ARGS_LEN)
#define STARS_CCU_EXIST_ERROR (0xFF00U)

namespace cce {
namespace runtime {

#pragma pack(push)
#pragma pack (1)
struct rtStarsSqeHeader_t {
    uint8_t type : 6;
    uint8_t l1_lock : 1;
    uint8_t l1_unlock : 1;

    uint8_t ie : 2;
    uint8_t pre_p : 2;
    uint8_t post_p : 2;
    uint8_t wr_cqe : 1;
    uint8_t reserved : 1;

    uint16_t block_dim;  // block_dim or res

    uint16_t rt_stream_id;
    uint16_t task_id;
};

struct rtDavidStarsSqeHeader_t {
    /* word0 */
    uint8_t type : 6;
    uint8_t lock : 1;
    uint8_t unlock : 1;
    uint8_t ie : 1;
    uint8_t preP : 1;
    uint8_t postP : 1;
    uint8_t wrCqe : 1;
    uint8_t ptrMode : 1;
    uint8_t rttMode : 1;
    uint8_t headUpdate : 1;
    uint8_t reserved : 1;
    uint16_t blockDim;

    /* word1 */
    uint16_t rtStreamId;
    uint16_t taskId;
};

struct RtFftsSqe {
    // 0-7 bytes
    rtStarsSqeHeader_t sqeHeader;
    // 8-11 bytes
    uint32_t fftsType : 2;
    uint32_t reserved20 : 16;
    uint32_t qos : 4;
    uint32_t reserved21 : 10;
    // 12-15 bytes
    uint16_t reserved30;
    uint8_t kernelCredit;
    uint8_t reserved31;
    // 16-19 bytes
    uint8_t number_of_subtasks : 6;
    uint8_t reserved40 : 2;
    uint8_t number_of_ticked_cache : 7;
    uint8_t reserved41 : 1;
    uint16_t reserved42;
    // 20-23 bytes
    uint32_t reserved50;
    // 24-31 bytes
    uint64_t pointer_of_ffts_desc : 49;
    uint64_t reserved70 : 15;

    // 32-63 bytes
    uint8_t sub_task_length[32]; // only use 5 bits
};

struct rtStarsCommonSqe_t {
    rtStarsSqeHeader_t sqeHeader;  // word 0-1
    uint32_t commandCustom[14];       // word 2-15 is custom define by command.
};

struct rtDavidStarsCommonSqe_t {
    /* word0-1 */
    rtDavidStarsSqeHeader_t sqeHeader;

    /* word2-15 */
    uint32_t commandCustom[14];       // word 2-15 is custom define by command.
};
#pragma pack(pop)

struct DavinciTaskInfoCommon {
    void *stubFun;
    void *soName;
    void *funcName;
    void *args;
    void *argHandle;
    uint32_t argsSize;
    uint16_t dim;
    uint8_t kernelFlag;
};

struct AicTaskInfo {
    DavinciTaskInfoCommon comm;
    void *descBuf;
    void *descAlignBuf;
    void *sqeDevBuf;     // used to update sqe for capture
    void *oldArgHandle;  // the oldArgHandle in the scene of update sqe for capture
    rtArgsEx_t *argsInfo;
    Kernel *kernel;
    Program *progHandle;
    uint64_t tilingKey;
    uint64_t funcAddr;    /* only for 1910 or 1980 virtual (because of sending thread) */
    uint64_t funcAddr1;
    uint64_t smDescData;
    uint32_t smSize;
    uint16_t groupDim;
    uint16_t groupBlockDim;
    uint8_t kernelTaskMode;
    uint8_t machine;
    uint8_t qos;
    uint8_t partId;
    uint8_t schemMode;
    uint8_t mixOpt : 1;
    uint8_t infMode : 1;
    uint8_t resv : 6;
    uint8_t updateSqeOffset;
    uint8_t res;
    rtArgsSizeInfo_t inputArgsSize;
    uint32_t blockDimOffset;
    uint32_t dynamicShareMemSize;
    uint64_t timeout; // uint in us
};

struct AicpuTaskInfo {
    DavinciTaskInfoCommon comm;
    void *soName;
    void *funcName;
    rtArgsEx_t *argsInfo;
    rtAicpuArgsEx_t *aicpuArgsInfo;
    Kernel *kernel;
    uint32_t aicpuFlags;
    uint32_t headParamOffset;
    uint64_t timeout; // unit: us
    uint8_t aicpuKernelType;
    uint8_t resv;
};

struct rtAicAivFusionInfo_t {
    uint32_t mach;
    uint16_t dimNum;
    uint8_t mixType;
    uint8_t resv;
    LaunchTaskCfgInfo_t *launchTaskCfg;
    Program *program;
    Kernel *kernel;
    uint64_t funcAddr;
    uint64_t funcAddr1;
};

struct rtAicpuArgsDesc_t {
    void *soName;
    void *funcName;
};

struct FusionTaskInfoAicPart {
    Kernel *kernel;   /* 判断Kernel是否为空来判断tilingkey下沉场景 */
    uint64_t funcAddr;
    uint64_t funcAddr1;
    uint16_t dim;
    uint16_t groupDim;
    uint16_t groupBlockDim;
    uint8_t kernelFlag;
    uint8_t qos;
    uint8_t partId;
    uint8_t schemMode;
    uint16_t resv;
    rtArgsSizeInfo_t inputArgsSize;
    uint32_t dynamicShareMemSize;
};

struct FusionTaskInfo {
    FusionTaskInfoAicPart aicPart;
    std::array<rtAicpuArgsDesc_t, FUSION_SUB_TASK_MAX_CPU_NUM> aicpuArgsDesc;
    void *args;
    void *fusionKernelInfo;
    rtFusionArgsEx_t *argsInfo;
    void *argHandle;
    uint32_t argsSize;
    uint8_t sqeLen;
    uint8_t aicAivType;
    uint8_t sqeSubType;
    uint8_t ccuSqeNum;
    uint8_t ccuArgSize;
    std::array<uint8_t, 2> resv; // 2个字节内存空间
    void *oldArgHandle;  // the oldArgHandle in the scene of update sqe for capture
};

struct RecycleArgs {
    void *argHandle;
    void *mixDescBuf;
};

struct DavinciMultiTaskInfo {
    void *multipleTaskInfo;
    std::vector<void *> *cmdListVec; // device memory for cmdlist
    std::vector<void *> *argHandleVec;
    uint32_t cqeErrorCode;
    uint32_t sqeNum;
    uint8_t multipleTaskCqeNum;
    uint8_t sqeType;
    uint8_t errorType;
    bool hasUnderstudyTask;
    uint32_t flag;
};

struct UbDma {
    uint16_t dieId;
    uint16_t functionId;
    uint16_t jettyId;
    std::array<uint8_t, 64> wqe; // 64个字节内存空间
    uint8_t *wqePtr;
    bool isUbAsyncMode;
    int32_t wqeLen;
};

struct MemcpyAsyncTaskInfo {
    struct DMA_ADDR dmaAddr;
    void *src;
    void *destPtr;
    void *srcPtr;
    void *desPtr;
    void *originalDes;
    void *memcpyAddrInfo;
    void *releaseArgHandle;  // old argHandle will be release after update
    std::vector<std::shared_ptr<void>> *guardMemVec;
    uint64_t size;
    uint32_t copyType;
    uint32_t copyKind;
    uint8_t copyDataType;
    uint8_t qos;
    uint8_t partId;
    uint8_t sqeOffset;
    bool isD2dCross;
    uint32_t sqId;
    uint32_t taskPos;
    bool dmaKernelConvertFlag;
    bool dsaSqeUpdateFlag;
    bool d2dOffsetFlag;
    bool isSqeUpdateH2D;
    bool isSqeUpdateD2H;
    uint64_t dstOffset;
    uint64_t srcOffset;
    struct UbDma ubDma;
    bool isConcernedRecycle;
};

struct rtD2DAddrCfgInfo_t {
    uint64_t srcOffset;
    uint64_t dstOffset;
};

union rtDsaCfgParam{
    struct {
        uint8_t dropoutRatio : 1; // 0:addr 1:value
        uint8_t uniformMin : 1;
        uint8_t uniformMax : 1;
        uint8_t normalMean : 1;
        uint8_t normalStddev : 1;
        uint8_t seed : 1;
        uint8_t randomNumber : 1;
        uint8_t rsv : 1;
    } bits;
    uint8_t u8;
};

struct RtLogicCqReportMsg {
    volatile uint16_t phase      : 1;
    volatile uint16_t sop        : 1; /* start of packet, indicates this is the first 32bit return payload */
    volatile uint16_t mop        : 1; /* middle of packet, indicates the payload is a continuation of previous task
                                      return payload */
    volatile uint16_t eop        : 1; /* end of packet, indicates this is the last 32bit return payload. SOP & EOP
                                      can appear in the same packet, MOP & EOP can also appear on the same packet. */
    volatile uint16_t logic_cq_id  : 12;
    volatile uint16_t stream_id ;
    volatile uint16_t task_id;
    volatile uint8_t error_type;
    volatile uint8_t need_sorting; /* drv need sorting cqe data to user thread */
    volatile uint32_t error_code;
    volatile uint32_t pay_load;
};

/**
 * @ingroup engine or starsEngine
 * @brief the type defination of logic cq for all chipType(total 32 bytes).
 */
struct rtLogicCqReport_t {
    volatile uint16_t streamId;
    volatile uint16_t taskId;
    volatile uint32_t errorCode;    // cqe acc_status/sq_sw_status
    volatile uint8_t errorType;     // bit0 ~ bit5 cqe stars_defined_err_code, bit 6 cqe warning bit
    volatile uint8_t sqeType;
    volatile uint16_t sqId;
    volatile uint16_t sqHead;
    volatile uint16_t matchFlag : 1;
    volatile uint16_t dropFlag : 1;
    volatile uint16_t errorBit : 1;
    volatile uint16_t accError : 1;
    volatile uint16_t reserved0 : 12;
    union {
        volatile uint64_t timeStamp;
        volatile uint16_t sqeIndex;
    } u1;
    /* Union description:
     *  Internal: enque_timestamp temporarily used as dfx
     *  External: reserved1
     */
    union {
        volatile uint64_t enqueTimeStamp;
        volatile uint64_t reserved1;
    } u2;
};

// =============================
struct RtRdmaDbCmd {
    uint32_t reserve0;  // tag 0~23 & cmd (24:27)& rsv(28:31)
    uint16_t sqProducerIdx;
    uint16_t reserve1;  // uint16_t sl : 3; uint16_t reserve:13;//RQ//SRQ & CQ
};

union rtRdmaDbInfo_t {
    uint64_t value; // for ts module
    RtRdmaDbCmd cmd;
};

struct RtRdmaDbIndexStars {
    uint32_t vfId : 12;
    uint32_t sqDepthBitWidth : 4; // sqDepth = 1 << sqDepthBitWidth
    uint32_t dieId : 8;
    uint32_t rsv : 7;
    uint32_t qpnEn : 1;
};

union rtRdmaDbIndex_t{
    uint32_t value; // for ts module
    RtRdmaDbIndexStars dbIndexStars; // new define for stars
};

// =============================

struct NO_DMA_OFFSET_ADDR {
    uint32_t srcVirAddr;
    uint32_t dstVirAddr;
    uint8_t reserved[4];
};

struct D2D_ADDR_OFFSET {
    uint32_t srcOffsetLow;
    uint32_t dstOffsetLow;
    uint16_t srcOffsetHigh;
    uint16_t dstOffsetHigh;
};

struct rtFftsPlusTaskErrInfo_t {
    uint32_t contextId;
    uint16_t threadId;
    uint32_t errType;
    uint64_t pcStart; // aic/aiv context
    rtStarsCommonSqe_t dsaSqe; // dsa context
};

struct rtBarrierTaskCmoInfo_t {
    uint16_t cmoType; // // 0 is barrier, 1 is invalid, Prefetch is 2, Write_back is 3, FE/GE only use invalid type.
    uint16_t cmoId;
};

struct rtBarrierTaskMsg_t {
    uint8_t cmoIdNum;   //cmoIdNum max is 6
    rtBarrierTaskCmoInfo_t cmoInfo[6U]; //6U, BarrierTask support max 6 cmoid in barrier
};

struct rtPkgDesc {
    uint16_t receivePackage;
    uint16_t expectPackage;
    uint8_t packageReportNum;
};

// StarsCommonTask
struct StarsCommonTaskInfo {
    void *cmdList; // device memory for cmdlist
    void *srcDevAddr;  // for dsa src addr
    void *randomDevAddr;
    union {
        rtStarsCommonSqe_t commonSqe;
        rtDavidStarsCommonSqe_t commonDavidSqe;
    } commonStarsSqe;
    uint32_t flag;
    uint32_t errorTimes;
};

struct CommonCmdTaskInfo {
    uint16_t cmdType;
    uint16_t streamId; // for streamclear
    uint16_t step;     // for streamclear
    uint32_t notifyId; // for notifyreset
};

// =============================
enum rtDavidUbDmaSqeMode : uint16_t {
    RT_DAVID_SQE_DIRECTWQE_MODE        = 0, // direct wqe
    RT_DAVID_SQE_DOORBELL_MODE         = 1, // doorbell
    RT_STARS_SQE_MODE_END              = 2
};

struct DavidUbDbinfo {
    uint16_t jettyId;
    uint16_t funcId;
    uint16_t piVal;
    uint16_t dieId;
};

struct UbSendTaskInfo {
    uint8_t wrCqe;
    uint8_t dbNum;
    std::array<DavidUbDbinfo, UB_DB_SEND_MAX_NUM> info;
};

struct DirectSendTaskInfo {
    uint16_t wrCqe;
    uint16_t wqeSize;
    uint16_t dieId;
    uint16_t jettyId;
    uint16_t funcId;
    uint8_t *wqe;
    uint16_t wqePtrLen;
};

union CcuTaskErrInfo {
    struct {
        uint32_t subStatus : 8;
        uint32_t status : 8;
        uint32_t missionId : 4;
        uint32_t dieId : 2;
        uint32_t res : 10;
    } info;
    uint32_t err;
};

struct CcuLaunchTaskInfo {
    CcuTaskErrInfo errInfo;
    uint8_t dieId;
    uint8_t missionId;
    uint16_t timeout;
    uint16_t instStartId;
    uint16_t instCnt;
    uint16_t ccu_size;
    uint16_t res;
    uint32_t key;
    uint32_t *args;
};

struct AicpuMsgVersionTaskInfo {
    uint16_t magicNum;
    uint16_t version;
};

/*
 * random num task for dsa
 * dropout bitmask  : firstParam --> dropout ration;
 * 均匀分布          : firstParam --> min; secondParam --> max
 * 正态分布          : firstParam --> mean; secondParam --> stddev
 * 截断正态分布       : firstParam --> mean; secondParam --> stddev
 */
struct RandomParamCfgInfo {
    uint64_t firstParam;
    uint64_t secondParam;
};

// =============================

}
}
#endif  // CCE_RUNTIME_TASK_INFO_BASE_HPP