/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __DSMI_COMMON_INTERFACE_H__
#define __DSMI_COMMON_INTERFACE_H__
#ifdef __cplusplus
extern "C" {
#endif

#ifdef __linux
#define DLLEXPORT
#else
#define DLLEXPORT _declspec(dllexport)
#endif

#include "ascend_hal_error.h"
#include "dms_device_node_type.h"
#include "dsmi_common_interface_base.h"

#define DMP_MSG_HEAD_LENGTH     12U
#define DMP_MAX_MSG_DATA_LEN    (1024U - DMP_MSG_HEAD_LENGTH)

#define PATH_MAX 4096
#define BIT_IF_ONE(number, n) (((number) >> (n)) & (0x1))
#define MAX_FILE_LEN PATH_MAX
#define MAX_LINE_LEN 255
#define MAX_LOCK_NAME 30
#define PCIE_EP_MODE 0X0
#define PCIE_RC_MODE 0X1

#define DAVINCHI_SYS_VERSION 0XFF
#define INVALID_DEVICE_ID 0XFF

// 1980 dsmi return value
#define DM_DDMP_ERROR_CODE_EAGAIN DRV_ERROR_TRY_AGAIN                     /**< same as EAGAIN */
#define DM_DDMP_ERROR_CODE_PERM_DENIED DRV_ERROR_OPER_NOT_PERMITTED                 /**< same as EPERM */
// all of follow must same as inc/base.h
#define DM_DDMP_ERROR_CODE_SUCCESS DRV_ERROR_NONE                      /**< success */
#define DM_DDMP_ERROR_CODE_PARAMETER_ERROR DRV_ERROR_PARA_ERROR              /**< param error */
#define DM_DDMP_ERROR_CODE_INVALID_HANDLE_ERROR DRV_ERROR_INVALID_HANDLE         /**< invalid fd handle */
#define DM_DDMP_ERROR_CODE_TIME_OUT DRV_ERROR_WAIT_TIMEOUT                    /**< wait time out */
#define DM_DDMP_ERROR_CODE_IOCRL_ERROR DRV_ERROR_IOCRL_FAIL                 /**< ioctl error */
#define DM_DDMP_ERROR_CODE_INVALID_DEVICE_ERROR DRV_ERROR_INVALID_DEVICE        /**< invalid device */
#define DM_DDMP_ERROR_CODE_SEND_ERROR DRV_ERROR_SEND_MESG                  /**< hdc or upd send error */
#define DM_DDMP_ERROR_CODE_INTERNAL_ERROR DRV_ERROR_INNER_ERR              /**< internal error */
#define DM_DDMP_ERROR_CODE_NOT_SUPPORT DRV_ERROR_NOT_SUPPORT                 /**< dsmi command not support error */
#define DM_DDMP_ERROR_CODE_MEMERY_OPRATOR_ERROR DRV_ERROR_MEMORY_OPT_FAIL        /**< system memory function error */
#define DM_DDMP_ERROR_CODE_PERIPHERAL_DEVICE_NOT_EXIST DRV_ERROR_NOT_EXIST /**< peripheral device not exist, BMC used */

typedef struct dm_flash_info_stru {
    unsigned long long flash_id;    /**< combined device & manufacturer code */
    unsigned short device_id;       /**< device id    */
    unsigned short vendor;          /**< the primary vendor id  */
    unsigned int state;             /**< flash health */
    unsigned long long size;        /**< total size in bytes  */
    unsigned int sector_count;      /**< number of erase units  */
    unsigned short manufacturer_id; /** manufacturer id   */
} DM_FLASH_INFO_STRU, dm_flash_info_stru;

typedef struct tag_pcie_idinfo {
    unsigned int deviceid;
    unsigned int venderid;
    unsigned int subvenderid;
    unsigned int subdeviceid;
    unsigned int bdf_deviceid;
    unsigned int bdf_busid;
    unsigned int bdf_funcid;
} TAG_PCIE_IDINFO, tag_pcie_idinfo;

typedef struct tag_ecc_stat {
    unsigned int error_count;
} TAG_ECC_STAT, tag_ecc_stat;

typedef struct dsmi_upgrade_control {
    unsigned char control_cmd;
    unsigned char component_type;
    unsigned char file_name[PATH_MAX];
} DSMI_UPGRADE_CONTROL;

typedef enum dsmi_upgrade_device_state {
    UPGRADE_IDLE_STATE = 0,
    IS_UPGRADING = 1,
    UPGRADE_NOT_SUPPORT = 2,
    UPGRADE_UPGRADE_FAIL = 3,
    UPGRADE_STATE_NONE = 4,
    UPGRADE_WAITTING_RESTART = 5,
    UPGRADE_WAITTING_SYNC = 6,
    UPGRADE_SYNCHRONIZING = 7
} DSMI_UPGRADE_DEVICE_STATE;

typedef enum {
    DSMI_DEVICE_TYPE_DDR,
    DSMI_DEVICE_TYPE_SRAM,
    DSMI_DEVICE_TYPE_HBM,
    DSMI_DEVICE_TYPE_NPU,
    DSMI_HBM_RECORDED_SINGLE_ADDR,
    DSMI_HBM_RECORDED_MULTI_ADDR,
    DSMI_DEVICE_TYPE_NONE = 0xff
} DSMI_DEVICE_TYPE;

typedef enum dsmi_boot_status {
    DSMI_BOOT_STATUS_UNINIT = 0, /**< uninit status */
    DSMI_BOOT_STATUS_BIOS,       /**< status of starting BIOS */
    DSMI_BOOT_STATUS_OS,         /**< status of starting OS */
    DSMI_BOOT_STATUS_FINISH,     /**< finish boot start */
    DSMI_SYSTEM_START_FINISH = 16  /**< dsmi channel ready */
} DSMI_BOOT_STATUS;

typedef enum rdfx_detect_result {
    RDFX_DETECT_OK = 0,
    RDFX_DETECT_SOCK_FAIL = 1,
    RDFX_DETECT_RECV_TIMEOUT = 2,
    RDFX_DETECT_UNREACH = 3,
    RDFX_DETECT_TIME_EXCEEDED = 4,
    RDFX_DETECT_FAULT = 5,
    RDFX_DETECT_INIT = 6,
    RDFX_DETECT_THREAD_ERR = 7,
    RDFX_DETECT_IP_SET = 8,
    RDFX_DETECT_MAX
} DSMI_NET_HEALTH_STATUS;

#define UTLRATE_TYPE_DDR 1
#define UTLRATE_TYPE_AICORE 2
#define UTLRATE_TYPE_AICPU 3
#define UTLRATE_TYPE_CTRLCPU 4
#define UTLRATE_TYPE_DDR_BANDWIDTH 5
#define UTLRATE_TYPE_HBM 6

#define TAISHAN_CORE_NUM 16
typedef struct dsmi_aicpu_info_stru {
    unsigned int maxFreq;
    unsigned int curFreq;
    unsigned int aicpuNum;
    unsigned int utilRate[TAISHAN_CORE_NUM];
} DSMI_AICPU_INFO;

typedef enum {
    ECC_CONFIG_ITEM = 0X0,
    P2P_CONFIG_ITEM = 0X1,
    DFT_CONFIG_ITEM = 0X2,
    VDEV_MODE_CONFIG_ITEM = 0X3
} CONFIG_ITEM;

typedef enum {
    DSMI_UPGRADE_MAIN_TYPE_VERSION = 0,
    DSMI_UPGRADE_MAIN_TYPE_PARTITION,
    DSMI_UPGRADE_MAIN_TYPE_REG_PROG_PKG_INFO, // register program package infomation
    DSMI_UPGRADE_SUB_TYPE_FW_VERIFY,
    DSMI_UPGRADE_MAIN_TYPE_CRL,
    /* Basic version information of the BOM, which is written in the fixed area of
       the flash memory during production. */
    DSMI_UPGRADE_MAIN_TYPE_BOM_INIT_VER,
    DSMI_UPGRADE_MAIN_TYPE_MAX,
} DSMI_UPGRADE_MAIN_TYPE;

typedef enum {
    DSMI_UPGRADE_GET_PUBLIC_AREA_CRL,
    DSMI_UPGRADE_GET_LOCAL_IMAGE_CRL,
    DSMI_UPGRADE_SUB_TYPE_CRL_MAX,
} DSMI_UPGRADE_SUB_TYPE_CRL;

typedef enum dsmi_component_type {
    DSMI_COMPONENT_TYPE_NVE,
    DSMI_COMPONENT_TYPE_XLOADER,
    DSMI_COMPONENT_TYPE_M3FW,
    DSMI_COMPONENT_TYPE_UEFI,
    DSMI_COMPONENT_TYPE_TEE,
    DSMI_COMPONENT_TYPE_KERNEL,
    DSMI_COMPONENT_TYPE_DTB,
    DSMI_COMPONENT_TYPE_ROOTFS,
    DSMI_COMPONENT_TYPE_IMU,
    DSMI_COMPONENT_TYPE_IMP,
    DSMI_COMPONENT_TYPE_AICPU,
    DSMI_COMPONENT_TYPE_HBOOT1_A,
    DSMI_COMPONENT_TYPE_HBOOT1_B,
    DSMI_COMPONENT_TYPE_HBOOT2,
    DSMI_COMPONENT_TYPE_DDR,
    DSMI_COMPONENT_TYPE_LP,
    DSMI_COMPONENT_TYPE_HSM,
    DSMI_COMPONENT_TYPE_SAFETY_ISLAND,
    DSMI_COMPONENT_TYPE_HILINK,
    DSMI_COMPONENT_TYPE_RAWDATA,
    DSMI_COMPONENT_TYPE_SYSDRV,
    DSMI_COMPONENT_TYPE_ADSAPP,
    DSMI_COMPONENT_TYPE_COMISOLATOR,
    DSMI_COMPONENT_TYPE_CLUSTER,
    DSMI_COMPONENT_TYPE_CUSTOMIZED,
    DSMI_COMPONENT_TYPE_SYS_BASE_CONFIG,
    DSMI_COMPONENT_TYPE_RECOVERY,
    DSMI_COMPONENT_TYPE_HILINK2,
    DSMI_COMPONENT_TYPE_LOGIC_BIST,
    DSMI_COMPONENT_TYPE_MEMORY_BIST,
    DSMI_COMPONENT_TYPE_ATF,
    DSMI_COMPONENT_TYPE_USER_BASE_CONFIG,
    DSMI_COMPONENT_TYPE_RTC_CORE,
    DSMI_COMPONENT_TYPE_RTC_CONFIG,
    DSMI_COMPONENT_TYPE_AO_BOOT,
    DSMI_COMPONENT_TYPE_AO_FW,
    DSMI_COMPONENT_TYPE_SIOE,
    DSMI_COMPONENT_TYPE_MAX,        /* for internal use only */
    UPGRADE_AND_RESET_ALL_COMPONENT = 0xFFFFFFF7U,
    UPGRADE_STATE_FLAG = 0xFFFFFFFCU,
    UPGRADE_ALL_IMAGE_COMPONENT = 0xFFFFFFFDU,
    UPGRADE_ALL_FIRMWARE_COMPONENT = 0xFFFFFFFEU,
    UPGRADE_ALL_COMPONENT = 0xFFFFFFFFU
} DSMI_COMPONENT_TYPE;

/* DSMI sub command for UPGRADE module */
typedef enum {
    DSMI_UPGRADE_SUB_TYPE_GET_PARTITION = 0,
    DSMI_UPGRADE_SUB_TYPE_SET_PARTITION = 1,
    DSMI_UPGRADE_SET_COLD_BOOT_AREA = 2,
    DSMI_UPGRADE_SAVE_ORIGIN_AREA = 3,
    DSMI_UPGRADE_GET_UPGRADE_INFO = 4,
    DSMI_UPGRADE_SET_WARM_BOOT_AREA = 5,
    DSMI_UPGRADE_GET_WARM_BOOT_AREA = 6,
    DSMI_UPGRADE_GET_RUN_IMG_LOCATION_INFO = 7,
    DSMI_UPGRADE_SUB_TYPE_PARTITION_MAX,
} DSMI_UPGRADE_SUB_TYPE_PARTITION;

#define DSMI_UPGRADE_NONE 0
#define DSMI_UPGRADING 1
#define DSMI_BOOT_NONE 0
#define DSMI_BOOT_MAIN 1
#define DSMI_BOOT_BAK  2
#define UPGRADE_RESERVED_LEN 10
typedef struct dsmi_upgrade_flags {
    unsigned int upgrade_sys;  /* indicates whether environment is upgrading(1) or no upgrade(0) */
    unsigned int boot_area;    /* indicates next boot area is master(1) or backup(2) or none (0) */
    unsigned int reserved[UPGRADE_RESERVED_LEN];
} DSMI_UPGRADE_FLAG;

typedef struct dsmi_upgrade_info {
    unsigned int upgrade_sys;        /* indicates whether environment is upgrading(1) or no upgrade(0) */
    unsigned int boot_area_firmware; /* indicates firmware boot area is master(1) or backup(2) or none (0) */
    unsigned int boot_area_image;    /* indicates image boot area is master(1) or backup(2) or none (0) */
    unsigned int origin_area;        /* indicates origin area is master(1) or backup(2) or none (0) */
    unsigned int reserved[UPGRADE_RESERVED_LEN];
} DSMI_UPGRADE_INFO;

typedef struct dsmi_upgrade_bom_init_ver {
    int driver;     /* bom initial version number of driver */
    int firmware;   /* bom initial version number of firmware */
} DSMI_UPGRADE_BOM_INIT_VER;

typedef struct dsmi_runimglocation_info {
    unsigned int valid;            /* indicates whether the structure information is available. 0:invalid, 1:valid */
    unsigned int os_location;      /* indicates the current boot partition of the OS. 0:master, 1:backup */
    unsigned int flash_location;   /* indicates the preferred boot partition of the flash. 0:master, 1:backup */
    unsigned int disk_type;        /* indicates the disk media type. 0:UFS, 1:SSD, 2:EMMC */
    unsigned int reserved[UPGRADE_RESERVED_LEN];     /* Reserved field. default value is 0 */
} DSMI_RUNIMGLOCATION_INFO;

/* partition type */
typedef enum {
    PARTITION_A = 0,
    PARTITION_B,
} PARTITION_TYPE;

/* package type, Security information is at the head or tail of the file. */
typedef enum {
    SEC_INFO_AT_HEAD = 0,
    SEC_INFO_AT_TAIL,
} PACKAGE_TYPE;

#define PROG_PKG_INFO_RESERVE_LEN 10
/* Format of the input parameter of the DSMI_UPGRADE_MAIN_TYPE_REG_PROG_PKG_INFO */
typedef struct program_pkg_info {
    unsigned int component_id;
    PARTITION_TYPE partition;
    unsigned int lun_id;
    unsigned long long lun_offset;
    PACKAGE_TYPE pkg_type;
    unsigned int reserve[PROG_PKG_INFO_RESERVE_LEN];
} PROG_PKG_INFO;

#define MAX_COMPONENT_NUM 32U

typedef struct cfg_file_des {
    unsigned char component_type;
    char src_component_path[PATH_MAX];
    char dst_compoent_path[PATH_MAX];
} CFG_FILE_DES;

typedef enum {
    DSMI_REVOCATION_TYPE_SOC = 0,      /* for SOC revocation */
    DSMI_REVOCATION_TYPE_CMS_CRL = 1,  /* for MDC CMS CRL file upgrade */
    DSMI_REVOCATION_TYPE_CMS_CRL_EXT = 2, /* for extended CRL upgrade */
    DSMI_REVOCATION_TYPE_MAX
} DSMI_REVOCATION_TYPE;

/* Data Identifier */
struct dsmi_did_info {
    unsigned short did_id;
    unsigned short did_value_size;
    unsigned char *did_value;
};

/* Unified Diagnostic Services */
struct dsmi_uds_info {
    unsigned short total_size;
    unsigned short did_info_size;
    struct dsmi_did_info *did_record;
};

struct dsmi_fault_info {
    union {
        struct dsmi_uds_info uds_info;
    } fault_t;
};

typedef void (*fault_event_handler)(unsigned int faultcode,
    unsigned int faultstate, struct dsmi_fault_info *fault_info);

#define DSMI_SOC_DIE_LEN 5
struct dsmi_soc_die_stru {
    unsigned int soc_die[DSMI_SOC_DIE_LEN]; /**< 5 soc_die arrary sizet */
};
struct dsmi_power_info_stru {
    unsigned short power;
};
struct dsmi_memory_info_stru {
    unsigned long long memory_size;
    unsigned int freq;
    unsigned int utiliza;
};

struct dsmi_hbm_info_stru {
    unsigned long long memory_size;      /**< HBM total size, KB */
    unsigned int freq;                   /**< HBM freq, MHZ */
    unsigned long long memory_usage;     /**< HBM memory_usage, KB */
    int temp;                            /**< HBM temperature */
    unsigned int bandwith_util_rate;
};

typedef struct dsmi_aicore_info_stru {
    unsigned int freq;    /**< normal freq */
    unsigned int curfreq; /**< current freq */
} DSMI_AICORE_FRE_INFO;

struct dsmi_ecc_info_stru {
    int enable_flag;
    unsigned int single_bit_error_count;
    unsigned int double_bit_error_count;
};

struct tag_cgroup_info {
    unsigned long long limit_in_bytes;       /**< maximum number of used memory */
    unsigned long long max_usage_in_bytes;   /**< maximum memory used in history */
    unsigned long long usage_in_bytes;       /**< current memory usage */
};

#define MAX_CHIP_NAME 32
#define MAX_DEVICE_COUNT 64

struct dsmi_chip_info_stru {
    unsigned char chip_type[MAX_CHIP_NAME];
    unsigned char chip_name[MAX_CHIP_NAME];
    unsigned char chip_ver[MAX_CHIP_NAME];
};

#define DSMI_VNIC_PORT 0
#define DSMI_ROCE_PORT 1
#define DSMI_BOND_PORT 2
#define DSMI_UNIC_PORT 3

enum ip_addr_type {
    IPADDR_TYPE_V4 = 0U,    /**< IPv4 */
    IPADDR_TYPE_V6 = 1U,    /**< IPv6 */
    IPADDR_TYPE_ANY = 2U
};

#define DSMI_ARRAY_IPV4_NUM 4
#define DSMI_ARRAY_IPV6_NUM 16

typedef struct ip_addr {
    union {
        unsigned char ip6[DSMI_ARRAY_IPV6_NUM];
        unsigned char ip4[DSMI_ARRAY_IPV4_NUM];
    } u_addr;
    enum ip_addr_type ip_type;
} ip_addr_t;


#define COMPUTING_POWER_PMU_NUM 4

struct dsmi_cntpct_stru {
    unsigned long long state;
    unsigned long long timestamp1;
    unsigned long long timestamp2;
    unsigned long long event_count[COMPUTING_POWER_PMU_NUM];
    unsigned int system_frequency;
};

typedef enum dsmi_channel_index {
    DEVICE = 0,
    HOST = 1,
    MCU = 2
} DMSI_CHANNEL_INDEX;

struct dmp_req_message_stru {
    unsigned char lun;
    unsigned char arg;
    unsigned short opcode;
    unsigned int offset;
    unsigned int length;
    unsigned char data[DMP_MAX_MSG_DATA_LEN];
};

#define DSMI_RSP_MSG_DATA_LEN 1012
struct dmp_rsp_message_stru {
    unsigned short errorcode;
    unsigned short opcode;
    unsigned int total_length;
    unsigned int length;
    unsigned char data[DSMI_RSP_MSG_DATA_LEN]; /**< 1012 rsp data size */
};

struct dmp_message_stru {
    union {
        struct dmp_req_message_stru req;
        struct dmp_rsp_message_stru rsp;
    } data;
};

struct passthru_message_stru {
    unsigned int src_len;
    unsigned int rw_flag; /**< 0 read ,1 write */
    struct dmp_message_stru src_message;
    struct dmp_message_stru dest_message;
};

struct dsmi_board_info_stru {
    unsigned int board_id;
    unsigned int pcb_id;
    unsigned int bom_id;
    unsigned int slot_id;
};

typedef struct dsmi_llc_perf_stru {
    unsigned int wr_hit_rate;
    unsigned int rd_hit_rate;
    unsigned int throughput;
} DSMI_LLC_PERF_INFO;

#define SENSOR_DATA_MAX_LEN 16

#define DSMI_TAG_SENSOR_TEMP_LEN 2
#define DSMI_TAG_SENSOR_NTC_TEMP_LEN 4
typedef union tag_sensor_info {
    unsigned char uchar;
    unsigned short ushort;
    unsigned int uint;
    signed int iint;
    signed char temp[DSMI_TAG_SENSOR_TEMP_LEN];   /**<  2 temp size */
    signed int ntc_tmp[DSMI_TAG_SENSOR_NTC_TEMP_LEN]; /**<  4 ntc_tmp size */
    unsigned int data[SENSOR_DATA_MAX_LEN];
} TAG_SENSOR_INFO;

typedef enum {
    POWER_STATE_SUSPEND,
    POWER_STATE_POWEROFF,
    POWER_STATE_RESET,
    POWER_STATE_BIST,
    POWER_STATE_MAX,
} DSMI_POWER_STATE;

typedef enum {
    POWER_RESUME_MODE_BUTTON,   /* resume by button */
    POWER_RESUME_MODE_TIME,     /* resume by time */
    POWER_RESUME_MODE_TIME_POWEROFF, /* poweroff by time */
    POWER_RESUME_MODE_MAX,
} DSMI_LP_RESUME_MODE;

#define POWER_INFO_RESERVE_LEN 8
struct dsmi_power_state_info_stru {
    DSMI_POWER_STATE type;
    DSMI_LP_RESUME_MODE mode;
    unsigned int value;
    unsigned int reserve[POWER_INFO_RESERVE_LEN];
};

#define DSMI_LP_WORK_TOPS_RESERVE 32
typedef struct dsmi_lp_work_tops_stru {
    unsigned int work_tops;
    unsigned int is_in_flash;
    unsigned char reserve[DSMI_LP_WORK_TOPS_RESERVE];
} DSMI_LP_WORK_TOPS_STRU;

struct dsmi_lp_each_tops_details {
    unsigned int work_tops;     /* it is a index for aic_tops */
    unsigned int aic_tops;      /* just as 4T/8T/8Tx/16T */
    unsigned int aic_freq;      /* AI core frequence */
    unsigned int aic_vol;       /* AI core voltage */
    unsigned int cpu_freq;      /* CPU frequence */
    unsigned int cpu_vol;       /* CPU voltage */
    unsigned char reserve[DSMI_LP_WORK_TOPS_RESERVE];
};

#define DSMI_LP_WORK_TOPS_MAX 10
typedef struct dsmi_lp_tops_details_stru {
    unsigned int tops_nums;
    struct dsmi_lp_each_tops_details each_work_tops[DSMI_LP_WORK_TOPS_MAX];
} DSMI_LP_TOPS_DETAILS_STRU;

typedef struct dsmi_lp_cur_tops_stru {
    unsigned int work_tops;
    unsigned int tops_nums;
} DSMI_LP_CUR_TOPS_STRU;

#define LOAD_AWA_SWITCH_OFF     0
#define LOAD_AWA_SWITCH_ON      1
#define LOAD_AWA_RES_MAX        7
#define LOAD_AWA_PARA_MAX       8
typedef enum {
    LOAD_AWA_SWITCH_TYPE = 0,
} FEATURE_TYPE;

struct load_awa_feature_para {
    unsigned int over_time;
    unsigned int res[LOAD_AWA_RES_MAX];
};

struct dsmi_lpm_feature_switch {
    FEATURE_TYPE feature_type;
    unsigned int feature_switch;
	union{
		unsigned int data[LOAD_AWA_PARA_MAX]; // 结构体对齐8 * unint32_t
		struct load_awa_feature_para load_awa_feature_para;
	} switch_para;
};

// lp stress cfg type
enum {
    STRESS_ADJ_AIC,
    STRESS_ADJ_BUS,
    STRESS_ADJ_L2CACHE,
    STRESS_ADJ_MATA,
    STRESS_ADJ_CPU,
    STRESS_ADJ_HBM,
    STRESS_ADJ_MAX
};

// lp stress set restore
enum {
    STRESS_VOLT_SET,
    STRESS_VOLT_RESTORE,
    STRESS_FREQ_SET,
    STRESS_FREQ_RESTORE,
    STRESS_FUNC_OPEN,
    STRESS_FUNC_CLOSE,
    STRESS_SET_RESTORE_MAX
};

struct soc_stress_cfg {
    unsigned char type;
    unsigned char set_restore;
    unsigned short value;
};

#define LPM_SOC_STRESS_RESV_LEN 24
#define COMPONENT_CFG_MAGIC   0x636F6D70U  /* comp */
struct component_id_cfg {
    unsigned int magic;
    unsigned int component_id;
};

typedef struct lpm_soc_stress_dsmi_cfg_in {
    struct soc_stress_cfg cfg;
    struct component_id_cfg component_cfg;
    unsigned char resv[LPM_SOC_STRESS_RESV_LEN];
} DSMI_LP_SET_STRESS_TEST_STRU;

#define CPM_BUFFER_SIZE 256
typedef struct dsmi_cpm_out_info {
    unsigned short voltage;
    unsigned char max_volt_fall;
    unsigned char core_num;
    unsigned char cpm_data[CPM_BUFFER_SIZE];
} DSMI_LP_GET_CPM_STRU;

#define LPM_STREE_FREQ_VOLT_RESV_LEN 4
struct soc_stress_freq_volt {
    unsigned short freq;
    unsigned short volt;
    unsigned short freq1;
    unsigned short volt1;
    unsigned char resv[LPM_STREE_FREQ_VOLT_RESV_LEN];
};

#define LPM_STREE_FREQ_VOLT_TYPE_MAX 16
typedef struct dsmi_stress_freq_volt_out_info {
    struct soc_stress_freq_volt freq_volt[LPM_STREE_FREQ_VOLT_TYPE_MAX];
} DSMI_LP_GET_STRESS_FREQ_VOLT_STRU;

enum DsmiShareMemTempType {
    DSMI_SOC_MAX_TEMP,
    DSMI_SOC_AIC_MAX_TEMP,
    DSMI_SOC_HBM_MAX_TEMP,
    DSMI_SOC_TOTEM_MAX_TEMP,
    DSMI_MOUDLE_TEMP_MAX = 64,
};

#define LP_TEMP_INVALID_VALUE  (-128)
#define LP_TEMP_TSENSOR_NUM_MAX  512

typedef struct dsmi_lp_temp_info {
    short tsensor_temp[LP_TEMP_TSENSOR_NUM_MAX];
    short temp[DSMI_MOUDLE_TEMP_MAX];
} DSMI_LP_TEMP_INFO_STRU;

#define DSMI_LP_AIC_INFO_RES   56
typedef struct dsmi_lp_aic_info {
    unsigned int aic_current;
    unsigned int aic_power;
    unsigned char res[DSMI_LP_AIC_INFO_RES];
} DSMI_LP_AIC_INFO_STRU;

#define DSMI_LP_BUS_INFO_RES   56
typedef struct dsmi_lp_bus_info {
    unsigned int bus_current;
    unsigned int bus_power;
    unsigned char res[DSMI_LP_BUS_INFO_RES];
} DSMI_LP_BUS_INFO_STRU;

#define DSMI_LP_HBM_INFO_RES   60
typedef struct dsmi_lp_hbm_info {
    unsigned int hbm_current;
    unsigned char res[DSMI_LP_HBM_INFO_RES];
} DSMI_LP_HBM_INFO_STRU;

#define DSMI_LP_POWER_RESERVED_LEN 32
typedef struct dsmi_lp_power_info {
    unsigned int soc_rated_power;
    unsigned char reserved[DSMI_LP_POWER_RESERVED_LEN];
} DSMI_LP_POWER_INFO_STRU;

#define DDR_ECC_CONFIG_NAME      "ddr_ecc_enable"

#define MAX_CAN_NAME 32

typedef struct dsmi_emmc_status_stru {
    unsigned int    clock;               /**< clock rate */
    unsigned int    clock_store;         /**< store the clock before power off */
    unsigned short  vdd;                 /**< vdd stores the bit number of the selected voltage range from below. */
    unsigned int    power_delay_ms;      /**< waiting for stable power */
    unsigned char   bus_mode;            /**< command output mode */
    unsigned char   chip_select;         /**< SPI chip select */
    unsigned char   power_mode;          /**< power supply mode */
    unsigned char   bus_width;           /**< data bus width */
    unsigned char   timing;              /**< timing specification used */
    unsigned char   signal_voltage;      /**< signalling voltage (1.8V or 3.3V) */
    unsigned char   drv_type;            /**< A, B, C, D */
    unsigned char   enhanced_strobe;     /**< hs400es selection */
} DSMI_EMMC_STATUS_STRU;

#define EMMC_MAX_PI_LEN     7
#define EMMC_FW_LEN         8
#define EMMC_RESERVE_LEN    8
#define EMMC_MANUFACTORY_INFO_LEN    512

typedef enum {
    DSMI_EMMC_SUB_CMD_STANDARD_INFO = 0x01,            /* Standard protocol information */
    DSMI_EMMC_SUB_CMD_MANUFACTURER_INFO = 0x02,      /* Manufacturer custom information */
    EMMC_SUB_CMD_INVALID = 0xFF,
} EMMC_SUB_CMD;

struct dsmi_emmc_standard_info_stru {
    unsigned int manufacturer_id;         /* emmc device manufacturer id */
    unsigned char product_name[EMMC_MAX_PI_LEN];    /* emmc device product identification */
    unsigned char timing_interface;       /* emmc speed mode: 9-HS200; 10-HS400 (see define in linux/mmc/host.h) */
    unsigned int serial_number;           /* emmc device serial number */
    unsigned int fault_status;            /* emmc device exception status */
    unsigned int device_life_time_a;      /* emmc device life time estimation type A value */
    unsigned int device_life_time_b;      /* emmc device life time estimation type B value */
    unsigned int pre_eol_info;            /* emmc device life time reflected by average reserved blocks */
    unsigned int spec_version;            /* emmc device specification version */
    unsigned int device_version;          /* emmc device device version */
    unsigned int total_capacity;          /* total raw device capacity (unit: 512 bytes) */
    unsigned char fw_ver[EMMC_FW_LEN];    /* product revision level */
    unsigned int reserve[EMMC_RESERVE_LEN]; /* reserve size */
};

#define PCIE_RESERVE_LEN    8

struct dsmi_pcie_info_para {
    unsigned int link_status;
    unsigned int rate_mode;
    unsigned int lane_num;
    unsigned int reserved[PCIE_RESERVE_LEN];
};

typedef enum {
    BUS_STATE_ACTIVER,
    BUS_STATE_ERR_WARNING,
    BUS_STATE_ERR_PASSIVE,
    BUS_STATE_ERR_BUSOFF,
    BUS_STATE_DOWN,
} DSMI_CAN_BUS_STATE;

typedef struct dsmi_can_status_stru {
    DSMI_CAN_BUS_STATE bus_state;
    unsigned int rx_err_counter;
    unsigned int tx_err_counter;
    unsigned int err_passive;
} DSMI_CAN_STATUS_STRU;

typedef enum {
    UFS_STATE_LINKOFF,
    UFS_STATE_ACTIVE,
    UFS_STATE_HIBERN8,
} DSMI_UFS_STATE;

typedef enum {
    UFS_FAST_MODE   = 1,
    UFS_SLOW_MODE   = 2,
    UFS_FASTAUTO_MODE   = 4,
    UFS_SLOWAUTO_MODE   = 5,
    UFS_UNCHANGED   = 7,
} DSMI_UFS_PWR_MODE;

typedef enum {
    UFS_PA_HS_MODE_A    = 1,
    UFS_PA_HS_MODE_B    = 2,
} DSMI_UFS_HS_MODE;

typedef enum {
    UFS_DONT_CHANGE,
    UFS_GEAR_1,
    UFS_GEAR_2,
    UFS_GEAR_3,
} DSMI_UFS_GEAR;

typedef enum {
    UFS_UIC_LINK_OFF_STATE  = 0,     /**< Link powered down or disabled */
    UFS_UIC_LINK_ACTIVE_STATE   = 1, /**< Link is in Fast/Slow/Sleep state */
    UFS_UIC_LINK_HIBERN8_STATE  = 2, /**< Link is in Hibernate state */
} DSMI_UFS_LINK_STATE;

typedef enum {
    UFS_DEV_PWR_ACTIVE = 1,
    UFS_DEV_PWR_SLEEP  = 2,
    UFS_DEV_PWR_POWERDOWN  = 3,
} DSMI_UFS_DEV_PWR_STATE;

typedef enum {
    UFS_DEV_CLK_19M2 = 0,
    UFS_DEV_CLK_26M0,
    UFS_DEV_CLK_38M4,
    UFS_DEV_CLK_52M0,
    UFS_DEV_CLK_INVAL,
} DSMI_UFS_DEV_CLOCK;

typedef enum {
    UFS_PM_LEVEL_0, /**< UFS_ACTIVE_PWR_MODE, UIC_LINK_ACTIVE_STATE */
    UFS_PM_LEVEL_1, /**< UFS_ACTIVE_PWR_MODE, UIC_LINK_HIBERN8_STATE */
    UFS_PM_LEVEL_2, /**< UFS_SLEEP_PWR_MODE, UIC_LINK_ACTIVE_STATE */
    UFS_PM_LEVEL_3, /**< UFS_SLEEP_PWR_MODE, UIC_LINK_HIBERN8_STATE */
    UFS_PM_LEVEL_4, /**< UFS_POWERDOWN_PWR_MODE, UIC_LINK_HIBERN8_STATE */
    UFS_PM_LEVEL_5, /**< UFS_POWERDOWN_PWR_MODE, UIC_LINK_OFF_STATE */
    UFS_PM_LEVEL_MAX,
} DSMI_UFS_PM_LEVEL;

#define UFS_MAX_MN_LEN  18                      /**< ufs max manufacturer name length */
#define UFS_MAX_SN_LEN  254                     /**< ufs max serial number length */
#define UFS_MAX_PI_LEN  34                      /**< ufs max product identification */

typedef struct dsmi_ufs_status_stru {
    DSMI_UFS_STATE status;                      /**< ufs status */
    DSMI_UFS_PWR_MODE rx_pwr_mode;              /**< rx rate mode */
    DSMI_UFS_PWR_MODE tx_pwr_mode;              /**< tx rate mode */
    DSMI_UFS_GEAR rx_pwr_gear;                  /**< rx rate */
    DSMI_UFS_GEAR tx_pwr_gear;                  /**< tx rate */
    unsigned int rx_lanes;                      /**< rx lanes */
    unsigned int tx_lanes;                      /**< tx lanes */
    DSMI_UFS_LINK_STATE link_pwr_status;        /**< link power status */
    DSMI_UFS_DEV_PWR_STATE device_pwr_status;   /**< device power status */
    int temperature;                            /**< ufs device temperature */
    unsigned int fault_status;                  /**< ufs device exception status */
    unsigned int total_capacity;                /**< total raw device capacity */
    unsigned int model_number;                  /**< ufs device sub class */
    unsigned int device_life_time;              /**< ufs device life time used */
    unsigned int fw_ver;                        /**< product revision level */
    unsigned int fw_update_enable;              /**< whether to support firmware update: 0-not support, 1-support */
    unsigned char product_name[UFS_MAX_PI_LEN];         /**< ufs device product identification */
    unsigned char manufacturer_name[UFS_MAX_MN_LEN];    /** <ufs device manufacturer name */
    unsigned char serial_number[UFS_MAX_SN_LEN];        /** <ufs device serial number */
    unsigned int spec_version;                  /**< ufs device specification version */
    unsigned int device_version;                /**< ufs device device version */
} DSMI_UFS_STATUS_STRU;

#define FSIN_USER_NUM  4

typedef struct dsmi_sensorhub_status_stru {
    /**< 0:normal, 1: no working, 2: fsync lost, 4: pps lost, 6: pps&fsync lost */
    unsigned int status;
    unsigned int timestamp_lost_error_cnt[FSIN_USER_NUM];       /**< timestamp irq lost error count */
    unsigned int timestamp_op_error_cnt;         /**< timestamp read/write operation error count */
    unsigned int pps_lost_error_cnt;             /**< GPS PPS lost error count */
} DSMI_SENSORHUB_STATUS_STRU;

#define MAX_SID_FILTER_NUM  128
#define MAX_XID_FILTER_NUM  64

struct sid_filter_stru {
    /**
     * Standard Filter Type:
     * 0 - Range filter from SFID1 to SFID2
     * 1 - Dual ID filter for SFID1 or SFID2
     * 2 - Classic filter: SFID1 = filter, SFID2 = mask
     * 3 - Filter element disabled
     */
    unsigned int sft : 2;
    /**
     * Standard Filter Element Configuration:
     * 0 - Disable filter element
     * 1 - Store in Rx FIFO 0 if filter matches
     * 2 - Store in Rx FIFO 1 if filter matches
     * 3 - Reject ID if filter matches, not intended to be used with Sync messages
     * 4 - Set priority if filter matches, not intended to be used with Sync messages, no storage
     * 5 - Set priority and store in FIFO 0 if filter matches
     * 6 - Set priority and store in FIFO 1 if filter matches
     * 7 - Store into Rx Buffer or as debug message, configuration of SFT[1:0] ignored
     */
    unsigned int sfec : 3;
    unsigned int sfid1 : 11;   /**< Standard Filter ID 1 */
    /**
     * Standard Sync Message
     * 0 - Timestamping for the matching Sync message disabled
     * 1 - Timestamping for the matching Sync message enabled
     */
    unsigned int ssync : 1;
    unsigned int res : 4;    /**< reserved */
    unsigned int sfid2 : 11; /**< Standard Filter ID 2 */
};

struct xid_filter_stru {
    /**
     * Extended Filter Element Configuration
     * 0 - Disable filter element
     * 1 - Store in Rx FIFO 0 if filter matches
     * 2 - Store in Rx FIFO 1 if filter matches
     * 3 - Reject ID if filter matches, not intended to be used with Sync messages
     * 4 - Set priority if filter matches, not intended to be used with Sync messages, no storage
     * 5 - Set priority and store in FIFO 0 if filter matches
     * 6 - Set priority and store in FIFO 1 if filter matches
     * 7 - Store into Rx Buffer or as debug message, configuration of EFT[1:0] ignored
     */
    unsigned int efec : 3;
    unsigned int efid1 : 29; /* Extended Filter ID 1 */
    /**
     * Extended Filter Type
     * 0 - Range filter from SFID1 to SFID2
     * 1 - Dual ID filter for SFID1 or SFID2
     * 2 - Classic filter: SFID1 = filter, SFID2 = mask
     * 3 - Range filter from EFID1 to EFID2 (EFID2 >= EFID1),, XIDAM mask not applied
     */
    unsigned int eft : 2;
    /**
     * Extended Sync Message
     * 0 - Timestamping for the matching Sync message disabled
     * 1 - Timestamping for the matching Sync message enabled
     */
    unsigned int esync : 1;
    unsigned int efid2 : 29; /* Extended Filter ID 2 */
};

struct global_filter_stru {
    /* reserved */
    unsigned int res : 26;
    /**
     * Accept Non-matching Frames Standard
     * 0 - Accept in Rx FIFO 0
     * 1 - Accept in Rx FIFO 1
     * 2 - Reject
     * 3 - Reject
     */
    unsigned int anfs : 2;
    /**
     * Accept Non-matching Frames Standard
     * 0 - Accept in Rx FIFO 0
     * 1 - Accept in Rx FIFO 1
     * 2 - Reject
     * 3 - Reject
     */
    unsigned int anfe : 2;
    /**
     * Reject Remote Frames Standard
     * 0 - Filter remote frames with 11-bit standard IDs
     * 1 - Reject all remote frames with 11-bit standard IDs
     */
    unsigned int rrfs : 1;
    /**
     * Reject Remote Frames Extended
     * 0 - Filter remote frames with 29-bit extended IDs
     * 1 - Reject all remote frames with 29-bit extended IDs
     */
    unsigned int rrfe : 1;
};

struct busoff_config_param {
    unsigned int busoff_quick;
    unsigned int busoff_slow;
    unsigned int busoff_quick_times;
    unsigned int busoff_report_threshold;
};

typedef enum {
    RX_FIFO_BLOCKING_MODE,
    RX_FIFO_OVERWRITE_MODE,
} DSMI_CAN_RX_FIFO_MODE;

typedef enum {
    TX_FIFO_OPERATION,
    TX_QUEUE_OPERATION,
} DSMI_CAN_TX_FIFO_QUEUE_MODE;

typedef struct  dsmi_can_config_stru {
    unsigned int element_num_rxf0;                          /**< Rx FIFO 0 quantity */
    unsigned int element_num_rxf1;                          /**< Rx FIFO 1 quantity */
    unsigned int element_num_rxb;                           /**< Rx Buffer quantity */
    unsigned int element_num_txef;                          /**< Tx Event FIFO quantity */
    unsigned int element_num_txb;                           /**< Tx Buffer quantity */
    unsigned int element_num_tmc;                           /**< Trigger Memory quantity */
    unsigned int tx_elmt_num_dedicated_buf;                 /**< Tx dedicated buf quantity */
    unsigned int tx_elmt_num_fifo_queue;                    /**< Tx FIFO/Queue quantity */
    unsigned int dsize_fifo0;                               /**< Rx FIFO 0 data size */
    unsigned int dsize_fifo1;                               /**< Rx FIFO 1 data size */
    unsigned int dsize_rxb;                                 /**< Rx Buffer data size */
    unsigned int dsize_txb;                                 /**< Tx Buffer data size */
    unsigned int watermark_rxf0;                            /**< Rx FIFO 0 watermark */
    unsigned int watermark_rxf1;                            /**< Rx FIFO 1 watermark */
    unsigned int watermark_txef;                            /**< Tx Event FIFO watermark */
    DSMI_CAN_RX_FIFO_MODE mode_rxf0;                        /**< Rx FIFO 0 work mode */
    DSMI_CAN_RX_FIFO_MODE mode_rxf1;                        /**< Rx FIFO 0 work mode */
    DSMI_CAN_TX_FIFO_QUEUE_MODE mode_txfq;                  /**< Tx Event FIFO work mode */
    unsigned int element_num_sidf;                          /**< Standard ID Filter quantity */
    unsigned int element_num_xidf;                          /**< Extended ID Filter quantity */
    struct global_filter_stru global_filter;                /**< Global Filter */
    unsigned int xid_and_mask;                              /**< Extended ID AND Mask */
    unsigned int echo_skb_max;                              /**< Local socket buffer quantity */
    unsigned int poll_weight;                               /**< napi poll weight */
    unsigned int ts_cnt_prescaler;                          /**< timestamp counter prescaler */
} DSMI_CAN_CONFIG_STRU;

typedef struct dsmi_can_tdc_cfg_stru {
    unsigned char tdc_flag; /**< TDC mode: 0-Auto adaptation config, 1-Disable TDC, 2-Enable TDC */
    unsigned char tdco; /**< Transmitter Delay Compensation SSP Offset, Configured only when tdc_mode=2 */
    unsigned char tdcf; /**< Transmitter Delay Compensation Filter Window Length, Configured only when tdc_mode=2 */
} DSMI_CAN_TDC_CFG_STRU;

typedef struct  dsmi_ufs_config_stru {
    DSMI_UFS_PWR_MODE pwr_mode;             /**< Link Rate Mode */
    DSMI_UFS_GEAR pwr_gear;                 /**< Link Rate */
    DSMI_UFS_HS_MODE hs_series;             /**< HS Series, Only query, not configuration */
    DSMI_UFS_PM_LEVEL suspend_pwr_level;    /**< HS Series, Only query, not configuration */
    unsigned int auto_h8;                   /**< enable autoH8: 0-disable, 1-enable */
    unsigned int lane_count;                /**< active lanes count */
    DSMI_UFS_DEV_CLOCK device_refclk;       /**< Reference Clock Frequency value, Only query, not configuration */
} DSMI_UFS_CONFIG_STRU;

#define DSMI_UFS_DEFAULT_KEY_NUM 8
#define INLINE_CRYPTO_RESERVED_LEN 4
typedef struct dsmi_ufs_partition_stru {
    unsigned int lun;
    unsigned int lba_start;
    unsigned int lba_end;
    unsigned int crypto_key_index;
    unsigned int reserved[INLINE_CRYPTO_RESERVED_LEN];
} DSMI_UFS_PARTITION_STRU;

typedef struct dsmi_ufs_inline_crypto_stru {
    unsigned int enable;
    DSMI_UFS_PARTITION_STRU partition[DSMI_UFS_DEFAULT_KEY_NUM];
    unsigned int partition_cnt;
} UFS_INLINE_CRYPTO_STRU;

typedef struct dsmi_ufs_key_index_stru {
    unsigned int key_index;
    unsigned int reserved[INLINE_CRYPTO_RESERVED_LEN];
} UFS_KEY_INDEX_STRU;

#define UFS_DESC_LEN 255
typedef struct dsmi_ufs_descriptor_stru {
    unsigned char automotive_health[UFS_DESC_LEN];
    unsigned char device_health[UFS_DESC_LEN];
    unsigned char device[UFS_DESC_LEN];
    unsigned char osv_report[UFS_DESC_LEN];
    unsigned char nand_info_report[UFS_DESC_LEN];
    unsigned char reserved[UFS_DESC_LEN];
} UFS_DESCRIPTOR_STRU;

#define __FSIN_INT_NUM 4
typedef struct dsmi_sensorhub_config_stru {
    unsigned int fsin_fps[__FSIN_INT_NUM];           /**< fsin0~3_thr frame rate value */
    unsigned int imu_fps;                            /**< imu0_thr frame rate value */
    unsigned int ssu_ctrl_ssu_en;                    /**< ssu enable,  */
    unsigned int ssu_ctrl_pps_sel;                   /**< pps resource select,  */
    unsigned int pps_lock_thr;                       /**< GPS pps lock threshold */
    unsigned int pps_lost_thr;                       /**< GPS pps lost threshold */
    unsigned int fsin_initial_pre[__FSIN_INT_NUM];   /**< fsin0~3 initial advance count to pps pulse */
    unsigned int imu0_initial_pre;                   /**< imu0 initial advance count to pps pulse */
    unsigned int ssu_normal_taishan_mask;            /**< mask of ssu normal irq to taishan */
    unsigned int ssu_normal_taishan_mask_2;          /**< mask of GPS PPS lost irq to taishan */
    unsigned int ssu_error_taishan_mask_1;           /**< mask of read/write error irq to taishan(expose mode) */
    unsigned int ssu_error_taishan_mask_2;           /**< mask of read/write error irq to taishan(strobe mode) */
    unsigned int ssu_path_en;                        /**< register to enable interrupt path */
    unsigned int fsin_pw[__FSIN_INT_NUM];            /**< fsin0~3 pulse width count per 5ns */
    unsigned int imu_pw;                             /**< imu0 pulse width count per 5ns */
    unsigned int inter_pps_thr;                      /**< pps pulse count per 5ns */
    unsigned int fsin_thr[__FSIN_INT_NUM];           /**< fsin0~3 pulse count per 5ns */
    unsigned int imu_thr;                            /**< imu0 pulse count per 5ns */
    unsigned int timestamp_check_en;                 /**< timestamp check enable */
} DSMI_SENSORHUB_CONFIG_INFO_STRU;

typedef enum {
    HISS_NOT_INITIALIZED,
    HISS_ERROR,
    HISS_OK
} ENUM_HISS_STATUS;

typedef enum {
    DSMI_UPGRADE_ATTR_SYNC,
    DSMI_UPGRADE_FIRMWARE_SYNC
} DSMI_UPGRADE_ATTR;

typedef struct  dsmi_hiss_status_stru {
    ENUM_HISS_STATUS hiss_status_code;
    unsigned long long hiss_status_info;
} DSMI_HISS_STATUS_STRU;

typedef struct dsmi_lp_status_stru {
    unsigned int status;
    unsigned long long status_info;
} DSMI_LP_STATUS_STRU;

/* DSMI main command for common interface */
typedef enum {
    DSMI_MAIN_CMD_DVPP = 0,
    DSMI_MAIN_CMD_ISP,
    DSMI_MAIN_CMD_TS_GROUP_NUM,
    DSMI_MAIN_CMD_CAN,
    DSMI_MAIN_CMD_UPGRADE = 5,
    DSMI_MAIN_CMD_UFS,
    DSMI_MAIN_CMD_OS_POWER,
    DSMI_MAIN_CMD_LP,
    DSMI_MAIN_CMD_MEMORY,
    DSMI_MAIN_CMD_RECOVERY,
    DSMI_MAIN_CMD_TS,
    DSMI_MAIN_CMD_CHIP_INF,
    DSMI_MAIN_CMD_QOS,
    DSMI_MAIN_CMD_SOC_INFO,
    DSMI_MAIN_CMD_SILS,
    DSMI_MAIN_CMD_HCCS,
    DSMI_MAIN_CMD_HOST_AICPU,
    DSMI_MAIN_CMD_TEMP = 50,
    DSMI_MAIN_CMD_SVM,
    DSMI_MAIN_CMD_VDEV_MNG,
    DSMI_MAIN_CMD_SEC,
    DSMI_MAIN_CMD_EMMC,
    DSMI_MAIN_CMD_PCIE,
    DSMI_MAIN_CMD_SIO,
    DSMI_MAIN_CMD_SERDES,
    DSMI_MAIN_CMD_LOG,
    DSMI_MAIN_CMD_P2P_COM,
    DSMI_MAIN_CMD_FLASH,
    DSMI_MAIN_CMD_TRS,
    DSMI_MAIN_CMD_UB,
    DSMI_MAIN_CMD_MAX,
} DSMI_MAIN_CMD;

/* DSMI sub command for HCCS module */
typedef enum {
    DSMI_HCCS_CMD_GET_STATUS = 0,
    DSMI_HCCS_CMD_GET_LANE_INFO,
    DSMI_HCCS_CMD_GET_PING_INFO,
    DSMI_HCCS_CMD_GET_STATISTIC_INFO,
    DSMI_HCCS_CMD_GET_CREDIT_INFO,
    DSMI_HCCS_CMD_GET_STATISTIC_INFO_EXT,
    DSMI_HCCS_SUB_CMD_MAX
} DSMI_HCCS_SUB_CMD;

#define DSMI_HCCS_STATUS_RESERVED_LEN 4
struct dsmi_hccs_status {
    unsigned int pcs_status;
    unsigned int hdlc_status;
    unsigned char reserve[DSMI_HCCS_STATUS_RESERVED_LEN];
};

#define DSMI_HCCS_MAX_PCS_NUM 16
struct dsmi_hccs_lane_info {
    unsigned int hccs_port_pcs_bitmap;
    unsigned int pcs_lane_bitmap[DSMI_HCCS_MAX_PCS_NUM];
    unsigned int reserve[DSMI_HCCS_MAX_PCS_NUM];
};
struct dsmi_hccs_statistic_info {
    unsigned int tx_cnt[DSMI_HCCS_MAX_PCS_NUM];
    unsigned int rx_cnt[DSMI_HCCS_MAX_PCS_NUM];
    unsigned int crc_err_cnt[DSMI_HCCS_MAX_PCS_NUM];
    unsigned int retry_cnt[DSMI_HCCS_MAX_PCS_NUM];
    unsigned int reserve[DSMI_HCCS_MAX_PCS_NUM * 3];
};

struct dsmi_hccs_statistic_info_ext {
    unsigned long long tx_cnt[DSMI_HCCS_MAX_PCS_NUM];
    unsigned long long rx_cnt[DSMI_HCCS_MAX_PCS_NUM];
    unsigned long long crc_err_cnt[DSMI_HCCS_MAX_PCS_NUM];
    unsigned long long retry_cnt[DSMI_HCCS_MAX_PCS_NUM];
    unsigned long long reserve[DSMI_HCCS_MAX_PCS_NUM * 3];
};

struct dsmi_hccs_credit_info {
    unsigned int credit_num[DSMI_HCCS_MAX_PCS_NUM];
    unsigned int reserve[DSMI_HCCS_MAX_PCS_NUM * 4];
};

/* DSMI sub command for RECOVERY module */
typedef enum {
    DSMI_RCVR_SUB_CMD_SET_FLAG = 0,
    DSMI_RCVR_SUB_CMD_GET_FLAG,
    DSMI_RCVR_SUB_CMD_CLEAN_FLAG,
    DSMI_RCVR_SUB_CMD_RESET_BOOT_CNT,
    DSMI_RCVR_SUB_CMD_SET_STATUS, // set recovery upgrade status.
    DSMI_RCVR_SUB_CMD_RELEASE_DATA,
} DSMI_RECOVERY_SUB_CMD;

/* DSMI sub command for PCIE module */
typedef enum {
    DSMI_PCIE_SUB_CMD_PCIE_INFO = 0,
    DSMI_PCIE_SUB_CMD_PCIE_LINK_ERROR_INFO,
    DSMI_PCIE_SUB_CMD_MAX,
} DSMI_PCIE_SUB_CMD;

typedef struct dsmi_pcie_link_error_info {
    unsigned int tx_err_cnt;
    unsigned int rx_err_cnt;
    unsigned int lcrc_err_cnt;
    unsigned int ecrc_err_cnt;
    unsigned int retry_cnt;
    unsigned int rsv[11];
} DSMI_PCIE_LINK_ERROR_INFO;

/* DSMI sub command for CAN module */
typedef enum {
    DSMI_CAN_SUB_CMD_SID_FILTER = 0,
    DSMI_CAN_SUB_CMD_XID_FILTER,
    DSMI_CAN_SUB_CMD_RAM,
    DSMI_CAN_SUB_CMD_BUSOFF,
    DSMI_CAN_SUB_CMD_TDC,
    DSMI_CAN_SUB_CMD_MAX,
} DSMI_CAN_SUB_CMD;

/* DSMI sub command for SIO module */
typedef enum {
    DSMI_SIO_SUB_CMD_CRC_ERR_STATISTICS,
    DSMI_SIO_SUB_CMD_DFX_INFO,
    DSMI_SIO_SUB_CMD_MAX,
} DSMI_SIO_SUB_CMD;

/* DSMI sub command for SERDES module */
typedef enum {
    DSMI_SERDES_SUB_CMD_QUALITY_INFO,
    DSMI_SERDES_SUB_CMD_MAX,
} DSMI_SERDES_SUB_CMD;

/* DSMI sub command for UFS module */
typedef enum {
    DSMI_UFS_SUB_CMD_CONFIG = 0,
    DSMI_UFS_SUB_CMD_STATUS = 1,
    DSMI_UFS_SUB_CMD_INLINE_CRYPTO = 2,
    DSMI_UFS_SUB_CMD_CREATE_KEY = 3,
    DSMI_UFS_SUB_CMD_DELETE_KEY = 4,
    DSMI_UFS_SUB_CMD_QUERY_DESCRIPTOR = 5,
    DSMI_UFS_SUB_CMD_INVALID = 0xFF,
} DSMI_UFS_SUB_CMD;

/* DSMI sub os type def */
typedef enum {
    DSMI_SUB_OS_SD = 0,
    DSMI_SUB_OS_ALL = 0xFE,
    DSMI_SUB_OS_INVALID = 0xFF,
} DSMI_SUB_OS_TYPE;

/* DSMI sub command for safetyisland module */
typedef enum {
    DSMI_SILS_SUB_CMD_PMUWDG_DISABLE = 0,
    DSMI_SILS_SUB_CMD_PMUWDG_ENABLE = 1,
    DSMI_SILS_SUB_CMD_PMUWDG_STATUS = 2,
    DSMI_SILS_SUB_CMD_INVALID = 0xFF,
} DSMI_SILS_SUB_CMD;

typedef enum {
    P2P_COM_SUB_CMD_LINK_INFO = 0,
    P2P_COM_SUB_CMD_FORCE_LINKDOWN,
    P2P_COM_SUB_CMD_MAX,
} P2P_COM_SUB_CMD;

typedef enum {
    DSMI_FLASH_SUB_CMD_GET_ERASE_COUNT = 0,
    /* 1~15 reserved for erase count*/
    DSMI_FLASH_SUB_CMD_FW_WRITE_PROTECTION = 0x10,
    DSMI_FLASH_SUB_CMD_MAX,
} DSMI_FLASH_SUB_CMD;

/* DSMI sub command for os power module */
#define DSMI_OS_TYPE_OFFSET     24
#define DSMI_OS_TYPE_CFG_BIT    (0xff000000U)
#define DSMI_POWER_TYPE_CFG_BIT (0x00ffffffU)
#define DSMI_OS_SUB_CMD_MAKE(os_type, power_type) (((os_type) << \
    DSMI_OS_TYPE_OFFSET) | (power_type))

/* DSMI sub command for can module */
#define DSMI_CAN_CAN_INDEX_OFFSET 24
#define DSMI_CAN_SUB_CMD_MAKE(can_index, can_sub_cmd) (((can_index) << \
    DSMI_CAN_CAN_INDEX_OFFSET) | (can_sub_cmd))

/* DSMI sub command for sio module */
#define DSMI_SIO_SLLC_INDEX_OFFSET 24
#define DSMI_SIO_SUB_CMD_MAKE(sllc_index, sio_sub_cmd) (((sllc_index) << \
    DSMI_SIO_SLLC_INDEX_OFFSET) | (sio_sub_cmd))

/* DSMI sub command for DVPP module */
#define DSMI_SUB_CMD_DVPP_STATUS 0
#define DSMI_SUB_CMD_DVPP_VDEC_RATE 1
#define DSMI_SUB_CMD_DVPP_VPC_RATE 2
#define DSMI_SUB_CMD_DVPP_VENC_RATE 3
#define DSMI_SUB_CMD_DVPP_JPEGE_RATE 4
#define DSMI_SUB_CMD_DVPP_JPEGD_RATE 5

/* DSMI sub command for Low power  */
typedef enum {
    /* Obtain the AICORE voltage and current value from the low-power module. */
    DSMI_LP_SUB_CMD_AICORE_VOLTAGE_CURRENT = 0,
    /* Obtain the HYBIRD voltage and current value from the low-power module. */
    DSMI_LP_SUB_CMD_HYBIRD_VOLTAGE_CURRENT,
    /* Obtain the TAISHAN voltage and current value from the low-power module. */
    DSMI_LP_SUB_CMD_TAISHAN_VOLTAGE_CURRENT,
    /* Obtain the DDR voltage and current value from the low-power module. */
    DSMI_LP_SUB_CMD_DDR_VOLTAGE_CURRENT,
    DSMI_LP_SUB_CMD_ACG,
    DSMI_LP_SUB_CMD_STATUS,
    DSMI_LP_SUB_CMD_TOPS_DETAILS,
    DSMI_LP_SUB_CMD_SET_WORK_TOPS,
    DSMI_LP_SUB_CMD_GET_WORK_TOPS,
    DSMI_LP_SUB_CMD_AICORE_FREQREDUC_CAUSE,
    DSMI_LP_SUB_CMD_GET_POWER_INFO,
    DSMI_LP_SUB_CMD_SET_IDLE_SWITCH,
    DSMI_LP_SUB_CMD_SET_STRESS_TEST, // 2024-12-30 reserve
    DSMI_LP_SUB_CMD_GET_AIC_CPM,     // 2024-12-30 reserve
    DSMI_LP_SUB_CMD_GET_BUS_CPM,     // 2024-12-30 reserve
    DSMI_LP_SUB_CMD_FEATURE_SWITCH,

    DSMI_LP_SUB_CMD_INNER_START = 0x100,    // start here used for inner, not for product
    DSMI_LP_SUB_CMD_INNER_SET_STRESS_TEST,
    DSMI_LP_SUB_CMD_INNER_GET_AIC_CPM,
    DSMI_LP_SUB_CMD_INNER_GET_BUS_CPM,
    DSMI_LP_SUB_CMD_INNER_GET_STRESS_FREQ_VOLT,
    DSMI_LP_SUB_CMD_INNER_GET_TEMP_INFO,
    DSMI_LP_SUB_CMD_INNER_GET_AIC_INFO,
    DSMI_LP_SUB_CMD_INNER_GET_BUS_INFO,
    DSMI_LP_SUB_CMD_INNER_GET_HBM_INFO,
    DSMI_LP_SUB_CMD_MAX,
} DSMI_LP_SUB_CMD;

/* DSMI sub command for TS  */
typedef enum {
    DSMI_TS_SUB_CMD_AICORE_UTILIZATION_RATE = 0,  // Obtains the single-core usage of AI Core.
    DSMI_TS_SUB_CMD_VECTORCORE_UTILIZATION_RATE,  // Obtains the single-core usage of Vector Core.
    DSMI_TS_SUB_CMD_FFTS_TYPE, // Obtains the type of FFTS or FFTS+
    DSMI_TS_SUB_CMD_SET_FAULT_MASK,
    DSMI_TS_SUB_CMD_GET_FAULT_MASK,
    DSMI_TS_SUB_CMD_LAUNCH_AICORE_STL,
    DSMI_TS_SUB_CMD_AICORE_STL_STATUS,
    DSMI_TS_SUB_CMD_AIC_UTILIZATION_RATE_ASYN,
    DSMI_TS_SUB_CMD_AIV_UTILIZATION_RATE_ASYN,
    DSMI_TS_SUB_CMD_START_PERIOD_AICORE_STL,
    DSMI_TS_SUB_CMD_STOP_PERIOD_AICORE_STL,
    DSMI_TS_SUB_CMD_COMMON_MSG,
    DSMI_TS_SUB_CMD_MAX,
} DSMI_TS_SUB_CMD;

#define DSMI_TS_SAMPLE_START  0  // op_type: start sample core utilization
#define DSMI_TS_SAMPLE_END    1  // op_type: stop sample core utilization
#define DSMI_TS_SAMPLE_OP_RESV 3
typedef struct {
    unsigned char op_type;
    unsigned char resv[DSMI_TS_SAMPLE_OP_RESV];
} TS_UTILIZATION_OPT;

#define TS_UTILIZATION_UNIT_NUM 10U
#define CORE_UTIL_ARR_MAX_LEN  200U
typedef struct ts_utilization_rate_info {
    unsigned char single_core[TS_UTILIZATION_UNIT_NUM];
} TS_UTILIZATION_RATE;

typedef struct ts_utilization_block_info {
    unsigned int array_len;         // Core utilization array length setted by user
    unsigned int valid_core_num;    // Numbers of valid cores
    TS_UTILIZATION_RATE core_util_array[CORE_UTIL_ARR_MAX_LEN];  // Structure array which store the core utilization
} TS_UTILIZATION_BLOCK;

struct ts_stl_query_info {
unsigned char aic_num;
    unsigned char aic_status[0];  /* variable data length: the number of aic_status is aic_num */
};

struct ts_stl_launch_info {
    unsigned int timeout;
};

#define TSDRV_STL_PERIOD_MAX 4000U // unit: ms
#define TSDRV_STL_PERIOD_MIN 30U  // unit: ms

struct ts_stl_start_info {
    unsigned int period;
};

struct dsmi_ts_fault_mask_stru {
    unsigned int type;
    unsigned int mask_switch; /* 0: switch off; 1 switch on */
};

/* DSMI sub command for TEMP module */
#define DSMI_SUB_CMD_TEMP_DDR           0
#define DSMI_TEMP_SUB_CMD_DDR_THOLD     1
#define DSMI_TEMP_SUB_CMD_SOC_THOLD     2
#define DSMI_TEMP_SUB_CMD_SOC_MIN_THOLD 3

/* DSMI sub command for ISP module */
#define DSMI_ISP_CAMERA_INDEX_OFFSET 24
#define DSMI_ISP_SUB_CMD_MAKE(camera_index, isp_sub_cmd) (((camera_index) << \
    DSMI_ISP_CAMERA_INDEX_OFFSET) | (isp_sub_cmd))

#define DSMI_SUB_CMD_ISP_STATUS 0
#define DSMI_SUB_CMD_ISP_CAMERA_NAME 1
#define DSMI_SUB_CMD_ISP_CAMERA_TYPE 2
#define DSMI_SUB_CMD_ISP_CAMERA_BINOCULAR_TYPE 3
#define DSMI_SUB_CMD_ISP_CAMERA_FULLSIZE_WIDTH 4
#define DSMI_SUB_CMD_ISP_CAMERA_FULLSIZE_HEIGHT 5
#define DSMI_SUB_CMD_ISP_CAMERA_FOV 6
#define DSMI_SUB_CMD_ISP_CAMERA_CFA 7
#define DSMI_SUB_CMD_ISP_CAMERA_EXPOSURE_MODE 8
#define DSMI_SUB_CMD_ISP_CAMERA_RAWFORMAT 9

#define COMPUTE_GROUP_INFO_RES_NUM 5
#define AICORE_MASK_NUM            2

/* DSMI sub command for memory module */
#define DSMI_SUB_CMD_MEMORY_TYPE 0
#define DSMI_SUB_CMD_MEMORY_CAPACITY 1
#define DSMI_SUB_CMD_MEMORY_CHANNEL 2
#define DSMI_SUB_CMD_MEMORY_RANK_NUM 3
#define DSMI_SUB_CMD_MEMORY_ECC_ENABLE 4
#define DSMI_SUB_CMD_MEMORY_MANUFACTURES 5
#define DSMI_SUB_CMD_MEMORY_SINGLE_ECC_HW_ADDR 9
#define DSMI_SUB_CMD_MEMORY_MULTI_ECC_HW_ADDR 10
#define DSMI_SUB_CMD_MEMORY_SET_MATA_READ_ONCE 30
#define DSMI_SUB_CMD_MEMORY_GET_MATA_READ_ONCE 31
#define DSMI_SUB_CMD_SERVICE_MEMORY 32
#define DSMI_SUB_CMD_SYSTEM_MEMORY 33
#define DSMI_SUB_CMD_DDR_MEMORY 34
#define DSMI_SUB_CMD_HBM_MEMORY 35
#define DSMI_SUB_CMD_MEMORY_SET_HPAGE_RATIO 36
#define DSMI_SUB_CMD_MEMORY_GET_HPAGE_RATIO 37
#define DSMI_SUB_CMD_MEMORY_CLEAR_HUGE_PAGE 38

/* DSMI sub command for DSMI_DETECT_MAIN_CMD_MEMORY */
#define DSMI_DDR_SUB_CMD_KERNEL_MEMTEST 0
#define DSMI_DDR_SUB_CMD_DDR_EXMBIST 1
#define DSMI_DDR_SUB_CMD_CLEAR_FAULT_ADDR 2
#define DSMI_DDR_SUB_CMD_SET_FAULT_ADDR 3

#define DSMI_DDR_SUB_CMD_GET_KERNEL_MEMTEST_SWITCH 0
#define DSMI_DDR_SUB_CMD_GET_EXMBIST_SWITCH 1
#define DSMI_DDR_SUB_CMD_GET_CACHE_FAULT_INFO 2
#define DSMI_DDR_SUB_CMD_GET_FLASH_FAULT_INFO 3

struct dsmi_ddr_single_fault_addr_info {
    unsigned long long physical_addr;
    unsigned int size;
    unsigned int rank_id;
    unsigned int row;
    unsigned int col;
    unsigned int bank;
    unsigned int reserve;
};

#define DSMI_DDR_ADDR_INFO_MAX_LEN 32
struct dsmi_ddr_fault_addr_info {
    unsigned int total_addr_count;
    struct dsmi_ddr_single_fault_addr_info addr_info[DSMI_DDR_ADDR_INFO_MAX_LEN];
};


#define DSMI_MEMORY_RESERVE_LEN 38
struct dsmi_memory_info {
    unsigned int total_size;
    unsigned int used_size;
    char reserve[DSMI_MEMORY_RESERVE_LEN];
};

/* DSMI sub QOS info def */
typedef enum {
    DSMI_QOS_SUB_MATA_CONFIG,
    DSMI_QOS_SUB_MASTER_CONFIG,
    DSMI_QOS_SUB_BW_DATA,
    DSMI_QOS_SUB_GLOBAL_CONFIG,
    DSMI_QOS_SUB_CONFIG_DONE,
    DSMI_QOS_SUB_ALLOW_CONFIG,
    DSMI_QOS_SUB_OTSD_CONFIG,
    DSMI_QOS_SUB_DMC_CONFIG,
    DSMI_QOS_SUB_UB_SL_CONFIG,
} DSMI_QOS_SUB_INFO;

/* DSMI sub command for qos module */
#define DSMI_QOS_INDEX_OFFSET 8
#define DSMI_QOS_SUB_CMD_MAKE(qos_index, qos_sub_cmd) (((qos_index) << \
    DSMI_QOS_INDEX_OFFSET) | (qos_sub_cmd))
#define DSMI_QOS_MAIN_INDEX_OFFSET  8U
#define DSMI_QOS_SUB_INDEX_OFFSET   16U
#define DSMI_QOS_THIRD_INDEX_OFFSET 24U
#define DSMI_QOS_INDEX_LEN          8U
#define DSMI_QOS_METHOD_LEN         4U

#define DSMI_QOS_SUB_CMD_MAKE_V2(qos_main_index, qos_sub_index, qos_third_index, qos_sub_cmd) ( \
    (((qos_main_index) & ((1U << DSMI_QOS_INDEX_LEN) - 1U)) << DSMI_QOS_MAIN_INDEX_OFFSET) | \
    (((qos_sub_index) & ((1U << DSMI_QOS_INDEX_LEN) - 1U)) << DSMI_QOS_SUB_INDEX_OFFSET) | \
    (((qos_third_index) & ((1U << DSMI_QOS_INDEX_LEN) - 1U)) << DSMI_QOS_THIRD_INDEX_OFFSET) | (qos_sub_cmd))
#define DSMI_QOS_SUB_CMD_MAKE_V3(qos_main_index, qos_method, qos_sub_cmd) ( \
    (((qos_main_index) & ((1U << DSMI_QOS_INDEX_LEN) - 1U)) << DSMI_QOS_MAIN_INDEX_OFFSET) | \
    (((qos_method) & ((1U << DSMI_QOS_METHOD_LEN) - 1U)) << DSMI_QOS_SUB_INDEX_OFFSET)  | (qos_sub_cmd))   
/* DSMI sub command for DSMI_MAIN_CMD_SOC_INFO */
typedef enum {
    DSMI_SOC_INFO_SUB_CMD_DOMAIN_INFO = 0,
    DSMI_SOC_INFO_SUB_CMD_CUST_OP_ENHANCE = 1,
    DSMI_SOC_INFO_SUB_CMD_MAX,
} DSMI_SOC_INFO_SUB_CMD;

/* DSMI sub command for DSMI_MAIN_CMD_SEC */
#define DSMI_SEC_SUB_CMD_PSS 0
#define DSMI_SEC_SUB_CMD_CC 1
#define DSMI_SEC_SUB_CMD_CUST_SIGN_FLAG 2
#define DSMI_SEC_SUB_CMD_CUST_SIGN_VENDOR_CERT 3
#define DSMI_SEC_SUB_CMD_CUST_SIGN_USER_CERT 4

#define PKCS_SIGN_TYPE_OFF  1
#define PKCS_SIGN_TYPE_ON   0

/**
 * Enum for signature verification flag types
 * 0: Disable verification, no signature check.
 * 1: Huawei certificate only, use Huawei certificate to verify.
 * 2: User certificate only, use user certificate to verify.
 * 3: Huawei certificate | User certificate, first use Huawei certificate then use user certificate to verify.
 */
typedef enum {
    SIGN_FLAG_DISABLED = 0,       
    SIGN_FLAG_HUAWEI_ONLY = 1,    
    SIGN_FLAG_USER_ONLY = 2,       
    SIGN_FLAG_HUAWEI_THEN_USER = 3,
    SIGN_FLAG_MAX
} SIGN_FLAG_TYPE;
 

struct dsmi_domain_info {
    int ai_cpu_num;
    int ctrl_cpu_num;
    int data_cpu_num;
    int ai_core_num;
    int vector_core_num;
    int reserve[8];
};

/* dsmi ts identifier for get ts group info */
typedef enum {
    DSMI_TS_AICORE = 0,
    DSMI_TS_AIVECTOR,
}DSMI_TS_ID;

/* DSMI sub CHIP info CMD def */
typedef enum {
    DSMI_CHIP_INF_SUB_CMD_CHIP_ID,
    DSMI_CHIP_INF_SUB_CMD_SPOD_INFO,
    DSMI_CHIP_INF_SUB_CMD_SPOD_NODE_STATUS,
    DSMI_CHIP_INF_SUB_CMD_CUST_BOARD_INF,
    DSMI_CHIP_INF_SUB_CMD_UUID,
    DSMI_CHIP_INF_SUB_CMD_MAX = 0xFF,
} DSMI_CHIP_INFO_SUB_CMD;

struct dsmi_capability_group_info {
    unsigned int  group_id;
    unsigned int  state;
    unsigned int  extend_attribute;
    unsigned int  aicore_number;
    unsigned int  aivector_number;
    unsigned int  sdma_number;
    unsigned int  aicpu_number;
    unsigned int  active_sq_number;
    unsigned int  aicore_mask[AICORE_MASK_NUM];
    unsigned int  vfid;
    unsigned int  poolid;
    unsigned int  poolid_max;
    unsigned int  res[COMPUTE_GROUP_INFO_RES_NUM - AICORE_MASK_NUM];
};

struct dsmi_ecc_pages_stru {
    unsigned int corrected_ecc_errors_aggregate_total;
    unsigned int uncorrected_ecc_errors_aggregate_total;
    unsigned int isolated_pages_single_bit_error;
    unsigned int isolated_pages_double_bit_error;
};

#define DSMI_MAX_VDEV_NUM 16 /**< max number a device can spilts */
#define DSMI_MAX_SPEC_RESERVE 8

#define DSMI_VDEV_RES_NAME_LEN 16
#define DSMI_VDEV_FOR_RESERVE 32
#define DSMI_VDEV_RESULT_RESERVE 28
#define DSMI_SOC_SPLIT_MAX 32
#define DSMI_UINT_SIZE sizeof(unsigned int)

struct dsmi_base_resource {
    unsigned long long token;
    unsigned long long token_max;
    unsigned long long task_timeout;
    unsigned int vfg_id;
    unsigned char vip_mode;
    unsigned char reserved[DSMI_VDEV_FOR_RESERVE - 1];  /* bytes aligned */
};

/* total types of computing resource */
struct dsmi_computing_resource {
    /* accelator resource */
    float aic;
    float aiv;
    unsigned short dsa;
    unsigned short rtsq;
    unsigned short acsq;
    unsigned short cdqm;
    unsigned short c_core;
    unsigned short ffts;
    unsigned short sdma;
    unsigned short pcie_dma;

    /* memory resource, MB as unit */
    unsigned long long memory_size;

    /* id resource */
    unsigned int event_id;
    unsigned int notify_id;
    unsigned int stream_id;
    unsigned int model_id;

    /* cpu resource */
    unsigned short topic_schedule_aicpu;
    unsigned short host_ctrl_cpu;
    unsigned short host_aicpu;
    unsigned short device_aicpu;
    unsigned short topic_ctrl_cpu_slot;

    /* vdev info */
    unsigned int vdev_aicore_utilization;

    unsigned char reserved[DSMI_VDEV_FOR_RESERVE - (int)DSMI_UINT_SIZE];
};

/* configurable computing resource */
struct dsmi_computing_configurable {
    /* memory resource, MB as unit */
    unsigned long long memory_size;

    /* accelator resource */
    float aic;
    float aiv;
    unsigned short dsa;
    unsigned short rtsq;
    unsigned short cdqm;

    /* cpu resource */
    unsigned short topic_schedule_aicpu;
    unsigned short host_ctrl_cpu;
    unsigned short host_aicpu;
    unsigned short device_aicpu;

    unsigned char reserved[DSMI_VDEV_FOR_RESERVE];
};

struct dsmi_media_resource {
    /* dvpp resource */
    float jpegd;
    float jpege;
    float vpc;
    float vdec;
    float pngd;
    float venc;
    unsigned char reserved[DSMI_VDEV_FOR_RESERVE];
};

struct dsmi_create_vdev_res_stru {
    char name[DSMI_VDEV_RES_NAME_LEN];
    struct dsmi_base_resource base;
    struct dsmi_computing_configurable computing;
    struct dsmi_media_resource media;
};

struct dsmi_create_vdev_result {
    unsigned int vdev_id;
    unsigned int pcie_bus;
    unsigned int pcie_device;
    unsigned int pcie_func;
    unsigned int vfg_id;
    unsigned int vf_id;
    unsigned char reserved[DSMI_VDEV_RESULT_RESERVE];
};

struct dsmi_vdev_query_info {
    char name[DSMI_VDEV_RES_NAME_LEN];
    unsigned int status;
    unsigned int is_container_used;
    unsigned int vfid;
    unsigned int reserved; /* There was a redundant member before and reserved is for compatibleness. */
    unsigned long long container_id;
    struct dsmi_base_resource base;
    struct dsmi_computing_resource computing;
    struct dsmi_media_resource media;
};

/* for single search */
struct dsmi_vdev_query_stru {
    unsigned int vdev_id;
    struct dsmi_vdev_query_info query_info;
};

struct dsmi_soc_free_resource {
    unsigned int vfg_num;
    unsigned int vfg_bitmap;
    struct dsmi_base_resource base;
    struct dsmi_computing_resource computing;
    struct dsmi_media_resource media;
};

struct dsmi_soc_total_resource {
    unsigned int vdev_num;
    unsigned int vdev_id[DSMI_SOC_SPLIT_MAX];
    unsigned int vfg_num;
    unsigned int vfg_bitmap;
    struct dsmi_base_resource base;
    struct dsmi_computing_resource computing;
    struct dsmi_media_resource media;
};

/* for compute group ratio */
struct dsmi_soc_vdev_ratio {
    unsigned int vdev_id;
    unsigned int ratio;
};

typedef enum {
    DSMI_SET_VDEV_CONVERT_LEN = 0,
    DSMI_GET_VDEV_CONVERT_LEN,
    DSMI_SVM_SUB_CMD_MAX,
} DSMI_SVM_SUB_CMD;

enum dsmi_owner_type {
    DSMI_DEV_RESOURCE = 0,
    DSMI_VDEV_RESOURCE,
    DSMI_PROCESS_RESOURCE,
    DSMI_MAX_OWNER_TYPE,
};

enum dsmi_dev_resource_type {
    DSMI_DEV_STREAM_ID = 0,
    DSMI_DEV_EVENT_ID,
    DSMI_DEV_NOTIFY_ID,
    DSMI_DEV_MODEL_ID,
    DSMI_DEV_HBM_TOTAL,
    DSMI_DEV_HBM_FREE,
    DSMI_DEV_DDR_TOTAL,
    DSMI_DEV_DDR_FREE,
    DSMI_DEV_PROCESS_PID,
    DSMI_DEV_PROCESS_MEM,
    DSMI_DEV_INFO_TYPE_MAX,
};

#define DSMI_RESOURCR_PARA_RESERVE_MAX 8
struct dsmi_resource_para {
    unsigned int owner_type;         /**< the owner of resource */
    unsigned int owner_id;           /**< the owner id */
    unsigned int resource_type;
    unsigned int tsid;
    unsigned int reserve[DSMI_RESOURCR_PARA_RESERVE_MAX];         /**< reserve */
};

#define DSMI_RESOURCE_INFO_RESERVE_MAX 8

struct dsmi_resource_info {
    unsigned int buf_len;            /**< the buffer size */
    void *buf;                       /**< return buffer */
    unsigned int reserve[DSMI_RESOURCE_INFO_RESERVE_MAX];         /**< reserve */
};

/* DSMI sub vdev mng CMD def */
typedef enum {
    DSMI_VMNG_SUB_CMD_GET_VDEV_RESOURCE,
    DSMI_VMNG_SUB_CMD_GET_TOTAL_RESOURCE,
    DSMI_VMNG_SUB_CMD_GET_FREE_RESOURCE,
    DSMI_VMNG_SUB_CMD_SET_SRIOV_SWITCH,
    DSMI_VMNG_SUB_CMD_GET_TOPS_PERCENTAGE,
    DSMI_VMNG_SUB_CMD_GET_VDEV_ACTIVITY,
    DSMI_VMNG_SUB_CMD_MAX,
} DSMI_VDEV_MNG_SUB_CMD;

#define DMS_MAX_EVENT_NAME_LENGTH 256
#define DMS_MAX_EVENT_DATA_LENGTH 32
#define DMS_MAX_EVENT_RESV_LENGTH 32

#define DMS_MAX_EVENT_SRC_LENGTH 32
#define DMS_MAX_EVENT_OBJ_LENGTH 256

#define DSMI_EVENT_FILTER_FLAG_EVENT_ID (1UL << 0)
#define DSMI_EVENT_FILTER_FLAG_SERVERITY (1UL << 1)
#define DSMI_EVENT_FILTER_FLAG_NODE_TYPE (1UL << 2)

struct dsmi_event_filter {
    unsigned long long filter_flag;
    unsigned int event_id;
    unsigned char severity;
    unsigned char node_type;

    unsigned char resv[DMS_MAX_EVENT_RESV_LENGTH]; /**< reserve 32byte */
};

struct dms_fault_event {
    unsigned int event_id;
    unsigned short deviceid;
    unsigned char node_type;
    unsigned char node_id;
    unsigned char sub_node_type;
    unsigned char sub_node_id;
    unsigned char severity;
    unsigned char assertion;
    int event_serial_num;
    int notify_serial_num;
    unsigned long long alarm_raised_time;
    char event_name[DMS_MAX_EVENT_NAME_LENGTH];
    char additional_info[DMS_MAX_EVENT_DATA_LENGTH];

    unsigned char os_id;
    unsigned char resv_1[1]; /* reserve 1 byte for byte alignment */
    unsigned short node_type_ex;
    unsigned short sub_node_type_ex;
    unsigned char resv_2[2]; /* reserve 2 byte for byte alignment */

    /* os_id occupy 1byte, node_type_ex,sub_node_type_ex occupy 7byte, reserve 24byte */
    unsigned char resv[DMS_MAX_EVENT_RESV_LENGTH - 8];
};

struct sec_event_info {
    unsigned int event_id;
    unsigned short deviceid;
    unsigned char node_type;
    unsigned char node_id;
    unsigned char sub_node_type;
    unsigned char sub_node_id;
    unsigned char severity;
    unsigned char assertion;
    int event_serial_num;
    int notify_serial_num;
    unsigned long long alarm_raised_time;
    char eventSrc[DMS_MAX_EVENT_SRC_LENGTH];
    char eventObj[DMS_MAX_EVENT_OBJ_LENGTH];
    unsigned int count;
    unsigned char os_id;
    unsigned char resv[DMS_MAX_EVENT_RESV_LENGTH - 5]; /**< count occupy 4byte, os_id occupy 1byte, reserved 27byte*/
};

enum dsmi_event_type {
    DMS_FAULT_EVENT = 0,
    DMS_SEC_EVENT,
    DSMI_EVENT_TYPE_MAX
};

struct dsmi_event {
    enum dsmi_event_type type;
    union {
        struct dms_fault_event dms_event;
        struct sec_event_info sec_event;
    } event_t;
};

#define QOS_TARGET_NUM_MAX 16U
#define QOS_CFG_RESERVED_LEN 8
struct qos_bw_config {
    unsigned char mode;
    unsigned char state;
    unsigned char cnt;
    unsigned char method;
    unsigned int interval;
    unsigned int target_set[QOS_TARGET_NUM_MAX];
    int reserved_1[QOS_CFG_RESERVED_LEN];
};

struct qos_bw_result {
    int mpamid;
    unsigned int curr;
    unsigned int bw_max;
    unsigned int bw_min;
    unsigned int bw_mean;
    int curr_method; /* -1 - not start, 0 - dha/mata, 1 - dmc */
    int reserved[QOS_CFG_RESERVED_LEN - 1];
};

#define QOS_MPAM_NAME_MAX_LEN 16

struct qos_mata_config {
    int mpamid;
    unsigned int bw_high;
    unsigned int bw_low;
    int hardlimit;
    int priority;
    unsigned int bw_adapt_en;
    unsigned int bw_adapt_level;
    char name[QOS_MPAM_NAME_MAX_LEN];
    unsigned int reserved[QOS_CFG_RESERVED_LEN - 7];
};

struct qos_master_config {
    int master;
    int mpamid;
    int qos;
    int pmg;
    unsigned long long bitmap[4]; /* max support 64 * 4  */
    unsigned int mode; /* 0 -- regs vaild, 1 -- smmu vaild, 2 -- sqe vaild */
    int reserved[QOS_CFG_RESERVED_LEN - 1];
};

struct qos_gbl_config {
    unsigned int enable;
    unsigned int autoqos_fuse_en;         /* 0--enable, 1--disable */
    unsigned int mpamqos_fuse_mode;       /* 0--average, 1--max, 2--replace */
    unsigned int mpam_subtype;            /* 0--all, 1--wr, 2--rd, 3--none */
    unsigned int lqos_retry_start_thres;  /* 0 is invaild */
    unsigned int lqos_retry_stop_thres;   /* 0 is invaild */
    int reserved[QOS_CFG_RESERVED_LEN - 2];
};

#define MAX_OTSD_LEVEL 2
struct qos_otsd_config {
    unsigned int master;
    unsigned int otsd_mode; /* 0 -- disable otsd limit, 1 -- read & write merge, 2 -- read & write not merge */
    unsigned int otsd_lvl[MAX_OTSD_LEVEL];
    int reserved[QOS_CFG_RESERVED_LEN];
    unsigned long long bitmap[4]; /* max support 64 * 4 */
};

#define MAX_QOS_ALLOW_LEVEL 3
struct qos_allow_config {
    unsigned int master;
    unsigned int qos_allow_mode;        /* 0 -- disable bp, 1 -- produce bp, 2 -- response bp */
    unsigned int qos_allow_ctrl;        /* 0 -- Don't care, 1 -- read, 2 -- write */
    unsigned int qos_allow_threshold;
    unsigned int qos_allow_windows;
    unsigned int qos_allow_saturation;
    unsigned int qos_allow_lvl[MAX_QOS_ALLOW_LEVEL];
    int reserved[QOS_CFG_RESERVED_LEN];
    unsigned long long bitmap[4];       /* max support 64 * 4 */
};
struct qos_dmc_config {
    unsigned int target;             /* mpamid or qos, according to matching_mode */
    unsigned int matching_mode;      /* 0 matching mpamid, 1 matching qos */
    unsigned int timeout;
    unsigned int adpt;
    unsigned int reserved[QOS_CFG_RESERVED_LEN];
};

#define QOS_UB_SL_NUM_MAX 16
struct qos_ub_sl_config {
	unsigned int mode;              /* UB-TM or ETS */
	unsigned int fe_idx;            /* FE index */
	unsigned int port_bitmap;       /* port bitmap: most 18 ports */
	unsigned int sl_num;
	unsigned char sl_list[QOS_UB_SL_NUM_MAX];   // sl id list
	unsigned char sl_bw[QOS_UB_SL_NUM_MAX];     // sl bw weight(percent)
	unsigned char sl_mode[QOS_UB_SL_NUM_MAX];   // sl sched mode(SP | DWRR)
	unsigned int reserved[QOS_CFG_RESERVED_LEN];
};

#define BIST_MODE_RESERVED_LEN  6
typedef enum {
    SUSPEND_FLAG,
    RESUME_FLAG,
    MAX_BIST_FLAG
} BIST_POWER_FLAG;

typedef struct dsmi_bist_mode_stru {
    unsigned int seconds;
    BIST_POWER_FLAG bist_flag;
    unsigned int start_vector_id;
    int reserved[BIST_MODE_RESERVED_LEN];
} DSMI_BIST_MODE_STRU;

typedef enum {
    POWER_ON_BIST,
    LOGIC_BIST,
    MEM_BIST,
    MAX_BIST_TYPE
} BIST_TYPE;

#define BIST_INFO_RESERVED_LEN 10
typedef struct dsmi_bist_info {
    unsigned int bist_result;
    unsigned int error_code;
    unsigned int vector_tested_cnt;
    unsigned int vector_sum;
    unsigned int vector_failed_id;
    unsigned int vector_failed_cnt;
    unsigned int reserved[BIST_INFO_RESERVED_LEN];
} DSMI_BIST_INFO;

typedef struct dsmi_bist_result_stru {
    unsigned int bist_result;
    unsigned int failed_vector_id;
    unsigned int tested_vector_cnt;
    DSMI_BIST_INFO bist_info[MAX_BIST_TYPE];
} DSMI_BIST_RESULT_STRU;

#define NODE_BIST_MODE_RESERVED_LEN  6
typedef struct dsmi_node_bist_mode {
    unsigned int enable;
    int type;                
    int reserved[NODE_BIST_MODE_RESERVED_LEN];
} DSMI_NODE_BIST_MODE;

#define NODE_BIST_RESULT_MAX_ERROR_TYPE  32
#define NODE_BIST_RESULT_RESERVED_LEN  8
typedef struct dsmi_node_bist_result {
    unsigned int bist_result;
    unsigned int failed_node_cnt;
    struct dsmi_node_bist_info {
        unsigned int node_type;
        unsigned long long result_mask;
        char rsv[NODE_BIST_RESULT_RESERVED_LEN];
    } info[NODE_BIST_RESULT_MAX_ERROR_TYPE];
    char rsv[NODE_BIST_RESULT_RESERVED_LEN];
} DSMI_BIST_NODE_RESULT;

typedef enum {
    DSMI_BIST_CMD_GET_RSLT = 0,
    DSMI_BIST_CMD_SET_MODE,
    DSMI_BIST_CMD_GET_VEC_CNT,
    DSMI_BIST_CMD_GET_VEC_TIME,
    DSMI_BIST_CMD_SET_MBIST_MODE,
    DSMI_BIST_CMD_GET_MBIST_RESULT,
    DSMI_BIST_CMD_MAX
} DSMI_BIST_CMD;

typedef void (*fault_event_callback)(struct dsmi_event *event);

#define DSMI_HOST_AICPU_BITMAP_LEN 8 /* (Maximum core num:512) / sizeof(unsigned long long) */
#define DSMI_HOST_AICPU_THREAD_MODE 0
#define DSMI_HOST_AICPU_PROCESS_MODE 1
#define DSMI_HOST_AICPU_RESERVED_LEN 16
struct dsmi_host_aicpu_info {
    unsigned int num;
    unsigned long long bitmap[DSMI_HOST_AICPU_BITMAP_LEN];
    unsigned int work_mode; /* thread or process */
    unsigned char reserved[DSMI_HOST_AICPU_RESERVED_LEN]; /* reserved data must be set to 0 */
};

struct dsmi_spod_info {
    unsigned int sdid;
    unsigned int scale_type;
    unsigned int super_pod_id;
    unsigned int server_id;
    unsigned int chassis_id;
    unsigned int super_pod_type;
    unsigned int reserve[6];
};

typedef enum {
    DSMI_SPOD_NODE_STATUS_NORMAL = 0,
    DSMI_SPOD_NODE_STATUS_ABNORMAL,
    DSMI_SPOD_NODE_STATUS_MAX
} DSMI_SPOD_NODE_STATUS;

struct dsmi_spod_node_status {
    unsigned int sdid;
    DSMI_SPOD_NODE_STATUS status;
};

struct dsmi_sio_crc_err_statistics_info {
    unsigned short tx_error_count;
    unsigned short rx_error_count;
    unsigned char reserved[8];
};

struct dsmi_sio_dfx_info {
    unsigned long long rx_ecc_count;
    unsigned int reserve[16];
};

#define SERDES_RESERVED_LEN 64
#define SERDES_MAX_LANE_NUM 8
typedef struct dsmi_serdes_quality_base {
    unsigned int snr;
    unsigned int heh;
    signed int bottom;
    signed int top;
    signed int left;
    signed int right;
} DSMI_SERDES_QUALITY_BASE;

typedef struct dsmi_serdes_quality_info {
    unsigned int macro_id;
    unsigned int reserved1;     /* reserve for byte alignment */
    struct dsmi_serdes_quality_base serdes_quality_info[SERDES_MAX_LANE_NUM];
    unsigned int reserved2[SERDES_RESERVED_LEN];
} DSMI_SERDES_QUALITY_INFO;

typedef enum {
    DSMI_SUB_CMD_HOST_AICPU_INFO = 0,
} DSMI_HOST_AICPU_SUB_CMD;

#define POWER_INFO_RESERVE_LEN 8
typedef enum {
    DSMI_DTM_OPCODE_GET_INFO_LIST = 0,
    DSMI_DTM_OPCODE_GET_STATE,
    DSMI_DTM_OPCODE_GET_CAPACITY,
    DSMI_DTM_OPCODE_SET_POWER_STATE,
    DSMI_DTM_OPCODE_SCAN,
    DSMI_DTM_OPCODE_FAULT_DIAG,
    DSMI_DTM_OPCODE_EVENT_NOTIFY,
    DSMI_DTM_OPCODE_GET_LINK_STATE,
    DSMI_DTM_OPCODE_SET_LINK_STATE,
    DSMI_DTM_OPCODE_FAULT_INJECT,
    DSMI_DTM_OPCODE_ENABLE_DEVICE,
    DSMI_DTM_OPCODE_DISABLE_DEVICE,
    DSMI_DTM_OPCODE_SET_POWER_INFO,
    DSMI_DTM_OPCODE_GET_POWER_INFO,
    DSMI_DTM_OPCODE_MAX,
} DSMI_DTM_OPCODE;

struct dsmi_dtm_node_s {
    DMS_DEVICE_NODE_TYPE node_type;
    int node_id;
    unsigned int reserve[POWER_INFO_RESERVE_LEN];
};

typedef enum {
    DSMI_DTM_FREQSCALING = 0,
    DSMI_DTM_POWERGATINGEN,
    DSMI_DTM_CLOCKGATINGEN,
    DSMI_DTM_RESETEN,
    DSMI_DTM_DEVICE_STATUS,
    DSMI_DTM_MAXDEVOPSIDNUMS,
} DEV_POWER_OP_TYPE;

typedef union {
    unsigned int level;
    int flag;
} DEV_POWER_OP_VAL;

typedef struct {
    DEV_POWER_OP_TYPE op_type;
    DEV_POWER_OP_VAL op_val;
} DEVPOWER_OP;

typedef struct {
    void *in_buf;
    unsigned int in_size;
    void *out_buf;
    unsigned int out_size;
} IN_OUT_BUF;

typedef enum {
    DEV_DTM_POWER_CAPABILITY = 0,
    DEV_DTM_MAX,
} DEV_DTM_CAP;

#define DSMI_EID_INFO_LEN 16
#define DSMI_MAX_EID_PAIR_NUM 8
#define DSMI_MAX_DEVICE_REPLACE_TIMEOUT_SEC 120

union dsmi_urma_addr_info {
    unsigned char eid[DSMI_EID_INFO_LEN];
    struct {
        unsigned long long reserved;
        unsigned int prefix;
        unsigned int addr;
    } in4;
    struct {
        unsigned long long subnet_prefix;
        unsigned long long interface_id;
    } in6;
};

enum dsmi_urma_eid_type {
    DSMI_URMA_EID_TYPE = 0U, /* 128bit */
    DSMI_URMA_TYPE_MAX = 1U,
};

struct dsmi_eid_pair_info {
    union dsmi_urma_addr_info eid_local;
    union dsmi_urma_addr_info eid_remote;
    unsigned int default_eid_flag : 1;
    unsigned int resv : 31;
};

struct dsmi_device_attr {
    int phy_dev_id;
    unsigned int eid_num;
    struct dsmi_eid_pair_info eid_pair[DSMI_MAX_EID_PAIR_NUM];
    enum dsmi_urma_eid_type type;
    unsigned int reserve;
};

/* CC: confidential computing, crypto: cryptology */
enum dsmi_cc_mode_type {
    DSMI_CC_MODE_OFF = 0,
    DSMI_CC_MODE_NORMAL,
    DSMI_CC_MODE_ADDITIONAL,
    DSMI_CC_MODE_MAX,
};
enum dsmi_crypto_mode_type {
    DSMI_CRYPTO_MODE_OFF = 0,
    DSMI_CRYPTO_MODE_ON,
    DSMI_CRYPTO_MODE_MAX,
};

#define DSMI_CC_RESV_LEN 8
typedef struct {
    enum dsmi_cc_mode_type cc_mode; /* 0:cc off  1:cc normal  2:cc additional */
    enum dsmi_crypto_mode_type crypto_mode; /* 0:crypto off  1:crypto on */
    unsigned int resv[DSMI_CC_RESV_LEN];
} DSMI_CC_MODE;

typedef struct {
    DSMI_CC_MODE cc_running_info;
    DSMI_CC_MODE cc_cfg_info;
} DSMI_CC_INFO;

typedef enum {
    DSMI_PLATFORM_DEVICE_ENV = 0,
    DSMI_PLATFORM_HOST_ENV = 1
} DSMI_PLATFORM_INFO;

#define FLASH_ERASE_COUNT_LEN   (4*1024)
typedef struct dsmi_flash_erase_count {
    unsigned short erase_count[FLASH_ERASE_COUNT_LEN];
} DSMI_FLASH_ERASE_COUNT;

typedef enum {
    DSMI_TRS_SUB_CMD_KERNEL_LAUNCH_MODE = 0,
    DSMI_TRS_SUB_CMD_MAX,
} DSMI_TRS_SUB_CMD;

typedef enum {
    DSMI_TRS_KERNEL_LAUNCH_SECURITY = 0,
    DSMI_TRS_KERNEL_LAUNCH_HIGH_PERFORMANCE,
    DSMI_TRS_MODE_MAX,
} DSMI_TRS_CONFIG_MODE;

typedef struct dsmi_trs_config_stru {
    unsigned int ts_id;
    DSMI_TRS_CONFIG_MODE mode;
    unsigned char reserve[16];
} DSMI_TRS_CONFIG_STRU;

/* DSMI sub command for UB module */
typedef enum {
    DSMI_UB_INFO_SUB_CMD_PORT_STATUS = 0,
    DSMI_UB_INFO_SUB_CMD_MAX,
} DSMI_UB_SUB_CMD;

#define DSMI_UB_PORT_NUM 36
typedef enum {
    DSMI_UB_ALL_PORT_NO_LINK = 0,
    DSMI_UB_ALL_PORT_LINK,
    DSMI_UB_PARTIAL_PORT_LINK,
    DSMI_UB_NO_NEED_LINK,
} dsmi_entire_ub_status;    /* 0-2：actual link status, 3: link requirement*/

typedef enum {
    DSMI_UB_PORT_STATUS_NONE_LANE = 0,
    DSMI_UB_PORT_STATUS_FULL_LANE,
    DSMI_UB_PORT_STATUS_PARTIAL_LANE,
    DSMI_UB_PORT_STATUS_INITIAL
} dsmi_ub_port_status;

struct dsmi_ub_status {
    dsmi_entire_ub_status ub_link_status;
    dsmi_ub_port_status ub_port_status[DSMI_UB_PORT_NUM];
};

/**
* @ingroup driver
* @brief Get the specified elabel
* @attention NULL
* @param [in] device_id  The device id
* @param [in] item_type The elabel_data type
* @param [out] elabel_data  data
* @param [out] len  data length
* @return  0 for success, others for fail
* @note Support:Ascend310
*/
DLLEXPORT int dsmi_dft_get_elable(int device_id, int item_type, char *elable_data, int *len);

/**
* @ingroup driver
* @brief start upgrade
* @attention Support to upgrade one firmware of a device, or all upgradeable firmware of a device (the second
            parameter is set to 0xFFFFFFFF), Does not support upgrading all devices, implemented by upper
            layer encapsulation interface
* @param [in] device_id  The device id
* @param [in] component_type firmware type
* @param [in] file_name  the path of firmware
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_upgrade_start(int device_id, DSMI_COMPONENT_TYPE component_type, const char *file_name);

/**
* @ingroup driver
* @brief set upgrade attr
* @attention NULL
* @param [in] device_id  The device id
* @param [in] component_type firmware type
* @param [in] attr the upgrade attr
* @return  0 for success, others for fail
* @note Support:Ascend610,as31xm1,bs9sx1a,Ascend610Lite
*/
DLLEXPORT int dsmi_set_upgrade_attr(int device_id, DSMI_COMPONENT_TYPE component_type, DSMI_UPGRADE_ATTR attr);

/**
* @ingroup driver
* @brief get upgrade state
* @attention NULL
* @param [in] device_id  The device id
* @param [out] schedule  Upgrade progress
* @param [out] upgrade_status  Upgrade state
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_upgrade_get_state(int device_id, unsigned char *schedule, unsigned char *upgrade_status);

/**
* @ingroup driver
* @brief get the version of firmware
* @attention The address of the third parameter version number is applied by the user,
             the module only performs non-null check on it, and the size is guaranteed by the user
* @param [in] device_id  The device id
* @param [in] component_type firmware type
* @param [in] version_len the length of version_str
* @param [out] version_str  The space requested by the user stores the returned firmware version number
* @param [out] ret_len  The space requested by the user is used to store the effective character length
               of the version number
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_upgrade_get_component_static_version(int device_id, DSMI_COMPONENT_TYPE component_type,
    unsigned char *version_str, unsigned int version_len, unsigned int *ret_len);

/**
* @ingroup driver
* @brief Get the system version number
* @attention The address of the second parameter version number is applied by the user,
             the module only performs non-null check on it, and the size is guaranteed by the user
* @param [in] device_id  The device id
* @param [in] version_len  length of paramer version_str
* @param [out] version_str  User-applied space stores system version number
* @param [out] ret_len  The space requested by the user is used to store the effective
               length of the returned system version number
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_version(int device_id, char *version_str, unsigned int version_len, unsigned int *ret_len);

/**
* @ingroup driver
* @brief Obtains the number of components that can be upgraded, excluding the recovery component.
* @attention Get the number of firmware that can be support
* @param [in] device_id  The device id
* @param [out] component_count  The space requested by the user for storing the number of firmware returned
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_component_count(int device_id, unsigned int *component_count);


/**
* @ingroup driver
* @brief Obtains the list of components that can be upgraded, excluding the recovery component.
* @attention You need to invoke the dsmi_get_component_count interface to obtain the number of components
* that can be upgraded, and then invoke the dsmi_get_component_list interface to obtain the component list.
* @param [in] device_id  The device id
* @param [out] component_table  The space requested by the user is used to store the returned firmware list
* @param [in] component_count  The count of firmware
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_component_list(int device_id,
    DSMI_COMPONENT_TYPE *component_table, unsigned int component_count);

/**
* @ingroup driver
* @brief Get the number of devices
* @attention NULL
* @param [out] device_count  The space requested by the user is used to store the number of returned devices
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_device_count(int *device_count);

/**
* @ingroup driver
* @brief Get the number of devices
* @attention the devices can obtain from lspci command,not just the devices can obtain from device manager.
* @param [out] all_device_count  The space requested by the user is used to store the number of returned devices
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310P,Ascend910,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_all_device_count(int *all_device_count);

/**
* @ingroup driver
* @brief Get the id of online devices
* @attention NULL
* @param [out] device_id_list[] The device ID list of all devices is displayed.
* @param [in] count Number of equipment
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_list_device(int device_id_list[], int count);

/**
* @ingroup driver
* @brief Get the id of all devices
* @attention the devices can obtain from lspci command or mami management,not just the devices can obtain from device manager.
* @param [out] all_devices  The device ID list of all devices is displayed.
* @param [in] count number of equipment
* @return  0 for success, others for fail
* @note Support:Ascend310B,Ascend310P,Ascend910,Ascend910B,Ascend910_93,Ascend910_95
*/
DLLEXPORT int dsmi_list_all_device(int device_ids[], int count);

/**
* @ingroup driver
* @brief Start the container service
* @attention Cannot be used simultaneously with the computing power distribution mode
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend310P,Ascend910,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_enable_container_service(void);

/**
* @ingroup driver
* @brief Logical id to physical id
* @attention NULL
* @param [in] logicid logic id
* @param [out] phyid   physic id
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend310P,Ascend910,Ascend910B,Ascend910_93,Ascend610,as31xm1,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_phyid_from_logicid(unsigned int logicid, unsigned int *phyid);

/**
* @ingroup driver
* @brief physical id to Logical id
* @attention NULL
* @param [in] phyid   physical id
* @param [out] logicid logic id
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend310P,Ascend910,Ascend910B,Ascend910_93,Ascend610,as31xm1,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_logicid_from_phyid(unsigned int phyid, unsigned int *logicid);

/**
* @ingroup driver
* @brief Query the overall health status of the device, support AI Server
* @attention NULL
* @param [in] device_id  The device id
* @param [out] phealth  The pointer of the overall health status of the device only represents this component,
                        and does not include other components that have a logical relationship with this component.
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_device_health(int device_id, unsigned int *phealth);

/**
* @ingroup driver
* @brief Query device fault code
* @attention NULL
* @param [in] device_id  The device id
* @param [out] errorcount  Number of error codes
* @param [out] perrorcode  error codes
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend310P,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_device_errorcode(int device_id, int *errorcount, unsigned int *perrorcode);

/**
* @ingroup driver
* @brief Query the temperature of the ICE SOC of Shengteng AI processor
* @attention NULL
* @param [in] device_id  The device id
* @param [out] ptemperature  The temperature of the HiSilicon SOC of the Shengteng AI processor: unit Celsius,
                         the accuracy is 1 degree Celsius, and the decimal point is rounded. 16-bit signed type,
                         little endian. The value returned by the device is the actual temperature.
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite
*/
DLLEXPORT int dsmi_get_device_temperature(int device_id, int *ptemperature);

/**
* @ingroup driver
* @brief Query device power consumption
* @attention NULL
* @param [in] device_id  The device id
* @param [out] schedule  Device power consumption: unit is W, accuracy is 0.1W. 16-bit unsigned short type,
               little endian
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend310P,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_device_power_info(int device_id, struct dsmi_power_info_stru *pdevice_power_info);

/**
* @ingroup driver
* @brief Query PCIe device information
* @attention NULL
* @param [in] device_id  The device id
* @param [out] pcie_idinfo  PCIe device information
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend910,Ascend310P,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_pcie_info(int device_id, struct tag_pcie_idinfo *pcie_idinfo);

/**
* @ingroup driver
* @brief Query the voltage of Sheng AI SOC of ascend AI processor
* @attention NULL
* @param [in] device_id  The device id
* @param [out] pvoltage  The voltage of the HiSilicon SOC of the Shengteng AI processor: the unit is V,
                         and the accuracy is 0.01V
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_device_voltage(int device_id, unsigned int *pvoltage);

/**
* @ingroup driver
* @brief Get the occupancy rate of the HiSilicon SOC of the Ascension AI processor
* @attention NULL
* @param [in] device_id  The device id
* @param [in] device_type  device_type
* @param [out] putilization_rate  Utilization rate of HiSilicon SOC of ascend AI processor, unit:%
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_device_utilization_rate(int device_id, int device_type, unsigned int *putilization_rate);

/**
* @ingroup driver
* @brief Get the frequency of the HiSilicon SOC of the Ascension AI processor
* @attention NULL
* @param [in] device_id  The device id
* @param [in] device_type  device_type
* @param [out] pfrequency  Frequency, unit MHZ
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_device_frequency(int device_id, int device_type, unsigned int *pfrequency);

/**
* @ingroup driver
* @brief Get the number of Flash
* @attention NULL
* @param [in] device_id  The device id
* @param [out] pflash_count Returns the number of Flash, currently fixed at 1
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_device_flash_count(int device_id, unsigned int *pflash_count);

/**
* @ingroup driver
* @brief Get flash device information
* @attention NULL
* @param [in] device_id  The device id
* @param [in] flash_index Flash index number. The value is fixed at 0.
* @param [out] pflash_info Returns Flash device information.
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_device_flash_info(int device_id, unsigned int flash_index, dm_flash_info_stru *pflash_info);

/**
* @ingroup driver
* @brief Get memory information
* @attention NULL
* @param [in] device_id  The device id
* @param [out] pdevice_memory_info  Return memory information
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,bs9sx1a,Ascend610Lite
*/
DLLEXPORT int dsmi_get_memory_info(int device_id, struct dsmi_memory_info_stru *pdevice_memory_info);

/**
* @ingroup driver
* @brief Get ECC information
* @attention NULL
* @param [in] device_id  The device id
* @param [in] device_type  device type
* @param [out] pdevice_ecc_info  return ECC information
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_ecc_info(int device_id, int device_type, struct dsmi_ecc_info_stru *pdevice_ecc_info);

/**
* @ingroup driver
* @brief Message transfer interface implementation
* @attention NULL
* @param [in] device_id  The device id
* @param [out] passthru_message  passthru_message_stru struct
* @return  0 for success, others for fail
* @note Support:not support
*/
DLLEXPORT int dsmi_passthru_mcu(int device_id, struct passthru_message_stru *passthru_message);

/**
* @ingroup driver
* @brief Query device fault description
* @attention NULL
* @param [in] device_id  The device id
* @param [in] schedule  Error code to query
* @param [out] perrorinfo Corresponding error character description
* @param [out] buffsize The buff size brought in is fixed at 48 bytes. If the set buff size is greater
                        than 48 bytes, the default is 48 bytes
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend310P,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_query_errorstring(int device_id, unsigned int errorcode, unsigned char *perrorinfo, int buffsize);

/**
* @ingroup driver
* @brief Get board information, including board_id, pcb_id, bom_id, slot_id version numbers of the board
* @attention NULL
* @param [in] device_id  The device id
* @param [out] pboard_info  return board info
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_board_info(int device_id, struct dsmi_board_info_stru *pboard_info);

/**
* @ingroup driver
* @brief Get system time
* @attention NULL
* @param [in] device_id  The device id
* @param [out] ntime_stamp  the number of seconds from 00:00:00, January 1,1970.
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_system_time(int device_id, unsigned int *ntime_stamp);

/**
* @ingroup driver
* @brief config device ecc
* @attention NULL
* @param [in] device_id  The device id
* @param [in] device_type  the DSMI_DEVICE_TYPE.
* @param [in] enable_flag  Enabled Status , 1 means enabled, 0 means disabled.
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend310P
*/
DLLEXPORT int dsmi_config_ecc_enable(int device_id, DSMI_DEVICE_TYPE device_type, int enable_flag);

/**
* @ingroup driver
* @brief get ecc enable status
* @attention NULL
* @param [in] device_id  The device id
* @param [in] device_type  the DSMI_DEVICE_TYPE.
* @param [out] enable_flag  flag value.
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend310P
*/
DLLEXPORT int dsmi_get_ecc_enable(int device_id, DSMI_DEVICE_TYPE device_type, int *enable_flag);

/**
* @ingroup driver
* @brief Set the MAC address of the specified device
* @attention NULL
* @param [in] device_id  The device id
* @param [in] mac_id Specify MAC, value range: 0 ~ dsmi_get_mac_count interface output
* @param [in] pmac_addr Set a 6-byte MAC address.
* @param [in] mac_addr_len  MAC address length, fixed length 6, unit byte.
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend910,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_set_mac_addr(int device_id, int mac_id, const char *pmac_addr, unsigned int mac_addr_len);

/**
* @ingroup driver
* @brief Query the number of MAC addresses
* @attention NULL
* @param [in] device_id  The device id
* @param [out] count Query the MAC number, the value range: 0 ~ 4.
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend910,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_mac_count(int device_id, int *count);

/**
* @ingroup driver
* @brief Get the MAC address of the specified device
* @attention NULL
* @param [in] device_id  The device id
* @param [in] mac_id Specify MAC, value range: 0 ~ dsmi_get_mac_count interface output
* @param [out] pmac_addr return a 6-byte MAC address.
* @param [in] mac_addr_len  MAC address length, fixed length 6, unit byte.
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend910,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_mac_addr(int device_id, int mac_id, char *pmac_addr, unsigned int mac_addr_len);

/**
* @ingroup driver
* @brief Set the ip address and mask address.
* @attention NULL
* @param [in] device_id  The device id
* @param [in] port_type  Specify the network port type
* @param [in] port_id  Specify the network port number, reserved field
* @param [in] ip_address  ip address info wants to set
* @param [in] mask_address  mask address info wants to set
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_set_device_ip_address(int device_id,
    int port_type, int port_id, ip_addr_t ip_address, ip_addr_t mask_address);

/**
* @ingroup driver
* @brief get the ip address and mask address.
* @attention NULL
* @param [in] device_id  The device id
* @param [in] port_type  Specify the network port type
* @param [in] port_id  Specify the network port number, reserved field
* @param [in&out] ip_address  return ip address info
* @param [out] mask_address  return mask address info
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_device_ip_address(int device_id, int port_type, int port_id, ip_addr_t *ip_address,
    ip_addr_t *mask_address);

/**
* @ingroup driver
* @brief get device fan number
* @attention NULL
* @param [in] device_id  The device id
* @param [out] count  fan count.
* @return  0 for success, others for fail
* @note Support:Ascend310
*/
DLLEXPORT int dsmi_get_fan_count(int device_id, int *count);

/**
* @ingroup driver
* @brief get device fanspeed.
* @attention NULL
* @param [in] device_id  The device id
* @param [in] fan_id  Specify the fan port number,reserved field.
* @param [out] speed  fan speed
* @return  0 for success, others for fail
* @note Support:Ascend310
*/
DLLEXPORT int dsmi_get_fan_speed(int device_id, int fan_id, int *speed);

/**
* @ingroup driver
* @brief send pre reset to device soc.
* @attention NULL
* @param [in] device_id  The device id
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310P,Ascend310B,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_pre_reset_soc(int device_id);

/**
* @ingroup driver
* @brief send re scan soc.
* @attention NULL
* @param [in] device_id  The device id
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310P,Ascend310B,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_rescan_soc(int device_id);

/**
* @ingroup driver
* @brief Reset the HiSonic SOC of the designated Ascent AI processor
* @attention NULL
* @param [in] device_id  The device id
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310P,Ascend310B,Ascend910,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_hot_reset_soc(int device_id);

/**
* @ingroup driver
* @brief Get the startup state of the HiSilicon SOC of the Ascend AI processor
* @attention NULL
* @param [in] device_id  The device id
* @param [out] boot_status The startup state of the HiSilicon SOC of the Ascend AI processor
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend910,Ascend310P,Ascend310B,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_device_boot_status(int device_id, enum dsmi_boot_status *boot_status);

/**
* @ingroup driver
* @brief Relevant information about the HiSilicon SOC of the AI processor, including chip_type, chip_name,
         chip_ver version number
* @attention NULL
* @param [in] device_id  The device id
* @param [out] chip_info  Get the relevant information of ascend AI processor Hisilicon SOC
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_chip_info(int device_id, struct dsmi_chip_info_stru *chip_info);

/**
* @ingroup driver
* @brief Get SOC sensor information
* @attention NULL
* @param [in] device_id The device id
* @param [in] sensor_id Specify sensor index
* @param [out] tsensor_info Returns the value that needs to be obtained
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_soc_sensor_info(int device_id, int sensor_id, TAG_SENSOR_INFO *tsensor_info);

/**
* @ingroup driver
* @brief set the gateway address.
* @attention NULL
* @param [in] device_id  The device id
* @param [in] port_type  Specify the network port type
* @param [in] port_id  Specify the network port number, reserved field
* @param [in] gtw_address  the gateway address info wants to set.
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_set_gateway_addr(int device_id, int port_type, int port_id, ip_addr_t gtw_address);

/**
* @ingroup driver
* @brief Query the gateway address.
* @attention NULL
* @param [in] device_id  The device id
* @param [in] port_type  Specify the network port type
* @param [in] port_id  Specify the network port number, reserved field
* @param [in&out] gtw_address  return gateway address info
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_gateway_addr(int device_id, int port_type, int port_id, ip_addr_t *gtw_address);

/**
* @ingroup driver
* @brief  get mini I2C heartbeat for mini to mcu.
* @attention NULL
* @param [in] device_id  The device id
* @param [out] status  heartbeat status
* @param [out] disconn_cnt  Number of lost heartbeats: range: 0 to 9999
* @return  0 for success, others for fail
* @note Support:Ascend310
*/
DLLEXPORT int dsmi_get_mini2mcu_heartbeat_status(int device_id, unsigned char *status, unsigned int *disconn_cnt);

/**
* @ingroup driver
* @brief Queries the frequency, total capacity, used capacity, temperature, and usage of the hbm.
* @attention NULL
* @param [in] device_id  The device id
* @param [out] pdevice_hbm_info return hbm infomation
* @return  0 for success, others for fail
* @note Support:Ascend910,Ascend910B,Ascend910_93
*/
DLLEXPORT int dsmi_get_hbm_info(int device_id, struct dsmi_hbm_info_stru *pdevice_hbm_info);

/**
* @ingroup driver
* @brief Query the frequency information of aicore
* @attention NULL
* @param [in] device_id  The device id
* @param [out] pdevice_aicore_info  return aicore information
* @return  0 for success, others for fail
* @note Support:Ascend910,Ascend610,as31xm1,Ascend310P,Ascend310,Ascend310B,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_aicore_info(int device_id, struct dsmi_aicore_info_stru *pdevice_aicore_info);

/**
* @ingroup driver
* @brief Query the connectivity status of the RoCE network card's IP address
* @attention NULL
* @param [in] device_id The device id
* @param [out] presult return the result wants to query
* @return  0 for success, others for fail
* @note Support:Ascend910,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_network_health(int device_id, DSMI_NET_HEALTH_STATUS *presult);

/**
* @ingroup driver
* @brief Get the ID of the board
* @attention NULL
* @param [in] device_id The device id
* @param [out] board_id Board ID. In the AI Server scenario, the value is 0
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_board_id(int device_id, unsigned int *board_id);

/**
* @ingroup driver
* @brief Query LLC performance parameters, including LLC read hit rate, write hit rate, and throughput
* @attention NULL
* @param [in] device_id  The device id
* @param [out] perf_para  LLC performance parameter information, including LLC read hit rate,
                         write hit rate and throughput
* @return  0 for success, others for fail
* @note Support:Ascend910,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_llc_perf_para(int device_id, DSMI_LLC_PERF_INFO *perf_para);

/**
* @ingroup driver
* @brief Query the number, maximum operating frequency, current operating frequency and utilization rate of AICPU.
* @attention NULL
* @param [in] device_id  The device id
* @param [out] pdevice_aicpu_info  Indicates the number of AICPUs, maximum operating frequency,
*                                  current operating frequency, and usage.
* @return  0 for success, others for fail
* @note Support:Ascend910,Ascend610,as31xm1,Ascend310P,Ascend310B,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_aicpu_info(int device_id, struct dsmi_aicpu_info_stru *pdevice_aicpu_info);

/**
* @ingroup driver
* @brief get user configuration
* @attention NULL
* @param [in] device_id  The device id
* @param [in] config_name Configuration item name, the maximum string length of the
                          configuration item name is 32
* @param [in] buf_size buf length, the maximum length is 1024 byte
* @param [out] buf  buf pointer to the content of the configuration item
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_user_config(int device_id, const char *config_name, unsigned int buf_size, unsigned char *buf);

/**
* @ingroup driver
* @brief set user configuration
* @attention NULL
* @param [in] device_id  The device id
* @param [in] config_name Configuration item name, the maximum string length of the
                          configuration item name is 32
* @param [in] buf_size buf length, the maximum length is 1024 byte
* @param [in] buf  buf pointer to the content of the configuration item
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_set_user_config(int device_id, const char *config_name, unsigned int buf_size, unsigned char *buf);

/**
* @ingroup driver
* @brief clear user configuration
* @attention NULL
* @param [in] device_id  The device id
* @param [in] config_name Configuration item name, the maximum string length of the
                          configuration item name is 32
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_clear_user_config(int device_id, const char *config_name);

/**
* @ingroup driver
* @brief Get the DIE ID of the specified device
* @attention NULL
* @param [in] device_id  The device id
* @param [out] pdevice_die  return die id infomation
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_device_die(int device_id, struct dsmi_soc_die_stru *pdevice_die);

/**
 * @ingroup driver
 * @brief: revocation for different type of operation
 * @param [in] device_id device id
 * @param [in] revo_type revocation type
 * @param [in] file_data revocation file data
 * @param [in] file_size file data size for revocation
 * @return  0 for success, others for fail
 * @note Support:Ascend910,Ascend610,Ascend310P,Ascend310B,Ascend910B,Ascend910_93,bs9sx1a,as31xm1,Ascend610Lite,Ascend910_95,Ascend910_55
 */
DLLEXPORT int dsmi_set_sec_revocation(int device_id, DSMI_REVOCATION_TYPE revo_type, const unsigned char *file_data,
    unsigned int file_size);

/**
 * @ingroup driver
 * @brief: Set the system mode.
 * @param [in] device_id device id, not userd  default 0
 * @param [in] type determine the system to different sleep type
 * @return  0 for success, others for fail
 * @note Support:Ascend610,bs9sx1a
 */
DLLEXPORT int dsmi_set_power_state(int device_id, DSMI_POWER_STATE type);

/**
 * @ingroup driver
 * @brief: control systems sleep state
 * @param [in] device_id device id, not userd  default 0
 * @param [in] type determine the system to different sleep type
 * @return  0 for success, others for fail
 * @note Support:Ascend310B,as31xm1,Ascend610Lite
 */
DLLEXPORT int dsmi_set_power_state_v2(int device_id, struct dsmi_power_state_info_stru power_info);

/**
 * @ingroup driver
 * @brief: get can status info
 * @param [in] device_id device id
 * @param [in] name Name of the CAN controller device.
 * @param [in] name_len Name length.
 * @param [out] can_status_data return the value of can status info
 * @return  0 for success, others for fail
 * @note Support:Ascend610,bs9sx1a,Ascend610Lite
 */
DLLEXPORT int dsmi_get_can_status(int device_id, const char *name, unsigned int name_len,
    struct dsmi_can_status_stru *can_status_data);

/**
 * @ingroup driver
 * @brief: get ufs status info
 * @param [in] device_id device id
 * @param [out] ufs_status_data return the value of ufs status info
 * @return  0 for success, others for fail
 * @note Support:Ascend610,bs9sx1a,Ascend610Lite
 */
DLLEXPORT int dsmi_get_ufs_status(int device_id, struct dsmi_ufs_status_stru *ufs_status_data);

/**
 * @ingroup driver
 * @brief: get sensorhub status info
 * @param [in] device_id device id
 * @param [out] sensorhub_status_data return the value of sensorhub status info
 * @return  0 for success, others for fail
 * @note Support:Ascend610,bs9sx1a,as31xm1,Ascend610Lite
 */
DLLEXPORT int dsmi_get_sensorhub_status(int device_id, struct dsmi_sensorhub_status_stru *sensorhub_status_data);

/**
 * @ingroup driver
 * @brief: get sensorhub config info
 * @param [in] device_id device id
 * @param [out] sensorhub_config_data return the value of sensorhub config info
 * @return  0 for success, others for fail
 * @note Support:Ascend610,bs9sx1a,as31xm1,Ascend610Lite
 */
DLLEXPORT int dsmi_get_sensorhub_config(int device_id, struct dsmi_sensorhub_config_stru *sensorhub_config_data);

/**
 * @ingroup driver
 * @brief: get hiss status info
 * @param [in] device_id device id, not userd  default 0
 * @param [out] hiss_status_data hiss status infomation
 * @return  0 for success, others for fail
 * @note Support:Ascend610,Ascend910B,Ascend910_93,bs9sx1a,as31xm1,Ascend610Lite,Ascend910_95,Ascend910_55
 */
DLLEXPORT int dsmi_get_hiss_status(int device_id, struct dsmi_hiss_status_stru *hiss_status_data);

/**
 * @ingroup driver
 * @brief: get lp system status info
 * @param [in] device_id device id
 * @param [out] lp_status_data  lp system status information.
 * @return  0 for success, others for fail
 * @note Support:Ascend610,bs9sx1a,as31xm1,Ascend610Lite
 */
DLLEXPORT int dsmi_get_lp_status(int device_id, struct dsmi_lp_status_stru *lp_status_data);

/**
 * @ingroup driver
 * @brief: register fault event handler
 * @param [in] device_id device id
 * @param [in] handler fault event callback func.
 * @return  0 for success, others for fail
 * @note Support:Ascend610,bs9sx1a,Ascend610Lite
 */
DLLEXPORT int dsmi_register_fault_event_handler(int device_id, fault_event_handler handler);

/**
 * @ingroup driver
 * @brief: get device cgroup info, including limit_in_bytes/max_usage_in_bytes/usage_in_bytes.
 * @param [in] device_id device id
 * @param [out] cgroup info limit_in_bytes/max_usage_in_bytes/usage_in_bytes.
 * @return  0 for success, others for fail
 * @note Support:Ascend310,Ascend310B,Ascend310P,Ascend910,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
 */
DLLEXPORT int dsmi_get_device_cgroup_info(int device_id, struct tag_cgroup_info *cg_info);

/**
 * @ingroup driver
 * @brief: set device information
 * @param [in] device_id device id
 * @param [in] main_cmd main command type for device information
 * @param [in] sub_cmd sub command type for device information
 * @param [in] buf input buffer
 * @param [in] buf_size buffer size
 * @return  0 for success, others for fail
 * @note Support:Ascend610,as31xm1,Ascend310P,Ascend310B,Ascend910,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
 */
DLLEXPORT int dsmi_set_device_info(unsigned int device_id, DSMI_MAIN_CMD main_cmd, unsigned int sub_cmd,
    const void *buf, unsigned int buf_size);

/**
 * @ingroup driver
 * @brief: get device information
 * @param [in] device_id device id
 * @param [in] main_cmd main command type for device information
 * @param [in] sub_cmd sub command type for device information
 * @param [in out] buf input and output buffer
 * @param [in out] size input buffer size and output data size
 * @return  0 for success, others for fail
 * @note Support:Ascend610,as31xm1,Ascend310P,Ascend310B,Ascend910,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
 */
DLLEXPORT int dsmi_get_device_info(unsigned int device_id, DSMI_MAIN_CMD main_cmd, unsigned int sub_cmd,
    void *buf, unsigned int *size);

/**
* @ingroup driver
* @brief create ts group
* @attention null
* @param [in]  device_id device id
* @param [in]  ts_id ts id 0 : TS_AICORE, 1 : TS_AIVECTOR
* @param [in]  group_info ts group info
* @return  0 for success, others for fail
* @note Support:Ascend610,bs9sx1a,Ascend310P,Ascend610Lite
*/
DLLEXPORT int dsmi_create_capability_group(int device_id, int ts_id,
                                 struct dsmi_capability_group_info *group_info);

/**
* @ingroup driver
* @brief delete ts group
* @attention null
* @param [in]  device_id device id
* @param [in]  ts_id ts id 0 : TS_AICORE, 1 : TS_AIVECTOR
* @param [in]  group_id group id
* @return  0 for success, others for fail
* @note Support:Ascend610,bs9sx1a,Ascend310P,Ascend610Lite
*/
DLLEXPORT int dsmi_delete_capability_group(int device_id, int ts_id, int group_id);

/**
* @ingroup driver
* @brief get ts group info
* @attention null
* @param [in]  device_id device id
* @param [in]  ts_id ts id 0 : TS_AICORE, 1 : TS_AIVECTOR
* @param [in]  group_id group id
* @param [in]  group_count group count
* @param [out]  group_info ts group info
* @return  0 for success, others for fail
* @note Support:Ascend610,bs9sx1a,Ascend310P,Ascend610Lite
*/
DLLEXPORT int dsmi_get_capability_group_info(int device_id, int ts_id, int group_id,
    struct dsmi_capability_group_info *group_info, int group_count);

/**
 * @brief: get total ECC counts and isolated pages count
 * @param [in] device_id device id
 * @param [in] module_type DDRC or HBM ECC Type
 * @param [out] pdevice_ecc_pages_statistics return ECC statistics
 * @return  0 for success, others for fail
 * @note Support:Ascend910,Ascend910B,Ascend910_93,Ascend310P,Ascend910_95,Ascend910_55
 */
DLLEXPORT int dsmi_get_total_ecc_isolated_pages_info(int device_id, int module_type,
    struct dsmi_ecc_pages_stru *pdevice_ecc_pages_statistics);

/**
 * @ingroup driver
 * @brief: clear recorded ECC info
 * @param [in] device_id device id
 * @return  0 for success, others for fail
 * @note Support:Ascend910,Ascend910B,Ascend910_93,Ascend310P,Ascend910_95,Ascend910_55
 */
DLLEXPORT int dsmi_clear_ecc_isolated_statistics_info(int device_id);

/**
* @ingroup driver
* @brief create vdavinic device on the specified devid
* @attention used on host side
* @param [in] devid               the logic id of device that create vdavinci device
* @param [in] vdev_id             vdavinci device id
* @param [in] vdev_res            specify resource for creating virtual device
* @param [out] vdev_result        result for creating virtual device
* @return  0 for success, others for fail
* @note Support:Ascend910,Ascend310P,Ascend310B,Ascend910B,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_create_vdevice(unsigned int devid, unsigned int vdev_id, struct dsmi_create_vdev_res_stru *vdev_res,
    struct dsmi_create_vdev_result *vdev_result);

/**
* @ingroup driver
* @brief destroy the specified vdavinci device on the specified devid
* @attention used on host side
* @param [in] devid       the logic id of device that create vdavinci device
* @param [in] vdevid      specify the vdevice id number which will be destroyed
* @return  0 for success, others for fail
* @attention  if vdevid = 0xffff, destroy all the vdevice created by device(devid)
              otherwise destroy the vdevice[vdevid]
* @note Support:Ascend910,Ascend310P,Ascend310B,Ascend910B,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_destroy_vdevice(unsigned int devid, unsigned int vdevid);

/**
* @ingroup driver
* @brief get resource info
* @attention used on host side
* @param [in] devid       device id
* @param [in] para        intput para needed including type and id
* @param [out] info       resource info including buffer and buffer len
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend310P,Ascend910,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_resource_info(unsigned int devid, struct dsmi_resource_para *para,
    struct dsmi_resource_info *info);

/**
* @ingroup driver
* @brief Get the number of chips
* @attention NULL
* @param [out] chip_count  The space requested by the user is used to store the number of returned chips
* @return  0 for success, others for fail
* @note Support:Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_chip_count(int *chip_count);

/**
* @ingroup driver
* @brief Get the id of all chips
* @attention NULL
* @param [out] chip_list Indicates the sequence number list of all AI processors.
* @param [in] count Number of chips. The value of count is obtained through the dsmi_get_chip_count interface.
* @return  0 for success, others for fail
* @note Support:Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_list_chip(int chip_list[], int count);

/**
* @ingroup driver
* @brief Get the number of one chip
* @attention NULL
* @param [in] chip_id  The chip id
* @param [out] device_count  The space requested by the user is used to store the number of returned chips
* @return  0 for success, others for fail
* @note Support:Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_device_count_from_chip(int chip_id, int *device_count);

/**
* @ingroup driver
* @brief Get the id of all devices of one chip
* @attention NULL
* @param [in] chip_id  The chip id
* @param [out] device_list device list.
* @param [in] count Number of equipment
* @return  0 for success, others for fail
* @note Support:Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_device_from_chip(int chip_id, int device_list[], int count);

/**
* @ingroup driver
* @brief Subscribe the fault event of device
* @attention NULL
* @param [in] device_id  The device id
* @param [in] filter  Filter options
* @param [in] handler  handler fault event callback func.
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,BS9SX1A,Ascend310P,Ascend910B,Ascend910_93,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_subscribe_fault_event(int device_id, struct dsmi_event_filter filter,
    fault_event_callback handler);

/**
* @ingroup driver
* @brief Get the event of device
* @attention NULL
* @param [in] device_id  The device id
* @param [in] timeout  Block times(ms)
* @param [in] filter  Filter options
* @param [out] event  Information of fault event
* @return  0 for success, others for fail
* @note Support:Ascend310,Ascend310B,Ascend910,Ascend310P,Ascend910B,Ascend910_93,Ascend610,as31xm1,BS9SX1A,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_read_fault_event(int device_id, int timeout, struct dsmi_event_filter filter,
    struct dsmi_event *event);

/**
* @ingroup driver
* @brief Query device fault event
* @attention NULL
* @param [in] device_id: The device id
* @param [in] max_event_cnt: max size of event_buf. The value cannot exceed 1024.
* @param [out] event_buf: fault event info, at least max_event_cnt *sizeof(struct dsmi_event) bytes.
* @param [out] event_cnt: count of fault event
* @return  0 for success, others for fail
* @note Support:Ascend610,as31xm1,BS9SX1A,Ascend610Lite,Ascend910_95
*/
DLLEXPORT int dsmi_get_fault_event(int device_id, int max_event_cnt, struct dsmi_event *event_buf, int *event_cnt);

/**
* @ingroup driver
* @brief ctrl device node
* @attention NULL
* @param [in] device_id: the device id
* @param [in] dtm_node: dtm node
* @param [in] opcode: dtm opcode
* @param [in out] buf: in buf and out buf
* @return  0 for success, others for fail
* @note Support:Ascend610Lite
*/
DLLEXPORT int dsmi_ctrl_device_node(int device_id, struct dsmi_dtm_node_s dtm_node,
    DSMI_DTM_OPCODE opcode, IN_OUT_BUF buf);

/**
* @ingroup driver
* @brief get all device node
* @attention NULL
* @param [in] device_id: the device id
* @param [in] capacity: capacity
* @param [out] node_info: dtm node info
* @param [in out] size: size node_info
* @return  0 for success, others for fail
* @note Support:Ascend610Lite
*/
DLLEXPORT int dsmi_get_all_device_node(int device_id, DEV_DTM_CAP capability,
    struct dsmi_dtm_node_s node_info[], unsigned int *size);

/**
* @ingroup driver
* @brief Set BIST info
* @attention NULL
* @param [in] device_id  The device id
* @param [in] cmd  command type for bist information
* @param [in] buf input buffer
* @param [in] buf_size buffer size
* @return  0 for success, others for fail
* @note Support:BS9SX1A,Ascend610Lite,Ascend910_95
*/
DLLEXPORT int dsmi_set_bist_info(int device_id, DSMI_BIST_CMD cmd, const void *buf, unsigned int buf_size);

/**
* @ingroup driver
* @brief Get BIST info
* @attention NULL
* @param [in] device_id  The device id
* @param [in] cmd  command type for bist information
* @param [out] buf  output buffer
* @param [in out] size input buffer size and output data size
* @return  0 for success, others for fail
* @note Support:BS9SX1A,Ascend610Lite,Ascend910_95
*/
DLLEXPORT int dsmi_get_bist_info(int device_id, DSMI_BIST_CMD cmd, void *buf, unsigned int *size);

/**
* @ingroup driver
* @brief load package to device
* @attention Support to upgrade patch of all device (the first
    parameter is set to -1);
* @param [in] device_id  The device id,only support -1;
* @param [in] pack_type  The type of package, 1:abl Hotfix;
* @param [in] file_name  the path of livepatch;
* @return  0 for success, others for fail
* @note Support:Ascend310P,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_load_package(int device_id, int pack_type, const char *file_name);

/**
* @ingroup driver
* @brief unload sdk patch
* @attention Support to unload patch of all device (the first
    parameter is set to -1);
* @param [in] device_id  The device id,only support -1;
* @param [in] pack_type  The type of package, 1:abl Hotfix;
* @return  0 for success, others for fail
* @note Support:Ascend310P,Ascend910B,Ascend910_93,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_unload_package(int device_id, int pack_type);

struct dsmi_sdid_parse_info {
    unsigned int server_id;
    unsigned int chip_id;
    unsigned int die_id;
    unsigned int udevid;
    unsigned int reserve[8];
};

/**
* @ingroup driver
* @brief get the parsed SDID infomation
* @attention Not supported called in split mode, do not check validity for sdid;
* @param [in]  sdid SDID
* @param [out] sdid_parse  Parsed SDID infomation
* @return   0 for success, others for fail
* @note Support:Ascend910B,Ascend910_93,Ascend910_95
*/
DLLEXPORT int dsmi_parse_sdid(unsigned int sdid, struct dsmi_sdid_parse_info *sdid_parse);

typedef enum {
    DSMI_CONTENT_RTC_CONFIG,
} DSMI_FLASH_CONTENT_TYPE;

#define FLASH_CONTENT_RESERVED_LEN 4
typedef struct dsmi_flash_content {
    DSMI_FLASH_CONTENT_TYPE type;
    unsigned char *buf;
    unsigned int size;
    unsigned int offset;
    unsigned int reserved[FLASH_CONTENT_RESERVED_LEN];
} DSMI_FLASH_CONTENT;

/**
* @ingroup driver
* @brief get flash_content
* @attention NULL
* @param [in] device_id
* @param [in out] content_info flash content info;
* @return 0 for success, others for fail
* @note Support:Ascend610Lite
*/
DLLEXPORT int dsmi_get_flash_content(int device_id, DSMI_FLASH_CONTENT content_info);

/**
* @ingroup driver
* @brief set flash_content
* @attention NULL
* @param [in] device_id
* @param [in] content_info flash content info;
* @return 0 for success, others for fail
* @note Support:Ascend610Lite
*/
DLLEXPORT int dsmi_set_flash_content(int device_id, DSMI_FLASH_CONTENT content_info);

typedef struct {
    unsigned int node_type;
    unsigned int node_id;
    unsigned int init_state;
    unsigned int current_state;
    unsigned int resv[2]; // 2 resv
} DSMI_DEV_NODE_STATE;

/**
* @ingroup driver
* @brief get device state
* @attention NULL
* @param [in] device_id
* @param [in out] node_state;
* @param [in] max_node_num node_state max number
* @param [out] node_num node_state result number
* @return 0 for success, others for fail
* @note Support:as31xm1, BS9SX1A, Ascend610, Ascend610Lite
*/
DLLEXPORT int dsmi_get_device_state(int device_id, DSMI_DEV_NODE_STATE *node_state,
    unsigned int max_num, unsigned int *num);

/**
* @ingroup driver
* @brief Replace a faulty device with the backup device.
* @attention NULL
* @param [in] src_dev_attr  Attribute of the faulty device
* @param [in] dst_dev_attr  Attribute of the backup device
* @param [in] timeout  Setting of timeout duration, [1S, 120S]
* @param [in] flag  Reserve para
* @return  0 for success, others for fail
* @note Support:,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_device_replace(struct dsmi_device_attr *src_dev_attr, struct dsmi_device_attr *dst_dev_attr,
    unsigned int timeout, unsigned long long flag);

/**
* @ingroup driver
* @brief Querying the platform info (Host or Device).
* @attention NULL
* @param [in out] info  platform info
* @return  0 for success, others for fail
* @note Support:Support:Ascend310,Ascend310B,Ascend910,Ascend610,as31xm1,Ascend310P,Ascend910B,Ascend910_93,bs9sx1a,Ascend610Lite,Ascend910_95,Ascend910_55
*/
DLLEXPORT int dsmi_get_platform_info(DSMI_PLATFORM_INFO *info);

#ifdef __cplusplus
}
#endif
#endif
