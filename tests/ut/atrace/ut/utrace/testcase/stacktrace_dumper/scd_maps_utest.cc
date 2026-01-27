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

#include "scd_dl.h"
#include "scd_maps.h"
#include "scd_dwarf.h"
#include "adiag_utils.h"
#include <elf.h>
#include <link.h>
#include "scd_map.h"

class ScdMapsUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        system("rm -rf " LLT_TEST_DIR "/*");
        system("mkdir -p " LLT_TEST_DIR );
    }

    virtual void TearDown()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
        system("rm -rf " LLT_TEST_DIR );
    }

    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }
};


TEST_F(ScdMapsUtest, TestScdMapsInit)
{
    ScdDwarf dwarf;
    ScdMaps *maps = ScdMapsGet();
    int32_t pid = getpid();
    TraStatus ret = TRACE_FAILURE;
    ScdMap *mapRet = 0;

    ret = ScdMapsInit(maps, pid);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdMapsLoad(maps);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ScdMapsUninit(maps);
}

TEST_F(ScdMapsUtest, TestScdMapsInitFailed)
{
    MOCKER(mmMutexInit).stubs().will(returnValue(-1));
    ScdMaps *maps = ScdMapsGet();
    int32_t pid = getpid();
    TraStatus ret = TRACE_FAILURE;
    ScdMap *mapRet = 0;

    ret = ScdMapsInit(maps, pid);
    EXPECT_EQ(TRACE_FAILURE, ret);
}

TEST_F(ScdMapsUtest, TestScdMapsFailed)
{
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    ScdMaps *maps = ScdMapsGet();
    int32_t pid = getpid();
    TraStatus ret = TRACE_FAILURE;
    ScdMap *mapRet = 0;

    ret = ScdMapsInit(maps, pid);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdMapsLoad(maps);
    EXPECT_EQ(TRACE_FAILURE, ret);

    ScdMapsUninit(maps);
}

TEST_F(ScdMapsUtest, TestScdMapsInsertFailed)
{
    void *buf = malloc(sizeof(ScdMap));
    MOCKER(AdiagMalloc).stubs().will(returnValue(buf)).then(returnValue((void *)NULL));
    ScdMaps maps = { 0 };
    int32_t pid = getpid();
    TraStatus ret = TRACE_FAILURE;
    ScdMap *mapRet = 0;

    ret = ScdMapsInit(&maps, pid);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdMapsLoad(&maps);
    EXPECT_EQ(TRACE_FAILURE, ret);

    ScdMapsUninit(&maps);
}

TEST_F(ScdMapsUtest, TestScdMapsScanfFailed)
{
    MOCKER(vsscanf_s).stubs().will(returnValue(-1));
    ScdMaps *maps = ScdMapsGet();
    int32_t pid = getpid();
    TraStatus ret = TRACE_FAILURE;
    ScdMap *mapRet = 0;

    ret = ScdMapsInit(maps, pid);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdMapsLoad(maps);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ScdMapsUninit(maps);
}

TEST_F(ScdMapsUtest, TestScdMapCreate)
{
    uintptr_t start = 0x7f1d28000000;
    uintptr_t end = 0x7f1d28021000;
    size_t offset = 0;
    ScdMap *ret = 0;

    ret = ScdMapCreate(start, end, offset, "libc.so.6");
    EXPECT_NE((ScdMap *)0, ret);

    ScdMapUpdata(ret, start, end, offset);

    ScdMapDestroy(&ret);
    EXPECT_EQ((ScdMap *)0, ret);
}

TEST_F(ScdMapsUtest, TestScdDlInit)
{
    ScdDl dlInfo = {0};
    int32_t pid = 0;
    TraStatus ret = TRACE_FAILURE;

    ret = ScdDlInit(&dlInfo);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdDlLoad(&dlInfo, pid, "libc.so.6");
    EXPECT_EQ(TRACE_FAILURE, ret);

    ScdDlUninit(&dlInfo);
}

TEST_F(ScdMapsUtest, TestScdDlLoadElfFailed)
{
    ScdDl dlInfo = {0};
    int32_t pid = 0;
    TraStatus ret = TRACE_FAILURE;

    ret = ScdDlInit(&dlInfo);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    char log[200] = { 0 };
    (void)memset_s(log, 200, 1, 199);
    char cmd[256] = { 0 };
    const char *fileName = "/test_scd_maps.txt";
    (void)snprintf_s(cmd, 256, 256, "echo %s > %s%s", log, LLT_TEST_DIR, fileName);
    system(cmd);
    std::string str(fileName);
    str = LLT_TEST_DIR + str;
    ret = ScdDlLoad(&dlInfo, pid, str.c_str());
    EXPECT_EQ(TRACE_FAILURE, ret);

    ScdDlUninit(&dlInfo);
}

TEST_F(ScdMapsUtest, TestScdDlLoadElfPheadFailed)
{
    ScdDl dlInfo = {0};
    int32_t pid = 0;
    TraStatus ret = TRACE_FAILURE;

    ret = ScdDlInit(&dlInfo);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    const char *fileName = "/test_scd_maps.txt";
    std::string str(fileName);
    str = LLT_TEST_DIR + str;
    FILE *file = fopen(str.c_str(), "w");

    ElfW(Ehdr) ehdr;
    memcpy_s(ehdr.e_ident, sizeof(ehdr.e_ident), ELFMAG, SELFMAG);
    ehdr.e_phoff = 64;
    ehdr.e_phnum = 1;
    ehdr.e_phentsize = 56;
    char log[10] = { 0 };
    (void)memset_s(log, 10, 1, 9);
    fwrite(&ehdr, sizeof(ElfW(Ehdr)), 1, file);
    fwrite(log, 10, 1, file);
    fclose(file);

    ret = ScdDlLoad(&dlInfo, pid, str.c_str());
    EXPECT_EQ(TRACE_FAILURE, ret);

    ScdDlUninit(&dlInfo);
}

// TEST_F(ScdMapsUtest, TestScdDlLoadElfSheadFailed)
// {
//     ScdDl dlInfo = {0};
//     int32_t pid = 0;
//     TraStatus ret = TRACE_FAILURE;

//     ret = ScdDlInit(&dlInfo);
//     EXPECT_EQ(TRACE_SUCCESS, ret);

//     const char *fileName = "/test_scd_maps.txt";
//     std::string str(fileName);
//     str = LLT_TEST_DIR + str;
//     FILE *file = fopen(str.c_str(), "w");

//     ElfW(Ehdr) ehdr;
//     memcpy_s(ehdr.e_ident, sizeof(ehdr.e_ident), ELFMAG, SELFMAG);
//     char log[200] = { 0 };
//     (void)memset_s(log, 200, 1, 199);
//     fwrite(&ehdr, sizeof(ElfW(Ehdr)), 1, file);
//     fwrite(log, 200, 1, file);
//     fclose(file);

//     ret = ScdDlLoad(&dlInfo, pid, str.c_str());
//     EXPECT_EQ(TRACE_FAILURE, ret);

//     ScdDlUninit(&dlInfo);
// }

TEST_F(ScdMapsUtest, TestScdDlInitFailed)
{
    MOCKER(mmMutexInit).stubs().will(returnValue(-1));
    uintptr_t start = 0x7f1d28000000;
    uintptr_t end = 0x7f1d28021000;
    size_t offset = 0;
    ScdMap *ret = 0;

    ret = ScdMapCreate(start, end, offset, "libc.so.6");
    EXPECT_EQ((ScdMap *)0, ret);
}

TEST_F(ScdMapsUtest, TestScdOpenFailed)
{
    ScdDwarf dwarf;
    MOCKER(fopen).stubs().will(returnValue((FILE *)NULL));
    ScdMaps maps = {0};
    int32_t pid = getpid();
    TraStatus ret = TRACE_FAILURE;
    ScdMap *mapRet = 0;

    ret = ScdMapsInit(&maps, pid);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdMapsLoad(&maps);
    EXPECT_EQ(TRACE_FAILURE, ret);

    ScdMapsUninit(&maps);
}

TEST_F(ScdMapsUtest, TestScdFstatFailed)
{
    ScdDwarf dwarf;
    MOCKER(fstat).stubs().will(returnValue(-1));
    ScdMaps maps = {0};
    int32_t pid = getpid();
    TraStatus ret = TRACE_FAILURE;
    ScdMap *mapRet = 0;

    ret = ScdMapsInit(&maps, pid);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdMapsLoad(&maps);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ScdMapsUninit(&maps);
}

TEST_F(ScdMapsUtest, TestScdMmapFailed)
{
    ScdDwarf dwarf;
    MOCKER(mmap).stubs().will(returnValue(MAP_FAILED));
    ScdMaps maps = {0};
    int32_t pid = getpid();
    TraStatus ret = TRACE_FAILURE;
    ScdMap *mapRet = 0;

    ret = ScdMapsInit(&maps, pid);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdMapsLoad(&maps);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ScdMapsUninit(&maps);
}

TEST_F(ScdMapsUtest, TestScdElfInit)
{
    ScdElf elfInfo = {0};
    ScdMemory memInfo = {0};
    ScdRegs regsInfo = {0};
    int32_t pid = 0;
    TraStatus ret = TRACE_FAILURE;

    ret = ScdElfInit(&elfInfo);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdElfLoad(&elfInfo, pid, &memInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);

    uintptr_t bias = ScdElfGetLoadBias(&elfInfo);
    EXPECT_EQ(0, bias);

    ScdElfUninit(&elfInfo);
}

TEST_F(ScdMapsUtest, TestScdElfLoadFailed)
{
    ScdDwarf dwarf;
    ScdMaps *maps = ScdMapsGet();
    int32_t pid = getpid();
    TraStatus ret = TRACE_FAILURE;

    ret = ScdMapsInit(maps, pid);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ret = ScdMapsLoad(maps);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    ScdMapsUninit(maps);
}

TEST_F(ScdMapsUtest, TestScdRealPathFailed)
{
    ScdDwarf dwarfInfo = {0};
    pid_t pid = getpid();
    pid_t tid = gettid();
    ScdMaps maps = {0};
    ucontext_t uc = {0};
    TraStatus ret = TRACE_FAILURE;

    int status = fork();
    if (status == -1) {
        return;
    }
    if (status == 0) {
        ret = ScdMapsInit(&maps, pid);
        EXPECT_EQ(TRACE_SUCCESS, ret);

        MOCKER(mmRealPath).stubs().will(returnValue(-1));

        ret = ScdMapsLoad(&maps);
        EXPECT_EQ(TRACE_SUCCESS, ret);

        ScdMapsUninit(&maps);
        exit(0);
    } else {
        int32_t err = prctl(PR_SET_PTRACER, status, 0, 0, 0);
        EXPECT_EQ(0, err);
        int ret = 0;
        (void)wait(&ret);
    }
}

TEST_F(ScdMapsUtest, TestScdMap)
{
    uintptr_t start = 0;
    uintptr_t end = 10;
    size_t offset = 0;
    ScdMap *map = ScdMapCreate(200, 300, 100, "test1");
    TraStatus ret = ScdMapUpdata(map, 300, 400, 200);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    ret = ScdMapUpdata(map, 100, 200, 0);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    ret = ScdMapUpdata(map, 1000, 1100, 0);
    EXPECT_EQ(TRACE_FAILURE, ret);
    ret = ScdMapUpdata(map, 50, 60, 0);
    EXPECT_EQ(TRACE_FAILURE, ret);
    EXPECT_EQ(100, map->start);
    EXPECT_EQ(400, map->end);
    EXPECT_EQ(0, map->offset);
    EXPECT_STREQ("test1", map->name);
    ScdMapDestroy(&map);
}