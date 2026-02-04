/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 *
 * The code snippet comes from CANN project
 *
 * Copyright (c) Huawei Technologies Co., Ltd. 2012-2019. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#ifndef TRS_PKG_H
#define TRS_PKG_H

#include "common_pkg.h"

#define SQCQ_RTS_INFO_LENGTH 5
#define SQCQ_RESV_LENGTH 8
#define SQCQ_UMAX 0xFFFFFFFF

typedef enum tagDrvSqCqType {
    DRV_NORMAL_TYPE = 0,
    DRV_CALLBACK_TYPE,
    DRV_LOGIC_TYPE,
    DRV_SHM_TYPE,
    DRV_CTRL_TYPE,
    DRV_GDB_TYPE,
    DRV_INVALID_TYPE
}  drvSqCqType_t;

struct halSqCqInputInfo {
    drvSqCqType_t type;  // normal : 0, callback : 1
    uint32_t tsId;
    /* The size and depth of each cqsq can be configured in normal mode, but this function is not yet supported */
    uint32_t sqeSize;    // normal : 64Byte
    uint32_t cqeSize;    // normal : 12Byte
    uint32_t sqeDepth;   // normal : 1024
    uint32_t cqeDepth;   // normal : 1024

    uint32_t grpId;   // runtime thread identifier,normal : 0
    uint32_t flag;    // ref to TSDRV_FLAG_*
    uint32_t cqId;    // if flag bit 0 is 0, don't care about it
    uint32_t sqId;    // if flag bit 1 is 0, don't care about it

    uint32_t info[SQCQ_RTS_INFO_LENGTH];  // inform to ts through the mailbox, consider single operator performance
    uint32_t ext_info_len;
    void *ext_info;    // the header of ext_info is struct trs_ext_info_header
    uint32_t res[SQCQ_RESV_LENGTH - 3];
};

struct halSqCqFreeInfo {
    drvSqCqType_t type; // normal : 0, callback : 1
    uint32_t tsId;
    uint32_t sqId;
    uint32_t cqId;  // cqId to be freed, if flag bit 0 is 0, don't care about it
    uint32_t flag;  // bit 0 : whether cq is to be freed  0 : free, 1 : no free
    uint32_t res[SQCQ_RESV_LENGTH];
};

typedef enum tagDrvSqCqPropType {
    DRV_SQCQ_PROP_SQ_STATUS = 0x0,
    DRV_SQCQ_PROP_SQ_HEAD,
    DRV_SQCQ_PROP_SQ_TAIL,
    DRV_SQCQ_PROP_SQ_DISABLE_TO_ENABLE,
    DRV_SQCQ_PROP_SQ_CQE_STATUS, /* read clear */
    DRV_SQCQ_PROP_SQ_REG_BASE,
    DRV_SQCQ_PROP_SQ_BASE,
    DRV_SQCQ_PROP_SQ_DEPTH,
    DRV_SQCQ_PROP_SQ_PAUSE,
    DRV_SQCQ_PROP_SQ_MEM_ATTR,
    DRV_SQCQ_PROP_SQ_RESUME,
    DRV_SQCQ_PROP_SQCQ_RESET,
    DRV_SQCQ_PROP_CQ_DEPTH,
    DRV_SQCQ_PROP_SQE_SIZE,
    DRV_SQCQ_PROP_CQE_SIZE,
    DRV_SQCQ_PROP_H2D_ASYNC_JETTY_INFO,
    DRV_SQCQ_PROP_D2D_ASYNC_JETTY_INFO,
    DRV_SQCQ_PROP_MAX
} drvSqCqPropType_t;

#define SQCQ_CONFIG_INFO_LENGTH 8
#define SQCQ_CONFIG_INFO_FLAG (SQCQ_CONFIG_INFO_LENGTH - 1) // 0: local; 1: remote
#define SQCQ_QUERY_INFO_LENGTH 8

struct halSqCqConfigInfo {
    drvSqCqType_t type;
    uint32_t tsId;
    uint32_t sqId; // U32_MAX: pause or resume will config all sq in the process
    uint32_t cqId; // U32_MAX: pause or resume will config all cq in the process
    drvSqCqPropType_t prop;
    uint32_t value[SQCQ_CONFIG_INFO_LENGTH]; // 0: value; SQCQ_CONFIG_INFO_FLAG(7): flag
};

struct halSqCqQueryInfo {
    drvSqCqType_t type;
    uint32_t tsId;
    uint32_t sqId;
    uint32_t cqId;
    drvSqCqPropType_t prop;
    uint32_t value[SQCQ_QUERY_INFO_LENGTH];
};

enum res_addr_type {
    RES_ADDR_TYPE_STARS_NOTIFY_RECORD,
    RES_ADDR_TYPE_STARS_CNT_NOTIFY_RECORD,
    RES_ADDR_TYPE_STARS_RTSQ,
    RES_ADDR_TYPE_CCU_CKE,
    RES_ADDR_TYPE_CCU_XN,
    RES_ADDR_TYPE_STARS_CNT_NOTIFY_BIT_WR,
    RES_ADDR_TYPE_STARS_CNT_NOTIFY_BIT_ADD,
    RES_ADDR_TYPE_STARS_CNT_NOTIFY_BIT_CLR,
    RES_ADDR_TYPE_STARS_TOPIC_CQE,
    RES_ADDR_TYPE_HCCP_URMA_JETTY,
    RES_ADDR_TYPE_HCCP_URMA_JFC,
    RES_ADDR_TYPE_HCCP_URMA_DB,
    RES_ADDR_TYPE_MAX
};

#define RES_ADDR_INFO_RSV_LEN 2
struct res_addr_info {
    unsigned int id;                 /* the meaning of 'id' depends on res_type, default is 0 */
    processType_t target_proc_type;
    enum res_addr_type res_type;
    unsigned int res_id;             /* corresponding resource id if res_type is NOTIFY or CNT_NOTIFY */
    unsigned int flag;               /* default is 0, ascend910B and ascend910_93 with NOTIFY is TSDRV_FLAG_SHR_ID_SHADOW. */
    unsigned int rudevid;            /* remote unify devid, rudevid is valid when the flag is TSDRV_FLAG_SHR_ID_SHADOW */
    unsigned int rsv[RES_ADDR_INFO_RSV_LEN];  /* default is 0 */
};

struct halTaskSendInfo {
    drvSqCqType_t type;
    uint32_t tsId;
    uint32_t sqId;
    int32_t timeout;                 /* send wait time */
    uint8_t *sqe_addr;
    uint32_t sqe_num;
    uint32_t pos;                    /* output: first sqe pos */
    uint32_t res[SQCQ_RESV_LENGTH];  /* must zero out */
};

struct halReportRecvInfo {
    drvSqCqType_t type;
    uint32_t tsId;
    uint32_t cqId;
    int32_t timeout;         /* recv wait time */
    uint8_t *cqe_addr;
    uint32_t cqe_num;
    uint32_t report_cqe_num; /* output */
    uint32_t stream_id;
    uint32_t task_id;        /* if this parameter is set to all 1, strict matching is not performed for taskid. */
    uint32_t res[SQCQ_RESV_LENGTH];
};

typedef enum tagDrvIdType {
    DRV_STREAM_ID = 0,
    DRV_EVENT_ID,
    DRV_MODEL_ID,
    DRV_NOTIFY_ID,
    DRV_CMO_ID,
    DRV_CNT_NOTIFY_ID,    /* add start ascend950 */
    DRV_SQ_ID,
    DRV_CQ_ID,
    DRV_INVALID_ID,
} drvIdType_t;

#define RESOURCEID_RESV_LENGTH  8

struct halResourceIdInputInfo {
    drvIdType_t type;                       // resource Id Type
    uint32_t tsId;
    uint32_t resourceId;                    // the id that will be freed, halResourceIdAlloc does not care about this variable
    uint32_t res[RESOURCEID_RESV_LENGTH];   // 0:stream pri, 1:flag
};

struct halResourceIdOutputInfo {
    uint32_t resourceId;  /* applied resource id */
    uint32_t res[RESOURCEID_RESV_LENGTH];
};
#endif
