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
#include <fstream>
#include <functional>
#include <thread>
#include "mockcpp/mockcpp.hpp"
#include "dump_core.h"
#include "register_config.h"
#include "adump_dsmi.h"
#include "dump_common.h"

using namespace Adx;

class DupDumpCoreUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(DupDumpCoreUtest, Test_DumpRegisterNotSupport)
{
    DumpCore core("", 10);
    uint32_t v4type = 15;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4type)).will(returnValue(true));
    std::shared_ptr<RegisterInterface> register_ = std::make_shared<CloudV2Register>();
    core.DumpRegister(0, 0);
}

TEST_F(DupDumpCoreUtest, Test_DumpRegister)
{
    DumpCore core("", 10);
    uint32_t v2type = 5;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    registerManager.CreateRegister();
    core.DumpRegister(0, 0);
}

TEST_F(DupDumpCoreUtest, Test_DumpRegisterReadAICoreFail)
{
    DumpCore core("", 10);
    uint32_t v2type = 5;
    MOCKER_CPP(&rtDebugReadAICore).stubs().will(returnValue(1));
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    registerManager.CreateRegister();
    core.DumpRegister(0, 0);
}

TEST_F(DupDumpCoreUtest, Test_DumpRegisterMemCpyFail)
{
    DumpCore core("", 10);
    uint32_t v2type = 5;
    MOCKER_CPP(&memcpy_s).stubs().will(returnValue(1));
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    RegisterManager registerManager = RegisterManager();
    registerManager.CreateRegister();
    core.DumpRegister(0, 0);
}

TEST_F(DupDumpCoreUtest, Test_ConvertCoreIdNotSupport)
{
    uint32_t v4type = 15;
    uint8_t coreType = 0;
    uint16_t coreId = 1;
    DumpCore core("", 10);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4type)).will(returnValue(true));
    EXPECT_EQ(core.ConvertCoreId(coreType, coreId), 1);
}

TEST_F(DupDumpCoreUtest, Test_ConvertCoreId)
{
    uint32_t v2type = 5;
    uint8_t coreType = 0;
    uint16_t coreId = 1;
    DumpCore core("", 10);
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    EXPECT_EQ(core.ConvertCoreId(coreType, coreId), 1);
    coreType = 1;
    EXPECT_EQ(core.ConvertCoreId(coreType, coreId), 26);
}


// TEST_F(DUMP_CORE_UTEST, TEST_CORE_DUMP_DAVID)
// {
//     uint32_t type = 15; // CHIP_CLOUD_V4
//     MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(type)).will(returnValue(true));
//     const std::shared_ptr<Adx::RegisterInterface> reg = std::make_shared<CloudV4Register>();
//     MOCKER_CPP(&Adx::RegisterManager::GetRegister).stubs().will(returnValue(reg));

//     DumpConfig dumpConf;
//     dumpConf.dumpPath = "/tmp/adump_coredump_utest";
//     dumpConf.dumpStatus = "on";
//     EXPECT_EQ(AdumpSetDumpConfig(DumpType::AIC_ERR_DETAIL_DUMP, dumpConf), ADUMP_SUCCESS);
//     rtSetDevice(0);
//     rtDeviceReset(0);
//     rtSetDevice(0);

//     rtExceptionInfo exceptionInfo = {0};
//     exceptionInfo.streamid = 1;
//     exceptionInfo.taskid = 1;
//     exceptionInfo.deviceid = 1;
//     exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
//     char fftsAddr[] = "ffts addr";
//     int32_t tensor[] = {1, 2, 3, 4, 5, 6};
//     float input0[] = {1, 2, 3, 4, 5, 6};
//     float output0[] = {2, 4, 6, 8, 10, 12};
//     int32_t placehold[] = {1};
//     int32_t normalPtr1[] = {10, 20, 30};
//     int32_t normalPtr2[] = {40, 50, 60};
//     int32_t shapePtr2t3[] = {2, 2, 2, 3, 3, 3};
//     int32_t shapePtrPlaceHold[] = {7, 8, 9};
//     int32_t shapePtrScalar[] = {123456};
//     int32_t workspace[] = {100, 100, 100};
//     uint64_t args[22] = {};
//     args[0] = reinterpret_cast<uint64_t>(&fftsAddr);
//     args[1] = reinterpret_cast<uint64_t>(&tensor);
//     args[2] = reinterpret_cast<uint64_t>(&input0);
//     args[3] = reinterpret_cast<uint64_t>(&output0);
//     args[4] = reinterpret_cast<uint64_t>(&placehold);
//     args[5] = reinterpret_cast<uint64_t>(&args[8]);
//     args[6] = reinterpret_cast<uint64_t>(&args[10]);
//     args[7] = reinterpret_cast<uint64_t>(&workspace);
//     args[8] = reinterpret_cast<uint64_t>(&normalPtr1);
//     args[9] = reinterpret_cast<uint64_t>(&normalPtr2);
//     args[10] = sizeof(uint64_t) * 9;                    // offset of shapePtr(args[19])
//     args[11] = 2 | (1ULL << TENSOR_COUNT_SHIFT_BITS);   // shapePtr2t3 dim(2) and count(1)
//     args[12] = 2;                                       // shapePtr2t3 shape[0]
//     args[13] = 3;                                       // shapePtr2t3 shape[1]
//     args[14] = 2 | (1ULL << TENSOR_COUNT_SHIFT_BITS);   // shapePtrPlaceHold dim(2) and count(1)
//     args[15] = 3;                                       // shapePtrPlaceHold shape[0]
//     args[16] = 1;                                       // shapePtrPlaceHold shape[1]
//     args[17] = 1 | (1ULL << TENSOR_COUNT_SHIFT_BITS);   // shapePtrScalar dim(1) and count(1)
//     args[18] = 1;                                       // shapePtrScalar shape[0]
//     args[19] = reinterpret_cast<uint64_t>(&shapePtr2t3);
//     args[20] = reinterpret_cast<uint64_t>(&shapePtrPlaceHold);
//     args[21] = reinterpret_cast<uint64_t>(&shapePtrScalar);
//     exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
//     exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);

//     std::vector<uint8_t> dfxInfoValue;
//     // ffts addr
//     std::vector<uint8_t> fftsAddrDfxInfo;
//     WithoutSizeTensor fftsAddrTensor = {
//         static_cast<uint16_t>(DfxTensorType::FFTS_ADDRESS) |
//         (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS)};
//     generateDfxInfo(fftsAddrDfxInfo, fftsAddrTensor);
//     dfxInfoValue.insert(dfxInfoValue.end(), fftsAddrDfxInfo.begin(), fftsAddrDfxInfo.end());

//     // general tensor
//     std::vector<uint8_t> tensorDfxInfo;
//     StaticL1PointerTensor generalTensor;
//     generalTensor.argsType = static_cast<uint16_t>(DfxTensorType::GENERAL_TENSOR) |
//                              (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
//     generalTensor.size = sizeof(tensor);
//     generalTensor.dim = 2;
//     generalTensor.shape = {1, 6};
//     generateDfxInfo(tensorDfxInfo, generalTensor);
//     dfxInfoValue.insert(dfxInfoValue.end(), tensorDfxInfo.begin(), tensorDfxInfo.end());

//     // input0
//     std::vector<uint8_t> inputDfxInfo;
//     StaticL1PointerTensor inputTensor;
//     inputTensor.argsType = static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
//                            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
//     inputTensor.size = sizeof(input0);
//     inputTensor.dim = 2;
//     inputTensor.shape = {2, 3};
//     generateDfxInfo(inputDfxInfo, inputTensor);
//     dfxInfoValue.insert(dfxInfoValue.end(), inputDfxInfo.begin(), inputDfxInfo.end());

//     // output0
//     std::vector<uint8_t> outputDfxInfo;
//     StaticL1PointerTensor outputTensor;
//     outputTensor.argsType = static_cast<uint16_t>(DfxTensorType::OUTPUT_TENSOR) |
//                             (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
//     outputTensor.size = sizeof(input0);
//     outputTensor.dim = 2;
//     outputTensor.shape = {3, 2};
//     generateDfxInfo(outputDfxInfo, outputTensor);
//     dfxInfoValue.insert(dfxInfoValue.end(), outputDfxInfo.begin(), outputDfxInfo.end());

//     // placehold
//     std::vector<uint8_t> placeholdDfxInfo;
//     StaticL1PointerTensor placeholdTensor;
//     placeholdTensor.argsType = static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
//                                (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
//     placeholdTensor.size = 0;
//     placeholdTensor.dim = 2;
//     placeholdTensor.shape = {4, 2};
//     generateDfxInfo(placeholdDfxInfo, placeholdTensor);
//     dfxInfoValue.insert(dfxInfoValue.end(), placeholdDfxInfo.begin(), placeholdDfxInfo.end());

//     // normal pointer
//     std::vector<uint8_t> normalPointerDfxInfo;
//     L2PointerTensor normalPointerTensor;
//     normalPointerTensor.argsType = static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
//                                    (static_cast<uint16_t>(DfxPointerType::LEVEL_2_POINTER) << POINTER_TYPE_SHIFT_BITS);
//     normalPointerTensor.size = NON_TENSOR_SIZE;
//     normalPointerTensor.dataTypeSize = 4;
//     generateDfxInfo(normalPointerDfxInfo, normalPointerTensor);
//     dfxInfoValue.insert(dfxInfoValue.end(), normalPointerDfxInfo.begin(), normalPointerDfxInfo.end());

//     // shape pointer
//     std::vector<uint8_t> shapePointerDfxInfo;
//     L2PointerTensor shapePointerTensor;
//     shapePointerTensor.argsType =
//         static_cast<uint16_t>(DfxTensorType::OUTPUT_TENSOR) |
//         (static_cast<uint16_t>(DfxPointerType::LEVEL_2_POINTER_WITH_SHAPE) << POINTER_TYPE_SHIFT_BITS);
//     shapePointerTensor.size = NON_TENSOR_SIZE;
//     shapePointerTensor.dataTypeSize = 4;
//     generateDfxInfo(shapePointerDfxInfo, shapePointerTensor);
//     dfxInfoValue.insert(dfxInfoValue.end(), shapePointerDfxInfo.begin(), shapePointerDfxInfo.end());

//     // workspace
//     std::vector<uint8_t> workspaceDfxInfo;
//     WithSizeTensor workspaceTensor = {
//         static_cast<uint16_t>(DfxTensorType::WORKSPACE_TENSOR) |
//             (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
//         sizeof(workspace)};
//     generateDfxInfo(workspaceDfxInfo, workspaceTensor);
//     dfxInfoValue.insert(dfxInfoValue.end(), workspaceDfxInfo.begin(), workspaceDfxInfo.end());

//     // total dfxInfo
//     std::vector<uint8_t> dfxInfo;
//     uint16_t dfxInfoLength = static_cast<uint16_t>(dfxInfoValue.size());
//     generateDfxByLittleEndian(dfxInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX);
//     generateDfxByLittleEndian(dfxInfo, sizeof(uint16_t), dfxInfoLength);
//     dfxInfo.insert(dfxInfo.end(), dfxInfoValue.begin(), dfxInfoValue.end());
//     uint8_t *ptr = dfxInfo.data();
//     exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = ptr;
//     exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = dfxInfo.size();
//     exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.elfDataFlag = 1;

//     // test collect kernel .o .json file
//     (void)setenv("ASCEND_CACHE_PATH", ASCEND_CACHE_PATH, 1);
//     (void)setenv("ASCEND_CUSTOM_OPP_PATH", ASCEND_CUSTOM_OPP_PATH, 1);
//     char binData[] = "BIN_DATA";
//     exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(binData);
//     exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(binData);
//     std::string kernelName = "Custom_3ee04b5d550e4239498c29151be6bb5c_mix_aic";
//     exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
//     exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();

//     system("mkdir -p /tmp/adump_coredump_utest");
//     DumpCore dumpCore("/tmp/adump_coredump_utest", 0);
//     dumpCore.DumpCoreFile(exceptionInfo);
//     EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -t"));
//     EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -p .ascend.global"));
//     EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -p .ascend.host_kernel_object"));
//     EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -p .ascend.file_kernel_json"));
//     EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -p .ascend.file_kernel_object"));
//     EXPECT_EQ(0, system("readelf /tmp/adump_coredump_utest/*.core -p .ascend.local.1"));
//     system("rm -r /tmp/adump_coredump_utest");
// }