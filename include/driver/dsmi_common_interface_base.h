/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DSMI_COMMON_INTERFACE_BASE_H
#define DSMI_COMMON_INTERFACE_BASE_H

typedef enum {
    STATE_NORMAL = 0,
    STATE_MINOR,
    STATE_MAJOR,
    STATE_FATAL,
} DSMI_FAULT_STATE;

typedef enum {
    DSMI_DETECT_MAIN_CMD_MEMORY = 0,
    DSMI_DETECT_MAIN_CMD_MAX,
} DSMI_DETECT_MAIN_CMD;

typedef enum {
    SECURE_BOOT,
    ROOTFS_CMS,
    BOOT_TYPE_MAX
} BOOT_TYPE;

#define DSMI_EMU_ISP_MAX 2
#define DSMI_EMU_DVPP_MAX 3
#define DSMI_EMU_CPU_CLUSTER_MAX 4
#define DSMI_EMU_AICORE_MAX 10
#define DSMI_EMU_AIVECTOR_MAX 8

struct  dsmi_emu_subsys_state_stru {
    DSMI_FAULT_STATE emu_sys;
    DSMI_FAULT_STATE emu_sils;
    DSMI_FAULT_STATE emu_sub_sils;
    DSMI_FAULT_STATE emu_sub_peri;
    DSMI_FAULT_STATE emu_sub_ao;
    DSMI_FAULT_STATE emu_sub_hac;
    DSMI_FAULT_STATE emu_sub_gpu;
    DSMI_FAULT_STATE emu_sub_isp[DSMI_EMU_ISP_MAX];
    DSMI_FAULT_STATE emu_sub_dvpp[DSMI_EMU_DVPP_MAX];
    DSMI_FAULT_STATE emu_sub_io;
    DSMI_FAULT_STATE emu_sub_ts;
    DSMI_FAULT_STATE emu_sub_cpu_cluster[DSMI_EMU_CPU_CLUSTER_MAX];
    DSMI_FAULT_STATE emu_sub_aicore[DSMI_EMU_AICORE_MAX];
    DSMI_FAULT_STATE emu_sub_aivector[DSMI_EMU_AIVECTOR_MAX];
    DSMI_FAULT_STATE emu_sub_media;
    DSMI_FAULT_STATE emu_sub_lp;
    DSMI_FAULT_STATE emu_sub_tsv;
    DSMI_FAULT_STATE emu_sub_tsc;
};

struct  dsmi_safetyisland_status_stru {
    DSMI_FAULT_STATE status;
};

typedef struct dsmi_fault_inject_info {
    unsigned int device_id;
    unsigned int node_type;
    unsigned int node_id;
    unsigned int sub_node_type;
    unsigned int sub_node_id;
    unsigned int fault_index;
    unsigned int event_id;
    unsigned int reserve1;
    unsigned int reserve2;
} DSMI_FAULT_INJECT_INFO;

struct dsmi_reboot_reason {
    unsigned int reason;
    unsigned int sub_reason; /* reserve */
};

/**
 * @ingroup driver
 * @brief: get gpio value
 * @param [in] device_id device id
 * @param [in] gpio_num gpio_num
 * @param [out] status return the value of gpio value
 * @return  0 for success, others for fail
 * @note Support:Ascend610,bs9sx1a,as31xm1,Ascend610Lite
 */
DLLEXPORT int dsmi_get_gpio_status(int device_id, unsigned int gpio_num, unsigned int *status);

/**
 * @ingroup driver
 * @brief: get soc hardware fault info
 * @param [in] device_id device id
 * @param [out] emu_subsys_state_data dsmi emu subsys status information.
 * @return  0 for success, others for fail
 * @note Support:Ascend610,bs9sx1a
 */
DLLEXPORT int dsmi_get_sochwfault(int device_id, struct dsmi_emu_subsys_state_stru *emu_subsys_state_data);

/**
 * @ingroup driver
 * @brief: get safetyisland status info
 * @param [in] device_id device id
 * @param [out] safetyisland_status_data dsmi safetyisland status information.
 * @return  0 for success, others for fail
 * @note Support:Ascend610,bs9sx1a,Ascend610Lite
 */
DLLEXPORT int dsmi_get_safetyisland_status(int device_id,
    struct dsmi_safetyisland_status_stru *safetyisland_status_data);

/**
* @ingroup driver
* @brief set detect info
* @attention NULL
 * @param [in] device_id device id
 * @param [in] main_cmd main command type for detect information
 * @param [in] sub_cmd sub command type for detect information
 * @param [in] buf input buffer
 * @param [in] buf_size buffer size
 * @return  0 for success, others for fail
 * @note Support:Ascend610Lite
 */
DLLEXPORT int dsmi_set_detect_info(unsigned int device_id, DSMI_DETECT_MAIN_CMD main_cmd,
    unsigned int sub_cmd, const void *buf, unsigned int buf_size);

/**
* @ingroup driver
* @brief get detect info
* @attention NULL
 * @param [in] device_id device id
 * @param [in] main_cmd main command type for detect information
 * @param [in] sub_cmd sub command type for detect information
 * @param [in out] buf input and output buffer
 * @param [in out] buf_size input buffer size and output data size
 * @return  0 for success, others for fail
 * @note Support:Ascend610Lite
 */
DLLEXPORT int dsmi_get_detect_info(unsigned int device_id, DSMI_DETECT_MAIN_CMD main_cmd,
    unsigned int sub_cmd, void *buf, unsigned int *buf_size);

/**
* @ingroup driver
* @brief inject fault
* @attention call dsmi_get_fault_inject_info() to get fault inject info that supported by dsmi_fault_inject();
* @param [in] fault_inject_info a fault that the customer want to inject;
* @return 0 for success, others for fail
* @note Support:as31xm1,BS9SX1A,Ascend610Lite
*/
DLLEXPORT int dsmi_fault_inject(DSMI_FAULT_INJECT_INFO fault_inject_info);

/**
* @ingroup driver
* @brief get the inject fault infos supported by device
* @attention real_info_cnt will <= 64;
* @param [in] device_id
* @param [in] max_info_cnt how many DSMI_FAULT_INJECT_INFO type structs did the info_buf contain;
* @param [out] info_buf  the memory malloced by users to store DSMI_FAULT_INJECT_INFO structs;
* @param [out] real_info_cnt DSMI_FAULT_INJECT_INFO supportd by device;
* @return 0 for success, others for fail
* @note Support:as31xm1, BS9SX1A, Ascend610,Ascend610Lite
*/
DLLEXPORT int dsmi_get_fault_inject_info(unsigned int device_id, unsigned int max_info_cnt,
    DSMI_FAULT_INJECT_INFO *info_buf, unsigned int *real_info_cnt);

/**
 * @ingroup driver
 * @brief verify if current partitions is same as configuration file
 * @param [in] config_xml_path    full path of configuration file
 * @return  0 for success, others for fail
 * @note Support:Ascend610,as31xm1,bs9sx1a,Ascend610Lite
 */
DLLEXPORT int dsmi_check_partitions(const char *config_xml_path);

/**
* @ingroup driver
* @brief Get the reboot reason
* @attention NULL
* @param [in] device_id  The device id
* @param [out] reboot_reason  Indicates the reset reason of the AI processor.
* @return  0 for success, others for fail
* @note Support:Ascend610,BS9SX1A,as31xm1,Ascend610Lite
*/
DLLEXPORT int dsmi_get_reboot_reason(int device_id, struct dsmi_reboot_reason *reboot_reason);

/**
* @ingroup driver
* @brief Get boot state
* @attention NULL
* @param [in] device_id: the device id
* @param [in] boot_type: the stage boot_type. 0 for Secure Boot, 1 for rootfs cms
* @param [out] state: the boot state. 0 for normal, others for abnormal
* @return  0 for success, others for fail
* @note Support:Ascend610,BS9SX1A,Ascend610Lite
*/
DLLEXPORT int dsmi_get_last_bootstate(int device_id, BOOT_TYPE boot_type, unsigned int *state);

/**
* @ingroup driver
* @brief get centre notify info
* @attention NULL
* @param [in] device_id: the device id
* @param [in] index: which index you want to get(0-1023)
* @param [out] value: the valve you want to get
* @return  0 for success, others for fail
* @note Support:Ascend610,BS9SX1A,as31xm1,Ascend610Lite
*/
DLLEXPORT int dsmi_get_centre_notify_info(int device_id, int index, int *value);

/**
* @ingroup driver
* @brief set centre notify info
* @attention NULL
* @param [in] device_id: the device id
* @param [in] index: which index you want to set(0-1022)
* @param [in] value: the valve you want to set
* @return  0 for success, others for fail
* @note Support:Ascend610,BS9SX1A,as31xm1,Ascend610Lite
*/
DLLEXPORT int dsmi_set_centre_notify_info(int device_id, int index, int value);

#endif