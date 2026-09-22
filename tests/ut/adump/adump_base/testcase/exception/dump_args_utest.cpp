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
#include "adump_platform_manager.h"
#include "ascend_hal.h"
#include "dump_exception_stub.h"
#include "kernel_info_collector.h"
#include "exception_info_common.h"
#include "path.h"

using namespace Adx;

namespace {
const std::string g_idemHostBinContent = "host kernel bin content for idempotent test";
int32_t StubGetBinDataForIdem(rtBinHandle binHandle, std::string& binData, uint32_t& binSize)
{
    (void)binHandle;
    binData = g_idemHostBinContent;
    binSize = static_cast<uint32_t>(g_idemHostBinContent.size());
    return ADUMP_SUCCESS;
}
} // namespace

static void SetupKernelMetaDir(const Tools::CaseWorkspace& ws)
{
    ws.Mkdir("kernel_meta");
    ws.Echo(
        R"({"kernelName": "AddCustom_3ee04b5d550e4239498c29151be6bb5c"})",
        "kernel_meta/AddCustom_3ee04b5d550e4239498c29151be6bb5c.json", true, false);
    ws.Echo(
        R"({"kernelName": "te_gatherv2_e0258b0a6b5321e318fc35"})",
        "kernel_meta/te_gatherv2_e0258b0a6b5321e318fc35.json", true, false);
    ws.Echo("test.o", "kernel_meta/te_gatherv2_e0258b0a6b5321e318fc35.o", true, false);
}

struct AicoreArgsFixture {
    static constexpr const char* KERNEL_NAME = "AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic";

    char input0[7] = "input0";
    char shapePtr1[10] = "shapePtr1";
    char shapePtr2[10] = "shapePtr2";
    char normalPtr1[11] = "normalPtr1";
    char normalPtr2[11] = "normalPtr2";
    char workspace[10] = "workspace";
    char oldNormalPtr[13] = "oldNormalPtr";
    char tilingData[11] = "tilingData";
    uint64_t args[14] = {};
    uint32_t atomicIndex = 0;
    uint64_t* sizeInfoAddr = nullptr;
    rtExceptionInfo exceptionInfo = {0};
    char hostKernel[26] = "host kernel bin file stub";

    void Setup()
    {
        exceptionInfo.streamid = 1;
        exceptionInfo.taskid = 1;
        exceptionInfo.deviceid = 1;
        exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
        exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = nullptr;
        exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = 0;

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

        uint64_t sizeInfo[] = {
            atomicIndex,
            0x000000010000000D,
            sizeof(input0),
            0,
            static_cast<uint64_t>(static_cast<int64_t>(-2)),
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
        sizeInfoAddr = static_cast<uint64_t*>(AdumpGetSizeInfoAddr(space, atomicIndex));
        auto sizeInfos = sizeInfoAddr;
        sizeInfo[0] = atomicIndex;
        for (const auto& size : sizeInfo) {
            *sizeInfos = size;
            sizeInfos++;
        }
        exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.infoAddr = sizeInfoAddr;
        exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.atomicIndex = atomicIndex;
    }

    void SetKernelBin(const char* kernelName = KERNEL_NAME)
    {
        exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin =
            static_cast<rtBinHandle>(hostKernel);
        exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(hostKernel);
        exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName =
            const_cast<char*>(kernelName);
        exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = strlen(kernelName);
    }

    static std::string StripMixSuffix(const std::string& name)
    {
        const std::string mixSuffix = "_mix_aic";
        std::string result = name;
        auto pos = result.find(mixSuffix);
        if (pos != std::string::npos) {
            result.replace(pos, mixSuffix.size(), "");
        }
        return result;
    }

    void AssertKernelFilesDumped(const std::string& wsRoot) const
    {
        std::string shortName = StripMixSuffix(KERNEL_NAME);
        Path hostKernelPath(wsRoot);
        hostKernelPath.Concat("extra-info/data-dump")
            .Concat(std::to_string(exceptionInfo.deviceid))
            .Concat(shortName + "_host.o");
        std::ifstream hostFile(hostKernelPath.GetString());
        std::cout << hostKernelPath.GetString() << std::endl;
        EXPECT_EQ(hostFile.good(), true);

        Path kernelJsonPath(wsRoot);
        kernelJsonPath.Concat("extra-info/data-dump")
            .Concat(std::to_string(exceptionInfo.deviceid))
            .Concat(shortName + ".json");
        std::ifstream jsonFile(kernelJsonPath.GetString());
        std::cout << kernelJsonPath.GetString() << std::endl;
        EXPECT_EQ(jsonFile.good(), true);

        Path kernelPath(wsRoot);
        kernelPath.Concat("extra-info/data-dump")
            .Concat(std::to_string(exceptionInfo.deviceid))
            .Concat(shortName + ".o");
        std::ifstream kernelFile(kernelPath.GetString());
        std::cout << kernelPath.GetString() << std::endl;
        EXPECT_EQ(kernelFile.good(), false);
    }
};

#define ASCEND_CACHE_PATH ADUMP_BASE_DIR
#define ASCEND_CUSTOM_OPP_PATH "/src/dfx/adump:/tests/ut/adump:"

class DumpArgsUtest : public testing::Test {
protected:
    virtual void SetUp() { ResetAllPlatformManagers(); }
    virtual void TearDown()
    {
        ResetAllPlatformManagers();
        ThreadManager::Instance().WaitAll();
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
    uint64_t sizeInfo[] = {
        atomicIndex,
        0x0F230, //  62000
        sizeof(input0)};
    auto sizeInfoAddr =
        static_cast<uint64_t*>(AdumpGetSizeInfoAddr(sizeof(sizeInfo) / sizeof(sizeInfo[0]), atomicIndex));
    auto sizeInfos = sizeInfoAddr;
    sizeInfo[0] = atomicIndex;
    for (const auto& size : sizeInfo) {
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

INT32 mmRealPathStub(const CHAR* path, CHAR* realPath, INT32 realPathLen)
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

static void RunArgsFailureScenarios(AicoreArgsFixture& f)
{
    f.sizeInfoAddr[4] = -16;
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    f.sizeInfoAddr[1] = 0x000000100000000D;
    ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    f.exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.atomicIndex = f.atomicIndex - 1;
    ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    // test argsize is 0
    f.exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = 0;
    EXPECT_EQ(ADUMP_FAILED, DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo));

    // test info addr is null
    f.exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.infoAddr = nullptr;
    EXPECT_EQ(ADUMP_FAILED, DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo));

    // test exception type is not support
    f.exceptionInfo.expandInfo.type = RT_EXCEPTION_INVALID;
    EXPECT_EQ(ADUMP_FAILED, DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo));
}

static void RestoreArgsAndDumpSuccess(AicoreArgsFixture& f)
{
    f.sizeInfoAddr[1] = 0x000000010000000D;
    f.sizeInfoAddr[4] = static_cast<uint64_t>(static_cast<int64_t>(-2));
    f.exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = f.args;
    f.exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.atomicIndex = f.atomicIndex;
    f.exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(f.args);
    f.exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.sizeInfo.infoAddr = f.sizeInfoAddr;
    f.exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(DumpArgsUtest, Test_Dump_Args)
{
    Tools::CaseWorkspace ws("kernel_meta_Test_Dump_Args");
    SetupKernelMetaDir(ws);

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    dumpConf.dumpSwitch = 1U << 2; // exception dump with shape
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    AicoreArgsFixture f;
    f.Setup();

    std::string fileName = "AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic.json";
    std::string value = "{\n\\\"kernelName\\\": \\\"AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic.json\\\"\n}";
    ws.Touch(fileName);
    ws.Echo(value, fileName, true, false);

    RunArgsFailureScenarios(f);

    f.exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    f.exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = nullptr;
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    RestoreArgsAndDumpSuccess(f);

    // test collect kernel .o .json file
    (void)setenv("ASCEND_CACHE_PATH", ws.Root().c_str(), 1);
    (void)setenv("ASCEND_CUSTOM_OPP_PATH", ASCEND_CUSTOM_OPP_PATH, 1);
    f.SetKernelBin();
    ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS); // copy kernel bin file failed
    sleep(1);                      // wait async process done

    f.AssertKernelFilesDumped(ws.Root());

    // mock copy success
    MOCKER_CPP(&File::Copy).stubs().will(returnValue(ADUMP_SUCCESS));
    ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    sleep(1); // wait async process done

    // mock real path failed
    MOCKER(&DumpFile::Dump).stubs().will(returnValue(ADUMP_SUCCESS));
    MOCKER_CPP(&Path::RealPath).stubs().will(returnValue(false));
    ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);
    sleep(1); // wait async process done

    MOCKER_CPP(&File::Write).stubs().will(returnValue((int64_t)EN_ERROR));
    ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);
    sleep(1); // wait async process done

    EXPECT_EQ(AdumpIsDumpEnable(DumpType::ARGS_EXCEPTION), true);
    uint64_t dumpSwitch = 0;
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::ARGS_EXCEPTION, dumpSwitch), true);
    EXPECT_EQ(dumpSwitch, dumpConf.dumpSwitch);
    sleep(1); // wait async process done
}

TEST_F(DumpArgsUtest, Test_Dump_Args_Quick_Recover)
{
    Tools::CaseWorkspace ws("kernel_meta_Test_Dump_Args_Recover");

    rtSetOpExecuteTimeOutWithMs(100);

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    dumpConf.dumpSwitch = 1U << 2; // exception dump with shape
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    std::string fileName = "AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic.json";
    std::string value = "{\n\\\"kernelName\\\": \\\"AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic.json\\\"\n}";
    ws.Touch(fileName);
    ws.Echo(value, fileName, true, false);

    AicoreArgsFixture f;
    f.Setup();

    f.sizeInfoAddr[4] = -16;
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    rtSetOpExecuteTimeOutWithMs(18 * 60 * 1000);
}

TEST_F(DumpArgsUtest, Test_Dump_Args_OPP_Path)
{
    Tools::CaseWorkspace ws("kernel_meta_Test_Dump_Args_OPP_Path");
    SetupKernelMetaDir(ws);

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    dumpConf.dumpSwitch = 1U << 2; // exception dump with shape
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    AicoreArgsFixture f;
    f.Setup();

    std::string fileName = "AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic.json";
    std::string value = "{\n\\\"kernelName\\\": \\\"AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic.json\\\"\n}";
    ws.Touch(fileName);
    ws.Echo(value, fileName, true, false);

    RunArgsFailureScenarios(f);

    f.exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = nullptr;
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    RestoreArgsAndDumpSuccess(f);

    // test collect kernel .o .json file
    (void)setenv("ASCEND_CACHE_PATH", ws.Root().c_str(), 1);
    (void)setenv("ASCEND_OPP_PATH", ADUMP_BASE_DIR, 1);
    (void)setenv("ASCEND_WORK_PATH", ADUMP_BASE_DIR "ASCEND_WORK_PATH", 1);
    f.SetKernelBin();
    ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS); // copy kernel bin file failed
    sleep(1);                      // wait async process done

    f.AssertKernelFilesDumped(ws.Root());

    // mock copy success
    MOCKER_CPP(&File::Copy).stubs().will(returnValue(ADUMP_SUCCESS));
    ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    sleep(1); // wait async process done

    // mock real path failed
    MOCKER(&DumpFile::Dump).stubs().will(returnValue(ADUMP_SUCCESS));
    MOCKER_CPP(&Path::RealPath).stubs().will(returnValue(false));
    ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);
    sleep(1); // wait async process done

    MOCKER_CPP(&File::Write).stubs().will(returnValue((int64_t)EN_ERROR));
    ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);
    sleep(1); // wait async process done

    EXPECT_EQ(AdumpIsDumpEnable(DumpType::ARGS_EXCEPTION), true);
    uint64_t dumpSwitch = 0;
    EXPECT_EQ(AdumpIsDumpEnable(DumpType::ARGS_EXCEPTION, dumpSwitch), true);
    EXPECT_EQ(dumpSwitch, dumpConf.dumpSwitch);
    sleep(1); // wait async process done
}

static void FftsArgs_InitExceptionInfo(rtExceptionInfo& exceptionInfo)
{
    exceptionInfo = {0};
    exceptionInfo.streamid = 1;
    exceptionInfo.taskid = 1;
    exceptionInfo.deviceid = 1;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_FFTS_PLUS;
    exceptionInfo.expandInfo.u.fftsPlusInfo.contextId = 2;
    exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = nullptr;
    exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.exceptionKernelInfo.dfxSize = 0;
}

static void FftsArgs_SetupArgs(
    uint64_t (&args)[14], char* input0, char* shapePtr1, char* shapePtr2, char* normalPtr1, char* normalPtr2,
    char* workspace, char* tilingData)
{
    args[0] = 0;
    args[1] = reinterpret_cast<uint64_t>(input0);
    args[2] = 2;
    args[8] = reinterpret_cast<uint64_t>(normalPtr1);
    args[9] = reinterpret_cast<uint64_t>(normalPtr2);
    args[4] = reinterpret_cast<uint64_t>(&args[8]);
    args[10] = 16;
    args[12] = reinterpret_cast<uint64_t>(shapePtr1);
    args[13] = reinterpret_cast<uint64_t>(shapePtr2);
    args[5] = reinterpret_cast<uint64_t>(&args[10]);
    args[6] = reinterpret_cast<uint64_t>(workspace);
    args[7] = reinterpret_cast<uint64_t>(tilingData);
}

static void FftsArgs_SetupSizeInfo(
    rtExceptionInfo& exceptionInfo, const uint64_t (&args)[14], const char (&input0)[7], const char (&shapePtr1)[10],
    const char (&shapePtr2)[10], const char (&normalPtr1)[11], const char (&normalPtr2)[11],
    const char (&workspace)[10], const char (&oldNormalPtr)[13], const char (&tilingData)[11])
{
    uint32_t atomicIndex;
    uint64_t sizeInfo[] = {
        atomicIndex,
        20,
        1, // context 1
        0, // argSize
        0x0000000100000001,
        1,
        2, // context 2
        sizeof(args),
        0x000000010000000D,
        sizeof(input0),
        0,
        static_cast<uint64_t>(static_cast<int64_t>(-2)),
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
    auto sizeInfoAddr = static_cast<uint64_t*>(AdumpGetSizeInfoAddr(space, atomicIndex));
    auto sizeInfos = sizeInfoAddr;
    sizeInfo[0] = atomicIndex;
    for (const auto& size : sizeInfo) {
        *sizeInfos = size;
        sizeInfos++;
    }
    exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.sizeInfo.infoAddr = sizeInfoAddr;
    exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.sizeInfo.atomicIndex = atomicIndex;
}

TEST_F(DumpArgsUtest, Test_Dump_Ffts_Args)
{
    Tools::CaseWorkspace ws("Test_Dump_Ffts_Args");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    rtExceptionInfo exceptionInfo;
    FftsArgs_InitExceptionInfo(exceptionInfo);
    char input0[] = "input0";
    char shapePtr1[] = "shapePtr1";
    char shapePtr2[] = "shapePtr2";
    char normalPtr1[] = "normalPtr1";
    char normalPtr2[] = "normalPtr2";
    char workspace[] = "workspace";
    char oldNormalPtr[] = "oldNormalPtr";
    char tilingData[] = "tilingData";
    uint64_t args[14] = {};
    FftsArgs_SetupArgs(args, input0, shapePtr1, shapePtr2, normalPtr1, normalPtr2, workspace, tilingData);
    exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.argsize = sizeof(args);

    FftsArgs_SetupSizeInfo(
        exceptionInfo, args, input0, shapePtr1, shapePtr2, normalPtr1, normalPtr2, workspace, oldNormalPtr, tilingData);
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

void generateDfxByBigEndian(std::vector<uint8_t>& vec, size_t typeSize, uint64_t value)
{
    for (size_t i = 0; i < typeSize; ++i) {
        uint8_t tmpValue = static_cast<uint8_t>(((value) >> ((typeSize - i - 1) * 8)) & 0xFF);
        vec.push_back(tmpValue);
    }
}

void generateDfxByLittleEndian(std::vector<uint8_t>& vec, size_t typeSize, uint64_t value)
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
void generateDfxInfo(std::vector<uint8_t>& dfxInfo, T& tensor, uint16_t argsInfoType = TYPE_L0_EXCEPTION_DFX_ARGS_INFO)
{
    std::vector<uint8_t> tensorDfxInfo;
    auto* p = reinterpret_cast<uint64_t*>(&tensor);
    for (size_t i = 0; i < sizeof(tensor) / sizeof(uint64_t); ++i) {
        generateDfxByBigEndian(tensorDfxInfo, sizeof(uint64_t), *(p + i));
    }
    ArgInfoHead head = {argsInfoType, sizeof(tensor) / sizeof(uint64_t)};
    generateDfxByBigEndian(dfxInfo, sizeof(uint16_t), head.argsDfxType);
    generateDfxByBigEndian(dfxInfo, sizeof(uint16_t), head.numOfArgInfo);
    dfxInfo.insert(dfxInfo.end(), tensorDfxInfo.begin(), tensorDfxInfo.end());
}

template <typename T>
void generateDfxInfoWithError(
    std::vector<uint8_t>& dfxInfo, T& tensor, uint16_t numOfArgInfo,
    uint16_t argsInfoType = TYPE_L0_EXCEPTION_DFX_ARGS_INFO)
{
    std::vector<uint8_t> tensorDfxInfo;
    auto* p = reinterpret_cast<uint64_t*>(&tensor);
    for (size_t i = 0; i < sizeof(tensor) / sizeof(uint64_t); ++i) {
        generateDfxByBigEndian(tensorDfxInfo, sizeof(uint64_t), *(p + i));
    }
    ArgInfoHead head = {argsInfoType, numOfArgInfo};
    generateDfxByBigEndian(dfxInfo, sizeof(uint16_t), head.argsDfxType);
    generateDfxByBigEndian(dfxInfo, sizeof(uint16_t), head.numOfArgInfo);
    dfxInfo.insert(dfxInfo.end(), tensorDfxInfo.begin(), tensorDfxInfo.end());
}

template <typename T>
std::vector<uint8_t> GetTensorData(T& tensor)
{
    std::vector<uint8_t> tensorData;
    tensorData.resize(sizeof(tensor));
    memcpy(tensorData.data(), tensor, sizeof(tensor));
    return tensorData;
}

static uint64_t MakeArgsType(DfxTensorType t, DfxPointerType p)
{
    return static_cast<uint64_t>(t) | (static_cast<uint64_t>(p) << POINTER_TYPE_SHIFT_BITS);
}

static void AppendStaticL1(
    std::vector<uint8_t>& out, DfxTensorType t, uint64_t size, uint64_t dim, std::array<uint64_t, 2> shape)
{
    StaticL1PointerTensor tensor;
    tensor.argsType = MakeArgsType(t, DfxPointerType::LEVEL_1_POINTER);
    tensor.size = size;
    tensor.dim = dim;
    tensor.shape = shape;
    std::vector<uint8_t> buf;
    generateDfxInfo(buf, tensor);
    out.insert(out.end(), buf.begin(), buf.end());
}

static void AppendWithSize(std::vector<uint8_t>& out, DfxTensorType t, DfxPointerType p, uint64_t size)
{
    WithSizeTensor tensor;
    tensor.argsType = MakeArgsType(t, p);
    tensor.size = size;
    std::vector<uint8_t> buf;
    generateDfxInfo(buf, tensor);
    out.insert(out.end(), buf.begin(), buf.end());
}

static void AppendWithSizeErr(
    std::vector<uint8_t>& out, DfxTensorType t, DfxPointerType p, uint64_t size, uint16_t numOfArgInfoOverride)
{
    WithSizeTensor tensor;
    tensor.argsType = MakeArgsType(t, p);
    tensor.size = size;
    std::vector<uint8_t> buf;
    generateDfxInfoWithError(buf, tensor, numOfArgInfoOverride);
    out.insert(out.end(), buf.begin(), buf.end());
}

static void AppendWithoutSize(
    std::vector<uint8_t>& out, DfxTensorType t, DfxPointerType p,
    uint16_t argsInfoType = TYPE_L0_EXCEPTION_DFX_ARGS_INFO)
{
    WithoutSizeTensor tensor;
    tensor.argsType = MakeArgsType(t, p);
    std::vector<uint8_t> buf;
    generateDfxInfo(buf, tensor, argsInfoType);
    out.insert(out.end(), buf.begin(), buf.end());
}

static void AppendL2Pointer(
    std::vector<uint8_t>& out, DfxTensorType t, DfxPointerType p, uint64_t size, uint64_t dataTypeSize)
{
    L2PointerTensor tensor;
    tensor.argsType = MakeArgsType(t, p);
    tensor.size = size;
    tensor.dataTypeSize = dataTypeSize;
    std::vector<uint8_t> buf;
    generateDfxInfo(buf, tensor);
    out.insert(out.end(), buf.begin(), buf.end());
}

static std::vector<uint8_t> WrapKernelAndExceptionLE(const std::vector<uint8_t>& payload)
{
    std::vector<uint8_t> kernelTypeDfxInfo;
    uint16_t dfxKernelType = 1;
    uint16_t dfxInfoLength = static_cast<uint16_t>(payload.size());
    generateDfxByLittleEndian(kernelTypeDfxInfo, sizeof(uint16_t), dfxKernelType);
    generateDfxByLittleEndian(kernelTypeDfxInfo, sizeof(uint16_t), dfxInfoLength);
    kernelTypeDfxInfo.insert(kernelTypeDfxInfo.end(), payload.begin(), payload.end());

    std::vector<uint8_t> exceptionDfxInfo;
    generateDfxByLittleEndian(exceptionDfxInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX);
    generateDfxByLittleEndian(exceptionDfxInfo, sizeof(uint16_t), dfxInfoLength);
    exceptionDfxInfo.insert(exceptionDfxInfo.end(), payload.begin(), payload.end());

    std::vector<uint8_t> dfxInfo;
    dfxInfo.insert(dfxInfo.end(), kernelTypeDfxInfo.begin(), kernelTypeDfxInfo.end());
    dfxInfo.insert(dfxInfo.end(), exceptionDfxInfo.begin(), exceptionDfxInfo.end());
    return dfxInfo;
}

static std::vector<uint8_t> WrapTikAndExceptionLE(const std::vector<uint8_t>& payload, uint32_t tikValue)
{
    std::vector<uint8_t> tikInfoDfxInfo;
    generateDfxByLittleEndian(tikInfoDfxInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX_IS_TIK);
    generateDfxByLittleEndian(tikInfoDfxInfo, sizeof(uint16_t), sizeof(uint32_t));
    generateDfxByLittleEndian(tikInfoDfxInfo, sizeof(uint32_t), tikValue);

    std::vector<uint8_t> exceptionDfxInfo;
    uint16_t dfxInfoLength = static_cast<uint16_t>(payload.size());
    generateDfxByLittleEndian(exceptionDfxInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX);
    generateDfxByLittleEndian(exceptionDfxInfo, sizeof(uint16_t), dfxInfoLength);
    exceptionDfxInfo.insert(exceptionDfxInfo.end(), payload.begin(), payload.end());

    std::vector<uint8_t> dfxInfo;
    dfxInfo.insert(dfxInfo.end(), tikInfoDfxInfo.begin(), tikInfoDfxInfo.end());
    dfxInfo.insert(dfxInfo.end(), exceptionDfxInfo.begin(), exceptionDfxInfo.end());
    return dfxInfo;
}

static std::vector<uint8_t> WrapExceptionBE(const std::vector<uint8_t>& payload)
{
    std::vector<uint8_t> dfxInfo;
    uint16_t dfxInfoLength = static_cast<uint16_t>(payload.size());
    generateDfxByBigEndian(dfxInfo, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX);
    generateDfxByBigEndian(dfxInfo, sizeof(uint16_t), dfxInfoLength);
    dfxInfo.insert(dfxInfo.end(), payload.begin(), payload.end());
    return dfxInfo;
}

static void SetDfxInfoAicore(rtExceptionInfo& ei, const std::vector<uint8_t>& dfxInfo, int32_t elfDataFlag)
{
    ei.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = const_cast<uint8_t*>(dfxInfo.data());
    ei.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = dfxInfo.size();
    ei.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.elfDataFlag = elfDataFlag;
}

static void SetDfxInfoFusion(rtExceptionInfo& ei, const std::vector<uint8_t>& dfxInfo, int32_t elfDataFlag)
{
    ei.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.exceptionKernelInfo.dfxAddr =
        const_cast<uint8_t*>(dfxInfo.data());
    ei.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.exceptionKernelInfo.dfxSize = dfxInfo.size();
    ei.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.exceptionKernelInfo.elfDataFlag = elfDataFlag;
}

static void InitExceptionInfo(
    rtExceptionInfo& ei, rtExceptionExpandType_t type, uint32_t streamid = 1, uint32_t taskid = 1,
    uint32_t deviceid = 1)
{
    ei = {0};
    ei.streamid = streamid;
    ei.taskid = taskid;
    ei.deviceid = deviceid;
    ei.expandInfo.type = type;
    ei.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxAddr = nullptr;
    ei.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.dfxSize = 0;
}

struct ShapeInfo {
    uint64_t tensorSize;
    uint64_t input0Size;
    uint64_t output0Size;
    uint64_t workspaceSize;
    uint64_t tensorDim;
    uint64_t tensorShape0;
    uint64_t tensorShape1;
    uint64_t input0Dim;
    uint64_t input0Shape0;
    uint64_t input0Shape1;
    uint64_t output0Dim;
    uint64_t output0Shape0;
    uint64_t output0Shape1;
};

static ShapeInfo MakeShapeInfo(uint64_t outDim = 2)
{
    return {
        sizeof(int32_t) * 6, sizeof(float) * 6, sizeof(float) * 6, sizeof(int32_t) * 3, 2, 3, 2, 2, 3, 2, outDim, 2, 3};
}

static void FillShapeAddr(uint64_t* shapeAddr, const ShapeInfo& s)
{
    shapeAddr[0] = s.tensorSize;
    shapeAddr[1] = s.input0Size;
    shapeAddr[2] = s.output0Size;
    shapeAddr[3] = s.workspaceSize;
    shapeAddr[4] = s.tensorDim;
    shapeAddr[5] = s.tensorShape0;
    shapeAddr[6] = s.tensorShape1;
    shapeAddr[7] = s.input0Dim;
    shapeAddr[8] = s.input0Shape0;
    shapeAddr[9] = s.input0Shape1;
    shapeAddr[10] = s.output0Dim;
    shapeAddr[11] = s.output0Shape0;
    shapeAddr[12] = s.output0Shape1;
}

static void SetupTikStyleArgs(
    uint64_t (&args)[9], const int32_t (&tensor)[6], const float (&input0)[6], const float (&output0)[6],
    const int32_t (&workspace)[3], const uint64_t (&tilingData)[3], uint64_t atomicIndex)
{
    args[0] = reinterpret_cast<uint64_t>(&tensor);
    args[1] = reinterpret_cast<uint64_t>(&input0);
    args[2] = reinterpret_cast<uint64_t>(&output0);
    args[3] = reinterpret_cast<uint64_t>(&workspace);
    args[5] = tilingData[0];
    args[6] = tilingData[1];
    args[7] = tilingData[2];
    args[4] = reinterpret_cast<uint64_t>(&args[5]);
    args[8] = atomicIndex;
}

/* == dlopen test == */
static int32_t HeadProcessTest(uint32_t devId, const void* addr, uint64_t headerSize, uint64_t& newHeaderSize)
{
    (void)devId;
    (void)addr;
    newHeaderSize = headerSize + 1;
    return 0;
}

static int32_t TensorProcessTest(uint32_t devId, const void* addr, uint64_t size, int32_t fd)
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

void* mmDlsym(void* handle, const char* funcName)
{
    if (strcmp(funcName, "AdumpPluginInit") == 0) {
        return (void*)&AdumpPluginInitStub;
    }
    return nullptr;
}

char* mmDlerror(void) { return "None"; }

int32_t g_handle;
void* mmDlopen(const char* filename, int mode)
{
    (void)mode;
    if (strcmp(filename + strlen(filename) - strlen("plugin.so"), "plugin.so") == 0) {
        return &g_handle;
    }
    return nullptr;
}
/* == dlopen test == */

static std::string SetupPluginSoDir(const Tools::CaseWorkspace& ws)
{
    std::string pluginDir = ws.Mkdir("plugin/adump");
    ws.Echo("target file for testing", "plugin/adump/adump_test_plugin.so");
    ws.Echo("target file for testing", "plugin/adump/adump_test2_plugin.so");
    return pluginDir;
}

static void SetupPluginMocks(const std::string& pluginDir)
{
    MOCKER_CPP(&LibPath::GetTargetPath).stubs().will(returnValue(pluginDir));
    MOCKER(dlopen).stubs().will(invoke(mmDlopen));
    MOCKER(dlsym).stubs().will(invoke(mmDlsym));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER(dlerror).stubs().will(invoke(mmDlerror));
}

static HcclCombinOpParam g_combinOpParam;
static uint8_t workSpaceData[128] = {1, 2, 3, 4, 5};
static IbVerbsData g_ibVerbsData;

static void DfxStatic_SetupGlobals()
{
    g_combinOpParam.mc2WorkSpace = {(uint64_t)&workSpaceData, 128};
    g_combinOpParam.rankId = 0;
    g_combinOpParam.winSize = 128;
    g_combinOpParam.windowsIn[g_combinOpParam.rankId] = (uint64_t)&workSpaceData;
    g_combinOpParam.windowsOut[g_combinOpParam.rankId] = (uint64_t)&workSpaceData;
    g_ibVerbsData.localInput = {128, (uint64_t)&workSpaceData, 0};
    g_ibVerbsData.localOutput = {128, (uint64_t)&workSpaceData, 0};
    g_combinOpParam.ibverbsData = (uint64_t)&g_ibVerbsData;
    g_combinOpParam.ibverbsDataSize = sizeof(g_ibVerbsData);
}

static void DfxStatic_SetupArgs(
    uint64_t (&args)[22], char* fftsAddr, int32_t* tensor, float* input0, float* output0, int32_t* placehold,
    int32_t* workspace, int32_t* normalPtr1, int32_t* normalPtr2, int32_t* shapePtr2t3, int32_t* shapePtrPlaceHold,
    int32_t* shapePtrScalar)
{
    args[0] = reinterpret_cast<uint64_t>(fftsAddr);
    args[1] = reinterpret_cast<uint64_t>(tensor);
    args[2] = reinterpret_cast<uint64_t>(input0);
    args[3] = reinterpret_cast<uint64_t>(output0);
    args[4] = reinterpret_cast<uint64_t>(placehold);
    args[7] = reinterpret_cast<uint64_t>(workspace);
    args[8] = reinterpret_cast<uint64_t>(&g_combinOpParam);
    args[9] = reinterpret_cast<uint64_t>(normalPtr1);
    args[10] = reinterpret_cast<uint64_t>(normalPtr2);
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
    args[19] = reinterpret_cast<uint64_t>(shapePtr2t3);
    args[20] = reinterpret_cast<uint64_t>(shapePtrPlaceHold);
    args[21] = reinterpret_cast<uint64_t>(shapePtrScalar);
}

static std::vector<uint8_t> DfxStatic_BuildDfxInfo(
    const int32_t (&tensor)[6], const float (&input0)[6], const int32_t (&workspace)[3])
{
    std::vector<uint8_t> dfxInfoValue;
    AppendWithoutSize(dfxInfoValue, DfxTensorType::FFTS_ADDRESS, DfxPointerType::LEVEL_1_POINTER);
    AppendWithoutSize(dfxInfoValue, DfxTensorType::FFTS_ADDRESS, DfxPointerType::LEVEL_1_POINTER, 6);
    AppendStaticL1(dfxInfoValue, DfxTensorType::GENERAL_TENSOR, sizeof(tensor), 2, {3, 2});
    AppendStaticL1(dfxInfoValue, DfxTensorType::INPUT_TENSOR, sizeof(input0), 2, {3, 2});
    AppendStaticL1(dfxInfoValue, DfxTensorType::OUTPUT_TENSOR, sizeof(input0), 2, {2, 3});
    AppendStaticL1(dfxInfoValue, DfxTensorType::INPUT_TENSOR, 0, 2, {4, 2});
    AppendL2Pointer(dfxInfoValue, DfxTensorType::INPUT_TENSOR, DfxPointerType::LEVEL_2_POINTER, NON_TENSOR_SIZE, 4);
    AppendL2Pointer(
        dfxInfoValue, DfxTensorType::OUTPUT_TENSOR, DfxPointerType::LEVEL_2_POINTER_WITH_SHAPE, NON_TENSOR_SIZE, 4);
    AppendWithSize(dfxInfoValue, DfxTensorType::WORKSPACE_TENSOR, DfxPointerType::LEVEL_1_POINTER, sizeof(workspace));
    AppendWithoutSize(dfxInfoValue, DfxTensorType::MC2_CTX, DfxPointerType::LEVEL_1_POINTER);
    return WrapKernelAndExceptionLE(dfxInfoValue);
}

static std::vector<uint8_t> BuildMc2Data(size_t& totalSize)
{
    // workspace + windowsIn + windowsOut + ibverbsData struct + ibverbsData data localInput + ibverbsData data
    // localOutput
    totalSize = sizeof(HcclCombinOpParam) + 128 + 128 + 128 + sizeof(g_ibVerbsData) + 128 + 128;
    std::vector<uint8_t> mc2Data(0, totalSize);
    mc2Data.insert(
        mc2Data.end(), reinterpret_cast<uint8_t*>(&g_combinOpParam),
        reinterpret_cast<uint8_t*>(&g_combinOpParam) + sizeof(HcclCombinOpParam));
    mc2Data.insert(
        mc2Data.end(), reinterpret_cast<uint8_t*>(&workSpaceData),
        reinterpret_cast<uint8_t*>(&workSpaceData) + 128); // workspace
    mc2Data.insert(
        mc2Data.end(), reinterpret_cast<uint8_t*>(&workSpaceData),
        reinterpret_cast<uint8_t*>(&workSpaceData) + 128); // windowsIn
    mc2Data.insert(
        mc2Data.end(), reinterpret_cast<uint8_t*>(&workSpaceData),
        reinterpret_cast<uint8_t*>(&workSpaceData) + 128); // windowsOut
    mc2Data.insert(
        mc2Data.end(), reinterpret_cast<uint8_t*>(&g_ibVerbsData),
        reinterpret_cast<uint8_t*>(&g_ibVerbsData) + sizeof(g_ibVerbsData)); // ibverbsData struct
    mc2Data.insert(
        mc2Data.end(), reinterpret_cast<uint8_t*>(&workSpaceData),
        reinterpret_cast<uint8_t*>(&workSpaceData) + 128); // ibverbsData data localInput
    mc2Data.insert(
        mc2Data.end(), reinterpret_cast<uint8_t*>(&workSpaceData),
        reinterpret_cast<uint8_t*>(&workSpaceData) + 128); // ibverbsData data localOutput
    return mc2Data;
}

static void DfxStatic_CheckResult(
    DumpFileChecker& checker, const int32_t (&tensor)[6], const float (&input0)[6], const float (&output0)[6],
    const int32_t (&shapePtr2t3)[6], const int32_t (&shapePtrScalar)[1], const int32_t (&workspace)[3])
{
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
    size_t totalSize = 0;
    std::vector<uint8_t> mc2Data = BuildMc2Data(totalSize);
    EXPECT_EQ(checker.CheckWorkspaceSize(1, totalSize), true);
    EXPECT_EQ(checker.CheckWorkspaceData(1, mc2Data), true);
}

TEST_F(DumpArgsUtest, Test_Dump_Args_With_Dfx_Static)
{
    DfxStatic_SetupGlobals();

    Tools::CaseWorkspace ws("Test_Dump_Args_With_Dfx_Static");
    std::string pluginDir = SetupPluginSoDir(ws);
    SetupPluginMocks(pluginDir);

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);
    uint32_t v2type = 5;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));

    rtExceptionInfo exceptionInfo;
    InitExceptionInfo(exceptionInfo, RT_EXCEPTION_FUSION);
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
    DfxStatic_SetupArgs(
        args, fftsAddr, tensor, input0, output0, placehold, workspace, normalPtr1, normalPtr2, shapePtr2t3,
        shapePtrPlaceHold, shapePtrScalar);
    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.argsize = sizeof(args);

    auto dfxInfo = DfxStatic_BuildDfxInfo(tensor, input0, workspace);
    SetDfxInfoFusion(exceptionInfo, dfxInfo, 1);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    std::string expectDumpFilePath = ExpectedArgsDumpFilePath(
        ws.Root(), exceptionInfo.deviceid, exceptionInfo.streamid, exceptionInfo.taskid, stubNowTime);
    DumpFileChecker checker;
    EXPECT_EQ(checker.Load(expectDumpFilePath), true);
    DfxStatic_CheckResult(checker, tensor, input0, output0, shapePtr2t3, shapePtrScalar, workspace);

    uint64_t headerSize = 0;
    uint64_t newHeaderSize = 0;
    EXPECT_EQ(
        0,
        DumpTensorPlugin::Instance().NotifyHeadCallback(DfxTensorType::MC2_CTX, 0, nullptr, headerSize, newHeaderSize));
    EXPECT_EQ(1, newHeaderSize);
    EXPECT_EQ(0, DumpTensorPlugin::Instance().NotifyTensorCallback(DfxTensorType::MC2_CTX, 0, nullptr, 0, 0));
}

static void DfxDynamic_FillShapeAddr(
    uint64_t* shapeAddr, const int32_t (&tensor)[6], const float (&input0)[6], const float (&output0)[6],
    const int32_t (&workspace)[3])
{
    auto s = MakeShapeInfo();
    shapeAddr[0] = s.tensorSize;
    shapeAddr[1] = s.input0Size;
    shapeAddr[2] = s.output0Size;
    shapeAddr[3] = 0;                     // placeholdSize
    shapeAddr[4] = sizeof(uint64_t) * 11; // shape ptr dynamic inputs size
    shapeAddr[5] = s.workspaceSize;
    shapeAddr[6] = s.tensorDim;
    shapeAddr[7] = s.tensorShape0;
    shapeAddr[8] = s.tensorShape1;
    shapeAddr[9] = s.input0Dim;
    shapeAddr[10] = s.input0Shape0;
    shapeAddr[11] = s.input0Shape1;
    shapeAddr[12] = s.output0Dim;
    shapeAddr[13] = s.output0Shape0;
    shapeAddr[14] = s.output0Shape1;
}

static void DfxDynamic_SetupArgs(
    uint64_t (&args)[27], char* fftsAddr, int32_t* tensor, float* input0, float* output0, int32_t* placehold,
    int32_t* workspace, uint64_t tilingData, uint64_t atomicIndex, int32_t* normalPtr1, int32_t* normalPtr2,
    int32_t* shapePtr2t3, int32_t* shapePtrPlaceHold, int32_t* shapePtrScalar)
{
    args[0] = reinterpret_cast<uint64_t>(fftsAddr);
    args[1] = reinterpret_cast<uint64_t>(tensor);
    args[2] = reinterpret_cast<uint64_t>(input0);
    args[3] = reinterpret_cast<uint64_t>(output0);
    args[4] = reinterpret_cast<uint64_t>(placehold);
    args[7] = reinterpret_cast<uint64_t>(workspace);
    args[9] = tilingData;
    args[8] = reinterpret_cast<uint64_t>(&args[9]);
    args[10] = atomicIndex;
    args[11] = reinterpret_cast<uint64_t>(normalPtr1);
    args[12] = reinterpret_cast<uint64_t>(normalPtr2);
    args[5] = reinterpret_cast<uint64_t>(&args[11]);
    args[13] = sizeof(uint64_t) * 10; // offset
    args[6] = reinterpret_cast<uint64_t>(&args[13]);
    args[14] = 2 | (2ULL << TENSOR_COUNT_SHIFT_BITS);
    args[15] = 2;
    args[16] = 3;
    args[17] = 2 | (1ULL << TENSOR_COUNT_SHIFT_BITS);
    args[18] = 1024;
    args[19] = 0;
    args[20] = 0 | (1ULL << TENSOR_COUNT_SHIFT_BITS);
    args[21] = 0; // empty shape info
    args[22] = 0; // empty shape info
    args[23] = reinterpret_cast<uint64_t>(shapePtr2t3);
    args[24] = reinterpret_cast<uint64_t>(shapePtr2t3);
    args[25] = reinterpret_cast<uint64_t>(shapePtrPlaceHold);
    args[26] = reinterpret_cast<uint64_t>(shapePtrScalar);
}

static std::vector<uint8_t> DfxDynamic_BuildDfxInfo(const uint64_t& tilingData, const uint64_t& atomicIndex)
{
    std::vector<uint8_t> dfxInfoValue;
    AppendWithoutSize(dfxInfoValue, DfxTensorType::FFTS_ADDRESS, DfxPointerType::LEVEL_1_POINTER);
    AppendWithSize(dfxInfoValue, DfxTensorType::GENERAL_TENSOR, DfxPointerType::LEVEL_1_POINTER, NON_TENSOR_SIZE);
    AppendWithSize(dfxInfoValue, DfxTensorType::INPUT_TENSOR, DfxPointerType::LEVEL_1_POINTER, NON_TENSOR_SIZE);
    AppendWithSize(dfxInfoValue, DfxTensorType::OUTPUT_TENSOR, DfxPointerType::LEVEL_1_POINTER, NON_TENSOR_SIZE);
    AppendWithSize(dfxInfoValue, DfxTensorType::INPUT_TENSOR, DfxPointerType::LEVEL_1_POINTER, NON_TENSOR_SIZE);
    AppendL2Pointer(dfxInfoValue, DfxTensorType::INPUT_TENSOR, DfxPointerType::LEVEL_2_POINTER, NON_TENSOR_SIZE, 4);
    AppendL2Pointer(
        dfxInfoValue, DfxTensorType::OUTPUT_TENSOR, DfxPointerType::LEVEL_2_POINTER_WITH_SHAPE, NON_TENSOR_SIZE, 4);
    AppendWithoutSize(dfxInfoValue, DfxTensorType::WORKSPACE_TENSOR, DfxPointerType::LEVEL_1_POINTER);
    AppendWithSize(
        dfxInfoValue, DfxTensorType::TILING_DATA, DfxPointerType::LEVEL_1_POINTER,
        sizeof(tilingData) + sizeof(atomicIndex));
    return WrapExceptionBE(dfxInfoValue);
}

static void DfxDynamic_CheckResult(
    DumpFileChecker& checker, const int32_t (&tensor)[6], const float (&input0)[6], const float (&output0)[6],
    const int32_t (&shapePtr2t3)[6], const int32_t (&shapePtrScalar)[1], const int32_t (&workspace)[3],
    const uint64_t& tilingData, const uint64_t& atomicIndex)
{
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

TEST_F(DumpArgsUtest, Test_Dump_Args_With_Dfx_Dynamic)
{
    Tools::CaseWorkspace ws("Test_Dump_Args_With_Dfx_Dynamic");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);
    uint32_t v2type = 5;
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));

    rtExceptionInfo exceptionInfo;
    InitExceptionInfo(exceptionInfo, RT_EXCEPTION_AICORE);
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

    uint64_t atomicIndex = 0;
    uint64_t* shapeAddr = static_cast<uint64_t*>(AdumpGetDFXInfoAddrForDynamic(15, atomicIndex));
    DfxDynamic_FillShapeAddr(shapeAddr, tensor, input0, output0, workspace);

    uint64_t args[27] = {};
    DfxDynamic_SetupArgs(
        args, fftsAddr, tensor, input0, output0, placehold, workspace, tilingData, atomicIndex, normalPtr1, normalPtr2,
        shapePtr2t3, shapePtrPlaceHold, shapePtrScalar);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);

    auto dfxInfo = DfxDynamic_BuildDfxInfo(tilingData, atomicIndex);
    SetDfxInfoAicore(exceptionInfo, dfxInfo, ELF_DATA2MSB);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    std::string expectDumpFilePath = ExpectedArgsDumpFilePath(
        ws.Root(), exceptionInfo.deviceid, exceptionInfo.streamid, exceptionInfo.taskid, stubNowTime);
    DumpFileChecker checker;
    EXPECT_EQ(checker.Load(expectDumpFilePath), true);
    DfxDynamic_CheckResult(
        checker, tensor, input0, output0, shapePtr2t3, shapePtrScalar, workspace, tilingData, atomicIndex);
}

static void DfxStaticFailed_BuildDfxInfo(
    const int32_t (&tensor)[6], const float (&input0)[6], std::vector<uint8_t>& kernelTypeDfxInfo,
    std::vector<uint8_t>& dfxInfo)
{
    std::vector<uint8_t> dfxInfoValue;
    AppendWithoutSize(dfxInfoValue, DfxTensorType::FFTS_ADDRESS, DfxPointerType::LEVEL_1_POINTER);
    AppendWithoutSize(dfxInfoValue, DfxTensorType::FFTS_ADDRESS, DfxPointerType::LEVEL_1_POINTER, 6);
    AppendStaticL1(dfxInfoValue, DfxTensorType::GENERAL_TENSOR, sizeof(tensor), 2, {3, 2});
    AppendStaticL1(dfxInfoValue, DfxTensorType::INPUT_TENSOR, sizeof(input0), 2, {3, 2});

    // output0 with large arg info num
    StaticL1PointerTensor outputTensor;
    outputTensor.argsType = MakeArgsType(DfxTensorType::OUTPUT_TENSOR, DfxPointerType::LEVEL_1_POINTER);
    outputTensor.size = sizeof(input0);
    outputTensor.dim = 2;
    outputTensor.shape = {2, 3};
    uint16_t numOfArgInfo = (sizeof(StaticL1PointerTensor) / sizeof(uint64_t)) + 1;
    generateDfxInfoWithError(dfxInfoValue, outputTensor, numOfArgInfo);

    // kernelType-only dfxInfo (for testing "no exception dfx")
    generateDfxByLittleEndian(kernelTypeDfxInfo, sizeof(uint16_t), static_cast<uint16_t>(1));
    generateDfxByLittleEndian(kernelTypeDfxInfo, sizeof(uint16_t), static_cast<uint16_t>(dfxInfoValue.size()));
    kernelTypeDfxInfo.insert(kernelTypeDfxInfo.end(), dfxInfoValue.begin(), dfxInfoValue.end());

    dfxInfo = WrapKernelAndExceptionLE(dfxInfoValue);
}

static void DfxStaticFailed_RunErrorScenarios(
    rtExceptionInfo& exceptionInfo, char* fftsAddr, int32_t* tensor, float* input0, float* output0,
    const std::vector<uint8_t>& kernelTypeDfxInfo, const std::vector<uint8_t>& dfxInfo)
{
    // test no exception dfx
    SetDfxInfoAicore(exceptionInfo, kernelTypeDfxInfo, 1);

    uint64_t args[4] = {};
    args[0] = reinterpret_cast<uint64_t>(fftsAddr);
    args[1] = reinterpret_cast<uint64_t>(tensor);
    args[2] = reinterpret_cast<uint64_t>(input0);
    args[3] = reinterpret_cast<uint64_t>(output0);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    SetDfxInfoAicore(exceptionInfo, dfxInfo, 1);

    // test current dfx size larger than dfx size
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    // test arg index out of max arg index
    uint64_t args1[3] = {};
    args1[0] = reinterpret_cast<uint64_t>(fftsAddr);
    args1[1] = reinterpret_cast<uint64_t>(tensor);
    args1[2] = reinterpret_cast<uint64_t>(input0);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args1;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args1);
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    // test output0 with zero arg info num
    std::vector<uint8_t> dfxInfoValue1;
    StaticL1PointerTensor outputTensor1;
    outputTensor1.argsType = MakeArgsType(DfxTensorType::OUTPUT_TENSOR, DfxPointerType::LEVEL_1_POINTER);
    outputTensor1.size = sizeof(float) * 6;
    outputTensor1.dim = 2;
    outputTensor1.shape = {2, 3};
    generateDfxInfoWithError(dfxInfoValue1, outputTensor1, 0);

    std::vector<uint8_t> exceptionDfxInfo1;
    generateDfxByLittleEndian(exceptionDfxInfo1, sizeof(uint16_t), TYPE_L0_EXCEPTION_DFX);
    generateDfxByLittleEndian(exceptionDfxInfo1, sizeof(uint16_t), static_cast<uint16_t>(dfxInfoValue1.size()));
    exceptionDfxInfo1.insert(exceptionDfxInfo1.end(), dfxInfoValue1.begin(), dfxInfoValue1.end());

    SetDfxInfoAicore(exceptionInfo, exceptionDfxInfo1, 1);

    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(DumpArgsUtest, Test_Dump_Args_With_Dfx_Static_Failed)
{
    Tools::CaseWorkspace ws("Test_Dump_Args_With_Dfx_Static_Failed");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    rtExceptionInfo exceptionInfo;
    InitExceptionInfo(exceptionInfo, RT_EXCEPTION_AICORE);
    char fftsAddr[] = "ffts addr";
    int32_t tensor[] = {1, 2, 3, 4, 5, 6};
    float input0[] = {1, 2, 3, 4, 5, 6};
    float output0[] = {2, 4, 6, 8, 10, 12};
    int32_t placehold[] = {1, 1, 1, 1, 1, 1, 1, 1};

    std::vector<uint8_t> kernelTypeDfxInfo;
    std::vector<uint8_t> dfxInfo;
    DfxStaticFailed_BuildDfxInfo(tensor, input0, kernelTypeDfxInfo, dfxInfo);

    DfxStaticFailed_RunErrorScenarios(exceptionInfo, fftsAddr, tensor, input0, output0, kernelTypeDfxInfo, dfxInfo);
}

static void TikDynamic_SetupShapeAndArgs(
    uint64_t (&args)[9], const int32_t (&tensor)[6], const float (&input0)[6], const float (&output0)[6],
    const int32_t (&workspace)[3], const uint64_t (&tilingData)[3], uint64_t& atomicIndex)
{
    uint64_t* shapeAddr = static_cast<uint64_t*>(AdumpGetDFXInfoAddrForStatic(13, atomicIndex));
    FillShapeAddr(shapeAddr, MakeShapeInfo());
    SetupTikStyleArgs(args, tensor, input0, output0, workspace, tilingData, atomicIndex);
}

static std::vector<uint8_t> TikDynamic_BuildDfxInfo(const uint64_t (&tilingData)[3], const uint64_t& atomicIndex)
{
    std::vector<uint8_t> dfxInfoValue;
    AppendWithSize(dfxInfoValue, DfxTensorType::GENERAL_TENSOR, DfxPointerType::LEVEL_1_POINTER, NON_TENSOR_SIZE);
    AppendWithSize(dfxInfoValue, DfxTensorType::INPUT_TENSOR, DfxPointerType::LEVEL_1_POINTER, NON_TENSOR_SIZE);
    AppendWithSize(dfxInfoValue, DfxTensorType::OUTPUT_TENSOR, DfxPointerType::LEVEL_1_POINTER, NON_TENSOR_SIZE);
    AppendWithoutSize(dfxInfoValue, DfxTensorType::WORKSPACE_TENSOR, DfxPointerType::LEVEL_1_POINTER);
    AppendWithSize(
        dfxInfoValue, DfxTensorType::TILING_DATA, DfxPointerType::LEVEL_1_POINTER,
        sizeof(tilingData) + sizeof(atomicIndex));
    return WrapTikAndExceptionLE(dfxInfoValue, 1);
}

static void TikDynamic_CheckResult(
    DumpFileChecker& checker, const int32_t (&tensor)[6], const float (&input0)[6], const float (&output0)[6],
    const int32_t (&workspace)[3], const uint64_t (&tilingData)[3], const uint64_t& atomicIndex)
{
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

TEST_F(DumpArgsUtest, Test_Dump_Args_With_Dfx_Tik_Dynamic)
{
    Tools::CaseWorkspace ws("Test_Dump_Args_With_Dfx_Tik_Dynamic");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    rtExceptionInfo exceptionInfo;
    InitExceptionInfo(exceptionInfo, RT_EXCEPTION_AICORE);
    char fftsAddr[] = "ffts addr";
    int32_t tensor[] = {1, 2, 3, 4, 5, 6};
    float input0[] = {1, 2, 3, 4, 5, 6};
    float output0[] = {2, 4, 6, 8, 10, 12};
    int32_t workspace[] = {100, 100, 100};
    uint64_t tilingData[] = {300, 400, 500};

    uint64_t atomicIndex = 0;
    uint64_t args[9] = {};
    TikDynamic_SetupShapeAndArgs(args, tensor, input0, output0, workspace, tilingData, atomicIndex);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);

    auto dfxInfo = TikDynamic_BuildDfxInfo(tilingData, atomicIndex);
    SetDfxInfoAicore(exceptionInfo, dfxInfo, 1);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    std::string expectDumpFilePath = ExpectedArgsDumpFilePath(
        ws.Root(), exceptionInfo.deviceid, exceptionInfo.streamid, exceptionInfo.taskid, stubNowTime);
    DumpFileChecker checker;
    EXPECT_EQ(checker.Load(expectDumpFilePath), true);
    TikDynamic_CheckResult(checker, tensor, input0, output0, workspace, tilingData, atomicIndex);
}

static void DfxFailed_FillShapeAddr(
    const int32_t (&tensor)[6], const float (&input0)[6], const float (&output0)[6], const int32_t (&workspace)[3],
    uint64_t& atomicIndex)
{
    uint64_t* shapeAddr = static_cast<uint64_t*>(AdumpGetDFXInfoAddrForDynamic(13, atomicIndex));
    FillShapeAddr(shapeAddr, MakeShapeInfo(3)); // output0Dim=3 for error test
}

static std::vector<uint8_t> DfxFailed_BuildDfxInfo(const uint64_t (&tilingData)[3], const uint64_t& atomicIndex)
{
    std::vector<uint8_t> dfxInfoValue;
    AppendWithSize(dfxInfoValue, DfxTensorType::GENERAL_TENSOR, DfxPointerType::LEVEL_1_POINTER, NON_TENSOR_SIZE);
    AppendWithSize(dfxInfoValue, DfxTensorType::INPUT_TENSOR, DfxPointerType::LEVEL_1_POINTER, NON_TENSOR_SIZE);
    AppendWithSize(dfxInfoValue, DfxTensorType::OUTPUT_TENSOR, DfxPointerType::LEVEL_1_POINTER, NON_TENSOR_SIZE);
    AppendWithoutSize(dfxInfoValue, DfxTensorType::WORKSPACE_TENSOR, DfxPointerType::LEVEL_1_POINTER);
    AppendWithSize(
        dfxInfoValue, DfxTensorType::TILING_DATA, DfxPointerType::LEVEL_1_POINTER,
        sizeof(tilingData) + sizeof(atomicIndex));
    return WrapTikAndExceptionLE(dfxInfoValue, 0);
}

static void DfxFailed_SetupArgs(
    uint64_t (&args)[9], const int32_t (&tensor)[6], const float (&input0)[6], const float (&output0)[6],
    const int32_t (&workspace)[3], const uint64_t (&tilingData)[3], const uint64_t& atomicIndex)
{
    SetupTikStyleArgs(args, tensor, input0, output0, workspace, tilingData, atomicIndex);
}

static void DfxFailed_RunErrorScenarios(
    rtExceptionInfo& exceptionInfo, uint64_t (&args)[9], const uint64_t& atomicIndex)
{
    // atomicIndex check failed
    uint64_t atomicIndexErr = atomicIndex | 0x040000000;
    args[8] = atomicIndexErr;
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
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
    uint64_t* dynamicChunkBak = g_dynamicChunk;
    g_dynamicChunk = nullptr;
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);
    g_dynamicChunk = dynamicChunkBak;

    // tilling data address is nullptr
    args[4] = reinterpret_cast<uint64_t>(nullptr);
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(DumpArgsUtest, Test_Dump_Args_With_Dfx_Failed)
{
    Tools::CaseWorkspace ws("Test_Dump_Args_With_Dfx_Failed");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    rtExceptionInfo exceptionInfo;
    InitExceptionInfo(exceptionInfo, RT_EXCEPTION_AICORE);
    char fftsAddr[] = "ffts addr";
    int32_t tensor[] = {1, 2, 3, 4, 5, 6};
    float input0[] = {1, 2, 3, 4, 5, 6};
    float output0[] = {2, 4, 6, 8, 10, 12};
    int32_t workspace[] = {100, 100, 100};
    uint64_t tilingData[] = {300, 400, 500};

    uint64_t atomicIndex = 0;
    // get addr failed
    void* addr = AdumpGetDFXInfoAddrForDynamic(DFX_MAX_TENSOR_NUM + 1, atomicIndex);
    EXPECT_EQ(addr, nullptr);
    addr = AdumpGetDFXInfoAddrForStatic(DFX_MAX_TENSOR_NUM + 1, atomicIndex);
    EXPECT_EQ(addr, nullptr);

    DfxFailed_FillShapeAddr(tensor, input0, output0, workspace, atomicIndex);

    auto dfxInfo = DfxFailed_BuildDfxInfo(tilingData, atomicIndex);
    SetDfxInfoAicore(exceptionInfo, dfxInfo, 1);

    uint64_t args[9] = {};
    DfxFailed_SetupArgs(args, tensor, input0, output0, workspace, tilingData, atomicIndex);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);

    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    DfxFailed_RunErrorScenarios(exceptionInfo, args, atomicIndex);
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
    AppendWithoutSize(dfxInfoValue, DfxTensorType::FFTS_ADDRESS, DfxPointerType::LEVEL_1_POINTER);
    AppendWithSize(dfxInfoValue, DfxTensorType::TILING_DATA, DfxPointerType::LEVEL_1_POINTER, 0);
    AppendWithSize(dfxInfoValue, DfxTensorType::GENERAL_TENSOR, DfxPointerType::LEVEL_1_POINTER, NON_TENSOR_SIZE);
    AppendWithSizeErr(dfxInfoValue, DfxTensorType::INPUT_TENSOR, DfxPointerType::LEVEL_1_POINTER, NON_TENSOR_SIZE, 0);

    auto dfxInfo = WrapExceptionBE(dfxInfoValue);
    SetDfxInfoAicore(exceptionInfo, dfxInfo, ELF_DATA2MSB);

    // check tiling data size failed
    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_FAILED);

    void* nullHostMem = nullptr;
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

int32_t halGetVdevNumStub(uint32_t* num_dev)
{
    *num_dev = 1;
    return 0;
}

int32_t halGetVdevIDsStub(uint32_t* devices, uint32_t len)
{
    (void)devices;
    (void)len;
    return 0;
}

static rtError_t rtGetSocVersionStub(char* version, const uint32_t maxLen)
{
    strcpy_s(version, maxLen, "Ascend910_9381");
    return RT_ERROR_NONE;
}

static HcclOpResParam g_opResParam;
static void Mc2Ctx910C_FillShapeAddr(uint64_t& atomicIndex)
{
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

    uint64_t* shapeAddr = static_cast<uint64_t*>(AdumpGetDFXInfoAddrForDynamic(14, atomicIndex));
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
}

static void Mc2Ctx910C_SetupArgs(uint64_t (&args)[6], const uint64_t (&tilingData)[3], const uint64_t& atomicIndex)
{
    args[0] = reinterpret_cast<uint64_t>(&g_opResParam);
    args[1] = reinterpret_cast<uint64_t>(&args[2]);
    args[2] = tilingData[0];
    args[3] = tilingData[1];
    args[4] = tilingData[2];
    args[5] = atomicIndex;
}

static std::vector<uint8_t> Mc2Ctx910C_BuildDfxInfo(const uint64_t (&tilingData)[3], const uint64_t& atomicIndex)
{
    // mc2_ctx + tiling data
    std::vector<uint8_t> dfxInfoValue;
    AppendWithoutSize(dfxInfoValue, DfxTensorType::MC2_CTX, DfxPointerType::LEVEL_1_POINTER);
    AppendWithSize(
        dfxInfoValue, DfxTensorType::TILING_DATA, DfxPointerType::LEVEL_1_POINTER,
        sizeof(tilingData) + sizeof(atomicIndex));
    return WrapTikAndExceptionLE(dfxInfoValue, 1);
}

static void Mc2Ctx910C_CheckResult(
    DumpFileChecker& checker, const uint64_t (&tilingData)[3], const uint64_t& atomicIndex)
{
    EXPECT_EQ(checker.CheckWorkspaceNum(1), true);

    // mc2_ctx
    std::vector<uint8_t> vecData(
        reinterpret_cast<uint8_t*>(&g_opResParam), reinterpret_cast<uint8_t*>(&g_opResParam) + sizeof(HcclOpResParam));
    EXPECT_EQ(checker.CheckWorkspaceSize(0, sizeof(g_opResParam)), true);
    EXPECT_EQ(checker.CheckWorkspaceData(0, vecData), true);

    // tiling data
    EXPECT_EQ(checker.CheckInputTensorSize(0, sizeof(tilingData) + sizeof(atomicIndex)), true);
    uint64_t tmpTilingData[4] = {tilingData[0], tilingData[1], tilingData[2], atomicIndex};
    EXPECT_EQ(checker.CheckInputTensorData(0, GetTensorData(tmpTilingData)), true);
}

TEST_F(DumpArgsUtest, Test_Dump_Args_For_MC2_CTX_910C)
{
    uint32_t v2type = 5; // CHIP_CLOUD_V2
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v2type)).will(returnValue(true));
    MOCKER(rtGetSocVersion).stubs().will(invoke(rtGetSocVersionStub));

    Tools::CaseWorkspace ws("Test_Dump_Args_For_MC2_CTX");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    rtExceptionInfo exceptionInfo;
    InitExceptionInfo(exceptionInfo, RT_EXCEPTION_AICORE);
    char fftsAddr[] = "ffts addr";
    uint64_t tilingData[] = {300, 400, 500};

    uint64_t atomicIndex = 0;
    Mc2Ctx910C_FillShapeAddr(atomicIndex);

    uint64_t args[6] = {};
    Mc2Ctx910C_SetupArgs(args, tilingData, atomicIndex);

    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.argsize = sizeof(args);

    auto dfxInfo = Mc2Ctx910C_BuildDfxInfo(tilingData, atomicIndex);
    SetDfxInfoAicore(exceptionInfo, dfxInfo, 1);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    std::string expectDumpFilePath = ExpectedArgsDumpFilePath(
        ws.Root(), exceptionInfo.deviceid, exceptionInfo.streamid, exceptionInfo.taskid, stubNowTime);
    DumpFileChecker checker;
    EXPECT_EQ(checker.Load(expectDumpFilePath), true);
    Mc2Ctx910C_CheckResult(checker, tilingData, atomicIndex);
}

TEST_F(DumpArgsUtest, Test_Dump_Args_Multi_Thread)
{
    Tools::CaseWorkspace ws("Test_Dump_Args_Multi_Thread");
    SetupKernelMetaDir(ws);
    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    dumpConf.dumpSwitch = 1U << 2; // exception dump with shape
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);

    AicoreArgsFixture f;
    f.Setup();

    std::string fileName = "AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic.json";
    std::string value = "{\n\\\"kernelName\\\": \\\"AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic.json\\\"\n}";
    ws.Touch(fileName);
    ws.Echo(value, fileName, true, false);

    // test collect kernel .o .json file
    (void)setenv("ASCEND_CACHE_PATH", ws.Root().c_str(), 1);
    (void)setenv("ASCEND_CUSTOM_OPP_PATH", ASCEND_CUSTOM_OPP_PATH, 1);
    f.SetKernelBin();
    // multi thread collect same kernel files.
    int32_t ret = 0;
    ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    // multi thread collect different kernel files.
    rtExceptionInfo exceptionInfo2 = f.exceptionInfo;
    std::string kernelName2 = "te_gatherv2_e0258b0a6b5321e318fc35";
    exceptionInfo2.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName2.data();
    exceptionInfo2.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName2.size();
    ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo2);
    ret = DumpManager::Instance().DumpExceptionInfo(f.exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

static void L2Shape_SetupArgs(
    uint64_t (&args)[19], int32_t* shapePtr2t2Float4, int32_t* shapePtr2t3, int32_t* shapePtrPlaceHold,
    int32_t* shapePtrScalar)
{
    // shape tensor for float4
    args[2] = sizeof(uint64_t) * 4;
    args[0] = reinterpret_cast<uint64_t>(&args[2]);
    args[3] = 2 | (1ULL << TENSOR_COUNT_SHIFT_BITS);
    args[4] = 4;
    args[5] = 4;
    args[6] = reinterpret_cast<uint64_t>(shapePtr2t2Float4);

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
    args[16] = reinterpret_cast<uint64_t>(shapePtr2t3);
    args[17] = reinterpret_cast<uint64_t>(shapePtrPlaceHold);
    args[18] = reinterpret_cast<uint64_t>(shapePtrScalar);
}

static std::vector<uint8_t> L2Shape_BuildDfxInfo()
{
    std::vector<uint8_t> dfxInfoValue;
    // shape pointer 1, dataTypeSize unit: bit
    AppendL2Pointer(
        dfxInfoValue, DfxTensorType::OUTPUT_TENSOR, DfxPointerType::LEVEL_2_POINTER_WITH_SHAPE, NON_TENSOR_SIZE, 4);
    // shape pointer 2, dataTypeSize unit: bit
    AppendL2Pointer(
        dfxInfoValue, DfxTensorType::OUTPUT_TENSOR, DfxPointerType::LEVEL_2_POINTER_WITH_SHAPE, NON_TENSOR_SIZE, 4 * 8);
    return WrapKernelAndExceptionLE(dfxInfoValue);
}

static void L2Shape_CheckResult(
    DumpFileChecker& checker, const int32_t (&shapePtr2t2Float4)[2], const int32_t (&shapePtr2t3)[6],
    const int32_t (&shapePtrScalar)[1])
{
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

TEST_F(DumpArgsUtest, Test_Dump_Args_For_L2_Shape)
{
    Tools::CaseWorkspace ws("Test_Dump_Args_For_L2_Shape");
    std::string pluginDir = SetupPluginSoDir(ws);
    MOCKER_CPP(&LibPath::GetTargetPath).stubs().will(returnValue(pluginDir));
    MOCKER(dlopen).stubs().will(invoke(mmDlopen));
    MOCKER(dlsym).stubs().will(invoke(mmDlsym));
    MOCKER(dlclose).stubs().will(returnValue(0));
    MOCKER(dlerror).stubs().will(invoke(mmDlerror));

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::ARGS_EXCEPTION, dumpConf), ADUMP_SUCCESS);
    uint32_t v4type = 15; // diff with 910B/310P
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(v4type)).will(returnValue(true));

    rtExceptionInfo exceptionInfo;
    InitExceptionInfo(exceptionInfo, RT_EXCEPTION_FUSION);
    int32_t shapePtr2t3[] = {2, 2, 2, 3, 3, 3};
    int32_t shapePtr2t2Float4[] = {0x12345678, 0x43218765}; // shape: 4*4, 16bit
    int32_t shapePtrPlaceHold[] = {0, 0, 0};
    int32_t shapePtrScalar[] = {123456};
    uint64_t args[19] = {};
    L2Shape_SetupArgs(args, shapePtr2t2Float4, shapePtr2t3, shapePtrPlaceHold, shapePtrScalar);
    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.argAddr = args;
    exceptionInfo.expandInfo.u.fusionInfo.u.aicoreCcuInfo.exceptionArgs.argsize = sizeof(args);

    auto dfxInfo = L2Shape_BuildDfxInfo();
    SetDfxInfoFusion(exceptionInfo, dfxInfo, 1);

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    int32_t ret = DumpManager::Instance().DumpExceptionInfo(exceptionInfo);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    std::string expectDumpFilePath = ExpectedArgsDumpFilePath(
        ws.Root(), exceptionInfo.deviceid, exceptionInfo.streamid, exceptionInfo.taskid, stubNowTime);
    DumpFileChecker checker;
    EXPECT_TRUE(checker.Load(expectDumpFilePath));
    L2Shape_CheckResult(checker, shapePtr2t2Float4, shapePtr2t3, shapePtrScalar);
}

// 幂等:_host.o 已存在时，DumpHostKernelBin 应跳过写、直接返回成功（提前落盘后，后置慢搜索路径不重复落盘）。
TEST_F(DumpArgsUtest, Test_DumpHostKernelBin_Idempotent)
{
    Tools::CaseWorkspace ws("Test_DumpHostKernelBin_Idempotent");
    const std::string kernelName = "AddCustom_idem";
    MOCKER_CPP(&ExceptionInfoCommon::GetBinDataFromHandle).stubs().will(invoke(StubGetBinDataForIdem));

    KernelInfoCollector collector;
    char fakeHandle[] = "fake_bin_handle";
    ASSERT_EQ(collector.InitFromBinHandle(static_cast<rtBinHandle>(fakeHandle), kernelName), ADUMP_SUCCESS);

    // 首次落盘：文件不存在，正常写入。
    std::string hostOPath;
    EXPECT_EQ(collector.DumpHostKernelBin(ws.Root(), hostOPath), ADUMP_SUCCESS);
    Path hostBinPath(ws.Root());
    hostBinPath.Concat(kernelName + "_host.o");
    EXPECT_TRUE(hostBinPath.Exist());
    // 出参应回填实际落盘路径，且与文件系统上的 _host.o 一致。
    EXPECT_EQ(hostOPath, hostBinPath.GetString());

    // 二次落盘：文件已存在且大小一致。即使 File::Write 被打桩为失败，幂等守卫也应跳过写并返回成功。
    MOCKER_CPP(&File::Write).expects(never());
    EXPECT_EQ(collector.DumpHostKernelBin(ws.Root(), hostOPath), ADUMP_SUCCESS);
    GlobalMockObject::verify();
}

// kernelName 为空时应跳过落盘并返回成功，避免退化成非唯一文件名 "_host.o" 互相覆盖。
TEST_F(DumpArgsUtest, Test_DumpHostKernelBin_EmptyKernelNameSkip)
{
    Tools::CaseWorkspace ws("Test_DumpHostKernelBin_EmptyKernelNameSkip");
    MOCKER_CPP(&ExceptionInfoCommon::GetBinDataFromHandle).stubs().will(invoke(StubGetBinDataForIdem));

    KernelInfoCollector collector;
    char fakeHandle[] = "fake_bin_handle";
    // kernelName 为空
    ASSERT_EQ(collector.InitFromBinHandle(static_cast<rtBinHandle>(fakeHandle), ""), ADUMP_SUCCESS);

    // 前置守卫命中，跳过写、返回成功，且不产生 "_host.o"。
    std::string hostOPath;
    EXPECT_EQ(collector.DumpHostKernelBin(ws.Root(), hostOPath), ADUMP_SUCCESS);
    Path hostBinPath(ws.Root());
    hostBinPath.Concat("_host.o");
    EXPECT_FALSE(hostBinPath.Exist());
}

// 幂等校验基于文件大小:磁盘上残留截断/空文件(部分写)时，Exist() 为真但大小不匹配，应重写而非跳过。
TEST_F(DumpArgsUtest, Test_DumpHostKernelBin_TruncatedFileRewrite)
{
    Tools::CaseWorkspace ws("Test_DumpHostKernelBin_TruncatedFileRewrite");
    const std::string kernelName = "AddCustom_trunc";
    MOCKER_CPP(&ExceptionInfoCommon::GetBinDataFromHandle).stubs().will(invoke(StubGetBinDataForIdem));

    KernelInfoCollector collector;
    char fakeHandle[] = "fake_bin_handle";
    ASSERT_EQ(collector.InitFromBinHandle(static_cast<rtBinHandle>(fakeHandle), kernelName), ADUMP_SUCCESS);

    // 预置一个大小不足的截断文件，模拟上次部分写残留。
    Path hostBinPath(ws.Root());
    hostBinPath.Concat(kernelName + "_host.o");
    {
        std::ofstream truncated(hostBinPath.GetString(), std::ios::binary | std::ios::trunc);
        truncated << "partial"; // 长度短于 g_idemHostBinContent
    }
    ASSERT_TRUE(hostBinPath.Exist());

    // 大小不匹配，幂等守卫不跳过，应重写为完整内容。
    std::string hostOPath;
    EXPECT_EQ(collector.DumpHostKernelBin(ws.Root(), hostOPath), ADUMP_SUCCESS);
    EXPECT_EQ(hostOPath, hostBinPath.GetString());
    std::ifstream rewritten(hostBinPath.GetString(), std::ios::binary);
    std::string content((std::istreambuf_iterator<char>(rewritten)), std::istreambuf_iterator<char>());
    EXPECT_EQ(content, g_idemHostBinContent);
}

// 落盘不完整(写后文件大小不足全长)应经 stat 校验判失败并返回 ADUMP_FAILED，避免截断文件被后续幂等误判为完整。
TEST_F(DumpArgsUtest, Test_DumpHostKernelBin_ShortWriteFail)
{
    Tools::CaseWorkspace ws("Test_DumpHostKernelBin_ShortWriteFail");
    const std::string kernelName = "AddCustom_shortwrite";
    MOCKER_CPP(&ExceptionInfoCommon::GetBinDataFromHandle).stubs().will(invoke(StubGetBinDataForIdem));
    // 打桩 File::Write 返回正值但不实际写入,模拟落盘残缺(文件被 M_TRUNC 建为空,大小不足全长)。
    MOCKER_CPP(&File::Write).stubs().will(returnValue(static_cast<int64_t>(1)));

    KernelInfoCollector collector;
    char fakeHandle[] = "fake_bin_handle";
    ASSERT_EQ(collector.InitFromBinHandle(static_cast<rtBinHandle>(fakeHandle), kernelName), ADUMP_SUCCESS);

    std::string hostOPath;
    EXPECT_EQ(collector.DumpHostKernelBin(ws.Root(), hostOPath), ADUMP_FAILED);
    GlobalMockObject::verify();
}
