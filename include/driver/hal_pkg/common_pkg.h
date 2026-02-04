/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef COMMON_PKG_H
#define COMMON_PKG_H

/* If need to add module_id, Prioritize adding module_id reserved in the middle.
    The assigned module_id value cannot be changed to prevent compatibility issues */
enum {
    UNKNOWN_MODULE_ID = 0,       /* When module_id input invalid, Mem will be counted to this id */
    IDEDD_MODULE_ID = 1,         /* IDE daemon device */
    IDEDH_MODULE_ID = 2,         /* IDE daemon host */
    HCCL_HAL_MODULE_ID = 3,      /* HCCL */
    FMK_MODULE_ID = 4,           /* Adapter */
    HIAIENGINE_MODULE_ID = 5,    /* Matrix */
    DVPP_MODULE_ID = 6,          /* DVPP */
    RUNTIME_MODULE_ID = 7,       /* Runtime */
    CCE_MODULE_ID = 8,           /* CCE */
    HLT_MODULE_ID = 9,           /* Used for hlt test */
    DEVMM_MODULE_ID = 22,        /* Dlog memory managent */
    LIBMEDIA_MODULE_ID = 24,     /* Libmedia */
    CCECPU_MODULE_ID = 25,       /* aicpu shedule */
    ASCENDDK_MODULE_ID = 26,     /* AscendDK */
    HCCP_SCHE_MODULE_ID = 27,    /* Memory statistics of device hccp process */
    HCCP_HAL_MODULE_ID = 28,
    ROCE_MODULE_ID = 29,
    TEFUSION_MODULE_ID = 30,
    PROFILING_MODULE_ID = 31,    /* Profiling */
    DP_MODULE_ID = 32,           /* Data Preprocess */
    APP_MODULE_ID = 33,          /* User Application */
    TSDUMP_MODULE_ID = 35,       /* TSDUMP module */
    AICPU_MODULE_ID = 36,        /* AICPU module */
    AICPU_SCHE_MODULE_ID = 37,   /* Memory statistics of device aicpu process */
    TDT_MODULE_ID = 38,          /* tsdaemon or aicpu shedule */
    FE_MODULE_ID = 39,
    MD_MODULE_ID = 40,
    MB_MODULE_ID = 41,
    ME_MODULE_ID = 42,
    GE_MODULE_ID = 45,           /* Fmk */
    ASCENDCL_MODULE_ID = 48,
    PROCMGR_MODULE_ID = 54,      /* Process Manager, Base Platform */
    AIVECTOR_MODULE_ID = 56,
    TBE_MODULE_ID = 57,
    FV_MODULE_ID = 58,
    TUNE_MODULE_ID = 60,
    HSS_MODULE_ID = 61,          /* helper */
    FFTS_MODULE_ID = 62,
    OP_MODULE_ID = 63,
    UDF_MODULE_ID = 64,
    HICAID_MODULE_ID = 65,
    TSYNC_MODULE_ID = 66,
    AUDIO_MODULE_ID = 67,
    TPRT_MODULE_ID = 68,
    ASCENDCKERNEL_MODULE_ID = 69,
    ASYS_MODULE_ID = 70,
    ATRACE_MODULE_ID = 71,
    RTC_MODULE_ID = 72,
    SYSMONITOR_MODULE_ID = 73,
    AML_MODULE_ID = 74,
    MBUFF_MODULE_ID = 75,        /* Mbuff is a sharepool type memory statistic alloced by the device process,
                                 including aicpu_schedule and hccp_schedule, not a module that alloc memory. */
    CUSTOM_SCHE_MODULE_ID = 76,  /* Memory statistics of device custom process */
    MAX_MODULE_ID = 77           /* Add new module_id before MAX_MODULE_ID */
};

#define SVM_DECLARE_MODULE_NAME(name)                   \
        static const char *name[MAX_MODULE_ID] = {      \
            [UNKNOWN_MODULE_ID] = "UNKNOWN",            \
            [IDEDD_MODULE_ID] = "IDEDD",                \
            [IDEDH_MODULE_ID] = "IDEDH",                \
            [HCCL_HAL_MODULE_ID] = "HCCL",              \
            [FMK_MODULE_ID] = "FMK",                    \
            [HIAIENGINE_MODULE_ID] = "HIAIENGINE",      \
            [DVPP_MODULE_ID] = "DVPP",                  \
            [RUNTIME_MODULE_ID] = "RUNTIME",            \
            [CCE_MODULE_ID] = "CCE",                    \
            [HLT_MODULE_ID] = "HLT",                    \
            [DEVMM_MODULE_ID] = "DEVMM",                \
            [LIBMEDIA_MODULE_ID] = "LIBMEDIA",          \
            [CCECPU_MODULE_ID] = "CCECPU",              \
            [ASCENDDK_MODULE_ID] = "ASCENDDK",          \
            [HCCP_HAL_MODULE_ID] = "HCCP",              \
            [ROCE_MODULE_ID] = "ROCE",                  \
            [TEFUSION_MODULE_ID] = "TEFUSION",          \
            [PROFILING_MODULE_ID] = "PROFILING",        \
            [DP_MODULE_ID] = "DP",                      \
            [APP_MODULE_ID] = "APP",                    \
            [TSDUMP_MODULE_ID] = "TSDUMP",              \
            [AICPU_MODULE_ID] = "AICPU",                \
            [TDT_MODULE_ID] = "TDT",                    \
            [FE_MODULE_ID] = "FE",                      \
            [MD_MODULE_ID] = "MD",                      \
            [MB_MODULE_ID] = "MB",                      \
            [ME_MODULE_ID] = "ME",                      \
            [GE_MODULE_ID] = "GE",                      \
            [ASCENDCL_MODULE_ID] = "ASCENDCL",          \
            [AIVECTOR_MODULE_ID] = "AIVECTOR",          \
            [TBE_MODULE_ID] = "TBE",                    \
            [FV_MODULE_ID] = "FV",                      \
            [TUNE_MODULE_ID] = "TUNE",                  \
            [HSS_MODULE_ID] = "HSS",                    \
            [FFTS_MODULE_ID] = "FFTS",                  \
            [OP_MODULE_ID] = "OP",                      \
            [UDF_MODULE_ID] = "UDF",                    \
            [HICAID_MODULE_ID] = "HICAID",              \
            [TSYNC_MODULE_ID] = "TSYNC",                \
            [MBUFF_MODULE_ID] = "MBUFF",                \
            [AICPU_SCHE_MODULE_ID] = "AICPU_SCHEDULE",  \
            [CUSTOM_SCHE_MODULE_ID] = "CUSTOM_SCHEDULE",\
            [HCCP_SCHE_MODULE_ID] = "HCCP_SCHEDULE",    \
        }

#define SVM_GET_MODULE_NAME(name, module_id) ((name[module_id] == NULL) ? "Reserved" : name[module_id])

typedef enum tagProcStatus {
    STATUS_NOMEM = 0x1,                    /* Out of memory */
    STATUS_SVM_PAGE_FALUT_ERR_OCCUR = 0x2, /* page fault err occur in svm address range */
    STATUS_SVM_PAGE_FALUT_ERR_CNT = 0x3,   /* page fault err cnt in svm address range */
    STATUS_MAX
} processStatus_t;

typedef enum tagProcType {
    PROCESS_CP1 = 0,   /* aicpu_scheduler */
    PROCESS_CP2,       /* custom_process */
    PROCESS_DEV_ONLY,  /* TDT */
    PROCESS_QS,        /* queue_scheduler */
    PROCESS_HCCP,        /* hccp server */
    PROCESS_USER,        /* user proc, can bind many on host or device. not surport quert from host pid */
    PROCESS_CPTYPE_MAX
} processType_t;

typedef enum {
    MEM_ACCESS_TYPE_NONE = 0x0,
    MEM_ACCESS_TYPE_READ = 0x1,
    MEM_ACCESS_TYPE_READWRITE = 0x3,
    MEM_ACCESS_TYPE_MAX = 0x7FFFFFFF
} drv_mem_access_type;

typedef enum {
    MEM_HANDLE_TYPE_NONE = 0x0,
    MEM_HANDLE_TYPE_FABRIC = 0x1,
    MEM_HANDLE_TYPE_MAX = 0x2,
} drv_mem_handle_type;

struct ShareHandleAttr {
    unsigned int enableFlag;     /* wlist enable: 0 no wlist enable: 1 */
    unsigned int rsv[8];
};

struct ShareHandleGetInfo {
    unsigned int phyDevid;
    unsigned int reserve[8];
};

struct DMA_OFFSET_ADDR {
    unsigned long long offset;
    unsigned int devid;     /* Input param */
};

struct DMA_PHY_ADDR {
    void *src;           /**< src addr(physical addr) */
    void *dst;           /**< dst addr(physical addr) */
    unsigned int len;    /**< length */
    unsigned char flag;  /**< Flag=0 Non-chain, SRC and DST are physical addresses, can be directly DMA copy operations*/
                         /**< Flag=1 chain, SRC is the address of the dma list and can be used for direct dma copy operations*/
    void *priv;
};

struct DMA_ADDR {
    union {
        struct DMA_PHY_ADDR phyAddr;
        struct DMA_OFFSET_ADDR offsetAddr;
    };
    unsigned int fixed_size; /**< Output: the actual conversion size */
    unsigned int virt_id;    /**< store logic id for destroy addr */
};

#endif