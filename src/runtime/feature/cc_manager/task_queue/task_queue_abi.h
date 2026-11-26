/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CC_TASK_QUEUE_ABI_H
#define CC_TASK_QUEUE_ABI_H

// Host/Device 共用的 POD 协议头，禁止引入任一侧运行时依赖或改变字段布局。
#include <stddef.h>
#include <stdint.h>

// Host: WAITING -> WORKING -> WAITING, TERMINATED on error; Device sets TERMINATED after consuming the queue.
enum TaskQueueStatus : uint32_t {
    TASK_QUEUE_STATUS_WAITING = 0, // 当工作线程尚未启动时，算子不应读取控制头其他数据（可能尚未初始化）
    TASK_QUEUE_STATUS_WORKING = 1, // 工作线程初始化以后进入该状态并保持；算子被动收取任务，不应长期处于该状态
    TASK_QUEUE_STATUS_TERMINATED = 2, // 不区分进入终止状态的原因是正常结束还是异常终止
};

constexpr uint32_t AICC_QUEUE_ERR_OK = 0U;
constexpr uint32_t AICC_QUEUE_ERR_PARAM_INVALID = 1U;
constexpr uint32_t AICC_QUEUE_ERR_TERMINATED = 2U;

// SPSC 环：Host 推进 head，Device 推进 tail/complete，可用槽位数为 depth-1。
struct BarTaskQueue {
    volatile TaskQueueStatus hostStatus;
    volatile TaskQueueStatus deviceStatus;
    volatile uint32_t complete;     // 已完成的任务数量，device 写，host 读
    volatile uint32_t head;         // 生产任务的第一位置， host 写，device 读
    volatile uint32_t tail;         // 消费任务的第一位置， device 写，host 读
    volatile uint32_t depth;        // 队列深度，host 写，device 读，可用的任务槽位数为 depth-1
    volatile uint32_t taskDescSize; // 任务描述大小，host写，device读
    volatile uint32_t deviceErrCode;
    uint8_t taskDescList[];         // 任务描述列表，host写，device读，大小为 depth*taskDescSize
};

constexpr uint32_t BAR_TASK_DESC_ALIGN = 8U; // 描述符起点和步长均须 8B 对齐。

constexpr uint32_t BAR_TASK_QUEUE_MIN_DEPTH = 2U;

static_assert(sizeof(BarTaskQueue) == 32U, "BarTaskQueue header must be 32 bytes");
static_assert(
    offsetof(BarTaskQueue, taskDescList) % BAR_TASK_DESC_ALIGN == 0U,
    "taskDescList must be 8B aligned: AIV scalar cores reject unaligned 64-bit access");

constexpr uint32_t CC_BUFFER_SLOT_NUM = 2U;

struct AiccSliceDescBase {
    volatile uint64_t ciphertextAddr; // Device Buffer A/B 地址（密文所在物理槽）
    volatile uint64_t plaintextAddr;  // 明文地址
    volatile uint32_t ciphertextLen;  // 密文长度（GCM 为密文头 + plaintextLen，CTR 为 plaintextLen）
    volatile uint32_t plaintextLen;   // 明文长度
    volatile uint32_t sliceIdx;       // 分片序号

    static uint32_t PhysicalBufferIndex(const uint32_t sliceIdx) { return sliceIdx % CC_BUFFER_SLOT_NUM; }
};
static_assert(offsetof(AiccSliceDescBase, plaintextLen) == 20U, "AiccSliceDescBase common prefix ABI");

// 描述符采用平铺布局，避免基类尾部 padding 影响跨端 ABI。
struct AiccKeystreamXorSliceDesc {
    volatile uint64_t ciphertextAddr; // Device Buffer A/B 地址（密文所在物理槽）
    volatile uint64_t plaintextAddr;  // 明文地址
    volatile uint32_t ciphertextLen;  // 密文长度（= plaintextLen，CTR 密文无头部）
    volatile uint32_t plaintextLen;   // 明文长度
    volatile uint32_t sliceIdx;       // 分片序号，同时是 complete 协议里的 taskId
    volatile uint32_t reserved;       // 对齐填充，保证 keystreamAddr 8B 对齐
    volatile uint64_t keystreamAddr;  // 本片密钥流在设备侧的地址（长度 = plaintextLen）
};
static_assert(sizeof(AiccKeystreamXorSliceDesc) == 40U, "CTR slice desc must be 40 bytes");
static_assert(sizeof(AiccKeystreamXorSliceDesc) % 8U == 0U, "desc size must preserve taskDescList 8B alignment");
static_assert(
    offsetof(AiccKeystreamXorSliceDesc, reserved) == 28U, "CTR desc common prefix must match AiccSliceDescBase");
static_assert(offsetof(AiccKeystreamXorSliceDesc, keystreamAddr) == 32U, "CTR keystream addr must be 8-byte aligned");

struct AiccKeystreamXorParam {
    uint64_t taskQueueAddr; // CC 分片环地址（in/out/len/keystreamAddr 均从 desc 读）
    uint32_t mode;          // ENCRYPT(D2H，设备加密) / DECRYPT(H2D，设备解密)，均为纯 XOR
    uint32_t totalSlices;   // 本条 memcpy 的总分片数（设备按此逐片消费后退出）
    uint32_t blockDim;      // 消费副本数（AICPU 历史协议字段；host 恒填 0，AIV 下发不读）
    uint32_t totalBytes;    // Plaintext bytes; host slices it in 16 KiB units for blockDim. Device does not read it.
};
static_assert(
    sizeof(AiccKeystreamXorParam) == 24U,
    "AiccKeystreamXorParam must stay 24B (device kernels include this type directly)");

#endif // CC_TASK_QUEUE_ABI_H
