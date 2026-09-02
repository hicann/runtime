/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_wrap.h"

namespace {
PyMethodDef g_methodsProf[] = {
    {"create_config", WrapAclProfCreateConfig, METH_VARARGS, "create config"},
    {"destroy_config", WrapAclProfDestroyConfig, METH_VARARGS, "destroy config"},
    {"init", WrapAclProfInit, METH_VARARGS, "init"},
    {"finalize", WrapAclProfFinalize, METH_VARARGS, "finalize"},
    {"start", WrapAclProfStart, METH_VARARGS, "start"},
    {"stop", WrapAclProfStop, METH_VARARGS, "stop"},
    {"model_subscribe", WrapAclProfModelSubscribe, METH_VARARGS, "model subscribe"},
    {"model_un_subscribe", WrapAclProfModelUnSubscribe, METH_VARARGS,
     "model un subscribe"}, // pyACL接口命名错误，客户界面兼容遗留
    {"model_unsubscribe", WrapAclProfModelUnSubscribe, METH_VARARGS, "model unsubscribe"},
    {"create_subscribe_config", WrapAclProfCreateSubscribeConfig, METH_VARARGS, "create subscribe config"},
    {"destroy_subscribe_config", WrapAclProfDestroySubscribeConfig, METH_VARARGS, "destroy subscribe config"},
    {"get_op_desc_size", WrapAclProfGetOpDescSize, METH_VARARGS, "get op desc size"},
    {"get_op_num", WrapAclProfGetOpNum, METH_VARARGS, "get op num"},
    {"get_op_type", WrapAclProfGetOpType, METH_VARARGS, "get op type"},
    {"get_op_name", WrapAclProfGetOpName, METH_VARARGS, "get op name"},
    {"get_op_type_v2", WrapAclProfGetOpTypeV2, METH_VARARGS, "get op type"},
    {"get_op_name_v2", WrapAclProfGetOpNameV2, METH_VARARGS, "get op name"},
    {"get_op_start", WrapAclProfGetOpStart, METH_VARARGS, "get op start"},
    {"get_op_end", WrapAclProfGetOpEnd, METH_VARARGS, "get op end"},
    {"get_op_duration", WrapAclProfGetOpDuration, METH_VARARGS, "get op duration"},
    {"get_model_id", WrapAclProfGetModelId, METH_VARARGS, "get model id"},
    {"get_op_type_len", WrapAclProfGetOpTypeLen, METH_VARARGS, "get op type len"},
    {"get_op_name_len", WrapAclProfGetOpNameLen, METH_VARARGS, "get op name len"},
    {"get_step_timestamp", WrapAclProfGetStepTimestamp, METH_VARARGS, "get step timestamp"},
    {"destroy_step_info", WrapAclProfDestroyStepInfo, METH_VARARGS, "destroy step info"},
    {"create_step_info", WrapAclProfCreateStepInfo, METH_VARARGS, "create step info"},
    {"create_stamp", WrapAclProfCreateStamp, METH_VARARGS, "create stamp"},
    {"destroy_stamp", WrapAclProfDestroyStamp, METH_VARARGS, "destroy stamp"},
    {"push", WrapAclProfPush, METH_VARARGS, "push"},
    {"pop", WrapAclProfPop, METH_VARARGS, "pop"},
    {"range_start", WrapAclProfRangeStart, METH_VARARGS, "range start"},
    {"range_stop", WrapAclProfRangeStop, METH_VARARGS, "range stop"},
    {"set_stamp_trace_message", WrapAclProfSetStampTraceMessage, METH_VARARGS, "set stamp trace message"},
    {"mark", WrapAclProfMark, METH_VARARGS, "mark"},
    {"mark_ex", WrapAclProfMarkEx, METH_VARARGS, "mark ex"},
    {"set_config", WrapAclProfSetConfig, METH_VARARGS, "set config"},
    {nullptr, nullptr, 0, nullptr}};
}

PyMethodDef* GetProfMethods() { return g_methodsProf; }