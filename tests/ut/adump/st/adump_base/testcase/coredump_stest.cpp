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
#include "adump_pub.h"
#include "dump_manager.h"
#include "dump_args.h"
#include "case_workspace.h"
#include "sys_utils.h"
#include "dump_core.h"
#include "dump_core_checker.h"
#include "adump_platform_api.h"
#include "runtime/mem.h"
#include "dump_file_checker.h"
#include "rt_error_codes.h"

using namespace Adx;

namespace {
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
}

class RuntimeExceptionCallback {
public:
    static RuntimeExceptionCallback &Instance()
    {
        static RuntimeExceptionCallback inst;
        return inst;
    }

    rtTaskFailCallback &MutableCallback()
    {
        return callback_;
    }

    void Invoke(rtExceptionInfo *const exception)
    {
        if (callback_) {
            callback_(exception);
        }
    }

private:
    rtTaskFailCallback callback_;
};

static rtError_t rtRegTaskFailCallbackByModuleStub(const char_t *moduleName, rtTaskFailCallback callback)
{
    RuntimeExceptionCallback::Instance().MutableCallback() = callback;
    return RT_ERROR_NONE;
}

class CoredumpStest : public ::testing::Test {
protected:
    virtual void SetUp()
    {
        SubRuntimeRegExceptionCallback();
    }

    virtual void TearDown()
    {
        ResetExceptionCallback();
        UnsetExceptionDumpEnv();
        GlobalMockObject::verify();
    }

    void SubRuntimeRegExceptionCallback()
    {
        MOCKER(rtRegTaskFailCallbackByModule).stubs().will(invoke(rtRegTaskFailCallbackByModuleStub));
    }

    void ResetExceptionCallback()
    {
        DumpManager::Instance().Reset();
        RuntimeExceptionCallback::Instance().MutableCallback() = nullptr;
    }

    void SetExceptionDumpEnv(const std::string &dumpPath)
    {
        (void)setenv("NPU_COLLECT_PATH", dumpPath.c_str(), 1);
    }

    void UnsetExceptionDumpEnv()
    {
        (void)unsetenv("NPU_COLLECT_PATH");
    }

    void InvokeException(rtExceptionInfo &exceptionInfo)
    {
        RuntimeExceptionCallback::Instance().Invoke(&exceptionInfo);
    }

    void GenLocalMem(uint8_t coreType, uint16_t coreId, std::vector<std::string> &localMemData, std::vector<LocalMemInfo> &localMemInfoList)
    {
        char version[50] = {0};
        rtGetSocVersion(version, 50);
        const std::string socVersion(version);
        BufferSize bufferSize = {0};
        AdumpPlatformApi::GetAicoreSizeInfo(socVersion, bufferSize);

        std::vector<rtDebugMemoryParam_t> memParamList = {
            { CORE_TYPE_AIC, 0, coreId, RT_MEM_TYPE_L0A, 0, 0, 0, 0, bufferSize.l0aSize },
            { CORE_TYPE_AIC, 0, coreId, RT_MEM_TYPE_L0B, 0, 0, 0, 0, bufferSize.l0bSize },
            { CORE_TYPE_AIC, 0, coreId, RT_MEM_TYPE_L0C, 0, 0, 0, 0, bufferSize.l0cSize },
            { CORE_TYPE_AIC, 0, coreId, RT_MEM_TYPE_L1, 0, 0, 0, 0, bufferSize.l1Size },
            { CORE_TYPE_AIV, 0, coreId, RT_MEM_TYPE_UB, 0, 0, 0, 0, bufferSize.ubSize },
        };

        for (auto &memParam : memParamList) {
            if (memParam.coreType != coreType) {
                continue;
            }
            std::string localData(memParam.memLen, 0);
            memParam.dstAddr = reinterpret_cast<uint64_t>(localData.data());

            rtError_t ret = rtDebugReadAICore(&memParam);
            localMemData.emplace_back(std::move(localData));
            LocalMemInfo localMemInfo = {memParam.memLen, 0, 0, memParam.debugMemType, 0};
            localMemInfoList.emplace_back(localMemInfo);
        }
    }
};

TEST_F(CoredumpStest, Test_Dump_Core_With_Dfx_Static) {
    uint32_t devType = 5; // CHIP_CLOUD_V2
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(devType)).will(returnValue(true));
    Tools::CaseWorkspace ws("Test_Dump_Core_With_Dfx_Static");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::AIC_ERR_DETAIL_DUMP, dumpConf), ADUMP_SUCCESS);

    rtSetDevice(0);
    rtSetDevice(0);
    rtDeviceReset(0);
    rtDeviceReset(0);
    rtSetDevice(0);

    std::vector<std::string> globalMem;
    std::vector<GlobalMemInfo> globalMemInfoList;
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
    uint64_t args[22] = {0};
    args[0] = reinterpret_cast<uint64_t>(&fftsAddr);
    args[1] = reinterpret_cast<uint64_t>(&tensor);
    args[2] = reinterpret_cast<uint64_t>(&input0);
    args[3] = reinterpret_cast<uint64_t>(&output0);
    args[4] = reinterpret_cast<uint64_t>(&placehold);
    args[7] = reinterpret_cast<uint64_t>(&workspace);
    args[8] = reinterpret_cast<uint64_t>(&normalPtr1);
    args[9] = reinterpret_cast<uint64_t>(&normalPtr2);
    args[5] = reinterpret_cast<uint64_t>(&args[8]);
    args[10] = sizeof(uint64_t) * 9;        // offset of shapePtr(args[19])
    args[6] = reinterpret_cast<uint64_t>(&args[10]);
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
    // args
    globalMem.emplace_back(reinterpret_cast<char *>(args), sizeof(args));
    GlobalMemInfo argsMemInfo = {reinterpret_cast<uint64_t>(args), sizeof(args), 2, DfxTensorType::ARGS};
    globalMemInfoList.emplace_back(argsMemInfo);

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

    globalMem.emplace_back(reinterpret_cast<char *>(tensor), sizeof(tensor));
    GlobalMemInfo tensorMemInfo = {reinterpret_cast<uint64_t>(tensor), sizeof(tensor), 3, DfxTensorType::GENERAL_TENSOR, .reserve = 0, .extraInfo = {.shape = {2, {1, 6}}}};
    globalMemInfoList.emplace_back(tensorMemInfo);

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

    globalMem.emplace_back(reinterpret_cast<char *>(input0), sizeof(input0));
    GlobalMemInfo input0MemInfo = {reinterpret_cast<uint64_t>(input0), sizeof(input0), 4, DfxTensorType::INPUT_TENSOR, .reserve = 0, .extraInfo = {.shape = {2, {2, 3}}}};
    globalMemInfoList.emplace_back(input0MemInfo);

    // output0
    std::vector<uint8_t> outputDfxInfo;
    StaticL1PointerTensor outputTensor;
    outputTensor.argsType = static_cast<uint16_t>(DfxTensorType::OUTPUT_TENSOR) |
                            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    outputTensor.size = sizeof(output0);
    outputTensor.dim = 2;
    outputTensor.shape = {3, 2};
    generateDfxInfo(outputDfxInfo, outputTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), outputDfxInfo.begin(), outputDfxInfo.end());

    globalMem.emplace_back(reinterpret_cast<char *>(output0), sizeof(output0));
    GlobalMemInfo output0MemInfo = {reinterpret_cast<uint64_t>(output0), sizeof(output0), 5, DfxTensorType::OUTPUT_TENSOR, .reserve = 0, .extraInfo = {.shape = {2, {3, 2}}}};
    globalMemInfoList.emplace_back(output0MemInfo);

    // placehold
    std::vector<uint8_t> placeholdDfxInfo;
    StaticL1PointerTensor placeholdTensor;
    placeholdTensor.argsType = static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
                               (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    placeholdTensor.size = 0;
    placeholdTensor.dim = 2;
    placeholdTensor.shape = {1, 1};
    generateDfxInfo(placeholdDfxInfo, placeholdTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), placeholdDfxInfo.begin(), placeholdDfxInfo.end());

    globalMem.emplace_back("");
    GlobalMemInfo placeholdMemInfo = {reinterpret_cast<uint64_t>(placehold), 0, 5, DfxTensorType::INPUT_TENSOR, .reserve = 0, .extraInfo = {.shape = {2, {1, 1}}}};
    globalMemInfoList.emplace_back(placeholdMemInfo);

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

    globalMem.emplace_back(reinterpret_cast<char *>(shapePtr2t3), sizeof(shapePtr2t3));
    GlobalMemInfo shapePtr2t3MemInfo = {reinterpret_cast<uint64_t>(shapePtr2t3), sizeof(shapePtr2t3), 7, DfxTensorType::OUTPUT_TENSOR, .reserve = 0, .extraInfo = {.shape = {2, {2, 3}}}};
    globalMemInfoList.emplace_back(shapePtr2t3MemInfo);

    globalMem.emplace_back(reinterpret_cast<char *>(shapePtrPlaceHold), sizeof(shapePtrPlaceHold));
    GlobalMemInfo shapePtrPlaceHoldMemInfo = {reinterpret_cast<uint64_t>(shapePtrPlaceHold), sizeof(shapePtrPlaceHold), 8, DfxTensorType::OUTPUT_TENSOR, .reserve = 0, .extraInfo = {.shape = {2, {3, 1}}}};
    globalMemInfoList.emplace_back(shapePtrPlaceHoldMemInfo);

    globalMem.emplace_back(reinterpret_cast<char *>(shapePtrScalar), sizeof(shapePtrScalar));
    GlobalMemInfo shapePtrScalarMemInfo = {reinterpret_cast<uint64_t>(shapePtrScalar), sizeof(shapePtrScalar), 9, DfxTensorType::OUTPUT_TENSOR, .reserve = 0, .extraInfo = {.shape = {1, {1}}}};
    globalMemInfoList.emplace_back(shapePtrScalarMemInfo);

    // workspace
    std::vector<uint8_t> workspaceDfxInfo;
    WithSizeTensor workspaceTensor = {
        static_cast<uint16_t>(DfxTensorType::WORKSPACE_TENSOR) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        sizeof(workspace)};
    generateDfxInfo(workspaceDfxInfo, workspaceTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), workspaceDfxInfo.begin(), workspaceDfxInfo.end());

    globalMem.emplace_back(reinterpret_cast<char *>(workspace), sizeof(workspace));
    GlobalMemInfo workspaceMemInfo = {reinterpret_cast<uint64_t>(workspace), sizeof(workspace), 10, DfxTensorType::WORKSPACE_TENSOR, .reserve = 0, .extraInfo = {.shape = {0, {0, 0}}}};
    globalMemInfoList.emplace_back(workspaceMemInfo);

    // stack
    const void *stackAddr = nullptr;
    uint32_t stackSize = 0;
    rtGetStackBuffer(nullptr, 0, 0, 0, 1, &stackAddr, &stackSize);
    globalMem.emplace_back((const char*)stackAddr);
    GlobalMemInfo stackData1MemInfo = {reinterpret_cast<uint64_t>(stackAddr), stackSize, 11, DfxTensorType::STACK, .reserve = 0, .extraInfo = {.coreInfo = {1}}};
    globalMemInfoList.emplace_back(stackData1MemInfo);
    rtGetStackBuffer(nullptr, 0, 0, 1, 2, &stackAddr, &stackSize);
    globalMem.emplace_back((const char*)stackAddr);
    GlobalMemInfo stackData2MemInfo = {reinterpret_cast<uint64_t>(stackAddr), stackSize, 12, DfxTensorType::STACK, .reserve = 0, .extraInfo = {.coreInfo = {2+25}}};
    globalMemInfoList.emplace_back(stackData2MemInfo);
    rtGetStackBuffer(nullptr, 0, 0, 1, 66, &stackAddr, &stackSize);
    globalMem.emplace_back((const char*)stackAddr);
    GlobalMemInfo stackData3MemInfo = {reinterpret_cast<uint64_t>(stackAddr), stackSize, 13, DfxTensorType::STACK, .reserve = 0, .extraInfo = {.coreInfo = {66+25}}};
    globalMemInfoList.emplace_back(stackData3MemInfo);
    rtGetStackBuffer(nullptr, 0, 0, 1, 67, &stackAddr, &stackSize);
    globalMem.emplace_back((const char*)stackAddr);
    GlobalMemInfo stackData4MemInfo = {reinterpret_cast<uint64_t>(stackAddr), stackSize, 14, DfxTensorType::STACK, .reserve = 0, .extraInfo = {.coreInfo = {67+25}}};
    globalMemInfoList.emplace_back(stackData4MemInfo);

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
    (void)setenv("ASCEND_CACHE_PATH", "./llt/abl/adump/st/", 1);
    (void)setenv("ASCEND_CUSTOM_OPP_PATH", "/abl/adump:/llt/abl/adump:", 1);
    char kernelBin[] = "kernel bin";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(kernelBin);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(kernelBin);
    globalMem.emplace_back(kernelBin);
    GlobalMemInfo binMemInfo = {reinterpret_cast<uint64_t>(kernelBin), sizeof(kernelBin), 15, DfxTensorType::DEVICE_KERNEL_OBJECT, .reserve = 0, .extraInfo = {0}};
    globalMemInfoList.emplace_back(binMemInfo);
    std::string kernelName = "AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    InvokeException(exceptionInfo);

    std::string coredumpFilePath = ws.Root() + "/extra-info/data-dump/" + std::to_string(exceptionInfo.deviceid) +
        "/" + kernelName + "." + std::to_string(exceptionInfo.streamid) + "." + std::to_string(exceptionInfo.taskid) +
        "." + stubNowTime + ".core";

    DumpCoreChecker checker;
    EXPECT_EQ(true, checker.Load(coredumpFilePath));
    DevInfo devInfo = {{0}, exceptionInfo.deviceid, devType};
    rtDebugGetStalledCore(&devInfo.coreInfo);
    EXPECT_EQ(true, checker.CheckDevTbl(devInfo));
    EXPECT_EQ(true, checker.CheckGlobalMem(globalMem, globalMemInfoList));

    std::vector<std::string> localMemData;
    std::vector<LocalMemInfo> localMemInfoList;
    GenLocalMem(0, 1, localMemData, localMemInfoList);
    // icache
    localMemData.emplace_back(kernelBin);
    LocalMemInfo localMemInfo = {sizeof(kernelBin), 0, 0, RT_MEM_TYPE_ICACHE, 0};
    localMemInfoList.emplace_back(localMemInfo);

    // dcache args
    localMemData.emplace_back(reinterpret_cast<char *>(args), sizeof(args));
    localMemInfo.size = sizeof(args);
    localMemInfo.type = RT_MEM_TYPE_DCACHE;
    localMemInfoList.emplace_back(localMemInfo);

    // dcache stack
    rtGetStackBuffer(nullptr, 0, 0, 0, 1, &stackAddr, &stackSize);
    localMemData.emplace_back((const char*)stackAddr);
    localMemInfo.size = stackSize;
    localMemInfo.type = RT_MEM_TYPE_DCACHE;
    localMemInfoList.emplace_back(localMemInfo);
    EXPECT_EQ(true, checker.CheckLocalMem(1, localMemData, localMemInfoList));

    localMemData.clear();
    localMemInfoList.clear();
    GenLocalMem(1, 2, localMemData, localMemInfoList);
    // icache
    localMemData.emplace_back(kernelBin);
    localMemInfo = {sizeof(kernelBin), 0, 0, RT_MEM_TYPE_ICACHE, 0};
    localMemInfoList.emplace_back(localMemInfo);

    // dcache args
    localMemData.emplace_back(reinterpret_cast<char *>(args), sizeof(args));
    localMemInfo.size = sizeof(args);
    localMemInfo.type = RT_MEM_TYPE_DCACHE;
    localMemInfoList.emplace_back(localMemInfo);

    // dcache stack
    rtGetStackBuffer(nullptr, 0, 0, 1, 2, &stackAddr, &stackSize);
    localMemData.emplace_back((const char*)stackAddr);
    localMemInfo.size = stackSize;
    localMemInfo.type = RT_MEM_TYPE_DCACHE;
    localMemInfoList.emplace_back(localMemInfo);
    EXPECT_EQ(true, checker.CheckLocalMem(2 + 25, localMemData, localMemInfoList));

    EXPECT_EQ(true, checker.CheckRegisters<Adx::RegInfo>(1, REG_DATA_VALID));
    rtDeviceReset(0);
    unsetenv("ASCEND_CACHE_PATH");
    unsetenv("ASCEND_CUSTOM_OPP_PATH");
}

TEST_F(CoredumpStest, TEST_CORE_DUMP_FUNC_FAILED) {
    uint32_t type = 5; // CHIP_CLOUD_V2
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(type)).will(returnValue(true));
    Tools::CaseWorkspace ws("Test_Dump_Core_With_Dfx_Static");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::AIC_ERR_DETAIL_DUMP, dumpConf), ADUMP_SUCCESS);

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
    (void)setenv("ASCEND_CACHE_PATH", "./llt/abl/adump/ut/", 1);
    (void)setenv("ASCEND_CUSTOM_OPP_PATH", "/abl/adump:/llt/abl/adump:", 1);
    char binData[] = "BIN_DATA";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(binData);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(binData);
    std::string kernelName = "Custom_3ee04b5d550e4239498c29151be6bb5c_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();

    rtError_t rtError = -1;

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    std::string coredumpFilePath = ws.Root() + "/extra-info/data-dump/" + std::to_string(exceptionInfo.deviceid) +
        "/" + kernelName + "." + std::to_string(exceptionInfo.streamid) + "." + std::to_string(exceptionInfo.taskid) +
        "." + stubNowTime + ".core";

    DumpCoreChecker checker1;
    MOCKER(memcpy_s).stubs().will(returnValue(EN_ERROR));           // memcpy register data failed
    InvokeException(exceptionInfo);
    EXPECT_EQ(true, checker1.Load(coredumpFilePath));
    EXPECT_EQ(true, checker1.CheckRegisters<RegInfo>(1, REG_DATA_INVALID));
    ws.Clean();

    DumpCoreChecker checker2;
    MOCKER(rtDebugReadAICore).stubs().will(returnValue(rtError));   // get register data failed
    InvokeException(exceptionInfo);
    EXPECT_EQ(true, checker2.Load(coredumpFilePath));
    EXPECT_EQ(true, checker2.CheckRegisters<RegInfo>(1, REG_DATA_INVALID));
    ws.Clean();

    DumpCoreChecker checker3;
    MOCKER(rtGetStackBuffer).stubs().will(returnValue(rtError));
    InvokeException(exceptionInfo);
    EXPECT_EQ(true, checker3.Load(coredumpFilePath));
    ws.Clean();

    DumpCoreChecker checker4;
    MOCKER(rtMemcpy).stubs().will(returnValue(rtError));
    InvokeException(exceptionInfo);
    EXPECT_EQ(true, checker4.Load(coredumpFilePath));
    ws.Clean();

    DumpCoreChecker checker5;
    MOCKER(rtMemGetInfoByType).stubs().will(returnValue(rtError));
    InvokeException(exceptionInfo);
    EXPECT_EQ(true, checker5.Load(coredumpFilePath));
    rtDeviceReset(0);
}

template <typename T>
static std::vector<uint8_t> GetTensorData(T &tensor)
{
    std::vector<uint8_t> tensorData;
    tensorData.resize(sizeof(tensor));
    memcpy(tensorData.data(), tensor, sizeof(tensor));
    return tensorData;
}

TEST_F(CoredumpStest, TEST_CORE_DUMP_SWITCH_TO_L0_DUMP)
{
    uint32_t type = 5; // CHIP_CLOUD_V2
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(type)).will(returnValue(true));
    Tools::CaseWorkspace ws("Test_Dump_Core_With_Dfx_Static");
    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::AIC_ERR_DETAIL_DUMP, dumpConf), ADUMP_SUCCESS);

    MOCKER(rtDebugSetDumpMode).stubs().will(returnValue(ACL_ERROR_RT_FEATURE_NOT_SUPPORT));
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
    int32_t placehold[] = {1, 1, 1, 1, 1, 1, 1, 1};
    int32_t normalPtr1[] = {10, 20, 30};
    int32_t normalPtr2[] = {40, 50, 60};
    int32_t shapePtr2t3[] = {2, 2, 2, 3, 3, 3};
    int32_t shapePtrPlaceHold[] = {0, 0, 0};
    int32_t shapePtrScalar[] = {123456};
    int32_t workspace[] = {100, 100, 100};
    uint64_t args[21] = {};
    args[0] = reinterpret_cast<uint64_t>(&fftsAddr);
    args[1] = reinterpret_cast<uint64_t>(&tensor);
    args[2] = reinterpret_cast<uint64_t>(&input0);
    args[3] = reinterpret_cast<uint64_t>(&output0);
    args[4] = reinterpret_cast<uint64_t>(&placehold);
    args[7] = reinterpret_cast<uint64_t>(&workspace);
    args[8] = reinterpret_cast<uint64_t>(&normalPtr1);
    args[9] = reinterpret_cast<uint64_t>(&normalPtr2);
    args[5] = reinterpret_cast<uint64_t>(&args[8]);
    args[10] = sizeof(uint64_t) * 8;
    args[6] = reinterpret_cast<uint64_t>(&args[10]);
    args[11] = 2 | (1ULL << TENSOR_COUNT_SHIFT_BITS);
    args[12] = 2;
    args[13] = 3;
    args[14] = 2 | (1ULL << TENSOR_COUNT_SHIFT_BITS);
    args[15] = 1024;
    args[16] = 0;
    args[17] = 0 | (1ULL << TENSOR_COUNT_SHIFT_BITS);
    args[18] = reinterpret_cast<uint64_t>(&shapePtr2t3);
    args[19] = reinterpret_cast<uint64_t>(&shapePtrPlaceHold);
    args[20] = reinterpret_cast<uint64_t>(&shapePtrScalar);
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
    (void)setenv("ASCEND_CACHE_PATH", "./llt/abl/adump/ut/", 1);
    (void)setenv("ASCEND_CUSTOM_OPP_PATH", "/abl/adump:/llt/abl/adump:", 1);
    char binData[] = "BIN_DATA";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(binData);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(binData);
    std::string kernelName = "Custom_3ee04b5d550e4239498c29151be6bb5c_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = nullptr;
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = 0;

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    InvokeException(exceptionInfo);

    std::string expectDumpFilePath = ExpectedArgsDumpFilePath(ws.Root(), exceptionInfo.deviceid, exceptionInfo.streamid,
                                                              exceptionInfo.taskid, stubNowTime);
    DumpFileChecker checker;
    EXPECT_EQ(checker.Load(expectDumpFilePath), true);
    EXPECT_EQ(checker.CheckInputTensorNum(3), true);
    EXPECT_EQ(checker.CheckOutputTensorNum(4), true);
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
}

TEST_F(CoredumpStest, TEST_CORE_DUMP_CAN_NOT_OFF)
{
    uint32_t type = 5; // CHIP_CLOUD_V2
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(type)).will(returnValue(true));
    Tools::CaseWorkspace ws("Test_Dump_Core_With_Dfx_Static");
    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::AIC_ERR_DETAIL_DUMP, dumpConf), ADUMP_SUCCESS);
    dumpConf.dumpStatus = "off";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::AIC_ERR_DETAIL_DUMP, dumpConf), ADUMP_SUCCESS);
    EXPECT_EQ(true, AdumpIsDumpEnable(DumpType::AIC_ERR_DETAIL_DUMP));
}

TEST_F(CoredumpStest, Test_Dump_Core_David) {
    uint32_t devType = 15; // CHIP_CLOUD_V4
    MOCKER_CPP(&Adx::AdumpDsmi::DrvGetPlatformType).stubs().with(outBound(devType)).will(returnValue(true));
    const std::shared_ptr<Adx::RegisterInterface> reg = std::make_shared<CloudV4Register>();
    MOCKER_CPP(&Adx::RegisterManager::GetRegister).stubs().will(returnValue(reg));
    Tools::CaseWorkspace ws("Test_Dump_Core_David");

    DumpConfig dumpConf;
    dumpConf.dumpPath = ws.Root();
    dumpConf.dumpStatus = "on";
    EXPECT_EQ(AdumpSetDumpConfig(DumpType::AIC_ERR_DETAIL_DUMP, dumpConf), ADUMP_SUCCESS);

    rtSetDevice(0);
    rtSetDevice(0);
    rtDeviceReset(0);
    rtDeviceReset(0);
    rtSetDevice(0);

    std::vector<std::string> globalMem;
    std::vector<GlobalMemInfo> globalMemInfoList;
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
    uint64_t args[22] = {0};
    args[0] = reinterpret_cast<uint64_t>(&fftsAddr);
    args[1] = reinterpret_cast<uint64_t>(&tensor);
    args[2] = reinterpret_cast<uint64_t>(&input0);
    args[3] = reinterpret_cast<uint64_t>(&output0);
    args[4] = reinterpret_cast<uint64_t>(&placehold);
    args[7] = reinterpret_cast<uint64_t>(&workspace);
    args[8] = reinterpret_cast<uint64_t>(&normalPtr1);
    args[9] = reinterpret_cast<uint64_t>(&normalPtr2);
    args[5] = reinterpret_cast<uint64_t>(&args[8]);
    args[10] = sizeof(uint64_t) * 9;        // offset of shapePtr(args[19])
    args[6] = reinterpret_cast<uint64_t>(&args[10]);
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
    // args
    globalMem.emplace_back(reinterpret_cast<char *>(args), sizeof(args));
    GlobalMemInfo argsMemInfo = {reinterpret_cast<uint64_t>(args), sizeof(args), 2, DfxTensorType::ARGS};
    globalMemInfoList.emplace_back(argsMemInfo);

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

    globalMem.emplace_back(reinterpret_cast<char *>(tensor), sizeof(tensor));
    GlobalMemInfo tensorMemInfo = {reinterpret_cast<uint64_t>(tensor), sizeof(tensor), 3, DfxTensorType::GENERAL_TENSOR, .reserve = 0, .extraInfo = {.shape = {2, {1, 6}}}};
    globalMemInfoList.emplace_back(tensorMemInfo);

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

    globalMem.emplace_back(reinterpret_cast<char *>(input0), sizeof(input0));
    GlobalMemInfo input0MemInfo = {reinterpret_cast<uint64_t>(input0), sizeof(input0), 4, DfxTensorType::INPUT_TENSOR, .reserve = 0, .extraInfo = {.shape = {2, {2, 3}}}};
    globalMemInfoList.emplace_back(input0MemInfo);

    // output0
    std::vector<uint8_t> outputDfxInfo;
    StaticL1PointerTensor outputTensor;
    outputTensor.argsType = static_cast<uint16_t>(DfxTensorType::OUTPUT_TENSOR) |
                            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    outputTensor.size = sizeof(output0);
    outputTensor.dim = 2;
    outputTensor.shape = {3, 2};
    generateDfxInfo(outputDfxInfo, outputTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), outputDfxInfo.begin(), outputDfxInfo.end());

    globalMem.emplace_back(reinterpret_cast<char *>(output0), sizeof(output0));
    GlobalMemInfo output0MemInfo = {reinterpret_cast<uint64_t>(output0), sizeof(output0), 5, DfxTensorType::OUTPUT_TENSOR, .reserve = 0, .extraInfo = {.shape = {2, {3, 2}}}};
    globalMemInfoList.emplace_back(output0MemInfo);

    // placehold
    std::vector<uint8_t> placeholdDfxInfo;
    StaticL1PointerTensor placeholdTensor;
    placeholdTensor.argsType = static_cast<uint16_t>(DfxTensorType::INPUT_TENSOR) |
                               (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS);
    placeholdTensor.size = 0;
    placeholdTensor.dim = 2;
    placeholdTensor.shape = {1, 1};
    generateDfxInfo(placeholdDfxInfo, placeholdTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), placeholdDfxInfo.begin(), placeholdDfxInfo.end());

    globalMem.emplace_back("");
    GlobalMemInfo placeholdMemInfo = {reinterpret_cast<uint64_t>(placehold), 0, 5, DfxTensorType::INPUT_TENSOR, .reserve = 0, .extraInfo = {.shape = {2, {1, 1}}}};
    globalMemInfoList.emplace_back(placeholdMemInfo);

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
    shapePointerTensor.dataTypeSize = 4 * 8;
    generateDfxInfo(shapePointerDfxInfo, shapePointerTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), shapePointerDfxInfo.begin(), shapePointerDfxInfo.end());

    globalMem.emplace_back(reinterpret_cast<char *>(shapePtr2t3), sizeof(shapePtr2t3));
    GlobalMemInfo shapePtr2t3MemInfo = {reinterpret_cast<uint64_t>(shapePtr2t3), sizeof(shapePtr2t3), 7, DfxTensorType::OUTPUT_TENSOR, .reserve = 0, .extraInfo = {.shape = {2, {2, 3}}}};
    globalMemInfoList.emplace_back(shapePtr2t3MemInfo);

    globalMem.emplace_back(reinterpret_cast<char *>(shapePtrPlaceHold), sizeof(shapePtrPlaceHold));
    GlobalMemInfo shapePtrPlaceHoldMemInfo = {reinterpret_cast<uint64_t>(shapePtrPlaceHold), sizeof(shapePtrPlaceHold), 8, DfxTensorType::OUTPUT_TENSOR, .reserve = 0, .extraInfo = {.shape = {2, {3, 1}}}};
    globalMemInfoList.emplace_back(shapePtrPlaceHoldMemInfo);

    globalMem.emplace_back(reinterpret_cast<char *>(shapePtrScalar), sizeof(shapePtrScalar));
    GlobalMemInfo shapePtrScalarMemInfo = {reinterpret_cast<uint64_t>(shapePtrScalar), sizeof(shapePtrScalar), 9, DfxTensorType::OUTPUT_TENSOR, .reserve = 0, .extraInfo = {.shape = {1, {1}}}};
    globalMemInfoList.emplace_back(shapePtrScalarMemInfo);

    // workspace
    std::vector<uint8_t> workspaceDfxInfo;
    WithSizeTensor workspaceTensor = {
        static_cast<uint16_t>(DfxTensorType::WORKSPACE_TENSOR) |
            (static_cast<uint16_t>(DfxPointerType::LEVEL_1_POINTER) << POINTER_TYPE_SHIFT_BITS),
        sizeof(workspace)};
    generateDfxInfo(workspaceDfxInfo, workspaceTensor);
    dfxInfoValue.insert(dfxInfoValue.end(), workspaceDfxInfo.begin(), workspaceDfxInfo.end());

    globalMem.emplace_back(reinterpret_cast<char *>(workspace), sizeof(workspace));
    GlobalMemInfo workspaceMemInfo = {reinterpret_cast<uint64_t>(workspace), sizeof(workspace), 10, DfxTensorType::WORKSPACE_TENSOR, .reserve = 0, .extraInfo = {.shape = {0, {0, 0}}}};
    globalMemInfoList.emplace_back(workspaceMemInfo);

    // stack
    const void *stackAddr = nullptr;
    uint32_t stackSize = 0;
    rtGetStackBuffer(nullptr, 0, 0, 0, 1, &stackAddr, &stackSize);
    globalMem.emplace_back((const char*)stackAddr);
    GlobalMemInfo stackData1MemInfo = {reinterpret_cast<uint64_t>(stackAddr), stackSize, 11, DfxTensorType::STACK, .reserve = 0, .extraInfo = {.coreInfo = {1}}};
    globalMemInfoList.emplace_back(stackData1MemInfo);
    rtGetStackBuffer(nullptr, 0, 0, 1, 2, &stackAddr, &stackSize);
    globalMem.emplace_back((const char*)stackAddr);
    GlobalMemInfo stackData2MemInfo = {reinterpret_cast<uint64_t>(stackAddr), stackSize, 12, DfxTensorType::STACK, .reserve = 0, .extraInfo = {.coreInfo = {2+36}}};
    globalMemInfoList.emplace_back(stackData2MemInfo);
    rtGetStackBuffer(nullptr, 0, 0, 1, 66, &stackAddr, &stackSize);
    globalMem.emplace_back((const char*)stackAddr);
    GlobalMemInfo stackData3MemInfo = {reinterpret_cast<uint64_t>(stackAddr), stackSize, 13, DfxTensorType::STACK, .reserve = 0, .extraInfo = {.coreInfo = {66+36}}};
    globalMemInfoList.emplace_back(stackData3MemInfo);
    rtGetStackBuffer(nullptr, 0, 0, 1, 67, &stackAddr, &stackSize);
    globalMem.emplace_back((const char*)stackAddr);
    GlobalMemInfo stackData4MemInfo = {reinterpret_cast<uint64_t>(stackAddr), stackSize, 14, DfxTensorType::STACK, .reserve = 0, .extraInfo = {.coreInfo = {67+36}}};
    globalMemInfoList.emplace_back(stackData4MemInfo);

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
    (void)setenv("ASCEND_CACHE_PATH", "./llt/abl/adump/st/", 1);
    (void)setenv("ASCEND_CUSTOM_OPP_PATH", "/abl/adump:/llt/abl/adump:", 1);
    char kernelBin[] = "kernel bin";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.bin = static_cast<rtBinHandle>(kernelBin);
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.binSize = sizeof(kernelBin);
    globalMem.emplace_back(kernelBin);
    GlobalMemInfo binMemInfo = {reinterpret_cast<uint64_t>(kernelBin), sizeof(kernelBin), 15, DfxTensorType::DEVICE_KERNEL_OBJECT, .reserve = 0, .extraInfo = {0}};
    globalMemInfoList.emplace_back(binMemInfo);
    std::string kernelName = "AddCustom_3ee04b5d550e4239498c29151be6bb5c_mix_aic";
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelName = kernelName.data();
    exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs.exceptionKernelInfo.kernelNameSize = kernelName.size();

    std::string stubNowTime = SysUtils::GetCurrentTimeWithMillisecond();
    MOCKER_CPP(&SysUtils::GetCurrentTimeWithMillisecond).stubs().will(returnValue(stubNowTime));

    InvokeException(exceptionInfo);

    std::string coredumpFilePath = ws.Root() + "/extra-info/data-dump/" + std::to_string(exceptionInfo.deviceid) +
        "/" + kernelName + "." + std::to_string(exceptionInfo.streamid) + "." + std::to_string(exceptionInfo.taskid) +
        "." + stubNowTime + ".core";

    DumpCoreChecker checker;
    EXPECT_EQ(true, checker.Load(coredumpFilePath));
    DevInfo devInfo = {{0}, exceptionInfo.deviceid, devType};
    rtDebugGetStalledCore(&devInfo.coreInfo);
    EXPECT_EQ(true, checker.CheckDevTbl(devInfo));
    EXPECT_EQ(true, checker.CheckGlobalMem(globalMem, globalMemInfoList));

    std::vector<std::string> localMemData;
    std::vector<LocalMemInfo> localMemInfoList;
    GenLocalMem(0, 1, localMemData, localMemInfoList);
    // icache
    localMemData.emplace_back(kernelBin);
    LocalMemInfo localMemInfo = {sizeof(kernelBin), 0, 0, RT_MEM_TYPE_ICACHE, 0};
    localMemInfoList.emplace_back(localMemInfo);

    // dcache args
    localMemData.emplace_back(reinterpret_cast<char *>(args), sizeof(args));
    localMemInfo.size = sizeof(args);
    localMemInfo.type = RT_MEM_TYPE_DCACHE;
    localMemInfoList.emplace_back(localMemInfo);

    // dcache stack
    rtGetStackBuffer(nullptr, 0, 0, 0, 1, &stackAddr, &stackSize);
    localMemData.emplace_back((const char*)stackAddr);
    localMemInfo.size = stackSize;
    localMemInfo.type = RT_MEM_TYPE_DCACHE;
    localMemInfoList.emplace_back(localMemInfo);
    EXPECT_EQ(true, checker.CheckLocalMem(1, localMemData, localMemInfoList));

    localMemData.clear();
    localMemInfoList.clear();
    GenLocalMem(1, 2, localMemData, localMemInfoList);
    // icache
    localMemData.emplace_back(kernelBin);
    localMemInfo = {sizeof(kernelBin), 0, 0, RT_MEM_TYPE_ICACHE, 0};
    localMemInfoList.emplace_back(localMemInfo);

    // dcache args
    localMemData.emplace_back(reinterpret_cast<char *>(args), sizeof(args));
    localMemInfo.size = sizeof(args);
    localMemInfo.type = RT_MEM_TYPE_DCACHE;
    localMemInfoList.emplace_back(localMemInfo);

    // dcache stack
    rtGetStackBuffer(nullptr, 0, 0, 1, 2, &stackAddr, &stackSize);
    localMemData.emplace_back((const char*)stackAddr);
    localMemInfo.size = stackSize;
    localMemInfo.type = RT_MEM_TYPE_DCACHE;
    localMemInfoList.emplace_back(localMemInfo);
    EXPECT_EQ(true, checker.CheckLocalMem(2 + 36, localMemData, localMemInfoList));

    EXPECT_EQ(true, checker.CheckRegisters<RegInfoWide>(1, REG_DATA_VALID));
    rtDeviceReset(0);
    unsetenv("ASCEND_CACHE_PATH");
    unsetenv("ASCEND_CUSTOM_OPP_PATH");
}