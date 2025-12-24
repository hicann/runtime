/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_STARSV2_AICPU_SQE_H
#define CCE_RUNTIME_STARSV2_AICPU_SQE_H

#include "base.h"
#include "task_info_base.hpp"
#include "starsv2_base.hpp"
#include "driver/ascend_hal_define.h"

constexpr uint16_t MAGIC_NUMBER_FOR_AICPU_MSG_VERSION = 0x5A5AU;
/* tsfw-aicpu msg version, begin with 0, if change aicpu parse way on different chip, should add 1. */
/* 0 : for obp, primary aicpu parse way */
/* 1 : beginning, for StarsV2, use tag_ts_aicpu_mail_box_cmd_type_new for aicpu msg cmd type */
enum RtAicpuMsgVersion : uint8_t {
    AICPU_MSG_VERSION_FOR_OBP   = 0,
    AICPU_MSG_VERSION_FOR_STARSV2 = 1
};

enum RtStarsV2AicpuMsgCmdType : uint8_t {
    TS_AICPU_MSG_VERSION    = 0,   /* 0 aicpu msg version */
    TS_AICPU_MODEL_OPERATE  = 1,   /* 1 aicpu model operate on starsv2 */
    TS_AICPU_TIMEOUT_CONFIG = 8    /* 8 aicpu timeout config on starsv2 */
};

namespace cce {
namespace runtime {
#pragma pack(push)
#pragma pack (1)

struct StarsV2AicpuModelOperate {
    uint32_t modelInfoAddrLow;
    uint32_t modelInfoAddrHigh : 16;
    uint32_t res : 16;
    uint16_t streamId;
    uint16_t modelId;
    uint8_t cmdType;
    uint8_t reserved[3];
};

struct StarsV2AicpuTimeoutConfig {
    uint32_t opWaitTimeoutEn : 1;
    uint32_t opExecuteTimeoutEn : 1;
    uint32_t rsv : 30;
    uint32_t opWaitTimeout;
    uint32_t opExecuteTimeout;
};

struct StarsV2AicpuMsgVersion {
    uint16_t magicNum;
    uint16_t version;
};

struct StarsV2AicpuUserData {
    uint32_t pid;
    uint8_t cmdType;
    uint8_t vfId;
    uint8_t tid;
    uint8_t tsId;
    union {
        StarsV2AicpuModelOperate modelOperate;
        StarsV2AicpuTimeoutConfig timeoutCfg;
        StarsV2AicpuMsgVersion msgVersion;
    } u;
};

struct RtStarsV2AicpuControlSqe {
    /* word0-1 */
    rtStarsV2SqeHeader_t header;

    /* word2 */
    uint16_t res1;
    uint16_t kernelType : 7;
    uint16_t batchMode : 1;
    uint16_t topicType : 4;
    uint16_t qos : 3;
    uint16_t res2 : 1;

    /* word3 */
    uint16_t sqeIndex;
    uint16_t kernelCredit : 8;
    uint16_t res3 : 5;
    uint8_t sqeLength : 3;

    /* words4-9 use reserved field */
    /* word4-9 */
    StarsV2AicpuUserData usrData;

    /* word10-13 */
    uint32_t res4[4];

    /* word14 */
    uint32_t subTopicId : 12;
    uint32_t topicId : 6;
    uint32_t groupId : 6;
    uint32_t usrDataLen : 8;

    /* word15 */
    uint32_t destPid;
};

union AicpuResv {
    struct {
        uint16_t resv : 10;
        uint16_t aic : 1;
        uint16_t subType : 5;
    } fusionSubTypeDesc;
    uint16_t res1;
};
struct RtStarsV2AicpuKernelSqe {
    /* word0-1 */
    rtStarsV2SqeHeader_t header;

    /* word2 */
    AicpuResv resv;
    uint16_t kernelType : 7;
    uint16_t batchMode : 1;
    uint16_t topicType : 4;
    uint16_t qos : 3;
    uint16_t res2 : 1;

    /* word3 */
    uint16_t sqeIndex;
    uint8_t kernelCredit;
    uint8_t res3 : 5;
    uint8_t sqeLength : 3;

    /* words4-13 use reserved field */
    /* word4-5 */
    uint32_t taskSoAddrLow;
    uint32_t taskSoAddrHigh : 16;
    uint32_t res4 : 16;

    /* word6-7 */
    uint32_t paramAddrLow;
    uint32_t paramAddrHigh : 16;
    uint32_t res5 : 16;  // used, for kfcArgsFmtOffset

    /* word8-9 */
    uint32_t taskNameStrPtrLow;
    uint32_t taskNameStrPtrHigh : 16;
    uint32_t res6 : 16;

    /* word10-11 */
    uint32_t pL2ctrlLow;
    uint32_t pL2ctrlHigh : 16;
    uint32_t overflowEn : 1;
    uint32_t dumpEn : 1;
    uint32_t debugDumpEn : 1;
    uint32_t res7 : 13;

    /* word12-13 */
    uint32_t extraFieldLow;  // send task id info to aicpu
    uint32_t extraFieldHigh;

    /* word14 */
    uint32_t subTopicId : 12;
    uint32_t topicId : 6;
    uint32_t groupId : 6;
    uint32_t usrDataLen : 8;

    /* word15 */
    uint32_t destPid;
};
#pragma pack(pop)
}
}
#endif
