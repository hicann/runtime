/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __MAKE_OP_EXECUTOR_H__
#define __MAKE_OP_EXECUTOR_H__
#include <set>
#include "opdev/platform.h"
#include "opdev/op_arg_def.h"
#include "opdev/op_executor.h"

using namespace std;
#define CREATE_EXECUTOR() UniqueExecutor(__func__)

// todo: consider reusing OpArgContext
#define INFER_SHAPE(KERNEL_NAME, op_args...)                                                           \
    ({  aclnnStatus inferShapeRet;                                                                     \
        do {                                                                                           \
            op::OpArgContext *opArgCtx = GetOpArgContext(op_args);                                     \
            if (opArgCtx == nullptr){                                                                  \
                inferShapeRet = ACLNN_ERR_PARAM_NULLPTR;                                               \
            } else {                                                                                   \
                inferShapeRet = InferShape(KERNEL_NAME##OpTypeId(),                                    \
                                            *opArgCtx->GetOpArg(op::OP_INPUT_ARG),                     \
                                            *opArgCtx->GetOpArg(op::OP_OUTPUT_ARG),                    \
                                            *opArgCtx->GetOpArg(op::OP_ATTR_ARG));                     \
                op::DestroyOpArgContext(opArgCtx);                                                     \
            }                                                                                          \
        } while (0); inferShapeRet;                                                                    \
    })

// WARNING: args are rvalue and will be moved. but args are used twice in the macro,
//          so DO NOT put rvalue in args as the rvalue in args will be empty in second usage.
// TODO: check GET_WORKSPACE error
#define ADD_TO_LAUNCHER_LIST_AICORE(KERNEL_NAME, op_args...)                                 \
    ({  aclnnStatus addToLaunchRet;                                                          \
        do {                                                                                 \
            op::OpArgContext *opArgCtx = GetOpArgContext(op_args);                           \
            addToLaunchRet = CreatAiCoreKernelLauncher(#KERNEL_NAME, KERNEL_NAME##OpTypeId(),\
                                                       executor, opArgCtx);                  \
        } while (0); addToLaunchRet;                                                         \
    })

#define ADD_TO_LAUNCHER_LIST_DSA(KERNEL_NAME, op_args...)                                    \
    do {                                                                                     \
        op::OpArgContext *opArgCtx = GetOpArgContext(op_args);                               \
        CreatDSAKernelLauncher(#KERNEL_NAME, KERNEL_NAME##OpTypeId(), KERNEL_NAME##TaskType, \
            executor, opArgCtx);                                                             \
    } while (0)

#endif
