/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DEVICE_INNER_INC_TSD_EVENT_INTERFACE_H
#define DEVICE_INNER_INC_TSD_EVENT_INTERFACE_H

#include <map>
#include <string>
#include "tsd/status.h"
#include "driver/ascend_hal.h"
#include "inc/log.h"

namespace tsd {
// can not use 0 here, conflict with aicpu group
constexpr uint32_t DEFAULT_GROUP_ID = 30U;
constexpr uint32_t MAX_GROUP_NAME_LENGTH = 96U;
constexpr int32_t TIMEOUT_INTERVAL = 3000;

enum class TsdSubProcessType {
    PROCESS_HCCP = 0,                     // hccp process
    PROCESS_COMPUTE = 1,                  // aicpu_schedule process
    PROCESS_CUSTOM_COMPUTE = 2,           // aicpu_cust_schedule process
    PROCESS_QUEUE_SCHEDULE = 3,           // queue_schedule process
    PROCESS_UDF            = 4,           // udf
    PROCESS_NN             = 5,           // nn
    PROCESS_PROXY          = 6,           // proxy
    PROCESS_BUILTIN_UDF    = 7,           // builtin udf
    PROCESS_ADPROF         = 8,           // adprof
    PROCESS_MAXPROCTYPE    = 0xFF,        // max type
};

struct TsdCustStartEventInfo {
    uint32_t deviceId;                    // device id
    uint32_t srcPid;                      // send process pid
    uint32_t dstPid;                      // receive process pid
    uint32_t hostPid;                     // host pid
    uint32_t vfId;                        // vf id
    uint32_t procType;                    // process type
    uint32_t eventType;                   // event type
    uint32_t groupNameNum;                 // intial group name number
    char_t groupNameList[MAX_GROUP_NAME_LENGTH]; // initial group name list
};

struct TsdEventHeadInfo {
    uint32_t deviceId;                    // device id
    uint32_t srcPid;                      // send process pid
    uint32_t dstPid;                      // receive process pid
    uint32_t hostPid;                     // host pid
    uint8_t vfId;                         // vf id
    uint8_t reserve;                      // reserve
    uint16_t reqId;                       // request id
    uint32_t procType;                    // process type
    uint32_t eventType;                   // event type
};

class TsdEventInterface {
public:
    /**
     * @ingroup TsdEventInterface
     * @brief subscribe event
     * @param [in] deviceId : device id
     * @param [in] groupId : group id (0-31)
     * @param [in] tid : tid (0-15)
     * @return TSD_OK: success, other: error code
     */
    TSD_StatusT SubscribeEvent(const uint32_t deviceId, const uint32_t groupId, const uint32_t tid);

    /**
     * @ingroup TsdEventInterface
     * @brief wait and process event
     * @param [in] deviceId : device id
     * @param [in] groupId : group id (0-31)
     * @param [in] threadIndex : tid (0-15)
     * @param [in] timeoutInterval : event wait interval
     * @return TSD_OK: success, other: error code
     */
    int32_t WaitAndProcessEvent(const uint32_t deviceId, const uint32_t groupId, const uint32_t threadIndex,
                                    const int32_t timeoutInterval);

    /**
     * @ingroup TsdEventInterface
     * @brief process event info
     * @param [in] eventInfo : event info
     * @param [in] groupId : group id (0-31)
     * @param [in] index : tid (0-15)
     */
    virtual void ProcessEvent(event_info &eventInfo) = 0;

protected:
    TsdEventInterface() = default;
    virtual ~TsdEventInterface() {};;

    TsdEventInterface(const TsdEventInterface &) = delete;
    TsdEventInterface(TsdEventInterface &&) = delete;
    TsdEventInterface &operator=(const TsdEventInterface &) = delete;
    TsdEventInterface &operator=(TsdEventInterface &&) = delete;
};
}
#endif // DEVICE_INNER_INC_TSD_EVENT_INTERFACE_H
