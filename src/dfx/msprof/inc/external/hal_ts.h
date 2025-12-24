/**
?* Copyright (c) 2025 Huawei Technologies Co., Ltd.
?* This program is free software, you can redistribute it and/or modify it under the terms and conditions of
?* CANN Open Software License Agreement Version 2.0 (the "License").
?* Please refer to the License for details. You may not use this file except in compliance with the License.
?* THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
?* INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
?* See LICENSE in the root of the software repository for the full text of the License.
?*/

#ifndef HAL_TS_H
#define HAL_TS_H

#include <stdint.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @ingroup driver
 * @brief driver error numbers.
 */

typedef enum {
    MDL_NORMAL = 0,                /* 普通任务 */
    MDL_BLOCK_CALLBACK,            /* 阻塞性质callback任务 */
    MDL_NON_BLOCK_CALLBACK,        /* 非阻塞性质callback任务 */

    MDL_TYPE_MAX,
} MDL_EXEC_TYPE;


typedef enum {
    DESC_FILL = 0,                  /* 只填写描述符 */
    DESC_FILL_EXEC,                 /* 填写描述符后执行 */
    DESC_FILL_EXEC_SYNC,            /* 填写描述符后执行并同步等待 */

    EXEC_CTRL_TYPE_MAX,
} EXEC_CTRL_TYPE;

typedef enum {
    MODULE_TYPE_SYSTEM = 0,  /**< system info*/
    MODULE_TYPE_AICPU,       /**< aicpu info*/
    MODULE_TYPE_AICORE,      /**< AI CORE info*/

    MODULE_TYPE_MAX,
} DEV_MODULE_TYPE;

typedef enum {
    INFO_TYPE_ENV = 0,
    INFO_TYPE_VERSION,
    INFO_TYPE_HID,
    INFO_TYPE_QOS,

    INFO_TYPE_MAX,
} DEV_INFO_TYPE;

typedef struct _ts_mdl_exec_desc_info {
    uint16_t vld : 1;               /* 模型执行描述符是否有效，用于推理任务取消 */
    uint16_t cqe : 1;               /* 模型执行完成后是否需要入CQ队列 */
    uint16_t sv : 1;                /* overflow是否上报中断 */
    uint16_t task_prof : 1;         /* 是否使能profiling功能 */
    uint16_t blk_prof : 1;
    uint16_t mpamid : 11;
    uint8_t mid;                    /* 模型描述符 ID */
    uint8_t meid;                   /* 模型执行描述符 ID */

    uint32_t mec_credit : 5;
    uint32_t aic_rd_ost : 5;        /* 指定AIC读操作访问总线的Outstanding能力 */
    uint32_t aic_wr_ost : 5;        /* 指定AIC写操作访问总线的Outstanding能力 */
    uint32_t mec_soft : 1;
    uint32_t cache_inv : 1;
    uint32_t reserved : 15;

    uint32_t mec_start_time : 30;
    uint32_t qos_credit : 2;

    uint64_t workspace_baseaddr;
    uint64_t ioa_base_addr;
    uint64_t dynamic_task_baseaddr;
    uint64_t model_desc_addr;
} ts_mdl_exec_desc_info_t;

/* MOUDLE */
typedef struct ts_mdl_desc_info {
    uint8_t om_flag; // overflow dump flag
    uint8_t weight_prefetch_flag; // all weights of model can be prefetched or not
    uint16_t total_task_num;
    uint32_t sid; // used for SMMU
    uintptr_t taskdesc_base_addr; // this model's task description
    uintptr_t pc_base_addr; // this model's tbe kernel instruction
    uintptr_t param_base_addr; // this model's params info
    uintptr_t weight_base_addr; // this model's weights
} ts_mdl_desc_info_t;

typedef ts_mdl_desc_info_t tsMdlDescInfo_t;

typedef struct _ts_mdl_exec_info {
    ts_mdl_exec_desc_info_t desc_info;  /* 模型执行描述符相关信息 */
    int64_t tid;                        /* 用户下发的tid，用于索引等待及唤醒的事件 */
    uint32_t ioa_size;                  /* 输入输出地址个数，每个地址为8字节大小 */
    uint8_t sqid;                       /* 指定执行队列 */
    uint8_t me_type;                    /* 执行任务类型，见 MDL_EXEC_TYPE */
    uintptr_t cb_fn;                    /* callback任务的回调函数, 普通任务为空 */
    void *cb_data;                      /* callback任务的回调函数入参，普通任务为空 */
    uint64_t reserved;
} ts_mdl_exec_info_t;

typedef struct {
    uint32_t sqid;
    uint64_t meid;
    int64_t tid;
    uintptr_t rpt;                      /* 同步等待场景下指定执行队列在当前线程的上报队列地址 */
    uint32_t rpt_num;                   /* 同步等待场景下指示CQE接收个数 */
    uint32_t timeout;                   /* 同步等待场景下的等待时长，0表示死等，大于0表示最多等待时间，毫秒为单位 */
} ts_mdl_exec_wait_para_t;

typedef struct {
    ts_mdl_exec_info_t exec_info;
    ts_mdl_exec_wait_para_t wait_para;
    uint8_t ec_type;                    /* 模型执行控制类型, 见 exec_ctrl_type */
} ts_mdl_exec_para_t;

typedef struct _ts_rtsq_cfg {
    uint8_t ns_flag; // RTSQ安全属性
    uint8_t qos; // 执行队列优先级，数字越小，优先级越高
    uint8_t poolid; // 指定pool里的硬件资源和加速器资源
    uint8_t swapout_Flag; // 表示该RTSQ每执行完一个MEC，是否无条件从ACSQ中SwapOut出去
    uint16_t sid;
    uint16_t len; // RTSQ深度
} ts_rtsq_cfg_t;

typedef ts_rtsq_cfg_t tsRtsqCfg_t ;
struct halSqCqInputInfo {
    tsRtsqCfg_t cfg; // 执行队列优先级，数字越小，优先级越高
};

struct halSqCqOutputInfo {
    uint8_t sqid;
};

typedef struct QosInfo {
    uint8_t qosMin; // GE申请sqid时需要指定合法的qos值
    uint8_t qosMax;
} tsQosInfo_t;

typedef struct HidInfo {
    uint8_t hid; // GE需要知道该信息用于模型执行描述符的填充
} tsHidInfo_t;

typedef ts_mdl_exec_info_t tsMdlExecInfo_t;
typedef ts_mdl_exec_wait_para_t tsMdlExecWaitPara_t;

struct halMdlExecInput {
    tsMdlExecInfo_t execInfo;       /* 模型执行信息 */
    tsMdlExecWaitPara_t waitPara;   /* 模型执行等待参数, sqid与meid可缺省，由驱动自行填写 */
    uint8_t ec_type;                /* 模型执行控制类型，见 EXEC_CTRL_TYPE */
};

struct halMdlExecOutput {
    uint64_t meid;                  /* 模型执行任务id */
    uint32_t rpt_num;               /* 同步等待场景下真实CQE上报个数 */
};

typedef ts_mdl_exec_wait_para_t tsMdlExecWaitPara_t;

struct halMdlExecWaitInput {
    tsMdlExecWaitPara_t waitPara;
};

struct halMdlExecWaitOutput {
    uint32_t rpt_num;                   /* 实际上报个数 */
};

typedef struct _ts_cb_rpt {
    uint8_t devid;          /* 指示callback对应的设备 */
    uint8_t sqid;           /* 指示callback对应的RTSQ */
    uint8_t me_type;        /* 执行任务类型，见 MDL_EXEC_TYPE */
    uintptr_t fn;           /* callback任务回调函数 */
    void *cb_data;          /* callback任务回调函数入参 */
} ts_cb_report_t;

typedef ts_cb_report_t tsCbReport_t;

struct halCbIrqInput {
    int64_t tid;
    uint32_t timeout;         /* 等待时长，0表示死等，大于0表示最多等待时间，毫秒为单位 */
    tsCbReport_t *rpt;      /* 上报队列地址 */
    uint32_t rpt_max_num;   /* 最大上报个数 */
};

struct halCbIrqOutput {
    uint32_t rpt_num; // 实际上报个数
};

typedef struct {
    int64_t tid;
    uint32_t timeout;
    ts_cb_report_t *rpt;
    uint32_t rpt_max_num;
} ts_cb_wait_info_t;

#define HOST_FUNC_TASK  10

typedef enum {
    SUBSCRIBE_CALLBACK = 0,
    SUBSCRIBE_HOSTFUNC,
    SUBSCRIBE_TYPE_MAX,
} SUBSCRIBE_TYPE;

typedef struct _ts_host_func_rpt {
    uint32_t dev_id;            /* 指示HostFunc对应的dev id */
    uint8_t sqid;               /* 指示HostFunc对应的RTSQ   */
    uint16_t mid;               /* 指示HostFunc对应的模型id */
    uintptr_t kernel_args;      /* HostFunc相关参数 */
    uintptr_t weight_base;
    uintptr_t workspace_base;
    uintptr_t ioa_base;
} ts_hostfunc_report_t;

typedef ts_hostfunc_report_t tsHostFuncReport_t;
typedef struct halHostFuncInput {
    int64_t tid;
    uint32_t timeout;               /* 等待时长，0表示死等，大于0表示最多等待时间，毫秒为单位 */
    tsHostFuncReport_t *rpt;        /* 上报队列地址 */
    uint32_t rpt_max_num;           /* 最大上报个数 */
} halHostFuncInput_t;

typedef struct halHostFuncOutput {
    uint32_t rpt_num;               /* 实际上报个数 */
} halHostFuncOutput_t;

// Static Task Description Command
typedef struct {
    uint16_t type : 3; // HwtsTaskType
    uint16_t pre_p : 1;
    uint16_t pos_p : 1;
    uint16_t dump : 1;
    uint16_t cond_s : 1;
    uint16_t : 1;
    uint16_t uf : 1;
    uint16_t sw : 1;
    uint16_t : 1;
    uint16_t prefetch_num : 5;
    uint16_t soft_user : 6;
    uint16_t : 2;
    uint16_t kernel_credit : 8;
    uint32_t task_param_offset;
} HwtsTaskDesc;

#define SINGLE_PREFETCH_BUFF_SIZE 12
#define SINGLE_PARAM_BUFF_SIZE 8
#define DYNAMIC_DESC_BASE_SIZE 8

// Dynamic Task Description Command
typedef struct {
    uint32_t vld : 1;
    uint32_t code_size : 12;
    uint32_t dyn_task_desc_size : 16;
    uint32_t block_dim : 3;
    uint32_t task_pc_offset;
} HwtsDynamicTaskDesc;

// Param Buf Info Entry
typedef struct {
    uint32_t OpType : 2; // ParamOpType
    uint32_t : 5;
    uint32_t DataSize : 25;
    uint32_t DstOffset : 25;
    uint32_t : 0;
    uint32_t SrcOffset;
} ParamBufInfoDesc;

// Task Description Command
typedef struct {
    uint8_t W : 1; // HwtsTaskType
    uint8_t : 0;
    uint8_t RTSQID : 4;
    uint8_t : 0;
    uint8_t MEID;
    uint8_t MID;
    uint16_t TID;
    uint16_t SID;
} HwtsCqe;

#define PROF_USER_DATA_LEN 128
#define DFX_EVENT_MAX_NUM   10
typedef struct {
    uint32_t pmu_event[DFX_EVENT_MAX_NUM];
} pmu_config_in_t;

typedef struct _dump_mailbox_info {
    uint16_t sid;
    uint16_t rsp : 1;
    uint16_t sat : 1;
    uint16_t om : 1;
    uint16_t res1 : 3;
    uint16_t dump_task : 1;
    uint16_t soft_user : 6;
    uint16_t hid : 1;
    uint16_t pa : 1;
    uint16_t w : 1;
    uint16_t task_id;
    uint16_t mid : 8;
    uint16_t res2 : 8;
    uint16_t block_id;
    uint16_t block_dim;
    uint32_t task_pc_addr_l;
    uint32_t task_param_ptr_l;
    uint32_t ioa_base_addr_l;
    uint32_t weight_base_addr_l;
    uint32_t workspace_base_addr_l;
    uint8_t task_pc_addr_h;
    uint8_t task_param_ptr_h;
    uint8_t ioa_base_addr_h;
    uint8_t weight_base_addr_h;
    uint32_t workspace_base_addr_h : 8;
    uint32_t res3 : 24;
} dump_mailbox_info_t;

#define PROF_OK (0)
#define PROF_ERROR (-1)
#define PROF_TIMEOUT (-2)
#define PROF_STARTED_ALREADY (-3)
#define PROF_STOPPED_ALREADY (-4)
#define PROF_ERESTARTSYS (-5)
#define PROF_NOT_READABLE_DATA (-6)
#define PROF_NOT_SUPPORT (-7)
#define PROF_BUSY (-8)
#define PROF_NOT_ENOUGH_BUF (-9)
#define PROF_NOT_ENOUGH_SUB_CHANNEL_RESOURCE (-10)
#define PROF_VF_SUB_RESOURCE_FULL (-11)
#define PROF_CONTAINER_SCENE_NOT_OPEN_PHY (-12)
#define PROF_PHY_SCENE_NOT_OPEN_CONTAINER (-13)

#define CHANNEL_HBM 1
#define CHANNEL_BUS 2
#define CHANNEL_PCIE 3
#define CHANNEL_NIC 4
#define CHANNEL_DMA 5
#define CHANNEL_DVPP 6
#define CHANNEL_DDR 7
#define CHANNEL_LLC 8
#define CHANNEL_HCCS 9
#define CHANNEL_TSCPU 10

#define CHANNEL_BIU_GROUP0_AIC 11
#define CHANNEL_BIU_GROUP0_AIV0 12
#define CHANNEL_BIU_GROUP0_AIV1 13
#define CHANNEL_BIU_GROUP1_AIC 14
#define CHANNEL_BIU_GROUP1_AIV0 15
#define CHANNEL_BIU_GROUP1_AIV1 16
#define CHANNEL_BIU_GROUP2_AIC 17
#define CHANNEL_BIU_GROUP2_AIV0 18
#define CHANNEL_BIU_GROUP2_AIV1 19
#define CHANNEL_BIU_GROUP3_AIC 20
#define CHANNEL_BIU_GROUP3_AIV0 21
#define CHANNEL_BIU_GROUP3_AIV1 22
#define CHANNEL_BIU_GROUP4_AIC 23
#define CHANNEL_BIU_GROUP4_AIV0 24
#define CHANNEL_BIU_GROUP4_AIV1 25
#define CHANNEL_BIU_GROUP5_AIC 26
#define CHANNEL_BIU_GROUP5_AIV0 27
#define CHANNEL_BIU_GROUP5_AIV1 28
#define CHANNEL_BIU_GROUP6_AIC 29
#define CHANNEL_BIU_GROUP6_AIV0 30
#define CHANNEL_BIU_GROUP6_AIV1 31
#define CHANNEL_BIU_GROUP7_AIC 32
#define CHANNEL_BIU_GROUP7_AIV0 33
#define CHANNEL_BIU_GROUP7_AIV1 34
#define CHANNEL_BIU_GROUP8_AIC 35
#define CHANNEL_BIU_GROUP8_AIV0 36
#define CHANNEL_BIU_GROUP8_AIV1 37
#define CHANNEL_BIU_GROUP9_AIC 38
#define CHANNEL_BIU_GROUP9_AIV0 39
#define CHANNEL_BIU_GROUP9_AIV1 40
#define CHANNEL_BIU_GROUP10_AIC 41
#define CHANNEL_BIU_GROUP10_AIV0 42

#define CHANNEL_AICORE 43
#define CHANNEL_TSFW 44      // add for ts0 as tsfw channel
#define CHANNEL_HWTS_LOG 45  // add for ts0 as hwts channel
#define CHANNEL_KEY_POINT 46
#define CHANNEL_TSFW_L2 47   /* add for ascend910 and ascend610 */
#define CHANNEL_HWTS_LOG1 48 // add for ts1 as hwts channel
#define CHANNEL_TSFW1 49     // add for ts1 as tsfw channel
#define CHANNEL_STARS_SOC_LOG_BUFFER 50       /* add for ascend910B */
#define CHANNEL_STARS_BLOCK_LOG_BUFFER 51     /* add for ascend910B */
#define CHANNEL_STARS_SOC_PROFILE_BUFFER 52   /* add for ascend910B */
#define CHANNEL_FFTS_PROFILE_BUFFER_TASK 53   /* add for ascend910B */
#define CHANNEL_FFTS_PROFILE_BUFFER_SAMPLE 54 /* add for ascend910B */

#define CHANNEL_BIU_GROUP10_AIV1 55
#define CHANNEL_BIU_GROUP11_AIC 56
#define CHANNEL_BIU_GROUP11_AIV0 57
#define CHANNEL_BIU_GROUP11_AIV1 58
#define CHANNEL_BIU_GROUP12_AIC 59
#define CHANNEL_BIU_GROUP12_AIV0 60
#define CHANNEL_BIU_GROUP12_AIV1 61
#define CHANNEL_BIU_GROUP13_AIC 62
#define CHANNEL_BIU_GROUP13_AIV0 63
#define CHANNEL_BIU_GROUP13_AIV1 64
#define CHANNEL_BIU_GROUP14_AIC 65
#define CHANNEL_BIU_GROUP14_AIV0 66
#define CHANNEL_BIU_GROUP14_AIV1 67
#define CHANNEL_BIU_GROUP15_AIC 68
#define CHANNEL_BIU_GROUP15_AIV0 69
#define CHANNEL_BIU_GROUP15_AIV1 70
#define CHANNEL_BIU_GROUP16_AIC 71
#define CHANNEL_BIU_GROUP16_AIV0 72
#define CHANNEL_BIU_GROUP16_AIV1 73
#define CHANNEL_BIU_GROUP17_AIC 74
#define CHANNEL_BIU_GROUP17_AIV0 75
#define CHANNEL_BIU_GROUP17_AIV1 76
#define CHANNEL_BIU_GROUP18_AIC 77
#define CHANNEL_BIU_GROUP18_AIV0 78
#define CHANNEL_BIU_GROUP18_AIV1 79
#define CHANNEL_BIU_GROUP19_AIC 80
#define CHANNEL_BIU_GROUP19_AIV0 81
#define CHANNEL_BIU_GROUP19_AIV1 82
#define CHANNEL_BIU_GROUP20_AIC 83
#define CHANNEL_BIU_GROUP20_AIV0 84

#define CHANNEL_AIV 85

#define CHANNEL_BIU_GROUP20_AIV1 86
#define CHANNEL_BIU_GROUP21_AIC 87
#define CHANNEL_BIU_GROUP21_AIV0 88
#define CHANNEL_BIU_GROUP21_AIV1 89
#define CHANNEL_BIU_GROUP22_AIC 90
#define CHANNEL_BIU_GROUP22_AIV0 91
#define CHANNEL_BIU_GROUP22_AIV1 92
#define CHANNEL_BIU_GROUP23_AIC 93
#define CHANNEL_BIU_GROUP23_AIV0 94
#define CHANNEL_BIU_GROUP23_AIV1 95
#define CHANNEL_BIU_GROUP24_AIC 96
#define CHANNEL_BIU_GROUP24_AIV0 97
#define CHANNEL_BIU_GROUP24_AIV1 98

#define CHANNEL_TSCPU_MAX 128
#define CHANNEL_ROCE 129
#define CHANNEL_DVPP_VENC 135  /* add for ascend610 */
#define CHANNEL_DVPP_JPEGE 136 /* add for ascend610 */
#define CHANNEL_DVPP_VDEC 137  /* add for ascend610 */
#define CHANNEL_DVPP_JPEGD 138 /* add for ascend610 */
#define CHANNEL_DVPP_VPC 139   /* add for ascend610 */
#define CHANNEL_DVPP_PNG 140   /* add for ascend610 */
#define CHANNEL_DVPP_SCD 141   /* add for ascend610 */
#define PROF_CHANNEL_NUM   160
#define CHANNEL_IDS_MAX PROF_CHANNEL_NUM
#define MAX_DEVICE_NUM  1

/* add for get prof channel list */
#define PROF_CHANNEL_NAME_LEN 32
#define PROF_CHANNEL_NUM_MAX 160

struct channel_info {
    char channel_name[PROF_CHANNEL_NAME_LEN];
    unsigned int channel_type; /* system / APP */
    unsigned int channel_id;
};

typedef struct channel_list {
    unsigned int chip_type;
    unsigned int channel_num;
    struct channel_info channel[PROF_CHANNEL_NUM_MAX];
} channel_list_t;

typedef enum prof_channel_type {
    PROF_TS_TYPE,
    PROF_PERIPHERAL_TYPE,
    PROF_CHANNEL_TYPE_MAX,
} PROF_CHANNEL_TYPE;

enum prof_cmd_type {
    PROF_START = 0,
    PROF_STOP,
    PROF_READ,
    PROF_POLL,
    PROF_GET_CHANNEL_LIST,
    PROF_CMD_MAX
};

typedef enum {
    TS_PROFILE_ACK_TYPE_OK = 0,
    TS_PROFILE_ACK_TYPE_INVALID_CMDTYPE = 1,
    TS_PROFILE_ACK_TYPE_INVALID_CHANNEL = 2,
    TS_PROFILE_ACK_TYPE_INVALID_BUFFER = 3,
    TS_PROFILE_ACK_TYPE_PARAMETERS_ERR = 4,
    TS_PROFILE_ACK_TYPE_NOT_SUPPORT_VM = 5,
    TS_PROFILE_ACK_TYPE_VMID_NOTSAME = 6,
    TS_PROFILE_ACK_TYPE_INVALID_SUB_CHANNEL = 7,
    TS_PROFILE_ACK_TYPE_INVALID_ACTION = 8,
} ts_profile_ack_type_t;

typedef struct tag_ts_ffts_profile_config {
    uint32_t type;              // bit0-task base, bit1-sample base, bit2 blk task, bit3 sub task
    uint32_t period;            // sample base
    uint32_t core_mask;         // sample base
    uint32_t event_num;         // public
    uint16_t event[DFX_EVENT_MAX_NUM];    // public
} ts_ffts_profile_config_t;

typedef struct tag_ts_stars_ffts_profile_config {
    uint32_t cfg_mode;                 // 0-none,1-aic,2-aiv,3-aic&aiv
    ts_ffts_profile_config_t aic_cfg;
    ts_ffts_profile_config_t aiv_cfg;
} ts_stars_ffts_profile_config_t;

typedef struct ts_pmu_data {
    uint32_t prof_type : 1;         /* 0: task, 1: block */
    uint32_t task_type : 3;         /* 0: AIC, 1: AICPU, 2:PlaceHolder */
    uint32_t ov : 1;                /* 1: PMU overflow */
    uint32_t hid : 1;
    uint32_t res0 : 2;
    uint32_t mid : 8;
    uint32_t meid : 8;
    uint32_t rtsq_id : 8;

    uint32_t core_id : 1;
    uint32_t res1 : 3;
    uint32_t core_type : 1;
    uint32_t res3 : 3;
    uint32_t blk_id : 3;
    uint32_t blk_dim : 3;
    uint32_t res4 : 2;
    uint32_t task_id : 16;

    uint32_t start_time_l;
    uint32_t duration;
    uint32_t total_cycle_l;

    uint32_t start_time_h : 24;
    uint32_t total_cycle_h : 8;

    uint32_t pmu_cnt_0;
    uint32_t pmu_cnt_1;
    uint32_t pmu_cnt_2;
    uint32_t pmu_cnt_3;
    uint32_t pmu_cnt_4;
    uint32_t pmu_cnt_5;
    uint32_t pmu_cnt_6;
    uint32_t pmu_cnt_7;
    uint32_t pmu_cnt_8;
    uint32_t pmu_cnt_9;
} ts_pmu_data_t;

typedef enum tagDrvError {
    DRV_ERROR_NONE = 0,                /**< success */
    DRV_ERROR_NO_DEVICE = 1,           /**< no valid device */
    DRV_ERROR_INVALID_DEVICE = 2,      /**< invalid device */
    DRV_ERROR_INVALID_VALUE = 3,       /**< invalid value */
    DRV_ERROR_INVALID_HANDLE = 4,      /**< invalid handle */
    DRV_ERROR_INVALID_MALLOC_TYPE = 5, /**< invalid malloc type */
    DRV_ERROR_OUT_OF_MEMORY = 6,       /**< out of memory */
    DRV_ERROR_INNER_ERR = 7,           /**< driver inside error */
    DRV_ERROR_PARA_ERROR = 8,          /**< driver wrong parameter */
    DRV_ERROR_UNINIT = 9,              /**< driver uninit */
    DRV_ERROR_REPEATED_INIT = 10,          /**< driver repeated init */
    DRV_ERROR_NOT_EXIST = 11,        /**< there is resource*/
    DRV_ERROR_REPEATED_USERD = 12,
    DRV_ERROR_BUSY = 13,                /**< task already running */
    DRV_ERROR_NO_RESOURCES = 14,        /**< driver short of resouces */
    DRV_ERROR_OUT_OF_CMD_SLOT = 15,
    DRV_ERROR_WAIT_TIMEOUT = 16,       /**< driver wait timeout*/
    DRV_ERROR_IOCRL_FAIL = 17,         /**< driver ioctl fail*/

    DRV_ERROR_SOCKET_CREATE = 18,      /**< driver create socket error*/
    DRV_ERROR_SOCKET_CONNECT = 19,     /**< driver connect socket error*/
    DRV_ERROR_SOCKET_BIND = 20,        /**< driver bind socket error*/
    DRV_ERROR_SOCKET_LISTEN = 21,      /**< driver listen socket error*/
    DRV_ERROR_SOCKET_ACCEPT = 22,      /**< driver accept socket error*/
    DRV_ERROR_CLIENT_BUSY = 23,        /**< driver client busy error*/
    DRV_ERROR_SOCKET_SET = 24,         /**< driver socket set error*/
    DRV_ERROR_SOCKET_CLOSE = 25,       /**< driver socket close error*/
    DRV_ERROR_RECV_MESG = 26,          /**< driver recv message error*/
    DRV_ERROR_SEND_MESG = 27,          /**< driver send message error*/
    DRV_ERROR_SERVER_BUSY = 28,
    DRV_ERROR_CONFIG_READ_FAIL = 29,
    DRV_ERROR_STATUS_FAIL = 30,
    DRV_ERROR_SERVER_CREATE_FAIL = 31,
    DRV_ERROR_WAIT_INTERRUPT = 32,
    DRV_ERROR_BUS_DOWN = 33,
    DRV_ERROR_DEVICE_NOT_READY = 34,
    DRV_ERROR_REMOTE_NOT_LISTEN = 35,
    DRV_ERROR_NON_BLOCK = 36,

    DRV_ERROR_OVER_LIMIT = 37,
    DRV_ERROR_FILE_OPS = 38,
    DRV_ERROR_MBIND_FAIL = 39,
    DRV_ERROR_MALLOC_FAIL = 40,

    DRV_ERROR_REPEATED_SUBSCRIBED = 41,
    DRV_ERROR_PROCESS_EXIT = 42,
    DRV_ERROR_DEV_PROCESS_HANG = 43,

    DRV_ERROR_REMOTE_NO_SESSION = 44,

    DRV_ERROR_HOT_RESET_IN_PROGRESS = 45,

    DRV_ERROR_OPER_NOT_PERMITTED = 46,

    DRV_ERROR_NO_EVENT_RESOURCES = 47,
    DRV_ERROR_NO_STREAM_RESOURCES = 48,
    DRV_ERROR_NO_NOTIFY_RESOURCES = 49,
    DRV_ERROR_NO_MODEL_RESOURCES = 50,
    DRV_ERROR_TRY_AGAIN = 51,

    DRV_ERROR_DST_PATH_ILLEGAL = 52,                    /**< send file dst path illegal*/
    DRV_ERROR_OPEN_FAILED = 53,                         /**< send file open failed */
    DRV_ERROR_NO_FREE_SPACE = 54,                       /**< send file no free space */
    DRV_ERROR_LOCAL_ABNORMAL_FILE = 55,                 /**< send file local file abnormal*/
    DRV_ERROR_DST_PERMISSION_DENIED = 56,               /**< send file dst Permission denied*/
    DRV_ERROR_DST_NO_SUCH_FILE = 57,                    /**< pull file no such file or directory*/

    DRV_ERROR_MEMORY_OPT_FAIL = 58,
    DRV_ERROR_RUNTIME_ON_OTHER_PLAT = 59,
    DRV_ERROR_SQID_FULL = 60,                           /**< driver SQ   is full */

    DRV_ERROR_SERVER_HAS_BEEN_CREATED = 61,
    DRV_ERROR_NO_PROCESS = 62,
    DRV_ERROR_NO_SUBSCRIBE_THREAD = 63,
    DRV_ERROR_NON_SCHED_GRP_MUL_THREAD = 64,
    DRV_ERROR_NO_GROUP = 65,
    DRV_ERROR_GROUP_EXIST = 66,
    DRV_ERROR_THREAD_EXCEEDS_SPEC = 67,
    DRV_ERROR_THREAD_NOT_RUNNIG = 68,
    DRV_ERROR_PROCESS_NOT_MATCH = 69,
    DRV_ERROR_EVENT_NOT_MATCH = 70,
    DRV_ERROR_PROCESS_REPEAT_ADD = 71,
    DRV_ERROR_GROUP_NON_SCHED = 72,
    DRV_ERROR_NO_EVENT = 73,
    DRV_ERROR_COPY_USER_FAIL = 74,
    DRV_ERROR_QUEUE_EMPTY = 75,
    DRV_ERROR_QUEUE_FULL = 76,
    DRV_ERROR_RUN_IN_ILLEGAL_CPU = 77,
    DRV_ERROR_SUBSCRIBE_THREAD_TIMEOUT = 78,
    DRV_ERROR_BAD_ADDRESS = 79,
    DRV_ERROR_DST_FILE_IS_BEING_WRITTEN = 80,           /**< send file The dts file is being written */
    DRV_ERROR_EPOLL_CLOSE = 81,                         /**< epoll close */
    DRV_ERROR_CDQ_ABNORMAL = 82,
    DRV_ERROR_CDQ_NOT_EXIST = 83,
    DRV_ERROR_NO_CDQ_RESOURCES = 84,
    DRV_ERROR_CDQ_QUIT = 85,
    DRV_ERROR_PARTITION_NOT_RIGHT = 86,
    DRV_ERROR_RESOURCE_OCCUPIED = 87,
    DRV_ERROR_PERMISSION = 88,

    DRV_ERROR_NOT_SUPPORT = 0xfffe,
    DRV_ERROR_RESERVED,
} drvError_t;

typedef enum tagDrvMemcpyKind {
    DRV_MEMCPY_HOST_TO_HOST,     /**< host to host */
    DRV_MEMCPY_HOST_TO_DEVICE,   /**< host to device */
    DRV_MEMCPY_DEVICE_TO_HOST,   /**< device to host */
    DRV_MEMCPY_DEVICE_TO_DEVICE, /**< device to device */
} drvMemcpyKind_t;

typedef unsigned long long UINT64;
typedef unsigned int UINT32;
typedef unsigned short UINT16;
typedef unsigned char UINT8;

typedef UINT32 DVmem_advise;
typedef UINT32 DVdevice;
typedef UINT64 DVdeviceptr;
typedef drvError_t DVresult;

#define DV_MEM_LOCK_HOST 0x0008
#define DV_MEM_LOCK_DEV 0x0010
#define DV_MEM_LOCK_DEV_DVPP 0x0020

#define DV_MEM_RESV 8

struct DVattribute {
    /**< DV_MEM_SVM_DEVICE : svm memory & mapped device */
    /**< DV_MEM_SVM_HOST : svm memory & mapped host */
    /**< DV_MEM_SVM : svm memory & no mapped */
    /**< DV_MEM_LOCK_HOST :    host mapped memory & lock host */
    /**< DV_MEM_LOCK_DEV : dev mapped memory & lock dev */
    /**< DV_MEM_LOCK_DEV_DVPP : dev_dvpp mapped memory & lock dev */
    UINT32 memType;
    UINT32 resv1;
    UINT32 resv2;

    UINT32 devId;
    UINT32 pageSize;
    UINT32 resv[DV_MEM_RESV];
};

struct MemPhyInfo {
#ifndef __linux
    unsigned long long total;
    unsigned long long free;
    unsigned long long huge_total;
    unsigned long long huge_free;
#else
    unsigned long total;        /* normal page total size */
    unsigned long free;         /* normal page free size */
    unsigned long huge_total;   /* huge page total size */
    unsigned long huge_free;    /* huge page free size */
#endif
};

struct MemAddrInfo {
    DVdeviceptr** addr;
    unsigned int cnt;
    unsigned int mem_type;
    unsigned int flag;
};

struct MemInfo {
    union {
        struct MemPhyInfo phy_info;
        struct MemAddrInfo addr_info;
    };
};

struct DMA_OFFSET_ADDR {
    unsigned long long offset;
    unsigned int devid;
};

struct DMA_PHY_ADDR {
    void *src;          /**< src addr(physical addr) */
    void *dst;          /**< dst addr(physical addr) */
    unsigned int len;   /**< length */
    unsigned char flag; /**< Flag=0 Non-chain, SRC and DST are physical addresses, can be directly DMA copy operations*/
                        /**< Flag=1 chain, SRC is the address of the dma list and can be used for direct
                           dma copy operations */
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


struct drvMem2D {
    unsigned long long *dst;        /**< destination memory address */
    unsigned long long dpitch;      /**< pitch of destination memory */
    unsigned long long *src;        /**< source memory address */
    unsigned long long spitch;      /**< pitch of source memory */
    unsigned long long width;       /**< width of matrix transfer */
    unsigned long long height;      /**< height of matrix transfer */
    unsigned long long fixed_size;  /**< Input: already converted size. if fixed_size < width*height,
                                         need to call drvMemcpy2D multi times */
    unsigned int direction;         /**< copy direction */
    unsigned int resv1;
    unsigned long long resv2;
};

struct drvMem2DAsync {
    struct drvMem2D copy2dInfo;
    struct DMA_ADDR *dmaAddr;
};

struct MEMCPY2D {
    unsigned int type;      /**< DEVMM_MEMCPY2D_SYNC: memcpy2d sync */
                            /**< DEVMM_MEMCPY2D_ASYNC_CONVERT: memcpy2d async convert */
                            /**< DEVMM_MEMCPY2D_ASYNC_DESTROY: memcpy2d async destroy */
    unsigned int resv;
    union {
        struct drvMem2D copy2d;
        struct drvMem2DAsync copy2dAsync;
    };
};

/* this struct = the one in "prof_drv_dev.h" */
typedef struct prof_poll_info {
    unsigned int device_id;
    unsigned int channel_id;
} prof_poll_info_t;


typedef struct prof_start_para {
    PROF_CHANNEL_TYPE channel_type;     /* for ts and other device */
    unsigned int sample_period;
    unsigned int real_time;             /* real mode */
    void *user_data;                    /* ts data's pointer */
    unsigned int user_data_size;        /* user data's size */
} prof_start_para_t;

typedef enum {
    NULLMODEL = 0,
    CALLBACK,
    MODEL_TYPE_MAX,
} CTRL_MODEL_TYPE;

typedef struct {
    CTRL_MODEL_TYPE type;
    void* static_task_desc;
    size_t static_task_desc_size;
    void* dynamic_task_desc;
    size_t dynamic_task_desc_size;
} ts_mdl_ctrl_info_t;

typedef ts_mdl_ctrl_info_t tsMdlCtrlInfo_t;
struct halGetTaskDescInput {
    tsMdlCtrlInfo_t mdl_ctrl_info;
};

struct halGetTaskDescOutput {
    uint16_t task_num;                   /* task个数 */
    size_t static_task_desc_valid_size;  /* 实际size */
    size_t dynamic_task_desc_valid_size; /* 实际size */
};

/* 功能说明: 填写指定类型的控制类模型的静态及动态task描述符
 * 参数:  1) in: 入参，包括控制模型类型，描述符地址等信息
 *        2) out: 出参，task的数量
 * 返回值: == 0, succ; other, fail，如执行异常、timeout等
*/
extern drvError_t halGetTaskDesc(struct halGetTaskDescInput *in, struct halGetTaskDescOutput *out);

/**
* @ingroup driver
* @brief Open the memory management module interface and initialize related information
* @attention null
* @param [in] devid  Device id
* @param [in] devfd  Device file handle
* @return DRV_ERROR_NONE : success
* @return DV_ERROR_XXX : open fail
*/
extern int drvMemDeviceOpen(uint32_t devid, int devfd);
/**
* @ingroup driver
* @brief Close the memory management module interface
* @attention Used with drvMemDeviceOpen.
* @param [in] devid  Device id
* @return DRV_ERROR_NONE  success
* @return DV_ERROR_XXX  close fail
*/
extern int drvMemDeviceClose(uint32_t devid);

/**
* @ingroup driver
* @brief Open the memory management module interface and initialize related information
* @attention null
* @param [in] devid  Device id
* @param [in] devfd  Device file handle
* @return DRV_ERROR_NONE : success
* @return DV_ERROR_XXX : open fail
*/
extern int tsMemDevOpen(void);

/**
* @ingroup driver
* @brief Close the memory management module interface
* @attention Used with drvMemDeviceOpen.
* @param [in] devid  Device id
* @return DRV_ERROR_NONE  success
* @return DV_ERROR_XXX  close fail
*/
extern void tsMemDevClose(void);

drvError_t halMemset(DVdeviceptr dst, size_t destMax, UINT8 value, size_t num);
drvError_t halMemcpy(DVdeviceptr dst, size_t destMax, DVdeviceptr src, size_t ByteCount, drvMemcpyKind_t kind);
drvError_t halMemGetInfo(unsigned int type, struct MemInfo *info);
/* 功能说明: 从系统内存池中分配满足用户请求size的内存块并返回内存块首地址给调用者
 * 参数:  1) pp: 出参，返回给用户的内存块首地址存储其中
 *        2) size: 入参，用户请求内存块大小
 *        3) flag: 入参，reserved, 当前不需要，未来可扩展:如size对齐、内存属性等
 * 返回值: == 0, succ; other, fail
*/
extern drvError_t halMemAlloc(void **pp, unsigned long long size, unsigned long long flag);

/* 功能说明: 内存释放
 * 参数:  1) p: 入参，待释放内存指针
 * 返回值: == 0, succ; other, fail
*/
extern drvError_t halMemFree(void *p);

/* 功能说明: 从系统内存池中分配满足用户请求size的内存块并返回内存块首地址给调用者, 协议栈自用内存，不可供NPU共享使用
 * 参数:  1) pp: 出参，返回给用户的内存块首地址存储其中
 *        2) size: 入参，用户请求内存块大小
 *        3) flag: 入参，reserved, 当前不需要，未来可扩展:如size对齐、内存属性等
 * 返回值: == 0, succ; other, fail
 */
extern drvError_t halHostMemAlloc(void **pp, unsigned long long size, unsigned long long flag);

/* 功能说明: 协议栈自用内存释放
 * 参数:  1) p: 入参，待释放内存指针
 * 返回值: == 0, succ; other, fail
 */
extern drvError_t halHostMemFree(void *p);

/* 功能说明: NPU驱动全局公共资源初始化，仅能调用一次包括:
 *          1) 规格类配置：如sq队列数、支持的模型执行描述符数目、模型描述符数目等
            2) 公共资源池初始化:ModelExecDesc、ModelDesc初始化
            3) NPU硬件上电流程配置:包括power、clock等
            4) NPU内部静态配置类寄存器赋值
 * 参数: none
 * 返回值: 0, succ; < 0, fail
*/
extern int halTsInit(void);

/* 功能说明: 关闭TS驱动依赖的设备节点:
 * 参数: none
 * 返回值: 0, succ; < 0, fail
*/
extern int32_t halTsDeinit(void);

/* 功能说明: 分配modelID并填充对应的模型描述符
 * 参数:  1) devId: 入参，兼容当前API(用于指定指定NPU硬件设备)，忽略可直接填0
 *        2) mdlDescInfo: 入参，需要用户提供的模型描述符中各字段信息结构体
 *        3) mdlID: 出参，指向存储返回的模型ID的内存指针
 * 返回值: == 0, succ; other, fail
*/
extern drvError_t halModelLoad(tsMdlDescInfo_t *mdlDescInfo, uint8_t *mdlID);

/* 功能说明: 删除模型资源，无效对应模型执行描述符
 * 参数: 1) devId: 入参，设备id
 *       2) mid: 入参，模型id
 * 返回值: == 0, succ; other, fail
*/
extern drvError_t halModelDestroy(uint32_t mid);

/* 功能说明:  按用户指定的qos分配执行队列sq,
 *            命名中有cq,是为了接口与非Nano场景保持一致
 * 参数: 1) devId: 入参，兼容当前API(用于指定指定NPU硬件设备)，忽略可直接填0
 *       2) in:  入参，包括用户指定的队列优先级qos
 *       3) out: 出参, 包括sqid
 * 返回值: 0, succ; other, fail
*/
extern drvError_t halSqCqAllocate(uint32_t devId, struct halSqCqInputInfo *in, struct halSqCqOutputInfo *out);

 /* 功能说明:  释放执行队列sq,
 *            命名中有cq,是为了接口与非Nano场景保持一致
 * 参数: 1) devId: 入参，兼容当前API(用于指定指定NPU硬件设备)，忽略可直接填0
 *       2) sqid:  入参，待释放的模型执行队列ID
 * 返回值: 0, succ; other, fail
*/
extern drvError_t halSqCqFree(uint32_t devId, uint32_t sqid);

/* 功能说明: 填写模型执行描述符
 * 参数:  1) devId: 入参，兼容当前API(用于指定指定NPU硬件设备)，忽略可直接填0
 *        2) mdlExecInfo: 入参，需要用户提供的模型执行描述符中各字段信息结构体
 *        3) exec_flag: 入参，当前描述符填写完是否触发执行
 *        4) meid: 出参，指向存储返回的模型执行ID的内存指针
 * 返回值: == 0, succ; other, fail
*/
extern drvError_t halModelExecDescFill(uint32_t devId, tsMdlExecInfo_t *mdlExecInfo, uint32_t exec_flag, uint8_t *meid);

/* 功能说明: 更新模型执行队列尾指针，触发TS硬件启动工作
 * 参数: 1) devId: 入参，兼容当前API(用于指定指定NPU硬件设备)，忽略可直接填0
 *       2) sqId  入参，待启动执行的模型执行队列ID
 * 返回值: 0, succ; other, fail
*/
extern drvError_t halModelExecStart(uint32_t devId, uint8_t sqId);

/* 功能说明: 等待推理模型执行完成
 * 参数:  1) devId: 入参，指定设备
 *        2) in: 入参，等待执行参数
 *        3) out: 出参，CQE上报个数
 * 返回值: == 0, succ; other, fail，如执行异常、timeout等
*/
extern drvError_t halModelExecWait(uint8_t devId, struct halMdlExecWaitInput *in, struct halMdlExecWaitOutput *out);

/* 功能说明: 下发模型执行任务
 * 参数:  1) devId: 入参，指定设备
 *        2) in: 入参，模型执行所需信息
 *        3) out: 出参，待查询的模型执行ID
 * 返回值: == 0, succ; other, fail，如执行异常、timeout等
*/
extern drvError_t halModelExec(uint8_t devId, struct halMdlExecInput *in, struct halMdlExecOutput *out);

/* 功能说明: 取消已入执行队列的模型执行，删除模型执行有效性，保留模型描述符信息
 * 参数:  1) devId: 入参，指定设备
 *        2) sqId: 入参，指定执行队列
 *        3) meid: 入参，待取消的模型执行ID
 * 返回值: == 0, succ; other, fail
*/
extern drvError_t halModelExecCancel(uint8_t devId, uint8_t sqId, uint64_t meid);

/* 功能说明: 查询推理模型执行是否已完成...........
 * 参数:  1) devId: 入参，指定设备
 *        2) sqId: 入参，指定执行队列
 *        3) meid: 入参，待查询的模型执行ID
 * 返回值: == 0, succ; other, fail，如执行异常、timeout等
*/
extern drvError_t halModelExecPoll(uint8_t devId, uint8_t sqId, uint8_t meid);

/* 功能说明: 指定执行队列Callback/hostfunc任务的处理线程
 * 参数: 1) devId: 入参，指定设备
 *       2) sqId: 入参，指定执行队列
 *       3) type: 入参，指定注册类型
 *       4) tid： 入参，目标线程的tid值
 * 返回值: 0, succ; other, fail
*/
extern drvError_t halSqSubscribeTid(uint8_t devId, uint8_t sqId, uint8_t type, int64_t tid);

/* 功能说明: 取消对应rtsq的callback/hostfunc线程订阅
 * 参数: 1) devId: 入参，指定设备
 *       2) sqId: 入参，指定执行队列
 *       3) type: 入参，指定注册类型
 * 返回值: 0, succ; other, fail
*/
extern drvError_t halSqUnSubscribeTid(uint8_t devId, uint8_t sqId, uint8_t type);

/* 功能说明: 等待处理回调中断
 * 参数:  1) in: 入参，callback流程线程id，上报缓存及超时等信息
 *        2) out： 出参, 实际上报callback个数
 * 返回值: == 0, succ; other, fail，如执行异常、timeout等
*/
extern drvError_t halCbIrqWait(struct halCbIrqInput *in, struct halCbIrqOutput *out);

/* 功能说明: 等待处理回调中断
 * 参数:  1) timeout: 等待时长，0表示死等，大于0表示最多等待时间，毫秒为单位
 *        2) tid: 入参，目标线程的tid值
 * 返回值: == 0, succ; other, fail，如执行异常、timeout等
*/
extern drvError_t halHostFuncWait(int32_t timeout, int64_t tid);

/* 功能说明: 恢复RTSQ的任务调度
 * 参数:  1) devId: 入参，指定设备
 *        2) sqId: 入参，指定RTSQ
 * 返回值: == 0, succ; other, fail，如执行异常、timeout等
*/
extern drvError_t halSqResume(uint8_t devId, int32_t sqid);

extern drvError_t halDumpInit(void);

extern drvError_t halDumpDeinit(void);

extern drvError_t halEschedWaitEvent(uint32_t tId, void *outInfo, uint32_t *infotype, uint32_t *ctrlinfo,
    uint32_t *outsize, int32_t timeout);

extern drvError_t halMsgSend(uint32_t tId, uint32_t sendTid, int32_t timeout, void *sendInfo, uint32_t size);

extern drvError_t halEschedAckEvent(uint32_t infoType, uint32_t ctrlInfo);
/**
* @ingroup driver
* @brief Trigger to get enable channels
* @attention null
* @param [in] device_id   device ID
* @param [in] channels user's channels list struct
* @return  0 for success, others for fail
*/
extern drvError_t prof_drv_get_channels(unsigned int device_id, channel_list_t *channels);

/**
* @ingroup driver
* @brief Trigger ts or peripheral devices to start preparing for sampling profile information
* @attention null
* @param [in] device_id   device ID
* @param [in] channel_id  Channel ID(CHANNEL_TSCPU--(CHANNEL_TSCPU_MAX - 1))
* @param [in] channel_type to use prof_tscpu_start or prof_peripheral_start interfaces.
* @param [in] real_time  Real-time mode or non-real-time mode
* @param [in] *file_path  path to save the file
* @param [in] *ts_cpu_data  TS related data buffer
* @param [in] data_size  ts related data length
* @return  0 for success, others for fail
*/
extern drvError_t prof_drv_start(unsigned int device_id, unsigned int channel_id, struct prof_start_para *start_para);

/**
* @ingroup driver
* @brief Trigger Prof sample end
* @attention nul
* @param [in] dev_id  Device ID
* @param [in] channel_id  channel ID(1--(CHANNEL_NUM - 1))
* @return   0 for success, others for fail
*/
extern drvError_t prof_stop(unsigned int device_id, unsigned int channel_id);
/**
* @ingroup driver
* @brief Read and collect profile information
* @attention null
* @param [in] device_id  Device ID
* @param [in] channel_id  channel ID(1--(CHANNEL_NUM - 1))
* @param [in] *out_buf  Store read profile information
* @param [in] buf_size  Store the length of the profile to be read
* @return   0   success
* @return positive number for readable buffer length
* @return  -1 for fail
*/
extern drvError_t prof_channel_read(unsigned int device_id, unsigned int channel_id, char *out_buf, \
    unsigned int buf_size);
/**
* @ingroup driver
* @brief Querying valid channel information
* @attention null
* @param [in] *out_buf  User mode pointer
* @param [in] num  Number of channels to monitor
* @param [in] timeout  Timeout in seconds
* @return 0  No channels available
* @return positive number for channels Number
* @return -1 for fail
*/
extern drvError_t prof_channel_poll(struct prof_poll_info *out_buf, int num, int timeout);

/**
* @ingroup driver
* @brief Get physical ID (phyId) using logical ID (devIndex)
* @attention null
* @param [in] devIndex  Logical ID
* @param [out] *phyId  Physical ID
* @return  0 for success, others for fail
*/
extern drvError_t drvDeviceGetPhyIdByIndex(uint32_t devIndex, uint32_t *phyId);

/**
* @ingroup driver
* @brief Get logical ID (devIndex) using physical ID (phyId)
* @attention null
* @param [in] phyId   Physical ID
* @param [out] devIndex  Logical ID
* @return   0 for success, others for fail
*/
extern drvError_t drvDeviceGetIndexByPhyId(uint32_t phyId, uint32_t *devIndex);

/**
* @ingroup driver
* @brief Get current platform information
* @attention null
* @param [out] *info  0 Means currently on the Device side, 1/Means currently on the host side
* @return   0 for success, others for fail
*/
extern drvError_t drvGetPlatformInfo(uint32_t *info);

/**
* @ingroup driver
* @brief Get the current number of devices
* @attention null
* @param [out] *num_dev  Number of current devices
* @return   0 for success, others for fail
*/
extern drvError_t drvGetDevNum(uint32_t *num_dev);

/**
* @ingroup driver
* @brief Convert device-side devId to host-side devId
* @attention null
* @param [in] localDevId  chip ID
* @param [out] *devId  host side devId
* @return   0 for success, others for fail
*/
extern drvError_t drvGetDevIDByLocalDevID(uint32_t localDevId, uint32_t *devId);

/**
* @ingroup driver
* @brief The device side and the host side both obtain the host IDs of all the current devices.
* If called in a container, get the host IDs of all devices in the current container.
* @attention null
* @param [out] *devices   host ID
* @param [out] len  Array length
* @return   0 for success, others for fail
*/
extern drvError_t drvGetDevIDs(uint32_t *devices, uint32_t len);

/**
* @ingroup driver
* @brief Get device information, CPU information and PCIe bus information.
* @attention each  moduleType  and infoType will get a different
* if the type you input is not compatitable with the table below, then will return fail
* --------------------------------------------------------------------------------------------------------
* moduleType                |        infoType             |    value                    |   attention    |
* --------------------------------------------------------------------------------------------------------
* MODULE_TYPE_SYSTEM        |  INFO_TYPE_ENV              |   env type                  |                |
* MODULE_TYPE_SYSTEM        |  INFO_TYPE_VERSION          |   hardware_version          |                |
* MODULE_TYPE_SYSTEM        |  INFO_TYPE_MASTERID         |   masterId                  | used in host   |
* MODULE_TYPE_SYSTEM        |  INFO_TYPE_CORE_NUM         |   ts_num                    |                |
* MODULE_TYPE_SYSTEM        |  INFO_TYPE_SYS_COUNT        |   system count              |                |
* MODULE_TYPE_SYSTEM        |INFO_TYPE_MONOTONIC_RAW      |   MONOTONIC_RAW time        |                |
* --------------------------------------------------------------------------------------------------------
* MODULE_TYPE_AICPU         |  INFO_TYPE_CORE_NUM         |   ai cpu number             |                |
* MODULE_TYPE_AICPU         |  INFO_TYPE_OS_SCHED         |   ai cpu in os sched        | used in device |
* MODULE_TYPE_AICPU         |  INFO_TYPE_IN_USED          |   ai cpu in used            |                |
* MODULE_TYPE_AICPU         |  INFO_TYPE_ERROR_MAP        |   ai cpu error map          |                |
* MODULE_TYPE_AICPU         |  INFO_TYPE_ID               |   ai cpu id                 |                |
* MODULE_TYPE_AICPU         |  INFO_TYPE_OCCUPY           |   ai cpu occupy bitmap      |                |
* --------------------------------------------------------------------------------------------------------
* MODULE_TYPE_CCPU          |  INFO_TYPE_CORE_NUM         |   ctrl cpu number           |                |
* MODULE_TYPE_CCPU          |  INFO_TYPE_ID               |   ctrl cpu id               |                |
* MODULE_TYPE_CCPU          |  INFO_TYPE_IP               |   ctrl cpu ip               |                |
* MODULE_TYPE_CCPU          |  INFO_TYPE_ENDIAN           |   ctrl cpu ENDIAN           |                |
* MODULE_TYPE_CCPU          |  INFO_TYPE_OS_SCHED         |   ctrl cpu  in os sched     | used in device |
* --------------------------------------------------------------------------------------------------------
* MODULE_TYPE_DCPU          |  INFO_TYPE_CORE_NUM         |   data cpu number           | used in device |
* MODULE_TYPE_DCPU          |  INFO_TYPE_OS_SCHED         |   data cpu in os sched      | used in device |
* --------------------------------------------------------------------------------------------------------
* MODULE_TYPE_AICORE        |  INFO_TYPE_CORE_NUM         |   ai core number            |                |
* MODULE_TYPE_AICORE        |  INFO_TYPE_CORE_NUM_LEVEL   |   ai core number level      |                |
* MODULE_TYPE_AICORE        |  INFO_TYPE_IN_USED          |   ai core in used           |                |
* MODULE_TYPE_AICORE        |  INFO_TYPE_ERROR_MAP        |   ai core error map         |                |
* MODULE_TYPE_AICORE        |  INFO_TYPE_ID               |   ai core id                |                |
* MODULE_TYPE_AICORE        |  INFO_TYPE_FREQUE           |   ai core frequence         |                |
* MODULE_TYPE_AICORE        |  INFO_TYPE_FREQUE_LEVEL     |   ai core frequence level   |                |
* --------------------------------------------------------------------------------------------------------
* MODULE_TYPE_VECTOR_CORE   |   INFO_TYPE_CORE_NUM        | vector core number          |                |
* MODULE_TYPE_VECTOR_CORE   |   INFO_TYPE_FREQUE          | vector core frequence       |                |
* --------------------------------------------------------------------------------------------------------
* MODULE_TYPE_TSCPU         |  INFO_TYPE_CORE_NUM         |   ts cpu number             |                |
* MODULE_TYPE_TSCPU         |  INFO_TYPE_OS_SCHED         |   ts cpu in os sched        | used in device |
* MODULE_TYPE_TSCPU         |  INFO_TYPE_FFTS_TYPE        |   ts cpu ffts type          | used in device |
* --------------------------------------------------------------------------------------------------------
* MODULE_TYPE_PCIE          |  INFO_TYPE_ID               |   pcie bdf                  | used in host   |
* --------------------------------------------------------------------------------------------------------
* @param [in] devId  Device ID
* @param [in] moduleType  See enum DEV_MODULE_TYPE
* @param [in] infoType  See enum DEV_INFO_TYPE
* @param [out] *value  device info
* @return   0 for success, others for fail
*/
extern drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value);

#ifdef __cplusplus
}
#endif

#endif