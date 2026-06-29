/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_DEVICE_H
#define CCE_RUNTIME_DEVICE_H

#include "base.h"
#include "runtime/rt_external_device.h"

#if defined(__cplusplus)
extern "C" {
#endif

#define RT_CAPABILITY_SUPPORT     (0x1U)
#define RT_CAPABILITY_NOT_SUPPORT (0x0U)
#define MEMORY_INFO_TS_4G_LIMITED (0x0U) // for compatibility

#define INFO_TYPE_CUBE_NUM (0x775A5A5AU) // for cube core num

#define RT_NPU_UUID_LENGTH  (16)

typedef struct tagRTDeviceInfo {
    uint8_t env_type;  // 0: FPGA  1: EMU 2: ESL
    uint32_t ctrl_cpu_ip;
    uint32_t ctrl_cpu_id;
    uint32_t ctrl_cpu_core_num;
    uint32_t ctrl_cpu_endian_little;
    uint32_t ts_cpu_core_num;
    uint32_t ai_cpu_core_num;
    uint32_t ai_core_num;
    uint32_t ai_core_freq;
    uint32_t ai_cpu_core_id;
    uint32_t ai_core_id;
    uint32_t aicpu_occupy_bitmap;
    uint32_t hardware_version;
    uint32_t ts_num;
} rtDeviceInfo_t;

typedef enum tagRtRunMode {
    RT_RUN_MODE_OFFLINE = 0,
    RT_RUN_MODE_ONLINE,
    RT_RUN_MODE_AICPU_SCHED,
    RT_RUN_MODE_RESERVED
} rtRunMode;

typedef enum tagRtAicpuDeployType {
    AICPU_DEPLOY_CROSS_OS = 0x0,
    AICPU_DEPLOY_CROSS_PROCESS,
    AICPU_DEPLOY_CROSS_THREAD,
    AICPU_DEPLOY_RESERVED
} rtAicpuDeployType_t;


typedef enum tagRtPhyDeviceInfoType {
    RT_PHY_INFO_TYPE_CHIPTYPE = 0,
    RT_PHY_INFO_TYPE_MASTER_ID,
    RT_PHY_INFO_TYPE_PHY_CHIP_ID,
    RT_PHY_INFO_TYPE_PHY_DIE_ID
} rtPhyDeviceInfoType_t;

typedef struct {
    uint64_t va;
    uint64_t size;
    uint32_t tokenId;
    uint32_t tokenValue;
} rtMemUbTokenInfo;


typedef void *rtHdcServer_t;
typedef void *rtHdcClient_t;
typedef void *rtHdcSession_t;

/* consistent with drvHdcServiceType in inc/driver/ascend_hal.h */
typedef enum {
    RT_HDC_SERVICE_TYPE_DMP                 = 0,
    RT_HDC_SERVICE_TYPE_PROFILING           = 1,
    RT_HDC_SERVICE_TYPE_IDE1                = 2,
    RT_HDC_SERVICE_TYPE_FILE_TRANS          = 3,
    RT_HDC_SERVICE_TYPE_IDE2                = 4,
    RT_HDC_SERVICE_TYPE_LOG                 = 5,
    RT_HDC_SERVICE_TYPE_RDMA                = 6,
    RT_HDC_SERVICE_TYPE_BBOX                = 7,
    RT_HDC_SERVICE_TYPE_FRAMEWORK           = 8,
    RT_HDC_SERVICE_TYPE_TSD                 = 9,
    RT_HDC_SERVICE_TYPE_TDT                 = 10,
    RT_HDC_SERVICE_TYPE_PROF                = 11,
    RT_HDC_SERVICE_TYPE_IDE_FILE_TRANS      = 12,
    RT_HDC_SERVICE_TYPE_DUMP                = 13,
    RT_HDC_SERVICE_TYPE_USER3               = 14,
    RT_HDC_SERVICE_TYPE_DVPP                = 15,
    RT_HDC_SERVICE_TYPE_QUEUE               = 16,
    RT_HDC_SERVICE_TYPE_UPGRADE             = 17,
    RT_HDC_SERVICE_TYPE_RDMA_V2             = 18,
    RT_HDC_SERVICE_TYPE_TEST                = 19,
    RT_HDC_SERVICE_TYPE_USER_START          = 64,
    RT_HDC_SERVICE_TYPE_USER_END            = 127,
    RT_HDC_SERVICE_TYPE_MAX
} rtHdcServiceType_t;


typedef enum tagRtDumpMode {
    RT_DEBUG_DUMP_ON_EXCEPTION = 1,
    RT_DEBUG_DUMP_MAX
} rtDumpMode_t;

typedef struct tagRtUuid {
    char bytes[RT_NPU_UUID_LENGTH];
} rtUuid_t;

/**
 * @ingroup dvrt_dev
 * @brief get total device number.
 * @param [in|out] cnt the device number
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetDeviceCount(int32_t *cnt);
/**
 * @ingroup dvrt_dev
 * @brief get device ids
 * @param [in|out] get details of device ids
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_DRV_ERR for error
 */
RTS_API rtError_t rtGetDeviceIDs(uint32_t *devices, uint32_t len);

/**
 * @ingroup dvrt_dev
 * @brief set target device for current thread
 * @param [int] devId   the device id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtSetDevice(int32_t devId);

/**
 * @ingroup dvrt_dev
 * @brief set target device for current thread
 * @param [int] devId   the device id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtSetDeviceEx(int32_t devId);

/**
 * @ingroup dvrt_dev
 * @brief get Index by phyId.
 * @param [in] phyId   the physical device id
 * @param [out] devIndex   the logic device id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetDeviceIndexByPhyId(uint32_t phyId, uint32_t *devIndex);

/**
 * @ingroup dvrt_dev
 * @brief get phyId by Index.
 * @param [in] devIndex   the logic device id
 * @param [out] phyId   the physical device id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetDevicePhyIdByIndex(uint32_t devIndex, uint32_t *phyId);

/**
 * @ingroup dvrt_dev
 * @brief get cability of P2P omemry copy betwen device and peeredevic.
 * @param [in] devId   the logical device id
 * @param [in] peerDevice   the physical device id
 * @param [outv] *canAccessPeer   1:enable 0:disable
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDeviceCanAccessPeer(int32_t *canAccessPeer, uint32_t devId, uint32_t peerDevice);

/**
 * @ingroup dvrt_dev
 * @brief get value of current thread
 * @param [in|out] pid   value of pid
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtDeviceGetBareTgid(uint32_t *pid);

/**
 * @ingroup dvrt_dev
 * @brief get target device of current thread
 * @param [in|out] devId   the device id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetDevice(int32_t *devId);

/**
 * @ingroup dvrt_dev
 * @brief reset all opened device
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDeviceReset(int32_t devId);

/**
 * @ingroup dvrt_dev
 * @brief reset opened device
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDeviceResetEx(int32_t devId);

/**
 * @ingroup dvrt_dev
 * @brief get total device infomation.
 * @param [in] devId   the device id
 * @param [in] type     limit type RT_LIMIT_TYPE_LOW_POWER_TIMEOUT=0
 * @param [in] val    limit value
 * @param [out] info   the device info
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDeviceSetLimit(int32_t devId, rtLimitType_t type, uint32_t val);

/**
 * @ingroup dvrt_dev
 * @brief Wait for compute device to finish
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDeviceSynchronize(void);

/**
 * @ingroup dvrt_dev
 * @brief Wait for compute device to finish and set timeout
 * @param [in] timeout   timeout value,the unit is milliseconds
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDeviceSynchronizeWithTimeout(int32_t timeout);

/**
 * @ingroup dvrt_dev
 * @brief Wait for compute device to finish
 * @param [in] devId   the device id
 * @param [in] timeout the time for hadle
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDeviceTaskAbort(int32_t devId, uint32_t timeout);

/**
 * @ingroup dvrt_dev
 * @brief get priority range of current device
 * @param [in|out] leastPriority   least priority
 * @param [in|out] greatestPriority   greatest priority
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDeviceGetStreamPriorityRange(int32_t *leastPriority, int32_t *greatestPriority);

/**
 * @ingroup dvrt_dev
 * @brief Setting Scheduling Type of Graph
 * @param [in] tsId   the ts id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtSetTSDevice(uint32_t tsId);

/**
 * @ingroup dvrt_dev
 * @brief init aicpu executor
 * @param [out] runtime run mode
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_DRV_ERR for can not get run mode
 */
RTS_API rtError_t rtGetRunMode(rtRunMode *runMode);

/**
 * @ingroup dvrt_dev
 * @brief get aicpu deploy
 * @param [out] aicpu deploy
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_DRV_ERR for can not get aicpu deploy
 */
RTS_API rtError_t rtGetAicpuDeploy(rtAicpuDeployType_t *deployType);

/**
 * @ingroup dvrt_dev
 * @brief get chipType
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtGetSocVersion(char_t *ver, const uint32_t maxLen);

/**
 * @ingroup dvrt_dev
 * @brief check socversion
 * @param [in] omSocVersion   OM SocVersion
 * @param [in] omArchVersion   OM ArchVersion
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtModelCheckCompatibility(const char_t *omSocVersion, const char_t *omArchVersion);

/**
 * @ingroup dvrt_dev
 * @brief verify whether omSocVersion is compatible with the current device.
 * @param [in] omSocVersion   OM SocVersion
 * @param [out] canCompatible Check compatibility: return 1 for compatible, 0 for incompatible
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtCheckArchCompatibility(const char_t *omSocVersion, int32_t *canCompatible);

/**
 * @ingroup dvrt_dev
 * @brief get device status
 * @param [in] devId   the device id
 * @param [out] deviceStatus the device statue
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtDeviceStatusQuery(const uint32_t devId, rtDeviceStatus *deviceStatus);

/**
 * @ingroup dvrt_dev
 * @brief reset all opened device
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDeviceResetWithoutTsd(int32_t devId);

/**
 * @ingroup
 * @brief set saturation mode for current device.
 * @param [in] saturation mode.
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtSetDeviceSatMode(rtFloatOverflowMode_t floatOverflowMode);

/**
 * @ingroup
 * @brief get saturation mode for current device.
 * @param [out] saturation mode.
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtGetDeviceSatMode(rtFloatOverflowMode_t *floatOverflowMode);

/**
 * @ingroup
 * @brief get saturation mode for target stream.
 * @param [in] target stm
 * @param [out] saturation mode.
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtGetDeviceSatModeForStream(rtStream_t stm, rtFloatOverflowMode_t *floatOverflowMode);

/**
 * @ingroup
 * @brief get pyh deviceid of current process
 * @param [in] logicDeviceId   user deviceid
 * @param [out] *visibleDeviceId  deviceid configured using the environment variable ASCEND_RT_VISIBLE_DEVICES
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetVisibleDeviceIdByLogicDeviceId(const int32_t logicDeviceId, int32_t * const visibleDeviceId);
/**
 * @ingroup
 * @brief get aicore/aivectoe/aicpu utilizations
 * @param [int] devId   the device id
 * @param [int] kind    util type
 * @param [out] *util for aicore/aivectoe/aicpu
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetAllUtilizations(const int32_t devId, const rtTypeUtil_t kind, uint8_t * const util);

/**
 * @ingroup dvrt_dev
 * @brief set default device id
 * @param [int] deviceId  deviceId
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtSetDefaultDeviceId(const int32_t deviceId);

/**
 * @ingroup dvrt_dev
 * @brief force reset all opened device
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDeviceResetForce(int32_t devId);

/**
 * @ingroup
 * @brief set failure mode for current device
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtSetDeviceFailureMode(uint64_t failureMode);

/**
 * @ingroup 
 * @brief get system param option's value
 * @param [in] configOpt system option to be get value
 * @param [out] configVal system option's value to be get
 * @return RT_ERROR_NONE for ok, errno for failed
 */
RTS_API rtError_t rtGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal);

/**
 * @ingroup 
 * @brief set system param option
 * @param [in] configOpt system option to be set
 * @param [in] configVal system option's value to be set
 * @return RT_ERROR_NONE for ok, errno for failed
 */
RTS_API rtError_t rtSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal);

/**
 * @ingroup
 * @brief get the status of a specified device.
 * @param [in] devId
 * @param [out] status
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetDeviceStatus(const int32_t devId, rtDevStatus_t * const status);

/**
 * @ingroup
 * @brief create and initialize HDC server
 * @param [in] devId    : only support [0, 64)
 * @param [in] type     : select server type
 * @param [out] server  : created HDC server
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtHdcServerCreate(const int32_t devId, const rtHdcServiceType_t type, rtHdcServer_t * const server);

/**
 * @ingroup
 * @brief release HDC server
 * @param [in] server    : HDC server to be released
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtHdcServerDestroy(rtHdcServer_t const server);

/**
* @ingroup
* @brief create HDC session for host and device communication
* @param [in]  peerNode : the node number of the node where the device is located. currently only 1 node is supported.
* remote nodes are not supported. you need to pass a fixed value of 0
* @param [in]  peerDevId: device's uniform ID in the host (number in each node)
* @param [in]  client   : HDC client handle corresponding to the newly created session
* @param [out] session  : created session
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtHdcSessionConnect(const int32_t peerNode, const int32_t peerDevId, rtHdcClient_t const client,
    rtHdcSession_t * const session);

/**
* @ingroup
* @brief close HDC session for communication between host and device
* @param [in] session  : specify in which session to receive data
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtHdcSessionClose(rtHdcSession_t const session);

/**
* @ingroup
* @brief get the device ID in the host CPU scenario
* @param [out] devId  : assigned device ID
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtGetHostCpuDevId(int32_t * const devId);

/**
* @ingroup
* @brief convert user device ID to logic device ID
* @param [in] userDevId     : user device ID
* @param [out] logicDevId   : logic device ID
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtGetLogicDevIdByUserDevId(const int32_t userDevId, int32_t * const logicDevId);

/**
* @ingroup
* @brief convert logic device ID to user device ID
* @param [in] logicDevId    : logic device ID
* @param [out] userDevId    : user device ID
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtGetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t * const userDevId);

/**
* @ingroup dvrt_dev
* @brief Get device uuid
* @param [in] devId user device ID
* @param [out] uuid rtUuid struct
* @return ACL_RT_SUCCESS for get uuid successfully
* @return ACL_ERROR_RT_FEATURE_NOT_SUPPORT for driver or device not support uuid feature
*/
RTS_API rtError_t rtGetDeviceUuid(const int32_t devId, rtUuid_t *uuid);

#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_DEVICE_H
