/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef INC_TDT_TSD_H_
#define INC_TDT_TSD_H_

#include <stdint.h>
#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

/**
* @ingroup  Tsdaemon.
*
* Identifies that HCCP or Compute_process is waiting for
* Tsdaemon to issue a shutdown command.
*/
typedef enum {
    TSD_HCCP = 0,    /**< HCCP*/
    TSD_COMPUTE = 1, /**< Compute_process*/
    TSD_CUSTOM_COMPUTE = 2, /**< Custom Compute_process*/
    TSD_QS = 3,
    TSD_WAITTYPE_MAX /**< Max*/
} TsdWaitType;

typedef enum {
    TSD_EVENT_START_RSP = 0,                  // 0 start response: client -> server tsd
    TSD_EVENT_SHUTDOWN_RSP = 1,               // 1 shutdown response: client -> server tsd
    TSD_EVENT_NOTIFY_AICPUINFO = 2,           // 2 inform tsdaemon start aicpu_cust_schedule
    TSD_EVENT_NOTIFY_AICPUINFO_RSP = 3,       // 3 start aicpu_cust_schedule response
    TSD_EVENT_ABNORMAL = 4,                   // 4 aicpu_sd destroy: client -> server tsd
    TSD_EVENT_SHUTDOWN = 5,                   // 5 shutdown:tsd server -> client
    TSD_EVENT_LOAD_SO = 6,                    // 6 aicpu_sd inform cust aicpusd to load so
    TSD_EVENT_START_OR_STOP_FAIL = 7,         // 7 send host start/stop err msg client-> server tsd
    TSD_EVENT_GET_CAPABILITY = 8,             // 8 send get capability msg to subprocess
    TSD_EVENT_START_AICPU_SD_MODULE = 30,     // 30 send start aicpu module msg
    TSD_EVENT_START_AICPU_SD_MODULE_RSP = 31, // 31 start aicpu module msg rsp
    TSD_EVENT_START_QS_MODULE = 32,           // 32 send start qs module msg
    TSD_EVENT_START_QS_MODULE_RSP = 33,       // 33 start qs module msg rsp
    TSD_EVENT_STOP_AICPU_SD_MODULE = 34,      // 34 send stop aicpu module msg
    TSD_EVENT_STOP_AICPU_SD_MODULE_RSP = 35,  // 35 stop aicpu module msg rsp
    TSD_EVENT_STOP_QS_MODULE = 36,            // 36 send stop qs module msg
    TSD_EVENT_STOP_QS_MODULE_RSP = 37,        // 37 stop qs module msg rsp
    TSD_EVENT_UPDATE_PROFILING_RSP = 41,      // 38 update profiling mode msg rsp
    TSD_EVENT_TYPE_MAX
} TsdSubEventType;

#define MAX_EVENT_PRI_MSG_LENGTH (96U)
struct TsdSubEventInfo {
    uint32_t deviceId;                    // device id
    uint32_t srcPid;                      // send process pid
    uint32_t dstPid;                      // receive process pid
    uint32_t hostPid;                     // host pid
    uint8_t  vfId;                        // vf id
    uint8_t  rsv;                         // reserve
    uint16_t reqId;                       // req Id
    uint32_t procType;                    // process type
    uint32_t eventType;                   // event type
    uint32_t startProcPid;                // startup process pid
    char priMsg[MAX_EVENT_PRI_MSG_LENGTH]; // so name
};

typedef int32_t (* SubProcEventCallBackFuncInfo)(const struct TsdSubEventInfo * const msg);

struct SubProcEventCallBackInfo {
    uint32_t eventType;
    SubProcEventCallBackFuncInfo callBackFunc;
};

/**
* @ingroup TsdWaitForShutdown
* @brief Wait for the TSD process to issue the shutdown command
*
* @par Function
* Wait for the TSD process to issue the shutdown command
*
* @param NA
* @param deviceId [IN] type #unsigned int. Physical device ID
* @param waitType [IN] type #TsdWaitType. HCCP or CP
* @param hostPid [IN] type #unsigned int. Host pid
* @param vfId [IN] type #unsigned int. Virtual force Id
* @retval 0 Success
* @retval OtherValues 0 Fail
*
* @par Dependency
* @li libtsdppc.so: Library to which the interface belongs.
* @li tsd.h: Header file where the interface declaration is located.
*/
int32_t TsdWaitForShutdown(const uint32_t deviceId, const TsdWaitType waitType,
                           const uint32_t hostPid, const uint32_t vfId);

int32_t TsdReportStartOrStopErrCode(const uint32_t deviceId, const TsdWaitType waitType,
                                    const uint32_t hostPid, const uint32_t vfId,
                                    const char *errCode, const uint32_t errLen);

/**
* @ingroup tsd_event_client
* @brief reg event call back func to tsdclient
* @param [in] SubProcEventCallBackInfo : event id, callbackfunc
* @return TSD_OK: success, other: error code
*/
int32_t RegEventMsgCallBackFunc(const struct SubProcEventCallBackInfo *regInfo);

/**
* @ingroup tsd_event_client
* @brief unreg event call back func to tsdclient
* @param [in]  : event id
* @return void
*/
void UnRegEventMsgCallBackFunc(const uint32_t eventType);

/**
* @ingroup tsd_event_client
* @brief reg event call back func to tsdclient
* @param [in] SubProcEventCallBackInfo : event id, callbackfunc
* @return TSD_OK: success, other: error code
*/

/**
* @ingroup tsd_event_client
* @brief sub module send start success message to tsd
* @param [in] deviceId : device id
* @param [in] waitType : process type
* @param [in] hostPid :  host pid
* @param [in] vfId : vf id
* @param [in] eventType : eventType
* @return TSD_OK: success, other: error code
*/
int32_t SubModuleProcessResponse(const uint32_t deviceId, const TsdWaitType waitType,
                                 const uint32_t hostPid, const uint32_t vfId,
                                 const uint32_t eventType);

int32_t TsdDestroy(const uint32_t deviceId, const TsdWaitType waitType,
                   const uint32_t hostPid, const uint32_t vfId);
#ifdef __cplusplus
}
#endif  // __cplusplus
#endif  // INC_TDT_TSD_H_