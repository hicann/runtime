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
#include "xpu_context.hpp"
#define protected public
#define private public
#include "rts_kernel.h"
#include "tprt.hpp"
#include "utils.h"
#include "json_parse.hpp"
#undef protected
#undef private
#include "xpu_stub.h"

using namespace cce::runtime;

class XpuKernelTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "XpuKernelTest start" << std::endl;
        MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_online));
        MOCKER_CPP(&XpuDevice::ParseXpuConfigInfo).stubs().will(invoke(ParseXpuConfigInfo_mock));
        rtError_t error = rtSetXpuDevice(RT_DEV_TYPE_DPU, 0);
        EXPECT_EQ(error, ACL_RT_SUCCESS);
    }

    static void TearDownTestCase()
    {
        std::cout << "XpuKernelTest end" << std::endl;
        rtResetXpuDevice(RT_DEV_TYPE_DPU, 0);
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};


TEST_F(XpuKernelTest, rtsBinaryLoadFromFile_JsonAndSo_Success_01)
{
    char* binPath = "stub";
    void *binHandle = &binPath;
    MOCKER(mmDlopen)
    .stubs()
    .will(returnValue(binHandle));

    void *funcPc = &binPath;
    MOCKER(mmDlsym)
    .stubs()
    .will(returnValue(funcPc));

    MOCKER(mmDlclose)
    .stubs()
    .will(returnValue(EN_OK));
    char *path = "../tests/ut/runtime/runtime/test/data/libcust_aicpu_kernels.json";
    rtLoadBinaryConfig_t cfg;
    rtLoadBinaryOption_t option;
    option.optionId = RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE;
    option.value.cpuKernelMode = 1; //  0:only json;1:json+so;2:from data
    cfg.numOpt = 1;
    cfg.options = &option;
    rtBinHandle handle;
    rtError_t error = rtsBinaryLoadFromFile(path, &cfg, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Program * prog = reinterpret_cast<Program*>(handle);
    EXPECT_NE(prog->GetKernelByName("AddBlockCust"), nullptr);

    EXPECT_NE(prog->GetKernelByName("ReshapeCust"), nullptr);

    EXPECT_NE(prog->GetKernelByName("UniqueCust"), nullptr);

    error = rtsBinaryUnload(handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(XpuKernelTest, BinaryLoadFromFile_JsonAndSo_mmDlopenNull)
{
    char* binPath = "stub";
    void *binHandle = nullptr;
    MOCKER(mmDlopen)
    .stubs()
    .will(returnValue(binHandle));

    void *funcPc = &binPath;
    MOCKER(mmDlsym)
    .stubs()
    .will(returnValue(funcPc));

    MOCKER(mmDlclose)
    .stubs()
    .will(returnValue(EN_OK));

    char *path = "../tests/ut/runtime/runtime/test/data/libcust_aicpu_kernels.json";
    rtLoadBinaryConfig_t cfg;
    rtLoadBinaryOption_t option;
    option.optionId = RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE;
    option.value.cpuKernelMode = 1; //  0:only json;1:json+so;2:from data
    cfg.numOpt = 1;
    cfg.options = &option;
    rtBinHandle handle;
    rtError_t error = rtsBinaryLoadFromFile(path, &cfg, &handle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(XpuKernelTest, BinaryLoadFromFile_JsonAndSo_FuncPcNull)
{
    char* binPath = "stub";
    void *binHandle = &binPath;
    MOCKER(mmDlopen)
    .stubs()
    .will(returnValue(binHandle));

    void *funcPc = nullptr;
    MOCKER(mmDlsym)
    .stubs()
    .will(returnValue(funcPc));

    MOCKER(mmDlclose)
    .stubs()
    .will(returnValue(EN_OK));

    char *path = "../tests/ut/runtime/runtime/test/data/libcust_aicpu_kernels.json"; // json so文件路径都可以，SetCpuBinInfo会处理so路径 遗留问题：./test/lib/device/lib64/librts_aicpulaunch.so需要改下名字，以及需要check下路径
    rtLoadBinaryConfig_t cfg;
    rtLoadBinaryOption_t option;
    option.optionId = RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE;
    option.value.cpuKernelMode = 1; //  0:only json;1:json+so;2:from data
    cfg.numOpt = 1;
    cfg.options = &option;
    void *handle = nullptr;
    rtError_t error = rtsBinaryLoadFromFile(path, &cfg, &handle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(XpuKernelTest, BinaryLoadFromFile_JsonAndSo_CpuKernelMode0)
{
    char* binPath = "stub";
    void *binHandle = &binPath;
    MOCKER(mmDlopen)
    .stubs()
    .will(returnValue(binHandle));

    void *funcPc = &binPath;
    MOCKER(mmDlsym)
    .stubs()
    .will(returnValue(funcPc));

    MOCKER(mmDlclose)
    .stubs()
    .will(returnValue(EN_OK));

    char *path = "../tests/ut/runtime/runtime/test/data/libcust_aicpu_kernels.json"; // json so文件路径都可以，SetCpuBinInfo会处理so路径 遗留问题：./test/lib/device/lib64/librts_aicpulaunch.so需要改下名字，以及需要check下路径
    rtLoadBinaryConfig_t cfg;
    rtLoadBinaryOption_t option;
    option.optionId = RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE;
    option.value.cpuKernelMode = 0; //  0:only json;1:json+so;2:from data
    cfg.numOpt = 1;
    cfg.options = &option;
    void *handle = nullptr;
    rtError_t error = rtsBinaryLoadFromFile(path, &cfg, &handle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(XpuKernelTest, rtsBinaryLoadFromFile_JsonAndSo_GetJsonObj_Fail)
{
    char* binPath = "stub";
    void *binHandle = &binPath;
    MOCKER(mmDlopen)
    .stubs()
    .will(returnValue(binHandle));

    void *funcPc = &binPath;
    MOCKER(mmDlsym)
    .stubs()
    .will(returnValue(funcPc));

    MOCKER(mmDlclose)
    .stubs()
    .will(returnValue(EN_OK));
    MOCKER(GetJsonObj)
    .stubs()
    .will(returnValue(RT_ERROR_INVALID_VALUE));
    
    char *path = "../tests/ut/runtime/runtime/test/data/libcust_aicpu_kernels.json";
    rtLoadBinaryConfig_t cfg;
    rtLoadBinaryOption_t option;
    option.optionId = RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE;
    option.value.cpuKernelMode = 1; //  0:only json;1:json+so;2:from data
    cfg.numOpt = 1;
    cfg.options = &option;
    rtBinHandle handle;
    rtError_t error = rtsBinaryLoadFromFile(path, &cfg, &handle);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}