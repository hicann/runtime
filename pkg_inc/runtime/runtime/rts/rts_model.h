/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RTS_MODEL_H
#define CCE_RUNTIME_RTS_MODEL_H

#include <stdlib.h>

#include "base.h"
#include "rt_model.h"

#if defined(__cplusplus)
extern "C" {
#endif

#define RT_MODEL_STREAM_FLAG_HEAD 0x0U // first stream
#define RT_MODEL_STREAM_FLAG_DEFAULT 0x7FFFFFFFU

typedef enum {
    RT_UPDATE_DSA_TASK = 1,
    RT_UPDATE_AIC_AIV_TASK,
    RT_UPDATE_MAX
} rtUpdateTaskAttrId;

typedef struct {
   void *srcAddr;
   size_t size;
   uint32_t rsv[4];
} rtDsaTaskUpdateAttr_t;

typedef struct {
  void *binHandle; // program handle
  void *funcEntryAddr;
  void *blockDimAddr;
  uint32_t rsv[4];
} rtAicAivTaskUpdateAttr_t;

typedef union {
  rtDsaTaskUpdateAttr_t dsaTaskAttr;
  rtAicAivTaskUpdateAttr_t aicAivTaskAttr;
} rtUpdateTaskAttrVal_t;

typedef struct {
   rtUpdateTaskAttrId id;
   rtUpdateTaskAttrVal_t val;
} rtTaskUpdateCfg_t;

/**
 * @ingroup rts_model
 * @brief launch update task (tiling sink senario & dvpp update)
 * @param [in] destStm destination stream
 * @param [in] destTaskId destination task id
 * @param [in] stm  associated stream
 * @param [in] cfg  task update config
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsLaunchUpdateTask(rtStream_t destStm, uint32_t destTaskId, rtStream_t stm, rtTaskUpdateCfg_t *cfg);

/**
 * @ingroup rts_model
 * @brief create model
 * @param [in] mdl  created model
 * @param [in] flag reserved
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsModelCreate(rtModel_t *mdl, uint32_t flag);

/**
 * @ingroup rts_model
 * @brief bind model and stream instance
 * @param [in] mdl  binded model
 * @param [in] stm  binded stream
 * @param [in] flag    whether first stream of model
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsModelBindStream(rtModel_t mdl, rtStream_t stm, uint32_t flag);

/**
 * @ingroup rts_model
 * @brief add a end graph task to stream
 * @param [in] mdl  model to execute
 * @param [in] stm  graph stream
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsEndGraph(rtModel_t mdl, rtStream_t stm);

/**
 * @ingroup rts_model
 * @brief tell runtime Model has been Loaded
 * @param [in] mdl  model to execute
 * @param [in] reserve  reserved
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsModelLoadComplete(rtModel_t mdl, void* reserve);

/**
 * @ingroup rts_model
 * @brief unbind model and stream instance
 * @param [in] mdl  unbinded model
 * @param [in] stm  unbinded stream
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsModelUnbindStream(rtModel_t mdl, rtStream_t stm);

/**
 * @ingroup rts_model
 * @brief destroy model instance
 * @param [in] mdl  model to destroy
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsModelDestroy(rtModel_t mdl);

/**
 * @ingroup rts_model
 * @brief execute model instance synchronously
 * @param [in] mdl model to execute, timeout for sync
 * @param [in] timeout  Max waiting duration of synchronization
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsModelExecute(rtModel_t mdl, int32_t timeout);

/**
 * @ingroup rts_model
 * @brief execute model instance asynchronously
 * @param [in] mdl  model to execute
 * @param [in] stm stream to execute
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsModelExecuteAsync(rtModel_t mdl, rtStream_t stm);

/**
 * @ingroup rts_label
 * @brief create label instance
 * @param [out] lbl   created label
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsLabelCreate(rtLabel_t *lbl);

/**
 * @ingroup rts_label
 * @brief destroy label instance
 * @param [in] lbl   label to destroy
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsLabelDestroy(rtLabel_t lbl);

/**
 * @ingroup rts_label
 * @brief create label switch list
 * @param [in] labels   model label list
 * @param [in] num   label number
 * @param [out] labelList   created label switch list
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsLabelSwitchListCreate(rtLabel_t *labels, size_t num, void **labelList);

/**
 * @ingroup rts_label
 * @brief destory label switch list
 * @param [in] labelList   label switch list to destroy
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsLabelSwitchListDestroy(void *labelList);

/**
 * @ingroup rts_label
 * @brief set label and stream instance
 * @param [in] lbl   set label
 * @param [in] stm   set stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsLabelSet(rtLabel_t lbl, rtStream_t stm);

/**
 * @ingroup rts_label
 * @brief label switch by index
 * @param [in] ptr   index value ptr
 * @param [in] maxValue   index max value
 * @param [in] labelInfoPtr   label content info ptr
 * @param [in] stm   set stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsLabelSwitchByIndex(void *ptr, uint32_t maxValue, void *labelInfoPtr, rtStream_t stm);

/**
 * @ingroup rt_model
 * @brief set  model name
 * @param [in] mdl
 * @param [in] mdlName
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsModelSetName(rtModel_t mdl, const char_t *mdlName);

/**
 * @ingroup rt_model
 * @brief get  model name
 * @param [in] mdl
 * @param [in] maxLen
 * @param [out] mdlName
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsModelGetName(rtModel_t mdl, const uint32_t maxLen, char_t * const mdlName);


/**
 * @ingroup rt_model
 * @brief get model id
 * @param [in] mdl
 * @param [out] modelId   model id
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsModelGetId(rtModel_t mdl, uint32_t *modelId);

/**
 * @ingroup rt_model
 * @brief abort model
 * @param [in] mdl   model to abort
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtsModelAbort(rtModel_t mdl);


#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_RTS_MODEL_H