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
#include "program.hpp"
#include "device.hpp"
#include "module.hpp"
#include "context.hpp"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "raw_device.hpp"

using namespace testing;
using namespace cce::runtime;

class ProgramTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout<<"program test start"<<std::endl;

    }

    static void TearDownTestCase()
    {
        std::cout<<"program test end"<<std::endl;

    }

    virtual void SetUp()
    {
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
         GlobalMockObject::verify();
    }
};

TEST_F(ProgramTest, Program_Process_ELF)
{
        rtError_t error;
        rtDevBinary_t binary;

        size_t MAX_LENGTH = 7186;
        FILE *bin = NULL;
        //bin = fopen("conv_fwd_sample.cce.tmp", "rb");
        //bin = fopen("elf.o", "rb");
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

        binary.magic = RT_DEV_BINARY_MAGIC_ELF;
        binary.version = 0;
        binary.data = (void*)bindata;
        binary.length = MAX_LENGTH;

        Program* program = new ElfProgram();
        error = program->Register(binary.data, binary.length);
        EXPECT_EQ(error, RT_ERROR_NONE);

        uint32_t elfMachine = program->Machine();
        printf("machine244:%d\n",elfMachine);

        char kernelName[] = "_Z15executor_conv2dPDhj";
        printf("kernelName:%s\n",kernelName);
        uint32_t length = 0;
        uint32_t symOff = program->SymbolOffset(kernelName, length);
        printf("symOff0:%d\n",symOff);

        uint32_t elfSize = program->LoadSize();
        printf("elfSize:%d\n",elfSize);

        void * output = NULL;
        //uint32_t size = 0;
        output= (void*)malloc(elfSize);
        memset(output,'\0',elfSize);

        error = program->LoadExtract(output, elfSize);
        EXPECT_EQ(error, RT_ERROR_NONE);

        if(NULL != output)
        {
            free(output);
            output = NULL;
        }
        program->SearchKernelByPcAddr(0);
        delete program;
}

TEST_F(ProgramTest, Program_ELF_Parse_SO_Name)
{
        rtError_t error;
        rtDevBinary_t binary;

        size_t MAX_LENGTH = 7186;
        FILE *bin = NULL;
        //bin = fopen("conv_fwd_sample.cce.tmp", "rb");
        //bin = fopen("elf.o", "rb");
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

        binary.magic = RT_DEV_BINARY_MAGIC_ELF;
        binary.version = 0;
        binary.data = (void*)bindata;
        binary.length = MAX_LENGTH;

        ElfProgram* program = new ElfProgram();
        program->elfData_->so_name = (char *)"test.so";
        error = program->Register(binary.data, binary.length);
        EXPECT_EQ(error, RT_ERROR_NONE);

        delete program;
}

TEST_F(ProgramTest, Program_Process_ELF_No_Kernel)
{
        rtError_t error;
        rtDevBinary_t binary;

        size_t MAX_LENGTH = 7186;
        FILE *bin = NULL;
        //bin = fopen("conv_fwd_sample.cce.tmp", "rb");
        //bin = fopen("elf.o", "rb");
        bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/no-kernel.o", "rb");
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

        binary.magic = RT_DEV_BINARY_MAGIC_ELF;
        binary.version = 0;
        binary.data = (void*)bindata;
        binary.length = MAX_LENGTH;

        Program* program = new ElfProgram();
        program->SetIsNewBinaryLoadFlow(true);
        int32_t fun1;
        Kernel * kernel2 = new Kernel(&fun1, "f1", "", program, 10);
        TilingTabl *tilingTab2 = nullptr;
        uint32_t kernelLen2 = 0U;
        program->kernelNameMap_["test1"] = kernel2;
        error = program->BuildTilingTbl(nullptr, &tilingTab2, &kernelLen2);
        EXPECT_EQ(kernelLen2, 1);
        free(tilingTab2);

        TilingTablForDavid *tilingTabForDavid2 = nullptr;
        kernelLen2 = 0U;
        error = program->BuildTilingTblForDavid(nullptr, &tilingTabForDavid2, &kernelLen2);
        EXPECT_EQ(kernelLen2, 1);
        free(tilingTabForDavid2);

        program->SetIsNewBinaryLoadFlow(false);
        Module *mdl;
        TilingTabl *tilingTab = nullptr;
        uint32_t kernelLen = 0;
        error = program->BuildTilingTbl(mdl, &tilingTab, &kernelLen);
        EXPECT_EQ(error, RT_ERROR_PROGRAM_SIZE);
    
        error = program->Register(binary.data, binary.length);
        EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

        uint32_t elfMachine = program->Machine();
        printf("machine244:%d\n",elfMachine);

        char kernelName[] = "_Z15executor_conv2dPDhj";
        printf("kernelName:%s\n",kernelName);
        uint32_t length = 0;
        uint32_t symOff = program->SymbolOffset(kernelName, length);
        printf("symOff0:%d\n",symOff);

        uint32_t elfSize = program->LoadSize();
        printf("elfSize:%d\n",elfSize);

        void * output = NULL;
        //uint32_t size = 0;
        output= (void*)malloc(elfSize);
        memset(output,'\0',elfSize);

        error = program->LoadExtract(output, elfSize);
        EXPECT_EQ(error, RT_ERROR_SEC_HANDLE);

        if(NULL != output)
        {
            free(output);
            output = NULL;
        }

        MOCKER(malloc).stubs().will(returnValue((void *)NULL));
        uint32_t kernelPos = program->kernelPos_;
        program->kernelPos_ = 1;
        Runtime *rt = ((Runtime *)Runtime::Instance());
        TilingTablForDavid *tilingTabForDavid = nullptr;
        rt->MacroInit(CHIP_DAVID);
        error = program->BuildTilingTblForDavid(mdl, &tilingTabForDavid, &kernelLen);
        EXPECT_EQ(error, RT_ERROR_PROGRAM_SIZE);
        program->kernelPos_ = kernelPos; 

        delete program;
}

TEST_F(ProgramTest, Program_Process_ELF_No_Kernel_For_David)
{
        rtError_t error;
        rtDevBinary_t binary;

        size_t MAX_LENGTH = 7186;
        FILE *bin = NULL;
        bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/no-kernel.o", "rb");
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

        binary.magic = RT_DEV_BINARY_MAGIC_ELF;
        binary.version = 0;
        binary.data = (void*)bindata;
        binary.length = MAX_LENGTH;

        Program* program = new ElfProgram();
        Module *mdl;
        TilingTablForDavid *tilingTab = nullptr;
        uint32_t kernelLen = 0;
        error = program->BuildTilingTblForDavid(mdl, &tilingTab, &kernelLen);
        EXPECT_EQ(error, RT_ERROR_PROGRAM_SIZE);

        error = program->Register(binary.data, binary.length);
        EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

        uint32_t elfMachine = program->Machine();
        printf("machine244:%d\n",elfMachine);

        char kernelName[] = "_Z15executor_conv2dPDhj";
        printf("kernelName:%s\n",kernelName);
        uint32_t length = 0;
        uint32_t symOff = program->SymbolOffset(kernelName, length);
        printf("symOff0:%d\n",symOff);

        uint32_t elfSize = program->LoadSize();
        printf("elfSize:%d\n",elfSize);

        void * output = NULL;
        output= (void*)malloc(elfSize);
        memset(output,'\0',elfSize);

        error = program->LoadExtract(output, elfSize);
        EXPECT_EQ(error, RT_ERROR_SEC_HANDLE);

        if(NULL != output)
        {
            free(output);
            output = NULL;
        }

        MOCKER(malloc).stubs().will(returnValue((void *)NULL));
        uint32_t kernelPos = program->kernelPos_;
        program->kernelPos_ = 1;
        Runtime *rt = ((Runtime *)Runtime::Instance());
        TilingTablForDavid *tilingTabForDavid = nullptr;
        rt->MacroInit(CHIP_DAVID);
        error = program->BuildTilingTblForDavid(mdl, &tilingTabForDavid, &kernelLen);
        EXPECT_EQ(error, RT_ERROR_PROGRAM_SIZE);
        program->kernelPos_ = kernelPos;

        delete program;
}

TEST_F(ProgramTest, Program_build_tiling_tbl_For_David)
{
        rtError_t error;
        Device * device = new RawDevice(0);
        Program* program = new ElfProgram();
        program->SetIsNewBinaryLoadFlow(false);
        program->kernelPos_ = 1;
        Module *mdl = new Module(device);
        program->KernelTable_ = new (std::nothrow) rtKernelArray_t[1U];
        int32_t fun1;
        Kernel * kernel2 = new Kernel(&fun1, "f1", "", program, 10);
        program->KernelTable_->kernel = kernel2;
 
        TilingTablForDavid *tilingTabForDavid2 = nullptr;
        uint32_t kernelLen2 = 0U;
        error = program->BuildTilingTblForDavid(mdl, &tilingTabForDavid2, &kernelLen2);
        EXPECT_EQ(kernelLen2, 1);
        EXPECT_EQ(error, RT_ERROR_NONE);
        free(tilingTabForDavid2);
 
        delete device;
        delete mdl;
        delete program;
}

TEST_F(ProgramTest, Program_Process_ELF_Output_Error)
{
        rtError_t error;
        rtDevBinary_t binary;

        size_t MAX_LENGTH = 6144;
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

        binary.magic = RT_DEV_BINARY_MAGIC_ELF;
        binary.version = 0;
        binary.data = (void*)bindata;
        binary.length = MAX_LENGTH;

        Program* program = new ElfProgram();
        error = program->Register(binary.data, binary.length);
        EXPECT_EQ(error, RT_ERROR_NONE);

        uint32_t elfMachine = program->Machine();
        printf("machine244:%d\n",elfMachine);

        const void * kernelName = "_Z15executor_conv2dPDhj";
        uint32_t length = 0;
        uint32_t symOff = program->SymbolOffset(kernelName, length);
        printf("symOff0:%d\n",symOff);

        uint32_t elfSize = program->LoadSize();
        printf("elfSize:%d\n",elfSize);

        void * output = NULL;
        //uint32_t size = 0;
        //output= (void*)malloc(elfSize);
        //memset(output,'\0',elfSize);

        error = program->LoadExtract(output, elfSize);
        EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
        if(NULL != output)
        {
            free(output);
            output = NULL;
        }

        delete program;
}

TEST_F(ProgramTest, Program_Process_ELF_Name_Error)
{
        rtError_t error;
        rtDevBinary_t binary;

        size_t MAX_LENGTH = 6144;
        FILE *bin = NULL;
        //bin = fopen("elf.o", "rb");
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

        binary.magic = RT_DEV_BINARY_MAGIC_ELF;
        binary.version = 0;
        binary.data = (void*)bindata;
        binary.length = MAX_LENGTH;

        Program* program = new ElfProgram();
        error = program->Register(binary.data, binary.length);
        EXPECT_EQ(error, RT_ERROR_NONE);

        uint32_t elfMachine = program->Machine();
        printf("machine244:%d\n",elfMachine);

        char kernelName[] = "onv";
        printf("kernelName:%s\n",kernelName);
        uint32_t length = 0U;
        uint32_t symOff = program->SymbolOffset(kernelName, length);
        printf("symOff:%d\n",symOff);

        delete program;
}

TEST_F(ProgramTest, Program_Process_ELF_LoadExtract_Error)
{
        rtError_t error;
        rtDevBinary_t binary;

        size_t MAX_LENGTH = 6144;
        FILE *bin = NULL;
        //bin = fopen("elf.o", "rb");
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

        binary.magic = RT_DEV_BINARY_MAGIC_ELF;
        binary.version = 0;
        binary.data = (void*)bindata;
        binary.length = MAX_LENGTH;

        Program* program = new ElfProgram();

        uint32_t elfSize = program->LoadSize();
        printf("elfSize:%d\n",elfSize);

        void * output = NULL;
        //uint32_t size = 0;
        output= (void*)malloc(elfSize);
        memset(output,'\0',elfSize);

        error = program->LoadExtract(output, elfSize);
        EXPECT_EQ(error, RT_ERROR_PROGRAM_DATA);

        if(NULL != output)
        {
            free(output);
            output = NULL;
        }

        delete program;
}

TEST_F(ProgramTest, Program_Process_ELF_Parser_Error)
{
        rtError_t error;
        rtDevBinary_t binary;

        size_t MAX_LENGTH = 6144;
        FILE *bin = NULL;
        //bin = fopen("elf.o", "rb");
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

        binary.magic = RT_DEV_BINARY_MAGIC_ELF;
        binary.version = 0;
        binary.data = (void*)bindata;
        binary.length = MAX_LENGTH;

        ElfProgram* program = new ElfProgram();

        delete program->elfData_;

        program->elfData_=NULL;

        error = program->Register(binary.data, binary.length);
        EXPECT_EQ(error, RT_ERROR_PROGRAM_DATA);

        delete program;
}

TEST_F(ProgramTest, Program_Process_ELF_SymbolOffset_Error)
{
        uint32_t error;
        rtDevBinary_t binary;

        size_t MAX_LENGTH = 6144;
        FILE *bin = NULL;
        //bin = fopen("elf.o", "rb");
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

        binary.magic = RT_DEV_BINARY_MAGIC_ELF;
        binary.version = 0;
        binary.data = (void*)bindata;
        binary.length = MAX_LENGTH;

        ElfProgram* program = new ElfProgram();

        delete program->elfData_;

        program->elfData_=NULL;
        char symbol[]="conv";
        uint32_t length = 0;
        error = program->SymbolOffset(symbol, length);
        EXPECT_EQ(error, 0);

        delete program;
}

TEST_F(ProgramTest, Program_Process_ELF_LoadSize_Error)
{
        uint32_t error;
        rtDevBinary_t binary;

        size_t MAX_LENGTH = 6144;
        FILE *bin = NULL;
        //bin = fopen("elf.o", "rb");
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

        binary.magic = RT_DEV_BINARY_MAGIC_ELF;
        binary.version = 0;
        binary.data = (void*)bindata;
        binary.length = MAX_LENGTH;

        ElfProgram* program = new ElfProgram();

        delete program->elfData_;

        program->elfData_=NULL;

        error = program->LoadSize();
        EXPECT_EQ(error, 0);

        delete program;
}

TEST_F(ProgramTest, Program_Process_ELF_hasMixKernel)
{
        rtError_t error;
        rtDevBinary_t binary;

        size_t MAX_LENGTH = 6144;
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

        binary.magic = RT_DEV_BINARY_MAGIC_ELF;
        binary.version = 0;
        binary.data = (void*)bindata;
        binary.length = MAX_LENGTH;

        Program* program = new ElfProgram();
        bool mixKernel = program->HasMixKernel();
        printf("mixKernel0 %d\n", mixKernel);
        EXPECT_EQ(mixKernel, false);
        error = program->Register(binary.data, binary.length);
        EXPECT_EQ(error, RT_ERROR_NONE);
        mixKernel = program->HasMixKernel();
        printf("mixKernel1 %d\n", mixKernel);
        EXPECT_EQ(mixKernel, false);

        delete program;
}

TEST_F(ProgramTest, LOAD_EXTRACT_TEST)
{
    size_t MAX_LENGTH = 6144;
    uint32_t error;
    uint32_t size = 100;
    FILE *bin = NULL;
    rtDevBinary_t binary;
    void *output = (char *)malloc(sizeof(char)*size);
    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o", "rb");
    if (bin == NULL)
    {
        printf("error\n");
        free(output);
        return;
    }

    char bindata[MAX_LENGTH];
    fread(bindata, sizeof(char), MAX_LENGTH, bin);

    binary.magic = RT_DEV_BINARY_MAGIC_ELF;
    binary.version = 0;
    binary.data = (void*)bindata;
    binary.length = MAX_LENGTH;

    PlainProgram* program = new PlainProgram(1);
    error = program->Register(binary.data, binary.length);

    error = program->LoadExtract(output, size);
    EXPECT_EQ(error, RT_ERROR_SEC_HANDLE);

    delete program;
    free(output);
}

TEST_F(ProgramTest, MIX_KERNEL_TEST_1)
{
    uint32_t error;
    uint64_t tilingValue = 0ULL;

    ElfProgram* program = new ElfProgram(1);
    Kernel *kernelPtr = new (std::nothrow) Kernel(nullptr, "abc", tilingValue, program, 0, 0, NO_MIX);

    EXPECT_NE(kernelPtr, nullptr);

    error = program->MixKernelAdd(kernelPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = program->MixKernelAdd(kernelPtr);
    EXPECT_EQ(error, RT_ERROR_KERNEL_DUPLICATE);

    const Kernel *getKernel = program->GetKernelByName("abc");
    EXPECT_NE(getKernel, nullptr);

    getKernel = program->GetKernelByName("abcd");
    EXPECT_EQ(getKernel, nullptr);

    delete program;
}

TEST_F(ProgramTest, KERNEL_CONTENT_FAIL)
{
    uint32_t error;
    uint64_t tilingValue = 0ULL;
    rtKernelContent info = {UINT32_MAX, 0, false, 0};
    ElfProgram* program = new ElfProgram();
    program->KernelContent(nullptr, &info);
    EXPECT_EQ(info.offset, UINT32_MAX);
    delete program->elfData_;
    program->elfData_ = nullptr;
    program->KernelContent(nullptr, &info);
    EXPECT_EQ(info.offset, 0U);
    program->KernelContent(nullptr, nullptr);

    delete program;
}

TEST_F(ProgramTest, KERNEL_CONTENT_TEST)
{
    uint32_t error;
    uint64_t tilingValue = 0ULL;
    rtKernelContent info = {UINT32_MAX, 0, false, 0};
    ElfProgram* program = new ElfProgram();
    char symbol[]="conv";
    const std::string opName ="conv";
    program->elfData_->kernel_num = 1U;
    program->kernels_ = new (std::nothrow) RtKernel[program->elfData_->kernel_num];
    program->kernels_->name = new char[10U];
    strcpy(program->kernels_->name, "conv");
    program->kernels_->length = 0U;
    program->kernels_->offset = 2U;
    program->kernels_->kernelVfType = 0U;
    program->kernels_->shareMemSize = 0U;
 
    program->KernelContent(symbol, &info);
    EXPECT_EQ(info.offset, 2U);
 
    delete program;
}

TEST_F(ProgramTest, CPU_KERNEL_REG)
{
    Context *const curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_NE(curCtx, nullptr);
    Driver *drv = curCtx->Device_()->Driver_();
    EXPECT_NE(drv, nullptr);
    MOCKER_CPP_VIRTUAL(drv, &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    rtStream_t stream;
    rtError_t error = rtStreamCreateWithFlags(&stream, 0, 8);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ElfProgram *program = new ElfProgram();
    EXPECT_NE(program, nullptr);
    program->SetKernelRegType(RT_KERNEL_REG_TYPE_CPU);

    std::vector<void *> allocatedMem;
    void *devMem= nullptr;
    allocatedMem.push_back(devMem);
    MOCKER_CPP_VIRTUAL(curCtx, &Context::StreamDestroy).stubs().will(returnValue(RT_ERROR_NONE));
    error = program->FreeCpuSoH2dMem(curCtx->Device_(), allocatedMem);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete program;
}