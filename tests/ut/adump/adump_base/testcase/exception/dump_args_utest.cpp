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
#include "case_workspace.h"
#include "dump_args.h"
#include "runtime/rt.h"
#include "adump_pub.h"
#include "dump_file.h"
#include "dump_manager.h"
#include "dump_file_checker.h"
#include "sys_utils.h"
#include "dump_memory.h"
#include "file.h"
#include "adx_exception_callback.h"
#include "lib_path.h"
#include "dump_tensor_plugin.h"
#include "thread_manager.h"
#include "hccl_mc2_define.h"
#include "ascend_hal.h"
#include "dump_exception_stub.h"

using namespace Adx;

#define ASCEND_CACHE_PATH ADUMP_BASE_DIR
#define ASCEND_CUSTOM_OPP_PATH "/src/dfx/adump:/tests/ut/adump:"

class DumpArgsUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        DumpManager::Instance().Reset();
        FreeExceptionRegInfo();
        GlobalMockObject::verify();
    }
};

TEST_F(DumpArgsUtest, Test_SizeInfoAddr_Check_Failed)
{
    Tools::CaseWorkspace ws("Test_SizeInfoAddr_Check_Failed");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();

    // test error dumpStatus
    dumpConf.dumpStatus = "normal";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::ARGS_EXCEPTION), false);

    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    rtExceptionInfo exceptionInfo = {0};
    exceptionInfo.streamid = 1;
    exceptionInfo.taskid = 1;
    exceptionInfo.deviceid = 1;
    char input0[] = "input0";
    uint64_t args[] = {reinterpret_cast<uint64_t>(&input0)};
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = nullptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = 0;

    uint32_t atomicIndex;
    uint64_t sizeInfo[] = {atomicIndex,
                           0x0F230,  //  62000
                           sizeof(input0)};
    auto sizeInfoAddr =
        static_cast<uint64_t *>(AdumpGetSizeInfoAddr(sizeof(sizeInfo) / sizeof(sizeInfo[0]), atomicIndex));
    auto sizeInfos = sizeInfoAddr;
    sizeInfo[0] = atomicIndex;
    for (const auto &size : sizeInfo) {
        *sizeInfos = size;
        sizeInfos++;
    }
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.infoAddr = sizeInfoAddr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.atomicIndex = atomicIndex;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.argsize = sizeof(args);
    exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.sizeInfo.infoAddr = sizeInfoAddr;
    exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.sizeInfo.atomicIndex = atomicIndex;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_FFTS_PLUS;
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    // over g_chunk + RING_CHUNK_SIZE - 1 address
    sizeInfoAddr += RING_CHUNK_SIZE - 1;
    exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.sizeInfo.infoAddr = sizeInfoAddr;
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(DumpArgsUtest, Test_DumpArgsExceptionInfo)
{
    Tools::CaseWorkspace ws("kernel_meta_Test_DumpArgsExceptionInfo");

    uint32_t deviceId = 1;
    std::string dumpPath = ws.Root();
    rtExceptionInfo exceptionInfo = {0};
    char hostKernel[] = "host kernel bin file stub";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "Custom_3ee04b5d550e4239498c29151be6bb5c_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;

    std::string fileName = "Custom_3ee04b5d550e4239498c29151be6bb5c_mix_aic.json";
    std::string value = "{\n\\\"kernelName\\\": \\\"AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic\\\"\n}";
    ws.Touch(fileName);
    ws.Echo(value, fileName, true, false);

    DumpArgs args;
    args.LoadArgsExceptionInfo(exceptionInfo);
    MOCKER(&DumpFile::Dump).stubs().will(returnValue(ADUMP_SUCCESS));
    // write host kernel failed
    MOCKER_CPP(&File::Write).stubs().will(returnValue((int64_t)EN_ERROR));
    int32_t ret = args.DumpArgsExceptionInfo(deviceId, dumpPath);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    // get bin buffer failed
    rtError_t rtError = -1;
    MOCKER(rtGetBinBuffer).stubs().will(returnValue(rtError));
    ret = args.DumpArgsExceptionInfo(deviceId, dumpPath);
    EXPECT_EQ(ret, ADUMP_FAILED);
    // open host kernel failed
    MOCKER_CPP(&File::Open).stubs().will(returnValue(ADUMP_FAILED));
    ret = args.DumpArgsExceptionInfo(deviceId, dumpPath);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(DumpArgsUtest, Test_DumpArgsJsonEmpty)
{
    Tools::CaseWorkspace ws("kernel_meta_Test_DumpArgsJsonEmpty");

    uint32_t deviceId = 1;
    std::string dumpPath = ws.Root();
    rtExceptionInfo exceptionInfo = {0};
    char hostKernel[] = "host kernel bin file stub";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_5ee04b5d550e4239498c29151be6bb5e_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;

    std::string fileName = "AddCustom_5ee04b5d550e4239498c29151be6bb5e_mix_aic.json";
    ws.Touch(fileName);
    DumpArgs args;
    args.LoadArgsExceptionInfo(exceptionInfo);
    MOCKER(&DumpFile::Dump).stubs().will(returnValue(ADUMP_SUCCESS));
    int32_t ret = args.DumpArgsExceptionInfo(deviceId, dumpPath);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(DumpArgsUtest, Test_DumpArgsJsonNotObject)
{
    Tools::CaseWorkspace ws("kernel_meta_Test_DumpArgsJsonNotObject");

    uint32_t deviceId = 1;
    std::string dumpPath = ws.Root();
    rtExceptionInfo exceptionInfo = {0};
    char hostKernel[] = "host kernel bin file stub";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_4ee04b5d550e4239498c29151be6bb5d_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;

    std::string fileName = "AddCustom_4ee04b5d550e4239498c29151be6bb5d_mix_aic.json";
    std::string value = "\\\"kernelName: AddCustom_4ee04b5d550e4239498c29151be6bb5d_mix_aic";
    ws.Touch(fileName);
    ws.Echo(value, fileName, true, false);

    DumpArgs args;
    args.LoadArgsExceptionInfo(exceptionInfo);
    MOCKER(&DumpFile::Dump).stubs().will(returnValue(ADUMP_SUCCESS));
    int32_t ret = args.DumpArgsExceptionInfo(deviceId, dumpPath);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    value = "\\\"kernelName\\\": AddCustom_4ee04b5d550e4239498c29151be6bb5d_mix_aic";
    ws.Echo(value, fileName, true, false);
    ret = args.DumpArgsExceptionInfo(deviceId, dumpPath);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    value = "\\\"kernelName\\\": \\\"AddCustom_4ee04b5d550e4239498c29151be6bb5d_mix_aic";
    ws.Echo(value, fileName, true, false);
    ret = args.DumpArgsExceptionInfo(deviceId, dumpPath);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(DumpArgsUtest, Test_DumpArgsJsonList)
{
    Tools::CaseWorkspace ws("kernel_meta_Test_DumpArgsJsonList");

    uint32_t deviceId = 1;
    std::string dumpPath = ws.Root();
    rtExceptionInfo exceptionInfo = {0};
    char hostKernel[] = "host kernel bin file stub";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;

    std::string fileName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic.json";
    std::string value = R"({
        \"kernelName\": \"Custom_6ee04b5d550e4239498c29151be6bb50\",
        \"kernelList\": [
            {
                \"kernelName\": \"AddCustom_6ee04b5d550e4239498c29151be6bb50\"
            }
        ]
    })";
    ws.Touch(fileName);
    ws.Echo(value, fileName, true, false);

    DumpArgs args;
    args.LoadArgsExceptionInfo(exceptionInfo);
    MOCKER(&DumpFile::Dump).stubs().will(returnValue(ADUMP_SUCCESS));
    MOCKER_CPP(&File::Copy).stubs().will(returnValue(ADUMP_SUCCESS));
    int32_t ret = args.DumpArgsExceptionInfo(deviceId, dumpPath);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(DumpArgsUtest, Test_DumpArgsDumpFileFailed)
{
    Tools::CaseWorkspace ws("kernel_meta_Test_DumpArgsDumpFileFailed");

    uint32_t deviceId = 1;
    std::string dumpPath = ws.Root();
    rtExceptionInfo exceptionInfo = {0};
    char hostKernel[] = "host kernel bin file stub";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6cc61_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;

    std::string fileName = "AddCustom_6ee04b5d550e4239498c29151be6cc61_mix_aic.json";
    std::string value = R"({
        \"kernelName\": \"Custom_6ee04b5d550e4239498c29151be6cc61\",
        \"kernelList\": [
            {
                \"kernelName\": \"AddCustom_6ee04b5d550e4239498c29151be6cc61\"
            }
        ]
    })";
    ws.Touch(fileName);
    ws.Echo(value, fileName, true, false);

    DumpArgs args;
    args.LoadArgsExceptionInfo(exceptionInfo);
    MOCKER(&DumpFile::Dump).stubs().will(returnValue(ADUMP_FAILED));
    MOCKER_CPP(&File::Copy).stubs().will(returnValue(ADUMP_SUCCESS));
    int32_t ret = args.DumpArgsExceptionInfo(deviceId, dumpPath);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(DumpArgsUtest, Test_DumpArgsDumpBinEmpty)
{
    Tools::CaseWorkspace ws("kernel_meta_Test_DumpArgsDumpBinEmpty");

    uint32_t deviceId = 1;
    std::string dumpPath = ws.Root();
    rtExceptionInfo exceptionInfo = {0};
    char hostKernel[] = "host kernel bin file stub";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = nullptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = 0;
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6cc61_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    DumpArgs args;
    args.LoadArgsExceptionInfo(exceptionInfo);
    MOCKER(&DumpFile::Dump).stubs().will(returnValue(ADUMP_SUCCESS));
    int32_t ret = args.DumpArgsExceptionInfo(deviceId, dumpPath);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(DumpArgsUtest, Test_DumpArgsJsonListFail)
{
    Tools::CaseWorkspace ws("kernel_meta_Test_DumpArgsJsonListFail");

    uint32_t deviceId = 1;
    std::string dumpPath = ws.Root();
    rtExceptionInfo exceptionInfo = {0};
    char hostKernel[] = "host kernel bin file stub";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_7ee04b5d550e4239498c29151be6bb51_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;

    std::string fileName = "AddCustom_7ee04b5d550e4239498c29151be6bb51_mix_aic.json";
    std::string value = R"({
        \"kernelList\": [
            \"array\": [\"first\", \"second\", \"third\"],
            AddCustom_7ee04b5d550e4239498c29151be6bb51_mix_aic
        ]
    })";
    ws.Touch(fileName);
    ws.Echo(value, fileName, true, false);

    DumpArgs args;
    args.LoadArgsExceptionInfo(exceptionInfo);
    MOCKER(&DumpFile::Dump).stubs().will(returnValue(ADUMP_SUCCESS));
    int32_t ret = args.DumpArgsExceptionInfo(deviceId, dumpPath);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

INT32 mmRealPathStub(const CHAR *path, CHAR *realPath, INT32 realPathLen)
{
    if (std::string(path) == std::string("AddCustom_8ee04b5d550e4239498c29151be6bb52_mix_aic.json")) {
        std::string cmd = "rm -fr " + std::string(path);
        system(cmd.c_str());
    }
    return EN_OK;
}

TEST_F(DumpArgsUtest, Test_DumpArgsFileCopyFailed)
{
    Tools::CaseWorkspace ws("kernel_meta_Test_DumpArgsFileCopyFailed");

    uint32_t deviceId = 1;
    std::string dumpPath = ws.Root();
    rtExceptionInfo exceptionInfo = {0};
    char hostKernel[] = "host kernel bin file stub";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;

    std::string fileName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic.json";
    std::string value = R"({
        \"kernelName\": \"Custom_6ee04b5d550e4239498c29151be6bb50\",
        \"kernelList\": [
            {
                \"kernelName\": \"AddCustom_6ee04b5d550e4239498c29151be6bb50\"
            }
        ]
    })";
    ws.Touch(fileName);
    ws.Echo(value, fileName, true, false);

    DumpArgs args;
    args.LoadArgsExceptionInfo(exceptionInfo);
    MOCKER(&DumpFile::Dump).stubs().will(returnValue(ADUMP_SUCCESS));
    MOCKER_CPP(&File::Copy).stubs().will(returnValue(Adx::ADUMP_FAILED));
    int32_t ret = args.DumpArgsExceptionInfo(deviceId, dumpPath);
    EXPECT_EQ(ret, Adx::ADUMP_SUCCESS);
}

TEST_F(DumpArgsUtest, Test_DumpArgsFileStatFailed)
{
    Tools::CaseWorkspace ws("kernel_meta_Test_DumpArgsFileStatFailed");

    uint32_t deviceId = 1;
    std::string dumpPath = ws.Root();
    rtExceptionInfo exceptionInfo = {0};
    char hostKernel[] = "host kernel bin file stub";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;

    std::string fileName = "AddCustom_6ee04b5d550e4239498c29151be6bb50_mix_aic.json";
    std::string value = R"({
        \"kernelName\": \"Custom_6ee04b5d550e4239498c29151be6bb50\",
        \"kernelList\": [
            {
                \"kernelName\": \"AddCustom_6ee04b5d550e4239498c29151be6bb50\"
            }
        ]
    })";
    ws.Touch(fileName);
    ws.Echo(value, fileName, true, false);

    DumpArgs args;
    args.LoadArgsExceptionInfo(exceptionInfo);
    MOCKER(&DumpFile::Dump).stubs().will(returnValue(ADUMP_SUCCESS));
    MOCKER(stat).stubs().will(returnValue(-1)).then(returnValue(0));
    int32_t ret = args.DumpArgsExceptionInfo(deviceId, dumpPath);
    EXPECT_EQ(ret, Adx::ADUMP_SUCCESS);
}

TEST_F(DumpArgsUtest, Test_DumpArgsFileOpenFailed)
{
    Tools::CaseWorkspace ws("kernel_meta_Test_DumpArgsFileOpenFailed");

    uint32_t deviceId = 1;
    std::string dumpPath = ws.Root();
    rtExceptionInfo exceptionInfo = {0};
    char hostKernel[] = "host kernel bin file stub";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_8ee04b5d550e4239498c29151be6bb52_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;

    std::string fileName = "AddCustom_8ee04b5d550e4239498c29151be6bb52_mix_aic.json";
    ws.Touch(fileName);

    DumpArgs args;
    args.LoadArgsExceptionInfo(exceptionInfo);
    MOCKER(&DumpFile::Dump).stubs().will(returnValue(ADUMP_SUCCESS));
    MOCKER(mmRealPath).stubs().will(invoke(mmRealPathStub));
    int32_t ret = args.DumpArgsExceptionInfo(deviceId, dumpPath);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(DumpArgsUtest, Test_Dump_Args)
{
    Tools::CaseWorkspace ws("kernel_meta_Test_Dump_Args");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    dumpConf.dumpSwitch = 1U << 2;  // exception dump with shape
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    rtExceptionInfo exceptionInfo = {0};
    exceptionInfo.streamid = 1;
    exceptionInfo.taskid = 1;
    exceptionInfo.deviceid = 1;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = nullptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = 0;
    std::string fileName = "AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic.json";
    std::string value = "{\n\\\"kernelName\\\": \\\"AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic.json\\\"\n}";
    ws.Touch(fileName);
    ws.Echo(value, fileName, true, false);
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

    sizeInfoAddr[4] = -16;
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    sizeInfoAddr[1] = 0x000000100000000D;
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.atomicIndex = atomicIndex - 1;
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    // test argsize is 0
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = 0;
    EXPECT_EQ(ADUMP_FAILED, DumpManager::Instance().DumpExceptionInfo(exceptionInfo));

    // test info addr is null
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.infoAddr = nullptr;
    EXPECT_EQ(ADUMP_FAILED, DumpManager::Instance().DumpExceptionInfo(exceptionInfo));

    // test exception type is not support
    exceptionInfo.expandInfo.type = RT_EXCEPTION_INVALID;
    EXPECT_EQ(ADUMP_FAILED, DumpManager::Instance().DumpExceptionInfo(exceptionInfo));

    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = nullptr;
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    sizeInfoAddr[1] = 0x000000010000000D;
    sizeInfoAddr[4] = -2;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.atomicIndex = atomicIndex;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.infoAddr = sizeInfoAddr;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    // test collect kernel .o .json file
    (void)setenv("ASCEND_CACHE_PATH", ASCEND_CACHE_PATH, 1);
    (void)setenv("ASCEND_CUSTOM_OPP_PATH", ASCEND_CUSTOM_OPP_PATH, 1);
    char hostKernel[] = "host kernel bin file stub";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);  // copy kernel bin file failed
    sleep(2);  // wait async process done

    // check host kernel file dump success
    Path hostKernelPath(ws.Root());
    std::string mixSuffix = "_mix_aic";
    std::string::size_type pos = kernelName.find(mixSuffix);
    if (pos != std::string::npos) {
        kernelName.replace(pos, mixSuffix.size(), "");
    }
    hostKernelPath.Concat("extra-info/data-dump")
        .Concat(std::to_string(exceptionInfo.deviceid))
        .Concat(kernelName + "_host.o");
    std::ifstream hostKernelFile(hostKernelPath.GetString());
    std::cout << hostKernelPath.GetString() << std::endl;
    EXPECT_EQ(hostKernelFile.good(), true);

    // check kernel json file dump success
    Path kernelJsonPath(ws.Root());
    kernelJsonPath.Concat("extra-info/data-dump")
        .Concat(std::to_string(exceptionInfo.deviceid))
        .Concat(kernelName + ".json");
    std::ifstream kernelJsonFile(kernelJsonPath.GetString());
    std::cout << kernelJsonPath.GetString() << std::endl;
    EXPECT_EQ(kernelJsonFile.good(), true);

    // check kernel file dump failed
    Path kernelPath(ws.Root());
    kernelPath.Concat("extra-info/data-dump").Concat(std::to_string(exceptionInfo.deviceid)).Concat(kernelName + ".o");
    std::ifstream kernelFile(kernelPath.GetString());
    std::cout << kernelPath.GetString() << std::endl;
    EXPECT_EQ(kernelFile.good(), false);

    // mock copy success
    MOCKER_CPP(&File::Copy).stubs().will(returnValue(ADUMP_SUCCESS));
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    // mock real path failed
    MOCKER(&DumpFile::Dump).stubs().will(returnValue(ADUMP_SUCCESS));
    MOCKER_CPP(&Path::RealPath).stubs().will(returnValue(false));
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    MOCKER_CPP(&File::Write).stubs().will(returnValue((int64_t)EN_ERROR));
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    EXPECT_EQ(AdumpIsDumpEnable(DumpType::ARGS_EXCEPTION), true);
    uint64_t dumpSwitch = 0;
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::ARGS_EXCEPTION, dumpSwitch), true);
    EXPECT_EQ(dumpSwitch, dumpConf.dumpSwitch);
    sleep(1);  // wait async process done
}

TEST_F(DumpArgsUtest, Test_Dump_Args_Quick_Recover)
{
    Tools::CaseWorkspace ws("kernel_meta_Test_Dump_Args_Recover");

    rtSetOpExecuteTimeOutWithMs(100);

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    dumpConf.dumpSwitch = 1U << 2;  // exception dump with shape
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    rtExceptionInfo exceptionInfo = {0};
    exceptionInfo.streamid = 1;
    exceptionInfo.taskid = 1;
    exceptionInfo.deviceid = 1;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = nullptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = 0;
    std::string fileName = "AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic.json";
    std::string value = "{\n\\\"kernelName\\\": \\\"AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic.json\\\"\n}";
    ws.Touch(fileName);
    ws.Echo(value, fileName, true, false);
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

    sizeInfoAddr[4] = -16;
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    rtSetOpExecuteTimeOutWithMs(18 * 60 * 1000);
}

TEST_F(DumpArgsUtest, Test_Dump_Args_OPP_Path)
{
    Tools::CaseWorkspace ws("kernel_meta_Test_Dump_Args_OPP_Path");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    dumpConf.dumpSwitch = 1U << 2;  // exception dump with shape
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    rtExceptionInfo exceptionInfo = {0};
    exceptionInfo.streamid = 1;
    exceptionInfo.taskid = 1;
    exceptionInfo.deviceid = 1;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = nullptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = 0;
    std::string fileName = "AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic.json";
    std::string value = "{\n\\\"kernelName\\\": \\\"AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic.json\\\"\n}";
    ws.Touch(fileName);
    ws.Echo(value, fileName, true, false);
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

    sizeInfoAddr[4] = -16;
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    sizeInfoAddr[1] = 0x000000100000000D;
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.atomicIndex = atomicIndex - 1;
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    // test argsize is 0
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = 0;
    EXPECT_EQ(ADUMP_FAILED, DumpManager::Instance().DumpExceptionInfo(exceptionInfo));

    // test info addr is null
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.infoAddr = nullptr;
    EXPECT_EQ(ADUMP_FAILED, DumpManager::Instance().DumpExceptionInfo(exceptionInfo));

    // test exception type is not support
    exceptionInfo.expandInfo.type = RT_EXCEPTION_INVALID;
    EXPECT_EQ(ADUMP_FAILED, DumpManager::Instance().DumpExceptionInfo(exceptionInfo));

    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = nullptr;
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    sizeInfoAddr[1] = 0x000000010000000D;
    sizeInfoAddr[4] = -2;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.atomicIndex = atomicIndex;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.infoAddr = sizeInfoAddr;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    // test collect kernel .o .json file
    (void)setenv("ASCEND_OPP_PATH", ADUMP_BASE_DIR, 1);
    (void)setenv("ASCEND_WORK_PATH", ADUMP_BASE_DIR "ASCEND_WORK_PATH", 1);
    char hostKernel[] = "host kernel bin file stub";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);  // copy kernel bin file failed
    sleep(2);  // wait async process done

    // check host kernel file dump success
    Path hostKernelPath(ws.Root());
    std::string mixSuffix = "_mix_aic";
    std::string::size_type pos = kernelName.find(mixSuffix);
    if (pos != std::string::npos) {
        kernelName.replace(pos, mixSuffix.size(), "");
    }
    hostKernelPath.Concat("extra-info/data-dump")
        .Concat(std::to_string(exceptionInfo.deviceid))
        .Concat(kernelName + "_host.o");
    std::ifstream hostKernelFile(hostKernelPath.GetString());
    std::cout << hostKernelPath.GetString() << std::endl;
    EXPECT_EQ(hostKernelFile.good(), true);

    // check kernel json file dump success
    Path kernelJsonPath(ws.Root());
    kernelJsonPath.Concat("extra-info/data-dump")
        .Concat(std::to_string(exceptionInfo.deviceid))
        .Concat(kernelName + ".json");
    std::ifstream kernelJsonFile(kernelJsonPath.GetString());
    std::cout << kernelJsonPath.GetString() << std::endl;
    EXPECT_EQ(kernelJsonFile.good(), true);

    // check kernel file dump failed
    Path kernelPath(ws.Root());
    kernelPath.Concat("extra-info/data-dump").Concat(std::to_string(exceptionInfo.deviceid)).Concat(kernelName + ".o");
    std::ifstream kernelFile(kernelPath.GetString());
    std::cout << kernelPath.GetString() << std::endl;
    EXPECT_EQ(kernelFile.good(), false);

    // mock copy success
    MOCKER_CPP(&File::Copy).stubs().will(returnValue(ADUMP_SUCCESS));
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    // mock real path failed
    MOCKER(&DumpFile::Dump).stubs().will(returnValue(ADUMP_SUCCESS));
    MOCKER_CPP(&Path::RealPath).stubs().will(returnValue(false));
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    MOCKER_CPP(&File::Write).stubs().will(returnValue((int64_t)EN_ERROR));
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    EXPECT_EQ(AdumpIsDumpEnable(DumpType::ARGS_EXCEPTION), true);
    uint64_t dumpSwitch = 0;
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::ARGS_EXCEPTION, dumpSwitch), true);
    EXPECT_EQ(dumpSwitch, dumpConf.dumpSwitch);
    sleep(1);  // wait async process done
}

TEST_F(DumpArgsUtest, Test_Dump_Ffts_Args)
{
    Tools::CaseWorkspace ws("Test_Dump_Ffts_Args");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    rtExceptionInfo exceptionInfo = {0};
    exceptionInfo.streamid = 1;
    exceptionInfo.taskid = 1;
    exceptionInfo.deviceid = 1;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_FFTS_PLUS;
    exceptionInfo.expandInfo.u.fftsPlusInfo.contextId = 2;
    exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = nullptr;
    exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.exceptionKernelInfo.dfxSize = 0;
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
    exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.argsize = sizeof(args);

    uint32_t atomicIndex;
    uint64_t sizeInfo[] = {atomicIndex,
                           20,
                           1,  // context 1
                           0,  // argSize
                           0x0000000100000001,
                           1,
                           2,  // context 2
                           sizeof(args),
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
    exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.sizeInfo.infoAddr = sizeInfoAddr;
    exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.sizeInfo.atomicIndex = atomicIndex;
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

void generateDfxByBigEndian(std::vector<uint8_t> &vec, size_t typeSize, uint64_t value)
{
    for (size_t i = 0; i < typeSize; ++i) {
        uint8_t tmpValue = static_cast<uint8_t>(((value) >> ((typeSize - i - 1) * 8)) & 0xFF);
        vec.push_back(tmpValue);
    }
}

void generateDfxByLittleEndian(std::vector<uint8_t> &vec, size_t typeSize, uint64_t value)
{
    for (size_t i = 0; i < typeSize; ++i) {
        uint8_t tmpValue = static_cast<uint8_t>(((value) >> (i * 8)) & 0xFF);
        vec.push_back(tmpValue);
    }
}

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
void generateDfxInfoWithError(std::vector<uint8_t> &dfxInfo, T &tensor, uint16_t numOfArgInfo,
                              uint16_t argsInfoType = TYPE_L0_EXCEPTION_DFX_ARGS_INFO)
{
    std::vector<uint8_t> tensorDfxInfo;
    auto *p = reinterpret_cast<uint64_t *>(&tensor);
    for (size_t i = 0; i < sizeof(tensor) / sizeof(uint64_t); ++i) {
        generateDfxByBigEndian(tensorDfxInfo, sizeof(uint64_t), *(p + i));
    }
    ArgInfoHead head = {argsInfoType, numOfArgInfo};
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

/* == dlopen test == */
static int32_t HeadProcessTest(uint32_t devId, const void *addr, uint64_t headerSize, uint64_t &newHeaderSize)
{
    (void)devId;
    (void)addr;
    newHeaderSize = headerSize + 1;
    return 0;
}

static int32_t TensorProcessTest(uint32_t devId, const void *addr, uint64_t size, int32_t fd)
{
    (void)devId;
    (void)addr;
    (void)size;
    (void)fd;
    return 0;
}

int32_t AdumpPluginInitStub()
{
    AdumpRegHeadProcess(DfxTensorType::MC2_CTX, &HeadProcessTest);
    AdumpRegTensorProcess(DfxTensorType::MC2_CTX, &TensorProcessTest);
    return 0;
}

void *mmDlsym(void *handle, const char* funcName)
{
    if (strcmp(funcName, "AdumpPluginInit") == 0) {
        return (void *)&AdumpPluginInitStub;
    }
    return nullptr;
}

char *mmDlerror(void)
{
    return "None";
}

int32_t g_handle;
void * mmDlopen(const char *filename, int mode)
{
    (void)mode;
    if (strcmp(filename + strlen(filename) - strlen("plugin.so"), "plugin.so") == 0) {
        return &g_handle;
    }
    return nullptr;
}
/* == dlopen test == */

static HcclCombinOpParam g_combinOpParam;
static uint8_t workSpaceData[128] = {1,2,3,4,5};
static IbVerbsData g_ibVerbsData;

TEST_F(DumpArgsUtest, Test_Dump_Args_With_Dfx_Static)
{
    g_combinOpParam.mc2WorkSpace =  {(uint64_t)&workSpaceData, 128};
    g_combinOpParam.rankId = 0;
    g_combinOpParam.winSize = 128;
    g_combinOpParam.windowsIn[g_combinOpParam.rankId] = (uint64_t)&workSpaceData;
    g_combinOpParam.windowsOut[g_combinOpParam.rankId] = (uint64_t)&workSpaceData;
    g_ibVerbsData.localInput = {128, (uint64_t)&workSpaceData, 0};
    g_ibVerbsData.localOutput = {128, (uint64_t)&workSpaceData, 0};
    g_combinOpParam.ibverbsData = (uint64_t)&g_ibVerbsData;
    g_combinOpParam.ibverbsDataSize = sizeof(g_ibVerbsData);

    std::string currPath = ADUMP_BASE_DIR "stub/plugin/adump";
    MOCKER_CPP(&LibPath::GetTargetPath).stubs().will(returnValue(currPath));
    MOCKER(dlopen).stubs().will(invoke(mmDlopen));
    MOCKER(dlsym).stubs().will(invoke(mmDlsym));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    MOCKER(&Adx::KernelInfoCollector::ParseKernelSymbols).stubs().will(invoke(Adx::ParseKernelSymbolsStub));
    Tools::CaseWorkspace ws("Test_Dump_Args_With_Dfx_Static");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);
    uint32_t v2type = 5;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));

    rtExceptionInfo exceptionInfo = {0};
    exceptionInfo.streamid = 1;
    exceptionInfo.taskid = 1;
    exceptionInfo.deviceid = 1;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_FUSION;
    char fftsAddr[] = "ffts addr";
    int32_t tensor[] = {1, 2, 3, 4, 5, 6};
    float input0[] = {1, 2, 3, 4, 5, 6};
    float output0[] = {2, 4, 6, 8, 10, 12};
    int32_t placehold[] = {1, 1, 1, 1, 1, 1, 1, 1};
    int32_t normalPtr1[] = {10, 20, 30};
    int32_t normalPtr2[] = {40, 50, 60};
    int32_t shapePtr2t3[] = {2, 2, 2, 3, 3, 3};
    int32_t shapePtrPlaceHold[] = {0, 0, 0};
    int32_t shapePtrScalar[] = {123456};
    int32_t workspace[] = {100, 100, 100};
    uint64_t args[22] = {};
    args[0] = reinterpret_cast<uint64_t>(&fftsAddr);
    args[1] = reinterpret_cast<uint64_t>(&tensor);
    args[2] = reinterpret_cast<uint64_t>(&input0);
    args[3] = reinterpret_cast<uint64_t>(&output0);
    args[4] = reinterpret_cast<uint64_t>(&placehold);
    args[7] = reinterpret_cast<uint64_t>(&workspace);
    args[8] = reinterpret_cast<uint64_t>(&g_combinOpParam);
    args[9] = reinterpret_cast<uint64_t>(&normalPtr1);
    args[10] = reinterpret_cast<uint64_t>(&normalPtr2);
    args[5] = reinterpret_cast<uint64_t>(&args[9]);
    args[11] = sizeof(uint64_t) * 8;
    args[6] = reinterpret_cast<uint64_t>(&args[11]);
    args[12] = 2 | (1ULL << TENSOR_COUNT_SHIFT_BITS);
    args[13] = 2;
    args[14] = 3;
    args[15] = 2 | (1ULL << TENSOR_COUNT_SHIFT_BITS);
    args[16] = 1024;
    args[17] = 0;
    args[18] = 0 | (1ULL << TENSOR_COUNT_SHIFT_BITS);
    args[19] = reinterpret_cast<uint64_t>(&shapePtr2t3);
    args[20] = reinterpret_cast<uint64_t>(&shapePtrPlaceHold);
    args[21] = reinterpret_cast<uint64_t>(&shapePtrScalar);

    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.argsize = sizeof(args);

    std::vector<uint8_t> dfxInfoValue;

    // ffts addr
    std::vector<uint8_t> fftsAddrDfxInfo;
    WithoutSizeTensor fftsAddrTensor = {
        static_cast<uint16_t>(DfxTensorType::FFTS_ADDRESS) |
        (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS)};
    generateDfxInfo(fftsAddrDfxInfo, fftsAddrTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), fftsAddrDfxInfo.begin(), fftsAddrDfxInfo.end());
    std::vector<uint8_t> fftsAddrDfxInfoExtern;
    uint16_t externArgsInfoType = 6;
    generateDfxInfo(fftsAddrDfxInfoExtern, fftsAddrTensor, externArgsInfoType);
    dfxInfoValue.insert(dfxInfoValue.end(), fftsAddrDfxInfoExtern.begin(), fftsAddrDfxInfoExtern.end());

    // general tensor
    std::vector<uint8_t> tensorDfxInfo;
    StaticL1PointerTensor generalTensor;
    generalTensor.argsType = static_cast<uint16_t>(DfxTensorType::GENERAL_TENSOR) |
                             (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    generalTensor.size = sizeof(tensor);
    generalTensor.dim = 2;
    generalTensor.shape = {3, 2};
    generateDfxInfo(tensorDfxInfo, generalTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), tensorDfxInfo.begin(), tensorDfxInfo.end());

    // input0
    std::vector<uint8_t> inputDfxInfo;
    StaticL1PointerTensor inputTensor;
    inputTensor.argsType = static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
                           (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    inputTensor.size = sizeof(input0);
    inputTensor.dim = 2;
    inputTensor.shape = {3, 2};
    generateDfxInfo(inputDfxInfo, inputTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), inputDfxInfo.begin(), inputDfxInfo.end());

    // output0
    std::vector<uint8_t> outputDfxInfo;
    StaticL1PointerTensor outputTensor;
    outputTensor.argsType = static_cast<uint16_t>(DfxTensorType::OUTPUT_TENSOR) |
                            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    outputTensor.size = sizeof(input0);
    outputTensor.dim = 2;
    outputTensor.shape = {2, 3};
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

    // mc2Space
    std::vector<uint8_t> mc2SpaceDfxInfo;
    WithoutSizeTensor mc2SpaceTensor = {
        static_cast<uint16_t>(DfxTensorType::MC2_CTX) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS)};
    generateDfxInfo(mc2SpaceDfxInfo, mc2SpaceTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), mc2SpaceDfxInfo.begin(), mc2SpaceDfxInfo.end());

    // total dfxInfo
    std::vector<uint8_t> dfxInfo;
    std::vector<uint8_t> kernelTypeDfxInfo;
    std::vector<uint8_t> exceptionDfxInfo;
    uint16_t dfxKernelType = 1;
    uint16_t dfxInfoLength = static_cast<uint16_t>(dfxInfoValue.size());
    generateDfxByLittleEndian(kernelTypeDfxInfo, sizeof(uint16_t), dfxKernelType);
    generateDfxByLittleEndian(kernelTypeDfxInfo, sizeof(uint16_t), dfxInfoLength);
    kernelTypeDfxInfo.insert(kernelTypeDfxInfo.end(), dfxInfoValue.begin(), dfxInfoValue.end());
    generateDfxByLittleEndian(exceptionDfxInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX);
    generateDfxByLittleEndian(exceptionDfxInfo, sizeof(uint16_t), dfxInfoLength);
    exceptionDfxInfo.insert(exceptionDfxInfo.end(), dfxInfoValue.begin(), dfxInfoValue.end());
    dfxInfo.insert(dfxInfo.end(), kernelTypeDfxInfo.begin(), kernelTypeDfxInfo.end());
    dfxInfo.insert(dfxInfo.end(), exceptionDfxInfo.begin(), exceptionDfxInfo.end());

    uint8_t *ptr = dfxInfo.data();
    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = ptr;
    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.exceptionKernelInfo.dfxSize = dfxInfo.size();
    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.exceptionKernelInfo.elfDataFlag = 1;

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    std::string expectDumpFilePath = ExpectedArgsDumpFilePath(ws.Root(), exceptionInfo.deviceid, exceptionInfo.streamid,
                                                              exceptionInfo.taskid, stubNowTime);
    DumpFileChecker checker;
    EXPECT_EQ(checker.Load(expectDumpFilePath), true);
    EXPECT_EQ(checker.CheckInputTensorNum(3), true);
    EXPECT_EQ(checker.CheckOutputTensorNum(4), true);
    EXPECT_EQ(checker.CheckWorkspaceNum(2), true);

    // general tensor
    EXPECT_EQ(checker.CheckInputTensorSize(0, sizeof(tensor)), true);
    EXPECT_EQ(checker.CheckInputTensorData(0, GetTensorData(tensor)), true);
    EXPECT_EQ(checker.CheckInputTensorShape(0, {3, 2}), true);

    // input0
    EXPECT_EQ(checker.CheckInputTensorSize(1, sizeof(input0)), true);
    EXPECT_EQ(checker.CheckInputTensorData(1, GetTensorData(input0)), true);
    EXPECT_EQ(checker.CheckInputTensorShape(1, {3, 2}), true);

    // placehold
    EXPECT_EQ(checker.CheckInputTensorSize(2, 0), true);
    EXPECT_EQ(checker.CheckInputTensorShape(2, {4, 2}), true);

    // output0
    EXPECT_EQ(checker.CheckOutputTensorSize(0, sizeof(output0)), true);
    EXPECT_EQ(checker.CheckOutputTensorData(0, GetTensorData(output0)), true);
    EXPECT_EQ(checker.CheckOutputTensorShape(0, {2, 3}), true);

    // shape pointer
    EXPECT_EQ(checker.CheckOutputTensorSize(1, sizeof(shapePtr2t3)), true);
    EXPECT_EQ(checker.CheckOutputTensorData(1, GetTensorData(shapePtr2t3)), true);
    EXPECT_EQ(checker.CheckOutputTensorShape(1, {2, 3}), true);

    EXPECT_EQ(checker.CheckOutputTensorSize(2, 0), true);
    EXPECT_EQ(checker.CheckOutputTensorShape(2, {1024, 0}), true);

    EXPECT_EQ(checker.CheckOutputTensorSize(3, sizeof(shapePtrScalar)), true);
    EXPECT_EQ(checker.CheckOutputTensorData(3, GetTensorData(shapePtrScalar)), true);

    // workspace
    EXPECT_EQ(checker.CheckWorkspaceSize(0, sizeof(workspace)), true);
    EXPECT_EQ(checker.CheckWorkspaceData(0, GetTensorData(workspace)), true);

    // mc2_ctx
    // workspace + windowsIn + windowsOut + ibverbsData struct + ibverbsData data localInput + ibverbsData data localOutput
    size_t totalSize = sizeof(HcclCombinOpParam) + 128 + 128 + 128 + sizeof(g_ibVerbsData) + 128 + 128;
    std::vector<uint8_t> mc2Data(0, totalSize);
    mc2Data.insert(mc2Data.end(), reinterpret_cast<uint8_t*>(&g_combinOpParam), reinterpret_cast<uint8_t*>(&g_combinOpParam) + sizeof(HcclCombinOpParam));
    mc2Data.insert(mc2Data.end(), reinterpret_cast<uint8_t*>(&workSpaceData), reinterpret_cast<uint8_t*>(&workSpaceData) + 128);    // workspace
    mc2Data.insert(mc2Data.end(), reinterpret_cast<uint8_t*>(&workSpaceData), reinterpret_cast<uint8_t*>(&workSpaceData) + 128);    // windowsIn
    mc2Data.insert(mc2Data.end(), reinterpret_cast<uint8_t*>(&workSpaceData), reinterpret_cast<uint8_t*>(&workSpaceData) + 128);    // windowsOut
    mc2Data.insert(mc2Data.end(), reinterpret_cast<uint8_t*>(&g_ibVerbsData), reinterpret_cast<uint8_t*>(&g_ibVerbsData) + sizeof(g_ibVerbsData));    // ibverbsData struct
    mc2Data.insert(mc2Data.end(), reinterpret_cast<uint8_t*>(&workSpaceData), reinterpret_cast<uint8_t*>(&workSpaceData) + 128);    // ibverbsData data localInput
    mc2Data.insert(mc2Data.end(), reinterpret_cast<uint8_t*>(&workSpaceData), reinterpret_cast<uint8_t*>(&workSpaceData) + 128);    // ibverbsData data localOutput
    EXPECT_EQ(checker.CheckWorkspaceSize(1, totalSize), true);
    EXPECT_EQ(checker.CheckWorkspaceData(1, mc2Data), true);

    uint64_t headerSize = 0;
    uint64_t newHeaderSize = 0;
    EXPECT_EQ(0, DumpTensorPlugin::Instance().NotifyHeadCallback(DfxTensorType::MC2_CTX, 0, nullptr, headerSize,
        newHeaderSize));
    EXPECT_EQ(1, newHeaderSize);
    EXPECT_EQ(0, DumpTensorPlugin::Instance().NotifyTensorCallback(DfxTensorType::MC2_CTX, 0, nullptr, 0, 0));
}

TEST_F(DumpArgsUtest, Test_Dump_Args_With_Dfx_Dynamic)
{
    Tools::CaseWorkspace ws("Test_Dump_Args_With_Dfx_Dynamic");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);
    uint32_t v2type = 5;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
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
    int32_t placehold[] = {1, 1, 1, 1, 1, 1, 1, 1};
    int32_t normalPtr1[] = {10, 20, 30};
    int32_t normalPtr2[] = {40, 50, 60};
    int32_t shapePtr2t3[] = {2, 2, 2, 3, 3, 3};
    int32_t shapePtrPlaceHold[] = {0, 0, 0};
    int32_t shapePtrScalar[] = {123456};
    int32_t workspace[] = {100, 100, 100};
    uint64_t tilingData = 300;

    uint64_t tensorSize = sizeof(tensor);
    uint64_t input0Size = sizeof(input0);
    uint64_t output0Size = sizeof(output0);
    uint64_t placeholdSize = 0;
    uint64_t workspaceSize = sizeof(workspace);
    uint64_t tensorDim = 2;
    uint64_t tensorShape0 = 3;
    uint64_t tensorShape1 = 2;
    uint64_t input0Dim = 2;
    uint64_t input0Shape0 = 3;
    uint64_t input0Shape1 = 2;
    uint64_t output0Dim = 2;
    uint64_t output0Shape0 = 2;
    uint64_t output0Shape1 = 3;

    uint64_t atomicIndex = 0;
    uint64_t *shapeAddr = static_cast<uint64_t *>(AdumpGetDFXInfoAddrForDynamic(15, atomicIndex));
    shapeAddr[0] = tensorSize;
    shapeAddr[1] = input0Size;
    shapeAddr[2] = output0Size;
    shapeAddr[3] = placeholdSize;
    shapeAddr[4] = sizeof(uint64_t) * 11;  // shape ptr dynamic inputs size
    shapeAddr[5] = workspaceSize;
    shapeAddr[6] = tensorDim;
    shapeAddr[7] = tensorShape0;
    shapeAddr[8] = tensorShape1;
    shapeAddr[9] = input0Dim;
    shapeAddr[10] = input0Shape0;
    shapeAddr[11] = input0Shape1;
    shapeAddr[12] = output0Dim;
    shapeAddr[13] = output0Shape0;
    shapeAddr[14] = output0Shape1;

    uint64_t args[27] = {};
    args[0] = reinterpret_cast<uint64_t>(&fftsAddr);
    args[1] = reinterpret_cast<uint64_t>(&tensor);
    args[2] = reinterpret_cast<uint64_t>(&input0);
    args[3] = reinterpret_cast<uint64_t>(&output0);
    args[4] = reinterpret_cast<uint64_t>(&placehold);
    args[7] = reinterpret_cast<uint64_t>(&workspace);
    args[9] = tilingData;
    args[8] = reinterpret_cast<uint64_t>(&args[9]);
    args[10] = atomicIndex;
    args[11] = reinterpret_cast<uint64_t>(&normalPtr1);
    args[12] = reinterpret_cast<uint64_t>(&normalPtr2);
    args[5] = reinterpret_cast<uint64_t>(&args[11]);
    args[13] = sizeof(uint64_t) * 10;  // offset
    args[6] = reinterpret_cast<uint64_t>(&args[13]);
    args[14] = 2 | (2ULL << TENSOR_COUNT_SHIFT_BITS);
    args[15] = 2;
    args[16] = 3;
    args[17] = 2 | (1ULL << TENSOR_COUNT_SHIFT_BITS);
    args[18] = 1024;
    args[19] = 0;
    args[20] = 0 | (1ULL << TENSOR_COUNT_SHIFT_BITS);
    args[21] = 0;  // empty shape info
    args[22] = 0;  // empty shape info
    args[23] = reinterpret_cast<uint64_t>(&shapePtr2t3);
    args[24] = reinterpret_cast<uint64_t>(&shapePtr2t3);
    args[25] = reinterpret_cast<uint64_t>(&shapePtrPlaceHold);
    args[26] = reinterpret_cast<uint64_t>(&shapePtrScalar);
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
    WithSizeTensor generalTensor = {
        static_cast<uint16_t>(DfxTensorType::GENERAL_TENSOR) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        NON_TENSOR_SIZE};
    generateDfxInfo(tensorDfxInfo, generalTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), tensorDfxInfo.begin(), tensorDfxInfo.end());

    // input0
    std::vector<uint8_t> inputDfxInfo;
    WithSizeTensor inputTensor = {
        static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        NON_TENSOR_SIZE};
    generateDfxInfo(inputDfxInfo, inputTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), inputDfxInfo.begin(), inputDfxInfo.end());

    // output0
    std::vector<uint8_t> outputDfxInfo;
    WithSizeTensor outputTensor = {
        static_cast<uint16_t>(DfxTensorType::OUTPUT_TENSOR) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        NON_TENSOR_SIZE};
    generateDfxInfo(outputDfxInfo, outputTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), outputDfxInfo.begin(), outputDfxInfo.end());

    // placehold
    std::vector<uint8_t> placeholdDfxInfo;
    WithSizeTensor placeholdTensor = {
        static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        NON_TENSOR_SIZE};
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
    WithoutSizeTensor workspaceTensor = {
        static_cast<uint16_t>(DfxTensorType::WORKSPACE_TENSOR) |
        (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS)};
    generateDfxInfo(workspaceDfxInfo, workspaceTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), workspaceDfxInfo.begin(), workspaceDfxInfo.end());

    // tiling data
    std::vector<uint8_t> tilingDataDfxInfo;
    WithSizeTensor tilingDataTensor = {
        static_cast<uint16_t>(DfxTensorType::TILING_DATA) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        sizeof(tilingData) + sizeof(atomicIndex)};
    generateDfxInfo(tilingDataDfxInfo, tilingDataTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), tilingDataDfxInfo.begin(), tilingDataDfxInfo.end());

    // total dfxInfo
    std::vector<uint8_t> dfxInfo;
    uint16_t dfxInfoLength = static_cast<uint16_t>(dfxInfoValue.size());
    generateDfxByBigEndian(dfxInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX);
    generateDfxByBigEndian(dfxInfo, sizeof(uint16_t), dfxInfoLength);
    dfxInfo.insert(dfxInfo.end(), dfxInfoValue.begin(), dfxInfoValue.end());
    uint8_t *ptr = dfxInfo.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = ptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = dfxInfo.size();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.elfDataFlag = ELF_DATA2MSB;

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    std::string expectDumpFilePath = ExpectedArgsDumpFilePath(ws.Root(), exceptionInfo.deviceid, exceptionInfo.streamid,
                                                              exceptionInfo.taskid, stubNowTime);
    DumpFileChecker checker;
    EXPECT_EQ(checker.Load(expectDumpFilePath), true);
    EXPECT_EQ(checker.CheckInputTensorNum(4), true);
    EXPECT_EQ(checker.CheckOutputTensorNum(5), true);
    EXPECT_EQ(checker.CheckWorkspaceNum(1), true);

    // general tensor
    EXPECT_EQ(checker.CheckInputTensorSize(0, sizeof(tensor)), true);
    EXPECT_EQ(checker.CheckInputTensorData(0, GetTensorData(tensor)), true);
    EXPECT_EQ(checker.CheckInputTensorShape(0, {3, 2}), true);

    // input0
    EXPECT_EQ(checker.CheckInputTensorSize(1, sizeof(input0)), true);
    EXPECT_EQ(checker.CheckInputTensorData(1, GetTensorData(input0)), true);
    EXPECT_EQ(checker.CheckInputTensorShape(1, {3, 2}), true);

    // placehold
    EXPECT_EQ(checker.CheckInputTensorSize(2, 0), true);

    // output0
    EXPECT_EQ(checker.CheckOutputTensorSize(0, sizeof(output0)), true);
    EXPECT_EQ(checker.CheckOutputTensorData(0, GetTensorData(output0)), true);
    EXPECT_EQ(checker.CheckOutputTensorShape(0, {2, 3}), true);

    // shape pointer
    EXPECT_EQ(checker.CheckOutputTensorSize(1, sizeof(shapePtr2t3)), true);
    EXPECT_EQ(checker.CheckOutputTensorData(1, GetTensorData(shapePtr2t3)), true);
    EXPECT_EQ(checker.CheckOutputTensorShape(1, {2, 3}), true);

    EXPECT_EQ(checker.CheckOutputTensorSize(2, sizeof(shapePtr2t3)), true);
    EXPECT_EQ(checker.CheckOutputTensorData(2, GetTensorData(shapePtr2t3)), true);
    EXPECT_EQ(checker.CheckOutputTensorShape(2, {2, 3}), true);

    EXPECT_EQ(checker.CheckOutputTensorSize(3, 0), true);
    EXPECT_EQ(checker.CheckOutputTensorShape(3, {1024, 0}), true);

    EXPECT_EQ(checker.CheckOutputTensorSize(4, sizeof(shapePtrScalar)), true);
    EXPECT_EQ(checker.CheckOutputTensorData(4, GetTensorData(shapePtrScalar)), true);

    // workspace
    EXPECT_EQ(checker.CheckWorkspaceSize(0, sizeof(workspace)), true);
    EXPECT_EQ(checker.CheckWorkspaceData(0, GetTensorData(workspace)), true);

    // tiling data
    EXPECT_EQ(checker.CheckInputTensorSize(3, sizeof(tilingData) + sizeof(atomicIndex)), true);
    uint64_t tmpTilingData[2] = {tilingData, atomicIndex};
    EXPECT_EQ(checker.CheckInputTensorData(3, GetTensorData(tmpTilingData)), true);
}

TEST_F(DumpArgsUtest, Test_Dump_Args_With_Dfx_Static_Failed)
{
    Tools::CaseWorkspace ws("Test_Dump_Args_With_Dfx_Static_Failed");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    rtExceptionInfo exceptionInfo = {0};
    exceptionInfo.streamid = 1;
    exceptionInfo.taskid = 1;
    exceptionInfo.deviceid = 1;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    char fftsAddr[] = "ffts addr";
    int32_t tensor[] = {1, 2, 3, 4, 5, 6};
    float input0[] = {1, 2, 3, 4, 5, 6};
    float output0[] = {2, 4, 6, 8, 10, 12};
    int32_t placehold[] = {1, 1, 1, 1, 1, 1, 1, 1};

    std::vector<uint8_t> dfxInfoValue;

    // ffts addr
    std::vector<uint8_t> fftsAddrDfxInfo;
    WithoutSizeTensor fftsAddrTensor = {
        static_cast<uint16_t>(DfxTensorType::FFTS_ADDRESS) |
        (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS)};
    generateDfxInfo(fftsAddrDfxInfo, fftsAddrTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), fftsAddrDfxInfo.begin(), fftsAddrDfxInfo.end());
    std::vector<uint8_t> fftsAddrDfxInfoExtern;
    uint16_t externArgsInfoType = 6;
    generateDfxInfo(fftsAddrDfxInfoExtern, fftsAddrTensor, externArgsInfoType);
    dfxInfoValue.insert(dfxInfoValue.end(), fftsAddrDfxInfoExtern.begin(), fftsAddrDfxInfoExtern.end());

    // general tensor
    std::vector<uint8_t> tensorDfxInfo;
    StaticL1PointerTensor generalTensor;
    generalTensor.argsType = static_cast<uint16_t>(DfxTensorType::GENERAL_TENSOR) |
                             (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    generalTensor.size = sizeof(tensor);
    generalTensor.dim = 2;
    generalTensor.shape = {3, 2};
    generateDfxInfo(tensorDfxInfo, generalTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), tensorDfxInfo.begin(), tensorDfxInfo.end());

    // input0
    std::vector<uint8_t> inputDfxInfo;
    StaticL1PointerTensor inputTensor;
    inputTensor.argsType = static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
                           (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    inputTensor.size = sizeof(input0);
    inputTensor.dim = 2;
    inputTensor.shape = {3, 2};
    generateDfxInfo(inputDfxInfo, inputTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), inputDfxInfo.begin(), inputDfxInfo.end());

    // output0 with large arg info num
    std::vector<uint8_t> outputDfxInfo;
    StaticL1PointerTensor outputTensor;
    outputTensor.argsType = static_cast<uint16_t>(DfxTensorType::OUTPUT_TENSOR) |
                            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    outputTensor.size = sizeof(input0);
    outputTensor.dim = 2;
    outputTensor.shape = {2, 3};
    uint16_t numOfArgInfo = (sizeof(StaticL1PointerTensor) / sizeof(uint64_t)) + 1;
    generateDfxInfoWithError(outputDfxInfo, outputTensor, numOfArgInfo);
    dfxInfoValue.insert(dfxInfoValue.end(), outputDfxInfo.begin(), outputDfxInfo.end());

    // total dfxInfo
    std::vector<uint8_t> dfxInfo;
    std::vector<uint8_t> kernelTypeDfxInfo;
    std::vector<uint8_t> exceptionDfxInfo;
    uint16_t dfxKernelType = 1;
    uint16_t dfxInfoLength = static_cast<uint16_t>(dfxInfoValue.size());
    generateDfxByLittleEndian(kernelTypeDfxInfo, sizeof(uint16_t), dfxKernelType);
    generateDfxByLittleEndian(kernelTypeDfxInfo, sizeof(uint16_t), dfxInfoLength);
    kernelTypeDfxInfo.insert(kernelTypeDfxInfo.end(), dfxInfoValue.begin(), dfxInfoValue.end());
    generateDfxByLittleEndian(exceptionDfxInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX);
    generateDfxByLittleEndian(exceptionDfxInfo, sizeof(uint16_t), dfxInfoLength);
    exceptionDfxInfo.insert(exceptionDfxInfo.end(), dfxInfoValue.begin(), dfxInfoValue.end());
    dfxInfo.insert(dfxInfo.end(), kernelTypeDfxInfo.begin(), kernelTypeDfxInfo.end());
    dfxInfo.insert(dfxInfo.end(), exceptionDfxInfo.begin(), exceptionDfxInfo.end());

    // test no exception dfx
    uint8_t *ptr = kernelTypeDfxInfo.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = ptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = kernelTypeDfxInfo.size();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.elfDataFlag = 1;

    uint64_t args[4] = {};
    args[0] = reinterpret_cast<uint64_t>(&fftsAddr);
    args[1] = reinterpret_cast<uint64_t>(&tensor);
    args[2] = reinterpret_cast<uint64_t>(&input0);
    args[3] = reinterpret_cast<uint64_t>(&output0);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    ptr = dfxInfo.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = ptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = dfxInfo.size();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.elfDataFlag = 1;

    // test current dfx size larger than dfx size
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    // test arg index out of max arg index
    uint64_t args1[3] = {};
    args1[0] = reinterpret_cast<uint64_t>(&fftsAddr);
    args1[1] = reinterpret_cast<uint64_t>(&tensor);
    args1[2] = reinterpret_cast<uint64_t>(&input0);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args1;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args1);
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    // test output0 with zero arg info num
    std::vector<uint8_t> dfxInfoValue1;
    std::vector<uint8_t> outputDfxInfo1;
    StaticL1PointerTensor outputTensor1;
    outputTensor1.argsType = static_cast<uint16_t>(DfxTensorType::OUTPUT_TENSOR) |
                             (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    outputTensor1.size = sizeof(input0);
    outputTensor1.dim = 2;
    outputTensor1.shape = {2, 3};
    generateDfxInfoWithError(outputDfxInfo1, outputTensor1, 0);
    dfxInfoValue1.insert(dfxInfoValue1.end(), outputDfxInfo1.begin(), outputDfxInfo1.end());

    std::vector<uint8_t> exceptionDfxInfo1;
    dfxInfoLength = static_cast<uint16_t>(dfxInfoValue1.size());
    generateDfxByLittleEndian(exceptionDfxInfo1, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX);
    generateDfxByLittleEndian(exceptionDfxInfo1, sizeof(uint16_t), dfxInfoLength);
    exceptionDfxInfo1.insert(exceptionDfxInfo1.end(), dfxInfoValue1.begin(), dfxInfoValue1.end());

    ptr = exceptionDfxInfo1.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = ptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = exceptionDfxInfo1.size();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.elfDataFlag = 1;

    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(DumpArgsUtest, Test_Dump_Args_With_Dfx_Tik_Dynamic)
{
    Tools::CaseWorkspace ws("Test_Dump_Args_With_Dfx_Tik_Dynamic");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    rtExceptionInfo exceptionInfo = {0};
    exceptionInfo.streamid = 1;
    exceptionInfo.taskid = 1;
    exceptionInfo.deviceid = 1;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    char fftsAddr[] = "ffts addr";
    int32_t tensor[] = {1, 2, 3, 4, 5, 6};
    float input0[] = {1, 2, 3, 4, 5, 6};
    float output0[] = {2, 4, 6, 8, 10, 12};
    int32_t workspace[] = {100, 100, 100};
    uint64_t tilingData[] = {300, 400, 500};

    uint64_t tensorSize = sizeof(tensor);
    uint64_t input0Size = sizeof(input0);
    uint64_t output0Size = sizeof(output0);
    uint64_t workspaceSize = sizeof(workspace);
    uint64_t tensorDim = 2;
    uint64_t tensorShape0 = 3;
    uint64_t tensorShape1 = 2;
    uint64_t input0Dim = 2;
    uint64_t input0Shape0 = 3;
    uint64_t input0Shape1 = 2;
    uint64_t output0Dim = 2;
    uint64_t output0Shape0 = 2;
    uint64_t output0Shape1 = 3;

    uint64_t atomicIndex = 0;
    uint64_t *shapeAddr = static_cast<uint64_t *>(AdumpGetDFXInfoAddrForStatic(13, atomicIndex));
    shapeAddr[0] = tensorSize;
    shapeAddr[1] = input0Size;
    shapeAddr[2] = output0Size;
    shapeAddr[3] = workspaceSize;
    shapeAddr[4] = tensorDim;
    shapeAddr[5] = tensorShape0;
    shapeAddr[6] = tensorShape1;
    shapeAddr[7] = input0Dim;
    shapeAddr[8] = input0Shape0;
    shapeAddr[9] = input0Shape1;
    shapeAddr[10] = output0Dim;
    shapeAddr[11] = output0Shape0;
    shapeAddr[12] = output0Shape1;

    uint64_t args[9] = {};
    args[0] = reinterpret_cast<uint64_t>(&tensor);
    args[1] = reinterpret_cast<uint64_t>(&input0);
    args[2] = reinterpret_cast<uint64_t>(&output0);
    args[3] = reinterpret_cast<uint64_t>(&workspace);
    args[5] = tilingData[0];
    args[6] = tilingData[1];
    args[7] = tilingData[2];
    args[4] = reinterpret_cast<uint64_t>(&args[5]);
    args[8] = atomicIndex;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);

    std::vector<uint8_t> dfxInfoValue;

    // general tensor
    std::vector<uint8_t> tensorDfxInfo;
    WithSizeTensor generalTensor = {
        static_cast<uint16_t>(DfxTensorType::GENERAL_TENSOR) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        NON_TENSOR_SIZE};
    generateDfxInfo(tensorDfxInfo, generalTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), tensorDfxInfo.begin(), tensorDfxInfo.end());

    // input0
    std::vector<uint8_t> inputDfxInfo;
    WithSizeTensor inputTensor = {
        static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        NON_TENSOR_SIZE};
    generateDfxInfo(inputDfxInfo, inputTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), inputDfxInfo.begin(), inputDfxInfo.end());

    // output0
    std::vector<uint8_t> outputDfxInfo;
    WithSizeTensor outputTensor = {
        static_cast<uint16_t>(DfxTensorType::OUTPUT_TENSOR) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        NON_TENSOR_SIZE};
    generateDfxInfo(outputDfxInfo, outputTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), outputDfxInfo.begin(), outputDfxInfo.end());

    // workspace
    std::vector<uint8_t> workspaceDfxInfo;
    WithoutSizeTensor workspaceTensor = {
        static_cast<uint16_t>(DfxTensorType::WORKSPACE_TENSOR) |
        (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS)};
    generateDfxInfo(workspaceDfxInfo, workspaceTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), workspaceDfxInfo.begin(), workspaceDfxInfo.end());

    // tiling data
    std::vector<uint8_t> tilingDataDfxInfo;
    WithSizeTensor tilingDataTensor = {
        static_cast<uint16_t>(DfxTensorType::TILING_DATA) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        sizeof(tilingData) + sizeof(atomicIndex)};
    generateDfxInfo(tilingDataDfxInfo, tilingDataTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), tilingDataDfxInfo.begin(), tilingDataDfxInfo.end());

    // total dfxInfo
    std::vector<uint8_t> dfxInfo;

    std::vector<uint8_t> tikInfo;
    uint32_t tikValue = 1;
    generateDfxByLittleEndian(tikInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX_IS_TIK);
    generateDfxByLittleEndian(tikInfo, sizeof(uint16_t), sizeof(tikValue));
    generateDfxByLittleEndian(tikInfo, sizeof(uint32_t), tikValue);
    dfxInfo.insert(dfxInfo.end(), tikInfo.begin(), tikInfo.end());

    uint16_t dfxInfoLength = static_cast<uint16_t>(dfxInfoValue.size());
    generateDfxByLittleEndian(dfxInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX);
    generateDfxByLittleEndian(dfxInfo, sizeof(uint16_t), dfxInfoLength);
    dfxInfo.insert(dfxInfo.end(), dfxInfoValue.begin(), dfxInfoValue.end());
    uint8_t *ptr = dfxInfo.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = ptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = dfxInfo.size();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.elfDataFlag = 1;

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    std::string expectDumpFilePath = ExpectedArgsDumpFilePath(ws.Root(), exceptionInfo.deviceid, exceptionInfo.streamid,
                                                              exceptionInfo.taskid, stubNowTime);
    DumpFileChecker checker;
    EXPECT_EQ(checker.Load(expectDumpFilePath), true);
    EXPECT_EQ(checker.CheckInputTensorNum(3), true);
    EXPECT_EQ(checker.CheckOutputTensorNum(1), true);
    EXPECT_EQ(checker.CheckWorkspaceNum(1), true);

    // general tensor
    EXPECT_EQ(checker.CheckInputTensorSize(0, sizeof(tensor)), true);
    EXPECT_EQ(checker.CheckInputTensorData(0, GetTensorData(tensor)), true);
    EXPECT_EQ(checker.CheckInputTensorShape(0, {3, 2}), true);

    // input0
    EXPECT_EQ(checker.CheckInputTensorSize(1, sizeof(input0)), true);
    EXPECT_EQ(checker.CheckInputTensorData(1, GetTensorData(input0)), true);
    EXPECT_EQ(checker.CheckInputTensorShape(1, {3, 2}), true);

    // output0
    EXPECT_EQ(checker.CheckOutputTensorSize(0, sizeof(output0)), true);
    EXPECT_EQ(checker.CheckOutputTensorData(0, GetTensorData(output0)), true);
    EXPECT_EQ(checker.CheckOutputTensorShape(0, {2, 3}), true);

    // workspace
    EXPECT_EQ(checker.CheckWorkspaceSize(0, sizeof(workspace)), true);
    EXPECT_EQ(checker.CheckWorkspaceData(0, GetTensorData(workspace)), true);

    // tiling data
    EXPECT_EQ(checker.CheckInputTensorSize(2, sizeof(tilingData) + sizeof(atomicIndex)), true);
    uint64_t tmpTilingData[4] = {tilingData[0], tilingData[1], tilingData[2], atomicIndex};
    EXPECT_EQ(checker.CheckInputTensorData(2, GetTensorData(tmpTilingData)), true);
}

TEST_F(DumpArgsUtest, Test_Dump_Args_With_Dfx_Failed)
{
    Tools::CaseWorkspace ws("Test_Dump_Args_With_Dfx_Failed");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    rtExceptionInfo exceptionInfo = {0};
    exceptionInfo.streamid = 1;
    exceptionInfo.taskid = 1;
    exceptionInfo.deviceid = 1;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    char fftsAddr[] = "ffts addr";
    int32_t tensor[] = {1, 2, 3, 4, 5, 6};
    float input0[] = {1, 2, 3, 4, 5, 6};
    float output0[] = {2, 4, 6, 8, 10, 12};
    int32_t workspace[] = {100, 100, 100};
    uint64_t tilingData[] = {300, 400, 500};

    uint64_t tensorSize = sizeof(tensor);
    uint64_t input0Size = sizeof(input0);
    uint64_t output0Size = sizeof(output0);
    uint64_t workspaceSize = sizeof(workspace);
    uint64_t tensorDim = 2;
    uint64_t tensorShape0 = 3;
    uint64_t tensorShape1 = 2;
    uint64_t input0Dim = 2;
    uint64_t input0Shape0 = 3;
    uint64_t input0Shape1 = 2;
    uint64_t output0Dim = 3;  // test error shape
    uint64_t output0Shape0 = 2;
    uint64_t output0Shape1 = 3;

    uint64_t atomicIndex = 0;
    // get addr failed
    void *addr = AdumpGetDFXInfoAddrForDynamic(DFX_MAX_TENSOR_NUM + 1, atomicIndex);
    EXPECT_EQ(addr, nullptr);
    addr = AdumpGetDFXInfoAddrForStatic(DFX_MAX_TENSOR_NUM + 1, atomicIndex);
    EXPECT_EQ(addr, nullptr);

    uint64_t *shapeAddr = static_cast<uint64_t *>(AdumpGetDFXInfoAddrForDynamic(13, atomicIndex));
    shapeAddr[0] = tensorSize;
    shapeAddr[1] = input0Size;
    shapeAddr[2] = output0Size;
    shapeAddr[3] = workspaceSize;
    shapeAddr[4] = tensorDim;
    shapeAddr[5] = tensorShape0;
    shapeAddr[6] = tensorShape1;
    shapeAddr[7] = input0Dim;
    shapeAddr[8] = input0Shape0;
    shapeAddr[9] = input0Shape1;
    shapeAddr[10] = output0Dim;
    shapeAddr[11] = output0Shape0;
    shapeAddr[12] = output0Shape1;

    std::vector<uint8_t> dfxInfoValue;

    // general tensor
    std::vector<uint8_t> tensorDfxInfo;
    WithSizeTensor generalTensor = {
        static_cast<uint16_t>(DfxTensorType::GENERAL_TENSOR) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        NON_TENSOR_SIZE};
    generateDfxInfo(tensorDfxInfo, generalTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), tensorDfxInfo.begin(), tensorDfxInfo.end());

    // input0
    std::vector<uint8_t> inputDfxInfo;
    WithSizeTensor inputTensor = {
        static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        NON_TENSOR_SIZE};
    generateDfxInfo(inputDfxInfo, inputTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), inputDfxInfo.begin(), inputDfxInfo.end());

    // output0
    std::vector<uint8_t> outputDfxInfo;
    WithSizeTensor outputTensor = {
        static_cast<uint16_t>(DfxTensorType::OUTPUT_TENSOR) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        NON_TENSOR_SIZE};
    generateDfxInfo(outputDfxInfo, outputTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), outputDfxInfo.begin(), outputDfxInfo.end());

    // workspace
    std::vector<uint8_t> workspaceDfxInfo;
    WithoutSizeTensor workspaceTensor = {
        static_cast<uint16_t>(DfxTensorType::WORKSPACE_TENSOR) |
        (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS)};
    generateDfxInfo(workspaceDfxInfo, workspaceTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), workspaceDfxInfo.begin(), workspaceDfxInfo.end());

    // tiling data
    std::vector<uint8_t> tilingDataDfxInfo;
    WithSizeTensor tilingDataTensor = {
        static_cast<uint16_t>(DfxTensorType::TILING_DATA) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        sizeof(tilingData) + sizeof(atomicIndex)};
    generateDfxInfo(tilingDataDfxInfo, tilingDataTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), tilingDataDfxInfo.begin(), tilingDataDfxInfo.end());

    // total dfxInfo
    std::vector<uint8_t> dfxInfo;

    std::vector<uint8_t> tikInfo;
    uint32_t tikValue = 0;
    generateDfxByLittleEndian(tikInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX_IS_TIK);
    generateDfxByLittleEndian(tikInfo, sizeof(uint16_t), sizeof(tikValue));
    generateDfxByLittleEndian(tikInfo, sizeof(uint32_t), tikValue);
    dfxInfo.insert(dfxInfo.end(), tikInfo.begin(), tikInfo.end());

    uint16_t dfxInfoLength = static_cast<uint16_t>(dfxInfoValue.size());
    generateDfxByLittleEndian(dfxInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX);
    generateDfxByLittleEndian(dfxInfo, sizeof(uint16_t), dfxInfoLength);
    dfxInfo.insert(dfxInfo.end(), dfxInfoValue.begin(), dfxInfoValue.end());
    uint8_t *ptr = dfxInfo.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = ptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = dfxInfo.size();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.elfDataFlag = 1;

    uint64_t args[9] = {};
    args[0] = reinterpret_cast<uint64_t>(&tensor);
    args[1] = reinterpret_cast<uint64_t>(&input0);
    args[2] = reinterpret_cast<uint64_t>(&output0);
    args[3] = reinterpret_cast<uint64_t>(&workspace);
    args[5] = tilingData[0];
    args[6] = tilingData[1];
    args[7] = tilingData[2];
    args[4] = reinterpret_cast<uint64_t>(&args[5]);
    args[8] = atomicIndex;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);

    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    // atomicIndex check failed
    uint64_t atomicIndexErr = atomicIndex | 0x040000000;
    args[8] = atomicIndexErr;
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    // space check failed
    uint32_t offset = static_cast<uint32_t>(atomicIndex & 0x0FFFFFF);
    g_dynamicChunk[offset] += DFX_MAX_TENSOR_NUM + 1;
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    // magic check failed
    g_dynamicChunk[offset] &= 0x0FFFFFFFF;
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    // offset check failed
    atomicIndexErr = atomicIndex + DYNAMIC_RING_CHUNK_SIZE;
    args[8] = atomicIndexErr;
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    // chunk addr null
    uint64_t *dynamicChunkBak = g_dynamicChunk;
    g_dynamicChunk = nullptr;
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);
    g_dynamicChunk = dynamicChunkBak;

    // tilling data address is nullptr
    args[4] = reinterpret_cast<uint64_t>(nullptr);
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(DumpArgsUtest, Test_Dump_Args_With_Dfx_Dynamic_Failed)
{
    Tools::CaseWorkspace ws("Test_Dump_Args_With_Dfx_Dynamic_Failed");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    rtExceptionInfo exceptionInfo = {0};
    exceptionInfo.streamid = 1;
    exceptionInfo.taskid = 1;
    exceptionInfo.deviceid = 1;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    char fftsAddr[] = "ffts addr";
    int32_t tensor[] = {1, 2, 3, 4, 5, 6};
    float input0[] = {1, 2, 3, 4, 5, 6};
    uint64_t tilingData = 300;

    uint64_t args[5] = {};
    args[0] = reinterpret_cast<uint64_t>(&fftsAddr);
    args[2] = tilingData;
    args[1] = reinterpret_cast<uint64_t>(&args[2]);
    args[3] = reinterpret_cast<uint64_t>(&tensor);
    args[4] = reinterpret_cast<uint64_t>(&input0);
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

    // tiling data with 0 size
    std::vector<uint8_t> tilingDataDfxInfo;
    WithSizeTensor tilingDataTensor = {
        static_cast<uint16_t>(DfxTensorType::TILING_DATA) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        0};
    generateDfxInfo(tilingDataDfxInfo, tilingDataTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), tilingDataDfxInfo.begin(), tilingDataDfxInfo.end());

    // general tensor
    std::vector<uint8_t> tensorDfxInfo;
    WithSizeTensor generalTensor = {
        static_cast<uint16_t>(DfxTensorType::GENERAL_TENSOR) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        NON_TENSOR_SIZE};
    generateDfxInfo(tensorDfxInfo, generalTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), tensorDfxInfo.begin(), tensorDfxInfo.end());

    // input0 with zero args num
    std::vector<uint8_t> inputDfxInfo;
    WithSizeTensor inputTensor = {
        static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        NON_TENSOR_SIZE};
    generateDfxInfoWithError(inputDfxInfo, inputTensor, 0);
    dfxInfoValue.insert(dfxInfoValue.end(), inputDfxInfo.begin(), inputDfxInfo.end());

    // total dfxInfo
    std::vector<uint8_t> dfxInfo;
    uint16_t dfxInfoLength = static_cast<uint16_t>(dfxInfoValue.size());
    generateDfxByBigEndian(dfxInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX);
    generateDfxByBigEndian(dfxInfo, sizeof(uint16_t), dfxInfoLength);
    dfxInfo.insert(dfxInfo.end(), dfxInfoValue.begin(), dfxInfoValue.end());
    uint8_t *ptr = dfxInfo.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = ptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = dfxInfo.size();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.elfDataFlag = ELF_DATA2MSB;

    // check tiling data size failed
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    void *nullHostMem = nullptr;
    MOCKER(&DumpMemory::CopyDeviceToHost).stubs().will(returnValue(nullHostMem));
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(DumpArgsUtest, Test_Dump_Args_Register)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/tmp";
    dumpConf.dumpStatus = "on";
    MOCKER(rtRegTaskFailCallbackByModule).stubs().will(returnValue(ADUMP_FAILED));
    DumpManager::Instance().Reset();
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);
}

TEST_F(DumpArgsUtest, Test_Dump_Args_Config)
{
    DumpConfig dumpConf;
    dumpConf.dumpPath = "/path/to/dump/dir";
    dumpConf.dumpStatus = "on";
    DumpManager::Instance().Reset();
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);
}

int32_t halGetVdevNumStub(uint32_t *num_dev)
{
    *num_dev = 1;
    return 0;
}

int32_t halGetVdevIDsStub(uint32_t *devices, uint32_t len)
{
    (void)devices;
    (void)len;
    return 0;
}

static rtError_t rtGetSocVersionStub(char *version, const uint32_t maxLen)
{
    strcpy_s(version, maxLen, "Ascend910_9381");
    return RT_ERROR_NONE;
}

static HcclOpResParam g_opResParam;
TEST_F(DumpArgsUtest, Test_Dump_Args_For_MC2_CTX_910C)
{
    uint32_t v2type = 5; // CHIP_CLOUD_V2
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    MOCKER(rtGetSocVersion).stubs().will(invoke(rtGetSocVersionStub));
    MOCKER(&Adx::KernelInfoCollector::ParseKernelSymbols).stubs().will(invoke(Adx::ParseKernelSymbolsStub));

    Tools::CaseWorkspace ws("Test_Dump_Args_For_MC2_CTX");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    rtExceptionInfo exceptionInfo = {0};
    exceptionInfo.streamid = 1;
    exceptionInfo.taskid = 1;
    exceptionInfo.deviceid = 1;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    char fftsAddr[] = "ffts addr";
    uint64_t tilingData[] = {300, 400, 500};

    uint64_t mc2CtxSize = sizeof(g_opResParam);
    uint64_t tensorDim = 2;
    uint64_t tensorShape0 = 3;
    uint64_t tensorShape1 = 2;
    uint64_t input0Dim = 2;
    uint64_t input0Shape0 = 3;
    uint64_t input0Shape1 = 2;
    uint64_t output0Dim = 2;
    uint64_t output0Shape0 = 2;
    uint64_t output0Shape1 = 3;

    uint64_t atomicIndex = 0;
    uint64_t *shapeAddr = static_cast<uint64_t *>(AdumpGetDFXInfoAddrForDynamic(14, atomicIndex));
    shapeAddr[0] = mc2CtxSize;
    shapeAddr[1] = tensorDim;
    shapeAddr[2] = tensorShape0;
    shapeAddr[3] = tensorShape1;
    shapeAddr[4] = input0Dim;
    shapeAddr[5] = input0Shape0;
    shapeAddr[6] = input0Shape1;
    shapeAddr[7] = output0Dim;
    shapeAddr[8] = output0Shape0;
    shapeAddr[9] = output0Shape1;

    uint64_t args[6] = {};
    args[0] = reinterpret_cast<uint64_t>(&g_opResParam);
    args[1] = reinterpret_cast<uint64_t>(&args[2]);
    args[2] = tilingData[0];
    args[3] = tilingData[1];
    args[4] = tilingData[2];
    args[5] = atomicIndex;

    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);

    std::vector<uint8_t> dfxInfoValue;

    // mc2_ctx
    std::vector<uint8_t> mc2CtxDfxInfo;
    WithoutSizeTensor mc2CtxTensor = {
        static_cast<uint16_t>(DfxTensorType::MC2_CTX) |
        (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS)};
    generateDfxInfo(mc2CtxDfxInfo, mc2CtxTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), mc2CtxDfxInfo.begin(), mc2CtxDfxInfo.end());

    // tiling data
    std::vector<uint8_t> tilingDataDfxInfo;
    WithSizeTensor tilingDataTensor = {
        static_cast<uint16_t>(DfxTensorType::TILING_DATA) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        sizeof(tilingData) + sizeof(atomicIndex)};
    generateDfxInfo(tilingDataDfxInfo, tilingDataTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), tilingDataDfxInfo.begin(), tilingDataDfxInfo.end());

    // total dfxInfo
    std::vector<uint8_t> dfxInfo;

    std::vector<uint8_t> tikInfo;
    uint32_t tikValue = 1;
    generateDfxByLittleEndian(tikInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX_IS_TIK);
    generateDfxByLittleEndian(tikInfo, sizeof(uint16_t), sizeof(tikValue));
    generateDfxByLittleEndian(tikInfo, sizeof(uint32_t), tikValue);
    dfxInfo.insert(dfxInfo.end(), tikInfo.begin(), tikInfo.end());

    uint16_t dfxInfoLength = static_cast<uint16_t>(dfxInfoValue.size());
    generateDfxByLittleEndian(dfxInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX);
    generateDfxByLittleEndian(dfxInfo, sizeof(uint16_t), dfxInfoLength);
    dfxInfo.insert(dfxInfo.end(), dfxInfoValue.begin(), dfxInfoValue.end());
    uint8_t *ptr = dfxInfo.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = ptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = dfxInfo.size();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.elfDataFlag = 1;

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    std::string expectDumpFilePath = ExpectedArgsDumpFilePath(ws.Root(), exceptionInfo.deviceid, exceptionInfo.streamid,
                                                              exceptionInfo.taskid, stubNowTime);
    DumpFileChecker checker;
    EXPECT_EQ(checker.Load(expectDumpFilePath), true);
    EXPECT_EQ(checker.CheckWorkspaceNum(1), true);

    // mc2_ctx
    std::vector<uint8_t> vecData(reinterpret_cast<uint8_t*>(&g_opResParam),
                              reinterpret_cast<uint8_t*>(&g_opResParam) + sizeof(HcclOpResParam));
    EXPECT_EQ(checker.CheckWorkspaceSize(0, sizeof(g_opResParam)), true);
    EXPECT_EQ(checker.CheckWorkspaceData(0, vecData), true);

    // tiling data
    EXPECT_EQ(checker.CheckInputTensorSize(0, sizeof(tilingData) + sizeof(atomicIndex)), true);
    uint64_t tmpTilingData[4] = {tilingData[0], tilingData[1], tilingData[2], atomicIndex};
    EXPECT_EQ(checker.CheckInputTensorData(0, GetTensorData(tmpTilingData)), true);
}

TEST_F(DumpArgsUtest, Test_Dump_Args_Multi_Thread)
{
    Tools::CaseWorkspace ws("Test_Dump_Args_Multi_Thread");
    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    dumpConf.dumpSwitch = 1U << 2;  // exception dump with shape
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    rtExceptionInfo exceptionInfo = {0};
    exceptionInfo.streamid = 1;
    exceptionInfo.taskid = 1;
    exceptionInfo.deviceid = 1;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = nullptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = 0;
    std::string fileName = "AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic.json";
    std::string value = "{\n\\\"kernelName\\\": \\\"AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic.json\\\"\n}";
    ws.Touch(fileName);
    ws.Echo(value, fileName, true, false);
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
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.atomicIndex = atomicIndex;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.infoAddr = sizeInfoAddr;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    // test collect kernel .o .json file
    (void)setenv("ASCEND_CACHE_PATH", ASCEND_CACHE_PATH, 1);
    (void)setenv("ASCEND_CUSTOM_OPP_PATH", ASCEND_CUSTOM_OPP_PATH, 1);
    char hostKernel[] = "host kernel bin file stub";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(hostKernel);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
    std::string kernelName = "AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();
    // multi thread collect same kernel files.
    int32_t ret = 0;
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    //multi thread collect different kernel files.
    rtExceptionInfo exceptionInfo2 = exceptionInfo;
    std::string kernelName2 = "te_gatherv2_e0258b0a6b5321e318fc35";
    exceptionInfo2.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName2.data();
    exceptionInfo2.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName2.size();
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo2);
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(DumpArgsUtest, Test_Dump_Args_For_L2_Shape)
{
    std::string currPath = ADUMP_BASE_DIR "stub/plugin/adump";
    MOCKER_CPP(&LibPath::GetTargetPath).stubs().will(returnValue(currPath));
    MOCKER(dlopen).stubs().will(invoke(mmDlopen));
    MOCKER(dlsym).stubs().will(invoke(mmDlsym));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER(dlerror).stubs().will(invoke(mmDlerror));

    Tools::CaseWorkspace ws("Test_Dump_Args_For_L2_Shape", false);

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);
    uint32_t v4type = 15; // diff with 910B/310P
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4type)).will(returnValue(true));

    rtExceptionInfo exceptionInfo = {0};
    exceptionInfo.streamid = 1;
    exceptionInfo.taskid = 1;
    exceptionInfo.deviceid = 1;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_FUSION;
    int32_t shapePtr2t3[] = {2, 2, 2, 3, 3, 3};
    int32_t shapePtr2t2Float4[] = {0x12345678, 0x43218765};   // shape: 4*4, 16bit
    int32_t shapePtrPlaceHold[] = {0, 0, 0};
    int32_t shapePtrScalar[] = {123456};
    uint64_t args[19] = {};
    // shape tensor for float4
    args[2] = sizeof(uint64_t) * 4;
    args[0] = reinterpret_cast<uint64_t>(&args[2]);
    args[3] = 2 | (1ULL << TENSOR_COUNT_SHIFT_BITS);
    args[4] = 4;
    args[5] = 4;
    args[6] = reinterpret_cast<uint64_t>(&shapePtr2t2Float4);

    // shape tensor 2
    args[8] = sizeof(uint64_t) * 8;
    args[1] = reinterpret_cast<uint64_t>(&args[8]);
    args[9] = 2 | (1ULL << TENSOR_COUNT_SHIFT_BITS);
    args[10] = 2;
    args[11] = 3;
    args[12] = 2 | (1ULL << TENSOR_COUNT_SHIFT_BITS);
    args[13] = 1024;
    args[14] = 0;
    args[15] = 0 | (1ULL << TENSOR_COUNT_SHIFT_BITS);
    args[16] = reinterpret_cast<uint64_t>(&shapePtr2t3);
    args[17] = reinterpret_cast<uint64_t>(&shapePtrPlaceHold);
    args[18] = reinterpret_cast<uint64_t>(&shapePtrScalar);

    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.argsize = sizeof(args);

    std::vector<uint8_t> dfxInfoValue;

    // shape pointer 1
    std::vector<uint8_t> shapePointerDfxInfo;
    L2PointerTensor shapePointerTensor;
    shapePointerTensor.argsType =
        static_cast<uint16_t>(DfxTensorType::OUTPUT_TENSOR) |
        (static_cast<uint16_t>(DfxPointerType::LEVEL_2_POINTER_WITH_SHAPE) << POINTER_TYPE_SHIFT_BITS);
    shapePointerTensor.size = NON_TENSOR_SIZE;
    shapePointerTensor.dataTypeSize = 4;   // unit: bit
    generateDfxInfo(shapePointerDfxInfo, shapePointerTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), shapePointerDfxInfo.begin(), shapePointerDfxInfo.end());

    // shape pointer 2
    std::vector<uint8_t> shapePointerDfxInfo2;
    L2PointerTensor shapePointerTensor2;
    shapePointerTensor2.argsType =
        static_cast<uint16_t>(DfxTensorType::OUTPUT_TENSOR) |
        (static_cast<uint16_t>(DfxPointerType::LEVEL_2_POINTER_WITH_SHAPE) << POINTER_TYPE_SHIFT_BITS);
    shapePointerTensor2.size = NON_TENSOR_SIZE;
    shapePointerTensor2.dataTypeSize = 4 * 8; //unit: bit
    generateDfxInfo(shapePointerDfxInfo2, shapePointerTensor2);
    dfxInfoValue.insert(dfxInfoValue.end(), shapePointerDfxInfo2.begin(), shapePointerDfxInfo2.end());

    // total dfxInfo
    std::vector<uint8_t> dfxInfo;
    std::vector<uint8_t> kernelTypeDfxInfo;
    std::vector<uint8_t> exceptionDfxInfo;
    uint16_t dfxKernelType = 1;
    uint16_t dfxInfoLength = static_cast<uint16_t>(dfxInfoValue.size());
    generateDfxByLittleEndian(kernelTypeDfxInfo, sizeof(uint16_t), dfxKernelType);
    generateDfxByLittleEndian(kernelTypeDfxInfo, sizeof(uint16_t), dfxInfoLength);
    kernelTypeDfxInfo.insert(kernelTypeDfxInfo.end(), dfxInfoValue.begin(), dfxInfoValue.end());
    generateDfxByLittleEndian(exceptionDfxInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX);
    generateDfxByLittleEndian(exceptionDfxInfo, sizeof(uint16_t), dfxInfoLength);
    exceptionDfxInfo.insert(exceptionDfxInfo.end(), dfxInfoValue.begin(), dfxInfoValue.end());
    dfxInfo.insert(dfxInfo.end(), kernelTypeDfxInfo.begin(), kernelTypeDfxInfo.end());
    dfxInfo.insert(dfxInfo.end(), exceptionDfxInfo.begin(), exceptionDfxInfo.end());

    uint8_t *ptr = dfxInfo.data();
    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = ptr;
    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.exceptionKernelInfo.dfxSize = dfxInfo.size();
    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.exceptionKernelInfo.elfDataFlag = 1;

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    std::string expectDumpFilePath = ExpectedArgsDumpFilePath(ws.Root(), exceptionInfo.deviceid, exceptionInfo.streamid,
                                                              exceptionInfo.taskid, stubNowTime);
    DumpFileChecker checker;
    EXPECT_TRUE(checker.Load(expectDumpFilePath));
    EXPECT_TRUE(checker.CheckOutputTensorNum(4));

    // shape pointer float4
    EXPECT_TRUE(checker.CheckOutputTensorSize(0, sizeof(shapePtr2t2Float4)));
    EXPECT_TRUE(checker.CheckOutputTensorData(0, GetTensorData(shapePtr2t2Float4)));
    EXPECT_TRUE(checker.CheckOutputTensorShape(0, {4, 4}));

    // shape pointer normal
    EXPECT_EQ(checker.CheckOutputTensorSize(1, sizeof(shapePtr2t3)), true);
    EXPECT_EQ(checker.CheckOutputTensorData(1, GetTensorData(shapePtr2t3)), true);
    EXPECT_EQ(checker.CheckOutputTensorShape(1, {2, 3}), true);

    EXPECT_EQ(checker.CheckOutputTensorSize(2, 0), true);
    EXPECT_EQ(checker.CheckOutputTensorShape(2, {1024, 0}), true);

    EXPECT_EQ(checker.CheckOutputTensorSize(3, sizeof(shapePtrScalar)), true);
    EXPECT_EQ(checker.CheckOutputTensorData(3, GetTensorData(shapePtrScalar)), true);
}