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
// #define private public
#include "runtime.hpp"
#include "program.hpp"
#include "kernel.hpp"
#undef private
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

#include "elf.hpp"

using namespace testing;
using namespace cce::runtime;

class ELFTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"ELF test start"<<std::endl;

    }

    static void TearDownTestCase()
    {
        std::cout<<"ELF test start end"<<std::endl;

    }

    // Some expensive resource shared by all tests.
    virtual void SetUp()
    {
        rtSetDevice(0);
        std::cout << "a test SetUP" << std::endl;
		GlobalMockObject::verify();
    }
    virtual void TearDown()
    {
        rtDeviceReset(0);
        std::cout << "a test TearDown" << std::endl;
		GlobalMockObject::verify();
    }

};


TEST_F(ELFTest, ELF_Process_Object_01)
{
    size_t MAX_LENGTH = 75776;
    FILE *bin = NULL;

    //bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o", "rb");
    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/conv_fwd_sample.cce.tmp", "rb");
    //bin = fopen("conv_fwd_sample.cce.out", "rb");
    if (bin == NULL)
    {
        printf("error\n");
        return;
    }
    else
    {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData    *elfData;
    RtKernel    *kernels;

    elfData = new rtElfData;
    bool isSupportMix = false;

    kernels = ProcessObject(bindata, elfData, 0, &isSupportMix);
    EXPECT_EQ(elfData->kernel_num, 1);

    if(NULL != elfData->section_headers)
    {
        delete [] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    for (uint32_t i = 0; i < elfData->kernel_num; ++i) {
        if (kernels != nullptr) {
            DELETE_A(kernels[i].name);
        }
    }
    delete elfData;
    elfData = NULL;
    delete [] kernels;
    kernels = NULL;
}

TEST_F(ELFTest, ELF_Process_Object_02)
{
    size_t MAX_LENGTH = 75776;
    FILE *bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o", "rb");
    if (bin == NULL)
    {
        printf("error\n");
        return;
    }
    else
    {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData    *elfData;
    RtKernel    *kernels;

    elfData = new rtElfData;
    bool isSupportMix = false;
    kernels = ProcessObject(bindata, elfData, 0, &isSupportMix);
    if(NULL != elfData->section_headers)
    {
        delete [] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    for (uint32_t i = 0; i < elfData->kernel_num; ++i) {
        if (kernels != nullptr) {
            DELETE_A(kernels[i].name);
        }
    }
    delete [] kernels;
    kernels = NULL;
    kernels = ProcessObject(bindata, elfData, 0, &isSupportMix);

    EXPECT_EQ(elfData->kernel_num,1);

    if(NULL != elfData->section_headers)
    {
        delete [] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    for (uint32_t i = 0; i < elfData->kernel_num; ++i) {
        if (kernels != nullptr) {
            DELETE_A(kernels[i].name);
        }
    }
    delete elfData;
    elfData = NULL;
    delete [] kernels;
    kernels = NULL;
}

TEST_F(ELFTest, ELF_Process_Object_03)
{
    size_t MAX_LENGTH = 6144;
    FILE *bin = NULL;

    //bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/bad-elf2.o", "rb");
    bin = fopen("bad-elf2.o", "rb");
    if (bin == NULL)
    {
        printf("error\n");
        return;
    }
    else
    {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData    *elfData;
    RtKernel    *kernels;

    elfData = new rtElfData;
    bool isSupportMix = false;
    kernels = ProcessObject(bindata, elfData, 0, &isSupportMix);
    EXPECT_EQ(elfData->kernel_num, 1);
    if(NULL == kernels)
    {
        printf("SUCC get 64bit section headers failed!\n");
    }
    else
    {
        printf("FAIL\n");
    }

    if(NULL != elfData->section_headers)
    {
        delete [] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    delete elfData;
    elfData = NULL;
    delete [] kernels;
    kernels = NULL;
}

TEST_F(ELFTest, ELF_Process_Object_04)
{
    size_t MAX_LENGTH = 75776;
    FILE *bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/bad-elf3.o", "rb");
    //bin = fopen("bad-elf3.o", "rb");
    if (bin == NULL)
    {
        printf("error\n");
        return;
    }
    else
    {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData    *elfData;
    RtKernel    *kernels;

    elfData = new rtElfData;
    bool isSupportMix = false;
    kernels = ProcessObject(bindata, elfData, 0, &isSupportMix);
    EXPECT_EQ(elfData->kernel_num, 0);

    if(NULL == kernels)
    {
        printf("SUCC get 64bit section headers failed!\n");
    }
    else
    {
        printf("FAIL\n");
    }

    if(NULL != elfData->section_headers)
    {
        delete [] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    delete elfData;
    elfData = NULL;
    delete [] kernels;
    kernels = NULL;
}

TEST_F(ELFTest, ELF_Process_Object_05)
{
    size_t MAX_LENGTH = 75776;
    FILE *bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/bad-elf4.o", "rb");
    //bin = fopen("bad-elf4.o", "rb");
    if (bin == NULL)
    {
        printf("error\n");
        return;
    }
    else
    {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData    *elfData;
    RtKernel    *kernels;

    elfData = new rtElfData;
    bool isSupportMix = false;
    kernels = ProcessObject(bindata, elfData, 0, &isSupportMix);
    EXPECT_EQ(elfData->kernel_num,0);

    if(NULL != elfData->section_headers)
    {
        delete [] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    delete elfData;
    elfData = NULL;
    delete [] kernels;
    kernels = NULL;
}

TEST_F(ELFTest, ELF_Process_Object_06)
{
    size_t MAX_LENGTH = 75776;
    FILE *bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/no-kernel.o", "rb");
    //bin = fopen("no-kernel.o", "rb");
    if (bin == NULL)
    {
        printf("error\n");
        return;
    }
    else
    {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData    *elfData;
    RtKernel    *kernels;

    elfData = new rtElfData;
    bool isSupportMix = false;
    kernels = ProcessObject(bindata, elfData, 0, &isSupportMix);
    EXPECT_EQ(elfData->kernel_num,0);

    if(NULL != elfData->section_headers)
    {
        delete [] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    delete elfData;
    elfData = NULL;
    delete [] kernels;
    kernels = NULL;
}

TEST_F(ELFTest, ELF_Process_Object_07)
{
    size_t MAX_LENGTH = 75776;
    FILE *bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/bad-elf.o", "rb");
    //bin = fopen("bad-elf.o", "rb");
    if (bin == NULL)
    {
        printf("error\n");
        return;
    }
    else
    {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData    *elfData;
    RtKernel    *kernels;

    elfData = new rtElfData;
    bool isSupportMix = false;
    kernels = ProcessObject(bindata, elfData, 0, &isSupportMix);
    EXPECT_EQ(elfData->kernel_num,0);

    if(NULL != elfData->section_headers)
    {
        delete [] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    delete elfData;
    elfData = NULL;
    delete [] kernels;
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
    char *outChar = (char*)out;
    outChar[8] = '\0';

}

TEST_F(ELFTest, ELF_Get_64bit_Section_Headers_Error_02)
{
    rtElfData *elfData;
    int out;
    elfData = new rtElfData;
    if (NULL != elfData)
    {
        memset_s(elfData,sizeof(rtElfData),'\0',sizeof(rtElfData));
    }
    elfData->elf_header.e_shentsize = 0;
    elfData->elf_header.e_shnum = 0;

    out = Get64bitSectionHeaders(elfData);
    EXPECT_EQ(out,1);

    elfData->elf_header.e_shentsize = 1;
    elfData->elf_header.e_shnum = 1;

    out = Get64bitSectionHeaders(elfData);
    EXPECT_EQ(out,1);

    elfData->elf_header.e_shentsize = 100;
    elfData->elf_header.e_shnum = 1;

    out = Get64bitSectionHeaders(elfData);
    EXPECT_EQ(out,1);

    if (NULL != elfData)
    {
        if(NULL != elfData->section_headers)
        {
            delete [] elfData->section_headers;
            elfData->section_headers = NULL;
        }

        delete elfData;
        elfData = NULL;
    }
}

TEST_F(ELFTest, ELF_Get_64bit_Elf_Symbols_Error_01)
{
    rtElfData *elfData;
    Elf_Internal_Shdr *section;
    unsigned long num_syms_return = 0;
    elfData = new rtElfData;

    if (NULL != elfData)
    {
        memset_s(elfData,sizeof(rtElfData),'\0',sizeof(rtElfData));
    }
    section= new Elf_Internal_Shdr;
    if (NULL != section)
    {
        memset_s(section,sizeof(Elf_Internal_Shdr),'\0',sizeof(Elf_Internal_Shdr));
    }
    section->sh_size = 0;
    std::unique_ptr<Elf_Internal_Sym[]> out = Get64bitElfSymbols(elfData, section, &num_syms_return);
    EXPECT_EQ(elfData->kernel_num,0);
    if (NULL != elfData)
    {
        if(NULL != elfData->section_headers)
        {
            delete [] elfData->section_headers;
            elfData->section_headers = NULL;
        }

        delete elfData;
        elfData = NULL;
    }
    if (NULL != section)
    {
        delete section;
        section = NULL;
    }

}

TEST_F(ELFTest, ELF_Get_64bit_Elf_Symbols_Error_02)
{
    rtElfData *elfData;
    Elf_Internal_Shdr *section;
    unsigned long num_syms_return = 0;
    elfData = new rtElfData;
    if (NULL != elfData)
    {
        memset_s(elfData,sizeof(rtElfData),'\0',sizeof(rtElfData));
    }
    section= new Elf_Internal_Shdr;
    if (NULL != section)
    {
        memset_s(section,sizeof(Elf_Internal_Shdr),'\0',sizeof(Elf_Internal_Shdr));
    }
    section->sh_size = 1;
    section->sh_entsize = 0;
    std::unique_ptr<Elf_Internal_Sym[]> out = Get64bitElfSymbols(elfData, section, &num_syms_return);
    EXPECT_EQ(elfData->kernel_num,0);
    if (NULL != elfData)
    {
        if(NULL != elfData->section_headers)
        {
            delete [] elfData->section_headers;
            elfData->section_headers = NULL;
        }

        delete elfData;
        elfData = NULL;
    }
    if (NULL != section)
    {
        delete section;
        section = NULL;
    }

}

TEST_F(ELFTest, ELF_Get_64bit_Elf_Symbols_Error_03)
{
    rtElfData *elfData;
    Elf_Internal_Shdr *section;
    unsigned long num_syms_return = 0;
    elfData = new rtElfData;;
    if (NULL != elfData)
    {
        memset_s(elfData,sizeof(rtElfData),'\0',sizeof(rtElfData));
    }
    section= new Elf_Internal_Shdr;
    if (NULL != section)
    {
        memset_s(section,sizeof(Elf_Internal_Shdr),'\0',sizeof(Elf_Internal_Shdr));
    }
    section->sh_size = 2;
    section->sh_entsize = 1;
    std::unique_ptr<Elf_Internal_Sym[]> out = Get64bitElfSymbols(elfData, section, &num_syms_return);
    EXPECT_EQ(elfData->kernel_num,0);
    if (NULL != elfData)
    {
        if(NULL != elfData->section_headers)
        {
            delete [] elfData->section_headers;
            elfData->section_headers = NULL;
        }

        delete elfData;
        elfData = NULL;
    }
    if (NULL != section)
    {
        delete section;
        section = NULL;
    }

}

TEST_F(ELFTest, ELF_Process_Object_Error)
{
    rtElfData *elfData;
    RtKernel* out;
    char *obj_buf = NULL;

    elfData = new rtElfData;
    if (NULL != elfData)
    {
        memset_s(elfData,sizeof(rtElfData),'\0',sizeof(rtElfData));
    }
    bool isSupportMix = false;
    out = ProcessObject(obj_buf, elfData, 0, &isSupportMix);
    EXPECT_EQ(elfData->kernel_num,0);
    if (NULL != elfData)
    {
        if(NULL != elfData->section_headers)
        {
            delete [] elfData->section_headers;
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
    FILE *bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/conv_fwd_sample.cce.tmp", "rb");
    if (bin == NULL)
    {
        printf("error\n");
        return;
    }
    else
    {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData *elfData;
    RtKernel *kernels;

    elfData = new rtElfData;
    elfData->elf_header.e_shnum = 1;

    Elf_Internal_Shdr *section_headers = new Elf_Internal_Shdr;
    section_headers->sh_size = 0;
    elfData->section_headers = section_headers;

    bool isSupportMix = false;
    kernels = ProcessObject(bindata, elfData, 0, &isSupportMix);
    EXPECT_EQ(elfData->kernel_num,1);
    delete [] kernels[0].name;
    if(NULL != elfData->section_headers)
    {
        delete [] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    delete elfData;
    elfData = NULL;
    delete []kernels;
    kernels = NULL;
    delete section_headers;
}

int num_stub = 1;
extern "C" void *__real_malloc (size_t c);
void *malloc_stub_elf(unsigned int num_bytes)
{
    if (7 == num_stub)
    {
        return NULL;
    }
    num_stub++;
    return __real_malloc(num_bytes);
}

TEST_F(ELFTest, ELF_Process_Object_09)
{
    size_t MAX_LENGTH = 75776;
    FILE *bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/conv_fwd_sample.cce.tmp", "rb");
    if (bin == NULL)
    {
        printf("error\n");
        return;
    }
    else
    {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData *elfData;
    RtKernel *kernels;

    elfData= (rtElfData*)malloc(sizeof(rtElfData));
    elfData->elf_header.e_shnum = 1;

    Elf_Internal_Shdr *section_headers = (Elf_Internal_Shdr *)malloc(sizeof(Elf_Internal_Shdr));
    section_headers->sh_size = 0;
    elfData->section_headers = section_headers;

    MOCKER(malloc).stubs().will(invoke(malloc_stub_elf));

    bool isSupportMix = false;
    kernels = ProcessObject(bindata, elfData, 0, &isSupportMix);
    EXPECT_EQ(elfData->kernel_num,1);
    if(NULL != elfData->section_headers)
    {
        delete [] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    for (uint32_t i = 0; i < elfData->kernel_num; ++i) {
        if (kernels != nullptr) {
            DELETE_A(kernels[i].name);
        }
    }
    free(elfData);
    elfData = NULL;
    delete []kernels;
    kernels = NULL;
    free(section_headers);
}


TEST_F(ELFTest, ELF_Process_Object_10)
{
    size_t MAX_LENGTH = 75776;
    FILE *bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/conv_fwd_sample.cce.tmp", "rb");
    if (bin == NULL)
    {
        printf("error\n");
        return;
    }
    else
    {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData *elfData;
    RtKernel *kernels;

    elfData = new rtElfData;
    elfData->elf_header.e_shnum = 0;

    Elf_Internal_Shdr *section_headers = new Elf_Internal_Shdr;
    section_headers->sh_size = 0;
    elfData->section_headers = section_headers;
    bool isSupportMix = false;
    kernels = ProcessObject(bindata, elfData, 0, &isSupportMix);
    EXPECT_EQ(elfData->kernel_num,1);
    if(NULL != elfData->section_headers)
    {
        delete [] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    for (uint32_t i = 0; i < elfData->kernel_num; ++i) {
        if (kernels != nullptr) {
            DELETE_A(kernels[i].name);
        }
    }
    delete elfData;
    elfData = NULL;
    delete []kernels;
    kernels = NULL;
    delete section_headers;
}


TEST_F(ELFTest, ELF_Process_Object_11)
{
    size_t MAX_LENGTH = 75776;
    FILE *bin = NULL;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/conv_fwd_sample.cce.tmp", "rb");
    if (bin == NULL)
    {
        printf("error\n");
        return;
    }
    else
    {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);
    bindata[5] = 2;

    rtElfData *elfData;
    RtKernel *kernels;

    elfData = new rtElfData;
    elfData->elf_header.e_shnum = 0;

    Elf_Internal_Shdr *section_headers = new Elf_Internal_Shdr;
    section_headers->sh_size = 0;
    elfData->section_headers = section_headers;

    bool isSupportMix = false;
    kernels = ProcessObject(bindata, elfData, 0, &isSupportMix);
    EXPECT_EQ(elfData->kernel_num,0);
    if(NULL != elfData->section_headers)
    {
        delete [] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    delete elfData;
    elfData = NULL;
    delete [] kernels;
    kernels = NULL;
    delete section_headers;
}

#ifdef AICPU_ON_OS
TEST_F(ELFTest, ELF_Process_Object_12)
{
    size_t MAX_LENGTH = 75776;
    FILE *bin = NULL;

    //bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o", "rb");
    //bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/libXv.so.1.0.0.txt", "rb");
    bin = fopen("/usr/lib/x86_64-linux-gnu/libXv.so.1.0.0", "rb");
    //bin = fopen("conv_fwd_sample.cce.out", "rb");
    if (bin == NULL)
    {
        printf("error\n");
        return;
    }
    else
    {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData    *elfData;
    RtKernel    *kernels;

    elfData = new rtElfData;
    memset(elfData, '\0', sizeof(rtElfData));

    bool isSupportMix = false;
    kernels = ProcessObject(bindata, elfData, 0, &isSupportMix);

    EXPECT_NE(elfData->so_name, (char *)NULL);

    printf ("Library soname: [%s]\n", elfData->so_name);

    if(NULL != elfData->section_headers)
    {
        delete [] elfData->section_headers;
        elfData->section_headers = NULL;
    }
    delete elfData;
    elfData = NULL;
    delete []kernels;
    kernels = NULL;
}
#endif /* AICPU_ON_OS */

TEST_F(ELFTest, ELF_Process_Object_15)
{
    size_t MAX_LENGTH = 75776;
    FILE *bin = nullptr ;

    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/no-kernel.o", "rb");
    if (bin == nullptr ) {
        printf("error\n");
        return;
    } else {
        printf("succ\n");
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    rtElfData    *elfData;
    RtKernel    *kernels;

    elfData = new rtElfData;

    bool isSupportMix = false;
    kernels = ProcessObject(bindata, elfData, false, &isSupportMix);
    if(nullptr  == kernels) {
        printf("SUCC no kernel!\n");
    } else {
        printf("FAIL\n");
    }

    if(nullptr  != elfData->section_headers) {
        delete [] elfData->section_headers;
        elfData->section_headers = nullptr ;
    }

    uint8_t buf[4096] = {0};
    uint8_t *bufPtr = buf;
    uint32_t totalLen = sizeof(ElfDfxInfo);
    ElfDfxInfo *typeInfo = (ElfDfxInfo *)bufPtr;
    typeInfo->head.type = FUNC_META_TYPE_DFX_TYPE;
    typeInfo->head.length = 100U;
    ElfKernelInfo kernelInfo = {5U, 0U, {1U, 3U}, bufPtr, 108U, false, false, 1U};
    GetKernelTlvInfo(buf, 150U, &kernelInfo);
    EXPECT_EQ(kernelInfo.dfxSize, 108U);
    EXPECT_EQ(kernelInfo.dfxAddr, bufPtr);

    delete elfData;
    elfData = nullptr ;
    delete [] kernels;
    kernels = nullptr ;
}

TEST_F(ELFTest, ELF_CONVERT_TASK_RATION_01)
{
    uint32_t taskRation = 2;
    rtError_t  error = ConvertTaskRation(nullptr, taskRation);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(ELFTest, ELF_CONVERT_TASK_RATION_02)
{
    uint32_t taskRation = 2;
    ElfKernelInfo elfKernelInfo = {5U, 0U, {2U, 1U}};
    rtError_t  error = ConvertTaskRation(&elfKernelInfo, taskRation);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ELFTest, ELF_CONVERT_TASK_RATION_03)
{
    uint32_t taskRation = 2;
    ElfKernelInfo elfKernelInfo = {4U, 0U, {1U, 1U}};
    rtError_t  error = ConvertTaskRation(&elfKernelInfo, taskRation);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ELFTest, ELF_CONVERT_TASK_RATION_04)
{
    uint32_t taskRation = 2;
    ElfKernelInfo elfKernelInfo = {4U, 0U, {1U, 0U}};
    rtError_t  error = ConvertTaskRation(&elfKernelInfo, taskRation);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ELFTest, ELF_CONVERT_TASK_RATION_05)
{
    uint32_t taskRation = 2;
    ElfKernelInfo elfKernelInfo = {5U, 0U, {1U, 0U}};
    rtError_t  error = ConvertTaskRation(&elfKernelInfo, taskRation);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(ELFTest, ELF_CONVERT_TASK_RATION_06)
{
    uint32_t taskRation = 2;
    ElfKernelInfo elfKernelInfo = {4U, 0U, {1U, 3U}};
    rtError_t  error = ConvertTaskRation(&elfKernelInfo, taskRation);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(ELFTest, ELF_GET_MIX_STATUS_01)
{
    uint32_t funcType = 1U;
    uint32_t crossCoreSync = 0U;

    bool isMix = GetMixStatus(funcType, crossCoreSync);
    EXPECT_EQ(isMix, false);
}

TEST_F(ELFTest, ELF_GET_MIX_STATUS_02)
{
    uint32_t funcType = 2U;
    uint32_t crossCoreSync = 1U;

    bool isMix = GetMixStatus(funcType, crossCoreSync);
    EXPECT_EQ(isMix, true);
}

TEST_F(ELFTest, ELF_GET_MIX_STATUS_03)
{
    uint32_t funcType = 3U;
    uint32_t crossCoreSync = 1U;

    bool isMix = GetMixStatus(funcType, crossCoreSync);
    EXPECT_EQ(isMix, true);
}

TEST_F(ELFTest, ELF_GET_MIX_STATUS_04)
{
    uint32_t funcType = 8U;
    uint32_t crossCoreSync = 1U;

    bool isMix = GetMixStatus(funcType, crossCoreSync);
    EXPECT_EQ(isMix, false);
}

TEST_F(ELFTest, ParseElfStackInfoHeader)
{
    rtElfData *elfData = new rtElfData;

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
    bool isSupportMix = true;

    RtKernel newKernels;
    newKernels.name = new (std::nothrow) char[5];
    strcpy_s(newKernels.name, 5, "test");
    newKernels.offset = 0;
    newKernels.length = 1;
    newKernels.funcType = 1;
    newKernels.crossCoreSync = 1;
    newKernels.taskRation = 1;
    newKernels.dfxSize = 1;

    ElfKernelInfo * kernelInfo = new (std::nothrow) ElfKernelInfo();
    if (kernelInfo == nullptr) {
        return;
    }
    kernelInfo->funcType = KERNEL_FUNCTION_TYPE_INVALID;
    kernelInfo->crossCoreSync = FUNC_NO_USE_SYNC;
    kernelInfo->taskRation[0] = 0U; // init value 0
    kernelInfo->taskRation[1] = 0U; // init value 0
    kernelInfo->dfxAddr = nullptr;
    kernelInfo->dfxSize = 0ULL;
    std::map<std::string, ElfKernelInfo *> kernelInfoMap;

    std::string kernelName = "test-update-kernels-info";
    kernelInfoMap[kernelName] = kernelInfo;

    rtError_t rtn = UpdateKernelsInfo(kernelInfoMap, &newKernels, &elfData, &isSupportMix);
    EXPECT_EQ(rtn, RT_ERROR_INVALID_VALUE);
    delete [] newKernels.name;
    delete kernelInfo;
    kernelInfo = NULL;

}
 
TEST_F(ELFTest, SymbolAddress)
{
    const uint64_t numSyms = 4;
    rtElfData    *elfData;
    elfData = new rtElfData;
    elfData->ascendMetaFlag = 0xF;
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
    memcpy_s(strTbl.get(), var1.size() + 1U + var2.size() + 1U + var3.size() + 1U + var4.size() + 1U, var1.c_str(), var1.size() + 1U);
    memcpy_s(strTbl.get() + var1.size() + 1U, var2.size() + 1U + var3.size() + 1U + var4.size() + 1U, var2.c_str(), var2.size() + 1U);
    memcpy_s(strTbl.get() + var1.size() + 1U + var2.size() + 1U, var3.size() + 1U + var4.size() + 1U, var3.c_str(), var3.size() + 1U);
    memcpy_s(strTbl.get() + var1.size() + 1U + var2.size() + 1U + var3.size() + 1U, var4.size() + 1U, var4.c_str(), var4.size() + 1U);

    std::unique_ptr<Elf_Internal_Sym[]> symTab(new (std::nothrow) Elf_Internal_Sym[numSyms]);
    Elf_Internal_Sym *psym = symTab.get();

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
    psym->st_name = var1.size() + 1U +  var2.size() + 1U;
    psym->st_value = reinterpret_cast<uint64_t>(&g_sysPrintFifoSpace);
    psym->st_shndx = 0;
    psym->st_info = STT_OBJECT;

    // 设置 g_sysSimtPrintFifoSpace 符号信息
    ++psym;
    psym->st_name = var1.size() + 1U +  var2.size() + 1U +  var3.size() + 1U;
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

    delete[] elfData->section_headers;
    elfData->section_headers = nullptr;
 
    delete elfData;
    elfData = nullptr;
}