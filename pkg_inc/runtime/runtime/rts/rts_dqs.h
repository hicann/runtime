/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RTS_DQS_H
#define CCE_RUNTIME_RTS_DQS_H

#include "base.h"

#if defined(__cplusplus)
extern "C" {
#endif


#define RTS_WEAK __attribute__((weak))

#define RT_DQS_MAX_INPUT_QUEUE_NUM      10U
#define RT_DQS_MAX_OUTPUT_QUEUE_NUM     10U

typedef enum {
    RT_DQS_SCHED_TYPE_NN = 1,    // NN+Q硬化调度
    RT_DQS_SCHED_TYPE_VPC = 2,   // VPC/NSC+Q硬化调度
    RT_DQS_SCHED_TYPE_DSS = 3,   // DSS+Q硬化调度
} rtDqsSchedType;

typedef enum {
    RT_DQS_FRAME_MAIN_CHANNEL_ALIGN,  // 主通路对齐
    RT_DQS_FRAME_ALL_CHANNEL_ALIGN    // 全通路对齐
} rtDqsFrameAlignMode;

typedef enum {
    RT_DQS_DROP_FRAME,          // 当前帧不处理，继续等待下一帧，直到所有输入都满足对齐时间阈值
    RT_DQS_USE_DEFAULT_FRAME,   // 使用默认帧
    RT_DQS_USE_HISTORY_FRAME    // 使用历史帧
} rtDqsFrameAlignTimeoutMode;

typedef enum {
    RT_DQS_ZERO_COPY_INPUT,     // 输入数据零拷贝
    RT_DQS_ZERO_COPY_OUTPUT,    // 输出数据零拷贝
} rtDqsZeroCopyType;

typedef enum {  // 零拷贝时，64bit的地址拆分为两个32bit地址，分为高32和低32
    RT_DQS_ZERO_COPY_ADDR_ORDER_LOW32_FIRST = 0,   // 拷贝到目标二进指针地址时，低32bit在前
    RT_DQS_ZERO_COPY_ADDR_ORDER_HIGH32_FIRST = 1,  // 拷贝到目标二进指针地址时，高32bit在前
} rtDqsZeroCopyAddrOrderType;

typedef struct {
    uint8_t type;                                             // 硬化调度类型，参考 rtDqsSchedType
    uint8_t reserve;                                          // 预留
    uint8_t inputQueueNum;                                    // 输入队列数量
    uint8_t outputQueueNum;                                   // 输出队列数量
    uint16_t inputQueueIds[RT_DQS_MAX_INPUT_QUEUE_NUM];       // 输入队列id列表
    uint16_t outputQueueIds[RT_DQS_MAX_OUTPUT_QUEUE_NUM];     // 输出队列id列表
} rtDqsSchedCfg_t;

typedef rtDqsSchedCfg_t rtDqsSchedConfig_t;

// 用于归一接口
typedef struct {
    rtDqsZeroCopyType copyType;
    rtDqsZeroCopyAddrOrderType cpyAddrOrder;  // 拷贝到目标二进指针地址时，高32位和低32位的安排顺序。
    uint16_t queueId;                         // 队列id
    uint16_t count;                           // offset和dest数组的数量
    uint32_t rsv;
    uint64_t *dest;                           // 目标地址的指针数组
    uint64_t *offset;                         // offset数组
} rtDqsZeroCopyCfg_t;

typedef struct {
    uint64_t *condition;         // 存放condition条件的标志
    void *dst;                   // 目的地址
    uint64_t destMax;            // 目的地的最大长度
    void *src;                   // 源地址
    uint64_t cnt;                // 拷贝的字节数
} rtDqsConditionCopyCfg_t;

typedef struct {
    uint32_t mbufHandle;        // ADSPC 数据存放mbuf handle，block_id:pool_id
    uint16_t queueId;           // ADSPC 生产者队列id
    uint8_t  cqeSize;           // ADSPC CQE大小
    uint8_t  cqDepth;           // ADSPC CQ深度
    uint64_t cqeBaseAddr;       // ADSPC CQE基地址
    uint64_t cqeCopyAddr;       // CQE拷贝目的地址，位于mbuf，由调用者根据mbuf data基地址、block_id、offset偏移计算得到
    uint64_t cqHeadRegAddr;     // ADSPC CQ head寄存器地址
    uint64_t cqTailRegAddr;     // ADSPC CQ tail寄存器地址
} rtDqsAdspcTaskCfg_t;
 
typedef enum {
    RT_DQS_TASK_SCHED_CONFIG,
    RT_DQS_TASK_NOTIFY_WAIT,
    RT_DQS_TASK_DEQUEUE,
    RT_DQS_TASK_ZERO_COPY,
    RT_DQS_TASK_CONDITION_COPY,
    RT_DQS_TASK_PREPARE_OUT,
    RT_DQS_TASK_ENQUEUE,
    RT_DQS_TASK_FREE,
    RT_DQS_TASK_FRAME_ALIGN,
    RT_DQS_TASK_SCHED_END,
    RT_DQS_TASK_INTER_CHIP_INIT,
    RT_DQS_TASK_ADSPC,
    RT_DQS_TASK_MAX
} rtDqsTaskType;
 
typedef struct {
    rtDqsTaskType type;
    uint32_t rsv;
    void *cfg;
} rtDqsTaskCfg_t;

/**
 * @ingroup rts_dqs
 * @brief Launch dqs task in stream
 * 
 * @param stm the stream to launch task
 * @param taskCfg the dqs task cfg
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtLaunchDqsTask(const rtStream_t stm, const rtDqsTaskCfg_t * const taskCfg) RTS_WEAK;

#if defined(__cplusplus)
}
#endif
#endif  // CCE_RUNTIME_RTS_DQS_H
