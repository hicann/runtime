/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "op.h"

namespace {
PyMethodDef g_methodsOp[] = {
    {"set_model_dir", WrapAclOpSetModelDir, METH_VARARGS, "set op model dir"},
    {"load", WrapAclOpLoad, METH_VARARGS, "load op model"},
    {"execute", WrapAclOpExecute, METH_VARARGS, "execute op"},
    {"execute_with_handle", WrapAclOpExecWithHandle, METH_VARARGS, "execute op by handle"},
    {"cast", WrapAclOpCast, METH_VARARGS, "convert input data type"},
    {"create_handle_for_cast", WrapAclOpCreateHandleForCast, METH_VARARGS, "hande for convert input data type"},
    {"create_attr", WrapAclOpCreateAttr, METH_VARARGS, "create data of type aclopattr"},
    {"destroy_attr", WrapAclOpDestroyAttr, METH_VARARGS, "destroy data of type aclopattr"},
    {"set_attr_bool", WrapAclOpSetAttrBool, METH_VARARGS, "set scalar type to bool"},
    {"set_attr_int", WrapAclOpSetAttrInt, METH_VARARGS, "set scalar type to int64_t"},
    {"set_attr_float", WrapAclOpSetAttrFloat, METH_VARARGS, "set scalar type to float"},
    {"set_attr_string", WrapAclOpSetAttrString, METH_VARARGS, "set scalar type to string"},
    {"set_attr_list_bool", WrapAclOpSetAttrListBool, METH_VARARGS, "set list type to bool"},
    {"set_attr_list_int", WrapAclOpSetAttrListInt, METH_VARARGS, "set list type to int64_t"},
    {"set_attr_list_float", WrapAclOpSetAttrListFloat, METH_VARARGS, "set list type to float"},
    {"set_attr_list_string", WrapAclOpSetAttrListString, METH_VARARGS, "set list type to string"},
    {"set_attr_list_list_int", WrapAclOpSetAttrListListInt, METH_VARARGS, "set list list type to int64_t"},
    {"create_handle", WrapAclOpCreateHandle, METH_VARARGS, "create handle for op execute"},
    {"destroy_handle", WrapAclOpDestroyHandle, METH_VARARGS, "destroy handle for op execute"},
    {"start_dump_args", WrapAclOpStartDumpArgs, METH_VARARGS, "start dump args"},
    {"stop_dump_args", WrapAclOpStopDumpArgs, METH_VARARGS, "stop dump args"},
    {"register_compile_func", WrapAclOpRegisterCompileFunc, METH_VARARGS, "register compile func"},
    {"unregister_compile_func", WrapAclOpUnregisterCompileFunc, METH_VARARGS, "unregister compile func"},
    {"create_kernel", WrapAclOpCreateKernel, METH_VARARGS, "create kernel"},
    {"set_kernel_args", WrapAclOpSetKernelArgs, METH_VARARGS, "set kernel args"},
    {"set_kernel_workspace_sizes", WrapAclOpSetKernelWorkspaceSizes, METH_VARARGS, "set kernel workspace sizes"},
    {"update_params", WrapAclOpUpdateParams, METH_VARARGS, "update params"},
    {"execute_v2", WrapAclOpExecuteV2, METH_VARARGS, "execute v2"},
    {"infer_shape", WrapAclOpInferShape, METH_VARARGS, "infer shape"},
    {"set_attr_data_type", WrapAclOpSetAttrDataType, METH_VARARGS, "set attr data type"},
    {"set_attr_list_data_type", WrapAclOpSetAttrListDataType, METH_VARARGS, "set attr list data type"},
    {"set_max_op_queue_num", WrapAclOpSetMaxOpQueueNum, METH_VARARGS, "op set max op queue num"},
    {nullptr, nullptr, 0, nullptr}};
}

PyMethodDef* GetOpMethods() { return g_methodsOp; }