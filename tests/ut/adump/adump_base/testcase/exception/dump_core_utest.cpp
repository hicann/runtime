/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"
#include "dump_core.h"
#include "runtime/rt.h"
#include "dump_file_checker.h"
#include "adump_dsmi.h"
#include "exception_dumper.h"
#include "dump_manager.h"
#include "register_config.h"
#include "dump_exception_stub.h"

using namespace Adx;

#define ASCEND_CACHE_PATH ADUMP_BASE_DIR
#define ASCEND_CUSTOM_OPP_PATH "/src/dfx/adump:/tests/ut/adump:"

class DUMP_CORE_UTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        DumpManager::Instance().Reset();
        FreeExceptionRegInfo();
        GlobalMockObject::verify();
    }
};

constexpr uint64_t NON_TENSOR_SIZE = 0xFFFFFFFFFFFFFFFF;

struct ArgInfoHead {
    uint16_t argsDfxType;
    uint16_t numOfArgInfo;
};

struct StaticL1PointerTensor {
    uint64_t argsType;
    uint64_t size;
    uint64_t dim;
    std::array<uint64_t, 2> shape;
};

struct L2PointerTensor {
    uint64_t argsType;
    uint64_t size;
    uint64_t dataTypeSize;
};

struct WithSizeTensor {
    uint64_t argsType;
    uint64_t size;
};
struct WithoutSizeTensor {
    uint64_t argsType;
};

static void generateDfxByBigEndian(std::vector<uint8_t> &vec, size_t typeSize, uint64_t value)
{
    for (size_t i = 0; i < typeSize; ++i) {
        uint8_t tmpValue = static_cast<uint8_t>(((value) >> ((typeSize - i - 1) * 8)) & 0xFF);
        vec.push_back(tmpValue);
    }
}

static void generateDfxByLittleEndian(std::vector<uint8_t> &vec, size_t typeSize, uint64_t value)
{
    for (size_t i = 0; i < typeSize; ++i) {
        uint8_t tmpValue = static_cast<uint8_t>(((value) >> (i * 8)) & 0xFF);
        vec.push_back(tmpValue);
    }
}

template <typename T>
void generateDfxInfo(std::vector<uint8_t> &dfxInfo, T &tensor, uint16_t argsInfoType = TYPE_L0_EXCEPTION_DFX_ARGS_INFO)
{
    std::vector<uint8_t> tensorDfxInfo;
    auto *p = reinterpret_cast<uint64_t *>(&tensor);
    for (size_t i = 0; i < sizeof(tensor) / sizeof(uint64_t); ++i) {
        generateDfxByBigEndian(tensorDfxInfo, sizeof(uint64_t), *(p + i));
    }
    ArgInfoHead head = {argsInfoType, sizeof(tensor) / sizeof(uint64_t)};
    generateDfxByBigEndian(dfxInfo, sizeof(uint16_t), head.argsDfxType);
    generateDfxByBigEndian(dfxInfo, sizeof(uint16_t), head.numOfArgInfo);
    dfxInfo.insert(dfxInfo.end(), tensorDfxInfo.begin(), tensorDfxInfo.end());
}

template <typename T>
std::vector<uint8_t> GetTensorData(T &tensor)
{
    std::vector<uint8_t> tensorData;
    tensorData.resize(sizeof(tensor));
    memcpy(tensorData.data(), tensor, sizeof(tensor));
    return tensorData;
}

TEST_F(DUMP_CORE_UTEST, TEST_CORE_DUMP)
{
    uint32_t type = 5; // CHIP_CLOUD_V2
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(type)).will(returnValue(true));
    MOCKER(&Adx::KernelInfoCollector::ParseKernelSymbols).stubs().will(invoke(Adx::ParseKernelSymbolsStub));

    DumpConfig dumpConf;
    dumpConf.dumpPath = "/tmp/adump_coredump_utest";
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::AIC_ERR_DETAIL_DUMP, dumpConf), ADUMP_SUCCESS);
    rtSetDevice(0);
    rtDeviceReset(0);
    rtSetDevice(0);

    rtExceptionInfo exceptionInfo = {0};
    exceptionInfo.streamid = 1;
    exceptionInfo.taskid = 1;
    exceptionInfo.deviceid = 1;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    char fftsAddr[] = "ffts addr";
    int32_t tensor[] = {1, 2, 3, 4, 5, 6};
    float input0[] = {1, 2, 3, 4, 5, 6};
    float output0[] = {2, 4, 6, 8, 10, 12};
    int32_t placehold[] = {1};
    int32_t normalPtr1[] = {10, 20, 30};
    int32_t normalPtr2[] = {40, 50, 60};
    int32_t shapePtr2t3[] = {2, 2, 2, 3, 3, 3};
    int32_t shapePtrPlaceHold[] = {7, 8, 9};
    int32_t shapePtrScalar[] = {123456};
    int32_t workspace[] = {100, 100, 100};
    uint64_t args[22] = {};
    args[0] = reinterpret_cast<uint64_t>(&fftsAddr);
    args[1] = reinterpret_cast<uint64_t>(&tensor);
    args[2] = reinterpret_cast<uint64_t>(&input0);
    args[3] = reinterpret_cast<uint64_t>(&output0);
    args[4] = reinterpret_cast<uint64_t>(&placehold);
    args[5] = reinterpret_cast<uint64_t>(&args[8]);
    args[6] = reinterpret_cast<uint64_t>(&args[10]);
    args[7] = reinterpret_cast<uint64_t>(&workspace);
    args[8] = reinterpret_cast<uint64_t>(&normalPtr1);
    args[9] = reinterpret_cast<uint64_t>(&normalPtr2);
    args[10] = sizeof(uint64_t) * 9;                    // offset of shapePtr(args[19])
    args[11] = 2 | (1ULL << TENSOR_COUNT_SHIFT_BITS);   // shapePtr2t3 dim(2) and count(1)
    args[12] = 2;                                       // shapePtr2t3 shape[0]
    args[13] = 3;                                       // shapePtr2t3 shape[1]
    args[14] = 2 | (1ULL << TENSOR_COUNT_SHIFT_BITS);   // shapePtrPlaceHold dim(2) and count(1)
    args[15] = 3;                                       // shapePtrPlaceHold shape[0]
    args[16] = 1;                                       // shapePtrPlaceHold shape[1]
    args[17] = 1 | (1ULL << TENSOR_COUNT_SHIFT_BITS);   // shapePtrScalar dim(1) and count(1)
    args[18] = 1;                                       // shapePtrScalar shape[0]
    args[19] = reinterpret_cast<uint64_t>(&shapePtr2t3);
    args[20] = reinterpret_cast<uint64_t>(&shapePtrPlaceHold);
    args[21] = reinterpret_cast<uint64_t>(&shapePtrScalar);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);

    std::vector<uint8_t> dfxInfoValue;
    // ffts addr
    std::vector<uint8_t> fftsAddrDfxInfo;
    WithoutSizeTensor fftsAddrTensor = {
        static_cast<uint16_t>(DfxTensorType::FFTS_ADDRESS) |
        (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS)};
    generateDfxInfo(fftsAddrDfxInfo, fftsAddrTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), fftsAddrDfxInfo.begin(), fftsAddrDfxInfo.end());

    // general tensor
    std::vector<uint8_t> tensorDfxInfo;
    StaticL1PointerTensor generalTensor;
    generalTensor.argsType = static_cast<uint16_t>(DfxTensorType::GENERAL_TENSOR) |
                             (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    generalTensor.size = sizeof(tensor);
    generalTensor.dim = 2;
    generalTensor.shape = {1, 6};
    generateDfxInfo(tensorDfxInfo, generalTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), tensorDfxInfo.begin(), tensorDfxInfo.end());

    // input0
    std::vector<uint8_t> inputDfxInfo;
    StaticL1PointerTensor inputTensor;
    inputTensor.argsType = static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
                           (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    inputTensor.size = sizeof(input0);
    inputTensor.dim = 2;
    inputTensor.shape = {2, 3};
    generateDfxInfo(inputDfxInfo, inputTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), inputDfxInfo.begin(), inputDfxInfo.end());

    // output0
    std::vector<uint8_t> outputDfxInfo;
    StaticL1PointerTensor outputTensor;
    outputTensor.argsType = static_cast<uint16_t>(DfxTensorType::OUTPUT_TENSOR) |
                            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    outputTensor.size = sizeof(input0);
    outputTensor.dim = 2;
    outputTensor.shape = {3, 2};
    generateDfxInfo(outputDfxInfo, outputTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), outputDfxInfo.begin(), outputDfxInfo.end());

    // placehold
    std::vector<uint8_t> placeholdDfxInfo;
    StaticL1PointerTensor placeholdTensor;
    placeholdTensor.argsType = static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
                               (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    placeholdTensor.size = 0;
    placeholdTensor.dim = 2;
    placeholdTensor.shape = {4, 2};
    generateDfxInfo(placeholdDfxInfo, placeholdTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), placeholdDfxInfo.begin(), placeholdDfxInfo.end());

    // normal pointer
    std::vector<uint8_t> normalPointerDfxInfo;
    L2PointerTensor normalPointerTensor;
    normalPointerTensor.argsType = static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
                                   (static_cast<uint16_t>(DfxPointerType::LEVEL_2_POINTER) << POINTER_TYPE_SHIFT_BITS);
    normalPointerTensor.size = NON_TENSOR_SIZE;
    normalPointerTensor.dataTypeSize = 4;
    generateDfxInfo(normalPointerDfxInfo, normalPointerTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), normalPointerDfxInfo.begin(), normalPointerDfxInfo.end());

    // shape pointer
    std::vector<uint8_t> shapePointerDfxInfo;
    L2PointerTensor shapePointerTensor;
    shapePointerTensor.argsType =
        static_cast<uint16_t>(DfxTensorType::OUTPUT_TENSOR) |
        (static_cast<uint16_t>(DfxPointerType::LEVEL_2_POINTER_WITH_SHAPE) << POINTER_TYPE_SHIFT_BITS);
    shapePointerTensor.size = NON_TENSOR_SIZE;
    shapePointerTensor.dataTypeSize = 4;
    generateDfxInfo(shapePointerDfxInfo, shapePointerTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), shapePointerDfxInfo.begin(), shapePointerDfxInfo.end());

    // workspace
    std::vector<uint8_t> workspaceDfxInfo;
    WithSizeTensor workspaceTensor = {
        static_cast<uint16_t>(DfxTensorType::WORKSPACE_TENSOR) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        sizeof(workspace)};
    generateDfxInfo(workspaceDfxInfo, workspaceTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), workspaceDfxInfo.begin(), workspaceDfxInfo.end());

    // total dfxInfo
    std::vector<uint8_t> dfxInfo;
    uint16_t dfxInfoLength = static_cast<uint16_t>(dfxInfoValue.size());
    generateDfxByLittleEndian(dfxInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX);
    generateDfxByLittleEndian(dfxInfo, sizeof(uint16_t), dfxInfoLength);
    dfxInfo.insert(dfxInfo.end(), dfxInfoValue.begin(), dfxInfoValue.end());
    uint8_t *ptr = dfxInfo.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = ptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = dfxInfo.size();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.elfDataFlag = 1;

    // test collect kernel .o .json file
    (void)setenv("ASCEND_CACHE_PATH", ASCEND_CACHE_PATH, 1);
    (void)setenv("ASCEND_CUSTOM_OPP_PATH", ASCEND_CUSTOM_OPP_PATH, 1);
    char binData[] = "BIN_DATA";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(binData);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(binData);
    std::string kernelName = "Custom_3ee04b5d550e4239498c29151be6bb5c_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();

    system("mkdir -p /tmp/adump_coredump_utest");
    DumpCore dumpCore("/tmp/adump_coredump_utest", 0);
    dumpCore.DumpCoreFile(exceptionInfo);
    EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -t"));
    EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -p .ascend.global"));
    EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -p .ascend.host_kernel_object"));
    EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -p .ascend.file_kernel_json"));
    EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -p .ascend.file_kernel_object"));
    EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -p .ascend.kernel_info"));
    EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -p .ascend.local.1"));

    system("rm -r /tmp/adump_coredump_utest");
}

TEST_F(DUMP_CORE_UTEST, TEST_CORE_DUMP_OLD)
{
    rtExceptionInfo exceptionInfo = {0};
    exceptionInfo.streamid = 1;
    exceptionInfo.taskid = 1;
    exceptionInfo.deviceid = 1;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = nullptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = 0;
    char hostKernel[] = "host kernel bin file stub";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "Custom_3ee04b5d550e4239498c29151be6bb5c_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();

    char input0[] = "input0";
    char shapePtr1[] = "shapePtr1";
    char shapePtr2[] = "shapePtr2";
    char normalPtr1[] = "normalPtr1";
    char normalPtr2[] = "normalPtr2";
    char workspace[] = "workspace";
    char oldNormalPtr[] = "oldNormalPtr";
    char tilingData[] = "tilingData";
    uint64_t args[14] = {};
    args[0] = 0;
    args[1] = reinterpret_cast<uint64_t>(&input0);
    args[2] = 2;
    args[8] = reinterpret_cast<uint64_t>(&normalPtr1);
    args[9] = reinterpret_cast<uint64_t>(&normalPtr2);
    args[4] = reinterpret_cast<uint64_t>(&args[8]);
    args[10] = 16;
    args[12] = reinterpret_cast<uint64_t>(&shapePtr1);
    args[13] = reinterpret_cast<uint64_t>(&shapePtr2);
    args[5] = reinterpret_cast<uint64_t>(&args[10]);
    args[6] = reinterpret_cast<uint64_t>(&workspace);
    args[7] = reinterpret_cast<uint64_t>(&tilingData);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);

    uint32_t atomicIndex;
    uint64_t sizeInfo[] = {atomicIndex,
                           0x000000010000000D,
                           sizeof(input0),
                           0,
                           -2,
                           sizeof(oldNormalPtr),
                           sizeof(oldNormalPtr),
                           0x0100000000000002,
                           sizeof(normalPtr1),
                           sizeof(normalPtr2),
                           0x0200000000000002,
                           sizeof(shapePtr1),
                           sizeof(shapePtr2),
                           sizeof(workspace),
                           0x0300000000000000 + sizeof(tilingData)};
    uint32_t space = sizeof(sizeInfo) / sizeof(sizeInfo[0]);
    auto sizeInfoAddr = static_cast<uint64_t *>(AdumpGetSizeInfoAddr(space, atomicIndex));
    auto sizeInfos = sizeInfoAddr;
    sizeInfo[0] = atomicIndex;
    for (const auto &size : sizeInfo) {
        *sizeInfos = size;
        sizeInfos++;
    }
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.infoAddr = sizeInfoAddr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.atomicIndex = atomicIndex;

    system("mkdir -p /tmp/adump_coredump_utest");
    DumpCore dumpCore("/tmp/adump_coredump_utest", 0);
    dumpCore.DumpCoreFile(exceptionInfo);
    EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -t"));
    EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -p .ascend.global"));
    EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -p .ascend.host_kernel_object"));
    EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -p .ascend.file_kernel_json"));
    EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -p .ascend.file_kernel_object"));
    EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -p .ascend.kernel_info"));
    EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -p .ascend.local.1"));
}

TEST_F(DUMP_CORE_UTEST, TEST_CORE_DUMP_RUNTIME_FUNC_FAILED)
{
    uint32_t type = 5; // CHIP_CLOUD_V2
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(type)).will(returnValue(true));
    MOCKER(&Adx::KernelInfoCollector::ParseKernelSymbols).stubs().will(invoke(Adx::ParseKernelSymbolsStub));
    rtExceptionInfo exceptionInfo = {0};
    exceptionInfo.streamid = 1;
    exceptionInfo.taskid = 1;
    exceptionInfo.deviceid = 1;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    char fftsAddr[] = "ffts addr";
    int32_t tensor[] = {1, 2, 3, 4, 5, 6};
    float input0[] = {1, 2, 3, 4, 5, 6};
    float output0[] = {2, 4, 6, 8, 10, 12};
    int32_t placehold[] = {1};
    int32_t normalPtr1[] = {10, 20, 30};
    int32_t normalPtr2[] = {40, 50, 60};
    int32_t shapePtr2t3[] = {2, 2, 2, 3, 3, 3};
    int32_t shapePtrPlaceHold[] = {7, 8, 9};
    int32_t shapePtrScalar[] = {123456};
    int32_t workspace[] = {100, 100, 100};
    uint64_t args[22] = {};
    args[0] = reinterpret_cast<uint64_t>(&fftsAddr);
    args[1] = reinterpret_cast<uint64_t>(&tensor);
    args[2] = reinterpret_cast<uint64_t>(&input0);
    args[3] = reinterpret_cast<uint64_t>(&output0);
    args[4] = reinterpret_cast<uint64_t>(&placehold);
    args[5] = reinterpret_cast<uint64_t>(&args[8]);
    args[6] = reinterpret_cast<uint64_t>(&args[10]);
    args[7] = reinterpret_cast<uint64_t>(&workspace);
    args[8] = reinterpret_cast<uint64_t>(&normalPtr1);
    args[9] = reinterpret_cast<uint64_t>(&normalPtr2);
    args[10] = sizeof(uint64_t) * 9;                    // offset of shapePtr(args[19])
    args[11] = 2 | (1ULL << TENSOR_COUNT_SHIFT_BITS);   // shapePtr2t3 dim(2) and count(1)
    args[12] = 2;                                       // shapePtr2t3 shape[0]
    args[13] = 3;                                       // shapePtr2t3 shape[1]
    args[14] = 2 | (1ULL << TENSOR_COUNT_SHIFT_BITS);   // shapePtrPlaceHold dim(2) and count(1)
    args[15] = 3;                                       // shapePtrPlaceHold shape[0]
    args[16] = 1;                                       // shapePtrPlaceHold shape[1]
    args[17] = 1 | (1ULL << TENSOR_COUNT_SHIFT_BITS);   // shapePtrScalar dim(1) and count(1)
    args[18] = 1;                                       // shapePtrScalar shape[0]
    args[19] = reinterpret_cast<uint64_t>(&shapePtr2t3);
    args[20] = reinterpret_cast<uint64_t>(&shapePtrPlaceHold);
    args[21] = reinterpret_cast<uint64_t>(&shapePtrScalar);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);

    std::vector<uint8_t> dfxInfoValue;
    // ffts addr
    std::vector<uint8_t> fftsAddrDfxInfo;
    WithoutSizeTensor fftsAddrTensor = {
        static_cast<uint16_t>(DfxTensorType::FFTS_ADDRESS) |
        (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS)};
    generateDfxInfo(fftsAddrDfxInfo, fftsAddrTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), fftsAddrDfxInfo.begin(), fftsAddrDfxInfo.end());

    // general tensor
    std::vector<uint8_t> tensorDfxInfo;
    StaticL1PointerTensor generalTensor;
    generalTensor.argsType = static_cast<uint16_t>(DfxTensorType::GENERAL_TENSOR) |
                             (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    generalTensor.size = sizeof(tensor);
    generalTensor.dim = 2;
    generalTensor.shape = {1, 6};
    generateDfxInfo(tensorDfxInfo, generalTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), tensorDfxInfo.begin(), tensorDfxInfo.end());

    // input0
    std::vector<uint8_t> inputDfxInfo;
    StaticL1PointerTensor inputTensor;
    inputTensor.argsType = static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
                           (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    inputTensor.size = sizeof(input0);
    inputTensor.dim = 2;
    inputTensor.shape = {2, 3};
    generateDfxInfo(inputDfxInfo, inputTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), inputDfxInfo.begin(), inputDfxInfo.end());

    // output0
    std::vector<uint8_t> outputDfxInfo;
    StaticL1PointerTensor outputTensor;
    outputTensor.argsType = static_cast<uint16_t>(DfxTensorType::OUTPUT_TENSOR) |
                            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    outputTensor.size = sizeof(input0);
    outputTensor.dim = 2;
    outputTensor.shape = {3, 2};
    generateDfxInfo(outputDfxInfo, outputTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), outputDfxInfo.begin(), outputDfxInfo.end());

    // placehold
    std::vector<uint8_t> placeholdDfxInfo;
    StaticL1PointerTensor placeholdTensor;
    placeholdTensor.argsType = static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
                               (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    placeholdTensor.size = 0;
    placeholdTensor.dim = 2;
    placeholdTensor.shape = {4, 2};
    generateDfxInfo(placeholdDfxInfo, placeholdTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), placeholdDfxInfo.begin(), placeholdDfxInfo.end());

    // normal pointer
    std::vector<uint8_t> normalPointerDfxInfo;
    L2PointerTensor normalPointerTensor;
    normalPointerTensor.argsType = static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
                                   (static_cast<uint16_t>(DfxPointerType::LEVEL_2_POINTER) << POINTER_TYPE_SHIFT_BITS);
    normalPointerTensor.size = NON_TENSOR_SIZE;
    normalPointerTensor.dataTypeSize = 4;
    generateDfxInfo(normalPointerDfxInfo, normalPointerTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), normalPointerDfxInfo.begin(), normalPointerDfxInfo.end());

    // shape pointer
    std::vector<uint8_t> shapePointerDfxInfo;
    L2PointerTensor shapePointerTensor;
    shapePointerTensor.argsType =
        static_cast<uint16_t>(DfxTensorType::OUTPUT_TENSOR) |
        (static_cast<uint16_t>(DfxPointerType::LEVEL_2_POINTER_WITH_SHAPE) << POINTER_TYPE_SHIFT_BITS);
    shapePointerTensor.size = NON_TENSOR_SIZE;
    shapePointerTensor.dataTypeSize = 4;
    generateDfxInfo(shapePointerDfxInfo, shapePointerTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), shapePointerDfxInfo.begin(), shapePointerDfxInfo.end());

    // workspace
    std::vector<uint8_t> workspaceDfxInfo;
    WithSizeTensor workspaceTensor = {
        static_cast<uint16_t>(DfxTensorType::WORKSPACE_TENSOR) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        sizeof(workspace)};
    generateDfxInfo(workspaceDfxInfo, workspaceTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), workspaceDfxInfo.begin(), workspaceDfxInfo.end());

    // total dfxInfo
    std::vector<uint8_t> dfxInfo;
    uint16_t dfxInfoLength = static_cast<uint16_t>(dfxInfoValue.size());
    generateDfxByLittleEndian(dfxInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX);
    generateDfxByLittleEndian(dfxInfo, sizeof(uint16_t), dfxInfoLength);
    dfxInfo.insert(dfxInfo.end(), dfxInfoValue.begin(), dfxInfoValue.end());
    uint8_t *ptr = dfxInfo.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = ptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = dfxInfo.size();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.elfDataFlag = 1;

    // test collect kernel .o .json file
    (void)setenv("ASCEND_CACHE_PATH", ASCEND_CACHE_PATH, 1);
    (void)setenv("ASCEND_CUSTOM_OPP_PATH", ASCEND_CUSTOM_OPP_PATH, 1);
    char binData[] = "BIN_DATA";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(binData);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(binData);
    std::string kernelName = "Custom_3ee04b5d550e4239498c29151be6bb5c_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = nullptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = 0;

    rtError_t rtError = -1;
    DumpCore dumpCore("/tmp/adump_coredump_utest", 0);

    MOCKER(memcpy_s).stubs().will(returnValue(EN_ERROR));
    dumpCore.DumpCoreFile(exceptionInfo);

    MOCKER(rtDebugReadAICore).stubs().will(returnValue(rtError));
    dumpCore.DumpCoreFile(exceptionInfo);

    MOCKER(rtGetStackBuffer).stubs().will(returnValue(rtError));
    dumpCore.DumpCoreFile(exceptionInfo);

    MOCKER(rtMemcpy).stubs().will(returnValue(rtError));
    dumpCore.DumpCoreFile(exceptionInfo);

    MOCKER(rtMemGetInfoByType).stubs().will(returnValue(rtError));
    dumpCore.DumpCoreFile(exceptionInfo);

    system("mkdir -p /tmp/adump_coredump_utest");
    ExceptionDumper dumper;
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/tmp/adump_coredump_utest";
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(ADUMP_FAILED, dumper.DumpException(exceptionInfo));
    dumper.ExceptionDumperInit(DumpType::AIC_ERR_DETAIL_DUMP, dumpConf);
    MOCKER_CPP(&DumpCore::DumpCoreFile).stubs().will(returnValue(ADUMP_FAILED));
    EXPECT_EQ(ADUMP_FAILED, dumper.DumpException(exceptionInfo));
    dumper.ExceptionModeDowngrade();
    EXPECT_EQ(ADUMP_FAILED, dumper.DumpException(exceptionInfo));
    system("rm -r /tmp/adump_coredump_utest");
}

TEST_F(DUMP_CORE_UTEST, TEST_CORE_DUMP_CAN_NOT_OFF)
{
    ExceptionDumper dumper;
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/tmp/adump_coredump_utest";
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(false, dumper.GetCoredumpStatus());
    EXPECT_EQ(ADUMP_SUCCESS, dumper.ExceptionDumperInit(DumpType::AIC_ERR_DETAIL_DUMP, dumpConf));
    EXPECT_EQ(true, dumper.GetCoredumpStatus());
    dumpConf.dumpStatus = "off";
    EXPECT_EQ(ADUMP_SUCCESS, dumper.ExceptionDumperInit(DumpType::AIC_ERR_DETAIL_DUMP, dumpConf));
    EXPECT_EQ(true, dumper.GetCoredumpStatus());
}
