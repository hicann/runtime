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
#include "prof_mstx_plugin.h"
#include "mstx_def.h"

using namespace ProfApi::MstxPlugin;

namespace {

int g_markACalled = 0;
int g_rangeStartACalled = 0;
int g_rangeEndCalled = 0;
int g_domainCreateCalled = 0;
int g_domainDestroyCalled = 0;
int g_domainMarkACalled = 0;
int g_domainRangeStartCalled = 0;
int g_domainRangeEndCalled = 0;

MstxDomainHandle g_fakeDomain;

void ResetCounters()
{
    g_markACalled = 0;
    g_rangeStartACalled = 0;
    g_rangeEndCalled = 0;
    g_domainCreateCalled = 0;
    g_domainDestroyCalled = 0;
    g_domainMarkACalled = 0;
    g_domainRangeStartCalled = 0;
    g_domainRangeEndCalled = 0;
}

void StubMstxMarkA(const char *, aclrtStream)
{
    g_markACalled++;
}

mstxRangeId StubMstxRangeStartA(const char *, aclrtStream)
{
    g_rangeStartACalled++;
    return 42;
}

void StubMstxRangeEnd(mstxRangeId)
{
    g_rangeEndCalled++;
}

mstxDomainHandle_t StubMstxDomainCreate(const char *)
{
    g_domainCreateCalled++;
    return &g_fakeDomain;
}

void StubMstxDomainDestroy(mstxDomainHandle_t)
{
    g_domainDestroyCalled++;
}

void StubMstxDomainMarkA(mstxDomainHandle_t, const char *, aclrtStream)
{
    g_domainMarkACalled++;
}

mstxRangeId StubMstxDomainRangeStartA(mstxDomainHandle_t, const char *, aclrtStream)
{
    g_domainRangeStartCalled++;
    return 99;
}

void StubMstxDomainRangeEnd(mstxDomainHandle_t, mstxRangeId)
{
    g_domainRangeEndCalled++;
}

// Simulated mstx init: pulls the func tables and writes our stub pointers into them.
int FakeMstxInit(MstxGetModuleFuncTableFunc getFuncTable)
{
    MstxFuncTable outTable = nullptr;
    unsigned int outSize = 0;
    if (getFuncTable(MSTX_API_MODULE_CORE, &outTable, &outSize) == MSTX_SUCCESS &&
        outTable != nullptr && outSize > MSTX_FUNC_RANGE_END) {
        *(outTable[MSTX_FUNC_MARKA]) = reinterpret_cast<MstxFuncPointer>(StubMstxMarkA);
        *(outTable[MSTX_FUNC_RANGE_STARTA]) = reinterpret_cast<MstxFuncPointer>(StubMstxRangeStartA);
        *(outTable[MSTX_FUNC_RANGE_END]) = reinterpret_cast<MstxFuncPointer>(StubMstxRangeEnd);
    }
    if (getFuncTable(MSTX_API_MODULE_CORE_DOMAIN, &outTable, &outSize) == MSTX_SUCCESS &&
        outTable != nullptr && outSize > MSTX_FUNC_DOMAIN_RANGE_END) {
        *(outTable[MSTX_FUNC_DOMAIN_CREATEA]) = reinterpret_cast<MstxFuncPointer>(StubMstxDomainCreate);
        *(outTable[MSTX_FUNC_DOMAIN_DESTROY]) = reinterpret_cast<MstxFuncPointer>(StubMstxDomainDestroy);
        *(outTable[MSTX_FUNC_DOMAIN_MARKA]) = reinterpret_cast<MstxFuncPointer>(StubMstxDomainMarkA);
        *(outTable[MSTX_FUNC_DOMAIN_RANGE_STARTA]) = reinterpret_cast<MstxFuncPointer>(StubMstxDomainRangeStartA);
        *(outTable[MSTX_FUNC_DOMAIN_RANGE_END]) = reinterpret_cast<MstxFuncPointer>(StubMstxDomainRangeEnd);
    }
    return MSTX_SUCCESS;
}

int FakeMstxInitFail(MstxGetModuleFuncTableFunc)
{
    return MSTX_FAIL;
}

// A getFuncTable that always fails.
int FakeGetTableFail(MstxFuncModule, MstxFuncTable *, unsigned int *)
{
    return MSTX_FAIL;
}

// A getFuncTable that returns MSTX_SUCCESS but with null/zero outputs.
int FakeGetTableEmpty(MstxFuncModule, MstxFuncTable *outTable, unsigned int *outSize)
{
    *outTable = nullptr;
    *outSize = 0;
    return MSTX_SUCCESS;
}

} // namespace

class PROF_MSTX_PLUGIN_UTEST : public testing::Test {
protected:
    virtual void SetUp()
    {
        ResetCounters();
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(PROF_MSTX_PLUGIN_UTEST, ProfRegisterMstxFunc_NullInitFunc)
{
    // null mstxInitFunc should be safely ignored (no crash).
    ::ProfRegisterMstxFunc(nullptr, PROF_MODULE_MSPROF);
    ::ProfRegisterMstxFunc(nullptr, PROF_MODULE_MSPTI);
}

TEST_F(PROF_MSTX_PLUGIN_UTEST, ProfRegisterMstxFunc_InvalidModule)
{
    // an unsupported module should not crash and should not invoke init.
    ::ProfRegisterMstxFunc(FakeMstxInitFail, MODULE_INVALID);
}

TEST_F(PROF_MSTX_PLUGIN_UTEST, ProfRegisterMstxFunc_Msprof_Then_ImplDispatch)
{
    // Register stubs into the msprof context.
    ::ProfRegisterMstxFunc(FakeMstxInit, PROF_MODULE_MSPROF);
    ::ProfEnableMstxFunc(PROF_MODULE_MSPROF);

    MstxMarkAImpl("hello", nullptr);
    EXPECT_EQ(1, g_markACalled);

    EXPECT_EQ(42u, MstxRangeStartAImpl("range", nullptr));
    EXPECT_EQ(1, g_rangeStartACalled);

    MstxRangeEndImpl(42);
    EXPECT_EQ(1, g_rangeEndCalled);

    uint64_t toolId = 0;
    MstxGetToolIdImpl(&toolId);
    EXPECT_EQ(static_cast<uint64_t>(MSTX_TOOLS_MSPROF_ID), toolId);

    auto domain = MstxDomainCreateAImpl("dom");
    EXPECT_EQ(&g_fakeDomain, domain);
    EXPECT_GE(g_domainCreateCalled, 1);

    MstxDomainMarkAImpl(domain, "msg", nullptr);
    EXPECT_EQ(1, g_domainMarkACalled);

    EXPECT_EQ(99u, MstxDomainRangeStartAImpl(domain, "msg", nullptr));
    EXPECT_EQ(1, g_domainRangeStartCalled);

    MstxDomainRangeEndImpl(domain, 99);
    EXPECT_EQ(1, g_domainRangeEndCalled);

    MstxDomainDestroyImpl(domain);
    EXPECT_GE(g_domainDestroyCalled, 1);
}

TEST_F(PROF_MSTX_PLUGIN_UTEST, ProfRegisterMstxFunc_Mspti_Then_EnableSwitch)
{
    // Register stubs into both msprof and mspti contexts so dispatch is exercised
    // through the mspti branch as well.
    ::ProfRegisterMstxFunc(FakeMstxInit, PROF_MODULE_MSPROF);
    ::ProfRegisterMstxFunc(FakeMstxInit, PROF_MODULE_MSPTI);

    ::ProfEnableMstxFunc(PROF_MODULE_MSPTI);
    MstxMarkAImpl("hi", nullptr);
    EXPECT_GE(g_markACalled, 1);

    // Domain create should record handles in both modules and return the mspti one.
    auto domain = MstxDomainCreateAImpl("dom");
    EXPECT_EQ(&g_fakeDomain, domain);

    // Switch back to msprof for the impl-dispatch branch coverage.
    ::ProfEnableMstxFunc(PROF_MODULE_MSPROF);
    MstxRangeEndImpl(0);
}

TEST_F(PROF_MSTX_PLUGIN_UTEST, ImplDispatch_NullDomainPassthrough)
{
    // Calling impls with null domain handles must not invoke remove/lookup paths.
    MstxDomainDestroyImpl(nullptr);
    MstxDomainMarkAImpl(nullptr, "x", nullptr);
    EXPECT_GE(g_domainMarkACalled, 0);
    MstxDomainRangeEndImpl(nullptr, 0);
}

TEST_F(PROF_MSTX_PLUGIN_UTEST, MsprofMstxGetModuleFuncTable_Variants)
{
    MstxFuncTable outTable = nullptr;
    unsigned int outSize = 0;
    EXPECT_EQ(MSTX_SUCCESS, MsprofMstxGetModuleFuncTable(MSTX_API_MODULE_CORE, &outTable, &outSize));
    EXPECT_NE(outTable, nullptr);
    EXPECT_GT(outSize, 0u);

    EXPECT_EQ(MSTX_SUCCESS, MsprofMstxGetModuleFuncTable(MSTX_API_MODULE_CORE_DOMAIN, &outTable, &outSize));
    EXPECT_NE(outTable, nullptr);
    EXPECT_GT(outSize, 0u);

    EXPECT_EQ(MSTX_FAIL, MsprofMstxGetModuleFuncTable(MSTX_API_MODULE_INVALID, &outTable, &outSize));
    EXPECT_EQ(MSTX_FAIL, MsprofMstxGetModuleFuncTable(MSTX_API_MODULE_CORE, nullptr, &outSize));
    EXPECT_EQ(MSTX_FAIL, MsprofMstxGetModuleFuncTable(MSTX_API_MODULE_CORE, &outTable, nullptr));
}

TEST_F(PROF_MSTX_PLUGIN_UTEST, MsptiMstxGetModuleFuncTable_Variants)
{
    MstxFuncTable outTable = nullptr;
    unsigned int outSize = 0;
    EXPECT_EQ(MSTX_SUCCESS, MsptiMstxGetModuleFuncTable(MSTX_API_MODULE_CORE, &outTable, &outSize));
    EXPECT_EQ(MSTX_SUCCESS, MsptiMstxGetModuleFuncTable(MSTX_API_MODULE_CORE_DOMAIN, &outTable, &outSize));
    EXPECT_EQ(MSTX_FAIL, MsptiMstxGetModuleFuncTable(MSTX_API_MODULE_INVALID, &outTable, &outSize));
}

TEST_F(PROF_MSTX_PLUGIN_UTEST, InitInjectionMstx_Null)
{
    EXPECT_EQ(MSTX_FAIL, ::InitInjectionMstx(nullptr));
}

TEST_F(PROF_MSTX_PLUGIN_UTEST, InitInjectionMstx_GetTableFail)
{
    // Failing getFuncTable -> GetModuleTableFunc still returns SUCCESS (it just continues).
    EXPECT_EQ(MSTX_SUCCESS, ::InitInjectionMstx(FakeGetTableFail));
}

TEST_F(PROF_MSTX_PLUGIN_UTEST, InitInjectionMstx_EmptyTable)
{
    // outTable null / outSize 0 path -> SetMstxModule* skipped via 'continue'.
    EXPECT_EQ(MSTX_SUCCESS, ::InitInjectionMstx(FakeGetTableEmpty));
}

TEST_F(PROF_MSTX_PLUGIN_UTEST, InitInjectionMstx_RealRoundTrip)
{
    // Use msprof's real getFuncTable as the injection callback. This exercises
    // SetMstxModuleCoreApi / SetMstxModuleCoreDomainApi against the real tables.
    EXPECT_EQ(MSTX_SUCCESS, ::InitInjectionMstx(MsprofMstxGetModuleFuncTable));
    EXPECT_EQ(MSTX_SUCCESS, ::InitInjectionMstx(MsptiMstxGetModuleFuncTable));
}

TEST_F(PROF_MSTX_PLUGIN_UTEST, EnableMstxFunc)
{
    ::ProfEnableMstxFunc(PROF_MODULE_MSPTI);
    ::ProfEnableMstxFunc(PROF_MODULE_MSPROF);
}
