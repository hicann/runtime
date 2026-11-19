/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "common/enum_log.hpp"
#include "task_enum_desc.hpp"
#include <array>
#include <memory>
#include <string>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "runtime/base.h"
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "runtime.hpp"
#include "program.hpp"
#include "device.hpp"
#include "module.hpp"
#include "context.hpp"
#include "raw_device.hpp"

void ClearLastDlogRecordLine();
bool DlogRecordContains(const std::string& keyword);

using namespace testing;
using namespace cce::runtime;

namespace {
constexpr uint32_t AICORE_END_INSTRUCTION_FOR_TEST = 0x41600000U;
constexpr uint32_t AICORE_BREAK_INSTRUCTION_FOR_TEST = 0x41800000U;
constexpr uint32_t AICORE_OTHER_INSTRUCTION_FOR_TEST = 0x12345678U;

struct BinaryCopyCapture {
    uint64_t devMemAllocFlag = 0U;
    uint64_t size = 0U;
    uint32_t callCount = 0U;
    uint32_t firstInstruction = 0U;
    rtMemcpyKind_t kind = RT_MEMCPY_HOST_TO_HOST;
};

static BinaryCopyCapture g_binaryCopyCapture;

class AiCoreTaskSyncCheckStateGuard {
public:
    AiCoreTaskSyncCheckStateGuard(Device* const device, const bool enabled)
        : device_(device), originalEnabled_(device->IsAiCoreTaskSyncCheckEnabled())
    {
        device_->SetAiCoreTaskSyncCheckEnabled(enabled);
    }

    ~AiCoreTaskSyncCheckStateGuard() { device_->SetAiCoreTaskSyncCheckEnabled(originalEnabled_); }

private:
    Device* const device_;
    const bool originalEnabled_;
};

static rtError_t DevMemAllocFlagCaptureStub(
    Driver* const driver, void** const dptr, const uint64_t size, const rtMemType_t type, const uint32_t deviceId,
    const DevMemAllocConfig* const config, const uint64_t curFlag)
{
    UNUSED(driver);
    UNUSED(size);
    UNUSED(type);
    UNUSED(deviceId);
    UNUSED(config);
    g_binaryCopyCapture.devMemAllocFlag = curFlag;
    *dptr = reinterpret_cast<void*>(0x1000U);
    return RT_ERROR_NONE;
}

static rtError_t BinaryMemCopyCaptureStub(
    Driver* const driver, void* const dst, const uint64_t destMax, const void* const src, const uint64_t size,
    const rtMemcpyKind_t kind)
{
    UNUSED(driver);
    UNUSED(dst);
    UNUSED(destMax);
    ++g_binaryCopyCapture.callCount;
    g_binaryCopyCapture.size = size;
    g_binaryCopyCapture.kind = kind;
    if ((src != nullptr) && (size >= sizeof(g_binaryCopyCapture.firstInstruction))) {
        (void)memcpy_s(
            &g_binaryCopyCapture.firstInstruction, sizeof(g_binaryCopyCapture.firstInstruction), src,
            sizeof(g_binaryCopyCapture.firstInstruction));
    }
    return RT_ERROR_NONE;
}
} // namespace

class ProgramTest : public testing::Test {
protected:
    static void SetUpTestCase() { std::cout << "program test start" << std::endl; }

    static void TearDownTestCase() { std::cout << "program test end" << std::endl; }

    virtual void SetUp() { rtSetDevice(0); }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
};

TEST_F(ProgramTest, ModuleLoadCopiesPatchedBinaryAndPreservesSourceForAiCoreTaskSyncCheck)
{
    Context* ctx = Runtime::Instance()->CurrentContext();
    ASSERT_NE(ctx, nullptr);
    Device* device = ctx->Device_();
    ASSERT_NE(device, nullptr);
    AiCoreTaskSyncCheckStateGuard syncCheckGuard(device, true);
    Runtime* rtInstance = const_cast<Runtime*>(Runtime::Instance());
    const rtChipType_t originRtChipType = rtInstance->GetChipType();
    const rtChipType_t originDevChipType = device->GetChipType();
    rtInstance->SetChipType(CHIP_MINI);
    device->SetChipType(CHIP_MINI);

    uint32_t binary[] = {AICORE_END_INSTRUCTION_FOR_TEST};
    PlainProgram prog(RT_KERNEL_ATTR_TYPE_AICORE);
    prog.binary_ = binary;
    prog.binarySize_ = sizeof(binary);
    g_binaryCopyCapture = {};
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAllocWithFlag)
        .expects(once())
        .with(
            mockcpp::any(), mockcpp::any(), eq(RT_MEMORY_HBM), eq(static_cast<uint32_t>(device->Id_())), mockcpp::any(),
            mockcpp::any())
        .will(invoke(DevMemAllocFlagCaptureStub));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).expects(once()).will(invoke(BinaryMemCopyCaptureStub));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));

    {
        Module module(device);
        EXPECT_EQ(module.Load(&prog), RT_ERROR_NONE);
    }

    EXPECT_NE(g_binaryCopyCapture.devMemAllocFlag & static_cast<uint64_t>(MEM_SNAPSHOT_REQUIRED), 0U);
    EXPECT_EQ(g_binaryCopyCapture.callCount, 1U);
    EXPECT_EQ(g_binaryCopyCapture.size, sizeof(binary));
    EXPECT_EQ(g_binaryCopyCapture.kind, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(g_binaryCopyCapture.firstInstruction, AICORE_BREAK_INSTRUCTION_FOR_TEST);
    EXPECT_EQ(binary[0], AICORE_END_INSTRUCTION_FOR_TEST);
    prog.SetBinBaseAddr(nullptr, device->Id_());
    prog.SetBinAlignBaseAddr(nullptr, device->Id_());
    rtInstance->SetChipType(originRtChipType);
    device->SetChipType(originDevChipType);
}

TEST_F(ProgramTest, RuntimeBinaryLoadCopiesPatchedBinaryAndPreservesSourceForAiCoreTaskSyncCheck)
{
    Context* ctx = Runtime::Instance()->CurrentContext();
    ASSERT_NE(ctx, nullptr);
    Device* device = ctx->Device_();
    ASSERT_NE(device, nullptr);
    AiCoreTaskSyncCheckStateGuard syncCheckGuard(device, true);
    Runtime* rtInstance = const_cast<Runtime*>(Runtime::Instance());
    const rtChipType_t originRtChipType = rtInstance->GetChipType();
    const rtChipType_t originDevChipType = device->GetChipType();
    rtInstance->SetChipType(CHIP_MINI);
    device->SetChipType(CHIP_MINI);

    uint32_t binary[] = {AICORE_END_INSTRUCTION_FOR_TEST};
    PlainProgram prog(RT_KERNEL_ATTR_TYPE_AICORE);
    prog.binary_ = binary;
    prog.binarySize_ = sizeof(binary);

    g_binaryCopyCapture = {};
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAllocWithFlag)
        .expects(once())
        .with(
            mockcpp::any(), mockcpp::any(), eq(RT_MEMORY_HBM), eq(static_cast<uint32_t>(device->Id_())), mockcpp::any(),
            mockcpp::any())
        .will(invoke(DevMemAllocFlagCaptureStub));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).expects(once()).will(invoke(BinaryMemCopyCaptureStub));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(Runtime::Instance()->BinaryLoad(device, &prog), RT_ERROR_NONE);
    EXPECT_NE(g_binaryCopyCapture.devMemAllocFlag & static_cast<uint64_t>(MEM_SNAPSHOT_REQUIRED), 0U);
    EXPECT_EQ(g_binaryCopyCapture.callCount, 1U);
    EXPECT_EQ(g_binaryCopyCapture.size, sizeof(binary));
    EXPECT_EQ(g_binaryCopyCapture.kind, RT_MEMCPY_HOST_TO_DEVICE);
    EXPECT_EQ(g_binaryCopyCapture.firstInstruction, AICORE_BREAK_INSTRUCTION_FOR_TEST);
    EXPECT_EQ(binary[0], AICORE_END_INSTRUCTION_FOR_TEST);
    EXPECT_EQ(Runtime::Instance()->BinaryUnLoad(device, &prog), RT_ERROR_NONE);
    rtInstance->SetChipType(originRtChipType);
    device->SetChipType(originDevChipType);
}

TEST_F(ProgramTest, KeepEndInstructionWhenAiCoreTaskSyncCheckDisabled)
{
    Context* ctx = Runtime::Instance()->CurrentContext();
    ASSERT_NE(ctx, nullptr);
    Device* device = ctx->Device_();
    ASSERT_NE(device, nullptr);
    AiCoreTaskSyncCheckStateGuard syncCheckGuard(device, false);
    uint32_t binary[] = {AICORE_END_INSTRUCTION_FOR_TEST};
    std::unique_ptr<uint8_t[]> patchedBinary;
    const void* dataToLoad = binary;

    EXPECT_EQ(
        Program::PrepareOperatorBinaryForAiCoreTaskSyncCheck(device, dataToLoad, sizeof(binary), patchedBinary),
        RT_ERROR_NONE);

    EXPECT_EQ(binary[0], AICORE_END_INSTRUCTION_FOR_TEST);
    EXPECT_EQ(dataToLoad, binary);
    EXPECT_EQ(patchedBinary.get(), nullptr);
}

TEST_F(ProgramTest, PreparePatchedBinaryForAiCoreTaskSyncCheckPreservesSourceBinary)
{
    Context* ctx = Runtime::Instance()->CurrentContext();
    ASSERT_NE(ctx, nullptr);
    Device* device = ctx->Device_();
    ASSERT_NE(device, nullptr);
    AiCoreTaskSyncCheckStateGuard syncCheckGuard(device, true);
    const uint32_t binary[] = {AICORE_END_INSTRUCTION_FOR_TEST};
    std::unique_ptr<uint8_t[]> patchedBinary;
    const void* dataToLoad = binary;

    ASSERT_EQ(
        Program::PrepareOperatorBinaryForAiCoreTaskSyncCheck(device, dataToLoad, sizeof(binary), patchedBinary),
        RT_ERROR_NONE);
    ASSERT_NE(patchedBinary.get(), nullptr);
    ASSERT_EQ(dataToLoad, patchedBinary.get());

    uint32_t instruction = 0U;
    ASSERT_EQ(memcpy_s(&instruction, sizeof(instruction), dataToLoad, sizeof(instruction)), EOK);
    EXPECT_EQ(instruction, AICORE_BREAK_INSTRUCTION_FOR_TEST);
    EXPECT_EQ(binary[0], AICORE_END_INSTRUCTION_FOR_TEST);
}

TEST_F(ProgramTest, PrepareOperatorBinaryRejectsNullDevice)
{
    uint32_t binary = AICORE_END_INSTRUCTION_FOR_TEST;
    std::unique_ptr<uint8_t[]> patchedBinary(new uint8_t[1U]);
    const void* dataToLoad = &binary;

    EXPECT_EQ(
        Program::PrepareOperatorBinaryForAiCoreTaskSyncCheck(nullptr, dataToLoad, sizeof(binary), patchedBinary),
        RT_ERROR_DEVICE_NULL);
    EXPECT_EQ(patchedBinary.get(), nullptr);
    EXPECT_EQ(dataToLoad, &binary);
}

TEST_F(ProgramTest, PrepareOperatorBinaryRejectsNullBinaryWhenCheckEnabled)
{
    Context* ctx = Runtime::Instance()->CurrentContext();
    ASSERT_NE(ctx, nullptr);
    Device* device = ctx->Device_();
    ASSERT_NE(device, nullptr);
    AiCoreTaskSyncCheckStateGuard syncCheckGuard(device, true);
    std::unique_ptr<uint8_t[]> patchedBinary(new uint8_t[1U]);
    const void* dataToLoad = nullptr;

    EXPECT_EQ(
        Program::PrepareOperatorBinaryForAiCoreTaskSyncCheck(device, dataToLoad, sizeof(uint32_t), patchedBinary),
        RT_ERROR_PROGRAM_DATA);
    EXPECT_EQ(patchedBinary.get(), nullptr);
    EXPECT_EQ(dataToLoad, nullptr);
}

TEST_F(ProgramTest, PatchOperatorBinaryKeepsIncompleteInstruction)
{
    std::array<uint8_t, sizeof(uint32_t) - 1U> binary = {0x00U, 0x00U, 0x60U};
    const auto originalBinary = binary;

    Program::PatchOperatorBinaryForAiCoreTaskSyncCheck(binary.data(), binary.size());

    EXPECT_EQ(binary, originalBinary);
}

TEST_F(ProgramTest, PatchOperatorBinaryReplacesAlignedEndInstructionsAndPreservesTrailingBytes)
{
    const std::array<uint32_t, 3U> instructions = {
        AICORE_END_INSTRUCTION_FOR_TEST, AICORE_OTHER_INSTRUCTION_FOR_TEST, AICORE_END_INSTRUCTION_FOR_TEST};
    std::array<uint8_t, sizeof(instructions) + 2U> binary = {};
    ASSERT_EQ(memcpy_s(binary.data(), binary.size(), instructions.data(), sizeof(instructions)), EOK);
    binary[sizeof(instructions)] = 0x60U;
    binary[sizeof(instructions) + 1U] = 0x41U;

    Program::PatchOperatorBinaryForAiCoreTaskSyncCheck(binary.data(), binary.size());

    std::array<uint32_t, 3U> patchedInstructions = {};
    ASSERT_EQ(
        memcpy_s(patchedInstructions.data(), sizeof(patchedInstructions), binary.data(), sizeof(patchedInstructions)),
        EOK);
    EXPECT_EQ(patchedInstructions[0U], AICORE_BREAK_INSTRUCTION_FOR_TEST);
    EXPECT_EQ(patchedInstructions[1U], AICORE_OTHER_INSTRUCTION_FOR_TEST);
    EXPECT_EQ(patchedInstructions[2U], AICORE_BREAK_INSTRUCTION_FOR_TEST);
    EXPECT_EQ(binary[sizeof(instructions)], 0x60U);
    EXPECT_EQ(binary[sizeof(instructions) + 1U], 0x41U);
}

TEST_F(ProgramTest, Program_Process_ELF)
{
    rtError_t error;
    rtDevBinary_t binary;

    size_t MAX_LENGTH = 7186;
    FILE* bin = NULL;
    // bin = fopen("conv_fwd_sample.cce.tmp", "rb");
    // bin = fopen("elf.o", "rb");
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

    binary.magic = RT_DEV_BINARY_MAGIC_ELF;
    binary.version = 0;
    binary.data = (void*)bindata;
    binary.length = MAX_LENGTH;

    Program* program = new ElfProgram();
    error = program->Register(binary.data, binary.length);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtKernelAttrType kernelAttrType = program->GetDefaultKernelAttrType();
    printf("machine244:%d\n", kernelAttrType);

    char kernelName[] = "_Z15executor_conv2dPDhj";
    printf("kernelName:%s\n", kernelName);
    uint32_t length = 0;
    uint32_t symOff = program->SymbolOffset(kernelName, length);
    printf("symOff0:%d\n", symOff);

    uint32_t elfSize = program->LoadSize();
    printf("elfSize:%d\n", elfSize);

    void* output = NULL;
    // uint32_t size = 0;
    output = (void*)malloc(elfSize);
    memset(output, '\0', elfSize);

    error = program->LoadExtract(output, elfSize);
    EXPECT_EQ(error, RT_ERROR_NONE);

    if (NULL != output) {
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
    FILE* bin = NULL;
    // bin = fopen("conv_fwd_sample.cce.tmp", "rb");
    // bin = fopen("elf.o", "rb");
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

    binary.magic = RT_DEV_BINARY_MAGIC_ELF;
    binary.version = 0;
    binary.data = (void*)bindata;
    binary.length = MAX_LENGTH;

    ElfProgram* program = new ElfProgram();
    program->elfData_->so_name = (char*)"test.so";
    error = program->Register(binary.data, binary.length);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete program;
}

TEST_F(ProgramTest, Program_Process_ELF_No_Kernel)
{
    rtError_t error;
    rtDevBinary_t binary;

    size_t MAX_LENGTH = 7186;
    FILE* bin = NULL;
    // bin = fopen("conv_fwd_sample.cce.tmp", "rb");
    // bin = fopen("elf.o", "rb");
    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/no-kernel.o", "rb");
    if (bin == NULL) {
        printf("error\n");
        return;
    } else {
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
    Kernel* kernel2 = new Kernel("f1", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICORE, 10);
    TilingTabl* tilingTab2 = nullptr;
    uint32_t kernelLen2 = 0U;
    program->kernelNameMap_["test1"] = kernel2;
    error = program->BuildTilingTbl(&tilingTab2, &kernelLen2);
    EXPECT_EQ(kernelLen2, 1);
    free(tilingTab2);

    TilingTablForDavid* tilingTabForDavid2 = nullptr;
    kernelLen2 = 0U;
    error = program->BuildTilingTblForDavid(nullptr, &tilingTabForDavid2, &kernelLen2);
    EXPECT_EQ(kernelLen2, 1);
    free(tilingTabForDavid2);

    program->SetIsNewBinaryLoadFlow(false);
    Module* mdl;
    TilingTabl* tilingTab = nullptr;
    uint32_t kernelLen = 0;
    error = program->BuildTilingTbl(&tilingTab, &kernelLen);
    EXPECT_EQ(error, RT_ERROR_PROGRAM_SIZE);

    error = program->Register(binary.data, binary.length);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    rtKernelAttrType kernelAttrType = program->GetDefaultKernelAttrType();
    printf("machine244:%d\n", kernelAttrType);

    char kernelName[] = "_Z15executor_conv2dPDhj";
    printf("kernelName:%s\n", kernelName);
    uint32_t length = 0;
    uint32_t symOff = program->SymbolOffset(kernelName, length);
    printf("symOff0:%d\n", symOff);

    uint32_t elfSize = program->LoadSize();
    printf("elfSize:%d\n", elfSize);

    void* output = NULL;
    // uint32_t size = 0;
    output = (void*)malloc(elfSize);
    memset(output, '\0', elfSize);

    error = program->LoadExtract(output, elfSize);
    EXPECT_EQ(error, RT_ERROR_SEC_HANDLE);

    if (NULL != output) {
        free(output);
        output = NULL;
    }

    MOCKER(malloc).stubs().will(returnValue((void*)NULL));
    uint32_t kernelPos = program->kernelPos_;
    program->kernelPos_ = 1;
    Runtime* rt = ((Runtime*)Runtime::Instance());
    TilingTablForDavid* tilingTabForDavid = nullptr;
    rt->UpdateDevProperties(CHIP_DAVID, "Ascend950PR_9599");
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
    FILE* bin = NULL;
    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/no-kernel.o", "rb");
    if (bin == NULL) {
        printf("error\n");
        return;
    } else {
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
    Module* mdl;
    TilingTablForDavid* tilingTab = nullptr;
    uint32_t kernelLen = 0;
    error = program->BuildTilingTblForDavid(mdl, &tilingTab, &kernelLen);
    EXPECT_EQ(error, RT_ERROR_PROGRAM_SIZE);

    error = program->Register(binary.data, binary.length);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    rtKernelAttrType kernelAttrType = program->GetDefaultKernelAttrType();
    printf("machine244:%d\n", kernelAttrType);

    char kernelName[] = "_Z15executor_conv2dPDhj";
    printf("kernelName:%s\n", kernelName);
    uint32_t length = 0;
    uint32_t symOff = program->SymbolOffset(kernelName, length);
    printf("symOff0:%d\n", symOff);

    uint32_t elfSize = program->LoadSize();
    printf("elfSize:%d\n", elfSize);

    void* output = NULL;
    output = (void*)malloc(elfSize);
    memset(output, '\0', elfSize);

    error = program->LoadExtract(output, elfSize);
    EXPECT_EQ(error, RT_ERROR_SEC_HANDLE);

    if (NULL != output) {
        free(output);
        output = NULL;
    }

    MOCKER(malloc).stubs().will(returnValue((void*)NULL));
    uint32_t kernelPos = program->kernelPos_;
    program->kernelPos_ = 1;
    Runtime* rt = ((Runtime*)Runtime::Instance());
    TilingTablForDavid* tilingTabForDavid = nullptr;
    rt->UpdateDevProperties(CHIP_DAVID, "Ascend950PR_9599");
    error = program->BuildTilingTblForDavid(mdl, &tilingTabForDavid, &kernelLen);
    EXPECT_EQ(error, RT_ERROR_PROGRAM_SIZE);
    program->kernelPos_ = kernelPos;

    delete program;
}

TEST_F(ProgramTest, Program_build_tiling_tbl_For_David)
{
    rtError_t error;
    Device* device = new RawDevice(0);
    Program* program = new ElfProgram();
    program->SetIsNewBinaryLoadFlow(false);
    program->kernelPos_ = 1;
    Module* mdl = new Module(device);
    program->KernelTable_ = new (std::nothrow) rtKernelArray_t[1U];
    int32_t fun1;
    Kernel* kernel2 = new Kernel("f1", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICORE, 10);
    program->KernelTable_->kernel = kernel2;

    TilingTablForDavid* tilingTabForDavid2 = nullptr;
    uint32_t kernelLen2 = 0U;
    error = program->BuildTilingTblForDavid(mdl, &tilingTabForDavid2, &kernelLen2);
    EXPECT_EQ(kernelLen2, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    free(tilingTabForDavid2);

    delete device;
    delete mdl;
    delete program;
}

TEST_F(ProgramTest, Program_Destructor_Skip_KernelNameMap_Duplicate)
{
    Program* program = new ElfProgram();
    program->kernelPos_ = 1U;
    program->KernelTable_ = new (std::nothrow) rtKernelArray_t[1U];
    ASSERT_NE(program->KernelTable_, nullptr);

    Kernel* kernel = new Kernel("duplicate_kernel", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICORE, 10);
    program->KernelTable_[0].kernel = kernel;
    program->KernelTable_[0].TilingKey = 0ULL;
    program->kernelNameMap_["duplicate_kernel"] = kernel;

    delete program;
    SUCCEED();
}

TEST_F(ProgramTest, Program_Process_ELF_Output_Error)
{
    rtError_t error;
    rtDevBinary_t binary;

    size_t MAX_LENGTH = 6144;
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

    binary.magic = RT_DEV_BINARY_MAGIC_ELF;
    binary.version = 0;
    binary.data = (void*)bindata;
    binary.length = MAX_LENGTH;

    Program* program = new ElfProgram();
    error = program->Register(binary.data, binary.length);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtKernelAttrType kernelAttrType = program->GetDefaultKernelAttrType();
    printf("machine244:%d\n", kernelAttrType);

    const void* kernelName = "_Z15executor_conv2dPDhj";
    uint32_t length = 0;
    uint32_t symOff = program->SymbolOffset(kernelName, length);
    printf("symOff0:%d\n", symOff);

    uint32_t elfSize = program->LoadSize();
    printf("elfSize:%d\n", elfSize);

    void* output = NULL;
    // uint32_t size = 0;
    // output= (void*)malloc(elfSize);
    // memset(output,'\0',elfSize);

    error = program->LoadExtract(output, elfSize);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    if (NULL != output) {
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
    FILE* bin = NULL;
    // bin = fopen("elf.o", "rb");
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

    binary.magic = RT_DEV_BINARY_MAGIC_ELF;
    binary.version = 0;
    binary.data = (void*)bindata;
    binary.length = MAX_LENGTH;

    Program* program = new ElfProgram();
    error = program->Register(binary.data, binary.length);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtKernelAttrType kernelAttrType = program->GetDefaultKernelAttrType();
    printf("machine244:%d\n", kernelAttrType);

    char kernelName[] = "onv";
    printf("kernelName:%s\n", kernelName);
    uint32_t length = 0U;
    uint32_t symOff = program->SymbolOffset(kernelName, length);
    printf("symOff:%d\n", symOff);

    delete program;
}

TEST_F(ProgramTest, Program_Process_ELF_LoadExtract_Error)
{
    rtError_t error;
    rtDevBinary_t binary;

    size_t MAX_LENGTH = 6144;
    FILE* bin = NULL;
    // bin = fopen("elf.o", "rb");
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

    binary.magic = RT_DEV_BINARY_MAGIC_ELF;
    binary.version = 0;
    binary.data = (void*)bindata;
    binary.length = MAX_LENGTH;

    Program* program = new ElfProgram();

    uint32_t elfSize = program->LoadSize();
    printf("elfSize:%d\n", elfSize);

    void* output = NULL;
    // uint32_t size = 0;
    output = (void*)malloc(elfSize);
    memset(output, '\0', elfSize);

    error = program->LoadExtract(output, elfSize);
    EXPECT_EQ(error, RT_ERROR_PROGRAM_DATA);

    if (NULL != output) {
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
    FILE* bin = NULL;
    // bin = fopen("elf.o", "rb");
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

    binary.magic = RT_DEV_BINARY_MAGIC_ELF;
    binary.version = 0;
    binary.data = (void*)bindata;
    binary.length = MAX_LENGTH;

    ElfProgram* program = new ElfProgram();

    delete program->elfData_;

    program->elfData_ = NULL;

    error = program->Register(binary.data, binary.length);
    EXPECT_EQ(error, RT_ERROR_PROGRAM_DATA);

    delete program;
}

TEST_F(ProgramTest, Program_Process_ELF_SymbolOffset_Error)
{
    uint32_t error;
    rtDevBinary_t binary;

    size_t MAX_LENGTH = 6144;
    FILE* bin = NULL;
    // bin = fopen("elf.o", "rb");
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

    binary.magic = RT_DEV_BINARY_MAGIC_ELF;
    binary.version = 0;
    binary.data = (void*)bindata;
    binary.length = MAX_LENGTH;

    ElfProgram* program = new ElfProgram();

    delete program->elfData_;

    program->elfData_ = NULL;
    char symbol[] = "conv";
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
    FILE* bin = NULL;
    // bin = fopen("elf.o", "rb");
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

    binary.magic = RT_DEV_BINARY_MAGIC_ELF;
    binary.version = 0;
    binary.data = (void*)bindata;
    binary.length = MAX_LENGTH;

    ElfProgram* program = new ElfProgram();

    delete program->elfData_;

    program->elfData_ = NULL;

    error = program->LoadSize();
    EXPECT_EQ(error, 0);

    delete program;
}

TEST_F(ProgramTest, LOAD_EXTRACT_TEST)
{
    size_t MAX_LENGTH = 6144;
    uint32_t error;
    uint32_t size = 100;
    FILE* bin = NULL;
    rtDevBinary_t binary;
    void* output = (char*)malloc(sizeof(char) * size);
    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o", "rb");
    if (bin == NULL) {
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

    PlainProgram* program = new PlainProgram(RT_KERNEL_ATTR_TYPE_AICPU);
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

    ElfProgram* program = new ElfProgram(RT_KERNEL_ATTR_TYPE_AICPU);
    Kernel* kernelPtr =
        new (std::nothrow) Kernel("abc", tilingValue, program, RT_KERNEL_ATTR_TYPE_AICORE, 0, 0, NO_MIX);

    EXPECT_NE(kernelPtr, nullptr);

    error = program->KernelNameMapAdd(kernelPtr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = program->KernelNameMapAdd(kernelPtr);
    EXPECT_EQ(error, RT_ERROR_KERNEL_DUPLICATE);

    const Kernel* getKernel = program->GetKernelByName("abc");
    EXPECT_NE(getKernel, nullptr);

    getKernel = program->GetKernelByName("abcd");
    EXPECT_EQ(getKernel, nullptr);

    delete program;
}

TEST_F(ProgramTest, CPU_KERNEL_REG)
{
    Context* const curCtx = Runtime::Instance()->CurrentContext();
    EXPECT_NE(curCtx, nullptr);
    Driver* drv = curCtx->Device_()->Driver_();
    EXPECT_NE(drv, nullptr);
    MOCKER_CPP_VIRTUAL(drv, &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    rtStream_t stream;
    rtError_t error = rtStreamCreateWithFlags(&stream, 0, 8);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ElfProgram* program = new ElfProgram();
    EXPECT_NE(program, nullptr);
    program->SetKernelRegType(RT_KERNEL_REG_TYPE_CPU);

    std::vector<void*> allocatedMem;
    void* devMem = nullptr;
    allocatedMem.push_back(devMem);
    MOCKER_CPP_VIRTUAL(curCtx, &Context::StreamDestroy).stubs().will(returnValue(RT_ERROR_NONE));
    error = program->FreeCpuSoH2dMem(curCtx->Device_(), allocatedMem);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete program;
}

TEST_F(ProgramTest, Program_build_tiling_tbl_For_David_NewFlow)
{
    rtError_t error;
    Device* device = new RawDevice(0);
    Program* program = new ElfProgram();
    program->SetIsNewBinaryLoadFlow(true);
    program->kernelPos_ = 1;
    Module* mdl = new Module(device);
    program->KernelTable_ = new (std::nothrow) rtKernelArray_t[1U];
    int32_t fun1;
    Kernel* kernel2 = new Kernel("f1", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICORE, 10);
    program->KernelTable_->kernel = kernel2;
    program->KernelTable_->TilingKey = 1U;

    TilingTablForDavid* tilingTabForDavid2 = nullptr;
    uint32_t kernelLen2 = 0U;
    error = program->BuildTilingTblForDavid(mdl, &tilingTabForDavid2, &kernelLen2);
    EXPECT_EQ(kernelLen2, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    free(tilingTabForDavid2);

    delete device;
    delete mdl;
    delete program;
}

TEST_F(ProgramTest, Program_build_tiling_tbl_For_David_NewFlow_and_kernelPos_0)
{
    rtError_t error;
    Device* device = new RawDevice(0);
    Program* program = new ElfProgram();
    program->SetIsNewBinaryLoadFlow(true);
    program->kernelPos_ = 0U;
    Module* mdl = new Module(device);
    TilingTablForDavid* tilingTabForDavid2 = nullptr;
    uint32_t kernelLen2 = 0U;
    error = program->BuildTilingTblForDavid(mdl, &tilingTabForDavid2, &kernelLen2);
    EXPECT_EQ(error, RT_ERROR_PROGRAM_SIZE);
    free(tilingTabForDavid2);
    delete device;
    delete mdl;
    delete program;
}

TEST_F(ProgramTest, GetKernelTypeAndMixTypeByMetaInfo_MixMain_InvalidKernelName)
{
    ElfProgram program;
    RtKernel kernel;
    rtKernelAttrType kernelAttrType = RT_KERNEL_ATTR_TYPE_AICORE;
    uint8_t mixType = 0U;

    (void)memset_s(&kernel, sizeof(RtKernel), 0, sizeof(RtKernel));
    kernel.name = const_cast<char*>("test_kernel_invalid");
    kernel.metaInfo.funcType = KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN;
    kernel.metaInfo.crossCoreSync = 0U;

    rtError_t ret = program.GetKernelTypeAndMixTypeByMetaInfo(&kernel, kernelAttrType, mixType);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
}

TEST_F(ProgramTest, StoreKernelLiteralNameToDevice_NonCpu_ReturnEarly)
{
    ElfProgram* program = new ElfProgram();
    program->SetKernelRegType(RT_KERNEL_REG_TYPE_NON_CPU);
    Kernel* kernel = new Kernel("non_cpu_kernel", 0U, program, RT_KERNEL_ATTR_TYPE_AICORE, 0U);
    rtError_t ret = program->StoreKernelLiteralNameToDevice(kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    delete kernel;
    delete program;
}

TEST_F(ProgramTest, CopySoAndNameToCurrentDevice_StoreKernelLiteralNameFailed)
{
    ElfProgram* program = new ElfProgram();
    program->SetIsNewBinaryLoadFlow(true);
    program->SetKernelRegType(RT_KERNEL_REG_TYPE_CPU);
    Kernel* kernel = new Kernel("cpu_kernel", 0U, program, RT_KERNEL_ATTR_TYPE_AICPU, 0U);
    program->kernelNameMap_["cpu_kernel"] = kernel;

    MOCKER_CPP(&Program::StoreKernelLiteralNameToDevice).stubs().will(returnValue(ACL_ERROR_RT_DEVICE_MEM_ERROR));
    rtError_t ret = program->CopySoAndNameToCurrentDevice();
    EXPECT_EQ(ret, ACL_ERROR_RT_DEVICE_MEM_ERROR);
    GlobalMockObject::verify();

    delete program;
}

static rtError_t DevMemAllocSuccessStub(
    Driver* drv, void** dptr, uint64_t size, rtMemType_t type, uint32_t deviceId, DevMemBackupType backupType,
    const DevMemAllocConfig* const config)
{
    UNUSED(drv);
    UNUSED(size);
    UNUSED(type);
    UNUSED(deviceId);
    UNUSED(backupType);
    UNUSED(config);
    *dptr = reinterpret_cast<void*>(0x1000);
    return RT_ERROR_NONE;
}

TEST_F(ProgramTest, AllocAndCopyHbmBuf_Success)
{
    Context* ctx = Runtime::Instance()->CurrentContext();
    ASSERT_NE(ctx, nullptr);
    Device* device = ctx->Device_();
    ASSERT_NE(device, nullptr);

    uint8_t hostBuf[] = {0x01, 0x02, 0x03, 0x04};
    void* devBuf = nullptr;
    std::vector<void*> allocMem;

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAllocWithBackupFlag)
        .stubs()
        .will(invoke(DevMemAllocSuccessStub));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t ret = AllocAndCopyHbmBuf(device, hostBuf, sizeof(hostBuf), &devBuf, allocMem);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(devBuf, nullptr);
    EXPECT_EQ(allocMem.size(), 1U);

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    for (void* mem : allocMem) {
        device->Driver_()->DevMemFree(mem, device->Id_());
    }
}

TEST_F(ProgramTest, AllocAndCopyHbmBuf_DevMemAllocFailed)
{
    Context* ctx = Runtime::Instance()->CurrentContext();
    ASSERT_NE(ctx, nullptr);
    Device* device = ctx->Device_();
    ASSERT_NE(device, nullptr);

    uint8_t hostBuf[] = {0x01};
    void* devBuf = nullptr;
    std::vector<void*> allocMem;

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAllocWithBackupFlag)
        .stubs()
        .will(returnValue(RT_ERROR_DRV_ERR));

    rtError_t ret = AllocAndCopyHbmBuf(device, hostBuf, sizeof(hostBuf), &devBuf, allocMem);
    EXPECT_NE(ret, RT_ERROR_NONE);
    EXPECT_EQ(allocMem.size(), 0U);
}

TEST_F(ProgramTest, AllocAndCopyHbmBuf_MemCopySyncFailed)
{
    Context* ctx = Runtime::Instance()->CurrentContext();
    ASSERT_NE(ctx, nullptr);
    Device* device = ctx->Device_();
    ASSERT_NE(device, nullptr);

    uint8_t hostBuf[] = {0x01, 0x02};
    void* devBuf = nullptr;
    std::vector<void*> allocMem;

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAllocWithBackupFlag).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t ret = AllocAndCopyHbmBuf(device, hostBuf, sizeof(hostBuf), &devBuf, allocMem);
    EXPECT_NE(ret, RT_ERROR_NONE);
    EXPECT_EQ(devBuf, nullptr);
    EXPECT_EQ(allocMem.size(), 0U);
}

TEST_F(ProgramTest, KernelRegistrationLog_PreservesSignedUnknownAndTilingKey)
{
    MOCKER(CheckLogLevel).stubs().will(returnValue(1));
    PlainProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    const KernelRegisterType originalType = program.GetKernelRegType();
    const KernelRegisterType types[] = {
        RT_KERNEL_REG_TYPE_CPU, RT_KERNEL_REG_TYPE_NON_CPU, static_cast<KernelRegisterType>(-7)};
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    const char* names[] = {"KERNEL_REG_TYPE_CPU", "KERNEL_REG_TYPE_NON_CPU", "UNKNOWN"};
#endif
    const uint64_t tilingKey = UINT64_C(4294967301);
    for (size_t i = 0; i < sizeof(types) / sizeof(types[0]); ++i) {
        program.SetKernelRegType(types[i]);
        ClearLastDlogRecordLine();
        EXPECT_EQ(program.GetKernelByTillingKey(tilingKey), nullptr);
        EXPECT_TRUE(DlogRecordContains("AllKernelLookup end, tilingKey=4294967301, programId="));
        const std::string number = std::to_string(static_cast<int32_t>(types[i]));
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
        EXPECT_TRUE(DlogRecordContains(std::string("kernelRegType=") + names[i] + "(" + number + ")"));
#else
        EXPECT_TRUE(DlogRecordContains("kernelRegType=" + number));
#endif
    }
    program.SetKernelRegType(originalType);
}

TEST_F(ProgramTest, KernelMixLog_PreservesMetadataNameAndDefaultReturnPaths)
{
    MOCKER(CheckLogLevel).stubs().will(returnValue(1));
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    char metaName[] = "log_meta";
    char mixName[] = "log_name_mix_aiv";
    char defaultName[] = "log_default";
    char* names[] = {metaName, mixName, defaultName};
    const uint8_t expectedMix[] = {MIX_AIC, MIX_AIV, NO_MIX};
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    const char* expectedNames[] = {"MIX_AIC", "MIX_AIV", "NO_MIX"};
#endif
    for (size_t i = 0; i < sizeof(names) / sizeof(names[0]); ++i) {
        RtKernel kernel = {};
        kernel.name = names[i];
        kernel.metaInfo.funcType = (i == 0U) ? KERNEL_FUNCTION_TYPE_AIC : KERNEL_FUNCTION_TYPE_INVALID;
        kernel.metaInfo.crossCoreSync = FUNC_USE_SYNC;
        rtKernelAttrType attrType = RT_KERNEL_ATTR_TYPE_AICORE;
        uint8_t mixType = UINT8_MAX;
        ClearLastDlogRecordLine();
        EXPECT_EQ(program.GetKernelTypeAndMixType(&kernel, attrType, mixType), RT_ERROR_NONE);
        EXPECT_EQ(mixType, expectedMix[i]);
        EXPECT_TRUE(DlogRecordContains(std::string("Get kernel type success, kernelName=") + names[i] + ","));
        const std::string number = std::to_string(static_cast<uint32_t>(expectedMix[i]));
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
        EXPECT_TRUE(DlogRecordContains(std::string("mixType=") + expectedNames[i] + "(" + number + ")"));
#else
        EXPECT_TRUE(DlogRecordContains("mixType=" + number));
#endif
    }
}

TEST_F(ProgramTest, MergeKernelLog_PreservesAllThreeMixTypes)
{
    MOCKER(CheckLogLevel).stubs().will(returnValue(1));
    MOCKER(GetPrefetchCnt).stubs().will(returnValue(RT_ERROR_NONE));
    ElfProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    Kernel kernel("merge_mix_aic", 0ULL, &program, RT_KERNEL_ATTR_TYPE_CUBE, 16U, 0U, MIX_AIC);
    kernel.SetFuncType(KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN);
    RtKernel incoming = {};
    char_t incomingName[] = "merge_mix_aiv";
    incoming.name = incomingName;
    incoming.offset = 32U;
    incoming.length = 64U;
    incoming.metaInfo.funcType = KERNEL_FUNCTION_TYPE_MIX_AIC_MAIN;
    ClearLastDlogRecordLine();
    EXPECT_EQ(program.MergeKernel(&incoming, &kernel), RT_ERROR_NONE);
    EXPECT_EQ(kernel.GetMixType(), MIX_AIC_AIV_MAIN_AIC);
    EXPECT_EQ(kernel.Offset_(), 16U);
    EXPECT_EQ(kernel.Offset2_(), 32U);
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
    EXPECT_TRUE(DlogRecordContains("mixType1=MIX_AIC(1), mixType2=MIX_AIV(2), final mixType=MIX_AIC_AIV_MAIN_AIC(3)"));
#else
    EXPECT_TRUE(DlogRecordContains("mixType1=1, mixType2=2, final mixType=3"));
#endif
}

TEST_F(ProgramTest, AdviseMemoryLog_PreservesWideSizeAndEarlyReturn)
{
    Context* const ctx = Runtime::Instance()->CurrentContext();
    ASSERT_NE(ctx, nullptr);
    Device* const device = ctx->Device_();
    ASSERT_NE(device, nullptr);
    MOCKER(CheckLogLevel).stubs().will(returnValue(1));
    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemAdvise).stubs().will(returnValue(RT_ERROR_NONE));
    const uint64_t size = 4294967301ULL;
    void* const memory = reinterpret_cast<void*>(0x1234UL);
    const rtAdviseMemType values[] = {RT_ADVISE_ACCESS_READONLY, RT_ADVISE_ACCESS_READWRITE, RT_ADVISE_TYPE_MAX};
    const char* const names[] = {"ADVISE_ACCESS_READONLY", "ADVISE_ACCESS_READWRITE", "UNKNOWN"};
    for (size_t i = 0U; i < sizeof(values) / sizeof(values[0]); ++i) {
        ClearLastDlogRecordLine();
        EXPECT_EQ(BinaryMemAdvise(memory, size, values[i], device, true), RT_ERROR_NONE);
        EXPECT_TRUE(DlogRecordContains("dev_size=4294967301"));
#if RUNTIME_ENABLE_ENUM_LOG_NAMES
        EXPECT_TRUE(DlogRecordContains(
            std::string("advise_type=") + names[i] + "(" + std::to_string(static_cast<int32_t>(values[i])) + ")"));
#else
        EXPECT_TRUE(DlogRecordContains("advise_type=" + std::to_string(static_cast<int32_t>(values[i]))));
#endif
    }
    ClearLastDlogRecordLine();
    EXPECT_EQ(BinaryMemAdvise(memory, size, RT_ADVISE_ACCESS_READONLY, nullptr, false), RT_ERROR_NONE);
    EXPECT_FALSE(DlogRecordContains("advise memory"));
}

#if RUNTIME_ENABLE_ENUM_LOG_NAMES
TEST_F(ProgramTest, TaskTypeNamesBorrowAndNormalizeProviderResults)
{
    // Typed inputs fit 0..255; unknown provider results still normalize to UNKNOWN.
    MOCKER(GetTaskDescByType)
        .expects(once())
        .with(eq(static_cast<uint8_t>(103U)))
        .will(returnValue(static_cast<const char_t*>("BORROWED_TASK")));
    MOCKER(GetTaskDescByType)
        .expects(once())
        .with(eq(static_cast<uint8_t>(10U)))
        .will(returnValue(static_cast<const char_t*>("unknown")));
    MOCKER(GetTaskDescByType)
        .expects(once())
        .with(eq(static_cast<uint8_t>(UINT8_MAX)))
        .will(returnValue(static_cast<const char_t*>(nullptr)));
    EXPECT_STREQ(TsTaskTypeToString(TS_TASK_TYPE_NOP), "BORROWED_TASK");
    EXPECT_STREQ(TsTaskTypeToString(static_cast<tsTaskType_t>(10)), "UNKNOWN");
    EXPECT_STREQ(TsTaskTypeToString(static_cast<tsTaskType_t>(UINT8_MAX)), "UNKNOWN");
    GlobalMockObject::verify();
}
#endif
