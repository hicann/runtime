/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_EXTERNAL_EVENT_H
#define CCE_RUNTIME_RT_EXTERNAL_EVENT_H

#include "rt_external_base.h"
#include "rt_external_stars_define.h"

#if defined(__cplusplus)
extern "C" {
#endif

/**
 * @ingroup dvrt_event
 * @brief Get the physical address corresponding to notify
 * @param [in] notify notify to be queried
 * @param [in] devAddrOffset  device physical address offset
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_DRV_ERR for driver error
 */
RTS_API rtError_t rtNotifyGetAddrOffset(rtNotify_t notify, uint64_t *devAddrOffset);

/**
 * @ingroup dvrt_event
 * @brief Get notify phy info
 * @param [in] notify the created/opened notify
 * @param [out] phyDevId phy device id
 * @param [out] tsId ts id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtNotifyGetPhyInfo(rtNotify_t notify, uint32_t *phyDevId, uint32_t *tsId);

typedef struct tagNotifyPhyInfo {
    uint32_t phyId;  /* phy id */
    uint32_t tsId;   /* ts id */
    uint32_t idType; /* SHR_ID_NOTIFY_TYPE */
    uint32_t shrId;  /* notify id */
    uint32_t flag;   /* RT_NOTIFY_FLAG_SHR_ID_SHADOW for remote id or shadow node */
    uint32_t rsv[3];
} rtNotifyPhyInfo;

/**
 * @ingroup dvrt_event
 * @brief Get notify phy and pod info
 * @param [in] notify the created/opened notify
 * @param [out] phyDevId phy device id
 * @param [out] tsId ts id
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtNotifyGetPhyInfoExt(rtNotify_t notify, rtNotifyPhyInfo *notifyInfo);

//dfx
// max task tag buffer is 1024(include '\0')
#define TASK_TAG_MAX_LEN    1024U

/**
 * @brief set task tag.
 * once set is only use by one task and thread local.
 * attention:
 *  1. it's used for dump current task in active stream now.
 *  2. it must be called be for task submit and will be invalid after task submit.
 * @param [in] taskTag  task tag, usually it's can be node name or task name.
 *                      must end with '\0' and max len is TASK_TAG_MAX_LEN.
 * @return RT_ERROR_NONE for ok
 * @return other failed
 */
RTS_API rtError_t rtSetTaskTag(const char_t *taskTag);

/**
 * @ingroup dvrt_event
 * @brief set event work mode
 * @param [in] mode // 0 default Software events; 1 HardWare events
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtEventWorkModeSet(uint8_t mode);

/**
 * @ingroup dvrt_event
 * @brief get event work mode
 * @param [out] mode // 0 default Software events; 1 HardWare events
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtEventWorkModeGet(uint8_t *mode);

/**
 * @ingroup dvrt_event
 * @brief Reset all Notify for the current device in the current process
 * @return ACL_RT_SUCCESS for ok, errno for failed
 */
RTS_API rtError_t rtNotifyResetAll();

#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_RT_EXTERNAL_EVENT_H