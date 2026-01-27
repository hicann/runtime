/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSCH_CMD_H
#define TSCH_CMD_H
#include "tsch_defines.h"

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

typedef struct {
    uint32_t input_len;
    uint32_t output_len;
    void *input_ptr;
    void *output_ptr;
} stars_ioctl_cmd_args_t;

typedef enum {
    STARS_IOCTL_CMD_BIND_QUEUE = 0x100, /* create queue bind cfg */
    STARS_IOCTL_CMD_UNBIND_QUEUE = 0x101, /* delete queue bind cfg */
    STARS_IOCTL_CMD_GET_BIND_QUEUE = 0x102, /* query queue bind cfg */
    STARS_IOCTL_CMD_GET_ALL_BIND_QUEUE = 0x103, /* query all queue bind cfg */
    STARS_IOCTL_CMD_BIND_QUEUE_MBUF_POOL = 0x104, /* create src queue mbuf pool bind info */
    STARS_IOCTL_CMD_UNBIND_QUEUE_MBUF_POOL = 0x105, /* delete src queue mbuf pool bind info */
    STARS_IOCTL_CMD_GET_QUEUE_MBUF_POOL = 0x106, /* get mbuf pool info */
    STARS_IOCTL_CMD_BIND_FRAME_ALIGN_INFO = 0x107, /* bind frame algin cfg */
    STARS_IOCTL_CMD_UNBIND_FRAME_ALIGN_INFO = 0x108, /* unbind frame algin cfg */
    STARS_IOCTL_CMD_UPDATE_CS_FRAME_ALIGN_INFO = 0x109, /* update ctrl space frame align cfg */
    STARS_IOCTL_CMD_ACC_SUBSCRIBE_QUEUE = 0x200, /* dqs acc subscribe, nn/dss/vpc+q */
    STARS_IOCTL_CMD_INTERCHIP_SUBSCRIBE_QUEUE = 0x201, /* dqs inter chip subscribe */
    STARS_IOCTL_CMD_DQS_CONTROL_SPACE = 0x300, /* create or delete dqs ctrl space shm for nn/dss/vpc+q */
    STARS_IOCTL_CMD_DQS_INTER_CHIP_SPACE = 0x400, /* dqs inter chip sched shm manage */
} stars_ioctl_cmd_t;

/* 单次队列绑定、解绑ioctl请求所支持的操作数量；特别的，单个源队列（生产者队列）最大支持绑定128个目的队列（消费者队列） */
#define STARS_DQS_MAX_QUEUE_OP_NUM                  128U
#define STARS_DQS_MAX_INPUT_QUEUE_NUM               10U     // 输入队列最大数量
#define STARS_DQS_MAX_OUTPUT_QUEUE_NUM              10U     // 输出队列最大数量

typedef enum {
    STARS_QUEUE_OP_SUCCESS = 0,
    STARS_ERROR_FEATURE_NOT_SUPPORT,               // 操作不支持
    STARS_ERROR_ILLEGAL_PARAM,                     // 参数非法
    STARS_ERROR_INTERNAL,                          // 内部错误
    STARS_ERROR_QUEUE_BIND_EXCEED,                 // 当前源队列绑定的目的队列已达上限
    STARS_ERROR_QUEUE_ALREADY_BOUND_TO_SRC,        // 当前目的队列已经与其他的源队列产生绑定关系
    STARS_ERROR_QUEUE_MBUF_POOL_NOT_MATCH,         // 未在controlSpace中找到需要绑定mbuf pool的队列
    STARS_ERROR_QUEUE_NOT_SUB,                     // 目的队列未订阅时无法进行转发关系绑定
    STARS_ERROR_QUEUE_FRAME_ALIGN_INFO_EXIST,      // 队列的帧对齐信息已经存在
} stars_queue_op_error_t;

typedef struct {
    uint8_t count;                                      // 目的队列数量
    uint8_t reserve;                                    // 保留字段
    uint16_t src_qid;                                   // 源队列id
    uint16_t dst_qid_list[STARS_DQS_MAX_QUEUE_OP_NUM];  // 目的队列id
} stars_queue_bind_param_t;

typedef struct {
    uint8_t count;                                   // 操作结果数量
    uint8_t reserve[3];                              // 预留
    uint32_t error_code[STARS_DQS_MAX_QUEUE_OP_NUM]; // 操作结果
} stars_queue_op_result_t;

typedef enum {
    STARS_QUEUE_QUERY_TYPE_SRC = 0,
    STARS_QUEUE_QUERY_TYPE_DST
} stars_queue_query_type_t;

typedef struct {
    stars_queue_query_type_t query_type;
    uint16_t qid;
} stars_queue_query_param_t;

typedef struct {
    uint16_t src_qid;   // 源队列id
    uint16_t dest_qid;  // 目的队列id
} stars_queue_bind_t;

typedef struct {
    uint8_t count;  // 查询结果数量
    uint8_t reserve;
    stars_queue_bind_t bind[STARS_DQS_MAX_QUEUE_OP_NUM];  // 绑定关系查询结果，一个源队列支持
} stars_queue_query_result_t;

typedef enum {
    STARS_QUEUE_UNBIND_TYPE_SRC = 0,        // 按源队列解绑
    STARS_QUEUE_UNBIND_TYPE_DST,            // 按目的队列解绑
    STARS_QUEUE_UNBIND_TYPE_SRC_AND_DST,    // 按源队列和目的队列解绑
} stars_queue_unbind_type_t;

typedef struct {
    stars_queue_unbind_type_t type;
    stars_queue_bind_t queue;
} stars_queue_unbind_info_t;

typedef struct {
    uint8_t count;   // 解绑请求数量
    uint8_t reserve[3];
    stars_queue_unbind_info_t queue_unbind_info[STARS_DQS_MAX_QUEUE_OP_NUM]; // 解绑请求
} stars_queue_unbind_param_t;

typedef struct {
    uint16_t qid;
    uint16_t mbuf_pool_id;
    uint32_t mbuf_data_pool_blk_size;
    uint32_t mbuf_head_pool_blk_size;
    uint32_t mbuf_data_pool_offset;
    uint32_t mbuf_head_pool_offset;
    uint64_t mbuf_head_pool_base_addr;
    uint64_t mbuf_data_pool_base_addr;
    uint64_t mbuf_free_op_addr;
    uint64_t mbuf_alloc_op_addr;
} stars_queue_bind_mbuf_pool_item_t;

typedef struct {
    uint8_t count;  // 生产者队列（源队列）mbuf pool信息绑定请求数量
    stars_queue_bind_mbuf_pool_item_t queue_mbuf_pool_list[STARS_DQS_MAX_QUEUE_OP_NUM];
} stars_queue_bind_mbuf_pool_param_t;

typedef struct {
    uint8_t count;  // mbuf pool解绑请求数量
    uint8_t reserve;
    uint16_t queue_list[STARS_DQS_MAX_QUEUE_OP_NUM]; // 要解绑的生产者队列id
} stars_unbind_queue_mbuf_pool_param_t;

typedef enum {
    STARS_QUEUE_BIND_OP_TYPE_CREATE = 0,
    STARS_QUEUE_BIND_OP_TYPE_DELETE = 1,
} stars_queue_bind_op_type_t;

typedef struct {
    /* 本片 */
    uint16_t src_chip_sub_qid;                  // 本片消费者队列qid，用于订阅本片生产者队列入队数据
    uint16_t src_mbuf_pool_id;                  // pool id
    uint32_t src_mbuf_data_pool_blk_size;       // 实际分配对齐后的blksize，非原始的blksize
    uint32_t src_mbuf_data_pool_blk_real_size;  // 原始的blksize
    uint32_t src_mbuf_head_pool_blk_size;       // 实际分配对齐后的blksize，非原始的blksize
    uint32_t src_mbuf_data_pool_offset;         // mbuf的data block的偏移
    uint32_t src_mbuf_head_pool_offset;         // mbuf的head block的偏移
    uint64_t src_mbuf_data_pool_base_addr;      // data pool池的基地址
    uint64_t src_mbuf_head_pool_base_addr;      // head pool池的基地址
    /* 对片 */
    uint8_t  dst_chip_id;                       // 对片chip id
    uint16_t dst_chip_qid;                      // 对片生产者qid，本片跨片队列时会将对片mbuf入队到此队列，触发对端的调度
    uint16_t dst_mbuf_pool_id;                  // pool id
    uint32_t dst_mbuf_data_pool_blk_size;       // 实际分配对齐后的blksize，非原始的blksize
    uint32_t dst_mbuf_data_pool_blk_real_size;  // 原始的blksize
    uint32_t dst_mbuf_head_pool_blk_size;       // 实际分配对齐后的blksize，非原始的blksize
    uint32_t dst_mbuf_data_pool_offset;         // mbuf的data block的偏移
    uint32_t dst_mbuf_head_pool_offset;         // mbuf的head block的偏移
    uint64_t dst_mbuf_data_pool_base_addr;      // data pool池的基地址
    uint64_t dst_mbuf_head_pool_base_addr;      // head pool池的基地址
} stars_queue_bind_inter_chip_info_item_t;

typedef struct {
    uint8_t op_type;    // stars_queue_bind_op_type_t
    stars_queue_bind_inter_chip_info_item_t interchip_info;
} stars_queue_bind_inter_chip_info_param_t;

typedef struct {
    uint16_t queue_id;  // 消费者队列id
    uint16_t notify_id;
    uint16_t notify_bit_idx;
} stars_subscribe_notify_t;

typedef struct {
    uint8_t op_type;    // stars_queue_bind_op_type_t
    uint8_t ts_id;
    uint8_t stream_id;
    uint8_t count;
    stars_subscribe_notify_t notify_list[STARS_DQS_MAX_INPUT_QUEUE_NUM];
} stars_queue_subscribe_acc_param_t;

typedef enum {
    STARS_DQS_FRAME_MAIN_CHANNEL_ALIGN,  // 主通路对齐
    STARS_DQS_FRAME_ALL_CHANNEL_ALIGN    // 全通路对齐
} stars_dqs_frame_align_mode_t;

typedef enum {
    STARS_DQS_DROP_FRAME,          // 当前帧不处理，继续等待下一帧，直到所有输入都满足对齐时间阈值
    STARS_DQS_USE_DEFAULT_FRAME,   // 使用默认帧
    STARS_DQS_USE_HISTORY_FRAME    // 使用历史帧
} stars_dqs_frame_align_timeout_mode_t;

typedef struct {
    uint16_t qid;
    uint16_t rsv;
    stars_dqs_frame_align_mode_t frame_align_mode;
    stars_dqs_frame_align_timeout_mode_t frame_align_timeout_mode;
    uint32_t frame_align_timeout_threshold;
    uint64_t default_input_addr; // dev va addr
} stars_dqs_frame_align_item_t;

// 帧对齐信息绑定参数信息
typedef struct {
    uint8_t count;
    uint8_t rsv[3];
    stars_dqs_frame_align_item_t frame_align_item_list[STARS_DQS_MAX_INPUT_QUEUE_NUM];
} stars_dqs_frame_align_bind_param_t;

// 帧对齐信息解绑参数信息
typedef struct {
    uint8_t count;
    uint8_t rsv[3];
    uint16_t queue_list[STARS_DQS_MAX_INPUT_QUEUE_NUM]; // 要解绑的qid列表
} stars_dqs_frame_align_unbind_param_t;

// 绑定/解绑帧对齐结果信息，可以体现对应索引qid失败和成功结果
typedef struct {
    uint8_t count;
    uint8_t rsv[3];
    uint32_t error_code[STARS_DQS_MAX_INPUT_QUEUE_NUM];
} stars_dqs_frame_align_op_result_t;

typedef struct {
    uint8_t count;
    uint8_t rsv[3];
    uint16_t queue_list[STARS_DQS_MAX_OUTPUT_QUEUE_NUM];
} stars_get_queue_mbuf_pool_info_param_t;

typedef struct {
    uint8_t count;
    uint8_t rsv[3];
    stars_queue_bind_mbuf_pool_item_t queue_mbuf_pool_list[STARS_DQS_MAX_OUTPUT_QUEUE_NUM];
} stars_dqs_queue_mbuf_pool_result_t;

typedef struct {
    uint8_t ts_id;
    uint8_t stream_id;
    uint16_t rsv;
} stars_dqs_update_cs_frame_align_info_t;

#define MAX_CACHE_SIZE 2

typedef struct {
	uint32_t handle_array[MAX_CACHE_SIZE];
    uint16_t cnt; // 已经缓存的handle个数。
    uint16_t reverse;
    uint64_t syscnt; // 入队时间戳
    uint64_t defaultAddr; // 默认数据地址
} input_mbuf_cache_t;

typedef struct {
    uint16_t stream_id;                                                         // stream id
    uint8_t input_queue_num;                                                    // 输入队列数量
    uint8_t output_queue_num;                                                   // 输出队列数量

    uint16_t input_queue_ids[STARS_DQS_MAX_INPUT_QUEUE_NUM];                    // 输入队列id列表
    uint32_t input_mbuf_list[STARS_DQS_MAX_INPUT_QUEUE_NUM];                    // 输入mbuf handle列表
    input_mbuf_cache_t input_mbuf_cache_list[STARS_DQS_MAX_INPUT_QUEUE_NUM];    // 多路输入场景下，输入mbuf handle的列表

    uint16_t output_queue_ids[STARS_DQS_MAX_OUTPUT_QUEUE_NUM];                  // 输出队列id列表
    uint16_t output_mbuf_pool_ids[STARS_DQS_MAX_OUTPUT_QUEUE_NUM];              // 输出队列所对应的mbuf pool id列表
    uint32_t output_mbuf_list[STARS_DQS_MAX_OUTPUT_QUEUE_NUM];                  // 输出mbuf handle列表

    uint32_t input_data_pool_block_size_list[STARS_DQS_MAX_INPUT_QUEUE_NUM];    // 输入mbuf data pool block大小
    uint32_t input_head_pool_block_size_list[STARS_DQS_MAX_INPUT_QUEUE_NUM];    // 输入mbuf head pool block大小

    uint32_t output_data_pool_block_size_list[STARS_DQS_MAX_OUTPUT_QUEUE_NUM];  // 输出mbuf data pool block大小
    uint32_t output_head_pool_block_size_list[STARS_DQS_MAX_OUTPUT_QUEUE_NUM];  // 输出mbuf head pool block大小

    uint64_t input_addr_list[STARS_DQS_MAX_INPUT_QUEUE_NUM];                    // 模型、VPC或DSS输入数据地址列表
    uint64_t input_data_pool_base_addrs[STARS_DQS_MAX_INPUT_QUEUE_NUM];         // 输入mbuf data地址，注意，这里已经加了偏移 dataPoolOffset
    uint64_t input_head_pool_base_addrs[STARS_DQS_MAX_INPUT_QUEUE_NUM];         // 输入mbuf head地址，注意，这里已经加了偏移 headPoolOffset
    uint64_t input_queue_gqm_base_addrs[STARS_DQS_MAX_INPUT_QUEUE_NUM];         // 输入队列gqm基地址
    uint64_t input_mbuf_free_addrs[STARS_DQS_MAX_INPUT_QUEUE_NUM];              // 输入队列mbuf释放操作寄存器地址

    uint64_t output_addr_list[STARS_DQS_MAX_OUTPUT_QUEUE_NUM];                  // 模型、VPC输出数据地址列表
    uint64_t output_data_pool_base_addrs[STARS_DQS_MAX_OUTPUT_QUEUE_NUM];       // 输出mbuf data地址，注意，这里已经加了偏移 dataPoolOffset
    uint64_t output_head_pool_base_addrs[STARS_DQS_MAX_OUTPUT_QUEUE_NUM];       // 输出mbuf head地址，注意，这里已经加了偏移 headPoolOffset
    uint64_t output_qmngr_enqueue_addrs[STARS_DQS_MAX_OUTPUT_QUEUE_NUM];        // 输出队列qmngr enqueue操作寄存器地址
    uint64_t output_qmngr_ow_addrs[STARS_DQS_MAX_OUTPUT_QUEUE_NUM];             // 输出队列qmngr overwrite操作寄存器地址
    uint64_t output_mbuf_alloc_addrs[STARS_DQS_MAX_OUTPUT_QUEUE_NUM];           // 输出队列mbuf申请操作寄存器地址
    uint64_t output_mbuf_free_addrs[STARS_DQS_MAX_OUTPUT_QUEUE_NUM];            // 输出队列mbuf释放操作寄存器地址

    stars_dqs_frame_align_mode_t frame_align_mode;
    stars_dqs_frame_align_timeout_mode_t frame_align_timeout_mode;
    uint32_t frame_align_timeout_threshold;
    uint64_t default_input_addr[STARS_DQS_MAX_INPUT_QUEUE_NUM];
    uint64_t align_res; // 1 success, 0 fail
} stars_dqs_ctrl_space_t;

typedef struct {
    uint8_t op_type : 1;    // 0: 申请, 1: 释放
    uint8_t ts_id : 7;
    uint8_t stream_id;  // dqs control stream id
} stars_dqs_ctrl_space_param_t;

typedef struct {
    uint32_t status;   // 执行结果状态码
    uint32_t reserve;  // 预留字段
    void *cs_va;       // control space user va
} stars_dqs_ctrl_space_result_t;

typedef struct {
    void *inter_chip_space_va;
} stars_dqs_inter_chip_space_result_t;

/* sdma ptr_mode sqe中SDMA_SQE_BASE_ADDR所指向的数据结构，与stars sdma sqe保持一致，仅word4~15为有效位 */
typedef struct {
    /* word0~3 is not used */
    uint32_t word0;
    uint32_t word1;
    uint32_t word2;
    uint32_t word3;

    /* word 4 */
    uint32_t opcode : 8;
    uint32_t sssv : 1;
    uint32_t dssv : 1;
    uint32_t sns : 1;
    uint32_t dns : 1;
    uint32_t sro : 1;
    uint32_t dro : 1;
    uint32_t stride : 2;
    uint32_t ie2 : 1;
    uint32_t comp_en : 1;
    uint32_t res1 : 14;

    /* word 5 */
    uint16_t sqe_id;
    uint8_t mpam_part_id;
    uint8_t mpamns : 1;
    uint8_t pmg : 2;
    uint8_t qos : 4;
    uint8_t res2 : 1;

    /* word 6 */
    uint16_t src_stream_id;
    uint16_t src_sub_stream_id;
 
    /* word 7 */
    uint16_t dst_stream_id;
    uint16_t dst_sub_stream_id;

    /* word 8~15 */
    uint64_t src_addr;
    uint64_t dst_addr;
    uint32_t length_move;
    uint32_t src_stride_length;
    uint32_t dst_stride_length;
    uint32_t stride_num;
} stars_memcpy_ptr_sdma_sqe_t;

typedef struct {
    uint32_t src_mbuf_handle;                               // 本片出队的mbuf handle
    uint32_t dst_mbuf_handle;                               // 对片申请的mbuf handle
    uint64_t src_mbuf_free_addr;                            // 本片mbuf释放操作寄存器
    uint64_t dst_mbuf_free_addr;                            // 对片mbuf释放操作寄存器
    uint64_t dst_mbuf_alloc_addr;                           // 对片mbuf申请操作寄存器
    uint64_t dst_qmngr_enqueue_addr;                        // 对片qmngr enqueue操作寄存器地址
    uint64_t dst_qmngr_ow_addr;                             // 对片qmngr overwrite操作寄存器

    uint32_t src_mbuf_head_pool_block_size;                 // 本片mbuf pool head block大小
    uint32_t src_mbuf_data_pool_block_size;                 // 本片mbuf pool data block大小
    uint64_t src_mbuf_head_pool_base_addr;                  // 本片mbuf pool head基地址
    uint64_t src_mbuf_data_pool_base_addr;                  // 本片mbuf pool data基地址

    uint32_t dst_mbuf_head_pool_block_size;                 // 对片mbuf pool head block大小
    uint32_t dst_mbuf_data_pool_block_size;                 // 对片mbuf pool data block大小
    uint64_t dst_mbuf_head_pool_base_addr;                  // 对片mbuf pool head基地址
    uint64_t dst_mbuf_data_pool_base_addr;                  // 对片mbuf pool data基地址

    /* SDMA拷贝SQE：用于拷贝mbuf private info数据, 必须64B对齐 */
    __attribute__((aligned(64))) stars_memcpy_ptr_sdma_sqe_t mbuf_head_memcpy_sqe;
    /* SDMA拷贝SQE: 用于拷贝mbuf data数据, 必须64B对齐 */
    __attribute__((aligned(64))) stars_memcpy_ptr_sdma_sqe_t mbuf_data_memcpy_sqe;
} stars_dqs_inter_chip_space_t;

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif