/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TS_AICPU_MSG_H
#define TS_AICPU_MSG_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/* ================================== for obp ============================ */
enum tag_ts_aicpu_mail_box_cmd_type {
    AICPU_MSG_VERSION = 0,        /* 0 aicpu msg version */
    AICPU_MODEL_OPERATE,          /* 1 aicpu model operate */
    AICPU_MODEL_OPERATE_RESPONSE, /* 2 aicpu model operate response */
    AIC_TASK_REPORT,              /* 3 aic task report */
    AICPU_ACTIVE_STREAM,          /* 4 aicpu active stream */
    AICPU_NOTIFY_RECORD,          /* 5 aicpu notify */
    AICPU_DATADUMP_REPORT,        /* 6 data dump report */
    AICPU_DATADUMP_LOADINFO,      /* 7 data dump load info */
    AICPU_DATADUMP_RESPONSE,      /* 8 data dump response */
    AICPU_ABNORMAL,               /* 9 aicpu abnormal report */
    AICPU_TASK_ACTIVE_FOR_WAIT,   /* 10 aicpu dvpp task active */
    AICPU_NOTICE_TS_PID,          /* 11 aicpu pid */
    AICPU_RECORD,                 /* 12 aicpu record: 1-event_record; 2-notify_record */
    AICPU_TIMEOUT_CONFIG,         /* 13 aicpu timeout config */
    AICPU_TIMEOUT_CONFIG_RESPONSE, /* 14 aicpu timeout response */
    CALLBACK_RECORD,              /* 15 synchronized callback record from runtime, not for aicpu */
    AICPU_ERR_MSG_REPORT,         /* 16 aicpu err msg report */
    AICPU_FFTS_PLUS_DATADUMP_REPORT, /* 17 ffts plus data dump report */
    AICPU_INFO_LOAD,                 /* 18 aicpu info load for tiling key sink */
    AICPU_INFO_LOAD_RESPONSE,        /* 19 aicpu info load  response */
    AIC_ERROR_REPORT,             /* 20 aic task err report */
    INVALID_AICPU_CMD,            /* invalid flag */
};

typedef struct tag_ts_aicpu_msg_version {
    volatile uint16_t magic_num;
    volatile uint16_t version;
} ts_aicpu_msg_version_t;

typedef struct tag_ts_aicpu_active_stream {
    volatile uint16_t stream_id;
    volatile uint8_t reserved[6];
    volatile uint64_t aicpu_stamp;
} ts_aicpu_active_stream_t;

typedef struct tag_ts_aicpu_model_operate {
    volatile uint64_t arg_ptr;
    volatile uint16_t sq_id;
    volatile uint16_t task_id;
    volatile uint16_t model_id;
    volatile uint8_t cmd_type;
    volatile uint8_t reserved;
} ts_aicpu_model_operate_t;

typedef struct tag_ts_aicpu_model_operate_response {
    volatile uint8_t cmd_type;
    volatile uint8_t sub_cmd_type;
    volatile uint16_t model_id;
    volatile uint16_t task_id;
    volatile uint16_t result_code;
    volatile uint16_t sq_id;
    volatile uint8_t reserved[2];
} ts_aicpu_model_operate_response_t;

typedef struct tag_ts_to_aicpu_task_report {
    volatile uint16_t model_id;
    volatile uint16_t stream_id;
    volatile uint16_t task_id;
    volatile uint16_t result_code;
} ts_to_aicpu_task_report_t;

typedef struct tag_ts_to_aicpu_aic_err_report {
    volatile uint64_t aiv_err_bitmap;
    volatile uint32_t aic_err_bitmap;
    volatile uint16_t result_code;
} ts_to_aicpu_aic_err_report_t;

typedef struct tag_ts_aicpu_notify {
    volatile uint32_t notify_id;
    volatile uint16_t ret_code;  // using ts_error_t
} ts_aicpu_notify_t;

typedef struct tag_ts_aicpu_event {
    volatile uint32_t record_id;
    volatile uint8_t record_type;
    volatile uint8_t reserved;
    volatile uint16_t ret_code;  // using ts_error_t
    volatile uint16_t fault_task_id;    // using report error of operator
    volatile uint16_t fault_stream_id;  // using report error of operator
} ts_aicpu_record_t;

typedef struct tag_ts_to_aicpu_datadump {
    volatile uint16_t model_id;
    volatile uint16_t stream_id;      // first dump task info
    volatile uint16_t task_id;        // first dump task info
    volatile uint16_t stream_id1;     // second dump task info
    volatile uint16_t task_id1;       // second dump task info
    volatile uint16_t ack_stream_id;  // record overflow dump aic task info
    volatile uint16_t ack_task_id;    // record overflow dump aic task info
    volatile uint8_t reserved[2];
} ts_to_aicpu_datadump_t;

typedef struct tag_ts_to_aicpu_ffts_plus_datadump {
    volatile uint16_t model_id;       // model id
    volatile uint16_t stream_id;      // first dump task info
    volatile uint16_t task_id;        // first dump task info
    volatile uint16_t stream_id1;     // second dump task info
    volatile uint16_t task_id1;       // second dump task info
    volatile uint16_t context_id;     // context id
    volatile uint16_t thread_id;      // current thread ID
    volatile uint8_t reserved[2];
#if (defined(DAVINCI_CLOUD_V2) || defined(DAVINCI_CLOUD_V2_FFTS))
    volatile uint32_t pid;
#endif
} ts_to_aicpu_ffts_plus_datadump_t;

typedef struct tag_ts_datadumploadinfo {
    volatile uint64_t dumpinfo_ptr;
    volatile uint32_t length;
    volatile uint16_t stream_id;
    volatile uint16_t task_id;
    volatile uint16_t kernel_type;
    volatile uint16_t reserved;
} ts_datadumploadinfo_t;

typedef struct tag_ts_to_aicpu_datadumploadinfo {
    volatile uint64_t dumpinfoPtr;
    volatile uint32_t length;
    volatile uint16_t stream_id;
    volatile uint16_t task_id;
} ts_to_aicpu_datadumploadinfo_t;

typedef struct tag_ts_to_aicpu_loadinfo {
    volatile uint64_t aicpuInfoPtr;
    volatile uint32_t length;
    volatile uint16_t stream_id;
    volatile uint16_t task_id;
} ts_to_aicpu_loadinfo_t;

typedef struct tag_ts_aicpu_dump_response {
    volatile uint16_t task_id;
    volatile uint16_t result_code;
    volatile uint16_t stream_id;
    volatile uint8_t cmd_type;
    volatile uint8_t reserved;
} ts_aicpu_dump_response_t;

typedef struct tag_ts_aicpu_response {
    volatile uint16_t task_id;
    volatile uint16_t result_code;
    volatile uint16_t stream_id;
    volatile uint8_t cmd_type;
    volatile uint8_t reserved;
} ts_aicpu_response_t;

typedef struct tag_ts_aicpu_task_active_for_wait {
    volatile uint16_t stream_id;
    volatile uint16_t task_id;
    volatile uint32_t result_code;
} ts_aicpu_task_active_for_wait_t;

typedef struct tag_ts_aicpu_timeout_config_response {
    uint32_t result;
} ts_aicpu_timeout_config_response_t;

typedef struct tag_ts_callback_record {
    volatile uint16_t stream_id;
    volatile uint16_t record_id;
    volatile uint16_t task_id;
    volatile uint16_t reserved;
} ts_callback_record_t;

typedef struct tag_ts_aicpu_err_msg_report {
    volatile uint32_t result_code;
    volatile uint16_t stream_id;
    volatile uint16_t task_id;
    volatile uint16_t offset;
    volatile uint8_t reserved[2];
} ts_aicpu_err_msg_report_t;

typedef struct tag_ts_to_aicpu_timeout_config {
    volatile uint32_t op_wait_timeout_en : 1;
    volatile uint32_t op_execute_timeout_en : 1;
    volatile uint32_t rsv : 30;
    volatile uint32_t op_wait_timeout;
    volatile uint32_t op_execute_timeout;
} ts_to_aicpu_timeout_config_t;

// 51 and 71 share this structure. 51 supports only 24 bytes and 71 supports 40 bytes
// It is recommended that macro control be performed when adding fields.
typedef struct tag_ts_aicpu_sqe {
    volatile uint32_t pid;
    volatile uint8_t cmd_type;
    volatile uint8_t vf_id;
    volatile uint8_t tid;
    volatile uint8_t ts_id;
    union {
        ts_aicpu_model_operate_t aicpu_model_operate;
        ts_aicpu_model_operate_response_t aicpu_model_operate_resp;
        ts_to_aicpu_task_report_t ts_to_aicpu_task_report;
        ts_aicpu_active_stream_t aicpu_active_stream;
        ts_aicpu_notify_t aicpu_notify;
        ts_aicpu_record_t aicpu_record;
        ts_to_aicpu_datadump_t ts_to_aicpu_datadump;
        ts_to_aicpu_datadumploadinfo_t ts_to_aicpu_datadumploadinfo;
        ts_aicpu_dump_response_t aicpu_dump_resp;
        ts_aicpu_task_active_for_wait_t task_active_for_wait;
        ts_to_aicpu_timeout_config_t ts_to_aicpu_timeout_cfg;
        ts_aicpu_timeout_config_response_t aicpu_timeout_cfg_resp;
        ts_callback_record_t callback_record; /* synchronized callback record from runtime, not for aicpu */
        ts_aicpu_err_msg_report_t aicpu_err_msg_report;
        ts_to_aicpu_ffts_plus_datadump_t ts_to_aicpu_ffts_plus_datadump;
        ts_to_aicpu_loadinfo_t ts_to_aicpu_info;
        ts_aicpu_response_t aicpu_resp;
        ts_to_aicpu_aic_err_report_t ts_to_aicpu_aic_err_report;
        ts_aicpu_msg_version_t aicpu_msg_version;
    } u;
} ts_aicpu_sqe_t;

/*============================== for david =======================================*/

enum tag_ts_to_aicpu_msg_cmd_type {
    TS_AICPU_MSG_VERSION            = 0,         /* 0 aicpu msg version */
    TS_AICPU_MODEL_OPERATE          = 1,         /* 1 model operate */
    TS_AICPU_TASK_REPORT            = 2,         /* 2 aic task report */
    TS_AICPU_ACTIVE_STREAM          = 3,         /* 3 aicpu active stream */
    TS_AICPU_RECORD                 = 4,         /* 4 aicpu notify */
    TS_AICPU_NORMAL_DATADUMP_REPORT = 5,         /* 5 normal data dump report */
    TS_AICPU_DEBUG_DATADUMP_REPORT  = 6,         /* 6 debug datadump report */
    TS_AICPU_DATADUMP_INFO_LOAD     = 7,         /* 7 datadump info load */
    TS_AICPU_TIMEOUT_CONFIG         = 8,         /* 8 aicpu timeout config */
    TS_AICPU_INFO_LOAD              = 9,         /* 9 aicpu info load for tiling key sink */
    TS_AIC_ERROR_REPORT            = 10,        /* 10 aic task err report */
    TS_INVALID_AICPU_CMD                         /* invalid flag */
};

typedef struct tag_ts_aicpu_model_operate_msg {
    uint64_t arg_ptr;
    uint16_t stream_id;
    uint16_t model_id;
    uint8_t cmd_type;
    uint8_t reserved[3];
} ts_aicpu_model_operate_msg_t;

typedef struct tag_ts_to_aicpu_task_report_msg {
    uint16_t model_id;
    uint16_t stream_id;
    uint32_t task_id;
    uint16_t result_code;
    uint16_t reserve;
} ts_to_aicpu_task_report_msg_t;

typedef struct tag_ts_aicpu_record_msg {
    uint32_t record_id;
    uint8_t record_type;
    uint8_t reserved;
    uint16_t ret_code;  // using ts_error_t
    uint32_t fault_task_id;    // using report error of operator
} ts_aicpu_record_msg_t;

typedef struct tag_ts_to_aicpu_normal_datadump_msg {
    uint32_t dump_task_id;
    uint16_t dump_stream_id;
    uint8_t is_model : 1;
    uint8_t rsv : 7;
    uint8_t dump_type;
} ts_to_aicpu_normal_datadump_msg_t;

typedef struct tag_ts_to_aicpu_debug_datadump_msg {
    uint32_t dump_task_id;
    uint32_t debug_dump_task_id;
    uint16_t dump_stream_id;
    uint8_t is_model : 1;
    uint8_t rsv : 7;
    uint8_t dump_type;
} ts_to_aicpu_debug_datadump_msg_t;

typedef struct ts_to_aicpu_datadump_info_load_msg {
    uint64_t dumpinfoPtr;
    uint32_t length;
    uint32_t task_id;
    uint16_t stream_id;
    uint16_t reserve;
} ts_to_aicpu_datadump_info_load_msg_t;

typedef struct tag_ts_to_aicpu_info_load_msg {
    uint64_t aicpu_info_ptr;
    uint32_t length;
    uint32_t task_id;
    uint16_t stream_id;
    uint16_t reserve;
} ts_to_aicpu_info_load_msg_t;

typedef struct tag_ts_aicpu_response_msg {
    uint32_t task_id;
    uint16_t stream_id;
    uint16_t result_code;
    uint8_t reserved;     /* for normal/debug dump, and info load */
    uint8_t rsv[3];
} ts_aicpu_response_msg_t;

typedef struct tag_ts_to_aicpu_aic_err_msg {
    uint16_t result_code;
    uint16_t aic_bitmap_num;
    uint16_t aiv_bitmap_num;
    uint8_t bitmap[26];
} ts_to_aicpu_aic_err_msg_t;

typedef struct tag_ts_aicpu_msg_info {
    uint32_t pid;
    uint8_t cmd_type;
    uint8_t vf_id;
    uint8_t tid;
    uint8_t ts_id;
    union {
        ts_aicpu_msg_version_t aicpu_msg_version;
        ts_aicpu_model_operate_msg_t aicpu_model_operate;
        ts_to_aicpu_task_report_msg_t ts_to_aicpu_task_report;
        ts_aicpu_active_stream_t aicpu_active_stream;
        ts_aicpu_record_msg_t aicpu_record;
        ts_to_aicpu_normal_datadump_msg_t ts_to_aicpu_normal_datadump;
        ts_to_aicpu_debug_datadump_msg_t ts_to_aicpu_debug_datadump;
        ts_to_aicpu_datadump_info_load_msg_t ts_to_aicpu_datadump_info_load;
        ts_to_aicpu_timeout_config_t ts_to_aicpu_timeout_cfg;
        ts_to_aicpu_info_load_msg_t ts_to_aicpu_info_load;
        ts_aicpu_response_msg_t aicpu_resp;
        ts_to_aicpu_aic_err_msg_t aic_err_msg;
    } u;
} ts_aicpu_msg_info_t;

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* TS_AICPU_MSG_H */