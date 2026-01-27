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
#define private public
#include "config.h"
#include "runtime.hpp"
#include "kernel.h"
#include "rt_error_codes.h"
#include "api_impl.hpp"
#include "dev.h"
#include "binary_loader.hpp"
#undef private
#include "utils.h"
#include <fstream>
#include <iostream>
#include <string>
#include <sstream>
#include <filesystem>
#include "thread_local_container.hpp"

using namespace testing;
using namespace cce::runtime;

static bool CreateFile(std::string &fileName, std::string content);
static void DeleteFile(std::string &fileName);

std::string binaryTxtFileName("llt/ace/npuruntime/runtime/ut/runtime/test/data/GatherV3_9e31943a1a48bf81ddff1fc6379e0be3_high_performance.txt");
std::string binaryFileName("llt/ace/npuruntime/runtime/ut/runtime/test/data/GatherV3_9e31943a1a48bf81ddff1fc6379e0be3_high_performance.o");

class BinaryLoaderTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();

        std::cout<<"BinaryLoaderTest test start start. disbale=%d. "<<rtInstance->GetDisableThread()<<std::endl;

        // Create GatherV3.o binary file 
        std::ifstream binaryTxtFile(binaryTxtFileName);
        if (!binaryTxtFile.is_open()) {
            std::cout << "Failed to open file: " << binaryTxtFileName << std::endl;
            return;
        }
        std::ofstream binaryFile(binaryFileName);
        if (!binaryFile.is_open()) {
            std::cout << "Failed to open file: " << binaryTxtFileName << std::endl;
            binaryTxtFile.close();
            return;
        }

        // read file to buffer
        std::stringstream txtBuffer;
        txtBuffer << binaryTxtFile.rdbuf();
        std::vector<char> charArray;
        std::string temp;

        // convert hex number to char
        while (std::getline(txtBuffer, temp, ',')) {
            if (temp.empty()) {
                continue;
            }
            binaryFile << static_cast<char>(std::stoi(temp, nullptr, 16));
        }
        binaryFile.close();
        binaryTxtFile.close();
    }

    static void TearDownTestCase()
    {
        std::cout<<"BinaryLoaderTest test start end. "<<std::endl;
        DeleteFile(binaryFileName);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
    }

    virtual void SetUp()
    {
        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
    };

    static bool CreateFile(std::string &fileName, std::string content)
    {
        std::ofstream file(fileName);
        if (!file.is_open()) {
            std::cout << "Failed to open file: " << fileName << std::endl;
            return false;
        }

        if (content.empty()) {
            file.close();
            std::cout << "Create empty file success, file name: " << fileName << std::endl;
            return true;
        }

        // 写入一些内容到文件
        file << content << std::endl;
        std::cout << "Create and write file success, file name: " << fileName << std::endl;
        file.close();
        return true;
    }

    static void DeleteFile(std::string &fileName)
    {
        std::remove(fileName.c_str());
    }
};

TEST_F(BinaryLoaderTest, TestUtilsReadPathEmpty)
{
    std::string path = "";
    std::string realPath = RealPath(path);
    EXPECT_EQ(realPath, "");
}

TEST_F(BinaryLoaderTest, TestUtilsReadPathLengthExceed)
{
    std::string path(PATH_MAX, 'A');
    std::string realPath = RealPath(path);
    EXPECT_EQ(realPath, "");
}

TEST_F(BinaryLoaderTest, TestUtilsReadPathNotExist)
{
    std::string path("test_no_exist");
    std::string realPath = RealPath(path);
    EXPECT_EQ(realPath, "");
}

TEST_F(BinaryLoaderTest, TestUtilsReadPathSuccess)
{
    std::string fileName("TestUtilsReadPathSuccess.txt");
    bool fileRet = CreateFile(fileName, "");
    EXPECT_EQ(fileRet, true);
    std::string realPath = RealPath(fileName);
    std::cout << "RealPath res: " << realPath << std::endl;

    DeleteFile(fileName);
}

TEST_F(BinaryLoaderTest, TestUtilsIsStringNumericSuccess)
{
    std::string str("012340000");
    bool ret = IsStringNumeric(str);
    EXPECT_EQ(ret, true);
}

TEST_F(BinaryLoaderTest, TestUtilsIsStringNumericFail)
{
    std::string str("012340A00");
    bool ret = IsStringNumeric(str);
    EXPECT_EQ(ret, false);
}

TEST_F(BinaryLoaderTest, TestLoadFromDataWithMetainfoError)
{
    BinaryLoader binaryLoader(nullptr, 0, nullptr);

    MOCKER_CPP(&Program::Register).stubs().will(returnValue(RT_ERROR_NONE));
    Program * prg = binaryLoader.LoadFromData();
    EXPECT_EQ(prg, nullptr);
}

TEST_F(BinaryLoaderTest, TestRtsBinaryLoadFromData_CpuKernel_Success)
{
    rtLoadBinaryConfig_t cfg;
    rtLoadBinaryOption_t option;
    option.optionId = RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE;
    option.value.cpuKernelMode = 2;
    cfg.numOpt = 1;
    cfg.options = &option;
    uint64_t data = 1024U;;
    BinaryLoader binaryLoader(static_cast<void *>(&data), sizeof(uint64_t), &cfg);
    Program *prog = nullptr;
    rtError_t ret = binaryLoader.Load(&prog);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    Context *ctx = Runtime::Instance()->CurrentContext();
    EXPECT_NE(ctx, nullptr);
    uint32_t devId = ctx->Device_()->Id_();
    ret = prog->ProcCpuKernelH2DMem(false, ctx->Device_());
    ret = rtsBinaryUnload(prog);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(BinaryLoaderTest, BinaryLoadSuccess)
{
    std::filesystem::path  currentPath = std::filesystem::current_path().parent_path();
    std::string path = currentPath.string() + "/tests/ut/runtime/runtime/test/data/libcust_aicpu_kernels.json";
    rtLoadBinaryConfig_t cfg;
    rtLoadBinaryOption_t option;
    option.optionId = RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE;
    option.value.cpuKernelMode = 0;
    cfg.numOpt = 1;
    cfg.options = &option;
    void *handle = nullptr;
    rtError_t error = rtsBinaryLoadFromFile(path.c_str(), &cfg, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtFuncHandle func;
    error = rtsFuncGetByName(handle, "ReshapeCust", &func);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtKernelLaunchCfg_t kennelCfg;
    rtLaunchKernelAttr_t attrs[7];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE;
    attrs[0].value.schemMode = 0;
    attrs[1].id = RT_LAUNCH_KERNEL_ATTR_LOCAL_MEM_SIZE;
    attrs[1].value.localMemorySize = 100;
    attrs[2].id = RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE;
    attrs[2].value.engineType = RT_ENGINE_TYPE_AIV;
    attrs[3].id = RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET;
    attrs[3].value.blockDimOffset = 10;
    attrs[4].id = RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH;
    attrs[4].value.isBlockTaskPrefetch = 1U;
    attrs[5].id = RT_LAUNCH_KERNEL_ATTR_DATA_DUMP;
    attrs[5].value.isDataDump = 1U;
    attrs[6].id = RT_LAUNCH_KERNEL_ATTR_TIMEOUT;
    attrs[6].value.isDataDump = 10U;

    kennelCfg.attrs = attrs;
    kennelCfg.numAttrs = 6;

    void *argsHandle;
    error = rtsKernelArgsInit(func, &argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(argsHandle, nullptr);

    error = rtsLaunchKernelWithConfig(func, 1, nullptr, &kennelCfg, argsHandle, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    void *result = nullptr;
    error = rtGetBinaryDeviceBaseAddr(handle, &result);
    EXPECT_EQ(error, ACL_ERROR_RT_INTERNAL_ERROR);

    error = rtsBinaryUnload(handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(BinaryLoaderTest, BinaryLoadAndSetProgramInvalid)
{
    std::filesystem::path  currentPath = std::filesystem::current_path().parent_path();
    std::string path = currentPath.string() + "/tests/ut/runtime/runtime/test/data/libcust_aicpu_kernels.json";
    rtLoadBinaryConfig_t cfg;
    rtLoadBinaryOption_t option;
    option.optionId = RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE;
    option.value.cpuKernelMode = 0;
    cfg.numOpt = 1;
    cfg.options = &option;
    void *proghandle = nullptr;
    rtError_t error = rtsBinaryLoadFromFile(path.c_str(), &cfg, &proghandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtFuncHandle func;
    error = rtsFuncGetByName(proghandle, "ReshapeCust", &func);
    EXPECT_EQ(error, RT_ERROR_NONE);

    void *argsHandle;
    error = rtsKernelArgsInit(func, &argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(argsHandle, nullptr);

    RtArgsHandle *handle = (RtArgsHandle *)argsHandle;
    EXPECT_NE(handle->buffer, nullptr);
    EXPECT_NE(handle->bufferSize, 0);
    uint32_t param1 = 1002;
    void *paramHandle = nullptr;
    error = rtsKernelArgsAppend(argsHandle, &param1, sizeof(uint32_t), &paramHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ParaDetail *pHandle = (ParaDetail *)paramHandle;
    uint32_t *addr1 = reinterpret_cast<uint32_t *>(reinterpret_cast<uintptr_t>(handle->buffer) + static_cast<uint64_t>(pHandle->paraOffset));
    EXPECT_EQ(*addr1, param1);
    error = rtsKernelArgsFinalize(argsHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t test1 = 1001;
    ParaDetail tmpPhandle = {};
    tmpPhandle.type = 1;
    tmpPhandle.paraSize = sizeof(uint64_t);
    error = rtsKernelArgsParaUpdate(argsHandle, &tmpPhandle, &test1, sizeof(uint32_t));
    EXPECT_NE(error, RT_ERROR_NONE);

    uint32_t test2 = 1001;
    tmpPhandle.type = 0;
    tmpPhandle.paraSize = sizeof(uint64_t);
    error = rtsKernelArgsParaUpdate(argsHandle, &tmpPhandle, &test2, sizeof(uint32_t));
    EXPECT_NE(error, RT_ERROR_NONE);

    rtKernelLaunchCfg_t kennelCfg;
    rtLaunchKernelAttr_t attrs[7];
    attrs[0].id = RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE;
    attrs[0].value.schemMode = 0;
    attrs[1].id = RT_LAUNCH_KERNEL_ATTR_LOCAL_MEM_SIZE;
    attrs[1].value.localMemorySize = 100;
    attrs[2].id = RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE;
    attrs[2].value.engineType = RT_ENGINE_TYPE_AIV;
    attrs[3].id = RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET;
    attrs[3].value.blockDimOffset = 10;
    attrs[4].id = RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH;
    attrs[4].value.isBlockTaskPrefetch = 1U;
    attrs[5].id = RT_LAUNCH_KERNEL_ATTR_DATA_DUMP;
    attrs[5].value.isDataDump = 1U;
    attrs[6].id = RT_LAUNCH_KERNEL_ATTR_TIMEOUT;
    attrs[6].value.isDataDump = 10U;

    kennelCfg.attrs = attrs;
    kennelCfg.numAttrs = 6;

    Context *ctx = Runtime::Instance()->CurrentContext();
    EXPECT_NE(ctx, nullptr);
    Program * prog = reinterpret_cast<Program *>(proghandle);
    uint32_t devId = ctx->Device_()->Id_();
    prog->SetDeviceSoAndNameInvalid(devId);
    error = rtsLaunchKernelWithConfig(func, 1, nullptr, &kennelCfg, argsHandle, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_INVALID_HANDLE);

    error = rtsBinaryUnload(proghandle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}


TEST_F(BinaryLoaderTest, TestRtsBinaryLoadFromFile_CpuKernel_JsonAndSo)
{
    char *path = "../tests/ut/runtime/runtime/test/data/libcust_aicpu_kernels.json";
    rtLoadBinaryConfig_t cfg;
    rtLoadBinaryOption_t option;
    option.optionId = RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE;
    option.value.cpuKernelMode = 1;
    cfg.numOpt = 1;
    cfg.options = &option;
    void *handle = nullptr;
    rtError_t error = rtsBinaryLoadFromFile(path, &cfg, &handle);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(BinaryLoaderTest, TestRtsBinaryLoadFromFile_CpuKernel_Mode1_Fail_01)
{
    char *path = "../tests/ut/runtime/runtime/test/data/libcust_aicpu_kernels.json";
    MOCKER_CPP(&BinaryLoader::ReadBinaryFile).stubs().will(returnValue(RT_ERROR_NONE));
    PlainProgram * prog = nullptr;
    MOCKER_CPP(&BinaryLoader::ParseJsonAndRegisterCpuKernel).stubs().will(returnValue(prog));

    rtLoadBinaryConfig_t cfg;
    rtLoadBinaryOption_t option;
    option.optionId = RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE;
    option.value.cpuKernelMode = 1;
    cfg.numOpt = 1;
    cfg.options = &option;

    void *handle = nullptr;
    rtError_t ret = rtsBinaryLoadFromFile(path, &cfg, &handle);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(BinaryLoaderTest, TestRtsBinaryLoadFromFile_CpuKernel_Mode1_Fail_02)
{
    char *path = "../tests/ut/runtime/runtime/test/data/libcust_aicpu_kernels.json";
    MOCKER_CPP(&BinaryLoader::ReadBinaryFile).stubs().will(returnValue(RT_ERROR_NONE));
    PlainProgram * prog = nullptr;
    MOCKER_CPP(&Program::ProcCpuKernelH2DMem).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    rtLoadBinaryConfig_t cfg;
    rtLoadBinaryOption_t option;
    option.optionId = RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE;
    option.value.cpuKernelMode = 1;
    cfg.numOpt = 1;
    cfg.options = &option;

    void *handle = nullptr;
    rtError_t ret = rtsBinaryLoadFromFile(path, &cfg, &handle);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtsBinaryUnload(handle);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(BinaryLoaderTest, TestRtsBinaryLoadFromFile_CpuKernel_Mode0_Fail_01)
{
    char *path = "../tests/ut/runtime/runtime/test/data/libcust_aicpu_kernels.json";
    MOCKER_CPP(&BinaryLoader::ReadBinaryFile).stubs().will(returnValue(RT_ERROR_NONE));
    PlainProgram * prog = nullptr;
    MOCKER_CPP(&BinaryLoader::ParseJsonAndRegisterCpuKernel).stubs().will(returnValue(prog));

    rtLoadBinaryConfig_t cfg;
    rtLoadBinaryOption_t option;
    option.optionId = RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE;
    option.value.cpuKernelMode = 0;
    cfg.numOpt = 1;
    cfg.options = &option;

    void *handle = nullptr;
    rtError_t ret = rtsBinaryLoadFromFile(path, &cfg, &handle);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(BinaryLoaderTest, TestRtsBinaryLoad_CpuKernel_InvalidMode)
{
    char *path = "../tests/ut/runtime/runtime/test/data/libcust_aicpu_kernels.json";
    rtLoadBinaryConfig_t cfg;
    rtLoadBinaryOption_t option;
    option.optionId = RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE;
    option.value.cpuKernelMode = 3;
    cfg.numOpt = 1;
    cfg.options = &option;
    void *handle = nullptr;
    rtError_t error = rtsBinaryLoadFromFile(path, &cfg, &handle);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(BinaryLoaderTest, TestRtsBinaryLoad_CpuKernel_ParseJsonAndRegisterCpuKernel_01)
{
    BinaryLoader binaryLoader("", nullptr);
    PlainProgram *prog = binaryLoader.ParseJsonAndRegisterCpuKernel();
    EXPECT_EQ(prog, nullptr);
}

TEST_F(BinaryLoaderTest, TestRtsBinaryLoad_CpuKernel_ParseJsonAndRegisterCpuKernel_02)
{
    char *path = "../tests/ut/runtime/runtime/test/data/libcust_aicpu_kernels.json";
    MOCKER_CPP(&Program::RegisterCpuKernel).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    BinaryLoader binaryLoader(path, nullptr);
    PlainProgram *prog = binaryLoader.ParseJsonAndRegisterCpuKernel();
    EXPECT_EQ(prog, nullptr);
}

TEST_F(BinaryLoaderTest, TestRtsBinaryLoad_CpuKernel_ArgsUserByMem)
{
    PlainProgram prog;
    prog.SetKernelRegType(RT_KERNEL_REG_TYPE_CPU);
    prog.SetSoName("libcust_aicpu_kernels.so");
    rtFuncHandle funcHandle = nullptr;
    rtError_t error = rtsRegisterCpuFunc(&prog, "RunCpuKernel", "Abs", &funcHandle);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtFuncHandle funcHandle1 = nullptr;
    error = rtsRegisterCpuFunc(&prog, "RunCpuKernel", "Abs", &funcHandle1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    size_t memSize = 0U;
    error = rtsKernelArgsGetHandleMemSize(funcHandle, &memSize);
    EXPECT_EQ(error, RT_ERROR_NONE);

    size_t actualArgsSize = 0U;
    error = rtsKernelArgsGetMemSize(funcHandle, 30, &actualArgsSize);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint8_t *userHostMem = new (std::nothrow) uint8_t[actualArgsSize];
    uint8_t *argsHandle = new (std::nothrow) uint8_t[memSize];
    error = rtsKernelArgsInitByUserMem(funcHandle, argsHandle, userHostMem, actualArgsSize);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete [] argsHandle;
    delete [] userHostMem;
}

TEST_F(BinaryLoaderTest, TestLoadFromFileWithParseKernelJsonFileError)
{
    std::string file = "TestFileNotExist";
    MOCKER_CPP(&BinaryLoader::ReadBinaryFile).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Program::Register).stubs().will(returnValue(RT_ERROR_NONE));

    BinaryLoader binaryLoader(file.c_str(), nullptr);
    Program *prog = binaryLoader.LoadFromFile();
    EXPECT_EQ(prog, nullptr);
    delete prog;
}

TEST_F(BinaryLoaderTest, TestLoadFromFileWithNoMagicInfoError)
{
    std::string file = "llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o";

    BinaryLoader binaryLoader(file.c_str(), nullptr);
    Program *prog;
    rtError_t ret = binaryLoader.Load(&prog);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    delete prog;
}


TEST_F(BinaryLoaderTest, TestLoadFromFileWithMagicInfoError)
{
    std::string file = "llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o";
    std::string jsonFile = "llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.json";
    std::string content = "{\"binFileName\":\"test_kernel\",\"binFileSuffix\":\".o\",\"blockDim\":40,\"coreType\":\"VectorCore\",\"deterministic\":\"ignore\",\"intercoreSync\":0,\"kernelName\":\"test_kernel\",\"magic\":\"RT_DEV_BINARY_MAGIC_ELF_AIVEC_INVALID\",\"memoryStamping\":[],\"opParaSize\":0,\"parameters\":[null,null],\"sha256\":\"23673556afa3860402a84eda043f19ffbd350a39a08ac94635dbbfeb35a2024d\"}";
    CreateFile(jsonFile, content);
    BinaryLoader binaryLoader(file.c_str(), nullptr);
    Program *prog;
    rtError_t ret = binaryLoader.Load(&prog);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    delete prog;
    DeleteFile(jsonFile);
}

TEST_F(BinaryLoaderTest, TestLoadFromFileWithJsonFileInvalid)
{
    std::string file = "llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o";
    std::string jsonFile = "llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.json";
    std::string content = "error 123 test for error\"binFileName\":\"test_kernel\",\"binFileSuffix\":\".o\",\"blockDim\":40,\"coreType\":\"VectorCore\",\"deterministic\":\"ignore\",\"intercoreSync\":0,\"kernelName\":\"test_kernel\",\"magic\":\"RT_DEV_BINARY_MAGIC_ELF_AIVEC_INVALID\",\"memoryStamping\":[],\"opParaSize\":0,\"parameters\":[null,null],\"sha256\":\"23673556afa3860402a84eda043f19ffbd350a39a08ac94635dbbfeb35a2024d\"}";
    CreateFile(jsonFile, content);
    BinaryLoader binaryLoader(file.c_str(), nullptr);
    Program *prog;
    rtError_t ret = binaryLoader.Load(&prog);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    delete prog;
    DeleteFile(jsonFile);
}

TEST_F(BinaryLoaderTest, TestLoadFromFileWithNoMagicError)
{
    std::string file = "llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o";
    std::string jsonFile = "llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.json";
    std::string content = "{\"binFileName\":\"test_kernel\",\"binFileSuffix\":\".o\",\"blockDim\":40,\"coreType\":\"VectorCore\",\"deterministic\":\"ignore\",\"intercoreSync\":0,\"kernelName\":\"test_kernel\",\"magic_error\":\"RT_DEV_BINARY_MAGIC_ELF_AIVEC_INVALID\",\"memoryStamping\":[],\"opParaSize\":0,\"parameters\":[null,null],\"sha256\":\"23673556afa3860402a84eda043f19ffbd350a39a08ac94635dbbfeb35a2024d\"}";
    CreateFile(jsonFile, content);
    BinaryLoader binaryLoader(file.c_str(), nullptr);
    Program *prog;
    rtError_t ret = binaryLoader.Load(&prog);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    delete prog;
    DeleteFile(jsonFile);
}


TEST_F(BinaryLoaderTest, TestLoadFromFileWithNoPrintfError)
{
    std::string file = "llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o";
    std::string jsonFile = "llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.json";
    std::string content = "{\"binFileName\":\"test_kernel\",\"binFileSuffix\":\".o\",\"blockDim\":40,\"coreType\":\"VectorCore\",\"deterministic\":\"ignore\",\"intercoreSync\":0,\"kernelName\":\"test_kernel\",\"magic\":\"RT_DEV_BINARY_MAGIC_ELF_AIVEC_INVALID\",\"memoryStamping\":[],\"opParaSize\":0,\"parameters\":[null,null],\"debugOptions\":\"printf\",\"sha256\":\"23673556afa3860402a84eda043f19ffbd350a39a08ac94635dbbfeb35a2024d\"}";
    CreateFile(jsonFile, content);
    BinaryLoader binaryLoader(file.c_str(), nullptr);
    Program *prog;
    rtError_t ret = binaryLoader.Load(&prog);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    delete prog;
    DeleteFile(jsonFile);
}

TEST_F(BinaryLoaderTest, TestParseKernelJsonFile)
{
    std::string file = "file_not_exist";
    BinaryLoader binaryLoader(file.c_str(), nullptr);
    ElfProgram program;
    program.elfData_->containsAscendMeta = true;
    program.isSupportMix_ = true;
    rtError_t ret = binaryLoader.ParseKernelJsonFile(&program);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(BinaryLoaderTest, TestCheckLoaded2DeviceSuccess)
{
    MOCKER_CPP(&Runtime::BinaryLoad).stubs().will(returnValue(RT_ERROR_NONE));
    ElfProgram program(Program::MACH_AI_MIX_KERNEL);
    program.SetIsLazyLoad(true);
    rtError_t ret = program.CheckLoaded2Device();
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(BinaryLoaderTest, TestCheckLoaded2DeviceFailed)
{
    MOCKER_CPP(&Runtime::BinaryLoad).stubs().will(returnValue(RT_ERROR_PROGRAM_SIZE));
    ElfProgram program(Program::MACH_AI_MIX_KERNEL);
    program.SetIsLazyLoad(true);
    rtError_t ret = program.CheckLoaded2Device();
    EXPECT_EQ(ret, RT_ERROR_PROGRAM_SIZE);
}

TEST_F(BinaryLoaderTest, TestAdjustKernelNameAndGetMixType)
{
    RtKernel kernel;
    uint8_t mixType = 0;
    ElfProgram program;

    char *name = "test_kernel_mix_aiv_00001";
    kernel.name = "test_kernel_mix_aiv_00001";
    std::string kernelName = program.AdjustKernelNameAndGetMixType(&kernel, mixType);
    EXPECT_EQ(kernelName, "test_kernel_00001");
    EXPECT_EQ(mixType, MIX_AIV);

    kernel.name = "test_kernel_mix_aic_00001";
    kernelName = program.AdjustKernelNameAndGetMixType(&kernel, mixType);
    EXPECT_EQ(kernelName, "test_kernel_00001");
    EXPECT_EQ(mixType, MIX_AIC);

    kernel.name = "test_kernel_mix_aic_mix_aiv_00001";
    kernelName = program.AdjustKernelNameAndGetMixType(&kernel, mixType);
    EXPECT_EQ(kernelName, "test_kernel_00001");
    EXPECT_EQ(mixType, MIX_AIC_AIV_MAIN_AIC);
}

TEST_F(BinaryLoaderTest, TestLoadFromDataWithMixKernelNotFound)
{
    ElfProgram prog;
    Kernel * k1 = new Kernel(nullptr, "f1", "", &prog, 10);
    rtError_t ret = prog.MixKernelRemove(k1);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete k1;
}


TEST_F(BinaryLoaderTest, TestFindAndProcMixKernelV1)
{
    ElfProgram prog;
    Kernel kernelAicObj(nullptr, "testKernelName", 1, &prog, 2048, 0, 0, 0, 0);
    Kernel *kernelAicPtr = &kernelAicObj;
    rtError_t ret = prog.MixKernelAdd(kernelAicPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    RtKernel kernelAiv;
    uint32_t procVersion = 1;
    bool mixRet = prog.FindAndProcMixKernel(&kernelAiv, "testKernelName", 1, procVersion);
    EXPECT_EQ(mixRet, true);

    ret = prog.MixKernelRemove(kernelAicPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(BinaryLoaderTest, TestFindAndProcMixKernelWithConflict)
{
    ElfProgram prog;
    Kernel kernelAicObj(nullptr, "testKernelName", 1, &prog, 2048, 1024, 0, 0, 0);
    Kernel *kernelAicPtr = &kernelAicObj;
    rtError_t ret = prog.MixKernelAdd(kernelAicPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    RtKernel kernelAiv;
    uint32_t procVersion = 1;
    bool mixRet = prog.FindAndProcMixKernel(&kernelAiv, "testKernelName", 1, procVersion);
    EXPECT_EQ(mixRet, false);

    ret = prog.MixKernelRemove(kernelAicPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(BinaryLoaderTest, TestFindAndProcMixKernelAndAjustOffset1Offset2)
{
    ElfProgram prog;
    Kernel kernelAivObj(nullptr, "testKernelName", 1, &prog, 2048, 0, 2, 0, 0);
    Kernel *kernelAivPtr = &kernelAivObj;
    rtError_t ret = prog.MixKernelAdd(kernelAivPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    RtKernel kernelAic;
    kernelAic.offset = 1024;
    uint32_t procVersion = 1;
    bool mixRet = prog.FindAndProcMixKernel(&kernelAic, "testKernelName", 1, procVersion);
    EXPECT_EQ(mixRet, true);
    EXPECT_EQ(kernelAivObj.Offset_(), 1024);
    EXPECT_EQ(kernelAivObj.Offset2_(), 2048);

    ret = prog.MixKernelRemove(kernelAivPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(BinaryLoaderTest, TestFindAndProcMixKernelV2)
{
    ElfProgram prog;
    Kernel kernelAicObj(nullptr, "testKernelName", 1, &prog, 2048, 0, 0, 0, 0);
    Kernel *kernelAicPtr = &kernelAicObj;
    rtError_t ret = prog.MixKernelAdd(kernelAicPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    RtKernel kernelAiv;
    uint32_t procVersion = 2;
    bool mixRet = prog.FindAndProcMixKernel(&kernelAiv, "testKernelName", 1, procVersion);
    EXPECT_EQ(mixRet, true);

    ret = prog.MixKernelRemove(kernelAicPtr);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(BinaryLoaderTest, TestDegenerateMixType)
{
    ElfProgram prog;
    uint8_t mixType = MIX_AIC;
    prog.elfData_->degenerateFlag = true;
    prog.DegenerateMixType(mixType);
    EXPECT_EQ(NO_MIX, mixType);
}

TEST_F(BinaryLoaderTest, TestFuncGetAddrWithOnlyAiv)
{
    ElfProgram prog;
    Kernel kernelAicObj(nullptr, "testKernelName", 1, &prog, 2048, 0, 0, 0, 0);
    prog.SetMachine(Program::MACH_AI_VECTOR);

    void *aicAddr;
    void *aivAddr;
    rtsFuncGetAddr(&kernelAicObj, &aicAddr, &aivAddr);
    EXPECT_EQ(aicAddr, nullptr);
    EXPECT_NE(aivAddr, nullptr);
}

TEST_F(BinaryLoaderTest, TestFuncGetAddrWithOnlyAivWithKernelType)
{
    ElfProgram prog;
    Kernel kernelObj(nullptr, "testKernelName", 1, &prog, 2048, 0, 0, 0, 0);
    prog.SetMachine(Program::MACH_AI_MIX_KERNEL);
    kernelObj.SetKernelType_(Program::MACH_AI_VECTOR);

    void *aicAddr;
    void *aivAddr;
    rtsFuncGetAddr(&kernelObj, &aicAddr, &aivAddr);
    EXPECT_EQ(aicAddr, nullptr);
    EXPECT_NE(aivAddr, nullptr);
}

TEST_F(BinaryLoaderTest, TestFuncGetAddrWithMixOnlyAiv)
{
    ElfProgram prog;
    Kernel kernelObj(nullptr, "testKernelName", 1, &prog, 2048, 0, 0, 0, 0);
    prog.SetMachine(Program::MACH_AI_CORE);
    kernelObj.SetMixType(MIX_AIV);

    void *aicAddr;
    void *aivAddr;
    rtsFuncGetAddr(&kernelObj, &aicAddr, &aivAddr);
    EXPECT_EQ(aicAddr, nullptr);
    EXPECT_NE(aivAddr, nullptr);
}

TEST_F(BinaryLoaderTest, TestLoadFromData)
{
    BinaryLoader binaryLoader(nullptr, 0, nullptr);

    MOCKER_CPP(&Program::Register).stubs().will(returnValue(RT_ERROR_NONE));
    binaryLoader.magic_ = RT_DEV_BINARY_MAGIC_ELF;
    Program * prg = binaryLoader.LoadFromData();
    EXPECT_NE(prg, nullptr);
    delete(prg);
}

TEST_F(BinaryLoaderTest, TestAdaptKernelAttrType)
{
    ElfProgram program;
    uint64_t tilingKey = 0;
    Kernel kernel(nullptr, "testKernelName", tilingKey, &program, 2048, 1024, 0, 0, 0);

    RtKernel kernelInput;
    kernelInput.name = "test_mix_aic";
    program.AdaptKernelAttrType(&kernelInput, &kernel);
    EXPECT_EQ(kernel.GetKernelAttrType(), RT_KERNEL_ATTR_TYPE_CUBE);

    kernelInput.name = "test_mix_aiv";
    program.AdaptKernelAttrType(&kernelInput, &kernel);
    EXPECT_EQ(kernel.GetKernelAttrType(), RT_KERNEL_ATTR_TYPE_VECTOR);

    program.elfData_->containsAscendMeta = true;
    kernelInput.name = "test_kernel";
    kernelInput.funcType = KERNEL_FUNCTION_TYPE_AICORE;
    program.AdaptKernelAttrType(&kernelInput, &kernel);
    EXPECT_EQ(kernel.GetKernelAttrType(), RT_KERNEL_ATTR_TYPE_AICORE);

    kernelInput.funcType = KERNEL_FUNCTION_TYPE_AIC;
    program.AdaptKernelAttrType(&kernelInput, &kernel);
    EXPECT_EQ(kernel.GetKernelAttrType(), RT_KERNEL_ATTR_TYPE_CUBE);

    kernelInput.funcType = KERNEL_FUNCTION_TYPE_AIV;
    program.AdaptKernelAttrType(&kernelInput, &kernel);
    EXPECT_EQ(kernel.GetKernelAttrType(), RT_KERNEL_ATTR_TYPE_VECTOR);

    program.elfData_->containsAscendMeta = false;
    program.SetElfMagic(RT_DEV_BINARY_MAGIC_ELF);
    program.AdaptKernelAttrType(&kernelInput, &kernel);
    EXPECT_EQ(kernel.GetKernelAttrType(), RT_KERNEL_ATTR_TYPE_AICORE);

    program.SetElfMagic(RT_DEV_BINARY_MAGIC_ELF_AICUBE);
    program.AdaptKernelAttrType(&kernelInput, &kernel);
    EXPECT_EQ(kernel.GetKernelAttrType(), RT_KERNEL_ATTR_TYPE_CUBE);

    program.SetElfMagic(RT_DEV_BINARY_MAGIC_ELF_AIVEC);
    program.AdaptKernelAttrType(&kernelInput, &kernel);
    EXPECT_EQ(kernel.GetKernelAttrType(), RT_KERNEL_ATTR_TYPE_VECTOR);
}
