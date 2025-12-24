/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_EXTERNAL_DEVICE_H
#define CCE_RUNTIME_RT_EXTERNAL_DEVICE_H

#include "rt_external_base.h"

#if defined(__cplusplus)
extern "C" {
#endif

/**
 * @ingroup dvrt_dev
 * @brief set chipType
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtSetSocVersion(const char_t *ver);

/**
* @ingroup
* @brief set debug dump mode
* @param [in] mode    : dump mode
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_INVALID_VALUE for error input
*/
RTS_API rtError_t rtDebugSetDumpMode(const uint64_t mode);

typedef struct tagRtDbgCoreInfo {
	uint64_t aicBitmap0;
    uint64_t aicBitmap1;
	uint64_t aivBitmap0;
	uint64_t aivBitmap1;
} rtDbgCoreInfo_t;

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

typedef enum {
    QUERY_PROCESS_TOKEN,
    QUERY_TYPE_BUFF
} rtUbDevQueryCmd;

/**
 * @ingroup
 * @brief query ub device info
 * @param [in] cmd query info tpye
 * @param [in|out] info input/output parameter
 * @return RT_ERROR_NONE for ok, errno for failed
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtUbDevQueryInfo(rtUbDevQueryCmd cmd, void *devInfo);

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

/**
 * @ingroup dvrt_dev
 * @brief set target device for current thread
 * @param [int] devId   the device id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtSetDeviceWithoutTsd(int32_t devId);

// used for rtGetDevMsg callback function
typedef void (*rtGetMsgCallback)(const char_t *msg, uint32_t len);

typedef enum tagGetDevMsgType {
    RT_GET_DEV_ERROR_MSG = 0,
    RT_GET_DEV_RUNNING_STREAM_SNAPSHOT_MSG,
    RT_GET_DEV_PID_SNAPSHOT_MSG,
    RT_GET_DEV_MSG_RESERVE
} rtGetDevMsgType_t;

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
 * @ingroup rts_device
 * @brief get device feature ability by device id, such as task schedule ability.
 * @param [in] deviceId
 * @param [in] devFeatureType
 * @param [out] val
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsDeviceGetCapability(int32_t deviceId, int32_t devFeatureType, int32_t *val);

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
* @brief get phy device infomation.
* @param [int] phyId        the physic Id
* @param [int] moduleType   module type
* @param [int] infoType     info type
* @param [out] val          the device info
* @return RT_ERROR_NONE for ok
* @return RT_ERROR_DRV_ERR for error
*/
RTS_API rtError_t rtGetPhyDeviceInfo(uint32_t phyId, int32_t moduleType, int32_t infoType, int64_t *val);

#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_RT_EXTERNAL_DEVICE_H