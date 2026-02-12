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
#include <string>
#include <dlfcn.h>
#include "securec.h"
#include "mockcpp/mockcpp.hpp"
#include "aicpu_engine.h"
#include "aicpu_engine_struct.h"
#define private public
#include "ae_def.hpp"
#include "ae_so_manager.hpp"
#include "ae_kernel_lib_manager.hpp"
#include "ae_kernel_lib_aicpu_kfc.h"
#undef private
#include "aicpu_context.h"
#include "aicpu_event_struct.h"



using namespace aicpu;
using namespace std;

namespace aicpu {
    namespace ut {
        static uint32_t HcclKernelSuccessStub(void *)
        {
            return 0;
        }

        static uint32_t HcclKernelErrorStub(void *)
        {
            return 1;
        }

        static aeStatus_t GetErrorApiStub(cce::MultiSoManager *, aicpu::KernelType kernelType,
                                          const char *soName, const char *funcName,
                                          void **funcAddrPtr)
        {
            *funcAddrPtr = (void *) HcclKernelErrorStub;
            return AE_STATUS_SUCCESS;
        }


        class AIKernelsLibAiCpuKFCSTest : public testing::Test {
        protected:
            static void SetUpTestCase()
            {
                aeStatus_t ret = cce::AIKernelsLibManger::GetKernelLib(KERNEL_TYPE_AICPU_KFC, AIKernelsLibAiCpuKFC_);
                EXPECT_EQ(AE_STATUS_SUCCESS, ret);
                printf("AIKernelsLibAiCpuKFCSTest SetUpTestCase\n");
            }

            static void TearDownTestCase()
            {
                if (AIKernelsLibAiCpuKFC_ != nullptr) {
                    cce::AIKernelsLibManger::ClearKernelLib(KERNEL_TYPE_AICPU_KFC);
                }
                printf("AIKernelsLibAiCpuKFCSTest TearDownTestCase \n");
            }

        protected:
            // Some expensive resource shared by all tests.
            virtual void SetUp()
            {
                Init();
            }

            virtual void TearDown()
            {
                GlobalMockObject::verify();
            }

            void Init()
            {
                kernel_.kernelSo = (uintptr_t) kernelSo_.data();
                kernel_.kernelName = (uintptr_t) kernelName_.data();
            }

        protected:
            static cce::AIKernelsLibBase *AIKernelsLibAiCpuKFC_;
            std::string kernelSo_ = {"libTest.so"};
            std::string kernelName_ = {"TestFun"};
            HwtsCceKernel kernel_ = {0};
        };

        cce::AIKernelsLibBase *AIKernelsLibAiCpuKFCSTest::AIKernelsLibAiCpuKFC_ = nullptr;

        TEST_F(AIKernelsLibAiCpuKFCSTest, CallKFCKernelApi_ST_param_NULL)
        {
            int32_t ret = AIKernelsLibAiCpuKFC_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU_KFC, nullptr);
            EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
        }

        TEST_F(AIKernelsLibAiCpuKFCSTest, CallKFCKernelApi_ST_kernelName_NULL)
        {
            kernel_.kernelName = 0;
            int32_t ret = AIKernelsLibAiCpuKFC_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU_KFC, &kernel_);
            EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
        }

        TEST_F(AIKernelsLibAiCpuKFCSTest, CallKFCKernelApi_ST_strncpy_kernelName_failed)
        {
            MOCKER(strncpy_s)
                    .stubs()
                    .will(returnValue(1));
            int32_t ret = AIKernelsLibAiCpuKFC_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU_KFC, &kernel_);
            EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
        }

        TEST_F(AIKernelsLibAiCpuKFCSTest, CallKFCKernelApi_ST_strncpy_soName_failed)
        {
            MOCKER(strncpy_s)
                    .stubs()
                    .will(returnValue(0)).then(returnValue(1));
            int32_t ret = AIKernelsLibAiCpuKFC_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU_KFC, &kernel_);
            EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
        }

        TEST_F(AIKernelsLibAiCpuKFCSTest, CallKFCKernelApi_ST_CALL_kernel_failed)
        {
             MOCKER_CPP(&cce::MultiSoManager::GetApi,
                       aeStatus_t(cce::MultiSoManager::*)(aicpu::KernelType kernelType, const char *, const char *,
                                                           void **))
                .stubs()
                .will(invoke(GetErrorApiStub));
            int32_t ret = AIKernelsLibAiCpuKFC_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU_KFC, &kernel_);
            EXPECT_NE(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(AIKernelsLibAiCpuKFCSTest, CallKFCKernelApi_UT_kernelSo001)
        {
            std::string kernelSo = "";
            kernel_.kernelSo = (uintptr_t) kernelSo.data();
            std::string kernelName = "TestFuna";
            kernel_.kernelName = (uintptr_t) kernelName.data();
            MOCKER(dlsym).stubs().will(returnValue((void *)nullptr));
            int32_t ret = AIKernelsLibAiCpuKFC_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU_KFC, &kernel_);
            EXPECT_NE(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(AIKernelsLibAiCpuKFCSTest, CallKFCKernelApi_UT_kernelSo002)
        {
            std::string kernelSo = "";
            kernel_.kernelSo = (uintptr_t) kernelSo.data();
            std::string kernelName = "TestFunb";
            kernel_.kernelName = (uintptr_t) kernelName.data();
            MOCKER(strnlen).stubs().will(returnValue(101));
            MOCKER(dlsym).stubs().will(returnValue((void *)nullptr));
            int32_t ret = AIKernelsLibAiCpuKFC_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU_KFC, &kernel_);
            EXPECT_NE(AE_STATUS_SUCCESS, ret);
        }

        using AicpuKFCOpFuncPtr = uint32_t(*)(void *);
        TEST_F(AIKernelsLibAiCpuKFCSTest, CallKFCKernelApi_ST_RunAicpuFunc)
        {
            AicpuKFCOpFuncPtr opFuncPtr = &HcclKernelSuccessStub;
            aicpu::HwtsCceKernel kernelBase;

            uint32_t ret =  cce::AIKernelsLibAiCpuKFC::GetInstance()->RunAicpuFunc(static_cast<void *>(&kernelBase), opFuncPtr);
            EXPECT_EQ(0, ret);
        }
        TEST_F(AIKernelsLibAiCpuKFCSTest, CallKFCKernelApi_ST_RunAicpuFunc1)
        {
            aicpu::HwtsCceKernel kernelBase;
            char str[100] = "HcclKernelSuccessStub";
            kernelBase.kernelName = (uint64_t)str;
            std::string kernelName = "HcclKernelSuccessStub";
            cce::AIKernelsLibAiCpuKFC::GetInstance()->apiCacher_[kernelName] = &HcclKernelSuccessStub;
            int32_t ret =  cce::AIKernelsLibAiCpuKFC::GetInstance()->CallKernelApi(aicpu::KERNEL_TYPE_AICPU_KFC, static_cast<void *>(&kernelBase));
            EXPECT_EQ(0, ret);
        }

        TEST_F(AIKernelsLibAiCpuKFCSTest, CallKFCKernelApi_ST_BatchLoadClose)
        {
            const char_t *soName = "test.so";
            std::vector<std::string> aicpuSoVec;
            aeStatus_t ret = cce::AIKernelsLibAiCpuKFC::GetInstance()->BatchLoadKernelSo(aicpu::KERNEL_TYPE_AICPU_CUSTOM, aicpuSoVec);
            EXPECT_EQ(0, ret);
            ret = cce::AIKernelsLibAiCpuKFC::GetInstance()->CloseSo(soName);
            EXPECT_EQ(0, ret);
        }

        TEST_F(AIKernelsLibAiCpuKFCSTest, TransformKernelErrorCodeTaskAbort)
        {
            const char_t *kernelName = "RunCclKernel";
            int32_t ret = cce::AIKernelsLibAiCpuKFC::GetInstance()->TransformKernelErrorCode(
                static_cast<uint32_t>(cce::AicpuOpErrorCode::AICPU_TASK_ABORT), kernelName);
            EXPECT_EQ(AE_STATUS_TASK_ABORT, ret);
        }

        TEST_F(AIKernelsLibAiCpuKFCSTest, TransformKernelErrorCodeTaskFail)
        {
            const char_t *kernelName = "RunCclKernel";
            int32_t ret = cce::AIKernelsLibAiCpuKFC::GetInstance()->TransformKernelErrorCode(22U, kernelName);
            EXPECT_EQ(AE_STATUS_TASK_FAIL, ret);
        }

        TEST_F(AIKernelsLibAiCpuKFCSTest, TransformKernelErrorCodePassthrough)
        {
            const char_t *kernelName = "RunCclKernel";
            const uint32_t errCode = 1021U;
            int32_t ret = cce::AIKernelsLibAiCpuKFC::GetInstance()->TransformKernelErrorCode(errCode, kernelName);
            EXPECT_EQ(errCode, ret);
        }
    }
}