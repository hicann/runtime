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
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"
#include "aicpu_engine.h"
#include "aicpu_engine_struct.h"
#include "ae_def.hpp"
#define private public
#include "ae_kernel_lib_fwk.hpp"
#include "ae_so_manager.hpp"
#include "ae_kernel_lib_manager.hpp"
#undef private
#include<pwd.h>
#include <sys/stat.h>
#include <unistd.h>
#include <libgen.h>
#include <dlfcn.h>
#include <iostream>
#include <fstream>
#include "securec.h"
#include "aicpu_event_struct.h"
#include "ae_kernel_lib_aicpu.hpp"

using namespace std;
using namespace testing;
using namespace cce;
using namespace aicpu;

using namespace aicpu::FWKAdapter;


#define SIMPLE_MAIN_FOO  "func_main"
#define SIMPLE_TEST_SO  "libengine_ut_simple_so.so"

class AicpuEngineUTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        printf("AicpuEngineUTest  SetUpTestCase :%s\n", get_work_so_dir().data());
    }

    static void TearDownTestCase()
    {
        printf("AicpuEngineUTest TearDownTestCase \n");
    }

public:
    static string GetCwd()
    {
        char cur_work_dir[1024];
        memset(cur_work_dir, 0, 1024);
        getcwd(cur_work_dir,1024);
        return string(cur_work_dir);
    }


    static void so_copy(string src, string dst)
    {
        using namespace std;

        ifstream in(src,ios::binary);
        ofstream out(dst,ios::binary);

        cout << "COPY " << src << " TO " << dst << endl;
        if (!in.is_open()) {
            cout << "ERROR: open file " << src << endl;
            return ;
        }
        if (!out.is_open()) {
            cout << "ERROR: open file " << dst << endl;
            return ;
        }
        if (src == dst) {
            cout << "ERROR: the src file can't be same with dst file" << endl;
            return ;
        }
        char buf[2048];
        long long totalBytes = 0;
        while(in)
        {
            in.read(buf, 2048);
            out.write(buf, in.gcount());
            totalBytes += in.gcount();
        }
        in.close();
        out.close();
    }

    static string get_work_so_dir()
    {
        struct passwd* user = getpwuid(getuid());
        if (user == nullptr || user->pw_dir == nullptr) {
            cout << "ERROR: user or user->pw_dir is nullptr!" << endl;
            return "/";
        }
        char pidTmpDir[PATH_MAX + 1] = {0};
        __pid_t pid = getpid();
        int ret = sprintf_s(pidTmpDir, sizeof(pidTmpDir), "%s/tmp/%d/", user->pw_dir, pid);
        if (ret == -1) {
            cout << "ERROR: sprintf_s pid tmp dir failed, pid=" << pid << " , pw dir=." << user->pw_dir;
            return "/";
        }

        string soRootDir;
        soRootDir.assign(pidTmpDir);
        char localPath[1000];
        memset(localPath, 0, sizeof(localPath)/sizeof(localPath[0]));
        sprintf(localPath, "%s", soRootDir.data() );
        return string(localPath);
    }

    static string get_out_so_dir()
    {
        string cwd = GetCwd();
        return cwd + "/tmp/llt_gcc4.9.3-prefix/src/llt_gcc4.9.3-build/llt/aicpu/aicpu_device/aicpu_processer/ut/";
    }

protected:
    // Some expensive resource shared by all tests.
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

/**
*@test       UT_AICPU_ENGINE_aeCallInterface_01
*- @tspec    aeCallInterface
*- @ttitle   Testing for aeCallInterface when input is NULL
*- @tprecon     1.Set input to NULL
*- @tbrief      1.Call funtion: aeCallInterface;
                2.Get return status and output;
*- @texpect     1.Return status shold be AE_STATUS_BAD_PARAM;
                2.Should print error log "Input param addr is NULL";
*- @tprior   1
*- @tauto TRUE
*- @tremark
*/
TEST_F(AicpuEngineUTest, input_null)
{
    int32_t ret = aeCallInterface(NULL);
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
TEST_F(AicpuEngineUTest, str_kernel_param_null)
{
    HwtsTsKernel strKernel;
    {
        strKernel.kernelType = KERNEL_TYPE_RESERVED;
        int32_t ret = aeCallInterface(&strKernel);
        EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
    }
}
static aeStatus_t stubInstanceInit()
{
    return AE_STATUS_INNER_ERROR;
}

TEST_F(AicpuEngineUTest, GetInstanceInit_FAIL)
{
    MOCKER_CPP(&cce::MultiSoManager::Init).stubs().will(invoke(stubInstanceInit));
    MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(returnValue(AICPU_ERROR_FAILED));
    
    cce::AIKernelsLibAiCpu::DestroyInstance();
    auto aiKernelsLibAicpu = cce::AIKernelsLibAiCpu::GetInstance();
    EXPECT_EQ(aiKernelsLibAicpu, nullptr);
}

TEST_F(AicpuEngineUTest, GetInstance_FAIL)
{
    MOCKER_CPP(&cce::MultiSoManager::Init).stubs().will(invoke(stubInstanceInit));
    cce::AIKernelsLibAiCpu::DestroyInstance();
    auto aiKernelsLibAicpu = cce::AIKernelsLibAiCpu::GetInstance();
    EXPECT_EQ(aiKernelsLibAicpu, nullptr);
}

TEST_F(AicpuEngineUTest, SingleSoManager_init_fail_test)
{
    SingleSoManager sSoMngr;
    sSoMngr.Init("guard", "no_such_so");
    void *funcAddrPtr = NULL;
    aeStatus_t ret = sSoMngr.GetApi(SIMPLE_TEST_SO, SIMPLE_MAIN_FOO, &funcAddrPtr);
    EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
}

TEST_F(AicpuEngineUTest, SingleSoManager_checkfile_fail_test)
{
    SingleSoManager sSoMngr;
    aeStatus_t ret = sSoMngr.Init("/tmp/xx/d/", AicpuEngineUTest::get_work_so_dir() + SIMPLE_TEST_SO);
    EXPECT_EQ(AE_STATUS_OPEN_SO_FAILED, ret);

    void *funcAddrPtr = NULL;
    ret = sSoMngr.GetApi(SIMPLE_TEST_SO, SIMPLE_MAIN_FOO, &funcAddrPtr);
    EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
}

#define MAX_TEST_TH 15
char thread_error_str[MAX_TEST_TH][1024];

const string &stubTfSoFile()
{
    static const string soFile(AicpuEngineUTest::get_out_so_dir() + SIMPLE_TEST_SO);
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
TEST_F(AicpuEngineUTest, cc_fwk_tf_kernel_no_such_so)
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
TEST_F(AicpuEngineUTest, cc_cdclose_error)
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
TEST_F(AicpuEngineUTest, cc_fwk_tf_kernel_call_api_inner_error)
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

TEST_F(AicpuEngineUTest, cc_fwk_tf_kernel_get_api_inner_error)
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

TEST_F(AicpuEngineUTest, cc_fwk_AIKernelsLibFWK_call_test)
{
    int32_t ret = AIKernelsLibFWK::GetInstance()->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, nullptr);
    EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
    ret = AIKernelsLibFWK::GetInstance()->CloseSo(nullptr);
    EXPECT_EQ(AE_STATUS_SUCCESS, ret);
}

/**
*/

/**
*@test       UT_AICPU_ENGINE_aeClear_13
*- @tspec    aeClear
*- @ttitle   Test for aeClear
*- @tprecon     1.None
*- @tbrief      1.Call aeClear() twice;
*- @texpect     1.No except happened.
*- @tprior   1
*- @tauto TRUE
*- @tremark
*/
/*
TEST_F(AicpuEngineUTest, ae_clear)
{
        aeClear();
        aeClear();
}*/

TEST_F(AicpuEngineUTest, aeBatchLoadKernelSo)
{
    const char *aicpuKernelSoName = "libaicpu_kernels.so";
    const char *cpuKernelSoName = "libcpu_kernels.so";
    const char *tfKernelSoName = "libtf_kernels.so";
    const uint32_t loadSoNum = 3;
    const char *soNames[loadSoNum] = {aicpuKernelSoName, cpuKernelSoName, tfKernelSoName};
    aeStatus_t ret = aeBatchLoadKernelSo(aicpu::KERNEL_TYPE_AICPU, loadSoNum, soNames);
    EXPECT_EQ(AE_STATUS_SUCCESS, ret);
}

TEST_F(AicpuEngineUTest, aeBatchLoadKernelSo_Success1)
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

TEST_F(AicpuEngineUTest, aeBatchLoadKernelSo_Success2)
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

TEST_F(AicpuEngineUTest, aeCloseSo_Success)
{
    std::string soName("libcpu_kernels.so");
    aeStatus_t ret = aeCloseSo(aicpu::KERNEL_TYPE_AICPU_CUSTOM, soName.c_str());
    EXPECT_EQ(AE_STATUS_SUCCESS, ret);
}

TEST_F(AicpuEngineUTest, aeCloseSoNullptr_Fail)
{
    aeStatus_t ret = aeCloseSo(aicpu::KERNEL_TYPE_AICPU_CUSTOM, nullptr);
    EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
}

TEST_F(AicpuEngineUTest, BatchLoadEmptySo_Success)
{
    std::vector<std::string> aicpuSoVec;
    aeStatus_t ret = AIKernelsLibAiCpu::GetInstance()->BatchLoadKernelSo(aicpu::KERNEL_TYPE_AICPU_CUSTOM, aicpuSoVec);
    EXPECT_EQ(AE_STATUS_SUCCESS, ret);
}



TEST_F(AicpuEngineUTest, AeAddSoInWhiteList)
{
    const char_t * const soName = "789.so";
    AeDeleteSoInWhiteList(soName);
    AeDeleteSoInWhiteList(nullptr);
    aeStatus_t ret = AeAddSoInWhiteList(soName);
    EXPECT_EQ(AE_STATUS_SUCCESS, ret);
    ret = AeAddSoInWhiteList(nullptr);
    EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
}