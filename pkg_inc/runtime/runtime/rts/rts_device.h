/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RTS_DEVICE_H
#define CCE_RUNTIME_RTS_DEVICE_H

#include <stdlib.h>
#include <unordered_map>

#include "base.h"
#include "dev.h"

#if defined(__cplusplus)
extern "C" {
#endif

#define  FEATURE_SUPPORT        1U
#define  FEATURE_NOT_SUPPORT    0U

typedef enum { 
    RT_DEV_ATTR_AICPU_CORE_NUM  = 1U,
    RT_DEV_ATTR_AICORE_CORE_NUM = 101U,
    RT_DEV_ATTR_CUBE_CORE_NUM   = 102U,

    RT_DEV_ATTR_VECTOR_CORE_NUM = 201U,
    RT_DEV_ATTR_WARP_SIZE       = 202U,
    RT_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE  = 203U,  
    RT_DEV_ATTR_LOCAL_MEM_PER_VECTOR_CORE   = 204U,

    RT_DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE   = 301U,     /* total available global mem */
    RT_DEV_ATTR_L2_CACHE_SIZE           = 302U,

    // MODULE_TYPE_SYSTEM
    RT_DEV_ATTR_SMP_ID = 401U,                  // indicates whether devices are on the same OS
    RT_DEV_ATTR_PHY_CHIP_ID = 402U,             // physical chip id
    RT_DEV_ATTR_SUPER_POD_DEVICE_ID = 403U,     // super pod device id
    RT_DEV_ATTR_SUPER_POD_SERVER_ID = 404U,     // super pod server id
    RT_DEV_ATTR_SUPER_POD_ID = 405U,            // super pod id
    RT_DEV_ATTR_CUST_OP_PRIVILEGE = 406U,       // indicates whether the custom operator privilege is enabled
    RT_DEV_ATTR_MAINBOARD_ID = 407U,            // mainboard id

    RT_DEV_ATTR_IS_VIRTUAL = 501U,              // is_virtual

    RT_DEV_ATTR_MAX
} rtDevAttr;

typedef enum { 
    RT_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV = 1U,
    RT_FEATURE_SYSTEM_MEMQ_EVENT_CROSS_DEV       = 21U,

    RT_FEATURE_AICPU_SCHEDULE_TYPE               = 10001U,

    RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH           = 20001U,

    RT_DEV_FEATURE_MAX 
} rtDevFeatureType;

// 通过HCCS连接的两个NPU之间的拓扑互联关系
#define RT_DEVS_TOPOLOGY_HCCS     0x01ULL
// 单个PCIe switch连接两个NPU之间的拓扑互联关系
#define RT_DEVS_TOPOLOGY_PIX      0x02ULL
// PIB
#define RT_DEVS_TOPOLOGY_PIB      0x04ULL
// Path traversing PCIe and the PCIe host bridge of a CPU
#define RT_DEVS_TOPOLOGY_PHB      0x08ULL
// 在不同的NUMA节点下的NPU之间的拓扑互联关系
#define RT_DEVS_TOPOLOGY_SYS      0x10ULL
// Die间直连
#define RT_DEVS_TOPOLOGY_SIO      0x20ULL

#define RT_DEVS_TOPOLOGY_HCCS_SW  0x40ULL

// 拉起HCCP进程
struct rtProcExtParam {
    const char  *paramInfo;
    uint64_t    paramLen;
};

struct rtNetServiceOpenArgs {
    rtProcExtParam *extParamList;   // 拉起服务的参数列表
    uint64_t     extParamCnt;    // 拉起服务的参数列表长度
};

#define RT_EXT_PARAM_CNT_MAX  127U

typedef enum {
    RT_DEVS_INFO_TYPE_TOPOLOGY = 0,
} rtPairDevicesInfoType;

/**
 * @ingroup dvrt_dev
 * @brief get status
 * @param [in] devId   the logical device id
 * @param [in] otherDevId   the other logical device id
 * @param [in] infoType   info type
 * @param [in|out] val   pair info
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsGetPairDevicesInfo(uint32_t devId, uint32_t otherDevId, int32_t infoType, uint64_t *val);

/**
 * @ingroup dvrt_dev
 * @brief set target device for current thread
 * @param [in] devId   the device id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsSetDevice(int32_t devId);

/**
 * @ingroup dvrt_dev
 * @brief Setting Scheduling Type of Graph
 * @param [in] tsId   the ts id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsSetTsDevice(uint32_t tsId);

/**
 * @ingroup rts_device
 * @brief get device infomation.
 * @param [in] device the device id
 * @param [in] attr device attr 
 * @param [out] val   the device info
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_DRV_ERR for error
 */
RTS_API rtError_t rtsDeviceGetInfo(uint32_t deviceId, rtDevAttr attr, int64_t *val);

/**
 * @ingroup rts_device
 * @brief get device feature ability by device id, such as task schedule ability.
 * @param [in] deviceId
 * @param [in] devFeatureType
 * @param [out] val
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsDeviceGetCapability(int32_t deviceId, int32_t devFeatureType, int32_t *val);

/**
 * @ingroup rts_device
 * @brief get priority range of current device
 * @param [in|out] leastPriority   least priority
 * @param [in|out] greatestPriority   greatest priority
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsDeviceGetStreamPriorityRange(int32_t *leastPriority, int32_t *greatestPriority);

/**
 * @ingroup rts_device
 * @brief get total device number.
 * @param [in|out] cnt the device number
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsGetDeviceCount(int32_t *cnt);

/**
 * @ingroup rts_device
 * @brief reset all opened device
 * @param [in] deviceId
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsResetDevice(int32_t devId);

/**
 * @ingroup rts_device
 * @brief force reset all opened device
 * @param [in] deviceId
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsDeviceResetForce(int32_t devId);

/**
 * @ingroup rts_device
 * @brief init aicpu executor
 * @param [out] runtime run mode
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_DRV_ERR for can not get run mode
 */
RTS_API rtError_t rtsGetRunMode(rtRunMode *runMode);

/**
 * @ingroup rts_device
 * @brief get aicore/aivectoe/aicpu utilizations
 * @param [int] devId   the device id
 * @param [int] kind    util type
 * @param [out] *util for aicore/aivectoe/aicpu
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsGetDeviceUtilizations(const int32_t devId, const rtTypeUtil_t kind, uint8_t * const util);

/**
 * @ingroup rts_device
 * @brief get chipType
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsGetSocVersion(char_t *ver, const uint32_t maxLen);

/**
 * @ingroup rts_device
 * @brief set event wait task timeout time.
 * @param [in] timeout
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsSetOpWaitTimeOut(uint32_t timeout);


/**
 * @ingroup dvrt_dev
 * @brief get device status
 * @param [in] devId   the device id
 * @param [out] deviceStatus the device statue
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsDeviceStatusQuery(const uint32_t devId, rtDeviceStatus *deviceStatus);

/**
 * @ingroup dvrt_dev
 * @brief set default device id
 * @param [int] deviceId  deviceId
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsSetDefaultDeviceId(const int32_t deviceId);

/**
 * @ingroup rts_device
 * @brief set system param option
 * @param [in] configOpt system option to be set
 * @param [in] configVal system option's value to be set
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal);

/**
 * @ingroup rts_device
 * @brief get value of current thread
 * @param [in|out] pid   value of pid
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsDeviceGetBareTgid(uint32_t *pid);

/**
 * @ingroup rts_device
 * @brief get target device of current thread
 * @param [in|out] devId   the device id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsGetDevice(int32_t *devId);

/**
 * @ingroup rts_device
 * @brief Wait for compute device to finish and set timeout
 * @param [in] timeout   timeout value,the unit is milliseconds
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsDeviceSynchronize(int32_t timeout);

/**
 * @ingroup rts_device
 * @brief Stop all tasks that are being executed on the current device
 * @param [in] devId   the device id
 * @param [in] timeout Max waiting duration of aborted tasks, in milliseconds
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsDeviceTaskAbort(int32_t devId, uint32_t timeout);

/**
 * @ingroup
 * @brief set op execute task timeout time.
 * @param [in] timeout
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsSetOpExecuteTimeOut(uint32_t timeout);

/**
 * @ingroup
 * @brief get op execute task timeout time.
 * @param [out] timeout
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsGetOpExecuteTimeOut(uint32_t * const timeout);

/**
 * @ingroup
 * @brief set op execute task timeout time with ms.
 * @param [in] timeout/ms
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */

RTS_API rtError_t rtsSetOpExecuteTimeOutWithMs(uint32_t timeout);

/**
 * @ingroup 
 * @brief get system param option's value
 * @param [in] configOpt system option to be get value
 * @param [out] configVal system option's value to be get
 * @return RT_ERROR_NONE for ok, errno for failed
 */
RTS_API rtError_t rtsGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal);

/**
 * @ingroup
 * @brief Limit device resource usage
 * @param [in] devId   the device id
 * @param [in] type    resource type
 * @param [in] value   resource limit value
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsSetDeviceResLimit(const int32_t devId, const rtDevResLimitType_t type, uint32_t value);

/**
 * @ingroup
 * @brief Remove the current limit on the use of device resources
 * @param [in] devId   the device id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsResetDeviceResLimit(const int32_t devId);

/**
 * @ingroup
 * @brief Get the value of the current device's limited resources
 * @param [in] devId   the device id
 * @param [in] type    resource type
 * @param [out] value   resource limit value
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsGetDeviceResLimit(const int32_t devId, const rtDevResLimitType_t type, uint32_t *value);

/**
 * @ingroup
 * @brief query ub device info
 * @param [in] cmd query info tpye
 * @param [in|out] info input/output parameter
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtUbDevQueryInfo(rtUbDevQueryCmd cmd, void *devInfo);

/**
 * @ingroup
 * @brief map resource va address
 * @param [in] resInfo resource info
 * @param [out] addrInfo resource address info
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetDevResAddress(rtDevResInfo * const resInfo, rtDevResAddrInfo * const addrInfo);

/**
 * @ingroup
 * @brief unmap resource va address
 * @param [in] resInfo resource info
 * @param [out] resAddress resource address
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtReleaseDevResAddress(rtDevResInfo * const resInfo);

/**
 * @ingroup
 * @brief query ub device info
 * @param [in] devId device id
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDeviceResourceClean(const int32_t devId);

/**
 * @ingroup dvrt_dev
 * @brief get Index by phyId.
 * @param [in] phyId   the physical device id
 * @param [out] logicId   the logic device id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsGetLogicDevIdByPhyDevId(int32_t phyDevId, int32_t * const logicDevId);
 
/**
 * @ingroup dvrt_dev
 * @brief get phyId by Index.
 * @param [in] logicId   the logic device id
 * @param [out] phyId   the physical device id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsGetPhyDevIdByLogicDevId(int32_t logicDevId, int32_t * const phyDevId);
 
/**
* @ingroup
* @brief convert user device ID to logic device ID
* @param [in] userDevId     : user device ID
* @param [out] logicDevId   : logic device ID
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtsGetLogicDevIdByUserDevId(const int32_t userDevId, int32_t * const logicDevId);
 
/**
* @ingroup
* @brief convert logic device ID to user device ID
* @param [in] logicDevId    : logic device ID
* @param [out] userDevId    : user device ID
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtsGetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t * const userDevId);

/**
* @ingroup
* @brief set debug dump mode
* @param [in] mode    : dump mode
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtsDebugSetDumpMode(const uint64_t mode);

/**
* @ingroup
* @brief get stalled core id in current process
* @param [out] coreInfo    : physics core id used
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtsDebugGetStalledCore(rtDbgCoreInfo_t *const coreInfo);

/**
 * @ingroup
 * @brief Open NetService for HCCL
 * @param [in] args   service args
 * @return RT_ERROR_NONE for ok, errno for failed
 */
RTS_API rtError_t rtOpenNetService(const rtNetServiceOpenArgs *args);
 
/**
 * @ingroup
 * @brief Close NetService for HCCL
 * @return RT_ERROR_NONE for ok, errno for failed
 */
RTS_API rtError_t rtCloseNetService();

typedef enum {
    RT_DEVICE_STATE_SET_PRE = 0,
    RT_DEVICE_STATE_SET_POST,
    RT_DEVICE_STATE_RESET_PRE,
    RT_DEVICE_STATE_RESET_POST
} rtDeviceState;

typedef void (*rtsDeviceStateCallback)(uint32_t devId, rtDeviceState state, void *args);

/**
 * @ingroup dvrt_base
 * @brief register callback for device state
 * @param [in] regName unique register name
 * @param [in] callback device state callback function
 * @param [in] args user args
 * @param [out] NA
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsRegDeviceStateCallback(const char_t *regName, rtsDeviceStateCallback callback, void *args);

typedef void (*rtsTaskFailCallback)(rtExceptionInfo_t *exceptionInfo, void *args);

/**
 * @ingroup dvrt_base
 * @brief register callback for fail task
 * @param [in] regName register name
 * @param [in] callback fail task callback function
 * @param [in] args user args
 * @param [out] NA
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsSetTaskFailCallback(const char_t *regName, rtsTaskFailCallback callback, void *args);

typedef enum {
    RT_DEVICE_TASK_ABORT_PRE = 0,
    RT_DEVICE_TASK_ABORT_POST
} rtDeviceTaskAbortStage;

typedef int32_t (*rtsDeviceTaskAbortCallback)(uint32_t devId, rtDeviceTaskAbortStage stage, uint32_t timeout, void *args);

/**
 * @ingroup dvrt_base
 * @brief register callback for device task abort
 * @param [in] regName register name
 * @param [in] callback device task abort callback function
 * @param [in] args user args
 * @param [out] NA
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsSetDeviceTaskAbortCallback(const char_t *regName, rtsDeviceTaskAbortCallback callback, void *args);

/**
 * @ingroup xpu dev
 * @brief get xpu device count
 * @param [in] devType Currently, only the DPU type is supported. 
 * @param [out] count Currently count=1
 * @return RT_ERROR_NONE for ok
 */
RTS_API uint32_t rtGetXpuDevCount(rtXpuDevType devType);

/**
 * @ingroup xpu dev
 * @brief set xpu device
 * @param [in] devType Currently, only the DPU type is supported. 
 * @param [in] devId Currently devId=0 is supported
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtSetXpuDevice(rtXpuDevType devType, const uint32_t devId);

/**
 * @ingroup xpu dev
 * @brief reset xpu device
 * @param [in] devType Currently, only the DPU type is supported. 
 * @param [in] devId Currently devId=0 is supported
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtResetXpuDevice(rtXpuDevType devType, const uint32_t devId);
#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_RTS_DEVICE_H