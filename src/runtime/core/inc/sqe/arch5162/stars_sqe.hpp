/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_STARS_SQE_HPP
#define CCE_RUNTIME_STARS_SQE_HPP

#include <cstdint>

namespace cce {
namespace runtime {

enum rtStarsSqeType {
    RT_STARS_SQE_TYPE_KS_AIC            = 0, // AIC
    RT_STARS_SQE_TYPE_AICPU             = 1, // AICPU
    RT_STARS_SQE_TYPE_KS_AIV            = 2, // AIV
    RT_STARS_SQE_TYPE_PLACE_HOLDER      = 3, // PLACE_HOLDER
    RT_STARS_SQE_TYPE_EVENT_RECORD      = 4, // EVENT_RECORD
    RT_STARS_SQE_TYPE_EVENT_WAIT        = 5, // EVENT_WAIT
    RT_STARS_SQE_TYPE_NOTIFY_RECORD     = 6, // NOTIFY_RECORD
    RT_STARS_SQE_TYPE_NOTIFY_WAIT       = 7, // NOTIFY_WAIT
    RT_STARS_SQE_TYPE_NOTIFY_SEND       = 8, // NOTIFY_SEND
    RT_STARS_SQE_TYPE_WRITE_VALUE       = 9, // WRITE_VALUE
    RT_STARS_SQE_TYPE_LP_AIC            = 10, // LP_AIC
    RT_STARS_SQE_TYPE_INVALID           = 63, // invalid type

    RT_STARS_SQE_TYPE_FFTS              = 0, // FFTS
    RT_STARS_SQE_TYPE_SDMA              = 11, // SDMA
    RT_STARS_SQE_TYPE_VPC               = 12, // VPC
    RT_STARS_SQE_TYPE_JPEGE             = 13, // JPEGE
    RT_STARS_SQE_TYPE_JPEGD             = 14, // JPEGD
    RT_STARS_SQE_TYPE_DSA               = 15, // DSA
    RT_STARS_SQE_TYPE_CDQM              = 19, // CDQM
    RT_STARS_SQE_TYPE_VIR_TYPE          = 0xFF, // DVPP virtual SQE TYPE
};

enum rtStarsSqeSubType {
    /* PLACE_HOLDER_SUBTYPE BEGIN */
    RT_SQE_SUBTYPE_CONDS_MODEL_EXEC = 1,
    RT_SQE_SUBTYPE_CONDS_STREAM_SWITCH_EX = 2,
    RT_SQE_SUBTYPE_CONDS_STREAM_ACTIVE = 3,
    RT_SQE_SUBTYPE_CONDS_LABEL_SWITCH_BY_INDEX = 4,
    RT_SQE_SUBTYPE_CONDS_LABEL_SET = 5,

    RT_SQE_SUBTYPE_UPDATE_ADDRESS = 19,
    RT_SQE_SUBTYPE_MEMORY_COPY = 20,
    RT_SQE_SUBTYPE_MEMORY_SET = 21,
    RT_SQE_SUBTYPE_AICPU = 22,
    RT_SQE_SUBTYPE_DATADUMP = 23,
    RT_SQE_SUBTYPE_CALLBACK = 24,
    RT_SQE_SUBTYPE_MODEL_MAINTAINCE = 25,
    /* PLACE_HOLDER_SUBTYPE END */

    /* WRITE_VALUE_SUBTYPE BEGIN */
    RT_SQE_SUBTYPE_MEMORY = 30,
    RT_SQE_SUBTYPE_NOTIFY_ID = 31,
    /* WRITE_VALUE_SUBTYPE END */

    /* NOTIFY_RECORD_SUBTYPE BEGIN */
    RT_SQE_SUBTYPE_AICPU_RESUME = 40,
    RT_SQE_SUBTYPE_CALLBACK_RESUME = 41,
    RT_SQE_SUBTYPE_DATA_DUMP_RESUME = 42,
    RT_SQE_SUBTYPE_EXECUTE_FAIL = 43,
    /* NOTIFY_RECORD_SUBTYPE END */

    /* PROFILING_SUBTYPE BEGIN */
    RT_SQE_SUBTYPE_PROFILER_DYNAMIC_ENABLE = 50,
    RT_SQE_SUBTYPE_PROFILER_DYNAMIC_DISABLE = 51,
    /* PROFILING_SUBTYPE END */

    RT_SQE_SUBTYPE_RESERVED = 255
};

#pragma pack(push)
#pragma pack (1)

struct rtStarsSqeHeader {
    /* word0 */
    uint8_t type : 6;
    uint8_t l1Lock : 1;
    uint8_t l1UnLock : 1;
    uint8_t ie : 1;
    uint8_t preP : 1;
    uint8_t postP : 1;
    uint8_t wrCqe : 1;
    uint8_t rdConds : 1;
    uint8_t res1 : 3;
    union {
        // blockDim for kickstart command type=0/1/2, sqeSubType for other command types
        uint16_t blockDim;
        uint16_t sqeSubType;
        uint16_t res;
    } u;

    /* word1 */
    uint16_t rtStreamId;
    uint16_t taskId;
};

struct RtStarsAicAivKernelSqe {
    /* word0-1 */
    rtStarsSqeHeader header;

    /* word2-3 */
    uint32_t res1;
    uint16_t scheme : 2;
    uint16_t res2 : 14;
    uint16_t kernelCredit : 8;
    uint16_t res3 : 8;

    /* word4 */
    uint16_t iCachePrefetchCnt : 7;
    uint16_t aiCacheEn : 1;
    uint16_t wrrRatioWr : 3;
    uint16_t wrrRatioRd : 3;
    uint16_t mtePortAwOstdWl : 9;
    uint16_t mtePortArOstdWl : 9;

    /* word5 */
    uint16_t loadMonitorEn : 1;
    uint16_t res4 : 3;
    uint16_t qos : 4;
    uint16_t aiCacheFmFlag : 1;
    uint32_t res5 : 23;

    /* word6-7 */
    uint32_t stackPhyBaseLow;
    uint32_t stackPhyBaseHigh;

    /* word8-9 */
    uint32_t aicStartPcLow;
    uint16_t aicStartPcHigh;
    uint16_t res6;

    /* word10-11 */
    uint32_t TaskParamPtrLow;
    uint32_t TaskParamPtrHigh;

    /* word12-15 */
    uint32_t res7[4];
};

struct RtStarsNotifySqe {
    /* word0-1 */
    rtStarsSqeHeader header;

    /* word2-4 */
    uint32_t res1;
    uint32_t swapoutCredit : 8;
    uint32_t res2 : 23;
    uint32_t timeoutEn : 1;
    uint16_t notify_id : 10;
    uint16_t dstId : 6;
    uint16_t uId : 12;
    uint16_t res3 : 4;

    /* word5-15 */
    uint32_t res[11];
};

struct RtStarsWriteValueSqe {
    /* word0-1 */
    rtStarsSqeHeader header;

    /* word2 */
    uint16_t puHint : 1;
    uint16_t puCoreId : 7;
    uint16_t subType : 8;
    uint16_t res1;

    /* word3 */
    uint16_t notifyId;
    uint8_t kernelCredit;
    uint8_t res2;

    /* word4 */
    uint32_t writeAddrLow;

    /* word5 */
    uint16_t writeAddrHigh;
    uint16_t awsize : 3;
    uint16_t snoop : 1;
    uint16_t res3 : 4;
    uint16_t awcache : 4;
    uint16_t awprot : 3;
    uint16_t va : 1;

    /* word6-7 */
    uint32_t res4;
    uint32_t res5;

    /* word8-15 */
    uint32_t writeValuePart[8];  // write value field
};

struct RtMemCpyAsyncSqe {
    uint64_t src;
    uint64_t dest;
    uint32_t size;
    uint32_t pid;
    uint32_t res2[6];
};

struct RtModelExecuteSqe {
    uint16_t modelId;
    uint16_t streamId;
    uint16_t operation;
    uint16_t streamType;
    uint16_t firstTaskId;
    uint16_t endgraphNotifyId;
    uint32_t executorFlag;
    uint64_t streamExecTimesAddr;
    uint32_t res2[6];
};

struct RtStarsModelMaintainceSqe {
    uint16_t modelId;
    uint16_t streamId;
    uint16_t operation;
    uint16_t streamType;
    uint16_t firstTaskId;
    uint16_t endgraphNotifyId;
    uint32_t executorFlag;
    uint64_t streamExecTimesAddr;
    uint32_t reserved[6];
};

struct RtCallBackSqe {
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
    uint32_t res5;
    uint32_t res6;

    /* word14 */
    uint32_t subTopicId : 12;
    uint32_t topicId : 6;
    uint32_t groupId : 6;
    uint32_t usrDataLen : 8;

    /* word15 */
    uint32_t destPid;
};

struct RtStreamActiveSqe {
    /* word4-15 */
    uint16_t activeStreamId;
    uint16_t reserved[23];
};

struct RtStreamSwitchExSqe {
    /* word4-15 */
    uint64_t varPtr;  // leftPtr
    uint64_t valPtr;  // rightPtr
    int32_t condition;  // rtCondition_t
    uint32_t trueStreamId;
    int32_t dataType;  // rtSwitchDataType_t
    uint16_t reserved[10];
};

struct RtLabelSwitchByIndexSqe {
    /* word4-15 */
    uint64_t indexPtr;
    uint64_t labelInfoPtr;
    uint64_t labelCountPtr;
    uint32_t labelMax;
    uint16_t reserved[10];
};

struct RtLabelSetSqe {
    /* word4-15 */
    uint16_t labelId;
    uint16_t reserved[23];
};

struct RtStarsPhSqe {
    /* word0-1 */
    rtStarsSqeHeader header;

    /* word2-3 */
    uint32_t puHint : 1;
    uint32_t puCoreId : 7;
    uint32_t res1 : 24;
    uint32_t res2;

    /* word4-15 */
    union {
        RtMemCpyAsyncSqe memcpyAsyncWithoutSdmaInfo;
        RtModelExecuteSqe modelExecuteInfo;
        RtStarsModelMaintainceSqe modelMaintainceInfo;
        RtCallBackSqe callBackInfo;
        RtLabelSwitchByIndexSqe labelSwitchInfo;
        RtLabelSetSqe labelSetInfo;
        RtStreamActiveSqe streamActiveInfo;
        RtStreamSwitchExSqe streamSwitchExInfo;
        uint32_t res[12];
    } u;
};

union rtStarsSqe_t final {
    RtStarsAicAivKernelSqe aicAivKernelSqe;
    RtStarsNotifySqe notifySqe;
    RtStarsWriteValueSqe writeValueSqe;
    RtStarsPhSqe phSqe;
};

struct RtStarsFunctionCallSqe {
    uint32_t res[16];
};

struct rtStarsSdmaSqe_t {
    uint32_t opcode : 8;
    uint32_t ie2 : 1;
    uint32_t sssv : 1;
    uint32_t dssv : 1;
    uint32_t sns : 1;
    uint32_t dns : 1;
    uint32_t qos : 4;
    uint32_t sro : 1;
    uint32_t dro : 1;
    uint32_t partid : 8;
    uint32_t mpam : 1;
    uint32_t pmg : 2;
    uint32_t format : 1;
    uint32_t res6 : 1;

    uint16_t srcStreamId;
    uint16_t src_sub_streamid;
    uint16_t dst_streamid;
    uint16_t dstSubStreamId;

    uint32_t length;
};

struct RtFftsPlusKernelSqe {
    rtStarsSqeHeader_t header;
    uint16_t fftsType : 3;
    uint16_t res1 : 9;
    uint16_t wrr_ratio : 4;
    uint16_t res2;
    uint16_t sqe_index;
    uint16_t kernel_credit : 8;
    uint16_t schem : 2;
    uint16_t res3 : 1;
    uint16_t icache_prefetch_cnt : 5;
    uint32_t stackPhyBaseLow;
    uint32_t stackPhyBaseHigh;
    uint32_t res4;
    uint32_t pmg : 2;
    uint32_t ns : 1;
    uint32_t part_id : 8;
    uint32_t res5 : 1;
    uint32_t qos : 4;
    uint32_t res6 : 16;
    uint32_t pc_addr_low;
    uint32_t pcAddrHigh : 16;
    uint32_t res7 : 16;
    uint32_t paramAddrLow;
    uint32_t param_addr_high;
    // use res8[1] bit 4 for l2cache
    uint32_t res8[4];
};

#pragma pack(pop)

}  // namespace runtime
}  // namespace cce
#endif  // CCE_RUNTIME_STARS_SQE_HPP
