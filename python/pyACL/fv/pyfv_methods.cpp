/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "fv_retrieval.h"

namespace {
PyMethodDef g_methodsFv[] = {
    {"create_init_para", WrapAclfvCreateInitPara, METH_VARARGS, "create init_para of feature retrieval module "},
    {"destory_init_para", WrapAclfvDestroyInitPara, METH_VARARGS, "destroy init_para of feature retrieval module "},
    {"destroy_init_para", WrapAclfvDestroyInitPara, METH_VARARGS, "destroy init_para of feature retrieval module "},
    {"set_1n_top_num", WrapAclfvSet1NTopNum, METH_VARARGS, "set top num of 1:N module "},
    {"set_nm_top_num", WrapAclfvSetNMTopNum, METH_VARARGS, "set top num of N:M module "},
    {"init", WrapAclfvInit, METH_VARARGS, "initialize the feature retrieval module "},
    {"release", WrapAclfvRelease, METH_VARARGS, "release the feature retrieval module "},
    {"repo_add", WrapAclfvRepoAdd, METH_VARARGS, "add Features to the base repository "},
    {"repo_del", WrapAclfvRepoDel, METH_VARARGS, "delete Features to the base repository "},
    {"create_feature_info", WrapAclfvCreateFeatureInfo, METH_VARARGS, "create the feature info "},
    {"destroy_feature_info", WrapAclfvDestroyFeatureInfo, METH_VARARGS, "destroy the feature info "},
    {"create_repo_range", WrapAclfvCreateRepoRange, METH_VARARGS, "create range to the base repository "},
    {"destroy_repo_range", WrapAclfvDestroyRepoRange, METH_VARARGS, "destroy range of the base repository "},
    {"delete", WrapAclfvDel, METH_VARARGS, "delete the feature retrieval module"},
    {"modify", WrapAclfvModify, METH_VARARGS, "modify the feature retrieval module"},
    {"create_query_table", WrapAclfvCreateQueryTable, METH_VARARGS, "create query table of retrieval module "},
    {"destroy_query_table", WrapAclfvDestroyQueryTable, METH_VARARGS, "destroy query table of retrieval module "},
    {"create_search_input", WrapAclfvCreateSearchInput, METH_VARARGS, "create search input of retrieval module "},
    {"destroy_search_input", WrapAclfvDestroySearchInput, METH_VARARGS, "destroy search input of retrieval module "},
    {"create_search_result", WrapAclfvCreateSearchResult, METH_VARARGS, "create search result of retrieval module "},
    {"destroy_search_result", WrapAclfvDestroySearchResult, METH_VARARGS, "destory search result of retrieval module "},
    {"search", WrapAclfvSearch, METH_VARARGS, "search info of retrieval module"},
    {nullptr, nullptr, 0, nullptr}};
}

PyMethodDef* GetFvMethods() { return g_methodsFv; }