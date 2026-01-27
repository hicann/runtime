/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __INC_TPRT_ERROR_CODE_H__
#define __INC_TPRT_ERROR_CODE_H__

#ifdef __cplusplus
extern "C" {
#endif

#define  TPRT_SUCCESS                0
#define  TPRT_INPUT_NULL             0x1
#define  TPRT_INPUT_INVALID          0x2
#define  TPRT_INPUT_OP_TYPE_INVALID  0x3
#define  TPRT_DEVICE_INVALID         0x5
#define  TPRT_DEVICE_NEW_FAILED      0x6
#define  TPRT_SQ_HANDLE_INVALID      0x7
#define  TPRT_SQ_HANDLE_NEW_FAILED   0x8
#define  TPRT_SQ_QUEUE_FULL          0x9
#define  TPRT_SQ_DEPTH_IS_INVALID    0xA
#define  TPRT_SQ_STATE_ABNORMAL      0xB
#define  TPRT_SQ_EMPTY               0xC
#define  TPRT_SQE_TYPE_IS_INVALID    0xD
#define  TPRT_SQE_PARA_IS_INVALID    0xE
#define  TPRT_CQ_QUEUE_FULL          0xF
#define  TPRT_CQ_HANDLE_INVALID      0x10
#define  TPRT_CQ_HANDLE_NEW_FAILED   0x11
#define  TPRT_WORKER_INVALID         0x12
#define  TPRT_WORKER_NEW_FAILED      0x13
#define  TPRT_START_WORKER_FAILED    0x14
#ifdef __cplusplus
}
#endif
#endif // __INC_TPRT_ERROR_CODE_H__