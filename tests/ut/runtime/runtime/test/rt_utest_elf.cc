/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include <sstream>
#define private public
#define protected public
#include "runtime.hpp"
#include "program.hpp"
#include "kernel.hpp"
#include "binary_loader.hpp"
#include "raw_device.hpp"
#undef private
#undef protected
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include "securec.h"
#include <thread>
#include <unistd.h>
#include "device.hpp"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "thread_local_container.hpp"
#include "common/rt_utest_context_reset_helper.hpp"

#include "elf.hpp"
#include "data/elf.h"

using namespace testing;
using namespace cce::runtime;

class ELFTest : public testing::Test {
protected:
    static void SetUpTestCase() { std::cout << "ELF test start" << std::endl; }

    static void TearDownTestCase() { std::cout << "ELF test start end" << std::endl; }

    // Some expensive resource shared by all tests.
    virtual void SetUp()
    {
        rtSetDevice(0);
        std::cout << "a test SetUP" << std::endl;
        GlobalMockObject::verify();
    }
    virtual void TearDown()
    {
        ut::ResetPrimaryDeviceIfActiveWithDeviceDown();
        std::cout << "a test TearDown" << std::endl;
    }
};

TEST_F(ELFTest, ELF_Process_Object_01)
{
    size_t MAX_LENGTH = 75776;
    FILE* bin = NULL;

    // bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o", "rb");
    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/conv_fwd_sample.cce.tmp", "rb");
    // bin = fopen("conv_fwd_sample.cce.out", "rb");
    if (bin == NULL) {
        printf("error\n");
        return;
    } else {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData* elfData;
    RtKernel* kernels;

    elfData = new rtElfData;

    kernels = ProcessObject(bindata, elfData);
    EXPECT_EQ(elfData->kernel_num, 1);

    if (NULL != elfData->section_headers) {
        delete[] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    for (uint32_t i = 0; i < elfData->kernel_num; ++i) {
        if (kernels != nullptr) {
            DELETE_A(kernels[i].name);
        }
    }
    delete elfData;
    elfData = NULL;
    delete[] kernels;
    kernels = NULL;
}

TEST_F(ELFTest, ELF_Process_Object_02)
{
    size_t MAX_LENGTH = 75776;
    FILE* bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o", "rb");
    if (bin == NULL) {
        printf("error\n");
        return;
    } else {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData* elfData;
    RtKernel* kernels;

    elfData = new rtElfData;
    kernels = ProcessObject(bindata, elfData);
    if (NULL != elfData->section_headers) {
        delete[] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    for (uint32_t i = 0; i < elfData->kernel_num; ++i) {
        if (kernels != nullptr) {
            DELETE_A(kernels[i].name);
        }
    }
    delete[] kernels;
    kernels = NULL;
    kernels = ProcessObject(bindata, elfData);

    EXPECT_EQ(elfData->kernel_num, 1);

    if (NULL != elfData->section_headers) {
        delete[] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    for (uint32_t i = 0; i < elfData->kernel_num; ++i) {
        if (kernels != nullptr) {
            DELETE_A(kernels[i].name);
        }
    }
    delete elfData;
    elfData = NULL;
    delete[] kernels;
    kernels = NULL;
}

TEST_F(ELFTest, ELF_Process_Object_03)
{
    size_t MAX_LENGTH = 6144;
    FILE* bin = NULL;

    // bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/bad-elf2.o", "rb");
    bin = fopen("bad-elf2.o", "rb");
    if (bin == NULL) {
        printf("error\n");
        return;
    } else {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData* elfData;
    RtKernel* kernels;

    elfData = new rtElfData;
    kernels = ProcessObject(bindata, elfData);
    EXPECT_EQ(elfData->kernel_num, 1);
    if (NULL == kernels) {
        printf("SUCC get 64bit section headers failed!\n");
    } else {
        printf("FAIL\n");
    }

    if (NULL != elfData->section_headers) {
        delete[] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    delete elfData;
    elfData = NULL;
    delete[] kernels;
    kernels = NULL;
}

TEST_F(ELFTest, ELF_Process_Object_04)
{
    size_t MAX_LENGTH = 75776;
    FILE* bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/bad-elf3.o", "rb");
    // bin = fopen("bad-elf3.o", "rb");
    if (bin == NULL) {
        printf("error\n");
        return;
    } else {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData* elfData;
    RtKernel* kernels;

    elfData = new rtElfData;
    kernels = ProcessObject(bindata, elfData);
    EXPECT_EQ(elfData->kernel_num, 0);

    if (NULL == kernels) {
        printf("SUCC get 64bit section headers failed!\n");
    } else {
        printf("FAIL\n");
    }

    if (NULL != elfData->section_headers) {
        delete[] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    delete elfData;
    elfData = NULL;
    delete[] kernels;
    kernels = NULL;
}

TEST_F(ELFTest, ELF_Process_Object_05)
{
    size_t MAX_LENGTH = 75776;
    FILE* bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/bad-elf4.o", "rb");
    // bin = fopen("bad-elf4.o", "rb");
    if (bin == NULL) {
        printf("error\n");
        return;
    } else {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData* elfData;
    RtKernel* kernels;

    elfData = new rtElfData;
    kernels = ProcessObject(bindata, elfData);
    EXPECT_EQ(elfData->kernel_num, 0);

    if (NULL != elfData->section_headers) {
        delete[] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    delete elfData;
    elfData = NULL;
    delete[] kernels;
    kernels = NULL;
}

TEST_F(ELFTest, ELF_Process_Object_06)
{
    size_t MAX_LENGTH = 75776;
    FILE* bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/no-kernel.o", "rb");
    // bin = fopen("no-kernel.o", "rb");
    if (bin == NULL) {
        printf("error\n");
        return;
    } else {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData* elfData;
    RtKernel* kernels;

    elfData = new rtElfData;
    kernels = ProcessObject(bindata, elfData);
    EXPECT_EQ(elfData->kernel_num, 0);

    if (NULL != elfData->section_headers) {
        delete[] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    delete elfData;
    elfData = NULL;
    delete[] kernels;
    kernels = NULL;
}

TEST_F(ELFTest, ELF_Process_Object_07)
{
    size_t MAX_LENGTH = 75776;
    FILE* bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/bad-elf.o", "rb");
    // bin = fopen("bad-elf.o", "rb");
    if (bin == NULL) {
        printf("error\n");
        return;
    } else {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData* elfData;
    RtKernel* kernels;

    elfData = new rtElfData;
    kernels = ProcessObject(bindata, elfData);
    EXPECT_EQ(elfData->kernel_num, 0);

    if (NULL != elfData->section_headers) {
        delete[] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    delete elfData;
    elfData = NULL;
    delete[] kernels;
    kernels = NULL;
}

TEST_F(ELFTest, ELF_GetStringTableCopy_memcpy_fail)
{
    char buf[20] = {0};
    MOCKER(memcpy_s).stubs().will(returnValue(3));
    std::unique_ptr<char_t[]> out = GetStringTableCopy(&buf[0], 20);
    uint16_t ret = strcmp((char*)&out, "");
    EXPECT_EQ(ret, 0);
}

TEST_F(ELFTest, ELF_Little_endian_case)
{
    const unsigned char* field = (unsigned char*)"1234567890";
    unsigned long out;
    out = ByteGetLittleEndian(field, 3);
    uint16_t ret = strcmp((char*)&out, "123");
    EXPECT_EQ(ret, 0);

    out = ByteGetLittleEndian(field, 5);
    ret = strcmp((char*)&out, "12345");
    EXPECT_EQ(ret, 0);

    out = ByteGetLittleEndian(field, 6);
    ret = strcmp((char*)&out, "123456");
    EXPECT_EQ(ret, 0);
    out = ByteGetLittleEndian(field, 7);
    ret = strcmp((char*)&out, "1234567");
    EXPECT_EQ(ret, 0);
}

TEST_F(ELFTest, ELF_Big_endian_case)
{
    const unsigned char* field = (unsigned char*)"1234567890";
    unsigned long temp;
    temp = ByteGetBigEndian(field, 1);
    uint16_t ret = strcmp((char*)&temp, "1");
    EXPECT_EQ(ret, 0);
    temp = ByteGetBigEndian(field, 2);
    ret = strcmp((char*)&temp, "21");
    EXPECT_EQ(ret, 0);
    temp = ByteGetBigEndian(field, 3);
    ret = strcmp((char*)&temp, "321");
    EXPECT_EQ(ret, 0);
    temp = ByteGetBigEndian(field, 4);
    ret = strcmp((char*)&temp, "4321");
    EXPECT_EQ(ret, 0);
    temp = ByteGetBigEndian(field, 5);
    ret = strcmp((char*)&temp, "54321");
    EXPECT_EQ(ret, 0);
    temp = ByteGetBigEndian(field, 6);
    ret = strcmp((char*)&temp, "654321");
    EXPECT_EQ(ret, 0);
    temp = ByteGetBigEndian(field, 7);
    ret = strcmp((char*)&temp, "7654321");
    EXPECT_EQ(ret, 0);
    unsigned long out[2];
    out[0] = ByteGetBigEndian(field, 8);
    char* outChar = (char*)out;
    outChar[8] = '\0';
}

TEST_F(ELFTest, ELF_Get_64bit_Section_Headers_Error_02)
{
    rtElfData* elfData;
    int out;
    elfData = new (std::nothrow) rtElfData();

    elfData->elf_header.e_shentsize = 0;
    elfData->elf_header.e_shnum = 0;

    out = Get64bitSectionHeaders(elfData);
    EXPECT_EQ(out, 1);

    elfData->elf_header.e_shentsize = 1;
    elfData->elf_header.e_shnum = 1;

    out = Get64bitSectionHeaders(elfData);
    EXPECT_EQ(out, 1);

    elfData->elf_header.e_shentsize = 100;
    elfData->elf_header.e_shnum = 1;

    out = Get64bitSectionHeaders(elfData);
    EXPECT_EQ(out, 1);

    if (NULL != elfData) {
        if (NULL != elfData->section_headers) {
            delete[] elfData->section_headers;
            elfData->section_headers = NULL;
        }

        delete elfData;
        elfData = NULL;
    }
}

TEST_F(ELFTest, ELF_Get_64bit_Elf_Symbols_Error_01)
{
    rtElfData* elfData;
    Elf_Internal_Shdr* section;
    unsigned long num_syms_return = 0;
    elfData = new (std::nothrow) rtElfData();

    section = new Elf_Internal_Shdr;
    if (NULL != section) {
        memset_s(section, sizeof(Elf_Internal_Shdr), '\0', sizeof(Elf_Internal_Shdr));
    }
    section->sh_size = 0;
    std::unique_ptr<Elf_Internal_Sym[]> out = Get64bitElfSymbols(elfData, section, &num_syms_return);
    EXPECT_EQ(elfData->kernel_num, 0);
    if (NULL != elfData) {
        if (NULL != elfData->section_headers) {
            delete[] elfData->section_headers;
            elfData->section_headers = NULL;
        }

        delete elfData;
        elfData = NULL;
    }
    if (NULL != section) {
        delete section;
        section = NULL;
    }
}

TEST_F(ELFTest, ELF_Get_64bit_Elf_Symbols_Error_02)
{
    rtElfData* elfData;
    Elf_Internal_Shdr* section;
    unsigned long num_syms_return = 0;
    elfData = new (std::nothrow) rtElfData();

    section = new Elf_Internal_Shdr;
    if (NULL != section) {
        memset_s(section, sizeof(Elf_Internal_Shdr), '\0', sizeof(Elf_Internal_Shdr));
    }
    section->sh_size = 1;
    section->sh_entsize = 0;
    std::unique_ptr<Elf_Internal_Sym[]> out = Get64bitElfSymbols(elfData, section, &num_syms_return);
    EXPECT_EQ(elfData->kernel_num, 0);
    if (NULL != elfData) {
        if (NULL != elfData->section_headers) {
            delete[] elfData->section_headers;
            elfData->section_headers = NULL;
        }

        delete elfData;
        elfData = NULL;
    }
    if (NULL != section) {
        delete section;
        section = NULL;
    }
}

TEST_F(ELFTest, ELF_Get_64bit_Elf_Symbols_Error_03)
{
    rtElfData* elfData;
    Elf_Internal_Shdr* section;
    unsigned long num_syms_return = 0;
    elfData = new (std::nothrow) rtElfData();
    section = new Elf_Internal_Shdr;
    if (NULL != section) {
        memset_s(section, sizeof(Elf_Internal_Shdr), '\0', sizeof(Elf_Internal_Shdr));
    }
    section->sh_size = 2;
    section->sh_entsize = 1;
    std::unique_ptr<Elf_Internal_Sym[]> out = Get64bitElfSymbols(elfData, section, &num_syms_return);
    EXPECT_EQ(elfData->kernel_num, 0);
    if (NULL != elfData) {
        if (NULL != elfData->section_headers) {
            delete[] elfData->section_headers;
            elfData->section_headers = NULL;
        }

        delete elfData;
        elfData = NULL;
    }
    if (NULL != section) {
        delete section;
        section = NULL;
    }
}

TEST_F(ELFTest, ELF_Process_Object_Error)
{
    rtElfData* elfData;
    RtKernel* out;
    char* obj_buf = NULL;

    elfData = new (std::nothrow) rtElfData();

    out = ProcessObject(obj_buf, elfData);
    EXPECT_EQ(elfData->kernel_num, 0);
    if (NULL != elfData) {
        if (NULL != elfData->section_headers) {
            delete[] elfData->section_headers;
            elfData->section_headers = NULL;
        }

        delete elfData;
        elfData = NULL;
    }
}

/* UT for elf.cc ByteGetLittleEndian() "default" Line:102*/
TEST_F(ELFTest, ELF_BYTE_GET_LITTLE_ENDIAN_TEST)
{
    const unsigned char* field = (unsigned char*)"1234567890";
    unsigned long out;

    MOCKER(abort).stubs().will(returnValue(0));

    out = ByteGetLittleEndian(field, 9);
    uint16_t ret = strcmp((char*)&out, "");
    EXPECT_EQ(ret, 0);
}

/* UT for elf.cc ByteGetBigEndian() "default" Line:136*/
TEST_F(ELFTest, ELF_BYTE_GET_BIG_ENDIAN_TEST)
{
    const unsigned char* field = (unsigned char*)"1234567890";
    unsigned long temp;

    MOCKER(abort).stubs().will(returnValue(0));

    temp = ByteGetBigEndian(field, 9);
    uint16_t ret = strcmp((char*)&temp, "");
    EXPECT_EQ(ret, 0);
}

TEST_F(ELFTest, ELF_Process_Object_08)
{
    size_t MAX_LENGTH = 75776;
    FILE* bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/conv_fwd_sample.cce.tmp", "rb");
    if (bin == NULL) {
        printf("error\n");
        return;
    } else {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData* elfData;
    RtKernel* kernels;

    elfData = new rtElfData;
    elfData->elf_header.e_shnum = 1;

    Elf_Internal_Shdr* section_headers = new Elf_Internal_Shdr;
    section_headers->sh_size = 0;
    elfData->section_headers = section_headers;

    kernels = ProcessObject(bindata, elfData);
    EXPECT_EQ(elfData->kernel_num, 1);
    delete[] kernels[0].name;
    delete elfData;
    elfData = NULL;
    delete[] kernels;
    kernels = NULL;
    delete section_headers;
}

int num_stub = 1;
extern "C" void* __real_malloc(size_t c);
void* malloc_stub_elf(unsigned int num_bytes)
{
    if (7 == num_stub) {
        return NULL;
    }
    num_stub++;
    return __real_malloc(num_bytes);
}

TEST_F(ELFTest, ELF_Process_Object_09)
{
    size_t MAX_LENGTH = 75776;
    FILE* bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/conv_fwd_sample.cce.tmp", "rb");
    if (bin == NULL) {
        printf("error\n");
        return;
    } else {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData* elfData;
    RtKernel* kernels;

    elfData = new (std::nothrow) rtElfData();

    elfData->elf_header.e_shnum = 1;

    Elf_Internal_Shdr* section_headers = (Elf_Internal_Shdr*)malloc(sizeof(Elf_Internal_Shdr));
    section_headers->sh_size = 0;
    elfData->section_headers = section_headers;

    MOCKER(malloc).stubs().will(invoke(malloc_stub_elf));

    kernels = ProcessObject(bindata, elfData);
    EXPECT_EQ(elfData->kernel_num, 1);
    if (NULL != elfData->section_headers) {
        free(elfData->section_headers);
        elfData->section_headers = NULL;
    }
    for (uint32_t i = 0; i < elfData->kernel_num; ++i) {
        if (kernels != nullptr) {
            DELETE_A(kernels[i].name);
        }
    }
    delete elfData;
    elfData = NULL;
    delete[] kernels;
    kernels = NULL;
}

TEST_F(ELFTest, ELF_Process_Object_10)
{
    size_t MAX_LENGTH = 75776;
    FILE* bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/conv_fwd_sample.cce.tmp", "rb");
    if (bin == NULL) {
        printf("error\n");
        return;
    } else {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData* elfData;
    RtKernel* kernels;

    elfData = new rtElfData;
    elfData->elf_header.e_shnum = 0;

    Elf_Internal_Shdr* section_headers = new Elf_Internal_Shdr;
    section_headers->sh_size = 0;
    elfData->section_headers = section_headers;
    kernels = ProcessObject(bindata, elfData);
    EXPECT_EQ(elfData->kernel_num, 1);
    for (uint32_t i = 0; i < elfData->kernel_num; ++i) {
        if (kernels != nullptr) {
            DELETE_A(kernels[i].name);
        }
    }
    delete elfData;
    elfData = NULL;
    delete[] kernels;
    kernels = NULL;
    delete section_headers;
}

TEST_F(ELFTest, ELF_Process_Object_11)
{
    size_t MAX_LENGTH = 75776;
    FILE* bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/conv_fwd_sample.cce.tmp", "rb");
    if (bin == NULL) {
        printf("error\n");
        return;
    } else {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);
    bindata[5] = 2;

    rtElfData* elfData;
    RtKernel* kernels;

    elfData = new rtElfData;
    elfData->elf_header.e_shnum = 0;

    Elf_Internal_Shdr* section_headers = new Elf_Internal_Shdr;
    section_headers->sh_size = 0;
    elfData->section_headers = section_headers;
    kernels = ProcessObject(bindata, elfData);
    EXPECT_EQ(elfData->kernel_num, 0);
    delete elfData;
    elfData = NULL;
    delete[] kernels;
    kernels = NULL;
    delete section_headers;
}

#ifdef AICPU_ON_OS
TEST_F(ELFTest, ELF_Process_Object_12)
{
    size_t MAX_LENGTH = 75776;
    FILE* bin = NULL;

    // bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o", "rb");
    // bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/libXv.so.1.0.0.txt", "rb");
    bin = fopen("/usr/lib/x86_64-linux-gnu/libXv.so.1.0.0", "rb");
    // bin = fopen("conv_fwd_sample.cce.out", "rb");
    if (bin == NULL) {
        printf("error\n");
        return;
    } else {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData* elfData;
    RtKernel* kernels;

    elfData = new (std::nothrow) rtElfData();

    kernels = ProcessObject(bindata, elfData);

    EXPECT_NE(elfData->so_name, (char*)NULL);

    printf("Library soname: [%s]\n", elfData->so_name);

    if (NULL != elfData->section_headers) {
        delete[] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    delete elfData;
    elfData = NULL;
    delete[] kernels;
    kernels = NULL;
}
#endif /* AICPU_ON_OS */

TEST_F(ELFTest, ELF_Process_Object_15)
{
    size_t MAX_LENGTH = 75776;
    FILE* bin = nullptr;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/no-kernel.o", "rb");
    if (bin == nullptr) {
        printf("error\n");
        return;
    } else {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData* elfData;
    RtKernel* kernels;

    elfData = new rtElfData;

    kernels = ProcessObject(bindata, elfData);
    if (nullptr == kernels) {
        printf("SUCC no kernel!\n");
    } else {
        printf("FAIL\n");
    }

    if (nullptr != elfData->section_headers) {
        delete[] elfData->section_headers;
        elfData->section_headers = nullptr;
    }

    uint8_t buf[4096] = {0};
    uint8_t* bufPtr = buf;
    uint32_t totalLen = sizeof(ElfDfxInfo);
    ElfDfxInfo* typeInfo = (ElfDfxInfo*)bufPtr;
    typeInfo->head.type = RT_FUNCTION_TYPE_DFX_TYPE;
    typeInfo->head.length = 100U;
    ElfKernelInfo kernelInfo = {5U, 0U, {1U, 3U}, bufPtr, 108U, false, false, 1U};
    GetKernelTlvInfo(buf, 150U, &kernelInfo);
    EXPECT_EQ(kernelInfo.dfxSize, 108U);
    EXPECT_EQ(kernelInfo.dfxAddr, bufPtr);

    delete elfData;
    elfData = nullptr;
    delete[] kernels;
    kernels = nullptr;
}

TEST_F(ELFTest, ELF_CONVERT_TASK_RATION_01)
{
    uint32_t taskRation = 2;
    rtError_t error = ConvertTaskRation(nullptr, taskRation);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(ELFTest, ELF_CONVERT_TASK_RATION_02)
{
    uint32_t taskRation = 2;
    ElfKernelInfo elfKernelInfo = {5U, 0U, {2U, 1U}};
    rtError_t error = ConvertTaskRation(&elfKernelInfo, taskRation);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ELFTest, ELF_CONVERT_TASK_RATION_03)
{
    uint32_t taskRation = 2;
    ElfKernelInfo elfKernelInfo = {4U, 0U, {1U, 1U}};
    rtError_t error = ConvertTaskRation(&elfKernelInfo, taskRation);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ELFTest, ELF_CONVERT_TASK_RATION_04)
{
    uint32_t taskRation = 2;
    ElfKernelInfo elfKernelInfo = {4U, 0U, {1U, 0U}};
    rtError_t error = ConvertTaskRation(&elfKernelInfo, taskRation);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ELFTest, ELF_CONVERT_TASK_RATION_05)
{
    uint32_t taskRation = 2;
    ElfKernelInfo elfKernelInfo = {5U, 0U, {1U, 0U}};
    rtError_t error = ConvertTaskRation(&elfKernelInfo, taskRation);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ELFTest, ELF_CONVERT_TASK_RATION_06)
{
    uint32_t taskRation = 2;
    ElfKernelInfo elfKernelInfo = {4U, 0U, {1U, 3U}};
    rtError_t error = ConvertTaskRation(&elfKernelInfo, taskRation);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(ELFTest, ParseElfStackInfoHeader)
{
    rtElfData* elfData = new rtElfData;

    elfData->stackSize = 0ULL;
    elfData->elf_header.e_version = 0x5a5a0301;
    ParseElfStackInfoHeader(elfData);
    EXPECT_EQ(elfData->stackSize, 0ULL);

    elfData->elf_header.e_version = 0x5a5a0101;
    ParseElfStackInfoHeader(elfData);
    EXPECT_EQ(elfData->stackSize, 16384U);

    elfData->elf_header.e_version = 0x5a5a0201;
    ParseElfStackInfoHeader(elfData);
    EXPECT_EQ(elfData->stackSize, 32768U);

    delete elfData;
    elfData = NULL;
}

TEST_F(ELFTest, UpdateKernelsInfo)
{
    rtElfData elfData = {};
    elfData.kernel_num = 1;

    RtKernel newKernels;
    newKernels.name = new (std::nothrow) char[5];
    strcpy_s(newKernels.name, 5, "test");
    newKernels.offset = 0;
    newKernels.length = 1;
    newKernels.metaInfo.funcType = 1;
    newKernels.metaInfo.crossCoreSync = 1;
    newKernels.metaInfo.taskRation = 1;
    newKernels.metaInfo.dfxSize = 1;

    ElfKernelInfo* kernelInfo = new (std::nothrow) ElfKernelInfo();
    if (kernelInfo == nullptr) {
        return;
    }
    kernelInfo->funcType = KERNEL_FUNCTION_TYPE_INVALID;
    kernelInfo->crossCoreSync = FUNC_NO_USE_SYNC;
    kernelInfo->taskRation[0] = 0U; // init value 0
    kernelInfo->taskRation[1] = 0U; // init value 0
    kernelInfo->dfxAddr = nullptr;
    kernelInfo->dfxSize = 0ULL;
    std::map<std::string, ElfKernelInfo*> kernelInfoMap;

    std::string kernelName = "test-update-kernels-info";
    kernelInfoMap[kernelName] = kernelInfo;

    rtError_t rtn = UpdateKernelsInfo(kernelInfoMap, &newKernels, &elfData);
    EXPECT_EQ(rtn, RT_ERROR_NONE);
    delete[] newKernels.name;
    delete kernelInfo;
}

TEST_F(ELFTest, SymbolAddress)
{
    const uint64_t numSyms = 4;
    rtElfData* elfData;
    elfData = new rtElfData;
    elfData->ascendMetaFlag = 0x1F;
    elfData->elf_header.e_shnum = 1;
    elfData->obj_ptr_origin = nullptr;

    elfData->section_headers = new Elf_Internal_Shdr[1];
    elfData->section_headers[0].sh_offset = 0;
    elfData->section_headers[0].sh_addr = 0;

    string var1 = "g_sysFftsAddr";
    string var2 = "g_opL2CacheHintCfg";
    string var3 = "g_sysPrintFifoSpace";
    string var4 = "g_sysSimtPrintFifoSpace";
    const uint64_t strSize = var1.size() + 1U + var2.size() + 1U + var3.size() + 1U + var4.size() + 1U;
    std::unique_ptr<char_t[]> strTbl(new (std::nothrow) char_t[strSize]);
    memcpy_s(
        strTbl.get(), var1.size() + 1U + var2.size() + 1U + var3.size() + 1U + var4.size() + 1U, var1.c_str(),
        var1.size() + 1U);
    memcpy_s(
        strTbl.get() + var1.size() + 1U, var2.size() + 1U + var3.size() + 1U + var4.size() + 1U, var2.c_str(),
        var2.size() + 1U);
    memcpy_s(
        strTbl.get() + var1.size() + 1U + var2.size() + 1U, var3.size() + 1U + var4.size() + 1U, var3.c_str(),
        var3.size() + 1U);
    memcpy_s(
        strTbl.get() + var1.size() + 1U + var2.size() + 1U + var3.size() + 1U, var4.size() + 1U, var4.c_str(),
        var4.size() + 1U);

    std::unique_ptr<Elf_Internal_Sym[]> symTab(new (std::nothrow) Elf_Internal_Sym[numSyms]);
    Elf_Internal_Sym* psym = symTab.get();

    uint64_t g_sysFftsAddr = 0;
    uint64_t g_opL2CacheHintCfg = 0;
    uint64_t g_sysPrintFifoSpace = 0;
    uint64_t g_sysSimtPrintFifoSpace = 0;

    // 设置 g_sysFftsAddr 符号信息
    psym->st_name = 0;
    psym->st_value = reinterpret_cast<uint64_t>(&g_sysFftsAddr);
    psym->st_shndx = 0;
    psym->st_info = STT_OBJECT;

    // 设置 g_opL2CacheHintCfg 符号信息
    ++psym;
    psym->st_name = var1.size() + 1U;
    psym->st_value = reinterpret_cast<uint64_t>(&g_opL2CacheHintCfg);
    psym->st_shndx = 0;
    psym->st_info = STT_OBJECT;

    // 设置 g_sysPrintFifoSpace 符号信息
    ++psym;
    psym->st_name = var1.size() + 1U + var2.size() + 1U;
    psym->st_value = reinterpret_cast<uint64_t>(&g_sysPrintFifoSpace);
    psym->st_shndx = 0;
    psym->st_info = STT_OBJECT;

    // 设置 g_sysSimtPrintFifoSpace 符号信息
    ++psym;
    psym->st_name = var1.size() + 1U + var2.size() + 1U + var3.size() + 1U;
    psym->st_value = reinterpret_cast<uint64_t>(&g_sysSimtPrintFifoSpace);
    psym->st_shndx = 0;
    psym->st_info = STT_OBJECT;

    elfData->elf_header.e_shnum = 0;
    SetSymbolAddress(strTbl.get(), symTab.get(), numSyms, elfData);

    SetSymbolAddress(nullptr, symTab.get(), numSyms, elfData);

    elfData->elf_header.e_shnum = 1;
    SetSymbolAddress(strTbl.get(), symTab.get(), numSyms, elfData);

    rtError_t error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE, 87);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE, 4 * 1024 * 1024);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE, 87);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE, 4 * 1024 * 1024);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    error = RefreshSymbolAddress(elfData);
    EXPECT_EQ(error, RT_ERROR_NONE);

    elfData->ascendMetaFlag = 0x10;
    error = RefreshSymbolAddress(elfData);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete[] elfData->section_headers;
    elfData->section_headers = nullptr;

    delete elfData;
    elfData = nullptr;
}

TEST_F(ELFTest, UpdateKernelsInfo_NoParamSummary)
{
    rtElfData elfData = {};
    elfData.kernel_num = 1;

    RtKernel newKernels;
    newKernels.name = new (std::nothrow) char[5];
    strcpy_s(newKernels.name, 5, "test");
    newKernels.offset = 0;
    newKernels.length = 1;
    newKernels.metaInfo.funcType = 1;
    newKernels.metaInfo.crossCoreSync = 1;
    newKernels.metaInfo.taskRation = 1;
    newKernels.metaInfo.dfxSize = 1;
    newKernels.metaInfo.paramInfos = nullptr;
    newKernels.metaInfo.paramCount = 0U;
    newKernels.metaInfo.paramTotalSize = 0ULL;
    newKernels.metaInfo.hasParamSummary = false;

    ElfKernelInfo* kernelInfo = new (std::nothrow) ElfKernelInfo();
    if (kernelInfo == nullptr) {
        delete[] newKernels.name;
        return;
    }
    kernelInfo->funcType = KERNEL_FUNCTION_TYPE_INVALID;
    kernelInfo->crossCoreSync = FUNC_NO_USE_SYNC;
    kernelInfo->taskRation[0] = 0U;
    kernelInfo->taskRation[1] = 0U;
    kernelInfo->dfxAddr = nullptr;
    kernelInfo->dfxSize = 0ULL;
    kernelInfo->hasParamSummary = false;
    kernelInfo->paramCount = 0U;

    std::map<std::string, ElfKernelInfo*> kernelInfoMap;
    std::string kernelName = "test-no-param-summary";
    kernelInfoMap[kernelName] = kernelInfo;

    rtError_t rtn = UpdateKernelsInfo(kernelInfoMap, &newKernels, &elfData);
    EXPECT_EQ(rtn, RT_ERROR_NONE);
    EXPECT_EQ(newKernels.metaInfo.hasParamSummary, false);
    EXPECT_EQ(newKernels.metaInfo.paramCount, 0U);
    EXPECT_EQ(newKernels.metaInfo.paramInfos.get(), nullptr);

    delete[] newKernels.name;
    delete kernelInfo;
}

TEST_F(ELFTest, UpdateKernelsInfo_Success)
{
    rtElfData elfData = {};
    elfData.kernel_num = 1;

    RtKernel newKernels;
    newKernels.name = new (std::nothrow) char[19];
    strcpy_s(newKernels.name, 19, "test-param-success");
    newKernels.offset = 0;
    newKernels.length = 1;
    newKernels.metaInfo.funcType = 1;
    newKernels.metaInfo.crossCoreSync = 1;
    newKernels.metaInfo.taskRation = 1;
    newKernels.metaInfo.dfxSize = 1;

    ElfKernelInfo* kernelInfo = new (std::nothrow) ElfKernelInfo();
    if (kernelInfo == nullptr) {
        delete[] newKernels.name;
        return;
    }
    kernelInfo->funcType = KERNEL_FUNCTION_TYPE_INVALID;
    kernelInfo->crossCoreSync = FUNC_NO_USE_SYNC;
    kernelInfo->taskRation[0] = 0U;
    kernelInfo->taskRation[1] = 0U;
    kernelInfo->dfxAddr = nullptr;
    kernelInfo->dfxSize = 0ULL;
    kernelInfo->hasParamSummary = true;
    kernelInfo->paramCount = 2U;
    kernelInfo->paramTotalSize = 48ULL;

    ElfParamInfo paramInfo1 = {};
    paramInfo1.info.ordinal = 0;
    paramInfo1.info.offset = 0;
    paramInfo1.info.size = 16;
    kernelInfo->cachedParamInfos.push_back(paramInfo1);

    ElfParamInfo paramInfo2 = {};
    paramInfo2.info.ordinal = 1;
    paramInfo2.info.offset = 16;
    paramInfo2.info.size = 32;
    kernelInfo->cachedParamInfos.push_back(paramInfo2);

    std::map<std::string, ElfKernelInfo*> kernelInfoMap;
    std::string kernelName = "test-param-success";
    kernelInfoMap[kernelName] = kernelInfo;

    rtError_t rtn = UpdateKernelsInfo(kernelInfoMap, &newKernels, &elfData);
    EXPECT_EQ(rtn, RT_ERROR_NONE);
    EXPECT_EQ(newKernels.metaInfo.hasParamSummary, true);
    EXPECT_EQ(newKernels.metaInfo.paramCount, 2U);
    EXPECT_EQ(newKernels.metaInfo.paramTotalSize, 48ULL);
    EXPECT_NE(newKernels.metaInfo.paramInfos.get(), nullptr);

    delete[] newKernels.name;
    delete kernelInfo;
}

TEST_F(ELFTest, ElfParseParamSummary_Success)
{
    rtElfData* elfData = new rtElfData;
    (void)ProcessObject((char_t*)elf_o, elfData);

    uint8_t paramSummaryBuf[64] = {0};
    ElfParamSummary paramSummary = {};
    paramSummary.head.type = RT_FUNCTION_TYPE_PARAM_SUMMARY;
    paramSummary.head.length = sizeof(uint32_t) + sizeof(uint64_t);
    paramSummary.paraNums = 5U;
    paramSummary.paramTotalSize = 256ULL;

    errno_t ret = memcpy_s(paramSummaryBuf, sizeof(paramSummaryBuf), &paramSummary, sizeof(ElfParamSummary));
    EXPECT_EQ(ret, EOK);

    ElfKernelInfo kernelInfo = {};
    GetKernelTlvInfo(paramSummaryBuf, sizeof(ElfParamSummary), &kernelInfo);
    EXPECT_EQ(kernelInfo.hasParamSummary, true);
    EXPECT_EQ(kernelInfo.paramCount, 5U);
    EXPECT_EQ(kernelInfo.paramTotalSize, 256ULL);

    if (elfData->section_headers != nullptr) {
        delete[] elfData->section_headers;
    }
    delete elfData;
}

TEST_F(ELFTest, ElfParseParamInfo_Success)
{
    rtElfData* elfData = new rtElfData;
    (void)ProcessObject((char_t*)elf_o, elfData);

    uint8_t paramInfoBuf[64] = {0};
    ElfParamInfo paramInfo = {};
    paramInfo.head.type = RT_FUNCTION_TYPE_PARAM_INFO;
    paramInfo.head.length = sizeof(ElfParamBody);
    paramInfo.info.index = 2U;
    paramInfo.info.ordinal = 3U;
    paramInfo.info.offset = 128U;
    paramInfo.info.size = 64U;
    paramInfo.info.align = 8U;
    paramInfo.info.paramType = 1U;
    paramInfo.info.spaceIndex = 0U;
    paramInfo.info.spaceType = 0U;
    paramInfo.info.space = 0U;
    paramInfo.info.resv = 0U;

    errno_t ret = memcpy_s(paramInfoBuf, sizeof(paramInfoBuf), &paramInfo, sizeof(ElfParamInfo));
    EXPECT_EQ(ret, EOK);

    ElfKernelInfo kernelInfo = {};
    GetKernelTlvInfo(paramInfoBuf, sizeof(ElfParamInfo), &kernelInfo);
    EXPECT_EQ(kernelInfo.cachedParamInfos.size(), 1U);
    if (kernelInfo.cachedParamInfos.size() > 0) {
        EXPECT_EQ(kernelInfo.cachedParamInfos[0].info.index, 2U);
        EXPECT_EQ(kernelInfo.cachedParamInfos[0].info.ordinal, 3U);
        EXPECT_EQ(kernelInfo.cachedParamInfos[0].info.offset, 128U);
        EXPECT_EQ(kernelInfo.cachedParamInfos[0].info.size, 64U);
        EXPECT_EQ(kernelInfo.cachedParamInfos[0].info.align, 8U);
        EXPECT_EQ(kernelInfo.cachedParamInfos[0].info.paramType, 1U);
        EXPECT_EQ(kernelInfo.cachedParamInfos[0].info.spaceIndex, 0U);
        EXPECT_EQ(kernelInfo.cachedParamInfos[0].info.spaceType, 0U);
        EXPECT_EQ(kernelInfo.cachedParamInfos[0].info.space, 0U);
        EXPECT_EQ(kernelInfo.cachedParamInfos[0].info.resv, 0U);
    }

    if (elfData->section_headers != nullptr) {
        delete[] elfData->section_headers;
    }
    delete elfData;
}

TEST_F(ELFTest, GetKernelTlvInfo_MultipleTlv)
{
    rtElfData* elfData = new rtElfData;
    (void)ProcessObject((char_t*)elf_o, elfData);

    uint8_t multiTlvBuf[128] = {0};
    uint8_t* curBuf = multiTlvBuf;
    uint32_t offset = 0;

    ElfParamSummary paramSummary = {};
    paramSummary.head.type = RT_FUNCTION_TYPE_PARAM_SUMMARY;
    paramSummary.head.length = sizeof(uint32_t) + sizeof(uint64_t);
    paramSummary.paraNums = 2U;
    paramSummary.paramTotalSize = 80ULL;
    memcpy_s(curBuf + offset, 128 - offset, &paramSummary, sizeof(ElfParamSummary));
    offset += sizeof(ElfParamSummary);

    ElfParamInfo paramInfo1 = {};
    paramInfo1.head.type = RT_FUNCTION_TYPE_PARAM_INFO;
    paramInfo1.head.length = sizeof(ElfParamBody);
    paramInfo1.info.ordinal = 0U;
    paramInfo1.info.offset = 0U;
    paramInfo1.info.size = 32U;
    memcpy_s(curBuf + offset, 128 - offset, &paramInfo1, sizeof(ElfParamInfo));
    offset += sizeof(ElfParamInfo);

    ElfParamInfo paramInfo2 = {};
    paramInfo2.head.type = RT_FUNCTION_TYPE_PARAM_INFO;
    paramInfo2.head.length = sizeof(ElfParamBody);
    paramInfo2.info.ordinal = 1U;
    paramInfo2.info.offset = 32U;
    paramInfo2.info.size = 48U;
    memcpy_s(curBuf + offset, 128 - offset, &paramInfo2, sizeof(ElfParamInfo));
    offset += sizeof(ElfParamInfo);

    ElfKernelInfo kernelInfo = {};
    GetKernelTlvInfo(multiTlvBuf, offset, &kernelInfo);
    EXPECT_EQ(kernelInfo.hasParamSummary, true);
    EXPECT_EQ(kernelInfo.paramCount, 2U);
    EXPECT_EQ(kernelInfo.paramTotalSize, 80ULL);
    EXPECT_EQ(kernelInfo.cachedParamInfos.size(), 2U);
    if (kernelInfo.cachedParamInfos.size() >= 2) {
        EXPECT_EQ(kernelInfo.cachedParamInfos[0].info.offset, 0U);
        EXPECT_EQ(kernelInfo.cachedParamInfos[0].info.size, 32U);
        EXPECT_EQ(kernelInfo.cachedParamInfos[1].info.offset, 32U);
        EXPECT_EQ(kernelInfo.cachedParamInfos[1].info.size, 48U);
    }

    if (elfData->section_headers != nullptr) {
        delete[] elfData->section_headers;
    }
    delete elfData;
}

TEST_F(ELFTest, GetBinaryMetaInfo_Error)
{
    rtElfData* tempData = new rtElfData;
    (void)ProcessObject((char_t*)elf_o, tempData);
    if (tempData->section_headers != nullptr) {
        delete[] tempData->section_headers;
    }
    delete tempData;

    rtElfData elfData = {};
    void* data = nullptr;
    size_t dataSize = 0;
    rtError_t ret = GetBinaryMetaInfo(&elfData, 99, 1, &data, &dataSize);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

// ===== AICPU SO printf TLV detection UT =====
// Constructs a minimal 64-bit ELF with a .ascend.meta section containing specified TLVs.
// Layout: | Elf64_Ehdr | shstrtab | .ascend.meta data | Elf64_Shdr[2] |
//          section[0] = .ascend.meta, section[1] = .shstrtab

struct MiniElf {
    std::vector<uint8_t> buf;
};

static MiniElf BuildElfWithMetaSection(const std::vector<std::pair<uint16_t, std::vector<uint8_t>>>& tlvs)
{
    MiniElf elf;
    constexpr uint16_t ELF_MAGIC0 = 0x464C457FU; // \x7fELF
    constexpr uint8_t ELFCLASS64 = 2U;
    constexpr uint8_t ELFDATA2LSB = 1U;
    constexpr uint16_t SHT_PROGBITS = 1U;
    constexpr uint16_t SHT_STRTAB = 3U;

    const std::string metaName = ".ascend.meta";
    const std::string strtabName = ".shstrtab";
    std::string shstrtab;
    shstrtab += '\0';
    const uint32_t metaNameIdx = static_cast<uint32_t>(shstrtab.size());
    shstrtab += metaName + '\0';
    const uint32_t strtabNameIdx = static_cast<uint32_t>(shstrtab.size());
    shstrtab += strtabName + '\0';

    std::vector<uint8_t> metaData;
    for (const auto& tlv : tlvs) {
        ElfTlvHead head;
        head.type = tlv.first;
        head.length = static_cast<uint16_t>(tlv.second.size());
        metaData.insert(
            metaData.end(), reinterpret_cast<uint8_t*>(&head), reinterpret_cast<uint8_t*>(&head) + sizeof(ElfTlvHead));
        metaData.insert(metaData.end(), tlv.second.begin(), tlv.second.end());
    }

    const uint64_t ehdrSize = sizeof(Elf64_External_Ehdr);
    const uint64_t shstrtabOff = ehdrSize;
    const uint64_t metaOff = shstrtabOff + shstrtab.size();
    const uint64_t shdrOff = metaOff + metaData.size();
    const uint16_t shentsize = static_cast<uint16_t>(sizeof(Elf64_External_Shdr));
    const uint16_t shnum = 2U;
    const uint16_t shstrndx = 1U;

    elf.buf.resize(shdrOff + shnum * sizeof(Elf64_External_Shdr), 0);

    auto put16 = [&elf](uint64_t off, uint16_t val) {
        for (int i = 0; i < 2; ++i) {
            elf.buf[off + i] = static_cast<uint8_t>((val >> (i * 8)) & 0xFF);
        }
    };
    auto put32 = [&elf](uint64_t off, uint32_t val) {
        for (int i = 0; i < 4; ++i) {
            elf.buf[off + i] = static_cast<uint8_t>((val >> (i * 8)) & 0xFF);
        }
    };
    auto put64 = [&elf](uint64_t off, uint64_t val) {
        for (int i = 0; i < 8; ++i) {
            elf.buf[off + i] = static_cast<uint8_t>((val >> (i * 8)) & 0xFF);
        }
    };

    // e_ident
    elf.buf[0] = 0x7FU;
    elf.buf[1] = 'E';
    elf.buf[2] = 'L';
    elf.buf[3] = 'F';
    elf.buf[4] = ELFCLASS64;
    elf.buf[5] = ELFDATA2LSB;
    elf.buf[6] = 1U;
    // e_type, e_machine, e_version
    put16(16, 2U);
    put16(18, 0xB7U);
    put32(20, 1U);
    // e_entry, e_phoff
    put64(24, 0UL);
    put64(32, 0UL);
    // e_shoff
    put64(40, shdrOff);
    // e_flags, e_ehsize, e_phentsize, e_phnum
    put32(48, 0U);
    put16(52, static_cast<uint16_t>(ehdrSize));
    put16(54, 0U);
    put16(56, 0U);
    // e_shentsize, e_shnum, e_shstrndx
    put16(58, shentsize);
    put16(60, shnum);
    put16(62, shstrndx);

    // shstrtab data
    std::copy(shstrtab.begin(), shstrtab.end(), elf.buf.begin() + shstrtabOff);
    // .ascend.meta data
    std::copy(metaData.begin(), metaData.end(), elf.buf.begin() + metaOff);

    // section header[0]: .ascend.meta
    uint64_t shdr0 = shdrOff;
    put32(shdr0 + 0, metaNameIdx);
    put32(shdr0 + 4, SHT_PROGBITS);
    put64(shdr0 + 8, 0UL);
    put64(shdr0 + 16, 0UL);
    put64(shdr0 + 24, metaOff);
    put64(shdr0 + 32, static_cast<uint64_t>(metaData.size()));
    put32(shdr0 + 40, 0U);
    put32(shdr0 + 44, 0U);
    put64(shdr0 + 48, 1UL);
    put64(shdr0 + 56, 0UL);

    // section header[1]: .shstrtab
    uint64_t shdr1 = shdrOff + sizeof(Elf64_External_Shdr);
    put32(shdr1 + 0, strtabNameIdx);
    put32(shdr1 + 4, SHT_STRTAB);
    put64(shdr1 + 8, 0UL);
    put64(shdr1 + 16, 0UL);
    put64(shdr1 + 24, shstrtabOff);
    put64(shdr1 + 32, static_cast<uint64_t>(shstrtab.size()));
    put32(shdr1 + 40, 0U);
    put32(shdr1 + 44, 0U);
    put64(shdr1 + 48, 1UL);
    put64(shdr1 + 56, 0UL);

    return elf;
}

TEST_F(ELFTest, CheckAicpuSoPrintfTlv_InvalidInput)
{
    bool hasPrintf = true;
    rtError_t ret = CheckAicpuSoPrintfTlv(nullptr, 0, hasPrintf);
    EXPECT_NE(ret, RT_ERROR_NONE);
    EXPECT_EQ(hasPrintf, false);

    uint8_t nonElf[] = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07};
    hasPrintf = true;
    ret = CheckAicpuSoPrintfTlv(nonElf, sizeof(nonElf), hasPrintf);
    EXPECT_NE(ret, RT_ERROR_NONE);
    EXPECT_EQ(hasPrintf, false);

    auto invalidSectionElf = BuildElfWithMetaSection({});
    hasPrintf = true;
    ret = CheckAicpuSoPrintfTlv(invalidSectionElf.buf.data(), sizeof(Elf64_External_Ehdr), hasPrintf);
    EXPECT_NE(ret, RT_ERROR_NONE);
    EXPECT_EQ(hasPrintf, false);
}

TEST_F(ELFTest, CheckAicpuSoPrintfTlv_NoMetaSection)
{
    bool hasPrintf = true;
    rtError_t ret = CheckAicpuSoPrintfTlv(elf_o, elf_o_len, hasPrintf);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(hasPrintf, false);
}

TEST_F(ELFTest, CheckAicpuSoPrintfTlv_InvalidSectionNameOffset)
{
    auto elf = BuildElfWithMetaSection({});
    const size_t sectionHeaderOffset = elf.buf.size() - 2U * sizeof(Elf64_External_Shdr);
    std::fill_n(elf.buf.begin() + sectionHeaderOffset, sizeof(uint32_t), 0xFFU);

    bool hasPrintf = true;
    const rtError_t ret = CheckAicpuSoPrintfTlv(elf.buf.data(), elf.buf.size(), hasPrintf);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(hasPrintf, false);
}

TEST_F(ELFTest, CheckAicpuSoPrintfTlv_WithAndWithoutPrintfTlv)
{
    constexpr uint16_t PRINTF_TLV_TYPE = 4U;
    constexpr uint32_t PRINTF_TLV_VALUE = 6U;
    uint32_t goodVal = PRINTF_TLV_VALUE;
    uint32_t badVal = 5U;
    std::vector<uint8_t> goodValBytes(
        reinterpret_cast<uint8_t*>(&goodVal), reinterpret_cast<uint8_t*>(&goodVal) + sizeof(uint32_t));
    std::vector<uint8_t> badValBytes(
        reinterpret_cast<uint8_t*>(&badVal), reinterpret_cast<uint8_t*>(&badVal) + sizeof(uint32_t));

    auto elf1 = BuildElfWithMetaSection({{PRINTF_TLV_TYPE, goodValBytes}});
    bool hasPrintf = false;
    rtError_t ret = CheckAicpuSoPrintfTlv(elf1.buf.data(), elf1.buf.size(), hasPrintf);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(hasPrintf, true);

    auto elf2 = BuildElfWithMetaSection({{1U, badValBytes}, {PRINTF_TLV_TYPE, goodValBytes}, {5U, badValBytes}});
    hasPrintf = false;
    ret = CheckAicpuSoPrintfTlv(elf2.buf.data(), elf2.buf.size(), hasPrintf);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(hasPrintf, true);

    auto elf3 = BuildElfWithMetaSection({{PRINTF_TLV_TYPE, badValBytes}});
    hasPrintf = true;
    ret = CheckAicpuSoPrintfTlv(elf3.buf.data(), elf3.buf.size(), hasPrintf);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(hasPrintf, false);

    auto elf4 = BuildElfWithMetaSection({{3U, goodValBytes}});
    hasPrintf = true;
    ret = CheckAicpuSoPrintfTlv(elf4.buf.data(), elf4.buf.size(), hasPrintf);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(hasPrintf, false);

    auto elf5 = BuildElfWithMetaSection({{1U, badValBytes}});
    hasPrintf = true;
    ret = CheckAicpuSoPrintfTlv(elf5.buf.data(), elf5.buf.size(), hasPrintf);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(hasPrintf, false);
}

// ===== ParseAicpuSoForPrintfTlv via LoadCpuKernelFromData UT =====

TEST_F(ELFTest, ParseAicpuSoForPrintfTlv_DfxNotSupported)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);
    dev->aicpuDfxSupport_ = false;

    constexpr uint16_t PRINTF_TLV_TYPE = 4U;
    uint32_t val = 6U;
    std::vector<uint8_t> valBytes(
        reinterpret_cast<uint8_t*>(&val), reinterpret_cast<uint8_t*>(&val) + sizeof(uint32_t));
    auto elf = BuildElfWithMetaSection({{PRINTF_TLV_TYPE, valBytes}});

    MOCKER_CPP(&BinaryLoader::ParseAicpuSoForPrintfTlv).expects(never());
    BinaryLoader loader(elf.buf.data(), elf.buf.size(), nullptr);
    PlainProgram* prog = loader.LoadCpuKernelFromData();
    ASSERT_NE(prog, nullptr);
    EXPECT_EQ(prog->HasPrintfTlv(), false);
    GlobalMockObject::verify();
    delete prog;

    rtDeviceReset(0);
}

TEST_F(ELFTest, ParseAicpuSoForPrintfTlv_DfxSupported)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);
    dev->aicpuDfxSupport_ = true;

    constexpr uint16_t PRINTF_TLV_TYPE = 4U;
    uint32_t goodVal = 6U;
    uint32_t badVal = 5U;
    std::vector<uint8_t> goodValBytes(
        reinterpret_cast<uint8_t*>(&goodVal), reinterpret_cast<uint8_t*>(&goodVal) + sizeof(uint32_t));
    std::vector<uint8_t> badValBytes(
        reinterpret_cast<uint8_t*>(&badVal), reinterpret_cast<uint8_t*>(&badVal) + sizeof(uint32_t));

    auto elfWithPrintf = BuildElfWithMetaSection({{1U, badValBytes}, {PRINTF_TLV_TYPE, goodValBytes}});
    BinaryLoader loader1(elfWithPrintf.buf.data(), elfWithPrintf.buf.size(), nullptr);
    PlainProgram* prog1 = loader1.LoadCpuKernelFromData();
    ASSERT_NE(prog1, nullptr);
    EXPECT_EQ(prog1->HasPrintfTlv(), true);
    delete prog1;

    auto elfWithoutPrintf = BuildElfWithMetaSection({{1U, badValBytes}});
    BinaryLoader loader2(elfWithoutPrintf.buf.data(), elfWithoutPrintf.buf.size(), nullptr);
    PlainProgram* prog2 = loader2.LoadCpuKernelFromData();
    ASSERT_NE(prog2, nullptr);
    EXPECT_EQ(prog2->HasPrintfTlv(), false);
    delete prog2;

    dev->aicpuDfxSupport_ = false;
    rtDeviceReset(0);
}
