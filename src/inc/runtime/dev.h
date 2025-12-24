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

typedef enum tagRtXpuDevType {
    RT_DEV_TYPE_DPU = 0,
    RT_DEV_TYPE_REV
} rtXpuDevType;

typedef enum tagRtAicpuDeployType {
    AICPU_DEPLOY_CROSS_OS = 0x0,
    AICPU_DEPLOY_CROSS_PROCESS,
    AICPU_DEPLOY_CROSS_THREAD,
    AICPU_DEPLOY_RESERVED
} rtAicpuDeployType_t;

typedef enum tagRtFeatureType {
    FEATURE_TYPE_MEMCPY = 0,
    FEATURE_TYPE_MEMORY,
    FEATURE_TYPE_UPDATE_SQE,
    FEATURE_TYPE_RSV
} rtFeatureType_t;

typedef enum tagRtDeviceFeatureType {
    FEATURE_TYPE_SCHE,
    FEATURE_TYPE_BLOCKING_OPERATOR,
    FEATURE_TYPE_FFTS_MODE,
    FEATURE_TYPE_MEMQ_EVENT_CROSS_DEV,
    FEATURE_TYPE_MODEL_TASK_UPDATE,
    FEATURE_TYPE_END,
} rtDeviceFeatureType_t;

typedef enum tagMemcpyInfo {
    MEMCPY_INFO_SUPPORT_ZEROCOPY = 0,
    MEMCPY_INFO_RSV
} rtMemcpyInfo_t;

typedef enum tagMemoryInfo {
    MEMORY_INFO_TS_LIMITED = 0,
    MEMORY_INFO_RSV
} rtMemoryInfo_t;

typedef enum tagUpdateSQEInfo {
    UPDATE_SQE_SUPPORT_DSA = 0
} rtUpdateSQEInfo_t;

typedef enum tagRtDeviceModuleType {
    RT_MODULE_TYPE_SYSTEM = 0,  /**< system info*/
    RT_MODULE_TYPE_AICPU,       /** < aicpu info*/
    RT_MODULE_TYPE_CCPU,        /**< ccpu_info*/
    RT_MODULE_TYPE_DCPU,        /**< dcpu info*/
    RT_MODULE_TYPE_AICORE,      /**< AI CORE info*/
    RT_MODULE_TYPE_TSCPU,       /**< tscpu info*/
    RT_MODULE_TYPE_PCIE,        /**< PCIE info*/
    RT_MODULE_TYPE_VECTOR_CORE, /**< VECTOR CORE info*/
    RT_MODULE_TYPE_HOST_AICPU,   /**< HOST AICPU info*/
    RT_MODULE_TYPE_QOS,         /**<qos info> */
    RT_MODULE_TYPE_MEMORY      /**<memory info*/
} rtDeviceModuleType_t;

typedef enum tagRtPhyDeviceInfoType {
    RT_PHY_INFO_TYPE_CHIPTYPE = 0,
    RT_PHY_INFO_TYPE_MASTER_ID
} rtPhyDeviceInfoType_t;

typedef enum tagRtMemRequestFeature {
    MEM_REQUEST_FEATURE_DEFAULT = 0,
    MEM_REQUEST_FEATURE_OPP,
    MEM_REQUEST_FEATURE_RESERVED
} rtMemRequestFeature_t;

// used for rtGetDevMsg callback function
typedef void (*rtGetMsgCallback)(const char_t *msg, uint32_t len);

typedef enum tagGetDevMsgType {
    RT_GET_DEV_ERROR_MSG = 0,
    RT_GET_DEV_RUNNING_STREAM_SNAPSHOT_MSG,
    RT_GET_DEV_PID_SNAPSHOT_MSG,
    RT_GET_DEV_MSG_RESERVE
} rtGetDevMsgType_t;

typedef enum {
    QUERY_PROCESS_TOKEN,
    QUERY_TYPE_BUFF
} rtUbDevQueryCmd;

typedef struct {
    uint64_t va;
    uint64_t size;
    uint32_t tokenId;
    uint32_t tokenValue;
} rtMemUbTokenInfo;

typedef enum {
    RT_RES_TYPE_STARS_NOTIFY_RECORD = 0,
    RT_RES_TYPE_STARS_CNT_NOTIFY_RECORD,
    RT_RES_TYPE_STARS_RTSQ,
    RT_RES_TYPE_CCU_CKE,
    RT_RES_TYPE_CCU_XN,
    RT_RES_TYPE_STARS_CNT_NOTIFY_BIT_WR,
    RT_RES_TYPE_STARS_CNT_NOTIFY_ADD,
    RT_RES_TYPE_STARS_CNT_NOTIFY_BIT_CLR,
    RT_RES_TYPE_MAX
} rtDevResType_t;

typedef enum {
    RT_PROCESS_CP1 = 0,    /* aicpu_scheduler */
    RT_PROCESS_CP2,        /* custom_process */
    RT_PROCESS_DEV_ONLY,   /* TDT */
    RT_PROCESS_QS,         /* queue_scheduler */
    RT_PROCESS_HCCP,       /* hccp server */
    RT_PROCESS_USER,       /* user proc, can bind many on host or device. not surport quert from host pid */
    RT_PROCESS_CPTYPE_MAX
} rtDevResProcType_t;

typedef enum {
    RT_DEV_STATUS_INITING = 0x0,
    RT_DEV_STATUS_WORK,
    RT_DEV_STATUS_EXCEPTION,
    RT_DEV_STATUS_SLEEP,
    RT_DEV_STATUS_COMMUNICATION_LOST,
    RT_DEV_STATUS_RESERVED
} rtDevStatus_t;

typedef struct {
    uint32_t dieId;  // for ccu res need set devId, for others set 0
    rtDevResProcType_t procType;
    rtDevResType_t resType;
    uint32_t resId;
    uint32_t flag;
} rtDevResInfo;

typedef struct {
    uint64_t *resAddress;
    uint32_t *len;
} rtDevResAddrInfo;

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

typedef struct tagRtDbgCoreInfo {
	uint64_t aicBitmap0;
    uint64_t aicBitmap1;
	uint64_t aivBitmap0;
	uint64_t aivBitmap1;
} rtDbgCoreInfo_t;

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
 * @param
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtInit(void);

/**
 * @ingroup dvrt_dev
 * @brief get total device number.
 * @param
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API void rtDeinit(void);

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
 * @brief get device infomation.
 * @param [in] device   the device id
 * @param [in] moduleType   module type
               typedef enum {
                    MODULE_TYPE_SYSTEM = 0,   system info
                    MODULE_TYPE_AICPU,        aicpu info
                    MODULE_TYPE_CCPU,         ccpu_info
                    MODULE_TYPE_DCPU,         dcpu info
                    MODULE_TYPE_AICORE,       AI CORE info
                    MODULE_TYPE_TSCPU,        tscpu info
                    MODULE_TYPE_PCIE,         PCIE info
               } DEV_MODULE_TYPE;
 * @param [in] infoType   info type
               typedef enum {
                    INFO_TYPE_ENV = 0,
                    INFO_TYPE_VERSION,
                    INFO_TYPE_MASTERID,
                    INFO_TYPE_CORE_NUM,
                    INFO_TYPE_OS_SCHED,
                    INFO_TYPE_IN_USED,
                    INFO_TYPE_ERROR_MAP,
                    INFO_TYPE_OCCUPY,
                    INFO_TYPE_ID,
                    INFO_TYPE_IP,
                    INFO_TYPE_ENDIAN,
               } DEV_INFO_TYPE;
 * @param [out] val   the device info
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_DRV_ERR for error
 */
RTS_API rtError_t rtGetDeviceInfo(uint32_t deviceId, int32_t moduleType, int32_t infoType, int64_t *val);

/**
* @ingroup dvrt_dev
* @brief get phy device infomation.
* @param [int] phyId        the physic Id
* @param [int] moduleType   module type
* @param [int] infoType     info type
* @param [out] val          the device info
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_DRV_ERR for error
*/
RTS_API rtError_t rtGetPhyDeviceInfo(uint32_t phyId, int32_t moduleType, int32_t infoType, int64_t *val);

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
 * @brief enable direction:devIdDes---->phyIdSrc.
 * @param [in] devIdDes   the logical device id
 * @param [in] phyIdSrc   the physical device id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtEnableP2P(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t flag);

/**
 * @ingroup dvrt_dev
 * @brief disable direction:devIdDes---->phyIdSrc.
 * @param [in] devIdDes   the logical device id
 * @param [in] phyIdSrc   the physical device id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDisableP2P(uint32_t devIdDes, uint32_t phyIdSrc);

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
 * @brief get status
 * @param [in] devIdDes   the logical device id
 * @param [in] phyIdSrc   the physical device id
 * @param [in|out] status   status value
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetP2PStatus(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t *status);

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
 * @brief set chipType
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtSetSocVersion(const char_t *ver);

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
 * @brief get status
 * @param [in] devId   the logical device id
 * @param [in] otherDevId   the other logical device id
 * @param [in] infoType   info type
 * @param [in|out] val   pair info
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtGetPairDevicesInfo(uint32_t devId, uint32_t otherDevId, int32_t infoType, int64_t *val);

/**
 * @ingroup dvrt_dev
 * @brief get status
 * @param [in] devId   the physic device id
 * @param [in] otherDevId   the other physic device id
 * @param [in] infoType   info type
 * @param [in|out] val   pair info
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtGetPairPhyDevicesInfo(uint32_t devId, uint32_t otherDevId, int32_t infoType, int64_t *val);

/**
 * @ingroup dvrt_dev
 * @brief get capability infomation.
 * @param [in] featureType  feature type
               typedef enum tagRtFeatureType {
                    FEATURE_TYPE_MEMCPY = 0,
                    FEATURE_TYPE_RSV,
               } rtFeatureType_t;
 * @param [in] featureInfo  info type
               typedef enum tagMemcpyInfo {
                    MEMCPY_INFO_SUPPORT_ZEROCOPY = 0,
                    MEMCPY_INFO _RSV,
               } rtMemcpyInfo_t;
 * @param [out] val  the capability info RT_CAPABILITY_SUPPORT or RT_CAPABILITY_NOT_SUPPORT
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtGetRtCapability(rtFeatureType_t featureType, int32_t featureInfo, int64_t *val);

/**
 * @ingroup dvrt_dev
 * @brief set target device for current thread
 * @param [int] devId   the device id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtSetDeviceWithoutTsd(int32_t devId);

/**
 * @ingroup dvrt_dev
 * @brief reset all opened device
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDeviceResetWithoutTsd(int32_t devId);

/**
 * @ingroup dvrt_dev
 * @brief get device message
 * @param [in] rtGetDevMsgType_t getMsgType:msg type
 * @param [in] GetMsgCallback callback:acl callback function
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetDevMsg(rtGetDevMsgType_t getMsgType, rtGetMsgCallback callback);

/**
 * @ingroup dvrt_dev
 * @brief get ts mem type
 * @param [in] rtMemRequestFeature_t mem request feature type
 * @param [in] mem request size
 * @return RT_MEMORY_TS, RT_MEMORY_HBM, RT_MEMORY_TS | RT_MEMORY_POLICY_HUGE_PAGE_ONLY
 */
RTS_API uint32_t rtGetTsMemType(rtMemRequestFeature_t featureType, uint32_t memSize);

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
 * @ingroup
 * @brief get serverid by sdid
 * @param [int] sdid   sdid
 * @param [out] *srvId serverid
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetServerIDBySDID(uint32_t sdid, uint32_t *srvId);

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
* @ingroup
* @brief set debug dump mode
* @param [in] mode    : dump mode
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtDebugSetDumpMode(const uint64_t mode);

/**
* @ingroup
* @brief get stalled core id in current process
* @param [out] coreInfo    : physics core id used
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtDebugGetStalledCore(rtDbgCoreInfo_t *const coreInfo);

/**
* @ingroup dvrt_dev
* @brief Get device uuid
* @param [in] devId user device ID
* @param [out] uuid rtUuid struct
* @return ACL_RT_SUCCESS for get uuid successfully
* @return ACL_ERROR_RT_FEATURE_NOT_SUPPORT for driver or device not support uuid feature
*/
RTS_API rtError_t rtGetDeviceUuid(const int32_t devId, rtUuid_t *uuid);
#define RT_DEVICE_FLAG_DEFAULT (0x0U)
#define RT_DEVICE_FLAG_NOT_START_CPU_SCHED (0x1U)

/**
 * @ingroup dvrt_dev
 * @brief set device with different flags
* @param [in] deviceId    : device id
* @param [in] flags    : flags
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtSetDeviceWithFlags(int32_t deviceId, uint64_t flags);

#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_DEVICE_H
