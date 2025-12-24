/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_STARS_H
#define CCE_RUNTIME_RT_STARS_H

#include "base.h"
#include "rt_stars_define.h"
#if defined(__cplusplus)
extern "C" {
#endif

/**
 * @ingroup rt_stars
 * @brief launch stars task.
 * used for send star sqe directly.
 * @param [in] taskSqe     stars task sqe
 * @param [in] sqeLen      stars task sqe length
 * @param [in] stm      associated stream
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtStarsTaskLaunch(const void *taskSqe, uint32_t sqeLen, rtStream_t stm);

/**
 * @ingroup rt_stars
 * @brief launch stars task.
 * used for send star sqe directly.
 * @param [in] taskSqe     stars task sqe
 * @param [in] sqeLen      stars task sqe length
 * @param [in] stm         associated stream
 * @param [in] flag        dump flag
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtStarsTaskLaunchWithFlag(const void *taskSqe, uint32_t sqeLen, rtStream_t stm, uint32_t flag);

/**
 * @ingroup rt_stars
 * @brief launch common cmo task on the stream.
 * @param [in] taskInfo     cmo task info
 * @param [in] stm          launch task on the stream
 * @param [in] flag         flag
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtCmoTaskLaunch(rtCmoTaskInfo_t *taskInfo, rtStream_t stm, uint32_t flag);

/**
 * @ingroup dvrt_mem
 * @brief launch common cmo task on the stream.
 * @param [in] cmoAddrInfo      cmo task info
 * @param [in] destMax          destMax
 * @param [in] cmoOpCode        opcode
 * @param [in] stm              launch task on the stream
 * @param [in] flag             flag
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtCmoAddrTaskLaunch(void *cmoAddrInfo, uint64_t destMax, rtCmoOpCode_t cmoOpCode,
    rtStream_t stm, uint32_t flag);

/**
 * @ingroup rt_stars
 * @brief launch common cmo task on the stream.
 * @param [in] srcAddrPtr     prefetch addrs
 * @param [in] srcLen         prefetch addrs load
 * @param [in] cmoType        opcode   
 * @param [in] stm            stream
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtCmoAsync(void *srcAddrPtr, size_t srcLen, rtCmoOpCode_t cmoType, rtStream_t stm);

/**
 * @ingroup rt_stars
 * @brief launch barrier cmo task on the stream.
 * @param [in] taskInfo     barrier task info
 * @param [in] stm          launch task on the stream
 * @param [in] flag         flag
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtBarrierTaskLaunch(rtBarrierTaskInfo_t *taskInfo, rtStream_t stm, uint32_t flag);

/**
 * @ingroup rt_stars
 * @brief dvpp group handle.
 */
typedef void *rtDvppGrp_t;

typedef struct tagDvppGrpRptInfo {
    uint32_t deviceId;
    uint32_t streamId;
    uint32_t taskId;
    uint8_t sqeType;
    uint8_t cqeErrorCode;
    uint8_t reserve[2];
    uint32_t accErrorCode;
} rtDvppGrpRptInfo_t;

typedef void (*rtDvppGrpCallback)(rtDvppGrpRptInfo_t *rptInfo);

/**
 * @ingroup rt_stars
 * @brief create dvpp group.
 * @param [in] flags     group flag, reserved parameter
 * @param [out] grp      group handle
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtDvppGroupCreate(rtDvppGrp_t *grp, uint32_t flags);

/**
 * @ingroup rt_stars
 * @brief destroy dvpp group.
 * @param [in] grp      group handle
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtDvppGroupDestory(rtDvppGrp_t grp);

/**
 * @ingroup rt_stars
 * @brief create stream with grp handle
 * @param [in|out] stm   created stream
 * @param [in] priority   stream priority
 * @param [in] flags  stream op flags
 * @param [in] grp    grp handle
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtStreamCreateByGrp(rtStream_t *stm, int32_t priority, uint32_t flags, rtDvppGrp_t grp);

/**
 * @ingroup rt_stars
 * @brief wait report by grp
 * @param [in] grp              group handle
 * @param [in] callBackFunc     callback
 * @param [in] timeout          wait timeout config, ms, -1: wait forever
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtDvppWaitGroupReport(rtDvppGrp_t grp, rtDvppGrpCallback callBackFunc, int32_t timeout);

/*
 * @ingroup dvrt_stream
 * @brief set stream geOpTag
 * @param [in] stm: stream handle
 * @param [in] geOpTag
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtSetStreamTag(rtStream_t stm, uint32_t geOpTag);

/*
 * @ingroup rt_stars
 * @brief build multiple task
 * @param [in] taskInfo(rtMultipleTaskInfo_t)
 * @param [in] stm: stream handle
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMultipleTaskInfoLaunch(const void *taskInfo, rtStream_t stm);

  /*
 * @ingroup rt_stars
 * @brief build multiple task
 * @param [in] taskInfo(rtMultipleTaskInfo_t)
 * @param [in] stm: stream handle
 * @param [in] flag
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtMultipleTaskInfoLaunchWithFlag(const void *taskInfo, rtStream_t stm, const uint32_t flag);

// general ctrl type
typedef enum tagGeneralCtrlType {
    RT_GNL_CTRL_TYPE_MEMCPY_ASYNC_CFG = 0,
    RT_GNL_CTRL_TYPE_REDUCE_ASYNC_CFG = 1,
    RT_GNL_CTRL_TYPE_FFTS_PLUS_FLAG = 2,
    RT_GNL_CTRL_TYPE_FFTS_PLUS = 3,
    RT_GNL_CTRL_TYPE_NPU_GET_FLOAT_STATUS = 4,
    RT_GNL_CTRL_TYPE_NPU_CLEAR_FLOAT_STATUS = 5,
    RT_GNL_CTRL_TYPE_STARS_TSK = 6,
    RT_GNL_CTRL_TYPE_CMO_TSK = 9,
    RT_GNL_CTRL_TYPE_BARRIER_TSK = 10,
    RT_GNL_CTRL_TYPE_STARS_TSK_FLAG = 11,
    RT_GNL_CTRL_TYPE_SET_STREAM_TAG = 12,
    RT_GNL_CTRL_TYPE_MULTIPLE_TSK = 13,
    RT_GNL_CTRL_TYPE_NPU_GET_FLOAT_DEBUG_STATUS = 14,
    RT_GNL_CTRL_TYPE_NPU_CLEAR_FLOAT_DEBUG_STATUS = 15,
    RT_GNL_CTRL_TYPE_MULTIPLE_TSK_FLAG = 16, // invoke rtMultipleTaskInfoLaunchWithFlag
    RT_GNL_CTRL_TYPE_MAX
} rtGeneralCtrlType_t;

/**
 * @ingroup rt_stars
 * @brief gerneral ctrl if
 * @param [in] ctl              ctl input
 * @param [in] num              ctl input num
 * @param [in] type             ctl type
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtGeneralCtrl(uintptr_t *ctrl, uint32_t num, uint32_t type);

/**
 * @ingroup rt_stars
 * @brief translate addr
 * @param [out] needTranslate
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtNeedDevVA2PA(bool *need);
 
/**
 * @ingroup rt_stars
 * @brief translate addr from va to pa
 * @param [in] devAddr translate addr
 * @param [in] len addr len
 * @param [in] stm stream
* @param [in] isAsync async or sync
 * @return RT_ERROR_NONE for ok, others failed
 */
RTS_API rtError_t rtDevVA2PA(uint64_t devAddr, uint64_t len, rtStream_t stm, bool isAsync);

#if defined(__cplusplus)
}
#endif
#endif  // CCE_RUNTIME_RT_STARS_H
