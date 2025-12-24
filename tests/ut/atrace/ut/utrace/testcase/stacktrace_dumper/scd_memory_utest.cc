/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include <sys/ptrace.h>
#include <sys/prctl.h>
#include "securec.h"
#include "scd_memory.h"
#include "scd_memory_local.h"
#include "scd_memory_remote.h"
#include "slog_stub.h"

class ScdMemoryUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }
};

void EXPECT_TestMemory(size_t(*iter)(void *obj, uintptr_t addr , void *dst, size_t size), void *src, void *dst, size_t size)
{    
    *(int8_t*)src = 1;
    size_t ret = iter(NULL, (uintptr_t)src, dst, size);
    EXPECT_EQ(ret, size);
    EXPECT_EQ(*(int8_t*)dst, 1);

    *(int8_t*)(src + 1) = 1;
    ret = iter(NULL, (uintptr_t)src, dst, size);
    EXPECT_EQ(ret, size);
    EXPECT_EQ(*(int8_t*)(dst + 1), 1);
    
    *(uint64_t*)(src + 2) = 0xFFFFFFFFFFFFFFFF;
    ret = iter(NULL, (uintptr_t)src, dst, size);
    EXPECT_EQ(ret, size);
    EXPECT_EQ(*(uint64_t*)(dst + 2), 0xFFFFFFFFFFFFFFFF);
}

void DstMememoryInit(void **dst, size_t size)
{
    *dst = malloc(size);
}
void CheckReadResult(void *src, void *dst, size_t size, size_t retSize)
{
    EXPECT_EQ(retSize, size);
    for (size_t i = 0; i < size; i++) {
        EXPECT_EQ(*(uint8_t *)(src + i), *(uint8_t *)(dst + i));
    }
}

void TestMemoryLocalRead(void(*srcMemoryInit)(void **src, size_t *size),
    void(*srcMemoryCheckResult)(void *src, void *dst, size_t size, size_t retSize), void(*srcMemoryFinalize)(void *src))
{
    void *src;
    size_t size;
    srcMemoryInit(&src, &size);
    void *dst;
    DstMememoryInit(&dst, size);    
    size_t retSize = ScdMemoryLocalRead((uintptr_t)src, dst, size);
    if (srcMemoryCheckResult == NULL) {
        CheckReadResult(src, dst, size, retSize);
    }
    free(dst);
    if (srcMemoryFinalize != NULL) {
        srcMemoryFinalize(src);
    } else {
        free(src);
    }
}

void TestMemoryRemoteRead(void(*srcMemoryInit)(void **src, size_t *size),
    void(*srcMemoryCheckResult)(void *src, void *dst, size_t size, size_t retSize), void(*srcMemoryFinalize)(void *src))
{
    void *src;
    size_t size;
    srcMemoryInit(&src, &size);
    int pid = getpid();
    (void)prctl(PR_SET_PTRACER, PR_SET_PTRACER_ANY, 0, 0, 0);
    int result = fork();
    if (result == -1) {
        return;
    }
    if(result == 0) {
        (void)ptrace(PTRACE_ATTACH, pid, NULL, NULL);
        int32_t ret;
        do {
            int32_t status;
            ret = waitpid (pid, &status, __WALL);
        } while (ret == -1 && errno == EINTR);
        // 
        void *dst;
        DstMememoryInit(&dst, size);
        size_t retSize = ScdMemoryRemoteRead((uintptr_t)src, dst, size);
        if (srcMemoryCheckResult == NULL) {
            CheckReadResult(src, dst, size, retSize);
        }
        free(dst);    
        (void)ptrace(PTRACE_DETACH, pid, NULL, NULL);
        // sub process
        exit(0);
    } else {
        int ret = 0;
        (void)wait(&ret);
        EXPECT_EQ(ret, 0);
    }
    if (srcMemoryFinalize != NULL) {
        srcMemoryFinalize(src);
    } else {
        free(src);
    }
}

TEST_F(ScdMemoryUtest, TestMemoryReadUint8)
{
    EXPECT_CheckNoErrorLog();
    auto readFunc = {TestMemoryLocalRead, TestMemoryRemoteRead};
    for (auto iter : readFunc) {
        iter([](void **src, size_t *size){
            uint8_t tmp = 0xAB;
            *size = sizeof(tmp);
            *src = malloc(*size);
            void *addr = *src;
            *(int8_t*)addr = tmp;
        }, NULL, NULL);
    }
}

TEST_F(ScdMemoryUtest, TestMemoryReadUint16)
{
    EXPECT_CheckNoErrorLog();
    auto readFunc = {TestMemoryLocalRead, TestMemoryRemoteRead};
    for (auto iter : readFunc) {
        iter([](void **src, size_t *size){
            uint16_t tmp = 0xABCD;
            *size = sizeof(tmp);
            *src = malloc(*size);
            void *addr = *src;
            *(uint16_t*)addr = tmp;
        }, NULL, NULL);
    }
}

TEST_F(ScdMemoryUtest, TestMemoryReadUint32)
{
    EXPECT_CheckNoErrorLog();
    auto readFunc = {TestMemoryLocalRead, TestMemoryRemoteRead};
    for (auto iter : readFunc) {
        iter([](void **src, size_t *size){
            uint32_t tmp = 0xABCDBCDA;
            *size = sizeof(tmp);
            *src = malloc(*size);
            void *addr = *src;
            *(uint32_t*)addr = tmp;
        }, NULL, NULL);
    }
}

TEST_F(ScdMemoryUtest, TestMemoryReadUint64)
{
    EXPECT_CheckNoErrorLog();
    auto readFunc = {TestMemoryLocalRead, TestMemoryRemoteRead};
    for (auto iter : readFunc) {
        iter([](void **src, size_t *size){
            uint64_t tmp = 0xABCDBCDACDABDABC;
            *size = sizeof(tmp);
            *src = malloc(*size);
            void *addr = *src;
            *(uint64_t*)addr = tmp;
        }, NULL, NULL);
    }
}

TEST_F(ScdMemoryUtest, TestMemoryReadInt64)
{
    EXPECT_CheckNoErrorLog();
    auto readFunc = {TestMemoryLocalRead, TestMemoryRemoteRead};
    for (auto iter : readFunc) {
        iter([](void **src, size_t *size){
            int64_t tmp = 0xABCDBCDACDABDABC;
            *size = sizeof(tmp);
            *src = malloc(*size);
            void *addr = *src;
            *(int64_t*)addr = tmp;
        }, NULL, NULL);
    }
}

TEST_F(ScdMemoryUtest, TestMemoryReadUnAligned)
{
    EXPECT_CheckNoErrorLog();
    auto readFunc = {TestMemoryLocalRead, TestMemoryRemoteRead};
    for (auto iter : readFunc) {
        iter([](void **src, size_t *size){
            int64_t tmp = 0xABCDBCDACDABDABC;
            *size = sizeof(int64_t);
            void *addr = malloc(*size + 1);
            *src = addr + 1;
            memcpy(addr, &tmp, sizeof(int64_t));
        }, NULL, [](void *src) {
            free(src - 1);
        });
    }
}

TEST_F(ScdMemoryUtest, TestMemoryReadArray)
{
    EXPECT_CheckNoErrorLog();
    auto readFunc = {TestMemoryLocalRead, TestMemoryRemoteRead};
    for (auto iter : readFunc) {
        iter([](void **src, size_t *size){
            int64_t tmp[2] = {0xABCDBCDACDABDABC, 0xDABCABCDBCDACDAB};
            *size = sizeof(tmp);
            *src = malloc(*size);
            void *addr = *src;
            ((int64_t*)(addr))[0] = tmp[0];
            ((int64_t*)(addr))[1] = tmp[1];
        }, NULL, NULL);
    }
}

TEST_F(ScdMemoryUtest, TestMemoryReadPtraceFailed)
{
    char src = {'1'};
    size_t size = 1;
    char dst;
    size_t retSize = ScdMemoryRemoteRead((uintptr_t)&src, &dst, size);
    EXPECT_EQ(retSize, 0);
}

static size_t g_memcpySucccessCount = 0;
static size_t g_memcpyCount = 0;
error_t memcpyStub(void *dest, size_t destMax, const void *src, size_t count)
{
    g_memcpyCount++;
    if (g_memcpyCount >= g_memcpySucccessCount) {
        return -1;
    }
    memcpy(dest, src, count);
    return EOK;
}

TEST_F(ScdMemoryUtest, TestMemoryReadRemoteMemcpyFailed)
{
    int testNum = 5;
    for (int i = 0 ; i <= testNum; i++) {
        g_memcpyCount = 0;
        g_memcpySucccessCount = i;
        MOCKER(memcpy_s)
            .stubs()
            .will(invoke(memcpyStub));
        auto readFunc = {TestMemoryRemoteRead};
        for (auto iter : readFunc) {
            iter([](void **src, size_t *size){
                int64_t tmp[2] = {0xABCDBCDACDABDABC, 0xDABCABCDBCDACDAB};
                *size = sizeof(int64_t) * 2;
                void *addr = malloc(*size + 1);
                *src = addr + 1;
                memcpy(addr, &tmp, *size);
            }, [](void *src, void *dst, size_t size, size_t retSize) {
                EXPECT_EQ(retSize,  0);
            }, [](void *src) {
                free(src - 1);
            });
        }
        GlobalMockObject::verify();
    }
}

TEST_F(ScdMemoryUtest, TestMemoryReadLocalMemcpyFailed)
{
    int testNum = 1;
    for (int i = 0 ; i <= testNum; i++) {
        g_memcpyCount = 0;
        g_memcpySucccessCount = i;
        MOCKER(memcpy_s)
            .stubs()
            .will(invoke(memcpyStub));
        auto readFunc = {TestMemoryLocalRead};
        for (auto iter : readFunc) {
            iter([](void **src, size_t *size){
                int64_t tmp = 0xABCDBCDACDABDABC;
                *size = sizeof(int64_t);
                void *addr = malloc(*size + 1);
                *src = addr + 1;
                memcpy(addr, &tmp, sizeof(int64_t));
            }, [](void *src, void *dst, size_t size, size_t retSize) {
                EXPECT_EQ(retSize,  0);
            }, [](void *src) {
                free(src - 1);
            });
        }
        GlobalMockObject::verify();
    }
}

TEST_F(ScdMemoryUtest, TestScdMemoryReadString_Failed)
{
    ScdMemory memory = {0};
    uintptr_t addr = 0;
    char buf[128] = {0};
    size_t size = sizeof(buf);
    EXPECT_EQ(0, ScdMemoryReadString((ScdMemory *)0, addr, buf, size));
    EXPECT_EQ(0, ScdMemoryReadString(&memory, addr, NULL, size));
    EXPECT_EQ(0, ScdMemoryReadString(&memory, addr, buf, 1));
}