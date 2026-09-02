/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <acl/ops/acl_fv.h>
#include <acl/acl.h>
#include "fv_retrieval.h"

PyObject* WrapAclfvCreateInitPara(PyObject* /* self */, PyObject* args)
{
    uint64_t fsNum = 0;
    CHECK_NULL(PyArg_ParseTuple(args, "K", &fsNum), "acl.fv.create_init_para args parse failed!");

    aclfvInitPara* initPara = aclfvCreateInitPara(fsNum);
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(initPara));
}

PyObject* WrapAclfvDestroyInitPara(PyObject* /* self */, PyObject* args)
{
    aclfvInitPara* initPara = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &initPara), "acl.fv.destroy_init_para args parse failed!");

    aclError ret = aclfvDestroyInitPara(initPara);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclfvSet1NTopNum(PyObject* /* self */, PyObject* args)
{
    aclfvInitPara* initPara = nullptr;
    uint32_t maxTopNumFor1N = 0;
    CHECK_NULL(PyArg_ParseTuple(args, "kI", &initPara, &maxTopNumFor1N), "acl.fv.set_1n_top_num args parse failed!");

    aclError ret = aclfvSet1NTopNum(initPara, maxTopNumFor1N);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclfvSetNMTopNum(PyObject* /* self */, PyObject* args)
{
    aclfvInitPara* initPara = nullptr;
    uint32_t maxTopNumForNM = 0;
    CHECK_NULL(PyArg_ParseTuple(args, "kI", &initPara, &maxTopNumForNM), "acl.fv.set_nm_top_num args parse failed!");

    aclError ret = aclfvSetNMTopNum(initPara, maxTopNumForNM);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclfvInit(PyObject* /* self */, PyObject* args)
{
    aclfvInitPara* initPara = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &initPara), "acl.fv.init args parse failed!");

    aclError ret = aclfvInit(initPara);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclfvRelease(PyObject* /* self */, PyObject* /* args */)
{
    aclError ret = aclfvRelease();
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclfvCreateFeatureInfo(PyObject* /* self */, PyObject* args)
{
    uint32_t id0 = 0;
    uint32_t id1 = 0;
    uint32_t offset = 0;
    uint32_t fLen = 0;
    uint32_t fCnt = 0;
    uint8_t* fData = nullptr;
    uint32_t fDataLen = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "IIIIIkI", &id0, &id1, &offset, &fLen, &fCnt, &fData, &fDataLen),
        "acl.fv.create_feature_info args parse failed!");

    aclfvFeatureInfo* feature = aclfvCreateFeatureInfo(id0, id1, offset, fLen, fCnt, fData, fDataLen);
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(feature));
}

PyObject* WrapAclfvDestroyFeatureInfo(PyObject* /* self */, PyObject* args)
{
    aclfvFeatureInfo* feature = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &feature), "acl.fv.destroy_feature_info args parse failed!");

    aclError ret = aclfvDestroyFeatureInfo(feature);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclfvCreateRepoRange(PyObject* /* self */, PyObject* args)
{
    uint32_t id0min = 0;
    uint32_t id0max = 0;
    uint32_t id1min = 0;
    uint32_t id1max = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "IIII", &id0min, &id0max, &id1min, &id1max),
        "acl.fv.create_repo_range args parse failed!");

    aclfvRepoRange* reporange = aclfvCreateRepoRange(id0min, id0max, id1min, id1max);
    return Py_BuildValue("k", reinterpret_cast<uintptr_t>(reporange));
}

PyObject* WrapAclfvDestroyRepoRange(PyObject* /* self */, PyObject* args)
{
    aclfvRepoRange* reporange = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &reporange), "acl.fv.destroy_repo_range args parse failed!");

    aclError ret = aclfvDestroyRepoRange(reporange);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclfvRepoAdd(PyObject* /* self */, PyObject* args)
{
    aclfvSearchType type = SEARCH_1_N;
    aclfvFeatureInfo* featureInfo = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "Ik", &type, &featureInfo), "acl.fv.repo_add args parse failed!");

    aclError ret = aclfvRepoAdd(type, featureInfo);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclfvRepoDel(PyObject* /* self */, PyObject* args)
{
    aclfvSearchType type = SEARCH_1_N;
    aclfvRepoRange* reporange = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "Ik", &type, &reporange), "acl.fv.repo_del args parse failed!");

    aclError ret = aclfvRepoDel(type, reporange);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclfvDel(PyObject* /* self */, PyObject* args)
{
    aclfvFeatureInfo* featureInfo = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &featureInfo), "acl.fv.delete args parse failed!");

    aclError ret = aclfvDel(featureInfo);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclfvModify(PyObject* /* self */, PyObject* args)
{
    aclfvFeatureInfo* feature = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &feature), "acl.fv.modify args parse failed!");

    aclError ret = aclfvModify(feature);

    return Py_BuildValue("i", ret);
}

PyObject* WrapAclfvCreateQueryTable(PyObject* /* self */, PyObject* args)
{
    uint32_t querycnt = 0;
    uint32_t tablelen = 0;
    uint8_t* tabledata = nullptr;
    uint32_t tabledatalen = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "IIkI", &querycnt, &tablelen, &tabledata, &tabledatalen),
        "acl.fv.create_query_table args parse failed!");

    aclfvQueryTable* querytable = aclfvCreateQueryTable(querycnt, tablelen, tabledata, tabledatalen);
    return Py_BuildValue("k", querytable);
}

PyObject* WrapAclfvDestroyQueryTable(PyObject* /* self */, PyObject* args)
{
    aclfvQueryTable* querytable = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &querytable), "acl.fv.destroy_query_table args parse failed!");

    aclError ret = aclfvDestroyQueryTable(querytable);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclfvCreateSearchInput(PyObject* /* self */, PyObject* args)
{
    aclfvQueryTable* queryTable = nullptr;
    aclfvRepoRange* repoRange = nullptr;
    uint32_t topk = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "kkI", &queryTable, &repoRange, &topk), "acl.fv.create_search_input args parse failed!");

    aclfvSearchInput* rt = aclfvCreateSearchInput(queryTable, repoRange, topk);
    return Py_BuildValue("k", rt);
}

PyObject* WrapAclfvDestroySearchInput(PyObject* /* self */, PyObject* args)
{
    aclfvSearchInput* searchInput = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &searchInput), "acl.fv.destroy_search_input args parse failed!");

    aclError ret = aclfvDestroySearchInput(searchInput);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclfvCreateSearchResult(PyObject* /* self */, PyObject* args)
{
    uint32_t qcnt = 0;
    uint32_t* rtnum = nullptr;
    uint32_t rtdatalen = 0;
    uint32_t* id0 = nullptr;
    uint32_t* id1 = nullptr;
    uint32_t* rtoffset = nullptr;
    float* rtdist = nullptr;
    uint32_t datalen = 0;

    CHECK_NULL(
        PyArg_ParseTuple(args, "IkIkkkkI", &qcnt, &rtnum, &rtdatalen, &id0, &id1, &rtoffset, &rtdist, &datalen),
        "acl.fv.create_search_result args parse failed!");

    aclfvSearchResult* rt = aclfvCreateSearchResult(qcnt, rtnum, rtdatalen, id0, id1, rtoffset, rtdist, datalen);
    return Py_BuildValue("k", rt);
}

PyObject* WrapAclfvDestroySearchResult(PyObject* /* self */, PyObject* args)
{
    aclfvSearchResult* rt = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "k", &rt), "acl.fv.destroy_search_result args parse failed!");

    aclError ret = aclfvDestroySearchResult(rt);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclfvSearch(PyObject* /* self */, PyObject* args)
{
    aclfvSearchType type = SEARCH_1_N;
    aclfvSearchInput* searchinput = nullptr;
    aclfvSearchResult* searchrst = nullptr;

    CHECK_NULL(PyArg_ParseTuple(args, "Ikk", &type, &searchinput, &searchrst), "acl.fv.search args parse failed!");

    aclError ret = aclfvSearch(type, searchinput, searchrst);
    return Py_BuildValue("i", ret);
}
