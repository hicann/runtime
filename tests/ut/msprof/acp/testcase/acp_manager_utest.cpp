/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mockcpp/mockcpp.hpp"
#include "gtest/gtest.h"
#include "error_code.h"
#include "acp_runtime_stub.h"
#include "acp_api_plugin.h"
#include "msprof_dlog.h"
#include "prof_utils.h"
#include "platform/platform.h"
#include "prof_params.h"
#include "acp_pipe_transfer.h"
#include "op_transport.h"
#include "acp_manager.h"
#include "config_manager.h"

using namespace analysis::dvvp::common::error;
using namespace Collector::Dvvp::Acp;
using namespace ProfAPI;
using namespace analysis::dvvp::transport;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::utils;
class ACP_MANAGER_UTEST : public testing::Test {
protected:
    virtual void SetUp()
    {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

int32_t rtStreamSynchronizeStub(rtStream_t stream)
{
    UNUSED(stream);
    return ACL_RT_SUCCESS;
}

int32_t rtSetDeviceStub(int32_t devId) {
    UNUSED(devId);
    return ACL_RT_SUCCESS;
}

rtError_t rtDevBinaryRegisterStub(const rtDevBinary_t *bin, void **hdl)
{
    UNUSED(bin);
    UNUSED(hdl);
    return ACL_RT_SUCCESS;
}

rtError_t rtDevBinaryUnRegisterStub(void *hdl)
{
    UNUSED(hdl);
    return ACL_RT_SUCCESS;
}

rtError_t rtFunctionRegisterStub(void *binHandle, const void *stubFunc,
                             const char_t *stubName, const void *kernelInfoExt,
                             uint32_t funcMode)
{
    UNUSED(binHandle);
    UNUSED(stubFunc);
    UNUSED(stubName);
    UNUSED(kernelInfoExt);
    UNUSED(funcMode);
    return ACL_RT_SUCCESS;
}

// dynamic operator register
rtError_t rtRegisterAllKernelStub(const rtDevBinary_t *bin, void **hdl)
{
    UNUSED(bin);
    UNUSED(hdl);
    return ACL_RT_SUCCESS;
}

rtError_t rtGetBinaryDeviceBaseAddrStub(void* handle, void** launchBase)
{
    UNUSED(handle);
    UNUSED(launchBase);
    return ACL_RT_SUCCESS;
}

int32_t rtKernelLaunchStub(const void *stubFunc, uint32_t blockDim, void *args, uint32_t argsSize, rtSmDesc_t *smDesc,
    rtStream_t stm)
{
    UNUSED(stubFunc);
    UNUSED(blockDim);
    UNUSED(args);
    UNUSED(argsSize);
    UNUSED(smDesc);
    UNUSED(stm);
    return ACL_RT_SUCCESS;
}

int32_t rtKernelLaunchWithHandleStub(void *hdl, const uint64_t tilingKey, uint32_t blockDim, rtArgsEx_t *argsInfo,
    rtSmDesc_t *smDesc, rtStream_t stm, const void *kernelInfo)
{
    UNUSED(hdl);
    UNUSED(tilingKey);
    UNUSED(blockDim);
    UNUSED(argsInfo);
    UNUSED(kernelInfo);
    UNUSED(smDesc);
    UNUSED(stm);
    return ACL_RT_SUCCESS;
}

int32_t rtKernelLaunchWithHandleV2Stub(void *hdl, const uint64_t tilingKey, uint32_t blockDim, rtArgsEx_t *argsInfo,
    rtSmDesc_t *smDesc, rtStream_t stm, const rtTaskCfgInfo_t *cfgInfo)
{
    UNUSED(hdl);
    UNUSED(tilingKey);
    UNUSED(blockDim);
    UNUSED(argsInfo);
    UNUSED(smDesc);
    UNUSED(stm);
    UNUSED(cfgInfo);
    return ACL_RT_SUCCESS;
}

int32_t rtKernelLaunchWithFlagStub(const void *stubFunc, uint32_t blockDim, rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc,
    rtStream_t stm, uint32_t flags)
{
    UNUSED(stubFunc);
    UNUSED(blockDim);
    UNUSED(argsInfo);
    UNUSED(stm);
    UNUSED(flags);
    return ACL_RT_SUCCESS;
}

int32_t rtKernelLaunchWithFlagV2Stub(const void *stubFunc, uint32_t blockDim, rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc,
    rtStream_t stm, uint32_t flags, const rtTaskCfgInfo_t *cfgInfo)
{
    UNUSED(stubFunc);
    UNUSED(blockDim);
    UNUSED(argsInfo);
    UNUSED(smDesc);
    UNUSED(stm);
    UNUSED(flags);
    UNUSED(cfgInfo);
    return ACL_RT_SUCCESS;
}

rtError_t rtProfSetProSwitchStub(void *data, uint32_t len)
{
    UNUSED(data);
    UNUSED(len);
    return ACL_RT_SUCCESS;
}

int32_t dlcloseStub(void *handle)
{
    return 0;
}

int32_t g_dlopenStubs;
void * dlopenStub(const char *fileName, int mode)
{
    if (strcmp(fileName, "libruntime.so") == 0) {
        return &g_dlopenStubs;
    }
    return nullptr;
}

static int32_t rtMallocStub(void **devPtr, uint64_t size, rtMemType_t type, const uint16_t moduleId)
{
    (void)type;
    (void)moduleId;
    *devPtr = malloc(size);
    return ACL_RT_SUCCESS;
}
 
static int32_t rtFreeStub(void *devPtr)
{
    free(devPtr);
    return ACL_RT_SUCCESS;
}
 
static int32_t rtMemcpyAsyncStub(void *dst, uint64_t destMax, const void *src, uint64_t cnt,
    rtMemcpyKind_t kind, rtStream_t stm)
{
    (void)kind;
    (void)stm;
    memcpy_s(dst, destMax, src, cnt);
    return ACL_RT_SUCCESS;
}

static int32_t rtSetDeviceCount = 0;

static void *dlsymStub(void *handle, const char *symbol) {
    std::string symbolString = symbol;
    if (symbolString == "rtSetDevice") {
        return (void *)rtSetDeviceStub;
    } else if (symbolString == "rtKernelLaunch") {
        return (void *)rtKernelLaunchStub;
    } else if (symbolString == "rtStreamSynchronize") {
        return (void *)rtStreamSynchronizeStub;
    } else if (symbolString == "rtKernelLaunchWithHandle") {
        return (void *)rtKernelLaunchWithHandleStub;
    } else if (symbolString == "rtKernelLaunchWithHandleV2") {
        return (void *)rtKernelLaunchWithHandleV2Stub;
    } else if (symbolString == "rtKernelLaunchWithFlag") {
        return (void *)rtKernelLaunchWithFlagStub;
    } else if (symbolString == "rtKernelLaunchWithFlagV2") {
        return (void *)rtKernelLaunchWithFlagV2Stub;
    } else if (symbolString == "rtProfSetProSwitch") {
        return (void *)rtProfSetProSwitchStub;
    } else if (symbolString == "rtDevBinaryRegister") {
        return (void *)rtDevBinaryRegisterStub;
    } else if (symbolString == "rtDevBinaryUnRegister") {
        return (void *)rtDevBinaryUnRegisterStub;
    } else if (symbolString == "rtFunctionRegister") {
        return (void *)rtFunctionRegisterStub;
    } else if (symbolString == "rtRegisterAllKernel") {
        return (void *)rtRegisterAllKernelStub;
    } else if (symbolString == "rtGetBinaryDeviceBaseAddr") {
        return (void *)rtGetBinaryDeviceBaseAddrStub;
    } else if (symbolString == "rtMalloc") {
        return (void *)rtMallocStub;
    } else if (symbolString == "rtFree") {
        return (void *)rtFreeStub;
    } else if (symbolString == "rtMemcpyAsync") {
        return (void *)rtMemcpyAsyncStub;
    }
    return (void *)0x87654321;
}

TEST_F(ACP_MANAGER_UTEST, AcpRtSetDeviceTest)
{
    // dlopen runtime failed
    MOCKER(dlclose).stubs().will(invoke(dlcloseStub));
    MOCKER(dlopen).stubs().will(invoke(dlopenStub));
    MOCKER(dlsym).stubs().will(invoke(dlsymStub));
    MOCKER_CPP(&AcpManager::TaskStart)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&AcpManager::TaskStop)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&AcpManager::PcSamplingIsEnable)
        .stubs()
        .will(returnValue(true));
    
    int32_t devId = 0;
    EXPECT_EQ(ACL_RT_SUCCESS, rtSetDevice(devId));

    void *ptr = nullptr;
    void **upPtr = reinterpret_cast<void **>(&ptr);
    uint64_t size = static_cast<uint64_t>(sizeof(uint32_t));
    rtMalloc(upPtr, size, 0, 0);

    void *hdl = (void*)0x12345678;
    void *kernelInfo = nullptr;
    void *stubFunc = nullptr;
    uint64_t tilingKey = 0;
    uint32_t flags = 0;
    uint32_t blockDim = 8;
    void *args = nullptr;
    uint32_t argsSize = 10;
    rtSmDesc_t *smDesc = nullptr;
    rtArgsEx_t *argsInfo = { 0 };
    rtTaskCfgInfo_t *cfgInfo = { 0 };
    rtStream_t stm = nullptr;
    uint8_t data = 7;
    rtDevBinary_t bin;
    bin.data = nullptr;
    bin.length = 0;
    rtDevBinary_t bin2;
    bin2.length = 1;
    bin2.data = &data;
    char_t *stubName = "stubName";
    EXPECT_EQ(ACL_RT_SUCCESS, rtDevBinaryRegister(&bin, &hdl));
    EXPECT_EQ(ACL_RT_SUCCESS, rtDevBinaryRegister(&bin2, &hdl));
    EXPECT_EQ(ACL_RT_SUCCESS, rtDevBinaryUnRegister(&hdl));
    EXPECT_EQ(ACL_RT_SUCCESS, rtFunctionRegister(hdl, stubFunc, stubName, kernelInfo, 0));
    EXPECT_EQ(ACL_RT_SUCCESS, rtRegisterAllKernel(&bin, &hdl));
    EXPECT_EQ(ACL_RT_SUCCESS, rtKernelLaunch(stubFunc, blockDim, args, argsSize, smDesc, stm));
    rtFree(ptr);
    rtMalloc(upPtr, size, 0, 0);
    EXPECT_EQ(ACL_RT_SUCCESS, rtKernelLaunchWithHandle(hdl, tilingKey, blockDim, argsInfo, smDesc, stm,
        kernelInfo));
    rtFree(ptr);
    rtMalloc(upPtr, size, 0, 0);
    EXPECT_EQ(ACL_RT_SUCCESS, rtKernelLaunchWithHandleV2(hdl, tilingKey, blockDim, argsInfo, smDesc, stm, cfgInfo));
    rtFree(ptr);
    rtMalloc(upPtr, size, 0, 0);
    EXPECT_EQ(ACL_RT_SUCCESS, rtKernelLaunchWithFlag(stubFunc, blockDim, argsInfo, smDesc, stm, flags));
    rtFree(ptr);
    rtMalloc(upPtr, size, 0, 0);
    EXPECT_EQ(ACL_RT_SUCCESS, rtKernelLaunchWithFlagV2(stubFunc, blockDim, argsInfo, smDesc, stm, flags, cfgInfo));
    rtFree(ptr);
}

TEST_F(ACP_MANAGER_UTEST, AcpManagerTest)
{
    MOCKER_CPP(analysis::dvvp::common::utils::Utils::CreateDir)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::CHIP_CLOUD_V3));
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params = nullptr;
    MSVP_MAKE_SHARED0(params, analysis::dvvp::message::ProfileParams, break);
    EXPECT_NE(params, nullptr);
    do {
        if (params == nullptr) {
            break;
        }
        params->result_dir = "./acp_test_dir";
        params->ai_core_metrics = "PipeUtilization";
        params->instrProfiling = "on";
        params->devices = "0";
        MOCKER_CPP(AcpPipeRead)
            .stubs()
            .will(returnValue(params));
    } while (0);

    MOCKER(dlopen).stubs().will(invoke(dlopenStub));
    MOCKER(dlsym).stubs().will(invoke(dlsymStub));
    MOCKER(dlclose).stubs().will(invoke(dlcloseStub));
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    params->ai_core_metrics = "PipeUtilization,ArithmeticUtilization,Memory";
    MOCKER(AcpPipeRead)
        .stubs()
        .will(returnValue(params));
    AcpManager::instance()->UnInit();
    EXPECT_EQ(PROFILING_SUCCESS, AcpManager::instance()->Init(0));
    AcpManager::instance()->SetKernelReplayMetrics(0);
    AcpManager::instance()->SetKernelReplayMetrics(1);
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::GetAicoreEvents)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    AcpManager::instance()->SetKernelReplayMetrics(2);
    AcpManager::instance()->SetKernelReplayMetrics(2);
    AcpManager::instance()->SetKernelReplayMetrics(2);
    EXPECT_EQ(PROFILING_FAILED, AcpManager::instance()->TaskStart());
    EXPECT_EQ(PROFILING_SUCCESS, AcpManager::instance()->TaskStart());

    EXPECT_EQ(PROFILING_SUCCESS, AcpManager::instance()->TaskStop());
}

drvError_t halGetDeviceInfoSamplingStub(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value) {
    if (moduleType == static_cast<int32_t>(MODULE_TYPE_AICORE) &&
        (infoType == static_cast<int32_t>(INFO_TYPE_CORE_NUM))) {
        *value = 20;
    } else if (moduleType == static_cast<int32_t>(MODULE_TYPE_VECTOR_CORE) &&
        (infoType == static_cast<int32_t>(INFO_TYPE_CORE_NUM))) {
        *value = 40;
    } else if (moduleType == static_cast<int32_t>(MODULE_TYPE_SYSTEM) &&
        (infoType == static_cast<int32_t>(INFO_TYPE_DEV_OSC_FREQUE))) {
        *value = 50000;
    }
    return DRV_ERROR_NONE;
}

TEST_F(ACP_MANAGER_UTEST, ParseDavidPcSamplingData)
{
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(PlatformType::CHIP_CLOUD_V3));
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::AscendHalAdaptor::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER(halGetDeviceInfo)
        .stubs()
        .will(invoke(halGetDeviceInfoSamplingStub));
    Platform::instance()->Init();
    using namespace Analysis::Dvvp::Analyze;
    std::string deviceId = "0";
    auto trans = OpTransportFactory().CreateOpTransport(deviceId);
    EXPECT_NE((ITransport*)NULL, trans.get());
    // stars_soc.data
    std::shared_ptr<analysis::dvvp::ProfileFileChunk> chunk(
        new analysis::dvvp::ProfileFileChunk());
    chunk->chunkModule = analysis::dvvp::common::config::FileChunkDataModule::PROFILING_IS_FROM_MSPROF_DEVICE;
    chunk->fileName = "pc_sampling_group0_aic.data";
    chunk->extraInfo = "./.0";
    char pcSamplingData1[] = {0x5c, 0x11, 0x00, 0x04, 0x05, 0x06, 0x07, 0x08};
    std::string psSampling1(pcSamplingData1, sizeof(pcSamplingData1));
    chunk->chunk = psSampling1;
    chunk->chunkSize = sizeof(pcSamplingData1);
    int ret = trans->SendBuffer(chunk);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    char pcSamplingData2[] = {0x04, 0x05, 0x06, 0x07, 0x08};
    std::string psSampling2(pcSamplingData2, sizeof(pcSamplingData2));
    chunk->chunk = psSampling2;
    chunk->chunkSize = sizeof(pcSamplingData2);
    ret = trans->SendBuffer(chunk);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    chunk->fileName = "end_info.0";
    chunk->extraInfo = "./.0";
    chunk->chunk = psSampling2;
    chunk->chunkSize = sizeof(pcSamplingData2);
    ret = trans->SendBuffer(chunk);
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    Platform::instance()->Uninit();
}

TEST_F(ACP_MANAGER_UTEST, DumpBinary)
{
    GlobalMockObject::verify();
    void *hdl = (void*)0x12345678;
    uint8_t data = 7;
    rtDevBinary_t bin;
    bin.length = 1;
    bin.data = &data;
    AcpManager::instance()->AddBinary(hdl, bin);
    MOCKER(Utils::CanonicalizePath)
        .stubs()
        .will(returnValue(std::string("./")));
    AcpManager::instance()->DumpBinary(hdl);
    remove(AcpManager::instance()->GetBinaryObjectPath().c_str());
    EXPECT_EQ(hdl, AcpManager::instance()->GetBinaryHandle());
    AcpManager::instance()->UnInit();
}

TEST_F(ACP_MANAGER_UTEST, AddBinaryBaseAddr)
{
    GlobalMockObject::verify();
    void *hdl = (void*)0x12345678;
    uint8_t data = 7;
    rtDevBinary_t bin;
    bin.length = 1;
    bin.data = &data;
    AcpManager::instance()->AddBinary(hdl, bin);
    AcpManager::instance()->AddBinaryBaseAddr(hdl, (void *)0x123456);
    EXPECT_EQ(hdl, AcpManager::instance()->GetBinaryHandle());
    AcpManager::instance()->UnInit();
}

TEST_F(ACP_MANAGER_UTEST, AcpManagerCustomBase)
{
    GlobalMockObject::verify();
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::CHIP_CLOUD_V3));
    SHARED_PTR_ALIA<analysis::dvvp::message::ProfileParams> params = nullptr;
    MSVP_MAKE_SHARED0(params, analysis::dvvp::message::ProfileParams, return);
    Platform::instance()->Uninit();
    Platform::instance()->Init();
    params->ai_core_metrics = "Custom:0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9,0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28";
    MOCKER(AcpPipeRead)
        .stubs()
        .will(returnValue(params));
    AcpManager::instance()->Init(0);
    AcpManager::instance()->SetKernelReplayMetrics(0);
    AcpManager::instance()->SetKernelReplayMetrics(1);
    AcpManager::instance()->SetKernelReplayMetrics(2);
    EXPECT_EQ(0, params->ai_core_metrics.compare("Custom:0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28"));
    AcpBackupAttr attr = {nullptr, 0, 0, 0};
    int32_t attrAddr = 1;
    AcpBackupAttr attr2 = {reinterpret_cast<void*>(&attrAddr), 0, 0, 0};
    AcpManager::instance()->RegisterRtMallocFunc(rtMallocStub, rtFreeStub);
    AcpManager::instance()->SaveRtMallocAttr(attr);
    AcpManager::instance()->SaveRtMallocAttr(attr2);
    AcpManager::instance()->ResetMallocMemory(nullptr);
    AcpManager::instance()->UnInit();
    Platform::instance()->Uninit();
}