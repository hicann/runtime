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
#include "securec.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#include "aicpu_engine.h"
#include "aicpu_engine_struct.h"
#include "ae_def.hpp"
#include "ae_so_manager.hpp"
#include "ae_kernel_lib_manager.hpp"
#include "ae_kernel_lib_aicpu.hpp"
#include "aicpu_context.h"
#include "aicpu_event_struct.h"
#undef private

using namespace aicpu;
using namespace std;

namespace aicpu {
    namespace ut {
        static int32_t DvppKernelSuccessStub(void *)
        {
            return 0;
        }

        static int32_t DvppKernelErrorStub(void *)
        {
            return 1;
        }

        static int32_t AICPUKernelEndOfSequenceErrorStub(void *)
        {
            return 201;
        }

        static int32_t AICPUKernelTaskWaitErrorStub(void *)
        {
            return 101;
        }

        static int32_t AICPUKernelSilentFaultErrorStub(void *)
        {
            return 501;
        }

        static int32_t AICPUKernelDetectFaultErrorStub(void *)
        {
            return 502;
        }

        static int32_t AICPUKernelDetectFaultNoRasErrorStub(void *)
        {
            return 503;
        }

        static int32_t AICPUKernelDetectLowBitFaultErrorStub(void *)
        {
            return 504;
        }

        static int32_t AICPUKernelDetectLowBitFaultNoRasErrorStub(void *)
        {
            return 505;
        }

        static aeStatus_t GetAICPUEndOfSequenceErrorApiStub(cce::MultiSoManager *, aicpu::KernelType kernelType,
                                                            const char *soName, const char *funcName,
                                                            void **funcAddrPtr)
        {
            *funcAddrPtr = (void *) AICPUKernelEndOfSequenceErrorStub;
            return AE_STATUS_SUCCESS;
        }

        static aeStatus_t GetAICPUTaskWaitErrorApiStub(cce::MultiSoManager *, aicpu::KernelType kernelType,
                                                       const char *soName, const char *funcName,
                                                       void **funcAddrPtr)
        {
            *funcAddrPtr = (void *) AICPUKernelTaskWaitErrorStub;
            return AE_STATUS_SUCCESS;
        }

        static aeStatus_t GetAICPUSilentFaultErrorApiStub(cce::MultiSoManager *, aicpu::KernelType kernelType,
                                                       const char *soName, const char *funcName,
                                                       void **funcAddrPtr)
        {
            *funcAddrPtr = (void *) AICPUKernelSilentFaultErrorStub;
            return AE_STATUS_SUCCESS;
        }

        static aeStatus_t GetAICPUDetectFaultErrorApiStub(cce::MultiSoManager *, aicpu::KernelType kernelType,
                                                       const char *soName, const char *funcName,
                                                       void **funcAddrPtr)
        {
            *funcAddrPtr = (void *) AICPUKernelDetectFaultErrorStub;
            return AE_STATUS_SUCCESS;
        }

        static aeStatus_t GetAICPUDetectFaultNoRasErrorApiStub(cce::MultiSoManager *, aicpu::KernelType kernelType,
                                                        const char *soName, const char *funcName,
                                                        void **funcAddrPtr)
        {
            *funcAddrPtr = (void *) AICPUKernelDetectFaultNoRasErrorStub;
            return AE_STATUS_SUCCESS;
        }

        static aeStatus_t GetAICPUDetectLowBitFaultErrorApiStub(cce::MultiSoManager *, aicpu::KernelType kernelType,
                                                       const char *soName, const char *funcName,
                                                       void **funcAddrPtr)
        {
            *funcAddrPtr = (void *) AICPUKernelDetectLowBitFaultErrorStub;
            return AE_STATUS_SUCCESS;
        }

        static aeStatus_t GetAICPUDetectLowBitFaultNoRasErrorApiStub(cce::MultiSoManager *, aicpu::KernelType kernelType,
                                                        const char *soName, const char *funcName,
                                                        void **funcAddrPtr)
        {
            *funcAddrPtr = (void *) AICPUKernelDetectLowBitFaultNoRasErrorStub;
            return AE_STATUS_SUCCESS;
        }

        static aeStatus_t GetErrorApiStub(cce::MultiSoManager *, aicpu::KernelType kernelType,
                                          const char *soName, const char *funcName,
                                          void **funcAddrPtr)
        {
            *funcAddrPtr = (void *) DvppKernelErrorStub;
            return AE_STATUS_SUCCESS;
        }

        static aeStatus_t GetSuccessApiStub(cce::MultiSoManager *, aicpu::KernelType kernelType,
                                            const char *soName, const char *funcName,
                                            void **funcAddrPtr)
        {
            *funcAddrPtr = (void *) DvppKernelSuccessStub;
            return AE_STATUS_SUCCESS;
        }

        class AIKernelsLibAiCpuSTest : public testing::Test {
        protected:
            static void SetUpTestCase()
            {
                aeStatus_t ret = cce::AIKernelsLibManger::GetKernelLib(KERNEL_TYPE_AICPU, aiKernelsLibAiCpu_);
                EXPECT_EQ(AE_STATUS_SUCCESS, ret);
                printf("AIKernelsLibAiCpuSTest SetUpTestCase\n");
            }

            static void TearDownTestCase()
            {
                if (aiKernelsLibAiCpu_ != nullptr) {
                    cce::AIKernelsLibManger::ClearKernelLib(KERNEL_TYPE_AICPU);
                }
                printf("AIKernelsLibAiCpuSTest TearDownTestCase \n");
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
            static cce::AIKernelsLibBase *aiKernelsLibAiCpu_;
            std::string kernelSo_ = {"libTest.so"};
            std::string kernelName_ = {"TestFun"};
            HwtsCceKernel kernel_ = {0};
        };

        cce::AIKernelsLibBase *AIKernelsLibAiCpuSTest::aiKernelsLibAiCpu_ = nullptr;

        TEST_F(AIKernelsLibAiCpuSTest, CallKernelApi_param_NULL)
        {
            int32_t ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, nullptr);
            EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
        }

        TEST_F(AIKernelsLibAiCpuSTest, CallKernelApi_kernelName_NULL)
        {
            kernel_.kernelName = 0;
            int32_t ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
        }

        TEST_F(AIKernelsLibAiCpuSTest, CallKernelApi_kernelSo_NULL)
        {
            kernel_.kernelSo = 0;
            int32_t ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(AE_STATUS_BAD_PARAM, ret);
        }

        TEST_F(AIKernelsLibAiCpuSTest, CallKernelApi_strncpy_kernelName_failed)
        {
            MOCKER(strncpy_s)
                    .stubs()
                    .will(returnValue(1));
            int32_t ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
        }

        TEST_F(AIKernelsLibAiCpuSTest, CallKernelApi_strncpy_soName_failed)
        {
            MOCKER(strncpy_s)
                    .stubs()
                    .will(returnValue(0)).then(returnValue(1));
            int32_t ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(AE_STATUS_INNER_ERROR, ret);
        }

        TEST_F(AIKernelsLibAiCpuSTest, CallKernelApi_GetApi_failed)
        {
             MOCKER_CPP(&cce::MultiSoManager::GetApi,
                       aeStatus_t(cce::MultiSoManager::*)(aicpu::KernelType kernelType, const char *, const char *,
                                                           void **))
                .stubs()
                .will(returnValue(AE_STATUS_OPEN_SO_FAILED));
            int32_t ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(AE_STATUS_OPEN_SO_FAILED, ret);
        }

        TEST_F(AIKernelsLibAiCpuSTest, CallKernelApi_CALL_kernel_failed)
        {
             MOCKER_CPP(&cce::MultiSoManager::GetApi,
                       aeStatus_t(cce::MultiSoManager::*)(aicpu::KernelType kernelType, const char *, const char *,
                                                           void **))
                .stubs()
                .will(invoke(GetErrorApiStub));
            int32_t ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_NE(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(AIKernelsLibAiCpuSTest, CallKernelApi_SUCCESS)
        {
             MOCKER_CPP(&cce::MultiSoManager::GetApi,
                       aeStatus_t(cce::MultiSoManager::*)(aicpu::KernelType kernelType, const char *, const char *,
                                                           void **))
                .stubs()
                .will(invoke(GetSuccessApiStub));
            int32_t ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(AE_STATUS_SUCCESS, ret);
        }

        TEST_F(AIKernelsLibAiCpuSTest, CallKernelApi_AICPU_END_OF_SEQUENCE)
        {
             MOCKER_CPP(&cce::MultiSoManager::GetApi,
                       aeStatus_t(cce::MultiSoManager::*)(aicpu::KernelType kernelType, const char *, const char *,
                                                           void **))
                .stubs()
                .will(invoke(GetAICPUEndOfSequenceErrorApiStub));
            int32_t ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(AE_STATUS_END_OF_SEQUENCE, ret);
        }

        TEST_F(AIKernelsLibAiCpuSTest, CallKernelApi_AICPU_TASK_WAIT)
        {
            MOCKER_CPP(&cce::MultiSoManager::GetApi,
                       aeStatus_t(cce::MultiSoManager::*)(aicpu::KernelType kernelType, const char *, const char *,
                                                           void **))
                .stubs()
                .will(invoke(GetAICPUTaskWaitErrorApiStub));
            int32_t ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(AE_STATUS_TASK_WAIT, ret);
        }

        TEST_F(AIKernelsLibAiCpuSTest, CallKernelApi_AICPU_SILENT_FAULT)
        {
            MOCKER_CPP(&cce::MultiSoManager::GetApi,
                       aeStatus_t(cce::MultiSoManager::*)(aicpu::KernelType kernelType, const char *, const char *,
                                                           void **))
                .stubs()
                .will(invoke(GetAICPUSilentFaultErrorApiStub));
            int32_t ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(AE_STATUS_SILENT_FAULT, ret);

            MOCKER(aicpu::IsCustAicpuSd).stubs().will(returnValue(true));
            ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(ret, 501U);
        }

        TEST_F(AIKernelsLibAiCpuSTest, CallKernelApi_AICPU_DETECT_FAULT)
        {
            MOCKER_CPP(&cce::MultiSoManager::GetApi,
                       aeStatus_t(cce::MultiSoManager::*)(aicpu::KernelType kernelType, const char *, const char *,
                                                           void **))
                .stubs()
                .will(invoke(GetAICPUDetectFaultErrorApiStub));
            int32_t ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(AE_STATUS_DETECT_FAULT, ret);

            MOCKER(aicpu::IsCustAicpuSd).stubs().will(returnValue(true));
            ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(ret, 502U);
        }

        TEST_F(AIKernelsLibAiCpuSTest, CallKernelApi_AICPU_DETECT_FAULT_NORAS)
        {
            MOCKER_CPP(&cce::MultiSoManager::GetApi,
                       aeStatus_t(cce::MultiSoManager::*)(aicpu::KernelType kernelType, const char *, const char *,
                                                           void **))
                .stubs()
                .will(invoke(GetAICPUDetectFaultNoRasErrorApiStub));
            int32_t ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(AE_STATUS_DETECT_FAULT_NORAS, ret);

            MOCKER(aicpu::IsCustAicpuSd).stubs().will(returnValue(true));
            ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(ret, 503U);
        }

        TEST_F(AIKernelsLibAiCpuSTest, CallKernelApi_AICPU_DETECT_LOW_BIT_FAULT)
        {
            MOCKER_CPP(&cce::MultiSoManager::GetApi,
                       aeStatus_t(cce::MultiSoManager::*)(aicpu::KernelType kernelType, const char *, const char *,
                                                           void **))
                .stubs()
                .will(invoke(GetAICPUDetectLowBitFaultErrorApiStub));
            int32_t ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(AE_STATUS_DETECT_LOW_BIT_FAULT, ret);

            MOCKER(aicpu::IsCustAicpuSd).stubs().will(returnValue(true));
            ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(ret, 504U);
        }

        TEST_F(AIKernelsLibAiCpuSTest, CallKernelApi_AICPU_DETECT_lOW_BIT_FAULT_NORAS)
        {
            MOCKER_CPP(&cce::MultiSoManager::GetApi,
                       aeStatus_t(cce::MultiSoManager::*)(aicpu::KernelType kernelType, const char *, const char *,
                                                           void **))
                .stubs()
                .will(invoke(GetAICPUDetectLowBitFaultNoRasErrorApiStub));
            int32_t ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(AE_STATUS_DETECT_LOW_BIT_FAULT_NORAS, ret);

            MOCKER(aicpu::IsCustAicpuSd).stubs().will(returnValue(true));
            ret = aiKernelsLibAiCpu_->CallKernelApi(aicpu::KERNEL_TYPE_AICPU, &kernel_);
            EXPECT_EQ(ret, 505U);
        }

        TEST_F(AIKernelsLibAiCpuSTest, ContextSet_SUCC_001)
        {
            string key = "test";
            string value = "test";
            SetUniqueVfId(0);
            SetCustAicpuSdFlag(false);
            aicpu::status_t ret = SetThreadLocalCtx(key, value);
            EXPECT_EQ(ret, 0);
            ret = GetThreadLocalCtx(key, value);
            EXPECT_EQ(ret, 0);
        }
    }
}
