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
#include <climits>
#include <string>
#include <fstream>
#include <sstream>
#include <iostream>
#include <cstdio>
#include <securec.h>
#include <dlfcn.h>
#include "mockcpp/mockcpp.hpp"
#define private public
#include "ae_so_manager.hpp"
#include "aicpu_context.h"
#include "aicpu_event_struct.h"
#include "ae_kernel_lib_manager.hpp"
#undef private

using namespace aicpu;
using namespace std;
using namespace cce;

namespace aicpu {
    namespace ut {
        int32_t addr = 1234;
        void *nll = nullptr;
        const std::string rootPath = "/root";
        const std::string userPath = "/home/HwHiAiUser";

        SingleSoManager g_singleSoManager;

        char *GetHomeEnvForRoot (const char *__name)
        {
            return const_cast<char *>(rootPath.data());
        }

        char *GetHomeEnvForUser (const char *__name)
        {
            return const_cast<char *>(userPath.data());
        }

        char *GetHomeEnvFail (const char *__name)
        {
            return nullptr;
        }

        class SoManagerUTest : public testing::Test {
        protected:
            static void SetUpTestCase()
            {
                printf("SoManagerUTest SetUpTestCase\n");
            }

            static void TearDownTestCase()
            {
                printf("SoManagerUTest TearDownTestCase \n");
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
        public:
            MultiSoManager soMngr_;
        };
        aicpu::status_t GetAicpuRunModeStub(aicpu::AicpuRunMode &runMode)
        {
            runMode = aicpu::AicpuRunMode::THREAD_MODE;
            return aicpu::AICPU_ERROR_NONE;
        }
        aicpu::status_t GetAicpuRunModePCIE(aicpu::AicpuRunMode &runMode)
        {
            runMode = aicpu::AicpuRunMode::PROCESS_PCIE_MODE;
            return aicpu::AICPU_ERROR_NONE;
        }
        aicpu::status_t GetAicpuRunModeSOCKET(aicpu::AicpuRunMode &runMode)
        {
            runMode = aicpu::AicpuRunMode::PROCESS_SOCKET_MODE;
            return aicpu::AICPU_ERROR_NONE;
        }
        TEST_F(SoManagerUTest, multi_so_mgr_init_success)
        {
            setenv("ASCEND_AICPU_KERNEL_PATH", "/usr/lib64/", 1);
            setenv("ASCEND_CUST_AICPU_KERNEL_CACHE_PATH", "/usr/lib64/", 1);
            cce::MultiSoManager soMngr;
            aeStatus_t ret = soMngr.Init();
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }
        TEST_F(SoManagerUTest, get_cust_so_path_success)
        {
            std::string value = "temp";
            cce::MultiSoManager soMngr;
            aeStatus_t ret = soMngr.GetCustSoPath(value);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        aeStatus_t OpenSoStub(const std::string &soFile, void ** const retHandle)
        {
            *retHandle = &addr;
            return AE_STATUS_SUCCESS;
        }


        TEST_F(SoManagerUTest, SingleSoManager_Init_01)
        {
            string guardDirName = "guardDirName";
            string soFile = "soFile";
            SingleSoManager singleSoManager;
            MOCKER(SingleSoManager::CheckSoFile)
                .stubs()
                .will(returnValue(AE_STATUS_SUCCESS));
            MOCKER(SingleSoManager::OpenSo)
                .stubs()
                .will(invoke(OpenSoStub));
            auto ret = singleSoManager.Init(guardDirName, soFile);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        void *dlsymStub(void *const soHandle, const char_t * const funcName)
        {
            return &addr;
        }

        TEST_F(SoManagerUTest, SingleSoManager_GetFunc_01)
        {
            SingleSoManager singleSoManager;
            MOCKER(dlsym)
                .stubs()
                .will(returnValue(nll));
            auto ret = singleSoManager.GetFunc(nullptr, "nullptr", nullptr);
            EXPECT_EQ(AE_STATUS_GET_KERNEL_NAME_FAILED, ret);
        }
        TEST_F(SoManagerUTest, SingleSoManager_GetFunc_02)
        {
            SingleSoManager singleSoManager;
            MOCKER(dlsym)
                .stubs()
                .will(invoke(dlsymStub));
            void *retFuncAddr = nullptr;
            auto ret = singleSoManager.GetFunc(nullptr, "nullptr", &retFuncAddr);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(SoManagerUTest, SingleSoManager_CheckSoFile_01)
        {
            SingleSoManager singleSoManager;
            auto ret = singleSoManager.CheckSoFile("", "");
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
            string soFile(PATH_MAX+1, '1');
            ret = singleSoManager.CheckSoFile("test", soFile);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(SoManagerUTest, SingleSoManager_CheckSoFile_02)
        {
            SingleSoManager singleSoManager;
            string guardDirName = "guardDirName";
            string soFile = "soFile";
            char_t path[] = "test";
            MOCKER(realpath)
                .stubs()
                .will(returnValue(&path[0U]));
            auto ret = singleSoManager.CheckSoFile(guardDirName, soFile);
            EXPECT_EQ(AE_STATUS_OPEN_SO_FAILED, ret);
        }

        TEST_F(SoManagerUTest, SingleSoManager_CheckSoFile_03)
        {
            SingleSoManager singleSoManager;
            string soFile = "soFile";
            MOCKER(memset_s).stubs().will(returnValue(-1));
            auto ret = singleSoManager.CheckSoFile("test", soFile);
            EXPECT_EQ(AE_STATUS_OPEN_SO_FAILED, ret);
        }


        void *dlopenStub(const char *filename, int flags)
        {
            return &addr;
        }

        TEST_F(SoManagerUTest, SingleSoManager_OpenSo_01)
        {
            SingleSoManager singleSoManager;
            MOCKER(dlopen)
                .stubs()
                .will(invoke(dlopenStub));
            char_t path[] = "test";
            MOCKER(realpath)
                .stubs()
                .will(returnValue(&path[0U]));
            void *retHandle  = nullptr;
            auto ret = singleSoManager.OpenSo("test", &retHandle);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(SoManagerUTest, SingleSoManager_OpenSoMemsetFail)
        {
            SingleSoManager singleSoManager;
            MOCKER(dlopen)
                .stubs()
                .will(invoke(dlopenStub));
            char_t path[] = "test";
            MOCKER(realpath)
                .stubs()
                .will(returnValue(&path[0U]));
            MOCKER(memset_s).stubs().will(returnValue(-1));
            void *retHandle  = nullptr;
            auto ret = singleSoManager.OpenSo("test", &retHandle);
            EXPECT_EQ(AE_STATUS_OPEN_SO_FAILED, ret);
        }

        TEST_F(SoManagerUTest, SingleSoManager_GetApi_01)
        {
            SingleSoManager singleSoManager;
            singleSoManager.apiCacher_["test"] = nullptr;
            singleSoManager.soHandle_ = &addr;
            char_t * const soNamePtr = nullptr;
            void *funcAddrPtr = nullptr;
            auto ret = singleSoManager.GetApi(soNamePtr, "test", &funcAddrPtr);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
            MOCKER(SingleSoManager::GetFunc)
                .stubs()
                .will(returnValue(AE_STATUS_SUCCESS));
            ret = singleSoManager.GetApi(soNamePtr, "testtest", &funcAddrPtr);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(SoManagerUTest, SingleSoManager_GetApi_02)
        {
            SingleSoManager singleSoManager;
            singleSoManager.soHandle_ = &addr;
            MOCKER(SingleSoManager::GetFunc)
                .stubs()
                .will(returnValue(AE_STATUS_INNER_ERROR));
            char_t * const soNamePtr = nullptr;
            void *funcAddrPtr = nullptr;
            auto ret = singleSoManager.GetApi(soNamePtr, "testtesttest", &funcAddrPtr);
            EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
        }

        TEST_F(SoManagerUTest, SingleSoManager_GetApi_03)
        {
            SingleSoManager singleSoManager;
            singleSoManager.soHandle_ = nullptr;
            char_t * const soNamePtr = nullptr;
            void *funcAddrPtr = nullptr;
            auto ret = singleSoManager.GetApi(soNamePtr, "testtesttest", &funcAddrPtr);
            EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
        }

        aeStatus_t GetFuncStub(void * const soHandle, const char_t * const funcName, void ** const retFuncAddr)
        {
            *retFuncAddr = &addr;
            return AE_STATUS_SUCCESS;
        }

        TEST_F(SoManagerUTest, SingleSoManager_GetApi_04)
        {
            SingleSoManager singleSoManager;
            singleSoManager.soHandle_ = nullptr;
            const char_t * const soNamePtr = "test";
            void *funcAddrPtr = nullptr;
            void *retHandle = nullptr;
            MOCKER(SingleSoManager::OpenSo)
                .stubs()
                .will(invoke(OpenSoStub));
            MOCKER(SingleSoManager::GetFunc)
                .stubs()
                .will(invoke(GetFuncStub));
            auto ret = singleSoManager.GetApi(soNamePtr, soNamePtr, &funcAddrPtr, &retHandle);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(SoManagerUTest, SingleSoManager_CloseSo_01)
        {
            SingleSoManager singleSoManager;
            MOCKER(dlclose)
                .stubs()
                .will(returnValue(-1));
            auto ret = singleSoManager.CloseSo(&addr);
            EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
        }

        TEST_F(SoManagerUTest, SingleSoManager_CloseSoSuccess)
        {
            SingleSoManager singleSoManager;
            MOCKER(dlclose)
                .stubs()
                .will(returnValue(0));
            auto ret = singleSoManager.CloseSo(&addr);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        aeStatus_t LoadSoStub(MultiSoManager *This, const aicpu::KernelType kernelType, const std::string &soName, SingleSoManager *&soMgr)
        {
            soMgr = &g_singleSoManager;
            return AE_STATUS_SUCCESS;
        }
        aeStatus_t CreateSingleSoMgrStub(MultiSoManager *This, const aicpu::KernelType kernelType, const std::string &soName, SingleSoManager *&soMgr)
        {
            soMgr = &g_singleSoManager;
            return AE_STATUS_SUCCESS;
        }

        TEST_F(SoManagerUTest, MultiSoManager_GetApi_01)
        {
            MultiSoManager multiSoManager;
            void *funcAddrPtr = nullptr;
            MOCKER_CPP(&MultiSoManager::LoadSo,aeStatus_t(MultiSoManager::*)(const aicpu::KernelType, const std::string&, SingleSoManager *&))
                .stubs()
                .will(invoke(LoadSoStub));
             MOCKER_CPP(&SingleSoManager::GetApi,aeStatus_t(SingleSoManager::*)(const char_t * const, const char_t * const, void ** const))
                .stubs()
                .will(returnValue(AE_STATUS_SUCCESS));
            const char_t * const funcName = "test";
            const char_t * const soName = "test";
            auto ret = multiSoManager.GetApi(KERNEL_TYPE_CCE, soName, funcName, &funcAddrPtr);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }
        TEST_F(SoManagerUTest, MultiSoManager_GetApi_02)
        {
            MultiSoManager multiSoManager;
            void *funcAddrPtr = nullptr;
            MOCKER_CPP(&MultiSoManager::LoadSo,aeStatus_t(MultiSoManager::*)(const aicpu::KernelType, const std::string&, SingleSoManager *&))
                .stubs()
                .will(returnValue(AE_STATUS_OPEN_SO_FAILED));
            auto ret = multiSoManager.GetApi(KERNEL_TYPE_CCE, "testtesttest", "test", &funcAddrPtr);
            EXPECT_EQ(AE_STATUS_OPEN_SO_FAILED, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_GetInnerSoPath_01)
        {
            MultiSoManager multiSoManager;
            string soName = "";
            string soPath = "";
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(returnValue(AICPU_ERROR_FAILED));
            auto ret = multiSoManager.GetInnerSoPath(soName, soPath);
            EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_GetInnerSoPath_02)
        {
            MultiSoManager multiSoManager;
            multiSoManager.innerKernelPath_ = "test";
            string soName = "";
            string soPath = "";
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(invoke(GetAicpuRunModeStub));
            auto ret = multiSoManager.GetInnerSoPath(soName, soPath);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_GetInnerSoPath_03)
        {
            MultiSoManager multiSoManager;
            string soName = "libretr_kernels.so";
            string soPath = "";
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(invoke(GetAicpuRunModeStub));
            auto ret = multiSoManager.GetInnerSoPath(soName, soPath);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_GetInnerSoPath_04)
        {
            MultiSoManager multiSoManager;
            string soName = "libhccl_operator_call.so";
            string soPath = "";
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(invoke(GetAicpuRunModeStub));
            auto ret = multiSoManager.GetInnerSoPath(soName, soPath);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_GetInnerSoPath_05)
        {
            MultiSoManager multiSoManager;
            string soName = "";
            string soPath = "";
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(invoke(GetAicpuRunModeStub));
            MOCKER(aicpu::aicpuGetContext)
                .stubs()
                .will(returnValue(AICPU_ERROR_FAILED));
            auto ret = multiSoManager.GetInnerSoPath(soName, soPath);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_GetContextError)
        {
            MultiSoManager multiSoManager;
            string soName = "";
            string soPath = "";
            setenv("ASCEND_AICPU_PATH", "/usr/lib64/", 1);
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(invoke(GetAicpuRunModePCIE));
            MOCKER(aicpu::aicpuGetContext)
                .stubs()
                .will(returnValue(AICPU_ERROR_FAILED));
            auto ret = multiSoManager.GetInnerSoPath(soName, soPath);
            EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_GetInnerSoPath_08)
        {
            MultiSoManager multiSoManager;
            string soName = "";
            string soPath = "";
            setenv("ASCEND_AICPU_PATH", "/usr/lib64/", 1);
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(invoke(GetAicpuRunModePCIE));
            char_t dirName[] = "/usr/local/Ascend";
            MOCKER(getenv)
                .stubs()
                .will(returnValue(&dirName[0U]));
            auto ret = multiSoManager.GetInnerSoPath(soName, soPath);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_GetInnerSoPath_09)
        {
            MultiSoManager multiSoManager;
            string soName = "";
            string soPath = "";
            setenv("ASCEND_AICPU_PATH", "/usr/lib64/", 1);
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(invoke(GetAicpuRunModePCIE));
            char *dirName = nullptr;
            MOCKER(getenv)
                .stubs()
                .will(returnValue(dirName));
            auto ret = multiSoManager.GetInnerSoPath(soName, soPath);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_GetInnerSoPath_10)
        {
            MultiSoManager multiSoManager;
            string soName = "";
            string soPath = "";
            setenv("ASCEND_AICPU_PATH", "/usr/lib64/", 1);
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(invoke(GetAicpuRunModePCIE));
            auto ret = multiSoManager.GetInnerSoPath(soName, soPath);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_BuildCustSoPath_01)
        {
            MultiSoManager multiSoManager;
            string soPath = "";
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(invoke(GetAicpuRunModePCIE));
            auto ret = multiSoManager.BuildCustSoPath(soPath, 0);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_BuildCustSoPath_02)
        {
            MultiSoManager multiSoManager;
            string soPath = "";
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(invoke(GetAicpuRunModeSOCKET));
            char *curDirName = nullptr;
            MOCKER(getenv)
                .stubs()
                .will(returnValue(curDirName));
            auto ret = multiSoManager.BuildCustSoPath(soPath, 0);
            EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_LoadSo_01)
        {
            MultiSoManager multiSoManager;
            string soName = "";
            auto ret = multiSoManager.LoadSo(aicpu::KERNEL_TYPE_AICPU_CUSTOM, soName);
            EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_GetCustSoPath_01)
        {
            MultiSoManager multiSoManager;
            string soPath = "";
            MOCKER(aicpu::aicpuGetContext)
                .stubs()
                .will(returnValue(AICPU_ERROR_FAILED));
            auto ret = multiSoManager.GetCustSoPath(soPath);
            EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_GetCustSoPath_02)
        {
            MultiSoManager multiSoManager;
            string soPath = "";
            MOCKER(aicpu::aicpuGetContext)
                .stubs()
                .will(returnValue(AICPU_ERROR_NONE));
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(returnValue(AICPU_ERROR_FAILED));
            auto ret = multiSoManager.GetCustSoPath(soPath);
            EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_GetCustSoPath_03)
        {
            MultiSoManager multiSoManager;
            string soPath = "";
            MOCKER(aicpu::aicpuGetContext)
                .stubs()
                .will(returnValue(AICPU_ERROR_NONE));
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(invoke(GetAicpuRunModeStub));
            char *dirName = nullptr;
            MOCKER(getenv)
                .stubs()
                .will(returnValue(dirName));
            auto ret = multiSoManager.GetCustSoPath(soPath);
            EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_GetCustSoPath_04)
        {
            MultiSoManager multiSoManager;
            string soPath = "";
            MOCKER(aicpu::aicpuGetContext)
                .stubs()
                .will(returnValue(AICPU_ERROR_NONE));
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(invoke(GetAicpuRunModeStub));
            char_t *dirName = nullptr;
            MOCKER(getenv)
                .stubs()
                .will(returnValue(dirName));
            auto ret = multiSoManager.GetCustSoPath(soPath);
            EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_GetCustSoPath_05)
        {
            MultiSoManager multiSoManager;
            string soPath = "";
            MOCKER(aicpu::aicpuGetContext)
                .stubs()
                .will(returnValue(AICPU_ERROR_NONE));
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(invoke(GetAicpuRunModeStub));
            char_t dirName[] = "";
            MOCKER(getenv)
                .stubs()
                .will(returnValue(&dirName[0U]));
            auto ret = multiSoManager.GetCustSoPath(soPath);
            EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_GetCustSoPath_06)
        {
            MultiSoManager multiSoManager;
            string soPath = "";
            MOCKER(aicpu::aicpuGetContext)
                .stubs()
                .will(returnValue(AICPU_ERROR_NONE));
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(invoke(GetAicpuRunModeSOCKET));
            char_t dirName[] = "/";
            MOCKER(getenv)
                .stubs()
                .will(returnValue(&dirName[0U]));
            auto ret = multiSoManager.GetCustSoPath(soPath);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(SoManagerUTest, MultiSoManager_GetCustSoPath_07)
        {
            MultiSoManager multiSoManager;
            string soPath = "";
            MOCKER(aicpu::aicpuGetContext)
                .stubs()
                .will(returnValue(AICPU_ERROR_NONE));
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(invoke(GetAicpuRunModeSOCKET));
            auto ret = multiSoManager.GetCustSoPath(soPath);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(SoManagerUTest, multi_so_mgr_init_success_getrunmode_fail)
        {
            setenv("ASCEND_AICPU_KERNEL_PATH", "/usr/lib64/", 1);
            setenv("ASCEND_CUST_AICPU_KERNEL_CACHE_PATH", "/usr/lib64/", 1);
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(returnValue(AICPU_ERROR_FAILED));
            aeStatus_t ret = soMngr_.Init();
            EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
        }
        TEST_F(SoManagerUTest, multi_so_mgr_LoadSo)
        {
            MOCKER_CPP(&MultiSoManager::CreateSingleSoMgr,aeStatus_t(MultiSoManager::*)(const aicpu::KernelType, const std::string&, SingleSoManager *&))
                .stubs()
                .will(invoke(CreateSingleSoMgrStub));
            MOCKER(aicpu::GetAicpuRunMode)
                .stubs()
                .will(invoke(GetAicpuRunModePCIE));
            SingleSoManager *sinsoMgr;
            aeStatus_t ret = soMngr_.LoadSo(aicpu::KERNEL_TYPE_AICPU_CUSTOM, "libtf_kernels.so", sinsoMgr);
            EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
        }

        TEST_F(SoManagerUTest, GetThreadModeSoPathSuccess01)
        {
            // for root
            MOCKER(getenv).stubs().will(invoke(GetHomeEnvForRoot));
            std::string soPath = "";
            const auto ret = soMngr_.GetThreadModeSoPath(soPath);
            EXPECT_EQ(ret, AE_STATUS_SUCCESS);
            EXPECT_STREQ(soPath.c_str(), "/root/aicpu_kernels/0/aicpu_kernels_device/");
        }

        TEST_F(SoManagerUTest, GetThreadModeSoPathSuccess02)
        {
            // for user
            MOCKER(getenv).stubs().will(invoke(GetHomeEnvForUser));
            std::string soPath = "";
            const auto ret = soMngr_.GetThreadModeSoPath(soPath);
            EXPECT_EQ(ret, AE_STATUS_SUCCESS);
            EXPECT_STREQ(soPath.c_str(), "/home/HwHiAiUser/aicpu_kernels/0/aicpu_kernels_device/");
        }

        TEST_F(SoManagerUTest, GetThreadModeSoPathSuccess03)
        {
            // for user with vfid
            MOCKER(getenv).stubs().will(invoke(GetHomeEnvForUser));
            MOCKER(GetUniqueVfId).stubs().will(returnValue(5U));
            std::string soPath = "";
            const auto ret = soMngr_.GetThreadModeSoPath(soPath);
            EXPECT_EQ(ret, AE_STATUS_SUCCESS);
            EXPECT_STREQ(soPath.c_str(), "/home/HwHiAiUser/aicpu_kernels/5/aicpu_kernels_device/");
        }

        TEST_F(SoManagerUTest, GetThreadModeSoPathFail01)
        {
            // getenv failed
            MOCKER(getenv).stubs().will(invoke(GetHomeEnvFail));
            std::string soPath = "";
            const auto ret = soMngr_.GetThreadModeSoPath(soPath);
            EXPECT_EQ(ret, AE_STATUS_INNER_ERROR);
        }

        TEST_F(SoManagerUTest, AddSoInWhiteList)
        {
            const char_t * const soName = "test1.so";
            AIKernelsLibManger::DelteSoInWhiteList(soName);
            auto ret = AIKernelsLibManger::AddSoInWhiteList(soName);
            EXPECT_EQ(ret, AE_STATUS_SUCCESS);
        }
    }
}