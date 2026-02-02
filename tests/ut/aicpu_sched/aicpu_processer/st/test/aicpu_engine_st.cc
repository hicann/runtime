/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <limits.h>
#include <stdlib.h>
#include <gtest/gtest.h>
#ifndef RUN_ON_AICPU
#include "mockcpp/mockcpp.hpp"
#endif
#include "aicpu_engine.h"
#include "aicpu_engine_struct.h"
#include "ae_def.hpp"
#define private public
#include "ae_kernel_lib_fwk.hpp"
#include "ae_kernel_lib_aicpu.hpp"
#include "ae_so_manager.hpp"
#include "ae_kernel_lib_manager.hpp"
#undef private
#include <libgen.h>
#include <sys/stat.h>
#include <time.h>
#include <unistd.h>
#include <dlfcn.h>
#include <iostream>
#include <fstream>
#include "aicpu_event_struct.h"
using namespace std;
using namespace testing;
using namespace cce;
using namespace aicpu;

using namespace aicpu::FWKAdapter;

#define SIMPLE_MAIN_FOO  "func_main"
#define SIMPLE_TEST_SO  "libengine_st_simple_so.so"

//extern void aeClear();
class AicpuEngineSTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {

    }

    static void TearDownTestCase()
    {

    }

protected:
    // Some expensive resource shared by all tests.
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
#ifndef RUN_ON_AICPU
        GlobalMockObject::verify();
#endif
    }

public:
    static string GetCwd()
    {
        char cur_work_dir[1024];
        memset(cur_work_dir, 0, 1024);
        getcwd(cur_work_dir,1024);
        return string(cur_work_dir);
    }
    static string get_out_so_dir()
    {
        string cwd = GetCwd();
        return cwd + "/tmp/llt_gcc4.9.3-prefix/src/llt_gcc4.9.3-build/llt/aicpu/aicpu_device/aicpu_processer/st/";
    }


};

void init_simple_str_cce_kernel_with_call_param(HwtsCceKernel *cceKernel, uint64_t paramBase)
{
    cceKernel->kernelName = (uint64_t)SIMPLE_MAIN_FOO;
    cceKernel->kernelSo = (uint64_t)SIMPLE_TEST_SO;
    cceKernel->paramBase = paramBase;
    cceKernel->l2VaddrBase = 0xfee1bee7e7;
    cceKernel->blockId = 1;
    cceKernel->blockNum = 5;
    cceKernel->l2InMain = 0xfefe;
    cceKernel->l2Size = 0xefef;
}


/**
*@test       UT_AICPU_ENGINE_aeClear_08
*- @tspec    aeClear
*- @ttitle   Test for aeClear
*- @tprecon     1. None
*- @tbrief      1. Call aeClear() twice;
*- @texpect     1. No except happened.
*- @tprior   1
*- @tauto TRUE
*- @tremark
*/
/*TEST_F(AicpuEngineSTest, ae_clear)
{
        aeClear();
        aeClear();
}*/

/**
*@test       UT_AICPU_ENGINE_aeClear_08
*- @tspec    aeClear
*- @ttitle   Test for aeClear
*- @tprecon     1. None
*- @tbrief      1. Call aeClear() twice;
*- @texpect     1. No except happened.
*- @tprior   1
*- @tauto TRUE
*- @tremark
*/
TEST_F(AicpuEngineSTest, input_null)
{
    auto ret = aeCallInterface(NULL);
    EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
}

/**
*@test       UT_AICPU_ENGINE_aeCallInterface_02
*- @tspec    aeCallInterface
*- @ttitle   Testing for aeCallInterface when input param "kernelType" is invalid.
*- @tprecon     1.Set input to a valid pointer;
                      2.Set kernelType to KERNEL_TYPE_RESERVED
*- @tbrief      1.Call funtion: aeCallInterface;
                2.Get return status and output;
*- @texpect     1.Return status shold be AE_STATUS_BAD_PARAM;
                2.Should print error log "Input param kernelType is invalid :";
*- @tprior   1
*- @tauto TRUE
*- @tremark
*/
TEST_F(AicpuEngineSTest, str_kernel_param_null)
{
    HwtsTsKernel strKernel;
    {
        strKernel.kernelType = KERNEL_TYPE_RESERVED;
        auto ret = aeCallInterface(&strKernel);
        EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
    }
}



/**
*@test       UT_AICPU_ENGINE_aeCallInterface_03
*- @tspec    aeCallInterface
*- @ttitle   Testing for aeCallInterface when input param kernelName or kernelSo is NULL.
*- @tprecon     1.Set input to a valid pointer;
                      2.Set kernelType to KERNEL_TYPE_CCE;
                      3.Set kernelName or kernelSo to NULL
*- @tbrief      1.Call funtion: aeCallInterface;
                2.Get return status and output;
*- @texpect     1.Return status shold be AE_STATUS_BAD_PARAM;
                2.Should print error log "Input param kernelName is NULL." or Input param kernelSo is NULL.;
*- @tprior   1
*- @tauto TRUE
*- @tremark
*/
TEST_F(AicpuEngineSTest, cc_cce_kernel_param_so_null)
{
    HwtsTsKernel strKernel;
    strKernel.kernelType = KERNEL_TYPE_CCE;

    short pIn[2] = {0x3c00, 0x105e};
    short pOut[2] = {0};
    short *addr[2] = {pOut, pIn};

    HwtsCceKernel *cceKernel = (HwtsCceKernel *)&strKernel.kernelBase;

    init_simple_str_cce_kernel_with_call_param(cceKernel, (uint64_t)addr);

    {
        cceKernel->kernelName = (uint64_t)SIMPLE_MAIN_FOO;
        cceKernel->kernelSo = (uint64_t)NULL;
        auto ret = aeCallInterface(&strKernel);
        EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
    }

}

TEST_F(AicpuEngineSTest, cc_cce_kernel_param_func_null)
{
    HwtsTsKernel strKernel;
    strKernel.kernelType = KERNEL_TYPE_CCE;

    short pIn[2] = {0x3c00, 0x105e};
    short pOut[2] = {0};
    short *addr[2] = {pOut, pIn};
    HwtsCceKernel *cceKernel = (HwtsCceKernel *)&strKernel.kernelBase;

    init_simple_str_cce_kernel_with_call_param(cceKernel, (uint64_t)addr);

    {
        cceKernel->kernelName = (uint64_t)NULL;
        cceKernel->kernelSo = (uint64_t)SIMPLE_TEST_SO;
        auto ret = aeCallInterface(&strKernel);
        EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
    }

}


TEST_F(AicpuEngineSTest, cc_cce_kernel_param_so_a_func_null)
{
    HwtsTsKernel strKernel;
    strKernel.kernelType = KERNEL_TYPE_CCE;

    short pIn[2] = {0x3c00, 0x105e};
    short pOut[2] = {0};
    short *addr[2] = {pOut, pIn};
    HwtsCceKernel *cceKernel = (HwtsCceKernel *)&strKernel.kernelBase;

    init_simple_str_cce_kernel_with_call_param(cceKernel, (uint64_t)addr);

    {
        cceKernel->kernelName = (uint64_t)NULL;
        cceKernel->kernelSo = (uint64_t)NULL;
        auto ret = aeCallInterface(&strKernel);
        EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
    }

}

#ifndef RUN_ON_AICPU
/**
*@test       UT_AICPU_ENGINE_aeCallInterface_08
*- @tspec    aeCallInterface
*- @ttitle   Testing for aeCallInterface when fwkKernelType in input param is invalid.
*- @tprecon     1.Set input to a valid pointer;
                      2.Set kernelType to KERNEL_TYPE_FWK;
                      3.Set fwkKernelType  FMK_KERNEL_TYPE_CAFFE/FMK_KERNEL_TYPE_PYTORCH/FMK_KERNEL_TYPE_RESERVED
*- @tbrief      1.Call funtion: aeCallInterface;
                2.Get return status and output;
*- @texpect     1.Return status shold be AE_STATUS_BAD_PARAM;
                2.Should print error log "Input param fwkKernelType in STR_FWK_OP_KERNEL is invalid";
*- @tprior   1
*- @tauto TRUE
*- @tremark
*/
TEST_F(AicpuEngineSTest, cc_fwk_tf_kernel_param_invalid)
{
    HwtsTsKernel strKernel;
    int32_t ret;
    strKernel.kernelType = KERNEL_TYPE_FWK;
    HwtsFwkKernel *fwkKernel = (HwtsFwkKernel *)&strKernel.kernelBase;
    {
        fwkKernel->kernel = (uint64_t)NULL;
        ret = aeCallInterface(&strKernel);
        EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
    }

    {
        FWKOperateParam tfKernel;
        tfKernel.opType = FWK_ADPT_KERNEL_RUN;
        STR_FWK_OP_KERNEL fwkOpKernel;
        fwkOpKernel.fwkKernelBase.fwk_kernel = tfKernel;
        fwkKernel->kernel = (uint64_t)&fwkOpKernel;

        fwkOpKernel.fwkKernelType = FMK_KERNEL_TYPE_CF;
        ret = aeCallInterface(&strKernel);
        EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);

        fwkOpKernel.fwkKernelType = FMK_KERNEL_TYPE_PT;
        ret = aeCallInterface(&strKernel);
        EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);

        fwkOpKernel.fwkKernelType = FMK_KERNEL_TYPE_RESERVED;
        ret = aeCallInterface(&strKernel);
        EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
    }

}

const string &stubTfSoFile()
{
    static const string soFile(AicpuEngineSTest::get_out_so_dir() + SIMPLE_TEST_SO);
    return soFile;
}

const string &stubNoSuchSoFile()
{
    static const string noSuchSo("no_such_so.so");
    return noSuchSo;
}

const string &stubNoSuchFuncName()
{
    static const string noSuchFuncName("stubNoSuchFuncName");
    return noSuchFuncName;
}

aicpu::status_t GetAicpuRunModeStub(aicpu::AicpuRunMode &runMode)
{
    runMode = aicpu::AicpuRunMode::THREAD_MODE;
    return aicpu::AICPU_ERROR_NONE;
}

/**
*@test       UT_AICPU_ENGINE_aeCallInterface_09
*- @tspec    aeCallInterface
*- @ttitle   Testing for aeCallInterface when tf so file is error.
*- @tprecon     1.Set input to a valid pointer;
                      2.Set kernelType to FMK_KERNEL_TYPE_TF;
                      3.Stub so file of tensorflow is invalid.
*- @tbrief      1.Call funtion: aeCallInterface;
                2.Get return status and output;
*- @texpect     1.Return status shold be AE_STATUS_OPEN_SO_FAILED;
                2.Should print error log "Open so failed with error:"
*- @tprior   1
*- @tauto TRUE
*- @tremark
*/
TEST_F(AicpuEngineSTest, cc_fwk_tf_kernel_no_such_so)
{
    HwtsTsKernel strKernel;
    int32_t ret;
    strKernel.kernelType = KERNEL_TYPE_FWK;
    HwtsFwkKernel *fwkKernel = (HwtsFwkKernel *)&strKernel.kernelBase;
    {
        GlobalMockObject::verify();
        MOCKER_CPP(&cce::FWKKernelTfImpl::GetSoFile).stubs().will(invoke(stubNoSuchSoFile));

        FWKOperateParam tfKernel;
        tfKernel.opType = FWK_ADPT_KERNEL_RUN;
        STR_FWK_OP_KERNEL fwkOpKernel;
        fwkOpKernel.fwkKernelBase.fwk_kernel = tfKernel;
        fwkKernel->kernel = (uint64_t)&fwkOpKernel;

        fwkOpKernel.fwkKernelType = FMK_KERNEL_TYPE_TF;
        MOCKER_CPP(&FWKKernelTfImpl::GetTensorflowThreadModeSoPath).stubs().will(returnValue(0));
        ret = aeCallInterface(&strKernel);
        EXPECT_EQ(AE_STATUS_OPEN_SO_FAILED, ret);
      }

}

/**
*@test       UT_AICPU_ENGINE_aeCallInterface_11
*- @tspec    aeCallInterface
*- @ttitle   Testing for aeCallInterface
*- @tprecon     1.Set input to a valid pointer;
                      2.Set kernelType to FMK_KERNEL_TYPE_TF;
                      3.Set valid input to call api in tf so lib.
*- @tbrief      1.Call funtion: aeCallInterface;
                2.Get return status and output;
*- @texpect     1.Return status shold be AE_STATUS_SUCCESS;
                2. optype would add one;
*- @tprior   1
*- @tauto TRUE
*- @tremark
*/
TEST_F(AicpuEngineSTest, cc_cdclose_error)
{
    GlobalMockObject::verify();
    MOCKER(&dlclose).stubs().will(returnValue(-1));
    aeClear();
    auto aiKernelsLibAicpu = cce::AIKernelsLibAiCpu::GetInstance();
    EXPECT_NE(aiKernelsLibAicpu, nullptr);
}

/**
*@test       UT_AICPU_ENGINE_aeCallInterface_12
*- @tspec    aeCallInterface
*- @ttitle   Testing for aeCallInterface
*- @tprecon     1.Set input to a valid pointer;
                      2.Set kernelType to FMK_KERNEL_TYPE_TF;
                      3.Set valid input to call api in tf so lib.
                      4. set optype == 0x383f
*- @tbrief      1.Call funtion: aeCallInterface;
                2.Get return status and output;
*- @texpect     1.Return status shold be AE_STATUS_KERNEL_API_INNER_ERROR;
                2.Should print error log "Call tf api return failed:";
*- @tprior   1
*- @tauto TRUE
*- @tremark
*/
TEST_F(AicpuEngineSTest, cc_fwk_tf_kernel_call_api_inner_error)
{
    HwtsTsKernel strKernel;
    int32_t ret;
    strKernel.kernelType = KERNEL_TYPE_FWK;
    HwtsFwkKernel *fwkKernel = (HwtsFwkKernel *)&strKernel.kernelBase;
    GlobalMockObject::verify();
    MOCKER_CPP(&cce::FWKKernelTfImpl::GetSoFile).stubs().will(invoke(stubTfSoFile));
    {
        STR_FWK_OP_KERNEL fwkOpKernel;
        fwkOpKernel.fwkKernelBase.fwk_kernel.opType = (enum FWKOperateType)0x383f;
        fwkKernel->kernel = (uint64_t)&fwkOpKernel;

        fwkOpKernel.fwkKernelType = FMK_KERNEL_TYPE_TF;
        MOCKER_CPP(&FWKKernelTfImpl::GetTensorflowThreadModeSoPath).stubs().will(returnValue(0));
        ret = aeCallInterface(&strKernel);
        EXPECT_NE(AE_STATUS_SUCCESS, ret);
    }
}

static aeStatus_t stubSingleGetApi(const char *soFile, const char *funcName, void **funcAddrPtr, void **retHandle)
{
    *funcAddrPtr = NULL;
    return AE_STATUS_SUCCESS;
}

static aeStatus_t stubInstanceInit()
{
    return AE_STATUS_INNER_ERROR;
}

TEST_F(AicpuEngineSTest, cc_fwk_tf_kernel_get_api_inner_error)
{
    HwtsTsKernel strKernel;
    int32_t ret;
    strKernel.kernelType = KERNEL_TYPE_FWK;
    HwtsFwkKernel *fwkKernel = (HwtsFwkKernel *)&strKernel.kernelBase;
    aeClear();
    GlobalMockObject::verify();
    //MOCKER_CPP(&SingleSoManager::GetFunc).stubs().will(invoke(stubSingGetFunc));
    MOCKER(
        cce::SingleSoManager::GetApi, aeStatus_t(const char_t *, const char_t *, void **, void **))
        .stubs()
        .will(invoke(stubSingleGetApi));
    {
        STR_FWK_OP_KERNEL fwkOpKernel;
        fwkOpKernel.fwkKernelBase.fwk_kernel.opType = (enum FWKOperateType)0x383f;
        fwkKernel->kernel = (uint64_t)&fwkOpKernel;

        fwkOpKernel.fwkKernelType = FMK_KERNEL_TYPE_TF;
        MOCKER_CPP(&FWKKernelTfImpl::GetTensorflowThreadModeSoPath).stubs().will(returnValue(0));
        ret = aeCallInterface(&strKernel);
        EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
    }
}

TEST_F(AicpuEngineSTest, cc_fwk_AIKernelsLibFWK_call_test)
{
    int32_t ret = AIKernelsLibFWK::GetInstance()->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, nullptr);
    EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
}

TEST_F(AicpuEngineSTest, aeBatchLoadKernelSo)
{
    const char *aicpuKernelSoName = "libaicpu_kernels.so";
    const char *cpuKernelSoName = "libcpu_kernels.so";
    const char *tfKernelSoName = "libtf_kernels.so";
    const uint32_t loadSoNum = 3;
    const char *soNames[loadSoNum] = {aicpuKernelSoName, cpuKernelSoName, tfKernelSoName};
    aeStatus_t ret = aeBatchLoadKernelSo(aicpu::KERNEL_TYPE_AICPU, loadSoNum, soNames);
    EXPECT_EQ(AE_STATUS_SUCCESS, ret);
}

TEST_F(AicpuEngineSTest, aeBatchLoadKernelSo_Success1)
{
    MOCKER_CPP(&cce::SingleSoManager::Init)
        .stubs()
        .will(returnValue(AE_STATUS_SUCCESS));
    const char *aicpuKernelSoName = "libaicpu_kernels.so";
    const char *cpuKernelSoName = "libcpu_kernels.so";
    const char *tfKernelSoName = "libtf_kernels.so";
    const uint32_t loadSoNum = 3;
    const char *soNames[loadSoNum] = {aicpuKernelSoName, cpuKernelSoName, tfKernelSoName};
    aeStatus_t ret = aeBatchLoadKernelSo(aicpu::KERNEL_TYPE_AICPU, loadSoNum, soNames);
    EXPECT_EQ(AE_STATUS_SUCCESS, ret);
}

TEST_F(AicpuEngineSTest, aeBatchLoadKernelSo_Success2)
{
    MOCKER_CPP(&cce::SingleSoManager::Init)
        .stubs()
        .will(returnValue(AE_STATUS_SUCCESS));
    const char *tfKernelSoName = "libtf_kernels.so";
    const uint32_t loadSoNum = 1;
    const char *soNames[loadSoNum] = {tfKernelSoName};
    aeStatus_t ret = aeBatchLoadKernelSo(aicpu::KERNEL_TYPE_AICPU, loadSoNum, soNames);
    EXPECT_EQ(AE_STATUS_SUCCESS, ret);
}

TEST_F(AicpuEngineSTest, GetAicpuKernelLib_SUCCESS)
{
    setenv("ASCEND_AICPU_KERNEL_PATH", "/usr/lib64/", 1);
    setenv("ASCEND_CUST_AICPU_KERNEL_CACHE_PATH", "/usr/lib64/", 1);
    cce::AIKernelsLibManger::ClearKernelLib(KERNEL_TYPE_AICPU);
    cce::AIKernelsLibBase *aiKernelsLibAicpu;
    aeStatus_t ret = cce::AIKernelsLibManger::GetKernelLib(KERNEL_TYPE_AICPU, aiKernelsLibAicpu);
    const char *custDirName = getenv("ASCEND_CUST_AICPU_KERNEL_CACHE_PATH");
    if (custDirName != nullptr) {
        printf("custDirName is %s\n", custDirName);
    } else {
        printf("custDirName is null.\n");
    }
    cce::AIKernelsLibManger::ClearKernelLib(KERNEL_TYPE_AICPU);
    EXPECT_EQ(AE_STATUS_SUCCESS, ret);
}

static int32_t DvppKernelSuccessStub(void *x)
{
    return 0;
}
static aeStatus_t StubMultileGetApi(cce::MultiSoManager *, aicpu::KernelType kernelType,
                                            const char *soName, const char *funcName,
                                            void **funcAddrPtr)
{
    *funcAddrPtr = (void *) DvppKernelSuccessStub;
    return AE_STATUS_SUCCESS;
}

TEST_F(AicpuEngineSTest, GetInstanceInit_FAIL)
{
    MOCKER_CPP(&cce::MultiSoManager::Init).stubs().will(invoke(stubInstanceInit));
    MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(returnValue(AICPU_ERROR_FAILED));
    
    cce::AIKernelsLibAiCpu::DestroyInstance();
    auto aiKernelsLibAicpu = cce::AIKernelsLibAiCpu::GetInstance();
    EXPECT_EQ(aiKernelsLibAicpu, nullptr);
}

TEST_F(AicpuEngineSTest, GetInstance_FAIL)
{
    MOCKER_CPP(&cce::MultiSoManager::Init).stubs().will(invoke(stubInstanceInit));
    auto aiKernelsLibAicpu = cce::AIKernelsLibAiCpu::GetInstance();
    EXPECT_EQ(aiKernelsLibAicpu, nullptr);
}

TEST_F(AicpuEngineSTest, CallKernelApi_SUC2)
{
    auto aiKernelsLibAicpu = cce::AIKernelsLibAiCpu::GetInstance();
    MOCKER_CPP(&cce::MultiSoManager::GetApi).stubs().will(invoke(StubMultileGetApi));
    std::string kernelSo = {"libTest.so"};
    std::string kernelName = {"TestFun"};
    aicpu::HwtsCceKernel kernel;
    kernel.kernelSo = (uintptr_t) kernelSo.data();
    kernel.kernelName = (uintptr_t) kernelName.data();
    int32_t ret = aiKernelsLibAicpu->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel);

    aiKernelsLibAicpu->CloseSo(kernelName.c_str());
    aiKernelsLibAicpu->DestroyInstance();

    EXPECT_EQ(AE_STATUS_SUCCESS, ret);
}

TEST_F(AicpuEngineSTest, TransformKernelErrorCodeSilentFault)
{
    const auto ret = cce::AIKernelsLibAiCpu::GetInstance()->TransformKernelErrorCode(501, "libaicpu.so", "silenfault");
    EXPECT_EQ(ret, AE_STATUS_SILENT_FAULT);
}

TEST_F(AicpuEngineSTest, TransformKernelErrorCodeDetectFault)
{
    const auto ret = cce::AIKernelsLibAiCpu::GetInstance()->TransformKernelErrorCode(502, "libaicpu.so", "detectfault");
    EXPECT_EQ(ret, AE_STATUS_DETECT_FAULT);
}

TEST_F(AicpuEngineSTest, TransformKernelErrorCodeDetectFaultNoRas)
{
    const auto ret = cce::AIKernelsLibAiCpu::GetInstance()->TransformKernelErrorCode(503, "libaicpu.so", "detectfault");
    EXPECT_EQ(ret, AE_STATUS_DETECT_FAULT_NORAS);
}

TEST_F(AicpuEngineSTest, TransformKernelErrorCodeDetectLowBitFault)
{
    const auto ret = cce::AIKernelsLibAiCpu::GetInstance()->TransformKernelErrorCode(504, "libaicpu.so", "detectfault");
    EXPECT_EQ(ret, AE_STATUS_DETECT_LOW_BIT_FAULT);
}

TEST_F(AicpuEngineSTest, TransformKernelErrorCodeDetectLowBitFaultNoRas)
{
    const auto ret = cce::AIKernelsLibAiCpu::GetInstance()->TransformKernelErrorCode(505, "libaicpu.so", "detectfault");
    EXPECT_EQ(ret, AE_STATUS_DETECT_LOW_BIT_FAULT_NORAS);
}

TEST_F(AicpuEngineSTest, DestroyInstance_01) {
    AIKernelsLibFWK::DestroyInstance();
    EXPECT_EQ(AIKernelsLibFWK::instance_, nullptr);
}

TEST_F(AicpuEngineSTest, DestroyInstance_02) {
    AIKernelsLibFWK *instance = AIKernelsLibFWK::GetInstance();
    EXPECT_NE(instance, nullptr);
    EXPECT_NE(AIKernelsLibFWK::instance_, nullptr);
    AIKernelsLibFWK::DestroyInstance();
    EXPECT_EQ(AIKernelsLibFWK::instance_, nullptr);
}

TEST_F(AicpuEngineSTest, TransformKernelErrorCode) {
    auto ret = FWKKernelTfImpl::TransformKernelErrorCode(0, 1000);
    EXPECT_EQ(ret, AE_STATUS_SUCCESS);
    ret = FWKKernelTfImpl::TransformKernelErrorCode(aicpu::FWKAdapter::FWK_ADPT_NATIVE_END_OF_SEQUENCE, 1000);
    EXPECT_EQ(ret, AE_STATUS_END_OF_SEQUENCE);
    ret = FWKKernelTfImpl::TransformKernelErrorCode(3, 1000);
    EXPECT_EQ(ret, 3);
}

TEST_F(AicpuEngineSTest, aeCloseSo_Success)
{
    std::string soName("libcpu_kernels.so");
    aeStatus_t ret = aeCloseSo(aicpu::KERNEL_TYPE_AICPU_CUSTOM, soName.c_str());
    EXPECT_EQ(AE_STATUS_SUCCESS, ret);
}

TEST_F(AicpuEngineSTest, aeCloseSoNullptr_Fail)
{
    aeStatus_t ret = aeCloseSo(aicpu::KERNEL_TYPE_AICPU_CUSTOM, nullptr);
    EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
}
 
TEST_F(AicpuEngineSTest, BatchLoadEmptySo_Success)
{
    std::vector<std::string> aicpuSoVec;
    aeStatus_t ret = AIKernelsLibAiCpu::GetInstance()->BatchLoadKernelSo(aicpu::KERNEL_TYPE_AICPU_CUSTOM, aicpuSoVec);
    EXPECT_EQ(AE_STATUS_SUCCESS, ret);
}

TEST_F(AicpuEngineSTest, Init_001) {
    setenv("HOME", "/usr/lib64/", 1);
    AIKernelsLibFWK *instance = AIKernelsLibFWK::GetInstance();
    const auto ret = instance->Init();
    EXPECT_EQ(AE_STATUS_SUCCESS, ret);
}

TEST_F(AicpuEngineSTest, Init_002) {
    setenv("ASCEND_AICPU_PATH", "/usr/lib64/", 1);
    AIKernelsLibFWK *instance = AIKernelsLibFWK::GetInstance();
    const auto ret = instance->Init();
    EXPECT_EQ(AE_STATUS_SUCCESS, ret);
}

TEST_F(AicpuEngineSTest, Init_003) {
    setenv("HOME", "/usr/lib64/", 1);
    MOCKER(aicpu::GetAicpuRunMode).stubs().will(invoke(GetAicpuRunModeStub));
    AIKernelsLibFWK *instance = AIKernelsLibFWK::GetInstance();
    const auto ret = instance->Init();
    EXPECT_EQ(AE_STATUS_SUCCESS, ret);
}

TEST_F(AicpuEngineSTest, AeAddSoInWhiteList)
{
    const char_t * const soName = "789.so";
    AeDeleteSoInWhiteList(soName);
    AeDeleteSoInWhiteList(nullptr);
    aeStatus_t ret = AeAddSoInWhiteList(soName);
    EXPECT_EQ(AE_STATUS_SUCCESS, ret);
    ret = AeAddSoInWhiteList(nullptr);
    EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
}
#endif
