/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ESCHED_PKG_H
#define ESCHED_PKG_H

#define EVENT_MAX_GRP_NAME_LEN   16
#define ESCHED_USR_CFG_DATA_MAX_LEN 32

struct event_sync_msg {
    unsigned int dev_id : 6;
    unsigned int pid : 22;
    unsigned int dst_engine : 4; /* local engine */

    unsigned int gid : 6;
    unsigned int tid : 8;
    unsigned int event_id : 6;
    unsigned int subevent_id : 12; /* Range: 0 ~ 2048 */
    char msg[];
};

/* Keys are aligned by bytes. Key_len is less than or equal to cqe_size.
  If the key is less than one byte, zeros are added to the high bits. */
struct esched_table_key {
    unsigned char *key;
    unsigned int key_len;
};

struct esched_table_key_entry_stat {
    unsigned long long matchNum;
    unsigned int rsv[8]; /* rsv 8 int */
};

typedef enum esched_query_type {
    QUERY_TYPE_LOCAL_GRP_ID,
    QUERY_TYPE_REMOTE_GRP_ID,
    QUERY_TYPE_MAX
} ESCHED_QUERY_TYPE;

struct esched_input_info {
    void *inBuff;
    unsigned int inLen;
};

struct esched_output_info {
    void *outBuff;
    unsigned int outLen;
};

enum esched_table_op_type {
    ESCHED_TABLE_OP_SEND_EVENT, /* send a event */
    ESCHED_TABLE_OP_NEXT_TABLE, /* continue query next table */
    ESCHED_TABLE_OP_DROP, /* drop */
    ESCHED_TABLE_OP_MAX
};

enum esched_data_src_type {
    ESCHED_DATA_SRC_NONE = 0,
    ESCHED_DATA_SRC_RAW_DATA = 1,
    ESCHED_DATA_SRC_KEY = 2,
    ESCHED_DATA_SRC_USR_CFG = 3,
    ESCHED_DATA_SRC_MAX
};

struct esched_table_op_send_event {
    unsigned int dev_id;
    unsigned int dst_engine;
    unsigned int policy;
    unsigned int gid;
    unsigned int event_id;
    unsigned int sub_event_id;
    enum esched_data_src_type data_src;
    unsigned char data[ESCHED_USR_CFG_DATA_MAX_LEN];
    unsigned int data_len;
};

struct esched_table_op_next_table {
    unsigned int dev_id;
    unsigned int table_id;
};

struct esched_table_entry {
    enum esched_table_op_type op;
    union {
        struct esched_table_op_send_event send_event;
        struct esched_table_op_next_table next_table;
    };
};

#endif
