/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef KFC_DUMP_SERVER_DATA_STUB_H
#define KFC_DUMP_SERVER_DATA_STUB_H

#include <cstdint>
#include <string>
#include <vector>
#include "kfc_dump_stub_config.h"
#include "dump_stats_param.h"
#include "dump_stats_server.h"
#include "datadump_kfc_interface.h"

using namespace kfc_dump_stats;

// 由 stub/datadump_kfc_interface.cpp 提供，构造测试用 tensor 信息
struct KfcDumpInfo GetDumpInfo(const KfcDumpTask& taskKey);

extern KfcDumpInfo* g_kfcDumpInfo;

// 由 stub/ascend_stub.cpp 提供，重置 sq head/tail 模拟计数器。
// 每个用例开始前必须调用，避免跨用例状态累积。
void ResetSqCqStub();

// 由 stub/ascend_stub.cpp 提供，改写驱动打桩返回的 sq 深度，用于构造异常场景。
void SetStubSqDepth(uint32_t depth);

// 由 stub/datadump_kfc_interface.cpp 提供，改写打桩 tensor 的 shape 维数。
// 默认维数见 STUB_DEFAULT_SHAPE_DIMS（定义于 kfc_dump_stub_config.h）。
void SetStubShapeDims(size_t dims);

constexpr uint64_t MSGQ_BUFFER_SIZE = 1024 * 1024;
constexpr uint64_t OUTPUT_BUFFER_SIZE = 512;
constexpr uint64_t WORKSPACE_BUFFER_SIZE = 40 * 64 * 8;
constexpr uint64_t STACK_PHYBASE_BUFF_SIZE = 40 * 32 * 1024;

extern uint8_t sqBuffer[64 * 2048];

class StubKFCDumpParam {
public:
    StubKFCDumpParam()
    {
        // msgQ 缓冲区必须清零：其中的 valid 标志是与 AIV 侧（UT 中为
        // KFCSeverProcess 线程）的同步依据，残留数据会被误判为有效消息，
        // 导致用例间相互干扰。
        (void)memset_s(msgQBuffer, sizeof(msgQBuffer), 0, sizeof(msgQBuffer));
        (void)memset_s(outputBuffer, sizeof(outputBuffer), 0, sizeof(outputBuffer));

        KfcDumpWorkSpace& kfcWorkSpace = initParam.kfcWorkSpace;
        kfcWorkSpace.msgQ = reinterpret_cast<uint64_t>(msgQBuffer);
        kfcWorkSpace.msgQSize = MSGQ_BUFFER_SIZE;
        kfcWorkSpace.output = reinterpret_cast<uint64_t>(outputBuffer);
        kfcWorkSpace.outputSize = OUTPUT_BUFFER_SIZE;
        kfcWorkSpace.workspace = reinterpret_cast<uint64_t>(workspace);
        kfcWorkSpace.workspaceSize = WORKSPACE_BUFFER_SIZE;
        kfcWorkSpace.stackPhyBase32k = reinterpret_cast<uint64_t>(stackPhyBase32k);
        kfcWorkSpace.stackPhyBase32kSize = STACK_PHYBASE_BUFF_SIZE;

        KfcDumpOpConfig& config = initParam.config;
        config.aiCoreNum = 20;
        config.vectorCoreNum = 40;
        config.ubSize = 200 * 1024;
        config.dumpStatPcAddr = 0;
        config.statsType = 63;
        config.chipType = CHIP_CLOUD_V2;

        KfcDumpStreamInfo& streamInfo = initParam.streamInfo;
        streamInfo.streamIds = 50;
        streamInfo.sqIds = 50;
        streamInfo.cqIds = 50;
        streamInfo.logicCqIds = 50;
        streamInfo.deviceId = 0;

        dumpContext.msgQ = kfcWorkSpace.msgQ;
        dumpContext.workspace = kfcWorkSpace.workspace;
        dumpContext.workspaceSize = kfcWorkSpace.workspaceSize;
        dumpContext.aiCoreNum = config.aiCoreNum;
        dumpContext.ubSize = config.ubSize;
        dumpContext.syncSpace = kfcWorkSpace.msgQ + MSG_BODY_SIZE;

        dumpStreamCtx.streamId = streamInfo.streamIds;
        dumpStreamCtx.sqId = streamInfo.sqIds;
        dumpStreamCtx.cqId = streamInfo.cqIds;
        dumpStreamCtx.logicCqId = streamInfo.logicCqIds;
        dumpStreamCtx.devId = streamInfo.deviceId;
        dumpStreamCtx.chipType = CHIP_CLOUD_V2;
        dumpStreamCtx.sqHead = 0;
        dumpStreamCtx.sqTail = 0;
        dumpStreamCtx.sqDepth = 2048;
        dumpStreamCtx.sqBaseAddr = reinterpret_cast<void*>(sqBuffer);
    }

    KfcDumpContext dumpContext;
    KfcDumpOpInitParam initParam;
    KfcDumpStreamCtx dumpStreamCtx;

private:
    uint8_t msgQBuffer[MSGQ_BUFFER_SIZE];
    uint8_t outputBuffer[OUTPUT_BUFFER_SIZE];
    uint8_t workspace[WORKSPACE_BUFFER_SIZE];
    uint8_t stackPhyBase32k[STACK_PHYBASE_BUFF_SIZE];
};

#endif // KFC_DUMP_SERVER_DATA_STUB_H
