/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "blas.h"
#include "acl/acl.h"
#include "acl/ops/acl_cblas.h"

PyObject* WrapAclblasGemvEx(PyObject* /* self */, PyObject* args)
{
    aclTransType transA = ACL_TRANS_N;
    int m = 0;
    int n = 0;
    void* alpha = nullptr;
    void* a = nullptr;
    int lda = 0;
    aclDataType dataTypeA = ACL_DT_UNDEFINED;
    void* x = nullptr;
    int incx = 0;
    aclDataType dataTypeX = ACL_DT_UNDEFINED;
    void* beta = nullptr;
    void* y = nullptr;
    int incy = 0;
    aclDataType dataTypeY = ACL_DT_UNDEFINED;
    aclComputeType type = ACL_COMPUTE_HIGH_PRECISION;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "iiikkiikiikkiiik", &transA, &m, &n, &alpha, &a, &lda, &dataTypeA, &x, &incx, &dataTypeX, &beta, &y,
            &incy, &dataTypeY, &type, &stream),
        "acl.blas.gemv_ex args parse failed");

    aclError ret = aclblasGemvEx(
        transA, m, n, alpha, a, lda, dataTypeA, x, incy, dataTypeX, beta, y, incy, dataTypeY, type, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclblasCreateHandleForGemvEx(PyObject* /* self */, PyObject* args)
{
    int m = 0;
    int n = 0;
    aclTransType transA = ACL_TRANS_N;
    aclDataType dataTypeA = ACL_DT_UNDEFINED;
    aclDataType dataTypeX = ACL_DT_UNDEFINED;
    aclDataType dataTypeY = ACL_DT_UNDEFINED;
    aclComputeType type = ACL_COMPUTE_HIGH_PRECISION;
    aclopHandle* handle = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iiiiiii", &transA, &m, &n, &dataTypeA, &dataTypeX, &dataTypeY, &type),
        "acl.blas.create_handle_for_gemv_ex args parse failed");

    aclError ret = aclblasCreateHandleForGemvEx(transA, m, n, dataTypeA, dataTypeX, dataTypeY, type, &handle);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(handle), ret);
}

PyObject* WrapAclblasHgemv(PyObject* /* self */, PyObject* args)
{
    int m = 0;
    int n = 0;
    aclTransType transA = ACL_TRANS_N;
    aclFloat16* alpha = nullptr;
    aclFloat16* a = nullptr;
    int lda = 0;
    aclFloat16* x = nullptr;
    int incx = 0;
    aclFloat16* beta = nullptr;
    aclFloat16* y = nullptr;
    int incy = 0;
    aclComputeType type = ACL_COMPUTE_HIGH_PRECISION;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "iiikkikikkiik", &transA, &m, &n, &alpha, &a, &lda, &x, &incx, &beta, &y, &incy, &type, &stream),
        "acl.blas.hgemv args parse failed");

    aclError ret = aclblasHgemv(transA, m, n, alpha, a, lda, x, incx, beta, y, incy, type, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclblasCreateHandleForHgemv(PyObject* /* self */, PyObject* args)
{
    int m = 0;
    int n = 0;
    aclTransType transA = ACL_TRANS_N;
    aclopHandle* handle = nullptr;
    aclComputeType type = ACL_COMPUTE_HIGH_PRECISION;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iiii", &transA, &m, &n, &type), "acl.blas.create_handle_for_hgemv args parse failed");

    aclError ret = aclblasCreateHandleForHgemv(transA, m, n, type, &handle);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(handle), ret);
}

PyObject* WrapAclblasS8gemv(PyObject* /* self */, PyObject* args)
{
    aclTransType transA = ACL_TRANS_N;
    int m = 0;
    int n = 0;
    int32_t* alpha = nullptr;
    int8_t* a = nullptr;
    int lda = 0;
    int8_t* x = nullptr;
    int incx = 0;
    int32_t* beta = nullptr;
    int32_t* y = nullptr;
    int incy = 0;
    aclComputeType type = ACL_COMPUTE_HIGH_PRECISION;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "iiikkikikkiik", &transA, &m, &n, &alpha, &a, &lda, &x, &incx, &beta, &y, &incy, &type, &stream),
        "acl.blas.s8gemv args parse failed");

    aclError ret = aclblasS8gemv(transA, m, n, alpha, a, lda, x, incx, beta, y, incy, type, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclblasCreateHandleForS8gemv(PyObject* /* self */, PyObject* args)
{
    int m = 0;
    int n = 0;
    aclTransType transA = ACL_TRANS_N;
    aclComputeType type = ACL_COMPUTE_HIGH_PRECISION;
    aclopHandle* handle = nullptr;
    CHECK_NULL(
        PyArg_ParseTuple(args, "iiii", &transA, &m, &n, &type), "acl.blas.create_handle_for_s8gemv args parse failed");

    aclError ret = aclblasCreateHandleForS8gemv(transA, m, n, type, &handle);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(handle), ret);
}

PyObject* WrapAclblasGemmEx(PyObject* /* self */, PyObject* args)
{
    aclTransType transA = ACL_TRANS_N;
    aclTransType transB = ACL_TRANS_N;
    aclTransType transC = ACL_TRANS_N;
    int m = 0;
    int n = 0;
    int k = 0;
    void* alpha = nullptr;
    void* matrixA = nullptr;
    int lda = 0;
    aclDataType dataTypeA = ACL_DT_UNDEFINED;
    void* matrixB = nullptr;
    int ldb = 0;
    aclDataType dataTypeB = ACL_DT_UNDEFINED;
    void* beta = nullptr;
    void* matrixC = nullptr;
    int ldc = 0;
    aclDataType dataTypeC = ACL_DT_UNDEFINED;
    aclComputeType type = ACL_COMPUTE_HIGH_PRECISION;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "iiiiiikkiikiikkiiik", &transA, &transB, &transC, &m, &n, &k, &alpha, &matrixA, &lda, &dataTypeA,
            &matrixB, &ldb, &dataTypeB, &beta, &matrixC, &ldc, &dataTypeC, &type, &stream),
        "acl.blas.gemm_ex args parse failed");

    aclError ret = aclblasGemmEx(
        transA, transB, transC, m, n, k, alpha, matrixA, lda, dataTypeA, matrixB, ldb, dataTypeB, beta, matrixC, ldc,
        dataTypeC, type, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclblasCreateHandleForGemmEx(PyObject* /* self */, PyObject* args)
{
    aclTransType transA = ACL_TRANS_N;
    aclTransType transB = ACL_TRANS_N;
    aclTransType transC = ACL_TRANS_N;
    int m = 0;
    int n = 0;
    int k = 0;
    aclDataType dataTypeA = ACL_DT_UNDEFINED;
    aclDataType dataTypeB = ACL_DT_UNDEFINED;
    aclDataType dataTypeC = ACL_DT_UNDEFINED;
    aclComputeType type = ACL_COMPUTE_HIGH_PRECISION;
    aclopHandle* handle = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "iiiiiiiiii", &transA, &transB, &transC, &m, &n, &k, &dataTypeA, &dataTypeB, &dataTypeC, &type),
        "acl.blas.create_handle_for_gemm_ex args parse failed");

    aclError ret =
        aclblasCreateHandleForGemmEx(transA, transB, transC, m, n, k, dataTypeA, dataTypeB, dataTypeC, type, &handle);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(handle), ret);
}

PyObject* WrapAclblasHgemm(PyObject* /* self */, PyObject* args)
{
    aclTransType transA = ACL_TRANS_N;
    aclTransType transB = ACL_TRANS_N;
    aclTransType transC = ACL_TRANS_N;
    int m = 0;
    int n = 0;
    int k = 0;
    aclFloat16* alpha = nullptr;
    aclFloat16* matrixA = nullptr;
    int lda = 0;
    aclFloat16* matrixB = nullptr;
    int ldb = 0;
    aclFloat16* beta = nullptr;
    aclFloat16* matrixC = nullptr;
    int ldc = 0;
    aclComputeType type = ACL_COMPUTE_HIGH_PRECISION;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "iiiiiikkikikkiik", &transA, &transB, &transC, &m, &n, &k, &alpha, &matrixA, &lda, &matrixB, &ldb,
            &beta, &matrixC, &ldc, &type, &stream),
        "acl.blas.hgemm args parse failed");

    aclError ret = aclblasHgemm(
        transA, transB, transC, m, n, k, alpha, matrixA, lda, matrixB, ldb, beta, matrixC, ldc, type, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclblasCreateHandleForHgemm(PyObject* /* self */, PyObject* args)
{
    aclTransType transA = ACL_TRANS_N;
    aclTransType transB = ACL_TRANS_N;
    aclTransType transC = ACL_TRANS_N;
    int m = 0;
    int n = 0;
    int k = 0;
    aclComputeType type = ACL_COMPUTE_HIGH_PRECISION;
    aclopHandle* handle = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iiiiiii", &transA, &transB, &transC, &m, &n, &k, &type),
        "acl.blas.create_handle_for_hgemm args parse failed");

    aclError ret = aclblasCreateHandleForHgemm(transA, transB, transC, m, n, k, type, &handle);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(handle), ret);
}

PyObject* WrapAclblasS8gemm(PyObject* /* self */, PyObject* args)
{
    aclTransType transA = ACL_TRANS_N;
    aclTransType transB = ACL_TRANS_N;
    aclTransType transC = ACL_TRANS_N;
    int m = 0;
    int n = 0;
    int k = 0;
    int32_t* alpha = nullptr;
    int8_t* matrixA = nullptr;
    int lda = 0;
    int8_t* matrixB = nullptr;
    int ldb = 0;
    int32_t* beta = nullptr;
    int32_t* matrixC = nullptr;
    int ldc = 0;
    aclComputeType type = ACL_COMPUTE_HIGH_PRECISION;
    aclrtStream stream = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(
            args, "iiiiiikkikikkiik", &transA, &transB, &transC, &m, &n, &k, &alpha, &matrixA, &lda, &matrixB, &ldb,
            &beta, &matrixC, &ldc, &type, &stream),
        "acl.blas.s8gemm args parse failed");

    aclError ret = aclblasS8gemm(
        transA, transB, transC, m, n, k, alpha, matrixA, lda, matrixB, ldb, beta, matrixC, ldc, type, stream);
    return Py_BuildValue("i", ret);
}

PyObject* WrapAclblasCreateHandleForS8gemm(PyObject* /* self */, PyObject* args)
{
    aclTransType transA = ACL_TRANS_N;
    aclTransType transB = ACL_TRANS_N;
    aclTransType transC = ACL_TRANS_N;
    int m = 0;
    int n = 0;
    int k = 0;
    aclComputeType type = ACL_COMPUTE_HIGH_PRECISION;
    aclopHandle* handle = nullptr;

    CHECK_NULL(
        PyArg_ParseTuple(args, "iiiiiii", &transA, &transB, &transC, &m, &n, &k, &type),
        "acl.blas.create_handle_for_s8gemm args parse failed");

    aclError ret = aclblasCreateHandleForS8gemm(transA, transB, transC, m, n, k, type, &handle);
    return Py_BuildValue("ki", reinterpret_cast<uintptr_t>(handle), ret);
}